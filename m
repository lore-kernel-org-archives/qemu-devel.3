Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF5CC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLffU-0005wD-KJ; Mon, 24 Jun 2024 05:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1sLffR-0005vs-VB
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:07:17 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <13824125580@163.com>) id 1sLffJ-0003Bx-6a
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=FaJbYp7rwDr/XEkK+m7zOUMZGneLFtk9ENGp4ZBAAQI=; b=i
 52M5C0wqoKPWrJq6/ms4obxe09HwV8lXtzErvgsHViTCfy7pMcufW2hQpy5aI1ci
 qppKkg2Imq4oRhxanNcr55raB2b7UG+sBfzOkQGNsTQxujgsp1hKgk26qELGd83l
 42TUmvDjPdZZzbzD4DFrLNE3z3/JMRbcHo9iMN6h6s=
Received: from 13824125580$163.com ( [14.125.52.91] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Mon, 24 Jun 2024 17:06:51 +0800
 (CST)
X-Originating-IP: [14.125.52.91]
Date: Mon, 24 Jun 2024 17:06:51 +0800 (CST)
From: tugouxp  <13824125580@163.com>
To: =?GBK?Q?Alex_Benn=A8=A6e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re:Re: Did the "TCG" emulation mode has a full capability compare
 with the "KVM" emulation mode?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <877ceera4b.fsf@draig.linaro.org>
References: <62981bf0.8f16.190495cbb92.Coremail.13824125580@163.com>
 <877ceera4b.fsf@draig.linaro.org>
X-NTES-SC: AL_Qu2aC/6Zv0gq5ymbZ+kfm0sQjuY3UcOxvPsk245RO51wjDjpxRAqTERlLFnbyvKtLQmFjT6xTBtQ4+Jcf7RZco4NXN7bzGCE4+bXINvA3vq3qg==
Content-Type: multipart/alternative; 
 boundary="----=_Part_147772_940375834.1719220011937"
MIME-Version: 1.0
Message-ID: <75d15b4b.9cee.190497f83a1.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3P+EsN3lmNuwEAA--.7117W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/xtbBchAIQmWXvyvvuAABsY
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=117.135.210.3; envelope-from=13824125580@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001, FROM_LOCAL_HEX=0.006,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_BL=0.01, RCVD_IN_MSPIKE_L4=1.7, SPF_HELO_NONE=0.001,
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

------=_Part_147772_940375834.1719220011937
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

VGhhbmsgeW91IQoKQlRXLCBUQ0cgYWxzbyBoYXMgdHdvIGJhY2tlbmRzIGltcGxlbWVudGlvbiwg
MS4gTmF0aXZlIGhvc3QgYXJjaCB0cmFubGF0aW9uLiBhbmQgMi4gVENJIGJ5dGUgY29kZSBpbnRl
cnByZXRlci4gVGhlIGRpZmZlcmVuY2UgaXMgdGhhdCB0aGUgZmlyc3Qgb25lIHdpbGwgdHJhbmxh
dGlvbiB0aGUgdGFyZ2V0IGFyY2ggY29kZSB0byBob3N0IGFyY2ggaW5zdHJ0aW9ucyBhbmQgdGhl
biBleGVjdXRlZCBpbiBob3N0IGNwdS4gYnV0IHRoZSBsYXR0ZXIgaXMgYSBoaWdoIGxldmVsIGlu
dGVycGVyYXRpb24uIGNvbXBhcmUgdGhlc2UgdHdvIGJhY2tlbmRzLCBBcmUgdGhlcmUgYW55IGNh
cGFiaWxpdHkgZGlmZmVyZW5jZSBvbiB0aGUgc3lzdGVtIGVtdWxhdGlvbiBhYm91dCB0aGUgdHdv
IGJhY2tlbmRzPyB0aGFuayB5b3UuCgoKCgoKCgoKCgoKCgoKCgoKQXQgMjAyNC0wNi0yNCAxNjo1
Nzo0MCwgIkFsZXggQmVubqimZSIgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+IHdyb3RlOgo+dHVn
b3V4cCA8MTM4MjQxMjU1ODBAMTYzLmNvbT4gd3JpdGVzOgo+Cj4+IEhlbGxvIGZvbGtzOgo+PiAg
ICBJIGhhdmUgYSBwdXp6bGUgb24gcWVtdSBtYWpvciB0d28gZW11YXRpb24gaW1wbGVudGlvbnMg
b24gd2hvbGUgc3lzdGVtIGVtdWxhdGlvbiwgdGhhdCBpcyAsZXhjZXB0IHRoZSBlbXVhdGlvbiBz
cGVlZCwKPj4gZGlkIHRoZSBUQ0cgd29yayBtb2RlIGhhcyBhbnkgd2Vha25lc3MgdGhhbiAiS1ZN
IiB3b3JrIG1vZGUgb24gd2hvbGUgc3lzdGVtIGVtdWxhdGlvbnMoaW5jbHVkaW5nIGtlcm5layBh
bmQKPj4gdXNlci1zcGFjZSk/Cj4KPkl0IGRlcGVuZHMgb24gdGhlIGd1ZXN0IGFyY2hpdGVjdHVy
ZS4gU29tZSBhcmUgbW9yZSBjb21wbGV0ZSB0aGFuCj5vdGhlcnMuIFRoZSB4ODYgZW11bGF0aW9u
IGZvciBleGFtcGxlIGRvZXNuJ3QgY292ZXIgYWxsIHRoZSBtb2Rlcm4geDg2Cj5leHRlbnNpb25z
IGFsdGhvdWdoIHRoZXJlIGhhdmUgYmVlbiBzb21lIGltcHJvdmVtZW50cyB0byBpdHMgdmVjdG9y
Cj5oYW5kbGluZyByZWNlbnRseS4KPgo+T25lIHRoaW5nIFRDRyBjYW4gZG8gdGhhdCBLVk0gY2Fu
J3QgaXMgZW11bGF0ZSBjb2RlIHJ1bm5pbmcgYXQgaGlnaGVyCj5wcmlvcml0eSB0aGFuIGtlcm5l
bC1tb2RlLiBGb3IgZXhhbXBsZSBmb3IgQVJNIHdlIGNhbiBlbXVsYXRlIHRoZQo+RUwzL1Jvb3Qg
ZG9tYWluIGFuZCBzZWN1cmUgYW5kIGNvbmZpZGVudGlhbCByZWFsbXMuIEluIEtWTSB5b3UgY2Fu
IG9ubHkKPnJ1biBhIGd1ZXN0IEVMMSBrZXJuZWwgYW5kIGl0cyB1c2VyIHNwYWNlLgo+Cj4+IGlz
IHRoZXJlIGFueSB3b3JrIHRoYXQga3ZtIGNhbiBkbyBidXQgVENHIGNhbnQ/IAo+Pgo+PiBvZiBj
b3Vyc2Uga3ZtIGlzIG11Y2ggZmFzdGVyIHRoYW4gVENHLCBidXQgbXkgcXVlc3Rpb24ganVzdCBh
Ym91dCB0aGUgZnVudGlvbiwgbm90IGNhcmUgYWJvdXQgc3BlZWQuCj4+Cj4+IHRoYW5rcyBmb3Ig
eW91ciBraW5kbHkgaGVscCEKPj4gQlJzCj4+IHppbG9uZy4KPgo+LS0gCj5BbGV4IEJlbm6opmUK
PlZpcnR1YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybwo=
------=_Part_147772_940375834.1719220011937
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgaWQ9InNwbkVkaXRvckNvbnRlbnQiPjxwIHN0eWxlPSJt
YXJnaW46IDA7Ij5UaGFuayB5b3UhPC9wPjxwIHN0eWxlPSJtYXJnaW46IDA7Ij5CVFcsIFRDRyBh
bHNvIGhhcyB0d28gYmFja2VuZHMgaW1wbGVtZW50aW9uLCAxLiBOYXRpdmUgaG9zdCBhcmNoIHRy
YW5sYXRpb24uIGFuZCAyLiBUQ0kgYnl0ZSBjb2RlIGludGVycHJldGVyLiBUaGUgZGlmZmVyZW5j
ZSBpcyB0aGF0IHRoZSBmaXJzdCBvbmUgd2lsbCB0cmFubGF0aW9uIHRoZSB0YXJnZXQgYXJjaCBj
b2RlIHRvIGhvc3QgYXJjaCBpbnN0cnRpb25zIGFuZCB0aGVuIGV4ZWN1dGVkIGluIGhvc3QgY3B1
LiBidXQgdGhlIGxhdHRlciBpcyBhIGhpZ2ggbGV2ZWwgaW50ZXJwZXJhdGlvbi4gY29tcGFyZSB0
aGVzZSB0d28gYmFja2VuZHM8Yj4sIEFyZSB0aGVyZSBhbnkgY2FwYWJpbGl0eSBkaWZmZXJlbmNl
IG9uIHRoZSBzeXN0ZW0gZW11bGF0aW9uIGFib3V0IHRoZSB0d28gYmFja2VuZHM/IHRoYW5rIHlv
dS48L2I+PC9wPjxwIHN0eWxlPSJtYXJnaW46IDA7Ij48YnI+PC9wPjxwIHN0eWxlPSJtYXJnaW46
IDA7Ij48YnI+PC9wPjxwIHN0eWxlPSJtYXJnaW46IDA7Ij48YnI+PC9wPjxwIHN0eWxlPSJtYXJn
aW46IDA7Ij48YnI+PC9wPjwvZGl2PjxkaXYgc3R5bGU9InBvc2l0aW9uOnJlbGF0aXZlO3pvb206
MSI+PC9kaXY+PGRpdiBpZD0iZGl2TmV0ZWFzZU1haWxDYXJkIj48L2Rpdj48cCBzdHlsZT0ibWFy
Z2luOiAwOyI+PGJyPjwvcD48cHJlPjxicj5BdCAyMDI0LTA2LTI0IDE2OjU3OjQwLCAiQWxleCBC
ZW5uqKZlIiAmbHQ7YWxleC5iZW5uZWVAbGluYXJvLm9yZyZndDsgd3JvdGU6CiZndDt0dWdvdXhw
ICZsdDsxMzgyNDEyNTU4MEAxNjMuY29tJmd0OyB3cml0ZXM6CiZndDsKJmd0OyZndDsgSGVsbG8g
Zm9sa3M6CiZndDsmZ3Q7ICAgIEkgaGF2ZSBhIHB1enpsZSBvbiBxZW11IG1ham9yIHR3byBlbXVh
dGlvbiBpbXBsZW50aW9ucyBvbiB3aG9sZSBzeXN0ZW0gZW11bGF0aW9uLCB0aGF0IGlzICxleGNl
cHQgdGhlIGVtdWF0aW9uIHNwZWVkLAomZ3Q7Jmd0OyBkaWQgdGhlIFRDRyB3b3JrIG1vZGUgaGFz
IGFueSB3ZWFrbmVzcyB0aGFuICJLVk0iIHdvcmsgbW9kZSBvbiB3aG9sZSBzeXN0ZW0gZW11bGF0
aW9ucyhpbmNsdWRpbmcga2VybmVrIGFuZAomZ3Q7Jmd0OyB1c2VyLXNwYWNlKT8KJmd0OwomZ3Q7
SXQgZGVwZW5kcyBvbiB0aGUgZ3Vlc3QgYXJjaGl0ZWN0dXJlLiBTb21lIGFyZSBtb3JlIGNvbXBs
ZXRlIHRoYW4KJmd0O290aGVycy4gVGhlIHg4NiBlbXVsYXRpb24gZm9yIGV4YW1wbGUgZG9lc24n
dCBjb3ZlciBhbGwgdGhlIG1vZGVybiB4ODYKJmd0O2V4dGVuc2lvbnMgYWx0aG91Z2ggdGhlcmUg
aGF2ZSBiZWVuIHNvbWUgaW1wcm92ZW1lbnRzIHRvIGl0cyB2ZWN0b3IKJmd0O2hhbmRsaW5nIHJl
Y2VudGx5LgomZ3Q7CiZndDtPbmUgdGhpbmcgVENHIGNhbiBkbyB0aGF0IEtWTSBjYW4ndCBpcyBl
bXVsYXRlIGNvZGUgcnVubmluZyBhdCBoaWdoZXIKJmd0O3ByaW9yaXR5IHRoYW4ga2VybmVsLW1v
ZGUuIEZvciBleGFtcGxlIGZvciBBUk0gd2UgY2FuIGVtdWxhdGUgdGhlCiZndDtFTDMvUm9vdCBk
b21haW4gYW5kIHNlY3VyZSBhbmQgY29uZmlkZW50aWFsIHJlYWxtcy4gSW4gS1ZNIHlvdSBjYW4g
b25seQomZ3Q7cnVuIGEgZ3Vlc3QgRUwxIGtlcm5lbCBhbmQgaXRzIHVzZXIgc3BhY2UuCiZndDsK
Jmd0OyZndDsgaXMgdGhlcmUgYW55IHdvcmsgdGhhdCBrdm0gY2FuIGRvIGJ1dCBUQ0cgY2FudD8g
CiZndDsmZ3Q7CiZndDsmZ3Q7IG9mIGNvdXJzZSBrdm0gaXMgbXVjaCBmYXN0ZXIgdGhhbiBUQ0cs
IGJ1dCBteSBxdWVzdGlvbiBqdXN0IGFib3V0IHRoZSBmdW50aW9uLCBub3QgY2FyZSBhYm91dCBz
cGVlZC4KJmd0OyZndDsKJmd0OyZndDsgdGhhbmtzIGZvciB5b3VyIGtpbmRseSBoZWxwIQomZ3Q7
Jmd0OyBCUnMKJmd0OyZndDsgemlsb25nLgomZ3Q7CiZndDstLSAKJmd0O0FsZXggQmVubqimZQom
Z3Q7VmlydHVhbGlzYXRpb24gVGVjaCBMZWFkIEAgTGluYXJvCjwvcHJlPjwvZGl2Pg==
------=_Part_147772_940375834.1719220011937--


