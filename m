Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37669CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3HDQ-0007iN-On; Mon, 29 Sep 2025 12:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3HDP-0007hi-6A
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:59:07 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3HDK-0004CR-91
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:59:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so3596841f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759165135; x=1759769935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0S6EILPN7ffIU403Vjsy+sm3b2HrDWxSRYwj6LQPxs=;
 b=QdgO9kcjl9pYQy7DYFw+FozNBR6ytlhLJtBvhmKtUL9l2Zq9EBmQr9kK9/myrOJcCM
 n/EQqRBwwm2rbYfdBEALUsUnBGCfrZfhV86KpddgAMUzR8jpxEaheAbWooulF4uB40My
 1MsRt8EGvzjaW5x4pC6WizTiTpBbI8xd94p6fIk18Q5dh44n99P+03I2r/3M4HuSVPhU
 JPdLygXQbrGVZ7CQ9Jz8uE80dut2XtmGCOuDCQ2mWHpbf5hmuBNDk+ftd13Sc+eSvqP1
 hhOF2OdBUivSG6rjxQaV9QmeCF4prpvjZ2dfjJ4zvwoezZRVn2LA8nudb/ZyCzkh/8w3
 hmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759165135; x=1759769935;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B0S6EILPN7ffIU403Vjsy+sm3b2HrDWxSRYwj6LQPxs=;
 b=o3ost0Zs9kXrW8Kxs5smbkj8CFNy+YiZgq5MY2awMLbZU59tRFxvDvjuGThTa9AGxI
 OgczoBnxBJeK6J9kOyXwq+7ktLXYoV6V3bKOBAhKpmdUpzoqvNdp6/xlfuMjJhTVK8uA
 UamCdw3XxGDl09xu4jKoFl8+XpVIUuC4QSdCT8YbZ9EgRUxPVihZo0HytXaT3q+mUwyt
 K46yvvX92LertDVQmQkWOIXDbBIuRsA/DB/ZpWgecwKlOL7GYRZPdlWQLRPjh75JuvIT
 ZmSmQfc0Y/9PY249DsN9HenlW9GZxt8kbqdktgVXR2fLm4x2+5Vn26+5nRVk8S/0f5ux
 jBPw==
X-Gm-Message-State: AOJu0YwYKv7D4mLCdjkmzfcJIebFWzDdew1+EsC8VJDG6X7T+yyI9/ps
 GvZYynNMDpOZTQYJ9sanvdq+BRhvQUIzl5QhpQyXuCvZI2P1+05JIaX+gMbFkjGF5Nc=
X-Gm-Gg: ASbGncsR+VNuROhWTn+N1G4QpjwGAxiUvpTLaCpcYqDx2egWuB8oPORkgKK6AXD8hDl
 8hTI1a7wkWTAR90SDLi1dPnjcKbMOiZXdyRg7daSUFpWmE6c7wUuPgDPTJ9+Qz0PLdwhMfGhcfT
 7YASKauAEHRU480Y+txYQgskABsxqSrfqCcFHnl/2MahzPMVSxjmCnX5iUbotfeiGlGh53Gk21n
 oNeB3ahlzdIqTu8l7zTI82kf5eOpjinYSVIM8znKWqMPvd7Iw57NPjMcXd3djFddVquI/jcjuW7
 ab1+Y+ZVp9YT6+euJkJQ2mcdO5Su8unDCFQDste2fXo8c74bdoRybhzGzUK5Cxk4bl8kqtIs7a2
 aTJ0OuO0UeILzxFoQFzCMvDc=
X-Google-Smtp-Source: AGHT+IH2fA59YHeZ+ymUy+20ZdxLapcCSwGaTQZySF6RUlu+W+xpISnyvkhcUOy2xZVW+sXHaCiDow==
X-Received: by 2002:a5d:5f96:0:b0:3e8:f67:894f with SMTP id
 ffacd0b85a97d-42411da986cmr1265597f8f.26.1759165135585; 
 Mon, 29 Sep 2025 09:58:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb7203b8asm19257053f8f.9.2025.09.29.09.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:58:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 063085F83A;
 Mon, 29 Sep 2025 17:58:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  "Maciej S.
 Szmigiero" <maciej.szmigiero@oracle.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  kvm@vger.kernel.org,  Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/6] system/ramblock: Move ram_block_is_pmem() declaration
In-Reply-To: <20250929154529.72504-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 29 Sep 2025 17:45:25
 +0200")
References: <20250929154529.72504-1-philmd@linaro.org>
 <20250929154529.72504-3-philmd@linaro.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 29 Sep 2025 17:58:53 +0100
Message-ID: <87zfadjiuq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Move ramblock_is_pmem() along with the RAM Block API
> exposed by the "system/ramblock.h" header. Rename as
> ram_block_is_pmem() to keep API prefix consistency.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/system/ram_addr.h | 2 --
>  include/system/ramblock.h | 5 +++++
>  migration/ram.c           | 3 ++-
>  system/physmem.c          | 5 +++--
>  4 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
> index 15a1b1a4fa2..53c0c8c3856 100644
> --- a/include/system/ram_addr.h
> +++ b/include/system/ram_addr.h
> @@ -99,8 +99,6 @@ static inline unsigned long int ramblock_recv_bitmap_of=
fset(void *host_addr,
>      return host_addr_offset >> TARGET_PAGE_BITS;
>  }
>=20=20
> -bool ramblock_is_pmem(RAMBlock *rb);
> -
>  /**
>   * qemu_ram_alloc_from_file,
>   * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified back=
ing
> diff --git a/include/system/ramblock.h b/include/system/ramblock.h
> index 8999206592d..12f64fbf78b 100644
> --- a/include/system/ramblock.h
> +++ b/include/system/ramblock.h
> @@ -108,4 +108,9 @@ void ram_block_attributes_destroy(RamBlockAttributes =
*attr);
>  int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t=
 offset,
>                                        uint64_t size, bool to_discard);
>=20=20
> +/**
> + * ramblock_is_pmem: Whether the RAM block is of persistent memory

missed a rename

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> + */
> +bool ram_block_is_pmem(RAMBlock *rb);
> +
>  #endif
> diff --git a/migration/ram.c b/migration/ram.c
> index 7208bc114fb..91e65be83d8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -53,6 +53,7 @@
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
>  #include "system/cpu-throttle.h"
> +#include "system/ramblock.h"
>  #include "savevm.h"
>  #include "qemu/iov.h"
>  #include "multifd.h"
> @@ -4367,7 +4368,7 @@ static bool ram_has_postcopy(void *opaque)
>  {
>      RAMBlock *rb;
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> -        if (ramblock_is_pmem(rb)) {
> +        if (ram_block_is_pmem(rb)) {
>              info_report("Block: %s, host: %p is a nvdimm memory, postcop=
y"
>                           "is not supported now!", rb->idstr, rb->host);
>              return false;
> diff --git a/system/physmem.c b/system/physmem.c
> index ae8ecd50ea1..3766fae0aba 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -43,6 +43,7 @@
>  #include "system/kvm.h"
>  #include "system/tcg.h"
>  #include "system/qtest.h"
> +#include "system/ramblock.h"
>  #include "qemu/timer.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> @@ -1804,7 +1805,7 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t sta=
rt, ram_addr_t length)
>=20=20
>  #ifdef CONFIG_LIBPMEM
>      /* The lack of support for pmem should not block the sync */
> -    if (ramblock_is_pmem(block)) {
> +    if (ram_block_is_pmem(block)) {
>          void *addr =3D ramblock_ptr(block, start);
>          pmem_persist(addr, length);
>          return;
> @@ -3943,7 +3944,7 @@ int ram_block_discard_guest_memfd_range(RAMBlock *r=
b, uint64_t start,
>      return ret;
>  }
>=20=20
> -bool ramblock_is_pmem(RAMBlock *rb)
> +bool ram_block_is_pmem(RAMBlock *rb)
>  {
>      return rb->flags & RAM_PMEM;
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

