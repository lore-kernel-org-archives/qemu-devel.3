Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A4DC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBqP-0006L4-7i; Mon, 04 Mar 2024 12:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhBqN-0006KW-FQ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:11:15 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhBqH-00045a-Np
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:11:15 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso6512777a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709572267; x=1710177067; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dsiwkkTI9GOPL0oYxkbwrLNcml1NBnji4qawjKw78Ms=;
 b=dNXVmgeHGKki5jEJGd2R2YMDDea72fmt2sBobFr4f5K8qyVZf4vb5wtR1aOyXk6hS1
 9U4L9L/MdR1cIKuTkn+MtVixNp198JDgpcKPdyb9/CSEarm9GkXUZJ6v6+qywlI4wqri
 9vDw+KM6XHSqSGecR94DGVCcYERMfEHR31UAJteE/bXRILSGKdlg62lPrVi7f7jd2vJ/
 9Ox0CEPaui+Z/kzcONXH+BnmJmwLJiTe2EO6Eb+NDgvRxv0VRAPwkQboKeuEBr6Iyfgr
 hLlebs8RSEQzaKnetM5hdyAc2eyMVfQ7gMd0g1z/J1+cNbXEeDJlviM+zngI2TRhxf5w
 S5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709572267; x=1710177067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dsiwkkTI9GOPL0oYxkbwrLNcml1NBnji4qawjKw78Ms=;
 b=AIYYncMpYr++RitIjQKjnJXikI1iBLQkDq6Tg5BZI8TXf5dFzhmlQvdyeMtMZgxgnI
 iYUuNvYuVb9aU/6vyg+G5vgFCXqGiyDP31PO3tO8MySijOGRcxCrWg/uP9J2RvqRrec7
 kHAZes6RVn+d6NOyj+wPZgYENls0dW/CyvFVe9vu9smJaxofPXZlIayo4EVqsN3RCL3p
 39RIiFEoxbZQPX40x+wmaRKVtBKYl9vP4Knhh3hZXX/BAk92ymaZTdcz8FMbaAVgx2pS
 yYbl5sMs8QUzudtZIn3LPtWsrAiq8+McwA4idmSvgn6pGnEsbas6o+u4a50Fb/UG6zrq
 91Uw==
X-Gm-Message-State: AOJu0YzG8bsyLbr9ydAz74AGdFgmMOxftBRXoNDpI+h+PHN2vMPR4cLn
 GPFyh++t8woy8GJbWpWwiT22NUkuhh8rk64L3hgD5a8VYKGGCgHZxAiacB4ntiFLpCOpYA8VTuP
 713i0k76Y9Ei0d/9cePmbJCGlbRNKS+Mz0fnR3w==
X-Google-Smtp-Source: AGHT+IFQWjdDQjiFHxSUMunhLmwFS6yDrYQKIs9czED9W0S1ULYQqxsiBJr3gsGMeO+faMeTQbzLvri0sgz9rgKjO+0=
X-Received: by 2002:a50:9306:0:b0:564:fe6b:906a with SMTP id
 m6-20020a509306000000b00564fe6b906amr6438154eda.42.1709572267293; Mon, 04 Mar
 2024 09:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-7-richard.henderson@linaro.org>
In-Reply-To: <20240301204110.656742-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:10:55 +0000
Message-ID: <CAFEAcA-RCuHCR18q6V+xGi_igE-7-+PUrX1eOjduJeeeWFq7EA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] target/arm: Do memory type alignment check when
 translation enabled
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 1 Mar 2024 at 20:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> If translation is enabled, and the PTE memory type is Device,
> enable checking alignment via TLB_CHECK_ALIGNMENT.  While the
> check is done later than it should be per the ARM, it's better
> than not performing the check at all.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +    /*
> +     * Enable alignment checks on Device memory.
> +     *
> +     * Per R_XCHFJ, this check is mis-ordered, in that this alignment check
> +     * should have priority 30, while the permission check should be next at
> +     * priority 31 and stage2 translation faults come after that.
> +     * Due to the way the TCG softmmu TLB operates, we will have implicitly
> +     * done the permission check and the stage2 lookup in finding the TLB
> +     * entry, so the alignment check cannot be done sooner.
> +     */

Looks like in rev J.a the priority list has had some extra entries
added, so these are now items 35, 36 and 37 in the list.
Maybe we should drop the numbering and say

 * Per R_XCHFJ, this check is mis-ordered. The correct ordering
 * for alignment, permission, and stage 2 faults should be:
 *    - Alignment fault caused by the memory type
 *    - Permission fault
 *    - A stage 2 fault on the memory access
 * but due to ...

?

> +    if (device) {
> +        result->f.tlb_fill_flags |= TLB_CHECK_ALIGNED;
>     }

In v7, the alignment faults on Device memory accesses are only
architecturally required if the CPU implements the Virtualization
Extensions; otherwise they are UNPREDICTABLE. But in practice
QEMU doesn't implement any CPU types with ARM_FEATURE_LPAE
but not ARM_FEATURE_V7VE, and "take an alignment fault" is
something that the UNPREDICTABLE case allows us to do, so
it doesn't seem necessary to put in a check for ARM_FEATURE_LPAE
here. We could mention it in the comment, though.

I propose to fold in this comment diff and take the patchset into
target-arm.next:

--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2141,12 +2141,19 @@ static bool get_phys_addr_lpae(CPUARMState
*env, S1Translate *ptw,
     /*
      * Enable alignment checks on Device memory.
      *
-     * Per R_XCHFJ, this check is mis-ordered, in that this alignment check
-     * should have priority 30, while the permission check should be next at
-     * priority 31 and stage2 translation faults come after that.
-     * Due to the way the TCG softmmu TLB operates, we will have implicitly
-     * done the permission check and the stage2 lookup in finding the TLB
-     * entry, so the alignment check cannot be done sooner.
+     * Per R_XCHFJ, this check is mis-ordered. The correct ordering
+     * for alignment, permission, and stage 2 faults should be:
+     *    - Alignment fault caused by the memory type
+     *    - Permission fault
+     *    - A stage 2 fault on the memory access
+     * but due to the way the TCG softmmu TLB operates, we will have
+     * implicitly done the permission check and the stage2 lookup in
+     * finding the TLB entry, so the alignment check cannot be done sooner.
+     *
+     * In v7, for a CPU without the Virtualization Extensions this
+     * access is UNPREDICTABLE; we choose to make it take the alignment
+     * fault as is required for a v7VE CPU. (QEMU doesn't emulate any
+     * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)
      */
     if (device) {
         result->f.tlb_fill_flags |= TLB_CHECK_ALIGNED;

thanks
-- PMM

