Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E90BCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9EK-0007Yx-6A; Tue, 09 Apr 2024 07:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1ru9Dy-0007Ig-8v
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:01:15 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <13824125580@163.com>) id 1ru9Du-0003wJ-6x
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=fIPxAr14GE7W8yr9125oYmqa1jwmSE5YsgDjBARVjPw=; b=M
 MAJxGT6p2NO7ajbglOn+psC9B//7x+umnBSx1f+wBQTGgwFVqcZYY17FDk7EwHZK
 o9imOGgnIWQsWJbsILl9LSIA04splsYjnXBDpxmmrRFtcv7DVJeH1d+KqPMwRj+w
 V8f1glyJBgCHWibKLuLJL65UYg1uHg+mRCKhxFx08M=
Received: from 13824125580$163.com ( [14.125.55.124] ) by
 ajax-webmail-wmsvr-40-121 (Coremail) ; Tue, 9 Apr 2024 19:00:50 +0800 (CST)
X-Originating-IP: [14.125.55.124]
Date: Tue, 9 Apr 2024 19:00:50 +0800 (CST)
From: tugouxp  <13824125580@163.com>
To: "Peter Maydell" <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re:Re: Re: how does the qemu emulate the "atomic" semantics on host
 that DOES NOT support atomic instructions?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAFEAcA8o3sEW3S3=D_nNA9qrmjm0zZNoheXTgQqEv4RTt10JnQ@mail.gmail.com>
References: <2484ebc6.e9b9.18ec24a8e9e.Coremail.13824125580@163.com>
 <CAFEAcA_KES78EcDe6G8hmOAGksxVnJS3K6CtnFzjQ05fPtqc_Q@mail.gmail.com>
 <41f35ede.f15e.18ec271aea7.Coremail.13824125580@163.com>
 <CAFEAcA8o3sEW3S3=D_nNA9qrmjm0zZNoheXTgQqEv4RTt10JnQ@mail.gmail.com>
X-NTES-SC: AL_Qu2aAPqdv0wu5iWQYukfm0sQjuY3UcOxvPsk245RO51wjArp8RAnb3tJF3z74s2KGSuHkxKdfRtu1v9Uf4BZToUlo//aIPrP7lzy9VW7td6wXQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_233019_99417156.1712660450592"
MIME-Version: 1.0
Message-ID: <5f4b0e4f.f41c.18ec2848d21.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3XwrjHxVmXy4MAA--.34082W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiYwq7QmV4HpZGOgAEs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.3; envelope-from=13824125580@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

------=_Part_233019_99417156.1712660450592
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgcGV0ZXI6Cmkgc2VlLCBtdWNoLCBtdWNoIGhlbHBmdWxsLiB0aGFuayB5b3UhIDopLgoKCgoK
CkF0IDIwMjQtMDQtMDkgMTg6NTE6MjYsICJQZXRlciBNYXlkZWxsIiA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPiB3cm90ZToKPk9uIFR1ZSwgOSBBcHIgMjAyNCBhdCAxMTo0MCwgdHVnb3V4cCA8
MTM4MjQxMjU1ODBAMTYzLmNvbT4gd3JvdGU6Cj4+ID09PT55ZXMsIGkgc29tZWhvdyBhIGxpdHRs
ZSBiaXQgb2YgZ3Vlc3Mgc3VjaCBsaWtlIHRoYXQsIGJ1dCB3aGVuIHRyeSB0byBmaW5kIHNvbWUg
Y29kZSBpbiBxZW11IHRvIHByb3ZlIHRoZSBndWVzcywgaSBmb3VuZCBpIHdhcyBsb3N0IGFuZCBl
eGF1c3RlZCBpbiB0aGUgb2NlYW4gb2YgdGhlIGNvZGUgYW5kIGNvbXBsZXggbG9naWMgb2YgcWV1
bXUuCj4+IGJlY2F1c2UgaW4gbXkgdGhvdWd0aCwgaXQgbWF5IGJlIGRvIHRoZSBzeW5jIGluIHVz
ZXIgcHRocmVhZCBsZXZlbCwgc28gaSBncmVwIHRoZSAicHRocmVhZCIgIm11dGV4IiwgImNvbmR0
aW9uIiwuLi4gYW5kIHNvIG9uLCBidXQgZGlkIG5vdCBmaW5kIGFueSBwb3NpdGlvbiB0byBwcm92
ZSB0aGlzIHRob3VnaHQuCj4+IHNvLCBjYW4geW91IG9mZmVyIG1lIHRoZSBkZW1vIGNvZGUgcG9z
aXRpb24gb2YgZG8gdGhlIHN5bmMgbGlrZSAicGF1c2UgZXhlY3V0aW9uIG9mIGFsbCB0aGUgb3Ro
ZXIgZ3Vlc3QgdkNQVSB0aHJlYWRzLCIsIHRvIG1ha2UgdGhlIGF0b21pYyBvcGVyYXRpb25zIG1l
ZXQgdGhlIHNlbWF0aWNzPwo+Cj5JIHdvdWxkIHN1Z2dlc3Qgc3RhcnRpbmcgYnkgdHJhbnNsYXRp
bmcgc29tZSBndWVzdCBjb2RlCj53aXRoIHRoZSBhdG9taWMgb3BlcmF0aW9uIHlvdSdyZSBpbnRl
cmVzdGVkIGluLCBhbmQgdXNpbmcKPnRoZSAnLWQnIHN1Ym9wdGlvbnMgaW5fYXNtLCBvcCBhbmQg
b3V0X2FzbSB0byBsb29rIGF0IHRoZQo+Z2VuZXJhdGVkIFRDRyBvcGVyYXRpb25zIGFuZCB0aGUg
Z2VuZXJhdGVkIGhvc3QgY29kZSBmb3IgaXQuCj4KPlRoZSBzdG9wLXRoZS13b3JsZCBoYW5kbGlu
ZyBoYXBwZW5zIHdoZW4gc29tZXRoaW5nIGNhbGxzCj5jcHVfbG9vcF9leGl0X2F0b21pYygpLCB3
aGljaCB0aGVuIHJhaXNlcyBhbiBFWENQX0FUT01JQwo+aW50ZXJuYWwtdG8tUUVNVSBleGNlcHRp
b24sIHdoaWNoIGlzIGhhbmRsZWQgYnkgc29tZQo+dG9wLWxldmVsLWxvb3AgY29kZSB0aGF0IGNh
bGxzIGNwdV9leGVjX3N0ZXBfYXRvbWljKCksCj53aGljaCAoYSkgdXNlcyBzdGFydF9leGNsdXNp
dmUoKSBhbmQgZW5kX2V4Y2x1c2l2ZSgpIHRvCj5lbnN1cmUgdGhhdCBpdCBpcyB0aGUgb25seSB2
Y3B1IHJ1bm5pbmcgYW5kIChiKSBnZW5lcmF0ZXMKPm5ldyBob3N0IGNvZGUgd2l0aCB0aGUgQ0Zf
UEFSQUxMRUwgZmxhZyBjbGVhciB0byB0ZWxsCj50aGUgdHJhbnNsYXRvciB0aGF0IGl0IGNhbiBh
c3N1bWUgaXQncyB0aGUgb25seSB0aGluZwo+cnVubmluZyAod2hpY2ggaW4gdHVybiBtZWFucyAi
eW91IGRvbid0IG5lZWQgdG8gYWN0dWFsbHkKPmRvIHRoaXMgb3BlcmF0aW9uIGF0b21pY2FsbHki
KS4KPgo+dGhhbmtzCj4tLSBQTU0K
------=_Part_233019_99417156.1712660450592
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPkhpIHBldGVyOjwvZGl2
PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPmkgc2VlLCBtdWNoLCBtdWNoIGhlbHBmdWxsLiB0aGFu
ayB5b3UhIDopLjwvZGl2PjxwIHN0eWxlPSJtYXJnaW46IDA7Ij48YnI+PC9wPjxwcmU+PGJyPkF0
IDIwMjQtMDQtMDkgMTg6NTE6MjYsICJQZXRlciBNYXlkZWxsIiAmbHQ7cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnJmd0OyB3cm90ZToKJmd0O09uIFR1ZSwgOSBBcHIgMjAyNCBhdCAxMTo0MCwgdHVn
b3V4cCAmbHQ7MTM4MjQxMjU1ODBAMTYzLmNvbSZndDsgd3JvdGU6CiZndDsmZ3Q7ID09PSZndDt5
ZXMsIGkgc29tZWhvdyBhIGxpdHRsZSBiaXQgb2YgZ3Vlc3Mgc3VjaCBsaWtlIHRoYXQsIGJ1dCB3
aGVuIHRyeSB0byBmaW5kIHNvbWUgY29kZSBpbiBxZW11IHRvIHByb3ZlIHRoZSBndWVzcywgaSBm
b3VuZCBpIHdhcyBsb3N0IGFuZCBleGF1c3RlZCBpbiB0aGUgb2NlYW4gb2YgdGhlIGNvZGUgYW5k
IGNvbXBsZXggbG9naWMgb2YgcWV1bXUuCiZndDsmZ3Q7IGJlY2F1c2UgaW4gbXkgdGhvdWd0aCwg
aXQgbWF5IGJlIGRvIHRoZSBzeW5jIGluIHVzZXIgcHRocmVhZCBsZXZlbCwgc28gaSBncmVwIHRo
ZSAicHRocmVhZCIgIm11dGV4IiwgImNvbmR0aW9uIiwuLi4gYW5kIHNvIG9uLCBidXQgZGlkIG5v
dCBmaW5kIGFueSBwb3NpdGlvbiB0byBwcm92ZSB0aGlzIHRob3VnaHQuCiZndDsmZ3Q7IHNvLCBj
YW4geW91IG9mZmVyIG1lIHRoZSBkZW1vIGNvZGUgcG9zaXRpb24gb2YgZG8gdGhlIHN5bmMgbGlr
ZSAicGF1c2UgZXhlY3V0aW9uIG9mIGFsbCB0aGUgb3RoZXIgZ3Vlc3QgdkNQVSB0aHJlYWRzLCIs
IHRvIG1ha2UgdGhlIGF0b21pYyBvcGVyYXRpb25zIG1lZXQgdGhlIHNlbWF0aWNzPwomZ3Q7CiZn
dDtJIHdvdWxkIHN1Z2dlc3Qgc3RhcnRpbmcgYnkgdHJhbnNsYXRpbmcgc29tZSBndWVzdCBjb2Rl
CiZndDt3aXRoIHRoZSBhdG9taWMgb3BlcmF0aW9uIHlvdSdyZSBpbnRlcmVzdGVkIGluLCBhbmQg
dXNpbmcKJmd0O3RoZSAnLWQnIHN1Ym9wdGlvbnMgaW5fYXNtLCBvcCBhbmQgb3V0X2FzbSB0byBs
b29rIGF0IHRoZQomZ3Q7Z2VuZXJhdGVkIFRDRyBvcGVyYXRpb25zIGFuZCB0aGUgZ2VuZXJhdGVk
IGhvc3QgY29kZSBmb3IgaXQuCiZndDsKJmd0O1RoZSBzdG9wLXRoZS13b3JsZCBoYW5kbGluZyBo
YXBwZW5zIHdoZW4gc29tZXRoaW5nIGNhbGxzCiZndDtjcHVfbG9vcF9leGl0X2F0b21pYygpLCB3
aGljaCB0aGVuIHJhaXNlcyBhbiBFWENQX0FUT01JQwomZ3Q7aW50ZXJuYWwtdG8tUUVNVSBleGNl
cHRpb24sIHdoaWNoIGlzIGhhbmRsZWQgYnkgc29tZQomZ3Q7dG9wLWxldmVsLWxvb3AgY29kZSB0
aGF0IGNhbGxzIGNwdV9leGVjX3N0ZXBfYXRvbWljKCksCiZndDt3aGljaCAoYSkgdXNlcyBzdGFy
dF9leGNsdXNpdmUoKSBhbmQgZW5kX2V4Y2x1c2l2ZSgpIHRvCiZndDtlbnN1cmUgdGhhdCBpdCBp
cyB0aGUgb25seSB2Y3B1IHJ1bm5pbmcgYW5kIChiKSBnZW5lcmF0ZXMKJmd0O25ldyBob3N0IGNv
ZGUgd2l0aCB0aGUgQ0ZfUEFSQUxMRUwgZmxhZyBjbGVhciB0byB0ZWxsCiZndDt0aGUgdHJhbnNs
YXRvciB0aGF0IGl0IGNhbiBhc3N1bWUgaXQncyB0aGUgb25seSB0aGluZwomZ3Q7cnVubmluZyAo
d2hpY2ggaW4gdHVybiBtZWFucyAieW91IGRvbid0IG5lZWQgdG8gYWN0dWFsbHkKJmd0O2RvIHRo
aXMgb3BlcmF0aW9uIGF0b21pY2FsbHkiKS4KJmd0OwomZ3Q7dGhhbmtzCiZndDstLSBQTU0KPC9w
cmU+PC9kaXY+
------=_Part_233019_99417156.1712660450592--


