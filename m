Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF780C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 21:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2zHV-0004eG-EG; Thu, 10 Apr 2025 17:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2zHQ-0004cS-7e
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:17:48 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2zHM-0004TV-10
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:17:47 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so959039a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744319862; x=1744924662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k27xR+gZgLXWoqf6VEdoeK1pkVf6pdMIpwfEk9UWv9g=;
 b=MMzphmnA0dqP30OmQmZ/TzrN2pePoPUI0iOUodJJSth8qAT6FdS9VN8WmlHKfyw8P9
 j/SFPUwAlek+HK6ggfFhlySfQq15I5GpfCKIbyux/kpeiWfGpNxFONaIfHio/TYOBN46
 9P7PuKmFZwvAhbkRp1gnhm41iW9rUi0Ddf04LoaS/CyOqNMp7ua46iuG1rnc0qVoGLO2
 aqEh8q+bSMpDXI6qlDTVY3bVatqy+mdwS1dA4Fgh1WThpDpZyG5CsGTicsd6qSZoYvCQ
 ph8BM15vxaVYHdcd6TfVt+5MFGWjbvOuaeREIhwBfiL1kf7si+u3PiCyUdsTUn6pQ99N
 LA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744319862; x=1744924662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k27xR+gZgLXWoqf6VEdoeK1pkVf6pdMIpwfEk9UWv9g=;
 b=nvKrk+gzuEh05IPnuzS/PK1EaB+kATPNV2l/z9wau24ZHQV+Gta6YlV1EfrvB9wPxq
 DH5aE1CLAxXoa84zf/I3uozziqB/sFJK3Ufj9p8+z3DqnvtlinWhhQ0WbOvH+Y5NdARg
 jK7C3jm4QijyzK9tJZO+W4vZoG04XC2rhGPcL8vvKG1qK62A8/VnQp91NUuuZzzoLpVi
 GzmfV+5WB52FvTuuUAbSPYKzuWgrBkcFqARINVfSzZQP65HJj/cmVl2TV29qWC78QVf5
 4azp1pEF5XZkruCFJDJOXy0YuxVOmYgWOBMrvbJCB2JtLVbwfTekdSjr6Jd/7GhXCs57
 lthw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRXH4S06He3PQtd/g1/fOO5HBKK6VHxE7NM7BXoM+YdY+II+MGPvfKXBOSk2uGctzjtakUJ6d8KRdY@nongnu.org
X-Gm-Message-State: AOJu0YxoKRpgqcxPLCRn4/ncc8gFMo8qM03gpHyOzUXbsYxyNatROfZo
 wEoIN/fc8poDodbluo/a9u9BlBDKktKJnXWuqt+G6EtDvQDNibLwppk3ctt+HOo=
X-Gm-Gg: ASbGncsdcYmdd74L3+duey3t8FNiOAFmnzBcpL/zYg2MMpzYIvwtaRG4AqDg6Xqh+Ol
 GK+16bUAyDuUsJh7dHHrHVVX28VIctCZHpGHG4MQGFZKfdQqfLXPIjP+IQN+RD0wGbRHg+O/ymG
 nfDqRIaK9wzHuypEidaokcOoHDIicMhONH47r+M9asoSnoc3pWw/bwf6afTYILxqoAR6dpfLlVd
 DdkOURYfcH7KMCO/pRXXTDc2C+lOdvl0O4fz3jsMiKxWQBhWldJDB2pRXH+LcZTwmtqFOBdvSYT
 x9n4Q095RCxOvo9YPNyXSSxte+ner2L8hRwOxlL9OoljXirfkSoXYQ==
X-Google-Smtp-Source: AGHT+IGV9Kr4rUGiX4wwreN3zU1Uxyn4f5lAefTT7MLjbAvXrDAG3ctGkzG9xhc3nM2j1PGz5SNXeA==
X-Received: by 2002:a17:90a:e7ca:b0:2ff:6ac2:c5a6 with SMTP id
 98e67ed59e1d1-308237cdb4amr522205a91.31.1744319862237; 
 Thu, 10 Apr 2025 14:17:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd12b4d5sm4653646a91.25.2025.04.10.14.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 14:17:41 -0700 (PDT)
Message-ID: <83f44749-0eea-48f0-8aa5-3882132e30d0@linaro.org>
Date: Thu, 10 Apr 2025 14:17:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Enable QEMU to run on browsers
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <20250409192115.GA5528@fedora>
 <dc36c24e-dc4a-4c24-97b7-8b812441ffce@linaro.org>
 <CAEDrbUZ4mbCT-npk8Nha4fDd9a5PGguAxS_RD0wG96gpQRUp+g@mail.gmail.com>
 <CAEDrbUYM3aK5ErvF=+oV=q-NVLO0uzxbYjHzcxPGvTLp7yNtwA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAEDrbUYM3aK5ErvF=+oV=q-NVLO0uzxbYjHzcxPGvTLp7yNtwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

Hi Kohei,

first, congrats for this work!
It would be really nice to have this available upstream, starting with a 
modest TCI port, before having the tcg backend also.

On 4/10/25 06:13, Kohei Tokunaga wrote:
> Hi Philippe,
> 
>  >
>  > The biggest problem I'm seeing is we no longer support 64-bit guests on
>  > 32-bit hosts, and don't plan to revert that.
> 
> Yes, so the sixth patch ("[PATCH 06/10] include/exec: Allow using 64bit
> guest addresses on emscripten") should be considered as a temporary
> workaround, enabled only for Emsripten builds. It will be removed once
> wasm64 gains broader support and is adopted in the Wasm backend.
> 

Do you have recent information about wasm64? It seems to be something 
that has been discussed for several years, without really seeing any 
progress.

As Philippe said, we can't really revert that (it's now an assumption 
for our softmmu implementation, and would break code if we enabled it 
again now.)

That said, we can always have a first version supporting only 32 bits 
targets. And later, when wasm64 will be available, we can extend this to 
all remaining ones.

Regards,
Pierrick

