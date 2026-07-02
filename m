Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKIM-0007gD-I0; Thu, 02 Jul 2026 12:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKIJ-0007co-4h
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:29:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKIG-0006CK-I6
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:29:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8478cc93299so1641204b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783009776; x=1783614576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MDr90+ABY75zPycwyGciDbTvFUJHeXA1hxI12e3GsYY=;
 b=kD67L53/6jSTleHlLZ8OrUb1fumU/OCkTntb5r9zll/3xEMV60ATejOWMMagGCmy/g
 SLN9S98QeUV7NqAQIUrRg3WfBgPZWFw531D7sot2JAq9hzWvD1Rz+uMJbmUqh4yeK7yZ
 EUyrb6RtrNlI5rr7gA5COF7QsOxqu/Cc6T2LN6LsgSxpV1gfp/P/TeCqMr+T8NrGhcm4
 yeIAujZw5qfpl4KCf8/kW+yUjqUVKgPIpMBG4hJ2uerGRqYT2qfM7VHgOyeF6X7fVvf/
 WKi8lTFPTGWoyDboxbKIIa9+EvEGieQFx4FHZfYFJy9n6Huo/qcAILJtwsgzVgiLCV/0
 yAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783009776; x=1783614576;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDr90+ABY75zPycwyGciDbTvFUJHeXA1hxI12e3GsYY=;
 b=iNcPCjXgLW/NGZuyWaL18fauQ+ver9W8h0miuXeWJM0IbsOeM9WlXNST3eNpxGIf6W
 iqshtB5pTCBf1E7UFYkldbK9G+4WnxDg9FfcVkrqvMpeUGexJMK6cxNGdK9sh5EPdxfq
 T0LW35hHDTzq9df90jQcDOKOUk7kkGNrkn8JHJYDAl2luTOVpgZUTANo7QJBug0mVKx6
 0Sk3iiv0Jm/DEZVv7z1txXDukV+kEFbLMvN1eivAFmQ4vkqCMh7C8524V66CaOaSbWEQ
 +GJafGRpq5+lXVA8JkGdxOkg4vXM6rypFAN86ZPARkkrTd6DchqcsylwShAOwqg4f13b
 DZUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lA4um+MRyUiZ8hhTk3rpdO+ByfXjbBYSvO+dEdiDiw2lWIYV49yctgehECkbCOA40dSILxKNCEYE8@nongnu.org
X-Gm-Message-State: AOJu0YxEQ1dhE19oTybIF88WP/ZMVi590ez1RxriEeXhr6ugMyOK6ozR
 G3JPb23hRXa4lhCFaRX7ne/5lXODGZ+wmGGBK8wQJHhUoxJmYDKM55eOb2sYNQi52ic=
X-Gm-Gg: AfdE7cmwUMNVkdrr4B8AhcNnLEL7R894Y8rRZ6ExOr8m5B37QH6J4y+CFVExGCcD+Wz
 AKc1gWmfnw0VMqn1+sm5dMozj20RB65c5C74WgvGsJ6Xi+F6omMzgSgfftGeF+FNWlK7to2+G0t
 dF3ADr7SoHCM1xL+Kfx5ECXc5+YY6QRDJqR3tgbwBMNel8bG/LMkiVFvAYODnyDzIlqBTWT6IjR
 XyyxjVdo+GA6IGH2vfqWRr0Zu/tILUaBTDOv0dnpsnNNyaP/x2M/2jwYVXDbEWMMxJpy/DjZGqW
 rSJJqZ0ozjnoNWkuheuC+KeaJ7f3UFeJMjsY7lcC4PKH0Aqx7y0xicbCajB/Z/uBSh/h24bm0xb
 54wQVeJD1tqq8Ot4/9NHxMSvC3pMst+AaAjQ719OfyZgF0hmFnTVeEOfF6f3x1Oba8jMCw1vtVL
 LQUmDJHtuG+lh8X08NA1O34gNzG+aV+Aj/xvjR9jHBAzTiX7bkcw0Jn7PDGFP7XVjG7ytJ
X-Received: by 2002:a05:6a00:2887:b0:845:e740:8ba6 with SMTP id
 d2e1a72fcca58-847c090a608mr6160201b3a.43.1783009775901; 
 Thu, 02 Jul 2026 09:29:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb76cee8sm1670827b3a.23.2026.07.02.09.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 09:29:35 -0700 (PDT)
Message-ID: <d3b5bd3e-939d-4b59-8c94-433d7064d0e6@linaro.org>
Date: Thu, 2 Jul 2026 09:29:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] accel/hvf: Remove left-over comment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Missed in commit 6bf331164c5 ("accel/hvf: Drop hvf_slot and
> hvf_find_overlap_slot").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   accel/hvf/hvf-accel-ops.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index b74a5779c3d..dd2b45b7cb5 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -62,8 +62,6 @@
>   
>   HVFState *hvf_state;
>   
> -/* Memory slots */
> -
>   static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
>   {
>       if (!cpu->vcpu_dirty) {


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

