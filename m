Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D48C9833E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xARuB-0000TS-MM; Sat, 26 Sep 2026 08:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@alexrp.com>) id 1xARAY-0002dz-8n
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:06:18 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@alexrp.com>) id 1xARAV-0001Th-5i
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:06:17 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 9B50CEC008C;
 Sat, 26 Sep 2026 08:06:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sat, 26 Sep 2026 08:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alexrp.com; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1790424371; x=1790510771; bh=8f
 kNYK5liUhC9xU3hbpUiyP+tB2wPtyzCHoVMWrkxq4=; b=RNVwjxboB+k5nc6Sbz
 H/FJiUayFwkGMZQx1DitRpWqVMFYMSd8XpyrkoismD8yh0Eu+O5f4xAxde/wyI/D
 fztSgzoM17Y4g9lU0DXbSUpfjAwk/UUiMk+aYGE/hiY0xGFTaICVOAUvztUDAp5i
 m6AHHJy4/0Vvwl+43tcVGdac0LncHFJpa6Pcn24ZMtmVPGNQN6q2e/SCB4D+/SeG
 3n2vf+wkMuOMlfESy2sfjBcoqX6ox/CPRZOSWrWnlhHBxKdyjociSyG7XWpFK3JG
 RF/+BwSE7kzXR48hV1p8G25nHC5tTSVzh6URGSHKjMsIQadFOYKfh6JR4xcCNPb3
 kwaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1790424371; x=1790510771; bh=8fkNYK5liUhC9xU3hbpUiyP+tB2w
 PtyzCHoVMWrkxq4=; b=JBDng0q+qMEwnuFpWwDzrEcy63w7Dsyjq4XviVF37dcF
 5jsQTTmjSaYj+jQqnokhcYvR06VofQjT5VxLAEdvYdhoQNu60P8dwAr43q26pzPc
 I+tqZfQ7+yj3R3L4RQmTt0uLkzmxs72K2mMjUgrAvUu1QaEkFzp7VNlohOk4uuep
 Gxb32iISxcpghh03HZJNEl8yi3FO5JsVs2OL17k2xyJ6QWOll3SYh5p6463Ag8x0
 eUGO+hchHmuv8tnCyrc4EOCtHNjHP//qonYtV+geGY9Kk0sQ71WsY6lMtK3Dkn7F
 9Z2QTurTFbkzId+HqiLJOyIljneZDyQrt/5FGoJIDA==
X-ME-Sender: <xms:MrW3anu1jzI6aEiJKenmvYY08ggaiRL-GfNMUJCl8hOU17UjmXOnjg>
 <xme:MrW3aolIMqavMA_d-xrmXxSlynY6KxXJkGTSJqJjiQDWYevXizxb0D8393J1p9SwL
 NXGov6gvr5amEzc-nWdNsNH1EXqiNkPyajPQXbJGhmFinTY8nY_v0Hq>
X-ME-Received: <xmr:MrW3aisCswraofmQ-UaJc-IH7HFg5pwRTZws408X61mXW72_j7R89iMwqlPy9unYllg>
X-ME-Proxy-Cause: dmFkZTGJDrwBe7c+0m/LnYDTtd8E1ZJDQrorphPVfLDr0JeQpXdf1oEj/nyL8XNvCBc9bF
 0oNDFeaviLNdr7kzwboieKqrkqh+EhkHX6S3NFIU+9YMiqByP/ItSqilkWfvkRrQweN9rQ
 DYBaSBU1xVlqRpds1iYuhxWSQ7pNF/Xe6nDHlhyImy3+auO8rpAHAU8gFV/UWHl/QjHW9v
 PbGvFdoru5ox8t2deScEU17UymYYdWyQX2kId94zIvRuz+IVXe2QVtzXbFZuVFxMblr6zb
 A3GC4HERZl4cXQJ6jwcr50x6LuECqCqh7Ev0nWTKNw2mqdR6go2nIGo5hC3sywbYMww2Jg
 pxnb802tagUO7kQiZBsTBSG5x8UTljE8SVrhXHi897YsdEIMiBuKGS+6CmWLgLmLpkJYLr
 4miFauQO+M6RnqD2jiDyRHNTa0p4HemjVI1kGamQQ8GSMps6KorfpHQSniqUucSu1f2i1q
 B2RvYKQ2jW8f8coOvQvgdPLJ1ftVW4fVOtT30E7mwmKV9k8ioKQoa0s2fzRUq+ImSGl9a2
 RjtDfVoYKykdGCuRgRiWvn1LbjDRTBWhrA+iZNqV9oVVYidLeg3DAVAeB9Vd+cy/dD2Ji2
 hB6aVfvRc9fvi7DEfkZPWCOQOo8BIz0W9jALkjIJnAc9qHwJVi07+MEk75BQ
X-ME-Proxy: <xmx:MrW3audO_Q6TC4BEEvVWol43aLbZfmGDLFk4PM0Jf8wNcawS6pHhyA>
 <xmx:MrW3aiwwnHPqjb2hp-bQKgyFWq_LRIplkblqDYaxUUvwh0cVf1jmkw>
 <xmx:MrW3asEYePZP-7oQs4UvUg6prP4cdv8ius1EG_IEN6A5n8HLu8aPdw>
 <xmx:MrW3auwljbSNyLzbF8420IWHsU8mtOOKUaJzSSktbKpIMrNHBJO9vg>
 <xmx:M7W3asob2HD5YuiHSyDkoK7YaSDEOxTMFki2vmu5YHfKEpdi4PwuDRwQ>
Feedback-ID: i799648cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 08:06:10 -0400 (EDT)
From: =?UTF-8?q?Alex=20R=C3=B8nne=20Petersen?= <alex@alexrp.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20R=C3=B8nne=20Petersen?= <alex@alexrp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v1 0/2] make pre-r6 mips64 nan2008 binaries work without -cpu
Date: Sat, 26 Sep 2026 14:05:32 +0200
Message-ID: <20260926120534.240391-1-alex@alexrp.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=alex@alexrp.com;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 26 Sep 2026 08:53:24 -0400
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

These two patches make it possible to run pre-r6 mips64 binaries that need
nan2008 without requiring the user to explicitly set a compatible -cpu. The
first patch is really a bug fix which enables the titular enhancement in the
second patch.

Alex Rønne Petersen (2):
  target/mips: fix Loongson-3A4000 definition to have abs2008 and
    nan2008
  linux-user/mips: pick Loongson-3A4000 if a pre-r6 mips64 binary needs
    nan2008

 linux-user/mips/elfload.c  | 14 ++++++++------
 target/mips/cpu-defs.c.inc |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.53.0


