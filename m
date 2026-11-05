Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D53606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j/Jhseq/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T2/+Ur/l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOsIY-0003DL-RR; Thu, 05 Nov 2026 02:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOsIV-0003Bg-3W
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:54:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOsIR-0002gc-63
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:54:10 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56V3MM2588427
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 07:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=cpxVBSNM0G2btBoIu0HQpJ
 9+iOR3TaxeS+N+lyxReC8=; b=j/Jhseq/RtrJUUrI0oumM3G2I60pCyaNK8K2Xi
 k+WMNpRbBPCH4o9yhieroRCeoT+beIhEHsSGAScDkP8/iZMyNK4+PT0NpXgvaEOi
 FeXVk5vZ0vbwTveVb5ebV69STsm6cg4S5JNwRl79HYzxswT6J+yxn2SEmZZHEqPq
 CUx7jlpPwFhuWn1w7/5yzgY763EW23TNepw2vsyG00fC+jmKYiOUolEoeW7b68Md
 zUWfkJ17m6UZpPuG35U8NOY+YlYvCZwiXtZfD8CQyeFN1rkCP615u1P9uLkGDD2M
 x0G6S9qBK6xCxkPZVT8owRfsV2cXkT42RMDD7C/bo1/SQVig==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr89subw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:54:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3adc5b185bfso1754565a91.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 23:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793865240; x=1794470040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cpxVBSNM0G2btBoIu0HQpJ9+iOR3TaxeS+N+lyxReC8=;
 b=T2/+Ur/ll7nKtxcsi1DEOR1GfOqT5GKEP9S4D4ci/nuxzUsRFf7lGpD4jaYx2nSXfO
 AS19cOKrSSZsus1iuah5kRJRgKzhs/Hl/rLD7gRyp4eZhrgOmSK5qNysU1nbhaSv1aTT
 6U4ZESVpmAy2OqRQTO2S8sOB6Ws2BkEgff1BLev5jfzd/od1L+/lpMlZl4uOc5DMfHOm
 AZgTVLKXmFjNhxyAFhvpT4tU7UE95fjoiRbnErphjMS2WqpQmdillZttD2SiYCzQnn3E
 iy1ohj6Id5dlSEU9zC4OoRUnLGCy2irBAtj6ov9CsWkRte76iwIi/obryMMpPfCgUqiU
 c8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793865240; x=1794470040;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cpxVBSNM0G2btBoIu0HQpJ9+iOR3TaxeS+N+lyxReC8=;
 b=ENMiBbG76MhdCjRJLGGVVjzvQKbTxEv8Z/0p1SIX//WlcqoV43GXX05jLN/OVbkgzL
 I48K01nu7ULtrliLErO9H1pVzdsZlkssde3XLNlQuSL3Ww9BjqGD/M82/FvSRBtdZtl/
 m/EkIzG2wYjSWySeeRAlIvcXfQVTK8YOkj3wRnTdXQPLN3rSeTQBiwvj5ZMi4DYeQfgr
 qGaLD4rfrFr6VaUfD7DYFxI2E2cwXk6N/dq9Y8udMY1dSMmvmvDscWfpn0DKOcmyjjsH
 oSnYf2OWb4aFECAX5qanwldHkJ0VrP77RqYDQLY3A3BrPQzXDHDwtmgiWLvXu7cClPD+
 P2Mw==
X-Gm-Message-State: APuU4Z9dG0D8SIX8CkaG2bh2fkzu3LpN4+jcH06AZ+ERI3HQfjiENWH0
 E6uHswwiT6oF9zyhzniC64BCNY44oxkcQTghQmDZ3Uo8sGSFb2OOx8P0U7raMvVG7nE96kdA9h6
 kfldL0zxnTVWsMKi4mlva5Od+dGYKQ3YQK0z758e2IXKH2cjvEWl4mpOtLVfpPFJwpw==
X-Gm-Gg: AYBFou0jWMJ7P4sjMmG/s+6JWtfnZjoTl8E+uQSDOnnSviIo1UYksvN+sKLSd8YeIJc
 LjUVq2aABr14u8j+Nkhuvg1BbNrrfMNrr6WU641LgJafflkGnbZK+XyPevEPwEKLHeO79zC8zmH
 u6lgIWtobeq4HMyZ6s8ga3ZA3LzwW5V5xCiFjO5kCtOQo74St8NyiwUAMbx6DYDo6/SiU9cwhfo
 VVKbyeZ5ns5PDNDDz/oaGsA7vjvLwOtJ0Z2IJbuFKl5tjlwzskusL/FKrMx0nqlAHivW7RYty/l
 dtBELXSygIpB5VsMtFOKU4XqSBgsJq9QiLW60x3ZiSG98a0JwsIAQJr2uQVLd2LklPqpJ4ISbXk
 gVs20wI98GG970Hf8BsVe2iCHn+OMxhjJlbYETbhC4q44KT+zvGF82mb8ryfyU328KgM2781Nsw
 qXlJbV3IOfqfAGr6o9hO6EW+uMQ12SDG8FYs9Y
X-Received: by 2002:a17:90a:d803:b0:3b0:9a0d:b825 with SMTP id
 98e67ed59e1d1-3b09a0db95fmr2782265a91.45.1793865240390; 
 Wed, 04 Nov 2026 23:54:00 -0800 (PST)
X-Received: by 2002:a17:90a:d803:b0:3b0:9a0d:b825 with SMTP id
 98e67ed59e1d1-3b09a0db95fmr2782251a91.45.1793865239866; 
 Wed, 04 Nov 2026 23:53:59 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b31d2b5esm2615769a91.15.2026.11.04.23.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 23:53:59 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 brian.cain@oss.qualcomm.com, Justin Sapp <jsapp@qti.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2] gdbstub: reset supported features on Supported request
Date: Thu,  5 Nov 2026 07:53:46 +0000
Message-ID: <20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Jd0fDi_pnk9I5qyQnOWS3jou0f9oG839
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMSBTYWx0ZWRfX9oFCwIIHAKYX
 taSiw40FWi4mtbEHvp47opsYHN2GWJ7os/csmZeLC3RLEPBGPSD789C9uBQFLUpcnVY+Htim1gU
 VkgbVp4/7RoA+xoPYeBeUf9RewRpArYx9l9HH2MfxbVW7GVdHRt0YuaBIkKHn6Qa1KRuldDYlGe
 Cc/ZUVhrbzIDKI0XJuAO+3dbj/7DV+6Di4BvwIjKG2UvtO8y+dfT+7SDNdz1zB7KOJu3S6n8Atr
 FBkNDLXeQSkCQpRW45B9UdycarqZOcqAxc1RXeJEdbBYHmDuzR7Qb8DvvhnaXIvT9PPqUig8O0w
 ao+okI3Bfc3bWzJaqGQfgFPyyj4h/Wvp/1LueWeICWYw8/MJDYyKjsAFpsDiUvF2u/PWo8nQbdw
 a7PPVKkh7QA/fg46QsrbWBsxwmcv7AFW+2xEKMOZNb/atUhf08TLMYDmAF/9+pipyl1+lMQp9lm
 icL1OB+nu+o0gR7giuQ==
X-Authority-Analysis: v=2.4 cv=N628hG9B c=1 sm=1 tr=0 ts=6aec3619 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=7aKUdkNyXzSyLjutrE4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: Jd0fDi_pnk9I5qyQnOWS3jou0f9oG839
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMSBTYWx0ZWRfX3Sb3k6e5/Ni/
 WzuApIir6gbFYw2M5Y+6mkG9NEgT0GSstHukhpZbuUZflS8Z0tIYLTgISMMVwVuOxoEYc4SsurK
 1UQyadDdbvZO9YM6oQLPnUmOO79yuNs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050031
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

From: Justin Sapp <jsapp@qti.qualcomm.com>

https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
```
Whenever the stub receives a ‘qSupported’ request, the supplied set
of GDB features should override any previous request. This allows GDB to
put the stub in a known state, even if the stub had previously been
communicating with a different version of GDB.
```

We exposed this by connecting to gdbstub using a gdb client first, and
then WinDbg (EXDI) for windows kernel debugging. Since they both
differ in their multiprocess support, this was confusing EXDI.

While we are here, fix the same for fork_events in user mode.
Simplify control flow to always call gdb_handle_query_supported_user.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 gdbstub/gdbstub.c | 15 +++++++--------
 gdbstub/user.c    |  4 +---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 0a328b0dd48..38fe56a5d36 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1679,6 +1679,11 @@ void gdb_extend_qsupported_features(char *qflags)
 
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
+    const char *gdb_supported = "";
+    if (params->len) {
+        gdb_supported = gdb_get_cmd_param(params, 0)->data;
+    }
+
     g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
     if (gdb_get_core_xml_file(first_cpu)) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
@@ -1701,16 +1706,10 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
 
-    if (params->len) {
-        const char *gdb_supported = gdb_get_cmd_param(params, 0)->data;
-
-        if (strstr(gdb_supported, "multiprocess+")) {
-            gdbserver_state.multiprocess = true;
-        }
+    gdbserver_state.multiprocess = strstr(gdb_supported, "multiprocess+");
 #if defined(CONFIG_USER_ONLY)
-        gdb_handle_query_supported_user(gdb_supported);
+    gdb_handle_query_supported_user(gdb_supported);
 #endif
-    }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index d810f0f38c3..6526200a360 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -701,9 +701,7 @@ fail:
 
 void gdb_handle_query_supported_user(const char *gdb_supported)
 {
-    if (strstr(gdb_supported, "fork-events+")) {
-        gdbserver_user_state.fork_events = true;
-    }
+    gdbserver_user_state.fork_events = strstr(gdb_supported, "fork-events+");
     g_string_append(gdbserver_state.str_buf, ";fork-events+");
 }
 
-- 
2.43.0


