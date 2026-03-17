Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669D5FEDA16
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Zrl-0001B5-AB; Tue, 17 Mar 2026 15:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2Zrg-000182-TN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:14:04 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2Zre-0006QL-QR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:14:04 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82a15b44c3cso2504487b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773774841; x=1774379641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jZ4FzxIFpCxFELnw+pMn0ZUhH34R92SXOQ3lVaEOWWA=;
 b=liomumppGu3t6DIqaq2QVXpuJ/tlkisVK7odtSVgi4WzXZ/qUxMru3J2tt5xF70zh9
 wGGCsEyQuP+w/s6d0xsMwcTPp3lrt6OshMyEBaTK8r/HwKKuNXkvOG8XQCaIF6oTW5Sm
 IPypKXcFC0qPAbx99cPE9C5MkUyAfYkoYEhMlZAUP34bLAw7x2wJriFExgaF/5HmpNa+
 7O0fV+ogWXs9mYvlruuFQd874QkDdYNtxnUhAUuBvJcA4VGd1Ilw06hNyq1RF/FoCcKM
 wHlhLVs9VgtYM0vJ9gMCCN4MgsivR9Ij2skb88OdVOXDiLYUWB3aD2VUUZ4fnyOwZh8i
 Icdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774841; x=1774379641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZ4FzxIFpCxFELnw+pMn0ZUhH34R92SXOQ3lVaEOWWA=;
 b=Wt4mefkmo6vlyxty5JJeAUt4f98U3qvFs++jMaHCmV1tgQdvSwQIwk0LvaSPhz3e4U
 Bja+BO642uaUIvuLmRKE+Pg2T+ospfRH4qW0I1xJjYoqK3g+HqOXqK/965LJAgK7BkXU
 fCD/gisB2GCoXR04NCcR83WD/fvKXnt2E5Wf0AdRi5XQec6DoG1SL3DnOD44R9FRNKX3
 A42hwsUldL7KZCT7eOK7xF2BaPDvxmrmWiXyCE5bugTgbjlRPWbAJBb4/TFF2n/hX+/p
 8P5eHgCqCEONoBrPksycn3zNI9vk8bW6H//SRXNsl8UkD7B2m9djHyd8zd0sr1rJPVc8
 sDZQ==
X-Gm-Message-State: AOJu0Yz8vcH3jXjvdOCHeQ7bIIu459mHaLIQiYuzOjzQv7rv++d+zOFP
 OSfJP8/Mu/5xQY6p8uzdU0cBL3I7nXg5NtfoaPocUZ5OzNe4935xnGDdlwopfeLRGp2aR90JIp2
 6cm7rJYQ=
X-Gm-Gg: ATEYQzx5n+4o1QM1jOLT2FG2iobr5x/vi74/tF+s6MY8kNSY3rJX6AkRqYJ6KEHgwid
 hzWbqat6OwqE+yxgDoPdTWXAXzvZUabPDzPkjHzyE61bbm2Yty6D0SuuiWUF96jz1XAAmEft2EN
 9sKUqTi8jBX5O/H+BG4nPNqMALhGaYvPoNeFnmu9aUHwsbBLcFIE2Awgn7Non1/M7m1li0ddM32
 L/TGusZLib+dvJdJ7/+hUi0tYRaBe/PlzDQAhu12pPuFPO5rfe66KWGHucAHFvUn07eXFB4ZI1F
 jPnLlclc3fQNT9JCA7szH+Sz9QUNrJFb9od7OLXpIzy7VyhrfgZdYndROGhxcxYyFuPFvNSBw01
 H+Ceknn6EandsfV1TPicu/g7CqdGrrHyOcNDjPSX06RpXW00tdeZwT+wVu1IMn0hGze9o60jyit
 vtzsA7gGR6Q880F3dnm/6NXGSHAXPWp3jtLUw232MzRcEs5DIHPqiLrPGYQPxog6584ImbQsmYi
 3TD
X-Received: by 2002:a05:6a00:e12:b0:829:7245:92f7 with SMTP id
 d2e1a72fcca58-82a6acd26camr431203b3a.3.1773774840632; 
 Tue, 17 Mar 2026 12:14:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6b56de44sm217490b3a.19.2026.03.17.12.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:14:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/1] Plugins update for 2026-03-17
Date: Tue, 17 Mar 2026 12:13:55 -0700
Message-ID: <20260317191356.844712-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

The following changes since commit 6667668e0cf369e47aa9dd0bae40989896e9ed9f:

  Merge tag 'pr-plugins-20260316' of https://gitlab.com/pbo-linaro/qemu into staging (2026-03-17 10:20:30 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260317

for you to fetch changes up to db52193355cf75394a39ca9f70b1325d4bbe18d6:

  plugins/api-system: Handle migrate_add_blocker() failure (2026-03-17 12:13:16 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2 v2] plugins/api-system: Handle migrate_add_blocker() failure (Trieu Huynh <vikingtc4@gmail.com>)
  Link: https://lore.kernel.org/qemu-devel/20260317134733.126584-1-vikingtc4@gmail.com

----------------------------------------------------------------
Trieu Huynh (1):
      plugins/api-system: Handle migrate_add_blocker() failure

 plugins/api-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

