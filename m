Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08849C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 12:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI4au-0004yI-0b; Thu, 22 May 2025 08:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uI4ar-0004xu-8w
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:00:13 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uI4aj-0003m6-6K
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:00:11 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 8969118030B
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 13:59:53 +0200 (CEST)
Received: (qmail 29681 invoked by uid 990); 22 May 2025 11:59:53 -0000
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
Subject: Re: [PATCH v3 2/8] Add register write API
Date: Thu, 22 May 2025 13:59:31 +0200
Message-ID: <20250522115935.34716-2-neither@nut.email>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094333.4075796-3-rowanbhart@gmail.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-3-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-3) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1)
X-Rspamd-Score: -0.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=1l0vxi1wNhkd3dmeb4T99ki2pKIMmOtsguPMVUsY/G0=;
 b=SqzLC/bUeyi84UgRAYPKeq/GO4enrasy+QobYKHi1ql3ja/VWc380s/PF/io6lvZARTUBPRNgq
 hz/jf6ZQmookH+Eo+aFgxLeZ5vRoY3dHW1Q8dCxUd27jXBjzR8cTt5xxpy1uvYvgj+oNAwSty/z5
 wYR2+6+cWAS6nyptnGdLHRH9ZLPhGOZ08wtab7RH7xbmQhwtKmFiWAslU/WhOSTwYCOgCxWxFkTF
 4UQfwxtEmfXp1wIRYRRC0v30+bGX8+tLLje2WAKW3LHFQyl+sOW5gY9QrmsovmbSKuUKWKiL61j4
 cm/MZkjuI+c4+MKbx4D1gNGP8P+8XqGd5l8loPIFwIa+Ho5137Uh8Kn+hfScf0qjNkcgu3auPXki
 1qSyusMhhtnHdOnKVlOdE1NFOViWGDKbjwmOMheMAzBfpKyosCM3Qz/7XMtMmoxGPaO1GVSBdnXV
 G4Tc1+o2YiRA7i94q/k20csqpOOG8aiJ6379Bc2m84z3TcyrCgh68Jdph5VG2N9a21brUUHd7Agp
 Sym8qhz8V/HTA5aU/SDzFpoX8VlWU+Mv1pV/gzx4od+ODYlwFMQJfCzEDwmIwdTXb8ExZOZo2wvc
 UfKo/jJGwsZCnE4LjkI/R/yxZ22Gk05XMBWoiLbxZU1gQtjATo5hBKJ7ikDShLSTxL6j1k6QJxq1
 s=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> index 3a850aa216..68c8632fd7 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -893,6 +891,41 @@ typedef struct {
>  QEMU_PLUGIN_API
>  GArray *qemu_plugin_get_registers(void);
> 
> +/**
> + * qemu_plugin_read_register() - read register for current vCPU
> + *
> + * @handle: a @qemu_plugin_reg_handle handle
> + * @buf: A GByteArray for the data owned by the plugin
> + *
> + * This function is only available in a context that register read access is
> + * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
> + *
> + * Returns the size of the read register. The content of @buf is in target byte
> + * order. On failure returns -1.
> + */
> +QEMU_PLUGIN_API
> +int qemu_plugin_read_register(struct qemu_plugin_register *handle,
> +                              GByteArray *buf);
> +
> +/**
> + * qemu_plugin_write_register() - write register for current vCPU
> + *
> + * @handle: a @qemu_plugin_reg_handle handle
> + * @buf: A GByteArray for the data owned by the plugin
> + *
> + * This function is only available in a context that register write access is
> + * explicitly requested via the QEMU_PLUGIN_CB_W_REGS flag.
> + *
> + * The size of @buf must be at least the size of the requested register.
> + * Attempting to write a register with @buf smaller than the register size
> + * will result in a crash or other undesired behavior.
> + *
> + * Returns the number of bytes written. On failure returns 0.
> + */
> +QEMU_PLUGIN_API
> +int qemu_plugin_write_register(struct qemu_plugin_register *handle,
> +                              GByteArray *buf);
> +
>  /**
>   * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
>   *
> @@ -915,22 +948,6 @@ QEMU_PLUGIN_API
>  bool qemu_plugin_read_memory_vaddr(uint64_t addr,
>                                     GByteArray *data, size_t len);
> 
> -/**
> - * qemu_plugin_read_register() - read register for current vCPU
> - *
> - * @handle: a @qemu_plugin_reg_handle handle
> - * @buf: A GByteArray for the data owned by the plugin
> - *
> - * This function is only available in a context that register read access is
> - * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
> - *
> - * Returns the size of the read register. The content of @buf is in target byte
> - * order. On failure returns -1.
> - */
> -QEMU_PLUGIN_API
> -int qemu_plugin_read_register(struct qemu_plugin_register *handle,
> -                              GByteArray *buf);
> -

Why the code move?

> diff --git a/plugins/api.c b/plugins/api.c
> index 3c9d4832e9..79b2dc20b8 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -433,6 +433,25 @@ GArray *qemu_plugin_get_registers(void)
>      return create_register_handles(regs);
>  }
> 
> +int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
> +{
> +    g_assert(current_cpu);
> +
> +    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
> +}
> +
> +int qemu_plugin_write_register(struct qemu_plugin_register *reg, 
> +                               GByteArray *buf)
> +{
> +    g_assert(current_cpu);
> +
> +    if (buf->len == 0) {
> +        return 0;
> +    }
> +
> +    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
> +}
> +
>  bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
>  {
>      g_assert(current_cpu);
> @@ -453,13 +472,6 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
>      return true;
>  }
>  
> -int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
> -{
> -    g_assert(current_cpu);
> -
> -    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
> -}
> -

Again, what was the reason for moving `qemu_plugin_read_register`?

Reviewed-By: Julian Ganz <neither@nut.email>

Regards,
Julian

