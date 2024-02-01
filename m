Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4A1C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 05:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVPrZ-0004Be-B6; Thu, 01 Feb 2024 00:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rVPrX-0004BF-6r
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:43:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rVPrV-0005mp-KN
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706766223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJpJi1+UiDSN9viHr2MAK6EEpE/xKn8U60ndryd1v9c=;
 b=WQi2lkVq1URJ1KlC8zSaBEd9geYndS347Jr5qNt9V864f61ExVXR+sk84x03C2lnvtO5Na
 qhuYZFfwOP16JCGwAoNgNUH3hNeRRWswTZA5KDiVFPXUkrMgvmx5xcfLaqx8hcrC+vKCqI
 2qgu7tmR5jAFcDOK56j5uat+E+oMEMU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-82uNIZuEN2iTONoiFi61zg-1; Thu, 01 Feb 2024 00:43:42 -0500
X-MC-Unique: 82uNIZuEN2iTONoiFi61zg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-59907104d88so652108eaf.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 21:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706766222; x=1707371022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJpJi1+UiDSN9viHr2MAK6EEpE/xKn8U60ndryd1v9c=;
 b=Ecfp4U6EmYrq9VqZ3HzOtMVq8Y/YNR3mwkPlU5rv3f4nhymj7YUX0U6vZJbTzKYXDH
 cT6l7lA6U3u6zGSLzp5Me3PAFvHvAKzQWMbr95JoaWIGvgiVTOdjMtRMvSS8Dg22Ond7
 Zm0wLPXW8LzAS6sS2/AqInTCOvwpHrs33JauM/7+6v8L6sqoigTJ7bvo52AJOCJQvVJB
 e2GiXMb1eKGaxy9GSTfwhoSnqB9tSIl/VbNahUJdsAe4lPXZJL6rn4bly1msRrG6q7f6
 Jtq/BDUBxnZTQbeq71hyfsRzZ4+HNKIfWLlnOXmkzUnO6q/jUD3Ab9atk1Hh8pYdibSv
 nOjQ==
X-Gm-Message-State: AOJu0YyB5NIk8KZlPuJQx7qDXAE8yupKDDFIldFc3y61iIXWNHUEuPCo
 kNXbBJucbsTuSYG5N2nl+++bCWJ49wAoVlf9g5MFV9ASJiNTCNmBbJFZi+tnj6ki/NB4u8bIkLW
 jvfz9RX+oZvyM/burznQhPwmohE/483V1V8Q83c6yTzXyBhOzSQUfbe6cZ/wLR6MX7CBuslNWnc
 D8YyiN0cyJQzfhxv9lFu/BlCxIM1Y=
X-Received: by 2002:a05:6358:7e83:b0:176:d1ed:aedf with SMTP id
 o3-20020a0563587e8300b00176d1edaedfmr3305453rwn.0.1706766221875; 
 Wed, 31 Jan 2024 21:43:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrqZCUrZr2avc3zOwCF2uHMm4T25CrpnE0+49Hr/LAZcNJGf4Vczh7AXzN13H1WqpzRwQyTpcIu7sCWwcyBlM=
X-Received: by 2002:a05:6358:7e83:b0:176:d1ed:aedf with SMTP id
 o3-20020a0563587e8300b00176d1edaedfmr3305448rwn.0.1706766221600; Wed, 31 Jan
 2024 21:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20240129132407.1474202-1-eperezma@redhat.com>
In-Reply-To: <20240129132407.1474202-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 13:43:30 +0800
Message-ID: <CACGkMEvXNSkMy=WAv-Eiy4M_7kmqJFkv7RgDwqrgry_O2eT2hA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Move net backend cleanup to NIC cleanup
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, si-wei.liu@oracle.com, 
 leiyang@redhat.com, yajunw@nvidia.com, Ani Sinha <anisinha@redhat.com>, 
 dtatulea@nvidia.com, mcoqueli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 29, 2024 at 9:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> structures if peer nic is present") effectively delayed the backend
> cleanup, allowing the frontend or the guest to access it resources as
> long as the frontend NIC is still visible to the guest.
>
> However it does not clean up the resources until the qemu process is
> over.  This causes an effective leak if the device is deleted with
> device_del, as there is no way to close the vdpa device.  This makes
> impossible to re-add that device to this or other QEMU instances until
> the first instance of QEMU is finished.
>
> Move the cleanup from qemu_cleanup to the NIC deletion.
>
> Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structu=
res if peer nic is present")
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reported-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Eugenio P=C3=A9rez (2):
>   net: parameterize the removing client from nc list
>   net: move backend cleanup to NIC cleanup
>
>  net/net.c        | 30 ++++++++++++++++++++----------
>  net/vhost-vdpa.c |  8 --------
>  2 files changed, 20 insertions(+), 18 deletions(-)
>
> --

Queued.

Thanks


