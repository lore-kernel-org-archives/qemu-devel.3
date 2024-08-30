Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9998CA1009
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4Vt-0004Kw-GB; Fri, 30 Aug 2024 12:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk4Vq-0004HY-9I
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:30:14 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk4Vo-0005T3-5n
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:30:13 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a2b4so3520522a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725035410; x=1725640210; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u+V31Mqg1iTS0y7T36ICG6IoXhl7dnQFm+0Bmu56rww=;
 b=oSACRumxKKp3jiQVhqG6DJxX6ZbXlPL6glXy842A/e7Ps494lTGriJ2IpXZCjMlDXq
 ITj5zzFHW2emOwpDeCM0du6TKAkeckeI+qZUTtMJACxbVB+IXwQVIuOByTv3PQ90JStU
 O1QYxJddoVgjh+635HWXY6NxqQUlDTkl2OXv9N8Q1cWG1P8WaDIH+cQggo8Earf7Z0/j
 FO0lPCxqt7rPTObuDFjjIrtrwE7z77r1r7pAN8vbxCLwvtn3WMYUxraYWnvhsCELVyfi
 8cy3+ZFazM1AE3B+ZzPVKq/NgYX+x2lMDWZGcmj+Pncy+Fjb2JXOUaTbE8bMMGZKCgNL
 2kVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725035410; x=1725640210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+V31Mqg1iTS0y7T36ICG6IoXhl7dnQFm+0Bmu56rww=;
 b=V6zcU0DiUkMMu7zRk63SCIYlywE7fvji2QoLyNOnk4RGfokCr+QTpsCOpVzKLkvH2t
 I8OAsvDmqlZimquJQ1YASKSeDQAFmJpKRinrM35E4eKvbcIfFZDxiqSyvbWwNWJFc0x2
 k2BOGZc9UaxinQOt8kUwNN4rhCAJusxcbwJarBTObK7PR5k29JR0afaBbLGaA9ZOBoQe
 RIXQt9aj+3hww/0DT5UPXsdidFJ1iNVIeOU/T0n2dvuqSK8FISGULEAfgjDf6AACM7Ws
 hbkK2EwSp+65EFRTTr0HeayvPlzg62nGB7eGOmgJwvtxG1dwCNI5hKcEPUt8s2OcFNRd
 ayiw==
X-Gm-Message-State: AOJu0YwpIanm89sls8Id+v5llrN2mEi0RkVN2ZIbjECrUl4nTdIwT/tt
 XlgH3P7k7oIm2s876u51MTm5CtSwyeHKCDUAyJ4FGs2Mo2Qz3GcMsGGuTvIXWnX2LRor1J3vlZq
 1JIkauHpBgYQJpHVEErcg3BOqZXpcUIGP7Sxe5g==
X-Google-Smtp-Source: AGHT+IEElwEtcposOYpHVAD1ICWphAz6rzN14Sfb1tee4M3W4yAW5aUINmcHUx01cq+wzRkrIaq8IpRF9gKvACsvVZk=
X-Received: by 2002:a05:6402:1d54:b0:5be:b4eb:e1de with SMTP id
 4fb4d7f45d1cf-5c2200de8a6mr7328273a12.1.1725035410151; Fri, 30 Aug 2024
 09:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240830161932.44-1-alireza.sanaee@huawei.com>
In-Reply-To: <20240830161932.44-1-alireza.sanaee@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Aug 2024 17:29:59 +0100
Message-ID: <CAFEAcA8d9SfCTSk02fg3C+t0mAQkanMPeYTahn0vWOOMnoCsAA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg: refine cache descriptions with a wrapper
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, linuxarm@huawei.com, 
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com, 
 Jonathan.Cameron@huawei.com, jiangkunkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 30 Aug 2024 at 17:19, Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
>
> Add wrapper for different types of CPUs available in tcg to decribe
> caches. Two functions `make_ccsidr32` and `make_ccsidr64`
> describing descriptions. The 32 bit version receives extra parameters
> that became unknown later in 64 bit.
>
> For CCSIDR register, 32 bit version follows specification [1].
> Conversely, 64 bit version follows specification [2].
>
> [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> edition, https://developer.arm.com/documentation/ddi0406
> [2] D23.2.29, ARM Architecture Reference Manual for A-profile Architecture,
> https://developer.arm.com/documentation/ddi0487/latest/

Could you explain in the commit message the reason for
making this change, please?

thanks
-- PMM

