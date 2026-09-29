Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1867CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKE-0000Jv-6W; Tue, 29 Sep 2026 17:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKC-0000I3-2n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKA-0003mA-4e
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:19 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THgWoK3301599
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q5mLeMW7SHzVQxiwH9Zns6MX4q/IP6L3UQbysA7XD/Q=; b=YT4jUqgbmxjTNx3J
 Okq6ipOnzHnGtXrFSi0Vlnaf8hFsqL4uwHnjLEncG39Q5tK4FlyicG/gP1iceg3+
 A88CgnThn5MijjO9CTv05yKWNSTlPJON2d6ZEXptkoGPssi6dgZIgGNORb15FOek
 sR7tMfuU9r8x2dj4PzL2ZWpJunEqhXBIQDRo+oL9ie0s3nIoU1ZgZzruAnFFbI2j
 JGVTKEwAxg6Virhv3jCfP/m/tHwSqoejl11cvQ89mnJIHTvBAs8ocAw4FWak72kv
 HTRJVL6f7C0YW5FPSoGZUfwur9z+ZttqnR40wY7+l3T4tleyCcf3AioqJr2T9PZi
 6zMmUg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx27np-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3437d0cc8c7so4867306eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717116; x=1791321916; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q5mLeMW7SHzVQxiwH9Zns6MX4q/IP6L3UQbysA7XD/Q=;
 b=ELHxm4XaOHTWo2ya88ddERRGla+OjbjamG5NuSVvL8NJqmasNnsHx/JCQYwBBeIk0N
 v9BWaeiohWhCyverZDRQEM8hwBR+i1qy0kCY4Yi+Bm8ONByZePLCBGNpYI9Nq84fvnfz
 i3gTJzmgw4k7yITprvqTZriv9hREr7Th83+LIgi8wefWrM8tecDHnl2Xtkb0RB5Rygge
 D+m6qX1Ip7hW4R/5VQoUoke2xpYCismz2giqm3sNtTB+xlOK0vbRiSyoEHOTYG83lT99
 CiRQR2HUH8ZWY95/w28C864tfJdYq3geCWznru3UiTI8/Jf2Ba2Sfhfk8W4Wg22JJDvX
 5SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717116; x=1791321916;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q5mLeMW7SHzVQxiwH9Zns6MX4q/IP6L3UQbysA7XD/Q=;
 b=cqMhoaa/OlJRe5lbXX49J2HbqfRBoNh6JhfaLDOcLtDHYXEnraIDFVEcCVNHnzV8Q+
 MJUvM9I2RbkVxErgTaptsRcMXUJF8P3PEPMVOJL+HBjM6+mgMad+7OWcGNk8Y2PL6IDz
 IFiLY2GILhNON/C94R8/R5P9mCWmiIBa/Rn8svWUE7mUEJQwtuE3iwlLuLKIBW3KIga6
 B6cckTbiyWTIHn9dzD91ybbIgckRjeIzBv6QwgxBqwx45butzBpKdjCpENkWHSWodj0R
 MmdaRcc0IZiFvl3b6dJq+bxP+GDIekV6UWMRirBYKf7IYhHabexAR4zX4VUFTbm+3Mfi
 UNyA==
X-Gm-Message-State: AFq9FYL8soFREhczdYS3IrDRWRgXnRkWjTlgqumsP0szIDt7UheeB7m+
 l2id4fIJMM6dvkdzhuTZuv/hVIXtk3kxTfbJjSKWndSuNiKS48S+VVGqhXSSQLRf5z7jcKI4pQx
 EZ3opvTqmDawVgtjVihRvoXZiAaRq8UViq3VEXeNjFeAboIiNR0wwc/QCINl+uQcyaQ==
X-Gm-Gg: AYBFou3IHbVH6hzxpJ1ybCbO5GryN5YWPKgZAFroFa66nJmknAVPq1FCckxeuxsSEKy
 TpreeqnLUHgQMF6Nev3jUjhKNBJoH3jIWSyCas66CJr9RbJvqSzV8RKWjuqh3DQzDVojrsB9ZCH
 iNTyhqzlCInFo3zE5SVrja9sH5078wjEcxOL4iHIPZ77c3isBqrsvnUagzcO2D7fhaIrVjMsoy+
 gOtzIah2pRSOKGjKyma6K+RgCWpKDoLcPMNTa25uQDCk5HWQf/kAObBU6/l/S3w3s8gXxL0Cece
 Bd4IVxFdpBqGOIzRxmffuOwZvHGwU3VbwKdrfw45IvJiduM5hOlDqhlN0TPzWS7Ws6uw52PF5NV
 FMC0S4CQgamQ6/mN6EKY8R4f4IfZdFgGfMe2AlBxL+fvkreGh05FIeSN/w0dj
X-Received: by 2002:a05:7300:d087:b0:33b:e4ec:234f with SMTP id
 5a478bee46e88-34c641d650emr744277eec.2.1790717115774; 
 Tue, 29 Sep 2026 14:25:15 -0700 (PDT)
X-Received: by 2002:a05:7300:d087:b0:33b:e4ec:234f with SMTP id
 5a478bee46e88-34c641d650emr744244eec.2.1790717115045; 
 Tue, 29 Sep 2026 14:25:15 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 12/24] tests/tcg/mips/include/wrappers_mips64r6.h: add
 missing wrappers for and, nor, or, xor insn
Date: Tue, 29 Sep 2026 21:24:27 +0000
Message-ID: <20260929212439.110454-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX1Cq7yKs2q3Q3
 EX6f0aMfphcV11oYkDx5vc8wxdEuSk/RY7867hMGqEe3uO/8A0WUzUgZI7D4Ou3/L+GkFoAgoa/
 L8/3kOzkgH9o3IDA4vwKY/2I5n8nM7UuY2oqi1tGhy26zhtI87ljyXtcH922T5Doh/gSreKVB+p
 f22XcnbjI1pPhnfr5yLk/L69GSM/eyabTTlNXPFsX54L6e4inYsJUFJElU4bgl1an5WDCplUh0t
 KyrMRu8nAjBT0xqZFcUEn8YYBxZrb3RM1URzGKpjdKdd+sY7SBnz6zIDphgDe9tzJPaDO1YLAbk
 npwyObl29xdsxb0Mg5ZJuWXIIB/j0saiEH6SPLzIHLL5gccVxsKtyfz8qdshQUNqzVL6I2iHWKN
 hHZZTPo+DN+0fNnCBtvmixww31Cx4MtchRLw0DlSjLoVvCqMhfyBcXpsdIlMsuEsPs7dpl5gEqI
 xMuLLoc4SrwMDTePAiQ==
X-Proofpoint-ORIG-GUID: qmmzjD6QuP-7ho-Kd2A-Fhd_NGFE-THa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX181Cs/lgqp01
 nnlwECYMvlyweBnc4R9oxVBozC/y/D9v80wBswznUyZqBN2XOLfPEF2qYZp5XYQWihydYduB3f3
 h96rAuahdfOgm+URuKHpE817AFAOLbk=
X-Proofpoint-GUID: qmmzjD6QuP-7ho-Kd2A-Fhd_NGFE-THa
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abc2cbc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ybKMF2EBzz_YHPg-y3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
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

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips64r6.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/include/wrappers_mips64r6.h
index 33d03de50b2..f078f534f05 100644
--- a/tests/tcg/mips/include/wrappers_mips64r6.h
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -47,7 +47,6 @@ DO_MIPS64R6__RD__RS(DCLZ, dclz)
 DO_MIPS64R6__RD__RS(BITSWAP, bitswap)
 DO_MIPS64R6__RD__RS(DBITSWAP, dbitswap)
 
-
 #define DO_MIPS64R6__RD__RS_RT(suffix, mnemonic)                       \
 static inline void do_mips64r6_##suffix(const void *input1,            \
                                         const void *input2,            \
@@ -80,6 +79,11 @@ DO_MIPS64R6__RD__RS_RT(DMUH, dmuh)
 DO_MIPS64R6__RD__RS_RT(DMULU, dmulu)
 DO_MIPS64R6__RD__RS_RT(DMUHU, dmuhu)
 
+DO_MIPS64R6__RD__RS_RT(AND, and)
+DO_MIPS64R6__RD__RS_RT(NOR, nor)
+DO_MIPS64R6__RD__RS_RT(OR, or)
+DO_MIPS64R6__RD__RS_RT(XOR, xor)
+
 
 #define DO_MIPS64R6__RT__RS_RT(suffix, mnemonic)                       \
 static inline void do_mips64r6_##suffix(const void *input1,            \
-- 
2.43.0


