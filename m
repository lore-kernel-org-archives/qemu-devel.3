Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B07606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YDLM1yDO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oo29XY9x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqT8-0007Yn-4X; Mon, 19 Oct 2026 12:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIqT7-0007YV-0y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:44:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIqT5-00031G-0r
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:44:12 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFOwEN035975
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 16:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /RL6WX+ac9h3pqtkce16DSl8cioiqHX/wpEGRucgYgw=; b=YDLM1yDO5thxR9Lq
 7XzIXBWI0fjE078pKzX1wX2pjUEE6vls1BUy2PjwApf+g375RFuKvjSSe2Bm+nef
 ImrhHXHtm/paxZs2t+sSM78bt+BjrkTHK4T50XOqDZ5Fgsy59wfwAEs5oEj6Jkj2
 6gEAUhpxx+G4d7Qu7kfNa35Re4iCLyZ0gjGAZVqpACVo1bWszqo23U17pl6jSjFX
 2v8yfq+Z9D1mV6Dya3QVasERkYB33lLQPgUbd/poU+af31L7VnEu3qBEx2xq2IZI
 L0TLG+BOIZk0OnTMAJunX8bGMXFev9QPXyXrmeV7szvhhDARSYBsEvME+b4+2qIf
 4ikLJg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47j975-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 16:44:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso3629862eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792428248; x=1793033048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/RL6WX+ac9h3pqtkce16DSl8cioiqHX/wpEGRucgYgw=;
 b=Oo29XY9x9OTo+sYWfVGj8Y8ZpkhYN3HH7u5tQDan3hLqC0ecn6iJng6WwzWpniQt04
 pmzaJQwX7sPSMlVF6MPxooCILGtN7Gbe9yApbMkVsXHfHEoWWnnQ0oZPnKZLvvsdHFgH
 tOtyjV92zHSh5f3UZyDdOO1SKStYqHvQsa28NRHUo1kBTUP+aPzV1WjvDIQWBfU/1O8/
 nFpX7QtB7tqIS/2bOD9Ul5Sc0ITCp5Wbs6c88H9LJ2PGeLWBH1aVXzQOtXQqJDQhwe+h
 iFgDO/QtCyCK25FqOPoL4SnyU1/xbDQ1ShwP5TFMNtnnF0xHAWjcSVH2Y9Fa107TTYdt
 rUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792428248; x=1793033048;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RL6WX+ac9h3pqtkce16DSl8cioiqHX/wpEGRucgYgw=;
 b=r5+UcdE3f+g2Jz/nXZGJ6/7GD2hDV74ph5qpnSrsBvs98/SCJgGS6o/PQ4gPgur33Y
 +vYTNO6VxQIJMjzQ4igX+FN/nwv2jvPWh8pF8iYYENCE95/AmdG/w80DJQPHW0jyN27b
 ZAlQWyziPyqciAwZgcB/AcOB454dFJtu57Eusrf8OrjMRrtWM2g7A1l+9GDlNcvwajyZ
 t4FBsLgcGCndgCtrJzeqaQ3aJwXnz5hJjx7zaPS3sp7nS81vphPZRhIDncZzXWVQFlt3
 MLgIiDna2GPetdYdJMp7tL0uF4RmGzY5rUOWhEY+K6Fpvzoqm9aV+iAnLGNSfCXgnj7p
 0bNA==
X-Gm-Message-State: AFq9FYKCqUkxmOBcWjyyp1NcVPgjBQg753xPxWP4F+R48d+Hqh/5/Lwc
 5bbpEjvgGPR8t4yExY8QM+Lvd5iCs9vodMe9lydDFALgtEkSxvMmq5Rq7zmw96sobW7rAbzpq3T
 7+3vV2BvTDEJjxFgscKU5sJ6QC5bT9BZOkPUj+WPNnLflgPCWF8Ol8Qj2Mg==
X-Gm-Gg: AYBFou0+Rx1gz3V4QuOtMf2sGMi2r9Lvaao9h7TN1iYytAQAx84hgIavfMvgNopPMXX
 Lk7khtx2f9dk9sZ2GMurpucU6HHJKXGhOJ9bpHvohawpN0w+hlldo6KOZT9Xfu/AfT60LFxy09Q
 9uk6647c6Ewm4H1kulBDjdrgWMUMr3VpUtl0KzjEzWHTv8Z6l5JFsF9rtNDiJzB9hCE8u365n12
 gCs2qOXr05Gx8KEwqwVySryvtvHuJd4R+jTGr5f8ZpSkhFYc5RfzcbYp24VDExj/mUJJ1EKB6ub
 5X1u1TOipTE8dO7Yxhrgwil5LGr1BhxzNBR90ZYcaP6NpwKwoPGwpKWHt4fUqhSSWFRDtKIJu8R
 N/fANh/NnwvI0+qmshPktDDrN5GeOKwvHFfXRTiCIx46ZyaQfui1fvuIKbLveqpgsR5mAuw==
X-Received: by 2002:a05:7300:d18b:b0:360:e2e6:f849 with SMTP id
 5a478bee46e88-361a2844812mr10830414eec.28.1792428247594; 
 Mon, 19 Oct 2026 09:44:07 -0700 (PDT)
X-Received: by 2002:a05:7300:d18b:b0:360:e2e6:f849 with SMTP id
 5a478bee46e88-361a2844812mr10830389eec.28.1792428247037; 
 Mon, 19 Oct 2026 09:44:07 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm56192080eec.28.2026.10.19.09.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 09:44:06 -0700 (PDT)
Message-ID: <03cf8b9e-c23b-4286-8c19-7094f7865f8a@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 09:44:04 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] tests/tcg/ppc64: Skip float_conv* tests
To: Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
 <20261019151233.230172-3-farman@linux.ibm.com>
 <9c7fb198-06eb-43ae-b945-bf789158a68b@oss.qualcomm.com>
 <1d797652-50c7-4292-9297-61b09aefbac3@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1d797652-50c7-4292-9297-61b09aefbac3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rm-5G25phFu9QjrmnGiXyjOt6fYcE2GB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfX86Q5IsjrJQT9
 vhibb5XAY/lURU2oVEY+OyajDiJQ+Pk2Ecaxel/4apVpaJBqyPmmwKEnxxfCWQpHq4VwFeKGPT6
 /hwRwtsbPjs5HlyiwVJIhsbx1JR8Gy6HxU77+yGgx91KG9IlsuvgZUzvzRz/XewhZxY4ZO/B6M0
 vpAAo2zLA5XFbB8S2iAlP9erWsO3JKw2D3Dc6TMKRIlnQoZaH34Hm/BrBSnW9NK+mJ0nGZ5QDwR
 ngWFiFSWCE5pd6EeMSm9NsmNKiMONcL3g42PThrZadlD3VWfPf/uQSai+IfVdH57Octodhw4FOE
 /uVFyPnm4I5mH37oKJiOdX7XXjryVL7s3qqepiivrE0qCwIiObFrq887s4mM515FlkUBj1Ruogo
 8ltkM61oZVSVYtDpvO+9HxFHN22zhTmil24C2hAvQCdGfYqZKBX29esGgQ1kqrKvNeOueCSC6Rh
 WKnMXP8GG7HzVfMV0Dg==
X-Proofpoint-GUID: Rm-5G25phFu9QjrmnGiXyjOt6fYcE2GB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfX9+34kZvngKjQ
 ctrv468bTJ9ZP9DxRbsjd/5+n8+CLYO+jjCZ+W/7v+tC1cDyIAOYySQPS+ZHlNkiiztFHkhgxIy
 IjTm8iDvlwLD1rEKUwx28XKQ7MRG7jE=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad648d8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VnNF1IyMAAAA:8 a=qymS1afNIhVNqmDIbC0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190066
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 9:23 AM, Eric Farman wrote:
> 
> 
> On 10/19/26 11:59 AM, Pierrick Bouvier wrote:
>> Hi Eric,
>>
>> On 10/19/2026 8:12 AM, Eric Farman wrote:
>>> There is an oddity that turns up with the float_convd and float_convs
>>> tests, when running from different toolchains. As one example, the
>>> expectation at the start of tests/tcg/ppc64/float_conv*.ref is:
>>>
>>>    ### Rounding to nearest
>>>    from double: f64(nan:0x007ff4000000000000)
>>>      to single: f32(nan:0x7fe00000) (INVALID)
>>>       to int32: -2147483648 (INVALID)
>>>       to int64: -9223372036854775808 (INVALID)
>>>      to uint32: 0 (INVALID)
>>>      to uint64: -9223372036854775808 (INVALID)
>>>
>>> But, other hosts offer a different response, e.g., this debian guest
>>> on a laptop:
>>>
>>>    ### Rounding to nearest
>>>    from double: f64(nan:0x007ff4000000000000)
>>>      to single: f32(nan:0x7fe00000) (INVALID)
>>>       to int32: -2147483648 (INVALID)
>>>       to int64: -9223372036854775808 (INVALID)
>>>      to uint32: 0 (INVALID)
>>>      to uint64: 0 (INVALID)
>>>
>>> The explanation seems to be a behavior change when compiling to
>>> different
>>> versions of power hardware. Disable this for the time being, and it can
>>> be added back in manually with the correct responses.
>>>
>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>> ---
>>>   tests/tcg/ppc64/meson.build | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
>>> index 8cca4d65a4c..ee86a75c23a 100644
>>> --- a/tests/tcg/ppc64/meson.build
>>> +++ b/tests/tcg/ppc64/meson.build
>>> @@ -13,6 +13,9 @@ foreach t: tcg_tests['multiarch-linux-user']['tests']
>>>       if fs.stem(src) == 'test-plugin-mem-access' and 'wrapper' in setup
>>>         continue
>>>       endif
>>> +    if 'float_conv' in fs.stem(src)
>>> +      continue
>>> +    endif
>>>       tests += {src: setup}
>>>     endforeach
>>>   endforeach
>>
>> could this be made deterministic by setting an explicit -march or -mcpu
>> compiler option?
> 
> That's what ends up happening in patches 3 and 4. I didn't like the idea
> of cobbling a conditional add to an existing dictionary of options
> within this multiarch loop, so thought it'd be cleaner to skip it and
> readd it outside the loop. Could squash them all together either way, of
> course.
>

Just saw that after sending this message, thanks.

For why to keep them in the loop, the reason is to keep multiarch
definition centralized. For instance, by removing and adding them, one
plugin test was unexpectedly removed. It's also just the general pattern
I enforced in all arch, so that could be nice if it could stay enforced.

Thus, I would invite you to use the following instead:

     if fs.stem(src) == 'test-plugin-mem-access' and 'wrapper' in setup
       continue
     endif
+    if fs.stem(src).contains('float_conv') and 'cflags' in setup
+      # ensure float conversion tests are deterministic
+      setup += {'cflags': setup['cflags'] + '-mcpu=power8'}
+    endif
     tests += {src: setup}
   endforeach
 endforeach

You can squash the ref files update with this change, that's good for me.

Thanks,
Pierrick

