Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE84C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFL-0008Tu-2R; Thu, 02 May 2024 01:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFI-0008Rd-Pq
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:41 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFA-0002ey-PV
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:40 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5ad21f3e5dcso5165902eaf.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628671; x=1715233471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6kRDMy0sQWoEwNjZBte06pFXGZWoKm5T0LNfV/1PDg=;
 b=e4+t25D8vJmeBiMOXVuMvKIZJGvpcGKaU8p3cn3wYGDViXiBhi1CXBfLldD8XjBS2f
 9sVKOGq7Gs9poDpSPnpd8Fel2vJSUw6PJxYK9hQdif+Jwt+MPux3MpkSTj9KUNVEIcGy
 AfeD0yBEGLwiV/c3wVB+DQ/ydPu2cbZL/XBQ2AuKMjvdFz+Fpk4oh2UMkKpxGcktnD44
 kYvLqFmzOg/5+b08SxchZqdesQr3BUORI5OfzhePEv+WucbfEl8IW1Q7DL1d36x5Txeu
 M3dfC+imMaFTecQsHu0/vK3ka5KxnjE5e1RYV8mxq4bP3XbicZ7aQUzjYNwswddAjf79
 hhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628671; x=1715233471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6kRDMy0sQWoEwNjZBte06pFXGZWoKm5T0LNfV/1PDg=;
 b=RcPPK5HGT8w0KOIcumKqFa86a9iLDoDQf8G8BhxN58/erCLKLrY0aB1FBPfFoDH2QA
 BPpdW1vO37e2rK8NoeegG61rajwKjcL8nhKbB8c7ewHv7yFNo1HgQaGaEm+I3xN84sty
 z3EtPcBbabe7BiidvQEOPwsGbu81trEZCeNM6dOCsp+26VuisRdlqc9wi7gWMiyQGTS6
 klUfa/LXx0dmn2ZLQp0GDD1xcggNPNr2LgBKV9ZPy4f5v+SEptXWpDEz9ZaU31w+Xyd+
 UJXvpqxIaBbzXv9AwU89h1Bv8nk1G3dqY9h3qWJAQL0U85VErq6zKvJobF19/vodgHfn
 GF2A==
X-Gm-Message-State: AOJu0Yy47WLW5jd9EnGD0EyrCakqjMbK85YpRKnI7kk3wunj5yT+YlOY
 fgX6KbdHOqwJtoxibKiu6ayfS6UqEyTUv2p6Pn4Rbt141mfLK1MDhm7x4os3RiWoFmMD/eysrym
 V
X-Google-Smtp-Source: AGHT+IEOSW7Fzmi2+dIupl6dV9+qX7CVVDfOdKm1nir64tlupKl4kkOY5ey2yKHX4NijdmUlzNDI2w==
X-Received: by 2002:a05:6358:3408:b0:18e:b11b:e770 with SMTP id
 h8-20020a056358340800b0018eb11be770mr5227948rwd.0.1714628670780; 
 Wed, 01 May 2024 22:44:30 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 11/14] target/s390x: Fix helper_per_ifetch flags
Date: Wed,  1 May 2024 22:44:14 -0700
Message-Id: <20240502054417.234340-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

CPU state is read on the exception path.

Fixes: 83bb161299c ("target-s390x: PER instruction-fetch nullification event support")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 5611155ba1..31bd193322 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -361,7 +361,7 @@ DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_3(lra, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(per_check_exception, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_WG, void, env, i64, i32)
-DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
+DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_2(per_store_real, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 
-- 
2.34.1


