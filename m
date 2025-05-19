Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB2EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 11:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGybm-00049z-R5; Mon, 19 May 2025 07:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@protonmail.com>)
 id 1uGybi-00049l-J2
 for qemu-devel@nongnu.org; Mon, 19 May 2025 07:24:34 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@protonmail.com>)
 id 1uGybg-0006o8-LE
 for qemu-devel@nongnu.org; Mon, 19 May 2025 07:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1747653867; x=1747913067;
 bh=5Vtlouxk7O4b23u6qfPQP3w/ezeYuTu/3JijUt8MW5U=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=YrmmYksx1kJDqftPu0g+sUVVEnPjpv9kwIapcKw6x8NgqzUZSccYtniuZw27WI+8S
 xs/en9RgYQHo9iNtUvXivNd/iSAQ4WGk8CtzbqW2hkWZvBHncxVRf6PFfH60mdOvPh
 jcPTp9TnfK6L6uafbBDTfyLUsdmSftpLwAAq7osdyGHFx3dBkayUWYOTqstwkyCINg
 JFmRfYEom7PsZtqUr7u1090h9x4fgBWPlF1u7V5afGtsL2lqIzeJIHgVQFVwOHIuFK
 x4+Ytf39M0qsK+MaNAErIMqu2YZPLeamPwXcDrOcY/wp0ZijuENxdU6rBRNHPCOGvs
 1BDrRw+6CF02Q==
Date: Mon, 19 May 2025 11:24:23 +0000
To: "clg@redhat.com" <clg@redhat.com>,
 "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>
Subject: [PATCH] vfio/igd: OpRegion not found fix error typo
Message-ID: <MFFbQoTpea_CK5ELq8oJ-a3Q57wo7ywQlrIqDvdIDKhUuCm59VUz2QzvdojO5r_wb_7SHifU0Kym3loj4eASPhdzYpjtiMCTePzyg1zrroo=@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: 257f01cb9ed146fbc40b341b99cb4ab1aeea886a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=188.165.51.139;
 envelope-from=edmund.raile@protonmail.com; helo=mail-0301.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "edmund.raile" <edmund.raile@protonmail.com>
From:  "edmund.raile" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
---
 hw/vfio/igd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e54a2a2f00..36ceb85212 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -203,7 +203,7 @@ static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice =
*vdev,
                     VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
     if (ret) {
         error_setg_errno(errp, -ret,
-                         "Device does not supports IGD OpRegion feature");
+                         "Device does not support IGD OpRegion feature");
         return false;
     }
=20
--=20
2.49.0

