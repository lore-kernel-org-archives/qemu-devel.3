Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF11C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwAXN-0000f6-NA; Mon, 17 Aug 2026 23:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwAXL-0000du-8A; Mon, 17 Aug 2026 23:30:51 -0400
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwAXJ-0007SF-Mf; Mon, 17 Aug 2026 23:30:50 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 13C0D1D0004B;
 Mon, 17 Aug 2026 23:30:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Mon, 17 Aug 2026 23:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787023845; x=1787110245; bh=PNm8bNK2GOSTuFyW9huewIQ0lfMYhQW/
 LfOgOUkBZPA=; b=t5DAZ5K2mczDh+frCmsSX/CX8D6z1mbCBqegFEe7UHd4ZmnW
 f9bhfOSj8p6Z8hKhFYfvRKkHrpL1N8DhWcPBF0u4RLvfJyAYipz3Qig0dXdNHOHx
 5MxIM27fxUbp3vCwJN8O4tjnn9RRrUJIsCaxdykHQ/m/0ZvgTRFoBvgl92HJSGB9
 lBAOYv205YN+o4HXlPFRcGNpSzI0TlR8YhThTCbUPsexMNDesJlIzgETFUS5Soyt
 CWGwYE4qTVxCAyyWCOCjm2rEoRZg1OT7ftIeAUUtBuVmqOXdQodBzGkx5WbbRb6I
 VK/YSIOguD3e4Ff1n/ymysDckiLI19RyIrcOIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787023845; x=
 1787110245; bh=PNm8bNK2GOSTuFyW9huewIQ0lfMYhQW/LfOgOUkBZPA=; b=M
 WdfG46IgPbXsn7adTCXp5dlh4Jd2GRNMWkJaZxVNTwctoMoSWa5wjW6dEOr9rRtd
 9LDbts9bJXqS/UlSOjAuxu44DKKvBB97Kiw+tIMSHFeJzdTxb2lmOvRA4Jo1HEK7
 3xPPpImqkXJGBGdjCZxYreYyFhVdhDB1gmquSoQAe5ecsxc+jQCRTXEY8sFn2rF2
 CcqCN2jredOBsVixhwjWjXPvUiZW9fAytu3uML1oH70v9sfq5sjlmyTHSVX6uUqM
 EmcO8pwmMzQFP4crbWxBIwziaIRhTY61NzsHfm9Cw51IHERefgBPABBmvozy2+uH
 UGF/ocuAR0Q7FooBEo5Jw==
X-ME-Sender: <xms:5dGDapse4DspQHlkqmr-xXcb5w762z_S22aM1hoGB7Ve4OsYnDcoSA>
 <xme:5dGDainLYYV7OdWdKTSHDEWCzIv9A5nVwt_E2SULbEeHiNImtJ87C2YaBJvWf-0XP
 -5bDttVCikXrm8SCU_7sM1tiQfb0bmgiRojnxHvSEdNJ22eGITSpTs>
X-ME-Received: <xmr:5dGDaktgyewaXNS7Ygxu8jk-48K2r6KDqtbsdk8WOilkHPtHIzAFgX_fQN1gGkDqES_xJx1VM8EGf_tgXrw1GPYdUew>
X-ME-Proxy-Cause: dmFkZTFrwVq7+53TR7uuUJGEfdkdiy39A6+Ny9LCLF2r81HDJ3gIIZIdOXXtdd2kfdkHLV
 D+z/rqVWW03rhXEOzaVim7TYlBErLxD40IKg90DqVouJZ0vOuLRh4Jr9TT/ergajlQA9E3
 FBJq4ovznsq4ZzC5kjyw5+K2cXTPvpADsQdwZeaE7Lk2muGVZtFxiGY/Ws4Damk+b3mzlH
 Ly4vIAepcsaHD6WOwDpbk3XgnYZHWbpUGMEPChyWcFQjZq7948zyllKgQ2jTJiZKE2UhBI
 4JavE081a/46Vbkm6IYxNkviFU8KbJbizw6oxHd0GUaRTZ4OesCci9FJjLvIawPYZZVaWJ
 T6lq43ovtJ0WvmuCQD0bV64zhb7q4VQkCdaCKMYr4nUKHH9r3aSPheg+CytCfk5rmzQEaK
 cUpKcDEYAyeDtSJfV+LB3gItGaQHWSSKP7ntWcxeO2TRSJcSMZk75G/vKF2bsRVppFXwtX
 pOLDiTRoym2EvTo3ou6PRSCtoUsA8w6PUlBbhfVMOJOjbeeUBRHFfOu5/OGRrqygAvVlNA
 Csx/6/R9iIxfV9v1cnhst/rUxkgulyVzjFdF7XPE34Q/mPPyX+/YcH17ewe+SE4omkZD0W
 A2/ZbDnJhgAsIBRvRLdrzit/4dkeqXC7UuEA6cAvNbapqimVQFIWY29CJk6w
X-ME-Proxy: <xmx:5dGDaocilPCzxlRl2TAOmm601GH3CI2tNMmtpNjCdo3K0h1f747O4Q>
 <xmx:5dGDakwLdtq912eg0s37LBlVoBxueFfIzOL9lrv8SvJLnhLN6iezIA>
 <xmx:5dGDamElmT2Tu-C79MgZYmEc4WVC4m0x4OG8WxX3I1lnNyKPaiFNaA>
 <xmx:5dGDagxGdxJMptHXCQhCcdS8ch6hJTurBBfY8HIrvZYxaAuzwdFUpA>
 <xmx:5dGDaoHazJJlxEXfIvm9-_SIQ3LyaOAeSAtRrX8NPpFv_GG8acWZkpnL>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 23:30:43 -0400 (EDT)
Message-ID: <7a536943a7b99eb8e0407a9e29ca14be7453f90e.camel@alistair23.me>
Subject: Re: [RFC PATCH 13/18] target/riscv: Move PMP_AMATCH_OFF check in
 pmp_hart_has_privs
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Date: Tue, 18 Aug 2026 13:30:41 +1000
In-Reply-To: <20260815203730.1468365-14-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.148;
 envelope-from=alistair@alistair23.me; helo=fout-b5-smtp.messagingengine.com
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

T24gU2F0LCAyMDI2LTA4LTE1IGF0IDEzOjM3IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBDaGVjayBmb3IgcmVnaW9uIGRpc2FibGVkIGJlZm9yZSBjaGVja2luZyB0aGUgcmVnaW9u
IHJhbmdlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnPgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0
YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgdGFyZ2V0L3Jpc2N2L3Rj
Zy9wbXAuYyB8IDkgKysrKystLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3BtcC5j
IGIvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYwo+IGluZGV4IDQxYjU1NTE5YTguLjViY2NjNjA1Mjcg
MTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYwo+ICsrKyBiL3RhcmdldC9yaXNj
di90Y2cvcG1wLmMKPiBAQCAtNDE1LDYgKzQxNSwxMCBAQCBib29sIHBtcF9oYXJ0X2hhc19wcml2
cyhDUFVSSVNDVlN0YXRlICplbnYsCj4gaHdhZGRyIGFkZHIsCj4gwqDCoMKgwqDCoCAqIGZyb20g
bG93IHRvIGhpZ2gKPiDCoMKgwqDCoMKgICovCj4gwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IHBt
cF9yZWdpb25zOyBpKyspIHsKPiArwqDCoMKgwqDCoMKgwqAgaWYgKHBtcF9nZXRfYV9maWVsZChl
bnYtPnBtcF9zdGF0ZS5wbXBbaV0uY2ZnX3JlZykgPT0KPiBQTVBfQU1BVENIX09GRikgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gKwo+
IMKgwqDCoMKgwqDCoMKgwqAgcyA9IHBtcF9pc19pbl9yYW5nZShlbnYsIGksIGFkZHIpOwo+IMKg
wqDCoMKgwqDCoMKgwqAgZSA9IHBtcF9pc19pbl9yYW5nZShlbnYsIGksIGFkZHIgKyBwbXBfc2l6
ZSAtIDEpOwo+IMKgCj4gQEAgLTQyNywxMCArNDMxLDcgQEAgYm9vbCBwbXBfaGFydF9oYXNfcHJp
dnMoQ1BVUklTQ1ZTdGF0ZSAqZW52LAo+IGh3YWRkciBhZGRyLAo+IMKgwqDCoMKgwqDCoMKgwqAg
fQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCAvKiBmdWxseSBpbnNpZGUgKi8KPiAtwqDCoMKgwqDC
oMKgwqAgY29uc3QgdWludDhfdCBhX2ZpZWxkID0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
bXBfZ2V0X2FfZmllbGQoZW52LT5wbXBfc3RhdGUucG1wW2ldLmNmZ19yZWcpOwo+IC0KPiAtwqDC
oMKgwqDCoMKgwqAgaWYgKCgocyArIGUpID09IDIpICYmIChQTVBfQU1BVENIX09GRiAhPSBhX2Zp
ZWxkKSkgewo+ICvCoMKgwqDCoMKgwqDCoCBpZiAocyArIGUgPT0gMikgewo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvKgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogSWYgdGhlIFBN
UCBlbnRyeSBpcyBub3Qgb2ZmIGFuZCB0aGUgYWRkcmVzcyBpcyBpbgo+IHJhbmdlLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogZG8gdGhlIHByaXYgY2hlY2sK


