Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1739C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eS-0004FS-4j; Tue, 07 Jul 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cb-00022D-5T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cY-0000VG-UC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8egm3606093
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9/xwOjdWaWLOj5FkMnw9lCn2viCsRQ9OPALqKHUIsjE=; b=DnB83yPjGbpAjm8E
 vGHjN6z5vP+DheCsZt4IT2LB/4TmutudGUj+Ox+AlAQoWtzN7jUGttaaQrUyXP60
 stHTLs3eQW93QFn4h8BivvKHILqnB8Kt4uvQhbPZVxF0ubeTMUd3D37X3lHKmG/e
 C6nujFwFO2TR8xg/aJNG6I/3OptFgj1QC3G7Z6pvmfIrk+H+ufwhy1mZ1PHeDWjj
 pLt+f5YFkzJKIrr1fCJBcwkWqmqFliUZDLrSDI9uRCQM+TP+GtrKHZ2gz2RMc9eR
 qgxRf3INthxgipNNsal3KgK62hlyunD5nGryxvQEZMY7QoBeQBLTc9tXmsyzbSP5
 gA7dZA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8j4fk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:13:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0d6a2f4cso46960471cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430031; x=1784034831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9/xwOjdWaWLOj5FkMnw9lCn2viCsRQ9OPALqKHUIsjE=;
 b=evjirTtvPMXx8fk/Eqa7CLSeFfu0IC/XxtS5IaCkl26uoVo8mvWYB39gx/f7iNL0+l
 pZmHYiO8fyuYPBfCTPglGfyF/XRHaUTei18fuBfP39A+NhnvqtVKf/uPb15+xLkDl9w8
 XN+3foFDzoKs/idSeCiM4ztkTex/Xyuj/EOTwQKivNw/2kmMckJrhKaQkMilS+kd83Ry
 29WzCNfPxWn41LCiOQ0gFbHWlrY3Wc0BQvS3Sg6cxf3j36VyZyq/pZ8hhWxyFWOQvQau
 qhOndS3zZg6ljZypOvXcAART0S0Hy6IpwKE+JzXo9RRdMcrIV8WkvCLxbkgIDMDoGjJJ
 h04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430031; x=1784034831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9/xwOjdWaWLOj5FkMnw9lCn2viCsRQ9OPALqKHUIsjE=;
 b=PeNGSH563/+VwXTIFDznp2R35jJzsmi7YnfPp4qFYfLp0hK6HiHgvHm9ld00z+vH4C
 M9Mvag9FmKw9n7F/62bAH9evD/N/FUPTmgATM4H27mQX1UtQlZT/+la0zF1WOCgInV9y
 M1nv/bdM5ZgEtHYCKl59hC+b7vh6jXmmTzg3OV2QKgkLnRnC3ASyPwCyTjREHrkpmvzm
 0p8LXb9LLQyeYK19Ww4JdXbpUjszqNmq7kukhSuyfPQy0eCXWgdxfA08pQ8oPGwKYe77
 UCqv0YnqiheJfygKm5MzMbz6aciySRILy+lsaGRPP5tQqq9LxAyL5FCqq35bYHj02hSc
 HVTA==
X-Gm-Message-State: AOJu0YxLeg8tGkQAdMFS1TWzHWPzgcpEwKCnWuHdjhAa5c9usVJXyKoX
 vzipSNjq5KvPcR01e3cem1LopiXiotXnCik/LSbMak5r9JH9G14flMan4Knq+ZoYF1YH4+FQ4IT
 PfznYus8uIKnyzA2fGEtw8n3wlj0y5qqYkyxwQBblq8Of/wJjcC3zdYacf+7Ay1cHBA==
X-Gm-Gg: AfdE7cmReAKiLBKRwes3vG7OVNvWAcu+nfDg8FFnAPEmp/8KI62Fx2SQ9gmrBbV+alK
 H0LM5EdY4hbFg5SIIIkRky+8yGrEd6vYXghnohcN4pCAeN7t1zSMFgsPMFUHqt5Tgf44W4JOxvv
 4VSvThqtinKFJG4937rrs0Rgqyn60FCQ2vI7M3SaD7cmB1XEX54jYfA2HGeCobxXZYWkQ5/jBz8
 RLXLohBpF5hypDgmVYZI+AdStlQJqi+59Em1T5jx2rdyOlnRn98cB5allqWyG3NQKIQExibqtba
 3wT6M9MLfd7tETDC889c8/9XY+sdbbN7mYizL7tfwoH41+ANJd8mNUHl+KlvzDM5Kgk1xdi0s/4
 HT3bEf/ghlM84ww70LyoYieoj8lGcGrqTh2FUjX7msQjTAk579FrxPelqMMX1rbAQA5Rv
X-Received: by 2002:ac8:59d1:0:b0:51c:478:32a1 with SMTP id
 d75a77b69052e-51c747e5dd8mr59290881cf.18.1783430030855; 
 Tue, 07 Jul 2026 06:13:50 -0700 (PDT)
X-Received: by 2002:ac8:59d1:0:b0:51c:478:32a1 with SMTP id
 d75a77b69052e-51c747e5dd8mr59290071cf.18.1783430030051; 
 Tue, 07 Jul 2026 06:13:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad8839c3sm135707066b.27.2026.07.07.06.13.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:13:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/32] hw/scsi/mptsas: Reset doorbell state on reset
Date: Tue,  7 Jul 2026 15:12:02 +0200
Message-ID: <20260707131223.51505-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX14ilVynOgeEn
 GOnadeS4q0DCc5hTJt1TUpiKTpBY3ZUtOeqGpxdffx2ahQJHT81ce/7g4uaLdvm4HTpFN0FCmjD
 4A0i8qb5ka4k207n3ZXLFhG/NrSsCwnwLkWwOA1Y1I6KZmH1B0K1z36JOd5CGXmZnWzm1H/HI06
 g+IC+xTCkZs+IOAqQfP5GfZL3MJ3Qmp2e8gOjT2COh1ifM4BFb3MVCu76B2Cwuc9ix3Qhov4VfG
 AazaxK2dvAaELTOf0JaBveHC1drH4+V84neFWwvTfi2M86thSpRPCEfkNtSYh0xfAPbSpGTqNhG
 mpV8OLvLrbX+j9kPjCxDFQ40ob2Cx4SWlGy/DG+TdFJUP6nSX8rWt2kd/KNnfHzkplfcVvjE8C4
 nJ7zO4cRC1ym4C/ZWRP8eH6WmF9+kll3AoqtDaYsTIwrAXh7g2wv9qh5+oQpFVSk+mEBBLMX6Ho
 xGPJfMgRo57qVUaHeHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX0Pdv36/FnrMA
 cpAevSGTZlIa+QX5fQEYH5bb0rxaA9v+CjtZo2iPtSpiw/45U2uJi225vK+Oe7w0HmGoOSlWB/t
 9Sdh1ZIV1XFI1rfkjbGs2Q4kpr+F8H4=
X-Proofpoint-GUID: 4mf4yYyGcRfFalIVa1h1HhSLlic8ZYt-
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cfb90 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=JFHzIf4ehS6O5uydGUYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 4mf4yYyGcRfFalIVa1h1HhSLlic8ZYt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070129
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently the mptsas reset function clears intr_status, but it
doesn't reset the doorbell state machine.  This means that the state
machine and the interrupt state get out of sync, and the guest can
trigger an assertion failure in mptsas_doorbell_read() where
s->doorbell_state is still DOORBELL_READ but s->intr_status does not
have MPI_HIS_DOORBELL_INTERRUPT set.

Fix this by having reset also reset the doorbell state.  Strictly
speaking we don't need to also clear doorbell_reply_idx and
doorbell_reply_size, because those are only read when in
DOORBELL_READ state, and the code always sets them up before
transitioning into that state.  But it's less confusing to clear them
out on reset.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/304
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260629185035.2138238-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/mptsas.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index e4a7b2fee4a..5df124c0ce5 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -811,6 +811,10 @@ static void mptsas_soft_reset(MPTSASState *s)
     s->intr_status = 0;
     s->intr_mask = save_mask;
 
+    s->doorbell_state = DOORBELL_NONE;
+    s->doorbell_reply_idx = 0;
+    s->doorbell_reply_size = 0;
+
     s->reply_free_tail = 0;
     s->reply_free_head = 0;
     s->reply_post_tail = 0;
-- 
2.53.0


