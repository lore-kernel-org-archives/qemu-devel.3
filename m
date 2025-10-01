Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3A2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tSk-0004MP-9w; Wed, 01 Oct 2025 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSe-0004Li-TB; Wed, 01 Oct 2025 05:49:26 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSY-0004v0-8i; Wed, 01 Oct 2025 05:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tomq6Ksis0ByDbDmP9t4RHVUBqhssk1c6yrYqSXmvjD20PWnUKrrIDPv7kIzmOLhKVFJrvEg+nXP/5DsICVttUV8KuyvOV+zvFXFyFP5rtV6RMCZfQChRlTipYRgE1zOCKp6vXE3YW794BGYeUDmwGw8Oq9uzzho6dUZEUISR91eluo6cuiL6pv4fZyzzc+D8m9TtySNMhVQIRTwA0XKjDAMrz1+FtqmHicWVoTxaTpHNn8C3VfmVShhQDDHTz4UT3tcbmYx5RcdAJ3MhxeOLQ5QlYGS1RPKoFxmSYTA9lVCPoYFFfYJTPDlV1KoW3HQq1DbxP/NfAtLbxqTlbFjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTx+bo99z3OmXHkcyQlNX4By/5Z/eKxjUgRRVZa1FoU=;
 b=Q95c7XnNh8GuZFC1r+9DT/Y69FS+3SIYgQ5Wth4se7bKhm+U6EvcNIl/cX6MbyZvA7swgAP+HOQC3uKK+4JxIf8onzhQrhoT9vo6Y1AZGmHyNciKISDoJ2hO5A6m5yDNfKE1q/3IM8BLXn3wlPVqNBnMBn7lNqH+p1byg5yMj80RadYNd+kNbsTx/ZjzwOJqJyHPRofirjKA3WSl9OwQf4nJELFI2ZW/RiufHzowZB49m2QlFFoAECqxcQzS33tftAy5vANRwnP286Z13xejUq/4d22YA7QBal56jOeUzY1Do7vmdx431pa6Ml3sTNeYhNu9s/vIHck7lg8OiZUACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTx+bo99z3OmXHkcyQlNX4By/5Z/eKxjUgRRVZa1FoU=;
 b=vULDKRR767uGbrmqTqOQ58Nph0Lc19S3HWCR18c/dINFzezDX8oLba1+FuStEkZKXkFAvW4w9jHIXVIdzrfPr5H6C7Ktb5VM8aANwoeGYDegQba9KWu7+CDubUIYU8LldfE2Dh+MYzAXNs3poIg53J/ZZ2Wf0kzsKVx9Tj/Z0pt+Wu5gMU0YFU4jsaqOxijAxcRSLBswabsXaHK1ifHy4dn4UIG6NJIOzrBwNAoq9D1erWeVDUMmei3n0htt2MbmjOpYKuNdQCT323nD9gcbRB6MKAzRFKU/sAelxddIlcDDNXihU7r9trtTXgiB2G0tpzqMUiUzFNcaYGq8KBK1QQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA3PR09MB8279.eurprd09.prod.outlook.com (2603:10a6:102:4b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:09 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:09 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v9 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcMrii2Cj7j1jFzk6/YVvdCmjUKA==
Date: Wed, 1 Oct 2025 09:49:09 +0000
Message-ID: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA3PR09MB8279:EE_
x-ms-office365-filtering-correlation-id: 95c7bb21-d32a-452c-38b6-08de00cfc4c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FhVlr0z7kFyzdlZFrJ70UNqCYQE3TCqEmqapWqc0w+eDoWzHTXGRNwewHE?=
 =?iso-8859-1?Q?8JLvK2Qgx3128OJTSfTD6lDsY/G09P/LLFNKWUyn/cMAEjKmY/kTxaP1Dz?=
 =?iso-8859-1?Q?Setvlb/7l8egUamRUB/dvoKpH5coFUu+0a2M2MiN0hwObzu+8NxsPCEVq3?=
 =?iso-8859-1?Q?+v/f9jjP1Hozdy9K0oh4u3JatkTGrHlyS6AsNjPamKuk8zyf3b0Qcbb9ts?=
 =?iso-8859-1?Q?NjmX9mct0AMm9XTu5XL7WTg1KnNy5pMi/iX/FvZK5PAkrRPFQkvW9PW5fr?=
 =?iso-8859-1?Q?CaUM10i8ugiwAR8fEhcsaV655c+J/zQaNgFF0uKppsNLbVNN/NGyXFBLR9?=
 =?iso-8859-1?Q?yFLNF4N3X8NMrGLRQH+f92/776L8ZFSOjlueWFs+/zKOIwVljQInQWZuLe?=
 =?iso-8859-1?Q?gUBfwVgjWeVOI9UQjbBDOGNcJm7hBD+GwavIYID8POVsAmSva8RfVeyrqq?=
 =?iso-8859-1?Q?ac+0sorEZpQxNxKoVmMjfsLvkQq30bu8kqi6wJeFMoAoBH2j0IaMLBspdX?=
 =?iso-8859-1?Q?83W3EhxMvBGtahQCN3+Jl6oDFWPY3RaneIUDcRwu4Co1fAlC9eMVtP1EzW?=
 =?iso-8859-1?Q?cR0hbPVFRGo5Lb7Obkj86SyjRUOk3HZb62p1f1HNidRr3Hln1BJT+pCVCY?=
 =?iso-8859-1?Q?1Gq8bpXfFmOXDNAIAFfxxpq1DV1mTNYhOoG5mGvU+b0GAxQHOtsv9ZQqKP?=
 =?iso-8859-1?Q?YvIsKhjGKUhTrdU0oCoBtespaa3KYOo2xww1zOO+V7R1ZQ2PzKDkPk+rgI?=
 =?iso-8859-1?Q?+AhMGVtgONRVWo1IP9649U1+2pAuGMqF1fZpA7VHZKdg3ppl/CAHXK05Ip?=
 =?iso-8859-1?Q?UYIBtQpD4BZKULKWfutjF74dJ4T1uV4Q+L9FaLl/LSVTz2F4jO2JuHqt5a?=
 =?iso-8859-1?Q?9THtgKWxA46VJLO9FzENMHOdbNGZt9JLuLC1KbSI9HxxINJpGT+hp21/KH?=
 =?iso-8859-1?Q?887++7G2muRrTcacmFH/kGaf17CQyl0aWMbksiQzAyX9gqz1RpqLHmUF/S?=
 =?iso-8859-1?Q?qHFnLlBdAIzF4Sltr8OEgx9kVyCkL7m6XZvnpGpqGsIklQRS8SHQc5xT2B?=
 =?iso-8859-1?Q?msMFRlA0gnED1qFKoEr2xaL8Ab2rxGK1mr/OXlN+2JQjbWHU0f1guEftQd?=
 =?iso-8859-1?Q?akpZVvjGkwTTKwiI1wCjjMGPIylN6HWxi9FKdwM70NEFWKw6mkj8yGEAYO?=
 =?iso-8859-1?Q?Dy3tiMe/wK6iuZG5hVo3j+xWG4wcaBZK4O95490/15SozpUD0y4ArpZAUl?=
 =?iso-8859-1?Q?N1EMrEw5bCUYXI/u53wkzBswOXPeT7KTnWR7mlhmeIWsmfBCIt8F81iunX?=
 =?iso-8859-1?Q?fs+59y7YLSGr+gGc1bX0sN2r58b0p3nhu7g1H97oxhNhIxhyMumfdzHo0q?=
 =?iso-8859-1?Q?R9XZGQg77Vgxbe/5hw1wsU2chYAf9uWWq8Gbzu4exwgvD3hhcbr4OhAkJm?=
 =?iso-8859-1?Q?qrquYCVWJ75n4JtZO9Uz/rFhz8WjpIryzk1+E/VNz3ge/nIGPUADOUrIEv?=
 =?iso-8859-1?Q?Y6Em+zFAJK3kNzB2rKH9QnfU99IFOLb4NxD4AhCEBEMtN7vgCNKfzpgGzc?=
 =?iso-8859-1?Q?kRB1K7wfB/a0YqUGFuTxz3bJ2lDm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?20wuPa6a20HQWwwW+FcZOTcVUfK80qJtzvvTl5T4VVY4PU9EcFvCAd55dd?=
 =?iso-8859-1?Q?bhLpblOclTTypxSCAtuErECW2G4+K8nik/eJhqs/Gjl9TpMi24+v42AVws?=
 =?iso-8859-1?Q?DMN2CSKTEC+bO48QK7BPgF4j6qDeKwSUxtQ18j5FoOffJidR3M7x0a1g6g?=
 =?iso-8859-1?Q?wCmMtKqtSBGPrSEAK32jaXb0cwBKn9dag+Imd3Jnpy3br8iNMjdBQ/SZq8?=
 =?iso-8859-1?Q?TxX5inDDZiIBebDnI5poX4wpId3Bh+0Kp8EzTTgbWzTOLoFvN71xzYLpjc?=
 =?iso-8859-1?Q?QchST8m3Up60UBU+3Qpo54K4qImWVWCv24oOm36dS+dx9Z+Os2ilZtjjs8?=
 =?iso-8859-1?Q?xd24TYEfcrL9oLlsLJugrWrsSCgtupCZj9xqkxznpNqTRs2YJ+AgblZZJK?=
 =?iso-8859-1?Q?tvQGSFPYi4wsWKknGi61L5vbdfkiarrrYA6N74KL93HOkcqcFDxI1/njGM?=
 =?iso-8859-1?Q?K2nsBn++ao6Z8aVPomFsm40NS+9cHTraB/7CLN2hCM6HZxivM99ZOuXKV4?=
 =?iso-8859-1?Q?i3p9zgXMR6FWfly+R59Nh+xHmr0r+k40fheFUUWEuytwW1XJ9h5MR6mnWX?=
 =?iso-8859-1?Q?HE/xdTJ8/FA7dvNVfrJgHILQUUxbYfMHrfK0ptpBGH1lTTC24uuvTHjsPw?=
 =?iso-8859-1?Q?675ASFAxj0l4m6ic8XdCdIFaVfdR2WxsoC4RypWOsjCnkfqPUiZQJwIrTo?=
 =?iso-8859-1?Q?gXbX+SFw5x6l6IKEtmgeYpJDCH2It9GpG5tbEVGFEVXQo6SR03blwEyWIr?=
 =?iso-8859-1?Q?v3bjAS05YXb6tn0zRvg7/+bg+m/gYXeR1Ojj5FsquofwD/+VajP8lPb/08?=
 =?iso-8859-1?Q?OwH9ewlXQkDaq4TvBi79uRe0Qm/yePxIkMVSG54OSk3mJVuEqbnGUnfuBr?=
 =?iso-8859-1?Q?bTyVg/PARmhBB51llY/GhsoSkSYr6+zjMZ9y8caaCkw8rja/99IZEtn/VJ?=
 =?iso-8859-1?Q?XKsUHim0w/pwd7o5ApX7lcim/XD57313hQWC+wM/EI+4IwgXfcF8Zxok1M?=
 =?iso-8859-1?Q?BN4HNFqkXrJWgnkfEtLe75DiiEUBywbnCwnQ7y3/YtD90mfJneQtLDFv2v?=
 =?iso-8859-1?Q?drfzmX/Bf4++4h9A2S2DNWj4rklUqCw+w2itRt6WQsw2uKJ0D0+1vM4+2T?=
 =?iso-8859-1?Q?h/7GNEPRmBJYweQrpSgLc5bcY3I0B9LlbX561D3F2ffmyFlh6kbBp51Mka?=
 =?iso-8859-1?Q?MtjfpuTTQIVIIz/ckzAo5q1JTDh5P3yrmQ7dh+biaoENGxtltp7F276diN?=
 =?iso-8859-1?Q?5DQp3Y9T2bYejFQPztTSVoEEKjRbgBnnqlAJKW7Iesa1Ike3leAwwNln7d?=
 =?iso-8859-1?Q?jBx9wvC9rHKg74HQ1NYU2fnXRI8xdAzB21w26XVC+aD+ZV/Ezw46x/+vLw?=
 =?iso-8859-1?Q?5Aw/adFyT50g+ptD3XFkzYIyU16Xbp3rCp0stfMZM707KVM+MimuO+6b2s?=
 =?iso-8859-1?Q?C8IDbU2LrqV/KTnlGyPqj8fT+y83AEk5QdHjzPRQLQVCeEjvqShssnTUVK?=
 =?iso-8859-1?Q?Kpho/bVwp6IRHmMo5KwnE2RKqZm+T2CH2Pyc1lSBsiTjvS9yP8Z1eg8Eau?=
 =?iso-8859-1?Q?JixRjD7GWh1uIPfAbt7kyDgFXLNQEpvsVq6TV0bXJSEVuYTOhcgCKN11lZ?=
 =?iso-8859-1?Q?CZ3KTrSgmEMAcsa0DX3HtWgvegSnp2i/3gxpwt6seKYMzSssbOAUQqICCr?=
 =?iso-8859-1?Q?cFbOoYvFmewefCEADP0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c7bb21-d32a-452c-38b6-08de00cfc4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:09.2373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YSf4XguVtlS2Oykrbmli5AhiOmpWdKs7mT07uMpkbNCHeK6AsK+kicKgcq2KHsEwPOLXIIU8nR7jCbyV1nxTnGN7gttMNYNFyzQ1J/yvP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8279
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Removed one patch from the patch set:
  hw/pci: Allow explicit function numbers in pci
since it is merged to master branch.

I addressed several comments in this version and
rebased on top of latest master.

Djordje Todorovic (13):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add RISC-V CMGCR device implementation
  hw/misc: Add RISC-V CPC device implementation
  hw/riscv: Add support for RISCV CPS
  hw/riscv: Add support for MIPS Boston-aia board mode
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
  test/functional: Add test for boston-aia board

 configs/devices/riscv64-softmmu/default.mak   |   1 +
 docs/system/riscv/mips.rst                    |  20 +
 docs/system/target-riscv.rst                  |   1 +
 hw/intc/riscv_aclint.c                        |  18 +-
 hw/intc/riscv_aplic.c                         |  13 +-
 hw/misc/Kconfig                               |  17 +
 hw/misc/meson.build                           |   3 +
 hw/misc/riscv_cmgcr.c                         | 248 +++++++++
 hw/misc/riscv_cpc.c                           | 265 ++++++++++
 hw/riscv/Kconfig                              |   6 +
 hw/riscv/boston-aia.c                         | 477 ++++++++++++++++++
 hw/riscv/cps.c                                | 196 +++++++
 hw/riscv/meson.build                          |   3 +
 include/hw/misc/riscv_cmgcr.h                 |  50 ++
 include/hw/misc/riscv_cpc.h                   |  64 +++
 include/hw/riscv/cps.h                        |  66 +++
 target/riscv/cpu-qom.h                        |   1 +
 target/riscv/cpu.c                            |  42 ++
 target/riscv/cpu.h                            |   7 +
 target/riscv/cpu_cfg.h                        |   5 +
 target/riscv/cpu_cfg_fields.h.inc             |   3 +
 target/riscv/cpu_vendorid.h                   |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc     | 136 +++++
 target/riscv/meson.build                      |   2 +
 target/riscv/mips_csr.c                       | 217 ++++++++
 target/riscv/translate.c                      |   3 +
 target/riscv/xmips.decode                     |  35 ++
 tests/functional/riscv64/meson.build          |   1 +
 .../functional/riscv64/test_riscv64_boston.py | 164 ++++++
 29 files changed, 2060 insertions(+), 5 deletions(-)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode
 create mode 100755 tests/functional/riscv64/test_riscv64_boston.py

--=20
2.34.1

