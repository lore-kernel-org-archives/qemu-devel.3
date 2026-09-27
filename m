Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E7DC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjN0-0006yw-46; Sun, 27 Sep 2026 03:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMQ-0006hb-F6
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:31:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMO-0006Nx-Ig
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:31:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1LZHf1245918
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=MW8U9byqO+6MjP75GOqtQ5
 v+l8iqt/YKmtkq9N/0its=; b=AxjX26MBraYTJ65/1CGlDvKfVq3LzwFBoCv/yf
 dZy2SjSMqTatsALIyp4twf8LMK0gm4PbLYbwkSIj8IqF2/5BOUaDUWoQL2Y3QwFN
 EWv7jypkV/lo5XwNVeRjCPSdqZrc+xN2WD6S2Rcv/H8boL2yGYLkViamQcrvkPow
 20DikR88FuVGc5U0fWpqTWfPdu0Zh8PVPbkK/l4ARxgbsIoY1w38Z7B1Wcb9xuWm
 Gyc+kYlAY5yOo+7U/o0AeSq8Pp+11sX/HxOvLhIRKnc2e5cOy0S2jaKbL+70jaMf
 soOFi7hSr28BODPDdEPvW4m9eK9yZUokSIxm/msoIncQkjSw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp2udf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:31:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5ab5c136so153107085a.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494302; x=1791099102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MW8U9byqO+6MjP75GOqtQ5v+l8iqt/YKmtkq9N/0its=;
 b=UVNJzrEJAe97CCqWox4T0+H9GYM13qxZiMs6+v5Be4NV9jaKwzMuI+fIqBF7x9UuGW
 zZW2N/4riMxVhM/bddVV2yiS1LrFbAQ5LHcfjt2W9mocD0bz7eVXTE3G4P3bdlQg8yJ6
 DlqxYoPm5cFxYgQoiaXSKvgmp2RJQ5XIYh25Fwzk4NZOoqrokivCsvgA1FL9z659Lfro
 MN+bwdQbDEBquBQ0+2jXDg9MPByyotEPHZPBHUNnRy4f7uz3TH7CxwOgM8P9LGdJLOXY
 ZZbpaGnz3DXF+Uftm6aCb5NOViWm1ZDSyRZqMKxYp3JxQqWlbnf3IFH8W4QvApQpSuZ8
 Fa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494302; x=1791099102;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MW8U9byqO+6MjP75GOqtQ5v+l8iqt/YKmtkq9N/0its=;
 b=HOjqo/tyV8xaPFueIEnpY81WLwpHm84DSsPyG1BuVFDCrm7NUdIJp4TiHOPe/bNOEU
 K1lrpYLM4kXrjGGn1TC+hhIRiZIMgrnsUjaAuHVnmM5/eGTjsh3QlosPPWQtBhlB3BsZ
 w7hAygjqZwg9NfAar8aTSI0mqhs5v68+UJcUYpVSK13IyjSYKRGld7Eco3wZO7YEtKki
 jEwprc7EqmfgTf+SNIsOh2Dh3WbI+gd3jjhnRQUvLUXWsMecwuujakbNdK7FmFCBg32B
 tdJZEhgb5DUhfZBj7LhhjogsgN+L4fJlxOdqxTm8CcdLW1PXkDVDTVmgJJIq8BNvnGuI
 hO6A==
X-Gm-Message-State: AFuF++kkfikkwEc9CCa9mjkmHNnEGg+uXSfQoewATi7hwQOt3s+DJ1LU
 hKNgLepRHsmUVMEpNls80AZtVwAy/kbOwbMIphXGZOkjYzNMM3Jyi1/RR2l9+3S7A0B8A7bPBr0
 tpBzYLl1YUXmVRk9hozk5e6FjYw6cqtl4osh4zt5Fyoja++yD7ssuniPlGScc2FUO/Q==
X-Gm-Gg: AYBFou1Cbiyls3u6Qx2i+/dRM6NvRlynSGPu6z6o9CTKHTVzUDvOxWCQS61jE7bhAtq
 aog2MPGu+o8dkjD2au1Z6BbjmplfO/SQbpOawVIJkLkd7RpKcuS9JeVJu8QqVxnCKpfS+NVQo6O
 4zzSbn/6FnlxVc9QzFmIAAk3e5kOXk7qChgRLC8cxw2koz2GYv70bFL6HFlsaQC5Is2Bbm1A0wo
 3UJWPM6+A/N9gD7M3PchsT6pm81Mw286Vvl3u4vAi3p7uioc+O3gTRVgcpuiJeL+DVp60wzdCF9
 sZs+R+jj/rU01c52jM+aG8VcLmaVHxYubaw6vdGPruMWiDtwv4e1/atQ0n1294DWMd4p76VIo5R
 fKxJfiQnb/5StfZWDK/POtfd5nX9ZJ1F12ZgXN1Kk
X-Received: by 2002:a05:620a:2686:b0:93c:208:3d9b with SMTP id
 af79cd13be357-93c43cd656emr1405706585a.41.1790494302440; 
 Sun, 27 Sep 2026 00:31:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2686:b0:93c:208:3d9b with SMTP id
 af79cd13be357-93c43cd656emr1405704385a.41.1790494301920; 
 Sun, 27 Sep 2026 00:31:41 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef60da94sm136155395e9.4.2026.09.27.00.31.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:31:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Misc HW patches for 2026-09-27
Date: Sun, 27 Sep 2026 09:31:31 +0200
Message-ID: <20260927073140.41422-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfXzHjtcqGRgS9F
 Ra7SnBAoYsC5pPYYo/mPmMuHHHKuNrv9f1rlWElnknvdmn+8k5x8K+b7ZFTcWjQR2TdJm4hUKLG
 hKkfaX3gGUUqdl4RXjDioIlqWzNrqAzvb3QjO7virsyILcco9Rf9ApPY24qMUnbO0SWl7yBldiX
 a0mqp3hMLtR/LEdXZEpZ/2X6OmYhcCHBp0wZbVhC9NActgR+/1Pn20DHLzqhy9Vfd2pT5K26kjK
 O3IFj79IMlBg016IY+GM8Si84cSZBt2X2sI/5tAHmpyNOieXPSsABrhDKZUHhuvvXki1EZEwIhD
 C/p/7ugjQc4BB5S9Xka+HbGid51Em4KL5RjZHGsnLYOwUDhfF3C+3l0zsUz0YI29HYley/tEKis
 rVtJZFMrTPpp1MaB9efqOmBA5qDaqYEA6eitRZwaxEr6/LA6LIdSLdCMdoNY6av+80ASaz+CD7O
 /kD/KB568krFqdDRFyg==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab8c65f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=1xWVNfVfhtQvV3Plv74A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: yGTY_bFawgIZAY95AzQVvlW2LYJkveID
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX2flRzxV5yXyT
 A0xfzsKCj2VhE+UHfDB39T6e9LYMjJl710y8K5TPFbuWdX/AQRlKvLOEN4yvX61/fuv+uch1wVs
 rHAkcHTkjeluDtb2c1VEWCURwYyH/78=
X-Proofpoint-ORIG-GUID: yGTY_bFawgIZAY95AzQVvlW2LYJkveID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit efa3b9d5ac8024078225e1ab434411fdfe53b457:

  Merge tag 'pbouvier/pr/tcg-tests-20260925' of https://gitlab.com/p-b-o/qemu into staging (2026-09-25 11:52:47 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260927

for you to fetch changes up to 8b395deb9475ca669f4ad62dd01d3ea66fdeea13:

  target-info: add multi-target test binary (2026-09-27 09:30:12 +0200)

----------------------------------------------------------------
Misc HW patches

- Improve QDev documentation
- Remove non-32-bit CPUs on ISA/PC machine
- MacIO and BCM2835 CPRMAN fixes
- New multi-target test binary
----------------------------------------------------------------

Akihiko Odaki (1):
  hw/qdev: Clarify instantiation and realization

Anisa Su (1):
  MAINTAINERS: Add Anisa Su as a reviewer for CXL

Jonathan Gilbert (1):
  hw/misc/bcm2835_cprman: correct register index in test for mux update

Mark Cave-Ayland (3):
  hw/i386/isapc: reject modern x86 CPU models
  hw/macio/mac_dbdma: ensure only implemented DBDMA registers are
    accessed
  hw/ide/macio: use pmac_ide_transfer_cb() for disk DMA read callback

Pierrick Bouvier (2):
  hw/xen: use stub_ss for xen_stubs
  target-info: add multi-target test binary

Yonggang Luo (1):
  hw/intc: use kvm_enabled() in APLIC AIA helpers

 MAINTAINERS                    |  2 ++
 meson.build                    | 23 +++++++++++++++
 include/hw/core/qdev.h         | 41 ++++++++++++--------------
 include/qemu/target-info-qom.h |  1 +
 hw/i386/isapc.c                | 53 ++++++++++++++++++++--------------
 hw/ide/macio.c                 |  2 +-
 hw/intc/riscv_aplic.c          | 14 +++++----
 hw/misc/bcm2835_cprman.c       |  2 +-
 hw/misc/macio/mac_dbdma.c      | 34 ++++++++++++----------
 target-info-qom.c              |  5 ++++
 tests/unit/test-multi-target.c | 53 ++++++++++++++++++++++++++++++++++
 hw/xen/meson.build             |  2 +-
 tests/unit/meson.build         | 12 ++++++++
 13 files changed, 176 insertions(+), 68 deletions(-)
 create mode 100644 tests/unit/test-multi-target.c

-- 
2.53.0


