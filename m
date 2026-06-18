Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18A6CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBrY-0007wh-JJ; Thu, 18 Jun 2026 08:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrT-0007v7-E6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:28:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrR-0007WO-Ow
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:28:47 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAraEw1054825
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lZGINRaxXIxDHDRwC/5u4ZiaZsPNVShYO4DeqkNE1wY=; b=WcnNJFE9qSCas+uz
 km1+p/+1pXqSnLL0433KJFqQlDfICsZEtELUCJ/23cmOqfGNjBiIBcBm7wQuZ+h3
 Keyjv5IdbCIo40OB3X5i3xYJbuR35alULkQ7hoSLi4kwa2XxFoOqZqqnhLkf9IEy
 CgKourv8ZiaP6rWxy+1EuttEF/Ytpoyw2rqclrifa5STic+7erG06petj3yxp/X/
 lSk9wucajmoeLqr4svo5wsVzwkTOfvvC2eNm+Y0FdPmBy3QBesykpu8SZ+R3uRa+
 j4GJ4IMDuOZnEa7d4vQgc0xP3QmWWvJYusqXcETIvXmez/eK64ngmrc8u99VaY16
 f424ng==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2ccf7q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8dbdf24d47bso20294766d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785723; x=1782390523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lZGINRaxXIxDHDRwC/5u4ZiaZsPNVShYO4DeqkNE1wY=;
 b=elaD4J7VQL/kWAT3DqSXCNrVAdtgE9DgZDecO3zr/NunUvqr4UW6cDX5W9ycU6sKVM
 ksLYKs09P8mRhk/qpWOBVPBcYkdGAYnxUlYL8bCYHktDEAEEQ2/y3vIOSnwrRQJl63kg
 6JADuqD+4DbeMa2W6wAAaXPR5u1jlnCEAZN8cYz6NfvwbmEW/i9M1mUwT8S9lhIuHuUO
 6IfX680qmue6bZyTbT82yGtT7Ae8TI/WBdg7B3butJGNjOP60BXxYpZ0SXy1v4lE41R5
 Yg/yNVw/FqSoFBa6kZjbGkm2S+41FCJioUojMWojtr92znt7YtxIWfWksXou8ceeu2oA
 YV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785723; x=1782390523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lZGINRaxXIxDHDRwC/5u4ZiaZsPNVShYO4DeqkNE1wY=;
 b=k9YbgVYuYS3MIALTgdyht7h9gepTAMLZBIbLU+xW5mV9h66bKUSDV8hpMenSv1AocB
 VjzGeoPMw7lVGbl/Tf02hbQ8DlyJxvs0GtGP7ElC4b7txfZI6bd0X7EJ0BfJ7+PgU/sb
 ktgg5H/k+k0F9duog6s0VLSjiPyExXe9HDtEhdtc9KskRHemVksMxZiCdcZvugOYO8UF
 CpbNrRo5qSat7Y413l2uOB/eIuEvVWyDyLEbBp9Nx5LMS+9ZA4T1H6Qx4tqB+p8sCcft
 0yCn9+TsCPck4mwtFiEef2GWm3sqt3b7uOEVgJwvBxLb+VYKYlZ3b7iXNKLMarseqUUZ
 P+gw==
X-Gm-Message-State: AOJu0YyORm6FJ+Or0+vghXNSYkl1FpB2w3QPVWMygO7JQsXaQZGoxYa3
 jKegZj/SfFkWXLszMW3LpkHVvX8LV1ydkK53zd5rdb9qKERINulqhgAYn7DWMedXGCwyDsDs31z
 vEqGQayqsqROfji3x63T5/dNp1xT1WhmBNjDusKzGS//1JOhKcIcZjEAZDPSVGX3c0Q==
X-Gm-Gg: AfdE7cm1TqKuBmLKVrbn0WZBj4uvquuQGuQe1srUcGZ3ilxCBsyDIsQZV7FqrWyHTFd
 SdR8TrzAKyfBAi2FFm/tthVbaYufharywDWejlUSe1SGEcHELaER1q2MDR3sUSNKsMTZ6pacfVL
 e+pk4emJeyIYk78PtqK4O9iykisgG5GZxkUpqLOtvhrVhkhJ3cpvCpEBAGHIJB0IeVWTolejYmR
 /P46Gd0CKbKcYEx5p/2/A41JW9ILzz7oYIN/3zvtCDWU/XshRA8915Rf/h7gMxXc9/ntx7YdDS+
 BbMMAz2KRTzTbqgN2pioMj6Fcr/SXvHArpl5XdD5EBzSvwlR2mFj2sEdwxJW+SD2zt65SvMnTLG
 yc2zj0vwI8bnOOjWbHQZLg+kGAh4vFIj0nz7aF0mvRIrqNmBnw+clvNM50NY2Mz8H1EYA
X-Received: by 2002:a05:620a:4003:b0:916:4a9:f35a with SMTP id
 af79cd13be357-91dbb949c9dmr1221473585a.30.1781785722965; 
 Thu, 18 Jun 2026 05:28:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4003:b0:916:4a9:f35a with SMTP id
 af79cd13be357-91dbb949c9dmr1221468585a.30.1781785722465; 
 Thu, 18 Jun 2026 05:28:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d2d9esm38948675e9.1.2026.06.18.05.28.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:28:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/48] system/memory: Constify various AddressSpace arguments
 (checks)
Date: Thu, 18 Jun 2026 14:27:39 +0200
Message-ID: <20260618122825.90331-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXyCWRVMTWK5tj
 9Y4nGygTIudUOzMZTBq3NP6aXJMRk4kklnRzgTMPMtbglKv4X1yCODrcQc0AdWVtLxhM1pnXSRe
 nbtBrJmA9r8gc7n/H5zmO36U2tFSDth84D5mg560oPuqLsMzs0TZHSboHhYf/Akweaox7Us7PVk
 Oo3RlLMc2XXu6wzS1TCu9QaX4ABpBimiVuN+LERR2cWeSp/nbv+uWiYCj3GS+oos+BjKkfbVsMF
 2HdR9oSfDmaN0EEkFpox54XtrZqamM6VrCTAv5R92StSVF9EmD/bf+pq3f7YunMQ4wi5sgWWB8K
 3rO8S+Jf+tZM1RhccX9b+tPjvgdf75khqSM/UQOduJSCXc5ASnG63DjTQvbTXVyJ4MTdMpH6z/X
 kjrel9vC+vy/YLY0gTq+HGFIG6Vpd1lILAdNfi2tODXzaNHTEa9fA/6RTazw/aIf8EbN1a5IR6U
 VDDYpxtRdNQperRS3jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXyeWJNN3wsVfw
 oSTDjnHBejj9kV8DKuzTXtpKKXdRnQUkP9cb23UNUKlBKwB+AiYtfAre2fctGTiIhf56HMz+bBm
 RNrcSa7VMsoHMxBvTBNK9bBkL1g1zXQ=
X-Proofpoint-GUID: 00qJVPnDIFDRVNAL9RDDqvbJLC-O9HFx
X-Proofpoint-ORIG-GUID: 00qJVPnDIFDRVNAL9RDDqvbJLC-O9HFx
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a33e47c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=e-NtlPoBfifz4Kb8xpcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the AddressSpace structure const when it is only accessed
read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020359.18627-2-philmd@oss.qualcomm.com>
---
 include/system/memory.h | 3 ++-
 system/physmem.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 9cd17847ab0..3acaa309755 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2850,7 +2850,8 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
  * @is_write: indicates the transfer direction
  * @attrs: memory attributes
  */
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
+bool address_space_access_valid(const AddressSpace *as,
+                                hwaddr addr, hwaddr len,
                                 bool is_write, MemTxAttrs attrs);
 
 /**
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf875736..a0561177afd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3646,7 +3646,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
     return true;
 }
 
-bool address_space_access_valid(AddressSpace *as, hwaddr addr,
+bool address_space_access_valid(const AddressSpace *as, hwaddr addr,
                                 hwaddr len, bool is_write,
                                 MemTxAttrs attrs)
 {
-- 
2.53.0


