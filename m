Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F73DCD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD69-0002Re-GW; Mon, 15 Jun 2026 15:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD63-0002P2-JX
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-00017d-5q
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ0H9R1389717
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/s+Ye+gqV9Qw9CJl0kDgXP
 8big/HURC5SMwc3kZkQ6k=; b=iNrvGyXFDbBOtNkGXy05rcAOfzOo2fPIFmFstn
 L0DY4f72vroBJdntH2DlV/TCXDF6Tvq0DVI78vOJrMneVT7GK8yF6cifZDvR20hC
 C1vJ4ULpbCALMm1jctu31NQR5jaJ0LvCls4ZUwctBoszPDon7MPPA1BfHHmu2qIs
 +k36GMzDrhWLEvbfOz2Cer3Hs95lA0jOZHcWTzEQ/hC2EDjz5ydrlQrsgdgxOUze
 xAJUHeWezNkCibkaq6tw/eT7vySfrdmir6q0j4CU8DSvU0IeQ7JTwHIUJwUwJM7g
 L7XNww0hzgkNnnC8Wy0m8lXM1RxZvTC72WSBTAIW4iorRzLg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter22n7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f1820babso5672058eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552130; x=1782156930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/s+Ye+gqV9Qw9CJl0kDgXP8big/HURC5SMwc3kZkQ6k=;
 b=iqQiWh133pU/lTtCNFxmsaDwKYL9U++aB0EaqvVA10129cQCMmsl0CZzzDlDw/JStE
 qjz+BhNaK8iPFumvjNJnjdXZtD065CbMWJIxBtZlGSe4t1CoUorijjfV8tZuV1RGot2h
 RBL22vvkk4fz7dvpYbJeVoXblfRCP60I/CZubMmMXjKyTO04wZLPleCPkkymb3Ay7tEF
 uYrdNbLlz2IZ2TP5dM1PjPy4hXEF76MWNiGtTyDkrhCxXUa4s/6WCAKUnVyPLnO3sbfD
 5CQGmTEdASNvFSqeQVEX9m4k4foegHGv1Pp/4By8HtpXlt+B5pcih0n//HcfoIixWlqh
 +M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552130; x=1782156930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/s+Ye+gqV9Qw9CJl0kDgXP8big/HURC5SMwc3kZkQ6k=;
 b=AeE4mEMDqC8LP6RYdFNqjL4AKWIF3SkekaZfR7I49ud21gpYkBunJ0KmdGWij2At7r
 XCJEn/O2e3Kjm0uqfba7i8eCgIl4a2Khga1VvqP4FGMuL7UEJVbVHS1VGKDZ3N5wBuDq
 ocXcxM5dLBuk12oMR/6+ZADHw2OEWutfdWhoPr24swvbro3uWv7R32x0KlGx3XRl50fQ
 Dosh+VYiXmlmX+gD/8uu614KtLjATqyRwKRo5FOgwNhuIqb66f59TUQu+pkeCPhaJp9C
 4nMiU3qaHqejrvXwKbUAGwI1GJ2+vfQEuBdRTrmVb1img/MBdbR1hJExqYb6tzWt2yBD
 8NeQ==
X-Gm-Message-State: AOJu0Yyo9qMHgfLITC6qoNC8t/skGP88HVw+gAd6ko8Z5cp2luuhPl+J
 TIuxSj6s4g/17OqL47b8ka/ndwJD4ItZD0O7BD6eB0pbyqWQESRA4Y5qAkKfHN4DkY52gx7Uzaf
 cxIgKgJqouXO3UvL9d4wN2Qslvs4fMhqz/giLao7E1z0lrHvdERNvVSDDBxP2RPNCBcuN
X-Gm-Gg: Acq92OHtk014ng017BmMs/8+B+IwGqQgO0l4uVrc/Jpk0GTONnMozazE5gbTVPAWyNB
 0nkzqg42k+TVEtxi6vqTdd9VqrGTeK7bfBwgNY8YwkGSPts2BNwTsBvqxRQiDExSpkZczyIt0qw
 EdRjfqjOjLzF4OzY2MHfxOrb5EK/BO4VEQOTUSk3ptNjtlSG+FVeaQ7Go2rGZtBp1sAhenLzwzQ
 ZlwTbkzldJNWh0up9wPUN+thhh1QYh9cYvdrFKp1MqW/oEyvT4qBMrymisEdy7yszU3KKQJa544
 npAwyL1FqcTDsaXqya2PVH7LamlooRJNJ2KYyOLPOAMrFc1iMRPUsT/PCLVgperpfroMaLEMveo
 /PIjmyzbDmS0m5NHkdjZ79qyrL4dMHcjKrEpx7AtNhYUaDDsUUkMIbhvXSxsPEAfUCN/LtLpoIT
 IsHyv2JQ==
X-Received: by 2002:a05:7023:b06:b0:138:1360:5bc9 with SMTP id
 a92af1059eb24-13985ebcba4mr228265c88.16.1781552129862; 
 Mon, 15 Jun 2026 12:35:29 -0700 (PDT)
X-Received: by 2002:a05:7023:b06:b0:138:1360:5bc9 with SMTP id
 a92af1059eb24-13985ebcba4mr228243c88.16.1781552129305; 
 Mon, 15 Jun 2026 12:35:29 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/26] plugins: refactor API to maintain state through
 callbacks chain
Date: Mon, 15 Jun 2026 12:34:59 -0700
Message-ID: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX70hsun/RlsXm
 +lcLrh1/ejquNzDnU/WFXtucDoeDvdY9sGJaQhWLAJePauSBaO4GkMOhFh7TY5vewlRbj8doWkN
 KDhJqM6vS1/Do3TjrU8t7oPPk1UfYJ4=
X-Proofpoint-GUID: uyK-NoiHXOY4n3cMcKsBIq3jOkcCf86Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXwWjz2Y/EE7HG
 b3zBkOLTfd+6SK17/f6BL8sF4V9krNCe/3t9bTRnYCEP6OVpTBAbcksFTOc+J8GIrnlPklT1weP
 Mgt8NRBFEpt21ZbVeo+YRxAvsiWIQXf/MqfN/yhfPAMwpfG/czBKjqHREa3WP8WuG51SBvEFEoe
 rQycwQrBfeSihR8xZpmTXKUAYe22Gshab3DnZtdeYqdbTPxBbYdjHj2aujrHdqr03gjJPGXM5Dh
 lUtoo8qdUBVLXYiaqVVlqUCotmajrWQjr4xngy11Ord4DClKj9YtN7ACCIUngWCySysDCtXwPQE
 RaMGjVL5qSx4LkurnXbyXImzUTGL9tC1aPw/78flITsyWrCF4Xt1PIbKqTdvkHLhigK5hy+fh6x
 V7AB9v+4Ohc/oR4h0cgXskr1xeBXFiel26g3HtEZXOJhWUAMnY/DVwmFGdFK/CawlPmXWTjZMMr
 y1kqzlOFFBpzuA5z1aA==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a305402 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NoHjUO1RaDQpt3zLnNsA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: uyK-NoiHXOY4n3cMcKsBIq3jOkcCf86Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150207
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

A coworker recently wrote a C++ plugin, and noticed interesting limitations of
current API. Basically, the biggest issue is that the only way to maintain state
in a plugin is by using global variables. The root cause is that some
callback types can't transfer user data.

Also, he asked why some callbacks have a qemu_plugin_id_t, and some other don't.
This excellent question exposed that we don't need this most of the time. And if
needed, we can rely on user data instead.

For functional programmers here, it allows to have something similar to
continuation-passing style, with all callbacks carrying data to next one.

This series modifies our callback types to make sure they all have a userdata,
and none have a qemu_plugin_id. Existing C plugins don't need to change, and
global variables can still exist.

After all those changes, we can finally implement a C++ plugin without any
static variable (well, out of qemu_plugin_version), using an object and
lambdas. This act as a demonstration of how we could write future plugins, and
also, how we are finally on the edge to offer a proper native interface
in Rust using closures.

v2
--
- fix wrong space line removal in patch 7
- add patch to have consistent documentation for userdata parameter
- style patch for C++: better commit description and add comments
  about which constructions trigger a false positive

Pierrick Bouvier (26):
  plugins: bump version
  plugins: add userdata for qemu_plugin_{uninstall, reset}
  plugins: add userdata to qemu_plugin_register_flush_cb
  plugins: remove type qemu_plugin_simple_cb_t
  plugins: remove qemu_plugin_id_t from qemu_plugin_udata_cb_t
  plugins: remove qemu_plugin_id_t from qemu_plugin_vcpu_simple_cb_t
  plugins: add userdata to qemu_plugin_register_vcpu_init_cb
  plugins: add userdata to qemu_plugin_register_vcpu_exit_cb
  plugins: add userdata to qemu_plugin_register_vcpu_idle_cb
  plugins: add userdata to qemu_plugin_register_vcpu_resume_cb
  plugins: add userdata to qemu_plugin_vcpu_for_each
  plugins: remove type qemu_plugin_vcpu_simple_cb_t
  plugins: add userdata to qemu_plugin_register_vcpu_discon_cb
  plugins: remove qemu_plugin_id from qemu_plugin_vcpu_discon_cb_t
  plugins: remove qemu_plugin_id from qemu_plugin_vcpu_tb_trans_cb_t
  plugins: add userdata to qemu_plugin_vcpu_tb_trans_cb_t
  plugins: remove qemu_plugin_id from qemu_plugin_vcpu_syscall_cb_t
  plugins: add userdata to qemu_plugin_register_vcpu_syscall_cb
  plugins: remove qemu_plugin_id from
    qemu_plugin_vcpu_syscall_filter_cb_t
  plugins: add userdata to qemu_plugin_register_vcpu_syscall_filter_cb
  plugins: remove qemu_plugin_id from qemu_plugin_vcpu_syscall_ret_cb_t
  plugins: add userdata to qemu_plugin_register_vcpu_syscall_ret_cb
  plugins: use consistent parameter documentation for userdata
  scripts/checkpatch: ignore spaces required around some operators in
    C++
  scripts/checkpatch: remove check on forbidden space before '[' in C++
  plugins/cpp: register callbacks using captureless lambda

 contrib/plugins/bbv.c         |  10 +--
 contrib/plugins/cache.c       |   6 +-
 contrib/plugins/cflow.c       |   6 +-
 contrib/plugins/cpp.cpp       |  90 ++++++++++++++++++++++-
 contrib/plugins/drcov.c       |   6 +-
 contrib/plugins/execlog.c     |  10 +--
 contrib/plugins/hotblocks.c   |   6 +-
 contrib/plugins/hotpages.c    |   6 +-
 contrib/plugins/howvec.c      |   6 +-
 contrib/plugins/hwprofile.c   |   6 +-
 contrib/plugins/ips.c         |  14 ++--
 contrib/plugins/lockstep.c    |  18 ++---
 contrib/plugins/stoptrigger.c |   6 +-
 contrib/plugins/traps.c       |   9 +--
 contrib/plugins/uftrace.c     |  10 +--
 include/plugins/qemu-plugin.h | 132 ++++++++++++++++++----------------
 include/qemu/plugin.h         |   2 -
 plugins/api.c                 |  40 ++++++-----
 plugins/core.c                |  93 ++++++++++--------------
 plugins/loader.c              |  13 ++--
 plugins/plugin.h              |   5 +-
 scripts/checkpatch.pl         |  28 +++++++-
 tests/tcg/plugins/bb.c        |  10 +--
 tests/tcg/plugins/discons.c   |  10 +--
 tests/tcg/plugins/empty.c     |   4 +-
 tests/tcg/plugins/inline.c    |   6 +-
 tests/tcg/plugins/insn.c      |  10 +--
 tests/tcg/plugins/mem.c       |   6 +-
 tests/tcg/plugins/patch.c     |   4 +-
 tests/tcg/plugins/registers.c |   4 +-
 tests/tcg/plugins/reset.c     |  17 ++---
 tests/tcg/plugins/setpc.c     |  10 +--
 tests/tcg/plugins/syscall.c   |  22 +++---
 33 files changed, 371 insertions(+), 254 deletions(-)

-- 
2.43.0


