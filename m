Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D19C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNW-0004uD-1f; Thu, 27 Aug 2026 18:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNR-0004sV-Oz
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNP-0005yo-Ff
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLckQ1358479
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 07rOxmN3l2DJ3nrkL9bTVDcLam+4ZtmCCBqbOlsQTho=; b=OVG1zM2LNyni/aSD
 jL5yQvFZ7FJVT6JiNmj8vdBPj6IDbt+unLhewqPhPiixsFOAQMlI4k7WU1rVLURB
 4Lrq94Vgae2RrIkm31lHFkrSabWW0eNgb1xtW5ilvCuvGlhOy5JrjOpBowP9m3sk
 ddTYnISUx3reRr0DGlXLXm5pJTQsq37QYQTrL4mQMPB830eUhx8IQekZDFaxJb8u
 UwUv2qZFyhQMwYnwv2ossli0kXwvzaN52X66L+cnLdTRye1tHUfPSl0b0afbYCBo
 Kdq9DhSVjNN8K2XJvQSpRCZj7RoTACLxD3edOl1CG89MY9Nttyontwix2af5QGoN
 9acJYg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgva9sb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8486c3411c8so240841b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868913; x=1788473713; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=07rOxmN3l2DJ3nrkL9bTVDcLam+4ZtmCCBqbOlsQTho=;
 b=X6sPbPiyp8RSNYZbVm2c7RcGR3AygEJm1PpAySvJ+Wp1pFgaU2VGuyCshO4iUxRvtu
 DqQyPKfkbKonovOBhXuMHgKEM/N49Q+DHN8PYezD56gOhcHL+u03Zj6QNXET1NSMMqBL
 5V/ks/uAyS/COSYyhj0TIylmefKXzwzpYXR/PJWDKURq2fi6aDKeJWPy8gHGqGYcz8hi
 7mDbDfTxT7C0mKwISMXaKwsmyGUEUEc/5lz/RYsMQpMe7vwGl4DpuER8NuE4qjY2jX3c
 N5uC6MZyBZ9tfu/IRAQV/PLU16EubQjjdT3euGwUd6izkhz1JlbJxKMPERiHTVZNwrMM
 h3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868913; x=1788473713;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=07rOxmN3l2DJ3nrkL9bTVDcLam+4ZtmCCBqbOlsQTho=;
 b=Zn+r9LQ2mJZpTz1EfnQw1FqVF68rP6qu0Ht8l7G84vJ1qQYHml2iSzGKagWYJui78c
 EpVCbdDDD8VODB5D0JgFwHUd980Afiod2O/avj0VmQWfnIaZBkNg11bC6csIzEkXJ2ky
 u2A+afefn2d2jouOglrHcdWNPteGUee1MsP+RTS/WCntY36/vdBArYEFOrjfg4wtDGBH
 7k7jG+YvxKQvua9Sood/tZi6msdgUB0SFoEzfdUmdBXBJ4AtaIBEFIW2PDPW5PEoo3gF
 97kQ8icKSC2LthQr0qaFjnqaiYhkSJD8S+QxuBac5OksFyVpqnZWdImlaIQeKIi9JB9j
 sHnA==
X-Gm-Message-State: AFuF++l6ru0CXmPrceOCezrSIc5vkknwUIOlBvJrgsTO4JGgaF3DzeRz
 KsgLYzsKiNQdyCTH90zwC9DjfkoGVhyst2Mm+cjiLtpad0yeI77y+12MStXXaeExh+EnQGkjGLK
 FCv53JoewQ1o45BCbL0F1J2wELesTh7JY2s8apfJHImmI86nu8opmlgzHkejuLQVIhQ==
X-Gm-Gg: AR+sD13bzseK8eub5F4fG3E7VMLDE8joMyRI8HX0AgTG9u1Tl1IVKnG/H9eZ8qu1gbI
 LwKQDq6zoQ8+BBlgS+hBQd42sslgmakfu2Hfm6NZSc/AYOFxXgQgl+uWxIm4PTCIjV9riVmLHu2
 Mc1XqGSWTOqcrexzzIhxAlvevFw97wn9Zv5kcCqcgrUplfqVG93xaTTNcZNS6jbAwAXiLK68YfL
 GEWvu0kTpukUeEyAF8Louz5VhtCgzf1KFGbF8k08kJCx1ZeDPXmMxx2fjq8if/rL/T7UoBafDbt
 Q3P1NVJgCO4866XsrCmJEj8b3fiPRhIFnVdiPdZ0SrelZmAP8FSfUqZsvLPHoLtO/rfyCkL/3IP
 hEQvmqP+80ZVJrL5yxfgl5lQ87HvbPTtqyVXQr47MzuTv20ef1ABgm2My6MU=
X-Received: by 2002:a05:6a00:802:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-85629064fcamr4710876b3a.7.1787868913013; 
 Thu, 27 Aug 2026 15:15:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:802:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-85629064fcamr4710764b3a.7.1787868912573; 
 Thu, 27 Aug 2026 15:15:12 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:12 -0700 (PDT)
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
Subject: [PATCH v8 004/105] meson: bump minimal version to 1.6.0
Date: Thu, 27 Aug 2026 22:13:25 +0000
Message-ID: <20260827221506.91574-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MZxPX-Lw3jQCTrLdoRu7KIVPhaY3zIxP
X-Proofpoint-GUID: MZxPX-Lw3jQCTrLdoRu7KIVPhaY3zIxP
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b6f1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=v7Yl3Ntq-7vvpjXoxa8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX4McS2+Tg+ZoD
 LBMXgPw/BgLHHOIpfCjSn8TLpuEqW/XqD4uCpk8wRgrG9AKzmR32rtKuDZyScpwxhRSwkbRcz6K
 wwcLmJfoBUrcEWp2AVKgAxzYbAdrSD9GMRL+tj+WUNpX0I3I2PRdd0lt0D5R8XEC6jYn21mJlrO
 JOnDIUhD7kcQ1HiEh5PowTa5LjMc4xjscfpPopq52/spP9V6B/pYKNIW0WDZyLvUtMxHrN8DyCO
 clLITqhSbslOKpn3LdU5EQUtwpAkKTmIm7Oju7Efvuh6STAlq7LyDaiVicYLu5ZU2WPLy3ymGou
 xg1KxK7W201Iho9qQdvQ4s0xjpQhccr68q0jzdBbzPauflJz1HBw7S3FCIckb+EAfmPurAybDyu
 EFFMlgwrTaPSmEvykTL7IP1O5+UkyW9w9zmlo1eQCE6+2oy/Meixu7pNK3R7vGS9/LITc2NUAOR
 WXiZ1TwjM/2auGJB+GA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXz/xcqob9+qkW
 kCbLtrjpY0iEqzxIsK1OdGAPeo7K3wWJ1SpM2axt7nlaIur5JHK8Qzl7XSr8N0rxCOv9UijFLkd
 mJ0+uD5mK01xvR7yk+6dAE/Yps4tL4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

Without it, we'll get the following warning:
WARNING: Project specifies a minimum meson_version '>=1.5.0' but uses features which were added in newer versions:
 * 1.6.0: {'test with external_program in args'}

Which we require because of how we build iteratively our test command
line.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build     | 2 +-
 pythondeps.toml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 6dcfdceb507..2c4cfffa728 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=1.5.0',
+project('qemu', ['c'], meson_version: '>=1.6.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'] +
 
diff --git a/pythondeps.toml b/pythondeps.toml
index 061f0cff0c4..fe2c50cdb25 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.5.0", installed = "1.12.0", canary = "meson" }
+meson = { accepted = ">=1.6.0", installed = "1.12.0", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [meson-rust]
-- 
2.43.0


