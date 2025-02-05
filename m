Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F5DC02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 10:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfcWZ-0007YH-PT; Wed, 05 Feb 2025 05:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tfcWX-0007Y2-Pc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:20:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tfcWU-0001wE-D0
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:20:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5159J2cK010845;
 Wed, 5 Feb 2025 10:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=MDsfUNlP+ldAChYobIDoS7TmJ++7rf1Fa6L9i5L22TY=; b=
 RuUA6rNePdZIQlQanNwHmQHCX6dhAMnnnQEeqDymbYQ/3XZ8Q8CebHvLtrv2wGuA
 63kLWnn4XM6ILY7dXITfW1Jzf66+m8968xYmojjuxyPk8on2MsI8Xu/RJrp1SBOw
 qpc6++3bkpkszz17jTqdirkXU2z6nOZNnIJoCI//cXiSmpznodi7rP7O967s+zZ+
 TC8AQI2FMIvONbZabWsf68ozCXH+vX1s/pwboE6g9QAH9C1KE7/G9lK7XCAstHlV
 bXiTdufFyPNfwvLcYr/nIjVQd9Cnrwj/cLE8gAjRyXdvp6IsuBbIwq4NQOQhieRV
 j9MpnfZZgljTbS9L27damA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m58cg481-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 10:20:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51592KGh037760; Wed, 5 Feb 2025 10:20:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8gj5e09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 10:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmA9oE9YmF19VVOnCLrj6jkuBIj2VmmDAoNy1ybqxE6QslVie/5xKF8LULv0sp/+vLlidPUQ84XZ4Zb15tYIexuoRrtzvdKHjwrV9Q7ECVQAc31MxGYmIv9SfKLomPKNoR0Jgx1DIHfL1coEAtjRhm2RX7YgDO7eZYMzelZIDbB4tcFf+/M3c60kFHVPW21+ASt72w1fcpn1UaN4p4wx1jDpYDiQQjdYNQxWv7zgKS1Y+Q2PvKrF3Av6ktxuMQTY75zb+XlJshO8rJCcFTQktka2i4GHT5OEsph8ZDVXJxiOwD8J+BEc7LPD4pMq6FVFJl290vpKkbk6HupPAfZf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDsfUNlP+ldAChYobIDoS7TmJ++7rf1Fa6L9i5L22TY=;
 b=abc0DpIefYe7cKToMwsz4zAzWiNnyMlnLsciQElA9MFvvDSujD/dZHERaeEwNTQP9xcTxmwcyHl6P+oDP4fhSBMBl4Ah59CAx3vt4s5D8H9otVO8wzUBYI2sTr4zv2yIP6Qouek/7Fzk0KBulLn1pN5Gv+vntlDdXgbSkmzjOWK+UbJ0guGc4IAD4zQoTlEov6J2mLiU2Q2skx4sQOYUvgmnQmVM7fTbIrbvyi3gw8LMev50bWJnThYlH4Z+0PhafvhoCnqHFwbaCZEPmpq0ZaVo/ml3/qZflVT6xI6eBZzmxGt9RhewbiGXvrBP3QyD0o7C0koA7vjS9ITbQKAHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDsfUNlP+ldAChYobIDoS7TmJ++7rf1Fa6L9i5L22TY=;
 b=cE23gdv8No8BPIPXmIzEFShSOhx7I9OjXAgyH+9hw4V3F0GuLH0LXJ2jaVD2dMkKM/05FzDo6NkUeI4lhZLhk14k2BV/VZxkNrMzNxInhGioQ2p59HZfhVEDwxaJMGtBjILvw86GIA3RBeaqCf0Wl4VOFBDxSiSC5MCGvUllnJI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by LV3PR10MB7963.namprd10.prod.outlook.com (2603:10b6:408:20e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 10:20:36 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 10:20:36 +0000
Message-ID: <48ca4719-e6fc-497b-a74f-89416d951ac6@oracle.com>
Date: Wed, 5 Feb 2025 10:20:31 +0000
Subject: Re: [PATCH] hw/i386/amd_iommu: Allow migration
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, Ruihui.Dian@amd.com,
 bsd@redhat.com, berrange@redhat.com
References: <20241120073114.20774-1-suravee.suthikulpanit@amd.com>
 <cae2e18a-a090-4bdc-b3b9-cf72393436b0@oracle.com>
 <b2c19675-ba87-499b-aff6-f946d5d25eb8@oracle.com>
 <e3cd0f2b-639e-4383-81a7-06a227d0db28@amd.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <e3cd0f2b-639e-4383-81a7-06a227d0db28@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:208:14::40) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|LV3PR10MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e7c6d2-bde6-4e5f-5ecd-08dd45cebb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG1tZWM2QXZ6Rlo3VHRHemkzMHFJaGVDMVJXQXJtaHVYb0xLakplTWwvaFhn?=
 =?utf-8?B?UHBWTkVBY0JIRFBFcTJFMldjQXBoMFFsV1JOcnEzWkNWcm11c1FLeEMrMTg4?=
 =?utf-8?B?QUx3bDM3ZU5icVd2akZ3N1MxRmZnVDJ2OUh6cTk4bEJRL0tMcUQ5UVRDaG9C?=
 =?utf-8?B?UUhSQnFJQUV0K3ZUZjc4My9PYXhtZmRZMWVZK3Y5VGc0Q04zR2pkVCtOeXBm?=
 =?utf-8?B?QU1qWHZMK2xxUWFjalk5RDdKSkVZVE9GMEtjTXZpVnF5S1IrL05jS2Q4NitQ?=
 =?utf-8?B?WE03YlkxRklRdU9VSnZlWUljMlZCcGloTWQ1UFFsSUZWakFpTjRnUUUxZmZX?=
 =?utf-8?B?YWkwYmUwV3RmYlFUR2lQeXJqY2tGV2UweVpoYmREb1JxRXJ0eUtkNUNaYlBB?=
 =?utf-8?B?L2tOYmV5UWdGcG1LNjFXN05DVjJMZmlzS3pabForY2J0OG1xQUQ3YmdnNC9o?=
 =?utf-8?B?cnJiN3ZpdFF6aWQwSHo4V3kwVDIzZWxQSm8yKzN0U21zMkx4dGRwY0p2K2tw?=
 =?utf-8?B?dzVVbG94TDFWeXcrSXpVblpmcmxMaVBNTmVwQlB5MlFBYkVzaXYvSEVQa1Jq?=
 =?utf-8?B?RWZ4QlBnS0NHZGUvMTlkd3MybS8rOFo1Y2tmZDhIQ2M5MEhGMTg5d1V4b3pW?=
 =?utf-8?B?SUZiNmJadHUxTzRGK1JjV0ErRHphcW14OC82dWVnUE1VMTZVWFEvQWYzU3dn?=
 =?utf-8?B?SmpMMlBUMkVRaXYwSkQybERFMXlUM0J0L3p3Y3NNTmZEMDE1TmxIMTFGd1lR?=
 =?utf-8?B?THBLOFNEWS9Id204Yy9nMkxXaFZJVGtWNHlHZDNSb2ladmxKZStlbkxZV0Qz?=
 =?utf-8?B?ZEdDWllXRE9HaUVlUTNIL1lla0VEVnR1TnVnMG5DNSt4dm5BN3Q1TkVPSHFp?=
 =?utf-8?B?OXFYYldDcGtnbG44VE9KS2N4ZU5pUytCL05ObFhGR3BnRnZVQXUrUkdUNHJH?=
 =?utf-8?B?ZEYrRTlPVi9tMTVPSGw5K0V0NUxpTVN0aU05dnp4SGIxM2MwNEZ3Y0F1SjRh?=
 =?utf-8?B?YkJxU3drdHJ2ZTZiMGdRUmI1QmJqeWxkREJpL1dESGpJd25oeC9pQzRQTU8v?=
 =?utf-8?B?VU44UE1zVWcxV1pOWDl1WGV2c1QrUUF3THJ4ZmdQQ0pUZkMvRFBab2JWTUI4?=
 =?utf-8?B?UUVnV01QU2V6Y1FESW1DNHpveENzSVVRMzRRQ0xaUFN4K3NFTmRlZDNTbmp0?=
 =?utf-8?B?bmlDT05obUg0a0JvN0M3bFRORU5IYllaM2xFTjdvdzBwZjJtVzRBUitwUnB5?=
 =?utf-8?B?VzhTWlZjeExqREtkejlaejVkLzUrcU1kWTFhSTZna29Vc2hxVEZ6Uk0zZERN?=
 =?utf-8?B?M2lnV1dpQmttYXZvSHFmL3J6eDJ2Z0tpRklHYlZKY294WktJZmFqQWNncGdL?=
 =?utf-8?B?UDVDcnh1TVhTZElFS05zbVAyTDBpWXZpWTJDMmgxSXAyLzNQemRibjFjaUNs?=
 =?utf-8?B?Qnc5R0w4Q1Z2bjdHd1RIakdrMURpam5iR2VaZDc3ZUc1TTZLK2VFL005WTBC?=
 =?utf-8?B?Ullnd1ZTdWUrMFlPZ0pXcFRRaFlSKytPMmVRK09LSktTcUl3ZlpRb1FpUURJ?=
 =?utf-8?B?UUJFcEtkVi9zK3lJUlMvUGQ4V3UxYVN6dEZtbU5IeGlFK0drN0prbVd6dFNE?=
 =?utf-8?B?KzRyNy9QV2FWUndYdklaVDhYQjNaUndFR1JQWmF2RWlXY1NFZVlBeVpoUk11?=
 =?utf-8?B?WTA0MlQ0bDV6bW9hM0twTXhsdm9CbzBUUnVraTZTY1pPeUFYbVZZeldFdGZP?=
 =?utf-8?B?Q1pHQ1hGMlVzMjFiKzN4S3BEQXZWUnRPL0pOQzVRa2NsaittOE1LdWV6dHRm?=
 =?utf-8?B?SU1qK0hqdm1xUlkxdXBCbjVYUk1ieFpGTWpsRHJCVlhIK2Y5WUhCcCtSdUV6?=
 =?utf-8?Q?HsFORdhM+zcH3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0VnQlI4N2pVOFAvNFBzUGhXZVZycVZRS0F1NUZ0Z3J4a3RZeEc0SUdrbnp3?=
 =?utf-8?B?NVZXV2N0K2tKak9WZnREREhUQVAvNlhsWFU2RGt5UlhCZS9jaWV2ZWlNUUVq?=
 =?utf-8?B?MXNtTDk2cDc4N3lMaUQvWXhLQ01iY3lMMGQ2OEMrcGU4RGdFeTNMYWQ1cEZL?=
 =?utf-8?B?TkRHSGZQN2ZkS2FjdjNhL054SzE4OE56enpiNEtTZWRUVnhWL0VoK2UrRnFl?=
 =?utf-8?B?TngrTTUwQ3R2V3I3TEJUZlJBSGRLc2VEbndYWXhuS245eTRwam1TcEJQNXBI?=
 =?utf-8?B?Q1lJUlpSTkdhTjhxalkxQ0xiRXBvUS9neUtkUHBDZm5BbTRmS1pYRWE0bjdS?=
 =?utf-8?B?dGN0NVRMOXZpSVpzbHhlM2hOdzhhemFxTVpWMFdXVGFYK3hYdDFVbFNHMWk3?=
 =?utf-8?B?TnlDSUdGK0ZxcllnR0lwUE9Fei9uQWcySXpjTW8rbHNCSzNNUUJCVXlmOTQ4?=
 =?utf-8?B?MUluQ3ZUb0hPeXNjbVRkMXhPcGsxblgvclFLbDNSdE81ZEFUM3Eya0dJOVFT?=
 =?utf-8?B?ZTcxT2JuLzZIVEN6bmo4ZTZsMkk0dXdxMlg1M1dPOHpSNDVGYU5TczV4R3Zv?=
 =?utf-8?B?dHpMWDZhTlBkOG5ZM1p0eW1mOEE2T1dLQnZ6R1U5MFNVVUd1OUwyNlErSFd1?=
 =?utf-8?B?aWZ1dkhPclJ5dVZDNDA3RHI3MllIVE9SQXRnaW9CenhhaGVUTW9KWkJiMEFE?=
 =?utf-8?B?UTdsWTM5M1ptTmpZbmt3OWdhV012d1ZOamE2OVc1QWVISzBIbHoyZERMdHBv?=
 =?utf-8?B?VnlBWjY4TG1tTE9GVERwYU9jenkrdGtnVVZmVlJ1WnJzelFGRHlQZWp1d0JV?=
 =?utf-8?B?a0h2MFFaWXY4SVhBd3dzaFlFMm1vNjVGeEt6SXkyWEJrTXBWMDdnRFF2eFB5?=
 =?utf-8?B?c2hPdEFYYTJ6Z2lZT3AxWnVKK1gzWDROYkxycSsyNkFqamN4cHN5dTFuMDNn?=
 =?utf-8?B?LzJtRmVPVEU5U21BUE1nVHlJdVRScnJVU2hmZHJrZExrUlBYWDBNUGVDVUNM?=
 =?utf-8?B?WkdzRUkxalRaK1U0Sk8xRGx5SlVTbGpubCs0d1E3UjZLbjlnd0IrdWhOLzRt?=
 =?utf-8?B?NUxPYko1VEdTSFFUYlVXVnpQVWp3dFR5QitiY2tuSS9mTXprZXhMRGFUQmRy?=
 =?utf-8?B?bmFqSU40K0xzVWJRdlBDZFllZ1JEc0NXY3lUWjh0YmxNL2JHa01iWStzMHZP?=
 =?utf-8?B?UFB2c3RVUDRuRlVBdUx5ZzJ3L2hhaHJSNkVmZlBQRlU3Y2xOWUo0SjRNTnc5?=
 =?utf-8?B?MERGZXY1bjJ6bWp2R3NWeXpCU0lYUWlYOTl0ZlA1eGhqc0QwdTZzUmZTcnJ1?=
 =?utf-8?B?V3RQWlRocit3dkJNM0QvajdqYW1JM0V2QndnTEd0VFRMdjB3SjRuWVliWnFo?=
 =?utf-8?B?RXorNkxXbXFrRm54OVhMT09NZ3dwQVdodkxMOUxGUG9uOXlJQ2RSbVJ2aWVT?=
 =?utf-8?B?RGhtSUdzSStkM2JPN0xLNWtZMFdZdnVybmdTaXdNWUgxQVJGeUthSFdHMGI2?=
 =?utf-8?B?QVlKZjJ3VllUVWJwUCs1dHZldHdZUmN1NHg5WDRnVkdxdzFtOGovZ3NNWjV5?=
 =?utf-8?B?YzV0RkR5bVowZ0pGVkZweUJHaVNJS1NSamsvTnhiTXZDbVhRbjFnSWJFdmVs?=
 =?utf-8?B?aVBURERTbnoxMEtSSjJweHBPMkF5VUllQVBpSnNMM3FMajVPN0U3clpHMnh1?=
 =?utf-8?B?ME9LZk9VcW1PV1R3Z0VNc2xhR3NJYkZmTEs4Zk5hQ2JxbEdnOVBnUW1HejdR?=
 =?utf-8?B?ZXI5a1BTWFJFc1A0NGs2TGNvYTVVbDhST3hkc2wxejRqeGNOSENTOGZkWE9n?=
 =?utf-8?B?WHJ6aFBrS1ZjTzRhd1RwWFZzNCtFZ2wvVDNvbkVCTXdhZFVmWE5NNFpSaWcz?=
 =?utf-8?B?RDZ5aU53ZW9aMHJQR2NOdjZYLzQwQVo4SE1hOGRLYm85TTd2ek9UM0lRNnBS?=
 =?utf-8?B?U0pPUzlneWJMUnNRK0MreVUyNXptSWo5amFiamFTTW5mbzlCS0p5bDBtaTZU?=
 =?utf-8?B?K29uUmphTno4YnRqSDlaa3d2cmg4b2diQkdveU5ONnhQT3R2MEZRWW1PV25J?=
 =?utf-8?B?eTRUTVNSK1VlWWtnaEthQXZSbytab0ZTK2pQQkdRL3U5R3BWREZVd1Y2RWtS?=
 =?utf-8?B?ekYyaG1OaGJ3MzBnVEl5dVFBUGZlQVZUK0JDWE1VTWZMdkg2Tkx4clFNV08z?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5SLXdLJ2s17CEuuVCtRmC0gUQAI/aCAKHteDcIlPbYPHt7U0fyJySdmBJer0UEAj7v3lgEjpn53yQ7pkrF9ovHRJZ5jzXl7NlOQ60rGqfUXCSn8Fzv8XvIX0naMEHf25X1LBxyqPzScjDQRwy73klBKGHfsEiu5DP9tmawPjJO3+C3w7x296IDC1PcloGk0/u0tmuyx1AAIv6k2vAkEjygo4blPRObdnbrFfhcLxB/Mo0B193JNEaC1ESq+hPK2dVXmfwl0/vNQzKyIBxXa87q7M0MqZIzHtQhVJv5ZrH6vmgGZFBIJ8EgbCsqtVZDzGKMbuoZ0f/b2DbBY7XONdajGqjeiqaUz4xIYSIZeaCJ72hV0oValVsdB3iComuOFdZftf94IG4PEx/IvFxHdlSYqmEzgHlVozB6g7z1ilsqbiBUbenIOhtVk1uHoBrVWgI2xFzySSL5EU/n+M9I3+GVcPCRBIJXpTAgoPPchgPuhepfUqw8A3G30dX06/6hhGdU91CHdvCKHlqYAFazUHFwhQZDDeukvTlOOcTQ9/1vff+eS1UybyJppeI2QCkiObgNsTHJ9LsYVE/q60Q73Vk5dAmcZXHooAA9bbvOa3Phg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e7c6d2-bde6-4e5f-5ecd-08dd45cebb32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:20:36.5536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6+6UHvZiL2wjNmgU07v8dNFTQi7f/5GiEoM8JbV6TZ6hyEnS4T2LLYXIjco38HU8wqcCxyxppDmFDE3ZkNLEK1ZrJJRPmkJIgf59tGgHi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050083
X-Proofpoint-ORIG-GUID: YxpbcFlK7zT1uOwF59KehkhWtMM_5UkL
X-Proofpoint-GUID: YxpbcFlK7zT1uOwF59KehkhWtMM_5UkL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 05/02/2025 02:45, Suthikulpanit, Suravee wrote:
> 
> 
> On 11/29/2024 12:14 AM, Joao Martins wrote:
>> On 21/11/2024 11:42, Joao Martins wrote:> On 20/11/2024 07:31, Suravee
>> Suthikulpanit wrote:
>>>> Add migration support for AMD IOMMU model by saving necessary AMDVIState
>>>> parameters for MMIO registers, device table, command buffer, and event
>>>> buffers.
>>>>
>>>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>> ---
>>>>   hw/i386/amd_iommu.c | 36 +++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>> index 13af7211e1..3d2bb9d81e 100644
>>>> --- a/hw/i386/amd_iommu.c
>>>> +++ b/hw/i386/amd_iommu.c
>>>> @@ -1673,7 +1673,41 @@ static Property amdvi_properties[] = {
>>>>
>>>>   static const VMStateDescription vmstate_amdvi_sysbus = {
>>>>       .name = "amd-iommu",
>>>> -    .unmigratable = 1
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .priority = MIG_PRI_IOMMU,
>>>> +    .fields = (VMStateField[]) {
>>>> +      /* Updated in  amdvi_handle_control_write() */
>>>> +      VMSTATE_BOOL(enabled, AMDVIState),
>>>
>>> no xtsup ?  I guess you are relying on the dest command line having xtsup=on
>>> like intel-iommu
>>>
>>
>> Having said, I think I found a flaw here that sort of "ignores" the default
>> command line param of 'device-iotlb' (broad x86-iommu param). By default it
>> seems we enable device-iotlb in amd-iommu regardless, even though it's disabled
>> by default in qemu command line params.
>>
>> Should we enable migration I think stuff like that starts to be important to
>> honor given the compability issues we would have to deal apriori. See below on
>> how to fix, happy to formally send if what I explained makes sense to all
> 
> As you mentioned, AMD vIOMMU currently ignore this parameter and QEMU default
> dt_supported to false, and set the IOTLBSup in the IVRS table to 1. If we start
> interpret this option, we need to also emulate the following cases when
> dt_supported=0:
> 
> * When DTE[I]=1. From AMD IOMMU Spec:
> 
> I: IOTLB enable. Controls IOMMU response to address translation requests from
> peripherals. 0=IOMMU returns target abort status when it receives an ATS
> requests from the peripheral. 1=IOMMU responds to ATS requests from the
> peripheral. This bit does not affect interrupts from the peripheral. If I=1 when
> Capability Offset 00h[IotlbSup]=0, the results are undefined.
> 
> * Handle the INVALIDATE_IOTLB_PAGES command, which also needs dt_supported=1.
> 
> Apart from trying to be compatible w/ the x86-iommu dt_supported param (which is
> mostly for Intel vIOMMU), I am not sure if handling the dt_supported is
> necessary for AMD vIOMMU.

I agree; I certainly not suggesting going out of our way to support
device-iotlb=1 with my command. We could throw an error and fail the amd-iommu
device realize if we wanna explicit that amd vIOMMU doesn't support device_iotlb=1.

> Do we have a scenario where we need to disable ATS
> support for vIOMMU?
> It's closer to reality that ATS isn't quite fully exerciable in Qemu (until this
series lands IIUC:
https://lore.kernel.org/qemu-devel/20250120174033.308518-20-clement.mathieu--drif@eviden.com/).


My whole point was to honor the default, which is disabled and not mis-advertise
it as being supported. Specially considering the cases abov you point out look
to be be obvious gaps that aren't implemented, all the more reason to not be
misadvertising it.

