Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A74C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEaA-0003XC-J4; Mon, 31 Mar 2025 08:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzEa8-0003WJ-4V
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:49:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzEa5-0000AB-RW
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:49:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VBu2mu021087;
 Mon, 31 Mar 2025 12:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=/zF1tqhC4S6aeR5xtrasSPgeU5B++6A31+mRZuFhmXY=; b=
 adnqP8YdEEql114JjqK3Epz089RGqKGM3xY+tmFHzYtFTVo0bWGvRinbjddFvbfR
 /p2vY3gTY5EyCpO9gznthpNHW+ElHitvL61p9UeWY9AfqHhsBwK7uCbACftpiIbr
 FReeqTKlR10d+fVhcPZfUJnnbFT0tpBDLlw07uIK3kdFnaV7ZmmoFve7IH7lul6L
 WQoIlh94sCf8gNTiWB1OScyn2pAEbe1Xmi6ZKIEKgQ6mGEWDaMr7HMVDhZ3G5W+M
 Ew0rJu6uQTtwIrbkp3pteCYJyfCStxIGxCtqIBKUVOGtT20utGNe9gj91KrUdsj0
 6fMQ6xLmP0tgcq3nIXHy+w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n235j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Mar 2025 12:49:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52VBjl7k002596; Mon, 31 Mar 2025 12:49:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45pr8nsmyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Mar 2025 12:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJUy1nzNqduEPlZ4iB/ujqfKg5fRW7huT99X5MJ/2jn3IuekM/npZDW93v7ERxk+dyN7sgjEpm1osQ227aMFCf2nhZkfYLICFOu1f7J50Yy3gjorE0MldZLbFM01V2wT7cmkoDMY2Ih601QydiIrs3ioTnKrKEBx3vACoYTV3hjZBok4uPEUchKdA5Ox6qo+BMMnQoqoJGPCbKgM63giLMuye504ueUqrlKV9trH7A9H1VGWU9o6KQkaBB+rWpnmgpRhoBZwqjTex8isYhuuUYdJ24cR+qNfsmMarCJMs5AGTaW623k9m4Ijk+hQnhVWRBknD2GJp0GSN/6Ug/2NEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zF1tqhC4S6aeR5xtrasSPgeU5B++6A31+mRZuFhmXY=;
 b=jTF0T3d99mWycygSevDKbDugbnnYGz+CB1B0i9UL4KIoq3NT2XuDZ2ZpI7mKORqMyMpPlpDRrR+ELCTQ1JTkDftU8m6AX0T9q/D9SnoUyE/VpHjKXK84CWIYSTp3MnE0yIDBGH4g9trIpER1hbnlEMjzjLoDdAYxWr34Y6QzaAGCFg7E0hqp8XCO3fF03MSz0xZ7J5/ng234MIvBtLCDqrddV27dbClPfIm3haT71XsDKxOUbGqQEThU7LwMEFGkVSwVeBtB0qWdbr/XgEAPnYcQWKuw5//noNH0etjXqytKim9Eg6c2wieXAe0RtoE7Gz20ZZ8Fli9s1Xt+IqmEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zF1tqhC4S6aeR5xtrasSPgeU5B++6A31+mRZuFhmXY=;
 b=o4Oq6uqQSeK4T7IgcgB57uEBnH/IajK4+xYxYKTEpzV4QuI4uXJKR3MqqkORJW1DwHkVZgMc2hPhp3YBP8QzB6Qjn+BL7pC1FRRisLlafyg8r4wmqXm1sqvoM6ty0MAFMGud69XYv7KcXu7U1JtyPNNrXoCdfKhPJEmkfUu1OLQ=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.31; Mon, 31 Mar
 2025 12:49:21 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8583.033; Mon, 31 Mar 2025
 12:49:21 +0000
Message-ID: <34dbe4a3-7c4c-477b-a41d-98f0636d1f61@oracle.com>
Date: Mon, 31 Mar 2025 13:49:16 +0100
Subject: Re: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-31-clg@redhat.com>
 <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
 <3bf1ab06-4411-4d19-afad-3da2e62cbd9d@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <3bf1ab06-4411-4d19-afad-3da2e62cbd9d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0030.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::35) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3179744b-76f1-42e4-69eb-08dd70527520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWwrT0MxRVVDaCs1cUI1UXJqT0lhMkh5R0hia3NQQ3JFZGlwcVhvN244RzNw?=
 =?utf-8?B?a21TaCtuVXl4WExrQWYwM0Z2c1dScTVKd05oZzBScHpRMHJWeWFhVFpjbDFE?=
 =?utf-8?B?VlZXTE9KZ3pvVlN3Ui92MlBtZGdwWEJuYUUwTUY3RjBCQnJ1Ym9IQldSQzk5?=
 =?utf-8?B?OW1QbUxvYitieW0wcDg3dHhFdHJXOTdjbVFNQmtmRDRITGZ4ZWdyVkhlNm94?=
 =?utf-8?B?elFYZzZHRnhRWU5HcnFkemZ3dlM3Z3FFRFFUaHVMNzYzZS9zR0JMZFdTVlZa?=
 =?utf-8?B?ZVp1a25WRlpuc1BXa3lsN00xZUV5SmwzR2tteUw5YXBzbzZJNTRSajh5UGhQ?=
 =?utf-8?B?aDlhK3BWM0lmRTlzMGljQVJCWVF2YjdRWHZESWFxYXV2NG1JRWR1OHRXeWFN?=
 =?utf-8?B?ZWhNVE9SNVZaTE5rWFl4cFhsTStpa0wzQ0t5MlB6N0J2ejdWWERBeHkrSGxD?=
 =?utf-8?B?WElWSzJrcEhHVktZcXJJUFcvTEVzU1FYNXRxNXlxeTVzUWdUTnR5bXcrNDFK?=
 =?utf-8?B?VGhQYzZrQVRMRzd0K0xDZkFFMk5RYXVCenUwOW11djBWcEdCZFNJL2lPUlBl?=
 =?utf-8?B?ODZqNm9SL0p4UTBmMi9kUmNwcW9nZHpiSlJGR3VKMXliSmc3Q3BTQlpBMW1H?=
 =?utf-8?B?Znl0Y0hmQkg4d0VvbjFpbkpEUFNnTGF4SGNpRjBJZ3NCdnlOaGdyZTljVzlj?=
 =?utf-8?B?QXVGd054RzFDMVJsMlF0YlV6UkV1VzQ0K0pwQTlHMXZLNit4cTh4dkxTMHEv?=
 =?utf-8?B?Q1VLTlFzckFlZ01SWWh1MTYrdkwvMnBhSG4wVWw3Z21KOG5zbktnN1A0d25R?=
 =?utf-8?B?cWtub2oyTGpLZE8ycENIazYwVDRwNkN6MXNTRnVvamRaamlhVTNSeFZZU2xu?=
 =?utf-8?B?UEpRTWgvaU52RUg4VXpBdGg0allNQVJ3QTQ5SVVHVnRsbnJmTmw2Zkxaa0ph?=
 =?utf-8?B?L2FSa3N6c0ZIc1ZsQkY1TW1yMFF5ZWJJR1dOY0NuWE1RV2JXV2ZjbGV6ZHBy?=
 =?utf-8?B?YkllTFpDODh0U3BLcnRsS2QvSlJMaHJsVThVbWEvWTVHeHpWYUthMllTdXp5?=
 =?utf-8?B?Zk1iNzZ2NEtMaVorSTJvVUtqQldlOTFmZVlOaCs4ZW9RNFlyc3ZDbGZNMzRZ?=
 =?utf-8?B?MDJGaXcydWg1dnUvZFJPdVZBU0ZyNEVvWTJHbGpxU3ptbWZIOHczMWNKMmM5?=
 =?utf-8?B?SXNmbXJ1VGNHaXByRTgxbzZlNWhxczUvZkZqUXhnQmZSN3hRS2RSVys5dnpU?=
 =?utf-8?B?Q3orNm9HcW8rWWtpZUNHemMrZng3cTBRTW9lRjhudXFjdWM4cnpScHUzMDZx?=
 =?utf-8?B?ZlR2Mm44VFFtbFczUzFKSUlrSGJWQmluKyt2b3BhSzNOL21pNFhGWEJsK2x1?=
 =?utf-8?B?K2E5L3dRV2QwdS8wTlhTQ0l4TTdpMjhibFRzekwzck5LMHNsdjBQTVFEK24y?=
 =?utf-8?B?US9aY2pNQU1yWXd4UjhXSHpFaDMwVXpjOWpuSmNIdTZiZHNvTUpzaS9GN3RG?=
 =?utf-8?B?N3hYaEpIV21UTE1rL3RTVVdVWVJtam5DYng1NExFRjVJODQ5QVRoUnNuY3ha?=
 =?utf-8?B?WXppVnExam9xdFF6Z1Izb0VxWjZScm1Zd2tyc3d6UGd0UDZkSXV6cjFFL3pj?=
 =?utf-8?B?VkVEWFhiLzIxUno1cXI4TExMbkRUeTI0dmx3aWoyZEdhaUZTczhhODYwZFFo?=
 =?utf-8?B?Vmt0dnFFbFRqdEFzL01MUm1obUp3c3JZYTk0aXlUclR4L2grUGpUcmdJSFFP?=
 =?utf-8?B?MUY3VGtKOHBTby9LWnBsamdoQkRqZkpUb1J4Zy9mZmU5dXVlRHlPdEIxVzJk?=
 =?utf-8?B?NSs3U1B2ZmhORFp1cFMweER1T2NqRTNmTHJPOE84dERROHZmWjl0ei84RktB?=
 =?utf-8?Q?Had9vSdmYKFZB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzBEZ1htazVZdnlhNHdTajFXVzZsM0tGY3VlSGtKTS96a3I5bkMremo1ak9y?=
 =?utf-8?B?SzhHKzhQUWppVnRGWHppd05oYkZQUm56NHpRZXNNbFNwZXg4K1JWR09LaVR3?=
 =?utf-8?B?THRDSkoyTnlwK0xZZDZzUEs2N3NKaWpHb2ZldW9hTUltSWRPUm9BcEhRL0F4?=
 =?utf-8?B?VkdRNjBPSEF0bDlWWXdEREovMEVTN2FqSnhIZm94aDJxYlplRWZVaFpCZUk3?=
 =?utf-8?B?bTl2aUYxVjhNai9KV0p5M2RqeFBCVjluNkNpclZTYXVLT0JlVWVtMUk5c1hH?=
 =?utf-8?B?bzM1VjAvQ1BRNTRrcnBXVFhTZWlQbFRWY3B1c0Z1dWxvWDFZVlFmdnBrYUlM?=
 =?utf-8?B?dVJrc1dEeFZMdW1UcElBQTBDa3BXUlZOMWxRYXdCOFlDazVMSFY0enFXMzhm?=
 =?utf-8?B?ck5zWlVlV3ZXU2JJbkFZM0MzaFlUbzFkZVRVdG1Uai9qWTEyOEZNWFNyVTNl?=
 =?utf-8?B?R2JCZGRxSUx0T0l4UG1oalROSWU1bmMrd3lXT3Z5eFYvblRFMGJBbUR2MXpF?=
 =?utf-8?B?a2dBVUtPQkJYVXVGalhyVytabGRtRmU4RlBYZWRmclBzdUZYMFBzNEppNGk3?=
 =?utf-8?B?a3dWdUZlNWYxUUZKTkdDNzE2MlVINjhya1RuRzgxTGxFR0FGdDI4ODFqaSsy?=
 =?utf-8?B?NmJRQzZWREk5Y0lQdHp2UDJnVmEzMjhma2VjSHpYdGVFNFliTFltL1kyVk0x?=
 =?utf-8?B?QU5BeS9ISG5LbkZmUDJhNC9rb0tQRzl1ci94YkpPMTZNdy9ZOVBaQm01RDNy?=
 =?utf-8?B?OWdmWEtYR1ZUdDFJWEdXWXl5WDZCaFJ3WlRWbnpza2tla2FRRmYwZ3J2cjdO?=
 =?utf-8?B?ODBGQXczN2FYMGxWc3d6M2hIQUpGU3FPTlJvQ2ljTzF3VldoRmV0aXM4N0px?=
 =?utf-8?B?dzRrRGRla1NjcDRqaldlVmNTQWhEdHcremIrR3pxYy9XRVVjaVdOL0xTQ21E?=
 =?utf-8?B?YTluUndraFBIMDh1SHVlNzFSZTRUOENpUUJzQ1djQ3FENDdGeno2alU0L0Yx?=
 =?utf-8?B?ZjIxU1hyaHhKc0g0RXkwKzYrQlNxY1o4TzFRUUEzQjRkaDZaV2tmSGhxK3NC?=
 =?utf-8?B?bjFKS2JCNzlrSDF6WU9Obzd4WlNSSVg5U0kzeVdHdVh1LzFKQXZxcU9FSjZY?=
 =?utf-8?B?dXFWL2tEaUM3N3V1Sk44eEtKenN2NG5sRS9Kbjc3TVl5bEpGY010SytMMCsv?=
 =?utf-8?B?eWI2TkVkdFl6czhhNDQ4ZGRhMVpjSG1Nc0pFUlkwb3J3dm1vMFp3cE5NcHBT?=
 =?utf-8?B?cjRGMllhZkdJSGxjelhDMWJMZUh6M3lrS2tIYloyLzRtTVhaQ1FmWm04NGRG?=
 =?utf-8?B?U01uVDBBMHpsdWhvdEVScE1Zb1MybCttRGF0OGhYZ3FmZVNiVHpBU1p0MXp3?=
 =?utf-8?B?OFVuR0ZZTWhYbGNIQ1kyaW1DWkxkYnJHeVB5djNlTXhoTU5abStZcWxnZXJZ?=
 =?utf-8?B?YlJraGRxTitXbm5hV0FTbWNEaDhsdE1MRkYreTZRWW5lWFJ4VkpMZ1pXTkRZ?=
 =?utf-8?B?enZRTGoyL0JPSWlnTmNXZlIzRUFJTVdGR0NEaWZwczU5QmtGNXpzM2pjRHEv?=
 =?utf-8?B?cklFVWdGK2hac0czNjZzSFBtSFBSZGxrS05PaXFGNldFTmlrTi9iNG51Z3NM?=
 =?utf-8?B?VzRxZDF4Q3kyWFpTYVVKL1B0OTBTWXNRWTRnY2ZmYnI2aEdoNkFmNytlTzJ2?=
 =?utf-8?B?Q0doT21BYk5GeDd3cExrZTZwWUNTRkgwTmNIRmxKaHV4MEM0aXRFVWQ0aHFO?=
 =?utf-8?B?b3krc3FhRGhVSkE0bWtvZ0dSRHF0STNTODVXLzZOZ2Vtd3pQdGNLai91VW1o?=
 =?utf-8?B?QjRWd0Q3M21RZUpscWZsWnltMXkwZ295cWNmTUJJT0dydS9mK2k3bGlOakt0?=
 =?utf-8?B?eHc1cGRkaUhjTVVaQ1RaWDRyQThBSzVhQ3dNbHZDWnlDcEpNcWMzb0NLcGRt?=
 =?utf-8?B?TjVsaUl2bE5OYWwvNndsM3hWWEhyM1dqVG5YT2U4citNUVU3MWFxaTUyMjh3?=
 =?utf-8?B?S2RVRExoVlVpVFIwc1g1QnBSNzVLR211Vkp5U2Y5UUNnd20zVFNOTkNWc2RJ?=
 =?utf-8?B?Zlo3ZG5maFRENGFlNXp1YktnN2pNK1VBMDNaenpwMllsUkNFWkdIdlI0WjJo?=
 =?utf-8?B?b0NCSGZtb0NEMWhUb1I5K2pUZ0xVRDBiWG9aZXVJZTlxdVpCSzFLNkVaTjIz?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NR1yzGvXuLjdcdX7ksZKXlwjQ68MryX7vqDxcPeVDZOz8ay8u0l47EuWkyfJKW3HiPvEfRkEXBxXkFPgLMvA7cgZdnj0yW8gOInDCodjQeON8Y8q0GWsHV4h5iasuY8jGROLrTNhBEeLZx9AlasIFGYiVyqXc4/vSqFx1yWusygu2e0ah2TCNaZV02TjC8yk+kZGtU3HqfccI3hxb9OKtO7cjRvgt+6HucyUiPCdaOkxNIFFjteTU+mey1jWUJxPzvxmWYykkSnPsiGxzpvnXIwKqaot5ih3G6pqxsbD94J8HySl71aj0oMNAvH/UVwtD28zBXFN3bGsPW4egPl/gAsfq7HppylP0tx1ZeDyuMbcZGlXp0YWKhDU7HqENI0beihr+vc6Rwr6dw43Kwzf+PWLx5jZ/8xK0MGNOIuS/XS0zt/Vjqhr13O0bAe+Hm/8QVemZp80sG7gKDfKFiO7hIlS1gSsURysbtaLnMj8FCcnlr8kVg4hx1ssLkPmxA3MCGs5N9ypgMnrmwjUpTEXTRqNJ2w5rpIsboRZubAqyVhlLJVfxwz1d4dP4kMZd/YKFQQCegPP3klf2Hf9t0h5Rr23ONquQW9BW9LVAkjjoZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3179744b-76f1-42e4-69eb-08dd70527520
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 12:49:21.4104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /16Nq9pLMyoy0lkvLfzvT54Q2PX+hRS+yYIp00EnYrSxRV9D5oB6sbefHRDvDbqqZVsQQF9/Aq4dH6g4MABVY3dPu1rd6y05YxvTqrvc0js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503310091
X-Proofpoint-ORIG-GUID: CB5O1vIgtc9T-J4ZFT5BSwInCHgyhIVa
X-Proofpoint-GUID: CB5O1vIgtc9T-J4ZFT5BSwInCHgyhIVa
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 21/03/2025 11:22, Cédric Le Goater wrote:
> On 3/19/25 13:21, Joao Martins wrote:
>> On 18/03/2025 09:54, Cédric Le Goater wrote:
>>> Rename these routines :
>>>
>>>    vfio_devices_all_device_dirty_tracking_started ->
>>> vfio_dirty_tracking_devices_is_started_all
>>>    vfio_devices_all_dirty_tracking_started        ->
>>> vfio_dirty_tracking_devices_is_started
>>>    vfio_devices_all_device_dirty_tracking         ->
>>> vfio_dirty_tracking_devices_is_supported
>>>    vfio_devices_dma_logging_start                 ->
>>> vfio_dirty_tracking_devices_dma_logging_start
>>>    vfio_devices_dma_logging_stop                  ->
>>> vfio_dirty_tracking_devices_dma_logging_stop
>>>    vfio_devices_query_dirty_bitmap                ->
>>> vfio_dirty_tracking_devices_query_dirty_bitmap
>>>    vfio_get_dirty_bitmap                          ->
>>> vfio_dirty_tracking_query_dirty_bitmap
>>>
>>> to better reflect the namespace they belong to.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>
>> The change itself is fine.
>>
>> But on the other hand, it looks relatively long names, no? 
> 
> I agree.
> 
>> I am bit at two minds
>> (as I generally prefer shorter code), but I can't find any alternatives if you
>> really wanna have one namespaces associated with the subsystem:file as a C
>> namespace.
>>
>> Every once and a while me and Avihai use the acronym DPT (Dirty Page Tracking)
>> when talking about this stuff, but it seems a detour from the code style to
>> abbreviate namespaces into acronyms.
> 
> I am ok to use a TLA for Dirty Page Tracking. Would DPT statisfy everyone ?
> 

It would, but the new version looks shorter so maybe we don't need to go against
style with TLAs.

>>
>> Having said that:
>>
>>     Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>
>> P.S. We could also remove 'devices' as the prefix for VF dirty tracking after
>> namespace, and thus drop 'dma logging'. That should put 'start/stop' a little
>> shorter.
> 
> Could you please send your proposal as a list, like the commit log does
> and let's discuss.

The idea was :

vfio_dirty_tracking_devices_dma_logging_start ->
	vfio_container_dma_logging_start
vfio_dirty_tracking_devices_dma_logging_stop ->
	vfio_container_dma_logging_stop

But honestly, doesn't make that much of the difference.

I'll have a look at your v2 hopefully tomorrow or Wednesday on the device dirty
tracking parts and iommufd dirty tracking.

