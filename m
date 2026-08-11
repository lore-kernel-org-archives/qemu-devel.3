Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAF2C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtspR-0003Cq-EL; Tue, 11 Aug 2026 16:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtspQ-0003CP-AS; Tue, 11 Aug 2026 16:12:04 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtspO-0002TU-SI; Tue, 11 Aug 2026 16:12:04 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 20CC9EC01C5;
 Tue, 11 Aug 2026 16:12:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 16:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479122; x=1786565522; bh=hS1z53I68kIwvAz1qiOv3/s2Vwc1wjiz
 6Mgk29wLK/Q=; b=DjnTFlUReHexSzhehWc1hjxOqCLgwxb0Dgc5auplzAIpgERY
 +Aok22qp3uozTX6pKJ1qqnBFiUJ82RQvWEIDUGgt57rMZtDlvaqD7nBhhKzHT40I
 nw06rky23y736LZZ1az+64Gs25O5Ic+m/J3XAVUJmEfAQdfsFlJWzMBCxmUxzEEm
 ODZsD1fVUSZ/H65k+gegwnqMtC692yYK1tgDnc68Sodq5Sabifpy1yRW2bowRru1
 h7K1uM9HfxpBmGwc4b9WvEcF+/iIP3pNRekt58JLyHhBt7+lSd/RhbL3LolTV81J
 fQYSvJe9TUXVUphFLDwaASNJAs3mFkGXHvLEFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479122; x=
 1786565522; bh=hS1z53I68kIwvAz1qiOv3/s2Vwc1wjiz6Mgk29wLK/Q=; b=O
 8DsWN6ZeZ2WUxraTyix8cSKUHl/RISuJAsxRIyAYs2JgeP5R+tA4+uUcSlMfQC/o
 8ymLKZqIzojZ/h3hvDtStMbJAL6WNxLVjx2ZJbC0asgScbyxTG9bCw4kWU97S6yh
 hlYlJj6H9VZcRefHsr8nPIQAaUEhx3xJSI2hEjx04Fcz+UN6qwnrZ4/S+032igpc
 cqQZ0JsxGVWIrLXvoV2SeHoBapQdaXV2UA7jpvxgZfwZ4eqvfi8/Ldh6WDEoG8ki
 t70YHqzeQAj16/6SsyPPa0jXruB82hUBjfDDI34ESi3M2MO8vpHVqzUSxZEXXnTX
 dVRaDyAm3MQub9Y8tAyow==
X-ME-Sender: <xms:EoJ7agN0ClbYsAS6v4kr84lF2s7Ix8C59w3neWaEqbMcj7fkGla1NA>
 <xme:EoJ7arQCCjFkvnkBr9XkckXS79XWtAl0WJZx8Tz7TjpLLQVZp5fSzDnh9U77dHqSf
 mSXncOx0AzdtLmU33Nvx2CxBOEbfgH1tkOPCViCCPmqOEjOSyru0kw>
X-ME-Received: <xmr:EoJ7amaRNVHYBQNw6uPwb9W3BhVJ034D2LBAlbsxoZNXTz6enoYQfTyrYRJBJWrRkRMTWA>
X-ME-Proxy-Cause: dmFkZTEmK5UXB+iPlA3i4U4vK634iwFqpJzLTxnXFYwYjdVKcmAniDjwi8dzcbpcUWMGL4
 SblBb7YHbzYTYv0IY9B+MITC7GK7k23YfdyIEe/4XFkyFJbyIoEuTbtj4AOQwk6DabFLq8
 YCKvDPH2zPpZgNMyA9kskzb7Fvx2FbtxAaXagPVp8SZCgWfl8HJPWQTcTu7rgLLeBVdBOc
 1TD+D35YhBXkEND/CYBspqheVSXX86UHW8+86vFGNka2CQpO7dGKPIhwaMgttJGEjOB1Sw
 Yo5pU/Cfl/FOVm5aN1slHI7B7IPmPLYZTxJJ4tn3Dh9bKXfbHyBeivhO0XljfW8Uz8pQrj
 eERlabQjXR9l3gIzlLtn8g1QKL++gY4hCqqM+2BZCJ/469LHEiCC49miZHoW4OCQHVuFOM
 hnpsrAj7UY8a6yaYOpwQjSRpkimAULEi8+YuTrcLyFDM7LzZAxS1IQodiWKUwabZ6PPVw0
 X/1/EcD14mfiiCDndOaLfq4900kJE6L5Z6aGfPETil76EUIp9QJmGIrkCADzN5cBSpBCO7
 SIn8Y/oA6GT8ZMb5zIWojA7pnkbwMBP34GtVWB4uLjtYzvysVIQjYuMVXBn+rotpGLrFAT
 tVoCuauoUAXHK/is11lWn+Pe9kZ3LUXR5k4COGyehvrmHRexxkVErHHRH7zg
X-ME-Proxy: <xmx:EoJ7ag2ESuQwZLSd594d-RgxUghVHjFbsjQ4rTRgamAC_TQ9ofpmEw>
 <xmx:EoJ7auXv11yQYreWTRPsVrNNasE1ZdQpac3e8KdwiDbxcCz_iqYM3w>
 <xmx:EoJ7aiVmXy-3_sKc3T22k9Kyo8smv_vBf1vybTd4SuucDCQk2uxucQ>
 <xmx:EoJ7alc34YsR5k8jkyDlI6WHGGFi77HVJMLlmk-91tjZFAxeokdziA>
 <xmx:EoJ7amTgRIc0Kx0Dqdsb0q0s5NoOEJbm20v2GvqjfXHr5ySTQvrsXqsd>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:12:01 -0400 (EDT)
Message-ID: <95304c7b23fe0174909269d498bcea7973aadfb7.camel@alistair23.me>
Subject: Re: [PATCH 17/56] disas/riscv: Drop codec from rv_decode
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
In-Reply-To: <20260809223545.730664-18-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Date: Wed, 12 Aug 2026 06:11:52 +1000
User-Agent: Evolution 3.60.2 (by Flathub.org) 
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=alistair@alistair23.me; helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTA4LTA5IGF0IDE1OjM1IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBUaGlzIGlzIG1vc3RseSB3cml0ZS1vbmx5LCBvbmx5IHVzZWQgaW4gb25lIHBsYWNlOwo+
IG90aGVyIHVwZGF0ZXMgYXJlIGlnbm9yZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBI
ZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0t
Cj4gwqBkaXNhcy9yaXNjdi5oIHwgMSAtCj4gwqBkaXNhcy9yaXNjdi5jIHwgNyArKystLS0tCj4g
wqAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZGlzYXMvcmlzY3YuaCBiL2Rpc2FzL3Jpc2N2LmgKPiBpbmRleCAzMzI1Yjdi
NGVmLi4zMWJiMGRiODZjIDEwMDY0NAo+IC0tLSBhL2Rpc2FzL3Jpc2N2LmgKPiArKysgYi9kaXNh
cy9yaXNjdi5oCj4gQEAgLTE5Nyw3ICsxOTcsNiBAQCB0eXBlZGVmIHN0cnVjdCB7Cj4gwqDCoMKg
wqAgaW50MzJfdMKgwqAgaW1tOwo+IMKgwqDCoMKgIGludDMyX3TCoMKgIGltbTE7Cj4gwqDCoMKg
wqAgdWludDE2X3TCoCBvcDsKPiAtwqDCoMKgIHVpbnQ4X3TCoMKgIGNvZGVjOwo+IMKgwqDCoMKg
IHVpbnQ4X3TCoMKgIHJkOwo+IMKgwqDCoMKgIHVpbnQ4X3TCoMKgIHJzMTsKPiDCoMKgwqDCoCB1
aW50OF90wqDCoCByczI7Cj4gZGlmZiAtLWdpdCBhL2Rpc2FzL3Jpc2N2LmMgYi9kaXNhcy9yaXNj
di5jCj4gaW5kZXggZWM0MGFiYjYxOC4uOTgxM2Q3NWZlYiAxMDA2NDQKPiAtLS0gYS9kaXNhcy9y
aXNjdi5jCj4gKysrIGIvZGlzYXMvcmlzY3YuYwo+IEBAIC00NjAzLDggKzQ2MDMsOSBAQCBzdGF0
aWMgdm9pZCBkZWNvZGVfaW5zdF9vcGVyYW5kcyhydl9kZWNvZGUKPiAqZGVjLCBydl9pc2EgaXNh
LAo+IMKgewo+IMKgwqDCoMKgIHJ2X2luc3QgaW5zdCA9IGRlYy0+aW5zdDsKPiDCoAo+IC3CoMKg
wqAgZGVjLT5jb2RlYyA9IG9wLT5jb2RlYzsKPiAtwqDCoMKgIHN3aXRjaCAoZGVjLT5jb2RlYykg
ewo+ICvCoMKgwqAgc3dpdGNoIChvcC0+Y29kZWMpIHsKPiArwqDCoMKgIGNhc2UgcnZfY29kZWNf
aWxsZWdhbDoKPiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqAgY2FzZSBydl9jb2Rl
Y19ub25lOgo+IMKgwqDCoMKgwqDCoMKgwqAgZGVjLT5yZCA9IGRlYy0+cnMxID0gZGVjLT5yczIg
PSBydl9pcmVnX3plcm87Cj4gwqDCoMKgwqDCoMKgwqDCoCBkZWMtPmltbSA9IDA7Cj4gQEAgLTUz
NjksNyArNTM3MCw2IEBAIHN0YXRpYyBjb25zdCBydl9vcGNvZGVfZGF0YQo+ICpkZWNvZGVfaW5z
dF9saWZ0X3BzZXVkbyhydl9kZWNvZGUgKmRlYywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKGNoZWNrX2NvbnN0cmFpbnRzKGRlYywgY29tcF9kYXRhLT5jb25zdHJhaW50cykpIHsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWMtPm9wID0gY29tcF9kYXRhLT5vcDsK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcCA9ICZkZWMtPm9wY29kZV9kYXRh
W2RlYy0+b3BdOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjLT5jb2RlYyA9
IG9wLT5jb2RlYzsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21w
X2RhdGErKzsKPiBAQCAtNTQwNyw3ICs1NDA3LDYgQEAgc3RhdGljIGNvbnN0IHJ2X29wY29kZV9k
YXRhCj4gKmRlY29kZV9pbnN0X2RlY29tcHJlc3MocnZfZGVjb2RlICpkZWMsIHJ2X2lzYSBpc2Es
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlYy0+b3AgPSBkZWNvbXBfb3A7Cj4gwqDCoMKg
wqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoCBvcCA9ICZkZWMtPm9wY29kZV9kYXRhW2Rl
Y29tcF9vcF07Cj4gLcKgwqDCoMKgwqDCoMKgIGRlYy0+Y29kZWMgPSBvcC0+Y29kZWM7Cj4gwqDC
oMKgwqAgfQo+IMKgwqDCoMKgIHJldHVybiBvcDsKPiDCoH0K


