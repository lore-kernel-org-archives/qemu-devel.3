Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD4AC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGKQ-0006b0-9l; Wed, 12 Aug 2026 17:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKI-0006ag-Qb
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKH-0007km-5C
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:30 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2cie599726
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CTL8wcdSUWwK33yVhke1H/B7124nQYamJHTbfP7lLYI=; b=nejspe8PclA+j/OU
 InA86rOrZyLYsrxCTSaX2n+UQHGhZNEqdkKnqerIq9w1ItpjiGSbwCg2ZRS2d53i
 7MnmTIGDpAWe5Wj7lsk5E8l2qUOELLxseazYbhBUTEvKe+vqIeQhKr3xMF+IE8c4
 m6HMShWE2erIemBc2+f70C45CaNbYbKkwzkbKBHpM4YW18M/bGfroSpyerG5dssz
 +hfcCD2/dCJ3FqvHKExPEN5O6csObbPtJdKWbUXANZWmsoM15Qr9wU7auO/p8yPr
 GDb/44DsNlDmd5D8wPsN+hTtajeFhnFSrsCWb4/a/hlwOlwXaGd+nIxim5ErzpYC
 5NnF8w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0y04gd1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso13607071cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569447; x=1787174247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CTL8wcdSUWwK33yVhke1H/B7124nQYamJHTbfP7lLYI=;
 b=KvfSDq7qshw45vdmIxiF4h1QkpA24Bq+NJ9Es2uZonajNmwcWF+yTjKQi07l1S+Bm4
 RfEC79MdyJ3duaX8mVqxntcykgFxTdxUyb3+Y4s2w3m05qmfGxzVcH44cpOToGrBEBJL
 iovfdYPW4oLs/FtPIwwS6Hlr3vLmPjUQIuL3lM2B7w+fcysvz56fezXAf3jLWWdwQksN
 vr5CE1j0dPy7nJ1ZS//PY7yxuIL/R4lHn3dDmYC5hk1qzt3vRXmcECj2f1cKDryx2G8e
 w00fagn5CFDqOPGIHLa7uCQMKPu33MY9QFKHbljRprHD+KPuHf1q2DOQnrkykCyC9/Yx
 cOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569447; x=1787174247;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CTL8wcdSUWwK33yVhke1H/B7124nQYamJHTbfP7lLYI=;
 b=GslhavwkBFet08WTI+R5oHo9OvjSZJRMeOP9D5QWAqG8KNX5FKk+AxxGCcUOPxNKdN
 MppQvYJKoE8bC9r2a2GHGRetDNgRfe4OSOUxa5j96iQvg3IBd06+xBahv2J8+4WyOIgF
 cBByVjjHKsMaM2yHOX9Q6MjnO8AVKjV0ZhYGvdR0qw0m+sOv0NoH+3M7slwM1t7NLlFy
 1Ko8At9mfj/Hto4AwUV6UGQfEjmh6MklLym8TPNmBD0TyhAfXXoqUV1GsQlVJncugj+r
 JWaTxNrOAZbZ5JunZjCZuWqc2gD4ogkn5233JKETZcFan9arqhV+rEXQUG2MdDhbLGiG
 sAnw==
X-Gm-Message-State: AOJu0YwtVHbwzRrjxMsDl1xBsHU80o8004lcAYbxTH0qXjFE18ug9/CS
 d0ff7alsJUN1dZGtwCcYXXp9p/oM/Uh3xBGyq1jWvVGB4eWal35ZXKP1OfpUORiA9jsYEbI5tGm
 KO6+jQDBKjUwyDi8VXW8U8GJ+NWbYj6AewAb12+X6K/FyKGJqUbY6HidnsU5uSmslaA==
X-Gm-Gg: AR+sD13f43Duq2rMIv5hQ4jNEMRwzZA6U6aXQqPUQ1msfyewEclFg067VAM6IZ0X/59
 zK7jZI2Vb+LWoLoXUp4KickK8rH5bxs1MKFuTbKGJjqBCu8zEKH7MS1ks38axD5L20DtyvsDmkv
 QkAkt/1qf3+k8iPIx+kmCt5CX86H/hop7hN3/q9iuBfQJjp9USGmFQ2y1tJqMOU+G15S4VWMraM
 uW65tl/tkXbi0T0AjVfrQ6pm5NsQ2Aw3fkPRxpYd6gfEDsnH7M31wfv0FfvUG01kS1fTWCeWYT8
 hEsccAEnowiBX5f9WeZO7rDF2Zih/SCIendcrRX9qmwUoLEVutU6hAPrn8YebYwztCSUm46ogBU
 fIk4NfDT1jm/YeZVvn7FbFhVTGcnM6eQ8P/piT6QHEg==
X-Received: by 2002:a05:622a:4c15:b0:51c:73f:e3a7 with SMTP id
 d75a77b69052e-52d73d14fbbmr12250071cf.26.1786569447291; 
 Wed, 12 Aug 2026 14:17:27 -0700 (PDT)
X-Received: by 2002:a05:622a:4c15:b0:51c:73f:e3a7 with SMTP id
 d75a77b69052e-52d73d14fbbmr12249471cf.26.1786569446738; 
 Wed, 12 Aug 2026 14:17:26 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49982131261sm11879755e9.8.2026.08.12.14.17.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:17:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v3 02/23] net/vhost-vdpa: Include missing 'qemu/iov.h' header
Date: Wed, 12 Aug 2026 23:16:46 +0200
Message-ID: <20260812211708.92824-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX8LyhEGlXnd3F
 fq/tQvPBvMkhuZdRkrz70W1iZjI0+o+Jxrybh9R5BVjkuOB0r2Xr9xVk1nal0DDyORpE559G8AV
 +9f2zXEfADl9YcVCDcy6HHgtpYmUAX1GC3zIaQoSY1TK4tg7pilXC9/R6/L4+ckOGfamf1huk8i
 q1Y0xkc2EKdhz0AeGHEnda7QFcdjZ6QZd0ToIC5qgLmoduhQTNbJM5X9jVf3XL2+M+xKX1aP7OO
 nghJLDlO8RQysQClVY5IxNDRSLVEPJeuXx37n4oslB/XcmU7Bdl8gzWD9bOklKkcEe6AJg2ah42
 LTpnLK+Zii+o2I70ip8zGxf629zGOtNywEk8gWrniluq9NUsOpAFg6pHpX+++4XZ1i2cMPpXgHV
 E82J5n7kK+RNkqlzEOutJvLItH0I297tu/KIMp/pgEjLs7ls+zeAEuk7+F4bh8tIBnzVexICUsh
 9C+94LfgL3wFX0zvAeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX7bmKZje85dNN
 mKanYx994p2RSHn8grCmcp8DDGE1ePhRrE+9lunIj6Z/rnWtSBxIDCEhBK8e51Rw0HgLvLnuRb1
 Q0l0g6qwHP0fEcj6CiXfIIlAd65XQvg=
X-Proofpoint-ORIG-GUID: r990-IK_6LEQbotFCHZKdRPrO9nwzYzg
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a7ce2e7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=q2KDGgPci4KyuifsgR0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: r990-IK_6LEQbotFCHZKdRPrO9nwzYzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120171
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

vhost-vdpa.c uses methods declared in the "qemu/iov." header.
Include it otherwise we get when refactoring unrelated headers:

  ../net/vhost-vdpa.c: In function ‘vhost_vdpa_net_load_cmd’:
  ../net/vhost-vdpa.c:714:24: error: implicit declaration of function ‘iov_size’
    714 |     size_t data_size = iov_size(data_sg, data_num), cmd_size;
        |                        ^~~~~~~~
  ../net/vhost-vdpa.c:714:24: error: nested extern declaration of ‘iov_size’
  ../net/vhost-vdpa.c:742:5: error: implicit declaration of function ‘iov_from_buf’
    742 |     iov_from_buf(out_cursor, 1, 0, &ctrl, sizeof(ctrl));
        |     ^~~~~~~~~~~~
  ../net/vhost-vdpa.c:742:5: error: nested extern declaration of ‘iov_from_buf’
  ../net/vhost-vdpa.c:744:5: error: implicit declaration of function ‘iov_to_buf’
    744 |     iov_to_buf(data_sg, data_num, 0,
        |     ^~~~~~~~~~
  ../net/vhost-vdpa.c:744:5: error: nested extern declaration of ‘iov_to_buf’
  ../net/vhost-vdpa.c:748:5: error: implicit declaration of function ‘iov_copy’
    748 |     iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
        |     ^~~~~~~~

Fixes: bd907ae4b00 ("vdpa: manual forward CVQ buffers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c526c2b2dc0..1052361a4ab 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -17,6 +17,7 @@
 #include "hw/virtio/vhost-vdpa.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/iov.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
 #include "qemu/option.h"
-- 
2.53.0


