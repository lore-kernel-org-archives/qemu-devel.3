Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BD1C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg5Yg-0001V9-VC; Fri, 01 Mar 2024 11:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liyongtai@iscas.ac.cn>)
 id 1rg5YV-0001TE-Fr
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:16:15 -0500
Received: from [159.226.251.87] (helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liyongtai@iscas.ac.cn>)
 id 1rg5YN-0001qJ-BY
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:16:14 -0500
Received: from liyongtai$iscas.ac.cn ( [27.198.242.149] ) by
 ajax-webmail-APP-17 (Coremail) ; Sat, 2 Mar 2024 00:15:25 +0800 (GMT+08:00)
X-Originating-IP: [27.198.242.149]
Date: Sat, 2 Mar 2024 00:15:25 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5rC45rOw?= <liyongtai@iscas.ac.cn>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "demin.han" <demin.han@starfivetech.com>, 
 qemu-riscv <qemu-riscv@nongnu.org>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>
Subject: Re: Re: [PATCH] Fix unexpected Illegal instruction error on RISC-V.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
In-Reply-To: <4ed4b35a-659b-42d2-a0d9-9e7340b732f6@linaro.org>
References: <20240301145545.333810-2-liyongtai@iscas.ac.cn>
 <4ed4b35a-659b-42d2-a0d9-9e7340b732f6@linaro.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <40c70913.243ca.18dfacc8cfb.Coremail.liyongtai@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: qgCowADnTDge_+FlDr8FAA--.5093W
X-CM-SenderInfo: pol100pjwdxq5lvft2wodfhubq/1tbiCREDBGXh38hILQACsr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 159.226.251.87 (deferred)
Received-SPF: pass client-ip=159.226.251.87;
 envelope-from=liyongtai@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

SGkgUGhpbGlwcGUsCgpUaGFua3MgZm9yIHRoZSBoZWFkcyB1cC4gU29ycnkgSSBkaWRuJ3QgY2hl
Y2sgZm9yIHRoaXMgYmVmb3JlIHNlbmRpbmcgb3V0IG15IHBhdGNoLgpJJ2xsIHRyYWNrIHRoaXMg
aW4gRGVtaW4ncyB0aHJlYWQuCgoKJmd0OyAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCiZndDsg5Y+R
5Lu25Lq6OiAiUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kiIDxwaGlsbWRAbGluYXJvLm9yZz4KJmd0
OyDlj5HpgIHml7bpl7Q6IDIwMjQtMDMtMDEgMjM6NTE6MDMgKOaYn+acn+S6lCkKJmd0OyDmlLbk
u7bkuro6IFNpSHVhTiA8bGl5b25ndGFpQGlzY2FzLmFjLmNuPiwgcWVtdS1kZXZlbEBub25nbnUu
b3JnCiZndDsg5oqE6YCBOiAiZGVtaW4uaGFuIiA8ZGVtaW4uaGFuQHN0YXJmaXZldGVjaC5jb20+
LCBxZW11LXJpc2N2IDxxZW11LXJpc2N2QG5vbmdudS5vcmc+LCAiRGFuaWVsIEhlbnJpcXVlIEJh
cmJvemEiIDxkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tPgomZ3Q7IOS4u+mimDogUmU6IFtQQVRD
SF0gRml4IHVuZXhwZWN0ZWQgSWxsZWdhbCBpbnN0cnVjdGlvbiBlcnJvciBvbiBSSVNDLVYuCiZn
dDsgCiZndDsgSGkgU2lIdWFOLAomZ3Q7IAomZ3Q7IE9uIDEvMy8yNCAxNTo1NSwgU2lIdWFOIHdy
b3RlOgomZ3Q7ICZndDsgQXZvaWQgcmlnaHQtc2hpZnRpbmcgYnkgYSBuZWdhdGl2ZSBudW1iZXIg
b2YgYml0cyB3aGVuIGxtdWwgaXMgOC4KJmd0OyAKJmd0OyBGWUkgRGVtaW4gcG9zdGVkIGEgc2lt
aWxhciBwYXRjaCwgc2VlOgomZ3Q7IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwv
MjAyNDAyMjUxNzQxMTQuNTI5OC0xLWRlbWluLmhhbkBzdGFyZml2ZXRlY2guY29tLwomZ3Q7IAom
Z3Q7ICZndDsgU2lnbmVkLW9mZi1ieTogU2lIdWFOIDxsaXlvbmd0YWlAaXNjYXMuYWMuY24+CiZn
dDsgJmd0OyAtLS0KJmd0OyAmZ3Q7ICAgdGFyZ2V0L3Jpc2N2L3ZlY3Rvcl9oZWxwZXIuYyB8IDMg
KystCiZndDsgJmd0OyAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKJmd0OyAmZ3Q7IAomZ3Q7ICZndDsgZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi92ZWN0
b3JfaGVscGVyLmMgYi90YXJnZXQvcmlzY3YvdmVjdG9yX2hlbHBlci5jCiZndDsgJmd0OyBpbmRl
eCA4NGNlYzczZWIyLi5mMDE1OGVhMjM3IDEwMDY0NAomZ3Q7ICZndDsgLS0tIGEvdGFyZ2V0L3Jp
c2N2L3ZlY3Rvcl9oZWxwZXIuYwomZ3Q7ICZndDsgKysrIGIvdGFyZ2V0L3Jpc2N2L3ZlY3Rvcl9o
ZWxwZXIuYwomZ3Q7ICZndDsgQEAgLTUzLDEwICs1MywxMSBAQCB0YXJnZXRfdWxvbmcgSEVMUEVS
KHZzZXR2bCkoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcgczEsCiZndDsgJmd0OyAg
ICAgICAgICAgICogVkxFTiAqIExNVUwgJmd0Oz0gU0VXCiZndDsgJmd0OyAgICAgICAgICAgICog
VkxFTiAmZ3Q7Jmd0OyAoOCAtIGxtdWwpICZndDs9IHNldwomZ3Q7ICZndDsgICAgICAgICAgICAq
ICh2bGVuYiAmbHQ7Jmx0OyAzKSAmZ3Q7Jmd0OyAoOCAtIGxtdWwpICZndDs9IHNldwomZ3Q7ICZn
dDsgKyAgICAgICAgICogQ29uc2lkZXJpbmcgdGhhdCBsbXVsIG1heSBiZSA4LCB0aGUgZm9sbG93
aW5nIGZvcm0gY2Fubm90IGJlIHVzZWQuCiZndDsgJmd0OyAgICAgICAgICAgICogdmxlbmIgJmd0
OyZndDsgKDggLSAzIC0gbG11bCkgJmd0Oz0gc2V3CiZndDsgJmd0OyAgICAgICAgICAgICovCiZn
dDsgJmd0OyAgICAgICAgICAgaWYgKHZsbXVsID09IDQgfHwKJmd0OyAmZ3Q7IC0gICAgICAgICAg
ICBjcHUtJmd0O2NmZy52bGVuYiAmZ3Q7Jmd0OyAoOCAtIDMgLSB2bG11bCkgJmx0OyBzZXcpIHsK
Jmd0OyAmZ3Q7ICsgICAgICAgICAgICAoY3B1LSZndDtjZmcudmxlbmIgJmx0OyZsdDsgMykgJmd0
OyZndDsgKDggLSB2bG11bCkgJmx0OyBzZXcpIHsKJmd0OyAmZ3Q7ICAgICAgICAgICAgICAgdmls
bCA9IHRydWU7CiZndDsgJmd0OyAgICAgICAgICAgfQomZ3Q7ICZndDsgICAgICAgfQo8L2xpeW9u
Z3RhaUBpc2Nhcy5hYy5jbj48L2RiYXJib3phQHZlbnRhbmFtaWNyby5jb20+PC9xZW11LXJpc2N2
QG5vbmdudS5vcmc+PC9kZW1pbi5oYW5Ac3RhcmZpdmV0ZWNoLmNvbT48L2xpeW9uZ3RhaUBpc2Nh
cy5hYy5jbj48L3BoaWxtZEBsaW5hcm8ub3JnPg==

