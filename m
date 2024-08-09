Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B546EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKxM-0006ik-3v; Fri, 09 Aug 2024 04:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scKxI-0006fk-OI
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:26:37 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scKxG-0000Vz-N5
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:26:36 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ef2fccca2cso19160921fa.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723191992; x=1723796792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ul4TWM1O/eViSsCqCENRg2xewmTO9UWHWns+1ydAHqo=;
 b=UySZyRFrPR5Tukzo0iRDUro0hIij6LFJN9YECvyGyfoyQZVRzvYLbEVkLNn8lIE4ES
 DEurFGNPL4hcjQpYsR9oMVIzNpYcoh83dng3rc00v9Xte2CmBg2wkCO576iv7/GMYUkv
 hHXlgApnDQBN5+47chdRcWcKUjj3J4k0guBFm7cb1zUfeWbdxftEkNiDzVdaLl1qnW8S
 mcoQHXiQL39qKM4UGaALveCU7zdO+bjjit6Q8eRfMJgH59t6EGUltcufwTIvQwkZgHKo
 DdbiaV0HgdBWCe2WJcTnI9JHGFMu8AhyZIIqa/eWzv30vlOvPIpBLLrIsneeOieDuKjD
 2DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723191992; x=1723796792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ul4TWM1O/eViSsCqCENRg2xewmTO9UWHWns+1ydAHqo=;
 b=H1XSFhz7F5nRDqRL6ZUzn57Kp2hSglbGlyzk9xFkP0OMwkS19s6+W8vZiHr7qONxfC
 k3PnqDUXvGKpDVNuBds/eRHbB4I31LiSWPVLttdrwuF7r3VgjXZmG6xCesXcQn2lrF5p
 SKaJhzygqKcT/8YmT1qeSXqJa6HLgZOLZVZs3aGtd+4ijb8sWInMstoeqNdY90TZ45YF
 JmEOjQP53ZzMpChEHoQFMqlavHoEhulRLUdQ/ekrH7ZinsngjVEEa2/Bee24ytqo77vq
 vmDCcKEwqtmpK0ltQYJ7P1tHbPm6UP12E52vdHwc528DLhDV+49q6hN+A9KVsZPLobv8
 shog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPRVsPJwjixZxsd09VTsPIqyFFfjPb5aHLoKtb7NPEjd4XnF/o+zkTk4AFRzXDA4YU29mA6gS8QPLAjhprm7hR7+Ngenk=
X-Gm-Message-State: AOJu0Yz69BWBqSj7C3QlS3ZJXK3Aj82UN7j8rpQ9rFKn7vK8/5Ts8o26
 zMi6EPExuh3m0pRRqEE9ayv/ntvqYrFM0IbzattNuXDByRBPk6k1+tQJTe7hI4s=
X-Google-Smtp-Source: AGHT+IFT6jkQ2NaUxtrclzehttIAcn9YlhsxrRt/q0Id+Psj4Us/29loSdhNfpwgOnYSD19ky+Areg==
X-Received: by 2002:a2e:b88b:0:b0:2ef:2c27:6680 with SMTP id
 38308e7fff4ca-2f1a6ce8d4amr6057121fa.12.1723191991864; 
 Fri, 09 Aug 2024 01:26:31 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059bdd72sm112997535e9.39.2024.08.09.01.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 01:26:31 -0700 (PDT)
Message-ID: <e1fcd91b-643d-4a5e-956c-0642d001aec1@linaro.org>
Date: Fri, 9 Aug 2024 10:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] accel/tcg: clear all TBs from a page when it is
 written to
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Emilio Cota <cota@braap.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240809074725.320801-1-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240809074725.320801-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

(Widening Cc list)

On 9/8/24 09:47, Nicholas Piggin wrote:
> This is not a clean patch, but does fix a problem I hit with TB
> invalidation due to the target software writing to memory with TBs.
> 
> Lockup messages are triggering in Linux due to page clearing taking a
> long time when a code page has been freed, because it takes a lot of
> notdirty notifiers, which massively slows things down. Linux might
> possibly have a bug here too because it seems to hang indefinitely in
> some cases, but even if it didn't, the latency of clearing these pages
> is very high.
> 
> This showed when running KVM on the emulated machine, starting and
> stopping guests. That causes lots of instruction pages to be freed.
> Usually if you're just running Linux, executable pages remain in
> pagecache so you get fewer of these bombs in the kernel memory
> allocator. But page reclaim, JITs, deleting executable files, etc.,
> could trigger it too.
> 
> Invalidating all TBs from the page on any hit seems to avoid the problem
> and generally speeds things up.
> 
> How important is the precise invalidation? These days I assume the
> tricky kind of SMC that frequently writes code close to where it's
> executing is pretty rare and might not be something we really care about
> for performance. Could we remove sub-page TB invalidation entirely?
> 
> Thanks,
> Nick
> ---
>   accel/tcg/tb-maint.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index cc0f5afd47..d9a76b1665 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -1107,6 +1107,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>       TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
>   #endif /* TARGET_HAS_PRECISE_SMC */
>   
> +    start &= TARGET_PAGE_MASK;
> +    last |= ~TARGET_PAGE_MASK;
> +
>       /* Range may not cross a page. */
>       tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
>   


