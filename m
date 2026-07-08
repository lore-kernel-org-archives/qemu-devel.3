Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3310C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTGH-0002D2-TX; Wed, 08 Jul 2026 10:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whTG9-0002Ck-C6
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:28:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whTG7-0006cF-GG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:28:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C3slW2751527
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 14:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZnXvxy38KZm3qC4yObYqoVsMaWqPw4jKW3wRWCWZmbM=; b=k0jKxRlv3zjHEpW4
 eqGYmYP0jOZ52LKrre5NdBKBx0NtgWSDW4NOXzZSD3Bos3Ih8OfdoRHHJZjWT2ei
 QV9zzCiNKVVq31Azo7RV180RH/Zj6yYUK6nR9/VIeD9LZjrhdUcrNJIlsR02+kL8
 pCX/prxOzOoF2mLNLhriY1oWTc66/aoaNx7nPUE2wZRnBC+e6Fjg39bc+43mwRtt
 zqsJZWIKZ/cdZdiOhjTN5VKK1HY7r4qCplZq3h65ma7qXeevSzv/2YFX/81nqQeF
 kbSZBCU/GXa0sL8BY3Nl03h+Ckt9HwJBo9hgDiMcrHOxriQqwNeh8asBcpLGqp32
 Iy1a9Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9csstvna-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 14:28:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ec45d9628aso17722426d6.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783520896; x=1784125696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZnXvxy38KZm3qC4yObYqoVsMaWqPw4jKW3wRWCWZmbM=;
 b=WDtTo2CRKykIrvyOtwiW0bIeoh5SNLQRFLaTQ3w7ugTb6XYAr736llT/Rcg1Oyssla
 nAM1SY9/JiVS/KKFDtlF0/5mQmMMGnZ4nf+dpSMg2NisXkZEav/AqJjf6q3rzbIrvPEj
 MwrGzPm4aK49JEYIy8AD8g1jZ5LQGGlZRIPbZxw1tF21atsb0b5sl3EnUzGjdv0pG0FV
 3NuSBISke9CGnoVS0CoQMkF6wdaLauO7HoywEDy06ht3lYRBaf8+sjbIGETDmLqG3lDo
 YOanQHb9/7snWyc9aELNHlt6kx4n0v9EVUhcXxnzRp0+vLtgQD74dyTt1wk9DIlRPj4t
 aIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783520896; x=1784125696;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZnXvxy38KZm3qC4yObYqoVsMaWqPw4jKW3wRWCWZmbM=;
 b=FVW4xfzMdKnnMJx+tsMx84m+AD52FYWzCmIiyn6TBN2uRDaids2tVx8Jb+TjGgDejJ
 MRNNXaFiKmXcnLv7Z7ni7UESGKEktTGZCyafZwg4jHPfMmidCALS7HLlVtdQZteguGRx
 bD4oBd2AFASyU6Gfst+pT6996YOWMBsuN2NV7mvURytrc/Y7zObU/AulvFNoN5ZK7T1T
 7j7bmFqtZntdvmORMYibqNs2eId1cwqsCeii8wPaMDHLb+AmyOX7aSZD7eToXl1gwoJY
 Y4rTcJugPZ3MqVs5603yJvoyS55PJYk8lL3224tDMBMMo3r0P7pBi3cMrcTA0lUJ9lQb
 +d8A==
X-Gm-Message-State: AOJu0Yz0GMWWo9mG4aKB3kpnltUh8pE9368IrNN3q2EUEL10OrkSur6h
 9B7dLxpd2CYYaJgAgTJLwCfi77TB3k0QZ0VJW/GnqkQqMsw71/RZSiy33UwshlVOV9YUFUp8+h/
 un4CKgDopKLue8/2gDC9IDH0rOmgTtr/5JlyCZ6E0aTwaA8N/WCke6DWLCQ==
X-Gm-Gg: AfdE7cnt1afsWgRgqcjjAlaxd1xuFGrm+8lfNxXV+cxmTcNRr5w8U1kj3xoKGwBtjnx
 /6aK+volCGMH+2p/luQoSdwP1HcW4k5oKMtT+3Zz87ovD/DJVNgekZ7ihdR3oZHjD5k93/y3b2x
 fpjF4Ug2SK4XN9JtpbDtL3yKuAUA/HtoNCLcF0AOaTncJR8emRJYE0sLd5g4Ur3Zt3X17/lFGtj
 KoNsug6I1E6BjhLkaWg/basDu0QLEgF0cBF+hfE2iMK/JHJdp+X7ZF3JHP/ZXVgBHWuLSzHF0BQ
 vATNORCPU/3hlsx1+jAv6z1V4VXlFqnbB02xGDtkIfkaQxiX6MtiOLbkIH7EvVwB7rNkE0RAcFM
 apekPwP2/s8Zjjmz1W/+3dH0JNhKWE6nVwSi4ow/0l+0XO05YAfZoUff8nRcibQ==
X-Received: by 2002:a05:622a:180e:b0:50f:b732:2025 with SMTP id
 d75a77b69052e-51c8b48ec74mr29467221cf.53.1783520896536; 
 Wed, 08 Jul 2026 07:28:16 -0700 (PDT)
X-Received: by 2002:a05:622a:180e:b0:50f:b732:2025 with SMTP id
 d75a77b69052e-51c8b48ec74mr29466751cf.53.1783520896023; 
 Wed, 08 Jul 2026 07:28:16 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19ce4588sm8281607a12.7.2026.07.08.07.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 07:28:14 -0700 (PDT)
Message-ID: <03e7ce1f-f25c-4e83-be4b-042b1100c104@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 16:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/docker/dockerfiles/ubuntu2404.docker: add
 missing apt update
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 richard.henderson@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
 <ak4H9Tn-t5rRH3oJ@redhat.com>
 <24403961-c7e6-4ab9-9d1e-719caa2f959b@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <24403961-c7e6-4ab9-9d1e-719caa2f959b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e5e81 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=n6MYwUk4AAAA:8 a=EUspDBNiAAAA:8 a=XHTB-dBBH7pzA6XnzDoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MSBTYWx0ZWRfX8ajpcX1JskpH
 xplylzKWOxMNTMbsJsawQsrLfpqRXHU+uKSg/m3f994Z7+XuRfsSOoW0HgOtHyNlZxBycG74ZSZ
 kFtFewNf+quHpYgYLNXIQxeOptS1GlGCzzqhZRypqhzdtI7tePpk2J3GwjQgFAOt5quirkBhQdI
 ajRYRBcNp2SbB/5Rr42kiJXuLn07u3pk3IIXdYN+tM2Mw2iMgGyEqjVyQVfq3NewZCDGxmKK/BB
 kNNTeJvYTqk3JC8mGp1uRqeyIxZlXEwRjXTOiA3AnHj9lQXYn+iOuh0GHHaHbkceOOulaK2vrMr
 6iTIkkOd7CpcodHMQO+QOHshKKbTolkM7TIDMj+3Bs6o/eGeo8YqYKnF+rDfJl5BMfj7M7GJMG8
 0t59d0Q98EwOe6YhWZWkY18cIQf9i+WcjJ6j4mns9taHSLe+UJJta7PTOpUJr8pqKzamhOwmwig
 AJ2M+4PLjQ9jV/fYOqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MSBTYWx0ZWRfX1krbhok9UUfY
 NA2zmfBEs5NyRRuf4FrjKs4RGsdGfoOcdbOjq4LnK49I/vDc+RfTCsjsQn0JorR1T0EuvbUVvzD
 6KMy6ksNWe/BtGzwM9HgXi2FSztp4Cc=
X-Proofpoint-GUID: 693J-W4xEaQp89UbW55AnmdpTomf6rYn
X-Proofpoint-ORIG-GUID: 693J-W4xEaQp89UbW55AnmdpTomf6rYn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080141
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

On 8/7/26 11:27, Michael Tokarev wrote:
> On 08.07.2026 11:19, Daniel P. Berrangé wrote:
>> On Tue, Jul 07, 2026 at 02:46:53PM -0700, Pierrick Bouvier wrote:
>>> RUN statements should always use apt update && apt install together:
>>> https://docs.docker.com/build/building/best-practices/#apt-get
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>   tests/docker/dockerfiles/ubuntu2404.docker | 3 ++-
>>>   tests/lcitool/refresh                      | 3 ++-
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/ 
>>> docker/dockerfiles/ubuntu2404.docker
>>> index 26bc2dd94f4..27992e34fd9 100644
>>> --- a/tests/docker/dockerfiles/ubuntu2404.docker
>>> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
>>> @@ -160,7 +160,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
>>>   ENV RUSTDOC=/usr/bin/rustdoc-1.83
>>>   ENV CARGO_HOME=/usr/local/cargo
>>>   ENV PATH=$CARGO_HOME/bin:$PATH
>>> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>>> +RUN apt update && \
>>> +  DEBIAN_FRONTEND=noninteractive eatmydata \
>>>     apt install -y --no-install-recommends cargo
>>>   RUN cargo install --locked bindgen-cli
>>>   # As a final step configure the user (if env is defined)
>>> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
>>> index 1fdd37440c9..bbbc6d3c46a 100755
>>> --- a/tests/lcitool/refresh
>>> +++ b/tests/lcitool/refresh
>>> @@ -157,7 +157,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
>>>   ENV RUSTDOC=/usr/bin/rustdoc-1.83
>>>   ENV CARGO_HOME=/usr/local/cargo
>>>   ENV PATH=$CARGO_HOME/bin:$PATH
>>> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>>> +RUN apt update && \
>>> +  DEBIAN_FRONTEND=noninteractive eatmydata \
>>>     apt install -y --no-install-recommends cargo
>>>   RUN cargo install --locked bindgen-cli
>>
>> So lcitool already ran 'apt update' earlier, but if we're trying to
>> avoid caching issues, I guess running it again is needed. Should we
> 
> No, running it again should not be needed.  Unless we change
> /etc/apt/sources.list.

The problem we want to address is wrt remote content going out of
sync; we need to run 'apt update' previous to any 'apt' call which
use the remote.

> 
>> also run 'apt dist-upgrade' though, as already installed content in
>> the cached layer can be outdated.
> 
> Um. Or maybe when we add more layers which contains outdated cache?
> 
> Apt has just one cache - /var/lib/apt/lists/ - of the packages which
> are available online.  This cache needs to be kept up to date for
> installation from network to work.  It is not, in any way, related to
> the installed software - apt knows which packages are installed without
> the cache, it always looks at the current dpkg database for that.
> 
> Thanks,
> 
> /mjt
> 
> 
>> With regards,
>> Daniel
> 
> 


