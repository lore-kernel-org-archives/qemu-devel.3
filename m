Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7BDCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhL7-0001V2-Jm; Mon, 05 Oct 2026 07:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKl-0001Tz-IQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:21 -0400
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKj-0002xM-J1
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:19 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 37A701D000D1
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2026 07:58:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 05 Oct 2026 07:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1791201492; x=1791287892; bh=LE2A1XPNQQ
 HlZhk7FYQc29VDi3DQ47/QXFDlSXAmSOk=; b=aE7w14FzIoSryUapmWH9kBLZp4
 uty5XQ/1Rey2GG/mDC80hSINl9z1iAhMYjb7RE6jVse948pUEqhTtdbkzTcBMgHI
 B88Um8sTUr3vTjsLS1k1/76Gu1yyxSYPN/uXIjCdWdC4L23SG++J240w+4ox/4Id
 oJ4VYMZDqXLujeScPUFl5g77fUwZcb+eQw1bknOsB/iM4FlZhc7T7e79J0upeHf2
 Tbwaz74uQmwN7vZf2g4YJj4vtTvV81DOWJC+WXx1icc2lAiGTujBW6srpgNW4+Sw
 NCoSl0AA0NgO1M6ONf1sJYYba12s6v70ww5qUgtOfZ4Ph1+e4PFF1nypqVvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1791201492; x=1791287892; bh=LE2A1XPNQQHlZhk7FYQc29VDi3DQ47/QXFD
 lSXAmSOk=; b=AjgUZviAJLgtHAQU4JKiOPgusHyVhXQyDis4e92F3oXPgriOsxi
 iYn8rhvCtQRPT9TSJIqziK5oUPbukWPURyrBVen1CTLoMWcOrLF6mQHihnw3tb3j
 zCATh8Gkbhd6DummuDtCgtGCArQXx0r8uKixzA/AY1ZB1T2hEvcuaIvhmwuw8UBP
 riyxOrBFqo+k8Sth8YxE1iorKvD1FE4Hx9Fb9O9VK9H3css+esGAB6n6+vqVywkx
 nU50cg+hzgChX/XNTiDljYB7g2JVT0HW48Jryzsiv87TJSekREAMannSfpQqQQ8y
 UpWMmFb9i6icmQ3gkUtaHkfndYA0kUubu0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791201492; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:4MRLRcMZy/smG4NO3KFHLLNzKwKkoveCH9GzmqYaidLYV+K
 f7/oXQM6PxF2Q9p1GD+kKkM+L2wmAx3FwCFXVwCzXev9ofokluwO2FNUODHSUagT
 7KA5LmlnI358+Jk9BifhPgk+c2N995mJbShcwZGSUQDoN8L26SG4L4azWKfIVeyY
 eE6+JNfiZfecGxZFGSFxy11EsqVNwct9QCVDdUudkJbqXKk6ZK45GT5LhPAz8zNL
 qX/uuJHykKkZVLf1ebZyzJF54bDbWXdTd+D9JQB5pwkgYni5n9Bpsi1/ybJdGGNo
 mFPCSc4JQwY7E5mv/x4ZiRu+RPSNBmdD+n88lBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:5LBmkppfoOyGmoj8GkWRrjndBxu5B8+lQ2mto53pUuY=:GPRFjCC2bAXcIyOqvLOh0qru63YrVYAxQdTic8BpSJs=;
X-ME-Sender: <xms:05DDahIY_Y_QEUrWrN5fCUjOty6Wv8vCyvmoSMOwSEEwJqMOw_oTOQ>
 <xme:05DDahdXkxznJiDSp3fgNos_9u4shNKeWlbtMmA8C7X44HHh2YfNlQ71yTcMIw4YZ
 Ld-hjZM46LgzjWqS-UhJ-JfIY74KoXXXzy0cw9ENqcUvQ0SrAzxChI>
X-ME-Received: <xmr:05DDao1xw6Gmhfn1ZTIoLgNlVSC23BQM0OhH4F25n592ncRuZmPsxKAtTBSpJy5_z72nnpbHYZMtL3ConIrdpC1Y>
X-ME-Proxy-Cause: dmFkZTGcjIY7TAZkzSrmRiOJgWlfcteyq21Arp/gQI0vc97Wt2AKcErwPJSxuKLrMOkqF3
 WdQTFydZXsTOe1QutO+aO+zquXhjpW4DStFu03LvcTO5p/kqvfLuAUXzuxYI4cY3jj/mSs
 LHugKa9MO7wqz56tUCHXHpJt2wF6RorzpsNCTMzaCjMDWdiAq3u5yRy385yUbQcinpFc6M
 k0GAwkQEGnrF+XqbkY1umDxQ8NAkG2yB9vr6DWNPQTN4oPO+pqe5LQyVBuqCA8i3ttIe5J
 OHGS9sEYeWuvrpJPBmhECYeA8tIuMcywKr3vxO5kXKk8V7XiojxDtPq0Mr93Ok9QRqOvhH
 BtECkZyrP9uyPY12WQpewAQOysBpTM7Sis1m1TBGTprJsacFhRtq/Su1UdOPTm3kXWfWyb
 go2uW+aQCkGyB2yEwBoJIjT8NbY97tUlYsQdAmMvHMX93gkWe4nwnMh+c1yuFhZu2vH+H0
 OuwFAtoqj1vOv/Es94muHYd9w22MzCIAZmEfiiF45aVX2RTUDY742TzDPko7tJeSvT3fdT
 O7HtnMGUGdB8AZnoJtTSw32qnyPiphG9S2RNFsE3cdDznmcVUxENxNk9qltdxIF5MICYpj
 +vhzQXZY5/DI55olKoWCaebR6ZLFYg43fymUtbVu92f1F5vyLLEo7/ZU5yIQ
X-ME-Proxy: <xmx:05DDaqj-CR5ouP_7og8rvqQGbJWjjxy2vrONBVJnYcAtFV91XMIe6A>
 <xmx:05DDauRlamw47KyGQUWIMzrExCp3yofx9ziWH6HF7WOah5SgPFHOBw>
 <xmx:05DDari90k_z0fX9A_Do_0aMA7sgOAvJAVVopmGulHz6DHxnjfJGKQ>
 <xmx:05DDau6SLzMY_UmllVaxeVALwg-O1U_PGY0LG-c_7ia-VPn6A7nnew>
 <xmx:1JDDaitRTvGVzqDCwpkJvHyJ1lJte31JEv5FKXlT99EPiNnSM4cGOSty>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 07:58:10 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/5] hw/nvme queue
Date: Mon,  5 Oct 2026 13:58:00 +0200
Message-ID: <20261005115805.99042-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=its@irrelevant.dk;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:

  Merge tag 'hppa-a400-updates-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20261005

for you to fetch changes up to f6c0588fd7c22caefc5b31f485c8bb3ee994a58b:

  hw/nvme: fix firmware boot path when nvme-ns has a bootindex (2026-10-05 11:00:47 +0200)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Alexander Mikhalitsyn (2):
      hw/nvme: initialize ns->subsys for n->namespace
      hw/nvme: support online resize

Daniel Paziyski (2):
      hw/nvme: fix assertion failure on sr-iov capable nvme controller removal
      hw/nvme: fix memory leak on sr-iov capable nvme controller removal

Luigi Leonardi (1):
      hw/nvme: fix firmware boot path when nvme-ns has a bootindex

 hw/nvme/ctrl.c | 22 ++++++++++++---
 hw/nvme/ns.c   | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/nvme/nvme.h |  2 ++
 3 files changed, 104 insertions(+), 8 deletions(-)

