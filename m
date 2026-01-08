Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68280D185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqGv-0002XW-LM; Thu, 08 Jan 2026 08:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGt-0002WH-Je; Thu, 08 Jan 2026 08:41:51 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGr-0005p5-2W; Thu, 08 Jan 2026 08:41:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjPAj2xeF9/NSUSY7iiUgh+sv5J3rQTPBvWLhMtO5iTWDVhlH+/x93WVj5CPcL8qX7uLVJQHHtK/D0M3CSJWtAdw/PGtsPmJ3q+bww8ZLBmEBOiiUg5cxfcCadb7+WD5tvJD+F9KYSTxl2wLjgxcgwYwtIk67P3bOLK110uyxSm/M1gQAeLV6nrd8SWcVzCOC9laR9ELeWngBmDSpvR2JZSg6SYs9M2rAenjUmnvHlOhwNJzvbdpvVyN6QvLT49DaJZUmxMotyzvPZ2SgAWgl+VZgf3o6JW2i8SEqLS/lDdr+3C0ju78tk67LYJ0KKtVMoz7yNgnLNnHYegAln4zxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fj0p/Aw1DZ9UYDKKxkB+oGJfU/Gmo3nFJ3k0WIEC+8=;
 b=SSndY5k2pEgp3SR7Ix5fk8OYTsIvKQPhXugGeijnXqik/CueU0oGDuOEp+QnYMb2hcOFfHMGYP5O2w+yV1N7TZwEJ5i37h78b81K+H5f9RTlqxNh1haaFGKOmKK3SbzkEbjg4vnZ2fjlDlhcxmaeqpErvgS6sRRUUxmh11ohmDRlZwVm0JAuylWEl0XS/efkj6coC5LVmQ82ofyWg1Gx0tQqBAV/jKXFZFTP9HmdhSVgFoKACBezFUI1Se22yA5Jm95WrLvclntNZ8NFhHbnntrvXcD/U4H78fMI+qQGVdk3rCRPqHHyIZM3CpZRCW74lJ8ON0IIFFt1KB0gXOL02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fj0p/Aw1DZ9UYDKKxkB+oGJfU/Gmo3nFJ3k0WIEC+8=;
 b=coZccGWbK5sWMvBc5tORr3tm8XFckrT813/T7t+CGiAaD0WnsfDkmjsZxbWPcLo12Xcb7sqmizDLwnoazJTfu4ezKfiu8w90haTNX5AgHcshiPTztgOw+2nALS1WYyi3D2NmyHiu1NsgMLS3lW62JS8otsXf2xwRqRhEIGxU5M4iuywuPNlBvPY9sA71i3A5YazTTIrPDpMXtbuvdabvWGLoYWCt2hPkgYePrdZuuxm9MSlvBOcL3DAL2VM0+HAchGmU2KYaTyaNZU43TOVWg0v4ycNpvb9EYdwfjWiJCgw5RdCM984Xwz6DgaYTbsEpCfrqR32uLi8Cn/yb66ODsA==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:37 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:37 +0000
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
Subject: [PATCH v16 03/12] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v16 03/12] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcgKSC4l23SXujKUip8B8HZtGfJg==
Date: Thu, 8 Jan 2026 13:41:36 +0000
Message-ID: <20260108134128.2218102-4-djordje.todorovic@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM8PR09MB5226:EE_
x-ms-office365-filtering-correlation-id: e549c6ed-13b4-4564-0ae7-08de4ebba54c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0FsOdFoyOSiBrRDT59SC0FHjwFCh8WZ7isuq8kPalWBEL/+OHqJRk3nnim?=
 =?iso-8859-1?Q?59azAVGLiX2lrHpGX/XyqEEJcN9lfHaKE4NAsCH/U3cu9L1ngLsJBBA3Pd?=
 =?iso-8859-1?Q?GcJGCbMmZhhKJzGKeQUqCZqvnJaw5xGjeo1NDf3FGjnIDI6CcXjNUtrb2m?=
 =?iso-8859-1?Q?fYAQB5dMRTVSHarUNmgLBq043zc0z2LKIrdbgxiu+umyQ9i6NoLcL4lWR8?=
 =?iso-8859-1?Q?NPxIreMaiMn6jX0TIa6P4GUXbPqGWqqzHovk7iZenvJKrvruUBbQY5VpjE?=
 =?iso-8859-1?Q?eHNJ75CUdsjyH9neO+KfQJS+uYDyyJZItdbYxIyiWB3RYVaGh8LIq7t6uH?=
 =?iso-8859-1?Q?ucz6X/I0o0Iga9fV7e+CTDn8EtBj5cTDiL2HeNhCDeX1jLy/vlCCYm4bVl?=
 =?iso-8859-1?Q?TGU3JgwfAdQU6eXMGreGfQWigeEkwGzfN3rJbQf2EGPtArNhOalkkDPqFM?=
 =?iso-8859-1?Q?3NNueiMN0wpLKCOJQqMmjVyT5shOz8wAy2NOx/VHRrakXkN2Xdx62dXztV?=
 =?iso-8859-1?Q?cTW11oBWaYPdakaJ38r7P/yOOTa9eD5dnpXjvwYU+vpOdlTzG7kyfIOct9?=
 =?iso-8859-1?Q?aOCh5xju4g4EYP+qEH/eZYFLEDdypeGtMGZkqSi/Rw0SWV/ncM4OSsJTUr?=
 =?iso-8859-1?Q?hVh/hCZCaoUnyTrfvS8r0KJmSCJZ+Y1CsJ++DjbgaYASRkdUlxHCVANXDV?=
 =?iso-8859-1?Q?Xa+PIHDFeyzQiDtSzJvnGceuFJRLu9m92+boXixmhFX8pK8p//c01NtNo7?=
 =?iso-8859-1?Q?h0FA/tQ19WOcjFi4eMGeLto9ITwITA74cQOdBzOyYn6rKUN7t5rtmF3e9k?=
 =?iso-8859-1?Q?wwvhg1I9SdssoJu/JiXE75ENWR34zLmus2gbgD5hKeHugC1VoyxWeXWqvC?=
 =?iso-8859-1?Q?Krzg57X7m5SNE2/xlKl9tc7KbKchNDWmekVLSoeoHd6JZ6P54JHJUU1DfR?=
 =?iso-8859-1?Q?Jcw3suJLxAucRlEP0heWoKZwL8cD/dwpmVlpoETFF7BRKE9s3FnS2fi+TS?=
 =?iso-8859-1?Q?ofcfDbEZdGHO9LOD82sy3ztq1h1KZUx69I5sBJRxrQtOboRIWmtIYiOZTI?=
 =?iso-8859-1?Q?S2704M/0LuYAjggjDnFBRbx2vSdi0A3gD8GcoOnQ2r4woUDIqXQUE72sNs?=
 =?iso-8859-1?Q?7LnL0dvmOj+MGxgLf6t3UFcf0+50jbVypBBDwoO9pa8/0nB3/RjOKwJ08M?=
 =?iso-8859-1?Q?QQE6bdVC/tmM9AfaJrheFVqC2IUXTliHXGeA66pz9Q5qnfaft9ghJFNCDY?=
 =?iso-8859-1?Q?N4m5zSMX0nBs1xsiooNb4sRrI65bJUeIqR7eggWW41TK7xpt6kDAnxBASV?=
 =?iso-8859-1?Q?8MbDNZ+AhZV56fRJmDkWpqskcnjKfuK4w4LNNG/ZhLfNOHPDcaDXmG/ISd?=
 =?iso-8859-1?Q?rqr8GkdaBysjsF0qO/Zmz0c8XSKouI2kl723ZajCnUgs4zTsAAdcYRkR+T?=
 =?iso-8859-1?Q?GzpGLyO+bPsDqe+BrxE/4uOYMMf8XoDOoJYspW8/651H8sYHLfg7gJZjx5?=
 =?iso-8859-1?Q?i/JaOnu8hEyz2HYtspbrBQXOlMqZ5YOq8BVXB0dTgDS+nfwxIRMW/rRV4I?=
 =?iso-8859-1?Q?7Macl140Rqc7qzKVns1NMueWdFK/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EYiB5KMok52hrB+HNPm/pNX30gUrHdrcwWv/jH3bEW64Jjdgvh5klQka8/?=
 =?iso-8859-1?Q?MDKf/uTZ5/AY1kMOW7ktbfHjU5GapoYP01hlSoBtGWMYX6QV01EXeGIHHq?=
 =?iso-8859-1?Q?zT/8BAqAs60jbaiWvjbsbqVh+Z+DBNLqNSHOn/qygerviUgWIKmkYf9mu8?=
 =?iso-8859-1?Q?R3YpyzVPsv5k5u5vg+VPTrE+7eEnZ5kHpj6CrOlkLa2ih4EG/PqJIodoxQ?=
 =?iso-8859-1?Q?7+OX9Dkxbw37b7mvhizdc16XWf2vv27/fRPpaggT9WUajbqDi/889CV1jv?=
 =?iso-8859-1?Q?NJkzUPM3thsw+fcGyCsSnBWy79HnyHblq3yMj1sROdGVcaMkXpMQORQIOA?=
 =?iso-8859-1?Q?/GSjGroI26+pmCyTZl0uDbizrXAY66hOdmyAj+Rq8sld9WFRBpgrGXtOyL?=
 =?iso-8859-1?Q?Cby3a2+QiJu5NKBWuPFSTOe0ehpfxIWuAhHtLQbk0GFWzS4UcUyu25vIhK?=
 =?iso-8859-1?Q?b8wk8Ceozzpp2OLN8FIneHf/l0NOBAu084N0cu6C8eYgIyIMtf9g17DGAi?=
 =?iso-8859-1?Q?xtwkTDfAAhbNZiQTAMras1RmZF29t1zQfDUjJl1z0DFznaNe03r9R0E9bL?=
 =?iso-8859-1?Q?Y+Rd2infO2ienclv2SUh3W4wvSWLq9MHD941gOrQf//rpvxZpbYEr2PNrO?=
 =?iso-8859-1?Q?82v/tPMBRoPoTDvpa2qCp2qiAxSh3sQofKSRwqm+Z7Z59SjDED1VYxe5bp?=
 =?iso-8859-1?Q?/L/eFzRdBlvyCgSD2w0rE2vC6VLvxWVeduTnsOXT14KepRe6t4DDoHCtio?=
 =?iso-8859-1?Q?rO2YfCxiS2pgZExjR5qZzmEzjcP9gbQSDU1NjeobAGLHSc1RtxFkyPySkC?=
 =?iso-8859-1?Q?ZFB6mDd+7LizCcmD+kDQsX3A327Ve0JCD3wCN8eKN5FHwpdEPHeGs3chNA?=
 =?iso-8859-1?Q?Et6XDRf5Uc7EWCV6oBFGvHsvXK1OuRzX8DWaO0eAWT52mTtyC3Cv8bB1cn?=
 =?iso-8859-1?Q?vaKX4nwErVPbuT7ixpNz5whaf8ja2c7VSrQfRc4kWKcd7fcvVTqqNEhTZ3?=
 =?iso-8859-1?Q?Fz0LLFACKTIDZh+IiggSthWg4HaQEAJOSVfAHYh/f1zoL48w5nt4b97Izm?=
 =?iso-8859-1?Q?dGhyLT+bPFCZbGkSUUXQWRYcFStElO0z02nSf6E/PVgW+QePn2rMm66rnx?=
 =?iso-8859-1?Q?W+DfoKatNEXyFvhQ6SglyP9/3LcXxO1CXOSovsqDd95eXVI0glX2qZaZhq?=
 =?iso-8859-1?Q?SMoYUP1Gm3qJFAeKv7kL41E5kAfo/b5oHDTuzO+6KQUJzAAFXrXvbuYvDO?=
 =?iso-8859-1?Q?tAmJ3Q3WhpHnKmoaTPxVZf9s6hMg5FFUxwnureLXnDqnBwOzuNLJ5XCGcc?=
 =?iso-8859-1?Q?CNgjPx/TWpD84mQU+vHlFeubdyJfGQhu3VYsETHc4M4Bol+h5iokB1A5mh?=
 =?iso-8859-1?Q?lX4QkY3niwlmuPZNt1qqttZkXtNf72wBpYCJgDvuI5Hes0MVo0tCXM++sx?=
 =?iso-8859-1?Q?8T6X/aTav1JsUJZGL673kLqa7apVyIBZBGWJ/Qplv9G/239TV1ACNxqUYr?=
 =?iso-8859-1?Q?bXz8z/xyyLQhqgMNyQ20b56A8SJEWq8X3Wvpc3FM8k2dN89YLhCGdQ9DII?=
 =?iso-8859-1?Q?hwqICWgaISQHSlAJ0xrUxSuw5lgYfJuwHbPR33pyy2NHCQHZCODT3o5qKf?=
 =?iso-8859-1?Q?pBfkuK/PqiBtVSlDQneL3ePE+73Iol+L9+XqTfi5ByHrd3K7SaQ1/P6Zwc?=
 =?iso-8859-1?Q?cVx6P/ci3or3NhzcohpqeojZfeYrKhPS/KRDhsJHcQ2KQuRu19tKsGeTNf?=
 =?iso-8859-1?Q?NzHHdh2hd6z5wO4kQzfkHisg5VqxLP97613Tn7queHMeW7wV0cYFNG1A/7?=
 =?iso-8859-1?Q?qee+1AkYhu2wln3JBQSSvV15VuKsmhvy2J2t+soQTAXOcdgUuvUu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e549c6ed-13b4-4564-0ae7-08de4ebba54c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:36.9534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQ+Lp+3EGpA+Eve96XSKNgpyVLn6mDSDnMicBd7rg+STWN3L8e9XJ+Ww/W75HUuG0Rq+/NlHELFEqOrXRHOJj7yMRflPL62xwzN2/VvIgZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
index f144107c89..455574f1d4 100644
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
index decf1e69d9..0c61c6967d 100644
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

