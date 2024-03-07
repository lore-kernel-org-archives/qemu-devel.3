Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88A6C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 21:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riKqp-0007xG-TF; Thu, 07 Mar 2024 16:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1riKqU-0007vQ-Ki; Thu, 07 Mar 2024 16:00:08 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1riKqS-0007aS-S2; Thu, 07 Mar 2024 16:00:06 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56694fdec74so1442538a12.1; 
 Thu, 07 Mar 2024 13:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709845202; x=1710450002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2hznLN7wg6hIpGibeVONc8fM+6iEbAFhiBfEOBTrMY=;
 b=GVIjfxzcDXUSXuAXgq9kdD9fwejBfKvLIJsvvQqdVysZQUXq5e+pMwFX5Rd+k3oU+j
 WquZedHJ+s/RSkI4ZPhl6Aou7MIiCS9gvAHSAXRRJnKZcx86XnXTgOJfhtJ2sC7PgMvw
 YFey1ehigbEm72gIgi5jncWDCYxRCpQ7m/WkzydEQOXIESm+vETPK4viqJtnOny+y9NU
 FsxfDnVqN0zaXRWGBOgA4QMsreER7aPW/oLFs/g2JmStqZAKACLG7r1ypTLv61HvhdMr
 TH5Y2VKEd7om2+5NWaFRnIyC8t8yi02Bnfc62J1QxnxBO9I1Et2KKRY8AC8qqtbMGf4K
 gqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709845202; x=1710450002;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f2hznLN7wg6hIpGibeVONc8fM+6iEbAFhiBfEOBTrMY=;
 b=uqM3ZLZFny2OdWQTR2sAdwSGBbA3IiMxZL2EGrro38KrpDyjm11ee3tkBf2Y2jAfSV
 8QmyIcw5ly2nM1DR1kKZ4l/t/6zeS4381RTrXwDuHUoI51TffvHElsIIpoEfAAzogVxo
 UvRlaGECn6mhXi15a/PZ/6MoHgl7YwRgQ+yIpNMKNzqnpT09a3HN7dWVSjY1xs/v0VtA
 LNDBrK/DJ4WItgmeTYFBnkw/sTR4ZQn07GD+NBUW/j7miEBLmxhDX16LUJDNxg7ZXepb
 SNmDCv/VawBdLJqSuvnTk/Zh+PRjfUMkU5VO6q0RA01+bjHQiLm3baVrCjLSaGEodH41
 oR6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSJFca9BwkYwdv1c0d6SUWOnNMi+GJZfCDJlw55JJpDJAniwEGr/hokZbFYNVzlaAUunZtzkL+AtGwwvEquDkNUrMkgGsojNSXhtz/1PMOnU62aSUwEoKsp26N2xBj
X-Gm-Message-State: AOJu0YwVfSBpgEChVzu+Zo3omQxjkWAekcCTT/qivXAY1FqPOuV+U0ED
 ea3sylGXHpui9HxOSFKFlJC9/d4qD9GMNsIhL1QLk0P79sLB3MOY
X-Google-Smtp-Source: AGHT+IEYzSbJnlKPzB+KmYMTS5h8ijVBJhYgTXAxmCCJoWk5mprlJA7BLVZMMZt0sHgoawkl2Ek3Xw==
X-Received: by 2002:a17:906:f28c:b0:a45:80a2:9748 with SMTP id
 gu12-20020a170906f28c00b00a4580a29748mr7690483ejb.34.1709845200682; 
 Thu, 07 Mar 2024 13:00:00 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-055-016-169.78.55.pool.telefonica.de.
 [78.55.16.169]) by smtp.gmail.com with ESMTPSA id
 m19-20020a17090607d300b00a45cabd9b5asm1219298ejc.111.2024.03.07.13.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 13:00:00 -0800 (PST)
Date: Thu, 07 Mar 2024 18:57:54 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Subject: Re: [PATCH 0/4] hw/i386/pc: Trivial cleanups
In-Reply-To: <20240301185936.95175-1-philmd@linaro.org>
References: <20240301185936.95175-1-philmd@linaro.org>
Message-ID: <2062822B-3D5E-4D17-A913-0036249CFB50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 1=2E M=C3=A4rz 2024 18:59:32 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>Trivial cleanups, mostly around the 'isapc' machine=2E
>
>Philippe Mathieu-Daud=C3=A9 (4):
>  hw/i386/pc: Remove pc_compat_1_4=2E=2E1=2E7[] left over declarations
>  hw/i386/pc: Use generated NotifyVmexitOption_str()
>  hw/i386/pc: Remove 'host_type' argument from pc_init1()
>  hw/i386/pc: Have pc_init_isa() pass a NULL pci_type argument

Ping=2E Will this series make it into 9=2E0? AFAICS all patches are review=
ed=2E

>
> include/hw/i386/pc=2Eh | 12 ------------
> hw/i386/pc_piix=2Ec    | 18 ++++++------------
> 2 files changed, 6 insertions(+), 24 deletions(-)
>

