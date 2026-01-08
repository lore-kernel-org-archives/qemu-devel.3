Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07914D185F8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqHI-00033x-Ac; Thu, 08 Jan 2026 08:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqHC-0002fx-5R; Thu, 08 Jan 2026 08:42:10 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqH6-0005p5-Mr; Thu, 08 Jan 2026 08:42:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lljLkbrt2EE9iEWcPQq00wBRTSwDAFua1m31x0huqOFUCwDw3NozG+VSjEQuSgInf7uv05/RvoaLzeIySRC/bpr40S9Lsu+Gu8A0ET6jKmjiViyefgzfOd9UyGUwl/BYvWhx4hPeoQ1kDblspSiSXhSCwJyYeFfKrkKuEDGxQzRA+TfPmGJQ9nyrSZix4Ugp0gKY628ouQIdfKe/omccDauUcireAZkWpX2Miq0oZmY9gAb4FQQ2bte+xDyHeXUy2kCthRY+LxPinRroSk1H8+xfTx7N9JTx6ThzMhIENT6PSrh/E32kHFHg7Gl7LOs/fFuswHQsr8QmAyU5hWuZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMsgq2eTMhHQu2EfHMX3/6BNemPFR7ME+dPQxfWW9ew=;
 b=QQNTJl+c9w0pEjJ2+5f1T1bKyoD84VCSoFFYAzjX52QdZO4ertOCh+SvseJa6u+ZEn+GP0aBs561/GTxADeG7RfLW6It3kG/whWxoKPn50skUCkO82ENSUD3lkXL3CSkxlJqzsPT8xN+uiX9ZrOinKTp6rk3IJIV7QnxLioz+iWF3jk7gx/kbcPy2BbsorGg4B4O46RcPnS9rt/+auI9fv7HSpPwoNhGDJaA4wCQYV0O5bFQ00+9RPc8bc542Jw7/e3nFRjbdQBKUhrTcQMjtKTs6tD+Eupyt56cq4JjWHbrpFWBkUlAvxbTX4jz6GjuSbcd90+UT7gLhAIJ70qHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMsgq2eTMhHQu2EfHMX3/6BNemPFR7ME+dPQxfWW9ew=;
 b=kcbutNp38ua3WSgqQUxcjvCNgiwc/UiGajQsGQ7ej1qKoUYTOCgqov3QCIDPR/U0WEId7BR6gsv7PkYKlA9X+jBpuKZZs3RDxvUkWvVF+nCyMlFAkuJ+9DR5ZYvksbJz78zeLpWsyIxHul7EcC1E+7CiMmb8wdQq+1Mlv1VBm+rwHsbIg+/KyqoRaDJ1J0lOA0ZPMEZHeL7IBp9qRkdcJJzs8GWT9JIH1R8jFwNR3s7n+pCXnJ6IqRHEit8rWr3pg3k1Rwwo785MzHGj8rxKvcggQoTvfzke+wVTOTnxuQggUvMiYzs5TGZA+6TsH3HhFxV8NWRuKVrFxYIUh5tvWw==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:41 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:41 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v16 11/12] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v16 11/12] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcgKSEWzcDwAwjI0KFk5lqxB5KRA==
Date: Thu, 8 Jan 2026 13:41:40 +0000
Message-ID: <20260108134128.2218102-12-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 7bc222bc-0563-4c56-c5c7-08de4ebba7b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Q6qRwtm7XXQg4GvjmALdIRl2ZKXj2rndHqdTzPjxu/RCA+KZgy3WdjW8CI?=
 =?iso-8859-1?Q?eW4ap5utQ5yQT9D9hJI22iKJD+0Dw/wVjY/TTHNd8Es15QTHmJQfLIINe0?=
 =?iso-8859-1?Q?HDJK6HqJW58oeRo2tvhXTuGPdpzAIWHwBo6V0QEya7hu5ZGb7x6vbUPSVW?=
 =?iso-8859-1?Q?6J+pWh6jqqBlypglmxUF51SAkA14Bevy145LjCE7V1SQvZX7/wutk0K0YE?=
 =?iso-8859-1?Q?zPC0whDMJoaa5mMtU01nubK8FjMTvCteotBOIgU8ALdlX5M4TrGZRi1ZLY?=
 =?iso-8859-1?Q?LJk4gGgZyJikfkmabpK4qiys5OQ2/oxZM9ttJJiB0QcaMqUZjwVVVQCNQq?=
 =?iso-8859-1?Q?UWiT0diCaolp2lKxxjOMqCCUbbJFT+KhMsvD3YaekYv4Zf8Mf/3vi6Ecp/?=
 =?iso-8859-1?Q?nIkA8vxX5RVKOLbev59Ghg8fS+mfKJkJFgp+JNpTOF0znqeMH8qbBM2XnZ?=
 =?iso-8859-1?Q?GqZsnRZ87R9Gzc+6PFvwMWjAmr5+QdaQRS/wCfMkTTMop6rfkJOcd9DPRW?=
 =?iso-8859-1?Q?UmJgtU0IWRrnJDI6HqBOAG8h3GkVfGq8FgadJhYSPfPBdSjYK+dlEf4nSS?=
 =?iso-8859-1?Q?dysiC47XrKFny07+5Vj+r5mSxT1C6Nt9WnV21ScOyH4ufXrsnTLNTGqe2R?=
 =?iso-8859-1?Q?s84yHdLPKfzR3karCp2bNAlIqBL3dLAyju55JCyAjB1dltqhnSKbNK2Ovt?=
 =?iso-8859-1?Q?GnlyxvIrU81P1FBPM09zmvXfjYS/EEqlniM5h4jo0QfvGtUqCf5qb4y5x4?=
 =?iso-8859-1?Q?yX/icH0HRdnVjTYk0HRcjtjv+W6wKAb5wIaNIJ2HGBMybg+bfcy/4fLZEr?=
 =?iso-8859-1?Q?EXtffoUPzz0e9gNg3TsYGHeArCb61lxZnqoyXIT3TP/dTrmlPcKqPacZuQ?=
 =?iso-8859-1?Q?GmH9OgRJW9FbwgV4PokLOh2+LuwAdQHVI6Rrev/MSvUHt9+6m9dy1wxNXk?=
 =?iso-8859-1?Q?v9sEKm0oVKfWA6iPWcLFefbw/+N5/QCiQWJxlolV3Rgm5Z6La6Kvcfft+J?=
 =?iso-8859-1?Q?qN4jVna+Fcn8ifPnlvQ4n3X/KCBcGR5l03xohs9226s7VoT1utkJTD7J8m?=
 =?iso-8859-1?Q?Kd2w+w83/OK8h/5BTWt6lct3NBQNxSib9dBc3IZthLuPPOSpFc2RKS4cZB?=
 =?iso-8859-1?Q?zrn3w159RuTcdkwnw2dFEI1GARHZQI9G86GZKPeqiWPjTUg2qLrQRGX3Wm?=
 =?iso-8859-1?Q?DHven1m9p3dlZ++A6nFomoMqFWXQSdhCAroS2Pbo5eYZcf5GRDC1Wy8cVN?=
 =?iso-8859-1?Q?+w10K7qUdKsVCFS0cCD/62K9lpRywd2zv8CU7KcG2pSa3ccgfck+vFrysP?=
 =?iso-8859-1?Q?yodJEoRAEkMBkpf6vRIvonEqrDq8dnpEQ62WabcqUHHFxH22ROUl/fyhAF?=
 =?iso-8859-1?Q?Wi5qO9G6Ic13I7gDuW8crWXzlPu7jTfBwlaZ6nsGBrvcXaWirh4FQVQ9t2?=
 =?iso-8859-1?Q?3Pnhs3cxGt+kHi3R1xf2It520Pd+G5S2379jpnpOmPweIs+Uh6KX5uWhgN?=
 =?iso-8859-1?Q?VD7Rfgw1Me65pRwESpF0ojOouId2bLqDawIkTeO0U5xXUkEIWgFMm5mdz6?=
 =?iso-8859-1?Q?5oJ9Ji2lV1rJ4ycd678REBGgun3Z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BZFkLdcE3QpclPV/l9OQVdEiXlOHYYeDOoHDBLOFKhpqc2rK8Jf2s2fvdm?=
 =?iso-8859-1?Q?bG5XCgT6ufZpHAzKXmsaTnqaAc7TioNzRPr34IRJyZwUrlUxjevX8L8cMh?=
 =?iso-8859-1?Q?06aAK3lsTNo4bh+ET24BKn1R7R2R92lQ/mHT7R2sxwEzC311ADqLoC+ycZ?=
 =?iso-8859-1?Q?psZtOqzU8krrC5entX00NZ/utIFoEWjNxtRM390m92Qhnn32T5TowyU6sr?=
 =?iso-8859-1?Q?dhcaS0Ar9VjxOMQZ2OnB+wFSHiISzWkMCk3cG8C96its//WXZBxFwpcfwc?=
 =?iso-8859-1?Q?Attum7lpv8OLBKqDZLhlou2cE53GuAZef8GwYDiVQx99aONTMQBlCs7tN+?=
 =?iso-8859-1?Q?OCA0UMVE5ZWOIHNuiI9MIlDylcS4UWjIIzp7kvFeFA4qHCVpwqAGlxppwy?=
 =?iso-8859-1?Q?bLc0/0nvrRrY5sly8ERo+ohy41V+RAc4S+8a3+bD/MyURyCFgimRpRPAlr?=
 =?iso-8859-1?Q?rm0RpS8qx0lCSEmD+v/4yLr/vfliDHqJAru0tRF3N5Lwdhl7OGX3RvfnYQ?=
 =?iso-8859-1?Q?np8RZt/yZMvNblHXmonqYu3AtMEO4iPzMjQqGyWdd82fQMJDtr90hwE/gv?=
 =?iso-8859-1?Q?F8bT9UZR/9tvyjP0vAE7WR653TmdKnH1EmYypOgAB0fSQrpRsHFR0bbwTR?=
 =?iso-8859-1?Q?otRi5ip4ENjkTJ4qP55H95zE8XxEwsnuyD/uaW4IqrqTmmZMMZiuF/c3S0?=
 =?iso-8859-1?Q?CROwe5acSzS4jLDBTA1ysY4Ef5lI3BLO/DM/s1C8rBggDt96JmYODeQem0?=
 =?iso-8859-1?Q?jWefknFWZ6OId5Hy3TdiRG7bEh/Sr68WpfpZuufVCgJ+w/nZJy0WaYjJuY?=
 =?iso-8859-1?Q?wL3qBA2h4uNUyojtpxfOKDlE516atGJh5JbRhmK/BlADkxX2TMrzU3c0ts?=
 =?iso-8859-1?Q?hi9EnE3YCJd0YXu6gurry3tAKJgXaoQQpr519yNeZFiYKQE14bpkZSziv9?=
 =?iso-8859-1?Q?OgFQVajs4wUEkLTNX0if0MaKEWlqdLp6skPkz3MT68ZpKNdkYRBQSN0iOw?=
 =?iso-8859-1?Q?ygZqf3HMu6yXQV1GwzdsMDokj6wMAzESzYs9wc4wYSJp71SFrXQ92TZODK?=
 =?iso-8859-1?Q?Kya3Ot403gRleAWEkj/dQfzHVSdw3FJh1uZ+LHZ+wwJIHPc7tvvvDbvEP4?=
 =?iso-8859-1?Q?mM8kRUkjO6+HBcc8l6pWeG56NfwpgrVyffT5SHL3Qtw6E2+sb5UcLxNcqf?=
 =?iso-8859-1?Q?tsRGHCrDzdAd03XDllQje15Rpi/8mBH8eeliJtfeiXFePL9F+SAYQGUz7w?=
 =?iso-8859-1?Q?2bDDrF2P/pOuZ+RxYzFLaDUIWu+q8ZHkyqVGs2ChJPumkeE0Aj4tQ2xL3G?=
 =?iso-8859-1?Q?sJeNHNk9K9aPOnJZvCd79xf6Lh8c9zzmVQ1dtJ3dNQL9GwMAZwNgNcYFdU?=
 =?iso-8859-1?Q?8ENgOC9pirlGMN+wbODf96S1BM8zJpWdO+L81RgqFzPK9jDYdaZ4TYZElK?=
 =?iso-8859-1?Q?2phfbM0AAbGR/FNnPIWIUz3E+tGsfhGb+lhlbasuzRn9x6X1uiOY95OXmJ?=
 =?iso-8859-1?Q?Fa6b0xk36uSDPC1WZ0MhwBJHqnud7xQWz4FlDXAPb7I9F0SFHXTJxHMxM6?=
 =?iso-8859-1?Q?aMmCT0JdV8Q/8CVN8H6hXbIUSm5csLj0REmUNNddvzLPGEAdPMcEilNWnn?=
 =?iso-8859-1?Q?7+PM0+UGMSZBahG5/IlmnfskEyHRrOcpEPOYFSBrdVnJO9KwR3ZHfbHRro?=
 =?iso-8859-1?Q?oh0m17kbRSUjyjG1oPwmRbZEWJ4s+Bq0Guiom2KJzxpvatPD8j6iLI3TT0?=
 =?iso-8859-1?Q?nHReQV91OG293nMwvvkCw26exnnjtz5d98ElBVrdIQLtSI7Q/8b7sfzLg8?=
 =?iso-8859-1?Q?C7AzD+2eTyAWMoI6xu1CnSJxkOf+8dQQgp11VtWheA0XDKQWnX3S?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc222bc-0563-4c56-c5c7-08de4ebba7b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:40.2504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/OC8IOfTusEFw2ZGCgX3wjZuz7NnHwP06PwC9VM+9WeENTUfTzXsCV/1rBU55cQSmN6eXQ+5/+aMFWwIc/O9AI/qBhS4XeaWlvcYgrPsvM=
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
index 1d9fa868c8..b90da096ea 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -424,6 +424,11 @@ static void boston_mach_init(MachineState *machine)
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
                                       0x1fc00000, 4 * MiB, NULL);
--=20
2.34.1

