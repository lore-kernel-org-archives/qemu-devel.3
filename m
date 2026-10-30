Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E02606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JygeUbFa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrm0-0006tX-Pp; Fri, 30 Oct 2026 14:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlk-0006rZ-KB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:05 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlj-0004nm-8N
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:04 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b118bea471so6253277b3.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386562; x=1793991362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pQAgIw/VpjhY7UIgTqdO5KMEmGk/zD26S1wrBERgqQY=;
 b=JygeUbFaITHs4lb4jBl3QP4Mi3cgQlcz3HLYUQMSYny66Xqh7ntTFyW5v7IYrluY/L
 JnF5HabnhOU+y2HFCBp13REyClyvkyXW179B+v8i1ZjEajoIb/+pX9lCWmKH+TxnOSSQ
 xKUNYNwUTaZElXqXeOcA2qaVUCfoDPCSZw4GKM+Inswnui0ESdyUeXMbwYKyKYg8BeoW
 1la209dT7Vza6Mis5QTUHm6gfDdGFtmD+44L7kK8/+PcNd1RZzYbLLmQCKPApN4ZORT2
 XKY91Dtn3hcARhymBm6NxlqWI39hj9xAYzZIQ6uUZq0tvEYTTKhemxHTT1muw2x6LmXw
 GE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386562; x=1793991362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pQAgIw/VpjhY7UIgTqdO5KMEmGk/zD26S1wrBERgqQY=;
 b=OKaZ3cuNym9KNglbwkO6iSgi3jd9pBIk0/n5prddrWhx/j2ce9B7Kv/+Ykd2fba1xj
 AJDRBLSD0h5V2L2Wwc3ts6uJinHnIf7bURd/SCQvkYq0dA6CwincSKE4gbgUYctgVqzz
 pN1LD6UwobUjqRi7Xi+0ho1JnKar/x8mZHOhEbJMYoWAKXDV01LPb/D8MtOyZeMJNB4p
 ATP0aOk+jgnvsUA3RoeWN3FbDynwYUrhO95GvBK+xkKyfPVtrzoEQKyLB33ZhGomLFE/
 axkKUCduHSWM888knAHosw+vc3iLRXsVBbWrxaQ1UVtTLwn7YtV0Na/i14PnmwGbCycf
 KlsQ==
X-Gm-Message-State: AFq9FYJXpygPRhVch4Tbcw5Ia510260qYV3LJF3jZgtXy6F9qBPBn0Qx
 AUnnOhages4k4oJU8Nfi3aQuhZRcs1+ky/Tv27VPmTeUFm4en8AK3u4NM01nik3fzWH9Sc6q4LL
 OV3Z1
X-Gm-Gg: AYBFou1r2aAqLxVRmJ4rk1gKN2F3Y4ftshdZWIcRiCZ86xJ75FqELnXdeFMeN85Wgoy
 pqPk0wbcKNJpSkPzwdvt6+Ujvq+U2KxA4WoklKzyQMHpDbLT7Vaxid52Lae4ETdCaKmGkWJjmej
 9B2RiOyzk4btgp8t7z2eKj4hFCi4JGf8GGPToL1xK8zu37wtKSXGGDTNXDcGZoUqjWPcuQn+V45
 8pUfPIraLtuB+YbRfuvZH+yrZvztRtA9aSaR/T730iL3ZgqrJcdWt2Rr7lWuRY5+nE21LkKhHVq
 U1msQmFMj3LSkXusktnKEhPM7F11juVgzpMmeiUX2Kc7EFOUqCQhPhj1dD0LgTnmBJ5ohMk2dqm
 NUFQIgKSrSqLO9mTE29Az2BSS3GOadOVC1RyuMnAAggi2NGLxBtIbit14gJphBGnaVNlLQN7uMf
 ktELOdiNOierPU0NBdf5KyhoRr7IckyZ23v0th5VFBv8vUr6eHX9Vknsr9b62tZ2NYx/BcQDF5D
 kDsSrJDZ/Nr30Y8V8tNaWejVD51je1CupmiPxQoQlmfszGi5EwZ+zO1w0M/hz3jzOaW+HrBnfvm
 nzQL9bHro1raVQ9nARQl8Pm8ACwPHQz+AX4=
X-Received: by 2002:a05:690c:fd3:b0:8ae:dfee:cd0d with SMTP id
 00721157ae682-8b2b6723edamr21218807b3.35.1793386561644; 
 Fri, 30 Oct 2026 11:56:01 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 04/14] target/ppc: Use tcg_gen_goto_jc_tl
Date: Fri, 30 Oct 2026 13:55:41 -0500
Message-ID: <20261030185551.193092-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1134.google.com
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

From: Matt Turner <mattst88@gmail.com>

The only instance of mid-tb flags change occurs with spr_write_40x_dbcr0,
which already uses DISAS_EXIT_UPDATE.  Therefore we can always use
tcg_gen_goto_jc_tl in preference to tcg_gen_lookup_and_goto_ptr.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 467b8f3d4e..a99ab018b8 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2649,7 +2649,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_nip);
     }
 }
 
@@ -5164,7 +5164,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_nip);
         break;
 
     case DISAS_EXIT_UPDATE:
-- 
2.53.0


