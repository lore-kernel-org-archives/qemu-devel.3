Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDF2C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24vN-000852-Rz; Thu, 03 Sep 2026 06:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vM-0007wm-6Y
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vK-00073s-Fx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH2Oi3720073
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Deu+jmw96z1aDyam445k/RrNymHVFSDqbsg5lCU6QRI=; b=ZIvEJ6sGMN9fL5F5
 xwirsUVjF6p6r1sO4KxH8Kn+Tq99gSaW5fKnC7iF06/bYxXh+Q0JFq3O37Zjujcd
 dMFVsQlmcVknIxJf820cxa9DoO3k8AJ3bvmjzJJBPXD9g3jt+aUi6tefCrLIFJsR
 tHc9tmNJArRfI1KsP19bUNiYOivfwNEXJykc6EqcYgcQ07QTzPez8jCGV3AKQypp
 tvdVx0PCtUvGV+jhpXOVvfTdx6YG5EeTtMVlZyjv/TDZEZ2GEFmyW76OdaJwz2LS
 m49rdzuG/BM6xeue7uAT1h3CHduFhSxlxQw9BEmPLYcSiJIP8CxxyIQPmWJcj42/
 Ab4xjg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf0gjsqk9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:44:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939694871aaso254339485a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432240; x=1789037040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Deu+jmw96z1aDyam445k/RrNymHVFSDqbsg5lCU6QRI=;
 b=DOyfCLWB2UKK4ocZsOBcT8RD/8F7dODzHWqdfxjFhVUW7yf7ied0LmGqm0p8GHk6eZ
 wS3pNej/2HOesRw5DLKLSjHzqYDso6h6MrXsQHyjP3Ck1cXMaQCuuDdBxxE8mzdkWoCZ
 7/LRlRKZIlUY/DXs2hiF7Ye3z4Gfe/7cPPQkFjcgxi70jTnngoeijJq61hloP46eso6z
 LEsZi6zBMibWv1sv6KcS7gdbwlhuRCuCL4YfGDOuBrL8eURmR9lA4JtJIuRRq0WGIaEB
 7WYmnOOjSeZ39X2/CkPOkIOwcIdoW6Kkq7RK0dqU+KyBh87cydm5VySyCwTjFjX6B6GC
 8hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432240; x=1789037040;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Deu+jmw96z1aDyam445k/RrNymHVFSDqbsg5lCU6QRI=;
 b=YTqp9gUQjIoFuZw94UN7JtQo61XU7B/St2eXZAt8NCBAu5FGAC1ZbJWut9oJQueEE4
 pv2djzVCUNnVemEl0fZX1NrH1kD1/hGW2mhSkmR17x6+GUP8fGYomTsslEvnkFakEuYp
 QN6aqwZMS4IciDkYHe4QKIoAYaFGbSNRBs125eCuq4mDEifAf40NgAUQK1PhhkMzwaAd
 iuQvT6NVIUPbIV5pdGs9OIwr+iMkDTzHPjd5zi6y6Ts8HIVoVe4IZb1L3aUE+nkE4ifA
 DX+TfEoC/8Kv1r2RdBDj6aVACy7lX39ghQXsamxvNx8elcGOK9bFIRkF8LF946Ro4Jb7
 k9uA==
X-Gm-Message-State: AFuF++kiR5ytx1w1syjEOrchtzkNMEyeWP4ep7vwk9Y+JqjwyQ6O2tif
 n0HwQ2pZKmUBameaDB15MRaUsof2DFgL8y2WZ/7okycz4sl1CzyEgdl63ZrFFPm/bIohzeEJ6vG
 pvLEt7JoPA2HoRAd+2ekEh4m+e2pxGIl7HkINZAiUzyN51mQiI1gqto+A1pDcQo3TEw==
X-Gm-Gg: AYBFou3YEVrRAaYnPuNL75xpysM61O75x7hG6P0bbIK2JURIZz717lKEAeEpflfMZ8G
 uuQZMXdnERFBZrBiGNipApALyBQKsLXbzOq2KJu2Sqy5vdJc8/1xZqalFeJ5+oNUIQBjX4iXBpa
 x6D7mg1PEUwikSntadqcKCml98+kwfZ122IMmexe5aBz81lwwNAk7/x/Mbf/x18GsGGeQ+ayHd6
 hF/PR0/G8+2x7WjUGiTutGHo3vF5HT2fezePL1u01WV7uTkfBbUoM1DIOqezDphKyC8uyGL7lnY
 RRLxh8o0nIPhE85Yula+CFe2vnoiyQb/TFg6uO9eo+0MrPCIygzyhsJ8euSxjshhbjknhOk3HzN
 ktglAVtqG0Febk4CG9Mp1AoZQ0x33IxxKX3cT/+EN
X-Received: by 2002:a05:620a:27c1:b0:939:2bbb:b266 with SMTP id
 af79cd13be357-93960ccd7b1mr1352547185a.8.1788432240204; 
 Thu, 03 Sep 2026 03:44:00 -0700 (PDT)
X-Received: by 2002:a05:620a:27c1:b0:939:2bbb:b266 with SMTP id
 af79cd13be357-93960ccd7b1mr1352543585a.8.1788432239727; 
 Thu, 03 Sep 2026 03:43:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6024a8sm60328485e9.6.2026.09.03.03.43.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:43:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/51] target/arm: Return immediately on error in
 kvm_arch_init()
Date: Thu,  3 Sep 2026 12:39:19 +0200
Message-ID: <20260903103936.62355-36-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX7yqhQk0cVIZP
 LYqf+JonpnD1KLfsNi5iOWkhzA9N4QTewCAhFMqLdXJzElREDMYXU0tDmixN7YHk5elATBgIJfg
 Wf0ZUGEhOOea9s1YAbu5rU1Ay1fy01XokR6orNfvWa9i2iCnCtASGd+CJrgtRge4YQcURGJwAv9
 YUxRm0rmuFA7xGAngEiR0ucx8oh4doZHwxTpiQv46LXTWtTwAoc5wyIespFNJi06wpnupnhqVPa
 xS427t88/kgOWuAgEYn2UM86RWhu8y62l8te79aSVonMsRauJY/yPKCpitJK7PybdOrNNEljLKR
 33vNJJwlfveaOhI2jnaFcRankC0FT1Vtuo+evHt9KOKVxtYQ8WnAVDFeqzjQRScABmZaHJ1323Q
 F3pRLEmdux/mr0Ao5S371ND5hhwV/5kacguXCeRb1J6VdmcRjcBZzgpqasMItqwV+D0wPZ3alAK
 6k41e3GPVvA6q07X0PA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX6GHu5yyxiLfY
 XtDmunxbTDt2NetfUiQAvOP33tLWe5hfkSmKvk64jxVosmeQNmShlL8S93zqq3FDFqZ3RtBviPl
 nlvJ15GaRQl3cMUSWRKl3N8in1K9WR4=
X-Proofpoint-GUID: rFA4eg2sk0a0hzDMHUbxC_CiGqGNOFkR
X-Proofpoint-ORIG-GUID: rFA4eg2sk0a0hzDMHUbxC_CiGqGNOFkR
X-Authority-Analysis: v=2.4 cv=LZ4MLDfi c=1 sm=1 tr=0 ts=6a994f71 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=vqajonI0KEcA7s6tbs4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Returning an error to kvm_init() is fatal anyway, no need to continue
the initialization.

Leave the `ret` variable in the function scope because it will be reused
when adding RME support.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Message-ID: <20260825220101.3443954-3-mathieu.poirier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/kvm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d40a6a98591..ed99be7fd80 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -596,7 +596,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret = 0;
+    int ret;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -618,7 +618,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
                      "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
-        ret = -EINVAL;
+        return -EINVAL;
     }
 
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
@@ -640,13 +640,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             warn_report("Eager Page Split support not available");
         } else if (!(s->kvm_eager_split_size & sizes)) {
             error_report("Eager Page Split requested chunk size not valid");
-            ret = -EINVAL;
+            return -EINVAL;
         } else {
             ret = kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
                                     s->kvm_eager_split_size);
             if (ret < 0) {
                 error_report("Enabling of Eager Page Split failed: %s",
                              strerror(-ret));
+                return ret;
             }
         }
     }
@@ -659,7 +660,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return ret;
+    return 0;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.53.0


