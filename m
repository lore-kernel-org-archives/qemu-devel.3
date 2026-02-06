Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56865EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQ5m-0004TD-MJ; Fri, 06 Feb 2026 12:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1voQ5k-0004Sr-UD; Fri, 06 Feb 2026 12:58:05 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1voQ5h-0007eN-Ny; Fri, 06 Feb 2026 12:58:04 -0500
Received: from mail-nwsmtp-mxback-corp-main-90.klg.yp-c.yandex.net
 (mail-nwsmtp-mxback-corp-main-90.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:7527:0:640:60b9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5B08C80784;
 Fri, 06 Feb 2026 20:57:56 +0300 (MSK)
Received: from mail.yandex-team.ru (2a02:6b8:c43:d2c0:0:640:1a89:0
 [2a02:6b8:c43:d2c0:0:640:1a89:0])
 by mail-nwsmtp-mxback-corp-main-90.klg.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTPS id FaSLFj0ngmI0-sPwtQ70Q; Fri, 06 Feb 2026 20:57:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770400676;
 bh=5nbDeCGhSsfKzynAI4QF/8/9m1FnZ+GbvKWbudHYvTE=;
 h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
 b=1B96Akkh5KPmz43UWnGbuSUiKS7n5OJh3i2yob4wJReoFc1Za2DsLYtdeBdlbpgsZ
 VZ2EM9IgblVeikxPohNvxz/iv+NlIwo7VZaxq3AjkQAoYrxUcc8arh7acCH+6CgAZZ
 A2I7hhDnOxtyvMp+TkgNQTdTGKDB9ovdJWYg3rVg=
Authentication-Results: mail-nwsmtp-mxback-corp-main-90.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Received: by mail-sendbernar-corp-main-91.klg.yp-c.yandex.net
 (sendbernar/Yandex) with HTTPS id 560f5485bcdf8b5647ae960827f69ffe; 
 Fri, 06 Feb 2026 20:57:55 +0300
From: Sergei Heifetz <heifetz@yandex-team.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
In-Reply-To: <CAFEAcA9TFgGrXx9TfC1jr=VOOJzoAQqirbDOyf2PU3cMXc9iLw@mail.gmail.com>
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-4-heifetz@yandex-team.com>
 <722eb7df-0eb2-49c1-af07-90004ad46a8e@vivier.eu>
 <67851770384370@mail.yandex-team.ru>
 <CAFEAcA9TFgGrXx9TfC1jr=VOOJzoAQqirbDOyf2PU3cMXc9iLw@mail.gmail.com>
Subject: Re: [PATCH 3/4] system/physmem.c: reorder usage and assertion of block
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 06 Feb 2026 22:57:55 +0500
Message-Id: <67741770400127@mail.yandex-team.ru>
Content-Transfer-Encoding: base64
Content-Type: text/html; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

PGRpdj48ZGl2PkhlbGxvLCBQZXRlci4gVGhhbmsgeW91IHZlcnkgbXVjaC4gSSBhcG9sb2dpemUg
Zm9yIHRoZSBtaXN1bmRlcnN0YW5kaW5n4oCUSSBzaG91bGQgaGF2ZSByZWFkIExhdXJlbnQncyBt
ZXNzYWdlIG1vcmUgY2FyZWZ1bGx5IHRvIHJlYWxpemUgdGhhdCB0aGVzZSBsaW5lcyBoYXZlIG5v
dGhpbmcgdG8gZG8gd2l0aCBoaXMgY29tbWVudC4gSSdtIG5vdCB5ZXQgYWNjdXN0b21lZCB0byBj
b21tdW5pY2F0aW5nIHZpYSBlbWFpbC4gSXQgbWFrZXMgcGVyZmVjdCBzZW5zZSBub3cuPC9kaXY+
PC9kaXY+PGRpdj48YnIgLz48L2Rpdj48ZGl2PjxiciAvPjwvZGl2PjxkaXY+LS0tLS0tLS0tLS0t
LS0tLTwvZGl2PgogICAgICAgICAgICAgICAgICAgICAgICA8ZGl2PtCa0L7QvNGDOiBTZXJnZWkg
SGVpZmV0eiAoaGVpZmV0ekB5YW5kZXgtdGVhbS5jb20pOzxiciAvPjwvZGl2PgogICAgICAgICAg
ICAgICAgICAgICAgICA8ZGl2PtCa0L7Qv9C40Y86IExhdXJlbnQgVml2aWVyIChsYXVyZW50QHZp
dmllci5ldSksIHFlbXUtZGV2ZWxAbm9uZ251Lm9yZywgcWVtdS10cml2aWFsQG5vbmdudS5vcmc7
PGJyIC8+PC9kaXY+CiAgICAgICAgICAgICAgICAgICAgICAgIDxkaXY+0KLQtdC80LA6IFtQQVRD
SCAzLzRdIHN5c3RlbS9waHlzbWVtLmM6IHJlb3JkZXIgdXNhZ2UgYW5kIGFzc2VydGlvbiBvZiBi
bG9jazs8YnIgLz48L2Rpdj4KICAgICAgICAgICAgICAgICAgICAgICAgPGRpdj4wNi4wMi4yMDI2
LCAxODo0OSwgIlBldGVyIE1heWRlbGwiICZsdDtwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcmZ3Q7
OjxiciAvPjwvZGl2PgogICAgICAgICAgICAgICAgICAgICAgICA8YmxvY2txdW90ZT48cD5PbiBG
cmksIDYgRmViIDIwMjYgYXQgMTM6MzMsIFNlcmdlaSBIZWlmZXR6ICZsdDs8YSBocmVmPSJtYWls
dG86aGVpZmV0ekB5YW5kZXgtdGVhbS5jb20iPmhlaWZldHpAeWFuZGV4LXRlYW0uY29tPC9hPiZn
dDsgd3JvdGU6PGJyIC8+PC9wPjxibG9ja3F1b3RlIGNsYXNzPSIyMTBlN2E4NDhlOGZjYjQ1d21p
LXF1b3RlIj48YnIgLz48YnIgLz48YnIgLz7CoEFjY29yZGluZyB0byBjb2Rpbmcgc3R5bGUgKGRv
Y3MvZGV2ZWwvc3R5bGUucnN0KTo8YnIgLz48YnIgLz7CoE1peGVkIGRlY2xhcmF0aW9ucyAoaW50
ZXJsZWF2aW5nIHN0YXRlbWVudHMgYW5kIGRlY2xhcmF0aW9ucyB3aXRoaW48YnIgLz7CoGJsb2Nr
cykgYXJlIGdlbmVyYWxseSBub3QgYWxsb3dlZC48YnIgLz48YnIgLz48YnIgLz7CoMKgwqDCoMKg
wqDCoMKgbmV3c2l6ZSA9IFRBUkdFVF9QQUdFX0FMSUdOKG5ld3NpemUpOzxiciAvPsKgwqDCoMKg
wqDCoMKgwqBuZXdzaXplID0gUkVBTF9IT1NUX1BBR0VfQUxJR04obmV3c2l6ZSk7PGJyIC8+PGJy
IC8+PGJyIC8+PGJyIC8+wqBIZWxsbywgTGF1cmVudC4gUGxlYXNlIG5vdGUgdGhhdCBJIGRpZG4n
dCB0b3VjaCB0aGVzZSBsaW5lcy48YnIgLz48L2Jsb2NrcXVvdGU+PHA+PGJyIC8+TGF1cmVudCdz
IGNvbW1lbnQgaXMgbm90IGFib3V0IHRob3NlIHR3byBsaW5lcywgYnV0IGFib3V0PGJyIC8+dGhl
IG9uZXMgYWJvdmUsIHRoYXQgeW91IGRvbid0IHF1b3RlIGluIHlvdXIgcmVwbHkuIChMYXVyZW50
PGJyIC8+aXMgZm9sbG93aW5nIHRoZSB1c3VhbCBtYWlsaW5nIGxpc3Qgc3R5bGUgb2YgaW50ZXJs
ZWF2ZWQgY29tbWVudGFyeSw8YnIgLz5zbyBoaXMgcmVtYXJrIGZvbGxvd3MgdGhlIHBhcnQgb2Yg
eW91ciBlbWFpbCB0aGF0IGl0IGlzIGluPGJyIC8+cmVzcG9uc2UgdG8uKTxiciAvPjxiciAvPjwv
cD48YmxvY2txdW90ZSBjbGFzcz0iMjEwZTdhODQ4ZThmY2I0NXdtaS1xdW90ZSI+wqBAQCAtMjA1
NCwxMSArMjA1NCwxMSBAQCBzdGF0aWMgaW50IG1lbW9yeV90cnlfZW5hYmxlX21lcmdpbmcodm9p
ZCAqYWRkciwgc2l6ZV90IGxlbik8YnIgLz7CoMKgwqDCoCovPGJyIC8+wqDCoMKgaW50IHFlbXVf
cmFtX3Jlc2l6ZShSQU1CbG9jayAqYmxvY2ssIHJhbV9hZGRyX3QgbmV3c2l6ZSwgRXJyb3IgKipl
cnJwKTxiciAvPsKgwqDCoHs8IS0tIC0tPjxiciAvPsKgKyAgICBhc3NlcnQoYmxvY2spOzxiciAv
PsKgKzxiciAvPsKgwqDCoMKgwqDCoMKgY29uc3QgcmFtX2FkZHJfdCBvbGRzaXplID0gYmxvY2st
Jmd0O3VzZWRfbGVuZ3RoOzxiciAvPsKgwqDCoMKgwqDCoMKgY29uc3QgcmFtX2FkZHJfdCB1bmFs
aWduZWRfc2l6ZSA9IG5ld3NpemU7PGJyIC8+PGJyIC8+wqAtICAgIGFzc2VydChibG9jayk7PGJy
IC8+wqAtPGJyIC8+PC9ibG9ja3F1b3RlPjxwPjxiciAvPllvdSd2ZSBtb3ZlZCBhIGNvZGUgbGlu
ZSAodGhlIGFzc2VydCkgYWJvdmUgdGhlIGRlY2xhcmF0aW9uIGxpbmVzLCBzbzxiciAvPnRoZSBm
dW5jdGlvbiB1c2VkIHRvIGZvbGxvdyB0aGlzIGNvZGluZyBzdHlsZSBydWxlLCBidXQgbm93IGl0
IGRvZXNuJ3QuPGJyIC8+PGJyIC8+dGhhbmtzPGJyIC8+LS0gUE1NPGJyIC8+PC9wPjwvYmxvY2tx
dW90ZT4=

