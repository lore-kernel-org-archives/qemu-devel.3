Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF1BC98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rB9-00007m-6H; Thu, 24 Sep 2026 17:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAX-0008OS-Te
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAV-0000vx-RD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdbQk2295220
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zVfN49Aym23JjjZNQuepm0
 +IWRnFCxSvBH7fmPYUR7w=; b=msMpC1/VNpus1Sdd+dD2lcXRgDMNHIlKkWeev4
 RgAmXZgXQsWU8O9gcIg2oDfvVTBZw2MihOAtnoSICmes3FecC75ALgc8PFOo3Ckr
 zD3KWfEf5hN/Qz4JjjJu9LSjM+vIo4uSIeB4t5goNEtCI+VO7LthjbxZMum3CS+l
 qd/b5cxffN83vcl7JiHoED4AKR6kcH9obF0DtQKCge7em8QHDAmxcKDPwA2I2Wif
 mdQG+bksrpROR73/vr5ugZXGG6NDl7OYi4Uq9qAczfpX080NWUybdnkbbGWWscdR
 7j21OV/uBGULRyAbr9qVLeudsZ+wvooeeHpPuYSvaI6CmBmA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94k8n1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-32b8c2b30c4so356355eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790285987; x=1790890787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zVfN49Aym23JjjZNQuepm0+IWRnFCxSvBH7fmPYUR7w=;
 b=acZbBH/VTkH5Gbria/73m8dyIRh/2NapktEuMMo3VytXgc7ZUUMbq0wXNQjHD6OqHM
 ZduJFsHHSairBv3q8F2hb5MO5oHQwylyyiYZa0Y/t3+kCj/R1D5zKE711CF69uYnGcN9
 fZNrImIQUaL/HVTg+J55KhjB2foeFtYs+AES9FwvOHY4dgS03mU0vm3pZ/x3rSRVS0cU
 qmSHZbu+kmS1CF3/CSA0fasiQ4lDePhJsY1xjR3K+O8UvjOsTu23HeHdI0N4rF0hqJTL
 bCjsGa/IoMPu+fLDU/GgSr8TTMaRTcPFtmedAYmps9j24gHqBstZ896gC1IiToYHVa2K
 urfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790285987; x=1790890787;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zVfN49Aym23JjjZNQuepm0+IWRnFCxSvBH7fmPYUR7w=;
 b=17dAbCED5MS0lzW97a9h/GIfRd4VK+xiav0caitYX8eH6EyvaCnE5xWLnZFBBjBE4W
 eFyCnuLF+OGp0aID2k0/4kIzCyIXKSs7lAsp7pJCH2pbsZ8wqXN2BFWAhNn98D07/KGV
 6gMZJLZIV1EBOpW867k9vP4N20v2B4GC0E6jlLcYjeBFo95UXNrWtzS8WtGYFJg3bsDZ
 C4EEmRrMT29U1i8paW7nVIfxlqy79oJkYKcqxzBVwIqA3Xo1hZ5Q5c2oUlGMvyJymVDU
 hwvL7M5/uqIcPnBF/S7eiVdRPESt1ct3IjoeuSFwJtrsaI3lVwrdOBe17CdI1p1VQVmO
 6dwQ==
X-Gm-Message-State: AFuF++lIL2/unDT8RU7XZ8B3GXOhKNnH1/QIzfigDRux+VZY+e0IGFn0
 neHJnAXHvuKELuCzx0bEfZF1bxFkA75QgeUxIFEQlC0opkqCice3co9HJKhLfvNbmRIs5ErOBIG
 rcamw20R71g8qkPZfIXe/+Rm1vS9TFDQp6Z3E7IXavnQb9fxMtxc5d6hXN/JDT9o8+w==
X-Gm-Gg: AYBFou0OA7XAizoop5cXZ4wHq5edmsVjjfgzn77zkyqeQAD6J+akywcbfoLrp4Wh0I3
 FDY3HgHUOnEar3BCS2CFJsscUnhBp32/KyTGE738ufpPqMhUci4Xz7OExwEQZm3iVKSNdnjG73H
 RWiH0LmZPZ4DPua0u8xhjW47mnUMkgxrCu65lQiRS/ochu2kGBaXgUQEQLeFyEL7vO23OkrDOV7
 BuU2yA6dO8/PMqAvesjGmGAii18jMqMSd1DE3TRpKP9UGz3KvbLY/iQihp4itE6CPlBFvEmewyZ
 cU59u3XygrkehJ0kwuCznri4iE8Vqv178cz1/0e9Hmna9aVJQ5Re4iCvpXAuiyXEEAZqYHj+ABM
 k2SJeKBQQZQC4xbgAIRyu7hP+5jQEqUpdJ9nivJLleR08jzHahHo8NQoZMg==
X-Received: by 2002:a05:7300:1c94:b0:33b:fae9:fc37 with SMTP id
 5a478bee46e88-340043a2f7fmr3200309eec.5.1790285986833; 
 Thu, 24 Sep 2026 14:39:46 -0700 (PDT)
X-Received: by 2002:a05:7300:1c94:b0:33b:fae9:fc37 with SMTP id
 5a478bee46e88-340043a2f7fmr3200287eec.5.1790285986129; 
 Thu, 24 Sep 2026 14:39:46 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-341463ec3ecsm1273668eec.31.2026.09.24.14.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:39:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] tests/tcg/meson.build: detect additional cross compilers
Date: Thu, 24 Sep 2026 21:39:38 +0000
Message-ID: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab598a3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JE-Q6gTbdLfs4ShADjsA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: S_fa9rj9iemcd56fMYzTVfeGKhTicR28
X-Proofpoint-ORIG-GUID: S_fa9rj9iemcd56fMYzTVfeGKhTicR28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX61tdUdQSw2AN
 jlK1NUyN0JUjFitbIsvpTWH7H7Wlru04lBTRKgpCDF5Tt1V03DNdMywocjT67ZN37845LO72XZZ
 3J2QGzSSSCyNlKO8SGH6OoNTfll1542Wmgp/+EPGmbMdRADOc0n1s66/tahkrKwtgCEE12cSauO
 RXtVrZ3Sby/CKXSDKU+2xFovqFguSbrfqNJaY9BHj3YJwVrgN5Sa2o9LzKBICONMZ3CyygKmQyW
 vT9U0oaYWc9bvjYQ2XY+Q9DVU8heUSzb7Sq2PXpblhhvL5PagdJ9ocATkKXaCqWJzItYKDdfCrJ
 bpTd/PfL/NiHAitb7mZtYJ3sZReA5TaSdv6t+D8yNVrQMPH17KC3xTW/xoiN7ObkFwiYxTrm0fv
 c5GSNeffhDaoKBabHEdn7NZEWuz4a+7ebJfVJneeSVez4gbzQTSahdoLljHHVJo1tQ7/yqCRCo0
 rviIWbimBsMYAiPgXPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX5Ai9IkqDqyQX
 Mu7GNMZMQ3x7cKONBcRUklexYesAOjCfjSUuzhMjTHfDK0bYmKNA+nscr2vmikcO7CgMnX3UkQU
 RlVFfkvI1RMvnKwvj85OE/AEpZwn/cg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240088
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

This series solves:
- detect and choose host compiler for host target on fedora
- detect and choose cross compilers install with homebrew on macos

It adds a new cc_alt list field to test suite, to specify one or several cross
compilers to try. If none is found, or none works, we fallback to containers as
usual.

Tested on debian, macos, fedora, archlinux for x86 and aarch64 arch.

Based-on: 20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com
"[PATCH v2 0/6] tests/tcg: use x86_64 cross containers on all host architectures"

Pierrick Bouvier (4):
  tests/tcg/meson.build: report correct cc in summary
  tests/tcg/meson.build: introduce cc_alt (alternative cross compiler)
  tests/tcg: add alternative cross-compilers for fedora
  tests/tcg: add alternative cross-compilers for macos (homebrew)

 .gitlab-ci.d/macos.yml               |  7 ----
 tests/tcg/aarch64/meson.build        |  2 ++
 tests/tcg/aarch64/system/meson.build |  1 +
 tests/tcg/aarch64_be/meson.build     |  1 +
 tests/tcg/arm/system/meson.build     |  1 +
 tests/tcg/i386/system/meson.build    |  1 +
 tests/tcg/meson.build                | 53 ++++++++++++++++------------
 tests/tcg/ppc64le/meson.build        |  1 +
 tests/tcg/riscv64/meson.build        |  2 ++
 tests/tcg/riscv64/system/meson.build |  1 +
 tests/tcg/s390x/meson.build          |  2 ++
 tests/tcg/s390x/system/meson.build   |  1 +
 tests/tcg/x86_64/meson.build         |  2 ++
 tests/tcg/x86_64/system/meson.build  |  1 +
 14 files changed, 47 insertions(+), 29 deletions(-)

-- 
2.43.0


