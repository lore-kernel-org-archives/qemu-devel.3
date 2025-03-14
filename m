Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F091DC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8uN-0006gd-KS; Fri, 14 Mar 2025 13:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8uK-0006bC-Qo
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:33:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8uF-0008Sp-Sw
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:33:16 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2239aa5da08so48501365ad.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973590; x=1742578390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lfJn8ylcc7bIMXo6FULC7ghWGBlTsQARiadKWN33xhk=;
 b=eyrOwiW95sbhlfnP7IWbdJlEOz5IuFjl4R8aKD27fVcawC2KxnxlkW6g5zyMpjhEt/
 /koenWrJQPovoVTjImzCYNWxIuto5jDQe7MG9/3JVCLFU3jkuSLVEk5R1K4QKEQR7c+l
 woluUea9E1eHMF927/P4uZ/XcO66wJaMZCooqfvSJP08VilllGjdKYE7XOPqUppfPBxh
 UB/KyXAZlwO0gY04ZE9CXFRbiXgrdc9YvN1mCTi9FZYbeahFoguAz6PMaaWqPa9ImuLO
 dgNFXMW155bCoLP9EqcPxqqbZS6ox6r4XsVzvV+BGM6jwe4pJ3G2CikAR/8F3hxwLEIt
 DWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973590; x=1742578390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lfJn8ylcc7bIMXo6FULC7ghWGBlTsQARiadKWN33xhk=;
 b=T03qEnqSV0+/xaPuqkm+5y18S3UnaWEB1QFQQE9M4zTTKC+fPexn/WyIaNjr+TlKDD
 XB89cZSHuG9l0m/yMAPclIesWreeuXLkb0vww9SuC0DzgVWR0oAARFvLfqDf09stfIPk
 xhZpKE1z0XWt8fczKNWAf5Qq7xmsrJEKs+MtPc/VABc4b2BnMp5pJgIxQvdVX/y6gSeL
 xI0NyU8qAm4unHqm6wcBOSQNtNx3tjX2ILrQsUsC+YTTQRA8Z1KaS0aWZa8xTEQ25jww
 cWE9IfRxvpsMa33wgEPo/e71hru4v7kURh9TkeSgqfiYbcw7m4O6H2TvX4lHd7RMJSOV
 7JGg==
X-Gm-Message-State: AOJu0YyfJr3Maz/8WqaGqqVSzLrR+XDTyPAi5WZP7g2k76iwU02It/kQ
 LoEDqXoU9kaD8xwuLy0AqhITRyELgce3zduno+idT1Cp9e2kMXvKHixEjIZbJMTg/koyeE4qaAi
 kGlM=
X-Gm-Gg: ASbGncuj3NtGyWLa6c4LOGehWu6xcDgiRRSRpuud0mdMpVXTlGJ2vJkF2MlelClPajV
 Z0wbVJX1iXwHgxu+VkUWomPiKh1YWmscilL48YFsVex5FIkDzbgv6AytEBBJrN93+isNGUV8fAs
 pqMlH2FGcL5jS0wKVjJM4Pj83duWqg0xjLfXYOaEfADWJhkZZlDFDgtKREo1ypdAO7/0bEs92EU
 jRhm9ctcWZasCRalrnPZRw0MywLw9papJZsfLgPTtgVS4KGm86ui79cOZl1MT6Io8ebbAPyZOaX
 HkeF+WAtW5EMW8fISCbdjyS51LP3oSPSW4Ys2J1dSetX2MH9ez3iiIA8eA==
X-Google-Smtp-Source: AGHT+IGn7+0AN3fVzzoc32npzDlWCxdUi65DSAZ1hRH63zOg5rpmzCsnUJT+UaYhzI2QTzM024e55A==
X-Received: by 2002:a17:902:da90:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-225e0afa014mr36590685ad.36.1741973590244; 
 Fri, 14 Mar 2025 10:33:10 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe4c5sm31163235ad.192.2025.03.14.10.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 10:33:09 -0700 (PDT)
Message-ID: <5951f731-b936-42eb-b3ff-bc66ef9c9414@linaro.org>
Date: Fri, 14 Mar 2025 10:33:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/17] make system memory API available for common code
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Hi,

one patch is missing review:
[PATCH v5 12/17] hw/xen: add stubs for various functions.

Regards,
Pierrick

On 3/14/25 10:31, Pierrick Bouvier wrote:
> The main goal of this series is to be able to call any memory ld/st function
> from code that is *not* target dependent. As a positive side effect, we can
> turn related system compilation units into common code.
> 
> The first 5 patches remove dependency of memory API to cpu headers and remove
> dependency to target specific code. This could be a series on its own, but it's
> great to be able to turn system memory compilation units into common code to
> make sure it can't regress, and prove it achieves the desired result.
> 
> The next patches remove more dependencies on cpu headers (exec-all,
> memory-internal, ram_addr).
> Then, we add access to a needed function from kvm, some xen stubs, and we
> finally can turn our compilation units into common code.
> 
> Every commit was tested to build correctly for all targets (on windows, linux,
> macos), and the series was fully tested by running all tests we have (linux,
> x86_64 host).
> 
> v2:
> - reorder first commits (tswap change first, so memory cached functions can use it)
> - move st/ld*_p functions to tswap instead of bswap
> - add define for target_words_bigendian when COMPILING_PER_TARGET, equals to
>    TARGET_BIG_ENDIAN (avoid overhead in target code)
> - rewrite devend_memop
> - remove useless exec-all.h in concerned patch
> - extract devend_big_endian function to reuse in system/memory.c
> - rewrite changes to system/memory.c
> 
> v3:
> - move devend functions to memory_internal.h
> - completed description for commits removing cpu.h dependency
> 
> v4:
> - rebase on top of master
>    * missing include in 'codebase: prepare to remove cpu.h from exec/exec-all.h'
>    * meson build conflict
> 
> v5:
> - remove extra xen stub xen_invalidate_map_cache()
> - edit xen stubs commit message
> 
> Pierrick Bouvier (17):
>    exec/tswap: target code can use TARGET_BIG_ENDIAN instead of
>      target_words_bigendian()
>    exec/tswap: implement {ld,st}.*_p as functions instead of macros
>    exec/memory_ldst: extract memory_ldst declarations from cpu-all.h
>    exec/memory_ldst_phys: extract memory_ldst_phys declarations from
>      cpu-all.h
>    exec/memory.h: make devend_memop "target defines" agnostic
>    codebase: prepare to remove cpu.h from exec/exec-all.h
>    exec/exec-all: remove dependency on cpu.h
>    exec/memory-internal: remove dependency on cpu.h
>    exec/ram_addr: remove dependency on cpu.h
>    system/kvm: make kvm_flush_coalesced_mmio_buffer() accessible for
>      common code
>    exec/ram_addr: call xen_hvm_modified_memory only if xen is enabled
>    hw/xen: add stubs for various functions
>    system/physmem: compilation unit is now common to all targets
>    include/exec/memory: extract devend_big_endian from devend_memop
>    include/exec/memory: move devend functions to memory-internal.h
>    system/memory: make compilation unit common
>    system/ioport: make compilation unit common
> 
>   include/exec/cpu-all.h              | 66 -----------------------
>   include/exec/exec-all.h             |  1 -
>   include/exec/memory-internal.h      | 21 +++++++-
>   include/exec/memory.h               | 30 ++++-------
>   include/exec/ram_addr.h             | 11 ++--
>   include/exec/tswap.h                | 81 +++++++++++++++++++++++++++--
>   include/system/kvm.h                |  6 +--
>   include/tcg/tcg-op.h                |  1 +
>   target/ppc/helper_regs.h            |  2 +
>   include/exec/memory_ldst.h.inc      |  4 --
>   include/exec/memory_ldst_phys.h.inc |  5 +-
>   cpu-target.c                        |  1 +
>   hw/ppc/spapr_nested.c               |  1 +
>   hw/sh4/sh7750.c                     |  1 +
>   hw/xen/xen_stubs.c                  | 51 ++++++++++++++++++
>   page-vary-target.c                  |  2 +-
>   system/ioport.c                     |  1 -
>   system/memory.c                     | 17 ++----
>   target/ppc/tcg-excp_helper.c        |  1 +
>   target/riscv/bitmanip_helper.c      |  2 +-
>   hw/xen/meson.build                  |  3 ++
>   system/meson.build                  |  6 +--
>   22 files changed, 188 insertions(+), 126 deletions(-)
>   create mode 100644 hw/xen/xen_stubs.c
> 


