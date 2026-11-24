Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B20606A698
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MfpUbKeC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ap8eim1f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVndb-0004XA-58; Tue, 24 Nov 2026 05:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVndY-0004Wi-Ia
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:20:32 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVndW-0007fs-Sp
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:20:32 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO5m2s12848316
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rHtKYqXEeEJOF9cHpZiNL0PiDrdxLeIdvyvjvrzs9vQ=; b=MfpUbKeCruO6jrmt
 s6p4S4zpjnqpwzEgH8B8T0ksBmAQyplhrxk/DpUWlNscE2IxW+VCN+J3VerbAxBZ
 9LI/1VAJtbLHHMt4YPQjnY0whilwvhQZvOhHaas/Y4DrgPo9eA9k25H6AXr+l58/
 Qg6PwHn+Wee1J6u06DzoPdQ5wE3rEzGg+ctvWhFwtcG35ZhASZPAJBcyaLB0gfX+
 +JhdEbDQTROKOCWt0rmvmMNUpMP2bAUFry9O3EOcs8a9kMQN0DmZxRijSG24MVnE
 ni60pVQzPy9xvZ0IITBGaNO53aXM0crPyt7EyEk01vboeuaiMIJ0taqLEkCbuwbo
 v/CP9A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rh93x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:20:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94961511b61so727876185a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795515627; x=1796120427; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rHtKYqXEeEJOF9cHpZiNL0PiDrdxLeIdvyvjvrzs9vQ=;
 b=ap8eim1fbv8ftPQ+Fn4zExdUSWLJy9UPtjpN3mCRHCR7zWOsoWuY1eaA8SecF47Ojl
 wZ/iBJAHGVgL9CwyZI1Dr7cpYxx66I9qUmw4DF37CeoCgo7pKPm+KC4NlysXYieH7+li
 V9eYXY7HORsuY1vMzQCO8bFRfq7mINsPOwmCGtnCe63sM+35EjBeMQzcbGLiP1Km3q73
 vuYeJvNWHWFECf28RNy1h7pq+n6elda7t2g8gc1xmFOJxAIImtomxGskD7c0Pet4lEoU
 EBxpslgo2TNOCqsVAoEe7NzdF5YGIsOx5GKqo1qaW38CJxlAGQjjbJ6HidzOp24U+eiN
 YWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515627; x=1796120427;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rHtKYqXEeEJOF9cHpZiNL0PiDrdxLeIdvyvjvrzs9vQ=;
 b=BZEtN/VgE0QoO8rFUGsooCNKat7n1wMU04YSaQ0Ffr9CyWboreAcz1kXtY8cCPGMJG
 Pvu0PqJ2f3xD0KJ6172SENk4PGBMEl6/IYBmNWp8Dkl6Kf7WJiTBcIjP/Io8cRLbA7gr
 bFkZKwC3cEWdmOxP8puMdnfkMWvZF6G3f89pJO68zkM1AsdLcBU9gwqgGW2n08W8W2Qs
 SS9Wbs8RTYnEe+h/sD3OvUwNWltLOEZwJSx7T51doIJBTe47DOaw+QaBiuq3kgGWOlT5
 5OoqvfEmLL02REqj560cOOV1NxR84ExCO3NQYhGb0WWORoTFw2ifphhpTUSsVvFiE+oB
 LRHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGarYOkPuy2aHMi5E8m3MvRUhbwf1GH8Q7zvbM/VmOaswpNN5A8lxRDodoDiKabE7yN0UNDnfE90Cih@nongnu.org
X-Gm-Message-State: APuU4Z9bYFQWtYN0KWv+TWyEL2BYD8voCPNTaoeQvQcMLJzBB1RjsHpF
 o0XVj2JSueKncDtENVqJcgADjsoXizIKVftYSJq/G1NtbYGCXcMdkyC7pU76MxqrDiHuuaqs2WI
 kEO+WeAbAVZ8IuzLyz+Vw5f3HKbKlAILbGd5SIbbWPCZHAqT2D+nqtSCPoA==
X-Gm-Gg: AZFdTZcTfcbUjU18oxDVFyVPdnRK/wyB4jpNpZ5y7WLYz3UYv98hYSeyLZj9WJZkhJN
 vxhyZP4e9+xbeZfIPzzwAhs5Rg/C2lB42pMFicNKWHqg3fzHyUe+nqd4EShAQzgkuL+egW4czU/
 D1JTaUYT03TeLFE6rXuK/fL4Bjbec3BfJZTrBCe6z6+WPm9zP5kBbj3UipALugVClvfCLYAMEES
 KDllACm7p1+7lR2kbx4AFm7lg5XBMNIvUiTBDEpJ8TwL4567k6uRq/c65HBH/HmQPHtYTeWjGQm
 Sb7LMGataFXm0YCpnkxuchqUc22+G9SqnZLqlbHH+nAllotO2hOwv9kdmFdbDR4+74XM7yDerCJ
 L6z/OsuaUchPmNqO8nDSSRVM8pIQnmP2yHIma/HW8Qjiibg7BbX/gdQR1xbQbW+fEZZrBbvErwa
 rUrVQQtsY=
X-Received: by 2002:a05:620a:458d:b0:939:6dea:4f1a with SMTP id
 af79cd13be357-949ba9c228amr2447605485a.48.1795515627460; 
 Tue, 24 Nov 2026 02:20:27 -0800 (PST)
X-Received: by 2002:a05:620a:458d:b0:939:6dea:4f1a with SMTP id
 af79cd13be357-949ba9c228amr2447602785a.48.1795515627004; 
 Tue, 24 Nov 2026 02:20:27 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dd55sm26493972f8f.30.2026.11.24.02.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 02:20:26 -0800 (PST)
Message-ID: <69976e65-ae0d-4fe7-abe4-1894b4005873@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:20:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 2/4] hw/display/vmware_vga: Check for bogus
 FIFO_STOP and FIFO_NEXT values
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
 <20261124095719.4126146-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261124095719.4126146-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b0564ec cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=hlCYXMhYWPKoYp4UXMcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfX22bWxGQRJGvO
 YPO+YEQ6C0ON3/P6Y7epccQEVjaUS7tr3erCQ05vxle7ekgdFz10X08c52T/7JwFGdc6n3j4+5u
 gQKZiH7gHSm3pRv00dhQdBys8kbB8io=
X-Proofpoint-GUID: L-CImttYteUvECN9zblrbckZ586Wm2jo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfXx/JRtcSEz1Uh
 gzwcSmMJK0i1bp3Ddo+hHSUx53UQ3q/m5jOH91I/AjCqkeDbthP0aSXlj3GPdsRW6/ns5GCTF1e
 F+Zr4ulhTv1RnvVIpkBfcQCIeOhwL9Q5JsphURmknK1zSpj956b+Vj80s2df8n4sNne+QZ/KPxI
 QNtE7wmljQO2oRl+RxJOeDgCw1jeHpvbGgtTJXOdZnDQJV+32xks2bzJzF3mtfeap9XpyenJlgf
 0oSvrM78pcLjSvt05D/AiVW/MLlQ8SjE2n4oF9rllTfsKRFyW+4zhRTbe9Y6bcp09KUnkfsLiwO
 HNbrCvoHCS0PXMBiHKJbQDX6X/ZNexrnzQVfwQJKuFjyK7HY+V0kAem8fPxluK9pM/sUulaPvsA
 V2+ObHDeUjgvv+Sy+wm2e+Svhi+GqSQ0RRqhVVHrojfdofXldkAAHwsTVDn18Vx/iOAXgUEE1Ye
 m9gbVDLIXKqvZIGJIzQ==
X-Proofpoint-ORIG-GUID: L-CImttYteUvECN9zblrbckZ586Wm2jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240039
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/26 10:57, Peter Maydell wrote:
> The guest should never program the FIFO head and tail offsets (in the
> FIFO_NEXT and FIFO_STOP registers) to something outside the bounds of
> the memory area it has defined as for the FIFO via the FIFO_MIN and
> FIFO_MAX registers. If it does that, return a zero fifo length as
> we do for various other bad values.
> 
> Bad values here won't cause any serious problems as we were rejecting
> offsets that would cause us to index outside the s->fifo[] array; but
> they're better rejected. For safety's sake we add an assertion on
> the fifo cursor before we read it.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/display/vmware_vga.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)


>   static inline uint32_t vmsvga_fifo_read_raw(struct vmsvga_state_s *s)
>   {
> -    uint32_t cmd = s->fifo[s->fifo_stop >> 2];
> +    uint32_t cmd;
> +
> +    assert((s->fifo_stop >> 2) < SVGA_FIFO_SIZE);

s->fifo is a uint32_t * array, shouldn't we check the index as:

        assert((s->fifo_stop >> 2) < SVGA_FIFO_SIZE / 4);

?

> +    cmd = s->fifo[s->fifo_stop >> 2];
>   
>       s->fifo_stop += 4;
>       if (s->fifo_stop >= s->fifo_max) {


