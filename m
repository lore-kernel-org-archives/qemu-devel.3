Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1551BCEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svg1p-00076O-2L; Tue, 01 Oct 2024 12:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg1b-0006UR-AH
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:47:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg1Y-00073D-Vd
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:46:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71b0d9535c0so4099744b3a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801215; x=1728406015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fOytmqVO3zXyUJ0nP2wESEdbzdCo0nkTINVmpjlqe9Y=;
 b=CE2pFw0DswM9RClOCg71KbJOuduIAarjKnyIRX6lBL4olmk1xbsSqgQnB1V5akw7T8
 LV9FKqWZOPWAJdaQCLHRqpe765lohu++sLqkYuwb3cLhTyJl9QpugBhDdHIkNLnXYk6o
 CitSeo20ropDp/udx5f8UFoiiwwYV40fCfjrBs0p/BKQ6LOurzHtRLV6G5P+uGMijS0H
 jtugeN44I3SU+V4Bb/y+GfaKJTr8WW/zcN4CBAf8yu0CB2/0Xbd2Bu1NCUiwkyrDIEes
 hirDfz4WeV5OKA8Ws5ekLkSiYddEaiEXXp7V6gRjhENogiA5AB/doxPMwRP9yJwoMGeH
 k6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801215; x=1728406015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fOytmqVO3zXyUJ0nP2wESEdbzdCo0nkTINVmpjlqe9Y=;
 b=dMoHn8Fu94fCDBrSAivyKM2pAvpRm99l0mBXR4ulw64cNaQazEmBzuVM106QshqQDp
 svubL+bYyR3COzn+DQTToroLQI2RpwrTLe1IgCIsTMKyVAQZTCw5G4vP/pGwyPe6LK1u
 fX65VqgRJFtHKuEhv+1oBPc2rfq2WU5uNmohGAwyPs6bbcf/RugegxxztGhO9SOd40It
 jkPzuazxW3vlneyHPmGDqa30UF22DxtUhk7tbakSoyBYuj0GY4/br54CXaoBgelLlrs8
 AXaOlkMog8jkxRoKHZxXiAO9JtrNdBXieG/K6xotCRW7l4qRJmQKaoJLHn0sMJbSxiRV
 bwlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjZOGrX5ZVyt+2wrnM3zHce/rCD0crvCRBNdZvJyLn7dRatd9xNNctONO/r5THlkpYtOgy9AVhDN+M@nongnu.org
X-Gm-Message-State: AOJu0Yw8Yo/5zJvPNnnJg2lxsKf5tdL2yLO4UiO94MuIj0ds7pgQoNOR
 ig+9mnjmXagOnCmgZtUpQoKqfQpQ2zgS9K87zqDwltN4VaGns3jQNJ1my8keNew=
X-Google-Smtp-Source: AGHT+IGP2s7i/fjXTXuAysRxcFVM89tY2V68gj53XfUw4LuHNvuhkINNc1koSnV5DQik1etXhkknrw==
X-Received: by 2002:a05:6a00:3cc2:b0:710:6e83:cd5e with SMTP id
 d2e1a72fcca58-71dc5b140d9mr563847b3a.0.1727801214756; 
 Tue, 01 Oct 2024 09:46:54 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652b5b3sm8262343b3a.161.2024.10.01.09.46.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:46:54 -0700 (PDT)
Message-ID: <f401ae3b-498f-450f-a82d-6be84a8550cb@linaro.org>
Date: Tue, 1 Oct 2024 09:46:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] target/arm/ptw: Use the ld/st_endian_p() API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gOS8zMC8yNCAwMDozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFJl
ZmFjdG9yIHRvIHVzZSB0aGUgcmVjZW50bHkgaW50cm9kdWNlZCBsZC9zdF9lbmRpYW5fcCgp
IEFQSQ0KPiBObyBsb2dpY2FsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0t
DQo+ICAgdGFyZ2V0L2FybS9wdHcuYyB8IDE5ICsrKystLS0tLS0tLS0tLS0tLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL3B0dy5jIGIvdGFyZ2V0L2FybS9wdHcuYw0KPiBp
bmRleCBkZWZkNmI4NGRlLi5hMWE2YjFmZWMzIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvYXJt
L3B0dy5jDQo+ICsrKyBiL3RhcmdldC9hcm0vcHR3LmMNCj4gQEAgLTY5OSwxMSArNjk5LDcg
QEAgc3RhdGljIHVpbnQ2NF90IGFybV9sZHFfcHR3KENQVUFSTVN0YXRlICplbnYsIFMxVHJh
bnNsYXRlICpwdHcsDQo+ICAgICAgICAgICAgICAgZGF0YSA9IGxlNjRfdG9fY3B1KGRhdGEp
Ow0KPiAgICAgICAgICAgfQ0KPiAgICNlbHNlDQo+IC0gICAgICAgIGlmIChwdHctPm91dF9i
ZSkgew0KPiAtICAgICAgICAgICAgZGF0YSA9IGxkcV9iZV9wKGhvc3QpOw0KPiAtICAgICAg
ICB9IGVsc2Ugew0KPiAtICAgICAgICAgICAgZGF0YSA9IGxkcV9sZV9wKGhvc3QpOw0KPiAt
ICAgICAgICB9DQo+ICsgICAgICAgIGRhdGEgPSBsZHFfZW5kaWFuX3AocHR3LT5vdXRfYmUs
IGhvc3QpOw0KPiAgICNlbmRpZg0KPiAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgLyog
UGFnZSB0YWJsZXMgYXJlIGluIE1NSU8uICovDQo+IEBAIC04NjAsMTYgKzg1Niw5IEBAIHN0
YXRpYyB1aW50NjRfdCBhcm1fY2FzcV9wdHcoQ1BVQVJNU3RhdGUgKmVudiwgdWludDY0X3Qg
b2xkX3ZhbCwNCj4gICAgICAgaWYgKCFsb2NrZWQpIHsNCj4gICAgICAgICAgIGJxbF9sb2Nr
KCk7DQo+ICAgICAgIH0NCj4gLSAgICBpZiAocHR3LT5vdXRfYmUpIHsNCj4gLSAgICAgICAg
Y3VyX3ZhbCA9IGxkcV9iZV9wKGhvc3QpOw0KPiAtICAgICAgICBpZiAoY3VyX3ZhbCA9PSBv
bGRfdmFsKSB7DQo+IC0gICAgICAgICAgICBzdHFfYmVfcChob3N0LCBuZXdfdmFsKTsNCj4g
LSAgICAgICAgfQ0KPiAtICAgIH0gZWxzZSB7DQo+IC0gICAgICAgIGN1cl92YWwgPSBsZHFf
bGVfcChob3N0KTsNCj4gLSAgICAgICAgaWYgKGN1cl92YWwgPT0gb2xkX3ZhbCkgew0KPiAt
ICAgICAgICAgICAgc3RxX2xlX3AoaG9zdCwgbmV3X3ZhbCk7DQo+IC0gICAgICAgIH0NCj4g
KyAgICBjdXJfdmFsID0gbGRxX2VuZGlhbl9wKHB0dy0+b3V0X2JlLCBob3N0KTsNCj4gKyAg
ICBpZiAoY3VyX3ZhbCA9PSBvbGRfdmFsKSB7DQo+ICsgICAgICAgIHN0cV9lbmRpYW5fcChw
dHctPm91dF9iZSwgaG9zdCwgbmV3X3ZhbCk7DQo+ICAgICAgIH0NCj4gICAgICAgaWYgKCFs
b2NrZWQpIHsNCj4gICAgICAgICAgIGJxbF91bmxvY2soKTsNCg0KUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

