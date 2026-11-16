Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC5606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UNU0Zlal;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hrjaEW8o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzcW-0003LH-EW; Mon, 16 Nov 2026 11:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSzcN-0003KL-Ih
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:31:45 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSzcL-0004Ip-MK
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:31:43 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGIecT2055784
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lboPQskACxY4qLfqt7rvseev/MINSGdPQDJPOOrlG7c=; b=UNU0Zlal1OSsM5sq
 X7FHJCoi888s2LBz+7ieopuDLunkmivnX31+8Rvfvg0kCW+RNzJiqmwTnppZRDQT
 RlLo1/l+/Uuw0XnSU+dnr8QDbzikcEOvLXoUT+fx2UfvmqEyhHQXY/kFh6WVzOmP
 WYto9S+Y21/T2TgIlRlQUve+IfOZQeEbLf7q6rLPy7TOyeTKXDJIbfQfnbbfWyH0
 ZpAe81E2Z1emP2F1+HVk3I7gBbH+2RO/Evg1OpQYiEMx/MfWdvKFJQs/BKopYQ7N
 QAWrZ3rNtVh99rmdhp8X2FprGOG0Q01yfYtUqIvTnqc0IqfckhfNvXo0F1WLdEAD
 KY7tlA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqherd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:31:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cdd769cc9deso1864023a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794846699; x=1795451499; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lboPQskACxY4qLfqt7rvseev/MINSGdPQDJPOOrlG7c=;
 b=hrjaEW8okyPH5uSLIYQuKjTK+3o4RalTKFZSwyVKnc14pkjc6fWA9Htp+VPzZfK3z8
 8TD3F1tMM95fdkaYDoikSozOUnLkPWxiUCurhcIEpBfOQARjl2B5ZJ++ldZVuR7OHbZ3
 JJpdfwr0k2pXN4DzdXvOnZvVv/kGmcDoOKoKSHfuOMJ1PK6iTFWfxySzqfNdWg6pVd0t
 6IzyyEIidJET8zkEuL96hk9G3t/SeoPWszIJCWoUIbIzvoJMTNmA4V4sA16+8SYLkKOz
 Qx2qiMYB4ubseXfP1rVfybJr+CohUCYd6N14Uttv+LRFvSQAkNOnIuThpl7wsX9CYaeu
 faIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794846699; x=1795451499;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lboPQskACxY4qLfqt7rvseev/MINSGdPQDJPOOrlG7c=;
 b=e/YBnn416tDyQPZZYF+QPjC2gqQ8YcsnmC/+qntUUMkkAifQENnF/ByZEBj53pPfmp
 GFNX8gIwWsm6ayoozvcN3mxWkLOo/q/aV0uIwJXc/tqgF5/qiAJeRVEO33ga9zuz8qK/
 Xqygw+eHuDcgou9PF7/XpckaGlRVIh+chjqdkT5q2CJBIOcs8UkkVgMRnMEm4wMe9JrW
 9idbv+8zU8gTLmPOvVfvAKAv41AZV6b9Gni7FWtPL+YBV0J0Gm7Xs/SGNQZcrT7NXrnN
 L4iBzbTSqh4J70uCgD+5vIgs2aPBdLJoIVSJI09+KxUSvlGPUqIQluFYs/R0UX5aKXaJ
 WlNA==
X-Forwarded-Encrypted: i=1;
 AL+hErGPHns6imRHSvtdbl32cuuUvcrUYLrBwQJKUwnpCs2qY8s6Aw9IOQzzgfBm19gDncMalQbBnlxHoLDT@nongnu.org
X-Gm-Message-State: APuU4Z8eLKVq94wdUBfvL6jXUWknVXai586k1wP/tevx3pZ4iHxpeJN8
 TRVKElC8eVdwFh6kzqZGsfav+G1YZWLWc95a7NjsGXQri0b4LD3nQRYZRU85LnvDBFxvNt8g5TG
 nNxSS6ZLa3E82MgV4iJPxVlL4hK7grsYNo5X62ZUVlnj4zqXAPytAA5qBSw==
X-Gm-Gg: AZFdTZdrZS9I7CfcHrHVnWfgjBS/UPx26lFiFztxmCugIxcJ9BHmKEcQe4pgBR0Hcip
 emWezDzWYkXq//sUEXHu9X0A1e/IPwc9gSXV4weMQTfnajJiHO/9REN3HR6oDkxeTVv5xukqgx3
 UPNa0kAYCFvirX1GScKN0dSmnTvxFa5TDGqoh0EQfvnxyfZoc7Pa2XZmm3XhKu4k+ECzeO2LenG
 cLk+SYejdUKVgg0aYuzdgcdR/ckbwhzo2Wd/F7IAbe0r3CjTITxJqSUEB+UbGzU/W4A2P3V6iVt
 J1bNHB7+VxQ8j3JJEY4o/JVDvJgjtqHoZBuIiksAg/a0K2CLDSn7CWr6sG42JcbWb+Oh2EXeiyU
 RrjMfA2FKTE4sZ12cf65cP3vgHGRsW04DzPGGkSiL2AHf6SQqnwV1wyJCvUVOBfaMQi1SgjzU83
 M5m2vEPRc1SREU5TELP7SQg3jJ1AgqpJvKgrU+U8jMDs0=
X-Received: by 2002:a17:903:908:b0:2e9:970c:2c9 with SMTP id
 d9443c01a7336-2ee0dc341bamr115252605ad.42.1794846698652; 
 Mon, 16 Nov 2026 08:31:38 -0800 (PST)
X-Received: by 2002:a17:903:908:b0:2e9:970c:2c9 with SMTP id
 d9443c01a7336-2ee0dc341bamr115252295ad.42.1794846698043; 
 Mon, 16 Nov 2026 08:31:38 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2efd7a583b4sm1740275ad.44.2026.11.16.08.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 08:31:37 -0800 (PST)
Message-ID: <558f35d3-5a10-4652-8af4-4a88f382ca3d@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 08:31:36 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-12.0 v2 00/12] linux-user/aarch64: Support both
 endianness at runtime
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
 <9b64d3d9-736d-4878-80d7-4caa75eee778@linaro.org>
 <CAFEAcA8La+8TqFY0yCxRsXY2Ad9MA5Uu-sVEbysExZPkUXVawg@mail.gmail.com>
 <ccfcea11-ada8-4753-a71f-f59ed1bcb067@oss.qualcomm.com>
 <CAFEAcA9FE_dTUo5s2g7DMw9-ZhbjBUOfF0RJxdT7gMwm-rYuGQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA9FE_dTUo5s2g7DMw9-ZhbjBUOfF0RJxdT7gMwm-rYuGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afb2feb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Hxx5zoP2HA8tHVih_BIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: s8B568n6BmelSHAbgSN5aUCoWawSKv1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX0EBBxiW2+R5v
 MHJsLK/L0qmCil2IzrvGJmBQClxXZG05/1n0VOyDq+yIubHZTKeeqFNbpUMUN5SuwvBmFiEGRJG
 +tzDsdAFc4frwOIz3XRdCbu8kTXkkwcXoLVZQs6ld1U6q0wWVPtOejOAzo6G4KxlzXX3cuVYIxS
 oQyYRqhqZQ1cYMjlOxG7fQT5P8qD8lI/Ws0/YVu0qifb9Gpe5OGA8fcvE2SpzimtQwZjmOnYMG8
 0R+izQSIoUn4HUbhzL/vC19OHSE4n2V6NThgu7ngIB82fYRhHODAAsy7KYGSlPHPpWAx7BPVayK
 KssC6Nx4E9wiiOQTyu45fLoYPSJm711Dr3TMATxCC9Ck2tnS2WeviQLSQQu/JZB9t0dwkbl48A5
 Uqb1CHtPipi/PnXKsHSxd2zISDBNKTMj4oX9zaLgURlqyin8rnnwpfg8XehUSevtB5ih6A7o8/m
 nz1SZ0s0B8+Mwocxv9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX9vE4cQs/Y+2R
 621/d1e/Rfm4xNZwAnkeYNosKShN/JGpdhYPXK9uRqvRd3we8rfkow6saMSZ2xYxnzS2CfD+f+b
 FFfLaItZRWNUHLX3n8zYf3IjxPiIEOw=
X-Proofpoint-GUID: s8B568n6BmelSHAbgSN5aUCoWawSKv1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160064
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/2026 2:00 AM, Peter Maydell wrote:
> On Mon, 16 Nov 2026 at 08:53, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 13/11/26 19:55, Peter Maydell wrote:
>>> As a more general question, is this something we would want
>>> for architectures where both endiannesses are relevant (e.g.
>>> mips, ppc64)? At the moment we consistently for all targets
>>> handle big vs little endian as "it's a separate target with
>>> its own executable". That's convenient because you can at
>>> compile time hardwire in things like variations in struct
>>> layout between the two. We could switch to doing that kind
>>> of thing at runtime, but what is the benefit we're aiming
>>> for by doing that?
>>
>> I did the other conversions (Microblaze, Xtensa, PPC, MIPS, SH4)
>> and wanted to test the water first where this would get more attention,
>> with the series involving less changes.
>>
>> My motivation is MIPS where we currently have 6 binaries and I'd like
>> to add binaries to cover more ABIs without having a combinatory
>> explosion and have 18 linux-user MIPS binaries. With this approach I
>> reduced the current MIPS set to 3 binaries and add 2 more, ending with
>> 5 covering more ABIs instead of currently 6.
>>
>> In order to get there I need the few core changes introduced in this
>> series, which affect all user binaries. I have the idea ARM users are
>> the first ones interested by no performance change thus is where
>> I started the benchmark to prove this approach have no impact in emulation.
>>
>> The TargetInfo structure change (one initializer LTO-protected and
>> all accessors via read-only exposed structure) is also what Richard
>> was very keen to have (page size support planned) instead of the
>> current approach.
>>
>> I'm thus returning the question as: why would we not want to do this?
> 
> Mostly because what we have today works, and the idea of "the
> target ABI is known at compile-time" is quite deeply embedded in the
> way the linux-user code is written (both in terms of ifdefs and
> also C types being defined appropriately for one specific ABI).
>

The last part is what we had for system mode, and precisely what we have
been able to eliminate while working on the single-binary.
We could keep minimal wrappers to previous binaries in case we want to
wait a few releases to completely remove them.

In this case, the benefit is that the same existing binary (without
endianness variant) will be able to run "more things".
Since we talk about user-mode, it's strictly dependent on the program
passed in parameter, and we don't need to manually specify endianness
anywhere.

For the "how to make sure it works like before?", as usual, testing, and
a small leap of faith are required.

Overall, I think it would be a nice move for user-mode.

> The idea of not having to have 18 different MIPS linux-user binaries
> is pretty tempting, though.
> 
> thanks
> -- PMM

Regards,
Pierrick

