Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF5AEE2084
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 11:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJsa-0006ER-1U; Fri, 06 Feb 2026 06:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1voJsY-0006Ax-SU
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:20:02 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1voJsX-0007BC-9e
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:20:02 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso20951415e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 03:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770376799; x=1770981599; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mkIepJWCSHN7CrnzujNI6zzuDf3eZJ9AMeeaeFEp6rM=;
 b=aVRfhk8ipY7JH6m/nv/uanRQmEvQJae087r6Uga2GaWRWWOL9BE4xQPUE8LCCxXSsq
 0oIeOUqq9fPwu8sHL8uaP9NiayfRmJAN7zTsQdW6Ngm5JiruOXZ5udWIsK4czq7Cs6HD
 zrbPZm6MvnwxwKsW7ZYBlvQLm5/kP5FUKX0m2lNRh6NHm/8XnW7jyPQldIRbSmtc+L2B
 K8hD2nLpPNe8BY5HjaK/eLsqYXqEApuBpjCnGCi5Rov25ZytVcGsaEqHTE/S86cuTGQc
 AU1zjfTfuS6Yok18Bov0LtAf9gmXaNjTWh16Pn/umpVVujD74T3TUi5Mj+7Xr/K1PnT6
 EWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770376800; x=1770981600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkIepJWCSHN7CrnzujNI6zzuDf3eZJ9AMeeaeFEp6rM=;
 b=AxtGmWQ3LhkNtazh/8KCzo4ONIi9QKPd1/sJKT2W5kt+LEht+qeVCucyP/KDliS5KN
 2jm4bF/piC7oUsTSkXAZfyJONAgDrfUlbhBXgJ320ZdL1e486uxHpNR8b6Ps1HS5R53w
 Jp1CiGH1CQn98NmKBnb/eLoUJwQF1GmL5GH5yiou2Pt3BZ8NaHTdekRqjD6o9tB8UZG6
 l/DNn2HDly5Ba74jwiwILVwJs0Xv8Sj8H+ZCrCwqLqw/e9zVcn8bsBOf6AzQcawM7JES
 /XaJxlXZOkdGbZIhftouZ25FEPt+mTPJ5omjqgwlsTd8XH8XNlSZMWZKrMSMfcQZvtkK
 Dhkw==
X-Gm-Message-State: AOJu0YxsRoTcpn9bgumpFucSoCO8pTo68dbNYsgvUu90lllMT70pcglJ
 ixNRlc1zGC8ewn/HDxqi/G+8E2EVVd8+3rYPbXv69WyfJaGtCkJOXvS7
X-Gm-Gg: AZuq6aJB0gHtSCa3cI9uXOiB2ZPAcMjX/6fTe3ZyL/q2ZCbKkv52lah8pELMAix6xAR
 K6Fl+jQpiHfdCJgtP01eYTyZnBLsEz9xlUq0TBQa0V0hSK0rTafhhGNwRcy9hCzkdkNDdYGINhW
 btSOZ8wnSKgyV2iBs3hyHP3mMu3hf9JeyZ9nEVvmgGe7tsMR/1LO717nmxuEMyKTdgx9hczOeYr
 9AEWtpbreDPo0gUIG06Zjl5lI58uifSJq66AqrWFp9KWNM55fSC/3gGmoX9BHG6ZDc9UMBzVDOz
 bC0auZ17k7EK+VVpEmkq8KGyiHaMg50LpD67zdIm6To4/tVxRL9FTHlEdENwD7NwmYNxcwgi9t2
 YzkicU1ftB8SIw2lF72vZ+8/Vrva9WhM5cpMIbxZdHCvm9RH6DxEMyIVOj5De/kn+gliX7xYBdz
 y26TO4CYGbYt9+/gL2J1vebLjm3FQc8itbQ+y+DMx7M6Lyx8ovxxWsv/uVidV8F8ALuV69NsEwy
 x4=
X-Received: by 2002:a05:600c:3553:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-483201dc49emr34190975e9.1.1770376799416; 
 Fri, 06 Feb 2026 03:19:59 -0800 (PST)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483179dbdcfsm152971665e9.0.2026.02.06.03.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 03:19:58 -0800 (PST)
Date: Fri, 6 Feb 2026 11:19:58 +0000
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org
Subject: Re: [PATCH 6/6] hw/or1k: Rename or1k-sim.c from openrisc_sim.c
Message-ID: <aYXOXtxnnlu1Y52c@antec>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
 <20260205030244.266447-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205030244.266447-7-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x329.google.com
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

Hello,

On Thu, Feb 05, 2026 at 01:02:44PM +1000, Richard Henderson wrote:
> Match the filename to the machine type: or1k-sim.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  hw/or1k/{openrisc_sim.c => or1k-sim.c} | 0
>  MAINTAINERS                            | 2 +-
>  hw/or1k/meson.build                    | 2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename hw/or1k/{openrisc_sim.c => or1k-sim.c} (100%)
> 
> diff --git a/hw/or1k/openrisc_sim.c b/hw/or1k/or1k-sim.c
> similarity index 100%
> rename from hw/or1k/openrisc_sim.c
> rename to hw/or1k/or1k-sim.c
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b739cd59b1..e6c70b2b1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1493,7 +1493,7 @@ M: Jia Liu <proljc@gmail.com>
>  S: Maintained
>  F: docs/system/or1k/or1k-sim.rst
>  F: hw/intc/ompic.c
> -F: hw/or1k/openrisc_sim.c
> +F: hw/or1k/or1k-sim.c
>  F: tests/functional/or1k/test_sim.py
>  
>  PowerPC Machines
> diff --git a/hw/or1k/meson.build b/hw/or1k/meson.build
> index 49c274b848..a5c23f4f5a 100644
> --- a/hw/or1k/meson.build
> +++ b/hw/or1k/meson.build
> @@ -1,7 +1,7 @@
>  openrisc_ss = ss.source_set()
>  openrisc_ss.add(files('cputimer.c'))
>  openrisc_ss.add(files('boot.c'))
> -openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('openrisc_sim.c'))
> +openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('or1k-sim.c'))
>  openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: files('virt.c'))
>  
>  hw_arch += {'or1k': openrisc_ss}
> -- 
> 2.43.0
> 

