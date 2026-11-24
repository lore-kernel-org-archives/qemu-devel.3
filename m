Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67389606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RpbpwGMk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FXHCdvFO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzfu-0003G4-I8; Tue, 24 Nov 2026 18:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzfh-0002Vb-AR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:11:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzfd-0005Fq-OF
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:11:32 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMadTL2557972
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VLAq5TvovuOCmyqHoGigZlYCobeOnGCc5/44RV4Ypio=; b=RpbpwGMk60kYW5a1
 KzPN0+XSJXbAkAI/IFXlYYyix5uV54ApQaOUor6N4eOMF7ii7fhxkevEY1rZeUYZ
 LoYApyex4QN5MPvjsetK5ZbNxNtFkj7xlfvJFJbTwqgqmRzsK8Qv67RiseucKzfO
 0GcuECI7227u6bljwkNy1/CAf/U7n0/cE3UoDudSBNYHDnA/Xb+wBInsTqoE1dRB
 eaLETcEPhaxdzAxp3v3yA2KhEiWDd2VniMpXHyufLHCEXucHEOj3XLsXvopyN32F
 28jTaj0+R63B7qPpoDk1mDp5wefKDS1JT+h691i8eZI+spyEpWg7NEQGaIPWgIB4
 jAjbng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dnghpu0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:11:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-948d83322f6so299171985a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561879; x=1796166679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VLAq5TvovuOCmyqHoGigZlYCobeOnGCc5/44RV4Ypio=;
 b=FXHCdvFOo6mIfmKTZJDpuCwW/Crojgv8pWAKtqJdEK5R3O9SEIM6dtHS9/SJZAuZwU
 EVjOvtSKv/NhlIOo7GGW7VNLRnXjMXjheP4uldxsD9pf81quAMgOIsj2PV/xGkDEHj5w
 3zlUR438qqCozzPTkl3yVV0qW11v28oYsERl9zyD+DwQXjw8Rxt6r+A+wexEZPMFx/gi
 jBmisIpJlfNp+GvyUdoebrbQ2gPnepyFmahWqKmpaRUEWKuGq8KHRv1v777KrWOubY9x
 LDNs3ZqAiss3ax4XkMpcEJ7G3EPt3tPUn/WQpBsLjUtU5aPBRM0U0nG61mS0TFzsGKLe
 9yKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561879; x=1796166679;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VLAq5TvovuOCmyqHoGigZlYCobeOnGCc5/44RV4Ypio=;
 b=JQbOjegRQV0Va2xmuxdwDxtR7vf6ga3qAhRrobaV/MSc4YlqmOwODhcU9wjWdQUk8p
 e9eftOPwqVWlpx2L6tw+ycbXVMiM6bONWx9/tTzjQIYIctZaJhqiilFyt2Nh095tI7FG
 EkR+jyobyKN84q65fk/t1FgKu7Wtpi0/Lx7XFQuVHNLA1np9tBQN7Uf/fJAmKRYJKt5n
 kPD3OqsLtSCgGlcpUwff/Y/FOEZloydW2aqipC4wLoEQJ6Zmpok1XAM5yg4rKRftqCu6
 HFFERA0fFIoeGYkapiQas50D8jQofXkud9kLLLkotteyjO067XBuRVHfHr0L3CKrxIb0
 etWw==
X-Gm-Message-State: APuU4Z/RNP6IaeDB8j+66pSvkZVNYaoAeuaZ5onQ4vwtfiRNz4ea/XXZ
 aVROEMyIIOYBLtkJhpgFu/hT+wTJlnidekjb0BDwKgDB4yHXf8JxV+hsbYqCJgp6Z07xeCYk1Wk
 IuUXL4IPcvqsafRii0kRsofrxWgcGk9C3cWLhYRyQ8/hdBF3JzwtlV0illbk3b3IdeN1F
X-Gm-Gg: AZFdTZfx29jVg0b8NcufTqFqP1pdZ7JpThu/R9UCaWSpCv3rMRurBP+m5GezEhLgWJO
 fPVLZ0EWUKxdV5JbrlI0AbRjgJHk/zMZPFeDlgC4BnxcunSLYx9t9D7x2HFpSyv3rLQ2nHMAYBw
 vL7aa18bFnCidhF3u0n234ljslpLIcm7lbn1BT1TUf4gAtkaXVR1Bik8i24qJL4Y6Lm9nqMmBlG
 aKuP5fg9jnnyxGtu7zmt0CuuIFRGoJCryRkJWY80AH/zAf45tAtM4vLQNH/tqgsRrTmTfgC7Dmb
 SKtrl8n2HhvZW/oZ8z0s8z/wSXGhl1G/1BqvWB4JzrGH5e0WD7Okp2rc63c6Q/fRygDKsHp+V+j
 Qf07MfDfe3T3dMX4V2rBQtCK2X4zQZYQ7nJpUsl57gxdgXBdQnM13KZaZRsSvw4AjazcYNrqo89
 B6RdJ0v66EwygrFQ==
X-Received: by 2002:a05:620a:2b85:b0:93e:722b:1f79 with SMTP id
 af79cd13be357-949bab1bf5amr2673440285a.53.1795561878947; 
 Tue, 24 Nov 2026 15:11:18 -0800 (PST)
X-Received: by 2002:a05:620a:2b85:b0:93e:722b:1f79 with SMTP id
 af79cd13be357-949bab1bf5amr2673436885a.53.1795561878481; 
 Tue, 24 Nov 2026 15:11:18 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm430232715e9.12.2026.11.24.15.11.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:11:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/17] hw/ppc/amigaone: Invalidate TBs on NVRAM write
Date: Wed, 25 Nov 2026 00:09:17 +0100
Message-ID: <20261124230917.88704-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX2I3OsJsRv87o
 xELp86NsZgSuCvyvErGOh4EHSGhVCLjGywFz15bygvAgJl61JctvU5KAtwIRbBW/NCm56J0L6Bj
 5sKn3GhOMNESi2SpdQHdNejaS+IB9+M=
X-Proofpoint-ORIG-GUID: 81NpoXIpzURJZ0wMHlFCM4VBw1r6Adxe
X-Proofpoint-GUID: 81NpoXIpzURJZ0wMHlFCM4VBw1r6Adxe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXw228ukB7oYqq
 UmGODgYk9rFCFEnv6nPh5f4318GkrpnE70z+tTXS/nuBvFTOv8tzSHnB4i4ZdOivrqwFgvDrq2j
 52UdAbF9FcnAuUpTD2T0yrCz6FBCTFE2jtjC7xfN3rI9FUroAfTzl9bBk3xzY87hocJNAO/hhsY
 6j6ainZUf74jMidu4C+6ebr+9eitp0sdDH2MGo1qgT6b61my/FgwrvCrq1bPqelf0avALYkkm4N
 9EODaPNrt3nrzMIG0LEzhUcDyXEsKrn1+YB+/KGHRoVG2TmkIuD2igpWzpoqG4asYDw9AQmYHiM
 VrJyyO0Suu03lZ1kZrBXWdTp5YzwM03pkRmvvn/6tUm5OniikqO0WDHNjOE9Us1l91sCFaMCCaF
 Sy798zlH+dlHVInDM+IYGLQFplBdqNdFY7AkPxewuB7jDkksiT4MEQup2ApCufdthJVgey0qmNU
 PBGhwau6DZr222j+Kpw==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b061998 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=0hjgBjtiqwYy6jAIUE0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
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
Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20261124180138.69682-1-philmd@oss.qualcomm.com>
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


