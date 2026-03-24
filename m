Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744BAF532C6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 02:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4rhg-0007UO-4X; Mon, 23 Mar 2026 22:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4rhe-0007TZ-Eg
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 22:41:10 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4rhb-0000fk-M7
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 22:41:10 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1273349c56bso4700688c88.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 19:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774320065; x=1774924865; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yHNjnfex3lCxJpSAQH8Amxrp2xBDUlqGsbw02rxwBZQ=;
 b=Vqba90LygeIDTH303RfeSuw7ABoa+KFLBZo2HoHjlI78yR/QS+lOo3m18aPCR4mJl9
 3xfkz+nd6tZEkl8n0+sweNrT2EZe5/UahhOhg9yHfIr6ut4cLLq4CxArIe7uqQMJQYsr
 BR9cM9idMK/CARG9jcPNAM5xkBEzbr3b8qRDOWmDxWLhNYW8Q9kYItchGAE8V/F4OR/w
 kIde1g1XKJrmdMF2AUrsA0fsflTMU2D3L8ZosG/kDrGNQcl3Gk91LAnrISTzyqqHNIex
 Wym2Aa4urpy1whOWpzOqwoQ0FDTNb5oOmYHdQciENok75/W2T9XkP0IAxR7rlE8ZYc0a
 lzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774320065; x=1774924865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHNjnfex3lCxJpSAQH8Amxrp2xBDUlqGsbw02rxwBZQ=;
 b=JYsVwrf/Jfj1tizfDyvq88to3sIikBR8OEybsw+pPIXtuCQ2T27ChQkSzTawRP/Sys
 aiioq+ZZBoehjK/ZbT7k/p8aG6/of841KV7l9xotAieVapbbFailTY1MuDoAMyaL/Dr6
 VofEP1S2m9aN6liDcuP0wbSnEPXoi20NrmdahQaUuqtMbMr1jsQYITHLmGXrzbiF1Kj2
 2LGS059bLuojG8WtDvrku9Uq1tNnMwQajQhGTuPmZadCX6lru8+6duun222D2qrHMIN4
 N8jIbetuDwWXqrfJ3lEig2A4svsj2aOEeZYk8/aWs8RU/tJhRu4l7Co/800Ud1L92pf/
 TYLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtENpoi5bwEDlpdNywOk2DyPlxBUrbVQQ+CjVwZd6JIGrwtXyWUYHc+U3yaJPvZ2z+FYLGR1olpS6w@nongnu.org
X-Gm-Message-State: AOJu0YzE8pL0lfhZ7OTBST9beG2D6SAl6kfLxGglmEStkdexlB8bEwwI
 yzyBmIbREuy/CcsDKvUPqCYT0yXoMjHm++THEKhoK0rFNsygNrJUNRXT
X-Gm-Gg: ATEYQzx2DrKs5R2K6+RNeP1+GC3h4rvZie6A4vy3uJ7xMubeSPdxZDGu40pYD6/smeC
 +CP7sdVEUpm0IDchsWdRCon4uw6E6VCXtuTo2JcxBwHIXfNzDSZFx5/qrtkiBJrDYSQOb8IhcQr
 SI/CdPuFRn8sTmo3OCoACL1LkZFHZ0wp0oMPKePGPlb7G8d7BIjj7q65+syH0nwlhMZHUjJ9JZt
 DMQEoxK7c+/z3PqABkyGUgEaoHkYZLLzmEC6tTcwW3SLG40PJBBn39VFZWb1MBSXZOV7+qPv5+z
 bb7wjxVR3Tr8qDW10qsaeRh+5TG57O46XB4O5SYZJQxECsJfBeaG5oqy2/jSGm3+B/CLbJxZrFJ
 tj5cjrAWsO8GSl/lqq2QeHVZGQ9b+t1rFYdpx4FkrdpSysXPj/JRv+fNZNiuUQTpnCpOKtrtCik
 XDK//lLWF8QQNfTOkO0+xv1EuEX38raxqSJVRP5UBshdwN6k9P3yI3hiRCkBfihQxNf90Kt2L4u
 dOF9a8tdpgRWIb45/hbbJGBlY12i+s=
X-Received: by 2002:a05:7022:909:b0:128:d471:8c1 with SMTP id
 a92af1059eb24-12a72662bd7mr6024830c88.17.1774320065204; 
 Mon, 23 Mar 2026 19:41:05 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b2d673asm16845112eec.24.2026.03.23.19.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 19:41:04 -0700 (PDT)
Date: Tue, 24 Mar 2026 10:40:48 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC v3 1/4] tests/qtest: Add attrs support to qtest server
 memory commands
Message-ID: <acH32HUGWnbF2_PY@ZEVORN-PC.localdomain>
References: <20260323133210.1523868-1-tangtao1634@phytium.com.cn>
 <20260323133210.1523868-2-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323133210.1523868-2-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 23, 2026 at 09:32:07PM +0800, Tao Tang wrote:
> Extend qtest memory access commands to accept an optional attrs argument.
> 
> Supported attrs:
> - secure (x86/Arm)
> - space=non-secure|secure|root|realm (Arm-only)
> 
> For memory commands, parse attrs, select the corresponding AddressSpace
> with cpu_asidx_from_attrs(), and issue accesses with the matching
> MemTxAttrs.
> 
> Cover scalar and bulk memory commands, including:
> - read{b,w,l,q} / write{b,w,l,q}
> - read / write
> - b64read / b64write
> - memset
> 
> Also reject invalid attrs and excessive arguments, and document the new
> command forms in qtest.c, and use qtest_send_memtx_error() to return
> ERR for memory access failures.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  system/qtest.c | 517 +++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 463 insertions(+), 54 deletions(-)
> 
> diff --git a/system/qtest.c b/system/qtest.c
> index cf90cd53ad..30c2a95020 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -22,6 +22,7 @@
>  #include "hw/core/qdev.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/cpu.h"
> +#include "hw/arm/arm-security.h"
>  #include "qemu/accel.h"
>  #include "system/cpu-timers.h"
>  #include "qemu/config-file.h"
> @@ -113,6 +114,14 @@ static void *qtest_server_send_opaque;
>   * PIO and memory access:
>   * """"""""""""""""""""""
>   *
> + * Memory access commands allow specifying memory transaction attributes,
> + * which is useful for testing devices that behave differently based on
> + * security state (e.g., Arm TrustZone/CCA or System Management Mode in x86).
> + *
> + * Only the following attributes are supported by the qtest server:
> + * ``secure`` sets MemTxAttrs.secure=1 (x86/Arm).
> + * ``space=...`` is Arm-specific and accepts: non-secure, secure, root, realm.
> + *
>   * .. code-block:: none
>   *
>   *  > outb ADDR VALUE
> @@ -150,13 +159,42 @@ static void *qtest_server_send_opaque;
>   *
>   * .. code-block:: none
>   *
> + *  > writeb ADDR VALUE secure
> + *  < OK
> + *
> + * .. code-block:: none
> + *
> + *  > writeb ADDR VALUE space=realm
> + *  < OK
> + *
> + * .. code-block:: none
> + *
>   *  > writew ADDR VALUE
>   *  < OK
>   *
>   * .. code-block:: none
>   *
> + *  > writew ADDR VALUE secure
> + *  < OK
> + *
> + * .. code-block:: none
> + *
> + *  > writew ADDR VALUE space=realm
> + *  < OK
> + *
> + * .. code-block:: none
> + *
>   *  > writel ADDR VALUE
>   *  < OK
> + * .. code-block:: none
> + *
> + *  > writel ADDR VALUE secure
> + *  < OK
> + *
> + * .. code-block:: none
> + *
> + *  > writel ADDR VALUE space=root
> + *  < OK
>   *
>   * .. code-block:: none
>   *
> @@ -165,49 +203,147 @@ static void *qtest_server_send_opaque;
>   *
>   * .. code-block:: none
>   *
> + *  > writeq ADDR VALUE secure
> + *  < OK
> + *
> + * .. code-block:: none
> + *
> + *  > writeq ADDR VALUE space=non-secure
> + *  < OK
> + *
> + * .. code-block:: none
> + *
>   *  > readb ADDR
>   *  < OK VALUE
>   *
>   * .. code-block:: none
>   *
> + *  > readb ADDR secure
> + *  < OK VALUE
> + *
> + * .. code-block:: none
> + *
> + *  > readb ADDR space=root
> + *  < OK VALUE
> + *
> + * .. code-block:: none
> + *
>   *  > readw ADDR
>   *  < OK VALUE
>   *
>   * .. code-block:: none
>   *
> + *  > readw ADDR secure
> + *  < OK VALUE
> + *
> + * .. code-block:: none
> + *
> + *  > readw ADDR space=root
> + *  < OK VALUE
> + *
> + * .. code-block:: none
> + *
>   *  > readl ADDR
>   *  < OK VALUE
>   *
>   * .. code-block:: none
>   *
> + *  > readl ADDR secure
> + *  < OK VALUE
> + *
> + * .. code-block:: none
> + *
> + *  > readl ADDR space=root
> + *  < OK VALUE
> + *
> + * .. code-block:: none
> + *
>   *  > readq ADDR
>   *  < OK VALUE
>   *
>   * .. code-block:: none
>   *
> + *  > readq ADDR secure
> + *  < OK VALUE
> + *
> + * .. code-block:: none
> + *
> + *  > readq ADDR space=root
> + *  < OK VALUE
> + *
> + * .. code-block:: none
> + *
>   *  > read ADDR SIZE
>   *  < OK DATA
>   *
>   * .. code-block:: none
>   *
> + *  > read ADDR SIZE secure
> + *  < OK DATA
> + *
> + * .. code-block:: none
> + *
> + *  > read ADDR SIZE space=root
> + *  < OK DATA
> + *
> + * .. code-block:: none
> + *
>   *  > write ADDR SIZE DATA
>   *  < OK
>   *
>   * .. code-block:: none
>   *
> + *  > write ADDR SIZE DATA secure
> + *  < OK
> + *
> + * .. code-block:: none
> + *
> + *  > write ADDR SIZE DATA space=root
> + *  < OK
> + *
> + * .. code-block:: none
> + *
>   *  > b64read ADDR SIZE
>   *  < OK B64_DATA
>   *
>   * .. code-block:: none
>   *
> + *  > b64read ADDR SIZE secure
> + *  < OK B64_DATA
> + *
> + * .. code-block:: none
> + *
> + *  > b64read ADDR SIZE space=root
> + *  < OK B64_DATA
> + *
> + * .. code-block:: none
> + *
>   *  > b64write ADDR SIZE B64_DATA
>   *  < OK
> + * .. code-block:: none
There are a few places where the blank line before
``.. code-block:: none`` is missing (around writel and
b64write sections). RST requires a blank ``*`` line
before every directive, otherwise the doc build will
break or silently mis-render.

> + *
> + *  > b64write ADDR SIZE B64_DATA secure
> + *  < OK
> + * .. code-block:: none
> + *
> + *  > b64write ADDR SIZE B64_DATA space=root
> + *  < OK
>   *
>   * .. code-block:: none
>   *
>   *  > memset ADDR SIZE VALUE
>   *  < OK
>   *
> + * .. code-block:: none
> + *
> + *  > memset ADDR SIZE VALUE secure
> + *  < OK
> + *
> + * .. code-block:: none
> + *
> + *  > memset ADDR SIZE VALUE space=root
> + *  < OK
The documentation is very thorough but also very
repetitive -- every command x every attrs variant gets
its own code-block. It might be worth consolidating
this into a single description of the attrs syntax
followed by a note that it applies to all memory
commands. That would cut ~80 lines while keeping the
same information.

Thanks,
Chao
> + *
>   * ADDR, SIZE, VALUE are all integers parsed with strtoul() with a base of 0.
>   * For 'memset' a zero size is permitted and does nothing.
>   *
> @@ -353,6 +489,141 @@ static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name,
>      *disconnected = qdev_intercept_gpio_out(dev, icpt, name, n);
>  }
>  
> +static bool qtest_parse_mem_attrs(CharFrontend *chr, const char *arg,
> +                                  MemTxAttrs *attrs)
> +{
> +    if (!arg) {
> +        *attrs = MEMTXATTRS_UNSPECIFIED;
> +        return true;
> +    }
> +
> +    if (strcmp(arg, "secure") == 0) {
> +        *attrs = (MemTxAttrs){ .secure = 1 };
> +        return true;
> +    }
> +
> +    if (strncmp(arg, "space=", 6) == 0) {
> +        const char *space = arg + 6;
> +        ARMSecuritySpace sec_space;
> +
> +        if (!target_arm() && !target_aarch64()) {
> +            qtest_send(chr, "ERR space=<...> is Arm-specific\n");
> +            return false;
> +        }
> +
> +        if (strcmp(space, "non-secure") == 0) {
> +            sec_space = ARMSS_NonSecure;
> +        } else if (strcmp(space, "secure") == 0) {
> +            sec_space = ARMSS_Secure;
> +        } else if (strcmp(space, "root") == 0) {
> +            sec_space = ARMSS_Root;
> +        } else if (strcmp(space, "realm") == 0) {
> +            sec_space = ARMSS_Realm;
> +        } else {
> +            qtest_send(chr, "ERR invalid space value. Valid space: "
> +                            "secure/non-secure/root/realm\n");
> +            return false;
> +        }
> +
> +        *attrs = (MemTxAttrs){
> +            .space = sec_space,
> +            .secure = arm_space_is_secure(sec_space),
> +        };
> +        return true;
> +    }
> +
> +    qtest_send(chr, "ERR invalid attrs argument\n");
> +    return false;
> +}
> +
> +static bool qtest_get_mem_as(CharFrontend *chr, MemTxAttrs attrs,
> +                             AddressSpace **as)
> +{
> +    int asidx;
> +
> +    /*
> +     * cpu_asidx_from_attrs mainly uses attrs to call ->asidx_from_attrs. We use
> +     * first_cpu as it's readily available.
> +     */
> +
> +    asidx = cpu_asidx_from_attrs(first_cpu, attrs);
> +    *as = cpu_get_address_space(first_cpu, asidx);
> +    if (!*as) {
> +        qtest_send(chr, "ERR address space unavailable for attrs\n");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void qtest_send_memtx_error(CharFrontend *chr, MemTxResult result)
> +{
> +    qtest_sendf(chr, "ERR memory access failed 0x%x\n", result);
> +}
> +
> +static MemTxResult qtest_write_sized(AddressSpace *as, uint64_t addr,
> +                                     MemTxAttrs attrs, uint64_t value,
> +                                     char size)
> +{
> +    switch (size) {
> +    case 'b': {
> +        uint8_t data = value;
> +        return address_space_write(as, addr, attrs, &data, 1);
> +    }
> +    case 'w': {
> +        uint16_t data = value;
> +        tswap16s(&data);
> +        return address_space_write(as, addr, attrs, &data, 2);
> +    }
> +    case 'l': {
> +        uint32_t data = value;
> +        tswap32s(&data);
> +        return address_space_write(as, addr, attrs, &data, 4);
> +    }
> +    case 'q': {
> +        uint64_t data = value;
> +        tswap64s(&data);
> +        return address_space_write(as, addr, attrs, &data, 8);
> +    }
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static MemTxResult qtest_read_sized(AddressSpace *as, uint64_t addr,
> +                                    MemTxAttrs attrs, char size,
> +                                    uint64_t *value)
> +{
> +    switch (size) {
> +    case 'b': {
> +        uint8_t data = 0;
> +        MemTxResult result = address_space_read(as, addr, attrs, &data, 1);
> +        *value = data;
> +        return result;
> +    }
> +    case 'w': {
> +        uint16_t data = 0;
> +        MemTxResult result = address_space_read(as, addr, attrs, &data, 2);
> +        *value = tswap16(data);
> +        return result;
> +    }
> +    case 'l': {
> +        uint32_t data = 0;
> +        MemTxResult result = address_space_read(as, addr, attrs, &data, 4);
> +        *value = tswap32(data);
> +        return result;
> +    }
> +    case 'q': {
> +        uint64_t data = 0;
> +        MemTxResult result = address_space_read(as, addr, attrs, &data, 8);
> +        *value = tswap64(data);
> +        return result;
> +    }
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  static void qtest_process_command(CharFrontend *chr, gchar **words)
>  {
>      const gchar *command;
> @@ -510,33 +781,38 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>                 strcmp(words[0], "writeq") == 0) {
>          uint64_t addr;
>          uint64_t value;
> +        bool has_attrs;
> +        MemTxResult result;
> +        MemTxAttrs attrs;
> +        AddressSpace *as;
>          int ret;
>  
>          g_assert(words[1] && words[2]);
> +        if (words[3] && words[4]) {
> +            qtest_send(chr, "ERR too many arguments\n");
> +            return;
> +        }
>          ret = qemu_strtou64(words[1], NULL, 0, &addr);
>          g_assert(ret == 0);
>          ret = qemu_strtou64(words[2], NULL, 0, &value);
>          g_assert(ret == 0);
> +        has_attrs = words[3] != NULL;
> +        if (!has_attrs) {
> +            qtest_write_sized(first_cpu->as, addr,
> +                              MEMTXATTRS_UNSPECIFIED,
> +                              value, words[0][5]);
> +            qtest_send(chr, "OK\n");
> +            return;
> +        }
> +        if (!qtest_parse_mem_attrs(chr, words[3], &attrs) ||
> +            !qtest_get_mem_as(chr, attrs, &as)) {
> +            return;
> +        }
>  
> -        if (words[0][5] == 'b') {
> -            uint8_t data = value;
> -            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                                &data, 1);
> -        } else if (words[0][5] == 'w') {
> -            uint16_t data = value;
> -            tswap16s(&data);
> -            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                                &data, 2);
> -        } else if (words[0][5] == 'l') {
> -            uint32_t data = value;
> -            tswap32s(&data);
> -            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                                &data, 4);
> -        } else if (words[0][5] == 'q') {
> -            uint64_t data = value;
> -            tswap64s(&data);
> -            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                                &data, 8);
> +        result = qtest_write_sized(as, addr, attrs, value, words[0][5]);
> +        if (result != MEMTX_OK) {
> +            qtest_send_memtx_error(chr, result);
> +            return;
>          }
>          qtest_send(chr, "OK\n");
>      } else if (strcmp(words[0], "readb") == 0 ||
> @@ -544,51 +820,83 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>                 strcmp(words[0], "readl") == 0 ||
>                 strcmp(words[0], "readq") == 0) {
>          uint64_t addr;
> -        uint64_t value = UINT64_C(-1);
> +        uint64_t value = 0;
> +        bool has_attrs;
> +        MemTxResult result;
> +        MemTxAttrs attrs;
> +        AddressSpace *as;
>          int ret;
>  
>          g_assert(words[1]);
> +        if (words[2] && words[3]) {
> +            qtest_send(chr, "ERR too many arguments\n");
> +            return;
> +        }
>          ret = qemu_strtou64(words[1], NULL, 0, &addr);
>          g_assert(ret == 0);
> +        has_attrs = words[2] != NULL;
> +        if (!has_attrs) {
> +            qtest_read_sized(first_cpu->as, addr,
> +                             MEMTXATTRS_UNSPECIFIED,
> +                             words[0][4], &value);
> +            qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
> +            return;
> +        }
> +        if (!qtest_parse_mem_attrs(chr, words[2], &attrs) ||
> +            !qtest_get_mem_as(chr, attrs, &as)) {
> +            return;
> +        }
>  
> -        if (words[0][4] == 'b') {
> -            uint8_t data;
> -            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                               &data, 1);
> -            value = data;
> -        } else if (words[0][4] == 'w') {
> -            uint16_t data;
> -            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                               &data, 2);
> -            value = tswap16(data);
> -        } else if (words[0][4] == 'l') {
> -            uint32_t data;
> -            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                               &data, 4);
> -            value = tswap32(data);
> -        } else if (words[0][4] == 'q') {
> -            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                               &value, 8);
> -            tswap64s(&value);
> +        result = qtest_read_sized(as, addr, attrs, words[0][4], &value);
> +        if (result != MEMTX_OK) {
> +            qtest_send_memtx_error(chr, result);
> +            return;
>          }
>          qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
>      } else if (strcmp(words[0], "read") == 0) {
>          g_autoptr(GString) enc = NULL;
>          uint64_t addr, len;
>          uint8_t *data;
> +        bool has_attrs;
> +        MemTxResult result;
> +        MemTxAttrs attrs;
> +        AddressSpace *as;
>          int ret;
>  
>          g_assert(words[1] && words[2]);
> +        if (words[3] && words[4]) {
> +            qtest_send(chr, "ERR too many arguments\n");
> +            return;
> +        }
>          ret = qemu_strtou64(words[1], NULL, 0, &addr);
>          g_assert(ret == 0);
>          ret = qemu_strtou64(words[2], NULL, 0, &len);
>          g_assert(ret == 0);
>          /* We'd send garbage to libqtest if len is 0 */
>          g_assert(len);
> +        has_attrs = words[3] != NULL;
> +        if (!has_attrs) {
> +            data = g_malloc0(len);
> +            address_space_read(first_cpu->as, addr,
> +                               MEMTXATTRS_UNSPECIFIED,
> +                               data, len);
> +            enc = qemu_hexdump_line(NULL, data, len, 0, 0);
> +            qtest_sendf(chr, "OK 0x%s\n", enc->str);
> +            g_free(data);
> +            return;
> +        }
> +        if (!qtest_parse_mem_attrs(chr, words[3], &attrs) ||
> +            !qtest_get_mem_as(chr, attrs, &as)) {
> +            return;
> +        }
>  
>          data = g_malloc(len);
> -        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> -                           len);
> +        result = address_space_read(as, addr, attrs, data, len);
> +        if (result != MEMTX_OK) {
> +            g_free(data);
> +            qtest_send_memtx_error(chr, result);
> +            return;
> +        }
>  
>          enc = qemu_hexdump_line(NULL, data, len, 0, 0);
>  
> @@ -599,17 +907,45 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>          uint64_t addr, len;
>          uint8_t *data;
>          gchar *b64_data;
> +        bool has_attrs;
> +        MemTxResult result;
> +        MemTxAttrs attrs;
> +        AddressSpace *as;
>          int ret;
>  
>          g_assert(words[1] && words[2]);
> +        if (words[3] && words[4]) {
> +            qtest_send(chr, "ERR too many arguments\n");
> +            return;
> +        }
>          ret = qemu_strtou64(words[1], NULL, 0, &addr);
>          g_assert(ret == 0);
>          ret = qemu_strtou64(words[2], NULL, 0, &len);
>          g_assert(ret == 0);
> +        has_attrs = words[3] != NULL;
> +        if (!has_attrs) {
> +            data = g_malloc0(len);
> +            address_space_read(first_cpu->as, addr,
> +                               MEMTXATTRS_UNSPECIFIED,
> +                               data, len);
> +            b64_data = g_base64_encode(data, len);
> +            qtest_sendf(chr, "OK %s\n", b64_data);
> +            g_free(data);
> +            g_free(b64_data);
> +            return;
> +        }
> +        if (!qtest_parse_mem_attrs(chr, words[3], &attrs) ||
> +            !qtest_get_mem_as(chr, attrs, &as)) {
> +            return;
> +        }
>  
>          data = g_malloc(len);
> -        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> -                           len);
> +        result = address_space_read(as, addr, attrs, data, len);
> +        if (result != MEMTX_OK) {
> +            g_free(data);
> +            qtest_send_memtx_error(chr, result);
> +            return;
> +        }
>          b64_data = g_base64_encode(data, len);
>          qtest_sendf(chr, "OK %s\n", b64_data);
>  
> @@ -619,13 +955,22 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>          uint64_t addr, len, i;
>          uint8_t *data;
>          size_t data_len;
> +        bool has_attrs;
> +        MemTxResult result;
> +        MemTxAttrs attrs;
> +        AddressSpace *as;
>          int ret;
>  
>          g_assert(words[1] && words[2] && words[3]);
> +        if (words[4] && words[5]) {
> +            qtest_send(chr, "ERR too many arguments\n");
> +            return;
> +        }
>          ret = qemu_strtou64(words[1], NULL, 0, &addr);
>          g_assert(ret == 0);
>          ret = qemu_strtou64(words[2], NULL, 0, &len);
>          g_assert(ret == 0);
> +        has_attrs = words[4] != NULL;
>  
>          data_len = strlen(words[3]);
>          if (data_len < 3) {
> @@ -642,46 +987,96 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>                  data[i] = 0;
>              }
>          }
> -        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> -                            len);
> +        if (!has_attrs) {
> +            address_space_write(first_cpu->as, addr,
> +                                MEMTXATTRS_UNSPECIFIED,
> +                                data, len);
> +            g_free(data);
> +            qtest_send(chr, "OK\n");
> +            return;
> +        }
> +        if (!qtest_parse_mem_attrs(chr, words[4], &attrs) ||
> +            !qtest_get_mem_as(chr, attrs, &as)) {
> +            g_free(data);
> +            return;
> +        }
> +        result = address_space_write(as, addr, attrs, data, len);
>          g_free(data);
> +        if (result != MEMTX_OK) {
> +            qtest_send_memtx_error(chr, result);
> +            return;
> +        }
>  
>          qtest_send(chr, "OK\n");
>      } else if (strcmp(words[0], "memset") == 0) {
>          uint64_t addr, len;
> -        uint8_t *data;
>          unsigned long pattern;
> +        bool has_attrs;
> +        MemTxResult result;
> +        MemTxAttrs attrs;
> +        AddressSpace *as;
>          int ret;
>  
>          g_assert(words[1] && words[2] && words[3]);
> +        if (words[4] && words[5]) {
> +            qtest_send(chr, "ERR too many arguments\n");
> +            return;
> +        }
>          ret = qemu_strtou64(words[1], NULL, 0, &addr);
>          g_assert(ret == 0);
>          ret = qemu_strtou64(words[2], NULL, 0, &len);
>          g_assert(ret == 0);
>          ret = qemu_strtoul(words[3], NULL, 0, &pattern);
>          g_assert(ret == 0);
> +        has_attrs = words[4] != NULL;
> +        if (!has_attrs) {
> +            if (len) {
> +                uint8_t *data = g_malloc(len);
> +
> +                memset(data, pattern, len);
> +                address_space_write(first_cpu->as, addr,
> +                                    MEMTXATTRS_UNSPECIFIED,
> +                                    data, len);
> +                g_free(data);
> +            }
> +            qtest_send(chr, "OK\n");
> +            return;
> +        }
> +        if (!qtest_parse_mem_attrs(chr, words[4], &attrs) ||
> +            !qtest_get_mem_as(chr, attrs, &as)) {
> +            return;
> +        }
>  
>          if (len) {
> -            data = g_malloc(len);
> -            memset(data, pattern, len);
> -            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                                data, len);
> -            g_free(data);
> +            result = address_space_set(as, addr, pattern, len, attrs);
> +            if (result != MEMTX_OK) {
> +                qtest_send_memtx_error(chr, result);
> +                return;
> +            }
>          }
>  
>          qtest_send(chr, "OK\n");
> -    }  else if (strcmp(words[0], "b64write") == 0) {
> +    } else if (strcmp(words[0], "b64write") == 0) {
>          uint64_t addr, len;
>          uint8_t *data;
>          size_t data_len;
>          gsize out_len;
> +        bool has_attrs;
> +        MemTxResult result;
> +        MemTxAttrs attrs;
> +        AddressSpace *as;
>          int ret;
>  
>          g_assert(words[1] && words[2] && words[3]);
> +        if (words[4] && words[5]) {
> +            qtest_send(chr, "ERR too many arguments\n");
> +            return;
> +        }
>          ret = qemu_strtou64(words[1], NULL, 0, &addr);
>          g_assert(ret == 0);
>          ret = qemu_strtou64(words[2], NULL, 0, &len);
>          g_assert(ret == 0);
> +        has_attrs = words[4] != NULL;
>  
>          data_len = strlen(words[3]);
>          if (data_len < 3) {
> @@ -697,8 +1092,22 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>              out_len = MIN(out_len, len);
>          }
>  
> -        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> -                            len);
> +        if (!has_attrs) {
> +            address_space_write(first_cpu->as, addr,
> +                                MEMTXATTRS_UNSPECIFIED,
> +                                data, len);
> +            qtest_send(chr, "OK\n");
> +            return;
> +        }
> +        if (!qtest_parse_mem_attrs(chr, words[4], &attrs) ||
> +            !qtest_get_mem_as(chr, attrs, &as)) {
> +            return;
> +        }
> +        result = address_space_write(as, addr, attrs, data, len);
> +        if (result != MEMTX_OK) {
> +            qtest_send_memtx_error(chr, result);
> +            return;
> +        }
>  
>          qtest_send(chr, "OK\n");
>      } else if (strcmp(words[0], "endianness") == 0) {
> -- 
> 2.34.1
> 

