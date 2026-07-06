Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926D3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgji7-0006q7-7o; Mon, 06 Jul 2026 09:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgji5-0006ll-2t
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:50:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgji2-0007Sw-UL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:50:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666Ax9DC391072
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zYdOdD4hbcBfRUXcyiGK2HCTv4qNg0oWG/XGXRvDlfs=; b=JTxFDAq/rjNHVo+H
 NNQ2bqCRabhZDb0MCz4p1CpaOQxMbbc6Nfy58Wes2hdXemY1gtlqvLUMyWyIao39
 MzswYgkYJv36SRd1yzJVZTIRvwNrBt8ihOtwo+bL5jtOn7a9JhyJXy5o6okAzG6b
 371Cy/fNav4VMu5nhP8aGnnKzRqKqTSL/AAf1Cv222mRSiCwjI4PE+6SZtjOssER
 fwl9GR9uIg51ImothirlJJjXNbXZX1uRVii5NLLtVpjjlF9P1C6OI5nrvwf0gcR0
 oU+TaiH2gJGsfYkgunrjqiLkz0K47d8saM9I0z2On5GVyo/su4XVa80264HjkutZ
 CFFL2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgs1pu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:50:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e66f9e2baso299347185a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345804; x=1783950604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zYdOdD4hbcBfRUXcyiGK2HCTv4qNg0oWG/XGXRvDlfs=;
 b=GSYUUy0K16DMlL0EFyvThQuSBRHKCzrC9MdcLj+Or6UZvC4Mg4TZD/GHqZx4RwDLfa
 UDpxlLOBYlzQVPjLB3eX1PtNnIzaRYvhYuRE2LkX+qyPqa3FmgVxsltmo7vrlo72gpku
 f9Zh3+e0gyEyXh+deyy5pKlZDZPDYWFVUQr0laPn36AcWQs3d6nlwsk5rGX2Iule+S8x
 zp4/3IKOmJYNSb2nswkxsTBxG/FD3YQecn7FczLkK/CxrRHvaItEMjqOpkZquC0V3lOt
 b9uqOCeB/gyTq45NhpuMyFu13+7r/j6rdSaA9w4VoZaEimJAnWQ9rLOk2E94+2/zUxlu
 v8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345804; x=1783950604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zYdOdD4hbcBfRUXcyiGK2HCTv4qNg0oWG/XGXRvDlfs=;
 b=X812KVxJ8GN3Swu+sZixM55eb9xDwvz4EqXCle/MdD5qCSn5mGuTzfCxmW6RYV3+1T
 0DQSf5wFWnmvLzqU1Ta8AFfs3dQCVDrCWIktZt9W7DlYSu3AGWEzsjrN+5UZzuZOqxot
 nC/pvpNJlJTy9FChV9fZ2sZ/mkZ3uco7S0NDZh6kBZhMdbK3fbnSWMh4QQl90muavNK0
 ftKZhg5uI3cfflhTGGRVRpPmObxIZdFb3M9qs3hT6OUjbv/Hr8HjmyfL9tBp5EA6TixJ
 Caw662EK+80sHA1Pk0Dgnw3X5iEVVZFCcj5R+bZccUZQOmUIckzOkvILfZIciMefIi3M
 6HiQ==
X-Gm-Message-State: AOJu0YwjJn6gGHrGj4Ivpwt/oY+DEBM1YqFsAD+jrfsKxFQxRVpZI+Es
 Uc8mxKajWUF9o11tADymWbg88eZrvE1XbaWAmGx+GELde3YhYC+dWhv9sKQN8XFSB+y3I6JxXOh
 MSUee3hoJ+2wQqw6l63rOmBFri2OO9mT85pzbj6FCwLjwAcGtXgUm+8eCNGV9ShGBgg==
X-Gm-Gg: AfdE7cn8QxFJkRslx/M7o8Iue1+43gvVNJzjlWCOJsTeRZZ0JpTZzN7mlpPOazGNB3V
 zXqdYVtp3qAbs/IRzBLaZKHLIm/cdc/EtaJRKRyVOast4hFEWf+alLb1gpC5LhyZs2xaqdBfQnU
 SHV0tGKBi2K6xKVmwEh2a2xkZaCelpLF/A47PL71zGWEWDhE/pedJzCtnmGvCw8y57KulSgHc6m
 MPf4ZS087VuDSkSq71h70TlnYLp3CdE1MyxgDnZVhraAwwZ2N/ZEOFJUKOnWgdCJmuxfVUJFU5c
 tSfBIe0FUX78YmF6w+QHVL0O02dNXO1q/LJoQJPickSnHOzElDgKbbMQVT+W+zQzPbcKJaqVKnk
 RB/mtCu+3wmTroryIMfE4+ma8Xr1V7wa7pZrcJeF7izpWNa0odoZBrpCQlQ==
X-Received: by 2002:a05:620a:2950:b0:915:6453:1ae with SMTP id
 af79cd13be357-92ebb4a82d6mr91395185a.14.1783345804403; 
 Mon, 06 Jul 2026 06:50:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2950:b0:915:6453:1ae with SMTP id
 af79cd13be357-92ebb4a82d6mr91390685a.14.1783345803838; 
 Mon, 06 Jul 2026 06:50:03 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccd9d607sm358984745e9.2.2026.07.06.06.49.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:49:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/32] cpu: Better name cpu_single_step() trace event
Date: Mon,  6 Jul 2026 15:45:24 +0200
Message-ID: <20260706134527.84808-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B54HaDQNUJ0RARnan65jwWOGUvdyZfbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX/PwzD9kqGizi
 CZ5Be+1a6Fu5JUx3Q5aD6JqYqN5ceqom+QxG65AfrRKcqc85K0iPg3lQ1zGXdEYtkf0Hcg3VhN8
 dBHRv3tUZUbBx0Skmj4R6nPvHyTDb6p0i9B+H9fiZthc0+5IHDi6u7SExSY9HBvogjgvKoKOkGm
 0u2UUjfXj/9PuaSoYdJF9StLNou9ynZm0xZRBeGyrUpAFldAvVH3PVZB+vH3Y4RQjGaXMjW87r2
 XIR+eBCLIaNFz3OZR17v6zJ9iVFJeQJFyBNCxqNQJKDdAdZzkhxT2pkIleXcgKiGMxfFOlOnsVc
 CLS0hOONe7pns27meUI7WgCw23n86BNH7cri81XwAOzi+vqE3P+uF7B78f9eE70A0XxiiuEzg28
 tI3onSGj7r2+oc6LKRdaAliuAgliuI6th8Mj9HW9hFqkgqLgIG8/Yf6vKFSEVTul4Z7KyIL3W5t
 cuYYE4NHKkrxLOttMbg==
X-Proofpoint-ORIG-GUID: B54HaDQNUJ0RARnan65jwWOGUvdyZfbP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX9EmfjOzVjGoL
 Iy2UVO4iT662wEidG4HPyG/0cnvm8YdnPU4VrK0ul7OoMWTmf+kvkELDmJsi75ZdEihgsOMlsQK
 +0j35TsZeDGSFgpbnqfkYr1gfHgBq7s=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bb28d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=fWCg92Okmkq_k9tJrKMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141
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

cpu_single_step() is not related to breakpoints. Rename the
trace event.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260705215729.62196-30-philmd@oss.qualcomm.com>
---
 cpu-target.c | 4 ++--
 trace-events | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index f030e2c642e..019906b32eb 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -31,6 +31,8 @@
 void cpu_single_step(CPUState *cpu, int enabled)
 {
     if (cpu->singlestep_enabled != enabled) {
+        trace_cpu_change_singlestep_flags(cpu->cpu_index,
+                                          cpu->singlestep_enabled, enabled);
         cpu->singlestep_enabled = enabled;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -39,8 +41,6 @@ void cpu_single_step(CPUState *cpu, int enabled)
             ops->update_guest_debug(cpu);
         }
 #endif
-
-        trace_breakpoint_singlestep(cpu->cpu_index, enabled);
     }
 }
 
diff --git a/trace-events b/trace-events
index faeba6242fa..ea1d2b11a22 100644
--- a/trace-events
+++ b/trace-events
@@ -28,7 +28,7 @@
 # cpu.c
 breakpoint_insert(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_remove(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
-breakpoint_singlestep(int cpu_index, int enabled) "cpu=%d enable=%d"
+cpu_change_singlestep_flags(int cpu_index, int old_flags, int new_flags) "cpu=%d flags=0x%x -> 0x%x"
 cpu_exec_start(int cpu_index) "cpu=%d"
 cpu_exec_end(int cpu_index) "cpu=%d"
 
-- 
2.53.0


