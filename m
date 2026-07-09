Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A803FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whh0k-0006jP-Qm; Thu, 09 Jul 2026 01:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whh0j-0006jE-GC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:09:21 -0400
Received: from sonic316-8.consmr.mail.gq1.yahoo.com ([98.137.69.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whh0g-0005li-4S
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1783573753; bh=6kwiiz6vzXFsU52pONZLCow3uL6CNjnBbJwtIEwpgSY=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=Y7XXAh1pgxOLbetVg1cQAo2tZIkS8Wpy5RW7fz2FytRq5H1jFuI1o5uTU4rr08zWR6G88rXFj55UK20RC7/qMuBcmscehyK0nTXoTwKaqI8m7BX/Qh227TY2K79LLwDasa151k3ZqLCJAWc81Vfc/nha6bB5TyoZh3uc1CO6+TAo8LAMxmk4+pj8VRinJbb0LsBCUimR/DXtZYZ5upNkYOaOAmnNpGerbmjKQSUmD1fjWnYvIkqaUZkQoDgovZZ/XRuLX9bGUVtKsuEUCY0hzlOWXgNrGLM/TrtMtpIX7I0mRlX84WGWy/GTbqh9Yv8qr0t5oAloegKYjceGsYlsyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783573753; bh=Ek45+OKSiXAcv9KamB7PZ78+mUV+bMCwUDE2T1wXqe9=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=YAAG6OWHIzrG7ailh8b+SKpRWY9Knnt97EHKef61a2Sl0XAFrT8d9QtHFjSvfWLVQPMsoc3nj300Koiujj8SQ91q5XYIjdvzmQ68LnSiK3hJGHeCJ4PQ4sYrfXdajuSFxYYras6cQ0BiuNm7ST49JBD16xnso9B6DVbafcNcgJazqACYV/sOjr2+u3CXCUrZGrlbKbdCqpRfKmZNOAOMsLd+jcDanFXQPVhsnCrPN5ne2cma4Ej8c05hfYJlulmg5RyzVHDvWc1WW0Fr8BrC23+9r6r/CDFZtPj9E2A2z9CxoAOHq210bs3MS2l6ndpNq8vVj95fxWs5e2Q2y8jOHQ==
X-YMail-OSG: LxuUNu4VM1nbkAESYw17s7ue58ruNL2157YCsZ9.hRe3OyY4SrQOjJHQPkUgmJ7
 HT.xlgKkrTd.Wev5uGNaT5kCxO4_pQj2p5Q34tIwouv03MOnL_psQC9.xxVJnfkwa96vcZvjcabS
 BddlNPjOEiN9Owjw65QdwCLzbSUWOqTc0r_lOmgvOyOB6R17cW4YzeiW.YWLMHOW9tK3HtX5E.Wj
 ePzkcNefNdRjDyp5QEBXcpp8LnArRQ4cWAwKgGo9dzQg3eU5cx7.l7TgclFV3C69l73RC5WBZBNm
 oUOSHrXQilsMVEUU1SgF.5ACgOgy4tcxCrIslceMJSWPkIY4Rg4A4k7Z8YuK5XQuhvdAd4v_9vFs
 tPBYgmusek4wLwc2Oy78QmEmUj4Lb.wLLjj3y6WSPqaH_9qi7k4JxrCJWOAX9z1MR86ajXFFCsvP
 TUDW4hAg5oK8enMJP4VaZe_kFBWai6UxSoNSL_4UsQO6z3xnlX7JoM89X8etEj.MOjp9Vm5qdssZ
 048Ittba2zbBTAr2pwz8zQ38_3PZwLKTdL71Gg9eR_Yq2UVg7gtv6HNeDgOErCrxyXYqmdn.vUch
 6GCeqish24L6a6AJre3jgJe2oKaKdl9Zt_pW2WUa7UVyW91aAFtmYqzxZDz3jlQJjBWHAQulaQTY
 4g5FJXSU4l52S5f0DDj_aURb58CxsWsrL07i9ffjG9vFQePK.XCasPlIlcnwAXLnIm2qh.bZ_nFi
 BojN4GnfY2oz.wj9H2.R8KuXuvt3rmqPiT5vWzdom.LC4Mu6uTcIuoCTfhK.sz0pzp8jZC.IGuKp
 db2c4bfu3QGxLS7Nxlv_QeVfWvkQEFBT5FPR0FZFbuUHEbWaSs1Mt6WmgfMfbxU7eqI9lKaXEGPg
 ob095DghtCeDPwfvPIAJxAqDbHV7FBCx9uZ0QphZVPtE12eUqhXCHsR3kBDe1jv2zWf3YByWWmR6
 OAMFJyofU1GPVTtUjjFJj0ck4nfKPSNFUOQqM57hvF5qEiO1lFJJSN97Z4IFZkUlm0Tq9C9pqBR5
 cr.QHFXXFHxisMx5uiOzn7cNc2AiaGlCxuN63DHUcxjiflN96iPh15KhsCUb8.uM1XhA8XpuKF6R
 mH39Fji.RUfGGxRYXyx_LRAA14Q1a6Ikr5Ay55.MM_WuecwbizGW1qxwkBjRf60wdPwtNHK4zMT.
 nru85l_P2XUAjq0hs8xWssq6PjAjZaBTgZKbrrFVrH9yLR_qNsNo1GLMSKZbiVquylK2MYMZF1HL
 d0NWHiyf7S4B.RfqxElTnANhQf4kVF5aD0mQLxxObJXdAqM4eSAX7fSQVFW7X94jqxECKyRzJ6vy
 kNf470kzEz73s5Qhj_brHwG3.SQ1MY7jnBzUOogDl9V1cfzQxC9dmQdPPm_d1d.3H9SXUxQLjtkl
 N4FWNmHjGJMsp7qglL_iSc99KEIJ35VRDefjCyTFIYvihHmoOEuBbjfpTDFKkLOS6IKBobDoQyzM
 1DqnTg4PMoKi_IEocRSmbKLa0LaCWOEthVPiDqHSfAbaLQTO3BoA4vnhB78mtga_BAWkvdX_2Amf
 XBsptAwt6bjGNC_0sTLM2IppcCs0QJ_7ll_REj69L00zzfw0du9A9wcjuJrtH_2gEBIkwIwgE59y
 abShkIkuMR8mhwu3jKJ.obzQVOW_M57yDqgnunbPCImjwUdzTeXVoxHFNtGoUHNQF4OccE8ZMVfe
 Ub8QBCMYBjgt7duZrvfvc6gO9VYsH6TWriZVisRnGdBEWEgZJ7JrkJ0X_B0viUJBPaLvF.0fNurb
 MMXeStp7q8sIHiz2_qZvWW_mtj_8YCmnuU8CCdsUPFsbZjuAA.Zw5SOr6Zftx.PcTZS8NhIdLoAH
 pyBtQto.mqqI2XxwW0jdXYrfGl64y9EF.mn6w5sEOtjcqTYdqM_eInGP4U69y3QpCif.H6UaOR6C
 FOUnZMEVRBaB1Y3TOVTzM_aGWILpZtNcoL9eEUHsZ_vCIIZz4vJdJ3yDIYLwvbOzY6wtZqkhemRg
 DqPNpQn7RDrmQiOlnN4wsvOu3J1aRnsUI.DjNMRhmaS3exCJqOmQVwpI7uLfiCi2.wn_NOHAHBx0
 E502eniGqctY4ohr_A8iYZN61USvBs1KE9pTHlBOww5hGrNzPNxNTCThx_KWc9S4PY4wGcEj4_um
 HyIA3L_3ZNqG4iE6OPLuBiqsAReKFwKAVuSHnwNgKwsj6FOU_mCRFLs2EbH6mmd1ymOyAPy5k2wN
 oTrCpQnLIuRn8o4IIxeQi7WXgzCph
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 5bcfd46a-86cc-45df-a695-4da8c90a8007
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Jul 2026 05:09:13 +0000
Received: by hermes--production-ne1-7568ccb994-mqdhs (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID da73cafa7d25cff72b3b6899257e7b9a; 
 Thu, 09 Jul 2026 05:09:12 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 0/3] xen/igd: fixes for Intel IGD passthrough
Date: Thu,  9 Jul 2026 01:09:07 -0400
Message-ID: <20260709050910.8217-1-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260709050910.8217-1-brchuckz.ref@aol.com>
Received-SPF: pass client-ip=98.137.69.32; envelope-from=brchuckz@aol.com;
 helo=sonic316-8.consmr.mail.gq1.yahoo.com
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


