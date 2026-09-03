Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456FEC624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24rH-0004RU-LH; Thu, 03 Sep 2026 06:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rF-0004R2-PW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:39:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rE-00069I-3A
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:39:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHKsG162990
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +hA21VIYFSsJ97/MLiNGmGBD+2APEfUHCnq5ULE3qWE=; b=JUlntdyZCkLGXPTT
 N56PQaLT+vx3u5jkxQrvs5QkSW0Sb4OfiCOt90D/IdD94ffSaOwEwo2xhrZ40gol
 rOTNAAZhHcFW+sOAD+R7vtWZhZGEuH9ezL4xzX3K3O/LUYlR+NziVsvWXuPJrT/d
 yU8gBnnIyYrwK7MMzS0KxzOiHVeEIvBafGPSCVk4w9oAusYF52Xuzf2r+ZcuqC4c
 yKAv4sKMwTQWPgTuSFunK0DSQPju3e/Mg1ZQkW6dhSs84qJgHaPSVNdGv7I+ydmw
 W0CQXkXqdH05zsLbaf0r4oWNQjlN8gw3WkCT+woF9OiI1xWVjP/YNeejeL0fFViC
 ibc/Ng==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx049p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:39:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9393ac4961fso162327585a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788431986; x=1789036786; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+hA21VIYFSsJ97/MLiNGmGBD+2APEfUHCnq5ULE3qWE=;
 b=LEHDs2L7BRiIMW+VEl0CLWGwa3xeXPYq8A/Bg1pLN+M9IvejjybeM/7MFFlvyrm4dp
 jNFOwVdT+HGihYTkluvqmu43v12AwTVwbCznr/0ofq31Hyu439iAVQvOfPEHLsPDAYzn
 GcFTFN88jOr1P7M3krptdI5rHEtztdSgj7qZ1vWZCR1Y2+TsiuHZYn+drqSgHFqxYppM
 oN5zuSXjeaDIn/n/nbUt5rTf3M0h73e0aXkv8MgV/6j6JrzfbJFYgAzOpeuMj87GBBZy
 yzMSAYy/bJfc2+tMEQUmUPpc9Uvms0XKKYZC9pdE2z3/7yCEidoN1FguTWY2QojZDLT0
 saVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788431986; x=1789036786;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+hA21VIYFSsJ97/MLiNGmGBD+2APEfUHCnq5ULE3qWE=;
 b=JoINxQEom9ZaL2h5nOiDFuVZ5ZEDc4P/55Xv+6QWek0Vz4fM5QTGwhv9S3f7joCfWy
 0F2NTTPP5cKTsJTgFrAXGil7LaZEGvP6W5wLA735xwvEhwXRF6xQadRsBKVuDx73/8lF
 dCdEJcqwlJKx4lRkDDcTeF9mkDuyw3CDEMaQh6xeAcWrpo1m+Pu6A9e3TGkwGdvQxW5n
 3U/WKDBbB9q06c9x1to6blUuDXSoQXoN1kvs/NSfJ4r2FI4Lhr2Pt7KYhkaLS3dGAQSs
 0MiHC15esrdr+1L5gG8V5lrEu+x50lU6tTlYuekGRepP5LmvhIZWkMBfERlrklqQfuRa
 qY+A==
X-Gm-Message-State: AFuF++lN9dxVLa+tjtf7Hv410bRpBSrgoIBfpVyN8q/LnM1MdrBVNlWQ
 HjeaCR/fXF9X3a+Kp/AGornHag9TzvcsDZG8W8LmrZrhA1vCFhk0euQvydMd1UeRiTrpyML/6gs
 YMPSf0trYzqOQ8kWxWsJix0MuEPRvhbX84S7UCh2TSoBBHRmMAnkBd0kWJHi1RUaYdA==
X-Gm-Gg: AYBFou3dbNgP7+unNY3tAmE8pIBe8CuCIDeGkfPQ6IHNPGOOBmPbdz5dTNqojnGzHME
 NO8qa9fFsavOx/uqrqZA7Q/tsmgepi2AGu3nKUKFLbe/uW1YWJW5w0zYHTLAAQPjvcShxRGM37p
 P8gy2G1R2FwEYltsQ7CXLBoVN2Cz7mvL2306expNY0dzfwtcFqDAkBvqmsVCOpG1v7jWBsQ9E2q
 agUpMkKC3u7/K8P+F/Gh/Hfw9PsYHq/qnY6Myek1B2KlNXsoKID5VcTsP+ptDTSEZXy+0ZzoT2f
 pFcp2EGpU+RIGwVpUZ1Y8aJNf5ujR8Lhnz9qOWVIbEV82/ag3plvMm+/GS/hI0KQ8pqKzdKTqfG
 xXqZu+KKvBZ5Ax3mvghu+EaN9J6wFcpAaA7ehkBOa
X-Received: by 2002:a05:620a:4151:b0:939:fa7:8df8 with SMTP id
 af79cd13be357-93960de3a2bmr1289747985a.11.1788431986296; 
 Thu, 03 Sep 2026 03:39:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4151:b0:939:fa7:8df8 with SMTP id
 af79cd13be357-93960de3a2bmr1289744485a.11.1788431985780; 
 Thu, 03 Sep 2026 03:39:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed38cfsm11883102f8f.19.2026.09.03.03.39.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:39:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/51] hw/sd: give the RPMB vmstate subsection a name of its own
Date: Thu,  3 Sep 2026 12:38:45 +0200
Message-ID: <20260903103936.62355-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Eba_l5JxiNfpPQ4_GeNIFsike51a7qI2
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a994e72 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=5RHtEPMUJtLrCEOe:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=6rqHouBjAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=Oy2_cJ1RsVdzQtVqsEIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Hx1yvPaMooE3kwe23bt7:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: Eba_l5JxiNfpPQ4_GeNIFsike51a7qI2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX4sUHN1vOhwmE
 ps1jsvy3vINqxlI/5RJS5zFfPaIGidr36RN1loltqtRIsLC0E7xw9a2SjASDDpFLlggMIm1ahsX
 IKER9QQvG/wkdJG1wV0QQfq8sk99ROcNsmDd6iPP3kzaWsWsmb3IUB6JSUxDb6MKWoyCIXf8Jpt
 369D+fCsJ7pBDKMCS8KzdHbcH/W9+cQFgyyAX6LWsCgdfEoOrturGYoB9cgZncVPFyrNAv+Q8mz
 NzhEcgTY6H+K8O1Ov6PnvfT6RctG0ndCLNgvRNFXQssHdh9gw+DOn4scnvfs3mcyqUmYcXA4bV6
 R2sjQyLdvfmZO+wJ60E8MxxbKX0HdzGZIhP1adcgdHtPdgcsWWAAcAn10g04IVGwE1qdZ7e8rnx
 n5Iddr8UwGXoOwI0gu5jFWffUiFf1sCqt+vBTgDxIoRAf9iG0lMYAfPhBk3gqxSBi9x+Mgpygjx
 +Ui5XDiTppMNiFyPj8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/2dX3nowF+3q
 vZMaVP6TnLMKHhJgBD4iZF1HKAbbFcndODDRa7AFiuiA4kJjZf37PtzeVf4Onl8h8O2kmUkvEiD
 IwDnAEPjxnsRVg4wI2uN2RETOlVkdQI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: "Denis V. Lunev" <den@openvz.org>

emmc_rpmb_vmstate and emmc_extcsd_vmstate are both called
"sd-card/ext_csd_modes-state" and both sit in sd_vmstate.subsections, so
a card with an RPMB partition sends two subsections under one name:
192 bytes of ext_csd_rw and 353 bytes of RPMB state.

vmstate_get_subsection() returns the first entry whose name matches, so
the destination parses both of them as emmc_extcsd_vmstate. The RPMB
section is 161 bytes longer than the fields being loaded from it, the
stream is left mid-section, and the load fails:

  (qemu) migrate file:vm.mig
  ... on the destination:
  load of migration failed: Invalid argument:
  Section footer error, section_id: 38

Reproduced with

  qemu-system-x86_64 -M q35 -device sdhci-pci,id=mmc \
    -drive if=none,id=d0,file=emmc.raw,format=raw \
    -device emmc,bus=sd-bus,drive=d0,rpmb-partition-size=131072

Name it "sd-card/rpmb-state". A stream written by an affected version
cannot be loaded by any version, this one included, so there is no
working format to stay compatible with.

Cc: qemu-stable@nongnu.org
Fixes: 8ef4260a3f ("hw/sd/sdcard: Add basic support for RPMB partition")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260814183859.4034017-1-den@openvz.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a30c541df07..674ca09b49f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1022,7 +1022,7 @@ static bool vmstate_needed_for_rpmb(void *opaque)
 }
 
 static const VMStateDescription emmc_rpmb_vmstate = {
-    .name = "sd-card/ext_csd_modes-state",
+    .name = "sd-card/rpmb-state",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_needed_for_rpmb,
-- 
2.53.0


