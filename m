Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50A606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AGaszOP4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fGBS7NFe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nb-0001w4-MT; Thu, 22 Oct 2026 17:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nY-0001sG-3w
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nW-0000Jf-E3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtSQX387578
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U8UwPDs+juTfssBQH2MQi2Ngaod1WBLExfA7b+3K6fA=; b=AGaszOP4ZKpBMxs9
 PgS4HbJ2F+8EgauTnpwBy+EcdMBg1BVswo6HMCSgX6grown5YaDUenmVZUVs2xbp
 3BIt5zVJfX6dDIWoybDnYGr+2BNSQhl2+VfPUkE1ThfzcMSO8zMGRB0rSntmVPSS
 N00VJ+bHv1De0RFc0vpnUxhHCeT6U9Z0+cyk6WBt+lPXAQMyHVps7wM4+hJs6UFK
 R8AYZrrczkxTqeEEqoaYXHJ1OgbwR7kMPS0x4oy8uNuof3uFFYHKT6yvp/7IPKfB
 E9hjgS5K/gLf4sGHAF1HqiMycOaVj1eYcU17MVcbPWHAMeAEiKYOqZfjFDounmJB
 d7dlIg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4rd6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso368536a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706284; x=1793311084; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U8UwPDs+juTfssBQH2MQi2Ngaod1WBLExfA7b+3K6fA=;
 b=fGBS7NFeh65gh5d4Rv9zkuYET15Si4pHUfR6Oo8e+5r+i/TK9KqrG394ZjIsUMLrCE
 NntlDqwUVR+TzNHKfGCQr9fGfs9qAtxNVo/ZO1YwPUNbdhL87pTVkOLoKOAxofRe+GyP
 fZcyIC97+hjGNi8GrC6ByBWxoPUuHLlJk63kcIIM/vAhHMKRFsZvvRftRmFApfI09jWA
 F5+CkaidNq6fz9Ala3bLnSezK83YDUdjC0qwiAi67SYaUmLBH3Qpfw+18Bqz0D0xt8zE
 8WdBJJv6fWlKhWOwVQuOhJD+jgEFFSHsGgzDzTZfGVxoASokCLdZY9tAFJ01QU0de7C7
 L/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706284; x=1793311084;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U8UwPDs+juTfssBQH2MQi2Ngaod1WBLExfA7b+3K6fA=;
 b=1hqhwD0HJSUUPs+4pxh/HI1qqLSPfa87LlLZDqHvR8VDvUCiYB69te+rmXw/KWQ6sE
 dSf7azgjCqDoSvKSuHN9xVIYWCV8+OW0Wvzaqr1BzzyoLxxOSeV+N6vdkIrkRkAW1OfX
 RvaS78XbdvyzIApZPrji2LjEjF/k2fwLt2sVhWvhTTF6H0umaAbW8WyCrG01ILXl9aR0
 lwkm53H/GMOh6qWqFxQ+l6qBm+pbg93XmWFaZUdGnrSJL+TFSeYIFIOQpIWPo1Io0Uff
 w7kfzjYMvHkD03v24kvzgJnrOAV1NpDtSZHOhZvcGm8KUXssWG+jcdeTQcSsniz1D+93
 i2Kw==
X-Gm-Message-State: AFq9FYKRH+Q4s9jgfTihsJtb4+nn8USTtcXnzEXdw/EoXab00apG9VNV
 BwjOUU6t8dJdfWu1CnC5/7EIfHQYuEgOk0zciDqFuYgEvcfkYZEX7pPKQ0MUJlJNRW4aaiXX19x
 C92GgkirUWwfvZiUjFotXH+1/a9voBrN/fCjlvjHL5bESRDCi2P4dll1c4u5ri5YszA==
X-Gm-Gg: AYBFou39kYLJNL1ALhWJGg+Uj/XVNJZXXANxrXiNIBrjFhI7C4SNwpWjxscHb08quMy
 v1OnWfISLosKd0AAXvoZ6haiTmgRmXE78ZcXPOT1sKGdcylpit6dRrIZQ7CRHL5XNCvJjEq9xw4
 9fK5HAJg8ASJiDgnnjOjSmiZD11ZeikCM4lUj+63llXnDQyOb53FBkGfyd4kWaq2BMyuQlzks3h
 OBBlQCllaizXtZGfG4/RrlQz0obn/0RqrfP10I7793zGPId7/185bcpo6Sp9q2HzBKy/v6I9xkD
 sTWFQB/v2M9Cf8/R6nem8kkcLhIlsABvnCs97ethRDZW47shFl3fyziVw4mT7NEIla5oIpflctW
 c2T7Te9bp4LGg7scPX0HVwjrEVo53oqilhGm2TshWe3ZFBr0q7bC/WykRrXPhZiA=
X-Received: by 2002:a17:90b:1fcf:b0:3ab:afca:1d79 with SMTP id
 98e67ed59e1d1-3adce7a7ab4mr147347a91.21.1792706284492; 
 Thu, 22 Oct 2026 14:58:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1fcf:b0:3ab:afca:1d79 with SMTP id
 98e67ed59e1d1-3adce7a7ab4mr147330a91.21.1792706284050; 
 Thu, 22 Oct 2026 14:58:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 16/27] target/i386: implement get_note_size sysemu op
Date: Thu, 22 Oct 2026 14:57:35 -0700
Message-ID: <20261022215747.2479440-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HdZHUtfz6BCutx9UfvpykFeqYG5d2Nhr
X-Proofpoint-ORIG-GUID: HdZHUtfz6BCutx9UfvpykFeqYG5d2Nhr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXz7VXvHiicjC1
 mCY1+2PFQ+7JJlVVRlaXhMuBQcpc7v6loEDXwblKu+3kOkV6p0nUHY1zkKJszhOzZ65a3R7nM4s
 zDRjm8AaVaMGR8nHF3izTYX+MtyRm+Q=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada86ed cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=VkRzHO9NBAn2Hx42XgYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX08SLhbmLnyZY
 30PnP1Y2dTmPIGQ0JRwRWHvtOUnl+oYrmDHyQShLQ6ueFuOw81h0zyt8J76OjZf9ls35cgLdya0
 vsmBz7Sxkm1643Iuz2b4EufdsXEmyKTTkFn5ZWrEzUYpSB73syyC4fNsHA/w3ows6H4zMuVIKDM
 YiA+hFS510xztKjETfaoEOgIy85WNhiQ8QHV8tCll9+D/sXANctbAE3hrUFNezELC3xiSC5mn6y
 NpdpWeDTGctS37JByQQBSEPaqCwtgJYySxWdmYBiz5tP6BV16mUs1ejmXuiZ8baRuCHLCUe/d4G
 aYPzY6k3RM6y0Ri38UzaR/MfJ0IGgNBP4oDNDzu9LvwQw1MtlNPDt42pMfd/Q6DNHh2SyPrlGU7
 iS1y48zJYDyUZAJ2geyzcxLBZAPANq7XhAFm7xZfzBOhyZkqW4Uv2vHbGIZMKXNuEiP1EU98oXE
 qLrjij61RnZgxaElX0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-17-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/arch_dump.c    | 8 +++++++-
 target/i386/cpu-internal.h | 2 ++
 target/i386/cpu.c          | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index edbe99d3f51..270adb04468 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -428,7 +428,8 @@ void x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     }
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+size_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                         int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
     size_t elf_note_size = 0;
@@ -458,3 +459,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return x86_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 75bbd00bc7a..7f234cfd1b7 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -68,6 +68,8 @@ void x86_cpu_machine_reset_cb(void *opaque);
 
 void x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                        const GuestPhysBlockList *guest_phys_blocks);
+size_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                         int nr_cpus);
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49f453bb011..dd9cd7c5625 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10921,6 +10921,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
     .get_dump_info = x86_get_dump_info,
+    .get_note_size = x86_get_note_size,
 #ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
 #endif
-- 
2.47.3


