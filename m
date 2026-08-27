Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46DBC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziON-00078C-VR; Thu, 27 Aug 2026 18:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOJ-0006qz-40
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOH-0006DI-77
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLnjX235902
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oSRvqgL2uvtBT9ePvRjp7eOopnvLpiDGW089SWdvYdo=; b=Exdx2Rxy4OptPfXH
 hEZdHOppkOZDwrZSgi2UBRTzbDd7yqK3sosj+PLZuwhVZsEwx/el7NUPZwOWp1ZD
 zzjV7tGCwMNNA5zFWhF0RdomAgF4EihYNhvAC8oHD/YJ11e3lMTWE0dnfI6SiJy8
 Ong/o8npMV0Iab40B7ZfBsuaztgycI5zQ23e6aSyWimUjmkUKbBCAfQ+zVnK7htl
 ZSDXjoSk3UzA/kg8cKFEG6Ne/oL3uYnOkfnvwuu5Fzm5r72VjO2mnSMVgV2hZ1VP
 0Y/VKpRMScTlixRQb34/QnIMZ5ssbV1v0eQpVzMGTZ0j5QNl6RxN+BB8Z2GmZmbX
 f3YUcQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgtvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84842381150so472512b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868957; x=1788473757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oSRvqgL2uvtBT9ePvRjp7eOopnvLpiDGW089SWdvYdo=;
 b=N1HOVEUXw4zt5LUAax4jEPopNtKmEFVvIQPYEhKIlfceKo3o0M+5br2gIMuisSMc4E
 blxXOfKVHJTTc+rPSsfztfbrbpaZkKh3u4EzZ2nD2vgtGJRCvagYszGWIa6twrIhC4op
 1neBnqwspiyURFcYZfBA36cHC8UdCtjnSKjxkkHi6uwINW2DqEanIIOqKUQeUXU2PGLq
 cyb2LjvgQqB53rgJyBiK6cDat2WhxjsByUzQxC8RWgzlbSdbDgEF5IdIfek9ErOPF3Z1
 YmUFm4jNK+YziRb6tYOZLPn32uRA5lak6QlCOVclp8gbsFjv7aExyoWulpP1zEGuVcn6
 nwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868957; x=1788473757;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oSRvqgL2uvtBT9ePvRjp7eOopnvLpiDGW089SWdvYdo=;
 b=e/GGZ4cDhR+CzLwnkJrSO19WxlkZvAD6V+v9ZcU6QrdHkEUOiFGfnLiG9BDnj+tIFo
 rx9RtInULKlosgVM6RWs+NRgB4ep6ESHvfBkHWfwspEnxHk4+JEQshYfAs3vfxIWaj08
 q5BMICBBqn9YxFNeTtSLoCEPQvJwITKvMnMwz4e/+zz0Bqf2NX17PgkjJtYiMcl6xmuc
 bK7nOPJvRTFtL2S93swTQbXjEWA21QrR/GWLlV5b9UbuGW9Y3R8I20CUafCOHoS0eHiB
 UZLVTIzyPssumojQjowPLsDvqubFDf0AhXUu/pjUD3ceaHBfj2Xp9ZfUpKpt9W45egh3
 D8cQ==
X-Gm-Message-State: AFuF++nFN6MPvODVndrwvNJlEjJs8n64c9juxFJEe+bX4XsurXPbjm/b
 zLpb507mrsUjei0lxF9oVnIo2Qg4JxRFlGsfMdNhVPqFWwbndMjYP31pEXNzFLohwfvFt8l8wiS
 eoC9NOFSBe9QIbXlC/599ZqkYYQIX0lTZuGLw43eM5LEkz/TxcWPLKXE48zHDqxw/5g==
X-Gm-Gg: AR+sD12DtpFfpETQb/TzzFhGxGNmDThFuMyCrFk2pVhXo25eTn01ZQ3+4+A5wR4rUs6
 MXsvgWrqgGHF+jEBA4utlYAYFfaCauXHxVEJ0Z6e8pq+3mGMqbGUVCrgNedIvnzHB1MpgysVS+s
 LhIiyqTkfAtx4K53dsS4NAmA+mi86ncf5j33FObuLN5kzomu086UOMkY55QmBkgaYe/GgdfZAeS
 KagClY2slCfXSU/qc50/wkNw9BC3JPMQX8qivXtR0VR+Z+eU5Vd8Zncybk2giFtifbjH2dGVXjG
 Qt68nmZZMOs+e67L29xpVytW2/L3WmVLVfpyZNlcTEJo5fmUhOn07r0eIwptOuBgdi9/MOZAWVR
 d6uXjE3NSnJnxw6RJenz604WevqkUkmXYOiWMe5EWbzvxujU8F6OG3ZmIyg4=
X-Received: by 2002:a05:6a00:1da4:b0:847:973b:3cf6 with SMTP id
 d2e1a72fcca58-85625541a6emr4917156b3a.0.1787868957141; 
 Thu, 27 Aug 2026 15:15:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:1da4:b0:847:973b:3cf6 with SMTP id
 d2e1a72fcca58-85625541a6emr4917064b3a.0.1787868956704; 
 Thu, 27 Aug 2026 15:15:56 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 038/105] tests/tcg/meson.build: add generic plugin tests
Date: Thu, 27 Aug 2026 22:13:59 +0000
Message-ID: <20260827221506.91574-39-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: COEI2UBKrIPy29g-V34pGlbc6rhK9xzS
X-Proofpoint-ORIG-GUID: COEI2UBKrIPy29g-V34pGlbc6rhK9xzS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwBQBBwixkt5P
 AKzAwE2QdV2yslU/e2098EvtxaWsqs+BoiCqHbGaryGfC9dZwCzlno78pLKngPpnLNrAhWPXofz
 SYyGbMyeaPX/BPozBIBim02fkc4OFjrqfFibNEbHaeLK2hWZjrfOlCwdjfvt4U0eb+RY2qs6aIW
 CNadG3RytWhRRFRs1p0mSAKhMSFvCKPCDYqxmDBRASXzO2c3TYxgISEHSP0NVOh2NmnQJD5bqbJ
 ymdl8TrAVP9qa+AdFQQ9Uo8tOZfL6+mAGr1ukJDXnUjKQCLYiXuuuiTOrrpv0qrLklEVd84UoXC
 aIX1/cmFjyWz/zR9BaAEomJh8EP1NrEre4/CEZ/bDMkyNUoCiOPq96vz8rkEDwRAtQsxfwW4NyS
 rhGu0vbj5yMNGpk1FkoCMWFsTnk9pWSMCerLfJDsEE1klriHyIWLicwoNZgRLdUEwmvEblGUcdA
 NltRSWmCM6TPJ+tAhhw==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b71d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=20YfESkggsZWOKr5SEMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX32+rzhbdMkpS
 6oCVBiirbcmFLBRPl1O/8cRqJnvYJIDnNiBK1CFWA93bDUQ9xELmBPsyEZG4FfehcLin78Taj8W
 VVtqRt4cXFHrvGTiHOGuqGh1PtHYD8k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

We add one test for each plugin by picking a different user and system
multiarch test.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 536def60b44..16292d4d7b0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -90,6 +90,51 @@ subdir('plugins')
 # multiarch comes second, so it can be referenced by other arch after
 subdir('multiarch')
 
+# Generic Plugin tests
+# add a single test for each plugin in user/system multiarch set
+plugin_tests_exclude = ['patch']
+foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
+  plugin_tests = []
+  tests = tcg_tests[target]['tests']
+  normal_tests = []
+
+  # filter tests that are not plugin or gdb tests
+  foreach t: tests
+    foreach src, setup: t
+      if 'plugin_test' in setup or 'gdb_test' in setup
+        continue
+      endif
+      normal_tests += {src: setup}
+    endforeach
+  endforeach
+
+  idx = 0
+  foreach plugin_name, _: test_plugins
+    if plugin_name in plugin_tests_exclude
+      continue
+    endif
+
+    # pick one different test for each plugin
+    foreach src, setup: normal_tests[idx % normal_tests.length()]
+      # copy existing setup and remove existing cflags
+      new_setup = {}
+      foreach key, val: setup
+        if key == 'cflags'
+          continue
+        endif
+        new_setup += {key: val}
+      endforeach
+      new_setup += {'plugin_test': {'plugin': plugin_name}}
+      plugin_tests += {src: new_setup}
+    endforeach
+
+    idx += 1
+  endforeach
+
+  # replace list of tests with old and new ones
+  tcg_tests += {target: {'tests': tests + plugin_tests}}
+endforeach
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.43.0


