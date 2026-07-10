Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DFFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4c8-0002Jd-HG; Fri, 10 Jul 2026 02:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c7-0002By-3C
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c5-0004op-3v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3p4lb3855226
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gDup/KsI0LJAf0iBzQYFhDAOxBJXh+wxFj2U9fJCszc=; b=D0aDxg0mEJ39VtEf
 sXPTVjg7RupH5+MW+HZlMYAiyIk1LEvWv6QhMV1097m9j5WYuR0rXvubEFYDUiI+
 VF2J/Z0O/A0r5a1Zu8HStGFyzRCoC5J6PI5efANZ9jP1DakRW6y0udtpCqu/9DFB
 GO8BpsKj0J2yDJE0CY15b1oDOWeQJHmU3Y4KaU+yqZksIOP6Ix2Oa81A7RXCElqS
 CEDeK6oyxbVBvW4X4pcFpIT8BfZHnqxKLOTIHIJsb61hMGS/RqYO+zeH2Te+fUPT
 FD8equrwk52xgjjYAnvUTz8NDlVBxyVal9AmiKkbMGhr790tx+TC2+oNXd3+FIQW
 rRgyCQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0h89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c916d17dd43so1038707a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664487; x=1784269287; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gDup/KsI0LJAf0iBzQYFhDAOxBJXh+wxFj2U9fJCszc=;
 b=TbpMCBpfXs+6i658bDDz5SstI+qNbg9Ltx/P3ZmT6tAhuDkFRB9M3ulWitbO6MapkG
 rvN0GD+NIusBgpvu9g7uAJbOH3zwUabpslT3XuDJ5+QvBq/N4ojtL5+zDMgDjj00lEOn
 XkjW0tiEZya6sruRjWISvxJp0qC/b2ZgvvVQIZX11vC5UpJA2X1s4cScd37fBKvHuQRq
 yMHrgog3qPAhuBCmfI30ZzuJXFSomI5UPrRfAUbiBbZ+RBzCLlNu+3cKi+CEDXOB6jg8
 YmnohSDbLLXBUeLCYVovAy9Cjj2gD+ZnhExVjlVzVM3qLZzvoHAOysH0JlqgfDGzCcj0
 OKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664487; x=1784269287;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gDup/KsI0LJAf0iBzQYFhDAOxBJXh+wxFj2U9fJCszc=;
 b=mRkV31gpw4HEGlfdWnHZCB/jRYStq5Pb5vyfyDI/Hbu1xjuxbsXivGcDaFmWRhzg22
 ew2h8f8FQTyDtCVNA4iVIMhZ3tNQ81cOaFquuuqngQEM0ZWpnyjWBEYyURoNTOtixyr2
 A6q9igluSLiifBdXWNEfQN/6+x9ww0KH6smHlsRO6tvc6OlHiYa+p2WK3B8VVC0za4Iz
 y+5CImPhrvpZRaCLpJtEkkyLIGnSeP5TaNz6DDBUHeDUe971FwEYCtcpLeSAc1G68d2e
 gspIeu+lb/HCi6egwko3Vp4S8djojcaVHhzJlWM+8q/YnM4zrGws/B1to60Zc9rsTQkg
 tLRg==
X-Gm-Message-State: AOJu0YydwrPhQeF1T3xw7kuOpoQf37DXqhWv38Jck8Lv2fH5vl2D/Zfz
 7gDSVIFv1O+LbXnNhyQc3tNiR9LzTl0fNyMrp5ITKxrIlFpIp1bjBdRxRUf+i9URRYdMDOyWRjs
 wwfOg5Cs7kdlLy3Rf6pgewntLFZxq7i5rGkHlk9GljrzTmZzjfNGy4RTeSl2LLxAZGA==
X-Gm-Gg: AfdE7cmYUzAKWcEXGHlVOjJz41upvwbGLRW+EXn2NSUYTn+GrhRtQ//q/3HgxwjvFx4
 DgncmDAQqqD+wPb6qbkL8BUfjn4SOUP2FCp26HJzbil2isPh1utcRkY4uNoGEHlX4MXD4rSJQzQ
 dQun6zsPxoVv2TlH733tjgAsanmLgXu2rqj6V1tMNPvie9wqbeYh0MvbILYRnuy4sEaeVwlMy9S
 W8q0vT28l8B2goaHLAF10PZLvnRuwsxrdAZ6kVkD5ac2q8nL1RqKw9kO1BZnZhLnkRWCZQx49Jo
 8XoMXd/svynr896C8hFdT2Md12k3TH/rp/pxj5cFSZKyuo4AbznIwso6GcQ0Obs0NdodUZgawbv
 rWqxaP/vj7laImqyMv9nrcvTmJaJfzJnpaP7yMNpEmT0Bw76NEhWpinGu1hXVfwSXFNo8hZRpuU
 lSf9nfgA==
X-Received: by 2002:a05:6a20:6f8b:b0:3b4:b275:c5b1 with SMTP id
 adf61e73a8af0-3c0bc9bb036mr12571774637.26.1783664487061; 
 Thu, 09 Jul 2026 23:21:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f8b:b0:3b4:b275:c5b1 with SMTP id
 adf61e73a8af0-3c0bc9bb036mr12571733637.26.1783664486610; 
 Thu, 09 Jul 2026 23:21:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:25 -0700 (PDT)
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
Subject: [PATCH v4 34/97] tests/tcg/multiarch: declare system tests
Date: Thu,  9 Jul 2026 23:19:12 -0700
Message-ID: <20260710062016.1818125-35-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX/5HFhLwGW1Eh
 z9fBfYOdLQaPZTKq6HA2rwmbAiU8tRZ+ZO9Bdqrk2GfOYSs70Kw6Zf2mlvENRONnAblXW5ocMhK
 o26rDp7GOrFnHfr9KF0HrDnvd2lkclU=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a508f67 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8vYM-gic8w0O4C_0kjEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Lp2pKFFdcteL7RkP1I3YGOXw3bs1tQ01
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXy6Xrb2NL42kJ
 s+M0ja0jGrFgvZdTPMDV4wO/o4/fokCdJDInrr7N7XTj9LHzMm9wgvSpY2aBcCoAcrv9qL92VPr
 N/CU0miySxLIYXXCbACTXWRz0jnjs3JyHpDSRdVd8FcWjVKbkzbOs8x/CPFaGxsLyV83GcWMJAZ
 kdRH/t9ulScD72uKfgGbgRXg4UULXhS9N1jZQQZcKAQdV3EVE08N/ZSnSa22ea6ok+E1DhdXGcn
 n3BHqyMQmfbR+iFb95CZk5iEp/7GTthzemXGhvFJMUb5ApcEZxKrZhHpjSIo1R5LvY9KMN+3D8k
 FKG1yWJKUk18QW9dxw0YJz5IILmqeNrmWhNR8LsLTO8iMiHJqOaN3vAETEHpWQnWgv2BxYWzK3k
 x4lFbwOaafzS6QN2Ov3zrq8Rt8h6GlZWiKEKdAin4Rjhuy+D62WcppzlrTOEC6BCl+d7RfYXCbe
 sy8w2nXuBe8/cZzrFkg==
X-Proofpoint-GUID: Lp2pKFFdcteL7RkP1I3YGOXw3bs1tQ01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

We now declare all multiarch system tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/meson.build        |  2 +
 tests/tcg/multiarch/system/meson.build | 53 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tests/tcg/multiarch/system/meson.build

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index 99af41b3fcc..508fdb585b7 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
 tests = []
 
 float_helpers = files('libs/float_helpers.c')[0]
diff --git a/tests/tcg/multiarch/system/meson.build b/tests/tcg/multiarch/system/meson.build
new file mode 100644
index 00000000000..f71c12db38e
--- /dev/null
+++ b/tests/tcg/multiarch/system/meson.build
@@ -0,0 +1,53 @@
+tests = []
+
+# multiarch src path are written to be included from any other arch folder,
+# so all arch can directly add those tests.
+multiarch = meson.current_source_dir()
+
+tests += {
+  multiarch/'hello.c': {},
+  multiarch/'interrupt.c': {},
+  multiarch/'memory.c': {},
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'gdb_test': ['--test', files('../gdbstub/memory.py')]
+  },
+  multiarch/'interrupt.c': {
+    'gdb_test': ['--test', files('../gdbstub/interrupt.py')]
+  },
+  multiarch/'hello.c': {
+    'test_name': 'untimely-packet',
+    'gdb_test': ['--gdb-args',  '-ex \'set debug remote 1\'',
+                 '--output', '/dev/stdout',
+                 '--stderr', '/dev/stdout'],
+    'wrapper': [prog_run_and_check_forbidden_output,
+                'Packet instead of Ack, ignoring it']
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'registers',
+    'gdb_test': ['--test', files('../gdbstub/registers.py')]
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'memory-access',
+    'plugin_test': {
+      'plugin': 'mem',
+      'args': ['region-summary=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-memory-counts.py')]
+  }
+}
+
+tcg_tests += {
+  'multiarch-softmmu': {
+    'tests': tests
+  }
+}
-- 
2.47.3


