Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2C606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PMJ54SHV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrnN-00084x-8y; Fri, 30 Oct 2026 14:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrll-0006rv-W5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:06 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlk-0004o7-BH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:05 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8a83d2706fdso9777187b3.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386563; x=1793991363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5vcJ8YC/IHF2rwvCfFaTnD7lBd6nhIEwffs2J1zl4ps=;
 b=PMJ54SHVlLZJu44ynjukrmkmFk7/0ihVMQfEmjOOGWZ1PBeSx23XXXYiPPZgoBcJrb
 rDiuv2cl4OfE9tWc+IX0TfmvK01S7aKPRx612qRVZ/ISnUdYu2oIA8n9/YPw7XVeE0kv
 Zoy9DU85X/MaAZuy8oD70bxF2RTg7co1K6naYpmCbAuO5FjUlxJeOzpKgu3nIzbw9dqB
 TNWFXDF+WaF+fn8/bw//6DzaoXusUVk6ZXqKpyPioCnDEYFdD6hEipsYcMpopD0AupSu
 fx8LJVdV/VpzHa2qWgAGObjHkLUBcCZhVeuq6jhE23G+xPAwl88RgiTLbUskjMdEr6KG
 xIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386563; x=1793991363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5vcJ8YC/IHF2rwvCfFaTnD7lBd6nhIEwffs2J1zl4ps=;
 b=2Cw6gRdcqQbG4me4WilyQWH/Q84/FpLRPHxTZZk58PmB2d13Lez4hj4vrhgmFJUAQD
 xhzIpexdAWIIvi0sSTVGhGh3/FfAgj2tb+optOB5OqdETdt6MC7DyHAkp2vUeed+/C5s
 d4u6k73s1ai4QidH/LmrSCjc/72S7AwaDjOFVzAEQc3DUGj8xbaHosCWHT78P95seiZy
 CZiB/05u5A1+Dt9jP0WxT1y2jQVua0GKrcbjK7zz1RqvrPsX+oDIjDjcSAGFECtamKNh
 cmt68SCV9GUUlW/T0vysm88JzLDyv0+Y1DjyKeZD7Oadw5flsyGRK9i+TY4ggoaf0LSF
 zJ9Q==
X-Gm-Message-State: AFq9FYKmhMV+yY5VszafQtgI7eO78GaJqWxhX2qaDZFfU2b/uP5iwdeb
 IsESdlvai332UAejyuaw4A+eDIHaPa8cFbdFlQ+88Bu9YoC54C3PrwBNP3aqF1UAV2s8VYeP0EN
 s0vqI
X-Gm-Gg: AYBFou0R5azhVSa1gpP9pAliVTHuWzS4hxgks5Na3z11HXdRdQVbMeHUCK4rrhZ+aSJ
 glVAw4nLewy6tNVLqPyLxTqeK3I32RAT/NUwNqJp6oC9KMJWDiYWUjaQVeJTMhykY7h76M34Ktk
 g3rxX2THOhVfDIoNQt1v6kohDkZqMcnonjEjEDDNCdfu1dlseRJWxb0NFOEknn8qA50U0eFFbuY
 6kzqt7B9U1r2sMbdympWgwmPa5eO44r1EaBnYAK6pqrD//qBfN5k+SFYgjm+fo0bm4Tdw4rXtqp
 zdC26D01fibJW2u5XAW3a4nPT9CQ71UBjRVxfKcrFP6BQc+IuZ6XoyeAQEdxYh+RKohVTG10AhL
 rVUY/dcuG2LOBDjY5QQhlnCdfWmzBF+r0jjKHYM4c/YCOZK6dMWkiigZNI7v1ZK3rPxzehEGgQl
 /XXEEtBnaJTYjKpwwKU/CGJFrAZbEI4SwnnizW4Nw/oUlGCuJ953qYdF4WMJsKoxvrw1P+RBlPV
 dIWxPYHCb5d02bdb/4UBi4sPkXdeghyAYAfQCkL3bzjBY0LG5xu2GSNrWx6BJv+kK9QJP1XHzVn
 effY2Hxi+Fsj+bQp+lgVlSMFAMRNYx4fl70=
X-Received: by 2002:a05:690c:e0d4:10b0:8b1:691f:ab4d with SMTP id
 00721157ae682-8b2b66e9a38mr11817957b3.35.1793386563044; 
 Fri, 30 Oct 2026 11:56:03 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 05/14] target/s390x/tcg: Remove DISAS_PC_UPDATED
Date: Fri, 30 Oct 2026 13:55:42 -0500
Message-ID: <20261030185551.193092-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This value is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index ce55edb93a..3a29555605 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1025,11 +1025,6 @@ typedef struct {
 
 /* Return values from translate_one, indicating the state of the TB.  */
 
-/* We are not using a goto_tb (for whatever reason), but have updated
-   the PC (for whatever reason), so there's no need to do it again on
-   exiting the TB.  */
-#define DISAS_PC_UPDATED        DISAS_TARGET_0
-
 /* We have updated the PC and CC values.  */
 #define DISAS_PC_CC_UPDATED     DISAS_TARGET_2
 
@@ -6397,10 +6392,6 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         break;
     case DISAS_TOO_MANY:
         update_psw_addr(dc);
-        /* FALLTHRU */
-    case DISAS_PC_UPDATED:
-        /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
-           cc op type is in env */
         update_cc_op(dc);
         /* FALLTHRU */
     case DISAS_PC_CC_UPDATED:
-- 
2.53.0


