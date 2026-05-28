Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5DCCD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZec-0005Wf-5n; Thu, 28 May 2026 08:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wSZeZ-0005WG-Kj
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:15:59 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wSZeT-0006Kd-4f
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=6pm61MUc6RCE2OPopc+VagxlQGCVQkZJK1tZiGlGxck=; b=p
 6jGDTMWuF6oLBW6fmpYWRzIsRrPcRaeP41OCKd9pVRIedqbiLBK5WLqKfAW7NKYY
 6WSe1JwEqFmJ1LLYIPlttfNzwrSO7zZUrOWGbVo6apduE3URZNyjg6W7VJe0P8nW
 AiTMHPNCIH/2oJqp1zwsvsM25CmY0H4yEMEfiIJKUQ=
Received: from alanosong$163.com ( [59.173.202.83] ) by
 ajax-webmail-wmsvr-40-119 (Coremail) ; Thu, 28 May 2026 20:12:18 +0800
 (CST)
X-Originating-IP: [59.173.202.83]
Date: Thu, 28 May 2026 20:12:18 +0800 (CST)
From: "Alano Song" <alanosong@163.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, pbonzini@redhat.com, zhao1.liu@intel.com
Subject: Re:[PATCH] target/i386/monitor: Refine `info tlb` command logic
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260524124129.174254-1-AlanoSong@163.com>
References: <20260524124129.174254-1-AlanoSong@163.com>
X-NTES-SC: AL_Qu2cC/Wcv0so7iSaZ+kcm0wQgOk5XsCwu/wk3YNec/8EvTj/8QcGeUViF0nawO+XLxiOuiOZQTpUzuhlUq11i9lciS/LujS6me+R18vrmg==
Content-Type: multipart/alternative; 
 boundary="----=_Part_142023_1803991991.1779970338432"
MIME-Version: 1.0
Message-ID: <56debb66.9386.19e6e7fee81.Coremail.alanosong@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dygvCgD3n9QiMRhqj2KtAA--.19672W
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9gL0CWoYMSJflgAA3h
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.5; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

------=_Part_142023_1803991991.1779970338432
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

CgpBdCAyMDI2LTA1LTI0IDIwOjQxOjI5LCBBbGFub1NvbmdAMTYzLmNvbSB3cm90ZToKPldoZW4g
Ym9vdGluZyBhbiBpMzg2IGd1ZXN0LCB0aGUgYGluZm8gdGxiYCBjb21tYW5kCj5tYXkgd2FsayB0
aGUgZW50aXJlIHBhZ2UgdGFibGUgaGllcmFyY2h5IGFuZCBlbWl0Cj5hbiBlbm9ybW91cyBhbW91
bnQgb2Ygb3V0cHV0IChhcyBtYW55IGFzIDgwMCsgbWlsbGlvbgo+ZW50cmllcyB1bmRlciBteSB0
ZXN0KS4KPkl0IHdpbGwgdGFrZSBkb3plbnMgb2YgbWludXRlcyB0byBwcmludCBhbGwgdGhlIGlu
Zm8sCj5iZWNhdXNlIGVhY2ggbW9uaXRvciBwcmludCBmdW5jdGlvbiB3aWxsIGhvbGRzICdtb25f
bG9jaycuCj5UaGlzIGVmZmVjdGl2ZWx5IGhhbmdzIHRoZSBxZW11IG1vbml0b3IsIGFuZCBldmVu
IGxlYWRpbmcKPnRvIHByb2dyYW0gZXhpdCBkdWUgdG8gdGltZW91dC4KPgo+U28gaXQgbWF5IGJl
IGJldHRlciB0byBzaG93IG9ubHkgdGhlIGZpcnN0IDMyIGVudHJpZXMKPmFuZCB0aGUgbGFzdCBl
bnRyeSBieSBkZWZhdWx0Lgo+Cj5BbmQgaWYgZnVsbCBvdXRwdXQgaXMgcmVxdWlyZWQsIHRoZSB1
c2VyIGNhbiByZWRpcmVjdAo+dGhlIG91dHB1dCB0byBhIGZpbGUgYnkgc3BlY2lmeWluZyBhIGZp
bGUgbmFtZSwgZS5nLjoKPmBpbmZvIHRsYiB4eHgudHh0YC4KPgo+U2lnbmVkLW9mZi1ieTogQWxh
bm8gU29uZyA8QWxhbm9Tb25nQDE2My5jb20+Cj4tLS0KPiBobXAtY29tbWFuZHMtaW5mby5oeCAg
fCAgMTAgKy0KPiB0YXJnZXQvaTM4Ni9tb25pdG9yLmMgfCAyMzAgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tCj4gMiBmaWxlcyBjaGFuZ2VkLCAxOTUgaW5zZXJ0aW9u
cygrKSwgNDUgZGVsZXRpb25zKC0pCj4KCgpQaW5nIGZvciBjb2RlIHJldmlldyA6KQoKCkJlc3Qg
UmVnYXJkcywKQWxhbm8uCgo=
------=_Part_142023_1803991991.1779970338432
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PGRpdiBz
dHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvZGl2PjxwcmU+QXQgMjAyNi0wNS0yNCAyMDo0MToyOSwg
QWxhbm9Tb25nQDE2My5jb20gd3JvdGU6CiZndDtXaGVuIGJvb3RpbmcgYW4gaTM4NiBndWVzdCwg
dGhlIGBpbmZvIHRsYmAgY29tbWFuZAomZ3Q7bWF5IHdhbGsgdGhlIGVudGlyZSBwYWdlIHRhYmxl
IGhpZXJhcmNoeSBhbmQgZW1pdAomZ3Q7YW4gZW5vcm1vdXMgYW1vdW50IG9mIG91dHB1dCAoYXMg
bWFueSBhcyA4MDArIG1pbGxpb24KJmd0O2VudHJpZXMgdW5kZXIgbXkgdGVzdCkuCiZndDtJdCB3
aWxsIHRha2UgZG96ZW5zIG9mIG1pbnV0ZXMgdG8gcHJpbnQgYWxsIHRoZSBpbmZvLAomZ3Q7YmVj
YXVzZSBlYWNoIG1vbml0b3IgcHJpbnQgZnVuY3Rpb24gd2lsbCBob2xkcyAnbW9uX2xvY2snLgom
Z3Q7VGhpcyBlZmZlY3RpdmVseSBoYW5ncyB0aGUgcWVtdSBtb25pdG9yLCBhbmQgZXZlbiBsZWFk
aW5nCiZndDt0byBwcm9ncmFtIGV4aXQgZHVlIHRvIHRpbWVvdXQuCiZndDsKJmd0O1NvIGl0IG1h
eSBiZSBiZXR0ZXIgdG8gc2hvdyBvbmx5IHRoZSBmaXJzdCAzMiBlbnRyaWVzCiZndDthbmQgdGhl
IGxhc3QgZW50cnkgYnkgZGVmYXVsdC4KJmd0OwomZ3Q7QW5kIGlmIGZ1bGwgb3V0cHV0IGlzIHJl
cXVpcmVkLCB0aGUgdXNlciBjYW4gcmVkaXJlY3QKJmd0O3RoZSBvdXRwdXQgdG8gYSBmaWxlIGJ5
IHNwZWNpZnlpbmcgYSBmaWxlIG5hbWUsIGUuZy46CiZndDtgaW5mbyB0bGIgeHh4LnR4dGAuCiZn
dDsKJmd0O1NpZ25lZC1vZmYtYnk6IEFsYW5vIFNvbmcgJmx0O0FsYW5vU29uZ0AxNjMuY29tJmd0
OwomZ3Q7LS0tCiZndDsgaG1wLWNvbW1hbmRzLWluZm8uaHggIHwgIDEwICstCiZndDsgdGFyZ2V0
L2kzODYvbW9uaXRvci5jIHwgMjMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLQomZ3Q7IDIgZmlsZXMgY2hhbmdlZCwgMTk1IGluc2VydGlvbnMoKyksIDQ1IGRlbGV0
aW9ucygtKQomZ3Q7PC9wcmU+PGRpdj48YnI+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1m
YW1pbHk6IG1vbm9zcGFjZTsiPlBpbmcgZm9yIGNvZGUgcmV2aWV3IDopPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2U7Ij48YnI+PC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2U7Ij5CZXN0IFJlZ2FyZHMs
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2U7Ij5B
bGFuby48L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+
------=_Part_142023_1803991991.1779970338432--


