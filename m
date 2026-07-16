Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1AEC44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkSDJ-0008MY-3x; Thu, 16 Jul 2026 15:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSD5-0008Ia-A1
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:57:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSD3-0000Hm-8s
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:57:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJqLMx3853414
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tQsoVK9o6Jn
 TY63k0CBWn27eVPOf4mepjUp5pH7gZzc=; b=ooDgUEK7xaEQgJxPdGeyL2IlIr9
 okJqPQjuyV71vtydAPiYwgiGkeCJM/PAEM2EjwMcL+YkYW8eMCN17HOwtB56LZ/H
 RTsNDSHqANvbDJC2E8kgycRgBwGaMhO/8xc0NOGdRH4AtgwpfCS7I8SB2zMFMDZY
 2qr2hDPtIcZYD4/OxWI8N4uoOeG+QIGGReVrUlkIV7iP/Gh4emLIm0D5QgXyWfVN
 nlMdrvVMGcQ0tHfTcbw+iNlaU93czvH2+yT29Nbf6gYLSt+uHGWkjlQC81rvozBB
 P1ddI9uqa/2XOIU+NAFRDBeg2vPxCNhljukOQCAcSXGhi1Y42ZqARiHAElw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym19vhh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:57:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cf1c86963bso5483185ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784231847; x=1784836647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tQsoVK9o6JnTY63k0CBWn27eVPOf4mepjUp5pH7gZzc=;
 b=kX0auGpoukV57Y4Ek8f/byEAElymTAtLaw2WEfm+tTE+s9QbBbSBRE+jdVopAUcObA
 vkLWa9Zks6JPM52heOzl8/agxFt5h1yK2p4OnIoOV/887IQbl8a5GjeT4CzTphcjhJSN
 eQUZjfgQ9aao4QiuyLu0WlbL0IUTT5iNMEgVtyzTjstgt8VRCxziYONg48SoOSQAPpb5
 DTEt0ciVqlopLSRGiKPp+VBvDdxBYvIp2kuZiJqq03BCyKX1ScAgBrBGPYWLDDbs/JXS
 sn71gkC1TNNJInAWLgW2yrijpBeu+6p/r1yOvpjAghePiozCWarOPucVHS8ZVyBq+DTB
 ehJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784231847; x=1784836647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tQsoVK9o6JnTY63k0CBWn27eVPOf4mepjUp5pH7gZzc=;
 b=Pd7QyYMVV0Ibiz+X0bywnC1HEeJWwcVPcr5ZbfA1LGI41ap69BpxpOIMV4uR6THBem
 eG6MWaMQjIPqNZlwKpx5/Te3WJY4U2juWehKHMH0sDFmMpN9ZfQHMZ8G/O2QKfg1LCbf
 a+XuteSA7+U4U1D4NILQazRcapK0GfMxTHAy2FgaChUKtJPGoZ5WuEqWg2Nt8lecWN96
 OtjwXedatH6Qhx9dk9QIl9I9pwsW5GMaudzjXqZcxMrilt8D1lYnzcnbKmk2yz5CV5mE
 peRBzAQVNv2mAv3HgZ8ic5m8vHV2rZMitwrZk95g9E8LukUFgnlMs1NVd1/6BbCB9rb0
 g3aQ==
X-Gm-Message-State: AOJu0YxWz5GVOg9Kca9G0BNv7bSJFkwdg8zC5ZA0UAWIVYOQFFI/9oIk
 RaeNDCgRxcsCWDElyARw4rVKqHTFhk8GkncBV3CCOFtL07e9K8po8OiD7TqPaUJ+hDcij4P8ED9
 C97Zo99ODN92TH0xKOmXSkfiI0JWU3Fl7gg1dNGNjwwPaYt44H1WJhrxi15SBI309aQ==
X-Gm-Gg: AfdE7ckCLT6Lzrl6rmwjLb6DxVJsZZm0B/R6dBMOHeC3FcruGduCd1+Fe0FKfHnAsqb
 XAkEt2GKWwxlopjFcTWs4nY/arCLFEJVxAEXxQNAgXz4nryTNW7qlckTp8w9bJUJA+crWpqOvtu
 yjFx3eSTBmZ/BmwFbLM+GC/SzQjwdkoNzAAyx0rDS5UxRkeVM5mfk6SYb+1g6YDfguSwVNA07j3
 8t6vwp+bOC+q7I8L5BpiEo8eW72i4e8UG6lXU6KtxPQoqU/FQmn3INpoff81B1qN+SOR/MJiR5m
 qojralWSdwiM6dxjNp43G1qykX1tMOEBAmb9VQd7STsD9nDsn0Tpzv4yJCSd+2P6Ty3XI0pEmWp
 KY+Jig/Iy8Ja73uJekKCUQAbF7MTCy1Z+h3urL28LzWY2fkBwONTz4t5Jrgu9yiL2mlLL71k=
X-Received: by 2002:a17:90a:da86:b0:36b:4d63:4a93 with SMTP id
 98e67ed59e1d1-38e3d21fc15mr3649106a91.13.1784231846635; 
 Thu, 16 Jul 2026 12:57:26 -0700 (PDT)
X-Received: by 2002:a17:90a:da86:b0:36b:4d63:4a93 with SMTP id
 98e67ed59e1d1-38e3d21fc15mr3649073a91.13.1784231846189; 
 Thu, 16 Jul 2026 12:57:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6a5174sm14494672eec.15.2026.07.16.12.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 12:57:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/2] plugins/execlog: fix execlog vcpu_exit execution print loss
Date: Thu, 16 Jul 2026 12:57:15 -0700
Message-ID: <20260716195715.3218862-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260716195715.3218862-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260716195715.3218862-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a5937a7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=OZcmDFxvAAAA:8 a=EUspDBNiAAAA:8 a=a92uN-qT0L5WIk0CFmQA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwMiBTYWx0ZWRfX1hSu0trfrgkQ
 O5xvIj3FJ5aANwz5O9Kzck1qfvSvRlwdkLuFxvsJFoYES+R3KRdf9AaO9fO8NchW6nYDex5IbOZ
 wxgyC8bsj29DXNWs+Lu5rWf5jeZCedtYwZ2nd9sw629yjWKuAd9rCF9xUqt0o2erYTglh+OU4GJ
 Yjte5c9XSstLEDh85FobjfR2DrnXR8e3ta+WAD5+q23s9kpBmEwCu0dyD9o1Sx15RRDfOogMZhu
 Z+Qv/3lde11JqeO3Q8n3+3cSThVPUvPvr/cIIS8x8cMOenFlxdoweX4tuzsnhJBiuOJ9w5pl249
 meMVG19fXnH3Qr5J0ltSAFW782JlS+edWJUv54igb4pb/k8moQ5DhRAt/b15jdmrmS4ILYlh4An
 B44MzLp+8RNWay4IW8a0PE7JKAjfAJh3YBOddOtW+gSvLKVSKKw6GyKps/FjfNYI0DSKgvmULMD
 Eoy+JnW+6zYQGKYAblw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwMiBTYWx0ZWRfX48+UHzfCGdvy
 +2XaeR3bArbBa6G/nVWMEgbgSaWxZO9YSC1PdrfFz26KAopaUJ3QKJkhcORqN88Ijk7n4BfYTdD
 vf4L7TaVwDM790InrJtqkt8Bfq0G+xg=
X-Proofpoint-GUID: E488pUq4xJ-S1OnzsEv8IDDlc5zgSIPk
X-Proofpoint-ORIG-GUID: E488pUq4xJ-S1OnzsEv8IDDlc5zgSIPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160202
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Harry van Haaren <harry.vanhaaren@openchip.com>

Executed instructions are cached in string format inside the
execlog plugin. These strings are flushed on exit of a TB, improving
performance. This causes executed instructions to be lost when an
'ecall' (riscv system call) occurs that causes the thread to terminate.

The fix in this patch registers a 'vcpu_exit' callback, and flushes
any content in the c->last_exec buffer, to ensure all instructions are
present in the final instruction log.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Harry van Haaren <harry.vanhaaren@openchip.com>
Link: https://lore.kernel.org/qemu-devel/20260716094126.787556-3-harry.vanhaaren@openchip.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/execlog.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index dfe00bf836c..cb0bd399d88 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -380,6 +380,25 @@ static void vcpu_init(unsigned int vcpu_index, void *userdata)
     c->registers = registers_init(vcpu_index);
 }
 
+/**
+ * On vCPU exit, flush the last cached instruction for this vCPU.
+ *
+ * The one-instruction-delay pattern stores each instruction in last_exec and
+ * only prints it when the *next* callback fires. When a thread exits via
+ * syscall (e.g. ecall/exit), no subsequent callback fires for that vCPU and
+ * the final instruction is silently dropped. Flushing here guarantees it is
+ * written before the vCPU is torn down.
+ */
+static void vcpu_exit(unsigned int vcpu_index, void *udata)
+{
+    CPU *c = qemu_plugin_scoreboard_find(cpus, vcpu_index);
+    if (c->last_exec && c->last_exec->len) {
+        g_string_append_c(c->last_exec, '\n');
+        qemu_plugin_outs(c->last_exec->str);
+        g_string_truncate(c->last_exec, 0);
+    }
+}
+
 /**
  * On plugin exit, flush any remaining cached instructions and free state.
  */
@@ -461,6 +480,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     /* Register init, translation block and exit callbacks */
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
+    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
     return 0;
-- 
2.47.3


