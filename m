Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17014EC01B1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4bzf-00027N-4J; Mon, 23 Mar 2026 05:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bzd-000261-3u
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:54:41 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bzb-0002KK-Cd
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:54:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b94a19fdso2444053f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774259677; x=1774864477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8uPgG5J5PjJUfJmoUsFe9xRnPOKjQq2k4lhmyoBxMyY=;
 b=o6yioX9TvZ8GwFtvGzSO0668NdGsqkgvzPaYLlWZTq2zuMW6CA9/VwI8EF7XUffxS7
 D9o/FsuDFZjmEGCucMrsPab0ykkfObT1tTjae+wEZj4ZyDY1DgXZ0sO8kmf9gbYX7uWm
 yjLyMi1ODJTHun5kL5Y+ZU0rviME0zmOrz0qT4dSAcaOytpFmXyvyBQbxm8eUMd6jupn
 Z3GGSyr1ksc2cktUZho3/15pzxG4/O5IZwFFpePdF2pXIr/miJRe9Llqi1vAUEYoYNqm
 O83uCCL/R18wuUqubf4zm3vIclLa+ZmzXgAHR1sa6RquMguSa2P8dUhaD4tU/USPCoM2
 RE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774259677; x=1774864477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8uPgG5J5PjJUfJmoUsFe9xRnPOKjQq2k4lhmyoBxMyY=;
 b=UjwrHFeMcqpeXooQv44TQkVLDfFX8N/2c62NgYIRasnKnhpdnfynGWl+wZuaD/gTKa
 a1tHH7GmiJFyzy2sBp/ZIsU+FkMrdgmSqFnZgODVwTo5Kd76IlHd1JWvzvuT4EcJUGn4
 6ENXv7SC3oRAuREfR8pJHFWluffLitcMc60nkWnPzszTXAyTzxs6VOCKxXYD8Xt3chdv
 nlsWoZ7OBnmVmJ9bhYsDg6F6UHpbgTbyzl2tO8Jh7PUw+YX2x0IIeN9Y7h0nsuZobqrW
 hq5rVQ3y0TnciS1ItDXMuXnI9G7Ep9FsBYYEK6DBPA9381wO8yO35CcUx8On05nuIor4
 Dclw==
X-Gm-Message-State: AOJu0Yx1v+jbSaD1ZEJtj6qcBPvdK2dosT6HdCnxbRWJzzNvIzX6cNCx
 jN+WvLhG1SI4gqTokom5LbHEehSFmAi15+0vgb5+w7VOcWbdkmKhMY7V+g0pLGXU/DaYKiA/M4+
 UhZdbXjQXzA==
X-Gm-Gg: ATEYQzyJE23B6ornK7lQJq0CTOuNylNb4/W+RVlv5WUWvPies6vY7AEn3ACg5yfqLw7
 YKW+nnPOpQfgBIetUSDepA3SaKRa/xq+HExQTYhNEH3L1l9uiG38CKQoPUxh56+X8mLzY1lA0Ba
 DD1I0Dl392iRBgnvQkIAJRbzS9L2528hoFMXgZkYbFqN2SHuttjukr9DvPSVZaapZkaelBRkAsV
 olEcvq/Ly90L+h3wS8lyRfPhsoQ3abuigKbjCxakcQNTp5qv9i/5tk5Gu5AlCQ9TvdeNFkUIAOj
 WV4vk7FYSxKm+AjIZAReTtXjwGPVzT3uoXOxE5DzF8/wCKQX3ebBwaDnjvXY41EkMg/mnTgcJGn
 ouLzOWuDRG06KjLeQwVm79ZtI1lLl13j4geP/d7tBief+P/xYrp0UNBBKuJrInxWnCxam2OGh5g
 EdgPxuoaD+TgydqKHX5ztJYGJdbcycF1yjTiMqd7NGqWGoX8fQEKKcfiM+j8vWTWSz2g==
X-Received: by 2002:a05:6000:2c0e:b0:439:b744:c5fe with SMTP id
 ffacd0b85a97d-43b6427d272mr17635100f8f.52.1774259677234; 
 Mon, 23 Mar 2026 02:54:37 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae37dsm28192391f8f.2.2026.03.23.02.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:54:36 -0700 (PDT)
Message-ID: <d3dcd9e4-0df9-4e39-8660-31570f92775e@linaro.org>
Date: Mon, 23 Mar 2026 10:54:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Replace target_ulong -> uint64_t for
 TARGET_X86_64
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260315165319.39727-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260315165319.39727-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 15/3/26 17:53, Philippe Mathieu-Daudé wrote:
> These registers are only available on 64-bit builds, thus
> always handled as 64-bit. This isn't even a migration break
> because they are migrated as 64-bit since the beginning
> (see commit 02536f8b1f9 "x86_64 save/restore").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/cpu.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Queued for 11.1, thanks.

