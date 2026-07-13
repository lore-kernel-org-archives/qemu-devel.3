Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7EFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7KG-00008V-BH; Sun, 12 Jul 2026 23:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KE-000088-Ts; Sun, 12 Jul 2026 23:27:22 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KC-0006VO-6n; Sun, 12 Jul 2026 23:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH4kJZxXZiGn6TbcR5DizMxROTCv7syUACBGMiZuhvg3jHz7VVxY5TD/HHSL4gRHo6A+DGWcMzHN5/YTGbxu8G1+UIqNAPd+UexyAWm4cH+LaVuquLg8SvtqvN0C4AfPxiQ+mQH2ErA3oMFxaQGj+mwx2Mw6WwzW+8CCYfoKPqkssK/0KB9VZ6xhR2tyAihk3PvXpHH96xxLgNONkbHr6f45owpk/KT4MtTh4/R/xn27R1fmP/LhcDnUTgLpWOX7G6oE+MT0Zf2JqUoyGlhnfR9qE8dkx4Sxb7da6Y8hvD2LDNLoKgQdLwxdT6f1UgAXqTsptau5/qk1VSLLm75tsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ESq6v+3WZG6Au/Tb1T2SaR4TimOA7JcUYYH6vpvX7Q=;
 b=yMl3MDgRUM4bYh/sTBRxBgzo88AJlc+cPABZdyWYY5FvPqRuBSeH/g6E6xqD9y6wCDRGg9E9+b5z3G3+9DSOh9tZ4gpl13+sSTUNzPByi5Kmj4Tt9QevtpD+9+iggK0VF5NW2LrgAjW8nEhqvWaxV4C2kTjEtAR0d/YCVKnkoySnnGZoQ5SNBObQfJmYr36wrQrUCordo/cvcLstmVxSzCxihtwOSyfFqQBMYLTZsBSn4qRb6Zz3DRX4vk5O1osx22QALcaCB+cWi58q5vc+xBleO/e2J8BLP9dLXIO3X/ksGB/IcIZ2XhMkFltLrJPIEbKaDU6wcaaUBU3qTW517g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ESq6v+3WZG6Au/Tb1T2SaR4TimOA7JcUYYH6vpvX7Q=;
 b=Sfrxh1zJF0UH3iYSpaVBMknfaCYj5ZVIJapFHTOarqisuQCx17M4IKWIKs1KEApAhAjfrIRd0byu29SG5G5E5hannydpxcJ1SSVagPolOJWk/4j6QkoPUl5gCrhsk955wYWE+mCBbXKceeuH8HOhbncKyN8qW7qJiirm9inbT6XG8N40y385mFb6FqIn9G6jzCR9M8/Gdstg6/1dIUtpxA7jPYcz7QjGLehTR0WWIZ1oOTDK8H9zEwQ+/FP2dgeXmWACDnWSKcdIjiWzQ6H3yyQuC0C94Cs0QvYN9PIMaVTaytTVlcKmKgGAoT/ws4Q8TbakdjsVa8+DOXQNcPJ2hQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:07 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v7 01/10] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Thread-Topic: [PATCH v7 01/10] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Thread-Index: AQHdEnd7d/bpHLjsb0iy+TFMfeXGzA==
Date: Mon, 13 Jul 2026 03:27:07 +0000
Message-ID: <20260713032704.3583103-2-jamin_lin@aspeedtech.com>
References: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8221:EE_
x-ms-office365-filtering-correlation-id: d6bf15a2-707c-4307-6264-08dee08e9e29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|3023799007|22082099003|18002099003|38070700021|56012099006|6133799003|921020;
x-microsoft-antispam-message-info: SQCZHXE4LrX/mpg2386F6g/KV0PVOeL+HUQHjbBGu7ASoaiSkCwllzaIJu2yzI9FvGadEkPbojl9Rof7rbat6r9XHb7qDa0m0hUQr+HZmYb0Lhx5yYoeIF9nwufQWEdVYgBRe6A9u0dr0DA6GEJU1Pl+DqjYKZAv7elby7AdzIAyUCuWzdhCi0JUIIxxdQOCVeRcdkkRjRYcTvuIcrcbXEU/O83ZUK6ey91F+dnTndFZvJa0VPqytxuX9/wAEJfKyh2mX3TErGOyXBCXuhmLnZda6cY+9cDWGM8cd+uGuCpD7nqlWnpQXExIXMb82V84E8OvXV2MMFzOrMqWOGO2XJ5shXg5mikZ/MhBFRabfZP6nWqQxpTpoEQ1y76oXFyFUqG/NC8r4JqYHTgdXKNpOJaY7hdGAAz1htZnioffwN0ZscoichSTUEEmFP9rV236vNEUiTm5jw+Dhut/EM1rmudZY+x0zDHrehU4Sk1G7uXaw6LnR6Q0l3k40iTplJ7XH96cTpQqAm6wNcekzWF0xGnheZlZkV3tOvjXK6gNbHo+H8sXV82kImxfPYvt8IQ3q3d3yx4vcKnjk12sz+E4aGTMedOnAvfgphxt3UBXOVnD85UJr6Ca8RUjs23qnxD4+0QDJjkPx/7mLEc0TwlkedZX5zexb9mYLNmVWweKsOJuwymibqaUFNPhyzkL168bZEjj3KLt4y9SE9oWrW5lugrEme+EPAqDGgpSIpUSrYesi7CcEJ0rp09DQeA0qF5d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(3023799007)(22082099003)(18002099003)(38070700021)(56012099006)(6133799003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SQT14e8XzHUNBQKf0FbLAPffebZ8eSBHpJ/Ci7yBYO7/rAoghnCAJJeiX4?=
 =?iso-8859-1?Q?fP0l26yW8tCLFMrFaQYr0kWI9NxE5weDoOY7Ne+uWPaXGb7w0+BbT228vV?=
 =?iso-8859-1?Q?slagalGivC5dlh4/2goLE/doGvlXyQWkkfbg/cjD5yBVR1LQap/57YYMyD?=
 =?iso-8859-1?Q?bo4QK5FvWeGIDvHtEVKURsP5Gs6yH9Vyf/mkr0TkPqn6X9ebp4SiJ0dy3O?=
 =?iso-8859-1?Q?Z2H3Z3ECqewbtWztVLcwWOSSuNqxIXcvxJtl6m0kAG6E6eqYVYURbLp8sV?=
 =?iso-8859-1?Q?kgCaHl4pArz6xBPKabToRiG+YRhVdJ7/sdrEOJ1t1/coGVPQp1JS7JzCMM?=
 =?iso-8859-1?Q?YOQrZigLSaSQPsGAmJP0+mSGiE79+MeYQXzrBA4+aeFK5H2/jioO3fwrJc?=
 =?iso-8859-1?Q?zuZqwybU1AlyYjR9GWSsmjjdJZYi8KqwiPdeKR8pfzoDWJkyL4wzhJ//ln?=
 =?iso-8859-1?Q?tOs8NyvXMFhzyh3kli2oTRgWkUscoNrOSA4sRxmGpZNz9D93LDqmAU+63B?=
 =?iso-8859-1?Q?EMDSB+ykoDZK5kvu9lgPJtAq2fe/QdqBxOeS+hxaBzfKxnhJQ5ls0uD0qK?=
 =?iso-8859-1?Q?bKbAcCYWbKlo9kMgdKQ5IXDm5b2FT8GvIky5V89VcjTLa/mOLvcjQVw5ts?=
 =?iso-8859-1?Q?HABJot0jbFTIp6ZKzVS9XUTCh8qE7EmbbPCjrtVSA5ius/MCDRseJNTFnA?=
 =?iso-8859-1?Q?TgOh/VHkRFjLsVu2QuCZkcoX2vCy49bWRW4TPa2/22MqF1x+ZS++FRxc4l?=
 =?iso-8859-1?Q?MwqfME70qOqNdnITcGfcvPz3VglJPrWKo4xK+mQuVTDIXmdAnBCgpuEQEb?=
 =?iso-8859-1?Q?01Cn6P/ah270gp5svA9nH0sirLx7GfqQVyeLwLWrn/7KE3BlCD2THhNc3B?=
 =?iso-8859-1?Q?UQABongmrgfKF1U9+WOY6BqSoC0BuRdVBr0KZ/GR7nhxNR1QhQJzI6Cc/0?=
 =?iso-8859-1?Q?AtPqkoRFKD62VDqiiBQ5jY49geIJdpbo5yWnpwhW18PFT3WmWelevU5uRm?=
 =?iso-8859-1?Q?FN4RfNaChVyrVU6J1pZz6bZB5dg6EyX7n640PExp/qXOmfhpue3q2c5UEH?=
 =?iso-8859-1?Q?n7YIa5oc+dtWD3MaLZJz/kBz5QTg4K+S4yff903Zx4Ms9xHC06F1q7/fL9?=
 =?iso-8859-1?Q?oa40Jay24hH6MC5nooHv7BMaaOMZ1Y4JCxhCKbVL5EGFWurik38kWNrBnM?=
 =?iso-8859-1?Q?UVY+5uzNG74GKO6a0sfNzQ1qzjqpKVswW13Pvsy9ApjDDRJ22l2OcectJO?=
 =?iso-8859-1?Q?fIv4cSmdsMIKd1ffUbwKazYMvqUKp3nQBj4SrK6R+MqE3hiKg3AK0zW6Bp?=
 =?iso-8859-1?Q?tha+dsrTSyuNvHr8hn90J7K0MXcN9QkTR1qRxGbak5dqDxbnN7FLVXLenx?=
 =?iso-8859-1?Q?/cmub2bIvIArtOaYABqVdyZrU8CWOTcNibaoTZUHRu4U9ydPF2NQhwN1Bf?=
 =?iso-8859-1?Q?AtWKCkWYJzY4CF7RBZcPesyucNNC/UVLFOKa8EadcwBcmE9Byb9o5sDfxN?=
 =?iso-8859-1?Q?QTXekK4gtJbJphEoY5LTtsQ5/P7bdt2mMtI9qGwcZDTzCIlDwzEaTpDosw?=
 =?iso-8859-1?Q?PdNOsa0LS0OUriDpAjD/a0TUN6WyqMpcT7QOrhiZI8Dx83teyPODo0YAKH?=
 =?iso-8859-1?Q?ZnkyUer0fkG75l1vIVqbGs8dnEmM8FE96x800U1lyVkxRmfKnmswqb4C7y?=
 =?iso-8859-1?Q?nQ2tzVIxnVbBXNjgVyQhL3eLM0VT2FQexf0C99laCiCWy4+0Xls1dtbAa/?=
 =?iso-8859-1?Q?E5JITOLcDGnoNLYoBmcvU7tofGbe8H1V8pq1ERtqFqvAonbd9+CFmRzDEd?=
 =?iso-8859-1?Q?5mqbLuVcrw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IoNgQZerTiD7eAgYmlGEpM4EEEbY5MMi/wCLfdKuWWi4pui0+syGWXutxGe70sLuGs0lpjzASaiRK/LQhB9iMhw0umFsDrQILPSHofJmJdsCaBB1Z6aJgkUGvSZfizabDuj1Y46LXH+ARuzwT9Nfqm4DvcCbfxFAhmJtC3QxmPfBmRTxqHFdgEbED/LKV1LKQ45oKiHC6rCX81SnzFDHiM2aRGOPRYfScJLBZSYJDBkscKTN4hDR6S34J5joM3r8CKtG3p2ahSDD6hf7XVtvjxUVz2VAQtTsgXDf82+W6rmuCx9UVDsIL0U6V8Xj4/V51MI3rKGXgCbWDSkysBH1iw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bf15a2-707c-4307-6264-08dee08e9e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:07.5555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUdV6Bzx6qfVpuGqi+wMpgT43jvJXL70TIui7BA8/dY5ajcmmfQRAr2hnvqlW0ePVcKAll6UvblOkuactaI57/MBKqahvCxsi+88Fo7Ncww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8221
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Change internal EHCI descriptor addresses from uint32_t to uint64_t.=0A=
=0A=
The following fields are updated:=0A=
- EHCIPacket::qtdaddr=0A=
- EHCIQueue::{qhaddr, qtdaddr}=0A=
- EHCIState::{a_fetch_addr, p_fetch_addr}=0A=
=0A=
Update get_dwords() and put_dwords() to take 64-bit addresses and=0A=
propagate the type change through the descriptor traversal paths.=0A=
=0A=
Adjust NLPTR_GET() to operate on 64-bit values:=0A=
=0A=
    #define NLPTR_GET(x) ((x) & ~0x1fULL)=0A=
=0A=
so that link pointer masking works correctly when descriptor=0A=
addresses exceed 32-bit space. The previous mask (0xffffffe0)=0A=
implicitly truncated addresses to 32 bits.=0A=
=0A=
This patch does not change the on-wire descriptor layout yet.=0A=
It only removes the internal 32-bit address limit and prepares=0A=
for later patches that will add full 64-bit QH/qTD/iTD/siTD support.=0A=
=0A=
Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to=0A=
use uint64_t for the address argument and print it with PRIx64. This=0A=
ensures full 64-bit addresses are shown in trace output and improves=0A=
debugging of queue heads and transfer descriptors.=0A=
=0A=
Migration compatibility:=0A=
=0A=
To preserve backward migration compatibility, keep the legacy 32-bit=0A=
fetch address fields (a_fetch_addr_32, p_fetch_addr_32) alongside the=0A=
new 64-bit fields.=0A=
=0A=
Migration format is selected using a machine compat property=0A=
"x-migrate-fetch-addr-64bit":=0A=
=0A=
- Old machine types migrate 32-bit fetch addresses=0A=
- New machine types migrate full 64-bit fetch addresses=0A=
=0A=
This is implemented using VMSTATE_UINT32_TEST() and=0A=
VMSTATE_UINT64_TEST() so that only the appropriate format is migrated.=0A=
=0A=
In pre_save, the 32-bit shadow fields are populated when migrating=0A=
to old machine types. In post_load, the 32-bit values are restored=0A=
into the 64-bit fields when loading old migration streams.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h   | 30 +++++++++++++-----=0A=
 hw/core/machine.c   |  2 ++=0A=
 hw/usb/hcd-ehci.c   | 74 +++++++++++++++++++++++++++++++--------------=0A=
 hw/usb/trace-events | 24 +++++++--------=0A=
 4 files changed, 89 insertions(+), 41 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index d038ee1e31..cbc32c296d 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -208,7 +208,7 @@ struct EHCIPacket {=0A=
     QTAILQ_ENTRY(EHCIPacket) next;=0A=
 =0A=
     EHCIqtd qtd;           /* copy of current QTD (being worked on) */=0A=
-    uint32_t qtdaddr;      /* address QTD read from                 */=0A=
+    uint64_t qtdaddr;      /* address QTD read from                 */=0A=
 =0A=
     USBPacket packet;=0A=
     QEMUSGList sgl;=0A=
@@ -229,8 +229,8 @@ struct EHCIQueue {=0A=
      * when guest removes an entry (doorbell, handshake sequence)=0A=
      */=0A=
     EHCIqh qh;             /* copy of current QH (being worked on) */=0A=
-    uint32_t qhaddr;       /* address QH read from                 */=0A=
-    uint32_t qtdaddr;      /* address QTD read from                */=0A=
+    uint64_t qhaddr;       /* address QH read from                 */=0A=
+    uint64_t qtdaddr;      /* address QTD read from                */=0A=
     int last_pid;          /* pid of last packet executed          */=0A=
     USBDevice *dev;=0A=
     QTAILQ_HEAD(, EHCIPacket) packets;=0A=
@@ -256,6 +256,11 @@ struct EHCIState {=0A=
 =0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
+    /*=0A=
+     * Controls migration stream compatibility for old machine types.=0A=
+     * Old machine types only transfer 32-bit fetch addresses.=0A=
+     */=0A=
+    bool migrate_fetch_addr_64bit;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -293,9 +298,18 @@ struct EHCIState {=0A=
     EHCIQueueHead aqueues;=0A=
     EHCIQueueHead pqueues;=0A=
 =0A=
-    /* which address to look at next */=0A=
-    uint32_t a_fetch_addr;=0A=
-    uint32_t p_fetch_addr;=0A=
+    /*=0A=
+     * which address to look at next=0A=
+     *=0A=
+     * Migration compatibility fields for old machine types that only=0A=
+     * support 32-bit fetch addresses in the migration stream.=0A=
+     *=0A=
+     * New machine types migrate the full 64-bit runtime fetch address.=0A=
+     */=0A=
+    uint32_t migrate_a_fetch_addr;=0A=
+    uint32_t migrate_p_fetch_addr;=0A=
+    uint64_t a_fetch_addr;=0A=
+    uint64_t p_fetch_addr;=0A=
 =0A=
     USBPacket ipacket;=0A=
     QEMUSGList isgl;=0A=
@@ -308,7 +322,9 @@ struct EHCIState {=0A=
 };=0A=
 =0A=
 #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \=0A=
-    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128)=0A=
+    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \=0A=
+    DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \=0A=
+                     ehci.migrate_fetch_addr_64bit, true)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index 15886a56b1..148b960b70 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -49,6 +49,8 @@ GlobalProperty hw_compat_11_0[] =3D {=0A=
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },=0A=
     { TYPE_ARM_SMMUV3, "oas", "44" },=0A=
     { "migration", "switchover-ack-legacy", "on" },=0A=
+    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
 };=0A=
 const size_t hw_compat_11_0_len =3D G_N_ELEMENTS(hw_compat_11_0);=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 28a60e4c1a..1a0c580115 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -72,7 +72,7 @@ typedef enum {=0A=
 } EHCI_STATES;=0A=
 =0A=
 /* macros for accessing fields within next link pointer entry */=0A=
-#define NLPTR_GET(x)             ((x) & 0xffffffe0)=0A=
+#define NLPTR_GET(x)             ((x) & ~0x1fULL)=0A=
 #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)=0A=
 #define NLPTR_TBIT(x)            ((x) & 1)  /* 1=3Dinvalid, 0=3Dvalid */=
=0A=
 =0A=
@@ -287,7 +287,7 @@ static int ehci_get_state(EHCIState *s, int async)=0A=
     return async ? s->astate : s->pstate;=0A=
 }=0A=
 =0A=
-static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)=0A=
+static void ehci_set_fetch_addr(EHCIState *s, int async, uint64_t addr)=0A=
 {=0A=
     if (async) {=0A=
         s->a_fetch_addr =3D addr;=0A=
@@ -296,7 +296,7 @@ static void ehci_set_fetch_addr(EHCIState *s, int async=
, uint32_t addr)=0A=
     }=0A=
 }=0A=
 =0A=
-static int ehci_get_fetch_addr(EHCIState *s, int async)=0A=
+static uint64_t ehci_get_fetch_addr(EHCIState *s, int async)=0A=
 {=0A=
     return async ? s->a_fetch_addr : s->p_fetch_addr;=0A=
 }=0A=
@@ -373,7 +373,7 @@ static inline bool ehci_periodic_enabled(EHCIState *s)=
=0A=
 }=0A=
 =0A=
 /* Get an array of dwords from main memory */=0A=
-static inline int get_dwords(EHCIState *ehci, uint32_t addr,=0A=
+static inline int get_dwords(EHCIState *ehci, uint64_t addr,=0A=
                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
@@ -395,7 +395,7 @@ static inline int get_dwords(EHCIState *ehci, uint32_t =
addr,=0A=
 }=0A=
 =0A=
 /* Put an array of dwords in to main memory */=0A=
-static inline int put_dwords(EHCIState *ehci, uint32_t addr,=0A=
+static inline int put_dwords(EHCIState *ehci, uint64_t addr,=0A=
                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
@@ -549,7 +549,7 @@ static void ehci_free_packet(EHCIPacket *p)=0A=
 =0A=
 /* queue management */=0A=
 =0A=
-static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint32_t addr, int asy=
nc)=0A=
+static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint64_t addr, int asy=
nc)=0A=
 {=0A=
     EHCIQueueHead *head =3D async ? &ehci->aqueues : &ehci->pqueues;=0A=
     EHCIQueue *q;=0A=
@@ -622,7 +622,7 @@ static void ehci_free_queue(EHCIQueue *q, const char *w=
arn)=0A=
     g_free(q);=0A=
 }=0A=
 =0A=
-static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint32_t addr,=0A=
+static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint64_t addr,=0A=
                                         int async)=0A=
 {=0A=
     EHCIQueueHead *head =3D async ? &ehci->aqueues : &ehci->pqueues;=0A=
@@ -1135,7 +1135,7 @@ static void ehci_flush_qh(EHCIQueue *q)=0A=
 {=0A=
     uint32_t *qh =3D (uint32_t *) &q->qh;=0A=
     uint32_t dwords =3D sizeof(EHCIqh) >> 2;=0A=
-    uint32_t addr =3D NLPTR_GET(q->qhaddr);=0A=
+    uint64_t addr =3D NLPTR_GET(q->qhaddr);=0A=
 =0A=
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);=
=0A=
 }=0A=
@@ -1406,12 +1406,13 @@ static int ehci_execute(EHCIPacket *p, const char *=
action)=0A=
 /* 4.7.2 */=0A=
 static int ehci_process_itd(EHCIState *ehci,=0A=
                             EHCIitd *itd,=0A=
-                            uint32_t addr)=0A=
+                            uint64_t addr)=0A=
 {=0A=
     USBDevice *dev;=0A=
     USBEndpoint *ep;=0A=
     uint32_t i, len, pid, dir, devaddr, endp;=0A=
-    uint32_t pg, off, ptr1, ptr2, max, mult;=0A=
+    uint32_t pg, off, max, mult;=0A=
+    uint64_t ptr1, ptr2;=0A=
 =0A=
     ehci->periodic_sched_active =3D PERIODIC_ACTIVE;=0A=
 =0A=
@@ -1528,7 +1529,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint32_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D ehci->asynclistaddr;=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1578,7 +1579,7 @@ out:=0A=
 static int ehci_state_fetchentry(EHCIState *ehci, int async)=0A=
 {=0A=
     int again =3D 0;=0A=
-    uint32_t entry =3D ehci_get_fetch_addr(ehci, async);=0A=
+    uint64_t entry =3D ehci_get_fetch_addr(ehci, async);=0A=
 =0A=
     if (NLPTR_TBIT(entry)) {=0A=
         ehci_set_state(ehci, async, EST_ACTIVE);=0A=
@@ -1611,8 +1612,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)=0A=
     default:=0A=
         /* TODO: handle FSTN type */=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "FETCHENTRY: entry at 0x%x is of type %u "=0A=
-                      "which is not supported yet\n",=0A=
+                      "FETCHENTRY: entry at %" PRIx64 " is of type %" PRIu=
64=0A=
+                      " which is not supported yet\n",=0A=
                       entry, NLPTR_TYPE_GET(entry));=0A=
         return -1;=0A=
     }=0A=
@@ -1623,7 +1624,7 @@ out:=0A=
 =0A=
 static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIQueue *q;=0A=
     EHCIqh qh;=0A=
 =0A=
@@ -1712,7 +1713,7 @@ out:=0A=
 =0A=
 static int ehci_state_fetchitd(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIitd itd;=0A=
 =0A=
     assert(!async);=0A=
@@ -1738,7 +1739,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
 static int ehci_state_fetchsitd(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIsitd sitd;=0A=
 =0A=
     assert(!async);=0A=
@@ -1802,7 +1803,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
     EHCIqtd qtd;=0A=
     EHCIPacket *p;=0A=
     int again =3D 1;=0A=
-    uint32_t addr;=0A=
+    uint64_t addr;=0A=
 =0A=
     addr =3D NLPTR_GET(q->qtdaddr);=0A=
     if (get_dwords(q->ehci, addr +  8, &qtd.token,   1) < 0) {=0A=
@@ -1885,7 +1886,7 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
     USBEndpoint *ep =3D p->packet.ep;=0A=
     EHCIQueue *q =3D p->queue;=0A=
     EHCIqtd qtd =3D p->qtd;=0A=
-    uint32_t qtdaddr;=0A=
+    uint64_t qtdaddr;=0A=
 =0A=
     for (;;) {=0A=
         if (NLPTR_TBIT(qtd.next) !=3D 0) {=0A=
@@ -2008,7 +2009,8 @@ static int ehci_state_executing(EHCIQueue *q)=0A=
 static int ehci_state_writeback(EHCIQueue *q)=0A=
 {=0A=
     EHCIPacket *p =3D QTAILQ_FIRST(&q->packets);=0A=
-    uint32_t *qtd, addr;=0A=
+    uint32_t *qtd;=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
     /*  Write back the QTD from the QH area */=0A=
@@ -2414,6 +2416,18 @@ static USBBusOps ehci_bus_ops_standalone =3D {=0A=
     .wakeup_endpoint =3D ehci_wakeup_endpoint,=0A=
 };=0A=
 =0A=
+static bool ehci_fetch_addr_64_needed(void *opaque, int version_id)=0A=
+{=0A=
+    EHCIState *s =3D opaque;=0A=
+=0A=
+    return s->migrate_fetch_addr_64bit;=0A=
+}=0A=
+=0A=
+static bool ehci_fetch_addr_32_needed(void *opaque, int version_id)=0A=
+{=0A=
+    return !ehci_fetch_addr_64_needed(opaque, version_id);=0A=
+}=0A=
+=0A=
 static int usb_ehci_pre_save(void *opaque)=0A=
 {=0A=
     EHCIState *ehci =3D opaque;=0A=
@@ -2424,6 +2438,11 @@ static int usb_ehci_pre_save(void *opaque)=0A=
     ehci->last_run_ns -=3D (ehci->frindex - new_frindex) * UFRAME_TIMER_NS=
;=0A=
     ehci->frindex =3D new_frindex;=0A=
 =0A=
+    if (!ehci->migrate_fetch_addr_64bit) {=0A=
+        ehci->migrate_a_fetch_addr =3D ehci->a_fetch_addr;=0A=
+        ehci->migrate_p_fetch_addr =3D ehci->p_fetch_addr;=0A=
+    }=0A=
+=0A=
     return 0;=0A=
 }=0A=
 =0A=
@@ -2444,6 +2463,11 @@ static int usb_ehci_post_load(void *opaque, int vers=
ion_id)=0A=
         }=0A=
     }=0A=
 =0A=
+    if (!s->migrate_fetch_addr_64bit) {=0A=
+        s->a_fetch_addr =3D s->migrate_a_fetch_addr;=0A=
+        s->p_fetch_addr =3D s->migrate_p_fetch_addr;=0A=
+    }=0A=
+=0A=
     return 0;=0A=
 }=0A=
 =0A=
@@ -2504,8 +2528,14 @@ const VMStateDescription vmstate_ehci =3D {=0A=
         /* schedule state */=0A=
         VMSTATE_UINT32(astate, EHCIState),=0A=
         VMSTATE_UINT32(pstate, EHCIState),=0A=
-        VMSTATE_UINT32(a_fetch_addr, EHCIState),=0A=
-        VMSTATE_UINT32(p_fetch_addr, EHCIState),=0A=
+        VMSTATE_UINT32_TEST(migrate_a_fetch_addr, EHCIState,=0A=
+                            ehci_fetch_addr_32_needed),=0A=
+        VMSTATE_UINT32_TEST(migrate_p_fetch_addr, EHCIState,=0A=
+                            ehci_fetch_addr_32_needed),=0A=
+        VMSTATE_UINT64_TEST(a_fetch_addr, EHCIState,=0A=
+                            ehci_fetch_addr_64_needed),=0A=
+        VMSTATE_UINT64_TEST(p_fetch_addr, EHCIState,=0A=
+                            ehci_fetch_addr_64_needed),=0A=
         VMSTATE_END_OF_LIST()=0A=
     }=0A=
 };=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 0d4318dcf1..8c90688bb3 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -86,15 +86,15 @@ usb_ehci_portsc_write(uint32_t addr, uint32_t port, uin=
t32_t val) "wr mmio 0x%04=0A=
 usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_=
t old) "ch mmio 0x%04x [port %d] =3D 0x%x (old: 0x%x)"=0A=
 usb_ehci_usbsts(const char *sts, int state) "usbsts %s %d"=0A=
 usb_ehci_state(const char *schedule, const char *state) "%s schedule %s"=
=0A=
-usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0=
x%08x,0x%08x"=0A=
-usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
-usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x=
 - c %d, h %d, dtc %d, i %d"=0A=
+usb_ehci_qh_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%" PRIx64 ": next 0x%08x qtds 0=
x%08x,0x%08x,0x%08x"=0A=
+usb_ehci_qh_fields(uint64_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%" PRIx64 " - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
+usb_ehci_qh_bits(uint64_t addr, int c, int h, int dtc, int i) "QH @ 0x%" P=
RIx64 " - c %d, h %d, dtc %d, i %d"=0A=
 usb_ehci_qh_tbytes(uint32_t tbytes) "updating tbytes to %d"=0A=
-usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"=0A=
-usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
-usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacte=
rr %d"=0A=
-usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, u=
int32_t ep, uint32_t devaddr) "ITD @ 0x%08x: next 0x%08x - mplen %d, mult %=
d, ep %d, dev %d"=0A=
-usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ 0x%08x:=
 next 0x%08x - active %d"=0A=
+usb_ehci_qtd_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%" PRIx64 ": next 0x%08x altnext 0x%08x"=0A=
+usb_ehci_qtd_fields(uint64_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%" PRIx64 " - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
+usb_ehci_qtd_bits(uint64_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%" PRIx64 " - ioc %d, active %d, halt %d, babble %d=
, xacterr %d"=0A=
+usb_ehci_itd(uint64_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, u=
int32_t ep, uint32_t devaddr) "ITD @ 0x%" PRIx64 ": next 0x%08x - mplen %d,=
 mult %d, ep %d, dev %d"=0A=
+usb_ehci_sitd(uint64_t addr, uint32_t nxt, uint32_t active) "SITD @ 0x%" P=
RIx64 ": next 0x%08x - active %d"=0A=
 usb_ehci_port_attach(uint32_t port, const char *owner, const char *device)=
 "attach port #%d, owner %s, device %s"=0A=
 usb_ehci_port_detach(uint32_t port, const char *owner) "detach port #%d, o=
wner %s"=0A=
 usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"=0A=
@@ -104,15 +104,15 @@ usb_ehci_port_resume(uint32_t port) "port #%d"=0A=
 usb_ehci_port_disable(uint32_t port) "port #%d"=0A=
 usb_ehci_queue_action(void *q, const char *action) "q %p: %s"=0A=
 usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %=
s"=0A=
-usb_ehci_packet_submit(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, i=
nt pid, size_t len, int endp, int status, int actual_length) "qh=3D0x%x, ne=
xt=3D0x%x, qtd=3D0x%x, pid=3D0x%x, len=3D%zd, endp=3D0x%x, status=3D%d, act=
ual_length=3D%d"=0A=
+usb_ehci_packet_submit(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr, i=
nt pid, size_t len, int endp, int status, int actual_length) "qh=3D0x%" PRI=
x64 ", next=3D0x%x, qtd=3D0x%" PRIx64 ", pid=3D0x%x, len=3D%zd, endp=3D0x%x=
, status=3D%d, actual_length=3D%d"=0A=
 usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask=
) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"=0A=
 usb_ehci_guest_bug(const char *reason) "%s"=0A=
 usb_ehci_doorbell_ring(void) ""=0A=
 usb_ehci_doorbell_ack(void) ""=0A=
 usb_ehci_dma_error(void) ""=0A=
-usb_ehci_execute_complete(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%x, next=3D0x%x, qtdaddr=3D0x%=
x, status=3D%d, actual_length=3D%d"=0A=
-usb_ehci_fetchqh_reclaim_done(uint32_t qhaddr) "QH 0x%08x H-bit set, recla=
mation status reset - done processing"=0A=
-usb_ehci_fetchqh_dbg(uint32_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%08x (h 0x%x halt 0x%x active 0x%x) next 0x%08=
x"=0A=
+usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%" PRIx64 ", next=3D0x%x, qtda=
ddr=3D0x%" PRIx64 ", status=3D%d, actual_length=3D%d"=0A=
+usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set=
, reclamation status reset - done processing"=0A=
+usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) nex=
t 0x%08x"=0A=
 usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
 usb_ehci_log(const char *msg) "%s"=0A=
-- =0A=
2.43.0=0A=

