Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D0AC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziW5-0005JC-EK; Thu, 27 Aug 2026 18:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziW3-0005B6-TE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziW2-0000Jk-4z
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLeCJ778988
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CpxuIm2XgsoCc9OQNu1at7eO6dt4Gah2k1zYfdZm/R4=; b=DLHcoAAv0votKrr8
 CPa6F9zb314FXbYbqJvg0xi3nEkjFR99ciuqS7XP17edCBpDpqIql9LxExXQori8
 I7aRjDlrTDZH2dAHjoeEvVz7LR2Cv4S/YkzTR/qqIaHARHr80GyGxVz5Ymu1HL6g
 AWZfmoFoRZlMPIpyvoheLF9Rnorr3oGPzYZzzRzPFwaOJo3ciKC43QV7E6EXjoWL
 sVsHgXM+5HPjEBXSsWulqJcNzzf7mSVHp1a01eKBydRbkJGgZPLT7EfKTg7tPH7w
 zEp97C62I8dZL9oORqqEmwdP7kBwetQOnmA6sWTyFcl/k2rVcoZyja/9iXIxPOly
 h/nd8Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee1r7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so6362285ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869438; x=1788474238; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CpxuIm2XgsoCc9OQNu1at7eO6dt4Gah2k1zYfdZm/R4=;
 b=EKHeY2e7lN1cVfLUrq2PByv8nL8I0Ovjn3VWuFbFA4oxM8QTgzsuuWZUpzaPJcn/df
 Gsanzp23iYJGh1BDCequ0E0bRKCIDZVBLhHCgg3dZl85g88Skzysl3X2IiT18p0CLoAD
 CD6XjpTTcl9TkSYb92cb/hEUnk8bNG4K2sWYV1FE3CVPp8PoDFg1qPZ+SVN1WXwkAMD0
 UyldA244mEYUKAWD9lvufVgXQ2P2n672oZw7FaxVFdrLUyi/qSSU8sg9JVCw88lhgBjs
 QwmEvTlZEyQlcFFBlrYoX5VrN5luYGesv5DDiHeV3FWUfD+9qyeoQPSwf50QjmDh/pGl
 m2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869438; x=1788474238;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CpxuIm2XgsoCc9OQNu1at7eO6dt4Gah2k1zYfdZm/R4=;
 b=s5Rm7aAL6C6Gpjgsw4J2chUfo7KVi9Ko9KodezWFUMMq3usJ9FgW6PovVCj3GfP9rq
 xxd7NcMH4Ib1qyA1wD8ACE3+CwJGx5g7wFIWB+p4QdkUj1r/Y4qHpOkTWppMky8AYzyC
 uRqqyvAXl8agvn+y36EXVVwu8qEUBV8evBym34HsxaN0yfXmOf7BNWXUdgCFZz08h2Il
 2sMr5VmtQYOR97vwMPGxpS41UAhbSoXouFDYZl+d7JNpztZ0ykO61S1IM3UbPm4mBh2G
 9q9MMeZjumwl5LJzuD0qmZDoHzeZD9hHYTpLMWOBmKB+u7gn5U5lNrg5zTFx/OdGa2j1
 dupw==
X-Gm-Message-State: AFuF++l3GWdj7tJhRf54HdqCdXmwhQn7y/BcPvnOUZTVlm4VDGc4kOtI
 qNX4xZmfCrc/M1Ux+F6gA3GtiVck7arP6/imHIJKxHCfjij8OiJPVxnepkXkJo11Ss6yDMrGOfl
 Dmno61HsR4R03VZXD2c2h2tHMS1yLp6CkVdsz9SfXJ7CG1qhO4Y4Akza5ZilOLnVCMA==
X-Gm-Gg: AR+sD10vu1s+p7Y+IKbWAdIwWhG+KnaYZ9eeT8CWKati5mSS7OboRfPtufHi8IK379R
 +YFN2dBdX1FYTHJXf4Vf7RRr53r66s2EoROYLkj+BAqgHIe6IvCW0RlzpQAL0aAfIMJD+C3DOep
 ORLCzWenpqoy/LJ9V9m9A69uAHlmvV41JIeHdHXuaYGTyNQbhQvt48SVL/dE2o5WtYx3iB2NQXB
 Wq05P0pDjeP5/XSBP8Ut7mfn4L1P8KbGJ9bHKbH8E12ZTm/1l8vEkkn/aYsjX7m7tUC4GxjfnF8
 wKw/vV+GpdI8xpLosnQqVduAoRyWNPGxUWYvt+IumP8AFt6P8MeFnc14+Klpq6XPsDrVhBpynvF
 LPlmiZh0b7LCqFECNw6ffWiC9i8w4p1rFE8XHhUGlCJQcV5XRuQzx5rVLadw=
X-Received: by 2002:a17:903:2b0e:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2d74dc910cemr40404525ad.8.1787869438129; 
 Thu, 27 Aug 2026 15:23:58 -0700 (PDT)
X-Received: by 2002:a17:903:2b0e:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2d74dc910cemr40403705ad.8.1787869437667; 
 Thu, 27 Aug 2026 15:23:57 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:57 -0700 (PDT)
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
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v8 105/105] MAINTAINERS: add maintainer for tcg/tests meson
 infrastructure
Date: Thu, 27 Aug 2026 22:15:06 +0000
Message-ID: <20260827221506.91574-106-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX1LTUxnVfZxr/
 FWcur95zEgrfIPGXyCjykNSF77mERp3nbcnek1sGdsekONdpsrh/8DcErjlCHnMqgFwFufyhbyY
 Co+YSLp3Trj2S1dKxVIFnNk3/O1wJh2gzNbmiHPETE5547YS+SZ6U1L9dKgJ8yBwlkr+giTq4oR
 Nd4BPE0NP/qB1ITzahLY6unZYFwkQDkExwRuQu6f53QtQ2oFoUlreyKm58vFv7qCUd0dnTnGToj
 yBCohdJ3HlufHH2y1RYd0cvx11VxMZynrQ1uLaaJ/BEH0FHu3klUpgL2L3MTiQP0Br/irhpRvCR
 LpCp5b+/464FFjAvU3T99o+wIMSvcmECi2jYBfRyqOq6g4ab/4R9wn1LOIL+XfCaz+WfeJc2u1h
 Cxa0GpsrR2dKfVBmVBrgePZiCDss6SWrRvZPxGOOL5ihbNvCf8EF44E5ghV/HRhL61fQHSK2RLH
 bMZTRX9GluQd+K1BkKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX7Gc6lMgI+aLO
 LVWnFoIR1FdABSswpkN4mfkQxWmNe3vu3bKzybfi5mp0ZeG98/F9AEGfDHLlbKj+wyAMu5asFPP
 lxnArzT0E29uU5YI5R+NbI0A36MGBCY=
X-Proofpoint-ORIG-GUID: Goz4LSIeb3AnnEY1gOLYtf5Si9npsnmQ
X-Proofpoint-GUID: Goz4LSIeb3AnnEY1gOLYtf5Si9npsnmQ
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90b8fe cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=EaJnpZ2ZbUPJMKaiO9cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c18b8a4191..62ba29c9b77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -472,6 +472,7 @@ F: tests/tcg/tricore/
 
 Multiarch Linux User Tests
 M: Alex Bennée <alex.bennee@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: tests/tcg/multiarch/
 
@@ -4646,8 +4647,9 @@ F: .gitlab-ci.d/windows.yml
 
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
-F: tests/tcg/Makefile.target
+F: tests/tcg/meson.build
 
 GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
-- 
2.43.0


