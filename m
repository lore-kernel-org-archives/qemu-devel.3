Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57C606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EYRszEOL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RHswLpcI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV3v-0004jQ-8I; Sat, 24 Oct 2026 02:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3k-0004eO-Ry
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3j-0004b9-DL
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O2BnfP820260
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1jg1MnlkMAh
 /rW62uNJ9wJuWlx4lQP/LXDP2g5aBCL8=; b=EYRszEOLFBu4capb6hrTLFgZijH
 dHnM9nKL1x0yfqf7S1Rv1e9fQg+DSlAYA4ObiZwWGOQ3GmBIaBgzcR3Id1OPpPEw
 OBAne5J2VgyocDpUW1ICxV5TaZ/Ti5aSbuLYFIqVMSZzg8ieTGD+C1OnJ9CEa9Sl
 o2UxgpQdkAhhhoAr+GQS2PJcPeBFD1SAcJPA6YeD7n2pjJreC9Jjs40yt86/8CA2
 bYObPfn9YYqpg4nU3dVeLZstO6DXJ4Ilm5tUrOcrSz5ruIySfBuGbfOHuiNzh2iv
 eP53VWqNrCfRSTdpDeTX3Zc608o9j3j1mtIzwDjCULeBLLM7XpEdY3UzlHQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6gekv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adeba76cadso292158a91.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822609; x=1793427409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1jg1MnlkMAh/rW62uNJ9wJuWlx4lQP/LXDP2g5aBCL8=;
 b=RHswLpcI7AJZPFigGnDKtfnKoGVh7sw/Iq0MhZ2LBY8xTtsJSWJsec3JL3YbZidcTm
 R45+/xwkDluIJEFvftgqGIqs5C3VrlPYcGYQM79C2R6+DL7LXvYWNGyA0m5cFXQWyaUs
 xsNVCWxcPkpGzUJrlXBZl4HQsT6OmAdWf6+Q4yZ5LnnVX0tB0lW4AaWhduJGWdKfixbY
 XKOj5F6XDyyunLQn3OjzHpgouUykk0oLW2v7M1dWsSVBsLBWGhblm6Fo9I2DfW4nGCvx
 tEODTBctuTOOUUQYuvh/IxLR/ojvzDJYMlTKn2hkMBZuCqscPnmxfmEJkm5j6oQF0DDI
 Edcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822609; x=1793427409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1jg1MnlkMAh/rW62uNJ9wJuWlx4lQP/LXDP2g5aBCL8=;
 b=apJfhP3OmkwNQRSMiZUHxRdA0QeNdnmNJ47b2P9wmdZ/WCvA+hFC7WnwcIpobJqmR+
 k4HlM5YkuTSMeV1ql5X84dvXHcOP9FH6GPWvCSBn6RIe1eVh9la2FGZS69YIvD7CxcdY
 MGa+MFN3No0AxiIojvRAF+q9mZQg1ZTtDmKAFsECd27QfYVkQpCakeleG0WzfXgAyxqJ
 pkfetyaVQSN+A3WE89hmzrqYJ5u3o78aYpTzN5g2IIGcVTpX3e0J6lSoOlXOu4UnYmXS
 c3is3vyWNo426Y+Zke+SCUt7IXDYagYx1x4EklIkC35Jb3EnjasYshWQ5CKdvHoMiN/0
 pvMA==
X-Gm-Message-State: AFq9FYJ7rsOyLws3KdR3i9e9h7GEPSoONMNCl4vfh4KJy6p9jg8TJIQT
 hY48DhyE94bHV+AN5JAPd+x6O3vYo1UfQtt4pw1zcJ6uzVxLXoUZuW9fljRB9VYpGSpTTWD9rrm
 ps0DLXik+6KZDsO/dQHMx0o/ZdZjQHaPTFUDMPEe3zxTqEzi/u3m4GAd90nlI6rXlEQ==
X-Gm-Gg: AYBFou23857OqqmO3f7NvcJQXlKRldtUSUy62eLfXribqVYi5ve6x9Up8fTbSsp8aKn
 bNkPWe4sSn4kHbIX5qLBxTtzXoDDzh+2+TgfraI/L9hTRRb2yewI5pKWHG6ASjnfLdSD/TULrhZ
 cTNpfQHTKMLHQtwNPAbpmd2u0ofR98/4ocXZgLj5eHswjKSRJhmeQ8yNZfg0+jq6JLRT1o1cztG
 e4MH5AjOHGRukRK1YYhgdlXw6UYD7G9jnUjKBsuRfm4ZP+dZSW0qXT4YSDLWNeL+ivpElLMSO9W
 4s6O4f0twf/fvu4M03eoZGX7pP4KRfmixktCYLb1/2XUmgLdQNhN9bASLIUUA766M46Yupf7FwZ
 Gw1IaTjCdYML/S7lL2j++1bjMu6jAhI8w/mrppc6gRPVuhkYIDJF9msZLHXcHaV8=
X-Received: by 2002:a17:90b:1a8d:b0:39d:efa9:cd1a with SMTP id
 98e67ed59e1d1-3adea0a3c84mr1261978a91.4.1792822609414; 
 Fri, 23 Oct 2026 23:16:49 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8d:b0:39d:efa9:cd1a with SMTP id
 98e67ed59e1d1-3adea0a3c84mr1261970a91.4.1792822608946; 
 Fri, 23 Oct 2026 23:16:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 8/9] meson.build: add riscv64-softmmu to multi-target
Date: Sat, 24 Oct 2026 06:16:14 +0000
Message-ID: <20261024061616.27381-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cPKfcOr8eNAiIijT9nJYPt-3dEQBokHX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX6jagYafa+P8h
 ZkKtbSRG+XA/wvLNIhyYlHvlQUl+G5p0B2QzZLqgfi7I4FrEO5/8lUgXdaDrvZsqkGVpJdiJM1y
 ZqVmj6Xd+UJ/jU0R2BbUMbi6pimZp1k=
X-Proofpoint-GUID: cPKfcOr8eNAiIijT9nJYPt-3dEQBokHX
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adc4d52 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=adxff_50RVC0UkMNBscA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX18TaL91qSUJB
 oi8QgiQuvQXqoZFVMnHQXMkmd2uACm2EzDBsJYs+4QBIAuCosWInfY05jgYVGu3utPecG7znxaa
 cahxnoLmsckNQJQmUVGoyASWxEByL2SeQ+DzxSjtMNcepQdjobTH5+OGqzCNbyL0ytOykgR6uJr
 Ng4tPJ10hVG+PhP567WR7uVdUGGLnFgKYuNQgPHj/lfYXVoWPI0jWftr8l3F4BKMAUyIyi3gurc
 xj0N5xXOZtfxqdNOZXGXQngCn2nFSSkcqV4NYXn8G23zPuBkvzRvQ0//UuXTxvU58VON8pbNUGa
 8gscvSRdABS7TQga3F/mlAK39asSMe7T7C9ylNL3IGNjRZlhWjQq+qE+9mpMxJW4og8PpmLOcV2
 xa/+fcv94H6L2iHFBhRsJeyUgK0WeAQSce/ApGVrHgOj49BWE6s6wys5mHKy0K1oV8Myt5mpHBz
 eQQhFTB7vL30YYR+aWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240024
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index bbef9d9c293..24f60321d35 100644
--- a/meson.build
+++ b/meson.build
@@ -4271,6 +4271,7 @@ multi_target_supported_targets = [
   'm68k-softmmu',
   'microblaze-softmmu',
   'or1k-softmmu',
+  'riscv64-softmmu',
   'rx-softmmu',
   'tricore-softmmu',
 ]
-- 
2.43.0


