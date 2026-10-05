Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DE2CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqU-0007Vw-VW; Mon, 05 Oct 2026 14:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqG-0007Ox-Jv
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqE-0005hm-At
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLc1U3043975
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xB4lf7p37uc6I3q5sWvEeK
 CbW/6aOFCAnxBUdA0OyLA=; b=hP5OAv3IlLrpri5Km3NWcy9G327QY/DA2UJbUW
 3Ok6E+HpWB7iQnKIzCd0KqQeTdoXaMeOp+o/oM1pT8DnnC000O2DpxBD7XXQ3Nvl
 i9hZFSBxnL9NObWwaPuQh0u/FYqYs3U1FW8Wcs2HjtxOA1YUM+aFANjo4vPdxn6v
 593UdVNKif3xHMWVi12RbWs9gcCp2vqvLD24sHbcq0IxU2jvXSPCuYHaskYYT2ZG
 Vlh+JXj9Xu012Uz2fnURwq/Xu8loFq9xBgQq9Y6GbDB7RUvkAJ6h3wxD73Gj79P8
 q7mPAS4n0g3VOpIxinnsgT1tK5+c1Jv6EAxTbh5SMU5jVucA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvsxb1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:11 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-147be78cd56so7699537c88.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226511; x=1791831311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xB4lf7p37uc6I3q5sWvEeKCbW/6aOFCAnxBUdA0OyLA=;
 b=W/5ee6abRqCEcoOV9q1AH7WIXH9FsDh5kyqxzyTFfcpc2Kz72IHWKAwSwe4fkYjcS2
 w80XS6goKraF1klfyciR06p44SuuLz1G4cb2r08YRKyZ/EQUekUN6U5qFkDkKparCxS6
 a1Ms+82qEXuAnjk1vozhvYH6EBQ5XujbBAJ2Wdw+ZCjlJkvZhHzlZ+N+fEqjsil7uDDd
 UHZSkuwrBsZskW+gQen+kguHHCp7fCWuVsUbKWmbV+Udk0ZB63D7hm21wSBAh70dyfpy
 HAvGvz/qU54hs9dHQzfLlMebE9Wqt3lVQm9iXaZqDaE17f66+3RBmIGwy+WsYRcb3Nh7
 tIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226511; x=1791831311;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xB4lf7p37uc6I3q5sWvEeKCbW/6aOFCAnxBUdA0OyLA=;
 b=1nLQqLykwBgNWYt6egd5RYhLS7J/5SCRf0FMK7DlGFAJ48+1151KF37C+9rxFWDpS2
 oV1JLbtkmS84YBGgCieW7ro4fDjWHVI4HGUQwmfO5oK0FkWKWY0w4dudULfKHzjf5rc7
 zTQslqNjbbK/i7kAx4IqNNDNYTfCY40xEvac1nFfukX433FXLaJwXxwK+aqqqmTiN3yU
 14Q8JQ/oWl1mWOt5kYdsY9GozBJr4MaHvZYunjeph8Sxei7mkcW+cNjEK6PviwiaXn/m
 hrBL/kNoxXLsxuIwP8BZEa0ZjmLGBrxe75PwjNZRYVNOtoousi25/64nU72nQ8XtrC8s
 gvqQ==
X-Gm-Message-State: AFuF++n8CU6eXWw9pSpX674uKTLdj8C0wBEH9WQlNGMBAtEhQxCZ7Ojw
 BhvWdeZaO5t0wCWg/5FKmj2Yc37mjNhUF0ADzSUo/pfUxUBCAApc10c66fq0R/XUQTt74mEAQ9I
 PDcRNPZqV1jNyuhWI8KGcfD23SjeY36rStEAbwploppRWRvb6U/nPTN3Dl+8t14dy0g==
X-Gm-Gg: AYBFou3GzosJlolUFQUWi3dG0el8blb6Gi17mpulrYiIdVJd7VwTVss1EUxBOvQeS6O
 hTuOLAkbrr4JH8lYX5kK3SvHguQTdktIINbYcPE8rOagPvUv9s+VnErj261iPifvbQJsqgtrE9P
 wk9v+DqnaI0YC9kmRc0JFyRu/J9m0F13nC+7PKPOqL9TYJ6ezTdmZ0bZo62gSTz7ZwaRT5OvIT2
 lKJNOP5B0N+DRbcyXz2JqVXKKKrZRQJ59XtgqdiXUFLi8CCbMQRL/y7iUJnQ9p1UWDN4Q+owHl/
 /e3/KSfGa64afiryDUxZsljXA0OZNYUVr3b5P8o/HrsChOTLLtro6NkPkCeBtA6fLEQO3ptmISx
 ykkTECAV76CHhhsCfCnvZ2Gm2IK9li7JH8NA1v+afR8E6euzn2t5OYjUri9OT
X-Received: by 2002:a05:7022:f51a:b0:153:7a27:b7d with SMTP id
 a92af1059eb24-1537a2710c4mr9061573c88.20.1791226510772; 
 Mon, 05 Oct 2026 11:55:10 -0700 (PDT)
X-Received: by 2002:a05:7022:f51a:b0:153:7a27:b7d with SMTP id
 a92af1059eb24-1537a2710c4mr9061541c88.20.1791226510156; 
 Mon, 05 Oct 2026 11:55:10 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 00/22] Multi target update 20261005
Date: Mon,  5 Oct 2026 11:54:36 -0700
Message-ID: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac3f290 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_QIKIsHotRbyyty9gaQA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: VzROIXF-l0uHqtuBQjELjvYMkGFuu_Ps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX/yKs5uQjuIp6
 kJ6Q4NyNq+F25z0jHCCS2JSwRGfvX626l3BAvkMvOm5dT0T91f6sCDfn+hLfoXRCpAlpM+1csBD
 pyYNBzge0EtnFZYBq2CZy8uZPYKj/Q8JDjj5q9hk584YL8IbaNrVgPBr/lRCGTb8XTpJPMRel/T
 DB2PsbdtQx2Z4wlLaPS3BQ8pgMgBqZ+NJ2WGQ4TEdDdEMP45vSgm9j2hsgMV5Lf3gGI+9eOKzbX
 VR+ljg2vnUvQbAbVepLcMMFJEAgQoasVegNeVSK9PRmNzm4CQ64tNMif7pue3ztTnelW5ykZ+1C
 r4ZHl15aDyCf8mM1cL2oXCGzyrk1aDoz+LeW8fMWrsAtkCT+aPIbpegVjNbXv8m+FhsCgv53dBd
 Mfr13Wm0CjWBRQ+QuCTHjwuwZEKTze9IGoXPtfulrG0Y3jUMRU2H8kgJOEi28tatYl7lFvVJiPp
 K9nsOA7P0Vn18sG8Y0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX9UiiXhpEWuLZ
 AeSTxS/iDs7FadShFCxkRGV2CZ8qyvJ0jkGIBmkDf3hepFrvy3q7wYGynPm9WJQxdut03ZV3BFG
 yHrYoOwAypqER/FU37tLfuQukpgqTNs=
X-Proofpoint-ORIG-GUID: VzROIXF-l0uHqtuBQjELjvYMkGFuu_Ps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
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

The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:

  Merge tag 'hppa-a400-updates-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261005

for you to fetch changes up to 2cd349bf10c915d7a02c7444fa037f827a04bd0a:

  ci: add multi-target job (2026-10-05 11:54:09 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2 00/21] multi-target: add straightforward architectures (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH] ci: add multi-target job (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260929183320.2960-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (22):
      hw/arm/virt: make virt machines available for base arm targets only
      meson.build: subdir system before finalizing stubs library
      system/meson: use stub_ss for dtb stubs
      target/microblaze: prefix helper conflicting with other arch
      target-info: add target_m68k
      hw/m68k/virt: make machine available for m68k target only
      meson.build: add m68k to multi-target
      hw/pci-bridge: use stub_ss for pci_expander_bridge_stubs.c
      target/alpha: prefix divs helper
      meson.build: add alpha-softmmu to multi-target
      meson.build: add avr-softmmu to multi-target
      target/hppa: prefix helpers conflicting with other arch
      meson.build: add hppa-softmmu to multi-target
      target/rx: prefix helpers conflicting with other arch
      meson.build: add rx-softmmu to multi-target
      target/tricore: prefix helpers conflicting with other arch
      meson.build: add tricore-softmmu to multi-target
      target-info: add target_or1k
      hw/or1k/virt: make virt machine available for or1k target only
      target/or1k: prefix symbols conflicting with other arch
      meson.build: add or1k-softmmu to multi-target
      ci: add multi-target job

 .gitlab-ci.d/buildtest.yml     | 11 +++++++++++
 hw/arm/virt.c                  |  2 ++
 hw/m68k/virt.c                 | 10 ++++++----
 hw/or1k/virt.c                 |  1 +
 hw/pci-bridge/meson.build      |  4 ++--
 include/qemu/target-info.h     | 14 ++++++++++++++
 meson.build                    | 10 ++++++++--
 system/meson.build             |  4 ++--
 target-info.c                  | 10 ++++++++++
 target/alpha/fpu_helper.c      |  2 +-
 target/alpha/helper.h          |  2 +-
 target/alpha/translate.c       |  4 ++--
 target/hppa/helper.h           |  6 +++---
 target/hppa/op_helper.c        |  4 ++--
 target/hppa/sys_helper.c       |  8 ++++----
 target/hppa/translate.c        |  6 +++---
 target/microblaze/helper.h     | 10 +++++-----
 target/microblaze/op_helper.c  | 10 +++++-----
 target/microblaze/translate.c  | 10 +++++-----
 target/or1k/exception.c        |  2 +-
 target/or1k/exception.h        |  2 +-
 target/or1k/exception_helper.c |  2 +-
 target/or1k/helper.h           |  2 +-
 target/or1k/interrupt_helper.c |  2 +-
 target/or1k/sys_helper.c       |  6 +++---
 target/or1k/translate.c        |  2 +-
 target/rx/helper.h             | 12 ++++++------
 target/rx/op_helper.c          | 12 ++++++------
 target/rx/translate.c          | 14 +++++++-------
 target/tricore/fpu_helper.c    | 12 ++++++------
 target/tricore/helper.h        | 14 +++++++-------
 target/tricore/translate.c     | 14 +++++++-------
 32 files changed, 135 insertions(+), 89 deletions(-)

