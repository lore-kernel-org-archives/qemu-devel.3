Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91BFC5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFlR-00089s-Kr; Sat, 15 Aug 2026 10:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFlB-00084e-Ih
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:53:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFl8-0007GL-JJ
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:53:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDNrTx4015787
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FXFyWqlGq4MrvOJ8b4iWKJ83ABa5nD2HC91OBOFHl0Q=; b=dSsyz25oANafUYsO
 Hl1lyCI68QKiPEIUn/bh+sJEuWZBw5o4faoqjyYhSvurLXFWCIMVBiJ863xx7Dxv
 Osv60CK9HaPksDLHVcH9v8YeRMu5siNoSseoQ0INXBunW4iliOpq86xzUvnxkveI
 EiGM5juwOUwbT6+BP6jZSwtLKFc8d+vIydaWDX/nFAG1UM6AmOkuHT9VEyzSeY+Q
 4+raL+4wYyRaxqGRH+/mA0AD8MTd92hjfbyqcJuVXVQexK7ekuqsZ+uxax8J/2q3
 3sZ15SPA4gBwSFEoxVOnLszZf6pWwOGpXaMFxP0PeCM0uolIBxUpo8E1P36du7ou
 8buszQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gh4g8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:53:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5283df62d68so23594991cf.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786805595; x=1787410395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FXFyWqlGq4MrvOJ8b4iWKJ83ABa5nD2HC91OBOFHl0Q=;
 b=MqXE5zY2otOg0dCClI1enypM+6pFe4Do4P5ziIkI3ebAlDF8ATP5PEGFIXXvxgT93s
 xJR1dVXeDkiRVxVAq8kDIfUIqmZtOzu4ufqAmFGhXQ1OL4IWko7QcdJrgkdWwgSsHMB1
 UrnwrLpaibu2MT5Vrmw4g4cw2993JQyQVXheXJPn10A51fpZT+B7qTb8WUwtIJTWL2uB
 ilsXYqH48oq2/R3/bEwUOzIkkmnOml7J7621RP8psZrZ92TAcNgaFRRgZhxjWdQeaMSj
 Gb7Z7cpao5CB+M8LYpzB93CBxPqq+g3wyR4MuS5HzpvNJvoOsrBNu0LfTiW7AjLsS10f
 7eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786805595; x=1787410395;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FXFyWqlGq4MrvOJ8b4iWKJ83ABa5nD2HC91OBOFHl0Q=;
 b=tCtljp4xgc5voZxFa7tKKbEYel1ndXaWoxoslJiEoLej/LI28qVfAgtMNaY3UwtGgD
 dAvvVZVc0Mg3ZI2TvhBvLwIymiddr8ClWKRtr+kkCBWWWFG6V8f8s8MK2LmSBBD536fl
 VC2kNNDVmJB91hbVL2BpB9ET24bXtA21Ynjh8ShLQECstei29wYNWgCov/Wd+1hPFpu7
 mjspNWWx/M7D5aSAKxqDyPvVS4ldroqmV/SvuGjh9UHjHmiqSW3xxzL3BXVJ65fSZ7sf
 K5HUtB3HHt5Kn6BR77IXtUSIUQouQYfnqBqR2xf7Pc81KrE7/lKOLkGVjCh9VsKbtwgo
 N1yA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOwUfMsRy0bX9rnfdyuyMdONV5E+mVRyMu4Nl8HbNph4eqG+RZa0UC70tpfohkc682MFcCqK4q3ovv@nongnu.org
X-Gm-Message-State: AOJu0YwANVtCl95EYixTz0+psb4pS6OXUkCa9AUc4ABD1COHr5Z/jsh4
 U96eDEpc+DAOVK7UyQwLTddIkotCMVLvLnGxWKhaHWTHY4i9pw7eAPSnl0+f+x3062dtyIgDI4N
 kQ7oFY0tx+symyk9kQvjL0bvKX2cduEDcRVLQrRNqndyPY3qWevCOG8NCxQ==
X-Gm-Gg: AR+sD12KmwDCD8ExIq/83fOUHLoleVZaCPt4N4BB0ugzmVp92H8wtjCvqSLYzNb4Aon
 A5wY5sGSRoUxOF5rx3wfxOQTWd7gyISXp7hXiH1FG3akwXQEBGNiKJEhRTHM/ilyZQjBXVZcZUl
 +gImXDznTY1xuteAM6n+7RnAwBz5JIbQj7y5WvMACscgB23haZ2hhu9tpAPTbEPlSx8zL47AyRX
 SgSRki3MTPZ6b+IRULiGaFpPloLdtOabkK7lQzQv9CW4ap+alJwYS/OXfl1xQ3lVzEkzBNLv4ce
 N7/BC4L0s87TdPujlVYZ7tf2eednnZuywm7tUz1MqTI3f0kpFtn6xtfc+crijiVBxyNR/jgaiSZ
 2GouKQQ7AdeP8YS3Q9ukOYPz5jMmKwRb7bX4=
X-Received: by 2002:a05:622a:428b:b0:51c:2135:b00a with SMTP id
 d75a77b69052e-52d85583c72mr142540461cf.40.1786805594612; 
 Sat, 15 Aug 2026 07:53:14 -0700 (PDT)
X-Received: by 2002:a05:622a:428b:b0:51c:2135:b00a with SMTP id
 d75a77b69052e-52d85583c72mr142540051cf.40.1786805594124; 
 Sat, 15 Aug 2026 07:53:14 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899afa39sm140869235e9.2.2026.08.15.07.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 07:53:13 -0700 (PDT)
Message-ID: <ee2cdcf0-43d3-47fd-95b9-bfc106dcf650@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 16:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/26] hw/sd: sdhci: Use version 4 system address for SDMA
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-10-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723151853.2143177-10-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KW6NuDS0wg4wYXWMlhGet0UoKwtpa49Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwOCBTYWx0ZWRfX0ZAZ2TemArAh
 B3S9adc5os0++UgNfr8ZBQv0s6T6CLttca05JjqQw8POMGcPlDD77+Jb72bAzkVP+R6b/G3faPL
 Dx8AoEpuoqMSIYBKfEDAzUM+mgCZ+zs=
X-Proofpoint-GUID: KW6NuDS0wg4wYXWMlhGet0UoKwtpa49Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwOCBTYWx0ZWRfX6TSGPT8Qzbhk
 uJf8mJW+u8vUMAc4QDDhU6vaQB4/SBUtRPOHqSOaeOORQblPsjo6+sPqOQshDGd0JQ3r/7qTB/F
 3VvRKunxKt+WH+gsJfvI26ZIbVT8RXk6R6I9LBKfLDkGROOkmWbedye4otQt+lVri9LEdr5QbPg
 FyKIGp/ZgUTB0jC/N6QMJ2UXTROfGOBx/7UFT31Vq6GKtOBPcsetH62iGJaJOK7ibRkGETOCFbd
 QIWf8J2m6chScE8FncmjKJSOlrQU95tjHNum3CXpMgIkViJqYG69+M+Js2nX2NUkWmfuSkuOOoG
 VUZ/PHt4m0L7Fyn/xk6S2FCn282qyUJfCuoXoX4e8x7qAB5i3wbLmARXYPa6zPh4YSfVlSTQqrW
 Xk+E8HiXsx8DftaH53qRFcSxWv+2aibEQK0bUaRrRWIh07wcjzU4Rx5//kTV4vX4WzZ6Ev+ojGj
 qF5Qyx+Ng/Lbu4L7j1w==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a807d5b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=JNAUJBtyrWW-KMtcz8wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150108
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

Hi Bin,

On 23/7/26 17:18, Bin Meng wrote:
> SDHCI version 4 moves the SDMA system address from the legacy 32-bit
> register at offset 0x00 to the address pair at offsets 0x58 and 0x5c.
> At present QEMU always uses the legacy register, so guest SDHCI driver
> with version 4 mode enabled uses an incorrect DMA address.
> 
> Select the address register from Host Version 4 Enable and honor 64-bit
> Addressing when reading and advancing it. Keep the existing offset 0x00
> behavior when version 4 mode is disabled.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/sd/sdhci-internal.h |  1 +
>   hw/sd/sdhci.c          | 63 ++++++++++++++++++++++++++++++++++--------
>   2 files changed, 53 insertions(+), 11 deletions(-)

I'm splitting this patch in 3 to ease reviewing:

-- >8 --
commit 39ca75d42c0926d1b48e377bc3d32d439689936c
Author: Bin Meng <bin.meng@processmission.com>
Date:   Sat Aug 15 16:35:46 2026 +0200

     hw/sd: sdhci: Factor sdhci_advance_sdma_address() helper out

     Signed-off-by: Bin Meng <bin.meng@processmission.com>
     Message-ID: <20260723151853.2143177-10-bin.meng@processmission.com>
     [PMD: Split of bigger patch]
     Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 586e4680bee..ad370407c6e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -600,2 +600,7 @@ static void sdhci_write_dataport(SDHCIState *s, 
uint32_t value, unsigned size)

+static void sdhci_advance_sdma_address(SDHCIState *s, uint32_t bytes)
+{
+        s->sdmasysad += bytes;
+}
+
  /* Multi block SDMA transfer */
@@ -643,3 +648,3 @@ static void 
sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                               s->data_count - begin, 
MEMTXATTRS_UNSPECIFIED);
-            s->sdmasysad += s->data_count - begin;
+            sdhci_advance_sdma_address(s, s->data_count - begin);
              if (s->data_count == block_size) {
@@ -664,3 +669,3 @@ static void 
sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                              s->data_count - begin, 
MEMTXATTRS_UNSPECIFIED);
-            s->sdmasysad += s->data_count - begin;
+            sdhci_advance_sdma_address(s, s->data_count - begin);
              if (s->data_count == block_size) {
---

-- >8 --
commit a9ba0290e8c299c6e32c623755219fcd95f3d237
Author: Bin Meng <bin.meng@processmission.com>
Date:   Sat Aug 15 16:36:00 2026 +0200

     hw/sd: sdhci: Factor sdhci_sdma_address() helper out

     Signed-off-by: Bin Meng <bin.meng@processmission.com>
     Message-ID: <20260723151853.2143177-10-bin.meng@processmission.com>
     [PMD: Split of bigger patch]
     Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ad370407c6e..93e1687dbe5 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -600,2 +600,7 @@ static void sdhci_write_dataport(SDHCIState *s, 
uint32_t value, unsigned size)

+static uint64_t sdhci_sdma_address(SDHCIState *s)
+{
+        return s->sdmasysad;
+}
+
  static void sdhci_advance_sdma_address(SDHCIState *s, uint32_t bytes)
@@ -612,3 +617,4 @@ static void 
sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
      uint32_t boundary_chk = 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 
12) + 12);
-    uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
+    uint64_t sdma_address = sdhci_sdma_address(s);
+    uint32_t boundary_count = boundary_chk - (sdma_address % boundary_chk);

@@ -624,3 +630,3 @@ static void 
sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
       */
-    if ((s->sdmasysad % boundary_chk) == 0) {
+    if ((sdma_address % boundary_chk) == 0) {
          page_aligned = true;
@@ -646,3 +652,4 @@ static void 
sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
              }
-            dma_memory_write(s->dma_as, s->sdmasysad, 
&s->fifo_buffer[begin],
+            dma_memory_write(s->dma_as, sdhci_sdma_address(s),
+                             &s->fifo_buffer[begin],
                               s->data_count - begin, 
MEMTXATTRS_UNSPECIFIED);
@@ -667,3 +674,4 @@ static void 
sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
              }
-            dma_memory_read(s->dma_as, s->sdmasysad, 
&s->fifo_buffer[begin],
+            dma_memory_read(s->dma_as, sdhci_sdma_address(s),
+                            &s->fifo_buffer[begin],
                              s->data_count - begin, 
MEMTXATTRS_UNSPECIFIED);
@@ -702,6 +710,8 @@ static void 
sdhci_sdma_transfer_single_block(SDHCIState *s)
          sdbus_read_data(&s->sdbus, s->fifo_buffer, datacnt);
-        dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt,
+        dma_memory_write(s->dma_as, sdhci_sdma_address(s),
+                         s->fifo_buffer, datacnt,
                           MEMTXATTRS_UNSPECIFIED);
      } else {
-        dma_memory_read(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt,
+        dma_memory_read(s->dma_as, sdhci_sdma_address(s),
+                        s->fifo_buffer, datacnt,
                          MEMTXATTRS_UNSPECIFIED);
---

This patch becoming simpler:

-- >8 --
diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 4aeed120bf1..2116995dcca 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -203,2 +203,3 @@ FIELD(SDHC_HOSTCTL2, CMD23_ENA,       11, 1); /* 
since v4 */
  FIELD(SDHC_HOSTCTL2, VERSION4,        12, 1); /* since v4 */
+FIELD(SDHC_HOSTCTL2, ADDRESSING_64,   13, 1); /* since v4 */
  FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 93e1687dbe5..3fba3970d4f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -600,5 +600,20 @@ static void sdhci_write_dataport(SDHCIState *s, 
uint32_t value, unsigned size)

+static bool sdhci_version4_enabled(SDHCIState *s)
+{
+    return FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, VERSION4);
+}
+
+static bool sdhci_64bit_addressing_enabled(SDHCIState *s)
+{
+    return FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, ADDRESSING_64);
+}
+
  static uint64_t sdhci_sdma_address(SDHCIState *s)
  {
+    if (!sdhci_version4_enabled(s)) {
          return s->sdmasysad;
+    }
+
+    return sdhci_64bit_addressing_enabled(s) ?
+           s->admasysaddr : (uint32_t)s->admasysaddr;
  }
@@ -607,3 +622,13 @@ static void sdhci_advance_sdma_address(SDHCIState 
*s, uint32_t bytes)
  {
+    if (!sdhci_version4_enabled(s)) {
          s->sdmasysad += bytes;
+    } else if (sdhci_64bit_addressing_enabled(s)) {
+        s->admasysaddr += bytes;
+    } else {
+        uint32_t address = s->admasysaddr;
+
+        address += bytes;
+        s->admasysaddr = (s->admasysaddr & 0xffffffff00000000ULL) |
+                         address;
+    }
  }
@@ -1382,6 +1407,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t 
val, unsigned size)
              /*
-             * VERSION4 is writable even without UHS-I. Preserve all other
-             * Host Control 2 bits when UHS-I is not supported.
+             * Version 4 fields are writable even without UHS-I. 
Preserve all
+             * other Host Control 2 bits when UHS-I is not supported.
               */
-            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK;
+            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK |
+                                   R_SDHC_HOSTCTL2_ADDRESSING_64_MASK;

---

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


