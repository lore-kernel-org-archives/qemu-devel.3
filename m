Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5068EC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteiC-0005bM-BD; Tue, 11 Aug 2026 01:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtb55-0006Ys-Aj; Mon, 10 Aug 2026 21:15:03 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtb51-0006Xl-Vg; Mon, 10 Aug 2026 21:15:03 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowAA3Cu6Gd3pq5bPYBA--.22594S4;
 Tue, 11 Aug 2026 09:14:47 +0800 (CST)
Message-ID: <a417fdc4ee2d4c4c9760786a4104d051@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: SENT
 0001-target-riscv--honor-zicbo--envcfg-gating-in-linux-user-mode.patch  
 Subject: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in linux-user
 mode   Message-ID:
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
References: SENT
 0001-target-riscv--honor-zicbo--envcfg-gating-in-linux-user-mode.patch  
 Subject: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in linux-user
 mode   Message-ID:
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 11 Aug 2026 09:14:47 +0800
Subject: [PATCH 2/4] target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: qwCowAA3Cu6Gd3pq5bPYBA--.22594S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1ktry5Cry3Kr4rCF1rZwb_yoW8Xr4DpF
 sxKFWIkr4Ut34I9ay8tr4avF13GFs3Gw42g39avws0va15GrW2qFs0kw43tFn8JF4kXr4Y
 9a1Yya45ZFyDG3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQjb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
 xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
 jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67k042
 43AVAKzVAKj4xxMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JwCE64xvF2IE
 b7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07jwUUUUUUUU=
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Aug 2026 01:07:37 -0400
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

WmZpbnggZXhwbGljaXRseSBleGNsdWRlcyB0aGUgRk1WIHRyYW5zZmVyIGluc3RydWN0
aW9ucywgYnV0DQp0cmFuc19mbXZfeF93L3RyYW5zX2Ztdl93X3ggdXNlZCBSRVFVSVJF
X1pGSU5YX09SX0Ygc28gYSBaZmlueC1vbmx5DQpDUFUgYWNjZXB0ZWQgdGhlbS4gIFJl
cXVpcmUgUlZGIGluc3RlYWQgc28gdGhlIHRyYW5zZmVycyB0cmFwIHdpdGgNCmFuIGls
bGVnYWwgaW5zdHJ1Y3Rpb24gd2hlbiBvbmx5IFpmaW54IGlzIHByZXNlbnQuDQoNClJl
c29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3Jr
X2l0ZW1zLzQxMDgNClNpZ25lZC1vZmYtYnk6IHdhbmd5YW5nIDx3YW5neWFuZzI1QG90
Y2FpeC5pc2Nhcy5hYy5jbj4NCi0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yv
dGNnL2luc25fdHJhbnMvdHJhbnNfcnZmLmMuaW5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9p
bnNuX3RyYW5zL3RyYW5zX3J2Zi5jLmluYw0KaW5kZXggZTkzNTUyM2M5M2MuLjMwNWY1
NDViNDk0IDEwMDY0NA0KLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3Ry
YW5zX3J2Zi5jLmluYw0KKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3Ry
YW5zX3J2Zi5jLmluYw0KQEAgLTQyOCw3ICs0MjgsOCBAQCBzdGF0aWMgYm9vbCB0cmFu
c19mbXZfeF93KERpc2FzQ29udGV4dCAqY3R4LCBhcmdfZm12X3hfdyAqYSkNCiB7DQog
ICAgIC8qIE5PVEU6IFRoaXMgd2FzIEZNVi5YLlMgaW4gYW4gZWFybGllciB2ZXJzaW9u
IG9mIHRoZSBJU0Egc3BlYyEgKi8NCiAgICAgUkVRVUlSRV9GUFU7DQotICAgIFJFUVVJ
UkVfWkZJTlhfT1JfRihjdHgpOw0KKyAgICAvKiBaZmlueCBleHBsaWNpdGx5IGV4Y2x1
ZGVzIHRoZSBGTVYgdHJhbnNmZXIgaW5zdHJ1Y3Rpb25zLiAqLw0KKyAgICBSRVFVSVJF
X0VYVChjdHgsIFJWRik7DQogDQogICAgIFRDR3YgZGVzdCA9IGRlc3RfZ3ByKGN0eCwg
YS0+cmQpOw0KICAgICBUQ0d2X2k2NCBzcmMxID0gZ2V0X2Zwcl9ocyhjdHgsIGEtPnJz
MSk7DQpAQCAtNTMxLDcgKzUzMiw4IEBAIHN0YXRpYyBib29sIHRyYW5zX2Ztdl93X3go
RGlzYXNDb250ZXh0ICpjdHgsIGFyZ19mbXZfd194ICphKQ0KIHsNCiAgICAgLyogTk9U
RTogVGhpcyB3YXMgRk1WLlMuWCBpbiBhbiBlYXJsaWVyIHZlcnNpb24gb2YgdGhlIElT
QSBzcGVjISAqLw0KICAgICBSRVFVSVJFX0ZQVTsNCi0gICAgUkVRVUlSRV9aRklOWF9P
Ul9GKGN0eCk7DQorICAgIC8qIFpmaW54IGV4cGxpY2l0bHkgZXhjbHVkZXMgdGhlIEZN
ViB0cmFuc2ZlciBpbnN0cnVjdGlvbnMuICovDQorICAgIFJFUVVJUkVfRVhUKGN0eCwg
UlZGKTsNCiANCiAgICAgVENHdl9pNjQgZGVzdCA9IGRlc3RfZnByKGN0eCwgYS0+cmQp
Ow0KICAgICBUQ0d2IHNyYyA9IGdldF9ncHIoY3R4LCBhLT5yczEsIEVYVF9aRVJPKTs=


