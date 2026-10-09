Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF568CA9EC1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJ1s-0003Ax-4D; Fri, 09 Oct 2026 18:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJ1k-00039n-Ls
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:25:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJ1h-0000QN-RO
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:25:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhrKI3986789
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=etoYg94hc5+CZgh26tD99WgS+nQFmtb6g6L
 67whhwKU=; b=e98ICqth/kKztb8fXFcrzTfZ0uzZKihG4ny9NEKJBy0plhJ+Q5z
 rMj4p84uF6SpKMbnSRSDHwylq3MUpbVGzNLoQa42p8si4hi4kTkYUygNExd4Ku33
 QzxEJBmevBYbMPHiBsIl6LFuJ8yQD5Ew4kQL0n4i/eaW4qSxeEehrkaaC57hBA6/
 1xVVTlvMDnmv7v5MjjdxvDwJY0DcOs9j/BurCozFkeAP562dPQpNnuDDMSQER17i
 bGA30fr73c60ydTYvVvMKjR1dleTQnwWnxxUA+Z/2t4W8JP3iO8pRmgGtB6JsPn3
 oVrhzOjmYKY6CKlf1hYLxWS+4e44tCPWAdA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t70xe8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:25:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso331689eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791584715; x=1792189515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=etoYg94hc5+CZgh26tD99WgS+nQFmtb6g6L67whhwKU=;
 b=hePedfuD/RuCgN+WpyMXTdV9dNSE2/RRTxURCIc1Jqd1BG2ngtZCm2ll4UCFJShDKv
 1qHl6mYFznobQQmcCVbutrwJ0SrP7DCKfyK8yy1HwGYTQhGMMcWFbclyeSuET6uujIRv
 j2XakDHqt+4pLuyGa/PBdo5OadYDfSSF0VRFLmrXHMueWO70RpZ4dsbSvA9l9cevW8is
 gpJ/eODXbQ9lma+/LmSEEHUsdaUMz+EAQ5bw9GKsIJp9MJbQaHPcVjkk2z6iEjVAwhqg
 /C4x6Yi4jWvKviqVMC6yh3pD0XGNHol9r0VtJqeA37v6rqyWJn9bvifzwL5ZlxJmhW3N
 q49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791584715; x=1792189515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=etoYg94hc5+CZgh26tD99WgS+nQFmtb6g6L67whhwKU=;
 b=1g3P16T39KQFzCyo5/+tVsl3coIqvjmQacd5y4os6WpHca6zLYDgWw0AqTp5SXCchx
 Q7oDRx6BCfwu3m3wRTpfHf+yLdWMzk1b2VTEj4oO8TM3lStL3jnmgiIlgvkBfsMdXDLd
 C1yM92AN2jWR6gKtpKmIA7tnwLn1o4N/c6jXPXpCd7atxJ6Rv9Nfn9WTo7OIa48e0Ocw
 e4EWOZeKcj7b5oEi8LdxmIRh3BAmJxZfmJAxs34p0+03orM0xAVSWzetMSo+9XKykaSH
 OHWmEckvafR8C3Vce9ZKKaDWJr+3J5HttOntcGgOlg+sLjICoebkwyKQAeEgf7oogJAQ
 1Zfw==
X-Gm-Message-State: AFq9FYJZ3WvTZXkhO6ZghqPiavAVluy0ayoqDyTK3/E6l03Cd+CmwcYf
 ifBV6wdw1YjDidV2r3y5hlO/ckdSUmJcUB9Jm5c6Mlf+6EyYUamZpD10zmyZpSt+uF4SxT4bsjz
 K1m6mCVm8DUZJijPbYiIDbDGhoDDlsmmpbEEgGTvlXcGks35snROICg6YPYn4QW1T9w==
X-Gm-Gg: AYBFou1spaM3JiXywbWO3sGxDPBzhaih0uCGSOM8VGhBet+Rjo5lFCs7MWxWzFTn9cd
 Q9FTL26Rz2RTuRsGfy/iuWTYF7qVfWdzEPpiUOC0qPeA974ROs+ickHSfbLrltqMztqqIoi7NQl
 AVHbY2u5eccchftWbn1ww67wxhDeIjQ90qzwT77oD2tCuLlpY2XvHIWOa5b4dy3eMWpUItz6I2C
 eOzlP0rBT83fNg9wkksg1+nh0rbZIK8hzzdVvUnu8j2xBpo23XTzEJ41d0u9/gpUUFHedJNp9Dz
 16BTpa4MSRxJSltw8NojHZUxfXZAu3QxQSBv0y5nyR35bAUPrvzNsz/Vw1ApL0ALgBqMRqsKx1b
 tHVJTRxpVRE1wNBgSjoUZ82t0EC2VxWnurpgLivxBv/ogYkmLrbYyNPQzmeQ1
X-Received: by 2002:a05:7301:4b02:b0:339:7572:7b2b with SMTP id
 5a478bee46e88-3537e0f7acfmr5264648eec.24.1791584714826; 
 Fri, 09 Oct 2026 15:25:14 -0700 (PDT)
X-Received: by 2002:a05:7301:4b02:b0:339:7572:7b2b with SMTP id
 5a478bee46e88-3537e0f7acfmr5264611eec.24.1791584714209; 
 Fri, 09 Oct 2026 15:25:14 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca0e64csm9094339eec.10.2026.10.09.15.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:25:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/3] Multi target update 20261009
Date: Fri,  9 Oct 2026 22:24:56 +0000
Message-ID: <20261009222459.32364-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: J4gfc21G7_AGePaU78TtZOInYxU40gPD
X-Authority-Analysis: v=2.4 cv=Mbr5KJ/f c=1 sm=1 tr=0 ts=6ac969cb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=x_QhOHOegngiskChI6sA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfX67COI5nmwP0C
 SPL1nMrTF0mboSMDXPjtTD5s6REs+zSl5K23ZfsDL3NqXajYgVkEvH4NnTjC3PWxrGKI3Kifl65
 HQ2+3vQCpYROOA6VMNVnEP7eN9zGYBo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfX9Rlf1c2FlMi0
 ijbS2vvlBMvAFXfg2xE7hKI0mYaHRS5Kd6hCtBTCYksOX1nI5i3+TEkvGUqnX+moEe5CgfDSbhY
 sDtNLPzEHiAlOwLGuj1BkpEBwetyc2HICjqopLpTlIQ0cj9u+21QPaQq/uMbzBpyQgj8mK+c5FQ
 9OfexPZTdNTD9gXh/SMvwg5ezCCCBD12RrRob1V/dwlMSAEYGaWvImeJmlMQa8/yrbps5O1ZpQa
 eGTO41rUIY5bcEp6VkxDKXnH6xRbq+cI5hgrS6X3OVx7A7lgUHK9DvLg0ErhsS/KKpdlKvzfUXI
 2NNQhOzBufDL3MyvD7HOZoAHouKKlzmu0KRJhx9kmroZU6pbRoiAxruHpPekkh6hEKJzU+mmo7y
 LuHAqarD1XJsyO4LSmgR6q4hN7dNo9cWJmTx6Pj2mEDtmxYJp7l6uRK35OoRRLNIYeOpzKohF4k
 23Hlv/TbmSzUV8zErGw==
X-Proofpoint-GUID: J4gfc21G7_AGePaU78TtZOInYxU40gPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090089
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

The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261009

for you to fetch changes up to 602f2e66e80f95af4c5f4ea7393fa5f858d9e1aa:

  target-info: rename target-info-impl.h to target-info-def.h (2026-10-09 22:23:33 +0000)

----------------------------------------------------------------
Changes:
- [PATCH 0/3] qom: pass TargetInfo to the is_available callback (Yonggang Luo <luoyonggang@gmail.com>)
  Link: https://lore.kernel.org/qemu-devel/20261007115253.328-1-luoyonggang@gmail.com

----------------------------------------------------------------
Pierrick Bouvier (2):
      configs/targets: remove target info definitions
      target-info: rename target-info-stub.c in target-info-def.c

Yonggang Luo (1):
      target-info: rename target-info-impl.h to target-info-def.h

 MAINTAINERS                                        |  1 -
 configs/targets/aarch64-softmmu.c                  | 25 ----------------------
 configs/targets/arm-softmmu.c                      | 25 ----------------------
 configs/targets/meson.build                        |  6 ------
 configs/targets/riscv32-softmmu.c                  | 24 ---------------------
 configs/targets/riscv64-softmmu.c                  | 24 ---------------------
 include/hw/core/cpu.h                              |  2 +-
 .../qemu/{target-info-impl.h => target-info-def.h} |  4 ++--
 include/qemu/target-info-qom.h                     |  2 +-
 meson.build                                        |  7 +-----
 page-vary-common.c                                 |  2 +-
 page-vary-system.c                                 |  2 +-
 target-info-stub.c => target-info-def.c            |  2 +-
 target-info-qom.c                                  |  2 +-
 target-info.c                                      |  2 +-
 15 files changed, 10 insertions(+), 120 deletions(-)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c
 rename include/qemu/{target-info-impl.h => target-info-def.h} (94%)
 rename target-info-stub.c => target-info-def.c (97%)

