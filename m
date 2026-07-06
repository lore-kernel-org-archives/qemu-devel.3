Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0599C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wge4c-00020K-Pb; Mon, 06 Jul 2026 03:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wge45-0001yW-Qg
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:48:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wge40-0005dA-3x
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:48:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641TxU3615448
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 07:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AxeB8iThNg0pZ9nv9cjVd92Ai+Lyof0A97dS8ssOPOw=; b=FgkWFRX/4R5ZhcyZ
 Eul/EExv7TsGIVMgry0raER4tn8dCh/SIbX1VCEE1EIlcdWroFb0NtpaBACVEw8r
 OhDQN3UX6BpeSnuZ90D2nmvc8TEtj4IM7jZ9EwHQ+LwB6RUbdysvpErgB1SKw4wm
 tMBfo68lGLNbTD0EKUGz8Ac241yBVcMox9C9uhSUElGEmrLA0LULMCoBOA2HJqrC
 OPQau/mv3PA5mnguYxlA4cBD/pzPhc9MMGYqNMJ5AuSqU9UP/zB5lPSRgEWkAmWG
 ZKKxeJfqu7Q28fQxBvNHBeqaeB0UN0qxkyhl2/f+H9pmK1NzEoSS3GvEKLPjp/hU
 Mi1n4g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3d3j5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:48:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e623b0e95so214503685a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 00:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783324088; x=1783928888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AxeB8iThNg0pZ9nv9cjVd92Ai+Lyof0A97dS8ssOPOw=;
 b=OB49f+w/CSNVHt653NupT6uiZ5KWDj0PTiSTY0bXzvuulHnpgyO4zzgM6bI4XSm0+C
 aOSgthbF7bgFeZoCdM44oa7CcNevm7GnRVw96x3t9Fq6uzoK5pem1E/ibSN+EPwUwTmo
 QrX9bn9DObswljpdKWaPc8wJpNkynhEzwzsFPVWST5KfDOiDlNjahIX4k4mSFef6e3wh
 kC5PPp81L5loX1NtUg/LO4q+d4JkRprSX6dVIF9ZjHviSb5EO9Uc41o9RwdfD6e4QV+F
 SVpkM17tgQDA9OYwccTEVXo9BjNVgnwgelnv8+PaTWgYbk24kMKDPAEHelC9JOCT4/66
 OiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783324088; x=1783928888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AxeB8iThNg0pZ9nv9cjVd92Ai+Lyof0A97dS8ssOPOw=;
 b=WZ+I4y04Dex9d0yu+j723iRjDwiEFTPCI98xvGMJU3D4zd20d9MdGJUQQtPNGFqmP/
 CgfZyqt3IU5ZVMsoy/6mtZ6ioQ/bDAWhL8bplmY7vkuk2Ih7ZQZLnfZK4VZU0Ep5Hbx0
 2mZTazC/bc9TRFgQwHVcms+AxyRWiahwqW4qO5SqJWQWdl7hljk4r5s7VxooM5IbL91b
 qGlDGbbeEYZ5gOSnQszdGSHCUs5f/82nKK3fKgWDm3utSOES1FadaV6HTZiVi160z9ER
 mZsg/eEgFFOlWEbEa3Q5oU23egjBg+4LAsJ9N2KwACIYQUhSdZcrA/CZ2l48XHcPoHYu
 ffOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJw/r622GJqvbFI7elqEndfGWMLrFS2+Mfvu4R/Yabb4RR+cSI1UQEkcrd8Xt9zJzAxUagVEG7UtNd@nongnu.org
X-Gm-Message-State: AOJu0YzTA36P5jNLKrX/V0oBPY+DMCOsQjWM5qYj6NSMGCfKRrGTHEmX
 NZ2l6Eno53ab1cSPkTvcm8uHiOoDPL+GPpSD0CVaWvf6ilW7SLtw+F6BZHYij2x7nssCXbA0Lin
 HAKHkiFsVeqEtnGya7ogiIiDIR6AdRUe8g+RLUBEfqKUIMg3Z/lYaaJknPA==
X-Gm-Gg: AfdE7cn3v/uVOPP5FmWasW2S2AuTjCp3dtH/cyOHA+BEAJ7TmkK2doRhPv27lziuTpz
 qd9ezXAazwFkEOpVgKV2GMd0vAhkUD2dPGVKGbKs9dufisUobR1gc5eu+BUn+2LI1piEtVRMokf
 tgF9bC1lH5gKkSfMbJWtef6tF1ONRT9lWMCntn10aiE6CrhThFooa/dwek3DfhdLcFhfm1XGzfW
 h5avCduGOBuRB3xcDqIip9iwLJfktETg99SVsW03oxJUiycamzUPhFm5yJjVSNSrorvk81LA+aP
 GjBdVh/0tfT42Nsl4kMlG5Nj12sZ/p1ol3Kf0h7tMt1jG4pBjJkJTzPo5p2ZV8Col71OiKu1iwZ
 gkiF5lhGcgKrTO9BHxaN55HzKLkI8gIbngC0Hx/RZj+rj9TNYOBOLrjk8fMFmfg==
X-Received: by 2002:a05:620a:17a1:b0:92a:e5a3:d46a with SMTP id
 af79cd13be357-92e9a35a8ffmr1205465685a.4.1783324087952; 
 Mon, 06 Jul 2026 00:48:07 -0700 (PDT)
X-Received: by 2002:a05:620a:17a1:b0:92a:e5a3:d46a with SMTP id
 af79cd13be357-92e9a35a8ffmr1205455585a.4.1783324085426; 
 Mon, 06 Jul 2026 00:48:05 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960816sm21570995f8f.29.2026.07.06.00.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 00:48:04 -0700 (PDT)
Message-ID: <a8ed5d83-0cf5-4bf5-b6af-9cd9f2d1f9f4@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] hw/block: m25p80: Fix dummy byte handling for
 Winbond flash
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz
 <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20260630135729.466264-1-bin.meng@processmission.com>
 <20260630135729.466264-2-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630135729.466264-2-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3NyBTYWx0ZWRfX9J4X9engIssq
 6taSJ4e6JSOndDXhzeOJiOP2QFc4jt3VkqQ23SBiCeEXTf3f2tnO28/0evqb1XKzP9YPIBSCuOT
 J4Qv0tY2tvly95F7VcIcWBcqOp9Tghk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3NyBTYWx0ZWRfX3b1ZxCCjAbM+
 1HIRzXEGAr8G1WH5BuRI3YuJhU4ofhVr5zQj6d7Zma2WkHT3SSLhEJiTpWWco8rHdpn3SeM7IAD
 1sLygxGMaLQ7f4S5kFAf8GqeWDXZAxlCqOSvkYO8ouLa6ZE60za62+WK5nIvcy4n0nR+htHhBOK
 iqkPqJyVvZHPR5mawKoT/PX4MLP3mc6/W6i3PEjOn5gAor3jvnQnt3g4Oo9p4Set9vdWGb8jigs
 AHKFDtFm2lTwVA6YzmvSfi3ONRQFRMNKmio3o4ElnTe110IIepSNyCKE+xbAKdp6Nnsa7jZpfqa
 k5XZB2edDEVIBIONng8aOCyXdBW9FqjytLGP+AeBnxuhLmBJb3egwb6BIgZz4n0ulHgpbofUstt
 R9gETTbeQaT5CStijqYUOSXc2cuwUXmSqOqs6r3tRIroSujPbTCBn9EHsbOoA7ZTkTiQz96OXRE
 23K9l7EyXIXO2QpulCw==
X-Proofpoint-GUID: HjYFG2puixTLSeLNHfdhWxp8F-TbIcUN
X-Proofpoint-ORIG-GUID: HjYFG2puixTLSeLNHfdhWxp8F-TbIcUN
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4b5db9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=-fCmXZ3jAAAA:8 a=FRSEYCzRAAAA:8 a=9wpAQ59KHjxRAubgSNsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=NvoCvu5dULWom27q9pnt:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060077
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

Hi Bin,

On 30/6/26 15:57, Bin Meng wrote:
> The m25p80 model uses s->needed_bytes to track how many bytes a
> controller must send after an opcode before the flash model can enter
> the data phase. For address-bearing commands this includes the address
> bytes. For fast-read commands it also includes the dummy phase.
> 
> The tricky part is that flash datasheets describe the dummy phase in
> clock cycles, while the QEMU SSI interface advances the flash model one
> transferred byte at a time. The dummy clock count therefore has to be
> converted to the number of SSI bytes that the controller will actually
> emit.
> 
> Some controllers have drivers that push these dummy bytes into a FIFO.
> Other controllers are programmed with a dummy-cycle count and generate
> the clocks themselves. The flash model still has to use the same byte
> count that a FIFO-style controller or the Linux spi-mem layer would use,
> otherwise the model waits too long and drops the first data bytes.
> 
> Let's fix the inconsistency from the flash side first. We start from an
> easy one, the Winbond flashes.
> 
> Per the Windbond W25Q256JV datasheet [1] instrunction set table

"instruction"

> (chapter 8.1.2, 8.1.3, 8.1.4, 8.1.5), fix the wrong number of
> dummy bytes needed for fast read commands.
> 
> [1] https://www.winbond.com/resource-files/w25q256jv%20spi%20revb%2009202016.pdf
> 
> Fixes: fe8477052831 ("m25p80: Fix QIOR/DIOR handling for Winbond")
> Fixes: 3830c7a460b8 ("m25p80: Fix WINBOND fast read command handling")
> Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/block/m25p80.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 4a4cda6602..59ecb32c0a 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1004,7 +1004,7 @@ static void decode_fast_read_cmd(Flash *s)
>           s->needed_bytes += 1;
>           break;
>       case MAN_WINBOND:
> -        s->needed_bytes += 8;
> +        s->needed_bytes += 1;

hw/block/m25p80.c-1224-    case FAST_READ:
hw/block/m25p80.c-1225-    case FAST_READ4:
hw/block/m25p80.c:1226:        decode_fast_read_cmd(s);

This method is handling 2 distinct commands. Should we pass the
address count by argument? (IIUC that alters the dummy clock count)

>           break;
>       case MAN_NUMONYX:
>           s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
> @@ -1099,7 +1099,7 @@ static void decode_qio_read_cmd(Flash *s)
>       switch (get_man(s)) {
>       case MAN_WINBOND:
>           s->needed_bytes += WINBOND_CONTINUOUS_READ_MODE_CMD_LEN;
> -        s->needed_bytes += 4;
> +        s->needed_bytes += 2;

Ditto:

hw/block/m25p80.c-1257-    case QIOR:
hw/block/m25p80.c-1258-    case QIOR4:

>           break;
>       case MAN_SPANSION:
>           s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;


