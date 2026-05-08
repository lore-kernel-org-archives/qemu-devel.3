Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2E1CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNF5-000693-G8; Fri, 08 May 2026 11:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wLNEs-00068G-A3
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:35:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wLNEo-000106-03
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:35:40 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648DkH0W1859359; Fri, 8 May 2026 15:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=3T4u7Tvqhroub1QyFEj49V0C81E0bWu/uOkBelasi9Q=; b=
 rnLd/7hOdBEGUSvLuh19WagMoihKCqgeg1UU0qL5nfHT0GDDdlfPAfvpc5fTrBW7
 0i9seiwHMAIaXdd3ZXz6c1utPnEJ825aXaatv03WfU8xjn4jZ3sRQeWLkKnC2eY+
 UKhwl7Tevnt0IahxGOz9YYBS8lETqXAmrh+Tj6qXE4oJ8dFagyUcgauOysLCWGtF
 kLB0joNIWWdQOtkkGCT5Erc/XUPiyn3NHrs5A1n93VNnm3eQps12ZOC7hGeskDKy
 N8vQaFWLMFwQ/trMInXue7VXfIt3cVePbjEqlX6GpZK0llHo1Mr1D4GjrWx6E+MC
 IOhMYdhF+Cmfly7UpWAzgg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9dh30ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 15:35:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 648FQYQi005448; Fri, 8 May 2026 15:35:33 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx581xf1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 15:35:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYPtfu39Ib0eTwP31Ox8QqgCrTZ/4ZkHWvGJw+34mKo4oo8PLX6LtOF0jb+w7ewdaUtthkUSw7RiWTd14gEmAb8v+cM/G/ynL0/vVTpiT+oA0Oo8/ujnlAdKBbBFy2ZeqjCYcdXg1UYBhS3Izqtl0bSy5MLASgjBYoSrrSXUdHxJBmsHwr4pLTkgsHod0KqUnJYQSatKXDN2jsIeIdf5VSrSj4M5HlG5rqDLoRpx7yB/pxWUXhN7pii+FcdtDUjNCeY9yAnLjzi7hSrUZjSc+HT2GCRuzQ1bMm0fu/d5naeEAjRnTE446m7WJOG2DS2yRCojApXwK6bKKOKlOD6VKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T4u7Tvqhroub1QyFEj49V0C81E0bWu/uOkBelasi9Q=;
 b=u9qsHq90IeQJHMZ/80DhAdZtfURVrngPNoWiu4gThzLFuV0U0L4rcIlAJLQcYYSolJqWupnRne2ONoSfObAlNJcXN6zn+nVCCnkrwxZkFlXFT9ogzWIQWSNEbCRjbrPIU8JCqJGhvZz10wlEJ24qQIgQvdgd7J28a9UTVKcdz8IVxlXv7rqsG8/p80/pcnoWV5ktqZodHfk+CR+N2HttmN18jqoW71QE7a5ii4tvh0AD6Oab+pKS5SaGNdZ0wJE+ey6TGYHWQGVNlcEgeoG4oloTvhMWiydnhxXioMgzdKKeyFLrfTflm9qZta5krL4C81002CgWBdikwqsaV32+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T4u7Tvqhroub1QyFEj49V0C81E0bWu/uOkBelasi9Q=;
 b=OjXP2aiiMJdQ58SJmuKz45kjEbtKLT+LSZ3k1uhg0x4nAcGs15WPFJQ+ApNK2jXVHU2AXJNiRqEQ+nZ9fpjop6eqI1QbpNS2FXVXZaP1rpz+dJsHMmnm2ypGKmCGHPQbCEpIIHnzcNk+5W1wH5/FIhi7AIbQH0ESeAgxEjzTioc=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by LV3PR10MB7769.namprd10.prod.outlook.com (2603:10b6:408:1b7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 15:35:28 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 15:35:28 +0000
Message-ID: <f91cc783-0284-44c5-bfb5-a95b4abba380@oracle.com>
Date: Fri, 8 May 2026 11:35:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
To: John Levon <john.levon@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, "clg@redhat.com"
 <clg@redhat.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent> <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
 <af3_CqQf1wSSWYYY@lent>
Content-Language: en-US
From: Jagannathan Raman <jag.raman@oracle.com>
In-Reply-To: <af3_CqQf1wSSWYYY@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0412.namprd03.prod.outlook.com
 (2603:10b6:610:11b::24) To IA4PR10MB8301.namprd10.prod.outlook.com
 (2603:10b6:208:55e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8301:EE_|LV3PR10MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a05686-fd97-4d5f-2e7d-08dead176e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: ZacH7ayCQCzmId4ARS7BeCY/6D36DznIudvFam4LWUQXKkAWZK/DGmLxNqVCVUlrdMw5HNEgtgOvQmbIjD31qaQTyKfAhxNEoTMq8QqI6COau1o48s77QUnoz+mXVDyUIgrIDvSrUix5EuUt7ubl3M+UEjhbdH4foxjz3QMe1OPdIYZZRvelMjSGrWEpjOjdfVEncZvE3Kog+X/GsDtE0MEYFKd5rdhxXgl+p1+oCLgJwSLfW0Lp0UzuH+ridy79v3J8/QQHapH3ZjXjSJ/ku209E/xxRpE1VfN5maZ1cI9UkZ8glOycEDQmeR2yMTq3jWTAW9xLCRzsS6LVBMyyjSny0vjDkibw7Luws4Gk6klZVe1pQLWv1NKuHVcqWuM39Z9Q2iT7a+phsXqPz5emfOEbIVN5dYMCeUy/DhhRPGGajUvfAZ/rllE+hnOq4aLjDjYdSxitRE5z/DLmSgpycuZFbZPEeit2Qj3t/BUlzSmKjeYBB5XRrpc9aeFoqZgEsW5OHvbb0Cem4Ao8dSiYVH8sbedkPK5ZMODF/qntyO+dq/uu+DbtadLSdJ2qxZKYxNgFZNrFoLeQyeQ/q6GOLHSw0QVHXdwO++p75D5cGsNWNGezhJsoyjkhCzdo9IdCfFNTzDlJTKFJAFhPmJCW/KdsEB36YOaH+Z0Ae5yWKyZ+5DQmwsVdcyGGnsyRrDGT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhSYUFaSTZCQjdyS0tRMTdtVGRZY2lRdW9HUFBlbkM3bUVzY0htaE8vWjlQ?=
 =?utf-8?B?UXhHcXJnaDVlSSt1Yll4bDhXNE81d3BRRitmcHQwZENUTmp3aTlic0NaUDdq?=
 =?utf-8?B?S0hBUHhoWHhMc2dIVjU2S21PZ3FWM3k5WVVTWUVqYkpNclhZenFxNXROalky?=
 =?utf-8?B?bHlQL3F5S3NoZ0tHM1RTYno2SmVQa2RRN1lSdTlKQUs1aG52bEUzWktjblpQ?=
 =?utf-8?B?SXJ1YlJKMDRvbEFZdm5ZeUhWeGFPbkFhaG1OUWI4ZC8rc0VCaVV5SGRnN0Vp?=
 =?utf-8?B?NXpQOHZhcWh6SmplRkRVbVNDVGQyWnpDUlBYVjdkMlA3dEpabFB5UEp5d1Jn?=
 =?utf-8?B?bnFGU0ZxaVFRcE9yYVluTVRjdUR2Qis3ZUJzdlU2b2NrRklwWHo3U1MrQTBR?=
 =?utf-8?B?dVlXT3lQWVgyVW1hdjhjY3NBQXpnQWxHN1d5RCtIYTFLUFRGc2dVN21vbVFl?=
 =?utf-8?B?RHZmeTFpR3pvY0ppRjRvaDNZMjlGWkhtaVVBUitsUnZSNDBWYWFFNGd1RCtl?=
 =?utf-8?B?RDBYdjdaYlpBc1JucnNzelhxRHQ2V0IzZ1dKOTJkQWMwQUpKWlpzWGJ4M1li?=
 =?utf-8?B?cjQrNC8zNzJiV3VwQW5Dc2xOeFVnODJWS3p0QW13MGRoSXgzWmk3UVJnZktN?=
 =?utf-8?B?R1JSOE0zdmpiL1BRYW8veUkxWVBvbTZoZUpHREE2T0RzV3FXTEs3R1o4RmRk?=
 =?utf-8?B?d2dUSW9TeTN4UGlnTlNFWGNvdFN4Z3hwcjZPQkpzZm41WjhFMFZCSTRENnda?=
 =?utf-8?B?QmtnZ3Z3ZjlqOEUzek1tKzBRZWtreitxemd0bFBNMVR0QzdJVkpLeFlVNlg0?=
 =?utf-8?B?RjRLNkVUWUZQTlpEbmxDUlVIZVNQelkvSDVWYndldWRnZDRRaWxkeElER1ZN?=
 =?utf-8?B?eFh0RUZ6UzRCS3RDZ01LeVViSGNSNHIvUG9HUDZCc2ZPS2pTMURNN1Ftdnky?=
 =?utf-8?B?RjBmYkxMZDRaOEZsYW9jaldEWHdnaktzdFFhRG9oU0lOUGVwb1d0SG0zYzl1?=
 =?utf-8?B?ODk1NUNVRS9sNG9wMGVBZXQwK09IaUlyWXo2RFRDMnRsTVpjMW1CeEIxbTVH?=
 =?utf-8?B?emcwRDRKa3p1OWgvbnZ2dnYxdk1pOU9kaEpVRUZkbnZEZHlEWGJsMEtKVVg5?=
 =?utf-8?B?bk9lV3VCVUVGUjE0VnJiNjc1bk9jR3ExYUp6OUdvNEhaY2t5aEcxdjRvem5L?=
 =?utf-8?B?R2VIZEJVV2Vud1g1WklNc2cySlk4VUNmWnNGZWV5eEUwNVQ4WFBpYnQ3S2d4?=
 =?utf-8?B?Nm9ZdFlNdHltdHBJNjZmc241U2FwdHVDQXpGYzlxU2F2eDNER0NrTDFYVVoz?=
 =?utf-8?B?TXlOWmFsSmwwa1hLelJrYTNBSHBvMlpvdWIrUWN3aHg1ekpNeHJLZW16bDZP?=
 =?utf-8?B?azhyWDRrL2dpMzJTazMrM2dpR1QvZG85ZTdudUtJVFdHWGJjQ04zSFZzWFdR?=
 =?utf-8?B?NGhPMjVTQkhoMUVqZ1dBL3JxY2ZsbWZTV0FoYTBMdC9mVGIzYWxTcVIvZExh?=
 =?utf-8?B?WnRZUFgxaGNZWWRwUDRxNnlSbllXdFJjR1NXZ3V5aXpLSUF2WTNUUWZKSEFE?=
 =?utf-8?B?MERsaVROZmExZlcxU3hxdERSRDRiSHNlWmczQ3FQRXRkU0R4VDYzMXcxQjBH?=
 =?utf-8?B?TVJ0VldJR296UXNjSVlMcnUyVEo5S0lKd0tsdURjMDJta3gyZWxlVTJFN3Bq?=
 =?utf-8?B?OW5wOVpZeWhLc0sxcFFPQnh0RHliSUQvYUU5RFkzSnl1VndhSm1IR280S3Y4?=
 =?utf-8?B?QXlvbjZHbUVxaUNtL1lMTTFOb3o5VHJKSGlLOER4Ym9Va25RR1dhM0tOK21p?=
 =?utf-8?B?NWhmK0RpZld5NlRZczhxQzN0WjhJcHFLL3czRFEyeHY1bzFqSkd4cHhkck5L?=
 =?utf-8?B?dU5LWm8zNGxDWEd0RTdncTV5U1c5L0hQZTd1Snh2YWFJVUhyYjJtL1RnZFlX?=
 =?utf-8?B?UnpvMGo3RFpLcXpPRGxMSVJNNDZzSGJHQUhpRXV3UnJCQWxZKzJyd0p0bThx?=
 =?utf-8?B?UGJlUmgyTVFQQkVPVUxRdnlkUjA3cDNMenprMzNmSURvaFRQZ1JlMUJ2MHFK?=
 =?utf-8?B?M0U1S3h4Uy92U2lsLzZpelM4dkRaK1p5bmFxY3hudlZLaEdDL1I4YlhWamJZ?=
 =?utf-8?B?TlNJSlRjSHFJQUtOSFpzcWg2ZytPNG5kcS84Z0RCSDBORnpXdVI4LzJPcEF2?=
 =?utf-8?B?U2RmVlVEbCtPa2lOWE5CVDl3QUhyVjZPYWxkQnAwZzNiSElvZmlCQlphU0pu?=
 =?utf-8?B?RGRzWG1JRHNsQWRZc3hJWkpSUUwwb0FDODVvUFg4eW9WSGhxOGoyRERFNm5F?=
 =?utf-8?B?NXVMT1I3UU9NV1FaelFVK2ZVRlJ3dkJ5ZTFuWE5GQlVnRFphb1JCZz09?=
X-Exchange-RoutingPolicyChecked: RnQc27s9mYtuUthNTN1/bcmEkNkZ0N/aIyifWMXFyclUwm4MpLUiQiVtG/HeJAYfKi1knVaYNeDatktZB35pRGaVsy0TzW0oVaaMNUGcOGLWuaBntI6kWmPyn5RMkZyZiDOgg1co8ffbkbR9T58xmSGS563iV4CxUB8iIfSiLx24qYmEYNwbofkUuyCJC9oxdIJQzvYXUekRUcuj46iwvyLUteQct6oYSBcfSxteVt6e1lCYk8VJAhzN51fcUBDmWkp+P8qPWa21XAUhO/+PP7kF+pyYq1oT8h/mx6C0L96zPy9i+hxv0WIC4J1/tBFVXt5+Z2KZTQ8nSjdEjURElg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JebrTbDuteUBWNUF3+yPo8nrfscQN4DoSW9w8vr1rDr3KxQ5yNBrowg36CxPWVnaS7aX4XucwADh5w2kMaE5HNm5wbmOJcje7qUMLGf262uC3VOkggx+Vd2VG5RlD4pwUv/KpHHA1sFKiOv5CloLDwx2pW20nDkJMJv+4jgWPDTHvGAvWY5ehmvK+s1AtPwQCDXHWIky7yBDHWgsbVInNzcl/O6v6L9faS10eG8fN8EIlJGQb9oAtfX98pQtGRJf+xUgQvhcdcrcyyd4YwcIaLJ0uDNU88vlR4T8s9JQr0tGRKYZ6qCxLipoFoilLnplc2aeSFhu9Q/ubruz0BWW4mcgLXPjK9tERicI41A/wiwwV6VhAoUWIEtkiJgMDI9N4FtntluB8oaOfjJsLAPWDdC/vFPLkKHGUkQvb0qKCi1E9vbPE012oXg6MKL03acQPtE7X2bwl7rsFpIkHCtzxy0+hkCRtpmfLGTYHQz4hLCatarhURN0hqR3GgV24Fm2eBvK9rhfiV3bFD2XHNdPEYL+YUkRltxCVSGBFCktWIlq0CdhLkDfo8GW35kjBy+IhAzGJaARpIGLXcdzlRlf0C6rlNGfQD9u/lE4mk06tqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a05686-fd97-4d5f-2e7d-08dead176e09
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 15:35:27.8555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T27DagztDqz6o1R3J6xlnm993XKe96iaJcYjM1c8mBQ7wnO1UfdvF4kk1gLCAAydvU9C2y+FPvORRgtjxfDSSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605080155
X-Proofpoint-GUID: FG8-u1ainwYV4_FtjSdveQP_ZxL8_K3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1NSBTYWx0ZWRfXwnOpssioy7vU
 wkkd8rpDES4dk3iAAFWXgIPQHkIwxGf8MVNRha60hbmINyBJOrhgTo2qOionX8IRvQ5stE6ZhJA
 du215qtNVwRj3JMOnfaIx9R6lrsDSbs6HbmwNsdG71yJzVnS8BGOsssCQlrvtFHQ1PEP2dbtHBZ
 jSBfY17EAEPMc6UY/8l6aSzqJjW3Q7sHdmCKYj0wGhzV+69HOI9OWVmG8BffR+sUEBM14oGXcqI
 llHglljVaMsTinK+j55Ai8TwrayJh/e7n6iw7Ds7pDp9axeoHKuUU2KAi2s41wkID/dCei0944A
 eo0lMLMg1JzJQPKJvMkC/jvYmMlmtJK+CmThLLGtp9WZdwfKUTYP1cI9J9e/s+NzDzm5AoLH5C7
 FMhs3+Fe+4VFJKttHNhPCXB36Zhu8jVolphwmhs5VzlDXqXXzqGcNAcBnXYDV33pJwRKUd4Pfrp
 QksLIykeA9uLErO97Fcs6NBSppO60JCgFFaf/XCI=
X-Proofpoint-ORIG-GUID: FG8-u1ainwYV4_FtjSdveQP_ZxL8_K3c
X-Authority-Analysis: v=2.4 cv=HZckiCE8 c=1 sm=1 tr=0 ts=69fe02c6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=a_JZVQOQI5JK6mDj6JMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 cc=ntf
 awl=host:13839
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/8/26 11:19 AM, John Levon wrote:
> On Fri, May 08, 2026 at 11:07:28AM -0400, Jagannathan Raman wrote:
>
>> On 5/8/26 10:37 AM, John Levon wrote:
>>> On Fri, May 08, 2026 at 02:33:59PM +0000, Jag Raman wrote:
>>>
>>>>> QEMU maintainers can correct me, but I'd think it has to go through a
>>>>> deprecation cycle first?
>>>> If the code has to soak in a deprecated state, I think an “Obsolete” status
>>>> better fits it as it’s replaced by vfio-user.
>>> Are you saying you and/or Elena are still maintaining the vfio-user
>>> implementation in hw/remote ? As I don't think there's anything happening there
>>> either.
>> The vfio-user implementation is the server part of the vfio-user client and it
>> utilizes the x-remote machine object. I do maintain it - I proposed a fix to
>> bug last week and reviewed an alternative proposal from Marc-Andre.
> When I was asking you about mpqemu, I was talking about all of hw/remote, not
> just the legacy backend. Apologies if I misunderstood you.
>
> I think "S: Odd Fixes" is more appropriate (see below).
Reclassifying the status as "Odd Fixes" is accurate.
>
>> There's no active development on it due to a lack of inbound feature requests.
>> Are you looking for any specific features?
> Confused by this comment, as we've discussed before several times that you were
> going to migrate the testing across to vfio-user instead of the legacy protocol,
> then remove the legacy protocol altogether.
>
> Then no patches arrived, so I presume that's not going to happen.

My employer's resource allocation has de-prioritized this. So, I'll do 
this during my personal time.

I'll focus on these two items during this weekend. Do you need anything 
else?

>
>> If you want to bring the maintenance of this under your purview, I'm OK with
> I don't have cycles/interest for this unfortunately.
>
>
> How about the following:
>
> 1) mark the whole subsystem as Odd Fixes
>
> 2) mark the legacy backend as Obsolete
>
> 3) if we don't see any further work on converting mpqemu over to vfio-user
> properly over, say, the next calendar year, then remove the whole feature.

The above strategy sounds good to me.

Thanks!

>
> regards
> john

