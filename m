Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92DEC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojYX-0002Ja-QB; Mon, 25 Mar 2024 08:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYS-0002HG-QS
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:56 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYQ-0005dO-Nw
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:56 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4148bd2ce39so2075215e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370153; x=1711974953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aGhWsSP/npTCiFe/sHrNCbxR5PPjNjefjYSTRbPwF88=;
 b=Ygo1IaNH6FB5YXtSobiQEt8PzoNuvjYhNUE0vp/X+iAzTm/FcGTJ9FwmOQ+RVDImM9
 FpSERsaIE9OthTglJM9qukogC9Er2aUb1m1o4JpIGeToNxuoYH21/DcJRloZLuIIXMxA
 F7agCAnX3c7HmYxWd6MJo5qh4F8p/TCW06OJrqx7Dsq+FrZiNoaD++bDbsHMGb6e89n7
 B/2f+mPag3y13pJsERp0aokbPb8VFLM6ePKz41nEZ3R2jOX7YitSn+FAHl2slgbaJH4z
 fJlLNcWBAYVf4/FZUDsTdd7wqLSV7EZh6WTZ2JOPxPpzLJ41eu0O4VjZV4klQIvakbud
 pSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370153; x=1711974953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGhWsSP/npTCiFe/sHrNCbxR5PPjNjefjYSTRbPwF88=;
 b=ok5wVQ5CXiFti2jaeOodjrjpE6CZ9Bl90/jsCIkRwfvnCgIiokYvpbhR1R5vw+AAFs
 u6osu6VOGL5OoFKe9Y+By4ipVoPVZzJ/fq/VTizGi/zSaEwRiM4PSvZmSpBdJApAcFam
 xcLj6Vz15Sy8X2uuEgys3rFCuW38LfAsBmfoHLpMrVqnegQnbZKQDFEsVMHYeA6cpcu6
 CCurC9145QyR6G2uZamJdcBGkVsa7xv7AcrxSBxoS7jsI1RCDW9qagodRyKDzVyA4KRb
 jqDc84HaVDTRWAo8vnvjuU739z7gGyBIWviMwZARBikh0DdCfKW8cndMxZXLJdkBa5MQ
 6Juw==
X-Gm-Message-State: AOJu0YyyvsOl0XTXtRCjQRNKeDi8lY84LX8Pe07RVoDB7ZSzWzD1B3Fb
 OV1qn98XOItpBtlrIWoevTLD1YmAIelQG9l/l1hMkOJtVD/lANm8tF+ahT78nmwCaT6x430awm7
 w
X-Google-Smtp-Source: AGHT+IGPkE4pZV9wBlViscRjg8FwWPkFGu4Q3ONXbnxawSC2IxHR9Y6r9g3WFqH3NIs6lCbfZQJmEA==
X-Received: by 2002:a05:600c:4ece:b0:414:6c72:8df with SMTP id
 g14-20020a05600c4ece00b004146c7208dfmr4809223wmq.38.1711370153346; 
 Mon, 25 Mar 2024 05:35:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c339300b00414041032casm2303877wmp.1.2024.03.25.05.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:35:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] net/af-xdp.c: Don't leak sock_fds array in
 net_init_af_xdp()
Date: Mon, 25 Mar 2024 12:35:46 +0000
Message-Id: <20240325123550.1991693-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325123550.1991693-1-peter.maydell@linaro.org>
References: <20240325123550.1991693-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

In net_init_af_xdp() we parse the arguments and allocate
a buffer of ints into sock_fds. However, although we
free this in the error exit path, we don't ever free it
in the successful return path. Coverity spots this leak.

Switch to g_autofree so we don't need to manually free the
array.

Resolves: Coverity CID 1534906
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240312183810.557768-4-peter.maydell@linaro.org
---
 net/af-xdp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 38e600703a3..01c5fb914ec 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -446,7 +446,7 @@ int net_init_af_xdp(const Netdev *netdev,
     NetClientState *nc, *nc0 = NULL;
     unsigned int ifindex;
     uint32_t prog_id = 0;
-    int *sock_fds = NULL;
+    g_autofree int *sock_fds = NULL;
     int64_t i, queues;
     Error *err = NULL;
     AFXDPState *s;
@@ -516,7 +516,6 @@ int net_init_af_xdp(const Netdev *netdev,
     return 0;
 
 err:
-    g_free(sock_fds);
     if (nc0) {
         qemu_del_net_client(nc0);
     }
-- 
2.34.1


