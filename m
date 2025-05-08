Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CB2C3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 21:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD8nu-0005N6-TG; Thu, 08 May 2025 17:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uD8ns-0005Gp-9k
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uD8nq-00062m-Oi
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746739751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gduKp8TXaddet8MYCJkDdTxox7NbhZJ7SnzHOtqVZeE=;
 b=OqFMnzssU3W0gBaLhY+MmiFYlQ/ZaTQYjn7V32FaXl/oBPtsgnD5V5I9oyX+7PL11Z6lYu
 3+QHOtitzuUiZS4hPmAsMG5scWUD3kiPpAAWhwfZXEe2QgTX3dfhNvB1FM9UgK/8Ohkq0t
 9lW8ltCpe3iuGR6J0pMqn/i4WelxmcU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-b1jdGjAbNdSiL_jLj4rr8A-1; Thu, 08 May 2025 17:29:07 -0400
X-MC-Unique: b1jdGjAbNdSiL_jLj4rr8A-1
X-Mimecast-MFC-AGG-ID: b1jdGjAbNdSiL_jLj4rr8A_1746739745
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3feb1dce9ceso572527b6e.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 14:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746739745; x=1747344545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gduKp8TXaddet8MYCJkDdTxox7NbhZJ7SnzHOtqVZeE=;
 b=vK8WFDP3951FP+RUMdEATdLfra34w4hW86KdxGB/qZj49V666ovOfC56VskqC0hOp8
 w43n1eFL5jZSmNtn4aFaiPCErEIn8c1yUaX4raX6943I0/VeFsxeqXSYC4IQ/2gWct1C
 6evLYDKMkGIQOD3Itdz5NySysT83QQ4qBxLGV2N0pRPbwDo26aL94s7ezdi5dzpEhat6
 YWE+W7Ltz5xVt0Pn3jW3UHTYZA5m/dkOw6HFEYkdY+lItzNdC/ly21TgijaSfBcDTp2M
 J0pocq57/fWwuNdqT4BB+07HmnEOMPO/CJFZUd5MuUxl8vlSF0vqKbzw1t8uZAdxnwpj
 fIfQ==
X-Gm-Message-State: AOJu0YyaJc83GYGU2SLAAkX5hMvkLayVOVHunUH0V6VcKyb6tD/hiDFq
 8xXyrpwpYgWKfMBb1JfwYnAuU2QCPOL6l7Ge7Dq52BYibHZa7xrapt8NBZ86EzNjikwc5VZe5FW
 kOeg84ZUcdCEWpKGgua9v6PvehGdOU+CEmqrhJffMwvbAt7P7RRFwBf4KTLRrxvpUhhotNI+ZE6
 zEoY47Ii7/h64D/HL0TwhGwI6sR7s=
X-Gm-Gg: ASbGnctAmDJ8tV8clYeYFbbVWEkZoh98SOQZuehBmx9cBXBNr6ccbOG/PuFzx8vKTYE
 Kk+tfBB467IvC9f4uQlNVJocsadmL8oT0NAReyRAyXMcM9wrPdHi65S22ZpQ9sNREDhpuUQ==
X-Received: by 2002:a05:6870:c083:b0:2c1:5448:3941 with SMTP id
 586e51a60fabf-2dba4317d33mr706757fac.18.1746739745209; 
 Thu, 08 May 2025 14:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ZD6STFSXwRY5AvmKffHMkX6mVHH+MWc0kDGuytNNJFMGSmGUA3gfCUsL1mAfJG3jyP5mGjQq/Smaiha9YLs=
X-Received: by 2002:a05:6870:c083:b0:2c1:5448:3941 with SMTP id
 586e51a60fabf-2dba4317d33mr706736fac.18.1746739744837; Thu, 08 May 2025
 14:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250508002440.423776-1-afaria@redhat.com>
 <20250508002440.423776-3-afaria@redhat.com>
 <20250508203755.GA63777@fedora>
In-Reply-To: <20250508203755.GA63777@fedora>
From: Alberto Faria <afaria@redhat.com>
Date: Thu, 8 May 2025 22:28:27 +0100
X-Gm-Features: ATxdqUGldNclz98oWGrC7sKBpJLwSdW5iNPS0cRjTy5K3QDE_LTCuEk4Z4BaKYA
Message-ID: <CAELaAXywEqdE6w32QsGAqfBJjQRUjRQt7WaW1pJvjS+ifQtqHA@mail.gmail.com>
Subject: Re: [RFC 2/4] virtio-blk: Add VIRTIO_BLK_T_OUT_FUA command support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>, 
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Raphael Norwitz <raphael@enfabrica.net>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Hanna Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xie Yongji <xieyongji@bytedance.com>, Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 8, 2025 at 9:38=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
> On Thu, May 08, 2025 at 01:24:38AM +0100, Alberto Faria wrote:
> > Signed-off-by: Alberto Faria <afaria@redhat.com>
> > ---
> >  block/export/virtio-blk-handler.c |  7 ++--
> >  hw/block/virtio-blk.c             |  2 ++
> >  hw/core/machine.c                 |  4 ++-
> >  hw/virtio/virtio-qmp.c            |  2 ++
> >  tests/qtest/virtio-blk-test.c     | 56 +++++++++++++++++++++++++++++++
> >  5 files changed, 68 insertions(+), 3 deletions(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Please disregard this version of the series, it is missing several
hw/block/virtio-blk.c changes needed to actually get
VIRTIO_BLK_T_OUT_FUA working. I've sent v2 fixing this; it only
differs on patch 2/4.

Thank you,
Alberto


