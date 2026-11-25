Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773B607DDEC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FoMXPDDS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tr3440sb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9OY-0000O3-Fi; Wed, 25 Nov 2026 04:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9ON-0000Mp-Os
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:34:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9OL-0002Pa-Hz
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:34:19 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP68dAn3113711
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e3l6GirgykIU5WgTjlnaqkubbBBlncUV1LqnXnwqTLQ=; b=FoMXPDDSamxzCbxx
 NwWUIJvmdcpUqXmMF1LhAHb6X8TE2X0xru7q8z2XgT263R4mpyAh7SUIm50yaC7n
 CmnNoOMf1LvABzV5VVBpmwcRWSZGE2eYfJazvEQPfyrrCNMmzJ100wAONuG2P4m/
 nPcHS2Xv1rQbRe1r1s9zLen4SJAS0SPaaU2DMaY6+CFZ7Zj0ZK+an4Hb5ghm6K3I
 4Vp5aoVyKubeGpJH1MAYzgwEdZMRWq5gudnN1Nv/vX5a5WlHhSxzd3uAptfAuFdE
 hfXHPcftGBdyjW3SzU4r2Vv85tFFy2VtWLip5/dtyRWdWWwq6CNCQZEAtmiRtpGX
 RxyeyA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnsawss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:34:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9212335e257so12893376d6.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795599254; x=1796204054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e3l6GirgykIU5WgTjlnaqkubbBBlncUV1LqnXnwqTLQ=;
 b=Tr3440sb1sizeCY0ve9Y5/I5I72BajBDdk2Fw6Fk3PU6akbm3iKnNSWF99zi6axYYd
 fNQZe8b86Swp1gW9ib1AqVXtcmUHxdYjYyhLS+JfgoLEAlQ97BGOD72UAiuW+w+3JlEG
 HOLXkEXOx36/3uO+bfAfYWJyvUWzqVu/JwLfaagClk2/MeBG0Ic/uzeAUiw3Vzr9VF/c
 FblyNfNKvDUmKpS/vWXEn46e6dH2inABaNcgaOdB9tb5+FD7UqMOnusxQtl96XEQsyFY
 nhpF7sMWG3f3vI6o8cY59j3kyZrqId16YriX8jSUMgA1nuMavHxn6dhkO+TxKh0uxFAb
 StDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795599254; x=1796204054;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e3l6GirgykIU5WgTjlnaqkubbBBlncUV1LqnXnwqTLQ=;
 b=UDC7yMzUGFYnsNsCX1vyiYi1mN2gNgGDrTTuIIZtYt4T1XnclHjZXcVqN/IgqXdJDz
 E46qOqcozkkkHuF/Dn6vCJzRg+7VybWATIpWnKs5tCCT6rQly/WgHlIOUV8JnDxfJ0kR
 qBccKmrUBf95Vn/rrSM3YmX5iT8iz01ygw0augGcehFo1AJmIvQMS5ryN+M1JI9oDH7C
 JFXxdDA4xhv2/4/sAe4UfMILpnGAG5F5+fxOT3+12+5eIQ3WwDjegyiVg3rXvUGFn+ii
 HE88x9Lda8NVkEYzDxSsBs5rDBHYAn701MnMMpyxW79TooT+7gH754dA9Ws5qekjfdKk
 6Ckw==
X-Gm-Message-State: APuU4Z8wPCxrObcT2z0lquh4ZVhyjXQXWEB4Qn1gpgpYc++Y54o92MC9
 UF0DUSCxZ6qy/Vhuvf2bzLYvpxd/AlXAdBB0Gpui3/5mSvEsBMPsTtoWcfnRvANUV+4KUzKpAA8
 qX+oEwV/6Bk8lJuGsebbjefXZgtwF8eCKwsW/ErirUBVI7irphuGhIFx5Uo5/M4NUao8X
X-Gm-Gg: AZFdTZcE1Uv5jpmWvAUxfQAlLfm1qTQ18Gg/+uNNPNCOLrNbHvlMpxv0A29UxCzeJxj
 m75rLMq5WYrqxzuDtKWMSYpnetNSB9HSt4dE6QirOfJaSX7ObPZqZxjPlzx8up9rbmjMb4DGpOt
 z34zEY0nRCw5oXwwUZAadKMrHGwR0PyFvpouUDQlYEXWJbY9bmRu8HPFO6Qd0WGU8TQH9dn3/bK
 zEaRbO3evqKUoMdqBUWBmT52hn7LNTJMQclX2OLlnPR8BtCmrA2DFkl27bYsM63mlkAleBzh7+C
 OyO4uoBX+dvVJ8yYQ4O3PYkTdz1CWvAutlrAYSG//NaBU7LVE3hkck1ZWKp0dGN8GXmmqT8Ft2N
 pCHKAqxVH3KFA5dbLIbKpnBe5mqRJ2Nj+6YPrxYRdEdBH/2LvwPBj79lJ6BKek3RcHZc0PgreDp
 RdSIHm5bs9iBa88A==
X-Received: by 2002:a05:620a:28c2:b0:949:b1b5:bd6 with SMTP id
 af79cd13be357-949ba9b7e70mr3247762985a.15.1795599253685; 
 Wed, 25 Nov 2026 01:34:13 -0800 (PST)
X-Received: by 2002:a05:620a:28c2:b0:949:b1b5:bd6 with SMTP id
 af79cd13be357-949ba9b7e70mr3247760785a.15.1795599253259; 
 Wed, 25 Nov 2026 01:34:13 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm502535425e9.1.2026.11.25.01.34.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 01:34:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Elliot Berman <eberman@anduril.com>
Subject: [PATCH-for-11.2? v2 3/3] system/memory: Invalidate TBs on ROM device
 mode switch
Date: Wed, 25 Nov 2026 10:33:49 +0100
Message-ID: <20261125093349.97805-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125093349.97805-1-philmd@oss.qualcomm.com>
References: <20261125093349.97805-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Q6XNaVTYW-wW9snVxOdiS65DckP2rILH
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b06ab96 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=eDDFyTeRAAAA:8 a=EUspDBNiAAAA:8
 a=pvMrCqgW3zioGT-S4xsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=xu_OM7uD2k7YPmAm5WZD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfXw46FSBIMrG0R
 o851GPT3C6QAbeiKnanKar4ALG4yiP1YtXjV2F/1unkLFMLYWpP/MEB/6c4yFifF2ChkDcwQro5
 i92/XrwCdUPfR33wuUWXg1MR6psRUX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfX2kpc0NQoAJ7P
 0nq/fkW2nSi0n/cX+FIO6uLUTEpIuqoiEQXjqFhiJx5tvgpqALEcvoZajPuO+T5enWOBg2pgqtt
 9+z7pe0VMwbwlCK4d44ULONyHoomznEQzeS1lXYW0VYgJpd11R1oN/QbJa2VSOP26JiPvJabWnD
 21H4fE8iIJg3Qyj4eo2YlFs0XUVnWUg57If8TtPLv8JNRn771F2roXAjdw/zUsbF0S8Zq0vWREo
 m/I1DIet4Y2umshpiYJnjdbufHPob4bpeIhtz/enjdCt3rbE5IhdbIp+Yy5Mv+6eBcj+8MSi2nU
 LOnrBu0R4SjHCrMjl8Ttu0ww6ue2a0eEm/z5fxHtMyaKmdLNkLDUCCJGRrlA13BSZ0nFpqBrAFO
 zi9B1Yl/6IG/Czqb/SAfKkiedH4Ih5Ug6f1hUxlczSHTSZlaELQ8+bVsBzHubG/Dgrr+6wbuiG7
 xzDSWWOrJfrdYSQ6pgg==
X-Proofpoint-ORIG-GUID: Q6XNaVTYW-wW9snVxOdiS65DckP2rILH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250037
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A ROM device changes its contents with direct stores while in MMIO
mode. TCG does not see these stores, so translated blocks built from
the old contents survive the switch back to ROMD mode and the guest
executes stale code.

Make memory_region_rom_device_set_romd() drop the TBs of the whole
region on both transitions: before leaving ROMD mode (if currently
in it), and after entering ROMD mode, for TBs another vCPU built
before its TLB was flushed.

Flushing only on leave is not enough: another vCPU can still build
TBs from the old contents via its stale ROMD TLB entry until its
TLB is flushed.

Measured with a guest that repeatedly leaves and re-enters read-array
mode on a pflash, once with no code cached from the flash, and once
with a function in the flash called after every read-array transition.
The flush is almost free where code isn't cached in flash, and costs
about one retranslation per cycle when it is.

The pflash models are the only callers of this function. Other ROM
devices (nrf51_nvm, amigaone) flush from their own write callbacks.

Cc: qemu-stable@nongnu.org
Reported-by: Elliot Berman <eberman@anduril.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4490
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/memory.h | 4 ++++
 system/memory.c         | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 298310cffdd8..9224cbecf1ba 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1960,6 +1960,10 @@ void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile);
  * When in MMIO mode, reads are forwarded to the #MemoryRegion.read function.
  * Writes are always handled by the #MemoryRegion.write function.
  *
+ * The device may modify its contents while in MMIO mode. Under TCG,
+ * switching the mode drops the TBs of the whole region, so the modified
+ * code is retranslated.
+ *
  * @mr: the memory region to be updated
  * @romd_mode: %true to put the region into ROMD mode
  */
diff --git a/system/memory.c b/system/memory.c
index 2e3ce773ce97..6db104cf1741 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2254,10 +2254,18 @@ void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
     if (mr->romd_mode == romd_mode) {
         return;
     }
+    if (!romd_mode) {
+        /* Drop TBs while memory_region_flush_rom_device() can still run */
+        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
+    }
     memory_region_transaction_begin();
     mr->romd_mode = romd_mode;
     memory_region_update_pending |= mr->enabled;
     memory_region_transaction_commit();
+    if (romd_mode) {
+        /* Drop TBs another vCPU built from the old contents */
+        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
+    }
 }
 
 void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
-- 
2.55.0


