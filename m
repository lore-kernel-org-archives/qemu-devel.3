Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4E1C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrwaI-00071B-As; Thu, 06 Aug 2026 07:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwa3-00070O-HD
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:48:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwZy-0007ZC-Dt
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:48:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6769nieK1534178
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 11:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 auw5R7EpDYvD8tu3qHU0yZk6hRkssmFAjOr64hu9ygE=; b=ms1eaDkTTMQe20i7
 hFFKheexMLYrnnSU554LFPaJEzuXROFoUJe8dESHHARYOFlrybGBqL8eQp3KFdRj
 cTzC0NI+Uly96uPJdmTnrNzrRJTgHqz3w+Sz9Yvc1aCax812+WHeaVIckps9GAjq
 9jiMtdgy7G3RqrXXUwyfJzGHFtRdn+wtfG3DALWlU7QXdoS4Dw3/Akd/I9QYjuMc
 Z7EToZor0c9UjT3CSwoG5bSqARdTyw0FOTqZrA8RFKT70+gBw6XPIrIpuOxVcQgr
 Sx8Gzr3t9n2G34qpZDCjqN690C+9WG2JqL676BLREdo2+gZqQ1NeHcukFFZLJsfv
 A3UbPQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvn8psach-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 11:48:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9349c5af52bso370955485a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786016884; x=1786621684; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=auw5R7EpDYvD8tu3qHU0yZk6hRkssmFAjOr64hu9ygE=;
 b=Ytdty3JiZZurvRgJEtbUreoKNpxie9XGmrL4mQKIEjM1WYkLQXC1z8O/E1JIsGF33u
 eITB9PbPqfndDxuH917BylhJftLegfAAae4uq30X+kFW281KuWf8HP5U1zeKwaxJzdyS
 FzluF4t2JxoSFwpBt/mnOlotQkhIpL/4KmTTIFlK4G53KzQDvqXfOT4lDms8poPotExr
 7ud9nFa3ZusIu+A8R+WS+VUXecTy+jEwf5F5DqQbJrsfA1qr5Y9dbmwmcSTahaJ3dTW6
 wRAcGltv7SoiTZ9bjYHXwVjil6ok9W5zTHzTDUZpsQDsc7JBmL/1wiTCbzRGqylL83vu
 VuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786016884; x=1786621684;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=auw5R7EpDYvD8tu3qHU0yZk6hRkssmFAjOr64hu9ygE=;
 b=Mnj5LE2+QIOnoePWBSZzJsaLWeI8yeh6l8xohJlsbBODE1CH5JyTOn8jBQp0BK8a/f
 +ei+GaxsGpoOEsqw3gOHvwx64rvK95hXjauPqn11yY8P0SsknHdbw8ATo5re7kcHMhf2
 sZjr36NGk0d5vGBiCzvQPF4rhBq66f6g9torIlU5Wh1a6FmRs3agMj8CB3OnSEapb5wO
 t+3aHnma3ldsNd6Qju07JrezLQWbHDngI+8ogqWpbcKE8UeAagJFTkxODtRj9XGCUI/4
 DBmIyWQQNepkV2BlPdxA13VNqI/4CU/rteG5YZV3Y1QUIgnTW/5lpzlRV308xS4+xebL
 tfnA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqri4MGTA5+LND9qAtTgcUN37/e5/pMuNpYxZ+28Z0Tei1iRh0PvGJR4TUFNja4E7COMyMnYjZ3iDny@nongnu.org
X-Gm-Message-State: AOJu0YwI2I3eNkSZ86srGn+2SVTuqFUn2PE2vNQibOR8lF9pDvxOO9Gj
 Uplc9ePCU0f2EmjYha7ExFhVTNFyJBeGpGDeCiAdUNvWjcMZ0oCrf63uZ+5zTpDvbPlmB0qMavx
 Ac/6ZasRaHdbwqfG9JuGwFlBe+hCNMKSwfq71BK1HDRI16n99zom8IJTBTw==
X-Gm-Gg: AR+sD11vac9NT51UAVCSqK6971Ks2EbtXUoJ1029dvUK7rK7DKDhNRAhGTn+zqMTHB3
 B3RzlRqNA6zY9OhbjSiVOB5ui2DkEgqFOozUFizcVTaIjzsIoYVIkCcZ1XwWFwKBzCa+OVudUAG
 JIeWxFIYSUk29F01QRYLCgkHdiv4gXEO9RxmYvm7Gd1LfSSdCHVyAcetTDy7eCOeTJsFWsLog2P
 l7JAGiXO0C5kXXVdkdfHxLJJA/pmj32hd3x26lnwVjwccC+vOSFocitdSw5TwNQBslyrLdjzYHu
 SPhjtXyi4O8Ex2ECp7yDuMgTrMi1xmzTueRXIn8aLvipQI13IO15LQSPGKCPvcpqs2yQ4oE/r7o
 2080OOJK+FqoJc4NMo0zkVrfT2DvhxdBWrxeE
X-Received: by 2002:a05:620a:a1cb:20b0:92e:45e4:c6e with SMTP id
 af79cd13be357-93649153fccmr1224552985a.22.1786016883598; 
 Thu, 06 Aug 2026 04:48:03 -0700 (PDT)
X-Received: by 2002:a05:620a:a1cb:20b0:92e:45e4:c6e with SMTP id
 af79cd13be357-93649153fccmr1224546985a.22.1786016883081; 
 Thu, 06 Aug 2026 04:48:03 -0700 (PDT)
Received: from [192.168.15.12] ([177.196.135.131])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a4260c8sm387347085a.11.2026.08.06.04.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:48:02 -0700 (PDT)
Message-ID: <083ce420-ca09-4968-b284-e161ba781561@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 08:47:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/misc: add K230 decomp gzip
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 farosas@suse.de, lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 caojunze424@gmail.com
References: <20260727155702.36484-1-dingtao0430@163.com>
 <20260727155702.36484-5-dingtao0430@163.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727155702.36484-5-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5MyBTYWx0ZWRfX1OFSWszjOijm
 kywX30/QZSNiPl8V8i/e21NOl7UW6dza7xRi48bYKKwdvaUpC3PxhyiXaikdBDW8DwsZZu1vpiR
 KdqXiIKNThXOYVyVR7GbMAtgPTiNO5U=
X-Authority-Analysis: v=2.4 cv=RPeD2Yi+ c=1 sm=1 tr=0 ts=6a747474 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=TqADvzrrTdHTq19dv/zLaQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Rull5dLDAAAA:8 a=Byx-y9mGAAAA:8 a=NYnJYY1RAfWgCtwSQyIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=WpjELI0oDsu8BIz5_MMC:22
X-Proofpoint-GUID: JrFaqMWLR_nuVeGZ7wGsIHjRMZa3cKxF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5MyBTYWx0ZWRfX3ykJIUE0oCHl
 b5DBdiW/KfLBfOsNSYzcd8beQFlJ4dKMaaAlQgF6SV2oICd/PiZdCIpZaMqGnCaY5ZEFo2Elz6B
 RyOBwx++nDfzqfl27tTIYwqLR4X5jDGekRQL4AR8tegBVSuu0O7mLPusKX8pF26zxWwmpQfcDjq
 tytzQ5haFGxleDYhu6dBYBNBAYH+RkprYVVhafuWnQKpXvYYiJL0boaNq5PCyT0a7WgprjhyFP9
 a1fEdsq9eMnH1ZXtoqn9Cj8iOoQaC86l+YPMYpN1+1Iw8Vf+4tFijbHsK8PWb7thByVhobYSOj2
 vELbIjFg+2ffdHvzcDCLhuEDr6RxKNzaLFOLBEm0veXZdVmGr2fYyhcNfebOR8VN4f5VpoJJrPY
 acUMAEluDOLqPO88i6DN7sg6Zj25Vt4ufo+5oyqh/h9OpqbjoFCdlZsd1Zz3pBxhGWIeFBoXPp1
 rGM6CAMgp5uGXVIPD6w==
X-Proofpoint-ORIG-GUID: JrFaqMWLR_nuVeGZ7wGsIHjRMZa3cKxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

On 7/27/2026 12:56 PM, Tao Ding wrote:
> Decompression accelerator is mainly used to implement hardware GZIP decompression function.
> According to the k230 SDK, this hardware will be used during the uboot phase to decompress
> compressed files.
> 
> Decomp_gzip does not have the ability to access the system bus.
> Therefore, SDMA is required for data transmission. A typical scenario is SDMA moving compressed
> data from DDR to SRAM, and Decomp_gzip reading data from SRAM. After decompression, decomp_gzip
> writes the data back to SRAM, and SDMA moves the data from SRAM to DDR.
> 
> According to "K230 Technical Reference Manual v0.3.1" section 15.
> https://download.kendryte.com/developer/k230/HDK/K230%E7%A1%AC%E4%BB%B6%E6%96%87%E6%A1%A3/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---

LGTM.  Minor comment down below:

> In patchv1, the reviewer identified some bugs, which have been fixed.
> bugs:
>      Decomp gzip only support Dynamic Huffman format
>      Bit 0 in 0x0 register is write only
> enhance:
>      ues new reset interface
> 
>   MAINTAINERS                        |   2 +
>   docs/system/riscv/k230.rst         |   1 +
>   hw/misc/Kconfig                    |   3 +
>   hw/misc/k230_decomp_gzip.c         | 508 +++++++++++++++++++++++++++++
>   hw/misc/meson.build                |   1 +
>   hw/misc/trace-events               |   4 +
>   include/hw/misc/k230_decomp_gzip.h |  92 ++++++
>   7 files changed, 611 insertions(+)
>   create mode 100644 hw/misc/k230_decomp_gzip.c
>   create mode 100644 include/hw/misc/k230_decomp_gzip.h
> 


[...]


> +
> +static void k230_decomp_gzip_handle_ack(void *opaque, int n, int level)
> +{
> +    K230DecompGzipState *s = opaque;
> +
> +    if (!level || !s->active) {
> +        return;
> +    }
> +
> +    switch (n) {
> +    case K230_DECOMP_GZIP_GPIO_DMA_WRITE_ACK:
> +    {
> +        uint32_t input_size = s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_MASK;
> +        uint32_t chunk = MIN(K230_DECOMP_GZIP_BLOCK_SIZE,
> +                             input_size - s->total_requested);
> +
> +        if (!k230_decomp_gzip_load_input(s, k230_decomp_gzip_input_addr(s),
> +                                         chunk)) {
> +            k230_decomp_gzip_finish(s, false);
> +            return;
> +        }
> +        s->total_requested += chunk;
> +        s->input.slot = (s->input.slot + 1) % K230_DECOMP_GZIP_INPUT_SLOTS;
> +        break;
> +    }
> +    case K230_DECOMP_GZIP_GPIO_DMA_READ_ACK:
> +        if (s->output.current_offset == 0) {
> +            k230_decomp_gzip_finish(s, false);
> +            return;
> +        }
> +        s->output.slot = (s->output.slot + 1) % K230_DECOMP_GZIP_OUTPUT_SLOTS;
> +        s->output.current_offset = 0;
> +        break;
> +    default:
> +        return;

For all other read/write callbacks I see qemu_log_mask() calls to notice when something
unexpected happens, which is a good practice.

Shouldn't you do the same here?   Seems like you're silently ignoring a foreign interrupt.
Might as well do a qemu_log_mask() here too.


Thanks,
Daniel

> +    }
> +
> +    k230_decomp_gzip_kick(s);
> +}



> +
> +static void k230_decomp_gzip_start(K230DecompGzipState *s)
> +{
> +    uint32_t input_size = s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_MASK;
> +
> +    k230_decomp_gzip_reset_stream(s);
> +    s->decomp_stat &= ~K230_DECOMP_GZIP_STAT_CRC_OK;
> +    s->total_requested = 0;
> +    s->total_produced = 0;
> +    s->stream_end = false;
> +    memset(&s->input, 0, sizeof(s->input));
> +    memset(&s->output, 0, sizeof(s->output));
> +
> +    if (!(s->gzip_src_size & K230_DECOMP_GZIP_CTRL_EN) ||
> +        input_size == 0 || s->gzip_out_size == 0) {
> +        k230_decomp_gzip_finish(s, false);
> +        return;
> +    }
> +
> +    s->active = true;
> +    k230_decomp_gzip_update_ctrl_en(s);
> +    k230_decomp_gzip_kick(s);
> +}
> +
> +static uint64_t k230_decomp_gzip_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    K230DecompGzipState *s = opaque;
> +    uint64_t value = 0;
> +
> +    switch (offset) {
> +    case K230_DECOMP_GZIP_DECOMP_START:
> +        value = s->decomp_start & ~K230_DECOMP_GZIP_START; /* start bit is write only */
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_SRC_SIZE:
> +        value = s->gzip_src_size;
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_OUT_SIZE:
> +        value = s->gzip_out_size;
> +        break;
> +    case K230_DECOMP_GZIP_DECOMP_STAT:
> +        value = s->decomp_stat;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
> +                      TYPE_K230_DECOMP_GZIP, offset);
> +        break;
> +    }
> +
> +    trace_k230_decomp_gzip_read(offset, size, value);
> +    return value;
> +}
> +
> +static void k230_decomp_gzip_write(void *opaque, hwaddr offset,
> +                                   uint64_t value, unsigned size)
> +{
> +    K230DecompGzipState *s = opaque;
> +
> +    trace_k230_decomp_gzip_write(offset, size, value);
> +
> +    switch (offset) {
> +    case K230_DECOMP_GZIP_DECOMP_START:
> +        s->decomp_start = value;
> +        if (value & K230_DECOMP_GZIP_START) {
> +            k230_decomp_gzip_start(s);
> +        }
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_SRC_SIZE:
> +        s->gzip_src_size = value;
> +        k230_decomp_gzip_update_ctrl_en(s);
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_OUT_SIZE:
> +        s->gzip_out_size = value;
> +        break;
> +    case K230_DECOMP_GZIP_DECOMP_STAT:
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
> +                      TYPE_K230_DECOMP_GZIP, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps k230_decomp_gzip_ops = {
> +    .read = k230_decomp_gzip_read,
> +    .write = k230_decomp_gzip_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +};
> +
> +static const VMStateDescription vmstate_k230_decomp_gzip_slot = {
> +    .name = "k230.decomp-gzip.slot",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(slot, K230DecompGzipSlotState),
> +        VMSTATE_UINT32(current_offset, K230DecompGzipSlotState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_k230_decomp_gzip = {
> +    .name = "k230.decomp-gzip",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(decomp_start, K230DecompGzipState),
> +        VMSTATE_UINT32(gzip_src_size, K230DecompGzipState),
> +        VMSTATE_UINT32(gzip_out_size, K230DecompGzipState),
> +        VMSTATE_UINT32(decomp_stat, K230DecompGzipState),
> +        VMSTATE_STRUCT(input, K230DecompGzipState, 1,
> +                       vmstate_k230_decomp_gzip_slot,
> +                       K230DecompGzipSlotState),
> +        VMSTATE_STRUCT(output, K230DecompGzipState, 1,
> +                       vmstate_k230_decomp_gzip_slot,
> +                       K230DecompGzipSlotState),
> +        VMSTATE_UINT32(total_requested, K230DecompGzipState),
> +        VMSTATE_UINT32(total_produced, K230DecompGzipState),
> +        VMSTATE_BOOL(active, K230DecompGzipState),
> +        VMSTATE_BOOL(in_kick, K230DecompGzipState),
> +        VMSTATE_BOOL(zstream_inited, K230DecompGzipState),
> +        VMSTATE_BOOL(stream_end, K230DecompGzipState),
> +        VMSTATE_UINT8_ARRAY(input_buf, K230DecompGzipState,
> +                            K230_DECOMP_GZIP_BLOCK_SIZE),
> +        VMSTATE_UINT8_ARRAY(output_buf, K230DecompGzipState,
> +                            K230_DECOMP_GZIP_BLOCK_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void k230_decomp_gzip_reset_hold(Object *obj, ResetType type)
> +{
> +    K230DecompGzipState *s = K230_DECOMP_GZIP(obj);
> +
> +    k230_decomp_gzip_reset_stream(s);
> +    memset(&s->zs, 0, sizeof(s->zs));
> +    s->decomp_start = 0;
> +    s->gzip_src_size = 0;
> +    s->gzip_out_size = 0;
> +    s->decomp_stat = 0;
> +    memset(&s->input, 0, sizeof(s->input));
> +    memset(&s->output, 0, sizeof(s->output));
> +    s->total_requested = 0;
> +    s->total_produced = 0;
> +    s->active = false;
> +    s->in_kick = false;
> +    s->stream_end = false;
> +}
> +
> +static void k230_decomp_gzip_realize(DeviceState *dev, Error **errp)
> +{
> +    K230DecompGzipState *s = K230_DECOMP_GZIP(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &k230_decomp_gzip_ops, s,
> +                          TYPE_K230_DECOMP_GZIP,
> +                          K230_DECOMP_GZIP_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    qdev_init_gpio_in(dev, k230_decomp_gzip_handle_ack,
> +                      K230_DECOMP_GZIP_NUM_GPIOS_IN);
> +    qdev_init_gpio_out(dev, s->signal_out,
> +                       K230_DECOMP_GZIP_NUM_GPIOS_OUT);
> +}
> +
> +static const Property k230_decomp_gzip_properties[] = {
> +    DEFINE_PROP_UINT64("sram-base", K230DecompGzipState, sram_base, 0),
> +};
> +
> +static void k230_decomp_gzip_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    ResettableClass *rc = RESETTABLE_CLASS(oc);
> +
> +    dc->realize = k230_decomp_gzip_realize;
> +    rc->phases.hold = k230_decomp_gzip_reset_hold;
> +    device_class_set_props(dc, k230_decomp_gzip_properties);
> +    dc->vmsd = &vmstate_k230_decomp_gzip;
> +    dc->desc = "Kendryte K230 GZIP decompression engine";
> +}
> +
> +static const TypeInfo k230_decomp_gzip_info = {
> +    .name = TYPE_K230_DECOMP_GZIP,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230DecompGzipState),
> +    .class_init = k230_decomp_gzip_class_init,
> +};
> +
> +static void k230_decomp_gzip_register_types(void)
> +{
> +    type_register_static(&k230_decomp_gzip_info);
> +}
> +
> +type_init(k230_decomp_gzip_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..6f6bf3c85c 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -36,6 +36,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
> +system_ss.add(when: 'CONFIG_K230_DECOMP_GZIP', if_true: files('k230_decomp_gzip.c'))
>   
>   subdir('macio')
>   
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3ef..16db4ba0cc 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -442,3 +442,7 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
>   iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
>   iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
>   iommu_testdev_dma_armed(bool armed) "armed=%d"
> +
> +# k230_decomp_gzip.c
> +k230_decomp_gzip_read(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
> +k230_decomp_gzip_write(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
> diff --git a/include/hw/misc/k230_decomp_gzip.h b/include/hw/misc/k230_decomp_gzip.h
> new file mode 100644
> index 0000000000..9911af0095
> --- /dev/null
> +++ b/include/hw/misc/k230_decomp_gzip.h
> @@ -0,0 +1,92 @@
> +/*
> + * K230 Decompress Engine
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_K230_DECOMP_GZIP_H
> +#define HW_MISC_K230_DECOMP_GZIP_H
> +
> +#include <zlib.h>
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_K230_DECOMP_GZIP "riscv.k230.decomp-gzip"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230DecompGzipState, K230_DECOMP_GZIP)
> +
> +/* K230 DECOMP GZIP ACK input */
> +enum {
> +    K230_DECOMP_GZIP_GPIO_DMA_WRITE_ACK,
> +    K230_DECOMP_GZIP_GPIO_DMA_READ_ACK,
> +    K230_DECOMP_GZIP_NUM_GPIOS_IN,
> +};
> +
> +/* K230 DECOMP GZIP REQ output */
> +enum {
> +    K230_DECOMP_GZIP_GPIO_DECOMP_CTRL_EN,
> +    K230_DECOMP_GZIP_GPIO_DMA_WRITE_REQ,
> +    K230_DECOMP_GZIP_GPIO_DMA_READ_REQ,
> +    K230_DECOMP_GZIP_NUM_GPIOS_OUT,
> +};
> +
> +#define K230_DECOMP_GZIP_MMIO_SIZE       0x4000
> +
> +/* K230 DECOMP GZIP Registers map */
> +/* Start decompression controller */
> +#define K230_DECOMP_GZIP_DECOMP_START    0x00
> +/* Source data length register */
> +#define K230_DECOMP_GZIP_GZIP_SRC_SIZE   0x04
> +/* Output data length register */
> +#define K230_DECOMP_GZIP_GZIP_OUT_SIZE   0x08
> +/* Decompress status register */
> +#define K230_DECOMP_GZIP_DECOMP_STAT     0x0c
> +
> +/* Start decompression controller */
> +#define K230_DECOMP_GZIP_START           (1U << 0)
> +
> +#define K230_DECOMP_GZIP_CTRL_EN         (1U << 31)
> +#define K230_DECOMP_GZIP_DMA_IN_MASK     0x7fffffffU
> +
> +#define K230_DECOMP_GZIP_STAT_CRC_OK     (1U << 10)
> +#define K230_DECOMP_GZIP_STAT_STATE_MASK 0xfU
> +
> +#define K230_DECOMP_GZIP_BLOCK_SIZE      0x00020000
> +#define K230_DECOMP_GZIP_SRAM_IN_BASE    0x80000
> +#define K230_DECOMP_GZIP_SRAM_OUT_BASE   0
> +
> +typedef struct K230DecompGzipSlotState {
> +    uint32_t slot;  /* Slot index */
> +    /*
> +     * Data offset in current slot.
> +     * First valid data in input buffer. Last valid data in output buffer.
> +     */
> +    uint32_t current_offset;
> +} K230DecompGzipSlotState;
> +
> +struct K230DecompGzipState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    hwaddr sram_base;
> +    qemu_irq signal_out[K230_DECOMP_GZIP_NUM_GPIOS_OUT];
> +    uint32_t decomp_start;
> +    uint32_t gzip_src_size;
> +    uint32_t gzip_out_size;
> +    uint32_t decomp_stat;
> +    K230DecompGzipSlotState input;  /* decomp gzip ring input */
> +    K230DecompGzipSlotState output; /* decomp gzip ring output */
> +    uint32_t total_requested;
> +    uint32_t total_produced;
> +    bool active;
> +    bool in_kick;
> +    bool zstream_inited;
> +    bool stream_end;
> +    /* Read from ring input. */
> +    uint8_t input_buf[K230_DECOMP_GZIP_BLOCK_SIZE];
> +    /* Write to ring output. */
> +    uint8_t output_buf[K230_DECOMP_GZIP_BLOCK_SIZE];
> +    z_stream zs;
> +};
> +
> +#endif


