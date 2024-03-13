Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFF0C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLJv-00064Q-Dc; Wed, 13 Mar 2024 05:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkLJu-000643-G7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:54:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkLJs-0003lT-TO
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:54:46 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5684073ab38so1274421a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710323683; x=1710928483; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I3bOMZQ9BOPzzEgW12MeEnwoVuMCFQn4wljIhDg4nwk=;
 b=DtUCCp7201GD5oHWzotZKy8UV0/jsqwNuISms1QUi1fv3cNfRK2HxUIR+79+QmBZ50
 AT2VF4DhFoYtDHYmMyeJRNR2fbe800Y4Rr6qUT92inEGtcQ8vVAe+yufNQjvhwgmX4x/
 WTCU40OZ135Cz2v6zrq+FlHkY1oALTe2RRP23IL8dZEZXbtvTyWbTcFUQj7XI+L/zw7Z
 oSbq8+WH4Rq6UlBAG7l+bdNqnvDDy0nfa47O4e0Mcb7PCvH6YjRsVhRdX2alu5bqIUJU
 nqiccd6WUEybtSkbzem5zHSZBq3526hdTodcKLtp1BaO353v5vYomfaLD+Ulf3ZzxPRv
 G/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710323683; x=1710928483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3bOMZQ9BOPzzEgW12MeEnwoVuMCFQn4wljIhDg4nwk=;
 b=bHEq7eU4Avqek3Vx9RqHcmTqKt6/qm3EVinAlF1Mgs1zsQdeHW0g3eq1AOXbCqYF9p
 3gT5e/7PTEZAU3BAg5twp5sU56Krzb8WMcbV4upfq8NrL9K7E4l/6gIB1241dMKWxjhd
 NCzns3ZLIxFOmiQiv4PSWvvBt2+qRizMjKM+M+j1UYosqpxbVf8YshOxVC3LTbaZwOqe
 sZCzpUYWKAA4xhZk3sl/eNYvYnzBMrEq7Fm/Obq/cOOvv3/lGNAsjzg9BoBttn2A4YSh
 Zh1JUpOsxPQ/b6L6/L3XLfZ2wE45O0i/gTmJmRfkJFceMO3veEdpyuTT3IYLHnyj1Qj1
 P8hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm4hwrck6ZrQ5D16XggCnQIVvNmoRdQC0q5FlY/Vw1VtrwzOnhlZRXL9aZFFHgqErktpXsosnZ091Go2k+J6eOrmNxhn0=
X-Gm-Message-State: AOJu0Yw2YEejB+v1ntVS4hNKoNA2S+wq8bzxA1BWWYXEHTBmEGfG1qJS
 f1su+sXCA0wC89Wl0+l/2MVzyX4mezGzxixyV2dxvQPyyzfzuzuPwBh1XFcb0Rc=
X-Google-Smtp-Source: AGHT+IGt0jjWH6xA/C4mbEWoKDPY3DWoS+ftRWBf+pSgH9ZBD0d8abQRp72SG7eVCzA7lvuhcFYBTw==
X-Received: by 2002:a50:9983:0:b0:566:902e:65e4 with SMTP id
 m3-20020a509983000000b00566902e65e4mr2174552edb.18.1710323683162; 
 Wed, 13 Mar 2024 02:54:43 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 ev19-20020a056402541300b0056742460f68sm4759563edb.66.2024.03.13.02.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 02:54:42 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:54:41 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/3] target/riscv: Expose sdtrig ISA extension
Message-ID: <20240313-0ac597594e930a42685aeba5@orel>
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
 <20240313060931.242161-3-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313060931.242161-3-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x530.google.com
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

On Wed, Mar 13, 2024 at 11:39:30AM +0530, Himanshu Chauhan wrote:
> This patch adds "sdtrig" in the ISA string when sdtrig extension is enabled.
> The sdtrig extension may or may not be implemented in a system. Therefore, the
>            -cpu rv64,sdtrig=<true/false>
> option can be used to dynamically turn sdtrig extension on or off.
> 
> Since, the sdtrig ISA extension is a superset of debug specification, disable
> the debug property when sdtrig is enabled. A warning is printed when this is
> done.
> 
> By default, the sdtrig extension is disabled and debug property enabled as usual.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2602aae9f5..ab057a0926 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> @@ -1008,6 +1009,12 @@ static void riscv_cpu_reset_hold(Object *obj)
>      set_default_nan_mode(1, &env->fp_status);
>  
>  #ifndef CONFIG_USER_ONLY
> +    if (cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
> +	    warn_report("Disabling debug property since sdtrig ISA extension "
> +			"is enabled");
> +	    cpu->cfg.debug = 0;

If sdtrig is a superset of debug, then why do we need to disable debug?

Thanks,
drew

> +    }
> +
>      if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
>          riscv_trigger_reset_hold(env);
>      }
> @@ -1480,6 +1487,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
>      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>  
> +    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, false),
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> -- 
> 2.34.1
> 
> 

