Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC70DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5bS-00053E-0L; Fri, 10 Jul 2026 03:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5bQ-00052q-C1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:24:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5bK-0005Ws-Ti
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:24:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso325776f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783668285; x=1784273085; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jF8leG+mjYgWUMaWrAPdQbtgdhec2INhNoifkppjUS4=;
 b=p5nQRTr2TflpzFbvlfSp3k3t/SPljoWwDs03HIeJCI57iStSI+yxOG3vM2S7mY0Hde
 X3n43kxXRczABil0PAgVO8QTC82F+FaoC6P7nG/UszjoK1Sy8hq4kreMJE/sa06j6VCf
 6Dn6hwL+2GZASaB37HS0/WJ7sdUcUXU6EWHlpfA37w57Xop45MhHs0xFtvCnHntnWFzn
 L6uo9ufUMzoj/cqS3+7eRs4ZGL04YvNluCz1os5PbRpWmEbdKreb4TvftPqL8yOyGLph
 M/FRmr/8OocBXhiTHB7k+nDgCQLqxGD9YuDt7W/ago7hj09oIMDilJkdbNhLaokR9aFh
 PjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783668285; x=1784273085;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jF8leG+mjYgWUMaWrAPdQbtgdhec2INhNoifkppjUS4=;
 b=MVEXp5jNkLjyCqERL3HaX0tY/OFI6AQg6LpwumVLa5GYDCnndod0S8VqKXA88zDVXe
 xUTo59BVB1zH1IDlcuQLfG1hi+f+M8NPTSRqGSYb/zFsVGnKdRG9vg3cQJkhT0Igijcr
 pJx2sAAhmFp07wqaPkKnDFEQj9eiQpKfuczKHoHU5k1JU3EhmxHcLUwpCCXm4fVTC4Zc
 IDrfYxlXQlYlwwxU+sfRuoSyjpF1Oaq2aFa/st5rVI9MtoiuzteK+MPIKbrDu2haNdSL
 XldJDw5delvQ4yPr10KjB6miecDUfKHwUWB+Odjx9a9zPeaSb0wMIfF60Wlw1x8h+puE
 LzHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbUH/NDz4SzpiqZTgxtrTZR/HYw10ggbiUTt6AvECnAYhTi0qD/UrFCjeBB5ZHKMVsuZimSLTlDq0Z@nongnu.org
X-Gm-Message-State: AOJu0YxHREAh9jOWBK41li7fa2TDt7APx6WeQ0J91otGqZxCCIFxSTzx
 OoxBl7VqRED09wyceZEPmel4U4R5en11ZF/kqgzOWQO+8llGQxYhAI+boJ1TOYsBS5w=
X-Gm-Gg: AfdE7cnA4VVgM7xWTujWwrupGlY4nR3K7JHOaum0glkOQnijN36QbK9N5FBPhMbNtCd
 +TxqA/Q8ReEU+EfhqA9SBDOSJwvKzZGDa8rR4oQaG+VldC/sllS05rCgnACIV+R0i2e2v8Kwu+F
 exSiovekwcKLKRQBr4RjoAtgQ9xVpSQl3ZZDLLI6RFwKESiBP3oxXMC2wmAErw0ug5LVcBo5aHU
 PhjArZLxHfA6TwCoYC8jKz0cQGnUqTSz1u0iEG06V5RPhOVwZTTnmTz4dtGrmWAHhAX7CnIRznQ
 J8z3Nr2/Bq4/sWEkU20FPuihKmdCgf3weUT2n6d1fVEnn0/n2TkVVIam2WSQw0Hw6fjXbCMznF2
 9lXTOZGH+Zc/HFV5vUAOsRZ53qLyIKhiVPseiButiCtZq+DlTroNERNBX7QwDO83x09x8N6Y08K
 kUAQma1aX0zFWjJVw8JgjTsKAEwiPs0ReSAWgQ0iGlg6Si2/Mrt58MQQ4zd9MRHWBPhq3kVUfbW
 j/jfsCjZkjUIdLm9P/sPHF2WeTB/6Q88YWCi6O8pSCClXSUnzaCqbSJyINZ173t6av0LgHui7BH
 mI0my9uN4nLIgdJ82iyy75yQp8CQ56NYKEhXLITBpWRNXh9Zljt7oj18pcqDp/V5Ng==
X-Received: by 2002:a05:6000:2911:b0:46f:7d90:8125 with SMTP id
 ffacd0b85a97d-47df07b4f2amr10380277f8f.15.1783668285289; 
 Fri, 10 Jul 2026 00:24:45 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm58974486f8f.0.2026.07.10.00.24.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2026 00:24:45 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:24:18 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6ll?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Philippe Mathieu-Daud=?UTF-8?B?w6k=?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v4 24/97] tests/tcg/meson.build: move gdb_arch support
 check
User-Agent: meli/0.8.13
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710062016.1818125-25-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260710062016.1818125-25-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thy798.1pc7kghidcedk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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

On Fri, 10 Jul 2026 09:19, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>This allows to report the correct skip reason instead of saying gdb does
>not support a specific feature for some tests.
>
>Tested-by: Alex Bennée <alex.bennee@linaro.org>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 993a948bb80..572003f4ee7 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -138,10 +138,6 @@ foreach target, plan: tcg_tests
>       # if set, we'll skip test and print the reason
>       skip_test = ''
> 
>-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
>-        continue
>-      endif
>-
>       if 'plugin_test' in setup and not get_option('plugins')
>         # do not use the skip_test logic, and simply ignore the test
>         continue
>@@ -284,6 +280,10 @@ foreach target, plan: tcg_tests
>         endif
>       endif
> 
>+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
>+        skip_test = 'gdb not available for ' + gdb_arch
>+      endif
>+
>       if skip_test != ''
>         # still declare test, but skip it and print reason
>         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
>-- 
>2.47.3
>

