Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E966FC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjhA-0005VF-5q; Mon, 06 Jul 2026 09:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjh6-0005Qn-N5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjh5-00070w-86
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxHXv395393
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7/CNwPThXA5iwRd/mCekZEsKWAHu5BWzhtJdQEGE6bI=; b=Ij7DsglQQoJltJmy
 SQof4cdRzGJl8uypAxmOVRCuSORqcfp6zZqWsgPCPNVPhLbBu4UKNswj/AzxFf/2
 LTtupd6/nliHEQew1j1cjVf7QlNKGrCaPgtZ439KFn+T6yhcSLZSPkC/uCIlGy3S
 lH8I/GTElTcATa5z4pw/tu5V6qrhs4wd+2ZzilgQtvOECGm2RpK3YFamU1p9KXhk
 Y2Ng+CmaIyv09QD2tUdDvdaK9FXPRu1/iQRWUOwfJ3AJs8Ri2UIlsS6+edlh/X0v
 yxS1C9cSCl8F4TVUNWvbcSlluCBpNhHniJfj6wK+cToPbPXPPHM5MCTa1Wzx5p4/
 BBXisA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qph0md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:49:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e8004d60eso486739585a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345745; x=1783950545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/CNwPThXA5iwRd/mCekZEsKWAHu5BWzhtJdQEGE6bI=;
 b=TJ6ZNa5yPBqrChbdwuOIiwm3MzvWyE9A8jIH+LWSREyy9STbuBPEtRq16AIEVol/rD
 K/CV/zao4FBH03SjY6tfVrz9rRp0CswM1pVPk1TsA3MUt5O0QpDOtZu9jxO7nyg642tG
 FkMuPd6QXmFCCpVDppAjnV35H05O3MAQjEbcKItNHlMUGSyI1rE8GrGiqKcTyhi008g4
 7Fq2MVGUn8VzvzIN/ExHByEuI6Ven8xbBc5Tk2W+hszIKOPtx7jbl9Rb24N7lIk0P42D
 G3R3p70WxdCQTw6vTmb38I80+ZxQhhGY6gy6iYwzBr/DMucihpI1+8MJHk3G3uX5wd0z
 oBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345745; x=1783950545;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7/CNwPThXA5iwRd/mCekZEsKWAHu5BWzhtJdQEGE6bI=;
 b=M8c+d97+Fzz+FgHyZgVct20zW0rdF1MTkun35HM7cLvrq8/zw7hLqMlpjAS9WgO6Ls
 +ZWtg3FvTNzmpMdzA8xnvTI4lSKheO0TkbRJHbWMiCtnaIB/bEJgJd/5+mWErhXQOT7q
 9rd2dIjQYDUQhoF59XrrIOzsJjybGKpGwyJTRFH4m3SReDXNlG82ytSB1dWIS+FOi9Xm
 j5MaZ5V78KoB3CAaUCnrTNaogj2Im6KFjyyTuYMQGs6wijZPznNA6/obdEFCXiOZFgsq
 bKE60IUu7FlHs5+yMTF5f12bSaj0AqrGUEIIzJfjpEZOaXYAbe8KJXO2WvnCOdLRKVaz
 3c9A==
X-Gm-Message-State: AOJu0YzV9sUiJe7FGJNFGSE44G1Z84vwtV6Rv+RBoTbtSvorgr33GU6I
 4xWkWV2oMFVxIHXbQDZ4FTDA63RhIGww/YMOD2m+hFLSbpRoRquMYKb8+Ft3oogepuotRZIUWjm
 WK6hn4DGGiMBDZW2fftGgTufPHa3sxUpXYc+fbX67v1z4VMdOxCxNVcApj8CAgInRHA==
X-Gm-Gg: AfdE7ck2QE9C1HlBIb234Sq82PahvH1udaPQjYXWgfu8yzAXGNjdT7XbmED8jkG1TA3
 0vEK8eBcs9IzomL84l+622GVkBxaKxaCHK8+Zb/kG8gLVAABSi0e30oyeiD+C5F9VaEzFYVoArX
 zwR5jMrd4AkhgAn3kSnVTT9bBiSg3+GWw55RFJN4tpIBW8ySw4OFN63ZlYo5yDjyIUI47SFPOj5
 OXn6/xtF784hG3QwV0P8xI3YDhNp7AqiY+IIAixqqEbZiOLiHkYN71RB+nVSUP7pRv4jAG1kvt1
 YZ9Z1mqyIEakV9nD/Uh3w7fVgrMl2Yrsuits3gporj+TlPh2cqzUl3jP4aEQOBxmDaRMCdI1yU2
 rjZMsDugdJy+0S67/GMEemHe21EKx6eB+27UovuSmUM5I/Hv0kl8FtQaxfA==
X-Received: by 2002:a05:620a:3711:b0:92e:76a1:96cf with SMTP id
 af79cd13be357-92ebb5db684mr77840885a.39.1783345745536; 
 Mon, 06 Jul 2026 06:49:05 -0700 (PDT)
X-Received: by 2002:a05:620a:3711:b0:92e:76a1:96cf with SMTP id
 af79cd13be357-92ebb5db684mr77835785a.39.1783345744904; 
 Mon, 06 Jul 2026 06:49:04 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfe7427dsm259610615e9.2.2026.07.06.06.49.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:49:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/32] gdbstub: Reduce @type variable scope
Date: Mon,  6 Jul 2026 15:45:18 +0200
Message-ID: <20260706134527.84808-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4bb252 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=3yY2QiCzES6IJYuWj7AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NDmVszaRCSM_XDXU9wCwNJEANxkFNaVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX9VBwbg3y655H
 h+tz75SxqVojJT0Peff+OuIlmNi9pa8xf0blQFSYM+8bkpV8kXnkfGrqTps45xLaKWwtrbitm9b
 ZIKunbetz/cnLa6yDwI9bqe+Hl3edB11WXjmVcmXZB5iV7GpmEauB4W6khAdypUMielAbofQoM9
 eGT69+07veg5/FB+KyV6Z/F6bw+rYF3kNthaAIzlDq5/4LDBYqFdADRqVzEUj+8tlW1PoITLNUG
 IS3/wWio7eyBkIjLK4OUOkDMx7q2y/0kURX8eNGLz2d35tKd7nbpvgdcprlCzTX001JQC2qgLR2
 GP/kj5FBzHpbnH/APEgFEz19BNPPXZQR2fT/8XpOpoeMJEENp+5xp9xW7H5AxRWh+4SkxMJn9f8
 7E5zA9LaxIFlgMe8oywr7T9luRb2rHzuA59RZWFggWuTBcsWkvyxekunK4DtT2kRzg0UYgsGQ7V
 zPx6fqH/xmpG9FgriDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX4dzMN02cb5UX
 u1GJxkndJ9ZlH+pgw35DMC1oUsxcKOj6iXXQcf71b/jnXPSzoouHeDQVCrdKRPEM/QIBKaPxseL
 HQ+G1gra92mSLxjYcwEZQnRq9YVm7V4=
X-Proofpoint-GUID: NDmVszaRCSM_XDXU9wCwNJEANxkFNaVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-24-philmd@oss.qualcomm.com>
---
 gdbstub/system.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index bf7aa1ac234..9c4bd8ebcba 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -125,7 +125,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
     CPUState *cpu = gdbserver_state.c_cpu;
     g_autoptr(GString) buf = g_string_new(NULL);
     g_autoptr(GString) tid = g_string_new(NULL);
-    const char *type;
     int ret;
 
     if (running || gdbserver_state.state == RS_INACTIVE) {
@@ -151,6 +150,8 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
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


