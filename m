Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E786FC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRbQ-0007Cm-A1; Sat, 03 Feb 2024 20:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRbO-0007CP-VB
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:47:22 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRbM-0007o3-7d
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:47:22 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7c00ce1e005so121372139f.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707011233; x=1707616033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HILLJBidYRCstlJ7/XUG1N3Wo6mj6lwKWyvib6/1IRc=;
 b=KRaAv2wjXPignciX/E1cgHLILkWr+9X1LLAEVSqHQ4FAJFUpEhULZ6YhXIHjrLsF0g
 4zzA3uFdRH+WAXOcChUQQ+hifLiZ2bkXMNw4uf2D55U+0C6ojIagc4dm/yzaY2WrImL0
 IxHgfmdYed23gTbKpu2/V3hyZ50ZZTf6KepxBn/2RqS6iod/ZxNXk1mnPVUls1+MSOpo
 SNtxUr4ZAfBIxvThUEVcz4EgBR/yD899LaOQvZwa7dZxCYRkeYb1eKcsbHWHEQ+Q4YkJ
 MigRymt7J5vHaUrl1CmaQQTmRoA+87y8uqeW8kTI2OrHT0qN4B/A1Hb1s9dDsqm5sibE
 lzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707011233; x=1707616033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HILLJBidYRCstlJ7/XUG1N3Wo6mj6lwKWyvib6/1IRc=;
 b=YQtESVabAXeeCOOElnMS3gEPYwgCJKKZCO4M/7Gkl6Oj9qA9JSs5eny8CoYRwL7A+x
 eS8nmyi/O4G1fCJehfKJVSjNGOjubkac6sUMnpQHL601yltbi0H44N7j3oUs72/uldvx
 75pDjV/namcEANL7Ii1qXapbCR2BnYWAaHDY39uKreF/vvL0HGDvQuOc+FcKmNz6tlP+
 13Ye5IQ0x3aRoJmRDAzBeAJ80t0fTIxv+yAyd8UpzeEXp4x8uW/OzzhaI3qxYk7VEgIg
 bAy4LET7dVNSn7HuXx0ImWbxoDBP3m0oXVWrHET8t5gB96/ZX8K560jfTuDhCfkXKb7g
 Z8+Q==
X-Gm-Message-State: AOJu0YxN7TlTKKMJfZY8Cqv+t2xfOW33nj7BoFobwodmweeEYMWCYeaO
 y6M5SUmsizqb5vpjp+8B3mmdPRnrxaCdASiwpyrVltqpux/kY6Yg8GP6ld8kqfs1a6dgcQA09E6
 EHOrTWOXGHljJsvR9OaE8W2ZsQ4QuGXi1DyoGBA==
X-Google-Smtp-Source: AGHT+IEqfCeXe/oX9q3cBwD+d4Kdzk4JIWNgShwY5lKz3KN+z0hIIfe2BFtpUdlp8OEJY/Va602tTA6/lzMuY2V1frU=
X-Received: by 2002:a5e:a617:0:b0:7bf:5458:51a3 with SMTP id
 q23-20020a5ea617000000b007bf545851a3mr9797093ioi.6.1707011233453; Sat, 03 Feb
 2024 17:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-10-david@redhat.com>
In-Reply-To: <20240202215332.118728-10-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:47:02 -0500
Message-ID: <CAFubqFtLwvp4oRb1PKFqUzvr0nO5R5+9MCAc-o4Cqe4uv30GXQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/15] libvhost-user: Don't search for duplicates when
 removing memory regions
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
> We cannot have duplicate memory regions, something would be deeply
> flawed elsewhere. Let's just stop the search once we found an entry.
>
> We'll add more sanity checks when adding memory regions later.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index e1a1b9df88..22154b217f 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -896,8 +896,7 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>              i--;
>
>              found =3D true;
> -
> -            /* Continue the search for eventual duplicates. */
> +            break;
>          }
>      }
>
> --
> 2.43.0
>
>

