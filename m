Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C6FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 01:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwBT3-0006MQ-6d; Sun, 14 Apr 2024 21:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1rwBT0-0006Li-Aw; Sun, 14 Apr 2024 21:49:06 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>)
 id 1rwBSx-0007ZY-Rb; Sun, 14 Apr 2024 21:49:06 -0400
Received: from duchao$eswincomputing.com ( [10.64.113.11] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 15 Apr 2024 09:47:31 +0800 (GMT+08:00)
X-Originating-IP: [10.64.113.11]
Date: Mon, 15 Apr 2024 09:47:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Chao Du" <duchao@eswincomputing.com>
To: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, atishp@atishpatra.org
Subject: Re: [RFC PATCH 0/4] target/riscv/kvm: QEMU support for KVM Guest
 Debug on RISC-V
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20220420(169d3f8c)
 Copyright (c) 2002-2024 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <48d413a8.25e8.18ec23d85b9.Coremail.duchao@eswincomputing.com>
References: <20231221094923.7349-1-duchao@eswincomputing.com>
 <846ec319-6026-4b14-b156-9e1f42c6dba1@ventanamicro.com>
 <48d413a8.25e8.18ec23d85b9.Coremail.duchao@eswincomputing.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <74adbf4d.2bb3.18edf7020f7.Coremail.duchao@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID: TQJkCgBHWbszhxxm230GAA--.3729W
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/1tbiAQEIDGYboscKDgADsb
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: permerror client-ip=129.150.39.64;
 envelope-from=duchao@eswincomputing.com; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

R2VudGxlIHBpbmcuLi4KCk9uIDIwMjQtMDQtMDkgMTc6NDMsIENoYW8gRHUgPGR1Y2hhb0Blc3dp
bmNvbXB1dGluZy5jb20+IHdyb3RlOgo+IAo+IEhpIERhbmllbCBhbmQgYWxsLAo+IAo+IFRoZSBL
Vk0gcGF0Y2hlcyBoYXZlIGJlZW4gcmV2aWV3ZCBhbmQgYXJlIGluIHRoZSBxdWV1ZS4KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA0MDIwNjI2MjguNTQyNS0xLWR1Y2hhb0Blc3dp
bmNvbXB1dGluZy5jb20vCj4gCj4gQ291bGQgeW91IHBsZWFzZSByZXZpZXcgaW4gdGhlIFFFTVUg
c2lkZSA/Cj4gVGhlbiBJIHdpbGwgcmViYXNlIHRoaXMgc2VyaWVzIHdpdGggeW91ciBjb21tZW50
cy4KPiAKPiBTb21lIE5vdGVzOgo+IDEuIEFzIHRoZSBmaXJzdCBzdGFnZSwgb25seSB0aGUgc29m
dHdhcmUgYnJlYWtwb2ludHMgaXMgaW1wbGVtZW50ZWQuCj4gMi4gQSAnY29ybmVyIGNhc2UnIGlu
IHdoaWNoIHRoZSBkZWJ1ZyBleGNlcHRpb24gaXMgbm90IGluc2VydGVkIGJ5IHRoZQo+IGRlYnVn
Z2VyLCBuZWVkIHRvIGJlIHJlLWluamVjdGVkIHRvIHRoZSBndWVzdC4gVGhpcyBpcyBub3QgaGFu
ZGxlZCB5ZXQKPiBpbiB0aGlzIHNlcmllcy4KPiAKPiBUaGFua3MsCj4gQ2hhbwo+IAo+IAo+IE9u
IDIwMjMtMTItMjIgMjI6MTYsIERhbmllbCBIZW5yaXF1ZSBCYXJib3phIDxkYmFyYm96YUB2ZW50
YW5hbWljcm8uY29tPiB3cm90ZToKPiA+IAo+ID4gSGksCj4gPiAKPiA+IEl0IHNlZW1zIHRoYXQg
d2Ugc3RpbGwgbmVlZCB0aGUga2VybmVsIEtWTSBzaWRlIHRvIGJlIHNvcnRlZCBvdXQgZmlyc3Qg
WzFdLAo+ID4gc28gSSBiZWxpZXZlIHdlIHNob3VsZCB3YWl0IGEgYml0IHVudGlsIHdlIGNhbiBy
ZXZpZXcgdGhpcyBSRkMuIE90aGVyd2lzZSB3ZQo+ID4gbWlnaHQgcmlzayByZXZpZXdpbmcgc29t
ZXRoaW5nIHRoYXQgaGFzIHRvIGJlIGNoYW5nZWQgbGF0ZXIuCj4gPiAKPiA+IAo+ID4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8yMDIzMTIyMTA5NTAwMi43NDA0LTEtZHVjaGFvQGVz
d2luY29tcHV0aW5nLmNvbS8KPiA+IAo+ID4gCj4gPiBUaGFua3MsCj4gPiAKPiA+IERhbmllbAo+
ID4gCj4gPiBPbiAxMi8yMS8yMyAwNjo0OSwgQ2hhbyBEdSB3cm90ZToKPiA+ID4gVGhpcyBzZXJp
ZXMgaW1wbGVtZW50cyBRRU1VIEtWTSBHdWVzdCBEZWJ1ZyBvbiBSSVNDLVYuIEN1cnJlbnRseSwg
d2UgY2FuCj4gPiA+IGRlYnVnIFJJU0MtViBLVk0gZ3Vlc3QgZnJvbSB0aGUgaG9zdCBzaWRlLCB3
aXRoIHNvZnR3YXJlIGJyZWFrcG9pbnRzLgo+ID4gPiAKPiA+ID4gQSBicmllZiB0ZXN0IHdhcyBk
b25lIG9uIFFFTVUgUklTQy1WIGh5cGVydmlzb3IgZW11bGF0b3IuCj4gPiA+IAo+ID4gPiBBIFRP
RE8gbGlzdCB3aGljaCB3aWxsIGJlIGFkZGVkIGxhdGVyOgo+ID4gPiAxLiBIVyBicmVha3BvaW50
cyBzdXBwb3J0Cj4gPiA+IDIuIFRlc3QgY2FzZXMKPiA+ID4gCj4gPiA+IFRoaXMgc2VyaWVzIGlz
IGJhc2VkIG9uIFFFTVUgOC4yLjAtcmM0IGFuZCBpcyBhbHNvIGF2YWlsYWJsZSBhdDoKPiA+ID4g
aHR0cHM6Ly9naXRodWIuY29tL0R1LUNoYW8vcWVtdS90cmVlL3Jpc2N2X2dkX3N3Cj4gPiA+IAo+
ID4gPiBUaGlzIGlzIGRlcGVuZGVudCBvbiBLVk0gc2lkZSBjaGFuZ2VzOgo+ID4gPiBodHRwczov
L2dpdGh1Yi5jb20vRHUtQ2hhby9saW51eC90cmVlL3Jpc2N2X2dkX3N3Cj4gPiA+IAo+ID4gPiBD
aGFvIER1ICg0KToKPiA+ID4gICAgdGFyZ2V0L3Jpc2N2L2t2bTogYWRkIHNvZnR3YXJlIGJyZWFr
cG9pbnRzIHN1cHBvcnQKPiA+ID4gICAgdGFyZ2V0L3Jpc2N2L2t2bTogaW1wbGVtZW50IGt2bV9h
cmNoX3VwZGF0ZV9ndWVzdF9kZWJ1ZygpCj4gPiA+ICAgIHRhcmdldC9yaXNjdi9rdm06IGhhbmRs
ZSB0aGUgZXhpdCB3aXRoIGRlYnVnIHJlYXNvbgo+ID4gPiAgICBsaW51eC1oZWFkZXJzOiBlbmFi
bGUgS1ZNIEdVRVNUIERFQlVHIGZvciBSSVNDLVYKPiA+ID4gCj4gPiA+ICAgYWNjZWwva3ZtL2t2
bS1hbGwuYyAgICAgICAgICAgfCAgIDggKy0tCj4gPiA+ICAgaW5jbHVkZS9zeXNlbXUva3ZtLmgg
ICAgICAgICAgfCAgIDYgKy0KPiA+ID4gICBsaW51eC1oZWFkZXJzL2FzbS1yaXNjdi9rdm0uaCB8
ICAgMSArCj4gPiA+ICAgdGFyZ2V0L2FybS9rdm02NC5jICAgICAgICAgICAgfCAgIDYgKy0KPiA+
ID4gICB0YXJnZXQvaTM4Ni9rdm0va3ZtLmMgICAgICAgICB8ICAgNiArLQo+ID4gPiAgIHRhcmdl
dC9taXBzL2t2bS5jICAgICAgICAgICAgIHwgICA2ICstCj4gPiA+ICAgdGFyZ2V0L3BwYy9rdm0u
YyAgICAgICAgICAgICAgfCAgIDYgKy0KPiA+ID4gICB0YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUu
YyAgICB8IDEwMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ICAgdGFy
Z2V0L3MzOTB4L2t2bS9rdm0uYyAgICAgICAgfCAgIDYgKy0KPiA+ID4gICA5IGZpbGVzIGNoYW5n
ZWQsIDEzMCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IC0tCj4g
PiA+IDIuMTcuMQo+ID4gPiAK

