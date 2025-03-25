Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E94C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 07:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twz2z-0005Jz-Dq; Tue, 25 Mar 2025 03:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1twz2m-0005IU-OD
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 03:49:53 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1twz2j-0000lq-OS
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 03:49:52 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn7GgSYOJnWbJPDQ--.301S2;
 Tue, 25 Mar 2025 15:49:38 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Tue, 25 Mar 2025 15:49:37 +0800 (GMT+08:00)
X-Originating-IP: [218.76.62.144]
Date: Tue, 25 Mar 2025 15:49:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240812(cfb32469) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <20250312181035.00006e32@huawei.com>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
 <20250220161213.000049a9@huawei.com>
 <20250221065509-mutt-send-email-mst@kernel.org>
 <17b91a9f.2847.1955fd23d78.Coremail.wangyuquan1236@phytium.com.cn>
 <20250305141359.00001288@huawei.com>
 <4752672.2b5f.19565e01b65.Coremail.wangyuquan1236@phytium.com.cn>
 <20250312181035.00006e32@huawei.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: rc52s2Zvb3Rlcl90eHQ9MjkyMDozODM=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <243092c2.4d3c.195cc474586.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBna4cRYOJn6cdTAA--.8322W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWfhujoEA
	wABsA
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3WFy5CF13tr17Ar1kZF4Dtwb_yoW3Gr1rp3
 W8Aa48Aw1UK3W7G3ySkw18AryUK3yUGr47Xw1vy390ywnrJrn8XrnxKFZ7J3Wjgay5trs8
 t3W7X390qr1UtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_BL=0.001,
 RCVD_IN_MSPIKE_ZBI=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiSm9uYXRoYW4gQ2FtZXJv
biIgPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4KPiDlj5HpgIHml7bpl7Q6MjAyNS0wMy0x
MyAwMjoxMDozNSAo5pif5pyf5ZubKQo+IOaUtuS7tuS6ujogIll1cXVhbiBXYW5nIiA8d2FuZ3l1
cXVhbjEyMzZAcGh5dGl1bS5jb20uY24+Cj4g5oqE6YCBOiBxZW11LWRldmVsQG5vbmdudS5vcmcs
IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmcKPiDkuLvpopg6IFJlOiBbUEFUQ0hdIGRvY3MvY3hs
OiBBZGQgc2VyaWFsIG51bWJlciBmb3IgcGVyc2lzdGVudC1tZW1kZXYKPiAKPiBPbiBXZWQsIDUg
TWFyIDIwMjUgMTg6MzU6NDAgKzA4MDAKPiBZdXF1YW4gV2FuZyA8d2FuZ3l1cXVhbjEyMzZAcGh5
dGl1bS5jb20uY24+IHdyb3RlOgo+IAo+ID4gPiAKPiA+ID4gT24gVHVlLCA0IE1hciAyMDI1IDE0
OjIyOjQ4ICswODAwCj4gPiA+IFl1cXVhbiBXYW5nIDx3YW5neXVxdWFuMTIzNkBwaHl0aXVtLmNv
bS5jbj4gd3JvdGU6Cj4gPiA+ICAgCj4gPiA+ID4gPiAKPiA+ID4gPiA+IE9uIFRodSwgRmViIDIw
LCAyMDI1IGF0IDA0OjEyOjEzUE0gKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6ICAgIAo+
ID4gPiA+ID4gPiBPbiBNb24sIDE3IEZlYiAyMDI1IDE5OjIwOjM5ICswODAwCj4gPiA+ID4gPiA+
IFl1cXVhbiBXYW5nIDx3YW5neXVxdWFuMTIzNkBwaHl0aXVtLmNvbS5jbj4gd3JvdGU6Cj4gPiA+
ID4gPiA+ICAgICAKPiA+ID4gPiA+ID4gPiBBZGQgc2VyaWFsIG51bWJlciBwYXJhbWV0ZXIgaW4g
dGhlIGN4bCBwZXJzaXN0ZW50IGV4YW1wbGVzLgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFl1cXVhbiBXYW5nIDx3YW5neXVxdWFuMTIzNkBwaHl0aXVtLmNvbS5j
bj4gICAgCj4gPiA+ID4gPiA+IExvb2tzIGdvb2QuICBJJ3ZlIHF1ZXVlZCBpdCB1cCBvbiBteSBn
aXRsYWIgc3RhZ2luZyB0cmVlLCBidXQKPiA+ID4gPiA+ID4gTWljaGFlbCBpZiB5b3Ugd2FudCB0
byBwaWNrIHRoaXMgb25lIGRpcmVjdGx5IHRoYXQncyBmaW5lIGFzIHdlbGwuICAgIAo+ID4gPiA+
ID4gCj4gPiA+ID4gPiBTZWUgbm8gcmVhc29uIHRvLCBJIHdhcyBub3QgZXZlbiBDQydkLiAgICAK
PiA+ID4gPiAKPiA+ID4gPiBIaSwgTWljaGFlbAo+ID4gPiA+IAo+ID4gPiA+IEknbSBzb3JyeSwg
dGhpcyBpcyBteSBmYXVsdC4gSSB1c2VkICJnZXRfbWFpbnRhaW5lci5wbCIgdG8gY2hlY2sgdGhp
cwo+ID4gPiA+IHBhdGNoJ3MgbWFpbnRhaW5lcnMgYnV0IGl0IHNob3dzICJObyBtYWludGFpbmVy
cyBmb3VuZCwgcHJpbnRpbmcgcmVjZW50Cj4gPiA+ID4gY29udHJpYnV0b3JzIi4gCj4gPiA+ID4g
ICAKPiA+ID4gSSB1c3VhbGx5IHN0YWdlIHVwIG11bHRpcGxlIHNlcmllcyB0b2dldGhlciBhbmQg
c2VuZCBvbiB0byBNaWNoYWVsLgo+ID4gPiBTbyBpdCB3YXMgYmUgYmVpbmcgbGF6eSBmb3IgYSBt
aW5vciBjaGFuZ2UgcmF0aGVyIHRoYW4gYW55dGhpbmcgbXVjaAo+ID4gPiB0aGF0IHlvdSBkaWQg
d3JvbmcuCj4gPiA+IAo+ID4gPiBJZiBJIGdldCB0aW1lIEknbGwgcG9zdCBhIHNlcmllcyB3aXRo
IHRoaXMgYSBmZXcgb3RoZXIgcGF0Y2hlcwo+ID4gPiBsYXRlciB0b2RheS4gIAo+ID4gPiAKPiA+
ID4gSm9uYXRoYW4KPiA+ID4gICAKPiA+IFRoYW5rIHlvdSEKPiA+IAo+ID4gQlRXLCBJIGZvdW5k
IGEgY29ybmVyIGNhc2UgaW4gQ1hMIG51bWEgbm9kZSBjcmVhdGlvbi4KPiA+IAo+ID4gQ29uZGl0
aW9uOiAKPiA+IDEpIEEgVU1BL05VTUEgc3lzdGVtIHdpdGhvdXQgU1JBVCwgYnV0IHdpdGggQ0VE
VC5DRk1XUwo+ID4gMu+8iUVuYWJsZSBDT05GSUdfQUNQSV9OVU1BCj4gPiAKPiA+IFJlc3VsdHM6
Cj4gPiAxKSBhY3BpX251bWFfaW5pdDogdGhlIGZha2VfcHhtIHdpbGwgYmUgMCBhbmQgc2VuZCB0
byBhY3BpX3BhcnNlX2NmbXdzKCkKPiA+IDLvvIlJZiBkeW5hbWljYWxseSBjcmVhdGUgY3hsIHJh
bSByZWdpb24sIHRoZSBjeGwgbWVtb3J5IHdvdWxkIGJlIGFzc2lnbmVkCj4gPiB0byBub2RlMCBy
YXRoZXIgdGhhbiBhIG5ldyBub2RlCj4gPiAKPiA+IENvbmZ1c2lvbnM6Cj4gPiAxKSBJcyBhIG51
bWEgc3lzdGVtIGEgcmVxdWlyZW1lbnQgZm9yIENYTCBtZW1vcnkgdXNhZ2U/Cj4gCj4gT2J2aW91
c2x5IGRpc2N1c3Npb24gaGFzIGdvbmUgb24gZWxzZXdoZXJlLCBidXQgSSdkIHNheSBpbiBnZW5l
cmFsIGl0Cj4gd291bGQgYmUgYSBiYWQgaWRlYSB0byBub3QgaGF2ZSBhbiBTUkFUIGJlY2F1c2Ug
dGhlIG1vbWVudCB3ZSBhZGQgQ1hMCj4gaXQgaXMgZGVmaW5pdGVseSBhIE5VTUEgc3lzdGVtIGFu
ZCB3ZSB3YW50IHRoZSBHZW5lcmljIFBvcnQgZW50cnkgdG8KPiBhbGxvdyB1cyB0byBnZXQgcGVy
ZiBpbmZvcm1hdGlvbi4KPiAKPiBTbyBJIHdvdWxkbid0IG1pbmQgaWYgd2UgZmFpbCBDWEwgaW5p
dCBpbiB0aGlzIGNhc2UsIGJ1dCBtYXliZQo+IGl0IGlzIHdvcnRoIHBhcGVyaW5nIG92ZXIgdGhp
bmdzLgo+IAo+IEpvbmF0aGFuCj4gCgpIaSwgSm9uYXRoYW4KClJlY2VudGx0eSBJIG1hbmFnZWQg
dG8gZG8gc29tZSBob3QtcGx1ZyB0ZXN0cyBvbiBjeGwgdHlwZTMgZGV2aWNlIG9uIFFFTVUuCkkg
dHJpZWQgdXNlICJkZXZpY2UgYWRkIiBxZW11IGNvbW1hbmQgaW4gbW9uaXRvciwgYnV0IGl0IGZh
aWxlZC4gSSBhbHNvIHVzZWQKdW5iaW5kL2JpbmQgY3hsX3BjaSBkcml2ZXIgaW4gc3lzZnMsIEkg
Y2FuIHNlZSB0aGUgc29mdHdhcmUgZmxvdyBvbiBkZXZpY2UgYnV0Cm5vIGV4cGVjdGVkIGFjdGlv
bnMgb24gY3hsIHJvb3QgcG9ydHMgbGlua2VkKGxpa2UgcGNpZSBob3QtcGx1ZyBpbnRlcnJ1cHQg
YW5kCnNvIG9uKS4KCkNvdWxkIHdlIHNpbXVsYXRlIGEgaG90LWFkZCBmbG93IG9mIHR5cGUzIGRl
dmljZSBpbiBxZW11IG5vdz8gTWF5YmUgSSB1c2VkIHRoZQp3cm9uZyBtZXRob2QgOigKCll1cXVh
bgoNCg0K5L+h5oGv5a6J5YWo5aOw5piO77ya5pys6YKu5Lu25YyF5ZCr5L+h5oGv5b2S5Y+R5Lu2
5Lq65omA5Zyo57uE57uH5omA5pyJLOWPkeS7tuS6uuaJgOWcqOe7hOe7h+WvueivpemCruS7tuaL
peacieaJgOacieadg+WIqeOAguivt+aOpeaUtuiAheazqOaEj+S/neWvhizmnKrnu4/lj5Hku7bk
urrkuabpnaLorrjlj68s5LiN5b6X5ZCR5Lu75L2V56ys5LiJ5pa557uE57uH5ZKM5Liq5Lq66YCP
6Zyy5pys6YKu5Lu25omA5ZCr5L+h5oGv44CCDQpJbmZvcm1hdGlvbiBTZWN1cml0eSBOb3RpY2U6
IFRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBtYWlsIGlzIHNvbGVseSBwcm9wZXJ0
eSBvZiB0aGUgc2VuZGVyJ3Mgb3JnYW5pemF0aW9uLlRoaXMgbWFpbCBjb21tdW5pY2F0aW9uIGlz
IGNvbmZpZGVudGlhbC5SZWNpcGllbnRzIG5hbWVkIGFib3ZlIGFyZSBvYmxpZ2F0ZWQgdG8gbWFp
bnRhaW4gc2VjcmVjeSBhbmQgYXJlIG5vdCBwZXJtaXR0ZWQgdG8gZGlzY2xvc2UgdGhlIGNvbnRl
bnRzIG9mIHRoaXMgY29tbXVuaWNhdGlvbiB0byBvdGhlcnMu


