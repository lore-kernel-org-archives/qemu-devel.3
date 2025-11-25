Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C1FD0E6E5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNtfE-0004Zq-5Q; Tue, 25 Nov 2025 09:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1vNtf5-0004Oe-50
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:04:56 -0500
Received: from 6.mo552.mail-out.ovh.net ([188.165.49.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1vNtf2-0007T4-76
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:04:54 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.85])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dG4FV4H7vz5xRv;
 Tue, 25 Nov 2025 14:04:46 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 25 Nov
 2025 15:04:45 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0018e89a7fe-59d6-4cf1-9701-9a3a8f183cb1,
 F44D14359D3F567D284CF0746F87853B98EDC426) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 25 Nov 2025 15:04:44 +0100
From: Greg Kurz <groug@kaod.org>
To: Andrey Erokhin <language.lawyer@gmail.com>
CC: <qemu-devel@nongnu.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2] 9pfs: local: read native symlinks when
 security-model=mapped
Message-ID: <20251125150444.5deb5195@bahia>
In-Reply-To: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
References: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: c1a2db8f-cc64-42c1-b64c-b37c2f96c0e3
X-Ovh-Tracer-Id: 13222005557175294429
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTE1bn9scKouKQnYlDgMkP/ir1I7DPedxqI2zKx3BzeQPNTTtoXCqC1rgBrpEBL9W4mx62Eqcq9jWN6hg6+d45DjRYQ6bBUGLxK5PO/eS/mDl8Rg2wgWyJil+Cx8LOF4H/k7zjGjejkLorOPNyPjqeHSw4iVll7vOoKYx58xOhI23XVKslgQVY2DCqQvqAAGqV4kS/RudgpJZi7tItVxthD/oq5g00iyxEnR2I1o4wbFVxLvVjCZ4B2pnMO0x8uYOtlxxLzU5UoOGjdJwbnz9+BNif7RwRlm7ch8Ijyo5kD402dr6gGwjXH4fuT8d/cLnxLV4oGXbeSH70D1Df4L1KM5CsnSPTFF3TioW2fdJ0FBr5tZ8L/A8qlBwbmq9hAuDYGNCbq2U7VGNRyv4es4PkJACoM/YbA/hwDNHUtBWGvTVIvNuduLal3PF7lso//+DCrOYFNr48I5RyPN+5adzsMSE5Tf4NWKRuicHKsntY1bWDdFLfIpDrQUDqQ22k62nppEMO+Dnlbq+/i0oyVdrvN9KLm6Qtbz1DYBVNzGqlpS1pgmaihX0shxtwhjYleZmxxzt5B3//cNoCdyjzqTEP7RbxvQk/ES8ROJjshiFrQk8gGvklI0JpUDFWp51UVKKVMH20xC1ovGGQc5eVvQ4ZXAHhY9t8scKvfvMYF+OSlojg
DKIM-Signature: a=rsa-sha256; bh=owu/7ET1a/nR4XnB9a+iTG5NCLOtE87raVIZfOuIlKk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1764079487; v=1;
 b=NRvcopIdMx/bWQkynat3Fp5Ptj7Q3MTg/XNPnDheRSbrhw/4hqDBVzlUc30Zq3XpLusEC+z9
 rIq3pKdh1BWred214GW1W06XsotdFG0BTTE3a4b4K804imjHM1iWM1dea08PCkXw0IS3VOspEj+
 0OtzEVT13+jTqxA1x7hhplpY7L1Syy1kCNgDuaP1PrGXOdujHEshPa9cq7yVB7CqGIiwOV248/t
 hgC64xoMPRM1EAcIUcB1gerSl8DJJjdRRj3qpWb19gfTza/klH37w5V2ecepbqjYPU55btUp0+h
 MHWdwC1CTI4XSgHoBC0bfbTthzTErHRofaJU6LLzFjASw==
Received-SPF: pass client-ip=188.165.49.222; envelope-from=groug@kaod.org;
 helo=6.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sun, 23 Nov 2025 01:19:09 +0500
Andrey Erokhin <language.lawyer@gmail.com> wrote:

> Directories attached using virtfs with security-model=mapped
> may contain native symlinks
> 
> This can happen e.g. when booting from a rootfs directory tree
> (usually with a writable overlay set up on the host side)
> 
> Currently, when security-model=mapped[-xattr|-file],
> QEMU assumes that host-side "symlinks" are in the mapped format,
> i.e. are regular files storing the linked path,

This looks like an unfortunate design choice to start with. The mapped-xattr
mode was introduced to cache client-side uids/gids/mode in extended attributes.
Since there was no support in linux to set extended attributes on symlinks at
the time, 879c28133dfa ("virtio-9p: Security model for symlink and readlink")
opted to convert client originated symlinks into regular files.

A better choice would probably have been to leave symlinks as is and to cache
the metadata in a separate file, a bit like what the mapped-file does.

> so it tries to open with O_NOFOLLOW
> and fails with ELOOP on native symlinks
> 
> This patch introduces a fallback for such cases:
> reuse security-model=[none|passthrough] else if branch logic
> where readlink will be called for the path basename
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/173
> 
> Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
> ---
>  hw/9pfs/9p-local.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 6230466de1..ddf111b674 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -474,12 +474,16 @@ static ssize_t local_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
>  
>          fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
>          if (fd == -1) {
> +            if (errno == ELOOP) {
> +                goto native_symlink;
> +            }
>              return -1;
>          }
>          tsize = RETRY_ON_EINTR(read(fd, (void *)buf, bufsz));
>          close_preserve_errno(fd);
>      } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
>                 (fs_ctx->export_flags & V9FS_SM_NONE)) {
> +    native_symlink:;

Still has the terminating but unneeded semicolon. With that fixed,

Reviewed-by: Greg Kurz <groug@kaod.org>

>          char *dirpath = g_path_get_dirname(fs_path->data);
>          char *name = g_path_get_basename(fs_path->data);
>          int dirfd;



-- 
Greg

