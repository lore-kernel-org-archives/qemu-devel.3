Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D9606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i7mgWVub;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WVOZs1lu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVuqr-0004Dt-Ka; Tue, 24 Nov 2026 13:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVuqW-00048V-KX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:02:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVuqM-0006vP-HL
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:02:24 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL4jX1183909
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Gd1lfdLwRL+6z/GVuZi0K6
 jcmTI4FqTBC89fm1GDoCU=; b=i7mgWVub83AWlasJIYkMwmUZSfiuulPyoLxDeP
 nrv6aowLZ+T/FMDMeqHpslx4Ur+8oaF9z+rThLamEvRZrgVXfsBmFoqsJKSbekJf
 G+z1e7wDU67tjnODGMasqDAphrAj3BIkTqOkgHtIarNq4hKxqo0BKbO4clv2qvQ7
 Haod82sJEVXxE6HWtd9GFN3KjnVJu9ocYPxXx28AwsdSA5GggO7Zxqxub6vvEt46
 3XDZuAlYlwqMru/D+Lym7cwSL8Xm3VO4EF7ygvjEMgeSkQGHuypBUiy/6Nnbim5W
 cvD5vsNZjYrK7aPEuXhoT/8j+593lMgXmtd4TaM5hy+Or9ag==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky44vj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:02:03 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5ec8c86fb91so1303329e0c.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795543323; x=1796148123; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gd1lfdLwRL+6z/GVuZi0K6jcmTI4FqTBC89fm1GDoCU=;
 b=WVOZs1luHWNp23HAuvlrS6zRO7dkhbm9xy+Evth9UajgBJarTzffNmWVC54eswqbGb
 2hNtSRhLqithN9nZAGYwviwhO4q6Bj4UYDwMRMKVKFOnNmEaZoOCtHy+am9EXpwJuOYO
 UpTPq+o8vOAGXWWDjrHmLstNzAJ7e61o7tzSSxRlzEwxHsdd89Qtp2ntao0F4dt5lika
 rlXeWN3Wcxai0fPiSja9SHznMl/xw9Q/PAgTh1MBRZsJ7bPNV2JRUlfClgDZqdvfF8lX
 pbwqms1I06zaxprazaYv4J1Kki12I+OrnJQ9fk3Lbxusqr4/kQJTpUExy2GrvLM/nUzC
 660A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543323; x=1796148123;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gd1lfdLwRL+6z/GVuZi0K6jcmTI4FqTBC89fm1GDoCU=;
 b=nfXxpbVmx00AJuWiJOUpnmtNG3trKAwfK8+OtKP7cN9nyzShkos0oYX29zgdwymenl
 ZW9bqNet2TxMZztKt1bLN8PU8BBYdpkpry1kqaTy20tl2fEsKF+2EQ1mwnQswsSF9Md2
 gOaFEBZRjNw+7uV9VTNVTv6REhNdZHgycasL05F8PCrGBzE4+fNJLDPDyqT7JV+JH5l6
 /DQu/0wMGhYXUxnSXuhajc0uYqwxwELV/6HihhstIq/IzmkxzvkiUvX2O3G8XmQioPj7
 vIMsMR/mualsmCQrHIiSDF9n4xvndcs5y79fBeZ6GSundrIWTKSQtBG+1WxH+5d9FfxP
 U9gg==
X-Gm-Message-State: APuU4Z+2WsrPhwCJKNSuDNB6Ve0GYBM7y9GlGh3AS5AdOYElhLew4Jw3
 M7JL1CkvDCV+6kHzk3qgvRp7Cuql+U3vlPvoJOtAyw75aX1LIaUQlB3AwTIqNfrkF0bX526fc+H
 9eS2wh8xe2sQi+TTG5No7ycY8bJ0U3vq7bytuU3ORljvaTyIgYaSbMcQj++4i8+dynvdc
X-Gm-Gg: AZFdTZckKGPYj+dqP3te/nnjPg7mUD74YJ4247dSlgrLtZ9iPGDzwPdU9XJiMhpeIoR
 5XJ8tSN/TLFPi3I3BDxZZcWJCUFZ5VDkfbL/oyREeUH/Wy/H1gfOS/kbgjwIOYpEoDTYSLe1mgf
 xsFA58T8nZH6P0h5J8/UxSKND3+80gYtWa6zhocA1qRVUACAn4QoRY6QBBhSq3KIAu8PM0CwlQV
 A2tE/PCHKEuSLrc8k4Ko2qWjkhHqexguoH5uze3n0yjq43U16Coa/qf1GHM8nHVlnR8+fscozvb
 r/7hhBS5MAUZvP0T177cUkgdAJWGyhr4f2nNubxFXWRcsTSYzDFG5/kF4hMDltD2mS12Hijpcyk
 iBhkWouiqo0JdKQ6OiQzjZ/78CbkeTk7UN8D+91MYvBX/xkcAeCiwsFZpWtbfD1Q8FglKH8KIzR
 AVSXqQ1/Hf3+CjbQ==
X-Received: by 2002:a05:6122:1d0f:b0:5ea:d649:d1bc with SMTP id
 71dfb90a1353d-5ee8af45319mr9585541e0c.18.1795543315129; 
 Tue, 24 Nov 2026 10:01:55 -0800 (PST)
X-Received: by 2002:a05:6122:1d0f:b0:5ea:d649:d1bc with SMTP id
 71dfb90a1353d-5ee8af45319mr9583039e0c.18.1795543302222; 
 Tue, 24 Nov 2026 10:01:42 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm507642965e9.12.2026.11.24.10.01.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 10:01:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/ppc/amigaone: Invalidate TBs on NVRAM write
Date: Tue, 24 Nov 2026 19:01:38 +0100
Message-ID: <20261124180138.69682-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b05d11b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=IQV9Gh-rnCok4E_vxJkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: kk5K7-c_rzKOM5VLp40be5ivRyFIe0KZ
X-Proofpoint-ORIG-GUID: kk5K7-c_rzKOM5VLp40be5ivRyFIe0KZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3MCBTYWx0ZWRfX2Sus9Monh7It
 zfFuDk0I24NJht3zVCON1STZONdVJg4yCpcdu35kLVA2SdvP8qCKpOMtEfPT3/Rs6ZkORFKKlQC
 +4D2d39zGWTrQMEZePDUZU7BRQC8XIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3MCBTYWx0ZWRfXwzCcfpDADjvK
 EyzL44msunc06zkR1iiC6+nGSib34l9bS5fHH/n843gxpbEEYrTvkvYXCiEiftDF8mQjhgH+QsO
 uR7H4mi5vvi2KmwmIFzm67v7m015YLw7L10tZBTpNFPmM3dNZU2fQYui5r/igzwHm8H/Jy7TvRz
 J913OoMrE8bZEu8yU0+tYgP5kEa6NXTq2sHSuSChe6wRGjI7w/cLB51tKiIUVxofd5ZNgjzVR+t
 vZ9EKZMhFBIKh1+Zz7Zy5kvtGFQBYRqlVp+f1Rn5fi+4miMxURxmaim1/sSRTGYuFhxikll14Nd
 wQlHF7Rl+F2QFjrDKbEW8wHuT+KDmsv1/xjNFqwrapMVpEfCHf31DWRXVxHg5yYiFfwCwcD3Uri
 vX+Fe9aTGV5AvrDFyAjg/7I5wgYIxgh4FMJcQ6UYm7tZD3p9NAKTg+3y8RFH+PKWt9HPUsGrpwH
 /BDYQP9fzu5SV0lyLRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240070
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

The NVRAM is a ROM device, mapped in romd mode, so the guest can
execute from it. Its write callback stores the byte with a direct
store, which TCG does not see: translated blocks of the byte survive.

Flush the written byte, as the other models (TYPE_PFLASH_CFI01/2
and TYPE_NRF51_NVM) do.

Cc: qemu-stable@nongnu.org
Fixes: addff513a10e ("ppc/amigaone: Implement NVRAM emulation")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ppc/amigaone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 2e94e80b5692..9b60782172ff 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -109,6 +109,7 @@ static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
     uint8_t *p = memory_region_get_ram_ptr(&s->mr);
 
     p[addr] = val;
+    memory_region_flush_rom_device(&s->mr, addr, 1);
     if (s->blk && blk_pwrite(s->blk, addr, 1, &val, 0) < 0) {
         error_report("%s: could not write %s", __func__, blk_name(s->blk));
     }
-- 
2.55.0


