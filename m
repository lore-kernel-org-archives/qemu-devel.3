Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CD3C2A06F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6uj-00075V-Nc; Sun, 25 Jan 2026 15:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6uh-00070Z-Pk
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:51 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ug-0006Dl-B4
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373642; x=1769978442; i=lukasstraub2@web.de;
 bh=FS55Ktqo/GPPNIi1dt6u52WzyIntGAB3iXYHvWklJJ0=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MDs/Ovh1ycGsxzJnd5av4EWsKpPAwDLjkZzvccMKzh2bc96kLyEMz+pw40R1SYdo
 fy19RPUkqXTVVjIK6EeITew980mLd0i5mNFCdabjRxYkZ019QVQ3rzPCFSCESRCdN
 AaXN7mmWpteSyNPgdIX08JSd1Xr6TuvjTuOrPJYS+wpEz0yv+0RU6/enNJrwVlgX/
 v6StUcdojm5ZxfTI37becvKi4o4wgONPnwyRRoPMnR4CHyvI7vSpFq7z9nUGlVWJE
 2uhr+dqsV0xQJ5WER0yk6KnS/cWxd0tC33APs9AjAYIpr8OABYStorSwcurkXpxT3
 vDj3Z5OOUKdmID31fw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1wLdWD3Mka-00kbwe; Sun, 25
 Jan 2026 21:40:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 25 Jan 2026 21:40:06 +0100
Subject: [PATCH v3 01/10] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260125-colo_unit_test_multifd-v3-1-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=CaPOTfjUkigcqVlnftshkn+8clddI9wXrPrNEx+DluQ=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn/F5i+nAODDDTqSeqvhH3QHXxq6G2IxjA8Ig
 J0ryPr2waKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/xQAKCRA1qwsonF2y
 WL/7D/9WKjz0TAPI4t/82ODc+PkzbjwTfI+bek7iEWozZC0lOkMww2B8oKTIHeAxpg8mEP5DLb9
 8dSFPzddKBQje24kqzJzUVu2080dAy4N2g3HR4+25GbuflhzacvLibRw2pMN3rEPk4m+6SO4oTp
 xl9SXyp9W8XFL6tHGpFxqTuChqKwCCoCCKUIkdCSMaHWLs6mdkr+0fqSNOrB8yIF1I1iqZkr5cU
 U08gLhb3IFZapLZGMiu7T3DlXiKQx3Xkup/7pGNpY2X5UPUrH/HtDNnhz6qWMRqftBvP2B63Yvt
 jgbWZTyKebmXf+UU8WCitucWnYndWX37pwMD0bEu2/9jYHfmBKUgxCWD3VV6OW9NAEz//7edSUE
 2bdsQirAn9V3x0+Gz2edC2+W5HGl3aqn3blgLg8dreMgBBNv4etE5MFZqInnnlgnA2V1cItnFs9
 SaVjfAU+5wjo33c+RMHU9aMMoNQ1Vnln4LuXyxxP7utv1/4doQycTaHUxW2yiZhnN0enSSfhz4p
 a7BrHlXTtiWeboZY6iUK4dmcPMWMRs3SM/N1NCPBePDmE5EXXMd3G6lhnny2O6CT5N2IOhIKrp9
 SK4JhYsIianIegB1TKCL4VOIaHdQroQX2I+IjUEn6NJxmHjLBzs8QOrEO64MiLY+daQD//avHEj
 cS8aZQGRMoslWSg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:qherZtGK0jmSNynn5G7n0jnycycB1tHgPgnMtSVDY7MHJ4suxGD
 SRWVHyMc8u2hTJWvP6o0o29b6GQ8hM4y9tGqX7i8/pT1Wpb0BzV+FLp8SeJjBCvtU+3Lu/K
 xuHtlzNlH2RHmk2iNSfS4gg9OtSFyp18A6iL9GDxRQxgOXFGLkOrltOh9Al9aEQjoBqLyO9
 fLDJ1cR+VRwEjXyfWUAmw==
UI-OutboundReport: notjunk:1;M01:P0:J3cERKNBK54=;N0UT3y8IAOL8I3uZhGDR+1BMkaE
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I am ready to maintain it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e23354235dc70a6224dd00ce92b0a049fbc8edfc..689d79b82d39ec8c2bb15dacb7=
928df5649756cd 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3851,6 +3851,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


