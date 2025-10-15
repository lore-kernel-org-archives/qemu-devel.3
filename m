Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AECECCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98Zr-00088U-RN; Wed, 15 Oct 2025 16:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98Zm-00088C-Gb
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:58:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98ZZ-000714-QU
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:58:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so178235e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760561891; x=1761166691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0OrIebdIi6yQ6iMQfyofGROU8JFJSxKpuHx/oql4llw=;
 b=r859TGLVP0fsjV6ODr0wA7BY9KMpXI6TwkZHAwlXXGCvXndqqoZTIQ0OfY5fbHUuuc
 tF9K0hM9Ge3OY3dbWQqw4N+XwUwZe+Eof4EvBiVNdxgCDDAOFAzBUc6ROK7vCbLSxlQB
 EzhFzq2s6vhjmsHy/QsZyqPmamRkwVTtEBwCIDa3eM/FZZBMwy8REuypREiVO0y3HOoG
 DfjPiGJ69QvMMv8MiiimmxvVfSldjuaaiREdpOVt9zJftPp/ugJeGf4aZ5f1ZUe8Wsg/
 TKrwQVozKsBRz7ZfB3cmgcWfgOKhzTGLqX9TxpuXNkws8qrMZhsMt00S0E8teXl/keDc
 ub0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760561891; x=1761166691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0OrIebdIi6yQ6iMQfyofGROU8JFJSxKpuHx/oql4llw=;
 b=bmePkjo5F8VZ21+EgjhjGtHLPQMAs1J2f83lVIkomOxzeBrq6LVdFBImV67jWvFlgK
 xSt4eo2rNlLtMwhGRCCCf5eGsGnR7vIgB85mEzAyGeLm6Bb2gu38t03plkZn4BepZHfj
 LKAAlT1bZHuT+zTx4kcvAWeQd6Tt4InVocSYTLwoq9KoufyvFBe1JpjmYDU4bIDPSk5a
 LV6WuHBuCMqoWM9aZ37mVwQa8JuCBL6mCH+AT/Mi714thPcm9FG8FOXdUFhkWeaj+ro5
 GMH7t7eGU5H0HDiayxxDjc9TBfosgJlu8hx2zieKkBJb2Q+0e0ckDJjSCD5AkzyAs8x2
 97gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuDrh2x7D91Q5xekh/cWeAq9NYZMmw2m92qa4a9khiwufbPVxzNPvBMIRfyHXLR4Bw12I7FFz/Mlgz@nongnu.org
X-Gm-Message-State: AOJu0YwDDn0/EgkK0I7KhgPr2/wPY1f42mlur8DLSYxL2csA+PGoALEj
 DxkEZtzBO+qjJK2dAF2xwRm3a3urqkt/o1Du+UwZ+SXw+r9wqiNzmzPRpOk5Y2mYLng=
X-Gm-Gg: ASbGncu4Xg1rljvARQVZosZMrTHxEOtVQaVeCodVD38MWsRig4VUP33h02nOcbQJn19
 seUoo4UDECdgcMJ9BhlmKTc9nMLXkzBIVJ/tIM7kSSmZ4L8baNyXbVdEXjyRF4ObHFYQy9GuFHX
 23i15mfCM7QKmrDpCUJT3rjdXMcODdqoTR5gpDZcrqdgsTETiMEbkp7rhJyC9OT4ESuSZ7VdwiG
 j3mp3LhCFE/TObYo6Us+DOXu5iOn9FU+OEVxYbKzL/+OiVvG4WHRgcPfLFU4mnmhFx0EU+Hh8dA
 3sRdY0BbKg0FP84ZTtGVnY0U+WmOo22sQb3GwEDMCQ49Szaz/jZyagJNRJKcHwLZWhsZ7KUawXz
 ZmsAmkmrXcW76Z0B5BHqDPBHEZe+s3oc8gtSTmcFIaO99d61A1B9EGhBFHjsEVt9u1R2FpMup+A
 m54r3RiFvz6kcTLM6L6SxABjIwEEngJfsa2RHk0p0CP7TXs9lndJTuPPCEOb5zUuG0lijM
X-Google-Smtp-Source: AGHT+IHoj8YDylJw71O9Nt048iGAgKEuMVjVmmFtCtTOW/Yykcr45Vx78biSkYZSuocSlj7F1Mu/Fw==
X-Received: by 2002:a05:600c:19d2:b0:45d:84ca:8a7 with SMTP id
 5b1f17b1804b1-46fa9a96712mr193052665e9.14.1760561891040; 
 Wed, 15 Oct 2025 13:58:11 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489197dsm323305525e9.10.2025.10.15.13.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 13:58:10 -0700 (PDT)
Message-ID: <46e97347-63d2-4ca7-9704-e62abc0ee4f5@linaro.org>
Date: Wed, 15 Oct 2025 22:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/34] single-binary: Make riscv cpu.h target
 independent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014203512.26282-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 14/10/25 22:34, Anton Johansson wrote:
> Hi,
> 
> this is a first patchset moving towards single-binary support for riscv.
> Additional patchsets for hw/ and target/ are based on this one so it's
> best to make sure the approach taken is ok.  Most patches in this set
> concern fields in CPUArchState which are either widened (usually to
> uint64_t) or fixed to a smaller size which handles all use cases.
> 
> General purpose registers and fields mapped to TCG are dealt with by
> widening the type and applying an offset to tcg_global_mem_new() to
> correctly handle 32-bit targets on big endian hosts.

In order to not break bisectability, maybe set:

   vmstate_riscv_cpu.unmigratable = 1

in the first patch, ...

>    target/riscv: Fix size of trivial CPUArchState fields
>    target/riscv: Fix size of mhartid
>    target/riscv: Bugfix riscv_pmu_ctr_get_fixed_counters_val()
>    target/riscv: Bugfix make bit 62 read-only 0 for sireg* cfg CSR read
>    target/riscv: Combine mhpmevent and mhpmeventh
>    target/riscv: Combine mcyclecfg and mcyclecfgh
>    target/riscv: Combine minstretcfg and minstretcfgh
>    target/riscv: Combine mhpmcounter and mhpmcounterh
>    target/riscv: Fix size of gpr and gprh
>    target/riscv: Fix size of vector CSRs
>    target/riscv: Fix size of pc, load_[val|res]
>    target/riscv: Fix size of frm and fflags
>    target/riscv: Fix size of badaddr and bins
>    target/riscv: Fix size of guest_phys_fault_addr
>    target/riscv: Fix size of priv_ver and vext_ver
>    target/riscv: Fix size of retxh
>    target/riscv: Fix size of ssp
>    target/riscv: Fix size of excp_uw2
>    target/riscv: Fix size of sw_check_code
>    target/riscv: Fix size of priv
>    target/riscv: Fix size of gei fields
>    target/riscv: Fix size of [m|s|vs]iselect fields
>    target/riscv: Fix arguments to board IMSIC emulation callbacks
>    target/riscv: Fix size of irq_overflow_left
>    target/riscv: Indent PMUFixedCtrState correctly
>    target/riscv: Replace target_ulong in riscv_cpu_get_trap_name()
>    target/riscv: Replace target_ulong in riscv_ctr_add_entry()
>    target/riscv: Fix size of trigger data
>    target/riscv: Fix size of mseccfg

... and remove it in the last one.

