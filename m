Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB654C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSqK-0002vC-9d; Thu, 13 Aug 2026 06:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqH-0002rl-2X; Thu, 13 Aug 2026 06:39:21 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqC-00014w-Pd; Thu, 13 Aug 2026 06:39:20 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACnrz3Knn1qgUMmBQ--.60519S3;
 Thu, 13 Aug 2026 18:39:06 +0800 (CST)
Message-ID: <4bd85717cd6d4abea2a6d377e89c55dd@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 13 Aug 2026 18:39:06 +0800
Subject: [PATCH v2 0/4] target/riscv: fix reserved/illegal instruction
 encodings
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: rQCowACnrz3Knn1qgUMmBQ--.60519S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4ruryxGr4xAFW5tw4rAFb_yoW5GryfpF
 4fG345JrZ8GFWku3yfGw4xC3WFgF4rG3y5Xw1rA3s09ay5Kr9avFZ5Kayjg3Z3Crn5Wr4j
 9F1Uur10ka4DJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
 Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFcxC
 0VAYjxAxZF0Ew4CEw7xC0wCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
 0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
 JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UMV
 CEFcxC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU5AHUPUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhpcyBzZXJpZXMgZml4ZXMgZm91ciBSSVNDLVYgaW5zdHJ1Y3Rpb24gbGVnYWxpdHkg
ZGVmZWN0cyBpbiB0aGUNCnRyYW5zbGF0b3I6DQoNCiAgdGFyZ2V0L3Jpc2N2OiBob25v
ciB6aWNibyogZW52Y2ZnIGdhdGluZyBpbiBsaW51eC11c2VyIG1vZGUNCiAgICBjYm8u
aW52YWwvY2JvLmZsdXNoL2Niby56ZXJvIHJldGlyZWQgdW5jb25kaXRpb25hbGx5IGlu
IGxpbnV4LXVzZXINCiAgICBiZWNhdXNlIGNoZWNrX3ppY2JvX2VudmNmZygpIHNraXBw
ZWQgdGhlIGVudmNmZyBjaGVjayBlbnRpcmVseSBpbg0KICAgIHVzZXItb25seSBidWls
ZHMuICBBZGQgYSBzZW52Y2ZnLWJhc2VkIGdhdGUgYW5kIGluaXRpYWxpemUNCiAgICBT
RU5WQ0ZHX0NCWkUgYXQgcmVzZXQgd2hlbiBleHRfemljYm96IGlzIGVuYWJsZWQsIHNv
IGNiby56ZXJvIHN0YXlzDQogICAgdXNhYmxlIHdoaWxlIGNiby5pbnZhbC9jYm8uZmx1
c2ggcmVtYWluIGlsbGVnYWwsIG1hdGNoaW5nIHRoZQ0KICAgIHVzZXItbW9kZSB2aWV3
IG9mIGEgdHlwaWNhbCBmaXJtd2FyZS9rZXJuZWwgc2V0dXAuDQogICAgUmVzb2x2ZXM6
IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMv
NDEwNw0KDQogIHRhcmdldC9yaXNjdjogcmVqZWN0IEZNVi5YLlcvRk1WLlcuWCB1bmRl
ciBaZmlueA0KICAgIFpmaW54IGV4cGxpY2l0bHkgZXhjbHVkZXMgdGhlIEZNViB0cmFu
c2ZlciBpbnN0cnVjdGlvbnMsIGJ1dCB0aGUNCiAgICB0cmFuc2xhdG9ycyB1c2VkIFJF
UVVJUkVfWkZJTlhfT1JfRiBzbyBhIFpmaW54LW9ubHkgQ1BVIGFjY2VwdGVkDQogICAg
dGhlbS4gIFJlcXVpcmUgUlZGIGluc3RlYWQgc28gdGhlIHRyYW5zZmVycyB0cmFwIHdp
dGggYW4gaWxsZWdhbA0KICAgIGluc3RydWN0aW9uIHdoZW4gb25seSBaZmlueCBpcyBw
cmVzZW50Lg0KICAgIFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9q
ZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQxMDgNCg0KICB0YXJnZXQvcmlzY3Y6IGVuZm9y
Y2UgZXZlbiByZWdpc3RlciBjb25zdHJhaW50cyBmb3IgWmRpbnggZmN2dCBwYWlycw0K
ICAgIGZjdnQuZC5oIGFuZCBmY3Z0LmguZCBhY2Nlc3MgYSA2NC1iaXQgZG91YmxlIGhl
bGQgaW4gYSByZWdpc3Rlcg0KICAgIHBhaXIsIHNvIHVuZGVyIFpkaW54L1poaW54bWlu
IHRoZSBvZGQtcmQgKGZjdnQuZC5oKSBhbmQgb2RkLXJzMQ0KICAgIChmY3Z0LmguZCkg
ZW5jb2RpbmdzIGFyZSByZXNlcnZlZC4gIEFkZCB0aGUgbWlzc2luZyBSRVFVSVJFX0VW
RU4NCiAgICBjaGVja3Mgc28gdGhvc2UgZW5jb2RpbmdzIHJhaXNlIGFuIGlsbGVnYWwt
aW5zdHJ1Y3Rpb24gZXhjZXB0aW9uDQogICAgaW5zdGVhZCBvZiByZXRpcmluZy4NCiAg
ICBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0v
d29ya19pdGVtcy80MTA5DQoNCiAgdGFyZ2V0L3Jpc2N2OiBtYWtlIGNtLm12YTAxcy9j
bS5tdnNhMDEgaGlnaC1zcmVnIGZvcm1zIGlsbGVnYWwgb24gUlYzMkUNCiAgICBUaGUg
WmNtcCBwc2V1ZG9jb2RlIG1hcmtzIGNtLm12YTAxcy9jbS5tdnNhMDEgYXMgcmVzZXJ2
ZWQgb24gUlYzMkUNCiAgICB3aGVuIGVpdGhlciBjb21wcmVzc2VkIHNhdmVkLXJlZ2lz
dGVyIHNlbGVjdG9yIGlzIGFib3ZlIHMxLCBidXQgdGhlDQogICAgdHJhbnNsYXRvcnMg
b25seSBjaGVja2VkIFJFUVVJUkVfWkNNUC4gIEFkZCBhIGdhdGUgdGhhdCByZXR1cm5z
DQogICAgZmFsc2Ugd2hlbiBSVkUgaXMgZW5hYmxlZCBhbmQgZWl0aGVyIG9wZXJhbmQg
ZXhjZWVkcyB4OSwgc28gdGhlDQogICAgaGlnaC1zcmVnIGZvcm1zIHJhaXNlIGFuIGls
bGVnYWwtaW5zdHJ1Y3Rpb24gZXhjZXB0aW9uIHdoaWxlIHRoZQ0KICAgIHMwL3MxIGZv
cm1zIGFuZCBhbGwgUlYzMkkgZm9ybXMga2VlcCByZXRpcmluZy4NCiAgICBSZXNvbHZl
czogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVt
cy80MTEwDQoNCkVhY2ggZml4IHdhcyB2ZXJpZmllZCB3aXRoIGFuIGFmZmVjdGVkL2Zp
eGVkIHByb2JlIHBhaXIgYWdhaW5zdCBRRU1VDQpidWlsZHMgYW5kIG5hdGl2ZSBSSVND
LVYgaGFyZHdhcmUsIHdpdGggbGVnYWwtZW5jb2RpbmcgY29udHJvbHMNCnJlZ3Jlc3Np
bmcgdW5jaGFuZ2VkLiAgQWxsIGZvdXIgcGF0Y2hlcyB3ZXJlIHJldmlld2VkIGJ5IEFs
aXN0YWlyDQpGcmFuY2lzIGluIHRoZSB2MSB0aHJlYWQ7IHYyIGFkZHMgdGhpcyBjb3Zl
ciBsZXR0ZXIgcGVyIGhpcyByZXF1ZXN0IGFuZA0KcmVjb3JkcyB0aGUgUmV2aWV3ZWQt
YnkgdGFncywgd2l0aCBubyBjb2RlIGNoYW5nZXMuDQoNCndhbmd5YW5nICg0KToNCiAg
dGFyZ2V0L3Jpc2N2OiBob25vciB6aWNibyogZW52Y2ZnIGdhdGluZyBpbiBsaW51eC11
c2VyIG1vZGUNCiAgdGFyZ2V0L3Jpc2N2OiByZWplY3QgRk1WLlguVy9GTVYuVy5YIHVu
ZGVyIFpmaW54DQogIHRhcmdldC9yaXNjdjogZW5mb3JjZSBldmVuIHJlZ2lzdGVyIGNv
bnN0cmFpbnRzIGZvciBaZGlueCBmY3Z0IHBhaXJzDQogIHRhcmdldC9yaXNjdjogbWFr
ZSBjbS5tdmEwMXMvY20ubXZzYTAxIGhpZ2gtc3JlZyBmb3JtcyBpbGxlZ2FsIG9uIFJW
MzJFDQo=


