Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BD9C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfjh-0007bH-CZ; Mon, 09 Jun 2025 12:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOfjg-0007b5-5t
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:52:36 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOfje-00050M-82
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:52:35 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e3e0415a7so42477857b3.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749487952; x=1750092752; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=esuz4HfV7Pzibk5kRs7hoXOllWwkfrS0pI1r1E8Jthg=;
 b=g0NW47tDPtkDzkfuKQ0Dp6Ea9/712BT0iPuqkLA2mA8Lw5fXC32xLkYtSkx+w3GaF8
 wQarnTy7dSt3l9SDNvngq2gCbHo/Br8aKml3oJfsdnTM+9RNhU3fYZiWZeZZGLUGIyI4
 8BN0dioF137NTH1jyfCNRhQFbqFw/p1CDKO2NHh/T72r9MDQ/fjvFgpIt4h8VNngO8Gm
 5Y2xq29IgecGB7xkHDweCUfrjTp21kChrAmn8LTNDxtyP01h9tntAi1r8ZASgek2sFZ4
 pIF2/a566BHFjH91zPcLpQD6TPYzGzpQafgRO84tureVj9rH7CevPqnpSo2YH/fd2OUR
 7p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749487952; x=1750092752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=esuz4HfV7Pzibk5kRs7hoXOllWwkfrS0pI1r1E8Jthg=;
 b=U+pwCdzUa/NycPIsbwInNGbWyQ7fKpoUXiVqNpApCRJSkFwVN+OwLqRCXnc4WkdIch
 x//du6bx4q6mlu/f41pCk+BKqCil0fIdBevahPWr7K8+o28ikQtSOF+8wR6b0uYuMrHH
 ZWL7AY5BRQttSqhySYkg/K2l+W0izDOTE/1xChafEt2gsrPb2Fp2NVOGf66xqrrgjdj5
 bamklgdDqBOhjUDYjSKSXbbIkDBshfjjfB0DYssdYkyESFCCSGfUSRUqYng5m7Bwb6D9
 /Mdp7IUFFxyWZux2nz0APVURLRi+yG5KadyR1DKrQmS46XcTJeSPrqjlccRzFjJsb+Gr
 eqaA==
X-Gm-Message-State: AOJu0YyjuYy5mlBjoLUCW5ydiong2UpYJtLMvfAWLf8/OQbcqQJn1Nkk
 Cr8HUIn9sGBS7sCGhEjepKU7H9ElYTy8xJuGrpGJW/pHi7kNNSdKJMPUdLMRyeLD+X/OQ60Mg4w
 x6n0EsK0tQ/pGH+NQkvTBHAlbTgvPKnoD2t9Ci1TYJw==
X-Gm-Gg: ASbGncuzilNKcUWcuB1NUFf0HYzmLEFaKrQ6Z9GBRfEzBnE9gMZ39+d9wOMi3wV7DtT
 IFrwy+/Zf20GzTiM7NjcQIEN0aUH34Vm+0AoGNylFK00pNl7r3AIfCy9IGLZsPlEGSKUDWuQp7X
 I/6g5/MZQs2x5bCgJ1tUAHW6b9toRNXrvQya6oOQfiFyjt
X-Google-Smtp-Source: AGHT+IGh8BJyzWQ2Ohye6QL5GCqVvCg0Z6UdFFNUzPwHp9b2iDmm5lluz3MR+/Zs53oJg+T8rlzGCoQhIbZ5VUEZnz8=
X-Received: by 2002:a05:690c:998c:b0:70e:7c15:972f with SMTP id
 00721157ae682-711338710a4mr4380647b3.1.1749487952615; Mon, 09 Jun 2025
 09:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250429163212.618953-1-peter.maydell@linaro.org>
 <CAFEAcA_hV=962gFfKc-7D91X-MXxVs=VrKQVzOKaLS2gJDt5Lw@mail.gmail.com>
 <CAFEAcA98gbjUX08NccePxGB2k0S+fjFArgz4WjFc5CZdDQ0ezg@mail.gmail.com>
 <04c3ef19-deef-44a9-b056-3b295246ad5a@redhat.com>
In-Reply-To: <04c3ef19-deef-44a9-b056-3b295246ad5a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jun 2025 17:52:20 +0100
X-Gm-Features: AX0GCFueFEV0fuBAxq4SFiY17DXQ1SI9UIo8bg0XG3Dm2ksElnpAnUdKdN0gsV0
Message-ID: <CAFEAcA99teVBAPHOJ+bwfcP6T+Kuja9YDmZiBe_iJD35EPbNmg@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs: Avoid duplicate labels with a sphinx extn
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 9 Jun 2025 at 17:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 6/9/25 18:18, Peter Maydell wrote:
> > Ping^2 on this one?
>
> No objections if it's the easiest way to solve the issue.
>
> Alternatively, is there a Sphinx way to write something in the spirit of
>
> #ifdef DEFINE_THE_LABEL
> .. _label
> #endif

Unfortunately not. Sphinx's conditional-content stuff is a bit
odd, and only works for actual docs, not for sections, labels, etc:

https://www.sphinx-doc.org/en/master/usage/extensions/ifconfig.html
https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#including-content-based-on-tags

IIRC this is because under the hood the conditionalisation
only takes effect quite late, when it's about to emit
something: they really act just as filters on the output.
So you can't conditionalise a directive or anything that
needs to take effect at the parsing stage.

https://pypi.org/project/sphinx-selective-exclude/
is an extension that tries to work around this, but it
hasn't been updated in years and it probably doesn't work
with newer sphinx versions.

-- PMM

