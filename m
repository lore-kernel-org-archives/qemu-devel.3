Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF74E78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNO6-0004ht-UV; Mon, 09 Feb 2026 04:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO5-0004gb-5Z; Mon, 09 Feb 2026 04:16:57 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO3-0007H3-JS; Mon, 09 Feb 2026 04:16:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7Zh4ySopUvl8Rw8++wXZHAwg7H31atspiRjEj5LQybi2UJNFs0VpWkwb5cWSFK5/TWyGchAHVdm08dGcP+t++hpfoiKeczTef5O9pLiEp20zzC6xYuu2c8G/5nn+Y8gHbb08erh9h7LGWaS7A4+kxmNsinsgu2HduTgKEPb+7hqAUrXyLF7kwzQs1H9xLSPJlL9G3Na3C8UfASHO69fdAsIk0GQZYQsiMN9cnN1yboUThSixH0OUOnOWmjQalT9M532lvAUtr0bJ9gUbL+2SP3f76sa/HV/6UK9nJA8LiEovKD4PbEmjtun/7gc5uD4YHqsQeASCKMNQ6z2DDViCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOcj/GexpxQj1gX2Csv7uHNnmx2m3Mow99xN0cwY86o=;
 b=DEw8VhiZf5lKyEsRFxYxR+/s6DdL9DaWA96BCNYQNIIAy5NVnxYAgoD6eRnO/HulS+teyt8o1l79PUKe+0MgJ4s2iS1NZMkIXOpyaOa4vdnlHRnT/CeAtT+j8Hhs1yFncIhdoPyzBTn7EC+uk9+nJ443yJDOGJGI84of+MX8zrUWUHdLAvRxSvz3XsnS8odteOp0r4z7zAJ8DoNRLYSX7V6em3dAbyQO7TJ++s7L2SYdyQkX+TkUFd1w6P7R5ERkVpK8Z+FI4qwp2kHr3o8aCApE5QKz0woejz84bCv5mVhQFferBjz6W+ihyJVEEQXoWreD6zYF4LMXYhrzRoIzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOcj/GexpxQj1gX2Csv7uHNnmx2m3Mow99xN0cwY86o=;
 b=N8vHmLSQcZqcdSlQwUrQZ0JrmbRb8CEIHEZy2li/CSIvNm5+qvcQV+SOgNM6pPtlAsAUflyXx8Dhix0hPJMuS7w9wyPFNqJ3Tou4Q6GmpWl9YEZMgomYTE72kvT6b4iwnXWKBCg4ehir1uaqwH1j5Gfdus+tDujKq2WlrHfoUswN4NT535FGyfKV3qUGrFxCXA4MbS9K3P1r/U3JIcj1H2Rgdud0ZoysWqyEPoWf65Gl8cVWK8t4q7brFDIrs/mk7Yq9zWTuA+SJUX6SAdQISrmfAyqSq6x+8p8kBiEQnUy82ycyO/qYAO03zZFEiWp4N43gTeiD0g4XCFgCYgmvkQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:47 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>, Hao Wu <wuhaotsh@google.com>
Subject: [PATCH v4 11/20] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Topic: [PATCH v4 11/20] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Index: AQHcmaTQu6jnDSd1dku/E3KyUD/D3g==
Date: Mon, 9 Feb 2026 09:16:46 +0000
Message-ID: <20260209091629.823457-12-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5784:EE_
x-ms-office365-filtering-correlation-id: f1944c68-0a66-415d-1e41-08de67bbf327
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UpmDrGrc3HmLRgsmELQTlV4xHEpY48gWhS++6IIT6YN5JCnTKSIH6MN3b2?=
 =?iso-8859-1?Q?JISOSoyZqSV5Z/WQUFXTgJzpmpLIGCrdw7qFCeBT1WRzW7JVQWPpR/BK+k?=
 =?iso-8859-1?Q?OQv/dje6EdMmTqPqrLB0YrIKie6cQgSONCkCnts14SymRwi3LbdYxdPXAe?=
 =?iso-8859-1?Q?7B/Yn9qI1TahJcZoWMNXPmOMGPHxCYTn/bhNvOlCicA4r69Y6ABiZ1zTC1?=
 =?iso-8859-1?Q?ZASmFWtOMRCj5L6oXxqhfp/tWMTMW/+LrjQ+RVcmbOcJ7ldoedQGBIChID?=
 =?iso-8859-1?Q?pRS5gbRo7oAiwLsFyPMwM0URtmqQV2DzygpigJjFVqyPPjZGnhCVafz1E6?=
 =?iso-8859-1?Q?pcNlV77Dhk2BY/SWJldwHz7AFDk0kLltScs8wW40S7SxxS3j1TiOsr8oor?=
 =?iso-8859-1?Q?wr4LZ/6K8OCkrTwEP52ePkp2dB0B8tEMyGHFET5ryEs0/JXZHGp7CsF8Yz?=
 =?iso-8859-1?Q?QPr1pHfXBINdlmPTdoqI1xCnGE9K4mh8XirY1xToN8GyTLCTQtGlkG6VcL?=
 =?iso-8859-1?Q?kR6a6snX2t7V+aO1zoTxeUtQHQU2b9QMdOkwEvjKfKuUIv2lh9f+o0UKMo?=
 =?iso-8859-1?Q?AgpCM9JZHivgqNXPxaLA2xzjNvV3RGDmapVQuT+yVmQGLEzwqGvg3yqXb2?=
 =?iso-8859-1?Q?ZNpHaTMH+jdH6XtRkKbSuXA4QGd7ETRz6KBdZbn35tPymA4TmQ/QTxDBaK?=
 =?iso-8859-1?Q?2ezcR0lzjQ36EoNQ9urBbm5QqQoR6lLNYxDOenjZx79Oxg3kI4qpuKsPwr?=
 =?iso-8859-1?Q?rsz4QAi7gi7GFSnOX6LAWMu5DeTle8vM97jleXUU8RJ5OPQum2ursernij?=
 =?iso-8859-1?Q?8BDyF8CNNed/E81koDe+vNKfHqs8HpsCcoY3+wnikQFSPKNwuFEiO2qshH?=
 =?iso-8859-1?Q?/Xn/JYLr+LUkwhgOHeK7qeBeRmUQuYEalbErI1j/Op6I9iZMyGPKxI/GRu?=
 =?iso-8859-1?Q?wlYDnaEX9CjQTvJlYDSTcJevM6QOipbviueiSZ9CzaNKK6WtXDbJfEPK/K?=
 =?iso-8859-1?Q?vX9cyDyBYradybq99RFU+WcWqqW1ap0vgtWMZebZUn1cuXNkALzwqlloUk?=
 =?iso-8859-1?Q?T87hxUid+KLpiNlFrHccH51b/vWda53aiKfcyF8s8WvWTXKkjqjuXTn7ZO?=
 =?iso-8859-1?Q?mIaY83cJC0ztGBBe3Cw9NwSyFkwSapRFVvkpdK7wBWhNx1Y6JiK8mql1Gx?=
 =?iso-8859-1?Q?q56dm+ptk4IPmb/it/5/vXe44mLUZaUr3mz1VSNmGcaP/DPTSqm/X2DIyU?=
 =?iso-8859-1?Q?e4Nu8JA+IcHnGoXV27DQoq9ulj2JELfN9p9OGdg64ht/uk9sWFNwktabyg?=
 =?iso-8859-1?Q?/LKk+jB7bkVHS7WCUh2C9w7eIBx8oTfzYi3qOUR+7M2pMoNM1usYTEyydB?=
 =?iso-8859-1?Q?sjjTgWuOWm/zSPPZGyTxt7bOZ9HcoGyXhTinAMzJ7bEaspA92wvGiaFp0/?=
 =?iso-8859-1?Q?SVobGgx/h5X8tHybqqZl5j+WTJXYPN+jWlDYoFW81l2PybdX+EEG87YP2V?=
 =?iso-8859-1?Q?LC62ombZUDJkyjMhpIC9bnqO2z8QRAxK0ZPvl44AenCX44t6Fu1ZJ3QbE0?=
 =?iso-8859-1?Q?VpwzN0J6YpWwlJgc7N3mqS734+FivAlIr6OFwwI3CECzxvQ/5EyedP9/iU?=
 =?iso-8859-1?Q?f/XhymEXdVexzmmvaqBWVNlWIAjFo/T34NF8xalSvhVYVIRa6yxOy8xq+Z?=
 =?iso-8859-1?Q?GaTWp0UQlTolYt5Z4bbm4qv710D5Cry29SttCsRH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J2vuy2hlRTNqQWlGSJ1rXRC0j/wm2G+DN3SFgrQG1+eObYhGujM1q8KA6g?=
 =?iso-8859-1?Q?fuVl956aNF3rlQozmuoPezQeGX8I0/1oDQDGGmYQmT6BPmXi4Wjp0fQORr?=
 =?iso-8859-1?Q?VEFubRf9DUrcWN2HkfNKPwLL+fbkPbdZZbS3A1sWtJ8V421jyqc3eWSkOQ?=
 =?iso-8859-1?Q?FtsDRub0K1Q9ytFrdBCCiPvh5KDrNNSvKftU9JSmn5nnihW0vYRBA14L3B?=
 =?iso-8859-1?Q?pzHqrTnQicKr7c+0chD04qQKpbYCnEmdnbdrX7i597Gymq88gyTkHtZQ6q?=
 =?iso-8859-1?Q?R2T5/X8iIioPEq4UD5YUFITRqGNdnSzol3Ba6FA03rAbkmYwn5s0oqBS5g?=
 =?iso-8859-1?Q?hbXCsSBwm0mYZtmm808UnUlpC2RzkTloWEg/Ms+H5UM3bCzGANgfU/0rq+?=
 =?iso-8859-1?Q?1Qu8eVJ2p82do9uX6tMkbVCobNlaAW0OtRTo6QhN9ZSYsiwj3x9xmb1Bkb?=
 =?iso-8859-1?Q?M063XE62zVEoMAFzQp/7k33MBm4in67fW2+v2y6Zxr6zs9S8cOQbEjo0wN?=
 =?iso-8859-1?Q?o/LybtK3DIQl52A5vs/YbI3Z8t9ro4zLxwT37JskaYDigGVxGeqGT4ijLn?=
 =?iso-8859-1?Q?+dE3Cscxu9p0FGAc5yMg7XFpc1gIjkxD67/ObSh8z7z0LzRk71MNRRlhbd?=
 =?iso-8859-1?Q?v8eWDwHn3+HMVKIMhTrsdTl4/WFgs0EuOYgnH21EOcOgJ6KhbbqHXld+Ff?=
 =?iso-8859-1?Q?tIKk8G1TBN+SA8ESBX4RaMJzW3+aMe1OsdiEED26UmNQKhkhJO1/hOQ5Ew?=
 =?iso-8859-1?Q?7NQ9l9ljN2NRAcyy6q4RVkgPKYl7j23DZH0NKCvk3MmELIf7dfZm3HNe+l?=
 =?iso-8859-1?Q?rmM8+XPIVCrxwwcw2bZDjwSsN40CZmybzzQMr7K5tOQYX+RpfjpUfb0Ek3?=
 =?iso-8859-1?Q?0SZwndEqdoE9BsBQCx+mEYhmmICA3rhC+G7RThP62a3fgAHB05IW7/h+3W?=
 =?iso-8859-1?Q?t03bL4qVUWDhFpPfKyHpd3q6/nQhA7xOH9OnpY+yP/IUxuOmXtX0FEihNs?=
 =?iso-8859-1?Q?HXF1FNtmWvun8A9ZR+ksqNSFGDjXLuzbScHHtxefFXDFuR00BXKD7HVgsX?=
 =?iso-8859-1?Q?Lu2xgML7ge/NPfndUzQGPDjH0KhHtUr8KG9mnWd1ikI+cGxbX0JifAj0VQ?=
 =?iso-8859-1?Q?HYdJG4c7m1XPzdMljYw+GZdyQCzeOO6Gk5K8bkbh3wmEwGgXGNIOu5u0Qf?=
 =?iso-8859-1?Q?80UuMO18kc+ZqVb0QJgH4bSJgQOKPqEpbTKoEGjkptYzPhKPw6s4dqOEC0?=
 =?iso-8859-1?Q?drs2yp0Jv0Iy4TWgYqxFhbnn4A21RFQpYzurulpad62fBC0ddt7rraD1zH?=
 =?iso-8859-1?Q?ME9kxDns2lu1DDw03i6A2Uo2DODLBeyq8t9+8gTimXmGruTWANg52zK0IC?=
 =?iso-8859-1?Q?aovohpYHfKUvb6VeX4cWMGtcJv1FCQSq4+V3mHj7JFTIE0ep1s1w6QobuF?=
 =?iso-8859-1?Q?M5pge+ZevrRIcQ5VBK/pZJEw0YL5R5bGUpWq7O+l3voIR6hWs4+t7NACOU?=
 =?iso-8859-1?Q?zE5PzBVsMChCorDBc+k6aWaJfHR92sZUgS3jpdbO6l4L7eoXR1tpqwy9iT?=
 =?iso-8859-1?Q?GReRzIvlEcfm6legbj5j74XiL2pGiWT8UxYT54I1JXRec39I4/LS6K+OFA?=
 =?iso-8859-1?Q?H2o46okSQvr6//L7HT0YXu0eASaFnQRcmGzojc4NYUp7i3xiD1p6A0c5/7?=
 =?iso-8859-1?Q?cMGjruVP2g0G7MpsfFjFEqEa6keHeQvtjgISGcmQq+chVHooF1wLwb/7AK?=
 =?iso-8859-1?Q?s4t8V87IlJefpKAqEgA+p5UW3J8RIcXT8ogCRq8Om3kvsRFA0DZ81ioykc?=
 =?iso-8859-1?Q?U3vmznm3Vw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1944c68-0a66-415d-1e41-08de67bbf327
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:46.8207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjJeDCSTEjIVk4kfO9myybkZ57XNdF98v5U37jh2R8SKAwPoeWYW66idDJgjWuH6GEvSklf+xyZy+lWYBjNTLwCasluud1bvfUZ91SnVG/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
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

Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Hao Wu <wuhaotsh@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 56 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 9dc71aa3d8..bda8ab5d51 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -17,6 +17,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "trace.h"=0A=
+#include "hw/core/irq.h"=0A=
 =0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
@@ -335,6 +336,46 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_update_irq(DWI3C *s)=0A=
+{=0A=
+    bool level =3D !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);=
=0A=
+    qemu_set_irq(s->irq, level);=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
+{=0A=
+    /* Only return the status whose corresponding EN bits are set. */=0A=
+    return s->regs[R_INTR_STATUS] & s->regs[R_INTR_STATUS_EN];=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_STATUS[13:5] is w1c, other bits are RO. */=0A=
+    val &=3D 0x3fe0;=0A=
+    s->regs[R_INTR_STATUS] &=3D ~val;=0A=
+=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_STATUS_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_signal_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_SIGNAL_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_FORCE is WO, just set the corresponding INTR_STATUS bits. */=
=0A=
+    s->regs[R_INTR_STATUS] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -348,6 +389,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset=
, unsigned size)=0A=
     case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        value =3D dw_i3c_intr_status_r(s);=0A=
+        break;=0A=
     default:=0A=
         value =3D s->regs[addr];=0A=
         break;=0A=
@@ -392,6 +436,18 @@ static void dw_i3c_write(void *opaque, hwaddr offset, =
uint64_t value,=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        dw_i3c_intr_status_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_STATUS_EN:=0A=
+        dw_i3c_intr_status_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_SIGNAL_EN:=0A=
+        dw_i3c_intr_signal_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_FORCE:=0A=
+        dw_i3c_intr_force_w(s, val32);=0A=
+        break;=0A=
     default:=0A=
         s->regs[addr] =3D val32;=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

