Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B73C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVT-00039K-PA; Thu, 27 Aug 2026 18:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVK-0002qZ-60
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVI-00008c-LP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM27O3848558
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NrIp+DZsd+nQjheRQ1gcH+UWlnZp+GjS9oaS9w7InsI=; b=Io8PTNbYqf1bv/VH
 BxdCB94bFPX+XevE2IEE/B6ZJVCEtjfrziLUMlBMmGYhF3Nj5CxK6J/7zPJgDCEu
 wxX5qGCOOiqlYebZrXbSEtIgkzAfnAvljAfg/RxXEa9K60nvv1xZRgbAXPtBmlwB
 i7C+T8CDz7/SPPxewqBGq0m69i/DRJ4bMYqGUQD0d+p4RnH/BSjNkcreO+F8P7G5
 bWhivSG1aHVgQkugjA7/Yec8Z8OF2xDzbSkv+fpzM2GCEe2+SE19vm5L08Zluq33
 q8OO5wS19at5ABpRv7CIiwDPhv4VgmnhUDrle3ngNX4MmoUfrGE8UgvnpEVC0nj5
 1wC6Sg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0unw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so539691a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869403; x=1788474203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NrIp+DZsd+nQjheRQ1gcH+UWlnZp+GjS9oaS9w7InsI=;
 b=asXHRKTwOLBLo6t+kngmqullx4uBQrxrbNNE/jBWYMhvaTaeOIvcATWie8E0rOKHJ5
 1KeUbqjzDKRN/f+D9q/zuQieL2bI4zPaSVEWPIgq3qoQuaA/S4XJZUJViNovwX7J9lLR
 tHF+Gn5ChWv8T6BZNHazKBqWZjrL4dsMaNLbneHHd4rSd6nUxFeMCylW1RQoNQEWHAp4
 TecKGAdqlGTUSAv7KweYAY6sGhCDwo1B9PIX3YJqQxbPPXw4HxbNCsjXmiItXLLKvkAQ
 xqVOxk1ynWg3DPRqwwkss687N7n09Vi42feOw/4z9Ni5zJwodpBntqpSGJwN/Iu5mtlX
 r2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869403; x=1788474203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NrIp+DZsd+nQjheRQ1gcH+UWlnZp+GjS9oaS9w7InsI=;
 b=ConEyJVFE18JTnD51vbkhifStT0s7Xe1h73PYwx4li7KYLF2P9a/G+vWV1tEr37g/x
 Awj59gkcpUuEgOMcDQySv9i1qzw2SS36F0JNLJIEYRc4FyLRLlHiB/xuGz8hpDjgO5m9
 9Y9uBswpDwtCd3kXEoTR/QpCd7dCG6WlftgQCXHsePkM+PSx0zhAzIESiRV3f3GOu+ya
 dLMmRodwR+7n0p5ApCkPZZbXdQzGVlzp3RN+NAgcOXlEE68uADt+3CE9bTef3AtkIF5g
 9cGondGwNEkFcd6eADKd466D7UofAv6K3Mepxu/daZRmPTjsZkujKW6pUqj3oeci+a7z
 Z2bw==
X-Gm-Message-State: AFuF++nKKAHghPGdLbt4fH1WsTsqf4zwl+qYZ2bQfRHLYxmOc1P6tvXV
 ZQlBnVeuR2nb6HiyRrPw0itj+ThJn1u4O0nkoGrH4pD2u7maGvK6EkYgo6XSoJeZmFEik9WpkvQ
 h2dQYE4wYGi451ljeYihMX/g0LgabE/qHbwBEyt/CuhJSU2zuMgDWxcj1og28NspxUQ==
X-Gm-Gg: AR+sD13Jn+5fDU0otWx1jvxeWJIWElFq7oax3uteWUDk2pcyyzN4roDgqPYRMGt1Nnc
 b7eLvs7H2MWY2PEBkbupoUsHh31whu0IrmhXO3VXeJbvA+kDr1gd4bRCuU5ay48kl/c80ktebhY
 wxJog19HaXHwVmqzquitya265x4wUctPmd4kRNlawUNtjjygOswJ46/9+F+adwSf8FkxfsM4cxW
 5JhOMzfwUWTnJAISy6G/Vn0C/zMM4DVJ/ebGugvb7lykbUKF4nTWBJa89ZvNSROpY92/uD4z3qs
 HVsaxX75AUdf2/8kzT2BNjmVzPOiGd1+2iHf1swkk7axkD3bAyTCQXtWxgNeWh4Q8wG3XICnwi+
 F3fbYuirLwFslgArY8deUL42GlHATkUdqGD3whiCjb2Ofg13OkjfvtX6Q0Xo=
X-Received: by 2002:a17:902:cf0d:b0:2cf:ca89:499d with SMTP id
 d9443c01a7336-2d74def3ffcmr38122375ad.7.1787869402577; 
 Thu, 27 Aug 2026 15:23:22 -0700 (PDT)
X-Received: by 2002:a17:902:cf0d:b0:2cf:ca89:499d with SMTP id
 d9443c01a7336-2d74def3ffcmr38121725ad.7.1787869402158; 
 Thu, 27 Aug 2026 15:23:22 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 082/105] tests/tcg/s390x/head64.S: declare _exit symbol
 after main
Date: Thu, 27 Aug 2026 22:14:43 +0000
Message-ID: <20260827221506.91574-83-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX70Y7o6eBsqae
 IAuvHahwWKBpCUD0V6KndS0sMpQMeBgw3uupUK9tA4wrCVSa4uy39KxtimD7oxrI3AdPnRd58Rj
 6MN3EYUCtmrzVyAcJWtH/PO/1/LxlKwqN043r5dcANjVNfoe/6acV3iJCfcYdXclKzeUFkL5zWD
 PHIM1YuTO+y4FUHE7ZqDJHnGSNX3phLpROKCKOakk3FFRko1o4sXlfrF7QICpSq87g3TlQLv9bM
 SIrJHi+w5BeBF7SXx5GqR4robvO+r/OuWs0RRsxnJuD7lfr0HSwLordiDlsMlPjQTMuy68qXeHI
 6qO4bBVOaGANNM21NGB7JQIGt+HKo+67ggNgp3+FJ9B+KrbEDigQrixhklxI0ADS1BPLjB4jxhz
 yGWpY+pNS/t4JMiJO3KXcCiprZ+0sRX/rPrP43ju8+oCWiVdvFcE8KGIzzSk6NPYGMumBziytq1
 mMvaIyvvz8tR9oK72sQ==
X-Proofpoint-ORIG-GUID: OjExdJQKmC5QCNjYynEJbpBRYeyZpGKk
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b8db cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX+9sr+VRQ1Ky7
 uI5n6w+JdYN7coa/p80jw+0g1PSxNLhzf5iK07+VKGist2Z0KQGNJJ2xCzbm6/zB7x1u0TdsKp/
 1Cg5yiuTyX3no0orgmUM69/vgLktINA=
X-Proofpoint-GUID: OjExdJQKmC5QCNjYynEJbpBRYeyZpGKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

tests/tcg/multiarch/gdbstub/registers.py expects to find this symbol to
compare state of registers before and after execution. Define it
explicitly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/head64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
index 4fe288388ab..0523fcacb33 100644
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -14,6 +14,8 @@ main_pre:
     aghi %r15,-160                     /* reserve stack for C code */
     brasl %r14,sclp_setup
     brasl %r14,main
+.global _exit
+_exit:
     larl %r1,success_psw               /* check main() return code */
     ltgr %r2,%r2
     je 0f
-- 
2.43.0


