Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2107CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMG1-0004OK-En; Wed, 07 Oct 2026 03:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEG5m-0000Qd-5U
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:05:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEG5Z-0002rh-Dz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:05:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696HenAY1538685
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 18:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=i/X1f4OKN1m
 KI0l8sbNJ9sqMq0Otc7lzyvJ2OhEUenk=; b=DjBOTdZksDX3A76PNGWkWhLV8tR
 VS7oMgHB7goqgwt3DRb7BP3pIg3usBA6S3huLE8WAjhqd9nH6JRPFNHwkoMoSLm2
 s+/SmJmVjeL9FfJ6HmJvCjwLVygSYdsmLlAHHAAPEl7sc1Iv7cmQK7ihaFKRasmc
 8OEDqmM7mQhYUWheHFfTz5Ri+MbZrZyVB62K8Dhc4XaMNwS65Ht29H3uiWYzO6Ty
 zPaSNSkpgOKvh9E+dN2PpwEq6XcLTThsDy+ZbolYhg2gepTeIY4OxuJ5SPijHVLh
 X01hcB9dsJFNAjw6vbFgZ7s+T/baZU+ATh/W6XE3QjimJ9HzwSHQugbU3FQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h54620muv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:26:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510a481ae9so6006643eec.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791311182; x=1791915982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/X1f4OKN1mKI0l8sbNJ9sqMq0Otc7lzyvJ2OhEUenk=;
 b=Bn2xSvp7uAbyYnJExarkLTdxwfMNqdpFw66tT/Q01VoxYYbl1s1ZQbPucAsOAyRv9l
 hsYxf4G/U4urUMUTHuR1xup5IMFNCm1MaIrmJYsxftKE8H2/J7dyOWM5Y0jl0aca2uGV
 DwWq3GMuDibSCQ6u7I6UV//btSnq5qTwotV2xpY9hxPPOnV1MtuN5otepFNKGx2KIfjE
 0jS4BPjgMyYaRVbw30C8c7HeiVMPn92MAxBxMUYTxijYepJCPCAnBYXIFuwExZtpQ3R8
 r2b1/vYBpXo+5NIX2IpgVvMPwpxqxiblQQlIqKF+2Na8TSYjNVVXQGCsSDfS51TJnJAn
 ez4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791311182; x=1791915982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i/X1f4OKN1mKI0l8sbNJ9sqMq0Otc7lzyvJ2OhEUenk=;
 b=cLymuJYp8WJTcoZ+cVQAwIxjhxdEEeFkuPSjfAYoxW+QwhV6smuwy7R3eCIeKXogQY
 /DhEyqJzz4A3sQsJKCruU831GswFFqNNlRevkFcP9/4t4wQWG/+FlvV9FhZO+i/nKoci
 MYEO62Ya2KgFusSq6G1VKt8jS12+jufmPfaG24t1CA9J7lPd/n26ZglfRO2aq2GFMFFd
 R61IUY4431I9PGTpjuMJayYRoxBQT9yggW/1a9v1/bjNMf4/IverQiq9R8FFIs7VvPkp
 8VtYxGGALR0Xd1BZfeCALdn9BDvAoHk41qfQsdRWYhNMK85hZkuc0+y4lQ0dJxbNJ17x
 2Z6w==
X-Gm-Message-State: AFuF++mtX52AO1ty2Vo/+9hvEI7qjYto8r83bAxh39tdFCZf8XDg9e/3
 6itiHk4M0InC17C9cRgTGjK/ABgrVFG59+bPX4RxIMLQMH5NYyxh2w/M5Kz2xAp0HQSQahyY0+t
 YlgLIvU/s0XP71viOMZ9/xSlPW+QLpvD48L85kIMzJ1747UX/E7SYlnewu65XlPVfsw==
X-Gm-Gg: AYBFou3Y7ItSJwXWZx9HqY9mSkOvEhhjAO4drn5ipDu2UTLunaoyUQTbUJz1ynFNcLS
 GRIkP9wawU1stW1kCYsy2L49/kMXPWZuZdDTD8ko7NAGeVLGx1cdDAzQJEjVMgWOBP5+i7pM6QM
 GVNPeB34rEoeGg7zRXlpEieWSXh27Lo3DGKtahtak/QftIBB+2GEm7WgUfKlW/pzD1s2vv4ghhE
 k0WEg/r8xISJikj8Jb1yAuOtKzg7wrQD5jEQI3mG3drW+eY7hIphD7mp8mZp0dKHyz39yZpzuJo
 1rhIdyOhQcu0PhmpwVkXDHLWy4XWCBdTRdEBKZSAI50kXBqqJKLnR5JfPnUaJ3JZ7ArsZzMBRYl
 iMlp+c8luPiNKauRkhrb2V7TsHZk9tlskpqXks3jC2DaE4tdNvtOwVuxF+emb
X-Received: by 2002:a05:701b:2513:b0:148:cfd2:1e4 with SMTP id
 a92af1059eb24-15ec5e3b01bmr2643456c88.16.1791311181659; 
 Tue, 06 Oct 2026 11:26:21 -0700 (PDT)
X-Received: by 2002:a05:701b:2513:b0:148:cfd2:1e4 with SMTP id
 a92af1059eb24-15ec5e3b01bmr2643434c88.16.1791311181027; 
 Tue, 06 Oct 2026 11:26:21 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515aff5dd6sm242567eec.26.2026.10.06.11.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:26:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] target-info: use TARGET_ARCH_VARIANT
Date: Tue,  6 Oct 2026 18:25:58 +0000
Message-ID: <20261006182558.151956-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0oWqWncr6K0SGAQ1_yi8NpeVa05XE0e_
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac53d4e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PY5D17XH09hrHwDKjbsA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfX1ZzqkMV0Nr9o
 H3ZAJFrPxKE2elffKI9h5D8jZ09lgqBLReVZscYiuwLYKct2UByavR/1GsO17UsKnrrtHdXlqb7
 qmmXfSKMgcGmxbu6yW/00lGXrk5KX0c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfXxBkF4UfOhV4r
 s/qIKxLafhr6zNYVxvNQKmoRtGUa8l3Dm1UbsOA2yzQ5TJB3P5mhxfjNLkC+uJ/Pgef2fOKiFMv
 GyPdT7uAyt+vb3EpQzZfOj4ILaYeltXt0QHg2/JOtQI2o7ZCErJ8XpoOUSs5D/fo9xHFcOs0NqF
 hxWm61UdV3dpDon1SbFfTmI0H6MCp2reRUPKiI2tsv4cg1dgzkw4vrhH54O+UfiLZuDKGZgC40D
 shR3kWABBAU6ieWP7iq9hG44oOJCPHOP90VdMQZPM1cpFOYOB+0LLqy93usaNQXnRiNlFLtYUhe
 JXDOdLNBEH6uh6RmFbfnnkeZf9qh1NKpicH2p5rktQ2OTGlT4UpHclF9tGvKmJcyQUmxvZdspAi
 0nFk3USaz6hD8r7iXZ9NkXO0TEgiTDfCX9GLHpvoh8RzqjSqoQXNWz/6fpZn0hlh+Wo3FIzX9bI
 VNV917d1hLMTB+aDzBQ==
X-Proofpoint-ORIG-GUID: 0oWqWncr6K0SGAQ1_yi8NpeVa05XE0e_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060073
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

target_arch() will now return the full variant, per SYS_EMU_TARGET enum.

Fixes: e934c624f3 ("target-info: Statically initialize target_arch")
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target-info-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target-info-stub.c b/target-info-stub.c
index d121b8c0170..b0079d44dcf 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -26,7 +26,7 @@ QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
-    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
+    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH_VARIANT),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
-- 
2.43.0


