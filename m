Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B0DCD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZmP-0003cM-Cs; Thu, 14 May 2026 13:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmK-0003bL-5E
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmH-0005iI-Fu
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeRtm1717761
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=pic8sm/ZgTnWUBz2dj7Qt2
 OZZErVZNTxz9xiPQbSN5I=; b=SPA7AeQkK97ja12r0J+2YEA0ztIGGPRChAlj6R
 nH0fB/HE44+TnL+qSlmjb3I8NXerB4wJqe27MxL3ehHGIIQpXV547ufNaOBA+U0T
 AEXekNi5vPJgwOoM+38ZMeIxR8FMBPRBINmMhdL/jVcn5ariPxgY53doCzoyvUCG
 JwH9Az+wflixz8oB4HpXP0JMITdiocJn/SbUxWR/Upog409rxnlFnuMxG3dyvo5N
 TSQ9Km9HG8U+NilbXAai1UbKBDkT0cG0WOMPfOg/BJ3aEf2ATBDUfSbzOgVTwGpi
 dzTeCTKB7I9TMYObqD0SzYr58GIkza2PIWm5n+R3XjA12lvQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57y7jn3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso8665263eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778779391; x=1779384191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pic8sm/ZgTnWUBz2dj7Qt2OZZErVZNTxz9xiPQbSN5I=;
 b=i/Y4LVPou1nzzbAuAl0EctX2k0dcgk5AaGtZNIPg+hVlD36I1BhgiYxL6gJIkm6U3x
 nGdXPQR8LYa1d8Ird58NQdRWuDwdDft+Sw0RPK+idVuo3LDaxJto2yu2QPKkKHQNgBFn
 DD6pl4ZPBms+92QC4YnJZAEnNRkrNNdQIX5p8/ETaV2e/w2gUcYOu7k7x/5EzMct8JFZ
 KDEp2M13SBFQBgb41dT6togkUUMn2tvihyBcgyNUVMC7emy6RrrEdr7lhbgKAwXlM3dK
 yhxebqPb5dy1i0U4erI34ARZbhLHkDl7a/N8uxhmULf2Eck0r+kWN+9oAQMObe5R4cMr
 DRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779391; x=1779384191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pic8sm/ZgTnWUBz2dj7Qt2OZZErVZNTxz9xiPQbSN5I=;
 b=lEsclTujNYfB/3MZaL6tO+oCZtcqzHbsLUxZ33PItVhBdTL+8CIGIuCG4zrLqAID64
 vkv3Iw/aCzlRlcbmSJ4N2r60+FwO3BeMYJnFyC1MxnY3XYyIl2PMm7xkLHI2OfQQ1B2Y
 b0RdD2xyBI6/g3VoW6kVSJBCGDzYUBhZx0R/BE4uZQbQ4rQq8PoKtNbXG3/6ZxMeyLg3
 Z09IhFCaLx1gPO8cy/YyHUyZRG6P0f4YfgwCsJJQMRxIGm3aZNp16V1qqsvmOmgeyAWW
 xaqyXMvHbQHQN0Pmmmv1PzxkN9A5feAybRJso8t6onqpDLxLX1VGTRL1uQEo0b4SCmnS
 b/ow==
X-Gm-Message-State: AOJu0YzKmiYplPV7qnootcL4z4EOVbI54ysid+nz/WmM52mPeh2SjDGS
 tJeOJ1DRPHyPscenq7WvZwQex3pI7v8p0s1Pkyoa+MGim5ubvQFhrGKl0WzJBuQVn850kqjN8ON
 pWi2grK1XQBXxYdTE47dr3c+HKE22oFRXlDyOzjD8aj5n0p2zYCtj5ExiAE7hH+RckM1S
X-Gm-Gg: Acq92OEvxnwRMTqb1rlHmzzVSbd0l8ceuIn9f7NtObJXAeew5EyMYR6havdEDgzQRmy
 avEG160vDLzCA9uCRUilKKHmco1t1ysadVkdj2fZK5Fai2uaO9Wyj6UJ2BKqeqBc0iTiFh6yxx3
 +Q1pi4M7yz7MJLXPhkaoQdr1wBbXUT5QKJtLCgX8uu5w4BUES4OS/Kn3s/kY6SqTkn8W9GD0nMT
 aPDOOwI3U+POr1FP/CfCvno9eoaPXKF/RHxMYjzh6lTQatt4cBI275PN/ErUca1vY0DRmUEE9Hr
 s3KXfJm4phgHAe6iW0Q7+7TtPFMaT1SAkl+VGxiL3Sx2tq2SGigbsOmn6Og9ProMkB7vEmYCphT
 dxhDAvpGteg1SEYqCQUMqneQKWNmOLHR7nIhXzkg+NuAx9gjrxn2H5IzgVACSj2Xltgwj5AgcUf
 8TXX/O8Q==
X-Received: by 2002:a05:693c:2c8d:b0:2d9:6373:ad0a with SMTP id
 5a478bee46e88-3039818738dmr230734eec.11.1778779391006; 
 Thu, 14 May 2026 10:23:11 -0700 (PDT)
X-Received: by 2002:a05:693c:2c8d:b0:2d9:6373:ad0a with SMTP id
 5a478bee46e88-3039818738dmr230690eec.11.1778779390360; 
 Thu, 14 May 2026 10:23:10 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302944ffdf0sm3828677eec.8.2026.05.14.10.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:23:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v7 0/5] single-binary: deduplicate target_info()
Date: Thu, 14 May 2026 10:22:58 -0700
Message-ID: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zfS3qUFqCKbtm5fX0sChy3CiFXIojOsB
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a0604ff cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=jQUQ9ERTYtW1-GRz-9EA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: zfS3qUFqCKbtm5fX0sChy3CiFXIojOsB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NCBTYWx0ZWRfXyenorzM9mCBu
 pQmfMDn0FZw9i0fshT1vIijjWgyuKI6S3CQa7xOFPRepdV6Z9pzAk13/OgCgGRwrtLz1CFM1/rt
 t0oIG/rKHr0D1g9iDebF7678MJ7R2hNmqSc7xHGQfRZN+WhxK0VCcTci+sNxZ2mInOnLQPdj8zq
 DLkDt8B17ZOCcuH2YQbizRnsglocHEpulbhdTPRhQkIOj1mJI2aUWYrzgqcxcd4yiGFgXlU4mwQ
 C6n+3sYw3giYNhjYgZbOlvEXS2vry/Jq8io3SkvRDnA1nwlRN9F2lFZLZzJC47S9HLimXXZGRkp
 FJTdpi/TSuQduklXT569Vtc9FC7N28lqPngsL4doIYz7Fk92WY/oTpXucPPNWQ0iZ9d2eJRyayF
 Zy4J5W8CsUSE9ToxUTKcXBliqaVwMjlxYn4BMl4EerByauxVFnAJGyEqEgs+YyfMqGGyA3ngpYw
 k57vxS3b74rqzRPOcGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140174
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

v7
--

- Init target info in oss-fuzz main. Fixes job build-oss-fuzz.

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
 tests/qtest/fuzz/fuzz.c           |  3 ++
 10 files changed, 148 insertions(+), 28 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

-- 
2.43.0


