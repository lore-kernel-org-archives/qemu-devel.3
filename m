Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD098606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=ftUhKO4y;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=J6cJ/xII
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThBJ-00052z-Rh; Wed, 18 Nov 2026 10:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThAx-000526-Vz
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:21 -0500
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThAu-0003CD-6a
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:19 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id ACE64EC0B0E
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:02:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 10:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795014131;
 x=1795100531; bh=kzEDz15we3uMY6G1+g2sEvyj1tnQIbYRCsOeuuINZ+w=; b=
 ftUhKO4yHyzyCRO0fXAD0//ad+r77fmoC+Z9S/MwN3U29XX9uvSvET6IrovEV/UY
 aX7IHudZs2AFes33385qV+CGUtILTO73kktMyDBdSip5hdkSECvaQZzW4PKZmLN2
 iXR7oZ6KmhgZS/Unl9tsp8NlFcnVqO7IZFZ6+qCf/v6rHWEM5Elqas1rB7RbRBWO
 9IW5Z3s1qJ9gYM0PCbxFlZWyPzzhWqwB8LEukyNLQMv2UEv9dRMRDcM8UcAOl8yn
 1SlYvsEKVQPIevMXbDIrJhA90HN5MF44QoyDz8rNyQrrtCr/K63sFtR9/HbJwIbX
 RNJHyiEdN4rnL6w36Are3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795014131; x=
 1795100531; bh=kzEDz15we3uMY6G1+g2sEvyj1tnQIbYRCsOeuuINZ+w=; b=J
 6cJ/xIIbQeskU45YbeHsV3apSAM7UY2NbnxFAW5RoEuuw/FxtKocvdOmTt5XabNw
 Hab25hbiRdbi2f3SLFe88RlcQ3m8pVMBvxJPQIdZMD2GjGTsnd04dRSg5b07PANW
 ISXiHkFmyHWMKqw8MJesQ6K62e7WZWJ2ix/ISJnCcw84SwBw9UWE2BHMsrZB41Gh
 wvO1ITC1HvBF4zQjJvywnmN6GrSz1bDpWczXTZZvOh7CPUBb2w3SH5ZreMMb2UEW
 tDWVfZf9PfGpg+dSnE2JLFxqT+hXzM1kED0G6dJQZl48k4JDcqKI6kLmO4i5f/H8
 Jx46rx/eERqzecm6a6aAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795014131; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:iM0yCKloSy5097DxJrfAgVJKi+PVwTa3RiP/yKJO0fJUcso
 s5VhYZO5pahVmoP7L4gDezbsns8Dp2Nu8cjtLK6Va3NqkFkYS+1znCId68SLeFlZ
 yrYWboy9mfmFp1ANIu1N0oCotPoGgS+PNO7BKlo0gAn5gUL7T28xDKMCF9vY8LVl
 ECYJaH/sbv9JNDBMkUXOSvpo1ppQK2WyktYrwkNXf8EE18BXlxUo8EiOOoIys0gP
 VJXKboD/15SkjFxASP847sMu5yuSmuCLoPTr7Il1ExfaLhyxca+bHu5j1dW6eF/U
 FjpELjjoe7nFp7d6yT3HrFfwTR7Q6RyGJw5PcaQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:VTYpfU8QfC2HpKKXIPXec1FD44AjF8Uh9xG+ySf7Soo=:fW4UIGhNlgcc0gkvopQftxX5/BdEwhTM1GNYER0x8Ng=;
X-ME-Sender: <xms:8739atjAGEkmW0-N-AtWS9XQNijcPi3Ws7BU_Mf0QHVU4c0ExBEyAg>
 <xme:8739aq-F6HfYjezcwR-5H-a5uVlrMAtt8XdhBKbuVWfFfvlxV-3JEvUU0e-MDqcxT
 IedmGBmZ7N5yzlVwxnZUZ32uuQTgkT8veyY5gfCReikNyw1dGENcF_x>
X-ME-Received: <xmr:8739aoptqUt3G0uqrjXQQn24Xu8ZK2lk9qNkoeDOUbR4fkfayvP2ZNCwwexVuwqjWUU>
X-ME-Proxy-Cause: dmFkZTEb3vsAhEsk+czLgVLgpYCRht1vdkohoC7UopAIGj3NwdEa7iroZHyj5SkJgWMtSZ
 1c5iEYe4KFRrorvYenfcw5rGx9fJswQlfcMx/rXj9OF/wAw/8kM5R4Y7lXuXMtjHgVNeax
 GnG6V0FQcnP2B9HFSsEUm+VJ35DFfhZIl7EdN3F+3VZ3qRRt3eVBGMqvOC0SNQ8MGyQpDJ
 rWjg3WbD4EDdi9ec2CaU2k2YVfj8kprsW3Yf5bJYnpOqh5fhzwTusvnWXuPgX3CP+xi0yO
 eXCKUtwgyyRkd3Nt1POKvbeUAKm/VTGYmXQbkstcjsd90jXGppRUMoAZM6LjQ8bSFYpMGc
 LxtMkjNUC0WSv52xLFusT6Jwi0RfKI93ZbrxVzDy3PQYCGz5l7Wvi2i+q9yhK3VAiAGnvX
 aiGJGHS1wNpfOAuynI1uqAlSSuHdcoyFZeGCbVubaeslkZPPWVRxBjysQYNZYN1fEVSOdZ
 +oKDT3MDAFXHJU8zAGoMilkb0i12g60Pz0mNx2S7LZbkS+gU+oEG1F2UYZGn84T4TUTFQ/
 7lj1fx1v3GPcW1PwXqP+xjSvutyqOdmfBfeZYm4+DdvV39Z9dWqWJJzAX5vxZeDuFb7/il
 2PqayebKldvhSvj7mb8+EDZnePNOG/CNHyqoisOrdi/+wazaGIp7J9bBgbLA
X-ME-Proxy: <xmx:8739aiXhNg4UAB1h7w9G7U_heSLfdOK3BeAMCtoS9HE7UlwLfe6eJw>
 <xmx:8739anB1hEiZ0dLcP4vptG_SN0H_ssExfOCEtk6Tol9BfV92ZOFn1Q>
 <xmx:8739am0QFimOO9rtUtF-J94lf3JRpi7sAq1pPtbVW2lKCVowyQtWvg>
 <xmx:8739ap27GGLBXajFXsEjsSt1GRlyZXUAd1PaM8QwIqeDxUz7SSbjDA>
 <xmx:8739alHA10h1LUGzEvNybYqhemEga0SIpc3F4_3QGd5jDuSfNx8aL_wY>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:02:05 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Wed, 18 Nov 2026 16:01:28 +0100
Subject: [PATCH 1/7] hw/nvme: get feature - return invalid field if sel is
 reserved
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-jwd-181126-fdp-fixes-v1-1-ed76fad7861d@samsung.com>
References: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
In-Reply-To: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.146; envelope-from=foss@defmacro.it;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Base 2.4, figure 198, bits 10:08.
Get feature will now return invalid field if the value of sel
is in the reserved range.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 71c24dc02b6..ee670481876 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6462,6 +6462,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
     case NVME_GETFEAT_SELECT_CAP:
         result = nvme_feature_cap[fid];
         goto out;
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
     }
 
     switch (fid) {

-- 
2.51.2


