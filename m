Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2B2CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVs3-0004v3-2u; Wed, 10 Apr 2024 07:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVry-0004ur-5M
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:11:58 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVrw-0000bo-2F
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:11:57 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56c404da0ebso9773751a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712747514; x=1713352314; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bne216KvbRGOdDDZ6zCMMcUDZ+DucEkPd+/ueG20gE8=;
 b=T2CiEPGPMAuwTdXKTrCcZHuHZ8PyELXnlZXR6cECir8pQ4eBE+rqmIt5ko45oeY6LR
 +FIXfQoSFh90EJJ0lEC971Y+J6lMG6IVA/EUR62klQocpV4bDg/K3cfp4HAmcbXSzhkd
 L15aBqS2VEuib4FKBbCkyfr/WWxsJH2VSD18DMKQ3/KEKHY0yTbZNu3G3Wdl3V3EP+73
 QCZYP5FElVPs7yK5Ns16FaJkjwDFK+PimFfPaJp879n6Vy5QFmg4IBTFtUrCQ1sZaxJ+
 YgNYtSQO+Pfdm94+A9pXH/Gvaa2vhw8xOmpOqykLIrdAYwBiNcm+RB6IeFPjHKPAPcit
 ZZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712747514; x=1713352314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bne216KvbRGOdDDZ6zCMMcUDZ+DucEkPd+/ueG20gE8=;
 b=r1RxBoGmr0sP3CTvcoWO2619GhIAkr/TcElgIaFWqIonJpFUivFjWh4wHB+fvyIMJ9
 RKtna5sXEd1OWPuOi1Fby/Xe5CYEMTX+yHtuQGgME78o3MWt1i35y2ZZykg9V4lGgJvN
 PKX1J9sU9n5IvN5jR+Whwx7CSm6QLSdIq2WZrChevvuT01uxubmmeyr5xCs5W6x5JPh3
 vfE9zcex8tFmFmPxu7oWX3KGm74glIrMjD22HZJAPodraRS7aFWX0ciRC3DMas2HE188
 yJKaVEj7pxKIig0MthnzUo7/ZxhQZt+qFWL4BToGf7mA1eWZB6IWNeKycxEzv9vqq8ba
 Z5Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeFZqV+vy74iEhiVDjTDJxVD2uJok0gxhPlJlqxAUTVJlrZEgKRfHm5uYbtKeFgXcPvCKJAXFBp3A4tRLfCiaTTm251R4=
X-Gm-Message-State: AOJu0YwakUXT+4IEVeW2JZSopj8ACEaSFYq5fEFrA+ATOHAuX/7Rj6lj
 yoXs/J9aSE6XzypcfFRFi5ljtPd0HBLrW0eQWXKQSY1VbhpgjVPQ/uJjC46iC8JjacKm5wl6+Jc
 C5vtnpbxIfIl4jmC3Ph5TRvZVXTM=
X-Google-Smtp-Source: AGHT+IG5dbz3lz/dWNLr/AQRR3ivAeMkFvzTbCxh3cKrC759lTqXHPW1TDEExfmNgU8/cwX5iC2IsSAeVTKWqc4BhKk=
X-Received: by 2002:a50:99da:0:b0:56e:2b1c:d013 with SMTP id
 n26-20020a5099da000000b0056e2b1cd013mr1785719edb.21.1712747514144; Wed, 10
 Apr 2024 04:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-7-vikram.garhwal@amd.com>
 <alpine.DEB.2.22.394.2402291510080.853156@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2402291510080.853156@ubuntu-linux-20-04-desktop>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 10 Apr 2024 13:11:42 +0200
Message-ID: <CAJy5ezo2f8gxZ+Lfx3aXg7Oqx-1SMBTN-sU6-oZotUu3ARA3cg@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 6/7] xen: add map and unmap callbacks for grant
 region
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org,
 jgross@suse.com, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: multipart/alternative; boundary="0000000000002bac5a0615bc1b0f"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002bac5a0615bc1b0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:34=E2=80=AFAM Stefano Stabellini <sstabellini@ker=
nel.org>
wrote:

> On Tue, 27 Feb 2024, Vikram Garhwal wrote:
> > From: Juergen Gross <jgross@suse.com>
> >
> > Add the callbacks for mapping/unmapping guest memory via grants to the
> > special grant memory region.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>
>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

--0000000000002bac5a0615bc1b0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 1, 2024 at 12:34=E2=80=AFAM S=
tefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.org">sstabellini=
@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, 27 Feb 2024, Vikram Garhwal wrote:<br>
&gt; From: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" target=3D"_=
blank">jgross@suse.com</a>&gt;<br>
&gt; <br>
&gt; Add the callbacks for mapping/unmapping guest memory via grants to the=
<br>
&gt; special grant memory region.<br>
&gt; <br>
&gt; Signed-off-by: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" ta=
rget=3D"_blank">jgross@suse.com</a>&gt;<br>
&gt; Signed-off-by: Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd=
.com" target=3D"_blank">vikram.garhwal@amd.com</a>&gt;<br>
<br>
Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.or=
g" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
<br></blockquote><div><br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a =
href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</a>&gt;<br></=
div><div><br></div></div></div>

--0000000000002bac5a0615bc1b0f--

