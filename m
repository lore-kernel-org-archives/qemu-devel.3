Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA59FC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 18:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRFAh-0006fS-9M; Tue, 09 Jul 2024 14:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRFAf-0006ep-Gb
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 14:02:33 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRFAQ-0001Fs-6n
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 14:02:33 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so38920085ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720548132; x=1721152932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Mp2G6k+JninUoOEJZtaHihsFVlly49NVK1VVQJqjic=;
 b=qheWC19coOkpWvUvd1aJWZkFju6r/f2w17WanPonHMUgmqeVBDUunA4iaSmBWYdRch
 YYA0EWdggAzlesgJzO406WIyuPM9Gz0yg31w4XtzkqWVw62divOfTPsQMsJkbP8Ij3bF
 Xk9SaBTUpHzV1EpLNUNyKlC+VWFjB2ZruhAcDCl6a9Ll5GZOEE5/m01/JTtSfM+qmIFm
 be1xqM0dX+2PUBaK2lwdyNDc1RukDXLt9ifAEPuunXPj6kk0b//wMjs62+F0WEd01cXc
 EMZXIzJhErFeHI/hr2W5oN8/+BWDUuF6pPDSggyh508YJR2EbMBekk61+kWIlllfljA2
 w2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720548132; x=1721152932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Mp2G6k+JninUoOEJZtaHihsFVlly49NVK1VVQJqjic=;
 b=lAj1pgPXhZMFudSeZoyhKkRRUIUKWQhRHRgrZMGwRnbEb9Sr+SHF0YAa0JF+NnIFg0
 7gqmLFyNP9yTzzIZGLD4iByr1B8fjk9mjXw+X6eDWS59rNXsar2xx9/8RGWVk5GLRf0M
 ODPeJkQDLoftnXaoJLP7eoG0y+WuAv9asfzDGlz5+TE+YYry2mQ9rgS3w3jzy3XB3p16
 wt1wzHpulf3QW/QwPNUT3dne08PlgQ5AEdi0wMO4/sdS1/oMaYfx5afjVHURfpHNZM2q
 jI4wPg/lq3DGE+D8FVPQad0IiBN73RIrNuRTjNyGrbTKs3/MgzV1xq0+Zo8lbWVHntzX
 DAFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAyoIZzcCb49YaxFxfyGKL+zITIJlA8CnntgQi4x2mV3tpigUqDhKdB1/bsOcG/meZMmFRrGZdBTxGhEf/3X4jnjr5ak4=
X-Gm-Message-State: AOJu0YxvPoHIKsMuMTKRt4ApcRJrjMwAQA62ktAzJ8JfqDgL/JaYaN74
 JY+P2Rc9MLaMIJzM7mPDl3Wt+v6gylnEcWg0ny7jd/EJU9SdnEsRyPsK06A0pos=
X-Google-Smtp-Source: AGHT+IGaTi7vDy2XGapRvYMRa5q09tUUCWjj2r+ksRm7kFstGta87cuZPed9vD8yESsHs1z1Ohj8lA==
X-Received: by 2002:a17:902:c950:b0:1fb:4093:4712 with SMTP id
 d9443c01a7336-1fbb6cdac44mr24008065ad.10.1720548131807; 
 Tue, 09 Jul 2024 11:02:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ac084esm18961955ad.183.2024.07.09.11.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 11:02:11 -0700 (PDT)
Message-ID: <7505ceff-d92a-48f5-9c05-4c1f1124ab06@linaro.org>
Date: Tue, 9 Jul 2024 11:02:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
 <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
 <Zowd-UxAnPmJSA0G@redhat.com>
 <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
 <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
 <CABgObfa8KQOu6RPs1aqKww8qPeOjHppbH15aBCN+KvaOL=_W9A@mail.gmail.com>
 <CAAjaMXZ+Sx_+4sNFs=zy+bP0d5gbyf_Buh9JS-ixsRCfxsdN4w@mail.gmail.com>
 <CABgObfb3mmxZy_cEeUTbuGCN-3Nqs8x8dkGy7Ehyowd9LNbktg@mail.gmail.com>
 <Zo0qh51MPlmfFVUP@redhat.com>
 <CABgObfa+daKTnJ9ATCqFUHD=ZJK-KM+VDpMA6R_YPrvsGYx00g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfa+daKTnJ9ATCqFUHD=ZJK-KM+VDpMA6R_YPrvsGYx00g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/9/24 09:51, Paolo Bonzini wrote:
> On Tue, Jul 9, 2024 at 2:18 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>> My thought is that the initial merge focuses only on the build system
>> integration. So that's basically patches 1 + 2 in this series.
>>
>> Patch 3, the high level APIs is where I see most of the work and
>> collaboration being needed, but that doesn't need to be rushed into
>> the first merge. We would have a "rust" subsystem + maintainer who
>> would presumably have a staging tree, etc in the normal way we work
>> and collaborate
> 
> It's complicated. A "perfect" build system integration would include
> integration with Kconfig, but it's not simple work and it may not be
> Manos's preference for what to work on (or maybe it is), and it's also
> not a blocker for further work on patches 3-4.
> 
> On the other hand, patches 3 and 4 are _almost_ ready except for
> requiring a very new Rust - we know how to tackle that, but again it
> may take some time and it's completely separate work from better build
> system integration.
> 
> In other words, improving build system integration is harder until
> merge, but merge is blocked by independent work on lowering the
> minimum supported Rust version. This is why I liked the idea of having
> either a development tree to allow a merge into early 9.2.
> 
> On the other hand, given the exceptional scope (completely new code
> that can be disabled at will) and circumstances, even a very early
> merge into 9.1 (disabled by default) might be better to provide
> developers with the easiest base for experimenting. The requirements
> for merging, here, would basically amount to a good roadmap and some
> established good habits.
> 
> An merge into early 9.2 would be a bit harder for experimenting, while
> merging it now would sacrifice CI integration in the initial stages of
> the work but make cooperation easier.

I would be in favor of a 9.1 merge (disabled, not auto).
Noting that soft-freeze is two weeks from today, so no dilly dallying.  :-)

The only reasonable alternative that I see is the kind of development branch that qemu is 
not used to having: a long-term shared branch on qemu-projects.  With which I would be ok, 
up to and including a branch merge at the end, as I'm used to working that way with other 
projects.

I think the only reason to delay the current development work until 9.2 is if we were 
still questioning whether using Rust *at all* is a good idea.  I think we're beyond that 
point.


r~


