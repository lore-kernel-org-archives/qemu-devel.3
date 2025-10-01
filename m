Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510B2CCA474
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 06:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3qar-0003Ah-0R; Wed, 01 Oct 2025 02:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v3qaW-000387-E1
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:45:21 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v3qaK-0003Bk-L0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1759301108; x=1790837108;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hUCHQSmQfOjlA71LMhKpL2Gbzi+kH/Q8mqXjOMwhR9I=;
 b=vWV5aLDIFFT9faHTw+ZIvRjcqqFubMug1j0MyGIF0wRr8oYfTujmUekK
 YRM7PkUqJBJfjU6ncZBqV16nTZYIAg7X4obPHDSHyvbGiN80EczG/rEpO
 UYBGJDeDnk9cVPit6MtkrlpbOAYPsGSyJKPpg9wBo+mHWtoZZfDKzFTac
 SPm6ToujrFX1swty/wttRoOh5WPZYKg9NeFUlm+15nVFXYlNDnD457ujs
 qLcQaNzSoGCxXUEHpK1W8ntiDwg+P38rTDg9+HlZrtwlF8vlr9MvCNBFi
 eWPycE0JeedI74lNczFcDujM9b2s7jkYg1aWLigOqE46QsQBmUUprqkVp A==;
X-CSE-ConnectionGUID: zD6SgzQRRWOFBVwumTQPzQ==
X-CSE-MsgGUID: Nl18bD5tSxWaqbYu2x6zwA==
X-IronPort-AV: E=Sophos;i="6.18,306,1751234400"; d="scan'208";a="45571742"
X-MGA-submission: =?us-ascii?q?MDFlFQbx58R4RnPHw16ib/8Dhs7A5k+NTgggm8?=
 =?us-ascii?q?c0aeEBSoDsRW3qkNepTsxqimHRoPpoxmDxWHpHZo5+0sbsGsVuidT26j?=
 =?us-ascii?q?LYEp4UzIEY17GfPcj/ZlVGFC4BcDfguNCc4P+a+lMfCD4UP2RHVGtGE+?=
 =?us-ascii?q?1uo1CVkMLKzGuoF0Nqd+Oh9g=3D=3D?=
Received: from mail-francesouthazon11011032.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.32])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Oct 2025 08:44:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K28lZ0iyipKmmoa2w/OYB8UfYR7FCXq/Z8d8x7C0jBaU5+gf5htc6J8lX2Wz7XvNTDs5l7hd6a9V9lKot20Z5bm93g0iSikqUzCEo+HB6EVodu06R7qmzWKZkmzUoSjDRIn4oyYY7purlhaKa/d/O7J4Fm3MoY+MSofjPswNNfX0EztsrwHTE08SjSRv00XA+0HmgmGoA8fZ+tz3gSLGhFxo8JnK5ix9swpnE7NzZhqI4kdP14Tek6vPkAs83ZtbY0BphqTdssOXgg50gxyxlGdSZsioHz4Yt4Y0sNWCBVCx6mffHDIq6X/L2kHv4VJm8rrx7LiCS4qdaPMNEHdPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUCHQSmQfOjlA71LMhKpL2Gbzi+kH/Q8mqXjOMwhR9I=;
 b=tdvj3E31Uhs5Doj8vjkitFHOH7RO+S5DHoQJ1tYJGZTlvALA2BP0+EZRgZkriKoSc6V30YCegSRbZimszRH317i5PfR9n5SEOs6fQhMVxUqNi1s4bxiWwvUfFVQXPZrnULQCp17j1Q1GXElXEpkyacR4jCHaDb3vVrfL6xQffEFm3KJEJpsPuM5CH/pcOASA3yTv5zXJjvsbw0Ho1A7j+Lt5eIgmVSrPRjp/5CBIcB7460DVMC2WznNMMw4PV2M5PE97d2yzBiU6/T69JbVHtXxCbZnnJYSVBj7yFib9deU/Xix6Huw4nBl7ZZDWXRwzM6ELOUnnGZvjzKi6aK2Wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUCHQSmQfOjlA71LMhKpL2Gbzi+kH/Q8mqXjOMwhR9I=;
 b=fVfo4U4VP03pzy7+TIFKd5GYwbJiY1ed01hZX0I5njBPRSMAEPJCZc4C1b5/6LPZBNfbwyA2k34VOnyakYTaCpwnWky9WbKkjo3yuD3+Nt9vSt8n5bHjsuTtdNsiybNEvzwcQj1JB8XT0M3MFbLNMWxo2b5eACpk1W0BMUs94+XtUWPpQlDrSXjvkLN76j3IfsB/VbVW/fY6Ekx0UKxCtvkeTumGoUcF/LHqTWyFhDwExK6AnOtyWOG1QsWeYBPfnf6FUpEYt6jbcSLrXI0Qde7FsDksLHql7kBLCZdaWwLkgT/+PHwMk/T5zBd4JOc4IviT1Ew//eiA/9z/2JkdXA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7182.eurprd07.prod.outlook.com (2603:10a6:102:fc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 06:44:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9160.014; Wed, 1 Oct 2025
 06:44:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 2/3] intel_iommu: Simplify caching mode check with VFIO
 device
Thread-Topic: [PATCH v2 2/3] intel_iommu: Simplify caching mode check with
 VFIO device
Thread-Index: AQHcMPMlbIURbu3yUEOzgyjh0tCzzrSs27EA
Date: Wed, 1 Oct 2025 06:44:55 +0000
Message-ID: <a9a033d5a5422da97e808277b0400bd65466dbcf.camel@eviden.com>
References: <20250929034206.439266-1-zhenzhong.duan@intel.com>
 <20250929034206.439266-3-zhenzhong.duan@intel.com>
In-Reply-To: <20250929034206.439266-3-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7182:EE_
x-ms-office365-filtering-correlation-id: e7bad5a1-dded-485a-66a2-08de00b60814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UC9mdTVJTzUrYm5ScHZXV3hUZmxEbGx2UEIrQ3FiVHVxVnVWeVZFdEt1dHNq?=
 =?utf-8?B?UTd2c3hSRHpNS25FQ3p4MGUxa2kyM2RLTC9LUVZkTHh0VzlmSy9sVzZhc1Qz?=
 =?utf-8?B?dUNXOExGRU5sOVdybXJXdE5Ta1huTXM0MWpKQWVvK2dHcExudjRoa3hLWkp2?=
 =?utf-8?B?RWdCMTRjaGY1aitZL3ZmSEFzSWc2Z21RZlFaT2k4dlZud2t5dVE3TCtnbDhM?=
 =?utf-8?B?UGZqQjEvWmU5RXpjd09lbTgvSE5WcEUxZTJRaGRZK3JKZlFYQityQkN3Yjlx?=
 =?utf-8?B?WVF6dmh1eGFVVm81elpBamJJdGkzdW5tei9MeWtFVEJJU3hVOFpnU3U2alpU?=
 =?utf-8?B?WG04aHRpeGVtcDlBS2dYQ1IrVzhQMlQ3ZkdLRjdIbTRQbjRpeEZDRExXUWwx?=
 =?utf-8?B?US9OTU1GK1EyYmNkcjhBTktYU3ZUY05DbWduM0QzVDNnVHVxT1d0WFI2RUwr?=
 =?utf-8?B?c3R0L2F0S2RvaGQvZXM2NEFCYUdZY2xwL2NFczh6RDBNcVhZQzh3UHlWcFhR?=
 =?utf-8?B?bmlTVFdQcytCM0FTN09STnZMN1piZUNBc2hEUUZFMXZ4MnduOUVvMVpycE9O?=
 =?utf-8?B?czhmY1RjZnBQTHlkekRTcTJuK0RKU2pkZklDK0poak9jU2hiWDZJREY0QUVL?=
 =?utf-8?B?ZTJ4dHI3Ry9mOTdBMjNzV0swcUkyNlJQYWN4WmRVVzh3UlRXdFYyRXNJajVY?=
 =?utf-8?B?NTFVRHArSTBNZ3JrbldmNER6WUJ0bFJOWUZhY21RRVlsZ0JkM0JEdXJURHRU?=
 =?utf-8?B?Ulh5d3NDV1N2N1JsZ3R2ZHpDQktVdWh3dE5uK3JEZExuWjZUaWJzcCtJQVhO?=
 =?utf-8?B?NXIydkhyMTFpSCtMVW1qRU5tcCsxRGNnanhmTGJPZE9yRXk0K1gvZWFWblNv?=
 =?utf-8?B?ZkZYd2RaMTVpcGp6TEpGbnRHbW1XOExkQVdrZVpTWFlidTVPR2l0bnpnbjhl?=
 =?utf-8?B?NjA2cG8zNFU4dEZXcUo2RHdsd00vREJYOWs1VmpxNTk3UnZlVDlkbHpBWmZa?=
 =?utf-8?B?SEZzMTN6QkFqTHZCTXVzdG5ZZjV0YythUzdrMWxGQVNBOXVQMjA2eEVaa0tV?=
 =?utf-8?B?N0NZWXdNbFYzdDcybStYTVgycGtyUkJoVjhTT2VPOVZrcXNoeitDL21wTG5i?=
 =?utf-8?B?TEpkOE9PQyt1TXhueWFYRTlNcW9FdjNhcG8zQzcyMklYd3lEL2NWS0VZR2xy?=
 =?utf-8?B?Z1VTc05VdXB0b1dFcWYxbFVnNGN4ZEJkZGZDNFZJejI4dm15RUNsNjU1bnZL?=
 =?utf-8?B?SUNRSXY5MGdkTDhxUlhRRE5WZ0w3Wmk5NFRrdE4vemExRmdJc2pFQlpQWk50?=
 =?utf-8?B?MGFlNjlBZkNNa1Q0eVhUN1N3UHlYNXkxeWIxM00yVHJabjJFaHVEKzNsaXZN?=
 =?utf-8?B?TWpSaUJOR3Y4dU9BamQ4VmI5ems3SmlNRFRhamlrV01PQU1QQ2JkZS9OSW9m?=
 =?utf-8?B?UVNua3pFSFU2QlMzREpMN3ZBTGRZRnFKSVNUTElqRHYvOXJkSjAvVndBMk15?=
 =?utf-8?B?NUtVYkV3TGJ4ZkwxaDJhOWlheHU0K0dXbXdEMTRpUWlpVUI5K1JOcEhGT25D?=
 =?utf-8?B?azRFMzl1VzdicHFFZHlobWkwaFEzRVZVVG1nN2Z6Z2phMjBYVEl2L2k3VE9r?=
 =?utf-8?B?ZzZnRVc2aERHM3ZvVDhDZXQrS1dwUFVPWGJsZXVITU9yMXFBUHlPVmJwS3gv?=
 =?utf-8?B?RTdYQmpCS2Uxa0hwOVEraGZJcEZNZ0tXUHkzNjdTVWhOem02WDN6YVorU01w?=
 =?utf-8?B?ZnNycTdGOW9PTWFZSktWV0dpR0FrbDdoRmlGeUZaL0wyVkwrZzRhc1F0QXJX?=
 =?utf-8?B?UFBGdnJId0l2NGUxV041QVQxNERVcm9DT0ptMERVNUNZLy9qZ0FDazJ3c0Js?=
 =?utf-8?B?R0lwZDBtMm5scXlpQzNrVEtjR2cxRGpKSlpXZlN3Nm5ra2tqekV4UUdxRno2?=
 =?utf-8?B?Nm9ISWxmZVg2R3dCVUlPU2FRM3hqSmNsdWppWlRhYnpDdUJxaUFodU5WaTg3?=
 =?utf-8?B?cWN3UThSSVNjZEE0RGJReW52OHVpdEo3N2RrYVVhbzJrNXduTU9oNHFsR2xp?=
 =?utf-8?Q?inGn1L?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHpnWk51M2l3YlEyNm1oQVBsbmZHNXloczQ3dFJVcWpFa2M2cVl4MWF0cEhK?=
 =?utf-8?B?aC9hWXROYThYSmJFSmZXdkZqejIyZVV2Q3RuR1JhcGk2TllFajFmbE4ramcy?=
 =?utf-8?B?THcxVGtSckY2LzVoaU9PZGFaMHJycjZYTkE3Vmt6SGRsaGJuMFNkOTNiOXR5?=
 =?utf-8?B?NU5FLzdaZ2E1Smd6dm9mMm5vNDlMTGhaU0Y3UUlrdUxGZjE3aWFOMUY4NGc4?=
 =?utf-8?B?YmgrZHoyOVgrQ3Z4UG84K1VBcm5nQWVaWmoyNVAvNFpVQ24xcTBkWWxtRDlZ?=
 =?utf-8?B?dXlmUHI1NHo5c2tsdm1SLzdiZjE2OTdvWEZRV0IrNGtwQXMyT2dqZlNEb2Rv?=
 =?utf-8?B?VWdSaVFnd1NkT0U3cWgyUklCcVA3Q3FaVzdDTCtTeWxseFpkNEFMelYwUFZo?=
 =?utf-8?B?eGd3ZUdzVGxvbm1Jbjd6bzRCZkY0SmR1VFhLRFFzTzVXaU1JV0M2eFVRNXJ2?=
 =?utf-8?B?ZDhwalVXd3EwNHY1emxZTXJOeVAxNHZ2WHVKTjcxdVVVeHFNNEpSdm9hMzZy?=
 =?utf-8?B?VDdnTkJJUXNpRkdMcE9IU3lkSWdQUXl4Ny9NamY0eGR0RHBYTWZPWHY1S296?=
 =?utf-8?B?bWRIY1FKeWNjQmh2Tnd2bFBXMmFIM05ET3gyNUV6V2dhdmN3YUtIRWRiZ2lv?=
 =?utf-8?B?ajFQSWRPeGJ1ekRvcjFrdnRxeVJEUDVHbmd0WFBvV01XVFRSQzdTb2xPaEZm?=
 =?utf-8?B?dFZFbzFRUFRCNmFxbXBFcWJQTHZIWktMM0xVYzBxU2FLZWhubUN5TDNCREJK?=
 =?utf-8?B?RHh0Q0Nkb3FxRjN0SzlKZWQ1U1VtV0VGQXJ2bXJCOTBZaVNpVTFhY3E5TWxw?=
 =?utf-8?B?NjVTNXBIQzVxWnFGUHgwS290Rk1ZM0RIeHJGYnowZmlxL0RoL2h6WElxZ0xB?=
 =?utf-8?B?OWMwbU15SEJBNlQzck5JNXN1U0pKOWlSdzRmZll0SzU0UDR1TGxkck9YL1NW?=
 =?utf-8?B?U1dGTkFYN0diMDBoZGhtYlF1eUVIUS93eG0rUjFJa2s0NmJEU0E5MDlBSmRK?=
 =?utf-8?B?TFlWam9HOVNiLzAxalJvN2xmaDAxM2RoWFM4RWJXV3JoT0VEc2xhNndnN1Z6?=
 =?utf-8?B?ZHNSZnlqSHJEQm10OVBIcUg3TEJVVG1SOEs3QWxZUDYyOVlxUlNoa3U3MFpG?=
 =?utf-8?B?SzdFaUVTdGo3NlVlVElYZ1FDU1ZGMU9nemRyU1JueXc0TzNDbmxKcDhjYzFm?=
 =?utf-8?B?V0I3azN5a1pZYWErZFQzQ1BjT1VoMjR6YnBkalpXMWRGdmZwYkZQWWc0bFlI?=
 =?utf-8?B?VGFSVUIxcC9obDdDNVIzM0pnamtLQWErZElNMkVHb2NzdWJPUkVNK01NQU8r?=
 =?utf-8?B?aE5Rc3piWXVmdzJjQlo5czQyVVl0VlpiTUl4d1luazREdkRBTlYwTUcxRTk4?=
 =?utf-8?B?RC9oSzFENnRwQkNRbVNPelNldS9CMzhjOSs1MXpCL3VXVURMKzRNckE1Z1Vv?=
 =?utf-8?B?VlRVYkRqSDFJYmZmcFRWK21aeFdieG1MNkMwZU52MzI4cDVlSjNLZHMyZGlG?=
 =?utf-8?B?R3ZBRWFGWG5yUVQ4dWVIYy9LeHN3c3NpVnl5MHpWR3Bza2VrbHhYOXVKaHNr?=
 =?utf-8?B?VWFWSFlMS0VMa2ZGUXNWeEVKeEpUanB1Wm1yS2dWa1A2clVJL1YwWWRQemg0?=
 =?utf-8?B?RUlqUk4yR2Z4Y1lRZzF0N2Q3Wkp4YThWc0p2NFkwZEJMTmMzbEptcEJpMzBr?=
 =?utf-8?B?d0pkQzhZaGk4R204ZWZXczFQcW5CQjJBRlFKbmhXQTNkUzFWSU5HTHJSRzI1?=
 =?utf-8?B?by80TlUxeVhGM3B6a2VvdUkyNk5OaEc3U3JSL1VUV2Z0WFYxWkxZK1lqNTB3?=
 =?utf-8?B?YlR5d1BEQXhqVlpjVy9yNlJWZU9Ha1MvZSt2bUxoZlBtMXJZUVdmeHFDTC9m?=
 =?utf-8?B?U1ZNb0hDdVlodmZzVjhjbGoyRXJOd0J0RVhNRnd6Q1ArRDU5T0lCVzFEVlJT?=
 =?utf-8?B?Rk80WVFPVkxJODVMbGc4OHhZS1lMMEZIUXROTTJIN3lNTTl3bTRJOXU1dzJG?=
 =?utf-8?B?NWZBTzhaNm83czk0VnJkZlBKbTJUNjM5cUtHcEdWSEkyb3JnUjZmeXFHZFUw?=
 =?utf-8?B?dlpJNG5DNXlLbnN1TnNtQnhNeUN4b055OWRVRXpnYi9MajlzdmpYQUpPZENV?=
 =?utf-8?B?bEd4WWFsRnpKeTdOMDVJdm84NWFSTjh2YVRJdVNkWlh2bkVtQnlHa2Y3dk13?=
 =?utf-8?Q?2pQfFukobA4lQ7XwySYHq7k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCB746A08FDD1B4B9C2EBDD05DD7E715@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bad5a1-dded-485a-66a2-08de00b60814
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 06:44:55.2208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWdYEcEgYT3pM3v+Eq4250bIF/qBTE5JMuJA8xp00Oy4pkRe0IRKGFr5Pfk61f25I3Va20wTQjSLFRbiBL+PsyuUj50p5RC6UjRZ8kpWMDYUdpL5aDD2qfy/n37MCwKl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7182
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgemhlbnpob25nLA0KDQpUaGFua3MgZm9yIHRoZSByZXNwaW4uICANCkp1c3QgYSBmZXcgY29t
bWVudHMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpPbiBTdW4sIDIwMjUtMDktMjggYXQgMjM6
NDIgLTA0MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBJbiBlYXJseSBkYXlzLCB3ZSBoYXZl
IGRpZmZlcmVudCB0cmlja3MgdG8gZW5zdXJlIGNhY2hpbmctbW9kZT1vbiB3aXRoIFZGSU8gIA0K
DQpzL2hhdmUvaGFkDQoNCj4gZGV2aWNlOg0KPiANCj4gMjhjZjU1M2FmZSAoImludGVsX2lvbW11
OiBTYW5pdHkgY2hlY2sgdmZpby1wY2kgY29uZmlnIG9uIG1hY2hpbmUgaW5pdCBkb25lIikgIA0K
PiBjNmNiYzI5ZDM2ICgicGMvcTM1OiBEaXNhbGxvdyB2ZmlvLXBjaSBob3RwbHVnIHdpdGhvdXQg
VlQtZCBjYWNoaW5nIG1vZGUiKQ0KPiANCj4gVGhlcmUgaXMgYWxzbyBhIHBhdGNoIG9mIHNhbWUg
cHVycG9zZSBidXQgZm9yIFZEUEEgZGV2aWNlOg0KDQpzL29mIHNhbWUvd2l0aCB0aGUgc2FtZQ0K
DQo+IA0KPiBiOGQ3ODI3N2MwICgiaW50ZWwtaW9tbXU6IGZhaWwgTUFQIG5vdGlmaWVyIHdpdGhv
dXQgY2FjaGluZyBtb2RlIikNCj4gDQo+IEJlY2F1c2Ugd2l0aG91dCBjYWNoaW5nIG1vZGUsIE1B
UCBub3RpZmllciB3b24ndCB3b3JrIGNvcnJlY3RseSBzaW5jZSBndWVzdCAgDQo+IHdvbid0IHNl
bmQgSU9UTEIgdXBkYXRlIGV2ZW50IHdoZW4gaXQgZXN0YWJsaXNoZXMgbmV3IG1hcHBpbmdzIGlu
IHRoZSBJL08gcGFnZSAgDQo+IHRhYmxlcy4NCj4gDQo+IE5vdyB3aXRoIGhvc3QgSU9NTVUgZGV2
aWNlIGludGVyZmFjZSBiZXR3ZWVuIFZGSU8gYW5kIHZJT01NVSwgd2UgY2FuIHNpbXBsaWZ5ICAN
Cj4gZmlyc3QgdHdvIGNvbW1pdHMgYWJvdmUgd2l0aCBhIHNtYWxsIGNoZWNrIGluIHNldF9pb21t
dV9kZXZpY2UoKS4gVGhpcyBhbHNvICANCj4gd29ya3MgZm9yIGZ1dHVyZSBJT01NVUZEIGJhY2tl
ZCBWRFBBIGltcGxlbWVudGF0aW9uIHdoaWNoIG1heSBhbHNvIG5lZWQgY2FjaGluZyAgDQo+IG1v
ZGUgb24uIEJ1dCBmb3IgbGVnYWN5IFZEUEEgd2Ugc3RpbGwgbmVlZCBjb21taXQgYjhkNzgyNzdj
MCBhcyBpdCBkb2Vzbid0ICANCj4gdXNlIGhvc3QgSU9NTVUgZGV2aWNlIGludGVyZmFjZS4NCg0K
cy91c2UgaG9zdC91c2UgdGhlIGhvc3QNCg0KPiANCj4gRm9yIGNvbGRwbHVnIFZGSU8gZGV2aWNl
Og0KPiANCj4gwqAgcWVtdS1zeXN0ZW0teDg2XzY0OiAtZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAw
MDozYjowMC4wLGlkPWhvc3RkZXYzLGJ1cz1yb290MCxpb21tdWZkPWlvbW11ZmQwOiB2ZmlvIDAw
MDA6M2I6MDAuMDogRmFpbGVkIHRvIHNldCB2SU9NTVU6IERldmljZSBhc3NpZ25tZW50IGlzIG5v
dCBhbGxvd2VkIHdpdGhvdXQgZW5hYmxpbmcgY2FjaGluZy1tb2RlPW9uIGZvciBJbnRlbCBJT01N
VS4NCj4gDQo+IEZvciBob3RwbHVnIFZGSU8gZGV2aWNlOg0KPiANCj4gwqAgaWYgImlvbW11PW9m
ZiIgaXMgY29uZmlndXJlZCBpbiBndWVzdCwgIA0KPiDCoMKgwqAgRXJyb3I6IHZmaW8gMDAwMDoz
YjowMC4wOiBGYWlsZWQgdG8gc2V0IHZJT01NVTogRGV2aWNlIGFzc2lnbm1lbnQgaXMgbm90IGFs
bG93ZWQgd2l0aG91dCBlbmFibGluZyBjYWNoaW5nLW1vZGU9b24gZm9yIEludGVsIElPTU1VLiAg
DQo+IMKgIGVsc2UgIA0KPiDCoMKgwqAgRXJyb3I6IHZmaW8gMDAwMDozYjowMC4wOiBtZW1vcnkg
bGlzdGVuZXIgaW5pdGlhbGl6YXRpb24gZmFpbGVkOiBSZWdpb24gdnRkLTAwLjAtZG1hcjogZGV2
aWNlIDAxLjAwLjAgcmVxdWlyZXMgY2FjaGluZyBtb2RlOiBPcGVyYXRpb24gbm90IHN1cHBvcnRl
ZA0KPiANCj4gVGhlIHNwZWNpYWx0eSBmb3IgaG90cGx1ZyBpcyBkdWUgdG8gdGhlIGNoZWNrIGlu
IGNvbW1pdCBiOGQ3ODI3N2MwIGhhcHBlbiBiZWZvcmUgIA0KPiB0aGUgY2hlY2sgaW4gc2V0X2lv
bW11X2RldmljZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDxbemhlbnpo
b25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4gIA0K
PiAtLS0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDQwICsrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gIA0KPiDCoGh3L2kzODYvcGMuY8KgwqDCoMKgwqDCoMKg
wqDCoCB8IDIwIC0tLS0tLS0tLS0tLS0tLS0tLS0tICANCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgNTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jICANCj4gaW5kZXggZjA0MzAw
MDIyZS4uYzYzNDEyMTUxNCAxMDA2NDQgIA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMg
IA0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMgIA0KPiBAQCAtODUsMTMgKzg1LDYgQEAg
c3RydWN0IHZ0ZF9pb3RsYl9rZXkgeyAgDQo+IMKgc3RhdGljIHZvaWQgdnRkX2FkZHJlc3Nfc3Bh
Y2VfcmVmcmVzaF9hbGwoSW50ZWxJT01NVVN0YXRlICpzKTsgIA0KPiDCoHN0YXRpYyB2b2lkIHZ0
ZF9hZGRyZXNzX3NwYWNlX3VubWFwKFZUREFkZHJlc3NTcGFjZSAqYXMsIElPTU1VTm90aWZpZXIg
Km4pOyAgDQo+IMKgICANCj4gLXN0YXRpYyB2b2lkIHZ0ZF9wYW5pY19yZXF1aXJlX2NhY2hpbmdf
bW9kZSh2b2lkKSAgDQo+IC17ICANCj4gLcKgwqDCoCBlcnJvcl9yZXBvcnQoIldlIG5lZWQgdG8g
c2V0IGNhY2hpbmctbW9kZT1vbiBmb3IgaW50ZWwtaW9tbXUgdG8gZW5hYmxlICIgIA0KPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImRldmljZSBhc3NpZ25tZW50IHdpdGggSU9N
TVUgcHJvdGVjdGlvbi4iKTsgIA0KPiAtwqDCoMKgIGV4aXQoMSk7ICANCj4gLX0gIA0KPiAtICAN
Cj4gwqBzdGF0aWMgdm9pZCB2dGRfZGVmaW5lX3F1YWQoSW50ZWxJT01NVVN0YXRlICpzLCBod2Fk
ZHIgYWRkciwgdWludDY0X3QgdmFsLCAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IHdtYXNrLCB1aW50NjRfdCB3MWNt
YXNrKSAgDQo+IMKgeyAgDQo+IEBAIC00Mzc4LDYgKzQzNzEsMTIgQEAgc3RhdGljIGJvb2wgdnRk
X2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZm
biwgIA0KPiDCoCAgDQo+IMKgwqDCoMKgIGFzc2VydChoaW9kKTsgIA0KPiDCoCAgDQo+ICvCoMKg
wqAgaWYgKCFzLT5jYWNoaW5nX21vZGUpIHsgIA0KPiArwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0
ZyhlcnJwLCAiRGV2aWNlIGFzc2lnbm1lbnQgaXMgbm90IGFsbG93ZWQgd2l0aG91dCBlbmFibGlu
ZyAiICANCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiY2FjaGluZy1t
b2RlPW9uIGZvciBJbnRlbCBJT01NVS4iKTsgIA0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZh
bHNlOyAgDQo+ICvCoMKgwqAgfSAgDQo+ICsgIA0KPiDCoMKgwqDCoCB2dGRfaW9tbXVfbG9jayhz
KTsgIA0KPiDCoCAgDQo+IMKgwqDCoMKgIGlmIChnX2hhc2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9o
b3N0X2lvbW11X2RldiwgJmtleSkpIHsgIA0KPiBAQCAtNDkxMCwzMiArNDkwOSw2IEBAIHN0YXRp
YyBib29sIHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZSAqcywgRXJyb3IgKiplcnJw
KSAgDQo+IMKgwqDCoMKgIHJldHVybiB0cnVlOyAgDQo+IMKgfSAgDQo+IMKgICANCj4gLXN0YXRp
YyBpbnQgdnRkX21hY2hpbmVfZG9uZV9ub3RpZnlfb25lKE9iamVjdCAqY2hpbGQsIHZvaWQgKnVu
dXNlZCkgIA0KPiAteyAgDQo+IC3CoMKgwqAgSW50ZWxJT01NVVN0YXRlICppb21tdSA9IElOVEVM
X0lPTU1VX0RFVklDRSh4ODZfaW9tbXVfZ2V0X2RlZmF1bHQoKSk7ICANCj4gLSAgDQo+IC3CoMKg
wqAgLyogIA0KPiAtwqDCoMKgwqAgKiBXZSBoYXJkLWNvZGVkIGhlcmUgYmVjYXVzZSB2ZmlvLXBj
aSBpcyB0aGUgb25seSBzcGVjaWFsIGNhc2UgIA0KPiAtwqDCoMKgwqAgKiBoZXJlLsKgIExldCdz
IGJlIG1vcmUgZWxlZ2FudCBpbiB0aGUgZnV0dXJlIHdoZW4gd2UgY2FuLCBidXQgc28gIA0KPiAt
wqDCoMKgwqAgKiBmYXIgdGhlcmUgc2VlbXMgdG8gYmUgbm8gYmV0dGVyIHdheS4gIA0KPiAtwqDC
oMKgwqAgKi8gIA0KPiAtwqDCoMKgIGlmIChvYmplY3RfZHluYW1pY19jYXN0KGNoaWxkLCAidmZp
by1wY2kiKSAmJiAhaW9tbXUtPmNhY2hpbmdfbW9kZSkgeyAgDQo+IC3CoMKgwqDCoMKgwqDCoCB2
dGRfcGFuaWNfcmVxdWlyZV9jYWNoaW5nX21vZGUoKTsgIA0KPiAtwqDCoMKgIH0gIA0KPiAtICAN
Cj4gLcKgwqDCoCByZXR1cm4gMDsgIA0KPiAtfSAgDQo+IC0gIA0KPiAtc3RhdGljIHZvaWQgdnRk
X21hY2hpbmVfZG9uZV9ob29rKE5vdGlmaWVyICpub3RpZmllciwgdm9pZCAqdW51c2VkKSAgDQo+
IC17ICANCj4gLcKgwqDCoCBvYmplY3RfY2hpbGRfZm9yZWFjaF9yZWN1cnNpdmUob2JqZWN0X2dl
dF9yb290KCksICANCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9tYWNoaW5lX2RvbmVfbm90aWZ5X29uZSwg
TlVMTCk7ICANCj4gLX0gIA0KPiAtICANCj4gLXN0YXRpYyBOb3RpZmllciB2dGRfbWFjaGluZV9k
b25lX25vdGlmeSA9IHsgIA0KPiAtwqDCoMKgIC5ub3RpZnkgPSB2dGRfbWFjaGluZV9kb25lX2hv
b2ssICANCj4gLX07ICANCj4gLSAgDQo+IMKgc3RhdGljIHZvaWQgdnRkX3JlYWxpemUoRGV2aWNl
U3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKSAgDQo+IMKgeyAgDQo+IMKgwqDCoMKgIE1hY2hpbmVT
dGF0ZSAqbXMgPSBNQUNISU5FKHFkZXZfZ2V0X21hY2hpbmUoKSk7ICANCj4gQEAgLTQ5OTAsNyAr
NDk2Myw2IEBAIHN0YXRpYyB2b2lkIHZ0ZF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9y
ICoqZXJycCkgIA0KPiDCoMKgwqDCoCBwY2lfc2V0dXBfaW9tbXUoYnVzLCAmdnRkX2lvbW11X29w
cywgZGV2KTsgIA0KPiDCoMKgwqDCoCAvKiBQc2V1ZG8gYWRkcmVzcyBzcGFjZSB1bmRlciByb290
IFBDSSBidXMuICovICANCj4gwqDCoMKgwqAgeDg2bXMtPmlvYXBpY19hcyA9IHZ0ZF9ob3N0X2Rt
YV9pb21tdShidXMsIHMsIFEzNV9QU0VVRE9fREVWRk5fSU9BUElDKTsgIA0KPiAtwqDCoMKgIHFl
bXVfYWRkX21hY2hpbmVfaW5pdF9kb25lX25vdGlmaWVyKCZ2dGRfbWFjaGluZV9kb25lX25vdGlm
eSk7ICANCj4gwqB9ICANCj4gwqAgIA0KPiDCoHN0YXRpYyB2b2lkIHZ0ZF9jbGFzc19pbml0KE9i
amVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkgIA0KPiBkaWZmIC0tZ2l0IGEvaHcv
aTM4Ni9wYy5jIGIvaHcvaTM4Ni9wYy5jICANCj4gaW5kZXggYmMwNDhhNmQxMy4uMDFjZDlhNjdk
YiAxMDA2NDQgIA0KPiAtLS0gYS9ody9pMzg2L3BjLmMgIA0KPiArKysgYi9ody9pMzg2L3BjLmMg
IA0KPiBAQCAtMTcyMCwyNSArMTcyMCw2IEBAIHN0YXRpYyB2b2lkIHBjX21hY2hpbmVfd2FrZXVw
KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkgIA0KPiDCoMKgwqDCoCBjcHVfc3luY2hyb25pemVfYWxs
X3Bvc3RfcmVzZXQoKTsgIA0KPiDCoH0gIA0KPiDCoCAgDQo+IC1zdGF0aWMgYm9vbCBwY19ob3Rw
bHVnX2FsbG93ZWQoTWFjaGluZVN0YXRlICptcywgRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKipl
cnJwKSAgDQo+IC17ICANCj4gLcKgwqDCoCBYODZJT01NVVN0YXRlICppb21tdSA9IHg4Nl9pb21t
dV9nZXRfZGVmYXVsdCgpOyAgDQo+IC3CoMKgwqAgSW50ZWxJT01NVVN0YXRlICppbnRlbF9pb21t
dTsgIA0KPiAtICANCj4gLcKgwqDCoCBpZiAoaW9tbXUgJiYgIA0KPiAtwqDCoMKgwqDCoMKgwqAg
b2JqZWN0X2R5bmFtaWNfY2FzdCgoT2JqZWN0ICopaW9tbXUsIFRZUEVfSU5URUxfSU9NTVVfREVW
SUNFKSAmJiAgDQo+IC3CoMKgwqDCoMKgwqDCoCBvYmplY3RfZHluYW1pY19jYXN0KChPYmplY3Qg
KilkZXYsICJ2ZmlvLXBjaSIpKSB7ICANCj4gLcKgwqDCoMKgwqDCoMKgIGludGVsX2lvbW11ID0g
SU5URUxfSU9NTVVfREVWSUNFKGlvbW11KTsgIA0KPiAtwqDCoMKgwqDCoMKgwqAgaWYgKCFpbnRl
bF9pb21tdS0+Y2FjaGluZ19tb2RlKSB7ICANCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJy
b3Jfc2V0ZyhlcnJwLCAiRGV2aWNlIGFzc2lnbm1lbnQgaXMgbm90IGFsbG93ZWQgd2l0aG91dCAi
ICANCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJlbmFi
bGluZyBjYWNoaW5nLW1vZGU9b24gZm9yIEludGVsIElPTU1VLiIpOyAgDQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsgIA0KPiAtwqDCoMKgwqDCoMKgwqAgfSAgDQo+IC3C
oMKgwqAgfSAgDQo+IC0gIA0KPiAtwqDCoMKgIHJldHVybiB0cnVlOyAgDQo+IC19ICANCj4gLSAg
DQo+IMKgc3RhdGljIHZvaWQgcGNfbWFjaGluZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywg
Y29uc3Qgdm9pZCAqZGF0YSkgIA0KPiDCoHsgIA0KPiDCoMKgwqDCoCBNYWNoaW5lQ2xhc3MgKm1j
ID0gTUFDSElORV9DTEFTUyhvYyk7ICANCj4gQEAgLTE3NTgsNyArMTczOSw2IEBAIHN0YXRpYyB2
b2lkIHBjX21hY2hpbmVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRh
dGEpICANCj4gwqDCoMKgwqAgeDg2bWMtPmFwaWNfeHJ1cHRfb3ZlcnJpZGUgPSB0cnVlOyAgDQo+
IMKgwqDCoMKgIGFzc2VydCghbWMtPmdldF9ob3RwbHVnX2hhbmRsZXIpOyAgDQo+IMKgwqDCoMKg
IG1jLT5nZXRfaG90cGx1Z19oYW5kbGVyID0gcGNfZ2V0X2hvdHBsdWdfaGFuZGxlcjsgIA0KPiAt
wqDCoMKgIG1jLT5ob3RwbHVnX2FsbG93ZWQgPSBwY19ob3RwbHVnX2FsbG93ZWQ7ICANCj4gwqDC
oMKgwqAgbWMtPmF1dG9fZW5hYmxlX251bWFfd2l0aF9tZW1ocCA9IHRydWU7ICANCj4gwqDCoMKg
wqAgbWMtPmF1dG9fZW5hYmxlX251bWFfd2l0aF9tZW1kZXYgPSB0cnVlOyAgDQo+IMKgwqDCoMKg
IG1jLT5oYXNfaG90cGx1Z2dhYmxlX2NwdXMgPSB0cnVlOw==

