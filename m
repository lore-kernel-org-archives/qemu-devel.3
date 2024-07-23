Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDC7C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJ6-000856-Oe; Tue, 23 Jul 2024 16:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIo-0006fF-4Z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIl-00041o-CQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-427edcc207cso10657395e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767200; x=1722372000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEOkd3+zxom1XlmbkPPQvUDNjv9xP8TI/j35/QIU7mo=;
 b=gnP0B4UrGUazyktAluHhqjQUScuI1L/OmURPCarBu/6UJWaWxRzxuxY9blIllaVcAP
 i8Db/T2cy6Ye1a+VE8VQTlv7lRfxI4KzTPf9xFKOsZAms8GJt3Thqmpxn5YqCevpmE0P
 kp63ywRojTRSBnl2krCNGmilDjaC46clZoAYmT7FHI8c8mcTxNQXyEah7WfyYAuUKRbn
 ACOaa4SZhBBNgN5JGyAGxX+/jhPjqZDKvsKkw/z4oqXi7pZthOowUAeyQlNmJpw/Ea2+
 W+/Xfxs5GYJp7SAE7sl6DJ+gKnoOJjfwKiWs02AWljAbakTeWDkHtzGpfQcam3leElrq
 5lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767200; x=1722372000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEOkd3+zxom1XlmbkPPQvUDNjv9xP8TI/j35/QIU7mo=;
 b=EII9ANAlmTz+ms6lPcVxf6WlqYwPzWUvoYdI9HGXDJa3aL+gVX1WNTI5x/VDA/c/Fu
 wvBA1JzQezjwkOW+y1AGz01+vDWSV//lYCV7VCGXW46UKN69ogfts4I2lcwl3GrBmY4c
 HgfTjEeP8rRvMluo5wxVJ6FJ85WONPwZQYw5YvgJYqQ5VoOIFaRgx5EKQRz7m+mVokiC
 AaPzbVBn3mBzh1FjMDUgKGQiMKPyelK0U1ijsyluwaueFDpELpoJUK42b55aR2K+vufv
 DfvyBPHcEt1ngOYt6ZyB9guqK1mQFFQ2riV5JVMGsq0GQAlrNIhwSVbySU9+56MNyJ3h
 Xuzg==
X-Gm-Message-State: AOJu0YwAOfjzbNZr/KAHUERpPbahTZMpheA+n42pzsxB5cl1Qd5rqEQq
 gPH0L5MB7Z3gKi8iXerZq9XkQD42FHCNOQhryBH+W9xPZ4WQm3vJf34//hWwjhRuWOiAtn4mrea
 2u+g=
X-Google-Smtp-Source: AGHT+IG/JD7on6qkNkS7D2ufluexNdsnztjMRqzUsh2dMGW4owb5snE1Lf3MQRkUkNQ0dBB5hG9Fgg==
X-Received: by 2002:a05:600c:19cb:b0:426:622d:9e6b with SMTP id
 5b1f17b1804b1-427f95b0f94mr12795e9.23.1721767200235; 
 Tue, 23 Jul 2024 13:40:00 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9372e99sm532325e9.16.2024.07.23.13.39.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/28] hw/mips/loongson3_virt: remove useless type cast
Date: Tue, 23 Jul 2024 22:38:38 +0200
Message-ID: <20240723203855.65033-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

The type of kernel_entry, kernel_low and kernel_high is uint64_t, cast
the pointer of this type to uint64_t* is useless.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240722091728.4334-2-yaoxt.fnst@fujitsu.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4ad36f0c5b6..408e3d7054c 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -355,8 +355,8 @@ static uint64_t load_kernel(CPUMIPSState *env)
 
     kernel_size = load_elf(loaderparams.kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
-                           (uint64_t *)&kernel_entry,
-                           (uint64_t *)&kernel_low, (uint64_t *)&kernel_high,
+                           &kernel_entry,
+                           &kernel_low, &kernel_high,
                            NULL, 0, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
-- 
2.41.0


