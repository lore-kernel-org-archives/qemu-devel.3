Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0563C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24rx-00057H-Uv; Thu, 03 Sep 2026 06:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rr-00053B-CG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24ro-0006RR-KS
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHAHC440122
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5m+bdfXDGjMSrjZN0mTqDRdt7Sb7Otfs6JWBNkXvRP8=; b=ptz74bg5QNF+Gh6d
 shlt+vne5n8pjzqxeukNo4iNSg8L1wsaRIfCHUbwpMOyuk9XS1gNXuVjd+k+CtA6
 r42ZfrDSlYoUxiuPjJiskXusCetQxm2wIMu9me0rZNRlLUXJYACQRGdOQeYBUZxX
 wwLSj0VeMCaL8Xvtq58V4iLNZ9ixxWR5RsnAoz4EAiqdV3pZZgmw0/Bpsb/Y+GvP
 I4X8P2kE2FCVoXrdc3UBI3sVxLxkI/pHnciKRvcM5B39Dx9DWCO3NXy5ahhYww93
 aSYpKCwX/+QCHDZ5IhcH97QG8bMj8xpzATWAVVXU7hP6l9FwlnTe5v7CrFXDfeIC
 8PABWw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p705ur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:40:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so403475785a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432023; x=1789036823; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5m+bdfXDGjMSrjZN0mTqDRdt7Sb7Otfs6JWBNkXvRP8=;
 b=M9xhfYBsVUUy+4fHGSpL8gB7PNU3dPDLr+rTX2dZ9IztsWr/vxeuWQncRG5FsDhHxE
 jCuyslMNN9sqYe3cqkAbsa9L1vVESHFAj29Ncx+T+6FOx+gSKf14jFRMRYsQi0bHRSWe
 Vjs5oyQ6H9Q/I+TGW5Awybuv/x2Q/CpmYgxvhV3RYdqMlzFV3c3IaHqWy4vAaK6E9PLj
 11RSXxNkSm8LcDlcH+iR+PEAmEE+/4K+cC97ikePOQlUJMeFFp3fD8Tm61DAqXQ/jLod
 VXRe7EV0AWIhIdZLCjj34aT9/5i8VI74k5tubjzKsMEVKcd+r3gtGDzac6jCtrZg3xEo
 MuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432023; x=1789036823;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5m+bdfXDGjMSrjZN0mTqDRdt7Sb7Otfs6JWBNkXvRP8=;
 b=S52PurWuae67vXYbj2wyzJle45eYNND2CRsUI5RRfboUx+HO9FXN7idVBsrJ4uUS5Y
 zhv0V5f3ONSoV+Z0LyHgXxA/jx+EIK5Uf8sYW6o00s9jln4WZIMJKaTf5vyF2Sx1f/vi
 w1lS+5Fs3j3m7ArmnQs48mt+XHOOh9yroONGaEC03Js/DR9hfLIYh1CS3G5R6g08w/T3
 Sy12ROVlOeMGwtJoYJHqNHRUhjZ5Mtu+bhMeRuQp5nDErQIimWKFl7UtOUnUH/wa/V9O
 1FuLPwqpMPOLMKLn4Ml5u0YL8X1CMQwa1075Uno3khM8QPNjq2+yjDO+g5AHz1QCV+Sj
 YdEg==
X-Gm-Message-State: AFuF++kiY5IniDabqGGviKyAcmYKKZO60Kv97bFf3fnVtlmt2WEKOn8w
 SVFglp0in4N2Rz4XzS4A/kN4dLx0fVB5/oIGxyDI1M613on4jViGMvUj3YJBolJVE81jlOt/hw9
 ls6JSFTsdgEQumtpuVMQWwuJKB8mKCgZKyqEMzJuQsd8A1yMbC/m6gjvONkcK69tbyw==
X-Gm-Gg: AYBFou2E3CorDgHzrx6585KJJJRlbDOyjbMjVCYgyCKNfJRBJAWu93p6dhQh9S1OdHY
 gpmi4XIyXRgnoMv21WN2M5gXWmyp73N4sAJQraUxyTapaDJmljVk+IavrvfwQd6MYpBAdXz3uMg
 7x+yqdOba9F9xKeXKWOifZcWoV6VWM2crZqXnlnxbfhLBmktmnqvA/mzjzwoqSRKza02bIyO7X/
 RuFpH0bRfH1k6vq7v+HqGbVIDU+ofhq83Kh+lLWTKhtwKMcKmUvNSs7hHzy0SS2sSiAyHAIyYsR
 FDYeMoEs7PF7wnQCHNzozDbEwkrOLDckCVIZAkHQH3QAQ7o9X6ZwpB6yWAj5c7l0NCIR1npYAoO
 VEMEksi375a35mx7vbhUxiaEb4NgBuHhQFDGHr9nK
X-Received: by 2002:a05:620a:6592:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-93960f3887fmr931769985a.27.1788432023083; 
 Thu, 03 Sep 2026 03:40:23 -0700 (PDT)
X-Received: by 2002:a05:620a:6592:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-93960f3887fmr931767785a.27.1788432022638; 
 Thu, 03 Sep 2026 03:40:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72f02sm12645249f8f.3.2026.09.03.03.40.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:40:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/51] hw/sd: sdhci: Factor sdhci_advance_sdma_address() helper
 out
Date: Thu,  3 Sep 2026 12:38:50 +0200
Message-ID: <20260903103936.62355-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 04Yeef8tNXDByUF4l3viNmQ8-QkvuAtQ
X-Proofpoint-ORIG-GUID: 04Yeef8tNXDByUF4l3viNmQ8-QkvuAtQ
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a994e97 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=I8W03weja4XGKiVTSTMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX5/kHlYydrXNg
 e2yIXlRlZtyqfUaEEJlw42a8Vesywa0VOrenhsO7EMyvXnGFe2NQJdOF4g2kbtVDsOuDfHjaVeu
 K1soNLVIBjCAfOH7YKEW/X908lReNTQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX9I+LMcGaK7h/
 6GRKtRK6ydJ9jYWeQslbuN+dN6f24BzDY7z11iG5ucG1//KuNId2QoFTqu0QUSAlojJLyyX/Jdw
 iLQF4bzdOLzltULFjEJnkznOrVM6NpVmpzkMTMsccY6HDhEepZbXZu3C+747bFn1sjFRRWI7tdU
 vaqZRci8Cf2wQcvlJ8VHWKDzLwHL1EscYAVTB6kmCyxXiZMt5k41Tir1bjwza2uJ/nCq7gLQCxL
 zZehbNgYKubsNxes8F9OrcTXXwjPUsaveWwR7uZy2HB9c89iHvVpjyZD8NDJxUp/IZ1J3gQFYFP
 BIrLeV9sql2SZxL/DZDnErT+RbbzdGl+WD0/4B534/RLdukFqKBvb1cPqL2l3S9rmCVYQZlY9cZ
 g0RAxQtzYb1NuV/+i12KiXJ/ZGCvcEPA7dGQkWFg5boRt06QxGrTZuXb8MGcGAp8nIKoj9F+f9f
 jqzrtObj0o9p4QkVIew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: Bin Meng <bin.meng@processmission.com>

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260723151853.2143177-10-bin.meng@processmission.com>
[PMD: Split of bigger patch]
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 586e4680bee..ad370407c6e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -598,6 +598,11 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
  * Single DMA data transfer
  */
 
+static void sdhci_advance_sdma_address(SDHCIState *s, uint32_t bytes)
+{
+        s->sdmasysad += bytes;
+}
+
 /* Multi block SDMA transfer */
 static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 {
@@ -641,7 +646,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
             }
             dma_memory_write(s->dma_as, s->sdmasysad, &s->fifo_buffer[begin],
                              s->data_count - begin, MEMTXATTRS_UNSPECIFIED);
-            s->sdmasysad += s->data_count - begin;
+            sdhci_advance_sdma_address(s, s->data_count - begin);
             if (s->data_count == block_size) {
                 s->data_count = 0;
             }
@@ -662,7 +667,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
             }
             dma_memory_read(s->dma_as, s->sdmasysad, &s->fifo_buffer[begin],
                             s->data_count - begin, MEMTXATTRS_UNSPECIFIED);
-            s->sdmasysad += s->data_count - begin;
+            sdhci_advance_sdma_address(s, s->data_count - begin);
             if (s->data_count == block_size) {
                 sdbus_write_data(&s->sdbus, s->fifo_buffer, block_size);
                 s->data_count = 0;
-- 
2.53.0


