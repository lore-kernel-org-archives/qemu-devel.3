Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D1AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28n4-0006bD-Ld; Thu, 03 Sep 2026 10:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x28n0-0006a1-85
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:51:44 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x28mt-0000V6-Ei
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1788447095; x=1819983095;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=8RFzs8pOhgA9LNnoLFdhXsINHirw30x+KZqjMxgxftY=;
 b=HCN7aleKAOXgiGnAC1nbIaXy8S5p93QjU4SwsSQC2PHWFFycgCKWWL7b
 nQWN8iP192+S2x0tPPXkFQvb2tOlpok+0ehRYvMubI4bYzD4yYSr50cUs
 C3mQlFhlz1VcIOfVJgLOUtfmUllJgI9AME98B9dWDvlR1Ccu4XYe4rAMC
 LMFwOJsOPiYDzEAue9LDXN09dnFmlPp33q3AYmcP/0b2Qpi+/G6eoloCr
 l+WiYC4kBKv414QuzC6xmX4HHCy3ARLxIBaBUTshEE5uy7H9cz7NXwUvS
 umAutvGN1Bdjuwjvo9U8MMeuHJ6gKH3+gt28C8X9rznq1FcUzuqKsMsEy Q==;
X-CSE-ConnectionGUID: PD9unpwWRcq75TxvKFIPYQ==
X-CSE-MsgGUID: uUrJkxkCR+WqeAdrjiJimg==
IronPort-SDR: 6a99896a_K0YD2+To5a80RJFIpGDqzYnNxLGhd8r4SxTDVO3tQyc49Ye
 DgLAWQ1cXfkxAMi/t+E+2EW21NQY5qoiXtpoS9A==
X-IronPort-AV: E=Sophos;i="6.25,260,1779141600"; d="scan'208";a="48698900"
X-MGA-submission: =?us-ascii?q?MDH1PYpLgFmnsEkqe4tvHJtk8uPtiiT3/K7emL?=
 =?us-ascii?q?Xk2vWz+04iUyCEIvubuWJ5Rudh9xmVdh5Atw9M7fJznyPaJurwcQ2cRV?=
 =?us-ascii?q?wi55laGq0OhbLGiK2OoLzoPU5ylygF2fyrekxLJPjnGBUv/Ul3lbQ81I?=
 =?us-ascii?q?va81T866S4bZDyGBAgqynZVA=3D=3D?=
Received: from mail-northeuropeazon11010003.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.3])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 03 Sep 2026 16:51:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNIncY7Nfb2jHgYmqYtUJqFk8OmZq+YyHOiDXJMgRWx6i9q2p/05YeBIjqprmf9o79BuZQYhu/O0xjfIQyD2bIAWOwSE/YjiHaaD3TBAjy3FEVwbALpkRCwAuavpbZGRBR6zpsfa9iA0XYOfb5ySvJS3pt4NRNkelCB6YNd80nJKz2QLaObQcBnz0Sd8CB+pp9u/MAnSA/TxAmSMNYwRjpCjal+xAUqZZzjzDGVNpaa+FTOoWiUJyA7vZNB6hZaTYNQl43tZxUnVmwmqdvRlwnIV+wt4yBxyyCBrFANgZvulLy243J0ty9J3xnq9fhbfTyiVLfyjvWWfPacod2VAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjJ/ynesjNuNMIaXONpWrLNWVVEgzBvE1t0FIh/sS2Y=;
 b=MMCqJeJd1Gtv1Y8ejpvkX5zCWtjh8R33xuC/kVdQGcvxlwkDvmU+4Yn897AuvmsxmRAUzmLn5N0WW4mFByE8g3hg+yCRv0d7P7Llhn6ulkZ833Qq7xx9d+lLypb6bIKcUAACmrQcmqb1mUmY1MaeQ16zxSKAN/blfD9btFtgZpKudiDhSjZcUYaxNIwwzeKSA7yUcNu6q1sx/raT1WkK0ekklfv67JQEjHHriFQ2s7RTWz+nnnA3ily5RJJLNp0kd3shS6mRYH9zA/mjAHF8iXd0n3wE51phLxno7wh3AE+AKGx0ZrtF557MYYsy/ycwWOB/T8UbgTA9Vgj0wC8/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVUPR07MB11784.eurprd07.prod.outlook.com (2603:10a6:150:32e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 14:51:15 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 14:51:15 +0000
From: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?=
 <clement.mathieu--drif@bull.com>
Subject: [PATCH v1] intel_iommu: Support concurrent page fault handling with
 PRI
Thread-Topic: [PATCH v1] intel_iommu: Support concurrent page fault handling
 with PRI
Thread-Index: AQHdO7Orx/6HOHEK7kiJZZLQqCFugA==
Date: Thu, 3 Sep 2026 14:51:15 +0000
Message-ID: <20260903145044.2245609-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVUPR07MB11784:EE_
x-ms-office365-filtering-correlation-id: 85f6f79f-b159-4f16-a6d9-08df09cacdf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|3023799007|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: u7QvivOZyHP3Dj2MHd+AEdnUZDSc1dEs65JbrF0TxOwT6ZWonpA3NfR41gvLOPAp3sJOkOwW2m7Dikm2ddkN20SjsBerKlJzNboIR6w9jIhkmJRN74rF1kM7vrT7b7u29guEQlWXDzc1BkFDreBiBQIvH/KoDC1CuzFNnT7hiNsNuuiIyVdS2JpOxbN+NY3bVtnVUGrpbrojfw2Hgq9Z/qXoQcjV0CQuz1UBa/0R9vaLjrT5KRi62cHwAbuPqpnc7qZ0d+VYNSRcnhGicRveBMKzmjK/1FyF+2RpOYBNiRMmFI5kAEGnqV6BqS/2PRLbe5AkxstARc6/F54C/ltwqRlbj5bgYqI4YFx0vUin0Y+OZNtODRG03atqaS/lURcJckJ3a5ym8YTR/1bco7LMIiPr1TxHPuNvkUaGrJbI+3/IRol7RlJwwqQl6SQE/RKLPuNAMX+Be/bhyd0D9dx5utxltVBy3OwOHmJ+J3D/HtM91KKIjnoUixR99mIokNpGIi3JxViVtk2KvBMplHcMqmehCQ95AqEEEpOIbKcCWpG6baKxJfRTyGJ2d2uVeVC+ZAKIZhBrA8sN+DkZkVuEkcU/UWgXO2T62BWK00KKFdDffbOMBl93HBc1rnfk+vrZXusHHE+Wu9O9HE9s5GUYXOboYN/BuEl+17Eo7YnZqSDmpNcoYJK59JI3BiL6QqvsUoL6a1AmHDfoTAHHVmkzUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WDSgQiWN8/9zJYeBm67u+EJBt8I24eSDHvFpaFGcJlJTIDUbGFPHeoIYGF?=
 =?iso-8859-1?Q?894WRV4+a8VcjI5pSx0vsF6HNpZlEgkplfwmjsCqNpaLL4TONRh1T1iweD?=
 =?iso-8859-1?Q?AsUcDdFzivbGun4NlfF9B8Kn0vMCdUbF8IRFqXtTdWHYeGvtxDeACQeV9t?=
 =?iso-8859-1?Q?wT13Nj0rfQX3WxdtYNTWs2MVTYnps/riSWlWhvWnulXto+hRuxT22fanek?=
 =?iso-8859-1?Q?tfm/DrVC+NMB8LGxyLL8XDjiPHu8cMI+mgXA4ixlgyqyTJG2mvFEJ8DdiO?=
 =?iso-8859-1?Q?cEJ4xuOi2zM4ect96kQRgOmc9xnDGsgO6QL/X2sxUWJHp5SYohCrTwHuUA?=
 =?iso-8859-1?Q?foKNDkoFBD64azgRwkWyrTnFPBnCPSa0c7vrgNC9NsrpzoxTUjD5vBS1Yi?=
 =?iso-8859-1?Q?MEqqW1e4ARmfMrJ/58M+qHK5NZdOAoHM1ecc6f/Al6XLQP6FanhvUTsFmU?=
 =?iso-8859-1?Q?f39vH67wE4IFmVVNgx8PdqoA3w0csTGUdyb0vr7bnihEh1hH9yFjR6dulq?=
 =?iso-8859-1?Q?BeUBVbjfFCDCQ+M0ipjLuebxOL20vC2p509JiJ04sk4L2hN7AOxP/8UEX9?=
 =?iso-8859-1?Q?bTc9eeRfl+MrBCO4H2bzjAkmJjRp2yqyspxfnXjfpcNJuSeGRCIVKREpeJ?=
 =?iso-8859-1?Q?DK+B8fijOUpyh3sGAQvihpP5a2bHdu3Tt9MvDZKEQ52qUgs3rBtBUt+J1m?=
 =?iso-8859-1?Q?OG8Vi36GO2FQ5LbXbNWeD5o2O2fmBl3iTNBB4B1BiONm4cci6MlRDaVrxF?=
 =?iso-8859-1?Q?XiRI5oHmTJ9VPmwATv2CALQOuHhexnFh3oc8V5QCqkEpjvZCtL83slioO6?=
 =?iso-8859-1?Q?Cnrk0j/NKf1Q9nnjZX30L6Km/bwHDkZO8+eFdb9/kNyOuqvikmv+d5kZCV?=
 =?iso-8859-1?Q?+ggur6WGE+gHwrvEkOc8V+Tk7F/bfNxOFSShw1jyds0Lk34KHt5CCB5AIY?=
 =?iso-8859-1?Q?XKeN7U0BkJPCH96kylVNzrz8Ort8e0/DGYZAMan6R0TiRG9GuY+01cI6Wz?=
 =?iso-8859-1?Q?gvfKtVF6H90yN5whMnpDFXSsVsTc3t+UzLcRdmX+dNuOGEVftkUknX1xnB?=
 =?iso-8859-1?Q?lSum8NpqaZ0UV24YPaZ7yoiwquOGvtNsdiI5JoMZt/1W7/2aUZUALFkTvI?=
 =?iso-8859-1?Q?Be15OALXzz/iFHT2iJSYPOVhgOC4TWn5G30C9rKUVBgqmEyrcj9hSQrdBl?=
 =?iso-8859-1?Q?QMrrAeTVphq7nUFfFiFhqMhUbMYwbtEjL9scNTwmc3HiI2Uy1CgHgdktql?=
 =?iso-8859-1?Q?lMUoH/Vj6eLPT8sTG7WkZCGHmMmgImkg6SvaqeykWpvZDZG0QlZhl/ZT60?=
 =?iso-8859-1?Q?M98UISQq586+kFO5U3mIIYDImTnmSX9vD6233B+htwFKGahXGb5oFbbzS7?=
 =?iso-8859-1?Q?1jo6YyQhrD+h6YEbCR8uE0d4xtCr4GhlYQz1aMV3o8nAXcekQ2xumlDOf7?=
 =?iso-8859-1?Q?jAs5dAcW2HjwRHfnIaoTaz9tvogUbBGzh9pvQrX38T8Iw2uDj6p95RlUZD?=
 =?iso-8859-1?Q?Yomwy3dMX19ox4stNk5GDTX2kiJ/sbUhH19Ct4Z89ZnpE5hvsIcxj3NfvH?=
 =?iso-8859-1?Q?GYXMvJJW/YS2GE7jjQrqB7/cTNVv+lqMZHrH4Q/7wadshqJHlvebiH9NN3?=
 =?iso-8859-1?Q?SnwGgfxiRVYmGonC9xhxfkNFWnbAMvmQT+hLP17NplPTECyzxi1q93/lFU?=
 =?iso-8859-1?Q?zx60U1wz8ph5JMoFhB0meD+yHHvjIHP5Ppjak95EBNCjLxi3SlY1Q0AoS9?=
 =?iso-8859-1?Q?oe4+LR5CE6NaswWZNE2Jo4eQozrV9wHE/7MsdFLgi9eCOG893CYa1VSpb7?=
 =?iso-8859-1?Q?OnGQu1KhNvZxlWmtzm83JKKhUUWoM7FOrDcYdHmESjtnILAnT61H?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B/G43GP9cB0+9MOI7jdBW7LH8y3JdenH6BXydXFf3exuGQOmwiK9/bTuSCPTZ6fs0smurwUTWBcfFc6+riisEVV/h+uuuArjDRkt/Xqxw+QJd2FiZoRdQmDHMJiJHUO2guNdUX0zrP5Y0Ipmmj7nQSnMIryDaE9gnLkjEETKGqSxFmp+I2+PTegbfYWpyP5xJXB0BK3kJPIM2+LtBhaXMqi2sY6zPpraXFCpCtQq/9pnPBtjXID9B82PbIIYZJbpMjyQVH3MoyWnAn75Gw5cIpmww/7CiBSc1rrwfwSj1dB+meTUeT4CKYMWeUIXnNAWnbmq5P1fsQjdser8J+DHQA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f6f79f-b159-4f16-a6d9-08df09cacdf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 14:51:15.2710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /mnTBrAODH14Jkn1LagU/iSHPgBypaR34c4yFBtdLV5Xvvq0AGeanq5ZEtIPRKYy50kgzATqbPzjckdGw8Js01FvL6iYaKpbhvbwWA3YrxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR07MB11784
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
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

PRQ slot allocation must be thread safe to avoid posting multiple
commands in the same slot so we take a lock in vtd_pri_request_page.

This allows multiple devices to call the page request interface
of the same iommu instance.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c | 91 +++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 34 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9f21622a4f..350d2b7753 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3627,15 +3627,26 @@ static void vtd_handle_iectl_write(IntelIOMMUState =
*s)
=20
 static void vtd_handle_prs_write(IntelIOMMUState *s)
 {
-    uint32_t prs =3D vtd_get_long_raw(s, DMAR_PRS_REG);
+    uint32_t prs;
+
+    vtd_iommu_lock(s);
+
+    prs =3D vtd_get_long_raw(s, DMAR_PRS_REG);
     if (!(prs & VTD_PR_STATUS_PPR) && !(prs & VTD_PR_STATUS_PRO)) {
         vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
     }
+
+    vtd_iommu_unlock(s);
 }
=20
 static void vtd_handle_pectl_write(IntelIOMMUState *s)
 {
-    uint32_t pectl =3D vtd_get_long_raw(s, DMAR_PECTL_REG);
+    uint32_t pectl;
+
+    vtd_iommu_lock(s);
+
+    pectl =3D vtd_get_long_raw(s, DMAR_PECTL_REG);
+
     if ((pectl & VTD_PR_PECTL_IP) && !(pectl & VTD_PR_PECTL_IM)) {
         /*
          * If IP field was 1 when software clears the IM field,
@@ -3644,6 +3655,8 @@ static void vtd_handle_pectl_write(IntelIOMMUState *s=
)
         vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
         vtd_generate_interrupt(s, DMAR_PEADDR_REG, DMAR_PEDATA_REG);
     }
+
+    vtd_iommu_unlock(s);
 }
=20
 static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
@@ -5378,19 +5391,18 @@ static int vtd_pri_request_page(PCIBus *bus, void *=
opaque, int devfn,
 {
     IntelIOMMUState *s =3D opaque;
     VTDAddressSpace *vtd_as;
+    uint64_t queue_addr_reg;
+    uint64_t queue_tail_offset_reg;
+    uint64_t new_queue_tail_offset;
+    uint64_t queue_head_offset_reg;
+    hwaddr queue_tail;
+    uint32_t old_pr_status;
+    uint16_t sid;
+    VTDPRDesc desc;
+    int ret =3D 0;
=20
     vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
-
-    uint64_t queue_addr_reg =3D vtd_get_quad(s, DMAR_PQA_REG);
-    uint64_t queue_tail_offset_reg =3D vtd_get_quad(s, DMAR_PQT_REG);
-    uint64_t new_queue_tail_offset =3D (
-                                (queue_tail_offset_reg + VTD_PQA_ENTRY_SIZ=
E) %
-                                (vtd_prq_size(s) * VTD_PQA_ENTRY_SIZE));
-    uint64_t queue_head_offset_reg =3D vtd_get_quad(s, DMAR_PQH_REG);
-    hwaddr queue_tail =3D (queue_addr_reg & VTD_PQA_ADDR) + queue_tail_off=
set_reg;
-    uint32_t old_pr_status =3D vtd_get_long(s, DMAR_PRS_REG);
-    uint16_t sid =3D PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn=
);
-    VTDPRDesc desc;
+    sid =3D PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
=20
     if (!(s->ecap & VTD_ECAP_PRS)) {
         return -EPERM;
@@ -5414,52 +5426,63 @@ static int vtd_pri_request_page(PCIBus *bus, void *=
opaque, int devfn,
         return -EPERM;
     }
=20
+    /* Prepare the descriptor */
+    desc.lo =3D VTD_PRD_TYPE | VTD_PRD_PP(true) | VTD_PRD_RID(sid) |
+              VTD_PRD_PASID(vtd_as->pasid) | VTD_PRD_PMR(priv_req);
+    desc.hi =3D VTD_PRD_RDR(is_read) | VTD_PRD_WRR(is_write) |
+              VTD_PRD_LPIG(lpig) | VTD_PRD_PRGI(prgi) | VTD_PRD_ADDR(addr)=
;
+
+    desc.lo =3D cpu_to_le64(desc.lo);
+    desc.hi =3D cpu_to_le64(desc.hi);
+
+    if (vtd_pri_perform_implicit_invalidation(vtd_as, addr)) {
+        return -EINVAL;
+    }
+
+    vtd_iommu_lock(s);
+
+    queue_addr_reg =3D vtd_get_quad(s, DMAR_PQA_REG);
+    queue_tail_offset_reg =3D vtd_get_quad(s, DMAR_PQT_REG);
+    new_queue_tail_offset =3D ((queue_tail_offset_reg + VTD_PQA_ENTRY_SIZE=
) %
+                            (vtd_prq_size(s) * VTD_PQA_ENTRY_SIZE));
+    queue_head_offset_reg =3D vtd_get_quad(s, DMAR_PQH_REG);
+    queue_tail =3D (queue_addr_reg & VTD_PQA_ADDR) + queue_tail_offset_reg=
;
+    old_pr_status =3D vtd_get_long(s, DMAR_PRS_REG);
+
     if (old_pr_status & VTD_PR_STATUS_PRO) {
         /*
          * No action is taken by hardware to report a fault
          * or generate an event
          */
-        return -ENOSPC;
+        ret =3D -ENOSPC;
+        goto out;
     }
=20
     /* Check for overflow */
     if (new_queue_tail_offset =3D=3D queue_head_offset_reg) {
         vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PRO);
         vtd_generate_page_request_event(s, old_pr_status);
-        return -ENOSPC;
-    }
-
-    if (vtd_pri_perform_implicit_invalidation(vtd_as, addr)) {
-        return -EINVAL;
+        ret =3D -ENOSPC;
+        goto out;
     }
=20
-    desc.lo =3D VTD_PRD_TYPE | VTD_PRD_PP(true) | VTD_PRD_RID(sid) |
-              VTD_PRD_PASID(vtd_as->pasid) | VTD_PRD_PMR(priv_req);
-    desc.hi =3D VTD_PRD_RDR(is_read) | VTD_PRD_WRR(is_write) |
-              VTD_PRD_LPIG(lpig) | VTD_PRD_PRGI(prgi) | VTD_PRD_ADDR(addr)=
;
-
-    desc.lo =3D cpu_to_le64(desc.lo);
-    desc.hi =3D cpu_to_le64(desc.hi);
     if (dma_memory_write(&address_space_memory, queue_tail, &desc, sizeof(=
desc),
                          MEMTXATTRS_UNSPECIFIED)) {
         error_report_once("IO error, the PQ tail cannot be updated");
-        return -EIO;
+        ret =3D -EIO;
+        goto out;
     }
=20
     /* increment the tail register and set the pending request bit */
     vtd_set_quad(s, DMAR_PQT_REG, new_queue_tail_offset);
-    /*
-     * read status again so that the kernel does not miss a request.
-     * in some cases, we can trigger an unecessary interrupt but this stra=
tegy
-     * drastically improves performance as we don't need to take a lock.
-     */
-    old_pr_status =3D vtd_get_long(s, DMAR_PRS_REG);
     if (!(old_pr_status & VTD_PR_STATUS_PPR)) {
         vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PPR);
         vtd_generate_page_request_event(s, old_pr_status);
     }
=20
-    return 0;
+out:
+    vtd_iommu_unlock(s);
+    return ret;
 }
=20
 static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
--=20
2.54.0

