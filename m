Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A390DCFA47E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 21:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ixR-0003lf-9U; Wed, 23 Oct 2024 17:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3ixK-0003kU-JN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:31:54 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3ixI-00082U-6L
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:31:49 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso144061a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729719107; x=1730323907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XMV66Tma+m+DyNkwDKnD2R7rJWyhw+6KbQDPG90Lh9o=;
 b=WhYJLhI7NkvYbyIPAu9rUF9zpw6GNz0rTIg5gKiSKnQNmwQgto2hn0vG1xbJCdzi2Q
 6+crZMKcEvbpq+QiqXUw7quxq3nSPGYMK+tz164XGLAVxCPNVPty9WGCeBIL6JfBVNJ0
 C5jxlUqZ2D1EM62Eo5Z/suZnDgE+pFgo279c0AZuU2u/AG4g7xmqN3mHcBhZeI5gQ2Yu
 WFIV0qKDvEx+e2BgtRfm31ubxPDR9lXQOSBaQ3jLi7fvcRuFG/mHhiAo2yR7nwi8BL0m
 lRxuoDNEU91vXFU5lZhFEhukG80XJre+fGhAMl5aUnLHHL0dV6lAkeZdgxDOUY6rEZZA
 d6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729719107; x=1730323907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XMV66Tma+m+DyNkwDKnD2R7rJWyhw+6KbQDPG90Lh9o=;
 b=GuLZJuLObFMNxlZNLzH0pU/2KdSehZZ5cvUoft4vloqcQ0z3sXq5WqJtCULIHltuF+
 ISAKPqcqwg9WbLFru7rPxmm9KwFJCHDNX0T3j+iewknBHAblZtB36RzDR5/a/D4VMEU7
 AOgmuDO4G1F/Yo0Xbx9P//h0LcUSj1PHKIXEBIeW/mvneC2HFvV+9FFOE1ATe/HWigv/
 jCpAJ+bH4jGNggCRFCxHKZjHyXMzeQL0+8wn4p9rJHPIgXaYxBN2g846aw+CFXGV3jBw
 gG/hqF8MGk35vuqKYLtv45LVNtAPusT81fY2I281aSBoTQCOZ1uc1S1JCIvwmLmFRfHD
 XVew==
X-Gm-Message-State: AOJu0YyVyriPyaGakZKKEBy1eva6P3VBh7B1meMT5wVIwDrWdFuvVPjp
 7OPuYBejjwTjlEo9NxMlWdgsIR9FMccSgBfHaFxxoXALp7Mpzr6GJboa3omr6Ww=
X-Google-Smtp-Source: AGHT+IECIPlif+Tu0yu3XBicCEMHLEOzNPxUBgiSXihwbTu2CDR+24J+6/0XGCXXFNeLSWMcYXUV8g==
X-Received: by 2002:a05:6a21:6b0c:b0:1d9:78c:dcf2 with SMTP id
 adf61e73a8af0-1d978bd32cdmr5191354637.43.1729719106774; 
 Wed, 23 Oct 2024 14:31:46 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaec52dd6csm6230401a12.4.2024.10.23.14.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 14:31:46 -0700 (PDT)
Message-ID: <202cd5e2-3732-479d-ab02-67061e2114cc@linaro.org>
Date: Wed, 23 Oct 2024 14:31:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] meson: build contrib/plugins with meson
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-19-alex.bennee@linaro.org>
 <fe33c996-3241-4706-9ac1-85f00cb8f388@linaro.org>
 <87sesnkxhm.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87sesnkxhm.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

T24gMTAvMjMvMjQgMDE6NTcsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gT24g
MTAvMjIvMjQgMDM6NTYsIEFsZXggQmVubsOpZSB3cm90ZToNCj4+PiBGcm9tOiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4gVHJpZWQgdG8g
dW5pZnkgdGhpcyBtZXNvbi5idWlsZCB3aXRoIHRlc3RzL3RjZy9wbHVnaW5zL21lc29uLmJ1
aWxkDQo+Pj4gYnV0DQo+Pj4gdGhlIHJlc3VsdGluZyBtb2R1bGVzIGFyZSBub3Qgb3V0cHV0
IGluIHRoZSByaWdodCBkaXJlY3RvcnkuDQo+Pj4gT3JpZ2luYWxseSBwcm9wb3NlZCBieSBB
bnRvbiBLb2Noa292LCB0aGFuayB5b3UhDQo+Pj4gU29sdmVzOiBodHRwczovL2dpdGxhYi5j
b20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMTcxMA0KPj4+IFNpZ25lZC1vZmYtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+PiBN
ZXNzYWdlLUlkOiA8MjAyNDA5MjUyMDQ4NDUuMzkwNjg5LTItcGllcnJpY2suYm91dmllckBs
aW5hcm8ub3JnPg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5u
ZWVAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+PiAgICBtZXNvbi5idWlsZCAgICAgICAgICAg
ICAgICAgfCAgNCArKysrDQo+Pj4gICAgY29udHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkIHwg
MjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDI3
IGluc2VydGlvbnMoKykNCj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgY29udHJpYi9wbHVn
aW5zL21lc29uLmJ1aWxkDQo+Pj4gZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVzb24u
YnVpbGQNCj4+PiBpbmRleCBiZGQ2N2EyZDZkLi4zZWEwM2M0NTFiIDEwMDY0NA0KPj4+IC0t
LSBhL21lc29uLmJ1aWxkDQo+Pj4gKysrIGIvbWVzb24uYnVpbGQNCj4+PiBAQCAtMzY3OCw2
ICszNjc4LDEwIEBAIHN1YmRpcignYWNjZWwnKQ0KPj4+ICAgIHN1YmRpcigncGx1Z2lucycp
DQo+Pj4gICAgc3ViZGlyKCdlYnBmJykNCj4+PiAgICAraWYgJ0NPTkZJR19UQ0cnIGluIGNv
bmZpZ19hbGxfYWNjZWwNCj4+PiArICBzdWJkaXIoJ2NvbnRyaWIvcGx1Z2lucycpDQo+Pj4g
K2VuZGlmDQo+Pj4gKw0KPj4+ICAgIGNvbW1vbl91c2VyX2luYyA9IFtdDQo+Pj4gICAgICBz
dWJkaXIoJ2NvbW1vbi11c2VyJykNCj4+PiBkaWZmIC0tZ2l0IGEvY29udHJpYi9wbHVnaW5z
L21lc29uLmJ1aWxkIGIvY29udHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkDQo+Pj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAwLi5hMGUwMjZkMjVlDQo+Pj4g
LS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBiL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZA0K
Pj4+IEBAIC0wLDAgKzEsMjMgQEANCj4+PiArdCA9IFtdDQo+Pj4gK2lmIGdldF9vcHRpb24o
J3BsdWdpbnMnKQ0KPj4+ICsgIGZvcmVhY2ggaSA6IFsnY2FjaGUnLCAnZHJjb3YnLCAnZXhl
Y2xvZycsICdob3RibG9ja3MnLCAnaG90cGFnZXMnLCAnaG93dmVjJywNCj4+PiArICAgICAg
ICAgICAgICAgJ2h3cHJvZmlsZScsICdpcHMnLCAnbG9ja3N0ZXAnLCAnc3RvcHRyaWdnZXIn
XQ0KPj4NCj4+IGxvY2tzdGVwIGRvZXMgbm90IGJ1aWxkIHVuZGVyIFdpbmRvd3MgKGl0IHVz
ZXMgc29ja2V0cyksIHNvIGl0IHNob3VsZA0KPj4gYmUgY29uZGl0aW9ubmFsbHkgbm90IGJ1
aWx0IG9uIHRoaXMgcGxhdGZvcm0uDQo+PiBAQWxleCwgaWYgeW91IGZlZWwgbGlrZSBtb2Rp
ZnlpbmcgdGhpcywgeW91IGNhbi4gSWYgbm90LCB5b3UgY2FuIGRyb3ANCj4+IHRoZSBtZXNv
biBidWlsZCBwYXRjaGVzIGZyb20gdGhpcyBzZXJpZXMgdG8gbm90IGJsb2NrIGl0Lg0KPiAN
Cj4gSSdsbCBkcm9wIGZyb20gdGhlIFBSIGFuZCBsZXQgeW91IHJlLXN1Ym1pdC4NCj4gDQoN
ClNlbnQgYSB2MyB3aXRoIHdpbmRvd3MgZml4Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8yMDI0MTAyMzIxMjgxMi4xMzc2OTcyLTEtcGllcnJpY2suYm91dmllckBs
aW5hcm8ub3JnL1QvI3QNCg0KVGhhbmtzLA0KUGllcnJpY2sNCg==

