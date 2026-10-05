Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B753CA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnsQ-00013Y-E6; Mon, 05 Oct 2026 14:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqu-0007lW-9k
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqs-0005p9-HD
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HKpcF1583270
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yzdv4cCWZoTCwiTiShDkZQl4EHwqcLPQG5Mwz8slh08=; b=lIDeJRIhUIXj8DI0
 AXXbkeBzruTyyV9QTzOtV/u3c6hsf7MVQ6Y79UzZi1YxKQD4KiyylqtNJFml4xBU
 vkogawLxEmgdOnAqSERrP+lbsCffAlUAqFYVuqCl/XcMd64n7iXfPKSKqHZKzJ9L
 dqlU3kTaYUObQvlS0SUAjEu0rgESc6ZlhNqRn9Vm0mZ/9IDW/INFuiwez+icn+8w
 noev0pUXWpWj3bFMp8LIruJ2Zxyat7/H1OK2Z2Dt6krGkVCh9rzCBMUmX8gXeHjj
 qtIkgQ9HlQ+agpchQJGTluNEpVjpDWv+CP31LMKlCWxtVklrZpvsFpC8rSUCosE+
 njWsWA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4fkugh7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:43 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso3262580c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226542; x=1791831342; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yzdv4cCWZoTCwiTiShDkZQl4EHwqcLPQG5Mwz8slh08=;
 b=hk7N8mzyriTYluraHndolA6ruBlX8+3BzZoiuU1zuMIkxqLIlk5PSB/RZ0VJ1Tcbmq
 mdhg/SZ6HJAh8UobMyyjwhzweI89+MThJKf14J7dWOxL8qnteMgSuluDi6VMuZKIY2as
 ANQiGqaWag73zuM7QWGUQoMNuFfIdp74MHjiPyoegth/MPo0H4fI4NbVArN6BY4dN4Tx
 OeQY0VmYKTIxIpzSrhkk3VkrNT7ZTmg5JdR9v1oIkfqDBhBMvwEe9NcqhHZUQh3wUxUo
 +lN+0wjJKxqt9hzoiuS0AYz6jBubL1Z4bYefrEE+xYKNmKbRREwBdBJBef1rfTbI65xc
 npQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226542; x=1791831342;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yzdv4cCWZoTCwiTiShDkZQl4EHwqcLPQG5Mwz8slh08=;
 b=lbsslae58WfF8FzY922KB7CorcKLLa/H0pT52yjwNw/xDBaRxrkMibxuVRjmA8/8tm
 ZIf6Hd+RrVtWQAuJhCypWDlsjE0sSevxLtLAKN58Gs5A6bEN42avcmiFVkhIrcJMjl5R
 ClzkhUyUTLlvH23/N0ab74mytnf73viXaxHPL0kef8jILnIJWlpbeuap9nvJSYBfminh
 zVltrriA1UhnaeuupvC9utTM7QmIFnTlPMD1wBSv1GRP4a7xUrYzU9DZS+tUekifuL5B
 MNrlb8sPE0u4gh8zqLVoS8T0ol+7S7G8rv2faSeFEwvw9vXs0hh5Lxdend9xmGv9GHmh
 41iw==
X-Gm-Message-State: AFuF++kgzrnvR6RYyL3GQsr4JzrrQJuZO2hikSTK8/CsocxSwzBCKtSJ
 7Pp7jOyAjD5U8CuYkHmLfTy03DRMcfITcDk4YBSb9HrX0/1iC6hCefHBHU+FAMtqLDg2AiHvJKs
 vJ90/0ABUrj5+/Z3IHxEjIeWIGIm2MgErlLgRShTv8TaYQnuLHReh3iyw3mFeNz7Tzg==
X-Gm-Gg: AYBFou2to33yl041Cd2yTRRPUcci9C7oOQ9+7mOqoU+NbDQslcOdZWScLe3Sj1Ifmvb
 9L0VHdHYawhMN+8rbl557oLgJ0ziXBHCcMU5XwDW3MWTbkiTnFUSr1L9FrLhtJiT3snKQTAPQ09
 MQjkKeByPsS20uySTMxQM8Mn9M1RLihHEEx5MXVNu/Foyq4pt1FZ5euAnHYwwGTf6lsYeECQ5p+
 RBkctius2HAm+UNrwCK7pOxGekQj12rxC/HVW1ZcbjxkrqpX/acHIRvVjpf6LbqixeVp45U3rLk
 vd0iXoTt4h3gHEr21BpTfDWZP5dpwAy/VVkT7nP2Ffe/ssBPS/ZFjGOs6knK78P/5/EFWam0mfd
 lqWbBoYZLGPPUIW8LUn4T4KIYr6vIaN/IPRR+P4TrcrNFOQeraL0pjCwlYwuj
X-Received: by 2002:a05:7022:7e84:b0:143:8865:cc7 with SMTP id
 a92af1059eb24-151c30ec63fmr12339063c88.21.1791226542231; 
 Mon, 05 Oct 2026 11:55:42 -0700 (PDT)
X-Received: by 2002:a05:7022:7e84:b0:143:8865:cc7 with SMTP id
 a92af1059eb24-151c30ec63fmr12339035c88.21.1791226541677; 
 Mon, 05 Oct 2026 11:55:41 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 22/22] ci: add multi-target job
Date: Mon,  5 Oct 2026 11:54:58 -0700
Message-ID: <20261005185458.405929-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ac3f2af cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zTXboHLKykkbUYI2VpAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: 2hGuJHgDYlwuZH6fnXouzRy4bhQT8Dat
X-Proofpoint-ORIG-GUID: 2hGuJHgDYlwuZH6fnXouzRy4bhQT8Dat
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX8BxfQ49BO+c+
 rIH/laubym4fMRbzGjwy9Y7NpKRKhTWnrj15GzzMFR4y+2Ddv/mNarwn8LXBNA7TgHBh9UMF9+r
 4q0scP+wxApPWNA9umW9rn+z400wCy0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX+n5Ujitowv1M
 EsQDl1Cza8cQvBLtQPHWfVHcwMtvV1XwmPjD8cgXHqReDsIcjKGwvLrwCuSsU1HIIcL0IhRCZYp
 Hj0GSaP2bUXF7/hm8ziZt20B7Dq+4doBRRsIkNoM+TY99rb+NInd2f3arb50wGagQIFvhbfFd40
 rfMf95e/TJ3sMd6PYJOxj6+Tl9fI9XrslV9Z375Ftrl4FetGPosdLIt70Gaf/MrgDh4rhewzg++
 sXo6T12W9xfk3eLZhyOc9JfIRlb8784S7X33UICshoTc4BHLeQ2fwJcAbiTfc9rC9bQiPPNZyQW
 t0w7YfbUIWTNId88kEAkeDFkMH+fuMNu0MTltDX2RbNj8vm4VMQ2bcXFJQvzCPcJ5xNcltCZBNT
 7ILh0v4DEh89sTvxetMyzcIMLCF6354IsqhHUxowfN15GDiTAPLp1adeRM1cAp7Jdcick+elTYz
 zoafLDk2r3HNSDNvPSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
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

This check ensures we don't bring regression for all targets that can be
linked together by building multi-target test. Also, running it ensure
all QOM types are unique.

All compatible targets are automatically detected, so they don't need to
be fed to ./configure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929183320.2960-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/buildtest.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a97cc0b20b8..b1e95395d0c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -659,6 +659,17 @@ build-tci:
       done
     - make check-tcg
 
+multi-target:
+  extends: .native_build_job_template
+  needs:
+    - job: amd64-debian-container
+  variables:
+    IMAGE: debian
+  script:
+    - ./configure
+    - make -C build tests/unit/test-multi-target
+    - ./build/tests/unit/test-multi-target
+
 # Check our reduced build configurations
 build-without-defaults:
   extends: .native_build_job_template
-- 
2.47.3


