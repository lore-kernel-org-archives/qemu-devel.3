Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F038C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjNM-0007wD-FT; Sun, 27 Sep 2026 03:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjNE-0007d9-NX
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjND-0006YI-2Q
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:36 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQFN1449967
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QYu8bvEGUdQWeDhON91oegvqLJFYqYY7Upi3+WdIY80=; b=YAUNRa/xgICGRbey
 IAbsdqzXL+qd3uuxNnZPMCeIAhhmKyXscrHzYfggsSfr5g7JnAutvduQqQyNHhnq
 3TEo36cidBpAVp/3t5tzRryrdgIPmF3WE4Uum8iP3Kw26tGa2MwvoIwIiTARzXF+
 7/cvQms3HN5elRzBEmTTmlymX2EpEEs/fgwURfiIuKMBkDw+AcjoIidBPn/rOGu8
 TWgv5mR9hwwDwDCkvPIc4pXy+bwknPy2zxGI2cQkMcL7oCETqefHMs9/BI12V5Qx
 318vKKCB2uPijSnrOpKUbbeXHxH54rLMDA3e7EOhjKEopshVZU0tbyH3zENtzuAd
 159rcg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfttce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c444b438aso443542085a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494352; x=1791099152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QYu8bvEGUdQWeDhON91oegvqLJFYqYY7Upi3+WdIY80=;
 b=Q8tN/jl86v75N7w363/g6usIXm1fUZKe7bTfK72bTdy9X6vkzcRZRe7OICrLOHMXtu
 4DD6xVApT2iL3ZKc/gkTqk0TfC2vRVvPSp4VPDcbsf5kbtF+PcqAxJzfzPFierqdPmB8
 7haFozvtJDgZMXEW0WWqfvrOgERznib0mUq33z32vkSmxLm8X2Kd0L+6+cXmEdULV85a
 Kh34t8MHwgMj9fSvdnN2FsTO7rtoDbUeBdepB2VvdFBygwYk6KGG0mhroWKYjWwWZVxh
 PjGVeXplNZCSxcr0Uplg+TkiYkhaLGBiPxsWwyu6LWY3JmhW0Vq+sUEe7HP3S/YzQZUc
 ZIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494352; x=1791099152;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QYu8bvEGUdQWeDhON91oegvqLJFYqYY7Upi3+WdIY80=;
 b=wV4ixB1S+7fXKaZppsUyngLpDOrj/yze+KUGDD+PmccwbvDc3/YN1qWRgRDKftlM9f
 hDtJiXWNh8X5tu73TGk2WnMoGz2jfQivkLjYTnzELiAOwVFOShGR2Sxh2TdR2GYHfSNK
 wwhK+KXDoKQT/uA/AcHHsM7TTbyUaRVsVRlNlYJXWE+MBXeuOqQy+dOFDPg4dATSPLCc
 mhpBpaYUgayYYO1MYyXLV4iZs6M/URoBp9aEUpF0BPpfbnwae3YZ2Z/regv182iXeivZ
 1AMwGwytN9BA0ztTPf0uV9+DKDNFQy1UQlmnhTSIfJmXxQdFA5bOwEj8eXUYFjaQP+Z8
 2NPQ==
X-Gm-Message-State: AFuF++mO88YnbJtdbwFtQc7/cswJqePHhWBBJ+H7uel6FFth1NkbJhI5
 PnyuDq9xfdaE2R962eKsyauoECmsxTzEoFyt3q0u+Jov1WYiREp2pfep9MKPMlQmtXCZyEBeCbS
 sFCmvlcDu3WtsE9YytiM4K0UAn8HIYSLScfxIjwzUexfHGs/O/8YS0Ao2J5mpArj7vg==
X-Gm-Gg: AYBFou2FNIfTuLO/x9H4pIxCS8U2Dl9ZYkKPkAeIrFwJ7LZwqkPjOAxTfEC7TOfWxm0
 DZa/KDtM5dPE7hl6P6wsG67NuOOeWZWpqnBjKbYeJ1Doi1YHPqqwnVRoEVPsrT6EzBeFv0VgPMv
 tOxIv7i/8Cv186yvszGoN2W5bOmaQEARMhn7gQgMFRRJb4YN80+s3h31DyHkpQ4HAT7q0hhWtBQ
 pwRjrAaz6Ra5x42KIf9qWrJt/7vZaPu9HYq2tNYQOHZUZXSaycPQ01h9zxBlZrEGL+odgoJD4Mr
 no4rbbHij3FzbnBd2+cWHuSBZ+/WhvhWzDnrKPnLshCs7AxWLRWaFPSGhwTe+aIY0a63bvnZz3O
 mXXdVaGMSImdtDgSYMUwKnrogerHDc1p38qh+cWWQ
X-Received: by 2002:a05:620a:46a5:b0:93c:7582:14e4 with SMTP id
 af79cd13be357-93c75821ademr41794685a.40.1790494352527; 
 Sun, 27 Sep 2026 00:32:32 -0700 (PDT)
X-Received: by 2002:a05:620a:46a5:b0:93c:7582:14e4 with SMTP id
 af79cd13be357-93c75821ademr41791385a.40.1790494352039; 
 Sun, 27 Sep 2026 00:32:32 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f1375sm33391595e9.8.2026.09.27.00.32.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:32:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] hw/ide/macio: use pmac_ide_transfer_cb() for disk DMA read
 callback
Date: Sun, 27 Sep 2026 09:31:38 +0200
Message-ID: <20260927073140.41422-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfXwLsDvrS3IcBP
 sI7ndkbRFru4BXTIgkiWKXSoy6oxrw0YkYepseK/vkPkj+GxlZN3pZ4qsqcCH5FI9sfJIuRDiqa
 +fkB7hqhaGo7r3EmaBxvwd9p09UpBI4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX/1jY8fH7oPN+
 92+tV32MV+IOO/CpMP+BmXTaKm9wnb31cVb/bp3QKdA4X6LmKCgvMsCEaYDxhh7hDcAYM9+LSGH
 MibSByHMh0aZnwjK+cqlNnS/qP4I0rwUpKnAXg/9Y+DT5pRS/oiDkiTA3pNf20yZ05CPTsI9GvU
 zLqgEAZIsiKpEJpouxmMaFkIYxlHYAUvvBKOnZzIDJyA5z8SRO4f9VJY+pYb1JJO6YQAxr1rY4J
 GCo/SG6F9G09CHAMG6XTEeUjFUusYBcxC57EGeCXeTOmCmMsEckMUvCNxoQKrRTSN8dTbQBR16L
 9i6WdTiTE+xuXcohC6BU8Ui5PCEm4DcsiEFvy4nta67jSJ+ik+kH/Anf6kbLOiM133DQ3XGWQzV
 wj5e2Xyu6/YEjQQN8P11T/1g5fj8HyYMYBq1QPFDPAOEcwmxclPoV+hUGw0DxbgxVc3H8xKzY7k
 CpBMHgeXDgLNqweT5Mw==
X-Proofpoint-GUID: NUPIiiJl_4OWayhR9ZSdkCK2mp_Gpp57
X-Proofpoint-ORIG-GUID: NUPIiiJl_4OWayhR9ZSdkCK2mp_Gpp57
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab8c691 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pcZqCyVeAAAA:8 a=EUspDBNiAAAA:8 a=nzRHPgdkaXdYiH_QP9EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Since its original implementation the disk DMA callback pmac_ide_transfer_cb()
accidentally made use of the CDROM DMA read callback pmac_ide_atapi_transfer_cb()
for disk DMA reads instead of itself.

Fixes: be1e343995e ("macio: switch over to new byte-aligned DMA helpers")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260926074425.468348-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ide/macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 40fb4f3b4f3..a95e68083f4 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -180,7 +180,7 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
     switch (s->dma_cmd) {
     case IDE_DMA_READ:
         s->bus->dma->aiocb = dma_blk_read(s->blk, &s->sg, offset, 0x1,
-                                          pmac_ide_atapi_transfer_cb, io);
+                                          pmac_ide_transfer_cb, io);
         break;
     case IDE_DMA_WRITE:
         s->bus->dma->aiocb = dma_blk_write(s->blk, &s->sg, offset, 0x1,
-- 
2.53.0


