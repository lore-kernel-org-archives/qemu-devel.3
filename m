Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CE8C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZgx-0007Qe-PT; Tue, 28 Jul 2026 00:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfY-00051s-7P
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfW-0001cP-Ke
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:55 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ad3S1527550
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IPvr1ov7jYQK0A5/NuJKRMbWyomZMnz0ud37zgbzmj4=; b=igaOMtTBw0tLX//Y
 AhrOtfcDHLr48OGLXvCS7iFMyxO8BSaON+8dar9lHoJJKeAcvb6ZYtmBFak/SgGq
 ylyQbihFPj40bXGyhrMxyWItp7KWWhXx1q4mWAb0DtG2HGzUbTFdl9Yvseo2Pkqq
 bcrzwItl/Y3r1RPIXvSVafIfStXBp9K7lsf2M9ggoDrYG9DQaUkaRX02EPWJECy/
 LL9BqXlQ+UXG2Ag7KQDGHygfdMVZENJ58FUniXIRQczBSoe0jMUR64cIHtHwf/Nt
 d5LQKyCQqiOFuDYAC/B5vV3Lara6Ls1C09BVgaK/lNNOnHkN6fwyKTzrdeUIfjGX
 mb8o2w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8acvp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so535010a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213822; x=1785818622; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IPvr1ov7jYQK0A5/NuJKRMbWyomZMnz0ud37zgbzmj4=;
 b=TTIYF446UYQYHHedaLiqS+nB3+lT7W9jyoxecpNoiH56CH4jb1Mm0JsfLeRzSZ0ebJ
 lhvllObbqovX04fNni4OlA77vCm1hIzGUPLAhRAUzb4abJmQ4jr/y7v4U5g0vQ6EMeye
 aHNDu56odT6cg9yKZN+LPAIZh0guyYdu0VMySMzcWF5mApXQXzD6wumVlDhAO54477x4
 ec4bSAli9a5O+QIy2mOAN1L2ew94ji5laifEnPvaYr63IWG2GB0wPmjXNjURcQTisF7z
 yzSLqrv4A9lb1AWZVoZo6NiHU4rDjl/zJr4RgOP7EpkpjBZZWap5AzZ2LQgOWoBxxlbD
 igVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213822; x=1785818622;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IPvr1ov7jYQK0A5/NuJKRMbWyomZMnz0ud37zgbzmj4=;
 b=ldXRqfsybRy9tHFRKjwUfkRh0NZ3h744BS0N782UicN8vRqTW6h7k1PtwoC+RqEdBt
 xphK3INiADwhPr9bDtURlQxqAx7aNyWmi47SKnz0n6G1X+HSQGaXA/5IBN0yHvIwX7yS
 xN7yWMNK383YRzHRIMC3A39aFxT9r24t0/3lcnIkmTuvrJcxYSMfOdYGcF9K9V9XIBgR
 6BckKXdupBPl7+2G6qDNHnzMMt/N/uzAL1NE9avd7a4WP/rxNS7PCU6ylKd/1HHkt/A+
 P2KK3oENKvWyvOJUDErLQH1jLY+UtIGN/snC6AvLbTy1mx6j1gvH0IXgtRqkFYG+PMp2
 I+zA==
X-Gm-Message-State: AOJu0YyN/o7ALmx3+mR8uQGO7aw5FZOB5aim4+PyfDZYchcdNE5e7QAb
 oG9nN0c9bXb8rdm50f7zt9f026dnaoey0SRvK2e03Am0bCBMgBglCgqWbJ5jVBK9cYs2pruDRfx
 xymkdL5K4qULur2NDVPyzFUTaea5KkY5zMduOhHy6X1wzifr8oDXdEyqAkCrQRMdeYg==
X-Gm-Gg: AR+sD13zAk/gTAUFwRev8CAuoaAf8g6a5RiUM+OgHyI1FutTcsDy0WCG+ZbrkTMGJNp
 ESHCzv+KwW73ikxnA1nOIuSwc+E1Wvq+JO7VsVWaYb16RfC+xtIBIOWckjz2nO80tRiTAZzlyhK
 9g22cslYeMUUfok46AlsxXK0j9uUOfCpNxzow4vXQgLy4x0/+53PqaLXWQxEWw9i3SJAy2+WiK5
 YNDQoXUb1mNhdkFJrKxDz4EcNJaZNqisrLWm2UN/kd6sZ9Api+CcHYGuJDiHtDzcjnXieDR3qpt
 XdTc4lWsh+fTLjMy+UPlgj3oo6yEANeGz6ZboVdqeLWoFI3j/TdLb/7rIPxWscCLHtHg6akQHFL
 3lir2eI9Z7hGUGDvowwt85v7msVDMGDfRAH2ukyII9lWnSGSrW1rxgAQBJtZ9dv+P4+DaSaw=
X-Received: by 2002:a17:90b:4b50:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-38f6a27d798mr789286a91.0.1785213822491; 
 Mon, 27 Jul 2026 21:43:42 -0700 (PDT)
X-Received: by 2002:a17:90b:4b50:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-38f6a27d798mr789259a91.0.1785213822099; 
 Mon, 27 Jul 2026 21:43:42 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:41 -0700 (PDT)
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
Subject: [PATCH v6 027/103] tests/docker/docker.py: remove "Image is up to
 date" info
Date: Mon, 27 Jul 2026 21:41:31 -0700
Message-ID: <20260728044248.137626-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX9q+sS4UjXOjs
 y/ig53I+6jFe7hMNGzEYVscxAoyn9dabWH8ju7zsYKA5Kk9JFfYnhE4hLa1e7gksn+juVAhWkGg
 adarDVjbLMjodEk6OwE8ScpP0nmPsYa7rlj8GYpoK3DlbBI6bwMr3NI+pIJjNmbitn6z2gg84VF
 8Xuh5NmbYbdEmlQuIRKO4LvFZGFUEIboTs72IfqL/2riwR0iPkXCWY/fEgalZ08PAA/ATAd1ggi
 yXBsAaSdkPZbtZArxL1u7QDIX669ueccc/EumDF1CHZZWhUDWv2etTu/TUPTXrgUcfWGnOlTcHi
 DTxkvm0vGWfGWgqMldvdUoRFb+7E3N0McUPmRhA9MlistHfAT3XTMUJHa4z6ocs1yLcZLwf6d8r
 Ag7Pv/TwZ1eAOsGWSUTFDRzGzJ8fLz1WWR1dfjjt1KEpZ0XFIBjXAo1UzPHyF3bkNaIPenZe0Ed
 4cc1qBavjWYcEajbKdw==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a68337f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Le2pUKrCS2B_8Q0jc7MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nqBeto_N99RCAYXpN3l0DM4bCpQ7zaHx
X-Proofpoint-GUID: nqBeto_N99RCAYXpN3l0DM4bCpQ7zaHx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX6JTNTolAX+le
 PpCaJYG6b0lucH0yIb0D/NgEmuPMBWAbTAHHXHlvhdQwqEAOhtIm7TPYLKCEaeQlbP55tZfW/mo
 15BSytJVUiMjDISfLg4shas0hZh56m0=
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

It's useful to print build output by default, but not useful to mention
it succeeded. Reduce verbosity of tcg tests build.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index fea6d0f85af..315fa2ff848 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -429,8 +429,7 @@ def run(self, args, argv):
         dkr = Docker(args.command)
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


