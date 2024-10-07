Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042BACFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpt5-0003k3-N0; Mon, 07 Oct 2024 11:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxpt3-0003jr-MD
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:43:05 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxpt1-000296-N8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:43:05 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fabfc06de3so49658811fa.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728315781; x=1728920581; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cpMX1eumT+9vHxAImP8gJlIeH1i2TPrcR6wzeFPuFJM=;
 b=pbPIft4COtBWwxkYyId5hNrp5dVD01/ol6i64PMNR1Eaytav8KGBqUUuxNyC4EPHay
 VPa8oLqeIpfV3hmtRdya32OzGWlRp03hn+xsWm+/fHLusvTG8unWVjZVtAgZ+RndVwTY
 yRJu2tB/KjHn/iDxrsZYf12CiTvCSK1K123KtIHxX8edd3P17UQVisPMeClrBHHagLzr
 9AQUpYzhwrFD+ZAcf2frPDTBeSQjm8CwpHJRW074iHA4KnfSpnr1TDJ40kUjY8SYL2vq
 QTE0eNvxlo3vNvYjYPQgcU3nyBuwLhh9TsZrbAausFEW5av0I10Qt8nU/hwDMmzng46b
 W8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728315781; x=1728920581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cpMX1eumT+9vHxAImP8gJlIeH1i2TPrcR6wzeFPuFJM=;
 b=hTGtloeUVZRdvegCc0bA1p5fVFwGa45UamBkjNHTi+CQ7N1YLFcYG1ZKzkZ24yu3Zy
 HlZvC1Qnpuqns2RSaL4IEJj7CSQvubK4SEav5reMbPWeHn3iyG29rvqmT1cvBKnkj6Ev
 vvN6nyMd95noiecJBCKuaigX3hpqKGNX7LbemqoyGRIpc/LTiizpPwDuaL1kDnxeMMfr
 N/CD5EYV85mnBvlPLVL/KBf8e4kVq/3DIQ67n9TpvSSFshW/OdbWpewbvWoKTH3PzbrM
 24QynSysenaMkZw9twURYQDX61QMlITd5ZK1H4O0DqpXd8ePoxgnpOXkeeqxSOeaOHE1
 1LzQ==
X-Gm-Message-State: AOJu0YwcPo7F93FuCfa2lLKDxleYXD1DF97NpQssFhyUoGWw3t1y5HON
 ZAXX2H3r6CUsZAl9ZLngwh4CBhJTeHwnr6OVGe/UKX6ic54Lk9PZxd2nzVwOFiS5T0YD/sG9RS3
 /8Lt8enRosFIfZs9mq5AYVtvhPUGZ8C75BwcIzA==
X-Google-Smtp-Source: AGHT+IETk110tVG61E3F4FABrVSMPupalOBdEBJHK8o1Bqxb8M7h2LJ4plW2qf4888jIdIKNQ+CkKsjEM2CDkn/sJBA=
X-Received: by 2002:a2e:4e02:0:b0:2f5:2e2:eadf with SMTP id
 38308e7fff4ca-2faf3c1c87fmr45497171fa.10.1728315780966; Mon, 07 Oct 2024
 08:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
 <20241003185655.1480819-3-edgar.iglesias@gmail.com>
In-Reply-To: <20241003185655.1480819-3-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2024 16:42:49 +0100
Message-ID: <CAFEAcA9SgThjVW=VY_ZeKZh0bAe+rbTReK00DAQEXgMwD8cNqQ@mail.gmail.com>
Subject: Re: [PULL v2 2/5] hw/xen: Expose handle_bufioreq in xen_register_ioreq
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Thu, 3 Oct 2024 at 19:57, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> Expose handle_bufioreq in xen_register_ioreq().
> This is to allow machines to enable or disable buffered ioreqs.
>
> No functional change since all callers still set it to
> HVM_IOREQSRV_BUFIOREQ_ATOMIC.
>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Hi; Coverity has noticed a problem (CID 1563383) with this change:

> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index 3a9d6f981b..7d2b72853b 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -667,6 +667,8 @@ static int xen_map_ioreq_server(XenIOState *state)
>      xen_pfn_t ioreq_pfn;
>      xen_pfn_t bufioreq_pfn;
>      evtchn_port_t bufioreq_evtchn;

In this function bufioreq_evtchn is declared uninitialized...

> +    unsigned long num_frames = 1;
> +    unsigned long frame = 1;
>      int rc;
>
>      /*
> @@ -675,59 +677,78 @@ static int xen_map_ioreq_server(XenIOState *state)
>       */
>      QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_bufioreq != 0);
>      QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_ioreq(0) != 1);
> +
> +    if (state->has_bufioreq) {
> +        frame = 0;
> +        num_frames = 2;
> +    }
>      state->fres = xenforeignmemory_map_resource(xen_fmem, xen_domid,
>                                           XENMEM_resource_ioreq_server,
> -                                         state->ioservid, 0, 2,
> +                                         state->ioservid,
> +                                         frame, num_frames,
>                                           &addr,
>                                           PROT_READ | PROT_WRITE, 0);
>      if (state->fres != NULL) {
>          trace_xen_map_resource_ioreq(state->ioservid, addr);
> -        state->buffered_io_page = addr;
> -        state->shared_page = addr + XC_PAGE_SIZE;
> +        state->shared_page = addr;
> +        if (state->has_bufioreq) {
> +            state->buffered_io_page = addr;
> +            state->shared_page = addr + XC_PAGE_SIZE;
> +        }
>      } else if (errno != EOPNOTSUPP) {
>          error_report("failed to map ioreq server resources: error %d handle=%p",
>                       errno, xen_xc);
>          return -1;
>      }
>
> -    rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
> -                                   (state->shared_page == NULL) ?
> -                                   &ioreq_pfn : NULL,
> -                                   (state->buffered_io_page == NULL) ?
> -                                   &bufioreq_pfn : NULL,
> -                                   &bufioreq_evtchn);

...which was OK prior to this change, because (ignoring the
early-exit case) we would always pass through this function
call, which initializes bufioreq_evtchn...

> -    if (rc < 0) {
> -        error_report("failed to get ioreq server info: error %d handle=%p",
> -                     errno, xen_xc);
> -        return rc;
> -    }
> +    /*
> +     * If we fail to map the shared page with xenforeignmemory_map_resource()
> +     * or if we're using buffered ioreqs, we need xen_get_ioreq_server_info()
> +     * to provide the the addresses to map the shared page and/or to get the
> +     * event-channel port for buffered ioreqs.
> +     */
> +    if (state->shared_page == NULL || state->has_bufioreq) {
> +        rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
> +                                       (state->shared_page == NULL) ?
> +                                       &ioreq_pfn : NULL,
> +                                       (state->has_bufioreq &&
> +                                        state->buffered_io_page == NULL) ?
> +                                       &bufioreq_pfn : NULL,
> +                                       &bufioreq_evtchn);

...but now the initialization has moved inside an if() so it only
happens under certain conditions...

> +        if (rc < 0) {
> +            error_report("failed to get ioreq server info: error %d handle=%p",
> +                         errno, xen_xc);
> +            return rc;
> +        }
>
> -    if (state->shared_page == NULL) {
> -        trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
> +        if (state->shared_page == NULL) {
> +            trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
>
> -        state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
> -                                                  PROT_READ | PROT_WRITE,
> -                                                  1, &ioreq_pfn, NULL);
> +            state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
> +                                                      PROT_READ | PROT_WRITE,
> +                                                      1, &ioreq_pfn, NULL);
> +        }
>          if (state->shared_page == NULL) {
>              error_report("map shared IO page returned error %d handle=%p",
>                           errno, xen_xc);
>          }
> -    }
>
> -    if (state->buffered_io_page == NULL) {
> -        trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
> +        if (state->has_bufioreq && state->buffered_io_page == NULL) {
> +            trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
>
> -        state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
> -                                                       PROT_READ | PROT_WRITE,
> -                                                       1, &bufioreq_pfn,
> -                                                       NULL);
> -        if (state->buffered_io_page == NULL) {
> -            error_report("map buffered IO page returned error %d", errno);
> -            return -1;
> +            state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
> +                                                        PROT_READ | PROT_WRITE,
> +                                                        1, &bufioreq_pfn,
> +                                                        NULL);
> +            if (state->buffered_io_page == NULL) {
> +                error_report("map buffered IO page returned error %d", errno);
> +                return -1;
> +            }
>          }
>      }
>
> -    if (state->shared_page == NULL || state->buffered_io_page == NULL) {
> +    if (state->shared_page == NULL ||
> +        (state->has_bufioreq && state->buffered_io_page == NULL)) {
>          return -1;
>      }

...and the tail end of the function has not been modified, so
(not visible in this diff context) when we do:

    trace_xen_map_ioreq_server_buffered_io_evtchn(bufioreq_evtchn);

    state->bufioreq_remote_port = bufioreq_evtchn;

    return 0;

we may be using it uninitialized (in the trace statement
and when assigning it to state->bufioreq_remote_port).

Could you have a look at this and send a fix, please?

thanks
-- PMM

