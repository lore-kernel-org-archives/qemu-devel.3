Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89296607DDF2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X1swu3cc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CNJxDFJ2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9OY-0000O1-7J; Wed, 25 Nov 2026 04:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9OH-0000Me-Nm
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:34:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9O8-0002OI-Fa
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:34:10 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9DniA3682014
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HsI4sPDDeo3JamQ8jIBGl+
 rh4T08isNylf8i9hVQY0g=; b=X1swu3ccNOhftw7L2UYK3q7AQKAKEqMp742pId
 qgmmYSYQPs9HO+WBWub1vNggS8pHJxIiueB94j1N2mzTOvt/U2N1nsrb/Rjbw9s+
 47MCkjaa1WT6w92g9tOeCeszD0DiVA4UzPei7xnztX4Sf+FamCQLmgcpmrxRJvj4
 9edZcwVzze2zA27k5kR7ZWlWvL00b1/qS2jiq8bV/9FFaQWUQjFbMFjNpKMK8CFA
 2j0J1d1uoVRzREnzRIJHWPurL17TgIAVDp3fSj+ryBk7iItPHWDtqQoKCoa0xfYx
 3Gq9R1M6Aa49wFiCnJ5/7dGf+NyhDFcKaadOn2XxV/5GHnpQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vv2r3ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:33:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495c71055bso157108385a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795599232; x=1796204032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HsI4sPDDeo3JamQ8jIBGl+rh4T08isNylf8i9hVQY0g=;
 b=CNJxDFJ24U8YKUb0uFNQqfSJ4WSPVd91g+NkjdTyglR1xAz/VczQSdGQIWYE5LT5kZ
 R1mP/JDT3XdktbCRRTi6sOhQ12souUBO7YShhuRLBqfHfS6ZfWs28ibmTBHdepdOxQ83
 uLKZ1Lvd2LQgW8/+hVJy1g3ALYzZEWbOU39Q+NhDtdJBX8td0YU77Fdvq+b2VMv+S6Ca
 zByGX15c4gmSY4oAEWOQsWpOsuJ4m5rsVdHgg7Y8r7fby/p/SvDlcwGCJXlYQEqAs5yK
 osQ72XExqbZy0btj4vp2Yw2j95RTgxRwJkQxQpcOF2gZ4tB54dLQfd/0O2rwsppN33f8
 M/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795599232; x=1796204032;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HsI4sPDDeo3JamQ8jIBGl+rh4T08isNylf8i9hVQY0g=;
 b=EYP99UAfKsN6JxIB5e25gMgzJflt5fJJIvXNxdcelBf3zetq0eqn7PdbYOaHSw29Dd
 +tVQaxFuj+PHrkjkHxHza//CvI5goRKAf6uxuFBMHrDpTU/7z2mwancaVm9fIqfUYlpg
 uagxf4bTv9kif4L/KHswTa2LilYcnLqqatT8rWox8s/tVAAXrwGgUXzjnFAlwRXJFqrs
 RXc3u22y4Een+TN7zSVxG5DKO9fdp5AnFpXfqRc5rRkQ0VEDF02qQeq8cYtnH2wkAoMw
 MeJVC3KoygWT+kPqCBiV+RUYfVfHjM7cCoQS21p+ejbGcuQ3mmy7FmA5JgnOacNwW0Xt
 QvTg==
X-Gm-Message-State: APuU4Z+9TxswwDaAZM2Zxc0db/tSjtL3KPppmW3V7LGuCu3iZsUUiImN
 Y7wal4Z6R5YOLglNt+79BT9IkoYdMPTY8FORQGWWHJ0MHjm1plgLBcQz1TmE6UymjSfYLJmzh7q
 MdeUJYQpIn0TiqjHEARDDp+294wN/dyMmqrC8Wr9Q14D9fGoGyz3fGI6vAPTRweW6g6Qi
X-Gm-Gg: AZFdTZcLfFJb2NEn2NKeseYSrgyWOyeSFuacJHba2WCiAL7H4/tPkAePyUsqR+f1Dpw
 mDsCVzB3IUunHHfdo4OOcLn/IbPUP+vOcynJoadzULYSMETfzNszFegzChxCxPxM37nvPPFi7S0
 4rAQJcOhiBPs0NrxFCRZIs9AIJrThmP1BVZLlKIVWNAmJmeNd9jRQRWkRZWvmOyIfzofdsOGrva
 n3d+J0HTd0g+ot4G2wGCyyd6boInY0jicBCp9VYCnMA1KhaqPNJytQuNILBIOrLiur/q01N2pON
 SpER8P8+nUxNvPLu353UAPBKsyyWzmbHulrvrcu3rSiemo7FH9FZVnrQoL39uVnjl23yFDGrQTi
 SJcH/zYdaFdAv7zcvyJLWAept2x+ZYwtWvvwbXjPxaZBZO2xEQvxs1ygSv5Wv3ec1bknFBnU0Bj
 B+z5ehkSefAM/20A==
X-Received: by 2002:a05:620a:2906:b0:93e:5eaf:dd87 with SMTP id
 af79cd13be357-949bab54b88mr3066742985a.62.1795599232472; 
 Wed, 25 Nov 2026 01:33:52 -0800 (PST)
X-Received: by 2002:a05:620a:2906:b0:93e:5eaf:dd87 with SMTP id
 af79cd13be357-949bab54b88mr3066739785a.62.1795599231956; 
 Wed, 25 Nov 2026 01:33:51 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989eesm33254235f8f.50.2026.11.25.01.33.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 01:33:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2? v2 0/3] system/memory: Invalidate TBs on ROM device
 mode switch
Date: Wed, 25 Nov 2026 10:33:46 +0100
Message-ID: <20261125093349.97805-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfXwmigmlJzdOib
 0cqLg46O3U5KX1UBywtiA7eXHt3VeOeVlyna6WPXlrzYQNhXKBpvckhfFk1+PfAApkMMQPfTgYG
 tnYfHwArIap/W51hJL+4Y4MJLPWT0ew=
X-Proofpoint-GUID: TGW9ydH2AJdM-Ys7d7VlkBJQA1Nrh55d
X-Proofpoint-ORIG-GUID: TGW9ydH2AJdM-Ys7d7VlkBJQA1Nrh55d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfX+6W4SaIA/YOn
 iBX2aUcm2f5/vWxIS1B0C0mU3CUxm6nH/7l5fu4sm9plAP01N7P9Mpv4usNhj7glQJpn1omFeaI
 R/Uk7UqeCaeL3RRBRt4VO19rDuE3jjv0ZTbvHkEtcBB0CMiW2TcnPKZY/DiGthOgj1248howqYE
 bmurJ72RVw69tErNAx6z49vwYeFJo10m8+xh+w48+VdwWFsdt4e7akcRRiSCoCfsV/U/vQ1vTqw
 MXhf35T2rJyKq1LjwZcZc/Vz8SPAVdfG0/2vo+cst8z8n9xrTLv/Uc4vX9eRSZAelEVmYPit3MV
 rxNOtwG4ii05w9RPmV0xghUA1sr2VLYfUdxl5kfTxs8o+IP039R/roRxTBeM85EvT+o/pFwWWfW
 j5J/r/bDP0lPLnlceNonp1sMN6pv00hWxhhIgp4pEMg2c1rXxApT0F/7tUT+ff0cWgncSA8dL6X
 af2CuQjrFkbxEYmN1hw==
X-Authority-Analysis: v=2.4 cv=A/z5rKWG c=1 sm=1 tr=0 ts=6b06ab81 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=YVC2wF5cfVuM5J9m9TwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250037
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since v1:
- Docstrings reworded (peterx)
- Less convoluted logic (rth)

Fix for https://gitlab.com/qemu-project/qemu/-/work_items/4490:

A ROM device changes its contents with direct stores while in MMIO
mode. TCG does not see these stores, so translated blocks built from
the old contents survive the switch back to ROMD mode and the guest
executes stale code.

Make memory_region_rom_device_set_romd() drop the TBs of the whole
region on both transitions: before leaving ROMD mode (if currently
in it), and after entering ROMD mode, for TBs another vCPU built
before its TLB was flushed.

Measured with a guest that repeatedly leaves and re-enters read-array
mode on a pflash, once with no code cached from the flash, and once
with a function in the flash called after every read-array transition.
The flush is almost free where code isn't cached in flash, and costs
about one retranslation per cycle when it is.

Philippe Mathieu-Daudé (3):
  system/memory: Clarify TCG effect in memory_region_flush_rom_device()
  system/memory: Return early if ROM device mode is unchanged
  system/memory: Invalidate TBs on ROM device mode switch

 include/system/memory.h |  8 ++++++--
 system/memory.c         | 19 ++++++++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.55.0


