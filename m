Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7D60A261D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gl9EDmXo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jY0x3QZA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0iK-000733-1z; Thu, 22 Oct 2026 17:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0iH-0006sY-Ni
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0iG-0007Yd-1Q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHt2TW860648
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YfBbz1ntshu7HTJMMRGMbG70uprZA/xRojya9HsrRiE=; b=Gl9EDmXo4wzyvjy+
 U8gFVP/HPLNDuLIxhEYudYfgyPZm5mx/N753WhvQPTvRRkle/QIhinrrgZ6Z05AX
 cNGmMhtPHWkYTV9+gC0mi27guG66vyYc0gLYbUB59vcKPJE5y7oG13ztEBot3Uo+
 gTcpCXmOR2deh3rkge7ZA9AUBiL+3p+9Ciq0e3OlQcM1W4iZijQhOS5+GqMFX6rf
 /E892obgKszWGzsxJCyIedLI/6CHiIeKA2e2Q9E7PdtqgSjiHtBT9ZWfMXQvO2+4
 CiGf8+jYeCZStJl//U5LopmeAXtCmHFaYGpQhPUddO635QX01KIOa4OTTieYVDZq
 7vLvow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0h9eg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so42425385a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705958; x=1793310758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YfBbz1ntshu7HTJMMRGMbG70uprZA/xRojya9HsrRiE=;
 b=jY0x3QZArcV6QsQS4kMeK0KvNN5tJDM7fRtmpuHcFuVh/swdTFfiKb2OeKWTW679jV
 eOS9Yom+Te0RlRNoeNHdUxyWAIsFYfbxGYKp1T5XoLXiTCBykUUaMI5MSfWb762+yNWn
 AI25s/WgkGMXgPAJ4Y6dd5di/VtH9gEeVfnOwPengtBc2h2VTp/QZu9ADTCfFRyfTnrt
 hxXb24g0YqYUPDQaav7ncXSsGTxkPqRfMJu4Qzuf1V04MuYJdXEp7M3kBjQ3aD/FhytV
 S2EtpX1BoBCsC/wx7I8j/vXGZdNEbBwo4eGMTicIlCZmJ61wWhqPsyEnPF9sDtRXdroE
 m9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705958; x=1793310758;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YfBbz1ntshu7HTJMMRGMbG70uprZA/xRojya9HsrRiE=;
 b=eDPFQSd8DVozRjyQ9mNzH05C5hPItJ0NpzRQO8Ip2jloqBF1DQmMqu7iG2USxKMxKj
 dPa/ARZ7N8fOXSGgH/HCCjGGktm3aks+26saHPcnkOz69i5PPFN5/ODrL//+1AdZR+eT
 6G5cn/uc5jYJkG7oVQpENqOuBiHEKhxP68GBtqT07hoskjuB35HGQthPu3xJb8OQvUEr
 fw0LCTGBYXWwxzKWYd4/Dqrnch2CvYp212u/Z7s0ZEa4rA01qamWUABRv+ni3nlscX5Y
 23f4d5T59/Bu6yYNu9GNq/zUvvfOkCa/pDvIldWhO8/TgrXAB68+sgrtsS/+rJJUDsUQ
 22Ug==
X-Gm-Message-State: AFq9FYI0PFUj8J3VYHs2uH3qlrIypkAaDBc/Y+Y6UDzzQzpB0aTlT1US
 tJJ15igiaJgpeInsr8AZfJzyHU0LSEOCQKzeYtVGtnXXprQuyr25xLzWGQg2y51cSicPnoSclji
 AbeiNX6x0x1IP03TQ/7yjlL8EjuwhBCsVbL7Smz6LiiicJklMl2oxfVbnZgQ6uxTAig==
X-Gm-Gg: AYBFou0ne7TFCum19/WqeBzD9q+srW2Vp58mvbrvwD0gbYOljc9nKBm67lhYq/IafeM
 /MYHQvKCM5FjARYQrE5eLPwNzSO/fc4s4+tPx/fvzJFNoTR8GVisyovcHPeV59KxUaMUONK/SFY
 33ceTMAwZ/Y7qiD4Gevy+zh4nVuF8vc5fFlY14333mgXoLT3kyo0e5FsXSPEnKZhuvsDsmN8CAe
 v73TtMEdz4PnJS7FGDN61Z10XU9tHQvHlFELOtSo6fLqK5MkmbdjBbcFSZTrRrkbXAnEChw2FT6
 W4u4yCKKzHsXvVBzAn/meAYP/oLzXVDIPotcB6Bx1qAKw4FjsXYIXc1/7qV0bTzeZujoj8I9x53
 h+rqCj/88kYUOPMCa+KcesyaWRoQVHsvy4MnyV8Ic
X-Received: by 2002:a05:620a:25c7:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-93f6235c83dmr614836085a.0.1792705958302; 
 Thu, 22 Oct 2026 14:52:38 -0700 (PDT)
X-Received: by 2002:a05:620a:25c7:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-93f6235c83dmr614833485a.0.1792705957899; 
 Thu, 22 Oct 2026 14:52:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3804450bsm663006f8f.30.2026.10.22.14.52.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:52:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 11/33] target/i386: Replace magic value by proper
 EXCP0E_PAGE definition
Date: Thu, 22 Oct 2026 23:50:51 +0200
Message-ID: <20261022215115.19680-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y7oKkXGFhMUe-pmUErku09Ef64ywLAPI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5T5Kx6Ah13G7
 XPHFJUGVcQxyKuEeks3NuyAmrri/c9ujY9vRWB4pYUtXLtUsMJEbKIVAysllkHHJAEoGGfToVk6
 z/VIeMxrSJTmK9xc32Wee6Cn83KSgeId87SvXy5+iZeDQfhKCFDVNj+fUoZfd7XBO+ERTOmO03c
 tRcqa+mKzZLTeoJdPhxuj5SrPPJ0eh+D35apI+nQP93TFsEfvL5wisL6mh0oy3ZkPhnIm0GLeYP
 MmpPPJLFWm9TyarlX0bsSOHCwR1uvTLzimeNVy1s/BFQR7cSkkUCXEtIz0oZMnsOSzdOq9LHN8u
 0Hl/w33hO4OvKXzxZ+zk3L6BbiWjeXa7+m7yA/wk3CLMnVTkXHdJ7fW+Nw1UfVnH590IzpkQ871
 Wrs/cGsTU6MaJpTZOv5Yk3/8OtUOVRMn8do8waxa5ffwM3ScwLPEi2X4y7Ctq5FiyIxv+pMiqzn
 3pZjTaBHpDGfzIw0nZg==
X-Proofpoint-GUID: Y7oKkXGFhMUe-pmUErku09Ef64ywLAPI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+VzhjW6ORCqd
 oUtDCKQe+ZCg0k8bEhYBYuzmQmw7YJC8L9NbGZvyWHAFGeUgiURISnqO4tyN3+6Tqg4f2mCamkU
 dP8i1emVdIxvBPLeE+cETQABVB6qasY=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada85a6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=2cblKrENZZ9LBr9VnxsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

No functional change: EXCP0E_PAGE is the 0x0e page-fault vector.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index cad19f9ca6b..c89d97e022b 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1215,7 +1215,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
                      env->segs[R_CS].selector, env->eip,
                      (int)env->segs[R_CS].base + env->eip,
                      env->segs[R_SS].selector, env->regs[R_ESP]);
-            if (intno == 0x0e) {
+            if (intno == EXCP0E_PAGE) {
                 qemu_log(" CR2=" TARGET_FMT_lx, env->cr[2]);
             } else {
                 qemu_log(" env->regs[R_EAX]=" TARGET_FMT_lx, env->regs[R_EAX]);
-- 
2.55.0


