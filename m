Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E99C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiHT-0001Ou-AY; Fri, 03 Jul 2026 14:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHR-0001Nh-VR
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHO-0002CY-4p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:25 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HjhlB677998
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kng9bpxyRwdgZbGNRYVhTygs7OAGZbgpVlMBL4NTKG4=; b=LnvBW0R3RfXnz+ln
 rhfxSPJ4kBv2UMoOHiHwoTEwEhgpyoSLXd4fK84qTHgw1ohDBoFWqT4EyMDANdG3
 OXY8damUBJmjLPIOtcvE4t2bQ/5Hi7C3JqNFXkqeBpdnwlF4D+6IIEkCuUXLtlSF
 QXsyi5V7JAF2g5rVaViJPrsx+yOR3OidGU8EeD5OMcj7XeTlirD+hQCo19gL8e1T
 ACyjXx+53qAt8MDtKjW0N8FNZb8sFkDIHUm0bNZuPwyxUDRgZDeN4/Oi0b9xqI97
 14qH4xEMW0fVtcDmBGR69ctHAaAexlGju46TrKhMGGdrUhdFKUUf8+eIWMxypVD7
 P1+gkQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj18ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso17037541cf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101979; x=1783706779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kng9bpxyRwdgZbGNRYVhTygs7OAGZbgpVlMBL4NTKG4=;
 b=FWmhCHd2/ftNHfXiw8nhEDQk8HRW8w84gcNUG3PZ4va3Mgf70Z6vk1BRqo7VbedaW7
 Mc4WGN2f6rlA33PlhpyrZ+l9qDpP05xI3PCryNrfq6ZO8sd3T/aNKkVEltWPkgVwsOjN
 NX87I5ToqSbwfNugGJXRolKyea+vFYgrJieT326inAliy/nHU+aksOUmzK+zW10fJTOQ
 8AL+b1Y2z2P8t+xe5eTp5OxN+nEOcA+8KYw9V4bfHWBPfRgsyc4RfWpTYhpOUaDx0tB7
 49qutqOIlQcV/d0RX/nMj5sCCVE1xaYYOkp4mcHa3HgSQXVrF+zZ06Fk8KqemZhftBfL
 sLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101979; x=1783706779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kng9bpxyRwdgZbGNRYVhTygs7OAGZbgpVlMBL4NTKG4=;
 b=tDFt1IO0SB12iwUOecR8CEMW/217TIM/1cTaQ5BDK/ixrLiyepqpqnaXjAR6TfF90c
 TAPxxiZt4O0c+3o6f/ofsaiBFtCUCBf8Rjg8gn2Kpc/TEwIp4cNPG9HnP8j9jpDOIyPz
 7+EIcxQj0yoB7ngwQIrWNOn1D/NiC/RXzhN9yndBnJvKccRG+5PsOD3c3lmk5VUNluav
 QYT3FEprDW7JhUjogYi2atmsnAwRJOVDnRCRJdv99upySVAaD1AGwn1LEHXFeLstEUMw
 GKzaGZfCFb5BzURPWDt+2ZZ04pwk8/TfLl/CVmyda9u+99bYEEpNP1XHfi/+32DVBHgv
 pc6w==
X-Gm-Message-State: AOJu0YzNDEtWP/tOWXA1ennZ9GgUoYbqWK/vYRdRKdHsqfsthGM6ZoI6
 UulK5FXd9UPCfzrsgrA2QfGJc3oqtUffkvaDE2SjzkD6pKHh3FKx6ekMLG628t89t5dTLzkdTZ0
 c+16zxZuBD6/Vq0iMmvB79s2cSEul2bLZLub7B5zaB6tAut1ABzSTlgU3j8sWVGps4w==
X-Gm-Gg: AfdE7cmBs+GWBL5fhYOqUz3ZgQvkGMWQY+oECKyJjmBln/Zh0PA06zLQHXcqPHxo6JJ
 aDZeNqCee63Id0pmkhIhxAJopH8AZEc5wnIyF+L8N3nrkmy51Eiqq3+kR1//tVPkI1dCjFL0oJx
 Aaj6t9ZxvHQBil6sCjDRtE+3js8z0y9yuPwGwU8VAgasRi2EBzONecGDJBszFYlMpoE/fjnHOEo
 5OoxI2gK3q3RHeuNijaMEUHLTQLPQXnDskyap3qWC4iUsAcVQZz710pcyoFhU9QAE6vWbD9tEvg
 Kx7/ATF5aw5qdZeUuuTM/fDKn4fuLBTTgG0V7t2GkJ0rBxvtJKAZpEAxZ3uJMYtlkoymWyjHA6a
 TgzGSkw+/nKRlTyLYlTADOeRssJdi1bOKdi097/nlzZXA3A==
X-Received: by 2002:a05:622a:4a8d:b0:51a:8c86:bd48 with SMTP id
 d75a77b69052e-51c4c365523mr9163851cf.69.1783101978659; 
 Fri, 03 Jul 2026 11:06:18 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8d:b0:51a:8c86:bd48 with SMTP id
 d75a77b69052e-51c4c365523mr9163161cf.69.1783101978131; 
 Fri, 03 Jul 2026 11:06:18 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:17 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 12/24] target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
Date: Fri,  3 Jul 2026 15:05:24 -0300
Message-ID: <20260703180538.3346781-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX9lEMObS9+LA7
 S75hwpT0EMxQbiDgr6YGxtXahyZaLJNS2T7o4sTny41x62ULVluQ1GlWsutsY8RYLeU67g+ovzZ
 cuwKGBlrUo+hs/v06DD5l0/zpGgtq3Y=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47fa1b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=9Y5uhDEGy_uPjlLRjCEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: vOfMi6eZWThyL1npEN7UF9Sn_oxHAnKC
X-Proofpoint-GUID: vOfMi6eZWThyL1npEN7UF9Sn_oxHAnKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX/Mms/yNNs7Oq
 ki0LhRZ4lVlkTg3iDqImzbEy1O5VCyMNPJsgGO2WgNoIJA5br42FuVl/i4BdSV+YFdcI2gLrpEo
 7cHdmV4PHmAVntyxSp/majCoMNcn3221dpz9dWYHoicJeD+2rK27TGtM3jnrk1BHIpTSAfrjALX
 N4/C8a98wJjyJljgo9GuqlJFaqV8FhOat3BfzRVdxjFSI2V0I3GUEphmrz7H/CRtWUgL51OvrdF
 ZkPfIpuDf1vTyPlgiFfGmwYSm+srfjmD3kz+FlEwuEbsgDdh7+AKeSGbHwDgN4Q+esmuxxVdalr
 qWAnw3Qhys4b5VIp2qAjkcolfCAQnmoYIjn+rIBIVKodsFZnl6xgi5bCAIY4ptCR8TvFoFIjgQi
 ZLypTrLdOEAVmzL2AsGNpPjeuQZMFu+QmGPW3mcvooGss8sS/zNuM3m0dzJdvSiiNgsTsfLkwO9
 BXjpk3AYUPMAeSQKIhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

This function is related to Smrnmi and non-masked interrupts, firing up
interrupts via env->rnmip from riscv_cpu_local_irq_pending().

This is all TCG only code.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 8 --------
 target/riscv/tcg/tcg-cpu.c | 7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bbce58ee58..508e8dc03e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1180,11 +1180,6 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         g_assert_not_reached();
     }
 }
-
-static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
-{
-    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
-}
 #endif /* CONFIG_USER_ONLY */
 
 static bool riscv_cpu_is_dynamic(Object *cpu_obj)
@@ -1203,9 +1198,6 @@ static void riscv_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
-    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
-                            "riscv.cpu.rnmi", RNMI_MAX);
-
     if (mcc->def->num_triggers) {
         env->num_triggers = mcc->def->num_triggers;
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fef66557c2..4af5cd9c73 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1662,6 +1662,11 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
         }
     }
 }
+
+static inline void riscv_cpu_set_nmi(void *opaque, int irq, int level)
+{
+    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
+}
 #endif
 
 static void riscv_tcg_cpu_instance_init(CPUState *cs)
@@ -1674,6 +1679,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     if (mcc->def->custom_csrs) {
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
+    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
+                            "riscv.cpu.rnmi", RNMI_MAX);
 #endif
 
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
-- 
2.43.0


