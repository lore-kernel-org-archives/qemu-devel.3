Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A876DC4450C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjivl-0002BA-FD; Tue, 14 Jul 2026 15:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivj-00024b-LD
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivh-0005Ak-IT
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwH9N1243017
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 txGBeOUVbx+l8Zf+Ah8Kzr+SZ1ndefrhdV3RNtC3Llk=; b=AYTPR9NFy4yt5CFi
 RKp3hEKPKV23SDU+JRmmb0L1f+MoVyRdC0OQ1xzm5zEsUlEWqQ60KM7AYXMN/ucQ
 Owro37DkYHxESvlWJTsu74cIeCESWzpQWzP4fI5VyJzO+81M2Gjz6TiNObwbgeWl
 rPw0ZMByVT8eLcEzriQV2n//2iqL9PQvn1z2wPcYGU1oqBOa23WAZla/OMgz6vvA
 cp2T6ny91+iQvzjxq7TSL0moCd3HdLgzL3FcatmqIo/Dm41lSq+U0H+A+beylgu0
 AAPU3z7/HeZZNlRJRJFdHB3WHLNOtjXmbMTotrmoqhQ2rbd47XIJ+SsR6H9pRCAF
 0sYOFw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmkk1vds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so68652001cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057791; x=1784662591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=txGBeOUVbx+l8Zf+Ah8Kzr+SZ1ndefrhdV3RNtC3Llk=;
 b=InwjLh9g5zmpSfSD3bP3Np+0c3hEcX8j+Ek3teU5O8mgOd8ECZ5aP1fZ8f+iHvvEqv
 YcI8718aR1y+mQJGlf1SZfgqCY/Qx8hJd47IITgy/PPgnRky6yZf8DMv5INf/7hEXxIX
 07u1b6uqgqilYbTPLBX/IX5VGyiGkBLJOMm4UcebHKxbqanZzD2DH9er19fFHsnZF6Q5
 tEIy9nwSUrdPkhA2Tk3sAIcwMD3Pmq5iLozzsVpPuGdhiWpQOwjglCBL1LMfmfbA++4M
 CFNc3xnh337lstCdU1l08hvrFbUBQlvvcamc8wo5St4TdS4jShoEYZZoG1c8vX18+1FM
 6xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057791; x=1784662591;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=txGBeOUVbx+l8Zf+Ah8Kzr+SZ1ndefrhdV3RNtC3Llk=;
 b=qDDgkJyUZJbL9NEpDn07ruukE2LuJGKUFignuPdqiYrbGIZhH/3TqQCqNyDJIi3yCg
 1gH91gFd1zanQWy0NpR8T4zuda5NCfphodQbDydfsH4rQXyjXH1SsodgzLDa8Ws9URlb
 6bx23phjN29C6x+1wDiIowQP7MR3IiGJ9slFUuFZzpcGat+wVHbqYieeAsOaMYrUVdSZ
 M44eSfGXzFcjvXks9cRrryVMUbPIbTIdQYi3icp1Jo2TzoEQyhsw8QR3zTxUTveqIHCM
 x+6tOLH9wOUzklxAmdr6priS7HvhwtKQwg9++pD0UTpt8SUbq9XJ5betYKyuMyWgxQq7
 wNSg==
X-Gm-Message-State: AOJu0YwLXcdRPy/7vbZDQyQtZPFeMJApHY4z9L7UuvrryRY991vgAm3B
 ZGbEqm1torcCBtrjseFJjt2ygGLAv6po4cNKCDdkKHU70awKWejD3mbdsajhKqFvFQHnJav8kLo
 hnoUiwBoUZzqUnAK3bDSxSDMqnyVxjeoqxSM1Wc1n/dY3miLYGZy6IqC3UiV7LYL4gA==
X-Gm-Gg: AfdE7cnSHo08W1RYxeYBVquk3iPwaOu/mUeCbIDiit8A/z5YwUIfsgCqI3VOSR+NtrB
 bKLECKHp6Tl9CH9NFH5jY+alQ21F964YWPOAB3gEe4hfdnw33L8tqTDtWQo9mDs3Pm9iPe01Dyc
 8ezJT/N5SQLtn3t/Prm8mZQ3iuradfq75s98gtG8VNRjwRBT1JJ0DWq6Nlx81jO19YSS+k7IkvS
 juswqPyl4D0/b7j99tVMFN+d7iisXdpPXevQaz2o/T5r2XNwrYXHeH6tZ/RY3gbgAgCm5Z2e+/I
 FgBnQMzsM1xTOwLsbX7/qBQCkKO9XgFjsSmnYmZqX0C2oaPFoyiZVLpam5d+me2yFlCj1GNOTF3
 oKEwCF7qcTZk3Hwq8aKwIuxFCXRekp0nBzrTK7NAJ+Z6aa+ptDQYBqY9b1XKWpv0dT5d7
X-Received: by 2002:ac8:5d50:0:b0:51c:640:231f with SMTP id
 d75a77b69052e-51e4f0bb593mr294411cf.45.1784057789563; 
 Tue, 14 Jul 2026 12:36:29 -0700 (PDT)
X-Received: by 2002:ac8:5d50:0:b0:51c:640:231f with SMTP id
 d75a77b69052e-51e4f0bb593mr293281cf.45.1784057787610; 
 Tue, 14 Jul 2026 12:36:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464bbb0esm10734702f8f.28.2026.07.14.12.36.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:36:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/13] hw/usb/hcd-ohci: Make sure that ohci_service_ed_list()
 cannot loop forever
Date: Tue, 14 Jul 2026 21:35:13 +0200
Message-ID: <20260714193517.60708-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -o315fYXU3QZg_BLb-wfR3A84Vt6rKVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX4+/XqFJuJkie
 uzZc3xYu1S8R2vjgwxsYoItfnPOnUljHsxAZBGufLTNmUgMUJKCH+CUrss8RWNcj0e2heTxszOh
 oee7W8TOhY+CKbWVSklvQnxuWhH0G9ajoQH42ka6KxqwHId3IZ+WjTHsJq232h2IlV741vnydYG
 jGW/PakkCAI67kCvLfRW8yyQ1LXEYARKBZjvE0YyuNnEip6Bjm8VZ+Lk3XJytvAA+9LksHDFho1
 fIR6/DOxz4EKcl1+cLh1ZiTDvOL3ThT4mLeiVq2fnUS+9LNni3V/LEWPznzkq7qqpzXGai4gD6F
 rOLhtR9GS0AEuOW2eqwsJaqSphQrzqm7S07ptOHXRZKdxapIFPwuMObMyCOm+6OTO1Z8YoAjR6F
 8M5k4267bLl1dWUSSzw2Ew5N4KaNxHeDEPGgg+a/8pghYaIDrrhbQrrsNJ0GX88TMCQ8OtlbQEg
 s97XK35P6ELGrq1iLTA==
X-Authority-Analysis: v=2.4 cv=NszhtcdJ c=1 sm=1 tr=0 ts=6a568fc0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=A_swr5QPKuRQRUEhd6gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: -o315fYXU3QZg_BLb-wfR3A84Vt6rKVJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfXxFEVnyM+dNt1
 ppd8VFW8sD7CFKTLGos5qFd4zYuwcScMRSxKR9y5oetLhALjEwg/CUNPpAuwpwMTQBjO3lTYxh/
 /1JTExAa9odYM9aGeOpDejQKOYNFV2M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140202
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

From: Thomas Huth <thuth@redhat.com>

The inner while loop in ohci_service_ed_list() could theoretically
loop forever if a malicious guest prepares a set of bad descriptors.
Add a check to the loop to avoid this situation.

Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3781
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260713160458.343323-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/hcd-ohci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 40ebafb4dd9..c4a9741bd42 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb/usb.h"
@@ -1129,6 +1130,8 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head)
         return 0;
     }
     for (cur = head; cur && link_cnt++ < ED_LINK_LIMIT; cur = next_ed) {
+        unsigned int ed_cnt = 0;
+
         if (ohci_read_ed(ohci, cur, &ed)) {
             trace_usb_ohci_ed_read_error(cur);
             ohci_die(ohci);
@@ -1172,6 +1175,13 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head)
                     break;
                 }
             }
+
+            if (ed_cnt++ > ED_LINK_LIMIT) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "ohci: Too many endpoint descriptors in loop\n");
+                ohci_die(ohci);
+                return 0;
+            }
         }
 
         if (ohci_put_ed(ohci, cur, &ed)) {
-- 
2.53.0


