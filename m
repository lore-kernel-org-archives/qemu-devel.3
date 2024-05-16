Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D6FC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 11:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ZXn-0005YN-5K; Thu, 16 May 2024 07:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7ZXh-0005X3-ES
 for qemu-devel@nongnu.org; Thu, 16 May 2024 07:45:02 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7ZXb-0005QT-Gt
 for qemu-devel@nongnu.org; Thu, 16 May 2024 07:45:01 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e564cad1f1so8652641fa.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715859892; x=1716464692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QfveQ8TCc+NJIfycf7i1lNOa0m/PfDLwSdfgcNXfcHY=;
 b=uIEcYsp4sJrJfZ05SVHxwY/mrxiVNyLIGQhDp7q/U89BIsgpnd6OWb+ISDarh8oY4y
 vTu3tymC2nX+U2QcV1kDlJJh+s9ufla/9kOnp3wa+SXn9zfyA3z8C0ZFtXLDa2F0wUaD
 3VURaQeu+tl6GuQBjJt7bX5Fpi95Og/Dnm+M9rMjTxgpDYeSVvJ2KhbubCq5/JQ6x0Re
 So43EIFGG96LuOS4g0O14+3RjFeAdMTUzLiCwaWqu7WRyXBZvX3qKQkMYr236j7fRDTF
 nRs1aDyRlStBDuxpDZbjtZZWzCyDzKKIaE6vC+tASaXnPcjsH/1H2EUFjcLeUOlWdOAN
 wdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715859892; x=1716464692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QfveQ8TCc+NJIfycf7i1lNOa0m/PfDLwSdfgcNXfcHY=;
 b=d7DLXNobd4xU/F38ESL5c3VrkyNdHuWI6slsyRk2VVSpKE3v8a/vjA/484yd00OY0P
 IB8CDH6SbGFevjfVxy7c0SGHF5psXaJhkRkXxmGNMsROIByfEIbGXaStdIpQR/DL2dMq
 vJkIdGvOQjXLf9EdE9qH4BAMP9W3jDWYz4BuvrkkMCnOlOlcGK6WFnrzKkYgS9OR2+de
 kgCFwYSUNYzxzOWi7kM7rgvobOVuIYjl3wa0Wwuom2l887SQCw6QqN+paAqzDCnftZ7q
 mKeeBTwwYXhe3TB6g+gSdHHw6p0tcWEZcZdPWYzzqECDVVJj4mH1QUgxEpsFvlZ7NwKb
 gUXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb+KUb6jzmcDmKTXYenU029Q1fWKrqVELBNCvEbMHWcJK0xTAfPwPUULV396bXBtqLIALiB5CYAS/PFTa0VGRp/hBiiJQ=
X-Gm-Message-State: AOJu0YyoPR+nNKshD++QSLXwYXtJSeBVws9hUFEpnv7ayfGs70b3hG9Z
 F4C01HSHpF9yt3VHpuQU+nsps6gCnNO1dlo/1iSIL3lwU3EL9cCDr1lQMyGrbb4=
X-Google-Smtp-Source: AGHT+IEya0h5c04+6USyS8LApzHZ7T0wYd+jwpdT67pqkHCa0m2fANM4rkAqAIJTZFoUA08e3MtFlg==
X-Received: by 2002:a2e:9253:0:b0:2e2:a0f0:4e74 with SMTP id
 38308e7fff4ca-2e5203a44b5mr112104411fa.52.1715859892461; 
 Thu, 16 May 2024 04:44:52 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce25casm265628935e9.20.2024.05.16.04.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 04:44:52 -0700 (PDT)
Message-ID: <1fa17776-4711-44d6-8ace-a15c7c8a56c7@linaro.org>
Date: Thu, 16 May 2024 13:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] gdbstub: Add support for MTE in user mode
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
 <20240515173132.2462201-3-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240515173132.2462201-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/15/24 19:31, Gustavo Romero wrote:
> +static int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    assert(reg == 0);
> +
> +    /* Sanitize TCF0 bits. */
> +    *buf &= 0x03;
> +
> +    if (!isar_feature_aa64_mte3(&cpu->isar) && *buf == 3) {

cpu_isar_feature(aa64_mte3, cpu)


> +        /*
> +         * If FEAT_MTE3 is not implemented, the value 0b11 is reserved, hence
> +         * ignore setting it.
> +         */
> +        return 0;

That said, we always implement the mte3 behaviour, so perhaps drop this entirely?

> +    }
> +
> +    /*
> +     * 'tag_ctl' register is actually a "pseudo-register" provided by GDB to
> +     * expose options that can be controlled at runtime and has the same effect
> +     * of prctl() with option PR_SET_TAGGED_ADDR_CTRL,
> +     * i.e. prctl(PR_SET_TAGGED_ADDR_CTRL, tcf, 0, 0, 0), hence it controls
> +     * the effect of Tag Check Faults (TCF) due to Loads and Stores in EL0.
> +     */
> +    env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, *buf);
> +
> +    return 1;
> +}
> +
> +static void handle_q_memtag(GArray *params, G_GNUC_UNUSED void *user_ctx)
> +{
> +    uint64_t addr = get_param(params, 0)->val_ull;
> +    uint64_t len = get_param(params, 1)->val_ul;
> +    int type = get_param(params, 2)->val_ul;
> +
> +    uint64_t clean_addr;
> +    uint8_t *tags;
> +    int granules_index;
> +    int granule_index;
> +    uint8_t addr_tag;
> +
> +    g_autoptr(GString) str_buf = g_string_new(NULL);
> +
> +    /*
> +     * GDB does not query tags for a memory range on remote targets, so that's
> +     * not supported either by gdbstub.
> +     */
> +    if (len != 1) {
> +        gdb_put_packet("E02");
> +    }
> +
> +    /* GDB never queries a tag different from an allocation tag (type 1). */
> +    if (type != 1) {
> +        gdb_put_packet("E02");
> +    }
> +
> +    /* Remove any non-addressing bits. */
> +    clean_addr = useronly_clean_ptr(addr);
> +
> +    /*
> +     * Get pointer to all tags in the page where the address is. Note that tags
> +     * are packed, so there are 2 tags packed in one byte.
> +     */
> +    tags = page_get_target_data(clean_addr);

While you expect gdb will have called isaddresstagged first, you can't guarantee that:
you should verify that the address is valid and tagged first.

> +static void handle_q_isaddresstagged(GArray *params, G_GNUC_UNUSED void *user_ctx)
> +{
> +    uint64_t addr = get_param(params, 0)->val_ull;
> +
> +    uint64_t clean_addr;
> +    int mflags;
> +
> +    g_autoptr(GString) str_buf = g_string_new(NULL);
> +
> +    /* Remove any non-addressing bits. */
> +    clean_addr = useronly_clean_ptr(addr);
> +
> +    mflags = page_get_flags(clean_addr);
> +    if (mflags & PAGE_ANON && mflags & PAGE_MTE) {
> +        /* Address is tagged. */
> +        g_string_printf(str_buf, "%.2x", 1 /* true */);
> +    } else {
> +        /* Address is not tagged. */
> +        g_string_printf(str_buf, "%.2x", 0 /* false */);
> +    }
> +
> +    gdb_put_packet(str_buf->str);

Overkill with GString?

     const char *result = (mflags & PAGE_ANON && mflags & PAGE_MTE ? "1" : "0");
     gdb_put_packet(result);

?

> +}
> +
> +static void handle_Q_memtag(GArray *params, G_GNUC_UNUSED void *user_ctx)
> +{
> +    uint64_t addr = get_param(params, 0)->val_ull;
> +    uint64_t len = get_param(params, 1)->val_ul;
> +    int type = get_param(params, 2)->val_ul;
> +    char const *new_tags = get_param(params, 3)->data;
> +
> +    uint64_t clean_addr;
> +    int last_addr_index;
> +
> +    uint64_t start_addr_page;
> +    uint64_t end_addr_page;
> +
> +    uint32_t first_tag_index;
> +    uint32_t last_tag_index;
> +
> +    uint8_t *tags; /* Pointer to the current tags in a page. */
> +    int num_new_tags;
> +
> +    g_autoptr(GString) str_buf = g_string_new(NULL);
> +
> +    /*
> +     * Only the allocation tag (type 1) can be set at the stub side.
> +     */
> +    if (type != 1) {
> +        gdb_put_packet("E02");
> +        return;
> +    }
> +
> +    /*
> +     * 'len' is always >= 1 and refers to the size of the memory range about to
> +     * have its tags updated. However, it's convenient to obtain the index for
> +     * the last byte of the memory range for page boundary checks and for
> +     * obtaining the indexes for the tags in the page.
> +     */
> +    last_addr_index = len - 1;
> +
> +    /* Remove any non-addressing bits. */
> +    clean_addr = useronly_clean_ptr(addr);
> +
> +    start_addr_page = extract64(clean_addr, TARGET_PAGE_BITS,
> +                                64 - TARGET_PAGE_BITS);
> +    end_addr_page = extract64(clean_addr + last_addr_index, TARGET_PAGE_BITS,
> +                              64 - TARGET_PAGE_BITS);
> +
> +    /*
> +     * Check if memory range is within page boundaries.
> +     */
> +    if (start_addr_page != end_addr_page) {
> +        gdb_put_packet("E03");
> +        return;
> +    }
> +
> +    /*
> +     * Get pointer to all tags in the page where the address is. Note that here
> +     * tags are packed, so there are 2 tags packed in one byte.
> +     */
> +    tags = page_get_target_data(clean_addr);

Likewise.

> +
> +    /* Tag indices below refer to unpacked tags. */
> +    first_tag_index = extract32(clean_addr, LOG2_TAG_GRANULE,
> +                                TARGET_PAGE_BITS - LOG2_TAG_GRANULE);
> +    last_tag_index = extract32(clean_addr + last_addr_index, LOG2_TAG_GRANULE,
> +                               TARGET_PAGE_BITS - LOG2_TAG_GRANULE);
> +
> +    /*
> +     * GDB sends 2 hex digits per tag number, i.e. tags are not represented in
> +     * a packed way.
> +     */
> +    num_new_tags = strlen(new_tags) / 2;
> +
> +    /*
> +     * If the number of tags provided is greater than the number of tags
> +     * in the provided memory range, the exceeding tags are ignored. If the
> +     * number of tags is less than the number of tags in the provided memory
> +     * range, then the provided tags are used as a repeating pattern to fill
> +     * the tags in the provided memory range.
> +     */
> +    for (int i = first_tag_index, j = 0; i <= last_tag_index; i++, j++) {
> +        int new_tag_value;
> +        int packed_granules_index;
> +        int nibble_index;
> +
> +        sscanf(new_tags + 2 * (j % num_new_tags), "%2x", &new_tag_value);

Overkill?
While gdb may send 2 digits, only 0[0-9a-fA-F] is valid.


> +        /*
> +         * Find packed tag index from unpacked tag index. There are two tags
> +         * packed in one packed index. One tag per nibble.
> +         */
> +        packed_granules_index = i / 2;
> +        /* Find nibble index in the packed tag from unpacked tag index. */
> +        nibble_index = i % 2;
> +
> +        if (nibble_index == 0) { /* Update low nibble */
> +            *(tags + packed_granules_index) &= 0xF0;
> +            *(tags + packed_granules_index) |= (new_tag_value & 0x0F);
> +        } else { /* Update high nibble */
> +            *(tags + packed_granules_index) &= 0x0F;
> +            *(tags + packed_granules_index) |= ((new_tag_value & 0x0F) << 4);
> +        }

How many tags will gdb typically send with this?
If 1 or 2, it might be worth using memset.
If even, it might be worth pre-computing and using memcpy.


r~

