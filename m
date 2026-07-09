Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57F4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtbI-0007wf-7u; Thu, 09 Jul 2026 14:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whtas-0007rk-Si
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:35:35 -0400
Received: from sonic308-55.consmr.mail.gq1.yahoo.com ([98.137.68.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whtap-0006OA-8A
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1783622124; bh=6pmAJjcUB5q8haQTvbnM0zogdQ5zH/eTiLvwW+j9fm8=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=suhQKlawReJfhHuDdVMiNiIWTqvx5x2xbaHPLkGg6xExVCKMGgH1K26YqsDcIbi5w+2w7RSqQFagUGActkNL+cE3nVpyp/FSw8brXuo3wyXnEp+sSiiXL/bWFpNN2upwudI+k8QDtrVrUecy7lILVObvU7QHTSA8HM0Ta6dz8E7GjvLLwQSI6ut4HRbTva45MmAgLgK2uYFpeu4iNPSZJaekvpbBQgiFQhNonC4jMvfHhpY87p2urFHIPNP3Vg3JZ0lY+7pueUKxOHBVfVQQn6bqhCpFmZuFyww+c1DjYnQmopjnuYzGRcItUBftyrO0jdYyyBrZLR94XQoTvVYPsA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783622124; bh=YbAc9UOu0BeKowFlBqJ4iCwzGIb50Lalyd1ZEG25njI=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=fUnxTC6hGi26haE9mXa/MuDpp3fy8jN/LoNjlCjG9Ii6GXE9QAP/iTswUZ7Y6oOD8B845pojt4CEnhXQpLRe1RkX31i4n1J4St5ZCRvm2uqE0JqYCLV6MDB89QYMG2ujuAW2j0jBMJovAlhklk5waqB/CqlJ/LekLFTvVCU0uzCHRWAGmteDTngCsIfGZFQo/i4nQHgukufzfgzySOer8xvbm0uzeMOduZSTFpn9kymr70iN/mcC3ZQ8qF+EqmvBXq6wByl6uxPmEP15t4MoBhQCapQd5ti/gMeNT4C03NSWvkZ6k2IVLylTKjXMnQSPPUs72VtZA1zzRWayHJ0E+w==
X-YMail-OSG: GRRgYWYVM1lHNfMJWOAqwv6mlEfZzZhs37EeWkgCVNkndp.OWT_55kR6H2tdoXq
 .ETG4t.HZwjO_zpFAJ7_3jlBTPFH5Czvxo20eD9rIIBThM7zxDugIu4Toc93DsCojhuTzg4dPnbH
 dlPw4GlgoFGSK5zvQKiqwXu.M5Ixdhtuhx_0jFW2Jqhvn6w3yeXD3DYHP9jtNk32KZzwaUN63J5Z
 VJ3ATZI2sYvwyDBIjaGymjYPR8y1qire.EfHglRcxDNU1Kl5JhAm.mmZO6PKA.FrMlD3OWa42rQQ
 O89TSzERQPxbAh5b5ngCfG0QS45U249A5X1EEuYKAXMtgGG74CS.4JWEM20S6ocQLA0tDi.vOlxu
 FY9msu.axaHpPOqibZKVDCaFJwfX0Wc8GZ8sVaWpGnU7D9EA1wZm4GJqQqyeW.g0OM1WM4nhujha
 oaNArOEqo.77T7T9kNtRvR_LiFyIEAEQ1x6EAQsobpBw5iRDNNanPOJFqEZawCx7jRPsFLUTfJ1N
 L5Lyfo3sf6Y99O_.MZYmMfst1zGpnZK1TFMYwlgnPqZKtUr5cY4xVDIW5FBO9uq9YZxM6pA5GCR_
 G7VB2iMmrYmmgsBMw7H9HYCD8nyLUU4h3AP0G2Im98iUbBtB3_oRe_cW36wszrQBZaNH1krqDM.y
 zQuZhekO8goTh38iFBgqJ4lrKya1gsTH.HNMGVyXErjpoO3xT_jMlOBCbn8hHO3ONBfQYYTROoLz
 GxRVbwxRoLsj3IsrAcKQ8nMmfZai5hX7cvhj_yo6kasfEpjKWU4pYgJoMs0emTpfYiFOBd9iSHoq
 TjjLjA8hQDJvo80OT87IIxh3rXDSa5uX_rb2SYo_6TOTy7d5ba78KJOBWVYfwqg9ubcGQevfCIgu
 Z3ZXe_5Uu6A54FNR9.mWl.xY3xJCTf.X16B.bpOd2nR6x0oKL6Zp..n.kYvq55cbCs5sykRBE2j3
 8Vvj92_NFXHATmwCCdX0KfJ8B2LRosC0o4K8nDelipWxt._yOXPgb5Lf9MaOaDvD.OUmn6l1fYU.
 WXvWjXi7b_3IHONmK8XE7tgMBpCpdG8iBYbGUgCiY5hcwLb1DaI1iMBUeiTJOqx.BqKk9WNxXzp5
 13hLX6_OMWDgNbQ.u4fsyliqrvO51ZW44snYBhOpKGs_3sKgJ8g42J1.cZVLfyRzodYFYCLQsrbK
 1HXzjTZkqXYKqHShUW1gILmuDmwFfFs2yqDlvDVzcrKZgIS4Ax1UOBZ6Uz3WQ9I9g6RJFoiACytY
 2kq2Q6QHmY7pocqnS4r9Ql3WZ.r.T9wLY3ynksaQkBOfyhucg5whcsGOxwLVMBuAP1WOT2aku_..
 QDBmJ_VnxZhZRHyxa.ovx0sVUsESuPj82grjW.JxCrK2sLkTL0_i7_Y2DhabkjC5R_Mh4yI8BsyT
 fF5wVjr_PCeNiy.JGAndz9nYjSwokwSqAKTDhTPmhxG.cnqrmjvlaoPB1wZJ5qvjdl_AH.33UpL6
 G5hdv.VukPsH5s72Pn_FRdkjTVruVtt4vngswTeaPziJxkR.JVXC7RbxNVT7XMdgAeDrh6I4Hjjm
 yMmZtQZB76jFCUPJ_MyVpw.r213wT3i3oT515hXEFj.ZZDKzV9bYOcfZdE4Cu9lfRjKb6lSbmML_
 o8WMozzRPnR4CFmTr4iuCgkGrXRPTr061UNwEVBJeHvrmjuloYCQjXaUxKLDZdk7qjLUOQdfnZ93
 Wuc4zZmImORw4xQC64R4rs4exmhvlNJmQCmja2g1qUOdkSJ7crONCZFn39ZJ1Y6ap4FPCUQ0UaqL
 QBelb.AJKlas6UhLfLu7D9k8kvGwFPS8j8aS5Lm9eUFbKzr0IGrw2xEwwxCPkzg6KHyi5oggzSTv
 lcwrh.C_KV4pnz3S.5PGUxUqtFoka4p0NuCgJEUqps3rLsLrdl1QD6Zp8sl.vudykpiPFs7eat5K
 PaU4dt8jASVK.3rpN_E.NfoStyMtA87pjTtizpPY9VgD6BCKIr8FUMVco_6CTqyBL6PNvTAKBpU8
 Q3uAKTypnumQBzXDjS79fld05MtAP3DLfbje2h8LVmcL.D9XwOdEde3VLZ9XI5Im2q5Q45p3IBtz
 IjEpQA8rEBntk6f7gTJeLVviJtrlWRWPBwz09yc69u0a6BmXXrDYI8HOEyYpWdLbsRnZI1Hs_v0.
 qqD_zjSBsFe9PF6DtMvFHfy2kZw5RsK5G9x_Doby4q2pbsE6Kf4S4DYx1qb1S9XmA7ZFqPQuP2e9
 JWoAQCWRgzmyj6YMrH1yY.xI7j9Dw2yPnw9qWt2U-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 7cd21549-264e-427b-ac56-e248d8c18734
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Jul 2026 18:35:24 +0000
Received: by hermes--production-ne1-7568ccb994-fjmzg (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 910e3b4d72a347495c18993f77062a0e; 
 Thu, 09 Jul 2026 18:35:18 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v3 0/3] xen/igd: fixes for Intel IGD passthrough
Date: Thu,  9 Jul 2026 14:35:13 -0400
Message-ID: <20260709183517.25866-1-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260709183517.25866-1-brchuckz.ref@aol.com>
Received-SPF: pass client-ip=98.137.68.31; envelope-from=brchuckz@aol.com;
 helo=sonic308-55.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This patch series aims to fix long-standing bugs that need
to be backported to all currently supported stable versions.

This series fixes three bugs that cause problems ranging from
a dark screen in the guest until the guest OS graphics drivers
are loaded to an assert failure that prevents the guest from
starting.

To test these patches, it is necessary to test with older Intel
IGD devices that have support for legacy VGA bios.

The patches have been tested using Xen 4.21 and Seabios 1.17
on Fedora 44 using an Intel NUC7i5BNK with an i5-7260U processor
and have been verified to fix the bugs as described in the
individual patches.

Changes in v2:
  - close open files before setting errp
  - improvements to readability and style
  - small corrections to the commit messages
  - add stable to Cc list

Changes in v3:
  - whitespace fix in first patch
  - fix Cc address for qemu-stable

Chuck Zmudzinski (3):
  xen/igd: get PCH info from host sysfs
  xen/igd: don't register rom bar twice
  xen/igd: fixup device id before registering rom

 hw/xen/xen_pt.c          |  5 ++-
 hw/xen/xen_pt_graphics.c | 85 ++++++++++++++++++++++++++++++++++++++--
 hw/xen/xen_pt_load_rom.c | 18 ++++++---
 include/hw/xen/xen_igd.h |  3 +-
 4 files changed, 99 insertions(+), 12 deletions(-)

-- 
2.52.0


