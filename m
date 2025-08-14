Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE9BCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umYEV-00022u-Az; Thu, 14 Aug 2025 09:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umYET-000224-Up
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:43:05 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umYES-0003lJ-2Z
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:43:05 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e931cc09dd0so953886276.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755178982; x=1755783782; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMNOg1SLD7diA9u08byvth+NkQBp5w8d/N2urYdNriY=;
 b=vZ/TCM6OIKFqqG8mXTOaxhYf1JNUOfgbS/BguOaH1VQuMguu3UIxKK514E4LMZ9STf
 wCgGB6NSuGfoKpxn+9/Ol2tP6jxZ9NA4qyM0V5tAnivK0IypBJvfFLZkAx245Q9vQYyL
 CFAlAF1+A/0XdxwX3AYCG1VCgb+/PcKUfqhCvFHFT/QOl0OYMVpNLEzn6kGnFvJSUegi
 YkxYMUWKdxYU4DmAWImfYfdyfq7grt88wlK2rMYuWglCFuzKLQtLGvBKGa/GRUvYVONA
 x/cpFE4N5XVFftrjOYv/0EeLkn5srQBuFbZnIzosQQT2WuzX9h213Dv3xereT8tnaPL3
 jsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755178982; x=1755783782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HMNOg1SLD7diA9u08byvth+NkQBp5w8d/N2urYdNriY=;
 b=ELOH47G2zTVwY6NmfzL+gWm0iYDgll9fcnr2UdtLWbWvg9sakSNZJ0GLmePR1MJP2A
 IAYal3Azt01iBLCw14HvhPr2Oviu4e+iboBxoGHakh4LWfQ/3t+MfAwfOUoV8zc1Bkfz
 so6V/W3xuXeJTE7NPgNvhhSvGlJV5q5SzvWZLeJl9YBdAbelcXVWEGDSoRSb/Q4LLxIV
 13tjSFPImwLS4bq/nNS7D6miM4GPMzdCS3EDRyQhlfeKoybwVC2E5WF/BYTk2Djcj9SJ
 0mjs77koUWhKzuF4FA62VGlDbLIkE6fUzZiSA9ythb9csNioV0WkLeOEawOlxkwjkcwp
 kK1w==
X-Gm-Message-State: AOJu0YxivgyJmLPuWfYlG92jo/72bFSw1E0TnZ2V/NK1eNBBOV0e1YXP
 FdSXQMF7oC+PLMSyipUlGeUbr4dcAFgLB2VN3VUY1sc4WaVKNVnz3S9FwcbYxWAr3tl6ia0uIn0
 KDzKWhmD54e1j/A1OeOtc/FtiqcZ4sbqBSCMwhSVwIw==
X-Gm-Gg: ASbGncu2zabChFVtArnhH9jSHC62u6iMbbcr6arhJiMUCx/TQ7wpkDbtDKNtXNRtrya
 rrHbxkr7G1bZ54RkFhl+rT5XoIhujmntM7TZV+OlbGmIUpyBt8rWrM4g267XL6aNa3/GK7wqdML
 YcUA6WAMb/jyBr/aH24oIKnaE9roTYhRQ7CASGeBBMEcxjzh61SorAnQxf5ith2rfACXHGLhY5y
 d86Mofx
X-Google-Smtp-Source: AGHT+IFXUn6mO+CyqXSPxaT3L5nuqo1DDeIg/Wd25Yy9HT792PEMk2ymxa5MztJ9w+HW88erijvvAW+d0wt04o7JSqg=
X-Received: by 2002:a05:6902:124b:b0:e90:6ea3:1e0f with SMTP id
 3f1490d57ef6-e931e14cc6fmr3856417276.7.1755178981276; Thu, 14 Aug 2025
 06:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250814070650.78657-1-philmd@linaro.org>
In-Reply-To: <20250814070650.78657-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Aug 2025 14:42:49 +0100
X-Gm-Features: Ac12FXxRMIgxaezeWzacIbP88V9KdSvswihqUB4XMnklT9kCNUkvKylYZ4x-5v0
Message-ID: <CAFEAcA9Htm9sRpxGCD_Dye=vxtXvR4tW-SmOedR4b5aCMEExwQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.1? 0/3] linux-user: Select default CPUs for
 MicroMIPS and MIPS16e ASEs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Thu, 14 Aug 2025 at 08:07, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We weren't parsing MIPS ASE in the ELF header, so couldn't
> automatically pick an appropriate CPU.
>
> Since we'll have a rc4, I propose these sensible patches
> for 10.1, but both ASEs are available since 15 years in QEMU,
> so this isn't something broken since the latest release, and
> I don't mind holding it for 10.2.

If this is a long-standing bug then I think it's best
held for 10.2.

thanks
-- PMM

