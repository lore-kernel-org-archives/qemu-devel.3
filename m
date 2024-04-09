Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC2FC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru8u0-00058s-Nz; Tue, 09 Apr 2024 06:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1ru8tz-00058b-CO
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:40:31 -0400
Received: from m15.mail.163.com ([45.254.50.219])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <13824125580@163.com>) id 1ru8tv-0000Gr-AW
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=biFdX8d5ExHQkbz0M14xMG79jXxTXq5liZiHqCP73FI=; b=A
 whC4fbjgNUzUbe7DjE11BXbLM+2YMyUXVZyPwHp0xLbclvmAs4Bxx4ifkXHg1R2C
 C504WcBBaT/VP+sVwurAiDLTzrVaBWn3x5eYWs5ScVtPjbzgvzZuHvX7z9jz8vgH
 LT1DoPF8n2ATORR7e8o41Mxia+S1rLZKSuiC4clK58=
Received: from 13824125580$163.com ( [14.125.55.124] ) by
 ajax-webmail-wmsvr-40-121 (Coremail) ; Tue, 9 Apr 2024 18:40:13 +0800 (CST)
X-Originating-IP: [14.125.55.124]
Date: Tue, 9 Apr 2024 18:40:13 +0800 (CST)
From: tugouxp  <13824125580@163.com>
To: "Peter Maydell" <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re:Re: how does the qemu emulate the "atomic" semantics on host
 that DOES NOT support atomic instructions?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAFEAcA_KES78EcDe6G8hmOAGksxVnJS3K6CtnFzjQ05fPtqc_Q@mail.gmail.com>
References: <2484ebc6.e9b9.18ec24a8e9e.Coremail.13824125580@163.com>
 <CAFEAcA_KES78EcDe6G8hmOAGksxVnJS3K6CtnFzjQ05fPtqc_Q@mail.gmail.com>
X-NTES-SC: AL_Qu2aAPqetkoq5SmQYOkfm0sQjuY3UcOxvPsk245RO51wjArp8RAnb3tJF3z74s2KGSuHkxKdfRtu1v9Uf4BZToUlpHnGdQHC7Y3wf90tf4xEGw==
Content-Type: multipart/alternative; 
 boundary="----=_Part_230381_2011268207.1712659213990"
MIME-Version: 1.0
Message-ID: <41f35ede.f15e.18ec271aea7.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3vzYOGxVmh0UGAA--.35376W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiZRK7QmXAlDFjFAADs6
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=45.254.50.219; envelope-from=13824125580@163.com;
 helo=m15.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

------=_Part_230381_2011268207.1712659213990
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgcGV0ZXI7CiAgICBtdWNoLCBtdWNoIGFwcHJlY2lhdGUgeW91ciBleHBsYW5hdGlvbiEKPiAu
LmJ1dCB0aGUgaG9zdCBkb2Vzbid0IGhhdmUgb25lLCB3ZSBhcnJhbmdlIHRvIHBhdXNlIGV4ZWN1
dGlvbiBvZiBhbGwgdGhlIG90aGVyIGd1ZXN0IHZDUFUgdGhyZWFkcywKPT09PnllcywgaSBzb21l
aG93IGEgbGl0dGxlIGJpdCBvZiBndWVzcyBzdWNoIGxpa2UgdGhhdCwgYnV0IHdoZW4gdHJ5IHRv
IGZpbmQgc29tZSBjb2RlIGluIHFlbXUgdG8gcHJvdmUgdGhlIGd1ZXNzLCBpIGZvdW5kIGkgd2Fz
IGxvc3QgYW5kIGV4YXVzdGVkIGluIHRoZSBvY2VhbiBvZiB0aGUgY29kZSBhbmQgY29tcGxleCBs
b2dpYyBvZiBxZXVtdS4KYmVjYXVzZSBpbiBteSB0aG91Z3RoLCBpdCBtYXkgYmUgZG8gdGhlIHN5
bmMgaW4gdXNlciBwdGhyZWFkIGxldmVsLCBzbyBpIGdyZXAgdGhlICJwdGhyZWFkIiAibXV0ZXgi
LCAiY29uZHRpb24iLC4uLiBhbmQgc28gb24sIGJ1dCBkaWQgbm90IGZpbmQgYW55IHBvc2l0aW9u
IHRvIHByb3ZlIHRoaXMgdGhvdWdodC4Kc28sIGNhbiB5b3Ugb2ZmZXIgbWUgdGhlIGRlbW8gY29k
ZSBwb3NpdGlvbiBvZiBkbyB0aGUgc3luYyBsaWtlICJwYXVzZSBleGVjdXRpb24gb2YgYWxsIHRo
ZSBvdGhlciBndWVzdCB2Q1BVIHRocmVhZHMsIiwgdG8gbWFrZSB0aGUgYXRvbWljIG9wZXJhdGlv
bnMgbWVldCB0aGUgc2VtYXRpY3M/CnRoYW5rIHlvdSEKQlJzCnpsY2FvLgoKCgoKCkF0IDIwMjQt
MDQtMDkgMTg6MTA6NDIsICJQZXRlciBNYXlkZWxsIiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
PiB3cm90ZToKPk9uIFR1ZSwgOSBBcHIgMjAyNCBhdCAxMDo1OCwgdHVnb3V4cCA8MTM4MjQxMjU1
ODBAMTYzLmNvbT4gd3JvdGU6Cj4+ICAgIEhvdyBkb2VzIHRoZSBxZW11IGVtdWxhdGUgdGhlIHRh
cmdldCB0aGF0IHN1cHBvcnQgImF0b21pYyIgSVNBLCBzdWNoIGFzIHJpc2N2ICJhbW8iIGluc3Ry
dWN0aW9uIG9uIGhvc3QgbWFjaGluZSB0aGF0IGRvZXMgTk9UIHN1cHBvcnQgYXRvbWljICBpbnN0
cnVjdGlvbnMgPwo+PiBpcyB0aGlzIHNjZW5hcmlvIGhhcHBlbmRzPwo+Cj5BbGwgaG9zdHMgdGhh
dCBjYW4gcnVuIFFFTVUgc3VwcG9ydCBhdCBsZWFzdCBzb21lIGF0b21pYyBpbnN0cnVjdGlvbnMu
Cj5XaGVyZSBwb3NzaWJsZSB3ZSB1c2UgdGhlIGhvc3QgYXRvbWljIG9wZXJhdGlvbnMgdG8gcHJv
dmlkZSB0aGUKPm5lY2Vzc2FyeSBhdG9taWNpdHkgZ3VhcmFudGVlcyB0aGF0IGEgZ3Vlc3QgaW5z
dHJ1Y3Rpb24gbXVzdCBoYXZlLgo+Rm9yIGNhc2VzIHdoZXJlIHdlIGNhbid0IGRvIHRoYXQgKGVn
IHdoZXJlIHRoZSBndWVzdCBuZWVkcyBhbiBhdG9taWMKPjE2LWJ5dGUgc3RvcmUgYnV0IHRoZSBo
b3N0IGRvZXNuJ3QgaGF2ZSBvbmUpLCB3ZSBhcnJhbmdlIHRvIHBhdXNlCj5leGVjdXRpb24gb2Yg
YWxsIHRoZSBvdGhlciBndWVzdCB2Q1BVIHRocmVhZHMsIGRvIHRoZSB0aGluZyB0aGF0IG11c3QK
PmJlIGF0b21pYywgYW5kIHRoZW4gbGV0IGV2ZXJ5dGhpbmcgcmVzdW1lLgo+Cj50aGFua3MKPi0t
IFBNTQo=
------=_Part_230381_2011268207.1712659213990
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPkhpIHBldGVyOzwvZGl2
PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPiZuYnNwOyAmbmJzcDsgbXVjaCwgbXVjaCBhcHByZWNp
YXRlIHlvdXIgZXhwbGFuYXRpb24hPC9kaXY+PHByZT48c3BhbiBzdHlsZT0iYmFja2dyb3VuZC1j
b2xvcjogcmdiKDIyMSwgNjQsIDUwKTsiPiZndDsgLi5idXQgdGhlIGhvc3QgZG9lc24ndCBoYXZl
IG9uZSwgd2UgYXJyYW5nZSB0byBwYXVzZSBleGVjdXRpb24gb2YgYWxsIHRoZSBvdGhlciBndWVz
dCB2Q1BVIHRocmVhZHMsPC9zcGFuPjwvcHJlPjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPj09PSZn
dDs8c3BhbiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogcmdiKDExOSwgMjAxLCA3NSk7Ij55ZXM8
L3NwYW4+LCBpIHNvbWVob3cgYSBsaXR0bGUgYml0IG9mIGd1ZXNzIHN1Y2ggbGlrZSB0aGF0LCBi
dXQgd2hlbiB0cnkgdG8gZmluZCBzb21lIGNvZGUgaW4gcWVtdSB0byBwcm92ZSB0aGUgZ3Vlc3Ms
IGkgZm91bmQgaSB3YXMgbG9zdCBhbmQgZXhhdXN0ZWQgaW4gdGhlIG9jZWFuIG9mIHRoZSBjb2Rl
IGFuZCBjb21wbGV4IGxvZ2ljIG9mIHFldW11LjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsi
PmJlY2F1c2UgaW4gbXkgdGhvdWd0aCwgaXQgbWF5IGJlIGRvIHRoZSBzeW5jIGluIHVzZXIgcHRo
cmVhZCBsZXZlbCwgc28gaSBncmVwIHRoZSAicHRocmVhZCIgIm11dGV4IiwgImNvbmR0aW9uIiwu
Li4gYW5kIHNvIG9uLCBidXQgZGlkIG5vdCBmaW5kIGFueSBwb3NpdGlvbiB0byBwcm92ZSB0aGlz
IHRob3VnaHQuPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOiAwOyI+c28sIGNhbiB5b3Ugb2ZmZXIg
bWUgdGhlIGRlbW8gY29kZSBwb3NpdGlvbiBvZiBkbyB0aGUgc3luYyBsaWtlIDxzcGFuIHN0eWxl
PSJjb2xvcjogcmdiKDIyMSwgNjQsIDUwKTsgYmFja2dyb3VuZC1jb2xvcjogcmdiKDI1NSwgMjU1
LCAyNTUpOyI+IjxzcGFuIHN0eWxlPSJjb2xvcjogcmdiKDIyMSwgNjQsIDUwKTsgYmFja2dyb3Vu
ZC1jb2xvcjogcmdiKDI1NSwgMjU1LCAyNTUpOyBmb250LWZhbWlseTogYXJpYWw7IHdoaXRlLXNw
YWNlLWNvbGxhcHNlOiBwcmVzZXJ2ZTsiPjxiPnBhdXNlIGV4ZWN1dGlvbiBvZiBhbGwgdGhlIG90
aGVyIGd1ZXN0IHZDUFUgdGhyZWFkczwvYj4sIiwgdG8gbWFrZSB0aGUgYXRvbWljIG9wZXJhdGlv
bnMgbWVldCB0aGUgc2VtYXRpY3M/IDwvc3Bhbj48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0ibWFy
Z2luOiAwOyI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBhcmlhbDsgd2hpdGUtc3BhY2UtY29s
bGFwc2U6IHByZXNlcnZlOyBiYWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7IGNv
bG9yOiByZ2IoNjMsIDY1LCA2NCk7Ij50aGFuayB5b3UhPC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9
Im1hcmdpbjogMDsiPjxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUs
IDI1NSk7IGZvbnQtZmFtaWx5OiBhcmlhbDsgd2hpdGUtc3BhY2UtY29sbGFwc2U6IHByZXNlcnZl
OyBjb2xvcjogcmdiKDYzLCA2NSwgNjQpOyI+QlJzPC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9Im1h
cmdpbjogMDsiPjxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1
NSk7IGZvbnQtZmFtaWx5OiBhcmlhbDsgd2hpdGUtc3BhY2UtY29sbGFwc2U6IHByZXNlcnZlOyBj
b2xvcjogcmdiKDYzLCA2NSwgNjQpOyI+emxjYW8uPC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9InBv
c2l0aW9uOnJlbGF0aXZlO3pvb206MSI+PC9kaXY+PGRpdiBpZD0iZGl2TmV0ZWFzZU1haWxDYXJk
Ij48L2Rpdj48cCBzdHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvcD48cHJlPjxicj5BdCAyMDI0LTA0
LTA5IDE4OjEwOjQyLCAiUGV0ZXIgTWF5ZGVsbCIgJmx0O3BldGVyLm1heWRlbGxAbGluYXJvLm9y
ZyZndDsgd3JvdGU6CiZndDtPbiBUdWUsIDkgQXByIDIwMjQgYXQgMTA6NTgsIHR1Z291eHAgJmx0
OzEzODI0MTI1NTgwQDE2My5jb20mZ3Q7IHdyb3RlOgomZ3Q7Jmd0OyAgICBIb3cgZG9lcyB0aGUg
cWVtdSBlbXVsYXRlIHRoZSB0YXJnZXQgdGhhdCBzdXBwb3J0ICJhdG9taWMiIElTQSwgc3VjaCBh
cyByaXNjdiAiYW1vIiBpbnN0cnVjdGlvbiBvbiBob3N0IG1hY2hpbmUgdGhhdCBkb2VzIE5PVCBz
dXBwb3J0IGF0b21pYyAgaW5zdHJ1Y3Rpb25zID8KJmd0OyZndDsgaXMgdGhpcyBzY2VuYXJpbyBo
YXBwZW5kcz8KJmd0OwomZ3Q7QWxsIGhvc3RzIHRoYXQgY2FuIHJ1biBRRU1VIHN1cHBvcnQgYXQg
bGVhc3Qgc29tZSBhdG9taWMgaW5zdHJ1Y3Rpb25zLgomZ3Q7V2hlcmUgcG9zc2libGUgd2UgdXNl
IHRoZSBob3N0IGF0b21pYyBvcGVyYXRpb25zIHRvIHByb3ZpZGUgdGhlCiZndDtuZWNlc3Nhcnkg
YXRvbWljaXR5IGd1YXJhbnRlZXMgdGhhdCBhIGd1ZXN0IGluc3RydWN0aW9uIG11c3QgaGF2ZS4K
Jmd0O0ZvciBjYXNlcyB3aGVyZSB3ZSBjYW4ndCBkbyB0aGF0IChlZyB3aGVyZSB0aGUgZ3Vlc3Qg
bmVlZHMgYW4gYXRvbWljCiZndDsxNi1ieXRlIHN0b3JlIGJ1dCB0aGUgaG9zdCBkb2Vzbid0IGhh
dmUgb25lKSwgd2UgYXJyYW5nZSB0byBwYXVzZQomZ3Q7ZXhlY3V0aW9uIG9mIGFsbCB0aGUgb3Ro
ZXIgZ3Vlc3QgdkNQVSB0aHJlYWRzLCBkbyB0aGUgdGhpbmcgdGhhdCBtdXN0CiZndDtiZSBhdG9t
aWMsIGFuZCB0aGVuIGxldCBldmVyeXRoaW5nIHJlc3VtZS4KJmd0OwomZ3Q7dGhhbmtzCiZndDst
LSBQTU0KPC9wcmU+PC9kaXY+
------=_Part_230381_2011268207.1712659213990--


