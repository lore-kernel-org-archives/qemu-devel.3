Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776D7C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 02:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWS3i-0005J8-Tz; Sat, 03 Feb 2024 21:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWS3h-0005IW-Ho
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:16:37 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWS3f-0003ba-Ur
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:16:37 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7c3da02dcbcso84939f.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 18:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707012994; x=1707617794; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5MwKuRP1j2qbL1VFp+loud2H1ZyhuKIPFsEYMvgO7E=;
 b=Q2VzW9MjfzNoxxYABVVKm3PNpECRLa4q9jA10cnskh4SI4WPgAioOtCszoLjHrspjO
 B++ENlYEOP0h+TTBzz0mRxFCPtaozYliSQMwXw8/11lUQZfJzXyjVHRz6Qqfq4LEX7tu
 ZDH1GZP4B2P6YNqSkoFWypt3cfEjEHwCEEO6iUci06u8qJU1kCgov/UW0seNfW7+LqSe
 nWlhWca4j/99kvFdHBG0mk67Z0vqZXfSZcZElB8wedfQ2pdSmfCkcEOOMDcZn7SQuczE
 gyY9S4j2DEFQSZkT3LSf3HYGrtoZGI/5VF4sNiV8L0+99uw3MsVx3DW1DtFRwUdu5RMz
 LHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707012994; x=1707617794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5MwKuRP1j2qbL1VFp+loud2H1ZyhuKIPFsEYMvgO7E=;
 b=H2kiruvLDbi3op8AaQgCcYpJ4cpv1cJGVsclcfPfbjmY+UKpCiRXluYlqXfAo1tNY5
 79xaMk2iwwPlcH5KCpoa6e2DYnDmoCazeu9LM9GnArgY1+hJeNXcs4fn4MpKLGffcoOM
 hzPU2H0BPczUXWjrxFqCeqOp7KRF8CiPQr9LNb2PC79RhnDfqWzpyFPaqadxqEU7jMu0
 a8W3+Xlj38fdUhcqHx7STkzBIDJaqyn39WlQUo6ye1kohirK10ptsXzEl4bfPvt49Odm
 JckyFn7jpoJbJ+9ReHscLtjj5NpYPMU6U/KbVLEO3htCfQbS3RR5v2oRnnpPJKS3jFVp
 ty/Q==
X-Gm-Message-State: AOJu0YzVRw6VZwHQMuIt68EzYDs7SUEiBoqoxPAGiyDM0mhEFPuRwPDc
 UYByE6TJmdsGvcA3eEQRTPWddVclWbdVzZrRFalovGyGXImbXkSgQE5Gc8+ra259Vqq/v5zh9hz
 oMrIfE5HBIvxU+EIRBhG1ZU38fEw=
X-Google-Smtp-Source: AGHT+IEQJGVDgWp2A3cISJEQnQUbi32aTUzPtSAthkBvVWgcScL6/u+W1tQzp6YGAEalk8Wqor5PAVmz0gMS6I5FJyo=
X-Received: by 2002:a6b:6519:0:b0:7bf:f988:e0d4 with SMTP id
 z25-20020a6b6519000000b007bff988e0d4mr6054156iob.21.1707012994458; Sat, 03
 Feb 2024 18:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-16-david@redhat.com>
In-Reply-To: <20240202215332.118728-16-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 21:16:23 -0500
Message-ID: <CAFubqFviLAwkUBv0NwoUki2rARLoyEqJnRimRew5sDQ08LUhZg@mail.gmail.com>
Subject: Re: [PATCH v1 15/15] libvhost-user: Mark mmap'ed region memory as
 MADV_DONTDUMP
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2a.google.com
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

On Fri, Feb 2, 2024 at 4:56=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> We already use MADV_NORESERVE to deal with sparse memory regions. Let's
> also set madvise(MADV_DONTDUMP), otherwise a crash of the process can
> result in us allocating all memory in the mmap'ed region for dumping
> purposes.
>
> This change implies that the mmap'ed rings won't be included in a
> coredump. If ever required for debugging purposes, we could mark only
> the mapped rings MADV_DODUMP.
>
> Ignore errors during madvise() for now.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 738e84ab63..26c289518c 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -458,6 +458,12 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *m=
sg_region, int fd)
>      DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
>             (uint64_t)(uintptr_t)mmap_addr);
>
> +#if defined(__linux__)
> +    /* Don't include all guest memory in a coredump. */
> +    madvise(mmap_addr, msg_region->memory_size + mmap_offset,
> +            MADV_DONTDUMP);
> +#endif
> +
>      /* Shift all affected entries by 1 to open a hole at idx. */
>      r =3D &dev->regions[idx];
>      memmove(r + 1, r, sizeof(VuDevRegion) * (dev->nregions - idx));
> --
> 2.43.0
>
>

