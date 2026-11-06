Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A7606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=rhK1wBoU;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=dvE/jVSq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPCgc-0005JH-Qp; Fri, 06 Nov 2026 00:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7630b069b=Alistair.Francis@wdc.com>)
 id 1xPCgH-00057e-EP; Fri, 06 Nov 2026 00:40:07 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7630b069b=Alistair.Francis@wdc.com>)
 id 1xPCgF-0004mi-0M; Fri, 06 Nov 2026 00:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793943604; x=1825479604;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=N6prIaS3X+bRr2h/DdLc+fIs7g4ty3reQIb0mFoamz4=;
 b=rhK1wBoUVkskUstY5nKivNdLbZcp7TuWpwoPaMtnBHGKhLY7TWTWIRVs
 f/qyu38X4WtGjlCN06Z3QbBf0zoGAoSTBGcexnk7TZdEbxxVIwWoLUCh9
 eXZQlNp6uVrtOJVqDHFceWB4DZ6WgCA5IxTZzdhBf8ZLQHjn7PzeZ5Y4B
 JGpfTq5FfqNbq135D3TwvO64s+RUA4u04rIhNl+/EeiRw4fCL7iEpomvk
 NTlw8Wy17FU/JZsWKEFYfW/79Glx46ObMCNa7Ery45VfswU5S+Osm7X2j
 BR/eeCEOhTZLxZWQfQ7+Z7O2iSieBuD2iqdzMD1JXYmlVysCACzdz0YmZ Q==;
X-CSE-ConnectionGUID: vxuqQKyYQ5yuKCQ/NeNTdw==
X-CSE-MsgGUID: nAJiwC0nSGmAUXM5Yt87nw==
X-IronPort-AV: E=Sophos;i="6.27,197,1786982400"; d="scan'208";a="155744428"
Received: from mail-northcentralusazon11013038.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.38])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Nov 2026 13:39:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADXtclEfjgrhkE3/8uNWrBCTqnfSfCe2OkiZa/4ueAaw0tsBkAeypbARtqGKc2wYDWnaYwNYF2o91BwWgvVH5DAiRj+2nKEhEtNzYGptvoaJqZBuLRaGa41BcFPIhTmh7lTqaRjuHGADfP0MZth1sjqeD5dbKb9nZposme2kq8OOT+U4E5vcI2C47l6xwKIVM4nqr4C2KC/FfbKPCpJoPTdoAvpPY/a6tePtWjFK38nV3ATpfl9FXnsTUddg4037lrN5hvaRmPlZ4nxEOAhHdTM2UJ9enCGQNKeYhHB5s60cWIfroAe1+crCBaa81Di99n2ltImf5EeasFYRFBlBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6prIaS3X+bRr2h/DdLc+fIs7g4ty3reQIb0mFoamz4=;
 b=cxehDZXc91t8NQf7qRXDru4HvFgrkyeswVSUz1xqHRgffN31U9njLGK8vtcmRiEoPwc+YUgMZ9norLf6d1RWkNNJCBYaKEouYbm726F3NzD+StIk8sN71drq8F1xkW95qmHdyzWuRJl192JqEaYoOGhuvc1RbM8SNLS+mOYDuiWoPRDP84pfwndn/h9u9eXnu0kERip2Uqj3NrzLg0QPpKVDT1r5SoxPSbhiiwlUE4rFNVnodF1sxPB1+U3ML0hKDeAjYJHimWRmVyT4R0vgAlidfLzTF5t4EXQW4FqOdvLH0S3AvHR0eS6ZsS0M2thBzuv5+wi0LruAS6OFyhRU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6prIaS3X+bRr2h/DdLc+fIs7g4ty3reQIb0mFoamz4=;
 b=dvE/jVSqTp2YWl3eTqmJI9VtRrAXk4bby29OiwozoffogpT2VP2HkcBWmJUDF9RgKxnWZk+tMzvUNIF6cT2M664/kZZCKazZgAUvxH/oir0VxJyIsrgnrfIOMeEXAU0qOLrO/GIqC5mkiFdJmmWmbfncWjQ4u15k2f4ZgS+WYbg=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH6PR04MB993721.namprd04.prod.outlook.com (2603:10b6:610:380::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:39:54 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 05:39:54 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "jim.macarthur@linaro.org" <jim.macarthur@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jag.raman@oracle.com" <jag.raman@oracle.com>, "mst@redhat.com"
 <mst@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "tangtao1634@phytium.com.cn"
 <tangtao1634@phytium.com.cn>, "den@openvz.org" <den@openvz.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA
 driver
Thread-Topic: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9
 SATA driver
Thread-Index: AQHdbPUPMmH5Q8Mt10aLnsh7ptlMRrcfILeAgAFn3AA=
Date: Fri, 6 Nov 2026 05:39:53 +0000
Message-ID: <8b590f1f1d3e6ff6c650d25078fe1f1bc9dd5211.camel@wdc.com>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
 <3c7816f3-b8ad-4ab2-8057-9cbac6805fba@oss.qualcomm.com>
In-Reply-To: <3c7816f3-b8ad-4ab2-8057-9cbac6805fba@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH6PR04MB993721:EE_
x-ms-office365-filtering-correlation-id: 67fcb652-76d9-4975-ffcd-08df3bc86267
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|19092799006|38070700021|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: FBEKG8xNiJ0hRoceH4RTkWMIfdtep2qeMzmD1lEU3qit0Mn9GzqKQEwGsFr2PlzXiqnyn9KqWohq1J+c2lSZR5ulL/3GW/gMIMVrlDIaPNXPg3wj0rLzhpi4HkL4oiC7sMlDjAd8QodtF0//YqUtlKyF1UDjrjTXzBuHIM0VkD9nLVplUVdX5jD6EaqoQA1OqH02zZ35FYyfztQmIv43N9fJIQZVEcBmIQeJA1VLNPTitO37kCDqCsiQdbCDQ6Me27Yr+fFoSBuTblNBHuf1VaoxfIGT1AuZdYeXZsr+XsEJhkKqOGuufpHS8+THA7+vOQnULoBvqiwKnQvdNl9/DDk1T103ad6vk/Klfi44qEZfwC2xbYzSY/QkBNKOCDFlLZG1+euXBkQKLBRQkBWtkyucQCsWt9rhE5tFcShby5ApZeTV+Fxb44d92y8vfhIil0QCiGSbIsYjC6z0e0Bo2T07joAahHWVs0/7zzv8UXPfq1TzHyBX8k8IBw+YiSJhrXPsIYh7Jasu85HudLyfAMbqoN9uZazE59dyIpXSYpapNNU+/wH9QdSeLvQP/ufHM5BNGZm+PydtHMPWsgk3zDIab+t47ARH7BiEN6qm+9ybXOfCKj67onG5Dl2awN0K+jYMyM0RRCWS0HzoCcZQLojHr8sNgHg4rzD/vocnhL1kXJm+zPv4raK7A1sI5Nkq3lARUJYGifqJ4JiBgkcVEacq9VZ+ab4KzpXPeA05UWU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(19092799006)(38070700021)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWhWekpjWVR5bjVuNHpLckVqOTkwZzhpaDh1eUJpOWgxczhRbGhsUEVJdTJo?=
 =?utf-8?B?NUZkdlkxdnByQzlWUkFrMDhqeFlWdkZOVnhCREZzaFNQN3RmMnBrTUpXZ0Zj?=
 =?utf-8?B?cVYxOHp6amNTZ0VjZmJoWnQ5Q0ZYa2N1eXhOSktwdU9WMXROcGlUZ0VHNlM3?=
 =?utf-8?B?TURtNXBKUFNqblk0UjlFeE1jYlZoeENITFkzRk1RcVB3ZGZGT2ZxaGRRa0Zk?=
 =?utf-8?B?eDY0SmhBcUNOMDlvVDRzeVVXMzZDMFVwL1ZzQWZXQk12MXpFRytNeklnZ2lw?=
 =?utf-8?B?M3h1cXZFL3NtOW5vWUIzSGV0RVoxNWVESVN1WDVLRTB6T2VEa2pjOWQwREJG?=
 =?utf-8?B?MlNOWFduWjVWampPR2RoZ2FqS3FJNWl4MnhBeUdWcGZlUGdmaVc5ejRaWVRj?=
 =?utf-8?B?TTVUMENHMExUSFFCdlppMm91K2JWV0QrY1REQUJqdHJ4U1FoYnNpTDBzRWpk?=
 =?utf-8?B?cURtRWR1ZFFpM1V0NmgrYjFFUGllMjAxaDRiemwybVQrK3NMa2VROTJHSHdX?=
 =?utf-8?B?amxqL1lidUs3Q2dvN1FpcWZWc2F0MzFwRkNpN3hDWjNBcVhVczF6YnByV3Mv?=
 =?utf-8?B?OUdoc1lHSUZwcmMrTDRhd29hQXhRQUVlODFlRnNQTmRhOTk0TnVvcUZtMmJC?=
 =?utf-8?B?K0pLblVCb2RtN0wzdVdreDcrTVBVaSsxNjk0MW9BUlFXb2hBWUkyWllOSEh0?=
 =?utf-8?B?OVJHZjhZQWdZWXRvNy9tUUN4d1A0aFd4L09GbExiRUdrQUhqUTZyK25qZTdj?=
 =?utf-8?B?NUdmbHVZOWRWOER5aHdCTTVCTXkvSDNZckQ5ckVWaHFsR3Q5OUdUM241WkZu?=
 =?utf-8?B?Z1Y5RmpLWjlXWEEwQ3JhejhxQTlrVG9XMEpkSWhFUkR5YmZPbmRrdjRzYkt0?=
 =?utf-8?B?a3R4c0w2V250WkhBL0xIenoxczVXVFBMdm9kdTJKZFo5eS8wd09ORWtwU1VJ?=
 =?utf-8?B?ZzBwVEdNSjU2U3BKdnBZeHZCYVZYU3pWSzFjTnFyTEt1Tjk0VDR5ZkhiYjZk?=
 =?utf-8?B?bE5oNlExUEQ3cHpZVjBPVGh0bWJNcjB6TC92QkpGYU1xSkpCQVdDNWFIWEl4?=
 =?utf-8?B?UWRQVXZBWlVKaHp3NnBtS0FZQ1dOMmFacXc4dWlndzVFdDYveGpyZDI0VFg2?=
 =?utf-8?B?MUNMa3hHYWUyZjFiQmtBeTVwdjIzWmsvdjljRVBrNlNYSjh6UU1yNDBuNEs5?=
 =?utf-8?B?N094TzF2SEh3ZkZ2OHRiNTRyRjNYUmFuTGpzNzZ4S2xWZGF6eUJGUlVVS2ZB?=
 =?utf-8?B?V3VPd0FyNU5lTTh0ditjSWtvbzV0aWx2dHd5M05nWkMvUXl1YjRQMk9uRS8z?=
 =?utf-8?B?bzdzNkoyR2tBcXFsWU5IY25KTWxQcVA3SjJidTRhNjhvczN2UExvbUZVK2Mz?=
 =?utf-8?B?RFBQcUpOMmFhd0l0YWZzSVpZTCtPNVVWMmNhZmNHa0JtRjl3RFc2MTFLSGhW?=
 =?utf-8?B?TkxmY1c5cFkwandNclZNYUtXZElBQks4NEx5Qk1SUkR1dG9COVFDM1RhbzM1?=
 =?utf-8?B?MVlrUE9lUkUwOERKT21zL2hReVpUTWpZUDZ4d2JVV09QaEVlU3lQM1FqbXo4?=
 =?utf-8?B?Q3pmS3NPb2pmeFJOdHgvM0RTK1Mxc01xQXNzK0R4V1UweWZXY1c1MVNqd2cw?=
 =?utf-8?B?VDh0QkhNdGR3dVZnZUdzQUFzcDkrNTNqRGhkYU1hZFpOZzFyUElETzNYWnNl?=
 =?utf-8?B?RGZ2MWlZZ1N1UmZzMjgzUC9vTG02TGlCNk9acDFEclkxMmYvNHpIVmdVYXdH?=
 =?utf-8?B?QU11Ny9CRlljWHhuSkRuRjdKWnZ2TDJ0S08wWnJwMXVTQkJERWFOWTFWTHgv?=
 =?utf-8?B?TjFqTnY5VC9zbjNYRFd0c0ZOMjdQbWVqOEYvbVd3KytGamY4NTV2Wkdpckkv?=
 =?utf-8?B?cjIrZFJNQ2c5N0svTVY1d3BpczNFWDY5eThac2NkNTd2elVOQ0FjbEdBOXZV?=
 =?utf-8?B?eWdtSFRQWDkwSkxhbzFuM1QzOEVxQlhIUXQ1ZDVzVHpsZUpwaFNsQU0yN2wz?=
 =?utf-8?B?RXByOHQ4QVZEb0JMTTdJVDBiTG1GZnRyMFZHNDBvcEdxeW9BWlV4dHI5Z1hm?=
 =?utf-8?B?azRDTHBUOXFJcTEyYm9UL0R4ZDd0V2ZzdGd1QU5lN0laWkNPR0dYUmN6bnpU?=
 =?utf-8?B?RmNUUkxnejhyVjkrWWZybXE2VHM3MmdJck9ZdlczR2tkaEpuZ1VsU1VYMUIz?=
 =?utf-8?B?ejhndlRveCtmR0ZOdks5WWcrbmFxbVVCMEEyQkhYQnh5b2dOU2dSUmFCSW1o?=
 =?utf-8?B?YkVudzJkU20rV2t1MEFSRzY2Q2pPWENybE9wRjlQcXZGeXJVVDVqR1lPSHpJ?=
 =?utf-8?B?cktZWSs3cHpRbGhEenFpZzVPZEk1anhDZ05LNjdmTnJVa2ZQaFZlM2RxMWpB?=
 =?utf-8?Q?ql/OQK1NLET87MVsBNloPTj5iKVCgG1x2aMgU8RofRjIF?=
x-ms-exchange-antispam-messagedata-1: 97DMCEGFfg8YBk1hAfUszXxBAVe75fvmPpI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F4878FC0A44284898F9B06FC922436A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b0FY4pmc4AcmzCF+CFZIAnD8aDaT/Gtr6kmiHSxpFLGflqmuUbd/CDSRpqU+uM4k9oYdGNfklpuY4py/vkG2Kp/xwZTTriyRmT1cCJAE4DcfCW8TjA+JC/ua2MdV0375VJ46X7zhk5ShOFokHXZxxu9/82fIotJYxzQuRqehFGxEKvq0sOtceAIdwi/yRzz6ytk4UTvRJl0K7i4BvJ3DQdvjGieti0PNC/fF9F3qI7hn0Knr8BRL+Zw8FDG+yRpY/AKfPLD0xAO0gbe0ZB8rGz5QUoUa9wB7Ipz6lx9BGd2QmcB5SZGMmxa8tWpxTzBIV2D71MEYJwJTVLbh1gNhAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VFp3bHSRvNklx/ru3au7M1okqWx7NlHecGMvvByMFEU9Skrn2H7e3cW+h8DRl0E2plJwCZTgjy042sjIfxinmCoM3lftXDOW9+d/i5H9YkUqqmBOejb+mT3y+KEPEKX5RXi0/HA59AHfLEXdi79NgSjZODiCt8/zPYmBeLNfOrYqv/sxkerP+pA9D5Ncc/zfLZVnR2nW0Q/BmIWIR794irgJk+I9ITT5ctP7DOyWvT7+3Ncom7Vz7frxMa0vEYBrENVkcD1QS1BKOqsTodF6H807/2htnsaSxoE/NWk9oH9esz9tOsJbhgCWbUEEYBqf9boRDgccoB6dxTy2urq+WzEdFtdNmqzA45UVvUNltfO+2bi2pWGQgCPbVTT4fVtrJjkuril+DQEhc5nBRsrQot3ZNYLTY8N9dEBXccXBfiC7oHjeBTd8ZWZ/cl2l5ZhcJchwfimi522UspY7a9is8vUmwY4OQEj4xxciNoPnuMGzD00jr9X9a4UOd8/2nvt2O3buVaXbQH5125v5FV/yDc7egQKWrjYhYVtQKDVKexlQvUAGRnuHwq6U+JycAUd4stjwdWcehvZHs06EkaHu6FGFTznUcTzdUQxRbAkgK56i/eaVgUhVYJD/8cEYwZn1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fcb652-76d9-4975-ffcd-08df3bc86267
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 05:39:54.0176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXx5LkEhCrI3d1J3bvPysSkjQm3HKJyBfbNe5LJktl/hrfj3Q/Bha9vHdfOz6jp6c9t5MFCgJtag65+Gj6FD3mfDfMurmEtZifeebymNdRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH6PR04MB993721
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=7630b069b=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTA1IGF0IDAwOjExIC0wODAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBPbiAxMS80LzIwMjYgMTE6MTIgUE0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3Rl
Og0KPiA+IE9uIDQvMTEvMjYgMTc6MzQsIEppbSBNYWNBcnRodXIgd3JvdGU6DQo+ID4gPiBGcm9t
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+ID4gDQo+
ID4gUmF0aW9uYWxlPw0KPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmlt
IE1hY0FydGh1ciA8amltLm1hY2FydGh1ckBsaW5hcm8ub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiDC
oCBody9pZGUvaWNoLmMgfCA4Mg0KPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICsrKysrKysrLS0NCj4gPiA+IMKgIDEgZmlsZSBj
aGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvaHcvaWRlL2ljaC5jIGIvaHcvaWRlL2ljaC5jDQo+ID4gPiBpbmRleCBiMDA5
ODdmMDhkLi41OGUyZDNiOTk4IDEwMDY0NA0KPiA+ID4gLS0tIGEvaHcvaWRlL2ljaC5jDQo+ID4g
PiArKysgYi9ody9pZGUvaWNoLmMNCj4gPiA+IEBAIC03MCw2ICs3MCw3IEBADQo+ID4gPiDCoCAj
aW5jbHVkZSAiaHcvaWRlL3BjaS5oIg0KPiA+ID4gwqAgI2luY2x1ZGUgImh3L2lkZS9haGNpLXBj
aS5oIg0KPiA+ID4gwqAgI2luY2x1ZGUgImFoY2ktaW50ZXJuYWwuaCINCj4gPiA+ICsjaW5jbHVk
ZSAic3lzdGVtL3NwZG0tc29ja2V0LmgiDQo+ID4gPiDCoCDCoCAjZGVmaW5lIElDSDlfTVNJX0NB
UF9PRkZTRVTCoMKgwqDCoCAweDgwDQo+ID4gPiDCoCAjZGVmaW5lIElDSDlfU0FUQV9DQVBfT0ZG
U0VUwqDCoMKgIDB4QTgNCj4gPiA+IEBAIC05MCw2ICs5MSwxMCBAQCBzdGF0aWMgY29uc3QgVk1T
dGF0ZURlc2NyaXB0aW9uDQo+ID4gPiB2bXN0YXRlX2ljaDlfYWhjaSA9IHsNCj4gPiA+IMKgwqDC
oMKgwqAgfSwNCj4gPiA+IMKgIH07DQo+ID4gPiDCoCArc3RhdGljIGNvbnN0IFByb3BlcnR5IGlj
aF9wcm9wc1tdID0gew0KPiA+ID4gK8KgwqDCoCBERUZJTkVfUFJPUF9VSU5UMTYoInNwZG1fcG9y
dCIsIFBDSURldmljZSwgc3BkbV9wb3J0LCAwKSwNCj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4g
wqAgc3RhdGljIHZvaWQgcGNpX2ljaDlfYWhjaV91cGRhdGVfaXJxKHZvaWQgKm9wYXF1ZSwgaW50
IGlycV9udW0sDQo+ID4gPiBpbnQNCj4gPiA+IGxldmVsKQ0KPiA+ID4gwqAgew0KPiA+ID4gwqDC
oMKgwqDCoCBQQ0lEZXZpY2UgKnBjaV9kZXYgPSBvcGFxdWU7DQo+ID4gPiBAQCAtMTIwLDEzICsx
MjUsMzkgQEAgc3RhdGljIHZvaWQgcGNpX2ljaDlfYWhjaV9pbml0KE9iamVjdCAqb2JqKQ0KPiA+
ID4gwqDCoMKgwqDCoCBkLT5haGNpLmlycSA9ICZkLT5pcnE7DQo+ID4gPiDCoCB9DQo+ID4gPiDC
oCArLyogU2VuZHMgYW4gU1BETSBtZXNzYWdlIGFuZCByZWNlaXZlcyB0aGUgcmVzcG9uc2UgKi8N
Cj4gPiA+ICtzdGF0aWMgYm9vbCBwY2llX2RvZV9zcGRtX3JzcChET0VDYXAgKmRvZV9jYXApDQo+
ID4gPiArew0KPiA+ID4gK8KgwqDCoCB2b2lkICpyZXEgPSBwY2llX2RvZV9nZXRfd3JpdGVfbWJv
eF9wdHIoZG9lX2NhcCk7DQo+ID4gPiArwqDCoMKgIHVpbnQzMl90IHJlcV9sZW4gPSBwY2llX2Rv
ZV9nZXRfb2JqX2xlbihyZXEpICogNDsNCj4gPiA+ICvCoMKgwqAgdm9pZCAqcnNwID0gZG9lX2Nh
cC0+cmVhZF9tYm94Ow0KPiA+ID4gK8KgwqDCoCB1aW50MzJfdCByc3BfbGVuID0gU1BETV9TT0NL
RVRfTUFYX01FU1NBR0VfQlVGRkVSX1NJWkU7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgIHVpbnQz
Ml90IHJlY3ZkID0gc3BkbV9zb2NrZXRfcnNwKGRvZV9jYXAtPnNwZG1fc29ja2V0LA0KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFNQRE1fVFJBTlNQT1JUX1RZUEVfRE9FLA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcSwgcmVxX2xlbiwgcnNwLCByc3Bf
bGVuKTsNCj4gPiA+ICvCoMKgwqAgZG9lX2NhcC0+cmVhZF9tYm94X2xlbiArPSBESVZfUk9VTkRf
VVAocmVjdmQsIDQpOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoCByZXR1cm4gcmVjdmQgIT0gMDsN
Cj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArLyogU1BETSBwcm90b2NvbHM6IHBsYWluIGFuZCBz
ZWN1cmVkIFNQRE0gbWVzc2FnZXMgKi8NCj4gPiA+ICtzdGF0aWMgRE9FUHJvdG9jb2wgZG9lX3Nw
ZG1fcHJvdFtdID0gew0KPiA+ID4gK8KgwqDCoCB7IFBDSV9WRU5ET1JfSURfUENJX1NJRywgUENJ
X1NJR19ET0VfQ01BLCBwY2llX2RvZV9zcGRtX3JzcA0KPiA+ID4gfSwNCj4gPiA+ICvCoMKgwqAg
eyBQQ0lfVkVORE9SX0lEX1BDSV9TSUcsIFBDSV9TSUdfRE9FX1NFQ1VSRURfQ01BLA0KPiA+ID4g
cGNpZV9kb2Vfc3BkbV9yc3AgfSwNCj4gPiA+ICvCoMKgwqAgeyB9DQo+ID4gPiArfTsNCj4gPiA+
ICsNCj4gPiA+IMKgIHN0YXRpYyB2b2lkIHBjaV9pY2g5X2FoY2lfcmVhbGl6ZShQQ0lEZXZpY2Ug
KmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+ID4gwqAgew0KPiA+ID4gwqDCoMKgwqDCoCBBSENJUENJ
U3RhdGUgKmQ7DQo+ID4gPiDCoMKgwqDCoMKgIGludCBzYXRhX2NhcF9vZmZzZXQ7DQo+ID4gPiDC
oMKgwqDCoMKgIHVpbnQ4X3QgKnNhdGFfY2FwOw0KPiA+ID4gLcKgwqDCoCBkID0gSUNIOV9BSENJ
KGRldik7DQo+ID4gPiDCoMKgwqDCoMKgIGludCByZXQ7DQo+ID4gPiArwqDCoMKgIHVpbnQxNl90
IGNhcF9vZmZzZXQ7IC8qIE5leHQgb2Zmc2V0IGZvciBleHRlbmRlZA0KPiA+ID4gY2FwYWJpbGl0
aWVzICovDQo+ID4gPiArDQo+ID4gPiArwqDCoMKgIGNhcF9vZmZzZXQgPSBQQ0lfQ09ORklHX1NQ
QUNFX1NJWkU7DQo+ID4gPiArwqDCoMKgIGQgPSBJQ0g5X0FIQ0koZGV2KTsNCj4gPiA+IMKgIMKg
wqDCoMKgwqAgZC0+YWhjaS5wb3J0cyA9IDY7DQo+ID4gPiDCoMKgwqDCoMKgIGFoY2lfcmVhbGl6
ZSgmZC0+YWhjaSwgREVWSUNFKGRldiksDQo+ID4gPiBwY2lfZ2V0X2FkZHJlc3Nfc3BhY2UoZGV2
KSk7DQo+ID4gPiBAQCAtMTQ1LDYgKzE3Niw3IEBAIHN0YXRpYyB2b2lkIHBjaV9pY2g5X2FoY2lf
cmVhbGl6ZShQQ0lEZXZpY2UNCj4gPiA+ICpkZXYsDQo+ID4gPiBFcnJvciAqKmVycnApDQo+ID4g
PiDCoMKgwqDCoMKgIHBjaV9yZWdpc3Rlcl9iYXIoZGV2LCBJQ0g5X01FTV9CQVIsDQo+ID4gPiBQ
Q0lfQkFTRV9BRERSRVNTX1NQQUNFX01FTU9SWSwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZkLT5haGNpLm1lbSk7DQo+ID4gPiDCoCArwqDCoMKg
IC8qIExlZ2FjeSBjYXBhYmlsaXR5IGZvciBJQ0g5X1NBVEFfQ0FQICovDQo+ID4gPiDCoMKgwqDC
oMKgIHNhdGFfY2FwX29mZnNldCA9IHBjaV9hZGRfY2FwYWJpbGl0eShkZXYsIFBDSV9DQVBfSURf
U0FUQSwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElDSDlfU0FUQV9DQVBf
T0ZGU0VULA0KPiA+ID4gU0FUQV9DQVBfU0laRSwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVycnApOw0KPiA+ID4gQEAgLTE2NSw2ICsxOTcsMjkgQEAgc3RhdGljIHZvaWQg
cGNpX2ljaDlfYWhjaV9yZWFsaXplKFBDSURldmljZQ0KPiA+ID4gKmRldiwNCj4gPiA+IEVycm9y
ICoqZXJycCkNCj4gPiA+IMKgwqDCoMKgwqAgLyogQW55IGVycm9yIG90aGVyIHRoYW4gLUVOT1RT
VVAoYm9hcmQncyBNU0kgc3VwcG9ydCBpcw0KPiA+ID4gYnJva2VuKQ0KPiA+ID4gwqDCoMKgwqDC
oMKgICogaXMgYSBwcm9ncmFtbWluZyBlcnJvci7CoCBGYWxsIGJhY2sgdG8gSU5UeCBzaWxlbnRs
eSBvbiAtDQo+ID4gPiBFTk9UU1VQICovDQo+ID4gPiDCoMKgwqDCoMKgIGFzc2VydCghcmV0IHx8
IHJldCA9PSAtRU5PVFNVUCk7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgIC8qDQo+ID4gPiArwqDC
oMKgwqAgKiBJbml0aWFsaXNlIGEgY2FwYWJpbGl0eSBpbiB0aGUgbGVnYWN5IHNwYWNlIGFmdGVy
IHRoZQ0KPiA+ID4gSUNIOV9TQVRBX0NBUC4NCj4gPiA+ICvCoMKgwqDCoCAqLw0KPiA+ID4gK8Kg
wqDCoCBwY2llX2VuZHBvaW50X2NhcF9pbml0KGRldiwgSUNIOV9TQVRBX0NBUF9PRkZTRVQgKw0K
PiA+ID4gU0FUQV9DQVBfU0laRSk7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgIGlmIChkZXYtPnNw
ZG1fcG9ydCkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgIC8qIFNldCB1cCB0aGUgRE9FIGV4dGVu
ZGVkIGNhcGFiaWxpdHksIG1haWxib3hlcyBldGMgKi8NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBw
Y2llX2RvZV9pbml0KGRldiwgJmRldi0+ZG9lX3NwZG0sIGNhcF9vZmZzZXQsDQo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRvZV9zcGRtX3Byb3QsIHRy
dWUsIDApOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGNhcF9vZmZzZXQgKz0gUENJX0RPRV9TSVpF
T0Y7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgZGV2LT5kb2Vfc3BkbS5zcGRtX3Nv
Y2tldCA9IHNwZG1fc29ja2V0X2Nvbm5lY3QoZGV2LQ0KPiA+ID4gPnNwZG1fcG9ydCwNCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgDQo+ID4gPiBlcnJwKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBhc3NlcnQoZGV2LT5k
b2Vfc3BkbS5zcGRtX3NvY2tldCA+IDApOw0KPiA+ID4gK8KgwqDCoCB9DQo+ID4gPiArDQo+ID4g
PiArwqDCoMKgIC8qIElERSBleHRlbmRlZCBjYXBhYmlsaXR5ICovDQo+ID4gPiArwqDCoMKgIHBj
aWVfaWRlX2luaXQoZGV2LCBjYXBfb2Zmc2V0KTsNCj4gPiA+ICvCoMKgwqAgY2FwX29mZnNldCAr
PSBQQ0lfSURFX1NJWkVPRjsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqAgLyogVEVFIGNhcGFiaWxp
dHkgYml0IGluIGxlZ2FjeSBzcGFjZSovDQo+ID4gPiArwqDCoMKgIHBjaWVfY2FwX3RlZV9pbml0
KGRldik7DQo+ID4gDQo+ID4gV2hpY2ggc2VjdGlvbiBvZiB0aGUgSUNIOSBzcGVjIGRlc2NyaWJl
cyB0aGF0PyBBRkFJQ1QgSUNIOSBwcmVkYXRlcw0KPiA+IERPRSAvIElERS4gSXMgdGhlcmUgc29t
ZSBhbWVuZG1lbnQ/IE90aGVyd2lzZSB0aGlzIG1pZ2h0IG5vdCBiZSB0aGUNCj4gPiBjb3JyZWN0
IHBsYWNlIHRvIGFkZCB0aGF0IGNhcGFiaWxpdHkuIEVpdGhlciB1c2UgYSBGcmFua2Vuc3RlaW4N
Cj4gPiBJQ0g5DQo+ID4gd2l0aCBhIGRpc3RpbmN0IG1vZGVsIG5hbWUsIG9yIGFkZCBhdCB0aGUg
U0FUQSBsYXllciwgcG9zc2libHkgbGlrZQ0KPiA+IGEgY2xhc3MgaW50ZXJmYWNlICh3ZSBvbmx5
IG5lZWQgdGhlIFNBVEFfQ0FQX09GRlNFVCBJSVVDKS4NCj4gPiANCj4gDQo+IEl0J3MgYW4gYWQg
aG9jIGFkZGl0aW9uLCByZXByb2R1Y2luZyB3aGF0IEFybSBoYXMgYmVlbiBkb2luZyBvbiBmdnAN
Cj4gZm9yDQoNCkNhbiB5b3Ugc2hhcmUgYW55IGRldGFpbHMgb24gaG93IHlvdSBhcmUgdGVzdGlu
ZyB0aGlzPw0KDQo+IGRldmljZSBhc3NpZ25tZW50LiBJdCBkb2VzIG5vdCByZWFsbHkgbW9kZWwg
YSByZWFsIGRldmljZSwgYW5kIG52bWUNCj4gd2FzDQo+IChpcz8pIG5vdCBzdXBwb3J0ZWQgZHVl
IHRvIG90aGVyIGxpbWl0YXRpb25zLg0KDQpXaGF0IGxpbWl0YXRpb25zPyBOVk1lICsgRE9FIHNo
b3VsZCB3b3JrIGhlcmUNCg0KQWxpc3RhaXINCg0KPiANCj4gSUlSQywgd2UgZm91bmQgdGhhdCBp
biB0aGUgdGYtcm1tIGJyYW5jaCBzdXBwb3J0aW5nIGRldmljZQ0KPiBhc3NpZ25tZW50Lg0KPiAN
Cj4gV2hpbGUgaXQgZG9lcyBub3QgaHVydCwgdGhhdCdzIHdoeSBJIG5ldmVyIHNlbnQgcGF0Y2hl
cyBiZWZvcmUNCj4gYmVjYXVzZQ0KPiB0aGF0J3MgaW5kZWVkIGEgY3VzdG9tIHRoaW5nLCB0aGF0
IHdvcmtzIGZvciBhIGN1c3RvbSBzb2Z0d2FyZSBzdGFjaw0KPiB0aGF0IHdhcyAoaXM/KSBub3Qg
eWV0IGZpbmFsaXplZC4NCj4gDQo+IFRoYXQgc2FpZCwgaXQgc2hvdWxkIG5vdCBodXJ0IHRvIGFk
ZCBpdCwgc2luY2UgaXQncyBqdXN0IGFuIGV4dHJhDQo+IGNhcGFiaWxpdHkuDQo+IA0KPiBASmlt
OiBGZWVsIGZyZWUgdG8gY29tcGxldGUgbXkgYW5zd2VyIHdpdGggbGlua3MgdG8gdGhlIGNvZGUg
YW5kIGENCj4gc3BlYywNCj4gaWYgdGhlcmUgaXMgb25lIHRvIHNoYXJlIG5vdy4gSSdtIHN1cmUg
TWF0aGlldSBQb2lyaWVyIGhhcyBhbGwgdGhpcw0KPiBpbmZvDQo+IGFsc28uDQo+IA0KPiA+IE1p
Y2hhZWwsIFRhbywgd2hhdCBhcmUgeW91ciB2aWV3IG9uIHRoaXM/DQo+ID4gDQo+IA0KPiBSZWdh
cmRzLA0KPiBQaWVycmljaw0K

