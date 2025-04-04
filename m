Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F5EC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XKH-0005yX-Ux; Thu, 03 Apr 2025 23:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0XKD-0005rJ-S7; Thu, 03 Apr 2025 23:02:34 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0XKB-00086y-Vx; Thu, 03 Apr 2025 23:02:33 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-520847ad493so1501652e0c.1; 
 Thu, 03 Apr 2025 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743735750; x=1744340550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfSmNMORF6/3TZL75u4GLWRY7K/RKERTN16F2b7owKQ=;
 b=lC/P0lPB6kj6r77ZVLhKdpn2WES/x6K12cz6zDUFxfJ0/hkmyj2I8JHlPlqyb73gkE
 VJWxjlBepetCd9YOpjj9gSIyx8C5+aAISLZOhjuZupe2STBD2fTAeqLlyhJCrTsVgaGQ
 3SJXlc6LNa/0r1TOHz1CdXdFz+O8xwgGL9xn7lVta72l/JxPRu20cecUYr4VPCL5C6eb
 zG54SJ3UST6WnRSEXHXyxenwarblorOvWE5ypfByTj6ykYrZXmxvjqjNdaNbxWt+CjC6
 49vZ9tuoFwoyWbRMH6ZFyDVqKI1lr71QzEiKQ5X4/ciU7mHWN6EnvkSY1a13RFAP+2yk
 4odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735750; x=1744340550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfSmNMORF6/3TZL75u4GLWRY7K/RKERTN16F2b7owKQ=;
 b=mukm4ZZXJ5i8VC81q30vK8b5eodY5ATOsBBiJ585F/oaVM82hPHpTEaZcFpXTEOX0W
 CcymGWkai6uDHGl71nfWWIKrs2ytRJTuQZ5c+z1w4ab5PSXKWm8Zjbo5f+59Glu0D3cX
 0diPL1JdCPdcYgClSJW3vXf5hMD5rgSm7Z5FksbzPr+IuqF6c0l5DhYlvUnyc66vPVvQ
 sk3HhwsY/jBVpWY2QQyXFpcnQqsrnaaymLvFDzknE4gq0NdGjVMfX0wVPQxc1Ec4QyiO
 PRIoOqXvOwjjlgIS1SOeBm/RzEoLKMYnC4PoRzaXB4ZFzqFA3IO59AA5/7isEF0VNKqj
 rEjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnUaJXFLFWtvFioiz7e+CMUcwDw5bAkDUqslw4HLxUxNqiPpiix6xoiskDhu8ZqQldmvYeSy5YthiT@nongnu.org
X-Gm-Message-State: AOJu0Yw6xWzFFw7Np6M0JuHB5J1GUf4ceEiwObqCZJgR1WA4HisUiOqg
 YPuZRqqldjLYfo3ibE3sGgjLN41i6hG6dbcBzJQ+7SiyTfrLQiAJVCSIXpXzqxUzCRDkQjwYrIA
 BXdvrg42gdlFSvwlJkBiMLF/gwZs=
X-Gm-Gg: ASbGncvzZIEcEaQ3WK5r0sNe833vipeZFjH/A/IiWXn3iG/Li7JAoWCToGKiVuf4DWY
 lnLk1q5lo4ztpjX2+qq8Odu6Y2HF2WH6Z9BNVzgd9BfLbvvTMajZLHlHQEeaJqSruPkGZz6wadD
 0ddt4BC4MlVU0j913QkPr7mlatl4lflbTmegnmyxPfPapAOjaHRH7CgxLq
X-Google-Smtp-Source: AGHT+IFI0HRtewG/hOMFmnXCBqlt2+2oXTE2IqC2HcHSH9Q4pIq6iIHNUWxlypLslzePg6cRSEMvAc7N/uqQa16XmSI=
X-Received: by 2002:a05:6122:909:b0:520:62ce:98ed with SMTP id
 71dfb90a1353d-52764542ce4mr1612846e0c.6.1743735750482; Thu, 03 Apr 2025
 20:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250313152330.398396-1-paolo.savini@embecosm.com>
In-Reply-To: <20250313152330.398396-1-paolo.savini@embecosm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 13:02:04 +1000
X-Gm-Features: ATxdqUEfx4wb8EWqlvop383VcUBcmN6AE2I2a-nu10NFJQhragGhKziAoYtVUII
Message-ID: <CAKmqyKO4qUL484ndaGSfWX3Rcbhx0zDaGbvt3noJ49-BPCfD2w@mail.gmail.com>
Subject: Re: [PATCH 0/1 v4] target/riscv: use tcg ops generation to emulate
 whole reg rvv loads/stores.
To: Paolo Savini <paolo.savini@embecosm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, 
 Nathan Egge <negge@google.com>, Max Chou <max.chou@sifive.com>, 
 Jeremy Bennett <jeremy.bennett@embecosm.com>, 
 Craig Blackmore <craig.blackmore@embecosm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 14, 2025 at 1:24=E2=80=AFAM Paolo Savini <paolo.savini@embecosm=
.com> wrote:
>
> Previous versions:
>
> - RFC v1: https://lore.kernel.org/all/20241218170840.1090473-1-paolo.savi=
ni@embecosm.com/
> - RFC v2: https://lore.kernel.org/all/20241220153834.16302-1-paolo.savini=
@embecosm.com/
> - RFC v3: https://lore.kernel.org/all/20250122164905.13615-1-paolo.savini=
@embecosm.com/
>
> Version v4 of this patch brings the following changes:
>
> - removed the host specific conditions so that the behaviour of the emula=
tion
>   doesn't depend on the host we are running on.
>   The intruduction of this extra complexity is not worth the very margina=
l
>   performance improvement, when the overall performance improves anyway
>   considerably without.
> - added reviewers contacts (thanks all for reviewing the work).
> - changed the header from RFC to PATCH.
>
> Cc: Richard Handerson <richard.henderson@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Helene Chelin <helene.chelin@embecosm.com>
> Cc: Nathan Egge <negge@google.com>
> Cc: Max Chou <max.chou@sifive.com>
> Cc: Jeremy Bennett <jeremy.bennett@embecosm.com>
> Cc: Craig Blackmore <craig.blackmore@embecosm.com>
>
>
> Paolo Savini (1):
>   target/riscv: use tcg ops generation to emulate whole reg rvv
>     loads/stores.

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/insn_trans/trans_rvv.c.inc | 155 +++++++++++++++++-------
>  1 file changed, 108 insertions(+), 47 deletions(-)
>
> --
> 2.34.1
>

