Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7D606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lowdX672;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gs1THX+g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKeW9-0007qN-9U; Sat, 24 Oct 2026 12:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKeW8-0007q0-2U
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:22:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKeW4-0001Ik-R9
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:22:47 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF04pA1863262
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 doxKvGBD2us1pi786FVguuAJBPpjEgJ2HHh41Q8n4vQ=; b=lowdX672Ju2flpEp
 Me8JKMUuZW7uJ3xoNjgazovk9etIbYRKTYk7DFohrOfjjPz03IXWdOZMJX1tII0n
 kP0LKz7pLhpZyIqAFHB5zpz0j5QiJnfPXFugVLFJdcmkPpSeaPzhnA2Lr816UVSr
 d2Dh74oinRYe5aRMcAr+K0+OlOdWLm208ZMTta4Wr4n0X9lkbp8KaGvuQjkNKKZm
 FTTJ8PCttNoQbCWyW4iTxuggk9wcooqjsY/SLQdiYbhv9z0Jku5WlWdCohOE/2n3
 OooE5+mUR6uFJeMqngJzeWdHKm9TWcqPu+4sv+2MsCfBRi3bgWmahz0lpoB1wfUi
 xW0wpA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmruhahd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:22:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so405767885a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792858963; x=1793463763; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=doxKvGBD2us1pi786FVguuAJBPpjEgJ2HHh41Q8n4vQ=;
 b=gs1THX+gFaiejUTU8qiLHjFiesheUN8SqFjt0wUFIFt4dwgKT96DYBQLFf3dwgjJcr
 Vc4PchOxKu4c6VaKSAQtr6JsqW/ouInXmVGKLonuB0T2jyMoMn2OgV46yKMJ02YwVneM
 bONA7vDxhxFZ1ZW0E7jA/erbsusFMTijr+L8FCGTW77C2qmbxA9s8ZwrlqH4HlCLjg9Q
 VJDx+GlsLmVCA0P/BpxCGn22z2eb/aLee8YSTHJHsuEJJeBjm7TJeEbpANY+Ymz2MRG6
 J6mJUhqqhTZG8P2qhzb7ZciuEJEPsTRzcGJOoAr6OeJ6+kDUhjAFYesD5i+4YyEh3L7h
 1+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792858963; x=1793463763;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=doxKvGBD2us1pi786FVguuAJBPpjEgJ2HHh41Q8n4vQ=;
 b=m0URFPEFuLSUDJ9vOv4p8ZKdkq+j3DebcDQ9SUMSKUBcu43RUbwtDkKNa1uGySVTGG
 qT/XnzyqHXcnY4T4dsBhgd1FAHcuaBqJL5c/1hLEaJRo+MkJeu/RdkSssnkzSAzgiA5k
 qXE6Jes11VkfUl6/MhQb3S1sXdJ2kL5jlQ1fIWaPzy58rGKut16BWSuYZbGbTrjikazd
 V9vbNrsMFucZQWQ14NPI5JfmIzP0c+esqToDUDQR7emey8yRziuOvqihX3JA1EggPw/7
 ytmYDlrIpEtnS+HuUFYSNQN9bUK2s9iYLR03TALPyc2VWPQc/+4x52JRZerbN1wpbzKs
 OOPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEeI/gEid/dR12qVthjm1bZHD9VtvDF1eKvVPuOKtMhzu2bQXsvRv2RVKcjQjZBQpT4AZHfHIQaUBb@nongnu.org
X-Gm-Message-State: AFq9FYL2oZhf29eaq2meUv/m31gJJpxIG+/ryzT/c9x887dDPw/QHh42
 EAgWYeM8ZjGtbQ2bhVjcQXgZrDeuWzkhGDrjiGPr2fUCwBRbYT7UEuIr8/fqUW4scabBkyKkAhO
 QLp7xXTGviXvYIpWltm9Xop7Y86QRWz708YCy9LYJugjjDo+Ue46OGkcEqg==
X-Gm-Gg: AYBFou1vD1C0hRWzYUCyfz4tlDrMr0RyEmvXFb3YBWhld59HMhC8UeTNKpV723nBNa5
 UUiaBqexC4vRPOncN2shgmI6gtOcGane9VEjcj7IJ21aNgvNXVFVwY2KStBeAF0gQDnXJEnmMlQ
 wqkGiKtf6/0ZFiHh/MU9PW9vZcchKSj2GVscsOxexQNJjw0kZyLgknY8F1jxqKKlnqAKa9osY6r
 vn/FSdz/WubGKVFSFgZ2fcFPJ79oQ4xS/RI3z/MrGQILmhObqVrwyAU7pFLIfY5b+Uh+4xWmjBe
 w7p1h2+vGhs10cngoPAqSEMFvi4oPujGNCod7u/KuM2A17ScafVYsLwmVtro7wUTtfFxMrXwykz
 THK6qiAeagxHkQiTR7bhzLeA/arpLT87DyQ==
X-Received: by 2002:a05:620a:3945:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-940ef6874aamr323749585a.0.1792858962817; 
 Sat, 24 Oct 2026 09:22:42 -0700 (PDT)
X-Received: by 2002:a05:620a:3945:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-940ef6874aamr323744785a.0.1792858962143; 
 Sat, 24 Oct 2026 09:22:42 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd35c2sm5057746f8f.39.2026.10.24.09.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 09:22:41 -0700 (PDT)
Message-ID: <8c6a4a6a-8057-4823-b050-eeda79286d9c@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 18:22:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] hw/char: add TriCore ASCLIN UART controller
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Saravanan Sekar <saravanan@linumiz.com>,
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>,
 Christoph Seitz <christoph.seitz@infineon.com>,
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>,
 David Brenken <david.brenken@efs-auto.de>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
 <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-4-c722e4ca5661@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-4-c722e4ca5661@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX7kMgWGfn8alO
 zSdMwpoEQuY7Qfcf8/Lb1t8kQQVB+yuQ6hDj8RvaQXrIqo7mdD92QWV+k5IANxYw8irw2FSqElQ
 ++5WRSjCUGDd401lodElaTIHgALhVYmyg+FB2IleikFuH6C5WmKV4/c0MIbyo1Qnfctn9QNYhoo
 gBN5fr/cFiWIxkwrkdc1acHEhcJyql4R5vEYbyR2BYdKape2tXf7550mSOtyMDv9Fxd/huRWTMl
 bl7vdZ9uj3dZROUC1G9Zjt7AN6gelz+BcQOc27L+qKMBkFQHEKuyjHbpErfJYLWqk//fffIphic
 V+Jzm+zdwou2Bih+HLQNcNJl5PvuAQkTUUfhgU68oBRHe07BWu47QrRj15m/5rVzPtoYyzTEvBY
 nAmNl7OKdhcbqRKRDc2WWuXz9LXcWaHaVc+hMdnI+JJ9t3WcUIGbaAckbYCqd+cwYEIdxrIZ1SK
 ovPTso4ptxp011H42lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXzNYh8AJJRlIs
 Xa9AOPVuI+r7m73Fn5noFTFFQKizPcwVZe5ze9Fsz37CVlRxQQB5ZKMZ2NbILT8y5XmY0cWxAbD
 6YNEFTAacav8FaWAElDfHn95zzsrYbI=
X-Proofpoint-ORIG-GUID: bSotgtGxMPuUpeyeseiWZ1cheD8Ge3_Y
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adcdb53 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=vU9dKmh3AAAA:8 a=zzQyCZ59JRaAf8DvRRYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-GUID: bSotgtGxMPuUpeyeseiWZ1cheD8Ge3_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 22:11, Parthiban Nallathambi wrote:
> Model the ASCLIN in UART mode.  TX writes go to the chardev
> backend, RX fills a ring buffer.  FLAGS tracks FIFO status and
> three sysbus IRQ lines (TX, RX, ERR) are pulsed on flag edges.
> 
> Originally-by: David Brenken <david.brenken@efs-auto.de>
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   MAINTAINERS                      |   2 +
>   hw/char/Kconfig                  |   3 +
>   hw/char/meson.build              |   1 +
>   hw/char/tricore_asclin.c         | 537 +++++++++++++++++++++++++++++++++++++++
>   include/hw/char/tricore_asclin.h |  41 +++
>   5 files changed, 584 insertions(+)

(please enable scripts/git.orderfile)

> +/*
> + * Watch callback: retries TX when the chardev was previously busy.
> + */
> +static gboolean asclin_tx_watch(void *do_not_use, GIOCondition cond,
> +                                void *opaque)
> +{
> +    TriCoreASCLINState *s = TRICORE_ASCLIN(opaque);
> +    int ret;
> +
> +    s->watch_tag = 0;
> +
> +    ret = qemu_chr_fe_write_all(&s->chr, (uint8_t *)&s->txbuf,
> +                                asclin_tx_inlet_bytes(s));
> +    if (ret <= 0) {
> +        s->watch_tag = qemu_chr_fe_add_watch(&s->chr,
> +                                             G_IO_OUT | G_IO_HUP,
> +                                             asclin_tx_watch, s);
> +        if (!s->watch_tag) {
> +            goto drained;
> +        }
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +drained:
> +    qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);

MMIO read/write handlers run under the BQL (see prepare_mmio_access),
chardev callbacks run in the main loop with the BQL held, so no need
to use qatomics (multiple uses in this patch).

> +    asclin_pulse_irq(s, ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
> +    return G_SOURCE_REMOVE;
> +}
> +
> +/*
> + * Transmit TXFIFOCON.INW bytes immediately.  Re-asserts TFL and TC flags
> + * so that interrupt-driven drivers can continue filling the FIFO.
> + */
> +static void asclin_txdata_write(TriCoreASCLINState *s, uint32_t value)
> +{
> +    unsigned len = asclin_tx_inlet_bytes(s);
> +    int ret;
> +
> +    if (!len) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: TXFIFOCON.INW is 0, data dropped\n", __func__);
> +        return;
> +    }
> +
> +    s->txbuf = cpu_to_le32(value);
> +    ret = qemu_chr_fe_write_all(&s->chr, (uint8_t *)&s->txbuf, len);
> +    if (ret <= 0) {
> +        s->watch_tag = qemu_chr_fe_add_watch(&s->chr,
> +                                             G_IO_OUT | G_IO_HUP,
> +                                             asclin_tx_watch, s);
> +        if (!s->watch_tag) {
> +            goto drained;
> +        }
> +        return;
> +    }
> +
> +drained:
> +    qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
> +    asclin_pulse_irq(s, ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
> +}
> +
> +static void asclin_txfifocon_write(TriCoreASCLINState *s, uint32_t value)
> +{
> +    /* FILL field is read-only hardware status */
> +    s->regs[R_TXFIFOCON] = value & ~(ASCLIN_FILL_MASK | ASCLIN_RXFIFOCON_FLUSH);

RXFIFOCON isn't correct, we want TXFIFOCON.

> +}
> +
> +static uint32_t asclin_txfifocon_read(TriCoreASCLINState *s)
> +{
> +    /* Instant-TX model: FILL always reads as 0 */
> +    return s->regs[R_TXFIFOCON] & ~ASCLIN_FILL_MASK;
> +}
> +
> +static void asclin_rxfifocon_write(TriCoreASCLINState *s, uint32_t value)
> +{
> +    s->regs[R_RXFIFOCON] = value & ~(ASCLIN_FILL_MASK | ASCLIN_RXFIFOCON_FLUSH);
> +
> +    if (value & ASCLIN_RXFIFOCON_FLUSH) {
> +        asclin_rx_buf_reset(s);
> +    }
> +    if (value & ASCLIN_RXFIFOCON_ENI) {
> +        qemu_chr_fe_accept_input(&s->chr);
> +    }
> +}
> +
> +static uint32_t asclin_rxfifocon_read(TriCoreASCLINState *s)
> +{
> +    uint32_t used = asclin_rx_buf_used(s);
> +    uint32_t fill = MIN(used, ASCLIN_HW_FIFO_DEPTH);
> +
> +    return (s->regs[R_RXFIFOCON] & ~ASCLIN_FILL_MASK) |
> +           (fill << ASCLIN_FILL_SHIFT);
> +}
> +
> +static uint32_t asclin_rxdata_read(TriCoreASCLINState *s, bool peek)
> +{
> +    uint32_t r;
> +
> +    if (s->rx_rdidx == s->rx_wridx) {
> +        return 0;
> +    }
> +
> +    r = s->rxbuf[s->rx_rdidx];
> +    if (!peek) {
> +        s->rx_rdidx = (s->rx_rdidx + 1) % ASCLIN_RX_BUF_SIZE;
> +    }
> +    return r;
> +}
> +
> +static uint32_t asclin_csr_read(TriCoreASCLINState *s)
> +{
> +    uint32_t csr = s->regs[R_CSR];
> +
> +    /* CLKSEL valid: set CON bit (bit 31) when a clock is selected */
> +    if (csr & 0x1f) {
> +        csr |= (1u << 31);
> +    }
> +    return csr;
> +}
> +
> +static void asclin_flagsset_write(TriCoreASCLINState *s, uint32_t value)
> +{
> +    qatomic_or(&s->regs[R_FLAGS], value);
> +    asclin_pulse_irq(s, value);
> +}
> +
> +static void asclin_flagsclear_write(TriCoreASCLINState *s, uint32_t value)
> +{
> +    qatomic_and(&s->regs[R_FLAGS], ~value);
> +}
> +
> +/*
> + * FLAGSENABLE write: newly-enabled bits whose FLAGS is already set
> + * must produce a rising edge on the corresponding interrupt line.
> + */
> +static void asclin_flagsenable_write(TriCoreASCLINState *s, uint32_t value)
> +{
> +    uint32_t old_en = s->regs[R_FLAGSENABLE];
> +    uint32_t newly_enabled = value & ~old_en;
> +
> +    s->regs[R_FLAGSENABLE] = value;
> +    asclin_pulse_irq(s, newly_enabled & s->regs[R_FLAGS]);
> +}
> +
> +static uint32_t asclin_reg_read(TriCoreASCLINState *s, hwaddr offset)
> +{
> +    hwaddr reg = offset >> 2;
> +
> +    switch (reg) {
> +    case R_CLC:
> +    case R_IOCR:
> +    case R_ID:
> +    case R_BITCON:
> +    case R_FRAMECON:
> +    case R_DATCON:
> +    case R_BRG:
> +    case R_BRD:
> +    case R_LINCON:
> +    case R_LINBTIMER:
> +    case R_LINHTIMER:
> +    case R_FLAGS:
> +    case R_FLAGSENABLE:
> +        return s->regs[reg];
> +    case R_TXFIFOCON:
> +        return asclin_txfifocon_read(s);
> +    case R_RXFIFOCON:
> +        return asclin_rxfifocon_read(s);
> +    case R_FLAGSSET:
> +    case R_FLAGSCLEAR:
> +        return 0;
> +    case R_TXDATA:
> +        return 0;
> +    case R_RXDATA:
> +        return asclin_rxdata_read(s, false);
> +    case R_CSR:
> +        return asclin_csr_read(s);
> +    case R_RXDATAD:
> +        return asclin_rxdata_read(s, true);
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: read from unknown offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        return 0;
> +    }
> +}
> +
> +static uint64_t asclin_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    TriCoreASCLINState *s = opaque;
> +
> +    return extract32(asclin_reg_read(s, offset), (offset & 3) * 8, size * 8);
> +}
> +
> +static void asclin_write(void *opaque, hwaddr offset, uint64_t value,
> +                         unsigned size)
> +{
> +    TriCoreASCLINState *s = opaque;
> +    hwaddr reg = offset >> 2;
> +    unsigned shift = (offset & 3) * 8;
> +    uint32_t val;
> +
> +    /*
> +     * 8/16-bit writes: merge into the stored register, except for the
> +     * write-only action registers where unwritten bytes must stay 0.
> +     */
> +    if (reg >= ASCLIN_R_MAX || reg == R_FLAGSSET || reg == R_FLAGSCLEAR ||
> +        reg == R_TXDATA) {
> +        val = value << shift;
> +    } else {
> +        val = deposit32(s->regs[reg], shift, size * 8, value);
> +    }
> +
> +    switch (reg) {
> +    case R_CLC:
> +    case R_IOCR:
> +    case R_ID:

Isn't ID read-only?

> +    case R_BITCON:
> +    case R_FRAMECON:
> +    case R_DATCON:
> +    case R_BRG:
> +    case R_BRD:
> +    case R_LINCON:
> +    case R_LINBTIMER:
> +    case R_LINHTIMER:
> +        s->regs[reg] = val;
> +        break;
> +    case R_TXFIFOCON:
> +        asclin_txfifocon_write(s, val);
> +        break;
> +    case R_RXFIFOCON:
> +        asclin_rxfifocon_write(s, val);
> +        break;
> +    case R_FLAGS:
> +        /* read-only hardware status */
> +        break;
> +    case R_FLAGSSET:
> +        asclin_flagsset_write(s, val);
> +        break;
> +    case R_FLAGSCLEAR:
> +        asclin_flagsclear_write(s, val);
> +        break;
> +    case R_FLAGSENABLE:
> +        asclin_flagsenable_write(s, val);
> +        break;
> +    case R_TXDATA:
> +        asclin_txdata_write(s, val);
> +        break;
> +    case R_RXDATA:
> +    case R_RXDATAD:
> +        /* read-only */
> +        break;
> +    case R_CSR:
> +        s->regs[R_CSR] = val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: write to unknown offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps asclin_ops = {
> +    .read = asclin_read,
> +    .write = asclin_write,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void asclin_uart_rx(void *opaque, const uint8_t *buf, int size)
> +{
> +    TriCoreASCLINState *s = opaque;
> +
> +    while (size > 0) {
> +        if (asclin_rx_buf_free(s) == 0) {
> +            qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_RFO);
> +            asclin_pulse_irq(s, ASCLIN_FLAGS_RFO);
> +            break;
> +        }
> +        s->rxbuf[s->rx_wridx] = *buf++;
> +        s->rx_wridx = (s->rx_wridx + 1) % ASCLIN_RX_BUF_SIZE;
> +        size--;
> +    }
> +
> +    if (s->rx_rdidx != s->rx_wridx) {
> +        qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_RFL);
> +        asclin_pulse_irq(s, ASCLIN_FLAGS_RFL);
> +    }
> +}
> +
> +static int asclin_uart_can_rx(void *opaque)
> +{
> +    TriCoreASCLINState *s = TRICORE_ASCLIN(opaque);
> +
> +    if ((s->regs[R_RXFIFOCON] & ASCLIN_RXFIFOCON_ENI) &&
> +        asclin_rx_buf_free(s) > 0) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +static void asclin_uart_reset_hold(Object *obj, ResetType type)
> +{
> +    TriCoreASCLINState *s = TRICORE_ASCLIN(obj);
> +    int i;
> +
> +    for (i = 0; i < ASCLIN_R_MAX; i++) {
> +        s->regs[i] = 0;
> +    }
> +    asclin_rx_buf_reset(s);

We need to clear watch_tag with g_source_remove().

> +}
> +
> +static void asclin_uart_realize(DeviceState *dev, Error **errp)
> +{
> +    TriCoreASCLINState *s = TRICORE_ASCLIN(dev);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, asclin_uart_can_rx,
> +                             asclin_uart_rx, NULL,
> +                             NULL, s, NULL, true);
> +}
> +
> +static void asclin_uart_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    TriCoreASCLINState *s = TRICORE_ASCLIN(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &asclin_ops, s,
> +                          TYPE_TRICORE_ASCLIN, 0x100);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq_rx);
> +    sysbus_init_irq(sbd, &s->irq_tx);
> +    sysbus_init_irq(sbd, &s->irq_err);
> +}
> +
> +static int asclin_uart_post_load(void *opaque, int version_id)
> +{
> +    TriCoreASCLINState *s = TRICORE_ASCLIN(opaque);
> +
> +    if (s->regs[R_FLAGS] & ASCLIN_FLAGS_TFL) {

This rearms when transfer is finished, don't we want the opposite check?

> +        s->watch_tag = qemu_chr_fe_add_watch(&s->chr,
> +                                             G_IO_OUT | G_IO_HUP,
> +                                             asclin_tx_watch, s);
> +    }
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_asclin_uart = {
> +    .name = TYPE_TRICORE_ASCLIN,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = asclin_uart_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, TriCoreASCLINState, ASCLIN_R_MAX),

Missing rxbuf, rx_rdidx, rx_wridx and txbuf.

> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const Property asclin_uart_properties[] = {
> +    DEFINE_PROP_CHR("chardev", TriCoreASCLINState, chr),
> +};
> +
> +static void asclin_uart_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = asclin_uart_realize;
> +    rc->phases.hold = asclin_uart_reset_hold;
> +    dc->vmsd = &vmstate_asclin_uart;
> +    device_class_set_props(dc, asclin_uart_properties);
> +}
> +
> +static const TypeInfo asclin_uart_info = {
> +    .name = TYPE_TRICORE_ASCLIN,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(TriCoreASCLINState),
> +    .instance_init = asclin_uart_init,
> +    .class_init = asclin_uart_class_init,
> +};
> +
> +static void asclin_uart_register_types(void)
> +{
> +    type_register_static(&asclin_uart_info);
> +}
> +
> +type_init(asclin_uart_register_types)
> diff --git a/include/hw/char/tricore_asclin.h b/include/hw/char/tricore_asclin.h
> new file mode 100644
> index 0000000000..50642fd0f8
> --- /dev/null
> +++ b/include/hw/char/tricore_asclin.h
> @@ -0,0 +1,41 @@
> +/*
> + * TriCore ASCLIN (Asynchronous/Synchronous Interface) UART controller
> + *
> + * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
> + * Copyright (c) 2024 Siemens AG
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_TRICORE_ASCLIN_H
> +#define HW_TRICORE_ASCLIN_H
> +
> +#include "chardev/char-fe.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define ASCLIN_R_MAX        21
> +#define ASCLIN_RX_BUF_SIZE  8192

Can we use a Fifo8 of the hardware depth and rely on chardev
back-pressure instead of an 8 KiB ring buffer?

> +
> +#define TYPE_TRICORE_ASCLIN "tricore_asclin"

Usual QOM names are more like "tricore-asclin", but I don't mind.

> +OBJECT_DECLARE_SIMPLE_TYPE(TriCoreASCLINState, TRICORE_ASCLIN)
> +
> +struct TriCoreASCLINState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    CharFrontend chr;
> +    qemu_irq irq_rx;
> +    qemu_irq irq_tx;
> +    qemu_irq irq_err;
> +
> +    guint watch_tag;
> +    uint32_t regs[ASCLIN_R_MAX];
> +    uint32_t txbuf;
> +
> +    uint8_t rxbuf[ASCLIN_RX_BUF_SIZE];
> +    uint32_t rx_wridx;
> +    uint32_t rx_rdidx;
> +};
> +
> +#endif
> 


