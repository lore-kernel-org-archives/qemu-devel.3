Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B9606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n49BiNdI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GPJGTm9o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwT-0007qS-MG; Fri, 23 Oct 2026 12:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHw0-0006xc-Ta
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvx-0002QS-J4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6S1S2216170
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FHBwtfeYHyKYIoFDXSqPaZRe8t7cpoqEqTkKzZ61eGM=; b=n49BiNdIcI6cp7MZ
 xwG5L7oY9VU68Rawz3zsUQM0TuDdkXlWqFSoADTy1whh2IweD6M1KENXF5Rx/TQ7
 eIfqmOSyyepkscQ3QJrGQI9hSRXxn9CZuhqBDL3Ny4+4Oc6VTq3GC61IH3LL9cQA
 pJu+y9UOP/IGrAxzVztuVOyq1Og3/+Ed0VxWcUwFwK9VCU7HFG9evqfWuNiNOaVM
 lfWyGI64TgJOMZHhRB9KPRrXJjRlE7k966uqx39yoKN6/R1F9TBf9uPArB+ilkJ/
 0ful74HghMYLp9HuxA7NcQLNLgHEzhQV17g1mLusk2Xleq9UEqYcSY0Rj4dC6+zD
 XXK3SA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc817h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f3969a2a7so177104585a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772155; x=1793376955; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FHBwtfeYHyKYIoFDXSqPaZRe8t7cpoqEqTkKzZ61eGM=;
 b=GPJGTm9oEPRSM98W6jKi7VFFOpIV44gOC2WK8GNtEhZq+bdtt3LSJdCqIyMZrhwfQA
 myTc0HkYg4wSwLiVD6BBtKQ76t1TIdC8MbHQmNYp6upPG4EWCdY+HXgXeXtsbMNd/pqy
 4JgD39yQZ8nDbmiyAuLRccpv7oDnn8Hp/FOoyoappS9J8lLuu+T/xjdAObtzWzw4fB0k
 CE7+97ZdPu4g0003QbjbNfrw+3FIL8DAUabDVzZNiSYuBswPBYXVSmut0/62dxD7/Wgx
 mRh7+hPph+pOcJ9eB+LHOaVfp+OWJo/XlHxZf1xzbT6W5Q6iLhmPJL8F+UA3bgN4CNpg
 JChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772155; x=1793376955;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FHBwtfeYHyKYIoFDXSqPaZRe8t7cpoqEqTkKzZ61eGM=;
 b=hmPrmFD8v3yNLQp6nSQVWQL+rsbvBmhSgcTndCkLMcyG6xrq5Bumy5yQuiAPVF/nXE
 p4qBVDOthyYyNvl1nQm7boXlu5szozw14WRJj/0KwKdUPOou84siHBh/qZ/by5Xfg5bt
 3Ir/rReEd5b6FQ3Ra8kjBQ2UrEBLbn0JLPHLS6CDmnq/BHGkjdrg6AGNXwHuwXcYAijv
 b3Hm3fvUgKS5S+GSUw9b1OXghlK4eLUGUkhNAJotmKaNaIYpi7r6DfTSlnjBC62AZ8DH
 WGOp9GKa5L3FCzygbHE8/FiiAePYSqgXxvBpKAh7tnIa+IGnWZq+mX624eZrPpUtut16
 27dg==
X-Gm-Message-State: AFq9FYIhoofEIF8rAO6nFERH6F8aMGXG6s1f5GU9U8IuGlb5rS3AVy5Q
 GKiKCwgyShxoPSTs57ZFpesNgZfs/OBcNqdbfFzjZAEsA0Lbg2PoV11IPw83c2nB139Q5GATKGi
 uwIv72VH7Jk9ceR8KYTdpuikQLJ8pf+FMjEyDM14aJC6HvKoX3UBhU+Pvh04VXgWtp7Xj
X-Gm-Gg: AYBFou0aBeclO6wCeAp/613fsoZkaU4FcktTqbKT9wVpkBaifYY09FENTCiv+n25njY
 +5yXiLRUTA4z5Z9GSw2j+Ywy6UT90Fs7V6ui16EVRvTYNrk/rOaF278gwVNRfGLcEwJhmIIR0CU
 hiT/OncmZ9/Y2xybORYc2MU8+lTPSd25p4nrb9vmyOpku1vl7g4ibYmHWTfyp7euTsf/wMCFexe
 ggqgJOu0UwUEc8hDc7lJJFaPV4/jE+oA4p1qXNXVp4DK/vhjAk40pSoImPFG+McqnnMVC+NCgF5
 oYoPcttA42ctSTVpQn1rGrC5fGxK5pukwWoWF997TPDpJVmHcqsJo/v0hAxSG93jwl5knbrIcMd
 WJ+JUHfoMR8aULnNTRelgCq8KW4T/9x+FTlfdpn8w
X-Received: by 2002:a05:620a:4509:b0:93f:5ab9:fda7 with SMTP id
 af79cd13be357-93f6f7e3a9cmr490988085a.42.1792772155359; 
 Fri, 23 Oct 2026 09:15:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4509:b0:93f:5ab9:fda7 with SMTP id
 af79cd13be357-93f6f7e3a9cmr490982585a.42.1792772154767; 
 Fri, 23 Oct 2026 09:15:54 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3f9d0dsm1003111f8f.22.2026.10.23.09.15.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:15:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/83] include: Remove TARGET_LONG_SIZE definition
Date: Fri, 23 Oct 2026 18:12:27 +0200
Message-ID: <20261023161332.60153-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX37uj7aRjkn1W
 xZBs2D5CoPSWLwFXNtqxJF9MduDFXQPlrVfkNhQkB6vVhNe5nwLtY0MQkTNHsLxSTyUrQQy1lyp
 R/GQTn8SYWW16DskVEP1AkRAijItdYqB+udH0J3mEL4+CTaJhENy6THmSzWTzu+NU5iZdOTPFxY
 SLZaWzdmZb+i9Wi1kPloiHEqzRvDb1BW2wSixu1oVhKeWjNnyTz9cxFEklRW9//Ib8w63kx4uUE
 g7H6VzXpGcrYEtQu7p3sXqRF8Yjps86e5EOZZKqRw6SH4gar8q1ImGGCF1vCZMU+yHdhWvYcjEw
 zInDhEh/SMR1WqL3kQSh424pkl6yUTWUZLIza/mIV8i3ocJmUa+Htjft47TiN0XefzFT7nAOSC/
 6V+0kZryZ0NTm/6Nx7fc483LaSYAf4B3aKagpFBYdCHqmgGQm/XfEv8FsfuDuUw+c0gN9RBq7TW
 HkP0f6f95aM+rAOnLJg==
X-Proofpoint-GUID: iYyuZXmfu9XhvCtGiEcTOXMKCFQyuJbp
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb883c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Kwhbg8pJGtqcix1HUGwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: iYyuZXmfu9XhvCtGiEcTOXMKCFQyuJbp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX8lz8VSTdVWXU
 U7jU1ujPIlBPx3qB7fdB4TlnI0ja0I6LInkffdv3B+cbQwrz4GNFRgbgnzzPKsg7RsbIZriGpi7
 6UD+FW61dZ+meULv5rX6CBzOwSI/X08=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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

All the code base uses TARGET_LONG_BITS,
remove TARGET_LONG_SIZE as unnecessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261007232326.66240-11-philmd@oss.qualcomm.com>
---
 include/exec/target_long.h  | 8 +++-----
 include/user/tswap-target.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/exec/target_long.h b/include/exec/target_long.h
index 3cd8e26a23f..5d403c60402 100644
--- a/include/exec/target_long.h
+++ b/include/exec/target_long.h
@@ -20,17 +20,15 @@
 #error TARGET_LONG_BITS not defined
 #endif
 
-#define TARGET_LONG_SIZE (TARGET_LONG_BITS / 8)
-
 /* target_ulong is the type of a virtual address */
-#if TARGET_LONG_SIZE == 4
+#if TARGET_LONG_BITS == 32
 typedef int32_t target_long;
 typedef uint32_t target_ulong;
 #define TARGET_FMT_lx "%08x"
 #define TARGET_FMT_ld "%d"
 #define TARGET_FMT_lu "%u"
 #define MO_TL MO_32
-#elif TARGET_LONG_SIZE == 8
+#elif TARGET_LONG_BITS == 64
 typedef int64_t target_long;
 typedef uint64_t target_ulong;
 #define TARGET_FMT_lx "%016" PRIx64
@@ -38,7 +36,7 @@ typedef uint64_t target_ulong;
 #define TARGET_FMT_lu "%" PRIu64
 #define MO_TL MO_64
 #else
-#error TARGET_LONG_SIZE undefined
+#error TARGET_LONG_BITS invalid
 #endif
 
 #endif /* _TARGET_LONG_H_ */
diff --git a/include/user/tswap-target.h b/include/user/tswap-target.h
index 4719330dbbc..1c66a5b9344 100644
--- a/include/user/tswap-target.h
+++ b/include/user/tswap-target.h
@@ -11,7 +11,7 @@
 #include "exec/cpu-defs.h"
 #include "exec/tswap.h"
 
-#if TARGET_LONG_SIZE == 4
+#if TARGET_LONG_BITS == 32
 #define tswapl(s) tswap32(s)
 #define bswaptls(s) bswap32s(s)
 #else
-- 
2.55.0


