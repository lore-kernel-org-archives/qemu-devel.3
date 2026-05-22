Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B45CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVn6-00022a-Rj; Fri, 22 May 2026 15:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQVn5-00021x-1i
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:44:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQVn2-0005EH-Tc
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:44:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIE0cV3343110
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 19:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qfBKkLfhI4DkiFqZQWA4u2AQ2SGHfquedHCQRs68jbQ=; b=g21/CgCd7G1W5kg1
 Mk8CTwpZjJOGheE/ryNSG4Mmk9KlBh52SDzxLWc2zG4/zd+D0bjgAz2lOxWuAVIC
 2II1LB94m9pEv3BR9scI2znKN0wixprejZXMyzMbhbiCPLMC1sCZ1uAlRL9x+D+e
 CXxA+C1p8rGsMAAItYiBRAatsI/DFaa3R5QgDsdQYvkicWxOJ7+3PHU1htnpoh/G
 9bGw1Ngku6ygC9mkK1xBJ0v1VG+L98k373P9N1gqZhubf93/N8kDO0vE9LGOdoci
 JxoB5hL2fQwJKzpFV9HCyYsawai67zGd2AIGaAsj+pJ2mbrVQAShJDW51yCWn48J
 D0Wuig==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eav87r8uf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 19:44:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bda35eab74so6703585eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779479050; x=1780083850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qfBKkLfhI4DkiFqZQWA4u2AQ2SGHfquedHCQRs68jbQ=;
 b=QwIWizFOKXrwuT2nuqoeINgz7ri+zyhAWzVo9K/bb6NrZnJJflyslw3l2NpKVQM9N1
 JD8H1uUxW/4ojOahzohb2T3jD4pMBU6Am2uURRGUwInA8WTedvGkp3gHMMXOPlFJ+Iia
 cKtL7+eBs00rzTgbhXw97wwXZ0q4BJbKQ4kAQmONyeczzeHFrienLfrmXpiyzbKs6txF
 0SBvwn84LYDuVn9om3pJHPddeAKPoYxyc9C6Nt7MuDdI0kwtRdEdMZw4NFdwBA4Ws8p4
 tz/0OGQsO9pN1fOUFNkfGmeWfcS5T7oSLcGHA7plDrj04T6JFq311yW6pGwdm7lNWRqS
 ThuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779479050; x=1780083850;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfBKkLfhI4DkiFqZQWA4u2AQ2SGHfquedHCQRs68jbQ=;
 b=NSGMLu4qUvQVK31wN3w+JJ5wYp5r/8XjcqhJkYer3jlbSi699Qw6gtlIbWy2JSw2u/
 MJ0YfUnrEA6V1mBxvopCWqUnspPfsggJyX0P+FaoBhiUZJ5FVB4j0V7zKu0W3LFGChqX
 /IMjdH9n5Zbl8RE5XYBhuTo5/O4iGN0mOxbd0U3iZ/XaQpODT6z3vcR2M2zhQdxOqqIp
 Zgv3IMVK0atmEyRFCL9CesJ37fOqERZ9EwfVGdmhKlDq4oP6kzIKGSZ6s6iOeIwV/9cF
 ku1Kks4mZEAdCxgNgR6OuVGsh8mK+VMnCefMKCHD+PmWeVhizbgS3mPneBPQI5PZCtQZ
 p6eQ==
X-Gm-Message-State: AOJu0YyWtTtoxvlWzGnPnVIp/G4mNBYdxliNAw0aPQMhq5OY2dfgmjDo
 LhHerjerdywiE52coTaZ72AbToxja4hy/EdvqGmX8J1wd5Owtuzn2TPVlApkSBbWMZcdA6tqgCz
 qboIfxjZ/+f4y5smBZElUHaM8xRXgToHO286TJje2c2SEQGy/0rGKcwSpEg==
X-Gm-Gg: Acq92OFx66n8IYchODVB8NnW/zAuPA/L3p35bzjaBrUBtkVdI4TOkkRODOxoRfuhrR9
 2Qxya/thzZ/6eb3n+ttDxWN2SekG6XcmpsFNFlM38ouqQ8ccsGqPzt5VH22sIUjfdBiFStcCcPR
 HwT7FgNGLROBqXHgpLPTBICU/K0d18Q10W6tqxhL7oiz8F3Ks6Nh5LbiI70L/0+cNXet8Bi1ieX
 zNemoUbQ7DW9pkd4qb93JKVjXpVG9sEPZLh8+1eA1agB3Kz9RtVguCWfiUTJE7sAEaL4r90A/Pj
 J5SwNihdp+KTv76M5az2bPo+S7VL+h1cbqqdG9BHVI4lBbtcX7tte7jnaJPWVqwRB2rppDVnhFK
 9pvDUomSlJSrY8oWWg/hJu1twHKb/3LEm4DqjxLxVUySBTB9hSjo+NoQR1hrMDA/RHJ/Yd41DNN
 Dvatp/3tghdS4+jGRtWwTVj1a5
X-Received: by 2002:a05:7301:1686:b0:304:2176:a86f with SMTP id
 5a478bee46e88-3044a5c147fmr2018683eec.9.1779479050186; 
 Fri, 22 May 2026 12:44:10 -0700 (PDT)
X-Received: by 2002:a05:7301:1686:b0:304:2176:a86f with SMTP id
 5a478bee46e88-3044a5c147fmr2018663eec.9.1779479049576; 
 Fri, 22 May 2026 12:44:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef3273sm2361555eec.2.2026.05.22.12.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 12:44:08 -0700 (PDT)
Message-ID: <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
Date: Fri, 22 May 2026 12:44:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency to
 run-tcg-tests-% rules
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87tsrzl138.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE5NiBTYWx0ZWRfXxy3JvmV1X3d6
 kDklDqSYVRihcvEDDA71eNcOlx6QUjEBWc6wa7unDQjqtof6GaAo8Gt7A59tHx6kWJ1XS6W/635
 C4oRcvIMbQ1RfAy5WAgeNfosMeUR0NVn1uz/8Q0QYpQ1wlWRYD/ka1QUA+rRlggY7GBi94ZVZ6e
 eO/lCtsG2BchXB4qbIYZncQiBLxY3B5vr0+d1UFnLGQzctU3ZFkq8H5pz1td35lEucWSz9CxeGN
 aybe44G4Th3mc3NxWfDKLx/oe6Qz+eJq9hyQ+S7kvMujTprr/nWbN4ilOdC4lkIXWqwRERpHG6m
 K4036M9XPPMhoSnS4YNzROoYBIoPoBL8pCp0+A7VdRtU82rUYKxXyuvtQQYgJ15v/BhpQzYwu7p
 n4XNrNlVvJcJDRp83j4a4HmO+wFPet3uvQ3DqJma27Bdtmcr2UGadSSS1LvmmYfFp/y9qIq9tbg
 BItNVQio14yJf+LRdmA==
X-Authority-Analysis: v=2.4 cv=dbiwG3Xe c=1 sm=1 tr=0 ts=6a10b20b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZcAdr4m_QwgmZxOKJqMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: mDbCpKSivgGE48t8BcM20OhtPnvmU5nC
X-Proofpoint-ORIG-GUID: mDbCpKSivgGE48t8BcM20OhtPnvmU5nC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220196
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

On 5/22/2026 12:02 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 5/21/2026 6:17 AM, Alex Bennée wrote:
>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>> ensure they get built. This is especially important for MacOS which
>>> otherwise only builds the unsigned binaries on a normal "make all"
>>> run.
>>>
>>
>> I'm not sure to see why it matters. tcg-tests don't make use of hvf, so
>> unsigned binaries are plenty for it.
>>
>> Which other binary is this building that is not built by default?
>>
>> In general, if something is not included in "all" target, let's make
>> sure it's included there (meson.build?) instead of adding a workaround
>> here. Not only tests benefit this, but anyone doing a build on a
>> platform that might have optional binaries not built by default.
> 
> If you have a suggestion on how to make that work I'm all ears.
>

I would be happy to help, but I don't understand what the goal is. I
have three questions that should help to provide a suggestion.

Which exact test command do you run?

```
Explicitly set the appropriate QEMU binary as a dependency so we can
ensure they get built.
```
Aren't they built by all?
It seems to be a dependency, at least for check-tcg:
.ninja-goals.check-tcg = all test-plugins

```
This is especially important for MacOS which otherwise only builds the
unsigned binaries on a normal "make all" run.
```
Why do you need signed binaries for testing on MacOS (hvf?)?
Regards,
Pierrick

