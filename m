Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FB4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 03:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5c5J-0005oT-Gm; Thu, 17 Apr 2025 23:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5c5B-0005nu-Td
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:08:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5c59-0001cV-Kc
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:08:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224171d6826so22688285ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 20:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744945678; x=1745550478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qhuGnmDq3R/KW4PDRSBhOsiny8S8Xs1VDjrREZ8Dqmk=;
 b=CTrOx4wuXjpgFXHMwYRiczPqP3mqQ7cvDgQ2DeNlwC+LFRN1tUhRKjJeE57S3kHei+
 1pE/5r2m3WjYADR3hyEfw1jhDC496GcAAd8M2MePI/Wt4fqfgoGf7QSCb2rqoPI64otL
 bu1cIdusG7bNEQp7p7BbOZVv6xkemfL08cx4fHAD2W1uNlDDLGI0vnUSLHZYv/Q55Mgd
 iKa8DLDg/rv8JQtr8s/Z2loULfree4L8237yax0E9LlFXwNIalgUJuMK0143bv9hJE1E
 7TuUU7FXu0nmGv7P2QWWSgW54x4qmNq7qupqolJ1gqDddI0BR/xeRAv2b+aNy6iRRysO
 lF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744945678; x=1745550478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qhuGnmDq3R/KW4PDRSBhOsiny8S8Xs1VDjrREZ8Dqmk=;
 b=gUL5HKwBWvquzf+StWSa3Ux8WHG6HUAgUCncvfVOxJ2z4x+73J1lLKAaDVFLfx2POg
 SNNQwlJWIWlpYi1lH3HZJXUwGASu7KfExfQNvOddELrpaby0zgRCvHgTKLtARCARh5Ar
 mdbzl9vtVqRPkJTgykMPysgl0fqJyKksAskPxNh9KeHnW5H8XGJIrhF36mYVKcrpYw7U
 95LojvHAVSjRK6wpAsJpwodCsDt/voP73Yxb5ggmZ6qFuJhIjj5sLtTcNx8OmYKFYc1y
 zNSF5LERdqiyQhHMv7LjjGVBTEzbU7fIzKnulumPCpvFRgCRohGzB9FbUGwkkPrkoGry
 61NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0eO0XiYv7IwWo2HW2CpSwQjIEP/F5aKfxkxHI2F7gPMJtFBB39D38gdUT2rTdgzMdCyeeDdCKTrie@nongnu.org
X-Gm-Message-State: AOJu0YxqHWECdLBD8fcaRs2U5lBcEe+uoBbP8ql7b4m4zIZUkv1D9PTU
 iQ2Mcp32g3thPUwQ0aSV/xy6L/EyozlMMUqM0d0EWlDP7kokwPduqKt3yPGgOzw87gmg75U1xNn
 H
X-Gm-Gg: ASbGncvD88vt2nFI9dfyaeCuccK4ElzrHOTiDk4/PCP+o0Sk6rONcVTigMcBfDaaQLT
 EYBGySSOdZ0r2fUh90n/TuJDxYyXXsuhRqIPQGwk8JzV0+O4TSRUvoaOs4NrFCMl/tZiU2LiZaD
 iijXhRMvkL/FQUnAWTNS8wTFCPCCYC9pag8qr4ll8rLpyDMgweJvIfwjQdk86fzUJwIf9uFDuAk
 GcoZGNRCV1FfeHYGimAve+9EkoLP30gHzldpviHOLpKBJOvsOHVhwtHqzNdET1PzNi50rE2sCze
 9KAK+psR6H68LLtOIJYhOpogsKkh/v54PRwf3xe/Au+bKlsq3mPfrw==
X-Google-Smtp-Source: AGHT+IEm/PgnZA5adD4gqsafNw/Q4/8HIEQSttIUNjN5KRVTBiCAck4Dk3FVEq3z9YKFIpRUwp9taA==
X-Received: by 2002:a17:902:ce11:b0:223:f639:69df with SMTP id
 d9443c01a7336-22c53605f6amr22696465ad.41.1744945677930; 
 Thu, 17 Apr 2025 20:07:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf3eb1sm7892965ad.82.2025.04.17.20.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 20:07:57 -0700 (PDT)
Message-ID: <ac98a60e-fa76-4460-a9fa-6f95dd35814d@linaro.org>
Date: Thu, 17 Apr 2025 20:07:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/11] hw/arm: Register TYPE_TARGET_ARM/AARCH64_CPU
 QOM interfaces
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418005059.4436-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gNC8xNy8yNSAxNzo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IERl
ZmluZSB0aGUgVFlQRV9UQVJHRVRfQVJNX01BQ0hJTkUgYW5kIFRZUEVfVEFSR0VUX0FBUkNI
NjRfTUFDSElORQ0KPiBRT00gaW50ZXJmYWNlIG5hbWVzIHRvIGFsbG93IG1hY2hpbmVzIHRv
IGltcGxlbWVudCB0aGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBtZXNvbi5idWlsZCAg
ICAgICAgICAgICAgICAgICAgfCAgMSArDQo+ICAgaW5jbHVkZS9ody9ib2FyZHMuaCAgICAg
ICAgICAgIHwgIDEgKw0KPiAgIGluY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1xb20uaCB8IDE4
ICsrKysrKysrKysrKysrKysrKw0KPiAgIHRhcmdldF9pbmZvLXFvbS5jICAgICAgICAgICAg
ICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwg
NDQgaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3FlbXUv
dGFyZ2V0X2luZm8tcW9tLmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0X2luZm8t
cW9tLmMNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkDQo+
IGluZGV4IDQ5YTA1MGEyOGEzLi4xNjhiMDdiNTg4NyAxMDA2NDQNCj4gLS0tIGEvbWVzb24u
YnVpbGQNCj4gKysrIGIvbWVzb24uYnVpbGQNCj4gQEAgLTM4MDgsNiArMzgwOCw3IEBAIGNv
bW1vbl9zcy5hZGQocGFnZXZhcnkpDQo+ICAgc3BlY2lmaWNfc3MuYWRkKGZpbGVzKCdwYWdl
LXRhcmdldC5jJywgJ3BhZ2UtdmFyeS10YXJnZXQuYycpKQ0KPiAgIA0KPiAgIGNvbW1vbl9z
cy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLmMnKSkNCj4gK3N5c3RlbV9zcy5hZGQoZmlsZXMo
J3RhcmdldF9pbmZvLXFvbS5jJykpDQo+ICAgc3BlY2lmaWNfc3MuYWRkKGZpbGVzKCd0YXJn
ZXRfaW5mby1zdHViLmMnKSkNCj4gICANCj4gICBzdWJkaXIoJ2JhY2tlbmRzJykNCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvYm9hcmRzLmggYi9pbmNsdWRlL2h3L2JvYXJkcy5oDQo+
IGluZGV4IDAyZjQzYWM1ZDRkLi5iMWJiZjNjMzRkNCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9ody9ib2FyZHMuaA0KPiArKysgYi9pbmNsdWRlL2h3L2JvYXJkcy5oDQo+IEBAIC03LDYg
KzcsNyBAQA0KPiAgICNpbmNsdWRlICJzeXN0ZW0vaG9zdG1lbS5oIg0KPiAgICNpbmNsdWRl
ICJzeXN0ZW0vYmxvY2tkZXYuaCINCj4gICAjaW5jbHVkZSAicWFwaS9xYXBpLXR5cGVzLW1h
Y2hpbmUuaCINCj4gKyNpbmNsdWRlICJxZW11L3RhcmdldF9pbmZvLXFvbS5oIg0KPiAgICNp
bmNsdWRlICJxZW11L21vZHVsZS5oIg0KPiAgICNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+
ICAgI2luY2x1ZGUgImh3L2NvcmUvY3B1LmgiDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Fl
bXUvdGFyZ2V0X2luZm8tcW9tLmggYi9pbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8tcW9tLmgN
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAuLjdlYjliNmJk
MjU0DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZv
LXFvbS5oDQo+IEBAIC0wLDAgKzEsMTggQEANCj4gKy8qDQo+ICsgKiBRRU1VIGJpbmFyeS90
YXJnZXQgQVBJIChRT00gdHlwZXMpDQo+ICsgKg0KPiArICogIENvcHlyaWdodCAoYykgTGlu
YXJvDQo+ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXINCj4gKyAqLw0KPiArDQo+ICsjaWZuZGVmIFFFTVVfVEFSR0VUX0lORk9fUU9NX0gN
Cj4gKyNkZWZpbmUgUUVNVV9UQVJHRVRfSU5GT19RT01fSA0KPiArDQo+ICsjZGVmaW5lIFRZ
UEVfVEFSR0VUX0FSTV9NQUNISU5FIFwNCj4gKyAgICAgICAgInRhcmdldC1pbmZvLWFybS1t
YWNoaW5lIg0KPiArDQo+ICsjZGVmaW5lIFRZUEVfVEFSR0VUX0FBUkNINjRfTUFDSElORSBc
DQo+ICsgICAgICAgICJ0YXJnZXQtaW5mby1hYXJjaDY0LW1hY2hpbmUiDQo+ICsNCj4gKyNl
bmRpZg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0X2luZm8tcW9tLmMgYi90YXJnZXRfaW5mby1x
b20uYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMC4uZDNm
ZWU1NzM2MWINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90YXJnZXRfaW5mby1xb20uYw0K
PiBAQCAtMCwwICsxLDI0IEBADQo+ICsvKg0KPiArICogUUVNVSBiaW5hcnkvdGFyZ2V0IEFQ
SSAoUU9NIHR5cGVzKQ0KPiArICoNCj4gKyAqICBDb3B5cmlnaHQgKGMpIExpbmFybw0KPiAr
ICoNCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+
ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gKyNpbmNsdWRlICJx
ZW11L3RhcmdldF9pbmZvLXFvbS5oIg0KPiArI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4g
Kw0KPiArc3RhdGljIGNvbnN0IFR5cGVJbmZvIHRhcmdldF9pbmZvX3R5cGVzW10gPSB7DQo+
ICsgICAgew0KPiArICAgICAgICAubmFtZSAgICAgICAgICAgPSBUWVBFX1RBUkdFVF9BUk1f
TUFDSElORSwNCj4gKyAgICAgICAgLnBhcmVudCAgICAgICAgID0gVFlQRV9JTlRFUkZBQ0Us
DQo+ICsgICAgfSwNCj4gKyAgICB7DQo+ICsgICAgICAgIC5uYW1lICAgICAgICAgICA9IFRZ
UEVfVEFSR0VUX0FBUkNINjRfTUFDSElORSwNCj4gKyAgICAgICAgLnBhcmVudCAgICAgICAg
ID0gVFlQRV9JTlRFUkZBQ0UsDQo+ICsgICAgfSwNCj4gK307DQo+ICsNCj4gK0RFRklORV9U
WVBFUyh0YXJnZXRfaW5mb190eXBlcykNCg0KSWRlYWxseSwgdGhpcyBzaG91bGQgYmUgaW4g
dGFyZ2V0L2FybSwgYXMgdGhpcyB0eXBlIHdpbGwgb25seSBiZSB1c2VkIGJ5IA0KYm9hcmRz
IGluIGh3L2FybSwgYW5kIGJ5IHRoZSB0YXJnZXRfaW5mbyBzcGVjaWFsaXphdGlvbi4NCg==


