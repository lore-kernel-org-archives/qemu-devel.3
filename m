Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B55DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rztls-000560-7k; Thu, 25 Apr 2024 03:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshanliukou@163.com>)
 id 1rztlq-00055O-AG; Thu, 25 Apr 2024 03:43:54 -0400
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaoshanliukou@163.com>)
 id 1rztlh-0002qD-Vb; Thu, 25 Apr 2024 03:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=JkYHpcmxltk2cq7AVcN34wonmbVn1ADirOb9kinxMl8=; b=E
 jmlEhNwO5h5RkV8L0Ll4/WQD/zOyP8ph5wsVv2fq3G+GjBWHg7uzurX6Qw0huuKh
 ms+jzRusKEONihmW4ZiQEfmA4DueK8gxXJFePvf2YvwXtx+yp2C5jjvNkH+Bh2zY
 GtLv3fHhChf5xxWDFbzR5azrhFz/JWunVsLY2upTy0=
Received: from gaoshanliukou$163.com ( [60.27.226.48] ) by
 ajax-webmail-wmsvr-40-125 (Coremail) ; Thu, 25 Apr 2024 15:43:27 +0800
 (CST)
X-Originating-IP: [60.27.226.48]
Date: Thu, 25 Apr 2024 15:43:27 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: "Alistair Francis" <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, "yang.zhang" <yang.zhang@hexintek.com>
Subject: Re:Re: [PATCH] hw/intc/riscv_aplic: APLICs should add child earlier
 than realize
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAKmqyKM-0P+qbLZ0AB_NUOQEW5ypE8u=40ggi_=smtJjh8pYkg@mail.gmail.com>
References: <20240409014445.278-1-gaoshanliukou@163.com>
 <CAKmqyKM-0P+qbLZ0AB_NUOQEW5ypE8u=40ggi_=smtJjh8pYkg@mail.gmail.com>
X-NTES-SC: AL_Qu2aBvyYvkgr4SGQY+kXnEYQh+k3XcK4u/0u2YFVP5E0lCTK1gMef3F+PmTt8dKzJympvhaHfSZO1N9weKZSYq+7nhnf/TBOqnbak/4885Wv
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <74e9f44a.a02d.18f14359617.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3H9WfCSpmNIkuAA--.25633W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiNwvI8mXAk5h9uAACsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.4; envelope-from=gaoshanliukou@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL=1.31, SPF_HELO_NONE=0.001,
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

CkF0IDIwMjQtMDQtMjMgMTQ6MDQ6MjksICJBbGlzdGFpciBGcmFuY2lzIiA8YWxpc3RhaXIyM0Bn
bWFpbC5jb20+IHdyb3RlOgo+T24gVHVlLCBBcHIgOSwgMjAyNCBhdCAxMTo0NuKAr0FNIHlhbmcu
emhhbmcgPGdhb3NoYW5saXVrb3VAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IEZyb206ICJ5YW5nLnpo
YW5nIiA8eWFuZy56aGFuZ0BoZXhpbnRlay5jb20+Cj4+Cj4+IFNpbmNlIG9ubHkgcm9vdCBBUExJ
Q3MgY2FuIGhhdmUgaHcgSVJRIGxpbmVzLCBhcGxpYy0+cGFyZW50IHNob3VsZAo+PiBiZSBpbml0
aWFsaXplZCBmaXJzdC4KPj4KPj4gRml4ZXM6IGU4Zjc5MzQzY2YgKCJody9pbnRjOiBBZGQgUklT
Qy1WIEFJQSBBUExJQyBkZXZpY2UgZW11bGF0aW9uIikKPj4gUmV2aWV3ZWQtYnk6IERhbmllbCBI
ZW5yaXF1ZSBCYXJib3phIDxkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tPgo+PiBTaWduZWQtb2Zm
LWJ5OiB5YW5nLnpoYW5nIDx5YW5nLnpoYW5nQGhleGludGVrLmNvbT4KPgo+VGhhbmtzIQo+Cj5B
cHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQKPgoKPkFsaXN0YWlyClRoYW5rcy4KPj4gLS0t
Cj4+ICBody9pbnRjL3Jpc2N2X2FwbGljLmMgfCA4ICsrKystLS0tCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaHcv
aW50Yy9yaXNjdl9hcGxpYy5jIGIvaHcvaW50Yy9yaXNjdl9hcGxpYy5jCj4+IGluZGV4IGZjNWRm
MGQ1OTguLjMyZWRkNmQwN2IgMTAwNjQ0Cj4+IC0tLSBhL2h3L2ludGMvcmlzY3ZfYXBsaWMuYwo+
PiArKysgYi9ody9pbnRjL3Jpc2N2X2FwbGljLmMKPj4gQEAgLTEwMDAsMTYgKzEwMDAsMTYgQEAg
RGV2aWNlU3RhdGUgKnJpc2N2X2FwbGljX2NyZWF0ZShod2FkZHIgYWRkciwgaHdhZGRyIHNpemUs
Cj4+ICAgICAgcWRldl9wcm9wX3NldF9iaXQoZGV2LCAibXNpbW9kZSIsIG1zaW1vZGUpOwo+PiAg
ICAgIHFkZXZfcHJvcF9zZXRfYml0KGRldiwgIm1tb2RlIiwgbW1vZGUpOwo+Pgo+PiArICAgIGlm
IChwYXJlbnQpIHsKPj4gKyAgICAgICAgcmlzY3ZfYXBsaWNfYWRkX2NoaWxkKHBhcmVudCwgZGV2
KTsKPj4gKyAgICB9Cj4+ICsKPj4gICAgICBzeXNidXNfcmVhbGl6ZV9hbmRfdW5yZWYoU1lTX0JV
U19ERVZJQ0UoZGV2KSwgJmVycm9yX2ZhdGFsKTsKPj4KPj4gICAgICBpZiAoIWlzX2t2bV9haWEo
bXNpbW9kZSkpIHsKPj4gICAgICAgICAgc3lzYnVzX21taW9fbWFwKFNZU19CVVNfREVWSUNFKGRl
diksIDAsIGFkZHIpOwo+PiAgICAgIH0KPj4KPj4gLSAgICBpZiAocGFyZW50KSB7Cj4+IC0gICAg
ICAgIHJpc2N2X2FwbGljX2FkZF9jaGlsZChwYXJlbnQsIGRldik7Cj4+IC0gICAgfQo+PiAtCj4+
ICAgICAgaWYgKCFtc2ltb2RlKSB7Cj4+ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBudW1faGFy
dHM7IGkrKykgewo+PiAgICAgICAgICAgICAgQ1BVU3RhdGUgKmNwdSA9IGNwdV9ieV9hcmNoX2lk
KGhhcnRpZF9iYXNlICsgaSk7Cj4+IC0tCj4+IDIuMjUuMQo+Pgo+Pgo=

