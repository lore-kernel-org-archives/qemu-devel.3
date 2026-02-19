Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0206AE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9Zk-00085m-CM; Thu, 19 Feb 2026 14:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9Zi-00084m-9B
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:34 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9Zd-0007dJ-RG
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:32 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so847487f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528827; x=1772133627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nM2sRABQ43KRZ+QKd+NkNVefJG6jsCwk1I8dr/jZgg=;
 b=DClkk/FxGk5TzBsjZzzrQDKaj3/aw93VaMuuDJyyBC5HGDa9UTUw6N7+Tlh9RANrqp
 JuT2t99RZF7jSmYdZ9gkmbUiydb1Ipkrtw2rcd0e6gMXo7YSbAgMsUSkvmtaMYF53ZRD
 dPIRukgvlfx/w3vuXeHQVAZ0AYqQPmKQ5GJfOy6pGPMTHGz7DyfmbmZpPCKvTC7wUVkf
 QFQHEY8oWVVr7OcqU89tWD2qWw1iEbct21PC/0dXg3XznYtVQ95C9ZORJIfNDpA5rkMw
 11drveeBFyWMl0EdC973nShkQRFbp8HC9gBD83KGyF2UFYiCkFz54XL9Yd3PGLaCxeKl
 1N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528827; x=1772133627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7nM2sRABQ43KRZ+QKd+NkNVefJG6jsCwk1I8dr/jZgg=;
 b=vbgUQJUR+DK72FZ8mU/t+PLvZ6WpS2V8T18vU/0znTvAe5DfTs4/33DPXwx+vbPz/C
 NLSusoTP9dheM522GmFVv5Qwpl+cyOUiyszygdxadX3/I7rqOlngh5V1GR+q1Euz8BAo
 j+suIWDW6TEJR12XiZQFMMt4seNTX3fQGP/qPh97nqyFqPvq1Hpi8YFNE7FZ4RFj1kJ9
 hJHCqakbfvWVJCQaCi93OUJfIKmdOMDUHqQxXicx8SwbCjNDWkLIu1ijwTw9h9tPj9We
 b7GNQ6DbFoYJia2MaECluY1sVH1kYaNupwTUOy3ViqdgIUKpd8XSN9LHOxWSpn+mnuhw
 ckLw==
X-Gm-Message-State: AOJu0YyLciMgUIP8dBc/JehNEizBOpeivjAuwLUUC9+sil4p7pERs2QG
 nEE8gUvotHzxbRfHfKi9Vn0le/6kJKld944L3g1Y+3HadswBy5v7sGcdXATbAK7O3nVVwdAZCXM
 ZErdqfP6u8A==
X-Gm-Gg: AZuq6aImFz5Z1wlHE8Yw3QfuIahsKFO2J1Q51s2cAtwNU11w0MCC+VOTiyUM/wcq81/
 TK2X2M59B/DFmNIYah+OE0C8z3Qjpryz6Sq2dxbJc5CSbhQ79Le8mt7uTWhSur9QjHKp7hv7IeH
 JNYawpHrkmiGCQmPTfDXhmaZ0jEJ9zmfOsY7p3VjYldW49OlNFlmZb6L0wl5skXOYiDpKgaqt+k
 p7Ku5K3XeT7tk46BPHeIIkM1U4ZN13CvJWYAEIGpAkOOrcGk0jb2Qnw1BDuQLogjloVDMGhHotr
 GZgk/9IxujvTV3mvNqU4J+NxKJOYwGfa4jIyDOwjy2V1EcPHPspYjBLXmSf+InmsBddIc1zMxDQ
 osEr4sNp1LeB9oovfe4VoG1n5UGsQ2mrDeYa5pAIa1jhTsTaUvPCdrA0guQVmZI/Lz37S7k54vu
 QYVt1bZkdoQkCX+pYhAjqd2XcW31Fz/E9WatIqUN36FCJI+PFdWNP1FRi9ugcZNez/PTwkYX+7
X-Received: by 2002:a05:6000:2511:b0:432:dc1f:6982 with SMTP id
 ffacd0b85a97d-4395fd35462mr6578056f8f.16.1771528826755; 
 Thu, 19 Feb 2026 11:20:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6b563sm50560383f8f.12.2026.02.19.11.20.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:20:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 04/50] target/avr: Fix typo in gdb-xml feature name
Date: Thu, 19 Feb 2026 20:19:06 +0100
Message-ID: <20260219191955.83815-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

While GDB doesn't provide an official XML for the gdbstub
protocol, it is still better to name it 'avr' instead of 'riscv'.

Fixes: 12b35405476 ("target/avr: CPU class: Add GDB support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdb-xml/avr-cpu.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
index c4747f5b40e..926cf053210 100644
--- a/gdb-xml/avr-cpu.xml
+++ b/gdb-xml/avr-cpu.xml
@@ -10,7 +10,7 @@
      register descriptions.  -->
 
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.riscv.cpu">
+<feature name="org.gnu.gdb.avr.cpu">
   <reg name="r0" bitsize="8" type="int" regnum="0"/>
   <reg name="r1" bitsize="8" type="int"/>
   <reg name="r2" bitsize="8" type="int"/>
-- 
2.52.0


