Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035A6C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59Q9-00035g-Jv; Fri, 11 Sep 2026 18:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59Q8-00035N-1L
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:32 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59Q6-0002Fi-J2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:31 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccbd478bso29451fac.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164508; x=1789769308; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8LCrl+N/gIhSbZiyFPNK9KmCM+Ls7LggyWpvFxs0LSk=;
 b=qaKUsNGhT2eixikKwM6KVAMjIp375623pFvkMRh7TBYA5EIPZjc3+9CsbcJdy845z0
 3t9S54XnZCEVY/kP1QdxZcbs/GApUCtYezznhOYRn7tAzYfDdcWAGpI8+2i2LOKiWRpr
 Lr+X5vBHwx8dlUILU/uBMOclg+g/17prGIqxc0hmfltl8Q5nxTgpe2eyssADEhWeYjL9
 W3jkHRex0w6iKnbTmngjdvC0NJyX/suXncu7Z4Z6axpne5dJl+QVvaoYT3aHnY53nYyH
 53ehfMgJqpK8hVBugCzrUn4b16jF8P1751QBXRlVJq9DFP4ul09zLPil7nbWlWa++GQu
 2Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164508; x=1789769308;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8LCrl+N/gIhSbZiyFPNK9KmCM+Ls7LggyWpvFxs0LSk=;
 b=dZTweiP92RutvSRfA8MB0wLQSNnA10nWSSn+YlXXYgWNrL578iISoecF4UJjNyhD2f
 NVEtfz/PNMBNX8uh2sAcjgBaL5zE/64ZtJ8V451+o50PZIDaMWgcTCAhfQ6UM3SEa4gj
 oc6EwLuZC+25CV3Nj482fR1hrWh7Ry9v2A/YAV5mYUyt7gtSgoFwxnGfWhkVXwHS0zBm
 hi4GvzPapw37TCKVhgkx5+t4MFC6VQe5DWco5N8dhVxB1ylSzsvc7fVCT5n0Sdy6zQK9
 BuESHEdYcsj63GnXzTSyYEiPGJLUo3DlS4IJSPbjoiA1Y0HquZMLF5j2aoJCSTM4+emd
 Z5ZQ==
X-Gm-Message-State: AFuF++m2RK9ohYwn7125s53iLeN2SK+9hOfUd6GRsuBy01jO5yNvr0H1
 yLfmwNGI4aCZ+K4+NbdbPjnwurlUbddtiqKeIetvfUjIHWfxNr4qFpcCzJkkZ0jG
X-Gm-Gg: AYBFou0egfkN0B99Kj5OwuQW+nHWMiddu87CI7l3cgHZ9gREi2oQs33a4zaedfmEXUp
 FgurdTGZty7VamkwzHtDUUgH6aL2ey1ONs/hs5I175SfZ9dy5lAXtDvTROE1Y1JPvfw+LKJheDy
 vGgGFF5ZFgOxCQkrdzQ6tDEcElqd+TTLdVsSpdf0yDKt8Oz7kohb5q7RHyqb94OQHCAifZ2JZG/
 XbQwMOKBoItueHol2XSrUQ03xB0qSws6kbnvIEElZfZfywHlBA/3LAqT7p7CF1berXVmZcS7DM+
 lSJGP0MJJVoKEI64h3c+CS+Wk1/+TfYgcrS82ON9utNgK50zpf1O8lxc8NPYh7RIyeBqkGgKn7F
 FoShk3JjtskonN3Cayb8ibrreVyeE+9TNk8Vvh3R+dnb1M/1iqJIuPDg6TpD9hXKqHKFAsBfmKI
 Kwl7MWf8KQiGCHRADIrgLBjyDC99rQ8AEbHDeooFOlhOYwgthCpczOPkdI8xaWQ1W4Py3cPXOIS
 gx8f9HgOnzqOl3LQCel0NAFKIJ9WnxMJ0VMC68WwV2O/zVq0OekwLtWfWX31jpG
X-Received: by 2002:a05:6820:3084:b0:6be:2c0f:e40b with SMTP id
 006d021491bc7-6c24c7c7e32mr294269eaf.2.1789164507972; 
 Fri, 11 Sep 2026 15:08:27 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:27 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 00/10] Hexagon (target/hexagon) Check for multiwrites in
 analyze_packet
Date: Fri, 11 Sep 2026 16:08:15 -0600
Message-ID: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, we check for register multiwrites during packet decode. The
downside of this approach is that it only checks a single destination
register for each instruction.  During analyze_packet, we can check
for more than one write per instruction.  Further, we can check for
different types of registers.  This series adds checks for HVX
v-registers and q-registers.

Note that multiple writes to a predicate register are allowed on Hexagon.

Changes in v2
- Rebase against latest sources, including Hexagon system mode
- Add checks for multiple writes to system registers

Taylor Simpson (10):
  Hexagon (target/hexagon) Move code out of gen_start_packet
  Hexagon (target/hexagon) Check for GPR multiwrite in analyze_packet
  Hexagon (tests/tcg/hexagon) Add tests for multi-destination
    instructions
  Hexagon (target/hexagon) Check for vreg multiwrite in analyze_packet
  Hexagon (tests/tcg/hexagon) Add tests for vreg multiple writes
  Hexagon (target/hexagon) Check for qreg multiwrite in analyze_packet
  Hexagon (tests/tcg/hexagon) Add tests for qreg multiple writes
  Hexagon (target/hexagon) Check for greg multiwrite in analyze_packet
  Hexagon (target/hexagon) Check for sreg multiwrite in analyze_packet
  Hexagon (target/hexagon) Remove old way of detecting register
    multiwrites

 target/hexagon/insn.h               |   4 -
 target/hexagon/translate.h          |  47 ++++++++--
 target/hexagon/decode.c             |  54 ------------
 target/hexagon/translate.c          |  88 ++++++++++++++-----
 tests/tcg/hexagon/multiple-writes.c | 129 ++++++++++++++++++++++++++++
 target/hexagon/gen_trans_funcs.py   |  10 ---
 tests/tcg/hexagon/meson.build       |   2 +-
 7 files changed, 239 insertions(+), 95 deletions(-)

-- 
2.43.0


