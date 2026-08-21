Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217F1C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 23:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxZ1F-0001UX-BN; Fri, 21 Aug 2026 19:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxZ1D-0001Tv-AC
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 19:51:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxZ19-0002GC-0o
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 19:51:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LIA5N82728762
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 23:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ed76Nw/DyDzFBqoorTBiAi
 zovTnZ9+wJf/FNCvvaL4Y=; b=UaNRaBZh+p6ofQ8hCh7xRq0O6R/Wq+B13pQPoy
 cqFXdNTm8CRtKYl4aL5Kb+9b9C2GRmj/TMHY/lgUUyvKxyGDYQp9IQRRs9W2iCk8
 KFRJXzUUxeBoz6BMEtdxdlQiWBGHsWYD5e1j/P7cjH+Vv/AbTklseuVHWiQPrk2+
 J/EP82rJpLrOH55XqcdH738S4EGLZU/R683J56tDq2fJFB6IA1DfK2U8trCEfGfr
 Ghcua0fJhWPTXE9INxYGFokA4LLASe9S5O7u/47gtDllbH9J8B1C0OQyUsEEIcZg
 lpoixmNQdXtPs79RwL0uYsn+0hTsWLI06lKZCqtIzAef7OQg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fue3xy5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 23:51:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so2505874a91.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787356279; x=1787961079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ed76Nw/DyDzFBqoorTBiAizovTnZ9+wJf/FNCvvaL4Y=;
 b=eAT3o2RaOLu4SODpT7m9ebi8LkF631ZFM1B6c2/bJYMCG21T/FV3jk/TeIId7yyndG
 JJBEMajG1UYhw9FYbPFmhRTdMTg8H3gCtu3phmw0+GL0DgRAzKMPj+iZ5iUDR6bNcQXT
 HYGCwI7qLOzSbjB7McxmljWbG9LXYi7Ab3J1/9wOHKgb+L8EQuQX2phMPvSjOkdF7C5N
 dY7DzRkvVedEg8FONqzOgA/9miAmUVyaAO+8yNiNosoZp4fYzkWIo3cniSTuPB6P5Gri
 LWXpL1xlVAJod0/vPITx7K3H0obBVR7OJRJ9W9QJ3df0fvYu8JAT0+GWgm+7qhSAo4pc
 G8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787356279; x=1787961079;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ed76Nw/DyDzFBqoorTBiAizovTnZ9+wJf/FNCvvaL4Y=;
 b=hSK4ro3XFmdpScKnH3d0/JY774aU8qaLILpVfyv/5a/SJ7bkttr2E6/BsYnSOna6wX
 aISbfx5Xmo6rFDv0gukU6qXW55rzeJNEWwNYE4JinzM3VqhbhM3ycXEZeRrytaALL9jP
 o2jxorv5Ho0m3gEWRSBPnDaSMq6cVGiS9WTg0gISqenDU0SDfexL4b6mDnkcEhaH+GdF
 muSfNqqsGlfNMnUKFAURGLb6vLetT6Ps90r7IgmYIW07sknGKb7qnVEhORU5Sn0GgWE2
 Oz2xdnYKaAlM6CoGEfEWIV4G1dleXf/0N4bW+Q3BN+sIrGPHHtxos9n46JYR24kfWFLC
 1Wgw==
X-Gm-Message-State: AFuF++lrZ4LfOg5MPsq37gpzd18+0Q9W4AiBR+B/keLpQeVdis7tOvIG
 36o1T0btCUFt0FuRCq06ZdWG943yE+sPz9zY73Vp2KsWWV9VS0KVGWkHR2Ehly0n+vjKVmHaa91
 3mGySIcwwmYJoOST8RJfAKoX+Z868U9ox2IdTFsfuOk5lqhTdh2VS1BumoEuX4r/Xkw==
X-Gm-Gg: AR+sD11wK8BBBFJRIh+kdW2J/Ea7vd8s5V1xsrDyC9inD3Mb6jK/233FkJG3di/xDot
 bLF9w8GAhx/K//ylMadxFmVUZW3GqecBkmROqZg4Vd4olb2hPsMf4DkshhKGzyNCR974sx3ZTmM
 daieY3iOaNQ6dCxW/UcSurwT9LpZOFto8Lc6KNfSAdSbdzCNv0dnCJLiOhrlNz6rW+fPXl4keBI
 xDiF0MN4V3QfLwLjj26GaU0VCbk5E69lBEx4SPE+8lRh766AkvTW5bX4A3l4GcQFbHNyhkw61CF
 pqrDKRKqKlR1GfvGldvoXMjbuo09j2it6eoI9RQeW7Kimk4OfvAcTUaHNLok+ABbJg6V2gsZlUD
 MunIzNZGm9wdgGPpaDB/V801mlbHaZcwwzqzCtzkepVwOg0PaRJy80dAFN7c=
X-Received: by 2002:a17:90b:280a:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-395dee56103mr4236118a91.1.1787356279033; 
 Fri, 21 Aug 2026 16:51:19 -0700 (PDT)
X-Received: by 2002:a17:90b:280a:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-395dee56103mr4236025a91.1.1787356278507; 
 Fri, 21 Aug 2026 16:51:18 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af6e88sm605618a91.9.2026.08.21.16.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 16:51:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@oss.qualcomm.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/2] single-binary: implement dynamic filtering for machine
 types
Date: Fri, 21 Aug 2026 23:51:10 +0000
Message-ID: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE5MiBTYWx0ZWRfXyFQyuZTVfZDA
 9LKobZYj8U+qYQhIFt6ytqg1eOoXKN7ZeRUiFsn+tSZiRicX2HAsfQocsny9zOJvyOPhj69FbwR
 4pgDS2IWz0uLAEaABGBMuhjkqm/KoPI=
X-Authority-Analysis: v=2.4 cv=U9+iy+ru c=1 sm=1 tr=0 ts=6a88e478 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=2nS6yAJAdke8P8xKHAsA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: ekyzaGkJFv-gPqCiRHew1TXgNR8Ramll
X-Proofpoint-ORIG-GUID: ekyzaGkJFv-gPqCiRHew1TXgNR8Ramll
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE5MiBTYWx0ZWRfX7B0Hof+WKS8B
 ZC9bu2KxE12d5nHZar/TDEyRUp1xXRwzqMeo8E/pIZMHHXRg1Tcczm48GTTJz2xtlCxlJsNXr9/
 DuBnt0PsMTPzJh0q7Nvli51r5btHnGlzGOjUHdU0j+t68RkZlK4BBWXIoHOJhSMyjiwJXSgaB90
 JyegXM2dI1b3mCsKALwwdEB3Vdg/9/GuMBz69wlq+XFta8KWIpSqXvVRrhPI9GO7KLy++P217yk
 ujLFt+c7PxmAcp1rU5Y/0PtJb66G79pk20qOQGLtQsBixnHngAfgB3XZrRVuxqcddvdgbcd4j8+
 h6vyDAXytfZ2X96rn/BkQoBr64UoTNi40N46u6GQMlTGukyvPKiMi+fdF2/5M4V/5TE/xVSfEeo
 wGpH00z+yuW01m9Tyclazjgar/aLvNTjB0VRBSRNvAvmenA0GwJJwAZGGL7l6a00y+sF26fjngX
 uUGeXxpTSNutBzvpR4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210192
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Now that we can link a single-binary with at least two targets (arm, aarch64),
we want to make sure that we expose the same set of machines (later devices and
cpus) than target binaries. For that, we implemented a static filtering based on
target interfaces that each machine will implement to declare which targets have
this machine.

However, we discovered that this static filtering is not enough. Indeed, some
machines and devices do not depend only on target, and their presence can depend
on Kconfig or host/target combination. Thus, our static approach can't work, and
we need something more flexible.

In v1:
This series adds a new TYPE_TARGET_SPECIFIC, that declare a single function
bool is_available(void). From there, any machine type (and later devices and
cpus) can implement it to override their presence for each target.
We first replace the existing static mechanism with this, and once done, we
cleanup all the old interface. One nice benefit is that we can get rid of
config/targets/*.c files, which saves duplication.
In v2:
Suggested by Daniel, we share a list of requirement for type to be available,
for future introspection needs.

This series was tested by comparing list of machines for all qemu system
binaries, before and after this change, to make sure we don't introduce a
regression.

v2
--

Changed the design to use a list of requirements instead of a callback.
Implement it on one machine to show usage and get feedback before going further.

Pierrick Bouvier (2):
  qom/object: add available_if field to TypeInfo
  remote/machine: add available_if for x-remote machine type

 hw/remote/machine.c        |  3 ++-
 include/qemu/target-info.h | 11 +++++++++++
 include/qom/object.h       |  5 +++++
 qom/object.c               | 10 ++++++++++
 rust/qom/src/qom.rs        |  1 +
 stubs/meson.build          |  1 +
 stubs/target-info.c        | 11 +++++++++++
 target-info.c              | 13 +++++++++++++
 8 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 stubs/target-info.c

-- 
2.43.0


