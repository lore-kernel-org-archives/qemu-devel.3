Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52697606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=RoBUfbqX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHa-0008KH-AK; Tue, 10 Nov 2026 02:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHY-0008Iu-1p; Tue, 10 Nov 2026 02:28:40 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHW-0005Uy-FY; Tue, 10 Nov 2026 02:28:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxsfPNSaef35K+0YSHw1eUrIXgJDb/LMB9NPfoIyjJjyCZd0makOmS5lZQHHmJzFNcXjZ20sLDv6SrzplvC8oZPvXEaUnt02HQsenxwIDtwjkP6ws0I0mLd0fYAmngc/5di+x7I65joNaOYE1/HKbpX58M+RUJFOLZDPn+EAjX5BIcwNBopS/hJM/qrYBiUoJSbzXQMPoFVE2mm6x3QTU11TEvUwmhwDPkFfl/LALwuL++zdU7NtQdPfxr4DFX5tHGGd80EzWJB3C/diAt3k+nzoO7rzt8qXpGo7ELJGOU9dW9Ss5GqjWFW9giycI+Ld+TWetL5b/iFfXMyhzFA9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdc/RvB9m/GB4DRiq9WXPB+ddv4KffiMEZ67z5OnwJU=;
 b=C4PRSFeqK9t063B1117LBDaP5CYCko0esuLRv/cttiPleaOjcug90hAIeqxbS+SxBhW6lYplxQkT6zA128MX8LDA3odkQGPStGi1zySuiWaJV7GUnoqkA/jn+jy4nIXe+n9sLe5Q3X8NYeLubKZ7o8j0n9TetmN4KCl1Q1PHlSyDdthcz0xNWsCoHyVYaTGqyM0m2HRTaTqvFaom95g5swxBwVujyA4jYEDIcfKeuE1/ksK6Okod4Q5izaHy4bo2pRL71xIZpFnsZyP4x2hoUQZy4JDyA14FgeORVX74bk0l1P3lyeGNmeq+/5zrDWzxF0PjydUBIMlx998t9iQQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdc/RvB9m/GB4DRiq9WXPB+ddv4KffiMEZ67z5OnwJU=;
 b=RoBUfbqXZMkCfSNzcUYViPMg3stJ+FAtljM5z22LMg4BJGN8aVbzA9bzSLlbfF8IBlFA436SularXzW3OCdeOZkV3LVs4NA+xXRm3wjCUXVyKRjUr5DTPc8sQWCmrqjzcQUOkh7dbP8Mlryvrp6s20GvbAFHCKH/L2wRLXWg71l+9YAyR1KA97rRC1j3498Ixt0X1fh0LA20An1HbJsUk/3WAGcRgKF7nPu1ML5bpuF9L2h1DCgpxR/6rmF69jk0e3tBqDVsyiKWcv0KH9du7QMkDkcEAKuxVYvcwZXs0yqhC99V2E6f4++YEssUR4VxNIYhPIEKcvuupZKqFg5Y/A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:28 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:28 +0000
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
Subject: [PATCH v9 06/19] hw/usb/hcd-dwc2: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v9 06/19] hw/usb/hcd-dwc2: Add an auto-hub property and
 leave it off
Thread-Index: AQHdcOUU+vyeOoJo20u4/IS0ASZ5/Q==
Date: Tue, 10 Nov 2026 07:28:28 +0000
Message-ID: <20261110072818.2883349-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: f36a74c5-edd1-4f8a-3379-08df3efc36c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261021121427099003|261009223027099003|260925021911599003|260925021311599003|260925022911599003;
x-microsoft-antispam-message-info: 7UMfGlu1jxakFhwStwINIRGI7O7eKMrgqx9LD+MB09V0URiUnlr5MAn8i7AmLbG/DeTsL5G3tpxxU9fwF9dm9u55UrdzIGb7ypVIpimUV7Y+fwWBVVvP9Wyc0TWy0ttfqTtNzzAVnryNML2czOVPtcVsmnbLVBupbk5JvcizWvSID3KFtAwAdGH7JFUr/xqHd9VN69JbYSKqhFFLLCu8n7QAPydOE64qGblKjEwj3HK3tqeCUVKPxbLirRMPKPfQMkEGhSJsD+IYYGWzlBX1uurvSjq4t5PV3SmR/8v8pcNn4LoJGUc/smHObGRNaYYLnDXrTPU+Y20pCGdXJ+XoOJBBzE/ISBjYnh1M46hIfgw04CuOgkuvVKntLFIpIzqyEjz0nTOKK8VikgiN3HmkqS+itRJjAIgtOVpqSKX0uTfCAM0OU1Jnqx5of7iF7tIb0xqohashT4GyXXjPEod5Em1121YkVD47KKOQMDYwcEpB6CrKWrsGQidFYNSzCdBUnu1hMCSQb5T/ACI6ZBKpyfo73FYP+y0ie+hinOmFPAYaUk8qhGzKYegTxbtgbjbM1u1BJx0q00Cx35MuvZ7pgHgKcBOwO5xJH8tSBPqt4VjWyZ7tDopvfiDKJXoLTZgQUorhpXb9SdA9bd9RNwIlIj/87fdLM5KSncG3f3DWI9S1/uHcUlZTy+OaLkRvdgEn/EJrpE+doCiQGhEa617AOaZ9pi7fg9II9ucivOf5wJ01TTx9B2ePoQOeWWeIh5RM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261021121427099003)(261009223027099003)(260925021911599003)(260925021311599003)(260925022911599003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6DOzGucswjI6NyySqdWBTxL+GW8hoTxsoJdIfsN4ZnDEv7tsDdBsKNS+DE?=
 =?iso-8859-1?Q?/TQu0oso0stPSnloqt/dBL+cSu/Vxw/aYU4fG2Dn6utK1DpJZp7xU4jr/G?=
 =?iso-8859-1?Q?RxWSeJS0Eh/iXlu4gCE0wKeupNuwLC7F1AUysxSyZ+Jy8M3DNQU1Rl8pOY?=
 =?iso-8859-1?Q?RW5x+Vh8m2rpr51jXMkOzvCZ10dNLw4apIRIdT9L6Nwq1kF2jpwQaNlQUF?=
 =?iso-8859-1?Q?EzYXQ0iFu2+ZKvBle7c+zUDS3oxo5PDLIEtPNbBgdx9HJisB0bDQn+WD5a?=
 =?iso-8859-1?Q?MbbWb5/yN3t+ch5ihgYCaHUfHKVtKCmyFRPK5fvko4n9dzJVixoswB3+Q2?=
 =?iso-8859-1?Q?gDl5u6jY7CKqXi+2vBt2y4Tb6Axg498VNkRc+wVDCmaFyc/tmUoVIQ0Cwy?=
 =?iso-8859-1?Q?Ks3FkOFjmlHRvSPRaY2rLtrceh3ntuBO75HhlOKKRDwIgMP8S5UC2umb/3?=
 =?iso-8859-1?Q?tnxwFE98lyr9JLZA2Nj8Xq7o1xsMUc48tihBx4LqTc9kdE7EsvkkYzU1ix?=
 =?iso-8859-1?Q?/0U8WqfdcZJRAQvcneWami7SmVecOrCo6LIZPYNMwXc4VEIm3z2N9tKwWN?=
 =?iso-8859-1?Q?jDCZzd3861GR2c3grjI3wKl2dMrUzuqngjdML7ZsAEc27XYiCs8dzL10QN?=
 =?iso-8859-1?Q?8nTRFGeZ/9BwWyN8GV04dLC2CfTszBGo0lGJzeTjoMPf1i8K5ahR921oe4?=
 =?iso-8859-1?Q?S4+c377zg2Ef1cgr6NPIMByayqs4hRu9hFTBGYxLiJYLzZHJl0y49VQFpz?=
 =?iso-8859-1?Q?5OCg46Uvbr0oAImN2Ps7KpPh4qEdHxeBnSgjVrep0Ys9ruuQVueLDne/UG?=
 =?iso-8859-1?Q?XdKZjc2WpA6K8QzgpCj9rSTG2yiplP1gf5uEJXcAR+/VJsLD+rSK7mt/5C?=
 =?iso-8859-1?Q?msSFm5z68MOMuaONu2hzKfLaVEfF+PJrexyM7FYGsKKaZYXGdts/7BC9tE?=
 =?iso-8859-1?Q?pbNr621+aJEmkv9LCd0YRZ7gcxbeTOK1sHmgFrMPWfOfpTa8VB8zBWGtJ6?=
 =?iso-8859-1?Q?H8/a4UiukgYmo62eG635oV7SWW+NnZrERk9Ve2ZUZ451AhL/sYlPt0RFNv?=
 =?iso-8859-1?Q?wjjJtbKiXN3FJiDRRcgi8lkxc+1ZRRB/DT4/egZUMtfdUGdGlyzNAeYBiX?=
 =?iso-8859-1?Q?Bkzb547MLP9b4zWgBii6iSoECPr3iZ023i1fbbcKTID2Dmz8xi6cbgqP5W?=
 =?iso-8859-1?Q?sQSCh9REEMZ1EvF5aY0PAtumQVKrgN6GN5ZSa+4YtdFwzmHjbc/tf4PtQT?=
 =?iso-8859-1?Q?AZUKCA3RLkq6cJLnRRFcArhpt9BXbqPccrgON9F8iuSXn+Fv3Syq0eZwTS?=
 =?iso-8859-1?Q?oQa/XgbjVE57OzjPingiWp5EAaK7zlPRoUImpOoae+2KSrovDZ0m1LK0KM?=
 =?iso-8859-1?Q?89df860ABhfmvActSDCDu8zeWEg7DuMMZrDL42d72RSL9Y4amXkvY7WJaz?=
 =?iso-8859-1?Q?S1EhgoYTanUrVTvPx8mviEswk23b8ddHNCGHNrAn7B9RQQMt0cYfQ/Y4jV?=
 =?iso-8859-1?Q?ZAlKw5SuKgo6ujSKniGzO+zIXp647b9Tvd9qbvVDFBODJ29vNLQTGA6PN8?=
 =?iso-8859-1?Q?vRBYsveLNme4XZakInvfUmAuDfMmPImpbm6riIHoi3/iCy3SeyZCEr4uL/?=
 =?iso-8859-1?Q?wUcafSfSoa0sEOb4tDy6PbeA9d13nd0Ht+RTsvy3t9SM+D8MBTN+RiNLZP?=
 =?iso-8859-1?Q?f2HrvAAWWcWGnTPGJux3pYuWNeWof3eeV5uXnOHlD6Iw/t/UlZREAltYsu?=
 =?iso-8859-1?Q?kKex4YvNX++nxxTViN1j9n1/fur8SuTgcZEkPTtneahyyKpDmMyboFgsP3?=
 =?iso-8859-1?Q?AYIe/qhlTQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oJ7y1lPHryLIb7QOZguktEdPilLuUgdrHzwjf16BYdB5HIhhSO9I9qX60i/N8Bokob6OnX5BKIhOqU9v/CIPcQPo0BJzTcwX76XjlKo4dJwldn/49oawovGcupYNM1V+ubiCtx4vvlRhk+HUMLsZaGZ5DhDuoxWrqAfGrXVl7/1FV3iv1cnMZr+sBmVmN7X+A1guBUrvJUuIMWcWRKdzjNT/nNW/sD89z8reLQ8ULAJjhbQby/DS6A96Ey057/vk0yMpeSIT99jmJbHAwNbTxopZ/l8ky/bqNjIbJQbs+BMn1FObm4F5hhaKV9d52FGUGvg5nckXms4vdLLDSqFkPA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36a74c5-edd1-4f8a-3379-08df3efc36c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:28.0629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VU53tX0C3X3IvOI0jNgtEhUtRIeCjyS9ovk444P7mcmWwulEwZnvv1meVg1ygzF0EYcx3ODv1PbB8jCBwY/4f6BaBRZ1fqg6EIReaYRtDmY=
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

dwc2 has one root port and runs at full speed, so a second device only=0A=
fits behind the hub.=0A=
=0A=
Add auto-hub and leave it off. raspi has no versioned machine type, so=0A=
compat cannot reach it. bcm2835_peripherals turns the property on, and=0A=
raspi keeps the hub it has today.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Tested-by: Junjie Cao <junjie.cao@linux.dev>=0A=
---=0A=
 hw/usb/hcd-dwc2.h            | 1 +=0A=
 hw/arm/bcm2835_peripherals.c | 1 +=0A=
 hw/usb/hcd-dwc2.c            | 2 ++=0A=
 3 files changed, 4 insertions(+)=0A=
=0A=
diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h=0A=
index 68877661ca..be06f0b0e7 100644=0A=
--- a/hw/usb/hcd-dwc2.h=0A=
+++ b/hw/usb/hcd-dwc2.h=0A=
@@ -167,6 +167,7 @@ struct DWC2State {=0A=
     uint16_t fi;=0A=
     uint16_t next_chan;=0A=
     bool working;=0A=
+    bool auto_hub;=0A=
     USBPort uport;=0A=
     DWC2Packet packet[DWC2_NB_CHAN];                   /* one packet per c=
han */=0A=
     uint8_t usb_buf[DWC2_NB_CHAN][DWC2_MAX_XFER_SIZE]; /* one buffer per c=
han */=0A=
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c=0A=
index 558c180df9..9187376812 100644=0A=
--- a/hw/arm/bcm2835_peripherals.c=0A=
+++ b/hw/arm/bcm2835_peripherals.c=0A=
@@ -152,6 +152,7 @@ static void raspi_peripherals_base_init(Object *obj)=0A=
 =0A=
     /* DWC2 */=0A=
     object_initialize_child(obj, "dwc2", &s->dwc2, TYPE_DWC2_USB);=0A=
+    qdev_prop_set_bit(DEVICE(&s->dwc2), "auto-hub", true);=0A=
 =0A=
     /* CPRMAN clock manager */=0A=
     object_initialize_child(obj, "cprman", &s->cprman, TYPE_BCM2835_CPRMAN=
);=0A=
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c=0A=
index cd3b61158d..14211e6413 100644=0A=
--- a/hw/usb/hcd-dwc2.c=0A=
+++ b/hw/usb/hcd-dwc2.c=0A=
@@ -1354,6 +1354,7 @@ static void dwc2_realize(DeviceState *dev, Error **er=
rp)=0A=
     address_space_init(&s->dma_as, s->dma_mr, "dwc2");=0A=
 =0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &dwc2_bus_ops, dev);=0A=
+    s->bus.auto_hub =3D s->auto_hub;=0A=
     usb_register_port(&s->bus, &s->uport, s, 0, &dwc2_port_ops,=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       (s->usb_version =3D=3D 2 ? USB_SPEED_MASK_HIGH : 0))=
;=0A=
@@ -1450,6 +1451,7 @@ const VMStateDescription vmstate_dwc2_state =3D {=0A=
 =0A=
 static const Property dwc2_usb_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("usb_version", DWC2State, usb_version, 2),=0A=
+    DEFINE_PROP_BOOL("auto-hub", DWC2State, auto_hub, false),=0A=
 };=0A=
 =0A=
 static void dwc2_class_init(ObjectClass *klass, const void *data)=0A=
-- =0A=
2.43.0=0A=

