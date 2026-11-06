Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C71606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=rieQB2x3;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Cvnt5+um
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP8lm-00058E-78; Thu, 05 Nov 2026 20:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xP8lg-00055E-2l
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 20:29:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xP8lc-0000HG-Vv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 20:29:23 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5NhRPh2537241; Fri, 6 Nov 2026 01:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0zBZQylV5qMKGT6Y20hIUndzlBENEW5kAq69JhcdPtM=; b=
 rieQB2x3jzPqlo2tQBPan61VTVsGPjL4eCAQVeZz5CNeYrJ5qsuHfLj3BMB6dHHd
 ULRl1yGyxb8W2hMobZo7E7cxqrGk+oQBaJHclLDzVr47FdBnbFNKbgeTaizkv/uC
 NPjk3d/ykJCQuBrCMD8kOySh0OYom1IOE4DmjttEGVpfiGTuA772xDOHhf7j/v2s
 LL0J1WeYvQlQWut/UkEi1KrqUyJmDFw9PsNR+GbTl6RjygzfGrxOzedCjM06y1QC
 p7e7nAB+QNBb9z2J7nGUh121HB2NPngOJQ6pAwsj7lYnkdpL1eaCPenI+LBS0e9e
 Wm1DFzEIGctxTDyj8Pz6ng==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hs3qp82p1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 06 Nov 2026 01:29:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 6A5NhwSl284766; Fri, 6 Nov 2026 01:29:13 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4hs3qxaubu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Fri, 06 Nov 2026 01:29:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5SwNLCzddqpCoURhY6D3gFnLazEqBI2UzX1GYU/stlf98TgtN8uVG8Y4V5w5HXLGsAKHsF+G0pc4a7Oa9z+bj4pcZH4U0lpaX4FLbSprrfmyp0HFeBbrpmmhVsnZpL+M2MGCP/v1g6IOJjeCwDgokxq6SzBf7tZrfrqA+xbU57X493/DIFu/sjp17ImtVtRUbejd3N3xtmvJYgRA2PDZ27Q4RuJ1FVjC9wKgbHmARaDlp/XvD/xRR+qVCVyCE+iAFgMCuM0OYdd1Lwd5jsWZ/lhcmAHEevRmFmHCmEtn16kbhZAIOSe7p6IdRWwOxkELXrhe+9DVL0V99bWKYa1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zBZQylV5qMKGT6Y20hIUndzlBENEW5kAq69JhcdPtM=;
 b=N/TciqsKV9HYoC+piPnIF/RYIFnvwXCj1C1qs2y7Nt3Rua6UQKVJQGjReK7fOwDu21AHrqntQYHul4NhKMMCk5Hzh5tXqeGi1asuINW78m+JOSp6Xd3UHblnkFp3PEY3QWa8jzi54dwC6iFJo8IW44hNXYCneQtFB8KNV7DWkdkbAwtFPdiA6D6FH7mZa40fr66w3LfrkRM5jyiKLsKimCNBVSny2j0iRsS6BZthFJF3AUaLIwJidRjXaVqgqXClb1Mi0/W8sWQeKGhKd5/lNO0C9mtV7w+fFOd1tFqr0w2aUHntc2whE+oNIywx3dUZZmg0iShUj5xRcoa41GHdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zBZQylV5qMKGT6Y20hIUndzlBENEW5kAq69JhcdPtM=;
 b=Cvnt5+umqkvE9v/T7J9Z6YDqFlT8JLXm+GDzju9a7kaQt8lS70O0FNH68x4TgU78JG/qM1HGz8VuLtcPxMZGJJ05CdlBnGeRqNrnrweMSe30kROgzMPshvm74S6PqBTGcaMenif/SZUR99INVjG2/kr7PCBoN5qlwLxm7Y9TWdQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 01:29:09 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 01:29:08 +0000
Message-ID: <1cfb4510-ca79-4138-b59f-c7971fe41b40@oracle.com>
Date: Thu, 5 Nov 2026 20:29:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/amd_iommu: Mask address when calculating large
 PTE page size
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20261105105816.3012283-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20261105105816.3012283-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::7) To DS7PR10MB5056.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: a61b3900-ef5c-45b4-23fa-08df3ba55a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|261021121427099003|261021123027099003|56012099006|261009223027099003|261102123227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: op6Sj3GjQ0AoB5SbTUvqaK4HyXHcnBcDAvYdpls9U3mAClm5byebg6EF/BVGNRZOl3xVqHlnuiMG7UImMqxJj3SzoP4Jpg1UpCUYpioDSjGg/ATH6GoY2WvaTaIFkagQZ57XSSIUO4owMBL4OS9Bj/kJh2kYjtMI0xa8nbT8CLiyNqoWIcv7StdHPTLGXcsevFp2D5JGjtSPn0pV1ZVb2nNd5karHu5s2W+C0aqNlYFOLJvgTIa9tcPYrjOF9LqBOy+MhepSGwzugActeaFjJ8HZf3KFjJBKCky42RU35d1Hi8T7dgpADkap79BgNKIDwIOjTMwvhoeEgdGLyehoDmhI2KtXXRmPOzud4wpm4plxPEsaaSRN4FIQ5MMqajf/BLP2XtKnszGeSylM4j/puj3Ae/v3kgiuUkaT90mPDCJtgWIvHpmk2PSEcmXog/mG7du210Eid+po7N+YKaCUB0w9b5B1myLembbktXMFnoQErRSNhtJrOz8/7Nugi+Uq2PHVSsoDO9QU3VDwjtNlIGkVIEK5nOLTPh0YC2qMr8F4vHvKbMqxiEVzSFzdIfzbum2OLSe26Qa98ifeqyt6Ryt+dicUsg3Mqi8gYaQ+/pSoY2r53B8Ea4t+Fazv+tqnhKE42o1Xix6j4a416tdXVcC5UbMOGgNmJluyTx5oG3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003)(261102123227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1ZDelhoZ1psbkFjUjVhMzJ4YjNGUm9aL25aWFVNSjFHRGlIOUVTQ0hMN1JG?=
 =?utf-8?B?NjJ4bERPUUJrS0ZqSDZHWWZvVElVTG5QQlhXbDBiT2NKclR5T0RSNFd3SWpu?=
 =?utf-8?B?ZkJSSXJUSXAzMFNvanV3ei91SGo0RUlyaGtZU3M2clVwVVZNSkFKbmx4Zmh0?=
 =?utf-8?B?TGQrTE9QMCtuWDRsbUIrZERFN2JocW9IbklUT3FodWo5eFZFWHZGZXFUQmFF?=
 =?utf-8?B?TDBJeXk4TnhXTGtGWVFnUCtmZ0JBZm5KUzBZRFlGUlVOY3ZoV0RYdG5QR0Nj?=
 =?utf-8?B?RThiRko5Sk10LzMwaFVSY29ING41V1BWQzdsUGdpbTFXZ2FVT1ExR0RwYk5l?=
 =?utf-8?B?OWJTOFhTV0NTWTBXVTBwTmsxeE16MGZ5SGZQTVFpQWpIS2kwb2V4SHh1MWYx?=
 =?utf-8?B?OWZUc3lFM3RibWRabDRZWitLUmliWDdwenlFZVV0bGJEZjc3eFZjSzZDUHNu?=
 =?utf-8?B?b3g1bXROMjF1ODZONjIyZEg4S3FQeTFwMFBPUHVBdHZpek9wcWlldE5YeXVM?=
 =?utf-8?B?TlVKN21NYlhtdzhZamovWitxcnFRYzVrZHZHc0VrQ3E0QWNYV2xZZUd3eWdo?=
 =?utf-8?B?RTkrcUdsU1k0amx3NmFEVzdNZkdtdXhNdXUrQkExUVFuMkNlN0ZiNFF1emVy?=
 =?utf-8?B?OUNzZTNjUS9rWjZSNHYzRGVVM2g2Q1pLdHVFVkFXRDJ5bWp4ZkI5anhVMmhn?=
 =?utf-8?B?Q1JEcUZYb1NnY1Zkbld3TTdZOGtzWlEzczYyUHNONnN1bmZid2IxaWhMYlJU?=
 =?utf-8?B?T2Z5c29lcnFvaUVIblJ3YXE2Rm9PQUpxZ216enh4d2ZVM1RZTzRxQ2MxZnhN?=
 =?utf-8?B?MDdxMWY1bTA1ZDQwSGZickp0SlJ5aFNwaURVVHlhNTJOSHZFZG0xMVBadkhv?=
 =?utf-8?B?b3hDcE1yMlcyQkxKUjlhMzhvL3ZaK2FhODBmS1h0c21XZ3lsby9YWnY4cGhk?=
 =?utf-8?B?d3J1RElSSlRubWVYS1BjN2hlU0ZvdVRZVFR5WmpIQkRrS3J3WG1KSWhBNXJU?=
 =?utf-8?B?dkR0U21vVkpocmhpUnhvZGZibHloK09ZRnVFMDZYempPdmZHSE5kVkdOVjVJ?=
 =?utf-8?B?SGwyaGpKbCtaTVFWM3hMeXFjSTVlRTIwR2YvVFF3dEhPSHd4Vkh4YzZZTTcz?=
 =?utf-8?B?VDZ2MG1SdHRQYmVTdndOUzM1SUJOMFhOdzcxNk5QMEd6dCtjZGIvNHlCQzN5?=
 =?utf-8?B?aXVlOTdhWmdNdlY2bG9GTFBFRGtvZzVlaVBLckMrekE5d2dYRC80V0F5YmFR?=
 =?utf-8?B?enVPWFBmSHZPTHhhTlZVWUY4S290Y1ByaEFmSmQ1NVBSUlE3WUs0M1FGWkZ3?=
 =?utf-8?B?VW5ENXJySWNUeEcrNmFTTE5vakpRRkxWOWdwRmxiZ2QwTHdLcm9YN1hlc0Q1?=
 =?utf-8?B?ajFBYjNMOFFDclpRbmVjMVlTTnBEOXJJcUVBdGthSG0wU3JHOE0xd1h3WndV?=
 =?utf-8?B?L21IQ0k3UVZNbDdYdmhoS29DYTkwRTlra0pXSHNaSXBXdlB6SU5Jck1CcUEw?=
 =?utf-8?B?ZWNycGM3WUpoL0hZWmhrOHlnYnlOU3VBaWFVUCt6R1Q5bHN1MUtiaHY2Wnpa?=
 =?utf-8?B?RVhRM1hUbWxseVBleVBiVFhBS2t3WEJteVNOdTN6TU4vS3I4bjZZVytsWlph?=
 =?utf-8?B?R1F6OG4zeGF3ekZCZTRZSzNCLys5ZVNJaGlVbUxrUXU3c1ZmajkxeDhiU3Fn?=
 =?utf-8?B?RzZsZERwQ0RJRjgzelZsaGs1NGIwSGcxVnl5K0hnYWlscHNxTG1UTkJSSEQx?=
 =?utf-8?B?MGdGNW5jMko0MWZZSmU3amNVeC90YVV2cHV3VFQwaVZmeWpmZDhoTzlidGxa?=
 =?utf-8?B?S2JjWUtUd2dvMy9yMXZXMThmZVJHdTI4eVA2SGZCMm44bDc2SnpvalJyQmdk?=
 =?utf-8?B?SmpZaWF4akZhTUVKZldLNlVsQlMxN2JqbERiYVM4eXhtb0lsazQrZHZUdFJG?=
 =?utf-8?B?b3AyWjVQbE1VSHp1TUFsYnZEMkxaV2FXVWdtZzRyWjRuRUlaOUhDUFJvbktX?=
 =?utf-8?B?S294UzdVOFVvSWhMV0RQbXByUzBBMng5cG9mb0hyeDVIdGNHQVN6TWFUUDc0?=
 =?utf-8?B?aXZML09nc3F3UmpCQ2JvV294cmphNUZybkN3VjFDTDdGMWJHVkl3WVNKczg3?=
 =?utf-8?B?T2Q3VGtmdTN2YnhXUlJhbUJDY09ORWJzVGhtMGJCbURBUVM1SndTMFg1WWZB?=
 =?utf-8?B?cVlpdWVPZkk0MWZEcDVFSjIwZlVQMXliUVZ6TGtIZkhhS3poZEZ4VTF6dzNL?=
 =?utf-8?B?eUVQdE1BcGxVUHBVZ2hsWkg3USsrS2Jqa0ZOQjFBL3JheTFvR2JDbk5BN2FS?=
 =?utf-8?B?cGZZNVNVd3BiZEx1TFAzbkdtSHRYaFRyeW1EZmZ0UktENUZTRlZzTUF1T1FR?=
 =?utf-8?Q?8VtMvON4xuXgeEXE=3D?=
X-Exchange-RoutingPolicyChecked: VVtbTf6MConIt86DsySDTarb/4MvI7LLlxyDzkAUodLrNIDvmdxndk+JoI2p2/CFX1pKXK9jo6DTLfJl+2orfah1g6pMEsgRoNH/g8bUszeMea/xK/7D/D5+75C1LMQqe9HRo/q2xicR0kDttQpEn6fVgA2wqa4Z5txJY05rSJabzegC09zzI3USROABhPhpToIdKEHb2JFMHtCmFWGBNtJ45anAjDdrXyEZsUTF4FPzwDZ33UAju7Q941WLg8hTgz4+WbsgEKRXRVGlBArQngfqLcwszOAWef0wCQpqv+ZJqiiLDCEesQJG+NPqO8TgL2feN5LW1j2Pdbiw0Z4bOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +WwZYLrtN25LfI8yZZWMJ5mp1zSeh6LJGax5qQdt/XGmr+dAIDhSoBL16plabkHOnY54AOr48NQO3DkBEihCgRY8Ks7DAoJXbVbUO+Xa9Yx1UDOZ0ePkcoAEDoiiMofLpygGH1EEcaxmKPuNgEDcGVbcYNFE/Te0j39MQEYOfAshW7FLOOAd3isNBNDkRZUUI5U0oai2YPI+V5KyTMpucetgeuLS8YHDR2EETT+kKTsgyGsRTNmoefAb2ga66Q+G5i2LFwySWki4CQ8NEyV5X+oVUSC6d50p6B1yKePWzd3jtWwznM5b1uUhF9+fU50oV1lEeX0XW6FTYSg5AGmpN+/ZWs3JExuXTdLU03zldw9/4lkdeSbcsREQk+pRo/oR4T4UTT84r6zxLa8QlvgvIIgCSTobcxeEQdpaETFF7LhcN/nRKLnn6SvqorhHu0WYzwJWHLkmciQ7hKAznBVWh/IUkmj+AxBtQB4N0vCPlmooX3LkYS4bJiof1bLHZusxgjmQaSKEDHodm7SxgNgJZDcjY0dLSZxpOLIWWZ/9+dha8Iu/J9I5nkzVqaMYPqnmlQkjQjY/Z62svEwKThmhGtqLxgSkcxDfxTjRatvhNLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61b3900-ef5c-45b4-23fa-08df3ba55a00
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 01:29:08.6639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUkyxDpmTsjr1mVrEV5vNORJbfDXZOCVpaMRgUPyh1rKfXw1XGM1kLD7NEuaf8aH37YRJn1INTGSVazdkiRrESsToyX9Ncjd4IWhVPYefVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611060005
X-Proofpoint-GUID: caZ5fcTn-vaii2DFZV14WHq2iseQn1ER
X-Authority-Analysis: v=2.4 cv=GLqdgeNK c=1 sm=1 tr=0 ts=6aed2d6a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=p0WdMEafAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=zBFVCj2NODuXKUJ8jyUA:9
 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: caZ5fcTn-vaii2DFZV14WHq2iseQn1ER
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAwNSBTYWx0ZWRfX2AM4MLtu400j
 HH+hPcJ+Q7vuowiL1Vvl1Z5zEopuMNQtwanecjl1/ZDktwalIA5Wt+zo70LR6iG14pbGeL7noMG
 MXpU2GfsjF07rBLrfaCJZP9ZCSTKEpGWPI0jRIJGCScNkdwWtRNy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAwNSBTYWx0ZWRfXzWqbTPp+Sj8s
 l+B3eGKZzqRL9ENJvscki5L4QXVRdI+mhkKMQa/EVGuhaQw+z8IlpjqI7DKJ2ub/MgXmtoQk1zi
 9idrTT3Zky6KawCMT7zgM7OiwAMCjVR7n0DCgR8V9RUXjlAE6Mo3s6pJu9Nkek21mGnpdB4NqDq
 PXZgPzp/x4USIibMA9bvcKeUl68qog3hxn6q2w5RGrSpDzfv7hLJH+EpBZXfnzfkfNGDncqLV2u
 cSEQEGskaOr4CmQzvF1drgLfjxKFiCI/ay9OgayahcnJp7/aELZGHUxIx6g8kmplzYPyAuBRZmc
 KYTAmA7S6RucrNOqbkaGaF3+LZwRA7vS16xnROk509F1NZEGTRDEpZ7Jn+fH+JAhwUPj/7+xBQv
 RE67UkiWNM6iNIvUcP0Nveh96poaO1mz1g68cWBk+gjWoTdOOtrRqUf1oRfNoB4XBMkHdqzz7u2
 JtYVArcxBosJRcuNC3w==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nit: For consistency, please use "amd_iommu" as the prefix instead of the
full "hw/i386/amd_iommu" path.

On 11/5/26 5:58 AM, Peter Maydell wrote:
> The amd_iommu handling of the "large PTE page size" (where Next Level bits
> are 0b111) case is not correct. We calculate the page size using the
> address in the descriptor (as per table 14 of the spec), but we don't
> explicitly pick out the Page
> 
> The amd_iommu handling of the "large PTE page size" (where Next Level
> bits are 0b111) case is not correct.  We calculate the page size
> using the address in the descriptor (as per table 14 of the spec),
> but we don't explicitly pick out the Page Address field, instead
> passing the whole PTE word to cto64().  This means that a PTE which
> incorrectly sets all the reserved high bits can cause cto64() to
> return 63 or 64, and we will try to shift by an out of range amount,
> which is undefined behaviour.
> 
> Mask the PTE with AMDVI_DEV_PT_ROOT_MASK to get the page address
> (matching how we do it to get the address for the next page table
> level in NEXT_PTE_ADDR).
> 

Fixes: a74bb3110a5b ("amd_iommu: Add helpers to walk AMD v1 Page Table format")

> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3618
> Reported-by: huntr bubble <https://gitlab.com/bubblehuntr>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> ---
> Side note: we don't seem to enforce the spec's requirement that
> the page size must be larger than the default for the level
> and smaller than the default for the next level up, but that's
> a different bug.

ACK, will work on a follow up to address those types of issues.

Thank you,
Alejandro

> ---
>  hw/i386/amd_iommu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 948d8611b15..008e882724c 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -216,7 +216,8 @@
>  /*
>   * Take a PTE value with mode=0x07 and return the page size it encodes.
>   */
> -#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) | 0xfffULL))))
> +#define PTE_LARGE_PAGE_SIZE(pte) \
> +    (1ULL << (1 + cto64((((pte) & AMDVI_DEV_PT_ROOT_MASK) | 0xfffULL))))
>  
>  /* Return number of PTEs to use for a given page size (expected power of 2) */
>  #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
> -- 
> 2.43.0
> 

