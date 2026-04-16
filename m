Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB27F433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsQ-0008KQ-Ev; Wed, 15 Apr 2026 21:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsI-0008FK-B2; Wed, 15 Apr 2026 21:50:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsG-0007PV-Fo; Wed, 15 Apr 2026 21:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLiVQDyWBfO9nx4RK7qyvgFGKMcqEuUrGj7mASBU6DTrd2RWK/GLOezm/iRsaQ5n4ktLj1a3B4fFvm3edQvfeax6O6lqf+N2IAVc61Jk3gcNHY7TzMr3f4pzWfABR+4tly+KlH3xo0LNO/RvGQ5Su47+vtWQbtdZmlsvsacL1k0FYN2tiJT+H9XbfdbSccNBiYgts/rBnzkOM6vxHpdrQ/L175UlVPXVcdkToD2sRs/jnQwb0oHvWG587pDydipfwNOYq5dSLE56kBszQXFN3CfmSRfa2DAGFc6vyNLkz3QHb4S4J1LpVYW5bYDua4anini8mEL/m7gytq+w7+Zz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoUhykF/17cyowRf70s1nnRW+st+OCBueNdAEXL1Mwc=;
 b=y0ScjqY5WpnYfRLMiHEgkSge3DOdxLgM0Uu/+k2nmml/43ntZM91IzyzzndMY9kGSYRpRzXUbBc/37q7C3rm4UTi3kJ4Tfey8gDSBPVOXuYf5p1mtENfwqwvoVcMi78b8xM+3QxUTD8H0qDcIAmarJQKDOiTDQ9YWLAQF61TGd3AcsiHVGTYGLVr0siC9nHUh/XGZvSnoOStcl+y2M13uJiSaFVZW0V0NUt321gQUvJWVYPKAfcBFdeMe+YTGvuQ/ZPHW6m1kd1v8Vl219hqZuxQBgG1YnUoOKfwaQVCSot0TiO/ztU95IBTZnwMfvrJRq9Ll9j6iD27ENCyZ5atCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoUhykF/17cyowRf70s1nnRW+st+OCBueNdAEXL1Mwc=;
 b=J1zhgU9K0TIJje+2aUpbmEI8Chghki9QCB5N6xMBj56Dt0il8CHK04CJ9VRBpgLseQyrGZdkYyPfrhNc96YMo+04WpULL6qxWig8kA0F3gW28eZV5oUOaqPoy3NUaFxDHWGnw6JscKEQTD7EMUM2VsauDKXooDXKMyy7gJraUEPnB6ku9af/b6yu1hEP+mjvflCC45E5YqCVNKPUICzrDfg8/uzpD3xwakCIDIrAdtwZR9qIMRXuqSw2c5NbnX4tH5HA6i4iCHRxNhGO/qt4YBElA2LNIoAuqsb/xN5TQnKwcpUJ1qPicUDYq8qtHQKWWpgtC8hmfJEgwzlc7sHnUA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:58 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Topic: [PATCH v3 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Index: AQHczUNUCGCAr2wNUUqlxwuOt/36Cg==
Date: Thu, 16 Apr 2026 01:49:58 +0000
Message-ID: <20260416014928.1279360-14-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: 0fcf4f3f-075e-4649-47ea-08de9b5a775e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: t0rwNfrDaW0pyxseu334sHrvcXbJYPboKBXbQmsEUGECWkgOWr1KWlnOsMzAKzJmTVNjb/4HCAmcK5DhxFWUlZqVzzCNerxLfxEOFj3cM7nAl2ApIJovSFLI2bzKeFa9cpEUeCY1vLv0klHQyucoLGaJA5z0VIWG0+L6l2cSy9ZpHAceJHv7SKRVYUc0vUHd/HaJg8iyjEY6P4wPiGlES8y7msZY5qzsGF2hlLspl1lRVTEtQug51j4zqcqzHj/+u6IDLwPCHbLTLck1zg1kHOGt8QUJ3MLQnlbCage92wm+diNGXD6FonxR3ZEVQu7QCRrMTo115XZPiZRohGaeDOH6ySpv2ykyrr8qjk8hUq5/6UvDqaknSVljDbu3p1U4imYSERR+NPe93IRvJZII39Rr0UcMK4ShH2JiefIHuLe9o6CxkwGIEyGCWy3Jil4DX1xRh16O1y0n1qVTwVUCoEQqIChDKELUGJ22JGXy/5GFOQJVxaGkuRlBNayK9QIGGtliyQ0QcxEYO4fxOjtVz7L9NjGLTLlQUnjJkYe/S0jG2cUUgVKkFXlcYBBAEF4yXP5P5SehOsNWY3CBZgjZe0Eo9XwAZ9vKO1v3AAiT0G3VXhlnaSuulLTyuAmmeU14nlFJSRMcmyx32+CHCS3fv2p2s3HlQfpbQNzld+Zc7ZYnMdnneddOKhyMeM3H4lS9OLO9VjhL5ZXHTGxwzvGaeKoSklGkXMKlMmyg2AjG9i29KlQOK3ZfSkcuLL4A0aZorffINxrrZDfe+EbF0ho075S4ICga7jQ9FqJOzFKuDFx7dXRHt14BmT9xgcic9D6j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2FQBaGRSrA22gCkPlAXFK6BxE1EylyGh8oeRQBixvRCMPT1cTJNbuw6RhT?=
 =?iso-8859-1?Q?JPrmezj+O/T3gLO2/hhDcSgrtZlU5fh6q4pzeQHIqUl5CebTPfenURzQC2?=
 =?iso-8859-1?Q?XcuRgchH9GTTGIpDaOKa6WvF7kHsQ7364s4qOcrN7wYeCHy+ChsAOrnYm7?=
 =?iso-8859-1?Q?V956DP9LYz1UzYayoIte97va1XkBWd/zKO4IKLHKFzbsXIR6zzXF+saAAk?=
 =?iso-8859-1?Q?u2wM4nmkrGPiMLpCPpp8zdtebOfak5MG72TDUL9zM5/MHQ8b8NkjdPo0hZ?=
 =?iso-8859-1?Q?qB9Yv1rVbIFvymL5lU0YEZO48sGhNsnTwjq6LYpOK10iCMrKPy0fOdlMCy?=
 =?iso-8859-1?Q?zMLOu7uFO1ANXmFoad7yLypnoXaobkZo0mllIpuHL/Ob9eduLsRALOCS3a?=
 =?iso-8859-1?Q?2D6re4Ocm4oZb3Jwch8njOcl84TPRhH3FH0TZdzjo6sDMwwYt4DM4AAI/x?=
 =?iso-8859-1?Q?mSW0PLDVEnmospqTvCVYjT20ezxJT+j+w7aXFRy9tvxaLEdO7Q43FMxVBH?=
 =?iso-8859-1?Q?ecYKCh/fYl8kKX7qUugrEBil4KXy3oFJ1JvYM6PnjXenBDD5RTLalAeXF1?=
 =?iso-8859-1?Q?vvOhfu0vvDsGZmAg5+UP7NURFfaQAILqSKomlTeyhzO/6fHcMeER9y6SEJ?=
 =?iso-8859-1?Q?/t2EQPoKHCM5Cu4yk5W3hPz1Snjd+S8VbZRoGRRKfx/8ycxwsdQXpvvaay?=
 =?iso-8859-1?Q?jBoOiPQUN0e5sgh7X5LOwtBHc6Y9x3pHu7X13UUcRFe3+YCH20Jf+9Bxck?=
 =?iso-8859-1?Q?1qbR48HLy/NcMC4Hui6fZOalAu4n//ppSKqt5mTo5Zm4SuULz3xWClywHx?=
 =?iso-8859-1?Q?NaTbLHTcDEaJuWxwBS4EG8LXn3jsbQGnNDP9E6l6MIvAKlo1w06Hujca2g?=
 =?iso-8859-1?Q?DnpTiSdclN5kT+u5Ihq33HXTwYShpGyUXYrczk9GlaxP6RmUXWB+usMSjC?=
 =?iso-8859-1?Q?XT5xNzLajT6bL5QveiN7F8q450IkNnCbW1TEv1bzxfI0m9Ui3EQkpSVuM4?=
 =?iso-8859-1?Q?+O+HKhVYICDYr0hPcUWNiPTawzgCxTy2/9DcCBo6Mll134emgT+weH/p93?=
 =?iso-8859-1?Q?G7yliwBctcP2wOsCbF0jGGOa994KLkvbseDIpPXwa+LzsXj+tSXsJQtfuI?=
 =?iso-8859-1?Q?fK4EnPjdPLwGFsbQcbZGmyyss2A9wiZmAwPmnHI9Sk+8Cy86IDWycFZAvt?=
 =?iso-8859-1?Q?HWqCZU8DiaCP022XtEfDkAtg4qUF0K8zQrjtPI7YE3yVX+s6cRbjm27ymx?=
 =?iso-8859-1?Q?smjvq8OGaIcIOgMTHYYw0VHBAgfi7BY2jMs7WLtpg/xkRgyToANa5dyIsB?=
 =?iso-8859-1?Q?btMsDVkt74vqqgUqZ0KPuMLnHHQzDSV3hC7mPlrDruFjsE6ywtgDHFIM5S?=
 =?iso-8859-1?Q?OT9UlDH0hkXauMUOApdpGhNBvQalIu3LHwri7jwYOYLkR7ZByN+b3tM8Lu?=
 =?iso-8859-1?Q?FJV9HW5UHmfAbdXdrVEOhDOqcAB4xphxBw1EYyNpwwETjqAwRPpdRKjD+8?=
 =?iso-8859-1?Q?X+UfQ2YtiIt3FyfnoWk7TqdZ8jjfRo7H5IZL7J9Y5izUYpIGqfkxzbRQFN?=
 =?iso-8859-1?Q?vwpppVpBuukzSM7wu2VOoNf0NMhUfsVhidiIrp3oIQDw3dMJHokehEeQfl?=
 =?iso-8859-1?Q?CgtWEkyMLoz7iKj4BHl5SwcEPFE0ScuFHKkpeSoWdQinGP2kHdkw2uy35c?=
 =?iso-8859-1?Q?4C/3ku4TNCwktgfNA/t8E8jNK8P2xzCBPKKpu8GtI/9V253KuYfDxQzbdi?=
 =?iso-8859-1?Q?gea0FNChLOmR1xJJ9KFEzRYeAxYkPoByYrPXA+T+v1ZOL/qZR2Ch11fyry?=
 =?iso-8859-1?Q?xYXLqakSgQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BoWvfowBpNxwpYRYtBpchdhmBrByIAUY8g+WUX7BvXF0SKYZox+JDCL2Thj4rh3ZG98HdhyiVcCO4YWXc+kt1bIV6uFo009fDKf8W67Pi8U5L0amONa9h0Po+ou5zeUwjB47fNUBXZnm3BTtyULXpkZYR2PshF1tQxkhEUTQRefqPNg5A3SDTgqyVli2G0AO7EjieeT2E0lDtxWvZy1AMwagrzPtlbZ9FGv+018FJ7ULpXGPToKl6me7kwtVOQqCSzQZ8twaSSBGqW0qujCNzmE77/NyrnjLTyq7/lQY0Tpdgx2kPSt87zADaozuMp+QYfwRLoxUQq1SOBy+2P6aMA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcf4f3f-075e-4649-47ea-08de9b5a775e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:58.4597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OW1kRJ2lHIIGfgt1bwcXqFLLQvntX9BbLy42acElWpSV1pP9Tj76aKxkx6Pbm+nnkAPZroelzX8iMdxC3EHGagMxZlRDT4ze63plcTU14o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
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

When 64-bit addressing is supported, the Linux EHCI driver programs the=0A=
segment register to zero. See ehci_run function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
=0A=
=0A=
The driver comment also notes that descriptor structures allocated from=0A=
the DMA pool use segment zero semantics.=0A=
=0A=
Descriptor memory is allocated using the DMA API. The platform driver=0A=
configures a 64-bit DMA mask so memory can be allocated above 4GB.=0A=
See ehci_platform_probe function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platfor=
m.c=0A=
=0A=
On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.=0A=
As a result, descriptor addresses constructed directly from the guest=0A=
EHCI registers do not match the actual system address used by the=0A=
controller when fetching queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
Introduce a descriptor-addr-offset property so platforms can provide an=0A=
address offset applied when constructing descriptor addresses. This=0A=
allows systems where DRAM resides above 4GB to correctly access EHCI=0A=
descriptors while keeping the default behavior unchanged for existing=0A=
machines.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h        | 1 +=0A=
 hw/usb/hcd-ehci-pci.c    | 2 ++=0A=
 hw/usb/hcd-ehci-sysbus.c | 2 ++=0A=
 hw/usb/hcd-ehci.c        | 7 ++++++-=0A=
 4 files changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 6406f536e8..05d8db4a5d 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -264,6 +264,7 @@ struct EHCIState {=0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
     bool caps_64bit_addr;=0A=
+    uint64_t descriptor_addr_offset;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c=0A=
index 2ea8549db9..115d05ede0 100644=0A=
--- a/hw/usb/hcd-ehci-pci.c=0A=
+++ b/hw/usb/hcd-ehci-pci.c=0A=
@@ -139,6 +139,8 @@ static const Property ehci_pci_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", EHCIPCIState, ehci.caps_64bit_addr=
,=0A=
                      false),=0A=
+    DEFINE_PROP_UINT64("descriptor-addr-offset", EHCIPCIState,=0A=
+                       ehci.descriptor_addr_offset, 0),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ehci_pci =3D {=0A=
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c=0A=
index 61215e9f3d..df138fb339 100644=0A=
--- a/hw/usb/hcd-ehci-sysbus.c=0A=
+++ b/hw/usb/hcd-ehci-sysbus.c=0A=
@@ -36,6 +36,8 @@ static const Property ehci_sysbus_properties[] =3D {=0A=
                      false),=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", EHCISysBusState, ehci.caps_64bit_a=
ddr,=0A=
                      false),=0A=
+    DEFINE_PROP_UINT64("descriptor-addr-offset", EHCISysBusState,=0A=
+                       ehci.descriptor_addr_offset, 0),=0A=
 };=0A=
 =0A=
 static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index e1d5ecbad7..ea9d5846bc 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -162,7 +162,12 @@ static uint64_t ehci_get_buf_addr(EHCIState *s, uint32=
_t hi, uint32_t low,=0A=
 =0A=
 static uint64_t ehci_get_desc_addr(EHCIState *s, uint32_t low)=0A=
 {=0A=
-    return ehci_get_buf_addr(s, s->ctrldssegment, low, UINT32_MAX);=0A=
+    uint64_t addr;=0A=
+=0A=
+    addr =3D ehci_get_buf_addr(s, s->ctrldssegment, low, UINT32_MAX);=0A=
+    addr +=3D s->descriptor_addr_offset;=0A=
+=0A=
+    return addr;=0A=
 }=0A=
 =0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
-- =0A=
2.43.0=0A=

