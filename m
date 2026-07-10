Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A23AC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cX-0003kn-7p; Fri, 10 Jul 2026 02:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cQ-0003Dt-3b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cO-0004r6-BB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n31h3802158
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aV13cXTHb1A
 l+2P2pxsiOWM1VLEMqWvB6p5Jq6/xroM=; b=G/Bfg7rKyLJnksFsY48nnKlfcsK
 KZaKKgtuIz60Cl5jDbFGtruB5rEUZj4G+8VqecVQgETWDrS2ZdqHLNoXJOvtny05
 WJcCnCIAAfDx5HQbiZPdgVmdYbmiSNACcyz0VGSbT5yJQfM4SGphJTzOX3fN8M99
 HShnCpuAchcfciXF/KFBAT7W3Y2TZBdPx1FJnUGwHv9ToZZGbQ/qMBTFW157yR+m
 LtIR4+bn53cdH3I/KSHfRduVRha4VmdIiFxJ4itHaM5+Q3dHQVr1qwD9NJwnC8Nz
 THfC3EA7zzqvl7AaCmJRIjuLgCINFQ4FOqR/8OALmxSjLVYpCEMfPcTmwoQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpkn5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-384636ba25dso1066787a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664496; x=1784269296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aV13cXTHb1Al+2P2pxsiOWM1VLEMqWvB6p5Jq6/xroM=;
 b=EUqr3JU4FBBi5+653mQAlI6gbSA7tbtfS/TLos3J/Mo9wCWl8dynsE4Ocqw+vQSE23
 TUUDM0bvxZY4SJ1CdwbDsFdilC6kVSH/N5u0Esv/3qVJpvcQpdyHomjpr+cNZI5r4ULy
 Ps6uBgxHEAWvDd1bg40mBfuov4qp187EiplBj+VnG8T+gswohaDGx2z7qDVDVzHFV4Jo
 8co/JGSVvkmjRV3+eXOU/FDZRu/cc/e6YNU/6Gj186ckAX/6iGwKLrjP7vJ/8d8NL144
 22PGRzQvxVprj94j/CaasnM8zRfNirLoWEFqhsq3u8JtXQb8p9hQrdqaOv4/pg9X1m7c
 +2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664496; x=1784269296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aV13cXTHb1Al+2P2pxsiOWM1VLEMqWvB6p5Jq6/xroM=;
 b=VkGAK5NsRe5syy6R4YO/bbANipq2QjPKSWopoSUxxuK8OxvUAhi+R4aJH5eGe99gqt
 vvMrRJJUTyrPqBcrCIk/aE281Z/6RqpyEw/YNG2coDw4pAFZBb9jKHvpTu/byVVK5cyJ
 O8YbSNK2/uUcedG+l1IlhAp/R1QdBiMmCi4Ad8jtWbzH0rvFxCshP2J2qA+t+zPyddhN
 3TsuJxWYmmqcfrsCd1dfI2NySHmN+WJ/ahCLrQ2oHnwH/2OInp9FTlZ+kcBz7z9vCHAw
 QG3M9D1S31WN+1psXYTao79iOoYxGorEawWSX4K7VjSJUH0vUx2BMedKFI8mKlQ6Wp3x
 83cg==
X-Gm-Message-State: AOJu0YytItq588ZMPnJQTRwgD5lZyNgQ4Ey7FRKiQvXhO6qArzyNYuiD
 eJQkKxcrhbIE0b/zRw/l01eDA08g5uXmrIJvmtK7oIhIl8+Ps1xs5SKBRy7L+iR5A4XVf1bAo8I
 KXEzgKJJv+rHD6I/gCbObkai5mhSq1ZZt1GUGkrLeQlWF1Ie7MWqS/moBud3VXtvHMQ==
X-Gm-Gg: AfdE7cm3O8Z0Nz0YbVr4TA905N9cDq/D9b5CQZKLsJJXZ1k7BAyCMwDZ5PwlMAbNpnx
 mij6vb41BOHsgpb18oEpGEgXWh3QCu1UDJHZcdeRAqi6LbrUxvq5eTuEemuHTtYRoEuf+4yTMES
 Z3ZEUtPLKtH+cIxSfFl3uP/GNWMoeTHlyJjJRGcuTOpxPLgLyTO3vXV3/aYQWLeSW4YuwNDehfa
 fpePZVLzuXBLWswNBP8CS18PeKPhmuc8JPqndyxDQDz7Z2hkHlQmbdDM/liPaIzurBVa/FnW8Qx
 JFm6UYNuxvDSFtoXVcvxk9JKbx3jUax4OyqTY0ydxw7ZXju2y/mWy4BpXkXa3INtjj9PVib+b1K
 QYbN4a0Z/5E6Cf/D88SWbNaFemWK2JXpFk93yYCKoyzQzVOoVIJ4KQrvNajQY41TBpWkSZX8Vs2
 i2yLMjSA==
X-Received: by 2002:a05:6a21:b8f:b0:3b4:605c:2163 with SMTP id
 adf61e73a8af0-3c0bc903035mr13611068637.4.1783664496241; 
 Thu, 09 Jul 2026 23:21:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:b8f:b0:3b4:605c:2163 with SMTP id
 adf61e73a8af0-3c0bc903035mr13611018637.4.1783664495703; 
 Thu, 09 Jul 2026 23:21:35 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:34 -0700 (PDT)
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
Subject: [PATCH v4 39/97] tests/tcg/aarch64: system tests
Date: Thu,  9 Jul 2026 23:19:17 -0700
Message-ID: <20260710062016.1818125-40-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX9zeqxBRNXA72
 wPovg84pQGapVp/cdSMXoNZKQq5mDkYMIbr4pATXf+sSw7z3jsFN8uz9QvcwBJ4PNpEEykqMhNp
 2HaXKLYZzJjbGUjmI+6YfJhseGXTJ7obGAComqlacx6+piakZuYjaG0mVhvPxUFqmVSO6SALJDC
 hx+S//VrBtl8kj5z4Ojhb+sX7JC+5vNLm/dfn37/3c5Kt7m/vbi4wgnmGUoubfTrp8VZgyh2Yr5
 bBsxePxgDzHIPrBv0tAxr7xYLCMSFPDczSyWiu5UWf+8zGhkMkxLSKq6rUNpisscCigD1UKlOOM
 8h6TyDK29lLFappcSUl/5o3IPJAeizzP95/Hf4r4pQA1f7U6C8O4RDs2T/YSx0uHIHO/3wE4N4I
 xcrQ1NnwLKDYrEFrcHJOmG8ivtJhEWuXatxO82lbnt7AvwxUUFbeojs71mw1KdMoaCpyFXBZlGW
 gkpUyjhGz8/6xyV+1vA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX3T8F7TaI7cn7
 z8utpW0fDniBGwKzk8qacvsv3s7xBOKmOBemUtAicKvgyGDGwgwwhFliV9T0xKKo+kbpXkyuslx
 8O6fNv9iGkBywcvZsn76EwJieI0pDYc=
X-Proofpoint-GUID: loKWuKaAXBAF4ZNIFlvxCdS0vfavJHcX
X-Proofpoint-ORIG-GUID: loKWuKaAXBAF4ZNIFlvxCdS0vfavJHcX
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a508f71 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=oLNywW23YkJ1TVQIeeUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100058
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
 tests/tcg/aarch64/meson.build        |   2 +
 tests/tcg/aarch64/system/meson.build | 108 +++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/meson.build

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 959d1cf698f..7301d004606 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -21,6 +21,8 @@ gdb_feat_version = {
   'mte-baremetal': '16.0',
 }
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
new file mode 100644
index 00000000000..9c31694fbac
--- /dev/null
+++ b/tests/tcg/aarch64/system/meson.build
@@ -0,0 +1,108 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script]
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+
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
+tests += {
+  '../../multiarch/system/memory.c': {
+    'exe_name': 'memory-sve',
+    'cc_feat': 'sve',
+    'cflags': [cflags, '-DCHECK_UNALIGNED=1', '-O3'],
+    'qemu_args': qemu_def_args,
+  },
+}
+
+tests += {
+  'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'gpc-test.c': {
+    'cflags': [cflags, '-DLOGGING_VECTOR_TABLE',
+               '-Wno-main', '-Wno-unused-but-set-variable'],
+    'qemu_args': ['-M', 'virt,secure=on,virtualization=on,gic-version=3',
+                  '-cpu', 'max,x-rme=on',
+                  '-semihosting-config', 'enable=on,arg=3',
+                  qemu_base_args],
+  },
+  'rme_gdi.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiheap.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiconsole.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline',
+                  qemu_def_args],
+    'wrapper': [prog_run_with_input, 'X']
+  },
+  '../../multiarch/system/memory.c': {
+    'test_name': 'memory-record-replay',
+    'qemu_args': qemu_def_args,
+    'wrapper': [prog_record_replay],
+  },
+  'vtimer.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
+                  '-cpu', 'cortex-a57', '-smp', '4',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
+}
+
+tests += {
+  'pauth-3.c': {
+    'cc_feat': 'v8.3',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=on', qemu_base_args],
+  }
+}
+
+tests += {
+  'mte.S': {
+    'cc_feat': 'mte',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,mte=on', '-cpu', 'max', qemu_base_args],
+    'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mode=system'],
+    'gdb_feat': 'mte-baremetal',
+  }
+}
+
+if 'qemu-system-aarch64' in emulators
+  tcg_tests += {
+    'aarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64/system',
+      'gdb_arch': 'aarch64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-system-aarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


