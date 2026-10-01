Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A30CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxS-0007xP-1v; Thu, 01 Oct 2026 13:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxK-0007wE-5P
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxI-0001he-Fw
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsYwZ2886322
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RsLMtkm2R7ZF6tXPZeugXrx42AKKh32YqlwfXa4W120=; b=K0lILFPOc+X7YGEA
 GOIgy2z5Pkx21cHJwwnu2FEYSbp4zBaAl7cjFDjaC83wFBKMBB0uLN2dNoL0dspP
 vS+RyJ5WM9GcH5aiJ+6Y3rZ2TpfHoarrBmRJSCR1bJruxJsJjaI84nyWciVpySq5
 M+35lR6GB4YR7EIWzhwWWAmt7Es5kTgm7iAPm21pEl+p27XavTF7MEtWLq+E84Uy
 6vNPKxVg54opIjfNbVekf7g9i3khXRBgHd1M3x6Lh9A0DhOQr7NYvdeVLvw/QwPV
 k/VzjYkObas3g95lHp6wxQda8OvUaZthqFkFoOhHlC96WuCD13U/RwBE2Og+7CiJ
 QvmuTg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdch1au-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so10074646eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877146; x=1791481946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RsLMtkm2R7ZF6tXPZeugXrx42AKKh32YqlwfXa4W120=;
 b=OoO7M8SbvSPTASWAzG92z9Yix0zw++uAzfabvZwgtmSRXB809knjr0miUVzc2qYFaO
 3welE9HPHwM7edhF42z6pu4gn8W3pPzSdxSYe7Ho2Iu5T/TGf+/b9m/d1RoMpRhpulq5
 hrlpgpQLekGvTIezTxJ/i/ShRz0uqCAy0k/qTgjGdGpjrVmQRdg2zqODDNlICoNKDhwv
 /Z/IaQP2sO/HIs/zHim5ef7qc5t3octDNDEsjrmnKMa6pEZgWKb+Uhbd6MqtxmVSBMPw
 OCzsSjn/N6Njv7hn2FZ8WV8g/oOYFGmigBUSxInZuUM4U3qoiy0K9IT5ukPOX2WvtBSl
 rsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877146; x=1791481946;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RsLMtkm2R7ZF6tXPZeugXrx42AKKh32YqlwfXa4W120=;
 b=0vbZB2G86qUJ5azC1JazoUFh21ETDD9VDCp6/XjRQAgiXWlRCCpYXGyJoQ+7BccbcP
 JB5Syl2KZdmdd/etdKYnaGdV54Sxf0p/utt+Gh19zjfJ1/dUUAgI5SzOVEhT1puxlbvU
 FZMr2ucwmzMZ4VaJSNOqh2C9aY5om8SQA/23sdngXeoMfINC9DWFyiMQr3EDhTUBZJaB
 ORwg1Jl5xq0UY63PHYyxv9Sq95BYVk6a82pPF7f4IFEO8Lk+dzDspGOcXK/U9NcxcpI/
 T1MM4e4L+xIZUdjR1z96VctFpEPsR5Neb2NiAMQ66yBSUy8pcaMz0x3It0RPOKIQikXu
 +ACA==
X-Gm-Message-State: AFuF++lHLIexwrGaBm+DsaSoCwmaa2LaLpBWrFVNLAUlrUkcNOpMVu3B
 aOXlfsAbadASyNMsLVBjQtAEhhKH1m5oTENR4VrVw8Vip821S2VURzaNUebWddqYUAZQ8owzjTL
 xGQ5Q9xSFUWxiGPl21h9HXeEGlZhDTHUQGNhpbpqauAgabEF88iyd3iKg2S8+NxEW3A==
X-Gm-Gg: AYBFou3OEktHOmJlnxSIN9Zbgo0WBa2tyCD+Gc+SISQ+XjFE/XoTqUTyuGG/EBAkD3e
 FIMGxN2yM8oEbWF0O+6xj4JhqliSD0ps0zOyJzj5oX6ywO0kOYVvZ+j8OWexjTgYlYH1/p9lUIL
 ihiduVF6FVUX4zFAWz4VhcjtgeFWiJ9epdikFPiBCRm/myHOHlOsv4xlhZBno0SMrCbxWruPByj
 /pUyxy4JfWIT2Huiw/LyPbWWHUUk+XfZkLqoEbSRjKAD2XJI7h3KmXMMkEAZiIl/+YgPHSA8KLZ
 1w05PGU7V53lKUoHHhiBpobcBDiAC1gcU0MaGFYRHpV05/t5R0K8PE4q9DqqFkuY+JoRgEGGRNA
 Jf/p3xUVh5tXirwAyoLvZoa5XZv6/MTBLrCgvYH1YCRKKw/Hp4rV3UsllUzyTG4ks9slEl8k=
X-Received: by 2002:a05:7022:3a04:b0:14e:6b46:6494 with SMTP id
 a92af1059eb24-14e6b4667c2mr2568906c88.4.1790877146407; 
 Thu, 01 Oct 2026 10:52:26 -0700 (PDT)
X-Received: by 2002:a05:7022:3a04:b0:14e:6b46:6494 with SMTP id
 a92af1059eb24-14e6b4667c2mr2568842c88.4.1790877145395; 
 Thu, 01 Oct 2026 10:52:25 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 06/27] tests/tcg/mips64: move octeon test here
Date: Thu,  1 Oct 2026 17:51:42 +0000
Message-ID: <20261001175203.8673-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u6k9LlIFSOXfDqsK6Ic8M1ZUvQ15R7PG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX8fGfzk3H+3W3
 SspsDU7iG7rwxPPGbq3pjvR7pxmhUjqCkVfxylRe0GiyKvb7Xs0pKG74P3iSdFY250ykDCPtMly
 nQ1AOEheFTwDXpbwMTx/KrJlTtqtmR4=
X-Proofpoint-GUID: u6k9LlIFSOXfDqsK6Ic8M1ZUvQ15R7PG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXxwARGdtRjx4O
 4iWy3ANrZocyVqhpgmyPzD3R29EjeGw45QCWjVhYKUf+Ih8oSiQkXuQXEr3SnTcdR/dCDAvkVhO
 jUjGFCl9fthfMME4p9uxW6IZG1c0sE/9DNLalQfD5/CpkWezk/5pqroClg76urZTpKclPgNvxAo
 c3AXt8ivcmVAeJCm2mL4zs4cmbj80pzDCKpirygFELU6oK4EleSDBjonUdzg1ZREPFTpjdXNbBo
 IOgB0Ias6GXjrTsy+T5ZFKWsSVSv3lNGHWCuW+GnR65Y5tx1ZCpOOkWJuPUpC61OOTFLytIMqRC
 fxVylIHSOqUuafk5rbDj6mBn2gLdH5bzPKJlNEyrdvFyrmB47LBA3/lNd+SULvt0/OYmVtJHqbi
 GWMPpfTqAmNQoUavEEh8a4k/EjSIk78ovZX9wNn2WB/qndeguZMoiHpqoU6FbSHAOdY+C5Kutfe
 ma//ZHKOyRI/faDjz/g==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abe9ddb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ybKMF2EBzz_YHPg-y3kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010071
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
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-7-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/meson.build                              | 2 +-
 tests/tcg/{mips/user/isa/octeon => mips64}/octeon-insns.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/{mips/user/isa/octeon => mips64}/octeon-insns.c (100%)

diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index b8eb6705eae..a324a16d671 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -3,7 +3,7 @@ tests = []
 tests += tcg_tests['multiarch-linux-user']['tests']
 
 tests += {
-  '../mips/user/isa/octeon/octeon-insns.c': {
+  '../mips64/octeon-insns.c': {
     'qemu_args': ['-cpu', 'Octeon68XX'],
   },
 }
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
similarity index 100%
rename from tests/tcg/mips/user/isa/octeon/octeon-insns.c
rename to tests/tcg/mips64/octeon-insns.c
-- 
2.43.0


