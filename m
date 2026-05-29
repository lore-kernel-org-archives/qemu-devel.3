Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900B5CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5KJ-0005ng-Oy; Fri, 29 May 2026 18:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wT5KI-0005nK-2n
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:05:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wT5KF-0002cq-Uq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:05:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIswZa3526592
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 22:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jQfdheRL0RPUsLGZS1FZFYexOt5gXwrMh44T2dQJ7Zw=; b=Pst840PBsqju3p0t
 Cmu/egcAY4LFSc6exI5dzIhVPesUxjn87TtPJXLdLmUC52wzIKB6WstXuUyfb/c3
 m6T1KIZoLlmDdUvXqVMj+Bi6HGWNI8/ZYlslko8YUC6KhY0gsWN4ooEaceLSYd9t
 bDAhq4EPx+oiFFJvGqcP1GRDbGH0134BYPtdCH/CCcpnZXbPZ1ikV9yE3tywacgb
 eo6dUCrByKeRmCl/l5Am2rFprJxiqI1PRHrf6Hu3XMEtOmttPTe4rNKl2M2xPYjA
 pBhMG97qFWEKyRkl6pXHD8t82soI7dCzKWkoXBxG+6m5Ie+AJvluEEJOK5OXPCQl
 KsUpmw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efgge8q2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 22:05:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304f23c55b2so1043769eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780092305; x=1780697105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jQfdheRL0RPUsLGZS1FZFYexOt5gXwrMh44T2dQJ7Zw=;
 b=j9a4ZfMcSv4V+qjRN2vkVlL4wvOQcdyYnumrvcoZvGv/6eRAR/B1zT2yj2qkAza6WU
 IhgBGkl8TwAIhAzGFCWHTju1/L2yZuPPFqgcnqYliumUtIp6JOrL7d9QudTm7tRt8aTr
 6MA7PyYbARTfmSxZYTRzNHeTKCjAZCeyJ87DEZkRCz3c5qr32WELDvjnBrxcZlYU2Bdu
 /2JxuKCOIER8I0DVZOGtyvjyD1fiaJg8tl8vGusNFgVr9C4as46e5oXfF4sxkQHbJrYH
 z7HrGhqA0cvy+3fIEBmtvRTogMLSlnJ5BzqxDUw01l5UoUz8dVeXOmpqkxQnqScyUYK/
 3Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780092305; x=1780697105;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jQfdheRL0RPUsLGZS1FZFYexOt5gXwrMh44T2dQJ7Zw=;
 b=aVOq4deaampZ3ycq/L86VZUgUbqdHzDMSro5PBA1VhLBc9feltOSxTS+RNB8mYHLfT
 jSGC0a6bRP8mcYpljP+CKBMOSQ00qn1dCqchSyNNhtfD3njTFQIQX2PQww+QDsdIQd/S
 zCneluTONjaxG5yrAqgX92AUY80GE4ruU/8/0jSCUrcEQyWTvIVMw751tUmKw0yDkzFJ
 7I5igrktt/vyjRtEd9ybL8eL/LTSVwlLeJ4P7ARZWh7SbEc19O1Oq6W3CHwAwbW18Nqq
 t8nXLC3peprIJNle32iEjKTXyJ6PBF4KQXuCk9CVwCtsel12WC6KBkxsfiM9Cnda2nhf
 RiBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ80JpJFmZcOnDaEoNaFf4RScAibV3d4/J3ZIoJo8rsbC2nLUL8AkNnC8YljPMI08Z/PZYCGsWM6iWHA@nongnu.org
X-Gm-Message-State: AOJu0YyWcvAypNXc9Q2Eh4tLaD/CvDtXLLEtVd1QDvu+O++MQeAVmta6
 +G8FCyKlGqCJr9CofEmQ+O/ULYTT+4oBrcV2G8/B6O2TCEDkmiTD9UuaJw4McSx348YrTe7Ybyj
 rAaIQVAnBdpzQFJVUTWN68QQrVdu/RaFU+4JXDB1XrB5qKP/f2FI5GikChw==
X-Gm-Gg: Acq92OHeGDjDj+54aRU8HG53Zz/5hffGH1QQa5DNbZd8sgiH77+rZ0fD296iHxIIQHe
 rkcxDG5jtO/01dujPxXvYbdBdHk72wRIBgnhmgv3sxWkaV1/kbpIWhPPPZGyyyuxk4uho8Fq0x8
 NSuya+SelLSo0VEMR7kyxKoLsb3YFF9mJOWjTABaFfrQSmiZcElPZRLyns456diifw8R8B2i/P1
 GLIJHppM1Fd6UMdgycImr130j9tcrJTRGTS1yw1VrtefuJoLMMfcF/Kw7UYD6nszc6zt5G+FSg0
 GwxIfOxuasRE7f/fTWlJ9TwXruY5O2VE6XO4qCCVnFHE2PsKbHBTSqmav/9xvdq8WXi/eAuC3ju
 ZxjDZhhmQrYWIEHLBY9GmjTbPjAUWZjPXNdIqCxlvCfUDGCdPy0pBn9JDBL5cuuDGcixmIp9KAi
 sQ+pmiu6Bd9M7zkQ==
X-Received: by 2002:a05:7300:a44c:b0:304:562c:2338 with SMTP id
 5a478bee46e88-304fa5812ddmr794408eec.14.1780092305068; 
 Fri, 29 May 2026 15:05:05 -0700 (PDT)
X-Received: by 2002:a05:7300:a44c:b0:304:562c:2338 with SMTP id
 5a478bee46e88-304fa5812ddmr794390eec.14.1780092304482; 
 Fri, 29 May 2026 15:05:04 -0700 (PDT)
Received: from [10.110.86.149] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd6fdsm2158255eec.23.2026.05.29.15.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 15:05:03 -0700 (PDT)
Message-ID: <a724d148-57d6-4269-8913-68e9f29b9ec3@oss.qualcomm.com>
Date: Fri, 29 May 2026 15:05:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i3c: fix CMD/data FIFO depth reset values to match
 real silicon
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, clg@kaod.org, 
 jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, qemu-devel@nongnu.org
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260529014034.864722-2-jithu.joseph@oss.qualcomm.com>
 <71168e41-ad83-4a80-aa3d-3a40f042a8ad@linaro.org>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <71168e41-ad83-4a80-aa3d-3a40f042a8ad@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IjSoDzAhImLwv3LnxckG4g51hSYqpqhD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX2lVWPX42Rdv0
 ffQfsJwOd6nbnRP0De3q5mrL89zY1X9EQv4zmP86JyFnuG5hWUwxvApGK9fSZd8JVt5hz0NV2jh
 NPB3CeXVAHwlcFSkMvwBZ66d+TZKs6zWER5dGT0rTQOFlLodXCl/8H23JcFMyKhaBhndT3owAKt
 2w/E2SmJSwJXNmhXvDZPRwIwTUz0ucLyoYgOXlYbB4JhzRiJ41OLtgOUEczGUfQCe8pa6tc/FGx
 v4s8QBW07sWfUWW4FD8I+82ZucWipkjQIHdsqZkOk36l/gThNp7Lf9q5+k+8JLiIVJap8YS+oDV
 Vx36D0c7aKTm0rAbHFlGq5DcjScv9hlpGmOyFA4qxhNW1NCHhb94qbZKMZsaXubRc/grnTpQREi
 tkEeurYcy7pfOvJ7Ig7A1YFsGtXNyk8/vFhi5seesLR7H7VEzWbi8l/oqr6izPtZn3JbWEw18nO
 hBe9tDmnXpBe2CeeBfQ==
X-Proofpoint-GUID: IjSoDzAhImLwv3LnxckG4g51hSYqpqhD
X-Authority-Analysis: v=2.4 cv=Z4zc2nRA c=1 sm=1 tr=0 ts=6a1a0d92 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=J0xTLNSRAI11-Z3c0b4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 5/28/2026 11:24 PM, Philippe Mathieu-Daudé wrote:

Thanks Philippe for the review

> On 29/5/26 03:40, Jithu Joseph wrote:
>> The Linux DW-I3C master driver infers controller queue depths at probe
>> by reading two status registers that report free queue slots, which at
>> probe (queues empty) equals the full depth.  It then uses those values
>> to gate every I3C transfer -- any batch whose word count exceeds the
>> advertised depth is rejected with -EOPNOTSUPP.
>>
>>    QUEUE_STATUS_LEVEL        (0x4c) [7:0] -> cmdfifodepth  (cmd slots)
>>    DATA_BUFFER_STATUS_LEVEL  (0x50) [7:0] -> datafifodepth (32-bit words)
>>
>> Per the AST2600 datasheet the reset values are 0x10 and 0x40 (16 cmd
>> slots, 64 words = 256 B).  QEMU was advertising 0x02 and 0x10, making
>> the kernel believe the controller can only do 64-byte transfers.  The
>> visible symptom was -EOPNOTSUPP on any I3C transfer whose payload
>> exceeded 64 B (datafifodepth = 0x10 = 16 words = 64 B).
>>
>> The underlying FIFOs in QEMU were already allocated at the right size
>> (fifo32_create takes word counts; the existing defaults give 16 cmd
>> slots and 64 data words).  Only the advertised reset values were
>> wrong.  With this fix the guest sees datafifodepth=64 words and
>> accepts transfers up to 256 B.
>>
>> Fixes: e974c6957576 ("hw/i3c/dw-i3c: Add more reset values")
>> Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
>> ---
>>   hw/i3c/dw-i3c.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
>> index 17ff484c5df1..e1bcf083210b 100644
>> --- a/hw/i3c/dw-i3c.c
>> +++ b/hw/i3c/dw-i3c.c
>> @@ -282,8 +282,8 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
>>       [R_QUEUE_THLD_CTRL]             = 0x01000101,
>>       [R_DATA_BUFFER_THLD_CTRL]       = 0x01010100,
>>       [R_SLV_EVENT_CTRL]              = 0x0000000b,
>> -    [R_QUEUE_STATUS_LEVEL]          = 0x00000002,
>> -    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000010,
>> +    [R_QUEUE_STATUS_LEVEL]          = 0x00000010,
>> +    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000040,
> 
> [R_QUEUE_STATUS_LEVEL] = s->cfg.cmd_resp_queue_capacity_words;
> [R_DATA_BUFFER_STATUS_LEVEL] = s->cfg.tx_rx_queue_capacity_words;
> 
> ?

You're right — hardcoding 0x10/0x40 in dw_i3c_resets[] ignores the configured values
and would silently advertise wrong depths if these properties are ever overridden

Since literally initializing here would give compile errors, I can try overriding
it in reset functions (dw_i3c_reset() / dw_i3c_reset_enter()) after memcpying from
this array  (similar to what is done for R_DEV_CHAR_TABLE_POINTER / R_DEVICE_ADDR_TABLE_POINTER)

> 
>>       [R_PRESENT_STATE]               = 0x00000003,
>>       [R_I3C_VER_ID]                  = 0x3130302a,
>>       [R_I3C_VER_TYPE]                = 0x6c633033,
> 

Thanks
Jithu

