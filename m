Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AA1C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKG-000208-1F; Thu, 24 Sep 2026 11:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJS-0001mJ-6C
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJP-0000Dy-C5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:41 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OEW61Z2322316
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LuzzBNNYUkquyYLmfrOKR0ofZqga5fNjsljg49B3N1Q=; b=PTL6lU9oCCK+6Lz0
 1ui038RkL6XHsYDeYa1mDWm9zEyMrYiet9JUkFog70VYXlwPVWhaFVEdsZlKYGUy
 x3hdtKaEIudk306nCEKuPGx81RSfrxffsMIcLph1SZExIUE3zufamspJqQFAL2AU
 1oGQ24OJrqL9bGOPAsuBziBy9/An9CXCHuuqujXFEE5jfqnEtIEq9eK1NJb8UXXB
 /Y/bcfE/T+icoZjPrQPEFZwSyO04lsUDeWAnpsd5BQICBwM8mnGauyuisMggotfX
 jTfBVv6QjtuPqkEio4CM77SmXr3u7ZXWK/WUuYlgs1093Jme35v/Yjgc4dXqgsks
 2ufe2g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw5q8r7se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:35 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so1682788241.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263475; x=1790868275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LuzzBNNYUkquyYLmfrOKR0ofZqga5fNjsljg49B3N1Q=;
 b=elW6cGCtYLKvbre0ls4yKlWFPR3J253XmP/yLQ1fUa2WXIiuaXDgxXQq3x/BSuLeGc
 JJ3eX7/u+r2w3IV9L+UPwfKOTo6TEQiRI4EiZ/bzsrcqlxkKkmB6HUUq19G3+IhpHhjp
 DW4UNrqdSF5e++n5B+W90iF6z7raBZwKlzuQoLv3v1Hhf1bQJjre7ztfrDrIv+26ES0D
 L77Ij6GVaqIHuzLx3SvPqeQ9j6/xgrT+3Jnl0OS3s4gMkp3DqEe83TdvP8gF5NqCrIpL
 u05yIm16SNdaIkP6fuOjWox+613M6zQKdzY7UHT7hf7k7L0J7djlrLrwxgnXsHl0b3sL
 tB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263475; x=1790868275;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LuzzBNNYUkquyYLmfrOKR0ofZqga5fNjsljg49B3N1Q=;
 b=SeQX9krbc3tWu8UQ8WxxXkQmPnAR9HTfbIgYEvBd5IZgMdeP+6vweacaA2QQsPyR2S
 1lVVy1LIvoPcDWg7qBa1NXdLMOH5FvLR3j4u12/HKfucn5z6Z8DSS0qcDUyft/nYuELu
 5gV/DsfOjlv+NypBtvPaki8pksMyRDfAJued0onb8CRgqnQb6NHoDp6ncb2p71kVlVw/
 Q3NKEhNGHOw0Fk6m/qhdjP3zgJD1lDY3/AOsUULgo1IGcVgF2DN5tWcFbVMVhSgOdVOZ
 rYakcdDhU3pEaKfSbscBbRr/c2KbGZRH7o5o6FK5dq2sKpAD5SICKshePItvYNTdKxbz
 ASRA==
X-Gm-Message-State: AFuF++kwmN8hDiUDaqq5O2d5AhRVPEDqlCD9Bjzy3BUMStCegUHG2fdL
 m8hV9Q9+d79lhFVCHLEnFVxIvHAXadSBuNd+t7+O29gDTLQMmyhgkNx5hdc0VtoM5+gB8SH4WU/
 rUnIy9gLDt14cuW/dVQBYIMvcPljqQUBHVXw53W2SdPK75RQ9qA/yP1c+H+uwPQbNfQ==
X-Gm-Gg: AYBFou2MIQAcpr0E+ncLcrzsaYQvP1iCSGpVdzYRhmmrgkDsvSvR6ckWnbRpSDTlTXX
 Pki6TJU7EGvTuo/Lci6fSRnty7tmlVNXT5Z47U4cuk9CWzRKnJ+CXfO3T2x3bIU1u4GSDcHx+Bq
 lglG0CxzBkNMv4p83LFkWJadiOfaIb/Ke1zx4u0DyezTAL/xHfJ2qg+3EvyzpVAk0kwPcQhYwip
 27SuGMgyFGnFfcdZBnX+th3M/NLSjk8KT9MWE6sslTOgWbsJzmNdIXLzDg1kp/cFe9QAwIZ4MhW
 BWXeJJd86JFSb//Wto4JoxOdVfnyRAebo+ne//xEcgbr7iX+P/C6PAz+rknO2RRLUQ0qNTedGUJ
 CtItMGA1piqASp1/qY2a/otQZfQ2LhVI0ZUVGC8ZA
X-Received: by 2002:a05:6102:2ad4:b0:7a1:dca9:8563 with SMTP id
 ada2fe7eead31-7af1cc97bcfmr1510494137.12.1790263475212; 
 Thu, 24 Sep 2026 08:24:35 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad4:b0:7a1:dca9:8563 with SMTP id
 ada2fe7eead31-7af1cc97bcfmr1510474137.12.1790263474708; 
 Thu, 24 Sep 2026 08:24:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5df44f9sm69935265e9.11.2026.09.24.08.24.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:24:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] target/mips: Drop zero optimization in gen_mxu_s32mul
Date: Thu, 24 Sep 2026 17:23:37 +0200
Message-ID: <20260924152353.36209-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX1Z7MjI3xeloq
 IZ9TQYqom91EiAhK5ReGVdCTmIRXDtgyXMBfnMlaVVhZpUQfftny0HvHRCCpbZcQvI+fwVftk2R
 YulowRTygsPYgjupEK1GOk8B97Z/rRY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXzpxQq4fZg3i0
 hlYOAgIm1Gjpkr/AX6OEyF93X9WoYvjcqLXlw69WBnZRxuVyuCMfN0qmRsNRAI4WOUvIfK4n2+1
 G1ZduAVC9WNdY7ztUNgytgm0uGHGxvejSht2ezZ08TjKQRiUwi5ywZyUgaGjeUfE+Q/PgJAD3W3
 vaEmeMVVyUyXWE+bTM7BBpOM+chpWucpNpf1azpGz1y4wE5jYIetLcHRRhPFQ5o3ntcLB5v1Ltc
 sFfagCBu9WaqW+manulj+FE4HhrdU1ytb+fuoHExfygRXhV+WcjhmEscMXdeOSrc+vLkTXOuL+D
 TkwbR0offRUNFt+RKSoynXB8upRXKIexVJTMx8EDtZmFQVdJDHwENyk5hsOcBxGfEfYI5rj+dNe
 I7bleDhS9zoGEAprX28cqbM1GVj0E2Us6lKyBoR+KgXqd7cDIU0mHTxREghr1Mzh72BsXdWnseV
 aMZ9HRmkaESDSRG6FBA==
X-Authority-Analysis: v=2.4 cv=SYRi5fRu c=1 sm=1 tr=0 ts=6ab540b3 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UbgK6sZ85PiArCHPYcEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PUVz_a-9VustC525UAvXyqPht9DqndfX
X-Proofpoint-ORIG-GUID: PUVz_a-9VustC525UAvXyqPht9DqndfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240063
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

From: Richard Henderson <richard.henderson@linaro.org>

In the unlikely event of the architecturally valid case
of using the zero register as a multiply input, this will
be folded away during optimize.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260914230901.1781309-3-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/mxu_translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 9559b8aada3..f30883f976f 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -964,18 +964,13 @@ static void gen_mxu_s32mul(DisasContext *ctx, bool mulu)
     rs  = extract32(ctx->opcode, 16, 5);
     rt  = extract32(ctx->opcode, 21, 5);
 
-    if (unlikely(rs == 0 || rt == 0)) {
-        tcg_gen_movi_i32(t0, 0);
-        tcg_gen_movi_i32(t1, 0);
-    } else {
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
 
-        if (mulu) {
-            tcg_gen_mulu2_i32(t0, t1, t0, t1);
-        } else {
-            tcg_gen_muls2_i32(t0, t1, t0, t1);
-        }
+    if (mulu) {
+        tcg_gen_mulu2_i32(t0, t1, t0, t1);
+    } else {
+        tcg_gen_muls2_i32(t0, t1, t0, t1);
     }
     tcg_gen_mov_i32(cpu_HI[0], t1);
     tcg_gen_mov_i32(cpu_LO[0], t0);
-- 
2.53.0


