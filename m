Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF84E6F092
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 22:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6zg4-0003Wp-PF; Fri, 01 Nov 2024 17:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Pk8lZwYKCrEifhlVYXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--roqueh.bounces.google.com>)
 id 1t6zg2-0003Wf-TG
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:59:30 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Pk8lZwYKCrEifhlVYXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--roqueh.bounces.google.com>)
 id 1t6zg1-0002RM-Dw
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:59:30 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e30ceaa5feeso4417398276.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730498366; x=1731103166; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=krdseIyYUptjoGlkS20dYXsB5X6RPQ/3yN6z5zilcLU=;
 b=M+QlXGTr4lqwdtuBexW5SmqK+grY/CGx52GubKe4MIvN3jKNKWFqq7sx98RobNeLrS
 pOhnEHg3h5FIe1AdwMISUvbj/zOJVJZfXraqVGUUFn8WMuJ1131ycCbXeSQpX2UxrPDO
 /01A1l1m3jdWtT4MQX8hpbsMuUa/J/sxBv/Tilw+zE8y+ddYcmnlkPo0REuJHv5Fq5yM
 bhQGUAizbMsd0iY/RlyxeeyruBHymgKSKAtQnh9TwfgEB56GqiZ/UleB4qwtnjKj3UlE
 BbHBWBPlRurIaQk/KjYvZThV++ZeowKwU4beCnD2lpFMKudem+IsA0qWQVdq32afGOp2
 PbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730498366; x=1731103166;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=krdseIyYUptjoGlkS20dYXsB5X6RPQ/3yN6z5zilcLU=;
 b=ommh5v8yzaATD2by3KG4tPUvcjpSzqBy1v6BQbGvc51AYHKuWfNjE98wMqpBaCmKs0
 Ls61uMk/KXr/uthcOBo7q6bcUe86a08LQbd2LBnbfcVSxAgTcn5asPHBf4wdkTPf8SPx
 AJg3yK+59s/W/JrgqFbhf8AUv6flHsE6/6Uk53sYV5zWjXw+sjemyLKMgid6xZGUHHzy
 oUnG9IZv/bR34d6/zlw67+i+3G9wUFgBP4ZOk2w2WfwIg5x8MmvQ2JBy30VA9GbVu8CR
 dtHpyIyNf9q/mLCqtPhyOo2z6U7p0DVUeJk2XOYCx8sZNbm0kVqT5r/w9DASjWm0BlbF
 xhMw==
X-Gm-Message-State: AOJu0YwRoLUkMXW1TYrRtlaPUDowtpJZFjBqxwBOYCAvll7MOauVQz9e
 2e8MSOv1eaT3XBSi/niJBAydhR8FRPbJjw8ubF3ZV0I9eQqpYvYYxjQ+06U8CKK6LXYZ+8I+h9X
 XaA==
X-Google-Smtp-Source: AGHT+IFXOaJUNUTXtVlDeNrR3iOb0Mqocj5Da7hZLcfH1BiY3037GciMsMeGMtPgv6zMpWKdfdA8N8Y2XBA=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a25:b2a5:0:b0:e30:dccd:9aaa with
 SMTP id
 3f1490d57ef6-e3302686a1fmr4977276.6.1730498366547; Fri, 01 Nov 2024 14:59:26
 -0700 (PDT)
Date: Fri,  1 Nov 2024 21:59:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101215923.3399311-1-roqueh@google.com>
Subject: [PATCH] hw/pci: Add parenthesis to PCI_BUILD_BDF macro
From: Roque Arcudia Hernandez <roqueh@google.com>
To: nabihestefan@google.com, mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3Pk8lZwYKCrEifhlVYXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--roqueh.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The bus parameter in the macro PCI_BUILD_BDF is not surrounded by
parenthesis. This can create a compile error when warnings are
treated as errors or can potentially create runtime errors due to the
operator precedence.

For instance:

 file.c:x:32: error: suggest parentheses around '-' inside '<<'
 [-Werror=parentheses]
   171 | uint16_t bdf = PCI_BUILD_BDF(a - b, sdev->devfn);
       |                              ~~^~~
 include/hw/pci/pci.h:19:41: note: in definition of macro
 'PCI_BUILD_BDF'
    19 | #define PCI_BUILD_BDF(bus, devfn)     ((bus << 8) | (devfn))
       |                                         ^~~
 cc1: all warnings being treated as errors

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
---
 include/hw/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 35d4fe0bbf..1daec974da 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -16,7 +16,7 @@ extern bool pci_available;
 #define PCI_BUS_NUM(x)          (((x) >> 8) & 0xff)
 #define PCI_SLOT(devfn)         (((devfn) >> 3) & 0x1f)
 #define PCI_FUNC(devfn)         ((devfn) & 0x07)
-#define PCI_BUILD_BDF(bus, devfn)     ((bus << 8) | (devfn))
+#define PCI_BUILD_BDF(bus, devfn)     (((bus) << 8) | (devfn))
 #define PCI_BDF_TO_DEVFN(x)     ((x) & 0xff)
 #define PCI_BUS_MAX             256
 #define PCI_DEVFN_MAX           256
-- 
2.47.0.163.g1226f6d8fa-goog


