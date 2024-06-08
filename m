Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4C5C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG16F-0001gu-DN; Sat, 08 Jun 2024 14:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG16D-0001gF-TP
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:47:33 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG16C-0007mg-Bp
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:47:33 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6e9f52e99c2so190398a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717872451; x=1718477251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sXIQJhmt2t7U4AjigUp+szJWOuo4ME8Gmx2nONkkyrA=;
 b=jTvCfgj/HEeo/tHQGlsPoeRK6eRMTYEEXuBnpwiNwOkeeXzsUTRkC/riPQaTmCdDeH
 I4/V3h1sEokmfS+DCRlVmUWesA2qihvFqeBe5n0R8j5xJXSPSZ0EFthaQbE5N2AF64DL
 MWZGp7x5e5tn3ADf8WIE5Mde2diLoOVJPQvLFV5QbTWisbCdCTaJDD/xzDJ2f/1T7l9z
 e3USpqKV7EbhIs3VKYEYsjywD/NA1KvrgaRlGkCnBCf/qomt2HOxeRqBhEw9vzJcWl0w
 eEKIbRzXklrTA0uH7LzgzA2hAa5JnnBG85VLT/H1izKd0WQtZZ4YpKNvRFbelJOeNSZl
 5MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717872451; x=1718477251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sXIQJhmt2t7U4AjigUp+szJWOuo4ME8Gmx2nONkkyrA=;
 b=bZaL1k0MsxQdTW7blCqYea4xyA6oD4ova+frN/a5uo4GyajYAWctaguBuzSXog5b7k
 i/BQ7yfHNM/m1Rn4bwfMvTEWdMbzFZqwwlwd+/tHNTSDVhP//yJjqxmK8o/aMx9CGH0/
 bCOoI3f+DC9csdt3tm35nfskZje/njTyt87PJK+M7zaysjS/922teTG54GOnQUOMat9F
 9gdiYjOZSzIzYcVBYPtw9gtAwAUVnpNH7IoONQO9BtXfait5G2/W1pEpLJRx0AXi5g3q
 8DzcaCquHPMn/lNK85XeaTBUCDZJuJCSjIbnyWZ44y8IYZAQ1RTIDsWw6lU6a1Atynob
 HSHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD0/XOvOkFNbA5YTMrAnJ/RRnWhJ9YXGXeCIvuzo4TPK7q53cBCbvj2+gtJ6u6MgtaviMKOqfeyWeyOVTwFwk1vQ1MkKs=
X-Gm-Message-State: AOJu0YyJHpyCgF0IiIlMSeuvWEtDBy8os4mfhoe4Xy5rCuNoKN3+HzwG
 CN3Fu+u/C5HykmuydBtrTfWVX+CUYUFtUu79DfuSSvNufMHwOZ72M7/h6fD8KQXjSXoQXPC/5DP
 n
X-Google-Smtp-Source: AGHT+IE4zvpuLK9/DqEaFmg20wwK0gwI/aGUw7fMlluEtARkRNUDTIP4vyA/UZ20da+MdvhRzHpLyg==
X-Received: by 2002:a05:6a21:3393:b0:1af:cfc2:8069 with SMTP id
 adf61e73a8af0-1b2f96d6969mr6540192637.4.1717872450592; 
 Sat, 08 Jun 2024 11:47:30 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd76bbdbsm54471585ad.76.2024.06.08.11.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:47:30 -0700 (PDT)
Message-ID: <47024745-2b10-468b-8145-e5192dd93546@linaro.org>
Date: Sat, 8 Jun 2024 11:47:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/25] target/i386: split X86_CHECK_prot into PE and VM86
 checks
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-13-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> SYSENTER is allowed in VM86 mode, but not in real mode.  Split the check
> so that PE and !VM86 are covered by separate bits.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     | 8 ++++++--
>   target/i386/tcg/decode-new.c.inc | 9 +++++++--
>   2 files changed, 13 insertions(+), 4 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

