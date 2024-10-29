Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D824D3A696
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 19:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5sFw-00061t-D2; Tue, 29 Oct 2024 15:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5sFt-00061e-Gx
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:51:53 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5sFr-00071B-NR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:51:53 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso6032291e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730231510; x=1730836310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H3eIWPZg76QyyZL8cBf93m/bKwuNwEf1TbEXWtlbFQ0=;
 b=bRs5DClsZmWv5z2UABo11PPnU5Dny9tWyKwH0Mt1n4Do5zjMbI7FltIPD90brObzup
 2tk+Y7RqMKACpEYtP/ssVadjQtzu07J0nFh2CI38wqV5PPhGQDqgpYkDZySm9Ik8kbb+
 jj7AokR9+Ve6lYIEaHf4/CAgMBexSe5H3ipWOrulgxfEIx5bgajrEv9TkSeoo2A+a2MP
 Ox8IVTuNP9ZmxGxQijPZCIAevqGpf4SYrV3L6oKgELdxyo3z1sgA7OQCpsUx7d5MSkzh
 TObtzQjQ4k9OsRm97gk3pBCvV0FmCmkF0Wz35+fzdfjzeWUbP+xOuK3Aosv9zmfgfvyD
 soPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730231510; x=1730836310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H3eIWPZg76QyyZL8cBf93m/bKwuNwEf1TbEXWtlbFQ0=;
 b=RYGvEm9PBK5GmvlCK2fyFG71+q19feL5LXT8IQWCg79PU7OMkP98EEVTDPH5X8QLb+
 c15HMVkpYN9MVSVB6zUZlgRUxowqnqKUELRKcN4iHFq7mibKLQR37iD5livYp4PZi/3W
 aC3QHisDhWOvRO6byoqmMxA4VTlE4RF/YqWGamBNGIvXxwY4olq0rLTZgKUl/6CkRsrg
 210M+IWc4D3EEGrsU5o4U4tWK1M1dCLjHwLVO9NN3HDujS74q2V37gf+t/uIEKRqjDnl
 rUlihCOZREppjCVwUTmYnKh3QH0BrrMbwcBwSW220i7G/OiDF54IZci7jf4eTsAjgauq
 71Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUic16HeZN+gexhCzJPQN+W30wTCv+E+J6sNmCBr7B79NjkXIf+iBeD5PEfEjAHyzJwqTrlJ87pKA62@nongnu.org
X-Gm-Message-State: AOJu0Ywm9drnigd72y5ScAeZlKuZe5+/x6oVI1Odcr5OBQKKvXJfEerH
 Gdsd1Esfzpu+P4Zm3VxqY6emP6GT7TiUNRuj3mr7/zqmVihdg/V9VvmCsT5h2ME=
X-Google-Smtp-Source: AGHT+IHa066BQO3Qh+K0uXO0CAixqbi+D94oQ1o6Zt46VMgVuNfZtXc3jfyOlsBlQp/+8uVXDfL1UA==
X-Received: by 2002:a05:6512:3ba0:b0:52c:e17c:3741 with SMTP id
 2adb3069b0e04-53b348b7c07mr5981707e87.5.1730231509649; 
 Tue, 29 Oct 2024 12:51:49 -0700 (PDT)
Received: from [192.168.156.226] ([91.223.100.133])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53bc0d52d66sm37265e87.124.2024.10.29.12.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 12:51:48 -0700 (PDT)
Message-ID: <0219fcb3-96da-4ce4-94f1-8b3221a82da1@linaro.org>
Date: Tue, 29 Oct 2024 16:51:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] qom: use object_new_with_class when possible
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20241029122609.514347-1-pbonzini@redhat.com>
 <20241029122609.514347-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241029122609.514347-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 29/10/24 09:26, Paolo Bonzini wrote:
> A small optimization/code simplification, that also makes it clear that
> we won't look for a type in a not-loaded-yet module---the module will
> have been loaded by a call to module_object_class_by_name(), if present.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/qdev.c          | 5 +++--
>   qom/object_interfaces.c | 2 +-
>   qom/qom-qmp-cmds.c      | 2 +-
>   3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


