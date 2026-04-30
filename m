Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFDBCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYA4-0002oa-59; Thu, 30 Apr 2026 16:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9x-0002m3-T4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:38:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9t-0000sl-TM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:38:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UIcG5b1953414
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uDCbj/oqDsn6/NQNn/i2eW
 Mn9ooGHJJyqRLz5YESgoU=; b=Ko2wUHxYGWYL6GVwfKMGLXM7h4tDd14V+1Jsep
 +om0+ciPxztkKcgAJG1ZEpjbugngNy9w484IUiV88ykn6AdJmuKbXYst/SXc3QVD
 fQhAQ8UbqBmHNZp4b8O3YS75IDRdAGYGyMsl/af+gCwikJBei13t6cuuhe/Zoqhb
 xT9T0XcnJy8KugAy9wRtj9nchJVN7S63J14NVCVuhyMj60QB32hbhLdLgk0fwxE0
 fViQwN8goRM+P7SY8AiExRyGbCEsqhnfLNBgABd+LRcUKVh2EqfLD/pI8QYGCZJx
 lFnSroM8j9sdphILVfU6BYRCax6MTB4DfQ9YeqXWlmfPvmQw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvchk8f5t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2da19227bc1so6073370eec.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581530; x=1778186330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uDCbj/oqDsn6/NQNn/i2eWMn9ooGHJJyqRLz5YESgoU=;
 b=d1gOCSlkdL1bYikIOnp5e2vVsgmFwz1PoVQ5WTLI4SlGOx7RCouapmX4bt1LoP3xQY
 e9LQS3A7lcwYegIWXqUbAOGXz6yyU0T+DsBzOFxt94MtPxScxHXy6xdTu9zanydL3ewn
 EOYzyxWWXXWF3VzEZaDTFnoqE7YNXaYlm9OPOAGwnFnSdINxVf46aUHMi0xQ02wi3vpF
 8D3Y09VMDAxr5sL1CgQEPVDJdq5Rxx7kghgES1ZiCXRI9ziwYfnh4mD7g0tkevQRD/WG
 ZZeJvBW5/2hMy5ehVuwakU5DUIiQD//4NojvEYDsEwjVStWBagOw5PVkNa+XnB6jl7mL
 UM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581530; x=1778186330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDCbj/oqDsn6/NQNn/i2eWMn9ooGHJJyqRLz5YESgoU=;
 b=KoP7KZgX5b9vFmfVIJVYDneyTTPdAZ/zz3piu4ipieKnx5RigB1+EkhhvjIOIyK763
 bzp4cECxlXYxodBVeYA7BViPeYUbMA9cAcBlpKv6bE9DFb6WvAcmVGdMBkYXZLTrwLGU
 9MLq83ouFCcWKXulnhNMGJtsXSCBPthZuaLtrt1tP2aJ6N/Yrf24qSOwvCJJ1JpxDg+i
 6DqkpGxuVYpyucU/nKBoJqJ+A9T0SbB2M1D7zo/X1p0b0RJ7EfoZHOHoDx23vtDDrB4J
 R73P2EWmSUVEoKzys8UpVVt8tdBVLTIlTl5pRaB3UxJqKRNPBEyqTyeNLSqFv7QqUgWF
 bdIw==
X-Gm-Message-State: AOJu0YzLV7APRrf1JGCiE2EZ9k98FGctf8/y4EdqWydkodgMDI0y9IpZ
 yCW3HieySixPBtFGbQQNNrgFb6I62hIs9bbIQACuqGXZV0RalzeKfiwcJTEGD0ZwJkAA52QZiY8
 3M1isf5qr29NOCQpuhkHHgTOisjJ8b8bKYfQFt4/sMrFN8CYcTjKM2Qt8M5San03/7MAw
X-Gm-Gg: AeBDievTOe1OjJqkdOIX4pLt20EfJaaC3Du3vwAJ4jBchf8q0nUx+/Gq8tA+kHlSSG8
 4n+hGdDfW6jLt+xvkmCUpEC7UYoV/yARMJRQFmmxYsUpljMctenJzd9VC965AXKftt2atJpVsn/
 j9uPFp7Je6hEiJcuGZR69mESkNwWPVn/QSJrXZLbk8WKAfThJoeHQK4JE62qppVoSYnvuunBjNy
 WUP0SGqj1dHEv6tkg0xumzvr3BZQGlurHxP4/fw4rybQSafHXPWAV+DU88DvRJW9+FWw5SYcsj/
 3sFYvKbBguA4oYMrPxIe/vYXzqRQgsTnyFnLWMuCMGEGFLNm+vD4z5iHjyNGGfoMvt3zMCamRGV
 V62/8M4Y5vJUGyJ8ATdKd+saksaooqhoZIr+LPJThcM8dYgRqL6GbzIBkNuV3e9Psxyky2Z17xg
 OpnjkuSSkAFzsBYH0y
X-Received: by 2002:a05:7301:1484:b0:2d3:f43c:d684 with SMTP id
 5a478bee46e88-2ed3bfef716mr2191450eec.2.1777581529899; 
 Thu, 30 Apr 2026 13:38:49 -0700 (PDT)
X-Received: by 2002:a05:7301:1484:b0:2d3:f43c:d684 with SMTP id
 5a478bee46e88-2ed3bfef716mr2191433eec.2.1777581529353; 
 Thu, 30 Apr 2026 13:38:49 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d628sm2202341eec.6.2026.04.30.13.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:38:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 0/8] single-binary: deduplicate target_info()
Date: Thu, 30 Apr 2026 13:38:34 -0700
Message-ID: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfXzk00+AgprY1P
 jrlBDcFl6GHgiH91YbYdiwxLh7Ui0Yqdk5peCERzl/HmSAnxCmooSTLjqlwUmGRcRGoo6HEMm9g
 FracOoy2v2CgKrO6xBRYKBv6MwAs6wZRn5otOVp4OSgeP2hTs/1M4235SgL487QGNvdWroFRs2Q
 Q/3wbiq5WaeygobgrJSkVqvSScz0HvqrB1tTnSmKmiissGovPk3GgUwqxHwCY8q0kZk4ubgPyeI
 9klshBBXPDpr0USSLlkTTITr9QrKWiaOwYZ9CSfHy0mBLbzC7yfrNS/l5qR9EDVCDINp+aOD4dc
 dmt9sOztBZO/fw9lV+KZfG99H75vu6N9NMNIABAUG61NKq+biaLgJ2SUANELu2/FrBUh4G6nELt
 4JQ11Tb9PU7z/tEWavYF9GX6WbHPYIo3UlHFkEHtzJ+hsH+CZgRAqpArb4PMI5EQmrY+qaiLuvx
 xV7dn3I99tnwe2LA17Q==
X-Authority-Analysis: v=2.4 cv=Zdkt8MVA c=1 sm=1 tr=0 ts=69f3bddb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=CjC71j5HhX8qGozMzJIA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: mDnqK_XBGfuijuM55y6ywK2nHe6oYHyf
X-Proofpoint-GUID: mDnqK_XBGfuijuM55y6ywK2nHe6oYHyf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300213
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

We are getting close to be able to link several targets in a single QEMU system
binary, and the last obstacle on the road is to embed several TargetInfo in the
same binary. The end result of this series is to have a single definition for
target_info symbol.

This series adds TargetInfo types in QOM, and retrieve them dynamically(). At
the moment, we don't deal yet with multiple TargetInfo selection, but install
all that is needed to be able to do it easily.

Because TargetInfo data is set through class_init, it creates an issue at
startup, where we may try to instantiate additional (unrelated) types just to
retrieve the list of "target-info-X" types. Those other types class_init may be
using target information, to add target specific properties for instance.
This issue has been fixed by adding a new object_class_get_list_by_name_prefix
that does not force instantiation of all QOM types, but only those matching a
specific pattern. This way, we first initialize and retrieve target-info types
before others.

An alternative would be to leave all this out of QOM, and use startup
initializer to add them in a single list. However, because all the single-binary
work has been using QOM where possible, it would be really sad to not use it for
this final step. Comments are welcome!

Finally, sticking to our promise not create a special "single-binary
configuration", the goal is to use the *exact* same codepath for normal binaries
also. It means that even for existing system binaries, the goal will be to use
QOM to retrieve current target, even if there is only one.

v3
--

- fix rebase mistake for one header guard
- remove MODULE_INIT_TARGET_INFO and introduce MODULE_INIT_QOM_EARLY, as
  requested by Daniel

v2
--

- fix header guards
- introduce new module init step (MODULE_INIT_TARGET_INFO)
- as a consequence of item above, we need to register TYPE_OBJECT before startup
- fix xtensa core type registration using type_init instead of static ctor

Pierrick Bouvier (8):
  qemu/module: add a new QOM_EARLY init step
  qom/object: init OBJECT and INTERFACE type early
  target/xtensa/core: register types using type_init
  target-info: extract target_info() definition in target-info-init.h
  target-info: introduce TargetInfo in QOM
  system/vl: init module QOM_EARLY earlier than QOM
  target-info-qom: detect target from QOM
  target-info: replace target_info() in system-mode

 bsd-user/main.c                         |  1 +
 configs/targets/aarch64-softmmu.c       |  6 +-
 configs/targets/arm-softmmu.c           |  6 +-
 include/qemu/module.h                   |  2 +
 include/qemu/target-info-init.h         | 73 +++++++++++++++++++++++++
 include/qemu/target-info-qom.h          | 30 ++++++++++
 linux-user/main.c                       |  1 +
 qemu-img.c                              |  1 +
 qemu-io.c                               |  1 +
 qemu-nbd.c                              |  1 +
 qom/object.c                            |  2 +-
 rust/hw/core/tests/tests.rs             |  1 +
 scsi/qemu-pr-helper.c                   |  1 +
 storage-daemon/qemu-storage-daemon.c    |  1 +
 system/vl.c                             |  5 ++
 target-info-qom.c                       | 35 ++++++++++++
 target-info-stub.c                      |  6 +-
 target/xtensa/overlay_tool.h            |  5 +-
 tests/audio/test-audio.c                |  1 +
 tests/qtest/bios-tables-test.c          |  1 +
 tests/qtest/fuzz/fuzz.c                 |  1 +
 tests/qtest/migration-test.c            |  1 +
 tests/qtest/qos-test.c                  |  1 +
 tests/qtest/tpm-crb-swtpm-test.c        |  1 +
 tests/qtest/tpm-crb-test.c              |  1 +
 tests/qtest/tpm-tis-device-swtpm-test.c |  1 +
 tests/qtest/tpm-tis-device-test.c       |  1 +
 tests/qtest/tpm-tis-i2c-test.c          |  1 +
 tests/qtest/tpm-tis-swtpm-test.c        |  1 +
 tests/qtest/tpm-tis-test.c              |  1 +
 tests/unit/check-qom-interface.c        |  1 +
 tests/unit/check-qom-proplist.c         |  1 +
 tests/unit/test-authz-list.c            |  1 +
 tests/unit/test-authz-listfile.c        |  1 +
 tests/unit/test-authz-pam.c             |  1 +
 tests/unit/test-authz-simple.c          |  1 +
 tests/unit/test-char.c                  |  1 +
 tests/unit/test-crypto-block.c          |  1 +
 tests/unit/test-crypto-secret.c         |  1 +
 tests/unit/test-crypto-tlscredsx509.c   |  1 +
 tests/unit/test-crypto-tlssession.c     |  1 +
 tests/unit/test-io-channel-buffer.c     |  1 +
 tests/unit/test-io-channel-command.c    |  1 +
 tests/unit/test-io-channel-file.c       |  1 +
 tests/unit/test-io-channel-null.c       |  1 +
 tests/unit/test-io-channel-socket.c     |  1 +
 tests/unit/test-io-channel-tls.c        |  1 +
 tests/unit/test-io-task.c               |  1 +
 tests/unit/test-qdev-global-props.c     |  1 +
 tests/unit/test-qdev.c                  |  1 +
 tests/unit/test-smp-parse.c             |  1 +
 tests/unit/test-throttle.c              |  1 +
 tests/unit/test-vmstate.c               |  1 +
 tests/unit/test-xs-node.c               |  1 +
 tests/unit/test-yank.c                  |  1 +
 tools/i386/qemu-vmsr-helper.c           |  1 +
 56 files changed, 201 insertions(+), 15 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

-- 
2.43.0


