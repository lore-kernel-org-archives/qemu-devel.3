Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274E60A2611
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=s/qzx3YT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qKkkDTKQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThC4-0005bY-Vu; Wed, 18 Nov 2026 10:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBa-00057K-Po
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:03:02 -0500
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBY-00041Y-Dg
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:58 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 6C00BEC0B2A
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:02:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 18 Nov 2026 10:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795014158;
 x=1795100558; bh=Onwbx4NMD3p8ZoZCrfkgIuSDLU66ZJYzge3bvl5jUEU=; b=
 s/qzx3YTdtP3DbPhZshO5Q+MEBpZrsSuIklxgv4iaGbn6OluqMM6qnM6VoqoZdfa
 dr7qPFNJq4FOEJZaBMK2hhDVtT+OPpoX2ZCR81cAL/FY0/b2F7d/9P5GChGLgfYs
 iKZYhLQj498wLbDoHhvh9czMgjVt8xrydXkkcb3yZgJ0KRHWnuzS74APCDNMyQos
 khEnZ3La/RoRPulQg8G4PiRuz4rf2aVg/tL9ZBRDGyiAFoHJRV49XjPrvIUEmkI+
 6W5cLfX0J+Ha/EANwgrBgwlfSDUssy3rUc2nriwiJ9sgO1gcRwiDC1CyTySRWHQG
 aHlefbV2+NTJCdMpNgWq6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795014158; x=
 1795100558; bh=Onwbx4NMD3p8ZoZCrfkgIuSDLU66ZJYzge3bvl5jUEU=; b=q
 KkkDTKQxkOXXnRad7pdH/zJVVQPvzcUaaSx7V1x+6PRaRbIPQCt4cQIglVZmwIzr
 JBhX68QmlqunvnbHCaMmrEDRUEDk+Edn3cZTFoLSeiKb+zveg9+wiQ9KMyfZ8Wm6
 qX7UhjU34OVJxraKv0SXSt9XQfn7YA6sT+POGVjzi1LCk0BWy+EFQTSfSvOspC0p
 vAjijkgxJldWxsi2fNNFwYRdXFcRSCMIySadnmehonTjVDMIo6N1pIKO29SQ5ciy
 A0cZy4XQyvrzF3CRUbl6beH2btAIcCHSOTiPt4WzSQFA8ivYx+6fWgAH7RNMASL9
 zz23GCVmhPwLb69Pr7Lbg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795014158; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:Kk90sjluvFZLgEmd86jHw4CUjaiCdP3aJpf8l2KUnJgI7a/
 BYRaj/89UsxM4kczMvD4IECKa3nMHoiRZwzL2x39hXzx0PdLgsARJHxw872U0rCF
 YD+Qnc7XoQgsmXlQth5w+rm+OPPIcJ9agZjF9rfw4YK5zcJ08Wt/fU+2/xo8iNEQ
 WZFZzMQQATKla88QtGHyRkniSP6U0rMfrAHcdEje+2HUCKVTYbnfIprrh2gwKOkd
 eas4btIwVhdr2qlcUcZSYnuyOwpogw+JqwwpwN9lcn9uc2KrJXbqxyD0ERMVvi5Y
 UDnzZ4XsNN6EU/ilh32xbgQ+qNd2hpfs/UZwKCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:E353ufy+NNNuwgy+nYlSjoYNJPy6XEl7zogHFcpe4xM=:tPU6XsbfBMjkhyvqw1CVoOc3DS69461J3iJTF7nipYA=;
X-ME-Sender: <xms:Dr79auc6WtO9YEK5zwWMVDX8rE2MgcFhzKaNNHS6VO3vsWaZ9zCDFQ>
 <xme:Dr79ahL4RrHdVUViEy92-hE_Wk59Drv_doXw38CtTlGarm7nDDmzuGmdm6r7BN3F2
 ECsgtirJ7RVku7qSAgX5GSI3O3Np_bhX1GCdPI_PjjgsZdbUsD-VmXd>
X-ME-Received: <xmr:Dr79arET6eCkpGPCv39gMzUjvpJaubHqGg4QF061IiW7FZvnGGk2cHbmEXrrLZZKlm8>
X-ME-Proxy-Cause: dmFkZTEb3vsAhEsk+czLgVLgpYCRht1vdkohoC7UopAIGj3NwdEa7iroZHyj5SkJgWMtSZ
 1c5iEYe4KFRrorvYenfcw5rGx9fJswQlfcMx/rXj9OF/wAw/8kM5R4Y7lXuXMtjHgVNeax
 GnG6V0FQcnP2B9HFSsEUm+VJ35DFfhZIl7EdN3F+3VZ3qRRt3eVBGMqvOC0SNQ8MGyQpDJ
 rWjg3WbD4EDdi9ec2CaU2k2YVfj8kprsW3Yf5bJYnpOqh5fhzwTusvnWXuPgX3CP+xi0yO
 eXCKUtwgyyRkd3Nt1POKvbeUAKm/VTGYmXQbkstcjsd90jXGppRUMoAZM6LjQ8bSFYpMJs
 w0tfYKmnE9LrxOcRi4gCHiGagi2gotEwJp4HvNmhBQ6T4fwCozDm8UzGuxwIVQjKZRNWAE
 gJA5PTWBnAPxaDeLJE1G1B0vkbfKt4HgmFJ10LWVPhkOWP9Tz2eLxzF7tVi8PRJQxjyTky
 IvtxT1RmD+9QYpeo2vCDxKut+KdxLQhs/IclqNVZW2k0JrGsxsPANjPpB6ysebw6EmNYtj
 g2AXZyqKLttj5qn10+DCNdRPQ6qzQfIs3b428Y8+0qDNMVupQmup2s/+32p4DO9SgUHvIk
 5jr5qX+rZc3mFUNRcyf1nJRlXEas/b0jGuyidIjZxrykSSK7pavu+y+fqDpw
X-ME-Proxy: <xmx:Dr79asCpi8fQJf9BwxoqD_iPWhDBBGAI6Vouc8eZSqx3Oho1ZZmE2g>
 <xmx:Dr79am8hvbZIGcAtz7dMyicqDEziHf0DFg-eDWEPvLqJnsfhGPblLA>
 <xmx:Dr79agBm0rISx7cG564dpbrXdhlwZ7NfiyeL7NOH3VPM2XHD5ew7IQ>
 <xmx:Dr79ajQ9r5lq5d9ITn0ffmRjXc_gJgKGT3tNlRDU0yVqLKiAuamyOA>
 <xmx:Dr79apjjXsLJAmf0W1o-C8M2lw33dgT_cKCxuqEKo9AvvD9hummOTfn0>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:02:35 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Wed, 18 Nov 2026 16:01:33 +0100
Subject: [PATCH 6/7] hw/nvme: set feature FDP (1Dh) fix
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-jwd-181126-fdp-fixes-v1-6-ed76fad7861d@samsung.com>
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

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Shall only return command sequence error if the set feature command
attempts to change the current configuration AND the endurance group
has namespaces, still.

Additionally, check that the FDP configuration index and endurance
group IDs are correct as well.

Finally, if FDP is not enabled, thus not supported, return invalid
field (invalid feature).

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d82ff6793ff..95affb25c18 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6877,8 +6877,25 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         }
         break;
     case NVME_FDP_MODE:
-        /* spec: abort with cmd seq err if there's one or more NS' in endgrp */
-        return NVME_CMD_SEQ_ERROR | NVME_DNR;
+        {
+            uint32_t dw12 = le32_to_cpu(cmd->cdw12);
+            bool fdpe = (bool) FIELD_EX32(dw12, FEAT_FDP, FDPE);
+            uint8_t cidx = (uint8_t) FIELD_EX32(dw12, FEAT_FDP, CONF_NDX);
+            uint16_t endgrpid = dw11 & 0xffff;
+
+            if (!nvme_fdp_enabled(n) || cidx != 0 || endgrpid != 0x1) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            } else if (fdpe != 1) {
+                /*
+                 * if call attempts to toggle FDP or change configuration while
+                 * endurance group has one or more namespaces exist, return
+                 * command sequence error (2.4 Base, 8.1.12.1)
+                 */
+                return NVME_CMD_SEQ_ERROR | NVME_DNR;
+            } else {
+                return NVME_SUCCESS;
+            }
+        }
     case NVME_FDP_EVENTS:
         return nvme_set_feature_fdp_events(n, ns, req);
     case NVME_WRITE_ATOMICITY:

-- 
2.51.2


