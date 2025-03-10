Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C37C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 04:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trV2D-0008UV-PX; Mon, 10 Mar 2025 00:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trV25-0008U5-HK; Mon, 10 Mar 2025 00:46:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trV23-0005br-Mh; Mon, 10 Mar 2025 00:46:29 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22409077c06so47174395ad.1; 
 Sun, 09 Mar 2025 21:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741581985; x=1742186785; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCIYMBkz+ccL9FkKPpToGpSWZo1J05UaIS83SH+turk=;
 b=Yblrue+msHc1+Vl+MCgSDyFAi8c7MmhDeBEJXfAU37Fy9ydRtaFDVmYrMDssc/VxET
 FJuVSmumxGcgfU0Jzz8qe/JVr+fQcJzdq8quZJW8+X/HnS64Gb9KX2ILLwEsI9RuZjui
 NG4Vqr/kXSvgVIoZ5/XgaXGTsqCx2GHA058DXMKI6QMuXG/qm3O2/ANjcuUyWcBLWtIN
 kcoAgPOkj4omgXm1tesgP3KPbQ8L7F0KqBJU5T7YvEb5a/RNdDlTo2SFfdNDmidqVkxr
 9YfgalLEKKzdGya3+GcVwkRfvXxqF3CLtJjvX/SvfjtjdwSUY4c/TiHypLmuItKhakp+
 23Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741581985; x=1742186785;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QCIYMBkz+ccL9FkKPpToGpSWZo1J05UaIS83SH+turk=;
 b=u2tLLr9ptJTFjxPc1BS6rybrQmpu2WD3lJkH3/lCxRTK633h4wQO96PQtt68KCPv8u
 ytwgAv6AcCMZwCluw6qUhbgqX/Shnb07nDyToPwqF1RscusXtAxJr4/rS3lj5eluNk6m
 7Pk7ZzMPnwn/TdanCyToXTeU5/QnRKruFzHIZgTylkQngBiaTeU9xLGFIHuV7074znct
 +Aa11Kdb61/Wg1Nqp3ZnIfTHW+l5frANlyLPrf/1pMfESYAIteBzW8lNCxiq9phhVakm
 /3vaWWer0fKTdXzAu0YVR32TRFZIdduketZTkF2Y+rtVbRELdaLRPL2whN1r/Z2tx1kj
 qurw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv58KNLI07AB6iFdFFbSm4+GL9bbwYKqy+kW4krhnpicaslwv8LFbOQNq6yBzmMZZV2pKw73QfndI3@nongnu.org
X-Gm-Message-State: AOJu0YzSonkMfES5V2hrEpml09Ql6Qoxxljs4cUaNwQxgbSy0CnEcf0w
 eSt55Kv0TQCNMMPSZYcqdnSyo69g1lS4RxuVQ1NmjI1/imcNCS3z
X-Gm-Gg: ASbGncu8zrvgXD5JZkHf7jWr+1uNuHJlGi1NffGmsKZR5pnV0ydb/rdk983C+aZBdzR
 +bb/rNaE4k+1ZDVGAUbZwoT/R0zFv6WrwkqUESH9c8zqDRm4Ry3CMndcpta/2SwavF0TkZXSosk
 n3uXB9OGcXfbtYcIEvOTJP5mKieQpYWXUgu3WtYk9XD9Fbyx83+IFGfK3x5jENvzr/yk2LbUIp1
 9cY4+QwGinxe39xygsWMt5g9i+ps9icErgkzvdxPDZR4XMRDlGbFLSxItpDub3PqfE1qNmVd9ce
 8Ss+ntmhuF08UstOAU1YiewHcCQgKshY5/xgHlcq
X-Google-Smtp-Source: AGHT+IGy/6KciON10RiqpDiyzjS0ydpDWIrCmnOdFFA11KTEg1v1fyG0ajfwNdb3sLx+2/lTSqzfEw==
X-Received: by 2002:a05:6a00:2d90:b0:736:4b85:ee05 with SMTP id
 d2e1a72fcca58-736aaa56dc6mr16710548b3a.11.1741581985061; 
 Sun, 09 Mar 2025 21:46:25 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b6305227sm4837194b3a.16.2025.03.09.21.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 21:46:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 14:46:18 +1000
Message-Id: <D8CBABU0FRD1.1X7KHNS0GJUAK@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 08/14] qtest/xive: Add group-interrupt test
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-16-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-16-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> Add XIVE2 tests for group interrupts and group interrupts that have
> been backlogged.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  tests/qtest/pnv-xive2-test.c | 160 +++++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
>
> diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
> index dd19e88861..a4d06550ee 100644
> --- a/tests/qtest/pnv-xive2-test.c
> +++ b/tests/qtest/pnv-xive2-test.c
> @@ -2,6 +2,8 @@
>   * QTest testcase for PowerNV 10 interrupt controller (xive2)
>   *  - Test irq to hardware thread
>   *  - Test 'Pull Thread Context to Odd Thread Reporting Line'
> + *  - Test irq to hardware group
> + *  - Test irq to hardware group going through backlog
>   *
>   * Copyright (c) 2024, IBM Corporation.
>   *
> @@ -315,6 +317,158 @@ static void test_pull_thread_ctx_to_odd_thread_cl(Q=
TestState *qts)
>      word2 =3D get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD2);
>      g_assert_cmphex(xive_get_field32(TM_QW3W2_VT, word2), =3D=3D, 0);
>  }
> +
> +static void test_hw_group_irq(QTestState *qts)
> +{
> +    uint32_t irq =3D 100;
> +    uint32_t irq_data =3D 0xdeadbeef;
> +    uint32_t end_index =3D 23;
> +    uint32_t chosen_one;
> +    uint32_t target_nvp =3D 0x81; /* group size =3D 4 */
> +    uint8_t priority =3D 6;
> +    uint32_t reg32;
> +    uint16_t reg16;
> +    uint8_t pq, nsr, cppr;
> +
> +    printf("# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +    printf("# Testing irq %d to hardware group of size 4\n", irq);
> +
> +    /* irq config */
> +    set_eas(qts, irq, end_index, irq_data);
> +    set_end(qts, end_index, target_nvp, priority, true /* group */);
> +
> +    /* enable and trigger irq */
> +    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
> +    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
> +
> +    /* check irq is raised on cpu */
> +    pq =3D get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
> +    g_assert_cmpuint(pq, =3D=3D, XIVE_ESB_PENDING);
> +
> +    /* find the targeted vCPU */
> +    for (chosen_one =3D 0; chosen_one < SMT; chosen_one++) {
> +        reg32 =3D get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0)=
;
> +        nsr =3D reg32 >> 24;
> +        if (nsr =3D=3D 0x82) {
> +            break;
> +        }
> +    }
> +    g_assert_cmphex(chosen_one, <, SMT);
> +    cppr =3D (reg32 >> 16) & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0x82);
> +    g_assert_cmphex(cppr, =3D=3D, 0xFF);
> +
> +    /* ack the irq */
> +    reg16 =3D get_tima16(qts, chosen_one, TM_SPC_ACK_HV_REG);
> +    nsr =3D reg16 >> 8;
> +    cppr =3D reg16 & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0x82);
> +    g_assert_cmphex(cppr, =3D=3D, priority);
> +
> +    /* check irq data is what was configured */
> +    reg32 =3D qtest_readl(qts, xive_get_queue_addr(end_index));
> +    g_assert_cmphex((reg32 & 0x7fffffff), =3D=3D, (irq_data & 0x7fffffff=
));
> +
> +    /* End Of Interrupt */
> +    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
> +    pq =3D get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
> +    g_assert_cmpuint(pq, =3D=3D, XIVE_ESB_RESET);
> +
> +    /* reset CPPR */
> +    set_tima8(qts, chosen_one, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
> +    reg32 =3D get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
> +    nsr =3D reg32 >> 24;
> +    cppr =3D (reg32 >> 16) & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0x00);
> +    g_assert_cmphex(cppr, =3D=3D, 0xFF);
> +}
> +
> +static void test_hw_group_irq_backlog(QTestState *qts)
> +{
> +    uint32_t irq =3D 31;
> +    uint32_t irq_data =3D 0x01234567;
> +    uint32_t end_index =3D 129;
> +    uint32_t target_nvp =3D 0x81; /* group size =3D 4 */
> +    uint32_t chosen_one =3D 3;
> +    uint8_t blocking_priority, priority =3D 3;
> +    uint32_t reg32;
> +    uint16_t reg16;
> +    uint8_t pq, nsr, cppr, lsmfb, i;
> +
> +    printf("# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +    printf("# Testing irq %d to hardware group of size 4 going through "=
 \
> +           "backlog\n",
> +           irq);
> +
> +    /*
> +     * set current priority of all threads in the group to something
> +     * higher than what we're about to trigger
> +     */
> +    blocking_priority =3D priority - 1;
> +    for (i =3D 0; i < SMT; i++) {
> +        set_tima8(qts, i, TM_QW3_HV_PHYS + TM_CPPR, blocking_priority);
> +    }
> +
> +    /* irq config */
> +    set_eas(qts, irq, end_index, irq_data);
> +    set_end(qts, end_index, target_nvp, priority, true /* group */);
> +
> +    /* enable and trigger irq */
> +    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
> +    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
> +
> +    /* check irq is raised on cpu */
> +    pq =3D get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
> +    g_assert_cmpuint(pq, =3D=3D, XIVE_ESB_PENDING);
> +
> +    /* check no interrupt is pending on the 2 possible targets */
> +    for (i =3D 0; i < SMT; i++) {
> +        reg32 =3D get_tima32(qts, i, TM_QW3_HV_PHYS + TM_WORD0);
> +        nsr =3D reg32 >> 24;
> +        cppr =3D (reg32 >> 16) & 0xFF;
> +        lsmfb =3D reg32 & 0xFF;
> +        g_assert_cmphex(nsr, =3D=3D, 0x0);
> +        g_assert_cmphex(cppr, =3D=3D, blocking_priority);
> +        g_assert_cmphex(lsmfb, =3D=3D, priority);
> +    }
> +
> +    /* lower priority of one thread */
> +    set_tima8(qts, chosen_one, TM_QW3_HV_PHYS + TM_CPPR, priority + 1);
> +
> +    /* check backlogged interrupt is presented */
> +    reg32 =3D get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
> +    nsr =3D reg32 >> 24;
> +    cppr =3D (reg32 >> 16) & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0x82);
> +    g_assert_cmphex(cppr, =3D=3D, priority + 1);
> +
> +    /* ack the irq */
> +    reg16 =3D get_tima16(qts, chosen_one, TM_SPC_ACK_HV_REG);
> +    nsr =3D reg16 >> 8;
> +    cppr =3D reg16 & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0x82);
> +    g_assert_cmphex(cppr, =3D=3D, priority);
> +
> +    /* check irq data is what was configured */
> +    reg32 =3D qtest_readl(qts, xive_get_queue_addr(end_index));
> +    g_assert_cmphex((reg32 & 0x7fffffff), =3D=3D, (irq_data & 0x7fffffff=
));
> +
> +    /* End Of Interrupt */
> +    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
> +    pq =3D get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
> +    g_assert_cmpuint(pq, =3D=3D, XIVE_ESB_RESET);
> +
> +    /* reset CPPR */
> +    set_tima8(qts, chosen_one, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
> +    reg32 =3D get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
> +    nsr =3D reg32 >> 24;
> +    cppr =3D (reg32 >> 16) & 0xFF;
> +    lsmfb =3D reg32 & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0x00);
> +    g_assert_cmphex(cppr, =3D=3D, 0xFF);
> +    g_assert_cmphex(lsmfb, =3D=3D, 0xFF);
> +}
> +
>  static void test_xive(void)
>  {
>      QTestState *qts;
> @@ -330,6 +484,12 @@ static void test_xive(void)
>      /* omit reset_state here and use settings from test_hw_irq */
>      test_pull_thread_ctx_to_odd_thread_cl(qts);
> =20
> +    reset_state(qts);
> +    test_hw_group_irq(qts);
> +
> +    reset_state(qts);
> +    test_hw_group_irq_backlog(qts);
> +
>      reset_state(qts);
>      test_flush_sync_inject(qts);
> =20


