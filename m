Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2673C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BxT-000848-H6; Fri, 11 Apr 2025 06:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u3BxQ-00083i-Cg
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:50:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u3BxO-0000jb-7m
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:50:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAhudF009130;
 Fri, 11 Apr 2025 10:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=IpDLUWOukYoPLY8fV3l4sjvTVTtx8Piixl1g0o/Llp8=; b=
 mptmUSo2bBsxqCUhCXLVNVFbIdzs1TKlyCS3h9znJ/z3kD+9eQzZ5845uK/b46u7
 WEiNEjKq/JchRd++4xBsta0Uw8n1f3a5gRIshJ3G8ADSBiCjGKwpOR4g26cagbXm
 vaGxhmkOOS8TFBO159hvx4m+hiikOCR/JC0ptM2ZJiXUni382UlTsgdWyRbxRIbJ
 obG0KipQe6S847lQfKnrlJXNsy+BYnEzryEjpW79Yg2f6bpYl1rjpLCjgYXj+gsN
 ucMt3s0+aKarZgq59DRxtypeV+EtOTlpCCpz5/40Z/RGBJH4Pu7PE3Rlef8Pw1mB
 ngja/PWpEwaTikUraYmNbQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y1j800ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 10:49:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53BA07eF001297; Fri, 11 Apr 2025 10:49:52 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttydgue9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 10:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYzcBK0TnddB2jPqMlViuHR1SW9/7kGMFc9SJKhNES+D55waJuw/DfJGj0WzQycGcRgE/PNDbY5du0OHCVRN4uZHKwfputU1UjfT0WlFaJBQjRlALpKDgDAR3fhg6USsl3hBZT7YGbypM295iy+eP0H8kQjg3OQk0Xa1kLwAi10LafdDwJRV1eeXDbMl6ZmMATv4iGFZIEew/P21Dene6+Ym9arfA/J/P22dgu3TgWaXj+aj3hclMyqZc+5Lw03IOwuQlLQur6VbCZJfs4LzHWDx+8/gVOSxzdCgvYd+hm09KC4re2RKHORbAt11rCO0D+z+NeKAIaqZxq4Ao9GLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpDLUWOukYoPLY8fV3l4sjvTVTtx8Piixl1g0o/Llp8=;
 b=EU2gs5GiIQk2Umua9k/qKtw7mFMZlp/l8/EuqV3IxLbZ8lRpkAMDG1MEKTP+p9gI+cnIsXkFHuNNFppbkoi2lG6osUllpfvW8xvFZfWVo3toZotN3LnhW81uIbqusxkn2NdX332rcpwjkrLLK719hCJS4P/mpOXOZeNWjwqxW9G5xD3l5oKlRPtRQzRCjJPX2hibz1sUPJ4KItD9qEz/Hln2dpN7zmauGZq2z0a0vpf1nVMOMkMP/JBuUycGv4atDhPh/JXY7K59ddKzVYjTLWkfDAP4PEJNkXEuDetvthwiyVn3Zu8skoyRp19X9Pkv+CEnGehOwl7hzftwZD32Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpDLUWOukYoPLY8fV3l4sjvTVTtx8Piixl1g0o/Llp8=;
 b=DhcFiggmcHMbSya1yZfDvXAioy5oX/HeblhavQabPL/PyoB0bq+Y1BRmGNcjjN+gJhz+4Rt3TGwdc2mYihd/Yam3iot6ZTW5oJJGrXuRG8UzhAW7N0Nh9kiFdSuzohc3QUL7ipFSpZR0d5STErrKHefvwWrWKR4Uv3+k625bTxw=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by LV3PR10MB7772.namprd10.prod.outlook.com (2603:10b6:408:1b4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 10:49:50 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 10:49:50 +0000
Message-ID: <2fc17189-2154-45ed-b9f2-e67583651f7a@oracle.com>
Date: Fri, 11 Apr 2025 11:49:40 +0100
Subject: Re: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, chao.p.peng@intel.com, Yi Liu <yi.l.liu@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250411101707.3460429-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|LV3PR10MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: cab339ea-f574-44e7-907d-08dd78e6953c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDRycENWMC9iaHB4WFFiTHZBVFdzbXE4TDRGb0tEcUlCSTUxZG1oMjRLVUs0?=
 =?utf-8?B?SHhvQmxtZnVRdUR4Y0RrTGFpelJneWpWK1QrU09xNExCTHlXbllHZ0dOcmY1?=
 =?utf-8?B?a0trS0J2V1pDSEVqYnJIdC9rM3FhV04zOGtKYU5EbWt2T3F5MjFUTmp1KzJV?=
 =?utf-8?B?UVE1S2NxOTFKQlFLSHJkK1ZOMUFKQ21GKzVEdE5ydXhJUEY4TE44NnJpRUN0?=
 =?utf-8?B?ZFMvUW12YU41U1g4em1scGlaek43K2dIZjlNUXVHeUwyWGV5OVhvTWxGWTJ4?=
 =?utf-8?B?a2t5NWNWaElrSHYweFNTVUR5MWV2TVFrKzZrVnVXSXJDcDlsQkM4V1JxenU1?=
 =?utf-8?B?TEoxckZQNWt0UUNaZHNVMkxiUDhWZzlUajV4RU1yVitpRmp1K1pUai9Eb1Nk?=
 =?utf-8?B?RnR6WkR4dkVJallZQzhmYWdTUm85T01ZbXpxOUgzWUd5MlUxMmpPSjFTMjZY?=
 =?utf-8?B?ZkYrMXhyOEFrMmlpam51WVNudnE3cWRDVHNVbjVVTnhtb0l0UjlDaFlkaHkv?=
 =?utf-8?B?ellUUUpGOVdKMU1wUW1QS2RPZ0NQVXVWNHFIejFmTWdFZnFjUFdvRzZTVEV3?=
 =?utf-8?B?cUJhbnNwTjAwVm05UzZlQTlSUW5nTWxySXpQSzZTRUljQTBIREdRbWJ5WTZ3?=
 =?utf-8?B?elA1ZElGSnI0Tlo1ZVpvT0ZQaVY2WkZRSW1oRSt1Sm1UMmx5N3Ric0RPNDFR?=
 =?utf-8?B?ZmtkclVXdWJPbzJ0ZXA0b21YWUFFWkM1WEdRc1ZmdGpqb3pJckEyRzV0QzZy?=
 =?utf-8?B?VVFwb3l1UHYwbWJwc2xubHdyZnVncGdZcUlhQ3hwcHVRRmlxcXhUN0krWjJN?=
 =?utf-8?B?MlRKZUl6MHV3Y1hkRndEQUdzYnB2T1I2U0VIR1p5bCtNa3FNdFBYV3IzMC8z?=
 =?utf-8?B?M3Z1ajBWanFZeUJ2SG5GSmRxZHRzWG1PTWJQR0N4ZVB5dGh1NVNZa3QwUGhW?=
 =?utf-8?B?UzJObkx3MTJSTGJaWUp5Z1pSQUhNV3pNN2VUendta3VYcmlac25Uc0xYSmYy?=
 =?utf-8?B?VFFRZCtKaEQrVmVNVHF5V2FXYmRSNXQ4M0tMMU5jc1hZUUsxVHpDTTZseVFM?=
 =?utf-8?B?THplelQ3enZ1c0VxOWlzRGdVcnlWb0Q0YW9wVEJMaWI2Zk40aE1lenRtWEpG?=
 =?utf-8?B?SzJOWlo5SXhuMkFyTE04YjlwcEljRzluN2IxcmhQdk9FVmdTOFZDc3hkYVBL?=
 =?utf-8?B?N29DTXBkL0dHbnJ5VFhsbTNWTnVSN3Y3VlppNlNNUG9UZlZTanloM2JKUVl0?=
 =?utf-8?B?czFBTXBkMUtFaUR0M0xhV1lwOWx1MHRXcTBWN3V4Z0RmdDVjU0NXYkRkMGR0?=
 =?utf-8?B?cGMyZ1lHV2FaSDRkWis3K1AwMk42Tkc2UUJPUXRHOXB6eWRpNkpQekJzbVVk?=
 =?utf-8?B?QldYY0UvOTU4OVFRWnZXZWdLS1Y3Y1ppdytGMEdxS1RDSmF6YWJoZm51NDI1?=
 =?utf-8?B?U1hRRkhDempZM0Mzd2VHU0lCdTV0TFBDa2JRVm9rMW12M1FuKzNvM0JmR3Ay?=
 =?utf-8?B?aUZURU5IS0RFcVVueWhuMk5VYUs4T2pSdm1UUTBGN01jc3pqWkIySUZLL2NC?=
 =?utf-8?B?NHJxbHRMS295NVhHZ3Yzbk1LeHBIYWVzYk9HRzhMTmN1WEJuVEhSeHFnRTlJ?=
 =?utf-8?B?Vjc5bytDY01JZ29LMUI1cGFKOVdhNFZLYVNqa201VjVNWk42R1FiWGhEOXps?=
 =?utf-8?B?UXVKNGwwRzE3aytyZjFxUUI4NHV1Z2FUZkRRaUttclYyZFUvQVRkRjhTMVVP?=
 =?utf-8?B?b1Nwei83UlJJd28yZ211dDlDQXZVdTl1L3A2N05CV3J2bndSb3dIb2tuenhJ?=
 =?utf-8?B?ZG5TRlpPa3ZqY0lMbGJIWlJXNmN3SzJNenZSRGdoa1BIZk5LOHJmZkVqUDhr?=
 =?utf-8?B?MGdBMC9rT3pyMFVpRWNTM2xPOUorbEFBTEVCZVptb3V5WnQ1VXY5Y2N0andh?=
 =?utf-8?Q?0+5WHVnab1w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdsVnNkZ2c1L0ZzbFpVWUF5RUxHZTIzN1EvZ0poc0ozSzREalFSRjlaL1Q2?=
 =?utf-8?B?TEpqQXdPRlo3NTAyTy92dm9sYnlKYW1XazRSTUtLZkwzdExGaWJNN2N4L3V0?=
 =?utf-8?B?VmhOOHJ1RE90L1I4MjdaWEtyMFIvd2lvSVJybnVmWWZQcko5NTVWeHNwT1B5?=
 =?utf-8?B?WXhvZFp0bWhkT2EvcXkrNENTMFBUWWtZWEZZMDJaYk9HS0E4ZElacVBGQjRB?=
 =?utf-8?B?NmFxVHM2cCtBWkVEWXFUbTIvOUFkdjJPcWc5NEtMZXJLOVd0V3owZldaanR6?=
 =?utf-8?B?TXByeUZXeE1EZTk0YTMzRmpQMHg0Q3JvQWk3SEMrbklaWE9vRmJSOWR6b2tZ?=
 =?utf-8?B?aVN3ZG02bk5WOU9rVXVXK1hXa2NRamc0NjgvWVFuMEk3dG1aWE1sZVREdEg4?=
 =?utf-8?B?eUZyQ2ZMeHpUSE1BWi9Ra0dBc2lCcFY3RzJKeXAyTm9OdCtvRWRpQld0cmNC?=
 =?utf-8?B?azhNR0NzRkJHWFlRcEUvbXlWVk1KRlA3bmtpaWhYV0JFVEZpYmtPQ0EwQW5t?=
 =?utf-8?B?RnZ0cDgzM3lad1BIaHZuYkVTYlhmSmthY1d1UnkzOElJckxnMlh5dndsdzgz?=
 =?utf-8?B?ck92WEI5QVVaQ1AxemRTUlRybTZ2djBlb3UxcnF4WWZWY0tncWo1bVBvTTlQ?=
 =?utf-8?B?a2ljQ25UOXNaZ0JjanI2cWZ2b2pvaGZYeWNpdnBsQWJ0OGdhZ244bVF0dFFG?=
 =?utf-8?B?TzVZYlNBR1ZRaGx4THFSQXRvTVdiMElYZDgrOUJVeDJnMzhWM05WR1I0UGNC?=
 =?utf-8?B?ZjJLZC94S3kySjRockxJbGxuaXB3WitlL3Vta2dnOE16dHYxZnpSQUtEbzQ0?=
 =?utf-8?B?K0cwM0duWlNRbEFWRndRT2p6VFllek9pc1h6K3Z1eDdzUlFwaFhBWGxkWmxZ?=
 =?utf-8?B?WGU1NkczRGFjVTROdjlGM2pucncrTWZGanYxVWtxVmFsZmpoaWtJcFZTMW5u?=
 =?utf-8?B?ZHhHQUpha2l0M2RQVXZEZkVQd3JVVldnaTVkRkZHT2xDSlV3TVVLNjZRRzBh?=
 =?utf-8?B?UFB0ajdRT2pSNWJ6Sit6VFhKSVU3KytBbkpBY3A2elMzeXkzRWFQY055RzNl?=
 =?utf-8?B?RHMrR3N3dTV0dkRCMStMR2duVTUzMGFEbHFGdERJNWgrejh2OFl5MXBwQ3Qx?=
 =?utf-8?B?MkpQYm5RTWZFNTlMdjZJQ2ZweFd5YWl4bit4OGRXV2tzTmVVcS80Skg0cTJO?=
 =?utf-8?B?VVhuTlc3UnM0QXBBVEVTSXh6bkV2dTloR083bHpTclc3UmlxMFVPRW9yQVpp?=
 =?utf-8?B?Ly83NmRFVEZXMlpuY1NmYU1UakdTZ2RVcVdmN0haNkg0Ymt6d3NUWTFpeHRi?=
 =?utf-8?B?dFU5SGIzTFYyaXFEcm5UVDNLVTBpd0k0OWxhMjBPN1hVY1VESCtqSkEybm9O?=
 =?utf-8?B?d1o2a1ZKcHJQZEJVSnpNZTlTeG00Ujlpc1BGZ20rZUFTNXVGWGtrcExncXU3?=
 =?utf-8?B?TkU3RkRjVlg4WVJmeVpNaTFzM0t2bXhxOWMwYzllak1kYXBvZmkrckhiZ2NP?=
 =?utf-8?B?R212dXVJMVVJMWJIT3ZQTkxWaWVzemlPNkpEOGxnN1dNeFozYlllOS9PQkRG?=
 =?utf-8?B?NUNYbGlVMEVCdkpKRDlTdEp1TEpNYjY5VU85NGNBUVJncnBCcjBBVExhMjNx?=
 =?utf-8?B?K0QwUXgzWi9HWi9Ob0NXQmtYVVhYd05yWDVUYndYWVJyY0Y3cktaZEo5cVBC?=
 =?utf-8?B?Y3ZVQ1JsM2xHSDJhbHVPbjRZdzJHeFA5RjJ1M0JQNDRpNWV3QmxvdzFKQXV6?=
 =?utf-8?B?dDNzYTl2WCtyK0NUQkRkb2NJV3dLek9Vd2tvb0p3eGZlcFh6VjF3MmhwSi8w?=
 =?utf-8?B?dUROSDZIbnJhMHB3cjdlVEtKcTI2NkM1VC9FUkFVa2JDeGdMQnFqR05NTnJs?=
 =?utf-8?B?VURBMW9MVXU3cE9meFljd2xrOUt5R1Y3bnZIZUJhMWhySCtCelpsVGgvenVK?=
 =?utf-8?B?MU9ROVlHRFU2Um1QSFgwUWdNS0tVRHRWQmczMDlVUGlVRHpKREhBMWFkODlJ?=
 =?utf-8?B?Um9hTWFIVjBONWN5YXYzWFRNWXFOanc4RzZCY05VemNZYkZNMTNyUUtCNXEy?=
 =?utf-8?B?ZG9OR2VrWjMraW1rRmE3TkdtTmRTYVc1dlVDb0RpWVdTRnovQ0dwa2djTEk4?=
 =?utf-8?B?NERhOUVFSmE5TjlPVm12UnE4cC9SaTdBTGpGdi9qSnlqOGNqQW9ScFVxZUMr?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4TsVbp4loaABxXTvJGmaRFd1ngkCImA0ZnUzJlWKPjxgi+WSaFPBGCltXjQBPHIzYz9Qmgujo+9Q0sBPL07RhbqSn7eV6HYz4mF1iCBHdtpM7bwVvU/tfdZWCAntmUSWVaYI3Wn/Ys9cqGMNtxd0hfyJSPUihez5OpU3Vtv8+xF9sLM7AGdLWRT9SKMtagKlyDWTlbWW37SNsIIzli8ylvyi5amEo+5KxKYKbfHubayKGhZQ2mNyvWHEJ2vopI7LYIbA80fHZPCTetwj02e+opiPFipocGjgBg3oxRwR1+JuNtEZKPaQMTRV3heHk4kcUalVq5OaVG9pFVqjyu8WFoNhYtCo9iVTnovebCmna6tDSC+bQOrIe4MmSNRqe24QkpKwuRVWuA362YB/ZN3SDHOBHN2xW1wYZLBTKpeB06zHKiINQv8bUhZIfPRF/hSb4bd4sILYd3z2zUPWzK0wamedXXagYTDkwpmFmAkB0lkpPiWR37+NzdCRISDS73AEbpnQBLV456f4isPO4qVHQc/l1Wr5P33/UiLYxE3FHlipkZS/bC5c49YJfHFWlPp1v7aog0VR9YPeqmXsyJWEv+JDjvS53Qa7tun06Zh6SEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab339ea-f574-44e7-907d-08dd78e6953c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:49:50.1571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpIBpVfmFmKy+ghXT3xWhjpBfNhvqXy+nMTikWdjEjN45ed4iL8ac+vKCTmz//eKuHnCPtTfAdisf8Bnye6nITSCT3HLBK+Tei3J9Gma/tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504110068
X-Proofpoint-GUID: ApJpL_pNLl-EfdUgGD5NPfnS9QBoiT8P
X-Proofpoint-ORIG-GUID: ApJpL_pNLl-EfdUgGD5NPfnS9QBoiT8P
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/04/2025 11:17, Zhenzhong Duan wrote:
> The saved caps copy can be used to check dirty tracking capability.
> 
> The capabilities is gotten through IOMMUFD interface, so define a
> new structure HostIOMMUDeviceIOMMUFDCaps which contains vendor
> caps raw data in "include/system/iommufd.h".
> 
> This is a prepare work for moving .realize() after .attach_device().
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-device.h |  1 +
>  include/system/iommufd.h      | 22 ++++++++++++++++++++++
>  hw/vfio/iommufd.c             | 10 +++++++++-
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 66797b4c92..09a7af891a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -77,6 +77,7 @@ typedef struct VFIODevice {
>      bool dirty_tracking; /* Protected by BQL */
>      bool iommu_dirty_tracking;
>      HostIOMMUDevice *hiod;
> +    HostIOMMUDeviceIOMMUFDCaps caps;
>      int devid;
>      IOMMUFDBackend *iommufd;
>      VFIOIOASHwpt *hwpt;
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf..0f337585c9 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -18,6 +18,9 @@
>  #include "exec/hwaddr.h"
>  #include "exec/cpu-common.h"
>  #include "system/host_iommu_device.h"
> +#ifdef CONFIG_LINUX
> +#include <linux/iommufd.h>
> +#endif
>  
>  #define TYPE_IOMMUFD_BACKEND "iommufd"
>  OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
> @@ -63,4 +66,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                        Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +
> +typedef union VendorCaps {
> +    struct iommu_hw_info_vtd vtd;
> +    struct iommu_hw_info_arm_smmuv3 smmuv3;
> +} VendorCaps;
> +
> +/**
> + * struct HostIOMMUDeviceIOMMUFDCaps - Define host IOMMU device capabilities.
> + *
> + * @type: host platform IOMMU type.
> + *
> + * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
> + *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
> + */
> +typedef struct HostIOMMUDeviceIOMMUFDCaps {
> +    uint32_t type;
> +    uint64_t hw_caps;
> +    VendorCaps vendor_caps;
> +} HostIOMMUDeviceIOMMUFDCaps;
>  #endif
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48db105422..530cde6740 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -324,7 +324,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       * vfio_migration_realize() may decide to use VF dirty tracking
>       * instead.
>       */
> -    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> +    if (vbasedev->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
>  
> @@ -475,6 +475,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>      int ret, devfd;
>      uint32_t ioas_id;
>      Error *err = NULL;
> +    HostIOMMUDeviceIOMMUFDCaps *caps = &vbasedev->caps;
>      const VFIOIOMMUClass *iommufd_vioc =
>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>  
> @@ -505,6 +506,13 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>          goto err_alloc_ioas;
>      }
>  
> +    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> +                                         &caps->type, &caps->vendor_caps,
> +                                         sizeof(VendorCaps), &caps->hw_caps,
> +                                         errp)) {
> +        goto err_alloc_ioas;
> +    }
> +

I think this will fail on mdev (and thus fail the attachment mistakengly as
there's no IOMMUFDDevice with mdev) ? In case it fails, you can just do:

	if (!vbasedev->mdev && !iommufd_backend_get_device_info(...)) {


