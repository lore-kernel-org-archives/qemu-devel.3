Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DB606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iug4zFJ4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTYlP-0005Bn-7M; Wed, 18 Nov 2026 01:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xTYlH-0005BL-4s
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:03:15 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xTYlF-0003Y8-Dw
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:03:14 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4ad587ba293so416167fac.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794981790; x=1795586590; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JrHhCUsXhPTUpH9xjNmeczBcmgtCd0+kazu1Dq95rGw=;
 b=iug4zFJ4cdLAOF188m85kdsv9T059bLM4jQTjy+i9dZFWCKSQnY+N/CORlBqAz4zZ7
 Ib3CvjgXfSRJ2rvTRqAnxCfqMOdkRm8wlWa/QwAsZa3FFaDhavfgLnJFd3u4tRs3ykAJ
 Rm5q6qe7WVxsDZ/CnVIl58F27GLGo8rTeDS7wJHeTdxwTsh8zqs0ZnWWerNr+B8V+NEV
 zmuxKopi/yrQS+qZb9pctHPCo3gzHjYfIm/yOib65nZ4pWZr78cuuFGpDhDQQmlYu9lT
 Za0pGS45RJLABFBESf+ryQ0gCr6J0Oc3GuuetqvGjdhH4Y2ggS9Sr8eN6BU54rqIMPYO
 08yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794981790; x=1795586590;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JrHhCUsXhPTUpH9xjNmeczBcmgtCd0+kazu1Dq95rGw=;
 b=tJYRxh/LyfcWtYVG3GR3k5X+++HYhUEO52e08NTPnH93Z3SQ93XVMW3sOFOYMn7VwQ
 4Uuzt9RWVM1JuuRdt6QfF1GOm3r04XgncryZJ/DkDUifszx3RUaC7TWquEsdkJ6NbnFI
 nSBq07AFn/wLzAcU7vxWRAmjvi3tIouC5GDVRxsGi26YkiYHJTlgxj06QSuKES9zeJD0
 haVXL/AMtNB8+doRwIBH2hUdYk/0Yw96DWIXXdhUBODJYszQcaRB0w/LtPxTgLZn778W
 iy4vNTY8tkBqojbSXtpOVPPfqfd5o1Qcedg5/i/UMHIYV00b3MkAFBgPpDpx+Gd3kQZg
 QQZg==
X-Gm-Message-State: APuU4Z8KbyuFfsytet0z4jPza7W0/h3mNvCYW7Ad9VcAzJF0qjevVLff
 lOy6weJ5tQlkwFdBSXiOa6x13XoiksaGoZnX3qcX+UvLQkP0ugPrqQp9
X-Gm-Gg: AYBFou24C3ZQgxOOHhcYIsymeXctbqumlAWAcnj8c4uVtt7GjZQBmWdp44UWzlwpQ1e
 ycL1+ZwOhKJ/AHVpx0OXxMumgYoYUYZA6snGa0wGen+6iOLOREkArwsjydHQVFMkOuL7XrRuk+E
 yRnLOJC8tYYpvStAHKJ/H5wVaSxo9t+MCneswIZFtSbZNEz6m83ucfmLKhe5J2yn7U72GT8CsKk
 s/zFDBFDionQcvAXYmlXMHzYm+rl9ikcROWc2gUL5epVDxZhYQ69sk+3vXhEA3IlJpxhOzMvRBK
 9Tuxrnlv8QShmd0sqWSPoDaE8z9HPQzbnzDZ5sE6eOeW0wIbryS+DPsLFqtBMBGyimBE8wwxUD0
 k1GuwQ5B24SmY4glIGOTQnA3Dbej3vxDPe9I6IxagVV7msvXiOQeAce0pCEzofYWVTmo5E/Ph0u
 bOZppElG0JTj+DX0NUbsNfeovNeJxvKkHw+veyRbo3SIqhb1/PnP5e7C4jddRVwGKSTZne8fwwN
 p+6/oUrpR6qYg1Cr2/f7MUYQRlBag6xVOrlPFzjZblQTSbxeOy1CSBmZOTvKmH9GgmJcm3T/PmC
 eE51j6yDi3TmoHJLd3vMveBtFgI=
X-Received: by 2002:a05:6871:2edf:b0:493:186e:b51 with SMTP id
 586e51a60fabf-4b75d2575eamr1276186fac.20.1794981790084; 
 Tue, 17 Nov 2026 22:03:10 -0800 (PST)
Received: from [127.0.1.1] ([2605:ad80:33:509c:ff29:6c8b:a81b:ce71])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb6bsm1358721fac.4.2026.11.17.22.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 22:03:09 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Subject: [PATCH v2 0/2] target/i386: make error message for -cpu host more
 informative
Date: Wed, 18 Nov 2026 00:02:51 -0600
Message-Id: <20261118-4836-cpu-host-error-v2-0-ba02bb640d9d@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIs//WoC/32NQQ6CMBBFr0Jm7RgGLRJX3MOwKHQKkwglUyQaw
 t2tHMDle8l/f4PIKhzhnm2gvEqUMCUoThl0g516RnGJociLkogMXqtLid38wiHEBVk1KBJXpqU
 b554cpOWs7OV9VB9N4kHiEvRznKz0s/97KyGhdz7n1pStrWzdj1ae5y6M0Oz7/gWAs22MtgAAA
 A==
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794981788; l=1813;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=zGxLgq+fmlHyrsqB2xJLoUlX1Dd0O3Hr1GSHB+dpaiA=;
 b=+jzBaNJ49eCo7JoSW2B/MfdDldWXoIj5jXMvyEVg5PmeMQS0VpGUBBkUulBPboYdJiTp63mSR
 jwkGvEhlWlaDkB8kVvQbm3BN5oVxtcVkZhR+eAwiOF+gXTBEs9HN1Lo
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=xmphyr@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a resolution for issue #4836: https://gitlab.com/qemu-project/qemu/-/work_items/4836.
"-cpu host" by itself is not permitted; an accelerator must be specified as well. For Linux,
it is KVM. macOS is HVF and Windows is WHPX.

Previously, QEMU would only tell the user to use either KVM or HVF, essentially excluding
Windows users.

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
---
I originally was going to make hwaccel_names() a macro, but that felt wrong. 

I am considering putting the hwaccel_enabled() call in accel_uses_host_cpuid(), but I'm not 
totally sure what that function is for at the higher level. My assumption is whether or not 
QEMU is able to get the CPU's capabilities.

Just now realizing that the cover letter should largely be left unchanged between revisions.
However, I don't know where to put additional comments otherwise...

---
Changes in v1:
- cpu.c:10229: added WHPX to the error message when "-cpu host" doesn't include an accelerator

Changes in v2:
- cpu.c: added a check for hardware acceleration
- cpu.c: replaced the explicit list of hardware accelerators
- hw_accel.h: created function hwaccel_names() to return the list of hw accerlator names
- Link to v1: https://lore.kernel.org/qemu-devel/20261115-4836-cpu-host-error-v1-1-fdf0eb56ba8a@gmail.com

---
Andrew Nguyen (2):
      target/i386: make error message for -cpu host more informative
      target/i386: check hardware acceleration with -cpu host and scalable error

 include/system/hw_accel.h | 10 ++++++++++
 target/i386/cpu.c         |  7 +++++--
 2 files changed, 15 insertions(+), 2 deletions(-)
---
base-commit: e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5
change-id: 20261115-4836-cpu-host-error-1e85b17e0f1d

Best regards,
-- 
Andrew Nguyen <xmphyr@gmail.com>


