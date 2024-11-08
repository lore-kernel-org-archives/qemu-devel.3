Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BEED4335C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 02:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9EbX-0008RP-FU; Thu, 07 Nov 2024 21:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t9EbV-0008QS-Cr; Thu, 07 Nov 2024 21:20:05 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t9EbT-00085n-P5; Thu, 07 Nov 2024 21:20:05 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-210e5369b7dso17528375ad.3; 
 Thu, 07 Nov 2024 18:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731032401; x=1731637201; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6ypjtB4Ce9/9kar+pxYobz2T5pYe4mcIKmiMbFih/8=;
 b=g74VikVWGK0lLeJAqUwzb2qLaQSxhlNcqMs7CHgzniajtGCOfZVxh0+vXlI8fF5HWd
 4AHD1dqMQ+UQbd4ekirxkWNZFq5QwPs32J6xMh9Svwm9O+dY/XQVR8AsUMotvQAs112d
 uFb6wJzeheawNbZPgzIr5EangK/O8VxPvJXPhMPJm940JaP4D7eB/KYGJe6jP8cQpVQU
 ksdm9CW1a3opQnTmOe9TNpwFPqBcyuSe6JMZ/5Sk4n4LhTJGCDsOxTaqybtw0io7qcb0
 ME1GhuaOoryhDBOy512H6dLS5XU/M8r6wA12ar6/x7TNdqOCXI4FesSr+PzwfaT5e7BV
 oElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731032401; x=1731637201;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o6ypjtB4Ce9/9kar+pxYobz2T5pYe4mcIKmiMbFih/8=;
 b=WH6eeXNF2gkT6owxIn2MOhwZoJEI63abbhYH/ev6SQZSjXKAcHZXlUXNt8C/aUQRnX
 dGGyu2jVbu9CSHJ8nkmpWrfPa+wMpcAzmaiJmDi0JCYKh9k/jaq/1XMC4HlQq8jZ4C9H
 r6GRnUATNS03kFxj1OVAKqUPvHUIcjzdjcwOAzeetBs20VsSM5OIZSFDIER4r1hpkdKr
 aQVzsA39LGn+LMBN/KyWu6ogOJqeKWbcg3/Cosl3+3ZSPQuPr4PJycM4kNtY1Ib8mL1Q
 d92CwV0Bp7ef6PXwJXw5bRjW76W25MOv0icVFN6RjwuEtaNNrNA3UIwXzpBAsjXExxJM
 ymww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWMMbjUgg8UpC5+0AqEUI0rubcQM2oXEbUn7gEYpP3HLdhJHulzkS84o+zhLS76vTu9zTErV2On6Np@nongnu.org
X-Gm-Message-State: AOJu0YzPVNQcElHdwNeKuyF5C1ZFTU6IC5FEaUsqMte2DQApJw1ReE/h
 FWxtjxZp+2keuSXb/xg3qEf6hSX96S+YqPwGvjVF/KgKG4j7uBgFGJ+EMw==
X-Google-Smtp-Source: AGHT+IG6HD4Dst/dDgt74HMbAZSAxV3gzKIHOmvjH6k/tjYYBw107uqOqaMmyAB/K3YCHgXtrg0zlw==
X-Received: by 2002:a17:90b:2ec5:b0:2e0:8e36:132 with SMTP id
 98e67ed59e1d1-2e9b16ea926mr1798465a91.3.1731032401518; 
 Thu, 07 Nov 2024 18:20:01 -0800 (PST)
Received: from localhost (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a62bd09sm4361235a91.46.2024.11.07.18.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 18:20:01 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Nov 2024 12:19:56 +1000
Message-Id: <D5GFRSOQDWYJ.2WQBSSB5WHJ83@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, "Peter Maydell"
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/functional: Fix the ppc64_hv and the ppc_40p test
 for read-only assets
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241105160926.393852-1-thuth@redhat.com>
In-Reply-To: <20241105160926.393852-1-thuth@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Wed Nov 6, 2024 at 2:09 AM AEST, Thomas Huth wrote:
> Since commit 786bc2255256, cached asset files are read-only, so now we've
> got to use "read-only=3Dtrue" in tests that try to use these files direct=
ly.
>
> Fixes: 786bc22552 ("tests/functional: make cached asset files read-only")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

LGTM

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  tests/functional/test_ppc64_hv.py | 3 ++-
>  tests/functional/test_ppc_40p.py  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_pp=
c64_hv.py
> index 1a6e4b6d07..312248bbfe 100755
> --- a/tests/functional/test_ppc64_hv.py
> +++ b/tests/functional/test_ppc64_hv.py
> @@ -99,7 +99,8 @@ def do_start_alpine(self):
>          self.vm.add_args("-kernel", self.vmlinuz)
>          self.vm.add_args("-initrd", self.initramfs)
>          self.vm.add_args("-smp", "4", "-m", "2g")
> -        self.vm.add_args("-drive", f"file=3D{self.iso_path},format=3Draw=
,if=3Dnone,id=3Ddrive0")
> +        self.vm.add_args("-drive", f"file=3D{self.iso_path},format=3Draw=
,if=3Dnone,"
> +                                    "id=3Ddrive0,read-only=3Dtrue")
> =20
>          self.vm.launch()
>          wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
> diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc=
_40p.py
> index c64e876c1f..67bcdae53a 100755
> --- a/tests/functional/test_ppc_40p.py
> +++ b/tests/functional/test_ppc_40p.py
> @@ -46,7 +46,8 @@ def test_factory_firmware_and_netbsd(self):
> =20
>          self.vm.set_console()
>          self.vm.add_args('-bios', bios_path,
> -                         '-fda', drive_path)
> +                         '-drive',
> +                         f"file=3D{drive_path},format=3Draw,if=3Dfloppy,=
read-only=3Dtrue")
>          self.vm.launch()
>          os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST =
2007'
>          wait_for_console_pattern(self, os_banner)


