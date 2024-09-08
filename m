Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E59E6FE49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 20:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snOrK-000481-Ix; Sun, 08 Sep 2024 16:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snOrJ-000479-2U
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 16:50:09 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snOrH-00060p-77
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 16:50:08 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d8818337a5so3332117a91.1
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 13:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725828605; x=1726433405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eyMuXNqy+IuvXaTmqWI47AiF0YnUoGol0NjynUy8l2w=;
 b=dxaF0dLO4CWJ23WNCJj4z36qzaRqavAYBgAzJuKf91Z1bKBs0e0dTjjviNnPYXFwa/
 KB6DyzSZ41KK5yQAoHPnlQJr6FS58LcwhUUpdPMlSzAQNZcQnz9qNstvvmqFnWWcKbEV
 hJMWQh0xkVg5cUlKTi42/LlUbJH3flOSdBVIbM6uxdF21octfGOncJWGzo7oVbdr5tKr
 gLu5QzACvx31ght5ltCjMdLBBGNtiQcEAY/ohfsvL9ACUImrdlnJlr1odAV0CGtocgwd
 w5CV+F5Ua0jqocuoDSVjY00LjyioyPdb1FT5GTB/pc3BLaKVmA6OdqTqTO0OaUGW/X4c
 NEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725828605; x=1726433405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eyMuXNqy+IuvXaTmqWI47AiF0YnUoGol0NjynUy8l2w=;
 b=pfjnBdxWrclqyoRjjP0lAj7SYexXLxZkJpGbiNCjX2RftB5h2DYcdTmENi6f0q1f1W
 TrmIhU+lYKaZBbvu5BpzSuJjjdnubcEuEUTd+tTx1Vy0Pf8AM6lgAKgszzgmdrJ5TZU8
 zfEZ9IlyWF/T2rQEF5+5SP/8CqFUlSkua9UNZozypbCNqDHSZ2GiLEX0Z3LqdRCm1nLq
 erfGDd0mOP1M0Y/mcxXVB3QZB0fVI7f2ixtarOvcnKZBm3cGnwOoG+zwEehcYU+UVYSk
 yhdfg9+zmMZCD0TjcGE6dZVTfNQZBi+iiZhF67L8XGiP41UZHBvD6KzatACmuXeSpUV4
 YUYg==
X-Gm-Message-State: AOJu0YxP4JTEVZ+X+XRM9WQqBnTdVnhodTSAnwDEn7HWteIyOb9QwbWo
 thMNOe/a3JpCCva8kum2xuJKhji1ZXqXHZNpaRU74Xw+dkG16WZKyzxHugIoIrg=
X-Google-Smtp-Source: AGHT+IHeMc0Arcc490eLc27VBUkBoRBHPeOYLSDHQ1o0hkRJ75VIN3iNi4tdckKSkny52N1i3C7g6g==
X-Received: by 2002:a17:90a:a58a:b0:2d8:7a2d:62e1 with SMTP id
 98e67ed59e1d1-2dad4f0ecefmr14964211a91.2.1725828605084; 
 Sun, 08 Sep 2024 13:50:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc12dfccsm5188057a91.47.2024.09.08.13.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Sep 2024 13:50:04 -0700 (PDT)
Message-ID: <2ecb0e6a-b2bc-41e9-954c-8381bc73afbf@linaro.org>
Date: Sun, 8 Sep 2024 13:50:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] linux-user/i386: Emulate orig_ax
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240802095942.34565-1-iii@linux.ibm.com>
 <20240802095942.34565-3-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802095942.34565-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/2/24 02:59, Ilya Leoshkevich wrote:
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index a2961f503f4..85ba5a53869 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -159,6 +159,11 @@ struct TaskState {
>   
>       /* Start time of task after system boot in clock ticks */
>       uint64_t start_boottime;
> +
> +#if defined(TARGET_I386)
> +    /* Last syscall number. */
> +    target_ulong orig_ax;
> +#endif

Maybe place this higher, in the existing TARGET_I386 block?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

