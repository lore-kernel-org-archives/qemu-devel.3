Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3523CF532EF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4x2q-0000Jp-7t; Tue, 24 Mar 2026 04:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4x2p-0000Iy-0z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:23:23 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4x2l-0002yG-U3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:23:22 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1273349c56bso4920102c88.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774340598; x=1774945398; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=950Y4c56ii12zawlZJVlM/pNYzo0wHzkDMhN/y42rs0=;
 b=AKRZjZYlBBS8RJseKbcfXvRH/8B+Xnt8EaQ4CLjl/TYZbzPkUllnTRfxnTCrbWtxIi
 3roR+6lgO1UOIaeBsfaNFn4822UYKG2ZEI09n6rX2Te/0zilKrzPifVF0qSQLOeGNPbA
 7DiJFxJiRZ6IimJMuhhJ9kiYKmP3xif87sFG0mrU/7/zo5f8avKEPNdeCVy43yGt4I4v
 CjCkTAaBgdQ3kRn1XOt3V/xefBR1dfDb4EHGcJ80Up10pxQuAYtyP92/mq4SAml4HxW4
 nFTjI027Es3xve+f8uCJQDs/9jCsVTWbVaJ41zrYXoACCSQUSlELxrkisJJNU0dKW6BN
 I2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774340598; x=1774945398;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=950Y4c56ii12zawlZJVlM/pNYzo0wHzkDMhN/y42rs0=;
 b=ZjgtX2ld3kw+C1RTxHEhtcki943DfGbbJzXL9cmdJuKzqCtu08AgDAu6J9W/bjqOm3
 XIzgKIAyQhYe50sjA9eHg3JzdUDyqHAdos74XsWs3tIXn6BTyQkXDEnDapNN4I03PpPg
 3uii4ElBwqO4epf17h8WdwHrvB6X5xZo/UXxBhsszbsyDuEiRd8+KFmWGHQgwwq4rI8a
 1TL5lIaS+CS4lF8Ak1zjGXmq2SQaKCB67N2tmmZkHNOw8cukQWd45/PNLKMtHg1DIMkv
 KbDSxZo5+mvEnuRzfaEE59dtVRqBRr6nw1DptG9FlAv56FEgSAc4P2RVAGGIqQCTnqEv
 ODjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhMi1HoqWUZYUETeGkPQFlyS+3tcLh6uHH2W9k2keo2hkkQNSoslqqHBt3YZG0DGIC/VVti3zjQiXS@nongnu.org
X-Gm-Message-State: AOJu0YyjVnXKirp8ZBR0UXsUWJXO3cC67YIpgFKJjV1vtsQlj1i1QWHV
 3ZoDoZWSthkshSRhChl8cq47qN4OBC8bbC9168FBtxy8ZHQ4Tl2Tvo2e
X-Gm-Gg: ATEYQzxEsoELkJBx0A/CwjR0EJgbIzTsl3D1S6GsUKS7yNO+Jsal6wkL1Mr0V95YugZ
 BWZMGKpFunOZKCIH1gymdAQuy/nzSPaojOOAvZJBIDX4oCr4v9sTBV8nMAYy5WtpitL4ZWaqnvv
 H/4fFci8NvpZ8boDS5l9gWPA8f6jO1wyUcSpnLMd2oFfX24Uaucq7qK/UyesIqSRN4qfC8ehi1c
 R7YyicCrhbRXCwg/qbqIZiaJggU0Qj/+DRZndmCnoEaVt8UB6IYASoxOBhmNxCj3BZV+Z4TmY16
 72+ymO0hG4AU9mXUvGkgtsPY6kR6tBjvizklxk7VqcFGMdvkBVrsenpaFRCpp0DQrAs0gayCwaH
 i/tcodWg2hvtfP2npOkKNPcWiBIXTHlqSWSn+MogudbUP04a4fTQliIsnsUdeg9F5wGaZ38cZkm
 u0QU81pTSsKVBXElDuV/oplYEEuv7CRp9gi4KvMlr67j736qAIbqGHhJn6MsCsIdD87X8NFA3vf
 4jBk87WF0PUpMImHjWeT6NZB4yVLxA=
X-Received: by 2002:a05:7023:b82:b0:12a:6ab7:3f7c with SMTP id
 a92af1059eb24-12a7264eb86mr6607355c88.5.1774340598049; 
 Tue, 24 Mar 2026 01:23:18 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b17a7c1sm14842630eec.7.2026.03.24.01.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 01:23:16 -0700 (PDT)
Date: Tue, 24 Mar 2026 16:22:59 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC v3 2/4] tests/qtest: Add libqtest attrs helpers for memory
 accesses
Message-ID: <acJJwHlRxER4wjtF@ZEVORN-PC.localdomain>
References: <20260323133210.1523868-1-tangtao1634@phytium.com.cn>
 <20260323133210.1523868-3-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323133210.1523868-3-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
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

On Mon, Mar 23, 2026 at 09:32:08PM +0800, Tao Tang wrote:
> Expose libqtest APIs for qtest memory commands with optional attrs:
> - qtest_{read,write}{b,w,l,q}_attrs()
> - qtest_mem{read,write,set}_attrs()
> - qtest_buf{read,write}_attrs()
> 
> Keep the existing libqtest memory access helpers as wrappers passing
> NULL attrs, so current users remain unchanged.
> 
> Also add matching libqtest-single shortcut wrappers for the *_attrs
> helpers.
> 
> Refactor libqtest response parsing by splitting qtest_rsp_args() into a
> raw tokenizing helper, qtest_rsp_words(), and the existing OK-checking
> wrapper. Add qtest_raw_cmd() on top of qtest_rsp_words() so tests can
> send raw qtest protocol commands and inspect non-OK responses such as
> ERR and FAIL.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
LGTM.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  tests/qtest/libqtest-single.h | 156 +++++++++++++++++++++
>  tests/qtest/libqtest.c        | 246 ++++++++++++++++++++++++++--------
>  tests/qtest/libqtest.h        | 177 ++++++++++++++++++++++++
>  3 files changed, 524 insertions(+), 55 deletions(-)
> 
> diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
> index 851724cbcb..2812b86bd4 100644
> --- a/tests/qtest/libqtest-single.h
> +++ b/tests/qtest/libqtest-single.h
> @@ -291,6 +291,162 @@ static inline void memwrite(uint64_t addr, const void *data, size_t size)
>      qtest_memwrite(global_qtest, addr, data, size);
>  }
>  
> +/**
> + * writeb_attrs:
> + * @addr: Guest address to write to.
> + * @value: Value being written.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Writes an 8-bit value to guest memory with optional transaction attributes.
> + */
> +static inline void writeb_attrs(uint64_t addr, uint8_t value, const char *attrs)
> +{
> +    qtest_writeb_attrs(global_qtest, addr, value, attrs);
> +}
> +
> +/**
> + * writew_attrs:
> + * @addr: Guest address to write to.
> + * @value: Value being written.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Writes a 16-bit value to guest memory with optional transaction attributes.
> + */
> +static inline void writew_attrs(uint64_t addr, uint16_t value,
> +                                const char *attrs)
> +{
> +    qtest_writew_attrs(global_qtest, addr, value, attrs);
> +}
> +
> +/**
> + * writel_attrs:
> + * @addr: Guest address to write to.
> + * @value: Value being written.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Writes a 32-bit value to guest memory with optional transaction attributes.
> + */
> +static inline void writel_attrs(uint64_t addr, uint32_t value,
> +                                const char *attrs)
> +{
> +    qtest_writel_attrs(global_qtest, addr, value, attrs);
> +}
> +
> +/**
> + * writeq_attrs:
> + * @addr: Guest address to write to.
> + * @value: Value being written.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Writes a 64-bit value to guest memory with optional transaction attributes.
> + */
> +static inline void writeq_attrs(uint64_t addr, uint64_t value,
> +                                const char *attrs)
> +{
> +    qtest_writeq_attrs(global_qtest, addr, value, attrs);
> +}
> +
> +/**
> + * readb_attrs:
> + * @addr: Guest address to read from.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Reads an 8-bit value from guest memory with optional transaction attributes.
> + *
> + * Returns: Value read.
> + */
> +static inline uint8_t readb_attrs(uint64_t addr, const char *attrs)
> +{
> +    return qtest_readb_attrs(global_qtest, addr, attrs);
> +}
> +
> +/**
> + * readw_attrs:
> + * @addr: Guest address to read from.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Reads a 16-bit value from guest memory with optional transaction attributes.
> + *
> + * Returns: Value read.
> + */
> +static inline uint16_t readw_attrs(uint64_t addr, const char *attrs)
> +{
> +    return qtest_readw_attrs(global_qtest, addr, attrs);
> +}
> +
> +/**
> + * readl_attrs:
> + * @addr: Guest address to read from.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Reads a 32-bit value from guest memory with optional transaction attributes.
> + *
> + * Returns: Value read.
> + */
> +static inline uint32_t readl_attrs(uint64_t addr, const char *attrs)
> +{
> +    return qtest_readl_attrs(global_qtest, addr, attrs);
> +}
> +
> +/**
> + * readq_attrs:
> + * @addr: Guest address to read from.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Reads a 64-bit value from guest memory with optional transaction attributes.
> + *
> + * Returns: Value read.
> + */
> +static inline uint64_t readq_attrs(uint64_t addr, const char *attrs)
> +{
> +    return qtest_readq_attrs(global_qtest, addr, attrs);
> +}
> +
> +/**
> + * memread_attrs:
> + * @addr: Guest address to read from.
> + * @data: Pointer to where memory contents will be stored.
> + * @size: Number of bytes to read.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Read guest memory into a buffer with optional transaction attributes.
> + */
> +static inline void memread_attrs(uint64_t addr, void *data, size_t size,
> +                                 const char *attrs)
> +{
> +    qtest_memread_attrs(global_qtest, addr, data, size, attrs);
> +}
> +
> +/**
> + * memwrite_attrs:
> + * @addr: Guest address to write to.
> + * @data: Pointer to the bytes that will be written to guest memory.
> + * @size: Number of bytes to write.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Write a buffer to guest memory with optional transaction attributes.
> + */
> +static inline void memwrite_attrs(uint64_t addr, const void *data, size_t size,
> +                                  const char *attrs)
> +{
> +    qtest_memwrite_attrs(global_qtest, addr, data, size, attrs);
> +}
> +
> +/**
> + * memset_attrs:
> + * @addr: Guest address to write to.
> + * @pattern: Byte pattern to fill the guest memory region with.
> + * @size: Number of bytes to write.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Write a pattern to guest memory with optional transaction attributes.
> + */
> +static inline void memset_attrs(uint64_t addr, uint8_t pattern, size_t size,
> +                                const char *attrs)
> +{
> +    qtest_memset_attrs(global_qtest, addr, pattern, size, attrs);
> +}
> +
>  /**
>   * clock_step_next:
>   *
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 051faf31e1..b67786f1ad 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -747,11 +747,10 @@ static GString *qtest_client_socket_recv_line(QTestState *s)
>      return line;
>  }
>  
> -static gchar **qtest_rsp_args(QTestState *s, int expected_args)
> +static gchar **qtest_rsp_words(QTestState *s)
>  {
>      GString *line;
>      gchar **words;
> -    int i;
>  
>  redo:
>      line = s->ops.recv_line(s);
> @@ -781,6 +780,15 @@ redo:
>      }
>  
>      g_assert(words[0] != NULL);
> +
> +    return words;
> +}
> +
> +static gchar **qtest_rsp_args(QTestState *s, int expected_args)
> +{
> +    gchar **words = qtest_rsp_words(s);
> +    int i;
> +
>      g_assert_cmpstr(words[0], ==, "OK");
>  
>      for (i = 0; i < expected_args; i++) {
> @@ -790,6 +798,21 @@ redo:
>      return words;
>  }
>  
> +gchar **qtest_raw_cmd(QTestState *s, const char *fmt, ...)
> +{
> +    va_list ap;
> +    gchar *str;
> +
> +    va_start(ap, fmt);
> +    str = g_strdup_vprintf(fmt, ap);
> +    va_end(ap);
> +
> +    s->ops.send(s, str);
> +    g_free(str);
> +
> +    return qtest_rsp_words(s);
> +}
> +
>  static void qtest_rsp(QTestState *s)
>  {
>      gchar **words = qtest_rsp_args(s, 0);
> @@ -1232,66 +1255,44 @@ uint32_t qtest_inl(QTestState *s, uint16_t addr)
>      return qtest_big_endian(s) ? bswap32(v) : v;
>  }
>  
> -static void qtest_write(QTestState *s, const char *cmd, uint64_t addr,
> -                        uint64_t value)
> -{
> -    qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr, value);
> -    qtest_rsp(s);
> -}
> -
>  void qtest_writeb(QTestState *s, uint64_t addr, uint8_t value)
>  {
> -    qtest_write(s, "writeb", addr, value);
> +    qtest_writeb_attrs(s, addr, value, NULL);
>  }
>  
>  void qtest_writew(QTestState *s, uint64_t addr, uint16_t value)
>  {
> -    qtest_write(s, "writew", addr, value);
> +    qtest_writew_attrs(s, addr, value, NULL);
>  }
>  
>  void qtest_writel(QTestState *s, uint64_t addr, uint32_t value)
>  {
> -    qtest_write(s, "writel", addr, value);
> +    qtest_writel_attrs(s, addr, value, NULL);
>  }
>  
>  void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
>  {
> -    qtest_write(s, "writeq", addr, value);
> -}
> -
> -static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr)
> -{
> -    gchar **args;
> -    int ret;
> -    uint64_t value;
> -
> -    qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
> -    args = qtest_rsp_args(s, 2);
> -    ret = qemu_strtou64(args[1], NULL, 0, &value);
> -    g_assert(!ret);
> -    g_strfreev(args);
> -
> -    return value;
> +    qtest_writeq_attrs(s, addr, value, NULL);
>  }
>  
>  uint8_t qtest_readb(QTestState *s, uint64_t addr)
>  {
> -    return qtest_read(s, "readb", addr);
> +    return qtest_readb_attrs(s, addr, NULL);
>  }
>  
>  uint16_t qtest_readw(QTestState *s, uint64_t addr)
>  {
> -    return qtest_read(s, "readw", addr);
> +    return qtest_readw_attrs(s, addr, NULL);
>  }
>  
>  uint32_t qtest_readl(QTestState *s, uint64_t addr)
>  {
> -    return qtest_read(s, "readl", addr);
> +    return qtest_readl_attrs(s, addr, NULL);
>  }
>  
>  uint64_t qtest_readq(QTestState *s, uint64_t addr)
>  {
> -    return qtest_read(s, "readq", addr);
> +    return qtest_readq_attrs(s, addr, NULL);
>  }
>  
>  static int hex2nib(char ch)
> @@ -1309,23 +1310,7 @@ static int hex2nib(char ch)
>  
>  void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
>  {
> -    uint8_t *ptr = data;
> -    gchar **args;
> -    size_t i;
> -
> -    if (!size) {
> -        return;
> -    }
> -
> -    qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
> -    args = qtest_rsp_args(s, 2);
> -
> -    for (i = 0; i < size; i++) {
> -        ptr[i] = hex2nib(args[1][2 + (i * 2)]) << 4;
> -        ptr[i] |= hex2nib(args[1][2 + (i * 2) + 1]);
> -    }
> -
> -    g_strfreev(args);
> +    qtest_memread_attrs(s, addr, data, size, NULL);
>  }
>  
>  uint64_t qtest_rtas_call(QTestState *s, const char *name,
> @@ -1390,23 +1375,58 @@ void qtest_add_data_func(const char *str, const void *data,
>  }
>  
>  void qtest_bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
> +{
> +    qtest_bufwrite_attrs(s, addr, data, size, NULL);
> +}
> +
> +void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
> +{
> +    qtest_bufread_attrs(s, addr, data, size, NULL);
> +}
> +
> +void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
> +{
> +    qtest_memwrite_attrs(s, addr, data, size, NULL);
> +}
> +
> +void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
> +{
> +    qtest_memset_attrs(s, addr, pattern, size, NULL);
> +}
> +
> +static bool qtest_has_attrs(const char *attrs)
> +{
> +    return attrs && attrs[0];
> +}
> +
> +void qtest_bufwrite_attrs(QTestState *s, uint64_t addr, const void *data,
> +                          size_t size, const char *attrs)
>  {
>      gchar *bdata;
>  
>      bdata = g_base64_encode(data, size);
>      qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
>      s->ops.send(s, bdata);
> +    if (qtest_has_attrs(attrs)) {
> +        s->ops.send(s, " ");
> +        s->ops.send(s, attrs);
> +    }
>      s->ops.send(s, "\n");
>      qtest_rsp(s);
>      g_free(bdata);
>  }
>  
> -void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
> +void qtest_bufread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
> +                         const char *attrs)
>  {
>      gchar **args;
>      size_t len;
>  
> -    qtest_sendf(s, "b64read 0x%" PRIx64 " 0x%zx\n", addr, size);
> +    if (qtest_has_attrs(attrs)) {
> +        qtest_sendf(s, "b64read 0x%" PRIx64 " 0x%zx %s\n", addr, size, attrs);
> +    } else {
> +        qtest_sendf(s, "b64read 0x%" PRIx64 " 0x%zx\n", addr, size);
> +    }
>      args = qtest_rsp_args(s, 2);
>  
>      g_base64_decode_inplace(args[1], &len);
> @@ -1420,7 +1440,111 @@ void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
>      g_strfreev(args);
>  }
>  
> -void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
> +static void qtest_write_attrs(QTestState *s, const char *cmd,
> +                              uint64_t addr, uint64_t value,
> +                              const char *attrs)
> +{
> +    if (qtest_has_attrs(attrs)) {
> +        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 " %s\n",
> +                    cmd, addr, value, attrs);
> +    } else {
> +        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr, value);
> +    }
> +    qtest_rsp(s);
> +}
> +
> +static uint64_t qtest_read_attrs(QTestState *s, const char *cmd,
> +                                 uint64_t addr, const char *attrs)
> +{
> +    gchar **args;
> +    int ret;
> +    uint64_t value;
> +
> +    if (qtest_has_attrs(attrs)) {
> +        qtest_sendf(s, "%s 0x%" PRIx64 " %s\n", cmd, addr, attrs);
> +    } else {
> +        qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
> +    }
> +    args = qtest_rsp_args(s, 2);
> +    ret = qemu_strtou64(args[1], NULL, 0, &value);
> +    g_assert(!ret);
> +    g_strfreev(args);
> +
> +    return value;
> +}
> +
> +void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
> +                        const char *attrs)
> +{
> +    qtest_write_attrs(s, "writeb", addr, value, attrs);
> +}
> +
> +void qtest_writew_attrs(QTestState *s, uint64_t addr, uint16_t value,
> +                        const char *attrs)
> +{
> +    qtest_write_attrs(s, "writew", addr, value, attrs);
> +}
> +
> +void qtest_writel_attrs(QTestState *s, uint64_t addr, uint32_t value,
> +                        const char *attrs)
> +{
> +    qtest_write_attrs(s, "writel", addr, value, attrs);
> +}
> +
> +void qtest_writeq_attrs(QTestState *s, uint64_t addr, uint64_t value,
> +                        const char *attrs)
> +{
> +    qtest_write_attrs(s, "writeq", addr, value, attrs);
> +}
> +
> +uint8_t qtest_readb_attrs(QTestState *s, uint64_t addr, const char *attrs)
> +{
> +    return qtest_read_attrs(s, "readb", addr, attrs);
> +}
> +
> +uint16_t qtest_readw_attrs(QTestState *s, uint64_t addr, const char *attrs)
> +{
> +    return qtest_read_attrs(s, "readw", addr, attrs);
> +}
> +
> +uint32_t qtest_readl_attrs(QTestState *s, uint64_t addr, const char *attrs)
> +{
> +    return qtest_read_attrs(s, "readl", addr, attrs);
> +}
> +
> +uint64_t qtest_readq_attrs(QTestState *s, uint64_t addr, const char *attrs)
> +{
> +    return qtest_read_attrs(s, "readq", addr, attrs);
> +}
> +
> +void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data,
> +                         size_t size, const char *attrs)
> +{
> +    uint8_t *ptr = data;
> +    gchar **args;
> +    size_t i;
> +
> +    if (!size) {
> +        return;
> +    }
> +
> +    if (qtest_has_attrs(attrs)) {
> +        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx %s\n", addr, size, attrs);
> +    } else {
> +        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
> +    }
> +    args = qtest_rsp_args(s, 2);
> +
> +    for (i = 0; i < size; i++) {
> +        ptr[i] = hex2nib(args[1][2 + (i * 2)]) << 4;
> +        ptr[i] |= hex2nib(args[1][2 + (i * 2) + 1]);
> +    }
> +
> +    g_strfreev(args);
> +}
> +
> +void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
> +                          size_t size, const char *attrs)
>  {
>      const uint8_t *ptr = data;
>      size_t i;
> @@ -1436,14 +1560,26 @@ void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
>          sprintf(&enc[i * 2], "%02x", ptr[i]);
>      }
>  
> -    qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
> +    if (qtest_has_attrs(attrs)) {
> +        qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s %s\n",
> +                    addr, size, enc, attrs);
> +    } else {
> +        qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
> +    }
>      qtest_rsp(s);
>      g_free(enc);
>  }
>  
> -void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
> +void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t pattern,
> +                        size_t size, const char *attrs)
>  {
> -    qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n", addr, size, pattern);
> +    if (qtest_has_attrs(attrs)) {
> +        qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x %s\n",
> +                    addr, size, pattern, attrs);
> +    } else {
> +        qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n",
> +                    addr, size, pattern);
> +    }
>      qtest_rsp(s);
>  }
>  
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index 9c118c89ca..cee74cf2a4 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -239,6 +239,19 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
>  void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
>      G_GNUC_PRINTF(2, 3);
>  
> +/**
> + * qtest_raw_cmd:
> + * @s: #QTestState instance to operate on.
> + * @fmt: raw qtest protocol text to send, formatted like sprintf().
> + *
> + * Sends a raw qtest command and returns the response split on spaces.
> + * The response is not required to start with ``OK``; callers can inspect
> + * ``args[0]`` for ``OK``, ``ERR``, or ``FAIL`` and must free the returned
> + * vector with g_strfreev().
> + */
> +gchar **qtest_raw_cmd(QTestState *s, const char *fmt, ...)
> +    G_GNUC_PRINTF(2, 3);
> +
>  /**
>   * qtest_socket_server:
>   * @socket_path: the UNIX domain socket path
> @@ -671,6 +684,20 @@ uint64_t qtest_csr_call(QTestState *s, const char *name,
>   */
>  void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size);
>  
> +/**
> + * qtest_bufread_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to read from.
> + * @data: Pointer to where memory contents will be stored.
> + * @size: Number of bytes to read.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Read guest memory into a buffer and receive using a base64 encoding with
> + * optional transaction attributes.
> + */
> +void qtest_bufread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
> +                         const char *attrs);
> +
>  /**
>   * qtest_memwrite:
>   * @s: #QTestState instance to operate on.
> @@ -694,6 +721,21 @@ void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
>  void qtest_bufwrite(QTestState *s, uint64_t addr,
>                      const void *data, size_t size);
>  
> +/**
> + * qtest_bufwrite_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to write to.
> + * @data: Pointer to the bytes that will be written to guest memory.
> + * @size: Number of bytes to write.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Write a buffer to guest memory and transmit using a base64 encoding with
> + * optional transaction attributes.
> + */
> +void qtest_bufwrite_attrs(QTestState *s, uint64_t addr,
> +                          const void *data, size_t size,
> +                          const char *attrs);
> +
>  /**
>   * qtest_memset:
>   * @s: #QTestState instance to operate on.
> @@ -705,6 +747,141 @@ void qtest_bufwrite(QTestState *s, uint64_t addr,
>   */
>  void qtest_memset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);
>  
> +/**
> + * qtest_writeb_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to write to.
> + * @value: Value being written.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Writes an 8-bit value to guest memory with optional transaction attributes.
> + */
> +void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
> +                        const char *attrs);
> +
> +/**
> + * qtest_writew_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to write to.
> + * @value: Value being written.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Writes a 16-bit value to guest memory with optional transaction attributes.
> + */
> +void qtest_writew_attrs(QTestState *s, uint64_t addr, uint16_t value,
> +                        const char *attrs);
> +
> +/**
> + * qtest_writel_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to write to.
> + * @value: Value being written.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Writes a 32-bit value to guest memory with optional transaction attributes.
> + */
> +void qtest_writel_attrs(QTestState *s, uint64_t addr, uint32_t value,
> +                        const char *attrs);
> +
> +/**
> + * qtest_writeq_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to write to.
> + * @value: Value being written.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Writes a 64-bit value to guest memory with optional transaction attributes.
> + */
> +void qtest_writeq_attrs(QTestState *s, uint64_t addr, uint64_t value,
> +                        const char *attrs);
> +
> +/**
> + * qtest_readb_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to read from.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Reads an 8-bit value from guest memory with optional transaction attributes.
> + *
> + * Returns: Value read.
> + */
> +uint8_t qtest_readb_attrs(QTestState *s, uint64_t addr, const char *attrs);
> +
> +/**
> + * qtest_readw_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to read from.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Reads a 16-bit value from guest memory with optional transaction attributes.
> + *
> + * Returns: Value read.
> + */
> +uint16_t qtest_readw_attrs(QTestState *s, uint64_t addr, const char *attrs);
> +
> +/**
> + * qtest_readl_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to read from.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Reads a 32-bit value from guest memory with optional transaction attributes.
> + *
> + * Returns: Value read.
> + */
> +uint32_t qtest_readl_attrs(QTestState *s, uint64_t addr, const char *attrs);
> +
> +/**
> + * qtest_readq_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to read from.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Reads a 64-bit value from guest memory with optional transaction attributes.
> + *
> + * Returns: Value read.
> + */
> +uint64_t qtest_readq_attrs(QTestState *s, uint64_t addr, const char *attrs);
> +
> +/**
> + * qtest_memread_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to read from.
> + * @data: Pointer to where memory contents will be stored.
> + * @size: Number of bytes to read.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Read guest memory into a buffer with optional transaction attributes.
> + */
> +void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
> +                         const char *attrs);
> +
> +/**
> + * qtest_memwrite_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to write to.
> + * @data: Pointer to the bytes that will be written to guest memory.
> + * @size: Number of bytes to write.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Write a buffer to guest memory with optional transaction attributes.
> + */
> +void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
> +                          size_t size, const char *attrs);
> +
> +/**
> + * qtest_memset_attrs:
> + * @s: #QTestState instance to operate on.
> + * @addr: Guest address to write to.
> + * @patt: Byte pattern to fill the guest memory region with.
> + * @size: Number of bytes to write.
> + * @attrs: Optional transaction attributes string.
> + *
> + * Write a pattern to guest memory with optional transaction attributes.
> + */
> +void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t patt, size_t size,
> +                        const char *attrs);
> +
>  /**
>   * qtest_clock_step_next:
>   * @s: #QTestState instance to operate on.
> -- 
> 2.34.1
> 

