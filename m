Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDE606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kDcTUxYh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EjKs88fk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPEr-0008F8-Ax; Fri, 06 Nov 2026 14:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEL-0008DQ-6f
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEJ-0007Eu-E6
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:04 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HsvKn125541
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 19:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MDvG/za37hcvko/DVkxeRJhzvvtsV6yT1HspPFFWa3k=; b=kDcTUxYh2ZJlMc30
 v5WSKIMBK0FsniaLWq0sMRQgZLdfC5GxX9ef7QXINHPkpLaQUWvi1eSE+F2izJ3f
 0h1O1OCqy/5dgbhIlFbgecUtuOlB+hr4Chz8/V0GO0Wiwcy05/hPudItylPgT+ag
 1sWve1JBRpl1cj3iFKGcHMhyUIPTHYRpcXDrEruslvEP3dHeGijjJfA0BsFWvT5Z
 siUoRnvkKyHI+N6c3/BTpa4gPzL3NFwKSlWeh73wSqbnAHLioN9yXYYB46Iukki0
 m+Rb2EsLkKUrzyCinA4SKooFIsyAz7ToB2Spe6fgHJTXprrRVhOlL9Wb6xpVv6Ah
 GxE6Rw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk48rf5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 19:04:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ed05b3eaecso8261525ad.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793991841; x=1794596641; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MDvG/za37hcvko/DVkxeRJhzvvtsV6yT1HspPFFWa3k=;
 b=EjKs88fkNKgXnfny55+7EXQk8bZVCRmjl8O0OMivsmkYTwJyDHB9+EoNmGITKrYCOU
 IQTiHr5b7ZouNaRENh/siAOjti4u1P0TIm3UTY11j1BJX/5JOPvNo4w7VoRn8ndgkjiu
 IBsXyLL85TXuBj7PWZBTxUZ0Vda4tIx0iYzIc7moC7luJs4RTfM2W6TGonRM7h6VK0hx
 L4Tt0G1sglOWeue5LOS2fQppxJq0HyTdyoM6qjnyn3eQGf2+GvUcEbFyJC/P5CE6OMaq
 vNC9aBgHj7tuCNaCEWO9nEdv3jFxYwEYsp/QjMpu29Sx9UT8A38uJnX31BsRddc1zymd
 0MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793991841; x=1794596641;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MDvG/za37hcvko/DVkxeRJhzvvtsV6yT1HspPFFWa3k=;
 b=PpeBDdPI9zx9hCg7fqclk/x9kjdi30KNUsOmMzBlEZ5yAgmYi1mQ742zBSMgp0S2HR
 bf7ZWq/qvT9hatn1+A0TNGV/Q4rpeiQPLu/Mw9rTeg0yPUVsyGAF3jW9VDrD7QBkmOU4
 RFY73ax5SglgPn+10uYH7EVtYJqF6waJiWRK9SOQaPPpT7hsZoPd+7kB1Su+2I4HDrCY
 41sJK4AC0TlFqEwHvAbS40DZDwcMxZTUKOy5+hs24YhbvbptixAh1TWfIcbAAkshjRrh
 LJCfmrUFB4DMWBIroo8Zw3zGTOQ0mtHFYnpgft8pz9SyQOT+VPFvd6fdnxnySaG3jbOq
 NAXw==
X-Gm-Message-State: APuU4Z+4bmxOlcAUjpTVryXA7PltO8b3DlAvfvBXyfCZEQESmESzUd2u
 vBkdnLzUbuuFSy5aKa6hc02GSjC0np0HBhPmYapvqk0cgTmrveKhpcrPn3jrINjECFnZpFz0wEq
 cUNMPmQYO5c+4aSjqKcIVZsR/sMalMx12Zf8brbamekZhrmuuwK9svHrHLDmUrizjbQ==
X-Gm-Gg: AYBFou3SpwuiZDye1mhl9t49/GWO1dc27FsHAsrMpQVgeaY0lSsfBeCg1l3ue9fXsXX
 mMhjZSTLrOJA6uQRQajQ5No0AD09A1Qlbi+NwyAl9h8hICVD5kOR7HTKiDT3OsdcLak+UWitJff
 egwcXEJPNLBuvqHfc4fqgB7S9zZqHN1MD2hRX8YxE2UDtmVEEjnFuRlqRhKPwdV0RNOnpOe+b5v
 VuUdGMs+4sywou5oEgdQ4NO9X/6y7Oi9gt0NB9O7U6iuAVBuFnzD7uiwyObhnCf0GGSIFU4ADXt
 1nAjrcZnajpumHpGItGp/JRzkh96x3Mnbi/0LS9ASKoZf1UmcLd1gJBzfDFOBdYtXomZ6YSZ19l
 Rh5keQGWkD1oeM6DhXaW4co3diVicCmrA2gb/aIomP81GK+gkcM1oOqkx7aK9EkG75r//8xR0Cn
 ej9WwcaTcE2yfGbO3c/oeIIJ1jI9PG0DYia5Is
X-Received: by 2002:a17:903:37c4:b0:2e9:4b65:369f with SMTP id
 d9443c01a7336-2ed41bcfb63mr38224265ad.34.1793991841020; 
 Fri, 06 Nov 2026 11:04:01 -0800 (PST)
X-Received: by 2002:a17:903:37c4:b0:2e9:4b65:369f with SMTP id
 d9443c01a7336-2ed41bcfb63mr38224015ad.34.1793991840477; 
 Fri, 06 Nov 2026 11:04:00 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d40d19sm8283735ad.32.2026.11.06.11.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:03:59 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/5] hw/misc: move vmlaunchupdate.c from specific_ss to
 system_ss
Date: Fri,  6 Nov 2026 12:03:48 -0700
Message-ID: <20261106190352.1665081-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX271pzuWrrdhY
 tiE2tDo+snFItU3X7/PIqUS2itiBjNYenDgTxH/GjSRMawWDxP0NgVu2Yx7QhIQsSa6D6NDUSMC
 SEx2KpzsMb34o6n9xV11oe4djpCGNKqNeMTwQj1NGVHI6t7rfuLlOHKeHhW1BubJhI3bCC2soCd
 iSPZayO3K096S7d8VAxm7pKZFlLAYua4A9GNlJ2OZQ7qHCMeoFq9Z5UL5wvRVWJ3p2mkcQ7+waL
 cRBff60/5f000J/HQyqv99kAWcPAHYXyK3nlemn4nLR17v80+IBmHbqwQ83vCAzBa7R9Gr/Q1FL
 ksHXSKo4XAmGH/IIagoERYNZdP6nPHeXjWccY3+cLHK/zFWNbU8jAl6KCHdSvwTtdvUZf4tku/w
 auMGRpm8ilxbGeUS8P86Im4rWUIJEkhQ+U+4A8QP2d9v1ZgI+fm3hLygxFY8NmraTGvJOP5sqQL
 dp36nHsWR0/P7FfUlxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfXy0oZ9rXkk3W9
 RBAREk7lIh9wavgAE6z/Jl5z7pAMoQxmlRnGOB89qtO9R7Mokto4n686t0vQQ2iIaL9CL6EPgpK
 bHnc4P6RTfkaxPsHwF8gg2daPJPyvW0=
X-Proofpoint-ORIG-GUID: L76w4Ey2F0SC8-LiarA94rIA_PqNKDxX
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6aee24a2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LAscJXW7ItO83LQvPTYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: L76w4Ey2F0SC8-LiarA94rIA_PqNKDxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060075
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

test-multi-target fails when igvm is enabled if both arm and
aarch64 targets are enabled:

  $ tests/unit/test-multi-target
  TAP version 14
  # random seed: R02S0c27cf3526927aa4a7f822f0a8315b3e
  1..2
  # Start of multi-targets tests
  # Start of qom-types-are-unique tests
  Registering `vm-launch-update' which already exists
  # child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) killed by signal 6 (Aborted)
  # child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) stdout: ""
  # child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) stderr: "Registering `vm-launch-update' which already exists\n"
  **
  ERROR:../tests/unit/test-multi-target.c:41:test_qom_types_are_unique: child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) failed unexpectedly
  not ok /multi-targets/qom-types-are-unique/aarch64 - ERROR:../tests/unit/test-multi-target.c:41:test_qom_types_are_unique: child process (/multi-targets/qom-types-are-unique/aarch64 [1982534]) failed unexpectedly
  Bail out!
  Aborted                    (core dumped) tests/unit/test-multi-target

This is because it is linked twice into test-multi-target
and thus the same device class object code is duplicated and
thus the class name gets registered twice.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261106171836.2020151-2-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/misc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index fc3800baec0..7a071af82b0 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -170,7 +170,7 @@ specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmgcr.c'))
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c'))
 if igvm.found()
-   specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmlaunchupdate.c'))
+   system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmlaunchupdate.c'))
 endif
 
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
-- 
2.47.3


