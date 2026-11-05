Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EADE606A331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RD4mFNvm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzy2-0006fh-3d; Thu, 05 Nov 2026 11:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOzxu-0006aE-9V
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:05:28 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOzxo-00055R-2K
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:05:22 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so1867894f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793894716; x=1794499516; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MTD+YMdenV8nPVPhjGdFh71FJfRNuOqVrF2HphRsq1A=;
 b=RD4mFNvmXDn/0vC3IMlVWZ4VJsDK3SnGbmCoQbYMNrBlfBHCj2ZYmP/UU+We2Jw6TO
 Mm2rIk5j4qhEvtNQqrAOOc3hXW3Pf52LSWLkPBdfFsMipNLBL8K881a4EYYnXpYUtzMN
 e/5XztZBA7LzttlFGdmbS5FxVQrT1BVAfIPXbZDr163lzR1lMpfZ8tyCDOkO+QfvFLeu
 43YjXpcPtVj1DNzbhxEX7li6dzlfkojhRvo0u65wt+Wkkzad2rplLQ8tbUGufr+3xvPX
 TuCJO6roOdoILgNoDKfeP+new9B1PEDL8QCd7JZgyKuRw7jbyTvZ1VcS0/kb5sM3Ahbp
 TZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894716; x=1794499516;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MTD+YMdenV8nPVPhjGdFh71FJfRNuOqVrF2HphRsq1A=;
 b=voUC50aLLd54Ysrhlleu55gu6Mu6gseYCsCIJTLJ5Fo1yvUgmNvedQXAv/ChmRaymS
 Gsp4kHhemCB3OGpFA6MYKMyFUYmCcTkk/6hISPO3T5S3q3D7yo+1nxZtNeJYJaAWBGsc
 x9sVreTDsdglPIYBKsMZv2uQ2gnxgg/oU1srGGhJWJHh7y7KniP9j6LaX6ftQNngo0/K
 xCDdE6S3r0dnN7f2/3noFyiEw9Blo+1C0vbRFICSmLrFPnOh5ELKVFR7K/+o6dwH4UcG
 a5zbTOUc5hxKBgJ90aE2HJSGMrNdlVwNt2dACFrssFE2eiftBUG/9CdLsrSC5Ph0pVp4
 MxPA==
X-Gm-Message-State: APuU4Z/ECgFvECEc9VuwUmaNcy/bQc6E1VORyM7rkYD2ZTcdjinCZU9y
 x/urfa/wcXSWqsKz75dZNCMPWd3hwwP7QSuFhCJhokySSvutlZxLUSI8v3wEJJ5c5gQ=
X-Gm-Gg: AYBFou1fmODuUZPqN0NMpuaIQqcWHdqWiqhiUhyESFGzRM91SX0tTBEGwrDJrhCySJc
 WFcRXStmeod9OaY51hDDRVFJDmXsdYSb1w6b206PQyfseIneZL1Qq7y0WywgF+BwcJJdXKA0w4e
 imoG7Ip4fjyBjQG/xJw2BM/uMoURd2IatNSCDyKBBvwWcxCwds+US/cqOl4w2Udv6rFvzuUOIX+
 Tycj2khu2BHC+QELtWF9O/a1GTclZGmT+KK92jdQIBws1OTWDgRUapr75mn33miJIKSRdIGDzmY
 egnVWMya3g0b1BpJSPIpXmsTlErfTVVMVu2+xWk4+y4IAeXKmriVwa538RUC7J8T8eIjGjKMXro
 fixVKMVqkNjrj+17cD+TM/74FL8y2jNbVWtUpsx2EfE9lqp4IteqBxSjusAN8R9qZVSx3XpGdVo
 ty36lnr7zA9Veplq++/RHNvFzJJglDgMUv8WlD9VItLiC2AgUra4zAaf69chdI8iUKhjgrfDDts
 mJrpWGXct1EofYNc+e2QJcxh9Dx6ymzNEjnPKpgnCT+6pXHm2xn9+hxw+leDSS02otfvum8knaK
 p1YiR4zfynoPpnu0frwySkd2ORp1
X-Received: by 2002:a05:6000:2901:b0:48b:59f:db9c with SMTP id
 ffacd0b85a97d-492775f03ddmr79582f8f.53.1793894716357; 
 Thu, 05 Nov 2026 08:05:16 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d8734sm11354531f8f.20.2026.11.05.08.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:05:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B41E25F8AF;
 Thu, 05 Nov 2026 16:05:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,  Palmer Dabbelt <palmer@dabbelt.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>
Subject: Re: [PATCH v2 07/17] hw/riscv/platform-ref: Replace deprecated
 sprintf with g_strdup_printf
In-Reply-To: <20261105125203.40320-8-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Nov 2026 13:51:52
 +0100")
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-8-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Thu, 05 Nov 2026 16:05:14 +0000
Message-ID: <878q376z7p.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Replace sprintf() by safer g_strdup_printf() to format the AIA
> guest count / description, silencing -Wdeprecated-declarations
> produced by Apple clang 17.0.0.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

