Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF77C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSV-0005aV-7Y; Tue, 01 Jul 2025 13:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSU-0005Zv-1I
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSM-0003TT-4l
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453643020bdso51657425e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389659; x=1751994459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z3FS3pa/hJFQ3XazBFwVcLs+0F58UEBEFoq6YVldz6U=;
 b=TzohPTUJMTJvoiIqux5j4dC3P6SONAniudz7JGUTaOwtqerxgiTCcaMA86PiLUhX1l
 PS5q+kA4SPce89GeQKUZfMRvrwGyhVVu6KrVZ038ApDRefRHzpe+fE5yFt/B3PMj0SHq
 Dv5J/yF0Ys8s1urF+OKWIY2IoDur6j+odBjb7HpF3xBt79shEhcdFNPkek2RUgYDlRRO
 8b+gIGdjkLzszS3/WohZIRGAdhaVBO/jP3vsi8/248cE/nJo2sQwmxwOyoLnmJQ5tw5G
 QNhgYsafHAhAPaT88kiSmw4pYdMZB+bCi1NVMGoZOVH48L6ni3vNWiOkGGzOstBZx9NF
 UxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389659; x=1751994459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3FS3pa/hJFQ3XazBFwVcLs+0F58UEBEFoq6YVldz6U=;
 b=N6LSs0mf0sNRIwtUgfbaCf2LqTp7DWSReHJuVGqwFfmwcMGhfZmE3IRuuSa+fwatr7
 jaETVlPnhSIWj4Bpyh5bJufI+Brgi9QesvfKbB39jURA6Nb1/n8QKd2B+GRJA0iyxo3y
 kYjKDRzNshlBtSCMwmofojof0hMfJWmuoIYw7OUYBRG6dM4sCIzSv1NBnNhiL4zD4lj2
 rbSpMylCuY4uYh13DfIz94le+GhoyLKk2k+VnYKPfOBVtsKPT+NKp6enaCCdZ666sxz0
 olTJTWeocI3hZZ8yUxpbPeVU6DsDjOWDGCysJlGGMxJO3gxSz7NRMUN8UvNAD9kInbJ/
 wNFQ==
X-Gm-Message-State: AOJu0YwJ121OFqSlWbG/7rH0a+FaEhjOvm9x06gULV7p4vIQiYiplc3I
 cSvJHl2yfGr+yqHSt1BeUf1YVGyBvscQGhIZS+1OICBiGtaZ+bPrHTqICjONwuL2u3Tmbuexldp
 f4+IB
X-Gm-Gg: ASbGncslhJ8/+7vSN76Tb/ZeWMYrGxLgWMM03MmBiArjdLbaicgB7yYHOpwk9u0mV/E
 PLM8eLKlj9xWU3wL6/WSNixuxZaPypk28nSrJJMS9boqbC/0Hw9gXzYmeV/v6YRXiqAKm8QLTb0
 9KOV6Mz++7B03RhUJcH2cADklXK9Ygk/dy8oX48JLj3BHQVkqzRTI8GXHMwaaNiM7kRVvEJJmox
 PKyLYQe/Dfim9oy5U3dV9U7CGHHXLioz9bd3cj6ao3Xwge7ucqgVf+y7eYZjQtNK7FzZdPYaBeg
 2IeW3mN+1fSDDinjjmpINYP23AwPbt7nY7QvxpXgVmBLfzhCpXvBjhCsT9XfDYLrllRj
X-Google-Smtp-Source: AGHT+IGhBDCQYHsFrr/puJelHd/xRVxXX7WYwqJiMBBfDNblxcIQnGFURb9On6widWE1YW9ojTGwZQ==
X-Received: by 2002:a05:6000:4407:b0:3a5:52cc:346e with SMTP id
 ffacd0b85a97d-3a8fdb2accemr9792969f8f.6.1751389658928; 
 Tue, 01 Jul 2025 10:07:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/43] hw/arm/virt: Simplify logic for setting instance's
 'tcg_its' variable
Date: Tue,  1 Jul 2025 18:06:52 +0100
Message-ID: <20250701170720.4072660-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Because 'tcg_its' in the machine instance is set based on the machine
class’s negated variable 'no_tcg_its', 'tcg_its' is the opposite of
'no_tcg_its' and hence the code in question can be simplified as:
tcg_its = !no_tcg_its.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250628195722.977078-3-gustavo.romero@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99fde5836c9..6d9256a5255 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3342,12 +3342,8 @@ static void virt_instance_init(Object *obj)
 
     /* Default allows ITS instantiation */
     vms->its = true;
-
-    if (vmc->no_tcg_its) {
-        vms->tcg_its = false;
-    } else {
-        vms->tcg_its = true;
-    }
+    /* Allow ITS emulation if the machine version supports it */
+    vms->tcg_its = !vmc->no_tcg_its;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
-- 
2.43.0


