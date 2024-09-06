Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A37DCE7AA3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYQn-0005hg-1p; Fri, 06 Sep 2024 08:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smYQk-0005gw-KH
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 08:51:14 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smYQi-0004NV-Sn
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 08:51:14 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f50ca18a13so23549901fa.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725627069; x=1726231869; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yy9M8YrCRKPXItLf3DDsQ2VqeEa4BokE+4+DkGvRqSE=;
 b=hGB6o9p/rfZZMSyO+ZBUxmWk4BtQ2Med4Eic9r2HvFe93Rn1j7nmXNff24MJQ6rwbW
 vbKGRSLYBxf5KAd8fs3fMaQugYdCigOqpIAhg8Z8n+2u3XuqsWI7kmjOsx3gSiIqsN9+
 pBUjtp5UzIWaOuzHzIanQkOrWUdzXRAEtBBY5RElHiyiW5pH/wa4O31TOtmQa13ffzrx
 VB5xfj14XAwotSR6kT0fECRPmuGBTmbxuJXASFnRNqbUbp/e5lBSvWR444FliExDlqJd
 NNP3unRKz7zQ3CGZV1xuI15T7rXFJkrR7Cn/hEqZ171SnKa+U1SD3dJliy0LLWtxSTbL
 BJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725627069; x=1726231869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yy9M8YrCRKPXItLf3DDsQ2VqeEa4BokE+4+DkGvRqSE=;
 b=Nzs/FczQdhBuWoMRXKI9L/jPSX1tnFil7fWc2ZyMziCeXMHG6FAdK9enUBIg7PYiqI
 XsffzUC3keVrsojYkOGpSab53ciFjFyjV+T+kHTxuTJX9CLf0wfqi5smOk1E4Ae/uXcn
 7WFV1EkxpJgcDpZD5ie/6CQqSMdFBHEeXrdxSPCIuDRNcSiZs+kJ0cKEgWr8M1OjpqPl
 YEYUhbpUT2C6YZpcPKyrAk6m5GV7SSVYJQMwKXw0Jm/lTROG7FIi01X5AcRUgrT/0d+k
 hAa/JoVTv+vu659whzmEAe5HNl31BFZlghAaPfdd9NJ6IPElyC9O8x8qMMaZ/WhWvHsS
 u4/w==
X-Gm-Message-State: AOJu0YyuSTvXl94ZLMCc4qDAm8sozRzNOzmYhA3FwPtQJKD0kx0cWHho
 +JhrK3+V1naL+OMhJLEORhW9nl0SfvEYhUFAVolIXqYpyLwLZ/RwFfoyyxGZZXnHxGMdM6THL3F
 4MXCtBvTI73xYF7WV0QytSFJxKsYJzeAPISpdQKL5nYMoRjQV
X-Google-Smtp-Source: AGHT+IFna5xMgUJ4K/6OgCsayBYv+yzNEH9w0QE53f3lc/NHIdBmbsIbHLxCDAkcMGafJ6DYBneJnYhYabMKUWToTZA=
X-Received: by 2002:a2e:6109:0:b0:2f3:ec80:92a6 with SMTP id
 38308e7fff4ca-2f61054aaa5mr147162221fa.46.1725627068728; Fri, 06 Sep 2024
 05:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240902123038.1135412-1-jan.kloetzke@kernkonzept.com>
In-Reply-To: <20240902123038.1135412-1-jan.kloetzke@kernkonzept.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 13:50:57 +0100
Message-ID: <CAFEAcA-tK24wCPKZwig1iDPSOiHKqZMU4WH99ZZEG-awveEvag@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gic: fix spurious level triggered interrupts
To: =?UTF-8?B?SmFuIEtsw7Z0emtl?= <jan.kloetzke@kernkonzept.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 2 Sept 2024 at 13:32, Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.co=
m> wrote:
>
> Level triggered interrupts are pending when either the interrupt line
> is asserted or the interrupt was made pending by a GICD_ISPENDRn write.
> Making a level triggered interrupt pending by software persists until
> either the interrupt is acknowledged or cleared by writing
> GICD_ICPENDRn. As long as the interrupt line is asserted, the interrupt
> is pending in any case.
>
> This logic is transparently implemented in gic_test_pending(). The
> function combines the "pending" irq_state flag (used for edge triggered
> interrupts and software requests) and the line status (tracked in the
> "level" field). Now, writing GICD_ISENABLERn incorrectly set the
> pending flag if the line of a level triggered interrupt was asserted.
> This keeps the interrupt pending even if the line is de-asserted after
> some time.
>
> Fix this by simply removing the code. The pending status is fully
> handled by gic_test_pending() and does not need any special treatment
> when enabling the level interrupt.
>
> Signed-off-by: Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.com>

Thanks for this patch. I agree that this is wrong for the
GICv2 -- I think this is a bit we missed in commit 8d999995e45c
back in 2013 where we fixed most other places that were not
correctly making this distinction of "pending because of
ISPENDR write" and "pending because level triggered and
line is held high".

However I think for consistency with that commit, we should
retain the current behaviour here for the s->revision =3D=3D REV_11MPCORE
case. (This is basically saying "we don't really know exactly
how the 11MPCore GIC behaved and we don't much care to try to
find out, so leave it alone", which is the stance we were
already taking in 2013...) In particular, notice that
gic_test_pending() only does the "pending if level triggered
and held high" logic for the not-REV_11MPCORE case.

thanks
-- PMM

