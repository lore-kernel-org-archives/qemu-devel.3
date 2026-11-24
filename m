Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EFF606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i/73X2Em;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EWJd8Gqj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvF1-00039j-30; Tue, 24 Nov 2026 13:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvEr-00039J-NR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:27:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvEo-0006ZN-5i
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:27:32 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL1vU1872647
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CqIScvr6AlCA3my1JSnQk+
 EI+L3cf1r2vAu3vzBs8mQ=; b=i/73X2EmNtCMFKHZGYzdOHZxGoGiU9ZhPaeNt1
 PU/jpUtrgZOMy3wEKbAz/7m8bubMykvfQfbrIOhHnAU3jVy524lnsjx/pIOXT44A
 OhAhSOrPsq6TEpEy8f2BlzrPohq2NCRftF4rcPoRxjR7PXI4Rtv4bbpS/QcOYrNF
 Pxm5e2FZPF8idMqNI97Aq9okwY4bPLNleVRb9xZMZk6RXVyAYaCdWM9BWUl05xgi
 BC64zEyORCMBu4oriAwZWo5LI7xGT3OHxWIeH8aIuuLpre8WvWb3HOXU7y8JEVRI
 f5dqpKYktA2pXp0L9qUe5YuzaZ2+za/amvwv264ydD3Kmrcw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxk8xsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:27:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-920fb8b9859so1790446d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795544845; x=1796149645; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CqIScvr6AlCA3my1JSnQk+EI+L3cf1r2vAu3vzBs8mQ=;
 b=EWJd8Gqjxm9JHK0PPD0JIt9wQfQuVv7A9ldJDJaqpHb2r65m2bhK8pwzoZBxJJJft9
 bmwDeWoYKCHWgt/pkUahnXAoSbIkiidwqHyVDFDQ6nOjuJDBLuMZstwyu6iDhhXFOgT+
 76o6DI6giQYNxWfYtMHnPbN9MDVyiV+9Lkc5UQ51WlaRkoyo9gVx9yW85ik2u7zrVQSb
 U13SCjCYzpLWejN9wr1gI0YgF9Ha8G6BSROcce3ra9V+vMJ4bQ3jp/ZMV9KvrbEA8/Ge
 OQMSCsYi10yAN2AwVphk0+3bNbPqDHIJ+PiiudL6qj4cwJogA3Ky7PKEkIKb4ox1hGNV
 LsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795544845; x=1796149645;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CqIScvr6AlCA3my1JSnQk+EI+L3cf1r2vAu3vzBs8mQ=;
 b=uvph01Cjf34Z2agQF5+mGwxRjfMlhPsdxtrfXP6KcLPe4bdhSisvi2d47FDikrWgaM
 KGaeCCVeF5C4Ho5up5IuNumBsTpxEvIgIVv5oxjW72FJYuaHoFq/YR+dJHA2JhIEZkS8
 teDDv4Fn2viKpZlcqx+md8g9pCYC5LSaepLwqlZZ7cBkYpukFjOMjz4iTBkjMl/K91cq
 bgs4wqT8j7yl7NtuS8iDbTF1UZEzeFCfECjUu0bOmW/MKhIaO5G/0TSz0khrquc0/B5y
 MoZpZE3vLmcqi4o14sNUnjc108MRcEtqt+UVJneXvIrwGpcuNGSTZm1y0CmNgPo3J/cy
 PECA==
X-Gm-Message-State: APuU4Z8e2F+MtgRB2uGGqFPll4ywZZszKma6esJVTm9O5EqKkDtnkJjI
 vwTBKfPCMXiarnWjoy0cNR12Q6m+OdY7XFW5Bx0u6FxmBemoVZbVV0iH6u9138DOL8SIV12Al4k
 2Kyd0G2WEucQktEETJ8E9WX0S2VGUQGxDeOdTFtPQuD2e6GwHPKASxMc5P0IagJDr1Pf8
X-Gm-Gg: AZFdTZfbP8BCQOdNeMid/939aYFfU1KtFm6Rn1ibi7nuns5LxDpINa3F7FfUQfGkjnB
 x2N03zlocX6qyz4uScOfGg/whMd1rBxsYP+sAAX7PxlTLJQyDDbZTEE1nzcNFBBLtH6zOXFIQEM
 HGtOpscnTCiUWKW4hQ5z6UvIhFkPiHsqauL5rd312Nh/0ghmdZU8paZI/hEfvXfKzkyxzsgV/hR
 tBGKf3st0xEJM0RfFJF6IP31hUi8zdbR+m68pHm00mPrHlrOREey80yp2QdLRxeljbQ8KTdeS9g
 noTFlYTm8n1qgHMIkJZs9P/0uzTR3JA65YcXWosnSQyy1iYRpLzBNTttoAm6YWnQtcwkBeAlDY4
 htI1VPf5NCltMhRCisNeL3Sb0uqSLMoRqvfhfWVPrvjE1igBoG7EMzV+62xJmUIf2BCJnJ8SnXq
 xzN3zFm6ilzqUdpA==
X-Received: by 2002:a05:620a:2906:b0:93e:5eaf:dd87 with SMTP id
 af79cd13be357-949bab54b88mr2711114585a.62.1795544844843; 
 Tue, 24 Nov 2026 10:27:24 -0800 (PST)
X-Received: by 2002:a05:620a:2906:b0:93e:5eaf:dd87 with SMTP id
 af79cd13be357-949bab54b88mr2711109185a.62.1795544844342; 
 Tue, 24 Nov 2026 10:27:24 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b3a7sm510175825e9.3.2026.11.24.10.27.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 10:27:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device mode
 switch
Date: Tue, 24 Nov 2026 19:27:22 +0100
Message-ID: <20261124182722.78535-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3MiBTYWx0ZWRfXzmXl18VS9nXq
 +nVH9KmFLrGxpxkEpAhlN+45J/VqIVLKaFiZycueQMsYudMO8KyXj9usZ8/Hv154Q++YqVsew75
 J7IYkltsxcz73ES0BLdZJ8OuTCVdn4pU36kwPHzNwVS1Ucinf3HN8HvUqk4lE6wEgO7Uchq2MQO
 8s9D079fuJNinb2zjpkcLfG3ec7eGo74IgmhmraYY6XacSSdz6wu0YZf2JdtMRQvwLpmpLL/0OM
 ZD38UmAhJmEwsG2+2A/px6585QHnSPahVXFjHqtKszwEKbtpEjPZS2k2cMkxbLzLlq3pyTVbIK6
 XJknl4z+RnggPDDYlmvxUEQzx4cKggs52er9q9mU+QLWT8PF7a4884vWVCeoOzirm/p7n2jssSA
 tyDO2O8oqBJmgfKkrQQBX/syTzSKMbG7ZQTbjm2Wc86l9iFBQp1EdEAznZZRC/o6e016627fVkq
 wN2xZBEJnQfGRmv5XrA==
X-Proofpoint-GUID: 8uQ7lJRD14lkrS3U6-Rb4e-49NC7SrRy
X-Proofpoint-ORIG-GUID: 8uQ7lJRD14lkrS3U6-Rb4e-49NC7SrRy
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b05d70e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=eDDFyTeRAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=rmnutlRX91pVBAYPmhgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=xu_OM7uD2k7YPmAm5WZD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3MiBTYWx0ZWRfXzPbegWF0DXW5
 QIcYXanme3rKET0REC3Fdh0ndpnU4ubx7IC0L8PLixqD9ROssp3U1rZJC+px/2lOKxB7pQXZy3D
 BoqkGmuwVdHPq3oHBGmauV3mQ63YxBY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
---
 include/system/memory.h |  3 +++
 system/memory.c         | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 027ca81bd2e1..8dbe37e60ad5 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1959,6 +1959,9 @@ void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile);
  * device is mapped to guest memory and satisfies read access directly.
  * When in MMIO mode, reads are forwarded to the #MemoryRegion.read function.
  * Writes are always handled by the #MemoryRegion.write function.
+ * Switching to MMIO mode when currently in ROMD mode, and switching to ROMD
+ * mode, both drop the translated blocks of the whole region, so the device
+ * may modify its contents while in MMIO mode.
  *
  * @mr: the memory region to be updated
  * @romd_mode: %true to put the region into ROMD mode
diff --git a/system/memory.c b/system/memory.c
index 56c5dd6c8abd..f01470993914 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2249,7 +2249,8 @@ void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile)
     }
 }
 
-void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
+static void memory_region_rom_device_set_romd_mode(MemoryRegion *mr,
+                                                   bool romd_mode)
 {
     if (mr->romd_mode != romd_mode) {
         memory_region_transaction_begin();
@@ -2259,6 +2260,17 @@ void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
     }
 }
 
+void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
+{
+    if (romd_mode) {
+        memory_region_rom_device_set_romd_mode(mr, true);
+        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
+    } else if (memory_region_is_romd(mr)) {
+        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
+        memory_region_rom_device_set_romd_mode(mr, false);
+    }
+}
+
 void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
                                hwaddr size, unsigned client)
 {
-- 
2.55.0


