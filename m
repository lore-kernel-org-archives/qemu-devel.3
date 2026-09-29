Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA6ACA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKo-0001KE-Sg; Tue, 29 Sep 2026 17:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKf-0000yH-TC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKe-0003ty-A9
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THoGjm3301456
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u0vM0Qw/+fO
 SlcluMXOFu9EVoii7wmpQkch+S+uSqlY=; b=cmG7qBrfCn5nQ/VQaF0FvbApF1/
 V8eV5fxG3pJO4ypdfrSjEkYMwMK/1QGjuTvZxiyLibtumV6RfvPoPJsiXcOePYEA
 49ncH/rZHXv/PSkGqdg9b6heDB66u2LdbUbqae+wGdURFNIIJtXvj28sIfKhaz2w
 uKNJFSl/q54ccrrILHNAn626OCj2exJAvSAfd9AYpAdE4fYDujX5i6boNQZwaK6/
 ljEskKM/JfnBh8UyovOte/5J4+f4pOUAucB5K9qeXSD/19NBptOmBViH+ObdGGt5
 pnkSKSyNEtjS3yHfhnqjv0ONl/IT1csjhIgdUULgdHD05Yu7cMXEw72IP+w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx27q4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3282d5302ffso2210678eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717136; x=1791321936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u0vM0Qw/+fOSlcluMXOFu9EVoii7wmpQkch+S+uSqlY=;
 b=JEsS1yGQVlyDzAjB5vFEiRGJdzsuM9va5rnefAgJ9f5pB/0FYqI/r48m9Youwi68Mu
 pfEHhWwR5nM+vSKL5+I82oWsNnN7fGc9jn+2CZsJnhfxGbkKGv7Mtwf5e8kNM+Wtuj5H
 yvoSAvsHDK10ayXPO9hS6LdaGEQ0NeZQhdkdEeXHxjLEhvJ6b9Bn05Aubgjv6bZHDcIL
 /cdZPbvtRT1YodhT7EUoN8GybFkBWUfHdmcgKQXVttjicoomEnPXjFNNkxenzUY5LKvd
 CgAF8gxGInsDiwt4HA+C6vzX/fyIsSI1vRpk3yxAEJNvXlbkMSMxQVCVrX4NfyIho4dc
 TJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717136; x=1791321936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u0vM0Qw/+fOSlcluMXOFu9EVoii7wmpQkch+S+uSqlY=;
 b=CbmvTMh3zJTBjV5pqjUl2sJVwURTTIs5Az3aRtD780vWU5k7yubbYYXn5toBqpwbCW
 FJsnIQoQhiI5GmIHJS7HsN4o2kbloQt30HMdi/zebxwTbdWx1zm/CRplxwKbP4+xSBuJ
 w98zUthp2P65phkwJFxzdOWEifTnpdsEvYBgm/W9a4ti5wYujF4Mn9oN7hd7WCWForUG
 8pv3VkvMg3nH24eWoR4/uh3k2e7d7FH2mv3Bf66bSgWHoAFmoSZtN6uPSMZh+pc37yUf
 5gUQBE41MeCNwLnPKF4xgkQBOYXfWAySLZhkzXrslXnEqWmXdLvGIPWYZL6ThmOCa85A
 IL+w==
X-Gm-Message-State: AFq9FYJvsoFRdjxEgst14VjiY1ZCZ3PGuLyeJo20hrHQWv26Hcqb/uwi
 QlrmZKxYls7/9p7ptd+Aqkx8pCCFPP8gZzKzridE1r+jdJA8/MTukzLpvPc/AYreJ9/koD81/0P
 1LbUum9S9ILEaYhawDcu/DUVDaWBq4VG4F0Jrk+e32cY7wxG802OTeeJycvKqpmThAg==
X-Gm-Gg: AYBFou34lKfI+2VX8zkHOVpDPb0ibBxHImwNsiGAXevonjWfxM0uN017gLcRd1pFprU
 XvzurpSs0HdzKcaXfZM5rbzM6TZ1GGwAA7UPeQS4YWZyJvUNaF6JZzQwj6wHWb5Ef8qdNSiVGHT
 5j896Ilp1Ah0hHivF/V6rfdlmFZ1Iw70liszHNp3lYxaMB/BskmKAa0VhNCCygc6ZkufYLnfz7c
 srOYs7n10eI4IeMC18UvY0DYoKhAMLV9oALZjM7GEY1wdkOGlVsyS879M9Y1mcs74uMsREQk8oY
 VFTXD4wFEW8sfc83EuHVWyhZWhPbBIylRrtIPQ8y+9xdz6BAsWk2voyrUzPz0Ek3ZGc2SavUTIa
 DWCz3njhq8QT8QAfX++JTXCxFjHOw+W9B1c7LOq/isfPCxHh4OIoRenOl6YDO
X-Received: by 2002:a05:7301:860e:b0:344:1b88:6d88 with SMTP id
 5a478bee46e88-34af823fd75mr4225866eec.10.1790717135734; 
 Tue, 29 Sep 2026 14:25:35 -0700 (PDT)
X-Received: by 2002:a05:7301:860e:b0:344:1b88:6d88 with SMTP id
 5a478bee46e88-34af823fd75mr4225808eec.10.1790717134763; 
 Tue, 29 Sep 2026 14:25:34 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 21/24] tests/tcg/mips64/mips64r6: add msa tests
Date: Tue, 29 Sep 2026 21:24:36 +0000
Message-ID: <20260929212439.110454-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX/z46e9Appuue
 EHhG4jeqUS9JoTjYysPN02stuIdl7CJUFLHRgjB65SfHM/IiMnrNmtuYEAXxWlrFQeKECcI+olL
 ED7EA/m6sATYd6TarF9MYpWGJmP72rKEeOnHJbpm7ENhHUL2PYx0eA3LT2IBw8g5kOtKpygb8VU
 ZBzHyjbH7Dnpx5fqEC48kYv+yQPNN3+hSj3tN7LVeEzIAuu7l8/JxXHyYyc5xL/qcpoeBoTmkGa
 GH/MiZC35vwa0kHW02kQ0o/pZzkQWMYcwis4keGMKjDYnrW8De8vdWQfO/MSWC3bgkWjPo1sLd+
 bxuUhgQxYh7ohRModnN005wYNfAnrnfsxZ4ITJq+jqVFAi2oqSPLhtKr5e4scxw8WSoxUTn3lZL
 rYGt0+wVdcSY+HmG1P6RozocM+Tl99UaS7iTolxNhn+Qq2iKsl1a7IcuX785Fuw2aa9MGinpWz2
 kigW+jhnuZZnqP6l8/Q==
X-Proofpoint-ORIG-GUID: RTztMi4beKnbzRATxYCSS09ADnJNbC_e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfXzTvEMUyHQ/Gs
 XQHQV6uVeT2xnC/hINgKdL4fTHWDpGPOtsjidmEMBBAvOhqE0VA+rozs985QwP6BkcCbrV7iis3
 FOfw2+e4oHEQsLXti1bp5soKQpmyk2k=
X-Proofpoint-GUID: RTztMi4beKnbzRATxYCSS09ADnJNbC_e
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abc2cd0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=32VfMAGxpIpQ_FDrn5UA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
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

Those tests are added to mips64r6 and mips64r6el test suites.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 676a47f5c8f..c80a3716f55 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -65,6 +65,15 @@ foreach src: tests_mips64r6
   tests += {src: {'cflags': '-march=mips64r6'}}
 endforeach
 
+foreach src: tests_mips_msa
+  tests += {
+    src: {
+      'cflags': ['-march=mips64r6', '-mmsa'],
+      'qemu_args': ['-cpu', 'I6400'],
+    }
+  }
+endforeach
+
 # export tests for mips64el
 tcg_tests_mips64r6 = tests
 
-- 
2.43.0


