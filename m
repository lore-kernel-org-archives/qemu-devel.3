Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC1FC19F2E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnKtI-0004Cs-DI; Wed, 26 Feb 2025 12:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKtF-0004CM-Gy
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:08:09 -0500
Received: from mail-dbaeur03on2116.outbound.protection.outlook.com
 ([40.107.104.116] helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKtB-0006Oj-Vp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:08:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cM3xcCapSyiOkod8Mxcp1VJai2p85AD63Np6GHMWq0P6hXwdKF/UiQi8aeTsPmX+pws5faaqq4Io7KKp/eJFxc4D7GF821ldLL7F2YKDcAnxuVmiglA0rbeVWOJzEZSX707gtJLWgbSAJ4EAf7B6zgq16IrL1Bu95pSufXfuxvK43nlKFhnZx54TEjM0fWWZtNV1c/EgqBH3ev3Y+73ub8YGh2Tq9So37jBfLE9Vq8L/STOxsRQ12NUqf8pKCTKbc/FQCDqiy3JLppDYqN0sl36wtIYSx+eAzBfbpkiTG5LUVBQMREtBmcP0/a1LXqJQGbPDwCqtxL0DzVIZjZQ+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbWq8sey4nYExqgiiqp0c3oBzkfNpU1VUSr13xoBX+Y=;
 b=ptcS8aUyRc4uwn0Ks9J/ekwSuGqLdA/EaOjXwTk7TDn+uq43jwSy5FdV7rWpXXfkN1AlxbC/gttDJLi4cp8G32zRo6H7zihelTAAES6cfahLajIkKsxBZHa1CBxNrYTL/Dq0BP8qAc3EYbWtKrH0Pz8ajSi49hcxe7TwTZ95ECccSfNn0QETRQOqbPYoPU7dZu24l/gNu4fH/odqAMXhOhc9QIg+ZfQsPjSmmxnmsjschQzZom5KCflO5HVOip49MPOgsgK157K9XClu+tTG4BspG4smgxiGJIQuGaDVjw5z/t2O7/3SwjdKNQMuPLltZTQgIyT8w+MFQaCze/sAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbWq8sey4nYExqgiiqp0c3oBzkfNpU1VUSr13xoBX+Y=;
 b=fsB4MOvOQNh1gw7ZQ00DQfCtZ5E78AVIDWF0YWLkg4CiZdTQH1DddIhOCWx2S0arJ+3dXNXEK3wRrcHxeJatcZWhglRwTnoePCtViAPxBtiw/u0SbHL3dyK9JiuOELlMMBiW0yr11qSTE74BEZ/Rt63rV4d8nssTYyY6Smy9cWXAHzWa534RPPEeiqXtzPm/Oq4f2uRF/XeDO94nYQq1tq2k7NDvkChED0sVzE9Uslv4qlHsUHQQNaiPIBLn9E9MOqfwVTd3Bgr+Y5EKmWZklZn+rVYS9Zoa2PwNMmjOyJ+WQx4FRAm/AL/fC2Fqy6ymOdvYRLqCpKVz6QWEbQrYNg==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI0PR09MB7419.eurprd09.prod.outlook.com (2603:10a6:800:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 17:02:58 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:02:58 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: [PATCH v5 0/3] Improve Mips target
Thread-Topic: [PATCH v5 0/3] Improve Mips target
Thread-Index: AQHbiHBJvA4pfGMeIki7asRyZOfO2A==
Date: Wed, 26 Feb 2025 17:02:58 +0000
Message-ID: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI0PR09MB7419:EE_
x-ms-office365-filtering-correlation-id: c2656ed4-94c2-40d2-532c-08dd56876bf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wDVDrd67uuwc3LwuEhxa1xQhQd2jQCZkS7OGyxrfvYq0xL40Ke8pziSL1p?=
 =?iso-8859-1?Q?2SMAr46iESfv5jVfaVNeP7h1K5kCAOyEODWF7fw0W2yWEsvz1qKTPIGs5Z?=
 =?iso-8859-1?Q?gt46czWiG04Bs6IpGlYTVSj+FYC04Z+Sk1IkRoyS4E/UwK0SwBl14tVzrZ?=
 =?iso-8859-1?Q?u/DQsnqNM8yNNTrKEtv3sDWxb0iVkoaIJFH+nJi3D2qisW9qS5yXKtwHa6?=
 =?iso-8859-1?Q?UriDUrr1cH7V2tTToF93GZ4ZLGUGcvr9l3gaumMsAFfhCyYthkY5V7u+og?=
 =?iso-8859-1?Q?Dvg/XzKR/hOgVOjL/quoi3Vr9C9kOD5L9VzzFq3+7XUWL0u3zFt5HES7vF?=
 =?iso-8859-1?Q?dMb9hkcw4WimUt8cocQshZG55rGtvZ+YHnRteHO1+INAzGxpiJIID5NaoA?=
 =?iso-8859-1?Q?yPdbhr32tqNqkMoNzsQpOkLGVswnQ0hoW9/A7ZhvS+MgMNy8LnTYnUZGhz?=
 =?iso-8859-1?Q?uthpbWE5pO6EEFRNKE89klDwZcYwDhxiTK4D0rHaThwB+Z8Ng8VO7iMhOU?=
 =?iso-8859-1?Q?dqXC/Z8YVRCZSj+ScTWWNpozlX2Mk/ICWm9mrrguvQC1CmrIrL/kqe2TJK?=
 =?iso-8859-1?Q?HNCiBxhSuQwJN/K1TwOH22UgLD+Sqcbqyu4mRUzLFrSu7cVWDwlSXcI3BF?=
 =?iso-8859-1?Q?M0n0Z+iOzRmtzS4iKDV9j7HLytgDXTSNHFTKQQQ3SVghAz8nLBelbfkZvW?=
 =?iso-8859-1?Q?48j6Mvxo0OUNmqa6X9IgaS0IvuUdSWFpl/oiBbP2FIENBJcgJzs5pRUHnZ?=
 =?iso-8859-1?Q?HQVf12oeKSoIVDutdYX+pNz+0p6BJ6Qu+gMhdi9Y8v8wQlon8EGuBz3Lny?=
 =?iso-8859-1?Q?a9M4nLxYJAkdiXAIeHmdFMUxRo64E0tx8asMo1ChbgR7V1uZCpVtE+uXh1?=
 =?iso-8859-1?Q?4B+LVOa4qjFjTBsgSudM6qoIGer/6UEFSr5aOJJNE5HADOAfsJIx/iJAsa?=
 =?iso-8859-1?Q?jQy0EdPJmjVdjmjeKGWMG+rGDAxDmXcrBd/KWZCtiLTsBbzXCBM1h7ntnt?=
 =?iso-8859-1?Q?4TUjnwugXeWsjWTaFGozOeYDAnqNLJAPJxv9pBDdFRxrCgz68WJQv7JX5G?=
 =?iso-8859-1?Q?XHaLAyU1r2jAhOQ1Zy9TMX1GI1gprwSySH0rJGKDoEZ7huJ0JRKdr919bw?=
 =?iso-8859-1?Q?+5acHyDRcbGuKBPHF1tJnuRBVSyRbcTzFeZgw9FuMUqC6nqPtsvucWxVkC?=
 =?iso-8859-1?Q?PmHtIykiyulqbAJtbdViKCo0s6WKTkov9DaH8U7Dy2eaRQ44oqywacuL2J?=
 =?iso-8859-1?Q?HjUd01LH/PaLShJWs11GDSNqLc9Pj7P5JCAaw1mZNw0gI2HCbL1vtgwZ/F?=
 =?iso-8859-1?Q?7Bmuy2cPUUXUY0Tc9FwDEzWgsSeHtxJHa++L9j99uKcCeZNlG6sFFm6AAr?=
 =?iso-8859-1?Q?l5EyyCtCozSwmujPuO35BIcXAYDSCeVZrq7mnJwEkoxKptUe4TlP0RJgnC?=
 =?iso-8859-1?Q?2hciBoHgOz8iSBGaKUDBvdrf2uq4sEdhRRcgfs3BRVZzUYy1ixa9MHRXz4?=
 =?iso-8859-1?Q?6d2EQNQBvwRsgAAkgbYHCU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ESt2P932hFS9UNC8MW/k1cR7gtlyMJxTEMN2z3IbQORXvJWLgT0hShth9i?=
 =?iso-8859-1?Q?bjRKrnXtiwN+YSE6ebGHuioKT6fGA3aWWtbpC+7nyKKnWmcpwSIceW49Wq?=
 =?iso-8859-1?Q?RwpEjD0vcT5nMaEUAoubVbkmYAVN3bWPX+CSR0ueNnsJEUqO0w82GKBDeq?=
 =?iso-8859-1?Q?1eVJzKIrJlcKWgIYQWF7DkKZ2Wb3ESvD+5g8KxCKm0ZTEaXpFzjEY/Nmwg?=
 =?iso-8859-1?Q?mmnyk8MLwgK/oeTzh265cBmiTrBLpD/ROyNiIc9yu27RpGHtvySBat7WM/?=
 =?iso-8859-1?Q?rtMNZRmqM7Eg282fzOvD4Mfadg/YwEbxLOtSJ55zOSC2r+1sn3D9m8KBSP?=
 =?iso-8859-1?Q?AJ/JFjj/45tBRn3wrWQljkhuzZM1M2PUX7HMmgDVh0pvcB/nK7IHpHy7Mn?=
 =?iso-8859-1?Q?ojlRTSbhOy1AfX95pNPdb+XHLkDSY3VTAtjy+fRFAYWIcsgQN92qIMSKEQ?=
 =?iso-8859-1?Q?fhprknO/Ome5gUZbJC2wDKeTZTrrloEUqUd9hdki/xAP/r/gM7ZDdogI4X?=
 =?iso-8859-1?Q?z3Y3iWP+d/K28eITKKIgwABPQqb/HwSWhqo0jU3WT+ONtvat2oByAH3lJX?=
 =?iso-8859-1?Q?quU8GuEfaP1BdS4xFCRZVVPLKQPOQQ9/nn10dgHf6zo/PjDA661a/N3ToY?=
 =?iso-8859-1?Q?pvvLHZnSH5x/GmhEVgweefaSbfUaJl8c9fL7jLHO4xJR2kr5R6y7QvolS6?=
 =?iso-8859-1?Q?VN3fOq4TJTiVswVgMHVnIPwkIDx+lalkaVlXMXUCA8VT4SUv7hsdKG3DUj?=
 =?iso-8859-1?Q?FKcctp797WOyZ1ruEkysC2VfGzaB7zjVDgnj0jPdsHteHW6DI6D7Wx/3xQ?=
 =?iso-8859-1?Q?7gDIBkOzwnCcdr6jnwa/2X8d1dhvz1jATBEAZaDO/U5YWt+DROjJt8mR+T?=
 =?iso-8859-1?Q?zcfkJx5lZC0FSwFAYj/LSneRizHJGMf3WWIF0OihsW8t99Fw4NEk82so0U?=
 =?iso-8859-1?Q?KYTjgE67mSFni038YsINBAmC8gbajfEpWqsBajZrxDbNoHTadRUOwRbuR6?=
 =?iso-8859-1?Q?MaRxOR/TxBoXzgbaMdIDokPc+kO3SQsyY6fduv43hRAQ0S9noZlwSkzi3T?=
 =?iso-8859-1?Q?zoc/sqoWgt/9Q7338qpZGTRiYn47IOtwdxFrhzt6UPwI7KxBO1ekQlwFOk?=
 =?iso-8859-1?Q?zf8unvM8y2IJ4hkHV2yZnQzJtiEPYun71VRnJZHbAJxBbOA8v/kn6sX09J?=
 =?iso-8859-1?Q?Uj6qNpteaCKUCjcdhvNU0VnfyukXd1HLAfHgOzZ2SgC6/zhEnSyINcslLp?=
 =?iso-8859-1?Q?OB0wkyKFhQ9u0xBbBRm6A+6cUrnWWNGZFXeIQZfkYt4glhzl0VKElTXrhl?=
 =?iso-8859-1?Q?dcl3dtS+9yLbLap8ThU1Q/CR/P/kuFRyXWMGf+kfmHPGTve226URqtuOOf?=
 =?iso-8859-1?Q?FMnT0EKgN6iFHTUZXTMt6Fup9/KGevNw5bSVJJfTciPh2sVK6OJ7UXyMHw?=
 =?iso-8859-1?Q?wmKCJY0esOv1XfCnL6q4XkMVhRU08iHN716Nx/OEDJNvKZsFsUusO/L62T?=
 =?iso-8859-1?Q?jqFN0xpztCa6eo/sSdcALvHpuFPHjl6/hi9TDrmAcnnHCn/NSrc1ALnm3/?=
 =?iso-8859-1?Q?Ax+NE7/KE50EUXoZr/x3GX3c5wxId1zAVPqfXifqLoyL10whn2ltWmuy9Z?=
 =?iso-8859-1?Q?R3qJ2Cl9esVCSUsdMKkLvGjfkti7zQJoUGWD2zibh6ahNmulxOUWbr5wy6?=
 =?iso-8859-1?Q?v8f0QpteD7c6BUbncqo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2656ed4-94c2-40d2-532c-08dd56876bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:02:58.5884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJKnY0Gzy1ZXATvNG7uCOczdGICL08sHFeKINPGa75/OFKdZgiPXmPc5f7HcMc3RnPOL0Q/rqaVD4aBb1JxoAn1sTOQp127pU2/uCBmyFow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7419
Received-SPF: pass client-ip=40.107.104.116;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This patch series adds support for emulation of CRC32 instructions for
the Mips target in QEMU, enables CRC for mips64r6, skips NaN mode check
for soft-float, and adds a CLI flag for enabling an MSA feature.

The CRC32 instructions are available in MD00087 Revision 6.06.
Since the disassembly for crc32 is hidden in commit 99029be1c28, the new
version of the patch 1/3 is basically identical to v1, except tests
being added.

Most of the following patches are cherry-picked from the branch
mips_rel/4_1_0/master on the MIPS' repository:
https://github.com/MIPS/gnutools-qemu/
Further details on individual changes are included in the respective
patches.

Kind regards,
Aleksandar Rakic=

