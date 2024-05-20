Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3404C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 10:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s90Cm-0006ol-BT; Mon, 20 May 2024 06:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1s90Cj-0006mp-H3; Mon, 20 May 2024 06:25:17 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>)
 id 1s90Cf-0005fG-Ct; Mon, 20 May 2024 06:25:15 -0400
Received: from duchao$eswincomputing.com ( [10.64.112.210] ) by
 ajax-webmail-app1 (Coremail) ; Mon, 20 May 2024 18:22:57 +0800 (GMT+08:00)
X-Originating-IP: [10.64.112.210]
Date: Mon, 20 May 2024 18:22:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Chao Du" <duchao@eswincomputing.com>
To: pbonzini@redhat.com, "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, atishp@atishpatra.org
Subject: Re: [RFC PATCH 0/4] target/riscv/kvm: QEMU support for KVM Guest
 Debug on RISC-V
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20220420(169d3f8c)
 Copyright (c) 2002-2024 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <b93f13c4-05a9-4772-8ed9-a74b2f5f9cef@ventanamicro.com>
References: <20231221094923.7349-1-duchao@eswincomputing.com>
 <846ec319-6026-4b14-b156-9e1f42c6dba1@ventanamicro.com>
 <48d413a8.25e8.18ec23d85b9.Coremail.duchao@eswincomputing.com>
 <b93f13c4-05a9-4772-8ed9-a74b2f5f9cef@ventanamicro.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <745db9ba.296.18f95869950.Coremail.duchao@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: TAJkCgC3S+OBJEtm+ysMAA--.3224W
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/1tbiAgEDDGZJyRMgfgAFsi
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=duchao@eswincomputing.com;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgUGFvbG8sCgpBcyBEYW5pZWwgc3VnZ2VzdGVkLCBjb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBs
b29rIGF0IHRoaXMgc2VyaWVzID8KClRoYW5rcywKQ2hhbwoKT24gMjAyNC0wNC0xNiAxNzoyNSwg
RGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgPGRiYXJib3phQHZlbnRhbmFtaWNyby5jb20+IHdyb3Rl
Ogo+IAo+IE9uIDQvOS8yNCAwNjo0MywgQ2hhbyBEdSB3cm90ZToKPiA+IEhpIERhbmllbCBhbmQg
YWxsLAo+ID4gCj4gPiBUaGUgS1ZNIHBhdGNoZXMgaGF2ZSBiZWVuIHJldmlld2QgYW5kIGFyZSBp
biB0aGUgcXVldWUuCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA0MDIwNjI2
MjguNTQyNS0xLWR1Y2hhb0Blc3dpbmNvbXB1dGluZy5jb20vCj4gPiAKPiA+IENvdWxkIHlvdSBw
bGVhc2UgcmV2aWV3IGluIHRoZSBRRU1VIHNpZGUgPwo+ID4gVGhlbiBJIHdpbGwgcmViYXNlIHRo
aXMgc2VyaWVzIHdpdGggeW91ciBjb21tZW50cy4KPiA+IAo+ID4gU29tZSBOb3RlczoKPiA+IDEu
IEFzIHRoZSBmaXJzdCBzdGFnZSwgb25seSB0aGUgc29mdHdhcmUgYnJlYWtwb2ludHMgaXMgaW1w
bGVtZW50ZWQuCj4gPiAyLiBBICdjb3JuZXIgY2FzZScgaW4gd2hpY2ggdGhlIGRlYnVnIGV4Y2Vw
dGlvbiBpcyBub3QgaW5zZXJ0ZWQgYnkgdGhlCj4gPiBkZWJ1Z2dlciwgbmVlZCB0byBiZSByZS1p
bmplY3RlZCB0byB0aGUgZ3Vlc3QuIFRoaXMgaXMgbm90IGhhbmRsZWQgeWV0Cj4gPiBpbiB0aGlz
IHNlcmllcy4KPiAKPiBBc2lkZSBmcm9tIHRoZSBjb21tZW50cyBJIG1hZGUgaW4gcGF0Y2ggMSB3
LnIudCBjaGVja3MgdGhhdCAocGVyaGFwcykgY2FuIGJlIG1vdmVkCj4gdG8ga3ZtLWFsbC5jLCBp
dCBsb29rcyBnb29kIHRvIG1lLgo+IAo+IFNpbmNlIHlvdSdyZSBjaGFuZ2luZyBrdm0tYWxsLmMg
d2UnbGwgbmVlZCBQYW9sbyB0byBhY2sgdGhlIGNoYW5nZXMgaW4gcGF0Y2ggMSwgc28KPiBmZWVs
IGZyZWUgdG8gd2FpdCBmb3IgaGltIHRvIHRha2UgYSBsb29rIGJlZm9yZSBzZW5kaW5nIHYyLgo+
IAo+IAo+IFRoYW5rcywKPiAKPiAKPiBEYW5pZWwKPiAKPiA+IAo+ID4gVGhhbmtzLAo+ID4gQ2hh
bwo+ID4gCj4gPiAKPiA+IE9uIDIwMjMtMTItMjIgMjI6MTYsIERhbmllbCBIZW5yaXF1ZSBCYXJi
b3phIDxkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tPiB3cm90ZToKPiA+Pgo+ID4+IEhpLAo+ID4+
Cj4gPj4gSXQgc2VlbXMgdGhhdCB3ZSBzdGlsbCBuZWVkIHRoZSBrZXJuZWwgS1ZNIHNpZGUgdG8g
YmUgc29ydGVkIG91dCBmaXJzdCBbMV0sCj4gPj4gc28gSSBiZWxpZXZlIHdlIHNob3VsZCB3YWl0
IGEgYml0IHVudGlsIHdlIGNhbiByZXZpZXcgdGhpcyBSRkMuIE90aGVyd2lzZSB3ZQo+ID4+IG1p
Z2h0IHJpc2sgcmV2aWV3aW5nIHNvbWV0aGluZyB0aGF0IGhhcyB0byBiZSBjaGFuZ2VkIGxhdGVy
Lgo+ID4+Cj4gPj4KPiA+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzIwMjMxMjIx
MDk1MDAyLjc0MDQtMS1kdWNoYW9AZXN3aW5jb21wdXRpbmcuY29tLwo+ID4+Cj4gPj4KPiA+PiBU
aGFua3MsCj4gPj4KPiA+PiBEYW5pZWwKPiA+Pgo+ID4+IE9uIDEyLzIxLzIzIDA2OjQ5LCBDaGFv
IER1IHdyb3RlOgo+ID4+PiBUaGlzIHNlcmllcyBpbXBsZW1lbnRzIFFFTVUgS1ZNIEd1ZXN0IERl
YnVnIG9uIFJJU0MtVi4gQ3VycmVudGx5LCB3ZSBjYW4KPiA+Pj4gZGVidWcgUklTQy1WIEtWTSBn
dWVzdCBmcm9tIHRoZSBob3N0IHNpZGUsIHdpdGggc29mdHdhcmUgYnJlYWtwb2ludHMuCj4gPj4+
Cj4gPj4+IEEgYnJpZWYgdGVzdCB3YXMgZG9uZSBvbiBRRU1VIFJJU0MtViBoeXBlcnZpc29yIGVt
dWxhdG9yLgo+ID4+Pgo+ID4+PiBBIFRPRE8gbGlzdCB3aGljaCB3aWxsIGJlIGFkZGVkIGxhdGVy
Ogo+ID4+PiAxLiBIVyBicmVha3BvaW50cyBzdXBwb3J0Cj4gPj4+IDIuIFRlc3QgY2FzZXMKPiA+
Pj4KPiA+Pj4gVGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gUUVNVSA4LjIuMC1yYzQgYW5kIGlzIGFs
c28gYXZhaWxhYmxlIGF0Ogo+ID4+PiBodHRwczovL2dpdGh1Yi5jb20vRHUtQ2hhby9xZW11L3Ry
ZWUvcmlzY3ZfZ2Rfc3cKPiA+Pj4KPiA+Pj4gVGhpcyBpcyBkZXBlbmRlbnQgb24gS1ZNIHNpZGUg
Y2hhbmdlczoKPiA+Pj4gaHR0cHM6Ly9naXRodWIuY29tL0R1LUNoYW8vbGludXgvdHJlZS9yaXNj
dl9nZF9zdwo+ID4+Pgo+ID4+PiBDaGFvIER1ICg0KToKPiA+Pj4gICAgIHRhcmdldC9yaXNjdi9r
dm06IGFkZCBzb2Z0d2FyZSBicmVha3BvaW50cyBzdXBwb3J0Cj4gPj4+ICAgICB0YXJnZXQvcmlz
Y3Yva3ZtOiBpbXBsZW1lbnQga3ZtX2FyY2hfdXBkYXRlX2d1ZXN0X2RlYnVnKCkKPiA+Pj4gICAg
IHRhcmdldC9yaXNjdi9rdm06IGhhbmRsZSB0aGUgZXhpdCB3aXRoIGRlYnVnIHJlYXNvbgo+ID4+
PiAgICAgbGludXgtaGVhZGVyczogZW5hYmxlIEtWTSBHVUVTVCBERUJVRyBmb3IgUklTQy1WCj4g
Pj4+Cj4gPj4+ICAgIGFjY2VsL2t2bS9rdm0tYWxsLmMgICAgICAgICAgIHwgICA4ICstLQo+ID4+
PiAgICBpbmNsdWRlL3N5c2VtdS9rdm0uaCAgICAgICAgICB8ICAgNiArLQo+ID4+PiAgICBsaW51
eC1oZWFkZXJzL2FzbS1yaXNjdi9rdm0uaCB8ICAgMSArCj4gPj4+ICAgIHRhcmdldC9hcm0va3Zt
NjQuYyAgICAgICAgICAgIHwgICA2ICstCj4gPj4+ICAgIHRhcmdldC9pMzg2L2t2bS9rdm0uYyAg
ICAgICAgIHwgICA2ICstCj4gPj4+ICAgIHRhcmdldC9taXBzL2t2bS5jICAgICAgICAgICAgIHwg
ICA2ICstCj4gPj4+ICAgIHRhcmdldC9wcGMva3ZtLmMgICAgICAgICAgICAgIHwgICA2ICstCj4g
Pj4+ICAgIHRhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jICAgIHwgMTAxICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKPiA+Pj4gICAgdGFyZ2V0L3MzOTB4L2t2bS9rdm0uYyAgICAg
ICAgfCAgIDYgKy0KPiA+Pj4gICAgOSBmaWxlcyBjaGFuZ2VkLCAxMzAgaW5zZXJ0aW9ucygrKSwg
MTYgZGVsZXRpb25zKC0pCj4gPj4+Cj4gPj4+IC0tCj4gPj4+IDIuMTcuMQo+ID4+Pgo=

