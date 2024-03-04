Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1C1C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCdp-00005h-Ry; Mon, 04 Mar 2024 13:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCdn-00005L-Rm
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:02:19 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCdl-0006B8-Nx
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:02:19 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso6952917a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709575336; x=1710180136; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+XOylRq2YFuleu4481WXCPWra4gzRr7t8SnXmOsBZsA=;
 b=WboCNqNebAXBzw1OvBAEvwX98wcqMZpb6i0JUwADVESXZ8GlEGKqDgGNCqNC9YKmjr
 NEzFlYDUdGb5XM3Q9mEga2yg3UWgSwNwHdWKgGLFy1oGssMZta5C0KryNQEF0GYrfM1n
 UbVSum7JgCwbskXOapvLV9bzt2LPdFdyTHOrKNDow0aHOrOw9v1f6jTULF2yfNIvXQtE
 /hSGjIKbYoDsh7ftL4/tvgfHDW+LEMOlsfB67nd+TpDfjEYrweHMZxUG2Llp7FwUHTKz
 qQIcal6xIEY8+UKOVroF2CfwrOUMS8tfRkgZ9Z/P/NJA2iOUDPusKk9/iwQ05XMR6FjV
 cpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709575336; x=1710180136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+XOylRq2YFuleu4481WXCPWra4gzRr7t8SnXmOsBZsA=;
 b=NdhL3AUVcKMU2IkiGADk+yeASWop6xulodouL9NctOuS13XWS6wud251uqKevZ199d
 BbrPSBX3M4jRNs7HttF+tk//ZDFSnTYmdZlPbBL29V/wYEy4bU9XhviCtW25HWtKAvTI
 NNfkDUFAyCmE6FgGGKiS+B/Lz7d6DCqEdOlA626VeYVgz9MR3ivDasIYYPVx+k3rL3/J
 FN3QX6qiC6EBTiqCINxDKQv9f3eSoW1Ri1kwK4hzyIshstC1HynXoE8a4QmTyfwyzJ3g
 Yk4k7sn39LPQF6O2hGNN76EwSF7Tqzx0W0ROPbLDQV7fvRD279pcXM6i2WFHjBBVx2kT
 s8Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdWATfuR2TwYPxSfke0ZiiDBqvhnPSm+dHMZTUDrKvkXqc/BpMivElLe5IhpGsWefqgh0ib7t84Dx0e4tR61nNX9cuzzo=
X-Gm-Message-State: AOJu0YxzJgh4/oCgIk33Ro5C29B5itonnevR/FEDEG9IAD0ZD2dBwpQR
 8fWx/BrK78kjKi5xmVcJYTcv3/D/rK97B35fvA67o0Zm+g7PzUAEZS77hRlNnMxswS6bJlIKEI0
 FvWDs3Nfa8v4ANSH2Gu1baCOYQk7RPrNSRiXilg==
X-Google-Smtp-Source: AGHT+IGyyQy0+h0frsDg1HOFYw9j2oLlXedk1tVhiAmZXiDWAm1/jx1QYCVUo6Bvpnmd/7ab9ZMBzfCySY07pGQWHNg=
X-Received: by 2002:a05:6402:3d5:b0:567:6c78:52a1 with SMTP id
 t21-20020a05640203d500b005676c7852a1mr1310476edw.32.1709575335944; Mon, 04
 Mar 2024 10:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
 <20240303-elf2dmp-v1-6-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-6-bea6649fe3e6@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 18:02:05 +0000
Message-ID: <CAFEAcA_q58Qop1SNw7zYdCAfhxtsWyRR+A+hJXht2S86vH-nww@mail.gmail.com>
Subject: Re: [PATCH 6/7] contrib/elf2dmp: Continue even contexts are lacking
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 3 Mar 2024 at 10:52, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Contexts of some CPUs may be lacking or corrupted due to premature boot,
> but the output may still contain valuable information of other CPUs and
> memory.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/main.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

I think it would be worth having a brief comment explaining why
we don't make these memory read failures fatal errors, to
avoid somebody in future putting the error path back in again.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

