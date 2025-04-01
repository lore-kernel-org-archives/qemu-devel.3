Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C96FC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 15:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzd79-0005gO-SB; Tue, 01 Apr 2025 11:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzd75-0005eX-Ki
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:01:16 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzd74-0002dQ-04
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:01:15 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2295d78b433so17323475ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743519672; x=1744124472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LRGJlfoPKHv5RT5BSU5j5hTxk8oNVEEPXrqVfHvB7x8=;
 b=B2YwvnYQmDjYvXZoDDMb0oSIWq6KwkODl1as7+SJTZC5rYrKFt2jXwiigjoG/w6WFG
 RKweIpXN/vNh0ULkq1bYGJT/XfLDxPayKjTD4yAs0lKjLNgtjQdT0TxLJh6Q63smdl/0
 ZuYS8Mgkri2iSnky/ozp9V7Kh2B/V00KI1qS9OzC13fA1GAo/D7PGij3DDH8IacUdOMJ
 LqInDslDi9wu1VU9vpAVUJttA4E1i9ki2RUaE+KfmNC6Bx4PmsT3Xnt9QlLvahH0SZ8O
 p7pbXnkqPxM0yrvywAHpNif7nWbWStxN7TnTyEnbOgdJNu2Yj9//xpySqhDJX6ZRHM9C
 YaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743519672; x=1744124472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LRGJlfoPKHv5RT5BSU5j5hTxk8oNVEEPXrqVfHvB7x8=;
 b=xAFuAEouvLtDbSKFfYF00G1hI6NWUSajoqnxd6PZQZPm94dTO7oshVT29zP7fq2gGM
 Xtz3Ot9h9lgmb+S0/EWpNuZZIzvCSo+A1UCGPGC09nzf34bpSQw7ryYIGJ0nZZiBN6G9
 jWme57IkArJ6kJdIseF5UhtV/o1eiBlLAhXvTQxSQAzuEPMWkCn8mkWEuDHO9uSCaO6N
 YylQTLkk45Qt8L2BabG0XERD60ANdYBEzOXPlTKgkY8Xphw5jhfKN15s/OQMaDTLo8N3
 v+vFs6qjXw9RNzD69VXiUzO4PVVzE0+lbnF3sIimYjTrjrG5uCEtG/273tgw9giuSKBB
 O3MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlEjWN8iKykRsME0OnGyVUtP7odKvycc/4YmmdQcCJMQqWwUhaibjicFYNVxREWKmR5D2RJQifposm@nongnu.org
X-Gm-Message-State: AOJu0YwxVHlOdQbRxAu/lnNtqRfEnX+UY4ERKMViVDm0NY/78WxIbUGG
 opxiCTyW9YbuNCVtnQLUmkPluRShGnbQQPGq2lyBchNvKM2dRLr8S7citV6Scfk=
X-Gm-Gg: ASbGnctXpkO/zxmyt6vy2NVxqGUp5hAIt7xAKql99y/Rb4cLO70OFIEiLQWTTTGyTjQ
 I2O/Hq622A9yppgADtCKYJWky77TYK/oCynXWepKQzYYjo4Ips8cD1e86OMUi558iCzpy9lA7tY
 bCD1C99us5KkYWpc7FTJtvxulOo/h1k/aIFhfycdu82HPBdb1Os7PPZOCHXRQWKBqaElWzxy+bl
 4k/CutPAHLG60OFf+gJ+2hcIU3v9rO3iOMyu6G1r8v/27oTnAcLzr/N9sjapqIBroH/KZl3ylL+
 jkhy5kwzp0o0SWjJuq3Z+Bi4j3oMrNSSe1orzWSEM020xy/Id4Y5bwVgqA==
X-Google-Smtp-Source: AGHT+IEUNbatZQFhzJyUS8sQedmZY2qrlZr501hl+2rsQ9gZ8HYsCWzMYn8m+4bI2Ltrs7KStwI5qw==
X-Received: by 2002:a17:903:120c:b0:21f:2a2:3c8b with SMTP id
 d9443c01a7336-2292f948bb7mr221249255ad.11.1743519672201; 
 Tue, 01 Apr 2025 08:01:12 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1df418sm89093465ad.202.2025.04.01.08.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 08:01:11 -0700 (PDT)
Message-ID: <44070469-f67c-43de-9c48-24f19b06b1ba@linaro.org>
Date: Tue, 1 Apr 2025 08:01:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 3/3] exec: Do not include 'accel/tcg/cpu-ldst.h'
 in 'exec-all.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250401083232.33773-1-philmd@linaro.org>
 <20250401083232.33773-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250401083232.33773-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gNC8xLzI1IDAxOjMyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT25s
eSAyIGZpbGVzIHJlcXVpcmluZyAiYWNjZWwvdGNnL2NwdS1sZHN0LmgiIEFQSSBkbyBub3QN
Cj4gaW5jbHVkZSBpdDoNCj4gLSBhY2NlbC90Y2cvY3B1LWV4ZWMuYw0KPiAtIHRhcmdldC9h
cm0vdGNnL3N2ZV9oZWxwZXIuYw0KPiBJbmNsdWRlIGl0IHRoZXJlIGFuZCByZW1vdmUgaXQg
ZnJvbSAiZXhlYy9leGVjLWFsbC5oIi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

