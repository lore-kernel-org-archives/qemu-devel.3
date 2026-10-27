Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADA606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=csy0U42v;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=No1CLEQg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmu2-0002B7-IO; Tue, 27 Oct 2026 15:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmsN-0001EX-W2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmsL-0002n1-3Q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHMgR2088124
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QHqqBbaliFnB99gQymbuZMNdc1lJfMvoM2sK3tOO2gw=; b=csy0U42vH7l4z0Ty
 j1F9Zo45Z3kS2E/fih366rbNh+I9uKogJ2oY6Ao30EWez+H7UXBOA76MivDCoroN
 QFyjBGU64o52rTTB1/mPxuhnIV6fvOO5jlBONyqMoqJGu8ysjSKnhRCP/zkA5Ivu
 f0VIbUm3t+5/fbVCHJzKYwx/BOE/ktpftqGk0mK5jQLr/h2AGk+cGnGex8koZCXE
 gOXx/+f8rpuuW0i7NTd5iWupE2wiu/mDSBvoT1fpfjvmK7zK0HsAmZHnVsgA63Zp
 Te7jrAjhp3v0ksmN9dVGGVPU21po8gQaVEi1OpZQep1nhhIXrRNwm/PJko1KIB6K
 R7X7Mw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2tbbek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f62934ef6so25699685a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129422; x=1793734222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QHqqBbaliFnB99gQymbuZMNdc1lJfMvoM2sK3tOO2gw=;
 b=No1CLEQgPL5es6YMSABjQncV5D4tQU5cVZrocGaJC6bPmI1lpK7iF4wTStCDFeVNud
 CM72ue8jcdzGHsQO1aplJyfaxBrpBUyJcjK1QWLfC3xzeCxd8CLKYOKekrxggtaAp5Yt
 wM2fCRmYwE9Fr5oJDkI23AAJxdnU7vjy/yQAk70kjen4h4Xs9X6uGXjj2y9+DdO8DTFT
 u6p/JjlUonLSITqUz+w7jsWAP/r0BAQYqcPENrec8soOk8iYsGdeMJqmkQTQHovomp0F
 1hNoyXxPnfYvBP+vtYVvWRoBhVeA++DsK/OxD2zaGBQF/2O/C3JNCphyKoyMV4pL8Eb5
 IOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129422; x=1793734222;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QHqqBbaliFnB99gQymbuZMNdc1lJfMvoM2sK3tOO2gw=;
 b=znRMu+PrdYiul81GKnCjU/YnGmraqZ68gQO+XWZEuR6PSlwsuI+YzzVgIZJpPfuRzE
 fFReLHZvofCW8ap/d2NA/N1xZUrkhyR2kjKaccMgV5fwWihmPSX2xnfBBWBBvBWEn7eO
 d6OKUkxoY3Sp8QZ8PeeZUAibDose1G2mWwE2z3Ng01exVRI9Fp+6MLfR/Lw+H8Vdah8h
 FTgPSmNMB/iidzvfWPT7wWmgeF3qUIRq+76d2A2XZ9vgMX2a42VsPUN7WINxE42fgoW2
 4I35KUaU111rff522I+kEQbnIatHDtZKbF/cbNsP4Fw2cJUT057snQimtPW4JsbmFylV
 v/XQ==
X-Gm-Message-State: AFq9FYLOUw8xKXc/35bZjPMen+F3PVaSsPRvP0SRYrJMo1LTVRi7h9jm
 Q/41C9LJCzFaO2zvoB84elo7HVt+fb+0dF0gfe8OsZyxhCWVp1k8L7BJOSgz9xIDgHOB7DHOAY0
 mv0i5qBes8xMMWUXeC8tOX74S5pMaFflyaP1C82abLS95BMMDD37cLLlUe2CygjfbtQ==
X-Gm-Gg: AYBFou1zX/fY3FJnLQanzJO4AwxqsZu1N4z5SaA2rSIMkbSB3x3zGbq39Xi1RWYyiGe
 gnwqnvviYTCd+Pg3321BY7usUyQ1uRlkEzjeIilytfHf48Vx+mofzumVAh4hd7h9/sAhAp/32oT
 SdC8majBF7LDUocJoCz0ZLqh/mB6YE6ir4D2Rt6osZCwVQkU1yeGn/41s17L0dNeBsKzKRASITO
 efeoAAT0/eNFIbysG+mUTr5frBwOStX/aA0Bh/MTrVspxPOxmtgWl9dl/T923CA1ZmbG9Y4RkHP
 yW9rylzr3Fiy+EbwCeJ/ASipyrfah34JK94e1xS6gtqyrpn7lWBpf7ORE+ES6BgcEjd6uVw6Pwy
 sazoaDUp0gIcbSsvhgII4YuMyB6oYFfvaLf4RxWmDeKXwcd8swMELPKRy
X-Received: by 2002:a05:620a:31a1:b0:93b:db80:e0cf with SMTP id
 af79cd13be357-940ef9141a7mr1616439185a.60.1793129421757; 
 Tue, 27 Oct 2026 12:30:21 -0700 (PDT)
X-Received: by 2002:a05:620a:31a1:b0:93b:db80:e0cf with SMTP id
 af79cd13be357-940ef9141a7mr1616434285a.60.1793129421275; 
 Tue, 27 Oct 2026 12:30:21 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92e103d91sm4852085e9.0.2026.10.27.12.30.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:30:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 58/59] qemu/arch-defs: Use SYS_EMU_TARGET__MAX to define
 QEMU_ARCH_ALL
Date: Tue, 27 Oct 2026 20:23:39 +0100
Message-ID: <20261027192341.9197-59-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0fbcf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Kwhbg8pJGtqcix1HUGwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: iImLIB4GGtFvUAxN6c9bgIadicq_5T42
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX/ML/9hNaZUrM
 A02HYZkxSz87vIHq6y7GqbgsbFVF3EMHosyjxALcfTnoXoLyt67mlVnwpdYqah315o1L795vsfj
 egojxEGiEkAiYTLti8YgW/g1m8Z5aXA=
X-Proofpoint-ORIG-GUID: iImLIB4GGtFvUAxN6c9bgIadicq_5T42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX8hCfcpLtfldz
 8Qecg+YFgMXMN0rol5gPOdxoawS733YshLHI9Y//cK1nB4S1vacistlNevXGscpV1s2CEQzbnAi
 qRXGHdynvVbMRsDkEZvPys3mzby8aCfU3d2GCrbqMyiJzCyE41+Q6uFw7NmzfaMC9Ku3DtK6xU+
 RS90FJQgk4/45seWbkBDtf645CihXHV/xkmdFKdsNK74K7ZVMrr60lGgEdIWCWStamzth1vHeEQ
 IWIZMvMHQ29H0K/pBI5/z57LI/Zbiwdzi/OzBul2xNB80apgZLkR6B7InNczw8LyC5yhoXjYpys
 HbRoPiHoTb6PanIWQhh9q/eGF0KyfK5EzG8DaGx5h4IySdAKFgXffx08Trs8iiNFdhDVG5SNLhY
 P2g/K8OCDZQalN7t+bI5PTjHF8ONviD0YS3SaQSS3rtz3wKN6sjDoMv48hXgXxE1Vb9vWJMt0gO
 qSsWfqyODOGLSW72fCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yonggang Luo <luoyonggang@gmail.com>

This is more precise, so we can iterate all target_arch with QEMU_ARCH_ALL

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261027061504.2213-3-luoyonggang@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qemu/base-arch-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/base-arch-defs.h b/include/qemu/base-arch-defs.h
index 806ad8094a41..a6478c2d3fff 100644
--- a/include/qemu/base-arch-defs.h
+++ b/include/qemu/base-arch-defs.h
@@ -41,7 +41,7 @@ enum {
     QEMU_ARCH_AVR =         QEMU_ARCH_BIT(SYS_EMU_TARGET_AVR),
     QEMU_ARCH_HEXAGON =     QEMU_ARCH_BIT(SYS_EMU_TARGET_HEXAGON),
     QEMU_ARCH_LOONGARCH =   QEMU_ARCH_BIT(SYS_EMU_TARGET_LOONGARCH64),
-    QEMU_ARCH_ALL =         UINT32_MAX,
+    QEMU_ARCH_ALL =         QEMU_ARCH_BIT(SYS_EMU_TARGET__MAX) - 1,
 };
 
 QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
-- 
2.55.0


