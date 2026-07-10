Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213A7C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5e-0003qX-9c; Fri, 10 Jul 2026 17:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5X-0002zu-Ae
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5V-0004q1-1l
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:50 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3FaR1621110
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kSGwiMRYDcRmg6ozYAQgmtSI9aq9HO9mUGyA7RaMKw0=; b=DxOzaJYRr8se5XzJ
 S9oXdJgyFMqOS2C+Um1iSHdtdw6xHkajJvCJVnWxEJZKEsMT4/X81B1Xs85BoU/B
 xOP15DJEjZH+3s5raXqQLZ3P3PYujIv/aHBkaubryQ3hapin5eYZgrXXQSrgmYMH
 c+4DYq3caYVrE8GwmqV+WOHIOvpotWfehAGMiCQTwc+q0/Jbp0SOSxFRRrGs59Kt
 rkYhIXiAdByKz9THHZt3UQDd+HcqXjrMpLGVDxRSD8rBzg/qcrMa0Ajz+Y2IQovK
 hIAOk49HhM0WY3JFcZ2TgdN9pJ/crrGWyk3ZQl2NIQpuYJ2dduqzsll7d1JkCTxu
 rC8Uuw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8v4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so1089624a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720117; x=1784324917; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kSGwiMRYDcRmg6ozYAQgmtSI9aq9HO9mUGyA7RaMKw0=;
 b=S7R/SSOAb6q7jGcq6YB4j8Wi0uK8J190uGwqkVY1ZMy1HRHQmr1QT8hCy3LghcqgRr
 kbx5gWio6cr9poV8f+zzpYsC3QJB+lK+Rz5SA1Q6V/bA2toKw6kYbYerg7hiE18M8SRe
 PogLAuZB7KV9LpQNEyNB1dBUZU4QgWozOvt7bRLS7KmlaYDKA+sWz+9fEGW7GIjg2V2b
 8mxX7wPrmSVEux91jeZhTYFlxBQVH4VCQs/XNBS+d5uyLjB7rPY8htJxr13Wu9sjcr2t
 AUclvdG7QMFI1vOKV108rTWf1mWnveM/BBNoDY3C7LxJYHl9TeNxeQpW9PHlmnt0bhqV
 7mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720117; x=1784324917;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kSGwiMRYDcRmg6ozYAQgmtSI9aq9HO9mUGyA7RaMKw0=;
 b=DwcQ8RWzWD3p9qNIYTGycySR30CKB3vpldt1SYe2mzNbuCMdTBb2PutKfoNbMC8GhQ
 nkMJidZaA77sO4NcSAdxSD7yP759rdWwmg1ORfDTrxVtL47Oya0O6qBWuz+B8vQ8eM7S
 0zB5JBYg9k1Jgxox4PA/jwT+2XQn7SaRlo+QNbgKUWDIkYU/6FV5qKNpVWhRhPR6C+RN
 N2c8pFs0buVpcPuI1hXVuL/fTqOfXRlrz6RFKfrgTUayfl8zu27mshDdpj96IycRMNzU
 xSqQgrB/K5fA1IIEf/KH9KpaResWWdh2oRD0Nl4hrP9Xm0U98lEU7e0wuJlke84aaMTX
 nCbg==
X-Gm-Message-State: AOJu0Yyg7J5cvt4J9x0/Dd27FdKUU7inV18vAOaD0Sih9/QcCmAMHgXZ
 +BXmumNgf+jAcOfBJ2pyRYmRcupNIVpueBtcd95ieockVdFzgSzCEa+gR77W/q+QEbak3H03ohb
 LtK7QYIkdqp3rH5SYEdhnIItux8Cfzry9imJehOiKDkIdP/i+7BAgIWs4vLB2SZ/8Mg==
X-Gm-Gg: AfdE7cmO+R7Ammggm/qLpNpq9ht3Aka+qFwjlBhtMM9KFhmkS2lM8P95BQQoGQ69h7x
 T3OK8ykK4oY3Na6eNswTrXORuOXLvq8SbXFhbXs7yr1O+3Y0lN0a4+cNgfzS9DJUwYAHA9hD9XJ
 AueNKTVfx6sXthPC64z+pXq+e+WUvgNk/sqmFf/t2G1VilhkVICk2S9yVc3KqdKp7PyiEXeshTR
 5KxWuAc/4dKGVyWuKXKktA8rDVmYT55rWEmWh32uveQwRt3kx/Un6hsWNYvBDtALHJdC0IgdaBL
 yKnxxtI4V47x4DYSYqoKB1jRbNyAFc2aEVHA9nTPTZbAZjgTrF4N535QhPCVNB8uBI5NV7VuZc3
 QmofKB7w7kAwcqWrMWTFzU9vVFnfCSZ5qUgAzh1tjrFKEhYHYbl52qnmBk6eArm7HJQ8lbFkLnn
 XW30Neiw==
X-Received: by 2002:a05:6a21:7486:b0:3b4:b6d7:a992 with SMTP id
 adf61e73a8af0-3c11062f70cmr714193637.8.1783720116993; 
 Fri, 10 Jul 2026 14:48:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:7486:b0:3b4:b6d7:a992 with SMTP id
 adf61e73a8af0-3c11062f70cmr714164637.8.1783720116505; 
 Fri, 10 Jul 2026 14:48:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 49/98] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
Date: Fri, 10 Jul 2026 14:42:53 -0700
Message-ID: <20260710214343.2065491-50-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iwdBHNfbj-y9A5saQyZUd45KLiLbLrCP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX8Ipd+pW5ncOq
 Dc31ysp+Oq+BBP9hsqyBeA0EXnSQb4R6ejBTDwyew92AqFfGmgb1pXTUh401DXgItGN84V4KFDv
 VZu3lompIDQ4ERRmlWMfdWyc8yJ25spm3hgxrt/gfnVIsueR/K0HxrYEbGYZ00o7BY/0cJjHqaR
 gyywFFVO1hi9+HdqWv0ehAVnq+4fBmHjd5K+Fv2xd+x1WFREsctnEZsoKIyGD4l81Vx+q2LT3Rr
 NWlDEd1cYTeZNyBKXl6x4tzOfEs8nbYC/DU7jDKsx2h9kz9owRUtKkdxbz1ZksEwQhYzFObNIyE
 SQW1K4GuhycUDcOjv4NV4xa5VCfColaD9H1FDhLoHDU5RlZhIth9ILhu/h0WWPVjhI3gkKwYnEy
 eul9OO+kHK94mrqCTjy4hCdADi8vPmwFLAIh4jlFvcWKr6Bt7BUus7SHBf9XsTcUUKSbPt5kq2e
 4mniNUvdNQsr17pq1Fw==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a5168b5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0eg9nERfSt1gVPs494UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iwdBHNfbj-y9A5saQyZUd45KLiLbLrCP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXwBwDzFeCMGZv
 unSTYv75FQAXTyh4HDBlHKuyAQZWHQsi7vgCP6bTWbxnJufF/CoLIlfEMLqI2IgZCI1keYf3Sfl
 gf7On2TVdPEt1AtFuOTVqlJpS8Lembo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
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

All big endian targets were returning a wrong value due to this.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/sha1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
index 0081bd76577..6cebad2951d 100644
--- a/tests/tcg/multiarch/sha1.c
+++ b/tests/tcg/multiarch/sha1.c
@@ -48,10 +48,10 @@ void SHA1Final(unsigned char digest[20], SHA1_CTX* context);
 
 /* blk0() and blk() perform the initial expand. */
 /* I got the idea of expanding during the round function from SSLeay */
-#if BYTE_ORDER == LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define blk0(i) (block->l[i] = (rol(block->l[i],24)&0xFF00FF00) \
     |(rol(block->l[i],8)&0x00FF00FF))
-#elif BYTE_ORDER == BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define blk0(i) block->l[i]
 #else
 #error "Endianness not defined!"
-- 
2.47.3


