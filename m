Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F736C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOiPy-0006Cu-TI; Mon, 09 Jun 2025 15:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiPx-0006CX-IX
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:44:25 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiPu-0004xO-IV
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:44:25 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so4029204b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749498260; x=1750103060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pY+2st/ToLH5b6RQNJZK/53AKLB35/YawHLGZTb7p90=;
 b=g3OllDTdkK9GmACfWIyAE0GIhtYqF7rFs7iPGjkpAB3tWdD6RUfECFEs/LfpZ/u40n
 MsME/qQWbm5//YIOukN3/viUBEflzOEWa2iRHNf9ap1t+K1Lwr2edSBL4gA74BBINwW5
 0tQcULDmcPew1NM2bCB/sK0K/t6j2opilNFc2CcGMc9geKXS/SN5JJjgzBLfD+SZZ9Lr
 AHBW1yy0FtSytTbqN7lPBzhUXPE8KaXi3yCvQ/RUqszqKSLwZ2h/8EDoYW6uVP1oZjJG
 9AAGOKVKd16L35ICEKDtPeA3NMlx3uu/mELGoDVhNZwNDCi9ZEKhqKEMOQdGFh6Ku6Ya
 9TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749498260; x=1750103060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pY+2st/ToLH5b6RQNJZK/53AKLB35/YawHLGZTb7p90=;
 b=ga3NqefVM82zSosax03R1bAaW3UZa4sGxIoUj1MML0QMOOG9cQWyV+VxPbM8+YqaGj
 yH59JAPW0CqiOAZC4SiYpVPs6XLn/zyNmzfdu6DKuAAi+J3kNhx/IqTDnteo1dGxMyi4
 eo/bNQVjXpPly/soM5Pt7Px3CcvMENQhX2wwYnUzl7+0Kto/46/FLVIZ7bxjBkIFLXad
 OkxMLcQQPaD5g8b7Qs8qLrFwt4F2r/brKFmnIoP6ZW3elrlPdoPQ3tLP4y1AS6IlV+ut
 Z2BZFIo22APZNm+9sJUId3nIkFl+d4+QnfqQZXcih0q44TigDnAQE5txbAkE9OIJcbrA
 YBiw==
X-Gm-Message-State: AOJu0Yxibkro0DaFT22mYr7CDH+VmFy9X71TMIMgObpprFfcfHIywXB1
 Cpg6GtdyW9lm/gHZN+UTr57Gl7ExaOJ6vIHfqPJyitTP4/O/QD5nnc9/gZk4PbSM
X-Gm-Gg: ASbGncvnRn/maiAqOYSCsZcGjf+oU2vBNbDufs7w2IKMG+b6ZbL0YQHhMj2hebau0Zi
 wOnH2G/3uirg2DREytLOaJyklEOJD0QHvXd5M6Q2M9ljftRaWDuwV+BhZcZ55bT9d4FHkFfeuf3
 risCv2vJwleNheAFYKfVkAlAoCB5SKhzTFimRiRPa2zq4fXeqsf9xvOcQcs6ZiGgtf3ABBYr3Eg
 00o6DuwKM6kBQ2ocoAbzwRcMhYxUumrVt85HjWsdHY1hNsAzCKOv3rHjyqH/r27pNsW3/I/leUl
 k2BhbkLzA3mR8fsuoG7RWt4ka8lzD+ID9bMriOzNIvfnniAXuJr56uOE+2od9ZBLdw==
X-Google-Smtp-Source: AGHT+IGGLS7j+yke/oZFl6+i6J/8F/2vmHHbROPnGTquaFL/G7VxBPJYmKl8RmpZaALjJhnKwr5WRw==
X-Received: by 2002:a05:6a00:2e07:b0:746:2c7f:b271 with SMTP id
 d2e1a72fcca58-74827e7f485mr17057910b3a.9.1749498260515; 
 Mon, 09 Jun 2025 12:44:20 -0700 (PDT)
Received: from [192.168.1.119] ([50.46.174.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482af7ab1fsm6301923b3a.54.2025.06.09.12.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 12:44:20 -0700 (PDT)
Message-ID: <f738688e-7d02-47c5-bac6-82b21474f768@gmail.com>
Date: Mon, 9 Jun 2025 12:44:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/8] Add additional plugin API functions to read and
 write memory and registers
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
References: <20250609192342.316156-1-rowanbhart@gmail.com>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <20250609192342.316156-1-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42d.google.com
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

I forgot one additional update here that was necessary because the 
plugin_cb_flags getter/setters are now on the hot path and need 
inlining, and left a typo, both of which I fixed in v11 
(https://lore.kernel.org/qemu-devel/20250609193841.348076-1-rowanbhart@gmail.com/T/#t). 


On 6/9/25 12:23 PM, Rowan Hart wrote:
> This patch series adds several new API functions focused on enabling use
> cases around reading and writing guest memory from QEMU plugins. To support
> these new APIs, some utility functionality around retrieving information about
> address spaces is added as well.
>
> The new qemu_plugin_write_register utilizes gdb_write_register, which is now
> declared in gdbstub.h for this purpose instead of being static.
>
> qemu_plugin_write_memory_vaddr utilizes cpu_memory_rw_debug much the same as
> the existing read_memory_vaddr function does.
>
> The read and write_hwaddr functions are the most different. These functions
> use address_space_rw, which works well in most cases. There is an important
> caveat that for writes, the page being written will be set dirty by the
> write operation. This dirty setting requires locking the page range,
> which can contend with an already held lock in page_collection_lock
> when called in a tb translate callback with a write to the instruction
> memory in the tb. The doc comments warn against doing this, and it's unlikely
> anyone would want to do this.
>
> I've also added two test plugins: one that implements a simple hypercall
> interface that guest code can use to communicate with the plugin in a
> structured way with a test to ensure that this hypercall works and writing
> virtual memory works. And one that implements a simple patch utility to patch
> memory at runtime. The test for the second plugin ensures the patch applies
> successfully to instruction memory, and can use both hw and vaddr methods.
>
> For v3, I've had a few comments from the last submission that I've addressed,
> and some that I haven't for one reason or another:
>
> - Enforce QEMU_PLUGIN_CB_ flags in register read/write operations: done!
> - Fix my commit messages and add long messages describing commits: done!
> - Un-expose AS internals: done! Functions operate on current vCPU, current AS.
> - Clean up use of current_cpu: done!
> - Make functions take a vcpu_idx: not done. May revisit but it allows footguns.
>    Even for translation, seems best to not do this now. We can easily add _vcpu
>    versions of these functions in the future if we change our minds!
>
> For v5, I've just updated the enforcement of the QEMU_PLUGIN_CB_ flags to just
> use immediate stores, which simplifies the implementation quite a lot and
> should be more efficient too. Thanks Pierrick for the suggestion!
>
> v6 is a formatting pass, I left some whitespace that needed removal, some
> license text was wrong, and so forth.
>
> v8 reverts a mistake I made extending the size of arrays of TCGHelperInfo
> structs, as I misunderstood their sizes. It preserves adding an explicit
> zero as the last entry for clarity, however.
>
> v9 fixes qemu_plugin_read_register to return -1 on parameter or flag state
> error instead of 0.
>
> In v10, I relaxed the restriction on when the register r/w functions can be
> called, allowing all them to be used from any callback where the CPU is not
> currently executing, with additional notes in the documentation for exceptions
> (atexit and flush, which do not operate on a specific CPU and in which
> current_cpu is not set).
>
> Rowan Hart (1):
>    plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
>      callbacks
>
> novafacing (7):
>    gdbstub: Expose gdb_write_register function to consumers of gdbstub
>    plugins: Add register write API
>    plugins: Add memory virtual address write API
>    plugins: Add memory hardware address read/write API
>    plugins: Add patcher plugin and test
>    plugins: Add hypercalls plugin and test
>    plugins: Update plugin version and add notes
>
>   accel/tcg/plugin-gen.c                        |  30 +
>   gdbstub/gdbstub.c                             |   2 +-
>   include/exec/gdbstub.h                        |  14 +
>   include/hw/core/cpu.h                         |   1 +
>   include/qemu/plugin.h                         |   6 +
>   include/qemu/qemu-plugin.h                    | 176 +++++-
>   plugins/api.c                                 | 135 ++++-
>   plugins/core.c                                |  45 ++
>   tests/tcg/Makefile.target                     |   2 +
>   tests/tcg/plugins/hypercalls.c                | 547 ++++++++++++++++++
>   tests/tcg/plugins/meson.build                 |   2 +-
>   tests/tcg/plugins/patch.c                     | 297 ++++++++++
>   tests/tcg/x86_64/Makefile.softmmu-target      |  36 +-
>   tests/tcg/x86_64/system/hypercalls-target.c   |  40 ++
>   tests/tcg/x86_64/system/patch-target.c        |  27 +
>   .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
>   tests/tcg/x86_64/system/validate-patch.py     |  39 ++
>   17 files changed, 1416 insertions(+), 23 deletions(-)
>   create mode 100644 tests/tcg/plugins/hypercalls.c
>   create mode 100644 tests/tcg/plugins/patch.c
>   create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
>   create mode 100644 tests/tcg/x86_64/system/patch-target.c
>   create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
>   create mode 100755 tests/tcg/x86_64/system/validate-patch.py
>

