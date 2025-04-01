Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803F9C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 15:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzdBu-0000bP-It; Tue, 01 Apr 2025 11:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzdBq-0000aa-FU
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:06:11 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzdBo-0003Rs-Cq
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:06:10 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30185d00446so7908266a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743519966; x=1744124766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6qIarq8ewJ8oxyAYUGJH62nu4jp5qDGl1AsytYoD0us=;
 b=n4cWsWz8HJfk/0SRX+4ZnL9e7WWOI71NXEFnWwiyDfOgls0qH/rKC5Bn8gBL5ypiLP
 jVM1p2wvkaRv3ZlrIz6A8HFKRe3HzMi0Fo23axmUnx/IAGDU+bNeN+SUA7Gg7DVq/NrU
 ICmL4Po0bHF6W2sy7zCInS0zjhccZWT2uCkFJ+UPnR164Z60HDHnQxIVh2yKc/yfSTZz
 BUWIdTpEexe1Z359BD5jHP62ziPQBTmlEs9/QLVcUNqLph/7hSoKtdAt5snxhJhrTm9L
 P8907tgKjsYk/LT8XtD5D+E8xHM3Vaqj1vPe4yUuHjT/OetOY2DHsUun3im+zPsSW8fd
 rCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743519966; x=1744124766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6qIarq8ewJ8oxyAYUGJH62nu4jp5qDGl1AsytYoD0us=;
 b=sTXs6QfwUZ1W93lEDPt8DTNhk/Yaill9JkPxDeykfol8aKsLHg9dCB+4v6AnIBQYqT
 uWE3FEUO3VIPNrtPYeyvvTEVNxS4Qsjj/Eu5CjofIpgfOefGGIIqVrpO4MOBikwKoAR3
 DZYIjdpmG9J5U/V0JHM3S/WZlNfXZugNWFU8Tq1XquAh5OWy6AFSKFX578G4cNSi1dhD
 sTHkBWQyDLCXyEu1ZoMrRLtJmChFgLfr0bRt1woGIRIVC6stcEe5xYkhLQunRupr0YF4
 VvyHtNk0Rp4EcApoe9TKq+8/kLVHNdxaLppg+lZMRgQ/hHWDqiG72V86ILbkcdFcgJOu
 jbTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV280q68VGfG3SwBzxdiIC2liQZ5tnUky7Y1C7U1vX7wlgnceBEXk1SkKX8VufsxH1pp9TMm19x2GdI@nongnu.org
X-Gm-Message-State: AOJu0YyJQFfZLjZlIY68rr9//4eChkcq3hUd/oZJKU9iR0XZMEsONoLG
 P9MnUkh+CGotcDF+XT33YK7QXwQI4u1npH35DntgeKrLCjBJCwZGd1QWuNHhwLX5q6Y80yZ0xZp
 T
X-Gm-Gg: ASbGnctGFGoBGaZ+tSEP3I3v4hNy6Zy5GZWCOFPrVpaxsJ1e9kPtfEsLs7ThfEzyTW3
 mETQ1FB7P0G3otL6VV/ZIMpDkUnLPIDAjsMjeEn0Ga4PaoGEn2EN0EixG4dxtn3L1S6jnq4n4fO
 TkWG11Tux9lGh/hfhtysgMjvfgEjBzU/69QGcB5Eafbax7CLiubv8HR9Umn16E3gvyFoCrYr3VW
 V4XcW7hz/w+qjahnVVOfQ/NQBhLEQDb2W5SEwvv7J9fo8/xfU/PXmEWgGmeZhufA3vyO5yYGrVE
 tlnOn4fQe7N+klRORqtWdSte8+JRPOsZ2tPighpl0DNHKt5QhQfxxJLL8g7ckdkuq+67
X-Google-Smtp-Source: AGHT+IEPt+zXJTy3JLL0LqNHJGzn+Mp0yQT9zBJV0Jqix+KiNZVSagi4g7skQXYcEnLNM33kV557ew==
X-Received: by 2002:a17:90b:4984:b0:2ea:8aac:6ac1 with SMTP id
 98e67ed59e1d1-3056b79c0e7mr427485a91.15.1743519966149; 
 Tue, 01 Apr 2025 08:06:06 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039e10b783sm11702336a91.22.2025.04.01.08.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 08:06:05 -0700 (PDT)
Message-ID: <c9bb3d4d-8f89-4345-8568-e142016c98f9@linaro.org>
Date: Tue, 1 Apr 2025 08:06:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/3] exec: Restrict 'cpu-ldst-common.h' to
 accel/tcg/
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250401083232.33773-1-philmd@linaro.org>
 <20250401083232.33773-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250401083232.33773-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

T24gNC8xLzI1IDAxOjMyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBpbmNsdWRlL3tleGVjID0+IGFjY2VsL3RjZ30vY3B1LWxkc3QtY29t
bW9uLmggfCA2ICsrKy0tLQ0KPiAgIGluY2x1ZGUvZXhlYy9jcHVfbGRzdC5oICAgICAgICAg
ICAgICAgICAgICAgICB8IDIgKy0NCj4gICBhY2NlbC90Y2cvdHJhbnNsYXRvci5jICAgICAg
ICAgICAgICAgICAgICAgICAgfCAyICstDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ICAgcmVuYW1lIGluY2x1ZGUve2V4ZWMgPT4g
YWNjZWwvdGNnfS9jcHUtbGRzdC1jb21tb24uaCAoOTclKQ0KPiANCg0KUmV2aWV3ZWQtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

