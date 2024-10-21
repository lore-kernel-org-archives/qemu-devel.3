Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99747D1713F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 21:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t30L3-0001y8-6t; Mon, 21 Oct 2024 17:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t30L1-0001xo-Nc
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:53:19 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t30Kz-000715-Ut
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:53:19 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-207115e3056so40678705ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729547596; x=1730152396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GNEVRddww0ZBJdEbz2UkA6f292X2zUPaCf7SZK0mWEo=;
 b=u8L5CLnPLgZawiOJTlCozF0wjgHNljRX7xgUHhQXeYjaJB8QZHZKEYMnhOEWKUTorl
 /Ty+VFEYekkvqFjc0ee5AQapvwWLxLK8ciuEPROj2+nhnHlkP4Rh/Yiwdgqh1dGTExdx
 8uC7xdQIZaQHG8DVSmQvAe9sB0kaWaoTdInbTGAflweUcvVAj1BOMS1lWImqgT69pxR7
 K7SyBTMHsjUdCnoMQemKvdx4VqMNnlhAtNJmQXlX2bIBeQ6WhBqy6UU+waD6oN3GqsBm
 TxPtjkf/pESh/Zob9quHreW53PbO9+OJatwN2uhSMwWcMPBDk5e+20PCTnGyUKkmqeCp
 NKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729547596; x=1730152396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GNEVRddww0ZBJdEbz2UkA6f292X2zUPaCf7SZK0mWEo=;
 b=MqeXpQmslTthjtREt9WlnuxbBHhXVonJ09SyX6i9/TcooEUq36hkCphBmXotx3rTBW
 +JtMg5BrpGcOv+2GXNy0OH1b0JTeDB+7MorOi/vFp3UGUO8GHDs+vjBVBnqKdLCWLd/6
 Z7zLjcanKoFcSzGMulccznK/7Abxg0qVC9b0uib44RG+SuWedobB++USOK2KUq1BGABu
 k2ILLnjAcy6eNM7PTc1Can1hhNXK26pnBZzmf+JRYVUU8XNfuR6QrHsPsOP+fBghnySt
 cSxwQ/5C16lX9q9SvLH2JVE6vr4B+9bPpSbMB6/7hZq7Ot3pOoDgy1id747d8PfKbv/6
 c5NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNfuREbXH/r81FWvMyMIr2dayH9GXLkWqHXKwXMIkAeVriBsB95idCVu4rn0P84dkRaPY1S/1fNJra@nongnu.org
X-Gm-Message-State: AOJu0YyD93yCdbQqGHCYt3Yh+23Ms+93bFt7Uc4Ufu3K4eGgaJYSuxrO
 XTigGdpv2LQXdnyR3SZyLymtVWHrmSfA28HSKO3Jq8Mp4vIwlhfIt4yley4hOho=
X-Google-Smtp-Source: AGHT+IFpbnjL9TcLTWpU/xKdBIAU0UCY9NmCf+ShXhAfP4f89UocFgf/0yOZrjCouzUD0iuiSNhPjg==
X-Received: by 2002:a17:903:2907:b0:20e:57c8:6ab3 with SMTP id
 d9443c01a7336-20e5a71b492mr132565585ad.4.1729547596231; 
 Mon, 21 Oct 2024 14:53:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd4e6sm30608025ad.148.2024.10.21.14.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 14:53:15 -0700 (PDT)
Message-ID: <a39045a4-8e04-4c9f-853f-1ed366650059@linaro.org>
Date: Mon, 21 Oct 2024 14:53:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: explicitly permit a "commonly known identity" with
 SoB
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20241021190939.1482466-1-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241021190939.1482466-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 10/21/24 12:09, Daniel P. Berrangé wrote:
> The docs for submitting a patch describe using your "Real Name" with
> the Signed-off-by line. Although somewhat ambiguous, this has often
> been interpreted to mean someone's legal name.
> 
> In recent times, there's been a general push back[1] against the notion
> that use of Signed-off-by in a project automatically requires / implies
> the use of legal ("real") names and greater awareness of the downsides.
> 
> Full discussion of the problems of such policies is beyond the scope of
> this commit message, but at a high level they are liable to marginalize,
> disadvantage, and potentially result in harm, to contributors.
> 
> TL;DR: there are compelling reasons for a person to choose distinct
> identities in different contexts & a decision to override that choice
> should not be taken lightly.
> 
> A number of key projects have responded to the issues raised by making
> it clear that a contributor is free to determine the identity used in
> SoB lines:
> 
>   * Linux has clarified[2] that they merely expect use of the
>     contributor's "known identity", removing the previous explicit
>     rejection of pseudonyms.
> 
>   * CNCF has clarified[3] that the real name is simply the identity
>     the contributor chooses to use in the context of the community
>     and does not have to be a legal name, nor birth name, nor appear
>     on any government ID.
> 
> Since we have no intention of ever routinely checking any form of ID
> documents for contributors[4], realistically we have no way of knowing
> anything about the name they are using, except through chance, or
> through the contributor volunteering the information. IOW, we almost
> certainly already have people using pseudonyms for contributions.
> 
> This proposes to accept that reality and eliminate unnecessary friction,
> by following Linux & the CNCF in merely asking that a contributors'
> commonly known identity, of their choosing, be used with the SoB line.
> 
> [1] Raised in many contexts at many times, but a decent overall summary
>      can be read at https://drewdevault.com/2023/10/31/On-real-names.html
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> [3] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
> [4] Excluding the rare GPG key signing parties for regular maintainers
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/check-dco.py         | 5 ++++-
>   docs/devel/submitting-a-patch.rst | 7 ++++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)


Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

