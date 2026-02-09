Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD64E78D73
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNUO-0006up-51; Mon, 09 Feb 2026 04:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vpNUM-0006uS-Qe; Mon, 09 Feb 2026 04:23:26 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vpNUK-00084e-LY; Mon, 09 Feb 2026 04:23:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDIZWDTM0w59BXXTzhPteppPtRfomuj5bbWXEIJPjoHuLoJjXALVIDLf5s2b+x1Xhmjo1fIGDCrj5iVLQC07iLynikqqLPIA4DFzntB1LSIQkRzBqoqQrQPxR5YVz+EXRqcjIC0TqzXv6Tm/PV3CYDQmnF3tplx1EW+XRaX70i/hyvZLQS9BfWtV9u87c9l3JSnewVsZDV4DY7eKHjSfuZ0lXUtj2HSp84/ZLBel/tgSio/pNAUj3gcf4OUFyagjkE37jkaohDE6oThJkXAvp/bLYRjMXj3EgG/ZUMEqbmd9/FQuvo6OFu6jmuxDqir1/+lc0YeRBM+cYTdXdl6WUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6lIry4MYRALCjRq999vdB7aBV0eiW/fsKInvDgVyw8=;
 b=phWyAsOZNJxfc5gBuKckylnoJCU8R3ddxUgXWO5PgYIZo44aKNDvyczAaKSYP26g8iB9NcD5P1U4VQSCNCzL/3M70ywkz2reD9qZ60o9SeQrM9RT22VUqlrgmvp0llDgHqZAF4HZbn7PWI/4NPfUWNcMuHj0UUmyYXFZYTanfurkgujhj1ZmW49YjNrW42Bi+cbqfZh9KNi7tEm4TLixW5VaYiwvpN8WO2zz3mItgU7VG09lSLfBhgRKTPSzPRcEKLyFOsaHRfFHWRMw6PG8Lcr8jfkd/U8LTpP7B6PridV0kZjmrMNb1STardozPKDb2LG2JEy/dM8NAeP4KM0dXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6lIry4MYRALCjRq999vdB7aBV0eiW/fsKInvDgVyw8=;
 b=J8NNZPdxiAyzKZgL7CDvX7KwCZc3RaBlxZPN59Gc8lXL8KI5kgny91LbLQRWeSyYYVmlE8OjVuYVGP0VVcJKVdcOjMM1VQyY0cAXo0K3c4pBr/mKq3T0q3s6iESLZvTo6v+fB/wAmxHJ+37E6F6ukK2btnA76xg1j9qTRf3MmI+kRIib5uB9iMJXud3tE5WvpD/B5zImKAIQ+wjK1ShBnt35MCUxfCymKPyVwdbnou8DZESPBEp2qoeJJFz8KhOg1IuWeA0EtlHd/NLuS3tTLw58UaTYKHk1cmrJvhINrBHymRrVOt+2ykWqqJPgZahBC7arADD4PLWL40NtJTleBA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB8194.apcprd06.prod.outlook.com (2603:1096:101:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:23:15 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:23:15 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH 1/2] tests/functional: Split Aspeed ARM tests into
 separate files
Thread-Topic: [PATCH 1/2] tests/functional: Split Aspeed ARM tests into
 separate files
Thread-Index: AQHcmZ53IZu0ok7GIEK1jv3u+UAjOLV6EoNQ
Date: Mon, 9 Feb 2026 09:23:14 +0000
Message-ID: <SI6PR06MB7631CD6C25E9E4AC9D1286F6F765A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260209065044.239378-1-clg@redhat.com>
 <20260209065044.239378-2-clg@redhat.com>
 <5e9e55de-77fe-4871-97b3-8627892abdac@kaod.org>
In-Reply-To: <5e9e55de-77fe-4871-97b3-8627892abdac@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEYPR06MB8194:EE_
x-ms-office365-filtering-correlation-id: a00b38b1-00fd-4045-4454-08de67bcda76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y2NJRUliZk8wTC8ycGRqZnFMaHAydTBjZDJXa1hkZHdwbkR4QkZQU1RQNm1T?=
 =?utf-8?B?QU5iTkVabmNzSUpIZ3BzamtVVkh4T09OZU1WSytINFhEdzVybDVLUVB0UW9Q?=
 =?utf-8?B?ODJ5cDdBK1lFd0tFTzA5WGdPZ1I2UmNhd1JubFpadTB3ZGRFbDNJSkxHWXd1?=
 =?utf-8?B?dmp2L1pHL2o4OFAwaTdvUys2OEEySHZCT3c2NCtoeEZuYVJrNWRkQll3emdt?=
 =?utf-8?B?Q0lyWmhxb2tNWG9LTXZKaTk4NS9vcjBmVHJ1TGxHZEtEbCtOZ3Irem51ajNu?=
 =?utf-8?B?YmExNDB2eG9OWEsyaERhTTg0M21QWW1zNnZiUkNaczdBMzY5U3NKckxHMmhF?=
 =?utf-8?B?SGRNNGdZR0RFWEdHMDVPcVdUdTNZS1RPeDV4YUltbnlxK2hwb2JhRDdyd1Rv?=
 =?utf-8?B?dkxXanR4UlNKdTB6czEyQk5rOWdDRm4zWktVTlhWTVdlVnJtRUY5eUxQNThE?=
 =?utf-8?B?eW5DZjIvbFUxajMzRWFwK09DWVRlUWRnRUdoNmwvZGRNSENJcndMRmRtZGdi?=
 =?utf-8?B?cjR5cG9JcWpqa3BHci9wN2svQ1NTVm9PWFJlK2ZONEl4Z0pyMlJ0L2lTS2I3?=
 =?utf-8?B?dVI1bVlLU29hVWpnTzRxTWV6NDJscHRYM3BvaW93bGJVVVd5ekx1SDNwWTBO?=
 =?utf-8?B?Y0JWT3NpT2RqYVFvMEJWZDFuNVJ6SmVmdE1NME9MVHNTekx5SEVaVXhLVGZL?=
 =?utf-8?B?RkFGdkxXeUY2bjR3bllxb2xGK2U1RE9YWjZtbWhHaWVRaTlFbm1zUk41USt3?=
 =?utf-8?B?d01hc1RNUDNNd0RsSXZnK3R0OURNOXhld3F3OHJTeG9KQml3QkRTbUJOUDRT?=
 =?utf-8?B?SzV6VE9NYWZVVWtlUlJKRGRPN3lMeXBEajV5M04vU2ExNTZFV0hnWERUNG5q?=
 =?utf-8?B?UFRZbDRIM21ZOGFWbWVEdnBXK21ieWQzL21zL2FXb3pVcVMzVitYcUloWllM?=
 =?utf-8?B?TEMzb00vcDZ6MG83SkZ5dEVXT0cxVlFaYnp6bGExS3Z1WG81SzlSTEV4N0R4?=
 =?utf-8?B?czJsMWlKcVhrb2FPMTF3aG1oUytuaXBYYm81QW5nQi9PR0l0bS9oRnpVVHg3?=
 =?utf-8?B?M3AwVHM1ZU96ejByZGRXcDBwUGxGbzgrcGJvdGVIR1JCdU5zcHNibGdxVkRo?=
 =?utf-8?B?RUFrVDJKeEZoS2t5N01iVDhzSUY3S3Rocy9WTW81a2RoeWtjNXFyQTJNNWVI?=
 =?utf-8?B?MnpmRWljM3liQUxwWkplc3p2aFRVSWZJWlZQVzdaYktVRGtyUWVrOGhQUkZp?=
 =?utf-8?B?ODRYT2wyUm45eitLaHVkMllpZFplajh5czZZTVMyd3VqVEtpUUhWL1FhRUxi?=
 =?utf-8?B?NXMwYnRaZlc0eFg3ZS9KZkM0VFJrSVBJKzhwWUFUQmFON3k3VnR2cGpzb3Vt?=
 =?utf-8?B?TEMrRTRTSThzR3Nxa0JCTUlZd2MwcVVVbnNWbUxVVFoyeHFOZGFrTlRkNEQr?=
 =?utf-8?B?WWtIZy9reEdNOEljMW9rTEhucjJuQkhIVlp2UHJzY2hRMlNiWFBGczA0NWUx?=
 =?utf-8?B?VHNZQXUrUm5xMlJyRERVMUNnNmlDUzZUVWk4SEdIZWw2S1JsWGJIMlhnUmFr?=
 =?utf-8?B?NWV0YnM3cGQ5aWMrZlgwdjhqTWFFOVE1MzB4MGVESldNRUY5MmNodHp6QVM3?=
 =?utf-8?B?Qms0SFB4SnJrVGhRbGhoQWRYa1VJQlRpTzlzM2dESnYvaVNKQkhYOWxEalQ3?=
 =?utf-8?B?dVg4MDl5RFljRkszcG53dXNMUHM4dTlFWVNVbVMwVGVWalNBMVVHR1NtZ1pQ?=
 =?utf-8?B?UFlkSTlCbUk3M2lSSzN5R2NsSjVmYzdxejFGekFuQTZUNzdSU0Y0M0RmLzNp?=
 =?utf-8?B?V21UalZOVC9oeDNheXpLZ3A1Njl5ZWRXNjZXb0piOUpXYzJ4czF5UzFLZGF4?=
 =?utf-8?B?RFdJOGw2UzhpYUxHamd6QU93UU9GK2R5OHoyaFFReFhjeHhBVll5cXRSNUVW?=
 =?utf-8?B?akRRUWJsVHpaTnAyTVAwWTNWNDVLRmVaRG91S3JuVEVRazJnVzJFR2VTTnp3?=
 =?utf-8?B?UnN6UTlwTzJ5QnNtdFpMQitHY21VY05rSm5jZU11VlZIcjl4U0N4R1FjYlNG?=
 =?utf-8?B?ZjltQ2hvRW54MW43Z2ZsRVIvcDZEc2lnRHpPRmRycG93d2dwVWJhWGlIQXpH?=
 =?utf-8?B?RlRHcDlWUEFQTm56cTJKRGxtTzBqSGtoN2IxQVlyV2EwWk05aWVRWFlESGJr?=
 =?utf-8?Q?jnSD9f8b1t8f1TA6GVwFE40=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGNwbDJvWldqbC9vQ0IyVWVZNXVBelo4WXdEU0c0SE1SbTd5L2NRbVk3VzRq?=
 =?utf-8?B?WWdUR05OREtPcnE2SG1FMmw2WDFKenVxT0FReGU0NFJHTFlOanpBbXRvUmdu?=
 =?utf-8?B?ZnR0ZXRKZktlenJEdUo1Y2tLWW44d0hCMk5HMS9nRzBUVjdVNGQvbmRYWHNt?=
 =?utf-8?B?c2xHMkZzZzUrQTllWmw5dVFqcXcwUERFdVYvQXdFSG5sWGlKY2R6MlVORldy?=
 =?utf-8?B?NkRwM1R5K0hjQWJjWXl0Ym1uaE83VlJzSkZLWk8zaGlUVTFoaURSQk5oczVB?=
 =?utf-8?B?NlVONTFiQnoycjFYSVJhRitPWWt4aWp5ZXpPWnRBeTVkUGQzL3RpSWhrUnF1?=
 =?utf-8?B?QkVpRTFHdVZvT2JyUDB2dXI5NGhuZHZ6RWVlSDJ4WkU4MFF1RG81YUtkMDRs?=
 =?utf-8?B?TjNBRytzbnphZjloQ1BDUjQ1WGR2ODdZUm4zRjd4cTRKYWg5bEpBVGQxS3Er?=
 =?utf-8?B?c0x3Q1Y4c1NHQlNURjJBa280Mkd3WC9SbnJseURqYkl2L0QzT2JGSys3bFJR?=
 =?utf-8?B?UXNQNnFXY2NneVBVdm5YZ1I0WkdqYTQ0eUpmd3hDdUVQZlRPWnIySCtwdWJZ?=
 =?utf-8?B?NEpnVFhYL2tNMnlBRUdNNlhjbnVEL0YycGJkOUJVQjNjWXpZUVdFOTgxbDdQ?=
 =?utf-8?B?NUwwMXMvcDd3clc2U3RPNTJEV0JMbmlsNjduK1VHY2pKTkdyTERGUTJJRllK?=
 =?utf-8?B?SXZiSFRLM2IzSE5GWWswMy9rQjVaY0ZPRWpCb2ZwK2wwUTFYUDkxMzlkdjZi?=
 =?utf-8?B?aE9yTVdUaVo0VUd6WDUzNnZndVpnWFI3OEdmYmpONERMZi9OKzFKNUVJQkhS?=
 =?utf-8?B?TmNIRWh3eDNuVlMybXhmR0xtMi96QkE0WGRTK0RmQ2NLTC9zdWdsZi9BVVY0?=
 =?utf-8?B?Q3ducHRGNzRzZEljSXNkbjloT1hlOCttMkR4K3JoMlRhSTF4b240TkdFVlIz?=
 =?utf-8?B?VFExalE1Qm42a21OVWttdzRKU2ZjRkZjZlFKRy9aWVRpeUlPUlJvekpyM2JY?=
 =?utf-8?B?Y0trRlh0YzgrUTJVdWdJN1ZTQ242TytMdWpERkdOMkQybVcwZEpsQjRlUDhK?=
 =?utf-8?B?YlRodVNacC9XTFMxKzVnYnF6TXRub1l0MzNHRHBENzk5RFpNdTNCU3dqZlJD?=
 =?utf-8?B?cGVTMXB2b3d1cTl5K1A3TCtzd242d1hnZW5rRlJ5WDY4VmlGK1l3aFJheEJG?=
 =?utf-8?B?Y0RkSnVXZGZUMG80cWU4dDBoTVAxU09YNFh0akFxWXR4TFRWeDJsZFpRMjdz?=
 =?utf-8?B?L1ZPaWZqWUhlb2RRTTZqb283S042RmdObzhLSDdGY0hrZEhiS2VDYVd4bzhB?=
 =?utf-8?B?NjY4STVqM21URTZwRVNQQmtsaXpOSnl5MzlJZGVoWVFDSW0vRit5R3pYUURm?=
 =?utf-8?B?REJ6N3Z4Rk11a1ZDWDcxTFJxemYzVkFTNnpWcVlnVW5iUm0wY1Btdm9yU3dy?=
 =?utf-8?B?eE1pcGR0bnc3Sy9CaGpuZW5ud0hMaEJWNldxaFBYMmwzSWp3ZnlaeGNPQm9k?=
 =?utf-8?B?TVlEdUVib0tMMFc5QWcvUEE1NW4yeklBakljdmkxSUlHTU5SbUFwK291UGJ0?=
 =?utf-8?B?RC9HaVdPOUVDdWlIRGxYTFh5TUlNdEc1VGFLQy9YaHlybHFmbkkzZkxWeGhT?=
 =?utf-8?B?Y0s4d1NteHBKU2JlTXcvS1VUUEpwMFhKa2dEWGpBeGM5TnJQN3NFQ05KSFdn?=
 =?utf-8?B?TkgwQ21uWWl0MVFIQjl5aWVaWXFuY2xlelJ4dUxKT2RIbU5kdUxXOTV4a2Qx?=
 =?utf-8?B?TnlORjByYWxpMklPUEtIRlFDWTJ4bWV0cmoyU2I5enVoclNHL1FjaTIwSzdS?=
 =?utf-8?B?Zmc2RU5OWVd1MitnRm9YK2NlK2VkS05VYVJkU1ZHVnlYbVUwdVVrTWZIZ1BD?=
 =?utf-8?B?S0d6ZFpGdTM4RzFYdUJTK2xjcEJjNWxPaGxnTWpKMU4vU0RGRGZObmxLdnFm?=
 =?utf-8?B?SW5oQjl3MXJTVEp5c05RTXhTUUUxdDgrRDdSWDFzeFE4N1NvV3VHdDBESHYx?=
 =?utf-8?B?V3dRTDV0cnd4eDZFbkI0NGFZVWE5K3NqM0x3R2JsSERlbXFnWkcra1BqMkcw?=
 =?utf-8?B?M2hNMGJsQWZvZjh3cWZmbHc0UklLeVIvZXJ6RjBDRmREV3paa042SWtBWDhD?=
 =?utf-8?B?UlBHWkZPMDV4NmtQcVpDVEFOclcvc1lWWGVDN0daSUZCSDFiemwza0NGeTFj?=
 =?utf-8?B?emwvSG1sRHVKbk1YR21RS09md0pNZE9kQWpUczdvUVp1QjdNUERhS01CL3lX?=
 =?utf-8?B?UEp2Z3ZDRnFJTVY5QmV2ckF4alpPWUVvR1p0SFdNdnAzbURxN0NiZ2dQK0lj?=
 =?utf-8?B?dk51emROSTYxbFN0S0dEWmVWZXFmSVh1UWxudjBDS292RjQrS2FlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00b38b1-00fd-4045-4454-08de67bcda76
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:23:14.9657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FOTRs0zj+LJAKoN0+HmfMV4NH/d30eU3gw9sxVvFcZlek7Jzi1/CLfq9uxeNI4WjUV6DGQ7TKsYbPK0cS1LXhHeGNjZ7nXTtqUU+BbAfpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8194
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDksIDIwMjYgNDozMSBQTQ0K
PiBUbzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPjsgcWVtdS1kZXZlbEBub25n
bnUub3JnOw0KPiBxZW11LWFybUBub25nbnUub3JnDQo+IENjOiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlDQo+IDxzdGV2ZW5fbGVlQGFzcGVlZHRl
Y2guY29tPjsgVHJveSBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluDQo+IDxqYW1p
bl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25z
dHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IFRob21hcw0KPiBI
dXRoIDx0aHV0aEByZWRoYXQuY29tPjsgS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSB0ZXN0cy9mdW5jdGlvbmFsOiBTcGxpdCBB
c3BlZWQgQVJNIHRlc3RzIGludG8NCj4gc2VwYXJhdGUgZmlsZXMNCj4gDQo+ICsgS2FuZSwNCj4g
DQo+IE9uIDIvOS8yNiAwNzo1MCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4gUmVvcmdh
bml6ZSB0aGUgbW9ub2xpdGhpYyBBc3BlZWQgZnVuY3Rpb25hbCB0ZXN0IGZpbGVzIGludG8gc2Vw
YXJhdGUNCj4gPiBmaWxlcyBiYXNlZCBvbiBmaXJtd2FyZSB0eXBlIChCdWlsZHJvb3QgdnMgU0RL
KSBhbmQgc3BlY2lmaWMgdGVzdA0KPiA+IHNjZW5hcmlvcy4gVGhpcyBhbGxvd3MgdGhlIHRlc3Qg
c3VpdGUgdG8gcnVuIHRlc3RzIGluIHBhcmFsbGVsIG1vcmUNCj4gPiBlZmZlY3RpdmVseSBhbmQg
bWFrZXMgaXQgZWFzaWVyIHRvIGlkZW50aWZ5IGFuZCBydW4gc3BlY2lmaWMgdGVzdA0KPiA+IHNj
ZW5hcmlvcyBpbmRlcGVuZGVudGx5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBM
ZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgdGVzdHMvZnVuY3Rpb25h
bC9hcm0vbWVzb24uYnVpbGQgICAgICAgICAgICAgIHwgMTQgKysrLS0NCj4gPiAgIHRlc3RzL2Z1
bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDEwNjAucHkgICB8ICAwDQo+ID4gICAuLi4wMC5w
eSA9PiB0ZXN0X2FzcGVlZF9hc3QyNTAwX2J1aWxkcm9vdC5weX0gfCAxNCAtLS0tLQ0KPiA+ICAg
Li4uL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI1MDBfc2RrLnB5IHwgMjkgKysrKysr
KysrDQo+ID4gICAuLi4vYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfYnVpbGRyb290LnB5ICAgICAg
fCA0MSArLS0tLS0tLS0tLS0tDQo+ID4gICAuLi4vYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfYnVp
bGRyb290X3RwbS5weSAgfCA2MA0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gICAuLi4vZnVu
Y3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9zZGsucHkgfCAxNSAtLS0tLQ0KPiA+ICAg
Li4uL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3Nka19vdHAucHkgICAgICAgIHwgMzQgKysrKysr
KysrKysNCj4gPiAgIDggZmlsZXMgY2hhbmdlZCwgMTM0IGluc2VydGlvbnMoKyksIDczIGRlbGV0
aW9ucygtKQ0KPiA+ICAgbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+IDEwMDc1NQ0KPiB0ZXN0cy9mdW5j
dGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QxMDYwLnB5DQo+ID4gICByZW5hbWUgdGVzdHMvZnVu
Y3Rpb25hbC9hcm0ve3Rlc3RfYXNwZWVkX2FzdDI1MDAucHkgPT4NCj4gdGVzdF9hc3BlZWRfYXN0
MjUwMF9idWlsZHJvb3QucHl9ICg3NCUpDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMv
ZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjUwMF9zZGsucHkNCj4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDc1NQ0KPiB0ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX2J1
aWxkcm9vdF90cG0ucHkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDc1NQ0KPiA+IHRlc3RzL2Z1bmN0
aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2RrX290cC5weQ0KPiA+DQo+IA0KPiBbIC4u
LiBdDQo+IA0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVl
ZF9hc3QyNjAwX3Nka19vdHAucHkNCj4gPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNw
ZWVkX2FzdDI2MDBfc2RrX290cC5weQ0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi40MDY2NTMyZDVkZWMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9zZGtfb3RwLnB5DQo+
ID4gQEAgLTAsMCArMSwzNCBAQA0KPiA+ICsjIS91c3IvYmluL2VudiBweXRob24zDQo+ID4gKyMN
Cj4gPiArIyBGdW5jdGlvbmFsIHRlc3QgdGhhdCBib290cyB0aGUgQVNQRUVEIG1hY2hpbmVzICMg
Iw0KPiA+ICtTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiA+ICsN
Cj4gPiArZnJvbSBxZW11X3Rlc3QgaW1wb3J0IEFzc2V0DQo+ID4gK2Zyb20gYXNwZWVkIGltcG9y
dCBBc3BlZWRUZXN0DQo+ID4gKw0KPiA+ICsNCj4gPiArY2xhc3MgQVNUMjYwME1hY2hpbmUoQXNw
ZWVkVGVzdCk6DQo+ID4gKw0KPiA+ICsgICAgQVNTRVRfU0RLX1YxMTAwX0FTVDI2MDAgPSBBc3Nl
dCgNCj4gPiArDQo+ICdodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9y
ZWxlYXNlcy9kb3dubG9hZC92MTEuMDAvYQ0KPiBzdDI2MDAtZGVmYXVsdC1vYm1jLnRhci5neics
DQo+ID4gKw0KPiA+ICsNCj4gJzY0ZDg5MjZhN2QwMWI2NDkxNjhiZTk2Yzk4NjYwM2I1NjkwZjA2
MzkxMjg2YzQzOGEzYTc3MmM4YzcwMzllOQ0KPiAzJykNCj4gPiArDQo+ID4gKyAgICBkZWYgdGVz
dF9hcm1fYXN0MjYwMF9vdHBfYmxvY2tkZXZfZGV2aWNlKHNlbGYpOg0KPiA+ICsgICAgICAgIHNl
bGYudm0uc2V0X21hY2hpbmUoImFzdDI2MDAtZXZiIikNCj4gPiArDQo+ID4gKyAgICAgICAgaW1h
Z2VfcGF0aCA9DQo+IHNlbGYuYXJjaGl2ZV9leHRyYWN0KHNlbGYuQVNTRVRfU0RLX1YxMTAwX0FT
VDI2MDApDQo+ID4gKyAgICAgICAgb3RwX2ltZyA9IHNlbGYuZ2VuZXJhdGVfb3RwbWVtX2ltYWdl
KCkNCj4gPiArDQo+ID4gKyAgICAgICAgc2VsZi52bS5zZXRfY29uc29sZSgpDQo+ID4gKyAgICAg
ICAgc2VsZi52bS5hZGRfYXJncygNCj4gPiArICAgICAgICAgICAgIi1ibG9ja2RldiIsDQo+IGYi
ZHJpdmVyPWZpbGUsZmlsZW5hbWU9e290cF9pbWd9LG5vZGUtbmFtZT1vdHAiLA0KPiA+ICsgICAg
ICAgICAgICAiLWdsb2JhbCIsICJhc3BlZWQtb3RwLmRyaXZlPW90cCIsDQo+ID4gKyAgICAgICAg
KQ0KPiA+ICsgICAgICAgIHNlbGYuZG9fdGVzdF9hcm1fYXNwZWVkX3Nka19zdGFydCgNCj4gPiAr
ICAgICAgICAgICAgc2VsZi5zY3JhdGNoX2ZpbGUoImFzdDI2MDAtZGVmYXVsdCIsICJpbWFnZS1i
bWMiKSkNCj4gPiArICAgICAgICBzZWxmLndhaXRfZm9yX2NvbnNvbGVfcGF0dGVybigiYXN0MjYw
MC1kZWZhdWx0IGxvZ2luOiIpDQo+ID4gKw0KPiA+ICsNCj4gPiAraWYgX19uYW1lX18gPT0gJ19f
bWFpbl9fJzoNCj4gPiArICAgIEFzcGVlZFRlc3QubWFpbigpDQo+IA0KPiBLYW5lLA0KPiANCj4g
VGhpcyB0ZXN0IGRvZXNuJ3QgYWRkIG11Y2ggY29tcGFyZWQgdG8gdGhlIHNkayBib290LiBJcyBp
dCBwb3NzaWJsZSB0byBleHRlbmQNCj4gdG8gZXhlcmNpc2UgdGhlIE9UUCBmZWF0dXJlID8NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCkhpIEPDqWRyaWMsDQoNClRoYW5rcyBmb3IgdGhlIGZl
ZWRiYWNrLiBJIHdpbGwgZXh0ZW5kIHRoZSB0ZXN0IGNhc2UgYXMgc3VnZ2VzdGVkLg0KDQpJIHBs
YW4gdG8gaW1wbGVtZW50IHRoZSBPVFAgdmVyaWZpY2F0aW9uIGF0IHRoZSBVLUJvb3Qgc3RhZ2Ug
dXNpbmcgdGhlIFUtQm9vdCBPVFAgdG9vbCwNCmFzIHRoaXMgd2lsbCBzaWduaWZpY2FudGx5IHNw
ZWVkIHVwIHRoZSB0ZXN0IGV4ZWN1dGlvbi4gSG93ZXZlciwgaWYgeW91IHdvdWxkIHByZWZlciB0
aGUNCnRlc3RpbmcgdG8gYmUgZG9uZSBsYXRlciB3aXRoaW4gdGhlIEJNQyBMaW51eCBzdGFnZSwg
cGxlYXNlIGxldCBtZSBrbm93Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo=

