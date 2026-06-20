Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3853CDB466
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 08:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1warA4-0007jb-8g; Sat, 20 Jun 2026 04:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1warA1-0007iN-T9
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 04:34:41 -0400
Received: from mail-4317.protonmail.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1war9z-0002y7-Cj
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 04:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail3; t=1781944477; x=1782203677;
 bh=dL8eWft9febIY00ubN4SVI87eyqnrRB7N7GpG5iYwCg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=gbj00d/Nv5TJqz5/Y1xYVSYgNgJqg6V/NOuhYFidUyHsrFJjjpsDvwWjP6kdbUU8X
 de34c3or2zDpVWspz8Xs05pmujPn3AcmaJkrcQBws5r97WU3vJSibpbLvFFJg5nUOH
 zoI0yX3nd5ysnOJZU8WTwPDhJ5R9qztaAxzrLaPDsOi6pjtRJVGBUmmGm76UcvXl+r
 AtNnrIfYYm9PaUbysl0ddbKD2f0BctMvbX1RZjkd3kQxs3myXB7KnVsPWIVzDQcu98
 DIJPG1E0avdFwW8UWYJ9xyEM8CqdK76Igp01QhSwRHGK3Fb+cygnlzX/A6Wj/3mKEt
 2/Cu/YK6Ixo1Q==
Date: Sat, 20 Jun 2026 08:34:31 +0000
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v5 0/5 qemu] GNU/Hurd support
Message-ID: <a612eb6b-8e42-42e0-a6c8-4f09b33fdcab@zamaudio.com>
In-Reply-To: <977b7644-2511-4ded-9f7c-81dd610b6f04@oss.qualcomm.com>
References: <20260208055858.2166524-1-damien@zamaudio.com>
 <977b7644-2511-4ded-9f7c-81dd610b6f04@oss.qualcomm.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: d3fe9b8efa6f637fd191be4c51600282d9416151
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1=_jElOVuhMh05H2UPFUM5oZ5pDGQ3NhnOX5aj7R7nxw"
Received-SPF: pass client-ip=185.70.43.17; envelope-from=damien@zamaudio.com;
 helo=mail-4317.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--b1=_jElOVuhMh05H2UPFUM5oZ5pDGQ3NhnOX5aj7R7nxw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGkgUGhpbCwKCk9uIDE4LzYvMjYgNjozMyBwbSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3Jv
dGU6Cgo+IE9uIDgvMi8yNiAwNjo1OSwgRGFtaWVuIFphbW1pdCB3cm90ZToKPgo+PiAuLi4KPj4g
RXhlY3V0ZWQgcWVtdS1zeXN0ZW0te2kzODYseDg2XzY0fSBvbiBHTlUvSHVyZCB4ODZfNjQgc3Vj
Y2Vzc2Z1bGx5LgoKPiBDb3VsZCB3ZSBnZXQgdGhpcyBjb25maWd1cmF0aW9uIGludGVncmF0ZWQg
aW4gb3VyIENJIHRvIGJlIHN1cmUKPiBpdCB3b24ndCBiaXRyb3Q/Cj4KPiBTZWUgaG93IHdlIHRl
c3QgT3BlbkJTRCBvciBIYWlrdSBmb3IgZXhhbXBsZToKPgo+IHRlc3RzL3ZtL01ha2VmaWxlLmlu
Y2x1ZGU6Mjg6WDg2X0lNQUdFUyA6PSBmcmVlYnNkIG5ldGJzZCBvcGVuYnNkCj4gaGFpa3UueDg2
XzY0CgpJIHRvb2sgYSBxdWljayBsb29rLCBpdCBhcHBlYXJzIHZpcnRpby1ibGsgYW5kIHZpcnRp
by1uZXQgYXJlIGJvdGggcmVxdWlyZWQKdG8gYXV0b21hdGUgdGhlIGJ1aWxkaW5nIG9mIHRoZSB0
ZXN0IHZtLCBidXQgR05VL0h1cmQgZG9lcyBub3QgaGF2ZSBkcml2ZXJzIGZvciB0aGVzZSB5ZXQu
CgpJIGNhbiB0YWtlIGFub3RoZXIgbG9vayBhdCB0aGlzIHdoZW4gdmlydGlvIGlzIHdvcmtpbmcg
aW4gSHVyZCB3aXRoIHJ1bXAgZnJhbWV3b3JrLgoKVGhhbmtzLApEYW1pZW4=

--b1=_jElOVuhMh05H2UPFUM5oZ5pDGQ3NhnOX5aj7R7nxw
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PCFET0NUWVBFIGh0bWw+DQo8aHRtbD4NCiAgPGhlYWQ+DQogICAgPG1ldGEgaHR0cC1lcXVpdj0i
Q29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPg0KICA8L2hl
YWQ+DQogIDxib2R5Pg0KICAgIDxwPjxmb250IGZhY2U9Im1vbm9zcGFjZSI+SGkgUGhpbCw8L2Zv
bnQ+PC9wPg0KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+PGZvbnQgZmFjZT0ibW9u
b3NwYWNlIj5PbiAxOC82LzI2IDY6MzMNCiAgICAgICAgcG0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIHdyb3RlOjxzcGFuDQogICAgICAgIHN0eWxlPSJ3aGl0ZS1zcGFjZTogcHJlLXdyYXAiPg0K
PC9zcGFuPjwvZm9udD48L2Rpdj4NCiAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIg0KICAgICAg
Y2l0ZT0ibWlkOjk3N2I3NjQ0LTI1MTEtNGRlZC05ZjdjLTgxZGQ2MTBiNmYwNEBvc3MucXVhbGNv
bW0uY29tIj4NCiAgICAgIDxwcmUgd3JhcD0iIiBjbGFzcz0ibW96LXF1b3RlLXByZSI+T24gOC8y
LzI2IDA2OjU5LCBEYW1pZW4gWmFtbWl0IHdyb3RlOg0KPC9wcmU+DQogICAgICA8YmxvY2txdW90
ZSB0eXBlPSJjaXRlIj4NCiAgICAgICAgPHByZSB3cmFwPSIiIGNsYXNzPSJtb3otcXVvdGUtcHJl
Ij4uLi4NCkV4ZWN1dGVkIHFlbXUtc3lzdGVtLXtpMzg2LHg4Nl82NH0gb24gR05VL0h1cmQgeDg2
XzY0IHN1Y2Nlc3NmdWxseS48L3ByZT4NCiAgICAgIDwvYmxvY2txdW90ZT4NCiAgICA8L2Jsb2Nr
cXVvdGU+DQogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSINCiAgICAgIGNpdGU9Im1pZDo5Nzdi
NzY0NC0yNTExLTRkZWQtOWY3Yy04MWRkNjEwYjZmMDRAb3NzLnF1YWxjb21tLmNvbSI+DQogICAg
ICA8cHJlIHdyYXA9IiIgY2xhc3M9Im1vei1xdW90ZS1wcmUiPkNvdWxkIHdlIGdldCB0aGlzIGNv
bmZpZ3VyYXRpb24gaW50ZWdyYXRlZCBpbiBvdXIgQ0kgdG8gYmUgc3VyZQ0KaXQgd29uJ3QgYml0
cm90Pw0KDQpTZWUgaG93IHdlIHRlc3QgT3BlbkJTRCBvciBIYWlrdSBmb3IgZXhhbXBsZToNCg0K
dGVzdHMvdm0vTWFrZWZpbGUuaW5jbHVkZToyODpYODZfSU1BR0VTIDo9IGZyZWVic2QgbmV0YnNk
IG9wZW5ic2QNCmhhaWt1Lng4Nl82NA0KDQo8L3ByZT4NCiAgICA8L2Jsb2NrcXVvdGU+DQogICAg
PHA+PGZvbnQgZmFjZT0ibW9ub3NwYWNlIj5JIHRvb2sgYSBxdWljayBsb29rLCBpdCBhcHBlYXJz
IHZpcnRpby1ibGsNCiAgICAgICAgYW5kIHZpcnRpby1uZXQgYXJlIGJvdGggcmVxdWlyZWQ8YnI+
DQogICAgICAgIHRvIGF1dG9tYXRlIHRoZSBidWlsZGluZyBvZiB0aGUgdGVzdCB2bSwgYnV0IEdO
VS9IdXJkIGRvZXMgbm90DQogICAgICAgIGhhdmUgZHJpdmVycyBmb3IgdGhlc2UgeWV0Ljxicj4N
CiAgICAgIDwvZm9udD48L3A+DQogICAgPHA+PGZvbnQgZmFjZT0ibW9ub3NwYWNlIj5JIGNhbiB0
YWtlIGFub3RoZXIgbG9vayBhdCB0aGlzIHdoZW4NCiAgICAgICAgdmlydGlvIGlzIHdvcmtpbmcg
aW4gSHVyZCB3aXRoIHJ1bXAgZnJhbWV3b3JrLjwvZm9udD48L3A+DQogICAgPHA+PGZvbnQgZmFj
ZT0ibW9ub3NwYWNlIj5UaGFua3MsPGJyPg0KICAgICAgICBEYW1pZW48L2ZvbnQ+PC9wPg0KICA8
L2JvZHk+DQo8L2h0bWw+DQo=


--b1=_jElOVuhMh05H2UPFUM5oZ5pDGQ3NhnOX5aj7R7nxw--


