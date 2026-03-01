Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9099FD0068
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwhQs-0007sm-8d; Sun, 01 Mar 2026 09:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwhQh-0007rG-Pd
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:05:56 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwhQf-0007n7-UR
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:05:55 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2bdcb30fe8aso7161231eec.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772373951; x=1772978751; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JideBXed/PMqQ54+wLcVXaD2bIs/BWnrwmkUVo/rMkE=;
 b=D1ACgfCg5s4xJjuqvweRhay5OSVcrPqyFnpv63WDTR0aagp0cKN6MkDrlEOcXPors9
 IMh7Xkd7h1XSRPB31TaWAQL3fWh6igeZykt+ujr6DEFw5AlY+d2l3ffvdViAz73Ix7l1
 EZMKwewPAU/j+GGfKti7W4IxTkApq4OOhw1VHAgNmfWK28m3xRcczPy2NcuDuw0NqcM0
 CZTYUvHWpAMSWb8jcMDzY63yomRwT2y1sDDoxTxLdPNTz2ttdCnYt9MCsYRxbDtD7xtU
 7jsyKteQKms+JRu0A0e6wV4ThmQQkBzTvKmAJoXJEEZtYIxp0Cl1IPW5SmpI2XJCdi2E
 MJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772373951; x=1772978751;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JideBXed/PMqQ54+wLcVXaD2bIs/BWnrwmkUVo/rMkE=;
 b=QJ3/jVxJ0QirpO83S8zWKMOsOvBtoyFWmG/3KZYsEZJ78ZNvL3lI+wALfg0gYAWy8i
 Jir7v4wTGfnWekfhuQ1mvG3JRM97Quz0NRnuculbJcguWNamm1jtUdfBsh3a4Va5DLFr
 U+EJVXHbY41lo6q0L+eseWW/snuSxCfL/D1KqFv5uyoU0r6stO6gGq3pQa8iNG3Qvu5V
 1vaTi1dbBWSd1paKJ+NTmQHbAbZ2JMCARuPQHLjSNbiicRPgRSHJXe6Q2hJe167ak31D
 E6q0aaT2NW6RJzDM82s8JsPyECN+4F5R/tQmgpK1bazxqS24t0IpFNlu87AGH4DsEds1
 0xPg==
X-Gm-Message-State: AOJu0YzkuIZmulZC8SYbEL2p3VCmxxMoFV75wOarQJ1rAgpCj5qZr7JD
 yRbm073dQxwHaySQgb4NRmJz+KBRQgE8UPLxpPpRFSGvT5RVLYuYd+nW
X-Gm-Gg: ATEYQzyXydMUcxPGoYsLqVXXKKAAOPcu5aM0cWpdQj2bMeKU0oaXxvN3teghcDnOZp+
 G73yk67wNgeTt+OmmNL0DR1poxweVCffZempT3TJbqWuPTlUdd1uIXSSLbB2lEXChz/doXxXn/E
 URCzxh5/tEUfIUJ9ASZvszVcdD+U6IyqNQDq2sI8Zx8wdRJbGYwQRMaaw3IQ9s/6RbuPsT3e0wH
 fr4rpPCqdd8Ys7jdZ1N7tCYSD7jEHdhKZQAcAtkp24DLOzVpSjVPLGZr0h3C1azoifaaZIbzM6R
 J5/UWqj0Dxx5z//YqkcQxy/o5fZ0qMttz31b3K7coNpmbLLuPit4hJE4qmhgRJASPjj99HQW5nO
 5OjWHv4LDHB1a1Vj4znWjnoYee/6cZVREzFFPss/m3HfF1ebX0rGS1oO30G0+kP5TREnG8i3aUk
 ZSsnelKo11hBwtanSgcq6/OVADtQptzEwRpkMoP4nj+hQY7t9WJXqC5Qx9vAlpRDwOB2RJwJ32n
 r9lgiEEUcYjdMEg+usaVBDDhdGptIA=
X-Received: by 2002:a05:7300:220f:b0:2be:fe8:8aff with SMTP id
 5a478bee46e88-2be0fe8956fmr197449eec.18.1772373951423; 
 Sun, 01 Mar 2026 06:05:51 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdef9700ffsm3865065eec.28.2026.03.01.06.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:05:50 -0800 (PST)
Date: Sun, 1 Mar 2026 22:05:39 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 4/4] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Message-ID: <aaRD95XwtmZEZv8B@ZEVORN-PC.localdomain>
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227104314.81038-5-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

On Fri, Feb 27, 2026 at 11:43:14AM +0100, Philippe Mathieu-Daudé wrote:
> gdb_static_features[] only contains strings, nothing target-specific.
> Instead of generating one file per target, generate a single file
> with a single gdb_static_features[] array.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  meson.build                               | 14 --------------
>  stubs/gdbstub.c => gdbstub/gdb-xml-stub.c |  0
>  gdbstub/meson.build                       | 21 +++++++++++++++++++++
>  stubs/meson.build                         |  2 --
>  4 files changed, 21 insertions(+), 16 deletions(-)
>  rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)
> 
> diff --git a/meson.build b/meson.build
> index 56a746fed00..875a0bb1999 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4221,7 +4221,6 @@ if have_rust
>  endif
>  
>  
> -feature_to_c = find_program('scripts/feature_to_c.py')
>  rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
>  
>  if host_os == 'darwin'
> @@ -4301,19 +4300,6 @@ foreach target : target_dirs
>      endif
>    endif
>  
> -  if 'TARGET_XML_FILES' in config_target
> -    gdbstub_xml_files = []
> -    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
> -      gdbstub_xml_files += 'gdbstub/gdb-xml/' + gdbstub_xml
> -    endforeach
> -    gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
> -                                output: target + '-gdbstub-xml.c',
> -                                input: files(gdbstub_xml_files),
> -                                command: [feature_to_c, '@INPUT@'],
> -                                capture: true)
> -    arch_srcs += gdbstub_xml
> -  endif
> -
>    if target in config_target_info
>      arch_srcs += config_target_info[target]
>    else
> diff --git a/stubs/gdbstub.c b/gdbstub/gdb-xml-stub.c
> similarity index 100%
> rename from stubs/gdbstub.c
> rename to gdbstub/gdb-xml-stub.c
> diff --git a/gdbstub/meson.build b/gdbstub/meson.build
> index 15c666f5752..a25a5ae9fbf 100644
> --- a/gdbstub/meson.build
> +++ b/gdbstub/meson.build
> @@ -4,6 +4,27 @@
>  # types such as hwaddr.
>  #
>  
> +gdbstub_xml_files = []
> +foreach target : target_dirs
> +  config_target = config_target_mak[target]
> +  if 'TARGET_XML_FILES' in config_target
> +    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
> +      gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
Many XML files are shared across multiple targets. For example,
arm-core.xml appears in 5 targets (arm-softmmu, arm-linux-user,
arm-bsd-user, armeb-linux-user, arm-softmmu), riscv-64bit-fpu.xml
in 5 targets, etc.

Since there is no deduplication here, feature_to_c.py will receive
duplicate input files and generate duplicate GDBFeature entries in
gdb_static_features[]. While gdb_find_static_feature() does a
first-match linear scan so it won't break, it unnecessarily bloats
the binary.

Consider adding a dedup check:

```
    if not gdbstub_xml_files.contains('gdb-xml/' + gdbstub_xml)
      gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
    endif
```

I tested this by actually running feature_to_c.py with the collected
XML files:

==Without deduplication:==
- Total references: 171
- Unique files: 60
- Duplicates: 111 (64.91%)
- Generated file: 669 KB, 17,777 lines
- Example: arm-core.xml appears 5 times at lines 1527, 2705, 3276, 3847, 4418
  (each occurrence is 2400 bytes of identical code)

==With deduplication:==
- Generated file: 244 KB, 6,243 lines
- Space saved: 425 KB (63.57% reduction)
- No duplicate entries

---

Everything else looks good to me.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> +    endforeach
> +  endif
> +endforeach
> +if gdbstub_xml_files.length() > 0
> +  feature_to_c = find_program('../scripts/feature_to_c.py')
> +  gdbstub_xml = custom_target('gdbstub-xml.c',
> +                              output: 'gdbstub-xml.c',
> +                              input: files(gdbstub_xml_files),
> +                              command: [feature_to_c, '@INPUT@'],
> +                              capture: true)
> +else
> +  gdbstub_xml = files('gdb-xml-stub.c')
> +endif
> +common_ss.add(gdbstub_xml)
> +
>  # We build two versions of gdbstub, one for each mode
>  user_ss.add(files(
>    'gdbstub.c',
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 8a07059500d..1e0f6f47377 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -89,8 +89,6 @@ if have_system
>  endif
>  
>  if have_system or have_user
> -  stub_ss.add(files('gdbstub.c'))
> -
>    # Also included in have_system for --disable-tcg builds
>    stub_ss.add(files('replay.c'))
>  
> -- 
> 2.52.0
> 
> 

