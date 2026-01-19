Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA4ECA5FFB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 08:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhkH1-0001z7-Cc; Mon, 19 Jan 2026 03:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhkGp-0001tD-Rp
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:05:59 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhkGn-0007L3-7k
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:05:54 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso2248218b3a.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768809950; x=1769414750; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vWY/iFJIQrIoyhkl2tx0ZEw38qj30F85p6XeY6HDnP8=;
 b=RznkiPrNSk/umksS4dzHcTpyvsDfZ0oiix8xacncYjv63rWZk9WtOFqkZ5RUN3ywFi
 MezlJmU8LZAQO1TVXe+I5akB4mQ66iK8KxuEhZC5IMVtjIb/TlBg/klS3tiJTKRo412C
 gjckNcgTC98DxBcBVMtMhU7+ZIFVP7wB9DzOrUhKLPeNEW3AlDA6GxZXkx+cT83374NL
 2iESVT9+tieTrUMaLROyB9gvD2SnynCMWCJhxBTe3tOMNR4/S1mWD8XZ0jnZb5XNuZXH
 DS9gBmyacxB1vsf+JAunNsnE3QV6SnU/KRJlis97pfYWcP9J+7Pl4sl9nzgzj1rGm2XA
 XNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768809950; x=1769414750;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWY/iFJIQrIoyhkl2tx0ZEw38qj30F85p6XeY6HDnP8=;
 b=hvwgKboxZk9HAaS8keAtKcNUwz+ri0UAMl3VjrmgiWJ2xedh81VCmgcmPSfjMllmBf
 NfiPY0+wnjf1TOlA2tKceKz4FsHvmdNcrBvXRp5sjnDJ1MolaYMQgSr3hmtrpkOvAHDI
 i+g6C6oMrWCgDClfjOODu0ZT4/g1pp/hDVeZZJFM71nu7/I2K1FslLKMZKhKik9EtUBC
 DKItN++V4jqi1k/CGIO1hq7TGZJp0vVI8TCtvw0dcc0zR/i3hnOfayrdD8R49A0Bbf94
 T7KeiTHgzSicClJPr3wjs8nIM4QEo0pVHSD0nF8mG0zxYFV8hjRwls0fibiQJLfqzn3X
 C98g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWTjpO8PCV1bDG+byws2O/rT9muSlljpRKvXag6wo+slnxJ3/B/eRM/wFrA+loyixdX7sZ+JjZQRln@nongnu.org
X-Gm-Message-State: AOJu0YyVoxrcWmnEcef4g+cKsJtKpA3weRQkv6cqVwGVY/5Dh/Q6rMe7
 aBGLTa2+8qT9KdQagHAehVyQtwgP6e9q3x8dDxGGr3sel730Ms8eT3R/8tV/M/Y5Yic=
X-Gm-Gg: AY/fxX452uYjacKOoqD5l6GQt4Ma/R8aSMD/xdIseRP8BvxCSFRPrT3Hk+gB/u7o79P
 kI7hSJdAmZT72F+7MpRK33V7oOYj0uQYb1C8eFAvwrDyfBuFMNqjuTdFgWNaRx1H430lu3li+zw
 T9HvdN35FXJqXobQPdgkkhRnf1Qde317xQrgfcn6HdfVf3nN7yxByPGYew16R20Hy2hUipCuuFN
 Bd09RrLjug+E9Jgk8yWdycCwQweyn4lrX2V43PsiZrwBCcQMm8Y4vx942T+RZ0BnVCHWqxm1KpJ
 m11d2m061oqrWCm0cOI58QgH/WyQ/eBvJHoHpKncBmWd7H1xOiVFMynAzNTUZyjvObX7H8deIYm
 ZgQpNTNnYSEK1aC8Ukp+DcIAQPwE+EqsPIJ8nbyp52KEZVqKiS+FZLciP/665opLcgTNWnfhJlg
 KArch8emwbXwxFJFswc8jAii6OCWd65LvYVaWOkO9p+Nlu4XPuUb92JrHX
X-Received: by 2002:a05:6a21:99aa:b0:35b:9ba2:8cd5 with SMTP id
 adf61e73a8af0-38dfe7c2078mr11150744637.56.1768809950189; 
 Mon, 19 Jan 2026 00:05:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352741cc52asm4079632a91.3.2026.01.19.00.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 00:05:49 -0800 (PST)
Message-ID: <7a605222-4c4a-454f-9d50-d1eac922cee2@linaro.org>
Date: Mon, 19 Jan 2026 00:05:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 11/58] bsd-user: Fix __i386__ test for
 TARGET_HAS_STAT_TIME_T_EXT
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, thuth@redhat.com,
 pbonzini@redhat.com, philmd@linaro.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, qemu-stable <qemu-stable@nongnu.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-12-richard.henderson@linaro.org>
 <bf48c6fd-bbb8-4289-bd63-b09e2492c14b@tls.msk.ru>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <bf48c6fd-bbb8-4289-bd63-b09e2492c14b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x441.google.com
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

On 1/18/26 11:44 PM, Michael Tokarev wrote:
> On 1/16/26 06:32, Richard Henderson wrote:
>> The target test is TARGET_I386, not __i386__.
>>
>> Cc: Warner Losh <imp@bsdimp.com>
>> Cc: Kyle Evans <kevans@freebsd.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This looks like a qemu-stable material (but probably of very
> low priority).  Please let me know if it is not.
> 
> Thanks,
> 
> /mjt

It needs to come with this fix, or it will introduce a regression on 
x86_64 hosts:
https://lore.kernel.org/qemu-devel/20260119075738.712207-1-pierrick.bouvier@linaro.org/T/#u

Regards,
Pierrick


