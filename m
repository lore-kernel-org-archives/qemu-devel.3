Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D302BCD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXD2A-0001Qt-O5; Wed, 10 Jun 2026 03:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXD25-0001QY-DV
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:07:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXD23-0006Xq-Hl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:07:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490d1e54b3bso26179925e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781075241; x=1781680041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ssf7N5KP1JOsJG8f/+T1wuGPDqauVBhL2BDu1HgtoKY=;
 b=rGOTwSVeLZaDghG4q1lvvZ4AtGolLKvkNQRpPTJ0mqxfuefeBixjWzkHNf9kfJcbHC
 xIl6zEWpLgVHYUns8xPBRhT5ll5h+GeEXopFoGf/oKiKBTqmywTAObmRmqlIxN9yYES4
 PNfSGAaqnTdv6HYIvS76QgKGP8LxT1SOEBYHuK/i5gB/0/MdhISWlbCUuWX46LniMWC9
 mUA3zCVsk6dXVaGVTca0CEqP23QygN8y4FfvMJ075+3pOZP+WsdooJXGKWZruTvGxQ7B
 gvImzG16FfAQBrgtnnSjYQrvB6qfxAVNZRnabiFUgDcDv0BRir2gvaUte+/uBx8eaDj7
 mwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781075241; x=1781680041;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ssf7N5KP1JOsJG8f/+T1wuGPDqauVBhL2BDu1HgtoKY=;
 b=FzHv/JZTHxEVeX2EFEM38XWQG5ITDMYsq6twe7T0Jq4nPoFjWrB987CMqwx5rk++KM
 vloqvyvIMIDKUaaGxeRvcQoil/+FStBLsK5KMr/funuq10QWqkTd/7Dvn/tPGzsDFfFP
 q0DdQSrHA4KeFtCdqsRwAIwDsPZtN/UQoesYr8nkw7Om1jFc4D/sQlUKdSX1vbgQGAba
 PiyHXvBzbvn+w2fVG2eIp9zKE6nSBzD9mhZvlvC1zOFu1lfTKLcYzDbqnkwgvlB4Vy0O
 a9Dv/n/YG6ehAb1ReDnxyTpFIGh9IuWMBhr6ZnAXPi/NRmV/U6CkeXJUbHb3S01Ezgw+
 dfPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cbIKPkroDLNpPofx5A62EBm/hkEBjtALZPJcdiZKN3sJvy0DpJnSJyprAvdRj4Dl1v8UbiKLsfPm+@nongnu.org
X-Gm-Message-State: AOJu0YzQHjWkcNVDWRVB9RGDCaR5xblYHyJ+i0UNit/0SeiY3VbHdpp+
 t8q1O76fAoqm72X7cWW4QCGO5higJl92Vzx8W5LixzImKmuZlBo/YAJGelApoJnP4kM=
X-Gm-Gg: Acq92OGtmemOTqxMTCZc3CB/S1i9H59ivt2uBXt634V3ZoSPivlZvaGHqXg7gjrbX8n
 FTSIsqnjbtXxETMd/Azc0vbInCUt/yveSed4IRX0upx6wfdnoiDF6dJ84kz00otmfDUp7USaMDh
 ncabtmXeKAtBVN6xlBfc0JMyx4ONB/otaqx7i9iqa+j9CdDyG1ynyovL+el+iz96pmd7guXwtRb
 fJflF6tYVAnWK/m7UhdCOlPUuKYfc6R9sytc5bsm0EMqurenN7rvVmUtUCRueIb/9zC1s1rTe0C
 quGAMFKSK/PNaORw3WDZ/Es28wVhT3/dypGBFebOw6bXkiNblqRiZ6J2zsSvGy8/fLHn+eB1tN3
 OJgp/Qhzf9uOOKkSjOXoUzAV4cfE3+xQdmQ/PN6v+JidUiWEpeKpmdvJX/NB5yCu8RZr78JYdRT
 bsHt6CgAfH+5DJClvMqJERpYvNFJ4JDxgeg5wFv+57ywFhHONI0UzKTr//biFHKzFf/qnNCNsDc
 bNSytdFPnfCxKLUEyKMVdGio+e9ZGLbWA6HDph9J+sXLjSmCK7tv3LdusjNbuRG
X-Received: by 2002:a05:600c:314e:b0:490:9d1b:2022 with SMTP id
 5b1f17b1804b1-490c257bb25mr378369275e9.13.1781075241279; 
 Wed, 10 Jun 2026 00:07:21 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39e024sm721819585e9.4.2026.06.10.00.07.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:07:19 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:03:42 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 05/27] tests/tcg/meson.build: introduce exe_name
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-6-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-6-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgemg6.297pm0qzw7mjt@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

On Wed, 10 Jun 2026 00:47, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>We add possibility to duplicate a test executable for a given source
>file. This is needed when different cflags need to be used (like
>vectorized vs non-vectorized for instance, like sve tests in aarch64).
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---
> tests/tcg/meson.build | 17 +++++++++++++++--
> 1 file changed, 15 insertions(+), 2 deletions(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 72d1a9f8986..2c6d85c586a 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -11,6 +11,7 @@ tcg_tests = {}
> #     'tests': [
> #       {
> #         'src_file': {
>+#           'exe_name': ['provide an alternative binary name'],
> #         }
> #       },
> #       ...
>@@ -18,10 +19,10 @@ tcg_tests = {}
> #   }
> # }
> #
>-# Every test executable, is built only once.
>+# Every test executable, identified by 'exe_name' is built only once.
> # Tests for a given src use the same executable by default, and their definition
> # is guaranteed to be unique also.
>-# Default name is derived from src.
>+# Default name is derived from src if 'exe_name' is omitted.
> 
> # plugins come first, as we need to build the list
> subdir('plugins')
>@@ -47,11 +48,23 @@ foreach target, plan: tcg_tests
> 
>   foreach t : tests
>     foreach src, setup: t
>+      # return a clear error if user mispell a setup entry

Minor typo:

  If user misspells*

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>+      foreach key, _ : setup
>+        if key not in [
>+                       'exe_name',
>+                       ]
>+          error('unknown tcg setup entry \'' + key + '\' for test ' + src)
>+        endif
>+      endforeach
>+
>       # meson '/' operator drops left operand if right is an absolute path
>       src = folder / src
>       file = files(src)
>       test = fs.name(file)
>       exe_name = fs.stem(src)
>+      if 'exe_name' in setup
>+        exe_name = setup['exe_name']
>+      endif
> 
>       exe_name = target + '-' + exe_name
>       test_name = exe_name
>-- 
>2.43.0
>

