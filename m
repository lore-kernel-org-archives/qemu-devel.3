Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6572DFD0644
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dy2-00036k-B8; Wed, 11 Mar 2026 03:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxj-0002zN-FP; Wed, 11 Mar 2026 03:26:35 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxf-00052z-EV; Wed, 11 Mar 2026 03:26:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYca0CyaLq2HgRDoBOHdTeZMrRNOcsPkRWNNt0AGNvmSOpeVTZk8uug6yn2qcMa6ZLar9ecThnDWu/Gv0Rpd4nKPe2wN7xxuYA4tRXEh263pnS+/L7TIahIqCNp8zN6Q6MVTzfBAR+NCMvONazmOHXwGzwJmGYnMuRv7TJcq3UvHz+sBLl1mFwJaoPUlx1JfbDyxmMojq8nClQ7CfSCCeHlQLnvzJr2qHgUKeiMaTT5OuDQbc7k8U/myc9VN13dt+ZpArnrsUhiGi/Ia4B/vYnMrCwSUhLXn9a1Y8wqTXaBJqP6GZ5QTE7kK+aFZV7TqDw6dsyPchtObNBEeq+0kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqsoB8r+NzV8Rw8RSH3iuS0hQKt9IkuuMWoHuhsqS20=;
 b=K+YClmUc/RF+4Hm5tv+mvs4WTwFTrWzfYqD9jNPwuH61V+5Hkh/opGTgy5qah1QjmZWguA0WkVD3F9yVX2RUhMQWErZHO1XQvOxKWVenXdOJ4HakOUH0hIQtrkAsOv1CGaxpmYA+x4Xm3+vs56KeYnFDYxQ1Ohnf8FCnqtPtqnzmGSu6/F3RJvmMbRmVRMQcFTEQF1BuS6H4lTIytijJ0wrBV30N4AiDVDcQBLCgGTcTZTvmfIBMewjLXXyFLRjo/ZMtrM3pqqV6azO9UnVZe4isvyr7zyfTRsyIUxnn011g8//+Ne3pHGPVsyJCz9AgWm31PPrlinTM6Ye0NtrTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqsoB8r+NzV8Rw8RSH3iuS0hQKt9IkuuMWoHuhsqS20=;
 b=MpMqayvNHTb3OYI7wurKeRHFS8qA1zybsnB8UDm2i3xSHFQhx7rInDCv8XW0SMMOU93fUpkLiusIbsdIqfICkXn0t7gvTUA/+KPGoU4+bPL+Mjaju0EUNSXr8qTycsGYcQCR/wvTpvwokCQ7jX2OiQ+F37FycjsnvvhBJyP/hOp6IeQwdd1WJCuTcSqLwi945BjYtkwBdMWfWfCuNN7weIH8AaB3u1IdxSRAMGXQJTWfTeg1RC9B9oNxWEFGSBmg0lZSnrBRUFRwU/QDLFyPdm3aY6+Q0+tJvwxc4b/DrCsUeDGvOhh1rWQZ8XmEcB11Ps/PwCr2Ne+qf/ciMi3quQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6082.apcprd06.prod.outlook.com (2603:1096:101:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 07:26:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 08/13] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
Thread-Topic: [PATCH v1 08/13] hw/usb/hcd-ehci: Implement 64-bit qTD
 descriptor addressing
Thread-Index: AQHcsSheGdSk5ZoVpU2+JxVB5IlC2w==
Date: Wed, 11 Mar 2026 07:26:25 +0000
Message-ID: <20260311072614.1095587-9-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6082:EE_
x-ms-office365-filtering-correlation-id: 235accb4-82c4-4429-2fe3-08de7f3f80e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7142099003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: Oqg/k6M6D9ie3VGX8wf3835E6gJgeI9Qkah99nvqO2Z1s2TANOWDLporqz86/MEPVdLYQtVNpr57zpGqiGAUBzk9VUwXlC/qbpb73p/rD98wLn5IYb1iEzVfO7ueWo7pQgrfTPQyMy7LioPya7Cq0czuENGNH1LR65w6w04eJW6+91gxVYwlKh+qwqeGIG6juwlY31dz/trM9adUQRIKuI1rthJJqC+p20v9ewzwPI70vB62X4aWfIfhHIIl+O/CPueDzIiHuUhYmjjIxheIf16cpCDOukvl2JMeMctLAMtKeIsFUcipKDUpx5cLs6UOx781HXD3uMQR1B3oT86zvLWeb1xSXxmShXaARROzlMjVV4rOG60PN1Ok75eilwwNE52NnxoufqH8ZTsBEQA5AGny1MeAdiTp8yVQXfv0ssKwa9On1hmSO12Ve0oi0RwXjcjN6zTddjdR/Cq6YvNinFDQkWp1PJVKav4P4OSZcSSVo85ABi63t/kkkzRuUZpWNA9znMkTSD0Z+GjDo2NGuFNl5d6CpJMPX3IwKu5GrkEYcJR/3ukcFDUhwlbTHF2ON/5A4bR9RH0q0QelIltqzNG5msVkyI2F9AghiaTsSzfJIVyJLDCW0xZFVUHxALJ+sWpkbR68n0XuIMq8F7pAOO/j7b048CU629a6ght/WFc3ztIvRyYmqQzWYV/GxmOPIu2H1fo5iCiIxFRSkVxMacOjwGhWBPlBmMR/nxnOcGjw6cnC8GshvM3Qjb5XSUCGP6/p0pEbNjtXoXptRoJ3QPJe4rZMAHC3BYvQ7t/QNuo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7142099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2MWRAPZ40FIEWSB6DtTsweitHXCz2pIFfXrWF+lEMXU4x9UNihR9Xt7iXX?=
 =?iso-8859-1?Q?ZP6Ld8tCmBCi6ZSpDBAe70g+gk39HnyHosvzl7xtg98FuYk3OiwgDpCX9I?=
 =?iso-8859-1?Q?BQmgaov61m20klMOOp0a54fke7D/6GOgweCTHjA8eKAxKGwiShBwjmCigO?=
 =?iso-8859-1?Q?/PsPlrYlmDXtn4Kjy+oKpMTQ+8VYGm5X9lUCA2BpaGcebucOjWeZeZ+wHk?=
 =?iso-8859-1?Q?013TPhBuVkFR7SZp7UXIx7AbgkWJ2Sj555OAimYhcbHInSM0IRDiOkFAQC?=
 =?iso-8859-1?Q?ww4iMcQywWiphauEpag+ayhzVnIyIjxpQygSwPCePl3bQoW0Zd0t6uw+rj?=
 =?iso-8859-1?Q?MvPAtr5iAfZDAcbfXODkbNZPERiT5azowQrCkj4C0Wu7+TNXYz7FCmaH6v?=
 =?iso-8859-1?Q?Up/Dms6wgJznC29idan4qHiS3pQrpkqjISgK9sc/LNo5pKMEOaCXDfpuHF?=
 =?iso-8859-1?Q?NWJ4MjOFOAPqcTKSLTk+4BTRxShQzThriBrie3dQKOQsrZec1vF1rXaEcX?=
 =?iso-8859-1?Q?nbjzpe/REii9rMozxt3stcHrwwDcfcAoPHaBqzrm+czbyLUNrMvGnG+ge9?=
 =?iso-8859-1?Q?m8vpoU+2ofxVot1TYbEDXu5C5NNrI9kQhTZJ3G4sAorWf49Hl9QMFFu6Hu?=
 =?iso-8859-1?Q?5T9qC7iXBbJqAH3RhycofJ1mR4kbTo/oE1pcoxtUX3Az2OL2xUso/SO7CB?=
 =?iso-8859-1?Q?hcc1n4ji3iaLSi5TEmNQirM7YSpRoJbyh2EOFjQBdwJsNhbHHQfg68Y910?=
 =?iso-8859-1?Q?nC39MvGSnAAR5GwqUK+4ounncW2mmmqZtBIyiJ/zVJcObgBK+TePNSc6Wk?=
 =?iso-8859-1?Q?A/HH7dAflCSmRPNKCNoPOGfZur+fA+7VfSNBPSZ+UZrLPyp6NZaLjM0wT6?=
 =?iso-8859-1?Q?eM+ycCCh+XMXBJb33CSpQDpNLg/NVmVaCvPg9qmNTFWPA+brn99sXW9Vnf?=
 =?iso-8859-1?Q?etVEkosvp+/oZ/8RG1Qrsic+cbZd2n6fIDStbHjj9CB7evHTWZDSnptvI/?=
 =?iso-8859-1?Q?n+MnSDB4YbmKmt2sKP+8O7jhVuiwmbJC632Fi5EovKE6bGCzfY4RpNnef1?=
 =?iso-8859-1?Q?pqgtwTrrJNnxJmYCr7F2j7HEE5YCannrJJtuOdrt3WiJFxHd3iZaLo+IKe?=
 =?iso-8859-1?Q?S3FY/IpQHP1rIUxQ/CxziiHPOkTUppAoSKfD7TjsH+bi1FhJ05MLoVJsn5?=
 =?iso-8859-1?Q?MzBQpI1DeOULmWW6JpiTSL7o/EuWKJSyPH6qqQ3wTGbNoMz1G5pnizWLin?=
 =?iso-8859-1?Q?OAXi5jL+9lnA4+ggV+vZqYt7kPYbFS1z6lTC9QYAcdUy8YZjDNDJpACeNd?=
 =?iso-8859-1?Q?lJ03AT6LWX2+sePQicNEeLUtteN08joxlZzASM5cFDN53eI7MZ6uzeHeY0?=
 =?iso-8859-1?Q?e/HvQGtVGW+/uGchgZ6lh6GEuTUE0lW51TN9rlithTvkEmaiVomAbAI0lu?=
 =?iso-8859-1?Q?GRJ/IFoNFI+NJV2xEuVMdXlvANbCaMyncT9qsBWHHQTFARhOFNnh/qS3Vl?=
 =?iso-8859-1?Q?7lasraGjUcLrOn+pINCxujC/Y43Oo42REUL3zBNHXf6prBTt5KPkVnp+2n?=
 =?iso-8859-1?Q?KbZFk6nc3rJGqt5kJVWXX6ApJLHANbKkgPXoepT0j0dWZkgn1Foz3UJ6uR?=
 =?iso-8859-1?Q?P/mrhFmLYd5+9iOnAQXQvCKVcThnRO1qZrpyPtLznAo0lXnmNlKa67Sz9k?=
 =?iso-8859-1?Q?0xy9q84KMfIxl68d8EukI6qv9dr9dKuxGEiON6OPmYZQROJAsKXJVnxxGw?=
 =?iso-8859-1?Q?BBS2QVcymdWEVIV2ES4NpA6cViOjqbltp6ggOTqafKAj/MNK1wxBtOHnny?=
 =?iso-8859-1?Q?6khCmQG6Nw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eKQA7wXcFXNWRNytRSYdhXugPwu4gYogArrrivWJDXcarkKfzqd7i8rs4J3r3Ut9H05NKYAE43XleaHBpqgGAt1zw4KUj8FQRsvM3i8Pn/lxI9yLvvXxxcyjFvlhaFmaVKuI7aCATQklmnMa0pKIyqdAqumksG4a0770/6RVUOLszAFqPhwYMI3AUcuAI29eZOVaVqKBFpF1g136TtAr7XzPRAEYSXHqga/Sb12EtLCbZXRH4OlPs+Exkq8pooZ6da494zfYTWfMuQKh6/E1CSDxzCiJUPOuv/j5/ClndS2oL/dV3PtW+sdj550NHzGfT49X7HrF5YiBtnbaZwOg7w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235accb4-82c4-4429-2fe3-08de7f3f80e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:25.5435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqNEbO8JLri2dIBY2aMrYDOi9EE7g0eAm99RSkT7I4UWRFbtEKflXUjfNXDz0CgzMsRu0JgOlm+5aYHqObHbNN2SiB+QNPxRQ/QGBAyLQOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6082
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

EHCI supports 64-bit addressing when the 64-bit Addressing Capability=0A=
bit in HCCPARAMS is set. In that mode, the CTRLDSSEGMENT register=0A=
provides the upper 32 bits that are concatenated with 32-bit link=0A=
pointer values to form 64-bit control data structure addresses=0A=
(EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
qTD link pointers (current_qtd/next_qtd/altnext_qtd and qTD.next)=0A=
are stored as 32-bit values in the data structures and must be=0A=
expanded to full 64-bit descriptor addresses when 64-bit mode is=0A=
enabled. Update the qTD traversal paths to use ehci_get_desc_addr()=0A=
when following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for qTD buffer pointers.=0A=
Add bufptr_hi[5] to EHCIqtd and extend qTD fetch and QH overlay=0A=
handling to load and propagate the high buffer pointer fields.=0A=
=0A=
Introduce ehci_get_buf_addr() to construct full 64-bit buffer=0A=
addresses from bufptr[] and bufptr_hi[] fields. Use this helper=0A=
when calculating transfer buffer addresses so that data buffers=0A=
above 4GB are correctly handled.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  1 +=0A=
 hw/usb/hcd-ehci.c | 32 +++++++++++++++++++++++++-------=0A=
 2 files changed, 26 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index f18150c352..df16426f76 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -149,6 +149,7 @@ typedef struct EHCIqtd {=0A=
     uint32_t bufptr[5];               /* Standard buffer pointer */=0A=
 #define QTD_BUFPTR_MASK               0xfffff000=0A=
 #define QTD_BUFPTR_SH                 12=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqtd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 8fd3fd60c4..5964ede05b 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -158,6 +158,19 @@ static uint64_t ehci_get_desc_addr(EHCIState *s, uint3=
2_t low)=0A=
     return addr;=0A=
 }=0A=
 =0A=
+static uint64_t ehci_get_buf_addr(EHCIState *s, uint32_t hi, uint32_t low,=
=0A=
+                                  uint32_t mask)=0A=
+{=0A=
+    uint64_t addr;=0A=
+=0A=
+    addr =3D (uint64_t)(low & mask);=0A=
+    if (s->caps_64bit_addr) {=0A=
+        addr |=3D (uint64_t)hi << 32;=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -467,7 +480,8 @@ static bool ehci_verify_qtd(EHCIPacket *p, EHCIqtd *qtd=
)=0A=
             (p->qtd.next !=3D qtd->next)) ||=0A=
         (!NLPTR_TBIT(p->qtd.altnext) && (p->qtd.altnext !=3D qtd->altnext)=
) ||=0A=
         p->qtd.token !=3D qtd->token ||=0A=
-        p->qtd.bufptr[0] !=3D qtd->bufptr[0]) {=0A=
+        p->qtd.bufptr[0] !=3D qtd->bufptr[0] ||=0A=
+        p->qtd.bufptr_hi[0] !=3D qtd->bufptr_hi[0]) {=0A=
         return false;=0A=
     } else {=0A=
         return true;=0A=
@@ -1192,6 +1206,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
 =0A=
     for (i =3D 0; i < 5; i++) {=0A=
         q->qh.bufptr[i] =3D p->qtd.bufptr[i];=0A=
+        q->qh.bufptr_hi[i] =3D p->qtd.bufptr_hi[i];=0A=
     }=0A=
 =0A=
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {=0A=
@@ -1225,7 +1240,8 @@ static int ehci_init_transfer(EHCIPacket *p)=0A=
             return -1;=0A=
         }=0A=
 =0A=
-        page  =3D p->qtd.bufptr[cpage] & QTD_BUFPTR_MASK;=0A=
+        page =3D ehci_get_buf_addr(p->queue->ehci, p->qtd.bufptr_hi[cpage]=
,=0A=
+                                 p->qtd.bufptr[cpage], QTD_BUFPTR_MASK);=
=0A=
         page +=3D offset;=0A=
         plen  =3D bytes;=0A=
         if (plen > 4096 - offset) {=0A=
@@ -1720,7 +1736,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     } else if ((q->qh.token & QTD_TOKEN_ACTIVE) &&=0A=
                (NLPTR_TBIT(q->qh.current_qtd) =3D=3D 0) &&=0A=
                (q->qh.current_qtd !=3D 0)) {=0A=
-        q->qtdaddr =3D q->qh.current_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(ehci, q->qh.current_qtd);=0A=
         ehci_set_state(ehci, async, EST_FETCHQTD);=0A=
 =0A=
     } else {=0A=
@@ -1804,14 +1820,14 @@ static int ehci_state_advqueue(EHCIQueue *q)=0A=
      */=0A=
     if (((q->qh.token & QTD_TOKEN_TBYTES_MASK) !=3D 0) &&=0A=
         (NLPTR_TBIT(q->qh.altnext_qtd) =3D=3D 0)) {=0A=
-        q->qtdaddr =3D q->qh.altnext_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(q->ehci, q->qh.altnext_qtd);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);=0A=
 =0A=
     /*=0A=
      *  next qTD is valid=0A=
      */=0A=
     } else if (NLPTR_TBIT(q->qh.next_qtd) =3D=3D 0) {=0A=
-        q->qtdaddr =3D q->qh.next_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(q->ehci, q->qh.next_qtd);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);=0A=
 =0A=
     /*=0A=
@@ -1840,7 +1856,9 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
     if (get_dwords(q->ehci, addr +  0, &qtd.next,    1) < 0 ||=0A=
         get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) < 0 ||=0A=
         get_dwords(q->ehci, addr + 12, qtd.bufptr,=0A=
-                   ARRAY_SIZE(qtd.bufptr)) < 0) {=0A=
+                   ARRAY_SIZE(qtd.bufptr)) < 0 ||=0A=
+        get_dwords(q->ehci, addr + 32, qtd.bufptr_hi,=0A=
+                   ARRAY_SIZE(qtd.bufptr_hi)) < 0) {=0A=
         return 0;=0A=
     }=0A=
     ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);=0A=
@@ -1921,7 +1939,7 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
         if (NLPTR_TBIT(qtd.next) !=3D 0) {=0A=
             break;=0A=
         }=0A=
-        qtdaddr =3D qtd.next;=0A=
+        qtdaddr =3D ehci_get_desc_addr(q->ehci, qtd.next);=0A=
         /*=0A=
          * Detect circular td lists, Windows creates these, counting on th=
e=0A=
          * active bit going low after execution to make the queue stop.=0A=
-- =0A=
2.43.0=0A=

