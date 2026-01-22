Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A69D3EE66
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vivlJ-00048d-1o; Thu, 22 Jan 2026 09:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3160104094@zju.edu.cn>)
 id 1vir2P-0007W5-73; Thu, 22 Jan 2026 04:31:37 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <3160104094@zju.edu.cn>)
 id 1vir2M-0003Yh-6l; Thu, 22 Jan 2026 04:31:36 -0500
Received: from zju.edu.cn (unknown [183.129.171.42])
 by mtasvr (Coremail) with SMTP id _____wC3fM1p7nFpUEQqAA--.13055S3;
 Thu, 22 Jan 2026 17:31:22 +0800 (CST)
Received: from 3160104094$zju.edu.cn ( [183.129.171.42] ) by
 ajax-webmail-mail-app1 (Coremail) ; Thu, 22 Jan 2026 17:31:20 +0800
 (GMT+08:00)
X-Originating-IP: [183.129.171.42]
Date: Thu, 22 Jan 2026 17:31:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Peng Jiang" <3160104094@zju.edu.cn>
To: "Chao Liu" <chao.liu.zevorn@gmail.com>
Cc: "Alistair Francis" <alistair.francis@wdc.com>,
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Weiwei Li" <liwei1518@gmail.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 "Chao Liu" <chao.liu@zevorn.cn>
Subject: Re: [PATCH v4 2/5] hw/riscv: add k230 board initial support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <ad3c378976034be5cf80282048aafd002e725105.1768884546.git.chao.liu.zevorn@gmail.com>
References: <cover.1768884546.git.chao.liu.zevorn@gmail.com>
 <ad3c378976034be5cf80282048aafd002e725105.1768884546.git.chao.liu.zevorn@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <651b1d38.63ab7.19be50b4721.Coremail.3160104094@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: yy_KCgDHG9dp7nFpTce7BQ--.51530W
X-CM-SenderInfo: qtrwiiiquqmko62m3hxhgxhubq/1tbiAwYEE2ldZYQWEAAGsH
X-CM-DELIVERINFO: =?B?2pMVHAXKKxbFmtjJiESix3B1w3sL8hBMFUTpd3cX36+dE6DPAN7iCt/gLhxLJ5hnLg
 KjdepiEoGTxNXUHXvT72tDVr0xxMbZmRTA+tlqjP51nBqFnxem/dISYeM4+CTS/PTXCDmg
 bO/+NUOASBVCZTB9DJ00cDnoJM4sLbhixt0VqUCXXUt+rSuguHkySIGnzGEwVg==
X-Coremail-Antispam: 1Uk129KBj93XoWruryrZFykZw13tw4kXry3ZFc_yoW8JF17pF
 y5tFsxGFs5Xr47KF4fGw4UA3yYyrWrKa1DCws3C3y8Ca1agwn0vFZ8trZ0qFWUGr18uryU
 KanrAw4Yva1DAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
 xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
 CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
 xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
 kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24l
 FcxC0VAYjxAxZF0Ex2IqxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
 x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
 0_Jr0_Gr1l6VACY4xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxU7RpPUUUUU
Received-SPF: pass client-ip=206.189.21.223;
 envelope-from=3160104094@zju.edu.cn;
 helo=zg8tmja2lje4os4yms4ymjma.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Jan 2026 09:34:13 -0500
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

SGkgQ2hhbywKCkkgZm91bmQgYSBzbWFsbCBpc3N1ZSBpbiB0aGUgcmVzZXRfcm9tIGltcGxlbWVu
dGF0aW9uIGluIGh3L3Jpc2N2L2syMzAuYy4KCj4gK3N0YXRpYyB2b2lkIGsyMzBfbWFjaGluZV9k
b25lKE5vdGlmaWVyICpub3RpZmllciwgdm9pZCAqZGF0YSkKPiArewo+ICsgICAgLi4uCj4gKyAg
ICAvKiBNYXNrIFJPTSByZXNldCB2ZWN0b3IgKi8KPiArICAgIHVpbnQzMl90IHJlc2V0X3ZlY1td
ID0gewo+ICsgICAgICAgIC8qIDB4OTEyMDAwMDA6IGF1aXBjICB0MCwgMHgwICAgICAgICAgICAg
ICAqLyAweDAwMDAwMjk3LAo+ICsgICAgICAgIC8qIDB4OTEyMDAwMDQ6IGFkZGkgICB0MCwgdDAs
IDM2ICMgPHRyYXA+ICAqLyAweDAyNDI4MjkzLAo+ICsgICAgICAgIC8qIDB4OTEyMDAwMDg6IGNz
cncgICBtdHZlYywgdDAgICAgICAgICAgICAqLyAweDMwNTI5MDczLAo+ICsgICAgICAgIC4uLgo+
ICsgICAgICAgIC8qIHRyYXA6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwo+
ICsgICAgICAgIC8qIDB4OTEyMDAwMzA6IGogICAgICAweDkxMjAwMDMwICMgPHRyYXA+ICAqLyAw
eDAwMDAwMDZmLAo+ICsgICAgfTsKPiArCj4gKyAgICAvKiBjb3B5IGluIHRoZSByZXNldCB2ZWN0
b3IgaW4gbGl0dGxlX2VuZGlhbiBieXRlIG9yZGVyICovCj4gKyAgICBmb3IgKGludCBpID0gMDsg
aSA8IHNpemVvZihyZXNldF92ZWMpID4+IDI7IGkrKykgewo+ICsgICAgICAgIHJlc2V0X3ZlY1tp
XSA9IGNwdV90b19sZTMyKHJlc2V0X3ZlY1tpXSk7Cj4gKyAgICB9Cj4gKyAgICByb21fYWRkX2Js
b2JfZml4ZWRfYXMoIm1yb20ucmVzZXQiLCByZXNldF92ZWMsIHNpemVvZihyZXNldF92ZWMpLAo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgIG1lbW1hcFtLMjMwX0RFVl9CT09UUk9NXS5iYXNl
LCAmYWRkcmVzc19zcGFjZV9tZW1vcnkpOwo+IC4uLgo+ICt9CgpJdCBzZWVtcyB0aGUgb2Zmc2V0
IGZvciB0aGUgdHJhcCBoYW5kbGVyIGlzIGluY29ycmVjdC4KClRoZSBpbnN0cnVjdGlvbiBhdCAw
eDkxMjAwMDA0IGlzIGFkZGkgdDAsIHQwLCAzNi4gQWZ0ZXIgdGhlIGF1aXBjIGF0IDB4OTEyMDAw
MDAsIHRoaXMgc2V0cyB0aGUgdmFsdWUgb2YgdDAgdG8gMHg5MTIwMDAwMCArIDM2ICgweDkxMjAw
MDI0KSwgd2hpY2ggaXMgdGhlbiB3cml0dGVuIHRvIHRoZSBtdHZlYyByZWdpc3Rlci4KCkhvd2V2
ZXIsIHRoZSBhY3R1YWwgdHJhcDogbGFiZWwgaXMgbG9jYXRlZCBhdCBvZmZzZXQgMHgzMCAoMHg5
MTIwMDAzMCkuCgpUaGUgaW1tZWRpYXRlIHZhbHVlIGluIHRoZSBhZGRpIGluc3RydWN0aW9uIHNo
b3VsZCBwcm9iYWJseSBiZSA0OCAoMHgzMCkgaW5zdGVhZCBvZiAzNiAoMHgyNCkgdG8gcG9pbnQg
dG8gdGhlIGNvcnJlY3QgdHJhcCBoYW5kbGVyIGFkZHJlc3MuCgpCZXN0IHJlZ2FyZHMsClBhbmRh
IEppYW5nCg==


