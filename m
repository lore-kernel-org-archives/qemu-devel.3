Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4923C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weanf-0007QB-5G; Tue, 30 Jun 2026 11:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weand-0007Q1-Rq
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:55:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weanb-0006l3-Tj
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:55:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEDKip2217091
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cqQj/JNEycemoIKPGXlc2DE4FpfepTwXna84lWWRfHU=; b=EHenxBBT+5HBXp/A
 DXYIQjbdSddLgwiImR01hVxxYLrss1397N7jOsuww+aWdNwUNQ97hKA7nv5MeNna
 8okBc1PT5Gpv12rge/h43YeO7hcJzD3u4MWWJcBE6MUApDDn6AJjX5CvlQRvFiLW
 x0oJBz4jqJ1LOFWCHpZz1J5gU5lyOH7jJP6p7XFx2QOOyjCRz8jDNTSMtHgTzB8i
 ECNKyHDFR0pi04+4Qq1ze5/fuzVQ0u96tvDl3gogNFScd8WNCSo+0k9W+RE4Gf7D
 eMkKVvXUqh01KhtBZvSxkzd6pyEkqICmKajflwF6+213xcNBOFcTbTGTTnCovXDx
 QdqNzg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfkh7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:54:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f27f49bso369248285a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782834894; x=1783439694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cqQj/JNEycemoIKPGXlc2DE4FpfepTwXna84lWWRfHU=;
 b=dACcp4JtBVPqW9kz966fLnAjcyIoTKvItFWmTRl06rByxuNpZ4TgjLc/MBEnYH8hk5
 XwAd2e99KEQkVhtnd3/uCfQqImBsK3JluZOHQUIoUoZ+mHQDjRPvKahxVqy/uGuv2TXB
 AGWiZL+bPcG2Zhm6cvgdXRZsz6np+5rblb1qK/+2++lAGEp3J6uzaaxSkOqh2jFsTnw4
 Bna/U7tDvRVW+/DB/VhQ67KhWIUJbYYLwejge8IsS2e24b7BLmiCzbX0rseUZJtY/qzD
 oD2zRbV5GN27VKk2fgc/GxYnNsqKwhss88j/iZFwnqZpQW8Ix3a86LMLRrgnQKszCAIL
 XSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782834894; x=1783439694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cqQj/JNEycemoIKPGXlc2DE4FpfepTwXna84lWWRfHU=;
 b=BfrJuS/elIQQQ1WPrk1CvuFYHnAhm7P8SXnc2JCKxNzBvuYTlHc8LOWDmZqsa+nQGX
 PiiCvHNAIAdWwPQvpV6vquz5rgSxxPfW5etbgDE9zahQwEDROW1q7yFnA3+TQwyu05AJ
 v2hAR8PLQasRfUvaXxV7Ik4UUjq4g0gINaIbJ2WGwoseAzaOotRNHuVk6PGExzofpjTF
 s0roJQJp8apicoFzzFM5A/wbTvktN4AJ0qTMrpDRWnXlS3g0Nnq9/hk3oztFJYmYoxS1
 +FH/oMzwj9MZgFEDqKhgY+2Phy5iBhdDIXyVLZTl2t/7Fo15Yz9xBr876Z9Ihh4lByQI
 uroA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CfEeuW42J5kkUwS4lWcgOAD6xKg/ELHbGi++XGlv97ZZU/T8WlGmNAec1OgFbP//pSbIhXQoAq0IO@nongnu.org
X-Gm-Message-State: AOJu0YxSb+9F5vXdnfuvAh9kyLzJgzuo5wlzkuJmtVhyAUIdgCmlCMMC
 9f2nUCDah4wwCmTxKFrauJP6OKn55pcTeiL3t66OVhfAI2fVpa7Y03qLX5PUI/4RhhrowlMy3ki
 lGS+U7SMeIPq1DnycwJyb/GSzTzDtCDW8VUfETs2JAA+/2F0p7tnVBQCF8g==
X-Gm-Gg: AfdE7clh0aOZmaLQuqk8AJRo7qjwM7XfOiS/O/hiHtuvQ+cxwBKOzqM5chgw9jLuGIJ
 KZGNTP2wEgOtgJkiVanSbCpadQMAAnIIBxmmudJXzgD2+wX62VEm/i21TfKZReEwpeqkq9v956s
 zX+9dG+iXTD1EdxHId5ktnoscDxPS3D//z8aHgK/W+ZZR1ryCjYfiK7G3rjlHOjsZyhjKzsqwfl
 Izua49TCAeZCx1u6M+1q5zMD6G05/1apTpRrjng6Pxl27CVOAjPyWOYsT54UDMFVCc9srfA+THh
 HMGut2hSBzcK2jE6M7vecvj7ct0uu4H6vcwbh13KsDk9YKWcvXdS2m7qs40aFrHS6+9AlEeYTkw
 be8i1kph7kebfFm9tY/NvUB43gJDhqti/pNtH2sdu99R2n+KOPKzdCFLgckTRvw==
X-Received: by 2002:a05:620a:2951:b0:90c:be8b:3676 with SMTP id
 af79cd13be357-92e62886f7amr681014385a.56.1782834894538; 
 Tue, 30 Jun 2026 08:54:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2951:b0:90c:be8b:3676 with SMTP id
 af79cd13be357-92e62886f7amr681006985a.56.1782834893793; 
 Tue, 30 Jun 2026 08:54:53 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1288f4c3aesm152445366b.47.2026.06.30.08.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 08:54:52 -0700 (PDT)
Message-ID: <90e6b1ee-8337-4bb1-ba0c-0fdfe451487e@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 17:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma/i8257: Return zeroes for read_memory in verify mode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260629140128.1900095-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629140128.1900095-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x0TY9w4O4p48KxuLuc0Jv7kyCYPP1peY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE1MCBTYWx0ZWRfX1j+JpoNQeMkQ
 Sf/+8BRsr+UXeLv3sT0+/lIpalA7xn27oD2y08RYxlsmSBSz7pGCLfNJQiTjaXTM1bqtdJjZyUL
 cpH/XEj1MceM6nH4dqnvhRH34gCP6GLv8t+2mkVvcZ+p1ZrPgFwpzJqcbPFMSDX7sMwH/o0YErm
 ojAfTNYqM+hVZGXT4b78rSlarSd9Wtoh1oEyi+iZk2eX5fhv9/g4Cwb/VQh/tKGbHgBD/NnsYnQ
 1zOkshaLGDcuCPK8b41yBLoD6KBncEgdXf+QLDYlGAzQrWnN3/5DoxnqUuKXAjf2MFiLSN4vSOi
 XueXIiq9SoVPucF5Zmo0k7C4E9mEvAEYtHYaqCbV4gYbAljThfcrm1n2Dmd+xzuPHhQhJbcJOuM
 mxcu96VtHibOfAFMjnEOEy4787qvtK11xH9v+nsphisdlqk0LUDyacS6/BIcciNCzKOB2llLcxu
 cF8xu0075elJe0D3rtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE1MCBTYWx0ZWRfXxQQSXqHXYk2V
 KxskxO4HgCB4oopxJoMTkSPpj52lGKvS4agJfS72E9VRYY7btuXS3sUFuHXR3TdjL5awwoDELdf
 t0+o4CtXwOk3439ggrojJ3GvAO27LVk=
X-Proofpoint-GUID: x0TY9w4O4p48KxuLuc0Jv7kyCYPP1peY
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43e6cf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=eIhYIOwvZRR6YV1ZOekA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300150
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

On 29/6/26 16:01, Peter Maydell wrote:
> The i8257 DMA controller has a "verify" mode, which the datasheet
> describes like this:
> 
>> DMA verify, which does not actually involve the transfer of data.
>> When an 8257 channel is in the DMA verify mode, it will respond the
>> same as described for transfer operations, except that no memory or
>> I/O read/write control signals will be generated.  When an 8257
>> channel is in the DMA verify mode, it will respond the same as
>> described for transfer operations, except that no memory or I/O read
>> /write control signals will be generated, thus preventing the
>> transfer of data.  The 8257, however, will gain control of the system
>> bus and will acknowledge the peripheral's DMA request for each DMA
>> cycle.  The perihperal can use these acknowledge signals to enable an
>> internal access of each byte of a data block in order to execute some
>> verification procedure, such as the accumulation of a CRC check word.
> 
> In practice, for QEMU's purposes the only real user of this is the
> floppy controller, which can be made to perform a "read data from
> floppy disk and check the checksum" by telling the fdc to do a read
> and the DMA controller to do a verify.  This causes the fdc to do all
> the usual read actions including the checksum, but the data is never
> written to memory.  However, it is possible for a guest doing
> something silly to program the DMA controller to do a verify
> operation for a device that wants to read from memory.  Currently we
> simply return early from i8257_dma_read_memory() without writing to
> the buffer.  None of the callers (the GUS, sb16 and cs4231a sound
> cards, plus the fdc) expect this, so they will take the uninitialized
> data as if it were from the guest.  This can cause us to leak host
> data off the stack into the guest.
> 
> Make i8257_dma_read_memory() fill the buffer with zeroes rather
> than leaving it untouched for a verify operation.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3487
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/i8257.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)


Queued via hw-misc, thanks!

Phil.

