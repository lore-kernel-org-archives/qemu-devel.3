Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3471CC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AOQ-00088W-KA; Thu, 03 Sep 2026 12:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2AOI-000882-Vx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:34:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2AOC-0001hS-M2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:34:14 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3dTs820122
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 16:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NCdvqWnMc2h2lRO9AwzxPxFIyZo3LEXJtCsowCTD4sA=; b=Y5uFthyinNMA72sL
 djfYv33frSABcvC2rA0jPMD2892sAVchAnzuDJ3uv9r1oVdhn5wzPRN5fNumghYC
 xNVD/txsXKIxIUi+MEuDJtOO2+/WqVFlzZvAUBtiER/oYJMLWZukJO3sbNN90Hn9
 XvUrU3OVA+K2OlUnD9Fc2/OhtbGAbjzDlm7UFXnJ7iUVsEptIEwCcGlgMpjdo+ia
 taT0yNKfKHAVlWzQP30OpjQUX8qcigKJAfUYEbdteMlFxE1sgi/crRRQToZE3kiR
 u9VUJbFHB98/S/UpxhKNNCt24g+BuNdOpkWw6GNHDdzMNizcwy3mWKPp6Pvbf74Q
 rVE1ww==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf82k9d2u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:34:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so5484917a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788453250; x=1789058050; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NCdvqWnMc2h2lRO9AwzxPxFIyZo3LEXJtCsowCTD4sA=;
 b=K1Xa/1p5kGWsFE1y4y1APKFcqcxj6zOl0HwrMPCjGOy93aGvrJloA+x45xHmzQuzVm
 CbnHgzDW50WLP1fJgLLGWuhaNzXJowICC0jkWbwk+OIhYAFn1pwNcW5yES6m2//apGFJ
 IAPWlJHGo0zTSviWmJOHeQHLZ+dnScqmw3SiXV/EkUnY48AeQmv/qL7/DO/ciq4I2Seu
 m0fmkwWZawX3KNy8ipzerT2PAlJ8GKw75Q5/0ubD5OzA/3IXj1zlGxbaZ0uBLbF8Ng7X
 Sxt9GyfmKp+GXVE8QRUmsNekBxjIH6V7r8Xlcy4D643O6LdbSjth3HbAQHazNGoiLa7Y
 Efyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788453250; x=1789058050;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NCdvqWnMc2h2lRO9AwzxPxFIyZo3LEXJtCsowCTD4sA=;
 b=N/70aBCoih684T+iXJKfhvuclbxKv2fJ8hvWJkO3AVdDsmtLkr20gP30xSmxSc+V4B
 x0+YIg0bAhercFEgvTUcM8j1dIdaOMQYrxbUa4Zy7AjXY4DccCLnSxKs2cSa9QOC7Nwn
 bnkViRDV3M0zAPPjE94MgW+gnqI2L+p31e2d+rOagNZ8p7emRm3bGQtHaFxaw3TAlsZd
 m+LyX4kGcvR4XwlN1D39SW0/jKdR6SPPa90x/l33f19DOM3tJ1frmizE2fv9ZfPLazOP
 rGHzukRB/1k7apWYuf3oNIcQReYOh5JyJoXU+sUdTA+uYZeOrPrfwkwgUqE7hKDWBOeg
 q0BQ==
X-Gm-Message-State: AFuF++lH3sLGGfZhMSII39haGvRMia88dCV7Jn5inovr9Z08iZa+anUV
 y886RXvOd/svsdBXLU5KCkdnc65BFvimNeUgoDQrEDZ1Pxd2wwaYwTk6yHUHim9z9/KTkzH52tK
 ZhcsbCwqcnzUj7vIpnPWNN88TMfS/TQ9P5plSY0YSIi1PP3sOIVnJIG9Iqg==
X-Gm-Gg: AYBFou3NQHcdo1kPvf2pcPh0rVO80aCmiqb6liZTsRrKoHtUhQ8wofk5GhH4vfVgFR7
 Mm6g+N5HhoaDIEeZXQ914okOBZiloaQK9Th4urwlcWOfAPYC89WHvQ1JMKWPpARE8bmV4Gi5k9Q
 RSn/lOL71FcFaMUzkHczGaY87LOpbiBXizIum2350Qkxtyh3/XCGhVyWVt3kuAhJnIUrnbrss+H
 +EquSziViidKqjvZBuLv2aFe6Pwwdd645XteqXtA59z5kEBc1skCZO15ocSqJY/I3V7poL0DlT3
 U18S8mrFOl06NDIo87JGI/2jF50p99RkPkHK98L1DsIS6bYTCLPHUXjYMZrdy/2tu8Cz6ZKiE4S
 S8mvKPeAQEy+DLbb0SxC7KbpoERlntje1+r6UvpRKDQmXxzn3O6XkRFZN0AO3NwzBTEem
X-Received: by 2002:a17:90b:1c8b:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-39aee0ab6f2mr17057183a91.17.1788453249609; 
 Thu, 03 Sep 2026 09:34:09 -0700 (PDT)
X-Received: by 2002:a17:90b:1c8b:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-39aee0ab6f2mr17057095a91.17.1788453249087; 
 Thu, 03 Sep 2026 09:34:09 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm180589eec.15.2026.09.03.09.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 09:34:08 -0700 (PDT)
Message-ID: <732d046a-dee0-4e83-b553-ef924f476363@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 09:34:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 000/105] tests/tcg: run tests with meson - last chance
 to review
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <878q5lugc5.fsf@draig.linaro.org>
 <c3a1b237-36bc-4150-8aab-21aeebf22273@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c3a1b237-36bc-4150-8aab-21aeebf22273@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JVV4a9-RzMZHNp82Bu_ngZXJA8kx84K1
X-Proofpoint-ORIG-GUID: JVV4a9-RzMZHNp82Bu_ngZXJA8kx84K1
X-Authority-Analysis: v=2.4 cv=OuJ/DS/t c=1 sm=1 tr=0 ts=6a99a182 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=V9eeGgJormj7Tu0-Sk8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfXwTEbODmgaVUn
 Zx345bID17HVzC0rRPPTLzH4h2kSoAjViZffLeYvjSqZ/Xp/+Ko1817K76fgKXI/Iefv8j4L9rW
 gu5dt8SKe5ECrRW+jELPxKupATsxSIP0qIIipm+0T9tP68xOyPAnWuPQBdRQtPEBcMrHU4OQGTf
 zl3kP4FoSZeZyzKf/HkD4JQqbe9Zx0q6FPS790xdISkbwFDep0aPU6cJoprWtuzZiAj1ly5J/zT
 f+H0/YT0Kd9+wMTZ4g4yAE7UY7pJEm1aUHbc8/TYZCgnSj339ygIYRChFxfaoPDvy/QV22vQCaw
 qGpg+xAXhY4N3hOT4q2g7rMBU/OFFyPawYB0O1yVVW4ZbdfZ4H7krqHyZGTuYMfUBnDji5AtGLh
 fvf3qrYT8NXJXFpXMOf9SKV7JVHNAqtxGopMQlOpqhmwR5q2ymfY0DkPhw9p3To+COgQ19cUTMz
 /A3y4By/ZZ583pxDmaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX7ru/UK40uk9M
 WFUqCOrpwYYvJgzmB0Yg0iS/sVAUxJ3xrLUtV61T3UuehvqsMbvN2nOtm2YnT5oEOlqkvkZqiac
 euSV8774U2avbX8HoB6tMO0WnKZ3vUk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030144
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

On 9/1/2026 11:22 AM, Pierrick Bouvier wrote:
> On 9/1/2026 8:44 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> This series replaces TCG tests makefiles with meson, with the
>>> goal of having something more readable and maintainable in the long term.
>>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
>>> them with meson directly.
>>>
>>> It covers all existing tests for all architectures, including
>>> user/system/multiarch-user/multiarch-system. It implements all requirements
>>> listed on original thread [1].
>>>
>>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>>
>> <snip>
>>
>> I think this series is ready to merge so consider this a final chance to
>> review any architecture related bits. I shall generate the PR on Friday.
>>
> 
> Glad to hear, thanks Alex.
> 
> Just be aware it does not apply at the moment (since yesterday), because
> of armv7 flag added to tcg/arm/Makefile.softmmu-target. You just need to
> apply it an anterior commit, and do a git rm to go past the conflict. I
> don't think it's worth respining just for it.
> 
> I'll be off next week FYI, so won't be able to help if anything else is
> blocking.
> 
> Regards,
> Pierrick

A new conflict appeared today with latest hexagon PR.
If you feel like solving it and adding missing test cases, feel free to
do and send the PR.

Else, as I'll be off from tomorrow and next week, I'll rebase it when
I'm back and send directly the PR for this series to avoid having to
deal with another conflict.

Regards,
Pierrick

