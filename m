Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFADC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 13:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3yMY-0004L9-MQ; Mon, 06 May 2024 09:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s3yMS-0004Im-LG
 for qemu-devel@nongnu.org; Mon, 06 May 2024 09:26:32 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s3yMM-00024z-Mq
 for qemu-devel@nongnu.org; Mon, 06 May 2024 09:26:32 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59a934ad50so404563266b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715001985; x=1715606785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXjEFMRzTzj3KldPoNPBs9HkkDMftiy61B6AF2CyXKk=;
 b=c/IQ4wI12j64yW8ZkgpwTVizwnqsA5OajQVEBN1olJs+IA6bKAFt8M8RS/wUeVFUHz
 CY4+zfo5zprH4hXDozO13D7sHBanCzTYbXxce4mi//6E0VYAtXNuog722tLEltKtnsXr
 P56CJfXPAZJYH1WF+maJi4H3V8OOby2//OsdaPpkVd7xXJMmkMbN4ltWDvZKm8XPAdoR
 hG1j5MqrrGA8oA0sGQa8hlzJIaVtYdkIZ3WMWBJPEsvtJRK6YH2Cug7M0TiQyrNsYJAX
 5ZkcYbw1spQkFXEovE8l3j2sOiCx+7bVDgP6bonJke+BhM6RF9ywuQvklMM+EDGDQa8g
 VGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715001985; x=1715606785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXjEFMRzTzj3KldPoNPBs9HkkDMftiy61B6AF2CyXKk=;
 b=QLJMPAmayhkYsyzQ7v1qbvhGUVyEpncJoKty5G/q3XPRxKeM8v12ar53D6hrZQlyp7
 pWPbP3EL5syRhfeqgfEfVXE4t8nSX2kaZJQseSO0V6hsdfuYvnZFgBOZFZcZ/z3kowLC
 FMn1XeQsH8LqLd2y62Ty2Bj/+PRC2bnxr1f99yLGLsEu8mNdk2WcsD9vVHH9EL+dsM43
 Bxn3oF9mPwPV9bMdrGYJRb07QSGQAep9CFjTGYMqHuSCSAWJgEx2vlRDvJwcM9az5sMQ
 fHAGtg99X+akk7ZQpATBGEptBctb9Qg6IX2UIx1mdOdPUAyxxVGd5KNVy1VIxPlZ5d2L
 uDhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNGl4N+5ZqRgHBj5X+Ijr8m4ugFSOaljMPuljpfpotDZ9xFlvzfW45NvHUlfQ1662g5Uq1tkCbTw6ufDs7hL1AZDx8bS4=
X-Gm-Message-State: AOJu0YzGBDdkD3TrdiD+j1gNL133maX29vXHoH0HwhOvdpE/bP49YXjA
 VKo6ycc2miO3808DEIML5hF6hhd3UN4WmYoaZBjJmtKk4rxyGvIVX6gUW3qFRS0T0loGGcSWpfg
 zdTuYSdrk5GpZcdi9ePqbDvnoRNI=
X-Google-Smtp-Source: AGHT+IFjRGcd4vevXd4YmEJIpnLbj+EtQPldgB+Qq/+tP0OUO7ic/p9jXzqaReEl+6jNOvGvJR1QQdDnYUkvaMPNk/A=
X-Received: by 2002:a50:d495:0:b0:56d:c928:ad76 with SMTP id
 s21-20020a50d495000000b0056dc928ad76mr6259743edi.26.1715001984479; Mon, 06
 May 2024 06:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-15-edgar.iglesias@gmail.com>
 <0263b7e8-5800-4f5a-9dc5-bc2b4fbbbbfe@redhat.com>
 <d4008042-6f68-42f6-8ade-fbb0ba115a33@linaro.org>
In-Reply-To: <d4008042-6f68-42f6-8ade-fbb0ba115a33@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 6 May 2024 15:26:12 +0200
Message-ID: <CAJy5ezoVOR-OB7HVEAAkmwdC7jerCVatNS=VdP1jTMZpgUm_fg@mail.gmail.com>
Subject: Re: [PATCH v4 14/17] xen: Add xen_mr_is_memory()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 sstabellini@kernel.org, 
 jgross@suse.com, "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ej1-x631.google.com
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

On Mon, May 6, 2024 at 11:59=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 2/5/24 09:26, David Hildenbrand wrote:
> > On 30.04.24 18:49, Edgar E. Iglesias wrote:
> >> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >>
> >> Add xen_mr_is_memory() to abstract away tests for the
> >> xen_memory MR.
> >>
> >> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> >> ---
> >
> > [...]
> >
> >>   #endif
> >> diff --git a/system/physmem.c b/system/physmem.c
> >> index ad7a8c7d95..1a5ffcba2a 100644
> >> --- a/system/physmem.c
> >> +++ b/system/physmem.c
> >> @@ -2227,7 +2227,7 @@ static void *qemu_ram_ptr_length(RAMBlock
> >> *block, ram_addr_t addr,
> >>            * because we don't want to map the entire memory in QEMU.
> >>            * In that case just map the requested area.
> >>            */
> >> -        if (block->offset =3D=3D 0) {
> >> +        if (xen_mr_is_memory(block->mr)) {
> >>               return xen_map_cache(block->mr, addr, len, lock, lock,
> >>                                    is_write);
> >>           }
> >
> > I'd have moved that into a separate patch, because this is not a simple
> > abstraction here.
>
> Yes please, maybe using Stefano review comment in the description.
>

Thanks, for v5 I've split out this particular change into a separate patch:

    softmmu: Replace check for RAMBlock offset 0 with xen_mr_is_memory

    For xen, when checking for the first RAM (xen_memory), use
    xen_mr_is_memory() rather than checking for a RAMBlock with
    offset 0.

    All Xen machines create xen_memory first so this has no
    functional change for existing machines.

    Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

diff --git a/system/physmem.c b/system/physmem.c
index ad7a8c7d95..1a5ffcba2a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2227,7 +2227,7 @@ static void *qemu_ram_ptr_length(RAMBlock
*block, ram_addr_t addr,
          * because we don't want to map the entire memory in QEMU.
          * In that case just map the requested area.
          */
-        if (block->offset =3D=3D 0) {
+        if (xen_mr_is_memory(block->mr)) {
             return xen_map_cache(block->mr, addr, len, lock, lock,
                                  is_write);
         }



> >
> > Acked-by: David Hildenbrand <david@redhat.com>
> >
>

