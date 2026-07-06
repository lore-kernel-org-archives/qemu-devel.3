Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A301C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxC-0006T0-O8; Mon, 06 Jul 2026 18:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxA-0006JN-UL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrx8-0006nm-UT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KF2Jn1642034
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KghVSmw/DhX
 roOlsMlkdjKdHs+Iir+2R2tykyoaZljg=; b=MJ5qA9MveP5A18KGOLp4O2/kiF9
 gYKAaLdhFcxKlhDaStEj8OpowSo3TYFJ8itrNm5IMtwdWy6vA1G3WpB8WuTuTCjj
 YWXBHXVoF5KfAoeY6Jr3foHd1um0J/eeq53X+fh4uCUUFwZYdHrJT1WmMeQiwlRm
 IThma/5XnHoDBifexarbm7SgrUbMDsvF/gIBdfqs+Uh7lb+EVCyKZMW3TnOHYVcO
 1W/ZpN41QX0+nfejVcHKfiiXSW5CpAx6Rdezln1NKVOTpFF0EbrjVAGdW46ZbLWf
 lxYZ+rmqrwE3+ULFcwWTH17jdF6doKBbxtJllOo5DXhPfufHEQRMYZ3VuOg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r357e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc86a9ef97so39011855ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377493; x=1783982293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KghVSmw/DhXroOlsMlkdjKdHs+Iir+2R2tykyoaZljg=;
 b=KkJF+FTvr9XDUFL7Cu7qQOdnKJ2pF8rAUqoyMQigwGbq/Ko3v0FKb6PvMMHQxO+qE3
 cOzdJxk6ItQzVXuyzwGk3gehpw9EIEc0Mtv7Vjz+je759mC64IOqzGBrw1PZwszVdFkF
 FNL4VkAfFpMudJXw9/WjbOL1jdrOL2/SxTsvGg3TUVM7i/6EYKQeq1ZeP0aKFABKGGVk
 RcQk+jEsBHjM5FvyDONKUCSo0V82LG7uPoDI/9oRxLUXXNbghCs4o2OObOJMC6HX5ygx
 yR43minPJhcsVJbiDaApGVs1T5AA5PNkmGUpmOxQzV9RjL3WPy1Po9ek6iCwMo5gRxzY
 5E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377493; x=1783982293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KghVSmw/DhXroOlsMlkdjKdHs+Iir+2R2tykyoaZljg=;
 b=TpQ2lE1ut6pSvGbBM7H7VbN6twSZGf5sosEHtFjcJj4DkxabXlV8JL/eTHW+3whVRj
 QWdua27h1oSPe6mryeQEpMRMrOCjTNoIaRGaIWI8Y96n1iAXTMPBPeeZv+v9aSYaJKfH
 8hqyQe9Gl5e2oysQ5OzNBurwPfvFBWbKj3wv/A7HqP8VaMmriqgJPn2mHW0P8xlSN85c
 rASQGsKSyjNRTwnCAz4SPbAYWN+CdOtdgmoffa/iKN3VlAF9GNHKpBcSFBfdfvyjdUT/
 zv2fDDSukJ7hQ9SBbKAq9E2eDB3vIu089J4dqbEyKD1GLuf42VcJxWvHCykVS72a822C
 oGjA==
X-Gm-Message-State: AOJu0YxRO1T3+w6TbzYxpZQX7pkHy19YU9vZsO0fEi2n6gZzP9gIxIxn
 etX747DWRXd1SxQV9teXpkR+qW3/PvKbgMYgebAduqInp4meQ6wqgeO+KpjREBE4VNq2YP3gyHh
 eUCmQhpzNNfWaaV7sq0+/CKzEuSdP/wLFqUZqcu5JHzhwWHIeeJI3li0rYPxulnjqKw==
X-Gm-Gg: AfdE7cmfu6tu8uTOFe9esERxU+2BbfkTWeVHbtwLQwG1M+fBgrX4CnV81yM5imblFQB
 la6RqN8zF9E/0/09M2jP/yL7Z6iEpMVbP5pH1CJUkuTLc2vR9LdzfZIAGvvdFe0GEkW26cbkDRC
 bKLk2X3Knx/EetQW4PWbYn42pOXN0tPb2mQay3Ld2+ZvcTFIzjlEMNTPbGKbsmYO97Bt0qIu8Sp
 Zx28zlY387Y2UpvUOe9U/zHx8GEBHh0WuuRSg5KzEp+shbgDBN/mv52ezX1TTsU/7v+vFkA/qLb
 ipQEnW6x3XGL4epOneaTnOF4G787E2Kgx+HN7Kb8uWbBEPfBuvz6ZagV9wuyZATM8DILGu3mJMI
 uOhLbaH7qwpwiRCP4lqSEt9GRB1rvHq3NFZp3af+7bgdgsYNoqqVzdEbiX7GVB5e6UurulOHkwy
 Ve+Ug/yA==
X-Received: by 2002:a05:6a21:4e0b:b0:3b2:b1f8:c745 with SMTP id
 adf61e73a8af0-3c08edbd890mr2829084637.20.1783377492977; 
 Mon, 06 Jul 2026 15:38:12 -0700 (PDT)
X-Received: by 2002:a05:6a21:4e0b:b0:3b2:b1f8:c745 with SMTP id
 adf61e73a8af0-3c08edbd890mr2829054637.20.1783377492483; 
 Mon, 06 Jul 2026 15:38:12 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:12 -0700 (PDT)
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
Subject: [PATCH v3 44/91] tests/tcg/hexagon: user tests
Date: Mon,  6 Jul 2026 15:32:56 -0700
Message-ID: <20260706223343.988769-45-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX4MimiYQzYCT4
 O5lHRfr6955W9U5Cy1uabadzHWecBsHYNKCnGY+drEh5JWBiQYtcuabIAp7skhXUPI36yr12B9t
 bVhPnmYSUNnc9Yxi0RC2yy1uHULMx/VhaLKing0ZWFibXy3UOxreTo+6NriMnDn7YgQ21MalxiV
 qzJXY/X8PBP9knshJCBugxzGu8TVeFsmcOEC+iVoc+lspcf35mUHFw6G4xN8ms0w9PG8oCV9x6y
 Kkzvqvt98iRcuKZKj/bLLcMoKHLEvzi9yD44XGZgLSQ1ltRvkCw5g/W5dfEqyfe14J0GRjAe9J5
 Fd0vvwrdhZxtdlQbt51I5vwprZkSL/ZqO4DctOJwHHvIlE93S4Ov7oGtY8BEqPLIO/fvHmqpsuu
 LlH6pCSGYVBHLTgm0dUZ8EzZKp/azkoagxBlLSWR+sC8x1xDW966VXhtWpi8TsTaFNeJSlUHdf4
 EaOyFyOKJnKEprmWb2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX/QHU1ej56zji
 u+Y5XL1PUvKfVehnch81ck6EH9OcIa6NkWpQOS9RJxh1KICrFYTfR+OR2qyBxq5IlUdBPh6ATkm
 fhyNpUN2m1OXG6uiYoS9qDyrizjOIyE=
X-Proofpoint-GUID: Lnj-AxGf9phuMpiwy_RtQOBtr-41vwsq
X-Proofpoint-ORIG-GUID: Lnj-AxGf9phuMpiwy_RtQOBtr-41vwsq
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2e56 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=_iHZ7MywaTSflSyKFasA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hexagon/meson.build | 111 ++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build         |   1 +
 2 files changed, 112 insertions(+)
 create mode 100644 tests/tcg/hexagon/meson.build

diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
new file mode 100644
index 00000000000..c2266aeb55a
--- /dev/null
+++ b/tests/tcg/hexagon/meson.build
@@ -0,0 +1,111 @@
+tests = []
+
+cflags = ['-Wno-incompatible-pointer-types', '-Wno-undefined-internal',
+          '-fno-unroll-loops', '-fno-stack-protector']
+asmflags = [cflags, '-nostdlib', '-mv67', files('crt.S')]
+
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    if 'gdb_test' in setup
+      # gdb does not support hexagon, ignore test
+      continue
+    endif
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags += setup['cflags']
+    endif
+    new_cflags += cflags
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'atomics.c': {'cflags': cflags},
+  'brev.c': {'cflags': cflags},
+  # Compile for v66 so that the ELF selects a v66 CPU; the test then
+  # exercises revision gating by executing a v68 .word instruction.
+  'check_rev_gating.c': {
+    'cflags': [cflags, '-mv66', '-O2'],
+    'qemu_args': ['-cpu', 'v66'],
+  },
+  'circ.c': {'cflags': cflags},
+  'first.S': {'cflags': asmflags},
+  'fpstuff.c': {'cflags': cflags},
+  'hex_sigsegv.c': {'cflags': cflags},
+  'hvx_misc.c': {'cflags': [cflags, '-mhvx', '-mv69']},
+  'hvx_histogram.c': {
+    'cflags': [cflags, '-mhvx', '-Wno-gnu-folding-constant',
+               files('hvx_histogram_row.S')]
+  },
+  'invalid-encoding.c': {'cflags': cflags},
+  'invalid-slots.c': {'cflags': cflags},
+  'load_align.c': {'cflags': cflags},
+  'load_unpack.c': {'cflags': cflags},
+  # Build this test with -mv71 to exercise the CABAC instruction
+  'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
+  'multiple-writes.c': {'cflags': cflags},
+  'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
+  'preg_alias.c': {'cflags': cflags},
+  'dual_stores.c': {'cflags': cflags},
+  'multi_result.c': {'cflags': cflags},
+  'mem_noshuf.c': {'cflags': cflags},
+  'mem_noshuf_exception.c': {'cflags': cflags},
+  'read_write_overlap.c': {'cflags': cflags},
+  'reg_mut.c': {'cflags': cflags},
+  'scatter_gather.c': {'cflags': [cflags, '-mhvx']},
+  'signal_context.c': {'cflags': cflags},
+  'test_abs.S': {'cflags': asmflags},
+  'test_bitcnt.S': {'cflags': asmflags},
+  'test_bitsplit.S': {'cflags': asmflags},
+  'test_call.S': {'cflags': asmflags},
+  'test_clobber.S': {'cflags': asmflags},
+  'test_cmp.S': {'cflags': asmflags},
+  'test_dotnew.S': {'cflags': asmflags},
+  'test_ext.S': {'cflags': asmflags},
+  'test_fibonacci.S': {'cflags': asmflags},
+  'test_hl.S': {'cflags': asmflags},
+  'test_hwloops.S': {'cflags': asmflags},
+  'test_jmp.S': {'cflags': asmflags},
+  'test_lsr.S': {'cflags': asmflags},
+  'test_mpyi.S': {'cflags': asmflags},
+  'test_packet.S': {'cflags': asmflags},
+  'test_reorder.S': {'cflags': asmflags},
+  'test_round.S': {'cflags': asmflags},
+  'test_vavgw.S': {'cflags': asmflags},
+  'test_vcmpb.S': {'cflags': asmflags},
+  'test_vcmpw.S': {'cflags': asmflags},
+  'test_vlsrw.S': {'cflags': asmflags},
+  'test_vmaxh.S': {'cflags': asmflags},
+  'test_vminh.S': {'cflags': asmflags},
+  'test_vpmpyh.S': {'cflags': asmflags},
+  'test_vspliceb.S': {'cflags': asmflags},
+  'unaligned_pc.c': {'cflags': cflags},
+  'usr.c': {
+    'cflags': [cflags, '-mv67t', '-O2',
+               '-Wno-inline-asm', '-Wno-expansion-to-defined']
+  },
+  'v68_scalar.c': {'cflags': [cflags, '-mv68']},
+  'v68_hvx.c': {'cflags': [cflags, '-mhvx', '-Wno-unused-function', '-mv68']},
+  'v69_hvx.c': {'cflags': [cflags, '-mhvx', '-Wno-unused-function', '-mv69']},
+  'v73_scalar.c': {'cflags': [cflags, '-Wno-unused-function', '-mv73']},
+  'vector_add_int.c': {'cflags': [cflags, '-mhvx', '-fvectorize']},
+}
+
+if 'qemu-hexagon' in emulators
+  tcg_tests += {
+    'hexagon-linux-user': {
+      'cc': 'hexagon-unknown-linux-musl-clang',
+      'cc_dockerfile': 'debian-hexagon-cross',
+      'cc_docker_arch': ['x86_64'],
+      'folder': 'hexagon',
+      'gdb_arch': 'hexagon_is_not_supported_by_gdb',
+      'qemu': emulators['qemu-hexagon'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1c29c421ff0..c4b35161686 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,6 +138,7 @@ subdir('aarch64')
 subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
+subdir('hexagon')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


