Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A53C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc92-0002zH-63; Sun, 16 Aug 2026 10:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc90-0002yY-48
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8y-0000jn-F5
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDki2W4142901
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xLTsNF4Soh7q8ru9VGONHPuB7j85hRYLW7glkBkqV5Q=; b=I9xrfZxnz7O1Yz6P
 NYc+XP+2IWOCUYB4cKFz/f8dpA3yy18eY/CUGhbG+OjosN7Jhh3pKmVpy7KrmXA4
 vX5HS2Y/xcZcQDmH/fDeKRISOrUUPYKyWc2PqGKNqmDgL2xw78DKaQbrG72pWnLD
 3hdKE9gnLauvIehw4q854p/JUlIgFN8wd9Y1xLSBDE0CREL5A688WB+KAExn63zk
 Xc0SUCmVAqhuTUYPc7WzviMXqZbrTAob8n7spsqzySReFwONST1ZO5GHjB/+1UFN
 QLVr/YCIZrPyj2l1+7V+cizqdmGjljXmuOuaBgrrnaZ7GLMLz/iF8vR3ZZFl2TSJ
 GfW6RA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwkkb0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so25645181cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891642; x=1787496442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xLTsNF4Soh7q8ru9VGONHPuB7j85hRYLW7glkBkqV5Q=;
 b=E16NIW0m9ZPnWPZ9rsdUh+YlywpD9izugtxtxHNXX4ED638i4IgJuvAknFm4m1Hfi+
 CdPkisdH7OOwSS+yLe6FJdjFnlL+zfvNzX+YEE7NMgQGn6oQngypN/0mG4Hye/lP6kMC
 X7tR2BWpVcB9BPf7n1gI7gD9P1ihLxpi7+0+vaXmae9/85lJFNY/6Xm2007KNY6iZWru
 5JL68mEd5SP1OrrXEN8IVnvyQyOoEyvWg4kI0G5NZenRFxlu7I+lazZpIitBMtjvaczz
 qAtfuCf05WZ2eZDRhJ0WHRmMNPawfOg8XIKV6xTiTY7/r5Eyt8fFSpFnbaILttwAG0mz
 6m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891642; x=1787496442;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xLTsNF4Soh7q8ru9VGONHPuB7j85hRYLW7glkBkqV5Q=;
 b=HjQNkq2GEgtXi4usuaQCwWfO0FEkVNL5X7aWp5SqA2E8jez89GW2oN/T5NGcyfpcGJ
 4tC928Ex9C0Qk+cSXcpzCqA83nU/NZlwE3WqFr+5Lq4WjJ9e7uVHrPbnOXDJ1SdBIi5N
 f3OBZRW7gp5ZOz+vjP23nX+++Nnn+f3VGDI/R3RhL45hxJCO9zRp5uSKbmbwnwaaUDJn
 3k0Y3xrMjzSHb7p0hGX4YSQ35kIixZIV8DWdbsVXcr4goFipo+EtS3CuT3UJ9MXEDag8
 uVGVOOKcm9NNT2jw/Tzdw4qiInp3J4qea86p6jdZiZBj1EmKaWZH0nnQA/CSr6PsZIca
 mjzg==
X-Gm-Message-State: AOJu0Yy4yFNaggN3mJZpg4gSOcZ/d9jnzbSo54ZBMYbQuLI6cMG2XxdK
 V4R2wpq6UyJnzg/gy5gTSS2P6t97gXvhYfgnoiX1NQlpcVvsdycxZodzByNRp2OYj3B2ZAHXfyr
 i2HSKDj9q9AotPQYdnHeN4TilSxg5gSLYTcxJLlXrYb4EFSYmQXRI4KImVX2OpSrL6w==
X-Gm-Gg: AR+sD12dOwQgMH3IklrJH8CFweBu7m+cBarh6P1MwkDjjJAWGstG5eT2eLZQgGQR5ct
 k55brQ7JtO+hetQwT27Jn92551aYjJ+bfC2AkE2joW0dhTdlRVHLw9R5jnFMkv6aSrr5YnkqGpp
 D0uvJ2pOb3RVk5+8rN24IQvxhjEYByB/gXUGgc5PGJdQ1RX/Ee8e9es8xuVG2PlaLDQwyigpnj9
 p9SpqPFNFmTVKfaDzPn+rcBhjUpxWOZ6ozVCMb1jDTxG0tYW9CJNDdMBECvTbtTSIaWHNZdzGGp
 sMJZixwmjaVlpBih6QSAusFRlQnivKt6Ir+ZKHEp+PjQfL0C9oZGCL4yG0DD0x3kvQsoz1se1Bb
 iVXhjOxB2mf0CxcCLbLAQruW2rtPZ37KQK7jZo6Ubdw==
X-Received: by 2002:a05:622a:2308:b0:528:3882:3869 with SMTP id
 d75a77b69052e-52d85341082mr209639491cf.13.1786891641796; 
 Sun, 16 Aug 2026 07:47:21 -0700 (PDT)
X-Received: by 2002:a05:622a:2308:b0:528:3882:3869 with SMTP id
 d75a77b69052e-52d85341082mr209639131cf.13.1786891641377; 
 Sun, 16 Aug 2026 07:47:21 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c0a75sm24564583f8f.25.2026.08.16.07.47.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:47:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/56] hw/vfio: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:09 +0200
Message-ID: <20260816144556.69009-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jcpDGOAYd2TtYB8DGPmVp1XimWvClCt_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX0Cbgr2jWAkRh
 ub4Jl4n7dsPo1xrOUNdgovCcZFbPrFZNlELiXfwJluMB8uT5lGVtisoIVUxYKe5B+n0WaGfTQWP
 /W4psTSGfvYVrwfOBSbbSF7RqRdwenklw6Fx7B8U0oZVmoWIX2wPBzwdw4jjyoG3rvgoGKvUxQS
 hnMsTNFTNqHkH+l4SO6eIPYCejglBdiI4N6KRrNgLlsVna+nlvTR15NHnnp5roN8S2Sloi5mG6h
 ua/ZGyI8uf1OAzvIBhlESmTJ3nndiNJNw8jYdLsyviKiR1b1dmoGP+pcaFmv4ziZrPmKdx8te3U
 JHlqn5DUwzwN8X5iQDjwFJmEFsudnODzOJ2HtF6ti/bn+XoLoz6/BMJ1Qp9YPEzF6GK+q7SCbAm
 ZbgKa7ADkHdMEHgvR+jIoqrK64CUdrl0Ey6AYJ8DL0sb2uekfWmJwKjKr1+slr9tkSRyTM9C3Dx
 PGe4jQyibJmTHeLIaLA==
X-Proofpoint-GUID: jcpDGOAYd2TtYB8DGPmVp1XimWvClCt_
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a81cd7a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=bExcGYys6cyJo6IKf0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXzmc/sld7HpPG
 Pz9MLXOm9kA8liecTMVrBQ4sWCjZ4os3u1J6ts9tOINC1xnEymTZG+zKwCadbHTK0elPzfNhcA1
 1adcCw+EX4NsFcUif5mNeWG8OWCkaUM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160118
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-9-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/vfio/container-legacy.c | 4 ++--
 hw/vfio/device.c           | 4 ++--
 hw/vfio/iommufd.c          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index d301b27aa65..7ac7b372145 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -1075,7 +1075,7 @@ static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
 
         /* Prep dependent devices for reset and clear our marker. */
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-            if (!vbasedev_iter->dev->realized ||
+            if (!qdev_is_realized(vbasedev_iter->dev) ||
                 !vfio_pci_from_vfio_device(vbasedev_iter)) {
                 continue;
             }
@@ -1160,7 +1160,7 @@ out:
         }
 
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-            if (!vbasedev_iter->dev->realized ||
+            if (!qdev_is_realized(vbasedev_iter->dev) ||
                 !vfio_pci_from_vfio_device(vbasedev_iter)) {
                 continue;
             }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 1a7f8088aad..4f119596336 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -59,13 +59,13 @@ void vfio_device_reset_handler(void *opaque)
 
     trace_vfio_device_reset_handler();
     QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->dev->realized) {
+        if (qdev_is_realized(vbasedev->dev)) {
             vbasedev->ops->vfio_compute_needs_reset(vbasedev);
         }
     }
 
     QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->dev->realized && vbasedev->needs_reset) {
+        if (qdev_is_realized(vbasedev->dev) && vbasedev->needs_reset) {
             vbasedev->ops->vfio_hot_reset_multi(vbasedev);
         }
     }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6ff668d2597..242644aa001 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -829,7 +829,7 @@ iommufd_cdev_dep_get_realized_vpdev(struct vfio_pci_dependent_device *dep_dev,
 
     vbasedev_tmp = iommufd_cdev_pci_find_by_devid(dep_dev->devid);
     if (!vfio_pci_from_vfio_device(vbasedev_tmp) ||
-        !vbasedev_tmp->dev->realized) {
+        !qdev_is_realized(vbasedev_tmp->dev)) {
         return NULL;
     }
 
-- 
2.53.0


