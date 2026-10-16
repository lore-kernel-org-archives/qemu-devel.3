Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92744CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmf7-0007e8-7v; Fri, 16 Oct 2026 14:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmeu-0007cc-G5
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmes-0002wb-9I
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG3haf3260540
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=D8nf2HVubRh
 C1mdmlJGPwBZ4PJaNA9w0UWKDDsG+FlI=; b=TBO96IACioCEeH8goj8+tK1po19
 dBNdUBpbngjCbB8kYk2h/vnotW2PZDxs5n/H7UFhH8dbUW3o4az4eGV2Yku1jIPB
 YDQURZWA9i5uag8G24ARdCQkuQx0J3nlmkNnSFrIeOk8FaMUHSXnh94AmeKZJ4js
 EwK3pZbnw69OtKGaMi4NE8O4g4dgikGHrlLcW7oi+P6oh89GSRGHvEpFUNdOh7Ra
 zKidqHEsZdwKKIXK/iAyvRW5vO9R+EkTV7w41d8qbLyZFU8vZTBVF4EMr+jNh2YT
 14NHDEvCN+UPkh/4vNl6H7QUEMfRWQTuLtBzUFPgYqyh+xIVSVj0vkwbZ5Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq450j06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:27:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e818ca61bfso715625ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792175276; x=1792780076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D8nf2HVubRhC1mdmlJGPwBZ4PJaNA9w0UWKDDsG+FlI=;
 b=WcYQvsbraVf9fY+sJc/C/kqhzbVIf/Ihs4vOp6yKj9+6yGIZsAihemAHnO+1yNgtpU
 GFiUP/9XZjl1+pn1FmZ0mIenh5JNKfar64qtkk08JmstGrdmoMEI3zz8HTeHm0mAU9YG
 q9iJzTLV41h+gwbzbi5SiwaOz1muvN5bE+0Dee84tRk573/dLMG5P/II184GmoL/tVIZ
 uLy5ScT58Iq42ZLnqNo4qcSuImfMl+tsQ96w0wLhSzI8gSWg4gB+aL+TbZ45P0xTLgPG
 ATe+YUAfy8HbSCCl2IkUz6gziRMurq9Bm1W90e80jy/jGoGLSRP+9POzHv91MM3Dn+P4
 2NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175276; x=1792780076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D8nf2HVubRhC1mdmlJGPwBZ4PJaNA9w0UWKDDsG+FlI=;
 b=IS3iPG6FTo/hxzO5cyor8MCgDX09LHrDEoysH3Eu4NApeuF3q1HVSatE0cl91TFKvf
 n2aYohCNJlHSMVGmmn0HGR9SsVCXFV2HLA9JbjDEbY22ER0P1xmcBjnknAHy2UOWb+D/
 L5BCrQ1DXkGux6aTrjkh2mlfPWNatwA2/lO3DGCsym9jVW/dVFzopEA63e1HNVc7097f
 ErlvSdZ0PwqITxlNssSANxHIPO78CEjiQU9eqHpLU6tUZj4oRArrTdAYt5Z5GTYuHEym
 GmXakPGwzcBLt0/2O5Tc3a+aqNDSb2/6loXXETZC6fMc5ePf3vLlbMMuIpEJ7vi+w9nB
 NQrQ==
X-Gm-Message-State: AFq9FYIzqzyARkZb3keQ76i1E3/GipHFtN2mP4MhFdynrIUVLQqMlAvb
 1sWT/pmvD1BoFsiyUMXdneBh99PQtS8iZqIQR/goS/Bb+WIp+cBrIjYFiSERo6lvZWal0N/5y+O
 m96vaxXsYiR3w7ovCRvQmIMCr7CQ8CsLMDLAxmtpCtO/f2TPkCGenjnwCLxrBNx1w0Q==
X-Gm-Gg: AYBFou1cnZVJuTMa8Zw536KhhrMhWEXQ5vGzcvP3/UFkPWIq7W4ye0Yjo02FOELX8CI
 f/iZtsGDqKvYA37ByeQ+EGGFifGXilVKnexFQR2CCeaULkrZTSBLTU/oclY4EUHBqGr089roiFK
 wrWcx3ZDFKDFb32I/0dZjAmhw6aqho7nB4uTcBDARVM1aG3lsm6SbzjRDjBGS90TYfAdKor9pSE
 smBi5gOP73h/lvrwXWAHkut7HuJzQ61Ar+6KhRJWlRBohnaKtrFNGkBJMZdswDej3qGLXvW6Ba9
 jXfDRoOSLgTXZtAk9wF7QoJdWRHp/31/z3Thia3g19Cy2/zURg+8Yp8LheeLfHbJD//Ak9f110c
 x+xBuLqiynJNJom6HFARTts9MmPcTUCVgqxAqAp6GjWc6zbJtYrWVSNfXsZ6/2ps=
X-Received: by 2002:a05:6a21:730c:b0:3e0:c3f8:4821 with SMTP id
 adf61e73a8af0-3e225f9d7fdmr164497637.41.1792175276056; 
 Fri, 16 Oct 2026 11:27:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:730c:b0:3e0:c3f8:4821 with SMTP id
 adf61e73a8af0-3e225f9d7fdmr164466637.41.1792175275563; 
 Fri, 16 Oct 2026 11:27:55 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549c7034sm1557291a12.16.2026.10.16.11.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:27:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/6] hw/riscv/virt: restrict scope of virt_is_acpi_enabled to
 this file
Date: Fri, 16 Oct 2026 11:27:46 -0700
Message-ID: <20261016182751.264704-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ti_LJA8R5KMsxZrvwGodQlDqd_s5pMLy
X-Proofpoint-GUID: Ti_LJA8R5KMsxZrvwGodQlDqd_s5pMLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfXxoL7RYjWF3+g
 mJYKX+XUNfBOxk5t/n0bGfrdIbwfDPrU7WeIhxdVDjSavlHphRKQRrIVOXCSshKEuyc9k8/5KaT
 GwCCHW766XIuyxdwzKvY+IxYIeM0ptuoAeUpAVYr5OMNHLmBYuITBg9UjekSjWciUjjefWYvtjS
 4dmwGuMn7pYcLJaiAtKuqmWiVwbCq+mhM6yfBYbHbFleegfg0yyn03///qp3PqFesTaLKoGp8CP
 5SNsOWxn2l9/2VxnLS/hEWQFoW/gnLoIEtaZq7SxL4ror15ATYZqXTGUJHv44R1wvQQge05H9/9
 zJQ3Jxi5Gvx3b8VqTi+3qyQYH+woz7XaKksGGAQL7kIivEqMJ6aDj5+rSg0oIQOXVwdUfHgp9pQ
 jYXdImfTeRyNqTF1pgsZ38azM4UiIK27o6yGCcSrOdQO8GM5lrRkdbnIOJkYLQt6qQDek0UzaDT
 acaNCB1zKSwgw3Ce8KA==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad26cad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=cKco9eWmVNDuGNNw8cMA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfX0qZo12l8nx31
 ZTDNihBKnH/EU32vnErqJdD1IksFT0aN1nPtdsvBYVrMHRL4ASisRA6b/kKhuDWCKviiDG+0VfM
 cq+o5DL3T4RsahW7+tEjI1ExJ6ZWtJs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160073
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

This removes conflict with the same function from target/arm. To the
opposite of arm target, there is no external caller for this function.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/virt.c         | 10 +++++-----
 include/hw/riscv/virt.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f6..b53ae07f9b9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -71,6 +71,11 @@ static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
     return riscv_is_kvm_aia_aplic_imsic(msimode);
 }
 
+static bool virt_is_acpi_enabled(RISCVVirtState *s)
+{
+    return s->acpi != ON_OFF_AUTO_OFF;
+}
+
 static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
 {
     bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
@@ -1066,11 +1071,6 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
-bool virt_is_acpi_enabled(RISCVVirtState *s)
-{
-    return s->acpi != ON_OFF_AUTO_OFF;
-}
-
 static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9ad..16d86edfcfc 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,7 +121,6 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
-bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
 
-- 
2.47.3


