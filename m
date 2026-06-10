Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B2CCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDAK-0004Na-EQ; Wed, 10 Jun 2026 03:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDA6-0004Jy-Fg
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:15:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDA4-0000vw-T0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:15:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so71118935e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781075739; x=1781680539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3TDiUy2PzzCOyt5mHH6+W/zA3yy1jiRXqY3YKvb0zPo=;
 b=txvnijpe+QD2ka6aIkV7WCmUoXtBIlnYD9rZubDNAQKEiHUkoAWn1TS78Y8phTskBE
 N7cchhp9Z1iLLo1nbIjWVQcUWPU0uVSBz+udaK2LBpg2VttGZlAGkmyg+XVOo1YWtufB
 9ApzWMGDiu3cQ1i7YCLRP5Lg31IqOSR2BLtw5+gaksN/wu+oliqpWDIAIfdymiIJLWZM
 wsOo5xpwisrDps89RiBeFeW46qHt/eiAW9v6fuTrrjtw/ERnnOab0HtxmVZSpYAfA1ca
 9dbh0Z+D4JZZ1Sh4E6iKo5rCLxxM4OWyBOnrxe6hDXJrt6VRZ6nPMaaUJsGXwVY4eCk4
 suBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781075739; x=1781680539;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3TDiUy2PzzCOyt5mHH6+W/zA3yy1jiRXqY3YKvb0zPo=;
 b=FEvKaTP9kQh+PDaMcyLDjjTW+8clii+6wxn6DJyuWSjW6/J2pdjI0vz2iRUmoVjUR4
 uB3qxgQjwfs5XBhoChz7n7d0pUGTaBIAm0sLPr+S3zRqaHdHWxHZ/0EmZYJIuzJdvIbM
 4Z/3HSMfR7adbyNdApMogamttDb1pDgdbQCPNTLcVScup420oQx31etqOFfJMscG3kww
 y/gILZvY/Sko8vKpsRqBZD9kkW2vNwXPNFl0ACOXtBhZqIm5pYKntLPD4VWxczbOvy5b
 W4sc+wrNiJJ03fvZFoKZdaBpB//6dSlNj/TnZh6r0A1kA9hpqqdRDAaCsM/OhNXt3npm
 QgSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ilLCRAAcwT6CnQj/rIKeRCIAHnymkhP0LNJEELoJ4zl6Cy/LPXcV7cbmd5iDkua9Ds+OOzWpnB+k6@nongnu.org
X-Gm-Message-State: AOJu0YwSFyv/5PzT5MX8zdz5Zm+dtkVN8dr+AU6f8R7Umy4aU8ycNlkm
 aOJwf/V5IhDiEm9K0ib3qM5ouv0BsY5uMuFSeBFzrhSNH6TQIsM95F37ADRNSuaSejY=
X-Gm-Gg: Acq92OGMlINBCvC952dT4A+RCFVhJingdJeUAhNIV2uEP3xvK572Fjiwd2a11cQoSSO
 I0tuveAY5BAnHbQEjMBRlvpnjfglBK8K8ymn9XV5QkiShxRB/bQ2Z34h3NJsJSHlTbDBr1x6JvU
 0moOmDITvF9X/Nxe4x3WgfL1A9+2hzE12tzv59DvkMhPzDtLAAiDMS2dQz6KwDPVQAAh13CUC4G
 71p+nejQQsajBOnTfFVe8qmNSyQ2DSJT2leSQaUnZwt3F5GEIkFZfnzmJTNGHG41Rw5wLF/iZ7X
 gSGTHKfiGgdtY/U6lQ/W3Hiwj9H8RLktgQ7FNvpGiVGbOtWGz1oVjKHKGZpv5+s05yNlq+ypwic
 OTfqnKPfH+lA1lytwqtaJKh+YKKfle/geXCUqQoCN5hT4q12pmIu+fRq9AwKzam6huTNu2KB/2Y
 OaqVTnXPv5WvAIlcsVgD3+FZfEFnEMzzexX+QP7uK1DwRdmlSYMBhchM+ul9q5u6c5+VNB7j+gl
 vfdxdXW3pVX0FIjjHYtUJubdSSb1d8PqtemAQWJKvScHJvNSwesJ9IzcP8NzUVt
X-Received: by 2002:a05:600c:3e15:b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-490c25f67d9mr376796345e9.26.1781075739275; 
 Wed, 10 Jun 2026 00:15:39 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3d66c8sm515825105e9.10.2026.06.10.00.15.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:15:38 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:14:43 +0300
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
Subject: Re: [PATCH 09/27] tests/tcg/meson.build: introduce env_var
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-10-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-10-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgemu1.1usbqbq5v5b36@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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
>We add possibility to set an environment variable when running a test.
>An example of a test requiring this is
>tests/tcg/multiarch/linux/linux-sigrtminmax.c.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 28a7e529c7e..b6a375e9eee 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -15,6 +15,7 @@ tcg_tests = {}
> #           'test_name': ['provide an alternative test name'],
> #           'cflags': ['cflags to compile test', ...],
> #           'qemu_args': ['qemu command line flags', ...],
>+#           'env_var': ['VAR=value', ...],
> #         }
> #       },
> #       ...
>@@ -55,7 +56,7 @@ foreach target, plan: tcg_tests
>       # return a clear error if user mispell a setup entry
>       foreach key, _ : setup
>         if key not in ['cflags', 'qemu_args',
>-                       'exe_name', 'test_name',
>+                       'exe_name', 'test_name', 'env_var',
>                        ]
>           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
>         endif
>@@ -120,6 +121,10 @@ foreach target, plan: tcg_tests
>       # some tests expect QEMU env var to be set
>       cmd = ['QEMU=' + qemu.full_path(), cmd]
> 
>+      if 'env_var' in setup
>+        cmd = [setup['env_var'], cmd]
>+      endif
>+
>       test(test_name, env, args: cmd,
>            depends: depends,
>            suite: ['tcg', 'tcg-' + target])
>-- 
>2.43.0
>

