Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD2606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=oR2iBiR/;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=oqmo/HHn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJGl-0002Nm-3e; Sun, 22 Nov 2026 20:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJGi-0002NA-PW; Sun, 22 Nov 2026 20:54:56 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJGg-0006Jr-Cb; Sun, 22 Nov 2026 20:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795398894; x=1826934894;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OTfVMX2GkmzHUF+K/FXvGC3K6d/Ql9oDfcZo9BStk3c=;
 b=oR2iBiR/rVVVlrM29EBBgTbmqFxg/oAGFQQAW+VDHBdAPp8nClUCPu31
 JyWvwJG2PA8LySozshNbDxmctXW5fVHP6VL8SF5uM5P7qg/Nbn1Y8dLGJ
 +7yK8EiM96zc8VX52sH9AgG+5fW1lA3BYMQ4tBWi6Rm9FuOWo/M8AY08m
 wbITADs8efcKsnAqgcI8d9h+b7wtpUqBW3lh6bTNIxOHogZ+6isRpwciw
 DPYiIK6XnNqBUADh0NxKqYUZAMYh0q0oR9mkDHh3NIpMZ2ecxvByNFBLx
 PmvFdQka9TCavYhbvNpWD9g5z5BG1A6Fff5YQqyK5XbbgYy4Z9mSLSeLK w==;
X-CSE-ConnectionGUID: YaDtO5ZIQaOIHuC+2tOsIw==
X-CSE-MsgGUID: fykGel0jQVOX2qpVewv4UQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="162499859"
Received: from mail-southcentralusazon11012043.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.43])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 09:54:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAZQwINri2pNb+NVqyLxibRWIy5F68IqshEIvNXOlXyIfRjbhvcyQjqtK1H9EK+yzoggZGofDxriOabU/izFTAhgkEfoMsMwZ/YxtFFB4vknTzSwFMrcMfNSS8BMw8DnuBEImZGRhXN+DVlTVkXZ4RBI7nYityXRwsMPA4qKAN8Uu/oIbiowGvqk9UKRUsWPEOp/HvmtQPZo7kZWgjSUVnOMBYRNv+eD9/PS/qibVvmCihXFv1j3zInUdUYyj84IosHHXvj//zleiVbN7S6Mh9e2CHbxee4p2/gWjz+eueZK/eJG6jCNIjVJdXZUhc/bLtB1pmFsJ77yLWd2j2RY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTfVMX2GkmzHUF+K/FXvGC3K6d/Ql9oDfcZo9BStk3c=;
 b=DkY+iTB0173xs9AFGrIA1pWdTJjsEtOcFgtuRBLvwdrWKCVHFGct3w/Vrw6mApPRPaY9oNHmPL7TMVCiOGAw52T7BD0gVlBTygFP9WIGcP5ELzo+Kv7Pfeab/uPnnXnh+wsnjPShF0MY1NmGfivi68019fTKlCWd79+bViTOdERiKZ150nQzUgDMgBaq1VLiDs7W4tG6uHhU7T62oMqZQiFtclGavybraweoAIsKrz8d3ZhuTZ8IGhtlchry9wROqxory+8BnwZqrjv2zHoIo8ipnGuTQGimmLLNP6kWCJAAWYfyUyr/L3ngOyK8H2MB3SLMwdsNb8eSykfwBs53Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTfVMX2GkmzHUF+K/FXvGC3K6d/Ql9oDfcZo9BStk3c=;
 b=oqmo/HHnslnC/iNkPBateCMXWGAfBA8FxoIpPkSgcPAXVl0ZCkSoITbG6eR/d+tGQ9JI858WffQT54bZwiQlqSrcpgloLETEldPzbsG/xKEXIoPKMw6e9mQJiAPXk+4SgOWtLiRNNy438lSyKuargE32WybBvXBD7OhjEVR5v6s=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BN0PR04MB7919.namprd04.prod.outlook.com (2603:10b6:408:152::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 01:54:49 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 01:54:49 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: make mstatush.MPELP writable [GL4220]
Thread-Topic: [PATCH] target/riscv: make mstatush.MPELP writable [GL4220]
Thread-Index: AQHdcxL72OYEkNd8xkS9TVAjEswgl7c69RcA
Date: Mon, 23 Nov 2026 01:54:49 +0000
Message-ID: <3dff017029491bca89b1d085fc1ac10d44ed0128.camel@wdc.com>
References: <20261112200635.549520-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261112200635.549520-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BN0PR04MB7919:EE_
x-ms-office365-filtering-correlation-id: b1f60e69-cfcc-4d89-5dde-08df4904c24c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|10070799003|23010399003|366016|18002099003|22082099003|261009223027099003|260925021311599003|260925021911599003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|38070700021|260925022911599003;
x-microsoft-antispam-message-info: /Pmo74wcC3VGGyQvYDsF71HVok7bbDoiSIpsB7AZZLQcMG+X86nLGMmPl9yo7a/QrZsKT8ncRspZr6yluQVOt6aD60xPDPeq3t8Z0hRmhkoma/Lpdn4kxjG4UPftZdu8lMONHiZ0Nnl1S7uKEdCVjXRxaoSc22JnqxZdsuqeX84r4zTXuACWVa18OhOK1WFJRJzxvg5w0BiETW3irlZucowYI+DUDfjwxCsulDvO5E54AlBp/6+ACYJ8Xnzfed4RtjF3XY9yqMz3rf03YmmQwAe3u/YHSS4hG/ZBJoZH1InKNb8EpJTrbBOh6o7eX+7Weu11FL2hiBON4CKYkccdAANE9NKCpc9852UqINj7fo6zPa/F/oFuXiq6Wy4Sw6C2nEr5lMFJAvgLl4kRz/Kr+ARlN1uKLpNrlVubEfCOfUdXOkXa7W3Ar/G6Mt9BP9HPy1oEyCg8gqVycpwCu40jMhgwbNmJZD9vwaImHZstLFORh+BilMuFYYiaBQdyZrn3GsCh3QNYu27PHJMFvWB+pQN6YFlDbonrVr8clkkJN5PLnijwaiq9FcSZlW87F1s7J40j6CyPTis2nnqfW+0lK6eX/TUfssoYFToDpFRRnSwvzReRs8t9WJbHDqG7/r1XVPiOtL8mdWOk30o1wLLHjDHEyCVjaozWWcgBiEMbwGaTIrvbTaYcPizL6Er7yDisc5BxCnHmXFEpkHinEGwPRN3nDvVqfjK1h6GOUlamL3M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(260925021311599003)(260925021911599003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(38070700021)(260925022911599003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFF1TnpsYmNXT0pTWVdibldXMlpZbld4dDdXZWhaTnlzakVMVDJUaVRWMEMr?=
 =?utf-8?B?Qys4SlFuOE9YUnZiaHdsUHR6Nno3YWhEdXFzT3MrRVdLczZwSXhOODdEQ0tw?=
 =?utf-8?B?cE1LckRYZlpoS0p4N3N5bDV6U1BuS2c0K21Wd0F5SUg0c3hGY1ZRSTM2UW1w?=
 =?utf-8?B?TTExRUx2aVRzaEhSaVJoWkY2UnFrbHdCSVNwT3NxcDExWkxibXZmcXRJenQw?=
 =?utf-8?B?VGdMZEd6MmIxY28wajZwTzJOSU9SQVdMa1Z6dVJqTGxsSElWUTNQT1owaHBN?=
 =?utf-8?B?UWtRbVhBYllVbURQdTFkRkhRa0oycjZwdE1YSENONEpvaHYzUmFQbnBxRG5v?=
 =?utf-8?B?ZTg4MUNHTGU2eVZubFdTUitTdTNQNVJlbk5veGZlanZnbGcyRDJ1Q2NwYVJx?=
 =?utf-8?B?bU5aQ0txMFhFaWd1em03Mlk1Z0JuWW94cVBWb21jYy92Z2ZlZlE0Z3dVQmFC?=
 =?utf-8?B?V3p2Ry9nMzBKUmcraTZHYjhOV0FGTGpkblZnazErUXlsNGFzS2JnMGRYT29L?=
 =?utf-8?B?RysyOUxCQXl6alpoUWVZWTBOeEVQc29oWFdMc1FrcDhYVXVSOU9XT25RaHly?=
 =?utf-8?B?OFdBOFdCWkE3OGM4TFdaTkc3eiswcFRaR0JpT2x3STBQczJRZGR3WC93Ymhl?=
 =?utf-8?B?Tkhza21hQzA5TWJlelQ1R3VOS29raUorS21SZ3dsQ0k2M25uam5WSjZPaDg2?=
 =?utf-8?B?MS9tMHY4SEtaUWFHMTNvOUhQaFFNTHYySFViRGs2UTU4RUZka0ZlUWdwMUlo?=
 =?utf-8?B?K3l0Q3ovaEgzL1FvUzZYdm9rODNtS3Q3VEpGUzlNOUhuQU1rRStGc3dYMjds?=
 =?utf-8?B?MU4rendPbGo3dXBSWCs2NG9GRTRLM0M3MFEwL0tvRmZqdllVRFRORnVwbHUz?=
 =?utf-8?B?YVZTYzFaYlFuYkNyZHJOTUpVbFB5ZjB0YnRyYVR3bmFYdDcrQU9PcXhaNG5h?=
 =?utf-8?B?TG9nRmlteXZPZUdGWUU3WUN5bFloVGVQMyt1Tm5DSUNCaThEaUtiWkFmb3Zj?=
 =?utf-8?B?L3JBVWR2bzJacGRqWXlFYVZBNjBQS3h5RU5jc1VtNEZoU0FRTG9vL1NHS0t3?=
 =?utf-8?B?ZzBnYnR6cjM0aVNxS1ZYSytYM0Fvc1d5bXN2VlZHQmxKVTVZKzhpNmJENGNi?=
 =?utf-8?B?NlpXNG15VWFKb0g3bm4vejlQR2hQZjRTT1E2Q2tBM3lKRDVHOWR2YytrSnE5?=
 =?utf-8?B?QnQ2eWNuWDcyYnorSlVQbkx1Uy9uejlreU1RaWNWYnpqaXorYjRUVzZLdWRt?=
 =?utf-8?B?cHdSQTRVeW9MTnJlcDRhM0FtQ2J3M1R2T1VNMmE1WHFVNkF3SGw0NysvVGlH?=
 =?utf-8?B?d1RXNzFiSHc3V2pDM1JnUmd4UllFWjR3d2dYUURzMXZ3M1BaY3NUZW1UWmRo?=
 =?utf-8?B?ZFdyWVVMVDdVQ1V1SitsUG5Gd0J6Y1M1UXNzUWZrWlhUNjFhMjlUbFhPTkk1?=
 =?utf-8?B?aE9Id0F5L0pnMllIVldoTWRwRzRaQ3FVYktNY29rcjIwRzJ6VlZRbmh3Lzlo?=
 =?utf-8?B?c2taclFHdy8zK3dhS0FoSlpFOGF0WXJPQThJOGk2dkk0aHdOS09xQTFuaWFW?=
 =?utf-8?B?WmE4cmhkampJdU56Tjlzdko3a2QxZU5Jdi96bjlzK0p5aTYyM1hKbkxicm9I?=
 =?utf-8?B?NG1kV0VlNEMxZ3h6cVRkVUp5TExDbS9sYzFRVGlqVThpZ0VkZUVRbVVBQmZi?=
 =?utf-8?B?eFlWNWpCQ0NIbmtYUkNGYzVBQm5jNDB0dk1lVmt4R2Z6UlJZN2NEc2dyS2pO?=
 =?utf-8?B?TFNSK2RrNHJNY3Y5VGc1QWREY1h3MTRFU3NES0p6cEtCWFVZaWYvZ2tjWFZv?=
 =?utf-8?B?cVFFOFRjMHMxd2p3V3F1RENUdTNUY3JNSWdmTzljL2o2aWVIU2ZpQm82anBG?=
 =?utf-8?B?RllnM3lpK0srQ3hVYTBGdElOQkpuNkQyNXFSVUtEd1o3T2FJcFlWb0QrOVps?=
 =?utf-8?B?NmNTcVdLTE9KOHlQbmxRTW1MV3grQkkyZTlCTDIyTFBidFo5bmJUY2NlMGFt?=
 =?utf-8?B?by9WdG9pMnpMVTlHYlRFWnpsNHlXRHF0WG11dmF1YVlSVGhMTDRYUURlRWY1?=
 =?utf-8?B?YVdFUDFKRTduWjUvdndXQjBQNktxNVdhR2RUUjA4SmRuRU1JTmtzMXZ5WC9i?=
 =?utf-8?B?VCtoKzNMNU9jRUhML09weG0vVXhlYXRUMXIvdnBSMFMwY3lCL0tSTzYzSG91?=
 =?utf-8?B?UjNhYndXSTh4YjFON0wwVUM4M2thTXJVSnlvOEI4RW5tNGFxNVpxakpqUm5J?=
 =?utf-8?B?ZEtnYVdiUVZ6UDlOS1YzOGpwUjlXb3FScTNSVHRLaklTM3JGMUJJd1VGbHpp?=
 =?utf-8?B?L095a2h4WVVwUUFiQXlBVGVBbTdIWFdDaUdLZHFQSFcwekcvZTBvaVg1NGtB?=
 =?utf-8?Q?BQpD//27Yki1lCGGiS/HkbwY/w3M4mcQ2LtEnOdk/XqJe?=
x-ms-exchange-antispam-messagedata-1: kVQmnNNWGSLinDgI/hfApRnpPDyyKyPyJUs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F63E34424DA8549AC95A0C1F9A5BF8D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a9Xflsw246VkjzJm2vglAV5DUVVkoDcQ4g8QOgq7gA96MQzp5egnyVbI/oRuuLSDjMELEk9KJdcLzRiDOmaSZmFctcrYsz2sZuSiZRrenh9L2QRWGu/h3bF35eOpiVuOSLu4wgDlMlhWTmN7U8D8s7TgL98eTIEOXx+ndyDNtVatx6R64LkZgvy0fVrMXZ+xURuUcDX5l4uUM2lzAeMmmpSmm3x6simAsriOvdL0eYw71ipU1H0x+n3/KKnsG9HQGRbd+pQyFRWP3w//IFDywE+I+E0KZyRCjYvdXyvTBeohO8+trlSvATNNXhEke3uknS905nfghJNLoG2BF8Iwwg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p5sz8WMqROo4fA3w4EjLAEteXLLJi8oOq0Aotb0vZrHKlfZ3xnzUHSf2ASZiBFbGMGk/xCRFfd6wJjkXaFQBpmdnrWVHpuyBS2nuIKysbup6bxmq1RppBsu87gxV4/25gxPBfP3SUHwVXljVThih/yxU37h/iiYwvJQ8PrGFTFcfKrISveyqSxfQ6au85Rxp5/HDn8AUjPXO/5T/6vFBHKHNl41Y4SjDx8IlS0SzLBkwVIE2qJKWXZkKAM3fmWnx4/9zOP/NBOBK0gDAoBJg9yOlj1/zeK6ePyVx1/A3vkGWc81qh1Vw1lyYsfwu2QZwEYiu6ihUd0S3he25+2MywKL3hj4RaUF2Qh5aa0qb3b7c9VeKv4BzsVWEv5YdGzLI9UBTz/xFOxkmUB9GgQaaEIqdtl4FPF3LhSSqH+HVCTFrdMGSitpIkAf7ZVIencTfUwKON43BEYHhBln5QVLWR5wWdT2+jJV5p46ia3Oi1rRgfArKnR75ZVi/cpyEJ/KiOSYUpMG4cRbX+MkTISSBykh+UYM0+wH/JVgxfbTY8VM+oImdiHZhND7TsrPYmFDp4EpkeSdm2SJNuPDxSNKJIuWx8Vf3su+arFQwljR81Z+q+6VeoqVYpt3lUCmDi6GU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f60e69-cfcc-4d89-5dde-08df4904c24c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 01:54:49.7751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oQwrBn9qj1MYHQMpOGOH8FH+X0+HaB6iLKcuNwssypRyhHkBn/5BTI0WSWohG3lgrPMDuMLfJetBHa8Td5eDlXiPSyg2Jj3FNFYet8Pb/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7919
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTEyIGF0IDE3OjA2IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gQWRkIE1TVEFUVVNfTVBFTFAgaW4gdGhlIHdyaXRlIG1hc2sgaW5zaWRlIHdy
aXRlX21zdGF0dXNoKCkuDQo+IA0KPiBGaXhlczogNDkyM2Y2NzJlM2Q3ICgidGFyZ2V0L3Jpc2N2
OiBJbnRyb2R1Y2UgZWxwIHN0YXRlIGFuZCBlbmFibGluZw0KPiBjb250cm9scyBmb3IgemljZmls
cCIpDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93
b3JrX2l0ZW1zLzQyMjANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEN
Cj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClRoYW5rcyENCg0KQXBwbGll
ZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0
L3Jpc2N2L3RjZy9jc3IuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUg
KysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2MzIvc3lzdGVtL21lc29uLmJ1aWxkwqDCoMKgIHzCoCA3
ICsrKysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2MzIvdGVzdC1tc3RhdHVzaC1tcGVscC5TIHwgNDIN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgNTQgaW5z
ZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvcmlzY3YzMi90ZXN0
LW1zdGF0dXNoLW1wZWxwLlMNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2Nz
ci5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiBpbmRleCBhZjQ0NGUzZTZmLi5lNzM0NTVk
MDIxIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQo+ICsrKyBiL3Rhcmdl
dC9yaXNjdi90Y2cvY3NyLmMNCj4gQEAgLTIxNTUsNiArMjE1NSwxMSBAQCBzdGF0aWMgUklTQ1ZF
eGNlcHRpb24NCj4gd3JpdGVfbXN0YXR1c2goQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8s
DQo+IMKgwqDCoMKgIHVpbnQ2NF90IHZhbGggPSAodWludDY0X3QpdmFsIDw8IDMyOw0KPiDCoMKg
wqDCoCB1aW50NjRfdCBtYXNrID0gcmlzY3ZfaGFzX2V4dChlbnYsIFJWSCkgPyBNU1RBVFVTX01Q
ViB8DQo+IE1TVEFUVVNfR1ZBIDogMDsNCj4gwqANCj4gK8KgwqDCoCAvKiBJZiBjZmkgbHAgZXh0
ZW5zaW9uIGlzIGF2YWlsYWJsZSwgdGhlbiBhcHBseSBjZmkgbHAgbWFzayAqLw0KPiArwqDCoMKg
IGlmIChlbnZfYXJjaGNwdShlbnYpLT5jZmcuZXh0X3ppY2ZpbHApIHsNCj4gK8KgwqDCoMKgwqDC
oMKgIG1hc2sgfD0gTVNUQVRVU19NUEVMUDsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gwqDCoMKgwqAg
aWYgKHJpc2N2X2NwdV9jZmcoZW52KS0+ZXh0X3NtZGJsdHJwKSB7DQo+IMKgwqDCoMKgwqDCoMKg
wqAgbWFzayB8PSBNU1RBVFVTX01EVDsNCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoKHZhbGggJiBN
U1RBVFVTX01EVCkgIT0gMCkgew0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL3Jpc2N2MzIvc3lz
dGVtL21lc29uLmJ1aWxkDQo+IGIvdGVzdHMvdGNnL3Jpc2N2MzIvc3lzdGVtL21lc29uLmJ1aWxk
DQo+IGluZGV4IDExN2FlNmZiY2UuLjQxNWExYzIxMmQgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3Rj
Zy9yaXNjdjMyL3N5c3RlbS9tZXNvbi5idWlsZA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3YzMi9z
eXN0ZW0vbWVzb24uYnVpbGQNCj4gQEAgLTIyLDYgKzIyLDEzIEBAIHRlc3RzICs9IHsNCj4gwqDC
oCB9LA0KPiDCoH0NCj4gwqANCj4gK3Rlc3RzICs9IHsNCj4gK8KgICd0ZXN0LW1zdGF0dXNoLW1w
ZWxwLlMnOiB7DQo+ICvCoMKgwqAgJ2NmbGFncyc6IGNmbGFncywNCj4gK8KgwqDCoCAncWVtdV9h
cmdzJzogWyctY3B1JywgJ21heCcsIHFlbXVfYXJnc10sDQo+ICvCoCB9LA0KPiArfQ0KPiArDQo+
IMKgaWYgJ3FlbXUtc3lzdGVtLXJpc2N2MzInIGluIGVtdWxhdG9ycw0KPiDCoMKgIHRjZ190ZXN0
cyArPSB7DQo+IMKgwqDCoMKgICdyaXNjdjMyLXNvZnRtbXUnOiB7DQo+IGRpZmYgLS1naXQgYS90
ZXN0cy90Y2cvcmlzY3YzMi90ZXN0LW1zdGF0dXNoLW1wZWxwLlMNCj4gYi90ZXN0cy90Y2cvcmlz
Y3YzMi90ZXN0LW1zdGF0dXNoLW1wZWxwLlMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5k
ZXggMDAwMDAwMDAwMC4uZjcwYjRkZmMzMg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3Rz
L3RjZy9yaXNjdjMyL3Rlc3QtbXN0YXR1c2gtbXBlbHAuUw0KPiBAQCAtMCwwICsxLDQyIEBADQo+
ICsvKg0KPiArICogVGVzdCB0aGF0IG1zdGF0dXNoLk1QRUxQIGlzIHdyaXRhYmxlIChHaXRsYWIg
NDIyMCkuDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMs
IEluYy4gYW5kL29yIGl0cw0KPiBzdWJzaWRpYXJpZXMuDQo+ICsgKiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiArICovDQo+ICsNCj4gKyNkZWZpbmUgTVNUQVRV
U0hfTVBFTFAgMHgyMDANCj4gKw0KPiArLm9wdGlvbiBub3J2Yw0KPiArCS50ZXh0DQo+ICsJLmds
b2JhbCBfc3RhcnQNCj4gKw0KPiArX3N0YXJ0Og0KPiArCWxsYQl0MCwgdHJhcA0KPiArCWNzcncJ
bXR2ZWMsIHQwDQo+ICsNCj4gKwljc3JyCXMwLCBtc3RhdHVzaA0KPiArCWxpCXQwLCBNU1RBVFVT
SF9NUEVMUA0KPiArCW9yCXQxLCBzMCwgdDANCj4gKwljc3J3CW1zdGF0dXNoLCB0MQ0KPiArDQo+
ICsJY3NycglzMCwgbXN0YXR1c2gNCj4gKwlhbmQJdDEsIHMwLCB0MA0KPiArCWJuZQl0MCwgdDEs
IF9mYWlsDQo+ICsNCj4gKwlqCV9wYXNzDQo+ICsNCj4gK3RyYXA6DQo+ICsJaglfZmFpbA0KPiAr
DQo+ICtfcGFzczoNCj4gKwlsaQl0MCwgMHgxMDAwMDANCj4gKwlsaQl0MSwgMHg1NTU1CS8qIEZJ
TklTSEVSX1BBU1MgKi8NCj4gKwlzdwl0MSwgMCh0MCkNCj4gKwlqCS4NCj4gKw0KPiArX2ZhaWw6
DQo+ICsJbGkJdDAsIDB4MTAwMDAwDQo+ICsJbGkJdDEsIDB4MTMzMzMJLyogc3RhdHVzID0gRklO
SVNIRVJfRkFJTCwgY29kZSA9IDENCj4gKi8NCj4gKwlzdwl0MSwgMCh0MCkNCj4gKwlqCS4NCg==

