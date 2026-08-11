Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB37FC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteiD-0005bd-17; Tue, 11 Aug 2026 01:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtbEj-0007kA-Ms; Mon, 10 Aug 2026 21:25:01 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtbEg-0007Ya-M3; Mon, 10 Aug 2026 21:25:01 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowABXLfHjeXpqxxPZBA--.17429S7;
 Tue, 11 Aug 2026 09:24:51 +0800 (CST)
Message-ID: <3d4c159187be459f94ba6cf535cd74ce@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: SENT
 0001-linux-user-riscv-honor-zicntr-false-for-base-counter.patch   Subject:
 [PATCH 1/7] linux-user/riscv: honor zicntr=false for base counter CSRs  
 Message-ID:
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
References: SENT
 0001-linux-user-riscv-honor-zicntr-false-for-base-counter.patch   Subject:
 [PATCH 1/7] linux-user/riscv: honor zicntr=false for base counter CSRs  
 Message-ID:
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 11 Aug 2026 09:24:52 +0800
Subject: [PATCH 5/7] linux-user/riscv: handle address-misaligned exceptions
 in cpu_loop
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: qwCowABXLfHjeXpqxxPZBA--.17429S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18XryDWF1rKF1fZw1DKFg_yoW8Ww4UpF
 yv9FW3KF95WF4DX3y7Kw40ka1rXF45Ww47G34UKr4avayrAFyruF1qgFnxua4DJr4UXF4j
 9FyUCwsruF1DC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280
 aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
 AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0E
 x4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67
 k04243AVAKzVAKj4xxMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
 c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4U
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VAC
 Y4xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUk6wZDUUUU
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

Y29tbWl0IGQxMDdiNzQ4MDcgKCJ0YXJnZXQvcmlzY3Y6IEdlbmVyYXRlIGFjY2VzcyBm
YXVsdCBpZiBzYyBjb21wYXJpc29uDQpmYWlscyIpIG1hZGUgYSBtaXNhbGlnbmVkIHNj
Lncvc2MuZCByYWlzZSBSSVNDVl9FWENQX1NUT1JFX0FNT19BRERSX01JUw0KZnJvbSBo
ZWxwZXJfc2NfcHJvYmVfd3JpdGUoKS4gIFRoZSBsaW51eC11c2VyIGNwdV9sb29wKCkg
aGFzIG5vIGNhc2UgZm9yDQp0aGF0IGV4Y2VwdGlvbiwgc28gcWVtdS1yaXNjdjY0IGFi
b3J0cyB0aGUgd2hvbGUgZW11bGF0b3Igd2l0aA0KInFlbXU6IHVuaGFuZGxlZCBDUFUg
ZXhjZXB0aW9uIDB4NiAtIGFib3J0aW5nIiBpbnN0ZWFkIG9mIGRlbGl2ZXJpbmcgYQ0K
c2lnbmFsIHRvIHRoZSBndWVzdCBwcm9jZXNzLiAgQSBKQUxSIHRvIGFuIGFkZHJlc3Mg
d2l0aCBiaXQgMSBzZXQgd2hpbGUNCnRoZSBndWVzdCBDIGV4dGVuc2lvbiBpcyBkaXNh
YmxlZCBzaW1pbGFybHkgcmFpc2VzDQpSSVNDVl9FWENQX0lOU1RfQUREUl9NSVMsIHdo
aWNoIGFsc28gZmFsbHMgdGhyb3VnaCB0byB0aGUgZ2VuZXJpYyBhYm9ydA0KcGF0aC4N
Cg0KTmF0aXZlIFJJU0MtViBMaW51eCBkZWxpdmVycyBTSUdTRUdWL1NFR1ZfQUNDRVJS
IGZvciBtaXNhbGlnbmVkDQpsci9zYy9BTU8gYWNjZXNzZXMgYW5kIFNJR0JVUy9CVVNf
QURSQUxOIGZvciBpbnN0cnVjdGlvbi1hZGRyZXNzDQptaXNhbGlnbm1lbnQuICBBZGQg
Ym90aCBjYXNlcyB0byB0aGUgdXNlci1tb2RlIGxvb3AgYW5kIGZvcndhcmQgdGhlDQpl
eGNlcHRpb25zIGFjY29yZGluZ2x5Lg0KDQpSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIu
Y29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80MTUyDQpTaWduZWQtb2Zm
LWJ5OiB3YW5neWFuZyA8d2FuZ3lhbmcyNUBvdGNhaXguaXNjYXMuYWMuY24+DQotLS0N
CiBsaW51eC11c2VyL3Jpc2N2L2NwdV9sb29wLmMgfCA3ICsrKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9saW51eC11c2Vy
L3Jpc2N2L2NwdV9sb29wLmMgYi9saW51eC11c2VyL3Jpc2N2L2NwdV9sb29wLmMNCmlu
ZGV4IDZmMjdhMDZkYTQ5Li4yYTZlYmM5MjA0NyAxMDA2NDQNCi0tLSBhL2xpbnV4LXVz
ZXIvcmlzY3YvY3B1X2xvb3AuYw0KKysrIGIvbGludXgtdXNlci9yaXNjdi9jcHVfbG9v
cC5jDQpAQCAtODQsNiArODQsMTMgQEAgdm9pZCBjcHVfbG9vcChDUFVSSVNDVlN0YXRl
ICplbnYpDQogICAgICAgICAgICAgZG9fY29tbW9uX3NlbWlob3N0aW5nKGNzKTsNCiAg
ICAgICAgICAgICBlbnYtPnBjICs9IDQ7DQogICAgICAgICAgICAgYnJlYWs7DQorICAg
ICAgICBjYXNlIFJJU0NWX0VYQ1BfU1RPUkVfQU1PX0FERFJfTUlTOg0KKyAgICAgICAg
ICAgIGZvcmNlX3NpZ19mYXVsdChUQVJHRVRfU0lHU0VHViwgVEFSR0VUX1NFR1ZfQUND
RVJSLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPmJhZGFkZHIpOw0K
KyAgICAgICAgICAgIGJyZWFrOw0KKyAgICAgICAgY2FzZSBSSVNDVl9FWENQX0lOU1Rf
QUREUl9NSVM6DQorICAgICAgICAgICAgZm9yY2Vfc2lnX2ZhdWx0KFRBUkdFVF9TSUdC
VVMsIFRBUkdFVF9CVVNfQURSQUxOLCBlbnYtPnBjKTsNCisgICAgICAgICAgICBicmVh
azsNCiAgICAgICAgIGRlZmF1bHQ6DQogICAgICAgICAgICAgRVhDUF9EVU1QKGVudiwg
IlxucWVtdTogdW5oYW5kbGVkIENQVSBleGNlcHRpb24gJSN4IC0gYWJvcnRpbmdcbiIs
DQogICAgICAgICAgICAgICAgICAgICAgdHJhcG5yKTsNCi0tIA0KMi40My4wDQo=


