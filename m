Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284AFC5DF98
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 13:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy82O-0003zg-Th; Sun, 23 Aug 2026 09:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82D-0003uV-If; Sun, 23 Aug 2026 09:14:49 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82B-0007Og-3I; Sun, 23 Aug 2026 09:14:49 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-05 (Coremail) with SMTP id zQCowAD3Yz478opq7al2Bg--.8255S4;
 Sun, 23 Aug 2026 21:14:35 +0800 (CST)
Message-ID: <78f6f0b01d79a18cfb3a2a64f5219ae043243dfa.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
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
Subject: [PATCH 1/5] target/riscv: make mnstatus.MNPELP writable with Zicfilp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: zQCowAD3Yz478opq7al2Bg--.8255S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWrKryfJw1xCry7AF17GFg_yoWfWwcEgF
 4fWFykWa4v9ws29FWDAw1rArZ5C3409F4fK39xJFWF9ry7uF9rJas2va48Jr4Uuw1UKF1f
 Canxt3yxCr47AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbG8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
 IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CE
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
 UI43ZEXa7IUnUfQtUUUUU==
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

WmljZmlscCBhZGRzIE1OUEVMUCB0byBtbnN0YXR1cywgYW5kIE1OUkVUIGNvbnN1bWVz
IGl0IHdoZW4gcmVzdG9yaW5nIEVMUC4KSW5jbHVkZSB0aGUgZmllbGQgaW4gd3JpdGVf
bW5zdGF0dXMoKSB3aGVuIFppY2ZpbHAgaXMgaW1wbGVtZW50ZWQuClJlc29sdmVzOiBo
dHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQy
MjIKClNpZ25lZC1vZmYtYnk6IHdhbmd5YW5nIDx3YW5neWFuZzI1QG90Y2FpeC5pc2Nh
cy5hYy5jbj4KLS0tCiB0YXJnZXQvcmlzY3YvdGNnL2Nzci5jIHwgNCArKysrCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jp
c2N2L3RjZy9jc3IuYyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMKaW5kZXggMzZmMjAw
NC4uNWZmZDg1OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYworKysg
Yi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jCkBAIC01NTYzLDYgKzU1NjMsMTAgQEAgc3Rh
dGljIFJJU0NWRXhjZXB0aW9uIHdyaXRlX21uc3RhdHVzKENQVVJJU0NWU3RhdGUgKmVu
diwgaW50IGNzcm5vLAogICAgICAgICBtYXNrIHw9IE1OU1RBVFVTX01OUFY7CiAgICAg
fQogCisgICAgaWYgKGVudl9hcmNoY3B1KGVudiktPmNmZy5leHRfemljZmlscCkgewor
ICAgICAgICBtYXNrIHw9IE1OU1RBVFVTX01OUEVMUDsKKyAgICB9CisKICAgICAvKiBt
bnN0YXR1cy5tbmllIGNhbiBvbmx5IGJlIGNsZWFyZWQgYnkgaGFyZHdhcmUuICovCiAg
ICAgZW52LT5tbnN0YXR1cyA9IChlbnYtPm1uc3RhdHVzICYgTU5TVEFUVVNfTk1JRSkg
fCAodmFsICYgbWFzayk7CiAgICAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsKLS0gCjIu
NTUuMC53aW5kb3dzLjIKCg==


