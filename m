Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B04606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Yt/YOjOU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgI0-0008VH-Ik; Tue, 10 Nov 2026 02:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHz-0008Tk-6o; Tue, 10 Nov 2026 02:29:07 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHx-0005V4-6L; Tue, 10 Nov 2026 02:29:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYG8uLzKR+HgjCPXPkvpv+FYDpVboauYbj0FztOZbKybK32i7UreBpk81HvgBOmNOMn9NpzLba+aZW/l3MTFwWUTBPzB37T8L71KTM5X/FHnrMO8YffPr5UOuWOJnOX/0apRMscnEj1dASNJkUbYBTkpyjgk+iKYipEAf4p1YvrawZvPx8qc3duZufw3Pu4hqSdrEBhKk9Jif/+zw+fJvi7zFpvW3quQM77r5QZKL0vOr87Bsg+eGvv5Zkz6TpO37iGZbLs9j8VWGuWg8TGeKXhnhVHdpm+EZ6XN0fOsZI/jM8kONdQeojzB5H3sMzxHsQLQFnWFUM3HhKhPMu5yjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg45rE5Fv/8zDeUqregjqnARFOUhZm2eQwslZzh4+OI=;
 b=kdWYTp5EuEH0E3j3ukxzbbRxafnCpCuLnQ4Ve9su3P5htfd7PINiVCUTYGY0Q6ORqDm0AOc1Nrdgb7TsR2B2WADZHdeNnGkTAdn1Xb+5LqzDHzDmxaGdkithC32xoMYcpHMukhr75SA7I/8xJBfzoViol0uCZMbTaWN9KIJKhufD3ZbITLE2Hc6e/wGBPGpQQ7a29Htq5VsGLcrilpRYfHaCczjaaQPqAk/L2sSsGmAekNyK7J2Ko9M3Ph4KVS+M/CQTaDNE0j3/3DIDiYM75XWaEgewkXImMVDEwh6Qg/y6SpT6mt2J9gr0C6n/9vxscW12IEQm2ixIWYMOLb6tRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg45rE5Fv/8zDeUqregjqnARFOUhZm2eQwslZzh4+OI=;
 b=Yt/YOjOU965RVUuBZJp35do20BKyLfSbxNdm8hLtiNSz8T/zB6YcigdA60UFv5lf124wc/AtiqpKPHKnMhz6gxWngRw/LIptal6nPyNY3x+mFTD7p1FkL2hK7obZ7OKeF6WMKJ4HIxTD8tIR3ziIHdGVjI2NyY5qQoDWa4e3xmXfGzXZ8soOsrIEP5xzHDyuIZrWH8yJITjo/x1Zc6R6/bIStDqD979Kbb+0eWRq9zYP1kTuS0QV08pfl47AIQ5cMqxt/U9Aftc6tqEKpu1SXHLZlNLkMXpWnnfBaLH6AElbBuXifbFpKDqBxLoEO57+hED2lWocup6xchF6Tt44Sw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:35 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "berrange@redhat.com" <berrange@redhat.com>, "junjie.cao@linux.dev"
 <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "clg@kaod.org"
 <clg@kaod.org>, "junjie.cao@intel.com" <junjie.cao@intel.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
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
Subject: [PATCH v9 11/19] hw/usb/redirect-server: Add a usbredir server device
Thread-Topic: [PATCH v9 11/19] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdcOUYTRME7cBQg0KG/NgOkVu3tA==
Date: Tue, 10 Nov 2026 07:28:35 +0000
Message-ID: <20261110072818.2883349-12-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8987:EE_
x-ms-office365-filtering-correlation-id: a3ef45e1-3a28-4607-b38e-08df3efc3b32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|3023799007|921020|38070700021|5023799004|56012099006|261102123227099003|261102130727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003|260925021911599003|260925021311599003|260925022911599003;
x-microsoft-antispam-message-info: Qh1U6OZ2J+GYWr+etnQ6mN91A1xYriIgdlGOSWABbC2W66Hkjt07rvetYQOIoRCQjiZf52vemaiwJ3PfO6zE+YF8EOF9sSbJkwYOtf2X1Bq3NYDAD7vPdtvqB1zbUvMSpgNg/ScDCSfulkMy159eJMAbFj007Zk60O3sksITNZW10HCO80scuxgvsmDYEu65xJrSWOGPEN6lxwxfImCEBu5hzxe57Hht6b0rN8TQGMfU3u31RcrY0JIclTr6lM15yczIz/qPIx0VU12ABu8ChZAZt+JdIjqxhyfWpVcWAmau00o3TxBGkUsLEsFt0OdjLm0Gcv71YodJ0C3coFoFVruo7nLFg5G+q3pxubT72bams667rLqVdWRoQLs8h7UueQXkEATlExsq4xDC5Q0gxEAASf7mQH1Va+7PZJGh1nHgDQkFt+U8d6YPUsW/lWCopxdUuwMYgTMvU9IeNM7ic97oat4fl4rxCeM6SJHI+x7oXuCVbEBojCDMDBFT9TiX02mRBwuyU7WdzdDIFO9C40laKdtdkfC5mSXRYENuM9wW15llj7MKoKIdeZKmdzUgwKziAB1DR6q/Wt2plZCFEpO4rfH7bdFU6qAN+WGvXFwECEOBPk9b9tGt0PgIk69ny1IxPJ94F36eumfVXoNG6EQZj7RPShqq2spvBqgk9yrr5oW71Jc8brhAuJC4tSpzI8mAOEjymq2+8dbeqVNoab1Ar2DvlILPLOA8h04zmEONIjVo8f6vqbQTS+KIwxCj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(3023799007)(921020)(38070700021)(5023799004)(56012099006)(261102123227099003)(261102130727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(260925021911599003)(260925021311599003)(260925022911599003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fOi7YDgmHYaorBmYpCgGSsTozZIbWVVrV404u7tLwsJQkUApfBpvjMBwTy?=
 =?iso-8859-1?Q?2Bi6o0JcADPJwX/4KDqoreug92jue50LzttbWf/ABtILvzVaabFKAx8MlT?=
 =?iso-8859-1?Q?mb3OwIzgBkojsqXHmYZoLQ8hnaQjmlZd6wYhD/1wUYLPzlZ8GjFKWho5Qx?=
 =?iso-8859-1?Q?qQLnuZTmFSphDGnMbul7APUICUY0DU0LQvZpiUHzpYTxkbJkCGuiXyR99n?=
 =?iso-8859-1?Q?EGKEqyPbazt1bQCYPb3bgulUaXpi3+ykysHs3hgMnhYkEr/Lb5zoZ7YZBM?=
 =?iso-8859-1?Q?m43cUXE0r0dPU5JaJt2o3CTJ1sf8oRdxJfunfFSSwS76Plzn748ILxM5ql?=
 =?iso-8859-1?Q?Y8DMFZiRtpt39+vCt8i2rJwGLV3+J3WSr57Nept3fB7btoT8hX3lqSYqAz?=
 =?iso-8859-1?Q?ZtS6doIpcnVhbNr8AiapnTXpczVCo0YYN9NNemZ5yiEt9K7bTZnc5DVkFS?=
 =?iso-8859-1?Q?nSzGCLYSowOqGeA5vqVvRx2Yz3RJUzJ3G9Ge7Nx4C1mWjnvP/ot7T2B9Y8?=
 =?iso-8859-1?Q?cVGdtEVnkTeNJH9R179Hv+r1W4AnNNfm9hQoWk2wL6rv7iVVYKiFj/aV18?=
 =?iso-8859-1?Q?+UyEbTsNl1zxb1ZU2URcEpAeu3eZNsbcDaLwz3pQuRTjelu7hlVPmSwUu/?=
 =?iso-8859-1?Q?z+tQgc23+tKJxoso8jYBAgDY54ICU/wG+AOdtvlpuD+/c6gGtN0l/9KXLZ?=
 =?iso-8859-1?Q?4j12kdr6ZSfGMcXiH4VxcCAsFC3UF9iWl0rrYQhlI0t2GnodXJpwsmYzQt?=
 =?iso-8859-1?Q?xOZ/EfTmE3xSL+szy1TjU66CSe+r1df4OCBcjP8drhROZ3ORVOt0Ao7Ijw?=
 =?iso-8859-1?Q?qX2dTb2QHuB9CjAA4V3LBnkhsllIob2OWQ5KwSPGdX3cP4qzlwySIDK7bg?=
 =?iso-8859-1?Q?6Q9YQgixLHdB+7QUWr3kbkhXNpFKNs3ofad5RX3WwPRnAnx0ZW8XJK23l1?=
 =?iso-8859-1?Q?su4PqG+9+SEO1Qs65AHjtkGlPMMbGiAelCRaudkGkPJo1hPZ/FPb3MYUMo?=
 =?iso-8859-1?Q?SaEx3J6l6nRyWwC3VZA6yKMphjENwcRYdoseZGFQYU+0PEeFcx9ek4rwNm?=
 =?iso-8859-1?Q?xCkao9E2tCR83xqEBltxqgvtgV49TXiaFKu73JgMOzbBGFI2lElPuOWF6r?=
 =?iso-8859-1?Q?DJ0z/YpXVrd6n19pBMn4kj8CbcYGkpJ1KkH9gZd7obBv5YMpA1KWMhxgLB?=
 =?iso-8859-1?Q?DdwdfYWyG3xx9ikfcgsDxpcpbpHt0dXkVfaur8cI6btC76pGYgQPyZeXrS?=
 =?iso-8859-1?Q?pz5uKP9b32iIbDabAc3YHdcwXxlhQfe+0GIiln+N7/CIKow/itgYIyxruI?=
 =?iso-8859-1?Q?/vFQpnM35ZTsmAPY2a441pnYcEbPhvkKoLQowCoYMdUB7t12t593WoqiJU?=
 =?iso-8859-1?Q?gR2ErqVztOtAV40fxIB7DebWwRFR8Y34fok0oedtXdp26PM01n/H5GGCSy?=
 =?iso-8859-1?Q?GLJhq+0/LteOgrYW3lsONxoUEqCLKKwneflX3TKzk8BDoqvCFW1BGAkqcf?=
 =?iso-8859-1?Q?tm2YqXqdAsfHtRo8E5qsz1DmDzNcq3MuWfcF4E+AX88F4omfaCNEe6uD1f?=
 =?iso-8859-1?Q?BOGzHvB34bInNkV6mL8a2xRT14FpxXthRrnlCvNHQ0m/w1qBJj4rYsW7b/?=
 =?iso-8859-1?Q?fAjGeXJ9+Oz2kTkn3GVmijE/vmA16eeOue4aZiBZt5/aQzlCBxpJYToPiU?=
 =?iso-8859-1?Q?fJkuT1/FYQ+L7kv/o/mqSsAGrntMSLkfYHCJDSIGJvY8LjI18PTkkPyd2D?=
 =?iso-8859-1?Q?K/pjWh4/jsYsSD8PXAqaJLDzm4C0m9o3TFQKNlONHKkSjlFNCk/GjHehV1?=
 =?iso-8859-1?Q?bwrhA4RjmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nXh0Yf7DQ6h12PfTL69cUr/im0WOjPF0IK5tc1pORNIS6jWz9nIuhNINnAM1DI1kFY1vAXICgGuE1JV+OuOmcshO3aFtm63aVSY5chvOqjr2E1oqo2BfjGJ82q9fpFPKpsMj8t6dIytWo2C4VSmofBjfm0VI4ivumRIX92M30g1IIwX/uJyi78iq0TX+Y6Be7M8v+6CGXxoQde7/qsfYKo3CG1HN3ssYB4ZyQksxvKYnaq+0TprN7MCMwoS9Pt3TmV83YyXq3tjSH326kl5KyFSNnKsjl7WAOE2bPKtRXIqxHMCFJU3BcdDQad3mqQvBaU5H3wlYJIsNihyRlC9F9A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ef45e1-3a28-4607-b38e-08df3efc3b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:35.5441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVBWWqQKaqxwjRP7ocuIXoeT/4Ax+qR2z2xBQmsb7tTr2UdyxJuJ/QxY8e81oZ0z+Wx+KJXHEiNHsqVPD8vlg0LsmC7CH6MghMZGy5M9EWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8987
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add "x-usb-redir-server". It exports a USB device from this QEMU to a=0A=
USB host in another QEMU, using the usbredir protocol. The other side is=0A=
the existing "usb-redir" device.=0A=
=0A=
The name has an "x-" prefix because the device is experimental. It has=0A=
to sit on the sysbus so that qdev can find the USB bus it provides, and=0A=
that may change later, so the name is not fixed yet.=0A=
=0A=
The exported device is plugged in with "-device <dev>,bus=3D<id>.0". So we=
=0A=
have to provide a USB bus. To find that bus, qdev starts at the main=0A=
system bus and walks down the tree. A device that is not on a bus is not=0A=
in the tree, so the bus it provides cannot be found. We have to sit on=0A=
the main system bus. That makes this a sysbus device, even though it has=0A=
no MMIO and no IRQ.=0A=
=0A=
usbredir carries one device, not a bus. A hub cannot be exported because=0A=
the protocol has no device address field, so only the device on the=0A=
first port is redirected. To export several devices, run one=0A=
x-usb-redir-server per device, each with its own chardev.=0A=
=0A=
The link to the remote host is a chardev, so this device cannot be=0A=
migrated. Its VMStateDescription says so with unmigratable.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Tested-by: Junjie Cao <junjie.cao@linux.dev>=0A=
---=0A=
 hw/usb/redirect-server.c | 143 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |   3 +-=0A=
 2 files changed, 145 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
new file mode 100644=0A=
index 0000000000..1423564d22=0A=
--- /dev/null=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -0,0 +1,143 @@=0A=
+/*=0A=
+ * USB redirector, server side=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * Exports a locally emulated USB device to a remote USB host over the=0A=
+ * usbredir protocol, so a device emulated in one QEMU instance can be=0A=
+ * enumerated by a host controller emulated in another one.=0A=
+ *=0A=
+ * Architecture. The left column is a request going to the device. The=0A=
+ * right column is the answer coming back. The middle hop carries=0A=
+ * usbredir messages over a socket. The top and bottom hops carry=0A=
+ * USBPackets inside QEMU.=0A=
+ *=0A=
+ *     remote QEMU: guest driver -> EHCI/XHCI=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     "usb-redir" (the client)=0A=
+ *              |                     ^=0A=
+ *     usbredir |   chardev socket    | usbredir=0A=
+ *              v                     |=0A=
+ *     x-usb-redir-server (the server, this file)=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     any USBDevice, "-device <dev>,bus=3D<id>.0"=0A=
+ *=0A=
+ * "usb-redir" (hw/usb/redirect.c) is the client:=0A=
+ *   - it takes a USBPacket from the remote guest and writes it to the=0A=
+ *     socket as a usbredir message=0A=
+ *   - it reads the answer from the socket and completes the USBPacket=0A=
+ *=0A=
+ * This file is the server. It does the same thing, but backwards:=0A=
+ *   - it reads a usbredir message from the socket and runs it as a=0A=
+ *     USBPacket on the bus below=0A=
+ *   - it takes the result of that USBPacket and writes it back to the=0A=
+ *     same socket as a usbredir message, for the client to read=0A=
+ *=0A=
+ * A USB device has to sit on a USB bus, and in QEMU a USB bus is always=
=0A=
+ * made by a host controller. So this file makes one and acts as the=0A=
+ * host controller on this side. It models no real chip: its cable is=0A=
+ * the chardev socket. The real host is in the other QEMU.=0A=
+ *=0A=
+ * usbredir carries one device, not a bus. A hub cannot be exported:=0A=
+ * the protocol has no device address field. To export several devices,=0A=
+ * run one x-usb-redir-server per device, each with its own chardev.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "hw/usb/usb.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
+=0A=
+struct USBRedirServer {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    /* USB bus */=0A=
+    USBBus bus;=0A=
+    USBPort port;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB port ops=0A=
+ */=0A=
+=0A=
+static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
+{=0A=
+    /* We only export the device on our own port. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_wakeup(USBPort *port)=0A=
+{=0A=
+    /* We do not pass remote wakeup to the host. Nothing to do. */=0A=
+}=0A=
+=0A=
+static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .child_detach =3D usbredir_server_port_child_detach,=0A=
+    .wakeup =3D usbredir_server_port_wakeup,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB bus ops=0A=
+ */=0A=
+=0A=
+static USBBusOps usbredir_server_bus_ops =3D {=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Device registration=0A=
+ */=0A=
+=0A=
+static void usbredir_server_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    /* One port: usbredir carries a single device. */=0A=
+    usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
+    s->bus.auto_hub =3D false;=0A=
+    usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
+                      USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
+                      USB_SPEED_MASK_HIGH);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The link to the remote host is a chardev, and we cannot migrate=0A=
+ * that. So this device cannot be migrated either.=0A=
+ */=0A=
+static const VMStateDescription vmstate_usbredir_server =3D {=0A=
+    .name =3D TYPE_USB_REDIR_SERVER,=0A=
+    .unmigratable =3D 1,=0A=
+};=0A=
+=0A=
+static void usbredir_server_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "USB Redirection Server";=0A=
+    dc->realize =3D usbredir_server_realize;=0A=
+    dc->vmsd =3D &vmstate_usbredir_server;=0A=
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+}=0A=
+=0A=
+static const TypeInfo usbredir_server_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_USB_REDIR_SERVER,=0A=
+        .parent =3D TYPE_DYNAMIC_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(USBRedirServer),=0A=
+        .class_init =3D usbredir_server_class_init,=0A=
+    },=0A=
+};=0A=
+module_obj(TYPE_USB_REDIR_SERVER);=0A=
+module_kconfig(USB);=0A=
+=0A=
+DEFINE_TYPES(usbredir_server_types)=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index 429dcd6a24..0061b935e6 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -78,7 +78,8 @@ endif=0A=
 if usbredir.found()=0A=
   usbredir_ss =3D ss.source_set()=0A=
   usbredir_ss.add(when: 'CONFIG_USB',=0A=
-                  if_true: [usbredir, files('redirect.c', 'quirks.c')])=0A=
+                  if_true: [usbredir, files('redirect.c', 'quirks.c',=0A=
+                                            'redirect-server.c')])=0A=
   hw_usb_modules +=3D {'redirect': usbredir_ss}=0A=
 endif=0A=
 =0A=
-- =0A=
2.43.0=0A=

