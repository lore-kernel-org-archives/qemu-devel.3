Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13AFC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6VO-00009J-E1; Mon, 03 Mar 2025 09:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp6UV-0008DY-D4
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:10:01 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp6UR-0005zP-35
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:09:53 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6f6ae4846c7so38572777b3.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741010989; x=1741615789; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cIgyhJ5i2vtj1OWVRMetShaA8mHEg/S5UKs6I4/1BJg=;
 b=N9hrX3QgW2h69LdOiu8tvkPW/4nZuV28Mw68KdXp4NLJRW5T5BQQZWZH5UIZeirZJ+
 IrbQ3GFewRqWb2dJnqeuAvwSGtk8F2ttPS0AIi+mzabLQOMOQepx3XZkCS0fQEe6gQDA
 4n+BryR2S/5rpDhifTy7l/ZGi0OM8ERIoEYqIna6GCUiTy1tTqgz4WIfRbNz4le7j0ZX
 H5aJ0/FXMouZpV8tdLoWZiWptyrU5U1bVMBTKakdjUS3q7RczkLtao63J4YkGdRkLrwb
 mZwzG2xm6BCnl4pF1Z2vkJogoFDt2sYpb/PMbHx95M6qQ/sQK8aM0T2rgkZV+SZwCbfa
 oR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741010989; x=1741615789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cIgyhJ5i2vtj1OWVRMetShaA8mHEg/S5UKs6I4/1BJg=;
 b=NppM8XTj+QEue3WDD/Us4b0YQiBIBoi2tzYzAuttoODaJzoZRv68nvce6alZoyEISg
 B7rtqLDB25cl9Vp2BHBfXp6vQxYKXReOK6ny0oPlFnzic7VjG+wRAHhkrh4SWZm/nhJE
 Ly5dQJgdNlU4R1IKSLQOwWM0X5AQCrm2zZVdrd14Rcxfcll+JTpu07jiuib9RLrnMqTQ
 e1WmitWqWEAeWMnvYzi0EbQkapm8VNiZ7fY1arWuZ3YwOiMZ9AUnLBVnXvLg2PuVMSqA
 7oeVSVn+zm0PxlDCHGe75JBwMJPBWRTFNZPiYlWjeYvjtudrqb8HFRKFSvDTi+G8JBWE
 4s6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8fhALWMqmBu9OSW1DdsJAfsmewADi8M2PA2veAFfNKPvhN0lbNDKm92iXa60UraWCIN1rZHFlTuEu@nongnu.org
X-Gm-Message-State: AOJu0YwnpANMwAAGHpVYY8/CXXgHZNd0qvRynZU8BeTxvQNtwCI/wq/i
 OJt+CTZWlQpLk1cFU3BmRlKm9TOYCMUuUqBI/iQQBv5tk5VRUMBsfOENqzeVBIMGi9cK7gq7Ca/
 frYBw18Pd+7B7Jb3CtTNhTcR5ggGuu9g6biSUfQ==
X-Gm-Gg: ASbGnct0LBd1HOGW/jQdWrsj/7Zi/WUStD+CZ2ERVQd7sesHZF5Vpunzvqta1Cr0tDy
 8bDrL9xOg4J42TMvhkr4frVLnoyeZW6IWayafM0d47O6CZFAXW1KeqAgy7mDltCtTx/IR4FUld5
 kI98WyOvHFvGqYqIzfu3hGSBOL/vA=
X-Google-Smtp-Source: AGHT+IHn/Qj9KR57Jb94/zF0FQLukje61TZ0Qeij5hYeWt04dchmnP5FxsFTQmZ1DLABnaLuj/4+Vkii1m7EmWsP/tU=
X-Received: by 2002:a05:690c:4c12:b0:6ef:7d1e:bffd with SMTP id
 00721157ae682-6fd4a17166bmr162906027b3.37.1741010988574; Mon, 03 Mar 2025
 06:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20250221031034.69822-1-jansef.jian@hj-micro.com>
In-Reply-To: <20250221031034.69822-1-jansef.jian@hj-micro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Mar 2025 14:09:37 +0000
X-Gm-Features: AQ5f1JqKGoga6YGxJGBZ1VmYHzV9G6tZXuEQEi2Vs2kLxZRYgambW39F-vcC05g
Message-ID: <CAFEAcA_tmXzG4-P-VtZZqFkrcra0t33OEm3OTCkExNFDu7LBPg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/smmu-common: Remove the repeated ttb field
To: JianChunfu <jansef.jian@hj-micro.com>
Cc: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Feb 2025 at 03:10, JianChunfu <jansef.jian@hj-micro.com> wrote:
>
> SMMUTransCfg->ttb is never used in QEMU, TT base address
> can be accessed by SMMUTransCfg->tt[i]->ttb.
>
> Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
> ---
>  include/hw/arm/smmu-common.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index d1a4a6455..e5ad55bba 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -110,7 +110,6 @@ typedef struct SMMUTransCfg {
>      /* Used by stage-1 only. */
>      bool aa64;                 /* arch64 or aarch32 translation table */
>      bool record_faults;        /* record fault events */
> -    uint64_t ttb;              /* TT base address */
>      uint8_t oas;               /* output address width */
>      uint8_t tbi;               /* Top Byte Ignore */
>      int asid;
> --



Applied to target-arm.next, thanks.

-- PMM

