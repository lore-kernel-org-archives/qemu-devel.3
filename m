Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC75CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmtV-0008SM-Kn; Mon, 20 Oct 2025 06:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1vAmtM-0008Rx-MQ; Mon, 20 Oct 2025 06:13:29 -0400
Received: from forward502a.mail.yandex.net ([2a02:6b8:c0e:500:1:45:d181:d502])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1vAmtI-0004v9-A5; Mon, 20 Oct 2025 06:13:28 -0400
Received: from mail-nwsmtp-mxback-production-main-76.vla.yp-c.yandex.net
 (mail-nwsmtp-mxback-production-main-76.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2d0f:0:640:dcb0:0])
 by forward502a.mail.yandex.net (Yandex) with ESMTPS id 3E76E81313;
 Mon, 20 Oct 2025 13:13:12 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c0f:1287:0:640:2a3:0
 [2a02:6b8:c0f:1287:0:640:2a3:0])
 by mail-nwsmtp-mxback-production-main-76.vla.yp-c.yandex.net (mxback/Yandex)
 with HTTPS id 9DS41UO6t8c0-ynn1WO9q; Mon, 20 Oct 2025 13:13:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1760955191; bh=rjPcyK3uJnamug1xhj/lza9FjVvqqsMNdIBMI/dmbH8=;
 h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
 b=Hz8vvjdQp3NTCWjLbalUaTx3HabnsAQ0w5X9b2JPXXCv+H4VCxPYISvDolMeM8YY5
 ZtUSewmguu6BcR1FQSOFEpk3QdnGfm0BCQBAdVT0FoQYnpogUwjJOZ4R+Yak4A3TxQ
 BWimh0kOQ+IOLrN2k6vmorUmqqiRMUHcnBWsPVoI=
Authentication-Results: mail-nwsmtp-mxback-production-main-76.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by mail-sendbernar-production-main-76.vla.yp-c.yandex.net
 (sendbernar/Yandex) with HTTPS id 3388c48144ec92f578da1c922b97d26a; 
 Mon, 20 Oct 2025 13:13:10 +0300
From: =?utf-8?B?0JbQtdCx0YDRj9C60L7QsiDQlNCw0L3QuNC70LA=?=
 <d.zhebryakov@yandex.ru>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
In-Reply-To: <20250915124650.435777-1-d.zhebryakov@yandex.ru>
References: <20250915124650.435777-1-d.zhebryakov@yandex.ru>
Subject: Re: [PATCH v3 0/4] Add support for PowerPC e500 little-endian pages
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 20 Oct 2025 13:13:10 +0300
Message-Id: <67151760955134@mail.yandex.ru>
Content-Transfer-Encoding: base64
Content-Type: text/html; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:d502;
 envelope-from=d.zhebryakov@yandex.ru; helo=forward502a.mail.yandex.net
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

PGRpdj5QaW5nICgyKSDCoDxhIGhyZWY9Imh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNTA5MDMxMzQxNDYuMTQ4Nzc5NC0xLWQuemhlYnJ5YWtvdkB5YW5kZXgucnUvIiByZWw9
Im5vb3BlbmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzIwMjUwOTAzMTM0MTQ2LjE0ODc3OTQtMS1kLnpoZWJyeWFrb3ZAeWFu
ZGV4LnJ1LzwvYT48L2Rpdj48ZGl2PsKgPC9kaXY+PGRpdj4tLS0tLS0tLS0tLS0tLS0tPC9kaXY+
PGRpdj7QmtC+0LzRgzogcWVtdS1kZXZlbEBub25nbnUub3JnIChxZW11LWRldmVsQG5vbmdudS5v
cmcpOzwvZGl2PjxkaXY+0JrQvtC/0LjRjzogUmlrdSBWb2lwaW8gKHJpa3Uudm9pcGlvQGlraS5m
aSksIElseWEgTGVvc2hrZXZpY2ggKGlpaUBsaW51eC5pYm0uY29tKSwgTGF1cmVudCBWaXZpZXIg
KGxhdXJlbnRAdml2aWVyLmV1KSwgQ2hpbm1heSBSYXRoIChyYXRoY0BsaW51eC5pYm0uY29tKSwg
UmljaGFyZCBIZW5kZXJzb24gKHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcpLCBEYXZpZCBI
aWxkZW5icmFuZCAoZGF2aWRAcmVkaGF0LmNvbSksIFRob21hcyBIdXRoICh0aHV0aEByZWRoYXQu
Y29tKSwgcWVtdS1zMzkweEBub25nbnUub3JnLCBQYW9sbyBCb256aW5pIChwYm9uemluaUByZWRo
YXQuY29tKSwgTmljaG9sYXMgUGlnZ2luIChucGlnZ2luQGdtYWlsLmNvbSksIHFlbXUtcHBjQG5v
bmdudS5vcmc7PC9kaXY+PGRpdj7QotC10LzQsDogW1BBVENIIHYzIDAvNF0gQWRkIHN1cHBvcnQg
Zm9yIFBvd2VyUEMgZTUwMCBsaXR0bGUtZW5kaWFuIHBhZ2VzOzwvZGl2PjxkaXY+MTUuMDkuMjAy
NSwgMTU6NDYsICJEYW5pbGEgWmhlYnJ5YWtvdiIgJmx0O2QuemhlYnJ5YWtvdkB5YW5kZXgucnUm
Z3Q7OjwvZGl2PjxibG9ja3F1b3RlPjxwPlRoZXNlIGNoYW5nZXMgbWFrZSBwb3dlcnBjIGJvb2tl
MjA2IG1tdSBwYXNzIFRMQl9CU1dBUCBmbGFnIGZvciBwYWdlcyBtYXJrZWQgYXMgTEUsIGFuZCBh
bHNvIGZpeGVzIGFsbCB0aGUgaXNzdWVzIHRoaXMgY2F1c2VzLjxiciAvPsKgLSBhZGRlZCBUTEJf
QlNXQVAgdG8gbm9uLU1NSU8gZmxhZ3M8YnIgLz7CoC0gaW5zZXJ0ZWQgYWRkaXRpb25hbCBjaGVj
ayBmb3IgTEUgcGFnZSB3aGVuIGJzd2FwLWluZyBpbnN0cnVjdGlvbnM8YnIgLz7CoC0gcmVtb3Zl
ZCBhc3NlcnQgZm9yIGNyb3NzLXBhZ2UgVExCX0JTV0FQIGFjY2Vzc2VzPGJyIC8+wqAtIGFkZGVk
IGdkYnN0dWIgZml4IHRvIGFjY291bnQgZm9yIFRMQl9CU1dBUCBvZiB0aGUgY3VycmVudGx5IHJ1
bm5pbmcgY29kZTxiciAvPjxiciAvPkJFLSBhbmQgTEUtIGF0b21pYyBvcGVyYXRpb25zICh1c2Vk
IGJ5IGxvYWQtYW5kLXJlc2VydmUgYW5kIHN0b3JlLWNvbmRpdGlvbmFsIGluc3RydWN0aW9ucykg
d2VyZSB1bmlmaWVkIHRvIHN1cHBvcnQgVExCX0JTV0FQPGJyIC8+PGJyIC8+U29tZSBvZiB0aGUg
Zml4ZXMgYXJlIGJhc2VkIG9uIHdoYXQgaXMgZG9uZSBpbiA8YSBocmVmPSJodHRwczovL2dpdGh1
Yi5jb20vWWV0QW5vdGhlck1vZC9xZW11IiByZWw9Im5vb3BlbmVyIG5vcmVmZXJyZXIiPmh0dHBz
Oi8vZ2l0aHViLmNvbS9ZZXRBbm90aGVyTW9kL3FlbXU8L2E+PGJyIC8+PGJyIC8+VjI6PGJyIC8+
wqAtIFJlbW92ZWQgdXNhZ2Ugb2YgUEFHRV9VU0VSIGJpdCBmb3IgTEUgKGNvbW1lbnQgb24gcHJl
dmlvdXMgdmVyc2lvbik8YnIgLz7CoC0gUmVmYWN0b3JlZCBNTVUgY29kZSBzbyBkaXJlY3RseSBz
ZXR0aW5nIFRMQl9CU1dBUCBpcyBwb3NzaWJsZTxiciAvPsKgLSBtb3ZlZCB0cmFuc2xhdGlvbiBM
RSBwYWdlIGRldGVjdCB0byBvY2N1ciAxIHRpbWUgcGVyIHRyYW5zbGF0aW9uIChjb21tZW50IG9u
IHByZXZpb3VzIHZlcnNpb24pPGJyIC8+wqAtIFJlbW92ZWQgcmVkdW5kYW50IGFzc2VydCBpbiBh
dG9taWNfbW11X2xvb2t1cCAoY29tbWVudCBvbiBwcmV2aW91cyB2ZXJzaW9uKTxiciAvPsKgLSBB
ZGRlZCBhc3NlcnQgb24gY3Jvc3MtZW5kaWFuIGFjY2Vzc2VzIChpZGVhbGx5LCB0aGVyZSBzaG91
bGQgYmUgYW4gZXhjZXB0aW9uKTxiciAvPsKgLSBDaGFuZ2VkIGF0b21pYyBuZWVkX2Jzd2FwIGhh
bmRsaW5nIChjb21tZW50IG9uIHByZXZpb3VzIHZlcnNpb24pPGJyIC8+wqAtIFJlYmFzZWQgYW5k
IGZpeGVkIGF0b21pY3M8YnIgLz48YnIgLz5WMzxiciAvPsKgLSB1bmZpeCBhc3N1bWVkIHR5cG8g
KGlmIHZzIGlmZikuIEV2ZXJ5dGhpbmcgZWxzZSB1bmNoYW5nZWQ8YnIgLz48YnIgLz5BY2NvcmRp
bmcgdG8gUk0sIHVuYWxpZ25lZCBhY2Nlc3NlcyBiZXR3ZWVuIExFIGFuZCBCRSBwYWdlcyBzaG91
bGQgY2F1c2UgYW4gZXhjZXB0aW9uIG9uIGU1MDAuPGJyIC8+SG93ZXZlciwgKGFzIEkgdW5kZXJz
dGFuZCBpdCkgc3VwcG9ydGluZyB0aGlzIHdvdWxkIHJlcXVpcmUgYWRkaW5nIGEgbmV3IGNhbGxi
YWNrIHRvIFRDR0NQVU9wcywgbGlrZWx5IGp1c3QgZm9yIEU1MDAgb3IgbWF5YmUgYSBjb3VwbGUg
b3RoZXIgQ1BVcyBkb2luZyB0aGlzLjxiciAvPlN1Y2ggYWNjZXNzZXMgYXJlIGNsZWFybHkgbm90
IG5vcm1hbCBhbmQgdXN1YWxseSBkb24ndCBvY2N1ciBpbiByZWFsIGFwcGxpY2F0aW9ucywgc28g
SSB0aGluayBqdXN0IHBsYWNpbmcgYXNzZXJ0IGlzIE9LIGhlcmUuPGJyIC8+PGJyIC8+RGFuaWxh
IFpoZWJyeWFrb3YgKDQpOjxiciAvPsKgwqBhY2NlbC90Y2c6IFVuaWZ5IGJpZy0gYW5kIGxpdHRs
ZS0gZW5kaWFuIGF0b21pYyBvcHM8YnIgLz7CoMKgdGFyZ2V0L3BwYzogcmVmYWN0b3IgTU1VIGhl
bHBlcnM8YnIgLz7CoMKgdGFyZ2V0L3BwYzogQWRkIHN1cHBvcnQgZm9yIExFIHBhZ2VzIG9uIFBv
d2VyUEMgYm9va2UyMDYgbW11PGJyIC8+wqDCoHRhcmdldC9wcGM6IGZpeCBHREIgc3R1YiB0byB3
b3JrIGNvcnJlY3RseSB3aXRoIExFIHBhZ2VzPGJyIC8+PGJyIC8+wqBhY2NlbC90Y2cvYXRvbWlj
X2NvbW1vbi5jLmluYyB8IDM2ICstLTxiciAvPsKgYWNjZWwvdGNnL2F0b21pY190ZW1wbGF0ZS5o
IHwgMzI2ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS08YnIgLz7CoGFjY2VsL3RjZy9jcHV0
bGIuYyB8IDI5ICsrLTxiciAvPsKgYWNjZWwvdGNnL3RjZy1ydW50aW1lLmggfCA0OCArLS0tPGJy
IC8+wqBhY2NlbC90Y2cvdXNlci1leGVjLmMgfCAyICstPGJyIC8+wqBpbmNsdWRlL2FjY2VsL3Rj
Zy9jcHUtbGRzdC1jb21tb24uaCB8IDUxICsrLS0tPGJyIC8+wqB0YXJnZXQvbTY4ay9vcF9oZWxw
ZXIuYyB8IDQgKy08YnIgLz7CoHRhcmdldC9wcGMvZ2Ric3R1Yi5jIHwgMTcgKy08YnIgLz7CoHRh
cmdldC9wcGMvaW50ZXJuYWwuaCB8IDMgKy08YnIgLz7CoHRhcmdldC9wcGMvbW11LWJvb2tlLmMg
fCA2NyArKystLS08YnIgLz7CoHRhcmdldC9wcGMvbW11LWJvb2tlLmggfCAyICstPGJyIC8+wqB0
YXJnZXQvcHBjL21tdS1oYXNoMzIuYyB8IDMwICstLTxiciAvPsKgdGFyZ2V0L3BwYy9tbXUtaGFz
aDMyLmggfCAzICstPGJyIC8+wqB0YXJnZXQvcHBjL21tdS1oYXNoNjQuYyB8IDE0ICstPGJyIC8+
wqB0YXJnZXQvcHBjL21tdS1oYXNoNjQuaCB8IDIgKy08YnIgLz7CoHRhcmdldC9wcGMvbW11LXJh
ZGl4NjQuYyB8IDIwICstPGJyIC8+wqB0YXJnZXQvcHBjL21tdS1yYWRpeDY0LmggfCAyICstPGJy
IC8+wqB0YXJnZXQvcHBjL21tdV9jb21tb24uYyB8IDc1ICsrKystLS08YnIgLz7CoHRhcmdldC9w
cGMvbW11X2hlbHBlci5jIHwgMTUgKy08YnIgLz7CoHRhcmdldC9wcGMvdHJhbnNsYXRlLmMgfCA0
MiArKystPGJyIC8+wqB0YXJnZXQvczM5MHgvdGNnL21lbV9oZWxwZXIuYyB8IDYgKy08YnIgLz7C
oHRjZy90Y2ctb3AtbGRzdC5jIHwgNDMgKystLTxiciAvPsKgMjIgZmlsZXMgY2hhbmdlZCwgMzcw
IGluc2VydGlvbnMoKyksIDQ2NyBkZWxldGlvbnMoLSk8YnIgLz7CoDwvcD4tLTxiciAvPjIuNDcu
MjxiciAvPsKgPC9ibG9ja3F1b3RlPg==

