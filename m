Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B692EF99C3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxJQ-0006IL-FX; Fri, 13 Feb 2026 12:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJO-0006Hk-Sc
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:50:38 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJN-00065j-Dg
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:50:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4806e0f6b69so9651085e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771005035; x=1771609835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5AlmTMgCyk+2AUmH7VML5lKoAxWR5LTdLAyVu7t5Yig=;
 b=QM2Gabh7zrL0VslcafAOUah+dxybF7wLof/bjvn6BZ6lLDZDu7ZOJAY4Imj/YRApTm
 ulkfkYAm0ZwIixEJGo0TdtLLP/2VeG9zqv0QEbDVL6OCLnDJAo6KUgl6efq+zP8tXiZ2
 ArGYglFsFpReRZTrCibMbi5pLNlyq/+oUoArLqp0jhcUeAbGTsjeRozyTPX8EY5/K8DE
 nGhmUvdEpL7CY0ape2cFJuKjM/uNzHVit37m09Jd8eimHmZZ0dRtY31m9KLaQJZt5x9T
 a1zjBReIsH3nq/1arv8FhNyK0GPfLgMgQHHdtJMk2tPUc+8FnpQ+Nt0Q7ADKGqUqvCF0
 WZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005035; x=1771609835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AlmTMgCyk+2AUmH7VML5lKoAxWR5LTdLAyVu7t5Yig=;
 b=B2aWJcFIY0Br3UvH9IoHm9nXpdXq+pOg4NzEyGEuoSJZl2tDY89nOnp9VUCN8N1uXL
 Vw9rF/67kWErcfZj4nTmiXRVINxAVTG20sHGiDNVphOnrw3hXaRPkp6XnfsN/oTdi6Hx
 B5ojxt/BUyBOrpDkKgzNkVnuyXUgzSUJUk0y647LS1mYNlJX4aSqoaqVNtrJvFi2E78F
 KFJ1RCdalpr6FyMqxqwPD9Ob3rrcpDQN4y1aLbPndDm+7y4NMYHHhFWXyFWDCHSpbqqh
 P8GFWEchLH1yLniYpRScy0JH9GIDtdHJOgop7WT789t73YI2wAon07S8GGR+V+IYFnhn
 X+cA==
X-Gm-Message-State: AOJu0YwSBJ21ZyGFGb04Kt6+ohp08/bpv4oq1WmfdFQUQsoFnkellMKD
 U1EgwzzkBOOXvmWP2nNIXoFTG6ndh+3mEafv18a9vvDOyFi9GeW00vGnnBdzknDzt9U7hrbOgsP
 3SGsY8U4=
X-Gm-Gg: AZuq6aI6guSwE6kQUgnTmRBjGrWV/QAPbRm5GEus8PyD0RhQaxeWU7FEOEq+eXMGsio
 A+vNEaVpoSJCw45AtWNzL6hsOOQGHUO9l7SRnxlVgKvqEf1L/mOhdRQLaA10xXxhiCcB3k7+UET
 QgydFCl7v+zvb3USTCsox+Y5gcc1EMALXJQXfGjpdvfFSf541xdBGzdZVVRE3BLe6fA+uqPcm6p
 D3Xv+8oBfA7bL0fVhPbAUJt6wcerwj1lIyil9JrpaOS3aCtMjtxrqJBflyRATJH0Ib92URhbeg/
 yW34CR3/RcKUNyv2vDi7KGR5+TWctUpjL7juFqzqtIqpniicc8o3jEfb8EGZ75K79Bc316uJpBR
 3q1PxepRJLh2jVmsxMVU4OjtBNXvz9ohj6bXax9j++VX3ikoKudXtJWdJ5CNhl5MYq/6QSkzDWF
 OR4s7m+Va0JMD+jnDFNUt9jyLcN92lEUQvfmm+YYX+PBHpFgwkLNxmwQOz7RRPSkWJaOqAda/Q
X-Received: by 2002:a05:600c:c16b:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-48371042fb1mr57129795e9.8.1771005034699; 
 Fri, 13 Feb 2026 09:50:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfafcdsm359844685e9.9.2026.02.13.09.50.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:50:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 0/5] system: Make qemu_arch_available() common code
Date: Fri, 13 Feb 2026 18:50:27 +0100
Message-ID: <20260213175032.32121-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

- Avoid qemu_arch_available() in hw/
- Document qemu_arch_available(),
- define QEMU_ARCH_* based on SYS_EMU_TARGET_*, allowing
  (via with TargetInfo API) to compile arch_init.c as common,
- restrict qemu_arch_available() scope to system/ sub-directory.

---
v4: New approach
v3: Return directly within switch
v2: Prefer switch over array (pbo)

Philippe Mathieu-Daudé (5):
  qemu: Document qemu_arch_available() method
  qemu/target_info: Add target_s390x() helper
  hw/scsi/disk: Prefer target_s390x() over qemu_arch_available()
  system: Make qemu_arch_available() common code
  system: Reduce 'arch_init.h' scope

 meson.build                |  2 --
 include/qemu/target-info.h |  7 ++++++
 include/system/arch_init.h | 30 -----------------------
 system/arch_init.h         | 50 ++++++++++++++++++++++++++++++++++++++
 hw/scsi/scsi-disk.c        |  4 +--
 system/arch_init.c         |  6 +++--
 target-info.c              |  5 ++++
 system/meson.build         |  2 +-
 8 files changed, 69 insertions(+), 37 deletions(-)
 delete mode 100644 include/system/arch_init.h
 create mode 100644 system/arch_init.h

-- 
2.52.0


