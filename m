Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF2606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=iNv/6b0V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGE-0007WU-9f; Mon, 02 Nov 2026 04:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFK-0007LE-KD; Mon, 02 Nov 2026 04:22:33 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFJ-0000W7-32; Mon, 02 Nov 2026 04:22:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjx/b7ZkOY7jcsUD3VMnC1vAhlhOrp6gdKSdJmZ4sdfCKGL0Bh3f4sCtbwCo9BaVpZdNu40I3a/lUS3YXlrBMJJzqIFZj+uAUL8Of6Ln08tg5kW0V8vkZwKDJrhW0i576d4SdZKv0txDnPjGnGyCLc2pV/DqFhhmjlzlFZvhSIqiHfCOR+hVFTlMRVn4omH8P2IMiUUZVPN4K66iyKxbGibkUL+4snj/Cd/Kcc+sA3EifGlh3WwJcu3UdaVFQ1U9tgTPySOUtwTz9ur1scCaehZuZavIlG1tTx1xFBWSUXi9TmVFUI2W93EieLJ5r5a77e1LXc7/OrzQyLeL6h7A0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX9Bu5iUcluzz1IwNbqqdX2x3rrq6ZvYTGoWFsJ0rB8=;
 b=TtGzs64+llQOq3kH/z243omwQv6jzfFpTUvcLBOckwN3AhrqHqwOfM2S5VsX1IKC/Luy5FowII5Yo4LpkzQvSLuookHxDDALOYY9khI7EsSQVAAwqxZ7rzeUAUHNbMdYFTQ7y0nLzXHYGOM0/RVLQJ3SItD/1rQ1pemIX82FNKU4N0vMD8duuuDWPFiNjhcYNDlJr87/mYRS+lHTl9yzyNYwHEmORGzNkdZHV600CyvsSDMp/GFnSlUCaWNjrF8khYIcdcEOmfQoi6tieVCwViM6pRa590qDyFKn77s9YRi8nfCmSb4d0yET/F+4ss8f3JGelPQD53s7GgZi6zCGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX9Bu5iUcluzz1IwNbqqdX2x3rrq6ZvYTGoWFsJ0rB8=;
 b=iNv/6b0VSTbzyUmjbhSALDOvOEzbmIx+DhiQXTlqtbv54wXCrOW717+tZf4bvUzc1/fhIaH60inpBQMKC7Zwc4tHSfXFFaaMJR0S3eXRBAlhf75n3PMUK2GRaBZK4+I7yMhXNu1da2Vgif8dfLEMfX/gvNCeAHGHrfyiMJW6wBRKUIAXvS8Piie4D8WJH6NsssHyBCdUNgIzapuOPVprxFm4z686gvc2FIJghjCnnm/vaDR7mIUAEOHxE5jjg+uJh37l98EnR70UP5xZH5eLwyU+Urxcw+TDsqyKYGnZ8ZwBOYdUqRNThncXlS83E4slx/qqCo6HrmK/ILdQq+ZjNA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5265.apcprd06.prod.outlook.com (2603:1096:4:1e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:06 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdaqugzonZbCOsyEq5GblPuZWDag==
Date: Mon, 2 Nov 2026 09:22:05 +0000
Message-ID: <20261102092201.1729245-3-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5265:EE_
x-ms-office365-filtering-correlation-id: 2d6ec937-2625-4464-37ab-08df38c2c325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|921020|38070700021|56012099006|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info: kRWFjeDMcxv0jMuXmpMHLnnynSRQWnTws00M51ITlck2EWF9Lko6aW/QfbyWCwBIsA9MB3qq0HjTmfCojNRXWGrVbBOqeI1GPap0QslNIhPO05yyu6Dnlsr3V/ZQUyCVVjxKOk5p7EZ8KE7p081G8ydcEGeqA0l/GZP0Tg/1hXwEPxbVlQzwTVDNXQKAEpLd/scdvQvKPes5dQEgdtn2fV/qxtba0Tdj8HP0vLMdfffPEzs25hsP8ItaOBK8dZ5+scxxWqEyKDkO7CE/fTNtl/Wjy+XDPl/UvjL6xuJ+lUuHYgfqP1qJKT9ZWNEDevW4EOnJMnjZI2rjch93M8lfW4U8BQkfNCFzTOVSxuucvwxwWeCPnmi60NSnDeEO+SOio0vfmXaQANCg/QiP90VQ3MleXp2XQecwVTms507WQeK+MFQbLR2wBvHBlXlPt88f2b1JpJvICk0lHNyr3S+XmEGuc41T1IGjZRuNO5nLIqCzgBrtQrJktdlNuWft5MK1tq1Vr5osjBipYPjxDzBQ56+LfY9YmcZJBOkh1SFPFnSG8pZVFB9XFa6zYPS52XN+l9PdqlDibZBgOWpJQP2sgJLuE+pWk7UOB2VAvqFWf6DcQ2GztjnXLq+v87AaixQToAbDJ3MQ2PnSy8H+rUv0CrR2nnZtopCxKrTwiB3bqCYQKsWeML9nzXqGSjVwlFsbJSc1XMZ+SHzIwdyjNF5ZNH6wD7Tlm5YHgjlFI0aox/smTAxLRzXnyB8bzgvLX0aA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(921020)(38070700021)(56012099006)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cWkPFXBUrn2VTilTuRkTdk/l5GqnSrmMDTMP6bvGn+REAq9JS+70oygBn9?=
 =?iso-8859-1?Q?qUz23QCIrcruU9n28LNOGI2Tqf4Qgicui8nNGIO25bGYNngcvpufTFqX1D?=
 =?iso-8859-1?Q?cjSYSb8rSpKOKVRHj/DobdQJpGA9Rsu7f9TAuqDWHSt0AUFaIXTVIAXuaf?=
 =?iso-8859-1?Q?/IiSc3JE2niqzlQ3+xlDgt9BUjDOKgXFxLVEt3S1HncbeH/jGC5ToU86Ht?=
 =?iso-8859-1?Q?9g6gEOT+noGg70yTFKGc4vE88U/I+A0r7x/SM5PISXiuPrO1qfDlXWSYet?=
 =?iso-8859-1?Q?pgJWl/SVkbJehjrTnwB+VPOSnUDmNxJuQwU+RbxeFIM4jVioRJo9zadON6?=
 =?iso-8859-1?Q?TCwwEawzTBnojVbf2wj9NjXSmXKlp2xazvKsowifaZScEWaRLeBM8AgOgY?=
 =?iso-8859-1?Q?l/wwWB2OFqUZrP5nRnPBrzHEkJQ/gRkIZukS9gPgb6AEpsyPHZPN0T7eMz?=
 =?iso-8859-1?Q?/bcxipBLPEwQv8oRHDiAU4tqUpl49q2G550WEUPgKPidVvMY3jfaA6wyro?=
 =?iso-8859-1?Q?db30nrHCVbOPygNlaWzBI0imiiBgC0LdikQV2jHSsDunAfU0LuoRM1yPRo?=
 =?iso-8859-1?Q?psKKCZyG0iYmGcehlF/teM6VVWSNWvDKPu2q2wqwG2Taw1zIajJE2PfSfY?=
 =?iso-8859-1?Q?yGZGeCiKTrCr3mqn46sGQRZxewBddlpBTvY6xL42aFe76uvATMGVS38E9m?=
 =?iso-8859-1?Q?lE4/bnMXBU9o7EtCcoaIvSWrTJhGALN/bXYqbq/gZPVmVG1CpWq0VVSg0L?=
 =?iso-8859-1?Q?nEDbj5tkRnb1G/tymnQ7C6hFuTJEYQQk5KWVnXLrq3v7eTA8m0G5Qf6qdn?=
 =?iso-8859-1?Q?vfZEceNhelsplDu6qr7FPftvLEYeE5Gr1xaITMoVfQIKm8O91/3NXovMJX?=
 =?iso-8859-1?Q?0616VDtQjWAUIoBBTyJ2OomgjhLceQqEi83WT6CKXN722AFQXh8TXKH4hd?=
 =?iso-8859-1?Q?LmWFNQzsdGnZJb/9iAFKIbzC51Ck8Gcwz6J+G0GQQWOAUkqgsjgzdvQCbu?=
 =?iso-8859-1?Q?dKAufrnsce261v7z8RZvxvU3A8OChvsDz9nJbi1Hrgqdj1MoIyyAk9Zb0J?=
 =?iso-8859-1?Q?6MJZmETch8qN3kgrZhoHxAglvjtHhWQiu+/4hwwb7TEinSkJvkOB3fFFtv?=
 =?iso-8859-1?Q?WBZ6H2KDsA5z5WxLmZrQY7tV1lVdMg/HN730PCfRM35A1S2oL4dvelm5xl?=
 =?iso-8859-1?Q?4eptTWOCsz1+iehrul9mpxsusoD/UV1MoTAY7m/qduOUUC1kwRFQpE3Nuw?=
 =?iso-8859-1?Q?md6AD0EpTdRsBZZTwjkPOlcizOJsnEdnxdtXRH+N+3XCwpPv+3dBvQKEHO?=
 =?iso-8859-1?Q?IJA6ZUjnUHFLYYDUbJudGVZy3GRWfxB5EOvf9XqC+G0wlRMFVp2dD6MuRn?=
 =?iso-8859-1?Q?UxYhiA1yZhKMhfoZBjQgZiquq3F4x3eO87NX2/2m1/FcNU7TpNJ02Auky9?=
 =?iso-8859-1?Q?5IMqJV+kpgqTDCic7N+1fqnn9lNhDFxi/wl5XyDrCwziKSen+WlAIfez1+?=
 =?iso-8859-1?Q?O81h4Dp+ZbneiUduWIBLx20N6djHx/R+veh0M+u8Ayy6ucu5bSyfWzsWeT?=
 =?iso-8859-1?Q?lv4pZWLXERukiEO4VsYbtM5leD2j8/IF/sKQfUr/gAXcVNTF1YnGUzdn9V?=
 =?iso-8859-1?Q?c52qk4MohvVQCMGku14mwFuKpZV3j54rmPNz+kHnWMEoEoI7rcoDDPKtS3?=
 =?iso-8859-1?Q?w3tTR2IzlG7OnDgEuVm9QJeTiXwpVMtpt0AVxPbmHSNSOO8j4dpCwKpOSH?=
 =?iso-8859-1?Q?mB1y8TDs87srTK4Ttk/qI6ha2OC7MP4i1h5TUk69H058dBnvzGIul2G26w?=
 =?iso-8859-1?Q?esrMSBZiVA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: p3IQ89Atc4rbIhOmeCBHoKP+gIaHDMzpiaCyLFMZdstyqT0e/hanFh+GYU/506CGx/xMkpWerNAg+0voiee0q4uJQtXJha12Ai0LbsCcrNBDtKDnqWYHQzt0iIjy3aDdm9HLh/lfrInzbcgKGX5UW1hAR8VpLaGkEDhY3XL7ozLB/UezCON8Q8p91JUe6RrCCZBDpvxCg8FZaoeGRnss+xkSLEVw4SX+eCA8cmWQBxjpa8U05XJl1SP7FGeVl9nRNblSNqUESwoLmavcSEqhi0x79P41Ivm44ZVFkCs69aiXqWE6uVWsCr14ScunefKhI5jFZUkaUwZra3bGN4sBOQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6ec937-2625-4464-37ab-08df38c2c325
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:05.8411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dh2SfPW7gBFu02TycU1M7fnbrY0nn+Y1egDAWfjagvjbTGQw9sRSRcpJ3W8RNZEKo/Hag/Lwd3MAMZ+cRHiJBwAGPKQEtq1QijBMb/VCa8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5265
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xHCI has up to 15 root ports and does not need a hub to fit more=0A=
devices.=0A=
=0A=
Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older=0A=
machine type keeps the hub it has today and a guest saved by an older=0A=
QEMU still loads.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Reported-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-xhci.h | 1 +=0A=
 hw/core/machine.c | 1 +=0A=
 hw/usb/hcd-xhci.c | 2 ++=0A=
 3 files changed, 4 insertions(+)=0A=
=0A=
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h=0A=
index 5cb9e06d1d..a3eaf2ebb6 100644=0A=
--- a/hw/usb/hcd-xhci.h=0A=
+++ b/hw/usb/hcd-xhci.h=0A=
@@ -191,6 +191,7 @@ typedef struct XHCIState {=0A=
     uint32_t numslots;=0A=
     uint32_t flags;=0A=
     uint32_t max_pstreams_mask;=0A=
+    bool auto_hub;=0A=
     void (*intr_update)(XHCIState *s, int n, bool enable);=0A=
     bool (*intr_raise)(XHCIState *s, int n, bool level);=0A=
     /*=0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index d9ac4b419a..f8f5b01117 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -43,6 +43,7 @@=0A=
 GlobalProperty hw_compat_11_1[] =3D {=0A=
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+    { "base-xhci", "auto-hub", "on" },=0A=
 };=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
 =0A=
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c=0A=
index 376bc00264..1e42c851b4 100644=0A=
--- a/hw/usb/hcd-xhci.c=0A=
+++ b/hw/usb/hcd-xhci.c=0A=
@@ -3377,6 +3377,7 @@ static void usb_xhci_init(XHCIState *xhci)=0A=
     xhci->numports =3D xhci->numports_2 + xhci->numports_3;=0A=
 =0A=
     usb_bus_new(&xhci->bus, sizeof(xhci->bus), &xhci_bus_ops, xhci->hostOp=
aque);=0A=
+    xhci->bus.auto_hub =3D xhci->auto_hub;=0A=
 =0A=
     for (i =3D 0; i < usbports; i++) {=0A=
         speedmask =3D 0;=0A=
@@ -3660,6 +3661,7 @@ static const Property xhci_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),=0A=
     DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,=0A=
                      DeviceState *),=0A=
+    DEFINE_PROP_BOOL("auto-hub", XHCIState, auto_hub, false),=0A=
 };=0A=
 =0A=
 static void xhci_class_init(ObjectClass *klass, const void *data)=0A=
-- =0A=
2.43.0=0A=

