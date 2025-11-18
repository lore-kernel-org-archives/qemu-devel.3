Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F74CEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXn-0008EC-1f; Tue, 18 Nov 2025 03:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXl-0008DB-Ru; Tue, 18 Nov 2025 03:58:33 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXk-0003Vy-Gm; Tue, 18 Nov 2025 03:58:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPQw6LYinR4/JnQUN9ZjJfKVZemheLR7Xz4WDNwOWvJ9ILNNI3gR9TwPGUi3WuU8FKcI/vP7Yp0KzfpmBAzBTXP3IE3SPdefX217YYEjdhqmbh2ot3xORPMXJjvAPanjmK3cONAnoFhbIFLvCyo5RxDwgvG8Oe9Kcw2iulsG8d12q3WhaCXmY8R9039GtiraEeC4cq85qmTo6nstpoM1TDsLt5fviYUQ8GIfJpVus/atrSTUZcuyl7W+6KSJzpTYefMEyVXipyVjQTGbWUYWwLGUiGoW4PFZOdKDmOoKg+YIWhXXDn2U2TLz55oFUvaj0x35Imx/KugUFmkiz6tG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksIeetRZ3Mvf38H2ffdYm4vS0vWAgZzhy6QHP28h1lM=;
 b=IIbSHfJ176pkdGiY2W+xNDuQA02lu3Reszvn078dAkx1vQqRzeCSx/6Ot+hkYwRnqzaGnJ8qHK5SLng1D1+UeGqT5pr/wjJ5gd4Juo8Ezfaw1gqKlVl5PBizsMCxDR1VC/atjQonq74XgbYuRqSZRDePAlnQl0T1X2xKCxpVTAXn9ZYr1hhls1VxnufqXfKP1HuWSZRpiYixOzK8jhM8fmbscCG9T2bkG2Ncw6mlVeam5BkSlFA9LKE4dYY8X6347WhAbqBTA8ZUIA02BGHK40oNW4vcLWB6otr3I00sgG3eA83xhyqnbBhNUtv73bfItmtBLyjWXcgo+oWfJzuYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksIeetRZ3Mvf38H2ffdYm4vS0vWAgZzhy6QHP28h1lM=;
 b=uTaW9X83HiNB3JMs8wC61M9RFZ/5QiDlDHjAx2TxCDanTeImXrxwxk2idi6CgF+sqP0KE0JUeZI6Yp9SfjUoPSimwgmmhY7wZZ7XZBeYqPGP9ZY4SwzgkNyj9zjsd3nSmACKsHMO2TG6KUfenJfNQaxEIBUlJ6A4LkOiVlphW6pXfUGkCkOl4Xz8BNtBH0pRF8Wr7suvzMaZUQb2uTnzd3oGpqLex5zByVg26JYJPdiJ3qzoVBYZbeV74NZozGbIC5q+xIJlXTmzW03T9W2wVB9n6wLfnwKoe269jvi3iYn7tP6mHOfy/Mk3vyZMRA9bfUUqVWsP1sb+xBzRLTPEzA==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:12 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:12 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v14 12/14] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v14 12/14] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcWGl2fTbomma4bUiqerZUl2tRcA==
Date: Tue, 18 Nov 2025 08:58:10 +0000
Message-ID: <20251118085758.3996513-13-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: cf955185-4ce2-44a8-b29c-08de26809a8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QbsWdj9WXgMVi3tc6sMIujQZXPwXOjqKg50tcZcsfhQhx48dH09i4o5KXD?=
 =?iso-8859-1?Q?xV3KryT/+OaOvqrJ+Tc2okWtQKTYwFKRIz10aQy18Q+idyDzbKwfo+iznx?=
 =?iso-8859-1?Q?9F808+QfMFtYoFVI7KKX1rf/63QcvqmqBtPYaImsHqpQ61h9qhFl+BBs0I?=
 =?iso-8859-1?Q?oCXI7yyMwwTt9B7UIiGnbyxy3zNLSK/raIEtVMBzkjhlO7Y4MBp9RjtKSa?=
 =?iso-8859-1?Q?OhaYamuQMZPA+oLTL5NfG1DWB9hKaeeFNY9QkMECeUe4UWM/v8sRgqCu9Z?=
 =?iso-8859-1?Q?uboqLK0AqxAbvI1myA12LXUy9JgANzsaHolLStva3jNx8XKqcqYPVDOwdr?=
 =?iso-8859-1?Q?i/wWV88V+zZHO5zdU0OkoFaQ1o92gQTVnz0STi+wjnj53QrmDo6ldiJnRD?=
 =?iso-8859-1?Q?GTaxeq3Uv/a8F/BtUEd6ZNOE852EG7pdnbtyQQBC8sqY2kBzuHUO0jvIWR?=
 =?iso-8859-1?Q?ETTOSvTRQh2I2yyZ4OpRMwMITHSQVwHU8rMutMnjPcUcruq0MkJzo+jhqn?=
 =?iso-8859-1?Q?LlduHl7xS3Qmxq44g1hZSYAL1gseUpnlVqGz9HwffdJ/JRSgrVf6SGqjui?=
 =?iso-8859-1?Q?xY31msjqPw9jBk9PUKoMArY8DKSO0kXu3ae6xNuqcHwYlV0Osb4xokHfAU?=
 =?iso-8859-1?Q?0V0KdsGGpkBqUBNFi0jadX+WwXlpEbLH04Uy1w64HM/wU4t+N95RqY2CtF?=
 =?iso-8859-1?Q?HECVTWnkXwzW/bsGV/ULavT9oISJ8t+uXau2SrEauqdyG9r1pxcY6QZq/K?=
 =?iso-8859-1?Q?Aw1NO5BWhq16+/fZmLSnX6DPR8thLz9ISsrCeMByuTjNtc9lKIlvSLla3a?=
 =?iso-8859-1?Q?/+H3C1CFfAy8rc4R3s/EY1cTyJeWueopIN1DplzYycfjOmdyV2Kak2ia76?=
 =?iso-8859-1?Q?iT4fOmYwwuc3nKUbAJVKP5MF7oFP1+I3etbhyNpxPO3c9aOyOYlIT9bI8n?=
 =?iso-8859-1?Q?68wjGOqqPypUf1Md+H7OrOI2dGNzCKuwkSSP8Zfh6CNZJ1j5on1ay+PotK?=
 =?iso-8859-1?Q?c1NHF9sqGXiISzK4Bixg7Ael0rEOOctjHF31Cd8GgiBA6quQlG9XGmroiW?=
 =?iso-8859-1?Q?YNq7wCUBexAXCbfTF4bajTNASrYmJc2xuG7r/mOBxKpg6H7h5TwACvA3PY?=
 =?iso-8859-1?Q?jbvr9CowyoZHmQRuPOM2XjSaiaeOJlhHOCiP1kquMamnmRYLBhlOV4ohtP?=
 =?iso-8859-1?Q?KPPmFOrImIhNU1V7WyQuFAVzQuh4g/UWadaq3s8FrnciRZA79uW83hDof8?=
 =?iso-8859-1?Q?uFpr4gt8zYCrlMsU4EDY071164fllD2thOpPN8VuMR23fx/qrgZF+Cizhc?=
 =?iso-8859-1?Q?wFhSW1UQ/16TBaJXS64RsKd+pijFmwycJWt9H7dJVoZj/2clWbVFUuLzDm?=
 =?iso-8859-1?Q?G7YvFHNv7hxfSWwAvgIe7z2CsEJGldtHb8mrtnZSAd3vc6FP3KNIxmdHOP?=
 =?iso-8859-1?Q?seoQ+ZwQFdD5TEpTAMOaUDxNIOP7/8U4+nhUvD2YuQLLhj31HoooQBqhRt?=
 =?iso-8859-1?Q?9DWJZn+XHlPr7UYgsaH+iFN6f5rp8NiAnTvQjXi2onfTclcHVsKXDTN404?=
 =?iso-8859-1?Q?QCAYKvphYrP1etIhJPtJlNAuaJgA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dbN75mAOMSwGswKmARtBKxLjhtBY3KXB7WKBCpnzVO5GZruNuH44Mw4XZt?=
 =?iso-8859-1?Q?e0pzwMzt1+GL7N24m07ulUoL0LTcgwTHRkl+Gt5eFhSbJs97xkeWOALfCe?=
 =?iso-8859-1?Q?AKHwjlEHhFi2KBIuO176YZiqfxjn3wdXBuMHCLTGq0rRUSm7pZLpxvSU34?=
 =?iso-8859-1?Q?LitBRyElBd8DofDdOL8gNtBAtKXG6hlqolCKsz2c7eEXbXOS+XX5sdvOa+?=
 =?iso-8859-1?Q?ztVxk3ARHANfrFygq1H4tzf0jVn+qBwDl80dvsMTKf+2ghJ/8kl4K3ywAY?=
 =?iso-8859-1?Q?74brCbb3foE8/6su17eCNR6+F9VOpzdkONwslLAgu5XM6xknk7n2R8G2+w?=
 =?iso-8859-1?Q?jTbU6YtfuZcA1QLtimqiJ/SDi44WFMCtKz6rCxFNsa3py3wju2pxDg8IKq?=
 =?iso-8859-1?Q?8ybL9+ZaXCKBOLroaK1N6ol8RcKeAwkIyTa4uJkPQCTr8i464rO/GhptTL?=
 =?iso-8859-1?Q?HwJZtt59UGIKqPCghMF5NVEHDdvSfUyPnXNQjmUCMsdftGu9DJoAGydqY5?=
 =?iso-8859-1?Q?0lEGmGaJxqvoKhkxR/BSjYqX0JzJClZlZsYD5skhaMvW0pFTPDfHOf+21e?=
 =?iso-8859-1?Q?ZEtp0ld6K/yjatsbi1SabO3ShbKOm0cpoXsUleposb0hEsxcxd5smc6Abb?=
 =?iso-8859-1?Q?0nhEpl6QINTDDimLzqfT+pjwUxUw6XS2mFf+m+Lc9EEQhV2L1loYqUJBJC?=
 =?iso-8859-1?Q?IiCzGXcQAtzsqWKqDh3U0jr7vB1rFMQzN5rroLDm7eXz2N4+JoWS9lLi1F?=
 =?iso-8859-1?Q?4UHWbsXvWvu1Q2kV06/yL22eiiQ25/RCUuziXRFbR2M06EJJyabhqrY2qQ?=
 =?iso-8859-1?Q?Oh2SG4+hqm7DXgyAs1mcOESkcXnaNJtjRCRhjHC0gbeISW1NgfcxSYAWx+?=
 =?iso-8859-1?Q?guqL/I/bhylHcQM/Mxkvm/2CK19AQOsHKcV9L0duTt0j306ubT8ZfokQ8K?=
 =?iso-8859-1?Q?iq41H9YbsHt3UYKESRghPfz178T1mxfAVfTsddUK5gV4t6ApscyvtVjGF6?=
 =?iso-8859-1?Q?T83F+sjN3k2HMGCFCwhpNUmgyEHytRMS3kOd8urRGHfKzBqWjhMmBgF0xG?=
 =?iso-8859-1?Q?aCPPRK6lhoSu5xpMOpdyJ6PdLTckBDxjw87yEyix1NDthvnz32TjwQ2B9c?=
 =?iso-8859-1?Q?jyNajrMfmqQpqiWwH5omk4dMveGXLJU+Cca0I0DAvN9rPRjIIoBmCHbZI6?=
 =?iso-8859-1?Q?7vFKE0XbMt0ut5yZbg7PuEbyU5WGkzrF5Wf1RJd78wv3cl5jFu4BYpmCfg?=
 =?iso-8859-1?Q?3oy1z4OZuRrcrrGyymS0mTjSppCpUyiZsMqilO2mNYLYkcDWm1VMmxxR5F?=
 =?iso-8859-1?Q?ugw5nCf7JZchW2n8djh6jIXa/Dz4R21d+yEFGzLLGxrY5G9yCRuK8u8EdH?=
 =?iso-8859-1?Q?vW3r2iolFt+VdUGCFD2h4kc3KnvBKL3dYUI9eR73DhW+dAeOBsksFyklkQ?=
 =?iso-8859-1?Q?GcrnIRVot+2U2595067PbJRQGY+VsSMIE6K99YjsEGiJ3/eGtITOwK7me3?=
 =?iso-8859-1?Q?nqoFlNX1E2WMAO6yg9WKcAGSmcHjTJGlKqf7ZPltQoZ7rFv84s0KRvSYg2?=
 =?iso-8859-1?Q?4aJjm+Nf0CuyRVhjeklOryggiiF/JjgNI+1fx3EvEKVKhTmw9/w4VEi/xd?=
 =?iso-8859-1?Q?6xwBoJvFgo+gTkhb4A/dEmIYtRZtcUJ/kswdD9BsD5MuuDA6XD752kAG6H?=
 =?iso-8859-1?Q?bHaQ1nI//Y91nmsAHd8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf955185-4ce2-44a8-b29c-08de26809a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:10.4650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKV3nlksmQpCcm3OrYBS4nv829sAIwlMga4+8DYp0tWBMRYIDL8hE2e+nl8p8N3IE+e7s0QLCRjw0Vf6StCcwzO/w9bowhP1MMavew3/re0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 7d8b91ef04..44be6e03d3 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -424,6 +424,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
--=20
2.34.1

