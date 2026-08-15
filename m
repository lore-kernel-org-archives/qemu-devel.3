Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC50DC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvF17-00006H-Q4; Sat, 15 Aug 2026 10:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvF15-00005U-Pc
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:05:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvF12-0005L5-N9
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:05:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDMcoj247723
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zO6i98ZxnbPRZCozODgwOp+tlfTQGZBYWf+6IkaWOSI=; b=dsitHuz5YTwtRo9d
 CA3sSZm/Z+bPMqNRJowU3/1Ojn1+UhGxJMyPnT/cVaYkjy5Wzy+3LqHEZGJCbo9i
 aObMr2GVh84umN/xi7URIABM8pYiiEHs7IbmTkplG2nESShFqQwEZWNDV+691mCH
 jkn+cvU3WZlToxu4vlGS0hAhSwRKiXKlwxbRNuJLLc1gqwRzOl1E2YeJDaHwjOzf
 3g+Qza5G1oOd1/76/9moDoqE934y5R5uKwHRJOjf1jk04sZEIT2NRapS0oVBOlV3
 m/5zzYmSG2MX+KuIw/fFJ5zH09S4hDnCltx80AYc3rBm8PNMYCYzLXc1HgNUUmmr
 yiRi7w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf93wv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:05:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936d067836eso197507785a.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786802730; x=1787407530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zO6i98ZxnbPRZCozODgwOp+tlfTQGZBYWf+6IkaWOSI=;
 b=AD2K/MCVbQWn2o9MHRwaL7x2qBE+vvqHV6+0po28+8GWLLOigCUk2oWbQrQlWoWTNo
 6ahzA4af/xI30gdn+DZuZBcXXz8bo2/bLV5e7LKFi+OwrQKn/Gz0lLZLzmKzFNL8s3DC
 wgDujv1rMj6LOI/18h/VxoE2hddcj5RKmZ1Oq7GRO947tiTN58lTL6reBtzyg0ARQtlE
 nJhF4uh8jRkRNSdsOPLfq6gD8P4LETUzNKYvmpF+JGkLr6ZgMqOPyYtBOiUBF61LXABz
 stN4f2vq2zT8mqK4zXvF/Zncg/3Bg4qVQFlrVafMBxmdjBqc3OH4N6IRy9mYwMv8fZqa
 qVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786802730; x=1787407530;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zO6i98ZxnbPRZCozODgwOp+tlfTQGZBYWf+6IkaWOSI=;
 b=gmRL3GisaQvEMbpPhN7KF7QsHty1NjTvkwp5AfgPtL8g6qCxBUsKT/bYXglR2r4qbM
 6Faz9Dm5m3Hbatfm4LUNaDzsDHsjZJE4ZHkm9ecHxgP56ModvW7T3J+S1nHtOZy2hyHy
 sTyU1+zyuxFWXW7qwTCKxzgVpD5TvRRbii0BFEWqLnXIp+YuWZk2xgXxg9BwfOM+bCSh
 C/4RflrFXInYLi/VQfJhCzT6VN+fXH6XMXAKs8kEhaO/546jnmcL/NzQxAt+kTcX22uW
 QDIgAzkTgGyM/SEDBzE+VBhbfOpUwP3icq1LiDv7hsSMc5FtZvwgeAH56ct3eh4CSI/8
 5cSQ==
X-Gm-Message-State: AOJu0Yw5z51DmpCSUQTLMyFvolg2yYH6MWmCbWRO0wAgZ4a6DqNFu9pj
 nKQpNjaoA51hjirwMwd8NX+j8D+nGBjgP07BVZw7MRG36wi8nattKljIqOU6HyuMbiTHjFIGbUw
 1vP3ro43Is9UQAUWJfl+NOT9NY3dv7pwOM81x7kK+WW/IgaCCw+knrd7hHw==
X-Gm-Gg: AR+sD12tF+RCR+rdnRJFAuBTyVR0Fcj7o3uTjfi7kSrYscFbdsHZixy0rYSdhh63zJk
 wl6GyUHqfD9PUBlzUDAnUVeO4EtcnhQSt6yTKr4polJmoYjePU1oJ1IQQKafAFg5c7QVvNYo3SP
 +KSXzNU+aqWVOTtEwaHz4GmivZPD+xk7ne+Z1vF7ijyqFmyqKmiVqqRQLjRMWdjS5B7zdpzDCgq
 /PTQrSk6yoY8As17DUlqVgepqlL0lfnrpIewlxeHddnQWIFz0rPdpKExj0GWyAhG2vIUwrgksxi
 ++85YmmFYugoeKjS+B6plAdyOAztzXC9k7YBkmHWumJr+UjpAgLcHA9jpvrRmIisA5680vxes3U
 dlqeWndAZEqyNcNIOcPmkX33kj3i/kNzL1X0=
X-Received: by 2002:a05:620a:404c:b0:936:e3c3:8cb8 with SMTP id
 af79cd13be357-936e3c38cc9mr553122685a.45.1786802729681; 
 Sat, 15 Aug 2026 07:05:29 -0700 (PDT)
X-Received: by 2002:a05:620a:404c:b0:936:e3c3:8cb8 with SMTP id
 af79cd13be357-936e3c38cc9mr553113585a.45.1786802729193; 
 Sat, 15 Aug 2026 07:05:29 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899b5f86sm116421665e9.5.2026.08.15.07.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 07:05:28 -0700 (PDT)
Message-ID: <a79de0e7-f653-4a03-90b3-56b0b17cc9f9@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 16:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/pflash_cfi01: Restore ROMD mode after migration
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
References: <20260803041808.58174-1-guobin@linux.alibaba.com>
 <CAFEAcA-P6RH7nJK0KQ1H8576ULFA7nocB0EkhhZf6Rw3g0WCag@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-P6RH7nJK0KQ1H8576ULFA7nocB0EkhhZf6Rw3g0WCag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMSBTYWx0ZWRfXzNrWIBcSIp8y
 8Wj6+yOgUWVmaqPdifdRvqzkzAU/vZe8UcVB95cBTijphr0NMdz33zBrzUe6atOf0FgQUvhXZ6u
 V0Wtr/HvEfWS164Gacq3n8DDLGainAE=
X-Proofpoint-ORIG-GUID: rrzGHR2WMIRxZL74Tg7P5Z4GOGMzhrUA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMSBTYWx0ZWRfX+D7VQqSQNUML
 HwAvmMzrld5guUXh+ml196+vAC40CqkgW6PSJzX9MmzuaRtd79eB2qVnlbTebaZn/pnG7lQJaIF
 gALKoOQwi/zNKFmMykkPuSWXpGdgoCcZYBMLFdVWKTbU9LliEN2TtBFasHoPiEyo6ayQblOGWhR
 p5DIM+LxWfIRgRauuaQQ3NbVXSK8twsVnDgEZi4srCaVkl5IgP2MzW0qy7B7a/YYo9L7Gk5GfhR
 BbXJVd9xKLrGtTi1fhRAo+QO44OvCyNvVGI1/qI27avnzJXoITIg80BnBKfloQoFuJ2gOwswTgf
 yYgUbrMBb6jxJfjMPdSRbDsR4QXv5lIL+DoAUJKzpdD4uCHozhV8WlwC5gVB5y5fA6D65yIQKKv
 GSaqRsfhBJWQ0GFGVUJMNERum3dbATHbsbvsSzz+IjWhHYIURehI/bM1errddeP1rO0cbaGkzxR
 /6mHM6XQ+fpHesnoUgA==
X-Proofpoint-GUID: rrzGHR2WMIRxZL74Tg7P5Z4GOGMzhrUA
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a80722f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=SRrdq9N9AAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=uXTTcVZMJsNDpR9Ct-wA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 7/8/26 15:08, Peter Maydell wrote:
> On Mon, 3 Aug 2026 at 05:19, Bin Guo <guobin@linux.alibaba.com> wrote:
>>
>> pflash_post_load() did not restore the ROMD mode of the memory region.
>> Although cmd and wcycle are migrated, the destination retains the
>> default ROMD = true from realize.  When the source was in a non-array
>> mode (e.g. ID read, cmd = 0x90), reads on the destination bypass
>> pflash_read() via the ROM fast path and return raw storage bytes
>> instead of the command-specific response.
>>
>> Derive ROMD from the migrated cmd/wcycle in pflash_post_load.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4042
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
>> ---
>>   hw/block/pflash_cfi01.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 5b9ddb20b1..a13b91967e 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -1030,6 +1030,16 @@ static int pflash_post_load(void *opaque, int version_id)
>>   {
>>       PFlashCFI01 *pfl = opaque;
>>
>> +    /*
>> +     * ROMD mode is not in the VMState; derive it from the migrated
>> +     * cmd and wcycle.  Only (wcycle == 0, cmd == 0x00) is read-array.
>> +     */
>> +    if (pfl->wcycle == 0 && pfl->cmd == 0x00) {
>> +        memory_region_rom_device_set_romd(&pfl->mem, true);
>> +    } else {
>> +        memory_region_rom_device_set_romd(&pfl->mem, false);
>> +    }
> 
> Confirming that this is correct is a bit tricky. It relies on:
>   * when we set romd mode to true we also set wcycle = 0, cmd = 0
>     (which we do, in reset and in the mode_read_array code)
>   * when we set romd mode to false at the top of pflash_write(),
>     all paths out of that function either go through the mode_read_array
>     path, or else update pfl->cmd to something non-zero
>   * nowhere outside pflash_write() udpates cmd or wcycle except
>     for the "clear them to 0 and set romd mode" places
> 
> This is almost but not quite true. In pflash_read(), the default
> case for the pfl->cmd switch sets wcycle = 0 cmd = 0 but doesn't
> change the romd state. Luckily the "this should never happen"
> comment is true -- there's no way to get a pfl->cmd that falls
> into the default (except for being deliberately fed a bogus value
> via inbound migration).

Queued amending this audit note ^^, thanks.

> 
> It might be worth having that pflash_read() code also set the
> romd mode when it clears wcycle and cmd, to make the invariant
> more clearly preserved.
> 
> But this patch is correct, so:
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 


