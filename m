Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC0EC47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 00:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTAVY-0003gj-Ku; Thu, 25 Jan 2024 19:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DgOzZQcKChU59769y319916z.x97Bz7F-yzGz689818F.9C1@flex--komlodi.bounces.google.com>)
 id 1rTAVW-0003gX-Nz
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 19:55:46 -0500
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DgOzZQcKChU59769y319916z.x97Bz7F-yzGz689818F.9C1@flex--komlodi.bounces.google.com>)
 id 1rTAVV-0004op-81
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 19:55:46 -0500
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-6ddd112c8baso801247b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706230543; x=1706835343; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tXuYwNH/IUM70PRZoBMhFLJZc38Ll5xp3sPVPlzs72Q=;
 b=ylVqJcBWQUqz16FhFTys9GmPCjp5e7CgpOQAOLxSnwwxzKVd8vdVnrLCLEmPvhWfS/
 v20smQ7+zsQknBmPZZYrRXAnlkxWmWl6/k7g43Idl/lo5icgPd+0lHDbuT1XZbPe+/kL
 Mr0kiYGgKPemcdddAxKdn9ZUiZxW2N4D3I4nPKps99b2PciUSL44OOWYrMEQ9Y9Eh7XY
 XLTkINcgHLIa7cseDdy+ypTUDC4/HSwQkJlFSGSIJ+Xl67nvQLi49y4lQ7oPetZG6Otp
 +yIfJHwlWpSKNGVL3DIzHCKDeWSHs108pFvVFnTo75uSBxaHUKBje5jurskH/uPjYzp0
 CS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706230543; x=1706835343;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tXuYwNH/IUM70PRZoBMhFLJZc38Ll5xp3sPVPlzs72Q=;
 b=oO1IBDxyVf3UR1cROWK7W+BJCinKTzrx009DoVaGVvAdRlsPwVLNfI6WCMIN0ef8nR
 WZozAUwlt/euNS48f5OyQnl7LwALaWnp9YFToELE0CneLqGKt2g39kawImqGmB/KTozZ
 JQb3bT8okr6yiN5/4GesD2zbLqNqGq+5UcfjWKhbVbyYlBb5hMAJJxYNVRaurCIZSW3e
 MLC3kQTyRtrmC8Db7LcrGEfRSbHerrOlYYzS5h5dM3H6bxezWKbQ2SBeT1IwYrn9d8j6
 juwd1QhA+1pHEqfDF/xQUZJNAmbsw6LylBAy3XnYBZHWw1cdUEI/7Oi/AlHnodU9kO2F
 fPZw==
X-Gm-Message-State: AOJu0YwsldsEZswg+Hg5BrI1RD0BolGd2Gc4xQxQPHilaLuJp5/+BsPV
 MJ4K2BazJyR9fML45T8aBtKM9edXWqeLeMP2QIeE4CdwU/FktoWG2hiOqCL5iQiwNsCaG3V1gl7
 nVLOFnMaD1Jsoqh0d8kDah0JEnNu1zYn8+Q5B7UeflcM/DkVPhyG1EB1h+WJ9dFkm12hx3KA8kn
 bc2E6ZVMZgrGEKzjMptthYYL3w1EGJL39Y33tr
X-Google-Smtp-Source: AGHT+IFoiCQBr4JXM4S+St+7SIta+IcDlWU2+nTEpX9QA8wjo9eawG76qsBaiVRdmWIVcKBALI5j81Tp3KN1
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:6a00:f8e:b0:6dd:73a0:82ed with SMTP id
 ct14-20020a056a000f8e00b006dd73a082edmr113363pfb.0.1706230542804; Thu, 25 Jan
 2024 16:55:42 -0800 (PST)
Date: Fri, 26 Jan 2024 00:55:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126005541.1839038-1-komlodi@google.com>
Subject: [PATCH v2 0/3] hw/i2c: smbus: Reset fixes
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3DgOzZQcKChU59769y319916z.x97Bz7F-yzGz689818F.9C1@flex--komlodi.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Changelog:

v1 -> v2
- Dropped 4th patch "hw/i2c: smbus: mux: Reset SMBusDevice state
on reset". After more testing and Corey's comment, I realized it
wasn't needed.

Original message:

Hi all,

This series adds some resets for SMBus and for the I2C core. Along with
it, we make SMBus slave error printing a little more helpful.

These reset issues were very infrequent, they would maybe occur in 1 out
of hundreds of resets in our testing, but the way they happen is pretty
straightforward.

Basically as long as a reset happens in the middle of a transaction, the
state of the old transaction would still partially be there after the
reset. Once a new transaction comes in, the partial stale state can
cause the new transaction to incorrectly fail.

Thanks,
Joe

Joe Komlodi (3):
  hw/i2c: core: Add reset
  hw/i2c/smbus_slave: Add object path on error prints
  hw/i2c: smbus_slave: Reset state on reset

 hw/i2c/core.c        | 30 +++++++++++++++++++++++++-----
 hw/i2c/smbus_slave.c | 17 +++++++++++++++--
 include/hw/i2c/i2c.h |  6 +++++-
 3 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


