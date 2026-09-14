Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2E2C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6B7u-0003J4-Jd; Mon, 14 Sep 2026 14:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6B7V-0003C2-60
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:09:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6B7R-0003l6-Lc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:09:32 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0V833588163
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rzGnJiiGGeUlNUIiwmV6VxgVqkbyCJjJaeA5G9VZec4=; b=TfHJahvkHOu+Y94t
 v4x3XLZpGGxZpVpQf8xoa69tL9fxIsoNjzSof1lNoYPI1iZvxYoEdaSq7dUYoG0T
 FTn4iCbPuNmge4qk1TptG5ng44QzZkrGikYM/yVU8+lvFmjIuCT/6VAgAEDxRS1U
 J95BrOlqBwvsNgSq0HXf3IGi/8E4ENPfYNH7lDJnzWhhrfvuXV+1ukCMpQD/zfAv
 CRL7WRORexUBlE1tNhoQsW4Gqj8RhjUib4BHzIulcVFA3H/JP2Awz79oLnooREDG
 G7KELgZwDefZRGBEmvFkYHijN7od4teYlcGjoiQbfVC1d+/Az4nipd/7h5PBbsSH
 CzG+gw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gperga173-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:09:26 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6bc8f608979so2741332eaf.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789409366; x=1790014166; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rzGnJiiGGeUlNUIiwmV6VxgVqkbyCJjJaeA5G9VZec4=;
 b=NKMaqO3LOD6fKvfdjxYRcUkATU0YTAvrwuurm9j7GcstSzzQsgMsqSPE925fIKBucx
 VjSxcP6/cxTjQOIm/DT9Jkzcws8bbhDBOGtvkNnA9yqCnnGQ6By0CS9Ql4EHA2sJ0IVg
 4EUo32T5zdZdKymSXgm2N1S319H8pxTqZMbfuGzWP1S+be/uI3F118syuKV1TBoft4Du
 kEnKkWYX5TCK/G7IG5aSXrlgZCeHmE3LYpFm3V0t6FddIBPs/QGCSkaTr4A927WP5kti
 7A+k7wzmHBMq1cTlT3GfWoR9nG5xMMrl56mk9hoLEvtNYpq6Mnh2h2oJpYrUVUobdpS0
 LCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789409366; x=1790014166;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rzGnJiiGGeUlNUIiwmV6VxgVqkbyCJjJaeA5G9VZec4=;
 b=Y9/Vunv+DJCEJbD++oSw2MxhUbj+zMVEBoGXLVyl5mXAxxdiRyt2eSUOtR4MU/pDX0
 RRic5agfN9DTvQqt2jsQGIoykHr0TSWbuijovcdwBIbg72vshQj8rg1AQU5GrI7cL4yV
 sC8SpNA+jtzUb/Dm9rqUThunLKUE8khMlUpANOdGWwfCjvZM1RjwGNsBKL9FafYbaPXs
 Qz8ZzvydpnD3tl/xxKo8UgTp3SGYaYnSXnXF+th7TRLtflUqJksrPdXsfyquD4oVnSkb
 QNuZjnOu1HuQq+tHQ0Iun2Xtsv7XaYY6byHXN4/fr7PTkaNcU4Abrx/8VV7JxuEaNFAk
 j9zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzA244f/i345pRvmxFkTwOPsvhCV8RYFkLbpKNBpWqnezWqbcpsaimIOkWcb63QGPgo7DTIhEJZsLgM@nongnu.org
X-Gm-Message-State: AFuF++lWmowP6OrqFe9Hyx+Z1pADa9APBAJ3mDEz/vaQrzQHH56hrMbF
 Gp0Tlct/tRYkGqYG0yfG2juZDrQvBTKPi5O1cKF4OOu5AwjOxbU4W7mixWUHISrid1kG18GrhlY
 GgX/VcaEO8kQWGQ+sdYJy4TnRQ75SbtFGDV+DKR/hTLBhZW/SZhreDujUDw==
X-Gm-Gg: AYBFou2WtTq+t2iWAPXQnCVOLgdR+iUiHVEYUKrxoBxAokhUyavylGMUEOFgqf5Ajij
 BwzfwMED9W5XeO96EuFfmxG7NNEXZb1TRQI2muFQxklC/se6F8ey6GDwsUN9To81bU8cu5x2IwT
 bkmVBYDjh7TYoqk7r/T62DPbWhD5ZLPHu/deeeF8Kugng6koU2kQpOqYJ7WUR0vnWXdApRMesE7
 gn4rS+wt57zsl4jcTN1jfgJKOaJH/i1lkiIHqT8iuSFPVE//U03/LR6uySS4AWV4CLE/hi8EgVu
 lqCUbgPG0s4vuG5aPG2dq5uCOMNEa0egoukrn/u5YL5VQSrkDp5KHcauS7VnUTGW5G5dWPRJ0dN
 v60tp1ODJaXWjC5RWmM6wnCJPz8sKyVxTd4SvSfr1biWe+FAtdfatxSbxz+KWNzp3uryp
X-Received: by 2002:a05:6820:615:b0:6be:4eb3:e1be with SMTP id
 006d021491bc7-6c54203f08bmr2352135eaf.39.1789409365858; 
 Mon, 14 Sep 2026 11:09:25 -0700 (PDT)
X-Received: by 2002:a05:6820:615:b0:6be:4eb3:e1be with SMTP id
 006d021491bc7-6c54203f08bmr2352101eaf.39.1789409365378; 
 Mon, 14 Sep 2026 11:09:25 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b348cbsm26918000c88.3.2026.09.14.11.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 11:09:24 -0700 (PDT)
Message-ID: <858ea3b2-689c-4110-92e2-237b7aa87fb6@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 11:09:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <871pavd8ry.fsf@draig.linaro.org>
 <1a8155b3-92f2-452c-bd0f-884c3e0bef69@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1a8155b3-92f2-452c-bd0f-884c3e0bef69@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa83856 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=pLu7OuzSpMmMR2mv7BMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: sWC26wTsmpZJuFqjMOn689oMSjKHgBOE
X-Proofpoint-ORIG-GUID: sWC26wTsmpZJuFqjMOn689oMSjKHgBOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI1OCBTYWx0ZWRfX+1PvZ2CUng4P
 kwS/Vq+UUEDej6sm/NYjOO2V34uUfdsugkn2fdI/ugxjdyjKbP+2g3ft0Lgy2WgLISW1v6BnTRF
 7tGRcr8rcyjAPJv8nSJSmfpNinJ/oVA1y8pu+NQCJX9DFb6oSvZFwIL0x1PHZ5NmK2QHHLl/hR5
 1pAVdfVmi5P/sYYO0HDPTF3cUqgc+nY+3eZHrNmVV1i0ksQpvrn67MqHQamKJxFOC2Enzos1y87
 IUIPIBM7wsiktezL5ey5NdpyYGLg7xKevc8bl82rQxTlss0V4ZjxRsiyj6UXGUX68YEGY6DxIDz
 rG4gNlb8FV98tV9Zt1plVZxa5VlaKLHCmg6f4KFDF9bwthzQfuOOP9fOj8GcUovdSmJqPOIgIy1
 q/P3luJ0OtcXJMF3gTk0bppYvazJBqMBs+lWzXdIc57+5I6G18SGZZUfVOnl0qRw1rHqx4VTUSG
 FPSIP2cguJk/RFmnFoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI1OCBTYWx0ZWRfX+ODwDsmH83Ig
 /2ARc5RVE/mWufjmClcvIh1gRzbZE2XWTMGrLJTgFC5A+3bc5jAlTwpgso7dwmjzqulomaLCHqo
 B9ggPue0KBLokB8fH9f87LhN44gmeHI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140258
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/14/2026 11:04 AM, Pierrick Bouvier wrote:
> On 9/14/2026 10:48 AM, Alex Bennée wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> On Mon, Sep 14, 2026 at 6:13 PM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>> There might be some confusion with what the series introduced. To make
>>>> it clear, it does not touch, nor use tests/docker/Makefile.include.
>>>>
>>>> Each tests/tcg/arch declares which container it depends on, and we have
>>>> tests/tcg/meson.build that automatically builds it if needed for tests.
>>>> Reverting that will not be very easy to be honest, as it's a core part
>>>> of the new logic.
>>>
>>> If it is core, why is it patches 102...105?
>>>
>>>>  > IMHO it would be nice to replace tests/docker/Makefile.include with
>>>>> a meson.build too. Yes, that would make it rely on a configured
>>>>> build tree, but IMHO that's an acceptable tradeoff to get more
>>>>> stuff into meson natively.
>>>>
>>>> That's easy, and would allow us to get rid of
>>>> tests/docker/Makefile.include completely, by adding matching targets
>>>> make container-image-debian-*. Also, we can have a top target
>>>> 'container-images'. With this, people can build them with ninja or make.
>>>>
>>>> As Daniel mentioned, the trade off is to run configure first, and I feel
>>>> it's quite acceptable. What do you think Paolo?
>>>
>>> The problem is that right now firmware builds are broken, because all
>>> the supporting code in configure was removed. I'll review anything
>>> that fixes it, even moving firmware builds to meson custom_targets
>>> even though it seems quite intrusive.
>>
>> I've reverted those three patches - so leaving the TCG tests still to
>> run using meson but still generating tests/tcg/$TARGET/config-target.mak
>> for the benefit of the firmware builds (and also vdso build which uses
>> the same stuff).
>>
> 
> If vdso rely on this, we need to keep .mak files for now. They
> definitely would deserve to be buildable using meson though.
>

For vdso, we could simply build them as part of tests/tcg and tcg-tests
target, without having tests associated. This way they are always built,
and people can update them by simply copying them if needed.

For firmwares, if we move pc-bios/{vof, optionroms, s390x-ccw} to roms/,
this solves the problem also.

> With the revert, we can still keep the meson options to keep existing
> functionality, especially cross cflags. I think it's safe to not
> reintroduce any container mechanic as people building vdso/firmwares can
> have cross compilers installed.
> 
> So the partial revert is just for 102 mostly, with additional tweaks to
> collect cflags from 101.
> 
>> However I need to test the firmware builds and its not quite clear how
>> to kick that off. I did try:
>>
>>   cd pc-bios/s390-ccw
>>   make
>>
>> but that works even with the current state of the tree.
>>
>> Where is the firmware build documented so I can test the patches before
>> I post v2 to the list?
>>
> 
> With those commands I can reproduce the issue Eric reported.
> Maybe try with a fresh qemu repository (clone without submodules)?
> 
>>>
>>> Paolo
>>
> 


