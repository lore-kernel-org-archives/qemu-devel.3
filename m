Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9208CC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqTj-0001B1-2A; Wed, 21 Feb 2024 12:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36DPWZQwKCt0M9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com>)
 id 1rcqTU-0000t8-NC
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:33:45 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36DPWZQwKCt0M9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com>)
 id 1rcqTM-0002T7-9q
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:33:40 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-60804b369c7so72029487b3.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708536808; x=1709141608; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EcwbTVhF6/jNkSn+Rl6HkgY4LLv3UGKGBJOpP0BckOc=;
 b=2g6ftT0n9W10ghhB5oapRHhPqiTQ/Xcn2r2HW3GizciK44erXLrqcTaKVoiclJPozb
 Ky92/SKflwmh1wkK21G109aBlyrJne5zzLrqQxmKj4ztPUlloIz2IUg9xPTXcWoeT2b5
 hJHejD7DaqgdG60Y9OaRjZCw5Rm+90QPDJhdJgqCuJKyUjWRVjBsBfyOO434iXVAmyqQ
 Php7bt9+SW9WUUJPgPFqXSDhW0dzZxf/PqIwTH4UgstJjY2soJQZteSR6teERZpVRteD
 T3pBOnDZHInk5q2I8eRBWB73GKBN7ktZXf9MRcSKiEWx+kgHhfZ1WBeKFwVbaOdgi3kG
 F3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708536808; x=1709141608;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EcwbTVhF6/jNkSn+Rl6HkgY4LLv3UGKGBJOpP0BckOc=;
 b=dQapnBoDcGpv4sp+5YR5oiUeqEluj5G4XI8lnEZhOnd5C8RYg6RI1OKjrsKP9pcBoa
 z714rZEOR6oRndssCd/h3HZuZmI5sqlew0Opo2kK6uUAYUn2SqJtpkEztaKWgxwGsabt
 ogx9OZ83lUKKIfkuGZfIzYof0cahux4vZHmABO0BSjoHRTBSk77Y3GfQ6JaFF8kpAfD7
 69QUl7N+0xlWdybX7nCNMt9+kM6qOhw0w/HyuoybWwXwBZN+YZI/SpSYjDOARu43TkMO
 SOUzrP7m7TkU31qO2zQjjLvg0lwQWHiPzQ1+bFfqFfJtSjPTO2M5yVXKmj5yvcepy79h
 qcOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW49AJu5vn0hkJ4hi44KenyqeHERMZinLOu5s5qtvpnyVqYJBA2FRaK4+VOJ6ABU9gnr8MdZpqhH0Xpq3JRgo1tMdxCB7U=
X-Gm-Message-State: AOJu0Yy1DPCRhHgkHndu6KCIrKOQrjaHyqhwMHIF09FtX7OFBKv+FOD9
 lWG6oiJt6DS/QN7NrBFP7To8doB9ZlXa0l9u+cP6w2sfhdt+f0xGRXTtr8pkOGLMHl4HYplgUBl
 NH7B77k9JprjoMd8Xt6A/WoF3QA==
X-Google-Smtp-Source: AGHT+IG6WE3zV5svLQ76mxt52tZmeFvCHce6AV3kOrbEWjl9Jlp5P4EA3uPqqGtss7y3JBSiCxSj2FjjNcDRfwVl0aI=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:a196:0:b0:604:9b11:ff2 with SMTP
 id y144-20020a81a196000000b006049b110ff2mr4882082ywg.6.1708536808694; Wed, 21
 Feb 2024 09:33:28 -0800 (PST)
Date: Wed, 21 Feb 2024 17:33:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221173325.1494895-1-nabihestefan@google.com>
Subject: [PATCH 0/2] ARM GICv3 ITS DeviceID modification implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, roqueh@google.com, 
 nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=36DPWZQwKCt0M9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

This patch series modifies the ARM GICv3 ITS to use the already existing
send_msi virtual function when writing the GITS_TRANSLATER in order to be able
to modify the final DeviceID to an implementation specific version that requires
extra information besides the BDF that comes in the requester_id. This is
achieved by using inheritance and redefinition of the send_msi while the
parent's send_msi could still be used to inject the modified DeviceID.

Roque Arcudia Hernandez (2):
  hw/intc/arm_gicv3_its_common: Increase DeviceID to 32 bits
  hw/intc/arm_gicv3_its: Use send_msi in the GITS_TRANSLATER write

 hw/intc/arm_gicv3_its.c                | 20 +++++++++-----------
 hw/intc/arm_gicv3_its_kvm.c            |  2 +-
 include/hw/intc/arm_gicv3_its_common.h | 15 ++++++++++++---
 3 files changed, 22 insertions(+), 15 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


