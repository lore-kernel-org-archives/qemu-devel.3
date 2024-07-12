Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF16C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHD8-00089b-E8; Fri, 12 Jul 2024 10:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSHCy-00082T-0C
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:25:14 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSHCl-0005hR-Qd
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:25:11 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58d24201934so3422649a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720794298; x=1721399098; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4mdYYvHQplVLqMwGlfhOkzKhCELaN8LiA85Ap6Zdns=;
 b=YtMhKfc8HfgjmdcyYfr+AgxvLwciCzMRx0e1WA0wSMf+kyS8p0nv6BfDza9maoklwR
 aXYAivT5+PLVM0HxxOQFoE9V8fOvLrF0NBnvr62vCexD3WSAvQ68lYMLqjHpwTrh5Way
 eIiMS6PaAoQ64kNSReVF3GDxSD7pOnjxRCq4NMn4dYTx+NQTHeBIzuKpfEnCegfYzRcK
 tg/kQX1EI2kFDjzQfiGPl0HyW62DsDTU1EPhzCRy29FcWKFT+R0Eq0sBBe9A4ANDNDmI
 XcJVPa3NMuMzUEACsB1Cb0Rmjw3FRJSKt73L+6utdNgdcgHCvpC051BmXOGmSex2y/DS
 EE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720794298; x=1721399098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4mdYYvHQplVLqMwGlfhOkzKhCELaN8LiA85Ap6Zdns=;
 b=aqKR9WDN1qAj5dc+pwt1GzaDvwDi95lX1Nu/A0taYodFijrAGgoVw0ph25cRDCq9+J
 cMVR7oqHHcWCcAIcIHWP7KM9bRxj34VxILHLR1cpITbPqa2sVt2fqN6ZJzlpe90yhnYl
 sqAHrHxalGuKy7hJQsv/oQ8HsBvDVQBelxvCGn1ODoiT1fOKGMsDzsuqdS3qPl1ECOic
 /tepFfc6pROJAD8QV93nKArwWrPCPe1mhOFDvY8pTBPrLfRo5tTkEno3T6e35yHE6E3X
 JKKqErA8DUsnoNLzRUth14I7MBB3zhGveuHTw0hi0KW73MlSaUqCUliHTjwzCypUy+AM
 qx2A==
X-Gm-Message-State: AOJu0YxClWYDPsoTI+NzDZbO2/ooAQv1/uupvBdH/XLTUmliLEhEEeEg
 Jxb/B1owLyqYeCNAk5sy7BunWEyiT0yaKyGdQSa97szrYOV4QWECcvsNP+bHt26Rj9b7rXNLvRj
 LEuKBQhQYjH4A92juZ1Hh2lbTLer40n3U79Im9w==
X-Google-Smtp-Source: AGHT+IFsZUsUa6VqqzxasJA/FBuFGNObXkKmWbQOoxzzT04Vx/c2ssui2+1SrtVU9vDRmNDcvi5dQz5lHookJ8iervc=
X-Received: by 2002:a50:bb06:0:b0:584:21eb:7688 with SMTP id
 4fb4d7f45d1cf-599600085e4mr2120113a12.14.1720794298014; Fri, 12 Jul 2024
 07:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1720046570.git.mst@redhat.com>
 <5ab04420c3de11ae4a573b08b53584a2a0c5dd00.1720046570.git.mst@redhat.com>
In-Reply-To: <5ab04420c3de11ae4a573b08b53584a2a0c5dd00.1720046570.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 15:24:47 +0100
Message-ID: <CAFEAcA9Qvbz=S_-mEeeqgRdBXgxW+d3zrQxNZrcxg9S9G_UZQA@mail.gmail.com>
Subject: Re: [PULL v3 52/85] contrib/vhost-user-*: use QEMU bswap helper
 functions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 3 Jul 2024 at 23:48, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> Let's replace the calls to le*toh() and htole*() with qemu/bswap.h
> helpers to make the code more portable.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Message-Id: <20240618100447.145697-1-sgarzare@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c |  9 +++++----
>  contrib/vhost-user-input/main.c         | 16 ++++++++--------
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
> index a8ab9269a2..9492146855 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -16,6 +16,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/bswap.h"
>  #include "standard-headers/linux/virtio_blk.h"
>  #include "libvhost-user-glib.h"
>
> @@ -194,8 +195,8 @@ vub_discard_write_zeroes(VubReq *req, struct iovec *i=
ov, uint32_t iovcnt,
>      #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
>      VubDev *vdev_blk =3D req->vdev_blk;
>      desc =3D buf;
> -    uint64_t range[2] =3D { le64toh(desc->sector) << 9,
> -                          le32toh(desc->num_sectors) << 9 };
> +    uint64_t range[2] =3D { le64_to_cpu(desc->sector) << 9,
> +                          le32_to_cpu(desc->num_sectors) << 9 };

Hi; Coverity points out that this does a 32-bit shift, not a
64-bit one, so it could unintentionally chop the high bits off
if desc->num_sectors is big enough (CID 1549454).
We could fix this by making it
    (uint64_t)le32_to_cpu(desc->num_sectors) << 9
I think.

(It looks like the issue was already there before, so
Coverity has just noticed it because of the code change here.)

thanks
-- PMM

