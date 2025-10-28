Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6929ECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcnx-0003s3-TF; Tue, 28 Oct 2025 02:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcnn-0003pJ-8M
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:03:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcnk-0005hc-1f
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:03:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so41815725e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631402; x=1762236202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ll6Tf0Ct69En0jXlpNgHzxdgqKjfsdOoKFlniwfriwU=;
 b=dXbMPZ5k2ODr/W6OEGcFOJGQVtd1OWneggkR833RzJoHOIMCtOULso4jiCoR8GaeXQ
 du3zlbFdr8vOcmHNhMSCobsMX3Wm9HQ34BLPV3F0cwWo21oMAqQxpZuHB17Hg8OewE0n
 ix++qIwNILg9wsMrgLyv1vBEdY7rd6EX5/pPJ6X7aNYY6tsKitvrJVtZ72c4vxr2RAzf
 jkjHo7HpJ1wv6vYsGAsQg3EsLIJzVHQbB5NYLYRHr9iqGMdwHeaXVjT0ivima1qMZp99
 0DjYfjE+jn2FMsECAMFjkZrQzQBp8pkFMVzP5nxfDe96dZyL7pRyAIE2twBu4yZEBSYZ
 OSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631402; x=1762236202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ll6Tf0Ct69En0jXlpNgHzxdgqKjfsdOoKFlniwfriwU=;
 b=GjlkS7VokKIbTee4JN1nvlD+uCAo5c9NUZe3rIYvQCvcHRDSLcdIKvFkB+QRQ+iwwN
 HEWIxDgS/urRbiFiW4OLTC7h3uISsjOzd0LLhwFbOemI7h+4rOzLJ48p9zyLz60ykmeM
 l3WASNFxxwvdkjs7eAqt+rvEt0rwLzwVeq/dL1beLgP2Z3zmzBVU1wKiaNQDKInAjpI3
 oFcQTv0gDF1gUiNgojwlZhZPG/scqsADVfQsk7hgV2xKECmvK9lD6Oz47mLzsGjO7gPI
 /gERWdChU/86LLXHAJYzmksFw7seTKVw4EGf+WsmPSxrTAHX/ZhpJwU5q6NZkiRe3vDm
 B9+A==
X-Gm-Message-State: AOJu0YwQQITFk30zZI49jQ2J6UhkzHiqGskT5fODUfMHappNN5KQfmMj
 TTcnJSNN4QsJm+LsVmCrCnNiv2B3EiWqAT0kvR1I0BqIiO5YHLsNuzvp5f85kUEJxaO9hwe2Ieh
 8vHuzwPw=
X-Gm-Gg: ASbGncvdMnIzweB0oBCfnCEYnC+p8/3g8uD+O5m6DTBAqZaOiJTC4r6xRlC5aqizxj/
 2+1JBbX/z0GZLmZ3OsxoOEAJHAXcu8d6Suo8BH95hCkHY1Urg/Mf5YERUUhLV4APrupI55bHUqG
 sy+uLv3pUfzd6anis5FMcp/Ywx48sBWc68xEKq6As69F1iuNo8dVevz1T1ra9YJBUg6tkIrjOps
 CVNt1B1zHbtwVP6Tr51MkV1jCdcPjXLh6QjHSkDdhuFEUjffUeRNKEPlK2Vy2AEx6sJO0Avx6gh
 O3FpkO9uPTKrlc90Gy3duMjdjT/4VPFSO+em/bKFRgBiEiDJ2Fe6W7oVPG5LSp/uFd+xWIUqQi+
 //FA5vQb0agR0AjdpoyT3Ux9esMQLQ/avkbiiq/Qn0QmC+LSkqsWxiTwO4m/Y38+OepqpYES1Da
 mHUBQ4QlsIJFch0ch3JEJ+eFka5IRHN/MZuvpgT0B4LM1a56UsOPTkGpU=
X-Google-Smtp-Source: AGHT+IGAMsXwptan82HAuhng40vI14uZK7lXnZWO7NrVQgMpYfQLMhTUt44fnTq6xVkq8eQ8fsWA/g==
X-Received: by 2002:a05:600c:83c3:b0:475:de68:3c30 with SMTP id
 5b1f17b1804b1-47717dfaa4bmr13964525e9.16.1761631401853; 
 Mon, 27 Oct 2025 23:03:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df62dsm19804790f8f.45.2025.10.27.23.03.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:03:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 29/59] target/arm/hvf/hvf: Document $pc adjustment in HVF &
 SMC
Date: Tue, 28 Oct 2025 06:42:05 +0100
Message-ID: <20251028054238.14949-30-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f31b6e54ee7..805fe75e6b1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1936,6 +1936,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     case EC_AA64_HVC:
         cpu_synchronize_state(cpu);
         if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
+            /* Do NOT advance $pc for HVC */
             if (!hvf_handle_psci_call(cpu)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
@@ -1949,6 +1950,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     case EC_AA64_SMC:
         cpu_synchronize_state(cpu);
         if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
+            /* Secure Monitor Call exception, we need to advance $pc */
             advance_pc = true;
 
             if (!hvf_handle_psci_call(cpu)) {
-- 
2.51.0


