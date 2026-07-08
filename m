Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D9CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whZ92-0000wM-Ht; Wed, 08 Jul 2026 16:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whZ8w-0000vx-EM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 16:45:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whZ8s-0008S7-7P
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 16:45:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668K9UqP3701999
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 20:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tYf3F1aiUG/tVOUPtQsbPuSF+owft7f7Rp9DEL8bckw=; b=Av+H0VMQlInN8PAV
 NSEh+T4bqjpX/Z63LRr39TkHdb0VgBWGSewbh+Bd/kZaw8qaCFUTG7ylLmfLWmQX
 39YmN9sLVJ9XV+FKm0wLVKAFa16lREJQK6GaiAjfG9ngTmZQ1YoznUA5VG5e5LWn
 ysbiAC63Xwb+JlC8o44x+SQ3rA57SszKVIrOeG8GJ57nQzUOeRFt8JTUMSZwjroZ
 szWuUj34QeVJLKbgxnBTNmR13IQFyTBqbGZ3CPhXYOXyM7nnjpIM7de/OmInyaYZ
 FQ7/LNSbSshKQo8XmwsMPSLMiQbQycz00IIpxLi72+oswCR30Kollz3S/boSI24H
 TsfMzg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u0c9k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 20:45:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso4685671cf.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783543510; x=1784148310; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tYf3F1aiUG/tVOUPtQsbPuSF+owft7f7Rp9DEL8bckw=;
 b=RCeXOX7+a7uVnyB86U+Ppg1r9q5XdmIkGGbmarxykwyx28YFocIsFlW78rRlokWSem
 BIwnrYkCIygn2/iXavvYHDn9AMCGMOzTdzwkVbVCfcloCbhUZnAdH9+OYDgFBpJ0ddxl
 Y0Y/tJB5UR0qPmID6hjHi40pXNBiqKHPq2Sa5+IBkTevzEVYGnlWzXZEHmCOsO8MxcnX
 uoS2m6tVW+A6L64Hof39ChS8znSsPYJJqJke3qkD2S8OaU7CKKk7kyJIx9mCW4FgTCm+
 oRNG+rONcr+Wi1xkWt3an/nsOifi+b0JHOmbij/MFdCeLz7sIYXbEPZLn793cfEA4u02
 8mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783543510; x=1784148310;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYf3F1aiUG/tVOUPtQsbPuSF+owft7f7Rp9DEL8bckw=;
 b=URT8f1YV09O2/Uqv+6HHz1VsqSOgbJiC0haIJrppq4U24WSV9v2L5kYPoDlfF/mPu0
 QJGbWtc7WA+LTu3ryHkvtdyqLcL06JHQ0EzZihgYjAtNI9Rayb1cS73HzaPSURrciYMQ
 75xV+2KZsq+OUzVoLTiyKBmvy1J/va8SeuKa2CVOceZOoqxIyNUoNhSX7KI3tvOJXdG7
 zvZFsLG81DjBp5Qe1cnHxTCjjctvzvVJ4ZmfDDx89vFH0AsVujD9kKls2AQ7V7n61WiV
 S7odvcMWe3ruB/yZ7zCivE1L5vZxGfNe8wawkTT4GRKS81Yt2CMZQ3uQeXdX4RQEHRbw
 RvdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMcaSwK/tQ3xGI6yGOGclHO1zFPRgC2zqlVLdDp4Je1h9JjHATF16TIg/D8lUBh7IGxE1ESnmcmg9R@nongnu.org
X-Gm-Message-State: AOJu0YzwtJADIyepwI2INWRPTmZ5Co6p+YuNYuLhUw9xA07SSSro6urM
 Eqhy6sypbWnTrawNWnDSleDsOSsG+4mAZUyurAw13GhEIfjMrsP4tI9Uz1B8Dt2vabgl+BmZu0D
 28W+iYPEM+VpBZRbc9q5MQM4OkCK/0+vQKS/iRmi36Vr3h2d1Df4YUpl3uQ==
X-Gm-Gg: AfdE7cmGs2YeD8YUdaTd8rlPHQLiKZhRN4fD3v+euxMyA6Vz74KMeVr0qNh+vMG+Tm3
 f5f9FyX+x6tnA6LMo0Yc2V+Kv7Ys9DrMI8UVxMUcZwgV0hLmC+dWPlkyR0qqBGMNhJ92Ur7AeZy
 icC52G+eVRCcQi1vqIGQILT8djmreFJRpkEVAKxQ7Ds3NfOWbVedQ3io+UkMob6Q52GwtLpED06
 N75s2O0Z8JFixwy7wxep9forq6lk0knl8032J5ZgkS34alsKLJwNM2asJkRvnDruymFh1rXZxIe
 I1x+E7JLsU4WHZUY10VPWvA+riZVn8KAlxEk2ps0I6Bn47j+pEpCbIMbpHMpwN/Mc0w3nqzYFls
 L2LhU+7jQCXAUf3q54sRlzMRIRcjBqn/1apCAHC56yxYKob8tgiAsnjvED9ByQg==
X-Received: by 2002:ac8:7d14:0:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-51c8b4d596amr41363701cf.56.1783543510061; 
 Wed, 08 Jul 2026 13:45:10 -0700 (PDT)
X-Received: by 2002:ac8:7d14:0:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-51c8b4d596amr41363371cf.56.1783543509543; 
 Wed, 08 Jul 2026 13:45:09 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb70a677sm4956855e9.8.2026.07.08.13.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 13:45:08 -0700 (PDT)
Message-ID: <1097213e-0d13-4380-8fc0-5d94d3e657a0@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 22:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
Content-Language: en-US
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIwMyBTYWx0ZWRfX4RrbMhzw41SC
 w4GrFeSgI51aB+7efr1uhQeb/IOgoB7EaJgMp8l9XD2MRMJ/fxvUG4yNWRsK3P1HR1+1H7myDcZ
 SDZDcRPmJiJhSYQbEReXnmD9b1bZavk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMyBTYWx0ZWRfX78YlavQYA+04
 8EhZAcRmyHxcjyFXZlhyKoVQWUnw1W2an/lTcmErzJGn4bUp220GO3dQA9DDJo9G9fJjRQ/7mpE
 j4QOr5wwZc0jk+vHC95VIbcIig20Z7NTdKovhkMYDokEOs53sLyGwUdMtnc9XU7t0+7yd1LpVsM
 g6D4flY84FXeofUpK0c3NWT7HK7yO1fCjS23HQQyzuaqKVspj5lYBPN1684IwWemzDS/cr4dMhP
 9xXVtjKbeY0cTWBKN0kjwBsE2Fq6OzXstCj/ir15kwWqjv9gy2WuAshIFYdgGS68a7IMObPB6YW
 S5xB/wJTeIVaUoRQI4WFCsS8MZJmAZioBCDSflsX+uZIiZQbnd4NZMzTTZlFpQUHw/ieNPki9sS
 9YldraqtIEOvZK4p/4cyC4UyGFA5BTkjTXpHnjJCdfqBRX1qUzR45dZxFwHScRGbza3KlEhAuvi
 x7OMESz6a/XoJHlQPWA==
X-Proofpoint-GUID: cqX9tGPlpECI3hWBHuxutNLC5xpQMWr-
X-Proofpoint-ORIG-GUID: cqX9tGPlpECI3hWBHuxutNLC5xpQMWr-
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4eb6d7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080203
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

On 8/7/26 17:05, Max Filippov wrote:
> Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
> which matches the way it's used to store `argc + 2` pointers.
> 
> This fixes the test for me, which otherwise fails on xtensa with the
> following message
> 
>    linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv, environ) == 0' failed.'.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 6f58b090328 ("tests/tcg: Add SIGRTMIN/SIGRTMAX test")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

