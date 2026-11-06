Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153C606A31B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=JVnNkUaJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPAg0-0006Rs-1d; Thu, 05 Nov 2026 22:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xPAfx-0006P0-Rp; Thu, 05 Nov 2026 22:31:38 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xPAfw-0001yY-0k; Thu, 05 Nov 2026 22:31:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t23udFQ0sSf9j5IfobNXpZO4angKrrwT/qNpJroFycmM7uc8KpZwOxtG/85gKTOO/Jms7VuDciKUcdyIH7kTJjrDlJG6FtXeq+1usYLWzGyGT6V534f6A4WKlKk+GDjJm3AuKEwtmD6n9b4wYnbfxaMvYpOB9L9/CJqiV1AgwZRW//P52FVNHVmgzx5SerOtzGWSmlmKdI8d4X3Hs5YK7UvpWm54h0ZxkS3mz4nkyUy8u32vxZAiGXa/P22uuoUgqmVK585+pe2h4DYZLXW66nPe5dTsBoPTmmV0KS8c+prG/HE23wjwpJ/Djv5QbJKAXMdAasWrtdsMQ9k3bWmAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxtBzvEaplZGeOwjPUAiPIdEPs/14NqkHNmwzBuhzNk=;
 b=QJQTzGV2Pq237sxqpdROHGZa/I0Jt6aMUXuMgbyY75YecVPfEjULYFTOt1mnHXfrasC5dlCI3PQZd8yczPKF9TVJuFljsY/++G4FAvs9s+bJiyEV1+DlpnnGRs8ssyVOcXJN319BuoqHYrDUaixUvyz2gg6YHV8TY+ImDC0FnZGT0ee2LQQ0ka7V/u/5G7wCSQ5eHyA1XfimiYQwfGcWSdj5sbWn3wh3soj9Qs7eOOLpN4Gm84J2AJ/7FE5d7WMGdPvDAWmDus4JxvEZvyh+toVLUCC5ZkDqOAQ3AROC5Q9nr/pMRbACCFuVf0FjesDny408M3mwDeeyqL4x436NCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxtBzvEaplZGeOwjPUAiPIdEPs/14NqkHNmwzBuhzNk=;
 b=JVnNkUaJUQDyku79L/yeHf0f4iqFJ99ykxtJ+6spTn1sXeN7pr6UjnCgTsndnVcM98bDB3S7nTsC9oStyCbcrxkq/uBkdsw/r1sLZgegrNnr840OntMRwTN+4XfKzmgmTFde7W7KhZ/viOBmwnb3UDLev1MZ4xNvxW2INO7nE+An/wcIh/QEUQ/wgu0rPhakgGLOsehFud7ib27KB1Ekvy+2RcueS7pReQOOhsYWcd8gtcHSSHPZfOQ9qDBPoBjBufcIN3n/fHMW9UxZWh/4ee1nv4Llv73rVJS7nbRsEKYefhVr+Ah/ppQ3/0LOcW5l8ywu4sr4BvibPHilCYHj7A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5073.apcprd06.prod.outlook.com (2603:1096:400:1c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 03:31:30 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 03:31:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Junjie Cao <junjie.cao@linux.dev>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "clg@kaod.org" <clg@kaod.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "kfting@nuvoton.com" <kfting@nuvoton.com>,
 "wuhaotsh@google.com" <wuhaotsh@google.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "deller@gmx.de" <deller@gmx.de>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>, "anthony@xenproject.org"
 <anthony@xenproject.org>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, Troy Lee <troy_lee@aspeedtech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>
Subject: RE: [PATCH v8 10/18] docs/system/devices/usb: Note the automatic hub
 change
Thread-Topic: [PATCH v8 10/18] docs/system/devices/usb: Note the automatic hub
 change
Thread-Index: AQHdaqunzKBY01X8UU66zw8KbkYNarccaGsAgAQAgEA=
Date: Fri, 6 Nov 2026 03:31:30 +0000
Message-ID: <SEZPR06MB73624ACE053849A4FF8E1913FC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-11-jamin_lin@aspeedtech.com>
 <20261103142327.1348025-4-junjie.cao@linux.dev>
In-Reply-To: <20261103142327.1348025-4-junjie.cao@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5073:EE_
x-ms-office365-filtering-correlation-id: 5e7dbe9c-2b5f-4e1b-4a55-08df3bb67299
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|4143699003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 1DtwAzdSvPfVnDsAO/jIP+RMVrmmWlTyRH9cpK6k6XVhOoQC8kaI6bDczKFKLyOzOx0RtT22xSU8AB5nlHCL+GGO/2+IBGdZy8YlG5ixcv51SJfcMS6aDY0nk/QnIUex3cgv/tZ+7oLCV7gyxR96U8g090JEDkVt1jLrUB1kr6Y/LPx8IezT4/oy2BNZx7cEAoWbhKG3Mk6JNPQCZsbWHPq5ofNO0psQjZoWkkK79nwFQXGCGCKG7I9vk3U7FuR+X9PXaDj/JOt561CiJOTkV4mI9obcjbZeqktfctS3lZyGAxq0Cw5COyx9c0BglqPcCrvX2PZJb1P198GWoYQWGboeE3ZLuc5t2rzrPzRpL+B7nXNUeusMH1w4oYtT8jU0QLZpSjH8ov2JQ7x6emEurEZcFy9gMChrzQtA0EqwAh5Ocd6sZipvhUzZKQ+HnMImykRUM0UWFtk5OQBu5gVlGqbK0tOFLNEAS6UFjCOtmtl7JElPB47leNvUnXhSdSFO+bG4of0w2jpjkll6Fbn05o1AS4K2gaAEo7Er+EoxYTzVgF5TQp0vMft6HsQMLSJ65bZwFtd7kdq3ofhYRlg2EyxiozpWljLGe5cz8w6+FmPEDxqHSRru9yhVOw34kvXDrr5ZC0ECh5jDXdAqMm2y+pXM5rpQhn+mcHic3yRlcOZgLc9LKSiV0hRlK1mm6RhH/jUGo0mndq/Knu5vvRL/7tER9iOnjVZ8AYj47t8sRyA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q5yySy3AJnGtBckCKtYlg7Ts4ntAC6LuwOdWK9vzG1El5dw9yJnAZIBTAV08?=
 =?us-ascii?Q?ZrgAhAFWIGws2eg0GjBGf6eSDc1/ZQTAFCTeYsdx+gkCYdfY6lGK5k8pekBr?=
 =?us-ascii?Q?meIEG7bKcwpZO8B31jKYel6kR10Z871CrImhBTfWTZ4K0yya6Z0NC2uEtmNF?=
 =?us-ascii?Q?eIN3yUnuEc5pKMZ8ZALwlqeC6Wh3/NfKBX+s+P1aS+pwNxmDZX6CbfqjdVo/?=
 =?us-ascii?Q?lIMF69IR3L1LtcouvGHwAUOqPRfIAhzgWmLcTzX0kd/9snqbZNTLmrag9aM5?=
 =?us-ascii?Q?PCtEqbIhjYfg1P3g7zM8BMfcihFJBY2bIT+YZkRBdqxk+1WNZGKN9DgGaiGH?=
 =?us-ascii?Q?ZpVa2cedotwbuLd3VH9fNJirzKWV2T2JYo1RjsFvyBXfNYaQD5sVIg8At6fa?=
 =?us-ascii?Q?ZlB2FHuXwM+seL6BwgTzf0WEOiCLr7MaKCYx+FTWB36EzxNC+i1AW+6LetwX?=
 =?us-ascii?Q?/K8urWcr/adOdRUpyaIi2ASs8zGfQYBtkcBe7PvooNYO9uIhHoE/FxA/eJrZ?=
 =?us-ascii?Q?Y3WlUio4Legk38vqV+FrBU2ZVYElFBLVxs8nCCDfwVecaxrhGjs/6Ba6/3sv?=
 =?us-ascii?Q?ROZwGWA/i+9cmSDNBEtHy79uLN+7mmUEGJTPnRZzQiguIxShBoLHZ+fkwZaB?=
 =?us-ascii?Q?bxWqomGESWqjEYdgCqEKBn7oZFJUF2VOfeqTrbaONDcQ8GOImJynjDEM9yGc?=
 =?us-ascii?Q?bWzmgaPcw5PnGGZ4HUdU9KglSBasXD4PGDhprMk375omBwPzq5Qkcuml/iVD?=
 =?us-ascii?Q?PeoAKzMJyuqqwfY1Atb4PA2TFl2qYsrDE3fRgrMIxG+xMZ76e8GJVjaGqZwS?=
 =?us-ascii?Q?pwLYE/jhc0YpOvN6IOhMdXq7EUDQLFlOj3vIlqv/29z5JVX+NkPbUQjnaPiN?=
 =?us-ascii?Q?SsFxWlHsmOWCWBMX0Ffi8N5OUCPyNwf393ThGJA4mUzvXwBLtlS2L46ytqrg?=
 =?us-ascii?Q?gI4hAlH4FrJFQlyDeI7iH47/79BYrjezbqpfyxlw8mllWpqczszoJiiGrB2q?=
 =?us-ascii?Q?cLjImNOWj9mlDBVIAyfISwzm+6qAdhuulMl5XRxs/rkJWGDm5Mv2RK0nak9M?=
 =?us-ascii?Q?LLY4lHsVsnf8QIOw7v+tibwedLSkxmVz+MoOs2uasOCh/QW0Sa1erCQZnwcy?=
 =?us-ascii?Q?RdDjSYl3j8BC6BuWvvWdsG2W6wuuX6nEhOWL4LUOaq9xxuvxloUF76r1anni?=
 =?us-ascii?Q?OvgXiHWkbb4+vkyz5Z8rOWERuTGgHSSKS7EZAnS9oapOfcnGZf+ygGqeZTO1?=
 =?us-ascii?Q?aiybxiW919v70XU8YWktvqPidwz5VsJWEW744F5SNYb44sGTPh++BeD8oKZP?=
 =?us-ascii?Q?lIkI7KojB7Imoxb4S2oxQYWX24NNKJ8OmR+CSwNmsxd/vUa2vpkNhugYzqzd?=
 =?us-ascii?Q?J+mqX1v1UkUwWQ4DdfljWZgMFxMU0oGY40Uh5IldCd82WLq9q02QJtJhdvxS?=
 =?us-ascii?Q?Sk1BRW8kRbgpxbRTkvEDfbDXT3RvvTQ+sX7nVGGe+CapEzQQo8tyi2Qy4Yn+?=
 =?us-ascii?Q?lwEDCoiObcGBzHP2uzCszBf51t+OLpJlgiwWTAHrFFNozym6sBKrFOaTC8GV?=
 =?us-ascii?Q?SxBbeJkLSbONT8Ue9ClM6DDxq75dPJxIrDLVhl4KVFuniW7RXn2DvBJrQ4Cy?=
 =?us-ascii?Q?VB/zsszokrqNYn3fl/eRniHT6PKv5+lDLhEqTMfyKnGyUbTsto1WxCCeuP1R?=
 =?us-ascii?Q?qVA0DPO7GIA6ixsKHQ9pDlkbJwV/hiE8GH3TlNLk2WJywomOomLDn5Dky7KZ?=
 =?us-ascii?Q?55pqLhwSlg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: z+V0oB5TYMmdW04uYGh3ZmAmAKcy8F4FO3W4BJ+ijfY2EAtWCIfJCbjy4g36MLXGvthSUT115t7ZV1rlgpVl/zAnb/+yD1SiWQnqPv4+pYH2UsW/OMyrDnXKHw3SSOMk8pqX0iGyergvBZYQbqlB+/n5/L3S7x14HQqJUnsQt1gj/0TF6FUhJ4/4s4PjXIf9ldEXCA46Zt70YnmvDjZKFIuRBYYdkC4YwKXIgtfYkgCDCEBrzg0oumiugeSbusksry2ZJ0inaloA4vUK0J8gXZntqy/zfeXxnTVTTrU5iScqrbeN4v8infpESXZMvX3B9GW3d0GPom6H7E5VxjMK2w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7dbe9c-2b5f-4e1b-4a55-08df3bb67299
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 03:31:30.2595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OM5HWS2vwJoAQdkdaLXlxt183GG+YcGAiy8rwkfLDNK56inyP1H7x3ko0R1kHobV8o7DAek8NKaXRfPN+LIwN7g62cuWWDAhN1zvBztbXPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5073
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Junjie

> Subject: Re: [PATCH v8 10/18] docs/system/devices/usb: Note the automatic
> hub change
>=20
> Hi Jamin,
>=20
> On Mon, Nov 02, 2026 at 09:22:17AM +0000, Jamin Lin wrote:
> > +A machine type older than 11.2 plugs a virtual USB hub into the last

It should be updated to 11.3.

> > +free port, so that more devices fit. A newer one does not, and a
> > +device that finds no free port fails.
>=20
> With the series going into 12.0 this becomes "older than 12.0".
>=20
> It would also help to say how to get a hub back. piix3-usb-uhci has two p=
orts, so
> -usb with usb-kbd, usb-mouse and usb-tablet already fails on the newest
> machine type (pc-i440fx-11.2 on v8). Either of these fixes it here:
>=20
>   -device usb-hub                     (ahead of the other devices)
>   -global piix3-usb-uhci.auto-hub=3Don
>=20
> Junjie

Thanks for the review and suggestion. Will add.

Jamin

