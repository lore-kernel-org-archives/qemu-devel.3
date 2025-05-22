Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7104C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 12:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI4ao-0004vu-4L; Thu, 22 May 2025 08:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uI4am-0004vX-JF
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:00:08 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uI4ai-0003mH-TO
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:00:07 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 03F1218031B
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 13:59:53 +0200 (CEST)
Received: (qmail 29706 invoked by uid 990); 22 May 2025 11:59:53 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 22 May 2025 13:59:53 +0200
From: Julian Ganz <neither@nut.email>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 5/8] Add memory hardware address read/write API
Date: Thu, 22 May 2025 13:59:32 +0200
Message-ID: <20250522115935.34716-3-neither@nut.email>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094333.4075796-6-rowanbhart@gmail.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-6-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-3) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1)
X-Rspamd-Score: -0.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=doSqRyXXsf1NTn+TJKo4v2nGsZfnhTW2imRNbaJYcPU=;
 b=RpObsh5y6VBv2I4mNpNdByUIDYnZ/qbac5Ql9ag5+96AG9n8vPpK+MMJza7b8+FO83nz64twW+
 m56/9v8qxbUxHX/zkQp8HNMs36T2AtnRstzSKJ1Umsqz1FX1ilS/YLScreOY5TCJxrQWYWdEPsBo
 qZP6rvePeIl0Jp6uUrw7oNev9FyHWQPgGgmYJ8OOmW4L4L9B88oLgsPPjgflllrIfDbb8INrfn/x
 rls+bZqzKl+C/e5XM390NM5Kx/TsPbmH/4g7cLOvD/mmBx7hbUtrO2lj2ca/5SL+BdIt0KglY578
 7JGkwPvQu+Z7qlkKNAxvFPbA4JbLIv5nK5IxmxDMmxKXt2vGujC1p7dklffgSQXHp2RDus4tXn1E
 7dk9DZbdnRBPb0RMTPOy7s6TPf8F8bFLEvx4gfxunGd54D9gcuJDrdCgKwVTrKMMEgZ5bU8ydRHI
 pfAfHCsENFASejhghw1g4xKCFuRLXQseuiDyzGXLhMkRmRK0douwUqmCKgqmbi/uHJI/usT9lpxQ
 +vZrjHA3Zkjh66N2E+c/kSOMU6+lw2/qcStdpRrMxhoqIOM2o900QcGyWlDru+hkytt20ZunvcWI
 Y3Z4pnn7PnLGbxREZIikOFtprsYDVgFF1y9DQFaS7aCD4S7ze9QKamAsLbYfCuRXzI5UzJWF0Cf7
 U=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Rowan,

> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index eff8430b4a..d4f229abd9 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -1014,6 +1014,102 @@ QEMU_PLUGIN_API
>  bool qemu_plugin_write_memory_vaddr(uint64_t addr,
>                                     GByteArray *data);
>  
> <snip>
> +/**
> + * qemu_plugin_translate_vaddr() - translate a virtual address to a physical one
> + *
> + * @vaddr: virtual address to translate
> + * @hwaddr: pointer to store the physical address
> + *
> + * This function is only valid in vCPU context (i.e. in callbacks) and is only
> + * valid for softmmu targets.
> + *
> + * Returns true on success and false on failure.
> + */
> +QEMU_PLUGIN_API
> +bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr);

As a (testing) plugin author, I'm quite interested in this function in
particular. For the next iteration, would you be willing to split this
one out into its own patch? This would enhance the chance of it getting
picked up even if other parts of the series should not make it.

> diff --git a/plugins/api.c b/plugins/api.c
> index 19c10bb39e..5983768783 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -569,6 +569,106 @@ bool qemu_plugin_write_memory_vaddr(uint64_t addr, GByteArray *data)
> <snip> 
> +bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr)
> +{
> +#ifdef CONFIG_SOFTMMU
> +    g_assert(current_cpu);
> +
> +    CPUState *cpu = current_cpu;
> +
> +    uint64_t res = cpu_get_phys_page_debug(cpu, vaddr);
> +
> +    if (res == (uint64_t)-1) {
> +        return false;
> +    }
> +
> +    *hwaddr = res | (vaddr & ~TARGET_PAGE_MASK);
> +
> +    return true;
> +#else
> +    return false;
> +#endif
> +}

This definition strikes me as odd. What was your reason to assert
`current_cpu` here, but not in the other two functions? Also a bit
surprising is the declaration of `cpu` if you use it in just one place
(rather than just use `current_cpu` directly as for the assertion).

And there is no reason in particular why the vCPU could not be a
function parameter of `qemu_plugin_translate_vaddr`, right? You don't
have the same restrictions as in `qemu_plugin_read_memory_hwaddr` or
`qemu_plugin_hwaddr_operation_result` where you actually touch memory?

Regards,
Julian

