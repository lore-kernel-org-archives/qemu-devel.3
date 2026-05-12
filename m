Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619CDCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMoct-00084m-LL; Tue, 12 May 2026 11:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocs-00084C-2N
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocp-0000Rj-QK
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CB5Mnk591885
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=IGaINE0m4VZqtuRYXNWJGq
 bb79u6+9UJMub2tUzERi0=; b=pucjWplmUX2XJCB8btABKYckMFB+RNIkYiudmm
 4BYkjtb3avuI2OPJESCUuvSxu+7c/96OtGcjMrIIF8C516UrUmOFIgzS5Te3QJcK
 TMveXhMLgiDk9rIqCdhBiUQO9cO61PfDCzXQVPUCyamTiYnAGdZ6ubidDk/tZK0O
 IoTAs1dy3XGHFU3gXFm6/LZHE9Srk6M4eifJF2/3hCzc4suywD5kMh7ysZR3Ggfx
 ifnPswtutE47rfCeV0C+MEPECO+kc6jvmde/S68+7buEp/ysP1rE2Hg4LuoA+abC
 RJb2hI0+CxX/3M3gblDv6VgIANmWufM+yP/cm/FI39UE+HGg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319ryf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f3ec2e8d07so9758765eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778598140; x=1779202940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IGaINE0m4VZqtuRYXNWJGqbb79u6+9UJMub2tUzERi0=;
 b=jFxZJa5iEUWQIR2vSt7OBXXCsRubCKIPFlhNxxxlfimcuQP/fefvlwU1Bfc3fMZXlG
 a5V+2O9xmVCO+EtZSbQYIcuP5W1MOJt4iRdxsDvgt0DowabQ3HL4WIv0rUjf5COURTK4
 zYlKadvTbIlyY98X5Pshk/59YEaJqovdNuWI730f3uSP9o7OWtqYsxy+rzSSCe01C7YW
 ak9si1auqqsC0qq6pGCsof+4TKIbT9EtfzlhcsfW+gDicNoru8vOAC/V6Qqo4TuhJOkL
 +mbOGQENldGs32QILY1prh1P02Nt9VVZ7R4mS8gpJQVxK66IBoQ/3+mWDdv8aDVIgKli
 H+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598140; x=1779202940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGaINE0m4VZqtuRYXNWJGqbb79u6+9UJMub2tUzERi0=;
 b=c/XMdHwBD7gAsteipKNPwlOqpuHa+a3XFN34SdfI3WEQt15jK0zezdminnYoPMBVj0
 Fndz/2eQooB8RVl8u1f+0dOmxe/KACPfYijEMtEHLciPcv6jWmq1r1lObaeY8KFbfrDz
 tUrLs0GMaG4XLLuqqBf/nY4Pxlgebufc0LfThpsIQv1X0jI4w5k5iO8MH8omcVB2Lktf
 D54Ewt/A1LjFLKxDPsKoLV+DxH6TZldfDqKGAO2E3FViTnVuxflurVWj2N5oYd9D0f7K
 R7CdGTSkKQmIACsD49bR/L6YGT24WL7V1bG7Ntuxzg2dtjvgWv8EKfQwqLksyygwy+XH
 UlAw==
X-Gm-Message-State: AOJu0YxMlAtFg7B67X88eaSCwu03L0zgEiTeT+0FJaPNHfKGDu9DUN62
 RDHlpsKSFPczA62XNaiSKKtUC/LXnBTDTlFaA/SwUa8JXGozENBbYetrXuDhdlNKKmR8Y23PhW0
 B5bcwZoUFDxPu3CzhZCgsA/VeR7CLNvCmY/1T+f8j2btM2koS+OkN5eFiAu0hAQhu3P/2
X-Gm-Gg: Acq92OF4AVHf8XSfm1A4kqCTnjPFD+4b7FC928p/jMhRMc/wiDPABFeyit/0ybol5oE
 Mq5riFcSGugkrlbw4c5S0lPH6UCOqJ10ZmUgHm8H/FR5Z9OB/jwwHLGVWJQsvFH5KWV+qH/owK4
 kiOb9VsHkXdojPpa8SZdsZeced/MViK5NefXz+zZE8PK9Zpu7eLkn3U2rEcrqj6/rlRqq3UyKTl
 3dWqXC4ZGCX3HFP+MpsgHd+zGoNvSDR/2LiwL7Jsgq0fa0a/qZJvoOgqcgAINMNlET6FZVrE2cX
 U9Fmw6nCP+IVWUg89BLey4gIjJz0MTU7OtSIqiZyxwoLB0JrWFrg59x5m/3oyR2maEb+wCQOybd
 grb7z4R7hLJWFyXQj8Dd6cXultdnvzV65Oe09Ol/DXH0MSb9SzlW7rsR9XqfWyr64wOz7WUDgJV
 m9FfFnmA==
X-Received: by 2002:a05:7301:6006:b0:2f4:3a9c:8193 with SMTP id
 5a478bee46e88-2f85d94b2c1mr11076165eec.16.1778598139465; 
 Tue, 12 May 2026 08:02:19 -0700 (PDT)
X-Received: by 2002:a05:7301:6006:b0:2f4:3a9c:8193 with SMTP id
 5a478bee46e88-2f85d94b2c1mr11076063eec.16.1778598138657; 
 Tue, 12 May 2026 08:02:18 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d429asm18270335eec.12.2026.05.12.08.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:02:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 0/5] single-binary: deduplicate target_info()
Date: Tue, 12 May 2026 08:02:03 -0700
Message-ID: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1NyBTYWx0ZWRfX+U0XTyNCdJWB
 l0bbbJWLXAIZ4Tmjq8o84a4TyOYpkm1PGPVb6mw5guu6dg8SiNzWr9vhlu5GZ9w3uzCq0zRGae0
 /QjwW9klnUIEP5KS8hd3NHNiDihf6praTdbWeC0eEr1tfXAArcBaEqd3I66wdhOdfEmhc5XgvyM
 elUM4IZzPEP3tVqfSCuN+8uY5jGcDoiEY9LJ0FjaR1kjBp8nzDFhy/ldOWFkELSqHPKQFfcGN9X
 L6P6Dc+1oQFBr9NAh259ddvk+5hUPhbrWnyinjiAezrHvXIUNWLaYtOTbeNjUrDkPswNFwbNesj
 t2IqxmUon0QHs+8cS8XvUXgd9W/q7rqzxnA7NvykLeAQBwYnM8slU25lzjHbx/uPJ3tsjuCv0M0
 rtImMdiRPyzuN4cfAc02rLK5M6RpRf+YoQuleGQUJT4AUtBlaTyidA4JS/PiDtWXTbFvsoXWKTf
 hBjvj3j+riVa/+YUimg==
X-Proofpoint-GUID: cY0hTzA1NPyFKU83oK73Ro1bNmLOJ23a
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a0340fd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=jQUQ9ERTYtW1-GRz-9EA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: cY0hTzA1NPyFKU83oK73Ro1bNmLOJ23a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120157
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

v6
--

- Simplify QOM types as suggested by Richard
- Use class_base_init + class_data mechanic to initialize target-info pointer

v5
--

- Fix header guard name for target-info-init.h
  (TARGET_INFO_INIT_H -> QEMU_TARGET_INFO_INIT_H)
- add a new patch to initialize type_table with TYPE_OBJECT and TYPE_INTERFACE,
  as suggested by Richard
- use a single class_init for all target-info-* classes.

v4
--

- Revert to v2 MODULE_INIT_TARGET_INFO as Daniel didn't comment on issues about
  about MODULE_INIT_QOM_EARLY.

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

Pierrick Bouvier (5):
  qom/object: register OBJECT and INTERFACE QOM types before main
  qom/object: initialize type_table in static ctor with fundamental QOM
    types
  target-info: introduce TargetInfo in QOM
  target-info-qom: detect target from QOM
  target-info: replace target_info() in system-mode

 configs/targets/aarch64-softmmu.c |  6 ++--
 configs/targets/arm-softmmu.c     |  6 ++--
 include/qemu/module.h             |  1 +
 include/qemu/target-info-init.h   | 53 +++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h    | 30 +++++++++++++++++
 qom/object.c                      | 22 ++++---------
 system/vl.c                       |  4 +++
 target-info-qom.c                 | 45 ++++++++++++++++++++++++++
 target-info-stub.c                |  6 ++--
 9 files changed, 145 insertions(+), 28 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

-- 
2.43.0


