Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B73E7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5e4-0003Pi-Gg; Mon, 02 Feb 2026 20:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dn-0003M6-MF; Mon, 02 Feb 2026 20:55:43 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dl-0007rl-Kn; Mon, 02 Feb 2026 20:55:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yp27EyOV8CIGfssqEs7hpqlR4UDJqML39udhbpPkpSYU1CVFi6q7LpUCv1xjLP29FS+qXm1EU7V3UKYBIqcGieGaQLAiwFWvan9WtaPdTIRp7VH0VfwHOQ6IrrOk6SSQy2balVryER6RC0OyP86htfJhzbLCtkifpOwZKCbD1Pe3Y/v2sZkh6TGBoYKvvNEK3IWDD8HZuGWBIhlJW/06jraOcckr3st5F4PKT9Q6bDq7ZV2VL16SEcCFq+3b5k9p741y1ZY3b6xyOYWZ8UJIYNV/rn4ieYTEcxkOwR7NlXPjDdW/aJRAXaxqefp+MI2hmo3FBjlrNLkC9t5dGEQ2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTHMXhR8Gs+iPzla4NLrKBjm5DBADUz/BaEC3AZ2CXM=;
 b=TZNjor9VBoWSyGn9qWhdEnkDvheMsT3Rqr5J4lVQRPr8mZwBUc8AXRiE/FJLeyZKjfSJrpOxG2sIiagMXOYLJet4AFswUYIiQ3gDPubjyCIzCV+yNz0RDdQKkbLHtpLALnqNnV8YvtjIPY0C+LfyH2poB+2S/Ab13w0mMlh/OEkfDmBdiGzO5JGtK/QsfKmyBfjVrDBveUzZTB11yjQ6ZU0CUbwYapONYu9jw8YTcQYATlGXoutY0xD1kw07PpaSPauTGVCgP+KjpqsJIfRz+QJkYN/UxbplsLN9N7hJVthC3QhhW/Qu6kILHcbBXLMlmJgCljfvbNNdrfZlr7JQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTHMXhR8Gs+iPzla4NLrKBjm5DBADUz/BaEC3AZ2CXM=;
 b=dhzUnrZFxfj5k403sGIBA+c56PzRdgCWiZevofK+wppebHBvapN7q3IS2DRH8RrI7H/aUoNIA1vqS6Z1wpyemLKihp0mbcLdVF57jR886VBTayOqiUzEmdm5ZrfVpUOPLzAK2oNnCjcUqorI8iCDI8JZZ2LiWjT2a/7AXZCQLIUAivby14cGKrgxBKMoL9f21oWbmQVpmh21S66C/N33NNb9bC+kzviXlE7RxwyMSzHUxRxkZlikz9m3+1CALyNfyTbP7kDWvD2G3jwW8WgSUmzWITWdfr0JaPk4mtOZ+1LKDwN9wxgCUPTfGIychWeklYq5zXIRBPP6qe0wbOf7rA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8040.apcprd06.prod.outlook.com (2603:1096:101:2d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "clg@redhat.com" <clg@redhat.com>
Subject: [PATCH v2 2/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP memmap tables
 by address
Thread-Topic: [PATCH v2 2/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP memmap
 tables by address
Thread-Index: AQHclLAtkpSF//G/L06W1d1nQizHkg==
Date: Tue, 3 Feb 2026 01:55:31 +0000
Message-ID: <TYPPR06MB8206607A6B61EDD5AAB96C05FC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8040:EE_
x-ms-office365-filtering-correlation-id: f65ca56b-c2eb-44c2-3ceb-08de62c7503e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NU1MVWExVHhXOWtYMjhOajdnK1Z2YkJ0Vk5NQWo2dS9zS1B4ZjJrUllUTU5l?=
 =?utf-8?B?c2pUSEtMTVh0OVJ0VXhOcjRwVEZpcVRYeDJvdlZNdTl1UnRWTm9kMEQ4bG9Z?=
 =?utf-8?B?RUNLQm5mWitDUEhRcHF1TFR6ZlJOSjlaOG50MDZUZVRGVEhxbnE4VUhQUHNF?=
 =?utf-8?B?aFl5QW80QTZES21vQWtqVk1PSnZLem03WlVXQnNKam51ZmVJdWt4NXl2S01M?=
 =?utf-8?B?ODlNVlpPYUgvQ1BtTEFqSExvRFN4T3A0QW00SGlwL25pNEJCK0JCTXp2Ry9Q?=
 =?utf-8?B?WXZ2YjNlY0lxbTZyUVBjSDM5OWZGOE1YNytUMklwcFpNRXQ0SU9wYlo2c3ds?=
 =?utf-8?B?SkdzcGMxYzhLeW03Y2JBN1N2SlZ3clc1SU00c3gxcEo5VmpzVFd2bjF5NFpi?=
 =?utf-8?B?TldLdnJtSkpkbEhONW8vUEtFY0pwQ0RtUjQ3TWIrQklheXBLeERJcE1kRkNv?=
 =?utf-8?B?ODlWTWRXeUdzY3FuOUZBUkR6aVlubnYzckRUbUhnR0FyRi9vamo0dy8wcjFk?=
 =?utf-8?B?U3k4dmxncG5yblRHRENCSTUvL1lZaitzTDFnQ2dNc3RONTdwMkpXVUlHd2ZE?=
 =?utf-8?B?WncyVWtNNndQd0RwRnlLM1JBVEN4RWVtOUZNMjhzZlFiaU5mYXNpWVM3WGNi?=
 =?utf-8?B?Vit0SlFBVWM1WXJIdklFZlZNYTQvMHplaWtnVWwxRmZYU0hHdXU1NXc2T0pp?=
 =?utf-8?B?ZmU1NC9zeHNOTzJzY05PM3VwbXBjMko1WnU1QlQ3WDNQcTVlU1VxSHlORytp?=
 =?utf-8?B?RFVrZkxXSG1BdUVORUV2WThRa01UcnY1SjVBMUl0aGZpZm1aUzRHMUVCUWxt?=
 =?utf-8?B?Snh0MEJOWnU4bXF3SExXUk1QcTNLNjJydUEwenBMUmFScmNoSGRNRWlkYU5l?=
 =?utf-8?B?RG5WT09QM04ySCszWUNqSXFOWGlmdnF1WkdzZnhBZlIwUWtveWZ3M20zMVJX?=
 =?utf-8?B?Tkx2azVMWXVoY1o0UVNIQklSUlYwL0IxT2NNRkNVbXZQSGlGQzU1RTkycmg4?=
 =?utf-8?B?K2pVaDhDQmp6RjlONnJjTUo5em9SVlZPS2JWU0hPMDZib3k3Y20zTkh1RW1G?=
 =?utf-8?B?dnIybktyQ2FrUnc2UUVGOWtRSElJMzRNNElGQ2FMN1hyWlp0V0djRE9qUzF2?=
 =?utf-8?B?djBjZ1RkUlhVOHpSZ3VPNUw1Smk2UFBQY0FwZ2tzbC9FQkpmcFZBazFWN1Rn?=
 =?utf-8?B?bGxTY0lldFZWbEpNZDREK3dZWTIyK09FVEVsQmEwYXFIdTRwNFhLNHFvd3Fs?=
 =?utf-8?B?d2VpbW5HclRWdTRlU1ZlK3FadHBSMDAzN1FMaG5GRkFKMlVsTm40MjRrY05w?=
 =?utf-8?B?czlyMndsVG4xSWEvMGtSTHFVd0FkUm9ua3dndit0K0xubUordVZFVzQ5cDAv?=
 =?utf-8?B?aU9UTFlKQUdOVUs3NkRSOVNHRklzalRMTC95c0JNQUZnb3ZLdWlhYnBBTnZi?=
 =?utf-8?B?eXR2S1g0bUVUekk1MnA2dVl3Y093alZUd3NJcDRiTWg1R2RsRXFkbjgzZ2xV?=
 =?utf-8?B?VFhjZ2lleWc4SFhQdzdkckZKZVNyZGkrckUzakFzaW4xa0dMVFNQcjZPdUVZ?=
 =?utf-8?B?WkVYRFN3TjNJQ2dtRUczUDMwSjBhTTNxN1lqNGN2OS9JNENneWRhcTY2Qy9M?=
 =?utf-8?B?TlZvamhtdTJMOC9uREVOREt6N0xKRDNrOGNpcjZvc0RNM0FnWVZ4R3VQbkJm?=
 =?utf-8?B?ZTAxN1pKT3NWU2l2dmdib0tRL1Vqcy9wOXBSeTJyeDNhdmtQQ1NCZzhxdzVO?=
 =?utf-8?B?U2J3VUw4Nk16b1lzQU1ONTI5cUw0OE5tZ2paNGFlajA3N1FyZEZ3Vzk0TVZG?=
 =?utf-8?B?SUU1SEFMZTFxY0tpU0JaczVqaVdSVDI0T2pVajM1dXk5TUUxa3pqR0wybHE4?=
 =?utf-8?B?VTJtV053YllUU0MrUjNTNkM0ejhIOUZsZjRVWVpMTFg1dzByRnBEZktGVFNj?=
 =?utf-8?B?TWhEMSt4NWFQNlJ3REFRQ0tFbzhTSGdqQnFRZjVDZWdSQWIxaTNRbU1jRnRp?=
 =?utf-8?B?eDFNK0hmL0g3RS9sbzJ3QVhEODdXaVRSWFFGZ2RDcEtoS3hnWmdneXN3MjdH?=
 =?utf-8?B?amZhbHVmUElxcFB2NE01eHJFayt3dm90WGg5eTd5RDhDajFUYVoyZ0VqUXY2?=
 =?utf-8?B?cmxocmQwZS8xdFVoQkZsSnpoTzhzZElHTVE2R3BTWS85eHRZd0E4c0pUejFo?=
 =?utf-8?Q?MCbgqIE1rbnqn+iQiqH9XBs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmdGTnE4dzRxb2JHMWRGMngxK1E5K2Yva3Rkcy8yc2pqN2hzUDQzQ0t6N1lx?=
 =?utf-8?B?ZjlQc0tET1loUjlndm1GUU0yRzduQUViYlpLMVhkbWNaK2M0d1dNOFRpZFlj?=
 =?utf-8?B?MngwQXVWcDQ3eThuSWhIL1ZnNzVaR0oxakptakVFbnpQM082KzlrWWlOVFB3?=
 =?utf-8?B?U3ErdlY4Z1ZBNDRXb29WVjl2MVFxT1dWNFBBLzFlM2ZBcHFGbFY5dEgxVUda?=
 =?utf-8?B?ekRkZDJuM1Qrak1lWkQwS0RPdnJnTkpmdWk4WGdxd1RUODcvRFZtSlBWd2g2?=
 =?utf-8?B?NjN3VE9wMm1GMUdKNTR5cmhUSVY2NVdDc3phNE1GU3RjYWJLYkM4TndBSjd5?=
 =?utf-8?B?UFNvaElDNXkrQlVsWHhjeW1YaG80RUxhdHVtZmJzcXhUTWlOWnZOUGk3cGt2?=
 =?utf-8?B?eWpIYW5zN3loZ3lCMjE0ZWxCRFdPQjJVOS8rb3NqeUw0OEVCa0J2Ly9rM2dS?=
 =?utf-8?B?dkl3bDNTOTlYeGFieUFnNzRpeVJQNStuVDAyRVpKcElkMDhrVGFib1c3NUVG?=
 =?utf-8?B?Ujh5YThsQXFBMTZ3clF4TGZyVjdZVy9QeTdGZU1jUjdDQWpkMlZYYVNtTlZr?=
 =?utf-8?B?VWtITFRFRk5mdkJFRlFQV0tWaEg0dzVISFRkU3ZPZDl6bytVL3lsRDIxR3Fy?=
 =?utf-8?B?NkVVYUpIQmlNZ1llKy9oMUdybStuNjVBcytWQ2xOYUJJNlc3RXMvcTgxY3BW?=
 =?utf-8?B?Umx1SE1vc1QwKzFGMWRheGx6MkVWRWdQempNcFAzbmRBbUFaMEZFYklsM0Nv?=
 =?utf-8?B?MkFlVFo3b01JSDVtSjJaUkhwYlJ3MFpFeUJOd29GcGY3ekFKU04wTlNFaHEx?=
 =?utf-8?B?WkYwSlBZZCt0alIySVRNTWNINGRCYllnYXV6Ny9BSWhzYW8xRnFiRnRkNmdT?=
 =?utf-8?B?cVEwNlBNWWVjRlF4bTR0VE9IK3pYWjJsV3FtVSs5ajNwV3R2VXpoYjRNYWNJ?=
 =?utf-8?B?M2x6QjQ0Zmpub0t0dlluSFFlTTlKbXlxcWFmeHAxNUUvRDRxbFRwNythZmhv?=
 =?utf-8?B?c1FGRUNPOXJxY2kvNmtCckwvaTY1SllCYlc2dU1hWC9kY3ZzVUJOeG54bXNS?=
 =?utf-8?B?MDdEQ2dhMXBrbHA4NkFEWWFJcUV5bkZOSERzdEtoSEVqTjh4QzFHcFZTK1ZF?=
 =?utf-8?B?cFNyM3J4aWJIS2tzdnYvR0dRc1h5ZHUrYjVXUmRRTXo1WHJBM1FqclNNaUU5?=
 =?utf-8?B?R2k1Z0xnZjlYUFhacHo5TlpCaDVKV0c5QjBMRzl5RlhQM0dOTFN6eFVVYk4x?=
 =?utf-8?B?ZGQ1TnVSdkhoR3RmaGVrRTltL002RFdxc0hmUERmbzFUbFhnaHg5NE5MNTJ0?=
 =?utf-8?B?OTVXVTIwUHJDYlhmOXh2SHRDWUM1SGNUd1BrMTZuSG9GbkM0UTFFdXh6dmlh?=
 =?utf-8?B?VjlpcG82Mzc0Q2ovaG9WZWYvZWRybGQ1eDF6cngrU054cnZXUE1NUDYydG9U?=
 =?utf-8?B?dExoQllLQUhsc09HOXNqeXFkekcrNkdYaDlDTzVOU3NWUEt0YTFYN0IzV1d4?=
 =?utf-8?B?bnF2Zi9YY2pWRjJFK0MrNUFFek5zN2tOVmp4MTlzajI5UkcrUUZVS2VieVly?=
 =?utf-8?B?VEJKL2U0bW5oeTYvTUR1MkRMV0cxOFR2TTZGdlkyZFljb21HREJjZjdHd0hM?=
 =?utf-8?B?ODArcDduaUQxbjJEN2N4NjFFUkd0L2tDaStMVWl2UUJKS05hQmcxUThRRG5V?=
 =?utf-8?B?N0V1Ykh5emRwNmFGQkJxemhGNFRzdGJMTDFQQkh1cHRjUnZmY0lKK3Uxd2hG?=
 =?utf-8?B?b1Y3dktjUXhVTE9aSFhJTGpTdmxyTHBleEdaeGFmNlA5Yys1Q2R4Sm1Odzhz?=
 =?utf-8?B?M1JPL0tINkh4M2dsMXoycG5VSzhDQlNjWlJXWk5vSktPR0NyRlo3eVc0b1Yy?=
 =?utf-8?B?UUhQSnRaT2pUU0t2QUNOT21PMmNYTFlidTRMbVY5TWtRSFhjWTZXaFNiMWFk?=
 =?utf-8?B?aFNYYTUxc2N3N0Z0OWwrc1Q5Z0MxRzFCbVdBSnRCSFdJUitCZjlXRUZSMEV5?=
 =?utf-8?B?UDk3UENPb25EMmlTeFl6Z2Q4VXVxYlQ1V3VtQXR1M2ROL2VwUGNwc0YzYXp0?=
 =?utf-8?B?azFkZlc5UnhicmRjSG5DSHlCTTVMSEhjN3FaUXMzL0hDR1daK0JKdkJobVhs?=
 =?utf-8?B?eXJwNVMvdG9JMi9rTjlLM2VMRkNhcXlFS000bnVlZGQyOC9tTGV2aUgyeTZ1?=
 =?utf-8?B?V0RFRkJXZUZ3dTE0VE5SaGVwUDExYTN1dkRoWjNZVnVqc1lqd3JXclRObEcr?=
 =?utf-8?B?ZTRTNU9ieVpLLy9MdXBUczJBYnpreXlGa1p2SGd6NE1uZ0ZpSlUzM294S0FW?=
 =?utf-8?B?ekd2ZXFlRmlJejdXcDI4WHJEdFNadWlGODEzU0FRRkFYRjlWQnhRdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65ca56b-c2eb-44c2-3ceb-08de62c7503e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 01:55:31.7126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwEZiqx7RxlsU4Udv3MI2Qb8E0O2pAVURmdy2EAjxi+b9/x+juY0abOD1FFiXH8YUEBymwem8xkhHeTnAqNgo4kykzA//rPjjrxiIWGeO3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8040
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

U29ydCB0aGUgU1NQIGFuZCBUU1AgbWVtbWFwIHRhYmxlcyB0byBpbXByb3ZlIHJlYWRhYmlsaXR5
IGFuZAptYWtlIHRoZSBkZWZpbml0aW9ucyBlYXNpZXIgdG8gbWFpbnRhaW4uCgpObyBmdW5jdGlv
bmFsIGNoYW5nZS4KClNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRl
Y2guY29tPgpSZXZpZXdlZC1ieTogQ++/vWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4K
LS0tCiBody9hcm0vYXNwZWVkX2FzdDI3eDAtc3NwLmMgfCAxMCArKysrKy0tLS0tCiBody9hcm0v
YXNwZWVkX2FzdDI3eDAtdHNwLmMgfCAxMCArKysrKy0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2FybS9hc3Bl
ZWRfYXN0Mjd4MC1zc3AuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYwppbmRleCBjZWU5
MzdiMzdlLi5lNGJjZjBmYTJhIDEwMDY0NAotLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtc3Nw
LmMKKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXNzcC5jCkBAIC0yMywxNSArMjMsMTUgQEAg
c3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2FzdDI3eDBzc3BfbWVtbWFwW10gPSB7CiAg
ICAgW0FTUEVFRF9ERVZfU1JBTV0gICAgICA9ICAweDcwMDAwMDAwLAogICAgIFtBU1BFRURfREVW
X0lOVENdICAgICAgPSAgMHg3MjEwMDAwMCwKICAgICBbQVNQRUVEX0RFVl9TQ1VdICAgICAgID0g
IDB4NzJDMDIwMDAsCisgICAgW0FTUEVFRF9ERVZfVElNRVIxXSAgICA9ICAweDcyQzEwMDAwLAor
ICAgIFtBU1BFRURfREVWX1VBUlQ0XSAgICAgPSAgMHg3MkMxQTAwMCwKKyAgICBbQVNQRUVEX0RF
Vl9JUEMwXSAgICAgID0gIDB4NzJDMUMwMDAsCiAgICAgW0FTUEVFRF9ERVZfU0NVSU9dICAgICA9
ICAweDc0QzAyMDAwLAorICAgIFtBU1BFRURfREVWX0lOVENJT10gICAgPSAgMHg3NEMxODAwMCwK
ICAgICBbQVNQRUVEX0RFVl9VQVJUMF0gICAgID0gIDB4NzRDMzMwMDAsCiAgICAgW0FTUEVFRF9E
RVZfVUFSVDFdICAgICA9ICAweDc0QzMzMTAwLAogICAgIFtBU1BFRURfREVWX1VBUlQyXSAgICAg
PSAgMHg3NEMzMzIwMCwKICAgICBbQVNQRUVEX0RFVl9VQVJUM10gICAgID0gIDB4NzRDMzMzMDAs
Ci0gICAgW0FTUEVFRF9ERVZfVUFSVDRdICAgICA9ICAweDcyQzFBMDAwLAotICAgIFtBU1BFRURf
REVWX0lOVENJT10gICAgPSAgMHg3NEMxODAwMCwKLSAgICBbQVNQRUVEX0RFVl9JUEMwXSAgICAg
ID0gIDB4NzJDMUMwMDAsCi0gICAgW0FTUEVFRF9ERVZfSVBDMV0gICAgICA9ICAweDc0QzM5MDAw
LAogICAgIFtBU1BFRURfREVWX1VBUlQ1XSAgICAgPSAgMHg3NEMzMzQwMCwKICAgICBbQVNQRUVE
X0RFVl9VQVJUNl0gICAgID0gIDB4NzRDMzM1MDAsCiAgICAgW0FTUEVFRF9ERVZfVUFSVDddICAg
ICA9ICAweDc0QzMzNjAwLApAQCAtNDAsNyArNDAsNyBAQCBzdGF0aWMgY29uc3QgaHdhZGRyIGFz
cGVlZF9zb2NfYXN0Mjd4MHNzcF9tZW1tYXBbXSA9IHsKICAgICBbQVNQRUVEX0RFVl9VQVJUMTBd
ICAgID0gIDB4NzRDMzM5MDAsCiAgICAgW0FTUEVFRF9ERVZfVUFSVDExXSAgICA9ICAweDc0QzMz
QTAwLAogICAgIFtBU1BFRURfREVWX1VBUlQxMl0gICAgPSAgMHg3NEMzM0IwMCwKLSAgICBbQVNQ
RUVEX0RFVl9USU1FUjFdICAgID0gIDB4NzJDMTAwMDAsCisgICAgW0FTUEVFRF9ERVZfSVBDMV0g
ICAgICA9ICAweDc0QzM5MDAwLAogfTsKIAogc3RhdGljIGNvbnN0IGludCBhc3BlZWRfc29jX2Fz
dDI3eDBzc3BfaXJxbWFwW10gPSB7CmRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAt
dHNwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAtdHNwLmMKaW5kZXggOWMxMWMwMTZjYS4uNjg2
ODNhMTVkOCAxMDA2NDQKLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXRzcC5jCisrKyBiL2h3
L2FybS9hc3BlZWRfYXN0Mjd4MC10c3AuYwpAQCAtMjMsMTUgKzIzLDE1IEBAIHN0YXRpYyBjb25z
dCBod2FkZHIgYXNwZWVkX3NvY19hc3QyN3gwdHNwX21lbW1hcFtdID0gewogICAgIFtBU1BFRURf
REVWX1NSQU1dICAgICAgPSAgMHg3MDAwMDAwMCwKICAgICBbQVNQRUVEX0RFVl9JTlRDXSAgICAg
ID0gIDB4NzIxMDAwMDAsCiAgICAgW0FTUEVFRF9ERVZfU0NVXSAgICAgICA9ICAweDcyQzAyMDAw
LAorICAgIFtBU1BFRURfREVWX1RJTUVSMV0gICAgPSAgMHg3MkMxMDAwMCwKKyAgICBbQVNQRUVE
X0RFVl9VQVJUNF0gICAgID0gIDB4NzJDMUEwMDAsCisgICAgW0FTUEVFRF9ERVZfSVBDMF0gICAg
ICA9ICAweDcyQzFDMDAwLAogICAgIFtBU1BFRURfREVWX1NDVUlPXSAgICAgPSAgMHg3NEMwMjAw
MCwKKyAgICBbQVNQRUVEX0RFVl9JTlRDSU9dICAgID0gIDB4NzRDMTgwMDAsCiAgICAgW0FTUEVF
RF9ERVZfVUFSVDBdICAgICA9ICAweDc0QzMzMDAwLAogICAgIFtBU1BFRURfREVWX1VBUlQxXSAg
ICAgPSAgMHg3NEMzMzEwMCwKICAgICBbQVNQRUVEX0RFVl9VQVJUMl0gICAgID0gIDB4NzRDMzMy
MDAsCiAgICAgW0FTUEVFRF9ERVZfVUFSVDNdICAgICA9ICAweDc0QzMzMzAwLAotICAgIFtBU1BF
RURfREVWX1VBUlQ0XSAgICAgPSAgMHg3MkMxQTAwMCwKLSAgICBbQVNQRUVEX0RFVl9JTlRDSU9d
ICAgID0gIDB4NzRDMTgwMDAsCi0gICAgW0FTUEVFRF9ERVZfSVBDMF0gICAgICA9ICAweDcyQzFD
MDAwLAotICAgIFtBU1BFRURfREVWX0lQQzFdICAgICAgPSAgMHg3NEMzOTAwMCwKICAgICBbQVNQ
RUVEX0RFVl9VQVJUNV0gICAgID0gIDB4NzRDMzM0MDAsCiAgICAgW0FTUEVFRF9ERVZfVUFSVDZd
ICAgICA9ICAweDc0QzMzNTAwLAogICAgIFtBU1BFRURfREVWX1VBUlQ3XSAgICAgPSAgMHg3NEMz
MzYwMCwKQEAgLTQwLDcgKzQwLDcgQEAgc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2Fz
dDI3eDB0c3BfbWVtbWFwW10gPSB7CiAgICAgW0FTUEVFRF9ERVZfVUFSVDEwXSAgICA9ICAweDc0
QzMzOTAwLAogICAgIFtBU1BFRURfREVWX1VBUlQxMV0gICAgPSAgMHg3NEMzM0EwMCwKICAgICBb
QVNQRUVEX0RFVl9VQVJUMTJdICAgID0gIDB4NzRDMzNCMDAsCi0gICAgW0FTUEVFRF9ERVZfVElN
RVIxXSAgICA9ICAweDcyQzEwMDAwLAorICAgIFtBU1BFRURfREVWX0lQQzFdICAgICAgPSAgMHg3
NEMzOTAwMCwKIH07CiAKIHN0YXRpYyBjb25zdCBpbnQgYXNwZWVkX3NvY19hc3QyN3gwdHNwX2ly
cW1hcFtdID0gewotLSAKMi40My4wCg==

