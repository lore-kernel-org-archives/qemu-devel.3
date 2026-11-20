Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B260606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=H9YsjFHQ;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=tOBISaBm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUCye-0002p3-B5; Thu, 19 Nov 2026 19:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCyP-0002mH-23; Thu, 19 Nov 2026 19:59:32 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCyK-0001l7-DD; Thu, 19 Nov 2026 19:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795136372; x=1826672372;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=B+awpR/LB6z8mFFBW1CYpJlogQWLft4cQvOxT07syBk=;
 b=H9YsjFHQ7WOz3TA+K5F8UT+ka087cwVDJclXt6ncyV2jJOfbE3uoVZ0G
 G0NZ9/UJ8QIWIgG2tl+1MoL7XkYAw84BnR21nwe26MwTVNre/kv2vNUFt
 5cgwporl/iYCjTM2g3PgWf9A2oQn32xYxApnvyGYFYylwJQRqiV6WlLDl
 OUohiPew+wKLXGRNMmAVnajdHgJvdY6BjSK2pH5xBZ5PKKIwi/AkDiADZ
 T5enXYOh6mOBPTLtmMYI+PMJMsFkMcicOrHtaPiysqZH9+Eh4/niaJRht
 3c11ygAhygb2wa4smL/fhTp2ljLEigT8vg+HgWj+AF1jOkZwucBjNuIMK A==;
X-CSE-ConnectionGUID: x3PPhh6YS6GMUbibPvi4+g==
X-CSE-MsgGUID: pGE7Ds6ESbuyk3KCSKp3DQ==
X-IronPort-AV: E=Sophos;i="6.27,222,1786982400"; d="scan'208";a="157084179"
Received: from mail-westusazon11012043.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.43])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Nov 2026 08:59:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFod4DSuH9gvVX5UcdxvGSRyYrDSGbqAe543NFFvr+ZWtyLFPuzcZhKdd6Dvx798KdWXGwf1kT/kgZfEiiRGLB/hNJ3QELiE0mEXmoUM/BuGPrd8QwUBBNTLNV6wnM+EgL43/Q65s1SkRWdwVfWO1lAX+URyTCMqP1H5mHmkCH5mzbwlZugbpdalKyPHQjg7JBTPpTj6s3USnvZz92hlPec7fVlyxJVdyjYqcXv+GXsRsVyEERy27371xyjLD/vjtVDhjf34lSmJEQ8JsbDL43et+UNFD8T3UE7Pz9jjLPkD3ln1xP5G63yITsOd/vMaeJKQ0t9HT5A/neAieMwlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+awpR/LB6z8mFFBW1CYpJlogQWLft4cQvOxT07syBk=;
 b=FBLvKM9osD3B4KufLL/gZZUSzwsU5dghPphMg/JWrJ/hX4Muj7mQEZ40zNqQZ1RIereUieidCo83iNdlsmvZ8zG7ewUJmXevd9HD4B0iLqhg9sujFQN2f0FfjhuRSLDq3uicM0Dv4soq85pWQV3yDmIkGuHfqG6MTprIYazZ9R5qcX1YqME0pOZNxDK0U8aJ4rxUz750RGlO26C4xZX3n1Q9EGpjGgH892wQVFkJENdMQQ+eO4tyfa6Y0Tp3DUDJ3hlD7uRSkwhShSblYaTSdajamp/BLlrgvZGFIFt2zO4CFDciFssCqKAcgd6pmtFX5IyGeohrIosVgBd29H5jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+awpR/LB6z8mFFBW1CYpJlogQWLft4cQvOxT07syBk=;
 b=tOBISaBms4n+fhCiupZivdLyZqlCq+ZZa2Q7pvstomB33l24wT7kF5rd5HsDJCYU9UmeiKD6ip+st2PapDvG0ozYtd6yIDwoU7EiTB3wp5ukb8p9tbcl6xPvOgaP/mxqaISTokwQ7jGi4jv/4JVmLORHvKUKJJK38xu+epIlHFw=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ2PR04MB8460.namprd04.prod.outlook.com (2603:10b6:a03:4f3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 00:59:19 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 00:59:19 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/5] hw/riscv: allow machines to set 'hpm-counters' for
 riscv-iommu-sys
Thread-Topic: [PATCH v3 1/5] hw/riscv: allow machines to set 'hpm-counters'
 for riscv-iommu-sys
Thread-Index: AQHdd/9adMpCK5RKKkKGSA74aDPVjLc2JL4A
Date: Fri, 20 Nov 2026 00:59:19 +0000
Message-ID: <2a54cee195f71bacf15cb5a80d08c253bedafde2.camel@wdc.com>
References: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
 <20261119082356.1264726-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261119082356.1264726-2-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ2PR04MB8460:EE_
x-ms-office365-filtering-correlation-id: f48dd768-f40e-4763-3159-08df46a181d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|19092799006|23010399003|38070700021|10067099003|261022075727099003|261026121527099003|261026140227099003|5023799004|56012099006|4143699003|11063799006|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: xiXjlkf67NHtUjDMdEhvCLvYU4pBojwas23E1f1kOqd7FLhMTBN+ODDP0v7hRUZj0eNPtRupHha9hjmog4fclhWCOrvk5qC9WhbV9V8ULp+2XNP5BZl5gDrZdTqSqmebguiHwLiRCdExG7bOYdDHvLabVAeGDeacx2+FD+AQrc2bwCFwhAkOamFKHWBN6/wMuxtfEKL9oE7ZyuHJHM5D36w9wvB4WkVUQKX6rQdtUZ85sNOeH5L7iArmxfOSrkIo889z+M6W6xDwcKgF+fGrNX8aECoP/56uHu9OBukWAj8iNoNMZ8boJavLm5hdXu4BDHA0uSh1NyTyxQ+fD6RGnjHHi/kcKwt26x4hT3NI8aXbp9ywKghsbOkOAzxU7s9NGL0nxd1gjtbhZVpSgHaH2kkmmLcscwO5VRXgSPcUfiyR3RbvNZp+ViMzgfZoC5ypmZ60TMP1NZ7zCD3qJh0EWEwM73nWA55/+//04kLUZ6NCtwJEsbmLbzQGp8ET5ihVYg5cVZH/JqL9uAqRjY35JENWDUvfd73gxEgJ40+Ukcq8ObcnTdLnI8rHX4RfjvmpdkiwfFi3A6UlYm3xql7Ssys6um9joRVz18Qt7pLIkqlVx+Cnsw2BuwFQ8vEmQquBBvE1OBseSCOgZya20ik7BR7qWUXSc0Pr0Dz6NRN+SfI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(19092799006)(23010399003)(38070700021)(10067099003)(261022075727099003)(261026121527099003)(261026140227099003)(5023799004)(56012099006)(4143699003)(11063799006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXQ4c3p6RWttYVlCOFNHYm9KdExDdXh2TVN3TGhiTU4vUTIvbDlGd3Vob3k1?=
 =?utf-8?B?bGdqOHJIQ0lwaTVOUmVsMDA0Tk5aRE83M1pueW52akd4aElCdUh5ZFVXOHVK?=
 =?utf-8?B?QzFWRDd1VG1XejlVN0c2RXhMd3lvYmw2RmxxYi9odkdkWTgweHdGRWg3ZnRW?=
 =?utf-8?B?ZW1QL1NseTRBaEpDQWFZWlNEeWtrZ0Qwc1llRktKWEw2Ym9LSDhrRGVsYkRO?=
 =?utf-8?B?bXpuQkxTNVRkZEg4RStYS2V4OE5BY2VueTVkeW9TcDlMMlVUUkZzbHN4b2NC?=
 =?utf-8?B?QTB1ZE9yVkd0c0daRWF6K213WEdhTmJSM05pRDhHL25jS211cHlIWUNBOVRY?=
 =?utf-8?B?U0RZMnEzMnhqWXowbkxLNHM1N1BlOUdPMllYMzVPSGJvWlRobXhDWkZpTk80?=
 =?utf-8?B?QmxmKzhMRVErQjBiODZZOW5ucnRiRmEyaTU2cTRnd2VEckhSV1c0KzJJRHZI?=
 =?utf-8?B?T3FJK0lMdXZnWGR2S21CMFRrTTRFVHFGVDdCdmhJOGczQkluQVRyTUlPcXdY?=
 =?utf-8?B?ZkxuS254RlZkTFZET0o4a2l6WXRvc2JENVJjeWRPVE5VSGFJd040bFFZT1dm?=
 =?utf-8?B?MnBvb1lQdU5BVjRlcEFaS090M3ZpOWd0NGEwUWFRQzdVY3IyblBmU25EVWVB?=
 =?utf-8?B?OE5QeVI4WGJZRWJzdHA3bEFpQzBVQTJnSUJnMitJTTJoRTBpUGtyQ256KzI5?=
 =?utf-8?B?bWxiR1lGRGZsL09waDcyMUUvOWhIa0FObkp0ZVljWHJNT3FVMlhiZWRSTHRw?=
 =?utf-8?B?OWszVU1RT3ZsUnZSamo3aVZrKzNwWEdhdVJKU2lUdStKWk5tY2NuMjViaWZz?=
 =?utf-8?B?VW0yOUk2enBmVjk5cnBqU1l0WkNtekErMjJNRnFCcmwrbmFTV2lRdnFhQmlB?=
 =?utf-8?B?dXd1UXE1YjZnWjYrL2RRNXpBQjd0VVkxMEExRzZSdm1iMWlERGplSEZEbHVZ?=
 =?utf-8?B?YS93aUswbjRkNHFUd3UxRElPSGNxVnpBdHFZaVUwT0tnMmRGVDRLd3RoUmdG?=
 =?utf-8?B?UlBiV3hHbnU1bHFETGlhdjF0WU1YMzM2dmdoaUlLUStIbm96aFgrYllCNHpI?=
 =?utf-8?B?V1ZCbDVQMmlOa3l2bmk1aWpzdXVSOE0wVnlweng0bjE4eTRtSXptR3lsL3RI?=
 =?utf-8?B?WXJMQ1paYVBrVG5PKy94YjVQV05VejhXaEhYcVdPcWMyVnkzaEhhZVVFTTdX?=
 =?utf-8?B?WE9CRyt6KytmaEIveTMzUThTVlZtaEIzd3hoMXRmNFVRcm5nOGo5K0k4cDVm?=
 =?utf-8?B?K3ordW1laHlYWWZHanFnQVJNUUZMMkU3YXJUT3FXY0pldzhDVXFFb1Vub0VP?=
 =?utf-8?B?QXBudWp6SEdRSEVQaVdncTNQL05vYjBkU21ReGFTNWtLNDFGbWcrQVkxSHRv?=
 =?utf-8?B?azlIOGNGTlV5U3YrRU5FRk9VSE5BUFdLc0dJNkovSTBBbnR2VmdQbkp1ek81?=
 =?utf-8?B?cXRYM1NYV1ZVNU54SVZBcFcyQ2N0MndOVG9hSThQaXV5RkVSckNpV2V4aG1l?=
 =?utf-8?B?SWtMQ2o5N0xyUGpRY3E5cS9CU1pKc0hBY3ZHOEpwWC9sdVAwblF3SWdWSWJT?=
 =?utf-8?B?SzF0VEtwR2lhcksrSUx0SzVCWmRySGtoU212QWpBV3ppRnV1UmZMTHdiYzlL?=
 =?utf-8?B?T0UxYjZSU056RWg3UEQxdndzS3dNRzZVOEpDaWpFM29haitzaWNLdmp6czUx?=
 =?utf-8?B?SzZMRzhLcTIyU2xocVo2OXdEYmtWeFN3cWxYNkNLeTVnZ1paUHJFc2FxZlhE?=
 =?utf-8?B?WW84SVZ5SDlZVnNmcEFzdTFUZkRtM0FNYXRYQTlTQUR6c3g5bGcrakVBM2Fo?=
 =?utf-8?B?OWxhOWhlOXJnWGpFNExxZXFtSk4zUm9vUGhSWVQ5aHRVeVpsUzFwcUdNZG9u?=
 =?utf-8?B?elM2SjdrNi9KeFNScjV0ZHlOZGJBaVdmOUlwMUZrbHhMcFg1V2V2eXRwejV2?=
 =?utf-8?B?cHJSZTV0a0h6NW9Xd2M5cFd6bE0wUFkwL1ErbnBEblVGYis5am5lUzNMZ1Qw?=
 =?utf-8?B?bmU1TUFsK2x4WnR0MXVHUndYUUtXT3RaV1ZwT0dRWW1iKzZGQWFxQjNDVndC?=
 =?utf-8?B?aEVMQm9rTXBkY3p1bmoyWlBxOUV4ZlVjejlMeHk5Z01qZTVlc21yOVJsc3pz?=
 =?utf-8?B?OUtudzF2cUpsV0gwNVF2elRpK1h3aGttdm1RcGNueHJLZndwSGh4bzdUL3Rk?=
 =?utf-8?B?K3ZOS1JnclNTaG0rV0tMd0xtV25oYzRDSXo2OEdNR3NXSXQwQVI3Q0JvVXc5?=
 =?utf-8?B?SzdUUFVoVERWM2dFZ3RWeUlCbVBtTTRUbmExSjFIc09ubW1nTHlRd0VTRVZi?=
 =?utf-8?B?MzVCMm9zUHdrSktXanFUTHVqbHZsUGdHVGNlYVR6dXZBSlI5NDFNNTZiRUJw?=
 =?utf-8?Q?RAxEWz7r03chiPFF58ABl8IM1XzzCtVfLEfowPaZ90dst?=
x-ms-exchange-antispam-messagedata-1: V6pz+MbQV5HKA7tIyddZUVNLmK30PNbnlKQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BF2E93A3C1B4A41B37C27C1AF40555D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DV55/4NhZNR+EhL2TGY/lbFd2qnYOt2wb9tQRBTkR3jJnXovJCxofZCjSsxtK6zDLEWQi+lwEn7Ynpy80AAl+lzUi6UmKcJIEgUBISGQ/CPx8mQxWVHRyQLA2JocNpelIcau+lsGICk0QtBwxgo6Yx1biXVu4ztD/4sjUAtivXYL6jyEZZWHbJz6JDvdOPEZBPy/8AeSlkNhHpFtS/Kwax++PEey3RZnxs4cESdQdGrS1rQ823gCLalPJMuDZ7iLQpZ6C88wIby0JV5gOw+dhgzoADI1tvJLKkkUqHhUnaCpnH2hRfeKexsYq5nSJIM/O2DJ5KTiYZWxCr7pC4deqQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fcXFi7X71cWFZvu6RbIRY+FBPrIugKqZ0Chv7stclp71q05tvE4mHnBrB5kG28CsLqeWZzLYhPbXi+07psAfYUJOkGcl8RBvexzPsajETxfqGUgLOiZGSURJuSKiBLQnYD7jr4HMg8+8Dw02jdcwHpPQG/L6DTqt6aFD/38Kjqo64yQtvwz1uFnGxB0K2B04ODmcVme7zSQplMi2D4O2DEFQ2v7MnHTKE4IihYHba6sSZyt3k+myMiD/WPGXG4Ez2MHoytZXhA9jg9Ug55uLk4kC8LXXjFQm+WIHwS3tL7rc8mEBiyYZLZOHxNmJ7q8wDFu3ZORGAHXPEtYGICVJnjz5HQfmGE0w7vhKETPTn5cB6tMCW87Iplu744hRn9Ke/j6KQF5D0UdaE+sSumfVYhaem4bPVRWYfjCh4fEig++fPeMQ+KsZRM1pLDMYU/SVTi+L/5XhDF2DksuFldcQc4xnW2BKNn4whE69oZMDpbm8vxnqTbVr/qKxlocxPb6sO9LuwV4M0RfOBHVolgUsaXePUwIHyxtyy2KJWMbOFHppoRtuNsgt9+GHzUNus1vClOaiDUrUHPqJS4pdfDTeBCuzgCzsZRAwYX8+3+BDKG7ZRGMg0r4vSg+wFwWfIPWE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48dd768-f40e-4763-3159-08df46a181d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 00:59:19.0847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdnNi+GIxlzhzIl9THZFV0AojnsGDWFbakhNvDW3QPDqL0qFNScFCslovsH2ESOCq8T/kwejwUlyxlnMB8shIN8DVecVNm9LgoUt/q3jANY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8460
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=7773dcc14=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTExLTE5IGF0IDA1OjIzIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBUaGUgcmlzY3Ygc2VydmVyIHNvYyByZXF1aXJlbWVudHMgWzFdIGRpY3RhdGVz
IGluIHJ1bGUgIklPTV8yMDAiIHRoYXQKPiB0aGUgSU9NTVUgbXVzdCBoYXZlIGF0IGxlYXN0IDQg
ZXZlbnQgY291bnRlcnMuwqAgQXMgaXQgc3RhbmRzIHRvZGF5Cj4gd2UncmUKPiBjcmVhdGluZyBh
biBpb21tdS1zeXMgZGV2aWNlIHdpdGggUklTQ1ZfSU9NTVVfSU9DT1VOVF9OVU0gKDMxKQo+IGNv
dW50ZXJzLgo+IAo+IEZvbGxvd2luZyB0aGUgZGVzaWduIG9mIHNldHRpbmcganVzdCB0aGUgbWlu
aW1hbCBzcGVjIHJlcXVpcmVtZW50cywKPiBzZXQKPiBocG0tY291bnRlcnMgdG8gNC7CoCBXZSdy
ZSBkb2luZyB0aGF0IGJ5IGFkZGluZyBhIG5ldyBhcmd1bWVudCBpbgo+IHJpc2N2X2NyZWF0ZV9p
b21tdV9zeXMoKS7CoCBJbiBjYXNlIG1vcmUgSU9NTVUgcGFyYW1ldGVycyBuZWVkIHRvCj4gdHdl
YWtlZAo+IGluIHRoZSBkZXZpY2Ugd2UgbWlnaHQgY29uc2lkZXIgYSBkaWZmZXJlbnQgYXBwcm9h
Y2gsIGJ1dCBmb3Igbm93Cj4gdGhpcwo+IHN1ZmZpY2VzLgo+IAo+IFRoZSBocG0tY291bnRlcnMg
dmFsdWUgdXNlZCBpbiB0aGUgJ3ZpcnQnIGJvYXJkIGlzIGRlZmF1bHQgdmFsIGZyb20KPiByaXNj
di1pb21tdSwgaS5lLiB0aGVyZSdzIG5vIGNoYW5nZSBpbiAndmlydCcgYm9hcmQgY29uZmlndXJh
dGlvbgo+IHdpdGgKPiB0aGlzIHBhdGNoLgo+IAo+IE5vdGUgdGhhdCB0aGUgJ0ZpeGVzJyB0YWcg
cG9pbnRzIHRvIHRoZSByaXNjdi1zZXJ2ZXItcmVmIGluaXRpYWwKPiBjb21taXQKPiBiZWNhdXNl
IHRoZSBJT01fMjAwIHJ1bGUgc2hvdWxkIGhhdmUgYmVlbiB0aGVyZSBmcm9tIHRoZSBzdGFydC7C
oAo+IFRoZXJlJ3MKPiBub3RoaW5nIGluaGVyZW50bHkgd3Jvbmcgd2l0aCB0aGUgaW5pdGlhbCBj
b21taXQgZm9yCj4gcmlzY3ZfY3JlYXRlX2lvbW11X3N5cygpLgo+IAo+IFsxXQo+IGh0dHBzOi8v
ZG9jcy5yaXNjdi5vcmcvcmVmZXJlbmNlL3NlcnZlci1zb2MvdjEuMC9zZXJ2ZXJfc29jX3JlcXVp
cmVtZW50cy5odG1sCj4gCj4gRml4ZXM6IGMyZmE0MzIwODAzYiAoImh3L3Jpc2N2OiBzZXJ2ZXIg
cGxhdGZvcm0gcmVmZXJlbmNlIG1hY2hpbmUiKQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBIZW5y
aXF1ZSBCYXJib3phCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdl
ZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3Rh
aXIKCj4gLS0tCj4gwqBody9yaXNjdi9yaXNjdi1pb21tdS1zeXMuY8KgwqDCoMKgIHwgNCArKysr
Cj4gwqBody9yaXNjdi9yaXNjdi1pb21tdS5owqDCoMKgwqDCoMKgwqDCoCB8IDEgKwo+IMKgaHcv
cmlzY3Yvc2VydmVyX3BsYXRmb3JtX3JlZi5jIHwgMiArKwo+IMKgaHcvcmlzY3YvdmlydC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0KPiDCoDQgZmlsZXMgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2
L3Jpc2N2LWlvbW11LXN5cy5jIGIvaHcvcmlzY3YvcmlzY3YtaW9tbXUtc3lzLmMKPiBpbmRleCAy
NThjMTcxZWZkLi4zYTllMjIwODBhIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L3Jpc2N2LWlvbW11
LXN5cy5jCj4gKysrIGIvaHcvcmlzY3YvcmlzY3YtaW9tbXUtc3lzLmMKPiBAQCAtMjE5LDYgKzIx
OSw3IEBAIHN0YXRpYyB2b2lkIHJpc2N2X2lvbW11X3N5c19pbml0KE9iamVjdCAqb2JqKQo+IMKg
Cj4gwqBEZXZpY2VTdGF0ZSAqcmlzY3ZfY3JlYXRlX2lvbW11X3N5cyhEZXZpY2VTdGF0ZSAqbW1p
b19pcnFjaGlwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBod2FkZHIgYWRkciwgaW50IGJhc2VfaXJxLAo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGludCBocG1fY291bnRlcnMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wg
aXNfMzJfYml0KQo+IMKgewo+IMKgwqDCoMKgIERldmljZVN0YXRlICppb21tdV9zeXMgPSBxZGV2
X25ldyhUWVBFX1JJU0NWX0lPTU1VX1NZUyk7Cj4gQEAgLTIzNyw2ICsyMzgsOSBAQCBEZXZpY2VT
dGF0ZSAqcmlzY3ZfY3JlYXRlX2lvbW11X3N5cyhEZXZpY2VTdGF0ZQo+ICptbWlvX2lycWNoaXAs
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpc18zMl9iaXQgPyAzNCA6IDU2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2ZhdGFsKTsKPiDCoAo+ICvCoMKg
wqAgb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKGlvbW11X3N5cyksICJocG0tY291bnRl
cnMiLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaHBtX2NvdW50ZXJzLCAmZXJyb3JfYWJvcnQpOwo+ICsKPiDCoMKgwqDCoCBzeXNidXNf
cmVhbGl6ZV9hbmRfdW5yZWYoU1lTX0JVU19ERVZJQ0UoaW9tbXVfc3lzKSwKPiAmZXJyb3JfZmF0
YWwpOwo+IMKgCj4gwqDCoMKgwqAgcmV0dXJuIGlvbW11X3N5czsKPiBkaWZmIC0tZ2l0IGEvaHcv
cmlzY3YvcmlzY3YtaW9tbXUuaCBiL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LmgKPiBpbmRleCA0MDNk
MTBiMzIxLi4wZjc1NWIwOTkyIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LmgK
PiArKysgYi9ody9yaXNjdi9yaXNjdi1pb21tdS5oCj4gQEAgLTEwNyw2ICsxMDcsNyBAQCB2b2lk
IHJpc2N2X2lvbW11X25vdGlmeShSSVNDVklPTU1VU3RhdGUgKnMsIGludAo+IHZlY190eXBlKTsK
PiDCoHZvaWQgcmlzY3ZfaW9tbXVfZmF1bHQoUklTQ1ZJT01NVVN0YXRlICpzLCBzdHJ1Y3QKPiBy
aXNjdl9pb21tdV9mcV9yZWNvcmQgKmV2KTsKPiDCoERldmljZVN0YXRlICpyaXNjdl9jcmVhdGVf
aW9tbXVfc3lzKERldmljZVN0YXRlICptbWlvX2lycWNoaXAsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3
YWRkciBhZGRyLCBpbnQgYmFzZV9pcnEsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGhwbV9jb3VudGVy
cywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBpc18zMl9iaXQpOwo+IMKgCj4gwqB0eXBlZGVmIHN0
cnVjdCBSSVNDVklPTU1VQ29udGV4dCBSSVNDVklPTU1VQ29udGV4dDsKPiBkaWZmIC0tZ2l0IGEv
aHcvcmlzY3Yvc2VydmVyX3BsYXRmb3JtX3JlZi5jCj4gYi9ody9yaXNjdi9zZXJ2ZXJfcGxhdGZv
cm1fcmVmLmMKPiBpbmRleCAyMmIzMTQ5ZWU4Li5mYjc3MGNmNmZiIDEwMDY0NAo+IC0tLSBhL2h3
L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYuYwo+ICsrKyBiL2h3L3Jpc2N2L3NlcnZlcl9wbGF0
Zm9ybV9yZWYuYwo+IEBAIC02Nyw2ICs2Nyw3IEBACj4gwqAjZGVmaW5lIFNZU0NPTl9QT1dFUk9G
RsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgyCj4gwqAK
PiDCoCNkZWZpbmUgUlZTRVJWRVJfUExBVEZPUk1fQlVTX05VTV9JUlFTwqDCoMKgwqDCoMKgwqDC
oCA4Cj4gKyNkZWZpbmUgUlZTRVJWRVJfSU9NTVVfSFBNX0NPVU5URVJTwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCA0Cj4gwqAKPiDCoCNkZWZpbmUgVFlQRV9SSVNDVl9TRVJWRVJfUkVGX01BQ0hJTkUg
TUFDSElORV9UWVBFX05BTUUoInJpc2N2LQo+IHNlcnZlci1yZWYiKQo+IMKgT0JKRUNUX0RFQ0xB
UkVfU0lNUExFX1RZUEUoUklTQ1ZTZXJ2ZXJSZWZNYWNoaW5lU3RhdGUsCj4gUklTQ1ZfU0VSVkVS
X1JFRl9NQUNISU5FKQo+IEBAIC02NDEsNiArNjQyLDcgQEAgc3RhdGljIHZvaWQKPiBydnNlcnZl
cl9yZWZfbWFjaGluZV9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkKPiDCoMKgwqDCoCB9Cj4g
wqAKPiDCoMKgwqDCoCByaXNjdl9jcmVhdGVfaW9tbXVfc3lzKG1taW9faXJxY2hpcCwgcy0KPiA+
bWVtbWFwW1JWU0VSVkVSX0lPTU1VX1NZU10uYmFzZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSVlNFUlZFUl9JT01NVV9IUE1fQ09VTlRF
UlMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIElPTU1VX1NZU19JUlEsIGZhbHNlKTsKPiDCoAo+IMKgwqDCoMKgIHMtPm1hY2hpbmVfZG9u
ZS5ub3RpZnkgPSBydnNlcnZlcl9yZWZfbWFjaGluZV9kb25lOwo+IGRpZmYgLS1naXQgYS9ody9y
aXNjdi92aXJ0LmMgYi9ody9yaXNjdi92aXJ0LmMKPiBpbmRleCBkY2ViM2ZmNTVlLi4wMTYwMDNk
NzNkIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L3ZpcnQuYwo+ICsrKyBiL2h3L3Jpc2N2L3ZpcnQu
Ywo+IEBAIC05NjIsNyArOTYyLDggQEAgc3RhdGljIHZvaWQgdmlydF9tYWNoaW5lX2luaXQoTWFj
aGluZVN0YXRlCj4gKm1hY2hpbmUpCj4gwqAKPiDCoMKgwqDCoCBpZiAodmlydF9pc19pb21tdV9z
eXNfZW5hYmxlZChzKSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgcmlzY3ZfY3JlYXRlX2lvbW11X3N5
cyhtbWlvX2lycWNoaXAsIHMtCj4gPm1lbW1hcFtWSVJUX0lPTU1VX1NZU10uYmFzZSwKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IElPTU1VX1NZU19JUlEsIHJpc2N2X2lzXzMyYml0KCZzLQo+ID5zb2NbMF0pKTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElP
TU1VX1NZU19JUlEsCj4gUklTQ1ZfSU9NTVVfSU9DT1VOVF9OVU0sCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByaXNjdl9pc18z
MmJpdCgmcy0+c29jWzBdKSk7Cj4gwqDCoMKgwqAgfQo+IMKgCj4gwqDCoMKgwqAgcy0+bWFjaGlu
ZV9kb25lLm5vdGlmeSA9IHZpcnRfbWFjaGluZV9kb25lOwo=

