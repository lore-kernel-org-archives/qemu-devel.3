Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E17C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjL3J-00036K-80; Mon, 13 Jul 2026 14:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL3I-000364-7Y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:06:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL3G-0006dT-Dy
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:06:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8MsO1803589
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=B1kgvnRGdskG5MUnwMZsyu2l2z4Kt95iw5g
 cm3xymfQ=; b=cSZYdkTE+Mo5x2FgatypLWph/w0n6LdAnAXSCRI4YSIwxtv4S+i
 1J1HUdfVd4VYD3RBBUwn76SOcAJchE2SaDpkSw+5SoD2gaDl2Oqut+N2NfbG2/6x
 UaJfX1wi5XtwpRGwyRmAzhYxxl3SDd+4XXCpMrowsfEAzKpJ8oUycksx/CB9u51O
 JdyRvl9cbRWRfpIs323eJgfLScBqi4ndSPIBK3Rt/KS1ibJAijg6rmEijjY5NZjM
 LQ9qpVGCvGHm2IUyw+RDCPW4wX5ECQKV7Q9kLh7cno2Bk9HWJJl64xJQvUM2mPvN
 IxVxxUmtvJV74kLqPu/1W7q/Kdo0t6zRhmA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4sy97-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:06:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so115483a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783966004; x=1784570804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B1kgvnRGdskG5MUnwMZsyu2l2z4Kt95iw5gcm3xymfQ=;
 b=VrCaZU+18l8zo0LFK2LYSGfZXv511C2Tnr7v7r0U/Xdr6bIIXLxWfMdnEEb+IG7PGj
 yPrtpi5O+dusAOJCooofMsLOimE2Nd3qlX/hPas+wPrxrpEp768Gk44jYeEJBZq0aE0K
 YBW//T9yiFl4bOzxfK2fE8KR9Y7MuMN7Xlj0SZQwjXWU2wtxBfwkSAo6vtxxiJ+bRFil
 5LNyp7JJIAUj4pQxghlh8kTeT+cM7UsD0gEdw4SI0QHFWYUnsstKjahIC2ldLIWaodsE
 x5RmEjAJJ1sxf1CL79EKOdSWavIvpni045rPaon86JQsEG0I1I8T3MDPbfGigO7hQD9l
 k+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783966004; x=1784570804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B1kgvnRGdskG5MUnwMZsyu2l2z4Kt95iw5gcm3xymfQ=;
 b=Lj+r39UW/nCDjCiNA9Urt+XV7qTrKiYi5Y3zBzDtit/C11tpXIp3a8OzQMxigWzOIn
 28sDwKzII+LvREzgG3lzZ5P5E4tSUcum+qck63k0dCOJ5pj/Skxi/cMPAt/Ax2w8g+et
 Q8aIlCt5MQnlod/sPj9svvCkwpSoeNMMmQs+5qZcW/P/tqLgtRfULyoxw3dxznHvtpai
 3bbsuNxmKPeCPmCs5YxFXPFJc8WDUwms58JNX6wyImkwwMegRS4PH+WZPB5CrJj4yVBp
 qW8P+HiMrfKMkadRXjYnU4Vh4PvKNBA8pIsPqfRmYGqlL/4O9gjzsasWYc18Jefyacqe
 Qz1w==
X-Gm-Message-State: AOJu0Yw4hNta8s9ZhqSukxIU00MRipdqlMdZ6x8YNxqGrlX8XuYs0s7p
 TLvhPyrQ4yYZgPEyX5oEnS6xEpnbdqtqvNg/OJrYG6Q3a6J6496PFW7ccbfYHwDP/iFnUPQz7IK
 HUWwYxBUrdGPR/mgmmYuLqi/cFNS/keLsHRTMD2QlVmYo5EUD2m0MIoU9JxmYxHMeNA==
X-Gm-Gg: AfdE7clZLq3+tPSYYD1to+dJXOGJbQ/idwPsEwnS5A1LFNeyIb4tU8sY23L0kxF9I16
 NlDkzBWNAhLhu0CmEhfaM+k8+wFddQ/LLqNTxDnTNZp/81vPE46WHuMWeMZnTO9qrkEMbiEgw3C
 GRvpEQv5lALbzSAYCFLfgU3yNA/GC/nIUrqU2mGrO6x/nexrVTM/icBDEtJkoNQglZVn/W7tVxC
 lTXDltKjWNAtaP/wU00domrWYoq3bHF5pqF/L3AuRR+V6wKBvduzCETOq6/xcjDCGzWV7vZk3AL
 RH+MW/NZkY6RJ8YzUuSLmrpFCk8CDrcPWwIcXUJ9e7/VKP3M3t4v94O26HnWfNYCJwmoS6MA778
 flS9A/2wYnBJtNqn1NQApesB38lAn0Mf3z3TQbJzl5FKv8EzKaqcoJBs0kMXt0QuJHdp1tkJOAM
 0p1zLnfw==
X-Received: by 2002:a05:6a21:4c13:b0:3c0:9c19:b270 with SMTP id
 adf61e73a8af0-3c110bad8ecmr10607834637.62.1783966003648; 
 Mon, 13 Jul 2026 11:06:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c13:b0:3c0:9c19:b270 with SMTP id
 adf61e73a8af0-3c110bad8ecmr10607798637.62.1783966003187; 
 Mon, 13 Jul 2026 11:06:43 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b8a5992c9sm27501109c88.4.2026.07.13.11.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:06:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/3] Plugins update for 2026-07-13
Date: Mon, 13 Jul 2026 11:06:35 -0700
Message-ID: <20260713180638.2228609-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a552934 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=dZbOZ2KzAAAA:8 a=wOnHEsHB2rFzI8wXpkgA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfX46EvdUOu18N4
 tkiyQkIHdXZR9P7qjDv6O3hicOtv4+yiZ7DjNO9jW0uQHXhaXtcI2epQ9XZDcHe1PCUz/XWVHWs
 BPq506eC2H9QNDgLtKDi0gPuz3Z8OFE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfX4JGOJcKXGpBj
 RmGOPS3tBLOXOlsSUqtgLQcskqjZYNfUNPlJ7EH6V//qooEeo54CAITpb2mN0BPNM6KHWeHoWmj
 F9sTCAt0+dzkCZSoiDeDZfAzTMPb/BBjhajDXHs28ur7eWC6HDEgTllHlLj6KZldPb6ot22zS2X
 q/7gfp42KtZZo9t7cmpG6pjN+dnB6gqugzrnp12wjLc5P1AFQaHjnsXxWaRiBLV0hQJ0EGoCVZC
 b5fOTT3u6kWOGw5Hca9LkP2rH7yNRBWIWCprZQNdWALBq8Qdr6YNhH05woUFl3WEk5Zh+9h5uuN
 AUJQHGySaEesRfbQvYQICxilFbvW2MeyQ2XLQCll8iefYjG0XaS3HKO/VtYnLhjIJk9sS2dK5fk
 I1P969fasivUolx61PQZLiUiybZRD1k41DIrAyUPEaGQmJYW+y0Bm1K6KS6s7o6I0pXJb292Iy5
 uTVMQAxl3e5qAdHoBwg==
X-Proofpoint-ORIG-GUID: 09WEDD7bBSgWbgZ2ITT8sMYKA_RwaQ-k
X-Proofpoint-GUID: 09WEDD7bBSgWbgZ2ITT8sMYKA_RwaQ-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130187
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

The following changes since commit 499039798cdad7d86b787fec0eaf1da4151c0f05:

  Merge tag 'pull-request-2026-07-12' of https://gitlab.com/huth/qemu into staging (2026-07-12 21:49:04 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/plugins-20260713

for you to fetch changes up to eee8e58eed452fb8a7be4fd9c7868d0512abbd6a:

  docs/about/emulation: document the dlcall plugin (2026-07-13 11:04:51 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v1] uftrace: riscv privilege level (Yanfeng Liu <yfliu2008@qq.com>)
  Link: https://lore.kernel.org/qemu-devel/tencent_E17E8F6494EE130F71527C6BCE481AF33E08@qq.com
- [PATCH v12 0/2] contrib/plugins: add dlcall to call host functions (Ziyang Zhang <functioner@sjtu.edu.cn>)
  Link: https://lore.kernel.org/qemu-devel/20260711094523.622997-1-functioner@sjtu.edu.cn

----------------------------------------------------------------
Yanfeng Liu (1):
      uftrace: riscv privilege level

Ziyang Zhang (2):
      contrib/plugins: add a minimal dlcall plugin
      docs/about/emulation: document the dlcall plugin

 contrib/plugins/dlcall.c    | 248 ++++++++++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |   5 +
 contrib/plugins/uftrace.c   |  13 ++-
 docs/about/emulation.rst    | 158 ++++++++++++++++++++++++++++
 4 files changed, 421 insertions(+), 3 deletions(-)
 create mode 100644 contrib/plugins/dlcall.c

