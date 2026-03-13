Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2100D107BCCD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15YL-0003yi-MF; Fri, 13 Mar 2026 12:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15YJ-0003hN-Nz
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15YI-0002Bp-7q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ae5636ab04so25943855ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419993; x=1774024793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jIMWB2PBAu46E7OukTEd5U89nTSPFXYaaw0BgqG84QI=;
 b=XLzLofwvJtnVtC2xAfLk0NBROOvlizg5KqIsukoCEMHRvDI7Q2oMS5VTO4wxZWxLXK
 T7IF3Q6bYv3aS3s8vUL7KQLciFZxQMA2D0E7YP6KztRc/SDk7fFRMb5Xw9ozABsm5p5K
 uAB16hxKh3fJ9ulCdCxwv6wpUKYRXbKD4pE7vP+LOfYwYb/+rQd+LdezgIemSwCTmVJt
 AgEf1MGM2iJ3x1JtOK7vZmdBSCe8fxjDaAxzcXnqIVYS38lprSsMCo9m6BhgXLQLMlML
 RXnpkmOIXCtgjySaEe+uK89Wa6leybVW9bnOfqFj4s1B4dL8VljA6k42N5aVqopORpBB
 EXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419993; x=1774024793;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jIMWB2PBAu46E7OukTEd5U89nTSPFXYaaw0BgqG84QI=;
 b=dRQBvSuuRLMgNVTUoAO/N5lC7BkgwDDxcNLUPhFVa1yCQK+4gAmWmCXacG4zSyxhl8
 DUCpdKTiKBhJzWnyZaaqrm+sK340FuBfIk4fJ8NptazlU6F5MPbTKnk6u7bYDShEI04f
 7FPf/5iAt0xASQsifDQitpEv0gY9aRE3GHVXQ76z9wFQSFLHPLWJxBG7A9/L9fOljxsC
 14g0PtHmFw/SnaCOkOL6H4nc2gFbLkkF4FBkT6phSPegnCkHEbRoP2Zv5abmb3/QAjW8
 JX55t/ik2ryYj8pyGxXb/FP3UHe72REly3Zsyw1kU2r+183YnZXhqHP7oJLvQR3KfUqz
 mNuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhl8ViZ65H7SOr9pFv1AFtAozZY48uCMBJSTEkkEzua50Ux1KGA3zHLV46/F5IF3X8uzi6FYl1tZ4w@nongnu.org
X-Gm-Message-State: AOJu0Yz5GxG2xGn0bVaj5HJ2jiyMDpNT4tUGewajyjzQVDwDDFullLRn
 2I5JHqSQBI8I1TigB8lcHMEsNY3haJ9A0ww84tStxiQESFprGK2zA5E+jpex/Vb1k7edfiqscVa
 UE11W8q8=
X-Gm-Gg: ATEYQzyoDRJ1rgExjIYtap4LctAWnFLwX7TGNgYMjFoSJ3ApvYDWwsEob5F/SqrO/8c
 dX5qICFangTBC13hl0RAhet1XyBPDtZ6BROZBztvdml/rl+f3DchbqCGO01LMiGRd4ArBoxgFWb
 yXiY8a8MXgsSJ1vuagHOxbJi0B+5j1SWqP/FGRaktmPkJc+pMG0hyfifyl053bfv2ZKNzzXBe1W
 LaaP6XE75D9xQO7+LaE1Gr17nYR5WptlJ8d5XCjQzrTfVBONm9ya9ibPxqfB0OWrIqPD3jvRgXQ
 0+1UHLJMoGFGhdKppB8GU0zujuSX4vKW2dAxvFWA78BCpXYTUhjo3YeyKZoQfeUUmQMOV6Eet6/
 vDM429RBybwV3rghbbevs4NzKxz2LlaAEaV/iNY17hcH721dV4/jtVBDk1tyLPNLyhodaoTxBL+
 huHR4/TM2W2f3lBcFsMsqM8Q1iHvvFSZX5eIEKT2cTRMqnrB6Nuk/vPECzAnaef8xO0yS1
X-Received: by 2002:a17:903:8ce:b0:2ae:557e:1f7d with SMTP id
 d9443c01a7336-2aeca9b8bd6mr39604995ad.7.1773419992812; 
 Fri, 13 Mar 2026 09:39:52 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece627683sm25163655ad.32.2026.03.13.09.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:39:52 -0700 (PDT)
Message-ID: <b585104e-fbd8-462b-888b-eb4c5b69d264@linaro.org>
Date: Fri, 13 Mar 2026 09:39:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/38] hw/or1k: Include full path to target 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-29-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-29-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/or1k/boot.c     | 2 +-
>   hw/or1k/cputimer.c | 2 +-
>   hw/or1k/or1k-sim.c | 2 +-
>   hw/or1k/virt.c     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

