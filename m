Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B24C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 11:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3AiL-0002zZ-J7; Sun, 06 Sep 2026 07:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1x3AiE-0002xQ-Fy
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:07:02 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1x3AiB-0006WH-2I
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:07:02 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 00A7B240104
 for <qemu-devel@nongnu.org>; Sun,  6 Sep 2026 13:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1788692813;
 bh=Dlr2orpzpAgAVyJXul7eEkywX/xV8rw30gZcV165DV8=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=ImJKqidEo3lRMpaYvWtXzPtSt9QkqO01EntcvwjAc05XQncuy+7feGYUlpWnikWAL
 6v6jLfjBvRXZkZc/iIACZ3AhgcHP5CRBAg/bziE1T+MzVAnhQ8FsLPewYVNVMYdm9h
 0x1MWxekQ7qzNlgsEbc6thsX9O+sXikQDbYX97cafo8UTLFGjduLiBJX0cOwEhWf8c
 VRVp5F3Gv3uKd9pvIK7CB8kJg5fcVGfMuNdSQfsD2khfoDYqzmpNBaEfihlsRTG0+j
 KkRI62dvVlglijjBakuEOCeKe+H0LAYW5VtINZ5TsA4F7+gvT2mbweeL/uv5AhCPkE
 FYE3WfrwOo1Ew==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hd6pd6Gw7z9rxV;
 Sun,  6 Sep 2026 13:06:49 +0200 (CEST)
Date: Sun, 06 Sep 2026 11:06:53 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Fabiano
 Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-block@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <th.huth+qemu@posteo.eu>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>, Aurelien Jarno
 <aurelien@aurel32.net>, qemu-arm@nongnu.org, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-ppc@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/9] tests/functional: replace HMP with QMP
Message-ID: <20260906130649.6fafc3c4@tpx1>
In-Reply-To: <20260906-nohmp-v1-2-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
 <20260906-nohmp-v1-2-daee96491c43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am Sun, 06 Sep 2026 12:42:33 +0400
schrieb Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>:

> Replace HMP with QMP equivalent.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/functional/arm/test_integratorcp.py | 7 ++-----
>  tests/functional/m68k/test_nextcube.py    | 5 +----
>  tests/functional/mips64el/test_malta.py   | 7 ++-----
>  3 files changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/tests/functional/arm/test_integratorcp.py b/tests/functional=
/arm/test_integratorcp.py
> index 23ae919359d5..fefed26266f4 100755
> --- a/tests/functional/arm/test_integratorcp.py
> +++ b/tests/functional/arm/test_integratorcp.py
> @@ -72,11 +72,8 @@ def test_framebuffer_tux_logo(self):
>          self.boot_integratorcp()
>          framebuffer_ready =3D 'Console: switching to colour frame buffer=
 device'
>          wait_for_console_pattern(self, framebuffer_ready)
> -        self.vm.cmd('human-monitor-command', command_line=3D'stop')
> -        res =3D self.vm.cmd('human-monitor-command',
> -                          command_line=3D'screendump %s' % screendump_pa=
th)
> -        if 'unknown command' in res:
> -            self.skipTest('screendump not available')
> +        self.vm.cmd('stop')
> +        self.vm.cmd('screendump', filename=3Dscreendump_path)

screendump is an optional command - it is only available if CONFIG_PIXMAN
is enabled. That's why there was a check for "unknown command" here.
Does your new code still works if pixman is disabled?

 Thomas

