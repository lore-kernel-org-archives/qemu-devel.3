Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED966C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru0-0003aa-To; Mon, 06 Jul 2026 18:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrte-0002t8-8S
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtc-0005dv-MG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEGnw1505078
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=x7Kf9WBlz6F
 a4PhpwoLhlsU4y6ujenxg6BfqQuBWh1M=; b=L0bzRICluDi4UJktGtwXZspBXBf
 9zukfTxvxzGas0aE9U77/E075b4S3G6kG4jUrGyDKyHNRGun7c0GkoX2Td1IKjTD
 0Fu4fLOKlAeL49MCk3g1uVBKFmhL8Tv9rBAXniLYUE3Ug9Nr6dgqeFvkGWEIKLdO
 dF/5RZHuyyac6j2FbOY//yDLAh6ex9i8zYnpsPsp1BMytJYnP37AKu9ztucoSEYn
 biu/kQHI9feXlCJaZWjwtHQ5fzUwooM+68gUOt78xk2QA1nqexnM+5tqjjzbUqlC
 jGMRlzYXDumybCHvJaKXdUdJsmM/I9uQBkYdM5QBtKl89s7OUAVpbilf47g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98k2pw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9151bf6ce7so4001473a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377275; x=1783982075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7Kf9WBlz6Fa4PhpwoLhlsU4y6ujenxg6BfqQuBWh1M=;
 b=Mv055yxTZp/ljebPTjnisXu5RCYVDcToRXeOAgsTI7gdJifIsH3ALWT4LxwJwr6F4m
 nKDuaM6Y832X21uGhP+68H9JC8/5FYPjOuI+gul2aJZOXmo2FHVVjYQTrlQpxLFt/moz
 HBwCFD+Abo0NDvMvmcTv7m5yFz2kMgKwMOsDPSa0wNQsgZRlj6cEitEdvd8CmHouqy1/
 xmJxtUwQyLdb3D740TcdFzWAT2wKjwl0jM3EqNoSPqDzKRgwOZg8nySczGkAWtCSzh/7
 bItS5d68QxMUpLDWv3k3OHZ3RgumicEieHWr00OoU2nrjLl4JcFYtcQ+McsjWOAkwNZx
 kAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377275; x=1783982075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x7Kf9WBlz6Fa4PhpwoLhlsU4y6ujenxg6BfqQuBWh1M=;
 b=PlllgsNlONBEy35eodEoIjeJH58Kfdqk5F+1Ngj39QrtPro1MY5t5uVCTgXPl9gs10
 uBMT+MzJG3P6pbfupP3CyKRPLcStPhDAht5syVrMl0S0YWElYjF1qiPyJcKn/l/WgIML
 IlWPnJXNrkMm0FoFwlEpi3Spt8lHyqalf/XpD5nNY9MP9bQfMgMv3ngsWGYUfNfQ4hw8
 OESBFwgpsQw2Fj1+6GdUeQry4QEtzxmyyy3hzrpYo2PiUiy+okJbagDls8FJQRpdE4zn
 vFNwElB4QVNdgpw0nnzjY5roK2vFTbU2ep5dK8buxul+x8eFDPZsCf6LAik/Aql8gXoi
 Bo7A==
X-Gm-Message-State: AOJu0YzkhoxSRFsau9tU6B55BGX1afSOYDroDZO/L8hPJb6It55hy59l
 avN3nS2T0rlKRD7KazqxuAbKLudC726AT27Cosw+yAMnvJ9gGQX3FJfn3GXD78YwROibnYJ94Jf
 PtmM2+FBp/Tx3Mm4TbE39YWNfOWswgZdI461+TC+VIkPS/76g8MihGlUsRjEfu3I0oQ==
X-Gm-Gg: AfdE7cnMZrloIVSbvF+neOCpTN64BTjBNkV1pZp9bMPTC8cF5Sm/DDLnPd2pXCgpbFP
 eimU9Y9qVCuoFRZ1fclURZCWVZgI+q1t24ddgrip5RMR++m0bBdE6qaxk1qqmyYepr/m80y89Qx
 qE5Q7tOiaVmSWmOTWYTw8iLmAuu7UtwoMxYAOKD229LT6fngNDLYsPbrHRVqabv7RyQzjDTJ33C
 I7V/vt1xsE6ZXm2+Q7sMQJlllYBnBhr9uvbH8grugTfPcuk9CIbYca5RFqMctYQB86MiJi4uv9B
 p4c9wvY6UEImUjV/qXax0+54FARdEOxPWkLctId/f59b4PtbZozN2cMrZaXMkZC6WNGG8Z9ZsTW
 coFQLKyOSuhgjagNY8wsjUKLWRHCmxFBrRbE/e2eBoidPkUi9IPUsY8U98rtcSv6IxsZsXCvy0g
 Fsv8rb8Q==
X-Received: by 2002:a05:6a21:4d92:b0:3b3:f46:1eea with SMTP id
 adf61e73a8af0-3c08ed71955mr3228002637.7.1783377274638; 
 Mon, 06 Jul 2026 15:34:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d92:b0:3b3:f46:1eea with SMTP id
 adf61e73a8af0-3c08ed71955mr3227957637.7.1783377274253; 
 Mon, 06 Jul 2026 15:34:34 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 27/91] tests/docker/docker.py: remove "Image is up to date"
 info
Date: Mon,  6 Jul 2026 15:32:39 -0700
Message-ID: <20260706223343.988769-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c2d7b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Le2pUKrCS2B_8Q0jc7MA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXwLmkd6Deh+wA
 BIhvmH8MGPyOP6DUwQhlil7AHcW681pWqm+743OYfL4SthLlbm27oJAopdUB6M5JafDYYgnkWm+
 hstN7mwTmC7/atRjlsdtWzLhMbw2HhPltWisLx3Ka35aRW6kpjFYoLedO48mvpkwCp7Ec44AA2l
 vmbUGqM+x9PsLvLW8e/MSnL77jy0w4z5hXScUTGQS7looTqjCb/SwL7nys3BZRlj4LFs2O81cWU
 knBP2QAd3NP+GHJNhtwHpRHEf0RrBv2igW9C61L/FdLgtOF7CsM2yWvMagCsdH7ijemx0OB7HHH
 WZAkag7wIfDgj7F7xtOtZjWkTkJqrH7ROTR2qBZS+HeenE06FEzevnXo23dJDIZXAUZgXfxHL0n
 2JxMsS9xE7zWzc00dlVgHEodPMeDh7hHOSUzggIaYUfy6TrWGtyHVA9kSs2Uf1iHgakOLzLExJP
 WZxM3OytnOGrlpkYvcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX2VjXd2JCW1+9
 ygoJHNefb7P5p9fmCGUyei5x+9KhdM2wvVlW/tGJ+/yL1zxcdxFJrlMQGzJU0TI+9v6AMZwS6RM
 VOmt6N4yHFJox2d/TAe7d08Ix6zFPy0=
X-Proofpoint-GUID: JVKKLAXUf4JaxxTLRNQkkGYJtptKwUx_
X-Proofpoint-ORIG-GUID: JVKKLAXUf4JaxxTLRNQkkGYJtptKwUx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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


