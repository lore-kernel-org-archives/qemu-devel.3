Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B324C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4c6-00029r-Oe; Fri, 10 Jul 2026 02:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c4-0001uq-Fh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c2-0004nG-S1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3miGn3721099
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wwak1i+Z7YShzNB0prJqmDShxkxQBGZxGdlmBmYltbA=; b=Bv8hKqXHWst9rQIZ
 X752H1ZpV3VSjjrPiB6+2XcNMjBFMnb+uFag000/RjMQu5qTde79vcaWPRI2x5Pz
 PsAgx562CJtajyt089HTsvVSKNG3n2CLvAQa2z46z2mulv8tkgLl/I7K9XL5pbd1
 m5uUd3mcIRYHsgL376o4PZtIkLOWln9Ttm3dmEfPpmPEs1V2XCL5nZI8eYpKmVjT
 SaOdZEQmDDrbRaHX8NRkNfQ7C5jIAItd3rfygC2lg78L5+Aw+G1Bw6JgLezi/BBt
 KRH5kuju/vH6OH2vhdPgJumhGGnkImJ8O7svm9kdZDNcXCPaGAOTIviAKS7lKAOH
 f4RirA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwt9nmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c916d17dd43so1038489a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664475; x=1784269275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wwak1i+Z7YShzNB0prJqmDShxkxQBGZxGdlmBmYltbA=;
 b=LXpnYTi80leUnWa9CFEgTV6zPVW3QzuDj3hmQTJWB3QSzYCSrIMhFP1epein8zvA7V
 w3o+5VfgmBfR8TWQIa22WjIOhulWJk96mlSCzn6/vk2wmb6J2OzdJM/q8M7V1VjpKJ5d
 5qcwuKJCZC7UscPoJ0aDpxSOnOhlXZDTzJ62UBHtf+ITjfbuuda+q+sjrWD65i50iqOC
 yC6GyF681COqdS6AsyC7C+tZ5cWC9pQEYdLJ3DTy8cxN0wSJQjO1D7Aq/X456BCYzhsK
 S0IMX2a9xaW5YzpNmc+bUO7dqQhEUJtgKox49XfkP2cnn3EiuwHaQTaVPOIawhiKt/kF
 INTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664475; x=1784269275;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wwak1i+Z7YShzNB0prJqmDShxkxQBGZxGdlmBmYltbA=;
 b=dNAiJah2/IgHtvG2HtbRZXQ5JrED0GptF6YhDL+vaeToc438iaG4R7Q7K+ftUXUwmW
 XIJ+XrDWotBNRYZmfUWKmYYY1KCA3Haobpd6O+qH5fqhURKJfSQtrYajsX0VHdltwyXR
 oB/yblhXn+Xso56JfWl6PSJ+ePkZ9ddlGhK8F8/bPQhYP0+4i5UtHFqZijXjN+S5w2Iq
 17VTNIXDxMHEGf2SzEMcgKZZsNhUkPsYG+Y/YkUwZ/FLLY14CnQowqP8QOjt5RO8pYcy
 WFal0diQeDPhlihDqVlGYTuBfPpO74U2lW8Yn3AYjTQU3J+8ofLCwtJNC2SYHua4z9If
 DDxg==
X-Gm-Message-State: AOJu0YzmQev1aomfa/073wu0mIc7Y/Rhc2zyINNNsJs/wQhTNRkIokuf
 hoBIK6oM9XaLR6E1zXhoGsSjjN0b3ytNEMKsUaHYIAdpRW0X7Tw/TIkrIXqg/DGYsSwxSw3DUVq
 9w0uSCuLNR9mX9YP7tUZZwt2U5vh1ayEFIa3IMRv/C7f9ygqVOJXJESaNeidZCPw2yQ==
X-Gm-Gg: AfdE7cnU6J4ccUhO8kF4mEqNOg8Kx0OSYYHrHz8EfTja1fqUZbodWrzdBX2Vvoz7ie2
 8K1aqJ5fsNomYulXKA7Griqz5xMK5H+uWHc1zkPP4e9NPaooAEVXTIj5wwTxEYFlRX+r0WZ2BMf
 aVxX+5x2/riK1qhSo+x3UMMEayCdSg6tIPz0GTIMr8CPL6Fx/dlw8w1VjPHxNkOLXbAjCwvhS6e
 LBpYxDn/o0DV4WqrHerUmueoTzIpKr93iyXMaDqsDDrTkUPwxWLHAFUDjQtA00wyrQZnv8CthEb
 Q971I441dNf0GKZZL7jkIi3JK3BZxJYcSgFUAXo4wT5WsLZF/InFQ3995b2ptkCDJzCDElhtkM1
 LeTuYQiEd4O9nVhKeSo/4AiuB32nmhnPHYXepRCWZba/71JSEBTNxj1OS57cm8iL8qv7b2wD4Ea
 pb/WpTow==
X-Received: by 2002:a05:6a21:32a2:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3c0bca49c1dmr13537633637.33.1783664474578; 
 Thu, 09 Jul 2026 23:21:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a2:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3c0bca49c1dmr13537587637.33.1783664474119; 
 Thu, 09 Jul 2026 23:21:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:13 -0700 (PDT)
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
Subject: [PATCH v4 27/97] tests/docker/docker.py: remove "Image is up to date"
 info
Date: Thu,  9 Jul 2026 23:19:05 -0700
Message-ID: <20260710062016.1818125-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a508f5b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Le2pUKrCS2B_8Q0jc7MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: XWtFNWDtEtV6aBJzTfmWLz_f8udppk94
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXxUtFLrG6qA7R
 hju1/981eG7lC4Sc7PnAcGddRzRQcJ3rNp44QYmbgGRJfbDY1EUTFKiUFkUk6EPCU2GWTMNzWYY
 82nxTTfLMf2B6CLBZv20U/U6ShixzlY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXyC3hl+d0c4y+
 hhcoj7pH5KlMk72OpNcaeFZM84FPBou/H9lFJ/WrdSop2YriQNhiDJ3M4Xl+izQvkprFsuBIl+J
 qWf6p5GNcnf3fZq8lDNE0Hw9Mt3zFTbiqRAvNdut25ZMo7f0SvDIbH89mCsz+Jbk6USkUhmzeAr
 HOIJJF9OrbTm771Hr/FBRUNoZUuoOOR9xUqh56EUR9c3oOJh4kFB0VwdV7+lRJixW1CBGaIsytb
 rrjgGCAyiiLEW3DUoT6jmWFpVzyh8WcAC+DwBD2No4cJCV8ugueU0cYN2/t1Eudlg0GB3xYzo7y
 +GCstX8I51o7fTQ4B8sp8r/VrHFKysx0D5PDNVyoui3PJopKjBecglirfc5qAGK7x/QwVEEqUw0
 eoKDlagmipWuzAfQo8gXMDM2lWuhp1OdpUHhVpm/rxurAUg5HSX9SLtHFzkuc0zMJ5PyOSr0g7f
 szplYCmRkhJIB4kwTpg==
X-Proofpoint-ORIG-GUID: XWtFNWDtEtV6aBJzTfmWLz_f8udppk94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

It's useful to print build output by default, but not useful to mention
it succeeded. Reduce verbosity of tcg tests build.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 6640cebfbec..128c0e6caad 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -448,8 +448,7 @@ def run(self, args, argv):
         dkr = Docker()
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
-            if not args.quiet:
-                print("Image is up to date.")
+            pass
         else:
             # Create a docker context directory for the build
             docker_dir = tempfile.mkdtemp(prefix="docker_build")
-- 
2.47.3


