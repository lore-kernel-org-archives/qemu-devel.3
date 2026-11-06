Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB2606A334
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xj9IZ15z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPE29-0001Kl-3o; Fri, 06 Nov 2026 02:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xPE26-0001Jt-Ai
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 02:06:42 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xPE24-0004c1-47
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 02:06:42 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso185352f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 23:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793948798; x=1794553598; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JFO3oSEU1vOMULwohE7UZZcdkuXjFvGj+btGyl5NkdE=;
 b=Xj9IZ15zJRfE6peu57Gy6ekucJm6iIPir4NtwqgUviR+5PZJ9UkQZgwaDnb24C5pRh
 f5KTj8fRhaoy/VjZOTFWgmdZgI5oOJF/5SY0JkhjWgXmwYMNKKqnCuJ2cKBmClBPTGMd
 ooETiHxFaddXdvcdc16F8vVpQzlpojPQQZ0sg35nejPAOR+wffacD0fTzi0voq6jpMal
 B+9bFx/KtNaquqDESomuiRxo3HQPXN0OAFHYu8ezpkFqsW1MH6dxOnOjmgSWcOEK9Wa7
 9MXUBLUcLxZD/eX35H/Tk6OIwzEnMFQ31Yperwc9785eAiGNzKXIN1xzzjbxjToWJy+W
 EvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793948798; x=1794553598;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JFO3oSEU1vOMULwohE7UZZcdkuXjFvGj+btGyl5NkdE=;
 b=JJrTUFBC9yEGXHOxZJblRyS2z/TEw6VDIM8yb9cJfTQuAe0qFvJb4JQiD9JsbiHGpp
 orhJcN6QQ1De8cf+u6m+N1ekCK2gy6wsgZNtCqZC3p1Psv3KUFFV1oU/wsbsIZ0P85GA
 tA7iB9WnW8Wz+57zed/bhp99x2RhABu6c9HtmB2/chzfotEP6xcprYd9AVu+B0uH+bmu
 8l/4dVkdlYVCSTH3nRzXGEWQsQUleVeRs8BJluiv/W6qCoQHaS+Iu9kMJL64auMxvZSp
 XshAO9fMMNd5EHnH6MchutlRviNFeAIfOWP75rNM8XDcDAIls6P7c7Rk4REcbAC5EZk/
 1gBA==
X-Gm-Message-State: APuU4Z8bb148M0kBj7enBYyVccpyDM4b1aJOnLJ39wnpe3xyIl/S+ka1
 9IJziSi401UB3ybP0/a9D0dwOfcL4NvtYXt/nS5mTrK7kqY7qfmOoot7UDWJj81jYQc=
X-Gm-Gg: AYBFou2yEQgW+l+454ija9VmKeS3rmPp+rmY585LaP8ee5iUuzbYzfrhFdhIw4J0NeS
 0Ot691kQRRejKKu0PXNK/L72OiIteZdeiTGkZhXfnhOjtDVS3SQ6J4WX/yP1JVZ1j+puDhW5Dv4
 0y5fAk2WpsoFI3pXF79TlQOU+bkvzPibejE8xJhN+O0x01aaNYNzVEQkuXiiS7tj/eKqxGAPRIB
 2FxkgeP3HNI1Id4ZwFTakaNOKE+C9SjXF0+vd2H1r8ev9FijqhDOPhFSXIl6xm/BO17rgQENe2D
 gwPTAftRFVJli4JUttXOhZ3hF7wGRgN/dKp+zvF5UE6brIgc708YwZj4wwLbaZExEskIoKgrzhG
 dsRsEoBAVopu9wC5iUG6+yRBT+eQ5k+km2uCCpO/F5wxcAOA2QCgbx4Zp/cgCTkHzpkp6VR9wQt
 TAa7KLXZXpVCM6pHC1OCpHN6gc1T6E68Cyt8teex8We52H0efzqHSVKALbRqglDWWajMTJ/yh6m
 u6j0LtCz4ADMPWl5bGkAtKCFDChCDDxnGN00I4mpwIsaIm2XyEufRFmIQXFn3qu55FQdKyKKlBc
 QWnJ/ZqVKxwZjNH0IBKY0SYY3hJULB3SFljACBElNmYc8QizTlM5cs3v/8Zd8e2b2QIDqt+8ete
 htaYwQV3vTY45kjh3fFAVP7+IQZJZItbheFkEtucLU1VkKEg7tEKRLmZmbqV/TWjxh48JG+HBbg
 eT0c9+vXhp+QOp+poY71gxzMLFgAT4TkmhLA==
X-Received: by 2002:a05:6000:2488:b0:48e:2448:ea23 with SMTP id
 ffacd0b85a97d-4927807f0a8mr3433230f8f.55.1793948798488; 
 Thu, 05 Nov 2026 23:06:38 -0800 (PST)
Received: from meli-email.org ([94.66.192.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc5f11sm1823352f8f.49.2026.11.05.23.06.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Nov 2026 23:06:37 -0800 (PST)
Date: Fri, 06 Nov 2026 09:05:39 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH] target/arm/ptw: check XN for ARMv6 in get_S1prot()
User-Agent: meli/0.9.0
References: <20261105-armv6-xn-check-v1-1-fbeff926e692@linaro.org>
 <CAFEAcA_qmyR0E3+n8GByA6=kDwDQomCpk399DEc8pOPr=sqEaQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_qmyR0E3+n8GByA6=kDwDQomCpk399DEc8pOPr=sqEaQ@mail.gmail.com>
Message-ID: <to2jr0.1wqw0hsi7q7wn@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 20:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>On Thu, 5 Nov 2026 at 09:44, Manos Pitsidianakis
><manos.pitsidianakis@linaro.org> wrote:
>>
>> For the ARM_FEATURE_V6 case, it seems like we retrieve AP and XN bits in
>> get_phys_addr_v6() but we don't check the XN bit in get_S1prot().
>>
>> Change the `if (arm_feature(env, ARM_FEATURE_V7))` check in get_S1prot()
>> to `if (arm_feature(env, ARM_FEATURE_V6))` since v7 implies v6.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4367
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
>I think this is worth backporting, so:
>
>Cc: qemu-stable@nongnu.org
>Fixes: d8e052b3876356 ("target-arm: get_phys_addr_lpae: more xn control")
>
>> ---
>>  target/arm/ptw.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index 2e67d02493bd463cfd2d31ecf1316272ac3f1d99..b8b22b014e0574340a85abe73f3d9611d2360219 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -1595,7 +1595,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
>>          if (regime_has_2_ranges(mmu_idx) && !is_user) {
>>              xn = pxn || (user_rw & PAGE_WRITE);
>>          }
>> -    } else if (arm_feature(env, ARM_FEATURE_V7)) {
>> +    } else if (arm_feature(env, ARM_FEATURE_V6)) {
>>          switch (regime_el(mmu_idx)) {
>>          case 1:
>>          case 3:
>
>Digging into the various versions of the Arm ARM and looking
>at QEMU's code, I think that "allow this for v6" is correct,
>but  I think that ARM_FEATURE_V6 will always be true here
>so we don't need to explicitly check it. The two callers of
>get_S1prot() are get_phys_addr_v6() and get_phys_addr_lpae().
>If the CPU isn't v6 then it doesn't get those page table formats.
>(get_phys_addr_v5() is simpler and just figures out its prot
>bits directly rather than calling this.)
>
>So I think we can make this a plain "else", and delete the
>existing "else" clause that sets xn and wxn to 0.
>
>(Strictly speaking it is possible to get here without V6, because
>we don't enforce that a guest on a v5 CPU can't write to the
>SCTLR.XP bit which should be RAZ there, and we don't ignore it in
>get_phys_addr_nogpc(). But if the guest does do that then they're
>in UNPREDICTABLE territory and whether we give them v6 VMSA with
>XP or v6 VMSA without XP doesn't matter.)

It sounds like this is equivalent to this patch. Do you want me to send 
a v2?

Thanks for looking into this!

>
>thanks
>-- PMM

