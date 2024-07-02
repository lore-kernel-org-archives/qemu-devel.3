Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894C8C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRb-0007y9-Cz; Tue, 02 Jul 2024 01:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRY-0007vC-LC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:44 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRV-0006Un-EX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899561; x=1751435561;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xaxAGyD4o2O8sCWULUZmUAxQhty2kaey6TC3HEo4ugw=;
 b=BoIjCKwmxYWeEl1Mh+YGloGufo7COqD1eHD98+pIuzZZF1AGk6gE/1ie
 bg2Icq5ut+Gg49LQj1zXIKD+oGdwXMkrPHhFWLOMEnsRejO+buJJH/4lP
 Vl+3IbmCR2a7OF8vKg8gIxt1n9DmaqMF18LBuWaDts1+xaHykkTVNntum
 g9nSADwJhTSUvUf8yD93ECgk5Lz7fyHZvndljmyKjsNf/Ozd68eYrAQix
 RayPlPThmU/pn6EkQokCU7SpfXDHtrBuE94OJ7Ga9pNwTh4HPKMridnON
 +GXihuVfSgb7AoF6qqQe2vvY4wvKECsGeCYZRqKQWpZUpAYqvjCSY5HQ9 A==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721521"
X-MGA-submission: =?us-ascii?q?MDFYoE9tbcJ6B2npvCda6XPRaKqmw+1lDiukpc?=
 =?us-ascii?q?LyiA4H/T/XBKq82twj3YCKmV7NOY31yxKfJ/y4dz0cWrU7MgdXuibeoC?=
 =?us-ascii?q?NSBzuJLdpne1bF8uiZlp5XD4NVyJrQA/NNU0585dMv3hZ+zu8KSwH+L8?=
 =?us-ascii?q?7O3hlzgoF2DRQU0ksVbOVlLA=3D=3D?=
Received: from mail-am6eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.110])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpHXm1lTY8/8TeYs7XpMG7Z3sWjOy3iVyEPZR1caXOTaJt0efizzRBmi0/Q5KyyKdMbSWgxUpSavCPp1kDyOf6XdU9LOtd98GhJy5pmvY0J1IfZhPlKzey37Zb0unRa3s5p7+TAwoGW093y5WyrqgCsAGN8qcMUtITiLtJbfSkeCoriGFtgQSwJzIvdjkDz5AJpFb161Wq3RI4Ne62gLlbfpM+57HaDCLnzR4K617ukWAgnjP4ffDdmBsZfvfjnuvOsu+p1HompvVrO3KcyIGPrN6s5NuEVy07N66v7zDdM3i/X6PmGdvQVHYTcLNDXnKuo1zHazgwETD3h93wMtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaxAGyD4o2O8sCWULUZmUAxQhty2kaey6TC3HEo4ugw=;
 b=D+w+tC+Es6ZSuWvazmveG4yHm/Y4GbBwOMdZpUCCSOu4fQokIPRuv8+Vs6252SByuMP/MD9TXcKBVVYK3KpeXUAEfolXXsrgWWJm/GKnyY2wmQdTo8KEVULzWo4iM34POk/TtjwDIzFAGlO2+nulrgxpscP0thqNfwVBmxdduvAi84dmtwwMMseQtFvbW17sLhfyN4If4o777h5YHqVVefacr5jDcE4Nn1bFug2iBfjnPkLP4bZ61MEPp/VfK+hozMMRx/5jZbB826WXYu80vE+cUKUXLUi9QOPdjzRpbsY64XDSnhMVg379+zPnnE1KzVFlfiYQSMexJJioW4DBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaxAGyD4o2O8sCWULUZmUAxQhty2kaey6TC3HEo4ugw=;
 b=pZBAFwxnVvpw7+QEnGgMpqp7QhUYdlHsKdWT8iTCFDe1nNK86yLdcvpGDwzAcEP23ksdJLbQCgBb5dQHzyGLRxowArcXD5LjK9lx8HVzXemLg7/64PGqpXO005WbsrvEoCJ1KdyFsj2PmkS6RQrvK5aKDtUuVlH+GFNBK86ZbDC11/rtA8wSfJnzyTFP/e4u2HCcbgKDidjylQQ/2fh17vXst8VQ3V2EYxdtoQbyC7Nb4vh5GZi5WkjbZ1X1txJgOeBdWMNTCyvDtasxl3h8mgBsC5MwiaSyWFWZFsBjxCTgYCMMHHk4Zho0glI1oUpSMeWGbhsBsL6lZDr5lg6HOg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:37 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:37 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 09/22] pci: cache the bus mastering status in the
 device
Thread-Topic: [PATCH ats_vtd v5 09/22] pci: cache the bus mastering status in
 the device
Thread-Index: AQHazEQKdi6Jv3RtX0yfGUZA/khw1A==
Date: Tue, 2 Jul 2024 05:52:37 +0000
Message-ID: <20240702055221.1337035-10-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: a4f7b8c4-a2c2-4606-eeb6-08dc9a5b2d7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEptcVJRYnF2cjBCdy9YZzl0YWNPNW4rbnFTSHR4Skp4TThIQkNtclQ5bDJp?=
 =?utf-8?B?NE5MN25BL0IwcUNMWnlNQWtlQWJMZnRXc0JIRFRhK28xc1dEM1VGZWRVSjRB?=
 =?utf-8?B?V0ptRExVMDFXendrTG9zbXhqVHNMUnQzSm05UXUvVWgvb3FqcHBhdlU0dmdn?=
 =?utf-8?B?VUd2cUh1aVZ6c0s3UDV0OVVDbE85UjdoVVlBeS91MDV2aFNtWVpGTzV4Nm1U?=
 =?utf-8?B?NXhpYVNjS3ZWNVorMDRqZGZYRlZOR0U1RWJOWDk0eGJsSTF6aWR0Z1ZWUGlw?=
 =?utf-8?B?VkhFVVJPK2FCZ2JmOGZJa3FRL29nTTQ0TnRyME85ZnJ4VWtRVkR3Q0xiWHgv?=
 =?utf-8?B?VDFLb3ZQelFXWThXOEhJTEliQ0RpYllUYndqZEpWSkZxUWlPYVV3ckdudGZo?=
 =?utf-8?B?MkJqVnlORXhLd0RCM0xOTFIySkVNTWIvZ0JJNnZTMWpuU3dFeVhQMHMrcWlE?=
 =?utf-8?B?YkxZV1dHcFFjdklSQngrTXk0L29DRlowQTNLZEJYamp3T3F4dzl6YlJEMDhL?=
 =?utf-8?B?Si8yUURlTkp3ME9SMlZkeFlMU0ZvdlEzdEJVTjhDVkxyK0wyNTBmSUpKejd0?=
 =?utf-8?B?Qm1WWUl4SVVIOHE1MUVzTVdDTjB4R1pXZ2txd0NieURLL3pqODRhQUMzaXFW?=
 =?utf-8?B?cmh6RHdocTJqRXBrOUY3SFZRbFEvbUZMYlB0UnpMSVNiVW5YcTU2Rkx3Y24w?=
 =?utf-8?B?Q2xEL2pxemE5VDZSNFREaXhoWDl4RGpWWStsekdnSlBqQ3dlMmZXOXoyUzRn?=
 =?utf-8?B?ckdaVk80WHg4U2FiU1pmSzdWdFJMN2xkcFdxYVBGNEY2K0haWVkzSGMrMDRT?=
 =?utf-8?B?aFhZQ05LUnV2SmxYRmNPNXMrTG9lclF6VFh6Y0YxcnJCZ0RGTEp6MUdlWGNX?=
 =?utf-8?B?Mm1Mbkh4UFA3WjZrUjVoaWlhZXVkMzU5MEhDUEk4Q3VDUC9FeWh6TmJEQUZB?=
 =?utf-8?B?aUE5eTNXN0Joc0lMTVErYjh2aVVXV2hDTjFVd3VSdE11NnBlQjJEc0VNMlZV?=
 =?utf-8?B?ZkxYOWUyQzY0eERtcUdGSlRBU0xORDVvQUxxUys2ZWx0VjZqVFQvVGtTcjJ0?=
 =?utf-8?B?YlVFWU5wYXFQa0RWZi9RYWQ0clg1a2Y5S094WUJueXJsZStOcWg3cU1keS8z?=
 =?utf-8?B?Q08vZzJpTVYyTDMzVmJIb0xwcmdPZGJuNlFXMmtnSEhWd3Y0WnlpcW1KUDFJ?=
 =?utf-8?B?ZW1vdzNwOXpXWDlGV3AzRDVMbC8za3RHRStvSUZhT3orcTRQUXNTMi9TeGNH?=
 =?utf-8?B?b25tMG02ODE4L2E5M0RYODFING9vZ3lGNlV1Qm8rMUNTNzNwclVWSGd5c2tE?=
 =?utf-8?B?R3JXbURHVzF3UTNZeFUwUmtieTAvblNWTVFabUUxUFU4SDVnaDIzcHRscjRB?=
 =?utf-8?B?UFkrWkVudElxVVhhOE5oYTNHNzV6T3ZjOHV1bHN4MS9MRHJxS0xGTnA0eVZR?=
 =?utf-8?B?QTlPQ28xWEtIMmdqRndDQ3ZWb0dmTHBScmFUTnova0loRzNyODJTNDRkWVdM?=
 =?utf-8?B?U3lJWGpjcXVRakZic0srSUxMaFVPRUQ3SUFZb05YMmRBeTdPNUw0ZzBnYSth?=
 =?utf-8?B?Uk5mTUczL0JzdHFsZzdJMzZpZS9yUVNEdldQRkIwaDEwdm9zUy8wTm9pMkk4?=
 =?utf-8?B?djZNS042bkZOcmtZWUtrWkIwUFcwUFRuUFB5dVVPNEh3VldCRnZvZnI1MmVn?=
 =?utf-8?B?aXhvcWhTUHdOeDZXNVc1RUtkWk5Jc1pCWUR2SHlyT3V2aStnbmZPU1VFc0JO?=
 =?utf-8?B?MzZRRGQ0ODVmMEJ2RWFkOHhxODVSejFiSjJpU0Q1VEQxamFoSjBReFF3bXZ3?=
 =?utf-8?B?bkhJYUFPanRjWTE4OEx5NUJBWG9JVU5OMmw5aFhNU2xrdW5KMDBNWklTZ28z?=
 =?utf-8?B?ajFtSEJ3V0hTR0RyU1NiK1QzR1gvN1FVVHdWUTlTWXZFVEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGdUdlpNWnpPT1d4YWNmMGl4d3Vrd1VrcStLSDY4ZDM5ekhDa1FIUHluTGJl?=
 =?utf-8?B?S1lFYnJPVHFqSFhlMmcxd2dPRzVFbUpnTjFNMGRWMzhocGVPZkp5dVhNOUQ0?=
 =?utf-8?B?UzhldUJvbFY1LzZhbmpzNU5Ed0pXSUdmOHlPeGRaK1FEdEtvK1FHWTBpbFk5?=
 =?utf-8?B?TUdBaVJRK2hnaG1Nb0FndVgzdHp0WFAzMUxSRWt4cmY4NUtTOXhoZ1A5Z1lt?=
 =?utf-8?B?S01iRFgzcC9kZnJaN2ZybStUaFZhcTIrdnRUNTZVd1RjdlMzZVNkUUhxK2sv?=
 =?utf-8?B?QkEza25ZRWw3N2U3VVVrU25DVEpFKzBDcVB6TGZOYkFWOTVnRlV4UWNRYWdD?=
 =?utf-8?B?TDk2NWQvTVdNdkR4b05qbmxYSXZVV0RaSHRvRCtoUllLME1hL29RU3BGRGNF?=
 =?utf-8?B?UCtxcUNvcW9Dckc1emtQUWlCODMzbFQwSGh3aDJPYjZnWUdmTDZPZUtBNEVr?=
 =?utf-8?B?bGllY09CeFI2WnhjNzBNK1NiRXZ2RU5hQmw1VlRYazNRdjZjRjBhVmNuN2dl?=
 =?utf-8?B?T28yam1yOU9sYVRTK2FiRlhtL3Y3L1R0OTRYVmxxamFoTVFxazRndGFralAw?=
 =?utf-8?B?N21TUkJNWGlDb3cwME8wSFpUL0pMK1kyUExXOHF5N0xvbU1YRDE0VzZranUv?=
 =?utf-8?B?cCszaENRM2JJZVZ3RTBCOVI1KzA2L0g0b1pjdVVXc3dwSk5SajRuVHBucFNk?=
 =?utf-8?B?blhTV1E3Z3pnOFlJRDE5U0xWNE5udnpwSVVnR0lwVnZ5MUtzZGdVTi9SYTlZ?=
 =?utf-8?B?Mkg3eElpVTZtL0M0ZTFpQldFR2pLTFRtQnlrdjhPRm1FMk91WXRmK1NERzhm?=
 =?utf-8?B?bTdCSWNlTEZZME9lYlVRZjNuaW5VellXVStCRTRtcTNrK3BOaTBQUDlQMUFz?=
 =?utf-8?B?VU8yZ0FJMTlyNGtTQlZhZUVXMzNKMTExR0psUXB2WHN0WVhYZzlNM1M1NDNW?=
 =?utf-8?B?aXV0dkUwdjVBMXo2clBiWHZVeEtrTjI5SXZSNEJWMll6RzJ2enJrc0JmUWRx?=
 =?utf-8?B?NGNOekRHeDR6cnJ4S0I3bnh6dzJEMUtHNHkvSC84VWROYTJQVDhybXNNUms2?=
 =?utf-8?B?RjdoVzlMb2g2cWJ0SHhqS3lwbnExcmZuWjBkYnZQdUpkNjgxazJ1K2cxS2h4?=
 =?utf-8?B?a3BmYytMRXFYejAwc0VaODdqUjR2bXo2TFBQOUdvTkdiNTczVkdFMXZ2bThF?=
 =?utf-8?B?Vkp3K3lURSt6ZytORlc5YlRqdUJGY0pPbk9NWGVuK3hRaVdFVWRnUzJGdldT?=
 =?utf-8?B?SWs2TGRrQVlxc2pGOVMvYnBIakwrNVRwME9jRDlVRWt6QjJTRzNuUFhjNnRr?=
 =?utf-8?B?M3VXS09DSGRLL2lYaVd2bmxnZm0vNkhmMjJvak84RFplRHhENkFHZDNlTW9Y?=
 =?utf-8?B?Kzg0aVRucVRaWSt4WlJ6L0c4cVU2aGhUMWM1ZUpuemJTbjQraU42YlJTc3ls?=
 =?utf-8?B?Vkt6YlhWbHhESVdkYkJuQnByWE9yYWxrQTVaZ1VFSlVrWFNaakdyeFFlaDdr?=
 =?utf-8?B?V2V0NXd0eTQ5eXhVQkhGSHVObjdMb2FYRkx3Snhkejg0OUxVdGt2eUx0bmRK?=
 =?utf-8?B?eXJqQVJwaDJLUy9PaUR5akJHNUQ1VFk1bG5IcFE4KzNaaWVNbGtoaVk5aEIr?=
 =?utf-8?B?UXBYWlQrZmxDakpEMEhBdTdJSVIzWnBoRG9YUEFGWFh6R2VXdzhWTzM1Nkt5?=
 =?utf-8?B?M2xhV3BZOVo0eitmU05iY24zUEgvK29lUHoycVZwZTRDaVY4NDdYMGFhc2F5?=
 =?utf-8?B?ajdKT04xOWZROHV3M1djNW5NeFZYY0lSMEMxa3ptdmRXZ2RjVndkM1BNWGxI?=
 =?utf-8?B?QnNsSG5UZWJUSnJ1Y0hVZXZVQmk5OEJUVkI4Ykc0eTZJdVkrRVIveEFzVFJW?=
 =?utf-8?B?dENYaHRPNVhybmQzYUREaEFYSnRJL1dQOU1zcCtNYnJVRlpLcUV4cGhZL2JY?=
 =?utf-8?B?Yk1BdmliWGdkcHJQQXJ0REVTeW1RQ05vRWVoZU1hY0laVkNuS0krZDNXR1A2?=
 =?utf-8?B?V2MwYkpjdnFQZGZUV0JuY2M2bEU2dkF0TElkdUNTbURsUyttNXA2T2pkSzZu?=
 =?utf-8?B?dW1aYllTRW5kcGkramlTRDJMSFFoZ21jaWR6WE4yVEo4ZHBEdHhBdWVObTVJ?=
 =?utf-8?B?dEl4a1hHclFFTE8zNHJoN2xreUE3R1Uwb3pPZ01BR3dza2NNZi9TazhvL2Vp?=
 =?utf-8?Q?ts2O3k0miPNo37YUh2h9KR8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F1B17DE31F2584CB2DDCC2E5C7D9DBB@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f7b8c4-a2c2-4606-eeb6-08dc9a5b2d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:37.5268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05dRWd4oLmFAFJ0ocYmjjfvcWa5Y4Iq8dx7SWaXv7NrV1MmSaehrNRGo+6rJrrYBRKzQCuD8bNysFY/cvvkSsJGM349ZUiVtrDTLnNBEhL3BXdWPalF4+nHAAmgWdtFd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgICAg
ICAgIHwgMjQgKysrKysrKysrKysrKystLS0tLS0tLS0tDQogaW5jbHVkZS9ody9wY2kvcGNpX2Rl
dmljZS5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCmlu
ZGV4IGM4YThhYWIzMDYuLjUxZmVlZGUzY2YgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpLmMNCisr
KyBiL2h3L3BjaS9wY2kuYw0KQEAgLTExNiw2ICsxMTYsMTIgQEAgc3RhdGljIEdTZXF1ZW5jZSAq
cGNpX2FjcGlfaW5kZXhfbGlzdCh2b2lkKQ0KICAgICByZXR1cm4gdXNlZF9hY3BpX2luZGV4X2xp
c3Q7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIHBjaV9zZXRfbWFzdGVyKFBDSURldmljZSAqZCwgYm9v
bCBlbmFibGUpDQorew0KKyAgICBtZW1vcnlfcmVnaW9uX3NldF9lbmFibGVkKCZkLT5idXNfbWFz
dGVyX2VuYWJsZV9yZWdpb24sIGVuYWJsZSk7DQorICAgIGQtPmlzX21hc3RlciA9IGVuYWJsZTsg
LyogY2FjaGUgdGhlIHN0YXR1cyAqLw0KK30NCisNCiBzdGF0aWMgdm9pZCBwY2lfaW5pdF9idXNf
bWFzdGVyKFBDSURldmljZSAqcGNpX2RldikNCiB7DQogICAgIEFkZHJlc3NTcGFjZSAqZG1hX2Fz
ID0gcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKHBjaV9kZXYpOw0KQEAgLTEyMyw3ICsx
MjksNyBAQCBzdGF0aWMgdm9pZCBwY2lfaW5pdF9idXNfbWFzdGVyKFBDSURldmljZSAqcGNpX2Rl
dikNCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2FsaWFzKCZwY2lfZGV2LT5idXNfbWFzdGVyX2Vu
YWJsZV9yZWdpb24sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QocGNpX2Rl
diksICJidXMgbWFzdGVyIiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hcy0+
cm9vdCwgMCwgbWVtb3J5X3JlZ2lvbl9zaXplKGRtYV9hcy0+cm9vdCkpOw0KLSAgICBtZW1vcnlf
cmVnaW9uX3NldF9lbmFibGVkKCZwY2lfZGV2LT5idXNfbWFzdGVyX2VuYWJsZV9yZWdpb24sIGZh
bHNlKTsNCisgICAgcGNpX3NldF9tYXN0ZXIocGNpX2RldiwgZmFsc2UpOw0KICAgICBtZW1vcnlf
cmVnaW9uX2FkZF9zdWJyZWdpb24oJnBjaV9kZXYtPmJ1c19tYXN0ZXJfY29udGFpbmVyX3JlZ2lv
biwgMCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZwY2lfZGV2LT5idXNfbWFz
dGVyX2VuYWJsZV9yZWdpb24pOw0KIH0NCkBAIC02NTcsOSArNjYzLDggQEAgc3RhdGljIGludCBn
ZXRfcGNpX2NvbmZpZ19kZXZpY2UoUUVNVUZpbGUgKmYsIHZvaWQgKnB2LCBzaXplX3Qgc2l6ZSwN
CiAgICAgICAgIHBjaV9icmlkZ2VfdXBkYXRlX21hcHBpbmdzKFBDSV9CUklER0UocykpOw0KICAg
ICB9DQogDQotICAgIG1lbW9yeV9yZWdpb25fc2V0X2VuYWJsZWQoJnMtPmJ1c19tYXN0ZXJfZW5h
YmxlX3JlZ2lvbiwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwY2lfZ2V0X3dvcmQo
cy0+Y29uZmlnICsgUENJX0NPTU1BTkQpDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JiBQQ0lfQ09NTUFORF9NQVNURVIpOw0KKyAgICBwY2lfc2V0X21hc3RlcihzLA0KKyAgICAgICAg
ICAgICAgICAgICBwY2lfZ2V0X3dvcmQocy0+Y29uZmlnICsgUENJX0NPTU1BTkQpICYgUENJX0NP
TU1BTkRfTUFTVEVSKTsNCiANCiAgICAgZ19mcmVlKGNvbmZpZyk7DQogICAgIHJldHVybiAwOw0K
QEAgLTE2MTEsOSArMTYxNiw5IEBAIHZvaWQgcGNpX2RlZmF1bHRfd3JpdGVfY29uZmlnKFBDSURl
dmljZSAqZCwgdWludDMyX3QgYWRkciwgdWludDMyX3QgdmFsX2luLCBpbnQNCiANCiAgICAgaWYg
KHJhbmdlc19vdmVybGFwKGFkZHIsIGwsIFBDSV9DT01NQU5ELCAyKSkgew0KICAgICAgICAgcGNp
X3VwZGF0ZV9pcnFfZGlzYWJsZWQoZCwgd2FzX2lycV9kaXNhYmxlZCk7DQotICAgICAgICBtZW1v
cnlfcmVnaW9uX3NldF9lbmFibGVkKCZkLT5idXNfbWFzdGVyX2VuYWJsZV9yZWdpb24sDQotICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsg
UENJX0NPTU1BTkQpDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmIFBDSV9D
T01NQU5EX01BU1RFUikgJiYgZC0+aGFzX3Bvd2VyKTsNCisgICAgICAgIHBjaV9zZXRfbWFzdGVy
KGQsDQorICAgICAgICAgICAgICAgICAgICAgIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsgUENJ
X0NPTU1BTkQpICYNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX0NPTU1BTkRfTUFT
VEVSKSAmJiBkLT5oYXNfcG93ZXIpOw0KICAgICB9DQogDQogICAgIG1zaV93cml0ZV9jb25maWco
ZCwgYWRkciwgdmFsX2luLCBsKTsNCkBAIC0yODg4LDkgKzI4OTMsOCBAQCB2b2lkIHBjaV9zZXRf
cG93ZXIoUENJRGV2aWNlICpkLCBib29sIHN0YXRlKQ0KIA0KICAgICBkLT5oYXNfcG93ZXIgPSBz
dGF0ZTsNCiAgICAgcGNpX3VwZGF0ZV9tYXBwaW5ncyhkKTsNCi0gICAgbWVtb3J5X3JlZ2lvbl9z
ZXRfZW5hYmxlZCgmZC0+YnVzX21hc3Rlcl9lbmFibGVfcmVnaW9uLA0KLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsgUENJX0NPTU1BTkQpDQot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICYgUENJX0NPTU1BTkRfTUFTVEVSKSAmJiBk
LT5oYXNfcG93ZXIpOw0KKyAgICBwY2lfc2V0X21hc3RlcihkLCAocGNpX2dldF93b3JkKGQtPmNv
bmZpZyArIFBDSV9DT01NQU5EKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICYgUENJX0NPTU1B
TkRfTUFTVEVSKSAmJiBkLT5oYXNfcG93ZXIpOw0KICAgICBpZiAoIWQtPmhhc19wb3dlcikgew0K
ICAgICAgICAgcGNpX2RldmljZV9yZXNldChkKTsNCiAgICAgfQ0KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaA0KaW5k
ZXggZDNkZDBmNjRiMi4uN2ZhNTAxNTY5YSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3Bj
aV9kZXZpY2UuaA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5oDQpAQCAtODcsNiAr
ODcsNyBAQCBzdHJ1Y3QgUENJRGV2aWNlIHsNCiAgICAgY2hhciBuYW1lWzY0XTsNCiAgICAgUENJ
SU9SZWdpb24gaW9fcmVnaW9uc1tQQ0lfTlVNX1JFR0lPTlNdOw0KICAgICBBZGRyZXNzU3BhY2Ug
YnVzX21hc3Rlcl9hczsNCisgICAgYm9vbCBpc19tYXN0ZXI7DQogICAgIE1lbW9yeVJlZ2lvbiBi
dXNfbWFzdGVyX2NvbnRhaW5lcl9yZWdpb247DQogICAgIE1lbW9yeVJlZ2lvbiBidXNfbWFzdGVy
X2VuYWJsZV9yZWdpb247DQogDQotLSANCjIuNDUuMg==

