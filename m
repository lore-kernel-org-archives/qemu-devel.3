Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611A4FC616C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 18:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spAfd-00069w-45; Fri, 13 Sep 2024 14:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1spAfa-00068y-Pm
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 14:05:22 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1spAfY-0001ve-R3
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 14:05:22 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f75c6ed397so27817251fa.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726250718; x=1726855518; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SL824KUWsVEuIJ3iTgbTQ9SuKtB5u5ObbPWPGa0o3Ns=;
 b=IsTwzjTHcbvkCwowLYrDWogn2yw8b2a633TceCsHbrMjiUo1R+BH/ldon9m7V+vt+2
 6BcQQJjBz84ZCDnp+2shSF26RZyif3oLX39UgWcNK75kSE8s3oo3nUspnvck1EJDm1k/
 nlBV1UfT5SpTUeeyTQFokjDgG2FP1Tw6NIZVGDePMDIDf4aojz0UFGS4RoF3YvrBxLWq
 LqnCX7JRR75szymYX3/1Y4RFuvfIEtcGIES5lpKcmEVfnU1IhkUQTVwxFNa31Ln2EvzM
 hriJ/fxlwlN0fH2s6D88G+sy2HiFY35/7gEWQL1a75s86U+4PixKEq08IDecPe1S+WFV
 /imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726250718; x=1726855518;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SL824KUWsVEuIJ3iTgbTQ9SuKtB5u5ObbPWPGa0o3Ns=;
 b=GforuU/OoaeaodEAzf7NgGU6yRUyPmRimof5L6l4sesM+CLHZD7VpQFiiwA43hhWuO
 CltdbUXVD/oJo42ctniLi/H4a07oj6BxXKukDME4RICjSUJaurxcOSG4EqiqdaBDLiIO
 NXeyFxEdUJm7ZpbHlREuJqV/b5KOSfMXAyUuRpbU/fEedCzx8ix3SrPVWlweNlcfgnXX
 W5WZXbO1PNvnvWFqxeLEN3cffMhB5nKBbM5n9A+DDvOoaEygbUiiLsmMZNFG7RXl5shd
 zt67Hh9OBDD+hvzK9nzThUswHhhao3EHX0/sqFuQ6mcOYkwTPni6Zk3R3kduJEoQ0fsp
 kWqg==
X-Gm-Message-State: AOJu0YwKqndymveYOkMyZPpK/xZdbuxrFyxGHyCHq16b+cI/cKI/4iVT
 68TNA8jeoh29gFK0yq1vI6my5hQIKKiQP0ctwxWAWJhZMGQks0T6cK/MBQM+uHXssjNWZo9cOGx
 NQB9sj+bH80ZFphNIQNIJju3mGo8Z2IsYJaTS0E2Y1ssmH5Mf
X-Google-Smtp-Source: AGHT+IFcF7d4E01zJQogGgo/OKhsy0CeEFDDlIG7Oj8GjsraA802Sn5ULLKwxb8OJ2BMbu74e9yMMni/tBcj06zOdYI=
X-Received: by 2002:a2e:a7ca:0:b0:2f0:25dc:1894 with SMTP id
 38308e7fff4ca-2f787daf4bamr46172311fa.2.1726250718063; Fri, 13 Sep 2024
 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 19:05:07 +0100
Message-ID: <CAFEAcA_YDpvROyvXRx6wp1HYor53oajfuABoTsZR4n89bOPH_A@mail.gmail.com>
Subject: Re: [PULL 00/27] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Fri, 13 Sept 2024 at 16:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 63731c346f071a77e1bb1789bef1ac9d592b6d4f:
>
>   Merge tag 'pull-loongarch-20240912' of https://gitlab.com/gaosong/qemu into staging (2024-09-13 11:38:15 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240913
>
> for you to fetch changes up to 110684c9a69a02cbabfbddcd3afa921826ad565c:
>
>   hw/intc/arm_gic: fix spurious level triggered interrupts (2024-09-13 15:31:50 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * s390: convert s390 virtio-ccw and CPU to three-phase reset
>  * reset: remove now-unused device_class_set_parent_reset()
>  * reset: introduce device_class_set_legacy_reset()
>  * reset: remove unneeded transitional machinery
>  * kvm: Use 'unsigned long' for request argument in functions wrapping ioctl()
>  * hvf: arm: Implement and use hvf_get_physical_address_range
>    so VMs can have larger-than-36-bit IPA spaces when the host
>    supports this
>  * target/arm/tcg: refine cache descriptions with a wrapper
>  * hw/net/can/xlnx-versal-canfd: fix various bugs
>  * MAINTAINERS: update versal, CAN maintainer entries
>  * hw/intc/arm_gic: fix spurious level triggered interrupts


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

