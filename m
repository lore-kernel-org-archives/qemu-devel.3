Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D465EECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOX-000133-R6; Thu, 05 Feb 2026 22:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNt-0000RA-08; Thu, 05 Feb 2026 22:19:54 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNn-0008HM-VJ; Thu, 05 Feb 2026 22:19:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k66BpNma3/jy3w8Q1IWcLyF2i0Z014cScLxac/rdMvnShiHgUDyZ5c8oZ0GfsbO04OFpmSTeOdf213meiOX/o6QKzRUyLopzEgmAFYxllmAN/W4smB3S5Khl/9WalaXQHfQ/sFIgxZ71os6gj7nqcYhpH9N5pg71BUSu9b1tsUoxZtSbsUHZr1fhuSKJQJagkSUiPQV4zMO6ObITLnlrB6KqM6Yaj5OsLGZ7SB79tFEnKd0+QokACd4RI6jU4A4Q9DWFmTmllDblBgoTfd5rlc9dVUU+myZqcqshS73QaUeDcbS10XDk5VkT7WmSkx8cmhZk3UbYu5UDVi0wNz7E3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r58DxkdQ+dm+tkkf9kG13atVGBB92OKwRekROdlcPQ8=;
 b=djgGn7CmmweepaHu/gHJXdvMWhS1cqQADhNCG6GfYaDTCQdbMXWWeAlIj1aGxAhVHFIQG01huBV7Hf1B+5y/Cf0gCQpF7Q2H5BTzBvgAWHuP+EzwpMcEubCwKLnOBLQQSu2lF09Ofgn8G3c8JraQLNd1n/OZAbHV9PONSG8bp+IW1fJpRn9YLyX8De5HMThR+0RIAyD5hUTxATbKF17ofoq6v4t+Lks+chwWQW7KN2Z8LLgInuZNOPtAE6mXOwbrub/P4T743ADNctJFygv1Tpl6IiCXK33YsdjFIAU2uUowUHMwi/WH8uGcpoLPtRk0raloUifj88vICQzgFQ4MRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r58DxkdQ+dm+tkkf9kG13atVGBB92OKwRekROdlcPQ8=;
 b=DiHctALLiv66cU5mw7BmR2+f8fEwK/MNa7OURz81TVHcsh3xU9yCKZe8zVPuESqOQCRjitAuHIbUlHdkRSln6JlCzeayo6cQXHDrD8Jvqmqev+fvV4mT67RcnVjXMg7zNkjLsCfk10JzaG619i/CEwPOqT/RQpw53dOu+HFKaAxVrMxWeAzbe9VK5bwvIMFWA82aEs5iF+9JaRoEyOijMGchOFaCK3ILrDLlMeDE8Jcoox+j6//MkCQGv7uMzBKNBfyEChpsLWmWVIw+4945Vlqh2WJycYZpnUMgS/8t0qto5t8B/o9RoXMuiIUZ3UwieSNX5KqD6dcZ6H8ASUEpkg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:35 +0000
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
 Patrick Venture <venture@google.com>
Subject: [PATCH v3 05/20] hw/i3c/aspeed_i3c: Add more register fields
Thread-Topic: [PATCH v3 05/20] hw/i3c/aspeed_i3c: Add more register fields
Thread-Index: AQHclxdrgpZwCqKkPkS5Nx9odxnxtg==
Date: Fri, 6 Feb 2026 03:19:34 +0000
Message-ID: <20260206031926.3227848-6-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: d50105d3-7527-42de-de6c-08de652e8d84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EyZeME1gq9QUqHahMde3SOelCx5yFMmzq18n6mHzsUzdb/dC3miAbRvS9l?=
 =?iso-8859-1?Q?HN7d3wYWp9V1DG02dByoguTsJSzsQRcp1DfSuGWiOY4WVpoOeyMgt6eXzQ?=
 =?iso-8859-1?Q?xNs2xSKI2B9rqeEPPwgfoHnYqKzHDOiXu9ejP5Qz8FJMfBNwioeiQ1RHn2?=
 =?iso-8859-1?Q?1Z3HvVtaPpVNDh0jA424bgBZUUAUjcLllR0Yi9/j2Z6SniFSVJLlSNnpmb?=
 =?iso-8859-1?Q?CnkfKsn1TUj8Vf4dAfspTHdCR4oOmI6ARRQH3vFw/38FuzbyEk1KNvk0Vi?=
 =?iso-8859-1?Q?Evb+XHiY13kOfPnjej+racTJDDBu5Bv85ukuxKbBr9b9EA2Ik6cjRyCV3R?=
 =?iso-8859-1?Q?CW4ZQ4axNjXenQVQ7QeIh1TmgU+D1bZmleZCe2nCsIC5GBUd5a9nyAHJ2d?=
 =?iso-8859-1?Q?Wb9mc5cXprbbcl7iOC4AgtQy90qEKRjAvewkUURU/cye95AFMWHRIwLR2P?=
 =?iso-8859-1?Q?xoF7sxVojp1k3WCDvNURAoJV1xCGGngnlF0N/ynbAjnrLSjWt7ghS6jxpg?=
 =?iso-8859-1?Q?NQ3J3aVAe7TH75kr6jhd2x94gONjmQXW6jtASiKuh5MtmwCBA4Lq6M+Fg6?=
 =?iso-8859-1?Q?fY/QFxd9KWnK73M0920rXKpcRJgEurGG0Lc1vRoBU0Nhg1HzhwiLnmGEtp?=
 =?iso-8859-1?Q?g8wv+qQsCr+ZcmNUFhbNGyJf+Iaru0L3lNPTCb7ZYqB0/ueqt6jzMe9id1?=
 =?iso-8859-1?Q?iDzSlygrjVEBJ6xbHzwWhg0mphvbxJ5X3INnQ4LairrqwkH8zsLsk3jkMz?=
 =?iso-8859-1?Q?qrZZ/Rcc3a8dO45WFvS3gFKTlAk1j+kidsb3tx0DqHjYRmRD90ZNbyjiF4?=
 =?iso-8859-1?Q?QrDXqLhNkPnaBbVkthsJ4Pn83/IdqLuwhGRaOGQt3TnqxwsPX4KnBYrLg1?=
 =?iso-8859-1?Q?pZlPYGUFF3x5hs8fxJWbsudCzBS4UUfKtDDdcFmIVIiPNmo9bPIjLR64jS?=
 =?iso-8859-1?Q?O+PY/Lqx93QBR3zKCx5o/n6MVN7dtWn6qx57Dr+A6btZkRXWNCkF7jXnnf?=
 =?iso-8859-1?Q?58y8QRD8mXWIORKsCXngp962Gk+1baD33gsuBz3TzzByU9mp29NweDsKxl?=
 =?iso-8859-1?Q?6ACn9hEsL/HLSjKUejfcDovNC2X1lMKNK7fiASrOvi0BX1OQetT9rrmnq9?=
 =?iso-8859-1?Q?KtjlPoVMky1IAOtNVhowGeENW23T/hfPgDY11rf+F8P24LwkVBC+N8mIDn?=
 =?iso-8859-1?Q?s7pW5TcpIov3sizhRVkRGQSGFRkPXea2LarKDzR1aOaRgvDN9gkhc9pvC8?=
 =?iso-8859-1?Q?oswJLE+kYM8rVts4TiSBNPb39JmBXyPPR1OUZ0EZnHDa/EUHWfuj+PxOv2?=
 =?iso-8859-1?Q?qIQIYQ8hmwN3kMK/00P+b9dFexcalIzCnQORZkygtExJY6mvIe8p0eK8pV?=
 =?iso-8859-1?Q?l6/pZFUwbrSE+APXxSgNIhbi3D59E69tfyYP2JkoNQ0HZBLAZvsgz6KYUV?=
 =?iso-8859-1?Q?zoKSLOXBPtjqLgrEFSx6zy1pyQJ0NRKVxiX3OzMM999f81TQhAx+A/SxxC?=
 =?iso-8859-1?Q?3SChlaMiWHqVM/wyqLUSCAKfpo8bwUe+d95gTcGFPHD/KjGX3ExQ6FTuxm?=
 =?iso-8859-1?Q?hkVfxZLm+/Q33ZCdXidcxUT5ZKoWt/tMqGdWpVZUn2F3M2HSdXa1Sf+nWx?=
 =?iso-8859-1?Q?GSBedU8E8LIwTN6yO/T6JAKlFbwvr6eZ3jfi0zbxwWETJiMmkHrmQujCtZ?=
 =?iso-8859-1?Q?rygzWyx5CTH+d1TvO9GD8imfWaiTz1hxt/ChaGBi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N53JqKuqZFoXBaNFXH4ijN+r48jtWCPoLWOQIAOEPClRZKDxHJpKJv6geI?=
 =?iso-8859-1?Q?qa1ey0CZ0SGlPUenNTG43gPSeMIUpoBEcG+VvEeIcaF55D89o0tpiq4nCM?=
 =?iso-8859-1?Q?bgr5qZvv24uaZJMfwijWj3dU0NYuMrQ1kt7+t0403p54GRu7pPwSPd4okL?=
 =?iso-8859-1?Q?GDvkojUZ3errDTq9pi3KsIcRb6KiqcbzES70Ld8ElbQNqIlOwu3jbrp9eG?=
 =?iso-8859-1?Q?Iy0hm3IlKvpU0OYdBu5coA8+2aD2zTH9i+CWXaqNNR7nmioRYgesPILex1?=
 =?iso-8859-1?Q?P4/CQo3H3MXv91sadNgltCHLiEEyQZhx0sEHtZY0cCkOyPcwUUec/UVhAI?=
 =?iso-8859-1?Q?Ci1tttsrRLg+qAHdGyyVW94iMLy3259sMFQk1gdNenATv+OC+nTD2LayID?=
 =?iso-8859-1?Q?/NxEBv4WZVwyY1K0nVJL7WnXkNdCBWflEnA+A25E6/wvxUDa2o0RRDgY4/?=
 =?iso-8859-1?Q?aNDkOLe02enH6FzGzJVdVm/ll7Y338weOA2ybM2mbNMCFawV3fB/QLU45F?=
 =?iso-8859-1?Q?FKq4fa1BbaFweyJxq9LJUeIjSceV7az1R2S1SmcrZZQ1bfJxYcI4I0M+Sj?=
 =?iso-8859-1?Q?l9z2UHODOlY/hvBAIf5DmNsmZUnS9WaI9BvXHPgIIVYBloGpqzR6Pe0O/f?=
 =?iso-8859-1?Q?MG7VddYbHjBUic6Uw+vsm2oSiCiYYJHexivZr65fVh4VhvArqqz7h+AhUI?=
 =?iso-8859-1?Q?BzJkhM7l/+lEcqhCSGAZ9rUImE15r0qpo2t70Qh/nWAujxO/SN2xX17GPo?=
 =?iso-8859-1?Q?FvlmWrHl7XsFV5YlIAsqRq/YISY/YmlS3Y2d8k5JcWCpJ73vKlWRMEuqD7?=
 =?iso-8859-1?Q?7jnmnMHhYW1dn4C1uNc1RaIl4RGvIrbeTHTP77Bl0whzdUvOLVbb6b3mwX?=
 =?iso-8859-1?Q?OKMmdb12V651jPEbZD9/9Xk/SgoJamDtR6FVcCZZ4HaI2ck9rHQDaYd1w1?=
 =?iso-8859-1?Q?q05p2W2uZNEdpRK8RUq2q1m1QTW7cWktjfTo/9uyCpD/Btg1NdA8VLacH6?=
 =?iso-8859-1?Q?rYspnN7TK5fhAwcSsEMsHYrDU2/C6o6xdEZFzHiYJb2VCYO1wmkanjrn1a?=
 =?iso-8859-1?Q?GKDtQH38FoTu7/gkiZr4VypXSECE/wNdEWk4vHtamiqZcDMOAlqGgrPaur?=
 =?iso-8859-1?Q?EiWJTv2mXPNDKESeHd1OjYCpWrGrhVUJlGLEXM3PjcRBZU4qiCqrftnz7B?=
 =?iso-8859-1?Q?XRIyFSj4DUGzB7b7DEuKjwbGqnJuUXU6ZGsfxyB9wXuG8FZOIqT4IFk/OE?=
 =?iso-8859-1?Q?vzd9LH5RqGVv9IEpuGMqtVl7JwODMzLE9KLcxCJQGynhBSKrWoZz3/WYeB?=
 =?iso-8859-1?Q?i8g0jkyr0tTgK6GlEqvBSXloIyzZ38T5qP6mR/wA+IVoV30ydnp/x3NyAj?=
 =?iso-8859-1?Q?wGjf+0zeq2qqDnOk0I0RlHgs2fqpgON2KsSkTyAoV//oPAQ1CG9J275JFa?=
 =?iso-8859-1?Q?LcFu5W9+zfvgJMaUYLAJUN1cqGHr6lz8bRBKhxIhgb5Nk1e5PStDaUhc4F?=
 =?iso-8859-1?Q?vsM8GA7XVQhVHlcpUIfCFMPtmLUNHOPmc78wWdXLLB6Xj7U3Linmlj3M+M?=
 =?iso-8859-1?Q?sgfRPExeOO/FjzHT/58Qlt3nRg3r11HssK7jZGXozqila++21vmGH3gMRV?=
 =?iso-8859-1?Q?qogv7qjzXeKsyDUQwA80cP4lsBLLcl1uGD3QgpxDrhwHqhzpjNx8SGjRx3?=
 =?iso-8859-1?Q?fNZ/MFrKsC8qu8cZ9XSeiRhgW2T8ECVM1ek59j+Po7A0yV/PJMEwpT0heZ?=
 =?iso-8859-1?Q?6IJQpX0XQ9PDz3qG0lbzRtmKlY/CJLjTE7cATirWWPHt4kGu/b2MeaS0dH?=
 =?iso-8859-1?Q?XUi8yF2hiw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50105d3-7527-42de-de6c-08de652e8d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:34.9843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8ZN9jooMHbCaYgDYLO2xx8sUS5dOpCi+Hs/aDxtMstsrsF8UZWnyKfWLg1QywuOQ+ZTHCSLDn026P+7hfEpzS3ksb23TIRv9TB5XRZnMAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Adds the rest of the Aspeed I3C controller register fields.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 54 +++++++++++++++++++++++++++++++++++----------=0A=
 1 file changed, 42 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index b0844d4da2..f0352aaca0 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -21,28 +21,58 @@=0A=
 /* I3C Controller Registers */=0A=
 REG32(I3C1_REG0, 0x10)=0A=
 REG32(I3C1_REG1, 0x14)=0A=
-    FIELD(I3C1_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C1_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C1_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C1_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C1_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C1_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C1_REG1, SA,            8,  7)=0A=
+    FIELD(I3C1_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C1_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C2_REG0, 0x20)=0A=
 REG32(I3C2_REG1, 0x24)=0A=
-    FIELD(I3C2_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C2_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C2_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C2_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C2_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C2_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C2_REG1, SA,            8,  7)=0A=
+    FIELD(I3C2_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C2_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C3_REG0, 0x30)=0A=
 REG32(I3C3_REG1, 0x34)=0A=
-    FIELD(I3C3_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C3_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C3_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C3_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C3_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C3_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C3_REG1, SA,            8,  7)=0A=
+    FIELD(I3C3_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C3_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C4_REG0, 0x40)=0A=
 REG32(I3C4_REG1, 0x44)=0A=
-    FIELD(I3C4_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C4_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C4_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C4_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C4_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C4_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C4_REG1, SA,            8,  7)=0A=
+    FIELD(I3C4_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C4_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C5_REG0, 0x50)=0A=
 REG32(I3C5_REG1, 0x54)=0A=
-    FIELD(I3C5_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C5_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C5_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C5_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C5_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C5_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C5_REG1, SA,            8,  7)=0A=
+    FIELD(I3C5_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C5_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C6_REG0, 0x60)=0A=
 REG32(I3C6_REG1, 0x64)=0A=
-    FIELD(I3C6_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C6_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C6_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C6_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C6_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C6_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C6_REG1, SA,            8,  7)=0A=
+    FIELD(I3C6_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C6_REG1, INST_ID,       16, 4)=0A=
 =0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
-- =0A=
2.43.0=0A=

