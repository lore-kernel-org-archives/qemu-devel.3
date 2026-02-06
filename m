Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E39ECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOf-0001qZ-BW; Thu, 05 Feb 2026 22:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO5-0000Ut-6D; Thu, 05 Feb 2026 22:20:09 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO1-0008VR-TY; Thu, 05 Feb 2026 22:20:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWugcbRIWfG4XjWQPFsuUZCl4TEq/gSfA+2eUqS5WtdD30G8Ddn/frIiKutgBif3MBeYPo3vUIjCdBtUceRuahNVKDsI5WN1bA1I4pfyTe06SFfoZDFgbX0Jkwj7kWGVEMa3AmJn6Y2OPjgMGSro+boml2b1L/BgTfaQBWC7aMCGz3leGpTcTXzn5zX9DqlQokzpYYAUBucT1SLOe0l6ucsayN15AJGUOjIrVfV9G5O3L92zUWRsPEL5auJuFKUhTfvZjejbasqTaTcMhN0PhXdZu7cKp4AKTBtk2+SYGIh4FmJjnLKVbf5igDwWbEahMfC5XRwKJPplAfYVrbXKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LHe08sXo0xDLYJlKJBsDA7nPDg7IVxNtEj1DPMBLg0=;
 b=Q4ifmHkB5Cn6HfPiv1KAWzuHYfS1rvybiQ7Shw2HmhHCMQ8Z+d+PNk3kNiWFakZQBvVBhY3gUlJQMaHPKX0+86tZmU/4eyJrIba3WVdcGfdYGSl/NbSuJtqnXoiY8CNUVYtkK7Xxn0Izo5JpxCnWvXNCoOCv7myZ8teivLIoKHFGD57ZTpnLtJNJUmEQeaHgeh+Z2nN5I/H9HpGeDD1yZmaKTVXc+uoorSJkZbzmcvbFQeVMbQRbAlAK2W+r2FPv+SwpMYB0HLp7e1RILU2IhMdVCGVZG9of6v7ZSp3QIwZXK+bNCKw1UPzUlMwEgQzQb011QAEzwQsD//oOqFioyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LHe08sXo0xDLYJlKJBsDA7nPDg7IVxNtEj1DPMBLg0=;
 b=DxocWNvTlO7a83t1lXTVvmMZ+fx9wgF9nDaIyCyGTsYKtNK7+uVTeLSaqDHw4e90LUfKbSLp037wcJwBAd9sMxOxNU4bJD/xrJnH9e0folzX+SS0C5xYSy3VhOfoC8saGwk1jqIZDVg2FDE7c2ia7uC46RNK98S74Ft70BZ1A6zY60Db0OpKvdBB/pQyluyDfc8TxpuFBxsyvQ52eMobk/Fb/LXv5yFzZVaFjxOt/c2ctnlwAGWrsY2AT+N6FjVF6V78y7+ZtHTU+34vQc/tGgZbRInlYMCVVzBD7p2P52g83+sSfOqZZ7gyCk06DeyimiLpPHW491IDhQbNvfrtkg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF4DD1DCAD3.apcprd06.prod.outlook.com (2603:1096:408::78d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 6 Feb
 2026 03:19:52 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Stephen Longfield
 <slongfield@google.com>
Subject: [PATCH v3 15/20] hw/i3c/dw-i3c: Add controller resets
Thread-Topic: [PATCH v3 15/20] hw/i3c/dw-i3c: Add controller resets
Thread-Index: AQHclxdzas1/eK2dlkmN7pQITbBLSg==
Date: Fri, 6 Feb 2026 03:19:49 +0000
Message-ID: <20260206031926.3227848-16-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF4DD1DCAD3:EE_
x-ms-office365-filtering-correlation-id: fff3e3be-7d17-4ff5-4925-08de652e981f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HeirtXBWLNFJF0Ze8uuW3S6KzhpohU97Y8q6a05biL17bf6629KvRtpXs6?=
 =?iso-8859-1?Q?SunREe4792VCjTmZxw/CxL4IwdEmu1H4Bp1fTHIuAvpcV9pgj4Riaja5Id?=
 =?iso-8859-1?Q?98JqVNdceSY9XkjIdZ2VCRoR9i8lGhA50VKHzt2jtFHp4FVBY+1XM61OT5?=
 =?iso-8859-1?Q?ZK5wRvByWQUFbGJIurrRlu0+GuSCAkejdmtYf8bP+2qvdsRlSbrbdYk5pt?=
 =?iso-8859-1?Q?nWOC389GGNo8uB3e1YE91RWX2MnLAxBaQGTd59C7DWs/hLWKhnKgysUVKU?=
 =?iso-8859-1?Q?z9ZT2vudirkc/kefqp1rv4xnXbh85UJVPGK+fhXZy7TeryLVxvu0AHzYZK?=
 =?iso-8859-1?Q?Doj4gtwFVvDocymYagYLNOAnRBOZImMKoTAj/zgOu8C3lMKdjO3wotWMei?=
 =?iso-8859-1?Q?cdEN9FNygd3SutCSuHDovAC8RLgK5VXn54jKcwDwrYpxa2hTaKm0S31/H+?=
 =?iso-8859-1?Q?I537EMqhqgIlpKClnB4jnMKZqzCYHpA97UuIu4Z7M4g18nHVDmWuxXse4e?=
 =?iso-8859-1?Q?48tWHvPMtExqGkPhB6NjPLfNSfixWPxIrYFS4uKjJ3wcvq6sKYpVdOl/eJ?=
 =?iso-8859-1?Q?srGNBegNDjJ+rhRWlsibsV89RSIF54xdAjSvos5rR+xDMBoSO5nSuy2wO6?=
 =?iso-8859-1?Q?e61HMEa+h5X/LnP07xAkkoxzEcQLHOgDUtpS+6k9PFuXhj7t3PUHYdY/bX?=
 =?iso-8859-1?Q?QxO8qhjcHo7nmn3L+XbC3mg7hQwm5cH32q61VlNPdvnuYDRRcpqRllOhZb?=
 =?iso-8859-1?Q?+NbSeSQSFfyMIVpGYEzBMSkFx1uCGKEcoSA0gGi74xZo6iUOvVR30Zb9CN?=
 =?iso-8859-1?Q?I6LV3zqpN3E1AdqNwldyqiEJ2tdvUHBbxZxN8VcDj2yGpe1MVMEp+RRftQ?=
 =?iso-8859-1?Q?AQxon9jUGSwxM5S0giLQoqNfI0mG0Zl7WdXqB9DSTgSHBHinFRxErENacj?=
 =?iso-8859-1?Q?fv94FRX304BxldiNHyx/1szC1i6y9MP89CkzeoCO42tCCslFFCDQmLfVoJ?=
 =?iso-8859-1?Q?XDy9zD54ZW+OmkrBmRkgRKe0wxYkHcNuCvserQfvXMVDX+2/4dRguSKzHY?=
 =?iso-8859-1?Q?4c3ob2S1bJTCqbSVW2ekLyz1I3jMfo+HNvfPx+ir9TitDFvxP86zbVZRGv?=
 =?iso-8859-1?Q?/PZVXzsB5fqRFPwmZ0Af2S5plYF05fa8eZBDMYJKzOXdVQ2zCndBCnW3/l?=
 =?iso-8859-1?Q?Lua35uL2sfVqzPaydOCPm+G/z+Gju8wwskPWqloqw2Yqf0p38V1ofdBkCW?=
 =?iso-8859-1?Q?3lO43Z7MzZZ5uvO/5Y8PaupyDOcEbR+TaBj+fKjZrO6wxiR/DcNaigUz2/?=
 =?iso-8859-1?Q?gYiTFpAJztC5XiDdRno+n6BPZ/BGDQ1QHuKX5cSq4NU28GzzAhAcWPSaMu?=
 =?iso-8859-1?Q?qMad0/0ZRPicXVh/Vcb5xVB2B6xgx1nFlVsnfX01LqMEEPm3rRULZWDT+K?=
 =?iso-8859-1?Q?7POdM307YS0t/tfKZ1XGI/vekHqTubwwW7Y3GlZnT+tnVfNp9JSmAqbWrJ?=
 =?iso-8859-1?Q?lidn37lFAeNZGqVrI6vleFRWgbXG/PNLRIxjKUdVjWIKZcsUYwU0U8f0c3?=
 =?iso-8859-1?Q?giP4g07ObZ2Ncjw6zyJbr/e1PQynLHQ5FwUrFdj23OrD4OhAXj9j4X46L7?=
 =?iso-8859-1?Q?60a2Z52t3bqfRI2gNr7Y3os+ugpmkQsbbEN4C+SLsfGxMhugQD+Zou0ibW?=
 =?iso-8859-1?Q?CLKOr2LvKtja74ZIAPYhUK8yAH7aFdO7ttmTK1v1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?utixSc5kY8P4mL90OR5KttY3oJjks8E+j9HjNyEcm3t2IuF9cfzH/ZJpgi?=
 =?iso-8859-1?Q?rtMQZjyG87P+6bLcLhM/S6t4ecYZIZgQdkq+xFuXDpe6vfegZCcrk+HalX?=
 =?iso-8859-1?Q?LTQ+9HiOjtN+GUihBf8VxxV53RxMiQxQDgSqxiPb3wFReGp9fYNX42K0BH?=
 =?iso-8859-1?Q?vZCIEMsVfzOWOFCRjBRg3xs8C5YFl08uppiSaCbkAEIbt3X+QNh4SuLUHM?=
 =?iso-8859-1?Q?O6kqVzXxLuQyO2v1z1oKF0kKSlHtgfUj4njomRq5RqakonpZL4NRxN4CnK?=
 =?iso-8859-1?Q?kno6Zm+/siNWpuhHdqCuADU7qwzQUHGK0w/Qy8dhud+djHAnGqlH5AMYVa?=
 =?iso-8859-1?Q?3Qib6ZQSUldVLBxssckUqpBsZtGJ8/dlb4YrsEvmj2cdCwUIRrZ/qrw7lc?=
 =?iso-8859-1?Q?mcnmgZaV8j2UEPSsldX7IzCof5R6k14XCySBjAR5vgPeFMggTae6QW+YUT?=
 =?iso-8859-1?Q?puJGZvzl0RHbGVZWun6NbIaNJjwQJ2zYlZVtbVQZmmh/RA2UmCDSWakZZ1?=
 =?iso-8859-1?Q?Aupe7UZPt3XSeEobwKkyvqsEDCBa6MQVFEBvH1ucDdy0extkV4Z2exsv2F?=
 =?iso-8859-1?Q?qQiXkeUHfT0ugVE+JLURt779FcU0m6Sb/6WQcYMlYRJ2L5d0NK+iD1apL9?=
 =?iso-8859-1?Q?GYuxVqc76rzpmx4NtGSc+KKIN0eGSZHTAO6oMwqOo7zm4xB5WI6MgvVzXi?=
 =?iso-8859-1?Q?QbV0g4XInUcZ9C1rtCRMoqpplUSKI+D0OFH3iOWUiLyiOXug+AzL5trfTZ?=
 =?iso-8859-1?Q?CNaVqW9GKfhAQ7aVfKb4PKhhR629x8ZZY4Pk/e46z2sjC/6cdpAjNLhjz4?=
 =?iso-8859-1?Q?mZEQUMVzilzUBavb6MyomWSfS4WpAxigiesGIcTVJAK5tAulmaXpVo5c0O?=
 =?iso-8859-1?Q?0/DtKZPg4UMqtpjcWMVOV9992tNR+CLQ+p7Oyv6NqjaWUSqOA86xVE2CGf?=
 =?iso-8859-1?Q?oV1q/DxVDL1fYlWaGzxviScjL0Jnlz18ajY1fNYo8OcR9frQVQ8oa1LIWc?=
 =?iso-8859-1?Q?fjD1TlSbrgIB27JmlqXARHPlk5KFk2jUG2+P6VPKjOa2i6M9MC1aSYNiha?=
 =?iso-8859-1?Q?1t+tPIBbsIV9x+zucZMPuo/J5qMamYGrh6vzc9Wlbd++kIyVrni0WTuDRt?=
 =?iso-8859-1?Q?FjYpaARmAOI0LjJLA5H2SdDX1kk8P46wvUHw34EesLW7Nx0JH64m5k0Idb?=
 =?iso-8859-1?Q?infh91pCZpzawfOO2AopievgUdv+sKFivp6oIhXQwOE4offLiKDrp+199L?=
 =?iso-8859-1?Q?cVuOG9WQ2jqLiXT0rN8uuHu9KB+TEUEbh82IhmIDkTRmzu6bZd2YUOHC9e?=
 =?iso-8859-1?Q?8YrtYk+D+5Bg7duwGoIBLJodUMVArCTJx0dubfAp14VhXgOYlNpF8sBfSF?=
 =?iso-8859-1?Q?3w8UTQ4mAaTWmw1rbKTY7U9Xu9QIMB48guzuS+R6rTZ9LIC3pL3UJSmtOA?=
 =?iso-8859-1?Q?lICPzI4Zhm+quGWMbMsybTMRnDdiBA8JsfiVYpiTIZ4mnd6ULOXkjf0XX0?=
 =?iso-8859-1?Q?xzLQ/sQcV0fjFRhDIaaTnawbR2kpHAvtMnVuqKDSAP2Vav6DB+5U1trBSZ?=
 =?iso-8859-1?Q?OrbjOloOCKHg3nJ64bKXNyZoJKA8iL9aEDI2zHMYEusphqU9RJg8WQ4ugE?=
 =?iso-8859-1?Q?4LT/Uj/oC+iululLb+p1zNwuw9w6R+ny8BF70mIzHP2cnXwBx2RiAMqiwo?=
 =?iso-8859-1?Q?JGZowTMghe3/bTDzQL+zNHNwyPnzgmHfE06r/r9+FBwQI1xknYCdOjLJga?=
 =?iso-8859-1?Q?GZqRXxU256Yn8nj1KAjK7b9BAxnM9s3ykr+RNSHfvE94zF/++Ls2EUnmKx?=
 =?iso-8859-1?Q?TWcJ9MAmMA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff3e3be-7d17-4ff5-4925-08de652e981f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:49.3493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLV2aGtfDzjzDUZ6/buBMMwCoYmfVoNisqkOlZj9+UZHn/YxVCAF+D442L8tCFnwq0hkPXwJLv8s+1FtqLMEWvV8Y80/ZZnPCqkHl+bAX6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4DD1DCAD3
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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

Adds behavior to the device reset register.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c     | 117 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/trace-events |   1 +=0A=
 2 files changed, 118 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 7a1f79e10d..87ad344e5d 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -860,6 +860,122 @@ static void dw_i3c_intr_force_w(DWI3C *s, uint32_t va=
l)=0A=
     dw_i3c_update_irq(s);=0A=
 }=0A=
 =0A=
+static void dw_i3c_cmd_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->cmd_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,=0A=
+                     fifo32_num_free(&s->cmd_queue));=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                               CMD_BUF_EMPTY_THLD);=0A=
+    if (fifo32_num_free(&s->cmd_queue) >=3D empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    };=0A=
+}=0A=
+=0A=
+static void dw_i3c_resp_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->resp_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_ibi_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->ibi_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_tx_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->tx_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,=
=0A=
+                     fifo32_num_free(&s->tx_queue));=0A=
+    /* TX buf is empty, so this interrupt will always be set. */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 1);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_rx_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->rx_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_reset(DeviceState *dev)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(dev);=0A=
+    trace_dw_i3c_reset(s->cfg.id);=0A=
+=0A=
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+    /*=0A=
+     * The user config for these may differ from our resets array, set the=
m=0A=
+     * manually.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, ADDR,=0A=
+                     s->cfg.dev_addr_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, DEPTH,=0A=
+                     s->cfg.dev_addr_table_depth);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     P_DEV_CHAR_TABLE_START_ADDR,=0A=
+                     s->cfg.dev_char_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH=
,=0A=
+                     s->cfg.dev_char_table_depth);=0A=
+=0A=
+    dw_i3c_cmd_queue_reset(s);=0A=
+    dw_i3c_resp_queue_reset(s);=0A=
+    dw_i3c_ibi_queue_reset(s);=0A=
+    dw_i3c_tx_queue_reset(s);=0A=
+    dw_i3c_rx_queue_reset(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_reset_ctrl_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (FIELD_EX32(val, RESET_CTRL, CORE_RESET)) {=0A=
+        dw_i3c_reset(DEVICE(s));=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, CMD_QUEUE_RESET)) {=0A=
+        dw_i3c_cmd_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, RESP_QUEUE_RESET)) {=0A=
+        dw_i3c_resp_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, TX_BUF_RESET)) {=0A=
+        dw_i3c_tx_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, RX_BUF_RESET)) {=0A=
+        dw_i3c_rx_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, IBI_QUEUE_RESET)) {=0A=
+        dw_i3c_ibi_queue_reset(s);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
 {=0A=
     if (fifo32_is_empty(&s->rx_queue)) {=0A=
@@ -1617,6 +1733,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
         dw_i3c_cmd_queue_port_w(s, val32);=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
+        dw_i3c_reset_ctrl_w(s, val32);=0A=
         break;=0A=
     case R_INTR_STATUS:=0A=
         dw_i3c_intr_status_w(s, val32);=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index a262fcce39..39f33d9a50 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -11,6 +11,7 @@ dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C D=
ev[%u] send %" PRId32 "=0A=
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
 dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI=
 byte 0x%" PRIx8=0A=
 dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] =
handle IBI from address 0x%" PRIx8 " RnW=3D%d"=0A=
+dw_i3c_reset(uint32_t deviceid) "I3C Dev[%u] reset"=0A=
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
-- =0A=
2.43.0=0A=

