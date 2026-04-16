Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61372F433C7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 04:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDEk2-0001Z8-Vt; Thu, 16 Apr 2026 00:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wDEja-0001SK-8I
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 00:53:47 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wDEjY-0002Ek-OB
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 00:53:45 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82f431c0ab6so1874670b3a.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 21:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776315222; x=1776920022; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IqCapmQtvmEhj83T0wFK+kbc8osS06Sdqiw3OpaSi7g=;
 b=LzulVrcbd73IjPWYvxCOm4eaqzQbc8sFdF6+Xat/g14D62Wjauv6RB5AsigQid72Mi
 Wea8SV+nztZ0cVxFv/7LNxFpq4KzinjjPF37XPf6gnNZoi8Wtu1MF53FFS4L8Q44DQLk
 kG+G3OtTP8xpcYlYdEi8bemSIljRND5l1tGqcXo/gZ8pUQuu5TpcURtgzjNkRlIWIdnX
 6K1zOrg/opnfxnb0YwbnlGUIGLPoL82t+I9BKEIG9tIZ0FWd88PSUxPhI0XenJiXCGcn
 4XIGG9DHBisvjAysk7CK5rXNIHjHKlSQoh63PJ6EtV4DLQDbGfaF9Z3StcEgWQ0upabM
 9cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776315222; x=1776920022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqCapmQtvmEhj83T0wFK+kbc8osS06Sdqiw3OpaSi7g=;
 b=bM9s6Rfr6KGL+PlfL1/m157d/L2ALvdpfuxU2l0m8EHvBryd7cRYo+T5chhxobfzAq
 XgDsRktUiirOvm/i8jRF/IqJHYtvsUXqiCgJPDM4WaATEYfU9rAyV22S2A32zDsvsTQb
 1GcZj+T869Gq+iFOaVTQvyaL0zrf6c+dyNYHjQGhuC02NlqaLqTxq/lPPPqhzswz8FRJ
 xvwYOIZ9QlO8IxHOl2aiNxnfArasef2LJwDybGiXeAhjF6jevsVzmMfGXZCcsCwUrFni
 rCGxdgYFfT7e+mZwOzdu9/5AVt1h/5nTXhV+F2XwOS+TkM8xOEEGHrAE5cVnojQ8XnX3
 JK+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jQeawLv3cJ1WIc+9seSFz0icp3OQndYPSYKukvuH8+ZwDjNbIlqCzBg66dOfkpXBE39cFRLjwnAqL@nongnu.org
X-Gm-Message-State: AOJu0YxwV9PEXWbBrghWVLFaykW8RnuzYoEnpuG29Q8Ukxw+rzx7HYwK
 grKps+lnGtMNpDb5irSpFObwxM6exejMrlGwPNrd0NDuLRNnccOloNsO/vPA3+6UdYI=
X-Gm-Gg: AeBDietwDiOmyUKPBfWs4flR2oz5AwsOBK/WZVyqEm5ep31CdrAXA1shOFt1bhhB+cK
 CbeixTnWO25scTzi7pBSu2C1garKW+dEjIzliaSjXiDPOQdbjHZvgPqdzwZ+kxBb39l0a41FAsc
 O0lpv/OPl9h0j3BZnVmMjPVZHTgqFcTP0hObMJlxX8HYigZzuTm2Ht0Gz5GKoXzJ/KpvfcjN4IP
 8O9QkrJjCz9VLc3BZnYCjvAh6XcFa4J61q1/OpeLo1SdzpomtYcsQMbMu0+vNkSwLTFQ2YJiJqq
 kwbIK5RPPxI1++8sE6238m/K2lpLHzwGk1sV8qI5aaw8psWiM7m80DbpB9DKyarCoX/WkQxoN4+
 FzP2Qz6Iq5TEocLRokYmH0pvYiHU07wjJYrxDeLS6Jbxlw2lIbdyVOuGzb+Mr0iVDeYlHSSKuUg
 877JBqa1pyg0FXXwn+Lp/DMnkIxdenTXTVca0NneRpLXrTI517x6kCKih6oIQgsGA9
X-Received: by 2002:a05:6a00:2d8c:b0:82f:61f5:1d7 with SMTP id
 d2e1a72fcca58-82f61f50c9amr6568971b3a.25.1776315222565; 
 Wed, 15 Apr 2026 21:53:42 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e0f15sm4620065b3a.35.2026.04.15.21.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 21:53:42 -0700 (PDT)
From: max.chou@sifive.com
X-Google-Original-From: Max Chou <max.chou@sifive.com>, 
 ProxyCommand /usr/bin/nc -X 5 -x 172.20.10.1: 6153%h%p@sifive.com
Date: Thu, 16 Apr 2026 12:53:39 +0800
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2 4/4] target/riscv: Use ELEN for Fractional LMUL check
Message-ID: <aeBqXgTuxs-CMkNi@sifive.com>
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
 <20260415233740.3027321-5-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415233740.3027321-5-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x434.google.com
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

On 2026-04-16 09:37, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V spec states that
> 
> """
> For a given supported fractional LMUL setting, implementations
> must support SEW settings between SEWMIN and LMUL * ELEN, inclusive.
> """
> 
> We were previously checking VLEN, instead of ELEN, so let's update to
> check ELEN instead of VLEN for fractional scaling.
>

LGTM Thx

Reviewed-by: Max Chou <max.chou@sifive.com>

