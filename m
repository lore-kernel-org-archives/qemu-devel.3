Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711CDCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 23:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v30kW-0000LF-4H; Sun, 28 Sep 2025 19:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30kU-0000L6-QH
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:24:10 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30kH-00039t-QO
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:24:10 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b2bddecc51aso606057366b.2
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 16:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759101830; x=1759706630; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U425Yw16NkMJ85W1VHEiWxE8NcLlX0nDFIbGZLooW4w=;
 b=TKHLQpKeTOGnJjPgA2tq6QsiN4h42A69MoLgehYJv79KJuZUoxua/bbtBgb6hAi1sS
 Jpdle9KsFK+aDWsTTxETLM080DpG+KblLhHivG0sfTQPd/x1S6zXYLeUjRjq9eh5rUr5
 O/mtVo8xs3nd+kpPqxg246TG+JxiSTRgHBI0FAN/M722/NiPY7iM8cDF536Kv1VfijDl
 Ewj4fJjCFRCadw6EYiCLks+CH4+FHUIormbfrAAgsFUynFVAHrW80CMyCD9ff6xQMwpb
 yvNqvLmP2ikJgb30OHZW+ZERAq6r8w0uV5Err1gSY2PSwysyVXHxVCtz8FjkuFlO7t3l
 xlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759101830; x=1759706630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U425Yw16NkMJ85W1VHEiWxE8NcLlX0nDFIbGZLooW4w=;
 b=aNbSYfLDLjuBUV5aGkq/XfHe1HUM3ymIsOBmOthz7GllyMhMMXB+BCXC5C9+zNt84J
 lw9bpxPYWise1cy0PEscCdvWLh3ykSrSSi89bLPVO5eCXOu989SEcRSkvXAIBj42uiU9
 kIBnk4VP5AWGpugMhx76bxFjijBNqN2zTUjh0cyjyj+aokDtOw97KWNHhIlFBw8BBaWL
 UMddLezdhd7i9oW0VkviMg5qjeQD1f8Rg7lJgadpVBzjUDEOxs8Q0DwZLpXYR0pVTUxN
 iHXUVRUXJ+EMunlE3ZgV6ju3+btjILkwPbytP/4ceY2BlXblMFmdKGGgPWgc+ykUMPZz
 rdeQ==
X-Gm-Message-State: AOJu0YxQf4miiFY+/84DFTfcGz75LnRs2pehbj0EIKbYeluSSsiCbXXL
 2rbGMX+VHr3Lqn0ywjm4gO4iiAj76EE5ICLIIssqyGFOf2r6GTqhW8Ko0fgVsTssdU0HXsXXX8q
 TnluaKraOSkFtTX4oPua3Kemd+krTgA4=
X-Gm-Gg: ASbGnctQ5fhErQjeSnUXkPqMkzwmijWG8XUus6MT+wdA89JHa+s2CjkcW/c7ouerdb6
 Y1GtjhUEUJzLBJHxMcXG3Tjd001934UFgz/0GOCrwJd4Vl04Opg1BNtU8Urvmd44pP1nrxj6lGG
 ul3r5yISeYmyTw9C9lqzJr+iwKxm6xwhc8+FQvlAKwI4r77qApJU/veEf67gNqoQ+IIifOOKd+R
 +pA4SFr1C8nFq5k8SWinR+BNpCp17Kz0TBKaA==
X-Google-Smtp-Source: AGHT+IGguC9PLRzXxT5gxUw0xzO75NJPZHIvetElQpF2hEQbJ1KeLcThEoFtEIpQ8BZAPuKS43V01TpQJca57Viz7V0=
X-Received: by 2002:a17:907:9815:b0:b30:ea06:af29 with SMTP id
 a640c23a62f3a-b34b7fbb555mr1748069766b.16.1759101829738; Sun, 28 Sep 2025
 16:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250924020735.3909216-1-richard.henderson@linaro.org>
 <20250924020735.3909216-3-richard.henderson@linaro.org>
In-Reply-To: <20250924020735.3909216-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 09:23:23 +1000
X-Gm-Features: AS18NWCDVkDRH-pqZtH0egTArrscZ1I_eGYWA8pjIlT5aEf-oBSn3JWQLItiZKc
Message-ID: <CAKmqyKPuGnOTEV9ZCOvaO4_k7VTsy2NVg9DE0O9xgnukVs8pTw@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Properly unlink a TB linked to itself
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, jonwilson030981@googlemail.com, 
 =?UTF-8?B?5p2O5aiB5aiB?= <liweiwei@kubuds.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
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

On Wed, Sep 24, 2025 at 12:09=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When we remove dest from orig's links, we lose the link
> that we rely on later to reset links.  This can lead to
> failure to release from spinlock with self-modifying code.
>
> Reported-by: =E6=9D=8E=E5=A8=81=E5=A8=81 <liweiwei@kubuds.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/tb-maint.c              |  8 +++++
>  tests/tcg/riscv64/tb-link.c       | 60 +++++++++++++++++++++++++++++++
>  tests/tcg/riscv64/Makefile.target |  1 +
>  3 files changed, 69 insertions(+)
>  create mode 100644 tests/tcg/riscv64/tb-link.c
>
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 0048316f99..e6d45c9c12 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -836,6 +836,14 @@ static inline void tb_remove_from_jmp_list(Translati=
onBlock *orig, int n_orig)
>       * We first acquired the lock, and since the destination pointer mat=
ches,
>       * we know for sure that @orig is in the jmp list.
>       */
> +    if (dest =3D=3D orig) {
> +        /*
> +         * In the case of a TB that links to itself, removing the entry
> +         * from the list means that it won't be present later during
> +         * tb_jmp_unlink -- unlink now.
> +         */
> +        tb_reset_jump(orig, n_orig);
> +    }
>      pprev =3D &dest->jmp_list_head;
>      TB_FOR_EACH_JMP(dest, tb, n) {
>          if (tb =3D=3D orig && n =3D=3D n_orig) {
> diff --git a/tests/tcg/riscv64/tb-link.c b/tests/tcg/riscv64/tb-link.c
> new file mode 100644
> index 0000000000..b6fcca8668
> --- /dev/null
> +++ b/tests/tcg/riscv64/tb-link.c
> @@ -0,0 +1,60 @@
> +#include <assert.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <pthread.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +
> +
> +int main()
> +{
> +    /*
> +     * ## 1. RISC-V machine code.
> +     * Assembly:
> +     *   L: j L          ; Jump to self (spin).
> +     *   li a0, 42       ; Place 42 into the return value register a0.
> +     *   ret             ; Return to caller.
> +     */
> +    static const uint32_t machine_code[] =3D {
> +        0x0000006f, /* jal zero, #0 */
> +        0x02a00513, /* addi a0, zero, 42 */
> +        0x00008067  /* jalr zero, ra, 0 */
> +    };
> +    size_t code_size =3D sizeof(machine_code);
> +    int tmp;
> +    pthread_t thread_id;
> +    void *thread_return_value;
> +    uint32_t *buffer;
> +
> +    /* ## 2. Allocate executable memory. */
> +    buffer =3D mmap(
> +        NULL,
> +        code_size,
> +        PROT_READ | PROT_WRITE | PROT_EXEC,
> +        MAP_PRIVATE | MAP_ANONYMOUS,
> +        -1, 0
> +    );
> +    assert(buffer !=3D MAP_FAILED);
> +
> +    /* ## 3. Copy machine code into buffer. */
> +    memcpy(buffer, machine_code, code_size);
> +
> +    /* ## 4. Execute the code in a separate thread. */
> +    tmp =3D pthread_create(&thread_id, NULL, (void *(*)(void *))buffer, =
NULL);
> +    assert(tmp =3D=3D 0);
> +
> +    /*
> +     * Wait a second and then try to patch the generated code to get the
> +     * runner thread to get unstuck by patching the spin jump.
> +     */
> +    sleep(1);
> +    buffer[0] =3D 0x00000013;  /* nop */
> +    __builtin___clear_cache((char *)buffer, (char *)(buffer + 1));
> +
> +    tmp =3D pthread_join(thread_id, &thread_return_value);
> +    assert(tmp =3D=3D 0);
> +
> +    tmp =3D (intptr_t)thread_return_value;
> +    assert(tmp =3D=3D 42);
> +    return 0;
> +}
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefi=
le.target
> index 4da5b9a3b3..ba684616fd 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -4,6 +4,7 @@
>  VPATH +=3D $(SRC_PATH)/tests/tcg/riscv64
>  TESTS +=3D test-div
>  TESTS +=3D noexec
> +TESTS +=3D tb-link
>
>  # Disable compressed instructions for test-noc
>  TESTS +=3D test-noc
> --
> 2.43.0
>
>

