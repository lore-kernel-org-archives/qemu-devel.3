Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A763C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Mh-0002dd-65; Tue, 07 Jul 2026 04:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1Mg-0002d6-1J
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:41:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1Me-0005Go-7e
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:41:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678E4WK3070589
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 08:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y7TPvKirCeSdr16gVGRCvuSxdqN1Kg0Z8IRZ2/ELulM=; b=Leelg+yZna6f6H22
 hm1mJ68VMvDzqdl2xmg+STdtRsm/JAzx7+y4e3an+7eJIhnU5WIUPVgjy8ZaEv0q
 it5eeWe2hZc8xoQA6iSMcAZS7JJKyuxInci9EDMWd/rf7uQYtL5EBkg1ODdaR3Z7
 cY8+RS/oTo9Kd30Z0XbYkLAe18X1QBjbvllhhA7JET/xt8tcHsPyTda+QYxEkgon
 WgeG7O6Rjr+JJkBWexhtt82sFJBKB9pxAr0jiH47eIl5aB67Agni9A8fVd919TEX
 4JlRhvpLZmXvha/bKyW3Hsz01bR8RAL2A7V+qYHObY9ROFZs4G1lChpxA5CeGEf/
 S/qhcw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8h38h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:41:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so78293091cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783413670; x=1784018470; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y7TPvKirCeSdr16gVGRCvuSxdqN1Kg0Z8IRZ2/ELulM=;
 b=YY11PTVkiRWUG5WcwCYqDCnTcF7z/2yHE6laBkaiZKgF9dZ/iW12vnTizX1mGZKNNU
 dJPPow1w6iGfATiYPA6HOYHWgU5ux1gqo0ZZb2roYKHegFE0taJcg6mPIFq0obMJbbLt
 fFxh7jgiqQ9DVCqz7BM976zmd4ofI514/WU5DNQ8fxIZt3EOEs84N/W2+splf76lFhUH
 HyU6QbBG0lleJWCBJwYvsR18+/ty2rM3cNyY4MwJvGOG6A6qvM8bHN9pJy+KMkDWlKiq
 DbmPzKel6JDi4VKBzb4eBwBgt4WYQVtlbFGF8dyF/mJUUVI3B+FZQIm9MXBk6XBlTsYO
 uI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413670; x=1784018470;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y7TPvKirCeSdr16gVGRCvuSxdqN1Kg0Z8IRZ2/ELulM=;
 b=RjWlN39HFzzxcdsvsn4E6G57rb3AT7IQW1miojbcJtsZKp8/aPdo5HYTFx1tSi5hfd
 ynUaGkaQ6SWxOSeCRdEnv+10OkH5GCUjAjMMtGxpTZnxi4iiZYNAYcEWcW4hz/u+Nn1/
 2HwnzmOakVCHGhpzkXSI62ipt34U2mrSL1mkv/VPqwx+WD9Qhj8oUjQUzZpfCNN4Xo1b
 q/Lz0CZ68EJnV7YohGYKsGrTjIKSFaPOQjziF4z5r2CV8NETgh/D5ko9YgP7hBmxYJ5M
 7lN1LseJk4KVjcMurrHcZsGrq/Nnq2nttljvToYKhPJPkDob/sdiWGE6hsYbQU9Uu/bX
 bZ0g==
X-Gm-Message-State: AOJu0YwPYACS5WR88ccYvQUJcXgfR4G7cyQh4QISauv16Ggv6VRvIxnH
 Hp5uOFgsaUznEvhtNv62h3QxqTyhWqz0PLrGcAcL6fDzhRH20BTtxDt5BtAHSVv5n7P/1/JnRDE
 6mog3i3aBGdit9QAxU7Ku9H2U2YZzep3pNfCPknqPbw9meheqW8gUysu9MX5wieIk9Q==
X-Gm-Gg: AfdE7ckNt/lTu15b4n0MUZJI0oyNNyZfCKJyVSHFTwj8KD+0rDbczuSbfc9GHUhHYea
 vkL28+/vkZYLrnXiSYpkjq+UnGRqZALQlWDmO1FyEcY+zt7yll6kGOE+yTBF6lIOUrfYLoajedj
 zHf/gzdlp1lAym5IVNuJ7GbBIDftw5N5DW0Dmoww6tf0zeH1ir3Mshl7/+wgGy2JrYZ01bCw03u
 LiW28EXitAJSpXygE+W8SWAAQq2CNKtN4LGpAxbJGFdllbu3pYN/yO11zFlaJPhkiHo6aCd5kuI
 WTeXpV9yh7If88GGzpr0f7Cl+0trOB+Nmt0jH5b/44bI09sUu8tSYwta1126iFtpU4A53/0qpPU
 aKijCY9hmtvXW1V8zhayCuUJ9N3VSrFXgoxON9Aj+dIQiKQkiHQtLKyhKYWR/j5ZRebYx
X-Received: by 2002:a05:622a:4899:b0:516:e249:e30f with SMTP id
 d75a77b69052e-51c7487d5a3mr47255131cf.42.1783413670051; 
 Tue, 07 Jul 2026 01:41:10 -0700 (PDT)
X-Received: by 2002:a05:622a:4899:b0:516:e249:e30f with SMTP id
 d75a77b69052e-51c7487d5a3mr47254951cf.42.1783413669709; 
 Tue, 07 Jul 2026 01:41:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0fbb410sm39721015e9.12.2026.07.07.01.41.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 01:41:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/3] hw/qdev: Introduce BusClass::is_full() handler
Date: Tue,  7 Jul 2026 10:40:49 +0200
Message-ID: <20260707084050.32137-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707084050.32137-1-philmd@oss.qualcomm.com>
References: <20260707084050.32137-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX8pFw3m7lck1n
 iMPuC7DwYgD7xWKeuYYmRurd7VJ9iMfCjZ7kng71iwd9sJnllu/831GEaXVmNtb3TlAgUzBsVEh
 NGvRzpTP8oC17lmnceKUxjMJyXFxrTld62bYya5Jz3j27wWKgT8RCRUcMF+vpsGb7rHgJ2HgRnC
 DOE6GgkhoZM/thjJUtqwOK/cLlB5EVEi0E27sZBEkzln7H5PofCRXxxB96ZtMAQOXkBAlikzE35
 mRj1tESqwsbjS92L+srMt1ZAqPY0LhzQ+LVIlA02cd0Cm9oTyjKwP+S+KTcdN2dxx5i7THmCRUC
 hvazICwLkyofyXg/nOj18dz+XuH362IU9rs9olF7kGlwbah0zTEUd0Y0KcVYX9H3AnyspGNiSij
 pfOWHXeJsmhpZkwtL2l2712PgXbbX0QHOQbTPuy1WdvW/fLphQ3iAP9NHjqgizD8t93Kdpq4dUF
 jqyJvjDTmtH+5oUuQJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX+QJHEV76h/hs
 JLspq1FcnKDo9/fpg6BkRHYQT9torl0+NSGwUj6N7vSWyXogHOQpTS+wt27o9gbamU5sJB1foU0
 JVEsAW6k5MSsmyoBQZ5yiVGQjPAjXg8=
X-Proofpoint-GUID: gjGKFtLj3cCT3wm76630SWKowRl_r_AU
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cbba6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1aYBqpFfU4iLzEvhaNMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: gjGKFtLj3cCT3wm76630SWKowRl_r_AU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070083
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

Allow BusClass implementation to have their own is_full() handler.
Use it in qbus_is_full().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/qdev.h | 5 +++++
 system/qdev-monitor.c  | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index e1476223411..c1c17bd6f2b 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -345,6 +345,11 @@ struct BusClass {
      */
     bool (*check_address)(BusState *bus, DeviceState *dev, Error **errp);
 
+    /*
+     * Return whether more devices can be plugged into @bus.
+     */
+    bool (*is_full)(const BusState *bus);
+
     BusRealize realize;
     BusUnrealize unrealize;
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 00fed791cce..496850bd8ed 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -454,6 +454,9 @@ static inline bool qbus_is_full(BusState *bus)
         return true;
     }
     bus_class = BUS_GET_CLASS(bus);
+    if (bus_class->is_full && bus_class->is_full(bus)) {
+        return true;
+    }
     return bus_class->max_dev && bus->num_children >= bus_class->max_dev;
 }
 
-- 
2.53.0


