Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC94CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQPQ-0005S7-Eg; Fri, 08 May 2026 14:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLQPO-0005Rh-CE
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:58:46 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLQPM-0008VB-Vn
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:58:46 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-435153d9b68so1420445fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778266723; x=1778871523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uyLmIHl+RgPSbDCZ5XSd1a4F5lXZ3h5g0n/X9aHTGS4=;
 b=qyOQJBZWIVRCnopIa1A9XDCVKzwaihDK8a+eCr5HNSGklQ2G0fl4CIEjc/OckxmDyg
 vaTfU1SKrcMChyXaxtAA4An1jG5LwD1Ggak4yYXIS/YV9tvySR6GOd2wPB3mNytQtLBn
 Xwx4oJ6iJBYr3OW3kNj4Dx5/6/9KA0S3JOHgAilvbLb/HDNVC0HT3npjrfkEwuaYFDm0
 GU15hTPUvTGVIfxSEec8oN/oYe731fTnz/IFCHn9/GssuYFFk8A+CNKDW4yt/24ZR9RI
 oAxy7SJR6qdzDaOs7Mvr1o2SEO/1Tj7GoDrEl9mlR+njeMbIK3IRe3UaDlk5ZW8t1AeL
 ggJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778266723; x=1778871523;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uyLmIHl+RgPSbDCZ5XSd1a4F5lXZ3h5g0n/X9aHTGS4=;
 b=YI5u0Y5Fo9+e+xCu/b9fxFSx52RFSM+PWW6Oj9pObYTGyJK9XVXjPRW7l2t4BEGwiT
 s4s6VNqPaUfQrC3+03o6NTS0hy8wCWDdNgkbx5q1+i5xsu4dUd2f9UA34riN7jsLgPy7
 8bcGGwJs/s7jFH6PSc6VomlbneJey7eVDZfVkcIxjfHUyn494tE02IrJYDs75mjT2za4
 1naaVXKHQFF0s4fCFuxbqwAcztzRFYIMd66xfQYO2R58ELXsnRYDx5aTXeVTt+hD/fOR
 ABjBb7caHFCFiAyw1M2GslsjjlzWOyjiYwvY/jfYG0584thhAiBoTwCpdwGeDGIL+YZY
 J0cg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cxdd1CjFRsxUYt7Cw/9MvI1Z90Ts+ON+/pf6k6LzSJDxvtFnAk7mCxf4m5bl5eZX9dh7VVIhPb0A5@nongnu.org
X-Gm-Message-State: AOJu0YxNBEmusfALJIR/0VEWNGEHKFlGEXLdVnH7W0sqGNKXr+DsfFEQ
 YywOCYwgSmUjMIs9VV9zb2aem7aUsy9hRXbwLS3BfeZJwHpufTo1ejc1mZtJ5+N79qY=
X-Gm-Gg: Acq92OEbPU1R7ZRnR2rMaTdxpA0SDeXuPM9EIAwZpuQdUNgfzpSzP7Qn+fs521LmZVH
 oMSWUj2DigMsO5/wYT0PsAl75yPMLJQUQrPqco6ZXUjTOI0mRuUifCQ6s97D520Sw8Mz5/wMOyg
 iQUBAcW+J/tZzUT4vPoNpTv29or4GMHhNe7s6uH2C7LViPG85jgmHI1fusICbu2zfLbaOOqj9jG
 L1yWHvNC8IY0kPovPyseZW0vYQv6szn2IJxtAwMbmr6S1bwb84kXi7gt2xFChDMyhTLFPu1zrPN
 A38oUcWkBkPUj787Crr/2hJYDbAX9gmLF/sS7o3wPckuOhW27VXXVdxA+y8N1+Tr0zJi5SN/rKP
 bAwZO56DiH5K7bQ3/PqwygD23qwnRCxA81kfNdJ35fOPxCCRvHwAvLuACfG6dBC3/nj6LCzqA6i
 3g5idwUio9s5AUgJZ2z8u+h5xh+XmNhZWVYVb2LOYi/V5612SqLhqyywPQWzQ2MUx4WZzYnj4ct
 qpEpPb3F+ixOFnYnQwC
X-Received: by 2002:a05:6871:829:b0:42c:a5e:81b1 with SMTP id
 586e51a60fabf-434f64e9133mr9310956fac.22.1778266723534; 
 Fri, 08 May 2026 11:58:43 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm2477856fac.12.2026.05.08.11.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 11:58:43 -0700 (PDT)
Message-ID: <c6d40151-bce4-4c82-87ab-4194c3f58bbb@linaro.org>
Date: Fri, 8 May 2026 13:58:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] target-info: extract target_info() definition in
 target-info-init.h
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <20260505224826.2698753-4-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505224826.2698753-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 5/5/26 17:48, Pierrick Bouvier wrote:
> This allows us to prepare next commits, which will introduce qom
> registration for system mode.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   configs/targets/aarch64-softmmu.c |  6 ++----
>   configs/targets/arm-softmmu.c     |  6 ++----
>   include/qemu/target-info-init.h   | 21 +++++++++++++++++++++
>   target-info-stub.c                |  6 ++----
>   4 files changed, 27 insertions(+), 12 deletions(-)
>   create mode 100644 include/qemu/target-info-init.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

