Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA74CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYks-0004uV-4y; Tue, 16 Jun 2026 14:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkh-0004fB-SV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYke-0000Sa-Bu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOXds397506
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Zn6ZgOS8OUl
 KzC1zth9GAtM+lwu0NbsIsusKm7Q1gOw=; b=T2jkZny7BkcAlvMkVxHPOrClkoQ
 FxoROkklFTOKrgGwsMclXGAZm6qToVe+heU9NOBqHNOPCTYpcwYJ8Vk/60GAvTwI
 yYqooEi37PrmP1Ikq4bm1tDNCAnZCXmbqls3yKGdOgNP2JlpV5R6O08fofSTQxUL
 FnVvJQ1ejLKjST7je14Vv8DnIR8R2wG+nrGrmRCt4Frh7lJft8WAT4XCQ05ElGqR
 3xsZwutCQQFemH2YtfDBN+S+SUxE/mIbU0fKY6VFxhPfW7eq2uFMDn2VgZhqgIG8
 KOhstT+wHazgxdxfxReo2Kl/rLt7TRf1a+hToyv+N2jnUMlIdTlB0ijTfeA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ety52uvqh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8423f1fe39eso5669551b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635376; x=1782240176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zn6ZgOS8OUlKzC1zth9GAtM+lwu0NbsIsusKm7Q1gOw=;
 b=iCXaknONTqhotnWZJ2hlQ7A68FqxeYxJPS5HebQW5jB4H3JAdXrwqtyqRd3s6lKKXw
 /787jH5vVA6oOUi5WK9/qzx02wr7WR+SPMlCo+6VJ4aIT1/EXCJhawyqVIMtvei5SK94
 XWglZqF4GE82LQhT4I8U5GRJKXke51KF/roktEffASHZyiXTh3T6c/LLS6OK/aoE0wKZ
 iVHN4BNQHJMBrbxk+BkRjg38lB+mebzUHcpR0sHFgKFNReq6Ob+SftZva4/9HYeVO+lD
 vs78AYG/tMPJa8unyY8YJY2hENDI22DE0sgoPjCbZrnkaKbIjnWmUCghntFP74gINYad
 TVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635376; x=1782240176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zn6ZgOS8OUlKzC1zth9GAtM+lwu0NbsIsusKm7Q1gOw=;
 b=pfjKezAXlJJf7GBMBh4JsrouDBuovIaE6ck0cemibUWbDpXqCaidjh3K9i2nW8+uQ7
 QhM9xmDIScY0febAeT88M0dadjF0XEsLfv30FF+pd6v7blndC+9sYeOkOwVsfLJ+HcX3
 Ccr08rEM9RyObN0eCjaE7jFG5/yK/U6g9lf7LBr06T40DathwSZ7yIsX9+4M78Aes4kY
 LZWogvu+ryVkXPa5bJ8YCTcarJFt1imTTVW+g/dqquay2CcBqxoVHxTNT119uWpr11Vo
 BDTiLkfgNAEdtcg+HnOOppdWCoCtKJGuxuwQQDVV1Tm4dabs0dyliIh2ZhWI8874yQ5P
 ap6g==
X-Gm-Message-State: AOJu0YwkIpeNyj6neuHHbNR+OaFIlwO5CJaEsAg7TpwBdgsTfhIBn2F8
 FXW3bJOVjuTB3nNW8HbPCqpfqgDLFmha6ao/sUNpBNxgOWZjX19XNF9l+t1gpWMjKJFa4jovgox
 bRHknvLWr6kIiKU3i2Tc/xZ1gWQ8Ctx2EwPJlpEC+OQdcu2PrsKVejltpoF0BoKo3dUG3
X-Gm-Gg: Acq92OF2ozQ39wJJreLHlv4foFPwQzN4zf1ICgOQoNL97jddFzNl434rYRbNaxzAJxM
 wkDDnYZebqdo6r5wN9e7WNGmZnxkj+QeMVz6FAZ7MFUNFRWr/n/T1KtqgA9NxHKeh4sUOWmN24+
 FU6H4eZNU4fn53rj0wW65CKgKYkn7QUPBqTNfadU25ocjTpfFSsHW9dD+PBL/R+7oq0ad+OeQbF
 oc2Hh8wYwzG23bDOh9wiox7/ttTbG4D9t8s7p3N512rLk8LMD7MVpXLHg+ar+3AQRIF5M5lFYCK
 iXlya3tY5F3AEUeU3d/o7ibNTpGDz5oXvaO1mJsd/HD1oiQGuHnSGdnK2GfglbzY2oJcZ1p9+yB
 EJa5vhq9eG6P4fu1rXpD70/zvqkLMwve0G4MgQMfCYt0z+CjtAz7gPMpovOUaON3JDReNxa9tR/
 rIuD2F16U=
X-Received: by 2002:a05:6a00:340d:b0:842:5c60:51c with SMTP id
 d2e1a72fcca58-84524574e5cmr322944b3a.37.1781635375641; 
 Tue, 16 Jun 2026 11:42:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:340d:b0:842:5c60:51c with SMTP id
 d2e1a72fcca58-84524574e5cmr322925b3a.37.1781635375204; 
 Tue, 16 Jun 2026 11:42:55 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 17/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_cb_t
Date: Tue, 16 Jun 2026 11:42:21 -0700
Message-ID: <20260616184230.303038-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX3QspLrq6J7AZ
 sdzhFiKiFa1JRwtMlftEe6VWixis0GJLORrKLSV2IMHxeWdkHvPr85BPD+ezKUENx8KZ0b6nOtk
 pYPHBO8r7X/EN3FEMr+GBGscKCfL5po=
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a319930 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XHT7D-x7ZMtFmikgfWMA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX2pOTKGW8aeZD
 Bnlf22XfSpmJ9a9VOY+LOfbk3A+scAkH/vohskMN3p0FYOkUcqR1a5ESqdronn8UUNO3Uq6HgJV
 IZOTiejlin8o52IZQQbmmCPBlsv4E9UJwaj7U8FsTMurt1oysynXHq0kg0djNZ9RTerYIaFFl+V
 ntPCaYZAzIW6FRDUwDaUlJPK7t77kwto+wJnyLOFRJGlHejgSB2oXLFXVF8GxCrbkb/vCPmxxs+
 jn05tn6hV38R14z2qlhLecZPHAG3l9u+GgCcVt258FvjHovut9ZfPx5UDS3lOmqKB7i7NTYQarl
 LdDP6Q9mwYKdG6to+P4+JYUJPO//dha3yTC9LHnpoFX9KqNTbCF3vEZvbHx1rVP5ugs0FCGJWh3
 XAwQh/bkvkYmEcIYEfB5gxQwM4qlSf7R7UFOJfjtrUU3T2wYspDEiuk16sgQypB8Po3/A1XxLix
 qjyDgDG7z8RyJmJ4hSA==
X-Proofpoint-ORIG-GUID: CvYJsNni_3Pgj5GZWV-BxdBB6izfySAr
X-Proofpoint-GUID: CvYJsNni_3Pgj5GZWV-BxdBB6izfySAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-18-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 3 +--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 53daa09fc72..d82d996bce6 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -830,7 +830,6 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
 
 /**
  * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function type
- * @id: plugin id
  * @vcpu_index: the executing vCPU
  * @num: the syscall number
  * @a1: the 1st syscall argument
@@ -843,7 +842,7 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
  * @a8: the 8th syscall argument
  */
 typedef void
-(*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
+(*qemu_plugin_vcpu_syscall_cb_t)(unsigned int vcpu_index,
                                  int64_t num, uint64_t a1, uint64_t a2,
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
diff --git a/plugins/core.c b/plugins/core.c
index f30009d50dd..c272f47b642 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -534,7 +534,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
+        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 938646f9359..bfe12ad5558 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -125,7 +125,7 @@ static void hexdump(const GByteArray *data)
     qemu_plugin_outs(out->str);
 }
 
-static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
+static void vcpu_syscall(unsigned int vcpu_index,
                          int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5,
                          uint64_t a6, uint64_t a7, uint64_t a8)
-- 
2.47.3


