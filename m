Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2686BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5ZP-00088x-3K; Tue, 07 Jul 2026 09:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5ZM-00088g-Hh
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:10:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5ZK-0000KZ-Ry
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:10:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C92R03590133
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y8XIyet9jz5eOo45KSAGf8vWeZtGPGFcv/nkVU1S9Wc=; b=Zxz7ettV9zzRYeqN
 tZ7P+UVOqNcNxVaxjb+qRq/h02ai6btkUfeo5wMkTBQizcVNMkBSi/W/h0XZww1Z
 zTRHSx8+tqI4W12464cLGJ0QLXHuE4B0dPphpGX8KRUbFSsVZChfc4YpmvABSFvj
 9RWsALnOKkLalxkaYopJYnRpNY9vLdSTnwm909F8lVBWMmlUYomd7JyRcc9WsrNJ
 PAve91sCAnPS3GCsb9/zcYBwgBd14pvIgDT7UVgsIh2Uk2RdHPn13cy218KQztNU
 /kIdMAA0nucvciO/wr3tsaItlUzzTkE3gmaeaZUgguM9BbOG+5h3U5Uz/YR+b9vf
 se6dAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u9b32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:10:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0199faafso48063171cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783429832; x=1784034632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y8XIyet9jz5eOo45KSAGf8vWeZtGPGFcv/nkVU1S9Wc=;
 b=Dk+k/VYYfvkak62zAEng+49ogGRKCeK95T+ER7jFs+iRgtumsXydn4yx2QFbO5DFbA
 pIsVtFD71n+O/rkMZKTnYyve4zSktZNuRka0+VNVGuyDIktO8LFSTisCJ5ckHMcFC4Tf
 DOa6VX+tJ1HwkPGPVobiuZEQh35opi77/B3fB2BE6wjLHY83VCYlogkSbjIw+Cy6b/Bo
 wbmB4/+MeIYBwL7Rzrcl2MYWDBzFxKp/mdaQPaWG+hK2IAV/W+KhJFHn5qGr583fhU84
 9NwPyJa/IzejBW/b6ZHKopWM5J9fni16wOFDIH+v8pDOuhbicwtKejqbzp6DtYAlOWJ6
 C4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429832; x=1784034632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y8XIyet9jz5eOo45KSAGf8vWeZtGPGFcv/nkVU1S9Wc=;
 b=nCYzHAPf/cHH0CcY67Z6qJMcKFHE8ZD/fPaT/BXFd4iuGYJe7fkwzeya8P+XJbLUWT
 dt8oo2Pbnspi0jqmjQY1tdJx6j0445yzvyg1Jqi9qxhO5rzsHEnJHBDQiKSGTYhEWU5K
 yWKtOqF+4PklG3alvc8yCqVoHsp+uaf98KhNlofzcBHeRcmx5emoYkRTVZrmM2bIWaGA
 xqkJ7MCtuj8akILogzv9CsBUjeO8cAnBR8W2qy5ilbSVtugL1hUwksGVosXG6/eRD+3G
 p9tQdLTqL+XclKor0nN6+BdNUY17WiKmn6tL7iD98O5zDql1fFBBUR1VqD0ZDTw0PSpl
 v60g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1WfHJMy2AiIhiw5ZbGfUHp1GP1ptvogQPKEBsD2C9OmEr9idV+YXJYyZYdFKZtmsAsuzmy88Vmwrg@nongnu.org
X-Gm-Message-State: AOJu0YwG5732Bxa1swagK0P9j80o+cYi4RkhnNdrlQDoMpMSx9ZrPB7f
 Mjj1Sf4dpDzCpjOKGe/O0J0Q4z+LjhxUx0v7RblAjWjKH/OutCfBv2XPgR0BP+6DxMI02dBQrYN
 Bvq8dn83evEhnROliemY+kSsirEycOa4RUJZtWMQ7jm2pqCGP5zsieqpn4g==
X-Gm-Gg: AfdE7ckIqkCQeIP+gv9e1eD0vS2SdyXVEpeVRzvcrOzNUz2J4u06wXpCw0x3POIRODa
 jODCeM9i0utvWncNXynkWk8TVTpj2fmPrZYWh+CW8Ey0dwXFn6ai+htCN0M7ijCfxTrGMWkShO6
 lqnhE1DPLJzv49V11QnWh2q6HHP6GDR3Kigv0k7bDw8sEUufh2YyFMYbx6nb7+p21MlTYc77Pn3
 q66HkHlrdKU/pQSo4BNpuUT3WBQDxVx9BPmylmBDzXrkNEl+0jOlkwlARSO8jU/nZRpDTRR+tLf
 8NRlcQrC9WWbEwI2CsHxr2sviFxxFCsXrniRGcKzq1gY0SVdh2CbI2iexcBd9L9qRy9JcMHAxEs
 kz4HhGP5scsU71WGREOqZKgf/FHxCp5xcBgDpcfJGEH27KYeSY6koqVwbmZ7r8g==
X-Received: by 2002:ac8:7c54:0:b0:50e:a1ab:114c with SMTP id
 d75a77b69052e-51c747bc3abmr53510551cf.32.1783429831653; 
 Tue, 07 Jul 2026 06:10:31 -0700 (PDT)
X-Received: by 2002:ac8:7c54:0:b0:50e:a1ab:114c with SMTP id
 d75a77b69052e-51c747bc3abmr53509731cf.32.1783429830891; 
 Tue, 07 Jul 2026 06:10:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cf68f5sm6180104a12.13.2026.07.07.06.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 06:10:30 -0700 (PDT)
Message-ID: <8e6e16ff-ceac-4e87-af95-bb52d5cb57f2@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 15:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] docs/devel: Document SSI dummy-cycle ownership
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260707083431.219671-1-bin.meng@processmission.com>
 <20260707083431.219671-11-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707083431.219671-11-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX/l9IfmDDnB5L
 EWuyS3gmxEiwhD6H4T4h/L1Z/Mn76QeCTH8uLafSQQpbN8jh38P8kQXR55EanyM7Yyg/YHS54fJ
 EMu5D5GBpCAL7Ut+eHGBtXMEk9j6v0I=
X-Proofpoint-GUID: bz2EFXu3xG-ryq-hEJmcebaRtA9dX1w2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX7G5YPmyzhxPS
 pSoMQ80f+2zw95jZl92MW9YAzhUsXRvITIxT5AdUSVEZqKfLGtGfMKdzrk1sogVs6urf5WGUYTT
 RdAvD1orzWkrFTQ1EBblzXrDBNJjly7tHh628JBZKuyhMvmOLfkdjKGYV0BH/bnP7vfidrTUczW
 eVMTWqiO8cln2qm0bYxUejl9IpqL8ANoTLQWk6Q6eX0aH913f1cjlxw79tHHnOSIHdtyg1PnTM6
 5JW7wOgmPLN6rfws1spm/vAsUNnD6RiRWexk4S5PuM5MiCH8AsEsidgczOx5CON/s75y4HqeDG7
 3jW77pD6GCmJs8AqLXpmvy83GX9XtwJIpgrRzrRRIRPoPhrnkay4DxNxKUZqMbUDAl1C87EU7e+
 BdDBGhGzELBvcS/dlXMva2Oj6rLcL8I1bsSRf+2ff79zynuZlnbQdu+3oT/Dk3/5zQocgodzhYp
 5boisqO8Vn+NLC8lCLw==
X-Proofpoint-ORIG-GUID: bz2EFXu3xG-ryq-hEJmcebaRtA9dX1w2
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4cfac8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=rsnQfCYnut5FQG7pFV8A:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070128
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

On 7/7/26 10:34, Bin Meng wrote:
> Document the boundary between SPI/SSI controller models and SPI flash
> models when representing fast-read dummy cycles. It explains that
> flash models own command semantics, while controllers own
> hardware-generated dummy transfers and cycle-to-byte conversion.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> ---
> 
> (no changes since v1)
> 
>   docs/devel/index-internals.rst |   1 +
>   docs/devel/ssi.rst             | 132 +++++++++++++++++++++++++++++++++
>   2 files changed, 133 insertions(+)
>   create mode 100644 docs/devel/ssi.rst

Fails checkpatch.pl, missing:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e239f21166..2a9cf15fc7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2345,2 +2345,3 @@ M: Alistair Francis <alistair@alistair23.me>
  S: Maintained
+F: docs/devel/ssi.rst
  F: hw/ssi/*
diff --git a/docs/devel/ssi.rst b/docs/devel/ssi.rst
index 864b5d93204..7475d7f241a 100644
--- a/docs/devel/ssi.rst
+++ b/docs/devel/ssi.rst
@@ -1 +1,3 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
  ================================
---

