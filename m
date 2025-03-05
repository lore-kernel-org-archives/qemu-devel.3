Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A9C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 10:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpm6e-0005eo-Ua; Wed, 05 Mar 2025 05:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1tpm6Z-0005eT-Kj
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 05:35:59 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1tpm6V-0005dw-BX
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 05:35:59 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDn7Az_KMhn9rSNBg--.23229S2;
 Wed, 05 Mar 2025 18:35:43 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Wed, 5 Mar 2025 18:35:40 +0800 (GMT+08:00)
X-Originating-IP: [218.76.62.144]
Date: Wed, 5 Mar 2025 18:35:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240812(cfb32469) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <20250305141359.00001288@huawei.com>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
 <20250220161213.000049a9@huawei.com>
 <20250221065509-mutt-send-email-mst@kernel.org>
 <17b91a9f.2847.1955fd23d78.Coremail.wangyuquan1236@phytium.com.cn>
 <20250305141359.00001288@huawei.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: BXBrtmZvb3Rlcl90eHQ9MTczMTozODM=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4752672.2b5f.19565e01b65.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBna4f8KMhn3Oo6AA--.5354W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWfHXBcGa
	wAAsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr4xAr4kGrW3AFy8JF1DWrg_yoWrtrW5p3
 W8Ja48Aw1UKa17G3yS9w18ZryUG3yUGr47Xw10y39FywnrJrn0qrnIgFZ7J3Wjgay5tr4D
 t3W7X390qr1UtrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cj4gCj4gT24gVHVlLCA0IE1hciAyMDI1IDE0OjIyOjQ4ICswODAwCj4gWXVxdWFuIFdhbmcgPHdh
bmd5dXF1YW4xMjM2QHBoeXRpdW0uY29tLmNuPiB3cm90ZToKPiAKPiA+ID4gCj4gPiA+IE9uIFRo
dSwgRmViIDIwLCAyMDI1IGF0IDA0OjEyOjEzUE0gKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3Jv
dGU6ICAKPiA+ID4gPiBPbiBNb24sIDE3IEZlYiAyMDI1IDE5OjIwOjM5ICswODAwCj4gPiA+ID4g
WXVxdWFuIFdhbmcgPHdhbmd5dXF1YW4xMjM2QHBoeXRpdW0uY29tLmNuPiB3cm90ZToKPiA+ID4g
PiAgIAo+ID4gPiA+ID4gQWRkIHNlcmlhbCBudW1iZXIgcGFyYW1ldGVyIGluIHRoZSBjeGwgcGVy
c2lzdGVudCBleGFtcGxlcy4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVx
dWFuIFdhbmcgPHdhbmd5dXF1YW4xMjM2QHBoeXRpdW0uY29tLmNuPiAgCj4gPiA+ID4gTG9va3Mg
Z29vZC4gIEkndmUgcXVldWVkIGl0IHVwIG9uIG15IGdpdGxhYiBzdGFnaW5nIHRyZWUsIGJ1dAo+
ID4gPiA+IE1pY2hhZWwgaWYgeW91IHdhbnQgdG8gcGljayB0aGlzIG9uZSBkaXJlY3RseSB0aGF0
J3MgZmluZSBhcyB3ZWxsLiAgCj4gPiA+IAo+ID4gPiBTZWUgbm8gcmVhc29uIHRvLCBJIHdhcyBu
b3QgZXZlbiBDQydkLiAgCj4gPiAKPiA+IEhpLCBNaWNoYWVsCj4gPiAKPiA+IEknbSBzb3JyeSwg
dGhpcyBpcyBteSBmYXVsdC4gSSB1c2VkICJnZXRfbWFpbnRhaW5lci5wbCIgdG8gY2hlY2sgdGhp
cwo+ID4gcGF0Y2gncyBtYWludGFpbmVycyBidXQgaXQgc2hvd3MgIk5vIG1haW50YWluZXJzIGZv
dW5kLCBwcmludGluZyByZWNlbnQKPiA+IGNvbnRyaWJ1dG9ycyIuIAo+ID4gCj4gSSB1c3VhbGx5
IHN0YWdlIHVwIG11bHRpcGxlIHNlcmllcyB0b2dldGhlciBhbmQgc2VuZCBvbiB0byBNaWNoYWVs
Lgo+IFNvIGl0IHdhcyBiZSBiZWluZyBsYXp5IGZvciBhIG1pbm9yIGNoYW5nZSByYXRoZXIgdGhh
biBhbnl0aGluZyBtdWNoCj4gdGhhdCB5b3UgZGlkIHdyb25nLgo+IAo+IElmIEkgZ2V0IHRpbWUg
SSdsbCBwb3N0IGEgc2VyaWVzIHdpdGggdGhpcyBhIGZldyBvdGhlciBwYXRjaGVzCj4gbGF0ZXIg
dG9kYXkuICAKPiAKPiBKb25hdGhhbgo+IApUaGFuayB5b3UhCgpCVFcsIEkgZm91bmQgYSBjb3Ju
ZXIgY2FzZSBpbiBDWEwgbnVtYSBub2RlIGNyZWF0aW9uLgoKQ29uZGl0aW9uOiAKMSkgQSBVTUEv
TlVNQSBzeXN0ZW0gd2l0aG91dCBTUkFULCBidXQgd2l0aCBDRURULkNGTVdTCjLvvIlFbmFibGUg
Q09ORklHX0FDUElfTlVNQQoKUmVzdWx0czoKMSkgYWNwaV9udW1hX2luaXQ6IHRoZSBmYWtlX3B4
bSB3aWxsIGJlIDAgYW5kIHNlbmQgdG8gYWNwaV9wYXJzZV9jZm13cygpCjLvvIlJZiBkeW5hbWlj
YWxseSBjcmVhdGUgY3hsIHJhbSByZWdpb24sIHRoZSBjeGwgbWVtb3J5IHdvdWxkIGJlIGFzc2ln
bmVkCnRvIG5vZGUwIHJhdGhlciB0aGFuIGEgbmV3IG5vZGUKCkNvbmZ1c2lvbnM6CjEpIElzIGEg
bnVtYSBzeXN0ZW0gYSByZXF1aXJlbWVudCBmb3IgQ1hMIG1lbW9yeSB1c2FnZT8KMikgU2hvdWxk
IHdlIGZvcmJpZCB0aGlzIHNpdHVhdGlvbiBieSBhZGRpbmcgZmFrZV9weG0gY2hlY2sgYW5kIHJl
dHVybmluZwplcnJvciBpbiBhY3BpX251bWFfaW5pdCgpPyAKM++8iU9yIHdlIGNhbiBhZGQgc29t
ZSBrZXJuZWwgY29kZSB0byBhbGxvdyBjcmVhdGUgdGhlc2UgZmFrZSBub2RlcyBvbiBhCnN5c3Rl
bSB3aXRob3V0IFNSQVQ/CgpZdXF1YW4KCgoKDQoNCuS/oeaBr+WuieWFqOWjsOaYju+8muacrOmC
ruS7tuWMheWQq+S/oeaBr+W9kuWPkeS7tuS6uuaJgOWcqOe7hOe7h+aJgOaciSzlj5Hku7bkurrm
iYDlnKjnu4Tnu4flr7nor6Xpgq7ku7bmi6XmnInmiYDmnInmnYPliKnjgILor7fmjqXmlLbogIXm
s6jmhI/kv53lr4Ys5pyq57uP5Y+R5Lu25Lq65Lmm6Z2i6K645Y+vLOS4jeW+l+WQkeS7u+S9lees
rOS4ieaWuee7hOe7h+WSjOS4quS6uumAj+mcsuacrOmCruS7tuaJgOWQq+S/oeaBr+OAgg0KSW5m
b3JtYXRpb24gU2VjdXJpdHkgTm90aWNlOiBUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRo
aXMgbWFpbCBpcyBzb2xlbHkgcHJvcGVydHkgb2YgdGhlIHNlbmRlcidzIG9yZ2FuaXphdGlvbi5U
aGlzIG1haWwgY29tbXVuaWNhdGlvbiBpcyBjb25maWRlbnRpYWwuUmVjaXBpZW50cyBuYW1lZCBh
Ym92ZSBhcmUgb2JsaWdhdGVkIHRvIG1haW50YWluIHNlY3JlY3kgYW5kIGFyZSBub3QgcGVybWl0
dGVkIHRvIGRpc2Nsb3NlIHRoZSBjb250ZW50cyBvZiB0aGlzIGNvbW11bmljYXRpb24gdG8gb3Ro
ZXJzLg==


