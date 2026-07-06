Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE330C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqdN-00082I-0W; Mon, 06 Jul 2026 17:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgqdL-00081u-4w
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:13:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgqdJ-0004du-MA
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:13:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEJpo1655396
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 21:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=fR9SybPj86NkGPNGLjGsEH
 DTANI/tHUqS3+RIPxNUZE=; b=C5/DCKdvRA5Rl28yLRf7h92X7CF2oW7KHmP0/F
 4OUl9AlQUZoPI8AIOBX5hc7+vEi3EELmWoNwcx37tEWf/cl1a8qcJNwIJEXe07IS
 G3Jh1y9YSjWHVigxeX2A2+zW4hfQLm+lFMvsCjEtAptxweSE0j2f9vLWZ93GnfEH
 hi4rN9yRTSSZ/ws6hX5+xhglYMZde/Jf9lnn1m1wXYs5y6cNaxItZW3sQyQTpYte
 us/xh8OmlTUOyVxaEETJ0ZgXAzH6l8qalaze9wejUWrk9f/2fFK+0h5+9KPuxFTJ
 935TzXF8FG7IEhhgqBu9YnSaRK5EKal3rbFds8uVUVUIynGQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpjytr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 21:13:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c20762d21so42590961cf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783372419; x=1783977219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fR9SybPj86NkGPNGLjGsEHDTANI/tHUqS3+RIPxNUZE=;
 b=M1GQIWnnC9ak0hkRRnXOKSfrBaXOJW8a15IFkqfxNe4z1xy3n2cukBZ7wzBcLAGV1R
 2nR/iM0IjYrFgbAy3GNofF/hXLUYwznjsO185dJCSa8npyFd7PhMDHB1y8Rm6k4FCNPf
 1NiM5pG/YVUJ1OR/VhMwvWX+gQnx2BA7ZNKKiBW57Lz3xZWyPdwvuQjYvKV7X2Ip/ch1
 BPzfol13Pfkkqdpr5+9K7YMTENVkCJY9iaSMrRkllEk1bPcWh9F5FQMNz+BdjajwmR6K
 nnnbwG0vkcYqTRNgRzhV9a3r7Y0jKk5pD4vduZoKPJ7UXo3EB81jzp0la7gJroGaF6TH
 XLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783372419; x=1783977219;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fR9SybPj86NkGPNGLjGsEHDTANI/tHUqS3+RIPxNUZE=;
 b=JiN7NMdfvxeqQHEiKIKXUwqUGLgN2I9Xhf38Tb6dqLpw7EC3ALyZxwwjGQmz+t9ju2
 pmx4DpXVuhLaNijtmhMvZJQU3jS8fQgC+NykSkAGTnapbYHxKPHkj/bTOLjjLSJSZEqi
 +WN/S1PQL9tR7xj3Y2TSrOH4I8+y5xBB/4yduQPfK2643ynglCLeFM+uQOTX+asLmgQd
 hdUcCWtvKSW7kTfdUoobbQvkeGhfnvdhm8yqICa3eUPjgt8IpxP8OJsb0cCa8HEhzNJS
 NNlVhyORRi796Oz5gsyVlDwDWYr1cnkxgW8RysdqLomow/jCh9dPBiwjiRQJRNt3Us2x
 LY9g==
X-Gm-Message-State: AOJu0Ywv1G35UKioTLaavvbbr/dC00jKhm2gr05d8ytyRMAQcSEiDOYj
 KtobRASd7ySVCm5v68L5z2BcKt0y1wdcQh+YKvclfBBMdpTUXka56eU5MkRDPs45qhYM+q94a04
 7sRtJuKUj0KVPprqzji0a9pzlJwtNcPBscrFjnlJ3jOQkSX/XwzNub3g7E566g82O1Q==
X-Gm-Gg: AfdE7cmQM0O+HSUwFY4GDBl6Q3Hk0ochIPHT4rPsbRCRZkY1TR3Ki/7iME2SBVERnNM
 NAQ/6mUgA5uPg6NCIYSaoZ8LkWjUjyLMMSOvTICAH5yNG7OeaRl32NhdOq8CDvWdzpgFqshb+W/
 gGxrl1QYfAdb9CiKuO0LlC+xwsyLRx0fxI1pX25K0ZbxozGa23we6nv2fOur5/QWmjDcNpMyO9j
 cgkDdbayrkJK9X/PPEk/GDe4n07psttC8i6xq4k1o6dseHXGnZdPTdE+T9pp/v1VBjfx8nRbFUf
 G96bsTMlBkx3I3sTUX42+3SD4U5diAtpjtdYlwdChUz+0GG9ahf0El/WLgZcYcr+Yp82EW63b06
 MNCD1Ofu5/alnC1mWZgeU8CYolUxHQU7ZB82aoKhF3aJ+3AlYEUedjgq9zu6qNIdfQB9b
X-Received: by 2002:ac8:5744:0:b0:517:5e32:af1e with SMTP id
 d75a77b69052e-51c74797093mr29456631cf.8.1783372419378; 
 Mon, 06 Jul 2026 14:13:39 -0700 (PDT)
X-Received: by 2002:ac8:5744:0:b0:517:5e32:af1e with SMTP id
 d75a77b69052e-51c74797093mr29456221cf.8.1783372418807; 
 Mon, 06 Jul 2026 14:13:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8cdsm30127806f8f.1.2026.07.06.14.13.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 14:13:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] gitlab-ci: Fix macOS build by using bison from homebrew
Date: Mon,  6 Jul 2026 23:13:36 +0200
Message-ID: <20260706211336.11131-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c1a84 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CmH41O1nbTjac2MyBsoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: DPlUQA6Sxr__I1ld2fypK1F0E3Tku-Tk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfX+lCj6cVA7rs2
 hJB+kPz5yDh/81eKm08wdM73L4SAzCM5nmEnWmn4OethArsm7QbENYiMExry9O9QRXUYVEImKz+
 +WorpMKuNG6DcGwvDF/p2M2OMCL+qXU7oW+pb6LB8sU7djSqP3wzBAYXHXVl6ScHi7fi2g+0hzQ
 aGsjGeWC3xdwPFEhRp50oCN6LbafbH+KhEMcBaW12xHCzcmFoT41rjKVlQ/Wy7vwFwJ0fdpf+gL
 MzpAipuPo5NUacBjWDnOXknBS99wdQs/3RSBNnLqTk49f4lk4HhNAyMMguS12XquuaxGETuUf3n
 3UmG/yZocCrjwSkZMNeCHZ+QHGFojpwb8cKuLgCYrenN7wLCk5iSEWhL+F+DbZbrqKbIDPGFMpK
 BtMlBRiJ97MjaQHXNrhjCNEql4IidUrtl3PDXOuM574y6gi2I0AzC+UsXE+rxKjMv4JRScfTwl0
 1k436GnBjydWut7ugeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfX23xZPBs0Trpz
 bahXdchs96LIWr54xkGhzNhuPjkJ0ncuNBpIDgDeBlsxYkDZu+W1ku8eQd4bZosaAU3R5tWo+K1
 q5EVcKTcabf1QzZz6Q+4JcrrXHxAg1s=
X-Proofpoint-GUID: DPlUQA6Sxr__I1ld2fypK1F0E3Tku-Tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060214
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Since commit 6beec3bcdaa ("target/hexagon: add build config for
softmmu") we build the Hexagon target by default when system
emulation is selected. This commit introduced a hard dependency
on the 'bison' program for the idef parser. The binary provided
by Darwin is too old, and the build now fails:

  $ ../configure
  python determined to be '/opt/homebrew/bin/python3'
  C compiler for the host machine: clang (clang 17.0.0 "Apple clang version 17.0.0 (clang-1700.6.4.2)")
  Program bison found: NO found 2.3 but need: '>=3.0' (/usr/bin/bison)

  ../target/hexagon/meson.build:300:8: ERROR: Program 'bison' not found or not executable

  ERROR: meson setup failed

Since we use a lcitool generated vars file, we already install
'bison' from homebrew, but we don't have its path in our $PATH
variable. Add it to the macos.yml PATH_EXTRA variable which will
amend it to the global $PATH.

Fixes: 6beec3bcdaa ("target/hexagon: add build config for softmmu")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
This however doesn't help macOS users ... They need to manually
register the homebrew bison path.
---
 .gitlab-ci.d/macos.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 53b6e6c4d8f..3a9e5f46702 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -37,7 +37,7 @@ aarch64-macos-15-build:
   variables:
     QEMU_JOB_MACOS: 1
     NAME: macos-15
-    PATH_EXTRA: /opt/homebrew/gettext/bin
+    PATH_EXTRA: /opt/homebrew/gettext/bin:/opt/homebrew/opt/bison/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
         --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
@@ -54,7 +54,7 @@ aarch64-macos-26-build:
     QEMU_JOB_MACOS: 1
     NAME: macos-26
     DYLD_LIBRARY_PATH: /opt/homebrew/opt/expat/lib/
-    PATH_EXTRA: /opt/homebrew/gettext/bin
+    PATH_EXTRA: /opt/homebrew/gettext/bin:/opt/homebrew/opt/bison/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
         --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
-- 
2.53.0


