Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12210C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBSo-0007Yn-4O; Thu, 20 Feb 2025 13:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tlBSl-0007YJ-Lj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:39:55 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tlBSj-0005Ri-Ta
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:39:55 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fc3027c7aeso2662427a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740076792; x=1740681592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0YjL6qib2PCEQR/O1OQyuev1rj+ycsTMsp1L4WnsFmE=;
 b=VS34JZ58vLPGogKu4lpyfQq+dzuQy3iJvj32kLgUCv5q1dCOzTbmweKLE0mcfqPxFU
 PxvQSXvgiMf2aqg9cz/Et7o2DegL4OWv+1NKWl3Q2KAIaJxOJcsNCEANPeNS6wG+eUgc
 N4wz0zaWzSYm2L2CxuZQVY0WQr5DbdUUNIAhvi7z73PnBlN72klNVtEQKAAqxbnCBhZg
 q8qlXVcajHy3QCNIm0Rmp36qp0vFhBcCo/RtL0I7s9cd6gBcCSrmyaDgFeDdgU5YzfT5
 wEs1lDewsAcPufE3nPJFrKzpUxs67JTorLRfSyJ6oBA49q2dpv0erngqCtbUoJJMM1cY
 g2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740076792; x=1740681592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0YjL6qib2PCEQR/O1OQyuev1rj+ycsTMsp1L4WnsFmE=;
 b=gGvWVs4d2/n7k7mDWtMXLZc7JGL3sdjPGqq0pu9Cx9JoLlZOWG5Jii/XfOMnoBs+qc
 KztHdJBfFpZUOPSkgWxI1bHPzxjq+m00wZJk37loXAVSEfZwWP5NcYWQMgSiEg9XYypH
 /jWOZNTwnwxIVOgvqHRQAtpx9JUU+zOQas5kcQz06GCu+fuVWsOtZ3QrKuc/7LI+22IE
 FLb7UAVw6OqGNuaTn7zsE91gtV4cACQkmJjacpKwui7QXwi6/BzZa4O5kW8bWDgSe9gq
 ozPaNitqxjVmuOJwV1xn7Vo+B6+PwCBK73lUVOHWYd3nhRwRcNTIkn7tPpJgOFzH7Gjv
 j3sA==
X-Gm-Message-State: AOJu0YzThrlyzhwy+kfIF9muVDXE56MMa/PJ3CmGDirCmDLTmdj0XPgN
 7z34SWpmd0k2oDBDabb/QVEIzZAnBxCD3S9E7x+8AHRX1b0USUzN1drGM183se8a+L586vGgufF
 G
X-Gm-Gg: ASbGnct37S6wrrjkO0MbCLRCmDyt6pturgngeN2RdPa8DneGJPNBdHeqIIKS6HKGtNW
 mLfW/J1m3IuAYkjFplSggrqRFnxc9WWOkkjRQWH60FbIjA4WhXPcG1r3u2Se91h5klZaE9StWrh
 OwHT2mcmA0ueoIL0Vwm9HefdhZX2esuNJkEB35mauuO/IuzfcfRMuX60VsnkqOre2ooq+5BJREk
 AViDmbJ/YCozoGfPjAkejHlbHUxdsFprtN5Wzwc53F3RPqr6KRvFeIB8aiYNCUKkKklSus5DiiD
 yGRqoQ4IhO+OeeOtK/CoyudHw5Y9KrstVdV5bCO/5KzRfOLv9W1MTac=
X-Google-Smtp-Source: AGHT+IEVSpt3zeQxv/OB0kHjSaAgdSeDN/5/LEWzG8TgmjZwSaGwehvQnt0CEVpF83971w4xQRGFpg==
X-Received: by 2002:a17:90b:3c0e:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2fce78a3843mr420395a91.12.1740076791857; 
 Thu, 20 Feb 2025 10:39:51 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53668d1sm124768365ad.75.2025.02.20.10.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:39:51 -0800 (PST)
Message-ID: <d7a0260d-5cdb-4e87-b12c-32e1dee4df1c@linaro.org>
Date: Thu, 20 Feb 2025 10:39:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] fpu: Move m68k_denormal fmt flag into
 floatx80_behaviour
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-7-peter.maydell@linaro.org>
 <64deaf4f-b999-41aa-ae44-876a1860a10c@linaro.org>
 <CAFEAcA_upC=ty1PWXOSsHHgk67EoPi6rB2DhK2M5_q2mzUCW=Q@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_upC=ty1PWXOSsHHgk67EoPi6rB2DhK2M5_q2mzUCW=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 2/20/25 09:12, Peter Maydell wrote:
> That suggests that we are correctly implementing the x87
> required behaviour in QEMU, and so that the TODO comment
> I add in this patch isn't right. But then I'm a bit confused
> about what the code is actually doing. Why do we need to look
> at fmt->m68k_denormal in the input (canonicalize) code (i.e.
> to have different behaviour here for x86 and m68k), if
> both x86 and m68k accept these pseudodenormals as input?
> 
> Is the difference that for x86 we accept but canonicalize
> into the equivalent normal number immediately on input,
> whereas for m68k we accept and leave the pseudodenormal
> as a pseudodenormal (well, m68k calls these a kind of
> normal number) ?
The difference is in interpretation: x86 ignores the explicit integer bit of the 
pseudo-denormal, m68k considers it part of the input value.  This gives m68k one extra bit 
of range in their denormal, which allows representation of smaller numbers.


r~

