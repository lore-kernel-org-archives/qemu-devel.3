Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA14CD5BAA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPywE-0005Dh-Lv; Thu, 21 May 2026 04:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPywD-0005DS-TF
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:39:29 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPywC-0002oy-5d
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:39:29 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-135e88b8e55so6335609c88.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779352766; x=1779957566; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rxyAYIpWNqpe7nhy7CIlHScm688pqtzhxvN8cp2bMNg=;
 b=U1BFUzZJ2M859IWXp/rBEpDTRB9HMN/Hw4TyDw5RtE413ptDiGsL9TE0C6MQbYNHqf
 vTdcHqbmI29BhXSNeDfTIUBrE9Rdb22fK0GMTstc5eXurbmTAAN/FO4vb/KOzZa84kyh
 T1Ty8Yvk8YzHQHujniCEE5I9KGGMXoxhMZR/1pedQTxN8DZtiPlrh6iY+R8BCcI9LFra
 L7jHlSx+FUnXDvB5eJ4aaJ59phzMQ4QJEr+9tT0pl3hK2oO/bIjHl7gAGobka6USjFzf
 /48oZjCsD+TKo2WxO592GeL8WD+88UGaT2nCJ/jgAxApEp2bCg2dhf9c1947DoPHaT7W
 jVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352766; x=1779957566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxyAYIpWNqpe7nhy7CIlHScm688pqtzhxvN8cp2bMNg=;
 b=sQKkq01EvngKDdTwB44NCsElphVwj97Ee+oP3317IxIuRCsCA4/yM1ORf9XAwXIdXA
 Fs/MM1l2obUkQcEwvpjayNk8qNRq++omGSMCWseiZuVY4B8efLjLRIMgydhBgjuX9gLf
 YT2UExEyTJHeHQQrFTcyb7mSL4M8wj+21X6r6Qpx+oWopvnhjTuM/TAI+9LuP3xkePPb
 cmO1E+0IQros/CeIuabNq8X9gAEALbpqW6scOxb1nYSJyUv3x15BYZ7eBE8fF93wh6nW
 aZ7KXyFgIG7m26FsefygTLe8CZ+3zyIpqrNsuWCB5t1El7LkFDm/xJszst8RMlZJqETS
 Bo5g==
X-Gm-Message-State: AOJu0Ywsc0uv6LKxAEgUlZjc18rlv8HplHc3dB5AnQlY1S2fkYJhBQYq
 sKZ+gcjKMG4/uhdzHqgYGzegnUJZ3nnkllKsB3la/ZaVDSAZTHXoLcdm
X-Gm-Gg: Acq92OHf9rr7Z3T2bSeRtGh9AIR+0aAjTtgo4ldKkP/SZcqnOjbsbhS9BgWjgTxd1L8
 fn1xn3/kmRVnKGIGAHDC8WvuXulb8kQ6Zz755uBlnxZNlvhH1CPDcR7Pck/Bac8Y6io5GWp4bsI
 TtZmoCFbJxqQI8gc083xmUsKUdw7pIbH93gfwdU395RlKY2H/D/nEJhtY8NbSWs/4Cox5cS20/e
 0pDWM0yXeDWe5IXD6VDYdlDYJUcGq2WCfQK4IROp8Bf48LFWuP825k5vWJK14+lh3JtQLliutzM
 5fN41BI7Rlw9wyzQiiC74iK26DQzvtA+pdyDtwJcna1SByJeZA5u8HFQITY5+XDJfEUwpVyfvpZ
 o36g618WrGJBsq/v8cNugcF5gnoozov494NlHuQQRRU1LlM5t0JIlUC1vCvBGEntkCi6zL590fC
 555PcSxlWhvw392idsKoAVHqiOQB+pqW88UVLHS+ivtBt0LspIxmvwFQVtgV6NYzv88BJ/Sg==
X-Received: by 2002:a05:7022:688e:b0:12d:ce34:3f92 with SMTP id
 a92af1059eb24-13632e58fdbmr1139469c88.31.1779352766253; 
 Thu, 21 May 2026 01:39:26 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978ad18asm20337766eec.26.2026.05.21.01.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:39:25 -0700 (PDT)
Date: Thu, 21 May 2026 16:39:23 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 04/39] MAINTAINERS: Drop stale F: in "RISC-V TCG CPUs"
Message-ID: <ag7Eqe6WLAX9LqLr@ChaodeMacBook-Pro.local>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521080511.999266-5-armbru@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 21, 2026 at 10:04:36AM +0800, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we merged
> linux-user/host/riscv32/ and linux-user/host/riscv32/ into
> linux-user/host/riscv/.  The files since moved to linux
> linux-user/include/host/riscv64/, which is covered by "Linux user".
> Good enough; drop the stale lines.  Matches the other targets.
> 
> Fixes: ba0e733362 (configure: Merge riscv32 and riscv64 host architectures, 2021-09-17)
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Chao Liu <chao.liu.zevorn@gmail.com>
> Cc: qemu-riscv@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thaks,
Chao
> ---
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af76d9544d..366fc6c257 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -361,8 +361,6 @@ F: hw/riscv/
>  F: hw/intc/riscv*
>  F: include/hw/char/riscv_htif.h
>  F: include/hw/riscv/
> -F: linux-user/host/riscv32/
> -F: linux-user/host/riscv64/
>  F: common-user/host/riscv*
>  F: tests/functional/riscv32
>  F: tests/functional/riscv64
> -- 
> 2.54.0
> 

