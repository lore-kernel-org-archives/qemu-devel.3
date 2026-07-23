Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58E7C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmoi9-00011k-Je; Thu, 23 Jul 2026 04:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmoi8-00011J-GB
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:23:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmoi7-0005ik-5n
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:23:20 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7BYAf3157841
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7OSdMNcX4C7g6RJL/Gx3UkTQgPYOtbTDwsa0DNv+/U0=; b=naLkbpxLTT8YHQfy
 2WzOehdc7DXmgZm/eXelMYLtxZN/xl6FQYJAdXTh4mrOpKMS5JcrWYszycWiC1V1
 lilyFDK9fVDeoz0AnsTRViaRm4plsqYrNt65pcm4r5Z+Dr3CTLjHZsNAk8FMeZay
 dPDgXyrZJ3s05xuv3G3WQE7ikDDEfc1R9iGHMYrNa6lblLlTsD31m4MpJTl5qK/v
 AvajZmjz06IHli4Vn2GfngMY1KIY25ndva1iU9mNGFSBdhdcD5X2Lq47gyQcFZdZ
 xJQLRP7vgpiZDFHrBVQfE+JTOOkwAkU8Ca3ufJMZXZDb1sBS8UzwLw6Us1+JqC+A
 Gkz66w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0krbrj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:23:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a23afcbso3534701cf.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784794998; x=1785399798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7OSdMNcX4C7g6RJL/Gx3UkTQgPYOtbTDwsa0DNv+/U0=;
 b=Qh6tXcsyBnYAn4Sk3DHGbE0xdY1oniI792JIfzme4L5fl8sfyF423XCpIuNq+Ekfd5
 EBTRsiURKfLvOoNoIdpicqQsVDnTdO8EIkHFPw16Iac2JhQMrJwdR+25OTaKfNws1ISG
 WOkwWVAaqcaEjHRxF1kmnRZHlKLTpIR0QSTLthDVTJHgU7rnfKCUxnJUcj2icMLp7R9S
 pscMBraY4PGYKth8rgGcGgYQ2pqJRtIXct+gxcRoavJwKK0FhGlWxCQ9x94BWp2vAT/u
 zF7DKyFL2vypsuT0vZkJuI16sbMkI99K/iZjGbNmRwyWrWBx2P7P7CH098Ran8SZbwUz
 GyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784794998; x=1785399798;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7OSdMNcX4C7g6RJL/Gx3UkTQgPYOtbTDwsa0DNv+/U0=;
 b=qrSJ6uujoCoeMQrZQ9to6nwi4nBRSG0LsHJF+n3bUDmgk5ozJc05LQOjigDjinUUUJ
 VkUWSrCaxWeCTmUtXxCE8+1mkyV17n3rs8Zq3zwvQfbmZaTTVCraNrSH13owYYvo3PbG
 AAHdBSqiFgr3Z1jJwRlIAzJwc8bt3x/K0czuwHoTFqreBtyX3jG3t5G3zTxk2k3leedK
 9UsLEya2b38fyKMWzZVdzFSEaGxDo8Ngu7CY1WndQ3vj4fT2LlWJI+D1SlVHmlweoKRr
 yiqOFgEphkOgFM1Zv0jKrFirvd2GdimVNgwoSQY3pnV7ZPjt6NRhJFOf/wlKsYMjj/aj
 dUZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbxycLMGkZAiZz0NDBPNnWEJvSWrYlUKRW98f2DnIWv63zvF5fgoIngOM+/Jguf99AuKS0FiLuSmyg@nongnu.org
X-Gm-Message-State: AOJu0Yzb7euzQMWvBCXx4NTExDw3lCiiSTiMKcEAdb2u+a1QO5VcsjVD
 XuW4yygDQyNLm5wiwj89rMg0/2vjHxGH0doIij5VFDInzu5AdpzrL4FwjrVOGaFeg3gwodXxwlA
 F+qtWUl4wRKQ2jIrNo7NfMiuiYaEHgo6gn/fMtlDwAxZ9hOijTrNw6dS7KQ==
X-Gm-Gg: AR+sD13MrnFfJ5NXDl7xWVGdbtuRTvFj3ZOD3KOKdOSeULNMlfPYwwThOOS/CksMSz6
 qGr5kjyS5+jlcj3Jz3Jyeb1K1jc2oigUm/Tb93Dd0uXvQ0f1+n065QaRVzrkvQ5dCd/KanyIowE
 nV419XytFR68uYsTI5uBiA9Md4nhZasY/BD55b3S7vKyYFizAL5lA5Dfe+07NbeqzgJUyQJxCsc
 0WdK4nH1Ut9epS2ir7Gho3h6Aw7vYJSGmlKn1UxleW+Sh924VFAHqzimpjZEvpSJTGgMwvegR8Y
 ct9uA271Fn7uBcVCOOJAt51EokPU95P7rCk2qme2OjIybz5diIAgVygVwjUJEWlsBr+54Fu8m97
 cB4DOb4Wjagn+HuJwqvpiqdwS9yFZtFrZilYuISxNdJM0sysIgk8=
X-Received: by 2002:a05:622a:2445:b0:519:51b1:e764 with SMTP id
 d75a77b69052e-5283decce83mr17939641cf.47.1784794997627; 
 Thu, 23 Jul 2026 01:23:17 -0700 (PDT)
X-Received: by 2002:a05:622a:2445:b0:519:51b1:e764 with SMTP id
 d75a77b69052e-5283decce83mr17939431cf.47.1784794997122; 
 Thu, 23 Jul 2026 01:23:17 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49574653f83sm21459885e9.0.2026.07.23.01.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:23:16 -0700 (PDT)
Message-ID: <b6eb2c30-de04-4bda-a566-b5054d428b37@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] hw/net/flexcan: Drop unused RX FIFO register overlay
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723070059.6332-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YTtOBgI_ELEu5MDhvrVbwk9cuHK_4cZG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4MyBTYWx0ZWRfX99T2i2Ws6Dxs
 OqiJRz58FugQXMPAuTtKZFGdKY59GwamjJwj4Evr/NNKOtCix2eMvDLdeLC2poYkVWT+p0as5iC
 ifsqoTsZTQ/3BltviHtTnfkD7vC9Wfw=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a61cf76 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: YTtOBgI_ELEu5MDhvrVbwk9cuHK_4cZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4MyBTYWx0ZWRfX+owOBZXgpJR+
 BXua1VAiJSjWfA/09QE1sy9ESmbrR/CeC59ihTVhwnrjfOaQXSrP+RccrbOfJnWT+AhkAiETiyr
 ghX28vkmKInM4OSJ9W6+ICNK07pkQ+ZQqNCX2lCR5sfdVdVLhXHDzwqeAJuaTWSC4K2D6brjHJ6
 mART+6EWLVS8MLUb9adSMWunr96lC/pOcPCDPOgeCn/fCP1Jc5uR0FJZZ5/zeSCwymUe+9/S3qo
 mtIZftaU5ZQMYmNjMgNngNGm9vLIpgUfw8oXC77r7pRCm1rOo/wsX5yzTBvYYrt4ErCDxEbkm35
 50v1eUkh4TKm/H3mz41EiEYRhnX9Mv/Vmjx42FfP+wfXNSg7YdqZgUAq52VXTJ9mz9Ajyi598Ye
 E7XKomJZsSZYwnog5qD6KVkEq68b5wI0Vh2Dx6rc18bYtN0jTmPcmtiuKEm5v2tJw4wuwz1vmm3
 5YZ7kZwvK0dIBkGQSBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230083
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

On 23/7/26 09:00, Bernhard Beschow wrote:
> Remove the unused `FlexcanRegsRXFifo` union view now that FIFO accesses
> use the underlying `mbs[]` array directly.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/net/flexcan.h | 11 -----------
>   1 file changed, 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

