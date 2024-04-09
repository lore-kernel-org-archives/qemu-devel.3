Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F346ECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9xW-00046I-3k; Tue, 09 Apr 2024 07:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru9xR-00045p-PC
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:48:11 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru9xQ-0004eG-4L
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:48:09 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-516d536f6f2so4218244e87.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 04:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712663285; x=1713268085; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Degnu0MS5NwnOpDTl8IdP5LDf/dEPp+0UA0JHfd9gb8=;
 b=bwNXGUfdoX0U372YG8cD8wty2prok1FgBF4ZOb+rB4/GbgpT+s4qi4wk+T3P972TeH
 3cLYx+V+0/gy5OAq7tnRObjrEDShU8tRSoDVgM+N4xuqYzBk+QeDK+6LtDRPcGPYEp8j
 PcBZx7+OjJBgU7dmnJfMvuw3iv5wLFap0W6plP3ILqyFAqsUng9PLkY16yHZ5P4X0hcQ
 8Bkm5LMP/3D2paI+4mBNXalLy9aRICq/CNWsm+gfKay0VGRBb51rx3FPaL9VFpE6xUTq
 ag8d8n0FqAfncAKVQSWVkdcCa0vPT4fvoSKdNSW/6jQdiKd/+TzBaMHvZN/QKWAvwYul
 3DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712663285; x=1713268085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Degnu0MS5NwnOpDTl8IdP5LDf/dEPp+0UA0JHfd9gb8=;
 b=mk+Bb0CnYw6AVEKC1Zaxt3mMOlQEjg6qWbIdg7RQXRkQCrE+az4+bSrHWhlB02kWrr
 dBLoDgkKrsMa0Vapd2Lvoze/UBY7q/ZaxFZDowLut1DkYyTD/+6x2ZMd2+d46UtPpWJd
 WgYt48F/vuNoIRfiHMA62VUVoy+hYDkTK+LWtTmFiuH7krZkbycDd/09tiMIoaXqwACx
 IjoTw4YXudYvJjNK4VMdFAhdI6kQFksh8b9NyaDGgt5GiDcuppo9mw32gyPv/BblDbkR
 JKT5NAvYt2WE0jT/sP75TvCexMT0aylroq1EzjNY/d3xGLcv7G6Nju2uXiOUPStn60ln
 J2IA==
X-Gm-Message-State: AOJu0YyGcvCUxpDCtHD6SYkfB/v55EknwEXl++r69ARcaODxNy3l7y+m
 7lOkeRzYsu+A7bV81kSog2TP6z71k6eZJrCAMXNsCmQD8AAbiXWNkIh7Eg+HnwC++zsJ92ub3jT
 ZfZBLhP3GNSkvWdTHEmMXT9sDyYwbrdlG7B9x9GC2d+9BueEE
X-Google-Smtp-Source: AGHT+IESNjub7Lw4/pv0B7qGHXsR728luWwsNN0pX6S6zQaM5AZGEEk1ElRP/vCU+ZXibmT1TlstkuYO+aTlBxh+ruo=
X-Received: by 2002:a05:6512:3993:b0:516:e8b1:177d with SMTP id
 j19-20020a056512399300b00516e8b1177dmr6228303lfu.65.1712663284935; Tue, 09
 Apr 2024 04:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240408192404.542506-1-pbonzini@redhat.com>
In-Reply-To: <20240408192404.542506-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 12:47:54 +0100
Message-ID: <CAFEAcA-11sG_o4-RB31rEP0kb-C3hA3Pf40DQHSuhkZzhytqJw@mail.gmail.com>
Subject: Re: [PULL 0/3] 9.0 bugfixes for 2024-04-08
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Mon, 8 Apr 2024 at 20:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:
>
>   Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to e34f4d87e8d47b0a65cb663aaf7bef60c2112d36:
>
>   kvm: error out of kvm_irqchip_add_msi_route() in case of full route table (2024-04-08 21:22:00 +0200)
>
> ----------------------------------------------------------------
> * fall back to non-ioeventfd notification if KVM routing table is full
> * support kitware ninja with jobserver support
> * nanomips: fix warnings with GCC 14
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

