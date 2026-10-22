Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44B606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YjnGSn6R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsjm-0000ML-VK; Thu, 22 Oct 2026 09:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsjg-0000Kl-Mu
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:21:36 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsje-0001EH-SG
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:21:36 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8871ada1a26so13767717b3.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792675292; cv=none;
 d=google.com; s=arc-20260327;
 b=cAnqEM5yvn7N/pI2tCpHcz87k09mEeMse89KPiSXhTUxTCiSHrbWFJANtQc7uToO55
 KAKFdlbEbcrBYRErmRq0Y3xqcgO9rO2suaHW0lXcDUq/K1hgXW7n2pA73e9B5phvQTEE
 Syn+j/vyDCI6Q5S9OIi4POvLqGUuUYzLYB15I+xQNz8BEOl+Rp6acAT4AYgHYeQ1PrGv
 gfeZGGN+du5YTC7zZXqmrHw71Sy5E6cGVwRpDOiPLMTEhJ61G3vDCxulQkf97lkLgSGZ
 R+QUWb/Fxo9yPHH+73F/qhbfaSsTNn+sM70LQ/pGjwgztec8I4KpuT4FLB+Um/3/TGCV
 7l5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=w0H3pHdT5/DARs+ZyFHVcfo8IVHZOAcD409QCou2Bmc=;
 fh=xS7PDnxNjt+3pGu8h2A8YsFQ48YIDo7SGiTsZsAfSNA=;
 b=kBpx6yH0a7CLftlT3N7hhrdURCuoNUEGcGKVMjPnhLWbow2AVfnE2YrFLS5e/QXY6K
 07EI0pCpUjYuNjvIYcYcilJWPgln5k9xITzl+TsIcNkR4WAqKL68bDL5gGP1SihuIC4i
 zWTOd9kNM/SkanYZ79fM7GOWTpswuNNGPOnSUVp0MqI028YuzsBjw+DPNHc5ZVATw4WO
 UECPmMCEjRCVQH1mj/Q4I3epIam8h8lASXp0NvhAUkLLYoaSqUTU6irtfMU8S26fgIUq
 Yj/3+i1khbLyk6nmpSFXKNQx5xtKOJismWQ8ggfFZpAIPDfVDdU0CAp6KIZI5145M4HK
 igyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792675292; x=1793280092; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w0H3pHdT5/DARs+ZyFHVcfo8IVHZOAcD409QCou2Bmc=;
 b=YjnGSn6RzSQJUNr9L4QiQtvkXnlW9cvtLGCQUESnSxqlDBz6sby3nr6eeqEJ3b1HMJ
 r/uhm6csi2xWwZBpkMqqeCIaUFkcv4sBT/j172Xdo0+0zjXPLzG8YFOFMqMSmdMYx+3z
 vM/lybu1Jdp48OJw02W4PuAaS4xJKdKnWlnfvruC1ww9mdlgsxtcWEkpInsg6+OAOE3E
 mH0SzuS1gPouArHe1uXcMpfIsdOpEEjzM0r18b4Df1aVLDhFWX7joG/g+e6WZX0+uUBA
 OJ0TA9GrLXLk5ynBBnQ/Zyv0GirNGmioG2jCOpeS9R+KwoWaQpPF6oMKgsY3cut+2zBl
 1EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675292; x=1793280092;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w0H3pHdT5/DARs+ZyFHVcfo8IVHZOAcD409QCou2Bmc=;
 b=WTR3E+53sTplYkTFYS8JDh6RRSlBjOl0PF07KClzZX9diV1Vxf2iCmF7LJWHYDrqzF
 igiBkIrzTH6fAKUQ/TZeBsWcNaFFUK59j2o2eO6lJd7PxjSiJ97otDPbGDvJdBf6n794
 0f3crn8fiQ44rR1TN6Af5EyMoLvTSLDqjHJn8nRQisdu7BciUqIgwNLCAlnxub4qDFYk
 LplMpQUGDba6QgCq6terlJ7uI3u1kitwAVcPmFj8Wlww9mRHEfzmjhfmviUOfTI1mDt4
 gpTwWQMwpQY4Du7EEMq0MizVdTrKYcRLnSk9LV8cloRkD4spcWgu3hen4W72hFexCPgu
 3HyA==
X-Gm-Message-State: AFq9FYLciiw/AX7LS307F6+aCqDCXbtacQYlz30qSMkCvOTJgTZBKmK+
 sYKlkXD+AUorqAbYeJkAiD2YwYJNE10QD7fT5SCUBChb3b9ouXoSqhxDiGoD09FuxHFc/bQyI++
 kNtvUyXIF6MEpZ786z+FVygaTMUwt2GW7D2Is+9oWbDDSxhuD8y0XbTmLQA==
X-Gm-Gg: AYBFou2rUFggrpDGDd3U+xxb6KSKiKYf5bch39arTaToLTlCN8IwCtsrlyXz9/c+CrD
 vCrnRIHAvhA25h6pcv6r072Lx6btKNXO68xo3wGObUmOG3+SKrBbc1ktVIQs1JSkfF+rx36zkIu
 tmFIa8VEDgjM3yMh/+9B34+Qz8LiNJ0j64ytCs34ne18plArAz5cCVXUn5ZHT6GuulUmBGF07TB
 rJ0ZGLfJYnvPN/wbW3gLgNdbuqZWmQlLFr6a4nxcfkU3eP98tfleeF1OqOFeSLtjOFJQKaUdtNT
 1jAqD71GlIfZ7gkEl49Q9q9x1XRQSZ1YAFmnHB3FjAoeLh/5QZXWGoG7LMOOXVPr331OEfYLNJy
 t9eQk8i419x1RbHsZwMkv8f6aHxRTiVXDeHN3PrmgTkwzh1sgYEZhYIrH2uTTKqSiYk7/PM/m25
 7UishS0FiLbAnuRcmPfbhAuw==
X-Received: by 2002:a05:690c:2e09:b0:8a8:9149:e4da with SMTP id
 00721157ae682-8b1340f8d18mr18721367b3.108.1792675292188; Thu, 22 Oct 2026
 06:21:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2026 14:21:20 +0100
X-Gm-Features: AclHuK9hCJ4Ke1LCZmjfmKTZsottcOx4sekZ3fdITvxFpJi_IbFkhdaoCmobNxI
Message-ID: <CAFEAcA-E1Kuvegq2PeafG0of=TTRJfGX_yvbV-UibJ0tNhUM6Q@mail.gmail.com>
Subject: preferred tlb_fill mechanism for non-legacy code?
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently we provide multiple different ways that targets can implement
the basic "deal with a softmmu TLB miss" functionality:

(1) Implement TCGCPUOps::tlb_fill_align, which passes an argument
    CPUTLBEntryFull *out which the target code must fill in with the
    info about the TLB entry to add
(2) Implement TCGCPUOps::tlb_fill, and in your implementation call
    tlb_set_page_full, passing it a CPUTLBEntryFull *full with the
    info about the TLB entry
(3) Like 2, but call tlb_set_page_with_attrs(), which is a trivial
    wrapper round tlb_set_page_full()
(4) Like 2, but call tlb_set_page(), which is a trivial wrapper
    round tlb_set_page_attrs()

Currently Arm and hppa do (1). sparc does (2). i386 and microblaze
do (3). Other targets all do (4).

If we wanted to try to reduce the number of ways we're providing
to do this, what is our preferred destination? Moving i386 and
microblaze from tlb_set_page_with_attrs() to tlb_set_page_full()
would be easy, for instance, but should we move them directly to
tlb_fill_align instead? Or is the idea that you only implement
tlb_fill_align if you need to care about the priority of alignment
vs other faults, and implementing tlb_fill is fine if you're OK
with the default "check alignment fault before page fault" ?

(Updating all the "type (4)" architectures might not be worth
the effort, but I feel like we could at least rationalize the
type (3) cases and maybe type (2).)

thanks
-- PMM

