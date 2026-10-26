Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D3606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=YDm1+85E;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=EUxPefB4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLUYe-0005mj-NT; Mon, 26 Oct 2026 19:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLUYZ-0005mN-EB; Mon, 26 Oct 2026 19:56:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLUYX-0003mz-9U; Mon, 26 Oct 2026 19:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793059004; x=1824595004;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=2b9PTSGs05/rudSwyIZsTCYAWKGDoFYiENLsZFi5Xfw=;
 b=YDm1+85EBa7UASC3/aB/VA44+7rigvTPjfgymAyY5iwcOCl1+WT5BKi9
 M6QWrfNBzuVZrX/ugqjG2+gWIOr4xj5Z4mpL1DXYz8/uSN84Vb5ZFB8XZ
 r+MKgOyG2lrUDGjsW0SkdEyJXzWM4VmvUpBnfh8tWzx6CnpZTHm/ji1ZM
 fEG9NJKKMnRSKEtfGL6ziSkI/SWi+HQG3jiavNWWZ2GMK4qwFPDrBNVnN
 4/0RO2wwFlgcgxIjur7luwKxKBk6Onu4/GJ+709Dfehd0F5WEdtU1cbxA
 yEcdUB+aJUhQBm1u8elytxJNMFDA0blOMtOM2KZT0fcpeuVw618GtM699 Q==;
X-CSE-ConnectionGUID: k4uA48R1QpODHN7tcGwJoQ==
X-CSE-MsgGUID: +++mNZwOQ5q4GRuZ2mX/mw==
X-IronPort-AV: E=Sophos;i="6.27,180,1786982400"; d="scan'208";a="157447176"
Received: from mail-westusazon11012002.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.2])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Oct 2026 07:56:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6DZ4/X5+UA6ctyYPbcsnj9bt1CxsugEsjSmiOBdekbErkkALtVGwp3UxOVxbeV8IMeGpWWomwOrUwyKhvOJUVuHy7g0WhJZlVWGrXZvuChqW3QRKNBsBKMMAQ8gDGSMoyLGA3fo1GihYypqnr3R2R+fWryVULhAW/Fh2yZnR91KWletu1x3ivg/1psrzhtncpnuNKJZ+V7SHARmDPXq/rRzHDQjuvqCzIbnHuW4L9AIdCFaeMC3pqirzqNUtV0/toDV14R7vER6Nz8VngGaWtESpJLRWi9cAReql5Gmwcv3TjFTh4qFGuObRvZ4ifMJIKhVPHpD9H2Dk3UJXdjzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b9PTSGs05/rudSwyIZsTCYAWKGDoFYiENLsZFi5Xfw=;
 b=mkyalP6mhsZJFFNyivZ7k/KkuWsDhZ/anLt1t/kMggYcfLoydq05jRbMIzw25rVAosE93zav9PUJRBVb69D173QpVBKuBIRVMQND+fNbB33HwRH8tGbppg1k0Sp9oabE/B+L0+Zw0lnuWnUy4Y+EAbPq73oQ8GLMc0bKM68RhMzjmAKj+A3lWGs7bNGbY6BSXz2/hOmQj+dNI6T9JRRHXOg3lgn5l/UqyrzNCR1kdBsWnx+lGirRpU1rgRHzo7TY55Oc1rumNr45J15WDXcqSpJwd4O4tDw2hFIJsKegzhUgbRQ12hoc08fif4d+vdPEZPpECekdWhmJjkrnapuIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b9PTSGs05/rudSwyIZsTCYAWKGDoFYiENLsZFi5Xfw=;
 b=EUxPefB4LKqmjSPJ80JMnNMLQnd2O/56UDSSVrXfEJVTEi2RIqDjGrDoQ8HYZ4EmfuAQQ2rzigJzlcjD5fuolfCWat8mA7DtPZP13pNnS/tFXRqZLX3PEhNxEzeo/Re1/ziB469kXHcvyrlCerrETFHDvuiDEpXP5nRqTAXvBF8=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS0PR04MB993579.namprd04.prod.outlook.com (2603:10b6:8:432::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:56:38 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 23:56:38 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "sunilvl@oss.qualcomm.com" <sunilvl@oss.qualcomm.com>
CC: "anup.patel@oss.qualcomm.com" <anup.patel@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "shankar.c@oss.qualcomm.com" <shankar.c@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "prajwal.n@oss.qualcomm.com"
 <prajwal.n@oss.qualcomm.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "mst@redhat.com" <mst@redhat.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "fustini@kernel.org" <fustini@kernel.org>
Subject: Re: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Thread-Topic: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Thread-Index: AQHdXHGe0JoR77z4oE68l74n64s/PrcJCamAgAIJGICABX+hgA==
Date: Mon, 26 Oct 2026 23:56:38 +0000
Message-ID: <95082036aaf5b0ed1bee69fc21fcbb18fd74d61f.camel@wdc.com>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
 <91f1cd890aac1907f335ce3fdd22e6adf685c594.camel@wdc.com>
 <CAB19ukGtrbCV8s_WKnE2vDF5P4iiyPXYhyyJjqTu-S0823mjUg@mail.gmail.com>
In-Reply-To: <CAB19ukGtrbCV8s_WKnE2vDF5P4iiyPXYhyyJjqTu-S0823mjUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS0PR04MB993579:EE_
x-ms-office365-filtering-correlation-id: c112e818-2ca7-4980-4cfd-08df33bcc656
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|19092799006|23010399003|1800799024|261026140227099003|38070700021|4143699003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info: XiH4raVC0JqnZyqX4yU05nX8JbNnEdcLq+L1DMfXb60PeV4y5qMvhDocQXirZwGeKzUagRhtsz+Tiph7TsGBx9OBeFv9WfX4uRZT2nVXvrijN6vw/+ccPKC8x2Yg9jsaaWLoONZBJgUYepkuyN9989M5ai/dq5dMfK51AAzDS2aqLBZ8aT/Jrmq8g8yj8GlEtRz0LGsS4NGmLmrS+BZszeZ2b65aiPrIYcuZkG1W70i45zSA8q3qXNRmj44bnWc8y64VmfAS3B+nUWFaAjajIE/FvSgNnPsdlQTD3crgKyMQisD1xn1kkXX0R4ICd9eFhrVAMBbHnQTl0ah8zu2e4PE9wqHPZqBiV6wXvnljyzQyNmUmvB6pmssE42c96BsBQcA4v3Rr5ZXoicMBRzuHko3MHTvNGgiXiR3hyP6ODLZysuA5xQzdl4vI608uCHZjmdHVZlQRxBxK41aJ5vfsH8OgGOfamcwaH+M+KHznDOUeekuMmxlClX6jUUgkHroISiUk+Y0zD8p4xiC6Gg35HkD81QkxnEYDrz7CGa2daKX5VFHHxy9gUT8+JCl3aGSAoyuc6z//sh4he50xxQ9Ie0vVxK3Gy8m+Z5V3GszXeLSSfdTDNYuN2SLkQ2wct8Hk6B0oTEuDbM8CbKVuv+jmOj92vNxJLJ50y9GgTy2BWYJkplbJVY+Mwf9SQd3JeO/1B9R9s8Zw2PzQd5CFwj5Eo9yy0Ou7gtL9ia8P0NjUMrc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(19092799006)(23010399003)(1800799024)(261026140227099003)(38070700021)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU5mMlFzUndrR2RmaFErb3ZiSi9kVFhMWHBJakNKTDU4amxqc013YmdHMks2?=
 =?utf-8?B?WTVKK29KOGZYR0U3OFh2TisrQ1hiVE1TU0JGa09BdFltT05BTUhkRVp2MEhn?=
 =?utf-8?B?djRpUEQ4d1hJZlFSeW9rMGd6MmVEdW10SUNySnZza0RSQmluU3A2ZzRtWUZp?=
 =?utf-8?B?WFZNZlFWL1hDemN6bmVmVmZKN2VBU0k1RU40VmR2cEVHdXdncFArOTZTcG03?=
 =?utf-8?B?eEF2OW9TY2ZMN3JEeFdubG1XUmdzZTQwQ09LMk9OSlQvcGxBWFJJZTBZa0Nz?=
 =?utf-8?B?ZHZOa3pFb3o1ZDMwY1JxWVd5SW56elhCM2FLS2VYcENnelNmb3pHK2E0cVpO?=
 =?utf-8?B?aHRXbzk0ejRXV3Q3SWJsS2x0MmNodFd0MEdSaFBMeE0yVkVzMWJya1crSU5H?=
 =?utf-8?B?RlBBcG52ZjZJTTllNXdHd0lIOWgzNTVvL1hXRGw1K3dXbGxMOFpQcmxJVnVJ?=
 =?utf-8?B?MkpVcmxnc3RiYWdNM3pvWUs1bm1YdHA1aGk2MWU3a1N5cThDRzRKbGZiTkZv?=
 =?utf-8?B?YklIb1JjV0h5ek0vOTVMbWJyQitBU0E0SkNOUkpHTTRIQjJCNTBJQjJHdWN2?=
 =?utf-8?B?TjBzTHl6UGJUQnBhcDNTTFE2RCtKU0dxbzNjVkZpcVlyMzZTbUxPb2gxUndp?=
 =?utf-8?B?aFZNakhEZDQ3aXZoOGhCbDhTRkwzZnNZMWxzMlMwTmVUM2ZpRmZid2lwOEw5?=
 =?utf-8?B?OHlZUFF5UVJtaHUvTUdCai9sblFJWmMwbFo3TTQ0dk9Sd3BnZDh5UEVocHpL?=
 =?utf-8?B?RzltNWJlM0lURkNKTDMxeWNoais2WkFqU0w3UWdqaFZQRllMbllieWdsdzhN?=
 =?utf-8?B?dWY5a3JCWE5OY3hDLy9XK1hzM1VRWXBBQ1NBS2tlVmFSbkd3ZVlDQTZzaXVu?=
 =?utf-8?B?SmJEeXczSWNTc3VaTmNlWHBmQ21XWDNxV254RzZCMmVCdFZRTGE4Mkd2T3Nq?=
 =?utf-8?B?Mmc4MDlJYVc3TVptVEpnV1NxaUZUYmJPdW5pSU1xc1ZxalR1dGpTbnFGekNj?=
 =?utf-8?B?aVd6azMzWU1rRHZIV0RsMFdMbE5PcytOSWJpSzBCQ1djYWhHZU9CKzdIbW51?=
 =?utf-8?B?SkxCWHRtZGl6bTIwU3VJTFN0cGxOemg2K3UrRk1OSnZFRmFKRFEyRjU5L2RR?=
 =?utf-8?B?eEZTQ3I5aFNCSzFWMnV0TTdKQ2ZZUmlScHFVRG1JN2ZxTUd2SUVab3VMNk1V?=
 =?utf-8?B?TEV4Qm56b2NOQjh4NXFWVFAvRkxoVHVEMWkzMnR3MThsVy84clVhaHJrT2FS?=
 =?utf-8?B?N2NoYzZhbG9iRmk1YUFKN2VqYmRnTXkrYmRGQU5MelVXYlczbUNic0xOMWJa?=
 =?utf-8?B?dzlMK2F5K3IzZHA2R3NmYTFvbHgvUEZ0U0dZZ2MzQ0pUNDBHTVdDanVJV1Vx?=
 =?utf-8?B?UnJ4R3NoMjgzQU9Sd21kV25CY0h1ZFhEY1A0YW1wajFwSFMweEJOWTJlUjFC?=
 =?utf-8?B?T01kWGVyQ09FcG5ZTlFQck5uZXcwTGZuNmYzaEN2QTIzV0lsa0xiNjUybXVo?=
 =?utf-8?B?Qk1KeW5Fck5Kd1ZVQlNDNnBla1pRZVB2dG92b0lTQVJkYzI3QTRKV2Ezb0hY?=
 =?utf-8?B?TGU0ZEZPL0V1SnRoUUVnSXc2QUJuY3ovWFFURmRCT0NJVFlVV1hRdlM5K2hZ?=
 =?utf-8?B?RmZPUnQ0Mm02V2s1cHFRWklkMVRSV3pQbGNGejdCZ3VEcEtGak9Rc0YrKzZw?=
 =?utf-8?B?bTlQWU1DKzdLQmRFaTVEMWlBUlRlckhQeDZZRVZ1ZHVMc2U2elRZa1hsZVky?=
 =?utf-8?B?RE5FeFZyL1ZpdDFOS0haTDZrZW4zbHB6ZlNXNFlzWWxXVEswVzJ4cmx1TzVU?=
 =?utf-8?B?STkrTzVEWUNiby85NWlmRkVURCsrLzRBUG5zeXYzSEpTT2svVXdmcExCbTZF?=
 =?utf-8?B?aW1neTFCVlovTm4yU0hzSFBNd2ZDNEZsak0wL3ZYa2ZORW5vNWJjb1MrRFRC?=
 =?utf-8?B?TnBKWlBCTGppd2xOSGQ3RG5xQWx5QisrbnlYUXhzelFwOWFZMWxRdUFtTU90?=
 =?utf-8?B?VnZKS2pnZWc4ZFc4UGZLOVl2V0pHdFdjQU1STzhZNmhNbzBwV1NlR0JuYnQ0?=
 =?utf-8?B?c2NWQk5xTStGZVIzZXFZTk4xbzMrRmNXaktDM2xDVDdrcHhwY2Ria0tGMk5Y?=
 =?utf-8?B?WUErOWdtMERCQ3RLYVFnSUlNTmN3bzRxK2pON0RiYnY4NW9CZ2dWTFlDZlcy?=
 =?utf-8?B?SFBzZU84azNzOFV5a0R2bUtjL256ZEtGa2hWNHpXTmsrN2JDUUkyREVSUlBS?=
 =?utf-8?B?ajFBbDZIMjNyZlUvZXJPVzBpYi9UNXRUdE9ZZFpNK2RPem1iV2IvUXVnUFJl?=
 =?utf-8?B?WXlQMm9zRy91cmF6MW9JT0dsdHBMcnJRSm1Va0J0aHNmSU5VeVM1Z2I4a0F6?=
 =?utf-8?Q?Ur2Sdt959TGv6R2nT716CirWrImTM+Ku8IdOGyBfOnp0a?=
x-ms-exchange-antispam-messagedata-1: TdoiN+icGWQ1P6pCirt7fxdoT9Ged/dvUPs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F83BA00519C6847ABABE6DD4BFEA122@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VuzwtM/R7kmtX8rEiaVuZTCCj0MdZr5qMbX2JbePRV+RhD+qlhmFdSNkx/y84VQ/hDDKEgkgks6+JZiRPR5cYhUsdhLyleALhR9qHLITZUXcRxeC9lsfhALnAg3dVbIQTLUry+e3HpwyRFqYuWUEvmHc1LGJL7CpSegWVPi0wljK1CfRgS1EFRxSf4b2pUB2m50bOAPNdP5QmvqTJidk4wgUjucT74HWZk8Fwn/EXm+JybxNELqzlg4YF8wUXJ7cQYaz38qbICChBILaB9TaGLFF2WxdUaLspPMdPRzTpXQAQMNwOosEXITqmE9SfRh4rE9cdSA+ByI0QaFNhfknRQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cb9I3AmnOMYjyOVhyVrAzVCGIFLdBgdVIZ7kQuBL0ys2Sjd4mbLzDyIPYaDuDFaUfkSJnceip1NR0+CR3uB4kWEt1P2mpUWMii59tHaJXiSkb4MYfi+BFppnF82FbAvm1GkwpdFGehY46WwtsX6oRbiO+Y9Ph5gcpZVAaiFy2GXPfc2ZlAUYaKGDTrmECYmm99WtPPJem1jXBOZi22eOC0GbQnybk0Nu4nGMXKvNkxh9vvNs//R5ACfPcIAHtaMN0OIOu4ZDeP/NDR1fUyW7YK64T/dPn7XSFirHmTSOOfKWoJf7MtX5aoA9lIotfUCAJoKQX3W8Vcu62Ks2Q6W+bZIo3Y0HTFPPhPW72USdFwLA9EL1XxXXNtvWaAFpWDZ9/0M9kIUo0jGxIWVZAzO97v48QwnvyPUG1kLvAXmrDbLvTD9EGgQYc1PFqnOLIWaXs46TfVKZpOFBteL+hTLAXk1TWvINbMrAB6hBA0PewwqE1ZxWiQrhRngXuS+1yVhhU2esZNZXrzhlqZhsv461Q0revZIXk7U9dkuF73l7KKAhws00whtgKh1nmQpDLWibEIqRi5dHtSqQP3YjbLcrPtgy/NCscufRSMpDLqk853NiStu0GGkd/I6eJYlphsYI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c112e818-2ca7-4980-4cfd-08df33bcc656
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 23:56:38.3746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/4wzjPTODZNUHv881xhXawO/a+WmrLRFQr+EJrg7vvzku3GCPtu4DLc2tqBi4bL6tFGcCgNsGjWXchWdejgtiYLOA+e4Fs4X8wadRxFiRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB993579
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDE3OjI4ICswNTMwLCBTdW5pbCBWIEwgd3JvdGU6DQo+IE9u
IFRodSwgT2N0IDIyLCAyMDI2IGF0IDEwOjIz4oCvQU0gQWxpc3RhaXIgRnJhbmNpcw0KPiA8QWxp
c3RhaXIuRnJhbmNpc0B3ZGMuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjYtMTAt
MTUgYXQgMTI6MTkgKzA1MzAsIFN1bmlsIFYgTCB3cm90ZToNCj4gPiA+IEhpIGFsbCwNCj4gPiA+
IA0KPiA+ID4gVGhpcyBzZXJpZXMgYWRkcyBBQ1BJIFByb2Nlc3NvciBQcm9wZXJ0aWVzIFRvcG9s
b2d5IFRhYmxlIChQUFRUKQ0KPiA+ID4gc3VwcG9ydCB0bw0KPiA+ID4gdGhlIFJJU0MtViB2aXJ0
IG1hY2hpbmUuIFBQVFQgYWxsb3dzIHRoZSBndWVzdCB0byBkaXNjb3ZlciB0aGUNCj4gPiA+IHBy
b2Nlc3NvciBhbmQNCj4gPiA+IGNhY2hlIHRvcG9sb2d5IGV4cG9zZWQgYnkgdGhlIG1hY2hpbmUs
IHdoaWNoIGlzIHVzZWZ1bCBmb3IgbWFraW5nDQo+ID4gPiBiZXR0ZXINCj4gPiA+IHNjaGVkdWxp
bmcgYW5kIGNhY2hlLW1hbmFnZW1lbnQgZGVjaXNpb25zLg0KPiA+ID4gDQo+ID4gPiBUaGUgaW1w
bGVtZW50YXRpb24gZGVzY3JpYmVzIHRoZSBSSVNDLVYgdmlydCBjYWNoZSBoaWVyYXJjaHkgd2l0
aA0KPiA+ID4gc2VwYXJhdGUNCj4gPiA+IEwxIGluc3RydWN0aW9uIGFuZCBkYXRhIGNhY2hlcywg
Zm9sbG93ZWQgYnkgdW5pZmllZCBMMiBhbmQgTDMNCj4gPiA+IGNhY2hlcy4NCj4gPiA+IEl0IGFs
c28NCj4gPiA+IGVuYWJsZXMgdGhlIGNvcnJlc3BvbmRpbmcgY2FjaGUgYW5kIGNsdXN0ZXIgcHJv
cGVydGllcyBpbiB0aGUNCj4gPiA+IG1hY2hpbmUNCj4gPiA+IFNNUA0KPiA+ID4gZGVzY3JpcHRp
b24gYW5kIHdpcmVzIHRoZSBnZW5lcmF0ZWQgUFBUVCBpbnRvIHRoZSBleGlzdGluZyBBQ1BJDQo+
ID4gPiB0YWJsZQ0KPiA+ID4gYnVpbGQuDQo+ID4gPiANCj4gPiA+IFVubGlrZSBBUk0sIFJJU0Mt
ViBkb2Vzbid0IGhhdmUgYSB3YXkgdG8gZGlzY292ZXIgdGhlIENhY2hlDQo+ID4gPiB0b3BvbG9n
eSBmcm9tIHJlZ2lzdGVycy4gSGVuY2UsIEkgYW0gaGFyZGNvZGluZyBkZWZhdWx0IHZhbHVlcw0K
PiA+ID4gZm9yDQo+ID4gPiB0aGUNCj4gPiA+IGNhY2hlIHRvcG9sb2d5IHN0cnVjdHVyZXMuIFRo
ZXNlIGNhY2hlIHRvcG9sb2d5IHN0cnVjdHVyZXMgYXJlDQo+ID4gPiBhZGRlZA0KPiA+ID4gaW4N
Cj4gPiA+IHZpcnQuYyBpdHNlbGYgc28gdGhhdCBhIGZ1dHVyZSBzZXJpZXMgY2FuIGFkZCBzdXBw
b3J0IGZvciBEVCBhcw0KPiA+ID4gd2VsbC4NCj4gPiA+IEluDQo+ID4gPiBmdXR1cmUsIGl0IGNh
biBiZSBlbmhhbmNlZCB0byBzdXBwb3J0IHZlbmRvciBjcHUvc29jIHNwZWNpZmljDQo+ID4gPiBj
YWNoZQ0KPiA+ID4gaW5mb3JtYXRpb24gdG8gb3ZlcnJpZGUgdGhpcyBkZWZhdWx0IGhhcmRjb2Rl
ZCBjYWNoZSBkZXRhaWxzLg0KPiA+IA0KPiA+IFdoeSBub3QgYWRkIGEgdmVuZG9yIGNwdS9zb2Mg
c3BlY2lmaWMgb25lIHRvIGEgdmVuZG9yIGJvYXJkPyBUaGF0DQo+ID4gd2F5DQo+ID4gaXQgYWN0
dWFsbHkgbW9kZWwgaGFyZHdhcmUgaW5zdGVhZCBvZiBqdXN0IHByb3ZpZGluZyB0aGUgZ3Vlc3Qg
c29tZQ0KPiA+IG1hZGUgdXAgaW5mb3JtYXRpb24uDQo+ID4gDQo+IFRoYW5rcyBmb3IgdGhlIGZl
ZWRiYWNrIQ0KPiANCj4gSnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHlvdXIgc3VnZ2Vz
dGlvbiBjb3JyZWN0bHk6IHNob3VsZCB3ZQ0KPiBhdm9pZA0KPiBkZWZpbmluZyBhIGhhcmRjb2Rl
ZCBjYWNoZSB0b3BvbG9neSBmb3IgdGhlIGdlbmVyaWMgQ1BVIG9uIHZpcnQsIGFuZA0KPiBnZW5l
cmF0ZQ0KPiBQUFRUIGNhY2hlIGluZm9ybWF0aW9uIG9ubHkgZm9yIENQVSBtb2RlbHMgdGhhdCBw
cm92aWRlIGFuDQo+IGFwcHJvcHJpYXRlIGNhY2hlDQo+IGhpZXJhcmNoeT8NCg0KSXQgd2FzIGEg
cXVlc3Rpb24NCg0KU29tZXRoaW5nIHRvIGtlZXAgaW4gbWluZCBpcyB0aGF0IEkgKGFuZCBvdGhl
cnMgb24gdGhlIGxpc3QpIGRvbid0IGtub3cNCmFsbCBvZiB0aGUgY29udGV4dCB0aGF0IHlvdSBr
bm93IGFib3V0IHRoaXMgZXh0ZW5zaW9uLiBTbyB0aGUgY292ZXINCmxldHRlciBhbmQgY29tbWl0
IG1lc3NhZ2VzIHNob3VsZCBkZXNjcmliZSAqKndoeSoqIHdlIHdhbnQgdGhpcy4NCg0KUmVtZW1i
ZXIsIEknbSAoYW5kIG90aGVyIG9uIHRoZSBsaXN0KSBhcmUgbm90IHBhcnQgb2YgUlZJLiBXZSBk
b24ndA0KaGF2ZSB0aGUgaW5zaWdodCB0aGF0IHlvdSBoYXZlLiBJIGFsc28gZG9uJ3Qga25vdyB3
aGF0IERyZXcgaXMgd29ya2luZw0Kb24gKEkgc2VlIHNvbWUgcGF0Y2hlcyB0b2RheSwgYnV0IGJl
Zm9yZSB0aGVuIEkgZGlkbid0IGtub3cpLg0KDQpTbywgd2hlbiBzZW5kaW5nIHBhdGNoZXMgcGxl
YXNlIHRyeSB0byBleHBsYWluIHdoeSB3ZSB3YW50IHRoZW0uDQoNClRoZSBxdWVzdGlvbiB3YXMs
IHdoYXQgdXNlL3ZhbHVlIGlzIHRoZXJlIGluIGZha2luZyBzb21lIGNhY2hlIGxheW91dA0KdGhh
dCBkb2Vzbid0IGV4aXN0PyBUaGVyZSBtaWdodCBiZSBhIGdvb2QgcmVhc29uLCBidXQgdGhhdCBz
aG91bGQgYmUNCmp1c3RpZmllZCBhbmQgZXhwbGFpbmVkLg0KDQo+IA0KPiBJIGNhbiBjZXJ0YWlu
bHkgb21pdCB0aGUgY2FjaGUgaW5mb3JtYXRpb24gZm9yIHRoZSBnZW5lcmljIENQVS4gVGhlDQo+
IGNvbnNlcXVlbmNlDQo+IGlzIHRoYXQgRHJldydzIENCUVJJIHNlcmllcywgd2hpY2ggcmVxdWly
ZXMgY2FjaGUgaW5mb3JtYXRpb24sIHdvdWxkDQo+IG5lZWQgYQ0KPiBzdWl0YWJsZSBDUFUgbW9k
ZWwgYmVmb3JlIGl0IGNhbiBiZSB1c2VkIHdpdGggdmlydC4gRHJldywgcGxlYXNlDQo+IHNoYXJl
DQo+IHlvdXIgdGhvdWdodHMuDQoNCkRyZXcgd29ya3MgYXQgYSBjb21wYW55IG1ha2luZyBpdCdz
IG93biBDUFUsIEkgd291bGQgYXJndWUgaGUgY2FuIGp1c3QNCnVzZSB0aGF0IDopDQoNCkFsaXN0
YWlyDQoNCj4gDQo+ID4gSSBmZWVsIGxpa2UgeW91IHNob3VsZCBkZXNjcmliZSB3aHkgd2Ugd2Fu
dCB0aGlzIHNvbWV3aGVyZSBpbiB0aGUNCj4gPiBzZXJpZXMNCj4gPiANCj4gU3VyZS4gTGV0IG1l
IHVwZGF0ZSB0aGUgY292ZXIgbGV0dGVyIHdoeSBQUFRUIHN1cHBvcnQgaXMgcmVxdWlyZWQuDQo+
IA0KPiA+ID4gDQo+ID4gPiBUaGUgc2VyaWVzIGFsc28gdXBkYXRlcyB0aGUgYmlvcy10YWJsZXMt
dGVzdCBkYXRhIGFuZCByZW1vdmVzIHRoZQ0KPiA+ID4gdGVtcG9yYXJ5DQo+ID4gPiBQUFRUIGVu
dHJ5IGZyb20gdGhlIGFsbG93ZWQtZGlmZiBsaXN0LiBUaGUgZ2VuZXJhdGVkIHRhYmxlIGlzIDk2
DQo+ID4gPiBieXRlcyBhbmQNCj4gPiA+IGRlc2NyaWJlcyB0aGUgcGFja2FnZSwgY2x1c3Rlciwg
YW5kIHByb2Nlc3NvciBoaWVyYXJjaHkgZm9yIHRoZQ0KPiA+ID4gdmlydA0KPiA+ID4gbWFjaGlu
ZS4NCj4gPiA+IA0KPiA+ID4gVGhpcyB3b3JrIGZvbGxvd3MgdGhlIGRpc2N1c3Npb24gYW5kIGVh
cmxpZXIgd29yayBzaGFyZWQgaGVyZToNCj4gPiA+IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNo
aXZlL2h0bWwvcWVtdS1yaXNjdi8yMDI0LTAxL21zZzAwOTI4Lmh0bWwNCj4gPiA+IA0KPiA+ID4g
SSBoYXZlIHJldGFpbmVkIHRoZSBjb250cmlidXRpb24gZnJvbSBTaWEgSmVlIEhlbmcgYW5kIGFk
ZGVkIGhpcw0KPiA+ID4gU2lnbmVkLW9mZi1ieSB0YWcgdG8gdGhlIHJlbGV2YW50IHBhdGNoLg0K
PiA+ID4gDQo+ID4gPiBUbyBlbmFibGUgY2FjaGUgc3RydWN0dXJlcyBpbiB0aGUgUFBUVCwgb25l
IHNob3VsZCB1c2Ugc2ltaWxhciB0bw0KPiA+ID4gYmVsb3cNCj4gPiA+IGNvbW1hbmQgbGluZSBv
cHRpb24uDQo+ID4gPiANCj4gPiA+IC1NIHZpcnQsc21wLWNhY2hlLjAuY2FjaGU9bDFkLHNtcC1j
YWNoZS4wLnRvcG9sb2d5PWNvcmUsc21wLQ0KPiA+ID4gY2FjaGUuMS5jYWNoZT1sMWksc21wLWNh
Y2hlLjEudG9wb2xvZ3k9Y29yZSxzbXAtDQo+ID4gPiBjYWNoZS4yLmNhY2hlPWwyLHNtcC0NCj4g
PiA+IGNhY2hlLjIudG9wb2xvZ3k9Y2x1c3RlcixzbXAtY2FjaGUuMy5jYWNoZT1sMyxzbXAtDQo+
ID4gPiBjYWNoZS4zLnRvcG9sb2d5PXNvY2tldA0KPiA+IA0KPiA+IE9idmlvdXNseSA6UA0KPiA+
IA0KPiA+IExldCdzIGF0IGxlYXN0IGFkZCB0aGlzIHRvIHRoZSB2aXJ0IG1hY2hpbmUgZG9jcyBz
byBpdCdzIHVzZWZ1bCBmb3INCj4gPiBzb21lb25lLg0KPiA+IA0KPiBTdXJlLg0KPiANCj4gVGhh
bmtzLA0KPiBTdW5pbA0K

