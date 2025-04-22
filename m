Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B95C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IFG-0007hJ-2K; Tue, 22 Apr 2025 14:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IEu-0007dg-Gy
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:21:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IEo-0008FZ-RK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:20:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so4722221b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745346052; x=1745950852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7tg38it30oflvZKbM/Z9q9BINNmKF+dBclRKHu7o7uk=;
 b=SUFAvFg14Te/zubrgXUtEUvrcpA5QuIYpT4yQpe9UPdt0Ne2Q6DBuvllaEDOSLdMr5
 FogvAI2Lm1eEo9vJXE6Aiu3zBDb0pcaO51nA4gwF6MEuxRrwNyHGJbJIKSkaCZ/mu/82
 kiP+tnT/XmXLvsMzExGrqHqQBR3UuahixwzdNgQnEZ88bPBCtYGg8YB4hBmRylQfm1D0
 Aj/TfQKlZcnenF5m9bLr9dhaZ3o/h/fdh0CLwgjyNBXRgW0+KAGoc8BDhgiIg9v5E+rN
 Bejvhe2DYPpE5mrQAhhHqVowCChlES+Goh68zGSaKnPs4D3s5ADYD28DuReD1PZKzyRA
 mdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346052; x=1745950852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7tg38it30oflvZKbM/Z9q9BINNmKF+dBclRKHu7o7uk=;
 b=JFvdMHk2ZBysIuFKVvZpOfEza/c+OZSPZ5rOAASA29mdgYrNat7u7q0P3g28NACNrx
 Q9A1PMFpHkXi0M+vOQ6Chx3RbLvu6VT0j+YsMsy2ruZ5XWHNAVYMtFR6d9jXYbTFDLvf
 59Z52iAVfxo8X7S9R3fUVor3n2TjoQiCpyio1isqGK9Sj3EUSXpvy9rtKBE1H96B0xVD
 9oqXoep3VLnXXdO9C4h1mPHl76VynxlhsixdlyAhK35Y81VhIwX889MjsNN/TFV+5rrE
 biM5K933BKaVcyLpOHB5THWBG/SqG7eXM6lxjcnCr8ydujb6+PiQM0dAzlTQzyu0U9ic
 j/jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsQh9uDj5WrAl3Qk/gD7vhsBVulao30+ZRkHgrz9QGYxRXSEq2KXRIow8XqPniEssuQ3rt57+Q9qX/@nongnu.org
X-Gm-Message-State: AOJu0YyNAoGp6jDlVePX+RnxQZFqhvx0LI3/U3JSJBHXsHGSlwrnIhSW
 ycLuch/RgJDxUmOpF2guQQb2Rx2A5l0hcg3AeEE1AtGyqj5efjmJs3RUB5RUJ2U=
X-Gm-Gg: ASbGnct0t54bZGhlMbIbrhcVA3ebKVkgA4sC/GMmGoELY9ZzkMQy7ahytkgDCB2ARtX
 fxJZtV4K2xxPmkmzIB7TKfhNw5NlOtRy35fYUBxyebLiXEWcL1ZHmemjvJQ8ghcWmFm0tsSd6VV
 hpQz731nX3Q+cxa7HSKpG7RRe4m5oikc1plfipqGo7dxGqE+caytQQ+57PKsqb+jIMbkpuVoWq4
 SriZaYiy4+KqMyMkvP65fPYSlyUyHyIVNAyX8ELHmTGxd0sPDbN0iyzDE8xcfGwdwXumJ4ErrKl
 CUee+/Q5UfKlVL/hUvGcykL0WE+WcneWCr1UCMP7NWT3tvLNJkcCSq3lefYkYk2y
X-Google-Smtp-Source: AGHT+IEtBN9oD9DAQHf8H/FpRuryU3vwSwSONXybPt4eynUsxMCdjHOvoHtMHwqP0Pm0hGNub6FJ1g==
X-Received: by 2002:a05:6a00:1886:b0:736:51ab:7ae1 with SMTP id
 d2e1a72fcca58-73dc156b0ecmr20179779b3a.16.1745346051717; 
 Tue, 22 Apr 2025 11:20:51 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa595e4sm8970345b3a.88.2025.04.22.11.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:20:51 -0700 (PDT)
Message-ID: <cc5114fe-c17d-4e02-96f2-135ee1c7fa09@linaro.org>
Date: Tue, 22 Apr 2025 11:20:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422145502.70770-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

T24gNC8yMi8yNSAwNzo1NCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFNp
Z25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9y
Zz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9xZW11L3RhcmdldC1pbmZvLWltcGwuaCAgIHwgNCAr
KysrDQo+ICAgY29uZmlncy90YXJnZXRzL2FhcmNoNjQtc29mdG1tdS5jIHwgMSArDQo+ICAg
Y29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmMgICAgIHwgMSArDQo+ICAgdGFyZ2V0LWlu
Zm8tc3R1Yi5jICAgICAgICAgICAgICAgIHwgMSArDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvdGFyZ2V0
LWluZm8taW1wbC5oIGIvaW5jbHVkZS9xZW11L3RhcmdldC1pbmZvLWltcGwuaA0KPiBpbmRl
eCA0ZWY1NGM1MTM2YS4uZTVjZDE2OWI0OWEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvcWVt
dS90YXJnZXQtaW5mby1pbXBsLmgNCj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldC1pbmZv
LWltcGwuaA0KPiBAQCAtMTAsMTIgKzEwLDE2IEBADQo+ICAgI2RlZmluZSBRRU1VX1RBUkdF
VF9JTkZPX0lNUExfSA0KPiAgIA0KPiAgICNpbmNsdWRlICJxZW11L3RhcmdldC1pbmZvLmgi
DQo+ICsjaW5jbHVkZSAicWFwaS9xYXBpLXR5cGVzLW1hY2hpbmUuaCINCj4gICANCj4gICB0
eXBlZGVmIHN0cnVjdCBUYXJnZXRJbmZvIHsNCj4gICANCj4gICAgICAgLyogcnVudGltZSBl
cXVpdmFsZW50IG9mIFRBUkdFVF9OQU1FIGRlZmluaXRpb24gKi8NCj4gICAgICAgY29uc3Qg
Y2hhciAqY29uc3QgdGFyZ2V0X25hbWU7DQo+ICAgDQo+ICsgICAgLyogcmVsYXRlZCB0byBU
QVJHRVRfQVJDSCBkZWZpbml0aW9uICovDQo+ICsgICAgU3lzRW11VGFyZ2V0IHRhcmdldF9h
cmNoOw0KPiArDQo+ICAgICAgIC8qIFFPTSB0eXBlbmFtZSBtYWNoaW5lcyBmb3IgdGhpcyBi
aW5hcnkgbXVzdCBpbXBsZW1lbnQgKi8NCj4gICAgICAgY29uc3QgY2hhciAqY29uc3QgbWFj
aGluZV90eXBlbmFtZTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvdGFyZ2V0cy9h
YXJjaDY0LXNvZnRtbXUuYyBiL2NvbmZpZ3MvdGFyZ2V0cy9hYXJjaDY0LXNvZnRtbXUuYw0K
PiBpbmRleCAzNzVlNmZhMGI3Yi4uZmY4OTQwMWVhMzQgMTAwNjQ0DQo+IC0tLSBhL2NvbmZp
Z3MvdGFyZ2V0cy9hYXJjaDY0LXNvZnRtbXUuYw0KPiArKysgYi9jb25maWdzL3RhcmdldHMv
YWFyY2g2NC1zb2Z0bW11LmMNCj4gQEAgLTEzLDYgKzEzLDcgQEANCj4gICANCj4gICBzdGF0
aWMgY29uc3QgVGFyZ2V0SW5mbyB0YXJnZXRfaW5mb19hYXJjaDY0X3N5c3RlbSA9IHsNCj4g
ICAgICAgLnRhcmdldF9uYW1lID0gImFhcmNoNjQiLA0KPiArICAgIC50YXJnZXRfYXJjaCA9
IFNZU19FTVVfVEFSR0VUX0FBUkNINjQsDQo+ICAgICAgIC5tYWNoaW5lX3R5cGVuYW1lID0g
VFlQRV9UQVJHRVRfQUFSQ0g2NF9NQUNISU5FLA0KPiAgIH07DQo+ICAgDQo+IGRpZmYgLS1n
aXQgYS9jb25maWdzL3RhcmdldHMvYXJtLXNvZnRtbXUuYyBiL2NvbmZpZ3MvdGFyZ2V0cy9h
cm0tc29mdG1tdS5jDQo+IGluZGV4IGQ0YWNkYWU2NGYzLi4yMmVjOWU0ZmFhMyAxMDA2NDQN
Cj4gLS0tIGEvY29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmMNCj4gKysrIGIvY29uZmln
cy90YXJnZXRzL2FybS1zb2Z0bW11LmMNCj4gQEAgLTEzLDYgKzEzLDcgQEANCj4gICANCj4g
ICBzdGF0aWMgY29uc3QgVGFyZ2V0SW5mbyB0YXJnZXRfaW5mb19hcm1fc3lzdGVtID0gew0K
PiAgICAgICAudGFyZ2V0X25hbWUgPSAiYXJtIiwNCj4gKyAgICAudGFyZ2V0X2FyY2ggPSBT
WVNfRU1VX1RBUkdFVF9BUk0sDQo+ICAgICAgIC5tYWNoaW5lX3R5cGVuYW1lID0gVFlQRV9U
QVJHRVRfQVJNX01BQ0hJTkUsDQo+ICAgfTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC1pbmZvLXN0dWIuYyBiL3RhcmdldC1pbmZvLXN0dWIuYw0KPiBpbmRleCAyMThlNTg5OGU3
Zi4uZTU3M2Y1YzE5NzUgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC1pbmZvLXN0dWIuYw0KPiAr
KysgYi90YXJnZXQtaW5mby1zdHViLmMNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gICANCj4g
ICBzdGF0aWMgY29uc3QgVGFyZ2V0SW5mbyB0YXJnZXRfaW5mb19zdHViID0gew0KPiAgICAg
ICAudGFyZ2V0X25hbWUgPSBUQVJHRVRfTkFNRSwNCj4gKyAgICAudGFyZ2V0X2FyY2ggPSAt
MSwNCg0KSSB0aGluayB3ZSBzaG91bGQgaGF2ZSBhIGZ1bGwgaWZkZWYgbGFkZGVyIGhlcmUs
IHRvIGhhbmRsZSBhbGwgDQphcmNoaXRlY3R1cmVzLiBTZXR0aW5nIC0xIGlzIG5vdCBhIHNh
ZmUgZGVmYXVsdC4NCg0KPiAgICAgICAubWFjaGluZV90eXBlbmFtZSA9IFRZUEVfTUFDSElO
RSwNCj4gICB9Ow0KPiAgIA0KDQo=

