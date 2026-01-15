Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3C1D44C43
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMzD-0006V8-Fb; Thu, 15 Jan 2026 08:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vgMyf-0005ML-PH; Thu, 15 Jan 2026 08:01:30 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vgMyd-0007Hj-DA; Thu, 15 Jan 2026 08:01:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mspXsGuMDAeSujT9ymwh7tXbtSFO7muM13FcUWNxJeW394Z1H99KHHRCnTZvq06HA+Jk9Is4FEGKDamDRRF5VJLGfBcXrl7/mrirbQcs3Ca10WMBOI8Qx2nYIsUImc6q4eDCuWZg2W8bBmTw0dn4BOud5/Gh69+QGEyn5vo6+Fu8nvw3fNRajwOudHGxAAmzxY7n+qUfecdXmA0oTJ/s0tud078+hVi+4JQg1kaCCOkcd//ijF2mE0i/AZvfcns+pTeBZBKgK0SFFhvYNAz2tpMPYr0EePSBzhnrnqqR/ctt9ZMsnpfFX6VAYCqn63aCrTsIiVB82Klco2JXbwU6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXmUc27OnwvB/QZp+wYrfRkmqpgi+QRJyx2o56GZiTM=;
 b=A5ltRm7NwLcoWWdfUgtybu7Rt1WuAScPhfI1Ecjavuq0rEsrlwpWkBkLYG/spRWj2z/lhPq4ea+HbtLbD9k+CgcdP2cUsJHQP2ixFLqE/kreAxbeft73NJznY4t4VyV5M/328dYxdkVS8MG1hRdfJe2bxYDUkPKaT8pIRdMhd0hnOXCEoOCH6aFLYxI163wIK/6Ul+DkoqffpH8/+3oqg5ZDCOH6MOHlJO9BB2Pgf9K99kvXWf+3Kf94HJDOUBIA953KEBdIh2cxMCUDbAcN7an9KJa8w5SrJFMRQGOSCHBwbwFfp0sn+GlAFHVrfdMH/uLPqOPER3ag2hy7NPzwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXmUc27OnwvB/QZp+wYrfRkmqpgi+QRJyx2o56GZiTM=;
 b=MPdp/ojlBS7VWddCaQYDdYj5iT0Ou01D7C0v8gZR1VqrE/QKn7TRzaP2FSUcjB1J2hpCDFUfkq3yWAs5clNZmfHZ7ed8ziGdiVTlg0u8k3XMTJ1bNRJh0zaYADcMrqPQN7eVn+WXkJ3DWtee0Ib/BBj+Vr3bUQEQUb0gSB66j1ifwY/013KmI2Qmv1LibmR1k6gmGkbZB9ARgZmukjABxBcis/2TjOH9SFLN7CvcPMCZkdtUfDKboLqFb6MWWD2dUNtGNCB0VyLtovBQzHI1IwyjU0vDczz4d4/gWEkUXyeh2VROreTeK/eFaxO5lv4sKwaebhe+uV8ocDgsxQ9EJg==
Received: from VI1PR09MB2798.eurprd09.prod.outlook.com (2603:10a6:803:e6::13)
 by DB9PR09MB6507.eurprd09.prod.outlook.com (2603:10a6:10:304::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Thu, 15 Jan
 2026 13:01:17 +0000
Received: from VI1PR09MB2798.eurprd09.prod.outlook.com
 ([fe80::d8f:f20a:9e1a:9387]) by VI1PR09MB2798.eurprd09.prod.outlook.com
 ([fe80::d8f:f20a:9e1a:9387%7]) with mapi id 15.20.9542.001; Thu, 15 Jan 2026
 13:01:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 1/2] hw/riscv: Fix integer overflow in cm_base calculation
Thread-Topic: [PATCH v2 1/2] hw/riscv: Fix integer overflow in cm_base
 calculation
Thread-Index: AQHchh8JasMrs0BIMUaozFUFtn39LQ==
Date: Thu, 15 Jan 2026 13:01:16 +0000
Message-ID: <20260115130110.2825796-2-djordje.todorovic@htecgroup.com>
References: <20260115130110.2825796-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260115130110.2825796-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB2798:EE_|DB9PR09MB6507:EE_
x-ms-office365-filtering-correlation-id: a46f7091-8468-4584-5c15-08de54362bf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lGAJABPDnPx+XWmbEifbmyFv5kUSQXlsDO7QHmLIIRhkMVX2TFJz5knckl?=
 =?iso-8859-1?Q?t8TR+BR3iFPU/Ox4ahm06DOIxOjZV+AUxV9KYTC5+iAHiA8jvOxJr9bl7t?=
 =?iso-8859-1?Q?jv80yzinawmr+8Y/hIZR9PRqf5cNGzI9ppt288Aj4oaw4HsEEItHNYc+gu?=
 =?iso-8859-1?Q?H1gm67jhOKf0fNYyEjv4CNVjKuXkKCVFC3jU2GgVvQdz5ppFUDd33LYNJq?=
 =?iso-8859-1?Q?WdZh6xz4GfO3lbyhXBaIyQKoYyxc4shPG5uRQih3xMVuk1a7LZDjjYtzKh?=
 =?iso-8859-1?Q?cwhq42lFMzzI8bG4zJhYD1VW1CFWh4e7lsKbgJtTVnp0+aoAPOUPLXjHhB?=
 =?iso-8859-1?Q?W+nz4/P4tiBOQrNh66WNhpZhgnp9ngaSTpDW/qnOgPj2vla265+4yW2o1F?=
 =?iso-8859-1?Q?0VExVy/+ucavCg5iXOBIgVSHsMkFFEn3pUCzC9HyVB3Ptzbbcf+cU+sxPa?=
 =?iso-8859-1?Q?zdiN59RTTJLGCjVYYOPPQYCm0SyRX0k6lSEGK+b9OE/3tKrplwbgYVDOFV?=
 =?iso-8859-1?Q?Jq07PY5f8JfYyTYq6Igh8etr7/OC4oSt/Cmexfu/70z/YF9DcPh8CmuP77?=
 =?iso-8859-1?Q?2JS43reYPV4wiBPOxfQa/dZE5ghJQt72Dq1MIqxFaI9oCec6xT7iI1baUz?=
 =?iso-8859-1?Q?fj36UwLBUtWntW6z54NcGLXccaC1vYVZMgFvhGrFmV+sFvpeXYBQtzLJxt?=
 =?iso-8859-1?Q?vUlH9Lg8CwbEZ2wM5okiLX5G/oR6VT4w/vR8Yyi2EGo+uXq2KkOFhIiYgo?=
 =?iso-8859-1?Q?dIToF33eduTx3CvUYW6hnEiMb8QqCAEh11KN1Lj6b+bM4MgRl4iLMmBhdq?=
 =?iso-8859-1?Q?XUXLvqZvMjbojdh3f2WWyFrI8Q1yy1AsOAh8RxBX1Kjsm//B2cVyYAC0Xh?=
 =?iso-8859-1?Q?W7UcUcnW9jRkBIdVoIzpvvtDN6fmS/BPSTX3qTNtafbZCBIhrxSoMnJWdi?=
 =?iso-8859-1?Q?J6iP3cFv2yqE0I9udbQfx/1jaGgm/7fhuhnfY6OHVRlqeKQpCazlf5GOTe?=
 =?iso-8859-1?Q?BwYumGgwOBIU2MMVeF/Sw37j3COcwhV9AyGd1JUN32tmVlk6VNUPiS7Tiu?=
 =?iso-8859-1?Q?bf8qbc127eHBSFjIDuJhbCmXYKI7MfKx8Jqdc+SXgWFpzJkM/xD0u2U96G?=
 =?iso-8859-1?Q?6wAFQR4HPY9vp9lbZqzi33nJou1S9TbhjoLoUffCymBRE9ScRu3R0w5oJh?=
 =?iso-8859-1?Q?asodz5GY5s9al7zUgxD7v8eLFCfxNca8oqwdGG53XFZOzFL5Li9Q7eWFBH?=
 =?iso-8859-1?Q?x0v35edYVpvGytm1SZpcOrtnkqYWWWDjHp1ZidCMoUs+eJmIcTUkSLuJVR?=
 =?iso-8859-1?Q?AfnNGq76p3HsDinNQlauvG29P4ynfTDBbxqNd4AzbInhIkOT2e6cfTrXQx?=
 =?iso-8859-1?Q?Lkeb0Szg2I0FtO9xKE8nL6qNy2rqD29qW2pwp09vrQ2vvQh8HhxufwSVn0?=
 =?iso-8859-1?Q?fK2RhJodiwDojwRlCAv2E6Q/c9z9IEcilfqERujwFbWVqCZAfPb+N3gzfd?=
 =?iso-8859-1?Q?usY4Ha9+KK9M7YOS3A2I91nYMMv33hfkhiI+0h1b8dECdlosQlrN+cpP31?=
 =?iso-8859-1?Q?k+3x6uBS5BA6qOjWkeeNI8aLWuwI0AF7WNlvuzOwHL/0PWqah29M91M8XA?=
 =?iso-8859-1?Q?Xb46jTw373Yc2Ev7AnaW/Hj/CuI9GDGe6YYAn3/s95UZzernvOy4Svjy1e?=
 =?iso-8859-1?Q?5oiTlRjJ8AJ2mYuQm0I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR09MB2798.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wciz6U5PtGxqjXaV7C3ersRJfNj9iPiqgpAgm/1G1nWzYHsJ4C4gUXoiyY?=
 =?iso-8859-1?Q?LOjYDuFIUiusHeO+kvUzHqCxYEF33+PJ1n0cQrlkqznqnI3HzhfDusNVpa?=
 =?iso-8859-1?Q?kjee1HLd40KN0/h+XxKghTwqIccvMVhIczsRn47OpuuICbkpQRPJjzRAHo?=
 =?iso-8859-1?Q?QtrL9f8v1Xbpfa2d1TRgQawPx8GHbyXst/C7HaVxjTLIiyH4uRxPntpa/A?=
 =?iso-8859-1?Q?Cjn2HjSLcT0hz37XWeGDkSXup0N3JUm1XEFHcuX8JjuKcAR3UrdN3pKgqC?=
 =?iso-8859-1?Q?mqZoRM3nkYc5W4uH0ONLqhk4dvoTSueaLTFZ6CoJYaqphzaG/J9dvo8Wft?=
 =?iso-8859-1?Q?LTVEJoq5JB6dbZlu8h/yAoHEbJknuxbj0bshZgdzuOun+RXUSklBpMPizX?=
 =?iso-8859-1?Q?f1jAeOllyQoy6s9d0hM2eYokji1tQRQW/3zAcIcKm6/hCTo/mPzihqtnq8?=
 =?iso-8859-1?Q?RLds8zv2RlBy8poHcauOkN1rpEJTNWvHIVbk/TJ3VdI22eFmo/+Xm02Xu7?=
 =?iso-8859-1?Q?X7ZyVg1ajlu0ky1zvPpP36dKvEZ8YlJhaGlc3du1Ss0zI7CaLTlxqtisC2?=
 =?iso-8859-1?Q?C2vg4cMH71zQZa3L84W6Ny81hSR1rvC6mxbb6m3N0OMjHoGgySsJYirkOM?=
 =?iso-8859-1?Q?jNnpKzyuPkyTfFmfxyOi+r60GvB/f2+2mq9iogQ7Jar7o4GjbGDCtQDcMm?=
 =?iso-8859-1?Q?KnjfGKTUJ03z+JK5IkEpcZM13LzwJhqdszbBGE0mJqngO/fXxVEtRwsHQO?=
 =?iso-8859-1?Q?EUJzwQUIe6YKs64f8iV1AGc9K4T+UyVBO9ILMpvXuDOfH5FGW0bQJAcs+6?=
 =?iso-8859-1?Q?Yk6mxnGrn3t9EfJKOjAQxm9R4L4SLeTKyWycuimQJVtUwMV7uLeBhLHF6d?=
 =?iso-8859-1?Q?G6j5OOdQhFsFSIh4OJySEhB5T3tlRg7ka0U1I9dsViCfo4VbRt9enntaVc?=
 =?iso-8859-1?Q?SBrc5wpzuqP4aQb0eZzer0UQeKkiUpPRVzoEBJtVaG3JdBQbP4fjIvbIJx?=
 =?iso-8859-1?Q?vBWMuWlv0mU1NyB1Py3dtTpHQhQe3jg/wNvOxnHgKF2CpXbX65JVgqH2A5?=
 =?iso-8859-1?Q?prXmmSC1nm1wFLa6BURmfQx6hqF1u8ZZdd+UlO37kSvum+e6ZDwcJThtuP?=
 =?iso-8859-1?Q?DIKzUxVyTmUZFH8WSQILyB2PBMtsvliFBzMvUOLv5J6dPADVmNQ/ARD5Jb?=
 =?iso-8859-1?Q?d1cjDva6HWrm/wvPbZmCHPPMFNHThYsu0yNi+lCrXD8aACbUHaYsIRNMVQ?=
 =?iso-8859-1?Q?Yel9l0lacji09u6vyGsxvGGV3hvOVESjxMz20498H5nFlqZ+owMXXVzD++?=
 =?iso-8859-1?Q?dqeiIDemi8HfVOg4QHkFxLlCCSIWpqxAUgDBBZpbqJ55jwEl5YU92Fumnv?=
 =?iso-8859-1?Q?xfnbQh2XfhoMNyAAMNUcQ5vlc/Qmiyb8eJHqCj8FyL/n/GKyHXjJtmjHmv?=
 =?iso-8859-1?Q?1elIeoob6STCSd4PpW9ukGrNSglgKRXSzMaXhrsJtVkFD8Ip7m8yaRYl3o?=
 =?iso-8859-1?Q?5qaLvk429lnPTPZOqSYGkeX+lLIEGTabwEjBzIBjHURxXJHtjb6IRLGyvQ?=
 =?iso-8859-1?Q?XTVBNDRgxXdajcV9Y8v6L/0BFow7ns/e4SWYNMFEQa2UsEaH4avI4bJdnu?=
 =?iso-8859-1?Q?fH4eynRLlK67MKaT3fY2C2BVMbbHgWxYY2RyIiQ2jHkihiPzET2d+WLkSX?=
 =?iso-8859-1?Q?G9XO1S4rV5bWf9hVDkpSt9wf951kNkFu8htgUTdsKm2RS1Ck1uv+YK3EF5?=
 =?iso-8859-1?Q?3M23ikXQkJHwMTBSEz9GloZvRajGNl7fx3K75Bi8cuZOchubJglqXTpneC?=
 =?iso-8859-1?Q?bKv2gt/OvmKO05BiDRRmZ1x+BfbFtcXKfzB/KgAlUL3JNGiKOkxp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB2798.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46f7091-8468-4584-5c15-08de54362bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 13:01:16.8454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJXFR+scq+pSECHbC2bdLdCY2zrbNNYqKT4EEgcgA4D0VT2DxPKDyrn66SCzNCqjpeRgMu+xy6Tv6hIwSJu/vGO5MxWUUqygQFM8I+n7ljI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6507
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Ensure 64-bit arithmetic is used when computing cm_base,
avoiding potential integer overflow.

Resolves: Coverity CID 1644076

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 include/hw/riscv/cps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
index f33fd7ac86..39029bca8f 100644
--- a/include/hw/riscv/cps.h
+++ b/include/hw/riscv/cps.h
@@ -27,7 +27,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
 /* The global CM base for the boston-aia model. */
 #define GLOBAL_CM_BASE 0x16100000
 /* The CM block is 512 KiB. */
-#define CM_SIZE (1 << 19)
+#define CM_SIZE (1ULL << 19)
=20
 /*
  * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
--=20
2.34.1

