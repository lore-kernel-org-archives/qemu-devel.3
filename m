Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0441C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsYu-0001op-K5; Tue, 11 Aug 2026 15:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsYs-0001ia-CY; Tue, 11 Aug 2026 15:54:58 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsYq-00088L-Nn; Tue, 11 Aug 2026 15:54:58 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id A5086EC0081;
 Tue, 11 Aug 2026 15:54:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 15:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478095; x=1786564495; bh=7WxfSBYkMnaHyZKtq9R2D41fWRnkGWgy
 1ZNLOoAtvZA=; b=m6M6t5TjXNFW/uWS8u7NrQAHvmD2SHSXpg6hdYK/HnSB1n2S
 5v7RbOMh+/icIQ6L60hN4f9DrMlWXHHPlbtsmsCugkJ8EEYRyUiUF7n+OGApXNq6
 +Hy/Ob7KodxoABj+XdqPvzaSPgzKPH8VMqnDTGFJ9tVaaM6WBbMZAKMcMYA1VdE2
 Q1Cctx3Wp3ar8Vm6P8iA2zs6UnLI/aHcf9aGYsx9u1nRr/DnQ2gorFEUptSHjnRn
 tGG/iKETRT09AEQMx+el3cBoAWJdvjpCPk2ivte3Od13MYU/kVeZYyrjVsOfh2qr
 Dud0mh4ITmKdns6YwYaUe+mBfj75i7RLgARP9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478095; x=
 1786564495; bh=7WxfSBYkMnaHyZKtq9R2D41fWRnkGWgy1ZNLOoAtvZA=; b=A
 GHkpINBQ51OPM8EhdRrRcOhiGgDYKZWSYwDmDSVDc+UBWy8f9O4D1FxrUQ5qJmRv
 EcWzZexXMuYo5nG3kasq1GAKKJShvB9EnhuEeOBL0VZaOhGOF0yxlx9edqT66Eeq
 WBgsIuYP0MorN0PIubynLe/DuBCOS56NOEovwH69s/4CKaluqkfha5kLQdoeNmSS
 JQlF/k6TgAIM+ZQvsCTnH0AQdvKesaGPLMuiGTNU+BKrwTaTvw8XW8WfCdUZFjfX
 L1XKbhBO3Vf2RVIro86Y/9GvznPjVettVg7/eDvvvE/HySXyA+bELHWUn4IwWhSK
 ogxQEfYgtPBWPUE57ERuA==
X-ME-Sender: <xms:D357atYlwxAsJS092cgREkeOvCCfPOUbNRU5NQKRbp7ZX7_DtSNoIQ>
 <xme:D357avV-jXtSjmU0XuT65yjAN2ZcppUw7gnHknJtX1-aCD6ILyn0oSiAyHHGwCxPy
 -KylMOKkuL2OvysIk9ooYLxKpNV6zM0jDelTLtqaD_FisDPrSAqQ3I>
X-ME-Received: <xmr:D357au-iM0kVjkI6rmiYnET6slMrVzsfuwg6KZd7LGj4otp8ngCmXprCvAFa5OtaUlAS6A>
X-ME-Proxy-Cause: dmFkZTGBbbehFR9qf1hwLDlQe7R66VOje335Hk9fGmcv6vHGsJWgWYMhnJLf8QvAFe62YX
 qAXWvvWkPN+LH9TuDsj6+EoLC1k2LnA8InLrB6TzsGLJ11F5ja1Bg3ElTpanFSMecQtUIG
 mMgRSRArb15w411+z5M68lX7jqIGfsOSaJYtdVRYwwdVWDypQPMTqziSrdf9Lx0K3FQrIf
 sXh0qElZVsDXw1ELOF6SzBGJEIxveSTZ0PaHv3Iyeor0d0FhYBuiYZ2pHGmANwfeJ7Go1Y
 ZRVHhp7WqQMUrtTuAFpUWuqkPcMWTYQl5ZlMmJnxT+aoBFTRs6f1rjsdPBuyMkhRUiFAAh
 91m47X7XelJcd4b9SWSPZgo5cClN/u6OzpJqdA/idAajTe7XVkpoUELMnlcHL7LH1CSprY
 XVydqcbE7rUZ1o/XA2cZ8NEkPyv3zRQUf4I+3mAw+rp6BYmwUWMiZzUJtYPcfVM6yKBAa7
 jUV56cvxCtaWzN6Ib84W+S4TASuR5xr7jfyGmAan46872Xnq4ZVmBFDfSWLc5VafFJBn7V
 0NOTRcQMfMLGGJXOdEBn5fcIx8zZYu2v4flGrSNrQqnhlLjIcAu3C5ntATkG8lEkaBEeYU
 WnHpuFOgz9x0V2FAbdiMISavJWcsd6mYzhFui9ckyN581hFK8ubHIUf/m3yA
X-ME-Proxy: <xmx:D357ag8egQT3VJV6O2uBeqXyvbG8K6F2VMkzjn_wsxAQpicK4jVSdw>
 <xmx:D357amQiE49rs4yAfhwXSnQVVVWclV2BkjQ3fUxog_Hr3FifyXpzJA>
 <xmx:D357asfq6hYCYTfbGDp6petH63cJ2o0HvTCQfPamCmmNm395KmGLMA>
 <xmx:D357aiCVHRrmh36WO2XlTghBor4iK_o3IHLvDfuH52UJPAGSKYSHdQ>
 <xmx:D357auIwVOEa1F2n7CUkL24ndvrutQ1Iyh4O9l4KC1dd8E94W12NLRgO>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:54:55 -0400 (EDT)
Message-ID: <12bcf0347d20ad31bddfe7b9d37120310955fc05.camel@alistair23.me>
Subject: Re: [PATCH 01/56] disas/riscv: Fix th.srri decoding
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 05:54:55 +1000
In-Reply-To: <20260809223545.730664-2-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
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

T24gU3VuLCAyMDI2LTA4LTA5IGF0IDE1OjM0IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBGcm9tOiBUQU5HIFRpYW5jaGVuZyA8bHluZHJhQGxpbnV4LmFsaWJhYmEuY29tPgo+IAo+
IHRhcmdldC9yaXNjdi94dGhlYWQuZGVjb2RlIGRlZmluZXMgdGguc3JyaSBhcyBmdW5jdDY9MDAw
MTAwIGluCj4gYml0cyAzMToyNiwgd2l0aCB0aGUgNi1iaXQgaW1tZWRpYXRlIGluIGJpdHMgMjU6
MjAuCj4gCj4gZGVjb2RlX3h0aGVhZGJiKCkgc3dpdGNoZXMgb24gYml0cyAzMToyNSwgaS5lLiBm
dW5jdDYgcGx1cyBpbW1bNV0uCj4gVGhlcmVmb3JlIHZhbGlkIHRoLnNycmkgZW5jb2RpbmdzIGFy
ZSAwMDAxMDAwIGFuZCAwMDAxMDAxLiBUaGUKPiBjdXJyZW50IDAwMDAxMDAgYW5kIDAwMDAxMDEg
Y2FzZXMgdXNlIHRoZSB3cm9uZyBmdW5jdDYgdmFsdWUgYW5kCj4gZGVjb2RlIHZhbGlkIHRoLnNy
cmkgaW5zdHJ1Y3Rpb25zIGFzIGlsbGVnYWwuCj4gCj4gRml4IHRoZSBjYXNlcyB0byBtYXRjaCBm
dW5jdDY9MDAwMTAwIHdpdGggYm90aCBpbW1bNV0gdmFsdWVzLgo+IAo+IEZpeGVzOiAzMThkZjcy
MzhiOWYgKCJkaXNhcy9yaXNjdjogQWRkIHN1cHBvcnQgZm9yIFhUaGVhZCoKPiBpbnN0cnVjdGlv
bnMiKQo+IFNpZ25lZC1vZmYtYnk6IFRBTkcgVGlhbmNoZW5nIDxseW5kcmFAbGludXguYWxpYmFi
YS5jb20+Cj4gUmV2aWV3ZWQtYnk6IExJVSBaaGl3ZWkgPHpoaXdlaV9saXVAbGludXguYWxpYmFi
YS5jb20+Cj4gUmV2aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phCj4gPGRhbmllbC5i
YXJib3phQG9zcy5xdWFsY29tbS5jb20+Cj4gTWVzc2FnZS1JZDoKPiA8MjAyNjA3MDMtYjQtZGlz
YXMteHRoZWFkLWZpeC1yaXNjdi1uZXh0LXY0LTEtODRjNTY2MzMwYmM3QGxpbnV4LmFsaWIKPiBh
YmEuY29tPgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNA
d2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgZGlzYXMvcmlzY3YteHRoZWFkLmMgfCA2ICsr
KystLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvZGlzYXMvcmlzY3YteHRoZWFkLmMgYi9kaXNhcy9yaXNjdi14dGhl
YWQuYwo+IGluZGV4IGZjY2EzMjZkMWMuLjJmMmRkYjhkZDkgMTAwNjQ0Cj4gLS0tIGEvZGlzYXMv
cmlzY3YteHRoZWFkLmMKPiArKysgYi9kaXNhcy9yaXNjdi14dGhlYWQuYwo+IEBAIC0zMTUsOCAr
MzE1LDEwIEBAIHZvaWQgZGVjb2RlX3h0aGVhZGJiKHJ2X2RlY29kZSAqZGVjLCBydl9pc2EgaXNh
KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcCA9
IHJ2X29wX3RoX3Jldnc7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMGIwMDAwMTAwOgo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAwYjAwMDAxMDE6IG9wID0gcnZfb3BfdGhfc3Jy
aTsgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDBiMDAwMTAw
MDoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMGIwMDAxMDAxOgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcCA9IHJ2X29wX3RoX3Nycmk7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAyOiBvcCA9IHJ2
X29wX3RoX2V4dDsgYnJlYWs7Cg==


