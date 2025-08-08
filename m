Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A695CC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIin-0001dd-9k; Fri, 08 Aug 2025 04:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1ukIid-0001cE-4w; Fri, 08 Aug 2025 04:44:55 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1ukIiW-00038M-IG; Fri, 08 Aug 2025 04:44:54 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAHZ+P3uJVo46_+BA--.31662S2;
 Fri, 08 Aug 2025 16:44:39 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Fri, 8 Aug 2025 16:44:34 +0800 (GMT+08:00)
X-Originating-IP: [218.76.62.144]
Date: Fri, 8 Aug 2025 16:44:34 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v13 1/5] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250512(e7b47ee3) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
In-Reply-To: <20250513111455.128266-2-Jonathan.Cameron@huawei.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-2-Jonathan.Cameron@huawei.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: JShZGWZvb3Rlcl90eHQ9Mjg5NzozODM=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2883bf9d.17a0.19888da7214.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwAXoAfyuJVoBhINAA--.3982W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWiU-30C8
	AAPsT
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtw47uFyDZrWDuFy8Ww4fuFg_yoW3GFW8p3
 WxJ34UAw1UKw17J3yxCr18ArW8ArWUGr47Jw1xtayYvr17Jr4DWrnxKFWUA3Wjga4jgrn8
 tw1UWrs8Xr1jqrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

U29ycnkgZm9yIGRpc3R1cmJpbmchIEkgdHJpZWQgdG8gdGVzdCBzZW5kIG1vcmUgdGhhbiAxMCBl
bWFpbHMgb24gbXkgc210cCBzZXJ2ZXLvvIEKCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDl
j5Hku7bkuro6IHdhbmd5dXF1YW4gPHdhbmd5dXF1YW4xMjM2QHBoeXRpdW0uY29tLmNuPgo+IOWP
kemAgeaXtumXtDoyMDI1LTA4LTA4IDE2OjI5OjU3ICjmmJ/mnJ/kupQpCj4g5pS25Lu25Lq6OiB0
YW5ndGFvMTYzNEBwaHl0aXVtLmNvbS5jbiwgcWVtdS1kZXZlbEBub25nbnUub3JnLCAiRmFuIE5p
IiA8ZmFuLm5pQHNhbXN1bmcuY29tPiwgIlBldGVyIE1heWRlbGwiIDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+LCBtc3RAcmVkaGF0LmNvbQo+IOaKhOmAgTogIkpvbmF0aGFuIENhbWVyb24iIDxK
b25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+LCBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnLCBs
aW51eGFybUBodWF3ZWkuY29tLCBxZW11LWFybUBub25nbnUub3JnLCAiWXVxdWFuIFdhbmciIDx3
YW5neXVxdWFuMTIzNkBwaHl0aXVtLmNvbS5jbj4sICJJdGFydSBLaXRheWFtYSIgPGl0YXJ1Lmtp
dGF5YW1hQGxpbnV4LmRldj4sICJQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSIgPHBoaWxtZEBsaW5h
cm8ub3JnPgo+IOS4u+mimDogW1BBVENIIHYxMyAxLzVdIGh3L2N4bC1ob3N0OiBBZGQgYW4gaW5k
ZXggZmllbGQgdG8gQ1hMRml4ZWRNZW1vcnlXaW5kb3cKPiAKPiBGcm9tOiBKb25hdGhhbiBDYW1l
cm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+Cj4gCj4gVG8gZW5hYmxlIHRoZXNlIHRv
IGJlIGZvdW5kIGluIGEgZml4ZWQgb3JkZXIsIHRoYXQgb3JkZXIgbmVlZHMKPiB0byBiZSBrbm93
bi4gIFRoaXMgd2lsbCBsYXRlciBiZSB1c2VkIHRvIHNvcnQgYSBsaXN0IG9mIHRoZXNlCj4gc3Ry
dWN0dXJlcyB0aGF0IGFkZHJlc3MgbWFwIGFuZCBBQ1BJIHRhYmxlIGVudHJpZXMgYXJlIHByZWRp
Y3RhYmxlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNh
bWVyb25AaHVhd2VpLmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9ody9jeGwvY3hsLmggfCAxICsKPiAg
aHcvY3hsL2N4bC1ob3N0LmMgICAgfCA5ICsrKysrKy0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy9jeGwvY3hsLmggYi9pbmNsdWRlL2h3L2N4bC9jeGwuaAo+IGluZGV4IDc1ZTQ3YjY4NjQuLmIy
YmNjZTdlZDYgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9ody9jeGwvY3hsLmgKPiArKysgYi9pbmNs
dWRlL2h3L2N4bC9jeGwuaAo+IEBAIC0yNyw2ICsyNyw3IEBACj4gIHR5cGVkZWYgc3RydWN0IFBY
QkNYTERldiBQWEJDWExEZXY7Cj4gIAo+ICB0eXBlZGVmIHN0cnVjdCBDWExGaXhlZFdpbmRvdyB7
Cj4gKyAgICBpbnQgaW5kZXg7Cj4gICAgICB1aW50NjRfdCBzaXplOwo+ICAgICAgY2hhciAqKnRh
cmdldHM7Cj4gICAgICBQWEJDWExEZXYgKnRhcmdldF9oYnNbMTZdOwo+IGRpZmYgLS1naXQgYS9o
dy9jeGwvY3hsLWhvc3QuYyBiL2h3L2N4bC9jeGwtaG9zdC5jCj4gaW5kZXggZTAxMDE2MzE3NC4u
YjdhYTQyOWRkZiAxMDA2NDQKPiAtLS0gYS9ody9jeGwvY3hsLWhvc3QuYwo+ICsrKyBiL2h3L2N4
bC9jeGwtaG9zdC5jCj4gQEAgLTI0LDEzICsyNCwxNSBAQAo+ICAKPiAgc3RhdGljIHZvaWQgY3hs
X2ZpeGVkX21lbW9yeV93aW5kb3dfY29uZmlnKENYTFN0YXRlICpjeGxfc3RhdGUsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDWExGaXhlZE1lbW9yeVdpbmRv
d09wdGlvbnMgKm9iamVjdCwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEVycm9yICoqZXJycCkKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGludCBpbmRleCwgRXJyb3IgKiplcnJwKQo+ICB7Cj4gICAgICBFUlJQX0dVQVJE
KCk7Cj4gICAgICBnX2F1dG9mcmVlIENYTEZpeGVkV2luZG93ICpmdyA9IGdfbWFsbG9jMChzaXpl
b2YoKmZ3KSk7Cj4gICAgICBzdHJMaXN0ICp0YXJnZXQ7Cj4gICAgICBpbnQgaTsKPiAgCj4gKyAg
ICBmdy0+aW5kZXggPSBpbmRleDsKPiArCj4gICAgICBmb3IgKHRhcmdldCA9IG9iamVjdC0+dGFy
Z2V0czsgdGFyZ2V0OyB0YXJnZXQgPSB0YXJnZXQtPm5leHQpIHsKPiAgICAgICAgICBmdy0+bnVt
X3RhcmdldHMrKzsKPiAgICAgIH0KPiBAQCAtMzI1LDE0ICszMjcsMTUgQEAgc3RhdGljIHZvaWQg
bWFjaGluZV9zZXRfY2ZtdyhPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFt
ZSwKPiAgICAgIENYTFN0YXRlICpzdGF0ZSA9IG9wYXF1ZTsKPiAgICAgIENYTEZpeGVkTWVtb3J5
V2luZG93T3B0aW9uc0xpc3QgKmNmbXdfbGlzdCA9IE5VTEw7Cj4gICAgICBDWExGaXhlZE1lbW9y
eVdpbmRvd09wdGlvbnNMaXN0ICppdDsKPiArICAgIGludCBpbmRleDsKPiAgCj4gICAgICB2aXNp
dF90eXBlX0NYTEZpeGVkTWVtb3J5V2luZG93T3B0aW9uc0xpc3QodiwgbmFtZSwgJmNmbXdfbGlz
dCwgZXJycCk7Cj4gICAgICBpZiAoIWNmbXdfbGlzdCkgewo+ICAgICAgICAgIHJldHVybjsKPiAg
ICAgIH0KPiAgCj4gLSAgICBmb3IgKGl0ID0gY2Ztd19saXN0OyBpdDsgaXQgPSBpdC0+bmV4dCkg
ewo+IC0gICAgICAgIGN4bF9maXhlZF9tZW1vcnlfd2luZG93X2NvbmZpZyhzdGF0ZSwgaXQtPnZh
bHVlLCBlcnJwKTsKPiArICAgIGZvciAoaXQgPSBjZm13X2xpc3QsIGluZGV4ID0gMDsgaXQ7IGl0
ID0gaXQtPm5leHQsIGluZGV4KyspIHsKPiArICAgICAgICBjeGxfZml4ZWRfbWVtb3J5X3dpbmRv
d19jb25maWcoc3RhdGUsIGl0LT52YWx1ZSwgaW5kZXgsIGVycnApOwo+ICAgICAgfQo+ICAgICAg
c3RhdGUtPmNmbXdfbGlzdCA9IGNmbXdfbGlzdDsKPiAgfQoNCg0K5L+h5oGv5a6J5YWo5aOw5piO
77ya5pys6YKu5Lu25YyF5ZCr5L+h5oGv5b2S5Y+R5Lu25Lq65omA5Zyo57uE57uH5omA5pyJLOWP
keS7tuS6uuaJgOWcqOe7hOe7h+WvueivpemCruS7tuaLpeacieaJgOacieadg+WIqeOAguivt+aO
peaUtuiAheazqOaEj+S/neWvhizmnKrnu4/lj5Hku7bkurrkuabpnaLorrjlj68s5LiN5b6X5ZCR
5Lu75L2V56ys5LiJ5pa557uE57uH5ZKM5Liq5Lq66YCP6Zyy5pys6YKu5Lu25omA5ZCr5L+h5oGv
44CCDQpJbmZvcm1hdGlvbiBTZWN1cml0eSBOb3RpY2U6IFRoZSBpbmZvcm1hdGlvbiBjb250YWlu
ZWQgaW4gdGhpcyBtYWlsIGlzIHNvbGVseSBwcm9wZXJ0eSBvZiB0aGUgc2VuZGVyJ3Mgb3JnYW5p
emF0aW9uLlRoaXMgbWFpbCBjb21tdW5pY2F0aW9uIGlzIGNvbmZpZGVudGlhbC5SZWNpcGllbnRz
IG5hbWVkIGFib3ZlIGFyZSBvYmxpZ2F0ZWQgdG8gbWFpbnRhaW4gc2VjcmVjeSBhbmQgYXJlIG5v
dCBwZXJtaXR0ZWQgdG8gZGlzY2xvc2UgdGhlIGNvbnRlbnRzIG9mIHRoaXMgY29tbXVuaWNhdGlv
biB0byBvdGhlcnMu


