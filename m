Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C31CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrse-0001GA-82; Tue, 12 May 2026 14:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsS-0001Bw-PY
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsQ-00016X-Id
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CEJNAB424447
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=saZS87zRahS7jo2VKFh5cz
 pNLN4oO0OpYwAK4OV3T5Y=; b=iB07kQRaHAF1zhXREkMKukZkdsl867REq4W72S
 m96vsLP61hWdjNTxKXvEnd+xbfoqacqTVrW/yB6pJt96yhcAxAH2D+kF9hQA4Zq2
 XBjPchNfxEmZ9CNWu1XiVH3AQvatfd1v9xlMfvfuye/ghjF7PyvGHbEws34usYX0
 6ezJik2asYpemD19b1bWSZzvcc20zN5KHM+EwZtnjjiv2kLsb46BOevTxU5MCXSc
 dikD16gvQsuYgJqT1r2j7zhAJSi2sR7keKTjgnih/Tt5EGIyBzyhkpnnKv3T9/pB
 FdKbiONaq/7KwTIfJzkvLEeESpk+wqMPrFRuNBpP2zZ1zCxQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45v590ts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f485961555so13005871eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778610639; x=1779215439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=saZS87zRahS7jo2VKFh5czpNLN4oO0OpYwAK4OV3T5Y=;
 b=b8OQc0wDh/zSOIXP0Vfs8CH4zrNlMdZDh2D8aDtiNe3iKspBRUk8KcXc0Cu1/mGM/y
 EnPaJ2bhsTjwFjkpq3hKO/dOXZcSMe37anie1/yw5nWBWD7r+f4dyJGLjSOfwymhJrLI
 0IoLOmzUXPpg1tEzZwvDWcztkrNtBh/9IZ0rsiie9ZPXVNexbDV50y7iPjiQPkt09evO
 t8585NQLjvPCqKApXPyBL99q4qr8chUHLJp1OJR0rKC3PTiu3ocssMLbnRqkDO06v/20
 jkiwP2ZF1S505uy5PCIRsWpAkMLkl+j0lYE+JDNcMZhOXYJZ+kNdEWOKs9FpZU/s1sr4
 bKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778610639; x=1779215439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saZS87zRahS7jo2VKFh5czpNLN4oO0OpYwAK4OV3T5Y=;
 b=gCl5Pr1skiXhGLM3sACCBik0K1g0SV9dOVswC1dgo0l0en8GCDVtz8fL7Z+kHtHodC
 iUBSuuEn1uIuQVxTI7crgtoqpZ7wp9AMXLGyhj8FofalWfYvbRYWlyxCDqtKCFkRj2qY
 KZQp5hjGFZv2SWUXa4zVCJ3qU0gIPEmafItEtL8OwSnKAjuvHMQhP2tMzzlWlA11teZW
 dZVv3ie6ZOYUoc4qeZD0QIoIurLJNUGv8uKJdEnGxeUXaNy3ufD7ApLARTYCNaHDBnlJ
 iaDZecCTzgwB5nR+fMuWHSOwlKrBo/zC0kyrGvmi8SIjURvxomrIyZKzTnxv0oxmm9t3
 EWTA==
X-Gm-Message-State: AOJu0YxuZJDFiNZ6jECj9FXrDyP0tlxNZhVFLNFuKrtcSylU4UMceDd4
 BhcCqwvml/+kCrvOyKHm6ocTWZq3cdp9I1lvY63gyGxUbzHIZKDY5LuYxtmA2xapJ1V10h1yXQd
 zSOc9kqfG9I53HE58+ww5GGyyul5LrzxhBjQKENh77yJ4SBi0IWy/IcleuLZqYLg1QNS3
X-Gm-Gg: Acq92OGXQA6nMws7h6k+N+yHl3rxrnHKLyijH2U+4EDbMThZ08w886Tmw1Mg41mVQWq
 kTzH9EpNjszYq4qWF7lnFC6PEtXnIn2ZIL4ik7k9TLl3Za4f11uRQ/2liGojG+uOF3JtEQEsjNo
 bV+H/d6bSHL7P6FxO0H6vcznKfirP3ZUzYHEAnU7sTq+BGVRFn1rQrYo2UX4KC1TM8I8LfouqhQ
 NCp784qS9Qx6m9q5E7F0AAyeuu0KjmvLpKbRJIWBhXSSUW4CDF+o5WDJwQqiiDwTIy2318ZMwso
 SLVPN5+YPKGae4ZYgEhT+TzZ6cAfoSJ06y5vDUAy+Zr4j7Vliqe+Stfp7pLQH6juX43SrS1yytl
 98VMqFdZqjMbAO5i2zXr0Y6AWeCVX4G+fQEDF7GhnqL3bz5tIcdWZ0TFI/vIDFeF/Tha+xNzILp
 ExM/zJ9w==
X-Received: by 2002:a05:7022:e11:b0:130:9b78:b17b with SMTP id
 a92af1059eb24-13436babbacmr46223c88.38.1778610638746; 
 Tue, 12 May 2026 11:30:38 -0700 (PDT)
X-Received: by 2002:a05:7022:e11:b0:130:9b78:b17b with SMTP id
 a92af1059eb24-13436babbacmr46196c88.38.1778610638080; 
 Tue, 12 May 2026 11:30:38 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865955fsm25221376c88.11.2026.05.12.11.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:30:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/5] Target-info update for 2026-05-12
Date: Tue, 12 May 2026 11:30:25 -0700
Message-ID: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5MSBTYWx0ZWRfX5wHcfeuuLSkD
 90tjRinAzJh9Lu7NivbIIFDkgTpUtXWJl/gSgMgIAdIJI9Z0MupoCKfnkGzGo0bVfX4XuBtTs/r
 kTuAfEpKRDjaBV5SpGsWtq48Jo2rH5+0mj1umopbwZoA/kvenDVaF8Bro7j903vpsIu92gRXsSI
 26Y0Fve72zowoJzEOXNF21eBv1nNCQmAw9dzMtlyDvG4oFH0+H5uPq1x/aUojeB6G9cEq17Bx72
 HDpuZF8uIpMpdJY362XSwmKBYLPRHJCXditCyRLH1SBTdX16Js4IMrBvg5yjXvFXuv24r6UOdCJ
 NEoaJLWFGABetFrMZMuum3aDwT11Y43qBNHJX2i20+nmopPyjWeDVNmAnWfdbbk3RHyicmSxJss
 unwCcF4YVSzOfk5Q7K2aLqV3lq8qDCsCzL+xYMuPaOaWmaHWfnj8pA1PuxsFmPx05yxW81UlkCP
 z0hs2XKa97ECPnTc9Lw==
X-Authority-Analysis: v=2.4 cv=GZ8nWwXL c=1 sm=1 tr=0 ts=6a0371cf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IVpQVof7kjQRdDbqmGcA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: n5CM-j-8Q2HfdFn9C35bY19crm1eLkpg
X-Proofpoint-ORIG-GUID: n5CM-j-8Q2HfdFn9C35bY19crm1eLkpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120191
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

The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/target_info-20260512

for you to fetch changes up to 0fc2022c6331c5d5bdd9060c73d067abba3f5515:

  target-info: replace target_info() in system-mode (2026-05-12 11:29:18 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v6 0/5] single-binary: deduplicate target_info() (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com

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
 9 files changed, 145 insertions(+), 28 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

