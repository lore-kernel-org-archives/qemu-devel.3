Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F87C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRWs-0003Tg-1i; Sat, 03 Feb 2024 20:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRWn-0003TS-Rr
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:42:39 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRWm-0006lv-6Z
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:42:37 -0500
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7beda2e6794so71230839f.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707010954; x=1707615754; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWQrWH1CZ+JM6T3J0wi7jje2Z2XeHYcn9hJhtCfKwm8=;
 b=PObFZWgh2RJvXZKzUIT14qJ8ckl3ZcRDlBJ/kp6WNy2nR7ONh6HCjZ8k4TYBO1Nzer
 MpaTlQGzHKnbMlpaccjHlRMsc/rkPAT0J08I5Exyszx6paMwaaD++GR16h6GNEFQxl0T
 12nwQsgbsbo/nMfemjjA4tB2VPaQxuD3dhad8020cjObubiUOtrwTAe62ogMHuq4UqDN
 GCewmcrPYJPleiZMq4BPoAwKhf48eVXpikMa93nxCysFML1v7e+yFIV7dxeXj5ell6Gx
 gJdSurB3zQv1VdBPrvbe0R7Fx8qdHWvDL9vUcI1XadZgR5VUVmOB4oMf0J4NQC+7lv6L
 2cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707010954; x=1707615754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aWQrWH1CZ+JM6T3J0wi7jje2Z2XeHYcn9hJhtCfKwm8=;
 b=XiprqXLXMPHWAbsN+uzhHQAPJxGuPjYNu4pRFTkFaYAUYNE29EbF4ilIkm4Xy79eWE
 iw1zW5IKF2fwiU4TD67OiHYmhDaunoyVfuUazK1SD9Rk4bPy0hkqfFPegqXZq9KoQO40
 lEG37mBLBqa98Eew1ywzB1kk/72vVac/edV/GSAyxam2rstKkWIe8Ji0cFntwVrSs3as
 OkTBdvMCcxAcXB7dAF+rQDamLWTgwJ9O7+jn2I2VcXvKVV9ai0iOEMSlo+97/8+aKRus
 PrZWkhWZBlWNWZMWASCIeSQqXDVlJkmgkIvGRF6NmEmJe04fVmK6TI7DLgRr6wu3xlDe
 pL0g==
X-Gm-Message-State: AOJu0YyEhaaLSAAESicdg/+/oYz4LxdD17zYsS8ylTZEz0muRVVmpDQB
 aD76dLUob5Skl4j9q2M/2w8Qm330RzHEF0ucTLRejvO0pG3s19Hn7+GlV+rw8NT/EdHlGp72Vi+
 L/LyKOtXeaJmT2exNyMLvSDhMjQigfePzczxf5w==
X-Google-Smtp-Source: AGHT+IHmGLVeEAeh+9CX6Bq68yHbjU9BrVyUgy4j7hW1mLv0jZq8VW2/KY8fVZwZzO/AKjZHbPmO4Uf//lyGxuV8ZhU=
X-Received: by 2002:a05:6602:2d84:b0:7bf:e164:e4f1 with SMTP id
 k4-20020a0566022d8400b007bfe164e4f1mr2035990iow.2.1707010954570; Sat, 03 Feb
 2024 17:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-4-david@redhat.com>
In-Reply-To: <20240202215332.118728-4-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:42:23 -0500
Message-ID: <CAFubqFvqSQSELnmkzj1np==L0LcSP0RR=pF_0FmcHbEY1==UwQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/15] libvhost-user: Bump up VHOST_USER_MAX_RAM_SLOTS
 to 509
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2d.google.com
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

On Fri, Feb 2, 2024 at 4:54=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Let's support up to 509 mem slots, just like vhost in the kernel usually
> does and the rust vhost-user implementation recently [1] started doing.
> This is required to properly support memory hotplug, either using
> multiple DIMMs (ACPI supports up to 256) or using virtio-mem.
>
> The 509 used to be the KVM limit, it supported 512, but 3 were
> used for internal purposes. Currently, KVM supports more than 512, but
> it usually doesn't make use of more than ~260 (i.e., 256 DIMMs + boot
> memory), except when other memory devices like PCI devices with BARs are
> used. So, 509 seems to work well for vhost in the kernel.
>
> Details can be found in the QEMU change that made virtio-mem consume
> up to 256 mem slots across all virtio-mem devices. [2]
>
> 509 mem slots implies 509 VMAs/mappings in the worst case (even though,
> in practice with virtio-mem we won't be seeing more than ~260 in most
> setups).
>
> With max_map_count under Linux defaulting to 64k, 509 mem slots
> still correspond to less than 1% of the maximum number of mappings.
> There are plenty left for the application to consume.
>
> [1] https://github.com/rust-vmm/vhost/pull/224
> [2] https://lore.kernel.org/all/20230926185738.277351-1-david@redhat.com/
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libv=
host-user/libvhost-user.h
> index c882b4e3a2..deb40e77b3 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -31,10 +31,12 @@
>  #define VHOST_MEMORY_BASELINE_NREGIONS 8
>
>  /*
> - * Set a reasonable maximum number of ram slots, which will be supported=
 by
> - * any architecture.
> + * vhost in the kernel usually supports 509 mem slots. 509 used to be th=
e
> + * KVM limit, it supported 512, but 3 were used for internal purposes. T=
his
> + * limit is sufficient to support many DIMMs and virtio-mem in
> + * "dynamic-memslots" mode.
>   */
> -#define VHOST_USER_MAX_RAM_SLOTS 32
> +#define VHOST_USER_MAX_RAM_SLOTS 509
>
>  #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
>
> --
> 2.43.0
>
>

