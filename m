Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6518DD2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 04:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Sbu-0001Pm-O1; Wed, 23 Oct 2024 00:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t3Sbt-0001PR-4z
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 00:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t3Sbr-0002dX-C4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 00:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729656273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5WToq7NzHoocaRgTK4x1OCK76bJCyL7ULtF+WQMY0k=;
 b=VvJw/p5e+2yd8phgMycxCuiT1Qr0/4LQq4J28HOWsyksLXY9BQ54D/OoY7sPGpnPoV+aGX
 NAd9umm43XW17o8EkhTwrdlBgbulcfKqbfZVTQlQQQpxku5+YBkxsHrO0GdAaDg768wVZH
 kL17YMxkfmAg+hxL9dXHwHo0e/SEtC4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-u17sjZezPpWhFUbvXznV3w-1; Wed, 23 Oct 2024 00:04:31 -0400
X-MC-Unique: u17sjZezPpWhFUbvXznV3w-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e2ca403f5dso6012358a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 21:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729656269; x=1730261069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5WToq7NzHoocaRgTK4x1OCK76bJCyL7ULtF+WQMY0k=;
 b=AnrTW5ZHzNsjMiDK7SSY1TrgOvKWuxnXjjPyemj6Bv/a7PUatFHpqq+Tto+7GfS3oN
 cGJvBZiMhF2s7zY3Ui//6Q+sk77It3Psk4Qdxjvvw4GsRSLGEG6o7QiyWbOSKhtQwT+N
 jQVKETdpMV6qJ3HcebOF2bp+seoNLphBvs3zqpcn99SQWg6J5LOOEW6J2G7olXoOUXey
 6sok5kebUO/zRvHCcbbxez9AEiBZtQ4vLbrPLXNzGSyHJ9I8wZx3IX7+HjaDGpL13iAD
 eeueYoSnKWbVOTgezRQuDOREQCQlzJ+lP50IHrmP5GMOdOcspprs2g9DSWaEkmf4Mjzp
 KKAA==
X-Gm-Message-State: AOJu0Yy/BPEOWiIDRYRzRlcmmFNRAy9AwX7p0Y5WElzGTNlKsQp9qpuG
 cppeOXTFyWE7gUuF2UXOAFvkWYDwfENeB5CZRwgZ1C4ml8tzI+UqaXm0UEz1B9AKujrMya2Yrjl
 0xIUfvx420ChXWhrRAQWb5RCSo0ePfVNEYuBd3U3gyxxnESuVG7YETX1mHengFLypfZYarkdKr5
 DbJ92bbKSt7nXz6VI0WbAnOy5j0Mwks2zUCsnu1zNXq9E=
X-Received: by 2002:a17:90a:ce83:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2e76b5e63d1mr1215566a91.15.1729656268783; 
 Tue, 22 Oct 2024 21:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbd0be6WfLipSQMJSS5gsphqgtnh4Uli4LxWXVzSao5/8uX5Cop+lA9RgYbAh/rAFOK0e+TyJIIQletyefdA8=
X-Received: by 2002:a17:90a:ce83:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2e76b5e63d1mr1215547a91.15.1729656268324; Tue, 22 Oct 2024
 21:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240912165408.234447-1-eperezma@redhat.com>
 <20240912165408.234447-3-eperezma@redhat.com>
In-Reply-To: <20240912165408.234447-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Oct 2024 12:04:17 +0800
Message-ID: <CACGkMEviROuas_MT-tT+PMw0PCJa9Ossu1a-oKHpgt_TAiZxhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: move backend cleanup to NIC cleanup
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, dtatulea@nvidia.com, mcoqueli@redhat.com, 
 mst@redhat.com, si-wei.liu@oracle.com, qemu-stable@nongnu.org, 
 leiyang@redhat.com, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 13, 2024 at 12:54=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> structures if peer nic is present") effectively delayed the backend
> cleanup, allowing the frontend or the guest to access it resources as
> long as the frontend is still visible to the guest.
>
> However it does not clean up the resources until the qemu process is
> over.  This causes an effective leak if the device is deleted with
> device_del, as there is no way to close the vdpa device.  This makes
> impossible to re-add that device to this or other QEMU instances until
> the first instance of QEMU is finished.
>
> Move the cleanup from qemu_cleanup to the NIC deletion and to
> net_cleanup.
>
> Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structu=
res if peer nic is present")
> Reported-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v2: Remove NIC peer also at net_cleanup. vhost-user trust all the
> backends are clean before qemu removes char devices.
>
> This is not a requisite introduced by this commit as
> system/runstate.c:qemu_cleanup shows.
> ---

Unfortunately, this fails the build:

https://gitlab.com/jasowang/qemu/-/jobs/8138832559

Thanks


