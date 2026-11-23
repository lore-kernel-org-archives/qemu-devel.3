Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880A606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=R5r8Y0IV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=C3kwjICe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVfP-0003sX-G2; Mon, 23 Nov 2026 10:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbm-0001Zm-Il
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:33 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbj-0003lC-4j
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:29 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 641A1EC0BD6
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:05:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 10:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446313;
 x=1795532713; bh=ojhzdGGXFvx3Dhwy6MIJtVTS5wDCuTn8uj1f1w7azk4=; b=
 R5r8Y0IViXcJ+DJR0ROO9wWM6MWTFVHdsgHFkzgxqFGiQSyF1DMIA0rdGq/VrYXG
 D6ArupUyab9UC7yStKbmDILoNr7suXMVJUXFFDY2mR8LiejQt8r1yF0F3QtiZXpH
 iLQl3eiu94BF+rr4ntRauFQr9jBt49JAQnuil4f5+WiLFIZ6Zj/1K5MwYd/VDfTr
 izPYqKeGc9a1PZcp4/fpeEz/3wQIglYvinvgvLmvYtLNJFiAzJeILCitM2Wz4UUP
 +OOoYpU2GdTQGog4fc/zeuxosFgg1NlGEWPZvW8dVRjanm9EQjr6LqZEWJxxc2UM
 N3fRdpiKlERzPXtECc8DGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446313; x=
 1795532713; bh=ojhzdGGXFvx3Dhwy6MIJtVTS5wDCuTn8uj1f1w7azk4=; b=C
 3kwjICecAZkXCLruJN8IRTrNt2eICa0AkegpYb3Nomx2MElBWNm5Tpvzh+T6eY/C
 N2MyzwHdhsWCg2fGN1VSyLlHVZX1yMjtge4BF5W3DpkYwD8bSzIolAmffoS7Sp5Q
 gfiJdC6Qz102s5S1LFFBK+wHZdCLdHk3wr3cXIsxencARv5zm2XAXqMAZ8PMeDja
 QrxKOuN8tJgNV+TvqYF1i/HC46PykCHl0fv2dw7Cf19ngb2L9cWhicaIYlagnL1G
 UxZISSyZg192Mv/+8C01wwtwRkSQf+zC//+JR2XHM8pMC+Q8QahDJMk1EaOevLRz
 1lLrl54PbxHFg9b79zm4w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446313; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:Cq65OaZUQvAyGp9fZm3LiN2NftWYT9T+vF7E+6jjSvSk9b1
 7uB8+U/73ntcgNhNK1KQ8yAjlCeFzQtlsSEfcWLWOUG2sd+N4bvZU1kDSq+T0xhU
 cDeVF2e96wZpV06U6HUcqXiRMnQFZsT2Q5eJ+s7q3YU7+PTf75QrKChUtU6jvTee
 +b4oHJ3GX5b7xSD5lw4McP5my7ROHVt6FkFlXImpeKz+LHmLAmVI2sUNXXNZzkAN
 m70yWLUZBDuMV/ClmfwSusLOnYUyN/N7L2ldxQX7JNFB3yBPY8ln+4gqT8xBQvv/
 eypi3wDaTCQUvOd0UlvK85O2raM4snI6s2HPWng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:iJHV/3V+wFIN8qXBc+RlRFjrwJXMcQ7qQtF/vEt6Qt0=:a7JQv2li+2rl9/s5C6n/icsea1O7U87V8kA51sL4VnM=;
X-ME-Sender: <xms:KVYEa4hRwNFNYEanSor4uWQ7Og7deyGoJzyHzEeR7bnKHDi4bs8Fkw>
 <xme:KVYEaxedJEMBdCHIAC9HlaQeVAFPxVDc9TJ1l-kmRFDi88Z5LNPsYPk_5KCq8e8C7
 0sfhdYVcTBxS6A30cGvI56alXEjA02t6slywe1O2hzMMZviT_9kgZgN>
X-ME-Received: <xmr:KVYEawyJ9Af71uwrc7_KuMicxadcGscyp09tmmqe1oCN6-Rmi480Ont0JIit8U0KOTNF-I6_Ye5_g-UbfWpB78LEcHFzpwrG6I-S>
X-ME-Proxy-Cause: dmFkZTGpN1rBJTFZcUspkdSSqlrg1IfSnpVMDRVyTBWv9kgTmg8tHFw26b1+BcowUMWGRJ
 t9TYy9ClKuqpekAm7MzxXjHqjwuDlynFQvsJt5wBH3CCmbPGBrWGcYd8Mh4m/7tckYUMkP
 ZCxqTV3lXQWcoGiFjzn2AwpVt6k1R4P8ub4H84/VYAI00dspKZI6Cr643BwsJJA+TXii8Z
 Xm2neNXilO0fNMIWbOz/s6crele0aNSAcG4R7sp0ic5OlDJg9SjXLXUI8iL2e9bnSKeLqE
 M8uKGNVfIp0DDdlj2tKwmtcaJKqAKqaVpLc+pQy+3eExsJoWauZpPmMK6Uu9t2dN20/5Xj
 07wcXQkJrvoHZoJoKFgRlTbXXPvCRuJhXur9PV70QFaaC/ozoHfTtcisR9ORhOkBry6s55
 JKEqiF85pAV5ciCtvv36KLjkg2y8IGZipJPoZmUbQjd5+cIalpydNPiAL6YBq3WRu0BjxW
 dfZehWEj+/3n3HDiEjabvrrK4cIT+YLRZymdve/N7k4kPXajh5qJTGvGj0UxDKRzD4+HRQ
 A9bVmg5hGerxAJ2AlpxLBohn6Xsmw1VSKE9cSTrG7M6/A/r6nivsBD9Q7GXj5xcMpwyNSL
 ifUccxkwUpggs5S/4cdpsSEP5+YzWw/RpbjgZBjtDVm3DxgfeEwpTwNv9t9g
X-ME-Proxy: <xmx:KVYEaw0JG02g7R_TCXyoQZHYrw47eW1rtcTXXHqd1ShPre8gS4xAcw>
 <xmx:KVYEa2zBRjBRKVfpWfapFI4aKDG0GbwIOHdr35E4fwHR9n43TVardg>
 <xmx:KVYEa1Vk7Efsu73TKSiYohe3JS62UQIOGJoWW9lPkxVJPUlFHGBiRQ>
 <xmx:KVYEay_uRJJ8A65H0HSOi9hE6psCd54HQz8uPj26SSdjTKIA8BshRQ>
 <xmx:KVYEa1qB2vZhSjsguAq724SOEzucZT4XC63EVvNh7s9Vm7tdIaIs_Nrf>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:05:11 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:57 +0100
Subject: [PATCH v2 10/12] hw/nvme: clear OACS.NMS bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-10-4c9893537cd1@samsung.com>
References: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
In-Reply-To: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
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

From: Jesper Wendel Devantier <j.devantier@samsung.com>

The controller advertises OACS.NMS (namespace management) capability
support - but only supports the Namespace Attachment command, not the
Namespace Management command (creating- and deleting namespaces).

From the 2.4 Base specification, 8.1.17:
  A controller may support the Namespace Attachment command
  without supporting the Namespace Management command.

It goes on to say such a controller shall not set OACS.NMS and
should support the Namespace Attribute Change asynchronous event.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4caa4a2912f..36e9bb3beea 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9359,8 +9359,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
 
-    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES |
-           NVME_OACS_SECURITY;
+    oacs = NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES | NVME_OACS_SECURITY;
 
     if (n->params.dbcs) {
         oacs |= NVME_OACS_DBCS;

-- 
2.51.2


