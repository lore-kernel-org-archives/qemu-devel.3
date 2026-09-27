Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979DCC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjJo-0002h9-Bd; Sun, 27 Sep 2026 03:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjJS-0001jo-V3
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:28:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjJR-0005gO-Eb
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:28:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QN0l9s3890290
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TEfeyU6VW9MHFvZc3xuJDDpjit7VZViG10ow1KCllhE=; b=XmakTD5tHUez5Tme
 1fu4Oygfx/SACtJUGbGLzDDWTVv5TB0+ZwWO2Pqr6j3kklkIheRnDkeFbgu+8IHx
 7ttQzzzG34KU/03KWQN5SZAmXGyHIIW2zuoNufVx3mQ8u+rx8BMGcZBF2tDONv2j
 TBd2FYUU8Mdyb4UHwFRTEFbvzZRir+8AQKXrXMkYENNuXYH6jUE5Y5z6QMSqxw/t
 5R+Jry/F3uagLGqIzsRyWAyhrbTKfc7fKcEQGLjYTNPAnrNv7NtSO3x1vnXLa3Q8
 /GcGN2rEBNRHWC0mbuq51RssscaMGXa/7n/1xLW6UCzD0UHzhYynme0VHTTsWjRT
 o4D/rw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jtce7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:28:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ae8e7e546so437758285a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494118; x=1791098918; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TEfeyU6VW9MHFvZc3xuJDDpjit7VZViG10ow1KCllhE=;
 b=EePuFCO/nbApoyELQpZf+V6osR/7a+Pb0OpaSVWHkTe4D9FP3nwVgUfuFC7h44zO4S
 DM1YRE/rxvzMKK4VyVEeBn6v+qHCTgLG9QaRviRrRX/lNwFRWzi/Uo+UzgZZNIrcGykv
 dCwUrMUWOqxhMFLwb3SU3mULi6uGLCpXLVqV8Kz5KF1DycbfkcJj4FGUbJK6wj+0TRtS
 s+3bA6bW+BUhG40FiGhZTdKGOBjzgpw85t2LV81yjxrv2XDg0NG8FjhCRS3jxIxYitnT
 9PzO/dm9jmha/F+zNF2+h5ZCqSbFu6NzjGFbrt8/1hOJhzfMZ3bnz55eaL7KAVvObWbk
 GTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494118; x=1791098918;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TEfeyU6VW9MHFvZc3xuJDDpjit7VZViG10ow1KCllhE=;
 b=UUvnVB9VS6Ge53aBM8bJ9vuRA01JhYgGzKD1E/pfml5Dch60LtN+8kEPD5O5U0J+Fj
 t/475yT7k392z756vL+BDoCQlHD83yevDdJemw5YaNYZ5m0ivHCEvrGXu8jJu7/GPSW8
 ExBcZ0E++FPq7IOvVWIB9eWvy54jOrNRvHj0aFB7OTQFYTU/AczyDOwpjZ8Z5I7IL2n8
 3qWZ2Sb9yR/082kjZvIUQv8zKAs83rAXbSm2XfmLUw7F5DbdKt9JD2SiZWcvMRBTc7Ou
 MjqIMNYIoAzhY33yREhejGwihHTd3K6R4HTGhqFpQ5PLrwu4w1aJKW/bQhJ6RQVAd285
 OnVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoZHbtqDH/kI0RfuyraPanY2+yFW4N3m6abHWshO+jHiTUoMNEiF9PcVtaAC+hoVy/noOqKJSP9RX5@nongnu.org
X-Gm-Message-State: AFuF++nxWS+zEkkEKkrOBXtxHY8pw8XP5XeHS4Jj+sHe0xldMYxB2o+y
 0Il2YHhgQn0ZLw+ESJfCIzQ4KcIVm7RLpPSPQmMWWJwT1KvhTNabkRfSLUTvLadipxkRiQ/xSUU
 Kq7AKjK8FqJA1iF1pCDm9JGnYhqeyxMnQyChj6UHG5EhqAH9Qv8Ie3gcM9g==
X-Gm-Gg: AYBFou1W0+4acDTE9X7Ak1Yky2CphWGCWiGjdKtm9QeHjYGt3XZSDuqRI5x8rm3IFhC
 qKuf7BCOGZpWW+7II8Ci6QYOrKg5kT4JHIqOnSf7vtjG8lodQgXReSlcfQEebfsvIh8y92nY4mG
 2m09V3medldNKVahi/IhNvxHaGoLy3rzQIMNzcpsaEP2OsKllqN38xMHFu563EyQYa6RT0hrqvu
 KjoG+de7t18/HHxzFH6Gvvjz68vZ8wppJ0ffWb0f0bFb27yqMVyYxgAnWWsmfMDg19T0ExNf9Pj
 kKrmvEFC1XCbD88Ls94UToAZvY1CPhunW/izpvNqUov/XjI2m/ajm1HJyFO+YYBXigrzIUx3DO7
 jZsKCGtiHKZgbXbLau2ovYT6WScnGEwHW5g==
X-Received: by 2002:a05:620a:19a6:b0:93c:62b5:fc58 with SMTP id
 af79cd13be357-93c62b5fd7dmr503030985a.62.1790494118604; 
 Sun, 27 Sep 2026 00:28:38 -0700 (PDT)
X-Received: by 2002:a05:620a:19a6:b0:93c:62b5:fc58 with SMTP id
 af79cd13be357-93c62b5fd7dmr503028485a.62.1790494118111; 
 Sun, 27 Sep 2026 00:28:38 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0019162fcsm36853325e9.13.2026.09.27.00.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 00:28:37 -0700 (PDT)
Message-ID: <30fa3419-f6a6-402b-a1e0-b009196e9197@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 09:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/bcm2835_cprman: correct register index in test
 for mux update
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Jonathan Gilbert <logic@deltaq.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-trivial@nongnu.org, Luc Michel <luc@lmichel.fr>
References: <20260925100726.1546566-1-logic@deltaq.org>
 <507fb835-61a8-4e66-80f4-1ae6f07a5bf1@oss.qualcomm.com>
 <52c613fd-41ca-45c0-9d74-faccb58c11cc@oss.qualcomm.com>
In-Reply-To: <52c613fd-41ca-45c0-9d74-faccb58c11cc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfXzfFXTVx0v6Lc
 mPs6PG/HgqFln5UzQv4CN2fs/x1imGDOpzt++BQz27vPefciGl6QKlo8NSFtYa8uZ/Qth+k8SKo
 vZ+sghatza9Q7yo26Agr9yk2GPtV8L8=
X-Proofpoint-GUID: z3-CoWnPwfboJ0g6tMTZzjgu3Le16Lja
X-Proofpoint-ORIG-GUID: z3-CoWnPwfboJ0g6tMTZzjgu3Le16Lja
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab8c5a7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=-ISfGIX_AAAA:8 a=V7FwDPytFGZRKx2tYQMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=6K80JWTZPwV2TOQbRzu6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX4Zx6YP25R+Jf
 DsfhRv1audueA2zn7zQB8WXUXJ4VLPKdQ6c7zx/g8cV1ibI37FlwHbNmoz38YGrXg5Fl2Q6Fv16
 7O784UIrmm3y/6Q7bsQjcXvmgy258BSszHQ8XPQn7nzFtx0WQ87TcT1IOCt58t0f44tASrOBty8
 FIwqAdPGFWscjwDdhvj4Ddh7b8sd+T43p9IEWRQiLme4yI/Rk/NBAG0w2hCPbl7tBVW9YJ4AGOw
 HtrkCtfEC4O1siHuijx4FES6VCKs6NgsXXqU4Y3gJzHQpaLlbRIXbYTeY1Whj1DRL38Gli/4x51
 xjrTWrQXAt6tGp1cqga6ZqUF9OIZx3ICjAJeVu+0szCd/5Rd627tvdoX0qbO7qrqG/crw2s1YBe
 fjCWsQ6fxvhb0N4H6x9poqysnM7HYG6c6ox2Lqy4yY9Pw+T3xunViWsnC3GfsXZKT6CrTVgvm+Z
 gFB7/Q2U856DeXnc0Vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
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

On 26/9/26 11:42, Philippe Mathieu-DaudÃ© wrote:
> On 26/9/26 11:30, Philippe Mathieu-DaudÃ© wrote:
>> Cc'ing Luc
>>
>> On 25/9/26 12:07, Jonathan Gilbert wrote:
>>> After each register write handled by cprman_write, function update_mux
>>> checks each of the clocks to see whether the supplied register index
>>> applies to it, calling clock_mux_update if so. Each clock has two
>>> registers, so it needs to check the base cm_offset for CM_CTL and then
>>> the next slot for CM_DIV. But, it was checking for cm_offset plus 4, as
>>> though it were a byte offset when it's a logical index.
>>>
> 
> Fixes: 7281362484a ("hw/misc/bcm2835_cprman: clock mux skeleton 
> implementation")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
>>> Signed-off-by: Jonathan Gilbert <logic@deltaq.org>
>>> ---
>>>   hw/misc/bcm2835_cprman.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)

Trivial fix so patch queued, thanks.

