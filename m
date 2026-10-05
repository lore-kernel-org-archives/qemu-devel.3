Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3929ACA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqV-0007Wl-KJ; Mon, 05 Oct 2026 14:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqI-0007PD-0z
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqG-0005hy-AI
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLKZf2909372
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RtyCn8VZJ2tIdTYLEGpALfHHcZYLO/gQ7FbKpvCjtu0=; b=B/UHu0srGZnLX+9T
 RXyMur5l1Ly07QNP+Y4TsNM3vAl5YD/PmLhQfAz7C2pAJVBAletYUM/ZukqN2kxl
 I+QnXzgTdbC1+EF1beNNquTYF3YeoWFkyL25i4WGOwMKwIJ+EYxrvDuq9QIRW7eH
 yA44PxP0HkMQS9nJbYJ0E5t6ue32RWexHfyghXqJU6BxAtVZvYwVNGuQ2lkP2gYi
 kxn02g2QXGLN7SMV1rAx5o84xp5Wz82cV+3gHTUKor7RQMrblmhmsDG5ODq/XM4x
 JVknrYUqI8F4mCrvD/hJsxXepsNHIiKe9E3JDYkOqddNlwC92u72aT2vBxlgjXUl
 lkklCQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg1pw6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef0362d95so3940251eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226514; x=1791831314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RtyCn8VZJ2tIdTYLEGpALfHHcZYLO/gQ7FbKpvCjtu0=;
 b=NResqJp69V4wG5RQs9p8ArUOdYGtlJdEyQ4b7MsmBUpMGI1k5fN9uvLZbpZtsQPkOs
 M+2KIHPTYlT3/DsFTXN9xbBAW3rJ5jDZlqUdASf5mH2TZMmtcnkhb0GsQsVyeaXWK3N7
 UWxoA0hvi9X+oVSwm/k9K8KZG/JAPgdnT7kwH5nzyxIUAVnmlzqCvy3LUBKAd5YB/YQ9
 8iVtUt6YRkIoeKefI3+1ny1eTEdwfZyg57QdjJfG5fEXmGJeDsmv0PY1XZ8FUKelQUze
 553bTSjUPp+mksyhocOV6VgE2xEVXKghczCfoCn33oMFCMc99lvPdZkaK8B3LqLpLclG
 /u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226514; x=1791831314;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RtyCn8VZJ2tIdTYLEGpALfHHcZYLO/gQ7FbKpvCjtu0=;
 b=M9xsC/0/5rjYpgqlx52jDJ4PPwtURHQUkpQQuFGl4y2MrunjfwMviQ59Qhby8X3OGh
 OVHRIU/1wRUlMb0suXTh4MMH4Yg20EQ/kNSPx/bYa/UzXhlQLlCP8UD4VdkTZ3+QD7hD
 wulwTbdwdMSr/h0uI6N+JIFGH8fY1xrcA7himOBzlOTHOytAfY4ssVDntU577pnoxf8v
 g7EbWnpUEL4Dl45d5mmYxHYQxb1/b32vkwW2ekZUNijjK+i2+C3S1vLqazFVOA3DkRfA
 EnD0Z0WeDrmD8RUggnb6KSQxOHTiGdsELAXGmkoNi7Kmhg6Oo19AEnXi7NFYuEodPYc3
 Vdow==
X-Gm-Message-State: AFuF++kynMMhQdFhnG+/ZbP9YBDA0AX1NksmAKgSLMYVTaU3NPXros1y
 1HRnk3EhJzjtgf/ISf2FgxlyRgJdUYNL1gNGt0cvfcVjO26L70lMI+PMLUItS58cCnTa5oxVDL0
 DYrAFAIiYtL1dzLNkFMDnd5A3e1TwHMdfwZwu3NL1FWb1rgU5BfcS95EII3lrfH2oxA==
X-Gm-Gg: AYBFou3kshAwN/SYAfVHWtYzx5Y85MAh+wCy8mBKFKLnON/iSmMzhmotiJX38jdNIud
 Cvk489FTcICi0hm2cMfPDLod1JPo/OkQafw6dTyUhZNsIjQT4ixoLwokDGOOru/gqVnFqA6Ilgr
 SCOeYtR52vy6+8oteHNg1lo++JJFZCj7Lq2DQzKpAHqr3wVEi08S2Cx+MRj/+T5+SWx6krodxYI
 9xCwWZyOIoNq8Zl/jldAUYkx2zGZcgjz+Z2Qp8cBFYr0Ur5rrOS4WZ/1XiI0QtMppqn3O/aI74z
 SLiQboIHyngDUwQrzE0sd+OHDaCQ+L0A0KAgBmnzAlp1+J8jox2bnvu7zzdVKlaQjxacvPD+l6M
 GDFku0A0TvHa+qZTMiSWlBnI2oRSxwswLvjz831NPPJBUfhK6Eh+8wwOg1E6b
X-Received: by 2002:a05:701b:2413:b0:148:80d4:84b0 with SMTP id
 a92af1059eb24-151c30ed0e0mr11899006c88.23.1791226514008; 
 Mon, 05 Oct 2026 11:55:14 -0700 (PDT)
X-Received: by 2002:a05:701b:2413:b0:148:80d4:84b0 with SMTP id
 a92af1059eb24-151c30ed0e0mr11898974c88.23.1791226513436; 
 Mon, 05 Oct 2026 11:55:13 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 03/22] system/meson: use stub_ss for dtb stubs
Date: Mon,  5 Oct 2026 11:54:39 -0700
Message-ID: <20261005185458.405929-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tp4OvM6gTdfluKNQy68Y_51RXvctEIb2
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac3f293 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=DG0srgjjPWtBgymGp64A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX8n0Xbfo5D/BS
 1D6ngIrJmwiMHI1kaj7Mc0F2ZSGh4IqTUr4GiAlROayc8lD42SHIvHIHGvA/cwVh6naDj75paKL
 1oKrXE6kuUqUgG2V2DDB+8t2TeCrbjg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX5kuwQsrRTZsX
 80WQbF0BgtXV+CEJI2hYVK+m6bRHcnOYlM4gv0lZKNurHz3dd9M5x8ubvBIU+T6ss+d6NR6MmVD
 RZGyZhSmwuPNVWCuumk6/jM5a7URBAWi1GusEMlkM5Lazp4USJouVgPD6KUmnXVhfmEfaM0lxEz
 CjNLB0TA4LuRoZnPzXN0g0rW4Ypkb+6mLAMmWh4prfsrQjpiYEuX0Pb5wjqavl0GzIVG7EaSKIl
 p/CXKMubgwCF9i0NB2QOms00HzGqpDxd/axv6XjLwtc68WNfZ2QLEeOh9UBh9+ye42Bk/SgQEqr
 Byn/FrnboPuFfdRtY0nE4z6JLL0D8zu9VCyH2phRJDBs0WlM+AAeGkmMUJXmz25uByZEzFUTLY+
 kGKLwo60DVkxSa6OQDFkNeZh1G/fLkqa3sH6m/6pSiA391gTmU1zBMAGj0nQJBUVjDomn26q8v8
 kOisxPkdX+706SGOi4g==
X-Proofpoint-GUID: tp4OvM6gTdfluKNQy68Y_51RXvctEIb2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050074
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

Remove multiple definition of `qmp_dumpdtb' error, when linking m68k
target with other multi targets.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 system/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/meson.build b/system/meson.build
index 41e2e4a292d..a6ba7a04f7d 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -41,8 +41,8 @@ endif
 
 system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
 system_ss.add(when: 'CONFIG_DEVICE_TREE',
-              if_true: [fdt, files('device_tree.c')],
-              if_false: files('device_tree-stub.c'))
+              if_true: [fdt, files('device_tree.c')])
+stub_ss.add(files('device_tree-stub.c'))
 if host_os == 'linux'
   system_ss.add(files('async-teardown.c'))
 endif
-- 
2.47.3


