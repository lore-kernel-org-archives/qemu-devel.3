Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94900606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=Lbprr2UD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFKh-0000AH-63; Tue, 17 Nov 2026 04:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFKf-00009s-LP
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:18:29 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFKc-0007Sc-L7
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:18:29 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c4d2b741ed9so712067166b.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794907105; x=1795511905; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=goNmIIUIjh3CLGaPuvxf9iruCenabp9IRJLA1lhHZvE=;
 b=Lbprr2UDayZ0VMOzy4a8HwqobTreTuSIPcbH5Gsoysh4YMULEmv+nCcBXlJCiwxMez
 fgEGMNG+r/LV8tkxSG3MqibucNoIPASmXZNSiTlK8hBCMLnBxbQ9+2s2pqt+HV1vTZuy
 6ahFbWMznvm8UOFTxTi3rxOHa/lrfE7VC6Z0XwkBd4MLMy7FULDsUHNDMbeqeVLWd8T3
 pwuSI0nzOfv8C7e/eG8XbEyLagjgmGXhGvyKEgD3STBy1MksPks8EZ7XYCOBXxuIzIkO
 V9pMege0aso9ViPNM6nem82aUhHabkANbfAuwAoIOnLrPR+y0bNF6/X89TQXmw5JoOrk
 dXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794907105; x=1795511905;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=goNmIIUIjh3CLGaPuvxf9iruCenabp9IRJLA1lhHZvE=;
 b=y0buQQOMxn9WB5RJS5P+UCwKlQl76ofNWRdi6WqiBHDaoWZVvexDE5+hg/p3xQ0J0E
 5ucIxErAucWf3spLwUgKVI9XLsxtTJv8b5CKUHk2giId4WNCiGIbVwXv+YIIo2mRjFik
 vF3pAcJlu6bU0RSZ6T7oDXpkC/a3Apo5RH9hIHd8ehM/EapmJY0xye1WZkaFsZ01mJl6
 4at5zklO1qKvXPXWv5UQyKmVdRkjZkke32xLZNiRjlaPyBu4EpqW2ZewqXm9ZrH25oF3
 PMAJbN2B2DZe2+Qww8N9UokSdzi2xLmwwzxQKf8Mg0lVecxl9fxr653g70sl52x7sCWR
 XuUw==
X-Gm-Message-State: APuU4Z8aKWf12O/b2ovPSFBA2VLOK2nvhzqRh7X1hqEt+Rlt2VwMag5o
 1BBDCNVluuLDxu3NI4kxrmLTuDieS51f4Hi/FzYnQQXjqaXn8xQWOJcAWao1TuTznZlyRecDM1b
 q+NLF9sgqdEL20i4IRGblnEm6uP2fSCLUa5agdPylm4kv8Podztdvk/rhjDVAAzMmLEMAeI6CQ1
 TaYsuSc8rYZ+MBb6sNp/Qm27bJ8U6d67LjZSrjKm8R+VM=
X-Gm-Gg: AYBFou0e0JeB9j7HwuUXb4mxBoKCWrcQsXx+K8l66w8kefwtcPpEmW6+ClSx4eUdA0m
 6xtsuoZo01ejYetT2QON/Q1Vr1QgksBlNGh2bPUi85oqCRxhjjlbQMTXFwSTAkkuSMBaFZUW0kv
 9cAE1cAqQdlbYIDM/5OHjtI/a5mgFs7FSP0w6LwVZU82iihPwP01HA+CQSWRLVBOo25j4xHZsTJ
 xIeqAFvA4lS1DdrIFDAGJjQlnuYBn1EvMBXGcZkoRc+AQoXVnkqRRYPNtRwZPgNk6S4ScZaTE91
 PJ/oqtwsDV0gSnLKuiqMRJEJYDMPLH12fd0dk+YeZJA+YQQz6EkIrpkeKetS98C+x5FSisF1ePM
 k8rCo4VQ0EFPofeWAfpoeLiN1oEOWnzMKHmppII0Gp5760fiZAGFxow+HN9H6b4EzG1rkpqX9rJ
 Da3tK5ZqvXBcfqwlhTpueajS8amjDJFiLLKb8ME/rEFZ9kFpu5zdRrl50kVfemphaJaLKmz1H1Z
 S3tLdcRrPN6Nf/3+K/+IpEUEBiGNTBiFgEoeLh5kHvs6bJoL6YwGng3KEBjoi8H2uRouAOA6Sfa
 nVH1Kf87P5RVTJH2QRwj+ySIyuDvqJk8k5yoSWkwHvJgmfzGUz6SKpM4UDtk9QFeul4=
X-Received: by 2002:a17:906:99c2:b0:c29:4a1f:76be with SMTP id
 a640c23a62f3a-c50963adb21mr974519566b.20.1794907104851; 
 Tue, 17 Nov 2026 01:18:24 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b23b1fsm521757866b.21.2026.11.17.01.18.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:18:22 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6b6e7a05225so6827785a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:18:22 -0800 (PST)
X-Received: by 2002:a05:6402:15cc:b0:6b5:965f:98b2 with SMTP id
 4fb4d7f45d1cf-6b7c0ce6a05mr7426277a12.36.1794907102216; Tue, 17 Nov 2026
 01:18:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-6-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-6-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 17:18:10 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZMjDCUnOf5QAni3v0ZWVmmd0LYRh5pVrFoeiY+iyKnuQ@mail.gmail.com>
X-Gm-Features: AclHuK_pR52QMhYRLJpElGzAirzwgk7EVoggRniBkvEvKxBrKw025Z21csbvrEI
Message-ID: <CAMXXpfZMjDCUnOf5QAni3v0ZWVmmd0LYRh5pVrFoeiY+iyKnuQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] hw/riscv: add n-trace IndirectBranchHist
 rv-trace-message
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003b885a06607560ec"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000003b885a06607560ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks

On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semichastnov <
antikostya2@gmail.com> wrote:

> Add generation, encoding and sending logic for N-Trace
> IndirectBranchHist message.
>
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> Signed-off-by: Alexei Filippov <halip0503@gmail.com>
> ---
>  hw/riscv/rv-trace-messages.c | 42 +++++++++++++++++++++
>  hw/riscv/rv-trace-messages.h |  4 ++
>  hw/riscv/trace-encoder.c     | 87
> ++++++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/trace-encoder.h     | 10 +++++
>  target/riscv/trace_helper.c  |  3 +-
>  5 files changed, 145 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
> index 0b90d6a437..2ee38c4354 100644
> --- a/hw/riscv/rv-trace-messages.c
> +++ b/hw/riscv/rv-trace-messages.c
> @@ -354,12 +354,16 @@ typedef enum {
>  typedef enum {
>      WIDTH_TCODE  =3D 6,
>      WIDTH_SYNC   =3D 4,
> +    WIDTH_BTYPE  =3D 2,
>      WIDTH_ICNT   =3D 22,
>      WIDTH_FADDR  =3D 63,
> +    WIDTH_UADDR  =3D 63,
> +    WIDTH_HIST   =3D 32,
>  } NTraceFieldWidth;
>
>  typedef enum {
>      TCODE_PROG_TRACE_SYNC        =3D 0x9,
> +    TCODE_INDIRECT_BRANCH_HIST   =3D 0x1c,
>  } NTraceTcodeFieldValues;
>
>  typedef enum {
> @@ -387,6 +391,13 @@ typedef struct NTraceFieldPayload {
>          .value =3D (val),      \
>      }
>
> +#define PAYLOAD_BTYPE(val)    \
> +    {                         \
> +        .type =3D FIELD_FIXED,  \
> +        .width =3D WIDTH_BTYPE, \
> +        .value =3D (val),       \
> +    }
> +
>  #define PAYLOAD_ICNT(val)    \
>      {                        \
>          .type =3D FIELD_VAR,   \
> @@ -400,6 +411,20 @@ typedef struct NTraceFieldPayload {
>          .width =3D WIDTH_FADDR, \
>          .value =3D (val),       \
>      }
> +
> +#define PAYLOAD_UADDR(val)    \
> +    {                         \
> +        .type =3D FIELD_VAR,    \
> +        .width =3D WIDTH_UADDR, \
> +        .value =3D (val),       \
> +    }
> +
> +#define PAYLOAD_HIST(val)    \
> +    {                        \
> +        .type =3D FIELD_VAR,   \
> +        .width =3D WIDTH_HIST, \
> +        .value =3D (val),      \
> +    }
>  #define PAYLOAD_END()      \
>      {                      \
>          .type =3D FIELD_END, \
> @@ -492,3 +517,20 @@ size_t
> rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr)
>      return rv_ntrace_gen_encoded_msg(buf, msg_fields);
>  }
>
> +size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btyp=
e,
> +                                              uint32_t icnt, uint64_t
> uaddr,
> +                                              uint32_t hist)
> +{
> +    const NTraceFieldPayload msg_fields[] =3D {
> +        PAYLOAD_TCODE(TCODE_INDIRECT_BRANCH_HIST),
> +        /* SRC field is not supported for now */
> +        PAYLOAD_BTYPE(btype),
> +        PAYLOAD_ICNT(icnt),
> +        PAYLOAD_UADDR(uaddr >> 1),
> +        PAYLOAD_HIST(hist),
> +        /* TSTAMP field is not supported for now */
> +        PAYLOAD_END(),
> +    };
> +
> +    return rv_ntrace_gen_encoded_msg(buf, msg_fields);
> +}
> diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
> index 635e498393..d113129d65 100644
> --- a/hw/riscv/rv-trace-messages.h
> +++ b/hw/riscv/rv-trace-messages.h
> @@ -38,4 +38,8 @@ size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
>                                       bool notify, bool updiscon);
>
>  size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t
> faddr);
> +size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btyp=
e,
> +                                              uint32_t icnt, uint64_t
> uaddr,
> +                                              uint32_t hist);
> +
>  #endif
> diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
> index 46501e4f03..fafafb7b9b 100644
> --- a/hw/riscv/trace-encoder.c
> +++ b/hw/riscv/trace-encoder.c
> @@ -31,6 +31,11 @@
>
>  #define TRACE_MAX_BRANCHES 31
>
> +static uint64_t rv_ntrace_encode_uaddr(TraceEncoder *trencoder, uint64_t
> target_pc);
> +static uint32_t rv_ntrace_encode_and_reset_branch_map(TraceEncoder
> *trencoder);
> +static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
> +                                             uint64_t pc, uint32_t
> inst_len);
> +
>  static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
>  {
>      CPURISCVState *env =3D &te->cpu->env;
> @@ -478,6 +483,28 @@ static void trencoder_send_sync_msg(Object
> *trencoder_obj, uint64_t pc)
>      trencoder_send_message_smem(trencoder, msg, msg_size);
>  }
>
> +void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
> +                                         uint64_t curr_pc,
> +                                         uint32_t curr_inst_len,
> +                                         uint64_t target_pc,
> +                                         TraceBranchType btype)
> +{
> +    g_autofree uint8_t *msg =3D g_malloc0(TRACE_MSG_MAX_SIZE);
> +    uint8_t msg_size;
> +
> +    uint32_t icnt =3D rv_ntrace_get_and_reset_icnt(trencoder, curr_pc,
> curr_inst_len);
> +    uint64_t uaddr =3D rv_ntrace_encode_uaddr(trencoder, target_pc);
> +    uint32_t hist =3D rv_ntrace_encode_and_reset_branch_map(trencoder);
> +
> +    g_assert(trencoder->ntrace);
> +
> +    msg_size =3D rv_ntrace_gen_indirect_branch_hist_msg(msg, btype, icnt=
,
> uaddr, hist);
> +    trencoder->last_addr_reported =3D target_pc;
> +    trencoder->last_icnt_reset =3D target_pc;
> +
> +    trencoder_send_message_smem(trencoder, msg, msg_size);
> +}
> +
>  static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc=
)
>  {
>      g_autofree uint8_t *format2_msg =3D g_malloc0(TRACE_MSG_MAX_SIZE);
> @@ -551,6 +578,66 @@ void trencoder_send_prog_trace_sync(Object
> *trencoder_obj, uint64_t pc)
>      trencoder_send_message_smem(trencoder, msg, msg_size);
>  }
>
> +static uint64_t rv_ntrace_encode_uaddr(TraceEncoder *trencoder, uint64_t
> target_pc)
> +{
> +    return trencoder->last_addr_reported ^ target_pc;
> +}
> +
> +static uint32_t rv_ntrace_encode_and_reset_branch_map(TraceEncoder
> *trencoder)
> +{
> +    const uint32_t stop_bit =3D 1;
> +
> +    uint32_t hist =3D trencoder->branch_map;
> +
> +    if (trencoder->branches =3D=3D 0) {
> +        /*
> +         * if branches =3D=3D 0, we will overflow on bit shift, so just =
return
> +         * empty history value here (i.e. - only stop bit)
> +         */
> +        return stop_bit;
> +    }
> +
> +    /*
> +     * trencoder->branch_map stores bit 1 for NOT taken branches,
> +     * but N-Trace expects to stored bit 1 for TAKEN branches,
> +     * so, we should invert bits
> +     */
> +    hist =3D ~hist;
> +
> +    /*
> +     * Also, trencoder->branch_map is implemented in such way,
> +     * that oldest branch is LSB bit, but N-Trace format require
> +     * to HIST values be in shift-left format: the most recent branch
> +     * should be in LSB bit. So we should reverse order
> +     * of valid history bits
> +     */
> +    hist =3D revbit32(hist) >> (32 - trencoder->branches);
> +
> +    /* And finally N-Trace expects bit 1 as stop bit at the MSB position
> */
> +    hist =3D deposit32(hist, trencoder->branches, 1, stop_bit);
> +
> +    trencoder->branch_map =3D 0;
> +    trencoder->branches =3D 0;
> +
> +    return hist;
> +}
> +
> +static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
> +                                             uint64_t pc, uint32_t
> inst_len)
> +{
> +    uint64_t icnt =3D (pc + inst_len - trencoder->last_icnt_reset) / 2 +
> +                    trencoder->icnt_accumulated;
> +
> +    trencoder->last_icnt_reset =3D pc;
> +    trencoder->icnt_accumulated =3D 0;
> +
> +    if (icnt > MAKE_64BIT_MASK(0, 22)) {
> +        /* I-CNT overflow reporting is not supported for now */
> +        error_setg(&error_fatal, "N-Trace icnt overflowed");
> +    }
> +
> +    return icnt;
> +}
>
>  void trencoder_trace_trap_insn(Object *trencoder_obj,
>                                 uint64_t pc, uint32_t ecause,
> diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
> index 6551ac77f9..f8a6a254dc 100644
> --- a/hw/riscv/trace-encoder.h
> +++ b/hw/riscv/trace-encoder.h
> @@ -57,6 +57,11 @@ typedef enum {
>      BRANCH_TAKEN_UNCONDITIONAL =3D 2,
>  } TraceBranchRes;
>
> +typedef enum {
> +    BTYPE_CONTROL_FLOW =3D 0,
> +    BTYPE_EXCEPTION    =3D 2,
> +    BTYPE_INTERRUPT    =3D 3,
> +} TraceBranchType;
>
>  #define TYPE_TRACE_ENCODER "trace-encoder"
>
> @@ -64,6 +69,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER=
)
>
>  void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc);
>  void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc);
> +void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
> +                                         uint64_t curr_pc,
> +                                         uint32_t curr_inst_len,
> +                                         uint64_t target_pc,
> +                                         TraceBranchType btype);
>  void trencoder_trace_trap_insn(Object *trencoder_obj,
>                                 uint64_t pc, uint32_t ecause,
>                                 bool is_interrupt,
> diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
> index f6201e2fb9..d7763a998f 100644
> --- a/target/riscv/trace_helper.c
> +++ b/target/riscv/trace_helper.c
> @@ -36,7 +36,8 @@ void helper_trace_updiscon(CPURISCVState *env,
> target_ulong curr_pc,
>      TraceEncoder *te =3D TRACE_ENCODER(cpu->trencoder);
>
>      if (te->ntrace) {
> -        /* send IndirectBranchHist message */
> +        trencoder_send_indirect_branch_hist(te, curr_pc, curr_inst_len,
> env->pc,
> +                                            BTYPE_CONTROL_FLOW);
>      } else {
>          te->updiscon_pending =3D true;
>          te->trace_next_insn =3D true;
>
> --
> 2.43.0
>
>
>

--0000000000003b885a06607560ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Jay Chang&lt;<a href=3D"mailto:jay.chang@sifi=
ve.com" target=3D"_blank">jay.chang@sifive.com</a>&gt;<div>Thanks</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semic=
hastnov &lt;<a href=3D"mailto:antikostya2@gmail.com">antikostya2@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">A=
dd generation, encoding and sending logic for N-Trace<br>
IndirectBranchHist message.<br>
<br>
Signed-off-by: Konstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gm=
ail.com" target=3D"_blank">antikostya2@gmail.com</a>&gt;<br>
Signed-off-by: Alexei Filippov &lt;<a href=3D"mailto:halip0503@gmail.com" t=
arget=3D"_blank">halip0503@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/riscv/rv-trace-messages.c | 42 +++++++++++++++++++++<br>
=C2=A0hw/riscv/rv-trace-messages.h |=C2=A0 4 ++<br>
=C2=A0hw/riscv/trace-encoder.c=C2=A0 =C2=A0 =C2=A0| 87 ++++++++++++++++++++=
++++++++++++++++++++++++<br>
=C2=A0hw/riscv/trace-encoder.h=C2=A0 =C2=A0 =C2=A0| 10 +++++<br>
=C2=A0target/riscv/trace_helper.c=C2=A0 |=C2=A0 3 +-<br>
=C2=A05 files changed, 145 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c<br=
>
index 0b90d6a437..2ee38c4354 100644<br>
--- a/hw/riscv/rv-trace-messages.c<br>
+++ b/hw/riscv/rv-trace-messages.c<br>
@@ -354,12 +354,16 @@ typedef enum {<br>
=C2=A0typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0WIDTH_TCODE=C2=A0 =3D 6,<br>
=C2=A0 =C2=A0 =C2=A0WIDTH_SYNC=C2=A0 =C2=A0=3D 4,<br>
+=C2=A0 =C2=A0 WIDTH_BTYPE=C2=A0 =3D 2,<br>
=C2=A0 =C2=A0 =C2=A0WIDTH_ICNT=C2=A0 =C2=A0=3D 22,<br>
=C2=A0 =C2=A0 =C2=A0WIDTH_FADDR=C2=A0 =3D 63,<br>
+=C2=A0 =C2=A0 WIDTH_UADDR=C2=A0 =3D 63,<br>
+=C2=A0 =C2=A0 WIDTH_HIST=C2=A0 =C2=A0=3D 32,<br>
=C2=A0} NTraceFieldWidth;<br>
<br>
=C2=A0typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0TCODE_PROG_TRACE_SYNC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x=
9,<br>
+=C2=A0 =C2=A0 TCODE_INDIRECT_BRANCH_HIST=C2=A0 =C2=A0=3D 0x1c,<br>
=C2=A0} NTraceTcodeFieldValues;<br>
<br>
=C2=A0typedef enum {<br>
@@ -387,6 +391,13 @@ typedef struct NTraceFieldPayload {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.value =3D (val),=C2=A0 =C2=A0 =C2=A0 \<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+#define PAYLOAD_BTYPE(val)=C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D FIELD_FIXED,=C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .width =3D WIDTH_BTYPE, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .value =3D (val),=C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0#define PAYLOAD_ICNT(val)=C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D FIELD_VAR,=C2=A0 =C2=A0\<br>
@@ -400,6 +411,20 @@ typedef struct NTraceFieldPayload {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.width =3D WIDTH_FADDR, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.value =3D (val),=C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+#define PAYLOAD_UADDR(val)=C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D FIELD_VAR,=C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .width =3D WIDTH_UADDR, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .value =3D (val),=C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
+#define PAYLOAD_HIST(val)=C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D FIELD_VAR,=C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .width =3D WIDTH_HIST, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .value =3D (val),=C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0#define PAYLOAD_END()=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D FIELD_END, \<br>
@@ -492,3 +517,20 @@ size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8=
_t *buf, uint64_t faddr)<br>
=C2=A0 =C2=A0 =C2=A0return rv_ntrace_gen_encoded_msg(buf, msg_fields);<br>
=C2=A0}<br>
<br>
+size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint32_t icnt, uint64_t uaddr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint32_t hist)<br>
+{<br>
+=C2=A0 =C2=A0 const NTraceFieldPayload msg_fields[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_TCODE(TCODE_INDIRECT_BRANCH_HIST),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SRC field is not supported for now */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_BTYPE(btype),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_ICNT(icnt),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_UADDR(uaddr &gt;&gt; 1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_HIST(hist),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TSTAMP field is not supported for now */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_END(),<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 return rv_ntrace_gen_encoded_msg(buf, msg_fields);<br>
+}<br>
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h<br=
>
index 635e498393..d113129d65 100644<br>
--- a/hw/riscv/rv-trace-messages.h<br>
+++ b/hw/riscv/rv-trace-messages.h<br>
@@ -38,4 +38,8 @@ size_t rv_etrace_gen_encoded_format1(uint8_t *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool notify, bo=
ol updiscon);<br>
<br>
=C2=A0size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64=
_t faddr);<br>
+size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint32_t icnt, uint64_t uaddr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint32_t hist);<br>
+<br>
=C2=A0#endif<br>
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c<br>
index 46501e4f03..fafafb7b9b 100644<br>
--- a/hw/riscv/trace-encoder.c<br>
+++ b/hw/riscv/trace-encoder.c<br>
@@ -31,6 +31,11 @@<br>
<br>
=C2=A0#define TRACE_MAX_BRANCHES 31<br>
<br>
+static uint64_t rv_ntrace_encode_uaddr(TraceEncoder *trencoder, uint64_t t=
arget_pc);<br>
+static uint32_t rv_ntrace_encode_and_reset_branch_map(TraceEncoder *trenco=
der);<br>
+static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint64_t pc, uint32_t inst_len);<br>
+<br>
=C2=A0static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPURISCVState *env =3D &amp;te-&gt;cpu-&gt;env;<br>
@@ -478,6 +483,28 @@ static void trencoder_send_sync_msg(Object *trencoder_=
obj, uint64_t pc)<br>
=C2=A0 =C2=A0 =C2=A0trencoder_send_message_smem(trencoder, msg, msg_size);<=
br>
=C2=A0}<br>
<br>
+void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt64_t curr_pc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt32_t curr_inst_len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt64_t target_pc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Tr=
aceBranchType btype)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree uint8_t *msg =3D g_malloc0(TRACE_MSG_MAX_SIZE);<b=
r>
+=C2=A0 =C2=A0 uint8_t msg_size;<br>
+<br>
+=C2=A0 =C2=A0 uint32_t icnt =3D rv_ntrace_get_and_reset_icnt(trencoder, cu=
rr_pc, curr_inst_len);<br>
+=C2=A0 =C2=A0 uint64_t uaddr =3D rv_ntrace_encode_uaddr(trencoder, target_=
pc);<br>
+=C2=A0 =C2=A0 uint32_t hist =3D rv_ntrace_encode_and_reset_branch_map(tren=
coder);<br>
+<br>
+=C2=A0 =C2=A0 g_assert(trencoder-&gt;ntrace);<br>
+<br>
+=C2=A0 =C2=A0 msg_size =3D rv_ntrace_gen_indirect_branch_hist_msg(msg, bty=
pe, icnt, uaddr, hist);<br>
+=C2=A0 =C2=A0 trencoder-&gt;last_addr_reported =3D target_pc;<br>
+=C2=A0 =C2=A0 trencoder-&gt;last_icnt_reset =3D target_pc;<br>
+<br>
+=C2=A0 =C2=A0 trencoder_send_message_smem(trencoder, msg, msg_size);<br>
+}<br>
+<br>
=C2=A0static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t=
 pc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_autofree uint8_t *format2_msg =3D g_malloc0(TRACE_MSG=
_MAX_SIZE);<br>
@@ -551,6 +578,66 @@ void trencoder_send_prog_trace_sync(Object *trencoder_=
obj, uint64_t pc)<br>
=C2=A0 =C2=A0 =C2=A0trencoder_send_message_smem(trencoder, msg, msg_size);<=
br>
=C2=A0}<br>
<br>
+static uint64_t rv_ntrace_encode_uaddr(TraceEncoder *trencoder, uint64_t t=
arget_pc)<br>
+{<br>
+=C2=A0 =C2=A0 return trencoder-&gt;last_addr_reported ^ target_pc;<br>
+}<br>
+<br>
+static uint32_t rv_ntrace_encode_and_reset_branch_map(TraceEncoder *trenco=
der)<br>
+{<br>
+=C2=A0 =C2=A0 const uint32_t stop_bit =3D 1;<br>
+<br>
+=C2=A0 =C2=A0 uint32_t hist =3D trencoder-&gt;branch_map;<br>
+<br>
+=C2=A0 =C2=A0 if (trencoder-&gt;branches =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if branches =3D=3D 0, we will overflow=
 on bit shift, so just return<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* empty history value here (i.e. - only =
stop bit)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return stop_bit;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* trencoder-&gt;branch_map stores bit 1 for NOT taken =
branches,<br>
+=C2=A0 =C2=A0 =C2=A0* but N-Trace expects to stored bit 1 for TAKEN branch=
es,<br>
+=C2=A0 =C2=A0 =C2=A0* so, we should invert bits<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 hist =3D ~hist;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Also, trencoder-&gt;branch_map is implemented in suc=
h way,<br>
+=C2=A0 =C2=A0 =C2=A0* that oldest branch is LSB bit, but N-Trace format re=
quire<br>
+=C2=A0 =C2=A0 =C2=A0* to HIST values be in shift-left format: the most rec=
ent branch<br>
+=C2=A0 =C2=A0 =C2=A0* should be in LSB bit. So we should reverse order<br>
+=C2=A0 =C2=A0 =C2=A0* of valid history bits<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 hist =3D revbit32(hist) &gt;&gt; (32 - trencoder-&gt;branche=
s);<br>
+<br>
+=C2=A0 =C2=A0 /* And finally N-Trace expects bit 1 as stop bit at the MSB =
position */<br>
+=C2=A0 =C2=A0 hist =3D deposit32(hist, trencoder-&gt;branches, 1, stop_bit=
);<br>
+<br>
+=C2=A0 =C2=A0 trencoder-&gt;branch_map =3D 0;<br>
+=C2=A0 =C2=A0 trencoder-&gt;branches =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 return hist;<br>
+}<br>
+<br>
+static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint64_t pc, uint32_t inst_len)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t icnt =3D (pc + inst_len - trencoder-&gt;last_icnt_r=
eset) / 2 +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tren=
coder-&gt;icnt_accumulated;<br>
+<br>
+=C2=A0 =C2=A0 trencoder-&gt;last_icnt_reset =3D pc;<br>
+=C2=A0 =C2=A0 trencoder-&gt;icnt_accumulated =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (icnt &gt; MAKE_64BIT_MASK(0, 22)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* I-CNT overflow reporting is not supported f=
or now */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;error_fatal, &quot;N-Trace icn=
t overflowed&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return icnt;<br>
+}<br>
<br>
=C2=A0void trencoder_trace_trap_insn(Object *trencoder_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t pc, uint32_t ecause,<br>
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h<br>
index 6551ac77f9..f8a6a254dc 100644<br>
--- a/hw/riscv/trace-encoder.h<br>
+++ b/hw/riscv/trace-encoder.h<br>
@@ -57,6 +57,11 @@ typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0BRANCH_TAKEN_UNCONDITIONAL =3D 2,<br>
=C2=A0} TraceBranchRes;<br>
<br>
+typedef enum {<br>
+=C2=A0 =C2=A0 BTYPE_CONTROL_FLOW =3D 0,<br>
+=C2=A0 =C2=A0 BTYPE_EXCEPTION=C2=A0 =C2=A0 =3D 2,<br>
+=C2=A0 =C2=A0 BTYPE_INTERRUPT=C2=A0 =C2=A0 =3D 3,<br>
+} TraceBranchType;<br>
<br>
=C2=A0#define TYPE_TRACE_ENCODER &quot;trace-encoder&quot;<br>
<br>
@@ -64,6 +69,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)<=
br>
<br>
=C2=A0void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t p=
c);<br>
=C2=A0void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t p=
c);<br>
+void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt64_t curr_pc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt32_t curr_inst_len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt64_t target_pc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Tr=
aceBranchType btype);<br>
=C2=A0void trencoder_trace_trap_insn(Object *trencoder_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t pc, uint32_t ecause,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_interrupt,<br>
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c<br>
index f6201e2fb9..d7763a998f 100644<br>
--- a/target/riscv/trace_helper.c<br>
+++ b/target/riscv/trace_helper.c<br>
@@ -36,7 +36,8 @@ void helper_trace_updiscon(CPURISCVState *env, target_ulo=
ng curr_pc,<br>
=C2=A0 =C2=A0 =C2=A0TraceEncoder *te =3D TRACE_ENCODER(cpu-&gt;trencoder);<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0if (te-&gt;ntrace) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send IndirectBranchHist message */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trencoder_send_indirect_branch_hist(te, curr_p=
c, curr_inst_len, env-&gt;pc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BTYPE_CONTROL_FLOW);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te-&gt;updiscon_pending =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te-&gt;trace_next_insn =3D true;<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--0000000000003b885a06607560ec--

