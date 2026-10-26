Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47C606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c8K8nFTG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NZC/6XBR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHOO-0002h8-Gt; Mon, 26 Oct 2026 05:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xLHOM-0002gt-VY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xLHOL-0007zC-4t
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793008399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lFsqw8EN+vQzyKbyEmX1FhwZIZ68kFxNL5DZjtuMWYo=;
 b=c8K8nFTGE4JqauGAD5ZYkcsiu+kqAKtWIWZwpaHxtO5rt6Gllq8r61rikJLHg31H1Z41D/
 y897g0ro772n/26TnzxokisPKW6+xphur/sfGrFxAH2G2cO2WyeodDXsxoRvOwA1AA5OQQ
 Cr7yxbLnCE2Es66DpP3htu9v6kj0C9Y=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-8Buu03pPM_m_E83wYkJSXQ-1; Mon, 26 Oct 2026 05:53:17 -0400
X-MC-Unique: 8Buu03pPM_m_E83wYkJSXQ-1
X-Mimecast-MFC-AGG-ID: 8Buu03pPM_m_E83wYkJSXQ_1793008396
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc4216aee8fso3237834a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 02:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793008396; cv=none;
 d=google.com; s=arc-20260327;
 b=hcoPC+J5N5Kb1vGFME29KKf966OAiA3S/8v2p39PdBELpjpdoXq4DvvrJtzPzKNJzN
 enzZfSPG6arW1Ld3IxLDKdZCq09e37rZY8C6+EPu6uAt08WBTAZQAzRpYs/2UxH1yTCg
 Ta/sTjHx6lxZwYo9Dsv+H5HYGKeNkliQM38ij3ouJBIXR2xmaj6rYzMakG51YVMUYgTC
 OyYLb1RbaBnAGFdSapjR/A6guYEm9ULE5ghafug1zL8QlKAQtolSf5CP9sRjwkqM7mio
 D3qcHVyav12O+2NFQWUp6QFKWCPv/35ZjjnMfgrnjyDQbrD7GGzXtTKO3sYr6qvg7yhz
 mqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lFsqw8EN+vQzyKbyEmX1FhwZIZ68kFxNL5DZjtuMWYo=;
 fh=hVASSgkNmitpEdg8v1p79VPmMNKmW0a7Fs1op1MhlO0=;
 b=l74dZQoATePGc0XxFDfvJijfGVR69Cjgo1nKdhm2eunMyVXXS2oq84y7YEA7pDb+5r
 KIMM59umhzH1lkZHzLkUMrFinV6FxlsdoMcRlib1E7K1Ls0bzyQpGtAppxCaXeKzXd0b
 65pHgW75OJkWvF5zKs/BznxOetyxhAk7vMF0zFAPLwblYZkn5qFKQZMMhLYtmyxoKyE4
 nsiayRObcQhJEsJMoTjef3HkQmS5WJAhnwlj4U9wbwYGtXf3dTVyz0CZcYrKYEt3I8Lg
 EUt2LnbOXwcfbtjyI7z2q/l4GSVZqunFKAoQsxHXd3p3qQPZ0r9zXljUUaRbW6/7kx7f
 ibAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793008396; x=1793613196; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lFsqw8EN+vQzyKbyEmX1FhwZIZ68kFxNL5DZjtuMWYo=;
 b=NZC/6XBRp3T0p3sKBy83fF8M3PqSQcWspW0KeGbJ8eBOnRIVcSH+MOUGKloLdGEXHX
 /l9f/JoASweQ27Ox7SnVEzdFumgiIST6DEpRo5OGJ6JQKwx9QGFBU2QUuLOmUHF8AdE/
 VkALJ4A9LxNc78zfk3QfY3vBeXbKMm2j9iKlmLSU+Hyksbp9iQW/waJi8Duey4CZTlYZ
 vUbji85MJxmQCqbS8trn6L5scmHNk8SosEugXgoyV2x4m1cvTRJT63RDQw2nIpdb7ZPQ
 nNxUHV9puTB/AC12XBFbRI1A0B+0OwH/c8AutcCLyKPL7UxhFIcQUYvidZFxMcESpx+p
 XL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008396; x=1793613196;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lFsqw8EN+vQzyKbyEmX1FhwZIZ68kFxNL5DZjtuMWYo=;
 b=JLXXMf8KrsSvAUcSBHEhKTau+RSmSu0/B32h+mRHYdnIgUA6bQMFuejEFDjIBajS/K
 eFkBzM3WHIHKoWVL9L0bKYP6koqZTKt1sWr9fuQVJFHR9WiWY5b1qclHszs+L49vraSp
 eUViVFdEVln85sadU2w8P6E+ekm7YhOtkVUAePyz1uC/YOBvpE4aJV1JD41u3vyMENKs
 fGmav0A+MnpbDwn9qN5XfANn9jqRa8CrlJjXhN+PvXTTTAcDp04+xAJB/gXJYUy443tX
 xcDMX9L7vhtuGHRlfgQzqTFwfXaj7QydSg48lY4OonwBwzy/jKjWP1rkoBHEppzKZbOl
 H8PQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywNDt2qW0zpkOEOOHvH4elwmQ0jyWCi4g13gwFMSvaMEYxlmoqMPhyB2BosOA+pEjX6K27qE1d53UZ@nongnu.org
X-Gm-Message-State: AFq9FYKIao03dmdDSlAijE2elZaOPcVXLRE2OcOjmDNx1l9PZg3l4B/N
 cNL6LL2bNCCur7ZMEy9H6hwe6ESi1Eb1LYPuwMC8DdeWU2yldXy37Pbf3IR3P5a7flQVuw5CgFw
 FbeCuesACD/zqsWkfoF7QFNxsdUV0ygTMK/f+8QnC+uPbcSikUaoEKcLmV0tCpi7cGmUyMNhC8i
 BKJ7V6z+AGfh2mBTLeN9bYLdp0N+TS0/c=
X-Gm-Gg: AYBFou0wT15Y50/dJ4MRokTXu20PAD36xY5dlsW++AMbN8HBI0P7A5gLDUF3f2v5qE8
 5PBKdv0D3LjdHI7iarZJryf3t9X6cpv/6/PqGQAJDfsTYSbwfF4td/Au1c2nWZKp4QeZ2XQpyYV
 ofh59yXlJI5tQVCvkV01BQmUr45YyioKNrr1l2fXbbRV0kR/rVoqeAGLVMVQ==
X-Received: by 2002:a05:6a21:4d91:b0:3e2:3392:5414 with SMTP id
 adf61e73a8af0-3e7bfc0bfccmr4793722637.48.1793008396326; 
 Mon, 26 Oct 2026 02:53:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d91:b0:3e2:3392:5414 with SMTP id
 adf61e73a8af0-3e7bfc0bfccmr4793710637.48.1793008395842; Mon, 26 Oct 2026
 02:53:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023152357.1614817-1-peter.maydell@linaro.org>
 <0d30d085-0c38-41f6-84d8-3473b0635e5d@redhat.com>
In-Reply-To: <0d30d085-0c38-41f6-84d8-3473b0635e5d@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 26 Oct 2026 10:53:04 +0100
X-Gm-Features: AclHuK8xiukV32XVhjQeZ6Umf_1omgzX202kf5qMw3e9BJjhe1FHva2uJmlEjX0
Message-ID: <CAGxU2F5a2dCcYcVyjGdTS5cZ-F4cMW4V8ybZ19PuOCLEWFH1Tw@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: Don't complain about spaces before
 Fixes tags
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 at 09:42, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 10/23/26 17:23, Peter Maydell wrote:
> > The checkpatch.pl script insists that Fixes tags are at the start of
> > each line of its input. Although this is where they ought to be
> > in the commit message, it is not where the script will see them
> > in common usage patterns like
> >
> >    git show <hash> | ./scripts/checkpatch.pl -
>
> ah. I didn't think of that usage ...

For the reference, I hit with `./scripts/checkpatch.pl --branch master..HEA=
D`.

Thanks,
Stefano

>
> > because 'git show' prefaces each line of the commit message body with
> > four spaces.  Allow spaces before the Fixes tag; this matches how we
> > check for e.g.  Signed-off-by: tags.
> >
> > Reported-by: Stefano Garzarella <sgarzare@redhat.com>
> > Fixes: 910e1d41be6b2 ("scripts/checkpatch: validate Fixes: tag format a=
nd commit ancestry")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I just ran into this myself today as well so wrote up the patch
> > ---
> >   scripts/checkpatch.pl | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 5df266acb17..82f62f60212 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1889,7 +1889,7 @@ sub process {
> >
> >                       if ($line !~ /^\s*Fixes:\s+CVE/i) {
> >                               my $tag_case =3D not ($tag eq "Fixes:");
> > -                             my $tag_space =3D not ($line =3D~ /^fixes=
:? [0-9a-f]{5,40}/i);
> > +                             my $tag_space =3D not ($line =3D~ /^\s*fi=
xes:? [0-9a-f]{5,40}/i);
> >                               my $id_length =3D not ($orig_commit =3D~ =
/^[0-9a-f]{12,40}$/);
> >                               my $id_case =3D not ($orig_commit !~ /[A-=
F]/);
> >
>
>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>
> Thank for the fix,
>
> C.
>


