Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F166E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 16:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUpaE-0005Xi-2O; Mon, 06 Jan 2025 11:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUpaD-0005XP-8b; Mon, 06 Jan 2025 11:04:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUpaA-0001XZ-SQ; Mon, 06 Jan 2025 11:04:01 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506Etw70006681;
 Mon, 6 Jan 2025 16:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=i2o1tgil1DsdgxXz9U4socw8lYXSK95dUY10t/+YPXw=; b=
 bcqimjZeqIEYOa/wzTc8FJ+7N7m/l9OtFNaOw59L0k0aAhlYfginjhNtQnU/Qrm/
 y7mkDsnNtLNa+9ZbJGsYsBAw2n7MIWSi9I+o153JVyJffBBtIm8qSNYBDFaJy5TD
 tTKFdQtbUuXL1nLGgFpRyFofLQRAZDEadVIiwFZ9SLNbgytVa2mR86btAd3DwQ4F
 0cyQ8pKaK++MAbGj/jdWgbFSH45E8HyZxtUocu3m8QGWVvSlB7NRKtTmhZbPV645
 YU61lkwYytV9ny4XosJQPuz9twIt4dXNwjOG8cybXB2QOkITxlmQvdSVx5nDYZob
 cvjvIgu/v/xEGb3mOvNoMQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xw1btmbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 16:03:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 506F7eW6011275; Mon, 6 Jan 2025 16:03:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43xue77591-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 16:03:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjUNK5L/Vns791XTd3LJtdbcJKVkSFENzfGUL39/HqejA77ERnpY5BlFU2kQ4/v/USr/TuKu+oDWvkPp0/9WcC0I/Ww+lSh18afzMtDRZUNlWDDBWKgmWu+LHP1KwxktYrBUcL3vdeWCjsX6qsRGPv6TXQtwGgiCbGdBlJSiz0EBPTUDNfKP8ubvkW7Niye2+IHZLq43N6ODhsSDNrh38/FF3zATbxpimmcEk43Nu4u7urgkwg5mC45GylifSJsdt+fKEwbnkqmFqlIJyfBBdXOMeRGJTR6UTDJJ0wdnBhxqdNXu/LyskVzVcr9LQH01NGqpy8lWyZ6HanisireYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2o1tgil1DsdgxXz9U4socw8lYXSK95dUY10t/+YPXw=;
 b=Un45LWXBINdO9ntHjpVI++2+w17vQNnaDuv3yfXz1SBBsjt3jIO521XRpk9Jdj/y2FlWaA5DVLaWGrV3QlirDrdPPuHWPD81JCIaREQICCgfWndCtN2FJvvjtwlvFmOFY1hr8i0voIhIXJe+uIl8OPrbk+o65QH9//mI4EbheyYEjB8xiwljI9GQ5nWKoBQ8usSYE8GJkoraunAtEtQ4olw68gx0uCF7PaQJm02ipIZAoPaquYTv3QvJ3Bwx8vbIR9V9sSJNpNsWpuT6xd0voLHj/fxStiR4o0emIJd7upQQuOiR0G3SI7vKQdRZosacY/7KHx3nqqhpbVaU8NdEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2o1tgil1DsdgxXz9U4socw8lYXSK95dUY10t/+YPXw=;
 b=Knl9AdCCBjacVprmvkCk/3plq09oKsc7rXo4K8iTfSaFOX0ka/d7p5nqvf1LptWOv/lC795/ciPT+BET+f2GrrO4IzAyXwmnolllcLVj+/LQeaG6yIw7qmO5u78VkNM68y9JQgELFB/dkp3OjUjp7PdYoLFtk1J+1GYXnm6PPD4=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by PH7PR10MB5880.namprd10.prod.outlook.com (2603:10b6:510:127::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 16:03:50 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 16:03:50 +0000
Message-ID: <8a944e82-ac02-44d6-88dc-c2444a971377@oracle.com>
Date: Mon, 6 Jan 2025 11:03:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Move net backend cleanup to NIC cleanup
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 dtatulea@nvidia.com, mcoqueli@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, qemu-stable@nongnu.org, leiyang@redhat.com,
 Ani Sinha <anisinha@redhat.com>
References: <20240912165408.234447-1-eperezma@redhat.com>
 <7fa03d44-fc85-4732-b357-f5610460925f@tls.msk.ru>
 <CAJaqyWcgbFx=0LVLG-FFqGbYMrwa5qyWxhPhfqdYY0QAvsRe3Q@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWcgbFx=0LVLG-FFqGbYMrwa5qyWxhPhfqdYY0QAvsRe3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0902.namprd03.prod.outlook.com
 (2603:10b6:408:107::7) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|PH7PR10MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 942f148b-521a-4196-d541-08dd2e6bb562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEdHTTk0a3ladnorOXNoMzA1byt4cklRSmlkWmh6RS9RaDRIN0pwNDVpczR4?=
 =?utf-8?B?TmpoVDE2RFZId09XYU5IVlFFMDdod0ZPR2Q2T0FIeHBmaVZlNmJ2YnBjZHZB?=
 =?utf-8?B?TmdmZjErMDloOHYyWVlaWlBoK3JCNE9ILzNpblVJMlJhOXo3WXQ0TlFBNjJX?=
 =?utf-8?B?a1lWcXI5QU1KeGo3SlpUMjV0UGlsUFhFeW1lNTc4cFovZUVLUHl0RkxRK2pI?=
 =?utf-8?B?NEk5dmhLbW9uU2lkbkc4ZVhNaFB1TzY1K0pCcVFwZS9vS2o5dm9YS2FLNkps?=
 =?utf-8?B?NjVMQi85Y20wR2dSWjZRYlFnRzBicXIvWG9lbzU3MVMxZHNleFA5eXVwc3pu?=
 =?utf-8?B?UzBPem5SVlk1bUthbHpzMklBRStYMlhJR1ZTMFZZY3pwdURzRm53RFVReGlx?=
 =?utf-8?B?TGwvd1ZZSVFBRUdhT2lVcHRBSk1RRmUvRi9EMkJKVFJTbVhVbi8wdDVyazJY?=
 =?utf-8?B?RGR2bkpQaVBoUEVabEs2MGV1bEoxS1BpdlVoVHp4M2hxd2tnd044L2gwV3V1?=
 =?utf-8?B?U1dOOHJQNkx6Q1pLaUhCK1lXQitKUk9WRjNvYlVPY3ZmbzI0aHl3VC9lVkZD?=
 =?utf-8?B?WE0rbVRGSzFGOExUbEMwdXdabnc3OEZUQW8vUUxTNW44cTk4dzdLb1IxWnJu?=
 =?utf-8?B?YjM2M0ZsMFIzN0hQRDFUdTk1dHBjWVRUT2tqd2k2Uk01SUZSQ3JLSUxrdEtW?=
 =?utf-8?B?bTVrNWhnQVYwVTFSZnkycTAvMVhncWNlZkdncWd1aFFucDNKd3RJb1NjN3Fo?=
 =?utf-8?B?emhaM2Roc1J4Y2JhTXJxVFVnMmpSZ3A2c0c0SEtBL2crc1dQRWR6Y2k0VlpN?=
 =?utf-8?B?TkFJU0N6bUdmR2lFN0lMeWxXVy9PVGs3K244YkFKOTZ2ajdXa29yb25Ncy8y?=
 =?utf-8?B?aWhXb0FmcDNHeXBaWm5LaTgvSVRrdHR4WVA5SnVQamU4Z0s0OHd1a3NJVUM1?=
 =?utf-8?B?SzFWZHVuS0JHYjkzMC9OYmEzalNMQ0xzUDBpSEFreWlQSVBGTERZT25MNEgw?=
 =?utf-8?B?Qkx1bmlOd094N29zSHM4QUp1QXlmQ1RtL0JkNE1qWDBvaEtXT3FiWjNUSFZK?=
 =?utf-8?B?eExMcGhtVGZ6ZmhBWjFQZUZVNE5jbmttNkVxdE9oUFFRV3Z3aXVHMDNqZWpV?=
 =?utf-8?B?L1cwM2tnaTRFWEpsbGpTMlg1RjdPMTVaZ0dOUG5taVRQQ2FYNFJTM1ZTYTJx?=
 =?utf-8?B?VG5sdmNFb2M2UTdZZEdJU2lVc0IzclhqMVRlWUpFVUh5WHBlQm1qNDcyQzB5?=
 =?utf-8?B?dUtyTitlcldEZ1lHQ1BHcDQ1b2dvZ09ZdFZWV1h6Wk4rVnJvcHk1Mnc1TW5s?=
 =?utf-8?B?ekR4aXdJS3p5Z2dOUWpDblNaL2lHRU9UY0FZano3T3FBM2pPNU9tWVh3TVgr?=
 =?utf-8?B?eGxHNEd4NWl2aVgvUmdUcHJmSEd3MHFrS3hsSzNLR1Q0cFNJYnJNY3lnUmpl?=
 =?utf-8?B?WDE5b2ZoNVFJcnlYemlwRlJIaWJEWXQ3d2xTd3Q4VHQvK3dZYit5dWtwb1Qv?=
 =?utf-8?B?VHBRYnQxQnJzZzNvVkxpYVZITmM2aFhnZEpvQjZXYzlzSFRSZzVtWWhpWDVi?=
 =?utf-8?B?cUtDclp0eHdjM0dEZ0pmVmtEREM5K1djMGoxVVYvaHd4Q1NhcDBSMXFSQUoy?=
 =?utf-8?B?UGo2UU55bGRpakxNc3BKWVhPdlNCTzQ2TE04SG9kMzNES1NvOUU5bmxCdDJZ?=
 =?utf-8?B?TGx1K0Z1NEh1aldySFVhbmxjNGZuWmZmb1lwdWRMNEFaMytCS2Y4RFdndTQ0?=
 =?utf-8?B?NnpYeVRwcjNVR0JOZzYwbUl3aTVkTUNpRlp4Q0J0L05vczhiZkpoaGdEejdu?=
 =?utf-8?B?N3dtZjZHT3dPclRSWUpKditvUkVmdXNyNUpxNm9QakhpelZ6SEtWeDVrb2FC?=
 =?utf-8?Q?KxlF7vdFRNt60?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTRFVUd5anp2Ym9yYXp3ZzZzTlhSQU1ZS291ZG5QUzlVOFJsOC9RNXZsM2Vq?=
 =?utf-8?B?OGlSZk5SRGJhUS9DaFpjVHFxT1Qza3FsUldFbWxHbzc4NkdaTUQrcjJsUjJa?=
 =?utf-8?B?T3psUkw5bTRsWTVOOW43ZWhuSW9pcHp2b2ZBbXh2VjM0OWRaWEZqek9KY1lV?=
 =?utf-8?B?eVlKWmpBSmdJYkw0dWx6ZFJkc2FjSmFMZXRoNlhXZ0dLeW50VkgzNWptak1E?=
 =?utf-8?B?eFpYbmZxTHFQSlB3MVllWHViTnA2dDdxSjczMjhVZC9nZHZIM21WaEd3Ym9w?=
 =?utf-8?B?ZkNSMmxEdEc0S3JHeDFpNWdBSnVmZXZlbytKdWtud05adE9GOGJFMUtLb0lk?=
 =?utf-8?B?ZGVjbzZqUEl1QVlNL3I5SEVyZ0ZBS2JXQnZOamxtbEI1bzJKZ2U3M0tlZDFK?=
 =?utf-8?B?WTFnTlpETjRVVnpEWVd5bXNOald1M3BQMHBGaHVtQituK1RwUXFBNFREa1I0?=
 =?utf-8?B?cjJlWTc0aSszTnFyQks0VkxmbkdiZXVyd3BVN2pwV0JIVkEyYlZmQ2RzQUd2?=
 =?utf-8?B?Z2MwOUNydGNCeStSUTRqa0k2Y2NoNEtFQkpVdGx0TVhsQTFQRTNIR3B6NDlC?=
 =?utf-8?B?c2hKMVRXaXlaM1Bld2FGNmhNcFVXYVR0aDgwbjQwV0lzSmo0N3ZYa0ZnRUJ4?=
 =?utf-8?B?bll5cjRha05qcmhNRXhXbFNvaXB4cG9YbmErdVpaaVFQWWFjRUlRUnJzS0I3?=
 =?utf-8?B?and1OHJlY2ljVkpGVmcwSE5kaUZPUUlLWktqMmtPYy93dFZuUTJoNWRmMm9a?=
 =?utf-8?B?QWdWME1HUXBUUFNpYXdaU0prQ2RPZWVuVnFkS21LM1NYYzlzb0FSUDYrWlM0?=
 =?utf-8?B?aXQxMGI3TzlZdjVtWGZvQnRtYmhic1VlMERKWEZwdTRGSS9KN2JNYXhUVDBl?=
 =?utf-8?B?MnlFeGU4aThWNFlOS2NiaTFrd0lRZ0EzNWg2Rkh0OEx4VURZdXFncFBHWVhv?=
 =?utf-8?B?OWZuZVNHYlErVkRtS0VXT2NHRU5LYjZSV3pEdUVJZDMvNlVKTDVucWc4Qmtw?=
 =?utf-8?B?eGN4UUNLaTNURDZIOW90dUp5VTBRWHJldjR5S0xMYXpOYXRqT0tGV1BzNng1?=
 =?utf-8?B?NEpoN1dCeEt0ZzFqRGwrVDFQbjJubXJ2RzVZUklwTENNWFdPZFpycDE4UE5v?=
 =?utf-8?B?ZVd6bTZ4aXJTbjJNZ05Td0Qrb1F0UjlFOXNmR0hpK2FYQllIelNxclNhSWZi?=
 =?utf-8?B?VjNEYjB6RTdDck1YSG4zNWdicVlBeFZjVmtrRWl4aTJGM0VEWW5UWkZXUUdP?=
 =?utf-8?B?VU41dkc3WkJxNDlNS1dyUVdnc05TNFh3SEZ3MzF3OVozaWx2NlQ5Z251TWZS?=
 =?utf-8?B?VFZkUkc4bXBrMTRnMEdZOXJYUFEyend6bnI2QVhNQTQ1SlNMRThWOFVqbGxP?=
 =?utf-8?B?bEFocUk5MW9vNEdFcUh6Tmo0czdmdU5aZHJzdlk5S3JHK2l3emNkbTAyR2Ir?=
 =?utf-8?B?aVRPemprWnBIUjFjYmhscTNsV1FwemdleVp6UlF1a0VYc1dZQ25NWndyQTZo?=
 =?utf-8?B?cDBEaDB3VHUrOElxVHFNUTZaN0tpTlNLRHcvQVNVRXAwVlVkRVFlOHhSWWNK?=
 =?utf-8?B?VE1JbjZGelUzbWxUYXZ5V2NtUEtyY24wSVJ5Ykx6TldLRDNPVXVLSzlvZ1Zl?=
 =?utf-8?B?MzdpWFRxQ2diQ1FlZ2xsY3dlSHBaZk1GYm5nWkV5aDdkMzFiTktsRWlKQ1hO?=
 =?utf-8?B?eTg3VjA1ekZob3BRQmJuSEg4cXFyM1FUcUYyYzhVYzIya29vRFVUMlROM3pJ?=
 =?utf-8?B?eml0bElicHdldExqNTNqMm1lV1ZSb0huRVplakdhVXJXeWkxWm5sVDBWNFQx?=
 =?utf-8?B?K3IyZDRCdWxHS3V4dTQzc0VqdnNRTVdXalMrTWRUVk1tOUxsYmN5b0dHNDFP?=
 =?utf-8?B?cDZSdlF1ekg4SUpFNFJOaHVTRStNbThCVGVkZUVNUzVJSnRuK2VQMGx3aVQx?=
 =?utf-8?B?S090RzJ0R2lXZWhDS0RCU2xXMVB4WjNydjRlRVlicy9XMlFxWHpWZElWMXJu?=
 =?utf-8?B?T0k0UHQ2ZGY4UXpENk44QWk2VWhINjBHdVNpbkpTSkx0KzFITGY0TE9QaEt4?=
 =?utf-8?B?MmpXWDliREZ5UTN6eHY5V3R5OTJsem9NT2R1Z0ZqeUs5ZEdRemJXL0FQWndM?=
 =?utf-8?B?TzZDQlpBODNoc1VWeTh1SlBWMTlVd0ZQclVYaVdockxaS2l1Vm9zRlhiK0xl?=
 =?utf-8?Q?xUUdANgTBj+l+Udpg42+PGQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5E/PD32h5JObZN9OWJUFHZ5RHf2LbbnJlR7JmmBln8Q9MGkxLl3G5vU2Co4p8QWwzbVCfDFIioLqENwvrIIj9SLeJveEtA1pc39QFDobT+YfCvOYKZzvNxVEQ8UHapxgCjXZeHpNtwjoCSxMF8TsWY/qbZcbkXKL1HAbMLYs42FiztCxX2qVDemArmtCNnZS+s2HrYoSRXlQNy9JrwFoDc8Av/CF2Mmahwg4dwhcZhj086cyOtJc0Bzy+kJta5ue+GUNGcavchvrHkWj8k1Ld8OwlhdZXqMmosh0YZqhMRsxoiG6+oXEZ8tkRMXWNEmgcY4s/C+L3gd1rYbelxLQKZ11zTVGdTewJTuURPx4EYQ7UrRSmldF1ifIijWviKJRVGQw9cGrGO4v/ewGc8vt1J5g+Um5XZ0yBElhD+aZ2qfz2+lJoKULUimbrHl9+IYmH7UT94KNMXnoDhDHf1I9vui9n4c7tbtO+sSexlZEJUi/92BolFRSozfDtWUo5RXFCZ576LeL1CWQCcVtwaSRarVZzI1F3+Gi4EPZx8R+qJ2aopikUzH4DyYJkzp0afb/rtpqQAJ9JePb9/oZ8i4OrI0oELu8cbMShV477YpmPk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942f148b-521a-4196-d541-08dd2e6bb562
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 16:03:50.3871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mWP50gxHVe+4oNCL7r4RvHPfOmkYtw+evVDMGp3lAMPCQrMrR10NHwUdsZKczqxSvW1RhVaNfH9/Hk9cVRYRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060142
X-Proofpoint-ORIG-GUID: JZKrCVmO5Izx2y8KVt-d07BWb6gGioS8
X-Proofpoint-GUID: JZKrCVmO5Izx2y8KVt-d07BWb6gGioS8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 12/23/24 11:33 AM, Eugenio Perez Martin wrote:
> On Fri, Dec 20, 2024 at 10:02 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
>>
>> 12.09.2024 19:54, Eugenio Pérez wrote:
>>> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
>>> structures if peer nic is present") effectively delayed the backend
>>> cleanup, allowing the frontend or the guest to access it resources as
>>> long as the frontend NIC is still visible to the guest.
>>>
>>> However it does not clean up the resources until the qemu process is
>>> over.  This causes an effective leak if the device is deleted with
>>> device_del, as there is no way to close the vdpa device.  This makes
>>> impossible to re-add that device to this or other QEMU instances until
>>> the first instance of QEMU is finished.
>>>
>>> Move the cleanup from qemu_cleanup to the NIC deletion.
>>>
>>> v2:
>>> Remove NIC peer also at net_cleanup. vhost-user trust all the
>>> backends are clean before qemu removes char devices.
>>>
>>> This is not a requisite introduced by this commit as
>>> system/runstate.c:qemu_cleanup shows.
>>>
>>> Eugenio Pérez (2):
>>>     net: parameterize the removing client from nc list
>>>     net: move backend cleanup to NIC cleanup
>>>
>>>    net/net.c        | 44 ++++++++++++++++++++++++++++++++++----------
>>>    net/vhost-vdpa.c |  8 --------
>>>    2 files changed, 34 insertions(+), 18 deletions(-)
>> Hi!
>>
>> It looks like this series has been forgotten.  Is it still needed?
>>
>> In order for it to build, a single line in patch 2 needs to be
>> changed (in net_cleanup()), from:
>>
>> +                for (int i = 0; i < queues; i++) {
>> +                    NetClientState *nc = qemu_get_subqueue(nic, i);
>> +                    qemu_cleanup_net_client(nc->peer, false);
>> +                }
>>
>> to
>>
>> +                for (int i = 0; i < queues; i++) {
>> +                    nc = qemu_get_subqueue(nic, i);
>> +                    qemu_cleanup_net_client(nc->peer, false);
>> +                }
>>
>> so there's no variable shadowing anymore.
>>
>> Should this series be resent (a v3), or can this be fixed at apply time?
>>
> 
> I guess it is better to resend a v3, so we don't have a compiler
> warning (or error). Jonah, maybe do you want to move this one forward?
> 
> Thanks!
> 
Just sent out the v3 with the quick fix.

Ugh, and I just realized I forgot to CC Michael Tokarev in the v3 
series. My apologies Michael!

Jonah


