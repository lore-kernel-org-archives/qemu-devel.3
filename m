Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685A606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gurulabs.com header.i=@gurulabs.com header.a=rsa-sha256 header.s=google2026 header.b=BziGYOT2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQmc-0007Kj-AN; Thu, 29 Oct 2026 10:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkelson@gurulabs.com>)
 id 1xMQmO-0007J5-Tj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:06:57 -0400
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dkelson@gurulabs.com>)
 id 1xMQmM-0004d5-Rp
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:06:56 -0400
Received: by mail-pj1-x1061.google.com with SMTP id
 98e67ed59e1d1-3ac9f49b984so458705a91.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gurulabs.com; s=google2026; t=1793282813; x=1793887613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xb3MFtMIRqtwAoS5/RoThlAmIWd13bB0GuMAl2aE3to=;
 b=BziGYOT2Yc/IGgiVZy2lmb+FYyjsj/bgnvFF7XXAyN9xEo2LeNBsFIEhZprFjhtKR+
 i15D2psB1ZRpoZ58Uy62Tvs1bOGmBCvmOZDRDpEJAXrF92c94nuSBVMk+KnVysSvpEJf
 Apu6k/ApDpSTG2ulSkvGzk993qjUjuSCFlP0uwY0IHqvyor6AX0+fBmwVVn9LS+u9VRz
 fUI0SOe1fLIxx8mePo67Naa6L7++6I3S1JBbqZEtclgTOAAHVRQOxVqNlemt48hyzvdL
 JkeaQ6IJe74z57Rws66Lk5uZ6CW+KLnXGFKXo8EQWRANdEb07w1SPqvkSXY2O5k9wTQy
 IxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282813; x=1793887613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xb3MFtMIRqtwAoS5/RoThlAmIWd13bB0GuMAl2aE3to=;
 b=0gU3Jbef/Q51tSGdOZluOsM3D+VDqcBdlExnsnMpK9h1pjU3UDT2YbVt0hjK96jvg9
 AxnT/TD/fsSn/oAloM4iW7N7DLPhwtb3RCF3bz+g2Tp91MslMfCkm5WCDf0jqEXMnVSO
 vjRkUIoQYoS4piyQ3KX+C78l8PBvNqHM/iBivQNftH5McZ92DeSKV4Xn2S22hNsiM8RO
 pRTF//qDQIVFZuxCAAh06eNQkiEMTMU1wtTUxXQdSr6GiuSqqHHG9ixQb2lm1yqkNyUF
 caUN34TFUi2WpnzNcTgVrcNeCwQhEVnb/Pc3As+WarGZR96guYhRcX77CJIvyaTPolRd
 lG1A==
X-Gm-Message-State: AFq9FYJAxoDWh2EDRWx0ANG6xebDOnQlNThtMePmIrwralDk8DsyWw9U
 pCL5YIgst2cCI/aaIrxb4dRGAgZu9FBDuOvdCPKT9j70CWVXh1kDHXcELFzL4uBkA0KDUmM/ZyB
 rpsT+kJ9oX87d2HilLO2FId2HN79luVHCGHo6
X-Gm-Gg: AYBFou0/pjr9F/CxKsS9gdJ3JWDeRelNupprmYg6Cg2p0DN6odqYBX0DF0YKSkaju90
 bihG4khvquZgBpIYjm3OxQVot+L17UawTAFGQFgWbwfalFmjUWjwjTrS/mgsl9nbouTnuRc5x9a
 K89ZMBjV2oCnK6AER8PZ191wb7wEPh6BcC1dE9eYghlfHTvNITmAF7/SDC+oufR2thuLwIXYJa2
 bro7W8M3l4qjcxykw27E/5qYCM3O3YLKt2FDyfuLYE0cfOzUp93IUb2uD0PaeOQLLh8GFHEQnBz
 +Z2ea2ItRDqWX4/Q7h3zKvKuKwChXZcn8Pw9ZdMm52XKC27j7VglDE9ui8ufcw==
X-Received: by 2002:a17:90b:5624:b0:3a4:b509:88bd with SMTP id
 98e67ed59e1d1-3ae6ece0563mr1520105a91.2.1793282811689; 
 Thu, 29 Oct 2026 07:06:51 -0700 (PDT)
Received: from nas ([166.70.166.95]) by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae55a6cfdfsm1817318a91.0.2026.10.29.07.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 07:06:51 -0700 (PDT)
X-Relaying-Domain: gurulabs.com
Received: from localhost.localdomain (unknown [166.70.166.97])
 by nas (Postfix) with ESMTP id 5E99955AE;
 Thu, 29 Oct 2026 14:06:50 +0000 (UTC)
From: Dax Kelson <dkelson@gurulabs.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Dax Kelson <dkelson@gurulabs.com>
Subject: Re: [PATCH] ui/vnc: recover a job dropped by vnc_abort_display_jobs()
Date: Thu, 29 Oct 2026 08:06:44 -0600
Message-ID: <20261029140644.21310-1-dkelson@gurulabs.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028223204.86741-1-dkelson@gurulabs.com>
References: <20261028223204.86741-1-dkelson@gurulabs.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1061;
 envelope-from=dkelson@gurulabs.com; helo=mail-pj1-x1061.google.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Trailers I left off the patch:

Fixes: 61e77a5f0c ("vnc: detect and optimize pageflips")
Fixes: ada8d2e436 ("ui: fix VNC client throttling when forced update is requested")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4778
Cc: qemu-stable@nongnu.org

The issue has the reproducer attached: a podman container that builds
master with and without this patch, boots a virtio-gpu guest that
page-flips at 60 Hz, and compares each VNC client's framebuffer with QMP
screendump. It also has screenshots of a stale client next to the
server's screen.

Dax

