Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB2AC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 12:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkNqb-0004O4-TM; Wed, 13 Mar 2024 08:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkNqZ-0004Jf-5X
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:36:40 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkNqX-00072n-Ei
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:36:38 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5686677bda1so1538657a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710333393; x=1710938193; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4JDW3OehObsc6Mhsu3q0A3/9SHGEMnntkY9JYeLWae0=;
 b=hwnwtX9sxTAHaYQGqQvOGscOcw0Pen1/YAJxv3lItc0We3gsU80E75FsUpiS5KtMGL
 cKIhCVNzIMfBNp+sMkg+8BzvgdXDqvTXzVvfuVI+D7Q3+ZB3qE/JBH3ycNDhc4mYRg/J
 /SukOGtrqg+q7qJYLFrbVc0wspUmI+idEtPxW5EEXu0OGIvtz9ZnEpWtngL/MIjvqg2O
 aPjlqFcZrvXtghebAbPk9iVRSbbdf7CnEygGtNp+y84WjMyxITVXhhe14vFh+fx9mgzz
 u/pXsr+9LubgUUtcsf7Ao7rEp1Dqc+heiJrmvOnU1AYbJ6kOyNEtSdo6H3pbJC+rEWXP
 cBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710333393; x=1710938193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4JDW3OehObsc6Mhsu3q0A3/9SHGEMnntkY9JYeLWae0=;
 b=MHQ6/vSGV+81JOgY2aw+B/vohPT/J9gIrbB3tdMFvawLb3khFachReoU+XKXFcGl0N
 2FBba9RgXZSl2Q/s7fxIV7B6+jyZIrqF0IpPJ9QlMutBK4s2G9d5jNoFdtqR32RTuSit
 NLdH0jhUayD8A4R6rdxWjCihK0dFHT05ev+1eK5yIQU03LBbDJne6LbZoWdP+4y1dsYR
 Y4eL5G3vAdaN8sMlIYJrdOB3xSC0xZnSUuKANxNx1DcW0ozIewOHdh+mEzejlpnCbJlK
 EaSRIk7gWzl8O2bOulImDyliKhpfXhD2h7LW32UihacsCp5L0WWdOZYn4TVpWAOnTIbu
 nK8A==
X-Gm-Message-State: AOJu0Yy0QnFNPTOTfwDyqNgarUYulhI8j/kabNSx07LcRh1xsD8h0T29
 k748UiJZloGrGuSW2/rM0Dzhx5ycWpfWadYHpsM6coeIoi0SKOd/ShAx4gr6EhaKVl5hl3d2zG4
 pV/IBar/OjHhn01UXRg8OlOJFf60pMKIDIbihjg==
X-Google-Smtp-Source: AGHT+IEBWWwAwwAvz9NOAu25pE1GQRlVu/cHOa+nzFt32KbZ9cZDhnHTBmsb+G8PK+wLz297NYUNbtzxZ5lwTthrdkQ=
X-Received: by 2002:a50:d489:0:b0:568:335d:1192 with SMTP id
 s9-20020a50d489000000b00568335d1192mr2299140edi.13.1710333393250; Wed, 13 Mar
 2024 05:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240312142757.34141-1-anthony.perard@citrix.com>
In-Reply-To: <20240312142757.34141-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Mar 2024 12:36:21 +0000
Message-ID: <CAFEAcA_zaff0Bn8338XiOJmp9cP4z-AwnMAMpNVDcbF=MAsecQ@mail.gmail.com>
Subject: Re: [PULL 0/3] Xen queue 2024-03-12
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 12 Mar 2024 at 14:29, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit 8f3f329f5e0117bd1a23a79ab751f8a7d3471e4b:
>
>   Merge tag 'migration-20240311-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-03-12 11:35:41 +0000)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20240312
>
> for you to fetch changes up to 918a7f706b69a8c725bac0694971d2831f688ebb:
>
>   i386: load kernel on xen using DMA (2024-03-12 14:13:08 +0000)
>
> ----------------------------------------------------------------
> Xen queue:
>
> * In Xen PCI passthrough, emulate multifunction bit.
> * Fix in Xen mapcache.
> * Improve performance of kernel+initrd loading in an Xen HVM Direct
>   Kernel Boot scenario.



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

