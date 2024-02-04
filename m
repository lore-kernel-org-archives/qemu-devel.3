Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C646C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 02:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRzJ-0003t2-21; Sat, 03 Feb 2024 21:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRzH-0003ph-Hj
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:12:03 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRzF-00031R-Sr
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:12:03 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-363b6c3bc1eso4844325ab.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 18:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707012720; x=1707617520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOawBX782AYffXxTfOz9/om5gEl9gRcodQAMCApZGoo=;
 b=jrHjS51nuSUB7Y/hEQfHWecG5aJwvZ3Ah1rskqAVnFQC7Tz8cdHcWJo0DTdEdPRrbr
 rnXPsO3z5amdTBxq4rJi5fYCtihfqcPraR2ZOemcp9iAsrorr6eC/LG2wEFaWxaQoUEH
 w2s6k8vchNklLc80hSfi5WOzNshy1tAwwzBOzZDxh6L+FBqmKnHraw2X+Ry8yDoix2QU
 At+pDLIx7N8bCn7ekJJvvCkPCosWhGd6+hVl8hmHg1ot9yAKtIKsLs4TTlH8i4iHUIPN
 G1sh/a11owcKHEuUYFT0nyYgPyQm/SFERNrEaZmMsSXy7d7n3qBx1g134sVSFs0Q3ttt
 0gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707012720; x=1707617520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOawBX782AYffXxTfOz9/om5gEl9gRcodQAMCApZGoo=;
 b=wgXL7eKPqxS/n7QGVX1irsDIZoYRSjGCSactz1jqLrkiofQmmj7MK7ZAIMVy0u2iN0
 JGgY9szGhxSG17jYe5xBnJYvdOzwYm4fAqa0JKSEhWhS1IemVAzS7cG63tcUStJrPGea
 50VUisQbrnfUc7AJBAlhagh4ICpNuvMoKJojZuuT/xu9UpxAaGNfi4nZirJNeUkl3OVH
 wkMkgalthc43ecKS6LuDzSUwvrzBtjgcrq+kjS1tx4eUedWYave9modbhUQT4lBcScHL
 YCxILXOiXcygX1Z76cRhXOD9lB/GvMdGqMlhUFvo62C5DuRZ3LmH2kL+cGcNKxKGRuyu
 RlAA==
X-Gm-Message-State: AOJu0YwSzVe1/QD7AOA34w95eUqyI2u+nB55WtmrCDmb5a8GGRebWg3v
 TVDibsVxz6ApTSL4KfJw97W0TbfE5wWrfrRg99KPBwGBDZm6/HFUtO66BWHphelfVV4wNg83qyB
 5Pj1uSWK/CRdeOMHcpRIY7RAU0wQ=
X-Google-Smtp-Source: AGHT+IHSIKJCEC6K5zNEhg6O9ATCM6rk2Sfl0zqF/YXN7V3sOdYfZR6FitGRHJa8E4qfiCKKG7LKB9rG0GqF7jwy6KQ=
X-Received: by 2002:a92:cad2:0:b0:363:a9c0:fe58 with SMTP id
 m18-20020a92cad2000000b00363a9c0fe58mr6645022ilq.9.1707012720630; Sat, 03 Feb
 2024 18:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-14-david@redhat.com>
In-Reply-To: <20240202215332.118728-14-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 21:11:49 -0500
Message-ID: <CAFubqFvknpetS+vS71mSidemFDa8WmgLaZyBqVmyP6Vt87bOnw@mail.gmail.com>
Subject: Re: [PATCH v1 13/15] libvhost-user: Factor out vq usability check
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 2, 2024 at 4:55=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Let's factor it out to prepare for further changes.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 24 +++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 7d8293dc84..febeb2eb89 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -283,6 +283,12 @@ vu_remove_all_mem_regs(VuDev *dev)
>      dev->nregions =3D 0;
>  }
>
> +static bool
> +vu_is_vq_usable(VuDev *dev, VuVirtq *vq)
> +{
> +    return likely(!dev->broken) && likely(vq->vring.avail);
> +}
> +
>  static size_t
>  get_fd_pagesize(int fd)
>  {
> @@ -2378,8 +2384,7 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, u=
nsigned int *in_bytes,
>      idx =3D vq->last_avail_idx;
>
>      total_bufs =3D in_total =3D out_total =3D 0;
> -    if (unlikely(dev->broken) ||
> -        unlikely(!vq->vring.avail)) {
> +    if (!vu_is_vq_usable(dev, vq)) {
>          goto done;
>      }
>
> @@ -2494,8 +2499,7 @@ vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsig=
ned int in_bytes,
>  bool
>  vu_queue_empty(VuDev *dev, VuVirtq *vq)
>  {
> -    if (unlikely(dev->broken) ||
> -        unlikely(!vq->vring.avail)) {
> +    if (!vu_is_vq_usable(dev, vq)) {
>          return true;
>      }
>
> @@ -2534,8 +2538,7 @@ vring_notify(VuDev *dev, VuVirtq *vq)
>
>  static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
>  {
> -    if (unlikely(dev->broken) ||
> -        unlikely(!vq->vring.avail)) {
> +    if (!vu_is_vq_usable(dev, vq)) {
>          return;
>      }
>
> @@ -2860,8 +2863,7 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>      unsigned int head;
>      VuVirtqElement *elem;
>
> -    if (unlikely(dev->broken) ||
> -        unlikely(!vq->vring.avail)) {
> +    if (!vu_is_vq_usable(dev, vq)) {
>          return NULL;
>      }
>
> @@ -3018,8 +3020,7 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
>  {
>      struct vring_used_elem uelem;
>
> -    if (unlikely(dev->broken) ||
> -        unlikely(!vq->vring.avail)) {
> +    if (!vu_is_vq_usable(dev, vq)) {
>          return;
>      }
>
> @@ -3048,8 +3049,7 @@ vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned in=
t count)
>  {
>      uint16_t old, new;
>
> -    if (unlikely(dev->broken) ||
> -        unlikely(!vq->vring.avail)) {
> +    if (!vu_is_vq_usable(dev, vq)) {
>          return;
>      }
>
> --
> 2.43.0
>
>

