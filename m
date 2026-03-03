Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56B9EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPVT-0007qY-2N; Tue, 03 Mar 2026 08:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxPV9-0007RG-NY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:35 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxPUz-0000Nl-9L
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:21 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 623D90Jb018783
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Mar 2026 22:09:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GvlJiHIg5cF8lIcjx0ELCUIlxep//WnwqBouer09jxc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772543351; v=1;
 b=bSBMCWA5QiM5eYSo5foS+AMhS9SzNuIdm2wgkbIYa57cobKKHgMGcZ8+1Pd++WVr
 3E4uVs9wzq9lsb2J2teObOTKtvZFStsqM6OEKpRirMiizTBE57xMw78JvAHDHsIs
 iAs6XfKCt/jwAe3q8Lq1Kis+NsW75gcN8A6XSKRUJdJGlbzvpSdvEUQV4GILZHKu
 wwUQwC8teADBYjdwzH+ey1Y8ETJJPihW7gzMKFWpQDqvtKy53hYNBxlDWO1uMQKr
 zYPb/LsrX6qnyMdBnTiKEGn3uJ1Jd/BJbHLypiRzkmUEYGpcEQqRPf2IdozlvgJi
 5Y5UAaN2KBEkXbPDEBoabQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/3] ui/surface: Avoid including epoxy/gl.h in header files
Date: Tue, 03 Mar 2026 22:08:53 +0900
Message-Id: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXdpmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0MD3fQc3VSzFKNkC0sLQ7PkNCWgwoKi1LTMCrAh0bG1tQDYubbQVAA
 AAA==
X-Change-ID: 20250510-gl-e6d2c89816cf
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

include/ui/shader.h and include/ui/surface.h are included by files that
do not depend on Epoxy so they shouldn't include epoxy/gl.h. Otherwise,
compilations of these files can fail because the path to the directory
containing epoxy/gl.h may not be passed to the compiler.

Most variables with OpenGL types are removed. The remaining ones are
GLuint and replaced with uint32_t, which we already use for texture
names.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (3):
      ui/console: Unify pixman-OpenGL format mapping
      ui/console: Remove DisplaySurface::mem_obj
      ui/surface: Avoid including epoxy/gl.h in header files

 include/ui/console.h       |  4 +--
 include/ui/shader.h        |  2 --
 include/ui/spice-display.h |  1 +
 include/ui/surface.h       |  6 +---
 ui/console-gl.c            | 74 ++++++++++++++++++++++------------------------
 ui/shader.c                |  1 +
 ui/spice-display.c         |  9 +++++-
 7 files changed, 48 insertions(+), 49 deletions(-)
---
base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
change-id: 20250510-gl-e6d2c89816cf

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


