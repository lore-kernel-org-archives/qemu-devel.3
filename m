Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E45CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 21:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMXqW-0006DT-Q9; Mon, 11 May 2026 17:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMXqS-0006DB-1q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 17:07:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMXqQ-0002HG-1v
 for qemu-devel@nongnu.org; Mon, 11 May 2026 17:07:19 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6hac2803759
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DoKVKYpzr9rI2JcoxPSd0CLnq7U9TJToH3xLz5pICUQ=; b=Vi62pXIeTUGNjZF1
 mtM184SH1XFyYAdszR1bp+AfHKSFnNHbWrE7xBgdJbfgyUhDMPUd2M5AbqtsYNOT
 iT4OA4mMCgo2W5YSfsJWXJhcYm6AHjGwcjwNVauNSzfK8ZBRM2ZJvHAvOUdXYYIQ
 5MybfM8VmOniGri1s9JN9b7u91tW80cVhxyvVAxH5ta1CfYhyctcVNxD32y7GBde
 gvQbbUBr8a2bTwDkKv5Uy8+7jJhSvSBObOnSuTqAD67kaYbXNsI2c8wBd0jv2CaA
 z8Ey/Vckd/DnlNSpNt3/pRmyofDtjbnTES4B7qU3k/CALY8CKQ+td3mRhtKKQFyu
 sW/oQA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv3891c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:07:15 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-132c3280e03so3094869c88.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778533634; x=1779138434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DoKVKYpzr9rI2JcoxPSd0CLnq7U9TJToH3xLz5pICUQ=;
 b=K1RIoUeNjTqVJSweeaVrPwA2XnWjZ4x6uGY/HfRegq+lJeb3M/9K6qqNFz+JV7TUdY
 qp5QP4KaXpfVp/lw4zl2+PnqWOO4Nwy5Mzrw6nO8YHvX8gQahREMmHwcG9tqWAfh37he
 5thsKaaJ66e8CRm9XER5JE/diBFfa5TxIjI4cL1GIUFVPgIu+1MLKxoYX2SBGBER4IZN
 QFB4Tsy6iEzmv9ZJliysx8F/1/Q8bHTPd7m4K6borfsgj7oKTvHnRDEDYrLGaaDlf4Hx
 asGdNEXeuCrHwogDipbUSg33MIvByQSLQkxCjLIPwT7OtA0enoLIgh5Cl1fenwFonFfo
 lFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778533634; x=1779138434;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DoKVKYpzr9rI2JcoxPSd0CLnq7U9TJToH3xLz5pICUQ=;
 b=pBHY68Ur5jEXZn+2PUKvU8wgl6cHgA3l5udQ30JIpu7sNrKbkv7c9fj3D88AfioLqE
 F1oeq5nOvMc5s1kuK7B5PRZW1fgKb8V1cNK3WFJa5MicC68VoNcYYnc5vR5Jxoe+lv/Z
 nylkrGfYBOreaqhzbOxd4JGEV4EAQHC7eUfT6GTrkuyuhV5+U/ijUKAfT0XgbTapljca
 iYHmvMa14DHMFpmP+YKSs64s251p+8zbovs3um/0l440OIdGrhD0wjbqnnRUezgFwfGa
 pSmL3+1Rg2n9xZNAc+rJbe9geINWDXh6OsugGpsgskPMvRv83dUhCFrXnFoi1h3GvHzM
 vPBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gqnc7e8OL2SaPsZ/JpW8VQIAe8l2Lx3u1qHHnzsTDdTV390sHTZH9tm9FxJT+1n+fa435bum/XWeF@nongnu.org
X-Gm-Message-State: AOJu0YxUKZ5EzHs+EaA+ojhhwwrgWrWZ3pHUt5fkxKun8/APwycSguBI
 1NUHh0cb+h1fu6a4WJvxT0yMWtkHfcZEggmMjg4SnqqsGjaW4N6QGJPptf/fyNEEl5K+DoLADKu
 uhtjtqBsOj6KIkMk4eBiX64bhCxSh2H1IhGixdNaRvziW/voxpxQnochFfQ==
X-Gm-Gg: Acq92OE2fVvMtqtzFY8pcsbqprFP39TeNxeDB0VuUGHe8E9rnG6UvzzR/qNyPMI1hoC
 WAhE6KgtChJu6nx33v65cpyg0sSIBnQz5gWYkjalilmtDwKWcJatQRY7mcNuqYVc+Ay/kI9epRB
 bg82k1ma7F+M76i7l9p9yryTluHGfdWXSZxXmMe3LqXBzYFXXE9v3vtSGLFaxxLbmEzdeUZcKp4
 0psacQEDffX+BCSKnZ7MfNkPLrFiDHPFWdf2swvB+exTNEwiHWMh9iwMpNGT6sWJX1h+gIq5LhS
 PQmKya8dIXLVbyHcr1cdWwOluhlMHnxceqFebYrNcAL44eK7RyutuE9cHOub5BUwuDaje93m2zC
 hy07MF8MLN4h4T0fzktogXNo0EEIGul8dP9aCdpWYqsjX7u2IJWzWfzHdJyzg8XvnFmqhx6wzmt
 bh2cC61YMCKHBPuA==
X-Received: by 2002:a05:7022:50c:b0:12d:b8e5:5ee with SMTP id
 a92af1059eb24-132a83f6d15mr5926946c88.23.1778533634328; 
 Mon, 11 May 2026 14:07:14 -0700 (PDT)
X-Received: by 2002:a05:7022:50c:b0:12d:b8e5:5ee with SMTP id
 a92af1059eb24-132a83f6d15mr5926919c88.23.1778533633707; 
 Mon, 11 May 2026 14:07:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327821fd00sm19690335c88.8.2026.05.11.14.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 14:07:12 -0700 (PDT)
Message-ID: <5c5e992b-e093-462c-999b-47ff0e5c07ef@oss.qualcomm.com>
Date: Mon, 11 May 2026 14:07:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <a57d5120-dabf-4953-a680-a9c875ecf238@linaro.org>
 <49384318-3050-46fd-af06-4b5c0a14699b@oss.qualcomm.com>
 <dbd55bb5-392b-4a8e-b332-bc009b99014d@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dbd55bb5-392b-4a8e-b332-bc009b99014d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIyNCBTYWx0ZWRfX/NjemP1M54j5
 weSxxEF8AUwPm45D5yL6CfSKa0MYh9ZQp58Ouozc1WZ3USBoODK5IUncLhWsjSxU9JZDxfOxBf1
 ZIfHQmFWb2H2L6ynMJDL9JW69/uEIpe0emPzSlrU0f4derpmsl5bvdAD1RTVzIA1XnTF2dlpNnu
 lxYNG9lBFw8omNJL4z1dg17QuKu3jkcB3t0YgZTJi5yPo+GgxO49dPUmxT6f7tYbqvh1qmyctLr
 LjllatMw7rWic8g2jC6ugn7QkRn5t546HRsTDJQjm9RXHGAXUvuva+00oeuT97CRPiuJGSH9x27
 crm0dHTBVtXLHmctZ36V5NbMyBmrrY3FZK+bJx6aIuRJAHWHu0STPUo+Fs+kazgBXKCns0D5zlq
 X2/DSp0HjbfTjMNgSd6CUmOPKUOfS4zcGBQepx9aSIXUjEuwyBhL9lptsLx3QQihasu21uNfOnI
 O2Urr1AWO7i7Tog4w1Q==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a024503 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=3kSBSoc6NQbpz1qdjBsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2jtWJULQY22dqHN2wAEmqsHUzGOPsYrj
X-Proofpoint-GUID: 2jtWJULQY22dqHN2wAEmqsHUzGOPsYrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110224
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/11/2026 1:46 PM, Cédric Le Goater wrote:
> On 5/11/26 19:59, Pierrick Bouvier wrote:
>> On 5/11/2026 10:48 AM, Philippe Mathieu-Daudé wrote:
>>> On 11/5/26 17:48, Cédric Le Goater wrote:
>>>> Hello,
>>>>
>>>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>>>> Introduce a source set common to system / user. Start it
>>>>> with the files built in both sets: 'cpu_models_user.c'
>>>>> and 'gdbstub.c' No logical change intended.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>>>
>>>> This change introduced a regression with PCI passthrough which
>>>> stopped working. Guest kernel reports :
>>>>
>>>>     [    0.156501] zpci: PCI is not supported because CPU facilities 69
>>>> or 71 are not available
>>>>
>>>> and other devices (ap, ccw) are impacted too I think.
>>>
>>> Is it something we could test with the mainstream CI, or does this
>>> requires specific hardware?
>>>
>>
>> It could be tested with a tcg arm vm + nested VM with PCI passthrough.
> 
> Yes, adding VFIO tests to the QEMU upstream CI would be great.
> 
>> However, the problem is that you need to cross-compile QEMU in CI to
>> test current version to launch the nested VM.
> 
> Intel comes to mind first :)
>

I just mentioned Arm because I'm more familiar with what is implemented
for emulating nested virtualization, but any other arch would be welcome
of course!

> Couldn't we install the QEMU CI build artifacts into a VM matching
> the configuration in which they were built ? I assume the artifacts
> remain available for some time.
>

We could totally do that. We just need to agree on one environment, with
a list of dependencies preinstalled.
Ideally, it should be what we have in our cross containers, which are
based on debian. It would mean there is zero additional maintenance
burden. Only question is where to get the kernel, and if we should take
the one from distro, or compile our own.

I don't have the bandwith to implement this at the moment, but if anyone
has time and want more details, I would be happy to talk about it.

> We could then install them in an L1 VM with a predefined emulated
> igb device and assigned that device to an L2 VM.
> 
> I think this would also benefit the QEMU CI in other ways, as
> nested setups allow tests to run with higher privileges.
> 
>> This would imply to have a "standard" target environment (like debian
>> with X,Y,Z deps preinstalled) which CI does not have at the moment.
> 
> Why one "standard" target ? All arch are impacted, as well as various
> distro flavors.
>

I was using the word "target" for the environment it will target (i.e.
which distro), and not referring to arch. Probably a poor choice of
words, given that target already has too many meanings in QEMU :).

>> So in practice, it's hard to test it.
> 
> It is.
> 
> Thanks,
> 
> C.
> 


