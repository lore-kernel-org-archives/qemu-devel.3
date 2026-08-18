Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16327C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNqS-0002xJ-Kb; Tue, 18 Aug 2026 13:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwNqP-0002we-K7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwNqM-00083k-3u
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so8214715e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787074997; x=1787679797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kPXpsAinchDQvMs9iZODkBJQwoTp+QQZbw8S02ryqzY=;
 b=Gnj9TP8708jZmwn906H41tNmkKYxXBSZAxvo97dDHd8pvcmwQNwSYuDd8Xfchp+su1
 DJ1aTFkWK8yWrDLieLnGD+JwW5B7+zTO4afoVuePd9goan/tg5sB447j7LR5u5onFu16
 BkzE/Y5kwZkef6FyvDWYxbkuBeUQ1mU/mNm8P5GzsAFeHbf49uqqAvzKRSRNJQU+g/HU
 4CF+++jkeHCqSyPSVNmDeAbYA1Ji3EDwmkIMllXFSIYf5vlP+1AshX5vz8mZIcWNnnyW
 6Wf+1qsabWVlIrRrCdvXyDtdnTPC4c8yBHIm47cSRP76ItfU4RaMfOqpqrRccZF8WPGC
 Xhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074997; x=1787679797;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kPXpsAinchDQvMs9iZODkBJQwoTp+QQZbw8S02ryqzY=;
 b=KJIts2mGSAGEDy99jJX1XECDmHIsgxcsGOoBUq/rxMjnyDTzmod53E9PSMXxdQR8w5
 kxniSw+t7Ycevsx6v3iEV3cyNwEjZA1Tf2zCK8QG6UzML/1VOpEZxTvyGU0KBAiNaUvX
 K9muH/NDuzIN1vM3Z6N+PGyZCNC4mjbF+cxmlZOufk8gX8h2VIfjpEeA6TSF9EMrKOzf
 j8Y0E9yfu05wQrQCzpWV6aXoWbIsPwyMcYA/fuygwJE+THZSu5VWXgTwD1UcpWif41Gu
 tI00C0WxEqOcpRfGHDZNv1lYXOGe7Ib1L5xTrdm8R2mXJuw3h3y/rfUJfYWJp4M3U8zL
 0tyA==
X-Gm-Message-State: AOJu0YznFSvqVPVfKJw8dqKxoX6F7ZC/Ykdqy/iScV2l0lIaLqmrMiCS
 KtdpuR+Uto3mjGuPTjCyr3/Qz7lBPoqB8tZtjbfw0whb43hr5AxnOFX+xDPsAbgMr4E=
X-Gm-Gg: AR+sD12xkRPAapDy1qiB/+tmx2wTWIA9+/uR6LYednN0DqS/hwctz0FmXa3SJkx5N0M
 BQRIi6OzrRPYC+4zqee1TkaTKnLhhM/+guYfbnyHS7jciJioa+sAOex37xcsZJoHyiqkW0jaOfn
 M1ZRrYEngwjtxqeNdDlxCnVTqpUIRqH1jccO7IKtGYzxMLYNNNK3o2MmLdLWiCV9+Jc4+w1r3jW
 CxhLDNTgZnB9qyYK16g48LLYhFzhYQjaUE1RWSmd7AQJyPIbCsIRgPV9JvzjACosk0IxLrBAaXc
 LWD11Cfc8qt/kwn3qj2HlmT+XOO4JCAUVTn8dqAGlktbZSaeLDlmWq8JappfCnZTu/AtmBXVmic
 jz6bp+6MoYVG6co4yruiB/G6gnlmSiCKiLOsWvCb1BU5/yAUMWGprSk2r257TrxQzuYEMlbOpX6
 BzrHCMeFHW78r5+q3Fb8ui55KbrqRtEbxdmMbxaQSSzwBrGwPWovsfw8Z4GjUCng==
X-Received: by 2002:a05:600c:2d84:b0:495:648c:a1 with SMTP id
 5b1f17b1804b1-499a0846335mr101889525e9.3.1787074996224; 
 Tue, 18 Aug 2026 10:43:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b572sm12592778f8f.13.2026.08.18.10.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:43:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 659065F7DF;
 Tue, 18 Aug 2026 18:43:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  philmd@mailo.com,  zhao1.liu@intel.com,
 laurent@vivier.eu,  deller@gmx.de,  pierrick.bouvier@oss.qualcomm.com
Subject: Re: [RFC PATCH 1/8] accel/tcg: cache the result of curr_cflags()
In-Reply-To: <20260817190038.580257-2-mattst88@gmail.com> (Matt Turner's
 message of "Mon, 17 Aug 2026 15:00:31 -0400")
References: <20260817190038.580257-1-mattst88@gmail.com>
 <20260817190038.580257-2-mattst88@gmail.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Tue, 18 Aug 2026 18:43:14 +0100
Message-ID: <8733wbs4st.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Matt Turner <mattst88@gmail.com> writes:

> curr_cflags() is called once per TB dispatch, from helper_lookup_tb_ptr()
> and from the cpu_exec() loop. It recomputes the same value every time:
>
>     uint32_t cflags =3D cpu->tcg_cflags;
>     if (unlikely(cpu_single_stepping(cpu))) { ... }
>     else if (qatomic_read(&one_insn_per_tb)) { ... }
>     else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) { ... }
>
> That is three loads and three branches on the hottest path in the
> interpreter, for state that changes only when gdb enables single-step,
> when one-insn-per-tb is toggled, or when the log mask changes.

I agree this would be useful to remove but...

>=20=20
>  static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
> diff --git ./include/hw/core/cpu.h ./include/hw/core/cpu.h
> index b54035fb13..172872d005 100644
> --- ./include/hw/core/cpu.h
> +++ ./include/hw/core/cpu.h
> @@ -411,10 +411,16 @@ struct qemu_work_item;
>   *   to a cluster this will be UNASSIGNED_CLUSTER_INDEX; otherwise it wi=
ll
>   *   be the same as the cluster-id property of the CPU object's TYPE_CPU=
_CLUSTER
>   *   QOM parent.
> - *   Under TCG this value is propagated to @tcg_cflags.
> + *   Under TCG this value is propagated to @tcg_cflags_priv.
>   *   See TranslationBlock::TCG CF_CLUSTER_MASK.
>   * @start_powered_off: Indicates whether the CPU starts in powered-off s=
tate.
> - * @tcg_cflags: Pre-computed cflags for this cpu.
> + * @tcg_cflags_priv: Pre-computed cflags for this cpu.  Private to
> + *   tcg_cflags_has() and tcg_cflags_set(): @tcg_curr_cflags is derived =
from
> + *   it and is refreshed by the setter, so a direct assignment here would
> + *   leave the two out of step.  The name is deliberately awkward to mak=
e an
> + *   open-coded access fail to compile rather than silently go stale.
> + * @tcg_curr_cflags: Cached result of curr_cflags(), recomputed by
> + *   tcg_update_curr_cflags() whenever any of its inputs change.

This seems like introducing additional cache state to track. Why not
just provide a helper to call when ss/gdb/log conditions change and
change the current curr_cflags() code to only validate the helper has
been called when TCG debugging is turned on. See ppc_get_tb_cpu_state or
assert_hflags_rebuild_correctly for examples.

>   * @nr_threads: Number of threads within this CPU core.
>   * @thread: Host thread details, only live once @created is #true
>   * @sem: WIN32 only semaphore used only for qtest
> @@ -557,7 +563,8 @@ struct CPUState {
>      /* TODO Move common fields from CPUArchState here. */
>      int cpu_index;
>      int cluster_index;
> -    uint32_t tcg_cflags;
> +    uint32_t tcg_cflags_priv;
> +    uint32_t tcg_curr_cflags;
>      uint32_t halted;
>      int32_t exception_index;
>=20=20
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

