Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183B3CD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYl1-0005DZ-48; Tue, 16 Jun 2026 14:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkj-0004hj-DX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkg-0000T3-GE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:13 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOOpn397028
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eyBcxBXkJfG
 H9Gy/Xug3z1T1zNuaD60JPCtic+o/ssg=; b=ALUD56ixDT5pmomMd9VyHyMCxdM
 P6QF5A1nJ6WN/EYoFXymwuVk8mqmtJXtuVaVObChiGGg7M2asMqJZh/UCg0oIqL9
 wSuPXAGm8sPoZ70pXrNBtvrwel+Pin1aOf1z1X89UWAZvMKIP10hsS1J09I4esFN
 bBwygm51gPWIbDgx9VL57lV9hIjqW+MQIcOuHlhMDDwtHDRkeR42AjSokxaO6ONK
 S5rehWQgPwlXm0MErb3TFIqMebFr8aqXpdthNk8tkAvKzz+cbc13f/U7aaZagpp8
 eJQAY5cO5I2etfheq1P4C/fZlaGo1Nf+i9Dzmbubd4sKqVICUPeCm7vS1Cw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ety52uvqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8423efbfb61so3500116b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635378; x=1782240178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyBcxBXkJfGH9Gy/Xug3z1T1zNuaD60JPCtic+o/ssg=;
 b=eMYsXTbrunsAu37wXhdrx57DW0uXqpFrcukRBKjJR0Y9gBsa15D9z88//FPNThicMM
 cfjN0S/ogbIQ6Mht2lasvmOhNBMMAtrrLdtqIF7xhCoSsGO6SIBqqs6BBF2c0U0EqyBI
 DfH3jGykwPoIfugy4OixZS7FzibtQ0jbS/NiAhl+QU17TTLoyfCvg4JUrYbHs0jjuYDO
 C55zIUtK9Xes9oompnozReiVbKkaTi8S6UDtuRdyFrqYXUz8qT6bAnaSfARTVygdO6ph
 SeAFWBYDDi0jxIDkjH0FaezORtTFFWtRxITpIeEbokZ1mRXaxfIhQ8YgaioDuoWSdl9b
 5C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635378; x=1782240178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eyBcxBXkJfGH9Gy/Xug3z1T1zNuaD60JPCtic+o/ssg=;
 b=Zr7AO/kRZMu3XfgqrqegIJObbjMW+s/9bVB8vdk5ne5pPGMr4kv62tGvs2EgKAZDLO
 YyNhglIlzz3ozM2KzqxllzCxkqy3/T8dlus8IiJ0K44Zqx3bf/w2RzJLYsF5WbCHmAtH
 9naKnB14wvYvJDwaZbmGetKFn0eWqhuYIyBXueRgGI9jevavhlPK2MUnOCliU+jjIHbv
 ZIPEc+DOc2UXWAu2kyEmUw3MPdm3qo6UIGEr/LSU4keCmggwITbPd9ucbgnDGF2ZfEso
 BzuxhzMS1Cvqamt7Kbs9xAspiL/DBFC3anqQolZQv7XJKcIQkD4Xnq4nhr9CQvB3EqpS
 vMYg==
X-Gm-Message-State: AOJu0Yzp9C5wUmauCFYC5Qg+XfFS9iNu30YcTWQwj5oIOUoOC3g/IosK
 IhYFPxD/gnh8dv41w3KlgDJh+1mcMRXQS6HK9njdRHy/TJOUVwKbUuYpwZWLO3ExGM9609mz6TU
 iF5x6oqDhtgLJhu9Pd3zCaAwR0Zsf7OAXkcO543Nt6NcUHDClYDJ0zjOrLRlb+GZ99dCB
X-Gm-Gg: Acq92OG4XJz5jkkU8OH+NMqb6unzzXnbTRW4SzhLbNAXAvZ2rDHjehl3U3AOrA+koXa
 ZlaB4A+HKcBrS9Ysh9XSc24YaUGXW7D76vis3Cmn20bfh1D8KkSV7tKXTsPNDdlgTxxshhPcQos
 W3b7MDoqU0lLfdRXCEvBYbsOz32BnQqySaiWgcfb1oZRW/h3mMgVnXkAZD65MpazqNLoWapyZJp
 yyPsdppVvimvT2aIqBVeU7uR+fvdXGN3tAmoArPTWMvZC1HEcun/xa95GAmfPiVu+twtzQqeEwL
 lPuuFWc1gaPjk0oSD1XCZJBpbfPF32g73lS4ryaPxpVlx9lfDNXfdONFS40deQlTE+LCRsDhyEJ
 RW/nATlsxXCrG48aHnYKEDaxYuOCc4i2pWDhpdSrzGanNfksfgiXDE8BdPCuzWdElnNEmvJVc2q
 /Gqlb749I=
X-Received: by 2002:a05:6a00:1da5:b0:83a:ebec:452f with SMTP id
 d2e1a72fcca58-845246b6b72mr271179b3a.42.1781635378462; 
 Tue, 16 Jun 2026 11:42:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:1da5:b0:83a:ebec:452f with SMTP id
 d2e1a72fcca58-845246b6b72mr271150b3a.42.1781635377865; 
 Tue, 16 Jun 2026 11:42:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 19/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_filter_cb_t
Date: Tue, 16 Jun 2026 11:42:23 -0700
Message-ID: <20260616184230.303038-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX80hQ3INLKTjP
 D4O0HMRO7fZto2jHsS2+ZKvJsB0iV6Xz7ptZSA0sQLQlQlVdYiJeFzSDCHHHjnHGDEgkzWTKPbE
 lAez+Q7XhhvR3hAxIzEdJFM1MQCHAbU=
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a319933 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ZpZNCfPiCzbVQKdpNmsA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX0yPHouNu96DM
 s8YNUd2g0h0+0xaokJJINzOCyClPiRDgoUmiCgazLSj++4z4s/+iBTM3EfwQJUy2ehrg9NGbvyu
 U75rU4ZWAMxF3pNFnHzEEoyi/tgaLhXsFYyaxpyxOQ6ML0F84tkbd73gogXevvL9qwXjPRnL/pQ
 F6+XDrybqcJGWF13cl1qGau8gT65jsit8KPsJWXbfIXi8nny1NrCyDGx/CTgMY94TVsIAzx17Lk
 ESdjwdxkss94Do8NUVu8VdQJ9VJjAo4V5hiJnxw6htSWk/9yGAjSkST3IJqqaGkz21VlHav3Yob
 G5u99gFLgMwu1i9L1Pnng8V+A4WiO54MBTP78gElGEVH5L2/stKGpzyn7RvdGQdG/avGFrMRA2j
 l2jWCRDKR/BJzEJ8eig/pPo7aEsTlBfMYq3Gk+VY1nNDrMWoMTtS4kkDdUWX6cUuo482g4JxoRy
 IKpYLBUQl6QZQ1jlQUQ==
X-Proofpoint-ORIG-GUID: GhUBCMvxuqG0kj5b2Rv1U3iW31czwvx1
X-Proofpoint-GUID: GhUBCMvxuqG0kj5b2Rv1U3iW31czwvx1
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-20-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 4 +---
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 909f19b7128..c38ae7db1b3 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -852,7 +852,6 @@ typedef void
 /**
  * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
  * function type
- * @id: plugin id
  * @vcpu_index: the executing vCPU
  * @num: the syscall number
  * @a1: the 1st syscall argument
@@ -869,8 +868,7 @@ typedef void
  * handled further), otherwise returns false.
  */
 typedef bool
-(*qemu_plugin_vcpu_syscall_filter_cb_t)(qemu_plugin_id_t id,
-                                        unsigned int vcpu_index,
+(*qemu_plugin_vcpu_syscall_filter_cb_t)(unsigned int vcpu_index,
                                         int64_t num, uint64_t a1, uint64_t a2,
                                         uint64_t a3, uint64_t a4, uint64_t a5,
                                         uint64_t a6, uint64_t a7, uint64_t a8,
diff --git a/plugins/core.c b/plugins/core.c
index 7e2f25a9548..223a30cb944 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -590,7 +590,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
 
-        if (func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4,
+        if (func(cpu->cpu_index, num, a1, a2, a3, a4,
                  a5, a6, a7, a8, sysret)) {
             filtered = true;
             break;
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
index 595571cdfd9..9bb5bf0f5f7 100644
--- a/tests/tcg/plugins/setpc.c
+++ b/tests/tcg/plugins/setpc.c
@@ -23,7 +23,7 @@ static uint64_t source_pc;
 static uint64_t target_pc;
 static uint64_t target_vaddr;
 
-static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 8a823acfca7..2afd71895e3 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -171,7 +171,7 @@ static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
     }
 }
 
-static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-- 
2.47.3


