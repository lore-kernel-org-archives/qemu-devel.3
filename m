Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DF6C5DF98
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 13:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy82L-0003yA-Vi; Sun, 23 Aug 2026 09:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82D-0003uU-Kg; Sun, 23 Aug 2026 09:14:49 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82A-0007Od-PQ; Sun, 23 Aug 2026 09:14:49 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-05 (Coremail) with SMTP id zQCowAD3Yz478opq7al2Bg--.8255S6;
 Sun, 23 Aug 2026 21:14:35 +0800 (CST)
Message-ID: <f06b7dff002bb35f1524b271faefe0a9571459e6.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
In-Reply-To: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
References: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email via .NET SmtpClient
MIME-Version: 1.0
From: wangyang25@otcaix.iscas.ac.cn
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Date: 23 Aug 2026 21:14:35 +0800
Subject: [PATCH 3/5] target/riscv: mask inactive senvcfg.SSE on read
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: zQCowAD3Yz478opq7al2Bg--.8255S6
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW8JrWrKrWrGF48ZF17GFg_yoWfAFb_Cr
 4ruFyxZ3yDZ3ZFkFWDXw1rAryFy3y8Kw1rKa4SkrZ0gryUWFyUZ3WkCFyDur15uw4UJ3Za
 ywn7GrWxWw17AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbG8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
 IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CE
 w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6x
 kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF
 7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv04
 87Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
 aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4xvF2IEb7
 IF0Fy264kE64k0F24lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r1DMxkIecxEwVAF
 wVW5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjxAxZFUvcSsGvfC2KfnxnU
 UI43ZEXa7IU0HE_tUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.25;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

VGhlIENGSSBydWxlcyBtYWtlIHNlbnZjZmcuU1NFIHJlYWQgYXMgemVybyB3aGVuIG1l
bnZjZmcuU1NFIGlzIGNsZWFyLgpJbiBWVSBtb2RlIGl0IGFsc28gcmVhZHMgYXMgemVy
byB3aGVuIGhlbnZjZmcuU1NFIGlzIGNsZWFyLiBNYXNrIHRoZQpyZWFkYmFjayB0byBt
YXRjaCB0aG9zZSBydWxlcy4KUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11
LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMvNDIyNAoKU2lnbmVkLW9mZi1ieTogd2Fu
Z3lhbmcgPHdhbmd5YW5nMjVAb3RjYWl4LmlzY2FzLmFjLmNuPgotLS0KIHRhcmdldC9y
aXNjdi90Y2cvY3NyLmMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyBiL3Rh
cmdldC9yaXNjdi90Y2cvY3NyLmMKaW5kZXggNWZmZDg1OC4uNzA3ODczNiAxMDA2NDQK
LS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYworKysgYi90YXJnZXQvcmlzY3YvdGNn
L2Nzci5jCkBAIC0zMzA1LDYgKzMzMDUsMTQgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9u
IHJlYWRfc2VudmNmZyhDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywKICAgICB9
CiAKICAgICAqdmFsID0gZW52LT5zZW52Y2ZnOworCisgICAgaWYgKGVudl9hcmNoY3B1
KGVudiktPmNmZy5leHRfemljZmlzcykgeworICAgICAgICBpZiAoIShlbnYtPm1lbnZj
ZmcgJiBNRU5WQ0ZHX1NTRSkgfHwKKyAgICAgICAgICAgIChlbnYtPnZpcnRfZW5hYmxl
ZCAmJiAhKGVudi0+aGVudmNmZyAmIEhFTlZDRkdfU1NFKSkpIHsKKyAgICAgICAgICAg
ICp2YWwgJj0gflNFTlZDRkdfU1NFOworICAgICAgICB9CisgICAgfQorCiAgICAgcmV0
dXJuIFJJU0NWX0VYQ1BfTk9ORTsKIH0KIAotLSAKMi41NS4wLndpbmRvd3MuMgoK


