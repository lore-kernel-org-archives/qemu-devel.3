Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E7FC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc9w-0003ok-6T; Sun, 16 Aug 2026 10:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9M-0003bD-EC
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9K-0000n1-Nf
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:47 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl3b9481605
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WsyTyGLBE911i8ZCFz6dOwdHRKi55jh7LQC39nPa/5k=; b=D1UM/pOIi0UrZd13
 Ko2ipJQjh9AsNaxngJPphrsT+bzE2jo/cRo9iEmU4w7oq93PGJhsSwbz8TwHoBjO
 BrkrZ8A538f5RXlh2GkWTBwoUpuXM8EHUew9b4Zc/Mz/Uv26Fr+VGqKQgw0NHcFk
 b8g6i7CffSWAhFm0wk9IjfdDATigTYP+vH0EL6sNtgwKy0SCu2TfqjB+wVVPsrHM
 o7N28mUiSDLJ3yKSnxTrm3i3YPu0cSnaLERifL8SJ09pkG2Jr7JFZtVO5SLonLaR
 VZWnQhUlX4af0ga7eqK26QD3iNqSBDMo8xs9udRLAn5qghEOuWRRaSucKqNXiohP
 laB23Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfbjw7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so270150985a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891664; x=1787496464; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WsyTyGLBE911i8ZCFz6dOwdHRKi55jh7LQC39nPa/5k=;
 b=ITLVJglXCYJr6QWILxh7hUuODyIR6MiU5YJ5mJkzhBp09zEPFA37KEjbx+siaqTHkQ
 LFgM/fTwIpgsNBLHUy9o2zgWEAxsmxAOtx1XPN20wxi1+/P5YGa2dwKHnXFdBjVhvq4R
 ise+VJp01bTdw8MsHDcL2T7WlXQXABS7yw18Jq1mylHnaVXc7BffGQoD8cw2JYMHB92l
 fSYqRUmEuXVdUetlyUnEmBl4lIxvGFTGQQaBHJ7aLzQhFHqcfGNm3pbH5XfDNeKPQbh7
 88dNem6qdVfxqRTkLsZWi3GNW1ObqgRqlubzTo3qX0SRPcdvr7llAh8T7XsMKy8sLvro
 WYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891664; x=1787496464;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WsyTyGLBE911i8ZCFz6dOwdHRKi55jh7LQC39nPa/5k=;
 b=HH+1ewp9vh1NGvVBemEvpUn1tnzJDTG8D3aCwc3w9XMQuNpU6QN3y/d2tFshRgzBIs
 FrvK0gy4FTV4PTWBzEotw1rcn0JYmtsmggUlBaEO+asVFPJYblhbU4z22DdEvMGr2fzm
 ROClycE1EwNUVjRHh9XXg7tA2I1wwHFvONCbyoxTcP73X4tCZval4LbPQbHHTeVaIuA2
 yh+YZeX9psVrJw+9Z+J5+8yeNv9zDHpyKwyeZt22qrmSVBKF2DB4iPFvZN8qPUp107Zw
 aeOLfEF8JMvhBESa9ITjz2w/wrBDC2iiSJ4m0j7Dx8iLc/boXwW8sVshA5oF/8HJw9u2
 Qt5w==
X-Gm-Message-State: AOJu0Yz49Tu9dJQqimE9ZqxApArXvURFi/RWohOHU5tl8oRHer2Itkp9
 dD+RTfRQXLxvRC1nOQs+oqYOl5CF8NLNsk9bRD5YhVDVs4xwH610Hbq2wgh44boDb4ZMmOIoIc8
 WSWQsdOU9pL+z1vnhNpSdo7ycGNJnpzRw02ZvPNzuoT4VmunMFEE+47QOCx/6mNwTjA==
X-Gm-Gg: AR+sD1072xLCt2O29GA8E+uT6vFzQYaCq1RlDAjC0BqEv8cW+/+tIUIWfuX94UPjJAq
 uJbpr2/dXb0gcZT5N1EeyT0SvmmPPF20Lr3WQiCX1DBuTSvuO+iM5z3XEBNcZLhEBdsXktcY/go
 xytv1D+6hFwsmNvjHsEpH2Ss8HZ3ekuBhm45+QWpJ8/YWjsKoF/tHQw8IaXoyZqZKuXjJmXHoL6
 ToUMnqT5fy1jT7F/tRrAaNeiEpMexQWsqqmDCrZslU2fT1fDlaKj4ksmEe7Y6V5RmmhkP1huU3C
 TbYe0Dl8PnU/CDTDcG1JQx+cbf8JQuqa793J9hSIge+WF58CLnHIR8Pp77Q+ZdLJMylQlt3+C4F
 049XS3y2hXEc1G3mFDAhTCggt6SKsZVWwbSqEfYlqHw==
X-Received: by 2002:a05:622a:1a81:b0:51c:f3:34df with SMTP id
 d75a77b69052e-52d8551ef50mr191582851cf.30.1786891664258; 
 Sun, 16 Aug 2026 07:47:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1a81:b0:51c:f3:34df with SMTP id
 d75a77b69052e-52d8551ef50mr191582581cf.30.1786891663776; 
 Sun, 16 Aug 2026 07:47:43 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f219e12sm22741435f8f.10.2026.08.16.07.47.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:47:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/56] hw/virtio/virtio-qmp: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:11 +0200
Message-ID: <20260816144556.69009-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OZ6oyBTY c=1 sm=1 tr=0 ts=6a81cd91 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=uRxLgUfnyXHAhkBXUOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: pTo0UbK_e1YQ6swyfML6BEn7jJLFU8In
X-Proofpoint-ORIG-GUID: pTo0UbK_e1YQ6swyfML6BEn7jJLFU8In
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXz4QPilqCyaQj
 fBQnRFIg5Gg5Pn4NmXyMQK3UOvOHCC8/DUsCYIHbXC/8RPsIFkmNqefHN0wOVkID2CQIs6DFdlS
 FU4l9ICwm6aP1mtzBjM4LU+uayavWk8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXzYuCiEbD7qf2
 W7nZrqpZnftB0+Tq9I8d2NPskABXoyXycEq3m+k9F53sdM1C97xGmwH99RsZqknFEV9CyOsOc3I
 bWgNQ4sSoaAaUqfpXbpvTWGoQy68r5lK7opJACX7gQkyz0MLDDAokH8rKrsPQV/G7O6bFvga/dL
 5NnhDZhYSypazI9ugIEQqcH3279tOLJl6NsnBxmu/BlGvrcPJQtcRjWMalk1sWAGvDqNTulmzGu
 uYP0MRluJ7z41MzuMGZh83xzgNSFFJVTfsUQXGO+H0YzcC3rLbjIlBWtYlwkatGqslffdltOFDQ
 J7ver8nqMO2azlc1jv2091cu/XYFP+1dQVQEX+OukUoTLz2InSC1iCnOBkxPxNjiX/J4vzMlfH1
 CmrUvqzpKSs5UiM7Nf+gHPTE9ekUFU+yeMgpYHzdp0o2WkzR+PWC1fdzVwI7Mw0px21LRk+E4il
 MaV2N0zk2TwS8jcslbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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
Message-ID: <20260721-qdev-v3-11-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/virtio/virtio-qmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 57cc03828c2..5aaeebdd96a 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -659,7 +659,7 @@ static int query_dev_child(Object *child, void *opaque)
 {
     VirtioInfoList **vdevs = opaque;
     Object *dev = object_dynamic_cast(child, TYPE_VIRTIO_DEVICE);
-    if (dev != NULL && DEVICE(dev)->realized) {
+    if (dev != NULL && qdev_is_realized(DEVICE(dev))) {
         VirtIODevice *vdev = VIRTIO_DEVICE(dev);
         VirtioInfo *info = g_new(VirtioInfo, 1);
 
@@ -688,7 +688,7 @@ VirtIODevice *qmp_find_virtio_device(const char *path)
     /* Verify the canonical path is a realized virtio device */
     Object *dev = object_dynamic_cast(object_resolve_path(path, NULL),
                                       TYPE_VIRTIO_DEVICE);
-    if (!dev || !DEVICE(dev)->realized) {
+    if (!dev || !qdev_is_realized(DEVICE(dev))) {
         return NULL;
     }
     return VIRTIO_DEVICE(dev);
-- 
2.53.0


