Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9931C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jEm-0001QW-KZ; Tue, 30 Apr 2024 04:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jEk-0001QL-7B
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:53:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jEi-0007uI-1M
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:53:17 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57258c90899so6716525a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714467194; x=1715071994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YQqqfgFFD81JJTQiCqNbZrKAgbzqLMOph3cRFXw/+JI=;
 b=Ebi2DWAGoPab5nSTvSiGIAtM1/mpme9irplT7FIPndOdFnxJ2Emz24tt5umpoII061
 s+bkbUiFz+R+mBamJ8VgdVoBuZ9qG/0bkd5te2hKsHN49JZKPTbaz25KygIg7nuhWs27
 VtnFC3Ojq4jLoLgEylMzKGzjqRC2Lgj/Ak7RkIWspVjn2a+XZmpUGDskxXLVBFVgguQ4
 P4dzhESxpVJ1Wj5GyfLFg42mEF31rqzPVnHb6734aivwokA0KkdT1G/E6JU+xnj74Jte
 VGRiqsUWgfKii7G/zfnhpkVxZACr+J7D8dFaF9U2ly3DOzUBjw6fPYLi+ZWgc+rmircx
 3eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714467194; x=1715071994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YQqqfgFFD81JJTQiCqNbZrKAgbzqLMOph3cRFXw/+JI=;
 b=XdVCaLI5ezNw11r+dIVovL4kk7oeQ83EKZRkHqx28iAE/OGub2u7nEdUDTX0a6n29K
 +zsCYsoUXGzS9yz+O6LAmVB4H+4KQQ9khCSb4qt23KA4e3PvZgHBPB27mXIjLon5ZV9H
 fsVd5d9fXl/m7oLkaNHB5dCpCMhylapsttsYYZ3htRFVRgiu+NuTUpm/SVs4qf3/vAuH
 TF6B1xT6TLpTI18EDd+sICuJ0Sg7jUmJ4847UWqQG2te9E+YovF7WuJXvOaJTWjrP1CC
 0BZCsf6cJADY2dVnQT4Gacw8T7Ue5uwmEWkXM3Aa2/HoRpnlEDmL0KYkTTgfsMrJXKKj
 4Wjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnn1Foeduk1i+w3EuDbgM4zAKxNo6R1aZkWULS3WOs/NCk/aNl5R2cnWKTSdneXleKgHS1FREDOnplyEwHaa0pJ/8zJyk=
X-Gm-Message-State: AOJu0Yy8tOrhT0y9J5hGL6LnyVD19BOX6O8YwdBwQN+SgUwIUPxZw2aO
 7CW11AYOgTkHDVfp31PdJ9K4CSIZRgcKTDlW4sBLT8CRhUg7GCHXs/DU0lnyXXI=
X-Google-Smtp-Source: AGHT+IFIuXGRxXnPoTfW8ICcTPpAo1fKw96Yt0DQ2gDNRQ4+yiuANcBEhDDodZgTyeOKH3AUk9VdGw==
X-Received: by 2002:a50:c314:0:b0:571:bcbe:8ea8 with SMTP id
 a20-20020a50c314000000b00571bcbe8ea8mr1940502edb.15.1714467193874; 
 Tue, 30 Apr 2024 01:53:13 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 t16-20020a056402241000b005701eaa2023sm14210332eda.72.2024.04.30.01.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 01:53:13 -0700 (PDT)
Message-ID: <f9956c18-3530-4fc2-8150-beba7b673f89@linaro.org>
Date: Tue, 30 Apr 2024 10:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch/kvm: Fix VM recovery from disk failures
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maobibo@loongson.cn, lixianglai@loongso.cn,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20240430012356.2620763-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430012356.2620763-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

(Cc'ing migration maintainers)

On 30/4/24 03:23, Song Gao wrote:
> vmstate does not save kvm_state_conter,
> which can cause VM recovery from disk to fail.

Cc: qemu-stable@nongnu.org
Fixes: d11681c94f ("target/loongarch: Implement kvm_arch_init_vcpu")

> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/machine.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index c7029fb9b4..4cd1bf06ff 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -191,6 +191,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
>           VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
>                                0, vmstate_tlb, LoongArchTLB),
>   
> +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
> +
>           VMSTATE_END_OF_LIST()
>       },
>       .subsections = (const VMStateDescription * const []) {

The migration stream is versioned, so you should increase it,
but this field is only relevant for KVM (it shouldn't be there
in non-KVM builds). IMHO the correct migration way to fix that
is (untested):

-- >8 --
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index c7029fb9b4..08032c6d71 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -8,8 +8,27 @@
  #include "qemu/osdep.h"
  #include "cpu.h"
  #include "migration/cpu.h"
+#include "sysemu/kvm.h"
  #include "vec.h"

+#ifdef CONFIG_KVM
+static bool kvmcpu_needed(void *opaque)
+{
+    return kvm_enabled();
+}
+
+static const VMStateDescription vmstate_kvmtimer = {
+    .name = "cpu/kvmtimer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvmcpu_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif /* CONFIG_KVM */
+
  static const VMStateDescription vmstate_fpu_reg = {
      .name = "fpu_reg",
      .version_id = 1,
@@ -194,6 +213,9 @@ const VMStateDescription vmstate_loongarch_cpu = {
          VMSTATE_END_OF_LIST()
      },
      .subsections = (const VMStateDescription * const []) {
+#ifdef CONFIG_KVM
+        &vmstate_kvmcpu,
+#endif
          &vmstate_fpu,
          &vmstate_lsx,
          &vmstate_lasx,
---

