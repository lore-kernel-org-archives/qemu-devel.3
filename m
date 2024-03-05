Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54653C54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV7S-0006E3-G4; Tue, 05 Mar 2024 08:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhV6X-00058S-1O
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:45:16 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhV6V-0004OH-8r
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:45:12 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso7361951a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646310; x=1710251110; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nk61dm87MUb2IrBN3PbquWmu7NlfYTBZIb5XuqIsPV0=;
 b=ufvQVKnQxS5efNgsfY/4LJnRURe96AbVu9P3qH3BXoHTKegpuRsoYTaxsHddU4zuQC
 HQBK1sfR7V0ZFwIHRfWW0nwW9EVRJFzYd0uk9ViCOleCQhG8S/CUSpeLUrS4NzVcqu+a
 7oADEmYf7GD64xgfpHnboEKclSkL2gbr0lfZj0IrG/jhHp7Fg29WxdEbwGw8zML7e6Rz
 nZMr4EMgqFMpfxhotYJ6J1Rjq9vdUs/XN5YB/zCQqfgbdWDbcEFyaqckKlYqWQP4J3gu
 9Nzuf85J2ZrQzeMLOBp5aRjSvJnA6HvbxADD6BkIDUs4ukYCmT9lybeJAoCxrOatbLr1
 2ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646310; x=1710251110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nk61dm87MUb2IrBN3PbquWmu7NlfYTBZIb5XuqIsPV0=;
 b=TzzdR4hLqZpe2hoJeDH4e86+xDuvTWTK+2o1qd550i1p8Lw6m0iwbe9tUVMuI4MgJ3
 qKCq/G1SbzopeYaO2neoIXPwUgBep4QAhYkSsU8HH4eh3cf1YDVSBSLW2uErF6tc6TrN
 1GioHrIgEyaEV5JjqWMoqWOWfRXEVuPuxVQpaYMLOYLp8B2d2RC+KcPEk+YuyDYigGYM
 /zQgt7RMzgxSt4F8VsTw9OAR3BaWU/7evJOJXEXOYMjfKj3f8X+dI6/iWZzCte6//N11
 rrxgkP8/BmTY3iWgXIcsQiG33Js0JZ/W+86IubVSUCVRecln6k12CYOSHBc+aB7e/0Aw
 gp0g==
X-Gm-Message-State: AOJu0Yy8xe3br6cE5zoaHKNrqWkQgZf6nqQczfZXL8nN4Y58xX2lmwN6
 hu0ARf0TN+zZrcsc+JAm29Z0vduD9jXc4HnCrvOnfo2BUqnixKd0BozZWS7WZFCI71vAQZRQvaK
 IeDTTTya5iTzIFMVgJO/Y537MSAWNLvDbdkO3DQ==
X-Google-Smtp-Source: AGHT+IEEVt7WP3tzhrZlsUMavEL1ghvQGlGrVNrEYK/MbYPFCR0tjJfyYFf9iS88NySumWZJ2+iqPAOhLSfIoT7AGso=
X-Received: by 2002:a05:6402:1c91:b0:567:bab7:48fe with SMTP id
 cy17-20020a0564021c9100b00567bab748femr303900edb.21.1709646309858; Tue, 05
 Mar 2024 05:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20240304012634.95520-1-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:44:58 +0000
Message-ID: <CAFEAcA8J0+sq4A_6Fd85B6grozGeio=AgP_Tmi5hBOj=6SyVew@mail.gmail.com>
Subject: Re: [PULL 00/27] Migration next patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 4 Mar 2024 at 01:26, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit c0c6a0e3528b88aaad0b9d333e295707a195587b:
>
>   Merge tag 'migration-next-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-28 17:27:10 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-next-pull-request
>
> for you to fetch changes up to 1a6e217c35b6dbab10fdc1e02640b8d60b2dc663:
>
>   migration/multifd: Document two places for mapped-ram (2024-03-04 08:31:11 +0800)
>
> ----------------------------------------------------------------
> Migartion pull request for 20240304
>
> - Bryan's fix on multifd compression level API
> - Fabiano's mapped-ram series (base + multifd only)
> - Steve's amend on cpr document in qapi/
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

