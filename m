Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0949CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dJK-0003l0-Ph; Fri, 03 Oct 2025 06:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJH-0003kL-SO; Fri, 03 Oct 2025 06:46:47 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJ5-0007NV-JG; Fri, 03 Oct 2025 06:46:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa37WYVNOyhaAWdBI6VOtaHC1mwTthjy23+y1PYFpxb6r4LbwFvPiCgesldJWuVNWAjccKDsae14GC4GK68CnNBUTc15SY2m+BdrDaP/i2hznUwlrWu/UTS1vAkb2Z5DVMljHBnJoWxPFX3cqYr3ZRrAN8bUQv5lkiQX9YkwyrvI1GoDCu83OOZ/NhowDfLmUMT9lQhgtMhkFkcmY6KSnaf0a3G8qYeeUu5iH9sX2MkS1eatl7L6F7bAEiYNUFiSMBcE6mqpifbZWZsPSOVlz6PXrvGdEVI72aOK1oIRns0vw+SkE68pYpFHOxdqNvg3d4kItPWcBCG0BEpC9PSYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYPXFHvRZZqtjpQMe5wobkDshQarpp8CvNd3n8QfMmg=;
 b=SXGn8mm5LrlZ1T5zrS+Uyk9OzxlzYjthYDMTMOyC0h4jIAUxleDLw9LjFvIXKI1eYfsPiKFtcYCZ0v7S0O5JLnYbeWH7LFNHkbYA4w37FT+dvW1+8x53tHOBHJCwDaUWqG/CcNdIz521VBqnOe/XRGFXbbovRhNzQM+NAvueW+j9R7UwqwmbBjlubkdqViPMD5HRRs+Z0Pad0D+yoACTde7z2yrAO+g5L6CVmD+KYZVOG8637KdHXnwpxLDO3ndxh0Kv2Q5wFzTDYtvCGe9AtdEUeW8ps4+r+st6DqeVZJqYapC1twobYrIaeqzg9mXaAuw0XlL4bwgOgsm40KIfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYPXFHvRZZqtjpQMe5wobkDshQarpp8CvNd3n8QfMmg=;
 b=QzbME9HYtaSUfzFgpX+GxEXqfz6Gsf0dGDSHQGw3B+SepkbjGKOum3Z8UqLqLEvUNsfCEPBR0wcmMsU77BOQGj959xaVuM4ntKa3jsjHeK4/TOrxPi/phov7F9DaFleibHYVdvoIlLFxSQkriZEGjPfWU07ZyihpX0+j2GTgcfxMUEiR36UdFV4EKcY8xity04/irWB15CnMkLCGEoV3IacyRc12+iYZO95T8nqFsF85s6H+acWwb1l6tK3jLySSoOvAd04tFDTcg3tndJpKLed0CvUeBm+6wClj+EE2v6ApSXAL2kqAD9b0oiICOxnT5P0U4vt1hgoPE4HNtOFv6g==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7850.eurprd09.prod.outlook.com (2603:10a6:102:418::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:45:21 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:21 +0000
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
Subject: [PATCH v10 06/13] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v10 06/13] target/riscv: Add mips.pref instruction
Thread-Index: AQHcNFLRBSgfbmOIaUa1M1VSS+QD2g==
Date: Fri, 3 Oct 2025 10:45:21 +0000
Message-ID: <20251003104443.51501-7-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7850:EE_
x-ms-office365-filtering-correlation-id: 09069e08-20b1-462c-82b9-08de0269f3ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?F1RNoJIBHV1drWaSVJJCdHsJ8Yt2w+Nwu8rRQWWt0TLtL5kfWlwBu3jCEx?=
 =?iso-8859-1?Q?CIAnXy8wb1GrRy3DC+5F+IBh+ln8vkOx9GLx7zkmh41AXQx0xzy8Cm4X66?=
 =?iso-8859-1?Q?WBszIBQ6Lx4ORoRvEWHXz5U0wP50APeHC10jD7CXbu26B77+l9XRVTvbXk?=
 =?iso-8859-1?Q?mfJAgj0bTLK7WjN1DP8LZorAFc/Fq5T+Qc4DwEtPxWKtj6Rtn0o/wxo+m8?=
 =?iso-8859-1?Q?vxqpr11bmuUEMgyBWCNvoeJgm0B06IjV6oNHaOZL8HlTTEP7zJoudOUg77?=
 =?iso-8859-1?Q?cL2X8mWVwTw2I9sFWgCBnwoMTcujq3S2OqehTUowZfTNyWONc0PcWcpj82?=
 =?iso-8859-1?Q?W5QxGAWzoX5xA85do3l8Lz4aP++vijGbCBJfmW71etXGdJaF3hd44WTWcg?=
 =?iso-8859-1?Q?VEFeOGE5j8LRZOJR1Z8e+D0Ns3m/H0UclQqz1hCjG6bxni5hmUF+SZrP7D?=
 =?iso-8859-1?Q?55/3zTH+t4M4JJQ3BZ/pnbjcBiPg2pMb9LGKS8EgEcux8VUU4fQkNIumpT?=
 =?iso-8859-1?Q?ET1NxGzk46XMYqbs7WvueEB0ZJKBc8h4OUKCdGPRd5TCXRqvlQ2D7I/nRG?=
 =?iso-8859-1?Q?XgHA8cRKBFqJL4KdvGb6lz94CPozEMzuGO253HcfxlwPHJv5dz6rOIIH9G?=
 =?iso-8859-1?Q?fNmQHJV++gMOcJCgOkq/KKE/3prrguqUksi1Lkr1pzSqHh6qyG450JglkO?=
 =?iso-8859-1?Q?0XBf0JJIHVwWzgRftRgKekliUQ31fVhDZgXQQNvwBjrXe9LtNGpRNFJfT+?=
 =?iso-8859-1?Q?jObTPvQ3ti3wk/rHuDz5jCgJlniiMAOznFEGHUyFhwNHwDKIWf2jPnt2Ap?=
 =?iso-8859-1?Q?ShPZrm49f3XI3qhKtNcldhr5muwKrypwyBhgsFiAI9UZpOtD06HVnfdJ+O?=
 =?iso-8859-1?Q?cUncuie7tH9Ig5+PeA49ivnbKWKn730AAU7iPQfjoA3Jv1xhPbvi+67XAN?=
 =?iso-8859-1?Q?YNgRll8vb6sY1W215k6nRXms/tG/hu4X92kR1qIQ/b180w2Lp15WLQhWOX?=
 =?iso-8859-1?Q?KTqlsVY1z3jm4pQfKEtT4lHehJMXoVCrB6Gnd1OhUHOfwm+ZkEnb7ND4Pr?=
 =?iso-8859-1?Q?OHUUmnw/gMCHU5VkJr+UnavDCHY8C9o6DaOtlJFCSnE+kEmBBS98Ku/i9W?=
 =?iso-8859-1?Q?kLlJzJu8cZBBJrt6Pg01XfR3KgFgBEF+J1gnQV06KL+EZeVGkoqKTcO8Ct?=
 =?iso-8859-1?Q?u+OifXx9dRNGUng0YTq7iOqNdDh5HqYTglwmCr1TaiPAKk6epzjI/aASvE?=
 =?iso-8859-1?Q?9uBg79o90wjq/w6UDgmem3rvA7D3lPPvp/2ddSYJo3r74nI5NYnz92qqEG?=
 =?iso-8859-1?Q?k/JIvIiy4B1DHjgO13z3ZshvShJ9Qew01FWJoxf+iCviehcq8PtUozdvZr?=
 =?iso-8859-1?Q?aJucC8cIXrE3yLeNVChOBmz34HrWHfSqOxrm0VL9tY7SpI/ZUZ3GgXMWRd?=
 =?iso-8859-1?Q?P25SL3E2Ipfr7rHl4OENRKLsJWolbX9d4xAmO/b6N5eIvpvAsPNzF8YkQc?=
 =?iso-8859-1?Q?4KRJqWqz1t+8Hf+uWXp3x+6nvU5W85Xuw7pIsv6xoO8Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BHDcsk2gz6cMj9ilAQ7KBa+aXoOO6mWEjmOCS/xYanfZOBuYWRrLdCbyjU?=
 =?iso-8859-1?Q?WORqZkyJNNFo+sEo3uQaAPuUt6Bc9DVLl8Q34CN99j50p83osEmKpRxqcz?=
 =?iso-8859-1?Q?3PNpiW4qbv1+RyDQfhRGhfHhXa38H0ArcNmRBWXL6tm2t6BWY7YeP1yNBM?=
 =?iso-8859-1?Q?7ehn7rUIGwnS0D3m2E0cGWoyhZzFewEqd56yKkWK4C5Oxnzj0UaYj1+VZj?=
 =?iso-8859-1?Q?wOPlYI7wVbcF69l8di/i8zWs2t+LAepurVLRqbTWWrYRH7hfXTCaKyLK5T?=
 =?iso-8859-1?Q?jfsnfpHbA44uJ1B+MphivFit2x4gdb6f9os9bc9uqhOJ+VMQLaI+EUKQe5?=
 =?iso-8859-1?Q?jMCvaRPyM8b7W2BNGpXxVX0YODCfjGnyu7nKKVnrsYCl1V0FG7ZoPmGPHZ?=
 =?iso-8859-1?Q?ENxNTk7M4/FZj29UQrRS/HByx68zOhZVslxtjiIecSZ/QHHpxbqwrVaqad?=
 =?iso-8859-1?Q?XOy06YIQS5cKyXzlGwbVgE8PQTs2U/44ICbZJErsluytKAdWWT58T9n2uW?=
 =?iso-8859-1?Q?vBpEdFRGkakuabElSUnnqkTers9vZIpyRIhOnQcz/QpybcXG+uXCdLRyYV?=
 =?iso-8859-1?Q?sCOFjehPq6Q2H33z+A1KBiX5l420NajzPEvbJm0T9AqI53JJEgWMLpjZaw?=
 =?iso-8859-1?Q?v/289DjtjKLbaanRMXifbTasx3p9fDdvOYAvCm/GLDemleqMsPDSq8dvFs?=
 =?iso-8859-1?Q?OvGkumc+LWbA+1UoFm9P7YnoApo3C8eHoAx9nAKRMWI13Bwwu1Ypn+lt1s?=
 =?iso-8859-1?Q?bjK2HWmXbfCRYXfXG8I7gdZVx8lu7yK1jRch8K4+FHNgEmsTG9OqPWkK3H?=
 =?iso-8859-1?Q?VBWw23BZuwzph6BLc2B0j14TOkGNMW/scCcQljIaUO2QB/lcbOZ801Z7bB?=
 =?iso-8859-1?Q?w0eoGo+ZBcL/jJGDSaP+EGWNCDL4N5tPt28US3R2tSjRoCciuLvxT7Ghmi?=
 =?iso-8859-1?Q?TUbVd2fvTA3Om7z8AsLVWJb5E+DonhdVsXJSMEG0ySqmGAtXdwZordbSzb?=
 =?iso-8859-1?Q?85Chg/DVQxY3VWPHCIsViwOwBL8dk5U5TiyhC+iE1fXkzjMEjaehmsPb0W?=
 =?iso-8859-1?Q?zlmwFoX1WsvUxGVAH2htw+naO9iJDM0EKh8ChH8ihQ41xL62luqxFSm0LO?=
 =?iso-8859-1?Q?UHTSi8Cnjz6OT02cKGVJnwQC3djOPuyORnLLasQPXjBHpgFkGLKXY1T1Od?=
 =?iso-8859-1?Q?3Bky1DPNjw9TCSfkUFQdtOAEd8ryaArYKuLOY/dz6NFwYMSIETQc4WuTKL?=
 =?iso-8859-1?Q?56nIG+FN21SPPXqsc6M+7KcLRN27D1wC6YhTRU/pwI1i/TgK+fyc7rQZsb?=
 =?iso-8859-1?Q?OVduZY2XevEWwDN9IWvY8dHrNFIye9gyg1l6w+UrJwiyv86BFyoD0dTI2F?=
 =?iso-8859-1?Q?jInIhvtTQptrmOuBpUcN9piB2HJYwqnqYwPGJJEv1ia4SLmeequZnsCWN7?=
 =?iso-8859-1?Q?OgKX3Pm7NA0U0E+9tNJ468yxUY18UUHvRvVlzQi8e26IhoUiJH3vajLSr8?=
 =?iso-8859-1?Q?0Np++XRfbCsok1TmQKurduXpOUHm5euijz4FpUpIzMOLZqq7S+9ANzK0ji?=
 =?iso-8859-1?Q?eZiI/9pqOGiMr2EzlwpBw52gJZ4Leh+JPZQKzzOC2VeUbEPTr0WYcgPOg6?=
 =?iso-8859-1?Q?FCU4gl7eYixyBdNWLAiUmWrG0Ba57GpOAV8kYydV89Tb3rMtGzylwNaUKb?=
 =?iso-8859-1?Q?0QpOyW3PJ3ruKucB+IY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09069e08-20b1-462c-82b9-08de0269f3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:21.5840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4fnXgbo49qxVJkAr2cM4nvB5FW26vFdqF8DOAaw21oRWQq1V6xk1ZzaP4dfch3LXTzApq7Mywl3C/1kBxAd1e4fg1ZmTtOxVDUuyPUm6tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 15 +++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b03068fc8f..3a66c9408e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -248,6 +248,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1381,6 +1382,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3296,6 +3298,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..e4d5039c49 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index a290303ee7..dd3ee7ba2b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 3202fd9cc0..bfe9046153 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -9,6 +9,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -31,3 +37,12 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+/* Move data from memory into cache. */
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index fadcb78470..4215813b32 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

