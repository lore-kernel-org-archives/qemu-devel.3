Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32747109879E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bvE-0003Wj-UY; Fri, 20 Mar 2026 11:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3bvD-0003WO-9r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:37:59 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3bvB-0003PP-M7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:37:58 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82c20b9f989so222617b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021076; x=1774625876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4v9qCCYtNl9abIWnNJdoHNmf9JIEl3xP4H0BlVbHX6U=;
 b=d9Xpd68nlzAPMQuE+po+dhyBSMHdAuUL9H5RT18iGxEHIWa/l1AxvGie1brQITS3mw
 ZaI8Al3/66yuy5WKQ9sk7HJVaYv9AR3IXzR9XewaFFP/b34pyDo7fUNOZtHEbAB9ZMLV
 RVcgLUHne+VDAqcLS8zTnJ/Xfaz0NogsNOXZR/R9KXM/v92+l/SGpVJgyUm8ihey1iT5
 Nch7Aq6shTAJV7dQ91TtUITQL7sEXJ+Gw3RUI+ESZFyG3Iz9devFoMRkyziGRhcI//y2
 UT7czYP2RUfuhIsvruTpnjmIPMs5240wal/nh//VTiukjBuf1LQE8AOsLEFMfU4p7mMy
 /p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021076; x=1774625876;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4v9qCCYtNl9abIWnNJdoHNmf9JIEl3xP4H0BlVbHX6U=;
 b=PvYsvYFZ0OJO92jqGS5e5comJSJkiVp5aQ4Yu4xMhr8JWKbLcCEt0mFjrEElqciAVW
 iNA536ItnAYlD2Ws5WNe5Ix9rDPjyhw0vT8c6Id7p3TJxGWWmzHfXz6orLzURNK3G+a+
 9YNy7aEf0x8etgU4YMvy6fSK6ifh1VMTkBkvTyM2TerOiEDSv2bTiKlKQj0rVtIlLl6z
 1st0tRGirkCuzrqj+62QACUYOukvbp4I9X57jR4y8GuuUBxkrVd1sAgqeNVHGYeUkn1b
 eHg0DaU/E1idUZhyVWL4cgyPW+7YrbHzOyDUcRYkFAtROlRx5gNEahKKX1kiBviTS/OQ
 dSeA==
X-Gm-Message-State: AOJu0Ywkl21hsojJ0EkwLgWO96R1o5VAY9oo3bf829tj8PhpJlb4JPOF
 PBSLAv7u49SEkoIqUq/U0GdZ41Nfz20wx+NR8fEnrcD9KtRCtCorq/PfPF7pe4qbOZ8=
X-Gm-Gg: ATEYQzwoFvg1L/Q8iJB86KQVEasP7g11BhopNvo5QLNefDDb0/b8ZWQv66KGW1HGplq
 bUG7ObwcskbTFHUi5tu3XytZDS5aQiiH2S95gxUVwWaJze19y752XUze26SGkSIRXEIe+mBTThZ
 vtm75qPyJCt5h5Gh5fjzneFLEbzg9Gze/1JwTMQwQolPb9DTOLL0zUa4APIGIFNsjRWTxGFbJCc
 4mN3afwI0z37GvIcXfXDsgSRtZRniHhVe3uac7NxKhfeXhRV8Z2Q1571t9tiaJDrH0oKN6+jCjo
 7wecEjgpMYv1xayc0mCIcLBgjuX4kfTcYuQJGKrhyCerR8KJy6HfYH4XmDzcYwqSankRLb4nLl4
 H/lZKKNwARSpPx1tQrTJUKrvoVBZ3gVQtNWz/5a6oOwSuuAcVk3mG3lUjfNBXXVlSDqz6fNXYiS
 xBE3yGmdrLXnlpeS/5VrFgfSmvc1Lbw/cM5HFQefZZvK9slw==
X-Received: by 2002:a05:6a00:21d2:b0:82a:6b97:34a4 with SMTP id
 d2e1a72fcca58-82a8c351bfdmr3179739b3a.31.1774021075596; 
 Fri, 20 Mar 2026 08:37:55 -0700 (PDT)
Received: from [10.5.0.209] ([114.23.167.13]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03aa58dcsm2676966b3a.11.2026.03.20.08.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 08:37:55 -0700 (PDT)
Message-ID: <dedd88a2-cdc0-4f0c-bbf5-69751b9cd827@linaro.org>
Date: Sat, 21 Mar 2026 04:37:49 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/i386/signal.c: Correct definition of
 target_fpstate_32
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260305161739.1775232-1-peter.maydell@linaro.org>
 <8d76a679-4d7c-4c3b-80d2-11799dc98fdc@linaro.org>
 <CAFEAcA9HgVmbe9TXGOZW5Vbkvbn-Dvah24f1oPn4zvymk=_mZg@mail.gmail.com>
 <a38b768a-3a80-47de-8a03-11faf2b85526@linaro.org>
 <CAFEAcA9dCKF0H=MkNmOmxnfyJV+SeHk_tObL558MJ-w3w8aQSg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9dCKF0H=MkNmOmxnfyJV+SeHk_tObL558MJ-w3w8aQSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 3/20/26 22:23, Peter Maydell wrote:
> On Fri, 20 Mar 2026 at 01:15, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 3/19/26 22:27, Peter Maydell wrote:
>>> I also note that for the data structure I am fixing, we never do
>>> an xsave/xrestore on it -- it is purely junk unused padding.
>>> The real xsave/xrestore info is elsewhere, in the dynamic part
>>> of the signal frame.
>>
>> That is an excellent point.  The structure you're fixing is never really used.
>>
>> It's only use at present is to be included in the ia32 sigframe structure, and is only
>> used for padding.  As an unintended side effect, the alignment of X86LegacyXSaveArea is
>> inherited by sigframe.
>>
>> Perhaps we should simply have
>>
>> -    struct target_fpstate_32 fpstate_unused;
>> +    char fpstate_unused[sizeof(struct target_fregs_state) +
>> +                        sizeof(X86LegacyXSaveArea)];
> 
> I did consider something like that; from the commit message:
> 
> # Replace the use of X86LegacyXSaveArea with a set of fields that match
> # the kernel _fpstate_32 struct, and assert that the length is correct.
> # We could equally have used
> #    uint8_t legacy_area[512];
> # but following the kernel is probably less confusing overall.
> 
> Either way works, so I guess I don't care very strongly.

Ok then,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

