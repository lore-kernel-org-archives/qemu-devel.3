Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD1D767FA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 19:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6azu-00022W-OC; Thu, 31 Oct 2024 15:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6azp-00021j-Ic
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:38:18 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6azn-0002Lg-Mi
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:38:17 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c693b68f5so14118335ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730403494; x=1731008294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xXnjoSPlgyaqAPGgCHJ0WGtCxE2WQRYJKjYwdj3p1mg=;
 b=w0XLxuSUQtxP6ZHeTRR0ovnrcm2IJiLISBlOeYXgxYuf/aUjFhILyNP7Q3KDrRZK2a
 tN0lM6vlDcTC6i6e+gMvm+gnCCE6schxSvsqbjTUrdGHAy3aY2iWO3DAjsiMVtRoAuEh
 Q+7g6ijseRunq9XDr7Z5yRxHt9qI2nol6iK6YTvBFgZms2kq2dh6zruH8p6qTi5vwz9k
 Yn4X32AsmSI8NLYodrlCpLFB0hGLiVfP7/rrRXOe7AUpzyTcQSeMkNkH5/YPT/qp9Jc/
 YQiBicO2uhTCkg+3pXVWE0Xwtwt+Qyfv+K/608IcOaNRLdirGGebYhuDGADSvUazzfT7
 4xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730403494; x=1731008294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xXnjoSPlgyaqAPGgCHJ0WGtCxE2WQRYJKjYwdj3p1mg=;
 b=amhVe2dWPjn2oFJRY5X29+UCaVDYI2zBGIk18t12ty5djnecD/wDOvgImj99kBsp2t
 rRei3MCh/7hYiF5sKDymjzDzPiFDUO+1STVNOPmUJCS4HJ04eJp3D1e63KHm1EFt7S31
 1w6nxX+VGddsqDc+2dMX1M94Gki1hJio2mTAjSKCeu6nZZIwztAETtP217TrPKrttFj3
 NwWqTb91eeOCL4H/59lq7J6k9PkX3ASzTE4GS4EftzDqNsiM2F8/4yb/QVIkQdQyeP5z
 bf6UGOQgjuj7iedshNEmckihyGA5CUPR+ZvItdIU1z0mUlxY1Cef5d1H0h9mbn9VuI+b
 69Vg==
X-Gm-Message-State: AOJu0YyqCsX0IHwsdNv2HYfZ7WCzcBsGikanzPJLVFPcsjMcwdQpSF9X
 qLY1B1Eg2PvKwGCV3zbNwQW93ExFuA4cVF/DG4VV0KVvEz1+Xp0Uf8Ajt0RRMUA=
X-Google-Smtp-Source: AGHT+IEU5umQciuyc8QqLWwlNm6AJuX0APwP4mgrz4nBD4iJ7KfAUmbJFKF6xHgsUNOrYWk1GIBebA==
X-Received: by 2002:a17:902:db12:b0:20b:b26e:c149 with SMTP id
 d9443c01a7336-21103b1b872mr61177805ad.29.1730403493672; 
 Thu, 31 Oct 2024 12:38:13 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057087dasm12040295ad.85.2024.10.31.12.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 12:38:13 -0700 (PDT)
Message-ID: <862ebf44-765e-4cf9-9e6c-b08420eb6146@linaro.org>
Date: Thu, 31 Oct 2024 12:38:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] docs: add information on how to setup build
 environments
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-13-pierrick.bouvier@linaro.org>
 <ZyNMv46rHcmT8ILm@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ZyNMv46rHcmT8ILm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

T24gMTAvMzEvMjQgMDI6MjQsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+IE9uIFdl
ZCwgT2N0IDMwLCAyMDI0IGF0IDA5OjA0OjI2UE0gLTA3MDAsIFBpZXJyaWNrIEJvdXZpZXIg
d3JvdGU6DQo+PiBNYWNPUyBhbmQgTGludXggYXJlIHN0cmFpZ2h0Zm9yd2FyZCwgYnV0IFdp
bmRvd3MgbmVlZHMgYSBiaXQgbW9yZQ0KPj4gZGV0YWlscy4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+
PiAtLS0NCj4+ICAgZG9jcy9hYm91dC9idWlsZC1wbGF0Zm9ybXMucnN0IHwgICA0ICstDQo+
PiAgIGRvY3MvZGV2ZWwvYnVpbGQtc3lzdGVtLnJzdCAgICB8IDEwMCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4+ICtXaW5kb3dzDQo+PiArLS0tLS0tLQ0K
Pj4gKw0KPj4gK1lvdSBmaXJzdCBuZWVkIHRvIGluc3RhbGwgYE1TWVMyIDxodHRwczovL3d3
dy5tc3lzMi5vcmcvPmBfLg0KPj4gK01TWVMyIG9mZmVycyBgZGlmZmVyZW50IGVudmlyb25t
ZW50cyA8aHR0cHM6Ly93d3cubXN5czIub3JnL2RvY3MvZW52aXJvbm1lbnRzLz5gXy4NCj4+
ICt4ODZfNjQgZW52aXJvbm1lbnRzIGFyZSBiYXNlZCBvbiBHQ0MsIHdoaWxlIGFhcmNoNjQg
aXMgYmFzZWQgb24gQ2xhbmcuDQo+PiArDQo+PiArV2UgcmVjb21tZW5kIHRvIHVzZSBVQ1JU
NjQgZm9yIHdpbmRvd3MteDg2XzY0IGFuZCBDTEFOR0FSTTY0IGZvciB3aW5kb3dzLWFhcmNo
NjQNCj4+ICsob25seSBhdmFpbGFibGUgb24gd2luZG93cy1hYXJjaDY0IGhvc3RzKS4NCj4g
DQo+IEkgZG9uJ3QgYmVsaWV2ZSB3ZSBzaG91bGQgYmUgcmVjb21tZW5kaW5nIHVjcnQ2NCBm
b3Igd2luZG93cy4gV2UgaGF2ZSB0d28NCj4gdGVzdGluZyBqb2JzLCBvbmUgY3Jvc3MgY29t
cGlsZWQgZnJvbSBNaW5ndyBGZWRvcmEsIGFuZCBvbmUgbmF0aXZlIHVuZGVyDQo+IE1zeXMy
LCBib3RoIG9mIHdoaWNoIGFyZSB2YWxpZGF0aW5nIG1pbmd3NjQuIFdlIGhhdmUgbm8gdWNy
dDY0IHRlc3RpbmcuDQo+IElJVUMsIFN0ZWZhbidzIFFFTVUgaW5zdGFsbGVyIGJpbmFyaWVz
IGFyZSBhbHNvIG1pbmd3MzIvbWluZ3c2NCBiYXNlZCwNCj4gbm90IHVjcnQ2NC4NCj4gDQoN
CkkgaGF2ZSBubyBzdHJvbmcgb3BpbmlvbiwgYW5kIHdhcyBqdXN0IGZvbGxvd2luZyBkZWZh
dWx0IHJlY29tbWVuZGF0aW9uIA0Kb2YgTVNZUzIgcHJvamVjdCB0byBzd2l0Y2ggdG8gVUNS
VDY0Lg0KQWxsIG1zeXMyIGVudmlyb25tZW50IHVzZSBtaW5ndzY0LCBidXQgbWluZ3c2NCBj
YW4gdGFyZ2V0IGRpZmZlcmVudCANCndpbmRvd3MgcnVudGltZS4gRnJvbSB3aGF0IEkgdW5k
ZXJzdGFuZCwgYW55IGRpZmZlcmVuY2Ugb3IgYnVnIHdvdWxkIGJlIA0KYSBidWcgZm9yIG1p
bmd3NjQgcHJvamVjdCwgbm90IGZvciB1cy4NCg0KVUNSVCBpcyBub3cgdGhlIGRlZmF1bHQg
dGFyZ2V0IHVzZWQgYnkgbWluZ3c2NCBbMV0uDQpNb3JlIGluZm9ybWF0aW9uIG9uIHRoaXMg
ZGlmZmVyZW5jZSBoZXJlIFsyXS4NCk1pZ3JhdGluZyB0byBVQ1JUNjQgc2VlbXMgdG8gYmUg
dGhlIGJlc3Qgd2F5IGluIHRoZSBmdXR1cmUuDQoNCkFsbCB0aGF0IHNhaWQsIEknbGwgdXBk
YXRlIHRoaXMgcmVjb21tZW5kYXRpb24gdG8gTUlOR1c2NCBmb3IgVjIgb2YgdGhpcyANCnNl
cmllcywNCg0KWzFdIGh0dHBzOi8vd3d3Lm1pbmd3LXc2NC5vcmcvY2hhbmdlbG9nLyN2MTIw
MC0yMDI0LTA1LTI5DQpbMl0gDQpodHRwczovL2dpdGh1Yi5jb20vbWluZ3ctdzY0L21pbmd3
LXc2NC9ibG9iL21hc3Rlci9taW5ndy13NjQtZG9jL2hvd3RvLWJ1aWxkL3VjcnQtdnMtbXN2
Y3J0LnR4dA0KDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQo=

