Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129A8CFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 05:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNlaX-0006aP-E0; Tue, 25 Nov 2025 00:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vNlaV-0006Y4-FK
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 00:27:39 -0500
Received: from mail-francecentralazon11013067.outbound.protection.outlook.com
 ([40.107.162.67] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vNlaT-00034d-DO
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 00:27:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqtpylMVa7cU7SnQqGUMcllLMr7GYN6FPm2XU6PTBE8+arNuHxSKgoy/RMARxcxqxcF46DhsA/p9HZGd8jwoQlI1nLBHvCxtThZzuLiTjPCaYpBAZ9i95JfIaWTNDLDhikNYwwSxDhuUS3/tPxk/WkVR9/tyqHaPi/1eTPVJ/Xntley6u8uzRiLdJojT2gDXAr6kpIXu+SGfzzHyioAnMRqdk0MLi/RZ+kKREeMAGKj9fJ8qtHJj2zi+iAdNdIhf2CeG8LkF+eMMt8BpCEfZB8F5RL1maKqqA/jHYTywh2wQo7BBNXKBC+wrHsDDF6VyrsgAgFm5Rl1nGuBU4jRo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAtVrxFf8HNNZeyoDvrRmOs9PNnjcmwDZqNy5EYZSO8=;
 b=kFF6n4J/tjW4wWm5Yrg0+UKAbYab+gQqNTxuRnQd4DsyoCBRD02BlxbjGZTz38id+hZ8+AWAUkj6IX0ksSSPzJjaMVV6ErjNiMkRr3co2YtjaZBZ9zpAInjapUb3dxH/bO6hE3W0WkgvabUmVrT03Lg/LwjoiZDxkg1fPJe+3jmAGgb6dRIrCHmjTalNJz0b4m3emUwHHjs3wj/PxQi/gTgazrewW6wW6KLflqzTBKMUDlEDF9LOXhxH3t3DuX9ssERTjXLvGSitb39hbEQ9znqOzvVxuDxBLYrihNdP1YNz+aID0CpfvO8MpFNCFFH832saPjzZbleNGhy8BaMW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAtVrxFf8HNNZeyoDvrRmOs9PNnjcmwDZqNy5EYZSO8=;
 b=Wwh/IJKoYEGW+YVbt5VmE/e5+eg+AYLWMdFXdrOoGyssjFu5AX+ga4v6PbS4Gu1KA2YBBdQcXP5ws//fPpBMS+xhETrIxYQvisBu0hrWYu5RYZT4/6bJWi96QHM4YQarIc112jBeg1cw4T1LiZJ+J2A5O6P5jDz1M+3TuGBlEvEBJ54qfbG0myRF69qc/johP5aNCwFvqzbY2STfxKtUiPs6ewjbMobsQFEiSM8X/ue0jSWKVbs4TjDw9+dp4Oj2kAwO0phcSnpXzbv2nP6WJcYsBHP7t2Te7u6I4OLn+4XSU9wLhcPMa9lYHwpAb1GREM4uIuw+5k1gAXr8+4jtBg==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 05:22:28 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 05:22:28 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCHv3 00/13] Adding comprehensive support for i.MX8MM EVK board
Thread-Topic: [PATCHv3 00/13] Adding comprehensive support for i.MX8MM EVK
 board
Thread-Index: AQHcWVR8XMZOm6lZIkWllt/IB1o56LUC5D4g
Date: Tue, 25 Nov 2025 05:22:28 +0000
Message-ID: <AM9PR04MB8487540421160BCD438CFDA987D1A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|AM7PR04MB6981:EE_
x-ms-office365-filtering-correlation-id: 03965cdc-6474-441e-5e4f-08de2be2a04a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PbVqw1q0qdTqY0DZbEoa9l2YYbfP0T+hv1H4wlAgKY54LkInFtN8QRIEk+EL?=
 =?us-ascii?Q?3U98Bg6PQdyPx9ntNrYUqKdFqrkFFBH52YPdmwD+fPczrLy4Z3qNU8YlIbXy?=
 =?us-ascii?Q?vdUzYOsPwSzWfvoSYspYyaOhSJyfOc3Y8WKTdPPkxuRosI/YTE7ea7CW+sEW?=
 =?us-ascii?Q?G2XIZzYaGMJ2nrBgV9dBlw4Y4o3HMLwn9tfx6IZpYNZT66/QwOuzChnh3qh0?=
 =?us-ascii?Q?PXQC7cFb9HQZZUYwl4ZwEK3AUqd2UMZ/9CtJE8SYptSMbkvS6vluKSl821CX?=
 =?us-ascii?Q?e+lioor0L5vfQeX7vETJAk2vmS26NB7wr5DfQRdbQslPj3UfJYCptIxDbF5M?=
 =?us-ascii?Q?1Baz1PpbTUF1dJl9S3c/4Z+cRiCqe5+6BhfUkpPDHB8DcsAN5d+udF2/RPvt?=
 =?us-ascii?Q?2H73OXDFFs3iHho0ItGY+RCJH7khqu6rRSCOpGTJ4CVHdqh9xgX+BdWuU7zP?=
 =?us-ascii?Q?iscJP6nuD3t//fuQ0TdFbAqfUg+5JSkz447M5pdPW57qEtejSMQDgoLWfvOi?=
 =?us-ascii?Q?7p1uR8SWmcdLhYH42RP9SL6QCcEIPUL6mD6c7bg1489gzjyrDbX4FE0cqq+C?=
 =?us-ascii?Q?W5Ee4j6eTGD+C5b3ljnHEHJe27z9q1d6Pf86mJcVlUgkGQh4npL0XuXrgK6D?=
 =?us-ascii?Q?nGdi/C+Jp67IvpIlJ3hlavAaYfEc2rg7XNeZD6wPAMQPb/zYuFrITezlNo8i?=
 =?us-ascii?Q?OoZ6PKLnMIEwSkB4TWRgJG6Ps1ubU96tgv7K17WKTvt//PXXcP32X+uQobsk?=
 =?us-ascii?Q?yIAtkBDVG9ObDo0zOInTEiF+XxLisA3DpLp19Q+D8lzo4ewXy4y4gB3+PZIo?=
 =?us-ascii?Q?tGRGtVjn5NqnSXUJ8AL1U5nKIQl3FRrVrh2NH+cbG3efsqhyAaR8Jm2TpJ30?=
 =?us-ascii?Q?MMeO6xsZFn0ATeteLnKCE4syRkoKXtxPy1Ehze4lKkFLZ9HrrJzyWTCPPamk?=
 =?us-ascii?Q?aN6GmyUaFpsz6o/zgPRYeBT/oTpwH8TkqOdrnRo7NKf9pPpDlkvvSRA3PTMy?=
 =?us-ascii?Q?WGsImpsJDGjidc/frPGTOvU15Rw3t5UDNTks8TZg4SzGeSzI7NkXWao2LjTz?=
 =?us-ascii?Q?kkdCeMrXuvsLzsR3nqOzJ/dgfqALC+Em46W2I5w0OW1Rys8tyovVyhotM4Fr?=
 =?us-ascii?Q?g+DuByy8TP1ktzlAY136TVezCdAoPmHiwFRZpLCULN3C3e4UvbGomUWroC6U?=
 =?us-ascii?Q?bhfdM5y0kAF61WoLS5pRbFvjNNgyCeH7ioTtBdluZTYOoLBF2gsT5sTUHNcI?=
 =?us-ascii?Q?P7eAnGcgxtb3xKpAqcDnqJQ515sYAs69IrBob4kwNVHV3gB1aKaN2ZAu6Srt?=
 =?us-ascii?Q?2G7mbDI8XRk7VSr63F0L3QgUP1xjnqvwGVOtPOO8iYae8pJFOIu1Qp3TsQxX?=
 =?us-ascii?Q?X2k9aanJ/eRtOpPIzwcbBgrZd/q6ogUhbFsZUIQnzLfOi8QjqaXsz+LpGXzD?=
 =?us-ascii?Q?KBxycLj00oEnQTz/elDNZHk+7oLbz0L5LNgyoMMmFPPw9dfLhFzZSBeh2zXL?=
 =?us-ascii?Q?oqkotfoL0WY8poQISHw/uHUk/K6GEsGkEDba?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LOMKm/euFGI7+7sV1NB0SLHXqWQRV3mK8CovFtN2pO6tkCzFnh2K2LvVWKrv?=
 =?us-ascii?Q?fnPwC5NHSABGnjeQm2zUmKdile/dh9JCvcdtBtjfjJFSaLF/RbIxZO3YnkaT?=
 =?us-ascii?Q?3kg6LuEatUwn3MASlSDpCPTi2yxPWghcZyEoMNuB30FrufVZii1RcXekMq2I?=
 =?us-ascii?Q?dK6s0PKCRKxUfGQGnyNqKlEfJZe30EuJwmVVrbL7JdPZxEi9T060dnEJHVWK?=
 =?us-ascii?Q?BxXicLk+qPr3YbGBjvPsCXLtjr9cLzDdhVoVTEJ8Zh37wHltfv+PwYQIN2/Z?=
 =?us-ascii?Q?y1IuMBgXnq67pXB7hl2Zhar360sCecie2tpJpEyqK5FehUyQczCS2HMhiRvF?=
 =?us-ascii?Q?AM+8dL2ydcDkkpDBkW2i2qT+XCE8AF/wGeDITR1t5QmBAcxpVXzqXJ7rSDbs?=
 =?us-ascii?Q?t7lG94wFlh/ePYC6rgxb6JqTm4fr9gH7F78y/AyZGHWjyANPvOvPNi4dw3qg?=
 =?us-ascii?Q?XtTh7D8DO8JpCD9ED/CdffFBubNbboizKeU2IF/xa3oXS7ek9ZqlxYK1ZvCJ?=
 =?us-ascii?Q?kq8pHMjmfVtcPwm3EP+vWdzVe6ne6f5G6vvvoSIwUHH8BKAX902tc5blmUYq?=
 =?us-ascii?Q?h74M6kCKvt/UlCP9QhGjbDqi3xSfNsIYRiHutMz51VDLNZ+ZI11Nny9taOd3?=
 =?us-ascii?Q?Hqb9kcg6NchKqCwTilOp0mVipVhudNN6IEe20sZ9WuMQVy1wy0x1LECBMOnG?=
 =?us-ascii?Q?McGzDXx3kNAZ+XBKDaEPteLE2Z7OG7pRn/OB/QpsnCOqxu706YsoAoWLo6Oe?=
 =?us-ascii?Q?s4CrcDLBUdXHUsSXPVXGGa3khOnsdbYRbOqYgb2wZPbwTWIyYw8WuwkbeThM?=
 =?us-ascii?Q?GxgIQnQ2YsmsP1v/ka5jOBjHHAmxHkjnrYIgDlIbZWJaSihB4ye9H3EJ9/eI?=
 =?us-ascii?Q?HWBkn48UqKNyxgaIOpKqrpDJTIzdcDOakruzfAY2fR4A2TbI3XdbOJ03taQE?=
 =?us-ascii?Q?c8NkW/cDVTdRfBgK96uAJAx/kvvZ/jwJ174FmTI+vw/RHA0vw4fSzM/hcStE?=
 =?us-ascii?Q?Y9W4JH+gUnKeukn7+F61u3wKgnHlvgacdKRRxGBAt1rMwJYnZ+FnZ0pYiF8w?=
 =?us-ascii?Q?r1U/0OFOyZvi4lJtpX6fTS+ch5oib0o1J1vxtlWvZU0mruIrfxN3xH/AlCJa?=
 =?us-ascii?Q?SwqmwBwvqYlRxeVhMTX9BFi1KRi43l7kRrssx004OB10Fjwa/eqPN5QoCssN?=
 =?us-ascii?Q?QQplwPWLQAUxkjkVSO1WeW1dpHXGe4aQmjF1VEjBdCQ4gKLYKDVtTWg/iZnb?=
 =?us-ascii?Q?ia7DGfdvV2RAhlml/gK9J0Kqk2BwZQqb4vF5WeNJNf3WfQJfN5XKGjkD9WXa?=
 =?us-ascii?Q?2lz+ZtvTdwY7Qd78vhWZ7N8e+GoJS2o4X7+QGO6ok5Ut+Ire8is5cZ0FwXJZ?=
 =?us-ascii?Q?CNsS2r3/Qbw0kb2De1J2tl/NtjdZUgDHhf7Xr14f70VmRCrn+LFdVWm0QNMy?=
 =?us-ascii?Q?l28TOWlGarmZVZffUzxXWVACcB2LRvahBRYd8JIUppTHcvb01GDZZ5BgIxvy?=
 =?us-ascii?Q?hq6NXiweEVTSAUiigDQ0j+XK5ixC1rTs04XPNWuF7I5B6oDpQIJ7ZspkNdV/?=
 =?us-ascii?Q?FSm//yBH0Oj+KHUPCuCmlSj3fViFJWS+/oveDnva?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03965cdc-6474-441e-5e4f-08de2be2a04a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 05:22:28.4447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: na3I2UKujBbMQdu2CsoQCDi35xXFZ5446WCXxm74gC9HFjeE1vhyPyKRYON7jPQwkbAdMQ2pWeYTOfWrov+XkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981
Received-SPF: pass client-ip=40.107.162.67;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ping

-----Original Message-----
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>=20
Sent: 19 November 2025 18:30
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com; peter.maydell@linaro.org; Gaurav Sharma <gaurav.sh=
arma_7@nxp.com>
Subject: [PATCHv3 00/13] Adding comprehensive support for i.MX8MM EVK board

Changes in v3:
- Minor documentation change - Added KVM Acceleration section in docs/syste=
m/arm/imx8mm-evk.rst
=20
Changes in v2:
- Fixed the DTB offset in functional testing script test_imx8mm_evk.py
  and preserved alphabetical order of machine names in tests/functional/aar=
ch64/meson.build
- Fixed a typo and updated the documentation
- Modified structures type to static const in fsl-imx8mm.c wherever
  applicable.
- Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk.c. This
  is needed because the default DTB in the iMX LF BSP images have CSI
  and DSI enabled. Developers/Hobbyists using these BSP images will
  observe CSI and DSI crash logs on the console since these are unimplement=
ed.
  With this change, both debian and iMX LF images will boot up without any =
issues.

Changes in v1:

This patch series adds support for the NXP i.MX8MM EVK (Evaluation Kit) boa=
rd to QEMU, enabling emulation of this ARM Cortex-A53 based development pla=
tform.

The series includes:

1. Core peripheral support (CCM clock controller, Analog module) 2. GPT(Gen=
eral Purpose Timer) and WDT(Watchdog Timer) Emulation support 3. GPIO,I2C,S=
PI,USDHC and USB Emulation support 4. PCIe and ENET Controller Emulation su=
pport 5. Documentation and functional test included

Key features ported:
- Basic boot support with Linux
- UART console for serial communication
- Interrupt handling
- Clock and power management infrastructure

Testing:
- Linux kernel boots to console

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Gaurav Sharma (13):
  hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
  hw/arm/fsl-imx8mm: Implemented CCM(Clock Control Module) and Analog IP
  hw/arm/fsl-imx8mm: Implemented support for SNVS
  hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
  hw/arm/fsl-imx8mm: Add PCIe support
  hw/arm/fsl-imx8mm: Add GPIO controllers
  hw/arm/fsl-imx8mm: Adding support for I2C emulation
  hw/arm/fsl-imx8mm: Adding support for SPI controller
  hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
  hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
  hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
  hw/arm/fsl-imx8mm: Adding support for USB controller
  hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation

 docs/system/arm/imx8mm-evk.rst              |  79 +++
 docs/system/target-arm.rst                  |   1 +
 hw/arm/Kconfig                              |  24 +
 hw/arm/fsl-imx8mm.c                         | 687 ++++++++++++++++++++
 hw/arm/imx8mm-evk.c                         | 127 ++++
 hw/arm/meson.build                          |   2 +
 hw/misc/Kconfig                             |   6 +
 hw/misc/imx8mm_analog.c                     | 160 +++++
 hw/misc/imx8mm_ccm.c                        | 175 +++++
 hw/misc/meson.build                         |   2 +
 hw/timer/imx_gpt.c                          |  26 +
 include/hw/arm/fsl-imx8mm.h                 | 240 +++++++
 include/hw/misc/imx8mm_analog.h             |  81 +++
 include/hw/misc/imx8mm_ccm.h                |  30 +
 include/hw/timer/imx_gpt.h                  |   2 +
 tests/functional/aarch64/meson.build        |   2 +
 tests/functional/aarch64/test_imx8mm_evk.py |  67 ++
 17 files changed, 1711 insertions(+)
 create mode 100644 docs/system/arm/imx8mm-evk.rst  create mode 100644 hw/a=
rm/fsl-imx8mm.c  create mode 100644 hw/arm/imx8mm-evk.c  create mode 100644=
 hw/misc/imx8mm_analog.c  create mode 100644 hw/misc/imx8mm_ccm.c  create m=
ode 100644 include/hw/arm/fsl-imx8mm.h  create mode 100644 include/hw/misc/=
imx8mm_analog.h  create mode 100644 include/hw/misc/imx8mm_ccm.h  create mo=
de 100755 tests/functional/aarch64/test_imx8mm_evk.py

--
2.34.1


