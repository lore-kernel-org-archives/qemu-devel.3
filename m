Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6E3C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gk-0001Pi-QV; Fri, 10 Jul 2026 02:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gi-0001OF-Ta
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gh-00061o-GT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:16 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nUo33848866
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l/8ap9T0s7XEWDdZ5TAWh8KIwZJAZDX5hIl8EXyikv0=; b=h5g+fI/Fh2TU8Gxd
 fph1oi5cy9e//QfeBBgtDFDXyf2zGc+JWYQ2PpFchvIDN2LXCp8NYlBAiOp/3Xq5
 huAgp5AMr84ZqSLWvMTHy0EVKNJ76S0uI1Y3ZHByTRcWa08wm9kSO98UBwfr8WcY
 fpMluL67uG3PQK+dMZt67lgAnLxpfhJDz0qLgVQ6wBVzuygCElwIM3vE7UYZsG5V
 6vXhJrxeyuduUpiZQpoCbQLjM65FrldZj7DsKqhYM0/XbQT8jYaQfImhR+G7p5Sr
 jiaTG+/Ir16nomyHcShFh0xl5TeMFyGLJf+0kDz5Pt9B1uIg4iWv75BwbzsCYsnZ
 hel1sw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu31k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cccfa32670so7866095ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664763; x=1784269563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l/8ap9T0s7XEWDdZ5TAWh8KIwZJAZDX5hIl8EXyikv0=;
 b=RuX0y0KY6/UUE8x6LewHwBUz0LZ6L1Ix8578y+twZg4YtpieUn7fdC/EJUZcYyBb1f
 1Kz5u6yD/Kppm8YBkGOBs4ZUa1gvgEhpIXD4xEmjGRuESCjRHHiEP79LJAp6dsCIAoxd
 Q7FXpvsiTRoGBCcbO1QgVK92jW9+zOFMq9WzwzzVO8xB6v16BuMykqv//x6anWtva/EW
 DtQHZJY79Qsrb91oZEDbZr5ispFd0/TJkahpJzuTsDWhclAyQes8QXFYkQ0B1OThgmwM
 greuuACSGk2S1RFJrVcPypVIoV0MpWfH1inWwMLu4v76mwK+mBuepBi9GuCKtRxW8qed
 k0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664763; x=1784269563;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/8ap9T0s7XEWDdZ5TAWh8KIwZJAZDX5hIl8EXyikv0=;
 b=NN1TiFKfbatztxV/khjESYkY01RuG75O85JTBytDUvxm/7JSKvQHieOK257OS8pKbf
 vegNZuj0aFYaY5aT0ct29SxwwEtuHFrc0y/sWRUE6aPOS+5K1xOsD22gveTQToQaCDc4
 R33c7etkuCDlEah/zwkuLHoda/7coWUWVYnFpU+Q30VSVzVrIhLVixfT8T3rL3cKMqs/
 HzigDT+1ieesqRmXVlIWtPVLTaYxrvgOH//Vm9oJNpExsZmhBiAlyK+3ERFzUZjI8b36
 ygUeK5JWQgxzmVK6O92TvWQorAHwEpx/Aj94/1/M5rpZB5MelBiVoyk2vG8lfBh6U/4B
 1yMQ==
X-Gm-Message-State: AOJu0Yw915TCFsKdjhip+/R0jCl1/m1uHLPUmWGRkzhi2lvmUyNQS9JW
 yfKK1AIVawYG3SRthfT7OL1fVwGG585JCX96A6fLulBpPc+NGm3y2pya3jrAAZKehs5zAMeziKa
 wRLVq6eaPqnaz9VcZgdx9zFUUn0ibfPCA0X1VUixcopYmYm35ZxZsNT94J03mifSYYg==
X-Gm-Gg: AfdE7cnZPr0SJQyzexpi9pTT4M3wgKcvaBiNMgwXF7ZJNYonMMZpgoaqC4l+kpPcqka
 T7/OqbzYWBSFZ/SLe0qw682ex9dV4n+2/zgRHAp/KC3Zuk49r23aR5h5fnOBocONmv1kgcLFQ5J
 exPl9NjyEhl0UNXEfYrJHqqqt/KXDLveoyuO7crTGBgv9RF5IVTNZHwY5Gv5skiclmlPUoUkAOu
 CZLoJ9at7892ahXGbHEzLe7fgbmrTPHELBQBxh1A3rJ5MCwS6Na3xVIR8x6WGENgsW4ye6YafEE
 uiu8eQXGRh5+MFRbLSWWZaHKqoC/2j6AhnJ10Kqg/PzDy5fYRf+EAbGPdKhmwO0PzlRLra5AJKj
 UE8MSsyD6Od5Vz77rfFr8fTHzYfiPbt/h1iNV99NgViD/vnMqPCmK6mhF4jRlL9630IU7mVwXys
 RIvDQLIQ==
X-Received: by 2002:a05:6a20:12d0:b0:3bf:d0c8:2aa3 with SMTP id
 adf61e73a8af0-3c0bce1c07cmr12160944637.1.1783664763500; 
 Thu, 09 Jul 2026 23:26:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d0:b0:3bf:d0c8:2aa3 with SMTP id
 adf61e73a8af0-3c0bce1c07cmr12160912637.1.1783664763039; 
 Thu, 09 Jul 2026 23:26:03 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:26:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 67/97] tests/tcg/or1k/test_muli.c: remove set but unused
 variable
Date: Thu,  9 Jul 2026 23:19:45 -0700
Message-ID: <20260710062016.1818125-68-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NCEZrW8ue9l-dmSbidmQt-4JXyOphJoF
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a50907c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Fbn9wURAhCV4_gqr_ywA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXxojbGqn6Xfnc
 VSdM8zOsyHJFT1fvmgS8c+5hmywJrQ/YO3yWZ/GjhHM317uKnNGdNrGe2jmygfIwWDvlJJF2hEr
 vZEB1uMgqBUGUEKRs61/J8sGkWUF2dQ=
X-Proofpoint-ORIG-GUID: NCEZrW8ue9l-dmSbidmQt-4JXyOphJoF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXyPqM2baFYhrF
 mCd3dG7inm//x7uKuQUjYCPzOQlZkHr85L5KOjPfBbw/w19XurU/PfLABQEByjFTehKDcPI4HUH
 jT4WcqQPy8WKPo2kgejiWm0pr+LUs97V8Tz4z3b3o90rvafwWs/1VqHA5gn31wKG7g3qi456Kl2
 JsDEctI7jFk6QRuPzds1G/tUGXs+gtvCXcp8c4QqbVGoLw0ZP7oyuq0NhMgv1nYdjliCBzCLc9X
 Oyd8M/X8wbvnermkhEqqUX1Xd7btd8t9p/+PaZI5mpm8NnvotP15Metgq7eIJHodpz0eUpI5Guj
 vXYGmc6/v06uHg8l/F/PTaehJtm7or7v6lCw6inD6PXYZnx5JoqPbTGxKakCXJfJxyhfCBlopyN
 JBPNNC4Vlh3ewlOSUlsxMAzKIitwYumj+VsKfpk3aqwmT72y2gi0n9pew18y2xR+r/ge8n0vWZW
 kSo8TgwCHqVCe41yToA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_muli.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/tcg/or1k/test_muli.c b/tests/tcg/or1k/test_muli.c
index f1042e98dec..cfb6b3df251 100644
--- a/tests/tcg/or1k/test_muli.c
+++ b/tests/tcg/or1k/test_muli.c
@@ -2,11 +2,10 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a, b;
     int result;
 
     b = 0x4;
-    c = 0x1;
     result = 0x4;
     __asm
     ("l.muli    %0, %1, 0x1\n\t"
@@ -19,7 +18,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0x0;
     result = 0x0;
     __asm
     ("l.muli    %0, %1, 0x0\n\t"
@@ -32,7 +30,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0xff;
     result = 0xff;
     __asm
     ("l.muli    %0, %1, 0xff\n\t"
-- 
2.47.3


