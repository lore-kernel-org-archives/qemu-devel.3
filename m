Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40737C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG11N-0007sn-US; Sat, 08 Jun 2024 14:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG11K-0007sJ-N5
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:42:30 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG11I-00075B-LX
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:42:30 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6818e31e5baso2675837a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717872146; x=1718476946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gj028EnYJr9GCwyASiEcOdYkleewxVSWvWA8Xs7QBdY=;
 b=Fj3QHgZM3r6b5GO2Vqgsq1o21pBoYnC6SU0iTaAclTIQM650rH3KngZ61YPrgxQmjc
 nAg2gRIazXC/9sEZVoF7Fz6/tZRpwEv1ykTb7qpcXuClReuAky/6SsqF2GoGHqzQohxI
 +JtMFwi4FI/wvwmSDiajpJ+tisAslpC51JMHiX14f8rAQ9bvdcXdQgVHoQFpCeylj1a4
 5E2EES18JXR56ZkEd6kCRIkJfVVCmambgY0fum5wdgw4GwuVZWh/RR8KYGjknwpyq+aX
 Eov3rCKWDNv7rbfZHVDrzb+/9GnxTJ0A9kbh6nSQfsb/Nh9sXlMASBUgZ6m9MupxMsca
 E1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717872146; x=1718476946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gj028EnYJr9GCwyASiEcOdYkleewxVSWvWA8Xs7QBdY=;
 b=bWIh8osEjAZLYbJZFyUlGpIbEnzytBexzzGDvSQe8VvwdlHotpmdNSdyTkTzfUZrPw
 0UGpXkjKFmixbSgaArtiohigJxWXkWQsSSmuS8U/d8WysxBtO4yOyb5Otc+D0Kk7WwY0
 Q0B5pmQavJFhlwxuZGeWg8/+4RCgjTNCsheWmudrYBqVJ4+fouwsmIyUYA6+mXSBRMzW
 IG1SmwzwJ2mFOkeGWtTsugCt9bF1MyxIfm35ZeYOm+7rVjZ9R4b9GRXvgcA4EeEk74hV
 olCvF1eJWk7AG27HVyy7SDiXLXAtpATrwwOCWIpwK/c4zi6qqeCWp6qvyBuWfmBwa7HQ
 Je1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWukH9jY2Ggp4oKL8HokJiMhpkPokTUZFyWvswG67HsvtLP0itJ1Aw9zGxaSLb4eghDipugUiHZA/jkjgQusFxaoqrRFiM=
X-Gm-Message-State: AOJu0YyvJRc/ka0t6m+mrBIumFh4u/fV4pw9cZn/fUXsU8XmQH6o6L7R
 l0r565/I9mXs7/0drcT/97jnh9i+aVq3j0UJ9M+IhMz6bTiyWDVKAUNLDrVcNfQ=
X-Google-Smtp-Source: AGHT+IGSvo6QHp9NAdXejcFI1mNMnkoiOAwS4e22iW/lrkw9c/8zkfMX8DgNWfbYqO77s8+SC1BUyw==
X-Received: by 2002:a17:903:41c2:b0:1f7:414:d679 with SMTP id
 d9443c01a7336-1f70414dc42mr1631675ad.55.1717872146461; 
 Sat, 08 Jun 2024 11:42:26 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd760225sm54972135ad.15.2024.06.08.11.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:42:25 -0700 (PDT)
Message-ID: <df4dd9ee-11eb-44fe-a2a2-b8b2d14b06cb@linaro.org>
Date: Sat, 8 Jun 2024 11:42:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] target/i386: finish converting 0F AE to the new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-11-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 6/8/24 01:40, Paolo Bonzini wrote:
> +static void gen_FXRSTOR(DisasContext *s, X86DecodedInsn *decode)
> +{
> +    if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
> +        gen_NM_exception(s);
> +    }
> +    gen_helper_fxrstor(tcg_env, s->A0);
> +}
> +
> +static void gen_FXSAVE(DisasContext *s, X86DecodedInsn *decode)
> +{
> +    if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
> +        gen_NM_exception(s);
> +    }
> +    gen_helper_fxsave(tcg_env, s->A0);
> +}

You want else's here, to not emit fxsave/restore after raising NM.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

