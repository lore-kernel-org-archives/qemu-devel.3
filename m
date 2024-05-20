Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA92C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 16:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s96KJ-0005Tq-68; Mon, 20 May 2024 12:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1s96KH-0005TL-Jd
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1s96KF-0002rr-R5
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716224245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7F+OifLrdxTjBey0rpbUa68rG0iBXlmAv6iK/eSxYs8=;
 b=XtGy0e7SuR/6ootmTGxEE0Aua1isiQyaZV5b3zprII0V/FZ4VjgA1PdNyHO+nT8eQBxY55
 8rDoCGks15LadE9pOO3yHdVzUdTZquxqePRvgooED38Uk/I0ZCiSYC4sOL5AueNl3gDeR7
 QN2lNBgKU6l5yT5a+SZpEq9YxYZ1sN0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-UMN8_JQbOUKiJAQGXIxNGA-1; Mon, 20 May 2024 12:57:23 -0400
X-MC-Unique: UMN8_JQbOUKiJAQGXIxNGA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43e0a85a3ebso116238561cf.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 09:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716224243; x=1716829043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7F+OifLrdxTjBey0rpbUa68rG0iBXlmAv6iK/eSxYs8=;
 b=VrV+2VCYjFc9KVqZ5RCErlYiDvkxc3YfV6pfhaH2w3/mc0IFdgi4J7+Uu4mqKSle/Y
 NFml8H0+3YITatcTctl/CUkgN+BGkgUx6x8ql47UECiP2GT71bXDB4orQaWxcrqE/Haw
 iZ9GncC0Qu8Rl76CrPgeRTxlOzEGgeMji7ycY9Xk6qMi2UYBhLzuQXxNmGQsKBhnp8My
 WCKUAlNJD4M6ZSRUyqPUki1GnDMRsRRUfz2+1ng4RLJSZ979GzsjzqjuBdnO+KHrQlg7
 /UCoAjM4hi0SLfcBhSaAW9q07AdRT7FH8ggOFnYlJFoTcAX4ehmg7WudONxV5qecZKGz
 70Ng==
X-Gm-Message-State: AOJu0Yx+ap5Tx06EGEGEOpZU/61c2YOsEgdGbfDDNy9cQPtiq8n+qy2K
 VB9D2KQcfqeHSweLp3yZmK0qumo+gpPl1j/6I/ecwh6oZsekrXw1GB0+CeoL513VE7OBEGC+iW+
 40PtqCpEsTzv4iBIbCZ2ZkQYcmo2n4YreSZkzv0EljPDjJ6n61oTqkQH0IbRIjFvGI+Bzm779KG
 j+Pk6vepw90M8RBsHZTnMLnbHsrUU=
X-Received: by 2002:ac8:59d6:0:b0:43b:18b7:5584 with SMTP id
 d75a77b69052e-43dfdb20f5bmr390320311cf.8.1716224242789; 
 Mon, 20 May 2024 09:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV6O0aYWcFmjQ2P8Se0JDjpTq7qGclUyur99ROYXf2keoFaXYZDxBY7k+bFGyXOJ6gR0Ktd6Oimhersw2wYO0=
X-Received: by 2002:ac8:59d6:0:b0:43b:18b7:5584 with SMTP id
 d75a77b69052e-43dfdb20f5bmr390320061cf.8.1716224242424; Mon, 20 May 2024
 09:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240516165410.28800-3-cconte@redhat.com>
 <ZkZPRILIqoyGbdEk@redhat.com> <ZkcR4_cQzl-LjcjC@redhat.com>
In-Reply-To: <ZkcR4_cQzl-LjcjC@redhat.com>
From: Camilla Conte <cconte@redhat.com>
Date: Mon, 20 May 2024 17:56:46 +0100
Message-ID: <CACPOWh0ZLNMtkPT6Q9KJPGwVzqGxoE+n=gZ=d6_3Ke6Ndtya5Q@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci: Replace Docker with Kaniko
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 17, 2024 at 9:14=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, May 16, 2024 at 07:24:04PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, May 16, 2024 at 05:52:43PM +0100, Camilla Conte wrote:
> > > Enables caching from the qemu-project repository.
> > >
> > > Uses a dedicated "$NAME-cache" tag for caching, to address limitation=
s.
> > > See issue "when using --cache=3Dtrue, kaniko fail to push cache layer=
 [...]":
> > > https://github.com/GoogleContainerTools/kaniko/issues/1459
> >
> > After investigating, this is a result of a different design approach
> > for caching in kaniko.
> >
> > In docker, it can leverage any existing image as a cache source,
> > reusing individual layers that were present. IOW, there's no
> > difference between a cache and a final image, they're one and the
> > same thing
> >
> > In kaniko, the cache is a distinct object type. IIUC, it is not
> > populated with the individual layers, instead it has a custom
> > format for storing the cached content. Therefore the concept of
> > storing the cache at the same location as the final image, is
> > completely inappropriate - you can't store two completely different
> > kinds of content at the same place.
> >
> > That is also why you can't just "git pull" the fetch the cache
> > image(s) beforehand, and also why it doesn't look like you can
> > use multiple cache sources with kaniko.
> >
> > None of this is inherantly a bad thing..... except when it comes
> > to data storage. By using Kaniko we would, at minimum, doubling
> > the amount of data storage we consume in the gitlab registry.
>
> Double is actually just the initial case. The cache is storing layers
> using docker tags, whose name appears based on a hash of the "RUN"
> command.
>
> IOW, the first time we build a container we have double the usage.
> When a dockerfile is updated changing a 'RUN' command, we now have
> triple the storage usage for cache. Update the RUN command again,
> and we now have quadruple the storage. etc.
>
> Kaniko does not appear to purge cache entries itself, and will rely
> on something else to do the cache purging.
>
> GitLab has support for purging old docker tags, but I'm not an
> admin on the QEMU project namespace, so can't tell if it can be
> enabled or not ? Many older projects have this permanently disabled
> due to historical compat issues in gitlab after they introduced the
> feature.

I'm pretty sure purging can be enabled. Gitlab itself proposes this
with a "set up cleanup" link on the registry page (1).
Can you recall what issues they were experiencing?

If this is the only issue blocking Kaniko adoption, and we can't solve
it by enabling the cleanup, I can write an additional step at the end
of the container build to explicitly remove old cache tags.

(1) https://gitlab.com/qemu-project/qemu/container_registry

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


