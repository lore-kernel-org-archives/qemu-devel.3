Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE184CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91E7-000393-FO; Wed, 15 Oct 2025 09:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91E0-000346-4E; Wed, 15 Oct 2025 09:07:29 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91Dn-0000mp-O6; Wed, 15 Oct 2025 09:07:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXmsoP1Kgd05cixRf6MdOevnxHDR3Y57D2unEoKfoBpGL10SJyBuJN/RTun06N0efU9Q8VKfk4H+o4WQEM6vvnpHCDTd8dmqyNFDy0bseBM1Lp0ADyf1CyLEMPBQryEJ54aCkevXX5CAIYpTENG9cGqiJSS+gdB1NJUyiRTH+GaIRthNd6nbkazH030y585MW7szyl6HUfMP+FeOVjx5lDCMZHS2EQZPksaEhNwWtSTbNHK50hMW+hk3EiZOCbpXjNLK3V1zC28gOG3O1IaIA7xP6hpNM8qPRrJqoxH0VdStPb3DTthR2gC1Mk/LJzWYBC7hqglPF6nKdNYDZySocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=xBHCIr4dua0M9r7NRroFKXSWFqgW4HzYNMgc7AzVUAVaeiJiOVC6QSWKfcG+K7w1Ybv1c3MkoJ39x3kGR94G3dGUlxhocT9QG+G/kkKeyFP/+dRN0N8Ki6N0gUtN48F5lUxZBs11obbnpGY+34FKxdLiNZ/bWpromhkxiJu9Sd8MMqENqqgpBpAtraf+xjEKum7FOlBQrEVsmuC541xO6ovu9mb/i4pCUFEBs7jV3OY6z0w/JRQBvrW2Lh6gxFydX0flFsA8xCKg8vDSLFge15jM2QMbnkiIdf2Jc9z4u+QBWE6n1u242ZkIxwh3NlA9J7M5WUBIAu2oJis50mrOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=fusziGwAYSqcYV+VT1NRAfPSuAiFeL40aCBbRuPaPS/qwRBrTUYOuuxzinxvpqw8OSmhhZdcVw9xgoyk2m3SkhuRTIQuM1gaI+NerhSJWxTedlVcMlRs+vRftLbV3As2N1xbvv92EsVJ5pU9kb3dBILT7hmRxIujZaEzkTqWgBsfD61sOc5iZq37qUBDdJ/6WKKEsvSunlyVBB2f2+3nxLfchPlqTpYDZ2+5vemfViKRz95rj0Ggrq2OytMfZOVoCZvtSkerA9AMyMoTbdV8S7tzmfJkz2KCtentCv1VKW/Z/GPnBlkKkZGOPyOV6jO42BISDUx4ZQ73iA3SP3ZB7Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:03 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:03 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v12 01/13] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v12 01/13] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHcPdSZGEkgRnS+l0eENTs+j7O7yA==
Date: Wed, 15 Oct 2025 13:07:03 +0000
Message-ID: <20251015130657.571756-2-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: d7fbd855-5a3b-453f-93da-08de0bebbc32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dS++yjswUi1rvs/s0zL+28ahPkjRH8KbUeHRUlxqy6e3TXMPLC5vHEFuvv?=
 =?iso-8859-1?Q?44pOMcLWcsBZ+kKLIMIf8EQGzN+6Vd1Cj4XviqGubGz2Lmt5FjlqOzGZvm?=
 =?iso-8859-1?Q?6clQC41i7Aqbwtpgmfm0tblUNwjv6nmmZGfNtub0fjtSYFPpDtsIhUT6er?=
 =?iso-8859-1?Q?ZBZY3bMrcgUozonw5rIf2WP20GoZ8Co/u6tMxKVnHVe8ZaiE2v5HkWlPWf?=
 =?iso-8859-1?Q?7USpNTdVBCrsvQns3Yf+5xpmNITz3W4IvK0Bk3Z8dpfuJN58JkfzBzkF6G?=
 =?iso-8859-1?Q?bPnwGoMIyo/7HGoiJqH8BBNmxN79GT9OzfYeyzp32olzG+PXcjWif9imj0?=
 =?iso-8859-1?Q?qt1UmZkb7ihKpbr16xXJzJIN8PM/xDMywgxdobQkLTHSsEW1XtvjkUNfVg?=
 =?iso-8859-1?Q?+liSPUmbAfIWwpHvLTbiR780E3L1641btphAO60Y7Tq9AFzQEGj0MLjzEv?=
 =?iso-8859-1?Q?22iueM7lO0ip6SKAWmHn0iZntD4JF191y2Y2tlbm2TZhEpPSY6jyKnG9VI?=
 =?iso-8859-1?Q?XO68Gizw+BBhNCRBBuHBqpxwCxXJ8GJT8GnfeoWdN9DJf073DwYrg13bd8?=
 =?iso-8859-1?Q?dAECRQT5M13UwBtNyHE2bM5lZ/COfCZ7bOo4P2Z96mCAiFJMQAfUdVnYV7?=
 =?iso-8859-1?Q?K/1f2eaQifw9qsul67DF8yI89hSkQTUl1Qdmx/zE15tDzSBcb2QoBwSOEs?=
 =?iso-8859-1?Q?1X377NNNR7e1MBwZnGg+7xrz2uvGK8mDWokwdMSjV2Q2Gt1YtNS3cLvg5Z?=
 =?iso-8859-1?Q?WwdkFtvUYSTsS6CcDaHOimYjbiSMhmYyJ+AVy4PvvLWu0uD+ArtkHYh9EB?=
 =?iso-8859-1?Q?LNskDcw0wBf5z/P0nKe6ALudgNWbcWv+JneTbiCOSRgtpYNo8b56ncL3OD?=
 =?iso-8859-1?Q?p4LibH8sMhWZGc0s5rTuGjiblPnqWKgTNAcKxVbjMOv+hc4d/V1fU3LLcP?=
 =?iso-8859-1?Q?F4k9y59Thq/3tgz2XHn4Wfl3tRPYxatTSKURcAMpEuPXP9i3P2HQTe5zuj?=
 =?iso-8859-1?Q?LROCkIeQzcnkYVa8Uhh3W5PsSPYBT11LaKBFXQ/TTvd5XTd3iPtUcJc7QN?=
 =?iso-8859-1?Q?n8+PCeLPWhuf4SDZ6LunDMaFLJm5RP1Zr+320mXpt7SWjIt5UEPcASOPhL?=
 =?iso-8859-1?Q?S88wlM7ELLRrLqTq6ukHEyCHnGWJXd/uLZpBck2CNzhWeducnXnONkO26B?=
 =?iso-8859-1?Q?3olNMADgKYyTBGAQsx+wNmJCClMxawTvsri//+Bnc8jtPXXv+XJW2rF0lT?=
 =?iso-8859-1?Q?1MITI7gtTDqfYaGOpQFufqYfjxUQeI6jOyqJqQKKG1wlX/1ZTCfbMyS6fc?=
 =?iso-8859-1?Q?7zh9W3CbSDMmV//ojXO42AEUtEEewG8Xy97CjSUF6eeP69N67oh1UjVVuz?=
 =?iso-8859-1?Q?j84H8NS66kKsalGQqZcuz/lN/nQBYIgHVCWIOOfPNWq8F8uMOoKPq53oJR?=
 =?iso-8859-1?Q?9c8i67EE/mUT9PDUIh03X6mFKb0jpXdTfMm4eF3OE+kLp4uB941JAyQnkk?=
 =?iso-8859-1?Q?vj2Z7MWzj3f2pDZBq0++hjdGObJstG74qekXDNEJWBp6gwTU1xANl42rPh?=
 =?iso-8859-1?Q?5v/wKh/Rhvp23daHU3+oQ7EVWa62?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HrJMx/wrzdHRwdyNHO0MUAJmTCDPP02LoJVX8a0N/wyrXXeJZUPCqjfZ7G?=
 =?iso-8859-1?Q?MXf9Y/WwsihqdmV2C1cEywJtPDhKDqdRWKomN2nGj7PPWic/iLrRbZR5lK?=
 =?iso-8859-1?Q?wLIrCQnodpgVai7NsIfJXBLBZ+0ZxtaBrY63w/pqBI8Q0RjpA+AcC9cswD?=
 =?iso-8859-1?Q?ZMdT/kvXeh+2ty7QJXbbF4cWHpK1+2Xvq4sbq/Z1kUbqBl123Myt0GXi3x?=
 =?iso-8859-1?Q?8lgA+mJ49z7ZGrKGSRB5Jq2A28gF/63BywAvpqzwgkChLR2zWrIdGowX2Z?=
 =?iso-8859-1?Q?PiqX4QrFs/BpnOx3qMlUMI/LcgcrBJRr+Hy4BbbHiG4Zca1Xwclgj6tPrO?=
 =?iso-8859-1?Q?PakknheUiSSgfE6Vlywqo7wjJ5LR+lIZ7ob6Ma8w7eWHKzlbcWHJUGTNnz?=
 =?iso-8859-1?Q?oxEJ4MTGqICBcR9OmRPD+nu1Qw940QsZmniwnne76eiVIUulb9L8Rcyagl?=
 =?iso-8859-1?Q?6RYZlwbHxPxXAhW4b0JeTXeIY6TxPlKqMxjTtSuXOoyMT6xqe9WqB/al5A?=
 =?iso-8859-1?Q?Vpo4EayXFrw1PMwYjes+2tOhJTJZ8TEAbd/FCJqQU0TmyEAGcND5JeDmHT?=
 =?iso-8859-1?Q?lebNa8zBB9urym2gd8ZUcKb96axTcZhQni/a093dmlT/lq+jx2D4v1Yy4D?=
 =?iso-8859-1?Q?MEyh5xsQwIaInUcIgZrn9z2aZFMR2S+Bb7ba3u5OUD7WLSyuU2pq/Bz/dZ?=
 =?iso-8859-1?Q?UR1v5bDGMkr77ae6BzhLjY2FP23Axbyj8s+Y71l3rHKuf24z7zTaYZtxNS?=
 =?iso-8859-1?Q?0OPzdt2KjBdtnmcpp7nPG0tV1zcpF0LK9uH/TjsMYv/BRPTf4canLgrGhj?=
 =?iso-8859-1?Q?NLsOTDiAGQ2FMTXGiMZgkX7uPB8DtSFmIYRaCOIINflPRhUFfw+9FK1ROs?=
 =?iso-8859-1?Q?gcpQN3wkmT+CM9RKzYODJrWmosOSLYJoGKS6zs2MFrZedQ3ma2vvjjrYWt?=
 =?iso-8859-1?Q?EJU/g0qGysZnvjs0CKPAM1b/djCPGdp3owAPeV31cavSX3ETN10c8zmA99?=
 =?iso-8859-1?Q?YcKgTrcl6WOaErUU2lr9Xq2DKLZimg0KHKyAJG4Q/Tpe5uvEDXQ0VGt04g?=
 =?iso-8859-1?Q?8ffe3CYIIHebtm+WhNO322uz/u1+AZBpbWu4bx1wBv3vKg401r/gt7pau8?=
 =?iso-8859-1?Q?9mugZPjjxmKs974YSvouMAm+7eTMbgRPd/NWQLBl+3dshBb/hHMRLxNSOG?=
 =?iso-8859-1?Q?tLJvTLKiVTEqmiSjsdk94x0vh0EK7/R+qc1koihlK6gROTg56WeA8W1gsM?=
 =?iso-8859-1?Q?RznetLo+LZmtwOdhjMydcNvGsITzdnkj16KS4FAGOEvxqKqLm51dYJLSVj?=
 =?iso-8859-1?Q?RVj3yXXeMz+cxmR38B/rWPKtRi/2yczEW53LHEfUskK1kIzKs1Xfg1Oeku?=
 =?iso-8859-1?Q?JH9A0iazAWoKRl9AC5dkR3h35U+QpFBn+0vX8fPQs1GLr0PY/rZdaj3um7?=
 =?iso-8859-1?Q?ffa4HuMmyOqEDrs1M4baDiBx8+Fnd7eJUtUvUtq6Hm9sxYcggH1BfPcUd5?=
 =?iso-8859-1?Q?H1ZtT8HZ9JyyUCAPPSgMr9SUZhFNU2tjScHX6thXwa2cdS5A97h2ihI841?=
 =?iso-8859-1?Q?CUUmItcIogEhcl6HFHje66R3njoZJqAFOj54RLmo+Pz4UBginWFzr58iGq?=
 =?iso-8859-1?Q?WsuyswF/8disEpRJ0AMm4WR7Et2bbjSWjGVqS9YZMdd2+68I438NC659mx?=
 =?iso-8859-1?Q?uo3YgrWQlX0UYR/+F34=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fbd855-5a3b-453f-93da-08de0bebbc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:03.4843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHEixyqCJLTTW0Km65fBiGLtmZj5njkpKz7PhCpTiC8idDkW0yGv9+Ziee+qGs7tmsqfkveD3mtaT+1kTeg+N4wIOAThoPB8bdBgr6RvsOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 18 ++++++++++++++++--
 hw/intc/riscv_aplic.c  | 13 ++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4623cfa029..e3e019e605 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -297,7 +297,12 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -486,7 +491,12 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -550,6 +560,10 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..77cec8ece9 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -903,9 +903,12 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1088,6 +1091,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr =
size,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

