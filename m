Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1869DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeF7-0007M4-PS; Mon, 11 Mar 2024 07:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjeEp-0007GX-El
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:54:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjeEn-0002tW-8w
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:54:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56861dcbe79so897052a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710158075; x=1710762875; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XrPJ5FVMRW+ARTZ5yjY3kOrjmpkbRj73yOQGeXfiVZI=;
 b=PhZZ2XPdr/Q3HUiPSMV0Dog6f0sJWqUYtMDH1IT7BcvQu4trPsqn6OacqqTxFmY+eM
 2XiIG1Ii0e7PF4HMnEE0XfYv/+MuprhFx0NWLfcHCyXtBcmD9NV9CRd05seZsOlzXQbi
 m9FIzq7ZeRbR02j2WvQPLnskEUAy0K3plt1GwQQ7LYjibkjBs/PwW9eECu1GSIbEAQxo
 EekAXciQOsvVksrICxeTYnYFUSzeuJdQeKE7EOkaevbcl0iicbXCoPkZ3CgcjiueqyQ3
 4IdcjqpyRE6EW5n/6O+2GPXMtGOpNVf6hK7UZhc/i3MyguJV3DcJbWjQfaLlPwahi12r
 JOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710158075; x=1710762875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrPJ5FVMRW+ARTZ5yjY3kOrjmpkbRj73yOQGeXfiVZI=;
 b=fWnr+f3pCWsSYlbpAR9aaHreXUP6VifNTnelqbjy/Qo42kFMuBJizj6Q8bfhSFFPuM
 hci1b4Oev4pMRuAkpuocSGly58488tKeH4ychQNDfOJRf2PKgsiWrxqWXwwQiMLKVCkh
 +lktsGoaYNqzEI5+X75hE5KKEht4kNeOtVziBraWrej7OGrtTEVIaC2n7V8KiuRJMiv2
 vPl2JDulx2Ni1UlMcOJhDk4I64F6Suvl8PJvX4GxYaziOmoivJLoLfppOiwcetH+MIAy
 3ArZzBt/KR9RfEnbPLdW1n88+JGo+e3kHUKYr8I3JvwSSct3xR0ORqNPO4vnF0AfIOGb
 UCsw==
X-Gm-Message-State: AOJu0Yxf49ARH61a7MuzXV5ncgu04lgUlIAuAOGyWofA31tr2fwtmiTn
 l+BqpKftmIWHun+iD3/m4aMQ9a/bgW7JOBJsRBjkIRSXf/3ISyLJeXN8Lb4oQoYGdRzUfSt3Ekj
 9s/gM/DsnaYMRS63R+L6Xvr0nQYY62xiCZwk5MA==
X-Google-Smtp-Source: AGHT+IHAqJ2HIeeQMU+3lWA6aDfKgBNe09gLudVACFWWXhewWHCxQUOheT3slZn+sDAo/uGd6orPrCwF7CNRc75tRe8=
X-Received: by 2002:a50:d514:0:b0:567:1b50:559c with SMTP id
 u20-20020a50d514000000b005671b50559cmr4655791edi.39.1710158075053; Mon, 11
 Mar 2024 04:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240304012634.95520-1-peterx@redhat.com>
 <20240304012634.95520-26-peterx@redhat.com>
 <CAFEAcA-nfqP3LyGyvoeCSUce4OX5t_N_VcDc07Wa_GMEs4B5dg@mail.gmail.com>
In-Reply-To: <CAFEAcA-nfqP3LyGyvoeCSUce4OX5t_N_VcDc07Wa_GMEs4B5dg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2024 11:54:24 +0000
Message-ID: <CAFEAcA_UwiLk3trSYuetXk9KrJY=moP2DyBPSNLH_moMAONNgw@mail.gmail.com>
Subject: Re: [PULL 25/27] migration/multifd: Add mapped-ram support to fd: URI
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 11 Mar 2024 at 11:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 4 Mar 2024 at 01:28, <peterx@redhat.com> wrote:
> >
> > From: Fabiano Rosas <farosas@suse.de>
> >
> > If we receive a file descriptor that points to a regular file, there's
> > nothing stopping us from doing multifd migration with mapped-ram to
> > that file.
> >
> > Enable the fd: URI to work with multifd + mapped-ram.
> >
> > Note that the fds passed into multifd are duplicated because we want
> > to avoid cross-thread effects when doing cleanup (i.e. close(fd)). The
> > original fd doesn't need to be duplicated because monitor_get_fd()
> > transfers ownership to the caller.
> >
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Link: https://lore.kernel.org/r/20240229153017.2221-23-farosas@suse.de
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>
> Hi; Coverity points out some issues with this commit (CID 1539961, 1539965):

Oh, and also CID 1539960: there's a third instance of dup() with
no error checking in another commit.

thanks
-- PMM

