Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B2606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bv3yqi97
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3er-0007DJ-St; Sun, 25 Oct 2026 15:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29K-0001Uk-PD
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29I-0007uV-87
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1363165f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949807; x=1793554607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=msJI3Z0K76VklIMGwZtl1iOjdBjc5f9wydmB5y+3zso=;
 b=bv3yqi97JhvEHKHqZ7eLJeuq5wwgxwTuLnGXSzcSqxX+gEN+jJw+607Nfe0fK/1BcT
 gT5mQ6dGAlZCM3shhqSSECED80dlyvry3lPlcjkkIl96p7IQvzlIkkqTVblOKVjomtO5
 vTpVh4qDc1A8ImoODQMUAS00+9nSUj1QvsbxbJRvi5JpfoEOoSUQGGYTufp/9CgGE4My
 eB1X26M/DOPiCr2c9gAWqyU5DF6lINBvLxMuyz2RnN02++DtZWWapzMhe/QaB3ccL0+j
 S+tlntYpkFd8NZQ2YvNgZe/V0lW8wLIkYxu/cUYPUGyyj5RGlA5bmZi3gV+j7bzuITwf
 bKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949807; x=1793554607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=msJI3Z0K76VklIMGwZtl1iOjdBjc5f9wydmB5y+3zso=;
 b=VFnVmb7tKI9cpZczKtUbuwiaGUeUJtKUK5b2F4RiBnzRukS4+tctOcbpisV/PV7+LO
 w+cag4FBUkfqpuOvGFkS3uSg7/Sbxk8NU/oZF5FsLZKYOe6lfNLgOr1945Y8sRXawvVK
 8LCUt84W1tDjpk8sTLTBx6ce/lNELNBsaQZqBGLFdu34cd8TWUT9YHZ0hKmy60gCbsh/
 SAjlO0Q20ZuyhQDS/fETreD6nB3Pvz107+UJnKaRUJKX0JEPuvFcAIBIvtHjUEtXl+mU
 UMyYH9Ky2N5nMspsZddLtPm+AQfHK8iwkV3BfFa6cpQ4ToZOrrRqstPf7kkF97fHAR4B
 Fp/Q==
X-Gm-Message-State: AFq9FYIc5+ihTzGVLQYiUGezZRyPcZR6JRa8Wh4gMPd1/VPhjr0G3wwr
 jyzBq7TRUjzY48hKPiuPTCRHmRDWrgO0DzkCYHeinBLvh6+LdpA3F8arODBP
X-Gm-Gg: AYBFou197PtpyheTV29PL61Z7drKXXihgYD/A8C2Wdr80tX1jw/bmlRV692Rcyoyx92
 lBXSiDRGdaoso6I4Aji6/d+VAPOziT0dWFQ5K7YWzWBy0iN6VeVDUsVGsH5LPPDOe5d+3eo3aQw
 R5Wu6lgck+5UeYb7sQ7yPCozO9vl12c/eXd1Hrt4CTj+HMRplzB+ViPbJvUWZN5am8UORg4RJzN
 N+Ouf1ZXg3Cy8CVLVzQggiCYlKsyLMOpFbAZjTz7BkuD/b8TU7V3zK2Gy0dbCKfxJmNbge/8gHl
 Z8Al4Xrc/HwOvi8lrF4fizOn22rAfrWDDmcqpAhM0N6kQcvJUByc0hUgoAjGu8WIIovTClqy3G9
 0+bx6BxBmOiO63m6W/AEwShkLSZMAuDKYcSYsJpR4xAh7iMZ9Qs7lrHgfzoncVngbwX58RGTbR2
 K0Q17gnIthnBOwhHYZFEO7gkDb+xBTQDZOUyZuclCa//+IvKEv662nILUyG0M2GD6LUf/tHoUGf
 ArSaC9hl754ixg7w173N6FX0ErOZ4fDaM0DGQ==
X-Received: by 2002:a05:6000:22c8:b0:485:8a47:5b91 with SMTP id
 ffacd0b85a97d-48e3eba4598mr7980151f8f.46.1792949806570; 
 Sun, 25 Oct 2026 10:36:46 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm10886890f8f.42.2026.10.25.10.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:36:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org, hpoussin@reactos.org,
 arikalo@gmail.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de,
 pbonzini@redhat.com, fam@euphon.net, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, berrange@redhat.com
Subject: [PATCH 5/8] hw/scsi/ncr53c710: add instruction count limit to SCRIPTS
 engine
Date: Sun, 25 Oct 2026 17:36:22 +0000
Message-ID: <20261025173625.3372689-6-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025173625.3372689-1-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=tristmd@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 15:13:17 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NCR710 SCSI controller's SCRIPTS engine executes guest-provided
bytecode with no instruction count limit and no reentrancy guard.
A malicious guest can craft a JUMP-to-self instruction, causing the
QEMU main thread to loop indefinitely.

This is the same class of vulnerability as CVE-2023-0330 in the
LSI53C895A, where the fix added an instruction limit of 500 and a
reentrancy limit of 8. The NCR710 implementation has neither.

Add an instruction counter that yields to the event loop after
NCR710_MAX_INSN (500) instructions, matching the LSI53C895A fix.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4650
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 hw/scsi/ncr53c710.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57967e7..18da45a 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -51,6 +51,8 @@
 #define NCR710_SCNTL0_ARB0   0x40
 #define NCR710_SCNTL0_ARB1   0x80
 
+#define NCR710_MAX_INSN 500
+
 /* SCNTL1 (0x01) - SCSI Control Register 1 */
 #define NCR710_SCNTL1_RES0   0x01
 #define NCR710_SCNTL1_RES1   0x02
@@ -1319,9 +1321,13 @@ void ncr710_execute_script(NCR710State *s)
     uint32_t insn;
     uint32_t addr;
     int opcode;
+    int insn_processed = 0;
     s->script_active = 1;
 
 again:
+    if (++insn_processed > NCR710_MAX_INSN) {
+        return;
+    }
     insn = ncr710_read_dword(s, s->dsp);
     if (!insn) {
         /*
-- 
2.53.0


