Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA86606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LiJeDo92;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NYwgPghf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzeD-0000Ap-NT; Tue, 24 Nov 2026 18:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVze6-00009S-BE
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVze4-0004ub-3K
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:53 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMasVn2287992
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SIGBNHZbCobIskqsCB/6Y+/pvyk+U6nUwg5js+NtvvI=; b=LiJeDo92XBpAAKzu
 g6gfkCGuZK800Gma0kycRxHA4h4Lg1G3GShwirx3Bi+l6M4svJszGeL4z3jxXtt1
 HQA75MLdmKGWXo5hB0fbNyoNpnnQ6NrVVZVxKcGZDR7crMh8niW3us99if1Lp3MW
 h+XzvzbvFdLp0qFvYhF2GirPx5VS/IQKTK5t3MlWZQgmNNSvn+MxlhE1NDan9lzr
 A54hjplK7wgUBdbCrn74gh7LoDYZ4JRy6hIX/N6eo18oHrtapghk1CKejtRhEESx
 4vy4wWTARl5WqQz+rJwsBKZ75yLXcjDyC5CQzI6FL5yoww0yMfcq6MngVSb3pDv/
 wAOXXg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5egs9cn2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-920fb8b9859so8386686d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561789; x=1796166589; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SIGBNHZbCobIskqsCB/6Y+/pvyk+U6nUwg5js+NtvvI=;
 b=NYwgPghfamm5Tmqe83/puJi4mvAtooMI3f5s6AXpHmnv1nJvHY8P9Y1ACGv0kWpOuw
 JFgS0JU6Z3MNDktysC3Zfcdq8+AWNrYvnfwub/U6NKoeTvaj+oNpb6UKePKYfAYvekJw
 pIjWh4esUG2ZvQoFJdGBn53MzqnueQKb2pwmioHoUrmXIJ6drz/SIZrc/KD05iXonWWv
 VTCA7DT1VZYaGK+Ko13emNIbTDpJ+pug6Upq0gjH+Jzvmuwwzwg2mzzqwM5+uSBVvk+I
 ayT1K/759mZDqHxn/uiQY8xeRq4+s2mH7sZZR5RXQPBENCmqdPGp0HHhzkIg/t9KCWEA
 8Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561789; x=1796166589;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SIGBNHZbCobIskqsCB/6Y+/pvyk+U6nUwg5js+NtvvI=;
 b=hwt3ui2Iw+6wzwm7LfOfIjKhaOCwWo1EMaYSpU+peqY+CXjHMI1nNfHq/W+n9Doz0+
 CQ09gdOhYz2rGIBBI8KjkDhkVNaR3yVvshSud8scuxP8d0Or6lyTlLX7dg/kdOoKmvT3
 wM3uCraWCvkOheMy4YeOfW6NsEw8uMndIExXVDHpJmPQu0qygk2k2iAgbZEeKILkK5LI
 CIxPWRSYIKE6cum/EJvyXSQ/OIi3csz6dZLstvzGQFMuYUKqTZeZTqdfWhXfs1X9128y
 tCYzdD9YgPOZqIfleXavgtpvUj6Jmp0b3CkfzFgroZR2ZlWomKZKlQiIZyi9OQqzx15X
 TSZQ==
X-Gm-Message-State: APuU4Z8dOj9MJF+lEFubABX08mmtrCwCJWo0+N6Tj6ZizglC19kWP7Ga
 0IZRbseBL9ll8m5Bg5jaM1vqOMWFg/T4tocZo6mVEgaDkOSriSxvognnnoPACLOMlRpVzlAgo/b
 FCuctfQHcSRHI67VRS3st1ZAur/VamDabXY5aaKLzDpo4AXIcBFEz4k4+4yva3lkn0Qsv
X-Gm-Gg: AZFdTZeb4SQdeVws749Y16jUrHuhJm9XnGCrpwZsaycW+HytDqgtR1N39+/pg6ttTcl
 6ONgfVJikyVw3fifdtgz/WXmLbv6IMiitw649gqH2XyLuIgdFxcyktmL65rXPT/FGx65xgbz0Ia
 LLndYgzXC6ZjzBkaMDx2IWVy5vv3UMOaV6TNoMmxRhB95v8sn5Bo2ZoZwnZhGqBeSE4D0um5IZo
 wj2Yy1Sz3V7Pp6Tdp1ycBNhOs2yYDV6W68ZIqDwsk8mDevwIMwUCqz+aDtD+ATsGYSFHtEI8h8w
 IdP3SSMogkUXG0leyw2Kw2iHXB+X5WjIlJC/NMDKuVHGEJLiln+dNKvnT8k1hhIp9VJay+Dvjwy
 7Zyk5Km+uyGc4n3sxmZ1At+LQ7kSNxsQWc/5iURKqBCqDl8mSLX8StaiQMCrkVWxQf9mL0rtRRt
 LH79AiUwDzBLk+jA==
X-Received: by 2002:a05:620a:3726:b0:949:66eb:77eb with SMTP id
 af79cd13be357-949ba827b33mr2945589185a.10.1795561788907; 
 Tue, 24 Nov 2026 15:09:48 -0800 (PST)
X-Received: by 2002:a05:620a:3726:b0:949:66eb:77eb with SMTP id
 af79cd13be357-949ba827b33mr2945584585a.10.1795561788443; 
 Tue, 24 Nov 2026 15:09:48 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm31975905f8f.8.2026.11.24.15.09.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:09:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/17] hw/sd/sdcard: Reject zero block length (CMD16)
Date: Wed, 25 Nov 2026 00:09:04 +0100
Message-ID: <20261124230917.88704-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXwtUos+IY9PSr
 E3cuSJjQ6QYLnJ+mUcilREQuMft0xMCtWD1Q1PkdT912lsJ8b50LZLvjtSdM3LeDgLf4TRaPdeq
 5+ygZHGCWrlNzejJzf04rVEzBtDT4zoTnKhvajGWM/PJ8YZ2V3hoQ7+f7MM12n2Ys5wsfunbpny
 zEmA06r469Q7qwBYYr6p3hzWHtoRkGfdAf7gES9wmYGPO7nMBFuot/wUzIJHzK7Qcws0jm9m5zS
 cvij2O9DCm6s3e7YyZuDr3AqKJD3LeANLGpRGN4+jG8+Hk4WU5ZJloK61gp3Y+07MOb6rjAkhc6
 Hm+QAhXCT7r/IXQrly10aUMQU9kzHmllXLLsVUHHIAUznKsHStXiCKmRJtEd1tNguZg/sFQbep9
 NzGhAgJt3T989W3eQToOOGHTB43PVHsvz1/7q1x80xduEZhb/HzhXVkIe/+T8+smk1ts0MHsCDA
 TpPIEStXfiErQSgk8tQ==
X-Proofpoint-GUID: ym5f5OT__m5llRoEAYIVrQVFswXNjOR6
X-Proofpoint-ORIG-GUID: ym5f5OT__m5llRoEAYIVrQVFswXNjOR6
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6b06193d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=JfleF5YHFwbTGIRgw64A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX7DlMB8s5rJy/
 kll5CE6gHnsdesd8buVdZSKL5nZIeg0y+hscNdDRQmEgzJsnSsqQw3GB7TLD1mJt+e6EdBD13j4
 zOBuxsLwerwaIVCxTcHN3H+FWdunrZc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240091
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SET_BLOCKLEN (CMD16) accepts a zero block length. A following
READ_SINGLE_BLOCK (CMD17) on a Standard Capacity card then reads 0
bytes from the backing image and enters the sending-data state with
the data size of the previous transfer, so the guest reads back
stale SDState::data[] content, such as the password sent by a
previous LOCK_UNLOCK (CMD42):

  CMD42 (set password "secret-password!")
  CMD16 0
  CMD17 -> data block contains "secret-password!"

The spec only requires BLOCK_LEN_ERROR above 512 bytes, but a zero
length cannot carry any data. Reject a zero block length: set
BLOCK_LEN_ERROR and keep the current block length.

Cc: qemu-stable@nongnu.org
Fixes: a1bb27b1e98a ("SD card emulation (initial implementation)")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261123225349.54981-2-philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1772a4fdb11e..81dd54beb90a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1974,7 +1974,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
     if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
-    if (req.arg > (1 << HWBLOCK_SHIFT)) {
+    if (req.arg == 0 || req.arg > (1 << HWBLOCK_SHIFT)) {
         sd->card_status |= BLOCK_LEN_ERROR;
     } else {
         trace_sdcard_set_blocklen(req.arg);
-- 
2.55.0


