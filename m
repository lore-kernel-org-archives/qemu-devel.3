Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB45EB28C8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETl-0003aG-Vu; Fri, 06 Feb 2026 00:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETi-0003Xv-PZ; Fri, 06 Feb 2026 00:34:02 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETh-0007WD-A1; Fri, 06 Feb 2026 00:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkZ4GgZLp+G/sfOzDZSXJ+mGnNHqHmQswsVPzqhD6uB8oH8MFrT6WFEBUaDebz6qK/riZUu4dqg21eIadZOvz8nwT2EHllyY3CmWI5N7HwOPRwu1RTj5O7XBC2+HhdTefllkjoq/Ph1RNrTMfQdGaIRMP1f6yjr/fVX40i/MoWy8gOr6dcgsceRCxzMi0r80KiKQOW7J0fYHyxwDbcbCo1+r9uAReINAVpuCwe9uHbTcRoYm7ABbMyWwZOC5sHLRIJNHr47jDhGYT+YV7ujP+m7gn8/I5PdPOnA7D4jKlCOsg3O4UrUQ+cJkKY7Xni3ZPPUQwIJ+4NkHsirIRO0AKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkuBeFe+Dw6ZVEKoOQxz8szaGxXBXceTN2ATUrY9+eA=;
 b=s4rbUqFSZF6WxCWsgDRkNFNSB5LSCBjwGoad3R+rOrntSwszMnBrJw9ksJ5/ZAJyokqG5e/nwwAlNQ/t/KkQy9Wfw8Gj+wou47o10mny5MIN4VlrU+3c3KysZFNmQkhCHpSaI6C4OENysNTdP4L3ARo3Vp+jymAmbYJOynKwlUqUN/H8alOh9OouMVk96HiakbMiy24NKJ6X5i+zS8NtuQn6yukubzSUyon6wCLarJ5K3OC/yBRvboxoCAjgvTaZqb3a8INzq3iQWVVR1SYlNNAgxrBTFDZdp1hxyw5nlCQA01QYYva8IOktg7hcVaT7Xruefxjs7z/kfvZB/f+hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkuBeFe+Dw6ZVEKoOQxz8szaGxXBXceTN2ATUrY9+eA=;
 b=r2clm1OmUIievWcruob1Yhw9NSiw+5AfH4asoPepM4YsM9/bXRnsuEFHIP3aY450giXUeLHzD1RRc03/Iy32EcdILOswVRIoNYaAaBe2/sQQacOQcZO99zdk/VvzLffGTCsDR8CuRXbOQyYbYqoMagmpBx8GhPw47fjgs3kqIw2wrRUS9VSzwwRguYydAUo54cuSenCkuPp5vs5Vk4rz48tbdFElRU8s0/qgZJ31lrnIeXUTTAOG2OPqm+wsYZJeuCjtMYeAx25H7r2BXjac9nSpnEf18pIPueO3uoxuIbU84GdpqN2Tgf6kq99vNISMZmJ4BPtqtzcqbkLSKBfGxw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:51 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v1 07/10] tests/qtest/ast2700-hace-test: Use ast2700-evb alias
 for AST2700 HACE tests
Thread-Topic: [PATCH v1 07/10] tests/qtest/ast2700-hace-test: Use ast2700-evb
 alias for AST2700 HACE tests
Thread-Index: AQHclyoso76HRIqTtUS97Na8gd1DpA==
Date: Fri, 6 Feb 2026 05:33:51 +0000
Message-ID: <20260206053340.3716041-9-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI6PR06MB7165:EE_
x-ms-office365-filtering-correlation-id: 82d3fee2-ac1d-4142-58e8-08de65414f7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nGkLC39fKUkSi8dOu68hFGQaDHqFm2CbuEo8SCfUsIN5ExBN6Z7utlWFBX?=
 =?iso-8859-1?Q?bqdvL6PGWZfqWcmthOPeSVYeI5GuF87Y1XHqiP7omQ+m931jfZWZosROAu?=
 =?iso-8859-1?Q?Cvo3qSA2Q1HmYGlgIUApAKnu6AktwRHd13BGhtzp8W787+Wt6cLzyTQAo5?=
 =?iso-8859-1?Q?XQT7hePImbKESjJRaw8WaScFNxLFe4SmRax4SxMn2rKpabt3zh5F35T0B0?=
 =?iso-8859-1?Q?+vXLJLiBxt7tCEXh3s9lTM40ZUcNJ6rRHQCk1IzlTdfHIlS0KVRYZx+Jpl?=
 =?iso-8859-1?Q?5COYQvO6LdSLK6pOC8rLorcZ9abh8c6SADx9AnccK2QKkT7uNj6tDz0QMu?=
 =?iso-8859-1?Q?0rFFaCv40WxH8z0rIrVz6caBiQ3miPCMmqgt/AlQQJf3eHpVqE1QR3LXA3?=
 =?iso-8859-1?Q?ynD5vLB92b4elDLmXud14j8tMj1VRN6+n6GvxHD9PlUjaqhdnPzNLV1mDL?=
 =?iso-8859-1?Q?tjrZGZMdzA2RdSNTi4mySSPOU6/o/aLd2+kGT71GExsrgZisO5p3Efl/0M?=
 =?iso-8859-1?Q?RPzuw+G2UOvBE01VUm4WAJiiSmq55CdhnLHPl6JPFw6XhYencN9ctaVNuK?=
 =?iso-8859-1?Q?vuEl9lnQMvJGBcTDavEZeURBQa7XoZOJvgbG0TeJh2FqRrjI1POBSjSo7d?=
 =?iso-8859-1?Q?vB/hmT9ETr5xhsdps0f4LvrdI5UfTU74+JhNBXXRioWSOos81fvjzDaLM/?=
 =?iso-8859-1?Q?HAE/pivFpkyDHl9xbIaszny0pLLzj+aMWJk588hJzv+REwlJka39IdE/go?=
 =?iso-8859-1?Q?YxJEs8wzbRHx5qC+/0mu9nlCFC4HJXUhYEXlNmh9hyHCiWgpai29xJMv6w?=
 =?iso-8859-1?Q?uAQJa0uHDh4ICoa381rQoesxPGapqswKVN7KzlE8noOKpwwtqhHpeTmoV0?=
 =?iso-8859-1?Q?xwMeSX8XgXc6/a3huKi9c6nsBivXaUhyF5V6F8WBIeQQ0J+859kHHehl/2?=
 =?iso-8859-1?Q?veH5JOP/TepZxwjwVWkex5JCZrA0oxrQwca6sDKrRiVfThaj6KZ7hdf5fv?=
 =?iso-8859-1?Q?gyf4KngE8X+SUMtTfHkcrb++fhHdgx65u0CN+gwobD8YLaRHcgsAffms8L?=
 =?iso-8859-1?Q?qOhVWyN3ng/ZLRVf9jqC5lq5nb93rQ28HpxliRfbrc1ztgHqDZWdS6Tgph?=
 =?iso-8859-1?Q?fq9rheK5+Lp4VmnPWcEYpM/F1VfQRdpyxbV+YXvDosAHSkJ0WdnUBaLIZ9?=
 =?iso-8859-1?Q?BEkZs+dXKNW4LuoOVF3yOaxv9HEFSMb/toxyjxUx4vrjCB8kWSZoje+t0w?=
 =?iso-8859-1?Q?tiy3NMmKCXN8yo3he+lkzp9KhXXAqh6xFGGay+hlnffpgmsIVNgQ0HN0D2?=
 =?iso-8859-1?Q?asxf769wXtWt7VALt1LyrFInJ7wHrt8UTsNdFoQ8Zdg6Amt9CS1Xd6ZYYj?=
 =?iso-8859-1?Q?GoM20SCIy2KcOWylcff5zLxLZ1wKMuxoJF0M4iax77IG89EagN2pZANL/p?=
 =?iso-8859-1?Q?d0rZc5e1537y82LXDVml5bmTjLzWdA3A1nawRZEKQsjCSs6yU9ffMCVPKW?=
 =?iso-8859-1?Q?AOOymxsKQEZ6YNxmdXzgnn74L9t5oZlW8T205HVZ+zZVTcSqwMEMfD5A2T?=
 =?iso-8859-1?Q?5utEkj5EPBgGvhLWCcv/gS8yTU350pCFHLDTbrRCRMV3i4DOfkBqbk7JyR?=
 =?iso-8859-1?Q?uBEdpMz3ynEPt/r9TDDbaZzyapgKOFgspm1qByAqy3LdmUmJzO+sruZi2f?=
 =?iso-8859-1?Q?xMh8mAUJeLelGmK73BEi6PlrsiLqpQqgx1LItEm9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4Qd5RE1uVnvNFbptlu1Wac3gMl/2C27lfEYyF7nVXtzVDYjxQMiYioPyZH?=
 =?iso-8859-1?Q?BUhoP+8XF2an4Ytu6fFLJ65lR8Q1GSeqLQPt+9yJbrK3XB9zq7k9IHnwoc?=
 =?iso-8859-1?Q?neo5dAhAYu/n+uW0yhH81u77R+WlAkOsss35pcJhcgKQsZDz0GRKIKkKV6?=
 =?iso-8859-1?Q?zJ5pTzuSp1OcKaVtJbqvaJYCebakOgfgfL1K0KGCqHJPIDVty+fL/urq60?=
 =?iso-8859-1?Q?G3AcPOsLyx6zJVZHfx5ApXBJwBV74RVkyakpKJV7zKROiB/7saGi3IBYrh?=
 =?iso-8859-1?Q?IuDwAuVZnGEl0BkRDtbqOQQauYUDdCcJHGPGTuTB429QNCLQ6Bp1HF2oqn?=
 =?iso-8859-1?Q?TsJIZVjCS7H/ehQIVJKC/L4f6ixMVUSVahi36f1UgxxCPtl9uWWFD9T/ya?=
 =?iso-8859-1?Q?AHv8wNj5Xc7bcqtyCzYwSEkFbSTo7fPtTSm3jY4f6iw2Oc40F3Pwqx5ip4?=
 =?iso-8859-1?Q?iyhZIo7DQROfDLq+kYoqOh1ywXZ9/Pp0pENmIEB3b3EoD4ckdsJltIQx1O?=
 =?iso-8859-1?Q?l+DINlIpvO1qWhRpLVO3HhHkCG9KsRJwrXrkBKUjTggHjTe3DSiG5spi+9?=
 =?iso-8859-1?Q?fCm79QeyJY5ASeYGKoBREepCElGcENy2wCkUgX9xk1vzIPu1t1b9lYdKsy?=
 =?iso-8859-1?Q?/jdc3SI0DKAUScop0fWNGGVTrNRQbgejZ+YjccclRw0TUYoG1E53sZePCf?=
 =?iso-8859-1?Q?MiQlCglzsdcEaA+EtT3+NSO/4sl+/+vnMKoEUjxHhpvjnTvd/uHx4lE4eq?=
 =?iso-8859-1?Q?0JHDhNINbZPRTUb6TKxwAaDQ8/uB8IkIiPyiZI5WKD2UGdAXXE1Ak6B4AR?=
 =?iso-8859-1?Q?PffpNnGPcMQ4kfg8x96g2/sX4T4W7a7Z/svaVsBDe0lz/dJajuGLRpxdxa?=
 =?iso-8859-1?Q?WOxtNMlA5gjInJ+adW4Fxz0siN+qzO5pOXvQ4IgSv0opW9y77GLRB+dZVJ?=
 =?iso-8859-1?Q?ctFaHtNY0LreA5k/qvFbEI9nC4SlIx7qbqdIUP3WAXC8qJ3URNf5Dh2zx0?=
 =?iso-8859-1?Q?4tVElO4QSGs3s4fZ8aGo8gd1A8PcKin+LdtVwA8ChHy/yCvvYFU3kKAgTN?=
 =?iso-8859-1?Q?2hkR9aXdHiG79wmMnZD9QlmRqVnmrc6UEtIcJ9wlKnEFyIbcPcobqgTtfb?=
 =?iso-8859-1?Q?ufH9E5f+15uBs/Au7FnkuKpRO0ELbW45+u6KOtnKBw37VpCeSLO+6WslaB?=
 =?iso-8859-1?Q?PZ+EDPjXwmVqVFFWygqhEhabr2Ej18sJVsSf2A3elj4lCWNYVXh1Ellheq?=
 =?iso-8859-1?Q?x1V0H7nKuFky4OJOYnWkVBbxCEMdpWxN4jP+GgTmdesu27xcl9+Fddo0Xb?=
 =?iso-8859-1?Q?JckG5iFIldCJCQbCgAbdD3mYq/W09V/MCEIGsSuptvpDoIODWoQfwLC1mF?=
 =?iso-8859-1?Q?6sf2ZfCkn+OBj5FjA9RdlPnJamjHOBPE/vrjLQP0WFf900A+MyrCeE/ZIe?=
 =?iso-8859-1?Q?zd0fuet8QJWkfbwo32ahObPa2wwjHN1iBY10IsZu+RCOyB2q8YT+bELWDa?=
 =?iso-8859-1?Q?jfiQQb4CIKfsSVauvwh2qqJZWqaiQQDM89uqeXRSVaVPv1OBEHcV+WPvlw?=
 =?iso-8859-1?Q?043yWD6hMKnakh6jIWdBFA6Q6fR5EOzrP7LDS+Xz4a65bCnTT6zNEDEBgA?=
 =?iso-8859-1?Q?4R6F9+fZEQVU/XryPGfr7b/p3wxGjeVQfXLfHKU0wajzMYR7fCbeZs863A?=
 =?iso-8859-1?Q?aSfgzH7LEMuHpk5u61aeG76K8uNx1CefE8SVvI/e1hoNXiLOvSi6IIZd4p?=
 =?iso-8859-1?Q?2dyMGyAWQbjf7LbCO9sP5hHUKnQIuZbx8ccCEdxzlcBcP3hscBKavNDf6P?=
 =?iso-8859-1?Q?51uSC0umGQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d3fee2-ac1d-4142-58e8-08de65414f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:51.3538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMoXdxEdBqptHQnFpT6qtCm3oEavo6ZGSyqKceAYdzb3Npvpw4W41Mf2JpcUYjinRKlEH7eO7cN8X1+/8e1qLZ6iKmadhokUAQu6olsa1TE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165
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

Update AST2700 HACE qtests to use the "ast2700-evb" machine alias=0A=
instead of a specific silicon revision.=0A=
=0A=
The AST2700 A1 and A2 revisions are compatible for the HACE model, so=0A=
the tests do not depend on a particular EVB revision. Using the=0A=
"ast2700-evb" alias ensures the tests always run the latest=0A=
supported AST2700 silicon revision.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/ast2700-hace-test.c | 22 +++++++++++-----------=0A=
 1 file changed, 11 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-tes=
t.c=0A=
index a400e2962b..508a34dd6c 100644=0A=
--- a/tests/qtest/ast2700-hace-test.c=0A=
+++ b/tests/qtest/ast2700-hace-test.c=0A=
@@ -23,57 +23,57 @@ static const struct AspeedMasks as2700_masks =3D {=0A=
 /* ast2700 */=0A=
 static void test_md5_ast2700(void)=0A=
 {=0A=
-    aspeed_test_md5("-machine ast2700a1-evb", 0x12070000, 0x400000000);=0A=
+    aspeed_test_md5("-machine ast2700-evb", 0x12070000, 0x400000000);=0A=
 }=0A=
 =0A=
 static void test_sha256_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha256("-machine ast2700a1-evb", 0x12070000, 0x400000000);=
=0A=
+    aspeed_test_sha256("-machine ast2700-evb", 0x12070000, 0x400000000);=
=0A=
 }=0A=
 =0A=
 static void test_sha256_sg_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha256_sg("-machine ast2700a1-evb", 0x12070000, 0x40000000=
0);=0A=
+    aspeed_test_sha256_sg("-machine ast2700-evb", 0x12070000, 0x400000000)=
;=0A=
 }=0A=
 =0A=
 static void test_sha384_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha384("-machine ast2700a1-evb", 0x12070000, 0x400000000);=
=0A=
+    aspeed_test_sha384("-machine ast2700-evb", 0x12070000, 0x400000000);=
=0A=
 }=0A=
 =0A=
 static void test_sha384_sg_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha384_sg("-machine ast2700a1-evb", 0x12070000, 0x40000000=
0);=0A=
+    aspeed_test_sha384_sg("-machine ast2700-evb", 0x12070000, 0x400000000)=
;=0A=
 }=0A=
 =0A=
 static void test_sha512_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha512("-machine ast2700a1-evb", 0x12070000, 0x400000000);=
=0A=
+    aspeed_test_sha512("-machine ast2700-evb", 0x12070000, 0x400000000);=
=0A=
 }=0A=
 =0A=
 static void test_sha512_sg_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha512_sg("-machine ast2700a1-evb", 0x12070000, 0x40000000=
0);=0A=
+    aspeed_test_sha512_sg("-machine ast2700-evb", 0x12070000, 0x400000000)=
;=0A=
 }=0A=
 =0A=
 static void test_sha256_accum_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha256_accum("-machine ast2700a1-evb", 0x12070000, 0x40000=
0000);=0A=
+    aspeed_test_sha256_accum("-machine ast2700-evb", 0x12070000, 0x4000000=
00);=0A=
 }=0A=
 =0A=
 static void test_sha384_accum_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha384_accum("-machine ast2700a1-evb", 0x12070000, 0x40000=
0000);=0A=
+    aspeed_test_sha384_accum("-machine ast2700-evb", 0x12070000, 0x4000000=
00);=0A=
 }=0A=
 =0A=
 static void test_sha512_accum_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha512_accum("-machine ast2700a1-evb", 0x12070000, 0x40000=
0000);=0A=
+    aspeed_test_sha512_accum("-machine ast2700-evb", 0x12070000, 0x4000000=
00);=0A=
 }=0A=
 =0A=
 static void test_addresses_ast2700(void)=0A=
 {=0A=
-    aspeed_test_addresses("-machine ast2700a1-evb", 0x12070000, &as2700_ma=
sks);=0A=
+    aspeed_test_addresses("-machine ast2700-evb", 0x12070000, &as2700_mask=
s);=0A=
 }=0A=
 =0A=
 int main(int argc, char **argv)=0A=
-- =0A=
2.43.0=0A=

