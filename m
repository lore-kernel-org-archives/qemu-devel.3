Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550C9EA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjlK-0001B9-Bl; Wed, 04 Feb 2026 15:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnjlJ-0001AR-3s
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:46:09 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnjlH-0003fv-Fr
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:46:08 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8231061d234so224242b3a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 12:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770237965; x=1770842765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lun9Lb+QX4WVFdWMEaSyNUaYuqr3Hka1aVgD0N5WlBQ=;
 b=TNss9zpILBBNpkJiLxlv8sdr2wDGy30rd6Lt/V2OLIVhrXR3dgMQieUJVMTUl2qLIi
 uYh/3oVb1GhswPKaykmymZlJA+ZlBTSFxzdcR2b84MtHEsDwZrReQJlGG/IcXFoyZhSt
 /2EtWv6KkZk/hGHwdLZGTXbrIYfgN7OVU/Wp9n+bwLfcPkdB7A44kf06eODqyrki6hSb
 VO/EEo/EzYZKqTo3H1I0RX6t/xbog/U4f9U4c2IHMg+6Znxw/0loowN6fyDfYwg1ti1t
 rkahFIvaATELq9ZiwgmGVR3y2W4by/eqIV2ay4XTsPUbk/tXXV2F029wPneINOrMNobT
 h82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237965; x=1770842765;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lun9Lb+QX4WVFdWMEaSyNUaYuqr3Hka1aVgD0N5WlBQ=;
 b=gxGYdmNZX5NnZVGh+Eu9nhXU05OmARy6NxlOhKs6KwN/FQVXRjFP/2d4Tjv8Y6L4zN
 gUmXFx5pjrE/ZYGRgh2MNEkjK4TTDguyGcq4bMAdi1k24jwymD7I4ei1MEULHVVRfYsD
 W4jSinUp/SdOrTetV/mZjLCtd0NsGuIJvmjm1j3iLvAsJ0kWUDQaSSMYGDy97ZCe0inT
 tgeOEWbTeQ5lwm8cV066++UlVUtYQGE/PYOKN4Dnwym2udQz8wjwzVLMVpLNUKrNhliG
 TRbHCYC2elVv4i43CH1EUSGTa0d4QcOndBWu4Ch06KuARNQWgfK8lj3zUOwZJPs9Ng2Q
 AHQA==
X-Gm-Message-State: AOJu0YyZB5HLL5mJRGH60ZZZ9EH4exPtVhO1E9tdTlqg4ahHbr2kxStd
 UkGOg1QrAy5iWthbYeFn96tg91rud32qEBAwkXT+9nXzZqqN/XCHMLV2GF7/82iZiK4=
X-Gm-Gg: AZuq6aIzBSccG5u7VvQqetxLZ37UxwhyyKj7U2nGFke3Bu2xFvmAFqa74pbKgCX8mSN
 OFQzlG7i6EWIHti9/BBgprueyZgJeEXUPkDTDehiZUnEEQ8L7Banf959lS3fQaCxOeriiqu1RZV
 Xnvs3b4Iaa5VKXZK6q4JcGvqTAQpURWb525GAJAbIk7jdPvAmJu4dA+9RWp4rIjhJNRwTFK+IHX
 ZUU4pwk8P0Ep10MUO2piJFYJZ95g1eAVOb1vHCC1uWYZ9LAC56MZROcpJGPNBrNm/bBv7tGtPoL
 d623UkYTI1ouMm1tQRscdb50PBR3y6rGSaYkJ/zgswMFvCW76X9gqE7JdhIiC7rerlDwR4uMTNt
 3sEFT/yOSrKMuSy+ADOpg0f8cU3FOflE5NIzB/wayXpl9AktOBBuHjVsb8LTBDwDmyp1G2SDuAO
 tJ6ZK0lSCXpYbftE9gArcEUFJQmuw3RT8vpOuaNTIccPSYtPLk3U2b8bxAdS2vf1WuPTpeCV+Oe
 tWXJZmp3AqzvePioClWnRQmvrRADyAod7n3AtYijg==
X-Received: by 2002:a05:6a20:d523:b0:34e:7bef:e820 with SMTP id
 adf61e73a8af0-39372413fa5mr4606240637.41.1770237965482; 
 Wed, 04 Feb 2026 12:46:05 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:110e:c2b5:eb10:f92d?
 (bg30dhzn9pdmmwqf9rf0.ip6.superloop.au.
 [2401:d002:dc0f:2100:110e:c2b5:eb10:f92d])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8322127bsm2852541a12.12.2026.02.04.12.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 12:46:05 -0800 (PST)
Message-ID: <5c46d3a3-e046-46a1-ac5c-5588a2179441@linaro.org>
Date: Thu, 5 Feb 2026 06:45:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tcg/optimize: possibly expand deposit into zero
 with shifts
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-7-richard.henderson@linaro.org>
 <4bfd463a-f7ba-4bea-9fd5-27c1a05045f4@redhat.com>
 <4f299aca-b1f5-473e-9cd8-dc1fe997d19d@linaro.org>
 <CABgObfb3zP3TYCz04Rmg+2HZbXZjKFvuACqznJm56ET9NhBhzw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfb3zP3TYCz04Rmg+2HZbXZjKFvuACqznJm56ET9NhBhzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 2/4/26 20:41, Paolo Bonzini wrote:
>     This is primarily for x86.
> 
>     (1) movz is 2 operand, so that may avoid clobbering an input,
>     (2) movz is 3-4 byte whereas and r/i32 is 6-7 byte.
> 
>     Because of these, there's a comment somewhere that says we'll prefer extract over and
>     (perhaps in tcg_gen_andi_* or fold_and).  IIRC this also happens to simplify ppc and
>     s390x
>     insn selection (and vs rotate and mask).  AFAIK, no other hosts are penalized.
> 
> 
> I think it would be better to pick a canonical form for AND with 2^n-1 and handle 
> conversion to extract (like PPC rotates or movz) in the backend.
> 
> Picking AND as the canonical form also avoids makes the macros for extract validity 
> simpler too; adding an extra constraint for immediate 2^n-1 is easier and it generalizes 
> to other PPC rotate and mask cases.

Picking AND means we have to use "r,0,ri" for x86, losing register allocation flexibility.


r~

