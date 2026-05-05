Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE66FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOZ9-0006O2-4f; Tue, 05 May 2026 18:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZ8-0006Nt-I3
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZ6-00069k-QO
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645FtvBg2445821
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 22:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=SFETRwg3V7z4diDFpu7iyS
 LQwZImVaQT7YOjhhgGU9A=; b=F7TRJOzoRDIjzV9K7ZYFMWCG48BsmVynRuzYBt
 0SJtb9exzoCvLCDPRTQzsbO3FKMQblRnMcFTfT/LAgS87xQ2f89Whmmipxm5gfht
 fHhlCJ/HSCi3rv400WjJa4M/G9GFwahG2uea/rhWNvlqQFzB/pHCjLNSykLHsWTC
 9Gnp+AW2BeXklcp6DCpCP2O1wfxTh0i2mSFTW4zibMtwPiXNbLM2OADADOSq3Hcy
 RdSuZQdUGILz9opSLtaGaZDQkJhQ0aeK2Qx9JGs2f55Hu6PZX+wKUTLKN6o1TXEe
 I//yuO++TGJ53uXj71iNxcc9ubK3OfRDxgp4W/xMy0H7biUw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dykmhsh2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:48:30 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dfe06b670so19009741c88.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778021310; x=1778626110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SFETRwg3V7z4diDFpu7iySLQwZImVaQT7YOjhhgGU9A=;
 b=IplCcnLT9LR9kMUmElY1/sqRR1iJRyo2SHmWkVI0a4AxnEEP9/DSF1zfBNNgt5OG+R
 X/en+UWpf7myOHG9SUDdz/ymgoIZaPz6dfGA2rRQH+DBfgWUqBoGfxbyYyY7/ssFc7et
 EcuH1yJdoL4S/ALttuFdFEBwN0r/Enbk70LOEPnB7WP0Znrk7tbPuNaY1+RJtNmHIyK3
 pSzlllZDdCQd+lMjmnta/ZTQR0WPBurruJODQ3E9hHkekk2jQc0xO+osZfr0YcPRpeKw
 gDoa20asCV58XFGbgfoLIYjg39uLzp0sYdHi3t06/Y5DKmMpNtknGIqrh8n9QxbDUN1k
 6gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021310; x=1778626110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFETRwg3V7z4diDFpu7iySLQwZImVaQT7YOjhhgGU9A=;
 b=PEKGwsWYBh7hLRp6OvhiWSZEG6AZTFUi7XBkDv84ika+MKn17g/Z2hxhpV4Yhl8nHi
 lkCo6S3W8kS3p+7dOENCBGXz/QWULtc1ozxDZTFItX9rl7XvUni+ASuJpn4O1VO3F9UR
 MpnXkQ1LWj837JIb4O8/n0qPSY3fOx6oOE9Cz/sllmX5BKXQjDX9wUlvnM0A8eouUa1v
 jvluPNfTduMIAJ6FAzXxXFlIFcHw5dBqtpV6cxnssp+mszbKUgP/LxapV45zFVdoDGFA
 SZEDUBMT3+c1ywzLOAo0TtZuiAu0gDAjliqX3i256q3I1bLA+iDh6vB+iblDvdVSMHXG
 Rmiw==
X-Gm-Message-State: AOJu0Yw0afFYoP8ml63t2R78lxKoySbxMT42PcCBNyMfac+OkxrE9VP6
 ruNnCLbXsvCYmCBh9Wz5IQN+7sUQukN+VKtJjhRgDykqLHla0LZ634M17DAXCvE62wJkrMg/OXA
 m13HtJ1GdzMM76z17XQZJpN8iVHIjGa5pYbismaKyJpEWmKc6F4rKV1Zcx/waKfZiRaPT
X-Gm-Gg: AeBDievg1Q+sIEeqHcLIy2+lhdS8N9L3yYZGII88t0FHRX83BZ8OOgGrOqeZFwTW++4
 K/HTJzJSWjyDYb2pzZj0kxvbRTX5AbXCnaLlm+hzgyhllwmBgb92Pb6xG0oJzeBC63yJB1EgzK2
 BtA7RZoNijQSGs/8rQfVBH2hziAc2/yFBY9wswIQi0NcBCqvt+2Lb01QYytZjA8HlYyJgJL9Vou
 wb6Fxk1JWqaJJI93Jn4ffdgIGGT9HMUx6PM+A1qdCq7Cc1XstuqjyGa0ZXw4Ze0W8H5ZPYMGYLj
 NwapOalRhwaWAjhBbMG63KfaINNS57BbshwshYCmang3rPXo2aSExXJ71Pki9r9k8zkpklcnnhu
 bujm6DV1/WpZT+AI6uvfVfYWqDjrc1FnQxiB2crFvn5smsP0sjxhBo5z+uQOXN5HJjCChnv9SMS
 Hbn+Q6HalvRJkDWZhP
X-Received: by 2002:a05:7022:2225:b0:12a:713b:8964 with SMTP id
 a92af1059eb24-131965bf0a4mr655993c88.11.1778021309770; 
 Tue, 05 May 2026 15:48:29 -0700 (PDT)
X-Received: by 2002:a05:7022:2225:b0:12a:713b:8964 with SMTP id
 a92af1059eb24-131965bf0a4mr655978c88.11.1778021309219; 
 Tue, 05 May 2026 15:48:29 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56d4cf2fdsm898953eec.8.2026.05.05.15.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:48:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 0/6] single-binary: deduplicate target_info()
Date: Tue,  5 May 2026 15:48:20 -0700
Message-ID: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X6Zi7mTe c=1 sm=1 tr=0 ts=69fa73be cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=jQUQ9ERTYtW1-GRz-9EA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: vBacD_c61UKdaCuJfreGNszuCjaHEIGy
X-Proofpoint-GUID: vBacD_c61UKdaCuJfreGNszuCjaHEIGy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMiBTYWx0ZWRfX47UQ0zDfPwgs
 ozNBSAL84VnxmOBi69kL8WE7WRD/CwNHhNS/gj916Rif99726CREeNeFSSOJ1fDkAZDdgXB0+Tp
 XptuaYxDSTduiOKIfhNPOkSBnTH6r+umOFKj4p54v+4XRc1+SVZQHK0dALslrQoV/ypu7IQq8M5
 D7qjAr80VrgjLqjfC4OIanDEpM95p35FzEb9hx062R6rkWOced75SrgCHMM7wVJoC/dBoFJ4/KU
 B1BbcTjOWNZilNz8xV0LEX4xMDq+69FkE/frltnAY6UZSzC4Id9x/rCmfH+R2S00BIUaR+SDNap
 RsAxk59SIsl8w7gJ31/FxtWifjUT48u2JitDOE/MfpwRZqO/OhwNQWG45r8oZhEyxZ3i4zih9yH
 WtedSCVZivJb2a+ynwnOowsBWVJfOsP91PJowSXT6udesxCl5la+WSpbzXbadQpRP3rsDKBI2jC
 qux/BFOMv+Scr7mpXQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050222
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

Pierrick Bouvier (6):
  target/xtensa/core: register types using type_init
  qom/object: register OBJECT and INTERFACE QOM types before main
  target-info: extract target_info() definition in target-info-init.h
  target-info: introduce TargetInfo in QOM
  target-info-qom: detect target from QOM
  target-info: replace target_info() in system-mode

 configs/targets/aarch64-softmmu.c |  6 +--
 configs/targets/arm-softmmu.c     |  6 +--
 include/qemu/module.h             |  1 +
 include/qemu/target-info-init.h   | 73 +++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h    | 30 +++++++++++++
 qom/object.c                      |  4 +-
 system/vl.c                       |  4 ++
 target-info-qom.c                 | 35 +++++++++++++++
 target-info-stub.c                |  6 +--
 target/xtensa/overlay_tool.h      |  5 ++-
 10 files changed, 153 insertions(+), 17 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

-- 
2.43.0


