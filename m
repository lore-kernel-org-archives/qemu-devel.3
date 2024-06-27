Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF5EC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsfu-0001X4-ND; Thu, 27 Jun 2024 13:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfs-0001Mb-Su
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfr-0002KL-5g
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3636c572257so6588110f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508361; x=1720113161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CppPyHBGnGyh+KeMhLUUfKK62hbBIjgp+PC1jB0KmHY=;
 b=Unozw+WbqFhAtxGSCVcjHM2f4ppAu4pQhNXLSiN915fkY4m8t4Zla8HEOWFwUXNScz
 jjIh84omHzKMeZIXFIxCtlPc4B23Ta/n4uygMVlFD86fvKJcELvJoDVkgVBac0he8Vek
 gBkFF6rEUuGQ6nvvOynVYP8rv6v46JGCl/BFX5fFF5qKDVACREWkXqv2vH045EyIvXoP
 DIKCJnU4IWNKTDVUBa3nhbjfrZ5R3wQFeDD0/+YpY4NjSkozlocCzFCuk3LOCNYInMox
 i0SqLkV9X9ZqZNny3VDXLuMPmCvK6d6QxKxibVIY+xeyDOCSPpHbD8GiN+I3ZQ6hrfW6
 i4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508361; x=1720113161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CppPyHBGnGyh+KeMhLUUfKK62hbBIjgp+PC1jB0KmHY=;
 b=rXfq5QRW50F5BQdUZZbiEuj8YtqD0Z2741uPH0wGKoRcfyfQujBixWbYlqxKCHItrm
 gvxricdeXj6La/aS+BkGFvDFGFLx23/ZZ1s96BasS/G2x/4PDBkEcSs2ZWhPiKOtxJHy
 fltUIoHKY//8ppmeRFfoCSc9zn7EkIyoKuP9rogXSj7UqXHVQhP4P2hXRDSapcEVraFh
 FuI7TWsw1CJRmJJWvn+tmFsBge9i4D1zQ/AaPdK7W4Id8Pbuvkw/U2IIrfq1JkdqFyev
 GL8hKfwBXTJ8XhXcZRsDNl1xS2dluaEiBz46qSw0tw1YtZInlfjdGu0iytnbZqfkVkWH
 Xcdw==
X-Gm-Message-State: AOJu0YwT1i82JZkRnVknlItcuSSXSQyXjLLjmIzvy64Ejk7SmLOXLx78
 IdPF/wZLmqLn+oFRPeaCJ2ozn3Pl4fby8FF/1qLObyhhYgcoO/7V13LTkt01Tp2Go2f41sGNuUF
 12hA=
X-Google-Smtp-Source: AGHT+IFQedm5omyTJ3NlxjIwSTS0PK3a3Imi4i98PIvZJcL2L9K/BjXrna/LklFVxehY7cJuVO1GcA==
X-Received: by 2002:adf:b1d1:0:b0:362:ff67:272f with SMTP id
 ffacd0b85a97d-366e94db3e5mr11678812f8f.41.1719508361364; 
 Thu, 27 Jun 2024 10:12:41 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674369ebaesm2489133f8f.91.2024.06.27.10.12.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:12:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 09/19] hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler (CMD26)
Date: Thu, 27 Jun 2024 19:10:49 +0200
Message-ID: <20240627171059.84349-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
---
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7c6f5ccc72..0f9bab105e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1520,6 +1520,12 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 }
 
+/* CMD26 */
+static sd_rsp_type_t mmc_cmd_PROGRAM_CID(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
+}
+
 /* CMD27 */
 static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
 {
@@ -1868,9 +1874,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 26:  /* CMD26:  PROGRAM_CID */
-        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
@@ -2429,6 +2432,7 @@ static const SDProto sd_proto_emmc = {
         [19] = {0,  sd_adtc, "BUSTEST_W", sd_cmd_unimplemented},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [26] = {4,  sd_adtc, "PROGRAM_CID", mmc_cmd_PROGRAM_CID},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
-- 
2.41.0


