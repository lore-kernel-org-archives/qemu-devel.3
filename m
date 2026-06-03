Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF10ECD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsZR-0007xb-Nk; Wed, 03 Jun 2026 16:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZO-0007wp-8r
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZK-0004Bo-RM
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653H7WgW2368054
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3pivOVjZs/kADk43DEzQzC
 oE7MxVZ4PmMHBuQdGn/8I=; b=bC4HtqTSmrZBpHcddtx60Oxki37+WR0aUIWx36
 YWG5WuA6HTpPxUEJ1L8mLcQotpi15AhOvAdDbjHX0ZvBpsfYPyRDQ+p2ABKHjfbS
 2i/rQbdEY3ZohcE5HkpuWwKYAaXoX4ZKLD4wyTFM6UJSgonBBOQ2817o84K9u3sA
 H3DeqBo6Qn9XBKBajMgmjPVdsirzXXzk1xzkVJeenNtkWs4+jXJRgFD2AWkjVfQf
 4gqmpsuQObVV0tanGz1Z3R6tfomnk+6lRRmBQLMuPzY2BnOwBaVrbGmwwIythja5
 4aozTKlRjg/jlzabocGk8tZDH/B+diuUQxwzbDKjD+uRcCmg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj3gjnce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-307625ee07fso1179267eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519922; x=1781124722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3pivOVjZs/kADk43DEzQzCoE7MxVZ4PmMHBuQdGn/8I=;
 b=SlN6qY1ur7oCoq5KCOByeRLR5PhvSD3rgpxUhqdCh1WDq4SqEjPHZh4zSBWi6pUk+f
 /ko2CCH0Z2a34VFVQStJxTk9XbV4RBKTW3nFIYfGwmantm+kjS9+YSIJzNPHWxfpWcbV
 Qcu+lxW05cxzGCUHYfX/RADqRXtdree+cru0wJrYrtZ8QuuLPJ8vhdpp4AddpHmOuIXh
 Hp66OKrwFEf712V2F90J9E6whQv94cJqQ2rwXX93s69bIa1QOvQpiENeyTvq31USnn53
 u7FSEKddurgMmj7N03s9IIilwVy6qdKxoTFVNsCCyxpxV9M+JmsNxrwlHMVFrQhb/KJY
 QF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519922; x=1781124722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pivOVjZs/kADk43DEzQzCoE7MxVZ4PmMHBuQdGn/8I=;
 b=IrK9rXcUKuLzuTJ0Kf6uPmWhjPv9pLEGdHgRc/mrmeLnlQbDTPfvKSw6wplKI/oqIt
 2U3ZL+6VtDeS5OgsXNbPtvYkHPqJXp15yAeC6O4Q9tIHMBDaXBhZQGupSKdw5YNXBuY0
 Sgs5A9AAmP1NbHar5P/RL9GXEbI6LZJBwBMtCTgJKtX6yQqIN6gMgoXPopE95ysWAKPQ
 mfFRpRXfWfJYxnWRgBUXIhIVBnDRSkRIQMDKg8QtoBlYq47Wi51hHz0PXAip+8JRTcYj
 JC8UAu+vfZ+AEdxXQ0hbAG+WKz1kFuheG0b2aI9OWItNWxI8S45P+Avw5BejdtdIAic2
 r+sw==
X-Gm-Message-State: AOJu0YwCz+4YQoZtqtmRoHrie+Jm1CW6QoREhdVOKDjFuME6gcGSYlvm
 ZK9d7vAK5qDXQsvqRvvD/Sx8wU0BhCSowzrbVVjz/+snXgPi1McS6zLmegWmg1ysqxJ1Eg8Uf8r
 0eXOCXogUqUjeoRX+y0mwNeEGFqJ/+ms5vbae2V5I/ZjiDnXMo7hPtOZRhZGkY2MjKsmH
X-Gm-Gg: Acq92OEecHzqMsK+CMXSkHvvG4P2amMo+Um5YNEGBSuwdYCZ6j7cQt65dqY4zUJ/Yh8
 kunmzTpkAxpmFf2HvvkZEkGq9hfmvBasKvzLqJiSFQ3b0mmXSYcm6rUBx+zFN1CjvAnRWqXyq0m
 VhtyiY8SxMW1it53ntA5cFCAeU6GEyatitI9wo3dGmm9rJweeuRWYFNeYBHSIwhG8YNh8YweM2B
 saRWPvRES71L5Y8KRm56J/F+bik70QPGnS8aL69b3n3wp+cWVPr4hOfFUYeDJHgA5s4OyyVRiMV
 4lKHXIRQ0c53biM5q8YMhzemfNDkYh55BO2X+Xci52pOYNwwCIdovv8ehDXI2nvGahYs1os6Enx
 NEa+YdN6EwO0g4kqijeSvzzzKgo9yElW9JAeyKvpzk80JQHD8nn3jRSb43LFmxxWEn9VrZ9tjLV
 yiGhWoym+P5vCMXE/x
X-Received: by 2002:a05:7301:100e:b0:307:2e1c:17f1 with SMTP id
 5a478bee46e88-3074fbca1afmr2461985eec.25.1780519922439; 
 Wed, 03 Jun 2026 13:52:02 -0700 (PDT)
X-Received: by 2002:a05:7301:100e:b0:307:2e1c:17f1 with SMTP id
 5a478bee46e88-3074fbca1afmr2461960eec.25.1780519921841; 
 Wed, 03 Jun 2026 13:52:01 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 00/25] plugins: refactor API to maintain state through
 callbacks chain
Date: Wed,  3 Jun 2026 13:51:27 -0700
Message-ID: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX5jNDj/KooJWx
 73YN4dMO7ISq3JdPc9B04CI1+z0RE4whNuWLVT6oT8xkYp4/SMpZlO3JHCEO/50BLuREu5ed2Po
 vLXuGCoZ5SeqFvOqqcr9iWlUOFeLVOfyrwhXTQMv/ZZzivbnGm/tQPttOEbzSLxLxrbU8m4kz3B
 u8lH0c6gLO1JO/duRkt9KXl23o52FdozeFieXEHowMEjqEW6pa8ybJCJou3Tb4CKq0lV4XnaGkk
 4Vjv/0jeYr8BEXHhAJycfM19cx/D6TPxdaIP7EdZoucq0/nx5CeJhzK90YXLT639ylmlaRqRRpP
 /HKg1FTATF5RuhSNK0l9PhJYxxumcSnJYUfNuWRk4fX0NSb28a7FDAi8LodsFMdZf1SNalMgRug
 FpNUelUVmDsxPA1slC/DTxae8ZcSpstNx92/rmsOdy8R9ka4t2ob8MQbvm8Kwf+0Ib/3zRgIozQ
 P8fT0hXRPV70VfhlI0w==
X-Proofpoint-GUID: 3VUFx1b6zCn4xA-gX59M_UpEFzv9Vdzb
X-Proofpoint-ORIG-GUID: 3VUFx1b6zCn4xA-gX59M_UpEFzv9Vdzb
X-Authority-Analysis: v=2.4 cv=UvhT8ewB c=1 sm=1 tr=0 ts=6a2093f3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NoHjUO1RaDQpt3zLnNsA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
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

Pierrick Bouvier (25):
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
  scripts/checkpatch: ignore spaces required around some operators in
    C++
  scripts/checkpatch: remove check on forbidden space before '[' in C++
  plugins/cpp: register callbacks using captureless lambda

 contrib/plugins/bbv.c         |  10 +--
 contrib/plugins/cache.c       |   6 +-
 contrib/plugins/cflow.c       |   6 +-
 contrib/plugins/cpp.cpp       |  89 +++++++++++++++++++++++++-
 contrib/plugins/drcov.c       |   6 +-
 contrib/plugins/execlog.c     |  10 +--
 contrib/plugins/hotblocks.c   |   6 +-
 contrib/plugins/hotpages.c    |   6 +-
 contrib/plugins/howvec.c      |   6 +-
 contrib/plugins/hwprofile.c   |   6 +-
 contrib/plugins/ips.c         |  14 ++---
 contrib/plugins/lockstep.c    |  18 +++---
 contrib/plugins/stoptrigger.c |   6 +-
 contrib/plugins/traps.c       |   9 +--
 contrib/plugins/uftrace.c     |  10 +--
 include/plugins/qemu-plugin.h | 114 +++++++++++++++++++---------------
 include/qemu/plugin.h         |   2 -
 plugins/api.c                 |  40 +++++++-----
 plugins/core.c                |  94 +++++++++++-----------------
 plugins/loader.c              |  13 ++--
 plugins/plugin.h              |   5 +-
 scripts/checkpatch.pl         |  20 +++++-
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
 tests/tcg/plugins/syscall.c   |  22 ++++---
 33 files changed, 354 insertions(+), 245 deletions(-)

-- 
2.43.0


