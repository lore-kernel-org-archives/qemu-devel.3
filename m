Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516C8CD4F25
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMr9y-0000h2-Pw; Tue, 12 May 2026 13:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1wMr9t-0000gA-9n; Tue, 12 May 2026 13:44:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1wMr9n-0007DV-FN; Tue, 12 May 2026 13:44:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CGfebQ4125273; Tue, 12 May 2026 17:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=Ryk5nl8zkU+SiVKOnl
 3NZvtmyivJY4s2Twc0owk8MqY=; b=SkbtJPgM3VzjwdT0l5TEbqg8ZRkPByDwap
 0BEonqbDudEnuMD3M3rWkVLqVOQt+A2gdxK070chwGmD+gBs0mfl1ahG3cq7qWRV
 dinVno/D08X629tmdjn5TaGDkyUy1mjOjpgDgD0lPszRi/vs+vPfSidp4zaFmYC/
 MmW3tbVsno2Ve0Jet0zCYjuEgJzlo1vioj4QcnMw0rPHCUabi4PbxtMz9Ywp/ODj
 zJzX5XDATYjRsbKrAuZaZTqBVSvN9NmNUNDCzkOvh/MLVrxl6cjE437RJStb95DK
 zDQhR+70BFWFozAYCfGThYhXLKo1A4Q5zWmGdw5kKcaJwevKYoLw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv29ptk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64CHfnAL022682; Tue, 12 May 2026 17:44:14 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4e3neahn3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 17:44:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW9FJydTdEbfno/fCa499OGBQ/WHGqnFYG58Qm5DmIQ8tD3qARSMjFfFykpRZuKaTdgFunLNSkBvSYObNBrNqL2vHDtor8xlxFSFXxSSPe7UrDQvJe/7kQyMuFkmH+MDT0sLJ6lRIb5MXPLRhSW6FR8dn6ULchJ3XwuEbdcXjQg1IGFyqjcLzR30YY18zBd1nSSO5lG5V2D6LvCrgvbskmMpddJi/nLkTwp8AoKBMDsVzt9hufyY0E+HnCGkx17Tc9RVRi4lKGpsp7B9KWRIs7wmW0e+jWvGn/HZECJLD32tI5KzTy1P5VqmLJfiYwBtlsLDnXy1LGmTrzpcpNwJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ryk5nl8zkU+SiVKOnl3NZvtmyivJY4s2Twc0owk8MqY=;
 b=DHGE6Yp6vo2TLw/qKS1P1eFisIFWlee7SC2EwskzceMPqZoTjQhKcJ2V0fl1BWHI2/wbsBnhOJ1LiW1ZKVmwwrplYru3KkFirVFHeM0CwPn9XD1uHZUbNOGUpsxnIte965RaKRln6+jr6ru3P5l9EUewjsiBpp6NewjDfUG40IIoET/7wfnaRp0aujwbXhvG/7p1eaHA1jhRlblFQ+nwyr4QVfc8cRmCozsV6Dh85v9j80XcCfsso2Dd51WFsVXp+POUT6yCs3nBB2neVGuqtHHZUyuC46C2GgnidQFRSDiGTVUrxXyu2NhEmITDJhFI+TumT18N8/q3cAfxQxDCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ryk5nl8zkU+SiVKOnl3NZvtmyivJY4s2Twc0owk8MqY=;
 b=qg21g4GwQNBEkHJHzLb67IsSzExqSu0WLZWZ1OU21BY6VEEgFnFPpUQPGqL6Um2tEFy6oetHnwQBVzMS3lcyIkKXqBT/rFfgrQPh5yFcmkgtOAESSFOIMT8+osodpI2/oCsUMdP1Ud4qrM2XXqPjkRWZFBFtE5ZqOxnT5cYehlo=
Received: from BLAPR10MB5170.namprd10.prod.outlook.com (2603:10b6:208:321::18)
 by LV3PR10MB8155.namprd10.prod.outlook.com (2603:10b6:408:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 17:44:08 +0000
Received: from BLAPR10MB5170.namprd10.prod.outlook.com
 ([fe80::f215:a25c:4fce:d191]) by BLAPR10MB5170.namprd10.prod.outlook.com
 ([fe80::f215:a25c:4fce:d191%6]) with mapi id 15.20.9891.008; Tue, 12 May 2026
 17:44:06 +0000
Content-Type: multipart/alternative;
 boundary="------------8sj7lWwTxzEfWTXFxHeN3JmE"
Message-ID: <e64c6822-8433-4e05-872e-976d9aa7f2b7@oracle.com>
Date: Tue, 12 May 2026 12:44:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Glenn Miles <milesg@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Harsh Prateek Bora <harsh.prateek.bora@gmail.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
 <36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com>
Content-Language: en-US
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com>
X-ClientProxiedBy: CH5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::22) To BLAPR10MB5170.namprd10.prod.outlook.com
 (2603:10b6:208:321::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5170:EE_|LV3PR10MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 117f3262-0cc5-4035-752a-08deb04e1033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|8096899003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Mi9S8oIWE6fGmhpVt1C+SAYGRW/D+rUDWnjn6tBA+UlrLAmFVAw7gI4dfQJK7XWFaDcpFjT7JmzLTAXz6ipTVFK51EiSuYbuUZkG6Ut1PH/Jl+W/Yc5lrfRO5SQcpQR0XGiW4DC0i2w1fcYXXz4NpiUxSYM5Yo9nzyheU/4Rwio1dfNWvBhUMF4eeIu1NPlIzapO4qrf0FCqFsEWPUolp1iFMowHq7rTaJ/7jnv/Q9LlISLaIOzMqtV3HgwvdKlEAapVkcXT0iYPnPV718V32WwlIzXr4nC0epWCuPEIh69cPiE496D1Zv7li6JLRyd7HmlFX3FgYevDwYb4NJTDht2T7enyqC8MY6qsy9qkYyZN/HrWbP/+CyEPmmISrGB+mvZqePeECHA8Uvtq2rpKsse3uFq4+X0Jrbn5yrokj0ZqTprYo/ywfrl4ZTKLU7nbgH26ez3OGRO+a+q5DjnkxA5ga7uS73ec1OLWziLRrYVDr2DBR2D8QXE8xo/HU8yuTFA3/Yn5OgXxYoEGBcQN6xWSbbRPhzArujLtASQ1LCBhGS4u9u5fNptn2aWmdskWnfJ5PUBIxBRugMagr1j5xOTVWFPMkSXNPBvLnpZQtwH1WsrkBN9tggwuaNk8/n8ha3XHejrP5saFJU9u88szLdWy4Nte5efZLjh42raZXP9acJclL27iy0vUf+POz56D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5170.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(8096899003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TksxVnViM1FxRWJGNStRZmFBMzBUa0h2UEZLUVJZa05oV084cDNIakt2RVpQ?=
 =?utf-8?B?YW9tSEdLLzF5ZlZYenhDVU5nRUFndnhMaE5abkl6eG03MS9XenhEOVRlNVJC?=
 =?utf-8?B?Z0VQcEY5UURwZnpUeG1HSXpqenF3RXNlNC9pVG9sbUdQWThzczV2UkZGTlJM?=
 =?utf-8?B?YkxROHBPbE5idDFpbGErNnlCVEdSSHQ3QWJaM0UrVU1jNWN0d0toQm5PVEky?=
 =?utf-8?B?Sk1HVzhGVDJJS0piR0s0KzBzSW4rTWZFLzdFQ2MrRFJsTS8xY21FUkdjY3or?=
 =?utf-8?B?N1ZVSFRuNmZlRW5ITnIwcU8wMVNMc1B1WkNEODBpeU5MWjlaMGlHTmdZellI?=
 =?utf-8?B?aGx2bzZLblcwbGZSZ2w0WEJiNDNuZXdHS3ZvN3gxbFdZUEtDTFl1TU9GL0la?=
 =?utf-8?B?cjZLWDhreFczSFhFdkhSSmNzUXk2Z1hCaDhVWjJiZENoTmVGMWhiOUJpVllC?=
 =?utf-8?B?ZGVSSmdqUUQ4TEkwVURaeUJRZmVSRHdkaDRFQjJ4N1hKNFVxc21PQS9Mdkx4?=
 =?utf-8?B?R2k1MHFxM1VGcDB4Z1d6WUZLVDlyaDZxR1JmZmVmdVMyREJ3ZEI2a0pLTFFI?=
 =?utf-8?B?QlpPS3JtUmpnZCtZQkVqcGtOa0NKWVJnK3krSjZIMCtUMVhYZTJDb3UvZ1BC?=
 =?utf-8?B?cHhvVk9xZHR5a0FsTUhxOUN5Tm1GdFVjRHlpdS9vYzVRTlRqQXpMaVJqdlpI?=
 =?utf-8?B?ZnVQUTVCZVdDT3hSYWhMZGFJSXRwdlNJY0hrbHVlM3ZWRldjNFZ3aDhaQ1lD?=
 =?utf-8?B?bGwrT25MUzBKNFErNTZuRDFSSmp5bGd0MldMRWdJN2FOWXBxOC9Fb3czdC82?=
 =?utf-8?B?Ry8vSXc1allIMU1mVElieXNidnpLU3NvUUxYU255WjFWOEZpUzg3TU42NG9t?=
 =?utf-8?B?bTRaWW9UK1NWZXBIVHFURStBOVg1ZjM4bllYWm5KSGZQSGwyNEo0SktpVEwr?=
 =?utf-8?B?NUtNTUluSTgzSjMyMVRvQVBpNWR4UGNDNkxaeDd0aXEzaVZVbkVESUpTbStF?=
 =?utf-8?B?TUZtdlRMcW5HSWJMbVozaTV3ZmwyQUxZeUNsWTZYT0E3K1dOQkNPWjZzS3JM?=
 =?utf-8?B?UEN4SDNBZGlQd3g4WTRNK042K0FMTE03U29pakM0TlFPSkZESmJqL29aR2s0?=
 =?utf-8?B?MUxyUWNKTE5uYWJBYktnY096OGoxaE1leWY2Y3h4dmY5NzVyM2xPaFdpVXZZ?=
 =?utf-8?B?Wm9MZ0NKdEJRZmtHQkdTL3g4Q1cvM1hSWWhJTkp2M0RiSVlsQTVPd0ZBVmd4?=
 =?utf-8?B?WWpaa0pySSs2MzNlWTg5RVh3OHhCUFV3RnFPbjJ3VjJPak1lUlY4eFFaOFRw?=
 =?utf-8?B?cW54c05zdFhSUFpXTVc3NkxYSVROdi9Sa1JIQzFLdHJnUW9FRTZzSkxRVlRW?=
 =?utf-8?B?S0NjMzBkL3p3SXFXSEwyOUoxcG11VlpXZEdHOURDQ3Z3NEpkV3RqdUZyc0Rk?=
 =?utf-8?B?KzJKNGIrOW1rZERiaEd2ZUx6Z3Y1dk9xT2JqeE43RFZidEo3TVVyVWk3bXFs?=
 =?utf-8?B?alIwWmhTL0JzOXNlMUZNd0VXQmU5U2k5dEZ1Q2pveDh3SHlON2Q0ZGoyeGg0?=
 =?utf-8?B?VXltS2FEMHUzV1BOc3JjZTBBQUsvRXBHU0FhUHFQTG5MWjlEVGNmTlZFZzh0?=
 =?utf-8?B?NC9ncUxsL25GTUxYVTJ5cmEwZTAzUmM3MzMxc1RDN2dVOTNuTVJ5WGpoZFJw?=
 =?utf-8?B?TXJubXFUZUt5ank4VDFmSDBsc0lOZm1mdWhmQ1lOL2lMV3V3NFM3WjZWeGQv?=
 =?utf-8?B?NXdIQlFIaE1sNG5Cc20vcTBOR0lJdzMxbVVaRWNsSy9WSVJKRFdIVE5wV2lw?=
 =?utf-8?B?SHdQdGtoUjFXYUUxYmEzZEtYZDZkZVg4dDRwOW1pR3crQllNb1BxS2JMeWZ6?=
 =?utf-8?B?QndhREZKdTBkR1ZJcVZmNkxNTVEwWXF6MUsybFg3aGROK1hQMjgwUmxqRy96?=
 =?utf-8?B?Tnk4V1o1NG5YODdUanVLeDF6RUpFamJkRWdIM1U1SGF3OXBvLzRqVWdlVzY3?=
 =?utf-8?B?RjZSOURHVU5VV1VxcCtGM1ZiRE5NdzRzSkpGOWRYK24rME1yZFJwellQK21V?=
 =?utf-8?B?Q3gvUlVWMlJvS0NkN3lsbllxcm9saGl6bityRlNuTzlKeVBQNU4wOVRVWXNp?=
 =?utf-8?B?ZHhtc0E5d2NlNEE1cjNYMFRuNXlqSGpXK0R0RUZZQ1lCVTNrcUF1anNrK3dV?=
 =?utf-8?B?ZTJyZ0RPaU9RQ0JZcm9jVXZmM2hRc0pnYVRQU0tYMDFZZXJkUS9UQ1NjMGJE?=
 =?utf-8?B?UlJwQTlzYUxUeEVkUGV5RitFYTl3eGgrVGhHQkUrdm5wN0s5bHU2YWJDeWNO?=
 =?utf-8?B?Z0ZXa0MwSnFNRkZ0ZHR4SlAvUlAzSjZRVVpia2JkRXJUaWJpSVVvQT09?=
X-Exchange-RoutingPolicyChecked: tG7g/Q5ac8SiG+zMBZy731y15r9mVpuKFTgro3N1SNWUgHCIexzzZGJR0QCY1gi4uU4GpmW7+L3DKUWZntmXXRNI4DWpptN7VdjnsclEnYI1JWGf/hPAFeNMiNnC8XPT9qNoZNLUZuyZZa6PZUAWN50m7h8orVnwyw9/VxEe4eyjkFhP5LUzvpmkl1K/udNJnTU3gS+9N5hFNkWiXESmnYQP/arh1Ii6e3L5gq9W4RspSKfz368U851723ZcEepmOy0rDMsifa7NcpqeRyNy8PV08S1XP6LaXkrVt+PtlY4+E2x2lCQi0oDem3BpRyqBTO2iAmti0Dl4G+JopytM0Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YH4qxmmm/W+ELz6OsaXCv+SknDfZowhtfN5OYI19nb0eM/P4DQ3rXjKvXia0613ze65lYuZFjV7BT+hhM/TqNh7XHcak57odBCuHRjpGwkG6IAOGcfrX2Dr5O5cobCZsRFlvTZSAgIxbSfb31PN7rAADDKP3L4ZI+fJlhmI37uFb2s6FEuJIrLHsT1r8SqLnSxl7B7Eb/9Dbc7A/cwaz1yuq5sfRjkPxbYbl9N45CQhGq/qqGTDl3u11bQIa7a64HB3Ex6UyF8SWQksj/VRZCxhue2R1td+hVlaxHiyp6RUTgnDiqiJz6KR/FHqiKWOZBLeYXpTf1lyx4jVTtwvvhUojZZMaX8w/gpmALsnwOMC/OKEGVAsKL9NJRDgTyjgxHFLYCkJzF8LkteP2AQLxJNJ/n4WIpNuL9aHrvYkfFxF0h72oxVUseHbE7ehw1VsYczV8rOvZ5kUlhvYcVraXcjVPucFzb5XFsuF1/VbHd6UtBe4RaBKf5r+K8cscL8iWIqClUJu6PpHK7MBXTUI1m3t7zLi1T6v8JZMnwp/UGMQ8cp4opRDdp4nxYzJhU+evqtfxjE6YlFpv/3QLNyqwFQGdFJEs3w9ioiYXxjguwH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117f3262-0cc5-4035-752a-08deb04e1033
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5170.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:44:06.0974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hx4uL1b1y4MnGQTUDbDJlHRN7jB+2YO45vrN4dJM00rjmfFM+jN9zbQqS/YBygilJKU2j9rvb72EH7CcEGyexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120184
X-Proofpoint-GUID: t2pjer4k0m5tkQUuE0NU9JHnpaIZ-rOa
X-Authority-Analysis: v=2.4 cv=ed0NubEH c=1 sm=1 tr=0 ts=6a0366ef b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=M98VLt0xmqTDZtsn:21 a=xqWC_Br6kY4A:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=2o6O_lVPLw9ftnABGNcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tK66_9wYJU7LUoQhy48A:9 a=35r52zbcmUzyxhbn:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-ORIG-GUID: t2pjer4k0m5tkQUuE0NU9JHnpaIZ-rOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4NCBTYWx0ZWRfXwWUeKGH6lWVz
 fN7Y0Ml6dtQaajPAst/rCj8Zrkq5keB3EjBybdcPDWhdsp68q0UlSMQms1j/P1apJVKE2rq4vng
 sHl2xSmMZ0b6XjbfcDU0jCNNhNfJXV2XDqnY+5MNRrLLieP/4tHqVyPcsrwZ2g4/5kEcnMwa4xV
 fQj4bduuOtSsHbrRUtHAO+VKeW5DVViufrv70yyvB5Zp9rYO5FCWEcXx8suZ5iwfegO6lH/EuMo
 bzb4A5IFdQOurz/5+tpej7tT2Xju0RXUx6FiX+8DDpshIauMu9wHJ6u/D4sEzvzC8/puIAHbnr8
 0VnYP89kf2kyPtaDNwxWdvTuhqXtsOI2amy/p+ajTzt/BhPrU3EY1fNEUy9ewuC1DoN4O2lu2ua
 KCUIPWUn9TQRdHZW/KaweY2rxKJYUkkuGknM3K2bSj/cwcjFhiqu4dhGWYg7cB+GGV6OKhTBSBZ
 Q6x/7GyP6Ls47rk4zog==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
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

--------------8sj7lWwTxzEfWTXFxHeN3JmE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/6/26 7:26 AM, Cédric Le Goater wrote:
>>      MAINTAINERS:3165: CheckPoint and Restart (CPR)
>>      R: Peter Xu <peterx@redhat.com>
>>      R: Fabiano Rosas <farosas@suse.de>
>>      R: Mark Kanda <mark.kanda@oracle.com>
>>      R: Ben Chaney <bchaney@akamai.com>
>>      S: Supported
>
> Since Steve has retired, I believe Mark has taken over and should
> be promoted Maintainer. Correct ?

Maciej Szmigiero (cc'd) will take over as CPR maintainer (thanks Maciej!).
I will remain as a reviewer.

Thanks/regards,
-Mark

--------------8sj7lWwTxzEfWTXFxHeN3JmE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#f9fcff">
    <div class="moz-cite-prefix">On 5/6/26 7:26 AM, Cédric Le Goater
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com">
      <blockquote type="cite" style="">&nbsp;&nbsp;&nbsp;&nbsp; MAINTAINERS:3165: CheckPoint
        and Restart (CPR)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; R: Peter Xu <a class="moz-txt-link-rfc2396E" href="mailto:peterx@redhat.com" moz-do-not-send="true">&lt;peterx@redhat.com&gt;</a>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; R: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de" moz-do-not-send="true">&lt;farosas@suse.de&gt;</a>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; R: Mark Kanda <a class="moz-txt-link-rfc2396E" href="mailto:mark.kanda@oracle.com" moz-do-not-send="true">&lt;mark.kanda@oracle.com&gt;</a>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; R: Ben Chaney <a class="moz-txt-link-rfc2396E" href="mailto:bchaney@akamai.com" moz-do-not-send="true">&lt;bchaney@akamai.com&gt;</a>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; S: Supported
        <br>
      </blockquote>
      <br>
      Since Steve has retired, I believe Mark has taken over and should
      <br>
      be promoted Maintainer. Correct ?
      <br>
    </blockquote>
    <br>
    Maciej Szmigiero (cc'd) will take over as CPR maintainer (thanks
    Maciej!). I will remain as a reviewer.<br>
    <br>
    Thanks/regards,<br>
    -Mark<br>
    <br>
  </body>
</html>

--------------8sj7lWwTxzEfWTXFxHeN3JmE--

