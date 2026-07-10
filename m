Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8819C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJA1-0002fT-LV; Fri, 10 Jul 2026 17:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9z-0002Q2-Nx
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9t-0006SE-N1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKDcah1811763
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4+SiHtRBNrFz1LBCwuIViSBLrkRHrJcYuv2aqDvTqCI=; b=LrvmFyJ5aE68DVwf
 78wZrvJwLZXa7eCYSJY8sFfz1jwRcCfNIdGxiye1S/gD91LG44Gaycvmwi5532wm
 od3MOYEUbH3Eh9Y4vdHcWxi66Yd0etjZp0LGKAXLQSMCy79KsPGvOjgjHTZXabsn
 mYdzLIauMQ5VDcWZiNcxe2gdtPja6fkCCZ1i/PmCdowDF8GO6LxieJu/nZPB+nwP
 +pxJTGMe9Nw7fNOcOena3xRjjvPmdvIF8C30gJNTyxnDlj80uC/5Km28pjojl6FW
 87OBrCL3znsbnUdVSjjvd9hpQfJtvajDgI0nFjWISMlAqPJalC7o3f9Y57oK4dSj
 PB7TsA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5fajfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so950623a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720400; x=1784325200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4+SiHtRBNrFz1LBCwuIViSBLrkRHrJcYuv2aqDvTqCI=;
 b=Go4IVSNTaNoyc/8YTbwFZD54EGh0WpBFKXIXDCRaLh+yNiodczo2rPr5nWvNijGSEz
 uWuHl9udyYyG4WRCaxIAptDaQU0DvNDxfAJni5Zyj5SJfqYq2j5BdV4vO/0aKfUnljLy
 YMtv1vA/WOvrLYQ5+iFAfzpxS1UZ9O7TB2b/5a7PJeEoN8u+lD2LqK/M1eviBlz9erAJ
 fMeKXC5A6wVJtJCHXqStiHXF69HVql0UaBioJXILwqKzBdJ0Y/66tyNmCLe74R509sEa
 dUiu60FXf2PID20TpEBUDVP+MgDVq3TlKVSfbSmPFz8xjVa9Y8J9xVVLaKkUrNtnBaB4
 TwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720400; x=1784325200;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4+SiHtRBNrFz1LBCwuIViSBLrkRHrJcYuv2aqDvTqCI=;
 b=COTsna7rCKn+aTKbdWr3TeiLIOO3Rl0HUlLHZrejYEEBd9C87PMvMqabLl4/1Y1xdv
 Dk0WLlxiGXZ7Lk/ujTMxio9mK6LtEsMyC4AwacvSkIYP5OZ/1xUvcSTcIyGQg9ycMy4V
 rHmn0a1mgAwlgO3GopElF1HlfbPbP7RM9uBcyS7NAeY42P7OcxTk1eMONErWYGqQXfY1
 hDc0xkX+imTH9tpsBzNwcvu1VNP2OpW8AxzBXaf4tH1+FcXZHJf18j+E3vLTBL0Vuhwg
 i6DJEA1mGrER/jP/LX0TGPGrWoHLIBBO5nPsXaeCZ2WlIg4SNlDUdgar15sctL/kvUk+
 wWeQ==
X-Gm-Message-State: AOJu0YyGQjMZWfmS6WXUNSF7NjNjvk+WIWQ+Cul5aqCaLOpFCpMmULxn
 1+8anSXwonuzlUscOOyKPYL+mY15cJG09WZXLTJMlbVufvVUhrpaYtoDguyRHyBPMmwvhdeFZgO
 /KPPNyAaQ7YEDBLy3gMo+8BboLkW2XQaSVGuby2UJKKlVzmXHVleGxcYbAlFlOW8S4w==
X-Gm-Gg: AfdE7clfTDvtOWwcM1rmM5kEKbgBIdNISlin+NjTfPpD05yKdKmzbFNoZieyMcgl8VI
 UlqkFf3fTbk9FV/03VXxCMq0dEg81awEWLbzmUwQC4wOq6K62pFpN1cpLUZoccmZ7g1IWNcMT5M
 AGdrAyJQNBVdIikUTk726blM3q9SR0BDjLceaohENqBV+yqKxgRJyqBGcJHN7uTIluCP37m/eHu
 4YZkzBAqYxapzYnsyadRuAPHgZx8YdtnJWP94bI9u6C9s1fyFVMT554/w5dzlpb7c9kqQ7PeOIx
 uHjNOqenD4JvaPkkQHqgOLRdgUnivlFiJ6/aR5oncCOM98J02pI+7txZLf2wc9c6qHQItO//pt3
 KL97oGYBknUdxYOmyL1lVD35EkSx1KmsjTMig37jaZwUmJjusz93OXsA0oZLonUo6m2OwGUVkGw
 jDv8R8KA==
X-Received: by 2002:a17:90b:1644:b0:387:e0bb:5801 with SMTP id
 98e67ed59e1d1-38dc7ba8a90mr549937a91.40.1783720399830; 
 Fri, 10 Jul 2026 14:53:19 -0700 (PDT)
X-Received: by 2002:a17:90b:1644:b0:387:e0bb:5801 with SMTP id
 98e67ed59e1d1-38dc7ba8a90mr549905a91.40.1783720399358; 
 Fri, 10 Jul 2026 14:53:19 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:18 -0700 (PDT)
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
 Gustavo Romero <gustavo.romero@linaro.org>,
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v5 91/98] tests/tcg/xtensa/crt.S: align .text section
Date: Fri, 10 Jul 2026 14:43:35 -0700
Message-ID: <20260710214343.2065491-92-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a5169d0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=5InQkvVgWux2XAX5AMsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HdjfEvCn939vZ_vZ03oF2dl4JbCzvWMc
X-Proofpoint-GUID: HdjfEvCn939vZ_vZ03oF2dl4JbCzvWMc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX4oxE+W52PLA7
 7x+2la0lEBz0xzEcrESk6Fmoa1Lupmreqqp5qpkSHiaSX2338iK4NvbtoKGSxV10dQYGyyn4XrO
 AN+j+LMamx11TyuNr7jRrFp20JWHpes=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX8XKQwmR6lM4e
 uFvMGwFTcJrWMpUFpxWBRCZzYlSdTqquPFFe4KUapiVvHeUeZ/AbCdVgxG4u51jIIC2BoYT3cBB
 czflTNv4gCHQRaDVqSug5K7oQc4T+ihMmkvdDYbThiRcuvJE1Vqfn7qrj1MJLC1VT6bRk2UQzQw
 WF0VAefpVytu9BPFBpyBMInEdcsQRTp1wNiGuyt0fDURJ8hBNp1nH2bANVN5UbIoM1yda1rEU6S
 rN9GLR1e2qIKi0kbF3vRLNBHaIFu2Wswsg4CzIfRl3nNtvDDezaTNJBAjjrh+CmLFrS60lpv+LW
 S39N5D8NN2pAa95fR1072WP8F0JMjwFaHkcfAtn4eFGpZFi9vtbLC9SvqzF3a+23VUR65CF9SyK
 Z6YBRopxNBAbcuHBjJvcvrFM9+QFMLaE7vzUjD8/+6HoRtJuJGJloK5vWWapX1xBURV5nKZ5mw/
 u7BNNHLv6d9Do8E8qFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100220
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

Needed, else we get this error:
dangerous relocation: l32r: misaligned literal target: .text

Previously, .S and .c were compiled in different steps, with different
options. Now, with meson, we have to provide a single compiler command
for all the files (no intermediate steps), which is a *hard* requirement
to save user from dealing with compilation details in arch files.

One consequence is that .c + .S combination gets
-mtext-section-literals, which triggers this. Easily fixed by adding the
.align section.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/xtensa/crt.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
index 909872cd385..de8fd8c1cd7 100644
--- a/tests/tcg/xtensa/crt.S
+++ b/tests/tcg/xtensa/crt.S
@@ -6,6 +6,7 @@
     jx      a2
 
 .text
+.align 4
 .global _start
 _start:
 #if XCHAL_HAVE_WINDOWED
-- 
2.47.3


