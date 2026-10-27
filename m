Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F143606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ohCELvP7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BHD/9G5T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLms5-0000G9-RD; Tue, 27 Oct 2026 15:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmru-0008Ed-2R
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrs-0002XN-9w
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHqVV2960454
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wV58a87elWPn1qKA2O8/j56++37MwVM7H5xRVH3BlGM=; b=ohCELvP7PP2HqyU3
 WqVU7lLH77x8JWVD52xGbJ7lnN7D571Nc2jFqGL+KHC3gH6fvrP8mJRfNhX8eSyn
 xi96jmyxLyxfe/0qjnqdQ1WrvHTb5EgVWrUKBC5klWmfwNPCMOqHcBMzDdV8Xi7k
 h/ts0+53w/AGup+byiFiw+G9C7Pn+qQJVk0tWz9G9Mst4OrIf9doLP+KZtbPk+5E
 RwOzPbaY0vAvwMlSSMHxLM8OLUMjnelnNxmQL0Gw6gRIfJXwn+AII2hck1l0dA5u
 PUYOULXqLCbzNx7e0VwfreiU+vgD2/fQ8yKOw3B3WqkBMfjW/MhWPGA6qJaGeW29
 xrLRoQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy670vn5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c70349f65so5386956d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129394; x=1793734194; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wV58a87elWPn1qKA2O8/j56++37MwVM7H5xRVH3BlGM=;
 b=BHD/9G5TKeHVlfhjwrX3bLa1Inu9dqHPSMrCrtrWqK2aInkhWHGFDUge3BlslqrkDv
 hxPp4RJpz6E8adf/nzidkoiN/tH4DMW8ZPiDhxTS+f9bi/Pg1KSnoEFFHrrj8gxFawFa
 mpXNV7v/qeTvNeP70khkBV8F5/PvZKoV2oWi+ENYp10u3OVSLr3Wzka/OjjCLzeXHIqg
 9nkg1AelZQlPuF2KJp+FFXfKYbSu0tZbgyxuvl6Do2LNtnPtnBuCrqiDuSazBYtw/fH9
 OJGjJI2k73r+PwZG/sTsrQFaxpkTdjbGY1d5zfi6/0l5i5bauXuLTVtUYGy/98qPhIpC
 U6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129394; x=1793734194;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wV58a87elWPn1qKA2O8/j56++37MwVM7H5xRVH3BlGM=;
 b=s6NjO5NJYqf41sQOcsw8cer4YvsSNuniCzI+NA82JvHyUDm72gvhhPbHDUGkEhQO1B
 f2+2/UlHVytPfCpIPeNPOujC8Ux9p2/oo8NDtMtwq92BwD8Xb5IXCixhWPLedhxxCXQ+
 6LWR5lfo5vjDtzaAXgECrDfFLV9jrO3Y6pq0+DkR2ZnnhcrQSC42MtQX6pro57TQ+cVe
 PkifTHuVXxeXLLxXZsB+cP0v8fAjVd7+Mr8HkrlZe8Yr4j6PmY28EIYra1HSkY6KQUHW
 zDETY2JQxGBbZZh8RR/VEJrFnmUobobIREcuuXbIroKnDU7Fy+I1pFCSCfHyg1QnGXba
 o7AA==
X-Gm-Message-State: AFq9FYLXnnmvGmLfG9pOiMwFhqcdQJCqhGo2uCDewletBsov8naXZFZq
 zcu/FPPWRr338yzTKpNh6+wIAMX9UF4ARsbqUQLqKmdsgJbIGcn0hdZ6AOCszF/23WGvo12lk8f
 KeDKysvuNfxmRrddvuFtfVKKkW+zhz+1ddCuBSA9Y2KdSytp8VXgK6FoNTiOzeE9Ysg==
X-Gm-Gg: AYBFou2astyDjDOiZbNp1hzTuCuIpLxWOp/zFnligBiCkJ2lkGXA9071dWEkmgDj6Re
 TgL+6FOBOJ8Xt1TaU/il5gn96lnQXzWz3aRHLrgLa+o4CPIyxEdFGhFbR2K3PEvnBUu1CQr5Ibc
 //1clYGVDPFv7V9imBNPKKnyHMjAzAeSAF3cO5yBPFsHZagJbb/SOzEIjBT7cIhDRWjp3L6wN1l
 Dm2ZGV1fCkl1ZXU+vTNssI3uwLecImVbGGg8iMa3RFax6Bxj4YCEpqavLANj73PgKpUAwv938Uw
 hn5KUf6frnowzM3A71WlMMARALsBIO3FmGRnL+nh2a0QpaCQ1J+0L9e8IVFIIUG1SJfDpP2N5xD
 TBSSZ5jgfFRdJDZ8VEJN7Xx3HTUhT/pkB9+PQelANwj1eDPCpfYHWWUvKp1/e1llpgk78mwjB4w
 Bgrgh+6sUEqA54VWGL8jMi3iF1URqjzg==
X-Received: by 2002:a05:620a:4586:b0:93f:94b:81ce with SMTP id
 af79cd13be357-940ef9dfc23mr1708673685a.81.1793129393798; 
 Tue, 27 Oct 2026 12:29:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:93f:94b:81ce with SMTP id
 af79cd13be357-940ef9dfc23mr1708669685a.81.1793129393174; 
 Tue, 27 Oct 2026 12:29:53 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm24000291f8f.42.2026.10.27.12.29.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:29:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 54/59] hw/net/cadence_gem: Check guest-provided queue numbers
 in screening registers
Date: Tue, 27 Oct 2026 20:23:35 +0100
Message-ID: <20261027192341.9197-55-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: J9_LKXnmZSOzWfqC4JFVWQst7ItozpG7
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae0fbb2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=pCXGLztfb9cvn6Qfzu8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX3W+9gSDSi+hn
 NqnzV2+Pv3EU37cT2CiIvp7jfmHMIEK/qYRevuxDPrdebX9qCkZi/87ciAataxzBxzrhj9kB27I
 B1hzi+pVPWlCm7wnaA/dwvlktmUgEkI=
X-Proofpoint-GUID: J9_LKXnmZSOzWfqC4JFVWQst7ItozpG7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4Re7ITxOD0Ra
 YXIMmWXymWnZwcS6R3cMbkzVAV6cdJRfkIa5kdtkAHC/po+Y4McDMIGVbUUZ5kzzjeYRasRT/wX
 uS+iYvK34WMR49E9EMC806U8GAj0OMqtBbx+IzDvWVqrLuzlikmha4fPPSE29rzbAuJu20dI5w/
 R8YNqY654LiYGVtsjj+gFYSw/bTmydzIBSQc9xc+juDENPN5Smy9GK2401SBZk6Yu/4dVJrNGc4
 4oc1zL/qYdvcn26S/xSlVwdkMP7MSXsu7k+UVMzYBzq3QcRZjq/wRF2T5znB8m5ApJi64E4lnni
 ruAu+LPe5FJjj1Y7jg/DnA5uRqfGNl3KIn0AF/NYlq+9LraFKfUJv5L2oVCUcoEumxM21zsotF3
 q0K+99pVdPQLMZPW0R/D8PnSj89rjWIzkc98kxPvc2sUWtLYkxOwMrolw5/7hGpjMsRcyBCTy7U
 2jE8pJcsTnmN0ZjPW0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The Cadence GEM allows the guest to program "screening registers"
which control which queue received network data should be sent to.
The field for the queue number in these registers is 4 bits, but the
device might not actually have that many queues.  We weren't checking
this, which meant the guest could program a value that caused us to
index off the end of various arrays.

Check against num_priority_queues, and treat out-of-range values
as if the screen didn't match (i.e. go to queue 0). (This is a
best guess at reasonable behaviour since I don't have access to
a datasheet for this device.)

Cc: qemu-stable@nongnu.org
Fixes: e8e4994313b7 ("cadence_gem: Add support for screening")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4363
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261023153106.1710228-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/cadence_gem.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 39e3620ef5ba..9a94b3b8ca4c 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -854,6 +854,7 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
     uint32_t reg;
     bool matched, mismatched;
     int i, j;
+    int queue = 0; /* default to queue 0 if no match */
 
     for (i = 0; i < s->num_type1_screeners; i++) {
         reg = s->regs[R_SCREENING_TYPE1_REG0 + i];
@@ -881,7 +882,8 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         }
 
         if (matched && !mismatched) {
-            return FIELD_EX32(reg, SCREENING_TYPE1_REG0, QUEUE_NUM);
+            queue = FIELD_EX32(reg, SCREENING_TYPE1_REG0, QUEUE_NUM);
+            goto out;
         }
     }
 
@@ -974,12 +976,23 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         }
 
         if (matched && !mismatched) {
-            return FIELD_EX32(reg, SCREENING_TYPE2_REG0, QUEUE_NUM);
+            queue = FIELD_EX32(reg, SCREENING_TYPE2_REG0, QUEUE_NUM);
+            break;
         }
     }
 
-    /* We made it here, assume it's queue 0 */
-    return 0;
+out:
+    if (queue >= s->num_priority_queues) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Screening register selected out of range queue %d\n",
+                      queue);
+        /*
+         * This is a best guess at reasonable behaviour in the absence
+         * of a datasheet to confirm it.
+         */
+        queue = 0;
+    }
+    return queue;
 }
 
 static uint32_t gem_get_queue_base_addr(CadenceGEMState *s, bool tx, int q)
-- 
2.55.0


