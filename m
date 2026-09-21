Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3356BC982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8X40-0005YG-0N; Mon, 21 Sep 2026 01:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x8X3w-0005Xv-Uo
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:59:37 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x8X3u-0004Qt-Ne
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1789970374; x=1821506374;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=bLe4GEMoR/rCu1zOoLffRAls+mLqHEWGXIut4ASgCkc=;
 b=DjO/kq37+qUgUxvG9v2QbKQ+0GxxvWa4DDBNi82WEiBRCKbCXJf7/YeK
 I26oTfAjs+WRAu0b9GikuJaiSr8OgZiRaSTaqLseplnDXNhKUw78X51pw
 Yn63MQWCMSIdFSieTtpj7IEYVVZ48R/P0mwfAj1VtkhOFGeGVLT6ysWTh
 mw18OeA2JOmKTgkirt8a2t/dne0W/xlxZ9MpwXT8vhcskFuN7p9gUHM18
 enWaXKy/rLjTM78J6ulkDpky431QHuLzm5ochFt/zPLuqgSUeYC1UOp74
 GtqSADmWWa70aiCxSnNYXVTVx8tMOCk5jBfHsEar53YWq2oDVipPbY0D3 w==;
X-CSE-ConnectionGUID: Z1wRLCk5QgCdew3kJxGBRQ==
X-CSE-MsgGUID: F8SS1qcUQqCpYCvSoEPPlA==
IronPort-SDR: 6ab0c7be_ADfshNMyFIUgLag7Fd+8s92ll7OjuceojPa92bffK7hqU92
 Q8GNvhk9OL4FFlZVOlRI/V0/0C8kn0guYluYq0w==
X-IronPort-AV: E=Sophos;i="6.27,114,1787004000"; d="scan'208";a="48807223"
X-MGA-submission: =?us-ascii?q?MDGX8bSAnm8k/CrWRgwxpM+NHBYksRugTGrLY5?=
 =?us-ascii?q?00ruRp/8t3LfrpwTdRrfhpL9maH1ril7ojZiF1Rswkfb7zrvXY4OcCA7?=
 =?us-ascii?q?rO+8RSCpVowsAW9Re1V8VRSYwKAp/cFRb059Oj1eLcl6F824j43mLuqS?=
 =?us-ascii?q?SjPvBKPijXdqvzqGFhomjtNg=3D=3D?=
Received: from mail-norwayeastazon11013014.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.14])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Sep 2026 07:59:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dwyg5mSoS1N/P2mF6/YzhpbE7uu90emhUdt+JodT8h0kKauC0Th/0ydXTvu4gTCzUB5SZn0cajFLLHMApwGeidb1ZUiZj5rI6uwyYDcjiVHcbsjYScfu8HChP21DRH8ISUWpwMImHRR/VcPck8mR2SOZNO3k9hk7XxYLywElPZZb9KniDUqIW0AjX+awajqj/fh2OYxBxVeCh1wLrVc8eHQw/asjQ/jRK+N3XiQxHTh1mCpZxeXnRiCOsNqLnApc3u5SdS21sn8YG7S18WBmyVrrWEuju4ogTind7IOP0wSXWiXZ/bnyoGG2olkfR2IrusGcvmlSQ3mgiVd5iVpFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VpBdK+jqo2JfHOcrY8gSE5dDs6mXVeyOgFmhhR8Jns=;
 b=Nxi5SpwcscPaskxk76s2Bs4m6BOUq8VS8ixcID/kkPsnRtMTiTaz4pjqa5ND/gmhBFvxxfTAowjq+wTH/0icZD6Erb9wogWt0JrKqlNX9zFq2aF/KOp6KYRvy7rlNm8ZRoIZ0O86/ApYv92jFMfcr2d6gB+ZAqA/edKsWLGNNmL0HU9tZZRvtOB0rVXZFhoppWQAt8Wax8ZJrnj6IsXTnenfZ/xB14JHwhNrx0jiHUKFKhUfXVVpCHBeaMiHJgVO6/1g8FSbkrYRSsMbvr+xd3FGBxK63PkPBIgH6pdLNEPdPFzoCCvU0fmfgtNG++waXY8i/O6IOmz9RXdEuwQOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by BR0PR07MB684783.eurprd07.prod.outlook.com (2603:10a6:2c8:50::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 05:59:23 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:59:23 +0000
From: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "odaki@rsg.ci.i.u-tokyo.ac.jp"
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?=
 <clement.mathieu--drif@bull.com>
Subject: [PATCH] pcie_sriov: Avoid capability structure overflow in PF reset
Thread-Topic: [PATCH] pcie_sriov: Avoid capability structure overflow in PF
 reset
Thread-Index: AQHdSY5ZcmZDGZMVw0GjF8dGChIOEA==
Date: Mon, 21 Sep 2026 05:59:23 +0000
Message-ID: <20260921055917.715685-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|BR0PR07MB684783:EE_
x-ms-office365-filtering-correlation-id: b37686e2-ee80-48cf-bc61-08df17a57c72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|10067099003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: BVvOhnYJd6KPkvnUsImWEkGOZD6unRu7vg8MGBerGw+ES2P4iU2cHZezYc4KBXvwnJns3jL+QkpKvn+37GRFZxvzT13h7DAlivR/uch2FZ8L+65E3/3+idXKksnteSkEaf51s11HV0fxUrYyHRA3REALUgaRSsMaNZRyiIROZyc+FFaSn+eFRPpCdptQM7p2vneef7L0LbSKBcpXrKyTYF6aego89TNoHS9x2Tr7ee4+6I3qFKOJfjG/hnbmMrbyJCHZCXmA3nuHrZdm05aZtwy6HmBR9Gjr8xTmslvhOX57a8q4W8JS1jV5GB+t+xqrnUH9EVrbrEe3mwGRSekQsS+xr/cj0w/TF7Ao+s87SFp67uXXJGxzRVqzTYyD6bBg68NX1oRgleQXDej6fcSnRpYy4KbfgwgIx8xMuzgbNfqNBe28NQUYNugcR92hJs3tr4nJ6VSPACmzi+5iRecDcHVEFp5XHQ2b/tsyIdvlOUllq6A6X0Fgqr0ys1fGOxeFE0bT4+zwcFAV7ar9XcwzyjnxWuOW11bf/AAp+DYGtibgPCKymPVhvIbV3tYMG7cG+VuFtaHX/d/BdLoOEY6sp7yj2SRsJItisOsAdn3390XClggsVyT9VZhoLF6OwwJZBjbBZZMZUEJr6xfhQ9X75MGm2UrqIKlDLE6Xz1KEXumSRqmQlaccJyxwot9hIf9iXhF9nlBbB0gH+gX7Yx00tyYhd8lYjP/nZAtpko0OC7E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Nxn4TzS6fwgvUjdSpKISxD7DUM17qAwBYR8RYovtCfnPT2OW9CtTesvGWq?=
 =?iso-8859-1?Q?6f8iwdiQIya84XwxzBunSAqOxFlxOh5z9NXfjaTPWD1uirhMXaob0i0B7F?=
 =?iso-8859-1?Q?dhDMa77jQ1OLh5NyEYQDCGKKQX7ZQivYFomNLyXbXq0Mn9N4OdQajFQ84A?=
 =?iso-8859-1?Q?mizb6WkECl4yiSlbB8HsRz3YoJFeYiAVjjBX7jNXn3RalXXseKB1mRwe9d?=
 =?iso-8859-1?Q?nEKwg+25LV+YdoY/6qLfFDCxHfq16wHA86B1Hwqswci9HQYSaz0ZwaBnNG?=
 =?iso-8859-1?Q?lwgT+B5wmq3U1lIGD6SadNTMsAe384YX0ANAaHvpl1LccVUdGh0/zmVNUB?=
 =?iso-8859-1?Q?OU9mQ4QU3GE5sij9u/Eqs9AEY+EU2k6f/JTYusmRHzqDXRF+npLguKpIJ2?=
 =?iso-8859-1?Q?fqRvZ7agEqEqT6s+6IABXQb1AWGq2wH+R6uFXWF5dfz7DFk5ubg69l5uWG?=
 =?iso-8859-1?Q?xPPG7FCYsvr6ng7s5Qx25TR+Vtj0ZsiG/LqbTuxkMmwXcQw9kt4E5+GMHk?=
 =?iso-8859-1?Q?Z0c4WQk1paV3KSMkd6NwEz2MqzasRbvFAaNXqvv02JJV4N6n1u38FHrqjK?=
 =?iso-8859-1?Q?fdWEdQ5aWUOL10zB6SCETbd9dfnF241R/8cmaPe5v8EjH96NUQTL+Y47vA?=
 =?iso-8859-1?Q?+GRFCJHmXRtgFNJqD7Rd8M+iiNikmf00cldiN1v2ziGRoFr/NT4Hp1UB4W?=
 =?iso-8859-1?Q?kX+hQMt0ArYZ1m0pDWkSTdevaF5eP4LkHyMi4bQpe5iEk0Jp3oYhU6WKQX?=
 =?iso-8859-1?Q?HE0h2tNPowpFVV8jKuV6vCzGMhVi3TcE1QfLtvnxp5QOXNRdy9JDves73X?=
 =?iso-8859-1?Q?KCUPSc9di96BRwk/W0T64dViOMW/d13WIWGHhbMHKzxEjAkfIdQMGsbadI?=
 =?iso-8859-1?Q?PG6Ca/3bn3bCmIE10/aHnqniCiU/Hk6vsl3M7UpJEeaftz5c42wp7Shea3?=
 =?iso-8859-1?Q?+GlpZ5PmEpgwO9oxDNnQA8BcHN8HurRC/xdh6B6sEsyqZWPyCOh2Tll30w?=
 =?iso-8859-1?Q?dKhG4nzDv5+vMATt49C6iSckDtDwRPAenyk7CrYLtSw0bvedk/BAjOhLvd?=
 =?iso-8859-1?Q?maZzh9Kzg1WBvG3C6KgMfVSDlKZCFSCSGAOSM2wGMWWPIO5m8QEURuVJGP?=
 =?iso-8859-1?Q?8WaaSiMF4EdIOXTdemhlEK+E3mSmmhtiSGis94LLCaPZfNGyURVvsNcfjU?=
 =?iso-8859-1?Q?YgxlpQgq5SIrRy+zMghXfwpsIUZk+feuDnUr5jDWRbbp92yqkd53hOzt8E?=
 =?iso-8859-1?Q?o5RtFM8ArDO3o77qE0w9hxAm+fBjj8In6bBkpRLUPDq1Bq+4NVOuiy2NS7?=
 =?iso-8859-1?Q?1CvdTkmSj739tXSaCQxZ4FiB5VrUgm9X3CjExMiCBxkb4/RrnbgMALpsqe?=
 =?iso-8859-1?Q?2YpMDORN0ZHKfgBQko9f+MstMOAh7DDsW5EGQhiByl//Fj5sKvowLJdbCz?=
 =?iso-8859-1?Q?1wrdBMPX3oxxPHhABVW74UEieneHtCtoHUMVsiL9loc1u+KRZCIGC/Ipvu?=
 =?iso-8859-1?Q?8BazCqg3szNTfWFhzFyecyf9l5UkcTozuXg5uQLCM6vuNa3hQ824AnaBRW?=
 =?iso-8859-1?Q?QiJEETX2aWzOQAi1j+pk3cV0zkAP2W+wge1Vd1BQgJ8Q0RsDTAobrjTiFi?=
 =?iso-8859-1?Q?guKkGNnaCMTebu1biTKrxZFvouw7YKoV9xefa8sKZ/Kg9iGfln6oBrF1tq?=
 =?iso-8859-1?Q?tCNYx4WquCN/WUGcw2AFnDFwX9ueN9uJ4KFQJ7UEdJwhP0+9e03SDJPP5F?=
 =?iso-8859-1?Q?W/IUPURnzZ8mKhGmlyLn2OOOjKx8+xoT6CJ98NFbix77Mgm7l6qg47+n3+?=
 =?iso-8859-1?Q?i4CN8Fn+VuJ9jYbUOA3PgpxQHfC/6FXfUorn8RxPcwiHbAblAUXc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t69BDD50zpPnbVYz3V2zibHgAamm50dk74KzpjNuJ2P0O7n+6heyslozgvfS+GVYUX9fKDP/LB0Ecku9suQI82nmccSDlJyTuLKDfygv+aJBvjkHwgR6uD36yu2bjhEbdhSLLaZ1WK/WsCgTuaEPezpKwwJP5dbVcUN/bpkSu3EADlvSji3iM2QC7vZS3DMkCcJI2xI2+wEJWFP61w9blWyoO1lLVv/4luUNm4KhieVAFIkwOk8FR6HzbgP/f+ZY2ea9CnUF0UEGeEcvSsKkVTsvnFN3Jm+EGIX3ocM3h+PMp9bqpqsOlap/iz8sFRNBgNYqnmGWkXjsQf6Cd56RpA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37686e2-ee80-48cf-bc61-08df17a57c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 05:59:23.4806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSFBSCNJ7YD0icIpuU9KdXs+Rt/u6jfnn9FLG4Y84mvIVZOw6mm5Jx9ywuX4qm32VVb217GOG96emtWGfz5PLcwiVFu3iONehAJJ4IBHGNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR07MB684783
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
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

The SR-IOV PCIe capability exposes 6 regions (no ROM), each with a
dedicated 32-bit configuration field. Fix the reset loop to write
32 bits instead of 64 bits and stop after PCI_SRIOV_NUM_BARS iterations.

As a side effect of this change, update PCIESriovPF::vf_bar_type
to match the number of regions exposed by SR-IOV and rework the
associated assert statements.

Fixes: c8bc4db403e1 ("pcie_sriov: Reset SR-IOV extended capability")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
---
 hw/pci/pcie_sriov.c         | 9 +++++----
 include/hw/pci/pcie_sriov.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index c41ac95bee..df61f281ea 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -229,8 +229,7 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int regi=
on_num,
=20
     assert(sriov_cap > 0);
     assert(region_num >=3D 0);
-    assert(region_num < PCI_NUM_REGIONS);
-    assert(region_num !=3D PCI_ROM_SLOT);
+    assert(region_num < PCI_SRIOV_NUM_BARS);
=20
     wmask =3D ~(size - 1);
     addr =3D sriov_cap + PCI_SRIOV_BAR + region_num * 4;
@@ -344,6 +343,8 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDev=
ice *dev,
     dev->exp.sriov_pf.vf =3D vfs;
     dev->exp.sriov_pf.vf_user_created =3D true;
=20
+    assert(vfs[0]->io_regions[PCI_ROM_SLOT].size =3D=3D 0);
+
     for (i =3D 0; i < PCI_NUM_REGIONS; i++) {
         PCIIORegion *region =3D &vfs[0]->io_regions[i];
=20
@@ -463,8 +464,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
      */
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
=20
-    for (uint16_t i =3D 0; i < PCI_NUM_REGIONS; i++) {
-        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
+    for (uint16_t i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
+        pci_set_long(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
                      dev->exp.sriov_pf.vf_bar_type[i]);
     }
 }
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index b0ea6a62c7..5f81e3b1bb 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -16,7 +16,7 @@
 #include "hw/pci/pci.h"
=20
 typedef struct PCIESriovPF {
-    uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar =
*/
+    uint8_t vf_bar_type[PCI_SRIOV_NUM_BARS];   /* Store type for each VF b=
ar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
     bool vf_user_created; /* If VFs are created by user */
 } PCIESriovPF;
--=20
2.55.0

