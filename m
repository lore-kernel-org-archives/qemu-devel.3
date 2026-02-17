Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DEEE909DA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 17:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsOSl-0004Gm-NZ; Tue, 17 Feb 2026 12:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsOS5-0003uT-IA
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 12:01:36 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsORz-0006PL-Vn
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 12:01:30 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-436317c80f7so10172f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771347685; x=1771952485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77+c0e0Yovg9ap+AlPSHMs2Po67bUb2lMPPGT6TCzaE=;
 b=owrz3hZTr8zrSrn/kO/Vkez7dukjWrqjycmMSN3UDn+cpzkLp5aGOGP/hmcVeDJbOP
 RTKMb+sGeM+gIXzPWbqJh6qP7D+fJ/x/LajsWq2A8xDcjYWTohnvA9UMe+q6A4eVW3a+
 EqUMCoA2ReVDO8Qpp3PAWqQTo0QWyBPBdiwUb10QtY7QNTvsr4xdWpSCCtiwXLEHYHfX
 PNjuyTuc48iFnSZDB8T5/LJt0ndHnVzlp8PXG873tlKkl1b5q9S9XRV9Hd3al3BK6hKl
 BVXrXPaVUMo17XfQwtxTJnkrrYLCKz2GccxVFY7QkLAA9atyRjQn+4HCYk2JMOcmvadq
 G8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771347685; x=1771952485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77+c0e0Yovg9ap+AlPSHMs2Po67bUb2lMPPGT6TCzaE=;
 b=WKeujSDoW9BrBxplCoTYrQeAP2vKr/U+QErKp7TYErZ/kF/N14awvWabWczxV6iuA8
 Y/MIZmkDIbpq4MgH1Ph8SubIn621e0jGlFw3++yErU+OCcVI5MalmkSupuZkn5q3P70X
 VzgMxURl68656kLkbXVaFyXzszFCrgr3CQDnG3poNJ1g/GLAgQ8GVUhO1CT3tuNRG6I4
 ZYHYpfMa6zjzm3LzQZFMN/MPLwWN6XrVnSytg6tpB1f+cIDEuT8J90/dwESVSu2NyYiW
 vXzBoIJ2GAbKQQr0F92eVihtbWzl0VbAaDBFCHExBvYj1gJV3dtiEm0zaEl5z7Fq4HTE
 HJKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ7LifGrdzJLVRrCrvNzfYAGOOIzqYaUWK1bhkyG1sB/ucJ40/krp7ZhKUl6CH/v+88lt+o4oIk5rQ@nongnu.org
X-Gm-Message-State: AOJu0YxFnEuqCf/eubL+blGv4MOrnEVuxt1WIAEyQTmGefhszPl1mnqa
 mq/WDOMIl4xt3u5AjaVxO+/qtxM8FT2i56ak1JdaTkMjdpgnOHsEuFfhH9qHUktqCoI=
X-Gm-Gg: AZuq6aJpIe9mEsGgGnVSxnGE/Xn8afw+vrmNRXJYdUtsAGNE0KqJaxVEgrJSf51cFLR
 V5Zvql7xkwkcoC+ht4AKXQmdIlUDncp1ZJZAaFEluIjFZWKPriTBtvtrTDIkNjhz6HJA/M0gThO
 bS9mp+ksnP4e2pOg7jYxeJzXQCblgSfO/XHwvmvP6CiATynt34kH5FdeooX861FiUnXtFLHd8q1
 4eHDXxFApsntDFRaBtdkA+wBWwCSZ5ILnQCFN6Zoo/nlou9oq9Y1G/x+c2JofjGRlfybM0PH8RI
 U0r5BNjtnnF4CYjvorg6HqAyOMCklM8ZBy6YZAs8zXevS8jR0/SLDZanrEzM6y4v1rJ9y44MM5t
 vuWgd7PTEd8KSFcUVi7BPBYJq4nym20ZaWCxUp0nxU3cBb/fJHpME2IwghgufSnYe2YFkG0ZYe7
 FOj1vXU2MAOk1pVmPlixP19yKyRImcKlLfm++HVXXgZqZc1V/NCSPzfH9FmkLJsrHP5Q==
X-Received: by 2002:a5d:5850:0:b0:436:180e:78d9 with SMTP id
 ffacd0b85a97d-4379d5db880mr23928365f8f.1.1771347685038; 
 Tue, 17 Feb 2026 09:01:25 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm35438517f8f.31.2026.02.17.09.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 09:01:23 -0800 (PST)
Message-ID: <68c6ced9-dcbc-4981-b2be-65cdf7e2de9c@linaro.org>
Date: Tue, 17 Feb 2026 18:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Yodel Eldar
 <yodel.eldar@yodel.dev>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Akihiko,

On 17/2/26 07:34, Akihiko Odaki wrote:
> alpha_cpu_realizefn() did not properly call cpu_reset(), which
> corrupted icount. Add the missing function call to fix icount.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   target/alpha/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 1780db7d1e29..74281ebdb367 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
>       }
>   
>       qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>   
>       acc->parent_realize(dev, errp);
>   }
> 

We ought to rework the CPU reset paths, it is too confuse.
Peter / Alex / myself have been there. I started some work in the
area, fixing few inconsistencies, but it isn't a priority so never
got over it.

We really shouldn't manually call cpu_reset() in DeviceRealize
handlers, thus not add more calls, rather remove. I appreciate this
is a temporary kludge until we sort the cpu reset logic.

At a glance, since this is an icount issue, instead of adding
cpu_reset() all over, I wonder about this surgical kludge instead
(untested):

-- >8 --
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad94f96b252..0577c25e3e8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1071,2 +1071,3 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
      tcg_iommu_init_notifier_list(cpu);
+    cpu->cc->tcg_ops->cpu_exec_reset(cpu);
  #endif /* !CONFIG_USER_ONLY */
---

