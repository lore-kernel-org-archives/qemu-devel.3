Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5249CCA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulO2-00078w-0u; Sat, 06 Sep 2025 01:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulNy-00076s-Cr
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:22:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulNm-0007MS-N5
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:22:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45cb5e1adf7so22593425e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757136151; x=1757740951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vS2uyc14YHrlgQgbLTIElRTPpPc/4haz6a4U+nkwawY=;
 b=C+Ms+K9X8vq1WVPeY6AUWDxT0/Hborezfb7eOI+XoZ1L0Sc8Y0zb1lffsciaonoYqL
 dWA1WB6npz/SrD7yEJXenJTNijKy1ICeWsFjs3CprHWLQw56auvaaXJfmih3h6QgfgZV
 xadhBl137PVtBJbReo+qDIEy7vUxOdO4nc/EwcZACFeUafP1BFBw9rPOiGYWCxGejwDU
 G7kRjpCWAsHG4+JY2s7XbYIT/WQLpckbJIZ0mk35lo74fFmX4qGrW7ZuloJJhFSpvPRF
 +pk8ZfC+P1i1Bdl1hRcxNbeeqGZoTJ8gVpt/4w/QiF96rmD5vReOnvhV/sYliiw3B2hk
 4wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757136151; x=1757740951;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vS2uyc14YHrlgQgbLTIElRTPpPc/4haz6a4U+nkwawY=;
 b=VF73zFxvCzbqfY7zw8PRAK1VCEUUliVfboH7/19uhoZvi2TRr18BCCc4W9xjXBDRyG
 Y/NdluAhKTvBDNQByMCF4Jnevcdh9HNwJK9EouL7AeXtDz1PgOkH5IWj1lXK1Slee+TT
 PXaSsdUSarHJ/hQhUEwo2NQQzbvXHVpn/g42c4MXn4/YW/Y33K8tm79QiJCxgNcJLDVz
 j+IKyucKnaBbe2MalaUNZG1/WENoiSCZ4ExB52ftEznLgKaVPOIfJF9YYvXhDFjCbyBS
 o2bKQr8ucaoJzsboQ/yTDMZWSbfeJvsL9nHCUb2fr2zbe6SS5lLUos99x6yHchqqZmL1
 uItQ==
X-Gm-Message-State: AOJu0Yxi+01W7rGcMlxTOD/AKkl58LZD1c/xDpWBb7cYqcizlZ92StK7
 OmiQoURWSZKC1cAltyyOjVQPaXltBsK4Lda0KrWiOrYipbxAz+JlBY5+TdqKwzdEyXHj2qo0XUI
 F5no+51g=
X-Gm-Gg: ASbGnct4I+nGaGHfLVggefwfJmhLGXjQBkSswQWowDTrfe+XQydSHArb3GYLlc71k6I
 2BgAtHm863pIlWJLfa4AT6EbC1GE0ylW9wO3/nzEYZnuxmWgy4lP6pRpHR2T4F7e9lctgCySl2i
 EsZAJZQEsYH9PhB8PHqX/xYNoePFY8pED5uIUaWGR1zb8AUpNNwCy19B4h4SsxJNQFMRof7C2J6
 NNGeFLWqwHgtr+ocDJWIXpcOZgr6a/aKILUa/UAm+TJm0Xs3uFZvEpKnVeyvToGqEMchB24Fl9K
 uuQ+gDJxykAx1yQ2E9X3StqX0bbAs09RN15lBopgTuavKwIjMAbRs9QUKphgfSRwbxpQalufrG3
 f761H/+QMr2HAqik7rTVyfTeyUNE0Lz7EEpfZC7iGIta2xC473zUw++ge2ySaObISzdJnvDGMxY
 YC8Iimow==
X-Google-Smtp-Source: AGHT+IEgoPzJSfaXRJMtZhw2C5Wzqg+jJFkE1NNnidoWu7dQ2VykFgmaoYzETZY5HN4q0JYEQxXK8Q==
X-Received: by 2002:a05:600c:6995:b0:45d:ded8:3b6e with SMTP id
 5b1f17b1804b1-45dded83cecmr5731225e9.17.1757136151483; 
 Fri, 05 Sep 2025 22:22:31 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9c234b24sm166831325e9.16.2025.09.05.22.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 22:22:31 -0700 (PDT)
Message-ID: <1b224de2-a412-4f24-971f-b43582d4b8fd@linaro.org>
Date: Sat, 6 Sep 2025 07:22:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] accel/tcg: Improve tb_flush usage
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250906051820.160432-1-richard.henderson@linaro.org>
Content-Language: en-US
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

+cc target and migration maintainers

On 9/6/25 07:18, Richard Henderson wrote:
> It is too easy to mis-use tb_flush().  For instance, because of
> the cpu argument, some parts assumed that it needed to call the
> global flush function for every cpu.  It is easy to forget that
> the flush is not complete when the call returns: we have merely
> queued work to the cpu run loop.
> 
> (Phil, I suspect this second case is what's biting split-accel.)
> 
> So: remove tb_flush and expose only the core as tb_flush__exclusive,
> to be used only when we are already within an exclusive context.
> 
> In some cases (gdbstub, alpha, riscv, ppc spapr), we can eliminate
> the need for tb_flush completely.
> 
> Lightly tested so far, and I'm off on holiday next, but I thought
> this might help others working on split-accel in the meantime.
> 
> 
> r~
> 
> 
> Richard Henderson (11):
>    gdbstub: Remove tb_flush uses
>    accel/tcg: Split out tb_flush__exclusive
>    target/alpha: Simplify call_pal implementation
>    target/riscv: Record misa_ext in TCGTBCPUState.cs_base
>    accel/tcg: Move post-load tb_flush to vm_change_state hook
>    hw/ppc/spapr: Use tb_invalidate_phys_range in h_page_init
>    linux-user: Use tb_flush_exclusive to start second thread
>    plugins: Use tb_flush__exclusive
>    accel/tcg: Introduce EXCP_TB_FLUSH
>    accel/tcg: Use EXCP_TB_FLUSH in tb_gen_code
>    accel/tcg: Remove tb_flush
> 
>   include/exec/cpu-common.h       |  1 +
>   include/exec/tb-flush.h         | 18 +++++++---------
>   target/alpha/helper.h           |  1 -
>   accel/tcg/tb-maint.c            | 38 +++++++--------------------------
>   accel/tcg/tcg-accel-ops-mttcg.c |  7 ++++++
>   accel/tcg/tcg-accel-ops-rr.c    |  9 ++++++--
>   accel/tcg/tcg-all.c             | 21 ++++++++++++++++++
>   accel/tcg/translate-all.c       |  5 +----
>   gdbstub/system.c                |  4 ----
>   gdbstub/user.c                  |  3 ---
>   hw/core/cpu-system.c            |  8 -------
>   hw/ppc/spapr_hcall.c            |  4 ++--
>   linux-user/mmap.c               |  4 ++--
>   linux-user/syscall.c            |  2 +-
>   plugins/core.c                  |  6 ++----
>   plugins/loader.c                |  2 +-
>   target/alpha/sys_helper.c       |  6 ------
>   target/alpha/translate.c        | 21 ++++++------------
>   target/riscv/csr.c              |  3 ---
>   target/riscv/tcg/tcg-cpu.c      |  3 ++-
>   20 files changed, 69 insertions(+), 97 deletions(-)
> 


