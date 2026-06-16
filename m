Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC2FCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkx-00059u-N2; Tue, 16 Jun 2026 14:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkl-0004l1-S9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkj-0000U5-Tf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOjI5382369
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=travdE4zR8x
 9DEp5YqtsA2O11xDjJU54CBIk8xi0gw4=; b=UQWzn5hrLmqrto1gsxPIULQyurt
 VHcMXNUIhVd8bc+QAd485Hg3H7Lll4mdY482Nq4SQsKd+fVHZviqsnYKRzia8rhk
 7upi+Qi+ezfKkMDTY8j6dtiJ0j2Z7FJIB1xfmYcaoM9E3RxlCYMNXJEXtKPDPz4u
 itABAEflsktJqeS+U9jchWtnSwqnfxox7/6uiWJnid2A1xtj/VWFPeRZ/9W5DHWr
 M1CIVktBouOCUTD/fBz5wr3UbGbFrFkdtmDB/goljmqVQubF8s5yPiZ7rfqVZa5+
 cje54OkV3bAR1Ug2zCxD2NQUFW3tzsC15DrMINBjVOZFtdRuzB0fpgxaumQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkjfmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8423f3e4728so3490689b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635381; x=1782240181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=travdE4zR8x9DEp5YqtsA2O11xDjJU54CBIk8xi0gw4=;
 b=ZtOTCTM36CnVkoT6A4acGqZwwk3l+iS0HJs4dD3zQ40xXKOv5Q97W9SBGGSx+odbAz
 MpwEbOtp75F/pQoRwTE0tJgqhgRxvmj2YdGxE77CLFxRXX9ideSSPaW3nvxQI3huLMO1
 cpBV1qUwL4nSNHQhbQtA9/awWXBdig4mmLIwSaviNF+faKbg6WHJhYXxbbjgrSigY/R4
 NUAx5iFCSaxm3QNVl/oujjmf9w/XeMVOsbncDLTiuRFl8Ln6ZmjeSKEBePopttacMirV
 8LNPck9DY0/mwTUzxAeyFgfFKFJfTQkUNmUipupEVuCfdattRZL7cJwW9Ilu/C7uRM1b
 FZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635381; x=1782240181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=travdE4zR8x9DEp5YqtsA2O11xDjJU54CBIk8xi0gw4=;
 b=MzlppKO+h+h9myDYAQQUUaGdaM5Emo9A9yIs/4v8xvhlb2VtSe3xtLKL/sJi3Wx/r0
 0y14ono7xHSBk6ZZb/klse06LPI1eHbq4u6LfJ4ihEtTrXs77D/IdPtwf7ISwckyWR/z
 l5OorFM07iln29vR6/aTTjShRxHw/gmoo/USVfbqFKacXHZ/+QWKO3oLGoDGifHlMepc
 b1ieKh84q5WmXK1JS6cVaf/Jkth8qxquXVDPeBh6ePrumOCwAd10agvTXVlSAFpfAoeT
 nGiPH8eIzHcTTefmmw/KH2grCsAk0Rgj7vGnzyPmJCabftv+JeDZllRSI3JPXGPRXTsL
 7uDQ==
X-Gm-Message-State: AOJu0YyVYha8+wIjKR8lv9sP5uXD/RAdMSKu865OeIOXWlYz79LhiWvV
 Rq4QNS+lUtralS+E3ANSjtb9GpkPHkSweAHoHOlRJDxBrgV5MKWsSh+2YUW6DMJUWQ0oX+Ny26C
 vBYqQMjAwPi86WIWkjt00bnX/ODs7YaZiwQXaTPJHmW4sgU6kOTJySSe64M80IzYySUbE
X-Gm-Gg: Acq92OG57WqctUKznynn/AfwcfJUwnCucOW3UT+HwEzo8vQdk5v1GWBUdP5bvri/iyW
 XsUpkKD2hT1/i1VaaSHXdXi4GR1qlsknIgqu6AS2dLDV+72GXMGHRg2dFJBb0qVV0/KZ/OR5wx5
 ZOmdEs+CTAnFcxUrzYk6vpV9bf9cSvVHHpfH8YyY0Mu1CcrVqEQtpBKOA11yf+1IXFnGJfym/80
 oZd4OobQvUmJai6VxnvulkYzOncLVThADU2EC6oCblTsiU4o4Sv0E6eMbvJ8XW8VEIrjizWFCyO
 2O/Ahdl7PHMTCoyy/u3BG3eKmNZatr2RHaAb6pOZHsh9hevttBQDqpLAm9fRBsVT0u0a8udO24s
 PRrIeBBOt6FY83jefmmcvEa1y44IM9crgWqysqibFbi0slMR1C0cSBrEVqULboL4Au10s5eMnCz
 9KGQLLh50=
X-Received: by 2002:a05:6a00:80f:b0:842:5b63:6116 with SMTP id
 d2e1a72fcca58-8452443f077mr372322b3a.7.1781635381293; 
 Tue, 16 Jun 2026 11:43:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:80f:b0:842:5b63:6116 with SMTP id
 d2e1a72fcca58-8452443f077mr372293b3a.7.1781635380762; 
 Tue, 16 Jun 2026 11:43:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:43:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 21/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_ret_cb_t
Date: Tue, 16 Jun 2026 11:42:25 -0700
Message-ID: <20260616184230.303038-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rX48M5wWl9I4hDepvi_piS_X2y7H-sXF
X-Proofpoint-ORIG-GUID: rX48M5wWl9I4hDepvi_piS_X2y7H-sXF
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a319936 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=wqG2-qjEQvTc715uQEMA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX0Alw7Bc0Nnt4
 bb5IIpSpAqHIGFlZpPjS/wLz97ZIB9bERdgkrTlSmVwFMvITdehFDOXlwM20XBNKT3fFU3nWeaV
 H4dLqCwVbLbrUrfXRI7TSo9FGY+3bLKGmNZvWQ2Kqc2+TQp464zb2+UXCxbPLLiSDdQ5GKYYkKI
 LNRReZftnWqVSoOmEthW+9dIVQNzaVbFHnFilFis9flvkY7t+qkhYgSQfFp53kpgpc5X921qbal
 aga5WThKT4HBkWQQZveimpVb1LnxWsrDO3JZMOhB0piYW3WTY/h2muoqMN+1vBNI7UrquVC+PU7
 SFPpM88Oodm09Ug9/dvR2aM6Z6hJQqsXyTUGTu68Cfa/hvDTakQxMfYhfsI9zNMDgdVvdf3YwkQ
 TGbGXTU0iqI0YycGSu8bYT6TyhbNzEJrzErrl919f97P9Mor+/uMlIcOnyXdgrlMZHkW8BuIZYQ
 1jFXwTG3edM7csIYvBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXwPzLrnO3tlkq
 Odz6J8fn5uPutqcqQdJ3gYfqMAwczcR7UQ+oMTLGII+6UwwFFjAHoaWjQ9uZ49HvneKC+1tIFKS
 +HXt+M3Hg7CXGzApr6nZObo73KWPd/Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-22-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


