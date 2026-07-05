Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D538C44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUuh-00055F-96; Sun, 05 Jul 2026 18:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUuR-0004J1-8e
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUuN-0001E7-Vu
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxJfq2839014
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M3dp04bWiFG6HBjS185iJv16BHEJYGmT/8ByI5DYFTs=; b=l571H5Vam4aNBhJx
 eMRpcXsNyupLcydu42O7Ip1SMivZxvxiMPPoRLuw8ULmsVfrxVeeXxztlbmD9Nrt
 //RQBZtqBSkTINuxiL2vfbc9szKxwnTnE0oOWZ4W+P17TFrT3GWzSGHUX9c4s1b8
 BWopqCnsRqwu9Ux+BAHS7gOerQJHamq/QKU2lR9FiuC5U3m9gkpWzFqoHCadIcse
 oG4U4VB1Ta7gITnJME3jMskuPJXEJbJrlteU0V2HzNMvj4+5LsejDO6tZ6vzYDUy
 1v4l3dn6dUiEbIkKwBi7MKIOwQkDOehB5QOj507rgAD4I+DxBJdWYDJmvF6rlhuw
 3P63aw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvguty3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:01:40 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bde4e69013so1046654e0c.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288900; x=1783893700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3dp04bWiFG6HBjS185iJv16BHEJYGmT/8ByI5DYFTs=;
 b=D/V0ZpTWcUUblgjKuTZCSn2wVQmWa1j19EFUuPskNa6g5f4NhnKosc6vtP6tmobF5e
 ujt++HqXpz6b/Ibxj0tgRlHh8dLh8ymOjPuInp5pUzj3ziwDldDbviD9FlXZ5ux59oUR
 45vg3ezMH8uQXrp9dpkJyPcUMduM+gW9JEmwa79o/Va9isRw4p40BNi3lwPXqYZaZhyQ
 BRiAvE6th+BS6QMdoi/sU7L7rkd+ft1WlfV7Iu3bVvbmhcrCONdso3IVpR/MhSbCSCrm
 V4S8J6ahnCifN7PBLb+DUxGR3450UBKPtGYHnzrOgBMTtcGNCy/lRyTuDxA9IoSg+BPH
 LF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288900; x=1783893700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M3dp04bWiFG6HBjS185iJv16BHEJYGmT/8ByI5DYFTs=;
 b=FhSRy4eaDTK93sb0p+r2SUs1cEUwlv4HhdCPNE24qeWrC+OOE3lUK4SU6cfzKereNO
 Vo8y4F5ayNJ1K5SoAtbxQyLoD5YcRMpcGc4zCO2SUsCRGGD3yaqxLslwhI3I07VxjX2j
 hCw7xJAqV9xeIIhV6Tqk7QrPs971vvOYuWMDoA9bGFf0n5AoVKa6jHjg8CjpqxhgOmRg
 /qFxd2AIMOjz+VGl7lLMNEG35RErc6AM3iyZn9V4ZyTmXj427DZhcukyV/L2IWZwKidF
 bVdPWzJfu+kSrzv8I5DvGIzZ3cLDHkfwmbsRhA9YodhCGFg9P9rlwV+ZYDu7SvrtYWlG
 X38g==
X-Gm-Message-State: AOJu0YxB8KDk+Ub5r8TW3QtgnXVx2DG1YQps8xim9PZHJCMkDY/i3k1k
 XQswOd3IwKXwzHwv6iyTesTUG55YTeFfCEdUSyFGwBAnb8qJpKaDnjUEHU/JkrJlJDu0PdFaerF
 W2fodi4PLbiGjB0SCwzWATRFDEs/Z6zf2g10cL8wGn02IwrBSnINCtTqcMi7bWnQBYw==
X-Gm-Gg: AfdE7clD6gK+HTSVbOKcCIBCi/qHp8mQ6zrmdxnubvAw4YdQHlH5fGail9zHSJGay8D
 UojeDZls9l1wgbO8/gLLtVY81JABhde6aJnFvBGhiC6RTJgCybXIU+wHFl5i2srWehUb5qNvcWO
 altW2AFkHc3Al/D5klAyn/H9fQi1N38zKKFRJVm7UKn2Dzh7NpSktXCZtSDcniGRvYsphG+0j/R
 MRcflzGzXyQNUXfMyi3P34u8uQ3/9DMYSPKurdwhvzd4AmurSLTlZbaMFCvaWJ1wlj6I4+EVQtO
 QjJjpdAidnTV5+zY8DZx6D8HCb1MWn5x30EBW1BA79/2nFV3afm9sH3Jd98d9EHFNe1fIdhyKdl
 p5eo9y8zK/n4w5kH/VCPa/o2rzNPSAPsR7bZZiZdxI9KVQHmZVWdUllIVdz3U7BKp+iIs
X-Received: by 2002:a05:6122:e149:b0:5a2:5669:d6d7 with SMTP id
 71dfb90a1353d-5be102da71emr2511219e0c.9.1783288899643; 
 Sun, 05 Jul 2026 15:01:39 -0700 (PDT)
X-Received: by 2002:a05:6122:e149:b0:5a2:5669:d6d7 with SMTP id
 71dfb90a1353d-5be102da71emr2511136e0c.9.1783288899042; 
 Sun, 05 Jul 2026 15:01:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccb4cafesm220154275e9.0.2026.07.05.15.01.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:01:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 32/32] cpu: Only check SSTEP_ENABLE flag in
 cpu_single_stepping()
Date: Sun,  5 Jul 2026 23:57:28 +0200
Message-ID: <20260705215729.62196-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4ad444 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=67IpyjWKbRJXbWkAkIEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0pZrnw9_duGj-rrX1iOW-oFCXoFBAJF2
X-Proofpoint-GUID: 0pZrnw9_duGj-rrX1iOW-oFCXoFBAJF2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX+vsgGoZpcfLd
 HRmbIirPeTOzyrvlV42JsAh15OM4wvFBV3lJO7a8nfsa5fpCGJGawBsaJyvfBKSEJeKDHUopWBp
 IszfkQgDXnpah6N7S3ELqyN9mD6IXL8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXygiU5jJXCjkf
 V9LVSDBoo1XRWHNRlCPx2YLs6P9FsKDMEOEEwLOycc6eewYPgH5HFJjYUoWj3zzfMIrEFiO4I4J
 bo5BQ1jlvdmtByuAomvXWvzif+WfQx907Q4rBBng67CVvRANwiowXyqlEHLovbpmurOw8yvdW83
 kXrAtNDwgbyk4Hkx0TMMzlKc9yg6OwC5FBJm2wryTTgy6v+Ryxk9zQ4zWBBS0ikka6fJ/OVDZxK
 CBEU6dKSN3oJCM7mQLenU5PlpF84iYT9X8NeM5wun1RiZtKXpUEcS3UUldjJs2gyZyrqdBSYU2h
 /X3pGy1YA0olkA3hOA1xVOiSfY3dKfzWFDKE+HQifbrsLhXnA4JCOGo8H9j6RpghE+q2muISZYT
 ZDNfm4KbTtsHjJ49iqDrhwJ6+UvXNM28vk2nVLfDvt4oukqGJPXAA424d28yjToUrUsFdcGupHL
 6dJBzoArc82rc9c3PlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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

Only the SSTEP_ENABLE bitmask means single-step is enabled.

Fixes: 60897d369f1 ("Debugger single step without interrupts")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a841dd4dd96..fef4a17c965 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1146,7 +1146,7 @@ void cpu_single_step(CPUState *cpu, unsigned flags);
  */
 static inline bool cpu_single_stepping(const CPUState *cpu)
 {
-    return cpu->singlestep_flags;
+    return cpu->singlestep_flags & SSTEP_ENABLE;
 }
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
-- 
2.53.0


