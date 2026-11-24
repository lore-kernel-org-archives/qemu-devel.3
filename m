Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42AF606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K1rOWJSs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+8de2Kv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwm-0003Q9-T2; Tue, 24 Nov 2026 18:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwk-0003DC-2I
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:10 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwi-00082t-CK
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:09 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMbv77032696
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0PBiGY99R69/dGfLoIuhZLPrGstTlnBq/l+G8ksyDys=; b=K1rOWJSsqXjmZarL
 V+HImBU+N9Ni4VM2rmEtviW9RxUPS2QSkLiTBtdYQwGANxrRvAmamuDJ3HUMw8De
 cif7L6gDj1w0riGIjdfMdg5btva+mqlVhEMiNxZ0bTTJCG3tCxkZPBLczJG5l4ni
 8mJtlTHa2ikTqMxmIWOmR9tJAJkcAVUN7UpZSC3b5nljZm4n9BHPIDDf0N6MAH9s
 T06/EhbgwCSc+wPIr4GYMGbFFNV0TFID50YJerY1sHxRHuKYYjeDAotpz/Zg/ACp
 Kzj4qxG+gfmwl+Rc3Afv3jJ6dLv8voWjqjWFVF8Y2w/T9nMksDw3MH1YaR/5kHy9
 1Yf29g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7tr31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94961511b61so854661585a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562947; x=1796167747; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0PBiGY99R69/dGfLoIuhZLPrGstTlnBq/l+G8ksyDys=;
 b=Q+8de2KvBj4/NutzsxBuZwYV8uom+DwWTQxFSKqjtVHdZMxImgtq63zDG0Tj/Nv/WK
 tVO+fFOSt//30eQdTCuXhtC3g+kykN/nfld7/76IMCHL2OZdkmpIwdpP/WAeh0S8Bknb
 gXF1+0B5f0E7RDGkeq5N+t8BCDnUo6W7ovuTlwhOrLQcEcfT38u229pHdWbyhEreRC56
 2hFL5Hu9mgOy2rN65dHNqgxMmV2t79hv1+f3peqj2TIVUUX68AIdh+46P97jHLDhXJ1c
 6UFr1AbZGn2x6WZJjpzUBOIzm7MGq8XfURmVTXtB8bbIvxedDPEoKJ1m9dy2E+cu1bdE
 GAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562947; x=1796167747;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0PBiGY99R69/dGfLoIuhZLPrGstTlnBq/l+G8ksyDys=;
 b=kqzGNCLHaUAExAMOrFfnyn4DMdK6YM0ftUS+HjB88b/oYQ3Wxg2zUdwCoY81bBWOoy
 vUZOGfIaV/CvdiRjCOtI/ymjYyyxn4JIMb0JH0KuOJPshimlc78w28L9PlrO9LhlDK75
 JF+oSuVFaCaijo5WMB16ZaOOY9y7BKGx3C1UnGKV1Fy51+ATefbMfvJxkg4edYq4kuLl
 ok3u3JDdcY6TTDp2ZOFxj+w/JxQ4gG9RQ0n2I4ZxmFeU98+v9mP/rASFZmxyqzdkpP8O
 DpBjYsynL6M/mwAOjO39cfVVbODnVYh5rXuuJwQy5H23F+amy/CCDdvtt2VY7zl6WxJf
 kV9A==
X-Gm-Message-State: APuU4Z+luVZmVcgecqHe38r0jFLaOiPwl34ZWMQC/e2merndqss2gBTn
 mqC0OxUEdld5H5fH3uSlnhRN+DehCBZ1KdxOZaEjaeDFYWw/HuU71HYU6QAXVth1dLGED6Ghke5
 u8MbByjy7EGaqYrEA4wKwcUdGfSuXnp8XTsm2EAgjGvePDDAakJkv0FWvcXlOjwiw/pXf
X-Gm-Gg: AZFdTZeO3fQTelO497F3WTD322hkii24m143CqVw+el46+q3m4LWSi8Qh2riRTQVGLf
 +MvchcfWiGnK7zDdXosmemroA8BY9EFIKeFvuwR2PUoOuGr/KhHJ9p8B/hRdmt7Hd2HAaNg4q0y
 VD9s9c9fBPKWvcXgtDWYqvAhi3Ayis7rHmP2Tmzp3YJPSSYjX+Ut+bZI80gufUab4kMhd7WO/YO
 8j87R410decDsTQsYrhFQcaj7tWGrUYtWc3PTh+ISdvJZ7LwRGI1KG7FyAnNu4ZUv+aczPpvI4c
 Zbedy+ep+6UEpnHcHunSjlIY/i3rvGOPHlZhk++0y7u+YKQNY9+7fTjeV3tf2MBomBLHTcbs/1y
 2wxMewxxQk53QoyTQNV6fZZ1rwF88hk7qPykktpsAUS92Vz5WsGFTMGMupFoJj0HCEQqgJwQGj9
 HcLvlIwH/3B6eNEw==
X-Received: by 2002:a05:620a:2956:b0:93c:5958:9de9 with SMTP id
 af79cd13be357-949ba98f4d9mr2819486985a.33.1795562946724; 
 Tue, 24 Nov 2026 15:29:06 -0800 (PST)
X-Received: by 2002:a05:620a:2956:b0:93c:5958:9de9 with SMTP id
 af79cd13be357-949ba98f4d9mr2819484485a.33.1795562946311; 
 Tue, 24 Nov 2026 15:29:06 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61e8sm32060618f8f.11.2026.11.24.15.29.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:29:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] target/mips: Pass the right instruction size for
 nanoMIPS RESTORE.JRC
Date: Wed, 25 Nov 2026 00:27:18 +0100
Message-ID: <20261124232722.90234-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX+oTAw2tuQC+2
 YuUk7GnJi/qPGE0FEpYBiftXATxFT7U06LdAtdcNJE5Bagy5q9it57d/gPhb0ZHf0jEjbB/j4T5
 sK2U5xWqKhDk3EpvEB/TnIpVNb3MZlc=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b061dc3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXxdeIotdH11F2
 lqXyhzY+CsR8yZBmnJEH1W3Pv08UWqF0zWet+z83ycJq2nzESRPS8tZu3fkVwUVOIrWVX4E58Ah
 A/mVUQ7iJDcboL17IHaQDlCcNih557lYAiQOV0cwVzpc/ckrNIiwtApjgpTQgBsbA/ZFqRi2BHi
 y+n8sxcMn6RcD1UNhSMTEC78kw0hqLbwMahxHAJzEpYnzwQuHZTKMXyRVZad2wciUsErPGPXrJo
 ncVWSC8+reGIQbfiwKo53QAokF3q2JQgMofF9AkPYQ88UezV6Oxsoe/uUfkDq5N1rHwWo8MBmQM
 VksqomqyUegZy0sNblELi4B2gsaXSBZ8PSk78EUyfye9pTvmuKgqyu5kHEAfr9BD5AHPfx1M/bJ
 ML+vxgavH5mLw0RA8xzzspCPW2J1PCP0ceMgLVg3SyjpTVBa9nQ/sl3hDC8iGXvRtXvgJssy1Q/
 qEs1LVnRc21yaHSQ6CA==
X-Proofpoint-ORIG-GUID: SsbJ0SlFG5AvKa0YUySMXmXpb56Y6zK8
X-Proofpoint-GUID: SsbJ0SlFG5AvKa0YUySMXmXpb56Y6zK8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240092
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

RESTORE.JRC[32] is a 32-bit instruction (MD01247, printed page 155),
but gen_compute_branch_nm() was called with an instruction size of 2
(copy/paste from the 16-bit form), which wrongly set MIPS_HFLAG_B16.

No functional effect: gen_branch() clears MIPS_HFLAG_B16 before
anything reads it.

Fixes: c02809830346 ("target/mips: Add emulation of some nanoMIPS 32-bit instr")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-12-philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index f1462c971a93..39ba96230596 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -3745,7 +3745,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                                 extract32(ctx->opcode, 2, 1),
                                 extract32(ctx->opcode, 3, 9) << 3);
                     if ((ctx->opcode & 3) == NM_RESTORE_JRC) {
-                        gen_compute_branch_nm(ctx, OPC_JR, 2, 31, 0, 0);
+                        gen_compute_branch_nm(ctx, OPC_JR, 4, 31, 0, 0);
                     }
                     break;
                 default:
-- 
2.55.0


