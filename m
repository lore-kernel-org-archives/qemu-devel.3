Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C269C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJzKh-0002Uh-8a; Wed, 19 Jun 2024 13:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJzKf-0002UY-VZ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:42:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJzKe-0006Lw-DU
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:42:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-35f1bc2ab37so36585f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718818970; x=1719423770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=abuS4v5zUAkeccFvRnhKZ5JI5KQTgSIwrGhfz4wXJkI=;
 b=h+8rjVWwAzJ7l0fnFcdi+pfRAxQAPj1Gi4Mst32HfyStAB0Z8F6+YzAr3wRgDhUznE
 Njz0ywYuI3Vbq5NLgIzYpkV96FXkYkGbJz03jtnKwCJVGKLKctN3ICXczHnGj5SoHDFy
 FUhAdZJNBkxBgmvqRe2KeJg4ZWAAC/J/DDifY4hA6xDUPLm5l+PLErhWLZwdLOh+K1qu
 36F/YywJu/7ERPgXi6a52xUgRCbkQKkdvb2uhlkH13ZACFuQjU58hH55bL9rbaLCgKuM
 UXog7H9kv/rCOsqcIZtqIcrNvytImgX2Ty7d/dzDEZG+hBAdJthSYPJDyDzfcIBmuBp7
 Qz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718818970; x=1719423770;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=abuS4v5zUAkeccFvRnhKZ5JI5KQTgSIwrGhfz4wXJkI=;
 b=FShj6iZ/jqFQVDSa4yPxYPJZxNDcLKQsirrsvEyXX33FP3CbD/2CRGXEw/P+8RzijI
 UhCCSj99lkhJReJPe/5kveZt9hrjr1EMXj8FhiCF50kb+VHGvBiQqKANE+u+SqqVZzJr
 RmUYIkAaW545ewrnIDTm/xDBNdwAWvy1vtWCABGs3B0FUByJHJR17GmrofF89/tROsQw
 n8hyePVrK1KbcZoY7cRnU1cuM6kUjlR2p/ABApybx1v87qDMQbv4iQmeNCsb2G5wdcHh
 TwkG5XolPuFPgc1qqU1aUBngZxTOwVcN0Wzda6H+khRW4MarePPequbteYnKAbEz+eNn
 Yi3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAMtHFpX0nGwx2lWNNr6dyWeLDrMkDamqtOvqGkliPMCqQm6G7aeKZtO7EwslV+jOPhvtUZkSzQaBhmLVgEDPR2cvhpt8=
X-Gm-Message-State: AOJu0YwDAzcBPx9OCUSVY1WQuQPDRfr0+4wHGrxsYqC/upfNgs6gEnFh
 HKD+s5dShaqOqrGOTfHuPsTFY+NU6rcFvs3QUHOnRL7R0vNeV4fpnVVwPv2pYP4g1WOiWQK/NYc
 SPco=
X-Google-Smtp-Source: AGHT+IG5Mzxp4iTZaMEyUf5YOfNnqmQQi17kpfTssjkvzDbUzffvkcJuAU0s1k6rmde4sSJFI7wkpQ==
X-Received: by 2002:a5d:43c9:0:b0:35f:d6e:f7bd with SMTP id
 ffacd0b85a97d-36317b79cabmr2332474f8f.29.1718818970418; 
 Wed, 19 Jun 2024 10:42:50 -0700 (PDT)
Received: from meli-email.org (adsl-31.37.6.1.tellas.gr. [37.6.1.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36268ad16b6sm4467988f8f.92.2024.06.19.10.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 10:42:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 20:36:24 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 
Subject: Re: [RFC PATCH v2 0/5] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <7cd4838d-ab79-48a8-8f06-dd8145c6c82f@linaro.org>
In-Reply-To: <7cd4838d-ab79-48a8-8f06-dd8145c6c82f@linaro.org>
Message-ID: <fc97c.1cmc8zsf96fu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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

On Wed, 19 Jun 2024 06:31, Richard Henderson <richard.henderson@linaro.org> wrote:
>On 6/11/24 03:33, Manos Pitsidianakis wrote:
>> If `cargo` and `bindgen` is installed in your system, you should be able
>> to build qemu-system-aarch64 with configure flag --enable-rust and
>> launch an arm virt VM. One of the patches hardcodes the default UART of
>> the machine to the Rust one, so if something goes wrong you will see it
>> upon launching qemu-system-aarch64.
>
>What version is required?
>
>On my stock ubuntu 22.04 system, I get
>
>/usr/bin/bindgen aarch64-softmmu_wrapper.h ...
>error: Found argument '--formatter' which wasn't expected, or isn't valid in this context
>
>USAGE:
>     bindgen [FLAGS] [OPTIONS] <header> -- <clang-args>...
>
>$ bindgen --version
>bindgen 0.59.1

I added version checks in the (yet unpublished) next version:

(Which we will also need to match with distro ones whenever possible)

+# FIXME: Latest stable versions, refine to actual minimum ones.
+msrv = {
+  'rustc': '1.79.0',
+  'cargo': '1.79.0',
+  'bindgen': '0.69.4',
+}
+
+# rustup = find_program('rustup', required: false)
+foreach bin_dep: msrv.keys()
+  bin = find_program(bin_dep, required: true)
+  if bin.version() < msrv[bin_dep]
+    # TODO verify behavior
+    if bin == 'bindgen' and get_option('wrap_mode') != 'nodownload'
+      run_command(cargo, 'install', 'bindgen', capture: true, check: true)
+      bin = find_program(bin_dep, required: true)
+      if bin.version() >= msrv[bin_dep]
+        continue
+      endif
+    endif
+    message()
+    error(bin_dep + ' version ' + bin.version() + ' is unsupported: Please upgrade to at least ' + msrv[bin_dep])
+  endif
+endforeach

