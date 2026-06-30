Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641EEC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegZJ-00055l-GK; Tue, 30 Jun 2026 18:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYd-0004Y5-8F
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYb-0004JG-RS
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDn112937324
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4afQmHo8cpFkcr3t656DgTb/EAnwe6mE3Xep8ewUoKU=; b=POHChKvgmtAcRdWC
 pvomBsUrTYNhJCm4GqTyidl2K73+2jGexg2ffnHdiPA59dGWdL0WqtpcCh+3M2pZ
 ixPHHUiaIbE6llxT81W+kRTKjtOBiuHhTYkA994ZLqM3dD+kLTtlHqi1jZF7rbIU
 FRSUvq6u4DWXUTnyibM1oijvBAx+Z4MBNQAMYT3kA7GJcM9xz0EW/sj7tASyQUDx
 dST8UGz+PowlxjQXts2hbjr39x2PnfqJSIkfSpzTNel/+L81Q2yuV/Y6Hd/XI/WH
 kNRoJhx2rktCBR96FZwmGacJwXhOtRIDeKY3ow/zcpdnCavKNzDhYOtmXzkkOAUA
 K2CXWw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0a413-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:42 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-967973f71fcso2595181241.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857022; x=1783461822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4afQmHo8cpFkcr3t656DgTb/EAnwe6mE3Xep8ewUoKU=;
 b=IMXwXmABZai76iR0tWtqS6OAi4aADjqTQFWbpefLnvJols1CcBzU9+s9EAzBlvEhX7
 IAVlUjFwcpYeI20PaCA/5/o7OduzuFZi825I9bLzCQRBeH0kUp+tKOHGpmyjvEHNMA46
 x/+kyeM6lDI5dTiMt8XgRyzw6iCMn8Wf6jkSWE3u2AC2QYSouiK+apbfkMZH0/ZcTk7O
 ojLoi9BSIys/7mXcuHd28pF84NCJ4uajnz3tuccUujCR+pJBhbaCc5f/OHt/8uGaEcjR
 /g7A1x2+AauplfknOiYgQpa2lw0IHVQMQFdsJ0KRoMzPyYfrLJs+L5hhqlf4gVv78lds
 bigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857022; x=1783461822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4afQmHo8cpFkcr3t656DgTb/EAnwe6mE3Xep8ewUoKU=;
 b=dylZ1bInzD2cPzzxw56sCf3h0yJdyZbVdGo7B8wR/+yZ40YZopQmQGAYp04B6DyXK7
 /z1kwtYFkBG/rsdhiWrt5ABf8tDOd0qr4PKiEvuL1NF6LgCrIQotDCHGFq75lFR9WWQA
 9geSSZQS8mYiRkdmvY72/ikqU/BFnyUEDsRIEdoSIFgaDqZJ+xogZtf3KpIG6m3agpOV
 3pfOnuU5teCfzbxFppKSH0allmO4uHdTJBew4Y4eIKyhs7QxLLxK/HpG839Bo+smLOCN
 yhmvkHaLlTUtcrwAb7GKBqnKG9c8JhAJ1nHZQCPDje16m5gejm1hqVTOD9pJM6sgWdFD
 rOzA==
X-Gm-Message-State: AOJu0YxeklgMYEy1npvZXuRmkMalQu588hHryHOGOv5UMP98XYj4dETe
 CA98NQ0nrjevVhn2QXVDrPvxaZzfWyxKrO7WfW3DPAzWdCZybs2PBqfSoYIpSHX5ZfJ7y02uxrN
 JjEfZDC9Gy1JuuTHFaVIE77VwK3ayE/SXY+WicdxtybIDKwBVMLond7ARKcoLIh3org==
X-Gm-Gg: AfdE7cnWi/LvyN7NJGysM1Zavb+pk5yizGG3ivvpP9yR2xzExNkuRcXgrMctTQy0Goi
 LdcfH9ARA1LiDfJs6M151enN967erjggT8w1FThzdqa3bbgEuVhrZSUEs2WlUBrgo0IeSPqjQkz
 4yQ0qsTruIRV12IPK6yBheh9lIdlNYy3pJHVhYectJo0GNP9W/+ayL2t9XY1osw6xip1jxrF0C1
 XYf0nT3+zNcDGWzjDU3NVEe2Yv1ZmLaHYv8q3V1c8Zbc3Oy0hS5v7ULGmLpkhDHg2uzrXbJldza
 UjEY6pJw0FHRoenciugwNW61ybVqmLBnFZibpfq/JiJk8QGcAJ13H+HoO3ay5BqirV3+YFPKq3u
 19qfuKHpkJrmP5s84XS6JafFt/RPzckX+pUECM6xUCdrMTiPTavEHMgcd6GBxBEdQQq5d
X-Received: by 2002:a05:6102:3581:b0:632:29a5:2b28 with SMTP id
 ada2fe7eead31-73cb8965054mr1529419137.6.1782857022074; 
 Tue, 30 Jun 2026 15:03:42 -0700 (PDT)
X-Received: by 2002:a05:6102:3581:b0:632:29a5:2b28 with SMTP id
 ada2fe7eead31-73cb8965054mr1529387137.6.1782857021344; 
 Tue, 30 Jun 2026 15:03:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4bfdd5sm43078185e9.1.2026.06.30.15.03.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:03:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 21/33] gdbstub: Reduce @type variable scope
Date: Wed,  1 Jul 2026 00:00:48 +0200
Message-ID: <20260630220100.1289-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX9EqmaCPUmdNT
 /4WXTB0kojVdFpSDTIZ8z1CE6+vqdZNkDPqwsLvyzyRqRC7xMWV8+ImKm5BK56Do+4B3aM/kIMG
 WUL9cqfK5iv0tCXUQlNhsWTbWMjj93VxuZn/p5vhkSNlQv5IV8MEGM8cBA8ECPT/9O80wF4C3ht
 HwNploxnfWsjWVKn4sqbxtOFhHKjYqirxi6nYDuYu/dWD059n9EKOk3wRFoe6fKLxoxfHOx/bO+
 t6RssEIk7GRjeCBoZKXvPIeiRc1LXbqxcLQ2yki8LMGvl0oEkK3OoXRWZpTbnM3aEg8zYshVhwn
 dz3cxhubb3b5W2oWBZnM4oEeTlQSITK8yBxAAJQAGWCy0cZwLYnV8tioZ/d/2zpLCkAztOP4xpk
 zPNhYiBPIam9mCsmPP5TGm/ZIxLdu3+3hwdgcA4T2kMCNlkZe8+lJhapu+PtcZlTQ//I9pQPGe3
 R3uViB5iLAFwy1clJaA==
X-Proofpoint-GUID: jUD3gWBHWZrBAkvkSxjwdBDPO8XFiotU
X-Proofpoint-ORIG-GUID: jUD3gWBHWZrBAkvkSxjwdBDPO8XFiotU
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a443d3e cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=hlJWfxa9TtAqEMqpIbYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfXx/TN8f3h6jXt
 Mhy/iuZ0fQqBqz3fBDXrccCuL2dlAnMdM5+Bh0vd7B1I2qR6TNuWQLY4aqVsNq8EMVzGk2NRb/l
 l6Uqb/nDtunB7w8LsPgwPGX7bgV5Bk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/system.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index 414aef431ec..d5e09802323 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -126,7 +126,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
     CPUState *cpu = gdbserver_state.c_cpu;
     g_autoptr(GString) buf = g_string_new(NULL);
     g_autoptr(GString) tid = g_string_new(NULL);
-    const char *type;
     int ret;
 
     if (running || gdbserver_state.state == RS_INACTIVE) {
@@ -152,6 +151,8 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
     switch (state) {
     case RUN_STATE_DEBUG:
         if (cpu->watchpoint_hit) {
+            const char *type;
+
             switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
             case BP_MEM_READ:
                 type = "r";
-- 
2.53.0


