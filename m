Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F2606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RhlGGoa/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fllhK8+K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnVJ-0000so-3S; Tue, 24 Nov 2026 05:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnVG-0000sU-3E
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:11:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnVE-0007ra-1S
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:11:57 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO87Jrb901866
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v0+LEj/fI1GBgn+O0B4Y4CFXU25e/qj4jggK6TUMfcM=; b=RhlGGoa/ajdOdOTC
 nHg2avbzFJNOriF0XeFU0tCQQGyzNJt3fMaQLz2JFiwNVILNyj81HogUrv3pb7Sl
 s8BXvdn3YFAU8IgzHCNTZyU/IGV7XvyCje97XnkEl5Kd+aJQQLhzTdU2b1l3LTLH
 0SuxrUXzRsUKx0RCl5xnuwNVYIPnj1h5RBPoH3eI/TXYHMQSYO6E56aRkJxBWIrQ
 QHJgCeEEFQPkFg1Nb3d9LnIXosM16ovLLZ5fa303DNB0Oe+YFco771grQM70o0N9
 8iqohzW8yIaJ7lW8dpZ06/YwH8Deoj6J44CS4RvONeKcgKXI5tzkvXhvts1ARs7m
 7zn50w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6stq54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:11:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f37c94ceeso892641685a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795515113; x=1796119913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v0+LEj/fI1GBgn+O0B4Y4CFXU25e/qj4jggK6TUMfcM=;
 b=fllhK8+KQvVWXLnxQpZwZOc5KJnWLULpkN5HGrp1Nv+mJb1EP21hj7KzkMqsL3aN+Q
 GuxU6gVxrWtV8otxs+awuxvYfCkekbWJ1m3wr7reNiFIDdLqD5M1NWMl1geWOeGbTk6n
 ItxN27smEdw1GrXD11DF7QDNW76Ut3NliyGq4foM2jH+KjSsuBeG/0wMrGNYBfyyzaeb
 fk3MQbQuFvWqeDhnn+OODhlMS0hmLKVw4pzBOop8j3zrNUk/LdNQ9veFW7MHJ+526Uky
 KxhPex2llQfg3CKQyt9121C23EMktOmOgen5a6GLl4H9FFhXciqrWqEOQv5EFMT0+bg/
 RkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515113; x=1796119913;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v0+LEj/fI1GBgn+O0B4Y4CFXU25e/qj4jggK6TUMfcM=;
 b=A5MfuYiMRYzQgObCrK69E3ys9H42k1nSgs4AOuezDfN8V2yUTSx8U6KQrXrigoWHtz
 SQJxrRYtXoAV+kKPyTpnBn0syDcC1A89+FUGhXdzzFtm+K4X6xFrtWPWHi7pIhkS75RR
 aqHvmpKbuixhnsvLM5HvRD8tGkCYd08sAyFAGmk/ZsCJsm+tJN5nkOAZeZlO6lkx3VFk
 iHaPtWESfEi7L+MoIbGiIfqbX/Od9934b05VgQxkSTjRtCFa9lgRvHUzmXLVmEQdga0t
 v0MLyFoA1sIyT9ycir8WcWsVmGFxHFyjQ8+dCc1CTpssRXye2FAVdhOPAu84aIh376Xn
 MJyA==
X-Forwarded-Encrypted: i=1;
 AL+hErH7+hhhokvvdCBEDeC7ysTixgvkQlicYMbSbVDvdv1fHPBigz4ogPydJTlkuPFxxRzfBVyEUSRaR5SV@nongnu.org
X-Gm-Message-State: APuU4Z8nJS20tOwSFk0/PmSdJif0sg0tF7rlQZKt/6qksMIJif9aE7B9
 UmbnxnK87XF8Ybz0Hm6hp+r9hRLQ+96MfnuHRiZxbNgS0H3OCPJ5RNi/scYsOemmVWZAVJA5C3D
 KpqgR5mD/cdAcfIFlM1i1vHZsnzRrq532VT/6HtNzibOcy/5OUL3n8LkUxw==
X-Gm-Gg: AZFdTZc2M0BXwEoJExjc4cjWNkgc7b2CkhSISQtKFoVvVY5qB8yjsF7Z5AxClOm9/JE
 Pm39q+t6JGk9uhdOs9lJ7e/l/5Mii0bm+F8/pD4pjWEJaPGnuC6FjAW9U6qXOYdWSY54S+Csy0i
 NwaAPPqGB1yTLDqHYRr95fyxUCzVTyOi8jYCwE1vX+quOvzs7t0+0q7Gt6Lco7YqsyHQ3oQ2GhG
 iKF1ACPaXMZUbKfLmWhHDhgrI+4nFHtWOXpBcGDmKZZh8pLQItnyuIp8bO6qeCvJAL+bpmXD998
 p1lJZSRjht8nqCSO+XulL8HoPuhqNI6autbvzj3yhWYOcBpOPYj8ysbJRuej6WJ0x/rjw8puPdF
 U0/fKbrNXD7pXgrKerHXCKR/g4PGSiSSLxSuSH+d8IETemHZ1QHI7s9ELu92ew8IkCjLSUHwdvf
 D70DFwJLw=
X-Received: by 2002:a05:620a:2585:b0:949:7058:dbcb with SMTP id
 af79cd13be357-949b35723b2mr2670006985a.14.1795515113453; 
 Tue, 24 Nov 2026 02:11:53 -0800 (PST)
X-Received: by 2002:a05:620a:2585:b0:949:7058:dbcb with SMTP id
 af79cd13be357-949b35723b2mr2670005185a.14.1795515112974; 
 Tue, 24 Nov 2026 02:11:52 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906e4ce6sm228682885e9.4.2026.11.24.02.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 02:11:52 -0800 (PST)
Message-ID: <50aa4c62-1b91-4a9d-893b-c455d9396ba4@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:11:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 1/4] hw/display/vmware_vga: Zero-initialize
 scratch space
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
 <20261124095719.4126146-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261124095719.4126146-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: etqg8POaGfWHPzwKDQqcoQxkugtiS1U7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfX/LeSfqyCJYn7
 kMA17ixLmkQIzQxRYRnU8l4S9v9E0CDMfKeBa3j3lLYyqcEuZkLNWLqky6/x6wGdhEtbEc4nL30
 GadTanWxbNoRxJDMWC9PHDwepSiedic=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfX2PzIbJKJ9hZH
 PVbqibMvZ4FsZ16Dhd/QZyCfcBCWVKaVogUqXKUftrzJ2mpuIiNq+MwZ27Z5odLSBk6UDN6nYwv
 VEha2Ko6Da5s5vdjY72PCmYwmd7ZnNvuuW0X/GXFxI5FvZiNTVO7iPhHMXzOYvazggc8F/5mZQO
 tEGOAVWoZiUp8Nv5xEytb7ZCHs+vKS04QRCW7g8a54Fw3Wh+4wVRBlCuyEuW9SGyUsawX5K/khn
 XMk60Cl//JOvDQk+kq8kEKiVwDO9JAU/dd4Fc0HkRZojxynvbAOPnWzba92Qmx/jH+LA9Lyc9BF
 kCW8Ro/eVLdzBPfca1vAbuN0mnbSzoOA+s8Bkp+0dDdkuZZOnNtccbQ1Ide4aHgQpyyppO7uSIu
 caaMnKF3jBmmcScgUrKTiM2Ea1gVZtBUpRru5y6q35dXeYh83CS7PDbd8IUfWiYn6Ffeuja2FVj
 ezDxMhCXJl34grGVGvg==
X-Proofpoint-ORIG-GUID: etqg8POaGfWHPzwKDQqcoQxkugtiS1U7
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b0562ea cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240039
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/26 10:57, Peter Maydell wrote:
> The vmware_vga device has a set of scratch registers which the guest
> can use for anything it likes; we implement these by backing them
> with a lump of memory pointed to by s->scratch. However, we allocate
> it with g_malloc(), which means they start out with uninitialized
> contents. We should zero this memory so that we don't potentially
> leak host memory contents to the guest, and so that the guest will
> always see deterministic values.
> 
> Since s->scratch has type "uint32_t *" and s->scratch_size is its
> size in 32-bit words, prefer g_new0() over g_malloc0() for this.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d34cab9f49bc3 ("VMware SVGA II emulation, by Andrzej Zaborowski.")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4519
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> 4519 reports multiple things in one bug report; of the three,
> this is the most interesting, so I put the Resolves tag here;
> the others are addressed by other patches in this series.
> ---
>   hw/display/vmware_vga.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

