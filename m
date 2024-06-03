Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58972C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 07:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE2S0-0000r7-7B; Mon, 03 Jun 2024 03:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sE2Rv-0000qd-Le; Mon, 03 Jun 2024 03:49:48 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sE2Rq-0000hq-9L; Mon, 03 Jun 2024 03:49:47 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-37494bf9b5cso5811885ab.0; 
 Mon, 03 Jun 2024 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717400981; x=1718005781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPMr3gJEjuHLxDkjYI4Jd1VHFuBc/KV5GKxtaT7USzQ=;
 b=Uu0ZSlgSxbj/iCX5Q4JwZQOPpUnazA7Ap4Y9LN1ndz34xA9i6d0EHeu6qkLYoUdjBV
 j48HsjjOtXxC2Xo9Nbw/vOT3RLaOoSNDlM20wYpYnKG6ugmGtK0gnmUA9osSqhEJeUOc
 8ilnNyN08jxT4vWOLGt+CqcHj1rT5Y1Z1P8Fsrr/GEE4bSa8qSCFdIzaFuJIybCI2X30
 VTW52NQeYlQXgjXgggKTRxHLwotyRCzmX9LzG8DKWYmEIJwGPrYuudQ8qig3tekjuSUz
 wwrnlimj5S42bvLhhxB1pyzwZBGEOTjpEGc/3W43Txj5OcorKBpUVPlzEEvdlfvqemIM
 d4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717400981; x=1718005781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPMr3gJEjuHLxDkjYI4Jd1VHFuBc/KV5GKxtaT7USzQ=;
 b=Vvlba1ba305Nu0V5zY5AYVvnH6JC1PfIp1dyOVgG/yMABBZizC7kKuX9ZRnPKxJb4I
 lymM4Dh0yjf1UFSFe+zk7uwt9LByfYVTA5M2mvsbj1U1eKNojV3qu2mak5maMc/YjEjg
 v5PaWuKgRwGxTQc647YCoa97iUGJ52D7A98d/YG+KaQuJF3/nBxL3ZApiKhC6UvZHCtD
 moU1iP2CwwR2STCZPRUyqP23XvNf05Ui/pnu0yuSQ3Rz/+z337icxI62l+gWKRMMscZI
 Cx5aaKi2/Abqt57F81x9neA7HPCky+kWMBdoLhO0wdWrURz62nnxPKKZwFMS5qNJQtVO
 v5Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkuQUaOqIQ+CDXCbokiTSx+bYsyQB2/Av8SLQpLEw6PP2/6bcjOleqRKCKxYfTAiCoi+lrpT+wO6q7lFbQdwIK3zvU0Powog==
X-Gm-Message-State: AOJu0Yw7YBmUVSfO//bZL9NFknpL+8fMiQf/vfv+ik0ROpm7UAtl3499
 xemef9AcaIdx2SoeOPHcbcn+qzi1ElILcQL3qbpCTW9oU3gU6kEOH+jshLRCSw/ZD6QNGGyaciP
 iY9eRfnn8hDruB3HZtaYIxJbhgz4=
X-Google-Smtp-Source: AGHT+IFMAqnzXgynSmQIFsRO0q4PwBLdauIVUx3x0tFh/0NXppwcOnYCsvCl2na53LDwpM7J06OXFJJURF4l+doMZVs=
X-Received: by 2002:a05:6e02:1fc2:b0:36a:1104:2d6e with SMTP id
 e9e14a558f8ab-3748b96c7b2mr94456235ab.1.1717400980794; Mon, 03 Jun 2024
 00:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240602103810.21356-1-vilhelmgyda@gmail.com>
 <7b93d09f-2926-4f44-9c67-591317eeef52@tls.msk.ru>
 <CADe4k3+55-EQjkp6320+kUZ99yatoqsh6wEhfZEo7EhTCLAE2Q@mail.gmail.com>
 <204321db-44b2-462e-b0ba-fe93193b5575@tls.msk.ru>
In-Reply-To: <204321db-44b2-462e-b0ba-fe93193b5575@tls.msk.ru>
From: Vilhelm Gyda <vilhelmgyda@gmail.com>
Date: Mon, 3 Jun 2024 13:19:29 +0530
Message-ID: <CADe4k3+gQj-mc7r+yeEaopJiRFFSpxDRSvfDmwPiGqzRvNhVaw@mail.gmail.com>
Subject: Re: [PATCH] i386: removes microvm from default build since microvm
 doesn't support Xen accel.
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, philmd@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-il1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 3, 2024 at 1:10=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 03.06.2024 10:31, Vilhelm Gyda wrote:
> > We can remove Xen from default build too. Though, I think, regardless
> > of Xen being in our out of default build, the "depends on" change in
> > `hw/i386/Kconfig` is essential in itself to cover the case when a user
> > builds with Xen only. In case of a Xen only build by user, without the
> > proposed Kconfig changes, microvm can be ran with Xen accel. Something
> > that doesn't work currently.
>
> FWIW, I love to have some minimal xen-only build too, also microvm-only
> build.  I do this on Debian with a few tricks plus trial-and-error when
> choosing which devices/features to enable/omit.  9.1 will have microvm-
> config already which is good.
>
> Yes, either depends or fixing microvm to work under xen is a good thing
> for sure.

I am new here so I don't know enough to think critically about this.
On my previous submission Manos addressed the idea of making microvm
work under Xen as:

"... Xen machines in qemu already provide PV devices analogously to
what microvm promises to support. What would be the use case for a
"hypervisor agnostic" microvm machine..."

https://mail.gnu.org/archive/html/qemu-devel/2024-05/msg05842.html

Also, in terms of finding things or projects to work on qemu. Gitlab
issues page is the only place, right?



> /mjt
> --
> GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
> New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D=
98 ECDF 2C8E
> Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0=
A0 8044 65C5
> Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt
>

