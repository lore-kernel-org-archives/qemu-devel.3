Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA59C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 08:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNSpM-0004tI-Sg; Fri, 06 Jun 2025 04:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNSp7-0004rI-Vt
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 04:53:15 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNSp5-0003xi-Au
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 04:53:12 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a375888297so1194624f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749199989; x=1749804789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aR0oWFRYp6PORWHRUJow1gQr4dzui71+QM7wq6vxm3g=;
 b=e5uFpTGhS55pz0K3gOs02MptkCna1C0FZpdDCWxDyFm7os8FbUWu3pl4OGJzkF+5vd
 YpJvUaztl6pyrN07W6sY3VcW2pi+WnzU7kwulbsnWt0tmWLw3trtjV+syti1LD97Kxhr
 wViSH8h2IC++ktNDoWCMYkQYng5+J4FPx4FjWv6zTDMrrfilojQcYlYrrwqg66buBj1W
 J/1XefmK44RfVeB6b7fODPfaJMnhkdx7Cc1CK2BBxSmvzEBT3MYppnqpI6yQJEyV7nfn
 0lAI0Zv7m1uBY45CVOws6/XgJhsfXDnaUv8cmvXEeWfT8gREwau7IS3UB0BcTvYUyXLJ
 1ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749199989; x=1749804789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aR0oWFRYp6PORWHRUJow1gQr4dzui71+QM7wq6vxm3g=;
 b=iQr3joF+9Yq+YDKNh3J+1AnHje/ZRfLQr/NCBw3kp4765FwMaISCpug8wuorRdHGki
 Ir3+MMeSXDaJYbNylsZYFk1yqABk4GecPI1bil+lLiEEV9WlXW89dOzVShW+SThnXW29
 78qZM+tEPuVqj7D9qOMlVlK8cChVtTR0ZJ+332ReJ+R199GJB+vhWPpBV7hENRoAApsr
 gLoW8XikBWIRhU2K4/4CNwaYDiHdLFyzK4lQrkqUcGeJnIlxrCWfggs563lL5OpSWkk6
 ogkJiLjInVw7jAjLVPOP2rbQM5vskoHz8f+Ai0qPxVhNt4iXcWYa5Gay+WmPqe/p54L4
 xQZA==
X-Gm-Message-State: AOJu0Yylp5IYriuZb5U/cpNKqPCwdNOmY2yHObNY/iGbjlIcKR6F3YhC
 iZ/Z6EERDqunF+FWe1EJGRJvaocN0gGRl8nTX3ZsyB1TIWBrMaWNoXPVwEnfuTdR328=
X-Gm-Gg: ASbGncvOhkrRq+HQkn8vPJZOmaB9NCG429hnf2T2R0+XkgoYvPdkbxiX0x0cOFw2rcl
 RpY9uhW4ZxJltTVs9+eJSyX8KYiVuDXG+BOrgdqSGrltWPBYtO5mTvGgcrHHWyu2/NX/dvBWg5x
 6A14kuhV1zk4G/Ie8MDk8US6RjgT55BcC0EW5XpAkGxiSJ5LN7ZwhCEF3hw6tCPquovBjCXzcm9
 CynAqJFMboniqY+G87h73PGLQiJtTgzd1kPkyRJ0Iz6DnMbeSsRvxi+4E/TZ41Ki3hr5Ozzk7FG
 7YkLDCoHVXugy10L0d8vLKTsT01LyBRry78c/fXObXJI/ewkiF1wpG095nmd1SgsnbXlSAl/6Zi
 ejYSBDvVeEJSNsEooFbLzZaEluIKhJA==
X-Google-Smtp-Source: AGHT+IEDl+YNnxNN9ZFavr+Lllpi/A7HtUgDXYtY6P9JYyer4G13lM5INxjOHZE25QxY7YdaiPI8KQ==
X-Received: by 2002:a05:6000:26d0:b0:3a4:f70e:bc25 with SMTP id
 ffacd0b85a97d-3a5314412b1mr2468223f8f.27.1749199988602; 
 Fri, 06 Jun 2025 01:53:08 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244ed76sm1234515f8f.78.2025.06.06.01.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 01:53:07 -0700 (PDT)
Message-ID: <23897d70-b747-4c2b-ad71-e521ffb4f4bc@linaro.org>
Date: Fri, 6 Jun 2025 10:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] system: Forbid alloca()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250605193540.59874-1-philmd@linaro.org>
 <CAFEAcA9WF75iiL8WmcTYQ2ph7NLuMTXtarPp6HouEZ_nHhg1EA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9WF75iiL8WmcTYQ2ph7NLuMTXtarPp6HouEZ_nHhg1EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 6/6/25 10:37, Peter Maydell wrote:
> On Thu, 5 Jun 2025 at 20:35, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Eradicate alloca() uses on system code, then enable
>> -Walloca to prevent new ones to creep back in.
>>
>> Philippe Mathieu-Daudé (4):
>>    hw/gpio/pca9552: Avoid using g_newa()
>>    backends/tpmL Avoid using g_alloca()
>>    tests/unit/test-char: Avoid using g_alloca()
>>    buildsys: Prohibit alloca() use on system code
>>
>>   meson.build                 | 4 ++++
>>   backends/tpm/tpm_emulator.c | 4 ++--
>>   hw/gpio/pca9552.c           | 2 +-
>>   tests/unit/test-char.c      | 3 +--
>>   4 files changed, 8 insertions(+), 5 deletions(-)
> 
> There is also a use of alloca() in target/ppc/kvm.c
> in kvmppc_load_htab_chunk(), so I suspect that patch 4
> here will break compilation on PPC hosts with KVM enabled.

Oops sorry I missed that one :/

