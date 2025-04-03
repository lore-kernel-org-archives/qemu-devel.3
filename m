Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3985AC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0NH5-0004FD-Cc; Thu, 03 Apr 2025 12:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0NH4-0004Ey-BQ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:18:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0NH2-00042W-Gs
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:18:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227cf12df27so8916015ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743697114; x=1744301914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x39luPc+dOXIM+x6bbOzkYde6vN7LjcapekMw7Cuda8=;
 b=g02/NzR7RbtWRx+OxVsZKkXmpXO3/H/lH6uEDdOYJmCnGgnDIVhA8BIIcuszJBhxDl
 7MMIuZW+pQUBmeTa5UbQcOsniHVjkOJb6L6+scF2t6QI+FN/vqUNR9AF6vZPP6+fKrrb
 ZAQKM99BAKElLR3Xatw07aIronOs80gh7DjWa7NhljGdXhxcbSzB7Zgp1FQnqa25HR+t
 1PjFI7QVZiBDPJD6iJNaQBVlRl7IAaWiGMV2qRBBPAuWST20QrS7Gn5nBZ/XvzXDMwfj
 h90u1IAZZ6F8SPoaZtW4oWwy3LY+QOcKwUgxTvgf0DZm8cKf1ev5SUWsOvCFN4pgiqlx
 sJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743697114; x=1744301914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x39luPc+dOXIM+x6bbOzkYde6vN7LjcapekMw7Cuda8=;
 b=C2GaXqyVC4fh7NINYhkCs74kuhjVRXyHgABHNnGtyJjKkcE0QXKhz5f4w1Tb5QerIA
 Ck+21jFgxk/33QdzwBXidXObAzZVK0UA/O9qQSOulYg2MKmXMUKLYdKqsEw/T85iuitJ
 lHFmBELlHihWzcJr22Dz5HKtocm5ixICC20Ct9hOICsGpXmEYz6/ta2a2WxC45GrNObS
 JpuADeTjYsUrz5hipPUYSUtwwA+EEQ1/wZGQYA6V/zFCtwj89SVgk78yIE9vsgnW/rHx
 PuGgKfiTIqKuQeav2jpQQV+jHLbJm7TeVEAc5mG7C9TFnrpupp8t/S8L59m/iRwCan/m
 PiUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVedZo5e58/pI9bA33y7ZJM6bppd6GYLmpuZYFcsZw8skxodj4lYxa4rJ0LA5Pivj8GyKxV7r7Bk0OK@nongnu.org
X-Gm-Message-State: AOJu0YzHOz05m95titOgR/L5FQBiTX7nb203DvbQx8AgFRknoj0C5L4d
 BibnDvPSWP2+vuquIKf+vlSH1po8qWFw1OMa6wgkP+/rL4t+N3LYLRqKM1k74sM=
X-Gm-Gg: ASbGnctwPr50rBjQd7/irXZHYPiw76hxHxIbJyxTha2qml7IgGgrC4h0cIlICbYs/sC
 gjHmxjcKYkhzQM68ifwF1H14awTobY7TB4MFuJvOcZreITv2NKtyyig8dM38DprhJt+XtisuADE
 lVCpijSigRzvhbxvYmwqHZwGZkqo+yglGwxZs/lScfGkzIeQX/apGiQy3fKjXB1crKaeJPiJI+C
 TCiD/ovPZVLFym4QDAmVCKR2N7Hqu9i8YiGyIS3PBuov6B0IvVxqFqaNYJ/aQMTp9eQCw4rSuLD
 /JA5BcUC7zWZCw4T+ieRAKmhJOhKXvuv1lmZvnLdLJshGcL0a0TFFTJXZg==
X-Google-Smtp-Source: AGHT+IF4q7/kri8teKMRY/8jyeWsH+vGxnupu4MuBAEpCr3j4cu/OyriJ+IN91ryNnKreauAlaARJQ==
X-Received: by 2002:a17:903:3b84:b0:21f:53a5:19e0 with SMTP id
 d9443c01a7336-229765d1a02mr56269955ad.12.1743697114494; 
 Thu, 03 Apr 2025 09:18:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297877266fsm16560025ad.215.2025.04.03.09.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 09:18:34 -0700 (PDT)
Message-ID: <72224ba2-2d6a-4d84-99c9-83af5a47efce@linaro.org>
Date: Thu, 3 Apr 2025 09:18:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/29] include/exec/cpu-all: move compile time check
 for CPUArchState to cpu-target.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
 <20250325045915.994760-4-pierrick.bouvier@linaro.org>
 <e11f5f2e-0838-4f28-88c1-a7241504d28a@linaro.org>
 <319fd6a2-93c1-42ec-866b-86e4d01b4b39@linaro.org>
 <1d13c66a-e932-48c4-801c-9b14890679c5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1d13c66a-e932-48c4-801c-9b14890679c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gNC8yLzI1IDEzOjA2LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4gT24gNC8yLzI1
IDA4OjI1LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNC8xLzI1IDIwOjMxLCBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBXaXRoICJjcHUuaCIgaW5jbHVk
ZToNCj4+PiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBs
aW5hcm8ub3JnPg0KPj4+IFRlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEBsaW5hcm8ub3JnPg0KPj4+DQo+Pg0KPj4gSSBjYW4ndCByZXByb2R1Y2UgdGhpcyBl
cnJvci4NCj4+IFdpdGggdGhpcyBzZXJpZXMsIGNwdS5oIGlzIHB1bGxlZCB0cmFuc2l0aXZl
bHkgZnJvbSAiYWNjZWwvYWNjZWwtY3B1LXRhcmdldC5oIi4gSWRlYWxseSwNCj4+IGl0IHdv
dWxkIGJlIGJldHRlciB0byBhZGQgaXQgZXhwbGljaXRlbHkgeWVzLg0KPj4NCj4+IEBSaWNo
YXJkLCBjb3VsZCB5b3UgcGxlYXNlIGFtZW5kIHRoaXMgY29tbWl0IG9uIHRjZy1uZXh0IGFu
ZCBhZGQgYSBkaXJlY3QgaW5jbHVkZSB0byBjcHUuaD8NCj4gDQo+IERvbmUuDQo+IA0KDQpU
aGFua3MgUmljaGFyZCENCg0KPiANCj4gcn4NCg0K

