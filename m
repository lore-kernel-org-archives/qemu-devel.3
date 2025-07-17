Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15262C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucT1G-0006xu-Oc; Thu, 17 Jul 2025 14:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ucQNF-0002ql-0k
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:18:18 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ucQNC-0003Ys-L7
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:18:16 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so179790766b.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752765492; x=1753370292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5JKf/eIwcJ/5LAPndooCHPLhiB4ihbnu5/M84AB0DY=;
 b=ab4PCw62ZeJceDiieFNqi+U8Ef7riAXA5skKq16DwlcC0sRnR0J8Hld2XLuL5og3Lv
 g/qCfa7gmY1Bah1lLCRj6vQzzBzGIkrDENHI7QOHnyzlyd5HPKCmLIZLv4E9plhw6s3+
 FUwkMgD5r44U9dTsKl9K3xni6bmk77E/0CbHuu29ua8gYsq3SbCdMPXC2fYVwoV09g9K
 GCz0VcDQu8TPMTvjK8QXXrE+ECuobf41dw/XiEGRDSUBBgJoSGbD00EcBmamLWaP/NYN
 uTUmLqy1bZ/kJ2pjzy06tsC2bMwVjiDjcBPlrDdZra+nAQKyWKUMF0HJQlMbu7QpuJc4
 fSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765492; x=1753370292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5JKf/eIwcJ/5LAPndooCHPLhiB4ihbnu5/M84AB0DY=;
 b=GGiuvuMJW5uGfGBEVZlsIkMIVD+E+04zzwwqu8o6u48fnyEeLh7oEA72nFNca6K5zC
 e2k6Ig0xcnngvlmJYNinC9NAtqFoiqFPDLVgN0/+MxmW4HUe+8Ls0wiuO2eyej8DhxD1
 1LhUs9/PMVpicP1XP4Yogzxo1eeGUm1YjWRghLJksFFtpgb/O+vjwtQhqGRRLIYqX5Qx
 NPziE/qJnwj5F64oRxjAmW9x8AE4TGWJkrVJ+mS4+mSLY8otthpzv8Z8T3NP4S5omDQP
 pD5bkoxkT/5rDBrTd8yhaBcLqjwP3XqDYofCbTF7fecGJKjpWiN2G8fLz7i6zGyvsGFe
 SjEg==
X-Gm-Message-State: AOJu0YwIm/vpCM99t7mZsuqSJ0KBrvMHq0og24ycDft2JgurvhbMG7Qq
 Mj4Bru37PliaTTPT/urJZ2r0Yungz5MDVG5dP3seR/vS3Z7Dus01c079Srdn07/640T1pf+McKi
 ORDuwACC4akOjxDk5+bgsRdCDnleYfzJ0xf6q
X-Gm-Gg: ASbGnctqQM5/gp5MztpeLafZBUGGcB4D7mTGbcsyT0rm7oqOsviG2AGdY0qBuOr8OKW
 TkvmyOs2685cD2iJUHfg5XrgHUSnnk51tN1OL6aFsmslfP7IiCjzt/ZrHsuikGwbozz5zQyDfeb
 +T8DYpx4CXO8/uauPyEjK+HZg48yVN9Z86hxekCV774XPV7ynNCVd4anNUfDjsVeLaLMhnnWneB
 7PzWw==
X-Google-Smtp-Source: AGHT+IEecd73V+ouvsk1jChFEDTLkiPRyPcEdgE/sJq6V0eOveBh7lcvmHJzi5abSy2HTzWMBEzDEqCJ/gUJ5F3Cz88=
X-Received: by 2002:a17:907:3f22:b0:ae0:db23:e3e3 with SMTP id
 a640c23a62f3a-ae9cde0032fmr725773166b.16.1752765491233; Thu, 17 Jul 2025
 08:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250716103009.2047433-1-berrange@redhat.com>
In-Reply-To: <20250716103009.2047433-1-berrange@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 17 Jul 2025 11:17:59 -0400
X-Gm-Features: Ac12FXwyP0qLVRTBlA2eO0rcFUCVELG4JfGLFZ-fDLKtiLvkTAgO5i54Fbdt_Ig
Message-ID: <CAJSP0QWCcCGbp1T_r_o0cYSnPM6yDJAUiw_GuVJ2oj_zX7C_Lg@mail.gmail.com>
Subject: Re: [PULL 0/4] Misc crypto & UI patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62a.google.com
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

On Wed, Jul 16, 2025 at 6:39=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The following changes since commit c079d3a31e45093286c65f8ca5350beb3a4404=
a9:
>
>   Merge tag 'pull-10.1-rc0-maintainer-140725-1' of https://gitlab.com/sts=
quad/qemu into staging (2025-07-15 00:12:07 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/misc-next-pull-request
>
> for you to fetch changes up to def71a6b12d817b95a81b622bad2ca096ed5a3ab:
>
>   crypto: load all certificates in X509 CA file (2025-07-16 11:27:30 +010=
0)
>
> ----------------------------------------------------------------
> * Fix endian defaults when no VNC pixel format message is set
> * Add more trace events for VNC messages
> * Fix checking of certificate loading
> * Eliminate cert limit on loading CA certificates
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (2):
>   ui: fix setting client_endian field defaults
>   ui: add trace events for all client messages
>
> Henry Kleynhans (1):
>   crypto: load all certificates in X509 CA file
>
> Peter Maydell (1):
>   crypto/x509-utils: Check for error from gnutls_x509_crt_init()

Please take a look at the following test failure:

stderr:
../crypto/tlscredsx509.c:526:5: runtime error: control flow integrity
check for type 'void (void *)' failed during indirect function call
(/lib64/libc.so.6+0xa8e90): note: cfree@GLIBC_2.2.5 defined here
../crypto/tlscredsx509.c:526:5: note: check failed in
/builds/qemu-project/qemu/build/qemu-system-x86_64, destination
function located in /lib64/libc.so.6
#0 0x562e710ee7e0 in qcrypto_tls_creds_x509_load
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xc037e0)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#1 0x562e710c719a in user_creatable_add_type
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xbdc19a)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#2 0x562e710c74d0 in user_creatable_add_qapi
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xbdc4d0)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#3 0x562e712f634b in qmp_marshal_object_add.cfi
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xe0b34b)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#4 0x562e7135dfac in do_qmp_dispatch_bh.cfi
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xe72fac)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#5 0x562e71387d9e in aio_bh_call
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xe9cd9e)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#6 0x562e71387f8b in aio_bh_poll
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xe9cf8b)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#7 0x562e7136c0fb in aio_dispatch
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xe810fb)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#8 0x562e71388f0a in aio_ctx_dispatch.cfi
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xe9df0a)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#9 0x7f06fbde602b (/lib64/libglib-2.0.so.0+0x5d02b) (BuildId:
c1b2ab1d795f60de663adaf74140f09f2b2fd034)
#10 0x7f06fbde62f4 in g_main_context_dispatch
(/lib64/libglib-2.0.so.0+0x5d2f4) (BuildId:
c1b2ab1d795f60de663adaf74140f09f2b2fd034)
#11 0x562e7138a648 in main_loop_wait
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xe9f648)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#12 0x562e70d92b56 in qemu_main_loop
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0x8a7b56)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#13 0x562e7122510b in qemu_default_main.cfi
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xd3a10b)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#14 0x562e71225074 in main
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0xd3a074)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
#15 0x7f06f9e01087 in __libc_start_call_main
(/lib64/libc.so.6+0x2a087) (BuildId:
fc3b3c4da3283cd44c006682a30b9df3242de053)
#16 0x7f06f9e0114a in __libc_start_main@GLIBC_2.2.5
(/lib64/libc.so.6+0x2a14a) (BuildId:
fc3b3c4da3283cd44c006682a30b9df3242de053)
#17 0x562e709d9524 in _start
(/builds/qemu-project/qemu/build/qemu-system-x86_64+0x4ee524)
(BuildId: 62905ce6fa45c21d61eea8ffdcee6ca6b6a2af3d)
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../crypto/tlscredsx509.c:526:5
Broken pipe
../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from
signal 6 (Aborted) (core dumped)
(test program exited with status code -6)

https://gitlab.com/qemu-project/qemu/-/jobs/10717452444#L69

Thanks!

Stefan

>
>  crypto/tlscredsx509.c | 23 +++++++++----------
>  crypto/x509-utils.c   |  6 ++++-
>  ui/trace-events       | 14 ++++++++++++
>  ui/vnc.c              | 53 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 13 deletions(-)
>
> --
> 2.49.0
>
>

