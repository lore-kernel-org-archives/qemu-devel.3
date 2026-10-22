Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805A606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eYWWooFR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CEw1H4uo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nO-0001kx-4B; Thu, 22 Oct 2026 17:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nL-0001jt-Jx
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nJ-0000Fi-PX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIH99E1494700
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U2g+1W7PW3UR9TOQfxvua2EkUNe+5fs16xF3q5cN4bI=; b=eYWWooFRAhANaz2m
 wZMEVlvdvucZppDnJUuYabi+T2fX3C/fy81erhw/C+bZlwMcmz/m9w3mqscq24lq
 S6xEVhQ1/huiAQfVp8Y0bmKfrOxz/8w/cukgRBXmoGWJBY0bAGt1vREkj2zlWYxF
 b1Cl4LGBfX7Xs5Nr/SwPEn59gwBvBD9D8vL/oXH6OOYx5Zb58I7S7Jsxx0vqm5kv
 +F60RVmG9Yf9fZ5U3mnHq+DCBZd57qXlh0C0FPuDor1FPaNQ9fnxbYRwArGD3ar/
 DAMn6UoyWOIZIwSsBUWzF9X5qaBGGbEA+rd4TDs8ckf5O+SLD0rrIxrKFYgE0VUN
 3xm2qQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8q3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3acc98e3b3cso213011a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706271; x=1793311071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U2g+1W7PW3UR9TOQfxvua2EkUNe+5fs16xF3q5cN4bI=;
 b=CEw1H4uoEeyK4PSs2rVphU2Zv8QUNc1FzODAAyyJtWdSnobo1N/Gb4JAp2LGhFtrqx
 PWbqldp4cYO9TOYbn7wjdWFkEhcqqdGEwOcPo9HyzdP+AAcVykrIYMBCogR8weEppwIq
 o+95lnGrJuOVM77kDEaV/5N2IpvFhyY474Vg27v09+PZjHIzi700ylQGrHBXNkUvnplI
 kOS04OpaFPNJmxugCvsK605ro33XSfjdGfhe2qXPfjTWmHyC8emKfzkKPVedTidI1gNI
 hIncBsbpdNFpsXCMxl0PVLS+CK+Cj4aWaSxlcgVZEa5eCGI3f3CUeitpi5EczgQON9T4
 Ke9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706271; x=1793311071;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U2g+1W7PW3UR9TOQfxvua2EkUNe+5fs16xF3q5cN4bI=;
 b=UIR85pUf8a1Nsnpt6+R1/hMHSP9+4Ygss1LgClsLNfSeyl65JHXi5gRaj6kZ2yY9Xb
 +hwb+qVTbHYou+xUkevZvLue4lUiPg2z1vdvSzusgABK2VewbKlMx6Fq1CACLx+d1qtU
 MhxLiSZNey9/LI7JlB9azuPmyr2uYtU+ZyisLZSDKb/ZW1w9KadZ4vj110ySKZSg3+lL
 Egia8eggDuop8pT1V3LVWdOM4PXr06DU5eoLfRADYn30wUKJ/7X2mIUcs7qVEVSR8kbw
 RKHyXmYXeJjnuqbMFJliHat/GxrHy+yqsIfizKCn7SApznO0YnMBDwjiVTadcJkztf+U
 zjyg==
X-Gm-Message-State: AFq9FYI4FlQJyzLs2Ldy+bRK/7yb5CAezOaf3aZ9O9DT0XMal2gP7VWs
 lfDEslcJb3cBEC3NALIp8+A5pmf2O/0ZhAiXFFUC7/irVZ9tEd5N83pJD33xVBFuadB4vCAeG59
 8mo1rlwZmWH+UdoE2HtLw/akUSjSyZyQcdiJRg5qkaYlzG2kq4XDsyuTBseFqGj06kQ==
X-Gm-Gg: AYBFou3ZC/XhnS4VjWJi4sumV8wuwx+kLmsX/uVqjXW45MnM6ls60QC6bHoPOs9CvBA
 Bc8zIXefjG4RJeDZZHBnAJfPQ7Y/TfW0c37qERq9gWAL6V0i2i+D3e5q33oRtiXS2F4t4JCvC4L
 HvWbfd9+Tk2/JtkBH8mgF6IU6cQNBJkP5MGMRXwAieNGUyvM+bBPrzkjgF3Z+e8+c37d5o4Ge/K
 dDv3edTAK8BlijljUkFmbZdC593GlltqDxd9CzmirDNLY9g/VO0Q6oVMucGUxr3vyCrlbq1pLHn
 qIxBnzRAdott8+efYElpHeayjy0nrkH8e9K3cHQcVRyxP/aWgxh3QyyxnlxUFaQk8FgTXFLiBdl
 7Bh922QbHsCfMskTkE5vYyHg7Br1pvFsv0uwbayPxsktlIdiwrYRuhjIWxKUjniQ=
X-Received: by 2002:a17:90b:4a0c:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3adce629c32mr148354a91.30.1792706271522; 
 Thu, 22 Oct 2026 14:57:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4a0c:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3adce629c32mr148336a91.30.1792706271012; 
 Thu, 22 Oct 2026 14:57:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 03/27] include/qemu/typedefs: add ArchDumpInfo
Date: Thu, 22 Oct 2026 14:57:22 -0700
Message-ID: <20261022215747.2479440-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2bZBhXI8yiKR_6yGsXxmdXaB707qMwpt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX6RaYz2c4Ud9r
 BhWSv1ToVGdEr6Oz1vqQWmPf5YGb8qUDAIv4UrASc4dDB5a6xpNxFsPU3lL4fwdBvjicVS7aPiO
 uX96sYMzM2vMlXeXdU034IZv18WnOmw=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada86e0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=WAb2S511oTjnKBTKeboA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX2ojQFnv7jJYP
 fmjWyc7bjwPs9qIvXP9H53Ik3Ia2GJOxU1opdP1JburuaZq3wHGCFbpbM5OKfBHjwgNk1aDS+TW
 VSl+A6px31Lp1M55CxrGXPUziMchqiAYI+bTYoYElVJKNWCYLyE/o/+wzgUrR7aUJyoqo7MmXfp
 1dedUQz0am2S0VwE4VlA1CDnUD7Dzpdzu1NIKSI536b8enp+KxF1BSchRvFjkROrjBRn0nU7Wlo
 O0QgGpa6CVGOccc04MUb5NmwC794IdJqn/NVtF3Lfqn68BOWtK/K+IaJM8Pkrp+xR7XPwkwrIqT
 TC2GDqgb0Uo+eZfvk2XRilan+5QIht+8nVR14g+WafO+12KVk/grd6RA5cGz8e6jh4s+DrMnMZv
 9l3tPqhuXeydnsy6uCjnMYp7ha8qAZi/RWtamibPGgQh3k9UcyHFNn6a4Ir9wJAwTIDepfGdIqI
 gKxsvAOLxmtDJrpS4YQ==
X-Proofpoint-ORIG-GUID: 2bZBhXI8yiKR_6yGsXxmdXaB707qMwpt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This allows to use a forward declaration instead of including
system/dump-arch.h.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/typedefs.h    | 1 +
 include/system/dump-arch.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 2344c92182e..8fa7f752dac 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -28,6 +28,7 @@ typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
 typedef struct Aml Aml;
 typedef struct ArchCPU ArchCPU;
+typedef struct ArchDumpInfo ArchDumpInfo;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
 typedef struct BlockBackend BlockBackend;
diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index 743916e46ca..7165a5bbd03 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -14,7 +14,7 @@
 #ifndef DUMP_ARCH_H
 #define DUMP_ARCH_H
 
-typedef struct ArchDumpInfo {
+struct ArchDumpInfo {
     int d_machine;           /* Architecture */
     int d_endian;            /* ELFDATA2LSB or ELFDATA2MSB */
     int d_class;             /* ELFCLASS32 or ELFCLASS64 */
@@ -25,7 +25,7 @@ typedef struct ArchDumpInfo {
     uint64_t (*arch_sections_write_hdr_fn)(DumpState *s, uint8_t *buff);
     int (*arch_sections_write_fn)(DumpState *s, uint8_t *buff);
     void (*arch_cleanup_fn)(DumpState *s);
-} ArchDumpInfo;
+};
 
 struct GuestPhysBlockList; /* memory_mapping.h */
 int cpu_get_dump_info(ArchDumpInfo *info,
-- 
2.47.3


