Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929D4CD6E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjm-0003ME-3s; Sun, 31 May 2026 22:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjk-0003Le-9K; Sun, 31 May 2026 22:50:44 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsji-0002lH-FC; Sun, 31 May 2026 22:50:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnU//5VH1QN5s6Hq3OknZwNipE/fyychvTdDLwoIYCd2snm+rojGcMIeEe1Bsvb15/W481TXytVqw6lnv8cL4YPVxXk0nRKJisyIqb77G0+m8pKolivSZZ0bUx4UiWk0BR4/v7i8OoeoJ54LDQWJmZRhc+2YYvRPHgfvG98cUeFimP5dmbFW4E2kqesngCYWxCQZbdW0ftdks0LVbH++gLX5j1QLcDrwo/MFnYOgSNv9tmvooF/n3CjHsYqvDvMe+ijGARWhEXsSwy9Xt2lmPFbXEnCNXxTsRRYhZiZB0a28ljqDQwPwkalFRHPL86jKyroDIiyY5HXiptrj4Jiizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0whEKRwwmgt+W2ywuKdTep6mQFoh3H776NxC1L7zCc=;
 b=lintDIHkX+FyYbxHNz7LJ9Kl4yfJtm5D8Pn25o4SBVjEfKO/uvJ95jK5q5ulwDnhdsuBjwwKSwRS1hfYYWeoZp787Xc3YGlcUzxOf/ByJB7FHNIBagse4VRXCVocWWhjax3VFpXtlIE81zPuKA6ZOJzMyPPiDKqFmehanXsQZAG6jBFqcBEMlY5P0gsk7B/9H58CNsq0mvg6F9vuA5p+4xSeJOKuMVI8qotU5Z38q8cogJhoezqm1PWbdQyrVz7ECe88EMGn9laXEhyvynj9ub8CjqtCkY2p0Zs8KGfjaBdVbkOtiy/FiXsvaM8CRHJXP6JdnQL+T+xqhvDc+9Lppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0whEKRwwmgt+W2ywuKdTep6mQFoh3H776NxC1L7zCc=;
 b=nwiBW7Cl8+Le0DWZhalGJCgJJw/dOurPLY6VEaSmYC3sBCL+zhbJEH3Sknb6rUWWGt9FIBazxE40l5WKBvAq2vHD7AXIbChlk40KoqDycjUoM5AAU7e26kZtJ2eDM3dJq4JqsuaPcSStXXwKZtS4nzt0Y+tfHc4tKWdR034HVJydBK28fJE0iqzCSUwqg1O0CN5/N0lpiyUF3c6ORho3aOWlwVYjPOQz9iETFTyFMr7h98+KBDALiwFmu8vTmd6HyI95P/pcIpGBZBiEC1tc364GTgpbeUR86zepgigpu9nibSZeA/zD0akASJCxAVge93RfZGmwsE0yJgHjHKJoeQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 02:50:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 21/24] hw/pci-host/aspeed_pcie: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Topic: [PATCH v1 21/24] hw/pci-host/aspeed_pcie: Convert to
 DEFINE_TYPES() with inlined TypeInfo
Thread-Index: AQHc8XFpjtNuo9yp7EKEEsLD9cSRgw==
Date: Mon, 1 Jun 2026 02:50:32 +0000
Message-ID: <20260601024959.2347639-22-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5490:EE_
x-ms-office365-filtering-correlation-id: e6deba63-1b0f-4024-5238-08debf888c5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: YKLR/rhTI6cGSOwPLONSGNyYSl33ueJPg7bRGfWio4ZHx0JpUWzhg9vB/AO22kTzgtVqdAaL50eQHtBqrT4dw3sa1cV1m+MH0C6ci33BQ+f3Kx1ZmL8hiwEMVsqHZjecyVP4Pg5Z0+WUEnJmcMit6/ThUk8rM7lUGw1166v9z6QjxohQd124nPC/cEEyLrwveZthIVTV9HB7swuinLXHGC60XYgQWuvdye0ZoNnTFv1Tjm24F2qu3CLkLRZL3pBRZ2lyXFqxJRrPacLQaVEFZ1xDVa9Bf8ry88BukvntJmeDcrW5VfbdEwJbgbmY1bS69bSxSxOwLWQrjl69RQZZxgzi2CKOkTN4lOBMqcixipWJv7ItFo9L+wqHiXr9mm+H5gc7qzDX4cxlAjQFgxmkqlCRwPUnxyWRGEfMPVejpXxM+dNbC6kMi0bQzvR0ibDnxEVqjg4k1woN75YSZ8fDDvchK1HsekLdmP5esyqVVfkoi/Esmu/tJUoMXtkja9bog+csQhLmRlUkUWPq51+gVCDHbqbOa9HLDwS/6euJfYlFYroytP2X9DiKyGdIFjfu5WLU9lQPFGvDUwWSfJG3Prc3KcpOF8yLOUaWgIkGJfM2aAMs14guwvp6corrD+lHq/CXy7qnRRklXk0s94GmGTO9Ls6J8qiy8TduKWgwXMCehmKFo9IJ8S2Pj3vqQ6YDdI4+cxL7I18tBbcb1vidn8CmSEySfk1uAT6e/PjlbWCAOd3mKo/+nhhC6kEP9D/t+s9saqkyFyvkV1JsDS8srA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RlzYDlcj9G4CWmvPgV67dpaGR2gwZLHukIvaiMLGbOtyawuP/6EwBwhoI0?=
 =?iso-8859-1?Q?mKcyL0g08YuZjLljoxy3gMC8KTKIQeL/1Hrj7gOD/cEKWzbsImi9FJsxKN?=
 =?iso-8859-1?Q?NEFc/8I5RLM2yVW4C0XKnp9STF4GyLF/rsSN1zEDt2obzus44CWxNFV4TN?=
 =?iso-8859-1?Q?gnDmrhwUmZMaRLNH0+Pq7on0JE/ww7Bkd5oz73rlEpwfTmhwYkNEV1bED8?=
 =?iso-8859-1?Q?cPEBU76FQE7FdiYz+NgTh3YyY/ktyn8JcuEAfM8OgJRTHivLPPEqQAE5pl?=
 =?iso-8859-1?Q?8lkZ+Smlt6LKsWZ84DsbnXXaNhccr0iEmySWw/kSQQM1nI4cmWkMkeldkN?=
 =?iso-8859-1?Q?RPFJRtHRL1Ci/IfOKtggdvLxNO9Q/vVJYCTTKdWk6B6vwECM6hBOBswKx0?=
 =?iso-8859-1?Q?mxCtvpb0vVoJALC+o2u4hRg92s0hcbcs9n8miG1yEpPkDTuHHChy4gSakR?=
 =?iso-8859-1?Q?JUlyRtAJ2uEyT8+ZJLmUI5GOcsopoF3TKJIAoQpci3jZ6Br1qANnbqv23p?=
 =?iso-8859-1?Q?X7hppNpRP4Pfl4iMb/oiqXtJuEjwrOMMDNDvNsYL7kDBdworW28gbZU+DA?=
 =?iso-8859-1?Q?fd9e6V8DSaeb00EGNL7f70+SBsiNc01n8uTy/FQEi31mdev4kpgK64/vl9?=
 =?iso-8859-1?Q?iETK/w1kOrLWcp6yHzm57hP2I7eXUB1xRS9z7QdZigA1EFdWB8al0veqtV?=
 =?iso-8859-1?Q?NbLZ7mijCyLWlDtiEkUuysZHuTxIUssy+fA2VDmQj/C4YFyGcz15wwtDoy?=
 =?iso-8859-1?Q?WrVX6S6iHl/rDunM0HX9n2zAXArCqDZVfoFx85nfgH5Fs61ITh3KttZNpV?=
 =?iso-8859-1?Q?DmoVqZD+42SFglluavf0fnQ1KZV7D2hY7uZcAoLrAfQ7sK8s62tYl+o5Eq?=
 =?iso-8859-1?Q?gA6c89zf+heRjJumIcApXPwawjP98S7Ocojc3RUKnvcPBuEulb4ZT0TQzm?=
 =?iso-8859-1?Q?/qBC8IGPmmwG1E4/nQ/+u3EFqXObJcDgrp55mCI4IGuS9g3TBTgkVbgjka?=
 =?iso-8859-1?Q?50eCyab11WZeDZFpM+Q7uir9J3dSO2PdnR9bUhZDs4vvR6MspR+2kHl10d?=
 =?iso-8859-1?Q?6wUm5EL87hV43STrFKi3cJrXiVCnQouzK6xRAx+zpBKaYmbrG+ie4C7pSq?=
 =?iso-8859-1?Q?01830GHtnRd6XAOHfrAfAh8X5kj6woUq6j5kAWqreGAFCajXVioaua9Mgp?=
 =?iso-8859-1?Q?fn8uxQ9Y5nx+2v5g4GAsyN47u9PlShYT3DuHNk/G0VsSUyVzXHkzF2xzVv?=
 =?iso-8859-1?Q?WIx+5ML0Zft7r1ZPn6aRi55pmMHLxfVp09vFA+13KjFOIWBLGtV2YhO0JF?=
 =?iso-8859-1?Q?sqBc3p3CsEAm9gkzQhTaDtiICE3bNmIFN8CymCJQJW+tYfXXUG/FJxqAMv?=
 =?iso-8859-1?Q?B8a9tBQeZ6AQKAeBsZCDuKjcNgFvCSJcc8PEb6aqhMJmctIanvQH/b/JYU?=
 =?iso-8859-1?Q?PVd4xgbszZ1xgShXK7yj2PbFfxjxGYctLC6leTcJO45FVJd2WyXVLBfdk8?=
 =?iso-8859-1?Q?35cLnbm7slnSo+w09swwmZo4/6BC6IiWu1Tnpchpdg3Xlk/FY58MqpUzJm?=
 =?iso-8859-1?Q?xYg1wUy4LPDvSrsAbPV+aQW5rrlHsbkRVgErg/qXoA/NgkYhf6U7ZJGU4U?=
 =?iso-8859-1?Q?4hYjrgLzUC1FCE6KkiZp1a7e4EJHiTgViIsJiR1x1D4eM6eNaoDMgyZqFJ?=
 =?iso-8859-1?Q?38RR2Ssm5ltijRXdNNkKIRlKkjGiZ2e6CS2RgMCkPpAD6tepnosj5bdhGx?=
 =?iso-8859-1?Q?VuNUPcfDvfhR0nj0yJOxNc7TsrxL3I2XF9OtHo1kUE+h3cq3OziAxB9MBz?=
 =?iso-8859-1?Q?C9v28PpmCQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AlDKmb1YbvYiq6RBzktJPxGJruIdZkQJO9WHJ5ytka3rGfpEcJXXkQALQWzyvAErb1sDhKvMnF1F6FSJflpkIvqkFTzr/ho6lCwPMSvRPK+XPAchONps7fKh2Z8Ayvx2AwBL1ttO7h7Jo0r/vlBietZR4USIcVkktSETx26saT8gsYgz0ZQfW+fO8lSUID3ZM7vQDK06CxMEi1MbyPtmCjoOWDgSrpadUhohqLKEFjhTA2SoaMbZruqWYhh/6+MOoEYPMvkYj9LsthkDHIawNVBiqAkT9pCFx9i78sqLD7YCDFp+QHeKU0OItgpPBjbj/Wl1HBaiD2Fcjmd4lnwkjQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6deba63-1b0f-4024-5238-08debf888c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:32.4124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isYH98sOFcu6J29Rq0gKisNj9cBAIp/7/VRkSktGgdChWNwOvVndnG7gcA/zt8ClofSvuvw/iQq+vRtnXuWhldMQnVpNeXxjzozW3LVmdCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5490
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline 6 standalone TypeInfo variables (aspeed_pcie_phy_info, aspeed_2700_p=
cie_phy_info=0A=
aspeed_pcie_root_port_info, aspeed_pcie_rc_info, aspeed_pcie_cfg_info and=
=0A=
aspeed_2700_pcie_cfg_info directly into the 'aspeed_pcie_types[]'=0A=
array, removing the need for separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/pci-host/aspeed_pcie.c | 94 +++++++++++++++++----------------------=0A=
 1 file changed, 41 insertions(+), 53 deletions(-)=0A=
=0A=
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c=0A=
index 186e5aeea2..b46eb74234 100644=0A=
--- a/hw/pci-host/aspeed_pcie.c=0A=
+++ b/hw/pci-host/aspeed_pcie.c=0A=
@@ -83,13 +83,6 @@ static void aspeed_pcie_root_port_class_init(ObjectClass=
 *klass,=0A=
     rpc->ssid =3D 0x1150;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_pcie_root_port_info =3D {=0A=
-    .name =3D TYPE_ASPEED_PCIE_ROOT_PORT,=0A=
-    .parent =3D TYPE_PCIE_ROOT_PORT,=0A=
-    .instance_size =3D sizeof(AspeedPCIERootPortState),=0A=
-    .class_init =3D aspeed_pcie_root_port_class_init,=0A=
-};=0A=
-=0A=
 /*=0A=
  * PCIe Root Complex (RC)=0A=
  */=0A=
@@ -305,14 +298,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass *kla=
ss, const void *data)=0A=
     msi_nonbroken =3D true;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_pcie_rc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_PCIE_RC,=0A=
-    .parent =3D TYPE_PCIE_HOST_BRIDGE,=0A=
-    .instance_size =3D sizeof(AspeedPCIERcState),=0A=
-    .instance_init =3D aspeed_pcie_rc_instance_init,=0A=
-    .class_init =3D aspeed_pcie_rc_class_init,=0A=
-};=0A=
-=0A=
 /*=0A=
  * PCIe Config=0A=
  *=0A=
@@ -679,15 +664,6 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     apc->rc_rp_addr =3D PCI_DEVFN(8, 0);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_pcie_cfg_info =3D {=0A=
-    .name       =3D TYPE_ASPEED_PCIE_CFG,=0A=
-    .parent     =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_init =3D aspeed_pcie_cfg_instance_init,=0A=
-    .instance_size =3D sizeof(AspeedPCIECfgState),=0A=
-    .class_init =3D aspeed_pcie_cfg_class_init,=0A=
-    .class_size =3D sizeof(AspeedPCIECfgClass),=0A=
-};=0A=
-=0A=
 static void aspeed_2700_pcie_cfg_write(void *opaque, hwaddr addr,=0A=
                                        uint64_t data, unsigned int size)=
=0A=
 {=0A=
@@ -798,12 +774,6 @@ static void aspeed_2700_pcie_cfg_class_init(ObjectClas=
s *klass,=0A=
     apc->rc_rp_addr =3D PCI_DEVFN(0, 0);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_pcie_cfg_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_PCIE_CFG,=0A=
-    .parent =3D TYPE_ASPEED_PCIE_CFG,=0A=
-    .class_init =3D aspeed_2700_pcie_cfg_class_init,=0A=
-};=0A=
-=0A=
 /*=0A=
  * PCIe PHY=0A=
  *=0A=
@@ -926,14 +896,6 @@ static void aspeed_pcie_phy_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     apc->nr_regs =3D 0x100 >> 2;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_pcie_phy_info =3D {=0A=
-    .name       =3D TYPE_ASPEED_PCIE_PHY,=0A=
-    .parent     =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedPCIEPhyState),=0A=
-    .class_init =3D aspeed_pcie_phy_class_init,=0A=
-    .class_size =3D sizeof(AspeedPCIEPhyClass),=0A=
-};=0A=
-=0A=
 static void aspeed_2700_pcie_phy_reset_hold(Object *obj, ResetType type)=
=0A=
 {=0A=
     AspeedPCIEPhyState *s =3D ASPEED_PCIE_PHY(obj);=0A=
@@ -961,21 +923,47 @@ static void aspeed_2700_pcie_phy_class_init(ObjectCla=
ss *klass,=0A=
     apc->nr_regs =3D 0x800 >> 2;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_pcie_phy_info =3D {=0A=
-    .name       =3D TYPE_ASPEED_2700_PCIE_PHY,=0A=
-    .parent     =3D TYPE_ASPEED_PCIE_PHY,=0A=
-    .class_init =3D aspeed_2700_pcie_phy_class_init,=0A=
-};=0A=
+static const TypeInfo aspeed_pcie_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_PCIE_RC,=0A=
+        .parent =3D TYPE_PCIE_HOST_BRIDGE,=0A=
+        .instance_size =3D sizeof(AspeedPCIERcState),=0A=
+        .instance_init =3D aspeed_pcie_rc_instance_init,=0A=
+        .class_init =3D aspeed_pcie_rc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_PCIE_ROOT_PORT,=0A=
+        .parent =3D TYPE_PCIE_ROOT_PORT,=0A=
+        .instance_size =3D sizeof(AspeedPCIERootPortState),=0A=
+        .class_init =3D aspeed_pcie_root_port_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name       =3D TYPE_ASPEED_PCIE_CFG,=0A=
+        .parent     =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_init =3D aspeed_pcie_cfg_instance_init,=0A=
+        .instance_size =3D sizeof(AspeedPCIECfgState),=0A=
+        .class_init =3D aspeed_pcie_cfg_class_init,=0A=
+        .class_size =3D sizeof(AspeedPCIECfgClass),=0A=
+    },=0A=
+    {=0A=
+        .name       =3D TYPE_ASPEED_PCIE_PHY,=0A=
+        .parent     =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedPCIEPhyState),=0A=
+        .class_init =3D aspeed_pcie_phy_class_init,=0A=
+        .class_size =3D sizeof(AspeedPCIEPhyClass),=0A=
+    },=0A=
+    {=0A=
+        .name       =3D TYPE_ASPEED_2700_PCIE_PHY,=0A=
+        .parent     =3D TYPE_ASPEED_PCIE_PHY,=0A=
+        .class_init =3D aspeed_2700_pcie_phy_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_PCIE_CFG,=0A=
+        .parent =3D TYPE_ASPEED_PCIE_CFG,=0A=
+        .class_init =3D aspeed_2700_pcie_cfg_class_init,=0A=
+    }=0A=
 =0A=
-static void aspeed_pcie_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_pcie_rc_info);=0A=
-    type_register_static(&aspeed_pcie_root_port_info);=0A=
-    type_register_static(&aspeed_pcie_cfg_info);=0A=
-    type_register_static(&aspeed_2700_pcie_cfg_info);=0A=
-    type_register_static(&aspeed_pcie_phy_info);=0A=
-    type_register_static(&aspeed_2700_pcie_phy_info);=0A=
-}=0A=
+};=0A=
 =0A=
-type_init(aspeed_pcie_register_types);=0A=
+DEFINE_TYPES(aspeed_pcie_types)=0A=
 =0A=
-- =0A=
2.43.0=0A=

