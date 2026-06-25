Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B23CDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsS0-0000f3-4V; Thu, 25 Jun 2026 18:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsRy-0000eg-KY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsRw-0001J0-Jl
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFe4Ow2161554
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=w5/miaETc/JJxbFZ+/LnWy
 TXlLyc5jSBXdEMFm/FzvU=; b=SGOJiQIvV/LMrlQenZwkJjU4zbV8dW/j4LLuPl
 hMRVKfZoX5hgSd+LgmOTswxJIuVV6iwJ9b6W51Ao20pJHyfy59nADRxhlTzUjy95
 +7sCIbYNybUjnTMxxh0OhTNUtW5eBvqz3hhfJONjDrpKGVm0l0o7NajmjdrRDYN1
 QIX11Q/JTxtZZwGeJvmHUF/6eSF+To/ee7GCdLAL8KdnQqSfHY9ELNPl4MuuPyn/
 pARW3vWt5pE9EX6l43o9nWP4gbKqkzWTAjpTasUUw7z6XxFoqnqRU8qynE/Xa1S1
 C9YebK+f6KUIZmmWeS1IuXDYM0mGFHtn5Tb7kiP7zI0pgQRg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ymv3f8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:30 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1370417c0bfso365973c88.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426089; x=1783030889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w5/miaETc/JJxbFZ+/LnWyTXlLyc5jSBXdEMFm/FzvU=;
 b=Esv8rnUH7lA35ZcBNzStkR0RtAauM6YhA5Emn9WPxWSi4jWlkCsI3kvcsIK9prIakN
 aUzwO2i7a/Jgd78/lxDABm+ci02ADVFD71GdhGbdNrdWxIj3qX6zm24P6KcCgG/JOC3E
 jdtKTnLWTAOPwRiUqailyHkaa1p6weU48b+TXdtwwsnrHSf4XhP/aimUMb5ok84ZZvxZ
 fgq9xbzVC7l2JbhlvhwjhDE9B9k1cYQwJPezciCBWkCuzmVKjkpoVsTofGQokMtKJjYk
 lEm4B5ISIARgr7K4Fv7fui0b5ev4+Ralm3wg5G6fiNtZCjYZhYWYeqEs8ONJLcjkgO6R
 IZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426089; x=1783030889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5/miaETc/JJxbFZ+/LnWyTXlLyc5jSBXdEMFm/FzvU=;
 b=VdcOjK4V1ReYhmQDCa+7fI+kGOgmHOYXikx96/I4Bdo2tVRF3qiha3SwKaB9xkXDl8
 W40ynrjeN0Qu6cBQ/cOWj9Ffye5o5tTMv0aKFwbiBXiVtMYmCLVeNSyyULcjJU7XGEvx
 n0WfX3m455LIemzsuG82+/m78odYsIMR1ITMKvhCxgRg4pmho3pORIonBKt4jrgY0/OO
 EN+qRqbL8tYbKcIm3HtvK7RIbmCB1XzjpzK9Bd6nQ2cRubM/0cnd9JDhf5dWyt/AFE5Q
 rQgz7o0hh5mwIiq80w4/04ETqjvTrm0mRXJ+sj4mJTG5zRIbTcvJhDxzuvxqyKo+TNRX
 Os1A==
X-Gm-Message-State: AOJu0YzlXuF5IBHQaXenVIth/EnoLZO8DNQIPufJhxncuuXoJyEsn1AF
 k7TWw0VWYnHX9g7V0Bv+58rxUS49SNL9ErqTDq7DhvblvID5TrY9Ua2CFyn7auQeTNt+9067+/2
 xrnAsUjWVAILACaT4ZYRE79+iX/QkDoP7UT0hXe2Q+iVCAxHOo7hDOR3Y5BHSZ4X4kA==
X-Gm-Gg: AfdE7ck7Gp5Nhs3t9gCBWqrOCqHpuKcarylJN/WMpei9dRhYox6ngDgmB198buhaTNA
 agLK3QLvnYu1Vs2b30XOqzSacCyzx0VZgjXqiEoHTVQWXNKpeQNT3JrHAhXnGG7Od8v7jCfTfAk
 IQII4zVMDlOh733jRedlQ4SIdazM1gl3vX7o4K7Vs7f/JgUoLuuXxclqlTVM+hPdgEES75x653z
 ujJkD9xUsQm3JpGWWR2XXjt+6OvJRZCmpIEf5si5HxvwxNKtODX71Rpcw+oYTI9c8WLhF2HdWGY
 sCC+xGH4I6XYuqa4f1POkO1HcfYYvpTcAo2PlispI4A4R/gR+zR4fF4+yiTuR9R7XaFRGafiKOp
 xwxmAgW4laKLDh/l9m1HwmX5YsBXXdSMaUavNizLyX+YAMAsWJXPIFBuXvfteaoDnk6Qv5IsGMm
 8Dh9YQCA==
X-Received: by 2002:a05:7022:61e:b0:138:59d:e1 with SMTP id
 a92af1059eb24-139c3d145c3mr11474400c88.24.1782426089296; 
 Thu, 25 Jun 2026 15:21:29 -0700 (PDT)
X-Received: by 2002:a05:7022:61e:b0:138:59d:e1 with SMTP id
 a92af1059eb24-139c3d145c3mr11474382c88.24.1782426088777; 
 Thu, 25 Jun 2026 15:21:28 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318e7sm11538477c88.3.2026.06.25.15.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:21:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/6] CI update for 2026-06-25
Date: Thu, 25 Jun 2026 15:21:05 -0700
Message-ID: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DqBmPm/+ c=1 sm=1 tr=0 ts=6a3da9ea cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUzuhcyP3g1cI6dsK4sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfXzr9TRDNcjgyv
 BejWLM6ADTnO/kOyN3XQhQ6+UtM9tvn3G1g6brSzs1HuKguGR8ovgUkiJOnzKkpnf9L4iD9ma88
 naVK2aEKRMpwMWYo4Q1Xjh87zkl9DGA=
X-Proofpoint-ORIG-GUID: ohQ02AKrsaxAtC0Wv8YUQhy5Ziw9IvCf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfXwqrBCDZWHLaA
 ndnXDA55WBcI4frAQlqo6i3Qe80wOzAOJGpIcWh0D+q58ig27yXQgV6BA/coo5+rDx4WTUe5/Vx
 coZceh1eBLHKjtaMqecDU7LSUE4FoSkYb3w6YpWjy4AecH5sLBCVmo5rC7QUN6byZkYv+2fktTT
 Rz5JTnX/JvvC8Hig6XoWGsBubNKd5kV0deV8VNwzHfRKtl+fu4BCR6IgSonv3W5CTzSCGjMYVhM
 611K5aCAWARjJITZYA5XawejAuaJBgShOIjuFACHv88nw0nvk8B6yGm1QWeN7hGWxNVGUd4eafb
 Ctz4SHnCep2YG8IrwGXIKhD5jZSwBPHXdrBeuA9zYq3j3ECGpSLppoE2UQDMqrtwEBDuNLqMVOL
 mAXYOuvkyc+Wai2mz0HikVkK3IQCtJrYn2QgPhZ9LndkTLyZxm2C8sliQJcwW2Qsrn+nstjyAEW
 y/VJys1bV6yJyRhMcsA==
X-Proofpoint-GUID: ohQ02AKrsaxAtC0Wv8YUQhy5Ziw9IvCf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit 1b4d5bb3e233c9fc84663be28635d122c9a2b81e:

  Merge tag 'pbouvier/pr/gitlab_ci-20260623' of https://gitlab.com/p-b-o/qemu into staging (2026-06-25 15:34:37 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/ci-20260625

for you to fetch changes up to 94809d5d9b71fd3217e5587282563681f8233723:

  gitlab: greatly expand captured info about CI runner environment (2026-06-25 14:31:41 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2 0/6] gitlab: expose more info about CI runner environment (=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>)
  Link: https://lore.kernel.org/qemu-devel/20260624124657.2725376-1-berrange@redhat.com

----------------------------------------------------------------
Daniel P. Berrangé (6):
      gitlab: remove unused .cross_test_artifacts template
      gitlab: move .meson_job_template into base.yaml
      gitlab: use .base_meson_job_template from crossbuild jobs
      gitlab: pull ccache setup into .base_meson_ccache_job_template
      gitlab: pull before_script logic into .base_meson_job_template
      gitlab: greatly expand captured info about CI runner environment

 .gitlab-ci.d/base.yml                | 48 +++++++++++++++++++++++++++++
 .gitlab-ci.d/buildtest-template.yml  | 58 +++++------------------------------
 .gitlab-ci.d/crossbuild-template.yml | 59 ++++--------------------------------
 3 files changed, 62 insertions(+), 103 deletions(-)

