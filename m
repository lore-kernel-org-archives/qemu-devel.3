Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F32CFB43F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 14:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxRyM-0000sv-G3; Sun, 06 Oct 2024 10:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxRyK-0000sd-F0
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 10:10:56 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxRyI-0000Xf-Mv
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 10:10:56 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c8784e3bc8so4949526a12.1
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2024 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728223852; x=1728828652; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C9ClnrY3x2amDGHxOcjUBlicG90pPDOP6TnHeU7sBWg=;
 b=PJTDiaZ9OCsQFMLddcOwNEgQL015zT8gWP3HOq1EEVpT8e9a1WvQnYEVVDzKzFqDKu
 sClkNUOoJbjiz43hSqo1BR4Dis259U40SiROK+ceefyz6HFkoWcEjzS9+y75XpgsUAZb
 7vUywxQcZjLCpZbo6ePYvwah0A13KLQo6e208pn5UrSibDyzFbnL1g/tSHqXp/327fJg
 nYfNuhbCnI1YZ6P/IBXhsLokFmR2yRKEJCTRId/X5z6WQUwzhfmZIW+1ydwJantJduz6
 MuBb7oyrzqwO4xGrWLK655aPQ7hfv04XmlJwp5/hTOrcM4+GjCWD/mydOBk8fwuBOCLt
 zVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728223852; x=1728828652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9ClnrY3x2amDGHxOcjUBlicG90pPDOP6TnHeU7sBWg=;
 b=g5dYqjfaQCJGErzfzljuxf4XXgl0hYBLAzGo33TrIi5noPetr40DDVxXwvLPI3ZGxx
 40FINa2Iur6ZJdFyje3w4MYOmY8XMB1NSMFQ02FWK85bhc7pfrv26Hx9gGM8ho6RAlTR
 hbWTfQq1vM82VQ/E7/qIwO2EVepH6wIzogDOwqGOxvmk5i9DUTh4H1CdqmuNYaJIw+c0
 8hCDuztL98/fYY2iR6tTZ9jgKO5h2NeNJ30lJfSti7nkhsa8bhXnls9pjCsj/yDY1v/B
 9z4xiEXHPfqGujVeWzD9TswwOYtTR0hDbuLCOtnNZENLsuJUOpIpY94eyofA2Cc3ebF7
 /mWg==
X-Gm-Message-State: AOJu0Yzimw/EWe/xc+CVdfx1Zuwwg9lhAC7Mc59b9s3IelP/0e59e7OR
 2ecIj2trltlzhGo3cr9S1P/5T0byFVbAdtNgyPTLrEf5qBAvlELD2ys5ARpJBZTM6AmVwO9MziV
 jcSm3ZKxRmu+BuLQR8WhFCfxbEt3/pj72Ph4fLUMdY61y9JOZ
X-Google-Smtp-Source: AGHT+IGpZt/BRHo9YpCwByvDVZpnA+aJGknOOLGUl3IXR/sbjl971rpiI/U9KyLY8b7/doN/iFUeGSvKD0NsuPfOx58=
X-Received: by 2002:a05:6402:1f85:b0:5c2:439d:90d4 with SMTP id
 4fb4d7f45d1cf-5c8d2eb347cmr7462841a12.30.1728223851952; Sun, 06 Oct 2024
 07:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241004163415.951106-1-pbonzini@redhat.com>
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 Oct 2024 15:10:40 +0100
Message-ID: <CAFEAcA9k_NnEhvwq4bMV9SqgB9zhUku-_M6Hr2BASF0rR6UBvw@mail.gmail.com>
Subject: Re: [PULL 00/23] Misc patches for 2024-10-04
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 4 Oct 2024 at 17:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:
>
>   Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7cca79fa52128054b02ecbea249aa51e1916ba72:
>
>   qom: update object_resolve_path*() documentation (2024-10-03 22:04:24 +0200)
>
> ----------------------------------------------------------------
> * pc: Add a description for the i8042 property
> * kvm: support for nested FRED
> * tests/unit: fix warning when compiling test-nested-aio-poll with LTO
> * kvm: refactoring of VM creation
> * target/i386: expose IBPB-BRTYPE and SBPB CPUID bits to the guest
> * hw/char: clean up serial
> * remove virtfs-proxy-helper
> * target/i386/kvm: Report which action failed in kvm_arch_put/get_registers
> * qom: improvements to object_resolve_path*()
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

