Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98163606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m0iPV1Cv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=esAF1zpr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT61Y-0001FE-Cq; Mon, 16 Nov 2026 18:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT61Q-0001Cf-FN
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:22:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT61O-0007V9-R3
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:22:00 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJeleG2727613
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=T9UTjdBRQMU+G2Bx74YX+z
 fL+IVC+D9CKcLtszSjWcI=; b=m0iPV1Cv2Yzb7Ed0Jnj/yF/4vzA4S7+Brx6gL/
 BvLeRXgeBgmHcn854l46oizrbZEuQWXfdAXV/MV6FzibjIPoiOLODRJHuqd9tstl
 i8lG7Nws8BNGP1kHmTehil+f4ZGu84aqLsl22/NPKJb2IpZLnuYzjFkgHa8FPIEf
 CKfNsGDdJgky7/0kP4PeXZqVHfOKYyLCbqRgVCrhNgFC9aXTaxdcCvDT+QS6o0Ou
 VoTEahZH2XrVbnY6i+fEPvxDFDQuCL+rNH9Ls0xZVMZHdobwS2Y4PKldqOmFUWtA
 hT7OMAkhbRDTL6LyDOhIcDt4JmqpxeS8OV25lO4w/qWBM0dQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07reguke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:21:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b3b0ebd98cso123638a91.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871316; x=1795476116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T9UTjdBRQMU+G2Bx74YX+zfL+IVC+D9CKcLtszSjWcI=;
 b=esAF1zpravuc0E2s9I9Eh7AYSUsI9aDalkvtKKdPEs/hn14+MF13aHSZTq7TjC++ip
 th2QZg6970eX2AW//jLuEkLc2+fFuFypJGmP1KNn7TqL9aBF6PJo4Vcchqs3eqX9If76
 iLejngR/R0p+NwaCVsAjuWOccUK+H7FSZDAC3bWrkB5dUUZNvUKMMn4AKwdRFHH6+jgR
 iBg2XmhdZ/baEqSIqAK42UNXd7q8Lq6sIZoVF9/0UT0cobws5hbC8YGOx5efzdTb5tWC
 ISevWfCe4jW2Qcc5ZwCf59Yrj26n+V3484NhEp8IxB6u2iYZX1T1Ssd6FJ6wP9CusyoZ
 eIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871316; x=1795476116;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T9UTjdBRQMU+G2Bx74YX+zfL+IVC+D9CKcLtszSjWcI=;
 b=LjTPHpEO2tIrIa+3/RJz/O8i9+okjJvETWO51TmF5BGTDdDHWmu5JqZHms0NZjOm28
 1lgu9BcC6NgV9z1anNvLHyCntuDYjxTEcuaOZ0FQNOWAXYOZLjGPdhmGWQyy6XO7HuA+
 xEr8Zyv2l6sFw6QPZwcVX1206/D1gv6huIXCctgIT+weZIT+V9MIJv8eNSWUcLlyr1JW
 Fm7JPdX7Mn2+GnNX2fq5uOzc2OPiDK1v/BPaleH5apIXt21YuKFtLSq8o/tjke0UWXPz
 0dM9nfjSpLuYbGj3q4fHXA0hAHyP2C5GDlXPCWBi9mez6x1dKNNgiHWU7mzDHMgu8DMk
 oCfg==
X-Gm-Message-State: APuU4Z/P5eYFeCfnzOz6qbv46MEB2wgE1t8TOFo9/7Low/5C6FwePMTx
 zKVPw20ADTaZfmNQ+OaeGS4UcrD0NLdBbM09/6mQC7o1iwWJoPG5RBHPoZtyhR7GJ9nBHunKtl0
 e88cZcsr9ykfleCIWBBqufMSlyPVKxLFVXQDRMLhJzKdeS6CbhsK8JTpxTFU6ggN0kg==
X-Gm-Gg: AZFdTZdR3E8Qz0rqMkfL2LFEQTy13f47s0dmP/g33jNH96Ig1q8F10/N0hupD0rpRkn
 +PWzl+F44GqJZnPKD18ZTXhKWB7w1ZEaUYRXzZpjS/YMhd1D07yvhVk1iN71ZlNYitep1tRzaDE
 FYi0Q9srMWs2JOFFRzgrupvZe8zlIzlGY904ND3dkNvzEFQwr0rawTE8EAxkE/G6JEbB+1vZrTv
 Wy270iDIPjh9p/x125z10jhFibEbbqkmpAmYuAkjqobhefPEBeA8u0wSm9vPyaWqJ2ZAk/UnL1l
 /pe7WXezH5DXr6w/lcCkzi9Zw6Ml6mu1+8T0vHqnc5i0oRNFOMXpSuhUm+JH8c4QeyHEz4DLqjX
 i98EMHfrXRZSSNohxnHAjHPAo2wwmdt+4KOEWebEM5Qtr3R3hmtWjb56nSMD6feUBDz3Y8nRTw9
 0KpdBR0srW6PbDiTUIwVBX1aVFA+zRNslNZroc
X-Received: by 2002:a17:90b:2b45:b0:3a4:e735:b39d with SMTP id
 98e67ed59e1d1-3b1b0cccea5mr10440135a91.64.1794871315904; 
 Mon, 16 Nov 2026 15:21:55 -0800 (PST)
X-Received: by 2002:a17:90b:2b45:b0:3a4:e735:b39d with SMTP id
 98e67ed59e1d1-3b1b0cccea5mr10440110a91.64.1794871315430; 
 Mon, 16 Nov 2026 15:21:55 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abe77179sm1059550a91.11.2026.11.16.15.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 15:21:55 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/2] tcg-tests: detect redundant exe_name/test_name
Date: Mon, 16 Nov 2026 16:21:38 -0700
Message-ID: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXyt7FrUkaz//6
 i81vVrf8O6/Y0Ow2IbsDtGJBTaRfuhtGNSidY9FY1KW/awNnWQstxuRN7/JJa73qkrZNFGHQMBt
 phDYkJ6j1EYIAde8nEgaaOoYbbEwQHQ=
X-Proofpoint-ORIG-GUID: 3CoRvPdVYxskiMuOAMUx8ex47hipd1LX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX+5NInV2fm7PS
 iDGgZqvT/lZq6H/cMH/d4so3F9rQgnsLwaRSUs1Z97jLQgM571RX6gofYKV/5wyvAn33i0mFktu
 X3bVSKR8SzVkzQk9ANWLJiFH+tuAPttSa+2z3CG5nSX3Mp0dxF+hzH1HhzTmLfk22JiZJbnl/SP
 biyJ1TyD+ebCCisyhuaa8Nb29DsSRST2DvV28XJJGsCbCpigGWS17YDC4xxjQL4YDnA+zJrLrkf
 JCcP0CpPZGSLGDaNoyO0hI2GYTJbabqIHU7JyseHS86hXrXAx7ztSoQBJ7fhg7ePIiAMUx4BfiT
 lgp2mdBM5dFnMl8jhb1A+hucPyqnb/c7adxbF5/YxoP1JTC8EcFaV/mG6B/fst3DvrgdR1vOSw+
 NpY61c/wAZPHieBO70LI1QbqCAFiMrHsN3yfVHVgFYeM9smLC9s5/rroWoFBqAGb8lq5ZNKPnGo
 uDUm9RoK6jwiHO427Nw==
X-Proofpoint-GUID: 3CoRvPdVYxskiMuOAMUx8ex47hipd1LX
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb9014 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=wWiGVp9yJhZXvw6-tjkA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Detect and report an error if set exe_name/test_name matches the default one,
thus explaining to developer it's not needed to set it.

Pierrick Bouvier (2):
  tests/tcg/riscv64/system: remove exe_name as it's already the default
    one
  tests/tcg: detect redundant exe_name/test_name

 tests/tcg/meson.build                | 8 ++++++++
 tests/tcg/riscv64/system/meson.build | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.47.3


