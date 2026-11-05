Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57076606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ov+gPuPr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kuJJ32a1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwxT-0002qd-3h; Thu, 05 Nov 2026 07:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwxR-0002pi-Dl
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:52:45 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwxP-0005iS-Uy
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:52:45 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tkfe3532147
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5UXcNGmS5KbYbQV9waV7/SQYrXFpJcsPAVVikvbV08U=; b=ov+gPuPrY/0aU1/c
 kRv+mD8LbYScbG5uGUOUkS8Zqb2fSJuldOAMMgskFu7HHfnBBpMQWG3yP7E6u92m
 2hVeOvhKmtwd607y+V86CnjmhpMzNHN1zMKI6L0/ynxb/gv13GdRr44kQqpufZqv
 avIu3VAh/U1Ev/SnBw6LWZGPtXQpIbErZhQ6FBrJYt+c0DtO/LssUzWcVRN4ua1P
 R7i7UcpEiijUTKg97no6uwURnoX1tb9hfxNg6XmKunW3ydSM2feHazYZQJ8N1Q16
 2Sin89bwmsBw1+AMIAPow9uJdC/1XOafy4JNyViKmV9fjhUXe6qrag1KbdFRRB85
 zFfUcQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9pyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:52:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f322ef7d3so420020085a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883162; x=1794487962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5UXcNGmS5KbYbQV9waV7/SQYrXFpJcsPAVVikvbV08U=;
 b=kuJJ32a1SluOhP28z/b3aomxlmUXf1XA/uXE2J8pL06Ah9n0eD8cjDKgWXaDu6NWPg
 dwYKRoOZRHRkVfYWvQayJm9ZoLy9mrDglvn+Jxd6yzJ7nbNbZRtdXJ0GY3h5R+KJziVJ
 ltN7NOlr4hFhguhhCzifOcHVR7kjOVV8t61Ts3mTtVUE7t8xVO0Ot1ciN8wzFYUidsy2
 JUqifrXD9jyuyOgcr5yOvshlFg7mhjhpJb6e8ImR11qZHZF/HMPk/pF9vt2csyKwHJig
 4vdM09Z6IH2pamWFj85vIZs+yL1KxU4ydtvvjhJ7/GHj3SjNepO/9a1HmPccEmIykQEM
 n6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883162; x=1794487962;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5UXcNGmS5KbYbQV9waV7/SQYrXFpJcsPAVVikvbV08U=;
 b=BW5sp6XRQSuHlsJGpTTF8VCTeNYCoxh+gxpXjbn/ejWC44nDOyrE78qVbiwMxZiisR
 IaTP00WVf/a86JvETuiTjUo5uJcQ5WgOG86btryYofYCxdUugFlmCwBcFFSpMmO83+Js
 T1m8ZO4WRjM4828SmkPCH8w++XlS7mO/xY34gCP75RD1NVygkjr15Lyrp2zjWvs/Kedb
 inb2sSMiL8JeEXlj4HnRItKUJRPnCBhhMqNE3w7ZFbzsIw3UwgC1dyBKvQ8OUr/gfBLc
 pKMYU3XtodUJHwVGnkYMcSjBZcjKJt4Z2Sj5j1hkQhWEFkm3rFhWnAdm6lHYWlC8jcvY
 3k0Q==
X-Gm-Message-State: APuU4Z+/FH01aCAF8UuWv2ade/DjnCZKnzhabK1heJcnuMcQ1B825Q/J
 rukwD8laKMwmqmP1XuDpBCzioL5HhxkIymVoMDC5Cr4LgZqTyiyljNRgPcbXuBEGpJHXGblJl+L
 Mwxip9htPQST9/IUo/Q9R7eov348jsBoZPcTk5uB+1BEU0zSCjiHfJ/S2oEnXWIyXhQ==
X-Gm-Gg: AYBFou1dhZWu4Tb1LFVng3ezxxVMjMJ9AlqZ7ahrqhJC3tLVyLvnK6MD527C2Xiojn6
 6+F17ZitWSiKmKDTmlY5/23maDtNcRWogdPV2sTJT/7C46zBbpwjVZbJbSXijG69YYj6F6TuvG8
 C0DU7LJAxEhlpiCRDLbW0L4r+uVBJFe02dql1PvKryhRH0W45dLnUbZfhSiGG5v1CizAtE6mmyX
 9X4N1YOXZ7my9d14DZr3JGokmbe9wC00LFEha7MiIvulwCjSAaqbKNs4Kfl6QJg8fFNj/lBnvrF
 2uwe/6laAicTmLqA/y6tulprc76eZuE6SLGxujLZUWI8NlQMFudN9ygck6wcAi63qjWRCFFknZP
 ijC/e8Cja81QzONnxgi+MnI92aabSAxXBgJaDVY2zltWf48RnA9kLMsKShitdW6kem+cfMPONX+
 U097QcfzvLvZbxK9YXxtAj6v+qOjTBXA==
X-Received: by 2002:a05:620a:618e:b0:93c:6e1d:96b4 with SMTP id
 af79cd13be357-944217b4de9mr2907608385a.62.1793883161886; 
 Thu, 05 Nov 2026 04:52:41 -0800 (PST)
X-Received: by 2002:a05:620a:618e:b0:93c:6e1d:96b4 with SMTP id
 af79cd13be357-944217b4de9mr2907605285a.62.1793883161374; 
 Thu, 05 Nov 2026 04:52:41 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e466175sm170613566b.47.2026.11.05.04.52.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:52:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 03/17] tests/unit/qobject: Replace deprecated sprintf()
 with g_strdup_printf()
Date: Thu,  5 Nov 2026 13:51:48 +0100
Message-ID: <20261105125203.40320-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX6MhBtSirVP2/
 NaSSW+FKQe+O/J4otX4OdB0br63oOUdvIAsjq3stNyDy+swPYPrZ2XnMMlDMTqOabPoworGkjlt
 u0MMxjykvQ9aXU3XOHhc23x6JuTw18enZZDzBzG+oTRZC89PuSxoz+ULFqIB/qF0/YmAdE8F/CG
 FJcxEJ0ixzJWvfj2PsdxMLSzjwJ5hhw0RiMKV28wLFulL6YZnBHLXrGKXi/c31gLWzkve0k7CcZ
 a3O3YavCBf8lx9KSsMinC78XC08+g1LxZpxVX9b3lzGOG+Mw8gsl8Axh7XXsvxFD+lrc7s4Spg5
 oTDWikcjpPrC8fOgr2AZ23x07FGH9WNCkxZJYN79cUgPrdqox+kwnSjsEphhQH+OI+sxVfcw97M
 vF+IPuQ/4pvnWEDmsGvhbpldiBRaNt1mb0o2UgmRS/dh4eUSrOXTPjHICJBrV0emwZuypwa0Tg9
 J4fjAuLGQnOeXvw/XHw==
X-Proofpoint-ORIG-GUID: yTC5lbpTQGmZAtkcX8oFEwWwEzgFwf8X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX8bJ+1sSmQMgf
 aYSf6bKRm7G0CRrRMEMrgVK7mb/rh+7+HsK2/BkMKCE8DklFzh0t9wmaBdNyp6privvILz8R02l
 36eh5lRF3BAQWm4f+eyk6k5Q4EoKD0I=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec7c1a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=zVUThsOvjO3iHk_fBEUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: yTC5lbpTQGmZAtkcX8oFEwWwEzgFwf8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
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

Replace sprintf() by safer g_strdup_printf() to avoid
when using Apple clang 17.0.0 on macOS ARM64:

  ../tests/unit/test-qobject-output-visitor.c:598:9: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/unit/test-qobject-input-visitor.c:600:9: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/unit/test-qobject-input-visitor.c  | 4 +---
 tests/unit/test-qobject-output-visitor.c | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index beee11db4e47..d4d2f7f1ee0a 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -595,9 +595,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
 
     i = 0;
     for (str_list = arrs->string; str_list; str_list = str_list->next) {
-        char expected[32];
-
-        sprintf(expected, "%d", i);
+        g_autofree char *expected = g_strdup_printf("%d", i);
         g_assert_cmpstr(str_list->value, ==, expected);
         i++;
     }
diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
index 3c47b28f6638..b240cb326c4e 100644
--- a/tests/unit/test-qobject-output-visitor.c
+++ b/tests/unit/test-qobject-output-visitor.c
@@ -592,10 +592,9 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
     i = 0;
     QLIST_FOREACH_ENTRY(qlist, e) {
         QString *qvalue = qobject_to(QString, qlist_entry_obj(e));
-        char expected[32];
+        g_autofree char *expected = g_strdup_printf("%d", i);
 
         g_assert(qvalue);
-        sprintf(expected, "%d", i);
         g_assert_cmpstr(qstring_get_str(qvalue), ==, expected);
         i++;
     }
-- 
2.55.0


