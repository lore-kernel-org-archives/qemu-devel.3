Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C4EC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 13:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfK01-0004g5-Uc; Wed, 28 Feb 2024 08:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rfJzt-0004bU-3V
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:29:22 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rfJzk-0006tv-4C
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:29:20 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so873691766b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709126945; x=1709731745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RThoGPXsQJc+iaAkulPIZlf4d8OxG2wbLCLs/T/k65I=;
 b=ZtfDY5iwpbOzygpKbD5Ye2+1NpwdBFe71uBPK7oHj0nzUp7okXaaXWWY+jP0z5r7N7
 aMwSESJTUUl0AD8fZ3/iExLRg/hgcqHr4MwiTxzG35CbKQBuxO90dmXrRpIIpbZcCZQh
 gBVusTL+RPkbU7Rw/k20kg2LmdiKIQyioZnAawaCjQE73VK3SmFBXFDmzBPsHwc/nh3X
 ELw9a3MATK/MdjcVpIw9P7bcOF9qqO3JmDIZyQKeRomeGA9Ftfd84Xhdhf9dyUbyDklG
 jeZKm/sQlUOIPmLZMfvhEH8S5MbfaQ+YzrokHzUwUijtlLtWEEIQRrA35bBGn8lGA+G8
 QkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709126945; x=1709731745;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RThoGPXsQJc+iaAkulPIZlf4d8OxG2wbLCLs/T/k65I=;
 b=JQt4ITaUURCEBOQU2YLKbpXMXgYaoMaohN6228Gs1tEYS4VRqrmW/0aLYq+4lCRp/2
 +a9jtNIijcB3sEZ19+bc6GOnFmbM7XtjKhzYvpOoQQUHwqVN1tDHeMz9Y/JMmBwOO/Q/
 DNdn9T7fTCMHHYq0RjDCkUxWsFWI7i9QMiNo8ckXIsKOGUi7mJFymP0OcxauGDpjN1tH
 HGycuyRDYPbVW/cIPK2bOjz15j/tmYi18RYHUk5UwV5Rqr47/7x0cluhx1/l8dQihnYO
 n8EH+pKQmpzxSQDKQ4/kBNLA3Xp5akE9Xr8ANuhoO0vKZ2PX7ggKUFL5P/U2s1uYlBUI
 nEeQ==
X-Gm-Message-State: AOJu0YzTzuZRdg8gfSbPNGdrm8MMO2PANmZOoRP1GUmrmi3xpjPzsL/u
 wdWYTby1uhMaddl2/oMuCytbtg7HqUFVw2yvvvMbAbWHDmLvWcJXRSN1TpJjVQG0ASC/bMbgGrM
 Y4xw=
X-Google-Smtp-Source: AGHT+IHi+GA6fM8na897T8RLpi+kjV7tWcmixZcPPoxbDXsOJLUwNCWZffVUw/h3kDfs+Ph4qKzvvA==
X-Received: by 2002:a17:906:4694:b0:a43:7ea2:a289 with SMTP id
 a20-20020a170906469400b00a437ea2a289mr5025299ejr.55.1709126945408; 
 Wed, 28 Feb 2024 05:29:05 -0800 (PST)
Received: from meli.delivery (adsl-245.37.6.163.tellas.gr. [37.6.163.245])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a170906bc5800b00a3efa4e033asm1850972ejv.151.2024.02.28.05.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 05:29:05 -0800 (PST)
Date: Wed, 28 Feb 2024 15:27:12 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Vikram Garhwal <vikram.garhwal@amd.com>
Cc: sstabellini@kernel.org, vikram.garhwal@amd.com, jgross@suse.com
Subject: Re: [QEMU][PATCH v3 0/7] Xen: support grant mappings.
User-Agent: meli 0.8.5-rc.3
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
In-Reply-To: <20240227223501.28475-1-vikram.garhwal@amd.com>
Message-ID: <9kisd.h00guzdfowp4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hello Vikram,

Series doesn't apply on master. Can you rebase and also provide a 
base-commit with --base=<COMMIT_SHA> when you use git-format-patch? This 
will help git rebase if there are any conflicts found locally.

Thanks,

On Wed, 28 Feb 2024 00:34, Vikram Garhwal <vikram.garhwal@amd.com> wrote:
>Hi,
>This patch series add support for grant mappings as a pseudo RAM region for Xen.
>
>Enabling grant mappings patches(first 6) are written by Juergen in 2021.
>
>QEMU Virtio device provides an emulated backends for Virtio frontned devices
>in Xen.
>Please set "iommu_platform=on" option when invoking QEMU. As this will set
>VIRTIO_F_ACCESS_PLATFORM feature which will be used by virtio frontend in Xen
>to know whether backend supports grants or not.
>
>Changelog:
>v2->v3:
>    Drop patch 1/7. This was done because device unplug is an x86-only case.
>    Add missing qemu_mutex_unlock() before return.
>v1->v2:
>    Split patch 2/7 to keep phymem.c changes in a separate.
>    In patch "xen: add map and unmap callbacks for grant" add check for total
>        allowed grant < XEN_MAX_VIRTIO_GRANTS.
>    Fix formatting issues and re-based with master latest.
>
>Regards,
>Vikram
>
>Juergen Gross (5):
>  xen: add pseudo RAM region for grant mappings
>  softmmu: let qemu_map_ram_ptr() use qemu_ram_ptr_length()
>  xen: let xen_ram_addr_from_mapcache() return -1 in case of not found
>    entry
>  memory: add MemoryRegion map and unmap callbacks
>  xen: add map and unmap callbacks for grant region
>
>Vikram Garhwal (2):
>  softmmu: physmem: Split ram_block_add()
>  hw: arm: Add grant mapping.
>
> hw/arm/xen_arm.c                |   3 +
> hw/i386/xen/xen-hvm.c           |   3 +
> hw/xen/xen-hvm-common.c         |   4 +-
> hw/xen/xen-mapcache.c           | 214 ++++++++++++++++++++++++++++++--
> include/exec/memory.h           |  21 ++++
> include/exec/ram_addr.h         |   1 +
> include/hw/xen/xen-hvm-common.h |   2 +
> include/hw/xen/xen_pvdev.h      |   3 +
> include/sysemu/xen-mapcache.h   |   3 +
> system/physmem.c                | 179 +++++++++++++++-----------
> 10 files changed, 351 insertions(+), 82 deletions(-)
>
>-- 
>2.17.1
>
>

