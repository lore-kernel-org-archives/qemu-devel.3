Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D52C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjHc1-0006GJ-6i; Mon, 13 Jul 2026 10:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjHbx-0006G1-2y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:26:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjHbo-0000zT-HW
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:26:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DCE1C41210093
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 14:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 49Je4NTZpx4Po7c3DqU38M+PqpCxx9zs863fqnV7Tfo=; b=EfhQ6MuZSpCTezUO
 W+KFYHFfpyJSCfrLoq9JQsgOfaghFNw5FM/q1S9mgSpS3+zKPz1iSIqrZjvCNsnf
 8o+7C4fdVdc4rZSE7okb2dlkVh0fuuzX81t8x9ZQOeL2M1i4WX88JNX1JmXjSqn1
 eLB0I1Ow+DzgxztEtRD5yYuceQ7+e5+S6/mMyze0vwI3S+wW4nJqd++mc3vt1LyS
 8PojtyopYoi01p17ANCYSxWiW4kYS4bF5HxWD0E0JpbdZPG0g3WEshQ1Y/6QsnDY
 VDXVWYa2j+gVg+yoRhGKhgiQKJc6BunlivkLYbhvEoPvZlsveC/lZNlMnhhzS9t1
 XCKQtw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qs6kr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 14:26:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so44497896d6.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783952769; x=1784557569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=49Je4NTZpx4Po7c3DqU38M+PqpCxx9zs863fqnV7Tfo=;
 b=gTPWcKLePA66HKVJU3ZsVZzsXxR+g59SBCQuL3tgpwdz3UqH2jO8R/pJP9WdWFYYJU
 oWA78Iv15V1lTyGzqQACUPxgKMiJ6GzzlWDFpqqu0/BJA+oz8Ne7W1m30VIXrC7qIkwJ
 9P429qrlqzFee6YWjyetl3zAlRQotU4tdNr5uCPsKT76nM1OSHH2wIfIbY757Q/xKfZM
 xntfl/tenO4C7vUgjglpUD+KFvujx5v0NU32y8NQjz8RvP95gJY2vkGKCrhw2vVXxlyY
 pA6LGYpmyp+KYFGxs+Xybq+9YZRTfWOaGfh0+i/G9vT3RzuCh7VVvx3GrtOFROCTXeiC
 WHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952769; x=1784557569;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=49Je4NTZpx4Po7c3DqU38M+PqpCxx9zs863fqnV7Tfo=;
 b=MVJ+2y3lcT1SJIiRgow2q4NceeF2RFkTVeXIOb+25T0iyU1B8/SKlVe6C8ffjWZXhS
 7zKx5L7uW0udRasghC5Fww3JUdrmm7pWqEH2GsQNkcTf1CnguhdyZHiPByMzMZmLgulv
 XvBnjcQMW4oWsUed+52hpOIhpmw8n4sERiCXNvhPT0bXY4FjYuH4BONQNowyd7rZQOHb
 JPMqCFK5C2z50LLUHtsXmAncb5QWWpVqcVyMPW6ckAB78WlWizoQ8I0g8o3lKjZRinat
 jskTnOAx3ju1N6d3V0SZXfgeqmy+oueXAAtktTZ2onawz7xCmSAxlPOEwjfO9D9HcyKv
 KKMg==
X-Gm-Message-State: AOJu0YzUdixJY+F0jvAXIY7rgmSdjjoXVSYqR0e9VnhWBPbGG9AZCHTw
 E91x2LPdPWsHR/ut33PTXMmrgQkqmM+KMnqB+BanUrKg8uq16DvVaZg/pu8N2LdC3y9tMLrHGzI
 zVqLs2jqfxXZG1X/ciFGZi5wHyfqmI253B4wYSviVU9+daD9VMoiU74Aadw==
X-Gm-Gg: AfdE7cnvjhK2FxFxYXI9B/Gp/E5yMfcKNZa3IC2CosZ1uBOwZVN0BYv3upgkvYLeGcV
 Gcn2+Hxz9u5y9/PBL2Oo1fABlPMvIGnO6Yd99474/CD6OKri8X7q/Uas+7Q+cxO5SXzr5e9aKa+
 14BIdm57UVntbXo0Ed4oZID40JRa+4r72HZt/MAnwQntRBf8TpsZFmBGB/Z0kKNTFmxF+NPgsTU
 z2fhZEH79U/kZ7bG4Bqy6c4qBdZOH4VAAdmBi/beYx6Sxx3Z8tQPjMR4V+PB6xET02QBwy8C5YM
 +wpvFUo16bT3+t9Kqo6VnkfpoajWL6/uHmIoh1pBUfBSFbkiEcb9XdaVieQoVISiSK9QS5fgcIw
 Itms2cjB5sMwnYH7aCTv8TuZKlQCzgF2QNDFiABEMtrb0rTy0gs9PR4vyJIsTpQ==
X-Received: by 2002:ac8:7d0d:0:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-51cbf0468d7mr86977521cf.11.1783952768915; 
 Mon, 13 Jul 2026 07:26:08 -0700 (PDT)
X-Received: by 2002:ac8:7d0d:0:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-51cbf0468d7mr86973731cf.11.1783952762757; 
 Mon, 13 Jul 2026 07:26:02 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3c42sm360280015e9.1.2026.07.13.07.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 07:26:02 -0700 (PDT)
Message-ID: <ec368507-fe6c-4d6c-ac37-d13b9cb7f46e@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 16:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] system/memory: Have 'info mtree' display addresses
 nicely
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-8-philmd@linaro.org> <aah7i1iaoRb9yh7X@x1.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <aah7i1iaoRb9yh7X@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MCBTYWx0ZWRfX6ID6agD8dGlZ
 nhKn8eKxjE0oVD6kxkqVjY4xaxZYL/gnzCbRz32jjdlOZWU0fnjux0BPAk64otV1S38nzFI12DB
 2AxpoDCOFn26mJRs6ltVn3yoq5NkIXkZ9bFaigLKNL8jkQPkmpZ3dDktdTY4I75KbApVxSTGibr
 in49/kxJusOE6Vx4tayiHnzi26+hej78m/B+W0BSjAJRbs6iAEUyKLgQ5bKGh0i0tid+LFK3SuF
 u1RNvycpo7KCgEY+xQF9wttYxGM/DCuwdhLipbWR1FcUPBSNM6gZC39fE+XyhvHW2vhHFbGJbzW
 M92A3vi+IWK3ZLem7HRKeHzOjG+U5I4rX5l/5yE1HmIoDzELw7DQZe44PYltoEF+7yXsfJzgMA0
 FabDB4VCpHEcTxGT/Cd66uozXfg5qbpymdHzI4ndxxkvmzTFBMkyGsRgZrcqtUxbgyVAnb7GhHh
 Km1uwoBVPCgaPi6Esyg==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a54f581 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=xyt4nrV-CXGbbIWOvHoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2xJzwqi7YFH43daiWVSPRn3jqFjGdvwO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MCBTYWx0ZWRfX9K5H8lzRlERy
 OfmvCTWg+RQEa752g4qAN49bdxazG7EapFAnY7rrvsTAPn2l+iL4WuQd+og35DPafEC2NT4dyhx
 15VvNL1q5FEDqBA88r8nTpeaQcKOuW8=
X-Proofpoint-ORIG-GUID: 2xJzwqi7YFH43daiWVSPRn3jqFjGdvwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130150
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

On 4/3/26 19:35, Peter Xu wrote:
> On Thu, Feb 26, 2026 at 11:02:25PM +0100, Philippe Mathieu-Daudé wrote:
>> Use the size of a MR / AS to decide how many address chars
>> need to be used.
>>
>> For example, using 'qemu-system-x86_64 -M q35 -S -monitor stdio'
>> to run 'info mtree' displays before:
>>
>>    address-space: I/O
>>      0000000000000000-000000000000ffff (prio 0, i/o): io
>>          0000000000000000-0000000000000003 (prio 0, i/o): acpi-evt
>>          0000000000000004-0000000000000005 (prio 0, i/o): acpi-cnt
>>          0000000000000008-000000000000000b (prio 0, i/o): acpi-tmr
>>          0000000000000020-000000000000002f (prio 0, i/o): acpi-gpe0
>>          0000000000000030-0000000000000037 (prio 0, i/o): acpi-smi
>>          0000000000000060-000000000000007f (prio 0, i/o): sm-tco
>>        0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
>>        0000000000000008-000000000000000f (prio 0, i/o): dma-cont
>>        0000000000000020-0000000000000021 (prio 0, i/o): pic
>>        0000000000000040-0000000000000043 (prio 0, i/o): pit
>>        ...
>>    memory-region: pc.ram
>>      0000000000000000-0000000007ffffff (prio 0, ram): pc.ram
>>    memory-region: pc.bios
>>      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>    memory-region: pci
>>      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>>        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>>        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
>>        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>    ...
>>
>> and after:
>>
>>    address-space: I/O
>>      0000-ffff (prio 0, container): io
>>          0000-0003 (prio 0, i/o): acpi-evt
>>          0004-0005 (prio 0, i/o): acpi-cnt
>>          0008-000b (prio 0, i/o): acpi-tmr
>>          0020-002f (prio 0, i/o): acpi-gpe0
>>          0030-0037 (prio 0, i/o): acpi-smi
>>          0060-007f (prio 0, i/o): sm-tco
>>        0000-0007 (prio 0, i/o): dma-chan
>>        0008-000f (prio 0, i/o): dma-cont
>>        0020-0021 (prio 0, i/o): pic
>>        0040-0043 (prio 0, i/o): pit
>>        ...
>>    memory-region: pc.ram
>>      00000000-07ffffff (prio 0, ram): pc.ram
>>    memory-region: pc.bios
>>      fffc0000-ffffffff (prio 0, rom): pc.bios
>>    memory-region: pci
>>      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>>        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>>        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
>>        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>    ...
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/memory.c | 27 +++++++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index 4d276307da5..abcbdaadcd7 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -3321,7 +3321,26 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
>>   
>>   #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>>                              int128_sub((size), int128_one())) : 0)
>> -#define MR_ADDR_WIDTH   16
>> +
>> +static unsigned mr_addr_fmt_width(const MemoryRegion *mr)
>> +{
>> +    const unsigned int bits = 127 - clz128(mr->size);
>> +    unsigned int width;
>> +
>> +    if (bits <= 8) {
>> +        width = 2;
>> +    } else if (bits <= 16) {
>> +        width = 4;
>> +    } else if (bits <= 32) {
>> +        width = 8;
>> +    } else if (bits <= 64) {
>> +        width = 16;
>> +    } else {
>> +        width = 20;
> 
> Is there any case this can happen?  I thought we don't have MR larger than
> 1<<64.  Not a huge deal, though.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

There are few uses of 0x1.0000.0000.0000.0000:

$ git grep int128_2_64
hw/vfio/container-legacy.c:184:            Int128 llsize = 
int128_rshift(int128_2_64(), 1);
hw/vfio/listener.c:727:        if (int128_eq(llsize, int128_2_64())) {
hw/virtio/vhost-vdpa.c:469:    if (int128_eq(llsize, int128_2_64())) {
system/memory.c:757: 
addrrange_make(int128_zero(), int128_2_64()),
system/memory.c:1226:        mr->size = int128_2_64();
system/memory.c:1809:    if (int128_eq(mr->size, int128_2_64())) {
system/memory.c:2649:        s = int128_2_64();
system/physmem.c:2996:        .size = int128_2_64(),

include/qemu/int128.h:55:static inline Int128 int128_2_64(void)
include/qemu/int128.h-56-{
include/qemu/int128.h-57-    return (Int128)1 << 64;
include/qemu/int128.h-58-}


