Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D405DCA0FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 14:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk2FB-0002uy-Na; Fri, 30 Aug 2024 10:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sk2FA-0002p0-7B
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:04:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sk2F8-0007z5-6R
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:04:51 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7140ff4b1e9so1587741b3a.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725026686; x=1725631486; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xJrx9QWXg1ANvWnGO6gKRxZ3uy13OXLpCsnUzIBPTTE=;
 b=mEdNWMo4nCW6jxo1iBHGO5bCwhyQCY/bDk4Xxvjr1qLwxsTq99gEe9gHSFGCOjooRE
 fFvVx+uJQzihMGN0aK2+VpXAZHHJ5TONfTnBe3X76ip4l/eQxcE13oZvzznbX83dfM0X
 J2QVGta/Q7hjzN1N3l0SirpTADCmVT+tMqttoaQpMBKwVImoNmdY0FQfjdgxT1OmOxMe
 0tQHdwodcE/wjau0qeAfNN9v85DT4AmWO26V0pkDQ7JuGBgTDgFswQkSL6wGwPpewl0m
 +7GZsSVEEcEPPaQd81nWhVTyzdqJV4XJEHffwwGxYivmV5VSBAzlyNk/WwWN+Ceq+fRO
 kf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725026686; x=1725631486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJrx9QWXg1ANvWnGO6gKRxZ3uy13OXLpCsnUzIBPTTE=;
 b=sg4THNluoW9dJS3oRwh6tU5rWwt0y4J1lkRuNGS0Eu00Prux/Mmv7i7qCsXHHz6QHQ
 hCVU860LNDbgSdz/cBG+jPR7K2yEAHPQjPX8iGiGTMq/GSY/C7abQgwyFq6UMLnB+R1k
 TXJHMg5ouZ/Sta6UJcLIayvUDfU9lVNNUicmp1IQTuigUyGORL5H5boFYGHFcHBA8EXL
 BDp5C8mi2zlH9Rtz2aNJH1sMtJjB1vr1PaFlVoqwcOaVirNPpeUMZzaXKhqtXpLeqbEn
 oOElqGcnA1PudgRPTxVsyY8jyl33prKLp7DmghQSfi0UKpDI+Og7tPVnMSY9hrqYBy1l
 WDlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl62eXqDuxp5jlWTCZAbKNqvB4JDlE4zK/u55kt1LlbVtZ3IyDX4KEyL5jIxJ16p4D6nVn1/VveCzq@nongnu.org
X-Gm-Message-State: AOJu0YxxA5YKh1Roz1mhVa3jpR4yiIaw2QqbYSfGV/WdKPyuxl7EuG5z
 Mq4W+zNtty5taZIfjMEor2YRtmaw2GC8dLBVSaZ9li7yUV9Cv7yLjI+93RmrmV8=
X-Google-Smtp-Source: AGHT+IGiZFczloh/pUVT36WstF8OiafQ5VTDTjqT5ue9yPZPEgH2yob1ZQz8SP6hPIX9fOPoHJ7Ytw==
X-Received: by 2002:a05:6a21:114d:b0:1c2:8d72:67ce with SMTP id
 adf61e73a8af0-1cce100eb8amr5749393637.15.1725026686336; 
 Fri, 30 Aug 2024 07:04:46 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715edc66743sm1770906b3a.152.2024.08.30.07.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:04:45 -0700 (PDT)
Date: Fri, 30 Aug 2024 19:34:37 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v5 3/3] tests/qtest/bios-tables-test: Update virt SPCR
 golden reference for RISC-V
Message-ID: <ZtHRdVVXDcHkvHBY@sunil-laptop>
References: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
 <20240829015920.95778-4-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829015920.95778-4-jeeheng.sia@starfivetech.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42d.google.com
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

On Wed, Aug 28, 2024 at 06:59:20PM -0700, Sia Jee Heng wrote:
> Update the virt SPCR golden reference file for RISC-V to accommodate the
> SPCR Table revision 4 [1], utilizing the iasl binary compiled from the
> latest ACPICA repository. The SPCR table has been modified to
> adhere to the revision 4 format [2].
> 
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
> 
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks!

