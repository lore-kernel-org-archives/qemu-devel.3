Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22E4C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UIX-00006E-HZ; Thu, 17 Apr 2025 14:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UIV-0008T2-JS
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:49:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UIT-00052f-NZ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:49:15 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMqac004775;
 Thu, 17 Apr 2025 18:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+caJPEUbNUaSekvc+2XSeGFFlWplnMQp5tjJAUaeBIE=; b=
 GH+4ILmC2f22qu9j5QajXqr967mNAUQMzQRiOADfqmb0I6QvmSvFxoepayw+L0NT
 w2Mn5qH65qgJ1kOktdqOTuEilNSbnsV/J9nKs6rk4jgWRrqnRgTEVoP+6+b6yYkM
 k1oec7QKcixx0SpHdUioM3ONqULqpkYi9hRc4YM6W2vNQsQa4dRISHvNKO5oonIy
 Ifc+4P3Dn28mlsLomlWLfoQi63kBH2XjFRiQbkaHH2AsUxvdrIocCsCIr4GgvGz9
 Sl396cxsM8oc4VLzObVYFJTe9HTmCT/Nen7wOVlJZcdqScUgQ8/MCfmN9GTzNuYu
 +NjWEqrB0vHgCc1hVojhtA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185my0n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:49:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HHGebv038821; Thu, 17 Apr 2025 18:49:05 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010020.outbound.protection.outlook.com [40.93.12.20])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 460d4uxfwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:49:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weAEZNIgPOHi4iK20YcX5b6H4P+s/wUvED7jam7tEDa8/oLJRxVAQr/gkSxSH0oNpVD/IOR2gi9swlzk6uxbjT6uNG1SwEke23TLZEZAcTxZOuj3VTzuVHWxCMvDYWArFsPkSFmNh9sNqmSLW7yLHQskKCXn8dgkba5Pb24X2OJvm9tA49rBytUnKbaUe4VWb0WWlg0BBV47EMxQZoL52a3aDXT2yQfV895H0fWgODD75kFEtC/BjzfPZJIAlPtKKNwcBUHq9E9b6lkQ7q3QmBdpUa26QwG4nZIaw/YVHpFqEiOMjkacygSm6DqckQC1DW+OMUaAq43++BZzlg2xfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+caJPEUbNUaSekvc+2XSeGFFlWplnMQp5tjJAUaeBIE=;
 b=FhnV0b9ELndaMKSq4rztVpCwkR4IvzHPj0NN+ZO8VPw0F5ns6yRSzspsisoeRcM7cqoyrXhryhfTbmXRO66/dxfO66baWaLezihoAaNJLnABgTR1bNTA6Ox20NNSeSM9U07z7iL+z+UNOwIAMcJ/X7VeSCsrYXY1P63riQNgEONz1cZahhHm224JZMeiBYbRKH5uuGBKDBjxYdwTt00+SVE+LKyqY1IzsHMGKrDN/kJu82PNH6dlyw3sN2bGCU5CCkRtVDY/RYXCoOdJJ6Zm0yPFTimtikZF+LUaqr68BbrndVHVf8BhoFY5aS8GKk4Q7HcY4pY771kRW+WBv/J9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+caJPEUbNUaSekvc+2XSeGFFlWplnMQp5tjJAUaeBIE=;
 b=MXXL48ubtjE5lfGdlR502HPeHOi50ewEmYsRkSMMfqNHvVHAsRGfdZwbQ1X3l4h4q3mI4cinUIK86RCfms+dt6AJaMISAQoQWlG8qWoQ5T9yswjpzKK7g4tV5ht+N2RfiPt2IK6eciR5Akb6G/mbxfXKONGeQj2wIv3CTBX/MII=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by IA0PR10MB6793.namprd10.prod.outlook.com (2603:10b6:208:43b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 18:49:02 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:49:02 +0000
Message-ID: <30afd779-b648-4562-9bfd-18d02f21a864@oracle.com>
Date: Thu, 17 Apr 2025 14:49:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 07/13] microvm: support control method sleep button
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204236.2977-1-annie.li@oracle.com>
 <986226f4-e6ce-491c-a9bb-d1c2bcfd1e43@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <986226f4-e6ce-491c-a9bb-d1c2bcfd1e43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::10) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|IA0PR10MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1c7565-7844-4bab-0d48-08dd7de085ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUVsNmtZMjNYWStYckN3RjBMZWp1VkkrY3RFVG5oRjgyOHJZeEJFRmxadktL?=
 =?utf-8?B?ZSswQUt3TExRUkh0YzdmTXlRWityNEk5VFNvWVkzeHhHQnBIYnNPejZoRGIw?=
 =?utf-8?B?ZU9XbEZHRlN6S2p2R3Y1UEdhd3dXRlZjSnd5dmZXbjY4QjB3NDRVdlUxRWZT?=
 =?utf-8?B?ODgxQndFdC83WUV1T09WKzc0amF0OGVFTk1JdjBhM3NSekZxMERXOFJDSW1v?=
 =?utf-8?B?TjF2VzQyajlpVTBMVDdZUXA5NTRKR3JtblRQazl5d3Y2Yjd1N1E3dldNNlQx?=
 =?utf-8?B?aWprNS9jRW1SRm8wOENRL2Q2cDZ1QkhQTitNcEwxL0RUZHM4d2NaOWs4Rmpt?=
 =?utf-8?B?d3VFWHdoZEZLQmRoaWE5alh1UmN0RTMxQXp2YXFMUlVnNFZKbS9EN1o4c1Bt?=
 =?utf-8?B?S3NpUlc3dmpXYXdiZlA1VHRNM3o3bDBLVEY3bmtjR2hidlB5YWZJWk1jRjho?=
 =?utf-8?B?QUJMZUlpMDRvdGpKaUhEdXc5Nk43WnVITWtCYnZaclVBNVcrUHUzRnBld1l6?=
 =?utf-8?B?dWljYlEvV3hndjhjbDJCNFB4NGRWdVFSV1hnUFQ2SnFPb1M1amdaVEFmeHlB?=
 =?utf-8?B?cmZ4TEpzZ3NJOTN3ZjRVVDU3dkFHdDY5YVYrQWh5QzJ2Ym11L1FrYWRCOEJ2?=
 =?utf-8?B?b1BzSWpMRW1DMkhOUDd6VzBYQ0psMHZuVFpUZ0oydDMwdURydzBOYWJXQ1ht?=
 =?utf-8?B?WHdnRmdTbDRTdFhMVnhGUW9rMi9NRHJhcUNILzMzSlpidGFEN2lYbkJObjYx?=
 =?utf-8?B?eFk2djRUVTVJMkRhRzFIY1lBek00TzdVWWVXRUx2TTMrSHdxQ0o3RWFmQ2lh?=
 =?utf-8?B?em05cXpBVVFwWVlPcEpHZkttaWp2cFhUL2lOamhQVkNFaGQ2K3NzOXJERTFv?=
 =?utf-8?B?bDlRbElnVzBjWTZQRU03d0hXQk9EQ1dGZ28wRHh2SW85UlFjUTFNNmJrM2VD?=
 =?utf-8?B?eGkyTjZ3Y0Q5UWp5TlFmc1F3NVBVYnpDSkNNN3M0MEdqQXY5SUpIZHRadmNH?=
 =?utf-8?B?UHFTRTRYYzVIaGtEVDVuVlRjdEZtYlVQTVVGWFFhYTdzU25ERHpTTWVMNVBJ?=
 =?utf-8?B?NENKSFJUYm5VWDZtdUZmdGl3K2k0SHdVOUNPMUZNUmp4WlBVODh5bHM1N3Mz?=
 =?utf-8?B?RURpYmJHMXdsRUIxeUliWkNkOVZaWU1VdnIrdTBST2M3V2xzN25CQ0ZhQWlM?=
 =?utf-8?B?RHF0cHVsbFU3dm5sNnZxRWZjaDJ6MmwvaGszVjkvVG5vSUh4YVlLM2tCaUJw?=
 =?utf-8?B?VEN1ODVKalpRM1B4ZnhLZHlLTTFGVVJOSEZwU1ZzY2piaTBNK2FXTUhkNEZB?=
 =?utf-8?B?bzNxQk1veHdacDVIK0RBTVBqa1RJSHZoUUltZVgxQytiNm9aanl6VUU0WXk3?=
 =?utf-8?B?RzMxenBpc2IrNVBGYkVvMlRGcHViWjIyVnFZY2dSS1JsOVVuYkpsK2k4RWxF?=
 =?utf-8?B?YlpaWDMzS3RtSERxcUZsd3FCSHJCMWhlTmNmYS9kNURkbDVIN05Wd1doNmsv?=
 =?utf-8?B?MTVPZkhNTTRFcXkzRWZnTWRZSlQrTTREMjIvS2x1U1gxSkFBV0MwWlh0VUFJ?=
 =?utf-8?B?VHRSd2o4eENCU0IxNnNMcEc4Rzl3cyt0Zys1SThQby91U2Q3TUk4cGt1Z1pW?=
 =?utf-8?B?OGtjdUhaTzlVSmg5RE9CcmpxdUVCMG9qdUE4TkpFeVFhVlFQUUp2b1E2V3Bs?=
 =?utf-8?B?c2h5dFc5QitCd3cvdmdmVFg2NTFTSlliK0kyM2FHc2wrMmpwckpFQ0Fadm5r?=
 =?utf-8?B?VzFrbmVka085WTUvSlNkTDZJMVUyWCtIQnN3RVFxSG92U3VtM1E4MkN4YUt5?=
 =?utf-8?B?SGs3TVlwVTNkOXNTZmpJbEcwKzdlVDk0N0xyTENiN010MGlya001RmxpZzNO?=
 =?utf-8?B?SXBRQXZ3cjhDVlpyYkd6VzdDMTg0cE5CMExhN2JOUi9VWGF3ZnRFdUlWak4y?=
 =?utf-8?Q?MT66r+j9z5M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVloNkFKOXdqdzFWQUhudGYzdkp1RUExNlhjMWEyQ1BRNnVpWE9ycG5QVnp5?=
 =?utf-8?B?VFNNNjNJUUVKNFFCTzcwTE9KYXJPeUNXWkRyM1VTRElLa1RjWGlIYVZWVFBT?=
 =?utf-8?B?THlLSWtHb3lCdU8vT213Z2IrQ2w4SlNUWDkyUHFSS0ZPUGhmY1M5a25tb0lD?=
 =?utf-8?B?OVRDUzhDejE5N1UvWWdMWkR1RVBrUEU4blBpWjZ1L2dHejlPWE93cmtXZ2xQ?=
 =?utf-8?B?RDRiaFovNmZ0bG51RnZoQXNZN2gxQ3NTd0tQY29tWTRVU3FkaFBPZ2IzS1pt?=
 =?utf-8?B?bkpmK21VWE4vU0RvWEx0Tm96emhRbDBucXVJeHRnTzJDOGZsQ2gxRGNhZ2hs?=
 =?utf-8?B?N2xZL3JnUFUvSlVsZUZqdkhQRWFFWHZ5SSt2SmV4YUsyeFJTczdUTHFJYVFx?=
 =?utf-8?B?aW0vckFmQmkwV2tZZHBNN1VHdnJFakNBNEw5NkNqS1Baa2hCR0hDWUV0cHh5?=
 =?utf-8?B?Ny8yMXhESzJyWmF1clRtdGRrZ1g3RDdSTzVEN3VJL1VZVFpSZVNnMXRqbWhN?=
 =?utf-8?B?NEFKandTMTJ1RXJ0SDVpSlYzQTBPMTN4cEFVcnRjVThsSGM4VUtIQnJoY0JU?=
 =?utf-8?B?dEFaOEI4V1BKamI0V2RxZ3IwVlEyNk14clBEQUY5azVLQzZPZ2pBZWFVakpX?=
 =?utf-8?B?enpMc0J3YURlYnpjRjlyMXhGSUU0TWJLMUx4WXBaRE9xSXVZR2NZUzJqSDho?=
 =?utf-8?B?MDlibnZ0Z3g5ZW13VnFxMjFpbHdEbWhOK0dBQjMzcDF2QmtEdnpFVW1sQnBy?=
 =?utf-8?B?L1l6QzIrTk1OKzVrbjNlRjNZMnQzNlNWMjZIUEZ3Ym9ZMzEvdkhFM3ZNdzZN?=
 =?utf-8?B?dGtYSDhQK1F6MmRmZ1dROXI3QlQwTGZHZnllSFg4cHBPRkFtMEhvSW9meFVQ?=
 =?utf-8?B?eFdFNHZDdzY3Z1ppQ1poNDRKeWdvVVhDWUo3czRLdXFhQ0xORHRKeDlkci9D?=
 =?utf-8?B?cnZ0ZHVNc0x5TTRkTEFHSEVWL3FPZ09RTXJxVGVqdUlDVmxwaEVUNWczcU8v?=
 =?utf-8?B?S28wU2w4QzZzR1lkYVJEWGxTaWZYNGdnOFdva05obUo1S3NoTjhQWDdCWVF6?=
 =?utf-8?B?TkxpSlZZaXpJL01Rckhnb05UNGVBTWVrVGZzcVcrUHZQcDBNeHhHUWRFaVhE?=
 =?utf-8?B?c0owV0xIdkxOY1lIbi9jdjg0dWNlelYzMkZzbzhRTnlHWDl5STFzbVdBejYz?=
 =?utf-8?B?eERCc0sxS041MSs4bVVuZHJuLzFwL0ZTUjcwUTIyaFVoV0l2b0lid2tuTThU?=
 =?utf-8?B?djJXdkUxZEQ0d3BOd0lZQ3BsN1hIQ3ppN0lxaW52bmsvTGZBOWtoMHA2OC9T?=
 =?utf-8?B?ZGNvRzczSmJzajJ2Njd3eVc2eERRM1R4OHpDRk8vbkdReE4ydU1Ic3dPeFU1?=
 =?utf-8?B?cEZhcEdyTWdIL2svRUF2YUh5NDFvSEk3VUl2ZWhCZCtDRjU4dzcrOGVTUHFX?=
 =?utf-8?B?bnQrUmszZVNJLzRTUlczUVVrajV4Wk1FUm9lYTJTcVhNTThKUnNTZEZOUHVa?=
 =?utf-8?B?SGdQd2kwQ1dtME93SDFMNEhXck91V2hhS25Ma1BxR0prV0JxU2xoMFplWU5E?=
 =?utf-8?B?K2RzV01lcnR5dUN3UkY2YUhqakEyNk80RVkyZ3dBcWJLN0lrODB0Zmpkc2t6?=
 =?utf-8?B?ZDU3NmFYbWtXRHdMcDFiYzlCQ1dzUFJJaXZXS3M5NUZhQzNJSkg5ZU9wcDdi?=
 =?utf-8?B?VU1kWEUwUVUzZ1hvaHJCaWMyTEhtVXVha1M1RnVFRGVnQmVWZWZqZFhLSi9M?=
 =?utf-8?B?Ynlvek05ZkMvL292dkJQMlhQcmwrZTZKaldtTmI5bnY4YWlPak9waThNa0JT?=
 =?utf-8?B?ZTg4VzBkUDdVL2lpME16Rk5aQ2ZnWTdBTFM2TVRsc28xMm9nTXJXU2xVQkEv?=
 =?utf-8?B?Um92WkptaG8xcHJiZEx2MFdJTkVIL0lrZFd2aEhLOEJWTGlzZlRWQWN3enl5?=
 =?utf-8?B?RFo1OUhXdWJBNWp1WDZKTWNRTG1EVk1POUMxK0NXdzFsdVQ3WFk5dXNXcHNZ?=
 =?utf-8?B?N1ZxZk42RVNva3FNdjdtV3NSVFcxKzljQ1I4R05iNlNJZDkzbzNWSmhNcW4x?=
 =?utf-8?B?bWR6RmNDM2hvbUF4K1FDQnFsVDZwTFhOdkt5VUZRRk5uN2FFVmxnRWhoUERD?=
 =?utf-8?Q?KJR7v2x8AOPLyJUS9C1tCioJp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UlBkvNRiuvli2cT/OXmr5OB0VJ4KbQCnmG4pSX8L6CrtgZYGmtmhqDOfsfiV6qRiujFhq26VeaxUxhbGXZfpnIVaJHAYYSNPvAuPq/JDxtHr//g1w5Pebn296hr8AT76vwnXsGbmW1KzikmE9pNF1tpfhAOWVi5uht+uRintybpGi1gPnDdcuFjA4CL+7LDehty48hkgA8ZPjfFYD1/k97JFCPYjn2pTbiI6YPoOUCZtY8/se3joPt++e2YJSFyDA/BtD0Hp9NbxLH30uc1tzWWfjDcJzGlpau81/4YjdBVz/eQtgbmBTU+mxrXTy139RQyqXBBYFSB0KB6MB8A3g6FKBX//655a0KW39rmSs9QZimT3NG9Zb2Fbm2AGJ5Npnvxj3rTPOHN9pzJ3tXbSXZRDL5Jxl5/0dkkloUdGYGDP0yNt31XF+t0NQcWzydK/yhM3cwAMV5E6iqs+R+y72T8kZxxRbbrHnjHfO2GqDuCN129zNKekVRHdeeETtsHbh8NamPwiEEuQ7ij/n9oHxb4x3//Sd79TTckpHR8c+ASpOr42joFfvYdMyh2LjjtixsFWSxXEATjoo+pzv/SEnlMIwjZZOSnKFHjvEc2UAys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1c7565-7844-4bab-0d48-08dd7de085ab
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:49:02.7277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiGOm1XN/hgdPn+lq5/HatDVVWu8yDoMA+PG3OmUzFJel9kp0eTj8r5mSgi8nvCC/QYUPCW3W4oTeLFV/5TRTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170138
X-Proofpoint-ORIG-GUID: iDt-aCj_UAnRswAS57C-KzLDaW5ssL5N
X-Proofpoint-GUID: iDt-aCj_UAnRswAS57C-KzLDaW5ssL5N
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Gustavo,

On 4/17/2025 1:34 PM, Gustavo Romero wrote:
> Hi Annie,
>
> On 4/11/25 17:42, Annie Li wrote:
>> Add the support of control method sleep button and System
>> S3 Sleeping State for microvm.
>
> I would say "... of ACPI Control Method Sleeping Button ...¨,
> the important part being "ACPI" to make clear what's the
> context of the support. Because such a device requires
> also some plumbing in QEMU code to really be "supported".
>
> For the title, maybe smth like: "microvm: Add ACPI sleeping button 
> device"
Ack
>
>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hw/i386/acpi-microvm.c                 | 11 +++++++++++
>>   include/hw/acpi/generic_event_device.h |  1 +
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
>> index 279da6b4aa..57c45ea327 100644
>> --- a/hw/i386/acpi-microvm.c
>> +++ b/hw/i386/acpi-microvm.c
>> @@ -32,6 +32,7 @@
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "hw/acpi/utils.h"
>>   #include "hw/acpi/erst.h"
>> +#include "hw/acpi/control_method_device.h"
>>   #include "hw/i386/fw_cfg.h"
>>   #include "hw/i386/microvm.h"
>>   #include "hw/pci/pci.h"
>> @@ -123,12 +124,22 @@ build_dsdt_microvm(GArray *table_data, 
>> BIOSLinker *linker,
>>       build_ged_aml(sb_scope, GED_DEVICE, x86ms->acpi_dev,
>>                     GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
>>       acpi_dsdt_add_power_button(sb_scope);
>> +    acpi_dsdt_add_sleep_button(sb_scope);
>>       acpi_dsdt_add_virtio(sb_scope, mms);
>>       acpi_dsdt_add_xhci(sb_scope, mms);
>>       acpi_dsdt_add_pci(sb_scope, mms);
>>       aml_append(dsdt, sb_scope);
>>         /* ACPI 5.0: Table 7-209 System State Package */
>
> Should this be "Table 7-205"? Or even, why not:
>
> "ACPI 6.5, Table 7.11: System State Package" ?
Agree. I should have updated the comments here also, this was kept
from the existing code. Since the ACPI spec has been updated, the
comments here should be updated also.

Thanks
Annie
>
>
> Cheers,
> Gustavo
>
>> +    scope = aml_scope("\\");
>> +    pkg = aml_package(4);
>> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S3));
>> +    aml_append(pkg, aml_int(0)); /* ignored */
>> +    aml_append(pkg, aml_int(0)); /* reserved */
>> +    aml_append(pkg, aml_int(0)); /* reserved */
>> +    aml_append(scope, aml_name_decl("_S3", pkg));
>> +    aml_append(dsdt, scope);
>> +
>>       scope = aml_scope("\\");
>>       pkg = aml_package(4);
>>       aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
>> diff --git a/include/hw/acpi/generic_event_device.h 
>> b/include/hw/acpi/generic_event_device.h
>> index d2dac87b4a..28c5785863 100644
>> --- a/include/hw/acpi/generic_event_device.h
>> +++ b/include/hw/acpi/generic_event_device.h
>> @@ -85,6 +85,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>   #define ACPI_GED_SLP_TYP_POS       0x2   /* SLP_TYPx Bit Offset */
>>   #define ACPI_GED_SLP_TYP_MASK      0x07  /* SLP_TYPx 3-bit mask */
>>   #define ACPI_GED_SLP_TYP_S5        0x05  /* System _S5 State (Soft 
>> Off) */
>> +#define ACPI_GED_SLP_TYP_S3        0x03  /* System _S3 State 
>> (Sleeping State) */
>>   #define ACPI_GED_SLP_EN            0x20  /* SLP_EN write-only bit */
>>     #define GED_DEVICE      "GED"
>

