Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8D5C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1aH-0006YC-Ba; Thu, 08 May 2025 09:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD1aD-0006TX-VP
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:46:42 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD1aB-0005LM-Ic
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:46:41 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e732386e4b7so1042645276.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711998; x=1747316798; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icZBIvI1UBMMGilMqLbnwCDH5oPRY55BMuvb3dIFfEE=;
 b=lbI340gqIYDE4ll6/IlMfdYPyNh/fvgpuaZk/r/EYb3rOQsqJBcUoW7aFLg52OKUP8
 wmSmwVv6eqvrtsBlUQELU9SGpiiGpZn27CsBq1wmk1PblXCHIrt4MeM/AXWx0GzMU3ve
 PDYNp8yQqBptRC4kDxWuzD/ST7tu6lgh+VEAbvJnqg44E9xnHMfYc7kPoDOmqhZSuMKI
 6hlBIM6fODJgPFbkXnVWDxwsU2R0I94+QHK/+8Oa0bU0mAhah8NJ8vS+WxjdJ6HIOMfk
 hvU7hdJielbStOQ/kbovGYvXaDnIh6gkZVtpNAbiPYXyhK34oElUtQG2DfptWuDZW3Oa
 iEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711998; x=1747316798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=icZBIvI1UBMMGilMqLbnwCDH5oPRY55BMuvb3dIFfEE=;
 b=tcUQ1NHKNeNGIx7q8Wj5CAApDiGmYYYLDLPGHRd0b4if2zCfyrx9zY1R30cAiLYszW
 Ay0ldLXWFPjA4GpdIj3EBywqlY2R7Tjsem6FL/SnItnNlYPEP9MdBgevPUXPTUXeGHTt
 DfZ1agf8mPxZ2GjAVfwW5wDKsD3NgzliGFL8CzEq1JkEGlg01WgiZJe3upj4Fnlm4mbW
 CMeL72rhGlNTVzMwKZt/gLNK+buceyulLeDkGeJmwejdVyoxRhQGklncOrPGE3UUJYHP
 iccHtpBfhg+Ku4aM00bB4ldvwVF9Gx2djZyCAB0fpcn7yV3u76Rz7Qjv5SyuFeUkpy1c
 hoow==
X-Gm-Message-State: AOJu0YwvWjslrIzsKpdVDPIlJ16PnokD39Rjt0ZKxp0YvrpD64IomVF/
 SGgq4bZrz2DM1G7sXPD+wk5O8tnqPVCGsmp+Dped/le8NH4QZfuxSHtO9ChCzq4q+NQu3jsgNbe
 gL8zdhunAepqv3J4DXIAx1wQYKM8ZKM0mj2kZhg==
X-Gm-Gg: ASbGnctGlUxl7eoWG43yaeLHfiqtaQeHcWjJW5NUd9KdkmdYaV30iPXKkgR9uV+KkdD
 inn3KnXNxL5VNyH7TKPchyxf2QQ4lT5CXKXqayFjKGOKc5HS4mPwRJaMFSpmGBMgcSyp4vhsKnJ
 Y35lAMP6JbcWOu1rHPGp0EAI8=
X-Google-Smtp-Source: AGHT+IG8itxaIIgqSrLT+0VR5Cs4av7+PpQbqzwtlb5+gfp+gQwPsSkY0a8hRuoyHpLHAKCO6/rJ1PwmqUVorGUGkP4=
X-Received: by 2002:a05:6902:268a:b0:e75:bcba:aae2 with SMTP id
 3f1490d57ef6-e78814436e2mr8642702276.34.1746711997674; Thu, 08 May 2025
 06:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250408185538.85538-1-philmd@linaro.org>
 <20250408185538.85538-3-philmd@linaro.org>
In-Reply-To: <20250408185538.85538-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 14:46:26 +0100
X-Gm-Features: ATxdqUHdu0R1-dV4m7puis-pmrl1EFnhaUXGKgp__cSk4_lQy9BJaTEjdEjOBVw
Message-ID: <CAFEAcA-uDSs3eGQTPd5mGUEUJ15Ny-=c0AQioVza2j3FtxDeVA@mail.gmail.com>
Subject: Re: [PULL 2/8] hw/core/machine: Fix -machine dumpdtb=file.dtb
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 8 Apr 2025 at 19:57, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> From: Joel Stanley <joel@jms.id.au>
>
> In commit 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb
> option") the call to dump was moved with respect to the init of the
> machine.  This resulted in the device tree missing parts of the machine
> description, depending on how they construct their device tree.
>
> The arm virt machine is missing some PSCI nodes, while the riscv one
> is missing most of its content.
>
> Move the dump to after the notifiers have been run, allowing
> virt_machine_done to be called and the device tree to be fully
> populated.
>
> Fixes: 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb option"=
)
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-ID: <20250401041509.719153-1-joel@jms.id.au>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

I just noticed that this (which is now commit 15a9fe6e35369d6e4
in master) didn't get tagged for stable. I think it's worth
picking up in the 10.0.x branch, as the commit it's fixing
is in the 10.0 release.

thanks
-- PMM

