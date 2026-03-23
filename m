Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CDCEC01B6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4c03-0002RE-AA; Mon, 23 Mar 2026 05:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4c01-0002MR-2x
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:55:05 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bzz-0002M0-9C
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:55:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so5530811f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774259701; x=1774864501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=veW2TdckBctyztJTUtrDnGjbSdCSJOd+WxFVVe/HMN8=;
 b=rQPimDzErfwI4zBsRKzSWLzuswa62Cc2ovYhFCWllGiWvu97858vkfosus6T92SFRr
 AgCXSSOjtDCakieU8ctp7LI8P1rZLnAWqz6Ha1tMf+Ma2SnoYmZeqPr+fM9u/RqfgpUB
 U2Co6ugJX6kZux1wUFcUbNtAMu1vk02KAWzNi+fsSUXH15e2i1g8MxQxCfJP/d8q5h8v
 r+Cmx9ZLMNzkHro+unajiLVUXwy6uMe/qoELxnTpygf/Sae4wEH6ThZ9tYZitDuX6OQq
 4HHtA+bejHopa+9FyCVyN5bidKkfEmMsQUKq77x0f8qVsjMjw3aALjS09FcCIb42IAOW
 R72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774259701; x=1774864501;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=veW2TdckBctyztJTUtrDnGjbSdCSJOd+WxFVVe/HMN8=;
 b=PoprbLy4FeCZRNTH/ppOqH7hTp4IRKRosdv+z5K1lWB465XVubavngPsmvxIPNM9by
 ftvTBgT/Hgq6JdyoWfSHOa49F+p9f0ZCg/fNus9rxwePky6+CHT8CDqs14xY+2r5Fd13
 z2y1DIKCX0iD82Stsxd/u64dnG5pxlZOV2ZwMj64Xt8PJ82eCYqmXkyobBQv1P/F2u0N
 488Ba52LgxQghaQMS8YduxHzOzskeFeV4PZI7G+Fg4xRri2ZDefsjbq+qLYtDQuMsFWU
 it0HBRio5nV4SZ19JMMVWdMEs0AuJ+YwYtb4Qzr40qoSVGwrdK9OGnvTV0HHsBN+i8O+
 Iv+Q==
X-Gm-Message-State: AOJu0YwMo0n/eL9jCYbXs5Vb/i4FKluN5ipZd8901XhcQQbnzngGFAn2
 whkyJrl6JIK2E8MaR3bjlDqaQ3Vey+QDoQqLAgPOrZdkBUWjR+HLnqywpJOZmmkTr2Zzdg4g7km
 ukcfCaulaSQ==
X-Gm-Gg: ATEYQzzaNFt43Dx2S+09Trs9d0zpKNkBx6g5Oa1/oxBEHaoRPvIJKh1bzCprPIkGCem
 BArEQ0PB0O7d7Np3QiOXDE6b7gIs/9JJ6qCR49rar/KI+DEIr/r80nOx/tVV2QiH97qINhLljy4
 EC1vDEzPBd271/kRPOZKexdxmZrue1WOWTeae8i78ivGHkf+qSaD2yldbs8fTn62xo3YQ1f9ZLX
 2qz6oCYN/wmiFxHpUdgUmOw2byXhsWLXJGsmBVXAXbEmqRuuQ71dF7+SMBZOLzcIC9gBQaFlciI
 nP01jK/8ZR+i2ZJyVp96CZi+db+6NmlC5kBGIgMa79LN4ktOUoyJ6xgpLVgmk7yn6uSSkYW9Ort
 0RAqPxqMOZ7K2SbyfZqRkkVnn7OvLvw5DzLZl+tTZD2xbYcwuS8LYabVl1xGyMeUi94l1jt+Vbf
 rotceaeoM0H0W915C/mcpe53z2fVnuKM6c3OQ36wtMfxoXnC6IcgmFLnCVoiYKWnJs0w==
X-Received: by 2002:a05:6000:40de:b0:439:dfae:8083 with SMTP id
 ffacd0b85a97d-43b6427863cmr19264257f8f.38.1774259701016; 
 Mon, 23 Mar 2026 02:55:01 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b646b0b0csm26905665f8f.15.2026.03.23.02.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:55:00 -0700 (PDT)
Message-ID: <64fa4546-f815-446e-89c5-26c7524030c6@linaro.org>
Date: Mon, 23 Mar 2026 10:54:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/38] target/cpu: Do not include 'exec/cpu-defs.h'
 anymore
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/3/26 07:20, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (37):
>    target/arm: Remove target_ulong use in hvf_handle_psci_call()
>    target/ppc: Replace TARGET_PAGE_BITS -> qemu_target_page_bits()
>    hw/s390x/vfio: Replace TARGET_PAGE_BITS -> qemu_target_page_bits()
>    monitor/hmp: : Include missing 'exec/target_long.h' header
>    target-info: Include 'exec/cpu-defs.h' explicitly
>    target/xtensa: Restrict inclusion of 'exec/cpu-defs.h' header
>    target/hexagon: Include missing 'exec/target_long.h' header
>    target/hppa: Include missing 'exec/target_long.h' header
>    target/i386: Include missing 'exec/target_long.h' header
>    target/m68k: Include missing 'exec/target_long.h' header
>    target/mips: Include missing 'exec/target_long.h' header
>    target/ppc: Include missing 'exec/target_long.h' header
>    target/riscv: Include missing 'exec/target_long.h' header
>    target/sparc: Include missing 'exec/target_long.h' header
>    system/kvm_xen: Include missing 'exec/target_page.h' header
>    hw/misc/cpc: Include missing 'hw/core/cpu.h' header
>    target/s390x/tcg: Include missing '*cpu.h' headers
>    exec/helper-head: Include missing 'exec/target_long.h' header
>    target/cpu: Do not include 'exec/cpu-defs.h' anymore
>    hw/alpha: Include full path to target 'cpu.h' header
>    hw/arm: Include full path to target 'cpu.h' header
>    hw/avr: Include full path to target 'cpu.h' header
>    hw/hppa: Include full path to target 'cpu.h' header
>    hw/i386: Include full path to target 'cpu.h' header
>    hw/m68k: Include full path to target 'cpu.h' header
>    hw/microblaze: Include full path to target 'cpu.h' header
>    hw/mips: Include full path to target 'cpu.h' header
>    hw/or1k: Include full path to target 'cpu.h' header
>    hw/ppc: Include full path to target 'cpu.h' header
>    hw/riscv: Include full path to target 'cpu.h' header
>    hw/s390x: Include full path to target 'cpu.h' header
>    hw/sh4: Include full path to target 'cpu.h' header
>    hw/sparc: Include full path to target 'cpu.h' header
>    hw/tricore: Include full path to target 'cpu.h' header
>    hw/xtensa: Include full path to target 'cpu.h' header
>    hw/avr: Build as common unit files
>    hw/misc: Build 'mac_via' as common unit file
> 
> Pierrick Bouvier (1):
>    hw/misc/allwinner-cpucfg.c: make compilation unit common

Series queued for 11.1, thanks.

