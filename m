Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76D9C43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9g-00041c-5Y; Fri, 26 Jun 2026 19:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9e-0003xj-Dq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9c-00047l-99
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMx76f2746411
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Noka+og8zJN
 wUY5v3/FSoT5jF3JX7q42Y3xnrhoRRLE=; b=I1+iZZph3BlnY4WTBBLjOO+EbBs
 CHcmFZ95DK4aZFOdXI0unyebDEH+GuwerBKUilUnTjEcewewXwyhpO3Wl5RkR12Q
 KshNxPsgTw+cH06t9EAALcHkfz2OYl/oL4Xyyi2Hi8PIhMqd9NxzUD4GKf1vGcYY
 wLcWjGOIQM0ZljQMKSowypNEMdMF/cyDG1Q8zl+ZE5Wcw9wfNrNFSkUAU0T4t9XE
 oR48+r90Yjddo6Zr9zpQPoX4xegq1+pWpiXEmCkRqLx396H2Oy4+X/NeZo1Eiag4
 HYWnxYXNvhc01MDYRWebxn8R5hRoHFxyJ/O4Fiqo4soBg5VnDLQzJ5erK3A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1yqv0myd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c8722a4easo2383059eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517200; x=1783122000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Noka+og8zJNwUY5v3/FSoT5jF3JX7q42Y3xnrhoRRLE=;
 b=avnomCU7EXB+iUCNOLhQ/Wxir4TdYdvua9KUUBGbvl4WVSaGlUIsl0VZxmspo6oQiL
 e5xTGHYx6hP+91bFvwnQNYkv8kGD7tDQ3PguhQc04TQNFGOo/VK7yc8taCz9VQhY2y0E
 HuhQy7HaFPevkBLuT8XwxA5H9Ycu06DzEIol7We1BwnCvx5AQz5SCFJXzeTXcu2fVEhY
 hnCSvyxYgfW8PIF26dN5Solsbdu7zo0ajZP1QMeS2bu2GdD5OgPj8ZXN+pqUMX3svcJl
 yjoaj+kDmc8nin/5swyL5S3sFiq6lR3CorySUbMXqCr0OR9z75IHrm+JuhKHIGRcpocQ
 OrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517200; x=1783122000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Noka+og8zJNwUY5v3/FSoT5jF3JX7q42Y3xnrhoRRLE=;
 b=U/roRjwjqqIkMqWKg1ddRdQ2xrIHI19bLGO4Bq+8Ri47Fs6ewIkRczElNv1Wzl3U+K
 kOTngmgoiViiq+UWEqdoTlshRApegTSyS02W/vha3Okka0dzYydEbcWBJ8r1n3ER6q86
 VFBggb9WGqus4vUPvDm6KM019peTLNCxmDWymGPfEQxhAszgC7saWyy9e+x6Z7Gnwc2k
 R2aRiuHgDmsrwImzucc2Eb5xXf2oDGMo7iMX4DDTm6zh7vuuF62OfPGB2XWIk1ZoFtPu
 qeYHcAJg1nl+IAwbvXWdKe4nnRWJkKFLTanQma82T4b00lVq5tSa/zltmTyzOAw9Qvor
 fxBA==
X-Gm-Message-State: AOJu0YzG3lnJ8ZgSkzDUjj+j/+KCek2MRtw8TY+jkOxtdlirH3X+kAps
 RBsfXSXq6+d/1Y/HYK39mownUlsd+QbIz78R32JuMYZt9Yf+D83ux408QEK/Q7diD8QO+HvUWhX
 gL/Pq+cMAzcReMhZAHOnTzEBwEsauaUEuccXOJa+g8Z0+ppWCnaDD9ANsU6AZGkg1qQ==
X-Gm-Gg: AfdE7cmhG8GbYwhzfCDhcpJHHA0kIIPkucS62ZrFhby7hZWRcVTquJov/2vZdi8i77k
 /QPBjXDHotW3BQk+WWfo2Qg0nbNFSF7+l7V1L9G0tlztwIlf2icUceHRw767L0vjZGxFMvpS9fg
 Zz5r8P3hRmkqwk6ywWN4SIM7Bg581ZdrtQP3kdmZG+7nSjk3v44TyR2rkhRUTXNKAIuu5PaWXUq
 j4IO2otmk2kEjmhF1SKYQmpK0W5/ExfLvbdm4pTyGPScUixuc5mPt2N5a8zVCloe9ExsoQBUkZg
 F3Zjhkxmx1eIgXG4uopsfQ2q+dTestJ5/I5SdyW1CebwuoMUMs5gwvHdE7+QdoYwT6KUBH024+T
 06kdQHf4gvSFJ9qtehAWTc2mtThzmdT/THERY4omTfyY6zHvxSndI9Btw1jp9P8m+48sMZ0aRhn
 lFScXogw==
X-Received: by 2002:a05:7300:3256:b0:304:997c:d4b6 with SMTP id
 5a478bee46e88-30c84eba0d2mr8804410eec.17.1782517200184; 
 Fri, 26 Jun 2026 16:40:00 -0700 (PDT)
X-Received: by 2002:a05:7300:3256:b0:304:997c:d4b6 with SMTP id
 5a478bee46e88-30c84eba0d2mr8804383eec.17.1782517199704; 
 Fri, 26 Jun 2026 16:39:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 26/37] tests/tcg/aarch64: add multiarch system tests
Date: Fri, 26 Jun 2026 16:39:07 -0700
Message-ID: <20260626233918.158740-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aoiCzyZV c=1 sm=1 tr=0 ts=6a3f0dd1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=nM4Zb_-IiONNN0rUaVkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: tv-xorkGxTAZ_IdeGiDWR0-I50sXiL83
X-Proofpoint-ORIG-GUID: tv-xorkGxTAZ_IdeGiDWR0-I50sXiL83
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX3lpGV9d5ITtV
 nPDFflD+y+sD6DQYlqJjrLrjjJO7d6u5KcA0TRl4x4oVty6swDhR34/Xl4RW82IdqGkP2kN2aHT
 rRpFio62sFNuL9yqAuLDyyu7xP7cb0M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX4J6bvv82dRIN
 QbfnikRhZYBVR298C82nJpV00myJ/4GFSetawvqFHQNynwhE2nloyUul1HxkRjlt/QC6bTUapW/
 ZQ83WIAAqkWQ9ohmbsPOLXVqQeAcoKE5UHkQ/1wTjBxW58tGFB8L7X+XrPF5iSQ2+eoKxTQRSkT
 TM1NYERAcXvMwLWbflwrz4W48WoFJr50fhjmQq/70h8Io8MiXZFNUbwhVBMbtuDIcU2sgHkLpag
 wbJGgYGwlRnjSBGLpu2Fh6feOcaaFexr/pBcgkxdCbRXuuX3ZaW2H1hbdt36Qz6VyzBHQGh/KNe
 DF0mKND7F6drO80AwnqEFSYK+cB5AfbHmTgAaxtXux0MqOjeKDOA1A6NYRsFk7HAXiDH/19zkQR
 CYqqjojLxDUCtEOiCxYNP+W1C5YzSW1AX00jUEGVXUUt2qtv/9x/h7bExHvw+FDETIj0g6gGljS
 vhSVkJm7hDzGxWnzy2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
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

We can now add multiarch system tests. Because of our policy to not
repeat cflags, we must make sure we only add those once per executable.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/system/meson.build | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index a1edf1b8442..2a613cca52d 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -17,6 +17,32 @@ qemu_base_args = ['-display', 'none',
                   '-kernel']
 qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
 
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if cc_has_feat['sve']
+  tests += {
+    '../../multiarch/system/memory.c': {
+      'exe_name': 'memory-sve',
+      'cflags': [cflags, feat_cflags['sve'], '-DCHECK_UNALIGNED=1', '-O3'],
+      'qemu_args': qemu_def_args,
+    },
+  }
+endif
+
 tests += {
   'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
   'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
@@ -30,6 +56,11 @@ tests += {
                   qemu_def_args],
     'wrapper': [prog_run_with_input, 'X']
   },
+  '../../multiarch/system/memory.c': {
+    'test_name': 'memory-record-replay',
+    'qemu_args': qemu_def_args,
+    'wrapper': [prog_record_replay],
+  },
   'vtimer.c': {
     'cflags': cflags,
     'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
-- 
2.47.3


