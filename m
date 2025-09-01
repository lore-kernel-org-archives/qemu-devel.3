Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADC0CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1mv-0003tA-Dq; Mon, 01 Sep 2025 06:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mn-0003sO-1g; Mon, 01 Sep 2025 06:29:17 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mj-0005KL-S3; Mon, 01 Sep 2025 06:29:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq2QG5B+gEugeugKlSMBsKSSbym9TBzBrQBcKbX0FucSRwcZ7KxwzDZvOKkos1JPRtdZbs5E4Guc+ZOM40OdHByYt6UoC9hTfgeiGX6Eg7DTdBepuvrfOScMcM/fVI7uLRm0RagalQJ8pRpw2YywI7qNRkpiJSNi5jvjtf4oOGb4VJ5jgatJd+NOoj66s1l1kRztZ6mCo2GlbdAn1JerwrLZ4AeBLifygaAIG4wVS5t1mAc55lWPkeei+CGg6SKDmCRAihtPJ88kYhljL9nN0M7W3cN6eX777b8ILMs6vb+FYfaWyFtQNV+iTQ3SmQSxyN5yAfO5tu7/ZF6ULpTJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COW0u3llmiyuKvB8wV8E5La12/Izcz4UdydULptzmmc=;
 b=F026cDQ5GTtpRlP2eewq/Ym6P57ZO2+0LqT/NEK2ZCIGqUrnWzwCtMNDFdjZlDP5js1+fs2DNnLcCxc2GPSNvyvRq1QcLraOcTKi2NpezV8vSHhS0DCKZggGj7E2rX+LVeRc26jpikGgFAMSAn3oDb3vFkCrFM37xn3zhCyN8LIAyI/ezd57a+nEkzbktdDZ907Qd/Umpk5/rojzC/w49eRNA1/XXwYQXqhsoewijTaRL+8NOl9MTvp/WCqyQV0+4owTPpU1veSjsH5XsR8r9gBJI0WDNhLZGPyURlzD6DfkVvgz3/TqVYhqtt//1dQIMMRFIFrrSWDBxrWtqeSKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COW0u3llmiyuKvB8wV8E5La12/Izcz4UdydULptzmmc=;
 b=EPYEddeuDyGjPbQO/8lIAtqsk4UB6JkABszgPHLQSKxeuTFHlxM4QXxTfRSV98Htq74mTbDeyTGtCzOUEvLX9h5rzyGA1APYC7FKlJ7Cqvtn5mrUL+MzTHRzMfa/QOTy71zyz7/n2dzn4yn3QO/vc8xtDTLoSVZPHegOWcI+8WSo8bAd0bJv7LJS5K4Ayj9kBlm6qe1tyQhJLo0zAxSN1umcNQkX2YOZppaZqbTMO5ivQSaMKFPf22hWDz63QzmrGYHCHbuFZYV9UnVX+bnsXjhoVN9dqWrm+rsnNvLWuae3ISjSigW5il5avitpxsy4K6FWBitNOCK3WtAEXLb+QA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB6894.eurprd09.prod.outlook.com (2603:10a6:150:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:06 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:06 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 05/14] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v7 05/14] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcGys8IMDQFr1fq0WdbrdoZISRsw==
Date: Mon, 1 Sep 2025 10:29:03 +0000
Message-ID: <20250901102850.1172983-6-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB6894:EE_
x-ms-office365-filtering-correlation-id: ff48b1ac-d6bf-4c33-ce09-08dde94260f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XTnVVxHY9VCL/cGiQeL4Kdqu/erH9h0MqXdKDJ3HOT7ssYHQEqgZEO6MMI?=
 =?iso-8859-1?Q?AAP6sN67tYjyYtJmmKR10Y/sHTNKkFx7ZfMo6wFYMiW5sKPH8ZAxszUPs6?=
 =?iso-8859-1?Q?XCuoV4gGFvWlGnr4EONYWdvpIgU6l7LTJvAGHXTn4MP78JpMb0T0bWwRlu?=
 =?iso-8859-1?Q?OPcXvYHjVAeYMyztTPZD7RAIiRkEQcNr8Yv3xcQhWyj+XNicot1wnHwNMh?=
 =?iso-8859-1?Q?LtPG/dLyQOn5vnmYPgiZyI25Rn3NcTcEPOKWliGdNlJUTDcw34z62GYp78?=
 =?iso-8859-1?Q?KgvQh4W5EfqXlLV4+OfnYDD9mWEODqp9pX8zzd6eGmfYcIkn9GUnk52RO5?=
 =?iso-8859-1?Q?Uf/9WC+jr69Wv63wLmeS4HNZlsXZ6LPwvds8sz/9zH10CdpaHjSZDZNSBa?=
 =?iso-8859-1?Q?9zCNCp5hB4sOvyGzLjVAGl65KjzkO3T+r3w2Of4v4PH+dDCvTVbAZnaVmh?=
 =?iso-8859-1?Q?mEy0l8KMRPqPoY9M5/p79yJ83j3rVMqEtaygelkxNbIFGrkZVgXgTskfnK?=
 =?iso-8859-1?Q?AFD9B7YSynh1fmYhbueMQdUg7nSLHhU1WzilSnjABUVib7yS2ODfoNza1k?=
 =?iso-8859-1?Q?tcvUymtDjz85LRPo4vkOu7iGbWx0IAUBPLHjQTTudDyh7ZX+QhJlfauueP?=
 =?iso-8859-1?Q?ODsXtq4WEkf9+JyrIYk5wmnTOzJJdnixAPtufbLR43TYOMHcJ2eoCbs6+E?=
 =?iso-8859-1?Q?KEmcI680pTw5DHJtaVbbZrmLvB/47UvuZgwWQkObGngeqosTRZD00PUUqp?=
 =?iso-8859-1?Q?Ss74iNQT4bzqtQgqAxGzCEWlVN1NHNtJC5JasXCMYqMS4bN/e6mT6o0dcl?=
 =?iso-8859-1?Q?7Wm8tbk+iKABwYPdc6xteKNgB0MQfoayO06gzuYJBNDNT/JzvGI6QYtsOm?=
 =?iso-8859-1?Q?3mlA5L8UAtIUjtqPPnOryY4CpM+nY48T9Eh6l0eWdXpWbYLPLVdwjwthl2?=
 =?iso-8859-1?Q?6RQ3xDJ1RQoWxgtpt338cgV2fkF4yl4md0b3iJoSpHZFS8Trkq2YgZtaQT?=
 =?iso-8859-1?Q?PWfoH82geRketkRNs8IpLaPcnaGvtQvntnVw1yl5B6UOi6flpvHRm64bKn?=
 =?iso-8859-1?Q?NvRB1mkCntv0a8xe9HBJWeesst5Hd+FBhkPKcVM5Tdw187rv9pmZPYbq/0?=
 =?iso-8859-1?Q?zCw8VGBRW5nA5yhXsNKK9zHTO8/tuY6nM+tB3f9YMzIJOxFgl7gEz4jYfi?=
 =?iso-8859-1?Q?vR3EDMzfllFXQvYf9aiBkoraFW56iug0boa9GxS4R/aBDOBHWv5bQ4xt8w?=
 =?iso-8859-1?Q?LfIX2z7+PsJT9wrBWZqlsTtNx0Q1m5T4oRZtNzBVCL++Hr/3T+777Tiac0?=
 =?iso-8859-1?Q?fkC9+lV4MtVxnvSUCwJPiBhdLWRKxbTP+aHsdZfN0Rh6LksB1O49gmhVH1?=
 =?iso-8859-1?Q?+MKO2KIzSxioZOrCCC6T8+HlmXUDS6vGsveN3E36ENosUXl5WYBMuE2iFZ?=
 =?iso-8859-1?Q?LDqnpzznMte/NAbdzLWEFz3S6a4Wt/tI/PBof8XV3fxH9c//0m/5z9UyaK?=
 =?iso-8859-1?Q?KejVBhQ5AMoSJq2MSUgZ9Up2xLnxEf1BweoaArHRQzAw4puXTQs5zg0yns?=
 =?iso-8859-1?Q?UqHAZnU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0FVhc1YfVCaz9c+vBTOX0Mw76EhHC+F2+xOHwbZtcokl1KXt4IVNP5nH5m?=
 =?iso-8859-1?Q?b0ZbQtUtRFte+WMVtpN/EJ0PHj4nPmc2VFfHfLfIoqUcUCr63xLn+j7zKI?=
 =?iso-8859-1?Q?fq5sbYkTj7zEot5eh3UdRNjMM0D8sxXl3o8yMaUBFP4Zwf+siMUP13bvJK?=
 =?iso-8859-1?Q?1+zXYVOE6KiuYfd8pG+c4k0UGcC3R9tUHdx/q+WYTBWbIbAEJ4yjyeiJ1R?=
 =?iso-8859-1?Q?ySOrsPW9kJbb6Ouz+f5olo0+vw/4l/db7ml4wQFz/lP1JRHKuFQsbWpqwY?=
 =?iso-8859-1?Q?V+9FJ46t9e7/7xBLZO5t4N7OX69v1RkxPkRZTZx3x2kDcWj2iVh+1h63Cj?=
 =?iso-8859-1?Q?ei3rtbO+gtLeJ1R9/tQb0qArdtcSUg/9wOWRorof6dpU+aI4yUa7EP9dKy?=
 =?iso-8859-1?Q?X7m3tKjgNrl369tpVqBXilq89xIAuL0sG01RdpzzA5Ppww6nlg6AJuj+XK?=
 =?iso-8859-1?Q?oIFB5EQ1wDiqiTCJZrJYmzhKIHmPe4Z2e9xGu/mfW3gwEkThk48I9Mb7/H?=
 =?iso-8859-1?Q?O01tOmUSn7baAcUffjtsaG4+lE7vqzIHxIuOfW7OmOr20HTcoyRcDWC7Ue?=
 =?iso-8859-1?Q?ok3WM9aKQ4ncNLHgQu+msBxbXgXGlk9OaN0NTLVeldC5/iyWnGiS54bzG2?=
 =?iso-8859-1?Q?HZh7+HN3TElexQeRwDgsh4Fr6Y7Xa/5+/E3dxHvbch18J7JmT1ihzVJbLq?=
 =?iso-8859-1?Q?2ShfaOLuCd3HHuccYSQKkXxMsNmvfEqrZFE9S4Vtuuup2IdmX/WEIXRWH1?=
 =?iso-8859-1?Q?kdot0SnQP8XnIYNL9SggqK3lZv7THANVIrtlSYIVCTyVIbf2op1t+rPNzZ?=
 =?iso-8859-1?Q?sy8md72Yz3ouVlpHZ51nS9Qe6HAPdKHyCf3VzrOCacRymfAGFKpp11FsS3?=
 =?iso-8859-1?Q?cIoNuy9lU4krDR/1+p5b/LdNGH6s/NuGY6xLtVyfPdm6acEVo6xlPVTtns?=
 =?iso-8859-1?Q?icCnZJ2zz+KLYND/8MQM5t305iYkeCne1Xs229wfrXI6CL5jfIyDaKtw3k?=
 =?iso-8859-1?Q?F7q+L1GPJhYLjswrXSagl3Wzlf+9IkbPImIGKExDiZJyH1qV+8RAuYy2en?=
 =?iso-8859-1?Q?BtI4CTBx752IeAOIE4vJimiCl1FyZTIIUI5+gwkNJMMog350Ot1YkgBrfb?=
 =?iso-8859-1?Q?JOUNtAylYOeRmVSdjpWebPEfsu1vFhdxh4zQICg6vtefAgUzxqXKsRv9Ku?=
 =?iso-8859-1?Q?WPTwi1bNM0d7c6drk+q+iqMSsm5LTh5qOZ8x6LQgFx+YrTpPiGzUq20Jrf?=
 =?iso-8859-1?Q?Gf75jdfb7Jv+mdL6bkdp84sDxrvlNBBnrawGUiqaQ7sbLeXaRXvES6jD1X?=
 =?iso-8859-1?Q?EiVxJ4HxRq5O7jwlV0CJulbVjaIkIlwcRvxO1I+/0B+9HVIk3sNQIhyA0e?=
 =?iso-8859-1?Q?Ldil4LTi20b1CHkMqLlA6lnHTL61v+eqfrZ9PYWSoUAZ7X5UTworteJKLQ?=
 =?iso-8859-1?Q?4MvNqbBPxtcXRrZe1QpkAPTFIDkQOFnlDA2wS6/H2b/O1lAqQ8OtbjAHo1?=
 =?iso-8859-1?Q?AGCVmR8RdUQU7M4EDNRy/sqI13pyE4PPsCMuJ09bH2jF3+HL0ewbiUoQwH?=
 =?iso-8859-1?Q?CVQbbGiut0FCXcahUcwht24dPMVyy6ZNvnVcIgZMB+TlkrxsSu//qzwb4l?=
 =?iso-8859-1?Q?op8SaFlPhZoqltW8vST5sug7aGYTi1e0COl66V9zBjdyw122s/hnsB40qb?=
 =?iso-8859-1?Q?0y05fJoGLeK2Ss1o6nY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff48b1ac-d6bf-4c33-ce09-08dde94260f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:03.3677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVp5KrOyoJfpKRQdly1bofUPAtbyZr1wn6Gid4AQAthgGGXqN4IZ8pNBKh4cfWkS6s0i5QJrPFJVKCa0v1SjJ7CPKhwy7qmxorwBO834lOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6894
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                        |  3 ++
 target/riscv/cpu_cfg.h                    |  5 +++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 44 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 ++
 target/riscv/xmips.decode                 | 11 ++++++
 7 files changed, 68 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac72e49dbe..a725f4e366 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -246,6 +246,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1378,6 +1379,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3292,6 +3294,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index e2d116f0df..a290303ee7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..f5aeacc6fd
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,44 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2.1 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fbb6c8fb45..26cd11ec00 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..66d31b67d3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..cb334fa4bd
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

