Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85389C88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x696A-0002dE-7A; Mon, 14 Sep 2026 12:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6965-0002ak-DX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:59:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6962-0004Ms-Ci
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:59:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0TFI510948
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OEVU+s/ANi0pfiDYyw6mCYFSEMHOGygt4XdxroZO6Qc=; b=jJfxJHZlvQMmVBWh
 +/bo8A/a6ZG42vM4u4BLLMXNwSDGpanWtQB7B48jrHz7ioz1yH5/yi2Gm1d4oIz1
 6p0xq1H3L4Cbw7QcfnH6BU/bAkx/eOYEVoqgRECgl3QDV8SsIchcqml/HngA06+O
 WhheK3Qo9mN8IcDGSYDHt+RSSG4JTCozoiCHl2um6ALgHtM+guHp6lEPqANn1LyY
 OU6QnC/+2j3qT4IIfCXS/uyy95btPHu9tXp9QCRStEtlnE8wmYUBmk+ridkxBl9Y
 En/FUL6Tb6nI/HYyns/a1hK5K35VkDD6P3uPxAWdiVERFhQRvsPsdrRtldHvtPoh
 Ft/xkg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvtgw0v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:59:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381250979d5so3855101a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789401591; x=1790006391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OEVU+s/ANi0pfiDYyw6mCYFSEMHOGygt4XdxroZO6Qc=;
 b=GaQ29fuz9fdHwmELpKrybb8M8wZO+r8uElb3Q5y6YK4mFmE4wFspPuQnuSS+YSQrXC
 /z9fk1rzsJD+ea9xGxZsqy2WjxZ2tOJYunzyRfhJVo6AyXOTXlng0T1egBjjGPVt2m1B
 3HMEOHXr0hZfokaSvPZ/BCrr3rWId62jYZrQZW31em7/qgGcKB0LXh7kPylqy4ITl1qY
 NL3Jc9t4SE36BENhQv6NXr602zFveFsPb81qLCfsoGFvroNHR/YvBGhxyryj2nyG+GzD
 zN7HOzHmWGr7V5B8yIqVvYWG+D6f/244DidfiJtMcuAWvryXcddjjKJxu0vx7QUrQLvp
 Qs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401591; x=1790006391;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OEVU+s/ANi0pfiDYyw6mCYFSEMHOGygt4XdxroZO6Qc=;
 b=dTLL0MOhwLRxOJzv0PzHuU9PYAw697vKiS/gvHWjM6PDpAfmcx3bkAd1VRafGeyS1/
 P6p1WkbaXnDlJQNd1h+XoFcZq5c5QhWad6wXYhW24T7newQjuvjBdyvUQJ11rEOpFU6+
 u4QHEHN6n2AzwyHrY+0t9B9qwBp3oOvNjmPu8kRlBQYcIgMTK0CBfJS0dSTey+z24+H7
 +oKrz5KZ89xFa6rzcQXu4KBTRjLxZ//CYJyti31NWISa+K0yJZH8lWLrNe+AWPEYPrzW
 fApYVpeKfqPA6kf89SsFXg6Eh3ud519Pq13VdQ/gTqRjIrg8/1RiP9MVy0QLTf4ha6pw
 iEjw==
X-Gm-Message-State: AFuF++kXszMWW7F+eRNZtTnpa5F/xZGdFGOwkLnwlRw3IfCzw+II/J6N
 E5mI7vbJ07GiSzgy18VLGms/j22S7L+V7CKejPxfYIeX8RwJP2q8Km8KX79SS6sfZgPHTzk2rzo
 ZgAoY6GoJi8gCzU3joQAlAbjXCn4YMGZY8n2kvWICrADfTsD2xJmPs4eGPg==
X-Gm-Gg: AYBFou0pkVMhFznp526X4j6kMc3XN6lDr4QGSDU51/0fBj/AwMTXHdfyjLrCW8ENT3z
 bB7ZGArPOOC2xew32Gm9JKweyNNLTkMoccO+4OpLDT24ZGj8pJbmOQk1JHwOPuJhmAnalI88/Ge
 DbB1kVtzZm9YYd+9gsHoXZd517cz6vQ3r9wx6H8Chncic3rWY1VvEX5EQh5lT8bPKoiBGDERsZ3
 ZMtRhFheHh6+JgIqra72U0HtvnkIw2Bwq5bztZCeAz5dHL5E72N1RMujO9/oY+jsT3xAlknjbvc
 IiL5W6KSXp0q05j4hMabXdVkfVV0xfYLoiuLbIRGh2Bx8u351m+La4D2FhmaPVb06GwLXWu2200
 5VGmX8CuRtpgd5ltRtHOXqGDPLAuEa9kxZ8fqE6cw8T8pAVFoB0U/VJd5K4DwYbnUNGcM
X-Received: by 2002:a17:90b:4a47:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-39debf89013mr6584127a91.3.1789401590945; 
 Mon, 14 Sep 2026 08:59:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4a47:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-39debf89013mr6584057a91.3.1789401590507; 
 Mon, 14 Sep 2026 08:59:50 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b78d59sm24351415c88.8.2026.09.14.08.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 08:59:49 -0700 (PDT)
Message-ID: <7384499a-9162-4413-b9ed-0195ef21b109@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 08:59:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] tests/tcg: use --add-current-user when building
 containers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-5-alex.bennee@linaro.org>
 <78b4bda8-02cc-40b3-b9aa-137069a54811@oss.qualcomm.com>
 <87wlso1ede.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87wlso1ede.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa819f8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=10l49cbnMznCkJnTuZEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyOSBTYWx0ZWRfX5H8D6FAzM83I
 pGyEojmrQuem1LupYo/tW6CeuizjsHBr2ARqLUZh85FsfKhSWVxPltwsa2X1Kuf2GbYdcny+fVP
 mYotz/Zsf60yfBtJtJtHzDewf91JCxMbDkqJ7PCUJdr7RsDq/K4Q7eKz0W5mmgxdKF+SwBCd7lp
 Kx7WbpY7UOrHoNcsP1HS4/cwKxA/LpeKU7q1mDQ9UbyRZ6eUr6b/2ygxrCb5t/4DH+dj40aomSa
 BTRjMfGgIeA16YzQjIPDjX1exoofSlFbEqNpi7e6/6yHoLlpB7P0v2r/BTzMA+w7LKuzmvKJt7E
 TB7SqQAOwV7AqoB8SqniXMxIDX8IF43w6ENX7Nr8B+mIGpgDFyCi9f6xWvNuHM1IyYz3qotHzA6
 mJHWpY67RMkmI0Qyzu2l0c8iR/EObr8wP+Y9BZSlfVXc0wijtTyeOagq96EqLa2VD6zRmA7ptaj
 x7JT4U9ozMedT6p45QQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyOSBTYWx0ZWRfX7kSCHO0XRmj0
 2N43ndkTkwtUj57FyrdTY0R8sPkAE+fAeZWCWSNufGQuo/cGv3UXkO04hdYNvpYPlDfrUSD0whT
 4XAzFWWayQYmskmeFeTSHMHDdfVX3x8=
X-Proofpoint-ORIG-GUID: k1_qeGlpZOI964nTAbqrMM30AX1dy9Sg
X-Proofpoint-GUID: k1_qeGlpZOI964nTAbqrMM30AX1dy9Sg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140229
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/14/2026 12:27 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 9/10/26 11:14 AM, Alex Bennée wrote:
>>> As the meson tcg build routes the container builds through docker.py
>>> we can also clean up its hack which involved appending a RUN line to
>>> the dockerfile. All the dockerfiles that care will work with the
>>> --build-arg.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>   tests/docker/docker.py | 13 ++++++-------
>>>   tests/tcg/meson.build  |  3 ++-
>>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>
>> I'm not sure why this was added in the first place.
>> Technically, running the container with a specific uid (whether or not
>> a user is declared for it) is enough. The only errors you can have is
>> if some specific commands ran expect to check if user exist on the
>> machine, like sudo for instance.
>> For our need (cross compilation), it's not needed, as a compiler will
>> never check who is $USER. Files written will still have the correct
>> uid on host fs anyway.
> 
> That's why you do the mapping. Before I was seeing a whole bunch of the
> test files with a random group ownership.
>

I was talking about the adduser part in the container themselves.
Mapping users with container run -u is needed, but having a matching
user is not strictly needed.

>>
>> Do you have more info on this?
>>
>> Regards,
>> Pierrick
> 


