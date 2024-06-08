Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DEFC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2VV-000767-36; Sat, 08 Jun 2024 16:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2VT-000754-4M
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:17:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2VR-0005z4-KT
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:17:42 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so25642165ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717877860; x=1718482660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SKOFpkZH7cyvDsoDcdGLt3LBEW58WYsgTly3bbIwkJg=;
 b=W10T1Rfh95iFH7ndnXSNnV43Fa6upqAlLioKh4/jCbH32PsjBS0erJxoNhs2xsCutA
 LxiqRRQMGyqjSwfFdf2gLbvV1V4vD7hkm1C8tVJsuMJS0ptIoVnyahXT7VZWYnBq4dFH
 9VGkgezCoy78sXexhl3wUAllcH8kwdeCAspejYwNDzePweAZNmmCuyzmSBLm8en/SCLm
 3t/XIWM7fsETzAb+AITgZVXKJzL9THK5vCCsMklOgdw0tlvTJLnj8TidSIW2w3xIjLBh
 9iig9V6fjHIh0PAZqSln3yiSveBTECZvboO1MOgHvtbqda5JmPbKE7ihUZLic7Nkt4IG
 7EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717877860; x=1718482660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SKOFpkZH7cyvDsoDcdGLt3LBEW58WYsgTly3bbIwkJg=;
 b=nHlkaa8dRBLqEatWv9AgUb1prJreNQqloGYZKUTvpbG9LeZuEliDkUkAL9QjRFPFNr
 IG44sUPS+67lEG+UuioGMM7yS2lBUejS9XFNjkEWet6V//tWNfwEGVRD2y4UYXyDvthF
 De3B3ZOwlQHqSPiqh5zzdk8eGKyXs7ov/hvBYtN1xMNsh350A3TxgAikVxpTouinGUOo
 tipvll6mlZ0/BdZeSaGfmnoo0qzanV7Tef8IbZxvf7YNIT80qU4fGziD9xhirQtc9/SN
 aPzjxcq5d5laPDAQTTo9POSwLjTQp7XFIIUJ/DIRnIJuaRBG0JHAJIzD3uZ3mA/WASXO
 wjDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiZ/9hO5OY9l+FvIgS3ZLnQXejma3BD4o2XOnEUrDFqTlFytUNTdNuXfxFvjvhtqVomPJPruc8PYCgwRhoeYr7V1pyxJg=
X-Gm-Message-State: AOJu0YwDCCyMlizbrJLpTRmyiZXNSh43FQPtmwRjywf3BbAbL4Vg2pgN
 zFZEj5GqBt13ZboJUo2QOSVVlPk3wCwhk4GMAKEta6eVcaxF8FoCJFpcGi4GNuwgfJTe9MxKgSg
 G
X-Google-Smtp-Source: AGHT+IH9p0+HTWIsALjgMlo7iDlLza/OOqbppaTMZnc69WixxS7/mw0fzDvhvgT1eDJYbk8mqCsbBg==
X-Received: by 2002:a17:903:2345:b0:1f6:74f3:ac0a with SMTP id
 d9443c01a7336-1f6d03d6ef3mr63685455ad.64.1717877860075; 
 Sat, 08 Jun 2024 13:17:40 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd761430sm55488315ad.55.2024.06.08.13.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 13:17:39 -0700 (PDT)
Message-ID: <72409816-8703-4c4b-85ec-6c8b58c35eaf@linaro.org>
Date: Sat, 8 Jun 2024 13:17:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/25] target/i386: remove gen_ext_tl
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-26-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-26-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
> With the introduction of tcg_gen_ext_tl, most uses can be converted directly
> because they do not have a NULL destination.  tcg_gen_ext_tl is able to drop
> no-ops like "tcg_gen_ext_tl(tcgv, tcgv, MO_TL)" just fine, and the only thing
> that gen_ext_tl was adding on top was avoiding the creation of a useless
> temporary.  This can be done in the only place where it matters, which is
> gen_op_j_ecx.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 41 +++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

