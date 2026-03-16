Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0182FB5E88
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 23:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2HEh-0002Lb-1c; Mon, 16 Mar 2026 19:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2HEc-0002KU-Qk
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 19:20:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2HEb-0004MO-2Z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 19:20:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ad9516a653so21457385ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773703227; x=1774308027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YELrT0pPWhUItmp49HbOYdttN5pDb9h2gD1J8kFIenk=;
 b=vDO8RY2RBwsjUkmB5ZlgafngEbo1R+bw/GRA5tBK71uEurrvGFe+Tek9o0N68g4iQK
 iZ+qlOzis/M5peNmb0OJ3S8BgSdzjE9G1Co0Xb4D6Vg1fhFLp6tbYKWtKLvxumxOAx4U
 3KDCg0LzzDZHpCdzCZEkyVNWvIuaJ3oLq6jhwKeMoG1mj6K4b1ChC8FuYx3/8LeV1gsv
 eaUUxGHSsisVKFWKjx8M9n3CKuvmcBdpB9Cow/YMwlRe/+ps/MqCRjxFzBc6T5P0EBzZ
 9BI/hFi5y5lWuCd2Pw9Uspv+GWYiNYr+hsUBYDgb13lYrEHVKZRTIAPC2Mz245NgF5gh
 mMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773703227; x=1774308027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YELrT0pPWhUItmp49HbOYdttN5pDb9h2gD1J8kFIenk=;
 b=OwwYdBGCwAAzKWP7KCDfW6sZKkX3j2IQwrDjmK9iZdi6tbBvRoYvWA9q58Blr36k9x
 Na4jjv4Drl3QMCeNVQnzp/k9ojQZD0yiKka9LkI9c8TWLRo14lxNO/fFn64iS8hq2esO
 hgWY7hyBzqJvmF02zdMgpBWynjl21MRzc/YsqITWIOZHIyojRPGSd4Q/TpkKc6EoqjvO
 w+ik7vwK+Y7kEMGirKup1XXOcdme8kFTeWmDHs74Fm2PGRIkaWPsYVrntLRxrf1rlHCy
 CXo0CliI+7rmvkukuZhagLUWidK48yLzI4pXUS0TL7k8jp9wLVd77boI73ZOHCuw07xq
 zHAQ==
X-Gm-Message-State: AOJu0YyLtwpv3y7p72SYELjFyVv7qT0WCuLxkfWbm0xiTePs49wF4ydM
 E9JHylfOEDS18ztG4EDZ3bx7i1FqEjgqZc7uiHAVXdOuRQaWf8HP9ZUmp00CAEE0a3UJtGRp+Qa
 0WNZgw6o=
X-Gm-Gg: ATEYQzxlylS2JtguC9Z3W4YZ66GJguh8koR2fA5k00zgo2fDcMl60+9Q2TF7q+ia+n7
 PMLmp2h7cI4Vbqdi7KOLUG0Nd+GXCwwaP6knvcWHpN+n52UVzIwA/C7NxeVQJsZfe7HKDN8vrWN
 ta2c2twk58BKfpAwxCj8RuHIMfXrvJAwh6rKHcsYRhxouFkgf1LWvd18S4xZb/DYmyy45SMoA34
 Dy3ks08f6vlvbeX5DC4CtJCCa5ulDUWYz4T+BqhlfOdXWpShclm+eidval6GpJlCNjdu3I7c4Ob
 pczN7A4ip1+OJ0HuRC1uYXZCL7rEKWxclSSCVcTP2pVfa1ULXcmJI35Hu4umZD83tnb/idQIlVJ
 GVTQgjJK7lZ/G7fIBldPwSGU05hwm5pujufGpQcGFAxDV05Vb+SYVVhGul8FRWBVul0f8BDU4sN
 vW2T/v7puQ+uAdI4yyZ4CbzNpXgfoJo6hhwq7Wa4rclQAo32EdH/G6qZ+z3KzZgYj3QJ4two72E
 szd
X-Received: by 2002:a17:902:e842:b0:2b0:666f:4296 with SMTP id
 d9443c01a7336-2b0666f462cmr1436955ad.49.1773703226985; 
 Mon, 16 Mar 2026 16:20:26 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ee1d8sm125247995ad.55.2026.03.16.16.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 16:20:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/1] Plugins update for 2026-03-16
Date: Mon, 16 Mar 2026 16:20:15 -0700
Message-ID: <20260316232016.455394-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

The following changes since commit 559919ce54927d59b215a4665eda7ab6118a48aa:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-16 13:07:33 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260316

for you to fetch changes up to 48221e371686f7704f150aafe46b76bb9306c7b6:

  contrib/plugins/uftrace.c: fix depth for exit events (2026-03-16 16:19:18 -0700)

----------------------------------------------------------------
Changes:
- [PATCH] contrib/plugins/uftrace.c: fix depth for exit events (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
  Link: https://lore.kernel.org/qemu-devel/20260313063441.2048882-1-pierrick.bouvier@linaro.org

----------------------------------------------------------------
Pierrick Bouvier (1):
      contrib/plugins/uftrace.c: fix depth for exit events

 contrib/plugins/uftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

