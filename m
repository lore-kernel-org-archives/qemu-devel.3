Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F24606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mFJTKzor;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RkB16uy6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxKQ-0000ER-6q; Thu, 05 Nov 2026 08:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOxK8-0000Cu-Dp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:16:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOxK6-0001KF-Pw
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:16:12 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tiMF3532116
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 13:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e3N0JhSByvS1H/l+iwrRf2rrkc1z+/JxeWNW4NRNi7s=; b=mFJTKzorjw1j4FVo
 0x6wf+9c5WVQ0ICRNFMXvEhgQu+Bm9Fu2670U6YS8eKodssViHes9zHZxDRbQC8W
 RCiPMywEp8/UgFv4vgP77Cwu9hLwPPQeNK34v+dkiXPWGPMrNX7p6a+RMXymQ+s1
 M74cc4R94Z5/RSNdLuwUOrCCCbHHU+Nbp/CORhYCBxRJeQ1ft5M9WZjVJ7vaFxUM
 sKGdUrCvkWHUgCHFKHN+qTIag3Pkn5/OuGJOftLCHnEEAYjvJfiH4IuKY6RUuETM
 5vxxgAMRdPOY7EIZ2THxrv9wJHt/1q9oN7PmFAYWWX5vK1mHvxNcaFA48wEry5dB
 ifen5g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9t3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 13:16:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so358205785a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 05:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793884568; x=1794489368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e3N0JhSByvS1H/l+iwrRf2rrkc1z+/JxeWNW4NRNi7s=;
 b=RkB16uy66+Ak5+wddvobeMt1St9ihhz3TcKis1MPpp2kjatJz331iNy1/T8RzBpVQE
 4F/aZhSGoBXuNC5iGaHJD3tf0mlQLWkaRNT77boxQ9AHED74IGeyePo6x4MijhhhhJ51
 U8yld0bIK2OrIqbHYEDNTyCM1Hls8NjpqEtddPtlsxrAfEf97mG9TCT8I4srIjt9zP8c
 W4XPpe1+DlQ3/HmCKxhSt7nrQr/DkyiKUMR0RtmKIS5oNRQ42h2NzxCf4T63Vp4f/XEd
 5bmV+t/L96TIWlDRV/TdWuwgvJECcETpspSII7Yap2TZ83tajFgzSTdDVp8krcloLYWr
 5wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793884568; x=1794489368;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e3N0JhSByvS1H/l+iwrRf2rrkc1z+/JxeWNW4NRNi7s=;
 b=b0i8oiX6WKD62urwaH0VWAh9PudFn+VB9wOj8hbyhy0VRNep9Z6DKJcmSWZFiq7Yk7
 GaZ9p14R9GjUz4S/RT/U7DuXKgmQib0+9sAmnXkTIsx+pst+r5eq8GZYPJ5HWREfQfcE
 PTAGzNoo5UxB+IsDhabOR6px+eoz4qaO+p2PjAXctJB62J/NyjkFOrI8MdxgYFDYr+IY
 1En7cVVeaYTo/QO+fyqoYZfxW+cJE/VutojrTsxGvofO43Bl+NWAbdpJjx6KnN8qocjN
 PZH+X8FAzCnnjye0CjEf8+qty0nqGXUsqzGm48pgSaOuRlRxba6anGZt3tehmFau5W9C
 gz7w==
X-Gm-Message-State: APuU4Z8XZdfm+wfnVWFvxN+lzZ7QkTZZZzAVh13uqs5eduzHjMaA7ZRN
 B/hN/XNqOaZ0ysQaHsJ0d4n5eM4Q5AhkP+xnG1ZCwgeL3R9PTGntNZD5gX5M492YIca4Pjm4XUA
 hGU8WL7OddkjCKE90Ub0DbNhqZ2h/QXpNZWL9NgLmNquB+BP00UU+07xFxCQ/iwlZpg==
X-Gm-Gg: AYBFou1ukNE+5ED9if8bcIxqWpaLd+hYCsbgZRki5y3GvUncmkJ7oGVido2vR4KhglV
 RqBX+5HydkhmsmEr9ZltaAPR4Ssu6pKIa8hQh+M4HnC/NK2Ahlpg/vDQeCwFXC84r0mObo2/hlv
 pRsUwf0wRhjzo9BmZogaa/DCHg2iYkIyeu+x+LaZDC8/NCxLtCFahITxGEsQdpK39PjXPHe2VwH
 17VvbzcLOznZSYNArWJj8PYX7fnjLYtqaOm29hI1KgHatgFDIxPwe++g76VEhPjHInFXzwg5BQX
 K4bLQba9s175o408Ef5zLScmzUZb42hQOtdZijIeithKQTYKE0pGR7cHj3zL4JZnFhklgt6EBPE
 cRDoVzn5059m8IxMPUPbJB0+Q95jrUYw169LRYuHx9O0IgmYeEAsz8p4T/JMpVBEXLWPn+9yIx3
 tJdXTkltMYb+XUb41VWYMrVI5L
X-Received: by 2002:a05:620a:470f:b0:93f:5ac:14a3 with SMTP id
 af79cd13be357-944217217c0mr3280733285a.73.1793884568508; 
 Thu, 05 Nov 2026 05:16:08 -0800 (PST)
X-Received: by 2002:a05:620a:470f:b0:93f:5ac:14a3 with SMTP id
 af79cd13be357-944217217c0mr3280730285a.73.1793884567946; 
 Thu, 05 Nov 2026 05:16:07 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e48d3acsm168785266b.71.2026.11.05.05.16.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 05:16:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/2] replay: Explicitly require round-robin TCG
Date: Thu,  5 Nov 2026 14:15:48 +0100
Message-ID: <20261105131549.42175-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105131549.42175-1-philmd@oss.qualcomm.com>
References: <20261105131549.42175-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfXwUs7mwAn7TeF
 Vr/lmWzotaozQSi4MIZwirF1XRghQEBAARmiDtfeV0wUP1N1xZ/OMWTKijs8HjcwblifPBHXExN
 TYgF4z/b/p5DpNpb7ZPzLWcHPQBqFo95P0mYVtFrvfhYG+uUbHaDf7L4F2F2fh9p+GZWTL/uBFp
 UJgVQ3gru1HjxKlhrcdLBq5TkUNNYYNXcmOJtjM+XPv6IIWZt1eTHThV0hGOcrM2S40eEcoRURx
 lj5g921G2q7afPLzhWeQRKGtSdOpvthyNCRrD/ydhLrK+CYzPhdfeiSdrwe++NAH6OduKh7qEE2
 NTq1yggZSyXAYCzWG+Kr81ElbjAilyoJ/S/KuziqK2Je0Q4d4BGjurquy4bnBQ+D/GW+LokWPfQ
 /kr9DCDCPhWWnPwxGk0E3A5Td9Lf877yqmTC+5Z5PGtm9S931uasbW4aDHpki+NjUyKXNvxwTvL
 SroTGnNh4COX4TW2TrQ==
X-Proofpoint-ORIG-GUID: _qLqK3_XBuhhaCC60NrRYq0_KJz01aNx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfXyH6kLhPG3UCR
 QpHlxFtvIgv/xWPUDiw4op+2ScfLtkfts+DNgZwnZfwWU+2VJR0M1JfgTCEaeFoSEjcvhRvZlEP
 X9LzmKRruBLa97qz7Gnb3/iVM+4S1BI=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec8199 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rK-1C3BBwVyWgTyOwNcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: _qLqK3_XBuhhaCC60NrRYq0_KJz01aNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050052
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

Record/replay needs a single deterministic instruction stream,
which only round-robin TCG provides. This was enforced only
implicitly, through icount being incompatible with MTTCG.

Reject thread=multi in tcg_set_thread() and tcg_init_machine()
when record/replay is active, with a message mentioning record/replay,
never auto-select MTTCG then, and add a final check in replay_start().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/tcg-all.c | 13 +++++++++++--
 replay/replay.c     |  6 ++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index bbc733a7070b..6ffe04649072 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -125,7 +125,8 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
          * there is one remaining limitation to check:
          *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
          */
-        if (mttcg_supported && !icount_enabled()) {
+        if (mttcg_supported && !icount_enabled()
+                            && replay_mode == REPLAY_MODE_NONE) {
             s->mttcg_enabled = ON_OFF_AUTO_ON;
             max_threads = ms->smp.max_cpus;
         } else {
@@ -133,6 +134,11 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
         }
         break;
     case ON_OFF_AUTO_ON:
+        if (replay_mode != REPLAY_MODE_NONE) {
+            error_report("MTTCG is not supported with record/replay, "
+                         "use round-robin TCG (thread=single)");
+            return -1;
+        }
         if (!mttcg_supported) {
             warn_report("Guest not yet converted to MTTCG - "
                         "you may get unexpected results");
@@ -195,7 +201,10 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
     TCGState *s = TCG_STATE(obj);
 
     if (strcmp(value, "multi") == 0) {
-        if (icount_enabled()) {
+        if (replay_mode != REPLAY_MODE_NONE) {
+            error_setg(errp, "No MTTCG with record/replay, "
+                             "use round-robin TCG (thread=single)");
+        } else if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
             s->mttcg_enabled = ON_OFF_AUTO_ON;
diff --git a/replay/replay.c b/replay/replay.c
index 14437b32566b..d7d5ddc5a326 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -14,6 +14,7 @@
 #include "exec/icount.h"
 #include "system/replay.h"
 #include "system/runstate.h"
+#include "system/tcg.h"
 #include "replay-internal.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
@@ -447,6 +448,11 @@ void replay_start(void)
         error_report("Please enable icount to use record/replay");
         exit(1);
     }
+    if (tcg_enabled() && qemu_tcg_mttcg_enabled()) {
+        error_report("Record/replay requires round-robin TCG, "
+                     "not MTTCG");
+        exit(1);
+    }
 
     /* Timer for snapshotting will be set up here. */
 
-- 
2.55.0


