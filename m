Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C5606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kj33gJ3i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NQONARLH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRvr-00085M-8s; Thu, 29 Oct 2026 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRvn-00084L-BJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:20:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRvl-0003eW-EH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:20:43 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCdvnE1147371
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uoz0GJK4EiKftpnfPvWdrFy+BjMidf8V1yjYl5ZQOCA=; b=kj33gJ3i/7TpwfLz
 rT5JYcwJ9i40A3S+bnXaiI1AuV2kiJRcH5E8gpjM1+qOn9je5F9muj0gLWgsN9jz
 fBULS5ZVkO7yHXP/Egw+74f1Xx5p6KJ2PXKsdwgnTNVu7AwEfVRiOWXVrod0CJaM
 JdVH13MB3NzxLIJeR/Bzb0uEE7FasX+A53nfPVeuXGBjUqGBlZV+/yamSBgRKcGg
 s40oJ+zXRfpM36vm3KkVsfGFchPw9zJR7CrJjakR4xTGkC+ZcD1T7/jI/2X2LgU/
 DiGYvHucX7w84CwfdcKRxy4aJ3h8JhKb0sLroUwnTox54M3HFLwSNpo53kVAvq0Q
 7sA+ow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q95dy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:20:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb71b1443so470571985a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793287234; x=1793892034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uoz0GJK4EiKftpnfPvWdrFy+BjMidf8V1yjYl5ZQOCA=;
 b=NQONARLHvDcocGfxA3GejgedR2pM9EHUrzSxnxyzVOTYGIiuxtUF0eA6CAwSrJLo2D
 Jhnc3ZfWEeXzxALuaOcP/Ku5XFLj0Aw/OlOsfw4oJlnanYesYZIVehnybRJGQEClid30
 /aLD87aFHXYQ6+gXtlPWHpPncqJ04fq9SxjZaWKr+OgAUv/4aOuXzUXHO3PMUglpbx6b
 Zc9bIe4werq7NLJwbIlMu4VSK+n3GvELhDy0eR8Oer9LMWDz+ES4BcwjFQvFu3aZAhDH
 OO01bLsmpckP1KcpaZAIndGbMkxzAng9D1ICegq+k1tpxOgb6gX1ea5kBeXaGEEY55J0
 rYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287234; x=1793892034;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uoz0GJK4EiKftpnfPvWdrFy+BjMidf8V1yjYl5ZQOCA=;
 b=ywFIGvNU879I8NFyC4nKj+ENqO87zySDiZRHoE3yzVpdf/T96eaWhy/0dWPuGWuU9e
 /As5L7jBeqojV/4SWdq0nfenTzN8MN9W0BHE89RV2onVeVGU2WRXwyxVan7zAt6MdkLh
 2UUnoaFMMU1xdvJ53q41T2lNERk47SuA6z1QNvPyeJEnks7MVZe0q5TeNg1CVfB/yNS+
 MWdTd2yc3fqgyPwKtPqTRFTEWIulprgaZSPy/g8KBUWrdkYON70GH78hpgSlxt7kfoyv
 FiBsVwNGjDH9nEeBrKZFxf46V3IIMXTCE9f+pvVimhIhw9zS2Osmp/Ya0pHq9W+ws5Yt
 tH4A==
X-Gm-Message-State: AFq9FYIreWY4wXiJ/IPD31Q8nNIg10jvbQPmPKIOS9Ynll43lIIglOnL
 HBLXbVaUKgMBZMMVar1XRslVNUiXc5+vcU9eluU2WET25uuI1tTBK1fesqULLEB5WNRf5xXJPq4
 V/+gYDjLvHzqhV5OI2ti5Sw2Jgg+42geqaGORau2Oq+g6EM7L7qDVhHAM8yjQyZqe8xlw
X-Gm-Gg: AYBFou2uPEPHjwOtunYvAEePocfuaDXZdUI8g2O574H2R9QkWlAX6lRb9dDwylDkyNh
 Mu9HhYTjyBoQFJhmGfIfgp8OHSk8pXc0838IFbfM5D7hTCw7FoQ7HMz4EIBTx1tJy+T/MMtEyjE
 cNP2zGQQizyPCWnv5OhVyNwmbPZY7HqhOm5KMCzDTeWqR6iPAU0Py/pxpf+IuxnruvrrpP2OzYf
 M5o6OxOEBar19pRelqPMoVBu2WnKYdVp4lWeL7Ibu+QXIVBZmWpIjPdeXQuZ8VnsoBaXKI2zHAP
 gk2Ieko2q90q1jrfphynBcw4PcSdEU+CbrbGSkOM8pVt+HmXpAu6wRpGkR2IX3Ovmakx3ATx2n/
 znDsCwzyZ5vzIKoMdn5mL4+nYQTkjk4bEBb4Btk2ankmzSPp/Q7lX6rRYLSblY5zoyJZX4YTMVf
 H/Mvm1G+0wg1QnoMg7mnawxWhEvOklBA==
X-Received: by 2002:a05:620a:461e:b0:93e:6394:5e33 with SMTP id
 af79cd13be357-94408a5f872mr897143985a.27.1793287234211; 
 Thu, 29 Oct 2026 08:20:34 -0700 (PDT)
X-Received: by 2002:a05:620a:461e:b0:93e:6394:5e33 with SMTP id
 af79cd13be357-94408a5f872mr897139085a.27.1793287233616; 
 Thu, 29 Oct 2026 08:20:33 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f3229dbsm71352065e9.1.2026.10.29.08.20.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:20:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] tests/tcg/mips64: Test the Octeon POP instruction
Date: Thu, 29 Oct 2026 16:20:08 +0100
Message-ID: <20261029152009.19812-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029152009.19812-1-philmd@oss.qualcomm.com>
References: <20261029152009.19812-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfX5mN5po4Cjw0c
 G41V5IwUSRh3UCY7m++P++3oqyTZUEuawbX6g04kkEcQDjJWnNx2vrwmRJRBP2EFH521UOC7OBG
 MzSn1SeWvs7Tqe3CkhjAmS6IQkCbGg8=
X-Proofpoint-ORIG-GUID: ERHj9a2fYtfUKt3Uo4VPgeyVcEhfXwKn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfX73y4uZecbcgg
 fTjC3tAaNaVB+be5BSuQ4UD/KUPa/9wp/setH2akspSMMosS8jLYN3D0ZZdOclPfWniSArjpntv
 AAzAESRAAYD4GGspycacF5YvQp67RnXZcbmzN9K+DC9y6s2QYTsMEfisIf74g5ryQgN5m4KAjp/
 ySf3Q6T63itV5hEXy1+wEcet8X17Vk5GxT1YkXUip9x/AOj9IN50gNL6DG0tJn7Vk+d8YZMAs8L
 4o+eC6gn5Vg3CUKXY4UCP3nprR1X+3vO3Ni19Vv+awVVva7uYRjWDZUsFGJhMLdIeMfeOAQbXa4
 3rdXesgMuEXeOfDgJEwuDJ7Bev5l/zcuMx9iFSukavbTstNWfieDeF2mZklwHUlgAz7KXbn2Qpe
 4DdbOzMDLAxYzf5lSiQqitmteOo4dKPTtzLkpPBez9ttvsB8QYS/GfBUqi2vW4oKIOVAQJgmeZ6
 wYRVc0YjqTTA66dE83A==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae36443 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=CbHy6YXcP3UXE5Rb_AQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ERHj9a2fYtfUKt3Uo4VPgeyVcEhfXwKn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290060
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

Check that POP counts the bits of the low 32 bits only, unlike DPOP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64/octeon-insns.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/tcg/mips64/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
index 2c4fe8f58875..ff399507f1d4 100644
--- a/tests/tcg/mips64/octeon-insns.c
+++ b/tests/tcg/mips64/octeon-insns.c
@@ -48,6 +48,21 @@ static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
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
@@ -397,6 +412,9 @@ int main(void)
     printf("TAP version 14\n");
     CHECK(octeon_baddu(0x123, 0x0f0) == 0x13);
     CHECK(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    CHECK(octeon_pop(0) == 0);
+    CHECK(octeon_pop(0xf0f0f0f0) == 16);
+    CHECK(octeon_pop(0xffffffff00000001ULL) == 1); /* low 32 bits only */
     CHECK(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
     CHECK(octeon_seq(0xabc, 0xabc) == 1);
     CHECK(octeon_seq(0xabc, 0xdef) == 0);
-- 
2.55.0


