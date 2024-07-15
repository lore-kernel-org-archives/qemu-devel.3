Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C49C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHPG-0006Q9-E2; Mon, 15 Jul 2024 04:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sTHPD-0006Gk-R5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:49:59 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sTHPB-0004et-Ig
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721033398; x=1752569398;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=E/Zj2nXXC9KELGGto0o54+INJ1nf4RUpc11GwMLnSMI=;
 b=nKDx0aRr36gL7knCQiUFZrdAyV0tGl/maCjU7NGqYNKP8i6cquMYUfix
 LLwiZkcg0qY1UMfUSFOxMVot9DPXOUxUDZErO7fIoPaPfSwFyXxcw7P8x
 7wg6PlZ3S3LFTtbTkNhPQHjCHl5sDMqqwRK8D5eOhaC5y3+0n9qprfJsa
 64hBG4lQe4Dr0MFyN9d4yt2EPJUCcUMoKbELQmk9e5BuKjoJCPOyCkRqa
 ZQ1EN8OHvN8wSppi6jW+2PWMqbFH/up8u1dF49NIDCLpXYc1Tglp55bIe
 X71JYS/Xc87SznPkEK0mbZCKI0KIpDTcDulRFLzVbqr+lKzo04BUuKunq A==;
X-IronPort-AV: E=Sophos;i="6.09,209,1716242400"; d="scan'208";a="16489824"
X-MGA-submission: =?us-ascii?q?MDG86+4vkqKYvan35B05b6Wapx8Ts3P3U2m1Wr?=
 =?us-ascii?q?RiSpoR1ENEg1dILh5wpleHAWtD/HaCq5i0UEKV0dkKRvlARsFogYjwgY?=
 =?us-ascii?q?wPPMRC+3/FQGdY40B/Pa0GdLpXacWZiMSKdEW418Q0afF29Wdm/AbpNI?=
 =?us-ascii?q?7vK7ZZgq7BIRDpNd/pdnErOg=3D=3D?=
Received: from mail-am6eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.106])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 10:48:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3voZGKEQmQOj5OJ/NO3Rr7oUoHeutqMIaOmVLKKsIPmtWxaQtPFLfQP53bcOxLKvQvKOBArqZU0wcArEZ8PnMnjymuL/1qUCFSwemfwyTaq3dXPQ+VKGBjDAU/GX+92I5z6oB92Rl/+vVSSQD975FqJJ9YeSJcrIOL3TUN4arYuOZgfUSdXIT2jRPg6mjxtIQ77o8SULoKxw9PKfuFbAWOFZ0D9y2orKHMSlpcKfyEu4BhWk293gtIs/0y1LUwUZHJY8YyIfWBQ/mkngi7dZ8ctE8gy3Vciy2QG03w0xlas0aqvVvcmNdwHdGtDqEKVt1J+W63/olDWsI0ImU5vUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/Zj2nXXC9KELGGto0o54+INJ1nf4RUpc11GwMLnSMI=;
 b=loCH0eoV6wkXYREM6Np7KWYeKOSL89fE4DWma873b8U3oKbaP6/SWveNrDP/liDVeWJmkTZN37YjteKg5DV6Bh5adwpJIUcz0F3UJTRs+WumVLvZNFWMegY7CxCU/tWY+UecWQ9vLl2ZCrcBru2M3lc4MKEdNrysu3Cqw0hkYn6FlxtEo2TQH9+dXbV0FqKs2MEZjsEUCIOgwaE2HnHUxlaqb5vgSZfnrXEqXQ3499heJO1HeXj5sMborIFXRAhPxBhj4aue+awjIv+PKGk71CKZXHEUtmBZqlBU+N68IqwS9yUgJ9y1igmvWwG1O94g/scCQwN5EOEf52LytwNCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/Zj2nXXC9KELGGto0o54+INJ1nf4RUpc11GwMLnSMI=;
 b=l6QDbjiGF4Ai+xswUl1WO/J8REz8KZc5bbc5SJtCfBACE6eyrHZlQLjLFElBHqcKnW5RRa4MxiP17mwUPmdJPTc5PJTPr8xyEuAMepmPR03Kax6i2BejnHt6GaUOfyUQ7kZjZS8dvcgoPovL9XdKgkZmh6AnsepmoHCaCozVYFpR4qM1ejfST25+IYiWElQMd0uafIdbdN3bMpTGnHP9eNGvqo/XpRsLs2O+IO+UJ+/kq9HH4fVVbM1J2PE4Nlx4+UdLpek6HTLA+2apcC5UTCVOj8usECRib7TEugtfcSjhKx7vVqtaWKPxkCEIDJoCl+pbWVpmmckZuFRIU8eAEg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7302.eurprd07.prod.outlook.com (2603:10a6:20b:256::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13; Mon, 15 Jul
 2024 08:48:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.013; Mon, 15 Jul 2024
 08:48:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v7 0/4] VT-d minor fixes
Thread-Topic: [PATCH v7 0/4] VT-d minor fixes
Thread-Index: AQHa0gvviOR0C7Mtb0uxee8sx3GKOrH3g4mA
Date: Mon, 15 Jul 2024 08:48:52 +0000
Message-ID: <83110d22-6046-425e-8e4d-aa408f998d0b@eviden.com>
References: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7302:EE_
x-ms-office365-filtering-correlation-id: 14d79864-d487-4f59-d667-08dca4aaf3ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWdVUGN2ZEJuVW9GVGhOWXNvRElMMTJoWVE3VkJZQ1FENXUwZlBlZlZYN3pZ?=
 =?utf-8?B?a2FjbVJVUktjRHh0ZytJNVhtMHJvMzRPdmN5RTlXeklYdExPa0d4QWhlV1R0?=
 =?utf-8?B?ZmVxUjcyWC9pdnhtdjAzbkFhckVuZVpkVkVPbGhsd1VPOE9YVFBwdENXdkNG?=
 =?utf-8?B?bzFrTnpKRkVwQi9BRDB4MGZkbWl4eVJBWW1Zdko3MmRZVVl3Yzd6RFBTSWdY?=
 =?utf-8?B?enBSbjVMdjJMTlZKOXNPTGtjNVVEMm5MS2J5dlpxTGpYS1FuRUdJVDNyZVhn?=
 =?utf-8?B?RHUvUytmSUFQcWZTZ2FWZmdkTkRTcFdhYkQ2QURvaVR5ZUpXSG9QNXJiZ0hL?=
 =?utf-8?B?U2xMOFRyWkJheVhJWE9qL3R6YUNydDVlRFNGK1ZFU1dkOEpKQ1JHNyt2bksx?=
 =?utf-8?B?SHdPdFlKRDJTZEVrMEViYkZLMXE3czFyYktDY3hVUDJNVU9wNDc1dGdlYnVn?=
 =?utf-8?B?SXNRamNKWVhzdkFyZlEyYUszZzlUY05tVFpHZ1hXUmVJZU1SSkN6SzJrWFV5?=
 =?utf-8?B?RXJIbWprMnVYMXF0bWRPUzNRT1Irc0d5VHhwejZlcFVmQWNmUkNwcDN6WVhW?=
 =?utf-8?B?UlJsejd5WHFzZzM1RHd0dU13eExpbkwrY1dENTdrcWVrNzZxSmVMKytGdDhZ?=
 =?utf-8?B?Uy9KWGVrcEVxV0xXdUZhcnhYOXBRdGJuUUlVdnhveVZDS1pKWkM3Q093dDg0?=
 =?utf-8?B?dzJhSTVyMDRMbjJQSXpIMnMwWjM4ZzdLSlRuM2JVeXZYMkQ1ZFg1cWQ0WjRC?=
 =?utf-8?B?NzJQUHJpMHRsOWJ6cmJsMHlyYVprQUZwSVVkeUVuTFdzV1NrK1djSDd2WWtD?=
 =?utf-8?B?bnl4bUkwU2toVHIvMExFMjZyR1NQeVlxQ0hQTFdLNXBVZTY2NkNpTzN3OVkx?=
 =?utf-8?B?WW1abkdGREFPVGY1UisvdXVwaTRUWUlkbi9sajFKTzJwRG5EVmNOemZpREht?=
 =?utf-8?B?MlNWSVk3aWJVWjU2SDM4cnR2cGZpRkRhZEpzZWVYM254eEh0LzBBaHEybXRl?=
 =?utf-8?B?cEowbTNsVXdORll1MURXNFpGL3JyYUFZa0YxTWRrcGtQblZ0RGtVeE1WaXVr?=
 =?utf-8?B?QmppU2t3MTExTW1FQy93bXJSSjhXUGJnNFZqbkFTS1plV3VPVkowZ2ZTZXlp?=
 =?utf-8?B?ZjUrNDZrcCs5NVdTaFdOcEpHODhvcWF3RlU2enFURWpZOEZIWC9YbUxXYm1F?=
 =?utf-8?B?T01LZm5FbURJMiswWjI2M2tDWEtta0VNd3hOREhod21hMEMyb0lXcUJQOVcy?=
 =?utf-8?B?UStUaS9tUnFzQURvVDYwbGZqNTR2eFhaTTVPNEd4OGhBUzNnNkVLNW1CUGgz?=
 =?utf-8?B?S0o3clRlQ2VsRkM1Wm9vVHp2d1hVb3czZGpKMnc0dXQ4ZUgrci9LNkFCZHBJ?=
 =?utf-8?B?eFlrcTVDZ1ZMQTcwQ0pEdjRMZ0JQZmJBR29UNFNmN3JWNkNFdWxjT08rTjdV?=
 =?utf-8?B?ZmE3dWtJNHVEdlROcTNjK1dSMElNQUI2UVVvb2Ywc0dKa2p3cGo3QWlUb09m?=
 =?utf-8?B?b2NHWUNkS2dzbm1BbFBMTExNSzVGSzdQZjRqRWlMRm1HeVRZc0hPN2NHazVV?=
 =?utf-8?B?VnJyWWgzRU4rV1F0K1gwUmozSFZuSUFrRGtWTmxscDhMa3A4eldhTDNZMUVx?=
 =?utf-8?B?bEZjazlNamdINklIcjB2NjhQQldUblQvNVFxSm5pb3JPZ2dtOGp2UU9pMnZB?=
 =?utf-8?B?aGhDOTk4OWUwQ2hjWmFlYnNrSlJ1b0V4anF1ZTFPSzJYRUhCWjNFdkN3Q0xn?=
 =?utf-8?B?SlV2dmtBVVYzVE9aYnVUOXU3c1pHN2xxdE9PLzMrRWtWRTJJeW5Rd1R6S0lT?=
 =?utf-8?B?a2dEY3lFaVAwb1pscUw2aXBpYTlndnBqQlVMQ0JiU0MwMFE1cFhxa3lnUUV4?=
 =?utf-8?B?MDhaYTIxSDNxODRpWldtRVN4cWM2eFJTaW5YajAvN3JDREE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDArVVlaMVd1bmhMRjdpT3pDRUxPUFJmMWVUMklJamc1NFJVdjVmcnBoMVN3?=
 =?utf-8?B?eG9aVlFyMXRyT3hIckFCcnhVVkcxc29MZU9ESldsV2M1ZjBLMTlobFdJOXlQ?=
 =?utf-8?B?YlRnLzRKQmNEdlJOS0xxa0NMMmxVcUJPTFVxTDc5RE5JcFllZFg5cVl6eW9y?=
 =?utf-8?B?THMwWWxIZ3J4SGRUcUFNRTJ5eHh6azZyZ09aN3JrTTE2cHgzN3ZrZ29IYWhi?=
 =?utf-8?B?N2NBM1dXamxodjlmZW1teXBxZzJsRWw5UU9wemxaUzJXZkw0SWZGU3Y0bDVz?=
 =?utf-8?B?VC9NMVQ3eEkwb3NXMTBhSE8wWDc5bkQxNm1OKzVuSnN1MGZjbzZrY3UwaHVt?=
 =?utf-8?B?OUZ3Z2h1U2d4N1VQeVBjSUFCTjhqd2prcytiZ1pUbjZVOHRjVEh4cWsxRmVM?=
 =?utf-8?B?dnprWlZuZ0t6QUdWVWpaOTcyWVZVRGx6MFFnVzRoaXF2TTZqcVVQczMzR1Fx?=
 =?utf-8?B?bzgvd2Nuc0NYb3l2VDcrVGluT0o5N2FTeFZBV0JRU2JweHd6bXBzRE1HSkVv?=
 =?utf-8?B?SG9DSlc2VVpiZk9RcTNwZmR6aGUyK0NBYzdQQm4rWURsSGJSZVoxRWdQd3ZZ?=
 =?utf-8?B?UFl3VWYwTlA3TlVkZG9rZEF4RjZUaVAvanFUMkY0OUhjZVpxdHZ4czI2WGh6?=
 =?utf-8?B?RUZqbHJLWHdMejdLVUt3Sis4enNLOUd5R0lteVhxS0w2dFhteldhTzEyV09w?=
 =?utf-8?B?MHFCd1J0ZkZEMUVZNFN2VEIzalBWSFRpR2pXV3F1RGttalIybGNYb0Fnd0dz?=
 =?utf-8?B?V0NyR2dmNkcvWVJBRHcwTEVJRkQ1WTk3d3pIbUtkSElmV2d0aGNqNUdZMGxq?=
 =?utf-8?B?L1ZtTkJLWjduYVdqTTdMWE1MNEJXVnZ3SW9SR3NnZEJFSys3VXhMWjFqditW?=
 =?utf-8?B?MktPU3JvVUI4bXJiTGFEQmg0cUlybmZ1enJOUVl3dDJ0cURIZVpWekdRcG0r?=
 =?utf-8?B?M2d2YXdYcy85MDJZanZQYzlBWWRzSUxiNzBvdWFDZ2I2M3FiRE03T2wzNmsv?=
 =?utf-8?B?TEhJcFd5NVY5WmpQdThkYlR4Z2l2VGF3UzV5MHV1OGJ0eGFXYWUzbDR2aDFr?=
 =?utf-8?B?aVk2K0VIOXA4ei95dmtiamdhWkVSM3ZXK3Jta3ROdktMQ0t0ODVxaHBaZ1B4?=
 =?utf-8?B?alladXNLVjlzRHFjdlExa1VDTEtvbkRBNmpLMjlJVFZSZ05NMEFLMko5eXNk?=
 =?utf-8?B?YjdGMExlbDQ4NXZoK3cweHBPK2laMncrSWhCMDlueEhaWTB0VEhpWURZVmR2?=
 =?utf-8?B?MU5Ba2ZVUi81T3cwVVdKbUpITVlpRkdPTjVSS0RvU3puM0YyTHZhcmZiQWdm?=
 =?utf-8?B?VFZKL3h4cjBwdGZ5TU9JdFN4dzQ3U1N4WHk1aWQyVkF4Ry9lRmlNNW9INHZz?=
 =?utf-8?B?bUpmTUJybXN6S0xaN29ENFN6VmtoLzRsOU5Ca1JweGNVUTFLVm1zb3UwOTVB?=
 =?utf-8?B?TkZoaStyL2lTSDl0M2pZMXQ0d3FOZlBOaTZzRTNoK3V2VE1NSTJhUzRraUQz?=
 =?utf-8?B?UXltY2FYM0pjdVBCTjJ4NU1rUFJoQ3Q5bFZVeVZwUzB0TmJoL3pmLzlKWVVn?=
 =?utf-8?B?eTRSS3ZseFRwMkkvZWhZS1VONDVKQnRueXB0TnFzVXdmTHE5V3NzdGxBdVFM?=
 =?utf-8?B?Ymh0bmR3U1ZoVVFZQUFHb2pITUw3RXN4aHowT1dFWVNOTkJoL205T2dWSVMr?=
 =?utf-8?B?RGdMT2R2Vmh6UURKTE5ubEx6eFR4UkI4UmlIY3hvYlhOaTZRNmd6TExOeEhl?=
 =?utf-8?B?SzFQMFptNHZIN3NWU1NSVE1qY1NiWWdsTkZtcDc5cjhLYmpqMzZZSTZKQ1V3?=
 =?utf-8?B?S0dXZjF1L0kzeDVBZlFFMDg2dlJVRk44OXRJbWY4emw1dUdGYW9qOHdsRkl3?=
 =?utf-8?B?TzFFY2xFSVlrWTNRd0pvNU9ObXY2QmVrRmRDYm12QzA4MnpGSTEzV21FSnpQ?=
 =?utf-8?B?VFU2cm81Zko4S3JDWjdnRkk5QUFsLzhmMzNwL0s4cmJmUWtJcmFiZjlIT0lv?=
 =?utf-8?B?Vko2MmpSUnJPMnR3OVFGVVZ1VkdSc09PQUloMnVxNjBaT0VCcVY5SGZKTi92?=
 =?utf-8?B?R1YvenFkdDVXa1dGZ0U0dXFxVlBHVysxb1Q0RGF2YThxZjJFKzE4VHBkRnps?=
 =?utf-8?B?TFEyZENCYXE5a3RLSjBXdFNvL1UydjBoRGR4QzcvVElmODU0ZUdzcGJ0VHZW?=
 =?utf-8?Q?zdF11XBXNz1dX2RKND//eNw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <585CCEE1589E1542A214D7653BAB02E0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d79864-d487-4f59-d667-08dca4aaf3ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 08:48:52.1291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaPHr9oojuozRKkZUMsLJUi+EjX+2zZYyK5lRuloThvgDjPwHzKH9tkJ4pKJK/Elt/4PZy4BFoyS1eiAwXSRTE1UzW+SlIgDb8OibgMy2eqR9dCAfBrycVmoiuR3fvuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7302
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

SGkgTWljaGFlbCwgWWkgYW5kIEphc29uDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayBvbiB0
aGUgcHJldmlvdXMgdmVyc2lvbnMuDQpJZiB5b3UgYWdyZWUgd2l0aCB0aGUgc2VyaWVzLCBkbyB5
b3UgdGhpbmsgd2UgY2FuIG1vdmUgZm9yd2FyZD8NCg0KVGhhbmtzIQ0KID5jbWQNCg0KT24gMDkv
MDcvMjAyNCAxNjoyNiwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPiBGcm9tOiBDbMOp
bWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4N
Cj4gVmFyaW91cyBmaXhlcyBmb3IgVlQtZA0KPg0KPiBUaGlzIHNlcmllcyBjb250YWlucyBmaXhl
cyB0aGF0IHdpbGwgYmUgbmVjZXNzYXJ5DQo+IHdoZW4gYWRkaW5nIGluLWd1ZXN0IChmdWxseSBl
bXVsYXRlZCkgU1ZNIHN1cHBvcnQuDQo+DQo+IHY3DQo+ICAgICAgaW50ZWxfaW9tbXU6IGZpeCB0
eXBlIG9mIHRoZSBtYXNrIGZpZWxkIGluIFZURElPVExCUGFnZUludkluZm86DQo+ICAgICAgCS0g
RWRpdCBjb21taXQgbWVzc2FnZQ0KPg0KPiB2Ng0KPiAgICAgIGludGVsX2lvbW11OiBmaXggdHlw
ZSBvZiB0aGUgbWFzayBmaWVsZCBpbiBWVERJT1RMQlBhZ2VJbnZJbmZvOg0KPiAgICAgIAktIEFk
ZCAnRml4ZXMnIHRhZw0KPg0KPiB2NQ0KPiAgICAgIGludGVsX2lvbW11OiBmaXggRlJDRCBjb25z
dHJ1Y3Rpb24gbWFjcm86DQo+ICAgICAgCS0gUmVtb3ZlIGVtcHR5IGxpbmUgYWZ0ZXIgJ0ZpeGVz
Jw0KPiAgICAgIA0KPiAgICAgIGludGVsX2lvbW11OiBmaXggdHlwZSBvZiB0aGUgbWFzayBmaWVs
ZCBpbiBWVERJT1RMQlBhZ2VJbnZJbmZvOg0KPiAgICAgIAktIEVkaXQgY29tbWl0IG1lc3NhZ2Ug
YWZ0ZXIgY29tbWVudCBmcm9tIFlpDQo+ICAgICAgDQo+ICAgICAgaW50ZWxfaW9tbXU6IG1ha2Ug
dHlwZXMgbWF0Y2g6DQo+ICAgICAgCS0gRWRpdCBjb21taXQgbWVzc2FnZSAocy8ibWFrZSB0eXBl
cyBtYXRjaCIvIm1ha2UgdHlwZSBtYXRjaCIvKQ0KPg0KPiB2NA0KPiAgICAgIC0gTW92ZSBkZWNs
YXJhdGlvbnMgb2YgVlREX0ZSQ0RfUFYgYW5kIFZURF9GUkNEX1BQDQo+ICAgICAgLSBpbnRlbF9p
b21tdTogbWFrZSB0eXBlcyBtYXRjaDoNCj4gICAgICAJLSBlZGl0IGNvbW1pdCBtZXNzYWdlIHRv
IGV4cGxhaW4gdGhhdCB3ZSBhcmUgbm90IGZpeGluZyBhIGJ1Zw0KPiAgICAgIC0gaW50ZWxfaW9t
bXU6IGZpeCB0eXBlIG9mIHRoZSBtYXNrIGZpZWxkIGluIFZURElPVExCUGFnZUludkluZm8NCj4g
ICAgICAJLSBlZGl0IGNvbW1pdCBtZXNzYWdlDQo+DQo+IHYzDQo+ICAgICAgRlJDRCBjb25zdHJ1
Y3Rpb24gbWFjcm8gOg0KPiAgICAgIAktIExvbmdlciBzaGExIGZvciB0aGUgJ0ZpeGVzJyB0YWcN
Cj4gICAgICAJLSBBZGQgJy4nIGF0IHRoZSBlbmQgb2YgdGhlIHNlbnRlbmNlDQo+ICAgICAgDQo+
ICAgICAgTWFrZSB0eXBlcyBtYXRjaCA6DQo+ICAgICAgCS0gU3BsaXQgaW50byAyIHBhdGNoZXMg
KG9uZSBmb3IgdGhlIGZpeCBhbmQgb25lIGZvciB0eXBlIG1hdGNoaW5nKQ0KPiAgICAgIA0KPiAg
ICAgIFJlbW92ZSBwYXRjaCBmb3Igd2FpdCBkZXNjcmlwdG9yIGhhbmRsaW5nICh3aWxsIGJlIGlu
IHRoZSBQUkkgc2VyaWVzKQ0KPg0KPiB2Mg0KPiAgICAgIE1ha2UgY29tbWl0IGF1dGhvciBjb25z
aXN0ZW50DQo+DQo+DQo+DQo+IENsw6ltZW50IE1hdGhpZXUtLURyaWYgKDQpOg0KPiAgICBpbnRl
bF9pb21tdTogZml4IEZSQ0QgY29uc3RydWN0aW9uIG1hY3JvDQo+ICAgIGludGVsX2lvbW11OiBt
b3ZlIFZURF9GUkNEX1BWIGFuZCBWVERfRlJDRF9QUCBkZWNsYXJhdGlvbnMNCj4gICAgaW50ZWxf
aW9tbXU6IGZpeCB0eXBlIG9mIHRoZSBtYXNrIGZpZWxkIGluIFZURElPVExCUGFnZUludkluZm8N
Cj4gICAgaW50ZWxfaW9tbXU6IG1ha2UgdHlwZSBtYXRjaA0KPg0KPiAgIGh3L2kzODYvaW50ZWxf
aW9tbXUuYyAgICAgICAgICB8IDIgKy0NCj4gICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmggfCA2ICsrKy0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPg0K

