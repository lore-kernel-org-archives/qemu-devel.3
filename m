Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2664106B534
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vca-0001Q0-2t; Wed, 25 Mar 2026 17:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VcV-0001Lq-Cg
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VcN-0001bk-QT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4870206f73bso1803575e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473501; x=1775078301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqyoMwzLRJR2AbAa6Ihy5x9qHK83oShAfwYCT+jORGY=;
 b=axKR04R04ZIgMHWGTyQVk4LGfFJ9a/ZBXchh8T0jxQPQ/aFjyTitM+9bYzvlYrGcaU
 oPp86T6s4z2JlNZbjr1LghwUdg5j1oAeYw1QBPN8WlNL4cUREA1TunfvrGnRcgwDdwEc
 WXhMUmnxbkgWXdvAOlsrvHfx6Rhl75hXmWrvm64AZnOVvuFQBP3SC3zDkz/YbqewwRjK
 1+QGjkoZik29DmjQtFLNPVPwIibLUnoU8flhANZbRPp38UgjGqrEhkdE+6n+AH/WAqAX
 nzSzBOuw2sAP2cpmAf1XTzN0hSOpXFVkUntoujgscOw9FKA9NR/kpL/Z/SJIaIbM96Ym
 qNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473501; x=1775078301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aqyoMwzLRJR2AbAa6Ihy5x9qHK83oShAfwYCT+jORGY=;
 b=s3jWET7uDomzHbPn1jibYXS2R+2++WUBlCVCVNACL6tkJptvw6Y3jaCq3dkRL5Niiv
 WiuZk7XfFISqImcXrrWGNnc0LFhfAOfnJNHXxCvv8uSg8VkDbQKacw7KYLA8brAD9M3X
 CI9ZFkD5f6HT96/sVo67IIV9RRZQM+++t/eEoygBq3xfyyyW02yucYJBdTHcDTAgX+JD
 e21iEKJYiuHihpuqPyysefDMRtm3E3oDf8nnEOgGHrG/QSApgkLTYlPZjZu5q1fr4/bv
 lgnRFhG5lKqWJElsvne9IoeZfFXDHW6K5DV9NGGVJ7KATDGpgkLn8+pPLbajWMV7B2EH
 ScJw==
X-Gm-Message-State: AOJu0Yw4yOG7ioeFp5XzCo+AunWl21Wwu9Ado961EAsv74yYv9FiszVJ
 SVoQn9vxrU/qp1YYty8YdAL5Lb4wPUlFdmxeDuo6lPKbqMuQrO2hd8/Lvddv+MkYxpm+mQdPx77
 v0VOD+zg=
X-Gm-Gg: ATEYQzwCvJa15/PgXa/hfVgnxd4D/cX0RnelkDBQQS4HShWFa4lEOls9b3Dmd52K8mo
 rz8btuBI1Su4IOA8euzaslsOQdpG0UqMTmtnshtZql+1fFrkick4Jqh50IjIjN7ru3vNaZWc/+0
 Ujj+m6/X5nGaSafvDoGa7dXB43ixEF1K3u5lRSRoIfTOBhRSC+vf9vpQPfiOFr7F33T2Wzce4br
 OYw63by2uTzRB6rJP9p7Z0LKcC+WtBL7R9ILo//jMWtkKc1YLTwaAmIlRQ1S5CdHmLocnv3/ShF
 T7fZBI/xaqi7vXXwbi/1LH48QOkxxXuyqBT6HI/EzV/ZVNGDUDTm+xFnPLuIhxIznmLOAuOKop+
 afX4u8XbA9cwOslm6Osa2Ta9mvmBUH0V3TpBrkqqb7MytD8I+uMculNNs3rhn5bEmpI3tmwzIs8
 Ois8vUpEBERyH9j1ErhYTKTt7o1k9dUQCNK0cXNdkpnRu3ZaOgV6NGWhhFn4lv0i739MO+ckxs
X-Received: by 2002:a7b:ce8b:0:b0:485:41c4:e2e4 with SMTP id
 5b1f17b1804b1-487160616a8mr49059105e9.23.1774473500835; 
 Wed, 25 Mar 2026 14:18:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb3cb42sm7892895e9.9.2026.03.25.14.18.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:18:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-11.1 07/10] target/i386: Expand VMSTATE_UINTTL_SUB_ARRAY
 for APX registers
Date: Wed, 25 Mar 2026 22:17:25 +0100
Message-ID: <20260325211728.89204-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

APX registers are only migrated for 64-bit binaries, so
VMSTATE_UINTTL_SUB_ARRAY() expands to VMSTATE_UINT64_SUB_ARRAY().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 48a2a4b3190..1f5c517e562 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1756,7 +1756,7 @@ static const VMStateDescription vmstate_apx = {
     .minimum_version_id = 1,
     .needed = apx_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINTTL_SUB_ARRAY(env.regs, X86CPU, CPU_NB_REGS,
+        VMSTATE_UINT64_SUB_ARRAY(env.regs, X86CPU, CPU_NB_REGS,
                                  CPU_NB_EREGS - CPU_NB_REGS),
         VMSTATE_END_OF_LIST()
     }
-- 
2.53.0


