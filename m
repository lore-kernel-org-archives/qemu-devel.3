Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02246606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=SIYvVdBU;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=zopoKSQR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJjeM-0005WZ-KR; Wed, 21 Oct 2026 23:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJjeK-0005WK-Mw; Wed, 21 Oct 2026 23:39:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJjeI-0001E7-G7; Wed, 21 Oct 2026 23:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792640366; x=1824176366;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Q/hYikqR96m3DSoBvH0ZmcFxew/Qhwg1VxId22L62ig=;
 b=SIYvVdBUbBKgoPCuzG2G5LznWiAbA8T4EaggXU9SkjiohD25QfxngkJU
 OfK4kjkdudILI72UO3CNAgO48kgJW7CWbyap4NWGlucoA8lwiz3c4w12r
 aaoLwkeTPB1iw12ZTYPkvqwKJwV6NdjK1c7Goaci/69mbIJ0K80SkzT6w
 0tf7+7XJ+yoMQss1OP44rW3ixYCAzBVMu4hB9ZqKbfbxHXrXozzS3MZOx
 nbF1aqe8Yh4nH6uqHvDsXY/UU7Q6xKkh/GTgrmh0jbwf1ggnSeu9Xs95E
 MmLS/bvTrmsmL8nLBxLaw//nDoe2aYd38KWXzxmVYdxZQNV5DW8Qsuqmw Q==;
X-CSE-ConnectionGUID: nRqitSN1T6mJalI1yP7B+g==
X-CSE-MsgGUID: je2QOUjpS527dOUHeUg/7Q==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="158704077"
Received: from mail-centralusazon11010059.outbound.protection.outlook.com
 (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.59])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 11:39:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA28m5oodc3PVji6RT8RRfk/H7U1xWHzD7eUIqbZidf1nOcMmWuE48NKAM5hY6JFmZDcYVilwJbCGQniEQbGCWqFpLRRHhJ+gV6ecsI9324aGrdPsuerAmwo9vVAx+ArAMHgsqO6k6B4ySgZrSF6j2CtQW7FCKz5sGCZ6oOwPD0X7GRZhu4TrM6bvf/DqgD0IpjjfzIY2JTkZuWp3TnhbHDNbA2378ikNxVKFekbcZeMXE79ykn4ONe6NvGha4r7+997xRralqNRXf5j9hruyF2RhxIbRHDSYDO6m7UtDyWhQKdvTj5A+gs/+foBsEyGE0zIJeTMP/0Fn5/K5NW9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/hYikqR96m3DSoBvH0ZmcFxew/Qhwg1VxId22L62ig=;
 b=ENgma3xzOUnpfUlp7VsAe0Dyg7iI5g0Xs9Pq636nizOT8Vj8sOj946VekMrUyidvGjLweCTD80GlTY5ehjD6t8V/9htCJ4J1FVDPLFoYKI2/g2pR56sMhHVve6baLgvJlvstPrULuCmDPeJ8FeBZE57ek3+x6Ls+BMu48P5Xu3A4FB5kKJOZ1voRRF+9YjBMCJmrt+i+EVUm6miRIjOMn+tYD9IzPFC5J6Vw2DqNxMDlgNIVqn3FxHZM1DJYFZXMbPc+mupFr3iPNn3eaLEbYxVmXcd6Zev2h9mz3UfD2sgp3z5+9nIsHNUqACqbn5wUWjmFNNizuKqsjLelFfIXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/hYikqR96m3DSoBvH0ZmcFxew/Qhwg1VxId22L62ig=;
 b=zopoKSQRldcoAqvv6T6g2gLaU4PagyrMTFvS6NY1Qvff15XdA5CoqgQ2dWqCkUUzgqcUkr/xXEec7vQg5OcWSo+3y0Pl9OyFWVMm8pbK+pMtCtctBNnv7VnB8GwZhUQbeSRq6SXwK58wWHGUbxd/0uB6tRnQhZKRNZvdH/EWtIA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by LV8PR04MB9293.namprd04.prod.outlook.com (2603:10b6:408:25a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 03:37:32 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 03:37:32 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "sebasjosue84@gmail.com" <sebasjosue84@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: pmp: clear the entire PMP state on reset
Thread-Topic: [PATCH v2] target/riscv: pmp: clear the entire PMP state on reset
Thread-Index: AQHdWTXmWeqVr2fng0CByRsy2ZwNPrcI+ugA
Date: Thu, 22 Oct 2026 03:37:32 +0000
Message-ID: <b6a81310e44e6ac785c469772c9d6df2f1fce4a8.camel@wdc.com>
References: <20260916034331.2390427-1-sebasjosue84@gmail.com>
 <20261011040617.807504-1-sebasjosue84@gmail.com>
In-Reply-To: <20261011040617.807504-1-sebasjosue84@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|LV8PR04MB9293:EE_
x-ms-office365-filtering-correlation-id: 2206e67e-41e6-41a6-14b4-08df2fedce0f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|10070799003|261021123027099003|56012099006|38070700021|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|10063799003|261021121427099003;
x-microsoft-antispam-message-info: M2RdrMgBVS+dvXNU+U74+6zC/BFqLtASR8vA/XP3E4SwPoYfRG2S67vd3+R4hDD2/gBiyPMIyc7QNthAbJt9VetekYckiMJ+MHuN8k59gfme2MkvKEOWLedmFoZn3x1aWlrt7HgkZy2CRwN3OGquwEeAdnycZrWTYBkF0kUXwitZURTmkTebvmDB7W3DAsxAWpDkJzeHOYfRYKP1XA5OOrRMBnsz/w2WjsGkQ1uatye1tgA6yCI1Xlm2HVMwcZd9Tek3/v5/erE/zE8RFdZKDnDssyOkUIKlOYZ0FnJmzv6HYpHdH19VkYGuM2ACKoRfKsC+jraHGuhr02zLrkaDZi2AnxLrVSsKkZlZNcf/PCOKFA49zNB3TxAcVxSGfQ0pyAJ48SP7gih2tOqLfLDsqvO2dCzUVuSKIa/a9sgM3+okzTSjik4PWEB/FJogPGe4uxvmajiGXcO/+RV14ofxyYJQpqpQtQ/RPhe+AIOc028VRBu//WlD52d6EqZf8rZV01V9KqeHXSMFi6moll7gWRG1Q5nICmwbRjKEcONx1ovKF7id/neNXacU13Szys509OK8t6fyEBXmjZS7+px6JlNNyfz6LAcVAenmDMjKwyYnLhYH3N4EJ6C25X8zAmtXXgXRekyC4MlmzWkrsHktUxXFYiuUMeeD/XbGMbqbg4A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(10070799003)(261021123027099003)(56012099006)(38070700021)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(10063799003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnQ4ZW5QZ2M0UG5rb0lwQm4wTCt0dVpiK1pleGdNMUtCdnhpS2EyVUxMOEls?=
 =?utf-8?B?S0ZNOC9yV2haMHN0RENkQlpsbGdCQUk3UmtIN3Y5UmtOckw0QmJ6WGFMZlV6?=
 =?utf-8?B?UDNkdzVRUkwvZHU3cXBJSmdvWXpSQ0Q4L1FRM0g4VlFxT1NsbVpzKzdobE9U?=
 =?utf-8?B?VmdVY1BFTUpoYnhJakVibUNRRUt0SjYwSEEzLytWelJ3ZWFLMUw0QlBVMWNw?=
 =?utf-8?B?NU85amk4eWJtT05JODdjVkRybWVoZllrbWdkTEdRdG1WUWJsUFFvZTlGdVpy?=
 =?utf-8?B?UHo2UkRMSUdzU3pEMnNJN2tSUDIxWm9uSDN4V1FFMTFoZXgwZEhCMkNrVGxk?=
 =?utf-8?B?OWpheGRtV1N0Q3R1WHRDZW5ELzY4M1AweFJ2bGFscm9MTlVxK2E1NlRFc05G?=
 =?utf-8?B?dnpCK0tIYmpQRUFxdGp1TG9rZ0lFVmhhZTFUTzVIZW1ja08wU0tQUFpkdlFF?=
 =?utf-8?B?SUZWQkU2R2s0cDMvcGU2V1ZHTG85eHZzK0ZZWDYvN0g0THM4L3RSbEh3Q05E?=
 =?utf-8?B?WmZWbVhXMXhVU1RRUGRacGFrdjF0dE9jT3U5cUdkYW9SZ2ZSMXBYVEhEVjFY?=
 =?utf-8?B?S0sxYWZBTTlxb1hIRENHN2xReXl4M0ZPWFZNbzBLOXN4S3B0bjFXdzFIbUor?=
 =?utf-8?B?MWkrVHBUdHFHK1hiWkJCWTErd2ZhNDlYam1EVUlMN3o2Si9EVlozSlNZOFdk?=
 =?utf-8?B?VnBnUkVjUFRqelhaMzNobktDM3BMYmY2ais3YW1ZTjZDQmRSNGhpakt0QzBB?=
 =?utf-8?B?M09hSGJZTDN3TmszTWVRU2IrV0F5c1hkUzJEekt1d1Jla3BKdUtkQ29DT3lZ?=
 =?utf-8?B?US9ZanB2OHNCaFRsTFVESEN4dHU4aHFCekF4UEZOSDYzZGcvWVhPcWp5MCtD?=
 =?utf-8?B?SGVJNmhjajd5ZnFZOVBwWmk0cng2RHNzUERMbFh1OWNLLy93bmtmYndpN0U3?=
 =?utf-8?B?UkNhWUpDRWRMaVRSY0pDekpnQVRvU3c0UEpUU3N1TlZCYXRqa0tKdllVQ0tl?=
 =?utf-8?B?eUVNOTh3eDhnSFg1amtpVzFhZGlaQ3RvNE9FbUdqMVQ2djc5RExsUU5WUU44?=
 =?utf-8?B?ODJXa2FIajBVZU4vY3piWjN4QVladDFRaFJmcTdjVmZaejRHdXZiZTdyUDVB?=
 =?utf-8?B?SDg2U29QTnVMcGg0RjlRTzQwNUI4SjIzelk4dUd2cTNUNXlCUVNFWWZwVmIz?=
 =?utf-8?B?b2JEOHVQZVZjUGJ5WkgybVJkQ2M1OUVrZktMYmdzZG9FbTNXNnpHSU04ejhu?=
 =?utf-8?B?UHd0Y3IwbTd4aGQrZ2RWUm90dEl1d0lpQmw1MEpCTzR5cTdmWllmNzZLQlc5?=
 =?utf-8?B?cllHOHJwSnR6bFJ3SFBmTStEdWEwSnhNOGRzS3pFRjRTUXlCTVdJYjAyQWdu?=
 =?utf-8?B?SEdTbDczUWV6ZmtGNjJyTEowMlJPd3lqd3VGSDl2eHNzUEZyM0wrK0laK0gr?=
 =?utf-8?B?RGRHRy9RK3ovYWl0MVhJa2ZPSWV1TFl5RHEzZUlJUDZ6YXpyUlI2aGpjYTVT?=
 =?utf-8?B?Y1ArYWVobFdCRng3QmQ5RVB0RUhpaytKRVR6NndBNXJqd3pCQkpwbEVoMWJU?=
 =?utf-8?B?QnlVKzcyT0MrVUh4R1Q0QnFKUEYxdFdsOUpRZVFVaGV4U0FMV1JOaEc2OWJn?=
 =?utf-8?B?WHBRdTBiczdHL3FuUHBjVXhUVzFXb2c1U1N3YjBKR05uUkdDRCtBV0wyUkFv?=
 =?utf-8?B?ZmFtTS9uWlJ6Uk9WN1ZWaFU0V1ZBUzhyclROOExoYUNIUm5MK25Zdm9FSnZt?=
 =?utf-8?B?QlYvSFF1dFFmRm1BMzVNRFFnWGl5UFNDT3VzREprUVNHZTFFMFl4NkViOU9S?=
 =?utf-8?B?RFBJTlJvTGUxUkFEN1lWRitGVzJqWFYvOUhxUjBrT09FditveThWTFhGMnZU?=
 =?utf-8?B?Z2NBSXpPcVM0U2YxdzBYMWQ3WnQrYndLbmNFOFRnNm1NTFJON1JnTFowTGxE?=
 =?utf-8?B?NG1iNHAzdUNFOWlZQS81QWtiSGNHQVZ6MElNcmw5ak4wbnpFakFCMzE0Umg1?=
 =?utf-8?B?UVJqa0xZcTNoUVg3c0k3elQrQklTai84Uk9tVjhOZHFudVlydVdjM3dZT3JD?=
 =?utf-8?B?bzA0ak1SVS9GT3NNZ0xBUWNtT2s0YkVKN0hoQ0tubktHNTZBUGVzU29tRnpw?=
 =?utf-8?B?U2I1VWQ0NmpwSzUraVJVc0VZYUdja2I3bzVZVzJ2RlJyZXFLSUFCN0V3SkdR?=
 =?utf-8?B?bnIvKzFsK1pLSU1YTjNiVWQwb212VjkrUTlVU1JnM01CY3FIVERvcXJZUGt3?=
 =?utf-8?B?WjRLWEpYVzRxdWd1QnNtNkZBSEJjNVEwS1QybWM5ZkJaZVMzZkZsRytPUEtY?=
 =?utf-8?B?U2RHWkJkTWVIN1FWaDB6ZjEvdmlwVjlpeWlqbWF2NTJMNEhLOUs2V0pQMlFq?=
 =?utf-8?Q?vtf7AsYbqnpO41eYu5p4K5P9yeU8P2u4fJub6BCUz77o6?=
x-ms-exchange-antispam-messagedata-1: sR1U19/RFTXU5wHvC5QczrG2VyRkm4r/B/E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <440FDD3A8F2AFE448DC1E2AA44A39EB9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: siADaj1tYJf5peKSWWLLR2Mv7qNxj/4RNXm3FSwtp8ytcbNAMyuMHgEy9tzZHEDXY5Z0vhuF24mQjY6eCkflFh6+pp7YZaX7Fd3A3I7f+jrLF3GC5GI/VH5ci8lYqGzooi8x6OBAZF74piTiTQ5/tk7r/c67LyZgoZI33DEKKnyoLQHGZmaR0GE8V5gD+d++0rT5Ny68vY9OFqs7VGuAp6u7RFKNJpxrUmQL/bztKZyXEqScHvd+03ugCoRkz7a+CWnwDwf5RZrfkBYDY4Jk/YW+1yT/byhYej/1O/s63BuyVZpzpj9gtEBtArkcV4YDltTq2q78BUDYflZVZvP68w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sCvK3fiPJIR62a3KHXOxmVueKopC8wMaCq+/Ah7jJpX0Ynq8R3I4TsriQLuJGRZbir7hta9hh5ZQgqPghtgUu8SexQVohXZ6GvjhnI4Wdx2yKIBRznBryWjr+M/RwPlt3qHlEQA0DOPr96H0+U1EqW7QY/3zHeEiA3i6JTNC11C0X0UJOi2oX8w19X/scR34Vgeqdjl+rvfHEXgWxaqyS+0zLnLbG2w2iGtwjQH2XazvDEpxGTSCKWI2flOkWPm+OorV39hInDFYt3ymh+o8OsPoJnNozjwEWqQd4nu82ArPnGBV5pxGbKUJ7xuuXKwUew34bu5JtiwpQMm7RjH+R462uPuUPvb2BXdtu9WM7KfuLquyl1sW+yLNmOWg75q6leRzGAs/grbAZy2cXPgh8eIfVo6Ot3bgY1ygDONWIMDcMqzl/yeZZgy1udUDQfjngud8/tGOGtbGYW/9n8/JMTddcjFy5W4j9iu8ULlJE1Cnavmq53glha5B7+POcUr4BTIHICknSAY+DlnrTkYhmHgu67qP93yA+lXUVv6G7Zp2aDk0jGNkkKnV62R7CeuXmMe8Yb+Swd3UNT0jdyjnHKxwezQ0NgodRxUDDvLM41j1RMEHnIN4aWmdNKPMtzoD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2206e67e-41e6-41a6-14b4-08df2fedce0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 03:37:32.0405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRWelKDy/0/Nacrpw3MZxyOUhZ661Dx/JuF9drouaBx8eLc3WJLpri44AMLHQAj5dkdiL0q0sszjmzyFjKuls8E0WxDDnWdUW1udZtBWby4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9293
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDIyOjA2IC0wNjAwLCBTZWJhc3RpYW4gQWxiYSBWaXZlcyB3
cm90ZToNCj4gcG1wX3VubG9ja19lbnRyaWVzKCkgYm91bmRlZCBpdHMgbG9vcCB3aXRoIHBtcF9n
ZXRfbnVtX3J1bGVzKCksIHdoaWNoDQo+IHJldHVybnMgdGhlIG51bWJlciBvZiBlbnRyaWVzIHdo
b3NlIEEgZmllbGQgaXMgbm90IE9GRiByYXRoZXIgdGhhbg0KPiB0aGUNCj4gbnVtYmVyIG9mIGlt
cGxlbWVudGVkIGVudHJpZXMuIFdpdGggYSBzcGFyc2UgY29uZmlndXJhdGlvbiB0aGUgbG9vcA0K
PiBzdG9wcyBlYXJseTogd2l0aCBlbnRyaWVzIDAgYW5kIDEgT0ZGIGFuZCBlbnRyaWVzIDIgYW5k
IDMgbG9ja2VkLA0KPiBudW1fcnVsZXMgaXMgMiwgdGhlIGxvb3AgY292ZXJzIGkgPSAwIGFuZCBp
ID0gMSwgYW5kIGVudHJpZXMgMiBhbmQgMw0KPiBrZWVwIHRoZWlyIGxvY2sgYW5kIGFkZHJlc3Mt
bWF0Y2ggYml0cyBhY3Jvc3MgcmVzZXQuDQo+IA0KPiByaXNjdl9jcHVfcmVzZXRfaG9sZCgpIGNs
ZWFycyBtc2VjY2ZnLCBhbmQgd2l0aCBpdCBSTEIsIGJlZm9yZQ0KPiBjYWxsaW5nDQo+IHRoaXMs
IHNvIHBtcF9pc19yZWFkb25seSgpIHRoZW4gc2lsZW50bHkgZGlzY2FyZHMgZXZlcnkgc3Vic2Vx
dWVudA0KPiBwbXBjZmcgd3JpdGUgdG8gdGhvc2UgZW50cmllcy4gVGhlIHN0YWxlIHJ1bGVzIHN1
cnZpdmUgZm9yIHRoZQ0KPiBsaWZldGltZSBvZiB0aGUgbWFjaGluZS4NCj4gDQo+IENsZWFyaW5n
IG9ubHkgUE1QX0xPQ0sgYW5kIFBNUF9BTUFUQ0ggaXMgbm90IGVub3VnaCBlaXRoZXIuIFRoZSBw
cml2DQo+IHNwZWMgb25seSBtYW5kYXRlcyB0aGF0IHRoZSBBIGFuZCBMIGZpZWxkcyBiZSByZXNl
dCwgYnV0IFFFTVUga2VlcHMNCj4gZGVyaXZlZCBzdGF0ZSBuZXh0IHRvIHRoZSBhcmNoaXRlY3R1
cmFsIHJlZ2lzdGVyczogcG1wX3N0YXRlLmFkZHJbXQ0KPiBhbmQgcG1wX3N0YXRlLm51bV9ydWxl
cyBhcmUgcmVjb21wdXRlZCBmcm9tIHRoZSBwbXBhZGRyIGFuZCBwbXBjZmcNCj4gd3JpdGUgcGF0
aHMgb25seSwgbmV2ZXIgYXQgcmVzZXQuIHBtcF9pc19pbl9yYW5nZSgpIGNvbXBhcmVzIGFnYWlu
c3QNCj4gYWRkcltdLnNhIGFuZCBhZGRyW10uZWEgd2l0aG91dCBjb25zdWx0aW5nIHRoZSBBIGZp
ZWxkLCBhbmQgdGhlDQo+IHBhcnRpYWxseS1pbnNpZGUgY2hlY2sgaW4gcG1wX2hhcnRfaGFzX3By
aXZzKCkgcnVucyBiZWZvcmUgdGhlIEENCj4gZmllbGQgaXMgdGVzdGVkLCBzbyBhIHJhbmdlIGxl
ZnQgb3ZlciBmcm9tIGJlZm9yZSB0aGUgcmVzZXQgY2FuIHN0aWxsDQo+IGRlbnkgYW4gYWNjZXNz
IHRoYXQgc3RyYWRkbGVzIGl0cyBib3VuZGFyeSBvbmNlIHRoZSBndWVzdCBjb25maWd1cmVzDQo+
IGFueSBlbnRyeSBhZ2Fpbi4NCj4gDQo+IFplcm8gdGhlIHdob2xlIHN0cnVjdHVyZSBpbnN0ZWFk
LiBaZXJvIGlzIHRoZSBjb3JyZWN0IHJlc2V0IHZhbHVlIGZvcg0KPiBldmVyeSBmaWVsZDogYSBj
ZmdfcmVnIG9mIDAgaXMgQT1PRkYgd2l0aCBubyBwZXJtaXNzaW9ucywgYW5kIGENCj4gbnVtX3J1
bGVzIG9mIDAgcmVzdG9yZXMgdGhlIG5vLXJ1bGVzIHNob3J0IGN1dC4gUmVuYW1lIHRoZSBmdW5j
dGlvbg0KPiBzaW5jZSBpdCBubyBsb25nZXIgb25seSB1bmxvY2tzIGVudHJpZXMuDQo+IA0KPiBG
aXhlczogNGJmNTAxZGMwMTE4ICgidGFyZ2V0L3Jpc2N2OiBwbXA6IENsZWFyIHBtcC9zbWVwbXAg
Yml0cyBvbg0KPiByZXNldCIpDQo+IFN1Z2dlc3RlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFNlYmFzdGlhbiBB
bGJhIFZpdmVzIDxzZWJhc2pvc3VlODRAZ21haWwuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2
MjoNCj4gLSBaZXJvIHRoZSB3aG9sZSBlbnYtPnBtcF9zdGF0ZSBpbnN0ZWFkIG9mIG1hc2tpbmcg
UE1QX0xPQ0sgYW5kDQo+IMKgIFBNUF9BTUFUQ0ggb3ZlciBhIGJvdW5kZWQgc2V0IG9mIGVudHJp
ZXMsIGFzIHN1Z2dlc3RlZCBieSBSaWNoYXJkLg0KPiDCoCB2MSBhbHNvIGxlZnQgcG1wX3N0YXRl
LmFkZHJbXSBhbmQgcG1wX3N0YXRlLm51bV9ydWxlcyBzdGFsZSBhY3Jvc3MNCj4gwqAgcmVzZXQs
IHdoaWNoIHRoZSBtZW1zZXQgY292ZXJzIGFzIHdlbGwuDQoNCkkgdGhpbmsgeW91ciB2MSBpcyBh
Y3R1YWxseSBiZXR0ZXIuDQoNClJpY2hhcmQgYXNrZWQgd2h5IHlvdSBkb24ndCBqdXN0IHplcm8g
YHBtcF9zdGF0ZWAsIGJ1dCB0aGUgYW5zd2VyIGlzDQpiZWNhdXNlIHRoZSBSSVNDLVYgc3BlYyBz
dGF0ZXMgdGhhdCBvbiByZXNldCAiV3JpdGFibGUgUE1QDQpyZWdpc3RlcnPigJkgQSBhbmQgTCBm
aWVsZHMgYXJlIHNldCB0byAwIi4gU28gd2Ugc2hvdWxkIGZvbGxvdyB0aGF0DQoNCkFsaXN0YWly
DQoNCj4gDQo+IHYxOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYw
OTE2MDM0MzMxLjIzOTA0MjctMS1zZWJhc2pvc3VlODRAZ21haWwuY29tLw0KPiANCj4gwqB0YXJn
ZXQvcmlzY3YvY3B1LmPCoMKgwqDCoCB8IDQgKystLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvcG1w
LmMgfCA5ICsrLS0tLS0tLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvcG1wLmggfCAyICstDQo+IMKg
MyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KPiBp
bmRleCBkYTRjMWEwOTBiLi4wYjcxMTk2NTA3IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3Yv
Y3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+IEBAIC0xMDQ4LDcgKzEwNDgsNyBA
QCBzdGF0aWMgdm9pZCByaXNjdl9jcHVfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwNCj4gUmVzZXRU
eXBlIHR5cGUpDQo+IMKgwqDCoMKgIH0NCj4gwqANCj4gwqDCoMKgwqAgLyoNCj4gLcKgwqDCoMKg
ICogQ2xlYXIgbXNlY2NmZyBhbmQgdW5sb2NrIGFsbCB0aGUgUE1QIGVudHJpZXMgdXBvbiByZXNl
dC4NCj4gK8KgwqDCoMKgICogQ2xlYXIgbXNlY2NmZyBhbmQgdGhlIFBNUCBzdGF0ZSB1cG9uIHJl
c2V0Lg0KPiDCoMKgwqDCoMKgICogVGhpcyBpcyByZXF1aXJlZCBhcyBwZXIgdGhlIHByaXYsIHNt
ZXBtcCwgYW5kIG90aGVyIHNlY3VyaXR5DQo+IMKgwqDCoMKgwqAgKiBleHRlbnNpb24gc3BlY2lm
aWNhdGlvbnMgdGhhdCBzaGFyZSB0aGlzIENTUiwgYW5kIGlzIG5lZWRlZA0KPiDCoMKgwqDCoMKg
ICogdG8gY2xlYXIgc3RhbGUgZW50cmllcyBhY3Jvc3MgcmVib290cy4NCj4gQEAgLTEwNjAsNyAr
MTA2MCw3IEBAIHN0YXRpYyB2b2lkIHJpc2N2X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLA0K
PiBSZXNldFR5cGUgdHlwZSkNCj4gwqDCoMKgwqDCoMKgwqDCoCBlbnYtPm1zZWNjZmcgPSAwOw0K
PiDCoMKgwqDCoCB9DQo+IMKgDQo+IC3CoMKgwqAgcG1wX3VubG9ja19lbnRyaWVzKGVudik7DQo+
ICvCoMKgwqAgcG1wX3Jlc2V0KGVudik7DQo+IMKgI2VuZGlmIC8qIGlmZGVmIENPTkZJR19UQ0cg
Ki8NCj4gwqAjZWxzZQ0KPiDCoMKgwqDCoCBlbnYtPnByaXYgPSBQUlZfVTsNCj4gZGlmZiAtLWdp
dCBhL3RhcmdldC9yaXNjdi90Y2cvcG1wLmMgYi90YXJnZXQvcmlzY3YvdGNnL3BtcC5jDQo+IGlu
ZGV4IDQxYjU1NTE5YTguLjQzN2UwZmYyYWYgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90
Y2cvcG1wLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYw0KPiBAQCAtMTk5LDE0ICsx
OTksOSBAQCBzdGF0aWMgYm9vbCBwbXBfd3JpdGVfY2ZnKENQVVJJU0NWU3RhdGUgKmVudiwNCj4g
dWludDMyX3QgcG1wX2luZGV4LCB1aW50OF90IHZhbCkNCj4gwqDCoMKgwqAgcmV0dXJuIGZhbHNl
Ow0KPiDCoH0NCj4gwqANCj4gLXZvaWQgcG1wX3VubG9ja19lbnRyaWVzKENQVVJJU0NWU3RhdGUg
KmVudikNCj4gK3ZvaWQgcG1wX3Jlc2V0KENQVVJJU0NWU3RhdGUgKmVudikNCj4gwqB7DQo+IC3C
oMKgwqAgdWludDMyX3QgcG1wX251bSA9IHBtcF9nZXRfbnVtX3J1bGVzKGVudik7DQo+IC3CoMKg
wqAgaW50IGk7DQo+IC0NCj4gLcKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgcG1wX251bTsgaSsrKSB7
DQo+IC3CoMKgwqDCoMKgwqDCoCBlbnYtPnBtcF9zdGF0ZS5wbXBbaV0uY2ZnX3JlZyAmPSB+KFBN
UF9MT0NLIHwgUE1QX0FNQVRDSCk7DQo+IC3CoMKgwqAgfQ0KPiArwqDCoMKgIG1lbXNldCgmZW52
LT5wbXBfc3RhdGUsIDAsIHNpemVvZihlbnYtPnBtcF9zdGF0ZSkpOw0KPiDCoH0NCj4gwqANCj4g
wqBzdGF0aWMgdm9pZCBwbXBfZGVjb2RlX25hcG90KGh3YWRkciBhLCBod2FkZHIgKnNhLCBod2Fk
ZHIgKmVhKQ0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuaCBiL3RhcmdldC9y
aXNjdi90Y2cvcG1wLmgNCj4gaW5kZXggNGM5NWMyNzY3YS4uOTk1NDY5MzRmYyAxMDA2NDQNCj4g
LS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuaA0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL3Bt
cC5oDQo+IEBAIC03OSw3ICs3OSw3IEBAIHZvaWQgcG1wX3VwZGF0ZV9ydWxlX2FkZHIoQ1BVUklT
Q1ZTdGF0ZSAqZW52LA0KPiB1aW50MzJfdCBwbXBfaW5kZXgpOw0KPiDCoHZvaWQgcG1wX3VwZGF0
ZV9ydWxlX251bXMoQ1BVUklTQ1ZTdGF0ZSAqZW52KTsNCj4gwqB1aW50MzJfdCBwbXBfZ2V0X251
bV9ydWxlcyhDUFVSSVNDVlN0YXRlICplbnYpOw0KPiDCoGludCBwbXBfcHJpdl90b19wYWdlX3By
b3QocG1wX3ByaXZfdCBwbXBfcHJpdik7DQo+IC12b2lkIHBtcF91bmxvY2tfZW50cmllcyhDUFVS
SVNDVlN0YXRlICplbnYpOw0KPiArdm9pZCBwbXBfcmVzZXQoQ1BVUklTQ1ZTdGF0ZSAqZW52KTsN
Cj4gwqANCj4gwqAjZGVmaW5lIE1TRUNDRkdfTU1MX0lTU0VUKGVudikgZ2V0X2ZpZWxkKGVudi0+
bXNlY2NmZywgTVNFQ0NGR19NTUwpDQo+IMKgI2RlZmluZSBNU0VDQ0ZHX01NV1BfSVNTRVQoZW52
KSBnZXRfZmllbGQoZW52LT5tc2VjY2ZnLA0KPiBNU0VDQ0ZHX01NV1ApDQo=

