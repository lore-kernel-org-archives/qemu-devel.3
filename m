Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C15AC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoey-0002fL-QO; Mon, 17 Aug 2026 00:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoel-0002dg-HF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:09:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoej-0000lM-Ue
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:09:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLComx4118770
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o7AV7fAGcKDql50aWKCJIQLfwBIcT31pwhRf+Et+8qM=; b=TGDN8X1jUOeaZMgl
 4s5Ae74Cu+lUZuSZtPfRX+febaRQ0IR3/mHHBB9tnSyhL+tyyKDDHMCPLRJr5Nw1
 DIARKlhq8hKzQPtOL7945S/+MtkQ1ta+hje+gGk2d74e4BYHQ8A2YPi08DDSRwzZ
 7gzo7vVw6FVv3G6odeceQoC+zOA6otiYn3UzdAwPGtYNjTVGFci5VdRmCEM/Cfoe
 6Wl2Td78bJ+DP766WyGf28cbviOIK3wfON9e1ofc//OXjNY9p24JT9z+EBwT7Vsw
 Jtf9DUksER63kb0UZR90e1RYoCdthXU+oaXJ7WOuogJIzBj8d3SMQ/JQeS1SphZ7
 zquElQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfd55d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:09:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so29073961cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786939740; x=1787544540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o7AV7fAGcKDql50aWKCJIQLfwBIcT31pwhRf+Et+8qM=;
 b=fFyS0Nc8H2G+HE7f5ZysONlia3dRxDrbT+eYWYIpbWxg8pbMPVxt6GcbVY16PfhwQx
 OhTbL2/g6iMl1fPIytZSh1uPQcgvGqrySsKqI5t6Mj5s3h/mMB8mOCp6dvhV5QgsgHtd
 Y83LrVlgpDMKcIb7JpePQGv34TCXKSN8Sq/jtEvmYiqmfhtwxjbULDWtcch1P4raUFAD
 PPp0nIgBah4SGTf/47AcgKUbvAes6FMw39kAJQMCimytZx4t6fxKVgs3n6iqvmO/O0y9
 5AhVK3s8entnDDLSGdDeTdWoyzHE+W5AHlS74lzA3tM4PpJV0uuWhO35oe+8EPhZeIrW
 AU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786939740; x=1787544540;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o7AV7fAGcKDql50aWKCJIQLfwBIcT31pwhRf+Et+8qM=;
 b=HMd7/JZ7OZh3VXj9fe9GMCgITfy3is25QF70yDgknMtQKi0dug2pmsGDUCmLwmkPhU
 sFWUdHJQ3Nzj2+3PTC+u7K7GOCsjsybi8ZF3vyjen1u3UcYVTcGJN45DDHVGs2kazZBD
 Ldy8Xvs7S5HQpLehWPjXmwWjgdEwOs4xI1b8pdxu1uATlUc4hljBlyJh+8bmEnlagige
 M1pLxeCtNdQhymFTo69QmuufknqVg70JgfN9vgFKVd2NTvAHfmalqeSNIlpD3OBoSeFk
 FiAdal/Y/FqHFqQtJ7f5EwtU8i2Y48TsUg0QW8Y0dvFl1ZWlDbhvDa3cxLrbm53N1S8R
 x5mw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRmztoadX1ZniJj2emXS+P0JV8NeL4jK+kUe49H1s5agWSE6qt9s2P8On7iDrbbIrOAR6Zoj8RLldd@nongnu.org
X-Gm-Message-State: AOJu0YxMfSj2e3bNIG2RLtE2nT96RyjwWwQdA+UgHzux1oaKHNTWF7V/
 LoMOLxy+gKa6s0fuSJopXfCIOTfU8bEKda4kpaKT5ouyi8j+jPERwhzcadfV60qELSpm3pImjP3
 4UnW7pEqcH/z9ImohOoq43lrhIZ+TueDJxvoro5FRnWlbnQMB5zR8AhCZjw==
X-Gm-Gg: AR+sD137P4Y0nLZRTlivgXIWJ8g9FxGmvhGMhZyoCSbVAZKMQLVKLaUr2xlglR9MZY2
 EwRdp+8Pdrs7m+nhW3ol/ytoT25/65Vvmb80nUgxz9SsYCjF4SjA3ue4ZFqpxKPuAnF7UqKjIw9
 ZxDUA33CFgXeH+D0w3SmQKHawIrZT7K0NhKzRsil+VM+eMjR7alNzQqpHFm5AjCuYATiN5lt9lM
 1pA4yM59gxsR4TbBQ9lAP5T8GfqRceg89YCUMF9Lbn7CdZs3Ni84YM+Ob7M1jxrAw7FVnq1fKZ/
 VZE98xjPspC9DeMG9oxA3rYF6gGZ1TCmfhKyRgH+MZhHdcoYq76om+LVG7hpLauhKEa5P3vA+KB
 HGSglNM1gadug5ztQKhuHVpGKBI15HHjPGe4=
X-Received: by 2002:a05:622a:428b:b0:50d:e471:2d1e with SMTP id
 d75a77b69052e-52d854c5450mr245313831cf.35.1786939739948; 
 Sun, 16 Aug 2026 21:08:59 -0700 (PDT)
X-Received: by 2002:a05:622a:428b:b0:50d:e471:2d1e with SMTP id
 d75a77b69052e-52d854c5450mr245313551cf.35.1786939739535; 
 Sun, 16 Aug 2026 21:08:59 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999619a7c3sm101154665e9.15.2026.08.16.21.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:08:58 -0700 (PDT)
Message-ID: <bd4d82cf-918c-4d1a-998b-eaa8d81f956c@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 06:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/usb/hcd-ehci: Handle get_dwords() failures in async
 writeback
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "clg@redhat.com" <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260813072340.637657-1-jamin_lin@aspeedtech.com>
 <CAFEAcA-kKC0WPU2Tqa8Oc9A-1H9LhVr5ibGrksBOc3ZNr54iMA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-kKC0WPU2Tqa8Oc9A-1H9LhVr5ibGrksBOc3ZNr54iMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyOSBTYWx0ZWRfX0czwRvwzWVTM
 H+cBsw29N/B0TzksOjVuTbQfKGZ/Xfqmc5659owvsQHnyRcRhzvogDFTdwGDuSTVj7etCktB+37
 jv9CHdmZrOtbA0s6rP0WRLaXIuYA9o8=
X-Proofpoint-ORIG-GUID: bhmSL2N1IktQL5qxCCW8Noa3XuqYWFBV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyOSBTYWx0ZWRfX5w1juW3Mw6rO
 JMSa3YAor03d9RLtr6mMKT7RniqoG1a/PyOgmE80Y1ldIoujAE4lPqiNdsuCOOZidjk6SU+mu5U
 nLcv6i/JH2vNZRM7Gd6Amm7BU391+fsNrhfFVQvbVmJZj+JtGv4gKRZjeMDymMoY9zjNyD2E7Se
 7vxJaepQ+5NK+DcsAuV/DufLKrnHR0FfDEobYpOZtafHBlJT/8rJ5QdJAOYj1BwWweLaa0T1XRa
 aEhQhouLOjvaRMgKGeHVHYO1Lsdyjcm3hjco+RwEQYa6GL1MMZR6upVq7Lw1g4TPNtF1583zE2L
 NPmr8ITmmBXmj0+bn2BnNyGwY9kf3xMe9dIiNgF9+GpEmzI7dPk5iWCixEJhWA47QAG/AImXcte
 Gwua36zmMcgBMq+uSNaLcwVlcOwHTgbfGjP8EMV6/pl+IW+XehGPmPIN/+CHWL2RjW0weWPJ8eT
 /l79fTGRBnA5C3T2/Mw==
X-Proofpoint-GUID: bhmSL2N1IktQL5qxCCW8Noa3XuqYWFBV
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a82895c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=V2NxCb60AAAA:8 a=vaYj5ixRZCNqTi54SiQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170029
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

On 14/8/26 11:06, Peter Maydell wrote:
> On Thu, 13 Aug 2026 at 08:24, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
>>
>> Coverity reports that ehci_writeback_async_complete_packet() ignores
>> the return value of get_dwords() when reading the QH and qTD.
>>
>> Handle read failures in the same way as QH and qTD verification
>> failures by freeing the packet and returning early.
>>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> ---
>>   hw/usb/hcd-ehci.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
>> index 451a918e9f..d43951975a 100644
>> --- a/hw/usb/hcd-ehci.c
>> +++ b/hw/usb/hcd-ehci.c
>> @@ -533,11 +533,11 @@ static void ehci_writeback_async_complete_packet(EHCIPacket *p)
>>       /* Verify the qh + qtd, like we do when going through fetchqh & fetchqtd */
>>       memset(&qh, 0, sizeof(qh));
>>       memset(&qtd, 0, sizeof(qtd));
>> -    get_dwords(q->ehci, NLPTR_GET(q->qhaddr),
>> -               (uint32_t *) &qh, ehci_qh_dwords(q->ehci));
>> -    get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),
>> -               (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci));
>> -    if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {
>> +    if (get_dwords(q->ehci, NLPTR_GET(q->qhaddr),
>> +                   (uint32_t *) &qh, ehci_qh_dwords(q->ehci)) < 0 ||
>> +        get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),
>> +                   (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) < 0 ||
>> +        !ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {
>>           p->async = EHCI_ASYNC_INITIALIZED;
>>           ehci_free_packet(p);
>>           return;
> 
> Looking at the coverity report, my question is whether echi->as
> can ever actually be NULL. This is the address space we use to
> do DMA, so it feels like every EHCI device must set that up
> somehow. ehci_sysbus_init() does. So does usb_ehci_pci_realize().
> usb_ehci_pci_write_config() can change it, but never to NULL.
> 
> If echi->as is always non-NULL then we could change get_dwords()
> and put_dwords() to return "void".
> 
> Alternatively, maybe get_dwords() and put_dwords() should be
> checking the return value from dma_memory_write() and
> dma_memory_read() so that they fail if the DMA fails...

Oh good point, I missed that. We really should qualify
dma_memory_write() & co with G_GNUC_WARN_UNUSED_RESULT, that'd
help us preventing such mistakes.


