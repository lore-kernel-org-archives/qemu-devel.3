Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0818FD12D61
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 13:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQms3-0001P2-Fs; Wed, 03 Dec 2025 08:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1vQmrw-0001HK-Mv; Wed, 03 Dec 2025 08:26:08 -0500
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1vQmrt-0003mp-Up; Wed, 03 Dec 2025 08:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=NF9jDQ+ARLLF90NTr26gQbcc/g/YWByXlJX2DQtF8Mc=; b=l
 mDr4DOpmkSODU0vzovFj3b1wce8puvm1SyRmsaRUsVgXUHkVSmCb8EzhCX4CQXcW
 ugVSb2YNSJt37y8K3o4RGgKdSUkQRkNAAco0PxevozuhsMoQlqGbEZ/aPK68IjPZ
 7bwAqEXnId33hJHU6Ft4yHgg5fUrq4f2sWLzRkr6u4=
Received: from alanosong$163.com ( [240e:36a:14a9:1700:d4b1:88cd:5137:42e1]
 ) by ajax-webmail-wmsvr-40-125 (Coremail) ; Wed, 3 Dec 2025 21:25:36 +0800
 (CST)
X-Originating-IP: [240e:36a:14a9:1700:d4b1:88cd:5137:42e1]
Date: Wed, 3 Dec 2025 21:25:36 +0800 (CST)
From: "Alano Song" <alanosong@163.com>
To: "Christian Schoenebeck" <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org,
 "QEMU Trivial" <qemu-trivial@nongnu.org>, "Thomas Huth" <thuth@redhat.com>
Subject: Re:Re: [PATCH 2/2] hw/9pfs: Correct typo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <3383884.aeNJFYEL58@weasel>
References: <20251202132132.17636-1-AlanoSong@163.com>
 <3383884.aeNJFYEL58@weasel>
X-NTES-SC: AL_Qu2dBvudt0so4CKQYukfmUsUgOo9Xsa4sv8h345WOZ1xjAzp0QAZZVRoJ2n08em1AhmWkyiWfhN2x91ATahEYp432pjBmNrl2jB9VvOiugcyHQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_165731_85014129.1764768336298"
MIME-Version: 1.0
Message-ID: <68b4e7fb.abde.19ae463c9ab.Coremail.alanosong@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: fSgvCgD3_1ZQOjBp9OQwAA--.6219W
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC0xAJHWkwOlDoaQAA3l
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------=_Part_165731_85014129.1764768336298
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

QXQgMjAyNS0xMi0wMyAyMDoxMjozMCwgIkNocmlzdGlhbiBTY2hvZW5lYmVjayIgPHFlbXVfb3Nz
QGNydWRlYnl0ZS5jb20+IHdyb3RlOgo+T24gVHVlc2RheSwgMiBEZWNlbWJlciAyMDI1IDE0OjIx
OjMyIENFVCBBbGFub1NvbmdAMTYzLmNvbSB3cm90ZToKPj4gQ29ycmVjdCBjb21tZW50IHR5cG8g
aW4geGVuXzlwZnNfYmgoKQo+PiAKPj4gU2lnbmVkLW9mZi1ieTogQWxhbm8gU29uZyA8QWxhbm9T
b25nQDE2My5jb20+Cj4KPlBsZWFzZSBzZW5kIGEgc2V0IG9mIGFzc29jaWF0ZWQgcGF0Y2hlcyB3
aXRoIGEgY292ZXIgbGV0dGVyIG5leHQgdGltZS4gSXQgCj5tYWtlcyBpdCBlYXNpZXIgZm9yIHBl
b3BsZSB3aGVuIHRoZXkgYXJlIHRocmVhZGVkIHRvZ2V0aGVyLgo+Cj5JIGFzc3VtZSB0aGlzIHBh
dGNoIGNhbiBhbHNvIGJlIHB1c2hlZCB0aHJvdWdoIHFlbXUtdHJpdmlhbCwgc286Cj4KPlJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gU2Nob2VuZWJlY2sgPHFlbXVfb3NzQGNydWRlYnl0ZS5jb20+Cj4K
Pk90aGVyd2lzZSBsZXQgbWUga25vdyBhbmQgSSdsbCBwdXNoIGl0IHRocm91Z2ggbXkgOXAgcXVl
dWUuCj4KPi9DaHJpc3RpYW4KPgpTb3JyeSBmb3IgdGhlIG92ZXJzaWdodCwgSSdsbCBiZSBtb3Jl
IGNhcmVmdWwgbmV4dCB0aW1lLgoKCj4+IC0tLQo+PiAgaHcvOXBmcy94ZW4tOXAtYmFja2VuZC5j
IHwgMiArLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4+IAo+PiBkaWZmIC0tZ2l0IGEvaHcvOXBmcy94ZW4tOXAtYmFja2VuZC5jIGIvaHcvOXBmcy94
ZW4tOXAtYmFja2VuZC5jCj4+IGluZGV4IDc5MzU5ZDkxMWEuLmNhMGZmZjVmYTkgMTAwNjQ0Cj4+
IC0tLSBhL2h3LzlwZnMveGVuLTlwLWJhY2tlbmQuYwo+PiArKysgYi9ody85cGZzL3hlbi05cC1i
YWNrZW5kLmMKPj4gQEAgLTMxMCw3ICszMTAsNyBAQCBzdGF0aWMgdm9pZCB4ZW5fOXBmc19iaCh2
b2lkICpvcGFxdWUpCj4+IAo+PiAgYWdhaW46Cj4+ICAgICAgd2FpdCA9IHJpbmctPmNvICE9IE5V
TEwgJiYgcWVtdV9jb3JvdXRpbmVfZW50ZXJlZChyaW5nLT5jbyk7Cj4+IC0gICAgLyogcGFpcmVk
IHdpdGggdGhlIHNtYl93bWIgYmFycmllcnMgaW4geGVuXzlwZnNfaW5pdF9pbl9pb3ZfZnJvbV9w
ZHUgKi8KPj4gKyAgICAvKiBwYWlyZWQgd2l0aCB0aGUgc21wX3dtYiBiYXJyaWVycyBpbiB4ZW5f
OXBmc19pbml0X2luX2lvdl9mcm9tX3BkdQo+PiAqLyBzbXBfcm1iKCk7Cj4+ICAgICAgaWYgKHdh
aXQpIHsKPj4gICAgICAgICAgY3B1X3JlbGF4KCk7Cj4KPgo=
------=_Part_165731_85014129.1764768336298
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PGRpdiBp
ZD0ic3BuRWRpdG9yQ29udGVudCI+PGRpdiBzdHlsZT0ibWFyZ2luOiAwOyI+PC9kaXY+PC9kaXY+
PHByZT5BdCAyMDI1LTEyLTAzIDIwOjEyOjMwLCAiQ2hyaXN0aWFuIFNjaG9lbmViZWNrIiAmbHQ7
cWVtdV9vc3NAY3J1ZGVieXRlLmNvbSZndDsgd3JvdGU6CiZndDtPbiBUdWVzZGF5LCAyIERlY2Vt
YmVyIDIwMjUgMTQ6MjE6MzIgQ0VUIEFsYW5vU29uZ0AxNjMuY29tIHdyb3RlOgomZ3Q7Jmd0OyBD
b3JyZWN0IGNvbW1lbnQgdHlwbyBpbiB4ZW5fOXBmc19iaCgpCiZndDsmZ3Q7IAomZ3Q7Jmd0OyBT
aWduZWQtb2ZmLWJ5OiBBbGFubyBTb25nICZsdDtBbGFub1NvbmdAMTYzLmNvbSZndDsKJmd0Owom
Z3Q7UGxlYXNlIHNlbmQgYSBzZXQgb2YgYXNzb2NpYXRlZCBwYXRjaGVzIHdpdGggYSBjb3ZlciBs
ZXR0ZXIgbmV4dCB0aW1lLiBJdCAKJmd0O21ha2VzIGl0IGVhc2llciBmb3IgcGVvcGxlIHdoZW4g
dGhleSBhcmUgdGhyZWFkZWQgdG9nZXRoZXIuCiZndDsKJmd0O0kgYXNzdW1lIHRoaXMgcGF0Y2gg
Y2FuIGFsc28gYmUgcHVzaGVkIHRocm91Z2ggcWVtdS10cml2aWFsLCBzbzoKJmd0OwomZ3Q7UmV2
aWV3ZWQtYnk6IENocmlzdGlhbiBTY2hvZW5lYmVjayAmbHQ7cWVtdV9vc3NAY3J1ZGVieXRlLmNv
bSZndDsKJmd0OwomZ3Q7T3RoZXJ3aXNlIGxldCBtZSBrbm93IGFuZCBJJ2xsIHB1c2ggaXQgdGhy
b3VnaCBteSA5cCBxdWV1ZS4KJmd0OwomZ3Q7L0NocmlzdGlhbgo8ZGl2PiZndDs8L2Rpdj48ZGl2
PgpTb3JyeSBmb3IgdGhlIG92ZXJzaWdodCwgSSdsbCBiZSBtb3JlIGNhcmVmdWwgbmV4dCB0aW1l
Lgo8L2Rpdj48ZGl2Pjxicj48L2Rpdj4mZ3Q7Jmd0OyAtLS0KJmd0OyZndDsgIGh3LzlwZnMveGVu
LTlwLWJhY2tlbmQuYyB8IDIgKy0KJmd0OyZndDsgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQomZ3Q7Jmd0OyAKJmd0OyZndDsgZGlmZiAtLWdpdCBhL2h3Lzlw
ZnMveGVuLTlwLWJhY2tlbmQuYyBiL2h3LzlwZnMveGVuLTlwLWJhY2tlbmQuYwomZ3Q7Jmd0OyBp
bmRleCA3OTM1OWQ5MTFhLi5jYTBmZmY1ZmE5IDEwMDY0NAomZ3Q7Jmd0OyAtLS0gYS9ody85cGZz
L3hlbi05cC1iYWNrZW5kLmMKJmd0OyZndDsgKysrIGIvaHcvOXBmcy94ZW4tOXAtYmFja2VuZC5j
CiZndDsmZ3Q7IEBAIC0zMTAsNyArMzEwLDcgQEAgc3RhdGljIHZvaWQgeGVuXzlwZnNfYmgodm9p
ZCAqb3BhcXVlKQomZ3Q7Jmd0OyAKJmd0OyZndDsgIGFnYWluOgomZ3Q7Jmd0OyAgICAgIHdhaXQg
PSByaW5nLSZndDtjbyAhPSBOVUxMICZhbXA7JmFtcDsgcWVtdV9jb3JvdXRpbmVfZW50ZXJlZChy
aW5nLSZndDtjbyk7CiZndDsmZ3Q7IC0gICAgLyogcGFpcmVkIHdpdGggdGhlIHNtYl93bWIgYmFy
cmllcnMgaW4geGVuXzlwZnNfaW5pdF9pbl9pb3ZfZnJvbV9wZHUgKi8KJmd0OyZndDsgKyAgICAv
KiBwYWlyZWQgd2l0aCB0aGUgc21wX3dtYiBiYXJyaWVycyBpbiB4ZW5fOXBmc19pbml0X2luX2lv
dl9mcm9tX3BkdQomZ3Q7Jmd0OyAqLyBzbXBfcm1iKCk7CiZndDsmZ3Q7ICAgICAgaWYgKHdhaXQp
IHsKJmd0OyZndDsgICAgICAgICAgY3B1X3JlbGF4KCk7CiZndDsKJmd0Owo8L3ByZT48L2Rpdj4=

------=_Part_165731_85014129.1764768336298--


