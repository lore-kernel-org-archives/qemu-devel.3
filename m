Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D98CFD88D9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XW-000444-SO; Tue, 10 Mar 2026 21:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XO-0003zc-15
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:02 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XL-0004r7-U6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:01 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c7382731edfso4558754a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193138; x=1773797938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPPKgAKSIfGvq77Pt6PizyKOjmbFnDa3NHU/PwwSiFY=;
 b=dYuiD8LFTb2emoEg/ugwF9+5x2LMX/N76ff4wg4vswNB+NzbDJOWnvOp/sj+5HIoeg
 zeXR1jDPYfjaFwswa86VB/qkT1vJDdOUy9U2BfsUisFm+8ZCqY26yxnGOS7Bi5kqMj5U
 dkPJslZWWof3mzdN1/29T4iAqOQ9nK/Oq/q9h6wbglzIkIOCjAiQfKpHV60qWnSJgrSf
 SXqYyxbTDeniHoXjTn30xlqkiSDYWcXGOWD9h+FGF+enGUVe0NmPBbE5yJcUAPXaEKfZ
 I+9C1LFiUYLvhQoMsHl20DM3d7lZMmd9WzSoS67VOWK8nvebx4sF55jgjAFfATTmeYnv
 2vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193138; x=1773797938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pPPKgAKSIfGvq77Pt6PizyKOjmbFnDa3NHU/PwwSiFY=;
 b=PDM6E3XrbT6t3gVRtaYKz35mtCnO6jqnhCRGC6XiV8mfupBi2fK5o0JWpwxEELoREh
 DNEmjajPsYddfLdLJK1wEYJ1eejTw5qDyk7Zo0NZrBURzWITGaaEWkZ4LHBRXvXCPXCL
 dg3vD3P2oB/ano9Zi0om1+106Rk4cHeXQPnqqR0CzalS1DbDZFMFsMSWNfC2x0T0Rf5A
 /meuZ1EXPWW6zSOgpuKIb09fHywkVL04gSHcHzqXSlsu8MXBhs7peJ2to+ZlaFoRYDC3
 wfjvPL/eF9uZrWmTRX2QFuw0YCCfuDJGbPWqRQLy4DyezYGFrjZSlaoNydxuGSzqWNdU
 xcXw==
X-Gm-Message-State: AOJu0Yw5xNkhFCjjyH2cFMOt1p3Vjs8VrVV3fBUvkUycWaEd7qPf0vH3
 /UtwcR2VoKy7gcUwlXdezBaooyvqDKknoJcAJ1OPmQI82NU2WrOtKOwsIsXjnoB6kZXFj94q9Eg
 ECeGR
X-Gm-Gg: ATEYQzxkSe96xj/q4X8xVA+LwxJKuPdGjmYYfI8627/+LAhXVvhoaVg7ORgO/Ezsvyq
 cpyvLLbmzOn+Q9O6ERKF02nvnnahDnvVRTdlnYnZpEMuy39bVb4WYbp6L2JiCk6PgVbXsPqiNeI
 8NBwTyA8ueMOfv+NMk2KvcMd/gHT0j+iSEIARvz6VyreiU87UAhdniL5TxfGv88mykpKTrrc3kI
 KGo8dNhzHAgmVjMHf/5jao3m5JMethKCaAukyhCdKYE4p42hKg8+j7my6qhDIIOsfIELMFVl0y9
 ueAwZvW+nInKYA9D4NJu+0EhkGiQhyUmFwkVyn2vCFwUQgTNDjoP3IUQMhH78awJDCtRlaPJJH7
 5z7SyBvGmp725O+tTkyOlP3oPcQNesso2orZbnsx1BeXbrkLG/BJIByobo0BIhGpyiZuSniUwk/
 TnsRXiPQKLts1Ibd7VfQAJOUT9zvy1Ay3NsQ07AHQkEgy57tGcScbWnygZMw5AubPS0DlEyWPzP
 ZTOiE2YnglqCbk=
X-Received: by 2002:a17:902:f647:b0:2ae:abe9:b391 with SMTP id
 d9443c01a7336-2aeae7dfbe8mr8984275ad.24.1773193138284; 
 Tue, 10 Mar 2026 18:38:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 11/16] gdbstub: Emit base_register index in GDBFeature entries
Date: Tue, 10 Mar 2026 18:38:32 -0700
Message-ID: <20260311013837.69945-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Record the base register index in the generated C file.

Check at runtime that either @g_pos argument of
gdb_register_coprocessor() is zero, or it the base register
index.

This change pass 'make check-tcg' test suite, which runs the
tests/tcg/multiarch/gdbstub/registers.py test, itself calling
gdb_register_coprocessor() for each target tested.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-12-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/gdbstub.h  | 1 +
 scripts/feature_to_c.py | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 79e47a024ec..75eb4d9c365 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -6,6 +6,7 @@ typedef struct GDBFeature {
     const char *xml;
     const char *name;
     const char * const *regs;
+    int base_reg;
     int num_regs;
 } GDBFeature;
 
diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index 1329695ad04..a52cd2e9ec6 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -102,6 +102,7 @@ def writeliteral(indent, bytes):
         sys.stdout.write(',\n')
 
     sys.stdout.write( '        },\n')
+    sys.stdout.write(f'        .base_reg = {base_reg},\n')
     sys.stdout.write(f'        .num_regs = {num_regs},\n')
     sys.stdout.write( '    },\n')
 
-- 
2.47.3


