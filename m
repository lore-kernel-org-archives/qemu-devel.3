Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA09CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JK-00077P-7P; Tue, 09 Jun 2026 17:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J8-0006qM-Hr
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Iz-00085Z-Ap
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4Ek93229745
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ewqJKFVLzl8
 rdS23UubrdswMFY3I4XBQjyebwcsYW0Q=; b=HHQqMZX5scTPjXXFqMi6z5brkfd
 zOIMA0CJHwDgKs32vsqsTKkD749UFdbIR+Wd/4x0XZf0GikjYZ3edsJiE2KPfV54
 1f4iS24IX4+cZ16yAqekucwzx8Ymq/+Ez8AzV+cpPnAvCcoKqLhePwV1EB8S65Fw
 ZOX3wXudgyRQdBA2n2axSZJp3niSCvtTN6zSDItgMmByXAPafvoDZS+0f/dDapu9
 Fraq8rdonX6FDqbNmBWBARvGckOYTxcoQnWT4MIJY0FwFq7zuMmDP5/aiEohCVej
 wnZVqm6ReFW83SFjP0f9+r45urN3jal4wQx0SzZruTydPFGXRGuRVuZY6DA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgkxqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:05 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-13815cb1507so9024699c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041685; x=1781646485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewqJKFVLzl8rdS23UubrdswMFY3I4XBQjyebwcsYW0Q=;
 b=EzoBBqo9N/nciY/jhqJBjCA32Y9ijswUqyt27wXXb0qxgLkMaD8Qy9M70kyAMKBuYf
 OxBHLvvpUZnTTVmGKNF7B3VI79JIH36mS/YnembmbSF3quq6/6pCtSJrUApe6Rj+Z+Yh
 UY5lOG7lZLrwxnb6fhK9Aoi3emQVqK19C03kUtj+yBJ2HT5w2bRO1PUAnElW4T9MunY/
 T51UMjo5wfmbOaUDDa2Q0rC3e0b9w5BQDbZu500b5AswRuvxyNUbE6WyiUrwwXbYw1wi
 Ei2z7viUVZBypAdtkskfRs5KWTNd2jOO7YzVVyXKeu8ncPO4dMWbP3NNM+EM8iZG/J2B
 m/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041685; x=1781646485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ewqJKFVLzl8rdS23UubrdswMFY3I4XBQjyebwcsYW0Q=;
 b=ZdaEp+GOUg60bYR1TLIS3TBYcb0j2j2XTtjq8iD8VL7aLq5UV5f5K9dMqO5PlkaYf6
 5jmLjbrxNb735O41tMvZ8LXF03C9SGhQVD2C13OsHlQrX+0Pa6IP3uTGdledqvQ31Hkz
 PLKl9R1bujyoiYspddnAUWjKJaJbHqWLQsy8OhRcs09bcOfXizdb6gWclR0hkz22Rvos
 jBflxBzh/i/TrRwFQiduZ6fAjGgOxoVF/PJSc8eoFzIfLXWr8vdzLzCOhcJB+7t+95CE
 jODu5HTWIXQ2DXI7X+zq60Gyo8831GIWgGmK7ZBg+C0mXOEt+GPobC7Ro948oQT7J/0Y
 1gfg==
X-Gm-Message-State: AOJu0Yx1zvxny7VPFdh66Psw389CLeQFt0WI06XVlnf0gvOpInvgc3dX
 UHZiF4kV4hsR4r9PsR+5f6D0ndVB0NAX/JTUTv5CowvGY7Uq3ppsez7YjC84a55ZGX7ckGhmOYJ
 kc2yIT6fh37KStyKDWga4c8HroLfE7BTalWkP8hkNkqilPPpX0Kllj0kkgjL9TxuHL5sG
X-Gm-Gg: Acq92OHnXD15lzOI7tQ7mVUdEZyNQEcp1iGVWfmxPfaalQMmIfZ6W/Qjy4DDghkRFmJ
 uCvP2o8Pnqkx077vP3CXA11dvTxGJc0vd7eV6ZLJrek6CDkKnrEysGgkOdk/6dj4PteVxHTMeoa
 /xz8dw4noqGlq2e+zWZXXD0pE90E12hRWe07rdZbAlTEKKIFgPhkC8rgfdnUlZvgQGmRZWcwUHz
 K1pu060UB22t1KjW/sHd193/1BbCK2I21agwbeFENPHdLddrx4w81jgb/1Vw++F0Vz+Z4egoGIL
 Xre47DxWvJPmVtBOS9l3/fi6Bgjwg2ihQLI3BiCy0SCbJb/Dim499VRDG/ahOFxwQBuN8zDG1cr
 g4vM6JClOVPDU0AKchScUVqNcLcPbT02kswSu6lz21ZWGWT6kZR+sfEn2VmQ9qJUxkFXwL1bovg
 o9GmQl5UtN5Hs72bZe
X-Received: by 2002:a05:7022:f90:b0:12d:ceaf:ffcc with SMTP id
 a92af1059eb24-138066bad83mr11932727c88.5.1781041685224; 
 Tue, 09 Jun 2026 14:48:05 -0700 (PDT)
X-Received: by 2002:a05:7022:f90:b0:12d:ceaf:ffcc with SMTP id
 a92af1059eb24-138066bad83mr11932706c88.5.1781041684729; 
 Tue, 09 Jun 2026 14:48:04 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 12/27] tests/tcg/meson.build: test gdb support and introduce
 gdb_arch
Date: Tue,  9 Jun 2026 14:47:30 -0700
Message-ID: <20260609214745.772536-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX6ACpvFLY2+ZD
 bh0xjkl5m79Cv6iSsleG8eUELbUcqSMaUzufhFqfwmVk5yCosRsGSwIwztlqEt8zxrz9gGTETwL
 MRu0kIifY53Fh0Hq0vVcSr7nQkIutUbJIS0HwWqO0qYlGg5e8HbjesB88/m24gzBvQDvRT0/hii
 lzkFuaMWerCahn8C2H7SnWetdo0sMPtnRXQik5P1sg2H62LX9TWIfTjM5G3OfFiGCXykNQDndcj
 mBXKzC92wa1z6Mp+uP3SaE44KcIzSKR41bhmhApQe8X9437ZJUzAB4JhNZJl/SVYhxYIsMpfCdc
 1oq2OgZZPa8Ak55xT7GObfuzhy9/GilScv0/WxUZU+PPkrX/f5i6sZMffOzpXvAALwlINzccvpo
 2uPFsxTdCcfBEhGzaDSyhUlozA2wwLpLbesvfVp6XkewZg6GIayLr0fIs6vJy2w2nWjLTx4gwhj
 8aiPZ/bd/cQiruckm5w==
X-Proofpoint-ORIG-GUID: P4Y8Wks6LQbQxhe2Ww_AYoXEBVDqir0k
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a288a15 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=EVhyENkjGFIjn4asmzEA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: P4Y8Wks6LQbQxhe2Ww_AYoXEBVDqir0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
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

A given target can now declare which gdb architecture it requires.
Also, we add the code to check gdb capabilities, and version.
Tests can use gdb_version.version_compare('>=X.Y') to test this.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a47f1ada779..1496cba460c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,5 +1,11 @@
 env = find_program('env')
 
+gdb_progs = ['gdb-multiarch', 'gdb']
+if config_host.has_key('GDB')
+  gdb_progs = [config_host['GDB'], gdb_progs]
+endif
+gdb = find_program(gdb_progs, required: false)
+
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
 #
@@ -7,6 +13,7 @@ tcg_tests = {}
 #   'name_of_target': {
 #     'cc': cross_compiler,
 #     'folder': 'folder_for_test_src_files',
+#     'gdb_arch': 'gdb architecture requirement',
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -33,6 +40,18 @@ tcg_tests = {}
 # is guaranteed to be unique also. They can be duplicated by setting 'test_name'.
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
+gdb_arch_supported = {}
+gdb_version = '0'
+if gdb.found()
+  gdb_version = gdb.version()
+  gdb_arch = run_command(python, files('../../scripts/probe-gdb-support.py'),
+                           gdb,
+                           check: true)
+  foreach arch: gdb_arch.stdout().split()
+    gdb_arch_supported += {arch: true}
+  endforeach
+endif
+
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
@@ -46,13 +65,14 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user mispell a target entry
   foreach key, _ : plan
-    if key not in ['cc', 'folder', 'qemu', 'tests']
+    if key not in ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target)
     endif
   endforeach
 
   cc = plan['cc']
   folder = plan['folder']
+  gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
   tests = plan['tests']
 
-- 
2.43.0


