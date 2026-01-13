Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D697D2F32D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 19:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfk81-0007bg-Vr; Tue, 13 Jan 2026 14:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfk7z-0007b7-CP
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:32:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfk7x-0002lF-AR
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768332747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dgs7e0VJf7FjNX/oODX3kmzXKbqOP9h6mRN6h83mAks=;
 b=DfUJRSrtcVG2fsP/W/XaXBcmd4wh49HoZCLS8NL7QxukMs1WbhSKB9SZQBThaiv/MHR3zW
 xV0jWEM8QuZqWYQ5wUfTDd/LZ9kGkdxIQ3zGIQALQ4FEGwC4fKk+Mza9l3sZigLHdEDgAk
 MfpnpI2WAtS70pwwEuqTcQeNDVeN5cU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-JqNiAH7uNRyJehviTo-LXw-1; Tue, 13 Jan 2026 14:32:25 -0500
X-MC-Unique: JqNiAH7uNRyJehviTo-LXw-1
X-Mimecast-MFC-AGG-ID: JqNiAH7uNRyJehviTo-LXw_1768332745
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-431054c09e3so4679304f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768332744; x=1768937544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=dgs7e0VJf7FjNX/oODX3kmzXKbqOP9h6mRN6h83mAks=;
 b=K7jSSq85h2zNS2L7oFbHlngGVgNDnMgYIk7BAEzi3TsXkZJyf2MKz9Z9bUUTlgXevP
 hbd3415nj5r33T8hGbjZFgLKLs7AUSVa9S1lXxcHlC6I7q71zb3Oh+YQ00dH9dGx/KLh
 q87L/ZWuT/lZO1/bzWAgy+t4+reDaoKlDUli/Sm+uL3PpUhc2jcGsv4T11YFdzROEKOn
 lj/8X0uuSIS23eUMmXRQlEW0H/PRGYNRhZh+d/Ge+gJaBboDaGIb1yQUERKmD4FUc6ga
 QkAJYwPWAN0HzNRtWy51vwPTiqahjUfsZthVjsWik2BxZ1QhG2gv+Y+QfZVAkAGh9GJY
 uZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332744; x=1768937544;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgs7e0VJf7FjNX/oODX3kmzXKbqOP9h6mRN6h83mAks=;
 b=O8yCZmdZARAby+3vjs7ukHtG4y9XAvIeE3hMa+xSBgLTJyM42J4pBP+bPzRYtp23Dn
 puwbtL4+3AFiTXl6GsKqfBPsOa7TybVod7FFwwvpmBdskVa4e+0q5sCSue6D/IashEk7
 JJsyyQJOSJ31yiygaPh0RbkC/RCbCSsfyZ1LfoypeHMnkj+OUUapTpkIlwTz4xp6uSA2
 kZBG3YIYsmYDY67Gc6zaS77coxq1x0bnDJMMsYEZntj4c75ANkposZbwC3twzMfBbQiy
 UJ7K+msdiPWD0CotVztfaUMO+VrhWcHGQtVE5r4lyIdEjzhF+jKeXjxlcS2KAogF7R5e
 XaEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+CQKPXBliO5tbBDTYRwLXu0xD4Tdz944b12t2T2HMYAhE6KzexMFwVB/kbYfqYd7B1LuUUsScpEya@nongnu.org
X-Gm-Message-State: AOJu0YytacaPGtDVEVp2nxR6ChnNJxWz7uTQEC6EMYuoOYmlq8b29tiX
 v6W276yxuTk2CA9NmQ78wuN/U+sIWa2zHnelPJtSbDrnGnxySriY4dzxdJ3z4dvjqipm9NCbktw
 FuiWzuPJBuULZVfdSlyijpTNlJHWyC6M7YViz2eMKwwxI/mH/N9vAyyds
X-Gm-Gg: AY/fxX4WDepppzuj9yI9s9ByP6aFKUWZhVgbWDXE0s7czT/vPeeiCpUstCEMvRhU1QU
 R7/VAQFfVcMQBCw4ejvGxF3X3qDm/dt6z697Y21hmTLkGG3MNKFjSSP/VCkJiKoJyYhmYpI2Zki
 x0r9PGBu3YPIiLObGHaEA9Hhoeo+5/ADZolE15Xuir38pPjyOL3bvGvfu3KbFKKx5OAvRQq0bNx
 o86pjFSTDpq9kdT5H3mS6SJFQAFR/VsBm2tTqdw4dI4h1QEjFUDM/sHv8lsJiKtODe0k3q00Ps/
 hnsBaxlryezzq1vVG2cxr+bsiWfbV/ddOXvsNKLfnJ8si13QYrWh0K8RM2OzvaMhPoTuUl5F5a0
 ffe9G5xw=
X-Received: by 2002:a5d:5d83:0:b0:432:86a3:ef2e with SMTP id
 ffacd0b85a97d-4342c4f7da8mr44673f8f.21.1768332744553; 
 Tue, 13 Jan 2026 11:32:24 -0800 (PST)
X-Received: by 2002:a5d:5d83:0:b0:432:86a3:ef2e with SMTP id
 ffacd0b85a97d-4342c4f7da8mr44654f8f.21.1768332744152; 
 Tue, 13 Jan 2026 11:32:24 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm47135529f8f.22.2026.01.13.11.32.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 11:32:23 -0800 (PST)
Message-ID: <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
Date: Tue, 13 Jan 2026 20:32:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
Content-Language: en-US
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250704101433.8813-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/07/2025 12.14, Philippe Mathieu-Daudé wrote:
> No need for accel-specific @dirty field when we have
> a generic one in CPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Message-Id: <20250703173248.44995-20-philmd@linaro.org>
> ---
>   target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index f1c6120ccf1..aea61a6fd2a 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
...
> @@ -982,7 +981,7 @@ nvmm_init_vcpu(CPUState *cpu)
>           }
>       }
>   
> -    qcpu->dirty = true;
> +    qcpu->vcpu_dirty = true;
>       cpu->accel = qcpu;
>   
>       return 0;

FYI, this does not seem to compile:

../src/target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
../src/target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no 
member named 'vcpu_dirty'
   988 |     qcpu->vcpu_dirty = true;
       |         ^~

Is anybody checking the netbsd builds at all?
(I'm currently trying to update test/vm/netbsd to version 10.1, that's how I 
noticed it)

  Thomas


