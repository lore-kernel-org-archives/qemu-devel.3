Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C90C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBPzS-0001Nb-W1; Tue, 29 Sep 2026 01:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBPzL-0001N8-K7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:02:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBPzJ-00083t-VM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:02:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47NSO3891436
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M9mhHj6twl8UZM2hyFcx2ajDxRfDBFQMhgUFDwsx3Bg=; b=UBuoOeI5npMPA3T1
 YiHUfj4Y5uWVGbozpZ08iJoxqHzQBb4qON/LDlzCjbsYO1V8d0D+3PW4vJaB2oB9
 sVgq+CekhfKCd7w5ltJnr+wyrF8IZFtm66tEoJ5zbG4s4e9MsX98f9dVR+Gz3lrE
 M2MmEQwV3LZv3yQ/LGF38VtpMhFsutkTJRziHp30SVsekFQsD6oF96za+/PlUbyD
 /+vIFo+ERnxSJAn3gUk6ek0g2FxGjd48qn7iE82/A474AHT3VcKp0peCQJtSy/tD
 pBRY0ze+9kU/U7Es3HG1Ac6Lhc00H7S/5s5XuxX36foDtXJz0R66TAbgYxGpiih1
 mbOWZg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfkv7et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:02:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a183a0e93so831133085a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 22:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790658163; x=1791262963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M9mhHj6twl8UZM2hyFcx2ajDxRfDBFQMhgUFDwsx3Bg=;
 b=WWZUsHUqHFugTaT5Ln1/byjcO351khWncKwt/MPermByly3rr5LVhQZ+eZyE3IcNO6
 nkW4y5IH/JCAlJiGVuThc/QM1NloiNtRhbhqZBN4Tt0ErSNKRJFWgy5/E7ojFEBDCnWP
 8w5eFGQzIXtFIlznqHpGiKBMjCDBDZ+kxb7iXbB888xtwGhtQgac5ZTexhlBgvutDbMP
 3bH3JADb3K5IKbRFBoUQefl+ePf7LGLoOGIQB+XuoFYmiGbdTGCRvODfyGb1slCHbgvd
 VgPeejloOW0h7LBoVk0pgnKH68shnA78dftSOSXJal83llYIE8kvawVoASnpIZmPkPku
 /EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790658163; x=1791262963;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M9mhHj6twl8UZM2hyFcx2ajDxRfDBFQMhgUFDwsx3Bg=;
 b=SFMclFHcaGgC0+T8kjCNSkl526bIBgAT4Ev/SOG8j1i7g0mSylC654juFXEu8YqPkb
 95X2nFmG4PR9aYWGDZqDIhf8HGYM1HT4CGRY5f7aND/IRKSoabPlPGkdyw+9aV/4Vx0g
 lw0uvOC8Wsd2kMKn/PG/NPKTQEpke2VlBwXU9wudogJwABw4tSMuZalRum449daNyyV+
 d7g7qRPvBHetlwikULUKVSlwYQWQHKBSRV5LdmoseN2IOGtvNqD0Gz1I3XnbDzvg6jP7
 dYX2y6nDlJtexwuCP7ozWB5+0lJPdBmN1+bYiSfnqckDRQrCmj/cYlBp3/AKsRkdPMPx
 zgIA==
X-Gm-Message-State: AFuF++mXL3mobKYXA//95u8+53WnJbmEBC2kCslFYRdhazCAyd8pxZa5
 bN0E8WGFcikjymyfymEEmPIctbCOXHFnOpSnAM5dtHlC5Wx2qosVWk4AR2jc7mc/RjGx3u5WR70
 psCxjk20+B7/ASnxgb56bxWJrWG2n2qmQiHiKLEbZf/OfkSRC1miTtrRndg==
X-Gm-Gg: AYBFou35qRYfUFJOz5XUBf0IhODdq6/lPTSW5EHyMtkBX2PoDgiZAEmbJsiDkzWsto3
 /uNfZ3+7zrVJDoGCe8ML0hIXdp0pr+aZpRR0BFK4pSLnLYP2a12LchZxszmrmaLl6q72RXLbtVs
 UgT+lKZRHTe+j8AonPcSc5LF5DoxN2f9Jx8gQEYx4FhIhYtlFCOWTIWCwwra8t5M6J0RPuw08EV
 Wy8uQenGuEWCUtSF6X93/gtwHs5kCvzYPQWTJHJb644PjrbLeWCFhdp0yvJBNuMemdv/LWyGBPo
 hkkSpDk5UTdQOglif3nuCu7BhaRtB6J5KVMk1b8hD5iZCSietbXKm0aAIhuhus47MUjJFUKWHKN
 t/6VzcEjsUWKBEsv4BvUHQrSQrZ57z1s5oyW64YQ=
X-Received: by 2002:a05:620a:8811:b0:93c:23e4:359e with SMTP id
 af79cd13be357-93c43d1608cmr2450108085a.50.1790658162936; 
 Mon, 28 Sep 2026 22:02:42 -0700 (PDT)
X-Received: by 2002:a05:620a:8811:b0:93c:23e4:359e with SMTP id
 af79cd13be357-93c43d1608cmr2450105285a.50.1790658162438; 
 Mon, 28 Sep 2026 22:02:42 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af502cf08sm993667f8f.9.2026.09.28.22.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 22:02:41 -0700 (PDT)
Message-ID: <3847bbdf-02b8-4511-b745-fafa86bc9204@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 07:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io: prevent unbounded read of websocket data from client
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260928130904.3921495-1-berrange@redhat.com>
 <CAJ+F1C+CqVB45HLPNaiwJJjbnrmwNAkDu=kGN=Ut8OsBW4VdYA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAJ+F1C+CqVB45HLPNaiwJJjbnrmwNAkDu=kGN=Ut8OsBW4VdYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxOSBTYWx0ZWRfX0zCkDgCzjx+K
 ITR8BA+e+r0G2dZ14q6Msu4jWlZgBY4o3xzfw577BxhQ+huGrpl1rkPW1Fevw1Qkgeht7mPVM0X
 5/+xKJQlEzVCoUvwdcqBQ4lmS8NIWkBQU7HJh2WnySIjwEHghL3V10LVFeJ59c7vUJOP04D7cvX
 xkc6POeYUCMkFXpKoScXxHJcfI3wJplZx0ZLB5a5b0P1Uh/HKgcxy7cxnhKoPYptJsmgVtCymLI
 N0nMTmWme7+8yX4XkfGQjIzKupwvlbBlcQymaxl1v2Wb2VpmmDGz8qAoMjuy9jbIDqjYQfkhlnS
 yPnYDKAHHPmVlgG1Cnc/JAljJb6AxiyYNsUmL0FVOv5GP5tAn+wfhjV5vzAiYya5gXHmdFtgCqk
 O5P+wP5/jq9KuQdP4Y/bH31IEaYM65a6euyXB6aWdVq8l3wMpH/ABpU0SSAQHIC5Pe0Rwx8FUw+
 h3bWUV4cvd/GVsbZI+g==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6abb4673 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=FnapOH-xWNCB5aF0RLMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: mDXiTHaCJIsEcD_UyTcld7-gJfgDcm-K
X-Proofpoint-ORIG-GUID: mDXiTHaCJIsEcD_UyTcld7-gJfgDcm-K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxOSBTYWx0ZWRfX3+YtCZowcL+L
 o9o0/zkp43ijH8zdNd8QPLRQluo+jG4enrMlGS/FFiS/WVRX2aheE1HgCbjulIRCrocDPlw7hQk
 /EvTwO7MN9csFISJPI2NCi2xVb1zbYk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290019
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

On 28/9/26 22:09, Marc-AndrÃ© Lureau wrote:
> On Mon, Sep 28, 2026 at 5:09 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> The QIOChannelWebsock class wraps an underlying QIOChannel instance,
>> providing a websocket server handshake and packet encoding/decoding.
>>
>> When a watch is added to QIOChannelWebsock, this in turn creates a watch
>> on the underlying QIOChannel that is always monitoring G_IO_IN, as long
>> as the 'encinput' buffer has space.
>>
>> When this watch fires, it reads data off the wire into 'encinput' and
>> then decodes as much of 'encinput' as possible into the 'rawinput'
>> buffer.
>>
>> The qio_channel_websock_set_watch method checks to see that 'encinput'
>> does not exceed a max limit, but fails to check that 'rawinput' size.
>> Since any data read into 'encinput', can usually be immediately decoded
>> into 'rawinput', the 'encinput' size check is largely a no-op, and so
>> 'rawinput' will grow without bound.
>>
>> This is readily seen with the chardev socket backend if enabling
>> websockets, connecting a client that sends data, while not running any
>> guest OS to consume data from the chardev via a virtual serial port.
>>
>> The qio_channel_websock_read_wire() method will also unconditionally
>> read more data into 'encinput' if it has less than 4k present, which
>> is then decoded into 'rawinput'.
>>
>> IOW, if qio_channel_websock_read_wire() is triggered for lots of small
>> reads, it will be reading and decoding more data to 'rawinput' than is
>> consumed. Skip reading more data if 'rawinput' is already at its max
>> size.
>>
>> Reported-by: Aisle Research
>> Fixes: CVE-2026-101291
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> not sure if it's worth to add:
> Fixes: 2d1d0e70cf3e ("io: add QIOChannelWebsock class")

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
>> ---
>>   io/channel-websock.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)

