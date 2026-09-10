Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9BBC79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tqa-0005J3-Mu; Wed, 09 Sep 2026 21:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4TqV-0005Gw-Er; Wed, 09 Sep 2026 21:45:01 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4TqS-0004B8-8k; Wed, 09 Sep 2026 21:44:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsicZoNJG7by6XH0X2vtnccE2lU3yn9osEFNo51MRXZxauBPn95REL8d670TuI66fVuiv/nxC76kvuIY8QkFSSIDcF/Rewn9QgV0yKjHW3aZlTwm5d35dNFZUFFklL8jsoEwmrZhZ3r6deVqT2ShddJN5NS2KEt7/Pq4Is4oyDp3hQOKC8WFgpOOm1K5rWtkEjK+KALyqYnPTYXuhVTisMpvm+/nLdER44jASHqAgBiWYWcyPyl9ExmSCmQHykEqGHy29iCqlZI7mVumTTxFfhFXIRGxHXQQ1BM7EajqxePqR1dNY0YGcQPz2mk5PM/Q1fuV6armknamEl3rXwzJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/UlxvwtsJiAeeZ6plX4LkuNWvrhjF1nZ70tq4RtXjM=;
 b=g28gsHJTN/HjZei+b/tTr/lLOVpl2YUGp4AR7ddNp1j8MyDXt3z3nw9hDESz4TiyZXibG8wZcLURc6wYusydCdGpFIrDAJI+H/mnA7KMmdR8cfpnPFuZXK52yytqr/XLwuFoCwX/RJSVY99i1Jf5QysJ03eXefaVgHBoghGEpEWXbkHY1KL60S8/1nIkcaihgTAA4v9sVC8mq31AyKBmAcjNe4GVXtYZachBiW7hv1OByM+h5PiOZye2UPvnoteDU4EsOOdoNPmtCLIaHDWFVBgrJc2LGVC/+1MsudDbEdPhvIELfYEy6ZgYzpooC3k09ExJn7X7MSgrIMtdh00TTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/UlxvwtsJiAeeZ6plX4LkuNWvrhjF1nZ70tq4RtXjM=;
 b=EpdzmUB6aqV4xvrh2709+Yb+hQy9e8PpJZj8q/LJ+R9h/SwVlWCkSyT2P/1meBwBGuHjIu2ZLcET8tAhp9L+MfDRprDw8G9FQ5hDPrvySHCuajZuf88jTGw/LVQT+uTyOy1Dc1DTp66D63pYm+N/IHfUGWXO9cPBkAFyImsTDIn/t0LH7IoybALye//Ptaetzb/68RaevgsAi4puYe0z4q29jEXdk8+T4sj/lycwDRwvBOBJt+vPzHF32F5ebD08OC7Hz1MSLm/7dqm+09G3iNVY930l+F6ERXAlVksX38eZEAQkWWw0fP13oNk7ot9P/ybc9tsCbYr6pywHwym7Rg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF06C2A6398.apcprd06.prod.outlook.com (2603:1096:108:1::7c4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 01:44:48 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:44:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/6] Add ASPEED VGA PCI device support
Thread-Topic: [PATCH v2 0/6] Add ASPEED VGA PCI device support
Thread-Index: AQHdQMX280JuUOLBxEi/1XUaqs7ZBA==
Date: Thu, 10 Sep 2026 01:44:47 +0000
Message-ID: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF06C2A6398:EE_
x-ms-office365-filtering-correlation-id: 35607a15-2434-48e0-614e-08df0edd18f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|921020|5023799004|10067099003|56012099006|18002099003|3023799007;
x-microsoft-antispam-message-info: YvU2chWowoOI9Ke2DrnzIDkUG/6g9Sk0JixZP6FFN3rkWEqm6f+Yo/CyOvOr4ZhutwSr8Ur9mPEYgKmkISgBzpo6poqmdR0/qZqJKaHnNaq6sXZvTpfgBWMkN+coNwV4tM4FqvtyCNsk+5FB72ZDiU/206sIVXQPttT/jryFxsDhrbM5r6BVpIBFVxXaDf1Nm813wHpjJXXEvau1XgED73iqPKrRaqJhtXmiqm8CUF6UaghArUr8y3lCjH/mkJhFazfbuLiG92LA7Gd4mz9MpuCTi0JcUKqa3zmyVt9eHva83eFXnm3/CYgcMw8OxjG7w8r7VxQRHDnOAv96kwT3WGV0jf7rLz+ieyT12rNgsOaQ6L7N9vsOdbCb8MiPQ2wG/kn0nbbf9Vbv7QOzJhX20xNRKV2pMx2Y/8aRVGvI1h7WigYzaScNi55lCWnM9mdfAA8b+Gz1O1yll4K1/l7nkeZV98ChZwwc7IOyrFibd8nQz993CkDp71NIT4nWEndSTMy1Gpk8zcaVjU86cnfanbLsc63dRHfy3BSD1O0p0BLR8ZOCRl41HHU5voxgqDPAoai8rZn9yMq6V6mR/XiBEAMSgJHc/VpIwXBnTQTtoj0R5T0LOxUlXLhyZ/tZ7u1AkSOFJ+s4QtjWt+m0D8Yj7d1RPx+bGXvkKgJ6oCF87lLTqrOVCkMfuG+KPa25M9Af
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(921020)(5023799004)(10067099003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9MHteluQ33eOgkQemCBXc7TiXUWt3GnhjTw/oWiSr28TJ+KoEOJM8NgMKp?=
 =?iso-8859-1?Q?UA1plOCBIerwP3yoPv+DAo47i96xe7U1m/4IHmuLC4svk7V02P1q00Mx77?=
 =?iso-8859-1?Q?eioBbDDSfaFU9bBJUreX2Mv6ofFcpV2T//jFrviit9KiYl1suzdq80mZ15?=
 =?iso-8859-1?Q?c1zleJEwG5+g36KoXBch/bKmlqgDO9MckOydqXjWVL/juCtah1VGa8qYw8?=
 =?iso-8859-1?Q?ZpoU+8gjY8u81EqKwMqugWuuQpy3eNJerwk4fe8C6IPOwrr1myJvOaGYkd?=
 =?iso-8859-1?Q?KrJRWSDxBrMntrwfsZL9o6cvsUuHrEWdZ731KrSDi0BqMPfqCZnsKHfR0Q?=
 =?iso-8859-1?Q?LBb25n9eqbyaCScbGClfq1hFe9QiX2erJR7+B1Yf+M0qcHbXZ4TIK90fGu?=
 =?iso-8859-1?Q?5Q38AFw0KCaFFLPd/lnMNUm9xqK8k+nwmqKvfx+cICQGhKHVqW10uVCfUW?=
 =?iso-8859-1?Q?sczf/Ohkolf2xH6/eeUUuletmtMJmqy0BO7yzFZgbSClb5nGqk9bNI68og?=
 =?iso-8859-1?Q?C273LDlUyoLIYHDH0rgoeZzCqFFq/1a3ea5L5vIPxhd3pyLwlR+2UOXI1z?=
 =?iso-8859-1?Q?K3Ku/UKBDCsh4KymDf7v4LwzQjXYMwhZu2EAeEg4SiyuA8hpuMzS3qyZxL?=
 =?iso-8859-1?Q?JU0JglwEHHHapQCi/qUr4Ki9nCCgUVR/kDf9FLvHuKV6Yh3pdKijMiqJPA?=
 =?iso-8859-1?Q?g6D1ASTlja28iD7fS0bMgHqZmhhK8Aajto7iXilwEquL12yu9qmUyU7Ghq?=
 =?iso-8859-1?Q?Hg+LSJcPNa9ASj6M7fhB/TKEaiHEFI5WiUaJlQxWEWTwE9xAqsdAWwZW1j?=
 =?iso-8859-1?Q?Hhnw+AbDu2hZy7xhNkdpCTkxDV/SxpTfTsGXqHkeISk9WjxJ/5M0deJsjv?=
 =?iso-8859-1?Q?U/GSB+LkzwLx2rW2SiQ8CwBVPAkDCd+w07SrTtLCW6ABFggsoZLbJ2ml1l?=
 =?iso-8859-1?Q?ZjYHB4Nv2ulq8E3UG013tYqWuFNrQhjKLTlP+KGPMMbAxSzegA0+vph5ga?=
 =?iso-8859-1?Q?AG66Lzs5F+hDd0fUOcLZLIWeTr4DMw4miONuS4+Az4RdcQYez2v5nkGaKz?=
 =?iso-8859-1?Q?8SNDuR6RFA0nA4PGc670zaG3xt7AxGYGre5OAxa8p8n1zGXeAKFqz3TCvx?=
 =?iso-8859-1?Q?x44je67F69aUnPsKCV0dC5SYS+OrFxomLEInKhVp3r38qDeSmxUdfJ3u0x?=
 =?iso-8859-1?Q?3Hp2mm0E7cO4h5UqSYYdkxMXuesAJI0I6DQWMPTpt1Xr5e5sFxoLJAv80w?=
 =?iso-8859-1?Q?D0YJRkti5Gg/CtRRKDOeWBk5XUzgJB21UiBbHD+pjxN04UYt602vxCSjjA?=
 =?iso-8859-1?Q?RZRcgMXzTJ4mdWxv126jiSt+RShcO6rRvkJrSPlyTKdb5YkNNZG3nDRhY0?=
 =?iso-8859-1?Q?mtTxx5ohWPsBMan2tA453RnCVQ5+3RU/9U1mFqL2zT2Fe8qNbQmXgdipyh?=
 =?iso-8859-1?Q?6smVQ8Xuu4pNbigOsFiZehBwryDz6EEze6zidSBupMBcnG7cAbJkr40q1y?=
 =?iso-8859-1?Q?mL1m2zPLHoftTIKi4fVmmG0Xj5LaSQuXxgU9lgwndxGq7ZyWOvK6mkSZS4?=
 =?iso-8859-1?Q?UeC8I3T1+fvIqUJ7DbanwUbDcIXtqllzVo0VRK5kiPIotQDR0L3EH+CCYF?=
 =?iso-8859-1?Q?pQI4fXsrDtxLvCdhsTpxnrAqbLb6noLRBgjGA3nB2iR1WzNa+y27yqvX5M?=
 =?iso-8859-1?Q?mrrUeI//nmVTHBvexjDG9DmL5VUYMP66h1xupRVh680Gtej2g4Cr2EOMIG?=
 =?iso-8859-1?Q?D6IV7fIGULCb92dr38O1lIqFqTnamX3hD/9A/ElYkSzTnDIuEeah+hNUBR?=
 =?iso-8859-1?Q?FS8TB0PjoQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GO1e/9oJb1d/H8wLGaescZX2uyK5G1Xja6TDq8F665rpbgLtu9fUjgrf3IUBgE3AshNQM1zONs7Atu7n99m2fJo2MnPfXvxZyGC79nwNJnhU62vKi3D48gknPb9QYVKM9pHW7IKRsItC29KEnL+t0XcMz4Pj1vsr5CaJ73lusCuAr1cfWUWQpBdZ0EqJz9KQvus+n2y0GktnX5kPdy5DknyTB1ywSsm5V1t/4o1QCACIUIC5rz7rW+69st6k5jF2QRf5aPSzHgDEYbysmgnEPYTiZmrK35kY+6QvLQm0Ut7dxYLHo9RJ8j6R19MuDx1jg+rd9iFvAGWDrQNVouGy6w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35607a15-2434-48e0-614e-08df0edd18f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 01:44:47.8998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EoV0ldcQ8BVIC4HwgIPC/B9aw1ixWosk0XFcEgJfaFwi1bOjmm9YTYM8PcbZlhIVl/A0F/jj1MJNYcLfN9+dCQ2bMYqf0Qg6+rEVa4DxmSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF06C2A6398
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This series adds support for the ASPEED VGA PCI device found on AST2600=0A=
and AST2700 platforms.=0A=
=0A=
The longer-term goal is to support the video path used by BMC KVM=0A=
applications. The planned implementation consists of three stages:=0A=
=0A=
1. Add an ASPEED VGA PCI device so that a host system running in QEMU can=
=0A=
use the ASPEED VGA device as its display adapter. This series=0A=
implements this stage.=0A=
=0A=
2. Back the VGA framebuffer with shared memory, for example using a QEMU=0A=
memory backend backed by /dev/shm/vram. This allows the framebuffer=0A=
contents produced by the host QEMU instance to be accessed by another=0A=
QEMU instance emulating the BMC.=0A=
=0A=
3. Add an ASPEED Video Engine model to the AST2600/AST2700 BMC machine.=0A=
The model will read the shared VGA framebuffer and emulate the video=0A=
capture and JPEG compression path used by the BMC.=0A=
=0A=
The intended setup runs two QEMU instances on the same host machine:=0A=
+-------------------------------------------------------------------+=0A=
|                         Host Machine                              |=0A=
|                                                                   |=0A=
|  +---------------------------+                                    |=0A=
|  | QEMU 1: VMM / Host Guest  |                                    |=0A=
|  |                           |                                    |=0A=
|  |  +---------------------+  |                                    |=0A=
|  |  | ASPEED VGA PCI      |  |                                    |=0A=
|  |  | device              |  |                                    |=0A=
|  |  +----------+----------+  |                                    |=0A=
|  |             |             |                                    |=0A=
|  |             v             |                                    |=0A=
|  |  +---------------------+  |                                    |=0A=
|  |  | VGA VRAM            |  |                                    |=0A=
|  |  +----------+----------+  |                                    |=0A=
|  +-------------|-------------+                                    |=0A=
|                |                                                  |=0A=
|                | memory-backend-file                              |=0A=
|                v                                                  |=0A=
|        +-----------------------+                                  |=0A=
|        | /dev/shm/vram         |                                  |=0A=
|        | Shared VRAM file      |                                  |=0A=
|        +-----------+-----------+                                  |=0A=
|                    |                                              |=0A=
|                    | read by                                      |=0A=
|                    v                                              |=0A=
|  +---------------------------+                                    |=0A=
|  | QEMU 2: BMC               |                                    |=0A=
|  | AST2600 / AST2700         |                                    |=0A=
|  |                           |                                    |=0A=
|  |  +---------------------+  |                                    |=0A=
|  |  | ASPEED Video Engine |  |                                    |=0A=
|  |  |                     |  |                                    |=0A=
|  |  | - Read VRAM         |  |                                    |=0A=
|  |  | - Capture frame     |  |                                    |=0A=
|  |  | - Compress video    |  |                                    |=0A=
|  |  +----------+----------+  |                                    |=0A=
|  +-------------|-------------+                                    |=0A=
|                |                                                  |=0A=
+----------------|--------------------------------------------------+=0A=
                 =0A=
   =0A=
=0A=
With the complete implementation, users will be able to view the display=0A=
output of the emulated host through the OpenBMC KVM web interface.=0A=
=0A=
This series adds the following devices:=0A=
=0A=
- ``ast2600-vga``          Aspeed AST2600 VGA=0A=
- ``ast2700-vga``          Aspeed AST2700 VGA=0A=
=0A=
The size of the framebuffer aperture is set with ``vgamem_mb``, 32 MiB by=
=0A=
default. The device comes up with the standard VGA BIOS; pass ``romfile``=
=0A=
to use Aspeed's own option ROM instead, which can be downloaded from=0A=
=0A=
https://www.aspeedtech.com/support_driver/=0A=
=0A=
For example, the AST2700 VGA device can be used with an `aarch64=0A=
virt` machine as follows:=0A=
=0A=
  $ qemu-system-aarch64 \=0A=
        -M virt \=0A=
        -cpu neoverse-n1 -smp 8 -m 4G \=0A=
        -bios edk2-aarch64-code.fd \=0A=
        -device ast2700-vga,vgamem_mb=3D32,romfile=3Duefi_arm_2700_vga.rom =
\=0A=
        -drive file=3Dnoble-server-cloudimg-arm64.img,format=3Dqcow2 \=0A=
        -device qemu-xhci,id=3Dxhci \=0A=
        -device usb-kbd,bus=3Dxhci.0 \=0A=
        -device usb-tablet,bus=3Dxhci.0 \=0A=
        -display vnc=3D0.0.0.0:0=0A=
=0A=
The disk image is an Ubuntu cloud image from=0A=
https://cloud-images.ubuntu.com/. =0A=
=0A=
The output goes to the VNC backend on display 0, which listens on TCP port =
5900,=0A=
so point a VNC viewer at that port to see the screen.=0A=
=0A=
=0A=
v1:=0A=
 1. Add ASPEED VGA display controller=0A=
 2. Add the hardware overlay cursor=0A=
 3. Add the 2D graphics engine=0A=
 =0A=
v2:=0A=
  1. Drop "Add the ASPEED VGA device id" patch=0A=
=0A=
Jamin Lin (6):=0A=
  hw/display/vga: Allow a device to report vendor specific blanking=0A=
  hw/display/vga: Move VGA_HPEL_NEUTRAL to vga_int.h=0A=
  hw/display/aspeed-vga: Add ASPEED VGA display controller=0A=
  hw/display/aspeed-vga: Add the hardware overlay cursor=0A=
  hw/display/aspeed-vga: Add the 2D graphics engine=0A=
  docs/system/arm/aspeed: Document the VGA display controller=0A=
=0A=
 docs/system/arm/aspeed.rst |  37 +-=0A=
 hw/display/aspeed-vga.h    |  61 +++=0A=
 hw/display/vga_int.h       |   9 +=0A=
 hw/display/aspeed-vga.c    | 945 +++++++++++++++++++++++++++++++++++++=0A=
 hw/display/vga.c           |  11 +-=0A=
 hw/display/Kconfig         |   6 +=0A=
 hw/display/meson.build     |   1 +=0A=
 hw/display/trace-events    |   7 +=0A=
 8 files changed, 1066 insertions(+), 11 deletions(-)=0A=
 create mode 100644 hw/display/aspeed-vga.h=0A=
 create mode 100644 hw/display/aspeed-vga.c=0A=
=0A=
-- =0A=
2.53.0=0A=

