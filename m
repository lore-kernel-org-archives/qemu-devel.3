Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D3ECD37AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 00:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLVyY-0000UX-1v; Fri, 08 May 2026 20:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyM-0000TJ-5N
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyK-0005x5-6m
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6490Jh0x1767957
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 00:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CX4ZoN6AAdVYrdT/4aqOH6
 Y9RfQSagAnJrJv2MDutQQ=; b=owJ+zZ5wSlxc503TlX6LW2PRLJwXd85kvU6GRs
 a+zOtYY+BRljA/fGzjwXQ7fGbULHNnZGx0ipah2WnikiyZiF126M6E8PFc4wdExw
 0XBM7URaY+yyZtZ4V/ATmYKmn1aM6sKNyN4MIlbHmQgIbGnHkI0aaIq7fEyN/S3/
 jC651uCYMmvQtgcvPCeACaYeFDT9zcxs7RjJD1q6Uu4cTxFABRA0puyKOTnAJE4r
 iJIarJHddAn3KcYczBDLv07E2WES/bsyPeSAAWGKXoFxh6Z4iAihki7Lv5DOwb/M
 bgZ/Sr3MBujMe/xj1PY3vtwKSTEsrqWk/bZJaqcwO9s5XX8w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1t9q01sr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 00:55:09 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-131371497a1so6669913c88.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778288108; x=1778892908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CX4ZoN6AAdVYrdT/4aqOH6Y9RfQSagAnJrJv2MDutQQ=;
 b=fDvQyWP4bfTtTs0u8KRDAV2WF/GhcCt3pRAHpBIaKKZfXPveHmh+KYfiG7OH31c7du
 sU0J3mVrfc2hzveFh+2EXkxLm3KK6kbuVn7jupUmN6Ff2c+SZs2EkiE03Lwar0fcGzHS
 68rhodrGllx0rJeJ92vr8ujld5inpkmbMqPBdvApLjG23THBjvNF+nOZL9p8SUZC/5/B
 gz7DX7bpkNSw+af/yO1tHZ87agyVKPkwyvH7wtEHz9KwJxhG98CyJ2oQnYDnGAZEU0pX
 0p70yvmUdN9hbsrKlhY9sB6El7iO4noxUQ89+fRB5Ul5xvS3e116ePI7YzYP9otK60Ha
 BZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778288108; x=1778892908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CX4ZoN6AAdVYrdT/4aqOH6Y9RfQSagAnJrJv2MDutQQ=;
 b=kVJxEWTgK68rfnrm0rKXSyLVeXvEkmFrDhsNnjRW2PS0teysbjT3PyPQ9zRzRyuxMp
 xFIrFD39WweCo2uTO54ZWhLvkS++D3gKc16B7ghytRn5KuRn8Ss2iiRDsApMdoeq0LJr
 ElLCdr4bOXb+OaecA8KUSzHGp1a81DgW8spmv5+9KdAxnBOoZ6MMndlKaZK8vywim09i
 Nh6N3JddvayfLVJC5f2fkFSyNdqjaWoD041sNaCYLIbQdN1A6/fyCn5QIB644wqwLKr+
 cQzqjW66kojngHjJj+NP4QbuX/74rPCjXyy2VpfpSg5bfe/OtU9zArDkkOc95w5p7zoU
 CJVw==
X-Gm-Message-State: AOJu0Yy+wd6wRymytN0mfuV1tO6kAuvNxM+/4xEy6pXETktZs/zA1ECH
 mRwAtEb/v/mFHFYAuvWfW+swJPXtnhsyuP5BJ+FT9QAY1yDhkKOP1LdaFTjLVNoTddObCHWGskM
 /8WBw9V24ByNnvAUEUESF47IEfYxFRvs3G9+xdvvtCmbMrcmDmVmmIQwvwv/8WgICg92w
X-Gm-Gg: AeBDiev0P3rPR+b89IRDtdwQxQB2U7/mpzYdQfltOQgzTuTD6RIY1ZNbLWZ742QlSgn
 FMAr0zU1kB4bFAATIavDZcveS6yYfuc75YFexrbkVvvj1ShZeoDQfUMhXB1YcvxxWwi0fs6QqAr
 AwUlAWxftBYeVRucSma/wMs85fZsnxxtcxtVT0BZ8Mt9GA/n7zvCUDvVIuQDTFBVdxPCLnNeCpc
 A4aOB5Gcfp/L1JFV/KJLCPnBA/CHK9JNeAKjE0npZFFQlCI9BHEzIgRYhZnzofnJr4mGZLfmN1p
 iyAXA9nhAPAgrYgXXSrGSzVf6vHnc1r0Ikh/Fnk1U18aNEFaYytaRSqbzz9UcNAC/PYHzQQZPB8
 WLV1c9dkC3GVKvXt2Kg5KfkPKFwGsg1DpNmeDtticE50rpq6w+5kIyIPf3iG9rF/PLTQKSrQuT2
 fy/b07ew==
X-Received: by 2002:a05:7022:ef09:b0:130:ca6f:6c3d with SMTP id
 a92af1059eb24-1327124fb09mr2722297c88.1.1778288108294; 
 Fri, 08 May 2026 17:55:08 -0700 (PDT)
X-Received: by 2002:a05:7022:ef09:b0:130:ca6f:6c3d with SMTP id
 a92af1059eb24-1327124fb09mr2722274c88.1.1778288107533; 
 Fri, 08 May 2026 17:55:07 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm5352610eec.23.2026.05.08.17.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:55:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 0/6] single-binary: deduplicate target_info()
Date: Fri,  8 May 2026 17:54:47 -0700
Message-ID: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yNSXL67uiA-DZR-3BST0KIMA3h3xo9Ed
X-Proofpoint-ORIG-GUID: yNSXL67uiA-DZR-3BST0KIMA3h3xo9Ed
X-Authority-Analysis: v=2.4 cv=J7yaKgnS c=1 sm=1 tr=0 ts=69fe85ed cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=jQUQ9ERTYtW1-GRz-9EA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwNiBTYWx0ZWRfX0bVV9oR5GwCV
 PsFIEUZEe0TDlb775E2C7xtyJqsmPRujxMEme03Wxt0SpyRwyqKbaLf/ZK05Vx0dBkOKY/v3ryW
 cyhsRUTpiXP8FX4r5nhEmzUlLQJgeSUdvqUUjK9mmAw48woJYlBIVUNOygSmFSSAYpm853Lx8l8
 gdXKXQeWf3gZImQHhXyyTUWDe8jDk5w3RzBZ3hfmr5fx7zDxfuESrZ+hJ3tunwzQK9gbp7RJGGV
 4clrQLVjOR16K+uHuF9MFF9Zi0CO9Vrd4ieb7R+hVs/Ef77mG/wtQcMU066cehTUn7maxjuBROx
 4YFr0/N56DsK8bYc2y81F2v3ks/U/wJez7tKUlE3byE7kVyT3opUjDgAXUhcfowIvdcLPfIPF11
 2Ce/V+BWDu2e5Axk6wtY/lWNmYUa1325n2OrnUUHmSUiX09gRsk/K4YCzFg0eeuXaY33jSuiUII
 uieP+3CXhu88pwSb7vQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090006
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

Pierrick Bouvier (6):
  qom/object: register OBJECT and INTERFACE QOM types before main
  qom/object: initialize type_table in static ctor with fundamental QOM
    types
  target-info: extract target_info() definition in target-info-init.h
  target-info-qom: detect target from QOM
  target-info: replace target_info() in system-mode
  target-info-qom: use a single class_init for target-info-* classes

 configs/targets/aarch64-softmmu.c |  6 +--
 configs/targets/arm-softmmu.c     |  6 +--
 include/qemu/module.h             |  1 +
 include/qemu/target-info-init.h   | 63 +++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h    | 31 +++++++++++++++
 qom/object.c                      | 22 +++--------
 system/vl.c                       |  4 ++
 target-info-qom.c                 | 41 ++++++++++++++++++++
 target-info-stub.c                |  6 +--
 9 files changed, 152 insertions(+), 28 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

-- 
2.43.0


