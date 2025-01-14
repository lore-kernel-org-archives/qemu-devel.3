Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C72DC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXiCg-0005Fw-LJ; Tue, 14 Jan 2025 09:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tXiCd-0005Cq-Uf
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:47:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tXiCZ-0004HS-RS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736866048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqAGgIlsEznfDLQDECbfjJ95s1B1od1iZofkix5E5O0=;
 b=KfDecF902pVpSQJ2Z5zKqMW80+95sLf5s4c5L3l1YOTFkQRjU+LjjNeiikDyyz2iCD0wxF
 aIujyEpMtYws2SAVgeEu4KM1bY/hkXgV5RclxrrRypN56dr8a3qLwPT6wODaNhdoj/CRfy
 NFqP1acHacHyr+i98krMTlmGPFiNaGQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-sPrXifftPTSVfnJ_qgtDOg-1; Tue, 14 Jan 2025 09:47:27 -0500
X-MC-Unique: sPrXifftPTSVfnJ_qgtDOg-1
X-Mimecast-MFC-AGG-ID: sPrXifftPTSVfnJ_qgtDOg
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d895f91a7dso91922946d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 06:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736866047; x=1737470847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DqAGgIlsEznfDLQDECbfjJ95s1B1od1iZofkix5E5O0=;
 b=eHbH6DMydqFbpv7wYjicTMROhNl28iRi2ejOG+05h4dsKqCqCtPNLz1qe0V6kKFwhK
 1XMD0n4o7ZbA/wtuvxCzWNSgDl60sB5UAgsd+phwhI7s4TFfK2C/pPXl+osvvYz4VBcr
 C5CVNk6P4ZE8jMy//QHKgHWRM43HDbqrFCfA9ZESk3C3aVF76tgiceEgr4h6R4RvVE/a
 PCkBOZBk4KS7KOUQQ0kJWjYgj8V08Y7npncQYLUur0A4eS+Ok9lz2T3nEj4WYObKG2oA
 r83mtGp8OsLOn/v7u4LiMoC1SnuQO25bscg1EkSeStDY7FLRix5caSYOKRHephr/1Ahy
 uhAQ==
X-Gm-Message-State: AOJu0YyA1y6h7cySx7LlmAqgpKWrzW54uiOFZx/W2ZnnsCfMRC2BQsqn
 Dst2nfCz9Vk1ZjoeA3tXmEDGnMUk9bEcRHHunhR7Q9FdQps5rXYBfR8eT+AxW2EyhvfLMAlU6o8
 vXByiTCTI1TOx7jqlwwoYanaiKpcfqxzWtT7T2+MAEud5/jrgpIy1lsKIX6nDtUQ+wWFvL5UmFO
 AubjjAyur4aKsMHYZ5HO56+Her3bU=
X-Gm-Gg: ASbGncsPVTrFIjs7/q8t3TXA1KicRoeoEezCpdkpgt1CjfkNvYVNM1REMAQY1j21cKR
 tlgd4YSQ19VmFidBist9iouGVl0jKeotUBH/5
X-Received: by 2002:a05:6214:5504:b0:6d4:fff:f9cf with SMTP id
 6a1803df08f44-6df9b282e84mr429495226d6.35.1736866046928; 
 Tue, 14 Jan 2025 06:47:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpr+AzQ2oKzK4b/hX4udP4kAkQZxyH8jIt3SJeS8tGuTYs2wD+PUhkxdUnkbB0i2xeMrHIFRuCAkDCYs3T9Vg=
X-Received: by 2002:a05:6214:5504:b0:6d4:fff:f9cf with SMTP id
 6a1803df08f44-6df9b282e84mr429494976d6.35.1736866046650; Tue, 14 Jan 2025
 06:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20250114104811.2612846-1-marcandre.lureau@redhat.com>
 <87zfjtfoej.fsf@suse.de>
In-Reply-To: <87zfjtfoej.fsf@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 14 Jan 2025 18:47:15 +0400
X-Gm-Features: AbW1kvbQLJTU-rWYndtb4rwsiwnC8mncAjAuKRutJ26zmNLzQLEREZI3OWlEsSQ
Message-ID: <CAMxuvaw3Ja1W=U0GFVCZ0-P4U5fqtmzkwNNCe30nTy5W7STchQ@mail.gmail.com>
Subject: Re: [PATCH] migration: fix -Werror=maybe-uninitialized
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 "Henderson, Richard" <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi

On Tue, Jan 14, 2025 at 6:42=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > ../migration/savevm.c: In function =E2=80=98qemu_savevm_state_complete_=
precopy_non_iterable=E2=80=99:
> > ../migration/savevm.c:1560:20: error: =E2=80=98ret=E2=80=99 may be used=
 uninitialized [-Werror=3Dmaybe-uninitialized]
> >  1560 |             return ret;
> >       |                    ^~~
>
> Weird that this didn't show up anywhere.

I have a build setup with '--enable-debug' '--enable-asan'
'-Doptimization=3Dg' '-Ddebug=3Dtrue' for development.

Unfortunately, devs and CI don't seem to run with those flags, we
should probably add it back to CI (apparently partially dropped with
commit cb771ac1). There are regressions to clean up nowadays. Help
welcome!

>
> >
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>
> > ---
> >  migration/savevm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index c929da1ca5..6e56d4cf1d 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1557,7 +1557,7 @@ int qemu_savevm_state_complete_precopy_non_iterab=
le(QEMUFile *f,
> >              migrate_set_error(ms, local_err);
> >              error_report_err(local_err);
> >              qemu_file_set_error(f, -EFAULT);
> > -            return ret;
> > +            return -1;
> >          }
> >      }
> >      if (!in_postcopy) {
>


