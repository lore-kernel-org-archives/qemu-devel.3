Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE64C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7tw-00068H-KL; Tue, 21 Jul 2026 06:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7tu-00066c-UP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7tt-00036C-Da
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARUpv1455627
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0RPqPhzWejwl8D2kGhO3BkJ+420N4gsV0OefL4OgfOQ=; b=FA6Tuy12e1EnuUGW
 J9ntfPWPlEY/woVAzT5XczVl3+H2SEJ9SYxhmEKzAVfFjTUUJvCDt+Fua7930Q35
 vl+7cN0vBwBRETTnkL62gv1VWJ0vFV8J6zSX5JqS+3dl2uNksQutaTF6eiPUKxgo
 Hy609mllxWqpjysRF6jkC8jXScMRRQ/A60JsGv7mA2uKCztQbI7cO7Z/eB67FGZM
 2gl5QnjC7JuxJQulG2cwToFFyJxiyuv/m2RKJpj19YMsELMUGk7jCzJ6LWE+xSTK
 MNry1SRrYdsg/5nWTqMM4IZOk3SmHI9lcHRusPI7On6QKmzDbi9t7aSFpAHAhXs3
 JxDzJg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1duhs3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0408254aso109459941cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630436; x=1785235236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0RPqPhzWejwl8D2kGhO3BkJ+420N4gsV0OefL4OgfOQ=;
 b=SIDe5k/iqhsuR9cpVs3AOT1+LolhfECd+wkfIuYg+tA6QTzqtS6suK37JQd0fDUHEA
 tl1xJfzjNUcsvpzcRvQq1cQyNs8wfsUkGMhn8UMs675N7JVi0/8agES3TrnKVLCs3Xc1
 9f1YGsIysvmxEpUnqj+Ov2gTn8rHttUcACkG/LokM/zMmMCD7fBMwE17v+9rjUwlwJlF
 ukH5LDVU4zbHlRGQzKpMVlGqs2FL2bTrU40wiVihO0JJkjOVx5J0RKLLfu3jPG1IsVO/
 eoS7XZV0+ZnqGGpwMw27kx708ergd9lSODhPcsPICulQ9L1qo4TuH4sEt9T/dM/7Ss5/
 z0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630436; x=1785235236;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0RPqPhzWejwl8D2kGhO3BkJ+420N4gsV0OefL4OgfOQ=;
 b=gp7fgKhV8NbQRFOAznuAtYY3SMqPSzYd82dmvJivmaz3O+orjuDCgUrOIPEAN4OlkI
 aslQb+5C2k9ezh7oJtnoEsbolLdtYBXGiPcDbiibhUU5eec1aevEndco564mC9Lxoxa/
 o+3uFLN4ggYZYpMvFezw/y/o0IHZOtD4jqWCpRbgbnNlsxg8zom6B+Eg6LY0jNrC5a7F
 Ya+8kVhMgY0wY7IS76hEiJfRhxAMiJ3R4DnRIqL4ziPPBQTNiqPyx7fuKvCklOG9biwB
 v/n4i7KoQzrvP1U/2A0PD5IBqIXIj5PFKDxxsqTN9OvxjIrp67g4LB5x5L9DO/SK9mvk
 hr8g==
X-Gm-Message-State: AOJu0YxEvrtOMx9S/hujl9Ku2thbT61cMVMobOG0c7TF5O08d00Ejyfd
 nTUSlds1kYwNAtevrHpEe51s23nd8iHMq2oOIt8bR7cZurrppvpbH7VPb+txIPma5MdesPjUhRc
 kB8LCks/nEEE0zeRngBNskteOXhHMVnM+FJu6suQCevxA6sQTqBzcOKb9dL/Cg9ahIg==
X-Gm-Gg: AfdE7cnLoY8ZWM6pQp21ydPqJLMZz7QSLT3BNBbqMTQFMc0n/Fz7oNWFmFg6BLeZeZh
 wuU4DJS9VcjHP9BRSgwmbmJdxppY1xN+rCtkx+czJS/fG4URIviU0ADL9qknwYruawohLC7Vdim
 Mhait2gd5tS3cUxCu2Wjj43920obpnJBS45c9uLazWS1P0GyttdPl6goGaORS3Pzl1H/fX8t/gk
 VfcjyYSNmjl50IsnkutgF2aWYcRRUgifAOr2Uw1P6varUJ3Vae2rLzq4G0kcLYZakP0quyZI7PO
 /okiMsBfmqB6gAo6uWtLqmSW1M25R3yRNmMQ9Mz/zD1zHDe8SmmyFhwPfzEeyU1x3CIUcDRCYqe
 U/4cfjrW1xt+DeGl/WRcLnhMWR45Vi+jbjUlAsjBTy3bGJJTcrLqxfggztg==
X-Received: by 2002:a05:622a:3:b0:51c:11c2:dc17 with SMTP id
 d75a77b69052e-51fc214babamr194045561cf.40.1784630435769; 
 Tue, 21 Jul 2026 03:40:35 -0700 (PDT)
X-Received: by 2002:a05:622a:3:b0:51c:11c2:dc17 with SMTP id
 d75a77b69052e-51fc214babamr194045421cf.40.1784630435268; 
 Tue, 21 Jul 2026 03:40:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954c0a81f7sm248957665e9.1.2026.07.21.03.40.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:40:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] replay: fix use of uninitialized pointer on error
Date: Tue, 21 Jul 2026 12:39:59 +0200
Message-ID: <20260721104004.84934-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4-6I1J-ItjTm0vmCF_0CRRBzfE33t9pP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX7ICXWXW7P7w/
 QSQk7FRfh9D8Jwhac12fe8NXpLPZqbRrGHC425OjUYucqANtGoe+I3/LlQwaY4l6apYuTmiQyUS
 s54wc4CxLSGm2/eoZwDKlAQ4EFOEdClmrswTaO2B95ZBvb9lN99dFR7coSxAAlIXu+znBSL5nLK
 RzDt6Ym2QObBmdV+MXX4cRJRum8XCU141ohjXUqof5+1DXj8XowkMYB6FuBi9rlXiCItgn2w1Wa
 kNB9142uAqTq3mRRtZ9XEFkfIW0kH9x4XPKjoSjYxVFGXRl/LVYATTTXuZneGrFhg92pAu48PfG
 qmkEuqeFf8lIiI8ArA+1AqW456ICzoIUnqxfyEABUD93XEu6aiQl6cHO8C380pNvXI2rXw5i4VC
 gByYifBBmtS+vSSiLmfT01eXuX0xKdmtl+xEJRUaf1ebrOWXIZ06LKy5krqnsMkqr66U/zJkL0H
 kZJXjxPZoUEvf/QxU0Q==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5f4ca4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=RXSMPkjri_SMByUj9oYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 4-6I1J-ItjTm0vmCF_0CRRBzfE33t9pP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX7b7VoQ6HVm4Z
 t41sjRnyQHYCDD0RA8Rky+E+HCvpS/q8Soo4eIwydyaH7jlGfs4OzwM9aDQUYgdNVrIMrzZ4NJs
 2t7OdSwCQkm2OEr094et1Dc8sbm1XgU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210112
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When bdrv_snapshot_list() returns a negative error code, sn_tab is
uninitialized. The loop does not execute (since i=0 < negative is
false), but the code falls through to g_free(sn_tab) which frees
an uninitialized pointer.

Fixes: f6baed3d1485 ("replay: implement replay-seek command")
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260719113216.1177594-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 replay/replay-debugging.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 11053640021..7b904a14165 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -139,9 +139,8 @@ static char *replay_find_nearest_snapshot(int64_t icount,
                                           int64_t *snapshot_icount)
 {
     BlockDriverState *bs;
-    QEMUSnapshotInfo *sn_tab;
+    g_autofree QEMUSnapshotInfo *sn_tab = NULL;
     QEMUSnapshotInfo *nearest = NULL;
-    char *ret = NULL;
     int rv;
     int nb_sns, i;
 
@@ -149,15 +148,19 @@ static char *replay_find_nearest_snapshot(int64_t icount,
 
     bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, NULL);
     if (!bs) {
-        goto fail;
+        return NULL;
     }
 
     nb_sns = bdrv_snapshot_list(bs, &sn_tab);
+    if (nb_sns < 0) {
+        return NULL;
+    }
 
     for (i = 0; i < nb_sns; i++) {
         rv = bdrv_all_has_snapshot(sn_tab[i].name, false, NULL, NULL);
-        if (rv < 0)
-            goto fail;
+        if (rv < 0) {
+            return NULL;
+        }
         if (rv == 1) {
             if (sn_tab[i].icount != -1ULL
                 && sn_tab[i].icount <= icount
@@ -166,14 +169,12 @@ static char *replay_find_nearest_snapshot(int64_t icount,
             }
         }
     }
-    if (nearest) {
-        ret = g_strdup(nearest->name);
-        *snapshot_icount = nearest->icount;
+    if (!nearest) {
+        return NULL;
     }
-    g_free(sn_tab);
 
-fail:
-    return ret;
+    *snapshot_icount = nearest->icount;
+    return g_strdup(nearest->name);
 }
 
 static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **errp)
-- 
2.53.0


