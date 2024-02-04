Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4340C4828D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRYb-0004Uf-Ho; Sat, 03 Feb 2024 20:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRYa-0004UX-Jo
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:44:28 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRYY-0007Eh-Jm
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:44:28 -0500
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7c00128de31so124687839f.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707011065; x=1707615865; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcIw9qG2exC37IPIal1FnmxKmN8Vr06WvpBWAu1cW9w=;
 b=bHkyXgzZrV6e3ccfO6guguZD6wYPPI+tU2n/Wx0S8+/Yv7rTc5wXT25E4ydC4Tj2x+
 Y01tQqLwKzMgG+Uzw9FQchyLkAWO5BCkcQUXwIcnk0i7cRqy0nk2poXSauVQAylVhh8n
 p2jvypKkL2dMg5F8J/NhWTZrmcnFpFsPZ1pJl/yM+sLmWbKcnrjKJKpDC2xHHfhp5NpG
 MOELdGOdG17FlvJT0VTIDFjhHg8InqbsTH24yUwfWoctNG8RhgtTQCnti2wIjyVeeGuJ
 z2YkePt/G7/4B82NHs8Rj2ItBt7YK5r9QqC5Not2eQJmkWWGDiZqQa/Vd6S9vyMbXz8F
 eASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707011065; x=1707615865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcIw9qG2exC37IPIal1FnmxKmN8Vr06WvpBWAu1cW9w=;
 b=jPAuXSNacib0CUNZ2fu8Hu60GYtyNefHCYXVqVzZrGNay15DVG6vswkav0F2QcsM2w
 a9DwgFyaaZobLrLjPKz1kEm4EmE+eXpKT704HvJvuouTyxEDelTuviMjCgUMoMT19bdJ
 niw4GSOgsL6QDAik9CtN1HAgND+HDAaDdK6JiX//wKcmBosdR6pH7R724DubI9ap55av
 NO98XKEhPp1rgPImU8GBGgjecMlYF0YThU9iEdipKsE6/up+iBkbQF1BS1pMm4NpAETG
 wG5+JISopRHpirgIrT6bod5f/fzYKTwqHSBL7aUY9sPfk2MiOYixdgW/Rx5LL6CiWO8A
 DkCA==
X-Gm-Message-State: AOJu0YwXmWbIxgaJ2F45J126TWv8VW4CU5z52Julcb8TT1MsnyiWhP+o
 BQKb/68g1slAJmgWIZskrKTlmrbUhwWlzcgwI2etdx1LoaQzMoTF+/GTUIvc4BuIyM2TSYbyU4B
 cBJd5hlpMKgg5IEiPllYrTYPw3tsTzO8TLIKhrA==
X-Google-Smtp-Source: AGHT+IHC+A5mQbEeCAzPx61Bl7e/xVqiUx4nSuJZXgQ9H1l8Qok0WlwLPoVdeZ62NwFPCbRcrBKx/cHlNZkY/4kwQVE=
X-Received: by 2002:a6b:e206:0:b0:7c2:c967:7f17 with SMTP id
 z6-20020a6be206000000b007c2c9677f17mr4321903ioc.10.1707011065087; Sat, 03 Feb
 2024 17:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-6-david@redhat.com>
In-Reply-To: <20240202215332.118728-6-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:44:14 -0500
Message-ID: <CAFubqFtXAuwBx+1VmVCHwHyKnKRRtRuKQNeY=oqzi1qrw7uFdg@mail.gmail.com>
Subject: Re: [PATCH v1 05/15] libvhost-user: Merge
 vu_set_mem_table_exec_postcopy() into vu_set_mem_table_exec()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2b.google.com
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
> Let's reduce some code duplication and prepare for further changes.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 119 +++++++---------------
>  1 file changed, 39 insertions(+), 80 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index d5b3468e43..d9e2214ad2 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -937,95 +937,23 @@ vu_get_shared_object(VuDev *dev, VhostUserMsg *vmsg=
)
>  }
>
>  static bool
> -vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
> +vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> -    unsigned int i;
>      VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
> -    dev->nregions =3D memory->nregions;
> -
> -    DPRINT("Nregions: %u\n", memory->nregions);
> -    for (i =3D 0; i < dev->nregions; i++) {
> -        void *mmap_addr;
> -        VhostUserMemoryRegion *msg_region =3D &memory->regions[i];
> -        VuDevRegion *dev_region =3D &dev->regions[i];
> -
> -        DPRINT("Region %d\n", i);
> -        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
> -               msg_region->guest_phys_addr);
> -        DPRINT("    memory_size:     0x%016"PRIx64"\n",
> -               msg_region->memory_size);
> -        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
> -               msg_region->userspace_addr);
> -        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
> -               msg_region->mmap_offset);
> -
> -        dev_region->gpa =3D msg_region->guest_phys_addr;
> -        dev_region->size =3D msg_region->memory_size;
> -        dev_region->qva =3D msg_region->userspace_addr;
> -        dev_region->mmap_offset =3D msg_region->mmap_offset;
> +    int prot =3D PROT_READ | PROT_WRITE;
> +    unsigned int i;
>
> -        /* We don't use offset argument of mmap() since the
> -         * mapped address has to be page aligned, and we use huge
> -         * pages.
> +    if (dev->postcopy_listening) {
> +        /*
>           * In postcopy we're using PROT_NONE here to catch anyone
>           * accessing it before we userfault
>           */
> -        mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
> -                         PROT_NONE, MAP_SHARED | MAP_NORESERVE,
> -                         vmsg->fds[i], 0);
> -
> -        if (mmap_addr =3D=3D MAP_FAILED) {
> -            vu_panic(dev, "region mmap error: %s", strerror(errno));
> -        } else {
> -            dev_region->mmap_addr =3D (uint64_t)(uintptr_t)mmap_addr;
> -            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
> -                   dev_region->mmap_addr);
> -        }
> -
> -        /* Return the address to QEMU so that it can translate the ufd
> -         * fault addresses back.
> -         */
> -        msg_region->userspace_addr =3D dev_region->mmap_addr +
> -                                     dev_region->mmap_offset;
> -        close(vmsg->fds[i]);
> -    }
> -
> -    /* Send the message back to qemu with the addresses filled in */
> -    vmsg->fd_num =3D 0;
> -    if (!vu_send_reply(dev, dev->sock, vmsg)) {
> -        vu_panic(dev, "failed to respond to set-mem-table for postcopy")=
;
> -        return false;
> -    }
> -
> -    /* Wait for QEMU to confirm that it's registered the handler for the
> -     * faults.
> -     */
> -    if (!dev->read_msg(dev, dev->sock, vmsg) ||
> -        vmsg->size !=3D sizeof(vmsg->payload.u64) ||
> -        vmsg->payload.u64 !=3D 0) {
> -        vu_panic(dev, "failed to receive valid ack for postcopy set-mem-=
table");
> -        return false;
> +        prot =3D PROT_NONE;
>      }
>
> -    /* OK, now we can go and register the memory and generate faults */
> -    (void)generate_faults(dev);
> -
> -    return false;
> -}
> -
> -static bool
> -vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
> -{
> -    unsigned int i;
> -    VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
> -
>      vu_remove_all_mem_regs(dev);
>      dev->nregions =3D memory->nregions;
>
> -    if (dev->postcopy_listening) {
> -        return vu_set_mem_table_exec_postcopy(dev, vmsg);
> -    }
> -
>      DPRINT("Nregions: %u\n", memory->nregions);
>      for (i =3D 0; i < dev->nregions; i++) {
>          void *mmap_addr;
> @@ -1051,8 +979,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg=
)
>           * mapped address has to be page aligned, and we use huge
>           * pages.  */
>          mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
> -                         PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESE=
RVE,
> -                         vmsg->fds[i], 0);
> +                         prot, MAP_SHARED | MAP_NORESERVE, vmsg->fds[i],=
 0);
>
>          if (mmap_addr =3D=3D MAP_FAILED) {
>              vu_panic(dev, "region mmap error: %s", strerror(errno));
> @@ -1062,9 +989,41 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vms=
g)
>                     dev_region->mmap_addr);
>          }
>
> +        if (dev->postcopy_listening) {
> +            /*
> +             * Return the address to QEMU so that it can translate the u=
fd
> +             * fault addresses back.
> +             */
> +            msg_region->userspace_addr =3D dev_region->mmap_addr +
> +                                         dev_region->mmap_offset;
> +        }
>          close(vmsg->fds[i]);
>      }
>
> +    if (dev->postcopy_listening) {
> +        /* Send the message back to qemu with the addresses filled in */
> +        vmsg->fd_num =3D 0;
> +        if (!vu_send_reply(dev, dev->sock, vmsg)) {
> +            vu_panic(dev, "failed to respond to set-mem-table for postco=
py");
> +            return false;
> +        }
> +
> +        /*
> +         * Wait for QEMU to confirm that it's registered the handler for=
 the
> +         * faults.
> +         */
> +        if (!dev->read_msg(dev, dev->sock, vmsg) ||
> +            vmsg->size !=3D sizeof(vmsg->payload.u64) ||
> +            vmsg->payload.u64 !=3D 0) {
> +            vu_panic(dev, "failed to receive valid ack for postcopy set-=
mem-table");
> +            return false;
> +        }
> +
> +        /* OK, now we can go and register the memory and generate faults=
 */
> +        (void)generate_faults(dev);
> +        return false;
> +    }
> +
>      for (i =3D 0; i < dev->max_queues; i++) {
>          if (dev->vq[i].vring.desc) {
>              if (map_ring(dev, &dev->vq[i])) {
> --
> 2.43.0
>
>

