Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14010CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1U2m-0003OK-19; Wed, 24 Sep 2025 14:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v1U2d-0003KV-KS
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:16:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v1U2M-0003Bs-R6
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:16:35 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OHtvDi022725;
 Wed, 24 Sep 2025 18:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=aCMSY5gAyJnoNOQC10UzRvIgR8mLjXz3ZYsTnYNMbZE=; b=
 bndJqhMA1hMJ0YgFgBfhi10J4fAv1oRQdDZ0Y/SRMG9TbvZhrmXu3jvZTic3VT0W
 nw5awpFoH7J7xaZyMAThh2A4Fhru90LcbNzL+D8KgYmlykcNRwniu0h6vqcc9tHs
 ksH9EwEFV5Sg3GfVTCSroRQmxgElFP/C3BGvJJiVef8SZIV1OvHKVszLm3dZ6l13
 wVmaUV68a3fi2AZXfm9SE8gmyD11eBl6p/6LhiF8dWWbE2gSBMBV87u/Bm4l3VUa
 1zuy0xJIyOHdmAGS4GwLKqL7Hy849g8O0nsW92jmNA4vznfHX4dhrK0CBw3UwLkm
 Sp4SiuuADWDsHvkRjUWsFw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad8f08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 18:16:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58OH6J7F035552; Wed, 24 Sep 2025 18:16:13 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 499jqaa235-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 18:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVAe0fcOlsLyh2lQJM094jCL/IULiQRKkxIXv6EL/J9iaMV5LtqfQxX8K300wHL0scCQEW4HWVtP+1EzWDNK3MzxBMYarcnnn5nddjjTgpHIfCny48Pu32XGkrcpibE0We+w2e49ubXc2nIlUphy+iZlszcYrPMJY0z0yERMEL+FWCOovMKx/FHQWCsopBr/Z+aGbdhKx2dM51dBU0d4n3AYAP02kz3FJ6h4pLz5JgtFEGGPwQMgVE6TPLgDGXaOaiVQqgh0w8AW3MfCMZtmVhshR/D6iegv0W+4M8Q68dNZ+G8EJlJhOEl2x3dMEBiP/dBy1n9aXJ3X3kDbXC5L4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCMSY5gAyJnoNOQC10UzRvIgR8mLjXz3ZYsTnYNMbZE=;
 b=OIbi8KtGqTuSrrglHTuQXgLUZWkLaF+cNqA8udvWfdu4VbcZ2PAp6lWCicn9Wr5SglvI5XXW8NUeUV6coJusXjW9s5RRmBfOJuiCgvHCjipZ9Uyvlty37BBfJynqruyJW4YtlDP4X0Sfnza+VTUHFOsfwQ6V9ZLjg3dzK221fiUHCqRVPSA0+cqmrl70Di/cIDDHE5/o30zIy8oHp/oc9U5GK520hsRxc687yb2sMd6+ZuENYjnW4w3qWrVq69jk4deGf6ZcEFHjyxwFh1S1vnbDn/b4nKW/4NnpWIxGo4e5qXXAUmvAVUSLaErKoEyM1FcmGFwECiaIhElQJhUzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCMSY5gAyJnoNOQC10UzRvIgR8mLjXz3ZYsTnYNMbZE=;
 b=FmOiXlVvBFnG7o+RdgMntO1biaVRMRVOdQlUjWzt6myaCyshqlaoZP1INWB8OQ2YcLZaphbYWyJPqgNYIEePpAvX7OJx0GQqEK8YJnmICnWAMKSmWv7SttYs7/R7QFxcLS1k2zqdc3CxuYtuRoLdr+KAeB1kqnET8aWdzM5g90I=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4453.namprd10.prod.outlook.com (2603:10b6:510:37::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:16:11 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 18:16:11 +0000
Message-ID: <e8766c16-5f8e-4b3d-8808-42158d28b549@oracle.com>
Date: Wed, 24 Sep 2025 14:16:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/8] migration: cpr-exec save and load
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-6-git-send-email-steven.sistare@oracle.com>
 <15399e70-fa4b-4792-9881-9dec59f0c832@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <15399e70-fa4b-4792-9881-9dec59f0c832@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:510:4::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 53258adb-04cb-44b9-09e4-08ddfb967098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWx1UHY2WmZlNzVOQ3hOSXJlQVp2YWd5dmxVdGJpT0sxY0l3anQ1NDBMY0RF?=
 =?utf-8?B?WE1XTUtjUGNXOHMyUVovZnV5a3pHSnZLKzJScmgxSjFCbnpKc2IxN0RKT2N2?=
 =?utf-8?B?TEgwUWRKb0wwdTc1K1k0TmxadUxUTmxCTmVNK0NLZ3lkWEh6VVZ0a3NmbGoy?=
 =?utf-8?B?bUNWcUVlWnF4eTFMOUw1eDJITUU5QUhVZjRvKy92S21VRndtTGdXdGZmWEV6?=
 =?utf-8?B?UDRmRm5wRmhYQ0MyWEMyamErcFZKSWdnZ1FKRGw0dWFrZlVXZEt1OXBqREVk?=
 =?utf-8?B?VVd5b1U3blUzdUU0ZXV1TTFmYWhsK0xVdjdvODZVdVp1ZXNNeXBLWUlRenRL?=
 =?utf-8?B?RDlGRmhPbGpqN2doOGJ2Ymx4RzdXdWt3aUpuTDBrTEdSU054K0daeXFiaVNR?=
 =?utf-8?B?U0hScXV3UVE0NUl3S3pKUDJ6eFh6cFExVWtNYlIzVW5OekRHL3hzcHUvZE1Q?=
 =?utf-8?B?Wm9jR202R0NjWjNEZ0g0d29BeVM5SkI3dEVaWnpPN2ZFdncvNytkTXpodkdT?=
 =?utf-8?B?YlMxQ3EwYjRUblZScXJlcysvMW9GQzJPOUFuM0ZGcFpaV1Boa3VJWmJpL3RN?=
 =?utf-8?B?Rk9XWE1aMnl6VFY4NFZkZjFYdFVBZUxYVnM2cDdDWFg2MDdPQ29nL0xSY1FU?=
 =?utf-8?B?YWNuK2ZNUzdkTitaVXFoLzRya2NCMzNhMUNsRTcvcmg3WHJISUNacXJhcTRP?=
 =?utf-8?B?eDBKd0JsSUF3RWtCQWdVaVRzZHptaHhwR2taRkIxYXdHLzIvcmgzbTN4TXBh?=
 =?utf-8?B?ckdHZWVtSjVJYitaOXd6cUJZRTJ2VFpaUDFnckE3RFBVbE9yUVhWdC9DTGtZ?=
 =?utf-8?B?M2Q0dzhheFErb0MyeVcwOUF4WUFhMm9IUUl6Y29xVnVHeTZZQm5iZzhlNVR3?=
 =?utf-8?B?ZUtNcW9vYUxlRHFXc1lhajgrUDNiV0c2VU5zNzhiZlhYclVrSksxZkt2bVlM?=
 =?utf-8?B?dDZ6U2krbkNLZmtza0J6bjY3eUMvTnhyUDJtZ3JwN0dqbk5vd3AzZGVyeTF6?=
 =?utf-8?B?TG9MTUlCZ3QwMHpqZ3laTW5MWitDQlZyQmRLUWUyZVdTY04xREU1blJFZm9t?=
 =?utf-8?B?aXNaa3lVNUQ1KzgremJvOGt3T1B3K3Y4SHpwZmorNVRBVHk5Tm5UOWZCTXNO?=
 =?utf-8?B?bEM1RUY0R2JnckFxa2V2b1lZMTVNMDVLSWhFbEl3Q1drLzNWUVY1SjBhcGdX?=
 =?utf-8?B?TFFtMzNKZ0U1d3JZcmErMHJhVUtac2dtaFludFRGRnJJTG1CSGVYMmhZbkVs?=
 =?utf-8?B?RzNhZ1AyYlU0SllHWmgxaDQxdGN1anREdTlnc0FweWpxRnBjRXlHbmFiQXhk?=
 =?utf-8?B?UTYxUHh5V1Y4NFhlWVBSU1dGOTVyMlVkYW9Pc2xvZ2dMZkd3dGhzNm5EK00x?=
 =?utf-8?B?UE5NZVRzb3o5OFNKUFdNejk5QTAvaTc2clEzVTV0UVFrOWsxbVJpbkQ0NURH?=
 =?utf-8?B?NDlWZnYyK1QrbnFIQk04aWRPNy82K002OGtMQXFiUEhJd0xDMjVrS0NRb25z?=
 =?utf-8?B?VlF1K01ZS2puSm9VSHowWmM5MlpwK21BTU1Ielg5aUlWZmgzTEQ5RTRaQ3hh?=
 =?utf-8?B?eUZsRXlxRVR0QU51RmdETlV1MTVXeE5tVmJsdEZwdjE3ODVBeFhPbHhDNzU5?=
 =?utf-8?B?bGNzeGc1UCtGdi9hNmZ6VTZuVEhnaUZLa0I4TFVBMWFGUXNKeXcvRElJQUNw?=
 =?utf-8?B?K2ZBTVBQaWt4WFRvNW1QRTlZMzY2NUh4dy9KOGhrMUdYRFBZQ3RNc2J4SXB1?=
 =?utf-8?B?UVJhSGdYNFFwWkJ5VHN2enQ2QjVRVkpiYTM3MzVEc0NqbDZUQTJwS1paSEMy?=
 =?utf-8?B?VTY3MWhIYjJRWlcwSHJjMHYwNWcyR2YvcUI5cG1kVXFXR3ovc0ZXbnVrS0xF?=
 =?utf-8?B?N0tLVVBrRmI2bUpzTkZSaXM5TmxpbnJEWFVCVGpnNE1ZMFBZWmw2RnVOdWw0?=
 =?utf-8?Q?zEQVhng1Fpo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzhKWXlnKzg1OS8zQWtkeWVVcURtMEpLRFVNMEFnZEhPZGdiTHJLUkdwcXZi?=
 =?utf-8?B?WXZtZDlXL2ZXUURsamVkakYreWFzWURQYTRJYWMrNklsRHBHWGZZTGVuV1RW?=
 =?utf-8?B?RlNYZEwyY0pSaFZaUDBtaXdjYjhpL2Q2YTc5cmRoQ25zZE1PTUk1dVIzM1c3?=
 =?utf-8?B?NzBQNVZKaVZJd0cvb1FDQ2VTRkhDOWRtdk9aYmdPR2x6b0dheUowUzN2V2Y1?=
 =?utf-8?B?T3orZGN0dHhJQzVqS0xvdGs0NDFWVmFRcHo1eXYxZWhVdFkxR3M0U2ZhN1V4?=
 =?utf-8?B?ZnY0Ylcwd3NHVm91Mi9SbUZMOE9kdGUxRXBsVFFJS01wUzg3aU1QR0djQTRk?=
 =?utf-8?B?OXFtQmQxMEUvdlhabDJ4MEtaU2l0bzgwclhRWHYrT2hFRjUvODJTTW9DVkZC?=
 =?utf-8?B?L2w3QzB1cWNNOGVTTzBib3NibnhzQXI5Uk1Bem1nNndOMmRxOC9jUE95YmVj?=
 =?utf-8?B?dDRjWUgxRXRNcWFHRW5xckYzNFQ5Q2ZTaWFxaWo5RUhGMjNPNThTRTIwUWh3?=
 =?utf-8?B?a0hEcXNxajdqTE9NbEs4cHNrQUdpOUZQWFVYTmR1YVBmdmpUbXMvWnRIdnpP?=
 =?utf-8?B?bG9DLzVpN1NRN2VJd0tONzFnb1hOTDZNcE9BNEtxSDc3RTVtc1A2REtMRnZt?=
 =?utf-8?B?YmpyMjU4ZFZrYWZYUitLU3R6ZTdhUGcwZ1l5ZEs0V2sxWGU3cWJMODBvNkha?=
 =?utf-8?B?Y1RqTmRxNFBSbDcxVjlTVlhnRENzRGdZZms5TnRGVGZNQjF6L3ZqelIya0Vy?=
 =?utf-8?B?VlpWN0V4SFc5UUlyTHJQZ2ZKclFxa1pFTVJtNDVEYU04M2twMy94c3BJeXJL?=
 =?utf-8?B?VHlDUVlaMThRSWFuN2pvcWVrRXRJK3h6VVlPcGZJckhvUjI2R1M0eGhlZ0N0?=
 =?utf-8?B?NWVBa1k4N2s5SVMzTFpRK1FBeHl1dkJHSXlXbTFhZTI5RFBVZzF0OGsvWWlh?=
 =?utf-8?B?dWJRZUpXelJLVHFFTytSYWdtb2JUWnNnUFRmdXRFV21zQk1XWEs3dkJUTGw4?=
 =?utf-8?B?Qjd0TU9ReFlVbThRU04xOXZRdExBV25SOEVjdzJrK2IzMWdlMHFzcGZBKzAy?=
 =?utf-8?B?bWtkMnNicmttMHJxN3hhclAyWU1YL1hxVTlXN2ZrenkzSEN2TWdZZkxiaHZ6?=
 =?utf-8?B?TVljOHhYTjh1ODRydFhNcml0ck04Vlg0eGlTZy9JR3hPUWthRnNaRURnMUtE?=
 =?utf-8?B?TTlpdFo0SDhLZXFpOEFMYlp2SFdQUEl4T0h5cjA3WGNCZXoweVBrUG9tZFlJ?=
 =?utf-8?B?bUx4djB0ZmIyNlM2N2JkR1pZN0I4OGh2RFJDdVFXUDRFdFBWSFlVSmpXaTdB?=
 =?utf-8?B?R1FraGsrUXlSUitielNFSHFHL2QrTWlBMnNwMFExTFNxL29kRnZkYkZxYTNm?=
 =?utf-8?B?SHY5MjJlcnEvSUEzQVdXbG13TTkrdkNGaStKWnRCZkVOdGwrK1F1UzlreHlG?=
 =?utf-8?B?WWJQMEFURXcxeTgzRk82bFRsN1dtb3k3YlF0UGZjcjNTcklibnkyM3JDOE1F?=
 =?utf-8?B?U3cwODVBVFNjWHJRTUlJR3M1OE84Q00zeEUwbXhoR0lwY25GTklZYldMOXZt?=
 =?utf-8?B?S2hZL082K1NaQnRzdjhTMVF1NndlUHc2RVdtY2ZPVFczUkF6Q2dmeGIyMlRv?=
 =?utf-8?B?eTNBaVBVY1BWT0lQb3lTd3FVR3lKV3BrT1dnVjFSeHJCZnlsQkVHRGZQN1dG?=
 =?utf-8?B?RXZsczl2eG0vNjZFVUFWUEt1czh1NHk2bHZ0VTlYaERmQWswNFI4UDBtK1RS?=
 =?utf-8?B?UkIyQlFxSC9UZFpwZGlXT2FmNU9NdVRxZ1o5aitac1JMYll6dXcwRFZFZFN0?=
 =?utf-8?B?cmIrUEZackJ5c1BZaXRGTlFhZEw0OVNRQm5jVXNnam1TR0NUZlBPVUljTTNH?=
 =?utf-8?B?bzNjOEYwaHVsYUpKcE1QQnZPMWFNYklXZVhOTlk1WWxJMnhYaEo4MnZaM2Rk?=
 =?utf-8?B?b2FBOUZoeVFHQjg0ZXZpUlgxOWtUZk53WjVsdHlGd2JVcWpwcmdKakYvYUxs?=
 =?utf-8?B?ODZONzAvWHJmdTQxR3Q1cVdPYkw3Qno1UmhpNkdNN0VvVVp1QmZkUUFlMjRt?=
 =?utf-8?B?QWttRDdOczc0RC9VU0IwdUFONGxndi9GSHllNnBOT2F6VDQ4YmpTcVkrZTM1?=
 =?utf-8?B?TnFHbEg0M1ppdm0rdXI2ZE1GbnMxQzRrZjh3blZzOURQOFE0Wjkvd0FqdUNq?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ytwXgDNPejQTKg3Tjk9fql44ubI0cZfNf2bzvupPy29tjh6TWhxOflo3ULJ9wtUUJ+RCvLwFNQqbz6PhgfbQgjX1He7rr0rlJXmF4/F9dUqRBHmiHnQf2CJiE4bgjUcxm+hBSgnar7yG6UWKacu/vUATGDv5SpXQzCBkKoGtOjIrKgH9UrhmI7V5v/zlYJIM/md0MBF03iU6U1Yi/883BS4qOPd8h2UHxW6yhOlTQEHuqys7EArRcE7EUDd4WY3LPHvltDQw+SgaOK57soYLW4oMeKjOq855yQU8NW3uyDKbjqHsYng0tm4VZGhyEqiiKCxq83i/l4OkjV51lsAo1zGWQ2OKPyeRCBrGX/FSapX2rgOruzi6POGysyaMOO+L8sVdOt3vQdHLZ3bjKruwDli3FyFDZrYqTNvBCcIQBjt22bq7VYOUzefbnHUGX+SLcEvHf+iQjhY2YYLOdEB41zkKlGMXNSiTiRBSmVyK2QztsGYzMF24ZHtF7YYJ2u5AgjgoD6i96kT7jjY0QWjlE6U7Yv3+0D3xcDjayYcZN4+Tz9N0kCCRP/wcj1DekEZyPgKuYQgArlMMOEv3yRI3Hs+4o+rNmJphaXCebSowyTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53258adb-04cb-44b9-09e4-08ddfb967098
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:16:11.1019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Fd2e6lQDLHx5zQQi7OUDInT2D++hLiRPUbqSRdHAN6LErI7ZBajZOMUb1DkdXAoQq6S0EBXR+j1rWxEOYIX1clgjihV+ceUHBwUeoy4ulY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240158
X-Proofpoint-ORIG-GUID: cvFCje3md5qd8h5tWNWHbDqBMj-umULy
X-Proofpoint-GUID: cvFCje3md5qd8h5tWNWHbDqBMj-umULy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX4Yc5YXpfslJj
 pUColt68mGTiBjz9Qe6SdvCLoEj2gy2KJAo550PsY+k9Ha5J/AeOCJJFelgGC3YpadhXhhGOByy
 xBbFSJnRfpUstJm6/hL7+kkIeL3dRY/Gy478vbwBd1KyfGP6EN/ud+8d3hkhpjn0UOkAEwpeOWR
 uAoNx6Tj9f2Tr+uPfvZ4edwye+JSSwvUHCJNx/b2uNwcZtcyY8cKCDZOgJ4LjwBxBcMWgeLEg3p
 CdGgwaLSrarjSR4m+aFI6X2VljKNoex45Hzv5gGp9EX8+wTx2ICYc498SjDouUrW82W6PAWV6yg
 wMzWYkeWbV6Xc4o2MuUAEkldnMYzObuA2CNB2IP+tEBnMDH447OqO2b+tPknKDe9+QBeojQG1A/
 /+3R3Kh9
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d4356e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Fwdq8xlfBST6HCkDzlMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/22/2025 12:00 PM, Cédric Le Goater wrote:
> On 9/22/25 15:49, Steve Sistare wrote:
>> To preserve CPR state across exec, create a QEMUFile based on a memfd, and
>> keep the memfd open across exec.  Save the value of the memfd in an
>> environment variable so post-exec QEMU can find it.
> 
> Couldn't we preserve some memory to hand off to QEMU ? Like firmwares
> An environment variable is a limited method.

There is no upside in making this more complicated.  We only need to
pass one tidbit of information -- the file descriptor number of the memfd
that contains all other information.
> Thanks,
> 
> C.
> 
> That's a short term hack right ? it's not even documented. 

It is an implementation detail, known only to the matched saving
and loading functions inside qemu.  No one else needs to know, so
no documentation.

- Steve

>I am sure
> you something else in mind.
> 
>> These new functions are called in a subsequent patch.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/cpr.h |  5 +++
>>   migration/cpr-exec.c    | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/meson.build   |  1 +
>>   3 files changed, 100 insertions(+)
>>   create mode 100644 migration/cpr-exec.c
>>
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index 2b074d7..b84389f 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -53,4 +53,9 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>> +QEMUFile *cpr_exec_output(Error **errp);
>> +QEMUFile *cpr_exec_input(Error **errp);
>> +void cpr_exec_persist_state(QEMUFile *f);
>> +bool cpr_exec_has_state(void);
>> +void cpr_exec_unpersist_state(void);
>>   #endif
>> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
>> new file mode 100644
>> index 0000000..2c32e9c
>> --- /dev/null
>> +++ b/migration/cpr-exec.c
>> @@ -0,0 +1,94 @@
>> +/*
>> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>> +#include "qemu/memfd.h"
>> +#include "qapi/error.h"
>> +#include "io/channel-file.h"
>> +#include "io/channel-socket.h"
>> +#include "migration/cpr.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/misc.h"
>> +#include "migration/vmstate.h"
>> +#include "system/runstate.h"
>> +
>> +#define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>> +
>> +static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
>> +{
>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>> +    qio_channel_set_name(ioc, name);
>> +    return qemu_file_new_input(ioc);
>> +}
>> +
>> +static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
>> +{
>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>> +    qio_channel_set_name(ioc, name);
>> +    return qemu_file_new_output(ioc);
>> +}
>> +
>> +void cpr_exec_persist_state(QEMUFile *f)
>> +{
>> +    QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
>> +    int mfd = dup(fioc->fd);
>> +    char val[16];
>> +
>> +    /* Remember mfd in environment for post-exec load */
>> +    qemu_clear_cloexec(mfd);
>> +    snprintf(val, sizeof(val), "%d", mfd);
>> +    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
>> +}
>> +
>> +static int cpr_exec_find_state(void)
>> +{
>> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
>> +    int mfd;
>> +
>> +    assert(val);
>> +    g_unsetenv(CPR_EXEC_STATE_NAME);
>> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
>> +    return mfd;
>> +}
>> +
>> +bool cpr_exec_has_state(void)
>> +{
>> +    return g_getenv(CPR_EXEC_STATE_NAME) != NULL;
>> +}
>> +
>> +void cpr_exec_unpersist_state(void)
>> +{
>> +    int mfd;
>> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
>> +
>> +    g_unsetenv(CPR_EXEC_STATE_NAME);
>> +    assert(val);
>> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
>> +    close(mfd);
>> +}
>> +
>> +QEMUFile *cpr_exec_output(Error **errp)
>> +{
>> +    int mfd = memfd_create(CPR_EXEC_STATE_NAME, 0);
> 
> The build should be adjusted for Linux only.
> 
> Thanks,
> 
> C.
> 
> 
> 
>> +
>> +    if (mfd < 0) {
>> +        error_setg_errno(errp, errno, "memfd_create failed");
>> +        return NULL;
>> +    }
>> +
>> +    return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
>> +}
>> +
>> +QEMUFile *cpr_exec_input(Error **errp)
>> +{
>> +    int mfd = cpr_exec_find_state();
>> +
>> +    lseek(mfd, 0, SEEK_SET);
>> +    return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>> +}
>> diff --git a/migration/meson.build b/migration/meson.build
>> index 0f71544..16909d5 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -16,6 +16,7 @@ system_ss.add(files(
>>     'channel-block.c',
>>     'cpr.c',
>>     'cpr-transfer.c',
>> +  'cpr-exec.c',
>>     'cpu-throttle.c',
>>     'dirtyrate.c',
>>     'exec.c',
> 


