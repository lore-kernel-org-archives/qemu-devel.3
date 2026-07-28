Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7CBC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woczF-00080d-0B; Tue, 28 Jul 2026 04:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woczB-0007tO-U0
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:16:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocz9-0006nx-Pw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:16:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82KF32317993
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gzk2lrzrqZX7SqvM/G2m3AldXsI5eEndZqc05GUO1lc=; b=J9oeDD1vEfuLnuhF
 exMm6K/Fz5Bb4qaCAo9D0t9uclYrBTqOOIcZtyL2LEv1p1zKVTK1NCb0uXFdlCsQ
 7ifcrU1Z1l17gP0KyZy20Fg6j9p3opkoBSIZkbQuEennsqxBUs3+aaSeaOkeP4RK
 kSStCU5nQrkj9rdRC7ugk+ejWxKeLAvUS9tLU5j87DVg4HRf2cmbXdGpA9Zkeg2b
 Iokyv06Im8LDTUx3okOP3RMUMthvPiTG8BvwACsxiLER7+BF3JMkXQiH2FMMe6om
 wSrSZSt4ZCsmA8YSdDabdy8XQPDkD9hwePC/3F+YwxRthgLT81n8fxVKYf/xs0YW
 pZC3ag==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkkr0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:16:20 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso44963916d6.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785226580; x=1785831380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gzk2lrzrqZX7SqvM/G2m3AldXsI5eEndZqc05GUO1lc=;
 b=UeA5hbMruoMqDPidrkweubO1h5/UiTRl+FR7Z4jvCKuP8YlJ/XRAijTFTXiMLEA1/h
 yWHHeH3GrFftcf+4mF+7glYaQHDAz9UzY1zva1TRZk/I8SGcRdJmvQOeLO/iwH9t0wnT
 cqjbEr2khbeIXLUpinCcdhKcZh49Seso1UTMkmAr2dtoa7H+x/F0F9EzytgHNdgmTAbp
 0iQDntNNphqx67zIPr89r6vUoU3Zylz+oo7H+Y6uH6KDGBLUUjLEII6CtPvTz0MKgkWS
 4zmGJ+E6/Wtik08ORhyiceHDXC+OtdAHj0tOKpNyzN/FeWAU+lyBGH3S/88nMeSsFgfv
 D1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785226580; x=1785831380;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Gzk2lrzrqZX7SqvM/G2m3AldXsI5eEndZqc05GUO1lc=;
 b=ALUWhXD9lbUu8oiNFfRYiQUMoCu1Ur3y958a2xeLwA2tRfhcdNc+4SvcjP5kkdKYT9
 spD6ochJvUG2SbLASABe6wJ+W6mbmn7uGaefp//DPVWXtsHpXaZt2E7puZLMFsPICbil
 Kx+dvON685xPD3su2G66V95+rAE9gMALc7eQ91LOGBwoSgIfp90pVmdhjbFgPoiEx6kw
 M0D88Buz1hz/Px4YgNoUKA7bGRsu/1ZIxMYLajU+762mXln77D6N0QPkr+2Q/DFLpncm
 toYJqCEJa+NFf/sb5uoEvjMNF9ywoGnpJBI5WypbtsNfmod48tIXd8lId4EK2dvoQl+v
 aFOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQywYyN1OEq6tj2arV72UYQzj9QSGqjgSr7eqpzk0Im04dKxwp20g8gvWELpUOExFnwIkQpuFmup+c@nongnu.org
X-Gm-Message-State: AOJu0YwoxMICZbiBalCdcbNjJb9tvNNmOGazBKv7Ck4rDFdDiHlvr+4U
 AIWIGwdez5HVv+DDQJj9/lHZQt2jp+BOIMhVifYmyvtowbAUaaVgzRqetzNO3JxIQN81qMg2Uci
 bYOoojH+DnvqxIam4lNYnROPSIUFpTn1p50uZg2t7aJt0HSVxBEEivtHC9w==
X-Gm-Gg: AR+sD10wv/3SnISlYqySdPMnn/HmwlRHjwAdR0BCJsx9o7YZ5GZ2XkroCXfSMCXPj1V
 OHkJx2UpU4dfegX0KEBBtw9toGWdqQooBfPzZNtFHhpCthJCR98cMhqbRzqqT1Wo35h3rC5ca4N
 R97/aldiBZaYwFmniSo0iFLhvOuL6mRVeT5N6uRTTIprIgleoFtxLAQTIXtbBy46BqvfPgnXzqt
 zTRfHSsB/bsF+PD5lJfOB9lDsqTpaFdlUbNDhPb963T6wydxnLVv9/zS9hXor2/Cg8sEcxTa5do
 2ofLyCiBxUPjq9KO94jYoxwn81HPgXUrrE93/nByW7dgAwCUBGOgG+5pWO+RSRI6Hq+Z+6BsST5
 KZMvJM6ufquVkBIj6Y8VylCyKuZVrxLzg/CJXqPDs4l88Br8tOPU=
X-Received: by 2002:a05:622a:2a0f:b0:51c:439c:babb with SMTP id
 d75a77b69052e-529d7102cc0mr9750461cf.47.1785226580043; 
 Tue, 28 Jul 2026 01:16:20 -0700 (PDT)
X-Received: by 2002:a05:622a:2a0f:b0:51c:439c:babb with SMTP id
 d75a77b69052e-529d7102cc0mr9750311cf.47.1785226579626; 
 Tue, 28 Jul 2026 01:16:19 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957e334f63sm233566595e9.1.2026.07.28.01.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:16:18 -0700 (PDT)
Message-ID: <877501e4-91c9-4272-a004-23b6ba9bf30e@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/sparc: set reg window data structures currently
 after vmstate load
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org,
 atar4qemu@gmail.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20260725123411.993099-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260725123411.993099-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: W2LHVGeVDXpiXAP-0gCQQ7_-tq3MoL95
X-Proofpoint-GUID: W2LHVGeVDXpiXAP-0gCQQ7_-tq3MoL95
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a686555 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=69wJf7TsAAAA:8 a=pcZqCyVeAAAA:8 a=TKYMeimfTSsNrNSE2JcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfXwXvqjQoj6lBQ
 kc6RiyhsHpteew9elruiQD0P9EunyeOC3c1ArX3H9aTp2lGt9ooAcdGPC1vW852Sqh3X6zuyJYn
 lPyx8R9dlfcb9Xf56QUAdoiEYVhHnS5YWtFhiCceCwYTeQtfgiqpFugJi8vC98uJCZYwpEBENg2
 1IskfBLviPv+d7JRkNGbECigF0UaleVwpbCi06MJcBHYRsM/Mk8CDq6j2SCdFoFszWTv7sJCHdA
 S4qqkehe0nOsLmeiu9ohhktPcs/NLu5kE32BQuX9LFZOADgofZ4puzP097ipESNPN//bstG0G2C
 /ogBGyVxusZO9llU2iQKOd2wZkNJVnkVxJw9xzkWi0cTBCdBQJGZHhDJplnnudJLlmi3DVdAZcu
 tzi2Mj74dq4gNqvIqAVqYeqX3oRyNlEmywWNlRZSt2M++tl3FzYbmiLfsSUkFUIOF+nLMXwnVai
 MWTHc/NBSbNP1xd1YnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX66++TCyIblKg
 LRO4ftF4GzrRB77ixmtRxyrsUopBNNVq4GDFJ8PpY9W8FUn0bf/fjc4KEB4Bu+pvje2qhfTAc9c
 vLP1CFLdnSOvvmP79aTU1o0gQjcWgDI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280069
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

On 25/7/26 14:33, Mark Cave-Ayland wrote:
> In the SPARC CPU state, env->regwptr points into the env->regbase
> array at wherever the architectural CWP (current window pointer) says
> we are in the register windows.  We don't migrate this directly,
> since it's a host pointer, so we must ensure it is set up again
> after migration load.
> 
> We also have to deal with a special case when CWP is (nwindows - 1).
> In this case, while running we keep the "in" register data for this
> window in a temporary location at the end of the regbase[] array, so
> that generated code doesn't have to special case this "wrap around"
> case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
> wrapped data from its temporary location into the architectural
> location in window 0's "out" registers.  We then migrate only
> (nwindows * 16) entries in the regbase[] array.  So on the
> destination we need to copy the "in" register data back to its
> temporary location again.
> 
> For 32-bit SPARC we get this right, because the CWP is in the PSR.
> The get_psr() function does:
>       env->cwp = 0;
>       cpu_put_psr_raw(env, val);
> which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
> sets up both regwptr and the wrapped-register data.
> 
> However, for 64-bit SPARC the CWP is not in the PSR, and
> cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
> register state in a corrupted state, and the guest will likely crash
> on the destination if it didn't happen to be executing with CWP == 0.
> 
> Fix this by adding a custom vmstate_cwp VMStateInfo with corresponding
> get_cwp() and put_cwp() helpers which does the same for the 64-bit
> case.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/sparc/machine.c | 40 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)

Queued via hw-misc, thanks!

