Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12224606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UDQMDXRi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XbtkId9w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMuyz-0005Lb-V3; Fri, 30 Oct 2026 18:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMuyy-0005L8-OE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:21:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMuyx-0005B1-5z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:21:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtL0V4185873
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=XI5kjKnD5bW0Fep7EK9uqD
 GDE5nlAoHZwOJGW7ShxIY=; b=UDQMDXRicAtRVmLhC6bu8DEQq4/GPrtAmoR4yZ
 CYYTFImYX+fwd8SvjoEPydXwvkxyM4X7jlYyVoWlA2gZwzEimkGnF6y+JNukYY1C
 rjfsDZ8a287nmmShUBWTab+kBj/HqkHeELRMcNEUmXl2mxUibqnLnal5Pdv+n0BV
 mvIvFsrLD9SqN8qrgXLopQJLJ+r5Z47FRdqpeB5J6/XE9MmiImxZnZvzNAUBOq4/
 Q8fuKIPQFUTzt9HnVgRBANn36gBL+E8otpouN/wmzciT+qEfgUSodW0q9YHNvZY4
 K9dxAQvKLWb3SKib5F7fHZG0Wz2KnMYUg0BAJ65RN6UrD8XQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x108f6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:21:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2eaf3f829b3so12918045ad.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793398912; x=1794003712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XI5kjKnD5bW0Fep7EK9uqDGDE5nlAoHZwOJGW7ShxIY=;
 b=XbtkId9wm3D8FPRJ8g8tyDHonbRl3/MX/pM6SBnvA33Nb0le+YJlTLjdmbtYBoHyl1
 jTyGoyMsnIlwp8D5JvzC9zczJ9WFN6vdEULXE4rVMyyMUHazeQ3RS+Ig7b1oi9d2D47z
 MFzb9WtkGjZyQ2ylDigjDSIKj/++JtNfy5NL2l2exvzTz3pMtCOqFnrlv2Bh08kCPpj3
 CRpqpYvRaCdS57yHmRSSkynEE37YQA0pIbc+4Jl6hOv9mbwdnxn+jwc83bb6XZQw3aQx
 VXs3YWKVmOsnt/ji88Wr8fuPmYnbfO/aKwAEF8hNT9y6Au7Ha0WFpcHDDA7uxASDkmuk
 2grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793398912; x=1794003712;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XI5kjKnD5bW0Fep7EK9uqDGDE5nlAoHZwOJGW7ShxIY=;
 b=idMK5bJ/CUaR6WU0stlnd8ryvJeBe363EkynSvEsQm4hEDMR8LkkQQRK41Too3lAt4
 surHT4Wu9+IEd+i9CdPHbxuCjblrvVTd/V6oXx6CVjFqH1rNGjJ4nUJ5ftAsboMqGNgn
 fZ9oAkHhwjtpQKIHuorEMPwy3eCGFP+l58vmGnR9Y2V4qnyn/G8AQgTou75D+jPGmR1D
 Hn16Kb0tZEIWkAl/SuJj8ieilLrQf5SzHY9SIlZn3TAPxWBUQ6ABKfI0N3OYfPQqdFGK
 IVgzYUC29u1bBSjzMcFTj6r3g4SlnCtT+jJ4Gevei42In2SG9+ND5uasLVRtIFwA48Vo
 PsYA==
X-Gm-Message-State: AFq9FYKDkGdwt/gX6m72xawcu2uAx/8JdbcqmW3tGi0J81TKBhskaJcB
 QyIa2t0CobxigaQxEaaH4yebNc9cBYuMrcKLziIfCdBFzEZHqxIWeigKAvhadzXG77b9HY11VvP
 6yo4MdSureXf1+ZxFxJxN5AAB2420dxKnRyCCLu+d1hSBZPw+HBCi8xMOJNv6RALEfw==
X-Gm-Gg: AYBFou3V9jXS5QiwXyB51v2vANuFDfOIQ2+sgB5XBma6ITDlKJ7Lsd+U05e9OAdsiYO
 KgM3FXXMvfTIhJ8gBPbKsBk81TrRufkKBIKG/LojkJ9ccs1PcP7y7wtGlI+oy3FJX50N4/P4Uat
 JH/thS2V92a+gHgZnQa4NYdVwstWHxvpBVy3D1hwluHX7ES8uu0b5mgowiNpua3abKQSr0cs+KR
 NarCGSuegbIR/eq1lL7zVa4BtF9ExMi0M88wBRFw6OgpdNpALw87rnUYp3b9shYlp1mZ1x+58F2
 Xy7BooXGUs8SzwwJFkluAQQn+eqGsxWUoX0w7YQlfsEAoXYObcWk5qiM4vHE49F2jlHritj2hgp
 Vu5cYlUmtfuZsWKh5pdd2tQwHiRJIKjwaOWCoGjWoHnI7ZTaNX/DrliBZGuvUl6afGNu4h/a9yO
 bppwzmy3w1rXKws6/MYcP80c6xPaqcTbXjpwGc
X-Received: by 2002:a17:903:1aa5:b0:2e9:5eee:e085 with SMTP id
 d9443c01a7336-2eb3642fe71mr31966215ad.19.1793398912289; 
 Fri, 30 Oct 2026 15:21:52 -0700 (PDT)
X-Received: by 2002:a17:903:1aa5:b0:2e9:5eee:e085 with SMTP id
 d9443c01a7336-2eb3642fe71mr31966005ad.19.1793398911788; 
 Fri, 30 Oct 2026 15:21:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3929087csm11978345ad.57.2026.10.30.15.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 15:21:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Justin Sapp <jsapp@qti.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] gdbstub: reset supported features on Supported request
Date: Fri, 30 Oct 2026 15:21:46 -0700
Message-ID: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pOGijmveyIdkpqOr_k7IjoxR1nS6W617
X-Proofpoint-ORIG-GUID: pOGijmveyIdkpqOr_k7IjoxR1nS6W617
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OSBTYWx0ZWRfXyvMPFCkN9U7C
 cF6bf7KlhOjBudjt1qmr1XN1gNfmZ/siZ1XgzxaTWa7zOKJz4K/Uo0eVXctcGqVhgIlkjIN9Ld0
 bdYlptN7coaHFcrTWTo11RNSbl+hwEs=
X-Authority-Analysis: v=2.4 cv=abD0Dhot c=1 sm=1 tr=0 ts=6ae51881 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=bmN3bfNZrZQGJJ_IUdIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OSBTYWx0ZWRfXxj2CCjFan6Eg
 zj2KE6Bc22azslAHp4uZtzurn1N4n4x2N0NI32XRPM58ejjb35eJ5/QrQBc6OKV9YS2iKDabj2M
 ak6X4jYTcgjslPnoRLT2TvjqGjxhFi2lpbiqoBC6hRA98k+JlKnh36jDbBfATna1KTZmLLixG73
 Wb/iYRH09Qw/Ecsz1ytEaPI+XfSZtMzSmpN2sNvqiQ9q9/thlqh2wuiJP9ZcH+2+k/1wQJvlSdS
 ycwmrbR8YfqITjFpkZeho+h0P2WhXd3yppogvm/Oi+NRJUujHLkVQOxpqc99EyZAfHzThnTsvDM
 B5VXnH9LgBKObCuo33E3FL7MQFS30Er6eUlehj0xQ+64+WZVSYo0ZWSACsYqlWGXwzFfUNIsVGr
 AHA+ERbVIj9YkIqsh1ox39eVH+0nA884HnU9ivalPFqhh7f7eVJo80zUpH3NWo8M//zXdMR3hnE
 7GhNelrFr8KIWBuU1nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610300089
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 gdbstub/gdbstub.c | 6 ++++++
 gdbstub/user.c    | 1 +
 2 files changed, 7 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 0a328b0dd48..dbb2000c817 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1679,6 +1679,12 @@ void gdb_extend_qsupported_features(char *qflags)
 
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
+    /*
+     * Reset multiprocess support as a new gdb client may have different support
+     * than a previous one.
+     */
+    gdbserver_state.multiprocess = false;
+
     g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
     if (gdb_get_core_xml_file(first_cpu)) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
diff --git a/gdbstub/user.c b/gdbstub/user.c
index d810f0f38c3..9b6d42d210a 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -701,6 +701,7 @@ fail:
 
 void gdb_handle_query_supported_user(const char *gdb_supported)
 {
+    gdbserver_user_state.fork_events = false;
     if (strstr(gdb_supported, "fork-events+")) {
         gdbserver_user_state.fork_events = true;
     }
-- 
2.47.3


