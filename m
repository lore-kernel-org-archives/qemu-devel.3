Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559FDC624DB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 17:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDfz-0006lc-V2; Sun, 22 Feb 2026 12:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vuDfy-0006kt-R6
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 12:55:26 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vuDfx-0005Ly-F3
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 12:55:26 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aad1dc8856so25139965ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 09:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771782924; x=1772387724; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IxWkRVySp2TN5N/hipXG08upqyJuHl6A+T8aoTQwk60=;
 b=k1QxqfmxSXyGsjvwIRQh5hPQ4Z4prusTAfUmGBKGzP6PdZChdLQA+yV3/VP2CXQ2d6
 Xb/ZEfevwWOTSnKUOt4Pzm8uzEkadzCF/MqHDmhGFMDYQrQycE5sMPF3hWzNWgvNK+c5
 5w7HLiebHEZS8Vb87Q7lcaOaxD7/mvxJPmJOJV+Rgu2Z3uU/EKNec33TL1cwI4R32+pB
 6CCJLcJ3hlVmd9rpKgD//RyBHr7dQ8Q5RaqORg49vr9GyASHugMvsjrZ7sFpczW9FHaM
 FJa3esehP0Fstw/1IzUXK6lhH43mnY08Ynd87wQ0iFtxl4j21KGuJqAC//UfWDlEAlLZ
 BbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771782924; x=1772387724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxWkRVySp2TN5N/hipXG08upqyJuHl6A+T8aoTQwk60=;
 b=OEJv7NYxWkIjNfovpFiDrjmnAUdene7rviEbpsj3FQESJ2O/PWSRceHxaGV5vfxdEl
 ev+h/Yp0+4yletq8c8t4D/6twzcUrXXPfNAvrqvgMhjk4Cyxe87G+dpX0tgh49McJMqy
 FvMosRDKCTgVm7She1o0OJVhWj4/9iXAUvB3zxX9b95eAfgYGPlqHLDTmfhF/UTPaezo
 lwiaCPW48kHIHjrSDssD011shz2yRDqaM3+rSGr1xbj+KmCtS+jMXQsMgiyMqIXtoFQf
 MNOq64VWdkNzzJxttbXjp/NCqn0zpHZVpcGbsVhtFwYIonEP9v7AT4Udm9+ge2R2F1vV
 taPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMxlm3OSjWjmB/iAFTI1w7yx6n81bRmEgvyxMVf4HweOGEGWSuKmHFpB62QK8W6qwy79GxSFDenTsu@nongnu.org
X-Gm-Message-State: AOJu0Yzx1cCGvTVfkmKTdfUa8MEVXd7VcduA3mXXJh7Z6HFPic/XtG0Q
 hW/4gjQVanPXgUEdBvWCJER5ELlm1afm+KeNJoU4XhK0CUjyVj5RKGpA
X-Gm-Gg: AZuq6aJXGqHFPu3Fwzjv/0bYu8sz+dYOGqBW17oZngOMKX+fSIT9porx2vKgPhol0A0
 MhOnyE6DMStRRh6E3oR4hDZ9X+w/PpWdrzMc011IpLYhjx56+Lxap6UGPwb17ilduoVdiVNrQGA
 DC44z//TZoi54kU3WKEG91o9fjaB0AsEcD6yrUks0Peb5MSli60NuVpQ+xwtxL3zIuEiGz4ZiWm
 qtKzG1kN2S2Kcxt3AXe7F+SEvQ8Qup0za6u3j8nrqkQJV5tpdtOK24D5PILB3BSQhtszGijNNCK
 98kyuIna9+enqUmNPkZwJ+PuTucvaPSznZ3+wZT0v+HgoqJgH+WDRD31UntIagUFVnR6/4hpp4J
 2wRx8bFMRkaM9tZOEZ8aYm6ZXjppjTv20qhLFUi4qcmzPHpmxJnJszLZ+pW1AjpBKpfEFfChhzI
 lY/vq6KGBe4jn6f5q0+Cv1G5RVpH4r1hYNJddSpMua2vpfOPe8JLiKD+e31D+JsDbSn1k=
X-Received: by 2002:a17:903:2283:b0:295:560a:e499 with SMTP id
 d9443c01a7336-2ad74419fb9mr51734405ad.5.1771782923609; 
 Sun, 22 Feb 2026 09:55:23 -0800 (PST)
Received: from google.com (61-230-28-18.dynamic-ip.hinet.net. [61.230.28.18])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7500e2b2sm49389245ad.52.2026.02.22.09.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:55:22 -0800 (PST)
Date: Mon, 23 Feb 2026 01:55:20 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: laurent@vivier.eu
Cc: jserv@ccns.ncku.edu.tw, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/misc/virt_ctrl: Fix incorrect trace event in read
 operation
Message-ID: <aZtDCIujj1OC-ol0@google.com>
References: <20260111184915.1363318-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111184915.1363318-1-visitorckw@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x630.google.com
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

Hi Laurent,

On Sun, Jan 11, 2026 at 06:49:15PM +0000, Kuan-Wei Chiu wrote:
> The virt_ctrl_read() function currently invokes trace_virt_ctrl_write()
> instead of trace_virt_ctrl_read(). This results in read operations
> appearing as write operations in the trace output, which is misleading
> during debugging and analysis.
> 
> Replace the incorrect trace call with the proper read-specific trace
> event to accurately reflect the hardware behavior.
> 
> Fixes: 0791bc02b8fb ("m68k: add a system controller")
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  hw/misc/virt_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Any comments on this patch?

Regards,
Kuan-Wei

> 
> diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
> index 40747925a2..9b82e97ffd 100644
> --- a/hw/misc/virt_ctrl.c
> +++ b/hw/misc/virt_ctrl.c
> @@ -43,7 +43,7 @@ static uint64_t virt_ctrl_read(void *opaque, hwaddr addr, unsigned size)
>          break;
>      }
>  
> -    trace_virt_ctrl_write(s, addr, size, value);
> +    trace_virt_ctrl_read(s, addr, size, value);
>  
>      return value;
>  }
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

