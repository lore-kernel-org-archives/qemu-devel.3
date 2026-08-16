Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2D8C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcBg-00005q-7U; Sun, 16 Aug 2026 10:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBO-0008Ge-5V
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBM-0001MI-Im
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDklPj3226330
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XvmSsw6RFZVExmETaa1Y4Yhn6lHhVX5/670/OVLoUdM=; b=EKqxcIk5OwS/0eRX
 2kJHuc8RL052+qDF95jZnPpsOVGXm8ONDqM39Uap2KBqj2puldd7onotOurUpbB6
 H731qFls5luX/3TdGBKT9Ox55JuzuzxnKzLlVn83M66P7PqM0x4nZ+CNr02Qio/o
 KERyqZjqf4vU58AcW5kHPczG3ofIqWQVtd525Dm7KyD5W/Kg5vDY7L83/SMG78U/
 GdUUFB5XfCurJKoRzAuWaydQqhNo0rjh9bT9exBuQAI+ixj7jww4PylvlA4hZ2Ow
 e4ZHzh7fA+/6PBORdi0AYKNamfwTkKszxTcyTx702/aHyuZ1Qdq8n9zqGz/wdb/b
 9x8nbA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g322q99aw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso32724381cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891790; x=1787496590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XvmSsw6RFZVExmETaa1Y4Yhn6lHhVX5/670/OVLoUdM=;
 b=Lw6gnl5yatyg0KnSePqZnQhX8EKsQwbVE5hcGeDdbpAf6LrJPKUd+g4kBXYkt8VT9h
 j3v1z7MzPTWu8sTEUCKZIVmi4ro9GoDYea6PdkpvZWPakpVMl66FFbB6BqSYHainggtA
 fWp06lr8Be4jJz0GtAIbaXAscBV37Q1la3hb3UOUZArasTT+rYFULR4ku7v7LN1eSQCL
 yMPTMnIXlkmGHR7NyPNEkfbctnweVQvOCuqFYWwKMJi7wF92E8Wq+kX7I1TsAhL5LzKN
 pcUJ5034wuSDaP4+u1686KHB2jUsRWW8rh0SsNDfapt3WY+mbt7eicT0lFmwrRKYJ849
 Va2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891790; x=1787496590;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XvmSsw6RFZVExmETaa1Y4Yhn6lHhVX5/670/OVLoUdM=;
 b=rDl9Lxn4UYghKPzVfgp8pceMVNyv8fTFRzNp6LrL50LaPVdbxkGCavkwBx/K7rhEDo
 E99FFlCSMD4jEIxAJ1zjH2rwJebYvEuCt9pSjUgSgxT2j0B6ZCtWPgGpfJBARJwWu5pF
 E7U2OYAmzL62Tvl88E4bQCzVeoRd1hjgrigFcSsJCaHSohvuO+/aVjRMLbVqqcRy7qd7
 VhEqRU3UB4ZosQiGe/qbE07sOhS/s40Dp63+he4J8Rz4jufsS3qBCZo7+4FWlR1pi5Gq
 EQmwcVRFtpjXzAoUWz9kF47apPF9DrSQnvMTBfgfj33gV1jVXa/aPEgswgThhONik8Qf
 sv0g==
X-Gm-Message-State: AOJu0YzRT0Mq1wRoco1t6GMKrXw+xt5RKsVYWySHHQNNnkFRNTXnpGK6
 dTazMAVYtNcAeN0stE/W0Ht8RPF7YFj2Ai/Jv81MvCeHahqu76O9VDXU79GmKD/YEIafWUojWLc
 xmO/aTvK0QiQdF8yauZxI0EIfIXKjka+lI5E/8KaaLpPQr3bbO3A70llfezAidxXKhA==
X-Gm-Gg: AR+sD13cyfeIiXDfVmZGf3AqOGtiq5Q/mR3g2GL1rPVgJyL3pi/AtXeJhJglBRuBN4G
 /r1euHvL/iSTj6fc10ap0bPHmmVXzWW/JmU0FlmSEyCxrhi84ipd16iO3md1xV0AsYUI1QYYSb7
 Ze7CXZt/fZCjOnyZeSLYC3nX60xcT5/ioH5XQjLxDxjuXm5IVQcPKChD8v+NwImboMeDZLnAjN/
 qnmfMzEbQ9p39lYTNzYBiMPpwT/5bQvgBdV5nKNO73Fnu99e5zeZGBnuBXPiorIGWfcZujDGVT4
 Alqx1j+SZIHoknlHDr4NQzBpt02oCj6AwsDe5Uzotb9BzfWuLDDfvy4uq5TqQlq3EeDZ/d1sIsk
 Loj+bWEsV3oXHZ1ywBILwlNYniBRXCxB4xvfC90v6TA==
X-Received: by 2002:a05:622a:908:b0:51c:1a17:eba0 with SMTP id
 d75a77b69052e-52d852f1f15mr223845451cf.2.1786891790165; 
 Sun, 16 Aug 2026 07:49:50 -0700 (PDT)
X-Received: by 2002:a05:622a:908:b0:51c:1a17:eba0 with SMTP id
 d75a77b69052e-52d852f1f15mr223845121cf.2.1786891789772; 
 Sun, 16 Aug 2026 07:49:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f229681sm21097763f8f.16.2026.08.16.07.49.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:49:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/56] hw/cpu: Extract cpu_exec_realize() out of
 cpu_common_realizefn()
Date: Sun, 16 Aug 2026 16:45:26 +0200
Message-ID: <20260816144556.69009-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXwrzuDvTynYfA
 FIAQt2hhx9War9cl2rwZoacp594m9cTVTcTNNBJDAwZI7qpfUcuDjwFay9xaqPJxicS9xBZC7Xo
 tpBATI8D1ktMXWeHtNP/nkEcfPrrVBw=
X-Proofpoint-GUID: OALFlbVPOirW5hIy64ehpNawzjN8pFqx
X-Authority-Analysis: v=2.4 cv=C5PZDwP+ c=1 sm=1 tr=0 ts=6a81ce0f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=3ZqzEhZVOs4yraokUgkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX+ejxq+MTTtEx
 3VuNF5HCAsu/WTiSlREMWvxKw3k7q9Oall33J8+UX8sZCszfRrdZrrmub081V/wDUo8bLkpkRfI
 Bme/arP45LIT5gTLkgt0FPlNhX3A+5lA8l1BcFOwKOxCDD1xABu7nnCKhhNRB74/65rrEBqDCZZ
 n8YPHMXYoFnTWqPI1oL4iRzYslu1xO0hADrofzVvOSatQL3WWcma2k+e/tSOpBdB8ta5Def00nB
 rFUhyMXKZAgMwG3Ar/o4x9glVE2YVoCmBApa3NbffNmSrN1BRfaPbFejLiTvD5zRbkXJRldcq7H
 /HQRUuWC8a6BdH15LMHxamM41bX8PU4FM3oBPE7AwjBf8fb8FeM8PE5H+xtxQPGMnlbwkny45UB
 MNJSB4HrP0/SrwnP9pG+7/TXoia6CkgiCl6mmzUhK655nqZTsEPWdamy7wZauqJDRjsWsr+spnO
 cMCDaLFwki98jgFnpsw==
X-Proofpoint-ORIG-GUID: OALFlbVPOirW5hIy64ehpNawzjN8pFqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

cpu_common_realizefn() contains code only used by system mode
emulation. Extract it to a new cpu_exec_realize() helper. In
the next commit this helper will be moved to cpu-system.c where
it belongs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260811183410.22428-8-philmd@oss.qualcomm.com>
---
 hw/core/cpu-common.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 59cd489b713..cd7c8763cf5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -246,9 +246,8 @@ bool cpu_common_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
-static void cpu_exec_realize(DeviceState *dev, Error **errp)
+static void cpu_exec_realize(CPUState *cpu, Error **errp)
 {
-    CPUState *cpu = CPU(dev);
     Object *machine = qdev_get_machine();
 
     /* qdev_get_machine() can return something that's not TYPE_MACHINE
@@ -264,10 +263,15 @@ static void cpu_exec_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    if (dev->hotplugged) {
+    if (DEVICE(cpu)->hotplugged) {
         cpu_synchronize_post_init(cpu);
         cpu_resume(cpu);
     }
+}
+
+static void cpu_common_realizefn(DeviceState *dev, Error **errp)
+{
+    cpu_exec_realize(CPU(dev), errp);
 
     /* NOTE: latest generic point where the cpu is fully realized */
 }
@@ -379,7 +383,7 @@ static void cpu_common_class_init(ObjectClass *klass, const void *data)
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
-    dc->realize = cpu_exec_realize;
+    dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
     rc->phases.hold = cpu_common_reset_hold;
     rc->phases.exit = cpu_common_reset_exit;
-- 
2.53.0


