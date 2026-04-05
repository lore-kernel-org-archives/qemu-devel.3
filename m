Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DFBE9D827
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9X1x-0003RW-SV; Sun, 05 Apr 2026 19:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9X1w-0003Q1-RB
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:37:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9X1v-0004ox-Dt
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:37:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b24fdac394so35052475ad.3
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775432241; x=1776037041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=clgBh3y0kC9vRzxht/lmZZAh5KQpGrnNySBfHQK97C4=;
 b=nNMHo3nAyEav9FMSKPB+7i4bVG0uthkhS++5dBQuG2zsJBc5RsxpQr3jF/wr7wcu7L
 +4Ni9c6TAdk6SywuziN2yYsxjWs+rfP9D1kVdIgw5yBTmLYYGd7d9jIMNGKAwd28vkvb
 2sQp5Yy5ilw5fKpt6gEcA+LSTUpg77CgRPwjPURkaQlDy2KRVC2wHqs2sCs9oFrUs2Wz
 KRLVjRgFazxaOBJp5Xpdon86UWa49NEnlPNGlS26QTgSTg7TmAtn+rn9C7ZTr8NTz0G0
 6xtdt4UswsNsuCM4M4swmsbuRWU1FDgeNhehReIWlDpWrEW10vQLtTXE/EkzmWGhTlUy
 l23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775432241; x=1776037041;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=clgBh3y0kC9vRzxht/lmZZAh5KQpGrnNySBfHQK97C4=;
 b=PXW/NenDWr+A6QQ44hQs9f2MLgeZsbhCHTeCYnOOOA6y0f8G5wU05n5zBwZdMgSr2f
 mySgB31Th8S8526ge+namcTGs1A4SfDw0mzJGxCzBCOr6Q4InExtYdGz+wjUu2O+ixOi
 OB8ExtmnpuDMruzmuQ+0aAoAcrXW+AJaANqStkQoW/BxJ/WTJhGrk4UANpbVpRbMMxXJ
 Pi05QzY7Z2tNw0EIOEXUK+/0E7nPg7wstx2R/NWgnBgXcskODukPl/YyUP0zaMoLbKXr
 ORVxkH5RAQHXL2E1vqcSQ3b8ot23veTrn2mloIb3tWEx8dz/jrAw+d26Pv8OIHYPFgye
 E2tQ==
X-Gm-Message-State: AOJu0Yx78+0Vvon1gj14cC8OW9w+XKzZiWGNvCqjcy0xs5JsPC2BQ2ux
 Ma6GdjKpDTgup2fHS7Dfp5O0urwAJp7wtNCRNUEnZ+gaqqqMFbgND4sHDIsueabOmSSUwxs20aQ
 zzP1k
X-Gm-Gg: AeBDiesLVccy8qh0Rc7Yj3clRjBIJB+Bv3/Zl8R8wJ1ifjFHhUWKgL2fxMVBhjrvxI3
 i1ZmAI/txI5DuklTVSdUREbkThPvDcedFUvFyfi5SHaKfZEypz+c+GpzGFDAfYjM4adB5Jmvt0V
 eybW92cLh4Tiah6FPAK2AZW4fiOxfd2PnfE6aq5/5Cph1TKYhg0p2bbYSRY7nfrf3ISOV0BrP9e
 qiqjkXpR6TI4cXVloklE21mMuim+vlbNHk/BOESWsWY8ObYENp6f9TLWzXB1zYs+Fr5Pmq+yri3
 NOu6YQawHAhk0lxlFOws4uMHsjVKjPi+gzJO6wniK21lq82HChx5uSC+NugVFCt2k98XOVr3u94
 aM3Ng/7jkpOkArsEt36Nw5wgLmr/ry1El+rm/fa4NQ/BXQq05R0BYuh/0MunLzdzbUIMplKfzmb
 2TOyG1MFfBQWmPpUXwM1jB5g0sSDWoxXGY4xpronZUuJj6htUgfN94nhaGAVh0wXyo2Wc=
X-Received: by 2002:a17:903:1b70:b0:2b0:bebb:1081 with SMTP id
 d9443c01a7336-2b281799025mr119936455ad.28.1775432241363; 
 Sun, 05 Apr 2026 16:37:21 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472d618sm115153755ad.12.2026.04.05.16.37.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:37:21 -0700 (PDT)
Message-ID: <5b6e3a04-b4e9-4581-9750-7f1d7bcfe861@linaro.org>
Date: Mon, 6 Apr 2026 09:37:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/35] target/arm: migrate debug syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> Migrate syn_swstep, syn_watchpoint and syn_breakpoint to the
> registerfields API.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 54 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 48 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


