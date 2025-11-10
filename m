Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C389CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIST9-0004Sm-Cv; Mon, 10 Nov 2025 09:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vISHl-0003Cw-O1
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:50:22 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vISHj-0006PR-Hv
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:50:20 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640aaa89697so4371605a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 05:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762782617; x=1763387417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXCEtuBybIWNkH8OqUFYjuZlPwZp9AyCadxRNtAQ1Fk=;
 b=FdrH05DFq7RV2j5NXlZA46PVDmNILtkho/sWLPXeZNtU51roQPbcvywh1yp9dVcvfC
 2R4RVNljM8U5CdvUCyDw6FFwIeslcTMxWPshznpsPf2rH6VfBi5ZhccAsJ7HAdPyQHmH
 OPQXoPUX5okSmr3aasLHO4Tzy5ywKAmyvEVUPIARux2yjNKeLE0TPKcU5imRX3ainDvE
 CfKpyW8U+N3PsxkbyHUsAt0mb2q/Ih4bIJwCy2+fbkYsi7J/WlpOXyMBE7d1SPWMnKyN
 /N6+3dv3fhs+u8KzBfIPihxMVbTuBW2gi8Rv4Gy10BSLw18FwSSgTCJZSH2gYgJCm70v
 IdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762782617; x=1763387417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mXCEtuBybIWNkH8OqUFYjuZlPwZp9AyCadxRNtAQ1Fk=;
 b=pMozkkayUkyQItm5RjhrkufHRFVX/hN9lKwBja5nZVxSRUTaqDHB3x+AbXoj2kguiy
 4RKTgQhHLVLE82R4fQEoDhNtjWErH2NLsDwMwcUam6l7v/u0C73QwzoCxKGKnv9a4rHi
 iCWKYfE8GXtxlw93aJkCUWDbaMOaD6o0E5IhBZV8+dJv9bWCA8V8V/8eFy2B6FueLfeE
 eXNwcawssGv0NABPnkAC+tR4x1cACTOxIgh4zl6hvsjXyZS1/Pxbz66XtjnmkUx0O6Fe
 1kUyPZ4M33XtVrRgIHm3k/oGD29qbGJ3tuWX3GPzthkACB+J2ReJLYQQJVrJBNU81lvM
 rDfw==
X-Gm-Message-State: AOJu0YzZG4zl2W9c/t3X5qO7j9ZOc2nMV5PeQwUEhL5hJATtI7cMkgCx
 ZFHTzpX0mj71nqa90IBJbYPtX7hHdg6BLm6mva8QFt5g53j8zfBD6Zyhgck9N7WvPmLk8EsGRYz
 5MOIHG1ldaS+vkPZAAioqLu3mpEQuQ92MxTodBCgJCNWpQySfQfk70MPDow==
X-Gm-Gg: ASbGncveODRxjANRy5qQOqxgFLH1x5XrtNXsa3PNWk4eMOYIFqVtV1T/upVBMj3QlO9
 bzZx+5LZeGfPK5NlL8iweGCmWNHVHnwwrq7z5xIOhDcUUSvzFaS3hFPd+KwkJmNSK5Frqz0xvRY
 Tqcbvr6Z6huBq1ZyEv5tIl+yGVhrJKBztKL7rca3OZUb/IDEkni8h1pW3y0URefmjeVLopubT2l
 qDDCiHxOu/zJOYNprdmHI3HxTAp695ZZ5CEwiLKsgJ/66kTrQabctTdJ9OUCuPFon8R
X-Google-Smtp-Source: AGHT+IE/JOFksAxd4GP0WJpLJIQ0n3ZDNisPdGVey7S5iYT2Plwz8uGkMIsJzhC55C1yOSG2bl+48zbs1DI9K8nGifY=
X-Received: by 2002:a17:907:60d1:b0:b70:bc2e:a6f0 with SMTP id
 a640c23a62f3a-b72e02b3521mr716652666b.5.1762782617332; Mon, 10 Nov 2025
 05:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20251106215606.36598-1-stefanha@redhat.com>
 <20251106215606.36598-2-stefanha@redhat.com>
In-Reply-To: <20251106215606.36598-2-stefanha@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 10 Nov 2025 15:49:50 +0200
X-Gm-Features: AWmQ_bnZzqS7WMrJ7s44Zlwk6qf7OzRpa8-8ZzodONy_k1hmIh955cAMABSYzUw
Message-ID: <CAAjaMXaXgsHK2z-f81x_baUSZcaSsfRpBo1=s1TsgPeoPi3GSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hpet: remove unused trace events
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sun, Nov 9, 2025 at 3:57=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/timer/trace-events | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 2bb51f95ea..f3fca6fc9b 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -112,7 +112,6 @@ sh_timer_write(uint64_t offset, uint64_t value) "tmu0=
12_write 0x%" PRIx64 " 0x%0
>
>  # hpet.c
>  hpet_timer_id_out_of_range(uint8_t timer_id) "timer id out of range: 0x%=
" PRIx8
> -hpet_invalid_hpet_cfg(uint8_t reg_off) "invalid HPET_CFG + %u" PRIx8
>  hpet_ram_read(uint64_t addr) "enter hpet_ram_readl at 0x%" PRIx64
>  hpet_ram_read_reading_counter(uint8_t reg_off, uint64_t cur_tick) "readi=
ng counter + %" PRIu8 " =3D 0x%" PRIx64
>  hpet_ram_read_invalid(void) "invalid hpet_ram_readl"
> @@ -123,4 +122,3 @@ hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writ=
el HPET_TN_CMP + %" PRIu8
>  hpet_ram_write_invalid_tn_cmp(void) "invalid HPET_TN_CMP + 4 write"
>  hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
>  hpet_ram_write_counter_write_while_enabled(void) "Writing counter while =
HPET enabled!"
> -hpet_ram_write_counter_written(uint8_t reg_off, uint64_t value, uint64_t=
 counter) "HPET counter + %" PRIu8 "written. crt =3D 0x%" PRIx64 " -> 0x%" =
PRIx64
> --
> 2.51.1
>

