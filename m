Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6D4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 08:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rweWI-00028D-QQ; Tue, 16 Apr 2024 04:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rweWG-00027o-EW
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:50:24 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rweWE-0002la-Rq
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:50:24 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-436f1a770bdso16561071cf.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713257421; x=1713862221; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73Yh3hPa1KiLWD244acZZC781c8SJzLIzMGIqg2fKRU=;
 b=BhNBDswsHKM5loX5Th8qjj2w2tpRAoM0tvUyTCc2kdBYBR6VZMNExYXZNQCZPXhk4M
 knl7rtiztwaBMdYllRKLvGfM10tpoDERcih2HkB8yEgWOYNWDbsYYSmiukEs5in0/xnY
 sBn39d2BIDnDMbDaDUievMhoFTBNUXlTo5EcHC4K+oMxfP+sOtsSR3WMjwG9RmsabLh6
 AE9py4td7+DYmp4c+bN1G040SQkutWlCK2OvOQSMF80JZPMPoJPiKdGTx3faunK0HuzO
 zNXTT0Hb4XhZ7v/iScA+POQQYc2/amIrnTYZRPH/DpJM5/DQSurm9+MKb5r5sIi0VL/N
 D57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713257421; x=1713862221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73Yh3hPa1KiLWD244acZZC781c8SJzLIzMGIqg2fKRU=;
 b=TBeqmPctFT0p8jLBc4q/EDATuDcEQEcCKWckojkvpZXr2OpxE1N5z0EKE7i0U54XQp
 oEBGCwLl3H831FIli5Aqh4rO+2CeOWSMoKSLboYVtij9X6NTGz71M0MqMP87rJUhCOWt
 lXJUR03JSsYIX/Bbvs7Z0rIMKSLwKAWI7PFSHAmZMRJOVCFkz8LbVMcpZseogyGP+GEk
 z54AjgGu4xvjMPgQTg9UV9tnFsPFPHeMUZ5X1hbPo4t99Yh1KEZpsB2YpGxOfy/A9iSy
 31Hegdc/qEho+YQ5v8SrGODiaJ/rfQlHnIt8U9qXFG1SaHt4HPAWRKJi6FvnpfiomlSJ
 RMeA==
X-Gm-Message-State: AOJu0Yxbg7s4pff35mgokNQbBpk8uGoXpobZGetQkRSAEGEMEAfv2YHF
 bknIRvCV+QBTJC9+TnpAfSB3w2XQHORc2iBUh3mKJcPsQugP45qaztBx90gBWPp1Q+YT5YUcSWk
 no5i8gIRga8u4Bw58awl15l3hjp8=
X-Google-Smtp-Source: AGHT+IEsyWkQfrYHkmpMqT6tyQnC3CdCRXXrBVf8d9R0cDqCGknhpak86YblnAo6dDQxL2bdVAmCaP4nQb10+2dFPcQ=
X-Received: by 2002:ac8:5990:0:b0:434:4b88:2975 with SMTP id
 e16-20020ac85990000000b004344b882975mr3544765qte.1.1713257421228; Tue, 16 Apr
 2024 01:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240415111553.2733357-1-marcandre.lureau@redhat.com>
 <PH8PR11MB68796D6A887ECEA0D22FAA06FA092@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB68796D6A887ECEA0D22FAA06FA092@PH8PR11MB6879.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 16 Apr 2024 12:50:09 +0400
Message-ID: <CAJ+F1CJTYp660EQ7g1rXTszKbuxKCSu5uHz9Oa_8vb8bohbgJQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-gpu: fix import of DMABUF
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dbassey@redhat.com" <dbassey@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

Hi

On Tue, Apr 16, 2024 at 1:00=E2=80=AFAM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> > -----Original Message-----
> > From: marcandre.lureau@redhat.com <marcandre.lureau@redhat.com>
> > Sent: Monday, April 15, 2024 4:16 AM
> > To: qemu-devel@nongnu.org
> > Cc: Kim, Dongwon <dongwon.kim@intel.com>; dbassey@redhat.com; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Michael S. Tsirkin
> > <mst@redhat.com>; Gerd Hoffmann <kraxel@redhat.com>
> > Subject: [PATCH] vhost-user-gpu: fix import of DMABUF
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > When using vhost-user-gpu with GL, qemu -display gtk doesn't show outpu=
t and
> > prints: qemu: eglCreateImageKHR failed
> >
> > Since commit 9ac06df8b ("virtio-gpu-udmabuf: correct naming of QemuDmaB=
uf
> > size properties"), egl_dmabuf_import_texture() uses backing_{width,heig=
ht} for
> > the texture dimension.
> >
> > Fixes: commit 9ac06df8b ("virtio-gpu-udmabuf: correct naming of QemuDma=
Buf
> > size properties")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/display/vhost-user-gpu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c =
index
> > 709c8a02a1..baffb1c2d4 100644
> > --- a/hw/display/vhost-user-gpu.c
> > +++ b/hw/display/vhost-user-gpu.c
> > @@ -273,8 +273,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g,
> > VhostUserGpuMsg *msg)
> >          }
> >          *dmabuf =3D (QemuDmaBuf) {
> >              .fd =3D fd,
> > -            .width =3D m->fd_width,
> > -            .height =3D m->fd_height,
> [Kim, Dongwon]  I think we could just leave .width/.height setting here a=
lthough nothing will go wrong in any cases. Did you have any specific reaso=
n why leaving these uninitialized?
>


Good point. In fact, there are even dedicated fields for width/height.
Fixed in v2.

thanks


--=20
Marc-Andr=C3=A9 Lureau

