Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06008C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru82F-00089G-2M; Tue, 09 Apr 2024 05:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1ru825-0007nU-2B; Tue, 09 Apr 2024 05:44:50 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>)
 id 1ru820-0007Cu-Dw; Tue, 09 Apr 2024 05:44:48 -0400
Received: from duchao$eswincomputing.com ( [10.64.113.11] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 9 Apr 2024 17:43:15 +0800 (GMT+08:00)
X-Originating-IP: [10.64.113.11]
Date: Tue, 9 Apr 2024 17:43:15 +0800 (GMT+08:00)
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
In-Reply-To: <846ec319-6026-4b14-b156-9e1f42c6dba1@ventanamicro.com>
References: <20231221094923.7349-1-duchao@eswincomputing.com>
 <846ec319-6026-4b14-b156-9e1f42c6dba1@ventanamicro.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <48d413a8.25e8.18ec23d85b9.Coremail.duchao@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID: TQJkCgAnOryzDRVmgrQFAA--.3440W
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/1tbiAgECDGYVDQ0ACAABs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=duchao@eswincomputing.com;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

SGkgRGFuaWVsIGFuZCBhbGwsCgpUaGUgS1ZNIHBhdGNoZXMgaGF2ZSBiZWVuIHJldmlld2QgYW5k
IGFyZSBpbiB0aGUgcXVldWUuCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDQwMjA2
MjYyOC41NDI1LTEtZHVjaGFvQGVzd2luY29tcHV0aW5nLmNvbS8KCkNvdWxkIHlvdSBwbGVhc2Ug
cmV2aWV3IGluIHRoZSBRRU1VIHNpZGUgPwpUaGVuIEkgd2lsbCByZWJhc2UgdGhpcyBzZXJpZXMg
d2l0aCB5b3VyIGNvbW1lbnRzLgoKU29tZSBOb3RlczoKMS4gQXMgdGhlIGZpcnN0IHN0YWdlLCBv
bmx5IHRoZSBzb2Z0d2FyZSBicmVha3BvaW50cyBpcyBpbXBsZW1lbnRlZC4KMi4gQSAnY29ybmVy
IGNhc2UnIGluIHdoaWNoIHRoZSBkZWJ1ZyBleGNlcHRpb24gaXMgbm90IGluc2VydGVkIGJ5IHRo
ZQpkZWJ1Z2dlciwgbmVlZCB0byBiZSByZS1pbmplY3RlZCB0byB0aGUgZ3Vlc3QuIFRoaXMgaXMg
bm90IGhhbmRsZWQgeWV0CmluIHRoaXMgc2VyaWVzLgoKVGhhbmtzLApDaGFvCgoKT24gMjAyMy0x
Mi0yMiAyMjoxNiwgRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgPGRiYXJib3phQHZlbnRhbmFtaWNy
by5jb20+IHdyb3RlOgo+IAo+IEhpLAo+IAo+IEl0IHNlZW1zIHRoYXQgd2Ugc3RpbGwgbmVlZCB0
aGUga2VybmVsIEtWTSBzaWRlIHRvIGJlIHNvcnRlZCBvdXQgZmlyc3QgWzFdLAo+IHNvIEkgYmVs
aWV2ZSB3ZSBzaG91bGQgd2FpdCBhIGJpdCB1bnRpbCB3ZSBjYW4gcmV2aWV3IHRoaXMgUkZDLiBP
dGhlcndpc2Ugd2UKPiBtaWdodCByaXNrIHJldmlld2luZyBzb21ldGhpbmcgdGhhdCBoYXMgdG8g
YmUgY2hhbmdlZCBsYXRlci4KPiAKPiAKPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3Zt
LzIwMjMxMjIxMDk1MDAyLjc0MDQtMS1kdWNoYW9AZXN3aW5jb21wdXRpbmcuY29tLwo+IAo+IAo+
IFRoYW5rcywKPiAKPiBEYW5pZWwKPiAKPiBPbiAxMi8yMS8yMyAwNjo0OSwgQ2hhbyBEdSB3cm90
ZToKPiA+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgUUVNVSBLVk0gR3Vlc3QgRGVidWcgb24gUklT
Qy1WLiBDdXJyZW50bHksIHdlIGNhbgo+ID4gZGVidWcgUklTQy1WIEtWTSBndWVzdCBmcm9tIHRo
ZSBob3N0IHNpZGUsIHdpdGggc29mdHdhcmUgYnJlYWtwb2ludHMuCj4gPiAKPiA+IEEgYnJpZWYg
dGVzdCB3YXMgZG9uZSBvbiBRRU1VIFJJU0MtViBoeXBlcnZpc29yIGVtdWxhdG9yLgo+ID4gCj4g
PiBBIFRPRE8gbGlzdCB3aGljaCB3aWxsIGJlIGFkZGVkIGxhdGVyOgo+ID4gMS4gSFcgYnJlYWtw
b2ludHMgc3VwcG9ydAo+ID4gMi4gVGVzdCBjYXNlcwo+ID4gCj4gPiBUaGlzIHNlcmllcyBpcyBi
YXNlZCBvbiBRRU1VIDguMi4wLXJjNCBhbmQgaXMgYWxzbyBhdmFpbGFibGUgYXQ6Cj4gPiBodHRw
czovL2dpdGh1Yi5jb20vRHUtQ2hhby9xZW11L3RyZWUvcmlzY3ZfZ2Rfc3cKPiA+IAo+ID4gVGhp
cyBpcyBkZXBlbmRlbnQgb24gS1ZNIHNpZGUgY2hhbmdlczoKPiA+IGh0dHBzOi8vZ2l0aHViLmNv
bS9EdS1DaGFvL2xpbnV4L3RyZWUvcmlzY3ZfZ2Rfc3cKPiA+IAo+ID4gQ2hhbyBEdSAoNCk6Cj4g
PiAgICB0YXJnZXQvcmlzY3Yva3ZtOiBhZGQgc29mdHdhcmUgYnJlYWtwb2ludHMgc3VwcG9ydAo+
ID4gICAgdGFyZ2V0L3Jpc2N2L2t2bTogaW1wbGVtZW50IGt2bV9hcmNoX3VwZGF0ZV9ndWVzdF9k
ZWJ1ZygpCj4gPiAgICB0YXJnZXQvcmlzY3Yva3ZtOiBoYW5kbGUgdGhlIGV4aXQgd2l0aCBkZWJ1
ZyByZWFzb24KPiA+ICAgIGxpbnV4LWhlYWRlcnM6IGVuYWJsZSBLVk0gR1VFU1QgREVCVUcgZm9y
IFJJU0MtVgo+ID4gCj4gPiAgIGFjY2VsL2t2bS9rdm0tYWxsLmMgICAgICAgICAgIHwgICA4ICst
LQo+ID4gICBpbmNsdWRlL3N5c2VtdS9rdm0uaCAgICAgICAgICB8ICAgNiArLQo+ID4gICBsaW51
eC1oZWFkZXJzL2FzbS1yaXNjdi9rdm0uaCB8ICAgMSArCj4gPiAgIHRhcmdldC9hcm0va3ZtNjQu
YyAgICAgICAgICAgIHwgICA2ICstCj4gPiAgIHRhcmdldC9pMzg2L2t2bS9rdm0uYyAgICAgICAg
IHwgICA2ICstCj4gPiAgIHRhcmdldC9taXBzL2t2bS5jICAgICAgICAgICAgIHwgICA2ICstCj4g
PiAgIHRhcmdldC9wcGMva3ZtLmMgICAgICAgICAgICAgIHwgICA2ICstCj4gPiAgIHRhcmdldC9y
aXNjdi9rdm0va3ZtLWNwdS5jICAgIHwgMTAxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPiA+ICAgdGFyZ2V0L3MzOTB4L2t2bS9rdm0uYyAgICAgICAgfCAgIDYgKy0KPiA+ICAg
OSBmaWxlcyBjaGFuZ2VkLCAxMzAgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4gPiAK
PiA+IC0tCj4gPiAyLjE3LjEKPiA+IAo=

