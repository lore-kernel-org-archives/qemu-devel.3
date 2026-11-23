Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADED606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=PbmscySr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EBq7RENL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVbR-0001N0-Kr; Mon, 23 Nov 2026 10:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbI-0001KP-5O
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:01 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbE-0003fm-3r
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:04:59 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 9DFCCEC0BA9
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:04:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 10:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1795446292; x=1795532692; bh=wv
 SJG/EQZLWfCQPZYx1FM0dbT7LWqL+XKoXcleiTmOc=; b=PbmscySr6RBtsNHDi+
 f5XNbiq/8QiVzKXc4ERSqv8kPxCqtHh7Nq+HViDGvhdxRJ/6pKRHHXOspra5tJBs
 t2ce84oHuVO9PklNjBAED2IO4cv/X8czo27hxBf8M6RSGBDREDkZXHp5CWGa7pww
 U+v23clORSAk+2AplyeeEr9y3U5M/tojKH4ttA6lPK81cefagQj0Pg9jk7KuUaRY
 qLVbIDAvfpr5Nue5VGbgZpHbFQ+atqJTiltfuZ7SEwNsiNJ0785723+lOuIP87D7
 Zh/o/O1c9smvFU4xr5ySWxnBaBUIr2lsxzRZTuIdwWDbBzKkpHWBTbm1ZCQahwZw
 MoYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1795446292; x=1795532692; bh=wvSJG/EQZLWfCQPZYx1FM0dbT7LW
 qL+XKoXcleiTmOc=; b=EBq7RENLvwLgWAgGxpy8sn79YdybIwSxT/rpwrRAbB+0
 pgjoSqZvf0epq4AYEvbrCa1JKjSIO4NSVBCRkXvQHuRdrmyCKXRsqs2I9v+KDCOC
 LqRqwtpwjFXKg1WQnEhdIbB11ZAjnORTPpprKMyL90fMoN956/bxYTXPyhonMQP4
 u8BHuLVWjsJMF8TQl5H1iT4uHEXG+ZyQUlXQj+hPSzmvjmTjzv+H+oTKRrTZM0RE
 PDUUrjqVae0M3efCZcf8cNSwMH9pZSxfb1k9F+xHzj5BOwQ7/YUHiVClVljEqSac
 ohf7yJ9SEwbACy5UrhEQDMXKHAUG0iSr44/A0Ho1GQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446292; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:LcFWY2UTH96NnqOgX7w7m8Glol1TjLGUADVr4d9NZ6W2o3V
 uAW0FX0qa87C9HCvrrvaQ5lZFbDEN9W4NifFIK7+GJ+gprTJSxWwSe3ft/UoJCYW
 6K1dneLBbnzzMc9C3jRQtUuPlaYjABbjM7Hickv9MKg9uDhFFAj6UtfKYA7SAi3y
 HwxNNAbHtICwYEVnmdOvnPR9nWp3hunfwLZh/aoQQ+UdoRmaDHck1mHsmIkBcT0r
 cmrT8lAVRyKewPD+AAYaEQpeuObTomBw4TTVz80RdU/WH40sTi5en6CwRMYIPOjj
 mZTa0ibqnCFn90MO7zu+k594LI1eT7tiBgcnimg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:ckq0j7sfF53adRdxOdgAaQDip0+2zDsC4fxh8v9OGxw=:ngCxzpM66OIs5T5l1YAUYqTtqcFFxN7pOk0RloounVA=;
X-ME-Sender: <xms:FFYEa8eFdJE42v0CsGmcZZLEheN3a9Kyc0j1i75n3YTA9U9YR1XyNg>
 <xme:FFYEa-p145WHAy6s4GmQLSTI68X5HFHPUxpO9ixSRbop5vHKne1lsFT7nKAB1y3-m
 IULW_wHOIIyquYsnUDX-FbGpBY4VQN4EDr0XgHhnZ91jfcSFlRgivm9>
X-ME-Received: <xmr:FFYEa-NsiJYxLhlSICp1PigepFP7p2dhIHFfBXVWS0uynwJh8z7JDs35QTnWsxbHyLD12NUbsa_9dpj5GzPVIAGDKbG0GypiiqSi>
X-ME-Proxy-Cause: dmFkZTGWJrOsz07Eokc74Z9+rZzF+6KEgJP7pt8/+7J8q7zVN/y8sGOdbqFcDS0fdeH9Vb
 zmNE652i6alKlooMBzRLAcXCRb+ILGOvWU+ZyXOIdpjhssLy/pKL2W3abb01C547Y5Hlcx
 dyOOfz1HkK0lmF4VBzmZgr1LHGIQ3nmA1RQCdeRM34AX1ci3Qro44Zaxtu4A+EzIGpUeSu
 zcFKrf1Mne4+/dplF7UqummtUOpduuHm+i5y3ALn68J7vIlyKJK7SFNtkyEe4I0TWgDKSP
 2AaKghX+NvB4QXPmWpdyi6X6jyj18HrsPPq6eOX327jJgBNas5UvIA2pcB45qCPov0HHGE
 cB4tuMX5m3VsT40Ml0OqANw0RxxItT9EhPMuoCGj6TSdsrj9Cv5MeH9L08pAUvva833ViL
 +YL3nxLOhzzHTSotausL/Do2Mtz/AckzYMbNIoF2qJhpJNHbgu24lV0e7O9OPWnaBExdb0
 Wstiy0W9AqrGEL48kIOO+QiX1OqCMchi3HNlXFCwQrJGNlMK6DYuKsOA8uxPMD50tK0LMk
 hVF/Dk0wsCXFHawyjJp+KE/d175jrpDSJC2KK6JKGXP0KXpH5lBWXD6YBd7pt7Dxw7QWcF
 lEBqZdvAozuEuSu4j6Rx9l5iY1Lhw5YeW2VwdW9xPHDvsrQUD0OmdlCqO3Ng
X-ME-Proxy: <xmx:FFYEa5g1-lyTmFRBeottMSNbAgIFkvCMNKGY-TKzY1d3gI5o628JSg>
 <xmx:FFYEa5uadQ7byCJMX0XuoGerouPkQGaCm72X2mVLbfRzS76hl3NHAA>
 <xmx:FFYEa1gXU_LW6PkLpS87It1_5CFU7njuTsVb_ZfKZjXneq9Ba9gvMA>
 <xmx:FFYEa3bYlwUdtjXDTm3erGyyGZ4TSaId11IIlFbq84chwrG4S8K__w>
 <xmx:FFYEaym6e0K1O5i_uZ7-nmsCsj7K1xu5QGRxahzzRizBHiACrfxuoRLr>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:04:50 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Subject: [PATCH v2 00/12] hw/nvme assorted fixes (mostly FDP)
Date: Mon, 23 Nov 2026 16:04:47 +0100
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA9WBGsC/4WNSw7CMAxEr1J5jVEdQZqy4h6oi6h22iD1oxgKq
 OrdCb0AyzejN7OCSoqicClWSLJEjdOYwRwKaHs/doKRM4MpjSUih/cXIzkiYzHwjCG+RbH2dTh
 Rxe7sBLI6J9mLbN6azH3Ux5Q++8tCv/TP4EJYonBlg+fKWeKr+kGfY3dspwGabdu+3UPciboAA
 AA=
X-Change-ID: 20261118-jwd-181126-fdp-fixes-9a9f417d858e
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.150; envelope-from=foss@defmacro.it;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes mostly target FDP features- and log pages.

Notable non-FDP fixes are:
- get feature: check for invalid SEL values
- get feature: fix error-code returned if broadcast NSID is provided
               for a RUH-scoped feature
- clear OACS.NMS (namespace management) bit; we don't implement
  anything but the Namespace Attachment command, and a controller
  may support this command without supporting the capability, see
  commit details.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
Changes in v2:
- change return type of nvme_get_feature_fdp to uint16_t
- correct FDP MAXPIDS calculation
- clear OACS.NMS; a controller can support Namespace attachment alone
  (and we do)
- fixing get log page offset checks for various FDP log pages.
- Link to v1: https://lore.kernel.org/qemu-devel/20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com

---
Jesper Wendel Devantier (12):
      hw/nvme: get feature - return invalid field if sel is reserved
      hw/nvme: get feature - fix and revamp NS/NSID checks
      hw/nvme: fdp enabled helper
      hw/nvme: get fdp events, use helper
      hw/nvme: get feature FDP (1Dh) fixes
      hw/nvme: set feature FDP (1Dh) fix
      hw/nvme: get feature FDP events (1Eh) - return supported events
      hw/nvme: NVMe FDP event data structure - ruhid is 16b
      hw/nvme: correct MAXPIDS value
      hw/nvme: clear OACS.NMS bit
      hw/nvme: log 23h - FDP events, page is 4 KiB
      hw/nvme: get log page - fix offset checks

 hw/nvme/ctrl.c       | 193 ++++++++++++++++++++++++++++-----------------------
 include/block/nvme.h |   4 +-
 2 files changed, 108 insertions(+), 89 deletions(-)
---
base-commit: c0080f56036249df4a3f56e07e90cb0e56b3fd34
change-id: 20261118-jwd-181126-fdp-fixes-9a9f417d858e

Best regards,
-- 
Jesper Wendel Devantier <j.devantier@samsung.com>


