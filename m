Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51F5CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dJS-0003np-Qj; Fri, 03 Oct 2025 06:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJQ-0003mm-0Y; Fri, 03 Oct 2025 06:46:56 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJ7-0007QF-9J; Fri, 03 Oct 2025 06:46:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGmhwed5uvB78fEUh7SduESCrDyeUDikYk+2pE/Bx0gym4PSvVDN7/c4kbJU78yL5HfMCS49iKkrAqkcT/UoXUl+RhgLlDWnXXBkWNALHQd/Zl6mamAtbfoCGS5NxIZoyneAYoKhQTR4mvAQS/a8sJtFSN246Zmz5hRAgid0ONwkar0Y8+zZyE9llJ3E7QPC0E8cNFvw5LUESvBH2BMcTRw/qEcOg7f7t5+BKFxWtRSOShlXo7BunDy0mK1lE0GyCQNxQI4s1K20/OPTzlD5TuFVJDrF2/uiIpkmsxEmG52Mkn93BsvdiL4mrL19PMJwEQdBObNecmGQ5nqhGlPXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnALfnlm/Vpkyi1mSgG82l415+049KVo4AON3Xp0OwA=;
 b=Wu1sEffDAgWX8QUy24g8gIXM0/XAi1G6r2y9oHN9YWypUkm5mAB4Vj03UxrS0faGFCyI9RatPybN97bPpeJPvj55Ke2lmXiiEHXeQcyuXCujHdBNNvWMmiOZnwAaNdYx7dMa8+qRDRe7X0btqPZ86Dp4WxhC4ko/SJBmQ+JNhyIOQXv4KemgibyAov47238WAKwhTFXvYtGsZyv8B03KgrQRibCuUL9HxAzzLwAjoQDfikV3bocSu8sOpGBaC2PXct7PYbfBvRmqk/tnORldFBItRF37Jmtlpkn28Z7ZCkkV2rNLzdYXPIF6Mj2fZmCKOc6gigBy8LzdqYvvjbqxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnALfnlm/Vpkyi1mSgG82l415+049KVo4AON3Xp0OwA=;
 b=p+OKACoNXNdhxLruKdr/JPt3N3VGuQnK44/rySdr/4mOn2qDEk7Iiwh1HjKNXJwob3c6Aev0rwb/Ev+VKmjq8FQZk7NKlw0Sk/hn1964UKaruhpDHaO8GSZ9HnJOQlYLuch9wSdhERXmEFZmBQTeL/wPkb0J1fNpcvk3ZFKtRmz+eLnpiPnk2eI/KrWubgRIk0a1N3CfRibmLscSO86uVd7cHjR9uYmh0xPJgTjiA4kwsO7a08gwp0R3AyyqYoz00iwu3/XHloi/bT65BLku1DZijjPKx1fGX/bprZPTT+asEAcNzYj/MhA/9T2RzvhUwHcGHsAYLu5Dzw6COamHgA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DU7PR09MB7941.eurprd09.prod.outlook.com (2603:10a6:10:5b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 10:45:26 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:26 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v10 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcNFLSpG7YvJc3AUmZqa66pEzviA==
Date: Fri, 3 Oct 2025 10:45:23 +0000
Message-ID: <20251003104443.51501-13-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DU7PR09MB7941:EE_
x-ms-office365-filtering-correlation-id: f4747120-64f1-4684-6b1d-08de0269f69b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TDP+X9GNKVVXqzsjpl7Ov54r6RW/l5ARaqOMgA59dhXQ/XhirJ92WFPHl6?=
 =?iso-8859-1?Q?tno7ReLfaMVuQBIHzMaWvg4sTBUzy3ldbpumS0Ud99vdLPOd9+9FZK5pGq?=
 =?iso-8859-1?Q?BwyetQ89hTlgMZeprsnfY9/F3Ex4kRMqOUKQhRvf/jMvGt4CvaMBYrbJ5X?=
 =?iso-8859-1?Q?tqmHoySgq/0wkfZwVDPXhnktxMS8ifJ+5oBeIMqBHFID5e1u330WxznYl2?=
 =?iso-8859-1?Q?rE51zd0oOEi85bGur/LhqK2rjplX8h2kupmtNlQZgl0wsbtt53b9pdv53y?=
 =?iso-8859-1?Q?g1m0qBrz0sCxrIRjrVhG5X2RxqoNc2XeLP+7Uq3j/Nje81XVMkbdNzrnTK?=
 =?iso-8859-1?Q?6ZgTE/0crah6f+ojSIWQnVKYXLb/Pdq0IwcYCiibUxnPuUBRienfwO7SCX?=
 =?iso-8859-1?Q?BHYEaJ/HjhZPQPu6vWY2eXtQSvF9GX4mwsl+OZn5kOsKwNwLpS54D8u8YU?=
 =?iso-8859-1?Q?Qpjr1RckSJDTTZHy53wxt+CuijNPHyEofTSvbbIst5tQNXNtPV/E6xejX5?=
 =?iso-8859-1?Q?YMSU7pR5b94Z2CrFcRvDndFlM6qRVDVGu+mslTijL4LmT07vFSLjZH1zuF?=
 =?iso-8859-1?Q?Rgi8c/0V590pXQZOXqdgAxDFOWcx2g194QR4b4uhn0IF8RMCZdQXChpqv0?=
 =?iso-8859-1?Q?1qS94pqP5UOEelRaAcBUGtUUkS6h8hWmGiMRI2q/i1beQ2A3UetinGhlHK?=
 =?iso-8859-1?Q?cPRfIFoZaOtzTkeEQ/HjighFAJIeIQPT9f+r84pm2fBnRLzad7Ntzdpm9F?=
 =?iso-8859-1?Q?bh4Y/Nth4yF+FHnW05EU9UZ3MuABMbLPbmGmvyrROo0MLPt+IWmjSHWzPy?=
 =?iso-8859-1?Q?icXLMlsPizbra+SVq2jJCXdVPKtchOvA1oNw/sCAXp9U6op85drQmRWW1f?=
 =?iso-8859-1?Q?a6UBjRXESgHmHUJWWVDLbW70A6FIZYdPv6fbwFS82crgFTxwjUFDfEyrnf?=
 =?iso-8859-1?Q?HDrLO+idrKbzZl1JM6IVJXG+3RLAbInLYBt1HQS87kfBUDGZ7l5xg0jLYl?=
 =?iso-8859-1?Q?+Q0xbqPsIxTYYXcEKp0VBob2JwOEsqVoYqVRR+u9wdnGCNEtfu4rUjA5G6?=
 =?iso-8859-1?Q?WCBdDEF5kjjR2dgtJmNB73CVOM3jeRt/i3ZOkyKDMNe1RM558VFPUfc8m/?=
 =?iso-8859-1?Q?6sS0HAlH6XxQsYETJddlnn0QKGn2wgjEJN+FW7BO6v/5kp7mExkx7dOCZy?=
 =?iso-8859-1?Q?XJYcSTSv2qnpqPzQ5bDrj0bAqDwtOuQJ4xSxgOGWZgB1xMogkNkkWSYTW5?=
 =?iso-8859-1?Q?sXhYg1zaxgVDgXutWQI8v8EHAHuvprGuaZTVOmh4w6nvIhcwTMkmsEaa2Y?=
 =?iso-8859-1?Q?ZmFDkySqBQUKT5cc4DfO5X5X/PncoMGTmVUmLJDcJrK6jXeuWbtSDs1Co8?=
 =?iso-8859-1?Q?zyu3NlrlWNrEvArlbQPCypkgtfZ9o9HeGr+4y/vzTuNkp5azrlp/9qXMa1?=
 =?iso-8859-1?Q?lHj5FcXP8im6WdRuRDBsFpB7RVbLdQ6Jp1CKC04VTzgvdiDK0pJfwz7VWy?=
 =?iso-8859-1?Q?/YQ1w+rrw0aXEJVfgkbgQnSmcMgMiA+EYr93+weTWH7HWwNdlhJWEh8oDx?=
 =?iso-8859-1?Q?llpO/GYSBPlRK1GNAGcO0v2Mu6fs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zsAUEEmxCn3jBUBk/pDiwlb2KkcvD1dC8qqDI4M02gIW+DuOxCw66rljz0?=
 =?iso-8859-1?Q?IXpoC5FwaNXk2FpkWKY3nHel0J/zBFIqYepFAjzOH56bmj+n3ztZvWlYxb?=
 =?iso-8859-1?Q?Ej7oAiG/B9Opb6xgvuJLUmo2UW5B0Q6rrXyJPIr2Q7HrqXkiZdd39euG2x?=
 =?iso-8859-1?Q?NBiXi5QLAxnOJQkoUVuohwOiJwprNeno7prnQTq6z1hmC9fHWmlRu9KRCY?=
 =?iso-8859-1?Q?M44atA1O2x+cZorNdMeq2xQEpPkSmo2G5bmKCQyrCGLxyLTkzBTO5luEgF?=
 =?iso-8859-1?Q?pQ0wI5kDM+lC0KM8CP1vL7r9SbpdhEZlnuP5xYnU19iqbvlDST6vk2EutR?=
 =?iso-8859-1?Q?NTABYeR9OXWE4l5ZWky6XaNuJVIAycBocpws+Z5wBDpwwVqPsw4nFVG8Ty?=
 =?iso-8859-1?Q?hQr5WQC3yEzRAW2Z7s3/7ShqG1mKH2JMj1bfuBtApyzz8JWg4Y05J2FheT?=
 =?iso-8859-1?Q?C71H10qkmn5N3GbK6fWmpQh/ouDLyCkFYHQri/JSYvpw3SirL02WYYdq98?=
 =?iso-8859-1?Q?0erYup63d+3knTyTGoUFLYs/NDqxcT1WgMcMXZnmHWUJlahF1Vhx0FBVMS?=
 =?iso-8859-1?Q?icCytxIfF0ymHOtIuao/3wUkG03j46aYVCUWdRa5XtPzqz3vGt9/NdtJfU?=
 =?iso-8859-1?Q?eXkhU5WKLPwnDFoIxCw1otnzAelJaKxuW8DvQ4vKYdGvBpNo3iy+RZp2MT?=
 =?iso-8859-1?Q?A2x6OknNGD2GebhMusRakz3MJboApGKnPu8fWJc0kaEx8gA4LNZzfnXyOc?=
 =?iso-8859-1?Q?gVRItUmXcrimhhokOBNUo4vSlBy7ZT8uIBV5HwQftlkRXWH0Eeq4AiL+jo?=
 =?iso-8859-1?Q?CV4HoAO1sbbnXUmVN8TyJvBwdR0oRgHvoquNNMPLRdQVd941l5oYup/Z1K?=
 =?iso-8859-1?Q?XIS2Qy35v3eW4EYEZIyjmUtVW7AvHm+VJEiV8JXTcLTt6/lfAM1viIXzH6?=
 =?iso-8859-1?Q?Gk0+mHfoY+860RobdOT1oDkGCmnKk165PcJ8NXn3ggugA5ekPV8QSeKs9x?=
 =?iso-8859-1?Q?3826P2DQp1M+DtYARP4SijDPeyw1gF5qLeZQlWDTbxFJ3dsf3kXfAFC2U4?=
 =?iso-8859-1?Q?0VGrTovIdzEojcQ4Zob4gvv2L0nzurx8D40lDwVJrp+hoYHWL0JX7zWiaA?=
 =?iso-8859-1?Q?9cTmc5LTGXhkZIxR7+37C+u/DTcapSaq6sVBFzVCvLva42RH2mJMwN+VaZ?=
 =?iso-8859-1?Q?f1OxyYaD6rGPJKc9Ie6Ttb8puLVPyH9m3JGLNEOjlebVE05GzJpZRDzO2J?=
 =?iso-8859-1?Q?j0WpjulOaHdUgoA6VVQfIM1j6B9Zd2lAGCjiF6PDOGsZapWVBHq0TCC+50?=
 =?iso-8859-1?Q?23MpopBayoycSj4ErVjZFlCyMRA8U3sp4LEiUJDsI7n7pxwMscaI+7gZ+0?=
 =?iso-8859-1?Q?+gn28CTGmtej6ynNB8xl6FH5ep032EUtaBYF5VbOSYAU40uk6xyCEcWrss?=
 =?iso-8859-1?Q?padZsJ/cJxs6VkXnVVvAg59dKC1k74GROpwy4gH95GM8dN3WyK5drhp8W/?=
 =?iso-8859-1?Q?ccf6X0c5RXEwkHczZxBQJl4WAw6W2yjbizJ7b3COT5HjKjpsqR6L17Qqqo?=
 =?iso-8859-1?Q?zn5yyKRvJaGVCinWGWPFVmNBK8Dlr8oEjWRKjpthOc291Xel9gGjz9roX/?=
 =?iso-8859-1?Q?sdfqQii9CrhoktPMhVOGsf/AddbQr/Nr3Dg/czObRrEQGn0kqRIbwmbhgl?=
 =?iso-8859-1?Q?3MemMzB46MzzBBLrJ9g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4747120-64f1-4684-6b1d-08de0269f69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:24.0612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTcrDfUAC2htw/WoKR8ahyHtzIrYZxbcq5NDQym8g08WJmcNUqGCNltKvCOQF8Te5AWUVtzRGoxZ45jfnFuNGxyUmpwx44Ifa0iRmPmycMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR09MB7941
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index f7c4bd0f85..46b7f1a3d3 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -425,6 +425,11 @@ static void boston_mach_init(MachineState *machine)
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

