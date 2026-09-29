Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D703CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKY-0000hY-16; Tue, 29 Sep 2026 17:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKR-0000bt-0Q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKN-0003tB-Cx
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TIR9pW1649641
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jPkJ0QL74Bj4GhPucgdzejMp14XCihRK/eWSnQlebY8=; b=c4BUBUnDiVrq/clH
 /oksXGLZrTTrOc+HZOYhzr79cbRHXq4OK3agliE6pydqBnOZexVdYtOb7/57tbjL
 7gC+FVitAxqQt2lO8i3xljCfHiQEY6sDo9I48jDwTkeO2ti+m/A86bbWFiWjSZXm
 XdB/i4TNR8Qryjf+8mVa6Yadxcw+cBujmuI5KTaGu+l1BgoNZ5AMUjOtdTzFp2l0
 aXnCiGCjL2JSokhHcCrQzu8rfHZhD/8Ah2FwMx/153ZKI0vHqLfDmlmYjk31tQud
 VBoTPtwMB9DXCLIMI4kVtQmk1JIclyExIEcmMEvB8PXG6KEnESDztFtovh0lSewX
 Ng2iTA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0et29wf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso2807192eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717129; x=1791321929; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jPkJ0QL74Bj4GhPucgdzejMp14XCihRK/eWSnQlebY8=;
 b=CKL/A7MfIih/b6JuoFHAKW0uYtS5fnJ7ZOPJxv7HG3ZZUvMkurNvh8pZFeoxJ6qPqU
 fWwWun+oBk+2+OizHmONJrAJBAaaWn7JK0C+DCD/WIvQx2Gz9qDj1fqUCzW43c9BHeRC
 CfCVM9WzsFOkY/6P25sC/ra+DbOad8tOL776ihMpzv0ad5xr83OoGNY5lovt++QMYvYX
 m7lpxV90QCzHiy4cLqCKsJUZ3PQfmrYfq8IQyhSfg7/smD+nejhgGxpOnzAAwrduQZsk
 4MKuSkSrt7nKmdxX/YcuYYExAVEoIU1PtMZbmt1g3nZJKf8LTLn66jgYrb18UDimGYns
 c1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717129; x=1791321929;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jPkJ0QL74Bj4GhPucgdzejMp14XCihRK/eWSnQlebY8=;
 b=cMDTH/W2vBKN/opbnl+2DYIVPrZr1bQnXSVH8sHVaV4bMsQCIotGWY00MuFqIaEYkn
 dKK03mQ/aFNInADD4R7wlefIImaa3uhCHZftsXFcQz3urEKhx+2i/AHbGUoupOK2g5zY
 knisCWrbECPwz1VWAY97p6lkaJVkgM5BZYzrxvvTh4wF+b67JkMWlVuyS/RQeEnM+QnB
 lsKI0WT1ya0oj3jAfrkcIxG4MktGy9CFk4TN8RJRb11WXqlwtZmnIRuKcjiH4A37U4KL
 mJUviBYsQtgBez6m79FNm2SihPiC/Nv4kw+8SKoW+3wCi0+E95FpaqaUXhKMcTijo0PQ
 gLRw==
X-Gm-Message-State: AFuF++liOknUoIJCgTy3SggFFkDqR4RU1HpvC5Duh72wJndYsXxuRkT7
 4C0sq/vt1kCdoc9TOBrDLs13dA2rfoqTtGVBV5bJNdU8Nlk8du1xRaNJjfGbYstJDj/k+1KKuKs
 ymrz73yAN0NTWGzLJwQ2pMsgqhsDMEewFXR5cTavlyp92CPp07hvlQkbuONXgcoxX1g==
X-Gm-Gg: AYBFou1jvBQ58WrxTBm3lFyYcuxD73tkBvnw/0rno4f04/scDUxIi4SxsARIANqeiub
 wLX7QbeRA5O1d9Y590rkWnDSqtH0ZS46f/J8Goq5PAo/C9HSsD4toKwzU+TZUxp8Qg9UGLIIcta
 3/0Mm7zKgKObkkSmqPzNlNB8+AAImnaSMZMSUPxmEeo4hYKapzVrw5Yn5+dirmDJ+hQ5zuAv3sK
 A5Ec41XAO56rXHXQ0Cpx1Fuspiry9WT5PPuVsfdUV/bgv93MupENe/RCO6Es4KNIX/zAXA23Rby
 S1ud45rJZ4+7gHw5KZgMNPT00UzRaOIL6d8n5Agqix2W+Krwvu829mk/qsN+PdGmD5GQqlvFrHM
 zzU8S2I1g3BW+Zr701YbRVV7tvEOUGM7jer0bEZimB2PSY13QNsCtLR1ZUfDt
X-Received: by 2002:a05:7300:7fa8:b0:33c:1bd2:1d96 with SMTP id
 5a478bee46e88-34c5e841519mr936353eec.0.1790717128772; 
 Tue, 29 Sep 2026 14:25:28 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa8:b0:33c:1bd2:1d96 with SMTP id
 5a478bee46e88-34c5e841519mr936298eec.0.1790717127640; 
 Tue, 29 Sep 2026 14:25:27 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 18/24] tests/tcg/mips64/mips64r6: update references
Date: Tue, 29 Sep 2026 21:24:33 +0000
Message-ID: <20260929212439.110454-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MCQ19xxK5aRnaIEXMzU28XH8dDzNBw3R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX2aEzKFi6RgVe
 Q8TAwsr0V53KemvuHzlNzo84Mo0PDkNDsLXdowXkvFHFIx6D7XjUfoxfgWyx5ZQb1z0BirbHM4s
 c60kqAeibvUyHILtpzD9dNuykquBfp9pSDlWF8Z/lCC6UI2Er7Gs2uVPyyv13ncJE6aB8wZ9yXg
 U+9TUKJXdrsbZdtBelgiikgDKfcOkZql38+b9k30nYfv80zEgzxOWLC3VniOA/tyu9VMNAcopFU
 X/OcGMYDIeMcrc9aGz4kqgBPTIZdrFuUwdYrq4DNygqF4I81Ipo3s64LjoJnihgZo6kclOgRTvE
 4Qpvi1GUpPXWCDS/cXxzL+EQoOyWrAKFXvOb7nS1JWaFkVKqPKXjwNOh9vsf7+x0DeIp+6qnnjL
 UvpSSTHb4G+miuioTJdfp1i8FG5eM34oJ8o+BRLe8tX6Psn0EUf7+mRsaeGbZ6d3wTfyu74XXq8
 Ye1B+62xS2elGKc40Nw==
X-Authority-Analysis: v=2.4 cv=cokOAF4i c=1 sm=1 tr=0 ts=6abc2cc9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=SGz1nzReB8itku72Cc8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: MCQ19xxK5aRnaIEXMzU28XH8dDzNBw3R
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX8tVx/C7kGbnE
 wr6uIZ3kCSRTdIDjuba2puP+F6z4OeDKLi1e9rya/hxBv2hp6l5LsjzwZhF0hNo0ePiXN5q8wX8
 y3WEjokg3T5TNjxeVcthcyxsyxnvalk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Those references were incorrect. Updated them, after comparing output on
host machine using:

```
  #include <assert.h>
  #include <stdint.h>
  #define and(x,y) (x&y)
  #define or(x,y) (x|y)
  #define xor(x,y) (x^y)
  #define nor(x,y) (~(x|y))
  #define srav(x,y) ((int64_t)((int32_t)(x)>>(y&0b11111)))
  int main(void)
  {
  /* following source files are output of associated tests */
  #include "./and.c"
  #include "./or.c"
  #include "./nor.c"
  #include "./xor.c"
  #include "./srav.c"
  }
```

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_and.c  | 160 +++++++++++++-------------
 tests/tcg/mips64/test_mips64r6_nor.c  | 160 +++++++++++++-------------
 tests/tcg/mips64/test_mips64r6_or.c   | 160 +++++++++++++-------------
 tests/tcg/mips64/test_mips64r6_srav.c | 160 +++++++++++++-------------
 tests/tcg/mips64/test_mips64r6_xor.c  | 160 +++++++++++++-------------
 5 files changed, 400 insertions(+), 400 deletions(-)

diff --git a/tests/tcg/mips64/test_mips64r6_and.c b/tests/tcg/mips64/test_mips64r6_and.c
index f83359107b9..d7aba39edc3 100644
--- a/tests/tcg/mips64/test_mips64r6_and.c
+++ b/tests/tcg/mips64/test_mips64r6_and.c
@@ -32,86 +32,86 @@
 int32_t main(void)
 {
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
-        0x8000000000000000ULL,                    /*   0  */
-        0xffffffffffffffffULL,
-        0xfffffc0000000000ULL,
-        0xffffffffffe00000ULL,
-        0xfffffffffffff000ULL,
-        0xfff8000000000000ULL,
-        0xffffffffffffc000ULL,
-        0xfffe000000000000ULL,
-        0x0000000000000000ULL,                    /*   8  */
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,                    /*  16  */
-        0xaaaaaaaaaaaaaaaaULL,
-        0xaaaaa80000000000ULL,
-        0x5555555555400000ULL,
-        0xaaaaaaaaaaaaa000ULL,
-        0x5550000000000000ULL,
-        0xaaaaaaaaaaaa8000ULL,
-        0x5554000000000000ULL,
-        0x8000000000000000ULL,                    /*  24  */
-        0x5555555555555555ULL,
-        0x5555540000000000ULL,
-        0xaaaaaaaaaaa00000ULL,
-        0x5555555555555000ULL,
-        0xaaa8000000000000ULL,
-        0x5555555555554000ULL,
-        0xaaaa000000000000ULL,
-        0x0000000000000000ULL,                    /*  32  */
-        0xccccccccccccccccULL,
-        0x3333300000000000ULL,
-        0x9999999999800000ULL,
-        0xccccccccccccc000ULL,
-        0x6660000000000000ULL,
-        0x3333333333330000ULL,
-        0x9998000000000000ULL,
-        0x8000000000000000ULL,                    /*  40  */
-        0x3333333333333333ULL,
-        0xcccccc0000000000ULL,
-        0x6666666666600000ULL,
-        0x3333333333333000ULL,
-        0x9998000000000000ULL,
-        0xccccccccccccc000ULL,
-        0x6666000000000000ULL,
-        0x0000000000000000ULL,                    /*  48  */
-        0xe38e38e38e38e38eULL,
-        0xe38e380000000000ULL,
-        0x1c71c71c71c00000ULL,
-        0xe38e38e38e38e000ULL,
-        0x1c70000000000000ULL,
-        0x8e38e38e38e38000ULL,
-        0xc71c000000000000ULL,
-        0x8000000000000000ULL,                    /*  56  */
-        0x1c71c71c71c71c71ULL,
-        0x1c71c40000000000ULL,
-        0xe38e38e38e200000ULL,
-        0x1c71c71c71c71000ULL,
-        0xe388000000000000ULL,
-        0x71c71c71c71c4000ULL,
-        0x38e2000000000000ULL,
-        0x886ae6cc28625540ULL,                    /*  64  */
-        0x6ae6cc2862554000ULL,
-        0x886ae6cc28625540ULL,
-        0xb9b30a1895500000ULL,
-        0xfbbe00634d93c708ULL,
-        0xbe00634d93c70800ULL,
-        0xfbbe00634d93c708ULL,
-        0x8018d364f1c20000ULL,
-        0xac5aaeaab9cf8b80ULL,                    /*  72  */
-        0x5aaeaab9cf8b8000ULL,
-        0xac5aaeaab9cf8b80ULL,
-        0xabaaae73e2e00000ULL,
-        0x704f164d5e31e24eULL,
-        0x4f164d5e31e24e00ULL,
-        0x704f164d5e31e24eULL,
-        0xc593578c78938000ULL,
+        0xffffffffffffffff,
+        0x0,
+        0xaaaaaaaaaaaaaaaa,
+        0x5555555555555555,
+        0xcccccccccccccccc,
+        0x3333333333333333,
+        0xe38e38e38e38e38e,
+        0x1c71c71c71c71c71,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0xaaaaaaaaaaaaaaaa,
+        0x0,
+        0xaaaaaaaaaaaaaaaa,
+        0x0,
+        0x8888888888888888,
+        0x2222222222222222,
+        0xa28a28a28a28a28a,
+        0x820820820820820,
+        0x5555555555555555,
+        0x0,
+        0x0,
+        0x5555555555555555,
+        0x4444444444444444,
+        0x1111111111111111,
+        0x4104104104104104,
+        0x1451451451451451,
+        0xcccccccccccccccc,
+        0x0,
+        0x8888888888888888,
+        0x4444444444444444,
+        0xcccccccccccccccc,
+        0x0,
+        0xc08c08c08c08c08c,
+        0xc40c40c40c40c40,
+        0x3333333333333333,
+        0x0,
+        0x2222222222222222,
+        0x1111111111111111,
+        0x0,
+        0x3333333333333333,
+        0x2302302302302302,
+        0x1031031031031031,
+        0xe38e38e38e38e38e,
+        0x0,
+        0xa28a28a28a28a28a,
+        0x4104104104104104,
+        0xc08c08c08c08c08c,
+        0x2302302302302302,
+        0xe38e38e38e38e38e,
+        0x0,
+        0x1c71c71c71c71c71,
+        0x0,
+        0x820820820820820,
+        0x1451451451451451,
+        0xc40c40c40c40c40,
+        0x1031031031031031,
+        0x0,
+        0x1c71c71c71c71c71,
+        0x886ae6cc28625540,
+        0x882a004008024500,
+        0x884aa68828420100,
+        0x4a064c08204040,
+        0x882a004008024500,
+        0xfbbe00634d93c708,
+        0xa81a002209838300,
+        0x700e00414c11c208,
+        0x884aa68828420100,
+        0xa81a002209838300,
+        0xac5aaeaab9cf8b80,
+        0x204a060818018200,
+        0x4a064c08204040,
+        0x700e00414c11c208,
+        0x204a060818018200,
+        0x704f164d5e31e24e,
     };
 
     return !check_binary_op_64(do_mips64r6_AND, "and", b64_expect);
diff --git a/tests/tcg/mips64/test_mips64r6_nor.c b/tests/tcg/mips64/test_mips64r6_nor.c
index 13a51490187..a758f5cd5d9 100644
--- a/tests/tcg/mips64/test_mips64r6_nor.c
+++ b/tests/tcg/mips64/test_mips64r6_nor.c
@@ -32,86 +32,86 @@
 int32_t main(void)
 {
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
-        0x8000000000000000ULL,                    /*   0  */
-        0xffffffffffffffffULL,
-        0xfffffc0000000000ULL,
-        0xffffffffffe00000ULL,
-        0xfffffffffffff000ULL,
-        0xfff8000000000000ULL,
-        0xffffffffffffc000ULL,
-        0xfffe000000000000ULL,
-        0x0000000000000000ULL,                    /*   8  */
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,                    /*  16  */
-        0xaaaaaaaaaaaaaaaaULL,
-        0xaaaaa80000000000ULL,
-        0x5555555555400000ULL,
-        0xaaaaaaaaaaaaa000ULL,
-        0x5550000000000000ULL,
-        0xaaaaaaaaaaaa8000ULL,
-        0x5554000000000000ULL,
-        0x8000000000000000ULL,                    /*  24  */
-        0x5555555555555555ULL,
-        0x5555540000000000ULL,
-        0xaaaaaaaaaaa00000ULL,
-        0x5555555555555000ULL,
-        0xaaa8000000000000ULL,
-        0x5555555555554000ULL,
-        0xaaaa000000000000ULL,
-        0x0000000000000000ULL,                    /*  32  */
-        0xccccccccccccccccULL,
-        0x3333300000000000ULL,
-        0x9999999999800000ULL,
-        0xccccccccccccc000ULL,
-        0x6660000000000000ULL,
-        0x3333333333330000ULL,
-        0x9998000000000000ULL,
-        0x8000000000000000ULL,                    /*  40  */
-        0x3333333333333333ULL,
-        0xcccccc0000000000ULL,
-        0x6666666666600000ULL,
-        0x3333333333333000ULL,
-        0x9998000000000000ULL,
-        0xccccccccccccc000ULL,
-        0x6666000000000000ULL,
-        0x0000000000000000ULL,                    /*  48  */
-        0xe38e38e38e38e38eULL,
-        0xe38e380000000000ULL,
-        0x1c71c71c71c00000ULL,
-        0xe38e38e38e38e000ULL,
-        0x1c70000000000000ULL,
-        0x8e38e38e38e38000ULL,
-        0xc71c000000000000ULL,
-        0x8000000000000000ULL,                    /*  56  */
-        0x1c71c71c71c71c71ULL,
-        0x1c71c40000000000ULL,
-        0xe38e38e38e200000ULL,
-        0x1c71c71c71c71000ULL,
-        0xe388000000000000ULL,
-        0x71c71c71c71c4000ULL,
-        0x38e2000000000000ULL,
-        0x886ae6cc28625540ULL,                    /*  64  */
-        0x6ae6cc2862554000ULL,
-        0x886ae6cc28625540ULL,
-        0xb9b30a1895500000ULL,
-        0xfbbe00634d93c708ULL,
-        0xbe00634d93c70800ULL,
-        0xfbbe00634d93c708ULL,
-        0x8018d364f1c20000ULL,
-        0xac5aaeaab9cf8b80ULL,                    /*  72  */
-        0x5aaeaab9cf8b8000ULL,
-        0xac5aaeaab9cf8b80ULL,
-        0xabaaae73e2e00000ULL,
-        0x704f164d5e31e24eULL,
-        0x4f164d5e31e24e00ULL,
-        0x704f164d5e31e24eULL,
-        0xc593578c78938000ULL,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0xffffffffffffffff,
+        0x5555555555555555,
+        0xaaaaaaaaaaaaaaaa,
+        0x3333333333333333,
+        0xcccccccccccccccc,
+        0x1c71c71c71c71c71,
+        0xe38e38e38e38e38e,
+        0x0,
+        0x5555555555555555,
+        0x5555555555555555,
+        0x0,
+        0x1111111111111111,
+        0x4444444444444444,
+        0x1451451451451451,
+        0x4104104104104104,
+        0x0,
+        0xaaaaaaaaaaaaaaaa,
+        0x0,
+        0xaaaaaaaaaaaaaaaa,
+        0x2222222222222222,
+        0x8888888888888888,
+        0x820820820820820,
+        0xa28a28a28a28a28a,
+        0x0,
+        0x3333333333333333,
+        0x1111111111111111,
+        0x2222222222222222,
+        0x3333333333333333,
+        0x0,
+        0x1031031031031031,
+        0x2302302302302302,
+        0x0,
+        0xcccccccccccccccc,
+        0x4444444444444444,
+        0x8888888888888888,
+        0x0,
+        0xcccccccccccccccc,
+        0xc40c40c40c40c40,
+        0xc08c08c08c08c08c,
+        0x0,
+        0x1c71c71c71c71c71,
+        0x1451451451451451,
+        0x820820820820820,
+        0x1031031031031031,
+        0xc40c40c40c40c40,
+        0x1c71c71c71c71c71,
+        0x0,
+        0x0,
+        0xe38e38e38e38e38e,
+        0x4104104104104104,
+        0xa28a28a28a28a28a,
+        0x2302302302302302,
+        0xc08c08c08c08c08c,
+        0x0,
+        0xe38e38e38e38e38e,
+        0x77951933d79daabf,
+        0x4011910920c28b7,
+        0x538511114610203f,
+        0x7900932818c08b1,
+        0x4011910920c28b7,
+        0x441ff9cb26c38f7,
+        0x1511402203077,
+        0x400e990a04c18b1,
+        0x538511114610203f,
+        0x1511402203077,
+        0x53a551554630747f,
+        0x3a0411000001431,
+        0x7900932818c08b1,
+        0x400e990a04c18b1,
+        0x3a0411000001431,
+        0x8fb0e9b2a1ce1db1,
     };
 
     return !check_binary_op_64(do_mips64r6_NOR, "nor", b64_expect);
diff --git a/tests/tcg/mips64/test_mips64r6_or.c b/tests/tcg/mips64/test_mips64r6_or.c
index e4d7a95d37f..9f6189827db 100644
--- a/tests/tcg/mips64/test_mips64r6_or.c
+++ b/tests/tcg/mips64/test_mips64r6_or.c
@@ -32,86 +32,86 @@
 int32_t main(void)
 {
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
-        0x8000000000000000ULL,                    /*   0  */
-        0xffffffffffffffffULL,
-        0xfffffc0000000000ULL,
-        0xffffffffffe00000ULL,
-        0xfffffffffffff000ULL,
-        0xfff8000000000000ULL,
-        0xffffffffffffc000ULL,
-        0xfffe000000000000ULL,
-        0x0000000000000000ULL,                    /*   8  */
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,                    /*  16  */
-        0xaaaaaaaaaaaaaaaaULL,
-        0xaaaaa80000000000ULL,
-        0x5555555555400000ULL,
-        0xaaaaaaaaaaaaa000ULL,
-        0x5550000000000000ULL,
-        0xaaaaaaaaaaaa8000ULL,
-        0x5554000000000000ULL,
-        0x8000000000000000ULL,                    /*  24  */
-        0x5555555555555555ULL,
-        0x5555540000000000ULL,
-        0xaaaaaaaaaaa00000ULL,
-        0x5555555555555000ULL,
-        0xaaa8000000000000ULL,
-        0x5555555555554000ULL,
-        0xaaaa000000000000ULL,
-        0x0000000000000000ULL,                    /*  32  */
-        0xccccccccccccccccULL,
-        0x3333300000000000ULL,
-        0x9999999999800000ULL,
-        0xccccccccccccc000ULL,
-        0x6660000000000000ULL,
-        0x3333333333330000ULL,
-        0x9998000000000000ULL,
-        0x8000000000000000ULL,                    /*  40  */
-        0x3333333333333333ULL,
-        0xcccccc0000000000ULL,
-        0x6666666666600000ULL,
-        0x3333333333333000ULL,
-        0x9998000000000000ULL,
-        0xccccccccccccc000ULL,
-        0x6666000000000000ULL,
-        0x0000000000000000ULL,                    /*  48  */
-        0xe38e38e38e38e38eULL,
-        0xe38e380000000000ULL,
-        0x1c71c71c71c00000ULL,
-        0xe38e38e38e38e000ULL,
-        0x1c70000000000000ULL,
-        0x8e38e38e38e38000ULL,
-        0xc71c000000000000ULL,
-        0x8000000000000000ULL,                    /*  56  */
-        0x1c71c71c71c71c71ULL,
-        0x1c71c40000000000ULL,
-        0xe38e38e38e200000ULL,
-        0x1c71c71c71c71000ULL,
-        0xe388000000000000ULL,
-        0x71c71c71c71c4000ULL,
-        0x38e2000000000000ULL,
-        0x886ae6cc28625540ULL,                    /*  64  */
-        0x6ae6cc2862554000ULL,
-        0x886ae6cc28625540ULL,
-        0xb9b30a1895500000ULL,
-        0xfbbe00634d93c708ULL,
-        0xbe00634d93c70800ULL,
-        0xfbbe00634d93c708ULL,
-        0x8018d364f1c20000ULL,
-        0xac5aaeaab9cf8b80ULL,                    /*  72  */
-        0x5aaeaab9cf8b8000ULL,
-        0xac5aaeaab9cf8b80ULL,
-        0xabaaae73e2e00000ULL,
-        0x704f164d5e31e24eULL,
-        0x4f164d5e31e24e00ULL,
-        0x704f164d5e31e24eULL,
-        0xc593578c78938000ULL,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0x0,
+        0xaaaaaaaaaaaaaaaa,
+        0x5555555555555555,
+        0xcccccccccccccccc,
+        0x3333333333333333,
+        0xe38e38e38e38e38e,
+        0x1c71c71c71c71c71,
+        0xffffffffffffffff,
+        0xaaaaaaaaaaaaaaaa,
+        0xaaaaaaaaaaaaaaaa,
+        0xffffffffffffffff,
+        0xeeeeeeeeeeeeeeee,
+        0xbbbbbbbbbbbbbbbb,
+        0xebaebaebaebaebae,
+        0xbefbefbefbefbefb,
+        0xffffffffffffffff,
+        0x5555555555555555,
+        0xffffffffffffffff,
+        0x5555555555555555,
+        0xdddddddddddddddd,
+        0x7777777777777777,
+        0xf7df7df7df7df7df,
+        0x5d75d75d75d75d75,
+        0xffffffffffffffff,
+        0xcccccccccccccccc,
+        0xeeeeeeeeeeeeeeee,
+        0xdddddddddddddddd,
+        0xcccccccccccccccc,
+        0xffffffffffffffff,
+        0xefcefcefcefcefce,
+        0xdcfdcfdcfdcfdcfd,
+        0xffffffffffffffff,
+        0x3333333333333333,
+        0xbbbbbbbbbbbbbbbb,
+        0x7777777777777777,
+        0xffffffffffffffff,
+        0x3333333333333333,
+        0xf3bf3bf3bf3bf3bf,
+        0x3f73f73f73f73f73,
+        0xffffffffffffffff,
+        0xe38e38e38e38e38e,
+        0xebaebaebaebaebae,
+        0xf7df7df7df7df7df,
+        0xefcefcefcefcefce,
+        0xf3bf3bf3bf3bf3bf,
+        0xe38e38e38e38e38e,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0x1c71c71c71c71c71,
+        0xbefbefbefbefbefb,
+        0x5d75d75d75d75d75,
+        0xdcfdcfdcfdcfdcfd,
+        0x3f73f73f73f73f73,
+        0xffffffffffffffff,
+        0x1c71c71c71c71c71,
+        0x886ae6cc28625540,
+        0xfbfee6ef6df3d748,
+        0xac7aeeeeb9efdfc0,
+        0xf86ff6cd7e73f74e,
+        0xfbfee6ef6df3d748,
+        0xfbbe00634d93c708,
+        0xfffeaeebfddfcf88,
+        0xfbff166f5fb3e74e,
+        0xac7aeeeeb9efdfc0,
+        0xfffeaeebfddfcf88,
+        0xac5aaeaab9cf8b80,
+        0xfc5fbeefffffebce,
+        0xf86ff6cd7e73f74e,
+        0xfbff166f5fb3e74e,
+        0xfc5fbeefffffebce,
+        0x704f164d5e31e24e,
     };
 
     return !check_binary_op_64(do_mips64r6_OR, "or", b64_expect);
diff --git a/tests/tcg/mips64/test_mips64r6_srav.c b/tests/tcg/mips64/test_mips64r6_srav.c
index e98bb9b90ee..77fa59a0121 100644
--- a/tests/tcg/mips64/test_mips64r6_srav.c
+++ b/tests/tcg/mips64/test_mips64r6_srav.c
@@ -32,86 +32,86 @@
 int32_t main(void)
 {
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
-        0xffffffffffffffffULL,                    /*   0  */
-        0xffffffffffffffffULL,
-        0xffffffffffffffffULL,
-        0xffffffffffffffffULL,
-        0xffffffffffffffffULL,
-        0xffffffffffffffffULL,
-        0xffffffffffffffffULL,
-        0xffffffffffffffffULL,
-        0x0000000000000000ULL,                    /*   8  */
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0xffffffffffffffffULL,                    /*  16  */
-        0xffffffffaaaaaaaaULL,
-        0xffffffffffeaaaaaULL,
-        0xfffffffffffffd55ULL,
-        0xfffffffffffaaaaaULL,
-        0xfffffffffffff555ULL,
-        0xfffffffffffeaaaaULL,
-        0xffffffffffffd555ULL,
-        0x0000000000000000ULL,                    /*  24  */
-        0x0000000055555555ULL,
-        0x0000000000155555ULL,
-        0x00000000000002aaULL,
-        0x0000000000055555ULL,
-        0x0000000000000aaaULL,
-        0x0000000000015555ULL,
-        0x0000000000002aaaULL,
-        0xffffffffffffffffULL,                    /*  32  */
-        0xffffffffccccccccULL,
-        0xfffffffffff33333ULL,
-        0xfffffffffffffe66ULL,
-        0xfffffffffffcccccULL,
-        0xfffffffffffff999ULL,
-        0xffffffffffff3333ULL,
-        0xffffffffffffe666ULL,
-        0x0000000000000000ULL,                    /*  40  */
-        0x0000000033333333ULL,
-        0x00000000000cccccULL,
-        0x0000000000000199ULL,
-        0x0000000000033333ULL,
-        0x0000000000000666ULL,
-        0x000000000000ccccULL,
-        0x0000000000001999ULL,
-        0xffffffffffffffffULL,                    /*  48  */
-        0xffffffff8e38e38eULL,
-        0xffffffffffe38e38ULL,
-        0xfffffffffffffc71ULL,
-        0xfffffffffff8e38eULL,
-        0xfffffffffffff1c7ULL,
-        0xfffffffffffe38e3ULL,
-        0xffffffffffffc71cULL,
-        0x0000000000000000ULL,                    /*  56  */
-        0x0000000071c71c71ULL,
-        0x00000000001c71c7ULL,
-        0x000000000000038eULL,
-        0x0000000000071c71ULL,
-        0x0000000000000e38ULL,
-        0x000000000001c71cULL,
-        0x00000000000038e3ULL,
-        0x0000000028625540ULL,                    /*  64  */
-        0x0000000000286255ULL,
-        0x0000000028625540ULL,
-        0x000000000000a189ULL,
-        0x000000004d93c708ULL,
-        0x00000000004d93c7ULL,
-        0x000000004d93c708ULL,
-        0x000000000001364fULL,
-        0xffffffffb9cf8b80ULL,                    /*  72  */
-        0xffffffffffb9cf8bULL,
-        0xffffffffb9cf8b80ULL,
-        0xfffffffffffee73eULL,
-        0x000000005e31e24eULL,
-        0x00000000005e31e2ULL,
-        0x000000005e31e24eULL,
-        0x00000000000178c7ULL,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0xffffffffffffffff,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0x0,
+        0xffffffffffffffff,
+        0xffffffffaaaaaaaa,
+        0xffffffffffeaaaaa,
+        0xfffffffffffffd55,
+        0xfffffffffffaaaaa,
+        0xfffffffffffff555,
+        0xfffffffffffeaaaa,
+        0xffffffffffffd555,
+        0x0,
+        0x55555555,
+        0x155555,
+        0x2aa,
+        0x55555,
+        0xaaa,
+        0x15555,
+        0x2aaa,
+        0xffffffffffffffff,
+        0xffffffffcccccccc,
+        0xfffffffffff33333,
+        0xfffffffffffffe66,
+        0xfffffffffffccccc,
+        0xfffffffffffff999,
+        0xffffffffffff3333,
+        0xffffffffffffe666,
+        0x0,
+        0x33333333,
+        0xccccc,
+        0x199,
+        0x33333,
+        0x666,
+        0xcccc,
+        0x1999,
+        0xffffffffffffffff,
+        0xffffffff8e38e38e,
+        0xffffffffffe38e38,
+        0xfffffffffffffc71,
+        0xfffffffffff8e38e,
+        0xfffffffffffff1c7,
+        0xfffffffffffe38e3,
+        0xffffffffffffc71c,
+        0x0,
+        0x71c71c71,
+        0x1c71c7,
+        0x38e,
+        0x71c71,
+        0xe38,
+        0x1c71c,
+        0x38e3,
+        0x28625540,
+        0x286255,
+        0x28625540,
+        0xa189,
+        0x4d93c708,
+        0x4d93c7,
+        0x4d93c708,
+        0x1364f,
+        0xffffffffb9cf8b80,
+        0xffffffffffb9cf8b,
+        0xffffffffb9cf8b80,
+        0xfffffffffffee73e,
+        0x5e31e24e,
+        0x5e31e2,
+        0x5e31e24e,
+        0x178c7,
     };
 
     return !check_binary_op_64(do_mips64r6_SRAV, "srav", b64_expect);
diff --git a/tests/tcg/mips64/test_mips64r6_xor.c b/tests/tcg/mips64/test_mips64r6_xor.c
index 6aab6fc1d47..70626e4b429 100644
--- a/tests/tcg/mips64/test_mips64r6_xor.c
+++ b/tests/tcg/mips64/test_mips64r6_xor.c
@@ -32,86 +32,86 @@
 int32_t main(void)
 {
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
-        0x8000000000000000ULL,                    /*   0  */
-        0xffffffffffffffffULL,
-        0xfffffc0000000000ULL,
-        0xffffffffffe00000ULL,
-        0xfffffffffffff000ULL,
-        0xfff8000000000000ULL,
-        0xffffffffffffc000ULL,
-        0xfffe000000000000ULL,
-        0x0000000000000000ULL,                    /*   8  */
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,
-        0x0000000000000000ULL,                    /*  16  */
-        0xaaaaaaaaaaaaaaaaULL,
-        0xaaaaa80000000000ULL,
-        0x5555555555400000ULL,
-        0xaaaaaaaaaaaaa000ULL,
-        0x5550000000000000ULL,
-        0xaaaaaaaaaaaa8000ULL,
-        0x5554000000000000ULL,
-        0x8000000000000000ULL,                    /*  24  */
-        0x5555555555555555ULL,
-        0x5555540000000000ULL,
-        0xaaaaaaaaaaa00000ULL,
-        0x5555555555555000ULL,
-        0xaaa8000000000000ULL,
-        0x5555555555554000ULL,
-        0xaaaa000000000000ULL,
-        0x0000000000000000ULL,                    /*  32  */
-        0xccccccccccccccccULL,
-        0x3333300000000000ULL,
-        0x9999999999800000ULL,
-        0xccccccccccccc000ULL,
-        0x6660000000000000ULL,
-        0x3333333333330000ULL,
-        0x9998000000000000ULL,
-        0x8000000000000000ULL,                    /*  40  */
-        0x3333333333333333ULL,
-        0xcccccc0000000000ULL,
-        0x6666666666600000ULL,
-        0x3333333333333000ULL,
-        0x9998000000000000ULL,
-        0xccccccccccccc000ULL,
-        0x6666000000000000ULL,
-        0x0000000000000000ULL,                    /*  48  */
-        0xe38e38e38e38e38eULL,
-        0xe38e380000000000ULL,
-        0x1c71c71c71c00000ULL,
-        0xe38e38e38e38e000ULL,
-        0x1c70000000000000ULL,
-        0x8e38e38e38e38000ULL,
-        0xc71c000000000000ULL,
-        0x8000000000000000ULL,                    /*  56  */
-        0x1c71c71c71c71c71ULL,
-        0x1c71c40000000000ULL,
-        0xe38e38e38e200000ULL,
-        0x1c71c71c71c71000ULL,
-        0xe388000000000000ULL,
-        0x71c71c71c71c4000ULL,
-        0x38e2000000000000ULL,
-        0x886ae6cc28625540ULL,                    /*  64  */
-        0x6ae6cc2862554000ULL,
-        0x886ae6cc28625540ULL,
-        0xb9b30a1895500000ULL,
-        0xfbbe00634d93c708ULL,
-        0xbe00634d93c70800ULL,
-        0xfbbe00634d93c708ULL,
-        0x8018d364f1c20000ULL,
-        0xac5aaeaab9cf8b80ULL,                    /*  72  */
-        0x5aaeaab9cf8b8000ULL,
-        0xac5aaeaab9cf8b80ULL,
-        0xabaaae73e2e00000ULL,
-        0x704f164d5e31e24eULL,
-        0x4f164d5e31e24e00ULL,
-        0x704f164d5e31e24eULL,
-        0xc593578c78938000ULL,
+        0x0,
+        0xffffffffffffffff,
+        0x5555555555555555,
+        0xaaaaaaaaaaaaaaaa,
+        0x3333333333333333,
+        0xcccccccccccccccc,
+        0x1c71c71c71c71c71,
+        0xe38e38e38e38e38e,
+        0xffffffffffffffff,
+        0x0,
+        0xaaaaaaaaaaaaaaaa,
+        0x5555555555555555,
+        0xcccccccccccccccc,
+        0x3333333333333333,
+        0xe38e38e38e38e38e,
+        0x1c71c71c71c71c71,
+        0x5555555555555555,
+        0xaaaaaaaaaaaaaaaa,
+        0x0,
+        0xffffffffffffffff,
+        0x6666666666666666,
+        0x9999999999999999,
+        0x4924924924924924,
+        0xb6db6db6db6db6db,
+        0xaaaaaaaaaaaaaaaa,
+        0x5555555555555555,
+        0xffffffffffffffff,
+        0x0,
+        0x9999999999999999,
+        0x6666666666666666,
+        0xb6db6db6db6db6db,
+        0x4924924924924924,
+        0x3333333333333333,
+        0xcccccccccccccccc,
+        0x6666666666666666,
+        0x9999999999999999,
+        0x0,
+        0xffffffffffffffff,
+        0x2f42f42f42f42f42,
+        0xd0bd0bd0bd0bd0bd,
+        0xcccccccccccccccc,
+        0x3333333333333333,
+        0x9999999999999999,
+        0x6666666666666666,
+        0xffffffffffffffff,
+        0x0,
+        0xd0bd0bd0bd0bd0bd,
+        0x2f42f42f42f42f42,
+        0x1c71c71c71c71c71,
+        0xe38e38e38e38e38e,
+        0x4924924924924924,
+        0xb6db6db6db6db6db,
+        0x2f42f42f42f42f42,
+        0xd0bd0bd0bd0bd0bd,
+        0x0,
+        0xffffffffffffffff,
+        0xe38e38e38e38e38e,
+        0x1c71c71c71c71c71,
+        0xb6db6db6db6db6db,
+        0x4924924924924924,
+        0xd0bd0bd0bd0bd0bd,
+        0x2f42f42f42f42f42,
+        0xffffffffffffffff,
+        0x0,
+        0x0,
+        0x73d4e6af65f19248,
+        0x2430486691addec0,
+        0xf825f0817653b70e,
+        0x73d4e6af65f19248,
+        0x0,
+        0x57e4aec9f45c4c88,
+        0x8bf1162e13a22546,
+        0x2430486691addec0,
+        0x57e4aec9f45c4c88,
+        0x0,
+        0xdc15b8e7e7fe69ce,
+        0xf825f0817653b70e,
+        0x8bf1162e13a22546,
+        0xdc15b8e7e7fe69ce,
+        0x0,
     };
 
     return !check_binary_op_64(do_mips64r6_XOR, "xor", b64_expect);
-- 
2.43.0


