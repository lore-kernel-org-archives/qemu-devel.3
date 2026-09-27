Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD830C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjNR-00089t-OB; Sun, 27 Sep 2026 03:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjNL-0007vm-Ru
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjNK-0006aE-1t
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNwB9a2169659
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9HcQT+RC2Vf6Si0c7R/k3RokAONKg68v2I5zK2P1P4I=; b=i4FKAB80Xt8hEdEl
 sf0RodwMerPNW7ecVkDIv2kV0j/Ix580nS8JmPPuANdVeVk0VluK04LB3aJLB/vs
 TZZymuOzSnq+uFfSfbi2GxonFRi1w9szS0/j0RR3CFDGPDewd+l/ECGQDcj9OUQ6
 43UAN4iye7FA95sJT8+6ys/8EviMYwtv4rw/h2DCOeKi4l4nhwioJ5LtP23ryZvI
 nDfsNBTkXPQLmrgim6JE93PxBFSjRotoLL2wlkjLmJV4+NHRHjBqAH3hgcCNdRsp
 wAEmFOPqXug0u3UQr69etToU3bGCed7sK8rasDC/Il3qr+k1RDoJZrxFmcw3NBBs
 k+OtjQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx50sanh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a1e564fd5so411721585a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494359; x=1791099159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9HcQT+RC2Vf6Si0c7R/k3RokAONKg68v2I5zK2P1P4I=;
 b=N0Go8yAcvIci0FTBB60iPv0M2cGr5W6M139LaASUDxj7C5pS29XA4wYGRjhU2k6wq+
 i8ElIkqRTsN5T4PGWEM5lcCWTp83J8vir43PseAQ7LYHEHjJanKX2fabR1cZgEoShlzP
 s8JZ3cqJEIfKP1YTcIve66m+W2HhlVVz2YZyvTMmgubpTIRHA0YO59z+B5CcIimO0ITy
 pUy5a427OtApS0RMizCxF5qe4RYBNNQZpzZtiIBTi1t8oehzzPSX5fdJZLXYUhmj4AzS
 EMDhQfcjj7ykcgKtNiUAJKqNgfFXs4fdlpNS8722okEh534L42HMOpqlUpFxbhdKSTZo
 vaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494359; x=1791099159;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9HcQT+RC2Vf6Si0c7R/k3RokAONKg68v2I5zK2P1P4I=;
 b=j0fWZsfDEADKZFPlfLVj0TXf5F6YxuQynchGfKOA/lPO7VOCMPCnGAnIt0xqdPRHfn
 ftqe/Nqzx/w+GkDfvDiaDIk5JX0DkX/Rmdmwm08A7u8BcZsZEJucVC35H07ulh1hqSRs
 ZJ8hE53nlwIqJ5xu1vNLgWkRNHLfmSJT9L+rkisr51xC7r/ByF74rGqzrBeof6EQjlyc
 4N5Hn+vmEVSZCESx/KAmAGB0x0ShYMmq98U/v/sftV2SPC3XU9tHsND/fGE8RBsGPbVZ
 HL2/FXVDWEnb6IfleUqzgkthQpJ7jb/83JlxOdJTDJRPcnvy3atomlfjgjf6jpqkFXgY
 1duA==
X-Gm-Message-State: AFuF++ljzZv0U4SKvwFGK17UHK+jXZm2CSw0ml0elsNE3TcOazpRiNE8
 oGGfhaPsCDL2xnYroXpMIHW9SDjOC7yap1/eJSkFGneDdYkExa3d++ysZrOc0ED9QLHyFdu6MNc
 BXNe35hycew54RXGYjza95c4Qq/4+bbk/P6/zUtDPQvHvOzz1MLHmtOI4FZzPl+tdfg==
X-Gm-Gg: AYBFou2fQD/8WLXoP+KtBBG/fH7RwFAJaU3w0WRIEfZ/Ex9ptMvjs/bJgRDyXBF6w/i
 pYE5ajzokbDmSFA4t4YCgJ1Vgaog6+noSDBeeD3xcB0EEW1j0MCyopcKwr3JOhPOIZ7KVVDeHPW
 ZEpi5/SRhAgYVd8Wl0tRoeG8JeiqppeJseOD3nN5cAB3i2eRlqxRNBlx9d5b9Rzppd8Itze7Ytu
 7vaiMXfuU8+yhawc2DRNY1aKadG1s66lgMr9J9bpTTj+PXYmprRitzP2Fu8BSU0Nwp6FBY/OSd+
 4CEyEIMm+XyojmtZdqBk/8ZKbE5xgz5k9jwJU4MEJReF2YOAcmeyNWRIhhExEE9IXkqEmRoJBFj
 YvgIWJb12XTu+7PMimSaxJ+pAUxYioZ1dVRCWE4Rc
X-Received: by 2002:a05:620a:4111:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-93c43b7f202mr1426299585a.5.1790494359495; 
 Sun, 27 Sep 2026 00:32:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4111:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-93c43b7f202mr1426297785a.5.1790494359089; 
 Sun, 27 Sep 2026 00:32:39 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a74538asm18300762f8f.34.2026.09.27.00.32.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:32:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] hw/xen: use stub_ss for xen_stubs
Date: Sun, 27 Sep 2026 09:31:39 +0200
Message-ID: <20260927073140.41422-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX2JKSvmW13YIV
 VgW1TezNf41M6aN8e/RP5O4VpZ0yRpQvNwoAREfHe2EomFEhehPZq8fgdeLecVa7FKfNzEbNS+6
 dqq+zdLp8SbUKmbro55WInMw7d5f5sQ=
X-Proofpoint-ORIG-GUID: zRIKJLyPNs0PCcDx5GNPQGnXlXRaOgcy
X-Authority-Analysis: v=2.4 cv=WuK+otfv c=1 sm=1 tr=0 ts=6ab8c698 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=FgIZ_Fb27Ug_Fq7-BHoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX5wz1Je8UJA06
 Q0JpEFivO5OHwpJJfawXzbP/gzTzmtIzDlB9Knw0OfHvPDVCejVFwqe65bYNGGB1UKFSd84e6Bm
 XZ5vVAC1U903c8FP2t02Xcp+HOR5F/YeX93VyRczZo6rsi60e2bAlgmKdX44CU2HEv9WyLpr+Cs
 1iQIMW+M8ZzeBzc4ccMZyRC1s8FEJNSw+HuYrf6n8opMoS2oWSHR8ph0G9p74ED7yrzmcnzmmYp
 +9fFpnvyOZcAAMJJGnVfg9Y+QwfTAyaYGdEz+VYrqbIPzH2p43EKL8RfhK5+DRCdjPPg1uXDSGW
 XpL91FwWTEHnp6PpNzH5+IgY3EacPOytug5wUAZ1pyz2eZUbgzEZxC46X6U1QTEMTF4QTrFPG+p
 uM13bSHSkp2yVL3VFpczuW/3nnnrNv/aY0ziVpTIP39sSGRWpr8GglddnoDA4JxCzHmL0maRz3C
 dh3GEsUlUdPwKPlraYw==
X-Proofpoint-GUID: zRIKJLyPNs0PCcDx5GNPQGnXlXRaOgcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Solves these link errors on aarch64 hosts when linking
arm and aarch64 targets:

/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_hvm_modified_memory':
/qemu/build/../hw/xen/xen_stubs.c:17: multiple definition of `xen_hvm_modified_memory'; libsystem_arm.a.p/hw_arm_xen-stubs.c.o:/qemu/build/../hw/arm/xen-stubs.c:25: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_ram_alloc':
/qemu/build/../hw/xen/xen_stubs.c:23: multiple definition of `xen_ram_alloc'; libsystem.a.p/hw_xen_xen-hvm-common.c.o:/qemu/build/../hw/xen/xen-hvm-common.c:39: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_mr_is_memory':
/qemu/build/../hw/xen/xen_stubs.c:28: multiple definition of `xen_mr_is_memory'; libsystem.a.p/hw_xen_xen-hvm-common.c.o:/qemu/build/../hw/xen/xen-hvm-common.c:27: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_map_cache_enabled':
/qemu/build/../hw/xen/xen_stubs.c:34: multiple definition of `xen_map_cache_enabled'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:86: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_invalidate_map_cache_entry':
/qemu/build/../hw/xen/xen_stubs.c:38: multiple definition of `xen_invalidate_map_cache_entry'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:664: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_ram_addr_from_mapcache':
/qemu/build/../hw/xen/xen_stubs.c:43: multiple definition of `xen_ram_addr_from_mapcache'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:538: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_map_cache':
/qemu/build/../hw/xen/xen_stubs.c:54: multiple definition of `xen_map_cache'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:468: first defined here

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921204954.50529-2-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/xen/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/meson.build b/hw/xen/meson.build
index dcd2b7e1df3..62767a5ea21 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -29,4 +29,4 @@ else
 endif
 
 system_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_common_ss)
-system_ss.add(when: ['CONFIG_XEN', xen], if_false: files('xen_stubs.c'))
+stub_ss.add(files('xen_stubs.c'))
-- 
2.53.0


