Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7208A1099B59
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 00:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3kJ9-0003QY-65; Fri, 20 Mar 2026 20:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qguanni@gmail.com>) id 1w3jph-0000YR-F0
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:04:49 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qguanni@gmail.com>) id 1w3jpg-0000jI-3R
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:04:49 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-505a1789a27so14301501cf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774051485; x=1774656285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rex7xQFHxRc7L0kyFPZqwnfIVMJDK77X2EP6eL4f+RQ=;
 b=Rf+/huEPP/pEz5jAuOPh+IHOouxYHvwhVaBIZYm98V7qMlYxoMtd/L2Xugp+zwvBib
 7h2RVMBHmmaHZ1xHSC6k/JvZC6VjYv/iNj9biFYr3P+ZgoK6O0aINTika3Cuwc1nXrYG
 Y2JC6zfWOhnpHKvfJ9kH3femEkYQTF4QF3MSoBrYO6HBFWwmjlMAQRchCiGcwpQeIEOT
 Fl27v5FRDSDNrJICLWVcXW9WhW43FTTENvXpiAv5N4yDht8Iwt4CeJacZj2AtSD8Il3T
 yjeoEIJYpUXkiuYWUVnEED0GGDq3HcfdzVoVpbI0gl0G4dbXWzIh6yCX1DXLmiaWxb2l
 qIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774051485; x=1774656285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rex7xQFHxRc7L0kyFPZqwnfIVMJDK77X2EP6eL4f+RQ=;
 b=Vnegf35v38zWKcemDS/rXULCEE16bHPgE70zfvDOSMLHfk2UqQ2aUKmEBGDHMVkjGM
 UuHPrkHfZHSh97V/g9G6O4wMSvx4GkorWYLcVMtwn8grxCi3AEHrGxWAzHiAdOuzLo8m
 DGeHw4y/IRaM06koV3audjpKVgDLw9MqmoZ9vCkEfBrvmtpqcALwf00ntMusGZJwDoHt
 cqtCvGClF81I4nBpodfrB3mOUNCparE5K6fY1zrMrpu6u+av2v4puYHDj9otDuW3H01g
 On5Rb+37q8CwRmhGmSD+QO7SALruyxv9FI479PQRAMVO0DfBNqVdR9Ujc3RLLbhjLfwS
 wE+A==
X-Gm-Message-State: AOJu0Ywp3BvjR3M4k+GjhGRKT9UXR0qSJtN2tGXTpgQsXphmg2Flpxj7
 7QyWokrIwK7nn/PKGNs/tl+FXCj3YjOGRcn6pvjOADvZRg+dyiCd01VLRCvKql1H
X-Gm-Gg: ATEYQzwmVND/Ofz0ZEtdQxYpvq9qIUgJb07Jf0lXlobfOVWq/Epv9/2yjIkKO8xUMx6
 cwUfG5Di4lQAKzLbOgFi8Rl99G44S9CWOq/8ocq9ItqnaMP60liAB4xbZdCSzSrilVpN9ivP7NF
 sj0deO5UGG+w1Ly9z1u/lBfuRGftZw2NKY0XCQu/UpdYZsE4MCzr1ZF0ri1RYNNEv410A2/qBPD
 +ppHyJTj4kHcb5xpzxnNO5BlaRdbzQ63aA1w0651Cfo0c72Xep+FQYYD1/Il5kKaeEfbYp6OUiZ
 hlIVMKp9oADeGIyru9EjFCadMsXQovMRdYEQeLfNPeYFMP3U9kAHXXxKC73hycz7tJgHjQM01Gd
 SRpGxaMgnMcZGZcNn4tfOZQ8rphJaRB5rvP0K3N025PLdbMVuAhSeSW3nU9KLSG5itNKOWGOPdy
 LaZ0H0FpB57xOaIeUxqvLdjQmqeEWCF/DSHQ==
X-Received: by 2002:a05:622a:cd:b0:50b:4051:2cab with SMTP id
 d75a77b69052e-50b40513540mr51428911cf.58.1774051484643; 
 Fri, 20 Mar 2026 17:04:44 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85251b04sm30602326d6.17.2026.03.20.17.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 17:04:44 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, mcascell@redhat.com, peter.maydell@linaro.org,
 qemu-security@nongnu.org, Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v2] hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
Date: Sat, 21 Mar 2026 00:04:44 +0000
Message-Id: <20260321000444.909451-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=qguanni@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Mar 2026 20:35:14 -0400
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

When a guest sets MaxPacketSize to 0 in an OHCI Endpoint Descriptor,
ohci_service_td() transfers 0 bytes per iteration. The Transfer
Descriptor never completes because CBP never advances toward BE,
causing ohci_service_ed_list() to loop indefinitely and hang QEMU.

Add a check for MPS==0 after extracting the field from ED flags.
If MPS is zero, call ohci_die() to reset the controller and return
an error, preventing the infinite loop.

Fixes: CVE-2026-3890
Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 hw/usb/hcd-ohci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 1aeed9286f..6ed8046fc2 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -956,6 +956,17 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         if (len && dir != OHCI_TD_DIR_IN) {
             /* The endpoint may not allow us to transfer it all now */
             pktlen = (ed->flags & OHCI_ED_MPS_MASK) >> OHCI_ED_MPS_SHIFT;
+            /*
+             * The OHCI spec does not say what to do if the guest hands us
+             * an endpoint descriptor which specifies a MaximumPacketSize
+             * of zero, which would mean we can never actually make forward
+             * progress transferring data to it. We choose to treat it as
+             * an error.
+             */
+            if (pktlen == 0) {
+                ohci_die(ohci);
+                return 1;
+            }
             if (pktlen > len) {
                 pktlen = len;
             }
-- 
2.34.1


