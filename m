Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668B5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcVj-0005rl-FL; Thu, 15 May 2025 13:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uFcVh-0005rX-J6
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:36:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uFcVf-0003It-G5
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:36:45 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1uYX007637;
 Thu, 15 May 2025 17:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=t+0M7LLrVzyuU4CDOxuvcSVypIEWvdxEwsVM0jNwpgM=; b=
 OpWsaU0cQUEPgcewHfVJHxEEc5wRputXvdBI/dMkb8VRIi+Ueoi/VdBbWcLzyuDf
 fgV45ABAKoyHIvdMET2QMSgnx+yZ1zbzafGwSIw0kc1JbZSWD1ACcz5XS55+iGDX
 6HUM/GpOtXF7e63+kGeT87JVjw/Emdae55/Z+8JTQnsQRks3zG5kGZvGfdmhDb1+
 EVPOBecsinNhof7G39hSRb2qBpCUX6m78zyPPA7j0dH7bY3YbIUcc37D1wnw0O22
 XrNA1fjOKAJmFfavlL4VKY6uROXHziBSLDPobJNOIzsSg5fAPsAdHdArKaRw+Pt/
 6qcjlQNzQhyUsec70V0KuA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ms7buk2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 17:36:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54FH4lw7004343; Thu, 15 May 2025 17:36:38 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012036.outbound.protection.outlook.com [40.93.1.36])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mrmedpsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 17:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOgmhclbm9XDiXOPk26OHupeSb+FPyxVLaQVB3z20j4vYrM9tz04bbK6HzC4hGt6ICegG6GmdSilX61XT/5bcz0N4cWehzTInbCU2FE2nhXaoA24N3ZBiVSIlhudCcqbUkIwynXcIj7tDKZAA3Tu2Ru10bUilPXU8ZOpfc2Y0aaZ6ijRyyQFjua+ZvVYOn48AZOE+mGO05cYMAQoIVN8U++qujglzkWXIgMa+sAoCbnQtyafZB4IXM9PM0GdY49q7iB52r4ni41cSN80QP4GWLM9ijY9/H9XJbbxd+6ubYjoC86bk2oXN4Ui/zs8g7aMSm6wv4QMrbBAo/itOH78ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+0M7LLrVzyuU4CDOxuvcSVypIEWvdxEwsVM0jNwpgM=;
 b=KREs5eEoDN5grUBZetxBatIwOWwlrpr1LM+Hmw76Efl/w+9uR5LFkzWTPkOtNASeitqzJXUoPdOvvcQ8VnCeettsO65PF9CTr+aaNLgrGTNTbSQpPS9ivcAqI05feBYrCUJn7YmjHeDGE6dFBkHHZWXgt1ELBEujbYcyxw/dtAtGcfe6MSJJh0ortpLABp3Yqw4DfpWIITZ1+pBKubZJaprb4B+L948sSNfS/HUkA/i3v91c7k+vBouxrp8lRALL5/HLyf6fF+U9H/H6spJzvz93m8rhG55uSoE4CQlwxEfqJRtBBbf0ejFrJxFNnuju8RwqDwMqwUqW2472KsaItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+0M7LLrVzyuU4CDOxuvcSVypIEWvdxEwsVM0jNwpgM=;
 b=lbNDQXEC8XLxkteXidy9eCDGfFYcWnPsUJxp+6Y6uuoXr2WMZ223rbw29KXqy0qDA+BruZgAiCS307+oZqdHtKg+NI+whuLOm9Z70+xy6YHmSQDCM4vhJQTmIH/3AF5YnqEVhUH9q4YlBlsPYh2Hpiz8mkg2aLRTe6U1c/u2Y5c=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by PH0PR10MB5779.namprd10.prod.outlook.com
 (2603:10b6:510:146::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 17:36:34 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 17:36:34 +0000
Message-ID: <a05df34b-bacd-46b6-b958-ec94076d7649@oracle.com>
Date: Thu, 15 May 2025 10:36:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] vdpa: move memory listener register to
 vhost_vdpa_init
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-8-jonah.palmer@oracle.com>
 <20250515014103-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250515014103-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:36e::27) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|PH0PR10MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: ae986fb9-fec8-43a2-70b9-08dd93d70947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tkk5a2VPWHhLUENjUTVMU1ZhVk9RM0poSlZoR2V5TTIrVVhkMlU0L3A3Rzdk?=
 =?utf-8?B?TzJiYUZXMXJDZGNma2xUQjJaaWNJREtzYVcwUDhHWUFYcko0N2JLRlRuK0Zt?=
 =?utf-8?B?cTFuN2xGVVJkWFJZSUhyWjRiNWZ5SDc4QTBKNTZzc0xDMUREOXFrZVlNM09L?=
 =?utf-8?B?dG5QL1Myd043L29SQWFuYm54MGlFRE54dzZIK0RPbG1idXlod0lpRUtBYjBk?=
 =?utf-8?B?bHNMem1MUm40QXpGWGZ5UEFVSHJ0M2pBazZ6bGwzczFLSDZUaDJWanh6QUlF?=
 =?utf-8?B?R0QzWWIzMHRpZ25QNFM2V1RESWpZdHhkL1FaYmxUU2ZrSmVrelp0NFowdkZN?=
 =?utf-8?B?TXZZTkh0TzRyYnpick1qYTRzdVExKzVpZFVsSVdOSU5uOFFjaWU0Tit6VnRq?=
 =?utf-8?B?eWFFLzN5bkllMmdXamFmNlZQSjI4RXliRVhCNEI1Y0lEZm4raUV3MkhDaWJS?=
 =?utf-8?B?b3JHMGlZWThyaDUwMy83WFBOUUZmWWdOVHlFbGxZUDZqTkpiNmlXcUwxL0Jq?=
 =?utf-8?B?NDVZekphNHAxaDlVQVR5c2xqVHl5RnRWbENuSU9qdExXaXNiK01SMDh5Uk9y?=
 =?utf-8?B?YXg3YlhmYVpadTRDTDdjeTlvSUhnR00yUW9tcytTdy9KT1M5YlZOeHdQK3hF?=
 =?utf-8?B?M0ZvNCtlemc5VXBqczQ3bG5FTWFhY3VLeEVQVS9ERnJtODBVTUw1S0RpT3FB?=
 =?utf-8?B?UXdrQXhmZVpHVzJ0MXhEd2EzbTlJZ0QzZVFoZGRnVnBvanFyL3kxQXU2TGlK?=
 =?utf-8?B?UU9Jc0d2TUJUV1pSdnVBUjhacytuSWVmYUFPWjBkRDl3RXlkQ0hMdGNqcG54?=
 =?utf-8?B?MlUzU1grNklHNTkwbTAwc0loQlE1bmF3QTgrKzV6dEQyc0pnbm5Qcjhack03?=
 =?utf-8?B?d2YvMjNqS1JQL1pPYjFvL3d1dTNFVVlISnBYaVd3VEhXdDFjK1BSVWNCc0hp?=
 =?utf-8?B?MTBHZzh0Q01Ra3dRdzMweWp5Ni9hWEJ1VWZkcGRPNWdJV3h4UGVhOG0vSS9D?=
 =?utf-8?B?QndOWTJJK3Y2NlBSdndESGlWWnZ2TTJ0Um5jZ21CK09sRHdxdFl4bndUVG84?=
 =?utf-8?B?YzF4U3hDdmgzOThXSG1lRHgyTUQ1Q2lGOUJyczY5OUNCbUIra0NRRzd1dFQ1?=
 =?utf-8?B?dkVBT3ljQmhpTkE5VklhR0NRMEpYMVFKcFI3NGdyRmNOc2JoZVIvODhXbXk0?=
 =?utf-8?B?RHBSVS9xUWdSWUw2Q2orbU1uQlRUZkZWcHplT3Vmd3VGSUoxM3NMcTNZSHMx?=
 =?utf-8?B?ZHRkdnVXb2p5LzYwaCthbXhxNUZJdzkxSVJEMzZzTURKZjg0Q0FFakRUSmxC?=
 =?utf-8?B?QVIxZ3FoNDk4MHlrclJTT3l3aTM0MUNjZkl6RkZOUHhYVVpWeGFnNXRWT3pL?=
 =?utf-8?B?eHg3WWpsK21vaVo4V2UxR2RFN1ZZY3ZVQnFRVU9rSjBNUXJmMVp2NHVDUVVs?=
 =?utf-8?B?UDJCKzFVS1BET3RkY1BTZ0g2OXhJcExnOVlFOThjRGdia3pMRmxydE15SFky?=
 =?utf-8?B?VE9JZGFRdnhScE90RUoreGNVNzJJOEEydFZyTEpPa0FGTGpRbUpQODREajdR?=
 =?utf-8?B?THVtNmNNVi9qVUdVSDFWWkZja2VjTnE1elo5R0pBTWJvNTZoSzR2OEFDVnp6?=
 =?utf-8?B?dDBGQU5XYlBqQzBucVJmYWMreExhZWh5M1AyWEhaRjNEdWlXeFlRRCt3dklX?=
 =?utf-8?B?NGZXSkI2U3RWWXYxcGhldWw0cUNBTHdWdllhYVJjRlJySjVxVWhhUERRanVm?=
 =?utf-8?B?Z0luc3Z5SlhTRGtjODlWei9RdnhIS2NZN2N6dWs5TGxpUUZhMmF3TWduZ2ZU?=
 =?utf-8?B?aFJRcmc3Nk9wdk1qQklGNXA4ZzdhNXJkTlplRDRHaGhUMC9QMkpPL0J6V09P?=
 =?utf-8?B?UVpPTHB1OHphR01uYldXOGZLNHR6WTBjM1BsRHFocE0xYmJCNzVoY1FWTzBJ?=
 =?utf-8?Q?VUcpP9QKls4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF18D5A7206.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pyZ0VkYThnNno2L1d4ditreGtYaEtma1pSNXE3bGRWOE9iNVNIR0N6SElJ?=
 =?utf-8?B?SEZjYThsemdNR0M2czN2aitoZzEyZ3pEM0VlSUJzakg1UWZTaEhYTXAvK21a?=
 =?utf-8?B?VVlzV004LzVaL2FlTkVINzVwcXNuM1VrbUlUZmxzZHNVWitnQmdTS3N3ZzFk?=
 =?utf-8?B?VWFHZjZCQmVkeERBdUV1OVFvSmlsa0lBS1QxQVdPeFFZM1p4TlRaaS83LzNX?=
 =?utf-8?B?enVYQVZQSWpxTW82b0lSSkY3RVpSNkZhRUJ0QjFUY0ROaDhMOFIwd3VNWXJq?=
 =?utf-8?B?ZnAxVVBES1AxOTdXeWNxeUQrYVZhS1FiZ3FOQnpqNmR5OGVZeEREQWFDTExN?=
 =?utf-8?B?Wnp4YTJwZlpHK0Ird29zVkUza3M5ZGlCbGRheU1lUlVvanBFZHVFUFdMYS9M?=
 =?utf-8?B?eWZUWndPNTU3MklvL3MwTDlkN3RuZFdiZ0c4TWlEUndGY0NUTytpbjVtV0hr?=
 =?utf-8?B?dXI1VXZHV0Urcm1uZW42cHMyTjkybnFCNHVlNS9wWFlTS3NTNllCMWRBK2du?=
 =?utf-8?B?dWRHeDBEc3dLemdxR2VScTRrRSswV0hOYXo0dlFXUGc1b0xrSUZDcDRSWmFh?=
 =?utf-8?B?cE0xcHc0ZGxqbUJEUU1ONFZYcVcycWw2Z2piZkhvN1RXVXhaeGJTeFhtK0lJ?=
 =?utf-8?B?Ky9wamc1bXVKbXg4bTlZZHF1b1laRkdpZGNiRitEMmpKeGhqanRXSzJGeXNI?=
 =?utf-8?B?N1hEUzVKSyt1THpHMHNldTFlUEx3OFZ6OXJLYzkvK3VQSDcwc2xCdit5T3RV?=
 =?utf-8?B?QW5LdVFkeStKZlpUMG1KazR1QXNLclpaYmJUZ1drUy9xU0hpa0pySlFMRXJz?=
 =?utf-8?B?MzFUVi82Nlc1M2F3MDkyTWlndTNXTjd3blFUM0ZzRVpxRmNub0EwRU9velZv?=
 =?utf-8?B?bjZDaGxxOXRpVWIxVGw0YUswbVhFeWdObXRLakd4bzAyM0wzYUwxY2FQaEhW?=
 =?utf-8?B?VG5VTHNWY1NwdCtDTWJodnR0d2ZXMmtRUnBOYVZJcXExM3dxRGV4YTQvcThJ?=
 =?utf-8?B?dlptSGtiRFVYZWdTYTdodzI2dGtXVWFEeGo5NVJKVFBReGZWQlZWVGRxZjBM?=
 =?utf-8?B?OXplNytqV3VJdWcxVDlBNkRoOGdWaWd4Zk9BUFpZZ3ZtVDhhaW1zS0dZcTVa?=
 =?utf-8?B?cnNtU0hUdmxjSWVXcnpUamxRd3ZaeUVaRXpMY1NBQ3ZFd3NFZEpHSmlidzdG?=
 =?utf-8?B?MTYrTkFNdjVtUTYxeWlBaGRIMG1GVUlYRFJHS3NQM01JNm10all2QTZjZGJk?=
 =?utf-8?B?dUVPMHZidlliV2tsZzBJYm5nanNiMzRCdkpISXRYME5vV0ZnbVVSS3RnWE4r?=
 =?utf-8?B?Z1ZEcjk0UE4zTlNSTjlaZTA1N3pFVmJibzBEWTJwSjNVbndxSE5uN1UxYmNs?=
 =?utf-8?B?dk9FY3drTTg4bUdmdkhja2VLVVFsVFI2K0NDMlY0cmxnOXhzeFdxOVhiK2xJ?=
 =?utf-8?B?cndUdEh3c003M0ozcVhXbGZvNnRKWE85dDNIYkJjT2c0L0o5VlU0VWx4elpP?=
 =?utf-8?B?ZmV4emdaVk84b2RyeDlSbW1ZekJQZytJYUZWZk1DS0hCNGFwYXhhenlQSnJi?=
 =?utf-8?B?U080b3Fhb0FKR25hTTFIbzQ5anhoZ3FBamdoRnNuaDhLTXh5ODkyS3loNmZE?=
 =?utf-8?B?dHBIVGdFM1A5dk9XY1NHdjMvSzdLdmpuaVBmQ1hKbW0vSUNXdVBhRis0TlRX?=
 =?utf-8?B?WFRwcy9UQVFKUGUrL0VBcFlqNlZYejc2TTZNdnFUcGlpMTRuTEp4UjBVZzU4?=
 =?utf-8?B?SUdiNU1hZVA3UWt3WkE0WTJrdm5Yb1pMQll2bDIzTkpvd3IrbnhLc1N2Ym9W?=
 =?utf-8?B?UzliKzVKVnRoR3FFWGd3aGlpelFSQitWUFlzZk8vZkNUeldjN09OdWJKR3Bv?=
 =?utf-8?B?c2VCeFhBckpDN1k1ajF1Vnd6TmgxR2hFNkZFaHpFL1c1YTNvMm9yL0R1cm1L?=
 =?utf-8?B?dmoyb0NweUo0aGl0L3J3a2pOOGRCaGJxN2xaSFNHNVA1eWpPYzUrYXZwY3E4?=
 =?utf-8?B?eSsrQlg5bGhyQldWdXhGVE1adGNPSzEzeEpac1BrSlFsNm0wWUlzcXUvR3RN?=
 =?utf-8?B?YWJ2Z29tK1dmRWI0TWlwVDdpTEVtWTNHTGlXQmZ0MkdOTDc5cXIzQWdFQi82?=
 =?utf-8?Q?PsFqmKkG8wtcWCP1NNlFYPPxo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TwwDdCX1e5CrLvp9OlIapwg6xOb5F2r92m/0l/CNXKpG5uJFlYwWPxq683XCcazvTWZ2RlacdSzBBxNm1qUx3RgBPhhi19At8EqJRNz8a621Zqo929nuimUvrJnlmZOXhJdrXJVHUrEs9VWMwIQmAf7RfiBCpyzUxr5E2IMnFRmLsjiaP8rCN9fw0vrxLZdDHQuOUsG/eGYN4/Xv5dwPn5mwDHqkTImj6zRgaD7Aj30G+dFEbNVu7+qcD5ao3rdFVND4EY3NxCOcFaRplzh8OYNGWiWO0ULvh+T/GqD7KRJmNN1xmXuE13A8yayvCIe98/vOqz4bUaw/ga/j9IROyc4VFlAAm9VJIPMa+0V+oycqX6F4Ievs50GjFZQs0od/aFGLexq2JE5K2GwL7AvcAOSspGDc3OTeEnMTL+DUAFzA6e+aCLf4E9RfKBWkS3uH1xrcXRh+auPYFJ+6mqSJ2In/lqdMIjZb5TQucYlczFKcJ/EfMQrpxJpVLNTZZ+SYT9XMkCzeXZhRoJWptCJFqcIiBw5+xCAA0lhaDMbZFVJX2mUU0FmvUcmzd65JM65OYjLjPZYAxa0jabAtyR/MN97/1Pgg3etyz4mTJAFuo/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae986fb9-fec8-43a2-70b9-08dd93d70947
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:36:34.2182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSbajc+cmog7IYtXN3GSzU6lPVIrIMPEsRUZnHDjLxjVJl9YsCgEDzrfw0V9DyPwHaa7nY0CIKaD/CpRerxZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150173
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3NCBTYWx0ZWRfXyushwi7uHmDc
 KeuuDmh+tZCA4egJoCaDcBQTI6HbdgyD6krbtdJmc1uut+zQX35jaV+HH/3NqczCFEA5yxLCUWQ
 a8tQJIzX3WRRNw57wY86cfBXSn0m9kQHz1IunamzXxb41LH7yfY5o69t3R0rzTmr8X2KnfCxDRE
 l4Qb7RQB/Zk0whaVvKY1RW/ehiigiBnOLs1o3c2KNne+fM1x6DDOWV6ZILPqdvqKJBjyYyZVj6c
 ndCzvptrtslP7SW76B1gCA6V9ZGCCNnSlqX6JdrLr+HBA6rIGtUDO02kxl8McoExRqbV8I05fcR
 CokyIizrfKknYGCfXgh1GHeGVQdpGfhgY+Z+JnOGnFxf90trTKlKEusf/peTEuPy5fyNVLmYcWW
 uOQNYKd4fAD/luBa58MCDl4aeSXIPFYlG7x6uuOnlzTNaGDbSMPkPe0CtDNVoMjCkSHj9yZ4
X-Proofpoint-ORIG-GUID: deGCHYLT7WvF2r2VpnrpjzIjlQzCNIxu
X-Proofpoint-GUID: deGCHYLT7WvF2r2VpnrpjzIjlQzCNIxu
X-Authority-Analysis: v=2.4 cv=P846hjAu c=1 sm=1 tr=0 ts=68262627 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=z6maRmm4YkmY470tJ_YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/14/2025 10:42 PM, Michael S. Tsirkin wrote:
> On Wed, May 07, 2025 at 02:46:47PM -0400, Jonah Palmer wrote:
>> From: Eugenio Pérez <eperezma@redhat.com>
>>
>> Current memory operations like pinning may take a lot of time at the
>> destination.  Currently they are done after the source of the migration is
>> stopped, and before the workload is resumed at the destination.  This is a
>> period where neigher traffic can flow, nor the VM workload can continue
>> (downtime).
>>
>> We can do better as we know the memory layout of the guest RAM at the
>> destination from the moment that all devices are initializaed.  So
>> moving that operation allows QEMU to communicate the kernel the maps
>> while the workload is still running in the source, so Linux can start
>> mapping them.
>>
>> As a small drawback, there is a time in the initialization where QEMU
>> cannot respond to QMP etc.  By some testing, this time is about
>> 0.2seconds.  This may be further reduced (or increased) depending on the
>> vdpa driver and the platform hardware, and it is dominated by the cost
>> of memory pinning.
>>
>> This matches the time that we move out of the called downtime window.
>> The downtime is measured as checking the trace timestamp from the moment
>> the source suspend the device to the moment the destination starts the
>> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
>> secs to 2.0949.
>>
>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>
>> v3:
>> ---
> just know that everything beyond this line is not going into
> git commit log.
I guess that was the intent? Should be fine without them in the commit 
log I think. These are interim to capture what change was made to fix 
specific bug *in previous posted versions*.

(having said, please help edit the log and remove the "v3:" line which 
should be after the --- separator line, thx!)

-Siwei

>
>
>> Move memory listener unregistration from vhost_vdpa_reset_status to
>> vhost_vdpa_reset_device. By unregistering the listener here, we can
>> guarantee that every reset leaves the device in an expected state.
>> Also remove the duplicate call in vhost_vdpa_reset_status.
>>
>> Reported-by: Lei Yang <leiyang@redhat.com>
>> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>
>> --
>> v2:
>> Move the memory listener registration to vhost_vdpa_set_owner function.
>> In case of hotplug the vdpa device, the memory is already set up, and
>> leaving memory listener register call in the init function made maps
>> occur before set owner call.
>>
>> To be 100% safe, let's put it right after set_owner call.
>>
>> Reported-by: Lei Yang <leiyang@redhat.com>
>> ---
>>   hw/virtio/vhost-vdpa.c | 35 ++++++++++++++++++++++++++++-------
>>   1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index de834f2ebd..e20da95f30 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -894,8 +894,14 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
>>   
>>       ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
>>       trace_vhost_vdpa_reset_device(dev);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    memory_listener_unregister(&v->shared->listener);
>> +    v->shared->listener_registered = false;
>>       v->suspended = false;
>> -    return ret;
>> +    return 0;
>>   }
>>   
>>   static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
>> @@ -1379,6 +1385,11 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>>                            "IOMMU and try again");
>>               return -1;
>>           }
>> +        if (v->shared->listener_registered &&
>> +            dev->vdev->dma_as != v->shared->listener.address_space) {
>> +            memory_listener_unregister(&v->shared->listener);
>> +            v->shared->listener_registered = false;
>> +        }
>>           if (!v->shared->listener_registered) {
>>               memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
>>               v->shared->listener_registered = true;
>> @@ -1392,8 +1403,6 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>>   
>>   static void vhost_vdpa_reset_status(struct vhost_dev *dev)
>>   {
>> -    struct vhost_vdpa *v = dev->opaque;
>> -
>>       if (!vhost_vdpa_last_dev(dev)) {
>>           return;
>>       }
>> @@ -1401,9 +1410,6 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
>>       vhost_vdpa_reset_device(dev);
>>       vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>>                                  VIRTIO_CONFIG_S_DRIVER);
>> -    memory_listener_unregister(&v->shared->listener);
>> -    v->shared->listener_registered = false;
>> -
>>   }
>>   
>>   static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
>> @@ -1537,12 +1543,27 @@ static int vhost_vdpa_get_features(struct vhost_dev *dev,
>>   
>>   static int vhost_vdpa_set_owner(struct vhost_dev *dev)
>>   {
>> +    int r;
>> +    struct vhost_vdpa *v;
>> +
>>       if (!vhost_vdpa_first_dev(dev)) {
>>           return 0;
>>       }
>>   
>>       trace_vhost_vdpa_set_owner(dev);
>> -    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
>> +    r = vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
>> +    if (unlikely(r < 0)) {
>> +        return r;
>> +    }
>> +
>> +    /*
>> +     * Being optimistic and listening address space memory. If the device
>> +     * uses vIOMMU, it is changed at vhost_vdpa_dev_start.
>> +     */
>> +    v = dev->opaque;
>> +    memory_listener_register(&v->shared->listener, &address_space_memory);
>> +    v->shared->listener_registered = true;
>> +    return 0;
>>   }
>>   
>>   static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
>> -- 
>> 2.43.5


