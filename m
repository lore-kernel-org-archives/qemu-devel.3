Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF77C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbL2a-00019i-Ne; Tue, 06 Aug 2024 10:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbL2R-000168-4U
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:19:48 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbL2P-0004RP-DF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:19:46 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso1116458266b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722953983; x=1723558783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FMOBByQTuB0kCr54Tn1SiXD/gk4GGph9q20Pk/9oV3w=;
 b=DCOgigUraxR9bRKdIWS0mcOrJGh1RvZq57TaldoYUSumHipPu7Wrd7pLZZuqpG7QPH
 suX+Y/n6DejOLoVPI5MrchxrBLdl8gbA1liHagd1a8GsAchvRhDygGHWj8DA7R8wn0aD
 4VPOsO+PQpEZdyI2hTTawpmUgCre5v1up3/svWHVWY9+zlpuG7Q4qouaFBJEL1ZWPdsq
 z10wRzDwIkzXNGFgVyRBzT/yBIUNPHU4vuVJs0rgjel/i7TEetNsPMToXML/l2Yp4QU4
 QEvmg6T+chP4d0w+4oVzaawxc8qoi+p7zzxZVpaQP9zJyWAT3VKJCyDexp2kIuQHPIlb
 xk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722953983; x=1723558783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMOBByQTuB0kCr54Tn1SiXD/gk4GGph9q20Pk/9oV3w=;
 b=l8M4XZLijDmplxEUbBJ73OpSe8LKAncUxNkA9ICci3Mopg3aM04MFoZj86jV/4cj8S
 pfTQXvA7FJ3yjuJX2pIPfo4JQJfWrwwl0/5kVTgTyI2WiMNEF3QU8Q/GUSSbXMCeEuTJ
 wrLxgTqSPY7SJ/vnbC8ZsZVeyqQRjsZG+f8pKPQ7MDpyGtgv2pIpmf6zIpwJoMOOi2Hx
 mbZ+UC+w9HY5SStlShqv052JjN6JGkTXjb+rPCOxCcFnSF8tuUOM2gqTNPMJAMTXc4Wq
 /GqZlCNnNWkIDM/z/KY3R0NqPcMbfurF2+MGQ/QMmr539iPpD4LAzXo/MlwWM06HjwWS
 2U6Q==
X-Gm-Message-State: AOJu0YzyLJu9UZjcyPPlt8/r1F/tWJolxe/V5gAvVLmIOls3WCp3p/Z1
 vflxeCwAzAtmPWrOgEvL8yVch4JvweFGqWVLovTSeFqs0mgDCX0ljlnqw2m7C/eIeSLnVDnNzC+
 I
X-Google-Smtp-Source: AGHT+IHEMDxm4ye0mykYFg9IUVbdFwXZqvC33Ux6VfwvWtt0eh8rqCfM7LziDWHsTYoOf8jNIkNEcw==
X-Received: by 2002:a17:906:d257:b0:a6e:f869:d718 with SMTP id
 a640c23a62f3a-a7dc600f98cmr1244020266b.21.1722953983306; 
 Tue, 06 Aug 2024 07:19:43 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c0e0sm555953866b.67.2024.08.06.07.19.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 07:19:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1? 0/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
Date: Tue,  6 Aug 2024 16:19:38 +0200
Message-ID: <20240806141940.22095-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Attempt to clarify confuse output from the
'query-gic-capabilities' QMP command when
no GIC devices are built in.

Philippe Mathieu-Daudé (2):
  target/arm: Move qmp_query_gic_capabilities() to hw/intc/
  hw/intc/arm_gic: Only provide query-gic-capabilities when GIC built-in

 qapi/misc-target.json     |  4 +--
 hw/intc/arm_gic_qmp.c     | 61 +++++++++++++++++++++++++++++++++++++++
 target/arm/arm-qmp-cmds.c | 52 +--------------------------------
 hw/intc/meson.build       |  1 +
 4 files changed, 65 insertions(+), 53 deletions(-)
 create mode 100644 hw/intc/arm_gic_qmp.c

-- 
2.45.2


