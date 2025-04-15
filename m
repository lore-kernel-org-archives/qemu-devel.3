Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2C7C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 17:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4k8k-0004sS-NV; Tue, 15 Apr 2025 13:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4k8T-0004rO-5U
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:31:53 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4k8R-0000hR-0U
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:31:48 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2241053582dso81243295ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744738303; x=1745343103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bCmVMDVljO40oRkPaHY3BRhSfb9wLUefJVNXmI0711A=;
 b=OgzWFHtB7APy+NVyyHHOSQCiJb/d1aeQzyLCNRE717r2HGV23J13DOaccHeL7OoQJa
 xhHdPqxo9DPfh7DF3CCuocIIspEnioxSgEapg1sqqtDHHThYF6vGvo1egL8gerGNl5e3
 FsMsbUbUjpVnCbWoFCC/ES7rDb8lmQ6PqNafzBLq23yvQb9UYu7h6KMKxBzcW+E2A0Hk
 SljFqbgfEU/1dsxQZWQqTvPjsAdpqyQyzWr1B10RZGiBL30GM1ilXIp149bE+jXugZQe
 JtGEdR/lyrQZoDLZyuLi4u8HNLAyaa/Z11Sr6X75qmJiPAPQxuC3ObZR3t1qTrE8M0+z
 F1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744738303; x=1745343103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bCmVMDVljO40oRkPaHY3BRhSfb9wLUefJVNXmI0711A=;
 b=niSTqCiyUlyKk6LR+WP/rz8SGor4lkRXB2+FENyOGbDJrDDalZTEGqTeo4pJKYxE7y
 OnpWic2332iFHuoQMSrIspyDAs61ej2zg7coDMl25ChxT5ye1RWYpDJ9ixtDCHOFekB5
 PDWD6NpVi6BJqVlOnG8sBaUNLwaOn6QTFzfVSF0kl8MHVVPFstcIQvqe58fh4cQKxRTQ
 MbDVRfZlEixIUQS8gOqbIvlVwAA01fS9CGXSiuze5tjaOYgjQJz9gD7+1v0LzLe3hFK4
 BAqRRZ7panSsdryi6H4kpC9xdZCAuptZgEFnSTL//p9pU00iLsr2rgRDlPmlTRD0p+On
 uZgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNNHqsdTh4Y3s8m/zuBINfCZBNl6HxTBmlZ8jk6Zte8o4yptFR+yLyP477WuBaQZK+/08XvVvKJLr0@nongnu.org
X-Gm-Message-State: AOJu0YxErLOOVCyRm15H6s0zfe4FhHsgyXtSikrXGQo7FdPgc2z6lFKp
 iHI/8H9S9QMJaxicK3j30rRExEaneBfJCLakymC2/6G9GYHs971D+Jny7vlgOos=
X-Gm-Gg: ASbGncuCFBgW36oJaVtAi12iqr5H6ht7egXb4h5a9P/SIAkEsTjI8AgmTLA1CBQ49H3
 iK5kon7NtQ2SszgNqI3F0U3JrZaqTle7Z3lyyAxdggsuzVkWc1oy4+jQUMU1juGgdovBDrKXhoM
 ujhAGiDxyQfIyhjUXz9C9WVL4sMksDNFlT6KZKMBSH7+oVLU1hfvR21bnHE8L46QzYs0xAoHeOW
 KAf2KKACYcuE7d6Vc+OJIXXA3R3KJmdI7v/0xFHy+QKsb+oF6YY9Gum6Hm8Wby9aEiFYNbqAGeI
 0nE2vPHaunBlBpHHZwyb7Hc52GwieZ1T7JEATtiQanjx6/zQi5+OXAcRunlQkap4
X-Google-Smtp-Source: AGHT+IHrW4jHLUaLWGkG6UGZxlF8nHtmbigYilbF/sEQBNCC4miyKmdJtSbu+XWy4lS+aSfxGzsYrw==
X-Received: by 2002:a17:902:f552:b0:223:5c33:56a8 with SMTP id
 d9443c01a7336-22bea4ff1f5mr264413265ad.35.1744738302944; 
 Tue, 15 Apr 2025 10:31:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b6284dsm121065315ad.38.2025.04.15.10.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 10:31:42 -0700 (PDT)
Message-ID: <4fdcd3ae-71ac-42f3-94e7-c6d767448597@linaro.org>
Date: Tue, 15 Apr 2025 10:31:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] target/arm: Replace target_ulong -> hwaddr in
 ARMMMUFaultInfo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>
References: <20250415172246.79470-1-philmd@linaro.org>
 <20250415172246.79470-2-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415172246.79470-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

T24gNC8xNS8yNSAxMDoyMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFNp
Z25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9y
Zz4NCj4gLS0tDQo+ICAgdGFyZ2V0L2FybS9pbnRlcm5hbHMuaCB8IDUgKysrLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vaW50ZXJuYWxzLmggYi90YXJnZXQvYXJtL2ludGVy
bmFscy5oDQo+IGluZGV4IDI4NTg1YzA3NTU1Li4xNzVmYjc5MjM3NSAxMDA2NDQNCj4gLS0t
IGEvdGFyZ2V0L2FybS9pbnRlcm5hbHMuaA0KPiArKysgYi90YXJnZXQvYXJtL2ludGVybmFs
cy5oDQo+IEBAIC0yNSw2ICsyNSw3IEBADQo+ICAgI2lmbmRlZiBUQVJHRVRfQVJNX0lOVEVS
TkFMU19IDQo+ICAgI2RlZmluZSBUQVJHRVRfQVJNX0lOVEVSTkFMU19IDQo+ICAgDQo+ICsj
aW5jbHVkZSAiZXhlYy9od2FkZHIuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9icmVha3BvaW50
LmgiDQo+ICAgI2luY2x1ZGUgImh3L3JlZ2lzdGVyZmllbGRzLmgiDQo+ICAgI2luY2x1ZGUg
InRjZy90Y2ctZ3ZlYy1kZXNjLmgiDQo+IEBAIC03MjQsOCArNzI1LDggQEAgdHlwZWRlZiBz
dHJ1Y3QgQVJNTU1VRmF1bHRJbmZvIEFSTU1NVUZhdWx0SW5mbzsNCj4gICBzdHJ1Y3QgQVJN
TU1VRmF1bHRJbmZvIHsNCj4gICAgICAgQVJNRmF1bHRUeXBlIHR5cGU7DQo+ICAgICAgIEFS
TUdQQ0YgZ3BjZjsNCj4gLSAgICB0YXJnZXRfdWxvbmcgczJhZGRyOw0KPiAtICAgIHRhcmdl
dF91bG9uZyBwYWRkcjsNCj4gKyAgICBod2FkZHIgczJhZGRyOw0KPiArICAgIGh3YWRkciBw
YWRkcjsNCj4gICAgICAgQVJNU2VjdXJpdHlTcGFjZSBwYWRkcl9zcGFjZTsNCj4gICAgICAg
aW50IGxldmVsOw0KPiAgICAgICBpbnQgZG9tYWluOw0KDQpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

