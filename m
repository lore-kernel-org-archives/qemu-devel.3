Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099AFC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 05:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN2qH-0002xq-6W; Thu, 05 Jun 2025 01:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uN2qF-0002xe-5O
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:08:39 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uN2qC-0001P1-FQ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1749100116; x=1780636116;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=N1QnXOur8L50xzvwMyRFZ3cOQx3NscVRDehh6By+gcM=;
 b=p4Oeix/kf9Ic2AMwlGv78EyvQ7g5n1Qc9/qwkRDfHFSGautMxZulfnQe
 3tesB3WoOGdI6ZkKWNYwBsfz9NCnU9nvNMQAPIim1dNUC2h41T8fIQGO/
 fs8FCEXOuw7sJXz+p9C6IaCn1mGL4GxV4qU5bynRaYDWOUymOFMSbN+sP
 lyK86Vc7h1h6dgonRhAv1Hn/GOiiu4dZCAPFQSIOsbXMvVXcIr4YP0kDp
 sRCTDzoAbA5Q6iQn3MeGzvZZRyaU07JHOiY/dLUDd2t8f+kzN+Wd3Pe7j
 JqqKYWDfpwXNJXB/5C6tOLN6fZbZqk4X4LszOeBBfkk+7n09fdldl6rVG w==;
X-CSE-ConnectionGUID: 5qVIeMlmTpyMhb0uF+/5kg==
X-CSE-MsgGUID: CbcCiynzRxKkjhrYkfRsoQ==
X-IronPort-AV: E=Sophos;i="6.16,211,1744063200"; d="scan'208";a="40275202"
X-MGA-submission: =?us-ascii?q?MDH0IPobFHpaFXY/ZImvqwu5cG7OVFd8qSq97t?=
 =?us-ascii?q?6dV6qTo+6OE4kQanDhoCY4XUIRgiVtaF0WD+Az6qUEF6TzJuPVOilaJB?=
 =?us-ascii?q?qal6hQxcct94Q60xhuP4uysoqGwjYGTGIKw10XRt6ga/nMNPq7eZeTBJ?=
 =?us-ascii?q?B2QMp0+ejh/scAu0kje0iwYw=3D=3D?=
Received: from mail-northeuropeazon11012018.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.18])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 05 Jun 2025 07:08:32 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ5v+566Ifwn3KqOPDA5cy2G9xc08UO7QaESfmCiG8mk4w2L11VAzrN+IETHsSQ6b3Tcbmx5EAu8/cvQaqxDQqG/1gNWMC7y8vAmaPeI15fbfjQAX7lvYBm9D9nM5HEvFpZIAo7EvM/F8iR7m1v4L4Vw7hDeLMnQZeYOuQivLguncNfyX9xjAipbbJu8Wfcd+zO64Mo4bzu2XAdzqsTxJMyjyC6yoC4Okz9YoHilLzk21Dn+pNP234RHO46+EcT9WHkPhK+8VPtF7VgMEoiO+50auTsNwHSRtxUZ0NM3dyN6DTeU2hWHdMliTMIbEo7SlKMHOg/QSlk3e6Ou4Xwtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1QnXOur8L50xzvwMyRFZ3cOQx3NscVRDehh6By+gcM=;
 b=kDKXLYnwYT51w8ljr7po2TxYE+zt02NtfJZBUrSwfFmDmXewZoKH0ZtWQznqGEyVgcSROYq/0Wv5TegySs/bIjoPXkjCeI2okrBhfPwL49OT8nGIjPUdDBBqAP3/+UG7IdGyyWACq61XUuyNxJIU7wWrwtbXuw0ro8qHCzlTyXCDvalrh21NFCUYMrg5rvN6Ngrw/CJv5EM98qqRF6SPwXNBCUVD7hmT3MqEOA3oJIiWv19Rvj5gezeSVOnw3fdrbxOIlN66qPNc+R50F19KSON4c+ClVRM9oO1rOwHEZoFceoHUV+doEtZiRZ8YX0a0GZG9tANKf6xHcPRjhPN6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1QnXOur8L50xzvwMyRFZ3cOQx3NscVRDehh6By+gcM=;
 b=GZCeuMuDJTh427pemtQrJfo7dU3ijKPFJRaypR64PSLrYiOOkbt6yw3XYqOUMse9a2eDflMD2ldT/zUiFfLPpK43lT2+LEbyNMAF0T95l6kVSAYR6RlkjhwcQxIlIrtLmNTZf09Y9+BBffZ+ntHkR7VRLpWZrDbgkSBD+orT6DDsV9Ei+21aK/VRhUaj1REL7uaIxw9Cfw3PZ576vgDDm0CjRLyPUagRShmy3gNKPU1cNvaKEynJMsuRoduqF0LRqm+GX/ybgU4EVHjH+jtyETT5of9TwDTNiuUFVsDo5Scr/qRQ1HWeOSIPi7I04gV9BF1T/+RCxD7Ddb7IyK4yTQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8682.eurprd07.prod.outlook.com (2603:10a6:20b:4f0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Thu, 5 Jun
 2025 05:08:30 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%3]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 05:08:29 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "jason.chien@sifive.com" <jason.chien@sifive.com>, Tomasz Jeznach
 <tjeznach@rivosinc.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 00/11] SVM API declaration for emulated devices
Thread-Topic: [PATCH 00/11] SVM API declaration for emulated devices
Thread-Index: AQHbyVdtveefhgtz0E6YCoK5Dr0yXLP0HP6A
Date: Thu, 5 Jun 2025 05:08:29 +0000
Message-ID: <b7ed1645-b055-4721-a3e1-c5b0663476e5@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8682:EE_
x-ms-office365-filtering-correlation-id: 98538834-4829-4c24-0d72-08dda3ef02c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?U2h3SVVVUkx2L3AvS2RlQUxXekFsNFNBRkJLUFgwdy9oQ1pUZmFOellRcFZ1?=
 =?utf-8?B?WlFHMFY3NS84RVFtS1lsVUJRR2NoaTh1cjlyN0lWODBGV01hQUt1ZVhzTUI0?=
 =?utf-8?B?cmJubGMyNFNOZ3MxaGRUakpXQ3R3UnVqeHhXdXlZQUI0SUVkQkhOeWdneVBk?=
 =?utf-8?B?elN1eWRyejFuNHp6bVdHWWxKY2Q2ejhFYWNCN2FnSDNqdC9FZ2JYaGE1QVlF?=
 =?utf-8?B?QmVLdkJYMHJ1WitWQmd1MzRSZlQ5ajBjMFBpN09UTnk2WVN5V2pGQ3o1d3Zq?=
 =?utf-8?B?cG14TENoUFFMNUNkbC8yMjRid0pZZDdRS25PMFJtVCt3MWN5KytEOG9wUktm?=
 =?utf-8?B?bUc3ZE82c2NjeE5PT3lIcmpsVGtnSDl1T2lpNjgrMUdvSFRsQ2lyUUc2NE5m?=
 =?utf-8?B?b0JLK2lLSDBOTVdlNWszRDJaemUvamlwWjNWM0U0UHZDUkZsL0lrSUNTMnQ3?=
 =?utf-8?B?WStndmhmYndaMUc2a3JVbjIyaGw3cVFHL3RWTnBya3QyQlV4enpCYWk2UEdH?=
 =?utf-8?B?QlcrcmhPODFMM2JoaWdNR3VRdCtOa1UyWXZ6VDJFVWdyQnB5SFk0SkU5RFky?=
 =?utf-8?B?RDRXaWxqdzBQdEhhdFJ0N0ZWRFpVcVAyYTJ5L0RPVDRUeWM5U2J1TUorZ2hJ?=
 =?utf-8?B?K3UwK0tiUE92dEtpbDdTdUt5WEsxS2FCalk5ZmFmeTFuUlliSVZTbW9qVlhG?=
 =?utf-8?B?UENkaWlLZmp1alQ5dHM5V2hWbDByeTVYOGRPNzQvNXhmdFBqa211Qm5XVmZr?=
 =?utf-8?B?T0tmWk9pcUhQWHVXRG9IVTg4ZFFodmRSUmV0SGRxWXgvZXljSXJ2QUFBWWRo?=
 =?utf-8?B?RDJ1MXEwbUVScDNNSEwxeGxTdHlZRm5LbENmc2lnNThHWXNvaTdFNEFIOFc0?=
 =?utf-8?B?Q2oxRVVhdi9xNnZSVFdWWEdGb1RYdzVDSXpFT3N5TDNXQlJMSFVpWXhvdGs1?=
 =?utf-8?B?WkJwRzJSa0ljNWdTU0NJR3k1TmJiUEs0blVwQS9uRDNvejF2NTdmMzN3OFVj?=
 =?utf-8?B?Tll0M0pGK1JpU0ZadEFDbjNSTUh6TnErT0dhbklwMkpCei9sczhPb3l3WWli?=
 =?utf-8?B?VkNrOVk1Mm1vaUQzZmRGZTZPVzNzUkdjN21yWEI1TEttM2kxMUl4R243WnlG?=
 =?utf-8?B?dTI5WUthU0pxMXdVODZhRUN0VEJwMGRzcnhSVHRBaWdCclZnMUNhZW1rZHRZ?=
 =?utf-8?B?V0xGWWNNc3V6TEI3RVZFS0lIMnN4QnBuK2pPTVBYZ2FBZWZLK3RDSEcveFly?=
 =?utf-8?B?bDRhS0dYbmtUcGozd2VDY25ueHVDU1RHRDBDaitQRGVzc25MTTBvRGtBV2Rv?=
 =?utf-8?B?SzVJcHU3TmF6bllkL2FDUm9pWU5xVVlnOHJFNmcwOWRlVXh4VFdPZi9wUE1H?=
 =?utf-8?B?VTArdmJKdVpwQVdRd1dGTUhMWUpDajlxTU1UMTk5S0ZRdlJ4bHZHMlVPNmxG?=
 =?utf-8?B?MWRhNWdaUjlkVXJBT1V0dEdvdHZlK3hicGtZTkI3YjhsZHVLYlkycDRrelN6?=
 =?utf-8?B?Q0M1NTZlWXNhMHhLblJQUGlXSkUraWhBaW9jRzlNSmV6N1QxeVpoSTZhZ0dl?=
 =?utf-8?B?eUxEV3RBa200UVozSndnVjI2NzNBbEZzVnlDN1ZoYytjSlAzenZqcHJSUmoz?=
 =?utf-8?B?Y3FRR3pSUFo0S1FETnBkRU1LVVFBckJDa0ZYWGhjdy9NT0k4Vkx1WlRXeVhE?=
 =?utf-8?B?aHIwTWdMb2d0cUdsQXd3dDJCdnRmZzRkNk02UGcyZm9ndEVWZGIxNFFhLzI2?=
 =?utf-8?B?VmtGZXZVUTNWb0RkR0k5M1ZsdHYvK2hPNkFVdEkxQ080aGNiU1ZsR1NJemlh?=
 =?utf-8?B?UW1PNzlxWGU0cFY4WWNlbVZpYlJTL2tsOVpIbGJHSTUzQ1IrbW1vUytnMXdY?=
 =?utf-8?B?dnNwR0luVXRXM0xSNkVJSjh4Z3hEczRucit4WDcxN3Q0Uy94NGNFVEx2Qkt5?=
 =?utf-8?B?aXdraWNJRWlaSmxMVU9FaEFCMTBlK01OTzNnMGJ3VEdXZHovUXlKQWx3YlZH?=
 =?utf-8?Q?rpqyLqLHBdIlaiBxB76wD5s/foQgWs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlZDNTlXUEI3RG1TK3RoNUI1UmxHZHU2MXBydGVLT1YrOTMzT0dMd2h6RG5P?=
 =?utf-8?B?eFZaTitrSHU0Y3BnempaZzZwYmJzYzk1dU8yeXc4bUxsUlN4UXVXLzg4UmQ3?=
 =?utf-8?B?ZGJaREd0eklzcWp4c0VtYVNZWXNMVktUSlI5UkY5ekpOOTc1SkptODhTWXJx?=
 =?utf-8?B?N1JPSHpaa0l2bXZnTi9udVZ0VlpteTBZRVdPZzl5azg2SEVsR0M0UkVmU2Mw?=
 =?utf-8?B?OEtYWjRWYXdYak84Uk5jWFpQMnJZVGJCWkk2ME41dytaN2Q3WHFhUWVoc1FO?=
 =?utf-8?B?Y3drc3pOOHlTWjVodVR4WWRVSnpnNzZIb0ZwL2d0TWQwV01raElmZ3BteDF3?=
 =?utf-8?B?VkUvaUwxS3pEMElyWEdUaUxUbkUyRWNCUlg4KzBUM2JPTVNpc1BodFZMTzUw?=
 =?utf-8?B?Ymw3WVJnbHdjOW9mNWFvSUpnQk1VZWV5eHpzRDNiUVRjOU5tVlNlb3JlRW5B?=
 =?utf-8?B?RW12QmR2ZjBwTlZsZG9qejdTTlpxSS90RFNqOXJ5cTY2SWd1dHZ5WTZVTnJx?=
 =?utf-8?B?ZjkwSFZsamtRR3hnZ2Mvb01ZR3IyRDdjNkRFUUFiOVdNR3V2NkdFWmE0enBr?=
 =?utf-8?B?U2hDdG52dnI5K29nL3pZVUx5bVpCbHdEUmpnK3ZUNzlaN0JDWmhxRnRjNjF1?=
 =?utf-8?B?eXptV2JESzVMTmcvbExHV3J4cTd1Q0h1OElycVQxbllxUUZ5QnkwNXhHMFAy?=
 =?utf-8?B?YVNxUkYwSU5pRnZqbWNLbGZKT0NFVmxzNE43UGs5ZC92a3dTQmdSSlhpK3F0?=
 =?utf-8?B?b3RaKzlvT01mbkZuUUZWQm9UdlBZdGNvTnR4LzBLbi84K3hINVdBd3B6eEhn?=
 =?utf-8?B?bEFQT0VVS0toSU1MWW9Wb2ZvUUkzQnNGL3J1Rzg5TnVOWGhhRGdQdkxKOGVq?=
 =?utf-8?B?b0Y5M3Y3SWdpU2tSUHdNWVEvVzFvYzdWRVBkWkNPM3RVWWZzMTFmbHNvYmda?=
 =?utf-8?B?bmlrT1hRMWsxbGp6c3MvUTYxT3VaRXA1UVdzRmEzdTNObkZMWC8zYlEzdjY0?=
 =?utf-8?B?Y1RZVlloUjV5Q1RIUVQ0eWwyUUFjT2xtK2ZURU03SUN1SGRiakY3WTJUK2ti?=
 =?utf-8?B?YVh3YnVORzFlTE9jWE5UcHFPY2VXS1BwQWt1T1dNOStXNUc4OWtsZ1djcW92?=
 =?utf-8?B?R0FjMWxUS3REQWVSeDFCK0pYS0xsUXBSNWNzdC9CZHNQTDVPbjVCVGg3OEg4?=
 =?utf-8?B?QnFnc3ZxenJ3S2wrNUM1YkZTZ1AxT0dKNUtuZHNXL202OHdCOUxXUEtnVDlr?=
 =?utf-8?B?aFltSjRpY0dPVk1qRWh2aUQxUmhmWEdXTnRxN25CYmJtWnJjSWMvVnBRbzJj?=
 =?utf-8?B?RXcvQVFGSHZOMVQrVnpXN1RPdjNGNkpLTkxqa0pQT0FXU3M4M3IweDRwRjZG?=
 =?utf-8?B?enZIMldwSXNFV0F1SU9tbStDdXhIVS9ETnhFWFBWT0lpOFBpRE5yamJFcFg4?=
 =?utf-8?B?Nk1LaVovRG5iaEFBOFhtWmdxZEFnYWUwYlNPS1V4cWhGdTg3dUVrMGdmeG5M?=
 =?utf-8?B?dGlzbDR3VTI3UUhZSTJtV1JBU0VINDJ4SW8xOUdSRldIQXFsTkd1ZEhudVhw?=
 =?utf-8?B?aTBJaXFQNGFDK2x3UC9IR05hY0lMUGQzTWRiWE5rK1orM21MdnZkcTcycm1u?=
 =?utf-8?B?VDRTbWtDcFlxSjRHMXMyZWs4UFJBTXBLUnhjYW1lS090cmt1eXBrVUxzMmIx?=
 =?utf-8?B?SzI3dmhSMTZWTi9VWDhTN3k0b3BIQVJIT2Z0bmU2UXM3RzMwV0R4eTE1clJY?=
 =?utf-8?B?b3Z2WG41RmVQcGp6SnIxbUpVQnBoMVFWMWxDWG9xcFFKYkJhczg1Y1lHamdm?=
 =?utf-8?B?ZStlOXFrNGN5bFRrNXdLN0Y2S1IySVdtWDdMbFZ6VGUxUE1KN2FyVEJoM3pa?=
 =?utf-8?B?aGF5VVdWUys1MWIvNzRBd2hldTVaWW5pVFQ2eSs5UTZGK1VTL3owWU1DQ2JY?=
 =?utf-8?B?VXhScVVKanZsOENWZEk2U1pYUmFxbEptVE5BZHpJUy96QlhxTitqbmtaNWtP?=
 =?utf-8?B?ZDAwaytMR21kQ3pCeEpRMXdXTWF2MTQ0V0RBdUoydXVsTTVXdFhWWWNwdEhl?=
 =?utf-8?B?VitydFN3VytsWUltb1BBd09MdkJUUVdSbU50a1pQRDhhR0JTNmlBN3RzN3R4?=
 =?utf-8?B?dEllb2NRVGNkZURJVXBSaEI4eUxQdG1hZlhhVTQzengzQ1BSckM1MXQrZUJC?=
 =?utf-8?Q?HV/r/QLNYUclAaLyOYSUxPc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DCFD1FFFB6C4F4F9FA5E2448FA69409@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98538834-4829-4c24-0d72-08dda3ef02c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 05:08:29.5287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTambi1hiCaZKnL8/KuiDw2pUkJhBmw2f+s4JDchhMiPNHIVBh/HPGgzx8hBPH7Ko/JfD3dl6ZtmLCX4u98WEgd8/uGtsU5BabeYDzPy7jx4UQZUbkHGmNwLLlB5GrN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8682
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

SnVzdCBjYydpbmcgcmlzY3YgdGVhbQ0KDQpUaGFua3MNCiA+Y21kDQoNCk9uIDIwLzA1LzIwMjUg
OToxOCBhbSwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPiBUaGlzIHBhdGNoIHNldCBi
ZWxvbmdzIHRvIGEgbGlzdCBvZiBzZXJpZXMgdGhhdCBhZGQgU1ZNIHN1cHBvcnQgaW4gVlQtZC4N
Cj4NCj4gSGVyZSB3ZSBmb2N1cyBvbiBpbnRyb2R1Y2luZyBhIGNvbW1vbiBQQ0ktbGV2ZWwgQVBJ
IGZvciBBVFMgYW5kIFBSSSB0byBiZQ0KPiB1c2VkIGJ5IHZpcnR1YWwgZGV2aWNlcy4NCj4NCj4g
VGhlIEFQSSBpbnRyb2R1Y2VkIGluIHRoaXMgc2VyaWVzIGlzIG1haW5seSBiYXNlZCBvbiB0aGUg
UENJZSBHZW4gNSBzcGVjLg0KPg0KPiBXaGF0IGlzIEFUUz8NCj4gJycnJycnJycnJycnDQo+DQo+
IEFUUyAoQWRkcmVzcyBUcmFuc2xhdGlvbiBTZXJ2aWNlKSBpcyBhIFBDSWUtbGV2ZWwgcHJvdG9j
b2wgdGhhdA0KPiBlbmFibGVzIFBDSWUgZGV2aWNlcyB0byBxdWVyeSBhbiBJT01NVSBmb3Igdmly
dHVhbCB0byBwaHlzaWNhbA0KPiBhZGRyZXNzIHRyYW5zbGF0aW9ucyBpbiBhIHNwZWNpZmljIGFk
ZHJlc3Mgc3BhY2UgKHN1Y2ggYXMgYSB1c2Vyc3BhY2UNCj4gcHJvY2VzcyBhZGRyZXNzIHNwYWNl
KS4gV2hlbiBhIGRldmljZSByZWNlaXZlcyB0cmFuc2xhdGlvbiByZXNwb25zZXMNCj4gZnJvbSBh
biBJT01NVSwgaXQgbWF5IGRlY2lkZSB0byBzdG9yZSB0aGVtIGluIGFuIGludGVybmFsIGNhY2hl
LA0KPiBvZnRlbiBrbm93biBhcyAiQVRDIiAoQWRkcmVzcyBUcmFuc2xhdGlvbiBDYWNoZSkgb3Ig
IkRldmljZSBJT1RMQiIuDQo+IFRvIGtlZXAgcGFnZSB0YWJsZXMgYW5kIGNhY2hlcyBjb25zaXN0
ZW50LCB0aGUgSU9NTVUgaXMgYWxsb3dlZCB0bw0KPiBzZW5kIGFzeW5jaHJvbm91cyBpbnZhbGlk
YXRpb24gcmVxdWVzdHMgdG8gaXRzIGNsaWVudCBkZXZpY2VzLg0KPg0KPiBXaGF0IGlzIFBSST8N
Cj4gJycnJycnJycnJycnDQo+DQo+IFBSSSAoUGFnZSBSZXF1ZXN0IEludGVyZmFjZSkgaXMgYSBQ
Q0llLWxldmVsIHByb3RvY29sIHRoYXQNCj4gZW5hYmxlcyBQQ0llIGRldmljZXMgdG8gcmVxdWVz
dCBwYWdlIGZhdWx0IHJlc29sdXRpb25zIHRvDQo+IHRoZSBrZXJuZWwgdGhyb3VnaCBhbiBJT01N
VS4gUFJJIGNvbWJpbmVkIHdpdGggQVRTIGFyZSB0aGUNCj4gMiBjb3JuZXJzdG9uZXMgb2YgYSB0
ZWNobm9sb2d5IGNhbGxlZCBTVk0gKFNoYXJlZCBWaXJ0dWFsDQo+IE1lbW9yeSkgb3IgU1ZBIChT
aGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nKSB3aGljaCBhbGxvd3MNCj4gUENJZSBkZXZpY2VzIHRv
IHJlYWQgdG8gYW5kIHdyaXRlIGZyb20gdGhlIG1lbW9yeSBvZg0KPiB1c2Vyc3BhY2UgYXBwbGlj
YXRpb25zIHdpdGhvdXQgcmVxdWlyaW5nIHBhZ2UgcGlubmluZy4NCj4NCj4gSGVyZSBpcyBhIGxp
bmsgdG8gb3VyIEdpdEh1YiByZXBvc2l0b3J5IHRoYXQgY29udGFpbnM6DQo+ICAgICAgLSBRZW11
IHdpdGggYWxsIHRoZSBwYXRjaGVzIGZvciBTVk0gaW4gVlQtZA0KPiAgICAgICAgICAtIEFUUw0K
PiAgICAgICAgICAtIFBSSQ0KPiAgICAgICAgICAtIERldmljZSBJT1RMQiBpbnZhbGlkYXRpb25z
DQo+ICAgICAgICAgIC0gUmVxdWVzdHMgd2l0aCBhbHJlYWR5IHByZS10cmFuc2xhdGVkIGFkZHJl
c3Nlcw0KPiAgICAgIC0gQSBkZW1vIGRldmljZQ0KPiAgICAgIC0gQSBzaW1wbGUgZHJpdmVyIGZv
ciB0aGUgZGVtbyBkZXZpY2UNCj4gICAgICAtIEEgdXNlcnNwYWNlIHByb2dyYW0gKGZvciB0ZXN0
aW5nIGFuZCBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzKQ0KPg0KPiBodHRwczovL2dpdGh1Yi5jb20v
QnVsbFNlcXVhbmEvUWVtdS1pbi1ndWVzdC1TVk0tZGVtbw0KPg0KPiBDbGVtZW50IE1hdGhpZXUt
LURyaWYgKDExKToNCj4gICAgcGNpZTogQWRkIGhlbHBlciB0byBkZWNsYXJlIFBBU0lEIGNhcGFi
aWxpdHkgZm9yIGEgcGNpZSBkZXZpY2UNCj4gICAgcGNpZTogSGVscGVyIGZ1bmN0aW9ucyB0byBj
aGVjayBpZiBQQVNJRCBpcyBlbmFibGVkDQo+ICAgIHBjaWU6IEhlbHBlciBmdW5jdGlvbiB0byBj
aGVjayBpZiBBVFMgaXMgZW5hYmxlZA0KPiAgICBwY2llOiBBZGQgYSBoZWxwZXIgdG8gZGVjbGFy
ZSB0aGUgUFJJIGNhcGFiaWxpdHkgZm9yIGEgcGNpZSBkZXZpY2UNCj4gICAgcGNpZTogSGVscGVy
IGZ1bmN0aW9ucyB0byBjaGVjayB0byBjaGVjayBpZiBQUkkgaXMgZW5hYmxlZA0KPiAgICBwY2k6
IENhY2hlIHRoZSBidXMgbWFzdGVyaW5nIHN0YXR1cyBpbiB0aGUgZGV2aWNlDQo+ICAgIHBjaTog
QWRkIGFuIEFQSSB0byBnZXQgSU9NTVUncyBtaW4gcGFnZSBzaXplIGFuZCB2aXJ0dWFsIGFkZHJl
c3Mgd2lkdGgNCj4gICAgbWVtb3J5OiBTdG9yZSB1c2VyIGRhdGEgcG9pbnRlciBpbiB0aGUgSU9N
TVUgbm90aWZpZXJzDQo+ICAgIHBjaTogQWRkIGEgcGNpLWxldmVsIGluaXRpYWxpemF0aW9uIGZ1
bmN0aW9uIGZvciBJT01NVSBub3RpZmllcnMNCj4gICAgcGNpOiBBZGQgYSBwY2ktbGV2ZWwgQVBJ
IGZvciBBVFMNCj4gICAgcGNpOiBBZGQgYSBQQ0ktbGV2ZWwgQVBJIGZvciBQUkkNCj4NCj4gICBo
dy9wY2kvcGNpLmMgICAgICAgICAgICAgICAgfCAyMDQgKysrKysrKysrKysrKysrKysrKysrLS0N
Cj4gICBody9wY2kvcGNpZS5jICAgICAgICAgICAgICAgfCAgNzggKysrKysrKysrDQo+ICAgaW5j
bHVkZS9ody9wY2kvcGNpLmggICAgICAgIHwgMzE1ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgIGluY2x1ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaCB8ICAgMSArDQo+ICAg
aW5jbHVkZS9ody9wY2kvcGNpZS5oICAgICAgIHwgIDEzICstDQo+ICAgaW5jbHVkZS9ody9wY2kv
cGNpZV9yZWdzLmggIHwgICA4ICsNCj4gICBpbmNsdWRlL3N5c3RlbS9tZW1vcnkuaCAgICAgfCAg
IDEgKw0KPiAgIDcgZmlsZXMgY2hhbmdlZCwgNjA5IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQ0KPg0K

