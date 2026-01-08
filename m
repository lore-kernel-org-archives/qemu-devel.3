Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0DDD14882
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 00:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdeKX-0007qf-9X; Wed, 07 Jan 2026 19:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdeKW-0007kO-4S
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:56:48 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdeKU-0002Mr-LZ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:56:47 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso556505b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 16:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767833805; x=1768438605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rgZ1l0BhhAb8pf1FzZY0kqkTwaheDvDDkZKncVzOuvc=;
 b=BN3bn4b0GcNbXDlx0yFu9H0yBynrE5xMmW+Vh9zXaiOPfySVTTrOM1WOqr573dCoOD
 46Q1RRPp2MTXeBmOVG+8b+W5EKgljo1NSwp+CC0GYZRZ/zAPXVXKbOYDnbq3utV53ZST
 2CVCnbhcD9tiCF0+iAJPYTBpJWRMv/H5WLWLHLyLFpTPq0x0+lDc2LmhlW0CzllBDCR9
 fhcxZvRBVGAaUn/qbKg3wX25nukEb/fYtT7ytJZSwXdSVdMp77WCUWD/6ngyfsdspQBY
 Km3OhXV0XYeyK5fqysQsaVivfCt79+wzSD376Rx+1MRVJ4fGDZDV/vJBi0B0/wawq/3b
 CW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767833805; x=1768438605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rgZ1l0BhhAb8pf1FzZY0kqkTwaheDvDDkZKncVzOuvc=;
 b=pd0dnOnR3Qd0yBYaacpOP7nhofhoHk74MXjQ/QFu7dW9klO14adr3IfECmXSbrO+bd
 CDbM3+vpufS00DVyODIRM0IIhf6TGeK/d+MX/jMca9CJU4jUHq5bpVJEVBWRLQ6iSJh6
 kzXTQ+mzAvk3yS9hGJBj5+yZ3hXEGoCT0mW5UxSPGX/i2ie5kYnZ02Aw63O3i679J5jn
 R25aTa7/yvj5Kw0kKehFASwppQFHJlugEC1I6IPaBtNs/IxLITee/Mhur/h54X4Rr9Jy
 S08YVKlUE91I0rOsM2HgRHBsWjEQnypwLcND6u/ZfmSwWykGRGxU/A7HBQZWYqh+ApsE
 P6bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNrWzW6MtUwc2rC1iH9CH0alPMWvyPBVi3na2ApwhABUB3Kupl4sFBPD9lsllViS90CpXfqJUDTYjG@nongnu.org
X-Gm-Message-State: AOJu0YzyjNHn4JvoZNoU/n53EndxWLKawizrDYoQflDGT7oAGxBhNQSg
 Q7AEB/8cwFC3xXzOC0OxteHleAELNPE412KEO5i9wRZVPxXKBrGk/GM9eOwLit5Xwco=
X-Gm-Gg: AY/fxX65fZGF085uHURngkiKj8OsJOzpN/wCjgm/ophf0GGNSJ2JwOOhWlaBVL+9Z0z
 9srjbc78sGt6lT1IbvYvXmy9xgow2msaVTnc1LXvTdCExtO6vj6II9HnLeDF/x11jUAryPEBqwk
 geAyQUSh2QeQVDuTeYs1xPm368SEmEFU9t09/qY/iJZquPwYuc8mRUMVyK/JrGHwscagPfEmtZm
 2lOHRsVewASHvaKL98iMqT5t68MpxA9Q+nZxo2t4hhNk3vQaK/tjRKiPxJEgPdmDrfaQ+HpM2Yg
 2Je6MpyXuvwqs+jePMAj/6oqhL0m25nMLMj8aTlJ6qsVXWXPmNBufaEVDS+NaTav5zAJvMDsfho
 cTxzKGVxqRSgfyF4NnCwuCFmRsOEbI4+qc7x6Zfs0QAnS7W3dqwFr7oBGTzDbKc7oE9g1vOlBTS
 Lkas/RFMhPu771UfytteV099W0uhV0N66SAcrbJax9/WHlmm1QWSm5kFkOi1OMoYnYWU8=
X-Google-Smtp-Source: AGHT+IEWVQW2ek8FMnrs0ghLPGKdmI1MA6QB6X26zEjPjtMGQbWEtBl3y88mKmk/S+rQQ5qGBAS9Mg==
X-Received: by 2002:a05:6a00:4299:b0:7e8:4433:8fa2 with SMTP id
 d2e1a72fcca58-81b7f9d33d3mr3962663b3a.42.1767833805314; 
 Wed, 07 Jan 2026 16:56:45 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c59df961sm5919083b3a.47.2026.01.07.16.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 16:56:44 -0800 (PST)
Message-ID: <f3fd0232-17b2-4b51-b5d3-082f9cef1a46@linaro.org>
Date: Wed, 7 Jan 2026 16:56:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/s390x: Restrict WatchPoint API to TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260106231908.16756-1-philmd@linaro.org>
 <20260106231908.16756-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260106231908.16756-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x442.google.com
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

On 1/6/26 3:19 PM, Philippe Mathieu-Daudé wrote:
> By inverting the 'tcg_enabled()' check in s390_cpu_set_psw()
> we can let the compiler elide the s390_cpu_recompute_watchpoints()
> call when TCG is not available. Move it to a TCG specific
> file to avoid compiling dead code on KVM. This restricts the
> WatchPoint API calls to TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h |  1 -
>   target/s390x/tcg/tcg_s390x.h  |  4 +++
>   target/s390x/cpu.c            | 30 ++++++++++----------
>   target/s390x/helper.c         | 38 -------------------------
>   target/s390x/tcg/debug.c      | 53 +++++++++++++++++++++++++++++++++++
>   target/s390x/tcg/meson.build  |  3 ++
>   6 files changed, 75 insertions(+), 54 deletions(-)
>   create mode 100644 target/s390x/tcg/debug.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

