Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7678CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n6-0003zM-Oe; Mon, 01 Sep 2025 06:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1n1-0003wq-M5; Mon, 01 Sep 2025 06:29:33 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mz-0005KU-Ix; Mon, 01 Sep 2025 06:29:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwzUTlB7aQ+rgfcrMI3biOkX9C+8oxDYDiG4CdBr6q9e4zfW4QNxYcVYR6BkZyiOjG4JgU6MiZR4Itta0YTwOAIC/nWUmJWvpKcv6wkvMMpEu+pOShP32Ijadv8/1vgMHC8lZXCKpFEOWP61THW4Qr9539KdGGpvs5xhwlSBD8/7NydL8HzVNmVo3wx2X3iDjnJ5aZoDK4I6L5lWeQkN1DbubYCNLAPHunxWdKBhimXGoEVZMhg42qUx+5Om558QJrpJBtLZN9PA/B10F74Y+XmBJjiOE0Pz/x4eu+kfX2qsHDkZb8xq7Mrnb6HuXEZHgxKE12JloS0vx1ZEQbmA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlSc4QUYacHL+l0eQHnLIMMRJZTwEzhNC4Ot2fDdD/k=;
 b=ZqrfI/K1kF2Jdq4Uujmstibi3a7wpfYbKc0HcEiMh/8MeNWMleB7LRpcPiDdud00LHalgtG5sQz8qlYKw7RgXlHlQUTbd9fILFGvvOLE1rBbTpEo6X++MgKSeDMwLB7TujKG78rqr1p6itQPq1NnWRCzdL1A661SJHb4xZHGsQWj9NRoB3FuAbFz1fcpUd9/CM9Pe+3+Ngereh6g1UnkkQ/7MHlreom50wMlFWDlM2VP3zPZbgEguzC4CU5hQrUM/dInrmlAPylzTW9vyeM0b/skW+PbMYMkZAfSjyxIMoKa36OxVxdUUWqZJpkaPf6qWATODyRb9vY+xYMDS2JMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlSc4QUYacHL+l0eQHnLIMMRJZTwEzhNC4Ot2fDdD/k=;
 b=KCDVdGHk+tDbQiZUZcdcDN61HH8mvk/ZcV7EIBt7nJd+yK3nO8VyP+if9DDxwxTNzSYwycGNqiiYuPu2xsxBwOGJfiyamCov2Skcp1lfw2T+WgY2qc3hR/2UMZh+FiUu+D/JF7F/pgN9aEuvnhSeZi1Wr3to+1OjIlH+OjFGY/PH4W8/9VatB7I4E0WUi0H7EBjBbSB+QrSG9MRk3/iaip01487Ia1omDdFcVA9NwyroDmETi2FNaHOL+dLrHA0jejBYDwSj1rsnlj/a89EdKo8oVd95e+QZse2qfOBObFwc/UtjQv545+2uaRIa/3eq7umHVlHoxGRJEmpSzTSgsQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB5992.eurprd09.prod.outlook.com (2603:10a6:150:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:10 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:09 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 13/14] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v7 13/14] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcGys+ufIY9rBJfU6pZlkY/v8TOA==
Date: Mon, 1 Sep 2025 10:29:06 +0000
Message-ID: <20250901102850.1172983-14-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV2PR09MB5992:EE_
x-ms-office365-filtering-correlation-id: 368cd649-0356-4ec5-4061-08dde942633f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Hj05rh305z/unfZy+mRTK4NyFd+ekrfezMxdHTee3QPYj4LJ88oc2wm0Gx?=
 =?iso-8859-1?Q?xn9BpXscJSX1YgI0M5nL6+YP23OrN1AObPbhHf9o8FN8xDTLJwhnwPXKJi?=
 =?iso-8859-1?Q?iYP97kd6liiNuUnVvbewOwWy2pk7FJ9mlTNxUos9w0foMXGu7hedQ26N/w?=
 =?iso-8859-1?Q?EH1vq/4SvgnIC8TIOLOnHJyPnadzITHFOyazsr2Ju9fQPYYvQnM+GaTX4h?=
 =?iso-8859-1?Q?3kNv8pxib+Y+AzZST94yd/y2TY89rV82b06bSmmcj0rdmA1y/kITUSqBXq?=
 =?iso-8859-1?Q?kBsDTXYBnjr85a6Pk5JWPD7Cx2yaXnTuFauBilC8by0a3Kz1cOoONM05Rq?=
 =?iso-8859-1?Q?De0X4t5XyaCkrGIoxVUgHMCMVljYB3aIgRDx88k0WvnI/G6HQiBBd3m+EF?=
 =?iso-8859-1?Q?O6s1GiMipCp2NlIua4y0U9ZpbRElDlOtDVSVagR9CLB3AWLkSOKLoZHrsJ?=
 =?iso-8859-1?Q?36AEvQTP8XTyrM+4DzmH2cvofHu9ZFLWc1v052FQpEZ65KBjokA390liba?=
 =?iso-8859-1?Q?HfRHv4Et3QOgP6tRSPRUshucRGAmDMen+C6as9yzt3GxmKBIWZghpJg9g1?=
 =?iso-8859-1?Q?7K2oJ+IpEWo823hNFBCjF4naclkdzOl0uc9xsT+pSvQ5AYJQ8esz/N+fjc?=
 =?iso-8859-1?Q?LjpH4P71TSONXEdUppzcwIlxr/6J2+dVqrsexbQlR20v28Db9tqizPEBl8?=
 =?iso-8859-1?Q?Kgdl8xvJyORpzrSJBnvxdBAqMy+F0VIJvNJ4Pmen7RQE4CHFZ5tggFvyFX?=
 =?iso-8859-1?Q?FoI7eQ2JaQHx6X0R0MjIbzkoCr+mrTuV9Y5TIY7lOFR/ii2Esn2rOPGA5b?=
 =?iso-8859-1?Q?bC0JORU/N2T2bLVoYY8TCizEgJ9URcQxffPtINXesENjXEwPwgAGbXuus7?=
 =?iso-8859-1?Q?gaO6pc90cb5iyRXgfAx80sKVq4nB8KS/EI6xp3kAYnJcj8v9POrsAHtyId?=
 =?iso-8859-1?Q?b9mzTrxMUMxw6YRsHHZODS2fuZdI+S5IBAJcyhdQnGKV5vPXts8A8ANHMI?=
 =?iso-8859-1?Q?JWTeJnxSw7fiS82Wo3mX0RPKIgXfOzdAI8Gp3Xw/TNUtsCa/X8JbXq2u/4?=
 =?iso-8859-1?Q?1B3tWC3Gl+29bTE9mY/Bj5fT8mfoLRqAcz6xvsUAzva/pFvartJ4qeVDio?=
 =?iso-8859-1?Q?Y1jlD/cQ4FU6IYOD60Cy/+taZTowl0eCymn+wZIQmXH5frFJAd2sG9z07L?=
 =?iso-8859-1?Q?YfMmlHGXUnyj++RW7VPLtds7u2KFB6zRfRTViulVqVRCqm/PDBhT9CSw3z?=
 =?iso-8859-1?Q?YazNK4vBeZWy2ROPgV9WCnbalDG4PYMDCnY/X/oKPl68EbUOm4YkDYjy+5?=
 =?iso-8859-1?Q?V/voEyecf/Y3DLfBf6aJXBzrqwfaoQgm+VyPWdWUyujZfZKcp4Bf61Lj/p?=
 =?iso-8859-1?Q?Eo3fMekhxCJtX4JU/Wjdak2sO+EcSN39UjFh+BXf+zqwschfFBRHNeO6lC?=
 =?iso-8859-1?Q?4gi3tP8CDbh3IY4vQQAj0MV1SqIDRlyz3mZBznlf6P1HMbeCGRxjj+aAoj?=
 =?iso-8859-1?Q?dg1b0DYTzNKq0/If5T2ugX96RzON5Ykfa8yCp6QLn3vg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OLWSOD5DiZFVwgfFJmg5O19HrePxnWS0Y56wOoU5Fm8GlYi1/dw/7ihfcV?=
 =?iso-8859-1?Q?M5OYjKF1KChiAGVkyk87HtG8U2yV3FEWQTYZvFBD/rDX2op8nEIfFalUGW?=
 =?iso-8859-1?Q?RmERrZwHAKDMQeqZVegHq/rxSy8xBLLQNc1MkB7Fo89VYZv804FhW4lVUe?=
 =?iso-8859-1?Q?W1OuyymW6ZnUt603SDThppxbrk6HysNqs1AIIjjo8ch8yNbvbX7Ifj3hBG?=
 =?iso-8859-1?Q?mb1SRW7PjWvHJ/aPWStVC9DHMtUx/dXjytQcnlvACFTR+4r3KB9MHBtqqQ?=
 =?iso-8859-1?Q?anKhn892xZarVtF5mi6s1yqSQBhuAZd64MQ+2h4Xt6Ox7wAy/CylitCLDv?=
 =?iso-8859-1?Q?dWc280oYE3MSnDX0IUHy/CdVqyGRl0K+yo5V6CwcyCYHEPJSYw2D5FQYpH?=
 =?iso-8859-1?Q?1FqpaaDscpzJ7kB+JtF7tqLhwpg8ZLket3STbqV/K2glo8ajvBN8E+k7GM?=
 =?iso-8859-1?Q?mDpv8JEXP0xDKBDUaMR1pmb0dDcW6pL7MSz/QAMDv2f597X4SkBvwumfH0?=
 =?iso-8859-1?Q?F0kEfmk9j/7/M5evJBLbhfni0KUd/+74oZU+Qm79pQgeu28IfoZ8FS5zHg?=
 =?iso-8859-1?Q?DnUdgBV+/2b7WxSWJ+5wLF2OrkNM/uVaUMiAbWYjcSlwAtby4uiZKZzjor?=
 =?iso-8859-1?Q?9cEmKuYm1IRAQ/zr68NOPGofsbAKsnvS9jRqGqTv/I0bm3ogdOssC9Jlpl?=
 =?iso-8859-1?Q?LwEv/bg+cAGPWhcgYUFNCDc+E8UXbpVrSlVhxJZZVebaPiAMwloN/PIPVE?=
 =?iso-8859-1?Q?UiZSR08TPtsrkz8VWA27i+ccuErvv25Mucvd9fiUkYSLdBRHNJfwD3DO9N?=
 =?iso-8859-1?Q?zUsgLPRFAEmJJNKIXqPplVijnDtqi1tgs9fx4V6CAyu5b29/aJg4I0Sd5l?=
 =?iso-8859-1?Q?Mil6BtPyGlIl+PMtTfot9wNc0ZAxoZ3VxKM764hdSR86yhitfkZNkofO1/?=
 =?iso-8859-1?Q?kzXVocFAYZnkPLGnN9p4mRn0Rn+rTYPHfgp2//MipPThDspbIXssc2DzXA?=
 =?iso-8859-1?Q?73vZYxqci5CkrplZ6Gm4WhvvKUFFufzJICX9NMA1p1OkNJfudSa+5Q/NYV?=
 =?iso-8859-1?Q?HE2YCN9L/SVxLumgR9zhse8cWFmzp61jW4nJHqQuIQJ8db5P8Z2SMSt/hf?=
 =?iso-8859-1?Q?LNE1JXT5MOBySJZm/ICl6gP14Wf0x7t5jFVt0miX1I2J0BOiHZcWvSU21U?=
 =?iso-8859-1?Q?XZ/JEGWmptbli3SNPfgGjIooyxNa4z5DW4zubr0PLFxvbbM1yUSI3PQGsM?=
 =?iso-8859-1?Q?noaiFztyJ38ixBVVeq6XGNgJtxEnR/ClE1YaWt3aoG5RcNLqDzic3u+2QK?=
 =?iso-8859-1?Q?rkhUftRVbmz3RwWHDTT0XFgp7DNXULw9mWUQzDbGDaFD7+/MG2b5iFaTc1?=
 =?iso-8859-1?Q?vheT02+2FzuyY+vmauIn/qKbI7KqnXvLzj2xYzWF5Vgi88vn0tbReg/Ipu?=
 =?iso-8859-1?Q?A4d0MtbMOz+7KfYQK+Ml9gXT22ZZ7ghkTKlRl/uU47hb9lfHzY21zjbd9Q?=
 =?iso-8859-1?Q?BgLbKlr6Jpe1E1nQDxXdqv2IS0OhElL2eHsJMMClTAawSTWVOgyliVFQYf?=
 =?iso-8859-1?Q?8N52LJ6eAyxVhyD5i6ap7beyRVr4Bk/nQn9wG+KYYuPdwPo8PdZR6s+v8+?=
 =?iso-8859-1?Q?75aX2MKUtR8quwmPye8GcMmH3PxyGcUN/GyaBNgKApUPpyNnyVLcqkFvsL?=
 =?iso-8859-1?Q?WgT9mcUxRukMUEwdulQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368cd649-0356-4ec5-4061-08dde942633f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:06.6954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABu4b/XmSjnBZjB4OllQyStfp6DoiaQM/7tEBE2R2gCNmCyxGNtab8VeToN0ox38yXMO1ZXvOS4dZYAdzUw0DCvWDLPqohSnYUoWGPxAFWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5992
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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
index e31b0509ca..9be66167f0 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -437,6 +437,11 @@ static void boston_mach_init(MachineState *machine)
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

