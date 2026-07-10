Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAF1C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ9V-0001Be-Uf; Fri, 10 Jul 2026 17:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9U-00019B-S7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:52:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9T-0006J5-1U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:52:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3V8w1833088
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JN+OdpeHcMmltGI116CNSMKbTGMPNAS7mvZhZp5Oq/U=; b=J3zrTHkNESYFCDHo
 P9eetYK+3lJ3h3m4SibzFapk5xMOjNA+QTs19Se+R7U5SUZVcnMIXYW5YvVWB1nP
 P4NGYCl8ZBytLQSqI17JOIRannnfuLIg5e9D6puUBizOro3wtf5fsTAQO9LZiRSj
 HzpaJIuQkCYz1RJMqIK9+gllUraYHjzQ5xlMGe50Gl+5c2jh6Lz+vU2xpv/vdpjD
 0+9ju4jBuhvrl/qhY0FEBqk72QURWbREh9kpBsMEcjTJKUxoDlcQw3k4HeLKkR4r
 yiGb08cThP2dkGTStMD2cVWQlipZVxzU/Lab1uBRIuVE2wOi7fQW5qJni4NF2guo
 iG75/g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwecedh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:52:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37fca5f21b1so2065855a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720373; x=1784325173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JN+OdpeHcMmltGI116CNSMKbTGMPNAS7mvZhZp5Oq/U=;
 b=c+6RG7QPg8w9lqLnirQvb+Yi3J/Mq7lT+ca14sXcyxAZDt3VX02uT5mbBkX4OPH5uv
 a40yl3zp4wO4TA0XGPEIXcgyEiG4kNDZDX2yZVn/3aePizOjbp0Cu0EzAg0LsfJdfrxG
 lAbsa7zVt4NYRpj1MeSSv3Aa3VzaCvi04ZT2nJ6upc3v1gRwuYt+stj93u/bDPt+t/5P
 0SXMi2itqZ/hbZcH10Rmf7f5vKtwvtN5Sr/gjqzC8oJn2pLu6ikAzAlabI/YdtK70qPx
 Rx+PhdYpW+E4mfescaLmGHVQIcBRVQownnJtFcoDCUsN6mTMheWA16vjebmWUbOWdL+k
 3kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720373; x=1784325173;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JN+OdpeHcMmltGI116CNSMKbTGMPNAS7mvZhZp5Oq/U=;
 b=dKcSqx0bpuejEW2eFW5MSDvlaOAwfawMQyMTu9de5vu8Q9L6NsPjSVYeGn0ntwTQFK
 iOWHf3umyDbx6LQJRjFQ4ZshTomaxsJusqj95hCsHy1+qqHOTQ8Qbxy+5FfdtcMVRY7b
 6Po4wMZK7vlsAa1lGCR+yazi7vYK2O5s3JQuFBHgyphlbRB2cRurPuyDL0lgohBiunsr
 8VwymDnq+LqFh2ZsDms3aZ5jAlHsVICczzSTjS6ypYTHkCmq19yWNwYsdbLspSfPeca9
 Vk6sF+Czudvxna6vxW4CXy8WLwOsCeMb04cDCPoRKYTwzhOgEGvwziATHC1clKf+B4h2
 nzCg==
X-Gm-Message-State: AOJu0YwxK7AadSX0FxgnbtN0Kxu72XJah6qDjTVqfxFxKzQWhvIa+ld8
 C4yde22K6dDvK11u0jVTGFh0xgTRh0e5U6Ek1XcIZdwM5ugUUQ561bYdtYa+UoZ5n3x2kKI9UiY
 dwYrda1SX2hDmdGZ7KVn4c9fHP82PnRH4+2/ul1dbdNmdpTS2K/LGTODSDDgUZ0qLjg==
X-Gm-Gg: AfdE7cmHtcA+qS1NtLc01PyNMuvWzcvMtfp8Pkl0I+ETv1pQqeQr2B6yP7IcKejaFWL
 aykV3C8FqV9zKGVKDDGTP1fmQdJphlLTVqey8ugfFsHoOVW50u1oaHc/NIcup6x8UvDtUqZdG8s
 r1Q91hvJHlVSisbmjMpVEi/sy26N+ArAAEPHmGr2VZuXFZu5pYfPbyjIHTToeAQMX9De6FNIkBh
 Gf0upBFtyQ95UiV0PlVG9MpQzN63uON4NJ3eXNlUckR4ZvWOZrcv9s2UtGPkpDqseMVzGoZOPU+
 cJh6/In6e9VNCCF3tGT5N4yHn0llGDv1oLluLOwtPZo841cc+AxWV0WrIOssGSWmTF5BY5G7MhO
 f1OprhoC5odIInephuB0056olbSRjxP/afAAvGXM93GOpAmfGD/5UfT+KyomTS02hSXBNbugpQx
 I7JqTa9g==
X-Received: by 2002:a17:90b:3d86:b0:36a:caf2:3815 with SMTP id
 98e67ed59e1d1-38d15876f4amr5725348a91.15.1783720372759; 
 Fri, 10 Jul 2026 14:52:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3d86:b0:36a:caf2:3815 with SMTP id
 98e67ed59e1d1-38d15876f4amr5725330a91.15.1783720372315; 
 Fri, 10 Jul 2026 14:52:52 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:52:51 -0700 (PDT)
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
Subject: [PATCH v5 80/98] tests/tcg/s390x/head64.S: declare _exit symbol after
 main
Date: Fri, 10 Jul 2026 14:43:24 -0700
Message-ID: <20260710214343.2065491-81-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a5169b5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfXx3qjIkOoc3p2
 Mia74KAy5vD+JT7YrUo0FJJiSn1Dn1Ba4LcKbqVDnm/aV+zMaup0WvW6oqqoEg/g1PT0x21vwsn
 Cfn2G3VfY/mi2r6ApcK6TSGIZ51xDyYxFjQsIM0uFFijijkIulAymJqVj499QjjKxlpAahUPkxf
 /Xn/cDQd9+3xenfhwm36rYPl+zsxNv61Bcp6bJnf6XYJvvFB+o771llQXgxvR7dpl4rIe8ClY4V
 P8++uzb8n/iN23dclj4muFw/kkegVrh+P10dsagc6MQagZ2XN7KMyr2Ijv/74ogA05nwWTtYTvf
 +9LjNifUGb1IRRX869QX7ClKpMmrONiAsE5OELgFLovvw1LBYZYeobObbR3ei29fziZAVBgk2hb
 5xjpG+cRuCpMIH2qneS8HhZ4KfW7MY1bFFqLpYuK4WSPuZzyUF5OoykwubjduzGXV4h3DPI22KJ
 xTVo7DwlUluc9hHjxOw==
X-Proofpoint-ORIG-GUID: q16uoej7PvBdmwHYL__6finS9iKluvcp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX4eSE7S/upyXs
 m2zgyiSNOjE2kzSVgxJN/MPFWoGFr7Ptqpdl9I1fUtT7Lk+A7bgJNSsrvFmxR1JrQYtUeaMLpWi
 tL/ep3HMvph5jLTaBxG5l4TFkQX/HMk=
X-Proofpoint-GUID: q16uoej7PvBdmwHYL__6finS9iKluvcp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100220
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
2.47.3


