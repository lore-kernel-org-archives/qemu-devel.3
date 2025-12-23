Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415D7E6F079
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXyzs-0001V7-SN; Tue, 23 Dec 2025 04:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzp-0001TZ-RA; Tue, 23 Dec 2025 04:48:02 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzn-00025T-RF; Tue, 23 Dec 2025 04:48:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6aPcLvRx7jEboQDQCbz8INVGBtrzyasc+xQUpDWmdaTJUkX00Qjit+nD45NsKEMsXwoSTtdEQMfyJeRt9C9rw/z+iKeOVcxEwlVx1F0IXx3grs6da6W6e+92ShPHf5Ewcz45qiGsCldil1pjgYpBZ8G792MJqKU9s1dgi8cZYnF1v3CkKzS5kPSKc8QCA9mucRsWqLC6TMs/QGz7Ot+QLCU40bf38Bxk5JkeMJH7RQSf8ulOLdEYQKlpFfoDJPYPJiFeltY7DddlwDE0M9uyRBs8mpOjiXjvqwOy+uz0+7Szi3ig5mG/0ZXbKufwK2pukLhcAOi+uR93lHEx0ecLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WYVTxE+FvymIPKyI3809k6HIt3CoHfJWvOgH09zKzU=;
 b=v3QwxNSrPA2KKYBFBzyazr4JhjlZQ25BGg2HmJVq2gZVrwIDAbUga5f/3Fud0G96ahZVfTVv3T5oMUSKN/pWeIBZJvwVI4q1Anp6Y/xbqZTqBTVpKNUN7hSM6Q6VnWD2qIRAQOJ9b8lmGxlEcvcdakSrN0IQnWOvVkr8cvRZjWhuqq/PoTyWJMttYSc89hbtoLGGBmqmtGVgJOtz08X37qseg3AMB0Zp7MHx+kM4HzPSe1HmdLE3YeNHgJkqs0IWzujOFE08EPdGQf38x69addkSDW+kvDERtNiWpamgmcXkJ1qGxkxw18qcDtrJtznbho6TM9XhxDWXFxvhuozkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WYVTxE+FvymIPKyI3809k6HIt3CoHfJWvOgH09zKzU=;
 b=jJYt8Ya2+ur+x09JjwsJrwRd8GpvoBj5sPT6WlwTlV44bIHTlllYzkJyAOxgaI0u8558mtc+Liqnj/4r74fM4vCcexYQoZpJU8v0cx7eyqsT5A0hoVTfX4AKugsyQfyM9gvkKwP7a+cFFuAIvv5cgGI+ljOj9VvKPIJl68EwqS/A+xqGpFWkGsoA6b5Bu8L/Z+9wMagRJ0Mh2+iRZ0fPYNhUn0u+ncxs+4ROHbvlJ0SO67OQyvfEBccWc1Lga8xaaXQp3lGuCjqaV1iF3/+MxM8ZmigU0xySTdd3vLi15wiMXyl0wEXnJdowFQ4FGE1kMKB18tHODcJ93rRB6/klZg==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AS8PR09MB5758.eurprd09.prod.outlook.com (2603:10a6:20b:539::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:47:54 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:54 +0000
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
Subject: [PATCH v15 03/12] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v15 03/12] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcc/E1I66sF+ox+Ee3flBWGNab7A==
Date: Tue, 23 Dec 2025 09:47:53 +0000
Message-ID: <20251223094739.1983381-4-djordje.todorovic@htecgroup.com>
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AS8PR09MB5758:EE_
x-ms-office365-filtering-correlation-id: bb993bab-c7ef-424d-1962-08de42085853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mw7Tc4IMps7NeyiABBK8Nilp8ES3S7B6Dj+Jy0ibChtv5voKm4s2Q7NbeB?=
 =?iso-8859-1?Q?AfhPpe5m1Dg12hYFEdLc3PJ02oYvieLOwMuJaIGoT6ZS/cuRNH3zPw438C?=
 =?iso-8859-1?Q?KD8inJsLxu2+mGZdXk21B4Xp9Q8WyQ/ni13MgDRSXDcTVe0Ql0DmHSYMVM?=
 =?iso-8859-1?Q?UCBxYKvv7guL97W8RubL/K0fdp/Hq0qajHjMq3OFBSZjyn+Egz6XH57nbp?=
 =?iso-8859-1?Q?pxDjtwLJiTu81hNo1RCIUurMHqDpLfaamzwWqHXYkssMpJQJr0OZ1BrmmB?=
 =?iso-8859-1?Q?2QlAJ+2lR6LOG/j2Skiw7wGSlJTUi5/gMKbL9y0hzgmxJuoGgsUiG3rkpM?=
 =?iso-8859-1?Q?+0JCbRdODQm6J1t0/+QfbHgR79uxmSi99N3U6e+DO0kCLqo3btuQtUYwPM?=
 =?iso-8859-1?Q?TPySy2FIWjYMHiGX7jKzosIdrSIUW50c6R+vnvEvkh4gGdJAiHKzIbhH3j?=
 =?iso-8859-1?Q?AEF92lkQ1ssNnvsOIb4TkB9E16Q4wwdO/tCwhEUIufIAcE3KTAwSKoQLBy?=
 =?iso-8859-1?Q?uSWxJwNdcpfEnIfnq8PbKJvaERb0SsUW5v8dMJKs8LiVdKD+owWfQMcl4c?=
 =?iso-8859-1?Q?6DBAjb/fBFFA1mstx2iLn3gmOhw4atJIDDYuDulR5ka7mIb287cLOCLu4R?=
 =?iso-8859-1?Q?1DOSkaIGPbhuUe6u3bUdb9HxeXtcfkCYXk71OvOSY1pRjBJe5wQhlXzbkD?=
 =?iso-8859-1?Q?qYlvGkPFHzVbbGURrZQ7qdl6jhUTvIQYzUx5RDcXCbUKUQdOTY9nudywfY?=
 =?iso-8859-1?Q?E7we+HYJMaXAf7U1qPEXcQzuoqNkEr7jnrDm4T94I1WFGhoepuVqZop1+/?=
 =?iso-8859-1?Q?H3I1aGGYM1sndUIunXG6c0vVwcRfUsuIMubo0g4QpzSbDS2DoCEuwIJ1z9?=
 =?iso-8859-1?Q?uN24ICiqR9+7M5h+KTNCRq6NSEvN2zucwMA1okChlMiobxQQwqn8Rnu1Hh?=
 =?iso-8859-1?Q?xKQrAGn1CWJoBPx+lH/oA6JH9JvcVK8P5V+moKMwxbf9fQ6keEljkWFrU8?=
 =?iso-8859-1?Q?HoyhSCacT1NPVcLVdSBTNI9EkDmQ8cxC2e6a37CycHLB1NTyY+hlbBGfc0?=
 =?iso-8859-1?Q?+IWcNFE4okohulA/mzJWoG0wdx6c+zOGsVUnypgbY6kRGb1wIKWDpw/5Ay?=
 =?iso-8859-1?Q?U3vpf6dcz+KG2/BO2wXTM+PhO9OnKarGiBFheJtn+S9afbt2pfGsTLfIGd?=
 =?iso-8859-1?Q?AfyysWUfpkPjXBAYEorJW3cis1R513PCO5crE6jpmXxc8ofQAMhIW6vnaN?=
 =?iso-8859-1?Q?vPNZ1SwwabxPpzhdeLbvppuMXvzPjTimKNdrWKIkGi1HGLi0LDrsKw5HkP?=
 =?iso-8859-1?Q?YBsDOqd//kCxG/F07pufeYE/JZ983mG8Onk/lXh5/0fU++MbUwOIW6sVyf?=
 =?iso-8859-1?Q?3xdJLzTs+Ggtrljoaq0zAR1oZCxIjRGqUTMX3tYgMvsEuV9HHapWcQPHdh?=
 =?iso-8859-1?Q?0WIviQd7CLwby4uhHjACVZfX26pccwkYbatxCHUc1hMq13cFVaQSm6zIpC?=
 =?iso-8859-1?Q?kiQthcYLtEr2UmJU+ZqRQnGFoEsZQVAhsuHo5y/dTRSnhzE0tu41AJY8BM?=
 =?iso-8859-1?Q?enEsdtvjDL+i5am/DkQa+3uGAgJH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/8RQf5FHLsnBwsszVfRy7QLNnNsRdMzmFJ0XspnywyfJvpIo7qVOKlKHVA?=
 =?iso-8859-1?Q?6WFRx6Y6tW/UQiKICvs5gIM0FI5TZ5/CwhNjUE2nIXy5NSbDAtyVsQEPAI?=
 =?iso-8859-1?Q?3zZ3N0iR7timocPoKWfBcuGnoB+qRbYNPyPLoQGP518Wh6pyfFHMBCIh55?=
 =?iso-8859-1?Q?Qm1MfVAmXN+i+PEu2BdJmOM+YWpzzAj2MgSXAM2Ntpfr+j8aJK8wWhlCyc?=
 =?iso-8859-1?Q?IN10XMf/fbIExG+3inORaAvqBVc9/iR1RUKgIChWyZrP/t7DlqC1138PdC?=
 =?iso-8859-1?Q?jBZilRHMulodaCqOMh2rGEFW2qcEwnS7XQY68282/yel4T3jkn+amIk61v?=
 =?iso-8859-1?Q?lxXOLYS3R22zKh6Lx9l6KC/zbiMEaP7maqfOxMrlZOgpoNNkpxJNUnL4UA?=
 =?iso-8859-1?Q?IdY1GxEmLzG6bvPuE75T9N7PYo0Tql0JE2T3TNGFK/RRAHXnDx2/v+aScf?=
 =?iso-8859-1?Q?lcyzUscze23IhL7MGblFIWx80j6S61KUiLq2eHZ09swKB5YVbjrAeAD3kq?=
 =?iso-8859-1?Q?JCLB73AnpHwj3jwWu9Hb/aHedjZ3kZjLnQaGUqMACg+Y+BZCWDVdMw/TWg?=
 =?iso-8859-1?Q?63tU8CfSu1gKOWmCxbwMQecGiP1/b71cgJjEpU+QXnt5YWCMLX9svHBIZq?=
 =?iso-8859-1?Q?44hQF0Ic74OgjoFFz5cqAOH+Oz4O0wgGak2B3rgqiQFqevFyFcOCpsH+2Q?=
 =?iso-8859-1?Q?Plz8//dw96LtSCNB4HFEMzaAgatST4esjB+otWbhoKeNaS+IG/8SqmFGxv?=
 =?iso-8859-1?Q?u0cj8FPZP/kF7D201w5ZH5sYhjqITo8JKxjNhl58PmMrWCz4lbxUGDJp4z?=
 =?iso-8859-1?Q?Wewu5CItCkKLg+3O/k5sKNTYs1gqyo2vlHgEcvYqToaU04y1Etlvz62cIV?=
 =?iso-8859-1?Q?KJdPnM/Yd9Oh6muidIjhST0aop7/v7FyC2xIgOgEDF5rf+K6TxfVS/kzEf?=
 =?iso-8859-1?Q?IKukgt/MSURV1nlkQ+WcVnTE3TlkSHYCcXOzbO3EcfEhpMPpWdb4vwcGC0?=
 =?iso-8859-1?Q?X83jtZFEfBVLuogwFoGuMMfYX2bkSB+uzRZo6LgTMMryNT2fbh+uhn9WeE?=
 =?iso-8859-1?Q?6Az24HU8QLiUlP+RPBbONFnw5ods8Fc8BUS1b4+BeBBdEa6w/dSZgRdkMN?=
 =?iso-8859-1?Q?ERYo8DbsQxSJYnAjwZqzdYxr/x5NHcNncU0fn/UK27CjU66HgTM/qBdy6p?=
 =?iso-8859-1?Q?yMSoDqjQy4v85/sgRw7w57EALq2kfNtudsQo10zzgiKVZmhONlVim5uoOr?=
 =?iso-8859-1?Q?tQSObREMEpOpiEIYcwYXzskgfzezwauOOfPhzTPJvol8hkHrfqVjFdWbTj?=
 =?iso-8859-1?Q?VZfVnDw0hpy3vI+FyNef7i1oOxB5J/lTcm9CV+Mwp1xIj9MJQe21ecmADN?=
 =?iso-8859-1?Q?gMq8tl4wHksJs4DQikQ0fHbcGkUF51juI+cMhl3KNzbT6zEkPID3hRPlKV?=
 =?iso-8859-1?Q?mBU6W8gh0/HMKmnkhorfAtCDsFN+RJKgKaW/tV2Jkc/bj7eiy0Tkfi/AH1?=
 =?iso-8859-1?Q?3U0rTa+d0Ykoo9A0z7AAKo3+ith9ZqXJTGmMFKRIKMlsDnK9g1yCoiDjNI?=
 =?iso-8859-1?Q?QP/+j54hkPdp85fXmwsvH4qUOEmLmbx3geBVM4BIaI12vN7oU/gufJxXww?=
 =?iso-8859-1?Q?WrrzdsEuHXOujb64V5NPX+TcDkoTQNBoG4nP06wcw0NOBrjapYDLKCVVMm?=
 =?iso-8859-1?Q?lbeh07USuqvEVbwuqV93JCqpvjFpcK9ve5l3svXKK38bCLqUqPqCSuN9Ip?=
 =?iso-8859-1?Q?2pXZXF5Mk/wNe14lPClgqcXE+PvEubeiC+aZYA7iDVBwqsRHqy5TusBiul?=
 =?iso-8859-1?Q?FQaYdU0vImanr46wRhG+IQ8qZqo4xn9gG0hYT0K6SCYvUS9sBEir?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb993bab-c7ef-424d-1962-08de42085853
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:53.3598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLcpJV5UMfc8t/tODEFqtbdrBPpEaFdQ55QlEdJkmzoCoIYI53dJ3MlNiZ/0U6sGgTaVj4CHw5lN8Xmvspqeg0FpEmbhYUkrpoVUYv2rjjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5758
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e473e36e20..0c3b8d4f83 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3336,6 +3336,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d49ec4d90..44f173b84e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -989,5 +989,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..25d59ef9f9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -36,6 +36,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..822e25e346
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,217 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

