Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D53CC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFEp-0001Nx-W7; Thu, 19 Jun 2025 09:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1uSFEm-0001NJ-CJ
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:23:28 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1uSFEk-0006Lg-Rz
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:23:28 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3de1875bfd4so2726315ab.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750339404; x=1750944204; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z81gzf00YTkY/fBeXVt0/DuwssyllLL3hRkGPpJeRNY=;
 b=YcpsWbhIM11d6ULk45O43ea9tyw8N97r/JEtXcOKO7/7Mk4GXMItT+a/luUklLVq7G
 GOu/MnTdRy5aMARuSL56JaGBxQLFvXruVbFbbW6+h7UKUsGomR/Fj2ReFx5CuXlzUiD3
 fU+0jNcMV8Bow21OY2YoJ5a7v3ug55ezrSjZUloeuASxip7ybKmIGN0+Xip1rZob1A5n
 EZ52tnR0Yu7dqkeUGE8FdyLUy1Y/bHNmjab93SgU2us1nEeYJrDII0TyDSwbJajpWcIC
 W/fRjWqmn4yn13cXoXXccVcVo2sxPnBDJ85xpNu7XgTY9oHOKUoLyLXVPGrv++JO4vzJ
 hO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750339404; x=1750944204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z81gzf00YTkY/fBeXVt0/DuwssyllLL3hRkGPpJeRNY=;
 b=YzKJFtEaXvSGBnS+E2qUpZ01vud+rcSOC6CJSHByLYZWbc4pkqTUCfmFCLk0QK+BT4
 AlcmyRjJjJArAwfC0F7cHuZqyazsunHFYpiDsnhqkzqkqIJmGxTZWC284P3qfCFk4Brt
 SCfK4i1IR7JMdq026YKVWieyF4ONvev+C23k3WOIH4HmXzh06lauTlQfW0D8BgN7uHzQ
 83dIRDDIJeCUzp5GohPsQf3+LdxeBq4cuQgNA0gh4dqQB5IF753Tza3zozUWuiOpOUCy
 xBOIE24//XkCwKLanvJzBZaEL3AvlsxAQyUcznegJgur+6p52GBtGxwVUeAEz8u0krEa
 pzew==
X-Gm-Message-State: AOJu0Yy2Rdd4jMm9FtJO56YV5p7vJ1/Nh2FGgUq2kwVqTikoRCF8JSB3
 yJxCEEoQYtOVuCRt8keNBshxb9886kXF/yn6YgDB2TLtt9NsQoTWzStO00KyJfeEDaGG25vAN2a
 asq1a61XpZ60VYJ3/DYNWCiSuQBJonfX8yBNbSWYHH9xmbVsOkux87eDd2Q==
X-Gm-Gg: ASbGncvEZT7ix06UC8+Bcxt/uAt1BVW/kDw7gRStuIeIMeEK3D/bG8E2a4+XxfcUqkF
 pQnMOUv9MIVqdy6SpuMrMp7X+xLFMoYUxr6nti0IO6SqwuySChZMprg38bf1NTVdZ+q2lPL3JoT
 E/braA+ymL3q3FUOMRpyGLeJuheV9ZkIlTgnOm/meBzIw=
X-Google-Smtp-Source: AGHT+IHQux5BONbs+biKWvdH17zMCmnmXk/I0BfEe5F7pA7ZT7bha/W1MD5B0EJhN7nBoWpSXTZ2SAgZoBHpYqMNd34=
X-Received: by 2002:a05:6e02:3304:b0:3dd:cc4f:d85a with SMTP id
 e9e14a558f8ab-3de07d12d0bmr241002825ab.6.1750339404384; Thu, 19 Jun 2025
 06:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-21-philmd@linaro.org>
In-Reply-To: <20250619131319.47301-21-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Thu, 19 Jun 2025 15:23:13 +0200
X-Gm-Features: AX0GCFtmRRy5I91doA1D2ea5i25Q9Xlua4nOtMjG5qC8LQzhcPW_VnpruYxsqJk
Message-ID: <CAPMQPEJTTa4NiEvj9pmrubyn3dTB=13PW6scive=nfAGVtqMHw@mail.gmail.com>
Subject: Re: [PATCH 20/20] tests/functional/sbsa-ref: Move where machine type
 is set
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-il1-x131.google.com
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

On Thu, 19 Jun 2025 at 15:15, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> fetch_firmware() is only about fetching firmware.
> Set the machine type in test_sbsaref_edk2_firmware().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/functional/test_aarch64_sbsaref.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/=
test_aarch64_sbsaref.py
> index e6a55aecfac..5536ec622e6 100755
> --- a/tests/functional/test_aarch64_sbsaref.py
> +++ b/tests/functional/test_aarch64_sbsaref.py
> @@ -40,7 +40,6 @@ def fetch_firmware(test):
>          with open(path, "ab+") as fd:
>              fd.truncate(256 << 20)  # Expand volumes to 256MiB
>
> -    test.set_machine('sbsa-ref')
>      test.vm.set_console()
>      test.vm.add_args(
>          "-drive", f"if=3Dpflash,file=3D{fs0_path},format=3Draw",
> @@ -70,6 +69,7 @@ def test_sbsaref_edk2_firmware(self):
>
>          fetch_firmware(self)
>
> +        self.set_machine('sbsa-ref')
>          self.vm.add_args('-cpu', 'cortex-a57')
>          self.vm.launch()

Sorry, last patch, I forgot to squash:

-- >8 --
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py
b/tests/functional/test_aarch64_sbsaref_alpine.py
index 6108ec65a54..98762eedb67 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -32,2 +32,3 @@ def boot_alpine_linux(self, cpu=3DNone):

+        self.set_machine('sbsa-ref')
         self.vm.set_console()
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py
b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 26dfc5878bb..1c243d0d459 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -32,2 +32,3 @@ def boot_freebsd14(self, cpu=3DNone):

+        self.set_machine('sbsa-ref')
         self.vm.set_console()
---

