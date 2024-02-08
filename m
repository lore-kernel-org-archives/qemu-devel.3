Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0A8C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 19:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYANU-0001Zv-AZ; Thu, 08 Feb 2024 14:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38i_FZQwKCpsI56DC9NO9A5IBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--nabihestefan.bounces.google.com>)
 id 1rYANS-0001ZS-Ci
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:48:06 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38i_FZQwKCpsI56DC9NO9A5IBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--nabihestefan.bounces.google.com>)
 id 1rYANR-00071Q-1T
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:48:06 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-5cfd94f9433so111091a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 11:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1707421682; x=1708026482; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/dUY9x+67FvkVBEF/XyJqYKGwZN4xMXS3WjbK5pVzbc=;
 b=S2AjgUKHrV7pdHsSVlx4EaFbK7Ke4FHKIUe/rozzJSDQ/2wVXOFMAAD8fPzTRq48rb
 9fjOCXOhDCXna7mU22OAoC24bel+LxSPpgKmbHKd2p8cX3rugngn3cpK3Ox/hW2aa4Vs
 FsbT4MF+P55uiKCiLWrYu9SDrsh7ZlxDbQgoeVcaySY0hPYp21h61yEVrbupKCwSq/bt
 wySfJPpZeitkUsesUXKV0Mkqr9WvkfCCC8nV66ckw72p1ozj7E0DQlqVusNamXAWTucY
 CvroyW0hSsaxab0Tq6ltk3pg7hJeWFTHM4m3GH3pAf9pbdJJiun9ci2GaU30JCjnwyV5
 fCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707421682; x=1708026482;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/dUY9x+67FvkVBEF/XyJqYKGwZN4xMXS3WjbK5pVzbc=;
 b=l2P2+c6Fs8/q83sfTP3BI9db+h3dTykPMlJm/ke3opMapOXHtl6VlDeZHvVIpgKhxT
 /QdUbb8goC1XHN4IY6OI8Isa4roAuSZBBwI9qIDNbT+NniIsR1olWVYw7JURbmjHaTtn
 xrWZESuNQP4YM/nu4E5EJAP7l6ShSd884bANQUPsP/NAcmjAzilGDq3e2FsPr3fn/Mh9
 KvwvuqBHinf8FRxgBgPLxadW0Q2uY/ryaAQYCX0oldkUN8oCvSeRd6tjRWUGAJLDK6oD
 9JPVSE2TeWYBXxpQ4ra7OgvkxDjvuMfFabMRtHSWyCvmCsgxg3rwjITCg2LPDA6DKeto
 EbNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8/4f09zDGn6TtaKftI3chDIIsLkhe4G2U0dRo+YR61FLkLRctxYAJNgLE+GuWbv7WZM+qOMNk8EaMTFNs9Y5WG+uSX7s=
X-Gm-Message-State: AOJu0YwM1EkWa5wlHgBFrmgLNeiwf51QgD8hu6uKj753Nj+p4omAkum2
 B4kE/uPRpr+hNUJV6QzOLETR9xJSeEligoJ0WPuttmDLI+850B38O5+z9+QYTVrh8SLlJCZAzwG
 vFplvNKpAD/rg8cHebCYtiz8+EA==
X-Google-Smtp-Source: AGHT+IG5OKPfZ2YeSNzH3d7SBRKQcbfBY6z7vKn3AUyCnHZDFns78YqnPJdt27FjPkyU9ecJM5GdZAA1hXO8JR2pqhs=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6a02:f98:b0:5dc:1cc9:36ab with
 SMTP id dq24-20020a056a020f9800b005dc1cc936abmr8705pgb.12.1707421682224; Thu,
 08 Feb 2024 11:48:02 -0800 (PST)
Date: Thu,  8 Feb 2024 19:47:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208194759.2858582-1-nabihestefan@google.com>
Subject: [PATCH v3 0/1] Sending small fix for NPCM GMAC test to properly test
 on Nuvoton 7xx
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=38i_FZQwKCpsI56DC9NO9A5IBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--nabihestefan.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Accidentally added extra file to v2 that broke email sending (and was
not meant to be upstreamed). Sending our v3 to skip that confusion.

Removing testing for PCS registers since that doesn't exist on 7xx.

Nabih Estefan (1):
  tests/qtest: Fixing GMAC test to run in 7xx

 tests/qtest/meson.build      |  4 +-
 tests/qtest/npcm_gmac-test.c | 84 +-----------------------------------
 2 files changed, 4 insertions(+), 84 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


