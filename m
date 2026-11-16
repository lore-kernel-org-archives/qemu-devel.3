Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31E606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BOAc18SU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fv1NxngR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT52a-0001ui-Ks; Mon, 16 Nov 2026 17:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT52X-0001u2-UT
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:19:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT52V-00055s-Qm
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:19:05 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJemqc2727631
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mdzagJfGolk3Cvq2rH9EbvZzXcEeqtA0NJyRUqqZGwg=; b=BOAc18SUQ1txpMYq
 eWGjqQphkVvF1kc2E0r4xnbXTy4S7yIx2PBY0sU0Tv5gv9uK9f0EZrjgK0GE9uOn
 NxzY21lhFiKPVN8tS9qZabtAcSFH4oCMGPwpc9070ZQEdZLDhNv14/Tn4/ZIjw2a
 Le/YABbOk7dQJLUuk1zEZ7qDyCNJpqKPRtdgMygmDQD6YIvzHbyr/s9VqgnsZ08h
 aCs5WWEhDFM31b356F6qFRcVnDDdOwZjCKUb8lIBu1SssMHp0yAXvG2p8K9/nAoa
 smN/jWPdI0nCQzcfTUcoeh+dl/744iRzJ49bm5zN9dwTbwUBcTQlyKPdB6WJvJ6X
 hLZRcQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regnea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:19:00 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d32175c486so524718137.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794867540; x=1795472340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mdzagJfGolk3Cvq2rH9EbvZzXcEeqtA0NJyRUqqZGwg=;
 b=fv1NxngRrNbPhyF9n7sb8tRkOLlwUMecAhqNX/2gLtjHEfhe0/RZt42TzXNXPIz1eF
 214fLMUmaJosEpp429Td8ZN79+lb9BLS4GfV2D5x/pmXo0D5wQsXvMagYdG+qvIcK7MK
 DQ3vAA9QBOuqfhvjcpfFTZ2bga/OmP33hk8CJs9LssnNTrCHoQD5BJpcb+4lGMuvlrpA
 lFxyd+m4+zZLkG+ZroITsxVoaBB3RRP/F0pOX3Yu9ZJjfg8AnxQSBOB8bL6en9UuKn3+
 SP39Iq8cV1aPASkOOJx2NsXLTzabD8kKc86iPNEvKIqxu9nUX1+rqBQ7O9LR7HZVCO+B
 STjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794867540; x=1795472340;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mdzagJfGolk3Cvq2rH9EbvZzXcEeqtA0NJyRUqqZGwg=;
 b=NgT2bPcxfbeBKUbORH+l+Zy+UGUzAJhod2O2TmEXDfeWliaxN+aQHx/nchhRblO5lG
 HEJa/25/2XTKRKHc8ne0SK/ZOI6u+E7OtDEtFXmUW/A8/DVWc8d509ezao1JVX0mtKbD
 YJ0uNfCOcMX2XomiFlifbQXx1RNRwa7Gp0X9u2BvyDWmGukzh1Qyaj+mCYlnqOfnTRiC
 Iv1NNGnmnwqN/shPpts/ZDh/7purjweCONcnki1CQKaQMbywt7pM6imVlbXX7Hpi/qQ2
 4pD8P8l0JghxN5EGtC7H4sb57axIFV9hE2aefvhI1zGp6XavEG7j4kwpvaAjQiUP3P3t
 2Ndw==
X-Forwarded-Encrypted: i=1;
 AL+hErF61v66FHOTigSO5Fk1X/K7Cco1x7WkdMiRoam//t5769aA7szFHLqsEabztU94UkM9M6Vg9MGpVANf@nongnu.org
X-Gm-Message-State: APuU4Z/ZSVYP3CcPGc3IrKVvFJz7dIOpJr9dlncxMQZscHPrrVAlyLPw
 LE02ZVIfMrL6NtYYPqAhCtrGQfmL/bFI24UOd8ALh6wYVnaI8WD06DJ9Jqkr7jUSywtkAYd5che
 g9LqwQvsppmoXJWqb/Fj55uT99k079celPh4+YRPSJphrSXgdYF41PcMFKw==
X-Gm-Gg: AYBFou0RhI4F0Eyikw48BHSq+QFpIPTqialEGIfFW+pnxnSlHdR8onF2vcOwua7bZ0Y
 O1Y2Lrhc2UjcptSMsSDekrk+jmYxRnsaIO/9j0wEfahjEp+O+qc0RQOEsdEJvkFDdHKSdXU3rex
 wo8COgmvcElCnupY9UG2uvpp3can5weaVfM1ZlN6r1erah9V+xUYHPCDfh+xXFWyXcywdgxyclu
 FkPhyjGmxwSgZwLY21nvflfnkefZcyQNSm1m8gV2MJl7R7ZWyuB9H4h2lytijtcLzVrTtYNm+f3
 /mkFILpBMLXnoyUJXzqgxw4TELqtvyghuQhwkLGp5hOBM0FGV6mXRAzGUGh/djTpAiyhy3ABGzA
 ehDCcQORUSxbj9gt3+dUlF8nBwA7dloZw66zi/upTjnTR9Co9OzyGoSYjK08/xicwrOA65PRg82
 AOMmz9tdk=
X-Received: by 2002:a05:6102:511f:b0:7cc:776:6c41 with SMTP id
 ada2fe7eead31-7d64d770275mr3201684137.22.1794867539795; 
 Mon, 16 Nov 2026 14:18:59 -0800 (PST)
X-Received: by 2002:a05:6102:511f:b0:7cc:776:6c41 with SMTP id
 ada2fe7eead31-7d64d770275mr3201676137.22.1794867539288; 
 Mon, 16 Nov 2026 14:18:59 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783965c8sm18172905e9.9.2026.11.16.14.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 14:18:58 -0800 (PST)
Message-ID: <66899f0f-8f36-4963-a899-6a960dd3f963@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 23:18:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/rtl8139: Limit DMA transfers to plain memory
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Thomas Huth <thuth@redhat.com>
References: <20261113165015.1150646-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261113165015.1150646-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfXzcsk2x+2L2zV
 53GD5nuCVZEwZ4rwqnR/l3sBt77wOZykipeUTEQvLmv7ioAHi++Zf+GIQTiEuqEulF8dBNE5jcE
 xVWTbZNRoKjcRq60Gmt9sPVnziftnm8=
X-Proofpoint-ORIG-GUID: HhjHFqiuERm6G95xWG72PgkoaFIv8zl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX/TtaWuWPir/q
 gmF89mQMH9BMfkjjsIYL04wO76irTJEElp7nkvxFFqCXUKp3pgf4IaE6LKZoRbgPtuHXByuPfkt
 N5O2zp5L6tOP9BUhwyS52FqZEMNkZeGuxDfQ8kt9ktZwAH8uS9R7lVG+Fspubya4rKfzQV05nNa
 Mg2/9teLju6WgTF+GJlEYPxWSKZu/9S8Fx/wjum3WVqnqbtSLvwp+WJkmsc4nKe4hnlbqwHVCs7
 O0FV/mN92zGFLyYr+maWNTKQsj2tK9AecErW7yAh8xlKqU5pnAGasw/d7LrRyNUb1FmoMpVbxax
 eYIEGZa5Z3LOcKKWFZgTZ8mKCQbk0M7EcXTOtzw/PO+myTe0ZnqmFVqZAhMQ8daqYmYuesTF8/5
 8n88Yph0LnPZGRy3aJWqlz1a0xkEym0r2lYiDyICxkbkN9TkAASd4bhtRmM9Q1DT24zSsDxjehb
 HcjvLTxod8LQ4W7ljzA==
X-Proofpoint-GUID: HhjHFqiuERm6G95xWG72PgkoaFIv8zl9
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb8154 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=69wJf7TsAAAA:8 a=UqCG9HQmAAAA:8 a=KKAkSRfTAAAA:8 a=aCIl0sFFG5lcKjcHs4MA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160088
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/26 17:50, Peter Maydell wrote:
> There's no reason for the RTL8139 to be doing a DMA transfer to
> something that isn't memory, and allowing it can cause weird
> re-entrancy problems, such as a DMA to the PCI hot-unplug register
> causing the device to be deleted while it's halfway through doing
> something.
> 
> Replace the calls to pci_dma_read() and pci_dma_write() with
> local functions that are identical except that they pass
> a MemTxAttrs that forbids non-memory accesses.
> 
> This is the same approach we took to a similar problem with
> the hcd-xhci USB controller in commit 89e653b7736 (but differs
> from what we did for lsi53c895a in commit 4862d2c95104d).
> 
> The known trigger for this bug requires that you turned off
> ACPI hotplug on the QEMU commandline with
>    -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off
> so most configurations won't run into it.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 3ada003aee2004d24f2 ("rtl8139: Use PCI DMA stub functions")
> Fixes: CVE-2026-128868
> Reported-by: VictorCHEN <ahchen-yz@outlook.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm also wondering whether there's an approach to this class of
> bugs that would avoid us having to modify specific devices to
> insist on DMA-to-memory. It seems a bit dubious that writing to
> the PCI hot-unplug register can cause us to unrealize the plugged
> device even if lots of other things are still holding a reference
> to it. Or else we need to be more specific that you can still
> validly (in the sense of "doesn't break things") do things on or
> as part of an unrealized-but-not-yet-freed device, and move
> things like pci_config_free() from unrealize to deinit.

While still thinking about that, ...

> 
>   hw/net/rtl8139.c | 98 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 60 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 16479284eea..6644c1b62c5 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -513,6 +513,28 @@ struct RTL8139State {
>       int rtl8139_mmio_io_addr_dummy;
>   };
>   
> +/*
> + * There's no reason for the RTL8139 to do DMA to something that
> + * isn't memory, and it can cause weird re-entrancy problems if e.g.
> + * a DMA write targets the PCI hot-unplug register for the device.
> + * Set memory=1 in the memory attributes to avoid that kind of thing.
> + */
> +static MemTxResult rtl8139_dma_write(PCIDevice *dev, dma_addr_t addr,
> +                                     const void *buf, dma_addr_t len)
> +{
> +    const MemTxAttrs attrs = { .memory = true };
> +    return pci_dma_rw(dev, addr, (void *)buf, len,
> +                      DMA_DIRECTION_FROM_DEVICE, attrs);
> +}
> +
> +static inline MemTxResult rtl8139_dma_read(PCIDevice *dev, dma_addr_t addr,

(drop inline)

> +                                           void *buf, dma_addr_t len)
> +{
> +    const MemTxAttrs attrs = { .memory = true };
> +    return pci_dma_rw(dev, addr, buf, len,
> +                      DMA_DIRECTION_TO_DEVICE, attrs);

... these new helpers correctly return a MemTxResult but the
callers still ignore it. I appreciate this would be a larger
rework, unlikely worth it. What is your plan?

> +}
> +
>   /* Writes tally counters to memory via DMA */
>   static void RTL8139TallyCounters_dma_write(RTL8139State *s, dma_addr_t tc_addr);
>   
> @@ -756,15 +778,15 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
>   
>               if (size > wrapped)
>               {
> -                pci_dma_write(d, s->RxBuf + s->RxBufAddr,
> -                              buf, size-wrapped);
> +                rtl8139_dma_write(d, s->RxBuf + s->RxBufAddr,
> +                                  buf, size - wrapped);
>               }
>   
>               /* reset buffer pointer */
>               s->RxBufAddr = 0;
>   
> -            pci_dma_write(d, s->RxBuf + s->RxBufAddr,
> -                          buf + (size-wrapped), wrapped);
> +            rtl8139_dma_write(d, s->RxBuf + s->RxBufAddr,
> +                              buf + (size - wrapped), wrapped);[...]

