Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE50606A323
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=CyghbIdY;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Df0fF826
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQMu4-0006HS-T3; Mon, 09 Nov 2026 05:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xQMtw-0006H7-Q2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:47:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xQMtt-0003uC-J4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:46:59 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A90BpUp3996043; Mon, 9 Nov 2026 10:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=YTg3AjdKAzlbo+Z2oOpqAyMbYyKwaIsGcEk7L3/jh3k=; b=
 CyghbIdYCs91/3t2iUoA+ZM53GlKyRueAsFtJiZm/NFtGrmWtlzuR0rwq7t/7sZL
 uHj3uwNGQeyAqNFRAk/Ylsx28fkzB+7CY/v6J/2eUO/yAsnaNS85lyhEdO+tD2aQ
 oe1iVdzHqULn6Vqluxi2ix/F8J6utuBPg0uArWijh5ES+Wu8TRZV0MyzQptpIBxN
 RFn55YcjTGO6sVxhYRFLB8WOSK9xyM9SfBowRZ0OtScyNdPElAr56j6m85bPZN88
 qtMN0e8aqtFts/lMwmPD6D6/43SLUq93aA1dNe7cSE/OgQs7Scqh4hJJM6MUgljv
 IP87LCu8fuBkTMVXaRtcBw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hsv1ba424-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Mon, 09 Nov 2026 10:46:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 6A9AMVpw929171; Mon, 9 Nov 2026 10:46:48 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4huadqaxmw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Mon, 09 Nov 2026 10:46:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjsQBseJqgTx3T0827R+LSqpFXz9W//rWrx0XYBJ6KEytVGEmnX3NTVH1QL7Yez1T/Z5js9WfolY4BTj0KeVK6wj8qxXgu3hzn4jvs0KV2yLBDHbALpak4+/l8GZ6jDZl3me+dMME76CfatGr2Y6RBNEaWWNBr/BkedntmrcBoWK9eczzpGBwkXaCDXwgLxGt38IH+b4Jw6aXY62HIMKoddAQ8yVyepa4PyS4nRdJpGjncA7VaBK7CQCcOx6D2NRhHoJaX5J/o6c4C/CE/pgGDVS8J9UYxU5kJlFGC6ayOPzMjoP3+4sb/fqQYkRZIkHnBdykvY2TP9IdnZYBb1DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTg3AjdKAzlbo+Z2oOpqAyMbYyKwaIsGcEk7L3/jh3k=;
 b=bZd2r2rRj2cxZ0uR3Jl1++oQ8t367TmOLnAcN092ZeMuyTHNZhrnU04rTj49ANddNUeJJ6c2DHw+OwFyn9Ekw9FohB5Q5MOE61O7qSBQ+Am282KvO/KrxvBSqADJ0tIJK1TmHbd5b4zNCloWQ+XSPSMrmQg5h68YgGlVEURd78WmQkgjr+XCs1tHPAXs69Mg5Hoj+AlJcbQgbid1q3kgYZFL/KpP5scf7GG6e4d3aAuYa6RusD48bZdFkgbiUXd2aHnqhc6mFFZfyYILeAU5U6TQHvVH2KJNBVY6F1uBYkLLdl5w/AjxyjiJX/keM4vjAEIfFn5PGQJjFYdvdQWKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTg3AjdKAzlbo+Z2oOpqAyMbYyKwaIsGcEk7L3/jh3k=;
 b=Df0fF826AgrdkQYLiktar5/39wYW8n2oaz9eAYBJJI1CNylT8m2hoPRaM8OmsHXtHb0b1H83rG3HLkyZRanGuHXYt8ol5RLuTUY0t4tV7dbAQiBJ3tbmLNbjk6U/PABJHm0BSwbCq89+nzvoDbzx0/37LAE9IraXLt1zIZ88KkU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by LV3PR10MB8130.namprd10.prod.outlook.com (2603:10b6:408:28d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 10:46:46 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 10:46:46 +0000
Message-ID: <95d4d77e-7b30-463e-96a1-6add4495e451@oracle.com>
Date: Mon, 9 Nov 2026 02:46:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] migration/cpr: introduce cpr-luo mode to support
 KHO/LUO
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::12) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|LV3PR10MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: e70a3e77-e7b6-49ce-1d17-08df3e4ebff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|261026121527099003|261026135527099003|261022075727099003|261026130827099003|261022105027099003|261021130227099003|261102123227099003|261009223027099003|261021121427099003|261022115727099003|261021135927099003|261021123027099003|261021133027099003|261022113327099003|261028144727099003|261026140227099003|22082099003|6133799003|18002099003|10067099003|4133799003;
X-Microsoft-Antispam-Message-Info: ECHWHjXrJnfDeWnpu0L0IcTC/8L4x8Zd7RVfvooFPvsTYGGcoudotL1w9MFKjf6KJ6iyVRyRWulR8FH33vItV9h1r4OmZNsO78GrZNoDGtVAV0EhVYLsxZueSy2fNZG0A1hWD3HvAMB4WwPB+YTxnplGjjWzvC7dDXyn606OfElHF5xhtqKIJEpq2dhJ8l7Kvxkx+UhpdBvG509SWSaoSjGfhuWG1HCG+JQCEX5cVLPEm+gFp9I1kW0m03hADuFmA6goLg4OORDZxnZDvfGJJowrt5dcD1HGa5+a40pMOKOkqVcJip3lkkHwBPCLa/devddLfBMRPvEjKBbmt/TfnVu/SxL0uOsla+CsU8kfQRptWnalYs+L/bExTUGxLVsX3+5SBHgZjC/uM0Z+aUMJxQd7N3Dad23fdWUq887jiOmIqcTJwdjQDrb91XEUcITCrY0JT6SF1X2FM5KpEqzl3UX+KSrd0Uc+kwzyRnHIcD20LDvqDM+O63OfCVPSwQCjd804R0CIFD2OkGkVWzH4XcGGM8rLgfptF/0cg0s0M5a3hFZAn3rNe1+2W1ljn7MkHQvgI81QNcYNT2Rrt8RRC9tSzvv1Z51HieUBVoIwsHu7PcrcX8WMetNSK0gPAgu4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(261026121527099003)(261026135527099003)(261022075727099003)(261026130827099003)(261022105027099003)(261021130227099003)(261102123227099003)(261009223027099003)(261021121427099003)(261022115727099003)(261021135927099003)(261021123027099003)(261021133027099003)(261022113327099003)(261028144727099003)(261026140227099003)(22082099003)(6133799003)(18002099003)(10067099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxSMDBJVG9CQXhBSkNHU0RLUDBVWitNM1Zaa2VXMmc3dTI5a1FjdVNZQmVS?=
 =?utf-8?B?YW9mUUZ2VS96NGNrVDd5WGFlbVFPZTBqclArQmp3c1ZQUlkzeFRYVExJTVU4?=
 =?utf-8?B?NHVHZS9sRGk2OHRsV2EzY3JiaThWVHQ0M3pZOXd3MkJMZndTUHVtOG0zVk9Z?=
 =?utf-8?B?WTR5WVFTWHEybzAwZEVNaWZaWlpSamIxM09PaWVnd2EybGxYSFpuanIxY25y?=
 =?utf-8?B?V1BXY2pWSFFDaEo2OE95TENhMTJBNUEwVlg4azZNSUl0d0RJMWZSZzhFeXJL?=
 =?utf-8?B?dFpsYWorb1BrVW1JZmsvd3pUemtYYnpsRzY2RU04TEQ3QUsrRk5RKzJiVUxk?=
 =?utf-8?B?NGs1YnlUOHp1Qmx3dDVFWmNkTTBZdWYzYUdMSzZDd0E5bFNWK21lVVhnK3ZR?=
 =?utf-8?B?TW80RUxtSUppdlJ6NGFvQ0hMc3owUnZtUi8zWTBBbXJ6RDJCSk0yNWZSMHlw?=
 =?utf-8?B?Q3lpRVEyMHYyaFB0S1U2V0RtUWdTK2RWK0RhTDV2SmtaZnpYNVBHRXRaZXd2?=
 =?utf-8?B?TjBQUWJxQzFRQUdSd3NadU10TXh0UWoyQUhoc2IrWndKZ1cvZkdtc1dEbVB0?=
 =?utf-8?B?a0NXNVliL1hWVGdzT3djVE9vdnlsWTdnSVUvUGhQL1MvWXJsU0ZJNmlYUE5D?=
 =?utf-8?B?TnJOL1hyN2dabkltOWFoZHRaTU1IL1g1a01RRjhQWnNRL05oMGZUZjRtM1lQ?=
 =?utf-8?B?U25UMFZaR3VncXVlekg1N2ZoU0tKS1Y4Si9yZkJ5dW51SW16b2NuaHZacUJu?=
 =?utf-8?B?VWZQREJwaUJLMjRtTTk1OHUxOWlGKzd0N1BMenFsenJ6ZGg2RlN3RVZLaito?=
 =?utf-8?B?djlqYVNNMEFMR3FreWZscVZsSU1OVVpPYnFEcjNLbEpnc3ZySnBWcThnbS82?=
 =?utf-8?B?N0tTcjZ1THlGTFRqMDUrcFFCUE9qZ3lUK0xPMm5RZjBXLzBZZ1BWWXJSbXdB?=
 =?utf-8?B?VlNScDhJeDFqUUpKK1dkNm1OV1pFaU1HcmQrMTNKK2lHeXEvRUN4Unlpak8w?=
 =?utf-8?B?bEZ1ZXZSc2R4NU1wTTZEZUpIMWErTnpKeXJhNHZQc1lwY3FndXEwZE5yajNo?=
 =?utf-8?B?K2x4V0dEbnNZNmdMcVpMblZaOXhmUFVlaHA2UU5XNGVDNEkydDJIc1VaNk9p?=
 =?utf-8?B?YWpVZXdNY3Fzemp3WUtFK29rNG9WMS96S2VzeTNlUlhwM3BLcHhuc3ZJOU5t?=
 =?utf-8?B?WGo4MnFRYmloTHkvVW1YNElZUnp3Y1pzM1h3amNzL2M2cThKOFdSSlMyRHh2?=
 =?utf-8?B?a2IwdDd5MFlBTkh5MGdCSVU0M05YZVE1M0JDTnJ6YlZhc0x0NjFGcVluYVBh?=
 =?utf-8?B?NDBRYnpVV1Ard1FoZFdWejZ4dm1GTGNYNk8raWZoWVA4WUl5SzFwVHVsMzZZ?=
 =?utf-8?B?SmpBd0dXaGgyZEhsbzlHbzhvRWNuaGhYdzdFUmxPUGNQZ2lkSmpVUWRZNU42?=
 =?utf-8?B?dVh3emVtcTI0djhZdDdaWm8rMi9mSkVwY3Z4R2VReEZjb3ovNXU5bW9aSWow?=
 =?utf-8?B?QTFUbW9iTDhUNU42WUU1WjNaYm5qcEpEQ2NsekpsT2JEUEZrTjk3RE1qbmZD?=
 =?utf-8?B?Ykk0SC9BeTVuNHc3ZUtnQXhPTzJXT1g4MVZwdkNJRXo5QmxtWEh1cUtWd1dp?=
 =?utf-8?B?clpqbUdaV0pOR2xSdGpRMXM1eC9lUkFSeEpuVHR2Y0JDSStjb2p0RyttbGM2?=
 =?utf-8?B?UmdObjZncmhNdm9BdWJCY2FOZllkTzZBblJHN1dBbndmR0pzUlNpOS9RdXFw?=
 =?utf-8?B?cHIxTEJNMDZrREcrS2s3Ui9aK3BKekNyQ0U5VUx5dTBieXlGNVdHeitub0hT?=
 =?utf-8?B?dEE2SFQ5K2tJTjg2TGVFd0V6RWZFV0UwR1RKamU0bWhEU0U4SkJRZGdqOVBx?=
 =?utf-8?B?TWV2MHM1N1IxM3BWY29hYmoycWZFd21MZWJrUmpwejRHdUVuVXY5M0JIRk9L?=
 =?utf-8?B?OHJHSmtUb0JSSjl6UXl3SnV0TEd3VWh2Q0dDam1MTnJVdFB5UEZ3Z0FxeU1a?=
 =?utf-8?B?N2k4aU1PTjVDZlFITDhDaEs2WUVtZkxxejdmY0hBaFJCc1pVODNVWDlPanVS?=
 =?utf-8?B?eTRkL0RkZVYzajJrb2JsRWI0aHEyMTZOU2U4blVtSE53U1dQWjByV3VwZVdi?=
 =?utf-8?B?STJKUjFJMkN4Tkd5TXYrYXR5amdKNjRDMVoxS3BLQk5RVUNzZVNZV211THpu?=
 =?utf-8?B?QnBPWFlpcCsrcUR0UGdYWERRUkU3eG9sVW9lOUk3ZVQwZW9vZ3owMnlVWmlw?=
 =?utf-8?B?RTI0bCtWeERxb2pJVmZhZHlQMlYrYkxyVVF5b1J2SDRsNDd3OVNsMExocWJ1?=
 =?utf-8?B?eDNSZGlER2luS25DcS9aTVJDTXpuKzZnL1dia2RldVZMREJQZ0p5UT09?=
X-Exchange-RoutingPolicyChecked: TIYTu//6FJJ+ZnzJnW1pC4KMlJ0UPmtXcPTidBy29moG1usDSg4inefwMElenQ216CyXuvYkBg/BBwJ6O9lZRre4looarSwmZm00l9vm++NP5tIN1ZCGcjx4V8nwmhsr/kMSnV9ItTh89juNKB8Hn5tl1AjNveNle+oap0fAuOEj8bxd4wz32rJGGIEve0lMIHvT71m1NpvEU7uNcorRGtnGAFJY1VXANBq9ydHs2ZBsl4D9y+EeExQdMwUWwZPo7RTRmsRnDkBe6wC6nPrHvPvsjcrTkqXc4kOxxfSOpcQZ5lUVrqqgb623nllEjD0y6qP5aHzegem2dGaxMce9Ow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hjqjSCFaTDkNPBPVLkevWX/UVc7rbxoD63Pkc+m0e7bFoezRQvvHqc5OSfiISFrCBydZwyBpaekn/rhYAdN5pXhQcZnAC9aPNGfaILg5d7kKfSkGaWYBU6FOvbTSz9Qu32Y405XiSrmb2fXOlx9So0eMttkXRWsxT31OZB3IIkSWcoYRT9sLW9/AQDTn48inkY+Yqooj57zS/KG9Tmy0WCW4DTl3gK8cAC9OZEnFUygtxSnZf+hxepQn+wjJ9NnqnXyXlZQief9XUSAlneiuLnh/QSr2C39pZNjbxf5ifVd+y166fx2BeKnVjIqKm4PHyBXmnu5j1abif7/Yz0Z4LWOvItBwTjBDw1VR4ozl+L0qWdQaGQE/acZ2OsPkIM8sxzlskLHg/B0zaWjIYOE2EmhoAFRmFYYwNdXGYRE6MeNj/IRX8+iAbMir6z9Nj6NHCjW6jhkKuFohSBrpcfU8iH1+IaUJ6yhiTFUt2pjDgPujo04UpGdx/qqQaVitNpdZ5Sn7g1f5C8b2CTCIq4LLA2mIaCPMnfim44F2HYE+D1tqJ6rI8v1IXS5ZZYAle8kwGbZc3BwAFsG7r5MR3lE1raYW2W5Ch5GHVfEeX37d2ls=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70a3e77-e7b6-49ce-1d17-08df3e4ebff1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:46:46.2353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bydmrhO7HpYwieBSNFgv1WHl0oC6i+q5nfUQspCqew1CYXd36/tjVm05/qPOuhR+4N81sipORr698TK9cnLN8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611090042
X-Proofpoint-GUID: UfQPoyhRz7pLxjT1NlbR4BKNAta8XY4m
X-Authority-Analysis: v=2.4 cv=Y8NtIReN c=1 sm=1 tr=0 ts=6af1a499 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=uherdBYGAAAA:8
 a=VwQbUJbxAAAA:8 a=TYBLyS7eAAAA:8 a=Ta62tvkhemdLsCS8bAgA:9 a=QEXdDO2ut3YA:10
 a=zvYvwCWiE4KgVXXeO06c:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MiBTYWx0ZWRfX9mzcdgpWyBrP
 gS/Ilre4mcieEN+MyiEBxgLsY6pmS8zBoAk6BzV9JFIj7erqlifuxUDJNYaB/yn5fQxc5vfJpok
 kfWLps/tGL54Di9NLbZjbgokInH0slwz3bi0JXo2ItuODah8i6kZrLfCPqPW4k0ZddioN/yjI6D
 jRksrJbqrJUohzg/+tGxdKKvD6rnnS2GO4Hp5KwBZCRBpvk7kCHTtCQGoj+Y4nUZt1mjAs0Qor9
 qWu5WlXdUm+vYcr7IfJKsj8JC0CYggWRP4y6HNG5IFKwDqlxvFrcWt4uqwQZSe1F72/3SVr7f/L
 AdRd0EnmtKa9bksBKq6LNiLJXzMxqhulRSbqqTVAKBrK3+OI/8SRCih+N2xFkdN0d38dj/a96bo
 k95nzfId4twYkI11z5wvL+GUfg7un41PBQ0xyF6NAN5BfMec6jhDhLHyXjHAjZNFo2Twzp0S5TD
 tG4hiBr/gSOuneSHhBg==
X-Proofpoint-ORIG-GUID: UfQPoyhRz7pLxjT1NlbR4BKNAta8XY4m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MiBTYWx0ZWRfX/1OWDb2AotLT
 YB3gOMrA0mT9/zUj1S0huaApQtNnBM9ZHYtXK2hX88qjeFKw3qLsWuMUsUhBoHObAuG5rvKKtnb
 fz1OVNN1AujaWbZoJcFK8mSOU2AFC63hn1ycFtRWx/a+0IpUKqMv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I am rebasing the patchset on top of the most recent QEMU commit, especially
"migration/cpr: support vhost-vsock devices".

Meanwhile, any feedback on the proposal is appreciated.

So far, the main idea is to reuse as much code as possible from cpr-exec and
cpr-transfer.

1. Introduce the new cpr-luo mode.
2. Use a UUID to identify a LUO session.
3. Introduce APIs to create, preserve, and retrieve sessions and fds.
4. As LUO uses the name, id, and token instead of an fd, create an independent
VMStateDescription rather than reuse the one for cpr-exec and cpr-transfer.
5. Compute the token when transforming entries from the hash table into the list.
6. Preserve fds on the source. Follow the approach used in cpr-exec and
cpr-transfer.
7. Retrieve fds on the target. Follow the approach used in cpr-exec and
cpr-transfer. The tricky part is where to set the cpr incoming mode.
8. There is no need to modify save_fd() or load_fd(), as we only need to migrate
the corresponding name and token, not the fds.
9. Handle corner-case errors.
10. Block VFIO.

Thank you very much!

Dongli Zhang

On Mon, Oct 12, 2026 4:55:56PM -0700, Dongli Zhang wrote:
> This series introduces cpr-luo, a CPR migration mode that uses the Linux Live
> Update Orchestrator (LUO) and Kexec Handover (KHO) to support KVM host kernel
> updates through kexec. On the outgoing side, QEMU saves CPR state in a memfd and
> preserves
> 
> This series introduces cpr-luo, a CPR migration mode that uses the Linux
> Live Update Orchestrator (LUO) and Kexec Handover (KHO) to support KVM host
> kernel updates through kexec.
> 
> On the outgoing side, QEMU saves CPR state in a memfd and preserves that fd
> together with the RAMBlock backing fds in LUO. KHO carries the preserved LUO
> state into the new kernel. The incoming QEMU retrieves the CPR state and
> RAMBlock backing fds from LUO after kexec.
> 
> The regular migration stream carries device vmstate.
> 
> Although VFIO is currently blocked, I have an offline implementation that
> skips cpr-luo mode in cpr_is_incoming(), skips precopy, and carefully handles
> monitor_fd_param() although I never use it, so that VFIO is always
> reconstructed. It works with both iommufd and legacy for mlx5_vfio_pci by
> saving the VFIO and vendor specific state in vmstate as well.
> 
> The result is that guest RAM remains available across a kexec-based host
> kernel update without copying its contents through the migration stream.
> 
> Here is the main idea of the patchset:
> 
> 1. Introduce the new cpr-luo mode.
> 2. Use a UUID to identify a LUO session.
> 3. Introduce APIs to create, preserve, and retrieve sessions and fds.
> 4. As LUO uses the name, id, and token instead of an fd, create an
> independent VMStateDescription rather than reuse the one for cpr-exec and
> cpr-transfer.
> 5. Compute the token when transforming entries from the hash table into the
> list.
> 6. Preserve fds on the source. Follow the approach used in cpr-exec and
> cpr-transfer.
> 7. Retrieve fds on the target. Follow the approach used in cpr-exec and
> cpr-transfer. The tricky part is where to set the cpr incoming mode.
> 8. There is no need to modify save_fd() or load_fd(), as we only need to
> migrate the corresponding name and token, not the fds.
> 9. Handle corner-case errors.
> 10. Block VFIO.
> 
> I may need to rebase the current patchset on top of the patches below,
> from which I learned quite a lot in each iteration. While working on this
> patchset, I identified some cleanup and code issues in cpr-exec and
> cpr-transfer. I may send fixes for them separately.
> 
> [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
> https://urldefense.com/v3/__https://lore.kernel.org/all/20261012-up-vsock-vhost-
> v5-v16-0-36c38bd15ffc@virtuozzo.com/__;!!ACWV5N9M2RV99hQ!N58C4d74-
> zpeHeXtxKWUAIRgf18-Xzk7_V7p49rzvh29deg5g2oBeAn0R5b89vJzLBPv6rkzjTo-8F0Iy16Z0oRy$ <https://urldefense.com/v3/__https://lore.kernel.org/all/20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com/__;!!ACWV5N9M2RV99hQ!N58C4d74-zpeHeXtxKWUAIRgf18-Xzk7_V7p49rzvh29deg5g2oBeAn0R5b89vJzLBPv6rkzjTo-8F0Iy16Z0oRy$>
> 
> Example:
> 
> Add "kho=on liveupdate=on" to host kernel cmdline.
> 
> Create QEMU instance with memfd.
> 
> qemu-system-x86_64 \
> -uuid 6f1b9f5a-6b92-4a5d-ae57-7a0ddabc1234 \
> -machine q35,dump-guest-core=off,memory-backend=ram0,aux-ram-share=on \
> -accel kvm -cpu host \
> -name debug-threads=on \
> -m 8G -smp 4 \
> -object memory-backend-memfd,id=ram0,size=8G,share=on \
> -device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4 \
> -drive file=boot.qcow2,if=none,id=drive0 \
> -netdev user,id=net0,hostfwd=tcp::5028-:22 \
> -device virtio-net-pci,netdev=net0 \
> -vnc :8 -monitor stdio
> 
> Don't terminate QEMU process after cpr-luo migration.
> 
> (qemu) migrate_set_parameter mode cpr-luo
> (qemu) migrate -d file:cpr-luo.state
> (qemu) info status
> VM status: paused (postmigrate)
> 
> Use kexec to reboot the KVM host.
> 
> host# kexec -s -l /boot/vmlinuz-$(uname -r) --initrd=/boot/initramfs-$(uname -r).img --reuse-cmdline
> host# sync
> host# kexec -e
> 
> Resume QEMU instance after kexec reboot.
> 
> qemu-system-x86_64 \
> -uuid 6f1b9f5a-6b92-4a5d-ae57-7a0ddabc1234 \
> -machine q35,dump-guest-core=off,memory-backend=ram0,aux-ram-share=on \
> -accel kvm -cpu host \
> -name debug-threads=on \
> -m 8G -smp 4 \
> -object memory-backend-memfd,id=ram0,size=8G,share=on \
> -device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4 \
> -drive file=boot.qcow2,if=none,id=drive0 \
> -netdev user,id=net0,hostfwd=tcp::5028-:22 \
> -device virtio-net-pci,netdev=net0 \
> -vnc :8 -monitor stdio \
> -incoming cpr-luo:defer
> 
> (qemu) migrate_incoming file:cpr-luo.state
> (qemu) info status
> VM status: running
> 
> 
> Dongli Zhang (21):
>   qapi/migration: add cpr-luo migration mode
>   migration/cpr: move CprFd definition to header file
>   scripts/update-linux-headers: Add liveupdate.h
>   linux-headers: import liveupdate UAPI header
>   migration/cpr-luo: require a non-null machine UUID
>   migration/cpr-luo: add LUO session management
>   migration/cpr-luo: add LUO fd management helpers
>   migration/cpr-luo: track LUO fds
>   migration/cpr-luo: add LUO fd VMStateDescription
>   migration/cpr-luo: add tokens for LUO fds
>   migration/cpr: move QEMUFile fd helpers to common code
>   migration/cpr-luo: add state fd helpers
>   migration/cpr: add more arguments for cpr_walk_fd()
>   migration/cpr-luo: add helpers to preserve and retrieve all LUO fds
>   migration/cpr-luo: enable cpr-luo mode for source side preservation
>   migration/cpr-luo: enable cpr-luo mode for target side retrieval
>   migration/cpr-luo: abort session when migration fails
>   system/physmem: add cpr-luo blocker
>   monitor/qmp: close LUO session when resuming source QEMU
>   vfio: block cpr-luo migration
>   migration: cpr-luo documentation
> 
>  backends/hostmem-memfd.c         |   1 +
>  backends/hostmem-shm.c           |   1 +
>  docs/devel/migration/CPR.rst     |  64 +++++++
>  hw/vfio/cpr-iommufd.c            |  17 +-
>  hw/vfio/cpr-legacy.c             |   8 +
>  include/hw/vfio/vfio-cpr.h       |   1 +
>  include/migration/cpr.h          |  37 +++-
>  include/system/iommufd.h         |   1 +
>  include/system/system.h          |   2 +
>  linux-headers/linux/liveupdate.h | 239 +++++++++++++++++++++++++
>  migration/cpr-exec.c             |  32 +---
>  migration/cpr-luo-stub.c         |  78 ++++++++
>  migration/cpr-luo.c              | 328 ++++++++++++++++++++++++++++++++++
>  migration/cpr.c                  | 126 +++++++++++--
>  migration/meson.build            |   6 +
>  migration/migration.c            |  12 +-
>  migration/options.c              |   6 +
>  migration/ram.c                  |   1 +
>  monitor/qmp-cmds.c               |   7 +
>  qapi/migration.json              |  11 +-
>  scripts/update-linux-headers.sh  |   2 +-
>  system/globals.c                 |   5 +
>  system/physmem.c                 |   9 +-
>  system/vl.c                      |   9 +
>  24 files changed, 950 insertions(+), 53 deletions(-)
> 
> base-commit: 3377670ee96b5a68361016680a95b9013709d4b7
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> 

