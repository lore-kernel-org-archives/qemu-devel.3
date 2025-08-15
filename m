Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C0ACA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 02:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umkIR-00013m-PU; Thu, 14 Aug 2025 22:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1umkIO-00013V-Ew; Thu, 14 Aug 2025 22:35:57 -0400
Received: from mail-m16.yeah.net ([1.95.21.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1umkII-00028w-PW; Thu, 14 Aug 2025 22:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
 MIME-Version; bh=uk8j70b4VECA0gBkqVVwYNQsTdIu9N/e3F2eyluSZmI=;
 b=MpEygsKEmsdRTPjYvWB2k9CEPl0KgjB8SE1ZuDg/q221WcJQX1J5/f7eeWxMvJ
 9bsO70BTazraSmVD37+i0B8KGe96JtiPBsU/PXzDCxGEoZMXKu3uWKw4uQ/Sov8d
 8pDBKOO0Sxz9tJUSInKYOIGJg7fArw7h+X/bsU0FZHOBA=
Received: from OS3PR01MB7756.jpnprd01.prod.outlook.com (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHryHSnJ5opRWsAg--.49805S2;
 Fri, 15 Aug 2025 10:34:59 +0800 (CST)
From: "z_bajeer@yeah.net" <z_bajeer@yeah.net>
To: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>
CC: "yangjialong@rvcore.com" <yangjialong@rvcore.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBhcGxpYzogZml4IG1hc2sgZm9yIHNtc2lhZGRy?=
 =?gb2312?Q?cfgh?=
Thread-Topic: [PATCH v2] aplic: fix mask for smsiaddrcfgh
Thread-Index: AXJfMDQxjxv4VS4NCK58FBIJAbLnVtNcudAm
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Fri, 15 Aug 2025 02:34:57 +0000
Message-ID: <OS3PR01MB77564AE45A505FA83349E6B5F534A@OS3PR01MB7756.jpnprd01.prod.outlook.com>
References: <20250811034454.189208-1-z_bajeer@yeah.net>
In-Reply-To: <20250811034454.189208-1-z_bajeer@yeah.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CM-TRANSID: Ms8vCgDHryHSnJ5opRWsAg--.49805S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUogAzUUUUU
X-Originating-IP: [2603:1046:c0a:2099::5]
X-CM-SenderInfo: p2betyxhhuq5hhdkh0dhw/1tbiBASqI2ieP+3xIQAAs9
Received-SPF: pass client-ip=1.95.21.14; envelope-from=z_bajeer@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: 49
X-Spam_score: 4.9
X-Spam_bar: ++++
X-Spam_report: (4.9 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, MIME_CHARSET_FARAWAY=2.45, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

cGluZwoKaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VLzIwMjUwODExMDM0NDU0LjE4OTIwOC0xLXou
XzVGYmFqZWVyQHllYWgubmV0Lw==


