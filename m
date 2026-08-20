Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27880C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0c5-0001Tn-D9; Thu, 20 Aug 2026 07:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0c4-0001Tc-CA
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:07:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0c2-0001jo-O1
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:07:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KAP3PK2215930
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QCKUvMEQ2eEVWbzvfpxEwa8P9uv88Yo4AANPw7XO9t4=; b=bXCwDoQltVTLCYdp
 poEuiUU3VkvKmluaAkC106WmpQpt7KUu9b1Kx6LM4o6Sz7ft/ehxiuEhM5NGRIr2
 s1rdgV7qvPsgGmycMBagdJaiBxenEPDDWPrHqza2Av9zX0ZYSrE4xqYdrf8KuW58
 tSbpYWi9TScHayZxWyYSwfl7uhpxESshzG1AkIYiPrnjM2MWGqBRLUTdvrIqK9qP
 xOSi7l4wVOU9TSR3X6/Y29VUtj5GiP3IBFjSFF6tRPKT5UY9XS0nPw8PZFo74QgY
 5V98CbXpriJQzIosTWxOE5JJl4SI5HaXQSYh2XoM9r4kwW1zVUjDO4uo1gva8ko8
 YvubLQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ytc84rr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:07:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e8004d60eso387459385a.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787224028; x=1787828828; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QCKUvMEQ2eEVWbzvfpxEwa8P9uv88Yo4AANPw7XO9t4=;
 b=fZrCaNkloiGueejlCplMIBaPox6F0/vlsWjs1BxrwcXId64Nds2AoncyjkQHr21g4h
 BWeWBzPpio1wZVYkBxXrHkaJWwb2l7dWyT3hFk4FeTL9B0lrZxsfjne8XUcOLsFb4NYE
 99BdPQPMA9hep8ZdYBfgP4mqszwFeNg2vipWyEvoazjXWX7SoSVU+rppADV6nV1XH5I8
 ZvmKa5FmMlMVFkdYk1fsCXV3XYTffivlWEfjxqEoRaX80hrdvZqnafK06eGuHlH983n/
 Fw7AKhx/f+hUqVBM5QjD8RYE+b1Rxm7UPONBf4Iu7h2XVWB5Mbbejy5VS+qj66Oze9cV
 kF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787224028; x=1787828828;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QCKUvMEQ2eEVWbzvfpxEwa8P9uv88Yo4AANPw7XO9t4=;
 b=RyLzVsywuuuBW9XN7izZGsm6hbVagbLF6ukgtQW1ssMFrV2sqK+T6V+o1nW4+WbxnP
 B4M4gPcd0mQrcTt6EZu2bv8OE/PmJlEv235VeEHoaGcXxbXaO2MNR9gGqDcYlDew0KSl
 wYIFOEFAjtiIJFpyytYQGCh1ulxpxzOIh7FSJ21mFbbD+3q3D7hZ6piRc268amQQPDOE
 Fu8oaDl6tkEdwOvXPdFaH0evSidgIEIcuR749lD9lLusHAbB5CNgGLyBgUxo10mWuC4N
 GH2LAbbMLrCmqaabGQ8FTpsmvzMhaOct1SB8R84JBxypVBAGhNCkbA6tsubKkdiWqWmg
 1R0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqGZzooJiwjcmTFb1GdhIBnBBI+9DNjUeb2dPgDNnBgWH5IBb6J63FinmTIX6+BRvG4g+Yq9R4lDIa@nongnu.org
X-Gm-Message-State: AOJu0YzCWLrMrKdAKci6OiV/odEbvLt43vBH1rwWh895NZzgKvHEl3+A
 fogN3EUo5vIqAhLFs6lKmE/WmkNmNpgcMK8DIE81aPM2HrcpkORJjJhW4ZRTaAGDYez8ASYkm9A
 u/3MtpUEUAnKGgZykffbZvBTHe4r2YmSY8bWmPYL+1YZI0M7GfGlpr6q1Cg==
X-Gm-Gg: AR+sD12/EaWx7oL8SDqhuO4M6c9lO8KF4hQlqCITHNF0cegs+tHnYUD0ThSo5lTGyMe
 LymsEwgy1dBzU+F5nsZf3GSwkzLpFJLn9XcCZHhHfaLFrHOu+FHyWnhVpWMsjNn284MnygP97lC
 DrkcAN64q4boMchJP6+ucs/uu/p2d1QqGJrAmdafIfrgHE/TEEIeYYXgr+M/8BYCbdFLuDkFP3C
 NFhu1FgmWSpYQjoqLrtgbLtRZ4ANZdj7DulG0jYNVRbYxunn72PEkMuWqredHuYFfaznIFfnZVV
 KKuGUyXmoqubQHA3pNxvasuaDpVELwxI0IWj8IX/xuZRdrh0Y3M4gQ5hNoaSR9wJjQR4e6BuNMl
 77AvcoWbsQ5SqKFP3FjlC7w9aZe++A83uytA=
X-Received: by 2002:a05:620a:2616:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-9371e31e4fcmr1179199185a.1.1787224028021; 
 Thu, 20 Aug 2026 04:07:08 -0700 (PDT)
X-Received: by 2002:a05:620a:2616:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-9371e31e4fcmr1179188385a.1.1787224027356; 
 Thu, 20 Aug 2026 04:07:07 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499ab2a8b34sm164504925e9.8.2026.08.20.04.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 04:07:06 -0700 (PDT)
Message-ID: <ce56dc4f-6042-4f80-8523-3fc2e3065451@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 13:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] hw/ide: factor out the IDENTIFY DEVICE current
 geometry words
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260820100844.411717-1-den@openvz.org>
 <20260820100844.411717-8-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260820100844.411717-8-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a86dfdc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=5VAHT5MAFjTCagGqsCEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Hx1yvPaMooE3kwe23bt7:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4MiBTYWx0ZWRfX9tlkgFSxReD/
 XDBE8j6qXIF9c54rgC2jt2lAJoZ5QVPjo1ZDRkCBYoc1t8s/6e57sD5VuIC2WyUuXQWq/1kFj3L
 13q+rqOV4w8L3V0himfNHnDP5HL+gCEMDc+Vr8M0Dju6DJDrNlP5TqFINlOTDZv42S184XlV8IW
 Ecn9mNa9D9IrA0DSfUKM7wTq2KEMpuBU7qLQhg2uFMJVdzhVU0B9W5ce/viqgsy5wY3pEW48RPu
 SKwk0cVeNNHaxaJi+9tkscPW6vWX96T3F4HJcMlsG7qqkgoMGOGzYbnQ7bhmbFf8lZc4NKwRsmG
 mv+X46wHHAQnhk4aNqGiv+75WvSuOBFZPAUalZGxp9yyC1Z9WdFN+PpmFjBk2K5Jj4zEomZfZrG
 Zsn92r8DDDhbR3R3ZZef3siyNzjdli9DjS3fd3TwuNfvKroVkncv0bYa4fpXB8hilJRGD50BYAt
 pyxCeSSc3ysqMTaU8eA==
X-Proofpoint-ORIG-GUID: XroHr4LVjVzFvz4mZXN6k01Gl-QKTXn3
X-Proofpoint-GUID: XroHr4LVjVzFvz4mZXN6k01Gl-QKTXn3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4MiBTYWx0ZWRfX7/cMmMtpi95B
 5n75gPJ0AMK2db0YKA08JTqyBJfmNlaCTLX3oScJ6/vokDi7M6gQDoyXnXQ6NxiQzHZRpn/JL1V
 ZNPQzWc+E2d2OJY2HDk8y+YoUyMH3OQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200082
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

On 20/8/26 12:08, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Words 54 to 58 of IDENTIFY DEVICE describe the CHS translation in effect
> and the capacity it addresses. Both ide_identify() and
> ide_cfata_identify() fill them the same way while building their cached
> data.
> 
> Move them into ide_identify_chs(), so that the next change can refresh
> them in place once the translation changes, the way ide_identify_size()
> does for the capacity words.
> 
> No functional change.
> 
> Cc: John Snow <jsnow@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/ide/core.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

