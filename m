Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52797C369A1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RFa-00044y-83; Thu, 03 Apr 2025 16:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RFP-00040t-Vi
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:33:12 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RFN-00044Z-V8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:33:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so1177080f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712388; x=1744317188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7P8huLNBvJOP7nd4dB1l20n900j9HtETUh1v4TfTS8=;
 b=BGRZwgNrZYhKyISI+Sp69uko6dWskSKz0zTeKDuCfgebBsnPXlBItKeeWHrwEi/j03
 /GwLghqjdC9Zpcj6pht9DYAohk//m5zyljD+4qVtWdWjFgOeXvE8B9wzAPdkjaqweSy5
 tKTyp5lHYz9OM538RG766oDSndZVyLXRXN7WKcTc16MFl5fRQFbN6Jjj0VbRTtrbykwZ
 Zd4QY3sZ9zVInLNYQmD34fEwD+pye+NRqQN6CeZmL6YiBisCQltJd8k9fXR95HRLKMK1
 9EpqY2pbgBiB5WtCSlfP2rhJwWGdl1fLi1iBtwyjm5U6G+ObMIxNqK9toP9fqGkQ2i3n
 ySIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712388; x=1744317188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7P8huLNBvJOP7nd4dB1l20n900j9HtETUh1v4TfTS8=;
 b=u1Ikw7CEKm5MOw9swmHaF9iJosZtOljGjMd7n7PnKqplO3oPj8wTM6hIEpywQ+vPKj
 gEjbL+qDuWSN83wTPQIz/6lEozizc5LnUB4C7oJorLF9O8b5DFoOLCd9PyO9nn3Ae8Ph
 n1l0kjNmiOFaWLdvLLs6WQ2RpzoeH9cAPrgH6ZvyCN2Dh8l9P3uNMHSLO9qWjPxHnJZ7
 9aZgFfYONVK+O5aq78GpJI2sjP10JgTryf6Ux39hC4JOq7feO+dGOeys6tXnv+W8jFBz
 KhPuZsqtUZjbGaTaKAbPL1SM49yRH+9tPC/7HygxmkuJNASnW9hReV8lT3HX7MkxIc8A
 Cqfw==
X-Gm-Message-State: AOJu0YzEnambyn3cXFGFXqlYqlUlgWNsmnI+cHaMJTes9T05FJ4xGnml
 J7BAQAjITY09A4IkS4Ur+swUb9mo6JK6bIghIVCec5BFfEI7H7MpvDoyVYojdT2E5ezBNMSb/aQ
 0
X-Gm-Gg: ASbGnct4y0pjgJs/4VVzgaZZR/RJr75uUwLSbEIeNLogqSonfdKP0kADwBfKqSmKpUN
 hptu4yyTJNVKMpQnan4cgpZjTtHvppWqdkWXfR+SEYBg2mdrhboBYE2cFFapmxgiey7mUc7ToMz
 hf5eNAdjsAhUEwVjP/6eXCFjHoALki0IlmDqJibztGnTSfhEe/rZblPmaUL5ctLqs18S/qLbckk
 /NnwhF+2fJk9pvWufRSoCFaFh/rrAOW674fGomej68h676QWfgxCfpgohEuT2vnunvvNe1I3wE/
 qpVPmkCjDBFfF6SwPDbfetlA7N/lN5LJZs50az/seUO1PTYGMH9Ik0bhorA1qj10fla6KjUq6Kr
 2P5FD139eBOW6f6x+rlpertPQ
X-Google-Smtp-Source: AGHT+IF3FUguB0EvTpyHd8MltBrOfmE2hcv1EI3ehRRGy0NnWkF4yS9AYJvHalKm56xlv0y98rHadQ==
X-Received: by 2002:a5d:5f52:0:b0:38d:d0ca:fbad with SMTP id
 ffacd0b85a97d-39cb359bf41mr627115f8f.14.1743712387831; 
 Thu, 03 Apr 2025 13:33:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020dacfsm2666744f8f.72.2025.04.03.13.33.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:33:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.0 v3 5/5] hw/arm: Do not build VMapple machine by
 default
Date: Thu,  3 Apr 2025 22:32:41 +0200
Message-ID: <20250403203241.46692-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403203241.46692-1-philmd@linaro.org>
References: <20250403203241.46692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Unfortunately as of v10.0.0-rc2 the VMapple machine is unusable:

  $ qemu-system-aarch64 -M vmapple [...]
  *** Terminating app due to uncaught exception 'NSInvalidArgumentException',
      reason: '-[PGIOSurfaceHostDeviceDescriptor setMapMemory:]: unrecognized selector sent to instance 0x600001ede820'
  *** First throw call stack:
  (
    0   CoreFoundation          0x000000019c759df0 __exceptionPreprocess + 176
    1   libobjc.A.dylib         0x000000019c21eb60 objc_exception_throw + 88
    2   CoreFoundation          0x000000019c816ce0 -[NSObject(NSObject) __retain_OA] + 0
    3   CoreFoundation          0x000000019c6c7efc ___forwarding___ + 1500
    4   CoreFoundation          0x000000019c6c7860 _CF_forwarding_prep_0 + 96
    5   qemu-system-aarch64     0x000000010486dbd0 apple_gfx_mmio_realize + 200
    6   qemu-system-aarch64     0x0000000104e6ab5c device_set_realized + 352
    7   qemu-system-aarch64     0x0000000104e7250c property_set_bool + 100
    8   qemu-system-aarch64     0x0000000104e7023c object_property_set + 136
    9   qemu-system-aarch64     0x0000000104e74870 object_property_set_qobject + 60
    10  qemu-system-aarch64     0x0000000104e70748 object_property_set_bool + 60
    11  qemu-system-aarch64     0x0000000104e69bd8 qdev_realize_and_unref + 20
    12  qemu-system-aarch64     0x0000000104e258e0 mach_vmapple_init + 1728
    13  qemu-system-aarch64     0x000000010481b0ac machine_run_board_init + 1892
    14  qemu-system-aarch64     0x0000000104a4def8 qmp_x_exit_preconfig + 260
    15  qemu-system-aarch64     0x0000000104a51ba8 qemu_init + 14460
    16  qemu-system-aarch64     0x0000000104f7cef8 main + 36
    17  dyld                    0x000000019c25eb4c start + 6000
  )
  libc++abi: terminating due to uncaught exception of type NSException
  Abort trap: 6

Disable the machine so it isn't built by default.

This is tracked as https://gitlab.com/qemu-project/qemu/-/issues/2913

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/devices/aarch64-softmmu/default.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
index 93f4022ad62..ad8028cfd48 100644
--- a/configs/devices/aarch64-softmmu/default.mak
+++ b/configs/devices/aarch64-softmmu/default.mak
@@ -9,3 +9,4 @@ include ../arm-softmmu/default.mak
 # CONFIG_XLNX_VERSAL=n
 # CONFIG_SBSA_REF=n
 # CONFIG_NPCM8XX=n
+CONFIG_VMAPPLE=n
-- 
2.47.1


