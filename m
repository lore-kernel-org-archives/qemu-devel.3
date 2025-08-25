Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED584CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWhh-0007Oo-Av; Mon, 25 Aug 2025 08:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1uqWhQ-0007I5-M5
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:53:25 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1uqWhH-0005vH-R9
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:53:24 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-70d9eb2e96fso27431496d6.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756126390; x=1756731190; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=xzN5UM6Mcl1zDdSUky1UO1OvJmu1AZQv+xzg0DhxbbA=;
 b=ik8Elngdbg3fZFqy2Q3LOxbxrf4Lb20Nr/hcnQ9GOxHxbZmkLYZquk8I2H+KdJ7ET9
 Hh3aHM8+ZGd9F8DNDEMCgDpLDgj2pPAjGGU+F8uye5RU1GTYV3V3Dvd9BR7vvfuv72KW
 4AkGkZ6EO1rkqMVCowEs6/ljTkdI0a5RIKMHRCUwMl1fY4WsTYxLjTOv90FB0n5cIbM7
 2hWtbufgQPw4l/HQczVdeUuyv3+I1q4xQ+Ch0vQgOPH2kGq84rTAi5L/wEltF1Dk9zUQ
 9E90T02PROB3ZJzCAejHIYq/l+d4kVyg/wSv693q3RhfxrcNigwnMAQLPxklv2Xcfr+r
 GVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756126390; x=1756731190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xzN5UM6Mcl1zDdSUky1UO1OvJmu1AZQv+xzg0DhxbbA=;
 b=KVVzB+qgVtJ+Mvst7aeBKWP7ZxVL7+5TgywnE2/zn4R/rVcIUFivfDMHwezqj3ee3k
 jIFXZ1RwKIpzFU0hXT9Vnm0fZWdoVulWF7dlSIJPLgPURINO/kUK0q1CA6zAGGZDZVZC
 VIEaQHXIhwo6GsusZkmHbsJUUz+Gtv4X+xlc8lwFRhsHFn5k/T8MaQHvx9xd2+nraSu9
 ROLQ1v4IBfpf3DoSUqIDVB8IBuRvABwnyavNqnvjOEuy4Sr7U9FcmnxQVAeQ5FMDzHs3
 E2Pz1j0k8vKE9GDcBb7Lm+n+Kk4+x7An4Pk0gFxkhZkRTmFVMwOLopevjL3fjquADvJT
 lrKQ==
X-Gm-Message-State: AOJu0YyRC7l2NM6p3TWm37BsSKtm6NgGL0BEawfHKs/eyd7TiYHiMljw
 9ZSjMadgGvBnOf/TKiYQ9S9OgG5IWszwFzFQR/8ab9ZiDWlVssnGwVqs
X-Gm-Gg: ASbGncslYmDvngc7PHYc828xN1Shvcx1O/gmg0RxBVw2FsR6vT/W8W5RUkivclIgXhA
 +kmjLKtRsDv5fQ+M9ZGB2CSPSCiQFGeqWthuk8CCaoS7QMKgy7C7blObnpGgXnEUy8j6n246KC6
 PESiP6OGwjURc3Cusb5n3j89FWtm7Ls9KoT4/h799/sS1cd42LdiNhYB2iA+EhmYMDHOgQftKkd
 XBVAx5sLaBDwfj2Q6VXAlq+uyD3zFf5zmTZ0T5UN1ALA77BXSLV/XPMgB1cCAcQAtKnXExpmicF
 Soeb9MGrKtMFegCcRQqAUm/4mYcCvgjDui0K+jPmGRf9cJaEcLPNY0f36c/7p+9pxnjekcuy0Up
 ysmz6G1fKOj09vrZqasgms4WO1P8v4DAzNpLe
X-Google-Smtp-Source: AGHT+IEQNfL5wThRSYb+EGsaChTMTEREvdXhGUQkO78SKl1PWZSLOY8Uqt4tFL1m5qeO6k+nVNRmeg==
X-Received: by 2002:a05:6214:407:b0:70b:c8ae:1849 with SMTP id
 6a1803df08f44-70d983dc528mr115013196d6.27.1756126389608; 
 Mon, 25 Aug 2025 05:53:09 -0700 (PDT)
Received: from nuc (192-0-220-237.cpe.teksavvy.com. [192.0.220.237])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70dc949bcc6sm2526976d6.8.2025.08.25.05.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 05:53:08 -0700 (PDT)
Date: Mon, 25 Aug 2025 08:53:06 -0400
From: Mark Johnston <markj@freebsd.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] 9pfs: Add FreeBSD support
Message-ID: <aKxcsmP6MI5p9OPe@nuc>
References: <aJOWhHB2p-fbueAm@nuc>
 <2602995.s6eulQLtdm@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2602995.s6eulQLtdm@silver>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=markjdb@gmail.com; helo=mail-qv1-xf35.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 21, 2025 at 01:24:04PM +0200, Christian Schoenebeck wrote:
> On Wednesday, August 6, 2025 7:53:08 PM CEST Mark Johnston wrote:
> > This is largely derived from existing Darwin support.  FreeBSD
> > apparently has better support for *at() system calls so doesn't require
> > workarounds for a missing mknodat().  The implementation has a couple of
> > warts however:
> > - The extattr(2) system calls don't support anything akin to
> >   XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
> > - Attribute names cannot begin with "user." on ZFS, so the prefix is
> >   trimmed off.  FreeBSD's extattr system calls sport an extra
> >   "namespace" identifier, and attributes created by the 9pfs backend
> >   live in the universal user namespace, so this seems innocent enough.
> > 
> > The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
> > filesystems.
> > 
> > Signed-off-by: Mark Johnston <markj@FreeBSD.org>
> > ---
> > Changes since v1:
> > - Handle extended attributes in the system.* namespace as well.
> > - Fix a typo in a comment.
> > - Clarify a comment.
> 
> Not forgotten. I just hoped there were other reviewers or testers in the 
> meantime, but be it.
> 
> Like I said, I don't have FreeBSD system here to test this, so I am taking 
> your word for now that you tested this and plan to bring this into QEMU when 
> master re-opens for new features soon.

Thank you very much!

In case I missed somewhat, what testing would you typically do
otherwise?  So far I had run the QEMU test suite (which indeed found
some bugs in the initial version) and tried mounting a 9pfs share from
Linux and FreeBSD guests and doing a bit of manual testing.

> If you have some time to adjust the commit log message above, that would be 
> great, otherwise I can also handle this on my end later on. Looks like that 
> comment is not adjusted for v2 yet (i.e. "user." and not mentioning 
> "system.").

Here's an amended commit log message.  Please let me know if this is
better submitted as a v3.

commit b79bf1b7d42025e3e14da86a7c08d269038cd3ed
Author: Mark Johnston <markj@FreeBSD.org>
Date:   Wed Jul 16 20:32:05 2025 +0000

    9pfs: Add FreeBSD support
    
    This is largely derived from existing Darwin support.  FreeBSD
    apparently has better support for *at() system calls so doesn't require
    workarounds for a missing mknodat().  The implementation has a couple of
    warts however:
    - The extattr(2) system calls don't support anything akin to
      XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
    - Attribute names cannot begin with "user." or "system." on ZFS, so
      these prefixes are trimmed off.  FreeBSD's extattr system calls sport
      an extra "namespace" identifier, and attributes created by the 9pfs
      backend live in the universal user and system namespaces, so this
      seems innocent enough.
    
    The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
    filesystems.
    
    Signed-off-by: Mark Johnston <markj@FreeBSD.org>

