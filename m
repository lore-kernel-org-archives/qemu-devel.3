Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1321FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 08:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHIHS-0005PN-21; Tue, 20 May 2025 04:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uHIHP-0005P5-93; Tue, 20 May 2025 04:24:56 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uHIHN-0001rF-Ft; Tue, 20 May 2025 04:24:54 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-601aa44af77so4591955a12.3; 
 Tue, 20 May 2025 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747729487; x=1748334287; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghIvO5AS8mwOAmr85zjzw4+94UTWpeclWRhXWp5hqHw=;
 b=lWvSl5++y0oq1dT+TXQLWGqgfW1KY1zQ7J7x+gL3UpTmkndZlHPvRbw4Np9k6/oVty
 HEoQ1Yi80ZtkehuovYs7IgnUdaP6UNvA73QJLnGfyLjYjT/XABBJlyiH/rdHFoGnjrA4
 hgzgUhkrRfBxiZ5bT2uuf5lyE84H6pmmvnCa5LApTcqRVIHX5hHsFTtNVcFGJSCclElv
 Q506+cs97vT/AJvZqR6ni9dg5gzCRDn1X0DhXkD3kvWrim5isoyU59jJR6NjP2OhnMVC
 zvG2zHpI725MXBTlb3MOM097ENeGhoOlFhFoUnw7dUK+xkkSKWFY//EMOAdpFZSEGGUF
 OMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747729487; x=1748334287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghIvO5AS8mwOAmr85zjzw4+94UTWpeclWRhXWp5hqHw=;
 b=TO018YFLcRGQhrUic0VQS+A42TbMra7ojrxpc7apTXRYF1slukp3QiucHSa1Hs+BES
 ka/W0Fg12OACvFmkupRd7ThX25s1Q6sjdpFPPcwH0hdyeRvdePgVr6PcFkZ/pkimet9X
 4TbC2j2usAG+snPuPlHBPoBNjxi22Vw3J4xjJet4PwRSPoA5jpkGp5LXXvQlDIA4jfDs
 HsXHtIW8OmxttByTyBBINh0ValrvZm8T/vlmdsIux9NG8wKJSVIiPlfPwWZPzmHXdrKg
 liL3fykqP6iLiOaVCtl+/ZE7z8QJzJ6SPvIvcf5oH7Czu8AZXVQSqOns/JAtKo2vLJO+
 /7sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW56K75AMuZrbMJV+63ViDj20LSvl4fo9iawKSR5TcgUEcfkBNprV7lmwZuiO/1zewMZHfvU01SkNtCw==@nongnu.org
X-Gm-Message-State: AOJu0Yx5QaFSgAOrG7ElUlcGI5lH4yFhF0WpY/HT3EejhKqYEdxffWY5
 a2+S2y0hI19TAVkc6Wt2+wXlW3bxgAabfsgBff7pzjSZqwQ3SmuxCdbq10iT1zdGIEmT6jso+P3
 j/WbhAdO9FMe+3YYkAumZOl5EZbPsFY4=
X-Gm-Gg: ASbGncsBehwK4JOJx42i9Mo3j8CaeQ9ZHlpOIv/vFKXq8kgWDTVK69iPkcuE7Yv+WcG
 b6WrSVMEcqP5IyX4zd8My0CXhmA0Y4WufxNGHaYJBgW1Rh9EwuU+X4k7etIO5m42Pe0WywbWrCA
 dGq/W3Ao8J7zViTJebgOoy32blu/xDjoUcUJ8bv228IbNLnXuFTvbJ2R8X6LaLsH0VgQ==
X-Google-Smtp-Source: AGHT+IGZOx4aVJBLYfz+7aVY3GLR3mvpTpjQei4Bu3IXPUKbTkwdLTyRzxz9FRzeG1Dcn4VFrOePspY8tbrJX0WxCmE=
X-Received: by 2002:aa7:d593:0:b0:601:31e6:697b with SMTP id
 4fb4d7f45d1cf-60131e66aacmr10573136a12.30.1747729487306; Tue, 20 May 2025
 01:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250518152651.334115-1-zzyiwei@gmail.com>
 <328b1fed-f23d-4ec1-ab06-c3096a76da19@collabora.com>
In-Reply-To: <328b1fed-f23d-4ec1-ab06-c3096a76da19@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Tue, 20 May 2025 01:26:13 -0700
X-Gm-Features: AX0GCFuiJ7XgqJKgOrKlWPgiLr2zyyLWK5nZuqHhcNDuQzePQYu5_yWE2uwUu-E
Message-ID: <CAJ+hS_jVxV78mifbPEqvFM9Yuf3GOS+iP-yFrpLtRksGYpFLxw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: support context init multiple timeline
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=zzyiwei@gmail.com; helo=mail-ed1-x52a.google.com
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

On Mon, May 19, 2025 at 7:29=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 5/18/25 18:26, Yiwei Zhang wrote:
> > +#if VIRGL_VERSION_MAJOR >=3D 1
> > +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
> > +                                      uint32_t ring_idx, uint64_t fenc=
e_id) {
> > +    VirtIOGPU *g =3D opaque;
> > +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> > +
> > +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> > +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX &&
>
> What if guest kernel version is very old and doesn't support ring_idx?
> Wouldn't this write_context_fence() cb be used by vrend for signalling
> fences without ring_idx info?

Old kernels without CONTEXT_INIT don't have the uapi to create context
fences. So only ctx0 fences can be created, which are retired only
with the ctx0 specific write_fence() callback. The newer
write_context_fence() callback is dedicated to retire context fences.

>
> --
> Best regards,
> Dmitry

