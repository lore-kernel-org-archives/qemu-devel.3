Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE871C27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEU7s-0007XT-GM; Tue, 04 Jun 2024 09:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEU7q-0007Wy-OP
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:22:54 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEU7p-0000ve-69
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:22:54 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5ba65c2127cso400886eaf.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717507371; x=1718112171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mwUeuguyi1BrOrix2EWNigmtHwUKtXNcbL/LUaqUa1A=;
 b=ib96ez4fpsnFFdzVLwEMO0UXvE08SGV9b+8Hr2KY693+CXOaq0WGtThRTuHHiUXfjU
 n/0lsVOz3O6s9CjmGhO2Ghvig7kutlm8MVVcbK4esKIyJBP/mVDsZ0xjpCtsV75JGZnD
 ZQRERAA3bceO/CbP9vr0DbFfnQYtpb+nO1VmXFAj5833A7oyzaEPm888rIno7sLte/i3
 dFkCPKtre/9qJtjoae4AfGEspKPLz65XC+OF/QlCfmgyDh8UPiZD4JC+FVQa5rJweIPm
 ekq/RmsKgKJ2eb7UAQNgtluF0ZslJeROv+LFjfhZ1YOCtFd0yzwen6vB3FeYRdBuMpQG
 kfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717507371; x=1718112171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mwUeuguyi1BrOrix2EWNigmtHwUKtXNcbL/LUaqUa1A=;
 b=R4jO4fzi9RZ595z88jz3AE+NxEOYUUZLPhLNkQ6BK9OiKk/LU2OrJjegyX3CYspyUt
 TJEr0292lWN//rsQIi17aTGOhPZZQhBHaRof3rr35KCnK1Y9DHnvB3oTfrAZL3ePZWRj
 JnNKGhLU74uKi2hK8OvF7aCVQe9q1jOieivUPoD5QHIa3SrngIIDiIJ6P9ET/fFIP3bB
 UlxpPmpKsbHF5JviThFp6mDNaSuM2wxU5DFAkmk2y5rLzpP3mjmuaHnnD0Rji8wsle9U
 AmJepsmzhEt0eqkhFUkfaHjc027belXSIsULWaNzJCXDoxw1KZXlZUO+VeG0jy5Sw9cv
 Fbeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpgSjb85v41W1bNgn78hyIsVfr+XXsgknRarky6S7KjKovzvZQzeQTIRccA2W8zrSMQIa0r71+YBJLrOA/gsRhT7iPkBo=
X-Gm-Message-State: AOJu0Yzz73WgxKExW97TYmXTAbKR40daELgelyp+SLMtchcJCwKEi23p
 IlOkSaYrJH4mH5bnTt9932m5FojGmmh9b6AZJ53y/dQW5fFe+PJNzw5Sud0K8It5KvNA0tVo9lb
 O
X-Google-Smtp-Source: AGHT+IEsZA3bB90GZ7P/H2MAhNu54xoVp29OF6sI+bqqpi1FsltSmnAOwFdkYP6ppVvLC0X8zBWe8A==
X-Received: by 2002:a05:6820:1608:b0:5b2:f2a3:57 with SMTP id
 006d021491bc7-5ba05a9f685mr13148352eaf.2.1717507371281; 
 Tue, 04 Jun 2024 06:22:51 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba004f25absm1942288eaf.45.2024.06.04.06.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:22:50 -0700 (PDT)
Message-ID: <0dd4d577-e3b3-48d2-831c-9334d26ba65b@linaro.org>
Date: Tue, 4 Jun 2024 08:22:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] target/i386: implement DR7.GD
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-6-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/4/24 02:18, Paolo Bonzini wrote:
> DR7.GD triggers a #DB exception on any access to debug registers.
> The GD bit is cleared so that the #DB handler itself can access
> the debug registers.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/sysemu/bpt_helper.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

