Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6204AC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogu7-0003Rp-2T; Mon, 25 Mar 2024 05:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1rogty-0003RO-3u; Mon, 25 Mar 2024 05:45:59 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1rogtt-0007rB-Pf; Mon, 25 Mar 2024 05:45:57 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXRwjERwFmmrQyBw--.51115S2;
 Mon, 25 Mar 2024 17:45:40 +0800 (CST)
Received: from xiongyining1480$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Mon, 25 Mar 2024 17:45:35 +0800 (GMT+08:00)
X-Originating-IP: [218.76.62.144]
Date: Mon, 25 Mar 2024 17:45:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?54aK5LmZ5a6B?= <xiongyining1480@phytium.com.cn>
To: "Marcin Juszkiewicz" <marcin.juszkiewicz@linaro.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, chenbaozi@phytium.com.cn,
 quic_llindhol@quicinc.com
Subject: Re: [PATCH v2 0/2] ARM Sbsa-ref: Enable CPU cluster topology
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230609(48863718) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-76b96e3b-3ecc-44d5-9200-de81e6d4c242-
In-Reply-To: <c0478bc2-73bb-4048-988b-a05df30cdbd4@linaro.org>
References: <20240312083049.3412522-1-xiongyining1480@phytium.com.cn>
 <CAFEAcA8sQnBzFq3b_WscYY1o+J2CutFrEcTGHXvbi8YVn6vorg@mail.gmail.com>
 <c0478bc2-73bb-4048-988b-a05df30cdbd4@linaro.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: 79P2OGZvb3Rlcl90eHQ9MTkyOTozODM=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6d9dd876.2cb.18e75004489.Coremail.xiongyining1480@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3O5PARwFm22kAAA--.338W
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQAPBmYAgF4G 8AAAsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=xiongyinin
 g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kr1fuw1xuw18Ww4UGFy7Awb_yoW8Cw1DpF
 4Fqw1YkF4kKwn0k3Z7CF1xua45Zw1rWrW8Jr1kCw48CFnxWF92gryftrs09a4DGws5G3y2
 gF1Ig34kuF1DZrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=xiongyining1480@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

PiBXIGRuaXUgMjIuMDMuMjAyNCBvwqAxOTo1MSwgUGV0ZXIgTWF5ZGVsbCBwaXN6ZToKPiA+IE9u
IFR1ZSwgMTIgTWFyIDIwMjQgYXQgMDg6MzIsIFhpb25nIFlpbmluZwo+IAo+ID4+IHhpb25neWlu
aW5nMTQ4MCAoMik6Cj4gPj4gICAgaHcvYXJtL3Nic2EtcmVmOkVuYWJsZSBDUFUgY2x1c3RlciBv
biBBUk0gc2JzYSBtYWNoaW5lCj4gPj4gICAgaHcvYXJtL3Nic2EtcmVmOiBBZGQgY3B1LW1hcCB0
byBkZXZpY2UgdHJlZQo+ID4gCj4gPiBUaGFua3MgZm9yIHRoZXNlIHBhdGNoZXMuIEkgdGhpbmsg
d2Ugc2hvdWxkIHNxdWFzaCB0aGUgdHdvCj4gPiBwYXRjaGVzIHRvZ2V0aGVyIGludG8gb25lLCBi
ZWNhdXNlIHRoZSBmaXJzdCBwYXRjaCBpcyBvbmx5Cj4gPiBhIHNpbmdsZSBsaW5lLCBhbmQgYWxz
byBiZWNhdXNlIHdlIHNob3VsZG4ndCBzYXkgdGhhdCB0aGUKPiA+IG1hY2hpbmUgc3VwcG9ydHMg
Y2x1c3RlciB0b3BvbG9neSB1bnRpbCBpdCBhY3R1YWxseSBkb2VzCj4gPiBieSBwdXR0aW5nIHRo
ZSBpbmZvcm1hdGlvbiBpbnRvIHRoZSBkZXZpY2UgdHJlZS4KCmZ1bGx5IGFncmVlCgo+ID4gVGhl
cmUncyBubyBydXNoLCBiZWNhdXNlIHdlJ3JlICBub3cgaW4gc29mdGZyZWV6ZSBmb3IgOS4wLCBz
byB0aGVzZQo+ID4gd2lsbCBoYXZlIHRvIHdhaXQgdW50aWwgOS4wIGlzIHJlbGVhc2VkIChpbiBh
Ym91dCBhIG1vbnRoJ3MgdGltZSkuCj4gCj4gPiBJJ20gYWxzbyBhIGJpdCBjb25mdXNlZCBieSB0
aGUgUmV2aWV3ZWQtYnk6IHRhZyBmcm9tIE1hcmNpbiBvbiBwYXRjaCAyLAo+ID4gYmVjYXVzZSBJ
IGNhbid0IHNlZSB0aGF0IGluIG15IG1haWwgYXJjaGl2ZXMgb2YgdGhlIGRpc2N1c3Npb24gb24g
dmVyc2lvbgo+ID4gMSBvZiB0aGlzIHBhdGNoc2V0LCBvbmx5IGEgVGVzdGVkLWJ5Lgo+ID4gTWFy
Y2luLCBhcmUgeW91IE9LIHdpdGggdGhlc2UgcGF0Y2hlcz8KPiAKPiBJIG9ubHkgdGVzdGVkIHRo
ZW0uIFRoZXkgYXJlIGZpbmUsIHdpbGwgY2hlY2sgb24gTW9uZGF5Lgo+IAo+ID4gQWxzbywgaXMg
dGhpcyBjaGFuZ2UgdG8gdGhlIERUQiBzb21ldGhpbmcgdGhhdCB3b3VsZCByZXF1aXJlIGFuCj4g
PiBpbmNyZWFzZSBpbiB0aGUgc2JzYS1yZWYgcGxhdGZvcm0gdmVyc2lvbiBudW1iZXIsIG9yIG5v
dD8KPiAKPiBURi1BIHdpbGwgY2hlY2sgZm9yICIvY3B1cy9jcHUtbWFwIiBub2RlIGFuZCBpZiBp
dCBpcyBtaXNzaW5nIHRoZW4gd2lsbCAKPiBub3QgcHJvdmlkZSBpdCB0byBFREsyLiBTbyBmYXIg
SSBkaWQgbm90IHNhdyBwYXRjaGVzIGZvciBmaXJtd2FyZSBzaWRlLgoKSSBzZW5kIGEgcGF0Y2gg
aW4gVEYtQSB0byBjaGVjayAgIi9jcHVzL2NwdS1tYXAiIG5vZGUgaHR0cHM6Ly9yZXZpZXcudHJ1
c3RlZGZpcm13YXJlLm9yZy9jL1RGLUEvdHJ1c3RlZC1maXJtd2FyZS1hLysvMjcxODkvMSNtZXNz
YWdlLTJjMjliZTZiOGI5YjRmZDNmZWYyM2JhN2JlNmZlNmZjM2EyZDBhZWYuIEl0IGNhbiBiZSB1
c2VkIHdpdGggdGhpcyBwYXRjaCBpbiBxZW11LgoKPiBJIHdvdWxkIGFkZCBidW1wIG9mIHBsYXRm
b3JtIHZlcnNpb24gdG8gMC40IG9uZS4gSXQgaXMgY2hlYXAgb3BlcmF0aW9uIAo+IGFuZCBzbyBm
YXIgKGZyb20gZmlybXdhcmUgc2lkZSkgd2UgY2hlY2sgZm9yID49IDAuMyBvbmx5Lgo+IAo+ICA+
IFNob3VsZCB3ZSBhZGp1c3QgdGhlIGRvY3VtZW50YXRpb24gaW4gZG9jcy9zeXN0ZW0vYXJtL3Ni
c2EucnN0IHRvCj4gID4gbWVudGlvbiB0aGF0IHRoZSBEVEIgbWlnaHQgaGF2ZSBjbHVzdGVyIHRv
cG9sb2d5IGluZm9ybWF0aW9uPwo+IAo+IFllcy4gSSB3aWxsIHNlbmQgYW4gdXBkYXRlIHRvIG1l
bnRpb24gdGhhdCBOVU1BIGNvbmZpZ3VyYXRpb24gY2FuIGJlIAo+IHRoZXJlIHRvbyAod2UgYWxy
ZWFkeSBleHBvcnQgaXQgZnJvbSBURi1BIHRvIEVESzIgdmlhIFNNQyBjYWxscykuCg0KDQrkv6Hm
ga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7bljIXlkKvkv6Hmga/lvZLlj5Hku7bkurrmiYDlnKjn
u4Tnu4fmiYDmnIks5Y+R5Lu25Lq65omA5Zyo57uE57uH5a+56K+l6YKu5Lu25oul5pyJ5omA5pyJ
5p2D5Yip44CC6K+35o6l5pS26ICF5rOo5oSP5L+d5a+GLOacque7j+WPkeS7tuS6uuS5pumdouiu
uOWPryzkuI3lvpflkJHku7vkvZXnrKzkuInmlrnnu4Tnu4flkozkuKrkurrpgI/pnLLmnKzpgq7k
u7bmiYDlkKvkv6Hmga/jgIINCkluZm9ybWF0aW9uIFNlY3VyaXR5IE5vdGljZTogVGhlIGluZm9y
bWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIG1haWwgaXMgc29sZWx5IHByb3BlcnR5IG9mIHRoZSBz
ZW5kZXIncyBvcmdhbml6YXRpb24uVGhpcyBtYWlsIGNvbW11bmljYXRpb24gaXMgY29uZmlkZW50
aWFsLlJlY2lwaWVudHMgbmFtZWQgYWJvdmUgYXJlIG9ibGlnYXRlZCB0byBtYWludGFpbiBzZWNy
ZWN5IGFuZCBhcmUgbm90IHBlcm1pdHRlZCB0byBkaXNjbG9zZSB0aGUgY29udGVudHMgb2YgdGhp
cyBjb21tdW5pY2F0aW9uIHRvIG90aGVycy4=


