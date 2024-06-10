Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0966C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjkc-0006WW-KZ; Mon, 10 Jun 2024 14:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1sGjkO-0006UG-Ok; Mon, 10 Jun 2024 14:28:01 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1sGjkN-0007Et-CQ; Mon, 10 Jun 2024 14:28:00 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5b9776123a3so2413132eaf.0; 
 Mon, 10 Jun 2024 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718044077; x=1718648877; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e+vKsbcoleOYuc4PiNiO5dWwOmRc3lrgxALbS5CidGo=;
 b=JdSKYIGvtsePQtNTysA7P3T0lthA1bxO7I+D8ocNFxoSr5hw23E+qOK5ozNmlJoSp7
 jXmpVp6F7rGJbStNyo7hQaApP06upQLhcKhU4aZXfqRJQqnBoQ/LNfxB7qS7qWd8t63j
 8WBir+aoPBilw4QXCamMiL8IJbBP73V9JiyMZFxXEE/Jzo2c/x8Zwpr81ueoTy2den9v
 DzSwEPn+VSAdR3/c4sFGUTu8ynZzh19FvmWSu3BghgFKDu60DdLU0FBbeEdAboidN7sK
 bdSNmCnEHalAlQouCJ7VLHuBxVOMEDF3MgeyJu8R4hNCqjGV8KdgzwO6C0thLL2QkGeB
 BAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718044077; x=1718648877;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+vKsbcoleOYuc4PiNiO5dWwOmRc3lrgxALbS5CidGo=;
 b=w7v1nxvOTZyXVG7V8vPV+qXyu5ixvCazcWI9t/A8qkKz3rlA7LILy/ykl3FKN8hhFe
 kk0ay7/08qvsS0DWxcn+LZr1OnaLexvNMjmsoq4PwNV6FU/Q6sil+H5ScwTIAAYQvHAt
 iVWus6dYtVxDz26HUEhg6xFTjLiT++RmmMDy5kj5J2SmSVls4HIYOYMCJ++S33HIZWP8
 Wdgr41qik/1c5XIiYh3Nuw34ni2OkpF2U3n69PLAy7HkThxWyoJDWy6bmh530igdEkLU
 dRdsuuACsklFxlqFEZp5TpdxLMX/I2R4dthniyEDTy5LZuujf68x3CL15eh6D8aHNn7R
 steA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXfGfxsHPsgSy0pmRB2U+6Ho/zsioDiUjD5AvBvSVPJiAQmoa5uZuX0fq0c2IC0d0EgTMhP1uxd3wGXwKCNckPxRLpeR0=
X-Gm-Message-State: AOJu0Yz2B6yFttwEXdCyi9YNbxk2EVhbYdDILLzHhkrrbGl0GFLM0Pc+
 00mdmlRY4X/tL86UweGZWuImQjSLD0AvJg41DiXEkCWhZ6UEF5Ad
X-Google-Smtp-Source: AGHT+IEwmKEH6z/CY/zIgNlLA9Tqlm97IGgsC1LzdRAHBxjg+uYHjMfMy9KfPk/JYB97Guk40ReDew==
X-Received: by 2002:a05:6358:50cc:b0:19f:45ca:c1cb with SMTP id
 e5c5f4694b2df-19f45cac9a8mr768851455d.7.1718044076662; 
 Mon, 10 Jun 2024 11:27:56 -0700 (PDT)
Received: from octofox.metropolis ([2601:646:a200:bbd0:3ffd:29c9:236f:9968])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6f5e09e5261sm120053a12.19.2024.06.10.11.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 11:27:56 -0700 (PDT)
Date: Mon, 10 Jun 2024 11:27:11 -0700
From: Max Filippov <jcmvbkbc@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v3 2/5] target/xtensa: Restrict semihosting to TCG
Message-ID: <ZmdFfyzwWs_YREPx@octofox.metropolis>
References: <20240610145808.2267-1-philmd@linaro.org>
 <20240610145808.2267-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610145808.2267-3-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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

On Mon, Jun 10, 2024 at 04:58:04PM +0200, Philippe Mathieu-Daudé wrote:
> The semihosting feature depends on TCG (due to the probe_access
> API access). Although TCG is the single accelerator currently
> available for the xtensa target, use the Kconfig "imply" directive
> which is more correct (if we were to support a different accel).
> 
> Reported-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/xtensa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

