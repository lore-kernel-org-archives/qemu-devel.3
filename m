Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9A7CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN39-0003G8-T8; Wed, 07 Oct 2026 04:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHol-0006tq-It
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:55:46 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHoW-0005Z2-4p
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:55:37 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 3B6251D0004D
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 11:59:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Tue, 06 Oct 2026 11:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791302368; x=1791388768; bh=C2x/8BHFjckiODBfYVzvYKsK13YOwkO8
 xr+L2KIHVf4=; b=NHG2Pues93vlwNWL0pJXKxgfu3v75pnWhvZP/AeMGIYJ6nXY
 pmTWsSnL8G1zNa1LPbj39/smVd2F/ApaDB9QfygaCNd0NtpH3BnGJimPwYjNSJJf
 PSo4mrrkQB/WHuirhCNQIlb7Oh3UuqtPYH/kNEhDJRkUK5TZaQNo2V0/SaJT7f+W
 dWukAlUND1Tn+4SqB15t6QF3fniicX+XgEqZJUG4hyaZL1FBQ2qDfgTyWdhxXO9F
 Ihq9+wjLWXdV0TX9okCUgO6oAujdqM4doyoXGksVtoeSuL9gbN3Nur2tV3VpggCc
 we3mLj902Tep0Mg52rKsMaj+osSMSxoRlA5DmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791302368; x=
 1791388768; bh=C2x/8BHFjckiODBfYVzvYKsK13YOwkO8xr+L2KIHVf4=; b=p
 8WT/BuT/WnVBavf/EstwmcOO4L0fvhgpX4WmggSphEMYHUBa1rpZKs7LnRDqDWJu
 fftDJbR/+y4ntubDi1It29Jjh0cUlimZw583XLC2HElP1ZBYfi3R7VWtf+UNrUky
 sapMcgqpzqM/TEIe7IqAXv77zHDfzVVQq4KNvNCDeNyXCgz+a3nTjmowkFS00Mpw
 IIaO12Z+3buLTdiOLkb6ARGMByKs39ZeHlNRQ48O4nLRWaI/DX2YzgOJncim/eLh
 OFAH3urZ7xMNG7vApB0uOCa7aUEVlxOsahqgL3Uv4fmB+0XZ5eamP5Rg+1SIWutv
 xfMy/aeb8DQJkzbjZ9Sig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302368; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:GFz8A8IXnnCep6G+AGs44yTLtcCTtnYjLLoiLU/sOsQNmtd
 jP+/GDlAW8dpcu0on0Vt4P+00zw7pLEZk2maqhkZFJ0mnsMvGwn+4rayJMlOL4yR
 9gHdeqjtgjkVPlrboaqFzh44Ym5z7gE+EtVJvd+bAY0OepgTapLT23useJ1XUmEr
 MyUAck64gGokGiaik2CW+AQZ20oBQbZGKgnYbl+c/wFnGEddoYuOC+Ob4m6SQSYz
 cE9aLp9pStC6wHh8+n45kkjYkfATjWBTztXN+3eLZwpJFxL2Uj53Eh1VB3uXNYPN
 xmdfbWhgI6zsB/JY4vtKaIkPiKHvnP5oA8EZysg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:uDHgvR/gl5yvJA0A4e5fhqJ6cWuid5b6Z/E5mZS1c6I=:C2x/8BHFjckiODBfYVzvYKsK13YOwkO8xr+L2KIHVf4=;
X-ME-Sender: <xms:4BrFarueQIOi_2qDiXYmDxE3wxIIhrvDbMMZhZTb070YUxBDjCm5Cg>
 <xme:4BrFagyDGw1yXwQKXAmMeFPlDE8eNyI97TcdLTUNiPmYS0Z8BYhn2oXHtl0f4DJzc
 LyZKF4AZ9sfKb4LtOAe5cwlTXjYeVvsWTJXFHKZfJKdDO1j67bUBNE>
X-ME-Received: <xmr:4BrFat5GGF_ziycEiKP_MzSVIqOWhszmhZoimZy8omccW8mrbDVz43LLvRbqGrnpZtm7KSzKG4meJiKd8NNckbM>
X-ME-Proxy-Cause: dmFkZTE296QxoirS7zpK5ixx7IoT9BtqiYaiBi6SgKvCn6zZX/I7j4uwIhfLGFtXr3WEfg
 010P0AT/NxS16Yocl7wPfFUGzuaqkNrvssd+GKtWWGrm93Z2whaRHeSZ+HgfIhYbukJuAT
 uTmoJP2LrbzEEO4MIG7JTkm77sc3EwmeRzFs9Ji3207yvgHByfjvoybmIc9gvoaNHc8cgy
 P1xj2KtijUAOhqbUfKCeTB4kb+vEpIQFt/NReElG7YQpCLdNgPLiYsI9U6LW4baF8Q6Ia5
 jtC5F71JzJb2EsiQ/Ya+GVobT/ZzMHXwmRcj7ib9ySjJl5CapszbSDLJ7PDPQUvw4V+8o3
 6wCZHyZKeUNKEvMJQkWweWFCS1FI2H+uQLYT5D+ipRcHqzRem6L01uYrvWAyn67oH01/+y
 rLD17RRJ2Fa4SdjqrnJQ0quw9d3uWOzABVIvTkmO1dyELz4ZJex1gZEYt4dqxnjtlw/17L
 ZcvfP3jTU/cYQPbmPoZqPMMHuD+iev92BPLyGHo4Z0GnxwYcjtJU+nYNJNFxaqLUsiT0F5
 en1RFLpsp46VKyvfvrINmZ+RjN6AsgcA4nvq/dBrDtvcVab3Vre9TD5RYlHz2pzf01VlQb
 uSqxoR/OkS/Mx8oSzO0yudJ1oxWUyiNO1jal3Tw9IHL0peJk+VqHAo1YqwJA
X-ME-Proxy: <xmx:4BrFaiWYe9eWiYj9_XpEvX97RgiuezxjCXC9aFwFBMOT9c52-AEtjw>
 <xmx:4BrFah0O61Y7WGUkFkUpd4-Pa1bMW4XrttHHHa9iELZo8A9fjTcAHQ>
 <xmx:4BrFav2TSUJR1APks9ZEdwzyTlRc0XTwfz6gVXtf1FyJANHTLgyqFg>
 <xmx:4BrFak_M5pHuD2eA6So5IYaODzu3fWKl6DS3YYz9f_-rrKJ5nWF_vA>
 <xmx:4BrFaryqOcZ3JdQAxzguNVC7dP-fKuYDJLgrWFlWFwAfyMsPtorGaoOJ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:59:28 -0400 (EDT)
Message-ID: <de737b99874ce4f15b7a9034979f591b5e9f6166.camel@alistair23.me>
Subject: Re: [PATCH v2 14/23] target/riscv: Add MEM_IDX, BSWAP, ALIGN to VDATA
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 07 Oct 2026 01:59:26 +1000
In-Reply-To: <20260821040404.268123-15-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.146;
 envelope-from=alistair@alistair23.me; helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gVGh1LCAyMDI2LTA4LTIwIGF0IDIxOjAzIC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBQb3B1bGF0ZSBpdCBpbiBhbGwgdmVjdG9yIGxkc3Qgb3BlcmF0aW9ucy4KPiBOb3QgeWV0
IHVzZWQgd2l0aGluIHRoZSBoZWxwZXJzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVu
ZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgoKUmV2aWV3ZWQtYnk6IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+
IMKgdGFyZ2V0L3Jpc2N2L2ludGVybmFscy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDMgKysrCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNf
cnZ2LmMuaW5jIHwgMjUgKysrKysrKysrKysrKysrKy0tLQo+IC0tCj4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDIzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rh
cmdldC9yaXNjdi9pbnRlcm5hbHMuaCBiL3RhcmdldC9yaXNjdi9pbnRlcm5hbHMuaAo+IGluZGV4
IDllNGRhMzllYTAuLmI3ZmZiNjA5OGMgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2ludGVy
bmFscy5oCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2ludGVybmFscy5oCj4gQEAgLTk0LDYgKzk0LDkg
QEAgRklFTEQoVkRBVEEsIFZUQSwgNCwgMSkKPiDCoEZJRUxEKFZEQVRBLCBWVEFfQUxMXzFTLCA1
LCAxKQo+IMKgRklFTEQoVkRBVEEsIFZNQSwgNiwgMSkKPiDCoEZJRUxEKFZEQVRBLCBORiwgNywg
NCkKPiArRklFTEQoVkRBVEEsIE1FTV9JRFgsIDExLCAzKQo+ICtGSUVMRChWREFUQSwgQlNXQVAs
IDE0LCAxKQo+ICtGSUVMRChWREFUQSwgQUxJR04sIDE1LCAxKQo+IMKgCj4gwqAvKiBmbG9hdCBw
b2ludCBjbGFzc2lmeSBoZWxwZXJzICovCj4gwqB0YXJnZXRfdWxvbmcgZmNsYXNzX2hfYmYxNih1
aW50NjRfdCBmcnMxKTsKPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5z
L3RyYW5zX3J2di5jLmluYwo+IGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2
di5jLmluYwo+IGluZGV4IGEyMmUyY2FlNmMuLjM5MTYyMzY3NjIgMTAwNjQ0Cj4gLS0tIGEvdGFy
Z2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2di5jLmluYwo+ICsrKyBiL3RhcmdldC9y
aXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMKPiBAQCAtNjkzLDYgKzY5MywxNCBA
QCBzdGF0aWMgdWludDhfdCB2ZXh0X2dldF9lbXVsKERpc2FzQ29udGV4dCAqcywKPiB1aW50OF90
IGVldykKPiDCoHR5cGVkZWYgdm9pZCBnZW5faGVscGVyX2xkc3RfdXMoVENHdl9wdHIsIFRDR3Zf
cHRyLCBUQ0d2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgVENHdl9lbnYsIFRDR3ZfaTMyKTsKPiDCoAo+ICtzdGF0aWMg
dWludDMyX3QgdmRhdGFfYWRkX21lbW9waWR4KERpc2FzQ29udGV4dCAqcywgdWludDMyX3QgZGF0
YSkKPiArewo+ICvCoMKgwqAgZGF0YSA9IEZJRUxEX0RQMzIoZGF0YSwgVkRBVEEsIE1FTV9JRFgs
IHMtPm1lbV9pZHgpOwo+ICvCoMKgwqAgZGF0YSA9IEZJRUxEX0RQMzIoZGF0YSwgVkRBVEEsIEJT
V0FQLCBzLT5tb19lbmRpYW5uZXNzICE9IDApOwo+ICvCoMKgwqAgZGF0YSA9IEZJRUxEX0RQMzIo
ZGF0YSwgVkRBVEEsIEFMSUdOLCAhcy0+Y2ZnX3B0ci0+ZXh0X3ppY2Nsc20pOwo+ICvCoMKgwqAg
cmV0dXJuIGRhdGE7Cj4gK30KPiArCj4gwqBzdGF0aWMgYm9vbCBsZHN0X3VzX3RyYW5zKHVpbnQz
Ml90IHZkLCB1aW50MzJfdCByczEsIHVpbnQzMl90IGRhdGEsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZW5faGVscGVyX2xkc3RfdXMgKmZu
LCBEaXNhc0NvbnRleHQgKnMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBib29sIGlzX3N0b3JlKQo+IEBAIC03MTIsNiArNzIwLDcgQEAgc3Rh
dGljIGJvb2wgbGRzdF91c190cmFucyh1aW50MzJfdCB2ZCwgdWludDMyX3QKPiByczEsIHVpbnQz
Ml90IGRhdGEsCj4gwqDCoMKgwqDCoCAqIFRoZSBmaXJzdCBwYXJ0IGlzIHZsZW4gaW4gYnl0ZXMg
KHZsZW5iKSwgZW5jb2RlZCBpbiBtYXhzeiBvZgo+IHNpbWRfZGVzYy4KPiDCoMKgwqDCoMKgICog
VGhlIHNlY29uZCBwYXJ0IGlzIGxtdWwsIGVuY29kZWQgaW4gZGF0YSBvZiBzaW1kX2Rlc2MuCj4g
wqDCoMKgwqDCoCAqLwo+ICvCoMKgwqAgZGF0YSA9IHZkYXRhX2FkZF9tZW1vcGlkeChzLCBkYXRh
KTsKPiDCoMKgwqDCoCBkZXNjID0gdGNnX2NvbnN0YW50X2kzMihzaW1kX2Rlc2Mocy0+Y2ZnX3B0
ci0+dmxlbmIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5jZmdfcHRyLT52bGVuYiwgZGF0YSkp
Owo+IMKgCj4gQEAgLTg5MCw2ICs4OTksOCBAQCBzdGF0aWMgYm9vbCBsZHN0X3N0cmlkZV90cmFu
cyh1aW50MzJfdCB2ZCwKPiB1aW50MzJfdCByczEsIHVpbnQzMl90IHJzMiwKPiDCoMKgwqDCoCBt
YXNrID0gdGNnX3RlbXBfbmV3X3B0cigpOwo+IMKgwqDCoMKgIGJhc2UgPSBnZXRfZ3ByKHMsIHJz
MSwgRVhUX05PTkUpOwo+IMKgwqDCoMKgIHN0cmlkZSA9IGdldF9ncHIocywgcnMyLCBFWFRfTk9O
RSk7Cj4gKwo+ICvCoMKgwqAgZGF0YSA9IHZkYXRhX2FkZF9tZW1vcGlkeChzLCBkYXRhKTsKPiDC
oMKgwqDCoCBkZXNjID0gdGNnX2NvbnN0YW50X2kzMihzaW1kX2Rlc2Mocy0+Y2ZnX3B0ci0+dmxl
bmIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5jZmdfcHRyLT52bGVuYiwgZGF0YSkpOwo+IMKg
Cj4gQEAgLTk5MSw2ICsxMDAyLDggQEAgc3RhdGljIGJvb2wgbGRzdF9pbmRleF90cmFucyh1aW50
MzJfdCB2ZCwKPiB1aW50MzJfdCByczEsIHVpbnQzMl90IHZzMiwKPiDCoMKgwqDCoCBtYXNrID0g
dGNnX3RlbXBfbmV3X3B0cigpOwo+IMKgwqDCoMKgIGluZGV4ID0gdGNnX3RlbXBfbmV3X3B0cigp
Owo+IMKgwqDCoMKgIGJhc2UgPSBnZXRfZ3ByKHMsIHJzMSwgRVhUX05PTkUpOwo+ICsKPiArwqDC
oMKgIGRhdGEgPSB2ZGF0YV9hZGRfbWVtb3BpZHgocywgZGF0YSk7Cj4gwqDCoMKgwqAgZGVzYyA9
IHRjZ19jb25zdGFudF9pMzIoc2ltZF9kZXNjKHMtPmNmZ19wdHItPnZsZW5iLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcy0+Y2ZnX3B0ci0+dmxlbmIsIGRhdGEpKTsKPiDCoAo+IEBAIC0xMTI3LDYg
KzExNDAsOCBAQCBzdGF0aWMgYm9vbCBsZGZmX3RyYW5zKHVpbnQzMl90IHZkLCB1aW50MzJfdAo+
IHJzMSwgdWludDMyX3QgZGF0YSwKPiDCoMKgwqDCoCBkZXN0ID0gdGNnX3RlbXBfbmV3X3B0cigp
Owo+IMKgwqDCoMKgIG1hc2sgPSB0Y2dfdGVtcF9uZXdfcHRyKCk7Cj4gwqDCoMKgwqAgYmFzZSA9
IGdldF9ncHIocywgcnMxLCBFWFRfTk9ORSk7Cj4gKwo+ICvCoMKgwqAgZGF0YSA9IHZkYXRhX2Fk
ZF9tZW1vcGlkeChzLCBkYXRhKTsKPiDCoMKgwqDCoCBkZXNjID0gdGNnX2NvbnN0YW50X2kzMihz
aW1kX2Rlc2Mocy0+Y2ZnX3B0ci0+dmxlbmIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5jZmdf
cHRyLT52bGVuYiwgZGF0YSkpOwo+IMKgCj4gQEAgLTEyMzEsMTUgKzEyNDYsMTUgQEAgc3RhdGlj
IGJvb2wgbGRzdF93aG9sZV90cmFucyh1aW50MzJfdCB2ZCwKPiB1aW50MzJfdCByczEsIHVpbnQz
Ml90IG5mLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoCB9
Cj4gwqDCoMKgwqAgfSBlbHNlIHsKPiAtwqDCoMKgwqDCoMKgwqAgVENHdl9wdHIgZGVzdDsKPiAt
wqDCoMKgwqDCoMKgwqAgVENHdiBiYXNlOwo+ICvCoMKgwqDCoMKgwqDCoCBUQ0d2X3B0ciBkZXN0
ID0gdGNnX3RlbXBfbmV3X3B0cigpOwo+ICvCoMKgwqDCoMKgwqDCoCBUQ0d2IGJhc2UgPSBnZXRf
Z3ByKHMsIHJzMSwgRVhUX05PTkUpOwo+IMKgwqDCoMKgwqDCoMKgwqAgVENHdl9pMzIgZGVzYzsK
PiDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGRhdGEgPSBGSUVMRF9EUDMyKDAsIFZEQVRBLCBO
RiwgbmYpOwo+IMKgwqDCoMKgwqDCoMKgwqAgZGF0YSA9IEZJRUxEX0RQMzIoZGF0YSwgVkRBVEEs
IFZNLCAxKTsKPiAtwqDCoMKgwqDCoMKgwqAgZGVzdCA9IHRjZ190ZW1wX25ld19wdHIoKTsKPiAr
wqDCoMKgwqDCoMKgwqAgZGF0YSA9IHZkYXRhX2FkZF9tZW1vcGlkeChzLCBkYXRhKTsKPiArCj4g
wqDCoMKgwqDCoMKgwqDCoCBkZXNjID0gdGNnX2NvbnN0YW50X2kzMihzaW1kX2Rlc2Mocy0+Y2Zn
X3B0ci0+dmxlbmIsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcy0+Y2ZnX3B0ci0+dmxlbmIsIGRhdGEpKTsKPiAtwqDCoMKgwqDCoMKgwqAgYmFzZSA9
IGdldF9ncHIocywgcnMxLCBFWFRfTk9ORSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cy0+Y2ZnX3B0ci0+dmxlbmIsIGRhdGEpKTsKPiDCoMKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fYWRk
aV9wdHIoZGVzdCwgdGNnX2VudiwgdnJlZ19vZnMocywgdmQpKTsKPiDCoMKgwqDCoMKgwqDCoMKg
IGZuKGRlc3QsIGJhc2UsIHRjZ19lbnYsIGRlc2MpOwo+IMKgwqDCoMKgIH0KPiAtLSAKPiAyLjQz
LjAKPiAK


