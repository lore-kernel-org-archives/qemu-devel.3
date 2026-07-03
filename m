Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A83C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgx9-00054c-L4; Fri, 03 Jul 2026 12:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgx7-00051x-4w
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgx3-0001Ye-Aq
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIhrf364553
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0zxOegtK9/HXZJNp7+v9NFHsGRS7+LXc2HkX7d76Edg=; b=WZVCgSud7j3Cj98c
 FFWXaF1igXjqooF17+6p7IsvjlodiN8fuATRe7mgMnY3XraJfSA30kklsSceOmzn
 4uZzV/iV04g/pDdpfZittNMnRXx2r8roeucRSF3SdX6MA/MN7yaObAn1MOyZKoM4
 jjFjXfNce6etY+INxyIm/1tlv7cGI3bFXndx3aYcZoVzmw4pJk+j98/dbr+/FWfQ
 cWKDXg1KJJDp7jQq4QKOcYimoKvd8t+BhA8TERqL4PRB1OgtbSSL8PeRz5vXc4hf
 2G0vLZR5/wJDSNRacSTEFRdPaqXoPe0nZNtosDQ4kHUAZGHT4TjEmXWJ3KB4CDll
 oXXDAQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j02akk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:41:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e66f9e2baso74316285a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096874; x=1783701674; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0zxOegtK9/HXZJNp7+v9NFHsGRS7+LXc2HkX7d76Edg=;
 b=DenaLCbavgtch1UOy9Z7OqzJ8LpbJCHIIp20xaZyvuLLj2AnCKCRIKWRt98R42mvOz
 zi0mophVP6rkw7ju/H9PeWTsbCjVqXrwAUpOkH2wRdJKfkX0IrAPb42MZvACbYmrYOvU
 VXHy1b0StUllNggi03S4BWpwB9YUCWWV1rCAWcrOaXAzqqNpXuZNslF9gsdURI6TdcsA
 OiyXMvhg7jn9eYRmT1X9SRBM2VURfyjxIy1YSydcnNiqnQTqHHwyrFF3uLO+kao2DqKE
 /CzgcrAPVJXOfEVv0yNnRKhPSc2TzwncnKZ4JFZZz7KndXCbR+CTmCG97RfVNDHFrl8t
 IJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096874; x=1783701674;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0zxOegtK9/HXZJNp7+v9NFHsGRS7+LXc2HkX7d76Edg=;
 b=eBFJlpyzo2CmNlxisK1wHVFOpRTXLDt8qp4dQCPA5u4yjYvtgacD+0QiDSKrKApL4b
 la9GnDz/fs0tjHdLHlHc/sAXCy/v2qsRDrWMe7g+IbDmu4t4E4R+N3409RaVHr67ff1m
 2jxgH15yhOhLf9uktJForcY3h4I0IITco1X0uWJiI2du7N2m6QHhhbVEiSud5/qs1MG1
 faKuM28YY4Hp2Nmtr7z1BRhx+JN2aSAdz3rQb/Cb2tXogb/UAXQcfXZSeDOlH97x1upO
 U5J+7fKsPUlQ8lCycHytiHulmdj4ZJY8gVlg72R0rFWXClbfo3ht9YQ6HPZcdOPmAnZV
 OpGQ==
X-Gm-Message-State: AOJu0YxjeL6IlPdZpBZ0eq4RTj5Jwc/n1XqTL7yI8NkQpXOYVAhLZqcD
 UxD4wuXnH5ix5t6YPlGhP6a2g83BhWryQkBLRsUGOZLw7Xrh+AorjtoHrEuEYbaEHe4rwMP642v
 9toWC62TPufm7yS3is+XuW93pOfkuMsJAG7ax3nvfUID87HUhda5SO8msYyFNkmA/0w==
X-Gm-Gg: AfdE7clA45ewrsRNFZy+af7Ylb3SZqvpnlOU0F7bg5ile2IBxECaizMkpAlwZ71UhgG
 kMEePf6Fe3HtvwiWnP/uTmVzSwGhKn2B0Vyy2YcRx9SlmwYIcuIo/woD5+yCT3IoKq20ykJCivY
 uIbcSBp1TGFjOgPSnbDYMJjd72iLAXPUGjyO8kyRI9CvCbzfgEdDvTcYxY+DhssF4tM37B/lV3C
 OgdTeNe78TWVLl43ynL4uSr51gHkWLXYZXI0G8q4X8VObou2L7X74yGFhBBSELABZA/HihUL/mR
 ehnTIpSWZ1slLvm68/f36Cl2JRbTLOeQHQwGQ5I8XnOpk9Pxh6mp6dn0oOJQAO7lw8IldTa+SIn
 r0w2im+RANk4zHsD0mJHjhDO3q5ToHExCSFI021LJkIxNB9rXa1eqh+RbinAguEbVxSsj
X-Received: by 2002:a05:620a:4041:b0:916:10f6:77c3 with SMTP id
 af79cd13be357-92e9a3af101mr27092985a.28.1783096874384; 
 Fri, 03 Jul 2026 09:41:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4041:b0:916:10f6:77c3 with SMTP id
 af79cd13be357-92e9a3af101mr27088685a.28.1783096873917; 
 Fri, 03 Jul 2026 09:41:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a558easm584500f8f.27.2026.07.03.09.41.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:41:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 26/33] target/arm: Inline check_watchpoints() in
 arm_debug_check_watchpoint()
Date: Fri,  3 Jul 2026 18:37:49 +0200
Message-ID: <20260703163757.55500-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -6EIFDt6rvikqZ7xHNhg0jhIEOAOAkRD
X-Proofpoint-ORIG-GUID: -6EIFDt6rvikqZ7xHNhg0jhIEOAOAkRD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX0gXAoim0Kwn1
 Jzs0m7/dxVHHieqi+J97PTZoObyGQBBcaVjE9euPUNKA5S7wzozaZcyjMJsU11OOKWHyoytqlsG
 XIHaFylIKXeeuBkoUKnSNcESEePio6Y=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a47e62b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FSafjcPV3XuXVNEPM0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX8LrqkGoQqkSO
 /SSci5vZzpL+VQlBSfM/1NZeIBBBzsnHJKQRQzJhl66PwSsSJ/0oVAUIBrh1FTtDsFWEOkPDWrf
 MevgSkvMrAD0lGSKPcTeQ1fl9Bb7Vo/qblFsy68oJ7sqyuZbRyrC4wCg4zmc/sxI/hzsdJP9cAG
 dfT26AlLz3jIWCYqXjHYXzGaRD5BQHR7Sth67t2KxzSSG6MT9SfawTTDHFTg2SjXmOoYTo3iqZ6
 0UAt9H8c9nt/5g2tfpU+vxo3rBwLc+gvixuDvhJDs053G/LPqINgcNt5vtUSFryUsp+x1bBU3tP
 XKvK3pSTRwnWl1+nhUI/CGEnJfsG+HVc5BBU9Oale6EsSUjSWux7i1am9isnk7FpSoZ3637WfmW
 99Uv47fpaDmOAC5oeiFS0sbpxPzlymqwFbYqVNHUSnKecChMiagm6m41JewZdrSURi40qH8eMQU
 2n25gi3pJfy4paXgLZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
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

check_watchpoints() is called once, by arm_debug_check_watchpoint(),
which doesn't do more than this call. Merge both. No logical change
intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/debug.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 11043ecd589..7171501d400 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -351,28 +351,6 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
     return true;
 }
 
-static bool check_watchpoints(ARMCPU *cpu)
-{
-    CPUARMState *env = &cpu->env;
-    int n;
-
-    /*
-     * If watchpoints are disabled globally or we can't take debug
-     * exceptions here then watchpoint firings are ignored.
-     */
-    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
-        || !arm_generate_debug_exceptions(env)) {
-        return false;
-    }
-
-    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
-        if (bp_wp_matches(cpu, n, true)) {
-            return true;
-        }
-    }
-    return false;
-}
-
 bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -426,8 +404,24 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
      * is also an architectural watchpoint match.
      */
     ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int n;
 
-    return check_watchpoints(cpu);
+    /*
+     * If watchpoints are disabled globally or we can't take debug
+     * exceptions here then watchpoint firings are ignored.
+     */
+    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
+        || !arm_generate_debug_exceptions(env)) {
+        return false;
+    }
+
+    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
+        if (bp_wp_matches(cpu, n, true)) {
+            return true;
+        }
+    }
+    return false;
 }
 
 /*
-- 
2.53.0


