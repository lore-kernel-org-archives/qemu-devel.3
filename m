Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2EEC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfR-0004rJ-Al; Tue, 28 Jul 2026 00:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfP-0004ow-FS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfN-0001bo-VL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3abqO1527468
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M85wKm2rDxEWg7Na+MjBuWpOW6hY1FLQ5Zv/wM7+Q78=; b=C1RmFJ8xSiu+RQln
 Pnls4nojUhCaOQNJPtmmL3KWPeoM+NeZAcDTr1EVTvH08Ya2FdVocmVEL4HG9rGW
 hOmcgDuNj1b3ZbVlhFQmKEho3Q5XNjtNAhAtfAiLkKjaXD7B1jyRRe21PW9eUcNP
 z2AQgQd352qJ/SLvULTaKiwTHLsg7GB/wnTgZEqIVsXM+8aufd3rf5MpQpOmYC1m
 FeC41cgDg2BInw/wF6i1cxVZfYKiO6Ww8wbwA2PYp1WqevH5/H6AG+2gcTYkKQhd
 QA8s//7PeTo2XU703tzOvBsjvcs2+okaNKoAbBhGf7l9WaeEOLU+eU8vrYduEu0S
 6Axmag==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8acv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so534802a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213814; x=1785818614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M85wKm2rDxEWg7Na+MjBuWpOW6hY1FLQ5Zv/wM7+Q78=;
 b=AAd+YAYmt9O8QqK6R5Wpftu9eF5iNnEZlC0ANJZMlCvbA6B8E7AUmwROP6BQ6tMT4q
 K/O/37M02UeGYBZGM46spWSNVJPjGHqrCdWUNGGKcvfTv3mG2Ee1aaRrOLVyST+OFU9G
 n99NLiKQ2x7VLxCBP/V0KrPmUykX0SHx4bHPRdlO74/ulwgPimt6VwF1XHsQfXSyoQKj
 INeKrK2r1h1Z3jM7eKEIrJDzOw8b2b08bwO2p/xaABDf5fMEdKGa2SUXG0FgkebN+FWp
 mM/fUd8qB+jLvlBQFxKQzaBj1/kP/MHpKvr39z91ll3+zgAhoLHnoeiIjKmD1wJt8WtJ
 zTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213814; x=1785818614;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M85wKm2rDxEWg7Na+MjBuWpOW6hY1FLQ5Zv/wM7+Q78=;
 b=rIvO+AK85ATBUr7D4y6wOF/4QbjUtYhevquOqqDmfIiW7O8iF3Cxs7ttcOrNcPPItS
 5gn5fQeb9U/yGGZcj1Qbabb1KY6pmJ9xJX/Q8IQqQEtNBUC98NFezOoYvQNx9YyFn1aC
 VlXjI7Zsfnwo/sxmj7EcECzabfHeGvRCVAk5PspN38PvCoSD3ksYWq6pyJDvbY7SS78I
 kRqtIs4uca3ft9SmH6tKn+gZxPTqIulaPUutgRALDAVqtqbNUIfub19bqoNx7drkxT1S
 yYQh20y18atB8OP+tGPgiLusEESK9JVmOAdNmYSJQNIcHj1I5IwWm2lqHkuDPfjeBAx7
 Wo+Q==
X-Gm-Message-State: AOJu0YwuR4/xZl273IKTNdLN0mpu4xzEv5C/47Uj5ryJ7FykxA6xwP0K
 foy/lTUT3NW5xrQ+saQjCAMQLXpn5HkGUPaBuVD0Imczq+naV5EiMX8iuo99ZhQFSWQer/l6c5v
 DlDdwqBM/VOaaGF7Dk78EA7eWK7G3PEORBbCZUlZVYzYb4N7Xyp+buT4I2Sf156DuMA==
X-Gm-Gg: AR+sD13XC7r0B7QNel/xSlnCJ8bi75Cq7K7Of1/yc3dO7MNnc7ELjUyBeZidbHGghWE
 0I0hvdcWtYsw8K18gG8mLr4LJHFxKtLE+Un9dARtMGmgJOmL7qxQgrtiBC6tf79TlA536dDYG50
 QjCHibkuiYN3uuesdBcfqEKxKgYKcrw6WmElpnN/7I/q8wm47mOH3UMZEDgkKWd5nCJ/qtvmOJi
 74hinnG1GsOK6g7lcDr3IPpRmeVjtnNVOVwKWvoPAsrtO+a6HUZhT59XZsw+mdtBGgwrLoflWmn
 ydduRFbRr25Q58pRD9nJfPXyeLnR1VKsH4QvWbPl2qfpT0p5dYH2avwpOQwM4gNjmm38m+jvgKs
 67n9zQXgk7Q7AYMgnsiTPhN9duCHWTPRKZW9SwjokfTDyszE6i94RnFTQbOQvtIWgUBqK1gA=
X-Received: by 2002:a05:6a20:d808:b0:3c3:80bf:a861 with SMTP id
 adf61e73a8af0-3c8ba66a377mr1058896637.75.1785213814035; 
 Mon, 27 Jul 2026 21:43:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:d808:b0:3c3:80bf:a861 with SMTP id
 adf61e73a8af0-3c8ba66a377mr1058864637.75.1785213813612; 
 Mon, 27 Jul 2026 21:43:33 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 021/103] tests/tcg/meson.build: add logic to skip tests
Date: Mon, 27 Jul 2026 21:41:25 -0700
Message-ID: <20260728044248.137626-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXzYJXOpoP6Qat
 XLqcsyRn6WTfqq51hQfgXkIdIcCSaP6cg9HuEnarHTcPJOr0i1IoJzws5iyiAhdEkoYYoZEa4kB
 kdYURzO7tNaO0DGTtuoz5QYi/iU1PJ0Xj3RDmQaASX6c1Top0tjgUJC/lCn1ax7DPpWFa342TIr
 CfBo7pbv/Qy0FtWYp6J0hWnkLyqrvoYV3Ybv/UXjnTJqV453QMGomB6xvCY5erz2XsYyNICA3RR
 Ph4B4iTYTg5jmIEtkXMORUba2TkPGta5GrJacR7W6sxjSb7e5Cur7D/KS33VzN+sY9DUm54Nhgm
 ujSYeIJ1D+HWdUQ6Dj/5xQF1SHJAa2xN3o2V7grpkcH3OiMDuBuBFhmkfd6WPV5cIyRzEPJ/qvv
 G9u7/S0vD+g7BA0bCZLxfq1KIY0nJKnm58ZnY5h/5XBNirm0CEMrPV04rpxRDbs58xLrKXRobQF
 5IcC+6O40sIBEP2oggQ==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a683376 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6JUaU-OyqocPaAnZ_AcF5aonhMQ_5rYT
X-Proofpoint-GUID: 6JUaU-OyqocPaAnZ_AcF5aonhMQ_5rYT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX9DXcU5SNHb9d
 kzQP47n6q56cPk82hOBJDIStcZbNXHBgURDqkaVfa5lr39diyHXj1YrY9OGAbxBPJ6QO4kAFz9l
 fu2J788nXhhmzjLX8GfniTGMw4L7j8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

Instead of skipping tests and not declare them, always declare them and
simply return an exit code 77 (SKIPPED for meson) and print reason why
test is skipped.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 779f9043abb..7b60ea53825 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -114,11 +114,15 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      # if set, we'll skip test and print the reason
+      skip_test = ''
+
       if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
         continue
       endif
 
       if 'plugin_test' in setup and not get_option('plugins')
+        # do not use the skip_test logic, and simply ignore the test
         continue
       endif
 
@@ -226,6 +230,11 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if skip_test != ''
+        # still declare test, but skip it and print reason
+        cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            timeout: 120,
-- 
2.47.3


