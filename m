Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98042606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=HA8HikEa;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=jK8U8q5F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVIUw-0001bi-2G; Sun, 22 Nov 2026 20:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVIUt-0001bQ-Ic
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 20:05:31 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVIUr-0002Yu-EO
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 20:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795395930; x=1826931930;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oGsH30wahaI1DgQ2aR6E4YkixhRUcPTeX6ZiZAZkmA4=;
 b=HA8HikEagmdzUGY9bLYtKe+i1FiEQ9huaMz1AcORqPBwURsIiEsSozoM
 qDWbD19njaD3ZIeRiJC5Z+nnVrKh6/Vra70l+SZW1GqMJ2SGilvC5yL/a
 RiL40icPYQYSGr7yH4VQBKU19DZ+uIgDqyc1JrnQLshnlgwK53CihWcX0
 GoefDGV5jVodahNdkSy90Y4+9Lj5Z51Dwqj2c0rAITCi3xmRQyspIr4Lw
 VNmpiV4Q7EMwjqjbtYeTLiR1eqQ+s49yb0JiV3ZX4D3zwdiyIprVdL/EG
 Cy0L6C4tXRTBdzb4PtkG0hfSUW3n3T8O1AVZHJ5A8Prl6jhWtrCWluZzf w==;
X-CSE-ConnectionGUID: OoaFOlNzSuyjwBuXg3i/ew==
X-CSE-MsgGUID: krI4fkQQTj+M6yxLmJakyg==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="157274183"
Received: from mail-eastusazon11011068.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.68])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 09:05:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTvFae/V3vmcLBEr4A0YxE5v7Z/Y8cInUj32P7rxvL8L4s44SC8KHPMBX7EaSx6G3doWC/IZ7Qk5PQmue+fK8NHmzLFD+ZWGKmeNyei51IjO0JiRX5r5X+G+R5CexDVxiu2AWqLiZWInTp+c43O6zpPgcDXjDSmVW/PcbG2vocXW5GOT1OmydK6f+tUeS9Ncwh7+RyxAEK8ICPqvEtiEM7R6IZsNEvhfflt1+earAeRT9xmZNVSyNYwrBLt0FXu5U2yvzknuGBIg6s1hWFldFe39gs6R2OaHGZU/1DziEbKDmNpzPxDn3LBF4BgHrXSikWsp59JGwh+J4vwIeIMB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGsH30wahaI1DgQ2aR6E4YkixhRUcPTeX6ZiZAZkmA4=;
 b=x36MasVIxbzWQbQVHsdKHA24foLSgCxQGvK+TciSPaP3DXCKQNx9+ElYoOK7TlvAx8GD2O+GoTy9xlAEBCAym/qJCjufbokyKaLfb2ZqIaRj0K6w4aCWIGiIoNCXaV/777IZoPajf54MeHkLYYPDlSqpkHY0FCFO2ZCC59C6lXjMg9/MTgIxDwHXGVkGV5SPThhmHuRzORa1/UgHzDFAOaqDfm5IaSoi/5GrYn8ZhMCkjo+vA16IoqeVtmjZkQnA0ZfcASs93Ul+i3OpSb84NCOQoWJR7VC0M5dnN+1bfJeMtY05d9sIY77Weu12twO7tDMPP7jZoNZH8HVzVB/Egg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGsH30wahaI1DgQ2aR6E4YkixhRUcPTeX6ZiZAZkmA4=;
 b=jK8U8q5F0oAgMU464W045Vkirzi4oKZLlcs90rxNPRtD6J9nlVVNexETQFpmQWkOu2uTrM6gdllr53boYZkbqTdnwnoG4YlRfquEJyJZb1+5eIqS89JkSZ4x+BPhenCKXNWirx1Lvm0Yb2dX3ZEZk57BVERV6jtmXqjeurebjHQ=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA0PR04MB7243.namprd04.prod.outlook.com (2603:10b6:806:db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 01:05:19 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 01:05:19 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jsnow@redhat.com" <jsnow@redhat.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "crosa@redhat.com" <crosa@redhat.com>
Subject: Re: [PATCH 21/22] MAINTAINERS: use consistent capitalisation for
 Alistair
Thread-Topic: [PATCH 21/22] MAINTAINERS: use consistent capitalisation for
 Alistair
Thread-Index: AQHdeSuhmSZPYp4FIUmatuCFvsw7Tbc62w8A
Date: Mon, 23 Nov 2026 01:05:19 +0000
Message-ID: <838307238215cad692a6d499b5e19af6756e1d53.camel@wdc.com>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
 <20261120200511.822573-22-alex.bennee@linaro.org>
In-Reply-To: <20261120200511.822573-22-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA0PR04MB7243:EE_
x-ms-office365-filtering-correlation-id: b065495a-269b-4861-722a-08df48fdd7a9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|376014|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|38070700021|11063799006|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: Vsns56Beld5ZHl6q9dbQKlvFnXMtOPza1WqZmY0eCuytr/Kck2mpicD7eLaSrFgzSrfTjvFa9KiDT51CIuO834eUe10oGvTOgE43enXeKFWM5TDc+9FIfeXtSVYtRJEKniIKs6Xybhzj4+R4m5SMoJs9VyjaNxjdC1PKedkvNO1Z9mR+OLh6hg7aRPEDMNiRBIg8gXDyMutv2Ilh1o1WIIqwZFcwrtSNEQ1ZH/fzYO/DF1hLuPgH4xI4keKhaPfuNsTMS2XSrzyVKBebeEFSQciow5hn6WaP+nSZxibZhAR0Ip5KnGrtEe+ytGdk4hnbzI2xCkwfFROnSFrc8BWyTZZDXt2SVRpWFuT/oXF+9CIxpjQJJIGKyVwEtOzKUXgQMDDW7P7SKypads7AdSQdarlb1RHrrR9Fb929luNHGGVltIdYumYdptY7CeYON0jz9WJvI1ANlbQ98OBycp2b9ogedcfuw8p5ai6kgrjTYu+WObhgTxGRNXIMU5ad+bUI0oCj/3HPa1aYhn+72H3kglVTAT3vICQH9AZoijYEy9XabobtjM94fuAtPra7cMePJEVlUW8YZR529HprTOqRREPDYerVMSWHhiWL9hmc5/svcZA+Yb5UV9ePuWJskIulXTYhRI+IwCPRBgZefw0Pr9zlCd5y8cN+wz3Q9bkRCq7qrgLw/rSpFZctPFjmJIHW7XNmOtsm5uRbPokh6HrGAJ5ONrwaREkOH+ph2ZxSrt4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(376014)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUs5M010Mk1YMFRjb1NlU3NWYjIyaDNWTXJMektHbExuZkhjdHJodGlHc1F2?=
 =?utf-8?B?YU9XN2NqYmVzbGw1ajdrQzBPM0ZEYjhsZlpwdWk5ZkRHRVdWelhqM3NFRFV3?=
 =?utf-8?B?dVc5MDRqUTN4ME9FNUk2UThwRmRaL0t1M0NPS1kzRWVLZytNb0Y5aFF2eWo3?=
 =?utf-8?B?VU1pb2MwRkRQcHpUQ2d5Njd2ZGVIbWdNbC9vV2pXRGU1YUZoMlZjOWRDRW5R?=
 =?utf-8?B?S1J6aVlEbXp2cVE0UGhWbllJa3Q4c1R4dHBPQUxRYnZUazRDTDdUcXBuN3NN?=
 =?utf-8?B?RHpPcldNMGlEMHlZOEZsOG94ZlI0N0lCL1RHR0NLT2NGY3V6ZHVGR3Exdktl?=
 =?utf-8?B?WDg0N1FiZG55dmRpbXZEMTlKM3Z6UXNwY1B0eFFPTDdGeDd0VS9CdDc4eUFi?=
 =?utf-8?B?M2ZPWFdDTUtKVXBmL2c2eUdhRGJlSU9FVHdKZEh4YVNmVjVnUUptV3V6RHRI?=
 =?utf-8?B?bFVxNVdzRVUvN2JqSm5xaEFJMUhKcFBFampCMnhxSzVvYU1KK0doOHMwZjZo?=
 =?utf-8?B?SnJXekhNTHFPb2ozY0NJVFlyUFNObHk0UlFINjd4dnlRMWlUbTh5RWJydVRx?=
 =?utf-8?B?VWZhaGRYYThVRkY4aXVuWVdIM0lhT1BEaGhnNkRISWhsWXF4bnRYSGtPRktH?=
 =?utf-8?B?UUJTSFJvaXJBa1hwV1VHRzBWci84QkdFZnR6aGVnSUt4VkFSQXlFYURMTUFP?=
 =?utf-8?B?K0VoM1NpMisyUVU1YUhRT0tZM2hWK3ZMMVR6N3NuQ2J6YUZZUXRDMWRVYzFv?=
 =?utf-8?B?VzhjMXgxMDVrUkxGRURDK2NCTzg3ZStOdC9SM0VrT1F2UFY5V3pGVTRqZTlX?=
 =?utf-8?B?cmtOR3AzUDViU1FhbENhVWE3Y3l4T3hHY005c3hyT3N4cnZHWWh1Q21FVURX?=
 =?utf-8?B?QlIrQVJpbnl3TFY1eExYaDlueEo4UUU4d0sxS0RwekRiUE0xcUJ6TFpvWi9Y?=
 =?utf-8?B?NFFpZnNuOFduc2dZWnBpK0VnSXVFRjQzNk5zL204MnNPYnZiWmJEMS9XTTBY?=
 =?utf-8?B?UUk2OVRjK0RhaGJzWHYrWmROY0ljZzNuVDVoandBWkVKQk1Qb2hHR3ZuL1h4?=
 =?utf-8?B?TkNtTUNhNHpXQ2VqY24xNWQyZi8vdXQ0TklhaVIwV1NsZXdQTGdCd1NGTHN4?=
 =?utf-8?B?UUxoYWtNQklVSDFVWThMYkdFRk45Mkx3V1B0Qy9LZ3RiaG9lQVd6TlBxcWUx?=
 =?utf-8?B?ZEtDdmtZQnhXRnM5L2dSMGZLcWk3T3hjU29YTDZoWDVTbU45MlRHbXZVbHJ3?=
 =?utf-8?B?ZkczWHVLNkNOQmZLZTNrN1Z5VVp2cjVQdjd6Mjk4TXFKaGFxUVN3ak9QNkNh?=
 =?utf-8?B?c3NWS1BzYnF2SWdwYXZUR3ZQVldBOGdWbmZqcVA0UithdkZWWXU2U3YybTVJ?=
 =?utf-8?B?TXhLVDg0WVg4ZjhTbUhyQnRHOXQxSHVHOW9XeEMxMy9NRmpUK3lFblRhcnVJ?=
 =?utf-8?B?NEZnUlJ4TjhUckU1YkZYbjhqc2hKc0xzRDNiT1pwRjI4cmdTV1luR3dIdDU1?=
 =?utf-8?B?MWU3ZWlDdGpEa2tJTXhXYWt1TGVNeGF4L2JaclBCRytwRjBYVmNRTk1KelBN?=
 =?utf-8?B?bWF2WmJsaFBzRzZKbFc1V3ZXVmpmcjk3RnFaWkJTTTA0aGVXc0JnVmpNcm1C?=
 =?utf-8?B?aTdkU0x6WXZ6VUJQZXpDUXJMYnd6SW5nU0NwVzQzejJESnFjSUJralAreXlU?=
 =?utf-8?B?ZlhSUy9Nc3BPQUgrYTY5d1JHaTM1V0pwNzl5NjVtNXV4OUlnamlCZnAwNW1G?=
 =?utf-8?B?OGdyV1RsTWlWTnIxZEg2SDVKT1RYYm1tTElDZWwwVTBNUGxFbVNIeGhnMHkv?=
 =?utf-8?B?TnhFaWtGdndQeW4xNlVTSmR3UU91OVg4alhGdnpuRm05YTk3dlhNaDl0V3hE?=
 =?utf-8?B?eWU5N1B6TUwrTVU5cUJYcG9YeTN2b0dzTUQ2YjBTa1lybDZFN2I3ZU1tc2J2?=
 =?utf-8?B?R0RpSFdnalpIQ0FGc2hnRVhmd2dBQXgxZVFNaTNMYzNycDBLN3lVb2pLVXFv?=
 =?utf-8?B?NHZEV0x0TUFhM3dTN1RxbWRMU3EzLzl6M2RobER6TUNSNCtaSkVzRUNFN2pP?=
 =?utf-8?B?Y3MrQkRaTWYxbEtlSlFNcGt0QTRLVDFjK3JQUVFxbG5uK2FhVHBXcWRPSDBW?=
 =?utf-8?B?Y1E3ejVYOUFYR04wNUEzaStoTktUZWx6QmZITWdlMDhwaW43NlFMK2NkL1Rt?=
 =?utf-8?B?V1VjdFZWZTlqN3liU1k1VWtEYjIwRXZ5M1dWLzl6TVFOZE1XZmFBNk9BR2Uz?=
 =?utf-8?B?RXpNdmZzRnIxQUozZUpxcUJKdzZHRVRXS2k1WFM0UFl4QzZhd1pxMnhTUnZq?=
 =?utf-8?B?WVUzNTdHcUdnTVFSRDFFS21mNHgxeEdKQno1YW9ZcUwwSjRUZitZakpCMHVO?=
 =?utf-8?Q?iW38Qa2y2WRGlUmbsoRtz3C73DCTCYEE3Cwai/aVhtcKb?=
x-ms-exchange-antispam-messagedata-1: LdUC/cNj2AJBPpYSzVtb+yaRa/k4LNxNrbA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7948BAE0C5C8394AB27C064F9D9C786A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nyC9z9sJhIkyO42sFMty+vroSE/Wxy6eF2GgHjIRRe+ozCzGY5cWMvOHwrV8tVsRBxEe2qOlsvZQbB2a6+Xw23Q5GaaBfkf5l9yYMg3drxBfPeaIFhcilgDhiMLvlL71xBujaNhZtbKF3GDCskMt0fr4TPb7o4UF60tJPiN4lJhoe6XzJFlXTpSbvnbTDawAD0Sd4bvVK12ValkyhfuloWNfWQdoK/F741kCpsaJIFqAJeSe0mLp7RoiRIzG1pRi+xv9tIpqbQ8GPvdCzywjRreJn8J/o5wafAH3SunFEz99TKmrpCz8OX7gZ8jVOxsaxe4+xUKdRQcw+jdcn44Odw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6a+GY3nX0ynyOFq1ZBuLHyLHcM2I2XmdUbcSVtyqt1aRDkIjiS16PBoN/BEjXjZhy46eNnl0lPuNXGt+p47jSu+pbGt6qGE7O0SeySK4GogPYvKwQEYfXDOZP0MrinOyvOSHL2XP9sgXZWUojvP55Chopc7gjFX6ioAwgc35YoEGFWRT9sv4Y379EqsT+DsOGQRfrjSLc9e3cTCaBPSec4RFLoUeUc3sTc0w7uUY2ZQuv8mzsWzQHviPIKrDcVij8DBwL5YF7gY754VNkzRiG+7AVso9eAX2d4yC/v5TaVSI0vWcX/QWR8OcRTarVpCHiFa+OiifXUYANgLpas3kpI13Jliqf/RgLvIAXepgXk6ZvPq2xfRe895fQLY1c59xHU4nw2eeid56OWDc0/DZF5e2gV8d0TWT5l3BjgQoYaQuwWTqFpMT+EfKCLk/AKnP7sAbXqs1r+LtwRUg+WWvXdElgCLDwxj6PCZCONRlFLRURFKr5xTYEWjPFUwHig0f81O3oAnciB5Tf8z/aXPyzlCMfbXWB4Kj2VoMkYD4G9M3275PrNtvhY4F7476XeUaWSgc5IDQ8onch32fEZ5jVzUawOK0BCLNia81KDGj01UlDQpJrSTdiupUMOVXWbPl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b065495a-269b-4861-722a-08df48fdd7a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 01:05:19.1711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vfXm+YXkHD3QjxcDg9cdF2ydowDrnbp2lfjfXuLrmjKNDiXvOPTYVIMSIizhKVJ7Low/MmJ8rhbX6AiaGkXSU0TF6Nnkjg1faUbwYlN/l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7243
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTExLTIwIGF0IDIwOjA1ICswMDAwLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+
IFRoZSBsYXN0IGVtYWlscyB3aXRoIGNhcGl0YWxpc2F0aW9uIHdoZXJlIGluIDIwMTksIG1ha2Ug
aXQNCj4gY29uc2lzdGVudC4NCj4gV2UgY2FuIGFsc28gdHdlYWsgLm1haWxtYXAgc28gdGhpcyBz
dGlja3MgaW4gaGlzdG9yeSBhcyB3ZWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5u
w6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiBDYzogQWxpc3RhaXIgRnJhbmNpcyA8YWxp
c3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoE1BSU5U
QUlORVJTIHwgMTAgKysrKystLS0tLQ0KPiDCoC5tYWlsbWFwwqDCoMKgIHzCoCAxICsNCj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDVkMTQ0NGZmNjYx
Li40NTZkODM1Y2U3MCAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRB
SU5FUlMNCj4gQEAgLTg3OCw3ICs4NzgsNyBAQCBGOiB0ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0
X2Nhbm9uYTExMDAucHkNCj4gwqBGOiBkb2NzL3N5c3RlbS9hcm0vZGlnaWMucnN0DQo+IMKgDQo+
IMKgR29sZGZpc2ggUlRDDQo+IC1NOiBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lz
QHdkYy5jb20+DQo+ICtNOiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5j
b20+DQo+IMKgTDogcWVtdS1yaXNjdkBub25nbnUub3JnDQo+IMKgUzogTWFpbnRhaW5lZA0KPiDC
oEY6IGh3L3J0Yy9nb2xkZmlzaF9ydGMuYw0KPiBAQCAtMTgwNiw3ICsxODA2LDcgQEAgRjogdGVz
dHMvZnVuY3Rpb25hbC9wcGM2NC90ZXN0X2ZhZHVtcC5weQ0KPiDCoFJJU0MtViBNYWNoaW5lcw0K
PiDCoC0tLS0tLS0tLS0tLS0tLQ0KPiDCoE9wZW5UaXRhbg0KPiAtTTogQWxpc3RhaXIgRnJhbmNp
cyA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPg0KPiArTTogQWxpc3RhaXIgRnJhbmNpcyA8YWxp
c3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPiDCoEw6IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZw0KPiDC
oFM6IFN1cHBvcnRlZA0KPiDCoEY6IGh3L3Jpc2N2L29wZW50aXRhbi5jDQo+IEBAIC0xODQ0LDcg
KzE4NDQsNyBAQCBGOiBpbmNsdWRlL2h3L3Jpc2N2L3NoYWt0aV9jLmgNCj4gwqBGOiBpbmNsdWRl
L2h3L2NoYXIvc2hha3RpX3VhcnQuaA0KPiDCoA0KPiDCoFNpRml2ZSBNYWNoaW5lcw0KPiAtTTog
QWxpc3RhaXIgRnJhbmNpcyA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPg0KPiArTTogQWxpc3Rh
aXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPiDCoE06IFBhbG1lciBEYWJi
ZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+DQo+IMKgTDogcWVtdS1yaXNjdkBub25nbnUub3JnDQo+
IMKgUzogU3VwcG9ydGVkDQo+IEBAIC00MjQwLDcgKzQyNDAsNyBAQCBGOiBody9pMzg2L2FtZF9p
b21tdSoNCj4gwqBGOiB0ZXN0cy9xdGVzdC9hbWQtaW9tbXUtdGVzdC5jDQo+IMKgDQo+IMKgT3Bl
blNCSSBGaXJtd2FyZQ0KPiAtTTogQWxpc3RhaXIgRnJhbmNpcyA8QWxpc3RhaXIuRnJhbmNpc0B3
ZGMuY29tPg0KPiArTTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KPiDCoFI6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phIDxkYW5pZWwuYmFyYm96YUBvc3MucXVh
bGNvbW0uY29tPg0KPiDCoEw6IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZw0KPiDCoFM6IFN1cHBvcnRl
ZA0KPiBAQCAtNDM0MSw3ICs0MzQxLDcgQEAgRjogdGNnL3BwYzY0Lw0KPiDCoA0KPiDCoFJJU0Mt
ViBUQ0cgdGFyZ2V0DQo+IMKgTTogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4N
Cj4gLU06IEFsaXN0YWlyIEZyYW5jaXMgPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT4NCj4gK006
IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCj4gwqBSOiBEYW5p
ZWwgSGVucmlxdWUgQmFyYm96YSA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCj4g
wqBMOiBxZW11LXJpc2N2QG5vbmdudS5vcmcNCj4gwqBTOiBNYWludGFpbmVkDQo+IGRpZmYgLS1n
aXQgYS8ubWFpbG1hcCBiLy5tYWlsbWFwDQo+IGluZGV4IGJkOGJmMDdmZWI3Li5jNDQ5OTBmZDNk
NiAxMDA2NDQNCj4gLS0tIGEvLm1haWxtYXANCj4gKysrIGIvLm1haWxtYXANCj4gQEAgLTgwLDYg
KzgwLDcgQEAgQWxla3NhbmRhciBSaWthbG8gPGFsZWtzYW5kYXIucmlrYWxvQHN5cm1pYS5jb20+
DQo+IDxhcmlrYWxvQHdhdmVjb21wLmNvbT4NCj4gwqBBbGVrc2FuZGFyIFJpa2FsbyA8YWxla3Nh
bmRhci5yaWthbG9Ac3lybWlhLmNvbT4NCj4gPGFsZWtzYW5kYXIucmlrYWxvQHJ0LXJrLmNvbT4N
Cj4gwqBBbGV4IFdpbGxpYW1zb24gPGFsZXhAc2hhemJvdC5vcmc+IDxhbGV4LndpbGxpYW1zb25A
cmVkaGF0LmNvbT4NCj4gwqBBbGV4YW5kZXIgR3JhZiA8YWdyYWZAY3NncmFmLmRlPiA8YWdyYWZA
c3VzZS5kZT4NCj4gK0FsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4N
Cj4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT4NCj4gwqBBbmRyZXcgSm9uZXMgPGFuZHJldy5q
b25lc0Bvc3MucXVhbGNvbW0uY29tPg0KPiA8YWpvbmVzQHZlbnRhbmFtaWNyby5jb20+DQo+IMKg
QW5kcmV3IEpvbmVzIDxhbmRyZXcuam9uZXNAb3NzLnF1YWxjb21tLmNvbT4gPGRyam9uZXNAcmVk
aGF0LmNvbT4NCj4gwqBBbmkgU2luaGEgPGFuaXNpbmhhQHJlZGhhdC5jb20+IDxhbmlAYW5pc2lu
aGEuY2E+DQo=

