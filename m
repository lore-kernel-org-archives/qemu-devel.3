Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DD6C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvona-0004yG-DM; Mon, 17 Aug 2026 00:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvonX-0004xo-5u
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:18:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvonT-0001qk-Tg
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:18:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLEoZj3309446
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iQ5Q3uDVgApKy8gvGAqO9GzAOYoK+5lK8gcWU4U7Gec=; b=mq1KLWqRjAu+gTJM
 j5hJvVdcIg67KDCP+ALh5I+qWtoXHbl9Mo2Nv+a6DGNyBQ07Qdp4UhyWCqD82I/H
 3ZanePskyEiMq2CFu9S4Nb7cjGkh38yDKb9Uz1YDue0UXn8n1Tydns2b9L5bF3Av
 EpvzXabZdOMFWV8hoAnoqlsgMsxMP4uMnZb8h5CvDsTztCYj0LKtIFiC/wKsnXUc
 TgpX66BQWca0ci37SowyBf1NVBJCvDRfU7fhmEFVPPx9cOwQxfwq7CAmnlP0navw
 RC586JmJylUpvuEhkoKqrb4HBMM1GZdlxuUOrbZOaKFdlNrnE1r5uvfB16Rcrwxl
 KTz1Tg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq54x8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:18:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so512751685a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786940281; x=1787545081; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iQ5Q3uDVgApKy8gvGAqO9GzAOYoK+5lK8gcWU4U7Gec=;
 b=hx1NIKPV+W8iDTn1ODo7TYDBybtp1o91NF1zim3+38g/AK9YHaLkZ4kYFbuGAuQ2xI
 yXVGKGzVOcXDUUp2REGfYUMd87rBRpfR6elt2tACCfesSFj7iJ6pGwktvlGmAul+06nu
 wfi+H5ZAFq1Upwz7lVwd+f/zzyI+0c//qDULI60yudqPbZk7FX0rlWumxiEruAU/MvJK
 6kpJVRxG17DrfEhp/SZFPx1brZoN6yZF7wPrc4TIZkrF1sbbUrLqyfZRaBvwVAXvZcZz
 M8zK9dsY4yC9FhBWd6QWyPluyJM11FQSw7fecPS/RnKtyCFhOPXzwn1nqauT4lrDoWJp
 PtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786940281; x=1787545081;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iQ5Q3uDVgApKy8gvGAqO9GzAOYoK+5lK8gcWU4U7Gec=;
 b=TIL5iHa/zELbKOy+r5eZhNDnjUqDMXSNXs2UVKOhBn0yW3FKyitQpMFKwgHoq719/P
 UJ/8ALq6NGn1Eb/zNF22i9/nHgUsLypWN1Yq/BrWwq7TN+aYcYxqN64ltZJVSZe9w7pm
 /HMPHi+aPF/lrjuXSo83QSp8iTlq2X88pJj3sfcclTlXuRkaeYqFGVkgyGMhgXTg/I/3
 5wcEx+n8uil3sh9bNhIwAupcj9BourkbaWe7BWKElSZQ5IYKgOQy4mqlWcDs9dCpzTFd
 D3ttedKA9qdxNR3cPwNfUyKH0WpgU8eTjOUP9uf3ZV0yxP4ZNEVRqXJrne1lEAUr14Qo
 1zUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWnSIQp3lQRyMxGqqpriXVzdsNlAvX5OiEju4hXlys4WqoxaK01EWKXr5dRRKF/xAL+7xDkh15Ixv+@nongnu.org
X-Gm-Message-State: AOJu0YyrcAgL1MxNjrvslAy3DF9Ne/3zZE+pNhZLLQxzOpGPiNiTdUmH
 np5p6ApWqksaDA0AVFMH5EQkuEh+HtcgrgQ3xcB2nqE23KWzc8n3F+wGqYqB3WQ2kR/YJnv+G2j
 z1AHyMpIEBUpX21xTnIZIrpQSVoUZ17VgF+jJS68iZQUWSgMDwUVArTasmA==
X-Gm-Gg: AR+sD10fl8l/Kw+ZLUTOyt8cUin1sQKW+7J7rbQugz5VyagaXhmt8ibhaxp3opnqBbx
 DmNrI7/WJSXhyb3WFzKAT8WA4JsAPp2uvJtk/v1OcZPrYhkth6NDVHvFOonTBIVxVAeo2Y1fimd
 QtsGU15akCb+r5y0mLak3HZM/0LH5BXX+K61DzVO7scWtVLv2VfvU/IxKMEwGyUGgYmYm3szA5R
 UMECy9i9yMTMcMERuDmJXR716xSVEG3HtpqwmMEs24Y5vyyBr7X/FsmGNShHm+EUFX+L9vdz3Ck
 BbeaLdBXf3EkhhlNd0vzAAWDUobEabFuK1O2To8ZefXI9C3YeYE7GonAv8Q4022yTcmtwMTHNeB
 6Vzae51PilZaPES42JYmb61jgWo6/QqK+T/k=
X-Received: by 2002:a05:620a:4150:b0:915:79c8:ec92 with SMTP id
 af79cd13be357-936d231f768mr2237327085a.37.1786940281548; 
 Sun, 16 Aug 2026 21:18:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4150:b0:915:79c8:ec92 with SMTP id
 af79cd13be357-936d231f768mr2237325385a.37.1786940281165; 
 Sun, 16 Aug 2026 21:18:01 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610966dsm148124645e9.5.2026.08.16.21.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:18:00 -0700 (PDT)
Message-ID: <5980ddfc-63cb-43ce-a36c-537667255d91@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 06:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/usb/hcd-ehci: Check for DMA errors in
 get_dwords()/put_dwords()
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@redhat.com" <clg@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "philmd@mailo.com" <philmd@mailo.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260817023637.3082135-1-jamin_lin@aspeedtech.com>
 <20260817023637.3082135-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260817023637.3082135-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMCBTYWx0ZWRfX47tyaJDdCyzw
 TlubciG4p1oyw0VbtUQV1VzzRNPyQyW+Gydrk789fCdiC2Imnc/vfxXLEYSxymW2SgfUF+IkeUg
 kZDEPSJPQaLmme4hOc3AL5c19UxctmfX+PJIJXAGTZhnI3NXHkjwqJJ2/oVw8INbd+i1hDNlwdL
 dzQCyTqR8yWF2V2jOwGmYEJ4YBBaW4LKU9KtNMU0wE4rAzo8OVRd7y6Xc5GYrqfZTT583Y+hm4B
 JCGto9CiyavpkZA15o/VqOtTU5Iq86/WEvgjsK9bqplZj2NCKP/XqlXXBu8zf518hfumOiIDUSK
 5Nb/9N0z/TxcpqGvV+Q5M1Qzm19NHcryleoRIXhNAnDN3oD+MHU8nPWXQRyJ8hiA9uSl0vcEhKo
 CEo9UEejPYBC8idKgqwprr1tU2uw0tPqY0aJWh4VAMeXDkFMvvMYx/UGklsoBxrviYQYNoyksUj
 KeskMpuo6rWtZanKHKQ==
X-Proofpoint-ORIG-GUID: 4aCuH15dGwVv2IHlxVJYvo0Lh8xqAxUX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMCBTYWx0ZWRfX2EHp96yKC7b9
 Sl0FIkgkcZbCK2zNTtRfS3/sSeGuGLmsQMYptC7RPP1U90E5ksdhr1UYDB8MPIW5ZlCk/YbR7Yp
 177h0s4Cwy1Ggu40455CX0NO07gYgL0=
X-Proofpoint-GUID: 4aCuH15dGwVv2IHlxVJYvo0Lh8xqAxUX
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a828b7a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=8IzX_RpAO2Hg2pk7IroA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170030
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

On 17/8/26 04:36, Jamin Lin wrote:
> get_dwords() and put_dwords() return -1 when ehci->as is NULL, but that
> can no longer happen. The sysbus variants set it in instance_init
> (ehci_sysbus_init()), the PCI variant sets it in realize
> (usb_ehci_pci_realize()), and usb_ehci_pci_write_config() only switches
> between the bus master address space and address_space_memory.
> 
> Meanwhile the results of dma_memory_read() and dma_memory_write() are
> ignored, so a failed guest memory access is silently treated as success.
> 
> Drop the dead NULL test and check the MemTxResult of each access
> instead, so that the existing -1 error path reports real DMA errors:
> raise USBSTS_HSE, clear USBCMD_RUNSTOP and stop processing the
> descriptor, as the NULL path used to do. All 11 get_dwords() callers
> already check the return value.
> 
> put_dwords() now returns void: none of its four callers (ehci_flush_qh(),
> ehci_state_fetchitd() and twice in ehci_state_writeback()) looks at the
> status.
> 

Suggested-by: Peter Maydell <peter.maydell@linaro.org>

> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.c | 38 ++++++++++++++++----------------------
>   1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index d43951975a..daab5783bc 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -421,16 +421,14 @@ static inline int get_dwords(EHCIState *ehci, uint64_t addr,
>   {
>       int i;
>   
> -    if (!ehci->as) {
> -        ehci_raise_irq(ehci, USBSTS_HSE);
> -        ehci->usbcmd &= ~USBCMD_RUNSTOP;
> -        trace_usb_ehci_dma_error();
> -        return -1;
> -    }
> -
>       for (i = 0; i < num; i++, buf++, addr += sizeof(*buf)) {
> -        dma_memory_read(ehci->as, addr, buf, sizeof(*buf),
> -                        MEMTXATTRS_UNSPECIFIED);
> +        if (dma_memory_read(ehci->as, addr, buf, sizeof(*buf),
> +                            MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
> +            ehci_raise_irq(ehci, USBSTS_HSE);
> +            ehci->usbcmd &= ~USBCMD_RUNSTOP;
> +            trace_usb_ehci_dma_error();
> +            return -1;
> +        }
>           *buf = le32_to_cpu(*buf);
>       }

Maybe reorder before previous patch?

Note, for EHCI get_dwords() is only used as returning a boolean,
which would match with your conversion of put_dwords to void. While
the change involves some code churn, the result would be clearer
IMHO. Anyway can be done later.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


