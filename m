Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F601CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5iZC-00036R-UP; Mon, 06 Oct 2025 06:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1v5iZ6-00036B-Iz; Mon, 06 Oct 2025 06:35:36 -0400
Received: from forward502d.mail.yandex.net ([178.154.239.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1v5iZ2-0000m7-2x; Mon, 06 Oct 2025 06:35:36 -0400
Received: from mail-nwsmtp-mxback-production-main-87.klg.yp-c.yandex.net
 (mail-nwsmtp-mxback-production-main-87.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:21a5:0:640:c759:0])
 by forward502d.mail.yandex.net (Yandex) with ESMTPS id 22C3AC0917;
 Mon, 06 Oct 2025 13:35:23 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c42:26cc:0:640:9e82:0
 [2a02:6b8:c42:26cc:0:640:9e82:0])
 by mail-nwsmtp-mxback-production-main-87.klg.yp-c.yandex.net (mxback/Yandex)
 with HTTPS id JZhNs671kmI0-wYV3y8TD; Mon, 06 Oct 2025 13:35:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1759746922; bh=6JxHa/9bVvUwZrL9Bxvk12xBIzzn7HllP9NEdtSfRbc=;
 h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
 b=qv3PxLChCqiXHU75JmJRK94j5Z2aPon8HPZYPHLq5L0DjDwdDbA1SxFk3ZP7Nezid
 6q8s+rX6MYL15JpMITdasYaOsvHt+Byq1sw02yobr0Bh0cHI48CYxkXcKw/L/br77u
 Dk5yKE/r0Eer21oUiKfO7mB6PV4aD2DeRuCVgLF0=
Authentication-Results: mail-nwsmtp-mxback-production-main-87.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by mail-sendbernar-production-main-44.klg.yp-c.yandex.net
 (sendbernar/Yandex) with HTTPS id 18a6bb5c87a9269501119880b4f667ae; 
 Mon, 06 Oct 2025 13:35:21 +0300
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
In-Reply-To: <20250915124650.435777-5-d.zhebryakov@yandex.ru>
References: <20250915124650.435777-1-d.zhebryakov@yandex.ru>
 <20250915124650.435777-5-d.zhebryakov@yandex.ru>
Subject: Re: [PATCH v3 4/4] target/ppc: fix GDB stub to work correctly with LE
 pages
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 06 Oct 2025 13:35:21 +0300
Message-Id: <103431759746895@mail.yandex.ru>
Content-Transfer-Encoding: base64
Content-Type: text/html; charset=utf-8
Received-SPF: pass client-ip=178.154.239.210;
 envelope-from=d.zhebryakov@yandex.ru; helo=forward502d.mail.yandex.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

PGRpdj5QaW5nIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTA5MDMxMzQx
NDYuMTQ4Nzc5NC0xLWQuemhlYnJ5YWtvdkB5YW5kZXgucnUvPC9kaXY+PGRpdj7CoDwvZGl2Pjxk
aXY+LS0tLS0tLS0tLS0tLS0tLTwvZGl2PjxkaXY+0JrQvtC80YM6IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZyAocWVtdS1kZXZlbEBub25nbnUub3JnKTs8L2Rpdj48ZGl2PtCa0L7Qv9C40Y86IFJpa3Ug
Vm9pcGlvIChyaWt1LnZvaXBpb0Bpa2kuZmkpLCBJbHlhIExlb3Noa2V2aWNoIChpaWlAbGludXgu
aWJtLmNvbSksIExhdXJlbnQgVml2aWVyIChsYXVyZW50QHZpdmllci5ldSksIENoaW5tYXkgUmF0
aCAocmF0aGNAbGludXguaWJtLmNvbSksIFJpY2hhcmQgSGVuZGVyc29uIChyaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnKSwgRGF2aWQgSGlsZGVuYnJhbmQgKGRhdmlkQHJlZGhhdC5jb20pLCBU
aG9tYXMgSHV0aCAodGh1dGhAcmVkaGF0LmNvbSksIHFlbXUtczM5MHhAbm9uZ251Lm9yZywgUGFv
bG8gQm9uemluaSAocGJvbnppbmlAcmVkaGF0LmNvbSksIE5pY2hvbGFzIFBpZ2dpbiAobnBpZ2dp
bkBnbWFpbC5jb20pLCBxZW11LXBwY0Bub25nbnUub3JnOzwvZGl2PjxkaXY+0KLQtdC80LA6IFtQ
QVRDSCB2MyA0LzRdIHRhcmdldC9wcGM6IGZpeCBHREIgc3R1YiB0byB3b3JrIGNvcnJlY3RseSB3
aXRoIExFIHBhZ2VzOzwvZGl2PjxkaXY+MTUuMDkuMjAyNSwgMTU6NDYsICJEYW5pbGEgWmhlYnJ5
YWtvdiIgJmx0O2QuemhlYnJ5YWtvdkB5YW5kZXgucnUmZ3Q7OjwvZGl2PjxibG9ja3F1b3RlPjxw
PkdEQiBpcyBleHBlY3RlZCB0byBiZSBzZXQgdG8gdGhlIGVuZGlhbm5lc3Mgb2YgdGhlIGN1cnJl
bnRseSBydW5uaW5nIGNvZGUsIHdoaWNoIG1heSBiZSBpbiBMRSBwYWdlLiBCc3dhcCB0aGUgcmVn
aXN0ZXJzIGFjY29yZGluZ2x5LjxiciAvPjxiciAvPlNpZ25lZC1vZmYtYnk6IERhbmlsYSBaaGVi
cnlha292ICZsdDs8YSBocmVmPSJtYWlsdG86ZC56aGVicnlha292QHlhbmRleC5ydSIgcmVsPSJu
b29wZW5lciBub3JlZmVycmVyIj5kLnpoZWJyeWFrb3ZAeWFuZGV4LnJ1PC9hPiZndDs8YnIgLz4t
LS08YnIgLz7CoHRhcmdldC9wcGMvZ2Ric3R1Yi5jIHwgMTcgKysrKysrKysrKysrKysrKy08YnIg
Lz7CoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pPGJyIC8+
PGJyIC8+ZGlmZiAtLWdpdCBhL3RhcmdldC9wcGMvZ2Ric3R1Yi5jIGIvdGFyZ2V0L3BwYy9nZGJz
dHViLmM8YnIgLz5pbmRleCAzYjI4ZDRlMjFjLi44OWM3ODM4OTRjIDEwMDY0NDxiciAvPi0tLSBh
L3RhcmdldC9wcGMvZ2Ric3R1Yi5jPGJyIC8+KysrIGIvdGFyZ2V0L3BwYy9nZGJzdHViLmM8YnIg
Lz5AQCAtMTksNiArMTksOCBAQDxiciAvPsKgwqAqLzxiciAvPsKgI2luY2x1ZGUgInFlbXUvb3Nk
ZXAuaCI8YnIgLz7CoCNpbmNsdWRlICJjcHUuaCI8YnIgLz4rI2luY2x1ZGUgImFjY2VsL3RjZy9w
cm9iZS5oIjxiciAvPisjaW5jbHVkZSAiZXhlYy90bGItZmxhZ3MuaCI8YnIgLz7CoCNpbmNsdWRl
ICJleGVjL2dkYnN0dWIuaCI8YnIgLz7CoCNpbmNsdWRlICJnZGJzdHViL2hlbHBlcnMuaCI8YnIg
Lz7CoCNpbmNsdWRlICJpbnRlcm5hbC5oIjxiciAvPkBAIC04NCw3ICs4NiwyMCBAQCBzdGF0aWMg
aW50IHBwY19nZGJfcmVnaXN0ZXJfbGVuKGludCBuKTxiciAvPsKgdm9pZCBwcGNfbWF5YmVfYnN3
YXBfcmVnaXN0ZXIoQ1BVUFBDU3RhdGUgKmVudiwgdWludDhfdCAqbWVtX2J1ZiwgaW50IGxlbik8
YnIgLz7CoHs8IS0tIC0tPjxiciAvPsKgI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZPGJyIC8+LSBp
ZiAoIUZJRUxEX0VYNjQoZW52LSZndDttc3IsIE1TUiwgTEUpKSB7PCEtLSAtLT48YnIgLz4rIGJv
b2wgbGVfcGFnZSA9IGZhbHNlOzxiciAvPis8YnIgLz4rIGlmIChlbnYtJmd0O21tdV9tb2RlbCA9
PSBQT1dFUlBDX01NVV9CT09LRTIwNikgezwhLS0gLS0+PGJyIC8+KyBDUFVUTEJFbnRyeUZ1bGwg
KmZ1bGw7PGJyIC8+KyB2b2lkICpob3N0OzxiciAvPisgaW50IG1tdV9pZHggPSBwcGNfZW52X21t
dV9pbmRleChlbnYsIHRydWUpOzxiciAvPis8YnIgLz4rIHByb2JlX2FjY2Vzc19mdWxsX21tdShl
bnYsIGVudi0mZ3Q7bmlwLCAwLCBNTVVfSU5TVF9GRVRDSCwgbW11X2lkeCw8YnIgLz4rICZhbXA7
aG9zdCwgJmFtcDtmdWxsKTs8YnIgLz4rPGJyIC8+KyBsZV9wYWdlID0gZnVsbC0mZ3Q7dGxiX2Zp
bGxfZmxhZ3MgJmFtcDsgVExCX0JTV0FQOzxiciAvPisgfTxiciAvPis8YnIgLz4rIGlmICghbGVf
cGFnZSAmYW1wOyZhbXA7ICFGSUVMRF9FWDY0KGVudi0mZ3Q7bXNyLCBNU1IsIExFKSkgezwhLS0g
LS0+PGJyIC8+wqDCoMKgwqDCoMKgwqDCoMKgLyogZG8gbm90aGluZyAqLzxiciAvPsKgwqDCoMKg
wqB9IGVsc2UgaWYgKGxlbiA9PSA0KSB7PCEtLSAtLT48YnIgLz7CoMKgwqDCoMKgwqDCoMKgwqBi
c3dhcDMycygodWludDMyX3QgKiltZW1fYnVmKTs8L3A+LS08YnIgLz4yLjQ3LjI8YnIgLz7CoDwv
YmxvY2txdW90ZT4=

