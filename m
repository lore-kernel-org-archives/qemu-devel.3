Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B523FCD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6h-0002el-Jk; Mon, 15 Jun 2026 15:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6G-0002Um-EB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6D-0001UX-Hu
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxZIU3579093
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z/Kt10ye7G3
 phj9K6MQCWY/icu1NbRb4n7brc8HEKAE=; b=GyoSyV00yD7w/5t+rrXs0e71DvF
 IU4x5KJcugNgvVeELDUpTcScNHGnE3alhERJIBV/2BoqAY2f7wp0yZ99QAdz3g0t
 x5pSEwkl7gUz8Gz6sq2ceheE+QkA8PqedcBWjeg25bcgTri1EHFsE6j7+N454KY7
 hmeNfj76D/tYX8lhvAVzwR6662tHbsojFGRMAqKXLlx06GPG+IlUGvcBlWkBe9RD
 1/867xfEnLtcScWZ3lWthjFTAE15cPPQuPGBEAAWmmYeYZ8eIU0+UdOTUkp8Vc2l
 V4mHJd+L1WASFtI2GAYey9gv9AFqRyKYIo5y6FRnrU96NjkaWe/O8eM1wzg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete982s7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:55 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-137e49e896aso3311237c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552155; x=1782156955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/Kt10ye7G3phj9K6MQCWY/icu1NbRb4n7brc8HEKAE=;
 b=KS+5p+WSqd1KHX+WZtJ9J/H9B6Srky52nNilMiJ2vOzzb9c55HIDfacDi7uvTt3tyE
 GIoZIvtRKuNGdpPtib8kTbvJrNdhCbWCi1lwUYO5ytYHAS81fvKFavSLN6KfAEqs/fxl
 YtkHirPEYW8jof9N0gohmaxMB+b4Box8F+gPzMhilGz4LeyxlLKfTxUZik1TN0zrN1KE
 PRC/uy0dckxxT+CJD60LudhqM6HXQuaFnmCi9FxHTaGwTvCNDLtuZu5E3msadcc7WvxD
 5gXBKxcqLMwL2Tv+QbLZIAai6f6ha/PDetamie1Py+EqAWZ671g/ylF4aGhKOInHtxHf
 CodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552155; x=1782156955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z/Kt10ye7G3phj9K6MQCWY/icu1NbRb4n7brc8HEKAE=;
 b=tLk5xqfUrx1rzLbXR+y9hFfXOGstVKPWD+0e6b0kSU8EUyWF6LUaiLGd2C1blNhBj5
 ytqrmTdbkLC8CTONCUPCNyN4qjWcwtRGccevb19i0LKG6kDpicvGksj6mqs9gBklDjl1
 XzKcfv3Jw7uhrKFkC6WTVmp6D36ZoWNjQfWFi3b4k+Px8AMS5cVWZwwF6hQVHny6jrWl
 F29aYmEnV19RDsnNydoq/xVA3k6GdbsYt3Q8auNwRlifJP3GVSlX8GifRPko/cDUfHFW
 jbjxn9OIf8kwwqKwcbWFBSicE+gJhlcomAhX24Aa4cI9WB2kx8K0cQVvdAEUlwPLZejC
 QFKw==
X-Gm-Message-State: AOJu0YzgFmXNnD1nPyeqTGpDB6BVC938fd/ikbDL1tUydh1u6rTwf/im
 2yUl2PRKujoSjIKoApUg9b14HGErgOeqLRBg+djbzqz/g5qFPzXnSaPSjFT0Vwhtzu9ienRzz7G
 iG2rfq7uzqPaZQQO7SRLZXQKELZnvN2AIv7rjN8anAVKWoUx4aMGYAMb9oK9PrZIt909L
X-Gm-Gg: Acq92OERhlINCwa3+7kGsCMAzHRQ1bytISqMC13wmIGl6yHbmpzBtL9G9kAmDR80B65
 E7eMd8EPAz0RvI3jltOR3OsB63Rf35kyMnDoDOQD1sm0US7mNtU0Qy1y5yjD/UYWMh/uEpVDlrI
 FXchHgecTZfMXTStHO28u1pSqfJIgQcFj7GTydTuNxOo4+LoH6vcWuNtxSQvngQ+4xd/J+a37Rg
 h1PoIlIdg8jJ0TGTAAbSSA3fXhG+Rb3i+Doa0YRcmcCfW6VrpG9CWqpI7gvmosOzwUsbT5p5s6/
 ISv5dRsQfjYBUgkBvnmwuQi3bQhLQqSVf8FeNfzJJxDDXAWBfI7JMmAqxmkWKpMI5BSpFxdA+wD
 a6Nmy6CJ5QE1ZZRzgK91C3JFAMcRUHdHF8dzip8lIRopElvN5veU6GjRtn0sWQ5nJBsoaIZzU9C
 gor99wXw==
X-Received: by 2002:a05:7022:5f07:b0:136:8b76:14eb with SMTP id
 a92af1059eb24-139857f5178mr214690c88.14.1781552155240; 
 Mon, 15 Jun 2026 12:35:55 -0700 (PDT)
X-Received: by 2002:a05:7022:5f07:b0:136:8b76:14eb with SMTP id
 a92af1059eb24-139857f5178mr214686c88.14.1781552154697; 
 Mon, 15 Jun 2026 12:35:54 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 19/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_filter_cb_t
Date: Mon, 15 Jun 2026 12:35:18 -0700
Message-ID: <20260615193526.2883349-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a30541b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=ZpZNCfPiCzbVQKdpNmsA:9 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gIqNw2VU02Zufn91BAu9YPEMCJqu8rQL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXxl8PjBUQzIjr
 cVVfPyB8wR3M/Sha9ByxiE2POxr4+mss4jVyGfcbnhdaz0OLIwTrKQrNmVxv7HztNt08dYvAR/6
 em8h99BsOTrnag7zTkGGrwDvx64ajAI=
X-Proofpoint-ORIG-GUID: gIqNw2VU02Zufn91BAu9YPEMCJqu8rQL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXzZQ4XP5vp99f
 bDOrO/mH+pMpNXMk+8tMxGfWRpwS+c8pMMDC27joCGT9IaVqMrp2CIc1EDLwXFGCvGnydBY2W/A
 atnzXF+gmtNEfAD2h+R4u+w384j7dKyztaNJwTYqPJXFUVT3zqdWRrXf/BcG7kePe/R05McryQl
 mIiBh3yZj6pQ0JG0cKga/aL6p8asNPNzZ6kMEmpduvvjqVmb5qT/9Ah4BPwx5cwIE+Q3KUkfZAr
 QGNloO+ZnJJrZTKnB6qDeOaqnntMfTniQKk/V6JFuz1vxo+efT1BedQFExHA5486JWZvoWmV7O6
 +tz9IGfdGwzGtKg+jzPkCutaKJXk0EhPewPtOLoCfgJEEMJAHkKoTbypFY+6Z3uPTqgS09zTZ5e
 bl266XOMaGMvBQNUC7iUwClKJWjWdkivs/IP6tUKspdKp7ERpL+5WhrSd/Qi68o26aCXImwe319
 Ent1jBjFhTIwuVfPw6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
2.43.0


