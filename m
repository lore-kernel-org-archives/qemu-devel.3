Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0660C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkodz-0002y5-1h; Thu, 14 Mar 2024 13:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkodx-0002x9-PD
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:13:25 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkodw-0006BM-6l
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:13:25 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-568a19fcc4eso908183a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710436401; x=1711041201; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OqQBtrihkj/R+Xi0gP+XQSu/qnSWcolA39Qgx4tgN2Y=;
 b=KsF00Pc2+lhY55yusX34krjSQ7BWtmbR+zhAXYt0/wIYUd0xjKBbcmMK3TYPPSO01a
 qY8xaVb3F72I+Ncsl06Cj+SQE4FWDmhoZX3758QxVXHJ6MIvQaIC4cQjPN7KvaXhFGwO
 iInII7dFCTM6iedy8RRNhJGOBDLIw2rNskaO9QAlXwNJZJ1+TuG9OjyF+4MgD6DSMd0U
 riA/9uBJ/+QQ/b5DNSyMpt+cYSZ0emYOfGJjhGJJOG7x+tPcb7cCH04RBEJBWisAzaUn
 jKi/xOPI3vPwfrD7im0yzQkCPvU/KtLTF9EoopRheOWoWkbjk7iSbcuoLaIlQvPrE1AS
 aTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710436401; x=1711041201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqQBtrihkj/R+Xi0gP+XQSu/qnSWcolA39Qgx4tgN2Y=;
 b=Zrc+OJ2WYQpfz8RanFrXIOAh218/VFB6yHEzE7S9ScoVDswEHvHHOPXieyRm4jJd5o
 3YkOV4lGvEA21Haxk4pHoHzFgWQ86+uVYQuj8BSgJs2kMfkMIzPhU0yUCIJ0+VxkwDsd
 Z77AsS6E4GylQhUJKqyhqc+COQx7GJrCWLq6rHHVUa0PeegR9M32ck0DW6UVCeesgldu
 T+j9Xl3cMYGSSqWsQ5l/7f+OhCFP3qROmbz6nRfUJxHGlPr/qNy6gEmXAN2/Iftu8GWe
 EUeox1wLL57g2Q+paxHl9UcosEgJEGQmDgP6nih4MOXSNB7JN8zTyRJ3IqKOelVSIAC1
 4PNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg6C7+vvTf/wCfmbe6+lrA6cb9YArOS8gIFkXQR3DREucIspZ/2cq49IpmQbIzaxX1aGmNQlVNtGQgLGpeh+jOCDvCYQE=
X-Gm-Message-State: AOJu0YyJxbt9StBcjjsthuhmKARlHUf8rX5joAe0+aRFizf+yZ+1Dmpw
 OsxIQLvFoz3EKUPJ0EZ+ySDr2uyAzvesa2vR6l29usfGlUlPV7KwEG8vyMBO41s=
X-Google-Smtp-Source: AGHT+IF9wPWs1eq2zEUM4xKPza7RI9IR8AudHHXJzVVQc52o4Zydgdg4vbZ4PC4Ue4UVjbY+AsoMZA==
X-Received: by 2002:a05:6402:1513:b0:565:7ce5:abdb with SMTP id
 f19-20020a056402151300b005657ce5abdbmr906090edw.10.1710436401190; 
 Thu, 14 Mar 2024 10:13:21 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05640214cc00b00568a22038b4sm649547edx.88.2024.03.14.10.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:13:20 -0700 (PDT)
Date: Thu, 14 Mar 2024 18:13:19 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 3/3] target/riscv: Enable sdtrig for Ventana's Veyron
 CPUs
Message-ID: <20240314-00815f922c7320ceca28398b@orel>
References: <20240314113510.477862-1-hchauhan@ventanamicro.com>
 <20240314113510.477862-4-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314113510.477862-4-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 14, 2024 at 05:05:10PM +0530, Himanshu Chauhan wrote:
> Ventana's Veyron CPUs support sdtrig ISA extension. By default, enable
> the sdtrig extension and disable the debug property for these CPUs.

The commit message needs to be updated to remove the 'and disable the
debug property'.

> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 66c91fffd6..3c7ad1c903 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -569,6 +569,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
>      cpu->cfg.cbom_blocksize = 64;
>      cpu->cfg.cboz_blocksize = 64;
>      cpu->cfg.ext_zicboz = true;
> +    cpu->cfg.ext_sdtrig = true;
>      cpu->cfg.ext_smaia = true;
>      cpu->cfg.ext_ssaia = true;
>      cpu->cfg.ext_sscofpmf = true;
> -- 
> 2.34.1
>

Thanks,
drew

