Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E21AD33A04
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQWL-0006dc-HS; Thu, 15 Jan 2026 11:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgQV8-0005vt-Nj
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:47:17 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgQV4-0002sC-UP
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:47:13 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64472ea7d18so829185d50.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768495629; x=1769100429; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dLpB9xpODEAueR62n/GkI0QwFHxW938HRna5py6VUnI=;
 b=x4dSEW6O9WqGFPq2IFNaurL5hJFGnNSejRth5cx9gDnj+b5k545XIQTY1GcTbl6wOj
 a0+Y3QjmA2MH1q0dLrRc3txAr0i1Q9i/z9CrTXOHIiFgMpZV8XAjKh3MpwllzBt9qJ92
 BcdfjQCZIWiFWTY/ESskWxTYbHvSDqNPTfj3Bb2wIJr4VEDdvaUVjmYIxzSEyMz3CjfZ
 xM05uofF9KlnHq68LF6l3myAcs1mxe/Cf1HK0Z0QWAByup06/QhdWeUxdaxJBwWWN3eN
 046RTIF/bD14LBaQao+JQyFLHCVZRlZ3cDSxxvoTvvEZrp1PcD+in2z31t5f1SCpS0eL
 C5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768495629; x=1769100429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLpB9xpODEAueR62n/GkI0QwFHxW938HRna5py6VUnI=;
 b=j2Dmfy8f/t9ow7nO4n9bL3k/+ZetqUxFhGrzhYYCsp2sTy6L35+Liv08AAfVoaqMmj
 sm5gA2nl23YJJUaNAL4nx2myZ79YQz3OCeeFKADlNIKee4RREhu7nvxh06CvCHGOUlsh
 VS4So8vzsJ4PImuvhYIQL81pS8fDD8e2wRPCLy4m23ak0IlZ2vcu3OGLRApRRks8Qx92
 zTQDJOLkLXa1gFRnCcJgnZzC9nbWSBiO1DoTxZChNjfFydXlJ1kWtdDmr/Bl4ibGxB2S
 2gheuhnJadUvRwVrEwlwXSZQN3bJAWlyUQatLfQkMcyUzya/3oehKZcF2WVw/3NK88Rt
 rDFw==
X-Gm-Message-State: AOJu0Yy1LVgiZ2Bt/uGLbYj1fuEBNLyz2nRNHcazfcm/a211coQrFtCp
 uEKAOpr9okcGzdeGlw5ny1FQ9sMnCEW231m8HhnZY7OHI1RGmFUtrL1oFOO6C0YHDHtbcSPA970
 NQxLi7JpD4uyM512vztTsi3MaN1cqlufsu4W3miQgPg==
X-Gm-Gg: AY/fxX5qwUXO4Tx19LnegbT/kqquLwto8vAGS6XYxVKwEMCwDVXhD8ek0iloQOEUpxe
 jQkVnd1oP3CmQHDNNCFwn5lNUTFPBrPnXDRyS5WM+XWjtcmi33JMbLRwO30tCyQZo+v4xZPzcb4
 18bd2fmVJascDljuCwhSRI6ICsQ72ZvjhYRDj3bqEZXBBIUDD7iqzScviGMQUv52DR01phDxpKl
 4lwaM0GkCCt0+NZVX4/WbQXjIhE8KaZ1vqY+OJ7MLG1JH+z+slxmOOjBB85I0IfsjYlz9wWrSu+
 gJ+g8BccmVBfH2UcgXjFwk0=
X-Received: by 2002:a53:ac84:0:b0:640:b501:d7dc with SMTP id
 956f58d0204a3-6491649f7fbmr291748d50.23.1768495629440; Thu, 15 Jan 2026
 08:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20260109123211.368869-1-joel@jms.id.au>
In-Reply-To: <20260109123211.368869-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 16:46:56 +0000
X-Gm-Features: AZwV_Qg5__UKLyEP0MJ57qQ8O8hekEzAooy70ZwpURjy0r-AltrNLHYyTBx6Yyg
Message-ID: <CAFEAcA9JW+1f+mRKXtFoFwGUKzBM0mypjMFc5ToukRyKqCWy0Q@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: Add designware i2c controller
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Rauer <crauer@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Hao Wu <wuhaotsh@google.com>, AlanoSong@163.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 9 Jan 2026 at 12:33, Joel Stanley <joel@jms.id.au> wrote:
>
> From: Chris Rauer <crauer@google.com>
>
> Reviewed-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Chris Rauer <crauer@google.com>
> Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
> [jms: rebase and minor build fixes for class_init and reset callback]
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> This is a re-submission of the model with Chris' permission, with a
> light touch of updates to make it build with qemu master.
>
> It will be used by the Tenstorrent Atlantis machine, which will include
> a functional test for i2c devices attached to the controller.
>
> Daniel suggested that Alistair would take it through the riscv tree as
> a (soft) pre-req for the Atlantis machine.

Hi -- what relation does this model have to the
patch posted by Alano Song a few days earlier?
 https://lore.kernel.org/qemu-devel/20260106131253.16192-1-AlanoSong@163.com/
Are these independent re-implementations? Do we
have any particular reason to prefer one over the other?

thanks
-- PMM

