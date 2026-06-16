Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D73CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkJ-0004Mn-5S; Tue, 16 Jun 2026 14:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkF-0004M5-Ua
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkC-0000OB-OF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOYht303248
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=GuddOASfiAykf56K8qBpdb
 t4meygYCQ4mdlEb4ijinA=; b=iuUPfn3Gsyzltfzsvl9mXOxtsBtAn19Zi+ovD5
 KiC8euY4FzodiPTp2WjuTSjgdCFJrIEb79AexPn28/kceB9slIyslCvqv2sdeDqD
 woYRJGsPN2g9c0qd3T6gfOY/ZCevhgCqCHv5vult5xKx99ltM9MApGmVf0YUkY6e
 3SaTVT2DoS4TLx3mpedifkg2MLPX6+3be7apOgZzwVlROoxwzyUx3lTTZJjTAVg+
 z9V8ZY27PmjSZj057GTjluivtcklUwJDd8UFX0fuVFRYSI4lqgYK2U6+2ME9ckvo
 C5QH5bD3h1S51UAYHQhFcMHJJWaPciFjGRRVOCwfoXaDETyw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epb7ca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-842b0dd8107so2966649b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635357; x=1782240157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GuddOASfiAykf56K8qBpdbt4meygYCQ4mdlEb4ijinA=;
 b=jiOjINsFzHyaq6+nIlVZjAQGUgGSjyvCMSdRnCFsHp3h7EghSq6WBIWIhN97+b7RvF
 9zGoKwC9pVA3nrxDJG/mJf769SSJiprSgNkpMkkJQZl8+ngJ4Ie2BVpm3aJxjSPTFXG2
 vXv8hNeSUfqbvjtIUoPB+j1eETyZqBaGva0yM/w3e0X0wOnWiHh+4jfohP2EPSmsi1qx
 XMsqNO6Df5PDdxvCmfvyqbduYLE7VWcOoT+PpYqO6cSut9ZNycKFrOCSG14JNVQrc9kY
 7SLaSo72uB0TYonqNRiIrB27kOHBIqMh2To8cViZI//O/GTnCIiFqKJ3s66Au6LWGq6K
 3npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635357; x=1782240157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuddOASfiAykf56K8qBpdbt4meygYCQ4mdlEb4ijinA=;
 b=h+HV+Dka5esDQwtlsuPuv3SKo77ZMZ740SE4xlJzWapkjn5Fih+u4uq6LFDgl6x6sB
 65V9sGqmEZpmAb/Qde9OHHOTH0zDp19UvH63L1kalTdBkgDIIfiqGEt1UIByXgFF+wIP
 dYCML+vbp3yR9i5NeIK5Et1g1hF2D0nOk5FkC/QtFleKIjuWunujXCjJC55LqGs5vnRT
 xoJdCH0JszdfeuB5SoNE8tKKeXbFMxHjxJtBbjZyWPJO0PWDS8X0/bGtba+TyVjW4+c2
 P9ggibygb+BpAncafM1aCaAAtM2buTv0UfwPXXnSHQdpXS2JOJyinwb+eHf+SdmD7yQ2
 RUcA==
X-Gm-Message-State: AOJu0Yy5r5G8npCRfXZduGSAmhGoljV5xTg0okkTV+4pQsSowXdMZVMo
 ozn5r9VvFzP1eRIyuFkiZQ7cKpQ72eeGzqSyb3KJD/XzTC3LQj247SOYK5t2ay/I75K5PybBAyF
 7fKerw2Vts3PnmWCxuvlZojTKmeRvesrEHSnJdt+OvkgV70iJ0o+RVxoWTszkHjb1se7j
X-Gm-Gg: Acq92OHxF25zziJNB6DzLZwHzgjND7EWNimKsZg5r/KK/kcBVuk3MSFPWt8+lGC0HB3
 JiOPUH0q5QkO/P/nHk+we/nG20z/KA9ZH08laUSFq1a1h4jBge11K+UsidpHFcfjqqsZr7u7PdS
 spE+GKvsSiyfdiMrrdozvVgEkVSh1aEEPUQEVtInIDd4psCGmF0Gy0EWo4zXkBPGS03xDiJJono
 LsF2yLeOjG3TNqBV7S3AVsl4LOUEIPs66nClstkNDUls/0lPVzNciGgfIwGqdsA/jNwP3VZHGkZ
 zMIkK6VBEeTfE8YNL4tV+zwUYN9A9sI3hX+CTp5fEuZHpPobKrenjxA6dtw1LQ0RYPPX+x0TP6y
 jBf4R2g3wmnv4uFSIEV0lhfU+tAaVnYtojtPtPNfobDMe3pBfBzpZmfHfPfULa3qdNv5ioimNxN
 QqIGFzrAA=
X-Received: by 2002:a05:6a00:2987:b0:842:51d5:efc4 with SMTP id
 d2e1a72fcca58-8452447e271mr352194b3a.12.1781635356633; 
 Tue, 16 Jun 2026 11:42:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:2987:b0:842:51d5:efc4 with SMTP id
 d2e1a72fcca58-8452447e271mr352170b3a.12.1781635356141; 
 Tue, 16 Jun 2026 11:42:36 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 00/26] Plugins update for 2026-06-16
Date: Tue, 16 Jun 2026 11:42:04 -0700
Message-ID: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31991e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SBa8vAGURC_XE95p8-4A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX3PHCmi+G7G8g
 nFurZ/f2O/l/yE7W/2d3z/M4GCQgiye7kyxXQHpBVU/EffsQlUijuOwSDyyD09olDHM/f/cJ7FX
 w3hH/llchNRVrZOzucinvpigTrAWn4M=
X-Proofpoint-ORIG-GUID: QOXU1br-1TJJFOCWazWiXpIdlRBj392A
X-Proofpoint-GUID: QOXU1br-1TJJFOCWazWiXpIdlRBj392A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXyna3kZ/sQomo
 02WePXRNCRdumMw6M/mZZUvkDXhHtfG3nVURUmkQDp65KZLUsTT/n8F9MuLF3QWASJ2qHXhBrU5
 kokmiv04UbZet33q3NmOlPhxusygcmAras3N+s/LkCzW+SjoYR7AM0nDRZ0Cx536TiIvd8NC9E3
 diWC7NNkjTzBYZvW8l05FewJtn8DWJL5jbxT3YZeTAQULIEDXvJUuhFdnogMrR2bK3ADqvg4Sno
 dO6w9y8G20d8GZ53B4UkOWkMtS24ympnuGRCF5Gb0ekK3+rCbQmmAQcCpVxlw9T3hYRGgCpAqRh
 UoAPoWB6qba63pxLj7MggUMOA1dGlIU+9H1CGactdW16KKvKZXz6BPEQa2frVEJUN75EmDQBq2U
 dBWDCqoQOjUCRdU5UZYPnBmnq2aFQh6OJ0hE3nES8n7BUvM6mEczotlnXLKBwT2meF1iHM55e57
 IKktxSUP8bNFDtqZSww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit b0df6e2f2c6c45df8d4d286933799c623e124d98:

  Merge tag 'pull-riscv-to-apply-20260616' of https://github.com/alistair23/qemu into staging (2026-06-16 10:41:47 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/plugins-20260616

for you to fetch changes up to 76b70dcb8f425363cf4c767cd84761e219349bdd:

  plugins/cpp: register callbacks using captureless lambda (2026-06-16 10:59:05 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2 00/26] plugins: refactor API to maintain state through (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (26):
      plugins: bump version
      plugins: add userdata for qemu_plugin_{uninstall, reset}
      plugins: add userdata to qemu_plugin_register_flush_cb
      plugins: remove type qemu_plugin_simple_cb_t
      plugins: remove qemu_plugin_id_t from qemu_plugin_udata_cb_t
      plugins: remove qemu_plugin_id_t from qemu_plugin_vcpu_simple_cb_t
      plugins: add userdata to qemu_plugin_register_vcpu_init_cb
      plugins: add userdata to qemu_plugin_register_vcpu_exit_cb
      plugins: add userdata to qemu_plugin_register_vcpu_idle_cb
      plugins: add userdata to qemu_plugin_register_vcpu_resume_cb
      plugins: add userdata to qemu_plugin_vcpu_for_each
      plugins: remove type qemu_plugin_vcpu_simple_cb_t
      plugins: add userdata to qemu_plugin_register_vcpu_discon_cb
      plugins: remove qemu_plugin_id from qemu_plugin_vcpu_discon_cb_t
      plugins: remove qemu_plugin_id from qemu_plugin_vcpu_tb_trans_cb_t
      plugins: add userdata to qemu_plugin_vcpu_tb_trans_cb_t
      plugins: remove qemu_plugin_id from qemu_plugin_vcpu_syscall_cb_t
      plugins: add userdata to qemu_plugin_register_vcpu_syscall_cb
      plugins: remove qemu_plugin_id from qemu_plugin_vcpu_syscall_filter_cb_t
      plugins: add userdata to qemu_plugin_register_vcpu_syscall_filter_cb
      plugins: remove qemu_plugin_id from qemu_plugin_vcpu_syscall_ret_cb_t
      plugins: add userdata to qemu_plugin_register_vcpu_syscall_ret_cb
      plugins: use consistent parameter documentation for userdata
      scripts/checkpatch: ignore spaces required around some operators in C++
      scripts/checkpatch: remove check on forbidden space before '[' in C++
      plugins/cpp: register callbacks using captureless lambda

 contrib/plugins/bbv.c         |  10 ++--
 contrib/plugins/cache.c       |   6 +-
 contrib/plugins/cflow.c       |   6 +-
 contrib/plugins/cpp.cpp       |  90 +++++++++++++++++++++++++++-
 contrib/plugins/drcov.c       |   6 +-
 contrib/plugins/execlog.c     |  10 ++--
 contrib/plugins/hotblocks.c   |   6 +-
 contrib/plugins/hotpages.c    |   6 +-
 contrib/plugins/howvec.c      |   6 +-
 contrib/plugins/hwprofile.c   |   6 +-
 contrib/plugins/ips.c         |  14 ++---
 contrib/plugins/lockstep.c    |  18 +++---
 contrib/plugins/stoptrigger.c |   6 +-
 contrib/plugins/traps.c       |   9 +--
 contrib/plugins/uftrace.c     |  10 ++--
 include/plugins/qemu-plugin.h | 132 +++++++++++++++++++++++-------------------
 include/qemu/plugin.h         |   2 -
 plugins/api.c                 |  40 ++++++++-----
 plugins/core.c                |  93 ++++++++++++-----------------
 plugins/loader.c              |  13 +++--
 plugins/plugin.h              |   5 +-
 scripts/checkpatch.pl         |  28 ++++++++-
 tests/tcg/plugins/bb.c        |  10 ++--
 tests/tcg/plugins/discons.c   |  10 ++--
 tests/tcg/plugins/empty.c     |   4 +-
 tests/tcg/plugins/inline.c    |   6 +-
 tests/tcg/plugins/insn.c      |  10 ++--
 tests/tcg/plugins/mem.c       |   6 +-
 tests/tcg/plugins/patch.c     |   4 +-
 tests/tcg/plugins/registers.c |   4 +-
 tests/tcg/plugins/reset.c     |  17 +++---
 tests/tcg/plugins/setpc.c     |  10 ++--
 tests/tcg/plugins/syscall.c   |  22 +++----
 33 files changed, 371 insertions(+), 254 deletions(-)

