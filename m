Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBDCC44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjivG-0001aX-QO; Tue, 14 Jul 2026 15:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivE-0001Zw-8W
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivC-00056A-EF
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwKiM1137063
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TTTUEP9IQFjwJMoFTOSlQhorz1cluF6zUO4vNlxDSeY=; b=peEAJIgpeXzvdhQU
 lFBXrHU6l/IOhXhRBZgs5h/vJZgIHYoH1hYcXNHrpDs4h8wYGA69VikiPD4KmKDq
 pp3J9LCFHonIf0yuWUEIC8pbXrssQJS1Tq+byHLW4/dabI/8hKulkgUeFPICjJcX
 2ytvZhQV/ujADybyMh43WZBYIdE4HFSoEQBbfLIEnRnY7g9bgVlkgxW0G+m9e//y
 c506GdaNuxkU8B/jmb+wf8Fsfa4bzmpsohjG3jZiDnaOD9H3VE0Z2RhoxKof7STx
 Hxs7qGX97OHkuPGMMlgw+ZsoHnBqJ5qyA1jEHEs8lbE8Y0xeRLkjQLmO87t5AfiX
 Pbrx9Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9mgfsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:00 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f18c4d1f82so93308226d6.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057760; x=1784662560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TTTUEP9IQFjwJMoFTOSlQhorz1cluF6zUO4vNlxDSeY=;
 b=gtYT+5k9sC6Wvt9GfZehzv/G+71oj+IQV63LGmxJGaZXVw8PT3tBQ9G9Y8bahSRJd/
 TvNAmOvWqOA8Oog+QGFOh4zrb3smHAU3Bc+m5M7Hye4WKmQhICS+PdVdiYxbJwCMnNGL
 IKLzDz2A1Xo5oxCqkniLU3wGeeLAVp1CdZvcvAggRJvN5KQwJhQcY6jWp18USGTliYyb
 IKijqsBFQtvIaBmwsmVVVPw9adG9cJhbPimo0cHjmazZDTGTJuZOplx+o6poEJHBATO6
 YPSsQVIxJK3PS96EGbdTGlsEhfkBeTslpl8ucnuC3/tln5rs5E0hVgDq1gEWjMA20pEy
 Yk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057760; x=1784662560;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TTTUEP9IQFjwJMoFTOSlQhorz1cluF6zUO4vNlxDSeY=;
 b=ZhP+ayFGFs064S+grXC7to0KTHGbMzVWw8c3ACKDwwDrqGKfglpaAWV9dc1jhCvw9z
 xJTGmKTZmfdyOS7Zu4p3TMqhvYyqAoGUx2zuwL5YvWSO4yK1bkqNgFEFea1vPSCZ+YFN
 vpqFA3B8fdVXqTu2ra+1YofyJzpKQNt8CLAu0NE/VvgITkgDCgXyJgBysPpvaFYB1354
 /3CC0rD45zCS81FS3A2YGXRSVbqbZOCF0TKP79hpf7cvesWt+VF8wbZMqKphHf2RvcPQ
 wGNFWK7tb9Hdd7NF2DCn7JT1nsuyQr+HNfwoKayReLmi9nuoBdt8Wyu0kgEWUb2tRLRm
 8d7g==
X-Gm-Message-State: AOJu0YwRJISgnUlBObXhCEmDWzEONq+Jgq+Fs1AQRuQ4bs53tPJMOzqt
 RB+t7zMrPP0F5oy46gJn2L1t7WyMhiC3qYB9aTb5R0eXHUmb4EkDA6wGfMH69C8Clb/1GLKUiMu
 YMARdO141vOqI4DFVyHCMXz5XMysdEfBi8cu5fn4R6NZ7vg5C56Z8djMNimGK5qW3pg==
X-Gm-Gg: AfdE7cmsBUFPjKYLqH7w5y6HDBxieSNICeSP4o6//Bc73PHx4fdq11tM+5Mq3+QVzCC
 8cpOEbY49HC59sOMWz81tBhn7iZUhBarswAd+B4TckEz3yboW+5lIaCUqU2oPXus7jPbmcPyIut
 SsAKKyUtsBOgEkIxE99G4+3QbmvilEj9nlp/iJRdSx59hCpPTNJ3VGJ209Yy5CatJ+ZPKlUfI/N
 EW+MXpWithykhX8TIDgrv/IUn7avydQ0iXpsVWirf97p9ZoEj6ojMLvqBUWV90VSIpfo8XUj/lz
 xWGwYOg+6BCuj++Elw93JwuT6bN32iX18Vv0BTNhsuiFnUheCttSZrMEAPQsfB2XLZym9A37qsf
 hPGq7HtFv6nQW/KMU/1M13LMZj39Uv9G85LTEVWUOdI+QyeEgXZtxO9mbuBWkgcD/h4/C
X-Received: by 2002:a05:622a:2b0a:b0:51a:8c9a:8fad with SMTP id
 d75a77b69052e-51e4f0fd508mr286731cf.62.1784057759735; 
 Tue, 14 Jul 2026 12:35:59 -0700 (PDT)
X-Received: by 2002:a05:622a:2b0a:b0:51a:8c9a:8fad with SMTP id
 d75a77b69052e-51e4f0fd508mr285961cf.62.1784057758160; 
 Tue, 14 Jul 2026 12:35:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32c65asm95707755e9.14.2026.07.14.12.35.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:35:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/13] hw/scsi/vmw_pvscsi: add a comment to explain the
 endianness
Date: Tue, 14 Jul 2026 21:35:09 +0200
Message-ID: <20260714193517.60708-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX4hJBWzOJ9Taa
 wTkyRElQZtT0zmsn465PwFX7+vsOBRzLkjLklsmxbXj+o6SLEh8lIr7WycwIk7r6K34w0xKMsm/
 2r62NPA1/plI/eRDf6i5o+jYDiHuGH4cs5hWCdI1BTsMnci9a05w9aNCtL/GF4Vf7JIy9cJcdLb
 31obmvXyif6oU50Ba3hsxvJQRNJ46o8s9JDQyR9wNnMUHaL/0cuI6EVhAS2GKM134xFVmK/juKo
 j1fgFOdLPytwDpb+WtML6vQMH8EbJfjtaFs3zQmb0RNWFPqDL4Z6PsI8XU9+5YkbnyjyQMPjr/h
 7UANwyxYdhFBrkJllnCEL5pTEZvG+6dZWWOOaZncBfBMEoeviJOAfK+tELnTTKbmdeDFW6OLgd9
 GxrQ64w3NcqYZNC4aRdxNqgaHpwSFvIyAGp+yi5uJ7rS56XCHxU7g+FGeKfv0HBNvUUjFTLGjQW
 O2uH+koyWjgtAa5PeUg==
X-Proofpoint-ORIG-GUID: noERTdC17n-31Pgis8yP0vVvU2jVEjyK
X-Proofpoint-GUID: noERTdC17n-31Pgis8yP0vVvU2jVEjyK
X-Authority-Analysis: v=2.4 cv=E+79Y6dl c=1 sm=1 tr=0 ts=6a568fa0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=yIBoU1TpJL-JTJq4:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=e470PcS5NtvczxIusEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX8J88xtr+Y5Pm
 kVJZL2RD74NablDP3yht9/0eT1IVySncuo53A3S/eSjlu6uRs9jlTe78WssBqeSH/egWwpP6Cem
 hw1glBzHRs+5uUZLLAGKzm+rCa8BIVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140202
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Miao Wang <shankerwangmiao@gmail.com>

Add a comment to explain the endianness of the pvscsi device. We have
no information about the endianness should be little-endian or CPU
native endian because the current driver code is designed to work only
on x86 and is not endianness aware. We assume that the pvscsi device is
implicitly little-endian.

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260710-pvscsi-endianness-v3-2-27fe1c4d1f6e@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/vmw_pvscsi.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/scsi/vmw_pvscsi.h b/hw/scsi/vmw_pvscsi.h
index a3ae517e199..defff9e179e 100644
--- a/hw/scsi/vmw_pvscsi.h
+++ b/hw/scsi/vmw_pvscsi.h
@@ -108,6 +108,20 @@ enum PVSCSICommands {
 #define PVSCSI_COMMAND_PROCESSING_FAILED     (-1)
 #define PVSCSI_COMMAND_NOT_ENOUGH_DATA       (-2)
 
+/*
+ * About endianess for the below structs:
+ *
+ * These structs are used to describe the data that is exchanged between the
+ * guest and the PVSCSI device. The endianess of the fields in these structs
+ * is not defined by any standard. The current implemented drivers are designed
+ * to only work on x86 architecture, so there is no endianess awareness in the
+ * drivers and thus we have no idea whether the fields should be in little-
+ * endian or target native endian format.
+ *
+ * Considering the above, we assume that PVSCSI is implicitly little-endian and
+ * expect the fields in these structs to be in little-endian format.
+ */
+
 /*
  * Command descriptor for PVSCSI_CMD_RESET_DEVICE --
  */
-- 
2.53.0


