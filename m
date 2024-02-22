Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CB9C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8XZ-0004nt-NM; Thu, 22 Feb 2024 07:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bobby825@126.com>)
 id 1rd8XW-0004nH-Vn; Thu, 22 Feb 2024 07:51:03 -0500
Received: from m15.mail.126.com ([45.254.50.223])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bobby825@126.com>)
 id 1rd8XR-0004A4-Tj; Thu, 22 Feb 2024 07:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=smRy1MP2eycJYBYQb0xq5luxN8HH2rHLlR0MgIbH3Ko=; b=U
 B9eF6EoMVUOb1wIJTJFtpXvb/VvpriMF/LeEowxTnDWFYljr7JVOZGNQcXiZ3SDg
 f1cpNI7ERwOvShy9A2Y6Eaci2/w5zmowSoDfMEr7BY8ksdxocJmDMUWeK7upITHB
 T+oD1+l3iA4gUeY09//Uo6juvwaVa2JuhMTi1BMtzg=
Received: from bobby825$126.com ( [101.88.177.236] ) by
 ajax-webmail-wmsvr-41-110 (Coremail) ; Thu, 22 Feb 2024 20:50:47 +0800
 (CST)
X-Originating-IP: [101.88.177.236]
Date: Thu, 22 Feb 2024 20:50:47 +0800 (CST)
From: "Tianlan Zhou" <bobby825@126.com>
To: "Tianlan Zhou" <bobby825@126.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: "Michael Tokarev" <mjt@tls.msk.ru>, qemu-trivial <qemu-trivial@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 2/2] system/vl: Update description for input grab key
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
In-Reply-To: <20240221195208.462-3-bobby825@126.com>
References: <20240221195208.462-1-bobby825@126.com>
 <20240221195208.462-3-bobby825@126.com>
X-NTES-SC: AL_Qu2bCvqbuUov4SScY+kXm0gQgek7W8Gxvv0n2Y5VO5E0qS7k1w0CV1V6EVDZ3/uRGjqPmjKeXR5C1OpHeaNFWLrg01FyXGf/fxPZ2tHxwsNh
Content-Type: multipart/alternative; 
 boundary="----=_Part_107071_1155737227.1708606247450"
MIME-Version: 1.0
Message-ID: <71778fef.7272.18dd0de521a.Coremail.bobby825@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3_28nQ9dlF6shAA--.5926W
X-CM-SenderInfo: xereu5qysvqiyswou0bp/1tbiWRiMUmVLY4ZeKgAEsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=45.254.50.223; envelope-from=bobby825@126.com;
 helo=m15.mail.126.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

------=_Part_107071_1155737227.1708606247450
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

Q2MgcWVtdS1zdGFibGUsIGFzIHRoaXMgd2lsbCBmaXggdGhlIGBxZW11LXN5c3RlbS14eHggLWhg
IGhlbHAgbWVzc2FnZS4KCgpPbiAyMDI0LzIvMjIgMzo1MiwgVGlhbmxhbiBaaG91IHdyb3RlOgo+
IElucHV0IGdyYWIga2V5IHNob3VsZCBiZSBDdHJsLUFsdC1nLCBub3QganVzdCBDdHJsLUFsdC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBUaWFubGFuIFpob3UgPGJvYmJ5ODI1QDEyNi5jb20+Cj4gLS0t
Cj4gIHN5c3RlbS92bC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvc3lzdGVtL3ZsLmMgYi9zeXN0ZW0vdmwu
Ywo+IGluZGV4IGE4MjU1NWFlMTUuLmI4NDY5ZDk5NjUgMTAwNjQ0Cj4gLS0tIGEvc3lzdGVtL3Zs
LmMKPiArKysgYi9zeXN0ZW0vdmwuYwo+IEBAIC04OTEsNyArODkxLDcgQEAgc3RhdGljIHZvaWQg
aGVscChpbnQgZXhpdGNvZGUpCj4gICAgICBwcmludGYoIlxuRHVyaW5nIGVtdWxhdGlvbiwgdGhl
IGZvbGxvd2luZyBrZXlzIGFyZSB1c2VmdWw6XG4iCj4gICAgICAgICAgICAgImN0cmwtYWx0LWYg
ICAgICB0b2dnbGUgZnVsbCBzY3JlZW5cbiIKPiAgICAgICAgICAgICAiY3RybC1hbHQtbiAgICAg
IHN3aXRjaCB0byB2aXJ0dWFsIGNvbnNvbGUgJ24nXG4iCj4gLSAgICAgICAgICAgImN0cmwtYWx0
ICAgICAgICB0b2dnbGUgbW91c2UgYW5kIGtleWJvYXJkIGdyYWJcbiIKPiArICAgICAgICAgICAi
Y3RybC1hbHQtZyAgICAgIHRvZ2dsZSBtb3VzZSBhbmQga2V5Ym9hcmQgZ3JhYlxuIgo+ICAgICAg
ICAgICAgICJcbiIKPiAgICAgICAgICAgICAiV2hlbiB1c2luZyAtbm9ncmFwaGljLCBwcmVzcyAn
Y3RybC1hIGgnIHRvIGdldCBzb21lIGhlbHAuXG4iCj4gICAgICAgICAgICAgIlxuIgo+IC0tIAo+
IDIuMzguMS53aW5kb3dzLjE=
------=_Part_107071_1155737227.1708606247450
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPkNjIHFlbXUtc3RhYmxl
LCBhcyB0aGlzIHdpbGwgZml4IHRoZSAgYHFlbXUtc3lzdGVtLXh4eCAtaGAgaGVscCBtZXNzYWdl
LjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTog
YXJpYWw7IHdoaXRlLXNwYWNlLWNvbGxhcHNlOiBwcmVzZXJ2ZTsiPjxicj48L3NwYW4+PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOiAwOyI+T24gMjAyNC8yLzIyIDM6NTIsIFRpYW5sYW4gWmhvdSB3
cm90ZTo8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij48ZGl2IHN0eWxlPSJtYXJnaW46IDA7
Ij4mZ3Q7IElucHV0IGdyYWIga2V5IHNob3VsZCBiZSBDdHJsLUFsdC1nLCBub3QganVzdCBDdHJs
LUFsdC48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij4mZ3Q7Jm5ic3A7PC9kaXY+PGRpdiBz
dHlsZT0ibWFyZ2luOiAwOyI+Jmd0OyBTaWduZWQtb2ZmLWJ5OiBUaWFubGFuIFpob3UgJmx0O2Jv
YmJ5ODI1QDEyNi5jb20mZ3Q7PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOiAwOyI+Jmd0OyAtLS08
L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij4mZ3Q7Jm5ic3A7IHN5c3RlbS92bC5jIHwgMiAr
LTwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPiZndDsmbmJzcDsgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOiAw
OyI+Jmd0OyZuYnNwOzwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPiZndDsgZGlmZiAtLWdp
dCBhL3N5c3RlbS92bC5jIGIvc3lzdGVtL3ZsLmM8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7
Ij4mZ3Q7IGluZGV4IGE4MjU1NWFlMTUuLmI4NDY5ZDk5NjUgMTAwNjQ0PC9kaXY+PGRpdiBzdHls
ZT0ibWFyZ2luOiAwOyI+Jmd0OyAtLS0gYS9zeXN0ZW0vdmwuYzwvZGl2PjxkaXYgc3R5bGU9Im1h
cmdpbjogMDsiPiZndDsgKysrIGIvc3lzdGVtL3ZsLmM8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46
IDA7Ij4mZ3Q7IEBAIC04OTEsNyArODkxLDcgQEAgc3RhdGljIHZvaWQgaGVscChpbnQgZXhpdGNv
ZGUpPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOiAwOyI+Jmd0OyZuYnNwOyAmbmJzcDsgJm5ic3A7
IHByaW50ZigiXG5EdXJpbmcgZW11bGF0aW9uLCB0aGUgZm9sbG93aW5nIGtleXMgYXJlIHVzZWZ1
bDpcbiI8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij4mZ3Q7Jm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ImN0cmwtYWx0LWYmbmJzcDsgJm5ic3A7ICZu
YnNwOyB0b2dnbGUgZnVsbCBzY3JlZW5cbiI8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij4m
Z3Q7Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ImN0cmwt
YWx0LW4mbmJzcDsgJm5ic3A7ICZuYnNwOyBzd2l0Y2ggdG8gdmlydHVhbCBjb25zb2xlICduJ1xu
IjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPiZndDsgLSZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ImN0cmwtYWx0Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
IHRvZ2dsZSBtb3VzZSBhbmQga2V5Ym9hcmQgZ3JhYlxuIjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdp
bjogMDsiPiZndDsgKyZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ImN0
cmwtYWx0LWcmbmJzcDsgJm5ic3A7ICZuYnNwOyB0b2dnbGUgbW91c2UgYW5kIGtleWJvYXJkIGdy
YWJcbiI8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij4mZ3Q7Jm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IlxuIjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdp
bjogMDsiPiZndDsmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsiV2hlbiB1c2luZyAtbm9ncmFwaGljLCBwcmVzcyAnY3RybC1hIGgnIHRvIGdldCBzb21lIGhl
bHAuXG4iPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOiAwOyI+Jmd0OyZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyJcbiI8L2Rpdj48ZGl2IHN0eWxlPSJtYXJn
aW46IDA7Ij4mZ3Q7IC0tJm5ic3A7PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOiAwOyI+Jmd0OyAy
LjM4LjEud2luZG93cy4xPC9kaXY+PC9kaXY+PC9kaXY+
------=_Part_107071_1155737227.1708606247450--


