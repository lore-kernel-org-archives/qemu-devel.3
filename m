Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD15C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZf3-0004Mv-0r; Tue, 28 Jul 2026 00:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZet-0004Ky-VT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZes-0001R0-Cx
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ak8k1673396
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +p2lVbeMsthflMXIZbMTGvzqk+OnL4gslwFpdsGG3zk=; b=fDjcA6xmsnRIgEGv
 SUq6ikbZwR16NLsA28UAtT3esb3/SZEvrwyLrGhPzZjMG5G2Xsm2ui9IzPQRG7Fx
 Ca2gdr9lBdfSMyGcgYBNdurp5WC3MiZf31Lvz5zKwvUbXpDk5qkNNwudkWcEekQT
 VUqqYOnVIron5/srXK/05225QWG0DOw/unrho+QAKnHcziRe04XRSy9xJNPeZguZ
 YOQ0SHB15YtTcjU2MhTKRE/t4DxVcpwvYfx6jmnCrG4TbI+rMcLWXtZQokkx/+qV
 r60TeyZcZIJgN2EZt0BTBjZu/XkfIJQwKbakZ4YfqISQ8NDy6IWP4ctvVH6waf2p
 f5gjoA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrstbum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7b87ce77so8342764a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213792; x=1785818592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+p2lVbeMsthflMXIZbMTGvzqk+OnL4gslwFpdsGG3zk=;
 b=UDG5WdJz74RT/94IEvc0CLw3u1CkiSCpL4zq8p+q5OGmT6QCOKWKX2Jnf4m9dkA81S
 rHLGAWtdisR0cMjvv+DeoxU2+kX8xSTlw3anX+3c19IOti026+xEQZ3RUNNQzmF1/JUT
 1qHhbY9xWdJuZksTVylYHrpYU81AErFPR4G61I5GGZQoibOOEAnxtIR60F2XzD8QB+LP
 HC2iGdYGmaOPmKXX3pDF3IGqRLsLYzhBLlhK5OJxicHCaMD8GARBb3vRro8yJq11NOaf
 SaOVkYOlmuHxTVJadskfZIcqjiwb0lFauQ8XvgWPUBMSBWSdvyoj01ub7RjnOerDMkO5
 3obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213792; x=1785818592;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+p2lVbeMsthflMXIZbMTGvzqk+OnL4gslwFpdsGG3zk=;
 b=fVFBS/mW6iiWMkBld6y2y/hAeNG3VpZODaGoYze8Cdt+0Rj3FO0Q0GhyNFTCxrh6wt
 1hz3Gc9dSIvkXo+OxzOKr0U/vw/mtx29/j4hQjns35ruWK0uhuag0JepDfUsbSoYhYFk
 P8sKj4wcKC4cJhAT/YjEX4Mg/apukmVL/0oYplDk9zhYPIFzZ+COO65MVlm3M85Y8Tr0
 msZgi8Oky2sRArbiT/IJoZnMySP6LexaCYNn180LvJsaoXVNculvrm9yD9Xsr45VKKtH
 DFcIzxL1n1qSzOIwkY9AyS6xjkQxLOknVUQ9fp82OMFxqIFDqySLN0aJXS6r7L3lq//7
 ietg==
X-Gm-Message-State: AOJu0Yz5jKuS0mdcQ6Vwp0+WVcQUfsamJ2dCEHK01U+FZPNi/AJ4c8XH
 HpbZbc8woAXA+Rh6UVunYaRRmAK41kMLp+ltVHF1hjxtE+bVDxBeWXnlV5SmSw0uaf+W8hIpAQ4
 q6268rNHvsHsLsjGVkkiwGcrRewP/QKGLOsLqzcIU9faEGB5CG9yOjw+S48SIdzeffQ==
X-Gm-Gg: AR+sD12xsa0kVyTbPFTu1DEYMS4oKarSf40k6sxu+eH/bgZ6TdQq/lLm6kbVNE8CHm2
 NTGvULcS/ornfvT2hWxD3XviYP498CKQ20nlM/zQFaq64Ioq8LllqQV3qMGdQfXB/AuUNjvfmPg
 544lWZTq+H0jfNSAEMvrISyjkP8HsjGJkzOchnsVlK8H6sLhz+lmYojJW6cAx2/JWlQVzgzF+xy
 HlGoV44CbN9NHDswdMmJfeTgQnZPTiBKAYojdRlDsZe/IQ8UTywJyKjHvyx4myTb93Jt2eZf8Fd
 kZ++v+TpfbyBV62ZYIsRi3g0GSeCYKRahDPXslHve7JAAjFVtLLIopb/FIqVktX079ztwRJjNBk
 IX9ChzQ1BNR9vv+wNz3ElPn386lacUwsF1PlehnYZDYw6hP4eSBcP/ia3sASwCUstAC6RFL8=
X-Received: by 2002:a05:6a20:d805:b0:3c3:89ce:b5bc with SMTP id
 adf61e73a8af0-3c8aafbd493mr1150257637.15.1785213792360; 
 Mon, 27 Jul 2026 21:43:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:d805:b0:3c3:89ce:b5bc with SMTP id
 adf61e73a8af0-3c8aafbd493mr1150228637.15.1785213791913; 
 Mon, 27 Jul 2026 21:43:11 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:11 -0700 (PDT)
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
Subject: [PATCH v6 006/103] tests/tcg/meson.build: introduce exe_name
Date: Mon, 27 Jul 2026 21:41:10 -0700
Message-ID: <20260728044248.137626-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX5oWqV+JfLHr/
 WS6vO5esB7qQLqdAY2EundvuLyKy3chvx7qVIDfMpVSQV8V0UiJ1Kytsh/UFWa+TBB/ldon/JL7
 XMPIaXVBxg3oV/lw5EGeX4GLD4xDvRdsnCdBn8NavnXMs0MPGOBeid/P4Gh3fF+i6oTAM+Jv3GY
 MqZ5zvBLSv0MBImPRXGjiUyPa147XtNn9/YAF8S96lZl4znMR3m2twdDpoZsRFL1U4wnMVjMiP9
 IQ4hlkdudgRP++jZ9WKzxpQLApoyPxdlRqNioqTcHy1ksa6Nbg096EcFUp781FjFoC7Be+6OsBW
 ktL4KOudklGQ2RTXfKyoUa73UwCshbNi6DLuV2F5aNUccGEXMAsNVRxutxFy3+K9kSZKGVNOqTw
 5AMX+UUh1LyT7QEJrLQPdXmKDO+T7D69Op6sluEDqdsZebMQykz58tjC6IvZwYBY6wrf83UWYCq
 L3oVHG1KjK5fmE6nNKw==
X-Proofpoint-ORIG-GUID: 9fEQ3iaE0N9lho0y5S4wuhZnwdpL6PGR
X-Proofpoint-GUID: 9fEQ3iaE0N9lho0y5S4wuhZnwdpL6PGR
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a683361 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXxgdmk1hzf4ys
 fFWjdP4M8+IRzbTT0zeQ04L+H3zhUJ8J3ZfR0w0r6CLjNqyKCz2odybdgoKyq6yGIq30TlPnrvI
 fXR8PIi/3zRMdwAjXS9ZdtwmvEPZsxQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5758c7cc0b7..697b826a382 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -49,10 +50,22 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user misspell a setup entry
+      foreach key, _ : setup
+        allowed = ['exe_name']
+        if key not in allowed
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src +
+                ' (possible: [' + ', '.join(allowed) + '])')
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.47.3


