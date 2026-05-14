Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2FCCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc8o-00017X-BV; Thu, 14 May 2026 15:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8m-00016u-JE
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8k-00025K-9w
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpfPJ4008413
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=SQtpPKWtlmJos+ChuI5DEr
 RfNiYs9a8MTGF04I/m/4w=; b=T4FaVQZHv7Bn/nkPCU/G77OyBFlo8EqWYUUffB
 4ZFMyFBHNScHlensMzPvmRR+qE096dIwhAXS5A27ldLur8u663GUmq9I3iDUz21y
 zgxpawyZzbJWpaW/EbDRmzfw+LgXPSnurpAgBtluXHI56wwVDDyvzA/N8uSQR20N
 j4ydB+FjpHMYw+BIQ/gRddkDo9Q42bMHP0WM/LsWTmphbL8+eGmgkqejG9kXqPXY
 RPZpVAQaZWwzS/KSqulPGFPNy/68SQ9TLW6M4m5wFA0mVL3gxbcsUE5kAZfbYwPk
 qruwO1vRi3Dz7eep/GWy7PDBnNdFyxgJK7IncoIf5txN00aA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sr6hy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2fded513994so5801445eec.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778788475; x=1779393275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SQtpPKWtlmJos+ChuI5DErRfNiYs9a8MTGF04I/m/4w=;
 b=SqzgA3izaFDZzJ8dZHTJMUsooe0VX+kgqC26eEVwSy47xOZgdYNebGhy/vTdAToD8M
 TePFUoUpD8TM8wRT1BUh3Byqr9+afDF2d4Zu5w1K2Vjat+5SLibsII5b3/BzJ1xNymNa
 8i1IY7KgUIAq+cSTfFasb67LATC+lf3vQELz/DB/UuIKyR3KiTwppx6trsGj95mInyI3
 se3G75m6vp8nPobURtydnYpOEneQKYu35sTBD2pFmstos4WP7zCLP0YGSIz+aDKjNhrX
 pq/yarau8vUR70V+RjGwVb8R1e5azfBj0oLGtvHUonkih8lbT5UNR+hYZXF3pfbLebdG
 +qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788475; x=1779393275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQtpPKWtlmJos+ChuI5DErRfNiYs9a8MTGF04I/m/4w=;
 b=THwtN7bzSNWLZkm6aqDfmXVIG85NoU9KhINiM98pXinRZaPXvFrxzuMrN/JJWcfVZ2
 9/9bDxFVTs+b1pLw81Yh0kWN5C1lXj2DF2OrtxHAbTCeo1iPh6xEcmmza2DB6G0lV040
 xjPowfzSuBSIIurvaN/eJgwQxLRYSyc4kY/3/Q0IN5To3vvAsaT1MkDc8i6XwF2G7hlj
 NSjHAq1B0VFHQqiPKRJDnR+7c/FiMFNgOzIAMAxqrJPih1cp0ijf3eC4xqgXWMejSakE
 jTrnuMCFBomwnl95n1Y8Da6RWL+2IxXzKIAlxNw9NQ8WmgaT17ZNeL2rvT0sGq0pAsxT
 37Tw==
X-Gm-Message-State: AOJu0YzoDAUqfIFMf917+Qip5o7OmvYZoMM6WXgQb4I6RDepkL17qRBL
 r+Z2YreKjUmtNZjsbZracGfC/amzQ5sM6q8Ij3LzIq6Q2mQ82zh2ydd2OILURxOYHsKO514aCJz
 hJIvWc8Gcv6J2lJAtnft5Hj+1JtHy/EqX86wsJ7RcruXuZrdiCsdJBg627WdjaNodqV1q
X-Gm-Gg: Acq92OEiRSgsgzYmDRb2GSVrJ9zuz71rfrB3TZGixOA5zwuRXMRlo9UAx5QQa/7yA9Z
 d0XA+kPItzAdXt4oekOT3Xnxa/WKDVwVT93VAzJH/XARLfTFswqmhrdyWLdclWnvLqtPzVfe9Kb
 L+DBjij0hTOt3cjjA82L5GF/7VsD9n0ZgI2TAEPbgFOigPOO8HCtmY15OMfXCVwsX42AMvdSGGD
 cRcZlw7TAh3t9e1a41oAmG90crZmVNNwITR0HDX35YX6e+UJS43KbGUYi8GA4HNTCqms7zAPLS6
 CoQLirn9QG3gjwu5wpNqtIENZ3MstsOr1q2EBHv360p9if2dh5N7axbEe/0JLtntXF9FLL50Jnu
 DE5K6wtwaLJnxpVlccmrkRqbcfhuqZZpPE5AtvUqnf/Rq/Ggbv6GwVGapyKzXS3zuSemTsToSWO
 U8FLFbmg==
X-Received: by 2002:a05:7301:22a8:b0:2dd:6937:79c8 with SMTP id
 5a478bee46e88-3039818a6bcmr586527eec.5.1778788475099; 
 Thu, 14 May 2026 12:54:35 -0700 (PDT)
X-Received: by 2002:a05:7301:22a8:b0:2dd:6937:79c8 with SMTP id
 5a478bee46e88-3039818a6bcmr586507eec.5.1778788474555; 
 Thu, 14 May 2026 12:54:34 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bcc5asm4180636eec.22.2026.05.14.12.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:54:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/5] Target-info update for 2026-05-14
Date: Thu, 14 May 2026 12:54:22 -0700
Message-ID: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9zslNKqSpcOpJa0E7cRp6Y6hY6axgVWq
X-Proofpoint-GUID: 9zslNKqSpcOpJa0E7cRp6Y6hY6axgVWq
X-Authority-Analysis: v=2.4 cv=cZPiaHDM c=1 sm=1 tr=0 ts=6a06287c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DETuAXBoK_OonNVjEuYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX4C1o6LX17NS7
 /935kl6McsJpIiK1E9OEfpyH99ePRoXHiSEO15FLsbCI54CbQHOCfQNUFZuYPmcT+4LBHGpebis
 8UWXAkD4zufAuu/lVCwpet90gSO5zAfAm9E/XK0G6Wl8tQxG+uOwQTk4mHHSgf5IVVnAmfsAmVD
 vWr25CwG+A/qkQAxc368oPLT5lhIkfsKGVhpJYZXy6q9JDLy7hkb7lWm/scJhVB4djqj8ji44Sk
 wZXVJhOz31tyMPsiNYbWuGPWs2IaP9uaa9UaSCM330BC00O14cITYp1aNNKu9cDjoacsQ0TfKsY
 2Xich62sKYGkQhgISYxuzifxRPUucNO5EAkvvc8/PihdZ8zStYOI0Mxv3TTJ7u+OVRk8kC7BkD+
 q6H/KqV4J+hzz+9PBpvp+VIdro0Swf/bg7e7ULBfAkFq6KeBkmO/kw8Z99EqRCIg7CCFIlczYh9
 YRFQOSskAl0Mxe2GzYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
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

The following changes since commit edcc429e9e41a8e0e415dcdab6aa52ad17ef8889:

  Merge tag 'pbouvier/pr/docs-20260513' of https://gitlab.com/p-b-o/qemu into staging (2026-05-14 10:18:06 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/target_info-20260514

for you to fetch changes up to 669f866946289ec783b526924aa91f7847b0551e:

  target-info: replace target_info() in system-mode (2026-05-14 10:41:17 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v7 0/5] single-binary: deduplicate target_info() (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (5):
      qom/object: register OBJECT and INTERFACE QOM types before main
      qom/object: initialize type_table in static ctor with fundamental QOM types
      target-info: introduce TargetInfo in QOM
      target-info-qom: detect target from QOM
      target-info: replace target_info() in system-mode

 configs/targets/aarch64-softmmu.c |  6 ++---
 configs/targets/arm-softmmu.c     |  6 ++---
 include/qemu/module.h             |  1 +
 include/qemu/target-info-init.h   | 53 +++++++++++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h    | 30 ++++++++++++++++++++++
 qom/object.c                      | 22 +++++-----------
 system/vl.c                       |  4 +++
 target-info-qom.c                 | 45 +++++++++++++++++++++++++++++++++
 target-info-stub.c                |  6 ++---
 tests/qtest/fuzz/fuzz.c           |  3 +++
 10 files changed, 148 insertions(+), 28 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

