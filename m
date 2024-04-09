Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527C5C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 01:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru0aG-0004Oq-Vx; Mon, 08 Apr 2024 21:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshanliukou@163.com>)
 id 1ru0aF-0004OT-0n; Mon, 08 Apr 2024 21:47:35 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaoshanliukou@163.com>)
 id 1ru0aA-00033g-MF; Mon, 08 Apr 2024 21:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=kpGNrl5sBnKmYWmSt2AiQmdRbsLnaTJzHOjuEdd+NiI=; b=D
 URB1lU2x3shiO4BdVQsb0fLvruN0aeBbCE81Y+AW789tDDyvM/XokDLpBhqIdEtS
 R2yvsoPm0MQc3I8b+EmXbiVkLvdTgBHfmGs9X9w2LH3NMjkJZXx/4PCE5TPJg1AJ
 DmU4XUFk18DmtPh6wVh97KXVeCoNfVsGcD/KtNThMw=
Received: from gaoshanliukou$163.com ( [60.27.226.9] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Tue, 9 Apr 2024 09:46:47 +0800 (CST)
X-Originating-IP: [60.27.226.9]
Date: Tue, 9 Apr 2024 09:46:47 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com, palmer@dabbelt.com, anup@brainfault.org, 
 "yang.zhang" <yang.zhang@hexintek.com>
Subject: Re:Re: [PATCH] hw/intc/riscv_aplic: APLICs should add child earlier
 than realize
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <eb3ec708-b4f7-431a-bef0-b09a458f422b@ventanamicro.com>
References: <20240407034652.25739-1-gaoshanliukou@163.com>
 <eb3ec708-b4f7-431a-bef0-b09a458f422b@ventanamicro.com>
X-NTES-SC: AL_Qu2aAPqZuEor4SmbYekXnEYQh+k3XcK4u/0u2YFVP5E0lST3wxsYf0RhJ3TO+eWkJByViyOIdAFWwOloTJZ/RaHRpjTgXqIpR/zTf4ETRe3E
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5b3846fb.270f.18ec0894f02.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3v0gHnhRmc_8GAA--.20690W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiRAu68mVOCNubxgADsh
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.3; envelope-from=gaoshanliukou@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

CkF0IDIwMjQtMDQtMDkgMDY6MzM6NTUsICJEYW5pZWwgSGVucmlxdWUgQmFyYm96YSIgPGRiYXJi
b3phQHZlbnRhbmFtaWNyby5jb20+IHdyb3RlOgo+Cj4KPk9uIDQvNy8yNCAwMDo0NiwgeWFuZy56
aGFuZyB3cm90ZToKPj4gRnJvbTogInlhbmcuemhhbmciIDx5YW5nLnpoYW5nQGhleGludGVrLmNv
bT4KPj4gCj4+IFNpbmNlIG9ubHkgcm9vdCBBUExJQ3MgY2FuIGhhdmUgaHcgSVJRIGxpbmVzLCBh
cGxpYy0+cGFyZW50IHNob3VsZAo+PiBiZSBpbml0aWFsaXplZCBmaXJzdC4KPgo+SSB0aGluayBp
dCdzIHdvcnRoIG1lbnRpb25pbmcgdGhhdCwgaWYgd2UgZG9uJ3QgZG8gdGhhdCwgdGhlcmUgd29u
J3QgYmUKPmFuIGFwbGljLT5wYXJlbnQgYXNzaWduZWQgZHVyaW5nIHJpc2N2X2FwbGljX3JlYWxp
emUoKSBhbmQgd2Ugd29uJ3QgY3JlYXRlCj50aGUgYWRlcXVhdGUgSVJRIGxpbmVzLgo+Cj4+IAo+
PiBTaWduZWQtb2ZmLWJ5OiB5YW5nLnpoYW5nIDx5YW5nLnpoYW5nQGhleGludGVrLmNvbT4KPj4g
LS0tCj4KPlBsZWFzZSBhZGQ6Cj4KPkZpeGVzOiBlOGY3OTM0M2NmICgiaHcvaW50YzogQWRkIFJJ
U0MtViBBSUEgQVBMSUMgZGV2aWNlIGVtdWxhdGlvbiIpCj4KPgo+QW5kOgo+Cj4KPlJldmlld2Vk
LWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSA8ZGJhcmJvemFAdmVudGFuYW1pY3JvLmNvbT4K
CkRvbmUuClRoYW5rcy4KPj4KPgo+Cj4+ICAgaHcvaW50Yy9yaXNjdl9hcGxpYy5jIHwgOCArKysr
LS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
Cj4+IAo+PiBkaWZmIC0tZ2l0IGEvaHcvaW50Yy9yaXNjdl9hcGxpYy5jIGIvaHcvaW50Yy9yaXNj
dl9hcGxpYy5jCj4+IGluZGV4IGZjNWRmMGQ1OTguLjMyZWRkNmQwN2IgMTAwNjQ0Cj4+IC0tLSBh
L2h3L2ludGMvcmlzY3ZfYXBsaWMuYwo+PiArKysgYi9ody9pbnRjL3Jpc2N2X2FwbGljLmMKPj4g
QEAgLTEwMDAsMTYgKzEwMDAsMTYgQEAgRGV2aWNlU3RhdGUgKnJpc2N2X2FwbGljX2NyZWF0ZSho
d2FkZHIgYWRkciwgaHdhZGRyIHNpemUsCj4+ICAgICAgIHFkZXZfcHJvcF9zZXRfYml0KGRldiwg
Im1zaW1vZGUiLCBtc2ltb2RlKTsKPj4gICAgICAgcWRldl9wcm9wX3NldF9iaXQoZGV2LCAibW1v
ZGUiLCBtbW9kZSk7Cj4+ICAgCj4+ICsgICAgaWYgKHBhcmVudCkgewo+PiArICAgICAgICByaXNj
dl9hcGxpY19hZGRfY2hpbGQocGFyZW50LCBkZXYpOwo+PiArICAgIH0KPj4gKwo+PiAgICAgICBz
eXNidXNfcmVhbGl6ZV9hbmRfdW5yZWYoU1lTX0JVU19ERVZJQ0UoZGV2KSwgJmVycm9yX2ZhdGFs
KTsKPj4gICAKPj4gICAgICAgaWYgKCFpc19rdm1fYWlhKG1zaW1vZGUpKSB7Cj4+ICAgICAgICAg
ICBzeXNidXNfbW1pb19tYXAoU1lTX0JVU19ERVZJQ0UoZGV2KSwgMCwgYWRkcik7Cj4+ICAgICAg
IH0KPj4gICAKPj4gLSAgICBpZiAocGFyZW50KSB7Cj4+IC0gICAgICAgIHJpc2N2X2FwbGljX2Fk
ZF9jaGlsZChwYXJlbnQsIGRldik7Cj4+IC0gICAgfQo+PiAtCj4+ICAgICAgIGlmICghbXNpbW9k
ZSkgewo+PiAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IG51bV9oYXJ0czsgaSsrKSB7Cj4+ICAg
ICAgICAgICAgICAgQ1BVU3RhdGUgKmNwdSA9IGNwdV9ieV9hcmNoX2lkKGhhcnRpZF9iYXNlICsg
aSk7Cg==

