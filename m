Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6B1C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24rp-0004xm-Ai; Thu, 03 Sep 2026 06:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rj-0004uS-QT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24ri-0006QL-9p
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:19 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHIFV3782479
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yqIoxY4uvE/iA/VLE9haMr+T3JBp59A54zo4MolHNbQ=; b=n3XouhB1GLgV9odK
 JAKgcmM03iNr4JmEY+tsHFtMMkXzVq2hM4Rh/uf2ru1dBMtw3L4wtEOZTDgOQh2O
 UOc9bL13xRhGgeAAXAaLm8Coot8YluUiXEH+coms/7CSn5DeApUk2ozEVMXD4AvV
 BEnxn3Gi+HhW2/D04Zc5F3G26GsgIinuZ5SSWkePGazBFu84OEa1T0sYqXT3mivU
 GO5+8V8HJdbS/boan0u6ylTKnT8fVXDxGpuiUr5dLTohTqz13KiVyM47S64mLzDr
 W57Edeqc1SuH1goa6hs17WetgNyoKzYJ6uT35x+htw8kNHXwAtI6sYurCQznynQR
 oCTRSA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdrfqe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:40:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9396e0515dcso58581385a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432016; x=1789036816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yqIoxY4uvE/iA/VLE9haMr+T3JBp59A54zo4MolHNbQ=;
 b=OwLTAj6IMEkV+xjcTj/p6otL9nSK+AZXH7sExAI+QdJI4xB+kKDOUSKvzTP8gHcNfx
 DVHOpKsLO6SieHwXoYNk4XmvkOK7k9mXei+unAiwyPwZo/pskSGd/g94U0aKwBgWCIhN
 nWeG0N0JL5lT/ovM0SrmimeysmiXJfyUNMU8Sv12BgX3c/TIWCPkENqN/PcHLg/bKGQZ
 VkEMKYxj65X/n5KoWJrOfByiWWul1xapb178qJBgAB9rjsN7kZVDpx4VcX5p3h3NSehg
 LFFjWuLXJxuMvNFl8NC4oU7QOT4kHfq4DQE1MuOKIUHJ6OACl7SLiqwrzZMWxAGadqNn
 l53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432016; x=1789036816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yqIoxY4uvE/iA/VLE9haMr+T3JBp59A54zo4MolHNbQ=;
 b=AqnL83+mi9FjX5RKZcSQRmPsTxcBd9+LBRr0fGnjDMCOeHoVahgJgQur3mICroCHDR
 DWSQC1SkrRcxNw0Bmfn0Gd1l0dnQHloDEpq4r6PfBpmLStQTF0gSiU5G0kMrGJWPKk5X
 v0BFJ4M0DLciTtPjOmuYzYKPcaS8gc0nre0Pr0EXxZxIFRm8/0hqAs7BlSoM6PrC2ZME
 g/yuEvlPL3xxoIk6svPPz2P3344UMT9r2sf4SklQa/pICm0GGy/9j0mskLBwSkFzKzYM
 KNDPo+ZKuLsfitvaavph4MdN+T3bN8ZTkzUp33wiI4v09SDU7BB4mvvzQIld1ruTFdzA
 cAJw==
X-Gm-Message-State: AFuF++n+XVB0wMMqfr5ydLiNejpH2uvKEBtB9OU9Tx0cmRpMdb3GyaQc
 yNkE1WM5nR6NJGvHKzxrfp/2c72sJa5EgLjQ7EGtOmzWqWX/EhooVdE4PYJjXhuFRDXx7eKqDs2
 xooXsxY14aja46a2pP9DBlw9kRZgIezj80zGezDHwDAmo05T8Y43sCcQP9o+iQxkZ6w==
X-Gm-Gg: AYBFou02TljgIehmP0xu+1wy8MfE4qPc3muBpOYgQW0USDorQHu1WSKfm13H1hmI5VM
 52/lLtKX/ejXuhmERLYJxLKfrO2rYL1Tf0BjjCZD15pvRt0mxQK/srpY0jJ4i8p7IqeQxc8owCh
 0OZNeElzllijPd/0YFIqyEQiFYN7anjQdpcC0SPJxi4lGQgReS+++t8KzUP+aJ+HMqXmu6RGMeA
 NwYBU7EQOWvVhpnJIPIA92s2H+zW+OJpBKI154Qxdgx9StAy5Igy0oJEd+aqt5+eZK6uPGakQD5
 jiuJaI17V0mHPBlG+JcSJvZsDBDiwhGVYtqZJWAX9+AGPtU9mgFSpeGHobH8Sc/bnACVkQ5JiGv
 5LiEd/MHUS63jpzYrVovDnLwdrLlOvHVMKyjdDv9s
X-Received: by 2002:a05:620a:934f:b0:939:820:2e71 with SMTP id
 af79cd13be357-93960f871c8mr1032652085a.33.1788432015586; 
 Thu, 03 Sep 2026 03:40:15 -0700 (PDT)
X-Received: by 2002:a05:620a:934f:b0:939:820:2e71 with SMTP id
 af79cd13be357-93960f871c8mr1032647285a.33.1788432015011; 
 Thu, 03 Sep 2026 03:40:15 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d9db2sm63117615e9.8.2026.09.03.03.40.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:40:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/51] hw/sd: sdhci: Accept version 4 enable without UHS-I
Date: Thu,  3 Sep 2026 12:38:49 +0200
Message-ID: <20260903103936.62355-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXz/PhzFAiciij
 0qi9ZHP4EpixhR+n06wWoROg/7RxlYlSFrJyAUh8YO9dcB7xKcT4gjYSLSGsSA1qUzeGU/LJ97h
 TJfOqNxAH1p85gE+I6HupyG+Vj2HySw=
X-Proofpoint-ORIG-GUID: x6cJfWYhZO6KzU6wNCcqzD8JAfktiiFg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXzLDIgtfis/E3
 8xmDlxW353i+nL7G4RAqXChzpw0pK7Sl0hCZQfg99IIccU0gko6JjsPx7CjeYV2Pgk5RGkgJR/U
 +Wtpx3OIt74Qnf7KLsea7wP8GgnXMSeGg8U0u8BOJXlQEeHUxNLkjR5OZjQuCXUnXhNdfmWLmZE
 e8Bh8bpxtu/egv+k2Cwf6UyENE9+3MjNRDdaBm5/yL9r26NO3BCIK6nIqFRRG6cttS8PVqCfBT4
 TDKsC1zwiGzaumouyKb1a308Xv5ZVVwmVxUF1xJ6uKuwXRLRi8ey5c4GydKsANnLu2RwHAXJe6X
 LbuR9NUQU7FTmu6O4GltX/Qp7K/ZcGgdQFWJ+tK99CxdVeaYX+wXxPj1PN3ViFz72GwZOnBBoUH
 uuCdhbdGPIW2gqbQLmpM3m6ACK3PQU1KmnbJ9xRPQFso8Fin0wQjkaR3QW4PNVxH8uCNhCLKcQM
 LDokt0L08bo9KmzmCZg==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a994e90 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=FRSEYCzRAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=cecaVjzdulOwRCAQsNoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: x6cJfWYhZO6KzU6wNCcqzD8JAfktiiFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
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

Host Control 2 writes have been conditional on modeled UHS-I support
since commit 0034ebe6ee31. Host Version 4 Enable does not control UHS
signaling, so controllers without modeled UHS-I cannot enter version
4 mode.

Retain Host Version 4 Enable independently of UHS-I while continuing
to reject UHS-specific fields and keeping voltage changes UHS-gated.

Cc: qemu-stable@nongnu.org
Fixes: 0034ebe6ee31 ("sdhci: implement UHS-I voltage switch")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260723151853.2143177-9-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 101fbcf2ff9..586e4680bee 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1358,11 +1358,24 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         }
         sdhci_update_irq(s);
         break;
-    case SDHC_ACMD12ERRSTS:
-        MASKED_WRITE(s->acmd12errsts, mask, value & UINT16_MAX);
-        if (s->uhs_mode >= UHS_I) {
-            MASKED_WRITE(s->hostctl2, mask >> 16, value >> 16);
+    case SDHC_ACMD12ERRSTS: {
+        uint16_t hostctl2_mask = mask >> 16;
+        uint16_t hostctl2_value = value >> 16;
 
+        MASKED_WRITE(s->acmd12errsts, mask, value & UINT16_MAX);
+        if (s->uhs_mode < UHS_I) {
+            /*
+             * VERSION4 is writable even without UHS-I. Preserve all other
+             * Host Control 2 bits when UHS-I is not supported.
+             */
+            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK;
+
+            hostctl2_mask |= ~independent;
+            hostctl2_value &= independent;
+        }
+        MASKED_WRITE(s->hostctl2, hostctl2_mask, hostctl2_value);
+
+        if (s->uhs_mode >= UHS_I) {
             if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, V18_ENA)) {
                 sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_1_8V);
             } else {
@@ -1370,6 +1383,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
             }
         }
         break;
+    }
 
     case SDHC_CAPAB:
     case SDHC_CAPAB + 4:
-- 
2.53.0


