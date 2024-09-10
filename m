Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71CBEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 03:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snrqH-0006X4-Kh; Mon, 09 Sep 2024 23:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1snrqF-0006Vs-PX
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 23:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1snrqE-0005Kz-7K
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 23:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725940015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZFkwB9FfOnv6jV0ceFswbbC0Xt7iB+XqhbcSjYRR7U=;
 b=escTl6xFdj5ZRjJZAoEa88EOyVHMx+pFlIchXK3aY4o6Nfk+T/I/wHV4gkZ8NlmtAFW2NL
 gzFh+sMtbnfGFdAvVAL05//rxt/+yvC7hm1HyIZgW54QptGukYczM73lA6r8dCDzdg9UXJ
 eLQnzf/8Xi3Fex8/XqIniDPsCbgC94s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-bweVaKm4O4eK3LntShkJYQ-1; Mon, 09 Sep 2024 23:46:54 -0400
X-MC-Unique: bweVaKm4O4eK3LntShkJYQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d8859d6e9dso237545a91.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 20:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725940013; x=1726544813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZFkwB9FfOnv6jV0ceFswbbC0Xt7iB+XqhbcSjYRR7U=;
 b=Q2Ue0dQrRfc588RRU53NY3IUmvuyYw7QdG/F3YEkAI8djvvovPJ1bzgKZHPl9/QuWd
 l6jit+OpSFDdZM7g4ro1ZsYnyquCpAp6I9b5GV9g4lgzRYY7N6C7DaeVp72+4To4p6oh
 4Uo58QwB0nCrep+uEvlbIQL2AFMKhTyoQXAsyUeL8pneoLIwaR/SVJryVDxuONLH7/YY
 sMnxKSnUU3ZonWiOub3QZTxVk3zK8CcLZuudeRzRsIFKmr+4T3ys793kzD0RCcg/R/M1
 eZjSAv6Mx6l0q1P2QLXGAGJjDm7sA1V9xSY26fXk1c4kO/If7DSuSHfHKMb96fDHgBy6
 jhtw==
X-Gm-Message-State: AOJu0YynBW2HM3EXaFmSd3mcPfUAgK+0+nFtTanGm7ks4GKbzhi7hIZz
 QP7ji3WMu8jjqa7TUYOOEWydCSONfbVOEV/Z7FQVcT829iYQTntM93VAGWzwFTBgisuYKaeb4Ub
 l+oLTg+dOLW3AZy5Y1yySjoB7SJ6RUGb3Zpk/pxEyA3neVPwHTAGo+lcBmOD/ZsjGAuZSi0i+XY
 KmmPnPl/ri6+/eyyh4G+H1M+A3zng=
X-Received: by 2002:a17:90b:4b02:b0:2d8:a373:481e with SMTP id
 98e67ed59e1d1-2dad505ba8cmr12966893a91.24.1725940013188; 
 Mon, 09 Sep 2024 20:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrBZhHnKaIt0C3G3myNDeLfOm6pOkDfOBr3kMsSwKdYm1aNfosBgGq3T7VSXS3+Ma9MGGuTwTDdGAJZ6dZ/mU=
X-Received: by 2002:a17:90b:4b02:b0:2d8:a373:481e with SMTP id
 98e67ed59e1d1-2dad505ba8cmr12966866a91.24.1725940012619; Mon, 09 Sep 2024
 20:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240129132407.1474202-1-eperezma@redhat.com>
 <CACGkMEvXNSkMy=WAv-Eiy4M_7kmqJFkv7RgDwqrgry_O2eT2hA@mail.gmail.com>
 <1559bdcb-315e-4411-a996-89c6be430d4f@oracle.com>
In-Reply-To: <1559bdcb-315e-4411-a996-89c6be430d4f@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Sep 2024 11:46:41 +0800
Message-ID: <CACGkMEveP-MMN0qGRZEL_VwtJeA+9qiYq_5X9CsOpzTsCLNEuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Move net backend cleanup to NIC cleanup
To: Si-Wei Liu <si-wei.liu@oracle.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 yajunw@nvidia.com, Ani Sinha <anisinha@redhat.com>, dtatulea@nvidia.com, 
 mcoqueli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10, 2024 at 11:41=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
> Hi Jason,
>
> It seems this series wasn't applied successfully, I still cannot see it
> from the latest tree. Any idea?

It breaks make check.

Eugenio, would you want to fix and resend the series?

Thanks

>
> In any case the fix LGTM.
>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
> Thanks,
> -Siwei
>
> On 1/31/2024 9:43 PM, Jason Wang wrote:
> > On Mon, Jan 29, 2024 at 9:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> >> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> >> structures if peer nic is present") effectively delayed the backend
> >> cleanup, allowing the frontend or the guest to access it resources as
> >> long as the frontend NIC is still visible to the guest.
> >>
> >> However it does not clean up the resources until the qemu process is
> >> over.  This causes an effective leak if the device is deleted with
> >> device_del, as there is no way to close the vdpa device.  This makes
> >> impossible to re-add that device to this or other QEMU instances until
> >> the first instance of QEMU is finished.
> >>
> >> Move the cleanup from qemu_cleanup to the NIC deletion.
> >>
> >> Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net stru=
ctures if peer nic is present")
> >> Acked-by: Jason Wang <jasowang@redhat.com>
> >> Reported-by: Lei Yang <leiyang@redhat.com>
> >> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>
> >> Eugenio P=C3=A9rez (2):
> >>    net: parameterize the removing client from nc list
> >>    net: move backend cleanup to NIC cleanup
> >>
> >>   net/net.c        | 30 ++++++++++++++++++++----------
> >>   net/vhost-vdpa.c |  8 --------
> >>   2 files changed, 20 insertions(+), 18 deletions(-)
> >>
> >> --
> > Queued.
> >
> > Thanks
> >
>


