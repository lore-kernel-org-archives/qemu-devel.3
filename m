Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244F1C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJxY-0005ky-KI; Sat, 18 Jan 2025 20:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tZJxJ-0005SQ-Qh
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:18:27 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tZJxH-0004Dp-Dt
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:18:25 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e54bd61e793so6131121276.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1737249500; x=1737854300;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=985gn5VKLm1na1Rz/v5v/J8lTY200Hc3oVQBJYSyBiY=;
 b=Hcz3JLdEVB4HdbD4gBP1+1KBZbPSXG6NjBcrqb8/t/VCRpzVMAdO1AVpVbBsB3lf0Z
 jZ9ry25hEJW1kvVH7NNtXWEJCgqpmJWANZWW2EW8VZvxz2DuRqaDEqnyNz5yScT62e82
 mBQXEWK82F2ND3RWZLpGkpU/oALnqe9+QhClpq4b2hNvxw++DfkZSS+DI+JiBzbDnYKo
 Rk5+nN1Dq9QLFKRsLL9a+KhaiMbDEBphMftMT3aEWyxcInFA7gJKNNVSZUDcEH64+bqe
 otbE0yG19hK4yWoQKNLFbbTzBK7Ex13KBeZ0tq5G5pGg/vHm66I5BpiryG4xHLvglGTm
 4cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249500; x=1737854300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=985gn5VKLm1na1Rz/v5v/J8lTY200Hc3oVQBJYSyBiY=;
 b=jFFxQUhazBJmM0k3azapU4jTnuqAdcjv66Ee1KiMap6X6o1ag3eOg4F6u6QjxSIB0C
 qW1oVBDetELasEfrjE14NBOC5YyAwYYpnQFgX0ZMeCe7YRUtHNNZSd/b24Ig+6MH00RK
 kGbuAsKscBEtbFbQm8PWCR4FogmzRN9+66JqZavkPp9FrV8tFnZrTlHGKjUf8b66IykI
 PXbhddMFhgFxwB7QHQfK13UEOmMTVhyLk0rGr+Ih5hcu6bdXhP6xxCBVO2TO8h4u3YK0
 KrM9csmmE7779yzck8JD1Qu35Y9CyX3X34wK97N1H3H5jk2nNvhw96E4L7SQb+emCeoN
 gSfA==
X-Gm-Message-State: AOJu0YxF6KEOeuHVJqyXbojBr7tClV1JfAanC9VpDUMSw+0NvL8BlsuT
 wgxo8NE2t92PMulOttrPfyFDcs7t5YxiTczJbGXv5gTTA2BBa2UcCvapEub9D2uhPmsC76JtF3X
 xKXaCMvoxqaexTxz5GG4YGntgJo+P67pj+JAcHQ==
X-Gm-Gg: ASbGncu3ACcownkm6g0Q7vxuCWoQ+l8stU+YJpnb02r91Tg+Q9YoRRVwVHb8SBg4AGx
 Hxc7ZbfBgmNrC+PnulIU2I0I9ttzbWvsBEDI3XqzAcM/jaY3SvWM=
X-Google-Smtp-Source: AGHT+IH3AB0n0YAna4gORyVdLIQY1Z44FFoulnCzj1X1YGXTlx4qNm/lV+4JdqaMZaQi7Icy2ZGBBiPNw7vmZ36QYgA=
X-Received: by 2002:a05:6902:10c6:b0:e54:bc9f:a7fe with SMTP id
 3f1490d57ef6-e57b105690emr6650298276.20.1737249499775; Sat, 18 Jan 2025
 17:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20250117171337.91730-1-philmd@linaro.org>
In-Reply-To: <20250117171337.91730-1-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 18 Jan 2025 18:18:07 -0700
X-Gm-Features: AbW1kvYnTXNNzcuhlTLfqdOdFcTxzLUHHxP1Rn9hFWrm-aU8gDks6khsLumr35c
Message-ID: <CANCZdfo1EzKKSVp0CHgm1Qci38U57rjpizcoWVnuThWFNegnJw@mail.gmail.com>
Subject: Re: [PATCH] user: Extract common MMAP API to 'user/mmap.h'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="00000000000052225e062c04eb8a"
Received-SPF: none client-ip=2607:f8b0:4864:20::b32;
 envelope-from=wlosh@bsdimp.com; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000052225e062c04eb8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 10:13=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> Keep common MMAP-related declarations in a single place.
>
> Note, this disable ThreadSafetyAnalysis on Linux for:
> - mmap_fork_start()
> - mmap_fork_end().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  bsd-user/qemu.h        | 12 +-----------
>  include/user/mmap.h    | 33 +++++++++++++++++++++++++++++++++
>  linux-user/user-mmap.h | 19 ++-----------------
>  3 files changed, 36 insertions(+), 28 deletions(-)
>  create mode 100644 include/user/mmap.h
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

There's actually rather a lot of things like this since the code lineages
are rather
common and co-evolved between bsd-user and linux-user.

Warner


> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 3eaa14f3f56..a451d80a4db 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -32,6 +32,7 @@
>  extern char **environ;
>
>  #include "user/thunk.h"
> +#include "user/mmap.h"
>  #include "target_arch.h"
>  #include "syscall_defs.h"
>  #include "target_syscall.h"
> @@ -234,19 +235,8 @@ void print_taken_signal(int target_signum, const
> target_siginfo_t *tinfo);
>  extern int do_strace;
>
>  /* mmap.c */
> -int target_mprotect(abi_ulong start, abi_ulong len, int prot);
> -abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
> -                     int flags, int fd, off_t offset);
> -int target_munmap(abi_ulong start, abi_ulong len);
> -abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
> -                       abi_ulong new_size, unsigned long flags,
> -                       abi_ulong new_addr);
>  int target_msync(abi_ulong start, abi_ulong len, int flags);
> -extern abi_ulong mmap_next_start;
> -abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
>  void mmap_reserve(abi_ulong start, abi_ulong size);
> -void TSA_NO_TSA mmap_fork_start(void);
> -void TSA_NO_TSA mmap_fork_end(int child);
>
>  /* main.c */
>  extern char qemu_proc_pathname[];
> diff --git a/include/user/mmap.h b/include/user/mmap.h
> new file mode 100644
> index 00000000000..93476a159d0
> --- /dev/null
> +++ b/include/user/mmap.h
> @@ -0,0 +1,33 @@
> +/*
> + * MMAP declarations for QEMU user emulation
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef USER_MMAP_H
> +#define USER_MMAP_H
> +
> +#include "qemu/clang-tsa.h"
> +#include "exec/user/abitypes.h"
> +
> +/*
> + * mmap_next_start: The base address for the next mmap without hint,
> + * increased after each successful map, starting at task_unmapped_base.
> + * This is an optimization within QEMU and not part of ADDR_COMPAT_LAYOU=
T.
> + */
> +extern abi_ulong mmap_next_start;
> +
> +int target_mprotect(abi_ulong start, abi_ulong len, int prot);
> +
> +abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
> +                     int flags, int fd, off_t offset);
> +int target_munmap(abi_ulong start, abi_ulong len);
> +abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
> +                       abi_ulong new_size, unsigned long flags,
> +                       abi_ulong new_addr);
> +
> +abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
> +
> +void TSA_NO_TSA mmap_fork_start(void);
> +void TSA_NO_TSA mmap_fork_end(int child);
> +
> +#endif
> diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
> index b94bcdcf83c..dfc4477a720 100644
> --- a/linux-user/user-mmap.h
> +++ b/linux-user/user-mmap.h
> @@ -18,6 +18,8 @@
>  #ifndef LINUX_USER_USER_MMAP_H
>  #define LINUX_USER_USER_MMAP_H
>
> +#include "user/mmap.h"
> +
>  /*
>   * Guest parameters for the ADDR_COMPAT_LAYOUT personality
>   * (at present this is the only layout supported by QEMU).
> @@ -39,24 +41,7 @@
>  extern abi_ulong task_unmapped_base;
>  extern abi_ulong elf_et_dyn_base;
>
> -/*
> - * mmap_next_start: The base address for the next mmap without hint,
> - * increased after each successful map, starting at task_unmapped_base.
> - * This is an optimization within QEMU and not part of ADDR_COMPAT_LAYOU=
T.
> - */
> -extern abi_ulong mmap_next_start;
> -
> -int target_mprotect(abi_ulong start, abi_ulong len, int prot);
> -abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
> -                     int flags, int fd, off_t offset);
> -int target_munmap(abi_ulong start, abi_ulong len);
> -abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
> -                       abi_ulong new_size, unsigned long flags,
> -                       abi_ulong new_addr);
>  abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice);
> -abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
> -void mmap_fork_start(void);
> -void mmap_fork_end(int child);
>
>  abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
>                         abi_ulong shmaddr, int shmflg);
> --
> 2.47.1
>
>

--00000000000052225e062c04eb8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 17,=
 2025 at 10:13=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto=
:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Keep common MMAP-related declarations =
in a single place.<br>
<br>
Note, this disable ThreadSafetyAnalysis on Linux for:<br>
- mmap_fork_start()<br>
- mmap_fork_end().<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 +-----------<br>
=C2=A0include/user/mmap.h=C2=A0 =C2=A0 | 33 +++++++++++++++++++++++++++++++=
++<br>
=C2=A0linux-user/user-mmap.h | 19 ++-----------------<br>
=C2=A03 files changed, 36 insertions(+), 28 deletions(-)<br>
=C2=A0create mode 100644 include/user/mmap.h<br></blockquote><div><br></div=
><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bs=
dimp.com</a>&gt;</div><div><br></div><div>There&#39;s actually rather a lot=
 of things like this since the code lineages are rather</div><div>common an=
d co-evolved between bsd-user and linux-user.</div><div><br></div><div>Warn=
er</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
index 3eaa14f3f56..a451d80a4db 100644<br>
--- a/bsd-user/qemu.h<br>
+++ b/bsd-user/qemu.h<br>
@@ -32,6 +32,7 @@<br>
=C2=A0extern char **environ;<br>
<br>
=C2=A0#include &quot;user/thunk.h&quot;<br>
+#include &quot;user/mmap.h&quot;<br>
=C2=A0#include &quot;target_arch.h&quot;<br>
=C2=A0#include &quot;syscall_defs.h&quot;<br>
=C2=A0#include &quot;target_syscall.h&quot;<br>
@@ -234,19 +235,8 @@ void print_taken_signal(int target_signum, const targe=
t_siginfo_t *tinfo);<br>
=C2=A0extern int do_strace;<br>
<br>
=C2=A0/* mmap.c */<br>
-int target_mprotect(abi_ulong start, abi_ulong len, int prot);<br>
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int flags, int fd, off_t offset);<br>
-int target_munmap(abi_ulong start, abi_ulong len);<br>
-abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abi_ulong new_size, unsigned long flags,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abi_ulong new_addr);<br>
=C2=A0int target_msync(abi_ulong start, abi_ulong len, int flags);<br>
-extern abi_ulong mmap_next_start;<br>
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);<br>
=C2=A0void mmap_reserve(abi_ulong start, abi_ulong size);<br>
-void TSA_NO_TSA mmap_fork_start(void);<br>
-void TSA_NO_TSA mmap_fork_end(int child);<br>
<br>
=C2=A0/* main.c */<br>
=C2=A0extern char qemu_proc_pathname[];<br>
diff --git a/include/user/mmap.h b/include/user/mmap.h<br>
new file mode 100644<br>
index 00000000000..93476a159d0<br>
--- /dev/null<br>
+++ b/include/user/mmap.h<br>
@@ -0,0 +1,33 @@<br>
+/*<br>
+ * MMAP declarations for QEMU user emulation<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+#ifndef USER_MMAP_H<br>
+#define USER_MMAP_H<br>
+<br>
+#include &quot;qemu/clang-tsa.h&quot;<br>
+#include &quot;exec/user/abitypes.h&quot;<br>
+<br>
+/*<br>
+ * mmap_next_start: The base address for the next mmap without hint,<br>
+ * increased after each successful map, starting at task_unmapped_base.<br=
>
+ * This is an optimization within QEMU and not part of ADDR_COMPAT_LAYOUT.=
<br>
+ */<br>
+extern abi_ulong mmap_next_start;<br>
+<br>
+int target_mprotect(abi_ulong start, abi_ulong len, int prot);<br>
+<br>
+abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int flags, int fd, off_t offset);<br>
+int target_munmap(abi_ulong start, abi_ulong len);<br>
+abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abi_ulong new_size, unsigned long flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abi_ulong new_addr);<br>
+<br>
+abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);<br>
+<br>
+void TSA_NO_TSA mmap_fork_start(void);<br>
+void TSA_NO_TSA mmap_fork_end(int child);<br>
+<br>
+#endif<br>
diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h<br>
index b94bcdcf83c..dfc4477a720 100644<br>
--- a/linux-user/user-mmap.h<br>
+++ b/linux-user/user-mmap.h<br>
@@ -18,6 +18,8 @@<br>
=C2=A0#ifndef LINUX_USER_USER_MMAP_H<br>
=C2=A0#define LINUX_USER_USER_MMAP_H<br>
<br>
+#include &quot;user/mmap.h&quot;<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Guest parameters for the ADDR_COMPAT_LAYOUT personality<br>
=C2=A0 * (at present this is the only layout supported by QEMU).<br>
@@ -39,24 +41,7 @@<br>
=C2=A0extern abi_ulong task_unmapped_base;<br>
=C2=A0extern abi_ulong elf_et_dyn_base;<br>
<br>
-/*<br>
- * mmap_next_start: The base address for the next mmap without hint,<br>
- * increased after each successful map, starting at task_unmapped_base.<br=
>
- * This is an optimization within QEMU and not part of ADDR_COMPAT_LAYOUT.=
<br>
- */<br>
-extern abi_ulong mmap_next_start;<br>
-<br>
-int target_mprotect(abi_ulong start, abi_ulong len, int prot);<br>
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int flags, int fd, off_t offset);<br>
-int target_munmap(abi_ulong start, abi_ulong len);<br>
-abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abi_ulong new_size, unsigned long flags,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abi_ulong new_addr);<br>
=C2=A0abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice=
);<br>
-abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);<br>
-void mmap_fork_start(void);<br>
-void mmap_fork_end(int child);<br>
<br>
=C2=A0abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 abi_ulong shmaddr, int shmflg);<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div></div>

--00000000000052225e062c04eb8a--

