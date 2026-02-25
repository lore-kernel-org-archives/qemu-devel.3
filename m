Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF041F357D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0g-000433-Pv; Wed, 25 Feb 2026 05:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0Z-0003zI-C2; Wed, 25 Feb 2026 05:20:43 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0V-0002uZ-W7; Wed, 25 Feb 2026 05:20:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYiJ1v6M1jgy1N9MRVQr0fwJhLMLGmQBtrI3I6sQ07RFuYGqHwISGZUGZ2D1dk9L1dSHIQZEnV/J7kvacjsf02HVkTQGI+WLiaa+qo2TbZqp6i7LLbZTiDmsflzF8ctxjG24qoSIguiDtxhnkCJ/7Xdu50cxg5NPp3Omo08+k9SwzfaQgJLXtyMsb3fEXkgGkaSzcrQSlyO+Ij3D1TjQhWaBk+xliObCKOfOuc+ltfcLtW14rJWwaptu0RZFfwL1zhXh7hn85D2NsVI40V7AidziHC5McyQicPqaKKbEOT7M3ChWAr4yumBDMZaT3HyHlDI1RwjoPV19WPv5gpRvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XkuqYIAZH7q/x0WcHlniRj5aMvyML8lcBBJmgg8ANU=;
 b=dn6CWB6Dss5JzESmBnCV7krgG+tIaM1KMfeB+dGL7qDNQcTcPhC2d6k959Pxe4ArEsNKvOlEQFLwaP+EN9p0Msu9vZl1oBs6sKV35rMIdhMcZB7tC/sgrwZYmA6bz9AGZTmUtXp4W42TCvmz/LivdtEdfRvxwVfqfoHxSeS5WcA8jMRgq5NJxSAhMN+rSglg1rmU1knXDoaAosRdxKszpIBoghRdQMmFS8yCBcyaDPjvqB4nn8KOp10igsUwD1RjE/7/ld61pxpSZqUkDBqTRCI8D8pMdmOchhIdssdJcGh6nOW/RfZL1a2VBFHdPXy9THMZA2b8g42WZuUVU1EB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XkuqYIAZH7q/x0WcHlniRj5aMvyML8lcBBJmgg8ANU=;
 b=psXAl0dz2DbShEtNQNpC32o7klK760MwzgEcLpvVFcca2ORjYTypUa77yVyRn46YqptivFW/J3wFU6R+stnS2Yh3p47wvgqP/rsnlw4qIUPhrCCU7dFW8Y+UXC+7I/ng3piBRfRHmTeElWfAeR3d0p81gsGaQFcUE5tUb1r74jn0uF0nA9XUZfNdM17cDU1twMVxH8PVQrRmgRdQ2pGWt6KYxmeTAbZC/dJYcDoyeIWHH+YI0tO66naX0BijR9CSQKGZOGv+ueDqBq2jkFWtBLfozz9goX0uM1qeFOnIH8nNuGnMl3pau0gC4uP3IShG09cZIlcD7zYMNIG9ZxrAyg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA1PR09MB7406.eurprd09.prod.outlook.com (2603:10a6:102:466::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:28 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:28 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 02/16] config/targets: Add BE RISCV softmmu targets
Thread-Topic: [PATCH v2 02/16] config/targets: Add BE RISCV softmmu targets
Thread-Index: AQHcpkBbkuQwA1H3C02oIGomaV/qRA==
Date: Wed, 25 Feb 2026 10:20:25 +0000
Message-ID: <20260225102016.200654-3-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA1PR09MB7406:EE_
x-ms-office365-filtering-correlation-id: e4d5aa87-901b-448c-77e7-08de74577f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: +j7qOSrOTpLp3ALYYikYriQ8gDidJNM8x9mZFNERha7RTbGsxCi0vFHxmNKPT/aBYz8CPKTZN6SIzlirkUOy4nLplOhd2cw4W4HnC8ojR545ulGrWk7nOtDLuPg/MyukFie0C123madJmqQ0OoLRItoIPULheWnyB4FFKz/cyIrkTkzU6yrmz9jN125EHH6XA2xPczP2cP7je7ZQW6qU3si8At8ltEaYtlqyx+njnhrt9kt8bskytkbFtd90iCPV7rVSA6CqMuClE8mCLqDDqn7sgqzAZefosg3JZQotDrLFOT+EEpldofIM71FrgTXlEyOT3llPZ8ZobvhxgcuLZOr5KK7v/dmsXY1gQNIVP4M+n5giS0GoIVxar2niSA8MNEzQ6g06vbjSf5qMRiXQ++peQwL3+og2CMNxzmULwFvrHD0T0x8Y2NknEypCvY82WpHg+i+cCRtKqQZcFp5nD0WIzbBcFc9C/QKmlROHIIk4YNcjwK5IQEyiT9mPv4f+BRnrE60SGJ99RkJDydsNEgDpVPCuyqQH70iuT/eggS3upccJFPhZsI7Kc5VMKVzylgtxaxztGOoXdnCYz76QvsGpBaa8h341ae0idJmU4WCW5uC8gOYGhdR/kLDjiB+BiBIkD0B2fiE8n6FtM29YOwCY2OJ0jg0YXmfB3eYBYpKnka9IVvMAFuqe6pY4Vv5Z9zdmCiSgvNBScHxE4ZN4xhSeetfudaX3Y3uIS8Z/6tMao4Qec5rW86veEdFxvVI2186tdKNUiLpc9/XWjTOwsYpAP9pOWCv5oysD+cf5dYI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZcPZBlcTMwrrbEKIEB6qJ0DTRWNg89tQLkEqPF2jw//omebFcMdfFl5t/n?=
 =?iso-8859-1?Q?WC2t1OWaIQipuUcs1YGyrpTOIf3T4gEeN1BN11P0vjmzVdFKVXheQbNQ9l?=
 =?iso-8859-1?Q?a/fZsn3xVmdwZxrKFO1mZSi/Jbw/t8oj5VZrYOp4XGSa0ssHe01mV1bh4w?=
 =?iso-8859-1?Q?n2Sn1E4VJa3yqJDZ2+3vAoCRrONfTRhrXAHKMf4vr+VuZgYrdyqgbKxVMF?=
 =?iso-8859-1?Q?hWtGpVz9O7yiqvjyh6FmxyGcN+v3MNwV/Q6sovj53uZcdT9dZB+QzQa3jL?=
 =?iso-8859-1?Q?pQo4+gnoTqvpxXWOZDdHaE79SLK71CAOj5kdOqLObNAxGkMoIO+aPU47B4?=
 =?iso-8859-1?Q?E/e7txYDeniCzU88Br2RTQPM5ghGY1Mi7UoW9Q9S+n3Zv+d3efEm/Zifi8?=
 =?iso-8859-1?Q?7wnL66VamDInmaDy56B6Ly3vHOX2Qfo5nvJEwcaXgWZNNftlt4T7G4sP9U?=
 =?iso-8859-1?Q?r4tmyxCsq3b8TUGJdQ8ZgmmnM9F9QhFbmpd4o7JLoHJSBDeFp0VgD01X+J?=
 =?iso-8859-1?Q?IVLGdESBwUxpYNKGPoM6COBqFCHNTyTMN2shuepo8oASnma0uqFogIlN1X?=
 =?iso-8859-1?Q?8OK0kyvkrIepj1QKNEuqRHBKSSMJcq4QN/Qba84onORrQx9P3XLjl0qE1v?=
 =?iso-8859-1?Q?D8xvtE1lPPLwV3fYQp0L9sllfDTTex0oNYagSTTG23V8kl/08aKGf8ELRA?=
 =?iso-8859-1?Q?jcK2WVn9b5+Uck4rzl+BygldN80OKdHt4FL4jF4F8Lz5H2lEuSy7qvQJTT?=
 =?iso-8859-1?Q?6pQ0IWAv1pixPY6Pm4yFdMh7WXEDzWk0/x/s/Ricl091FnBEH3KIOkIRHw?=
 =?iso-8859-1?Q?lDzqawJ9vCiCqFo6fos/CgPeMMscrh7O9HiwTxQFkJH7gMDG3BTpGtElUA?=
 =?iso-8859-1?Q?PeCkZlYsY7kYjTjwpCM0ArtWLHjMKkY7dNKHRZBe5zfhr5SUa7umwNLdXY?=
 =?iso-8859-1?Q?qgaHmrYOXpry1wpGGxCWtoNZS5XgjA/Uu9GzsgNPquXbBHq2fDu27TGJvC?=
 =?iso-8859-1?Q?5gPOcCLmPeV67kYIR8Cb0Vwehw5yVC10iZ4GxzYDk/P+95lA48o0PIx/NZ?=
 =?iso-8859-1?Q?HbphBXrLj1r4GLK3Hob08Ti2bxB7+5+h+jFMY/o6hdiLSOkO8zo6DRyzcc?=
 =?iso-8859-1?Q?YKUyD1D8/9pjXC/lgl5W/bBTDupgdsoCKRDMmd6OHcDVJFOuaSTojY5S5Z?=
 =?iso-8859-1?Q?kwft6FtRhgUp/4jF2zIxNzc1GditgfBnvIcjQXT2Y0Zh+cCo/3ahbs0H+2?=
 =?iso-8859-1?Q?ntpuXJNvZY1zECSd8ujsJIcHiS5cGuCykkIbIxLODMGEb6xutjRUp1jall?=
 =?iso-8859-1?Q?Cm9xqF0nTgo8xRbRv1U1jg5ugWRg9n2cyJHhWX5bd4n01986sPlJTL8mlX?=
 =?iso-8859-1?Q?ZtctaDthXNn3VlMX8SoNnrwRoKSKVVrukINw3p/ay5OEp6LUbEKcc9Zh0w?=
 =?iso-8859-1?Q?y+1u3JAXTrHEoBMlJ7Dw6VU71eQwEAwcecSunb86xBeNdr4/UJKFEnQ3zp?=
 =?iso-8859-1?Q?1cE4FIeJviMKPvcTbr/C7802M+FTtFs9sbtn6oBVsz3v6xND4b4Rr4JZIQ?=
 =?iso-8859-1?Q?btMr82i3jNmqK2Q3ySWbIw+fmIw7wJHxt/ZHsYpTfCDT8sIK/g3zTx5OIz?=
 =?iso-8859-1?Q?a1ex2bnH3UKS9nYZRLy6JtF5b5K2av1iIs+UPdzVYv2F5D3/wXf3hU549m?=
 =?iso-8859-1?Q?aqvM6Ycvn9Pnr8qCdTb434rPlw5T8Tkm5NVwwqR8yN8/0AiaRMKCWNxdXK?=
 =?iso-8859-1?Q?5uct/wY2flbN0xBPR+nscx/znPJxBbHOnZEu2pOD/No0P9HIoe+F/HV6DF?=
 =?iso-8859-1?Q?Ftg7LtOljwsa9f80zOpwz4b3HuV1rBypGTFop84iO9NEvdehyzFM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d5aa87-901b-448c-77e7-08de74577f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:25.6285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OG3u4TiqLi1r24EOku6PNq5U0Bbb306U5CsigYBZmbpB+n03gioPXdyD/qkPZP/J/e2oUgJHUIvNS7FZ2kZ5ieFm7VfaSbxujRnUKrnf6eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7406
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

Add new RISCV softmmu targets that define TARGET_BIG_ENDIAN=3D1
---
 configs/targets/riscv32be-softmmu.mak | 8 ++++++++
 configs/targets/riscv64be-softmmu.mak | 8 ++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 configs/targets/riscv32be-softmmu.mak
 create mode 100644 configs/targets/riscv64be-softmmu.mak

diff --git a/configs/targets/riscv32be-softmmu.mak b/configs/targets/riscv3=
2be-softmmu.mak
new file mode 100644
index 0000000000..27c7467a43
--- /dev/null
+++ b/configs/targets/riscv32be-softmmu.mak
@@ -0,0 +1,8 @@
+TARGET_ARCH=3Driscv32
+TARGET_BASE_ARCH=3Driscv
+TARGET_SUPPORTS_MTTCG=3Dy
+TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xm=
l gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
+TARGET_NEED_FDT=3Dy
+TARGET_BIG_ENDIAN=3Dy
+TARGET_LONG_BITS=3D32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
diff --git a/configs/targets/riscv64be-softmmu.mak b/configs/targets/riscv6=
4be-softmmu.mak
new file mode 100644
index 0000000000..528ecea2f8
--- /dev/null
+++ b/configs/targets/riscv64be-softmmu.mak
@@ -0,0 +1,8 @@
+TARGET_ARCH=3Driscv64
+TARGET_BASE_ARCH=3Driscv
+TARGET_SUPPORTS_MTTCG=3Dy
+TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xm=
l gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
+TARGET_NEED_FDT=3Dy
+TARGET_BIG_ENDIAN=3Dy
+TARGET_LONG_BITS=3D64
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
--=20
2.34.1

