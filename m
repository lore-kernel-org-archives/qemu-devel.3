Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A437FC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7QS-000739-Ip; Tue, 21 Jul 2026 06:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7QP-000729-4t
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:10:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7QJ-0007Ur-Np
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:10:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LA2KkB2445186
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HCTvmAZ0P/RMuVowdn8AwCI6tT/0/UEInjMWmcfWez0=; b=nF5wbAOICxbxNsoQ
 RdJqtC42Cv/RjLAdm4M60HUvXUa1/kYaN0qQIegbaHnDRBmxg3fUReSpSVD4+l5A
 S0Y3/f1QNk46HJZuspjzPn/ANRLCKmk43kvJ4tTQ/w1hLS3stNxyaNWQDykejSHq
 Jy18sKmHrux6LzHyTMFF1EY/k/Eg5JYKb5uggqTE6FTlHn1mpqQpgkl4T9YmdxOk
 /G1ZvsP1TUPRyUUyGuJjSyEj3C6gkzz73km6g26c9FhMNZ1VrAgShLLYKCidxXhk
 vk7rbyaUbMbSS2FQ2wEBv0aWoCWwIVBqKqGwmiJJkD7QxhglwMV1xNhUN1LQNcWh
 rHa48w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6nsr14v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:10:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso168008971cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784628600; x=1785233400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HCTvmAZ0P/RMuVowdn8AwCI6tT/0/UEInjMWmcfWez0=;
 b=WPmMSRvq4x/OQVI1P11EgtyD2zMblXyVHqQtd5lfurAvrIRaqgIDV7/rcIqfWINVnJ
 pEXLj+kchdzXg5DKkxmeQ36gHM9erYMZJaa1v+5WWaB06gflBpe2LoNDuKLVLuHt80hi
 e5H6PYnd2JforGWDm3veF7QbxBm7/IX3f0UJzbHDPrCdzwgFlDuzJJTGlyxVeeA2S4Am
 Exkp4WNl3i0HdRdbpJejknVfYsC1wa3QTNjdfNj8nmp+6aTAjSapGfGEGy5yz/KT7Kr9
 9Q7KFLOwoWCbgv5jNWk8SO+BBUpUeY17mxgreeWhi/4PkhrDLKapjYce5MILOIDddHoV
 nbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628600; x=1785233400;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HCTvmAZ0P/RMuVowdn8AwCI6tT/0/UEInjMWmcfWez0=;
 b=ptOWiNmTAyJraXy79thi5/fRpLZLYWzggZkzYzOW4HetnuHEceV42+rMlEOtongoFV
 MpnTrd9O5wnOV6ib1+35h1MFHUpGy6R5uJSIU7/nqI2imkjv+oQ7zN+FSgp5aKBarXfl
 8T4XPbwAKg/u6Jh6geB41B/TY+ttrDr+VdBTJm1y6vUUL63r2ab8mzR03Z5om+4KT/jf
 1MP+1kLz24mugTWI2Nq35A2jYvMghWM3gInnDZk7uX/oIBpDRbop/xsBcsUUQ87sHnJ6
 uQnxYNpDyGuoi7GDsSBlryMHEAXxx1+dP8jw77U4KstnwGUQGrHOP25BjfJ2u7I6GF/A
 J4Jg==
X-Forwarded-Encrypted: i=1;
 AHgh+RphT7v6FJ9ngX479Kp4Z8fFiBqAXv1iwMWOYEebiqWSqcf/nLxT5HmJEHgU7NuFxnwDHGVw/Ah4ldVH@nongnu.org
X-Gm-Message-State: AOJu0YyOzSFzkUEfP/r+j6JlvU+6ML0cpkCpaPbJ8iYlwDIaxbBEddFs
 2LRnwAiofBnGCbWzgxtSfew9U6x86W7lsZUSZzWFyN4Ht6D83voUos/rptxaY0c5rpYk8YjY1am
 wWP+k67MlbjqbH6+eZSICugPSYD+N6qyzfldSIldFjWsADZNQGjbRi/BFVw==
X-Gm-Gg: AfdE7clelCKfpupsRxsIUyyM+xBDHilcujlSV1XSVFITH8eV0Vo+em4aLAinbfURS0k
 2lsnzyyrbECDnyxTlw1MSVU53pq3onozE/e5oS/JQeBzfsDMiBt/MLoeh1yqDeuiLiNVJ+ik/je
 IIP8pNVJdRpT/4hSoNv6lex6YddUIe7JW5ccoBbHLouRwBN2EA8Y7ilqXzCg0akRPC8ya4hlRQY
 2p5ZC2zVf65J0mBHPnY51mQ4cvT9/MRsTjb6qDt94JKL83MwSTk3V7PEczdfinFFOWZfHvTY+CH
 0PQ+eq24gLchz8JbO7gK/M5QSTyb4QrBArVUnWbEPl3ZD208f5h2suDiJofjOyLgPkpsQtI8Nzw
 9qtFJHMrtrRjJHp0TCR7Zm3ELdnBDJzEz4vHmEoHihSi2gVOwmhI=
X-Received: by 2002:ac8:5a86:0:b0:51a:329:e802 with SMTP id
 d75a77b69052e-5213f66c60amr171260571cf.41.1784628600603; 
 Tue, 21 Jul 2026 03:10:00 -0700 (PDT)
X-Received: by 2002:ac8:5a86:0:b0:51a:329:e802 with SMTP id
 d75a77b69052e-5213f66c60amr171260331cf.41.1784628600099; 
 Tue, 21 Jul 2026 03:10:00 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edda9bsm38030676f8f.31.2026.07.21.03.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:09:59 -0700 (PDT)
Message-ID: <a5fe84ae-14ee-499d-bfd9-7116fee18a49@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vfio/pci: reject invalid PCI_INTERRUPT_PIN values
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260715191735.2454719-1-den@openvz.org>
 <20260717122232.468955-3-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260717122232.468955-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HnW4Wu7oG9e1EmCZNpY74Rb8a7UIK4np
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwNyBTYWx0ZWRfX68YWLbODah8d
 8KxAEuSH8nHoZVDtcJDOLkeiUuB5AErfCw3OFvPEohoqOoqUY/R4+kdSVw8oqBS+6IYg2kxuO4M
 PxmDlqOuHYPo8R5OH1JkWoYiVmja0XM=
X-Authority-Analysis: v=2.4 cv=ZJjnX37b c=1 sm=1 tr=0 ts=6a5f4579 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=6rqHouBjAAAA:8 a=r1p2_3pzAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Hx1yvPaMooE3kwe23bt7:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: HnW4Wu7oG9e1EmCZNpY74Rb8a7UIK4np
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwNyBTYWx0ZWRfXzm9P6OZPSfZe
 WzCD7ls4XLhcfuPRk82iyvQLJCQlRrN039CjnOBRT8NZVNQotOnox7Snx7nkaMZ7r58faxAuhi6
 wPZpDnhEh9KcKpAd/OS1O906B90nQK6z+sxNtl/wHFGVMuELyTlxw4IR5pG1YGqwrVOXcIweBQF
 HoT2xqYlfi4xK9+lgqRgqFt7ZnTzafkXpYHoW8MMfpubOd7FzHK6UECngbx/TduspSENkL9SLOH
 IT6QbzkW2G/JJoM3cqfQL4YIcEjFsN+RggyXzG8Zde3frXTKEHio5VdLFWURmqgkbaKEL5nElbP
 zn2uszyhgIkDWTusC2MKHqrk4Yn5nY+mCwS4yda7n+kNdNaisygfk+seSEaD0ReZZNwADDnDfIV
 hAGUIT/lyjueFKhQOOpsWNBzO7kr7IC9/FSAqA2+JmVjFPfq+7498Q29+wLRbZzYkfPCSYb7PvX
 srE56dmwGWpU2gVFmWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210107
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

On 17/7/26 14:22, Denis V. Lunev wrote:
> qemu-kvm aborts a few seconds after starting a VM with a
> passed-through GPU whose PCI_INTERRUPT_PIN comes back as an
> out-of-range value: vfio_intx_enable() only guards against pin == 0
> and stores vdev->intx.pin = pin - 1 with no upper-bound check. That
> value later reaches pci_irq_handler()'s
> assert(0 <= irq_num && irq_num < PCI_NUM_PINS) via
> pci_irq_deassert() -> pci_set_irq(), aborting the process.
> 
> Legal PCI_INTERRUPT_PIN values are 0 (no legacy interrupt) or
> 1-PCI_NUM_PINS (INTA-INTD); reject anything else before it reaches
> vdev->intx.pin, whether the out-of-range value came from a read
> failure (now caught by the previous commit) or was handed back as
> data by the device itself.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Alex Williamson <alex@shazbot.org>
> CC: "Cédric Le Goater" <clg@redhat.com>
> ---
> 
>   hw/vfio/pci.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

