Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9D6C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBi-00026U-LX; Fri, 30 May 2025 08:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBg-00024p-WF
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBf-0001sE-Am
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cd6b511cso11929825e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609414; x=1749214214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fS79x5BIRHf5Re5DB6xx3FHnsTcpFhsOAzcTRrbY1fk=;
 b=Cja/J4GYcI/MCuqlEqly0KrGGuOXY2L5p6NZEqP7rWcRHT1EDBkG8vPtFzMAAe4ZfW
 zO+irA9xQJZ0VxYR0DpaNNlQ5iFddj86k9stpAhu92ns8VfAZjz8gHcL/dmZCD63dlxD
 3UNW4KSvcDaMv2SKLOoxG8EW2MyI1zxHjIGIk/MGeK/qQ2kZlaJ9637oxwA2vgZRu24U
 qJUK9KXQ04Rz7YlvcxfGjKPy/PtOD6iJO7NwMkBP8FQrRId1nJ62geVQTUFH9P+H2gJF
 ni4d1eySXCqkFSFi1vqOt+uWrMoFKRWnNV+SJvlyvDn9HhjPZYNABLI+t7BnKeMFPlWb
 mmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609414; x=1749214214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fS79x5BIRHf5Re5DB6xx3FHnsTcpFhsOAzcTRrbY1fk=;
 b=N3gOlHZaMRl1FP6489k+tcBY6FbtCbfyjAPE3H8MupIBaSBFgzB6q91b8La98jCwnv
 hdbIEAk81jsuIlzFNwLSuN1RNQoQfVNXibf9/jGHE4iQoy8vSFqj2Np+1qKjq3xSFPpz
 PUOwpDXGTZhpf86HQUmZigGDvM59XGiIf8g4iFr2oqVLvFKk4GL6c8Fc3XOkVYOrHMyN
 vLFXG1OVEORylybPA7RrN09+BSxRo+3R3Tr/25gNL0h4RCWfM8uyI41wPfrn0YJ+BZ5d
 YSwzIyt6z2lgo0qOlUrQ6J5pSBPkgHwbjAoD7k7QmJMwKOuwn4fH/bd0CWJ8LYjSpvH/
 rXGg==
X-Gm-Message-State: AOJu0YwzUho/5eBhwWDNExDTdonAowYiRr9W1tVRPpar/dUO3ixy792U
 XC/o0waFpgNUeT/2RAlL4CbmnFAI1rWaLKr+d1cWguBUCQqPxmDw8jyrJ+kFMZW1emUALh39Vx8
 hPDtl
X-Gm-Gg: ASbGnct0jYUusmIEDScPLBpJjJ8LNs8bFMgTilWUHF0A1xyHm0ETrn47VQFEAKNxjdA
 bhI6xmiTkj4xD8gCnNLw/QSNkJxMl6QkgDLGxLkdsU8IB7Q0y9Kj7+/CCiy95WLpVrGFJe29cfN
 LxQHomNePalWjwAm+KSmjgR/W/PoDc8ToRBuzVp7ZzfeQUVCV9gQlp+fjLlQpB87z5s7x+Cs5LU
 SvqPCSl7z7iHkStbZ0IQhebQK+k81klorRxi/QK2Dv3THCjJp4JA6VJjN1LYgWnI0r8NEAgGM8q
 4GP/hAjI1clDA5/6isjVxNB5jJvpfcHSCoDFuVxMjD0VvcVYK6++9rga5Q==
X-Google-Smtp-Source: AGHT+IGnxytiG+U82icGcCpBNo87c6ocHFi9r16dHpCEVXpAaaKqU6aVVSl3IOP6heuor4RsUQaSZA==
X-Received: by 2002:a05:600c:4e0b:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-450d64e145dmr31241385e9.14.1748609413747; 
 Fri, 30 May 2025 05:50:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] target/arm/kvm: Include missing 'cpu-qom.h' header
Date: Fri, 30 May 2025 13:49:49 +0100
Message-ID: <20250530124953.383687-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

ARMCPU typedef is declared in "cpu-qom.h". Include it in
order to avoid when refactoring unrelated headers:

  target/arm/kvm_arm.h:54:29: error: unknown type name 'ARMCPU'
     54 | bool write_list_to_kvmstate(ARMCPU *cpu, int level);
        |                             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250513173928.77376-9-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index c4178d1327c..7dc83caed5c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -12,6 +12,7 @@
 #define QEMU_KVM_ARM_H
 
 #include "system/kvm.h"
+#include "target/arm/cpu-qom.h"
 
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
-- 
2.43.0


