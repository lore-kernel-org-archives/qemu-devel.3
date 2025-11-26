Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3E1D111B3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 22:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vONod-0004Fg-Mi; Wed, 26 Nov 2025 17:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vONoW-0004ER-9b
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 17:16:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vONoQ-0000eq-7a
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 17:16:39 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AQJuDn83048141; Wed, 26 Nov 2025 22:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6Ij4vtAb+HBBWTMW4JatxDdLB8tk8VfZBTrHN9L+eKs=; b=
 mFRLSjpr+sNVK/3pbS8hBvGwK4Eyc08pxVTnWMLIgSxZBrf7Ul1O1BbQ2SXcTFpm
 9IV+4KH7o+v4g89JNvZ+mVzi+DK3XtvbFeESh0h352g/HrVE1Mnlw6Oj9mi+ucjw
 FbGJ3WSDtxYAelDwPz/DFX6weYJ8CAH4p1Hz5rXJG+ghCJ0ad4MylPB4IwTH9L8/
 eapLeNh++eS4cRg0Lf2gswRUeEwG03P5TRVjA6u+lQVmmTUU2OtQAdAKK1DaLQGZ
 /hNQTO6QF2jUMOdfJtAqWjXAgPJWjN2S9PyKG7+jwAfFAGLAXPNSE5ov4uNTXd1P
 Omc57OC2zYPnAspEpgLjrQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhwued-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Nov 2025 22:16:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5AQLUvo8018887; Wed, 26 Nov 2025 22:16:20 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ak3mbhq4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Nov 2025 22:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRiti1sphQ85tILqwikmBxiSNLe21Gjh5Y8+gnvbZwmCy7jXPSUdpU0trx1fwAAqtRLkPEfY2Z9TLXidgg8RgTqoGG8uzy8KmepclFqdh0SeJpJgkcnaFEDdSJj8+CtIAztn8LB8jzU+13D/akwn3oEMILZDjSBMMnfpCTjfqVdalCH81BhdViSQELh7khEDljqdo1B6qfzUyu34voySaDBfn7ykLBsNJAFZDzzKOcOn0ZkWEkByJlZ/54U/mHFSKYk1k6f6PMp/QhFSJyn6NL43rYrT2P0TMAZ5ZJb9DFk16rQY6vzDzUOk7DahidoWgaMYX0Un+xiHRse7tc2rbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ij4vtAb+HBBWTMW4JatxDdLB8tk8VfZBTrHN9L+eKs=;
 b=TzLNWUQOgt8ql1ReFw8wPyl5mnAT7oo8UMOvgoh/s1i8+MeUBe8KA9Ftyp6AzSSOgFfEfTW7BOI5YPXR9Kvxk3llIluq1y1q6jiN/olSBEVzEFzW8u5a3TQbMAUEZr3Miepi5YZMYMSI20kdZbZucmd4EPgrmwABjr6F1XvGV5hnQggb83qTn9DxPXtxFFAqJybLz0lJc2TMMSSoBEMctxyP2hn/5Kb+alyIh6916MnpfzB24kGbuZ8t/tJZyyciGoJUMea8RKHkJjragGzkd4njdSbxAtLFYl2It6ECs3HXGXY+ewIr2+/EwMKREuyIVC3pPo20IGstJSOHsYWnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ij4vtAb+HBBWTMW4JatxDdLB8tk8VfZBTrHN9L+eKs=;
 b=POYGhf5t73oIbHw45YAC585DgHU9jj4sNiWpk7R7oD2eYm9al0AwpvyhIV88gIbkLjJxGu4Nmr20l5poyWdPCoJ27gGjqSfoXT8goHMxbL3i3cuixCUPdro54MSJWduk7HlE5VGh6last0w9eeQVyCFHuy8PbcWgabSLv9qNGK4=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by MW4PR10MB5862.namprd10.prod.outlook.com (2603:10b6:303:18f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 22:16:17 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 22:16:17 +0000
Message-ID: <f7002e59-d0c5-4342-b647-196aa14c65a3@oracle.com>
Date: Wed, 26 Nov 2025 17:16:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] amd_iommu: Turn on XT support only when guest has
 enabled it
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20251118082403.3455-1-sarunkod@amd.com>
 <20251118082403.3455-3-sarunkod@amd.com>
 <40b36c5f-5e47-48a4-bd39-667040f53a05@oracle.com>
 <3a372c3b-7edf-4e11-9258-7f61c3cdb670@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <3a372c3b-7edf-4e11-9258-7f61c3cdb670@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:510:174::21) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|MW4PR10MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 80913c24-37fb-4cb0-efe7-08de2d396b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkFFQ1d3eEoyenpQeWV1UnNGbXFQSHp0Zm43cXNmNEdRY0FCaFRzYXdhL245?=
 =?utf-8?B?V1IyS3A5ZFMvc2QzUU5GaHRQOXRmMWdTckxGL3lWZWdBNGtwaEw1ZjZIVysr?=
 =?utf-8?B?RUJwVUdYbFgwOEZnc2JDbnRoVml0TjlZK2RyeEs4MjRpejNaTVh0N2FKSHNX?=
 =?utf-8?B?bTBZWnNKL01yLzU1d1cvVkNyRkVjWUxtZ3Z3bFdWL052RFdrby9KRmN5aHhR?=
 =?utf-8?B?QndWUGlCaXBlaVViYXFqVGQrUlh1UkhvajJYNTg1ZXkreEo5czVBRlJrcVds?=
 =?utf-8?B?UWkxeEl1V1FQK25uRzRkVTArc1lvRWNLeUE1VzRXemFJM20vUiticTRFUzc0?=
 =?utf-8?B?UDBoeUVoRURvdWJTUEtmd2VsQWR6dytLYUcxNnEyWmV5NEFUTFJ3NzhVSkdL?=
 =?utf-8?B?ekVzc3c2N1NZTmFsUk0rUFZockE4ZGl6YjA1Um9jdlg1RGFQWE5SdHVOVzVN?=
 =?utf-8?B?MURCKzRkaFVoWFVpbU50dTJGd3liN0Z0M3ovWWtVLzdiNHk1L2x4WkdNbFhE?=
 =?utf-8?B?Y3UwaWdmYzc5TFNodFdJWGE1RjBieUJoa0ZEbU1SUFk2ZXBwQ28zSlEyOVhj?=
 =?utf-8?B?bEhYbGtTeXJjNkYxNVBjNjZ0Y3N5Kzl2SkxtYmhLellTUmpQODBpcStJTTBn?=
 =?utf-8?B?aHA3bVlwUnNPRjZvY003SDUzRGg0cVVrTEtqbGIwdFNsOU5FVG9qdG15UTZU?=
 =?utf-8?B?NXNKKzQ4Nmg0UFRubHlVLzF5WWpCbUhReUYrZVljMmxLbktlK0JreS9KNTk0?=
 =?utf-8?B?WFY4aFN3bU1XdU5iMFM1aFlvUW5lN2RqQ0xsMVFDMzNYdmhCTGs1TmgzS0NX?=
 =?utf-8?B?Rk1jQVVzYUlNK1NldFU2TERibWJCY2xKelJSMXIxOXp2WXlqMS80elRjc3pj?=
 =?utf-8?B?cFU3alcvOXFXa0drMDN3MDF3c1FpSWxoeUZDK3AvL2dUMlB3Zy9zazFFbUVU?=
 =?utf-8?B?U2w2NDNBSFRYVG5BaU41OENsYk51SThiVndiYVpBUCsvNy9QTHdFZ1dxdHZN?=
 =?utf-8?B?TXFPWTdnUTJ6dXlJUGxjNDVUb0ZrMEVRMkFZKzJPNGFGQ3ZQU0grSWpOQ1hn?=
 =?utf-8?B?SDMwZk5LdWh2KzluVHpVNk9FSVFRZmFmdU94WkE2TnYzb3ZXakFvUldvLytV?=
 =?utf-8?B?S3hDUEdscDczZTRiRE05TFE2ckdnQlAxYmprbGdaYVpxQ3ovZk5nWVpBRU9t?=
 =?utf-8?B?TFpEZnBBZ3Z6b1JwUitONzBzeVZrLzE1OFV4NnZzSkt4RzFnQnlhZjV3UUhS?=
 =?utf-8?B?cWhCQXJLY1k1NS80THlqZGl3emI3UUEveGVRNDdpaFhFYjZkLzFZNW00T1Vt?=
 =?utf-8?B?MUtoeVlNR2V2WlN1aGcwS055azg1ZXFRbGREVk9EalVzdjE2SEZLTE5Mc25i?=
 =?utf-8?B?QUl3WDdacHFqU3dUN0xVQU9YbksyaWVXa0F4bS9CR2w3d01SVjJqYUt0ekpR?=
 =?utf-8?B?N3F5aGRqUmpiYnUxVnljS2EzMk5JcGZ1dC82UGh4VWRnTHhLL1Rya3pKQlow?=
 =?utf-8?B?dWZlMUVPNUVPWHJtZFVVcE1RdDlzU0hIWDV3M3prM0MzcGRuR2ZkVG90aWcz?=
 =?utf-8?B?bGpoOG0zQzEvOWZZc0hMQ2p4TjZzdldlejlSdzRwTTRnV2JrSXhna3Q4Nmp2?=
 =?utf-8?B?RXREWnc1OWNrVmNWQnR5RlNibVppL2U2MFVadmZMTFNVKzNRTUNVWXBzT0Jq?=
 =?utf-8?B?ZnRYeENKNnpUUXNISEw5aWFkaStRMXlIdGFXMkEyY2MzQUxQUDJ5RzJTV1Fm?=
 =?utf-8?B?UC9IdDNSM1BseGNkamJxWGt0cllDMXVXZjBwZUpSOWNtaTJrTVdFZzhEUEYv?=
 =?utf-8?B?YXI0SkRYU1djWkxEQi9pTHdaRGJ0cDN1QmV1U2pDTDB6VlBmd2ZxeG5xSU9h?=
 =?utf-8?B?UkROM2tGaTZ2NHlNNUlyL0FqYmJyZ1pGYWRadG9HTExaR3Q2SGdtSjNKb09s?=
 =?utf-8?Q?0wDDJUQhe1+sYMouhjhfv2cUiw4c551j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHdoUEliUEVFVzlaNVRXTmI0U0lVbUYzSUZUY1V3UHVuSmFMYWlOUURSUExY?=
 =?utf-8?B?OC9tdTA0UzVGRDNrM1RhTThIZU9pS1FYTkVLTGlRWm1mRkhuUHh6eFhrQlQ4?=
 =?utf-8?B?SGljV2NJMmZOb3J4VCt1eFQyWjlsWWFMc1creUcxS1o3RVEyOFh5clZHei9n?=
 =?utf-8?B?ZmxyUDlNcUlSU0w3ZXpCcVkvaVhMSlAvc0ZuemxXL1Nra0ZQU2FLRndhcHI5?=
 =?utf-8?B?V0xhb3E0S1gyMmVZa0hOdW9McmNRTjloYTN1WENlYW5XSlBMd1BxM1daWDNR?=
 =?utf-8?B?SXE5Y2pRa0FQTzZsMDZvVktuU1hkc3dhZ1FiT1RjekQ5M3ZTMlh2OTdTeDY4?=
 =?utf-8?B?b2R0cXNtdHUyMWRIVzZuTmpIMUV5ejJRRGZVUytMZzdNNEJibEliMXZIT1hO?=
 =?utf-8?B?WVp4bVo1TkdlTlV6Z0I3QWFLMy85SVBGR2FLOVJibTJPd2RqUU12SnRLSjkr?=
 =?utf-8?B?NkdMcyt2S0tnQVIyQkQ5TEJENTN0Z3RmNGpxUGtNa0c2NHd4ekR4dStsazhN?=
 =?utf-8?B?MlhoMm9QL1lDbUFZejBKc2pmUld1ZVhsdDNTc1UrRDJMcXdRL1dDOTQ0T01K?=
 =?utf-8?B?TEhOZ2grVDdKdGs1Q2tTSytwUzlLZENKc2ZMU0tDeEF2eFJycHA0TWV5dFdF?=
 =?utf-8?B?Z2RDR1BkVmVNZUp4OXRhZDQvUTROVU90dnFtT0VvYjEybEJCZUJQNDYyNndn?=
 =?utf-8?B?RkNTL0JFUmFPN2M1bGJyWUVUYTVjY0VieW1oaHIxNnFQQU45Skg2S25lM0x0?=
 =?utf-8?B?cUhKTkFQSThhbk9OYk1WZzhmbWIwVWlOSHVFZ2o0S2VlNjh6TTFKZURQbzFs?=
 =?utf-8?B?NFhWRWRJTDZqbmVDWnBiMytZTldNR0dFWjkyMm1RbG9JSVpMcFlZSnBhRGMz?=
 =?utf-8?B?c2xOa0dVOVVYT2Z6L0hEcDJVdHRIOTFKMnEvN2hXVW5XYlVBOEdJMyttUHo2?=
 =?utf-8?B?eXF5a1hMSmJDczg4UXhHMFlneXlMNlZNQy9yWDFjd1pCZTRhOXYybTQ2bWox?=
 =?utf-8?B?MWVpUUV2UExLS2pVejFZNnE3eDIzT1F4M25KM0Z3KzB3L0NRZmE5R3hWZUlR?=
 =?utf-8?B?cjVVb2t3SFdjL0kzNjM5Ri80THd3S2g2elZKcjhhWHpsdjIzR3FTTVpvMTJY?=
 =?utf-8?B?Y29yNWVzRWo3VWEzNTJ2bkRpdlVUSnZ3dytOSzZxS2UrY1JVL2l2Z0Nad3Vq?=
 =?utf-8?B?MENjdmFiRmtOaHM5WFpaZDcrU0ZwZ2xEZWVleVhSbTE5NGUycnE5Sm9qUmYr?=
 =?utf-8?B?enpOUHpGYjVXRVIrK0lvNXVTT2pqQldmd0NMZEVLV1ZzblBKTHo4T0pHWTc1?=
 =?utf-8?B?WTFUeDRsZXpuaUdlR1dqeGJnOHJBSUVsblRTUEpIZi9GZXFwNTNpb1lYR1Aw?=
 =?utf-8?B?UUJqQjBaditka29xZnNWaFdzNjhkODIyc0wxT3ZpdVkrWnRCRGkzc1A0NVdu?=
 =?utf-8?B?VVV2RVZNOXE4OW9qdVdZZjgzWXl2Snk1bnl2NUduc3RLbjNEdUtiQjNQalE2?=
 =?utf-8?B?L1FPcmtHektNREVyQzRjb3RvVzZMR0F1cFgrM2R3aE9MRG1iaTZHVkswdWwr?=
 =?utf-8?B?NWhQL0hXcjROdWVTTDdFQWhQVkpxdnNwQXAxVFZ6UW5raUtPYTRiQ05FeWZS?=
 =?utf-8?B?OU4wa2Y3OXFZb0hvS09RcGoyUGd3a21yZjArRjZZZDVQdnVnck5Ic3VDd3lW?=
 =?utf-8?B?TjIvcFpDS2hmbERKQVBuODZRdVAzeldPdW1vZVk5MWt3TmNwSjk2YXBiS3hP?=
 =?utf-8?B?U3JTdzlZZzY2ZDhvbHVmZHFTRXNiUkp1dTVFUHBPbDhuY0Q0TW1UV1FtN2Ja?=
 =?utf-8?B?cEtuWm9SZjdESkhCVUhNK1l0bnJDM2ZldFVBQXBvRFFHenZCUXFodGcvYUJq?=
 =?utf-8?B?Q2xHM05ZWWFucEc2RE4vYjU2Q2xKTWFUUnc1NlJ6LzdmZ1NENElrSytiNUE3?=
 =?utf-8?B?YW5hY2xwZ1NJUkFwWVp4cWl0WC9ZNUx3OG9wUG1KM2hiMExQWEEzMEN0WG94?=
 =?utf-8?B?TDlWV1lraVlLUVpjb1VMNjZlTGZjeUlvWUp5K1FCTk1uV2x1Tyt2cUNRS1hK?=
 =?utf-8?B?OTU0MHFnUXRac29hRFRnNnBMaGozOXlQNmNVZDIvVW9weTZLblE1ajhMbXZR?=
 =?utf-8?B?V2x0MjdaNDd1L3BGbnBtN0FZSVd6MXdDYnU3bDFvdlN2VmdiZzlzYUZ6cFFP?=
 =?utf-8?Q?yoOziolx6W1VmrYzNqZ12nc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d8MQI+3qK3BGfA8RLIeQ5fwvSHEkXb9Zh7jfNZLN7e9zD5nPJzGNzVqBU33n6PgJfUt5aznou2lFczGKzOnqQl1ZvJkS5+zhO97aZpoci7i+rI+enbbL6BINAQ9qEtSuLZ3tgCXJ23tjBOmtIiMvp1v1oQfvwcn9QywLhYdZnnFjFAYgXvdotALRTkM9NGGL+p6KWH0htDmBX+qklq0gdV02qw6vWgbjKlCfo0xKn/o18Zofvq1JwLkzonZhh2BplnNttVsLdT5p6H1Guu2LoGSE4rmbobI2pAOyt3LRcTnv1GjH0s03xtRjVxDVdJYFU2L2/kVjvfJXbNQ5rr8h3p+JDFidHvleDcFhC2WMBp8+sq7OrMNuVdD1HxRaM+ADkbn8g1e2nfys5WS2gSnqD8SQLFG2pKFoBoTkagUZDHP/lhAO+d5bpV9UjYTYDCOw9RC18dfl50Q3vmKgJniN3tHouf6Q2/5dtrnsEa9lVl1ZUb16CDD5Otir8WOmkXkyTs3EaXd57Knh1dv28OBFtLMfKrsiCYxOImQ8Md3FN6yyXE+N4AmgRT10cNz2MZnBck8xU9onIZkOzGjkQOgYuiB6Gkk4mV2a44HjpoMz1V0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80913c24-37fb-4cb0-efe7-08de2d396b8e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 22:16:17.5989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2R0Y8W6h26fy5kyuJiVt5EoxUbkJw10V026eBARt7OYuw3LYtsYME8mDyHWP6TbyKX9OCOn+zmQ5xZ5y7kc5lhT2/1nKu0X0JrJsjUel20M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511260180
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=69277c35 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=euJ3YeSU1tPyF14ck1gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE4MCBTYWx0ZWRfXwRIWoNhUuXGY
 GSZknsxgcDJLkogRJKiXVGtSi7FxcFfJOEQKm/KscgVwbFg75t80UP7dlljr4l9vwPlHxSmRV9v
 6zDTpjQ1RaB47bBHUlBdWx7hDvLQ+06W3evz5SxP88yBAby/EM+iGYwnWjqY4+f0nJETq+9hLfF
 OyRz8rZGgi6oyZ8WlUuICslc9ZovRnCEUkjilhW+1tl57i3RUe6hO7L5070sMXTUcB8caDvmTd3
 Ru0zTafz1voSHefe8TmuX9u8aJ/T09iP4SkQUe/TPNWo7Fju1qEL6NZUmQPzPFSCjrtQm99oxVl
 mGBlJ5hgE4hbx1h7Mgf+VGjtC6Yldy3Dwm07ZiNIpu2+ZoFTJsjjJ8jZKK0ZDN7bNDGXSXaZim2
 oYXW+CqSw1nWgPmmU9dQLFaZaMnCeg==
X-Proofpoint-ORIG-GUID: qioUPnEZ2tEsg7l3yjqd-wMvkQxlHT9e
X-Proofpoint-GUID: qioUPnEZ2tEsg7l3yjqd-wMvkQxlHT9e
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 11/26/25 7:13 AM, Sairaj Kodilkar wrote:
> 
> 
> On 11/26/2025 4:34 AM, Alejandro Jimenez wrote:
>> Hi Sairaj,
>>
>> I have a couple of suggestions, and one addition I believe is needed 
>> in the code, but overall looks good.
>>
>> On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
>>> Current code uses 32 bit cpu destination irrespective of the fact that
>>
>> s/"32 bit cpu destination"/"32-bit destination ID"
>>
>> I think it fits the language used by the spec slightly better.
>>
>>> guest has enabled xt support through control register[XTEn] and
>>
>> a guest has enabled x2APIC support ...
>>
>> I think it is better to replace "xt" above with "x2APIC", which 
>> describes what the XT feature is/does.
>>
>>> completely depends on command line parameter xtsup=on. This is not a
>>> correct hardware behaviour and can cause problems in the guest which has
>>> not enabled XT mode.
>>>
>>> Introduce new flag "xten", which is enabled when guest writes 1 to the
>>> control register bit 50 (XTEn).
>>>
>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>> ---
>>>   hw/i386/amd_iommu.c | 3 ++-
>>>   hw/i386/amd_iommu.h | 4 +++-
>>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index a9ee7150ef17..7f08fc31111a 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -1548,6 +1548,7 @@ static void 
>>> amdvi_handle_control_write(AMDVIState *s)
>>>       s->cmdbuf_enabled = s->enabled && !!(control &
>>>                           AMDVI_MMIO_CONTROL_CMDBUFLEN);
>>>       s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
>>> +    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup;
>>
>> I think we should also include a new xten field in 
>> vmstate_amdvi_sysbus_migratable, to ensure the remapping behavior 
>> stays consistent after migration. i.e.
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 9bf36ef608..5940011ef1 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -2452,6 +2452,7 @@ static const VMStateDescription 
>> vmstate_amdvi_sysbus_migratable = {
>>        /* Updated in  amdvi_handle_control_write() */
>>        VMSTATE_BOOL(enabled, AMDVIState),
>>        VMSTATE_BOOL(ga_enabled, AMDVIState),
>> +      VMSTATE_BOOL(xten, AMDVIState),
>>        /* bool ats_enabled is obsolete */
>>        VMSTATE_UNUSED(1), /* was ats_enabled */
>>        VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
> 
> Hi Alejandro,
> 
> I don't think adding a VMSTATE_BOOL directly is a good idea because 
> it'll break backward
> compatibility (kernel running on older qemu won't be able to migrate on 
> newer qemu because
> change in the stream length of the migration data). In this case we will 
> have to increment
> the min_version_number to stop migration from older qemu
> I am thinking to add a new subsection as it'll not break the 
> compatibility. Let me know what
> do you think about this.
> 

You are right, the subsection approach is the right way of doing this.
Given the lack of updates to the code until very recently, I think it is 
unlikely anyone is using migration... but since the feature is 
officially available, we need to do the right thing.

A problem remains if we need to support migration from newer to older 
(i.e. missing xten) QEMU versions. Then we need to have a .needed() 
method to avoid sending the subsection, or otherwise the migration fails 
due to the dest (i.e. the old version) not knowing about it. We can try 
to find a workaround, but my thinking is that the added complexity is 
not worth it, again considering the extremely low likelihood of actually 
breaking a user setup.

I don't know if there is a precedent for this type of choice, so let me 
do some research, and hopefully others in thread will also comment with 
their opinion/guidance.

Thank you,
Alejandro

> Something like this...
> 
> static const VMStateDescription vmstate_xt = {
>        .name = "amd-iommu-xt",
>        .version_id = 1,
>        .minimum_version_id = 1,
>        .fields = (VMStateField[]) {
>            VMSTATE_BOOL(xten, AMDVIState),
>        }
> };
> 
> static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
>      ....
>      .subsections = (const VMStateDescription *const []) {
>                     &vmstate_xt,
>                     NULL
>      }
> };
> 
> I have tested above code.
> 
> Thanks
> Sairaj


