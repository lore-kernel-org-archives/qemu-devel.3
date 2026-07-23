Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718EBC4453E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmmU9-00044b-1q; Thu, 23 Jul 2026 02:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmU8-00044H-76
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:00:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmU4-0005ZE-OY
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:00:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N4vYE82512086
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tu7fPYU67b0+YXycWA+1f+vCd/I2qv1yJs0CRvce99k=; b=gf+ewbm375aSgrl6
 hpshPVhVJExtbOg7F8/Crw0ma5/fvP9eGzJwUVDNbvVW31i0qVRreXhvX+08c/Of
 O6JGOyyrDQV83tkX0w89yqB//4Qnir/SeluDHv8Ft2hv2vakBekhWF+b8zFpcYZu
 +V+b63UGaceNuCsILxGXGeKcZLtZFzmjLcsSSLMAVhISUu3JZfa/yeTpy2mvBVtv
 7sRWx4FgZfW+GSpaPQCOSrsa3yMjAa25QvNWaPtFYTQKE/2bYvyldb9mW56l7m7V
 I7gCI06cAzgRv4h79lw0RjVVyyaavo4ubpn0re3RsFEvg2H60aauebbAVxU8dKH5
 SjJn8g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxmgkmaj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:00:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso1514891cf.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 23:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784786436; x=1785391236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tu7fPYU67b0+YXycWA+1f+vCd/I2qv1yJs0CRvce99k=;
 b=ZTSsPwX1t2nVRcEcDfIrnQ4N4lJ8m+NN9GAWWZgOSSEft1QfECde6IT5JpHLISGBqx
 Vvku3dn3bahLskB9ypMhDgOrRodAAkl/wEfLLCyyn11dZjhB1Vu/ThSeFTfPudUiaST3
 X0m6PH6FV/0agzZrB3hedrHxJaK6JhRcOAu+rBjtupa2iNiQI4h4FB378MV7xhkTD9FB
 P+V8mHTG5T6EJvqvtKkaOfK34cz66HjxSKESIvecstkNfCXu1beR/BfqLea/jY6vs7Rd
 cKdJ5Go1caIWGpmc3Ut4Yy0VwgvnupQ0+CIsTZJSDo/v62nB+92LnJCo6y/9Efk1J0+D
 u9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784786436; x=1785391236;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tu7fPYU67b0+YXycWA+1f+vCd/I2qv1yJs0CRvce99k=;
 b=aT6+R0ybCo0abD8HQPej8f20Exq3IkEVGggEQzwybYbxX4l9hsHb3U3rYO9q6iXg8h
 v8pYFNiBol215tbQouiBH/Ht2oM7w4WaZzNXSY76cJn9mcLipzXBYysDaN8t6KHoN3Om
 bgGPJIzLd5Blo2F8kIckdytvbEo/QsyRI5Wp6WyoLZbyyWzQkSvs3usI0+y2LMN63qd5
 /S06wuXbLBBACzF8uLykzxdxsmdJJec0at1YsCP8x9JpfdmI8JNZznfYLKoOR+XTnhl1
 Lao4GXI1BsX8O71rhlOIkXvgk48u9XmNwqLXcp0Wu36ZZZ3Z4CgoNwJUXcWRpDfacUAa
 oogQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq6H0JkT42FpGNYomDBpF2tpOqGnMhYa0tV17v6Z9agQmRvkxW8Hv4ud13NiePQhxWAf10egoWHGMD@nongnu.org
X-Gm-Message-State: AOJu0Yw217RGSRlmI2OObpu7CNAR5ljQKCdqcw5kXCF+WC2WAF7NRLTX
 rCWL08QvOTebrzrx2fPB1gZsRNTrEXoutpv66nWX7nCquHa2bCUf1kVoJ7Pz7MQ2i52/0RnwI86
 KwjpM5LwiteNJMzV6k49DrSE8ZXfvXfEzWk3whVrSpC/eLr1DS4zfe+6EOQ==
X-Gm-Gg: AR+sD11PxQpY/NfqsHxfiMAtImm2qI9aCj9AWPz2ahd2jAkZ4rZgg+Xt2PQ4y98jnVq
 XpTHhQDx0NTH3oKbVJMNcmhfn/zkhlbVQq91gNFm/kH6hLXHrSr+vx007TeXmWAtFSCXWZh76O/
 a1Jr+og2AHYfBjqN/saWsIJWXDrobC1DwY86V8AE/GQBjlxcpRSxzLdzzCT2BfFo7u2UtbSFmid
 /WvitNXyLT6wp+nWY098jGTiBjPW+BSezJM7NOlkoeLkf0E2d8igK4KtpaxLMErWoL60stRoiSD
 S6sNZnmeM//6E9j0tOIGgJ61LeC+szFT9F8i3/ERRS+7LBX7uQDlQfvNET6zXs7WYD2hKBphvvg
 XpzORL1tNPSU4pI5U57xSOUWj2PSXe1cHo0h9LlHQiA8Cpy9Ggrs=
X-Received: by 2002:ac8:5fc7:0:b0:517:c582:9161 with SMTP id
 d75a77b69052e-5283ece4591mr12479541cf.7.1784786435516; 
 Wed, 22 Jul 2026 23:00:35 -0700 (PDT)
X-Received: by 2002:ac8:5fc7:0:b0:517:c582:9161 with SMTP id
 d75a77b69052e-5283ece4591mr12478981cf.7.1784786434872; 
 Wed, 22 Jul 2026 23:00:34 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9bae7d0sm861473e87.34.2026.07.22.23.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 23:00:33 -0700 (PDT)
Message-ID: <0323de20-0eb6-4d6f-8951-37a0d81c6b88@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 08:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/intel-hda: restrict all DMA engine paths to
 memories
To: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-stable@nongnu.org
References: <20260723021412.377244-1-jianghaotian.sunday@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260723021412.377244-1-jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D+V37PRj c=1 sm=1 tr=0 ts=6a61ae04 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=XZgBJ2Msjz3XTiow3qcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: f_JseXFdgJFMbKW09AIF0f9tJjOVDcEE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA1OCBTYWx0ZWRfX3tSLdN7n0L73
 ZyklKCyvKbZZhxgQtpyLOx4pRIFzqLIVROFubCjMy4R6vGJqpsG/A7KOBcZv2xh8eZbnEyucbj0
 CxM/Ed7pAgEHNMA0dYAF/VS01cFRly8=
X-Proofpoint-ORIG-GUID: f_JseXFdgJFMbKW09AIF0f9tJjOVDcEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA1OCBTYWx0ZWRfXwKjxLj2/KJIJ
 +wQubhGl7vzhHaVSdyKVkpmyDVn17AozKTNe/AJOJgOyBrQ0GAblwauou1+wYvK5cDm3RXLQQg7
 HXZhp07wQxdirwr/0JFCxKcZ0XLS4NqDNkdBb2bLHE2un+J36wydgchUaotuPsp9DzkiuOchLXn
 90QGPnx2DOk/nEM0UeWJ2RjfdHfhNTPu+xFEDsZla5gWlxA+SD017kP8apjNAR+FGMKY/D/Nw+8
 KRSMy35UyEbSNqy/jlGCrjUGdSrShBdZxk69qEvu0qVpK76sDC4E4CBeLsbZchcPNN46EElw4yB
 IL/o9KSxvipop7U9Y9C0v1FKUsaX7KQPOCG+ISLeLXPuoEZqKjlwu93ZDrOF595R/542NYlHdnh
 4nGbKCYx54cyrmnZg7OsC8Dah9jfyk9ZfiBI9WxJortcTbJ6sSU7h81t3kLSKYmh2Ccd4Ke7rA4
 p6v6TEO7di4b5uDsbkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/7/26 04:14, jianghaotian.sunday@gmail.com wrote:
> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
> 
> CVE-2021-3611 (commit 79fa99831d) restricted the DMA engine to memories
> by setting attrs.memory=true, but only applied this to intel_hda_response.
> Three other DMA engine access points still use MEMTXATTRS_UNSPECIFIED,
> allowing a malicious guest to trigger DMA-to-self-MMIO reentry:
> 
>    - intel_hda_xfer (line 398): called from the audio timer callback
>      (hda_codec_xfer -> bus->xfer), so the MemReentrancyGuard does not
>      fire (engaged_in_io is false outside MMIO dispatch). A guest that
>      points a BDL entry at the HDA controller's own MMIO BAR can write
>      audio samples to device registers, triggering whandler side effects
>      such as starting/stopping streams or injecting codec commands via
>      CORBWP.
>    - intel_hda_parse_bdl (line 478): uses pci_dma_read which hardcodes
>      MEMTXATTRS_UNSPECIFIED. A guest-controlled BDL base address can
>      point at controller MMIO, allowing the DMA engine to read device
>      registers as BDL descriptors.
>    - intel_hda_corb_run (line 333): ldl_le_pci_dma reads the CORB ring
>      with MEMTXATTRS_UNSPECIFIED, allowing the DMA engine to read
>      controller MMIO as CORB entries.
> 
> Fix all three by passing {.memory = true} explicitly, matching the
> fix already applied to intel_hda_response. For intel_hda_parse_bdl,
> replace pci_dma_read with pci_dma_rw to pass the controlled attrs.
> 
> Fixes: 79fa99831d ("hw/audio/intel-hda: Restrict DMA engine to memories (not MMIO devices)")
> Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
>   hw/audio/intel-hda.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index d7c2c3c2fd..3d361a4976 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -305,6 +305,7 @@ static int intel_hda_send_command(IntelHDAState *d, uint32_t verb)
>   
>   static void intel_hda_corb_run(IntelHDAState *d)
>   {
> +    const MemTxAttrs attrs = { .memory = true };
>       hwaddr addr;
>       uint32_t rp, verb;
>   
> @@ -330,7 +331,7 @@ static void intel_hda_corb_run(IntelHDAState *d)
>   
>           rp = (d->corb_rp + 1) & 0xff;
>           addr = intel_hda_addr(d->corb_lbase, d->corb_ubase);
> -        ldl_le_pci_dma(&d->pci, addr + 4 * rp, &verb, MEMTXATTRS_UNSPECIFIED);
> +        ldl_le_pci_dma(&d->pci, addr + 4 * rp, &verb, attrs);
>           d->corb_rp = rp;
>   
>           dprint(d, 2, "%s: [rp 0x%x] verb 0x%08x\n", __func__, rp, verb);
> @@ -395,7 +396,7 @@ static void intel_hda_response(HDACodecDevice *dev, bool solicited, uint32_t res
>   static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
>                              uint8_t *buf, uint32_t len)
>   {
> -    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
> +    const MemTxAttrs attrs = { .memory = true };
>       HDACodecBus *bus = HDA_BUS(dev->qdev.parent_bus);
>       IntelHDAState *d = container_of(bus, IntelHDAState, codecs);
>       hwaddr addr;
> @@ -466,6 +467,7 @@ static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
>   
>   static void intel_hda_parse_bdl(IntelHDAState *d, IntelHDAStream *st)
>   {
> +    const MemTxAttrs attrs = { .memory = true };
>       hwaddr addr;
>       uint8_t buf[16];
>       uint32_t i;
> @@ -475,7 +477,8 @@ static void intel_hda_parse_bdl(IntelHDAState *d, IntelHDAStream *st)
>       g_free(st->bpl);
>       st->bpl = g_new(bpl, st->bentries);
>       for (i = 0; i < st->bentries; i++, addr += 16) {
> -        pci_dma_read(&d->pci, addr, buf, 16);
> +        pci_dma_rw(&d->pci, addr, buf, 16,
> +                   DMA_DIRECTION_TO_DEVICE, attrs);
>           st->bpl[i].addr  = le64_to_cpu(*(uint64_t *)buf);
>           st->bpl[i].len   = le32_to_cpu(*(uint32_t *)(buf + 8));
>           st->bpl[i].flags = le32_to_cpu(*(uint32_t *)(buf + 12));

What difference with commit c257745248b02fd468619b4b1fdbbade5344191d?

