Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A918BD59F6C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 20:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8mON-0003R3-71; Wed, 06 Nov 2024 15:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t8mOK-0003Qa-Hz
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 15:12:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t8mOH-0008TW-SK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 15:12:36 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXaW5001589;
 Wed, 6 Nov 2024 20:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=GGvcpwHKHIZBaEB121M0IiNjxCufJrYlJZZV/vPGcls=; b=
 muQZPhvf+y1stuU2pCnxJZuSTmd/K/7IBrkuPGWjWvGi3UXTiDPri3v8VYLh2N/K
 CLqpPibXMyOg0evbJI+CjA7lhsNtrSpOwpAlBUX++CaimKBfC2fciHoA7p33fqGi
 ROQau5omw3jOkuLc1VW4Ru1xFMnKUUr20ljZooZ60IPDxBZrnk+O/a4edMVqW4yY
 50YoykBn9AtJamwid7+b0mN7K3cC0D+akle7IDzfmrF6FRjGdsSnRTMdnK1OYdci
 TTY0RKB/R7ItwWoCAKj9Z85HC5UUZwJTGOiAMp27HPu9SOZ+leMznqZf2pKxaZGb
 YsyXE+bUBMgF8HcgmxKivA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt8ysj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Nov 2024 20:12:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A6JIFAn036832; Wed, 6 Nov 2024 20:12:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nah93e38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Nov 2024 20:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTXQmLzkmIIyodDcWj+/lZXi8DACDdiWX3Bw63b0EmL+ZOtoK85xnTETH0EZoLoZFA5ePW0k2zjjQySvzkMmtkAtJVE7cVilixllOAFsYMt6azptSm3wLtja9cKvYG/TCL0MhMfZZGDkHrWLHojx+peimEXQgglGh201IsVcFw1fmboSYDrj6/SLB+nzUNWV5smIKT/y/27KP8A9GnEyVD2LWG7L2OusDSD+mlNJhr2ULzMjLP8LoiA6RnGynYF3d/oT7ZaItuqapwHZTshz0NTnoCFGDX33iVxJnzIpiNUpuVj5e5qpbQT6zDapGlf7XeTW2pbcb2RJeQLJwwytCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGvcpwHKHIZBaEB121M0IiNjxCufJrYlJZZV/vPGcls=;
 b=kpZWMSoKb4EA3zCYf3MrT/x6h1odrOQ5cWBcAEbIDk+utLg+tTROkkJ6+o5LMJDtkn8a6VmGmZ82cxWlNEYVkhG2X/YNUvD1v/TYQ+aooX1b1j3aXvvRXmJIETQLQL5vEJ8Oep3Ik+PxQfrb4geqkSflRLuLvT00z3eAR3YL7uImgiDLwi6uz+AaNxxLDO2+g3qU/VUF6ki+K4rn5ls/lKcUryKt5qHczgvxTITUtbaNEYqPDOrEw4YXL/nWUq7kMwasPMgbFjT5uow3BLyrS9ySL1WXqNIsz0vmTEfLgzVsp5ljtMqUnILnJBde9leQmCPVKBuR63p8FTKQlW5MqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGvcpwHKHIZBaEB121M0IiNjxCufJrYlJZZV/vPGcls=;
 b=D3rA0U34CnXtkACGu4DsKtokrduTbFGqcL4KPvVdFnxw395ufvoyJ6ZIw1Gir0KPm1Xy94EKFERUAuFQ4B//akX1buq5VfMrENcm/ig2ojQxu/D2gS0ElGXDnLp5Wr/cVtOOM9vSZ+gV2l2+tXbHc4rFkea2VDz080VMME3Wess=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB5597.namprd10.prod.outlook.com (2603:10b6:a03:3d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 20:12:22 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 20:12:22 +0000
Message-ID: <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
Date: Wed, 6 Nov 2024 15:12:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb70122-d30f-4f1c-ab82-08dcfe9f52f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3kyZG1XdVFzRE9uajdlTVdxWFZBM0txeHhCdS9uRk5tM3A1ZGhocjhsKzlH?=
 =?utf-8?B?Ymk5K245TnVkT0RXbWcrNVNsT1BLV1BkTTlTdDM5SXlpVFpHZDh0RGdoOHRY?=
 =?utf-8?B?YlpBR2xUNVU1SkRuSHp0Z1crQUlnc1k0ZGVQbmZuL0haYWZ4dHdKbEt5Y2NB?=
 =?utf-8?B?K3ptemg3ZVRjb0lLdy9YaEhYczFZaStocUhCTmJZdTQ4VVJsN1ZRVTdWZ2w0?=
 =?utf-8?B?eXdtcVR0UmR5R0JkZjY2MFhzanJabG0rWFJsUDJKRzd6L1hnbGxmVG1FbTNk?=
 =?utf-8?B?Mm13YytmSDZpVWwvQ3p0WnBacFdRcXFJS0tVTVlPb1l6VnNKbUhMSFo5VGF3?=
 =?utf-8?B?Wk5vQ0kyMUpZdzVZWElVR0dBTUlZNDVraWhVQVN2MUJ2NGVCUlJNUGJGT3Bw?=
 =?utf-8?B?ZTRIN3krbllWQVlHZTkrQVNKZ0RQRWdGdjJWb01YclY5cy9xWDdocGM1dWN6?=
 =?utf-8?B?M25KZWJQeXZ6YnBlK3puSVZ4ZXpZL0RIZkN4NUNEUUp6d0tmd2FlY09qZE9z?=
 =?utf-8?B?QVJ1QVljdG5OLzB4dUNaZTd6RUp1TmFSOWJZY05CUGxybldXdjRqdTE5bFE2?=
 =?utf-8?B?NTBsQjRXV1NxSDA3bTNiTTlLZlUvNGI1eUxjYy9UYktEajZPWEo2T1NUSnox?=
 =?utf-8?B?NWtJV3BzaXo2QVRWdkNNRm5xTk9zMVBEUm1WYXJMOVUzVVJORWtXNzBvbXU3?=
 =?utf-8?B?NjE4aUdaM2srQktVUVZiOTYySkxSemdMYTVNaE4yeUwwYm1lOXJRM0cydnFB?=
 =?utf-8?B?REFqS0tRL1pwWXRNOWNsNTJZTHlJbm5jYTY3aTBhTm9odEgrV29PNG9aM0Ix?=
 =?utf-8?B?bWJNZUxtUWJpakRqalAyVkI5MEl2dEpOckhyaFgzMGhVbUhOaU9pd3JXTFFL?=
 =?utf-8?B?RklTT3ZUTzl1cjhGa2x6TzZraVRSWnMzcVJuYkxtaXJsRVRXTXE0VlEycVI0?=
 =?utf-8?B?UEhEdlZLTE0vWWwvNDZkRmg1K294TVZkc1crbTJMN0NVbnhEUmpuZGdVUEM3?=
 =?utf-8?B?c2NMcFFETkZwZjJRZXBjSFJqdTNZYVhVdzJHRUx1S2JyZWQ5QUlpaktxQzd6?=
 =?utf-8?B?MWtKbGpIdkVjeWxrMVcxNjZOSGtKYXZvSDlQTUI3THVMN2xrTWN4a1NlcWhK?=
 =?utf-8?B?YkpiTEJ2ZmttN2V1NzRaL3I4NmlZYkhEYW8yZDA5T3BqdzdlKzY2R0lrZk1x?=
 =?utf-8?B?OUFpN29aWURCTXYyUVZ1ZjAyNmF3Wm5BcWlwZ0l0bFloY1pzcGRrQkFjWG5M?=
 =?utf-8?B?aTdPbDRZOCs4aTY2NS96MEkrT250Qy8rbU0rbnZlaUwyclczZm5wcXdkTmJq?=
 =?utf-8?B?NCsxNlI3VkZmdjQ4V1QwdGhFT2FXQjRRUTlGV3BCTUx3TVRJeXBxRU5lejBq?=
 =?utf-8?B?Uy91YmdaSTVzdmtiZ1RPeXVyd2N5cXpEeXRyK3B6UGZjaDgzMzRZdVdUei9z?=
 =?utf-8?B?cEdKM3NuU1gzUzdXeVBDaFVSWE9SQWpaZGFITVE1bkRqMUZITlU2dm4zS0c1?=
 =?utf-8?B?UmhrbFI1Y09JQmxsZ1BwZVFSN1o2aWRoUjRFNmJ3cFdpUHdTMkJmc1RCanJS?=
 =?utf-8?B?dU9JMWsyTFM5RXRYSjkwSWNoUGQ1T1JuZEVMZ3lmY1pkanpSQjU5L21tZmxH?=
 =?utf-8?B?NjgvVndGS0UyMmhYVUc2M3JzdTkzK3I4dFpPWUthVDFtNEg5M01JNGRZRW84?=
 =?utf-8?B?alNUbFhLVXhpc2xlY2liQjdRU0dpV3VlcnZBQThlMlZoZ1Y1VklDelZGMXRQ?=
 =?utf-8?Q?6fdZ0lHxKS6TM8MopWOjBrO9ytPaaS7Z1+lo2xW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2tsOExZa1BJd3o1V1l0YXBFU3pwWXV2UTFQdFlLT3VmL1FPNkgxdms4ZlZj?=
 =?utf-8?B?M05xcDdNR01ZRStWMkZ6a1FzZFZRUFNZMmJiZWd6ZURWaXJPNnhOUW1HUW8v?=
 =?utf-8?B?NlRneU1abS9XSFU0aXUwbzhpSm1md2tPRDZ5N0FOUVRjUklYQjZ6T1FRUzMw?=
 =?utf-8?B?akZyQlE0MlJWaDJWSzZWdU5tZ0drWGFuclptMWM1OHUraXJIY2FvL044anpB?=
 =?utf-8?B?cUxIb2FSbmx4Q2NtNU5vOGZzT3BDNDRnbFZRQi9CNGtqMHBaRlZYOVp0bkZI?=
 =?utf-8?B?RlNkWmU2KzVVQTlzYVpySUd5R1IzaFNGbDNuZm10blJVRURpR2RqcHFxVllr?=
 =?utf-8?B?Nkw3cXdZQzJId2gzbnJLWEhKc1NodVp3aEQyMWhXa0FKV1F1NUxRUTFVbVB4?=
 =?utf-8?B?MlhsZzNaSVpMeFJ2bXg4QmpDR1ltYUE0NkgwTlN0Qk9LQVNnV3ViSU5ObTkv?=
 =?utf-8?B?ZzJqaVl0bkFieGNxRzRzWUVPTXNNK2NxOUFuZUROemMrcUFnU3drSitIQ0dv?=
 =?utf-8?B?SytXQ0lUNHBsRzRNVi9EWld5T0d1djd5dklEYmx2djQ4T3l5cWpmM0cyd3pj?=
 =?utf-8?B?VS85TklpcDdCaFFCOUx4azY4RWl1Lyt4WGg4VWtBaGo0cTA2VXh3T0FEcVYr?=
 =?utf-8?B?YlZHcDVpaCtJdlk3elAvYThWVzFubEFzQjc2OHFhMExvczROZjhCSDlWaXlx?=
 =?utf-8?B?bFFyWnJhWldjN0xuZkpkS3BHNEQrT0UxQkVQWlBESmtOV3Rld1dUaWlQdU9L?=
 =?utf-8?B?NFg0OVBFa2U2R0dwSXdTV3l3RzhIZlVRVzR0SUs0N2NMZWhmU2MzSFFuT0hv?=
 =?utf-8?B?eENCSmE2TjBaRjJvMkh1bWhoQ2d0UlpKc2FqUFVXNFB3Zlg5VlRpM2Y3ekp2?=
 =?utf-8?B?WkpPSW1mSEExOEpUaVQ2MlZ1Skx6MnhvM3p0L3F6WTl3Y3NvcnZTRFR0bzNF?=
 =?utf-8?B?cmhUWFhNdXdWenA2VFczSWNIckQ3TjQvK29Na01qbVdqSTZPYXFxcy9hdVZL?=
 =?utf-8?B?bWlpV2FON1hLNW16V1NHa2xiUlNkMU9xUXpJZUVUN0VUZ3NBalhZYnAyODll?=
 =?utf-8?B?SzBjUEVRZkR3RmFGa2ZFbmxWN0YzN3FUOForN2dJd05vQ1NzWUVUNWdibi8y?=
 =?utf-8?B?Sm90QWZFSE5pSTQvenl1MzArcDRyQ0orRW04dTIwNlpHaHZzSDlOZnBJNGFT?=
 =?utf-8?B?Y3NvNjArR2tvajdEWUxIUHB4dGZYZXRNVXduNWRHSmErQ3NCb1ZSM3ZOL2Jo?=
 =?utf-8?B?MXN1WFdXblUyY0dWZzFPK3hJZnFMNFlSVHBnUXJhMG81MG9OTVZuTDdZb2Fp?=
 =?utf-8?B?MlRnR1FsR2E1N1ZSTk1BbldKNkE1TUlUbFltcVhabm5hVjJCUUZMc3NTYkFF?=
 =?utf-8?B?SlQzQ0ZFaFV0S29YOEFEemdTZTFzOTNrSE4zWUZKM0ZQaTcwb2l1S1ZPRXRo?=
 =?utf-8?B?cWhuWU9oVHJVYVlVSElxNmI5aVNLZ1BENnl6Mnd2YUNYNGtHWGtqK2VhOHNy?=
 =?utf-8?B?MkNFK0FySFBta3VRbXgrMHZSRlVGME4rZzBNRUpKUWUydXIwMGtHU0didGhi?=
 =?utf-8?B?MUpiL2c4aHllSG52UmJmQk5CcDRvR2lORUh5a2xBWDB1RllMMitPc0JucHNC?=
 =?utf-8?B?eXJoSkhOSHRTWXcwQWxRTDVkZW11WkZyQUtFdjNrSDJjcXRGQm5iTG1Tb0Iz?=
 =?utf-8?B?VnNjc28xYlhrTmsvZ3hjbU14cHFTNS9wM0N2RnVnYXRzTDExY1BJc0tiWE5D?=
 =?utf-8?B?SEFlNXovR1lWcHRwMGRRbnZ4bXZIa3AvWGVRQ2d4aGtjcHE4N0NhS3JoOGF4?=
 =?utf-8?B?SlZHZXBLUjNSTWVhWG90bGhudkNwRlpnaEJBZlE5Rks4eXZXRmtWNElTMjZX?=
 =?utf-8?B?T3ltTzFKQWx4MzJ3UTFCemtSbkQ0bzR4bkErendoZUJWM2IxdXBqM0xoOUE1?=
 =?utf-8?B?KzBFTkhBdFkyTlJjYjdtWXJEbXpod1NUaENHZk85bVVHMGtua1lxMElmRy9W?=
 =?utf-8?B?WkJhSm9DbndZbTVKZThqT2lObW5ZT0FKb0NBRGtDb0UzUWYrTTJUSW5aaHpo?=
 =?utf-8?B?QWdVVENFWE9kdWk4dTRxdnFKd3JPQVV1MnhrVVBWRWQvTENYYjJIeVlOTW95?=
 =?utf-8?B?T0o0c3BFQjUzUi9YRzJabmhtcFNiaFpNQ1dpOUw0V2M1OVJPOTVQUXhVa3pw?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XAJiXQRNJYVo5HGTVb4/nxSZdl2hgIBGFNt01QScXYis9Tzkrdf4m19/zbyl/t9uTzmnUE32KrEIw9TUIK2j44ppecgalAsn9mjRD+pgsZgqv+Dvxm2OU9xAwF7MnoUSBW33zVtpB9EU6tiV9W+RP0Gb9EmjsfxWx34HV2j7iZ9u9+hzriu5qBArVgMeM3jO/E65ixsllWr+RRQaY8CqHmVAr7cNxAtXcYbi5NuvR9JkRWXFXypvjN2LkAIrfXSwblwMCUavlNrKdDtKkWeE2ds9eSlVDfKAlhG13VDMBAR/r4AWfB69Pia0jpOKA+V6iAhcxqHrUmgnDkRuKndJ09Eva+0BpX+X8egwmZw6OgQEJJL5uPNMScj6M9CLLstECjcK2HqCc3PgEORlwPVF7g6gkTD1wdh5MTkb7592pmWiLMiDq+G+aK61JzVargnUxscae2yGnfqKwkg4MrqYV/5as3x/k5yWKM3+NruUB/PItM5kjWBo2nXenxkScFCJwOAtjmv/khNLMN5U0HAHeIfv8+ncHXS36GdEmJ4mXZyuutwhjgyVydY6svjz7qsAPzBEs9zRWrIMZSG+RRaPhcScjXZvdOGnEYpiuuPyToY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb70122-d30f-4f1c-ab82-08dcfe9f52f9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:12:22.7554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXIyZwaoHstKZ3iEweWyLmzHpK7MMLR93mplWhY8YYr2AGgoulMi4TSUAQCfPGjZd81Ri0n90wbJUX8OEhx0rmopQ4spD157rEeWfd6v2U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_13,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060154
X-Proofpoint-GUID: 3c2ps_zQmhOsPVFiiwTZjbatVtHFdeB6
X-Proofpoint-ORIG-GUID: 3c2ps_zQmhOsPVFiiwTZjbatVtHFdeB6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/4/2024 4:36 PM, David Hildenbrand wrote:
> On 04.11.24 21:56, Steven Sistare wrote:
>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>
>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>
>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>> similar to backends/hostmem-shm.c.
>>>>>>
>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>> details. See below.
>>>>>
>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>
>>>> Unless there is reason to use memfd we should start with the more
>>>> generic POSIX variant that is available even on systems without memfd.
>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>
>>>> I can help with the rework, and send it out separately, so you can focus
>>>> on the "machine toggle" as part of this series.
>>>>
>>>> Of course, if we find out we need the memfd internally instead under
>>>> Linux for whatever reason later, we can use that instead.
>>>>
>>>> But IIUC, the main selling point for memfd are additional features
>>>> (hugetlb, memory sealing) that you aren't even using.
>>>
>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>
>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>> To do so using shm_open requires configuration on the mount.  One step harder to use.
> 
> Yes.
> 
>>
>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>> if memory-backend-ram has hogged all the memory.
>>
>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>
>> Yes, and if that is a good idea, then the same should be done for internal RAM
>> -- memfd if available and fallback to shm_open.
> 
> Yes.
> 
>>
>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>
>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>
>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>
>>> Thoughts?
>>
>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>> of options and words to describe them.
> 
> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".

Hi David and Peter,

I have implemented and tested the following, for both qemu_memfd_create
and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
for simplicity.

Any comments before I submit a complete patch?

----
qemu-options.hx:
     ``aux-ram-share=on|off``
         Allocate auxiliary guest RAM as an anonymous file that is
         shareable with an external process.  This option applies to
         memory allocated as a side effect of creating various devices.
         It does not apply to memory-backend-objects, whether explicitly
         specified on the command line, or implicitly created by the -m
         command line option.

         Some migration modes require aux-ram-share=on.

qapi/migration.json:
     @cpr-transfer:
          ...
          Memory-backend objects must have the share=on attribute, but
          memory-backend-epc is not supported.  The VM must be started
          with the '-machine aux-ram-share=on' option.

Define RAM_PRIVATE

Define qemu_shm_alloc(), from David's tmp patch

ram_backend_memory_alloc()
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     memory_region_init_ram_flags_nomigrate(ram_flags)

qemu_ram_alloc_internal()
     ...
     if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
         new_block->flags |= RAM_SHARED;

     if (!host && (new_block->flags & RAM_SHARED)) {
         qemu_ram_alloc_shared(new_block);
     } else
         new_block->fd = -1;
         new_block->host = host;
     }
     ram_block_add(new_block);

qemu_ram_alloc_shared()
     if qemu_memfd_check()
         new_block->fd = qemu_memfd_create()
     else
         new_block->fd = qemu_shm_alloc()
     new_block->host = file_ram_alloc(new_block->fd)
----

- Steve


