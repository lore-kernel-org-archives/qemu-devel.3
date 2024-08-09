Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E1EC52D73
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKjo-0005Z8-Hn; Fri, 09 Aug 2024 04:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1scKjm-0005Ry-J4
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:12:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1scKjk-0006mV-9i
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:12:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc491f9b55so15236225ad.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723191154; x=1723795954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0akk9tyfAh4jdZDvZ/G+t9QiEID+7sYMlv0pGeXDRA=;
 b=KInpY9NAAfrlISj/Go8FGbF6N/8fvLUUt5Z/iBGHesNN0o81DIzMtUxpwL/gw/rCX6
 tqZc/qPfCQHJdIJv/SJWodmaeLmDQRAa6Zs3S9QwmEBgZJKNwPN0k1PrrYmuivcEPILt
 G/EwJ6cH5QDZ/WLsOYFF8IF37LigPPZ+DjdaXCPs8A+Tv+Bqr/lQNh01yhwwuiXZ12Ei
 bJXvIqmPcGbQYQBuIyxBTy1H3493mqjR9YOnvZAKk8P8bcJT1+tMjgKlxgHs1fMGM4Xm
 KKoFE5bq+XJ/lODL2IAtCFOAWtwPjSJ94U19aRuIeRoVykMWMP3BdB11m5QsYIPcgi6V
 c4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723191154; x=1723795954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0akk9tyfAh4jdZDvZ/G+t9QiEID+7sYMlv0pGeXDRA=;
 b=bEc/6E5tEoj4NDJks44KCUoIMD4FghU1gmLXGULi1APusAuEKdRieNjGE6ddXoj+MH
 43DTT4z8u5dUTmHF95cO/oTw02wi/WU5csK73/w+j3e7sgkDQNPjfCZRrv2gNzXbW1yR
 R7YBYT3Gtqa32JZeYbpOBZxnVvkD1AaMwpJHMS3ppDuuAf51Lkrjali1wzBi8osidt88
 tZdLKqV62M/LuHQPbo+4tRXAHxNVXY9KxpYGBoZB3xCJDd8eDKLP9DQvQhbgMIoenb+p
 jpwXnnIIEKeHC+k/7uKET4dxFZ320+gFNwtGE3UxAa3bQSGKDxldPQx6VrES4O7HIi3z
 UpmQ==
X-Gm-Message-State: AOJu0YwuFZb/geyUjvUeCz1dDIblTh8CxLzWAe6GR5gFA75Z2mxm2nAI
 4ANddfCK2L9JlgVHyebMcNXQEs15oRNWDSH6xOpbcQAQDJr+UgX7Rf1fG6sLVhEw/2KrmTkPEEZ
 Z1hbLyUzyoDoCEwy+dyOEoVpbt+C1g0N2fUl20FQ8KVJAoy+Poye+kvIblzBk+Z3dGjX08OqZhL
 V6z3E3bQ5TKqzm7kqy27W0b4RH+OUcnoHRhPcefg==
X-Google-Smtp-Source: AGHT+IFNx0RIqB+bWlhV26lfOXNTWY3R7BP6Yqg3janFpP+XZj/yfkm0e3MT+WqlaBQEtZIoDEZmcg==
X-Received: by 2002:a17:903:32c6:b0:1fd:a412:5e05 with SMTP id
 d9443c01a7336-200ae5de153mr6428595ad.52.1723191154053; 
 Fri, 09 Aug 2024 01:12:34 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592b6cfbsm136391185ad.306.2024.08.09.01.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 01:12:33 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v5 1/5] target/riscv: Add `ext_smrnmi` in the RISCVCPUConfig.
Date: Fri,  9 Aug 2024 01:12:23 -0700
Message-Id: <20240809081227.1588508-2-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240809081227.1588508-1-tommy.wu@sifive.com>
References: <20240809081227.1588508-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=tommy.wu@sifive.com; helo=mail-pl1-x636.google.com
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

The boolean variable `ext_smrnmi` is used to determine whether the
Smrnmi extension exists.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b272fb826..ae2a945b5f 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -125,6 +125,7 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_smrnmi;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
 
-- 
2.39.3


