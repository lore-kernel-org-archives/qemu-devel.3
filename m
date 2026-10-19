Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074B606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HlDLGnTb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JYCcW6XT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIutV-0002sg-GI; Mon, 19 Oct 2026 17:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutC-0002kM-Ge
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIusu-0006J5-Tx
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK1Tf3627888
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MXdXctqen7bxdXW/pJcELTfyAg9I34YgxkC51jhk6ug=; b=HlDLGnTbVn+wmhHE
 TM0vbjJCF7iTi1+ngH1cTq5Yw5OENyGi2lZlkTUqe3VlN0tjuyeFpZbKe9hTF3Va
 Wh1xjZ7H4wo+omrywG2NhfrVLxbYyJo7j8hIvFFXOZkSGUgG4leCQgw6XS6dtX2I
 onl3a8mPAn0fES5o888Tss9LS/XnkKE4rD24JwBDGGbhkbRjkGY6Ue2C+6r5MzMG
 YOwCAb4yQ5mhRigR+i7Uon+kxHx2gqBYkyrAxmPYyvQpGPfbcyvvb3ng0iIvmTow
 p56KJeSgO/cfVpNTQaEWEDCOGf0oT0i8STlBg3SVSdEHFS6svY5NXihKKHeDwA4h
 gNRrxQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42gqgs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab27eb38d6so2766436a91.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445227; x=1793050027; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MXdXctqen7bxdXW/pJcELTfyAg9I34YgxkC51jhk6ug=;
 b=JYCcW6XT6G/WnAkK+4tB5/xXZyu+5+WjWINI3QK/J2uhlEpltVElCmcwsmf6X4HHg9
 TNpe1e5wF/xut8fgjcbqAJ4avjkXa06AX4l2wXpyXEGKMLyxOXnKNFRKB3mRUZ+OwGqI
 6p3QVEYkMXEF3FAZjAgc6PzijAA2Xs6jSRp0xfHNYXQuLlsBkGtfPFQpVFGI7lCvH6Gi
 k7fdWNpPZqQibX6bHrw5M3jXnaaBGJQXmCgWjxXAtuQ9ZnFRB/QGhkpR241KUO80uDcx
 lsJDslyqMKJo9tClrPl09OResyHkwNjoTJzklC8UIM7++vphHz8DzeSxJ7gK8uCVt+lc
 r3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445227; x=1793050027;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MXdXctqen7bxdXW/pJcELTfyAg9I34YgxkC51jhk6ug=;
 b=yWG3SvYftaYvTkIQvvliwmqTs0tHLw6MxaGXSwVmrMZgcq3iEPVQKZmrsNk9oZgMBV
 VIM8kctiQOg6mZ5XOj5wlQXKfUNDAzAVuaflq6G0FB27/iI0c0yJFoLNWIMHx70K2sbS
 iyd9QhCT3JVEhQ2XDiH2INiaeR+eaOZ3wPbAWqXzk52J8Y9XTE7YjIdZJbexPjZfAObB
 SmF8/Aiyv2ZFjBFPkrpp44r5iRwvDlQbnXkM2pwBBfnGlYKEybc6q72sRYmBgK+YbYWv
 V4beritykTvbPs1WLvt4V4vCRZtXNdIpb6Dctdd4qV6kNkAqyLAVbvL2T7HkH6T3+le+
 lU8Q==
X-Gm-Message-State: AFq9FYIK/BqXYLcnRXQU+lo/6hjOFz5rx4fSkbP2EHe7TLz/gCjCG15N
 f4TLUhhFTb3lgAui85RNMRMCoLONqPbardKS6sgdzaIAhet9RMTVOB8OwQsL5dl/fPMxI+KdH/P
 P5nda0dmGxKXRpVy9RnsopNs8BDyq0xqH+0yoeUwFQUyKDCRz1nr+AIpdQZ0R1QXSeQ==
X-Gm-Gg: AYBFou1rVLasxQYqxPJlFqhNlDWk4naOIPeVoV+aaX8CYRlwVpCQ1r9pxkpne9an/QV
 FHxa2VSd6gqOI+6aTsYbcj4vn7OgxwD1zBBMiz9V+f6OYAaGjfH0lfaRD+sIUJNc8um2aCUtIDO
 QTZwbYaFDCGkdlc2U8awJU4DynaTzURSAL52Ej6V5mVDAzAuund+U+/uYAzOiYz2gWEeq+41Pt2
 Hdu2OpycBlFHEW4peDom7+Mp97a8ERiZTK3owdT1/cy7/e7d/H0vputuELaRhiscZCEePWjGzwd
 LfMtED0Hq2OhKNxVzyo+m9zVCHXeOjcozqsWI2JpP6tZrj7f7uJ6U/pSh1R7j5Akm7tzrHUZj5C
 HOlR0JK0xGxJZkrMGU90QOPAyNndkMi1b/bMNy+wGiq0+/5Gh8QZ4ZwVoVfjd9Bs=
X-Received: by 2002:a17:90b:3a4d:b0:3ab:e588:c275 with SMTP id
 98e67ed59e1d1-3aceefbe878mr6925232a91.20.1792445226917; 
 Mon, 19 Oct 2026 14:27:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3a4d:b0:3ab:e588:c275 with SMTP id
 98e67ed59e1d1-3aceefbe878mr6925217a91.20.1792445226429; 
 Mon, 19 Oct 2026 14:27:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 02/21] dump/dump: do not dump machine if doing
 heterogeneous emulation
Date: Mon, 19 Oct 2026 21:26:29 +0000
Message-ID: <20261019212648.154493-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX4T7lEN/QMveG
 KvMfA9jnDwR6hQgX2o7DTQY17T+5DDAoTpVbuiWi8T0bdATDpNa7nk6Jd9KyYINstfgurRHZzrt
 R5tIfmRg/ajIQ6rlln7u+W+KT0V0W4pZVAiu5SD5+WBnu7uVH3RoIAwDETmyXTYjr41JQLbE8jB
 89lRVDJxA/j3ULxraveawCZsgAvcO4BMLEddkNZ2t1dEu5LVa10r5l7R1zXR2edCsifSe6YAbsG
 xJygo/9gYnNnTt5iLVyUs8SQTzTt4hB5FjMuyIGb2SwdWs2Llm3McspE7cYyfWeh+ajFxeFs6Vo
 PUOVlczJe2DZAXDNjL/wF6f7FTgJhEMY2NarddPCVCuRRUaog6ugHhm57YgJS/7ccFlZS9sY2od
 KkVwP5DawngpSOOcd92Z88TGQTDh5Z40TshkPQUyWcMmmNOtvtmW1fYW14keJFcxbtUDMvg7QzV
 8dD4/o8y0+nexHhK6pg==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad68b2b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=PZcAJl5xHOMMM7CFr9sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX9bQGkI08hMSt
 N0HYKlJoCeBQY9JPcUVGxTkYK31ZFiKE7FBHNKe8UhzsenSVq/Rd7MMx/YvqGM9BM9cQxtVbjri
 8hx5pOpi1kPFjOrSeWePNhDTpmaYBMc=
X-Proofpoint-ORIG-GUID: DpdarrlVH0Or8bq1m8jkQA3irBDknQf2
X-Proofpoint-GUID: DpdarrlVH0Or8bq1m8jkQA3irBDknQf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

This would need some refactoring to do it correctly over all targets
involved. For now, simply prevent this from happening.

We do the check at beginning of function, so no need to call cleanup
routine.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dump/dump.c b/dump/dump.c
index 52be7258a5d..0ecff682dd4 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1795,6 +1795,12 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     int nr_cpus;
     int ret;
 
+    if (target_heterogeneous()) {
+        error_setg(errp,
+                   "dumping guest memory is not supported for heterogeneous emulation");
+        return;
+    }
+
     s->has_format = has_format;
     s->format = format;
     s->written_size = 0;
-- 
2.43.0


