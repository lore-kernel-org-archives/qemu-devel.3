Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8234CC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 20:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIDGe-0007kJ-Lb; Fri, 14 Jun 2024 16:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trentmhuber@gmail.com>)
 id 1sIDGd-0007jo-Ch; Fri, 14 Jun 2024 16:11:23 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trentmhuber@gmail.com>)
 id 1sIDGb-0008In-HG; Fri, 14 Jun 2024 16:11:23 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4ee282a4fbfso47436e0c.0; 
 Fri, 14 Jun 2024 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718395880; x=1719000680; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oQJFnirZVYqSW44JTug1VwwUs8LLBBR2L468hP+eYk=;
 b=Lo7rwUsXkgLl4hEpSJ1Vx3sRmyVsyKv86hELHNf6oK7k/ZOzv+abOJBrhQWQYwWPux
 g+RXJ1xqrO4PBJhFIzxppyx2ngbbonuy1PpLmAGhvJ7sfvbIdiZU4QxHDQSv3W7K3Bdl
 bnNfKKfDn2CkhWq7GyitOAvcnOL/Kk87NdpH1JwnCNq+h/4LBsidwUnlyy3yJP2Sl9O8
 8E6Qx9QxaIyvI1KQ6IML3NzI1oU5yxZrjcM3aMyvrnBjHibNVwQdb2VjbCauptCL8Lkt
 Hs/okzro90vQzGSBtiU5IL28qp3qZPte9boWdBd0Kz2p9AMZIXi4+/M1BHjazJbaXLH4
 j9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718395880; x=1719000680;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6oQJFnirZVYqSW44JTug1VwwUs8LLBBR2L468hP+eYk=;
 b=YwGL8Quk3/5PilFksldex0GhY/7iWZchGXPmY1FyGWt3bTuy4fVV3llgDtOEJj0fEE
 t0r5DeFer8ReXVSm84+BJUMjVFjKMqdwz1lpQaFsH2KkfjEUHJ1Ko+rOYsN2NLYgaY5k
 +GLm9lRoYq/VZJ/OM/kCM8vJW4ZOOtm9a5pnorsOcklC09T0NtkGDsQz9AuRGi2L6xXs
 Qwb7D0Ul3nWWuj1VPymus4ub794rO1TDFsrlh4E/dGoIcP4JaE4jEx2ELUT6Gfwwin3k
 bx6FWIp4WfJtX/TltqTHCwZbXUNVtZ96iz9L1+Un/BqvRcnbBbbVhwhVQ7LeJvLh3Gkh
 2TBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvMxpGmVvbwox10WAgYLa7WxyYyynD63QhR3wXMUDKHdZNDCS9l2DTjJI5y9uvne7zZnJ5txT4ztju90KD0jCWcWgs3uA5Vw==
X-Gm-Message-State: AOJu0YxmNYjDSIqpftkRkIf03JSi5lhYTvSLufp04ewJfZysqd4PP0a/
 iNKvw/E4BNgW2RNH0R2gSzf8ayL7JOR+6ENCa/1Mkg/JF2s0Ky1myeO1pTVbeW0=
X-Google-Smtp-Source: AGHT+IEm6kwvRSrBg+pEMG3cUM9CuKzrAV65lCJgWmEPRUVAN1JK9sDwNWys8NyO/s+9abiP9jI/QA==
X-Received: by 2002:a05:6122:2642:b0:4eb:2012:f5ed with SMTP id
 71dfb90a1353d-4ee404322d9mr4239326e0c.1.1718395878282; 
 Fri, 14 Jun 2024 13:11:18 -0700 (PDT)
Received: from [192.168.1.19] (pool-96-227-82-228.phlapa.fios.verizon.net.
 [96.227.82.228]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798aacb1ebcsm177190085a.8.2024.06.14.13.11.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2024 13:11:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH] os-posix: Expand setrlimit() syscall compatibility
From: Trent Huber <trentmhuber@gmail.com>
In-Reply-To: <ZmxF2lTY0hvS_HqV@redhat.com>
Date: Fri, 14 Jun 2024 16:11:17 -0400
Cc: qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,
 pbonzini@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A91E989D-E646-4258-B080-67C9A29CBE80@gmail.com>
References: <20240614051422.13532-1-trentmhuber@gmail.com>
 <ZmxF2lTY0hvS_HqV@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=trentmhuber@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> On Jun 14, 2024, at 9:30 AM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Fri, Jun 14, 2024 at 01:14:22AM -0400, Trent Huber wrote:
>> Darwin (I'm running version 19.6.0) uses a subtly different version
>> of the setrlimit() syscall as described in the COMPATIBILITY section
>> of the macOS man page. I adjusted the way the rlim_cur member is set
>> to accommodate and which shouldn't affect any non-Darwin systems.
>>=20
>> Signed-off-by: Trent Huber <trentmhuber@gmail.com>
>> ---
>> os-posix.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/os-posix.c b/os-posix.c
>> index a4284e2c07..5766346521 100644
>> --- a/os-posix.c
>> +++ b/os-posix.c
>> @@ -270,7 +270,7 @@ void os_setup_limits(void)
>>         return;
>>     }
>>=20
>> -    nofile.rlim_cur =3D nofile.rlim_max;
>> +    nofile.rlim_cur =3D OPEN_MAX < nofile.rlim_max ? OPEN_MAX : =
nofile.rlim_max;
>=20
> There's no such constant OPEN_MAX on Linux, so this doesn't compile.
>=20
> There is a sysconf() parameter _SC_OPEN_MAX, but we should not use
> that as it is a dynamic value that just reflects what 'rlim_cur'
> is set to, and would thus turn this into a no-op.
>=20
> This should just be made conditional to macOS, since its the only
> problematic platform that we known of.
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|

Thanks for looking this over, I'll add some conditionals and send a v2 =
of the patch.

Kindly,
Trent


