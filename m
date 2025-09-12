Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0881BCAC594
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux55s-00067w-AP; Fri, 12 Sep 2025 10:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux55k-00063Z-WB
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:49:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux55h-0007dJ-LU
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:49:36 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uPTK016787;
 Fri, 12 Sep 2025 14:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=E6I1JJflsh0FUsox7MxstGfFjAyhTWuGg0UCX19FahU=; b=
 oJRrHpbUMlUrIDsjTbbkcrrVDEhd/HSluy9i4nLWCSTmH8p6EQL9OYhDGL7LV6vO
 utfh5tjN3rPivO7i+/R7OsDxXZ6P2LlbNe0NTicFL4q7JknXOfVZx6r2AKPDz7R+
 dYz7TnHtqHSW0qrzxiKThhIAOHlI4eMNnUGMKGfQiiR+DJzi52aQBAaww+xnhlga
 /qZrp7x+cXmRC/O39/kaW9rADxemgH+5XQnoiBVI+k95wGOhF7fkh3vcZEIo8N+P
 fKwY/cmoakhatlS29dw5+8Yn3/gdNUD7P685WYnCM2R3bWcEIFzqZm9RBji9XMIW
 QAiMoV68Eqfo6f2xeC7Saw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922968dfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:49:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58CD1Fa3025964; Fri, 12 Sep 2025 14:49:30 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 490bde0sgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj2HRB9q63dHFhk4E8+NY5uQP8/FthOo5XUdmuldoX9XNsPdsaaBlSLGPvP5QvlZcwsr+mVsN/d24C9rDNOP7nLGrqCUxFj+gtA86md2yc7Yh5BhHkYoiCqZXY4oGBo9tO05PkMRKwvd5BFtdgxnEvXZhw8OnlF0ZkF/HRWsmllVvuThYY4g+jwAHeTFjP9Y8NETNk27PHwvIOKIQVH2E52k8ENkt2/5G01TvdAIYSnFXrG9rwAtsfPWBQXxqmRxSJVXLOmiypmjjpFX1/bnqG8TUdJV4uMOcEyEnOmxXb2f+Cr8PhlFh72s0uKGJrEBxr28rY/5Lo714jiWWO81/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6I1JJflsh0FUsox7MxstGfFjAyhTWuGg0UCX19FahU=;
 b=d1wNfuNVAVGVYqzBj4kcAOmic0NhOggZYqiD2tI1kYxa/cR8mtYIYdHZCiD/QRyrbwsem7iycF0ZQmGxvv9QAnsHBvoY/M96b6nmZFML1vLhC/8WLcaTjamLHDNUTpBKxdwGbwWZjFO4jSC1WYRYl8ivTcc3pTZ/g/KoK8mJFu3pwih02p4U1BtRNeruTMu2CH7HmCcqMGN8fF9DeOizMmlnRp+HR2wQNeDc/ESY4ajFFe7ceVWCafZnU6ib9Xq6zvPfZKFUNqSdTwI1cJbS5cVfJjT46dLEWh83IIn06CihuN5u9FOtu9PwD4qTbXZzHERkpCkebGFmMYnm+HKCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6I1JJflsh0FUsox7MxstGfFjAyhTWuGg0UCX19FahU=;
 b=xHvDjEJwFYFHPfl2h7dwTAX6I7WzOzRKw6M6iYvisabbVRiMfpd5CCWS6LDo1hdWPskCADwWaZhzHSIF1Un+J+akxjabInTlzpW7sjaREdgzPJGEJ2So9pN/kgtFEh+e1IPuwcJRgOu5uMMuBlIvANRNQdBLQehk1/cxgAnCvcg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 12 Sep
 2025 14:49:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:49:28 +0000
Message-ID: <28bf9c97-1e69-4121-a4aa-2d2bf5ac50bb@oracle.com>
Date: Fri, 12 Sep 2025 10:49:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/9] vl: helper to request exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-5-git-send-email-steven.sistare@oracle.com>
 <aMBNCUXuMzxUToff@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aMBNCUXuMzxUToff@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:510:2da::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: c588235a-652b-43bb-97e6-08ddf20b9302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXBrR1F5NllDYTdia1E3UjRQMTZhWnpvVktDSEYyVitQTTVrTi9jQm9GcG5o?=
 =?utf-8?B?cjNBeVZSVXc3YlV1aHVKaXFSc2JKR2g2V21ocUlESVBDa0N6L2xMd1NGZzVu?=
 =?utf-8?B?d2Y4cVFDZVlieFlNWXFSU2lCRkhxRlFWa0pEVXptbm5MQkczZFRId05LRGtF?=
 =?utf-8?B?TnJnbEhCLzVpRFptQ0VNWUVSWXNxcTl4SHNjUnpQYkxGQWNlVmJ2T0NHaEto?=
 =?utf-8?B?eDJ2RkQvMmN1MmlWUXRlZ0VvaThreUVyMkRrR2tQbWlDZUFXT1V2L1FoUnN5?=
 =?utf-8?B?NUpaOW1yT3NEdmRyVkpzbGlBSWZRaUs3dk9ncmZ1emFRakwzUE41VVhuS3pC?=
 =?utf-8?B?SDB1aTF6RkVvL08yNDlwOHB0K25YRGY5UWNPRUx6TzN4ZmdEM1M0UWErSG1R?=
 =?utf-8?B?Ui8wdHFKenBnTFR4WUVVU3Roc0duOXA2Ykk2MEJ6WkRDR2x3dHFwYXM5Vng1?=
 =?utf-8?B?QVJKOGxMeDFVeE1vTXhBZEVCS1NkS29adXhKeUZIYjFPdlFZTFdJbXB4UHVM?=
 =?utf-8?B?a2tQb2JyWjArMDROMGp2QnRiaUszMWlMR01qSFc5SUJBOGFZS2tpalEyU1dX?=
 =?utf-8?B?RjFqV3laTm41TGZCeFNLalhONFlldUk2V3pMU20wWVRZUVorcFRIbjRwbmUr?=
 =?utf-8?B?RytBemw3ZlhGUitDdjU2aVIyU3NKODBLRGcvZzk3TWpFOTJHQmNJa2Y5VWpY?=
 =?utf-8?B?Zm02SXhjUnk3Ky9ja09sVzBYMTgvVjNmZGNVWmVhazlOY1AyYnh0MUFHTldJ?=
 =?utf-8?B?Y202eExWRzVVcE9LUXhYWjQ4NGxqY3d3M3B4MGJHc3ZPSysvbVlVb2pxaTd6?=
 =?utf-8?B?WXcwTVNIUlR2bVh6YnhUb1p3SFA5aHNlOU14SWZ5KzBFZ2JwV3A0Unh3WTA3?=
 =?utf-8?B?M0ptdCtaRW5oUU1PbEkzR21WNVdwQ3RkSG40NTREdFZmSy9BUzJnUFUxT3Bq?=
 =?utf-8?B?REQvREg5S1lzdE1wN1g0RC8zVW5KcnAwNW9ZL1RQYlRBa2ppODhMZ2wwY1l2?=
 =?utf-8?B?MDUydHF2eG5xaW1ZM0p1clh3KzBvZGVVanpUK04vRXBzc0lhVmE2TlIxbmZD?=
 =?utf-8?B?aGpTQjdXSlp6RlhTaG5PbGxjb3Y1M2JROHhNeGRqa0dockUrdWZQcFR3MkRX?=
 =?utf-8?B?YTJlZm44ejJTU1ozWkVuaGNtZzRiKzNORDRUMDFjNG1LaDhQMnpVd0pySVFG?=
 =?utf-8?B?TDhJRFo3bWdyQmQyQ3FtNUR1bFM5dHNWa0tNanc5ZlRmTDBOeC9KelY5dUpx?=
 =?utf-8?B?V1ZPQXpiMVFVNlhZaHVXWEpBZ1M3TXJPbEJCc1FNdDVPZFoxdzFJeHRuNlFx?=
 =?utf-8?B?NnFxSVhIT1hKZEE0a0MwVVBORlJIaUUxTktIR0RkeHhrTVdkZkdLZUV0YjQ1?=
 =?utf-8?B?cEFJYis2ck1Ed3dRa1dkQTJTdEhQRW1wR3BGZkMxQVpYNUtVOHpmY05YRDFQ?=
 =?utf-8?B?M3ZwN3RuZk1KMWtGTFdnRXFUQ3BjYnkrS1oveS9Za0F4TkRqdHAwcGlkUWlh?=
 =?utf-8?B?ejVCZTFNc2tOOXpwVVd1TW16bG1WSUdFbTNXdkJVZEpyaXVad0c2QndxVFBG?=
 =?utf-8?B?Qmt2REZsbmFTd2VCWVF5R2E3Qy9EVWtuTURXMmVpeUNZcjEyaUorU1FrMmFO?=
 =?utf-8?B?eDBtbEh6U0dCTnM2UXdkaGRuR1l0b0MyZ1BYTmFTN0tQbW1qaVBZT2ZNWDdG?=
 =?utf-8?B?TEhscUU0OURBTU9mc1BtZmFCVzlaV3hOTmg5QlZQaDZ1WHV6eDJDN2tTYWly?=
 =?utf-8?B?TzFUSmVvcGZ2WFhJRm40OUdNeFJEL2Q1ekVnNWI4QWl1QjFtemkzS1UzcWxu?=
 =?utf-8?B?QjVGbWZwZysxMDdZOWJPbXB1ajNiSnhONHcrUU1IcGZiWVJnNzlud00zdVJr?=
 =?utf-8?B?WjdkaFViaFpwMnBoSDA4R2J3cHFBS0docDY3VnBuSk1zb3h6L1d6Ull2WkQ3?=
 =?utf-8?Q?IKaaxkrmPzA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkFRcDE1NjJjRTNlbmJuY2xnRStwZEdZMzZ1OXFCSm5Mc0ZtNUN5Rzc3aHdT?=
 =?utf-8?B?YkltK0tJeHBibVNCdzU2Nnduek5aV2F0SVFKQmlYdkZ6MzZ4SThvVEozVXRo?=
 =?utf-8?B?a2RsdHNOMlBLaEJJallIaFdiS2pZeEo4cUJGamtCbHRac1oweHBNMmNFQytS?=
 =?utf-8?B?WjFZTGFWWFA2K1BOYVl2WVVsdVVUMDZFS3I1SXQzU2pPMDViOEJRWGlmNDRz?=
 =?utf-8?B?V2dHUER2TXlhc0tmWEY3UzdoT2NpaThFZnZHMXhDeHppL1NHUEVKRVIzRjBz?=
 =?utf-8?B?WWtvcVdqMi9zM3FxeFlsdjh3c1psY2ZHUE5ZODArYXpxSG5uTGVnVi9jRjlN?=
 =?utf-8?B?RHFuaktiRWtySDNTendmTFhLVnRRREF1L09lNVRaa0NOdjA0TFdKKzJUOU1z?=
 =?utf-8?B?TW1qcEx4VFhrTXNXZWZBT0IvcTYycnc5Q2psVFlaWEZqMHJZaURTZm16VytW?=
 =?utf-8?B?TU1pcGhxSURkdTUwNlpEeDNSYlhrZDJSNnA1Y2lQZ1A1QVJnSXpYU0IwRWZD?=
 =?utf-8?B?TjA0d1p6Nit4WlEzZTdYeHJidFUxK2xSWVFPVElOd3JmREk2K0xQVGlKZnN2?=
 =?utf-8?B?UUFsUU1EcWwxYWxFeTczOWhFcFZ3SXVpd3UzdUZ1T1pzL0E5Q2x1RVMrekF4?=
 =?utf-8?B?Ym96RFhxUEtBeUhwV0pzcnVSdUpKZUFnb0xoQXk2RkxSelk3NmJVd2Zvd3B3?=
 =?utf-8?B?MEc4WkdDQ1p2TTNMalBkZjZoa2pDTWdvR25STWwyY2dmOTZEYkJ3SzZ3M0cv?=
 =?utf-8?B?NjQ1Rno4WGpMWkcrUVdTSkd4OUFOaTVkcHV0OVRnYTVSYnRGVFFSc3pMa0ZK?=
 =?utf-8?B?Z1QxQnpKRk8zcWcycTRnSkNRZU1Td2hPYVBJVTdMeVlsekZKcVZWUzdZSEdQ?=
 =?utf-8?B?K0hmNXBBOFBVcG5JSS82ZjZGeXIxNmxoVFpXOFlzeENKTnZINlBoZWQzenJi?=
 =?utf-8?B?dDNyaDlyRHYwM21XaWpCM2dpK1lEUktiYlp4cjRKRGF0S3FlcXBOSlExOEZ0?=
 =?utf-8?B?Q0ZjR0hjUmgrS1hYbm01cFVnZFMyU0FCZ2ppeGdOSG4wVW9uRUZwL3JqWk1u?=
 =?utf-8?B?VW1TSW1EZVpRb1gwNUF2MlIvc1lZOExrZ3pFNEVZd1dMbGp1MjVYNWFqWUpw?=
 =?utf-8?B?dnpXM3FoL0hFdmVLNTFpbUZ4bXRCOUF4MVFRdjZOSU1pdGs0b1pTQkpIakxF?=
 =?utf-8?B?bUFoaWtrekFwOERhaEVGN29UQ1ZqdVZITWFIczE3N0h1VjVFbHRVemNIc0dn?=
 =?utf-8?B?eUJJSkw1V2c5eWtZczk4c2crQkVTWkZkMTNCaHpLTWVXMHh2MUozR2ZNVjdH?=
 =?utf-8?B?WHByTmZaTll3MFgrTVBCcDVuRTFqTmRtNkxISzhBUllSNFFQMk1EUVJZM1dQ?=
 =?utf-8?B?SWJ3ZHdXNGpDbzlZMFJHLzBMbjFMTHY2NCtYUUVoZDBVb2NzMEw1VFFvOXUx?=
 =?utf-8?B?TzBnaHR0Z0I5M2lZTGkwZjRtdHRMSXo1VkFhRWNWTXpUa2hhVnpWdVNJMkEv?=
 =?utf-8?B?ZjU5RDFTUXhuckxjVGFUTE8xTzR4OEJQZUZocC84RU9xcjZSRU8yUFBMRmp2?=
 =?utf-8?B?VkFrdzJpMEF5MTdFeVRjQ2lxemJXdXd0KzJHRUVpWWpDYjJOUUMyU1Z3Z2Fl?=
 =?utf-8?B?bEtHY1VhQU9kWkRoek1IbUdoU2M1UzJYM2FWOGQ3R1VRZTd0K3dsR2lRNGVa?=
 =?utf-8?B?UGp3Sjg1QnV5cXRuVnYyR1ZtOE9zVXFLRXVwM0ZRQnUwR3FCTTBJM1pueEd6?=
 =?utf-8?B?RlBJNDlzYUFGZTRxaFl5UUcrTXJxSU9LNWhEbkJZNXRMbW1QSmVsQUw2Z2NL?=
 =?utf-8?B?em9Ya0cvOEVoQTZoZFJjcHF4NUNreUs2VGhmWXZ6aG56QlNFbmEyTlVKWXlk?=
 =?utf-8?B?ZWNaSU0xcFFpY0w0aGNFeTBkRFQ4TWRVZHgxT0h5TkNsMHgvK0lpL0JnWUdB?=
 =?utf-8?B?YUtqbGRxL3RpV3ZLYkpPempnd1ltS0xkcktXck9UMTBxdzZMdkxFUTUra2h3?=
 =?utf-8?B?S21VdU9wMVZWS2M3YW9VRFlUVU16dU1EenFESDJ4b2xvK0lVNmNsaU43UGpi?=
 =?utf-8?B?Mit5TURtY05STEMvWEJYMVRHT1B6M2VxdmRFTlAzM2FkSUFiekRTbStWTk4z?=
 =?utf-8?B?bXNYclJKcWJtZXZ1RWY4TG82Q0lWZHoxUTNBbTRXU21NUUdEaTNlYWtSRDd6?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oysrFn4EZdoIVQCMc3HlqMzu1SSRyimdRitsMwvjIjSbrN/oHsewGt2yvFs7ErD5Qck9xotQq8m5TbeafYTnpTFdX+CEy/sY4+05U+OiNSbzEBtkOL0I/4ODN40qsL6YBkRO7Rr8EuamY+VYDjTXtqI1RDmsK04DIuWFUbFHvZr6BKg1JLtff05pEK8Sx07c+gbK2gIXD3PRRMurCPlsin3M+SuygeWGPiVOUnElApi9HH5Ji4XPObj7BvvskObMpEx496hgClkw+SsEwY9ni4uGNs99IQx6Yvs/miHvjLFsgEnsyj6jjxAZ30o5H2o1aa4BoNzpKSw4f+EJsza9CjHJ+PRxEjCJNYG+BRdxrPSM9wU2hj6qLgD69Pru3I7cxy/I+alYD5E2GGoHmr3+ferQ2Ygea97TVVmtTjsjyT3xBt50736CooDkf+RIY9UtkTB7fhSQCwlsgf7Bwzc3N8z5ib2lcC6pItZjtvJ/SnbVHuuGC3JS4eDLkXDKPl7ohgFDA8Dq7kfpmCN0ZNgH406z8TbyqvFyk0a5huyupTvgHedIkbYsLEzJ4Z+btJmRberFwkyKynKyoaiQMYwWFqR2Qohspu2xxZWne5Cdi1U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c588235a-652b-43bb-97e6-08ddf20b9302
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:49:28.3977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wb7q+ALN9pRb2KNiTEoxrWoZGlrEiVVxUltVKyrPBH1HuHA5GsJTzKUDVUSOSIDMhLtgxkJONfwFZLgr3bg/Hw1RZmOhy9gzEnhZvytYT3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120137
X-Proofpoint-GUID: KI_qjRokTgams8_G4YMiZfbRmH5ktCeA
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c432fc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=UMyXomIJRQMxgr3ulywA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX3mf6RoX5Ofif
 NaUcScWiF/3m0ivo6GOJtHVuwvVm28xqD9aPYXJ+3w2bTX7+BT0H8iFbvWp7HLbyuUc2utd/GJc
 yz4ZBRiV/pZS+yQu/QJkBDPlDrXF7WcMQB9tJ9zJpE/SLx85G5N5lK0B7F1zeKquksnIa/8fIUS
 tnIF45EuBt8vSee08hWitPrcjJSLOU8Y8aNr7SYmlPoWEozgPZAgT7d+mKJ+6i2er5f57XEVtKD
 ViWkZkEiPK7HAJ44yFTV2eBExlf4tNURg9aqIGVdnf2JqqSHLl7ZvKD/J64YfkClaurp6imhAus
 K4UMpnvRGYPounUVOz0FFIoHEBLA1fGOmWIGxm0IbC64IsLTMJJ2XGM9aMRCa+V1BRYhXzBhqqz
 XmKYiPUsk0UVIgyahCu6dJ4/inLFlQ==
X-Proofpoint-ORIG-GUID: KI_qjRokTgams8_G4YMiZfbRmH5ktCeA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/9/2025 11:51 AM, Peter Xu wrote:
> On Thu, Aug 14, 2025 at 10:17:18AM -0700, Steve Sistare wrote:
>> Add a qemu_system_exec_request() hook that causes the main loop to exit and
>> exec a command using the specified arguments.  This will be used during CPR
>> to exec a new version of QEMU.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/system/runstate.h |  3 +++
>>   system/runstate.c         | 29 +++++++++++++++++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/include/system/runstate.h b/include/system/runstate.h
>> index 929379a..c005f49 100644
>> --- a/include/system/runstate.h
>> +++ b/include/system/runstate.h
>> @@ -128,6 +128,8 @@ typedef enum WakeupReason {
>>       QEMU_WAKEUP_REASON_OTHER,
>>   } WakeupReason;
>>   
>> +typedef void (*qemu_exec_func)(char **exec_argv);
>> +
>>   void qemu_system_reset_request(ShutdownCause reason);
>>   void qemu_system_suspend_request(void);
>>   void qemu_register_suspend_notifier(Notifier *notifier);
>> @@ -139,6 +141,7 @@ void qemu_register_wakeup_support(void);
>>   void qemu_system_shutdown_request_with_code(ShutdownCause reason,
>>                                               int exit_code);
>>   void qemu_system_shutdown_request(ShutdownCause reason);
>> +void qemu_system_exec_request(qemu_exec_func func, const strList *args);
>>   void qemu_system_powerdown_request(void);
>>   void qemu_register_powerdown_notifier(Notifier *notifier);
>>   void qemu_register_shutdown_notifier(Notifier *notifier);
>> diff --git a/system/runstate.c b/system/runstate.c
>> index 6178b00..b4980ff 100644
>> --- a/system/runstate.c
>> +++ b/system/runstate.c
>> @@ -41,6 +41,7 @@
>>   #include "qapi/error.h"
>>   #include "qapi/qapi-commands-run-state.h"
>>   #include "qapi/qapi-events-run-state.h"
>> +#include "qapi/type-helpers.h"
>>   #include "qemu/accel.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/job.h"
>> @@ -422,6 +423,8 @@ static NotifierList wakeup_notifiers =
>>   static NotifierList shutdown_notifiers =
>>       NOTIFIER_LIST_INITIALIZER(shutdown_notifiers);
>>   static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
>> +qemu_exec_func exec_func;
>> +static char **exec_argv;
>>   
>>   ShutdownCause qemu_shutdown_requested_get(void)
>>   {
>> @@ -443,6 +446,11 @@ static int qemu_shutdown_requested(void)
>>       return qatomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
>>   }
>>   
>> +static int qemu_exec_requested(void)
>> +{
>> +    return exec_argv != NULL;
>> +}
>> +
>>   static void qemu_kill_report(void)
>>   {
>>       if (!qtest_driver() && shutdown_signal) {
>> @@ -803,6 +811,23 @@ void qemu_system_shutdown_request(ShutdownCause reason)
>>       qemu_notify_event();
>>   }
>>   
>> +static void qemu_system_exec(void)
>> +{
>> +    exec_func(exec_argv);
>> +
>> +    /* exec failed */
>> +    g_strfreev(exec_argv);
>> +    exec_argv = NULL;
>> +    exec_func = NULL;
> 
> Would this really happen?
> 
> If so, do we at least want to dump something?
> 
>> +}
>> +
>> +void qemu_system_exec_request(qemu_exec_func func, const strList *args)
>> +{
>> +    exec_func = func;
>> +    exec_argv = strv_from_str_list(args);
>> +    qemu_notify_event();
>> +}
>> +
>>   static void qemu_system_powerdown(void)
>>   {
>>       qapi_event_send_powerdown();
>> @@ -849,6 +874,10 @@ static bool main_loop_should_exit(int *status)
>>       if (qemu_suspend_requested()) {
>>           qemu_system_suspend();
>>       }
>> +    if (qemu_exec_requested()) {
>> +        qemu_system_exec();
>> +        return false;
>> +    }
> 
> Some explanation of why it needs to be done explicitly here would be
> helpful.  E.g., can we do exec inside a BH scheduled for the main thread?
> What if we exec() directly in another thread (rather than the main loop
> thread)?

A BH is a good idea, thanks.
It only requires a few lines of code, and no globals.
I will drop this patch and add a BH to patch "migration: cpr-exec mode".

- Steve


