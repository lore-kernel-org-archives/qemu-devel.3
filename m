Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0DD606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vr0ty++/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JaYtPOEy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnzB-0002t1-Ei; Fri, 30 Oct 2026 10:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMnya-0002P1-At
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:53:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMnyT-0006Ag-VQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:53:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERBS32494589
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Go5raBOf1KRQvFCZLOc5L5/jvKlytDeUWKABk1LcGx0=; b=Vr0ty++/UzdiM1h+
 HNN/rdGAw7lkT5CFckrHgsG6hPqecoR/6JAwqbq5kwRhxxvm+KzbFfFAfTI0cyKy
 tlv+j4TYzyq9ar0UKyvBUkXzyyOBjGJHcW2+Aj+7G6kE5YmEaI3zjDWmLNDCiE57
 FG4TKrBlSouoZ3WpPGwk3aMYYRzuw7XIRXoJgP+KhGojhbf/Wqvs1OAyrk6H08lv
 +QBLHyZiamd327+yuAMU+q/38aZxiuPMSKDIZSISgYPEobIQqHvk1899ADX8Bg+T
 7Xh3SpgF1ltda7UE+qO0YMteW4icLNFTKnJ9Xlpku1arAC0Y8IFTUTxWlBQqJZPF
 2uw6mg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3mxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb6391e89so174831985a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371973; x=1793976773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Go5raBOf1KRQvFCZLOc5L5/jvKlytDeUWKABk1LcGx0=;
 b=JaYtPOEyflO63fQnNL1TsBH0/dOjfIpId8RSXxYV5UHT3DgRKavLKLmfaP3ZHEeqW+
 +8xwutGgeEPq3CpNDsK6zWiyT3hZconx3gSq2cUswoFBNZBCZ3rbPMwveUHrw5hj2U7I
 nr3fDcOdodCCmKqx3pC6gPIo5woDXJNEkV8jgKgXnhfXCeuf+RV5/+eAqyvuf3PaIprZ
 p7s2VnRgUPiBDbHTkKyf7KdHzJOqGow86Gus6opykXjF1Gkw1OmngyXci7K32jUZ9yKq
 OIbpa5Znga4+I1Ys1QFPM35gFVRyF3rmYJiEnKbVSpiDW9npNHBj4xEO6kI7Qs7EfEZ7
 ryeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371973; x=1793976773;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Go5raBOf1KRQvFCZLOc5L5/jvKlytDeUWKABk1LcGx0=;
 b=LuLDvxObY0o3Vto7eOuTb2Jf44pIuiUkEt5/GGn4cbVv1saPwcM8GlktcfMxNyJRdy
 9dUCR/HQJNo5I5TwiVoBJAbCwGhDiZUjTwFDObpLQlf766wawfpTYsSAHm7YZhL5lEn7
 MkFLwWUg4KrKI4wGHXdycrzbtZWo6lUOBiCBEQqhM89qo30ICVS/cJBPkUvyc1V0e09V
 +jM+mzbkhL4tfUxEJ6k4QlU3jYakcvjdfugHGbvGjLTcX3xF18CWCA9Wsre2j0qNx3QA
 LZIfTTZ9nkHAquNl+G0DezuYGg0WakzvAO5PXgngexLcAjTupTVL1kHdzTKC+fN26oKt
 b8AA==
X-Gm-Message-State: AFq9FYK/WJR/x0jgj/3S32yCUeruYB2D4M7XHLxLtSvRyKd1gOZOnfgo
 higUKAYhBkpwZtJHu+wg5vBbg03a6os3+hxG/5Fcrw8KRWhZpfizgoLkk9pRsYdHS9Xu5foajL1
 Kwu96rXfXijRKxnIrK284YPFcfPx4rkGqMB1qmGVPm3Zhv3kEX6g1Epwi1tMqYZnIXk6T
X-Gm-Gg: AYBFou0Y/UmZIX3GnscvKuBCZT2lhHJzRaZKHh5qEqrMUx0JYCf7+07vxTYdkAo4ryf
 cqW2ik8YrxwKO52QXtUhQOBUbCypkz13vu6SG+7KfV2kDA9EwX2T/bsosGmaIS2rCFwv4JJ2T6w
 rvW/ovuzctEHJ4LDfakSWW8fnIpGSMgD5VoebdmUyOrbAmiY+lzytiphT4VaccIwq3EmYJewrzj
 U+o5G6pMj52mXForBhFpuGWDENnvo+AvE+2RnJ8S9Aekdv7QHqtrrhhqR3waS9+VUxuvGuYecjM
 jiDu3sbY1i9qJctsetGDohJw1Bat5mV4WmoFgDK4b9vcyUgULRxTKlM9R23jDDY3TQA0jXraIQq
 ednyFTmBiXf5W0tp1YGvJTTTg7PNUOFd+uw+WHyXf9V6IsC5MvOYwu4i4dO1p7KcJdyJcUc5vsX
 BwZgreFgmiBs4WCKr0hMbD6Dy7EE5d8Q==
X-Received: by 2002:a05:620a:29ca:b0:93e:c12c:43fd with SMTP id
 af79cd13be357-944217280e3mr418419485a.74.1793371973407; 
 Fri, 30 Oct 2026 07:52:53 -0700 (PDT)
X-Received: by 2002:a05:620a:29ca:b0:93e:c12c:43fd with SMTP id
 af79cd13be357-944217280e3mr418414885a.74.1793371972860; 
 Fri, 30 Oct 2026 07:52:52 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d2950sm140834505e9.8.2026.10.30.07.52.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 07:52:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/4] tests/tcg/mips64: Test the Octeon POP instruction
Date: Fri, 30 Oct 2026 15:52:18 +0100
Message-ID: <20261030145218.58385-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030145218.58385-1-philmd@oss.qualcomm.com>
References: <20261030145218.58385-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX+P3D761KoRyC
 dnJoXO4v20RS+u0dShH9yLG2b/C+PkBDVAXxXxkLoF75OJoTwIu0sKucc+x8tXI+AbNRTMVuFZf
 Ug3Q1atu/5SZJBycGiEBBELy+JTKaq0JMx59jWiTDwB712GsOsLDFA6eqgi8Pl7SkWOE0OUZy7S
 nezB4Z4KnnPur7yHJTbmC2pArve+gP587mtpO9Abnfmbd0BZK2rFoMfFeHJqAJWUM7Tjp/6W5Th
 1p36gmLcGrN/DT8cdEx4AF+3tmyjmvucWsMbqBoF+LoOHooHWE0rqkW2CMHJqfWxLYuDszxpEc6
 M7+MoYk+1xkl6PFydPZeRuv1phwjhZ/GYPdR+j2/knN0NExmKRk0hk2ZZ9tQIKqr7rB+AnCp1Jw
 os2ldIZj3pZWyBsyH+KDsJVAEdSWJezTzhhpDP61hWc92CaWVE015D9uLZLbU4rg06WGKyCJB48
 RuuOGk1hYMv1VzdtKrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX1JxovQOgXTlk
 +B2Qs3ukDnGUlJI/RvKvB+1LUx2AqscP7k4q1xj+mnklMbA5j2QxTVjsHlKwWIfG3PwQn6qY841
 cXAK2gsprwSd/cjMRL5JXWn5kVODP7s=
X-Proofpoint-ORIG-GUID: g8yj6nlnEabhKVEMeOBGYH5bazqDPjSr
X-Proofpoint-GUID: g8yj6nlnEabhKVEMeOBGYH5bazqDPjSr
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4af48 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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

Check that POP counts the bits of the low 32 bits only, unlike DPOP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/octeon-insns.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/tcg/mips64/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
index 208002c711a2..ea8ad4baee4d 100644
--- a/tests/tcg/mips64/octeon-insns.c
+++ b/tests/tcg/mips64/octeon-insns.c
@@ -39,6 +39,21 @@ static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
     return rd;
 }
 
+static uint64_t octeon_pop(uint64_t rs)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        ".word 0x7100502c\n\t" /* pop $10, $8 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs)
+        : "$8", "$10");
+
+    return rd;
+}
+
 static uint64_t octeon_dpop(uint64_t rs)
 {
     uint64_t rd;
@@ -388,6 +403,9 @@ int main(void)
     TAP_START();
     TAP_CHECK(octeon_baddu(0x123, 0x0f0) == 0x13);
     TAP_CHECK(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    TAP_CHECK(octeon_pop(0) == 0);
+    TAP_CHECK(octeon_pop(0xf0f0f0f0) == 16);
+    TAP_CHECK(octeon_pop(0xffffffff00000001ULL) == 1); /* low 32 bits only */
     TAP_CHECK(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
     TAP_CHECK(octeon_seq(0xabc, 0xabc) == 1);
     TAP_CHECK(octeon_seq(0xabc, 0xdef) == 0);
-- 
2.55.0


