Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A740606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lz2ofFff;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rpm/G8yb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTi3Z-00017q-Mq; Wed, 18 Nov 2026 10:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTi3X-00016P-A4
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:58:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTi3V-0002pr-76
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:58:42 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIDQWJg1928740
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 15:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1S3mWOItcH2+JuY9FXuFpDbhUu5wLTxdk71KKz7p+Hg=; b=Lz2ofFff1u6551jY
 OYZG3b/IZdoyGV5zcnwzWH76Vcv7LkLViir9hb4+iAi/nrb/0PWtIhmQ64lbPpcC
 UC8Jk/R5kYZJd8K8tEX5rHuSyH2cRYv+CTu3uSEFOOKZ2eqK1ZItht7JMqXCD8/A
 84ZlZJd/4jXcykGvRZJ2Q6ulfuDzg0xVjM40AcuE7drd3HgermhY5gApNOqQlm4f
 XqoYKrE3kRImfAMqagJwtv8W7ud82wf5lnd/2Z8AEc11CkgAVlN01vWpYv9agj7L
 otGPQQupuXycllUMhFmBeVu0WyPkx1G6Q763Hk0O6qs6B00sKyRwumP+YyIyWQ4e
 JJmNXA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8bvt7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 15:58:39 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-861598e3f88so1265441a34.3
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795017518; x=1795622318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1S3mWOItcH2+JuY9FXuFpDbhUu5wLTxdk71KKz7p+Hg=;
 b=Rpm/G8ybpgLrx6PvZTf9qa7UC7DTx55wznVF6tl5TdbeggqPTd8csWHQbc7g+I+szl
 12dkuvOatYkKp7Kuj8SbQsvFGAqoAWW4g8yEwgNSV/RdcCeg1ecIRw5Nl1UU4RXokD6+
 cfTlC3NhqgDr5iowU4lLl+jeRJvheC2KaZrSDOkr6O8aGq1rdHAYtL8RLyIY11nQEvjV
 n6tBN2VT64rpz1OWcwpzyYNdvqu35cyCqgHgs08xnhOJU6N0141DS0nOrD79X1sWW8MM
 lLhoRRlntu1eRXTOOb8kDGuYmrVqG+NvReh5tEac+jKo0KV4HKG1vjrrN3KsbVVGQexF
 4KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795017518; x=1795622318;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1S3mWOItcH2+JuY9FXuFpDbhUu5wLTxdk71KKz7p+Hg=;
 b=cFXES1HQF1ZWEe/nQGm8h68vXfHrsVZGrckoF47p/lWIhYlSuQdPOKNIvluSeCQagM
 5q//+lq+eiusPs+3wTJjlIw2er26wW0fnuU3+LmutVrnGCd2dXOSfD4/qqNYi07iw0qi
 XhXWjMPrfgtydKA5E32D2F3V7aZEfU0TgA75jNmm/xVMpARTRVZHvWdxzhq7ntGjknkK
 YKbtc9PUCp43UxeiPgyj5yqz5h6RUZ7u2qiowNR5JyxNrHaS6E+/iOKY6nneYlYkJ+0f
 dz3jwbrIOUprcZz7HxrE+GOmPBujuaDxk3YySbw1bGar7PdIhbTNk9UVDbIeq6qLp6LI
 vesA==
X-Gm-Message-State: APuU4Z8B7zDA4HkvLwNOo6BB2qRs4qvfS+9RAYf/bKA8VfPSvY4EQSVd
 akZkrdjEgmD18nRgXn4nouZypFT1CEnWhoJNf8cn+IDURjgrV6R3WQ8JZp5rmsikui6H7zBjhkQ
 HcRVPLOmrQ8ibLWiHYq2nco1Z3FLaG7MXv77MhiUjSqusN/6ppSetLez1jg==
X-Gm-Gg: AYBFou3lN/obq2vw//M0REsNwUXMVa7GUdIvDBe+LnbBj6Ys4Gtgc8FxDSg9X29Muum
 k7pga+iLsmbzI3XMzutks5rPhHnqu9G0awh0CHC7ENNNiNFfa3KSdaCSSRw/tkbn/HBGz2JQ7jM
 gmfmP2tZ2UUICB/bcL+xBt76inQYG1T38qyKHD7iF67jaVSXSfQ2sY2zOkOvl1sK05pEOA/vlaG
 jige1Zv/+Vlpu6SzSWpcOlKLp2ty3lujrABjnhs8NGrCqhYKjiwRUbsgYhr7LEbZ/zPz1LpIrYc
 mPxyoq+afr3VpltOxmBPbEYZ5cwMwUdB9fkL5N7GYqnX5GaHzikjHNyKpgpkzlCIC5cGTYse9ds
 SAzlZ9y02PxMlBVhWZN/gvIgynNAe6ccLdnLI29eUq4oZqzEdfTh9wTvT5FhPGBzh8vbTzRmcwV
 NHzYTDUvAJQJ40u3egb0ZfwQWT8/QKCe3cz7cQvyvYzbs=
X-Received: by 2002:a05:6820:1c91:b0:70e:1dd8:6695 with SMTP id
 006d021491bc7-71b18479194mr2043687eaf.37.1795017518429; 
 Wed, 18 Nov 2026 07:58:38 -0800 (PST)
X-Received: by 2002:a05:6820:1c91:b0:70e:1dd8:6695 with SMTP id
 006d021491bc7-71b18479194mr2043666eaf.37.1795017517838; 
 Wed, 18 Nov 2026 07:58:37 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb0esm2577396fac.3.2026.11.18.07.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 07:58:37 -0800 (PST)
Message-ID: <40efb3c8-a93f-4c47-83a0-08479ec207d9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 07:58:35 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs: add a diagram of the development process
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20261106122111.3005638-1-alex.bennee@linaro.org>
 <dfc31d65-d309-461d-a47e-3df3c658d56e@oss.qualcomm.com>
 <87ld7566jz.fsf@draig.linaro.org>
 <b6a6e0bc-90b0-4162-8ec9-098d1ced1069@oss.qualcomm.com>
 <87zev65f75.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87zev65f75.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aurdWG8n7ajMSEOtgTPW07Qatlb7NW0J
X-Authority-Analysis: v=2.4 cv=N9u8hG9B c=1 sm=1 tr=0 ts=6afdcb2f cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=kne_o7KXAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=0DwPdAuEPTJiwcXmv5IA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=c4Qo8gn-6q4hmEPFHG3F:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX+wNZ8J/PXuxU
 9M5wbHFf7GiD07kxaVxs7BHRrXAZ73W4QPBgEF4J/R6+I0vImtbEkSNmQAONBPXoM0QtY+pQ16w
 c5q7+GKErq9pVRlKTHNERQwH1d66cgyN3nzI2NH/6E3GU1Fre8ILwpqWNLZ45yjxNzbHoJofHuD
 fB2Nt+5pi3oRMbcyiGUF3jgw12jc42HFSmaeNoFrpS+pZgT7qpim0Sfl4eL8nTnb9bwEiiUtrxg
 H0ERovpBAMBl1H6wzqwJGiA655tc33ij4ukwrPLeKBL7Y+QvSYj7Uta92c3knL7KqFGxxKPLlmP
 os0ppoQ1suyMmdw6xWEhrNgrd4CWoW8DDYj7FSvi4W9nNW+8Ovr2W8phJ20ILLmXHjRt0Ikvz/i
 Xl7DrUyAgMIeof1CIT+tpOtDWg5Kr27x059vOFqmA1nqi/WxyL+YNSDtqQrILaYhDpbIyDAmI9V
 aG8FMnldpRyC1vNDzcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX2XaAwq6l6lAE
 LOoiM/tnyOP0HMvzxf+bh6Xq8/UvFL0PPGi7jUbH4lA3B1pX9qLFxWvNz0KrRRlLKFAHGUUGUOW
 5URzsZQW9w/zt8fmJYqDJVGP/ZC22oI=
X-Proofpoint-GUID: aurdWG8n7ajMSEOtgTPW07Qatlb7NW0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180063
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/2026 7:31 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 11/6/2026 12:36 PM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 11/6/2026 4:21 AM, Alex Bennée wrote:
>>>>> We've had various versions of this diagram for a while so I thought it
>>>>> would be worth adding to the developer docs. I chose plantuml as it
>>>>> has a plugin for sphinx that we can use and supports sequence diagrams
>>>>> which could be useful for documenting other features in the code base.
>>>>>
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>
>>>>> ---
>>>>> vRFC
>>>>>   - I've bundled all the plumbing together in this commit but it can
>>>>>   be split up if we want to go forward.
>>>>> ---
> <snip>
>>>>> diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
>>>>> index abbd3e3f0b8..de4395cd3c7 100644
>>>>> --- a/tests/lcitool/projects/qemu.yml
>>>>> +++ b/tests/lcitool/projects/qemu.yml
>>>>> @@ -89,6 +89,7 @@ packages:
>>>>>   - pcre-static
>>>>>   - pixman
>>>>>   - pkg-config
>>>>> + - plantuml
>>>>>   - pulseaudio
>>>>>   - python3
>>>>>   - python3-numpy
>>>>
>>>> It will silently disable doc by default for most of the people
>>>> unfortunately, not sure it's the best move we can do.
> 
> Do most people build the docs? As long as it fails hard for
> --enable-docs I think that should be OK right? Especially if we update
> the min requirements for the project.
>

If we start with the assumption that it's ok for people to not build
docs when submitting patches, then it's ok for sure. Is that right?
that's another question.

>>>
>>> plantuml seems to be pretty widely packaged so in this sense its just
>>> another dependency.
>>>
>>>> Maybe a simpler solution could be to generate diagrams out of sphinx,
>>>> add them as a dependency, and generate a blank image (or an image with
>>>> diagram source and a message - please install plantuml) if not
>>>> available. What does plantuml brings compares to graphviz builtin
>>>> extension?
>>>
>>> Ohh I didn't realize there was graphviz - I'll see if I can recreate
>>> with that.
>>>
>>
>> If graphviz is not installed, a warning is emitted, which stops the
>> build since we turn warnings into error.
>>
>> The warning emitted has no type, so it can't be filtered with
>> suppress_warning setting from sphinx-build.
>>
>> However, since sphinx uses standard logging framework, you can silence
>> it this way: https://github.com/sphinx-doc/sphinx/issues/10219
>>
>> ```
>> --- a/docs/conf.py
>> +++ b/docs/conf.py
>> @@ -24,6 +24,7 @@
>> +import logging
>>  import os
>>  import sys
>>  import sphinx
>> @@ -66,8 +67,20 @@
>>      'qapi_domain',
>>      'qapidoc',
>>      'qmp_lexer',
>> +    'sphinx.ext.graphviz',
>>  ]
>>
>> +# Render graphviz diagrams as SVG so they scale cleanly in HTML output.
>> +graphviz_output_format = 'svg'
>> +
>> +# Silence the warning emitted by sphinx.ext.graphviz when 'dot' is not
>> +# installed. Diagrams are then rendered as their raw source instead.
>> +class _NoDotWarning(logging.Filter):
>> +    def filter(self, record):
>> +        return 'cannot be run (needed for graphviz output)' not in
>> record.getMessage()
>> +
>> +logging.getLogger('sphinx.sphinx.ext.graphviz').addFilter(_NoDotWarning())
>> ```
>>
>> The advantage is that graphviz is not a required dependency, so doc is
>> still built for anyone having sphinx installed. That's a nice end result
>> I think.
> 
> I don't know - silently building a not quite complete set of docs seems
> like the wrong way around but I'm happy to defer to the distro folks
> here.
>

I don't mind blocking the build if you feel it's better.

The important IMHO, is that graphviz is a better choice than plantuml:
it's supported out of the box with sphinx, and avoid to add a transitive
(heavy) dependency to java for the project.

>>
>>>> Also, text diagrams (https://asciidraw.github.io/) with raw formatting
>>>> have the advantage to not require any external tool.
>>>
>>> I have the ascii original although ditaa seemed more of a stretch:
>>>
> <snip>
> 

Regards,
Pierrick

