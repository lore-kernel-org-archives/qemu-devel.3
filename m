Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A88606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kIV9YHCJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eyU2hQTy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJNhh-0003dv-JI; Wed, 21 Oct 2026 00:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNhf-0003dd-Rh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 00:13:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNhd-0000OZ-24
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 00:13:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F2Ph2898043
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5lAb9kY0VH+PQ6Sz9soSSP
 jvhuJhxlfFkH8nLlKoWUY=; b=kIV9YHCJBSODPOEYWAIxyJthOn0awSUxVsCD9w
 GSSNhy34spAsKLf8xg3qjRbkqsNDSToa4vwDttzpUIYQxBBc8HIVMeHhJPLp4rKf
 9Zhe2tNHloBWAiUSksl1jd9atgMmbv3G/zUKBAaSykCPWL7BDmZ6rUA2jJIK9htp
 1qvPT5VRh7LdSEAOG8ccE8Z54oa8+IdTcuQ0x9Sf0wj64grbEVo+DBREQhxotIUz
 g6mJ7DhSKG1i8kSUHA9NFD+52zTchek0cJ4/S3GfXWyuCdZlXidwp6WG2aTca5tp
 hxcLT5NmAAoQIbGo8XkCoOxAp3sKslAVCnLdTCx9Z88cRRBw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0hw3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:13:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f37c94ceeso260689085a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 21:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792555993; x=1793160793; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5lAb9kY0VH+PQ6Sz9soSSPjvhuJhxlfFkH8nLlKoWUY=;
 b=eyU2hQTyS0ajiZsid5e7Xo7pgJc52aRfTwMHpIqLiKi1Tag+sxeMk/lTtN/QMwp4VL
 i8wm8pUsTznxxSI+pRxW8Psonf4c9GOWM/H4COrTUMseT7J9xXwDleAZjn0P/hO7wEEB
 2ssriSE25yFBif150eXq7ZhG4kHP6ifvoDS6lnq+6y0CLjnyD29wCN7vHyYmIv5trquj
 Gtol7wpAa7v7su4LjK/hYw6ZQipSbMLdz9nDSTKt6qxcxTv5Qw7TEE65emDOUmX+2qUS
 o+3dDDYoFQKFO3RH+E0XanLlf2Wa/GnO31FoqMQFitzNXc4HUMabiPB8hUXMx4xa3UXt
 DwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792555993; x=1793160793;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5lAb9kY0VH+PQ6Sz9soSSPjvhuJhxlfFkH8nLlKoWUY=;
 b=zYHnwxr8GKo7zjCJwJaEGS3fJQEcU+w0nvtsISb43jdnHuw4P4txNHPpiWgsgvciV/
 L8LJ/KjlwjxYLgMSiKiwya/A5PlrxIVHKm0jwxORu8oirn4fRv3h/Q1xTCc/oX/XdSbI
 HDqRXAbc6H3Zv+L2XfjFNDlPyt0H7O//RX5dBzLoxLlCrIUfVLGr8IJqazrUUDB04M6V
 iM8qeXSjfE6cmeSZF0BkPDzzwaF6PbkGi2CLr9lvJE2gx88rnh2RwVxF5MEn/6OdGD0B
 VUxAaQ9WvsxdG9aSSTeiDcuXqc0BuuTcXSiRP5puav+NH8NOFeeSo1myo3eHiwdBdEAY
 hT4w==
X-Gm-Message-State: AFq9FYJzCDKMugdtKaIP2CXEMTimzTcr58HnCTqgLQ9+xT40u/6apCbr
 e6GGXhHCOy8hoSYETYQxcbv+WP6Ku+MTxqV1YFjpxE96NBKnnjoTm3i4g4H4r+fHjOIRi4sCg3K
 Ggmo24ypXO/aXnw2Uphz8ib7d+Yt0Hg4SnbeVJ1t5jYW/qg+L4+y3x8SJN9ZfTk3NlVdB
X-Gm-Gg: AYBFou0as0pG1dwFtlVkkMRaZhJVAk3t13OgSES09l+vwWSJ3rv9p7eXREN24sVsQVZ
 WLMQD9yO1RpM3qpxoZCfhYIacMJouhVlzmn88EXsZfMWDE0XCLLivLE48/FopEhKW2KC+Sh9lXc
 a5d30gZJzvCsX17CCiZI9WZqzXSbmvdabfwr/eHSpUvHPelPoa5PCy98Ajf1maKRxTAivu8kaGP
 Lqt4S75Xxy8aoV3z2+ctRfaXYHcgo2X8LpF+G2QNS7b/Iu9nlb780qO+pfeK2Z9503XmG+FNxo1
 UABIfGzSTo7bt3IRAmeU2puHNihhEHvNrdsVtCCEj0aCDdbQNVSS96kXNh+3KaLSzSGNGqaDo09
 xZY452PSBlf0SGR6XNaKn1z81J0BJ7BGai7yyZPUz
X-Received: by 2002:a05:620a:600b:b0:93e:fcac:a91f with SMTP id
 af79cd13be357-93f4c9975d1mr687323485a.37.1792555993182; 
 Tue, 20 Oct 2026 21:13:13 -0700 (PDT)
X-Received: by 2002:a05:620a:600b:b0:93e:fcac:a91f with SMTP id
 af79cd13be357-93f4c9975d1mr687322485a.37.1792555992740; 
 Tue, 20 Oct 2026 21:13:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb859326sm46538485e9.10.2026.10.20.21.13.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 21:13:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/sparc: Remove NO_READ_GLOBALS flag on saved/restored
 helpers
Date: Wed, 21 Oct 2026 06:13:10 +0200
Message-ID: <20261021041310.26960-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNiBTYWx0ZWRfX6C45GLc20OOj
 729K0YOvN8BcJtJqDZ7e1MEqYSlGy0VO9LDznWfa73d4cvKk/NNs9WxenP1UB/LKGH8IahSnPqa
 lsTZrWnBx1PGRBR1kK63SHZ+P6EBBYf4/oeFwdb7anlZUJoXD87ia9GdhdG9rPhKItViFKaiABf
 xgqxTe7YE3ujuL8H5SYUWz4FM4e3Wl/GUx0DonnzuHvn7yZu6xcPy5C8xDwowfng7FQNw0dYM4y
 XxaLyT6aG7kVVIC+4RnoYuCl0oGchCLf+3r74dEhETXLtbxkGZsfY0ix8z/2MxQjFBeMNdQmb0J
 htA4e7dQIaYJxw8LCJJ+SgdyqdYbeWgDdhvq8I99xex8DTsRYBjunqxXp4GIyApZVHWPMlAJuIt
 S7m87fsl7VcPa4pbuApVpWRjajvgTD4pzZ6QIo2DWdqYLPKH4PJeoXaopRcMGBoRLKlsQHtWJTf
 88GZFPVYiwoUO1xqnXQ==
X-Proofpoint-ORIG-GUID: yTzVDPo6DVgfmejniD_trua2y64PICOj
X-Proofpoint-GUID: yTzVDPo6DVgfmejniD_trua2y64PICOj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNiBTYWx0ZWRfXxLQ5nzORv1/p
 Mq5E6Z3pkrUirk9Mghg+bMjcgHgBWGCWOf/RpcMjnnWsT7AgBy6y/ljvA3GOwPswFsuQUd28ffk
 8pCBs6b675NFq21OTrvyo1xtNmASxD0=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad83bda cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iZfPhBtWR5Eut53SbJgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210016
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The NO_READ_GLOBALS flags are incorrect: helper_saved()
reads env::otherwin, helper_restored() reads env::otherwin
and env::cleanwin. Drop to plain DEF_HELPER_1; the helpers
have side effects regardless, so translation behavior is
unchanged.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sparc/helper.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 4be84622c89..758fcf2ba68 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -11,8 +11,8 @@ DEF_HELPER_2(wrpstate, void, env, tl)
 DEF_HELPER_1(done, void, env)
 DEF_HELPER_1(retry, void, env)
 DEF_HELPER_FLAGS_1(flushw, TCG_CALL_NO_WG, void, env)
-DEF_HELPER_FLAGS_1(saved, TCG_CALL_NO_RWG, void, env)
-DEF_HELPER_FLAGS_1(restored, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_1(saved, void, env)
+DEF_HELPER_1(restored, void, env)
 DEF_HELPER_1(rdccr, tl, env)
 DEF_HELPER_2(wrccr, void, env, tl)
 DEF_HELPER_1(rdcwp, tl, env)
-- 
2.55.0


