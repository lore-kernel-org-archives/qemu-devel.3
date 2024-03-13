Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ADDC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 12:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkNrI-0004eF-1p; Wed, 13 Mar 2024 08:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkNr9-0004bI-Kx
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:37:19 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkNr5-00078U-PD
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:37:14 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-568307fe62eso7101706a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710333430; x=1710938230; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W2KOYWLb0BCwLfBGy+z/iZaW0adTlaN63+C+ZhBqP2U=;
 b=TCDkZJ9Qg3kBowaahh5IL3LMxQginmnw4dhntnrafoptfUCQeNPMd9irhfXbBqD/k8
 m/Y8YhHGfs3vDCl0RWcLMmCBeZpD1q4Ahv79gpBUKr6o8En7kKEgV1jezQaw7DNuC6CP
 LdqLSFEXfu64I3LOOuIg8QaPn/TSMTNO74eyH5ZPja9JEyrX8kzA48X4KcJNx0dB6aIP
 VpUZDcW1VrtVfbHAW9Ew0y7OQDXIVq/YF5xuGEeJc+UpFuo3nrySyIVzEAXIOudmod07
 FCDeoSVSNhJ0WFDqUluTa+EcoklIUprZxfqLP0JvSUDr36fgXIKgYt3cNFTYPAin3xss
 2UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710333430; x=1710938230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W2KOYWLb0BCwLfBGy+z/iZaW0adTlaN63+C+ZhBqP2U=;
 b=Opr3ewi0Bq78scyJ0+R8EVnDuK/2v3HRnICRirVc2NveeOW4p762/Plg/0ZrMovA4E
 B0BFro3zpAnCTPp1ACV5nxg1eLfnZpxX0K88X4s3+qJaVZPNrKbi3iIAgyHx2L7jwa+Z
 BW41kYeLiCTdDav0OADe4Y4np02uzcuDyYj5Zse6zVerWnA/9gvVMcxnRxBcFH1CO7TX
 HJ4TmXe+Cq8ad5/a3x0dGxPWsHRonuJZggzXVhS6LLYEB8+EAYDPu4XYoW1g2nA9NQ8v
 soKsZbf6XlKIvDUEqLsKsZvBfJJYSBMlAgB/bLG2A4bJ9nJYS+ZFKblgVwQsuR6F7QIe
 Ao1w==
X-Gm-Message-State: AOJu0Yz7HR4Wdpcccz87Bg4Bs1Q8886hPUyPuD6e81rSRQlghq8293cz
 dSMsbYt2JGA5aEPgTStMqgs50P7+gfLWY+r+ApZNmdoLA8N9Ue60aIpiIMpKfr5uQCWcdGFJhVx
 50458OG4tQ3fCtOGIspQ590B3w8K+zZbAsIOUYg==
X-Google-Smtp-Source: AGHT+IFg5WiGPVggw1BAER6veKLyb+h8oZmon6cCX3hx4nw7aZN7qKpGOzOsxM6U8ZgHih17eRjtzgxqE/1P1aZ1JnA=
X-Received: by 2002:a50:d794:0:b0:566:4adc:45ac with SMTP id
 w20-20020a50d794000000b005664adc45acmr8313849edi.8.1710333429999; Wed, 13 Mar
 2024 05:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240312184115.365415-1-richard.henderson@linaro.org>
In-Reply-To: <20240312184115.365415-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Mar 2024 12:36:59 +0000
Message-ID: <CAFEAcA9BJicAwbWkWUL-YEXJbajw29oFo=vWkQkQSFS1hUahNA@mail.gmail.com>
Subject: Re: [PULL 0/8] tcg + linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 12 Mar 2024 at 18:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 8f3f329f5e0117bd1a23a79ab751f8a7d3471e4b:
>
>   Merge tag 'migration-20240311-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-03-12 11:35:41 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240312
>
> for you to fetch changes up to 4fe19bbbea2cb9f1ec28cfd40cdc7f61e95a790e:
>
>   tcg/aarch64: Fix tcg_out_brcond for test comparisons (2024-03-12 04:09:21 -1000)
>
> ----------------------------------------------------------------
> linux-user: Add FIFREEZE and FITHAW ioctls
> linux-user: Implement PR_*_{CHILD_SUBREAPER,SPECULATION_CTRL,TID_ADDRESS}
> linux-user/elfload: Fixes for two Coverity CIDs
> tcg/aarch64: Fixes for two TCG_COND_TST{EQ,NE} bugs
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

