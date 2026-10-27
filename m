Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2F606A327
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YVipPBBt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X/cFaEkE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmsa-00019s-69; Tue, 27 Oct 2026 15:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLms9-0000iT-EA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLms6-0002lN-P2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHQbl2639079
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rb4lC6DFBQgmCNM2zBL6kDy1oDECORzC5qj0IKwInZ4=; b=YVipPBBtJD4hPyR3
 YzWmx1ZNAajY4JnqQ9H4edrlrTRqrU2oButwCPvTTgYy+ZkZQ5WaNH6X4RFh4b3B
 DfuRPuR14mZxo50e1bM7tikgD/BQhPifm3uUHjZRU/goJg5hICJOETBq2aQOSsJQ
 rmCba6uUbFuNz3UR2FIfDbhohqs57kAx9sFKaDTiX2t2wFCk7F7tAoVcVpaGMYD9
 7ZCkQEFS+3DfAddIjBTcQTkOG52z3Fc/rQAFtnMbsOx22F1cXKo5OFsa7EAu8tPz
 arebTIG6B27yfeGwbJEx4yILEamTZjZ0gNkBt5ph18NOKTiTqpoSKVphGlWRWbEZ
 e0l1Iw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5u261-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:09 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c70349f65so5394306d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129409; x=1793734209; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rb4lC6DFBQgmCNM2zBL6kDy1oDECORzC5qj0IKwInZ4=;
 b=X/cFaEkEJgdfWNS13V0BJ9VLLGz5XVuqQyS4t+ONnJF2vLwa/4PS3L2dQQ92eMYuHh
 EZyTyZLpBRUPD/LFyEc9ndC7mHvYXmQfeVw4XEYgySFkDaRKEPu581kEj0bZBOs57hZO
 LLhok8H66CnOISpsMM7Gn+tqh1IcNTt34AWgQcacedzXEzXoXThJOdYgAMODh3/2Styn
 WJPup53inIbeSyHGrdJMD/5oUmR3DfShE73+SiknzenWtBG6930s//oICQvHO6T7V29Q
 e9ZMyw0ox9rru6XZre/p7qKvQ0DOPndIY18XO5VQyhgY/zFAfjczY9oapW2h3I6EkQWu
 ol0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129409; x=1793734209;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rb4lC6DFBQgmCNM2zBL6kDy1oDECORzC5qj0IKwInZ4=;
 b=yDtEAV0ETteKJq8BoTyCoCJE7ZEMWRDDFd/Cf9DIgm4TRiKwrsfItd0Htz/4LslU6U
 45QWWs14y/9aI/hy6dcw6ex9EEc16ZElK9AO5PzKdNqWj+ysktWwOQNKJEup0Sg5uYvR
 E8utFaRZuJaBdGdVrs4YMTUh/xSOXWoONg43fXNqazXuSDgCTXjnrjRyndUQUYyhOIOu
 kApx7TqeHG2J5w5DNsaEWiWehyNAsClNdDMszr2gX3KtOdBYGnbaFUy+CZ4XCbb4TqUF
 qdszJqlle6C5jSha6/RFDJARWTiz3NGTqhwHi7Fk5qWXmRRr+R0KHeT4ZZWYw3YMu1ob
 PKbw==
X-Gm-Message-State: AFq9FYKN/rxB8wFPxk1szsdRsOwvpwHM0AfcvSiTNVyi1sOQbBxEejGK
 EIOgdFepSYxOKj0dqfUbOMIxjE9NjE1lNSTMOdKEKedQsfgVQwLFWAgxO45NVGwAUlOwtnweDwL
 1u7JyHEUHcNqMsXLzsa0jewrVhivy2adAS8OqKLP5jnPyBP7+b42bblq0tPbQpblg3g==
X-Gm-Gg: AYBFou32nvMUFgB03PX7UAxAPjKD73TGOymIXqtgpTlFRW9kOs6p2XqN9NsbLtFsGrQ
 rVT23hgSJ1wMEx2ZS/js5gEp1THg/+Zf7kg9A+my7/FC1xUjHUGFcmlsl+9i/2KxiF9UIi7ek8Z
 gBNbBxBvgDcyX0b8uBSkpEqzVX59MQqi19znKo2LfGQYk+dfd0O6h8yiJ3fFcNMUW6Owsme7zIv
 a7HCWHjM/sg8mDZfsGnIDUygAkVsRNTsDQcAIlnG4Ddv5tDw5G8i6kjM/f7ULS44y+gVWlPq3yH
 iUtdIH1fVvqyFAUIlHaYypF2qzHe8KYVYe9y+weL/HXLNNoyKHbQ9djIw4vUKkVOM/QuL8pbai8
 6jAlI3BnDDpYUniO7Q1MWficmETIn5WC1NTwJiUavdvHBwPEHMntIMMFI
X-Received: by 2002:a05:620a:4151:b0:93f:167e:d98d with SMTP id
 af79cd13be357-940ef955128mr1736537985a.43.1793129408839; 
 Tue, 27 Oct 2026 12:30:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4151:b0:93f:167e:d98d with SMTP id
 af79cd13be357-940ef955128mr1736515485a.43.1793129406766; 
 Tue, 27 Oct 2026 12:30:06 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4d8dsm25963697f8f.36.2026.10.27.12.30.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:30:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 56/59] hw/display/xlnx_dp: Make assertions clearer
Date: Tue, 27 Oct 2026 20:23:37 +0100
Message-ID: <20261027192341.9197-57-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX/iuMVD9eFiaz
 nd+Jg1jkY4DY4axJI/SlQckqZXpeCoItFbBq4XHdxj10YdjPOIttdXfHjzmgNPSHIkXVgC4hado
 pFl+WiitvJH328YM41iBV7z6/EuLw9o=
X-Proofpoint-ORIG-GUID: 7g8iexN0pCKUSwIYRtmJs2yrA5l93UjG
X-Proofpoint-GUID: 7g8iexN0pCKUSwIYRtmJs2yrA5l93UjG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX+SLElpdXegBV
 zZX94yArL6ryaX4gPyei5CrEr7VlbVw/Oi1Ew4EALtTeZ7FyEB5CZ/RNwPfDJxTagWbPUR4HMoI
 pkxoDk7k1/mhkHREEoXZUcvb17G/P8WawdU16ZgD4Ix/f4rZ8uyECWn5v0MF95VPimG6ebPRQKN
 OsXcutNqGcLj5pb/mrP7x4sbnHcSmpqIqbLrjz5+cx9G/1IJVAy5s2KRb5J3GpmPx/Hronje1lo
 1FGBadKsb8+4BO2Lcgx0Q9w7D1f7NxScXMgQIXaBmktMQymhpmOxrNf0ToEzOMh2IEIYTEdgc89
 b5+R1W+69M3QoYxB2ze/2c7e9KhHulCR4tzg7GufZj3HW8EMOraJou3lvC/Oeso9g1XssRLWjKJ
 RDwKtFmLBGHLagIC6W4rb6sS5H2xLe1sqwnjzD3hnb1KyAcRbVTguuve6JRHEipUR3AP8ZMilc/
 vf5nLbbqvL95v3uSymg==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae0fbc1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8
 a=PEBbLlxAREG-V7KBnm0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The xlnx_dp code has some assertions in its read and write functions
guarding the fallback "read from core_registers[]" codepath.  The
array can't be overrun because of the defined size of the memory
region, but the read assert is confusingly written and the write
assert seems to be completely garbled.

Replace both with a simple check against the size the array, which
makes it clear that we're asserting that we won't overflow it.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4586
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261026152409.2869104-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/xlnx_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 98126ef320d4..d6b4e7bba612 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -795,10 +795,10 @@ static uint64_t xlnx_dp_read(void *opaque, hwaddr offset, unsigned size)
         ret = 0;
         break;
     default:
-        assert(offset <= (0x3AC >> 2));
         if (offset == (0x3A8 >> 2) || offset == (0x3AC >> 2)) {
             ret = s->core_registers[DP_INT_MASK];
         } else {
+            assert(offset < ARRAY_SIZE(s->core_registers));
             ret = s->core_registers[offset];
         }
         break;
@@ -969,7 +969,7 @@ static void xlnx_dp_write(void *opaque, hwaddr offset, uint64_t value,
         xlnx_dp_update_irq(s);
         break;
     default:
-        assert(offset <= (0x504C >> 2));
+        assert(offset < ARRAY_SIZE(s->core_registers));
         s->core_registers[offset] = value;
         break;
     }
-- 
2.55.0


