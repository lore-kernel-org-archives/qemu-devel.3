Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B57CC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgTMo-0006a5-OD; Fri, 07 Feb 2025 13:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTMk-0006ZU-3i
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:46:14 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTMg-0000Sk-Qe
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:46:12 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f5a224544so10566575ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738953969; x=1739558769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6PteMFpVHv0SCUiRxwY3z5U3KHwtSW68qytN5IFUi4o=;
 b=ZSgH+CJOhe54o8dKC8Fd2/rHKIWKlEPZj2QG9UwGdF2X6OgP5j6mC2aVOZI3s13qQ/
 /gOXQWFAgxFhXrSz9Rly/YqrB1HFa6ubPbSkQOmmtPu0aZNuOXX3lnFMvFwaqJe6XORW
 HzEIOAF1zgK0S14X95aC9ldugKVTmIPQUBsC92AiwcuCyZ4L8Z83CZMHfmukszrkbYzG
 FObbJaLUozxaJtCF1q0PG04WVYX8J5fmzCALOIheVofflzVAQuUAT0fziQNjJWIHO4h5
 WraESYn52HsVdfu0Re2xwwelXR0KCXMaetg4xqkNeYD1bgCbZ2+mt2h209anYkAW/ySB
 ZqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953969; x=1739558769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6PteMFpVHv0SCUiRxwY3z5U3KHwtSW68qytN5IFUi4o=;
 b=OrnKWuSUH5FAdBBtv7Uo/zNGpgoZuQzImJdDQI6SbHMjKwfvFo720cMzqWWXX/lptG
 jRjMyaYy0cL2+usJfmOLklYFFDCtn6ysJHgSLHNkCzi6t3Tqr1YnDbDKPr3NT8+4rhtg
 jN6+leVbdXlUfSyqCYqLjH4mqQQsV7U9Xn85J4nlPgXGsovYmifrSO+cX6COZGvq7vaY
 BxtZvxp67694RcPaVaf1DTCtLfI0cdm1V7+ZCChUxuKGFvROcWVzml0TR80Y/GSP+N4e
 uYM5NTx1Vfg+Zo4NkRX23GYm3FAkE+ZJ/5emPfBib+GIYivS+pwRqM7lvPXfyigz7vhY
 AWsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/BkFBA7yb/JOxd13dnu2ptLs7THXBf+KJnFfrqayRhJZ8djXOPim8jP+VvDpfba3XrFMMO2wUE48s@nongnu.org
X-Gm-Message-State: AOJu0YwGLLTeKK57+t96rwXmPj5z0C6OB937Lx0asddGxayfkWQN9Xvt
 unkWeDZWrmQu7EnII7xNpkupxyUHELt0giG27RS14VmS6vSuLrMQk+jp8Ey61c5AAn7AjMtQVEJ
 C
X-Gm-Gg: ASbGncsOwotHKEw0/8nSJF5Z+qRJ+9wNvmm6sGVPodmz1fNSTCWcPACvqbT7habymWQ
 SgHSeuG1efXxjaV7IhLqoss4EC6+C3dpx0cYBCxnDX2Kr2RadacPhliG8Ldnn3UUCLD18vRCogm
 JKPGnTSDJ3VtXOdQymDcvApX+P63XDjyd4dfETGktTcOl+pzR7kaT8a1yc7RTVAJBgshEmsrEpd
 Bm72iK0tO9I3DsaO1jB7QyUQeFutWOYfqKHj/4w/Y5fGA86UQ1bnDr1rwBvnZ6oRLEct+E21nFW
 B9jYVWW28aUqNC1YJRhfXhMbmA3RjYQqpay6lCNJBzH5EQnNQM96lcI=
X-Google-Smtp-Source: AGHT+IE7z8k4qpfSIgulmraWJ0y3FHwwvM3DymgfLwIPAxfpkzc/fz42Ze2Wcb4MbiQNvOsi75Bzlg==
X-Received: by 2002:a17:902:f60d:b0:21a:8dec:e59f with SMTP id
 d9443c01a7336-21f4e7637d1mr58683015ad.39.1738953969123; 
 Fri, 07 Feb 2025 10:46:09 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653baa8sm34150245ad.73.2025.02.07.10.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 10:46:08 -0800 (PST)
Message-ID: <1af2d33f-c876-4c23-afb8-be63447960f4@linaro.org>
Date: Fri, 7 Feb 2025 10:46:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] arm/cpu: Store aa64isar0 into the idregs arrays
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-4-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250207110248.1580465-4-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/7/25 03:02, Cornelia Huck wrote:
> -    t = cpu->isar.id_aa64zfr0;
> +    t = GET_IDREG(idregs, ID_AA64ZFR0);
>       t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
>       t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
>       t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
> @@ -1252,7 +1262,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>       t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
>       t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);     /* FEAT_F32MM */
>       t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* FEAT_F64MM */
> -    cpu->isar.id_aa64zfr0 = t;
> +    SET_IDREG(idregs, ID_AA64ZFR0, t);

This doesn't belong to this patch.


r~

