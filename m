Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB4EC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxZ-0000vD-Jg; Mon, 06 Jul 2026 18:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxY-0000qn-Im
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxW-0006u6-QF
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDpBS1628655
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xjUQOZ6sk70
 QIWz8KIyo7Yry2gumjVuUO4aAhS4bGsM=; b=EB6UIILlnL5QjypxreGtSlAKDGD
 CQ7Rvd4Dpfgc+Vrgnap9CTOCkkjFQf8nohbIqVh8zmRGC65Ya2MgiXxxHtzeFQlA
 FbGpQrcDGjV9mGDfHhnjY9mf4OJ+NL144LsZw6M9PJXXJa9t8EUzecRG9H3KoYL3
 Yid2yoZc0JjBcbQnA5D65PkeLD8R3mFxwqff0sMztb1hZH4NEsHPluHl9Cqul+Gh
 44gSNF34IOtYInkUu+z0/4Up+rCU8mGYOCD+1mZU+SR2CHtP7ALRYp8EgRZtpLMe
 CiAPuY/gIKyH/4xJo2CFF23S3kIzXpMXf7wm5gBFXGiX2Z2Bs26p3rczOkQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw1hyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c860544c077so9738447a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377517; x=1783982317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xjUQOZ6sk70QIWz8KIyo7Yry2gumjVuUO4aAhS4bGsM=;
 b=Wd0qVK0abwT09WiF4B50jUkghRfNcri5Itl4JhKDycvI6E0lxmFzG7VAdJAjI98Bfw
 +5LKI1F4mOwp5sOe3DpwH134adseSSF9P747QBawaF5dFL+1Ogc0MdFAs5EOshnOT5ae
 q7yKV221I/0qO0cEjdSnUpCrvJyKHCwKk96CNyb9gm4ycMh9Ad4COQHmQVhnEjaKRkR8
 DMR5UIAzwJOyNsOYWIwh3uI62De8NLx8b2eI6oPX7gTHazd41toxS4IGdbGQawWv5uZw
 lTDbTn8njtbYJU86VsqSMxSyTahistR3rUuuGPzr4/rKQMVu5uoAD9n/b+1t1esLI7/t
 50kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377517; x=1783982317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xjUQOZ6sk70QIWz8KIyo7Yry2gumjVuUO4aAhS4bGsM=;
 b=CuEL4V2QdfwAVvlZhyZk18TywGzorKn9fgwp23MNueuXINckqNcuDDXErVjKg2F1zZ
 AnzSxqopAlSVmTJxxrzbJ/pMI4sFopKNsz6WJp6EdwrZ3dKfoiPPe3+dKUwHguwY47OC
 9zk4g3P4ukIQyd2shzsmEb22hzG0wbqSHHkb6yZYUbRRDZJEipvAvx3f7g8sYwA+pcG4
 7d00wzDOhPeQ20/OQQ5aYivCIqGHe1K2bn3zR37zwinHO6wnzJesc0THC2Usy61Omv6Y
 3ucO/rBoOcEiO2Br3OPVEHK6UFY605pU9Kv64zBJQkQbO6Fb7akcmbenxUyNk6i14RfL
 tirw==
X-Gm-Message-State: AOJu0YxLtlhi56HJ21rQ/rhrV8L42Gi72da76OJ71+HjKf1ZaMpZt/rD
 80jt8HXnWGmg6JWQXWkhtwGkr1rcE17F0Vd3eJal2lh9VytFUPFYaPs29XXhg4fMpHdDnXxqoco
 2Bs9Es8M430wrdNj7PXaKvls1iIMXxpvWkX5As9LtcehdJFUarHAsrFOpZRQJf7NZrw==
X-Gm-Gg: AfdE7cna+oYcJmEskmkNkjxiMLgwVyGDhflqJxpctlhuiFRqfxgdBk3gK1SQv9OKX7z
 CWd6JRp7aIMXzWd/UVyKYxiBtgwkCZuze0LDkW3e+7JbsRb+ZvDyN0lPcb88xYEouI1a0ShAHyV
 aEqoCZF71SLmIo3VDSJQwKrkMiQF/L8XThuFY7yPLE5so1E8TgfVXFnKmy0vWRhjGH2xx8/LWFu
 fN8Za43tJwxkS/AOlVVjMYY5iylW3WgWTFMZM/pyz0el4FG4bqu8DFTAxrYV1ksjrXuFtRJc/wl
 1Q7p4hRKQ275zulxVL7nNwWjWdj14jhvRcn0+7v03KwOLwE1EhGzuLkd0ek+/5g2K4p+eDGOh0i
 MNnzIsxh2TEf+5/jgjEbVJGm83DHUcY25YacAkQten4OlXyBKHHAMeDhiCmXYFHwBn/0ncKdmCX
 gUCTTBAQ==
X-Received: by 2002:a05:6a20:a120:b0:3b4:65d3:17b1 with SMTP id
 adf61e73a8af0-3c08eeb37c8mr2940052637.43.1783377516620; 
 Mon, 06 Jul 2026 15:38:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:a120:b0:3b4:65d3:17b1 with SMTP id
 adf61e73a8af0-3c08eeb37c8mr2940025637.43.1783377516215; 
 Mon, 06 Jul 2026 15:38:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:35 -0700 (PDT)
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
Subject: [PATCH v3 57/91] test/tcg/mips: user tests
Date: Mon,  6 Jul 2026 15:33:09 -0700
Message-ID: <20260706223343.988769-58-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX0CqkxLaBJRmy
 bqN8BDjzEWkK0U13l5RbZ38AASC8JWEKKpSIg1znw7UqWUjTGwx+9znMe0R1AJyqToeSiokXCdi
 UxVcCNSms7G8HO4x3PihfO+HpKZwYcU=
X-Proofpoint-ORIG-GUID: DpwQitelFrLx0nF7V4JhqVmvaBC2jJCm
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4c2e6d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=0mQg0yVBovIz44vvuiEA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX7riyQsqjgjpW
 AGeBhAeDL6NC1S5D9+pk2xVRwT4SkERzBHsdBq6a/8kKDHkZUnGwDsB+7iwF20qi+2GRA5y/ka7
 +bATezalVw3nI5GvnqSwMsZNQf8ZJGCA+YsUR/lw5wFRo9fM+iSvJWfq6sm38YRj+3GehWLRziV
 i3y9OnfOo/hTMGoTXTEIrS0WBdTJLyy1H8WrU9OkBuiB3O1L2XGL/D75Q5/0kEbZsHRiNaLXBCH
 pY/ygTYkEGuKSYk11DJvi4ZrLM5jOqfR16r6P4ogRCeMG449zhJrgPe33jDRGLwT7sWEJS9NIa8
 XSmy2SjmwP6jipibSmlyiEdH6SDsMAgB2Q89SUn6K13DJkNZxvvGX4uanmKQCCYrW3qfg1CRZRw
 asVv6gnYAY3gVT/RlQx070EMIMAUghOpWS0NV6QUOFe3WFzSeldiGpPJBLrNdbdgT3XIkrE/uFq
 By3iXuY5fGDnt223MAA==
X-Proofpoint-GUID: DpwQitelFrLx0nF7V4JhqVmvaBC2jJCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build      |  1 +
 tests/tcg/mips/meson.build | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tests/tcg/mips/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a6bc12922cc..72ad2690f93 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -143,6 +143,7 @@ subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
+subdir('mips')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
new file mode 100644
index 00000000000..1b3f19a6153
--- /dev/null
+++ b/tests/tcg/mips/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'hello-mips.c': {
+    'cflags': ['-mno-abicalls', '-fno-PIC', '-fno-stack-protector', '-mabi=32',
+               '-nostdlib']
+  }
+}
+
+if 'qemu-mips' in emulators
+  tcg_tests += {
+    'mips-linux-user': {
+      'cc': 'mips-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips',
+      'gdb_arch': 'mips',
+      'qemu': emulators['qemu-mips'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


