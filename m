Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59489606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=bsMgGKN3;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=jou5HhFT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRI85-0002re-1C; Wed, 11 Nov 2026 18:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xRI83-0002qE-MZ; Wed, 11 Nov 2026 18:53:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xRI81-00080P-7D; Wed, 11 Nov 2026 18:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794441201; x=1825977201;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CiksTXJqecyafUTrSCpvJ32R070LQDfS3H1q0Sc7oxI=;
 b=bsMgGKN3K28MYFb5T8sf+eTYvB42FEshSKUAdZd3LyITjhnc+2eVNXC9
 UfsuRY/GhvTsTxIMFWyCwb81nwUY9lcTbfe7jwYNLqkIGRimNF4ZqEcAd
 01lUjCEOlA3VNub4KgaAqwo+gsFofsfkMf82vN2xUO5AO2SwkrNnNKgiE
 ekakv/oF/kRcClJNA43GTmWyZahc31lgWVTu89Nt+Ja2avFUmq0RcI3Wz
 oDsgXUyX9uYu1hfk8eTC6hhtYiHsJVf0+nZRunfU55Jqkn7eCI0EBNkyt
 UEXd+L0Ah+p/bb88lcPOBCiOit/MWkf+wldUbnzGG2iB0p6rSaXGxd3vg Q==;
X-CSE-ConnectionGUID: R3pw4kBaRy+bqXBNpVmK9A==
X-CSE-MsgGUID: 65rbKZ3aTgy64MVzIk1rJA==
X-IronPort-AV: E=Sophos;i="6.27,208,1786982400"; d="scan'208";a="160676885"
Received: from mail-westus3azon11011069.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.69])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 07:53:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1f3GqGB0qBc45lMTJtkiBT7YjcKrD7FGFqIbV081hBDgMBm9pvI01Rw1lR3RIIC9exgW7N8ae4kNmJo6rAj3lA7BUD4MzMbGztgwSWeNSGyvx5Vm9DfStYa/JpiSLrWf2RGy1NYfrB8B5knzdhgquRnwNfKSctBph4U2b0wjOsdjQgYKfC1Yl+Pa1Jv3RSp0gfusE0j6sXS+qQf8nbyeF0gn8LFzEWUoVP3IaW8B9H5mlm/Pnmd3XCAC6WWibZF4ZDSL2Ter3ZFfkVF+WT33+NX5zrLvkIcUBH1o2yTeyd+SwXwWeggVavdMG5kpS1cErsKPnFIQLMIZzGtdhieUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiksTXJqecyafUTrSCpvJ32R070LQDfS3H1q0Sc7oxI=;
 b=w7Re1Md6Gz2ctcJr93Dx3EhfsfqSEtokOWn9pUwuo4gWdip+1fKT3fb2JxyfXfUvY5KlGud6JmUIbo0/Z02AfSDurbg7dmViHRsGD1IZA7ZWmIUb2Spn/ImHO/qA67qNYDa/YXh28Bm3CFAevBoMsgm0DhCqmVIxAlHo1HtBzCtwp9EYcMJNjuWFp9Eh//0a7QlU8JZdUiHhuLiasvNQuLvY6OdxX573Npezepj6DkSnTGNmOU75wqSBs+IsbgXJWLYyvI8aBnc0FMIbiTvcZCpuGvvV2AGh8c0Gg/ip4NYphzZyu98R7Eh8O0NOCd5u8OHHHUkaXDTtb/4uhzfbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiksTXJqecyafUTrSCpvJ32R070LQDfS3H1q0Sc7oxI=;
 b=jou5HhFTFmEJjbEQChnFQH4orbBhyGghk/IXQSVsZmVXglULnY1oqqgJHjjqoGVQgnb69qsJqPId0G93jNPzwjXSc4uYHegAir1llBBEsM7ZMDjEpd8kCVdcDLWsW4w2ne4cHAdqnit/jr6P8NuwnXBInZs1MMA5oVhrcT4o31w=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by IA3PR04MB9279.namprd04.prod.outlook.com (2603:10b6:208:516::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 11 Nov
 2026 23:53:17 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 23:53:17 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "sunilvl@oss.qualcomm.com"
 <sunilvl@oss.qualcomm.com>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH for-11.2] hw/riscv/server_platform_ref: Fix mtimer
 frequency
Thread-Topic: [PATCH for-11.2] hw/riscv/server_platform_ref: Fix mtimer
 frequency
Thread-Index: AQHdccWz9iX+3qVpGEG98r2zJoPdf7cpjBeA
Date: Wed, 11 Nov 2026 23:53:16 +0000
Message-ID: <0b83fdbec84a3917a3b20a0e9d4c0c77f0840327.camel@wdc.com>
References: <20261111101609.1183263-1-sunilvl@oss.qualcomm.com>
In-Reply-To: <20261111101609.1183263-1-sunilvl@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|IA3PR04MB9279:EE_
x-ms-office365-filtering-correlation-id: 41823d19-ed60-40ff-0c5f-08df404ef4ef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|1800799024|366016|10070799003|18002099003|22082099003|10067099003|38070700021|261021121427099003|11063799006|261022105027099003|261021123027099003|261028144727099003|261026140227099003|261009223027099003|56012099006|261102123227099003;
x-microsoft-antispam-message-info: qn06X1TxXcH2ez9dYJ3aV9Z80WXebSR7R7B/Si4WovagCKgveL+RAbn5HRBOWQDCB8mBD16psRG86/cUraBuDOe1aVQhH++OV0MuXddOBJzasNaRGkgDy+JNwRl0kt0avRrUS1yypmsnRQ/K2IlNmn869YPIu2+i028yVJElKP1QmEgKQksn0sfWpf+vVDVf+iuHwRpaYilwRidMTfMEC8Foo7hmCHFamC1qDHFsR+fHiaT4fSTINU9r438SeKO/xkqFoaElXAkWPd73ElbOhjXgG4zwjodqTENla3OBEyTbpZZgXY9yAgUyVF/dWaSdrLzoiH4rJdNd4O3jdxHlkVLsvaD/IFFKhBAJUAUmBF9ybJz3OWHY8RqA/aWL/ecyS8Gx+6yfgETQVxdWf8vT1JhucHKSK7gtS7VY6M4AUEn5RZsYcvXPAy7SyDHsZjleoVcCn57/PgKzZOXhu8IbDwlRl38kYh3wMcs+OFSSCdvfiXd/oykPaK3+IrmH7iMxWIE8n+OA0ncdQons7IEvoWdazI8TOHq38ECE0IAadHhYShC30o2+SiJzVFiwMYFUcHORwFHbgVLgVFPgZGLPp+XJFs8YqquKGbL9nnEdCdO2MusBadSxlj2QGYm7oLeh8xRO6t3irxPgjP8Na+rrWEmQXg5MnDmP+9ZvESvY5QJrB46vlNXQyBanKRAUcFDRP/9rJmJOTDyNqz28zEixyh67VSppoHPjZYxhpp7d4xU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(10067099003)(38070700021)(261021121427099003)(11063799006)(261022105027099003)(261021123027099003)(261028144727099003)(261026140227099003)(261009223027099003)(56012099006)(261102123227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWQ5NDJxMmdndTFpK25XcnljdXVtMnVGNnIrT3NsT3kvVjd1NllZT2dIeVBl?=
 =?utf-8?B?SlNSUzJwcEYvOE1FS0ozdnRHVTBHRWp3VXV6Uk9PbzUvY051MGdMMTR3ek0w?=
 =?utf-8?B?MHlDNVBhblp3NnQ3QUM1UFRNSmo2WkxzdG81UkJTVDFIUlh5R2Y5SDErYktP?=
 =?utf-8?B?b1FIK1kySEdWbmJlWGRoM2w5blRpZ2pidUlzY3d3V2VPV0FWemNibEJGUDNa?=
 =?utf-8?B?SUJpb0JNajN5QUFwZHlwSzNaZUh0Q2FmUmhaaXlrcENGMWxkZFRrZnM3UG1k?=
 =?utf-8?B?MTVFNFhJZDczOGRCQTQ5NEQrSTg3UWNqZ0M2TEpBa3g4ZDNKTHMxTXBUY3JR?=
 =?utf-8?B?cHdoTEZzZDJxWFpSTjk2YkNFQU5ta1VjTnBEVWY1b1ovQ0lvUnJyZUpOMEN5?=
 =?utf-8?B?QWdYYUxzZWVJM2hkVzZQcHFyUGNvWkJKYk9KcVdWOGU4WTM3VVpKbVNWRmNW?=
 =?utf-8?B?ZjIralM4cU52bHZRcTdBcmU2VUF0R1Y1U2xtdDU3SnM4amt4emk3enZGcUFL?=
 =?utf-8?B?dlNMc2FPenBWV0puOGlwK2V4d05pRzduUlptS0RVREIwNUxSU1FHTXdkWlFQ?=
 =?utf-8?B?cDRPUlk4RUhKODVTbHFhLzE1VWVvd05XV1ZRQ2hndXRWbWpjVmp6SDk1VjI1?=
 =?utf-8?B?ZWYralN3cDdZZWxUZnRxSkRYa05KOVgxc0Y0U252anlvQVh6bGdxSXlyYk4w?=
 =?utf-8?B?SlV1cFJ4YmZSV3dTUUd2V1g5bHhQZUgzVmFOOXYzSG9SRElmTVVRdVlncFQ0?=
 =?utf-8?B?MGRCazNCdVM3dGhHV21TVWk4RHhFUllwemQ3b3ZCeXFpRS9CaDdlSk9PUE11?=
 =?utf-8?B?T2tyOUNqRzZ1NDJzNXdQTTM5Q2hEQXErQjNnZXF4d3gzUEMwcDVaOENLMGx3?=
 =?utf-8?B?SHFrZVVCMm9JcE5CSytkZ3FlRDFhK3lxWi85eHRiL3llVkpwK3M0OWZRdFlM?=
 =?utf-8?B?ZTdSYTB2eUlCVWJrYXBzdU5UcEplMXViQ01JK1NTWkxRTlFpZDRHUFhMUWZJ?=
 =?utf-8?B?OFFDQVJsY3lJQnhPemk4ZlhwcjY2b2NCd2VYeDBRL09Da1pqRG1ORTlpbHE4?=
 =?utf-8?B?WnJBZ0dHM0dvclFNNFc2eDVYZWpUZHk4NlBPalJJL2hIUjZFQVdLUUlYNStq?=
 =?utf-8?B?QVBROE5tS3JJdkovY0tqRmxHRHpFMCtsYUVwSDdFOHBobTROMTVKd0RCMmRU?=
 =?utf-8?B?ZHh4dkZHdGtHd2xaSXpoNVN6YlArK2RNZ0s4QXNGbFJ6N2I2b2lNWTU5N3Jk?=
 =?utf-8?B?QU9HS0RRd2NLK0NveXM5alhDanVwSEp3UEh2ZmsveFc1UFh2TlFmOEFXWmpl?=
 =?utf-8?B?SDI5dXFiT3R5WXpSNXpEbnEreEE0M1VlT1Jmd1A1UG5aVlRoT2RvMWppellV?=
 =?utf-8?B?aFRhRlluZ2ZRNGJlSEtVTDA4T3lqRmV0bzJrYmV5dS95bDRUU1FIMkhJL2hl?=
 =?utf-8?B?d295T1loV1ZKdVh2NWxmVnFYSlloZ2IySERiNXRpNGVHYll4RkE5UlpaVDRx?=
 =?utf-8?B?azdDbXlDdG8vSUp1N09kUmtEREY0MEdiS1dySWpPRlduZDJEZlIzN2tZWmly?=
 =?utf-8?B?ZEEwWTd0MHorc20wS2V3bWxiSlVHd1Z0UU5SVnA2RHJCSm1lZ0hGa3RxdE5h?=
 =?utf-8?B?bHZZQXl0Z0Z1d3pBY2M0aEcxQ1MzSElGZjBjRDg5cmVtNkZTaDNlUDZHUzBR?=
 =?utf-8?B?MS84SE1SbkdQbWZoVlhGVGludmdBSUo1RExtcWRGck5sSXc0L01aRmk3QkpI?=
 =?utf-8?B?citaa1MwOFVXdzVRYkFsV0pBU2Fqc05ieHhlMkhqQ2hFVDdqdTZUeFFTNUk2?=
 =?utf-8?B?V0xtV2VxL3F2M3c1a2NDVFRaMS84YlMybExJNE9DYi9MU01lYkVhaXNneHc2?=
 =?utf-8?B?KzZCM3hUaElTTEgreDBFRHVKbzhMSTE2dTA2enNrNEJLbnNCd0JoQXovUmlO?=
 =?utf-8?B?Tm02U0dqaS9SMDBVc0oyTmlrUFk2U2dSRk5Vd3FQWnlVTXRLMk03OXI5b0JM?=
 =?utf-8?B?clBwTmozdHFWYVNqTW41cFhQUUZ2TXJKamhRdmxlZy9JS3Mycmh2ZThVbUZG?=
 =?utf-8?B?K2pCYllqc0NjdUw2SkQwK015NVZrRGtiNkMxam5VNTdGQjhYMTlPWEZ1YjdS?=
 =?utf-8?B?T0RpbmdibHNYeUsxeVRuTTllc3RJTHpMWXM0a2E2cnFaRm1xSm5uOEtuUktv?=
 =?utf-8?B?dC9KcWE3azJOSDRpQStCL3pEUjQ5VHVtcEV4N0JaRTh4TUJPanlmNVJPb1JU?=
 =?utf-8?B?TDZhY2NhN01KTDRJU1pBZ1lFUDV6bzVNRFZJaDBpenMrKzBTbEFBZzdOWFc1?=
 =?utf-8?B?OERFRCt4MVNNQWZEdjZZU0dPLzNNTzU1aTdFaHI2eEhpblhhVGQreUtNc0gx?=
 =?utf-8?Q?UWawwYFpEcnnhOpCJ/Pcx3YHcgFMrMs9i5gzjIn3nyQB+?=
x-ms-exchange-antispam-messagedata-1: 7h3kenhExP7YkpXk0hy74uQIQpohRTm/WCE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71E73F16645BB946A0C0A87639A80BAD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TmQA323q7vDdAjgXtH1HxCufIqpi7JfMOtthhOdoXl+lhHy62roflnGkWs5PGrbaFXIVtNqnRy8BH2jTk0opf6ljSr+eE9DqVClhbsBaStO7Qzw62zVQ5rKX/Ip/aX8xzRCDggrGmXsYE9ilWXLeiMElX/EIQPJtxrx/f2DdQ35ZTqX9j3/kV+UQlNAQcF+D3T+IDP9fNHB9gwAIQEnCRq7V415klY0DHtWoKxYwm0/LQ1LxqnfV5WBnS7f+tXVIMb0N0wRtTXY0kMhm5wvRDnjkuJyvuRd13l/N88F2Q8GbxULSlwWhPvRk4uYmwbeM7GxXzaQrNJCv3D5B7LwqSg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F1ng6Q8grzyrsvm+GWUYSLq3jo+TTiBAvV2kL+ZzlRIm7QUFGXNrcquRDPH3EQThISZaSFhAe8g6gcrkpdzDmWHaSyiWzy+eT2+tFSGPrvebfnbPrLPWgEn8GYIwuWyIRXgNPjyxWa6oNnzIL01f7WCYgkxrpgEHUXePlDRr5rQpKuFRnBv7TuMcyBgrYqk43zgLdZHxl7OIEUIwtAsPbp7Q7/f94Ygb0unJqnFwxuOMerQJvozhdXzmh3QIJNwYxA1e41Qhs4katCQdCFM29ZkfH4DCZsbLRYU2yrfX9+lXnR//Fb9RDkD8+J5JtqXYgUC9TXYg/nmEbYFHflkgOpPrZDW6kUT6H9kY8hU+Gsn4FIqFegNnUF+0vbbhbynWCROoiW/A31Mh9TJ9GyksNRHHsDLsXrdVDh2myMH5qMmcyFrsoJvPALdyz5P0Gc9oULmiMXV3nSgKPFmFZ82OiFoLDE2idiI4pQz7ojMC9bIRxLsK+F3zZPbyHfWYe+U/Iam0VyuEbhg8UsI6NHNKFSzt+Fq38Py+qK3VRKH0VOpbeKOW0g1movmQ3jgTG9SgnO3DyJEKK0q4VqfGYgCFwOipDPiwvuMovqPRZhP7cwcRDXrtQsbmmzkFa2akLjyU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41823d19-ed60-40ff-0c5f-08df404ef4ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 23:53:17.0449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taPpqvK94Q68dO7Bt29acpK7Vlbd+3RqCBs9VywDEg0sIABistMIv0M9BYGzG3W1KaW1DsvhdZpZ3hEoGtOX4P1qRnuKHjomD9SSObsEtC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9279
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTExLTExIGF0IDE1OjQ2ICswNTMwLCBTdW5pbCBWIEwgd3JvdGU6DQo+IFRo
ZSBSSVNDLVYgc2VydmVyIHJlZmVyZW5jZSBwbGF0Zm9ybSByZXF1aXJlcyBhIDEgR0h6IHRpbWVy
DQo+IGZyZXF1ZW5jeS4NCj4gQWx0aG91Z2ggdGhlIHRpbWVyIGZyZXF1ZW5jeSBpcyBhZHZlcnRp
c2VkIGFzIDEgR0h6IGluIHRoZSBkZXZpY2UNCj4gdHJlZSwNCj4gdGhlIG10aW1lciBkZXZpY2Ug
aXMgc3RpbGwgY3JlYXRlZCB3aXRoIGEgMTAgTUh6IGZyZXF1ZW5jeS4gVGhpcw0KPiBtaXNtYXRj
aA0KPiBjYXVzZXMgdGhlIE9TIHRvIGJvb3QgdmVyeSBzbG93bHkuDQo+IA0KPiBVc2UgdGhlIGNv
cnJlY3QgMSBHSHogZnJlcXVlbmN5IHdoZW4gY3JlYXRpbmcgdGhlIG10aW1lciBkZXZpY2UuDQo+
IA0KPiBGaXhlczogYzJmYTQzMjA4MDNiICgiaHcvcmlzY3Y6IHNlcnZlciBwbGF0Zm9ybSByZWZl
cmVuY2UgbWFjaGluZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFN1bmlsIFYgTCA8c3VuaWx2bEBvc3Mu
cXVhbGNvbW0uY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIu
ZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jpc2N2L3NlcnZl
cl9wbGF0Zm9ybV9yZWYuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9zZXJ2ZXJfcGxh
dGZvcm1fcmVmLmMNCj4gYi9ody9yaXNjdi9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmMNCj4gaW5kZXgg
NWY0ODViMWM3OWNiLi5mZWM5NjdmNzA4YzIgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L3NlcnZl
cl9wbGF0Zm9ybV9yZWYuYw0KPiArKysgYi9ody9yaXNjdi9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmMN
Cj4gQEAgLTU1Niw3ICs1NTYsNyBAQCBzdGF0aWMgdm9pZA0KPiBydnNlcnZlcl9yZWZfbWFjaGlu
ZV9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYmFzZV9oYXJ0aWQsIGhhcnRfY291bnQsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFJJU0NWX0FDTElOVF9ERUZBVUxUX01USU1FQ01QLA0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSSVNDVl9BQ0xJTlRfREVGQVVMVF9NVElNRSwNCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSSVNDVl9BQ0xJTlRfREVGQVVMVF9USU1FQkFT
RV9GUkVRLCB0cnVlKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSVlNFUlZF
Ul9BQ0xJTlRfVElNRUJBU0VfRlJFUSwgdHJ1ZSk7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqAg
LyogUGVyLXNvY2tldCBpbnRlcnJ1cHQgY29udHJvbGxlciAqLw0KPiDCoMKgwqDCoMKgwqDCoMKg
IHMtPmlycWNoaXBbaV0gPSByaXNjdl9jcmVhdGVfYWlhKHN5c3RlbV9tZW1vcnksIHRydWUsIHMt
DQo+ID5haWFfZ3Vlc3RzLA0K

