Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3255606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=GxXH4ce2;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=QQ5aeXuM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUCsD-0000ch-E9; Thu, 19 Nov 2026 19:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCs7-0000cM-Rm; Thu, 19 Nov 2026 19:53:00 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCs5-0000ki-G8; Thu, 19 Nov 2026 19:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795135977; x=1826671977;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6BtEH6uZYrb7evZcy7eXzuo7rA+CFEmuL3Llb9tyEFg=;
 b=GxXH4ce2YFlXoCx8V6GA4tjz2deIWh7jvj5E9MQceyvtjotj3Ap+gMrK
 0iO8GWP4XW7ApBjMRUTv0LeCsp8fvmYsA5VaWawd/XEzm5rhuwUbUyHY9
 /3cGkYZ1ECaFaBI5mCmyqU0axDlqqOPd9uyFtVUSkMI/F84AyDNFdFaft
 u2IONpniPi2l9fWxtXv9tvesz1BuQKPJwgkAAFQ3DpsHEZ8jRo9kWMW22
 mZcEDpiMWRgqjsIeycHjQXfBQZ5Nk3guzrJOyrJLPxyXUL/cVIkqWSU8k
 zBALqZv7DVpt/AFnYdNXBZp9X2ebjl/l4193kVTYRH4h+qVMsp8E0NT88 g==;
X-CSE-ConnectionGUID: 3Hg871BOTfWH9fpf+Ruq2A==
X-CSE-MsgGUID: +fVWRyI/SX66i7VE0tGwcA==
X-IronPort-AV: E=Sophos;i="6.27,221,1786982400"; d="scan'208";a="161326735"
Received: from mail-westcentralusazon11013042.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.42])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Nov 2026 08:52:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfmgU99DT2/wLIeuK7il7QiNfgnEIAK390GwSz+sXDGdQ/kp7MHqcBKolIYi5Qp3kGpgSkkHWkSibu3Uw5dQCwHq/f5A1C92fMjGbT/J35oveVCbkWT0MXOVDhyizhLv8ylpRIgu7MzNifxHFNc2rFDdNUswPn4Qyf9WpMSbaj7Lu35AWgORveGuJT67Qgshgjt97poWCU/nVhAKU2ud5N3M4xf6Ptv/F9iWXLaEyh2JG/+LSVJ2pVptWw0KfwK2xzp06uzmaDI+gxkABgWVfbPPlDZr25wNlc5thE/KS4wN0nyC6zWKt1OevYtVimxlRRhUdx5+AA/fVeSS/K70Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BtEH6uZYrb7evZcy7eXzuo7rA+CFEmuL3Llb9tyEFg=;
 b=iHMFXujuWdaJhyTdrjJ+d6uifJmYfITmYHIGhrIFdPmhnA79HUC8wME2Ytu+SdVcbCbatSbqriQpuyoOkk3J0gG12NvPnBNiJveE4CyXSilFaTDJ+Xkytwpee8UY580t1kNuJHNjf/EtAb3pnBV14tHwZuYpnRaCl0uzjglqbZUTT6La7CfknQT0/BHVf98I0Pvz5Gz29yX0zk5qBakIFMdQs4MpVgtrOsImKTXs8526M1p9EvQXJzc0/OHCHRmRHhonTtXSfiGN/ioDMkCQL2b2RlZQo00DqNdSq+1PzhBqIqhHbl9pkgu1v3JGb77ec3G2khhkU0w7kwLZheaT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BtEH6uZYrb7evZcy7eXzuo7rA+CFEmuL3Llb9tyEFg=;
 b=QQ5aeXuMGHn1ugz1Xjubv6J5CCElqpejyeHYXNYnFw2WOvyNTAApzDOqcbM0+W6+zsV6VERI7y9V17/uJlN6lzplFkEelbdfmMSe8AfpGd+8pDUEKZ+3uphV8g4M8CaW0q6wT8hRmR8J6LIGE6n4JCiNKH5bDg0ehTLssRliy/g=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ2PR04MB8460.namprd04.prod.outlook.com (2603:10b6:a03:4f3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 00:52:49 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 00:52:48 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 1/1] target/riscv: do not write SXL < UXL [GL4821]
Thread-Topic: [PATCH v2 1/1] target/riscv: do not write SXL < UXL [GL4821]
Thread-Index: AQHdeCNc9nljLYuHnkSO1l3jl9Uutbc2IqSA
Date: Fri, 20 Nov 2026 00:52:48 +0000
Message-ID: <2875b864ae3cd69e79d5deb0ba434e20301ea091.camel@wdc.com>
References: <20261119124141.1279663-1-daniel.barboza@oss.qualcomm.com>
 <20261119124141.1279663-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261119124141.1279663-2-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ2PR04MB8460:EE_
x-ms-office365-filtering-correlation-id: 7cad54ca-8d55-4d3c-de9a-08df46a09930
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|19092799006|23010399003|38070700021|10067099003|260925022911599003|260925021911599003|261026121527099003|261026140227099003|56012099006|4143699003|11063799006|260925021311599003|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|18002099003|22082099003|13003099007;
x-microsoft-antispam-message-info: EtUVJ5suSO/sF+tIjs/K+Res7AlSLy2nuQAMsB92NQyS8ZdJzhuQ8lgFo9wkttohZ6M6XE1iV5dLKqWQp0yO0qx/O+f4sbKuKt/OKL6D3KoId/kNCmyr0LUUOzm8rcYQ1Da/R4L2IF24TEfAJq+ETMxT253m5DG81L0HVbZ4r6i3OUZ1c35YgBAtYveBJyJrbsIVxPFObjSS0XE5pwiwxsy+H0Xqyk0T5ar85YtOcMNBhuCI+RpbMyEzWU5I+suj5b+/fKvwDMLzQFzZiOZc9yRCTMkjrTNY7C/EDU4TA6EL9lC2RLJOPiT9VdvRk2zWy+NnVRBMCxZbZcnMAFv7Pz7VxjCferJs9CFaAzE5kht1dOVDaZn66npW0vOjuz1vAQiQxRvgC2BNdp4m9+HFYkxTzzh18KaCZ/QCWs10eyppTfuy9oqrZSANzAualeEWrCgy+Cst+bD8hnQMP2xcglTXhYZ69e89+5FshdfcZuyCaiSC57+3vyY1stIkN/PlTGoEXKdlhv5J9QCMnA2Fq47j+tcOFUoZfWPuGqeQC5VBXSaTC9Uwq1qwe4IqUnR1s+IdmaD8JNL3hHItWXtIkQYrsD8Q5pWkpK5Q38MPMZxejHMYkdFzA3Mk1Q7/1AR1PqR4Zev3Qg9Qzp8/XmzvvyoN6qTyR4JeIL0GGFfbOpjqUVud1fy0wJstW5Kx8OVsXCQ/BLT+hSQXwWPrw6mi0zUgdATNQhS7m9vrru1ysKk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(19092799006)(23010399003)(38070700021)(10067099003)(260925022911599003)(260925021911599003)(261026121527099003)(261026140227099003)(56012099006)(4143699003)(11063799006)(260925021311599003)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjVTQTlBdGJVVlRFY3ZFOG1LWTAxY1Q1dHptRlJjemNvYURJU2VDM0QwZG9F?=
 =?utf-8?B?NTEzSW1PZDE0YnA3MTF6UVJHdnFmRnRkNTYwczJac1hIWm5OcHJQSmJobzRR?=
 =?utf-8?B?b2N0L0MwQVdQR2QzWThrOVJoMnNXRUNHZ3p1eXV4S2QzV2lHeVVBOVZKY0Yw?=
 =?utf-8?B?YTF6eHRwWk9mc2dpd2d0UGpUL3o5d0N6UW5aVHl0STR3eEYva3Y4U3VtcUdO?=
 =?utf-8?B?TFY5aXhHMnd6b2IzT2tJMVA0QlV4Lytvd3B6aHBGcnNxcVFQMUJ5QVRLNEJD?=
 =?utf-8?B?cWFjNnEwMkxSQlBUaUpjNG5oMVVXNmVyVU9neEcySTRiTmZFb2Q0V3lPWlBD?=
 =?utf-8?B?OVZrVDlIRyt2eGxKbVVWSmtTRkNXbkViMUhEUE56MHNicFdsRWNHNGhNTkxV?=
 =?utf-8?B?ZStYRi9WOWFza0d2M25DczNnZ2Myc0dSYmlsY3JlaVcxdi9SM2JJZHBVZk5Y?=
 =?utf-8?B?QnpEY2Q1cEg3NnFPSkhGa3E4QzRXODE2cWQyT01LcUxwZytMM0w5ZEFlMlBZ?=
 =?utf-8?B?NndFeWlBVGlGMiszV0pDUmxIZ2lOV21ETmVRd29lb2dzc1VVamZpV1hLZDEv?=
 =?utf-8?B?VGpRck9wSmlxY1JOaStobllxQURrQ0lhRWNSM2hGM2JGQ041eTJZdnR3N2NM?=
 =?utf-8?B?TllONzduTjgwblBnVzJYRFRnSXQ3NkRqaWY3VGxhbzhSSmhOM1NCUDRTUnM4?=
 =?utf-8?B?TXN0K0pmT2FMYi9hM1lFcHFJLzhIMTRjNHdaM2xyQUxjbUpta2pQR3AyM21P?=
 =?utf-8?B?WTVvVEUzaVlMSFQ1MVRpY25QSUkxb05VajNhNmN5cXBuWjMvUGNmNU1lWHBp?=
 =?utf-8?B?dG1JbHA4UmdSbWYrS3cwNjhSeHBRSFhpTjlWVHRzckJYUnh2SS9aTUhkUHpv?=
 =?utf-8?B?VThSSE1aZGlKTVAvT0R4R09JYWtUQXl0djRzZkxZbi9GUW5RZHlPM0hmOHh6?=
 =?utf-8?B?ME9YZzFoeXhucWJlUkJ0VlB3YkhYSFRNRENrUkk0MnBubE9qZTJQeEhudSsy?=
 =?utf-8?B?L2pHcUhNV2xjTCsvcDZ3RVlmL2oxTnFZMDBPWnNYcVh1MUVHTzlhczNreWJY?=
 =?utf-8?B?Z3Bqd2sxNDZhOTdWdlNOUEpxUmRvUHVZS0dVR1JUQTR5WkNkblZqL3NGN3lv?=
 =?utf-8?B?VUxBUitQTVJ3T1l1cmQweVFBR3ZYWEdxK0ltYzZMRUlMVWo3L0R5b1VCd0VX?=
 =?utf-8?B?OXZOMy9LcGU2WUo4VjJnYzNvMGxjM1JjUm5YWlh6ZkcxTkNvaGJ5Y3R2MkVt?=
 =?utf-8?B?bldsZTVFeHcwZEpPMWdhNGJtNFVyU2ZlYkNXSG1rbWI1aVFzNVBtckdla2J4?=
 =?utf-8?B?U1lRSjBzQXRaVlBuS0FyQnVyd2swMTNna2NqMExaMHkrdmdZSEc2M0ZHWXRk?=
 =?utf-8?B?b1dyWlN4RFB5UlFEbVJMN3FrNERFZXM0bXBrTDFHWVBROFRvV0ZZOXdHYjhV?=
 =?utf-8?B?N0hoRURZZlhSMmNWekY2MlQzQ3BudE1qbEpRTjlmMVRrTlZmM0Z0b3AybnpN?=
 =?utf-8?B?RzYydi95RmJndFM3SUZ5NE1nVTVYTTZ1c1NuTHBwcFNKMiszNnJCZ045amNs?=
 =?utf-8?B?RGNtSmk2bUdleUdEemluS21nQWhzSmlRbjAzS3ZCakhUL2UzQmxMZnBJT0pr?=
 =?utf-8?B?QzdPMVB0V04zczNxc1JNOGNDNVl6bnRrMU1ZbitXU1g1Z2QzbVNrYmZIZU1t?=
 =?utf-8?B?THl3QTVLWlYzTnB5ejZwUXMxRHNkL1FWc0MvR2hpWjR0MXhTSFlIbmF2bHBS?=
 =?utf-8?B?SmNzNkNkelBwR2Y4aFAySkhlamRuaTBZc3VlQW5PNm5pellKTGkxTEZOcjRC?=
 =?utf-8?B?UU9BNFIvSDgzcGFKRXdYUit3M0xaRHJwM3dXZ2RBV2U5eXB6elV3Z3dIWllS?=
 =?utf-8?B?SjR4UHYrUklwRWJpWUFyVEZ3dUNlUVBsM1NWVWdhS3duY2VObUVDYTYxb1pJ?=
 =?utf-8?B?RUk0R0ZKWUhKMFpHOUY2UWRJSnZxNW02bSt0cHB1Q2RzU2Y0ODA2M043Njdv?=
 =?utf-8?B?SjJiazVDNmVKWHdzMTdxYVBDQ2dXdTIyOEhlblV2K3NNa1NQcnhUKzVlcDlp?=
 =?utf-8?B?T3NXY1ZCRGlXYWZZYWFKS1UrSTJJZWwzQm53b1YvaVlNOXp6Q1haVnJaMThF?=
 =?utf-8?B?cWg3N3BkKzd3T0dpWG16UGlDSW1paTJjdmUwT05NTUNIVTVNR3ZCUXZtRndO?=
 =?utf-8?B?WElUZnMrNXVjRlplbmVSREVnRHJQYlVyeDhwbE9IY1ROWmUxdnV0SndqcHZX?=
 =?utf-8?B?OXVaZHAzWmxYbUl6OWNJcTBFWmsrT3hpYnI5aG9LODlYTHlERWxsUzAyMklK?=
 =?utf-8?B?VUhzem5jR0k1NWY0TCtsdVhuWkJxUnFzeUhKem9tYzFOQ0RaWUhYMmJLSkZs?=
 =?utf-8?Q?uGIQ/zvna9fccI2gpc9ccL+iLwtggsGg5p7hHc/iIQMzL?=
x-ms-exchange-antispam-messagedata-1: gfbjkwO2MzMakPWxdnURrgYQxvBToprpzkI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CBF9367CA2BC546882E6F08BFD98F3D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1y/ENw+YE16z+V96vmI9D48rPYOl+a1E9RBE/7iImcHxfPg4p+Mfeg2/5Estxxd3yVz46db7wynOVukGCO8RvAk0qAk+PwM/tmIGGNxfIOTjC6XSbtc2NvQnMwlPQNIhipHVUM9TUYgRj/HGny25WppLCL8GJ5koNWInh1R7ictKgFEfTqbb0S1sz9qJOeKreFqvK0yRFka2xtPd7e7XJxadBIr9xl+EUtCKfhTN0m16fgOqKwGy7BOzp7NfvGScxSihqubxAW5dgqMrXxhU2MVltR4hscuHLZCm9Fs0pVt7PUHbHzJBWyXJ3wydDrm6m3cFDLo5280yh55vUD9AsA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oOmuNY9FhTKNtd8azlf431RB+w1A7MBl2ChbeML9EY+ops2IJdTQlIncrngsvi6b2PCN1NR+4Wyr6n+Nw8A4R6+m6TFk9I4KYPNkK7P4OrPHfZ47Eb0WYCI7NDl0P5rvoMZJ5m/97MhXcmDJ7w5dwcscYJ9ntZXxhryZdqXjeBh6zGZ96OQ8dsoZXH+syIuquVp1JlewoaRbsuSH9Rb1g/vksgL7RNv0YRa2ok8fVVytR7T4Cv43DymeqfVJKYDnUprmklVWnT6LUxL4uQtGz//VdmpuTDTRwLRx0WH6F23+qVK9n+uCeytvqNCZjjd/SrE8yCZR6i/UKicA/vvA3vKyD90bFENLI07jkJRKP2aved2VHwS2T5sgCwHO5w/FHRh+KdV/Zh6kCIf6oBi7Hmps0HUWtRqRC2umdRrxYL8+HJgPLq13xbcASsL9Dt8BdCxif9MJhubWuYE5lHOi5kJ860zVv5+izQTqRT53Fr/eVCrlvqKPokQxc/eys4I5SjitZHA1mKRcruygu7JTkVXK2dAmruLl6HK4OaW+EL0GoG0g/jrGjHf4L7ZfV7rZz8sHeeGVO/Hi0sU5z+J5zbGX/ySbhm0k4l4j2OTbW7mYh+3avBFYC6mi7jEdVu+c
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cad54ca-8d55-4d3c-de9a-08df46a09930
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 00:52:48.8698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaxBbmoqncoo49lViMJfAhajlV245LagZJVO/1pyQcBM0J49fQFin8Pbv42sXdPeXQ9ZaLp6hGiJmSORfAQbU7qYWIk2+KY3S2BV+YlJtZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8460
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7773dcc14=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTE5IGF0IDA5OjQxIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gUklTQy1WIHByaXYgc3BlYyBzYXlzOiAiSWYgUy1tb2RlIGlzIGltcGxlbWVu
dGVkLCB0aGUgc2V0IG9mIGxlZ2FsDQo+IHZhbHVlcyB0aGF0IHRoZSB1eGwgZmllbGQgbWF5IGFz
c3VtZSBleGNsdWRlcyB0aG9zZSB0aGF0IHdvdWxkIGNhdXNlDQo+IFVYTEVOIHRvIGJlIGdyZWF0
ZXIgdGhhbiBTWExFTi4iLsKgIEF0IHRoaXMgbW9tZW50IHRoZXJlJ3Mgbm8gcmVsYXRpb24NCj4g
YmV0d2VlbiBTWEwgYW5kIFVYTCB3cml0ZXMsIGkuZS7CoCB3ZSdyZSBoYXBweSB0byBhY2NlcHQg
U1hMIDwgVVhMLg0KPiANCj4gV2UnbGwgc3RhcnQgYnkgcmVuYW1pbmcgcmlzY3Zfd3JpdGVfdXhs
KCkgdG8gcmlzY3ZfdXBkYXRlX3hsX2ZpZWxkKCksDQo+IG1ha2luZyBpdCBjbG9zZXIgdG8gd2hh
dCB0aGUgZnVuY3Rpb24gYWN0dWFsbHkgZG9lcy7CoCBUaGVuLCBpbiB0aGUNCj4gc2FtZQ0KPiBm
dW5jdGlvbjoNCj4gDQo+IC0gJ3hsJyBpcyByZW5hbWVkIHRvICdtbHgnIHNpbmNlIGl0IHN0b3Jl
cyByaXNjdl9jcHVfbXhsKCk7DQo+IC0gJ3V4bCcgaXMgcmVuYW1lZCB0byAneGwnLCBpbmRpY2F0
aW5nIHRoYXQgdGhlIGZ1bmN0aW9uIGlzIGRlYWxpbmcNCj4gd2l0aA0KPiDCoMKgIG11bHRpcGxl
IFhMIGZpbGVzIChTWEwsIFVYTCwgVlNTVEFUVVMuVVhMIC4uLik7DQo+IC0gYWRkIGEgbmV3ICdt
aW5fZmllbGRfdmFsJyBmaWVsZC4NCj4gDQo+IFdpdGggdGhpcyBpbXByb3ZlZCBoZWxwZXIgd2hh
dCdzIGxlZnQgaXMgdG8gY2hhbmdlIFNYTC9VWEwgdXBkYXRlDQo+IG9yZGVyDQo+IGluIHdyaXRl
X21zdGF0dXMoKSBhbmQsIHdoZW4gdXBkYXRpbmcgU1hMLCB3ZSdsbCB1c2UgdGhlIHdyaXR0ZW4g
VVhMDQo+IHZhbHVlIGFzIGEgbWluaW1hbCB2YWx1ZSBmb3IgU1hMLg0KPiANCj4gVGhpcyBtZWFu
cyB0aGF0IGlmIHdlJ3JlIGluIGEgU1hMIDwgVVhMIGNhc2UsIGUuZy4gU1hMID0gMSBhbmQgVVhM
ID0NCj4gMiwNCj4gd2UnbGwgd3JpdGUgU1hMID0gMi9VWEwgPSAyLsKgIEFub3RoZXIgcG9zc2li
aWxpdHkgd291bGQgYmUgdG8NCj4gZGVjcmVtZW50DQo+IFVYTCBhbmQgd3JpdGUgU1hMID0gMS9V
WEwgPSAxLCBidXQgdGhlIGJ1ZyByZXBvcnQgaW4gWzFdIG1lbnRpb25zDQo+IHRoYXQNCj4gYnVt
cGluZyBTWEwgaXMgdGhlIGRlZmF1bHQgYmVoYXZpb3Igb2Ygb3RoZXIgZW11bGF0b3JzLsKgIEZv
ciB0aGUgc2FrZQ0KPiBvZg0KPiBjb21wYXRpYmlsaXR5IHdlJ3JlIGRvaW5nIHRoZSBzYW1lLg0K
PiANCj4gWzFdIGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRl
bXMvNDgyMQ0KPiANCj4gRml4ZXM6IGViZWY2Njg1YTFhMiAoInRhcmdldC9yaXNjdjogdXNlIFNY
TCBpbnN0ZWFkIG9mIE1YTCBmb3INCj4gcmVhZF9zc3RhdHVzIikNCj4gUmVzb2x2ZXM6IGh0dHBz
Oi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMvNDgyMQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3Nz
LnF1YWxjb21tLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3Yv
dGNnL2Nzci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM5ICsrKysrKysrKysrKy0t
LS0tLQ0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZCB8wqAgNyArKysr
DQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC11eGwtc3hsLlPCoMKgwqDCoCB8IDU5DQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDkyIGluc2Vy
dGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90
Y2cvcmlzY3Y2NC90ZXN0LXV4bC1zeGwuUw0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNj
di90Y2cvY3NyLmMgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQo+IGluZGV4IDI0ZWRhNTRiYWMu
LjA2ZjRmNTlkNTcgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gKysr
IGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiBAQCAtMjA0OSwxNSArMjA0OSwyNSBAQCBzdGF0
aWMgdGFyZ2V0X3Vsb25nDQo+IGxlZ2FsaXplX21wcChDUFVSSVNDVlN0YXRlICplbnYsIHRhcmdl
dF91bG9uZyBvbGRfbXBwLA0KPiDCoMKgwqDCoCByZXR1cm4gdmFsOw0KPiDCoH0NCj4gwqANCj4g
LXN0YXRpYyB1aW50NjRfdCByaXNjdl93cml0ZV91eGwoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50
NjRfdCB2YWwsDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBmaWVsZCkNCj4gK3N0YXRpYyB1aW50NjRfdCBy
aXNjdl91cGRhdGVfeGxfZmllbGQoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50NjRfdA0KPiB2YWws
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBmaWVsZCwgdWludDMyX3QNCj4gbWluX2Zp
ZWxkX3ZhbCkNCj4gwqB7DQo+IC3CoMKgwqAgUklTQ1ZNWEwgeGwgPSByaXNjdl9jcHVfbXhsKGVu
dik7DQo+IC3CoMKgwqAgdWludDY0X3QgdXhsID0gZ2V0X2ZpZWxkKHZhbCwgZmllbGQpOw0KPiAr
wqDCoMKgIFJJU0NWTVhMIG14bCA9IHJpc2N2X2NwdV9teGwoZW52KTsNCj4gK8KgwqDCoCB1aW50
NjRfdCB4bCA9IGdldF9maWVsZCh2YWwsIGZpZWxkKTsNCj4gK8KgwqDCoCBib29sIGZpZWxkX3Vw
ZGF0ZWQgPSBmYWxzZTsNCj4gKw0KPiArwqDCoMKgIGlmICh4bCA8IG1pbl9maWVsZF92YWwpIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgIHhsID0gbWluX2ZpZWxkX3ZhbDsNCj4gK8KgwqDCoMKgwqDCoMKg
IGZpZWxkX3VwZGF0ZWQgPSB0cnVlOw0KPiArwqDCoMKgIH0NCj4gwqANCj4gLcKgwqDCoCBpZiAo
eGwgIT0gTVhMX1JWMTI4ICYmIHV4bCA9PSBNWExfUlYxMjgpIHsNCj4gLcKgwqDCoMKgwqDCoMKg
IHV4bCA9IHhsOw0KPiAtwqDCoMKgwqDCoMKgwqAgdmFsID0gc2V0X2ZpZWxkKHZhbCwgZmllbGQs
IHV4bCk7DQo+ICvCoMKgwqAgaWYgKG14bCAhPSBNWExfUlYxMjggJiYgeGwgPT0gTVhMX1JWMTI4
KSB7DQo+ICvCoMKgwqDCoMKgwqDCoCB4bCA9IG14bDsNCj4gK8KgwqDCoMKgwqDCoMKgIGZpZWxk
X3VwZGF0ZWQgPSB0cnVlOw0KPiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIGlmIChmaWVsZF91
cGRhdGVkKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCB2YWwgPSBzZXRfZmllbGQodmFsLCBmaWVsZCwg
eGwpOw0KPiDCoMKgwqDCoCB9DQo+IMKgDQo+IMKgwqDCoMKgIHJldHVybiB2YWw7DQo+IEBAIC0y
MTE4LDE0ICsyMTI4LDE3IEBAIHN0YXRpYyBSSVNDVkV4Y2VwdGlvbg0KPiB3cml0ZV9tc3RhdHVz
KENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLA0KPiDCoMKgwqDCoMKgwqDCoMKgIGlmIChy
aXNjdl9oYXNfZXh0KGVudiwgUlZIKSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFz
ayB8PSBNU1RBVFVTX01QViB8IE1TVEFUVVNfR1ZBOw0KPiDCoMKgwqDCoMKgwqDCoMKgIH0NCj4g
LcKgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwgUlZTKSAmJiAodmFsICYgTVNU
QVRVUzY0X1NYTCkgIT0gMCkgew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXNrIHw9IE1T
VEFUVVM2NF9TWEw7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCA9IHJpc2N2X3dyaXRl
X3V4bChlbnYsIHZhbCwgTVNUQVRVUzY0X1NYTCk7DQo+IC3CoMKgwqDCoMKgwqDCoCB9DQo+IMKg
DQo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2hhc19leHQoZW52LCBSVlUpICYmICh2YWwg
JiBNU1RBVFVTNjRfVVhMKSAhPSAwKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXNr
IHw9IE1TVEFUVVM2NF9VWEw7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCA9IHJpc2N2
X3dyaXRlX3V4bChlbnYsIHZhbCwgTVNUQVRVUzY0X1VYTCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHZhbCA9IHJpc2N2X3VwZGF0ZV94bF9maWVsZChlbnYsIHZhbCwgTVNUQVRVUzY0X1VY
TCwgMCk7DQo+ICvCoMKgwqDCoMKgwqDCoCB9DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgIGlmIChy
aXNjdl9oYXNfZXh0KGVudiwgUlZTKSAmJiAodmFsICYgTVNUQVRVUzY0X1NYTCkgIT0gMCkgew0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBtaW5fdmFsID0gZ2V0X2ZpZWxkKHZh
bCwgTVNUQVRVUzY0X1VYTCk7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFzayB8
PSBNU1RBVFVTNjRfU1hMOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWwgPSByaXNjdl91
cGRhdGVfeGxfZmllbGQoZW52LCB2YWwsIE1TVEFUVVM2NF9TWEwsDQo+IG1pbl92YWwpOw0KPiDC
oMKgwqDCoMKgwqDCoMKgIH0NCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiBAQCAtNTQ3NCw3ICs1NDg3
LDcgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uDQo+IHdyaXRlX3Zzc3RhdHVzKENQVVJJU0NWU3Rh
dGUgKmVudiwgaW50IGNzcm5vLA0KPiDCoMKgwqDCoCBpZiAoKHZhbCAmIFZTU1RBVFVTNjRfVVhM
KSA9PSAwKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgbWFzayAmPSB+VlNTVEFUVVM2NF9VWEw7DQo+
IMKgwqDCoMKgIH0gZWxzZSB7DQo+IC3CoMKgwqDCoMKgwqDCoCB2YWwgPSByaXNjdl93cml0ZV91
eGwoZW52LCB2YWwsIFZTU1RBVFVTNjRfVVhMKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHZhbCA9IHJp
c2N2X3VwZGF0ZV94bF9maWVsZChlbnYsIHZhbCwgVlNTVEFUVVM2NF9VWEwsIDApOw0KPiDCoMKg
wqDCoCB9DQo+IMKgwqDCoMKgIGlmICgoZW52LT5oZW52Y2ZnICYgSEVOVkNGR19EVEUpKSB7DQo+
IMKgwqDCoMKgwqDCoMKgwqAgaWYgKCh2YWwgJiBTU1RBVFVTX1NEVCkgIT0gMCkgew0KPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IGIvdGVzdHMv
dGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IGluZGV4IDllZGFiMWZkN2EuLjg3NzVk
NTViN2EgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWls
ZA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gQEAgLTg4
LDYgKzg4LDEzIEBAIHRlc3RzICs9IHsNCj4gwqDCoCB9DQo+IMKgfQ0KPiDCoA0KPiArdGVzdHMg
Kz0gew0KPiArwqAgJ3Rlc3QtdXhsLXN4bC5TJzogew0KPiArwqDCoMKgICdjZmxhZ3MnOiBjZmxh
Z3MsDQo+ICvCoMKgwqAgJ3FlbXVfYXJncyc6IFsnLWNwdScsICdtYXgnLCBxZW11X2FyZ3NdLA0K
PiArwqAgfQ0KPiArfQ0KPiArDQo+IMKgaWYgJ3FlbXUtc3lzdGVtLXJpc2N2NjQnIGluIGVtdWxh
dG9ycw0KPiDCoMKgIHRjZ190ZXN0cyArPSB7DQo+IMKgwqDCoMKgICdyaXNjdjY0LXNvZnRtbXUn
OiB7DQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXV4bC1zeGwuUw0KPiBi
L3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtdXhsLXN4bC5TDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAwMDAuLjU0ZGMwODMyYjMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXV4bC1zeGwuUw0KPiBAQCAtMCwwICsxLDU5IEBADQo+
ICsvKg0KPiArICogVGVzdCB0aGF0IFVYTCB3aWxsIG5ldmVyIGJlIHJlYWQgYXMgZ3JlYXRlciB0
aGFuIFNYTC4NCj4gKyAqDQo+ICsgKiBCYXNlZCBvbiBHaXRsYWIgNDgyMSB0ZXN0Y2FzZSwgd2hp
Y2ggaXMgZGVyaXZlZCBmcm9tIHJpc2N2LWFyY2gtDQo+IHRlc3QuDQo+ICsgKg0KPiArICogQ29w
eXJpZ2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cw0KPiBzdWJz
aWRpYXJpZXMuDQo+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cg0KPiArICovDQo+ICsNCj4gKy5vcHRpb24gbm9ydmMNCj4gKwkudGV4dA0KPiArCS5nbG9iYWwg
X3N0YXJ0DQo+ICsNCj4gK19zdGFydDoNCj4gKwlsbGEJdDAsIHRyYXANCj4gKwljc3J3CW10dmVj
LCB0MA0KPiArDQo+ICsJY3NycglzMCwgbXN0YXR1cw0KPiArCWxpCXQwLCAweGYNCj4gKwlzbGxp
CXQwLCB0MCwgMzINCj4gKwlub3QJdDAsIHQwDQo+ICsJYW5kCXQxLCBzMCwgdDANCj4gKwlsaQl0
MiwgMHg2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIFNYTCA9IDAxLCBVWEwgPSAx
MA0KPiArCXNsbGkJdDIsIHQyLCAzMg0KPiArCW9yCXQxLCB0MSwgdDINCj4gKwljc3J3CW1zdGF0
dXMsIHQxDQo+ICsJY3NycglzMSwgbXN0YXR1cw0KPiArCWNzcncJbXN0YXR1cywgczDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8vIHJlc3RvcmUNCj4gKw0KPiArCXNybGkJdDEsIHMxLCAzNA0KPiAr
CWFuZGkJdDEsIHQxLCAzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLy8gU1hMDQo+ICsJc3Js
aQl0MiwgczEsIDMyDQo+ICsJYW5kaQl0MiwgdDIsIDPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvLyBVWEwNCj4gKwlzbHR1CWEwLCB0MSwgdDLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLy8g
ZmFpbCBpZiBTWEwgPCBVWEwNCj4gKwlqCV9leGl0DQo+ICsNCj4gK3RyYXA6DQo+ICsJIyBBbnkg
dHJhcCBpcyBhIGZhaWwgY29kZSAxDQo+ICsJbGkJYTAsIDENCj4gKw0KPiArIyBFeGl0IGNvZGUg
aW4gYTANCj4gK19leGl0Og0KPiArCWxsYQlhMSwgc2VtaWFyZ3MNCj4gKwlsaQl0MCwgMHgyMDAy
NgkjIEFEUF9TdG9wcGVkX0FwcGxpY2F0aW9uRXhpdA0KPiArCXNkCXQwLCAwKGExKQ0KPiArCXNk
CWEwLCA4KGExKQ0KPiArCWxpCWEwLCAweDIwCSMgVEFSR0VUX1NZU19FWElUX0VYVEVOREVEDQo+
ICsNCj4gKwkjIFNlbWlob3N0aW5nIGNhbGwgc2VxdWVuY2UNCj4gKwkuYmFsaWduCTE2DQo+ICsJ
c2xsaQl6ZXJvLCB6ZXJvLCAweDFmDQo+ICsJZWJyZWFrDQo+ICsJc3JhaQl6ZXJvLCB6ZXJvLCAw
eDcNCj4gKwlqCS4NCj4gKw0KPiArCS5kYXRhDQo+ICsJLmJhbGlnbgkxNg0KPiArc2VtaWFyZ3M6
DQo+ICsJLnNwYWNlCTE2DQo=

