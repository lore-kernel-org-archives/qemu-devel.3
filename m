Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0087C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KKR-000375-E1; Thu, 17 Sep 2026 18:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KKN-00036p-DC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:11:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KKL-0006gQ-MI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:11:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLG4es2955462
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=mf8V46GOTjmR7nVUWtdx6y
 wxqSvOAsjYG4La5kFbcMs=; b=H5UIamfiLayFB4xQzmJxvGNy2i+ILvnReCe7Fi
 RD04VsP6mnWlpuBQJ5mkfrJAUaZPkavn1zM9vSjdTeWJMHPvVVE+Dz0m81cHLfGL
 hBUuY2GsA9dtwQEk6lttriBmHmSGIbLXrd/O+bRnIhOY+8cjgliwscQ8y4+MEhhw
 QuKmudRmbdy52RiyjPzRTEWxRAtL5SROp3e8Frk/JUCBqzM3ujUdB8EfQNoty5Ev
 S3lFjdTaFCqc6LCvchyDK264kenWN+7zT1L/808xJ0k/0/ZagWpz//BfNTsX78of
 gg7DBhv5sQqSwBh0eB2JaCKbubcZVH395/2GZ2sVk0QUKYOQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grgu5jeak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:11:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39af92138f9so115620a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789683091; x=1790287891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mf8V46GOTjmR7nVUWtdx6ywxqSvOAsjYG4La5kFbcMs=;
 b=Dg2CE1MBsF0mbgH/MG8AvrQBjWw5NN5+ax8RPe9QIduv8UjGAhN7FOQGzEzu+xpQKO
 lxFcIeyNXtOIZQR6uAM8bkCnIYbD9Ovlzs+CpTRGuLHHZpVPYC7GpU83PmYwfIAl+ID0
 B+34VQgtyX9MzMJabd7u1BuB4ZNbozuHPvvrm0AxgHxswCKW2JTbMPGId8ZST6Jlj/R2
 fTQbus2BjpoMafFJtt/AxSAjcHZChUqCP93bi3tQ2POc0RhMd1GKjxTMrXPDGkIXqPWf
 mn8saq5YZxUXLKWqUVM7IBj1Zezl35IcTO9UrrO13Zf/OWAB7vJwxvpZV2nplSK1vuDo
 gA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683091; x=1790287891;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mf8V46GOTjmR7nVUWtdx6ywxqSvOAsjYG4La5kFbcMs=;
 b=ODALAfboF9SiIiyZ08HQIiY098bamEQq/x2OcQmAry3WuqLtzR5FOkwXj57nGYvqUh
 uJ+3spaDUh5Yui/OB5SxcqnahK9XDVZnGstP/8wAhhjuN/OOUy48hm3RQ4jL3B0+C2PP
 a1ZLycSeYXleeNa6pq9UJUC7nnif6jvLKDhAF0zAx34qJZSgrVFDIeW/U3VgXxLvQKpp
 p/OoxF5Vtc5echs0l9Mw44TDYMOH7DPeWUmVlziPsTQOgdjhStmh0+6lAsO06iQySwEN
 Nf28y4frhK3mQMUN0EDkM2d11ihoJDdMM2uIFICr8m5VkIpgwgAd7l+J9rv+iGMlNJD5
 Q2xg==
X-Gm-Message-State: AFuF++lU85bD5DpVLgJpF06etnjSgFcKTs3OWbSPzLcaAJwo6CVWW5A/
 5hFG5oeP6r/Wpv3BJuxjH6DVExubxCByW3BRuOScG7L3wV3vRh1tu5YfwwrmIcbn1tL6pmsPohw
 Wpa6qJl9Ud9mfGnDvuOtruXdw/w/zBoMckT4QLRCjYyfIiCEklk4sRhgT4Rd2CUhLnw==
X-Gm-Gg: AYBFou0wwBo1PN0L9mNhfoEkVOBfmrJbLVg+0IqL7pf+aleaS1IXXFnRYt5kShOjned
 jmaaiwX7IEqYbEkfoylvHsDAaJMhwdVkZWJCFCp9nqISOpnasVkD1wHV8b68gcABmrlxnZvTdwF
 8n8ezs65YaHImlrH2LjIJRYYJD0WtXMmsjHxAyGRvoLsW6escwXUNSXtNFZgGdudGDb724jWcnc
 CHaFU0DrQbB3hVMFuRvoL9TEyxqTljOIhcifbfb0j6UHAwPhx4N8MIglGmkzk8yJpqmUR0o9oDw
 YtRmnCWeFWoae2jjN1diHRFjXq/fHzHuYP3bYCWwZKl2Qqwa7cizM88KNPCbe3Le+hrkZ3WCOpL
 aR6ixWXZzMms4qzGlPqT76F6+lcZoS9/O3O+Qm0m7f40/VyBBaFxFhUbLjQ0=
X-Received: by 2002:a17:90b:2b8e:b0:39e:4c7e:bc5 with SMTP id
 98e67ed59e1d1-39e5572d5a2mr447047a91.19.1789683090751; 
 Thu, 17 Sep 2026 15:11:30 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8e:b0:39e:4c7e:bc5 with SMTP id
 98e67ed59e1d1-39e5572d5a2mr447008a91.19.1789683090329; 
 Thu, 17 Sep 2026 15:11:30 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm21021430eec.14.2026.09.17.15.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:11:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/3] tests/tcg: fix more container issues
Date: Thu, 17 Sep 2026 15:11:14 -0700
Message-ID: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfX0VESPIq9TaHa
 zthhZofCxuJWAPs5HjreaBQjEeNAD1ZyLqVzwf8eOWp8LEMWpZEQaJAGKCkUQPn6trCBfDLVg2S
 GzOUkUQp1xdwSvtphpvhecITWOMiYQQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfX2qNdJIXdEU5o
 HkFPUUrXCMqbkl8T0s9fvRBP0vIS/iiLRSetex/8CpQm8B56xmnQ/UhDNBJek0oEpRKAtiGybOz
 6iGhvdVOsSRktRfnB/5LMvoxHreSr7PiNL9fXDMrCS0S+tKwhQd95DzHeFZWO7kUzUedSbWJSL3
 kT6vfSuP61sB5oclk1p82dsORfIczoCjuUHrysot02cm81sm1AbhJQ3ddnPP8wCuWnwqf5ofDAD
 geb7pyyw+vSwos892LNY9ZwEWytJyn+h5IjT/jXDLwByOLk2P7ezjCncNlcWMh71rS7NX9DOck+
 W8s/4h1Sx9/tvzkjiS6eh/aY0OgVEHmX1LPFWK99cqHcvqUTvt+3F1ov/g4IRdlL7ZcErdodMje
 ebKSO2rU4yfcPdgEev+NgwMK/8/bwfwMsbv4R2759Qzzxw6xpf0j2vSVwCTgD9HPINbJPvzNO52
 dzXc+k7PSVhSun5HZ4A==
X-Proofpoint-GUID: AY_grFhvFqRrYcLwv_2gf7KLLnOzfbKs
X-Authority-Analysis: v=2.4 cv=GvbXaU1C c=1 sm=1 tr=0 ts=6aac6593 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=8mx3tMVbo_dAeSVaqSMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AY_grFhvFqRrYcLwv_2gf7KLLnOzfbKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170319
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

This series fix tcg tests compilation with containers.
It fixes SELinux hosts and dev container with rootless podman.

@Alex: it's based on the v5 series and can be applied on top of it.
It can be added for the PR coming tomorrow.

Based-on: 20260917165602.3405537-1-alex.bennee@linaro.org
[PATCH v5 00/17] testing: various docker clean-ups post meson tcg conversion (pre-PR)

Pierrick Bouvier (3):
  tests/tcg/meson.build: fix host fs mount on SELinux enabled systems
  tests/docker/docker.py: fix run command with $UID == 0
  tests/docker/docker.py: do not add-current-user if $UID == 0

 tests/docker/docker.py | 16 +++++++++-------
 tests/tcg/meson.build  |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.3


