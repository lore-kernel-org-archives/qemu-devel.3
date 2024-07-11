Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99C9C3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 07:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRo6Z-0006R1-TF; Thu, 11 Jul 2024 03:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sRo6Y-0006QL-4W
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:20:38 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sRo6W-0007QH-F3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:20:37 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52ea5dc3c79so787391e87.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720682434; x=1721287234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Hpq5/o883c4xxkl5ujSW9+2x2pZLwGTmOaQkpVvL8k=;
 b=ZvPGFVe4a2YhLtjhelTpP6AmSF1YIvqRwA0D26slhyXg60bHJdwn0fTG3coP9Wt0jE
 MpVp4QPNRYXn9SQR7rWh78J7UdZuvg//WN9j3BB8tXUupuU+Z6akOkxdS5l/JjfcNOry
 NsiDV16X3SEPwSK8dVDnNprUVjEvVSGpfgNHUlqS6Xo0vSZYl6mPCXe2yr64/yoWSE52
 hj4uQmIVAUJXcphVGpzYfKnKJTUfC/84gu4UucNhUl8EAqBBud2rBhMSKYAqgnwzw9iU
 iKGqtnJ2HEXUyNK0mEoJKQ26jqTBIFhCwPPtzJn3PAhbuFiS0ij9HjC8BPXv0y9Gt/P6
 NFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720682434; x=1721287234;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Hpq5/o883c4xxkl5ujSW9+2x2pZLwGTmOaQkpVvL8k=;
 b=WEVX7fgiIvZfPkQPs5H6D4QlaufGo32fR2Hno4fNvhZ85sG75CR+JEIRML0YQlf0Wk
 gx9VZCIcgTXNOUe5l87GtfCHgpB5j45VL7M4KIabCFPAwF7vml9BkblS2I+NvH8RFqJY
 a/OFjcd5euDGgU38M5Q/fUiNcoXgQmRCshDPoMaEYPliDQ8L4TyXiKK/Lk9x4FDLVRh6
 OGkIX/iIMH2dxg0HjoEBFOQZh/9Kq1UXkxi+cywmPNERYSsVyOsNp77ZRzhVIfJ7kjuu
 T4kOkkF0Z7fzPeWpvWZPeO6NAI2ulBdBVfN72lh0lUdQz/r2WBmevM5Cix5piU3Tq67C
 s7Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBaoYCQq/BXbr4KnFmOIAqFxGg1yR7cPN8rTTbyw6vjIv9yQje0sce5OV2h6Dd/Tl/duV+GwV03PYP6f70ZnmonV4Frv0=
X-Gm-Message-State: AOJu0YxSALYTypcOyvRuNSWZfFj2RVvCzrCYJsd1xfgOW/PMe7a7sHo3
 2lL0qPjOGi3OGzlVKB0e2IGYITCm23hYpyga+TElrB8AXrydybAE
X-Google-Smtp-Source: AGHT+IHyEl4w+j6z59oFYM7mDuz1ZVD3/KTvFid9Yc+fdEi1gJ3GKcWwG5rIYN+130m1Q0SIH6jOvw==
X-Received: by 2002:a05:6512:3d02:b0:52c:da18:618c with SMTP id
 2adb3069b0e04-52eb99d330bmr5637909e87.45.1720682433708; 
 Thu, 11 Jul 2024 00:20:33 -0700 (PDT)
Received: from [192.168.10.200] (54-240-197-233.amazon.com. [54.240.197.233])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42727805e4csm70474735e9.27.2024.07.11.00.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 00:20:33 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <d82ecc2e-05ba-4e2e-8471-2af05d9e1406@xen.org>
Date: Thu, 11 Jul 2024 09:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add Edgar as Xen maintainer
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: anthony@xenproject.org, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, stefanha@redhat.com
References: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=xadimgnik@gmail.com; helo=mail-lf1-x136.google.com
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/07/2024 22:28, Stefano Stabellini wrote:
> Add Edgar as Xen subsystem maintainer in QEMU. Edgar has been a QEMU
> maintainer for years, and has already made key changes to one of the
> most difficult areas of the Xen subsystem (the mapcache).
> 
> Edgar volunteered helping us maintain the Xen subsystem in QEMU and we
> are very happy to welcome him to the team. His knowledge and expertise
> with QEMU internals will be of great help.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
> 

Reviewed-by: Paul Durrant <paul@xen.org>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6725913c8b..63e11095a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -536,6 +536,7 @@ X86 Xen CPUs
>   M: Stefano Stabellini <sstabellini@kernel.org>
>   M: Anthony PERARD <anthony@xenproject.org>
>   M: Paul Durrant <paul@xen.org>
> +M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>   L: xen-devel@lists.xenproject.org
>   S: Supported
>   F: */xen*


