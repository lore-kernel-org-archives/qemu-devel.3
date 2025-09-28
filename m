Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EF6CAC5BC
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 02:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2hPv-0003mr-FO; Sat, 27 Sep 2025 22:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1v2hPs-0003lx-GZ; Sat, 27 Sep 2025 22:45:36 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1v2hPj-00049j-UK; Sat, 27 Sep 2025 22:45:36 -0400
Received: from xb$ultrarisc.com ( [192.168.100.1] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Sun, 28 Sep 2025 10:46:13
 +0800 (GMT+08:00)
X-Originating-IP: [192.168.100.1]
Date: Sun, 28 Sep 2025 10:46:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6LCi5rOi?= <xb@ultrarisc.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, ajones@ventanamicro.com, qemu-riscv@nongnu.org,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com, xiamy@ultrarisc.com
Subject: =?UTF-8?Q?Re:_Re:_[PATCH_v8_for_v10.0.0_0/2]_t?=
 =?UTF-8?Q?arget/riscv=EF=BC=9AFix_riscv64_kvm_migration?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240625(a75f206e) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-8cc425bc-7df6-4523-bb46-a48cc1a964e6-ultrarisc.com
In-Reply-To: <4103cde2-2e4a-4622-98a8-38a2a46723d7@tls.msk.ru>
References: <20250912085535.1649347-1-xb@ultrarisc.com>
 <4103cde2-2e4a-4622-98a8-38a2a46723d7@tls.msk.ru>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: /1QfhmZvb3Rlcl90eHQ9OTA0Ojg0MA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4f79395a.1352.1998e36b165.Coremail.xb@ultrarisc.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBXxM51odhoLYwxAA--.2414W
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQATB2jYkfQADwABsO
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGkgTWljaGFlbO+8jAoKd2UgYXJlIHBsYW5uZWQgdG8gaGF2ZSBhIHJlZ3VsYXIgUlZJIHNpZy1o
eXBlcnZpc29yIG1lZXRpbmcgb24gdGhlIDMwdGgsIAp3aXRoIFJhZGltIGFuZCBBbmRyZXcuIEEg
Y29uY2x1c2l2ZSBlbWFpbCB3aWxsIGJlIHNlbnQgc2hvcnRseSBhZnRlci4gClRoYW5rcyBmb3Ig
dGhlIHJlbWluZGVyLiAKClJlZ2FyZHPvvIwKWGllIEJvCgoKPiAtLS0tLeWOn+Wni+mCruS7ti0t
LS0tCj4g5Y+R5Lu25Lq6OiAiTWljaGFlbCBUb2thcmV2IiA8bWp0QHRscy5tc2sucnU+Cj4g5Y+R
6YCB5pe26Ze0OjIwMjUtMDktMjcgMjE6NTc6MDYgKOaYn+acn+WFrSkKPiDmlLbku7bkuro6ICJY
aWUgQm8iIDx4YkB1bHRyYXJpc2MuY29tPiwgcWVtdS1kZXZlbEBub25nbnUub3JnCj4g5oqE6YCB
OiBham9uZXNAdmVudGFuYW1pY3JvLmNvbSwgcWVtdS1yaXNjdkBub25nbnUub3JnLCBwYm9uemlu
aUByZWRoYXQuY29tLCBhbnVwQGJyYWluZmF1bHQub3JnLCBhbGlzdGFpci5mcmFuY2lzQHdkYy5j
b20sIHJrcmNtYXJAdmVudGFuYW1pY3JvLmNvbSwgcGFsbWVyQGRhYmJlbHQuY29tLCB4aWFteUB1
bHRyYXJpc2MuY29tCj4g5Li76aKYOiBSZTogW1BBVENIIHY4IGZvciB2MTAuMC4wIDAvMl0gdGFy
Z2V0L3Jpc2N277yaRml4IHJpc2N2NjQga3ZtIG1pZ3JhdGlvbgo+IAo+IE9uIDEyLjA5LjIwMjUg
MTE6NTUsIFhpZSBCbyB3cm90ZToKPiA+IFRoaXMgc2VyaWVzKHY4KSByZXBsYWNlcyB0aGUgZWFy
bGllciBzZXJpZXMgcGF0Y2giW1BBVENIIHY3IGZvciB2MTAuMC4wIDAvMl0KPiA+IHRhcmdldC9y
aXNjdjogRml4IHJpc2N2NjQga3ZtIG1pZ3JhdGlvbiIuCj4gCj4gUGluZz8gIENhbiB3ZSBhcHBs
eSB0aGlzIHRvIHRoZSBtYXN0ZXIgYnJhbmNoLCBzbyBJIGNhbiBwaWNrIGl0IHVwCj4gZm9yIHRo
ZSBzdGFibGUgc2VyaWVzPwo+IAo+IFRoYW5rcywKPiAKPiAvbWp0Cg0KDQpfX19fX19fX19fX19f
X19fX19fX19fd3d3LnVsdHJhcmlzYy5jb20NCumHjeimgeaPkOekuu+8muacrOmCruS7tuWMheaL
rOmZhOS7tueahOWGheWuueaYr+WPl+azleW+i+S/neaKpOeahOS/neWvhuS/oeaBr++8jOWmguae
nOaCqOS4jeaYr+aMh+WumuaUtuS7tuS6uu+8jOivt+eri+WNs+WwhuacrOmCruS7tuWIoOmZpO+8
jOazleW+i+emgeatouS7u+S9lemdnuazleeahOaKq+mcsuOAgeWkjeWItuOAgeS8oOaSreaIluS7
peS7u+S9leaWueW8j+S9v+eUqOacrOmCruS7tuOAguacrOmCruS7tuS4reWMheWQq+eahOaEj+in
geOAgeW7uuiuruaYr+WfuuS6juaIluWPl+WIsOaIkeaWueihqOi+vuWSjOWumuS5ieeahOadoeas
vuWPiuadoeS7tueahOmZkOWumu+8jOWmguaXoOaIkeaWueeahOato+W8j+S5pumdoua+hOa4heaI
luaOiOadg++8jOS4jeWPr+iiq+WNleeLrOS9nOS4uuS7u+S9leaDheW9ouS4i+eahOivgeaNruaI
luS+neaNruOAguaEn+iwouaCqOeahOeQhuino+S4jumFjeWQiOOAgueJiOadg+aJgOacieOAgklN
UE9SVEFOVCBOT1RJQ0U6IFRoaXMgZW1haWwsIGluY2x1ZGluZyBpdHMgYXR0YWNobWVudCBpZiBh
bnksIGlzIGNvbmZpZGVudGlhbC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCwgcGxlYXNlIGRlbGV0ZSBpdCBmcm9tIHlvdXIgY29tcHV0ZXIgaW1tZWRpYXRlbHkuIEFueSBk
aXNjbG9zdXJlLCBjb3B5aW5nLCBvciBkaXN0cmlidXRpb24gb2YgdGhpcyBtZXNzYWdlLCBvciB0
YWtpbmcgb2YgYW55IGFjdGlvbiBiYXNlZCBvbiBpdCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiAg
QW55IG9waW5pb25zIGFuZCBzdWdnZXN0aW9ucyBjb250YWluZWQgaW4gdGhpcyBlbWFpbCBhcmUg
c3ViamVjdCB0byB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMgZXhwcmVzc2VkIGFuZCBkZWZpbmVk
IGJ5IHVzIGFuZCBzaG91bGQgbm90IGJlIHJlbGllZCB1cG9uIHVuY29uZGl0aW9uYWxseSB1bmRl
ciBhbnkgY2lyY3Vtc3RhbmNlcyB1bmxlc3MgdGhleSBhcmUgY29uZmlybWVkIGluIG9mZmljaWFs
IHdyaXR0ZW4gY2xhcmlmaWNhdGlvbiBvciBhdXRob3JpemF0aW9uIGZyb20gdXMuICBUaGFuayB5
b3UgZm9yIHlvdXIgdW5kZXJzdGFuZGluZyBhbmQgY29vcGVyYXRpb24uQWxsIHJpZ2h0cyByZXNl
cnZlZC4=

