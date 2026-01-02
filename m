Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EE9FC6165
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0T-0006ki-Ue; Fri, 02 Jan 2026 16:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzk-0006g4-Rm
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:46 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzj-0000K9-3C
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:40 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso19968819b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390457; x=1767995257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxgwJL3StoDNRgD9wJ0r0ZCQoraW4pGC+QLyAjYPHgw=;
 b=ADbyMpovvJoiJpe0ooZyFmHH6y0199qzEcJk2Fc0MJzkUXXu/nlvoOU/I4faBROaNF
 ymFZyzU0PhcsocMbV8C1/lf+ZTYv72D6ZH1P3NMu/fzUUF2bCnzIN+iFiKKTOKap+zGL
 s2vL6FKTYLE/Cif4qFcjQ69Y9+KBjWbfv2adqXr8E3G+AI65rQ+9UFwFxMIdw7V0+UL4
 TOngkLfANzW1yeIC5cTBo0CKTEghYRvALCkjvD2rCmw7bde7Ob8ZBWr9JiFSjQhum1sm
 aEM8aflZ0jgKvya2YXrxMHY2wmgtl43PGa33ZmUMbxmeF2iO0dfmfmzbfq52AnPUPxCS
 s3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390457; x=1767995257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KxgwJL3StoDNRgD9wJ0r0ZCQoraW4pGC+QLyAjYPHgw=;
 b=iFjm72OCrdxuFcVULFzwicva3e4tHoBa3IzFLcj58GIXZljfwWYvcSlFTyBxvtxUe4
 RR59QVjAAmSnZXNIPhRVF2/e+hRWRgsUU5N7p32HAuHIROIy9jkj+ZvWaKP3JaEYcUeV
 B2nNgJkrJGxTv3Itj9NT3uVAD1e0cSFHZm21dIfTbLHEDuZO2RrhgUn2NQ+H07YmqlA1
 7pyMINi6hTrrybHefgIaUU+0rd5hKZQuZgM3ku+NDBfv4+wMB8cKhxsFGMag4hNJg84S
 4PXx7e4a4l69OU2gLgo+rbpNllC9FV1iEFu6VeU7P4JIgVVwptpeDVMtuC4KRAvZDblw
 5YlA==
X-Gm-Message-State: AOJu0Yx7PO7CM2AqJtj9e/IcPoNIxQpPfXHXM40Wiq2+Kh0/fyGLBZYS
 UDEXgH0aUh0qKh5ec/9eaZXDHsHqhvNmt9RZaH9FR/BmOzmt5HQYmKLLOWlaJfbF3hNKVRNpBVu
 A08qN
X-Gm-Gg: AY/fxX5XOhTflGvh06g16dbJXtjiD2nJjeAGn42EIm5gmRXpo/n2kd2pp51NNSwtPxm
 0CHQPvk/RgKFe9+8XMpse/zPN/liNW77IKnT+uCXPqa7eQTw4TuoNKMlff+Wr8bG2z62epO5t41
 mx7MefSk6nq4zEfsVLowV1Lj/eMCOOYDdHLMq84mwGTSAqb9Z2RIBpVMqCeRuIu099L81K09bDI
 ePJ8gC6DPP1tJQLszx0PyjMqCmLkTHze0AevJE6r80nXHNk7S62oTObr4QvUCGui5razuEYuR1U
 fX9QWvdJTnzsP57ijTUOkgOzcz7ZzigrWHH34/LYcBuPhTu7db2umUMgMzW59mmGbP0J/uikEHx
 nBcF3Q8/o7Z7K3uOvsq90Y7z0o6FFtle2YFVG6QZM3DrwTgce/4sZ2CkgXfNfkpXkcIGeSAb6fE
 J6tSTGWHoyaAY/CxOva6rhA9ZpGsCDgxsoIrmwPKfQybNe+2OySO07YEtj8c8yG+GX
X-Google-Smtp-Source: AGHT+IGUQ44mgkPALkP3KtQiiat2+JMZCMtQpmetkD/xMs8kHu5tVlm8t/7edF89M2VnWXD9kOY1QA==
X-Received: by 2002:a05:6a20:6d08:b0:387:5daf:b302 with SMTP id
 adf61e73a8af0-3875dbf065dmr4847560637.65.1767390457550; 
 Fri, 02 Jan 2026 13:47:37 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:37 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 08/11] meson: enable cpp (optionally) for plugins
Date: Fri,  2 Jan 2026 13:47:21 -0800
Message-ID: <20260102214724.4128196-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 256cc0cdb21..38767c2c68a 100644
--- a/meson.build
+++ b/meson.build
@@ -77,7 +77,8 @@ python = import('python').find_installation()
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
-if host_os == 'windows' and add_languages('cpp', required: false, native: false)
+enable_cpp = host_os == 'windows' or get_option('plugins')
+if enable_cpp and add_languages('cpp', required: false, native: false)
   all_languages += ['cpp']
   cxx = meson.get_compiler('cpp')
 endif
-- 
2.47.3


