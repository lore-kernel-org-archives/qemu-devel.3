Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F61AC531DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seydy-0003HI-OL; Fri, 16 Aug 2024 11:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seydx-0003Gf-Qv
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:13:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seydv-0007Yk-JN
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:13:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GC8s8n011794;
 Fri, 16 Aug 2024 15:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=4sF7Sy4HhwmhKDCDkr5gSVHUrXhXVdh+Ni3KnV3EJUY=; b=
 K/PX5A37d1MlOmQo5th3QIQTeVORKkVupHfC/RmJVnZG6Fr8j4eOcHen8ufvkcHN
 KxhTufapjJylqZP0xFZjtTqtyp8ThKoPrnkmHD5zmSI5H6h+pMQW9gXpZVgx6+Ui
 EYJuOi9rn8IlszKZQ82e+IlC2A3PlGvWnunAUouIXHYZuUV71IhTU4yAlAd9h04J
 0g8+8+yllTT3NOgbJGSWztbp/V2CW0nCa843ne2dXsQsuFZOr0ocHqYnQnOAlQdO
 IQ9b4T+rUa8rsXiQxgd++/EGfwUom2G4Wqf9qbG4TrDeZN/TAsjm2ILkTJhLW7w1
 1+AjOXzXMwjQrKwmMYX6SQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wyttmttq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:13:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47GEe8jv003378; Fri, 16 Aug 2024 15:13:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxnccwtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYXI7U0MLpi8oiXw++TlPtatI408wJG6RLcr2LZop/zY/dDb3ecFK+0c7MZN+4x6XCgc8xT8NWmR0+C26373BbE/yAgUZGq5itmFDqhg10LdIEVcIRsdtdb9lxvOqLu8YA9RJyPapXz78JBjTP4pe4v0o/ElcRlRAHD25EnSUEdy5EhsedmyxD0C5wswf8stn9ND4dnMZlZ13dImd8lo7lNYCndYRVs2Y62sUOVgMFyD2hqlNWYlcocb2EHeWuAtNCBve7OrgTNBW/k6kq2//nBPa1VzUISbv9ZfXbCCQ71czQHzUAhfJ1Pf3RVDTolGO7gVZla8Pg05dWSiN4rRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sF7Sy4HhwmhKDCDkr5gSVHUrXhXVdh+Ni3KnV3EJUY=;
 b=g6cgA6sEZdW2tI1E8Zx8dUxUYY+0m7AZSFcSkU47deIlpQpyi4QKxeczD48RvJrg0dk0uSTlDSV/wtGjmDWYuMiiPWtBtLhIFe+jcOQ2BuyYPsHTpX2iGsosJj28WdwATnLkb4MEZKIqwMzcnpyiwGUAEtdojx7qFItbVxSlwk/fod5Ru4zCiamYwYDVa0NGxlTw/o/3Bpv2qsclcpHAE75tOxZiwxtdU3ga412X9Q+AFfkMCbwG5CILaeKjOMikheaHGQQogpYnM1dxX5e8nqaxFZbDtHJTp67J7N+g5TLPO1uPv3tpTkN1pwX9UVJLYtjXa3gNTmu7441Q4M5y1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sF7Sy4HhwmhKDCDkr5gSVHUrXhXVdh+Ni3KnV3EJUY=;
 b=rMct4hGu/tJWL/xG/ctVQV1tjfRxelecRBCiNFX+RUC8FuxgIYUU+ewDeOg+3xHxCEZpyLKqDDBwkimORvwfkpusNX6llnJRcivjuddrBdzzSAGEjv7P9N3zFkGeezB3RIawjbCQzYs24yS2RluHEDqMVsDVpMlRVx2qMJZZ6Kk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW5PR10MB5667.namprd10.prod.outlook.com (2603:10b6:303:19c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 15:13:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 15:13:24 +0000
Message-ID: <92e5309e-9b16-4cf4-8ffb-e1383201cbd0@oracle.com>
Date: Fri, 16 Aug 2024 11:13:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 1/6] migration: SCM_RIGHTS for QEMUFile
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <1719776648-435073-2-git-send-email-steven.sistare@oracle.com>
 <Zr5r4_lyKAPVZY3Y@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zr5r4_lyKAPVZY3Y@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0351.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW5PR10MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 6657570b-4380-44ae-f114-08dcbe05f93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEliQnBJS0FqTXFJRU10NXJGZzZ6MFcrWE9CMDNsUDh4YW9VeU10NC9JWjZJ?=
 =?utf-8?B?MzR6ZFJPT1FEUVc3RmVGTzdEbE9Qc1ZHclhiRkI1cWJKMWVpNkd3cFVXNUNx?=
 =?utf-8?B?dkRKcTBoVXRDRzRvYndKNUQ5YUxYOVRMUmFRZ2YwNlMycXkwTy9jYkV5QXBC?=
 =?utf-8?B?b2FqbVI3Z2tiMlFFMnEwczJaK1VreFlnb3RYWWlYT2NnSElqdXgvU1RYU2Y2?=
 =?utf-8?B?N2VlV1hJZE0wOEUzR1BGWmxsbGF2Tyt2VGZYQmo1cmtkQjlxay94S25CYnRv?=
 =?utf-8?B?cjAweldNS29qU0FaRjBhYXVDL2tLd3hNb1hlZk13WEZ1U0lvNjBqUnBQQmtj?=
 =?utf-8?B?aTBHNzBlNGJYRnhEV29jK21abVZYYXlmK0swcnllckdvRVpoUXJWdGpGcHlD?=
 =?utf-8?B?d1NOMFdIVWlkQXBHZWJlb254bGRLUVp4ekFLRU1UdlZLVUVhZVVyY3c0eHZO?=
 =?utf-8?B?WXNxUUJ3WmtKeGxhNVIrdzVGVzJGY1I0M2NSUlR1NWpoZ2RiWmVvdFVPbXhW?=
 =?utf-8?B?dTlpWnY4MC9DdVN4b3JVZTA3OU5sd1lXcm9pQ1did0JUQXJGVVlybDZIcTUy?=
 =?utf-8?B?N2tGZkdtOEJCc1lOVHpJemNGbnIzaTAzY2p1ajZMTXc2ZzdFZ2cxTGJ2ZGtY?=
 =?utf-8?B?SHRnQ0JZdVRLbHJuS3BsMDBocUFTaUw4dHJNN2c2MjQ1NU9DZWtNdFF4akMz?=
 =?utf-8?B?UUFRTGtYZVFyamh1cDRyWktkd1lGV0NQZEhDQ0FoRkMxdVJ6NnVXTGw3S1Vm?=
 =?utf-8?B?S20rcG9BL2ZJSXZkQTd2eSs1SmludkpTVDhwb2JsWko3bm5CVGNKbEJuaThZ?=
 =?utf-8?B?ZnVpbE9VYkUwRFJ3dTVZV0RnM3lIVElwWUtaS2NiQkRySGM3UDNzRDRvMnBv?=
 =?utf-8?B?c2pSc2lqR3A0K25zVkIyWDBVU1phYWdsb21kdzkxY1pncjdVUG55VTkzbEps?=
 =?utf-8?B?MmdMZnJueFhqN2pEeDFMSFFwTUZBblRnZnVZb1JGRkdPRXRaYUNlSEp4REZh?=
 =?utf-8?B?aHdCNGxocmVtR2JzY0luVi9hR0I5ZzVzMmozRnNEVlZkUURramUzcjJZM1dT?=
 =?utf-8?B?K0pXckhrOXVnN0RyeHU5blVtL3M1SVo0MnQxZW9lTXJLN0lSaUpkSnd1N1BX?=
 =?utf-8?B?M2E1SkFYOGFDVVhMQktBNjRHckVIUkNmd0dvNHZxUkVtc2huQkIvVWZSSjFJ?=
 =?utf-8?B?M05aR2s4alhMWUNrMmExaFhuL3QxRXZGdWNlMVdLQy9pWnZzMVJiNjFPQURa?=
 =?utf-8?B?VnVPU0M2V090TktLUjJtbThFUUYySEdWSzMyNTk1MVU5TmRsa2FpbWNiTkJW?=
 =?utf-8?B?R0t3RXY3SURYVytjL25nbERFNENuY1BrRFY4SWw3Vm5SQWp4RjltOE5YSmEx?=
 =?utf-8?B?U25oVDd4OVdxcDNVT1F1ZkJUaEJQa1N3UDg5L3BqUUVhRGJiRHZHS09ZdGJG?=
 =?utf-8?B?RG1GMTRRRVNMekVnY2ozdURrc2xhQ2ZqMGxJMFRGUnl2ekcvNzRPSTNiaHRT?=
 =?utf-8?B?OVVFcHhyTzFlNTNQVUY0U3YrU0lYOU0wSGttK3RPdElGbHJUZmg4UGdaa0Vp?=
 =?utf-8?B?QmJsSGVDdURyRmtMVWFNTU5XeWRiZVNMYlduenUwWVhvd2tjaVdnTGVOTmR2?=
 =?utf-8?B?d3kzUTFNbjF5N0djN3N6WEhoNWliNDhmODRxdGVESkQweXpCWVBKQnZFZm1z?=
 =?utf-8?B?MUttSHkvTmxFMm9GMmt6RnZMeXZTNFR0MWx1Qm9tQ1FML0RKK2IrQjhFdVlM?=
 =?utf-8?B?dGs4akt1amVLZGRYSWtYL0huRVdmby9BRlFLMHphUjRteitTdWpFTmhqR0Fa?=
 =?utf-8?B?ZHViSW9HSzNpNE83eXFjdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGppWUtBUUMyM2pvM0N4blVDV2Fsc1pTTnREQTlkaUpEVk1LZVVZbXJpbU1E?=
 =?utf-8?B?REkwTHcybElxRnhON3dGZmdyM2UxQjUySmJVUWw0T3hGc0RUdmlzOXRaR3U4?=
 =?utf-8?B?d3hrMUJjQlRHOWdLWWFVOW9JMmk1T1Blbk1WbU1uejdDMVJydkxzM1UzeHp6?=
 =?utf-8?B?WVZGWERqYXpkNkNNM09QdUtqb2NjVWErM0l2MExGUG9LZjNSU0ZPR29IL0pD?=
 =?utf-8?B?THUrQXdZWk9Mb0d4enBwMlIwS1JQRWNaaStzTTNMcjc0Z0Y2R1dVdktYM1Jm?=
 =?utf-8?B?NVRaSlJTMzZDQmhBbmxUSUNpbjJtMEVldmxOK2w1UkkreFNvRWQwc2xYNjVB?=
 =?utf-8?B?UXJmN1FZM2I0Q0VnRHR5RkMzdERiVVZhblpycDkyRFBEaFZKVjl4UlNXZUUy?=
 =?utf-8?B?bW8yR2RmTGtxUUpCZ2c3RCtOZ0tHZzY0S0d4T1ptRGo2dy9MbnZOV3ZhL3VI?=
 =?utf-8?B?eENxYjd6Yy9EaEJ5L0NTSUorQUNXT1JhbDB0RzNlWmFpdjB0YUFLQTZtOFJQ?=
 =?utf-8?B?dkVVYU5HK29sYm9iVmgvdjRTQzhZK0k3UGxOcXdpcDVyTkZHTkljUXdFaTlW?=
 =?utf-8?B?VmNhUVNmZEZ0clVHTVNVUERDaTNnRFRpdnE5Sy9FK3JMdUkvcE5ncDRNTkNK?=
 =?utf-8?B?TTFYbWpYVXo5bm9EYkU4amplYTYrd3pna3lUd2ErSzlVMEVtem8xZXEwZnJW?=
 =?utf-8?B?ZkgvWC9PbjNWRUJzMmZoMzFFTFd3aGlhNkFkTWdhVENUb21hWGMvTmVvc0hi?=
 =?utf-8?B?M0NMWFczdDV4NGJNNE83T2NQdGphM2dJdHdGM1dpcXdZQWJES0tKUUFLYmhr?=
 =?utf-8?B?TWYySlpNMXFROUlFSWo2K3pmeEZyTkxHRWxtbVRuR0xrVWVVdUlzOUZLYUZR?=
 =?utf-8?B?RVhkd1BudGpHUjZxMFlqc3F3U3JxbTl4Q2dPR0NEbDVkYUlQRjdwSW9yck1V?=
 =?utf-8?B?WG91VXlKb2ZvUVYyRGJLTlU4Tmc3bWptR3QybkRHMVNuM2Fla2JyNzhIS0lY?=
 =?utf-8?B?T3hQeVh5STdFUkhSaEszUllDRUszeFZ2c25iNFdsOXVTZ1B6eG1VUkJYRy9t?=
 =?utf-8?B?RDVVTmFDQmNSTUJJeVJudHpueE5Yamx4OE5DMWZsdloxVTBxTWR2U1B6YlBs?=
 =?utf-8?B?ajYvRTg1cXJYTm1wakt3MU5MLzhTZlVzUG5pL3IrWVBSaXY3NGxaSWJZbTlr?=
 =?utf-8?B?NGJpLzRSWmtwSUJRaHI1TW9BeUdQeXhwQWM2bkQ1SVlJYi85cStWUXNzKy9D?=
 =?utf-8?B?NmIyL21valdhTVgwZUNhRmI4ZDNNWGhvSDlHclZYZEhWUFIxbmRCczlIb2hx?=
 =?utf-8?B?Y1JXZmZkWGhYZFdJa2RHUkNUWThDNE5YajJnSDFtSkFMWXVLOW1XOEM2TldB?=
 =?utf-8?B?d1pvK0VMMW8wWHZPRWxLSmpSRjNmSTEwa0xVb1FieFVVS1dkaWNZY1U5bGQ1?=
 =?utf-8?B?RFNhQnpmeGhRc21FQTl0K3haekhtd1oxVE9ic3EyRk1vbm9sQTlRMXVTUE1Z?=
 =?utf-8?B?bTU5MzBWWFRWOGhnTzFCMHdXbVpXb1FXNWJoOHZDd21pRmU2N0RrcHpOeWc1?=
 =?utf-8?B?bjlEQVh0MCtNVTJnQUMvNGk5VU1HUWlLdkw1NW1YUURxOTJoOFBnRzM0VGFY?=
 =?utf-8?B?NWx3MHNncjRobzVtSWNoSU1XZjM0czBWN1JkS29Kck9DdytDMnlXa01GVWJK?=
 =?utf-8?B?Z3hFSzZMamFFNVVTcURWTTAvZVR3Y29VSmR0b1lUd1JPVDVrVDlQWVJkNkNj?=
 =?utf-8?B?UkNyUHNJSzJ6NXJWbHFFZVNYSDlWVkRyM2FVSU8zWmd6MEloVm9OSDNMVHJk?=
 =?utf-8?B?cWdIQkNOSU01Q0pxY1JMWWYzRDBKNmdzc2ZYZzFIUWpVYXI4QnV3VXBmaHRq?=
 =?utf-8?B?Skh3d29MaFNaMEhuaHlzcGsxcXNONU9pZUlGaUs0Skh0WkpON2o3STkrcUg4?=
 =?utf-8?B?eXVFRnVESUVoU043aTZJWWl0VHJwVHZ2YTgrRW9qTTZqRE15MDhQb3A3ZWFG?=
 =?utf-8?B?bDRIa1FOS0hoN21SZ0dUcnVzRXFwc2ZDRTdxUkp0TzA1K3pGbkpnU0pCTlJS?=
 =?utf-8?B?dTJSdnBNV1F1MGR5RHhFRi9DdzE5eWxQOTk0Qlk0V0lkaURVOThtb0ZFdFdh?=
 =?utf-8?B?MDNkMGpvZmJpZXM1Z3ZmM1pETGgwemZvSHgwY0JZbEUvREw1TWVFTkVacGsv?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zemu6C3bd/QgEeOKmfm0rWEz3RAmHgVlpzPnHEC8BxRAUBXaNTD8j6+il8cSRbvbR588TiESochZ6bQqPq/tQ2Vd2h+SYxPTP/qeQRnH5p3sHYaEgnjNwgKJ63CHlK4KqQMfllkSrxfvAL2Xv/KhusGp+uI2hijn6u0f7kg1wVr3VJZgE++G8tfEuuxrCBWEeRMx2EBOfMwtS2feKLbwVA3dCPrD46rVOwXt0Aey8eVVr6VN0HovVwEhYwWIQ8bpwz9FmH8ZNMVt1RD6hnXp9ymyQWrhphkVUerPO5opkHhldejfnt77Eu34c6vx3FrmRFbAGxYcTWG2neraqn8sllXFmLL/jZ7fHa33ql9IPek8JRjM4IvigejMAGyFOKYN9fnQ9hFiyEqkC0x1nzQNkV+3r5Lzt1tOR9JuRiKp5FwMbTsWUuqIYqSK+yQAt02JiKno8V+CF6an42tuZBaYgnAJVXVXGZOTaTqDAb019YQ2HE1aOQdEdrnW6EPZ1camH8jS/JhHkbEH349bXQsO2j36Km/pbIFHJ7WWPZ6APWo+AVFr1CwZ2tqGMXhBKCWpIOvrO9nRb0wo0rC0YkJj+gG+bJPREFAoDWA2YmweGwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6657570b-4380-44ae-f114-08dcbe05f93d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:13:24.7259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOaE1/EmfTs4FTg8qSIn+PMcuIeCn2L/wxRVb7/cNEiVju9TdBSd0X0AayR2w2mUyeYRgvOlaWZRtaGX8Bb5KGrvtf4iZGnfka/dRc2IgVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_09,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408160110
X-Proofpoint-ORIG-GUID: Q6WmzfFWcNKUZgUqC4w_0M8TTXubiWJp
X-Proofpoint-GUID: Q6WmzfFWcNKUZgUqC4w_0M8TTXubiWJp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/15/2024 4:58 PM, Peter Xu wrote:
> On Sun, Jun 30, 2024 at 12:44:03PM -0700, Steve Sistare wrote:
>> Define functions to put/get file descriptors to/from a QEMUFile, for qio
>> channels that support SCM_RIGHTS.  Maintain ordering such that
>>    put(A), put(fd), put(B)
>> followed by
>>    get(A), get(fd), get(B)
>> always succeeds.  Other get orderings may succeed but are not guaranteed.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> It's a slight pity that we'll extend fd to qemufiles, rather than changing
> qemufiles back to iochannels.. for the long term we want to remove qemufile.

Thanks, I did not know that removing QEMUFile is a goal.

Currently QEMUFile buffers I/O in userland to reduce system calls.  Do you
plan to eliminate that buffering, or move it to QIOChannel, perhaps in a
new QIOChannelBuffered class?

If you eliminate the buffering, then migration might take longer.
If you keep the buffering, then this patch's logic will still be needed
in the QIOChannelBuffered code.

> Would you think we can start to introduce iochannel-compatible vmstate
> loader from cpr-[exec/transfer] here?  The idea is that we'd want
> vmstate_load_iochannel() then take that from an iochannel and start getting
> rid of qemufile API.  It'll already bring two benefits:
> 
>    - We don't need this patch then I assume, but stick with iochannel API
> 
>    - We can have Error** as last parameter of vmstate_load_iochannel(), then
>      as we discussed in the other thread cpr_state_load() can fail with
>      explicit errors without error_report()s (and as you pointed out, the
>      load side of Error** support is yet missing)
> 
> There's a 3rd potential benefit, and will come to play when we want to
> allow multifd threads to load device states / VMSDs at some point, as
> multifd doesn't maintain qemufiles, but only iochannels.
> 
> I'm not sure whether it adds too much to you yet, but I'm curious how you
> think about it.

A decent idea, but the task quickly mushrooms.  All of the VMSTATE macros used
in cpr.c would need to be converted, and that stack is deep. eg:

   VMSTATE_INT32
     vmstate_info_int32
       put_int32
         qemu_put_sbe32s
           qemu_put_byte
             add_buf_to_iovec
               qemu_fflush
                qio_channel_writev_all

- Steve

>> ---
>>   migration/qemu-file.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
>>   migration/qemu-file.h  |  2 ++
>>   migration/trace-events |  2 ++
>>   3 files changed, 83 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index b6d2f58..424c27d 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -37,6 +37,11 @@
>>   #define IO_BUF_SIZE 32768
>>   #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
>>   
>> +typedef struct FdEntry {
>> +    QTAILQ_ENTRY(FdEntry) entry;
>> +    int fd;
>> +} FdEntry;
>> +
>>   struct QEMUFile {
>>       QIOChannel *ioc;
>>       bool is_writable;
>> @@ -51,6 +56,9 @@ struct QEMUFile {
>>   
>>       int last_error;
>>       Error *last_error_obj;
>> +
>> +    bool fd_pass;
>> +    QTAILQ_HEAD(, FdEntry) fds;
>>   };
>>   
>>   /*
>> @@ -109,6 +117,8 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
>>       object_ref(ioc);
>>       f->ioc = ioc;
>>       f->is_writable = is_writable;
>> +    f->fd_pass = qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);
>> +    QTAILQ_INIT(&f->fds);
>>   
>>       return f;
>>   }
>> @@ -310,6 +320,10 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>>       int len;
>>       int pending;
>>       Error *local_error = NULL;
>> +    g_autofree int *fds = NULL;
>> +    size_t nfd = 0;
>> +    int **pfds = f->fd_pass ? &fds : NULL;
>> +    size_t *pnfd = f->fd_pass ? &nfd : NULL;
>>   
>>       assert(!qemu_file_is_writable(f));
>>   
>> @@ -325,10 +339,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>>       }
>>   
>>       do {
>> -        len = qio_channel_read(f->ioc,
>> -                               (char *)f->buf + pending,
>> -                               IO_BUF_SIZE - pending,
>> -                               &local_error);
>> +        struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
>> +        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
>> +                                     &local_error);
>>           if (len == QIO_CHANNEL_ERR_BLOCK) {
>>               if (qemu_in_coroutine()) {
>>                   qio_channel_yield(f->ioc, G_IO_IN);
>> @@ -348,9 +361,65 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>>           qemu_file_set_error_obj(f, len, local_error);
>>       }
>>   
>> +    for (int i = 0; i < nfd; i++) {
>> +        FdEntry *fde = g_new0(FdEntry, 1);
>> +        fde->fd = fds[i];
>> +        QTAILQ_INSERT_TAIL(&f->fds, fde, entry);
>> +    }
>> +
>>       return len;
>>   }
>>   
>> +int qemu_file_put_fd(QEMUFile *f, int fd)
>> +{
>> +    int ret = 0;
>> +    QIOChannel *ioc = qemu_file_get_ioc(f);
>> +    Error *err = NULL;
>> +    struct iovec iov = { (void *)" ", 1 };
>> +
>> +    /*
>> +     * Send a dummy byte so qemu_fill_buffer on the receiving side does not
>> +     * fail with a len=0 error.  Flush first to maintain ordering wrt other
>> +     * data.
>> +     */
>> +
>> +    qemu_fflush(f);
>> +    if (qio_channel_writev_full(ioc, &iov, 1, &fd, 1, 0, &err) < 1) {
>> +        error_report_err(error_copy(err));
>> +        qemu_file_set_error_obj(f, -EIO, err);
>> +        ret = -1;
>> +    }
>> +    trace_qemu_file_put_fd(f->ioc->name, fd, ret);
>> +    return 0;
>> +}
>> +
>> +int qemu_file_get_fd(QEMUFile *f)
>> +{
>> +    int fd = -1;
>> +    FdEntry *fde;
>> +
>> +    if (!f->fd_pass) {
>> +        Error *err = NULL;
>> +        error_setg(&err, "%s does not support fd passing", f->ioc->name);
>> +        error_report_err(error_copy(err));
>> +        qemu_file_set_error_obj(f, -EIO, err);
>> +        goto out;
>> +    }
>> +
>> +    /* Force the dummy byte and its fd passenger to appear. */
>> +    qemu_peek_byte(f, 0);
>> +
>> +    fde = QTAILQ_FIRST(&f->fds);
>> +    if (fde) {
>> +        qemu_get_byte(f);       /* Drop the dummy byte */
>> +        fd = fde->fd;
>> +        QTAILQ_REMOVE(&f->fds, fde, entry);
>> +    }
>> +out:
>> +    trace_qemu_file_get_fd(f->ioc->name, fd);
>> +    return fd;
>> +}
>> +
>>   /** Closes the file
>>    *
>>    * Returns negative error value if any error happened on previous operations or
>> @@ -361,11 +430,17 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>>    */
>>   int qemu_fclose(QEMUFile *f)
>>   {
>> +    FdEntry *fde, *next;
>>       int ret = qemu_fflush(f);
>>       int ret2 = qio_channel_close(f->ioc, NULL);
>>       if (ret >= 0) {
>>           ret = ret2;
>>       }
>> +    QTAILQ_FOREACH_SAFE(fde, &f->fds, entry, next) {
>> +        warn_report("qemu_fclose: received fd %d was never claimed", fde->fd);
>> +        close(fde->fd);
>> +        g_free(fde);
>> +    }
>>       g_clear_pointer(&f->ioc, object_unref);
>>       error_free(f->last_error_obj);
>>       g_free(f);
>> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
>> index 11c2120..3e47a20 100644
>> --- a/migration/qemu-file.h
>> +++ b/migration/qemu-file.h
>> @@ -79,5 +79,7 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>>                             off_t pos);
>>   
>>   QIOChannel *qemu_file_get_ioc(QEMUFile *file);
>> +int qemu_file_put_fd(QEMUFile *f, int fd);
>> +int qemu_file_get_fd(QEMUFile *f);
>>   
>>   #endif
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 173f2c0..064b22d 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -88,6 +88,8 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
>>   
>>   # qemu-file.c
>>   qemu_file_fclose(void) ""
>> +qemu_file_put_fd(const char *name, int fd, int ret) "ioc %s, fd %d -> status %d"
>> +qemu_file_get_fd(const char *name, int fd) "ioc %s -> fd %d"
>>   
>>   # ram.c
>>   get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
>> -- 
>> 1.8.3.1
>>
> 

