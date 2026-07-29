Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE21C54F52
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp4MP-0007jc-Ct; Wed, 29 Jul 2026 09:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wp4MM-0007jN-Os
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 09:30:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wp4ML-0001dj-3H
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 09:30:10 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TD89HR2144073
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 13:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7o520iD6vAXproxNtG9jKUsZWRYUepljt5EPuEGeAKA=; b=GUN0U6AqcCWF/HGK
 l60jzmyBL/rFyjMYXJefukxazNhcmgMJhihRcd3LrsVpSkcGIDkHj01WLPLbOndo
 p80OAvDDgptZahZqrCnVB41RS0sFz5uCKqwb5XeqgTnJl8/VxeAcSL8c4LZvnPrB
 rg5ywA9ksEm598LoikNzxK05pqpWpZCENl4MzdLX+ugKjiMDTA9WFMV6n/2AdzHq
 h8bgHXBoZnIHBIGKvh86OebCCx7XKZJZufvChCsefFFsk293XNKLXXmFiq05k4W7
 +PcQFSoiVl8Lse6mZqeK+vAOHi69qcSUhhxYsRARn+pXc4vs3DzIpmYLH1NNy1y3
 NYhV6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3ggbud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 13:30:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so19506401cf.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785331804; x=1785936604; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7o520iD6vAXproxNtG9jKUsZWRYUepljt5EPuEGeAKA=;
 b=g2G30DR2fdmPjKKPuXGOCxqsXcv2EPaMcD+ID3Kb27aLUm1I2EcgnN3jZPIstmu1eY
 c86EbSYxInpwCyfJVnacYQajdZMIoWr8tuErCBZymykxPqAZEQ7wCTrNdDeaxUlQlyAc
 8bVx4FtuBEkWcVP/TQiRV4mFmonyAesl+ixwX7VluamYjg16UmiEYxzT8/00DKYa0ql8
 QIqgnuzFNd+09p270ZaZAtKwhZSqmWjpt9p6AdYahdn44OgKGHIP+xo8ipQEd0+Oy/XQ
 fULvff6D0Y8RH4SJ+sScXfCnpkrVKbi7VBMsQyZsOx9k2IA8Hf9srK9PPKlEPitzAXRg
 gvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785331804; x=1785936604;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7o520iD6vAXproxNtG9jKUsZWRYUepljt5EPuEGeAKA=;
 b=Jn5IdWFg3lQbE91IwWbQaj81DMoopvdIDXrNdUv0USXYPurloq90qRRn1H9iB5E+pA
 /O9MfRSn5fdIFBJhv0U9FUqlOrroD71y9NesR+O4xuclADpwtT2P3kwJM//DTQ5WxS8q
 /As7uVuqCd/+AlMpSC7nxFSXAVxI7eEKsMG0Cn3uCfeyil800QMJk9siVHlCMRinIMAC
 7dGaSkKgWA1JMc6Mqg7weUp5P9Xg4Vzd4HAWe4tc9EBLPJPo0AiWMsx7KVNV87gNd2X9
 j3h2MBEvH46A27cNaIh0AF4mMOrWkaQ6B0BmInY6d04OrUuhg9L1wERvu2wo6g7EM/gF
 RjTg==
X-Gm-Message-State: AOJu0YwWsmuHg+me5YDhnLkfCx5L5Du1b53ekBVaGzaA8vlh9VG7QGG1
 4WWO+WqHgE11ccvd5o6288WgC1ARx2cCiSILshYdsKWz3IF4djfrQ5GNno/CcgrsvdHSE5wQOzV
 SI9jxPbN/8leshAHKW4oRhQt6wkzHu0xB4opmuk6/OU3OqGpEfgA+M0WXUg==
X-Gm-Gg: AR+sD12heUKvW125kHV+t86NOSh3t7QB+JpNMpnafsMa+Z9t+NQ81O/wheCGt+sgOcx
 wtGitw+qTNz27R+AuOu1pjwvabhrjWTrpA3j3NCApj9dFA8igStUnn7ZbpnfRHK3LYMcQr6AG4E
 qDZTnZ4B83eeDgXnJD922rruLGtFWELbV8FxejGFHAfGhQFHg/Q+tbcQn6XnmWI69CHtaSMS1FJ
 4EhWkrqK6owm6urBN2uFm0i3PcNp4AOhNc0XGe2K4r4z+/ys9SMCQu4qyxCqlP6A/JRTNJJywIt
 MoZc5H2fKHBn5Iw/oiI10bAZszlPF6vVbMf8GFRnJIj8AChTMLAk1KmLGUW2128xI8NH4+2naVH
 tJa/MB5Tu2bGFqb6+GaBkQi7f9QfnnvOVq118JRP451M3L8Okrik=
X-Received: by 2002:ac8:7fcd:0:b0:51a:8835:58cb with SMTP id
 d75a77b69052e-529d71d8c6emr62138971cf.54.1785331804266; 
 Wed, 29 Jul 2026 06:30:04 -0700 (PDT)
X-Received: by 2002:ac8:7fcd:0:b0:51a:8835:58cb with SMTP id
 d75a77b69052e-529d71d8c6emr62138451cf.54.1785331803530; 
 Wed, 29 Jul 2026 06:30:03 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4976bd6da4asm44081265e9.1.2026.07.29.06.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 06:30:02 -0700 (PDT)
Message-ID: <eeac5fd9-e03e-43e6-b53b-d0bb2d9e375f@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 15:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with PyPI when working offline
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
References: <6e28a268-6ec0-4f83-8d31-76c48634c2b0@linaro.org>
 <9cf3e30b-b2fe-4507-ac57-b437dca14721@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <9cf3e30b-b2fe-4507-ac57-b437dca14721@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExMSBTYWx0ZWRfX06IjY8QmNaFs
 PwE6fT3hGCjiQ2rAeYof5Zb43wF7rE1NuAUAxRe0hZkwEv2v2x26WDlIDwKY7RIipRZaDavbnDk
 iLRrrHO67n8ilNA9H92CbIVCunaOwD2GVX6UO8r/sC9dzMp4pg8R4L2oUi3y+3C8R84JM2V9/Ix
 tSc3FpzxrOyDggg/FZS7oK/KaicXJOAsCBrd5n/9rty19t6btqfqlvwh2QavmIy2cPkmrUCh/d2
 CQEUjGkKGw5y33XmEg/U07O8Mi80NYnCg2k40y+enDYtHaO8mBMopypcS9btQBvmf4/m5ZgFubU
 bDR5rI5rJYYPQWedT6HfPvXbBMycKTDXwRfNEj8bSHBm32sSyyCGm1hTi6UjRQVV5qr8echYqqU
 o7R//MMW5o6vZgnhto/PIbo5Fe5zg5CoU+w3vSIQb58FcvQaoJ+p1Pga1/RQ4V5u+QNhklc20BM
 v9/Rvi4ycDXDhrfM7qw==
X-Proofpoint-ORIG-GUID: UGcfIVQzzUEE8CcW99BPD_36T9nLc2jM
X-Authority-Analysis: v=2.4 cv=EOw2FVZC c=1 sm=1 tr=0 ts=6a6a005d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=CckQENj0AAAA:8 a=4EhkSYhyf4amYo8IwWcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: UGcfIVQzzUEE8CcW99BPD_36T9nLc2jM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExMSBTYWx0ZWRfXwJs2DJe8s+sd
 FnMEEdbuAU/GjKkQnhiRBCpVJS4IjYIdeJtCxcQ9AmHAQaCE7vjVP2Hbcw/waVHIHATTCDU3Pra
 xirQpEFAsH9P99yRFF4qGxoPH/WutAY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290111
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

Hi Paolo,

On 13/5/26 15:36, Paolo Bonzini wrote:
> On 5/13/26 15:04, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> This is the second time I'm working offline and do a simple
>> rebase, which triggers a re-configure, and then I'm stuck because
>> PyPI tries to access the Internet and do not allow me to neither
>> build nor test:
> 
> Does it work if you configure with --disable-download?

I got this issue again today:

$ ../configure --disable-docs --enable-plugins 
--target-list=aarch64-softmmu --enable-tcg --enable-kvm
python determined to be '/usr/bin/python3'
python version: Python 3.14.4
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=1.5.0
mkvenv: checking for pycotap>=1.1.0
mkvenv: installing meson==1.11.1, pycotap==1.3.1
mkvenv: checking for qemu.qmp>=0.0.5
mkvenv: checking for setuptools>=44.1.1
mkvenv: checking for wheel>=0.34.2
mkvenv: checking for pip>=20.3.4
mkvenv: installing qemu.qmp==0.0.6
WARNING: Retrying (Retry(total=4, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
timed out. (read timeout=15)")': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=3, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
timed out. (read timeout=15)")': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=2, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
timed out. (read timeout=15)")': /simple/qemu-qmp/

Indeed using --disable-download fixed it.

Thanks,

Phil.

