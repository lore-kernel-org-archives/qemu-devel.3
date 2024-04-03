Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C89CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs3kV-0007qX-Cm; Wed, 03 Apr 2024 12:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rs3kT-0007p9-7w
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 12:46:05 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rs3kR-00058P-0J
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 12:46:04 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so8431a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712162760; x=1712767560; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lhPZ2a59NPTIei2BqREjeJ8Vthr7QTIi9oyItXN/7/g=;
 b=NcvwWstfrqd3NJHUtwbUq0mbCXQkoECo7aEtWqqycDRhv2EWhixSQaeThbcvarkZQ/
 DMj323nzaz/5tX+wywRoqPC9nqubhjHHrUVfbPm6IudAp3qMPf7oOb+BNa9zQ8rlYeWT
 Si3NuAgHyka622JqeS5FwVLWiRNNxYUZzrJ2RlD7+hSQGIOYgunxQYmMVzfnC5a6epPs
 ck2jYMOJZitnvVQiNZTDHLtL+QUJwV/x5NDyWPtj47L/D6AQA8CKGtddxwu/Jr5EMBV4
 wPalTIa5eZ1vAlrVQG3Np8wvwuFvjGeQAsq9hZasCIPzL6g+YPHNdJei1u4GFc7ZfREq
 VGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712162760; x=1712767560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhPZ2a59NPTIei2BqREjeJ8Vthr7QTIi9oyItXN/7/g=;
 b=qpQ1gG8XOAVtPZcauxJUCKhJJYtyJQgPmAyhL4lFPJ5r6uLfPMR+Qd+MClX96vR8tk
 Bs1CVtuJg7JWy3+6lOta0fkFp06nWrS5/8Hb6+NNHoEOdzhd6T9FQEQpWowD1YXSQA5y
 VcRKTCg2zGVZ3cu0jSlCcenrPfIDVsSBLA9NXxHqFYLp4KnEsD07DZrmpCs+PfLi1Tp/
 e0nCrrpGVvQ+e4QPS4bS/z8kR27ZvRBn4PLFdspFney5t7ZyGzqVzx7z/kG9WnnPMy9P
 Y8gHRHH4+/iKYRi24RvrTbWMYbNeDoLIkZBDiyG2t3aWtcz12gs0DUzVf6OPLv9LxUn7
 T9ww==
X-Gm-Message-State: AOJu0YzY0E27nU27EGeIJFmGOe5wjBRy4+cq1Zw+gJ/8oQERlG6LcynG
 2DU391I5N5JXEEeqfgRkPems4+vevC8wTqqpCM7LPvNPyLkHTMY16rJTRxDOJr9P8Fnqcy0ri3/
 XdgEovldDad8tUrJHurgtzoTfmRGYgBGkYRnP1g==
X-Google-Smtp-Source: AGHT+IFCxj5h6QqGauizF7offhy/fRs+azJXtcGZWoE12flNQmrSdiEWZom1n8cM/FFT85x/HKjVn+Tsna8RuqCo/Pk=
X-Received: by 2002:a05:6402:2809:b0:56e:a5d:acc0 with SMTP id
 h9-20020a056402280900b0056e0a5dacc0mr2162032ede.13.1712162757188; Wed, 03 Apr
 2024 09:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240403100614.74983-1-pbonzini@redhat.com>
In-Reply-To: <20240403100614.74983-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Apr 2024 17:45:45 +0100
Message-ID: <CAFEAcA8FPSJauySMN=3rdk6-9L8RTTXTSOZ=80NQgoxHYNiN1w@mail.gmail.com>
Subject: Re: [PULL v2 0/6] lsi, vga fixes for 2024-04-02
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 3 Apr 2024 at 11:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 7fcf7575f3d201fc84ae168017ffdfd6c86257a6:
>
>   Merge tag 'pull-target-arm-20240402' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-04-02 11:34:49 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 8fc4bdc537d901c200e43122e32bcb40dc8fed37:
>
>   pc_q35: remove unnecessary m->alias assignment (2024-04-02 18:08:59 +0200)
>
> ----------------------------------------------------------------
> * lsi53c895a: fix assertion failure with invalid Block Move
> * vga: fix assertion failure with 4- and 16-color modes
> * remove unnecessary assignment
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

