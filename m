Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FC1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4mF-0007KJ-94; Fri, 10 Jul 2026 02:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lj-0006ZQ-Sq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lh-00075m-BE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n3Iq3802204
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V0FXnT6K77J
 /v4boQXA7Cgh5aAvf5QcNIOYcCs7YEd8=; b=fIah8+f1+oJLCdcbZI1JeX94tlv
 pnHt8sR2Pd6Fw64bNJvIg4BVaUkIWvpIcfrJydbjAF4wf6+mnAhoFB9EFb3LmwEv
 Z1i+ogs7A16czkfJ2yJf8/fWXumP+L774lEWu9Z6P8tN+LF8szF9LiQkpluaK/Io
 Xe82jW7MrklKHrkm/LSDM3ZqYJD/2ehMny7RqX1KTJp789qFB73bi6H2SJzPsg7R
 aOurDwOmERg4MQahB7vbQ1Q56BPGjw+GZ8/rce0KB6QMY+onB2QD25fNi+Ge1Zxu
 17i43pPIrtZgMLyAKxp/uF56eGcf+ME6eiqK2g45tQkzQZilMfHdx+a6Yuw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpkpe2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-384048e7e14so901861a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665073; x=1784269873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0FXnT6K77J/v4boQXA7Cgh5aAvf5QcNIOYcCs7YEd8=;
 b=Z8/x/RQ3Wb8t7Jf4/p5F6FUgc0Rq5kqyRVEtDZNMWAYz1/XuP+Dlj/3ZYIBMJwtLIb
 5+pqSNMbjRnfe0Jh9BaYPwi9Zqk761TsbZxZGOUkN6HKM7lN5ZTMHCdFZ9kK6J4gB5al
 GBPv2S85OKjxvaNGhnXwAb+YqCxvNcILtXCdS1vaGvK/svWcg9RkP2g/b+H5JkiA+rsO
 JJZXaC999KhT1hnWUl++q4Kz9AVDziZBxyhGS6/fWBCNwBFFe4le2N3WHQNtHaQJrYTR
 W8xdgLjAdZSIYyYc/fZhDyl/THHaLNe34AoOr0wVwypwpHrWiJf0LnNp8vgiJfQFiS4X
 Dd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665073; x=1784269873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0FXnT6K77J/v4boQXA7Cgh5aAvf5QcNIOYcCs7YEd8=;
 b=JO6vebsDp6fHLf0xIBBNlivtbzS2VVYFoB/MxAVMfVxtzolIrpeSw62wgpyLKi244m
 LuouJT1j0hgmDTvIsDj2Dpffadm8HhRQqZ4Og5BA9A9IrJ0ufPXcoL8xaPRiQZdFmL0+
 cd2D+/GJiXnc1AZ/Rk05xi10vMKg9f0lZlcoK+FDSK+gJOd03pbXW+jv/kZthXqJLyd8
 e5S8p3Nui01+KExAvbzKadiyq+xe/A8v5FIii5Dgi9Sqg8YvB8eNE/XcYkcfMxHdAwUh
 4pbEz/EUSmMG1LwNd3brq8gNVxjisjXPWwzKYeSuN1VHHOz0ftHXb76lYUFR+fWH7tv+
 xoEA==
X-Gm-Message-State: AOJu0YywMwKEI+O3CJq7ZYYLcMFBuLFnmAsjuLtSVNQ9fyPRJ4xn+tzP
 bCbnPLFNaFNed2nOuWTIOasSZ74LaDWx6Twrnui+NZXsE1iCOByEReNhgSFhVEDdNsK2CDKyCRp
 LXclvqUkO3/pGtBAbNg7Okg7HuN/erdPAFTSOcKiTycF5F+I6LoM5UGhu8725YjyePA==
X-Gm-Gg: AfdE7cm6gpJM1PgODxuU96+KnHOJVFHpnQcrbY+bQpHr4007Q8sGwEDjiO7Di5yWi0u
 +gib/qiQohhg9EJoyaOAh2HS77XoVvYHGba8AqnHehfkFkt2BsGSBydckctZSRYx+N1UfIXjH3N
 38+5XyIKaa9cotiaLRAuyGwlZkoqNbFz8YFxrhcMvDSUU3hk63BvSqkVUbeZeGz8z7z6r2O0NCY
 1X9hy0iaR9v2LIh6U9LNwFPdY5Z2lO4Owb9YV6XLKNoqTLCEijUhhOJcMon0uLNyduq25dagI+8
 fEa5xD60grSwI6h0aFRnGPrARjUH4Jql2znwTkh/ptyUS2SwtvylLqf4vM6mJ+Z6WWVSekt7zTn
 0g98GKk3MTNFlh7w/xMPTqUqlF2CYsBbTgtWz9ZnmHfLVwI1zvpznlGcBRqmrq//4yGmOCT6aLq
 BIwL2Img==
X-Received: by 2002:a17:90b:3f8c:b0:387:e0cb:7f7 with SMTP id
 98e67ed59e1d1-38942b786e0mr9964878a91.43.1783665073471; 
 Thu, 09 Jul 2026 23:31:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8c:b0:387:e0cb:7f7 with SMTP id
 98e67ed59e1d1-38942b786e0mr9964840a91.43.1783665072991; 
 Thu, 09 Jul 2026 23:31:12 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:31:12 -0700 (PDT)
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
Subject: [PATCH v4 93/97] tests/tcg/xtensa: xtensaeb system tests
Date: Thu,  9 Jul 2026 23:20:11 -0700
Message-ID: <20260710062016.1818125-94-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX/JS0HazwxXhj
 rall7vjIHQitaUaK3S7Dx0UtBuDAzqGrGPsZhdK9ckDb+iF+MjqKWz/z934M1l+6+5xxZnuN50j
 s6kehPnmIDBlpuKJ+jl+sAUfw2bA/t6acIL2bzv6uKvlNLO/n72ypiz/eIlhhYuyGEmrdbBcW5X
 dq8RPpiMbjsKlYNNSMbRjMDNiXXqXA3UnzM7c1NvbFEsNcUfbnPA5+JFiXIbw2rpN2HgokuHHpG
 fuq3z6Ny0Yzk1hDXDNWTcdOU9gil+IXvyQ9jMBLaWM5+Sy9U3JpQp9aWaTgnNCwDZgZim5ipNb1
 w7gaL5r8uveRtWC484MgUl+wfFE28zCGnW8d/mCC+kB2q4xrgf34Fjppe6fhTbyDr4AfvzTIN+Q
 Tj2Jpf7UFDjZy1QjNPYmtaBN9svATzahUFhNtNBH8yuFbj5keFJ5pn3q6ZjJNUK7PVS+1GvMNS+
 wSmyNtC5+2E7wcO9bLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX72Aa7E4qHsqF
 247+dM40aU4BNsmx6hcyfcfWEkUMrPLpGZUrA4E3JBI56RYlI24MUAg7Zq6fvDYJ/XnxzE4wu5h
 dxE6ovAa2+58ugKZxhmca/zf/cs46w4=
X-Proofpoint-GUID: u0eUkcyvaB15vULJWc97jkp6E8Tw3TIG
X-Proofpoint-ORIG-GUID: u0eUkcyvaB15vULJWc97jkp6E8Tw3TIG
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a5091b2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Gpx40EtBKFK82MPJ2IoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100060
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

Deactivate test_timer which is flaky with xtensaeb (25% of the time)
 ./build/pyvenv/bin/meson test -C build xtensaeb-softmmu-test_timer --repeat 100 -j 100

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/xtensa/meson.build | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
index 7c3c4f7cd62..680fa02ff5d 100644
--- a/tests/tcg/xtensa/meson.build
+++ b/tests/tcg/xtensa/meson.build
@@ -1,5 +1,5 @@
 tests_per_core = {}
-cores = ['dc232b']
+cores = ['dc232b', 'test_kc705_be']
 
 foreach core: cores
   tests = []
@@ -94,3 +94,17 @@ if 'qemu-system-xtensa' in emulators
     }
   }
 endif
+
+if 'qemu-system-xtensaeb' in emulators
+  tcg_tests += {
+    'xtensaeb-softmmu': {
+      'cc': 'xtensa-test_kc705_be-elf-gcc',
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensaeb',
+      'qemu': emulators['qemu-system-xtensaeb'],
+      'tests': tests_per_core['test_kc705_be'],
+    }
+  }
+endif
-- 
2.47.3


