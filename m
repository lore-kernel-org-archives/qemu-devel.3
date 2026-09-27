Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0E1C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqJb-0004qS-V6; Sun, 27 Sep 2026 10:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqJU-0004qA-BV
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:57:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqJS-0006Ft-Op
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:57:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R7qcsL1605899
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mEw8t7fU7MzgCJNXG2ecYeiW7Jvcq9eiJBRjFVPORJk=; b=PYe+2eNgl+nQB3to
 UEPE1b0xOt8A3EOp4UZW9rZongPbGfjwqtM7POyOrLYFMhfm3e7AdKGVnWg0wehR
 KxIa0zpk/DTfgYH/jFhYvd7TK92dmLNa+AwGzsMVtPasNnz1hKQlY8NNypRXZ6Ce
 HZ9o15BVryJqh+ZO6w0wVY626salXWsklpQ6Q2oNv+3Nxi53aa3Jt5beZrsdpFnC
 KNpjwVEdRAkMnv1vMsLcmumjoDaG2bYhc/5zdS9vjg2Vz5Tmnb+ochidnacZMiye
 ysnMe0ZaLYZdVoIjwWCFxKhb03bRqITe6QYehS95vfxevCuKiazyqrl9aPzPIwUZ
 221M+g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tek286-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:57:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so586049285a.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790521028; x=1791125828; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mEw8t7fU7MzgCJNXG2ecYeiW7Jvcq9eiJBRjFVPORJk=;
 b=jaQaTpyhOIK5R2HLBdQNSm2j7Z6Bbh30bZjPrVx2S58YPxDZGjdxJ9JB0u/KLJqK4k
 7055nJezr6DtQDayPsU7kBnVyCoUJng5cKkOlr089lLr833PlfvUoy4XPzxS6obC3r6F
 lNjoijSVqx6WwR5kvoO/4OxA73VfC36lOnsGynrsTWVsMKvdn52Ot9FG4/DGU1DKKsQD
 9YtcAkBnFG3SK6L9MSPg1j/m/JNo2Oe84du1A8TQLZRZgD268qG4om2F49yBvjEOcLP9
 UMmYvvdghhJYef4TUN3HDi53ZmfPwnFQ88EXVNweNUeDu4suc2s9WqttwEQGZrWcwonZ
 VWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521028; x=1791125828;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mEw8t7fU7MzgCJNXG2ecYeiW7Jvcq9eiJBRjFVPORJk=;
 b=cR7dKSll7bO8kuwg7NxuGsSaFziM350V97s1RP1WhnabNHOWxHwWTWUIdhaehYAmZ4
 CFYphruIQRdR8qHGPONony1YowL89wPUyWG4+wg+1PnsV1GdkXfnTJWADgGJc03Ugrgx
 tC0o5wsTH6NzC8rvQaDBwyHHHX3WfaT2rGCl0ByTBtHs5mfzoBvUR8XGRrFrfQwRSqLU
 m2Y2XZSBn5jOKJ51d24HBt2++uRkfKFB3QULdyzxgVPgu+I150L7izNW88CETtYqeOTC
 PlRezagQGFtLScYxZFSvL4u2PH2DRHA271jgCgpC+B5IURYmWDx2xqvjxetUKIrh/uQ4
 dDBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpdi1A8wvwXLSZVcRDCDwrdLDoWddx7dDNVf7q75Z7N9wY7BjFNRySjhnlkv+Zel+HwXW+aE+O3nto@nongnu.org
X-Gm-Message-State: AFuF++mK6RJB/PxRSplOYovLkvhnxZ+xYG2eTJuVT9kmTUWGG8at/Rgy
 SCgW42OyZHrs6VD4Q433x7Z0ag5EodqumW+IGqk1pMhIZga10G/SYyVMlHaXRBVpGEzewHoEP4c
 /Nv4VR5Iy8HByS0WWE/0Dd1P0AqCT5cGBa6IcqGS18dI4lekWkQMD8oNnCA==
X-Gm-Gg: AYBFou2lasn50jwJ9UW6AzXRI4lethhhS/os3P1+4XSrJ+m3chJQL5KyJKTXZe5fWZA
 UDJyKUaa7x7RTt5mIGBiZNfu/tZSE6SbGTKfyrW3iqUbRrdfDGdSrRX9pIrOuXte/gJp3P3sd/x
 3ElA1CHFd/WDB9pMF5/VYXVCwy1X5ryJPSw6aocahg4ip71/7X0d0sU8Ur1E6vIf+GPh4a4+enJ
 qI/1U/MfL6m5BF+bh0oK+CklwKHo+a2pl2DE8xpjkw56zb//Jgpac1+NwiW2SOkpqxFZDn6Gevp
 92HpEHdKcOK/bhOXtyaC+tpwvIUOyhmyh+VhfJmxfGnkzxwXE76ctWIsJAo1l+I2i3Iphxlarws
 eot4UdMJZTRAD/BsydavJ21TG75u4Y50vjA==
X-Received: by 2002:a05:620a:1b85:b0:93c:5f3a:43fe with SMTP id
 af79cd13be357-93c5f3a461cmr717861285a.34.1790521027734; 
 Sun, 27 Sep 2026 07:57:07 -0700 (PDT)
X-Received: by 2002:a05:620a:1b85:b0:93c:5f3a:43fe with SMTP id
 af79cd13be357-93c5f3a461cmr717859285a.34.1790521027329; 
 Sun, 27 Sep 2026 07:57:07 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30c43asm21992142f8f.3.2026.09.27.07.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 07:57:06 -0700 (PDT)
Message-ID: <5ffc8331-b628-4177-81bd-c90b35518840@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 16:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 101/101] tcg: Annontate functions in tcg-op-common.h
 with QEMU_*_NONNULL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-102-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-102-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX39fmoWzStJo5
 wXnXkpXPS0EdgzeVuJ/V4+nuHwDo8N/8CEbWAyxHOz0S97ppIVUYsRgZ1EugxxipAD2HfSglfwo
 sla5jmD5eePyhDQv5lZs8xe5Msk1YQqs8BHtMcWSJZqXvwLiqEed64r192U+PJaNgPs5oSy5Mt/
 k0YB97CLP3iOqiYXMD6vUT3injw51suw9R9/U4rYEplF5enHBZs+GMvDqsXg82LVMtZY8compWa
 zKXz4SqqdCyul8G96kRLQ3gFS4L7nbtnmPPUKiqezk3g0j0G9YMPKFQ0QxLXbaPsvGcjeh//8kb
 bb3pjIHqOOeuiexF4mLE8IARHoAcFk6U0zdbNUWj1lFBegvZJ7sm4PUndPiBZWvpBs0pOQSNbS7
 haXJPp1M3/k3ZGzdthSVa9kZxIZ2Mn7I0UdExHN4mNOsdhSdgNMl0LhPgw3PZthryUtXFt9vx18
 z1SW9ya/7AGDtCZfVnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX6Mk51UmmB66U
 NrKN4vR1Pj01paahRZwCEIoiLkyDO+WuYN9bv08M2Fj8dgWBWFyEAMtqGRopFozG8VimWBj6fcQ
 4uewzN3A75ASVcz4qeHzTxappH72N38=
X-Proofpoint-ORIG-GUID: EpsfAePyMcYwVjcnKHBY2Kxqc0OYL8bN
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab92ec4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: EpsfAePyMcYwVjcnKHBY2Kxqc0OYL8bN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270059
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

On 27/9/26 11:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 188 +++++++++++++++++++-----------------
>   1 file changed, 99 insertions(+), 89 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

