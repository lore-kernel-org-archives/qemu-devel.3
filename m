Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49C3C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 02:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBPsk-0005a4-Vt; Sun, 26 May 2024 22:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1sBPsi-0005Z6-1K; Sun, 26 May 2024 22:14:36 -0400
Received: from azure-sdnproxy.icoremail.net ([207.46.229.174])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>)
 id 1sBPsf-0001my-Id; Sun, 26 May 2024 22:14:35 -0400
Received: from duchao$eswincomputing.com ( [10.64.112.210] ) by
 ajax-webmail-app1 (Coremail) ; Mon, 27 May 2024 10:12:03 +0800 (GMT+08:00)
X-Originating-IP: [10.64.112.210]
Date: Mon, 27 May 2024 10:12:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Chao Du" <duchao@eswincomputing.com>
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, atishp@atishpatra.org
Subject: Re: [RFC PATCH 1/4] target/riscv/kvm: add software breakpoints support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20220420(169d3f8c)
 Copyright (c) 2002-2024 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <CABgObfYA3Er1y3R9v0Huf3w43n7oD83UhkqdRk-oBYzyM6O_ow@mail.gmail.com>
References: <20231221094923.7349-1-duchao@eswincomputing.com>
 <20231221094923.7349-2-duchao@eswincomputing.com>
 <ada42503-dab4-474f-a61a-a9fe3fa63afa@ventanamicro.com>
 <CABgObfYA3Er1y3R9v0Huf3w43n7oD83UhkqdRk-oBYzyM6O_ow@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1deff797.ed0.18fb7d1ae25.Coremail.duchao@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: TAJkCgDHaOXz61NmXgANAA--.4628W
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/1tbiAQEKDGZTAc0YowABsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: pass client-ip=207.46.229.174;
 envelope-from=duchao@eswincomputing.com; helo=azure-sdnproxy.icoremail.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL=1.31, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

T24gMjAyNC0wNS0yNSAwMDoxMSwgUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gCj4gT24gVHVlLCBBcHIgMTYsIDIwMjQgYXQgMTE6MjPigK9BTSBEYW5pZWwgSGVu
cmlxdWUgQmFyYm96YQo+IDxkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tPiB3cm90ZToKPiA+ID4g
K2ludCBrdm1fYXJjaF9pbnNlcnRfc3dfYnJlYWtwb2ludChDUFVTdGF0ZSAqY3MsIHN0cnVjdCBr
dm1fc3dfYnJlYWtwb2ludCAqYnAsCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdmFkZHIgbGVuKQo+ID4gPiArewo+ID4gPiArICAgIGlmIChsZW4gIT0gNCAmJiBsZW4g
IT0gMikgewo+ID4gPiArICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+ID4gKyAgICB9Cj4gPgo+
ID4gSSB3b25kZXIgaWYgdGhpcyB2ZXJpZmljYXRpb24gc2hvdWxkIGJlIG1vdmVkIHRvIGt2bV9p
bnNlcnRfYnJlYWtwb2ludCgpLiBJcwo+ID4gdGhlcmUgYW55IGtub3duIHJlYXNvbiB3aHkgb3Ro
ZXIgYXJjaHMgd291bGQgdXNlICdsZW4nIG90aGVyIHRoYW4gMiBvciA0PyBUaGUKPiA+IHBhcmVu
dCBmdW5jdGlvbiBjYW4gdGhyb3cgdGhlIEVJTlZBTCBpbiB0aGlzIGNhc2UuIE90aGVyd2lzZSBh
bGwgY2FsbGVycyBmcm9tCj4gPiBhbGwgYXJjaHMgd2lsbCBuZWVkIGEgc2ltaWxhciBFSU5WQUwg
Y2hlY2suCj4gCj4gSSdtIG5vdCBzdXJlIGhvdyBsZW4gaXMgZGVmaW5lZCBpbiB0aGUgZ2RiIHBy
b3RvY29sLCBidXQgeDg2IGhhcyBhCj4gYnJlYWtwb2ludCBsZW5ndGggb2YgMSBhbmQgYW4gaW5z
dHJ1Y3Rpb24gbGVuZ3RoIHRoYXQgY2FuIGJlIGFueSB2YWx1ZQo+IGJldHdlZW4gMSBhbmQgMTUu
Cj4gCj4gTW9zdCBhcmNoaXRlY3R1cmVzIGNvdWxkIGFzc3VtZSB0aGF0IGl0J3MgYWx3YXlzIG9u
ZSB2YWx1ZSwgaS5lLiBqdXN0Cj4gbm90IGNhcmUgYWJvdXQgY2hlY2tpbmcgbGVuIGluIGt2bV9h
cmNoX2luc2VydF9zd19icmVha3BvaW50Lgo+IAo+IFRoZSBwYXRjaGVzIGxvb2sgZ29vZCwgZmVl
bCBmcmVlIHRvIHRha2UgdGhlbSB0aHJvdWdoIHRoZSBSSVNDLVYgdHJlZS4KPiAKPiBPbmUgdGhp
bmcgdGhhdCBJIHdhcyB3b25kZXJpbmcgaXM6IGNvdWxkIFJJU0MtViBqdXN0IHVzZSBhbHdheXMK
PiBjLmVicmVhayBpZiBDIGluc3RydWN0aW9ucyBhcmUgc3VwcG9ydGVkLCBhbmQgZWJyZWFrIGlm
IHRoZXkncmUgbm90Pwo+IEJ1dCBpZiBmb3IgZXhhbXBsZSB0aGF0IHdvdWxkIHRoYXQgbWVzcyB1
cCB0aGUgc3luY2hyb25pemF0aW9uIG9mIHRoZQo+IGRpc2Fzc2VtYmx5IGluIGdkYiwgaXQncyBh
IGdvb2QgcmVhc29uIHRvIGFkZCB0aGUgbGVuIGFyZ3VtZW50IGFzIHlvdQo+IGRpZCBoZXJlLgoK
WWVzLCB5b3UgYXJlIHJpZ2h0LiBJZiB3ZSBpbnNlcnQgYW4gZWJyZWFrIGluc3RydWN0aW9uIHdo
b3NlIGxlbmd0aCBpcwpkaWZmZXJlbnQgZnJvbSB0aGUgb3JpZ2luYWwgb25lLCB0aGVuIHRoZSBk
aXNhc3NlbWJseSBpbiBnZGIgbWF5IGVuY291bnRlcgpzb21lIHByb2JsZW1zLgoKVGhhbmtzIGZv
ciB0aGUgcmV2aWV3LCBJIHdpbGwgcmViYXNlIHRoaXMgc2VyaWVzIGFuZCBzZW5kIGl0IG91dC4K
CkNoYW8KCj4gCj4gUGFvbG8K

