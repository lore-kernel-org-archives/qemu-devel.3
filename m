Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2428DCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMHp-0007BO-W9; Fri, 08 May 2026 10:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wLMHN-00077m-O2
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:34:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wLMHL-0006MP-Aa
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:34:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648ECeG62445998; Fri, 8 May 2026 14:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=ONAvkxlMXFM7ejRWfR
 9whuUgGun+xIePm37f+sdSW3k=; b=guMEAf3UsJBmHHqIecrpGB1ciDkiLgP944
 VZrTS+wICitxcExNyYO/Q3AcgHOPhrRwS3J8UBx7+kmj2A/guer7hAoTbqzIUmj5
 uel+aXcJ1zQcwXXl7Ur0kfpjczLi8jvSQqE+kbWCbsHti6BwQ1qzy6urigSYTXED
 DTCV8WvKDqzBWGC5G3yweQI60GSTOA6NZrHtJdN6NOI39o9Ju2hzUniROU1NUs0x
 kInYabr7Np7n9eGFGD2UngVtpMNdmIaquqXcsh0KKx/2gvP5TAjGu1oKUZyeinI0
 4nD8uZK3eA0J0BcDDTfdY0jNQu8w5djvRovx2Sf9TxZAr6YBlr+A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9eq304s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 14:34:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 648EQNbt017994; Fri, 8 May 2026 14:34:07 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx57a1176-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 14:34:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVbl8lWxYmubiNhT1mdME0ikCIYC0jJwVgziTntykWmqe/0kNAy0xDZziumgrhlh/0V+Qki3CRVeTP8OjJmLjpDj+dKVCVZ3sB+UnOG1h1xjNetDz9gWdTmkBHQb1+rpOJy5/DAF3xlAjhWTlfbGNWuGueKHthBCMJwpI0VzMyPrGhlomVPP/bypquDogtSRIHGLWUPSqgZIyN/nkmtJjr0L/Dnwd6kSWu3dAr2dGFLMRr25FrmKFD5cYzUqwyEUH2NonIcZpfcWqY+0NrV2kAO9bML+56U4Y4iLuen8nknjoPlUlhxeWiHGg4gxvJeDyHnXfaToBYl/MMM8YFJJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONAvkxlMXFM7ejRWfR9whuUgGun+xIePm37f+sdSW3k=;
 b=jrpME7y/ae4rBqByJXNIzQkpyMJc7CCukRqEK2WErBODx+ry6GWQ+/2TceGrA1xxx4i0Y5I6XLIS9z+pfk2v1hvAcHMMh7Gx067fKgSW6Is6dNuKkoXVLxXL30IlaXWWfca594q5xL2kbVs0z5IOzxj/DNGrimgSULP0egyU0+sCRbosPtrcgxaQSXOx+4WoCvZCes3avzrZ2G1N2/apPDVfEC2tEdIqqkruDRNEedYD97HbW0UtK8qaLlRYsM0+NKguZOyL+HYyTjhSqP+5v/dEnljfw+GCB7mmoFA62RlqrVMGt42ZuDFmq8ea1v5+gqb4vDuTjJbyoxPANR0h6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONAvkxlMXFM7ejRWfR9whuUgGun+xIePm37f+sdSW3k=;
 b=nYWGbVSPKzZkJUwZNr9m8C35ZBaE1oETTLnJapinRY3xTZmVwFOQzijKjYpzFX9y2mr8nySbpu1ILXRjmbgfBcIr2isloqoAlkhU50CtT0/K4sB706X2rpzSR+/j1WzMRBQgRa04xmTQ0TmHhPePKi9GkQlytgbI4Uve8OvrGvg=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by CY8PR10MB6873.namprd10.prod.outlook.com (2603:10b6:930:84::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 14:33:59 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 14:33:59 +0000
From: Jag Raman <jag.raman@oracle.com>
To: John Levon <john.levon@nutanix.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Topic: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Index: AQHc3tVAODNr3sAyP0CIkVhxZI9/m7YELdWmgAACZwCAAAE6WA==
Date: Fri, 8 May 2026 14:33:59 +0000
Message-ID: <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
In-Reply-To: <af3zEgHy7UMYN4Ow@lent>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-05-08T14:32:57.4594224Z;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients; MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|CY8PR10MB6873:EE_
x-ms-office365-filtering-correlation-id: cccd4334-d390-4c7b-a60a-08dead0ed7a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003|8096899003;
x-microsoft-antispam-message-info: /8WplrqzdwRMRnlHrgciBUSHS7C06+c0VWz5CYFMh1Xx2duCHRVrM/ODv/cBD949hxjuqS7h+fPkAERxp2vkfVXgGuP3axRaI0aVX0bF6bze8L/OyDQjDLXxXaxubbC8V703zTaSAcCwwm0yAM47/OkeTqjpbN63dFZpKboNEvd1Aj8fZRKFRUtKWwrIC6jJ+YSg1kcARYYBmO5v+0PdRzjsYZUQ55hwVJKEXsYwJH9zHm89ENAeVzGaxGSYi/nOaBy3wAlVC+XRe9uPI4NCmOjHFGt1vNkDFcAmqIvo95RIXN+kE8hkUNTKX9qFazMDQwM8sEqoewWzU3ekcF4YvdFClLT5+E40Hf37tERiIRZYwaKKhcw8Qn1rHULG/Wq654OJ8G4YA7vMRiR2re/Kq6oVK5J2bxSR+jE/Nmi5O9zQTdobYBRRN2EBvYCFQNsjaJI+rWDyv01YtujaJh1XllC7p8HwQLMbgKIiq4PKamiMESFfjvLcTYGGpUrICc7pq1AB9vOIPbG6ZB9Zn9jFw9VyQOWx1YTQBgvGaNWDeZDDs08ouyRaKQScnD5uI8BRrjUvXoEfiNiaKQ01yOJPCI/Myia3g/GxkvLk8oKyBGzb1gUS1XH5Hp6IniMY3I3tRoRHGqAG9QtVvt6lVZw/Ml/OtBAFVqK0gK5U5iXUQ7uWFtBBP2RWD+Cwx5ZMaDsIpZa/VBCZ3mjI4cDfESptLIaRru9wifz8i8YiOUZMDb0Lxu/OlIPf8u0R7ky1GvdN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEJ4NGtQK0V2VXAzWkd4ZGZXRWZWamFyd1piZk54ekVaNHJ5Q2ZSNGlaS1c4?=
 =?utf-8?B?K3lScFhXZHBmMlR4UkRFWEF0OUMvdGl1ZU5qOHhnN2VUR2dmSGMrN1p0Vllt?=
 =?utf-8?B?bkFWMlZqd1BMWDErTWRwajZaZ2lmVXFHc004YXdPZS9DdzdSMFdXbkZpQm1i?=
 =?utf-8?B?bGFzUms3YmJkM01lR1VTL1I4THpPQnFPbFJKU2FnZWZYUlBhZnJyVis0RlJX?=
 =?utf-8?B?OUZQZm1KWDBPd0s1SVN2Y3BQcS81RjRRQ01yMXR4UE1GOEQrZmpLTE1GNjQ1?=
 =?utf-8?B?QitMRHpFVGt1dmRBZmhjNzdRbXh3ejNpZ1MyQ2RiMEVDa3JWNnpDeVJsSjZG?=
 =?utf-8?B?YnVJVmx2UEM4QlJJQ2U1OVZYaCttdmR0d0RCK2pNMWJBb3ZTbGpHSmtpb1Bu?=
 =?utf-8?B?UmVYRjVkOEpFOTV0TjlyQS9IZjVpRTVaNTRaM2tqYXBHOEVLRXo5a01uaFVj?=
 =?utf-8?B?a3JwWC9WTWxaRmkyVzBhY3JIMkZyd3JtcXcxWnMva0UxNHFDSkdUc0JCTUg1?=
 =?utf-8?B?cG1EVlpNdkV3QVdzL0U1b1ZVZHJUbU5YSjQxZE5xVjJ4elJmNkE4OERSSE9x?=
 =?utf-8?B?NlkzWWpWWXFMMVk5WDlFd1M1cDJaQlF6Zk1NVEVRRk5nK2Q0MkwwNnBCUGFJ?=
 =?utf-8?B?K3dIbFZVUS9GUi9COFBQMyt4eEQrUlBoV2dEWWdmdGRLZ0JLZXFJekxEajY0?=
 =?utf-8?B?SEhxTFVMUmlwUEpONVI4ZDZVeDNOMlpCK0ZqN1NtZXpTeGk4L0kzaVJEekVZ?=
 =?utf-8?B?NlBMWXNzbDUyMU01em5rekFkQk9UdkxMWVNPU2ZMUldWZ0tITE9ZT1NRYjVi?=
 =?utf-8?B?QUsvODJRRnB1d0JzNThyRFJNbk5UMGpOM3ZUTUk3TG1qUXFoQ1VCaVV0TlRO?=
 =?utf-8?B?QTZvd01TN0xQQUYyc1EvZjl4N3ZvUi9IeXNWM1NhbUR3b3hXU29XMCtHM2p0?=
 =?utf-8?B?Yy9kTlRvYVRkR2JWcGYyZkFlSlIwc04yZGc2YVQwTFZiQjZoL0JyajdXR3VD?=
 =?utf-8?B?NThwSVViNjZRaHFXN08zSUl4eVU1czBhWnRqUG9VbEJ0MWw1UktkYUxoQllN?=
 =?utf-8?B?OXczcHRNOUQwMDdBNXhKOGlvMUtQNWRHaXEzRjVuUTUzekhwbTBIcWxWMjlJ?=
 =?utf-8?B?QkNUT01jK0dwbnRXcHNaSFd2THFHNW1tUGlVYy9SNW04dnpiT1BHc0RWNU9h?=
 =?utf-8?B?VXVsV04yRzZBU0VRektiRURqVXhReXpuQ1huY0x2ZTl2V0xEdzhhbGtOazgv?=
 =?utf-8?B?M0tpZzRINzk1bEQvY0VocStDNHNHUDNuNkpDcldjOENrczZ3TU9uS2VqL0lU?=
 =?utf-8?B?OFRFM2h2VUJvYVRhUTdsN3FIRXFHcWZqN2tydzlqazJtUmxYMWdjRTMvQzY5?=
 =?utf-8?B?SURtVWZ0UGZGaVg3NGRVWjBxYk1CWmhNN1ZDSk8yak1hM2pGOEJ5c3ZzMXRl?=
 =?utf-8?B?UUZ4T204SGN3c3FhSkN2cDBOSExYeWhxKzlYU3pkVElQc2ptUWdRaTd0SkNI?=
 =?utf-8?B?RFBoWS81ZlRobVZTY09NdVdVckhsQjhRWVFMOUZBRVhMSVM4R3NqaDBOVVJW?=
 =?utf-8?B?aUp0TE5aNHpKTE1abytXdXJPdW9kalBTRjFIeURjOVg5SFdzWlBDV1NXa1lS?=
 =?utf-8?B?YWRUSTRBc294NHhYbDRrTkVyUk5tZHhEMS95SmN0ZlYrZkZ4Q0lscjM5ZE9V?=
 =?utf-8?B?U252WDVSeVA3aFlmMkoyYnBaQ3F0T1I0cythb01xeEppVWlscVJya2dHWGxZ?=
 =?utf-8?B?TmNReTNLWGMwTGRUSTZmcjQ4Tmt5MElpemkwbzlPSzF3V0ZlcUdDWVlIUGdY?=
 =?utf-8?B?RXhCT3RpZnJmditmT3dhSy9HTXFLVVJYdGlpdk5zMjJNZnFIWWF6UWtEOXV4?=
 =?utf-8?B?VkE3YVJ4VkdUV0pmNndIV2IvbTM3MFNvem5wMi93eFNEak5wM1NWRlM0NEZD?=
 =?utf-8?B?RVNJYjRWVndYNTYxV0tIOXlEMFBLMmFPMG5zdVhRK1dKOVpBZi8wOFNWK242?=
 =?utf-8?B?WHRwNW9zTk5OaUZnb0NZM2s5MDFhbmhoNWcrWjNuY3MzRWZSZXNIbnRQVUVp?=
 =?utf-8?B?cm1WNkkxdjFNVjYwZnRNM0NWb0JPbkhqRmVtWVc4TFFTM1VaeTJnWENwbTdv?=
 =?utf-8?B?M3cvMjdLUVIyUUY2VXRaK2tNMU93YzgvMTN4cVZ2MU9XSE44dTNoRkpvQzh1?=
 =?utf-8?B?TUJXQXBmZEhwYk84c2ZhQ1dmaGVQMXlBRUhwL1FpR2VSTzFMRTBBSWxRVG10?=
 =?utf-8?B?SldaUmU3MWN6Ukk0bVVlSDcwQ2lqbzB3cEVTcUFpWkQ2ajhDdmdWRTUwbFY3?=
 =?utf-8?B?cHJqdmRtR083Y01FZHJqQmg4WHdieGhPdHEycHBkZ1JNYWQwUTY2U1c1cGx1?=
 =?utf-8?Q?bxNUoOyLI/zDWwas=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA4PR10MB83013C640DBB740BE8872FE4903D2IA4PR10MB8301namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kD5y/p8ia3L24WlKDd6BfmPNz22EQsBGsJXCJz1qKJgV3IWzyqs9PGR/79sTydraq4Ozbs5TByY7GpDCxVyOil8/9mcoyrRgC998m9oBRuphR2HHx9CfVIixKPBj3syt4aMglCibVvq3s+SY79Lp9obiEe6Uw6vg5DelZ34HFIe0JDM+gRgZ/uvvD+jdY1cKyAvrWocOHbmXRV2tKVL8DQylun1FeWmVHHzlbpJMrHvT3/ssXjZsg3Yd/mqWY+XRZFcB+7vEOhNK+u7RCw5BunsK6Laqf/C4ymDique/hmcfRBDhb/v7QYPFaM+JzJkDTQEDGQ+g23cm3/BotMxbdA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b+0M3Ty5orRKEyk9ofpg0W2GKKewNLwpXiSox8HCyJoEjFPhd8yAqIMD7nqqVgEzQextKW4WDN7mv9S9R5r65JIejXOuCsU/zR215IHkR9TpzuBTH4WMztlccAYxl4aaLnSiFmf+s9kHE+I/HbsY4HjVNTc54Bs1C0ndRaMTKFED6LvPIIFwomJDg+xzORI8U3lUHCQQi+wV5/Rw5xZQujs55ZCek9pnN2iPqAAnlEN1ehPC7UM+04ncY8kpAsfqtWKZZijF4K/O0MVsLnzg5mlRdaXwZd/w8jVq97pGzzYaOsOBtcRYj/sZ+z8dtJkrl/0raLlmunIxDwkUZqNm7WpSphkUgM9UQsZR619mWo45jhAVhgcf4VCp/BaNrHS8Jn44emV3lr7A3xhN9Nttvs54Zt7SVlNCAr1Ejvvz1Uj/HGHY2TNpKAwqZxGkrBPe4k3xJ3xXknf3Q7/r+0XKgfjVjvIkL1NA/kzT5lnpFoYU9h4hZt9opqP9W9MULuJUqghJBAkdDNXI1wYg8s4rBULr6Xh4k0epaRCJOb+r9bZ3D0k1iJRRIRqwpGyrwQ4WVQWwlUemVbrYhg54fvwdo4IjqyaH8cFKiow4MNcQ0kw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccd4334-d390-4c7b-a60a-08dead0ed7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 14:33:59.2082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6jUD8VuV+dsNgVd0NsjFdeNGb46iLsJleKFdZmze3AU95z1JGLs0EHsFLPHAqMgOiZ7MsW0TIxTndawGJsplA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605080149
X-Proofpoint-ORIG-GUID: 2Xt6yNyKWFyUeTvMDACAultvV_JXMjUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0OSBTYWx0ZWRfX93sRLA50qHpI
 e+B/nWDE+D67/7kv120HL4KgNRdbfuNr/IT8uNxYTsQkbsw5IygoCLABrTam2JJlqSbp9IVRr/v
 gdO3Lj0VLvImmdqdsQYPfQlAfvd97j8iY7o+DQVWbjwgP60bGvR9ELaEfpR5AVSPt1xv/mQbkBq
 1NOUg2P4buODgCfriMJlkuoJLvCX2MNc+q5AuIsKNAvRquNQvhObMkf9ed70IsqXXXx7euyfJTd
 NLUvHWvCPT76Pf7pQg1YPEr0LIQEmomhddeBmgNyTsU5Z8wWQTKD03vrV0O2H8uncNR43mF71wA
 1I/ul1Rm4s1rzIMHp4FAnlgEaQEVFq+lq8eslfwCrYmj8MZ6d+bIOMepkxvcKl72g5y7zar7vNc
 fDhaBIflj6xDOtSfvujaEdVWb01U7dju8qJmdlXlLIcs4Z1JpgLJcB7x+cgVmrR3PWSy/Rs1AyU
 n1stfO6482z6sEv2UTA==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=69fdf45f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22
 a=64Cc0HZtAAAA:8 a=yPCof4ZbAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=kPTU4Ox9-TrdYrnGXQwA:9 a=QEXdDO2ut3YA:10 a=ODHx-8iJ7m4XgVya:21
 a=_W_S_7VecoQA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 2Xt6yNyKWFyUeTvMDACAultvV_JXMjUl
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_IA4PR10MB83013C640DBB740BE8872FE4903D2IA4PR10MB8301namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Q29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNp
cGllbnRzDQoNCg0KDQoNCg0KQ29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1
ZGluZyBFeHRlcm5hbCBSZWNpcGllbnRzDQoNCkZyb206IEpvaG4gTGV2b24gPGpvaG4ubGV2b25A
bnV0YW5peC5jb20+DQpEYXRlOiBGcmlkYXksIE1heSA4LCAyMDI2IGF0IDEwOjI44oCvQU0NClRv
OiBKYWcgUmFtYW4gPGphZy5yYW1hbkBvcmFjbGUuY29tPg0KQ2M6IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgRWxlbmEgVWZpbXRzZXZhIDxlbGVuYS51Zmlt
dHNldmFAb3JhY2xlLmNvbT47IGNsZ0ByZWRoYXQuY29tIDxjbGdAcmVkaGF0LmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIE1hcmsgTXVsdGktUHJvY2VzcyBRRU1VIGFzIE9ycGhhbmVkDQoNCk9u
IEZyaSwgTWF5IDA4LCAyMDI2IGF0IDAyOjIxOjM3UE0gKzAwMDAsIEphZyBSYW1hbiB3cm90ZToN
Cg0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCAwYTkw
MjA0YWU5Li5jZTJiNDk0MDg2IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9N
QUlOVEFJTkVSUw0KPiBAQCAtNDQyOSw3ICs0NDI5LDcgQEAgRjogdGVzdHMvdGNnL2FhcmNoNjQv
c3lzdGVtL3NlbWloZWFwLmMNCj4gIE11bHRpLXByb2Nlc3MgUUVNVQ0KPiAgTTogRWxlbmEgVWZp
bXRzZXZhIDxlbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbT4NCj4gIE06IEphZ2FubmF0aGFuIFJh
bWFuIDxqYWcucmFtYW5Ab3JhY2xlLmNvbT4NCj4gLVM6IE1haW50YWluZWQNCj4gK1M6IE9ycGhh
bg0KPiAgRjogZG9jcy9kZXZlbC9tdWx0aS1wcm9jZXNzLnJzdA0KPiAgRjogZG9jcy9zeXN0ZW0v
bXVsdGktcHJvY2Vzcy5yc3QNCj4gIEY6IGh3L3BjaS1ob3N0L3JlbW90ZS5jDQo+DQo+IFRoYW5r
cyBmb3IgdGhlIHJlbWluZGVyLCBKb2huIQ0KDQooSnVzdCBmb3IgY29udGV4dCwgQ8OpZHJpYyBz
dWdnZXN0ZWQgdGhpcyBhZnRlciBteSBwYXRjaCB0byB1cGRhdGUgdGhlDQpsaWJ2ZmlvLXVzZXIg
c3VibW9kdWxlIGZvciB0aGUgY29tcGlsYXRpb24gaXNzdWVzLikNCg0KPiBJ4oCZbGwgc2VuZCBh
IFBSIHNob3J0bHkgcmVtb3ZpbmcgcGFydHMgd2UgYXJlIG5vdCBsb25nZXIgdXNpbmcuDQoNClFF
TVUgbWFpbnRhaW5lcnMgY2FuIGNvcnJlY3QgbWUsIGJ1dCBJJ2QgdGhpbmsgaXQgaGFzIHRvIGdv
IHRocm91Z2ggYQ0KZGVwcmVjYXRpb24gY3ljbGUgZmlyc3Q/DQoNCklmIHRoZSBjb2RlIGhhcyB0
byBzb2FrIGluIGEgZGVwcmVjYXRlZCBzdGF0ZSwgSSB0aGluayBhbiDigJxPYnNvbGV0ZeKAnSBz
dGF0dXMNCmJldHRlciBmaXRzIGl0IGFzIGl04oCZcyByZXBsYWNlZCBieSB2ZmlvLXVzZXIuDQoN
Cg0KcmVnYXJkcw0Kam9obg0K

--_000_IA4PR10MB83013C640DBB740BE8872FE4903D2IA4PR10MB8301namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPHAgc3R5bGU9ImZv
bnQtZmFtaWx5OkNhbGlicmk7Zm9udC1zaXplOjEwcHQ7Y29sb3I6IzAwMDAwMDttYXJnaW46NXB0
O2ZvbnQtc3R5bGU6bm9ybWFsO2ZvbnQtd2VpZ2h0Om5vcm1hbDt0ZXh0LWRlY29yYXRpb246bm9u
ZTsiIGFsaWduPSJMZWZ0Ij4NCkNvbmZpZGVudGlhbCAtIE9yYWNsZSBSZXN0cmljdGVkIFxJbmNs
dWRpbmcgRXh0ZXJuYWwgUmVjaXBpZW50czxicj4NCjwvcD4NCjxicj4NCjxkaXYgc3R5bGU9ImRp
cmVjdGlvbjogbHRyOyBmb250LWZhbWlseTogQXB0b3MsIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMt
c2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KPGJyPg0KPC9k
aXY+DQo8ZGl2IHN0eWxlPSJkaXJlY3Rpb246IGx0cjsgZm9udC1mYW1pbHk6IEFwdG9zLCBBcmlh
bCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwg
MCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBpZD0ibWFpbC1lZGl0b3ItcmVmZXJlbmNlLW1l
c3NhZ2UtY29udGFpbmVyIj4NCjxkaXYgY2xhc3M9Im1zLW91dGxvb2stbW9iaWxlLXJlZmVyZW5j
ZS1tZXNzYWdlIHNraXBQcm9vZmluZyI+DQo8bWV0YSBuYW1lPSJHZW5lcmF0b3IiIGNvbnRlbnQ9
Ik1pY3Jvc29mdCBFeGNoYW5nZSBTZXJ2ZXIiPg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJwYWRkaW5n
OiAzcHQgMGluIDBpbjsgYm9yZGVyLXdpZHRoOiAxcHQgbWVkaXVtIG1lZGl1bTsgYm9yZGVyLXN0
eWxlOiBzb2xpZCBub25lIG5vbmU7IGJvcmRlci1jb2xvcjogcmdiKDE4MSwgMTk2LCAyMjMpIGN1
cnJlbnRjb2xvciBjdXJyZW50Y29sb3I7Ij4NCjxkaXYgY2xhc3M9Im1zLW91dGxvb2stbW9iaWxl
LXJlZmVyZW5jZS1tZXNzYWdlIHNraXBQcm9vZmluZyIgc3R5bGU9InRleHQtYWxpZ246IGxlZnQ7
IGZvbnQtZmFtaWx5OiBBcHRvczsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogYmxhY2s7Ij4NCjxi
Pjxicj4NCjxwIHN0eWxlPSJmb250LWZhbWlseTpDYWxpYnJpO2ZvbnQtc2l6ZToxMHB0O2NvbG9y
OiMwMDAwMDA7bWFyZ2luOjVwdDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7
dGV4dC1kZWNvcmF0aW9uOm5vbmU7IiBhbGlnbj0iTGVmdCI+DQpDb25maWRlbnRpYWwgLSBPcmFj
bGUgUmVzdHJpY3RlZCBcSW5jbHVkaW5nIEV4dGVybmFsIFJlY2lwaWVudHM8YnI+DQo8L3A+DQpG
cm9tOiA8L2I+Sm9obiBMZXZvbiAmbHQ7am9obi5sZXZvbkBudXRhbml4LmNvbSZndDs8YnI+DQo8
Yj5EYXRlOiA8L2I+RnJpZGF5LCBNYXkgOCwgMjAyNiBhdCAxMDoyOOKAr0FNPGJyPg0KPGI+VG86
IDwvYj5KYWcgUmFtYW4gJmx0O2phZy5yYW1hbkBvcmFjbGUuY29tJmd0Ozxicj4NCjxiPkNjOiA8
L2I+cWVtdS1kZXZlbEBub25nbnUub3JnICZsdDtxZW11LWRldmVsQG5vbmdudS5vcmcmZ3Q7OyBF
bGVuYSBVZmltdHNldmEgJmx0O2VsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tJmd0OzsgY2xnQHJl
ZGhhdC5jb20gJmx0O2NsZ0ByZWRoYXQuY29tJmd0Ozxicj4NCjxiPlN1YmplY3Q6IDwvYj5SZTog
W1BBVENIXSBNYXJrIE11bHRpLVByb2Nlc3MgUUVNVSBhcyBPcnBoYW5lZDxicj4NCjxicj4NCjwv
ZGl2Pg0KPC9kaXY+DQo8ZGl2IGNsYXNzPSJQbGFpblRleHQiIHN0eWxlPSJmb250LXNpemU6IDEx
cHQ7Ij5PbiBGcmksIE1heSAwOCwgMjAyNiBhdCAwMjoyMTozN1BNICswMDAwLCBKYWcgUmFtYW4g
d3JvdGU6PGJyPg0KPGJyPg0KJmd0OyBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJ
TkVSUzxicj4NCiZndDsgaW5kZXggMGE5MDIwNGFlOS4uY2UyYjQ5NDA4NiAxMDA2NDQ8YnI+DQom
Z3Q7IC0tLSBhL01BSU5UQUlORVJTPGJyPg0KJmd0OyArKysgYi9NQUlOVEFJTkVSUzxicj4NCiZn
dDsgQEAgLTQ0MjksNyArNDQyOSw3IEBAIEY6IHRlc3RzL3RjZy9hYXJjaDY0L3N5c3RlbS9zZW1p
aGVhcC5jPGJyPg0KJmd0OyZuYnNwOyBNdWx0aS1wcm9jZXNzIFFFTVU8YnI+DQomZ3Q7Jm5ic3A7
IE06IEVsZW5hIFVmaW10c2V2YSAmbHQ7ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20mZ3Q7PGJy
Pg0KJmd0OyZuYnNwOyBNOiBKYWdhbm5hdGhhbiBSYW1hbiAmbHQ7amFnLnJhbWFuQG9yYWNsZS5j
b20mZ3Q7PGJyPg0KJmd0OyAtUzogTWFpbnRhaW5lZDxicj4NCiZndDsgK1M6IE9ycGhhbjxicj4N
CiZndDsmbmJzcDsgRjogZG9jcy9kZXZlbC9tdWx0aS1wcm9jZXNzLnJzdDxicj4NCiZndDsmbmJz
cDsgRjogZG9jcy9zeXN0ZW0vbXVsdGktcHJvY2Vzcy5yc3Q8YnI+DQomZ3Q7Jm5ic3A7IEY6IGh3
L3BjaS1ob3N0L3JlbW90ZS5jPGJyPg0KJmd0Ozxicj4NCiZndDsgVGhhbmtzIGZvciB0aGUgcmVt
aW5kZXIsIEpvaG4hPGJyPg0KPGJyPg0KKEp1c3QgZm9yIGNvbnRleHQsIEPDqWRyaWMgc3VnZ2Vz
dGVkIHRoaXMgYWZ0ZXIgbXkgcGF0Y2ggdG8gdXBkYXRlIHRoZTxicj4NCmxpYnZmaW8tdXNlciBz
dWJtb2R1bGUgZm9yIHRoZSBjb21waWxhdGlvbiBpc3N1ZXMuKTxicj4NCjxicj4NCiZndDsgSeKA
mWxsIHNlbmQgYSBQUiBzaG9ydGx5IHJlbW92aW5nIHBhcnRzIHdlIGFyZSBub3QgbG9uZ2VyIHVz
aW5nLjxicj4NCjxicj4NClFFTVUgbWFpbnRhaW5lcnMgY2FuIGNvcnJlY3QgbWUsIGJ1dCBJJ2Qg
dGhpbmsgaXQgaGFzIHRvIGdvIHRocm91Z2ggYTxicj4NCmRlcHJlY2F0aW9uIGN5Y2xlIGZpcnN0
PzwvZGl2Pg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0IiBzdHlsZT0iZGlyZWN0aW9uOiBsdHI7IGZv
bnQtc2l6ZTogMTFwdDsiPjxicj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0IiBzdHls
ZT0iZGlyZWN0aW9uOiBsdHI7IGZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsi
Pg0KSWYgdGhlIGNvZGUgaGFzIHRvIHNvYWsgaW4gYSBkZXByZWNhdGVkIHN0YXRlLCBJIHRoaW5r
IGFuIOKAnE9ic29sZXRl4oCdIHN0YXR1czwvZGl2Pg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0IiBz
dHlsZT0iZGlyZWN0aW9uOiBsdHI7IGZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigwLCAwLCAw
KTsiPg0KYmV0dGVyIGZpdHMgaXQgYXMgaXTigJlzIHJlcGxhY2VkIGJ5IHZmaW8tdXNlci48L2Rp
dj4NCjxkaXYgY2xhc3M9IlBsYWluVGV4dCIgc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsiPjxicj4N
Cjxicj4NCnJlZ2FyZHM8YnI+DQpqb2huPGJyPg0KPC9kaXY+DQo8L2Rpdj4NCjwvYm9keT4NCjwv
aHRtbD4NCg==

--_000_IA4PR10MB83013C640DBB740BE8872FE4903D2IA4PR10MB8301namp_--

