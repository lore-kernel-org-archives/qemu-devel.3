Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAFFCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 22:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9WwH-0004Kw-7p; Thu, 16 Oct 2025 18:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v9WwF-0004KX-P8
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 18:59:16 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v9WwD-00067q-K4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 18:59:15 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63bfbbbdd0bso2510895a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760655549; x=1761260349; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goE7sJ0NA1XckLEa4ixYcO17gAKRnfIduKfyBhjA9xs=;
 b=C5+Nee6xyS7DH/IZl3+W++ytCabdfPec3juaN2Ilx/40z/v6WXXaYdMs89MRe60RMw
 3UvB/e3dE4E9UE/NIC26oZH3xWQY0afboKFcN6rF7pru1IweW6Hyec7Xvjxi41Xv/L8y
 ji7FAbf7R837RICc93ulKxwibm1ZwlHrHWWQnsGjce2uIgVgCmafU/ckVrio1uAv8cVE
 W6hwZPo0sTILJsiwA6uYj51U8JCCxw8Ydk3kec39iKjTumAtsXE6Cwedps85v1wYmJq/
 lrUBSDmpsFLwL/I6Cu3LniZpjPm1oN4u9S7JepvDaZQ6KHP18BxHIybLylL4C8qjLphz
 G3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760655549; x=1761260349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goE7sJ0NA1XckLEa4ixYcO17gAKRnfIduKfyBhjA9xs=;
 b=mxuW8Z/VZewi+ynrpkxSSCxvGZrg/t6QdFK+XNvElYpKWiX1SsUdVRdXyFow9eJbVt
 9y252WJIush/ZUncONLLOw3p7Cb2CJWEB3KsLO6B4sfedI1M7IW6O7N8cFJdxqv/gUa4
 5zCnbgfPC1TVuO28pqF36NkxCkNu5MeyoNPqGbVLqfmeOMCRRzjCwO7WqIRRFN/14U1G
 k0msdMu0Y2emtKFCe0m9fDHIkcEhrEdDk8byxqaVw35BBswDOCKmFj7cvX41jHVrpJN1
 z1385EeEUDn1lAfYgICOM7+74F6gcgthe1Jbwj+hWoj8kEMhqmzI45GvdTLQ735/26tE
 9ZbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH+Ka8mViAOtWPb7LYDk9owvbNwDfSJ1SyLItXWGqsgPEF8Z2jdO80OlfOslbs6enu4edKyjtI2CTs@nongnu.org
X-Gm-Message-State: AOJu0YwvHVNRoXZV7pNkbmHwN61dTPauj6SaLBFoCP7cOKsYJuFjB7Sg
 iOtb7ZuFB+tork1k/a1rGUbC+sxWLkKGFoe4FYEnZlWK/XzXZjJ4SUFV/5D3uivZ8bkJXf5NBZQ
 eGji9Qo6RIPZDaNxar7FGfjW7EJM6KOs=
X-Gm-Gg: ASbGnculQMASjuPeBwMUtQw6o7O/d/A43zMtVoI/EISXeVADKz3TkCeGbmRMwGFtO1D
 NpsPDtTTrQCVeiiaX8DSlgV7F4+7xTKJXfOXNQ3+BlfCZjNmryGBglF5l9A19aUacGkL60tFPRf
 hwCNqQMrC8U1obaobsBWp9E0Sj9Z0kcO8mPxqRS4lHedmn4WaASPNFRqpiuFkTz8AGrMdaelFQM
 UgzSFB93Le1TB4IiTcwWfKQUYc4bCklRlJmcAvGhfciCECYuBfxcnUM99Y=
X-Google-Smtp-Source: AGHT+IFNojWlTsRxHiedH3X9Cv9Mk2VVl99lEP736+4dQcpIQjids1k4xHWytHz0AfjDeMYEwdp7t8wYDEAnOwvTAdY=
X-Received: by 2002:a05:6402:2801:b0:634:a8fb:b91d with SMTP id
 4fb4d7f45d1cf-63c1f57e517mr1569018a12.0.1760655548318; Thu, 16 Oct 2025
 15:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXLR5QkPwS62aGyKTTajwaXz-6bXzq8FNumW-HfMiQptA@mail.gmail.com>
 <aPFGJXe5gEqEQoIJ@redhat.com>
In-Reply-To: <aPFGJXe5gEqEQoIJ@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 16 Oct 2025 18:58:55 -0400
X-Gm-Features: AS18NWBUxKgy56AdWnwPSe0sW4IIouOQMi90miz4CXOTh4MkAGDdMCrVT_40tl0
Message-ID: <CAJSP0QVSszz0iE9Yv--9nRL6=7F8k_CcpWiFaktM5Z4P=KM9BA@mail.gmail.com>
Subject: Re: SLOF repo mirror URL updated to GitLab
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Oct 16, 2025 at 3:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Oct 16, 2025 at 02:57:20PM -0400, Stefan Hajnoczi wrote:
> > Hi,
> > QEMU's SLOF mirror at https://gitlab.com/qemu-project/SLOF has been
> > updated to pull from https://gitlab.com/slof/slof instead of
> > https://github.com/aik/SLOF.
> >
> > Thomas Huth requested this change on IRC and I see that
> > https://github.com/aik/SLOF has a notice pointing to
> > https://gitlab.com/slof/slof as the new official repo.
>
> Just changing the mirror location is not sufficient. The most recent
> commit in aik/SLOF, which was mirrored into qemu-project/SLOF, never
> existed in slof/slof.
>
> We'll need to force push history to qemu-project/SLOF to get rid of
> the divergence, before the mirroring will succeed.

Thanks for pointing this out, Daniel. I have force pushed so QEMU's
SLOF mirror is now syncing with the new upstream repo.

Stefan

>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

