Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3E606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=KL5idk/2;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=e0Sn8W43
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMP2h-0007Lv-Q1; Thu, 29 Oct 2026 08:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1xMP2X-0007K5-Qi; Thu, 29 Oct 2026 08:15:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1xMP2U-0000Df-TL; Thu, 29 Oct 2026 08:15:29 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8wUIh530340; Thu, 29 Oct 2026 05:15:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6q32oO3j/j3WS+eRRQkAoJ6fHqrzdeXMoXc+r3Bp/
 nY=; b=KL5idk/2eBH20A1QgYvrm+o/X5FbDrqiW9LgS/8qxctwq9wPmeSju0U7b
 sBv4IqeIhWMU71SQcsVWSlK5QBTrfAXzOGBZSSFVtMZHTnehv8lRZsMUk23yUxWE
 zd9bOUsd5gmWXIyPsadsEAKWs/Zu/smI6WNXB5SVpaGifm4LPqyhJwPsa+PQ9BPY
 Ueq/2b3J4Uf9w9IFWQ2dqgEXAjAcO2R9Xj9DLRKS4VP3w/QpGJ3OfnPvsP8iZMaP
 I/jp2OCgGpg5njaqvyluF/pewEPK7rhudyN43Uo8L/bs54djcxeohUNczE4+ORiY
 l8jhU1OJxbbasthv2DKhbHITQzStg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022093.outbound.protection.outlook.com [52.101.48.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hk40ncr1e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 05:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHQyi+G7BLzZ+4egTtmTpHnQjoLPE7cvnnJQLJQx6NKg2UgavmYCEpFwbS9cumqHxzgM01a8e5aDSu8YFpwHaVUwYJm00cOzZzcWq2Epo5ZG9ld/8GFRFVyagIIOrxWHkaNQCjmS/FLt/mSEpoHFwylCe10ViaurhfRe/jymN7e3EY2GsCXvd9EgYNkvMQLFsV/5Q2+rnoyDa3dmbr9pWE6TY+FntP2x5aYNaMEWlk4MpdHWx/GMfm7E+nuqn+oJ8NIInKi92lMl53QlhocJVAaJdroLkoRqiJySGARb8ddzB4iAOpbEK7GNoc0YtzU5A2GyOkDkQcY7IpYjMbToEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q32oO3j/j3WS+eRRQkAoJ6fHqrzdeXMoXc+r3Bp/nY=;
 b=Ta6O7xNfGIRmaYPWKLTZVKb/VKD9dP2+tZ2A0JqzqmlZEyUzVK1B4KfxAi/mlKS1UA0hpX5fHbivAG0BYmeYd0Cld8wTpXbsS6e6jcUXmt2dg+jh7n5W5z0Air4jh9VgyLLlNdoGTnG0LfVLRxlT+TQx1rIq1hclek9aGqIt3pmFzBZ+joTqZhoSdUKiRTTOzN9sBWgMREdjiH1uSwC3EMrqO2B1sf13BM7M/mvazZjbJfTadpSDxWofPbIlW9UmKiYyoCee93M4d2hOdJNpt3Gr/2AwCRHmif7Y+u1PZXmhSkuInRQ4vZn/qjkmZnsp6ydf/MKeXLzBI+dS+COOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q32oO3j/j3WS+eRRQkAoJ6fHqrzdeXMoXc+r3Bp/nY=;
 b=e0Sn8W4320YI1k032AT6RLN56p00tfZU6JD/cQ3H2KMtT92St7MT5xJva4UJMCkVp7MB/Im3MTNhybIi6xcNlqBUw0TMLYVfoOtBdLn2ylEIUw8Vd68KkpaSuhXwHGM0S8g868kGDlEzELKGTwQhTSGRIcQXDLGNoh/wp7OB/AbFOVNiqcTdiaXeZICoAAuqC3y5nDs/siC6nhdG9QEeeXNfOn/J5vB8D0+INf+AgaSDqqQd6KicRQhVX7dMjZp9ex5PE19Xj7BPfVNRciLUrM6987I0tXLObAoCJRQef4zq2zNJcwVoSqdD3ZgB1T/Tu8cDMpcbEMMz97gWSTJk7w==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by SAWPR02MB11416.namprd02.prod.outlook.com (2603:10b6:806:4ca::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 12:15:08 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 12:15:08 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: Eric Auger <eric.auger@redhat.com>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>, "7746591750@163.com"
 <7746591750@163.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "amachhiw@linux.ibm.com"
 <amachhiw@linux.ibm.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "milesg@linux.ibm.com"
 <milesg@linux.ibm.com>, "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "mbawa@redhat.com" <mbawa@redhat.com>
Subject: Re: [PATCH for-11.2 4/9] target/arm: Enforce MPIDR into isar.idregs[]
 storage
Thread-Topic: [PATCH for-11.2 4/9] target/arm: Enforce MPIDR into
 isar.idregs[] storage
Thread-Index: AQHdZ4c1QBEq74xwq0aDyOzRm6XGz7cUbywA
Date: Thu, 29 Oct 2026 12:15:08 +0000
Message-ID: <D7EFD669-A410-44E9-B8DB-23E0AE3B300D@nutanix.com>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-5-eric.auger@redhat.com>
In-Reply-To: <20261029092307.281287-5-eric.auger@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7564:EE_|SAWPR02MB11416:EE_
x-ms-office365-filtering-correlation-id: 9abe75e2-c69e-491c-0038-08df35b64612
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|261022113327099003|4143699003|56012099006|261009223027099003|261021130227099003|261022075727099003|261026121527099003|261022115727099003|261026130827099003|261028144727099003|261026140227099003|261026135527099003|261021121427099003|261021133027099003|261022105027099003|261021135927099003|10067099003|261021123027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0ko3VJA/rxsWdlHDCaPAkBp8jRfOw8wW+5kizLa/ldr/g9y+QLuJu2bFWvnGhqUeHnSu0rOfTQ2elE053DpEpB4hlmXopXZjFQq+4cDP3Bsr7xU0k+ASV5HYR0XYQoj/S9eqNSgefVUoss05WNcFnmFT9dwGJ1eKyeKLDpmmvBlMyAxAWQ+ktQ+t5HiI4RF+8pnrGQ9W2PlHwM5PsjDybQDQYItGEpWOQ2IqRdJt+IGcrBq/0JootvZNPL8BBjMVi5uBJZcWa/7kOsYVYGosiigQu92FRtUE80PcWxIcny0bLQo4599CWfwQBjMfhBhcLUnHJgbndzy5Ku/Vy3Vm0BZ07CZewcNdLb2vfzxepx0THnMXiDW+o4lSXFRnNjftAiAiMaVsNHDDy4g0Bl8i5PZFFr+OWsdIvLNHiI8dPX2LxuxAHMy2TTF1BKexl7ViyMSB0PUBiNavbF1sJNmkkmNLipCtfs+G2ZntRjgAyQnkOqtlUvxC599UShs/Vr7OcSGV8nlvOjDrezFNbRMph/g6l3ac0EEla8KDjmlM3ETv6DyY9kbKtMFMrWc7qOuXLDno8YLfpuUpZyZsHJt+glgBbty2+rixGbz+4HSXGWvFb/Y1B7eLKJL7zcVQ/C0sPZvyA7FUG0UtlYRbLHw+EJif0usoNQ0kgQS6bN4+O5tnm3vCsJlmI4ddgR2JVDBEemOh7egiNWyKu0c9LsFD4qOinrpqpv2UsCXeemgrh3U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(261022113327099003)(4143699003)(56012099006)(261009223027099003)(261021130227099003)(261022075727099003)(261026121527099003)(261022115727099003)(261026130827099003)(261028144727099003)(261026140227099003)(261026135527099003)(261021121427099003)(261021133027099003)(261022105027099003)(261021135927099003)(10067099003)(261021123027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1N1dWlhenBDcGdTQUFrSndRMG5sQi9WMEhuakxrVHEzQ3NhQTAzYklnRXdw?=
 =?utf-8?B?VnV3RUF2QUdFejdSZGQ5VEhUbGM2T1NCbHp3bmducDRsa2FxQ2hTaEU5WUI3?=
 =?utf-8?B?S2FGbUY5Y2Z3VEJDR2J6OUN6VGw5dTZZMlpjUnBkcStTN1NFT2xmWE5ZZDRw?=
 =?utf-8?B?cDBMQjNINSsvMG5vWElqN09XdnVUOGkwNlE0cXplRXN0ZU8xUlcwc2lBd0JN?=
 =?utf-8?B?dkpWV1ZEUGxSYlZ4QmIzR2p5SlFwdFZ2MHVaL3JTUFlYS3ZsRE9IZHZRa1Uz?=
 =?utf-8?B?QzR4MGZpYi9FclpLUThYN3hmeHpBUDR3NUdTYXZTVkoyRFZ6U3h3SjFJRGZq?=
 =?utf-8?B?WmhNOG9SVG5zYWZPQWMwRjFjLzBTNFVTRVB0T1FkUVpXNlExN0lvY3NuOGVU?=
 =?utf-8?B?OTV0Yk5xbW90YzUrcnpGcWFoRUhBVEc0VVdvYS9WR29PY3FHWDVSOEVlaVAy?=
 =?utf-8?B?MmhWYnZpK0YzdFpWTC90VXo5NW9CNk1GSkd3NHVyVXNGb0dXbWJSY1hkOGZo?=
 =?utf-8?B?ekhSS1o5d0UycmFQdXlmeEZoM3lvZ2Zvb0hOTHZjSE1IdGNGK0JsbkVuL2xG?=
 =?utf-8?B?V2pPS0ZLWTIzTlc0OVhkU005Z0lDelIvMDFtZ3hiQ3NraW9XOVJzRTkwbDFB?=
 =?utf-8?B?SDdoNDJOUHRNMk5PUkI0T20rcTFpZGw3RGcrYUpzMThSZ1lzZmdPck4vZEFD?=
 =?utf-8?B?cGUxa1RiakhLR1BldzFYaGwvZ2lxQUZGNzB0N0Z1SEd2UDNxcVdxMlZpL09M?=
 =?utf-8?B?NHZpeDhqLzJCa0hldDFrSUZMUmlKbURXcVJheWZ4b2JvL2w5OTE3V2dLWGpj?=
 =?utf-8?B?bVBrVmJ1WTFGOERnZmtHSHRBZ1VKVk9tZm85K3dmYkhiNHNvQ3ZaYy9vdzFD?=
 =?utf-8?B?WXBqaVZHLytHbDV3YjRSZ3Z1WFJzWmFESFdZYVZybU9ZN1ZFV2t1L1E0dHd5?=
 =?utf-8?B?azFDVHpSdUU3bWZnWnpQbXBWUlIrU3l4bVVHdzFnazM0SW1EdE1aeVBnM1Ba?=
 =?utf-8?B?QVFxYk5YdnUyeUVTSXpFNndjUnFBeVJoaGJPYTIzYndST0llTDJQQUE4bExn?=
 =?utf-8?B?Yk9XcmF6SUUzdmRwVit3Y0gxMWNtaGRKNEtCbE00VjlxTStLYTh6b1dwNXBy?=
 =?utf-8?B?S3l1WkR4b2kyK3pNeXgxeVZVTXNPaWwwc2swMWszNWFJS3NpK1RqVnVlRUhE?=
 =?utf-8?B?ejBua0dIaWdYVDZOckpKTnNVVUY5dDA5K05meHl5RE9YRktaSjZRamc3TEd2?=
 =?utf-8?B?WHdRUFdkTldQUWVQcnlrZmJCakg5UW13ZE1odjlFUVVJdS9mSS9QVWdLRGNQ?=
 =?utf-8?B?QkxyUnQvSmRvV3hBRGxkM1RYdDcvMFpUc3Y2UThLQjg3NmkwTW42bm9qSkQ2?=
 =?utf-8?B?MFM0Zk1BNW9wTnNaY1pkWjY2SlBMUUp2Q1k0dXhIK2lHclhGeWphMUV5WVE3?=
 =?utf-8?B?Q1U5SlJGbnRhakFxNjVqUTdXNXhicFV4ci8rMXdxWnFaSWpvTnFqQzRHQ1Yz?=
 =?utf-8?B?dlIrbXU0VmJxNjZReEVvVWJROUZiVENsd080VkR6R2o1d2g3bkdBdjhqY3NY?=
 =?utf-8?B?MkM1azhtTFFqSW1IRHBDLy9RSU4vZS9JYmJLWjVEMjdxZmljcXJBNTl0bENl?=
 =?utf-8?B?Y1l3SVJ1eWtVQnF2SGNVdUpSdW1hVzdGVTVmbFVML0R2bFR2MXpOeVlWQWNu?=
 =?utf-8?B?YXJhMEtFTlVHa21DSklGdlFibjRJMzZDY3dLTE9iYVk4SkFaTVBXVFFYNkd2?=
 =?utf-8?B?Q2JnVGpqVmt1SkpRUkI1bThxWC9vN0NjL3BBbGtwc0Zjc2t0M3hyQ3VEdmNi?=
 =?utf-8?B?ZlpIWGhzMVZjU2tMaGJDaXRLeDhrUmF2Sml3bCt1ZldjQ1F2dGxLTnRWRmVF?=
 =?utf-8?B?ZG42SS95ZXQ4T1RDNnlTUGd6TzAwT1J6bzAzRk1jNXNvV1hQL0ZZbXlGZTlX?=
 =?utf-8?B?N0pFY2NmcENPNVJ1MGFWZEZTVXdwaDRsQXh6VWp4TzdjWHpGV1VFdW43QzBD?=
 =?utf-8?B?dXZrcmtBNWxOODdySHJUWlRtY2NXeTJwdkw3UWY1QkJwakFSeU1xbFJKM09F?=
 =?utf-8?B?NndYMWhkMHIwMzVURkl5OE5oWnJ0bHFMOWhFUGVsZW9COHYxNlJXUkQ1NW5n?=
 =?utf-8?B?NGhYYWZDdzlVUEVpQ2x3SVBHcVZYSnIrcWkvQ2xoM1hFd2RoQ3ZGUlgyWElY?=
 =?utf-8?B?OUZHRE1mQ2J1TWNlODc4STJGTkZzcDN1ZlZwb3pXWldRVDdMOUtHTHdiVERM?=
 =?utf-8?B?ZFFJNjR5OVpCcUhzbWQ4S3E4enNzNmpkU3pRY0l6LzBYcDRYU3VwSlRXYUd5?=
 =?utf-8?B?ZjViVG9RbHhsQjRqa25HaTFJS2RxaE9kUXhGY3JtbmxEdDlaYVVrVXdUaTc1?=
 =?utf-8?Q?UCGwk3p9Gy7dF3pE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B998E7F5832A924E8E00023CD94B765B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HJJ1NwkGj3btCoUsdK5BwGtxgY7xlEErzs3f3+/eVLbmcb7kIk/dRjChyEQoDje24mdy1DSww6wi0yo76KskEqx6de2bgOapWqB/ToZlLR3WMNTmCr2jMQpyUpYkLB4zL4OJLoABMXxJIUvZ8jk4ZvcZG6ovohrgDsBSGtXHP86HNdEGpxvGJk7VVNH9qbE0wGwieBSg/IWjy5i9glK0ajPu51NPMedr4pxs57Cj+YGQbEzqoOQW/EJJdtRyAcC2jFAa+16XBByZFteHrkenK4oDDuIgfMB5j2FB7S/tZz7nJ0jQwWp1CMX11u2l8Zq2RfhCuUJ7kot/qcB9WokaAQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abe75e2-c69e-491c-0038-08df35b64612
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 12:15:08.5292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fv/dJl84WV0QmLjLV9ahMYujt2o6BMZGaqOFbYoOlTlB+7ehOCg9zq/k1fc1gJbjBfqAh6zO56reXyxZLassdxrOMGUMXT3DIFEQH2yzLJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR02MB11416
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0NyBTYWx0ZWRfX3ObLYaAw6ngP
 iDGpJAXS4VNSQsVFJ3AoDhZaRZIICtzWj7wUD/aqSYrDxeGHmyipKFGdX+BOCOlsDIZDkZRumeV
 gON6J7BCYKvSQ4j5U4VkQjhgo8LdRXw=
X-Proofpoint-ORIG-GUID: pE36Vgjpl2oYDn2DWqUBi_40KZs1gwFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0NyBTYWx0ZWRfX1RJ77EyMtP5E
 7I/0qXzrduARKOTEeodWgoeGgtl6/+Qy6Sk3mnLZzyply8L4ZrxS9y9m3DnYMCclMh1hjhlG9Ow
 Ne+VE2ytAQN5kTas8a/46gcaIp3vS/peBVZmg+KelOMOAik6QUGfZ1sXGSBt5RWLu9gd0Ni/Td9
 Q2LgrIcE6F2TSukLksTLaThQKRg6CKC/51FIcdwYJueGCKui+3IDjz0NnocKXF/MD/DRJ6NzdoY
 pD53MrhCI46KDSvjSXsnyNshuN1LQJWN8Xc5sX8nYPj7+YjAQQTqy117sVImgNfZr5SjvfRi+0o
 EHQZFYdJQoQnYr5MRb9RoeQ65liQUJj/hKjrsYjfwSTIfCDsNyyBbkij76bG4gxIoZtwl+B0KcR
 zRmRRPA6U4WD8M5FVJPs/oFkwWeYmUNsoIyfgXe9SdYBm6E1oaAIkdP6lxzrs4igvxtKWkSXrga
 Z8rg9KooEiN36+NrG5A==
X-Proofpoint-GUID: pE36Vgjpl2oYDn2DWqUBi_40KZs1gwFN
X-Authority-Analysis: v=2.4 cv=FYOiV5+6 c=1 sm=1 tr=0 ts=6ae338ce cx=c_pps
 a=9VIIl2UxNuoJMDRiX/J/iA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22 a=20KFwNOVAAAA:8
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=FUE9xt4JGuWGFeQp5AgA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=khushit.shah@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gT24gMjkgT2N0IDIwMjYsIGF0IDI6NTDigK9QTSwgRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElPTjogRXh0
ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gQXQgdGhlIG1vbWVudCBNUElE
Ul9FTDEgaGFzIG5vIHJlYWwgc3RvcmFnZS4gSW5zdGVhZCBjcHUNCj4gbXBfYWZmaW5pdHkgZmll
bGQgc3RvcmVzIHRoZSBBZmYwLUFmZjIgYml0cyBvbmx5IGFuZCB0aGUNCj4gSUQgcmVnaXN0ZXIg
aXMgcmVjb25zdHJ1Y3RlZCB3aGVuIG5lZWRlZC4gVGhlcmUgaXMgYWxzbw0KPiBhbiBtcC1hZmZp
bml0eSBwcm9wZXJ0eSB1c2VkIGZvciBUQ0cgb25seS4NCj4gDQo+IEtlZXAgdGhlIG1wLWFmZmlu
aXR5IHByb3BlcnR5IGFuZCBpdHMgYXNzb2NpYXRlZCBzdG9yYWdlDQo+IHdoaWxlIG1ha2luZyBz
dXJlIHRoZSBNUElEUl9FTDEgZnVsbCByZWdpc3RlciBpcyBzdG9yZWQNCj4gaW4gY3B1LT5pc2Fy
LmlkcmVnc1tdIGFzIG90aGVyIElEIHJlZ2lzdGVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBLaHVzaGl0
IFNoYWggPGtodXNoaXQuc2hhaEBudXRhbml4LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NClJldmlld2VkLWJ5OiBLaHVzaGl0IFNo
YWggPGtodXNoaXQuc2hhaEBudXRhbml4LmNvbT4NCg0KVGhhbmtzLA0KS2h1c2hpdA0KPiAtLS0N
Cj4gdGFyZ2V0L2FybS9jcHUuaCAgICAgICAgICAgICB8ICA4ICsrKysrKystDQo+IHRhcmdldC9h
cm0vY3B1LXN5c3JlZ3MuaC5pbmMgfCAgMSArDQo+IHRhcmdldC9hcm0vY3B1LmMgICAgICAgICAg
ICAgfCAxNyArKysrKysrKysrKysrKysrKw0KPiB0YXJnZXQvYXJtL2hlbHBlci5jICAgICAgICAg
IHwgMTQgKy0tLS0tLS0tLS0tLS0NCj4gdGFyZ2V0L2FybS9odmYvaHZmLmMgICAgICAgICB8ICAy
ICstDQo+IHRhcmdldC9hcm0va3ZtLmMgICAgICAgICAgICAgfCAgMSArDQo+IHRhcmdldC9hcm0v
d2hweC93aHB4LWFsbC5jICAgfCAgMiArLQ0KPiA3IGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlv
bnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vY3B1
LmggYi90YXJnZXQvYXJtL2NwdS5oDQo+IGluZGV4IGU2YjQwMDAxMjcuLjVjNWY1NTFkYWMgMTAw
NjQ0DQo+IC0tLSBhL3RhcmdldC9hcm0vY3B1LmgNCj4gKysrIGIvdGFyZ2V0L2FybS9jcHUuaA0K
PiBAQCAtMTEzMCw3ICsxMTMwLDEzIEBAIHN0cnVjdCBBcmNoQ1BVIHsNCj4gICAgIHVpbnQzMl90
IHJlc2V0X3NjdGxyOw0KPiAgICAgdWludDY0X3QgcG1jZWlkMDsNCj4gICAgIHVpbnQ2NF90IHBt
Y2VpZDE7DQo+IC0gICAgdWludDY0X3QgbXBfYWZmaW5pdHk7IC8qIE1QIElEIHdpdGhvdXQgZmVh
dHVyZSBiaXRzICovDQo+ICsgICAgLyoNCj4gKyAgICAgKiBNUCBJRCB3aXRob3V0IGZlYXR1cmUg
Yml0cywgaWUuIEFmZjAuLkFmZjMgb25seQ0KPiArICAgICAqIHVzZWQgdG8gc3RvcmUgdGhlIGNv
cnJlc3BvbmRpbmcgcHJvcGVydHkgdmFsdWUgZm9yIFRDRyB2Y3B1cy4NCj4gKyAgICAgKiBUaGUg
TVBJRFJfRUwxIHZhbHVlIChhZmZpbml0eSArIGZlYXR1cmUgYml0cykgaXMgc3RvcmVkIGluIGEN
Cj4gKyAgICAgKiBjb25zaXN0ZW50IG1hbm5lciBpbiBpc2FyLmlkcmVnc1tNUElEUl9FTDFfSURY
XS4NCj4gKyAgICAgKi8NCj4gKyAgICB1aW50NjRfdCBtcF9hZmZpbml0eTsNCj4gICAgIHVpbnQ2
NF90IHJlc2V0X2NiYXI7DQo+ICAgICB1aW50MzJfdCByZXNldF9hdXhjcjsNCj4gICAgIGJvb2wg
cmVzZXRfaGl2ZWNzOw0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9jcHUtc3lzcmVncy5oLmlu
YyBiL3RhcmdldC9hcm0vY3B1LXN5c3JlZ3MuaC5pbmMNCj4gaW5kZXggNzA5ZGM4ZmM5Ny4uZjE0
OGY2ZjU2NSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2FybS9jcHUtc3lzcmVncy5oLmluYw0KPiAr
KysgYi90YXJnZXQvYXJtL2NwdS1zeXNyZWdzLmguaW5jDQo+IEBAIC00Miw2ICs0Miw3IEBAIERF
RihJRF9QRlIwX0VMMSwgMywgMCwgMCwgMSwgMCkNCj4gREVGKElEX1BGUjFfRUwxLCAzLCAwLCAw
LCAxLCAxKQ0KPiBERUYoSURfUEZSMl9FTDEsIDMsIDAsIDAsIDMsIDQpDQo+IERFRihNSURSX0VM
MSwgMywgMCwgMCwgMCwgMCkNCj4gK0RFRihNUElEUl9FTDEsIDMsIDAsIDAsIDAsIDUpDQo+IERF
RihNVkZSMF9FTDEsIDMsIDAsIDAsIDMsIDApDQo+IERFRihNVkZSMV9FTDEsIDMsIDAsIDAsIDMs
IDEpDQo+IERFRihNVkZSMl9FTDEsIDMsIDAsIDAsIDMsIDIpDQo+IGRpZmYgLS1naXQgYS90YXJn
ZXQvYXJtL2NwdS5jIGIvdGFyZ2V0L2FybS9jcHUuYw0KPiBpbmRleCBlMzM3NDYyYTdlLi5hYmE0
NWI2NmY4IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvYXJtL2NwdS5jDQo+ICsrKyBiL3RhcmdldC9h
cm0vY3B1LmMNCj4gQEAgLTIxNzAsNiArMjE3MCwyMyBAQCBzdGF0aWMgdm9pZCBhcm1fY3B1X3Jl
YWxpemVmbihEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBUk1fREVGQVVMVF9DUFVTX1BFUl9D
TFVTVEVSKTsNCj4gICAgIH0NCj4gDQo+ICsgICAgLyogQ29uc2lzdGVudGx5IHVwZGF0ZSBNUElE
Ul9FTDEgaW4gaXNhci5pZHJlZ3NbXSBieSBhZGRpbmcgZmVhdHVyZSBiaXRzICovDQo+ICsgICAg
ew0KPiArICAgICAgICB1aW50NjRfdCBtcGlkciA9IGNwdS0+bXBfYWZmaW5pdHk7DQo+ICsNCj4g
KyAgICAgICAgaWYgKGFybV9mZWF0dXJlKGVudiwgQVJNX0ZFQVRVUkVfVjdNUCkpIHsNCj4gKyAg
ICAgICAgICAgIG1waWRyIHw9ICgxVSA8PCAzMSk7DQo+ICsgICAgICAgICAgICAvKg0KPiArICAg
ICAgICAgICAgICogVW5pcHJvY2Vzc29yIChub24tY29oZXJlbnQpIGNvcmVzIHRoYXQgc3RpbGwg
aW1wbGVtZW50IHRoZSBNUA0KPiArICAgICAgICAgICAgICogZXh0ZW5zaW9ucyBzZXQgVSAoYml0
IDMwKSwgZS5nLiBDb3J0ZXgtUjUuDQo+ICsgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAg
IGlmIChjcHUtPm1wX2lzX3VwKSB7DQo+ICsgICAgICAgICAgICAgICAgbXBpZHIgfD0gKDF1IDw8
IDMwKTsNCj4gKyAgICAgICAgICAgIH0NCj4gKyAgICAgICAgfQ0KPiArICAgICAgICBTRVRfSURS
RUcoJmNwdS0+aXNhciwgTVBJRFIsIG1waWRyKTsNCj4gKyAgICB9DQo+ICsNCj4gICAgIGlmIChj
cHUtPnJlc2V0X2hpdmVjcykgew0KPiAgICAgICAgICAgICBjcHUtPnJlc2V0X3NjdGxyIHw9ICgx
IDw8IDEzKTsNCj4gICAgIH0NCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vaGVscGVyLmMgYi90
YXJnZXQvYXJtL2hlbHBlci5jDQo+IGluZGV4IGFmYWFjMzNmMmEuLmY0MTNiMTVlYjcgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9hcm0vaGVscGVyLmMNCj4gKysrIGIvdGFyZ2V0L2FybS9oZWxwZXIu
Yw0KPiBAQCAtMzE4MCwyMCArMzE4MCw4IEBAIHN0YXRpYyB1aW50NjRfdCBtaWRyX3JlYWQoQ1BV
QVJNU3RhdGUgKmVudiwgY29uc3QgQVJNQ1BSZWdJbmZvICpyaSkNCj4gc3RhdGljIHVpbnQ2NF90
IG1waWRyX3JlYWRfdmFsKENQVUFSTVN0YXRlICplbnYpDQo+IHsNCj4gICAgIEFSTUNQVSAqY3B1
ID0gZW52X2FyY2hjcHUoZW52KTsNCj4gLSAgICB1aW50NjRfdCBtcGlkciA9IGNwdS0+bXBfYWZm
aW5pdHk7DQo+IA0KPiAtICAgIGlmIChhcm1fZmVhdHVyZShlbnYsIEFSTV9GRUFUVVJFX1Y3TVAp
KSB7DQo+IC0gICAgICAgIG1waWRyIHw9ICgxVSA8PCAzMSk7DQo+IC0gICAgICAgIC8qDQo+IC0g
ICAgICAgICAqIENvcmVzIHdoaWNoIGFyZSB1bmlwcm9jZXNzb3IgKG5vbi1jb2hlcmVudCkNCj4g
LSAgICAgICAgICogYnV0IHN0aWxsIGltcGxlbWVudCB0aGUgTVAgZXh0ZW5zaW9ucyBzZXQNCj4g
LSAgICAgICAgICogYml0IDMwLiAoRm9yIGluc3RhbmNlLCBDb3J0ZXgtUjUpLg0KPiAtICAgICAg
ICAgKi8NCj4gLSAgICAgICAgaWYgKGNwdS0+bXBfaXNfdXApIHsNCj4gLSAgICAgICAgICAgIG1w
aWRyIHw9ICgxdSA8PCAzMCk7DQo+IC0gICAgICAgIH0NCj4gLSAgICB9DQo+IC0gICAgcmV0dXJu
IG1waWRyOw0KPiArICAgIHJldHVybiBHRVRfSURSRUcoJmNwdS0+aXNhciwgTVBJRFIpOw0KPiB9
DQo+IA0KPiBzdGF0aWMgdWludDY0X3QgbXBpZHJfcmVhZChDUFVBUk1TdGF0ZSAqZW52LCBjb25z
dCBBUk1DUFJlZ0luZm8gKnJpKQ0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9odmYvaHZmLmMg
Yi90YXJnZXQvYXJtL2h2Zi9odmYuYw0KPiBpbmRleCBmOWYzZDIyMDE0Li40Yjk0N2U5YmE1IDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvYXJtL2h2Zi9odmYuYw0KPiArKysgYi90YXJnZXQvYXJtL2h2
Zi9odmYuYw0KPiBAQCAtMTQ3Niw3ICsxNDc2LDcgQEAgaW50IGh2Zl9hcmNoX2luaXRfdmNwdShD
UFVTdGF0ZSAqY3B1KQ0KPiAgICAgYXNzZXJ0X2h2Zl9vayhyZXQpOw0KPiANCj4gICAgIHJldCA9
IGh2X3ZjcHVfc2V0X3N5c19yZWcoY3B1LT5hY2NlbC0+ZmQsIEhWX1NZU19SRUdfTVBJRFJfRUwx
LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXJtX2NwdS0+bXBfYWZmaW5pdHkp
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0VUX0lEUkVHKCZhcm1fY3B1LT5p
c2FyLCBNUElEUikpOw0KPiAgICAgYXNzZXJ0X2h2Zl9vayhyZXQpOw0KPiANCj4gICAgIHBmciA9
IEdFVF9JRFJFRygmYXJtX2NwdS0+aXNhciwgSURfQUE2NFBGUjApOw0KPiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2FybS9rdm0uYyBiL3RhcmdldC9hcm0va3ZtLmMNCj4gaW5kZXggZGUwOWQ2M2QyZS4u
NzI0YmMwOGVkZiAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2FybS9rdm0uYw0KPiArKysgYi90YXJn
ZXQvYXJtL2t2bS5jDQo+IEBAIC0yMTAzLDYgKzIxMDMsNyBAQCBpbnQga3ZtX2FyY2hfaW5pdF92
Y3B1KENQVVN0YXRlICpjcykNCj4gICAgIGlmIChyZXQpIHsNCj4gICAgICAgICByZXR1cm4gcmV0
Ow0KPiAgICAgfQ0KPiArICAgIFNFVF9JRFJFRygmY3B1LT5pc2FyLCBNUElEUiwgbXBpZHIpOw0K
PiAgICAgY3B1LT5tcF9hZmZpbml0eSA9IG1waWRyICYgQVJNNjRfQUZGSU5JVFlfTUFTSzsNCj4g
DQo+ICAgICByZXR1cm4ga3ZtX2FybV9pbml0X2NwcmVnX2xpc3QoY3B1KTsNCj4gZGlmZiAtLWdp
dCBhL3RhcmdldC9hcm0vd2hweC93aHB4LWFsbC5jIGIvdGFyZ2V0L2FybS93aHB4L3docHgtYWxs
LmMNCj4gaW5kZXggMTgwMDlkNmM4ZC4uMDI0ZDE4ZGYwNCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0
L2FybS93aHB4L3docHgtYWxsLmMNCj4gKysrIGIvdGFyZ2V0L2FybS93aHB4L3docHgtYWxsLmMN
Cj4gQEAgLTg0Miw3ICs4NDIsNyBAQCBpbnQgd2hweF9pbml0X3ZjcHUoQ1BVU3RhdGUgKmNwdSkN
Cj4gDQo+ICAgICBjbGVhbl93aHZfcmVnaXN0ZXJfdmFsdWUoJnZhbCk7DQo+IA0KPiAtICAgIHZh
bC5SZWc2NCA9IGRlcG9zaXQ2NChhcm1fY3B1LT5tcF9hZmZpbml0eSwgMzEsIDEsIDEgLyogUkVT
MSAqLyk7DQo+ICsgICAgdmFsLlJlZzY0ID0gR0VUX0lEUkVHKCZhcm1fY3B1LT5pc2FyLCBNUElE
Uik7DQo+ICAgICB3aHB4X3NldF9yZWcoY3B1LCBXSHZBcm02NFJlZ2lzdGVyTXBpZHJFbDEsIHZh
bCk7DQo+IA0KPiAgICAgY2xhbXBfaWRfYWE2NG1tZnIwX3BhcmFuZ2VfdG9faXBhX3NpemUoJmFy
bV9jcHUtPmlzYXIpOw0KPiAtLSANCj4gMi41My4wDQo+IA0KDQo=

