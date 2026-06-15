Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1932ECD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD7u-0004tW-RK; Mon, 15 Jun 2026 15:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6K-0002Vo-2h
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6G-0001V4-0M
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxEW1861120
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zV11NEESNBc
 Y64WP+EP89WXElGJavXvFC1NakUQ955c=; b=FZj33wGslpVyVXqKML7hi6Z1LiC
 N7Dzoq74fcYYXbA7q+mbCxXBucn4R5tGf0wuuAEg+FCZsR7y18uRoBOX7BVmRpbu
 bdFZWW2tyVIynF5/mufBpJTDapp8G6PRHe4/NMKmBe/8XTyWusNZrN9JEg7Ejy7f
 vDsbKEJ3LxixkVewVXIrdKXfG2k7vRIDVR52mM8A3rS19ka9YTTkNs99hUrzwvpg
 70wcXOha+lIN+wiCtTAI47IvhWoSYyd7hMBThW7uWLgmXKv142asK4oVIhCgRRUT
 b1EzzsNeZ3CJTcD5KGUmTKGj/lVhOSgUwTFxUNOmkWSZfBiY8H58YJRzdpw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydam1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:58 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1382674ba2eso3369420c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552158; x=1782156958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zV11NEESNBcY64WP+EP89WXElGJavXvFC1NakUQ955c=;
 b=TJYtRMxzs/LG2e/RQOE9x8qqmPzW1XHlUUwMM5HFsldvgqxp/vaRmomunzjjzlaWpT
 8WxOHHxgP0O12p5MSllMJXyMJaEDafX9+Na7PWzNqh0ffCxuKu2nU3y828YnGt4trxH/
 qi/8YbSpWVw9RPRo8ARzPhmll7Nl0wfxDLXTDaEev/VBmb/B4V3Vcc3wtoPnDmOvNSS4
 K5QOWSSUgeB5ZFycX7jANjcfqpe4rQMua0eBb5oF1R9eVpzQ0uR454TqkogiqIL+Un30
 T85OZ7N2bTErnZWoz8ia8mru+SsLFgaehA4++Qd/95Tn2KiGTbVvw+jfK//0BRqVcurR
 lcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552158; x=1782156958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zV11NEESNBcY64WP+EP89WXElGJavXvFC1NakUQ955c=;
 b=mjkWUaUj+NxBhUca2aH4ReBXS4I2I/S41SzFsbWH7OeZpEdNW/ZnmI1FkiLe3obJl+
 a3R2tr1xFsrmfoPbEsFb0QLSGs2fwGwYYwmJGlRuC99D7yO6fYrWVgEo9w8LKaIzUKLt
 BaMH7ItA2/4p58SdUEAQcRo4FqhWG/xlARlFOCawE5t7Gx+sqzYE3HS8Jgc255iwaPLO
 U2FnVblzkNKubezdrfXJN5uZqHjTiPvhJpGfbfXE33PVu+gqA+yvqR5+8IoZBsi8pVnE
 f3qXoJZ1P8h0EJiUBsf35hcgwgzclBkBRmsIOa7I1bFceqdxlealenMk11k3J7T4PTay
 2vLQ==
X-Gm-Message-State: AOJu0YyLI5F5Wzhf6+JkHTJM7p0/WMh8ktjlZfj/Uw7vOKuPNp/hMYtx
 RIK6iQmx1Cv1lYpjVgfAHSqT0nQu+//JMoYp3FgDTRu3OTydicdI+rqudaikQ9Qpx4HMtLDq6pd
 6b3ucew+1eZBRcICFhlc3Dbrf+pMACXnxc+DfFxk8ebmN8VbNZpyy/TpOx11K6HyhEwOu
X-Gm-Gg: Acq92OFMocCk6LSiqCFwNfcwSSqE/Hg2/6b1DGd7tY62UxTOj68adCUFdNN+K8X86Nh
 ql7+cMFWqzFj5QdHVdnnXZUlRIzoUXhaJf+KaL3jG9UEHiTGm86IzsvJPK8OmByskE9EassFToV
 TFM3vS3yaxXhHGN0PJl59X8cNHtucw/hhAtPicsisfxoKHzkhcTYUye14cVKj+iy9C8B/Nth81F
 0hJywNI7mXMmO5JFei0OtuZKfqI8nktblUbD5aNcjDymqdU3zEZEuIP0QXB/ZGsin8b0jzljq2p
 vE5V16RtPqpx2vAK0HUCxru5G7AnwxvJf4eB9srRXxL8o/Lv9GWaULGfKk+e8WvlJXzUMKtbmxG
 u/tWHQuWB3Ncj3RZpfm+5KhWEaJQzGg7X6HmIrw3D7xW0my5R8Hxpjz8Bfs0mlsK0tHuLe567uZ
 QT31FLfA==
X-Received: by 2002:a05:7022:6b82:b0:138:49ea:f468 with SMTP id
 a92af1059eb24-1384baef0eamr7703773c88.2.1781552157545; 
 Mon, 15 Jun 2026 12:35:57 -0700 (PDT)
X-Received: by 2002:a05:7022:6b82:b0:138:49ea:f468 with SMTP id
 a92af1059eb24-1384baef0eamr7703748c88.2.1781552157038; 
 Mon, 15 Jun 2026 12:35:57 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:56 -0700 (PDT)
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
Subject: [PATCH v2 21/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_ret_cb_t
Date: Mon, 15 Jun 2026 12:35:20 -0700
Message-ID: <20260615193526.2883349-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HsVAvOjuL6Kw-q85gd8EQPYB3xOUSUQ5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXwUY+10anNSfv
 nQMDDiSCKE/dRdmzxlEnQ2bqXIkV/2Kv9gu6yo+OK8YrcTTr/wgqFK7yue6D0BWIr8pLF+Arj8C
 /OKnQkf7VkGZIQG66j/YpVD1wdbvKtM=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a30541e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=wqG2-qjEQvTc715uQEMA:9 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HsVAvOjuL6Kw-q85gd8EQPYB3xOUSUQ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXxg3PEPX3w9C4
 3KwZtZHkyr8z1kWRFFQ8zGfje0/l8qRBA28gTjEMjVcXqRHCk1Eu3AGhz+uLa6pxlZrzA8rz8J9
 6imkCOlWuGm/EMQHu5EjgLAxJv3sRydZjwr7JKoXZogF1Q38BmXWb5KrDRMhO4tNooJxkpHhDaZ
 C00NQKoLP8D/CuLM+KtyRPWJ32IZmkEgHAft7sJ16Rmu0+DOTfwil27J82maDxtdyWp7TuLFWO/
 kasg6mdLo4d9Vtm/2VeafCuV5yR/51zF9nHNe1S1h0keUZ4Q0YgCzvJI5+hYzfPWovpo2Vw9gqc
 oD1tFkuWc2XlO0YXET+HWfeLm/DY62SSzyyOMv640fBfBUleK1GG4r/asAWXgG2B1xL4EBSu29f
 0CDZ5n29ecUCTVDRn2sjDE2zPy2Vsv4AgSqVr9gCWBa0O1RFUm7bJXPh2VKPQgybfFcxUph4XPr
 LskfX8We4NRLPVy/yAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150207
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
 tests/tcg/plugins/syscall.c   | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 33d6f8e0b7d..4f0c73c7b33 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -879,14 +879,12 @@ typedef bool
 /**
  * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
  * function type
- * @id: plugin id
  * @vcpu_index: the executing vCPU
  * @num: the syscall number
  * @ret: the syscall return value
  */
 typedef void
-(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id,
-                                     unsigned int vcpu_index,
+(*qemu_plugin_vcpu_syscall_ret_cb_t)(unsigned int vcpu_index,
                                      int64_t num, int64_t ret);
 
 /**
diff --git a/plugins/core.c b/plugins/core.c
index 49fe1b582b5..0a18910f873 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -558,7 +558,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        func(cb->ctx->id, cpu->cpu_index, num, ret);
+        func(cpu->cpu_index, num, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 410fe617804..1bc737824ce 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -151,7 +151,7 @@ static void vcpu_syscall(unsigned int vcpu_index,
     }
 }
 
-static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
+static void vcpu_syscall_ret(unsigned int vcpu_idx,
                              int64_t num, int64_t ret)
 {
     if (statistics) {
-- 
2.43.0


