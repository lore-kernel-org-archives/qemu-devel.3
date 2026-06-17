Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88957CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZv2Y-0005EK-0X; Wed, 17 Jun 2026 14:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZv2W-0005AK-EU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:31:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZv2T-0001fF-C6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:31:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHd76M2976614
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 18:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 68gYC1/Hz14XQE1tdCYQGHl9EzM1XG2AVhiIsDAg9gg=; b=VoQJ8HDWlRVtWM3/
 fFYzjxq5FUGxyMt3xvA3Gdz+sJdPCjx++bRPkWLLu75bK0FGDOL8ErgCZ/Pd7Ndh
 Fmbtomh2aQOw69VNT7jq14qf3H0ZsFZ22RUfYLDBAH42VpUQCe67cDCHttyR/zYZ
 SsgGRTLCirL/X6q78olznppHl3DTj6T33npyIPaNShqTm0ugXo4j7ud5sCYYqotI
 fOGzPgfkKVoNY9gv7K9VpSpuwbxSvpNjaQNshmflLJXBx1ZZQBDkSGUaeH8HA+wc
 06Po2GBPAhATpAMfHQWizd17d0MPqpTvNF7cPRoYgK6JNHdwLI4TGtwSw18zO2P4
 BnRE7Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2c923r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 18:30:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-307625ee07fso331741eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781721058; x=1782325858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=68gYC1/Hz14XQE1tdCYQGHl9EzM1XG2AVhiIsDAg9gg=;
 b=WkETbjna65+9B5DFjGepSFNYqGMzqZU/ARInne3Ab0fQ0MX1gVg3zloOzp6gm63PYa
 EVD5UrbWlnVpdx/XMLMFpOpz6aasKb/IqVsO84r0UBXMOZcMbEdh8urlb8SS/0+WGtRr
 rbJF6n4gIGZQzOt53FmZAFij7OJC01EEPznLwuMc7BmW0lMhSXJerqUJmT6EbC91yXej
 W36lXYAYJYmMP3vBXcRlHXTEpvR2LMel5cY5Eysr/UbYtojnEvB/ACf6qXwNaDcxvSqd
 gyR0HWUldObIIDEnpRCq5OP/g2IuGSRTeWX6z8NhVeNkKoGyKbF7qU/VEq1CaW6aHwON
 0uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781721058; x=1782325858;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=68gYC1/Hz14XQE1tdCYQGHl9EzM1XG2AVhiIsDAg9gg=;
 b=Zpm49mo6XBLw0mkosgzn0uKOqkaLvZuCupHyaP80OVKNvPt6NoWo2kJf7E8LlwNJ7k
 VO4sG6OWXHliPI9xdXIJ/tkHZv/h+5d8hEzz6D2tluEdsHmLvWa1u3BPOSvI82rO51Us
 IVNilNrZjfq2s2RYnR0xIRfHgehdjm9+eaTzwhUg/qS3ELJo7pympRTMLvgAWyMX0amg
 tbW9ja+4WmIFKAlrBSttl7fX57n3QvuTH6vPiuUyS3ATIlsTOEMVqFwEFir+cmm/HYno
 VAayUj2dsKjFd6DL4xGdjmSRWdlsFePFhUt1w/EzNsYYEM1oezjhNnUTs63AsVzbbGqs
 HA6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DU/1czhhzM+TXavwY6b36PgYhwQjo5viJob2RT5YN5ctIm3CdXtKAVNw8ThtARuqIA3cloiUlt2SQ@nongnu.org
X-Gm-Message-State: AOJu0YyHbZTRHF9BGC5+q5xDBLE/14Cr7Ex4eJd+gWIHXcY2wLdruBVk
 GZ9g5tS0ZiwrlhegCOTiih1P3zA7/GaVD7Td7r7XpmZaK+YTGo7GBcc/o9/haNm/6BPxrL35JW4
 rgW4SUvAM91kz29Dql5PEAQo2JHnHFuWd7f6a62uy71qM5RApz4C03G7ZmA==
X-Gm-Gg: AfdE7cm8fAriYJqnmb+xmlRN7yclAi1ANfocX6fBZ6Rm9PnM/WLA2vl+55ywij2pwiH
 r+dYc6u0lXtjh0zg4K6XmEeVyJryUMt2qhiJ8LLmllkIqcVBOIZZ7DiZMyxOwnyEBv9NELzESZm
 6F0gO40eFiIA96MmeoiXM47tAKKsbHVQXxTkZrynSKxilnI/D4zDMtO9cGnrqctWboebFY4kQoG
 6Z2u/cKHaLlBuOgfrZ6aQC7/uYjEq9LvJxt/y4ERAUffA5M8xB/QPBzTQJQTqu0gtdhGWQ8ETrE
 cblECNdkRd4XcZze6cilX/uqWFvgBAq+9sd26NUiwV6zD4S8p60bZJxHj+pNHphvvNe/XPdD4/k
 ggTNKbhCwmnX9UE+zxI087VY5rOlCaADaUVFvZ8sIltvbu4AkyxrKLfGauAdZ9TefsTNbBXhvOf
 HAPpE=
X-Received: by 2002:a05:7300:549:b0:304:188d:d0be with SMTP id
 5a478bee46e88-30bca09e8aemr3212092eec.16.1781721057712; 
 Wed, 17 Jun 2026 11:30:57 -0700 (PDT)
X-Received: by 2002:a05:7300:549:b0:304:188d:d0be with SMTP id
 5a478bee46e88-30bca09e8aemr3212069eec.16.1781721057177; 
 Wed, 17 Jun 2026 11:30:57 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95342sm24271026eec.29.2026.06.17.11.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 11:30:56 -0700 (PDT)
Message-ID: <68e00eba-31e3-412d-9e3b-c33460fb1377@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 11:30:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
 <05604cb4-6f61-4b64-90ce-505ac87d8a04@oss.qualcomm.com>
 <36f118b4-8e24-4425-bc45-df2f13651c21@oss.qualcomm.com>
 <87fr2lpt0j.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87fr2lpt0j.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE3OCBTYWx0ZWRfX7myFkHH1bLXD
 DfOHNrudpzT+1NJM+8mviEeD0OElbKLmbdO4cH/8FMnKj8BkEsZxTwnMFTKWFh/DwYWAg/NsmJM
 0/QScTjU9llGll2CPzKHRS/6DqbbuLrZTF1Ls5lpOj1RpXM4aXGrE8V3uIeLT+ZWAd0iGudUpJR
 poN3S1Gx+sqJkMpUjQZwJLomBYNziYDqgM84OHZeYNRkQ7G2VHcnL8R5IYee+4U8ikGtDBTsyaa
 ADoqOPR+qjDWStEq82RK+gy3ApOIagq9v+G6xn+9jzBywfXr1qODBjilNOWKICKPE9G0CncAFvk
 yt878Ok9RETxxq9WhWO8ggeN3DVd1a9fhp9GwEPwP9LotBLspyo7WjvqYpbkDfMv/1CT2oZc4sd
 4Rhou1zu4AeKkOy6JfGe4n+jS/ih4FzhV0eixWPDTRA0OyLD5568yIpzbu4J/HLcdJC+O3wu6uS
 wk77OLPMFxdxLV5e0Dg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE3OCBTYWx0ZWRfX9hjsGGLUnPJQ
 uMJvaedCvKfbi2+dbkgiMSlpq9p5M11l+otCQq/60uobB/OC1vb5mHu4KVwBHmOUEbXjBsIQj3q
 hbVBY5isKOmZmWG+tSQa0o2oGJulRiY=
X-Proofpoint-GUID: LsyuEfQfk1Rpe0tLzfwRyZz3VLDHbDN7
X-Proofpoint-ORIG-GUID: LsyuEfQfk1Rpe0tLzfwRyZz3VLDHbDN7
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a32e7e2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=ZiMIAIO6AAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8
 a=Ewlfqs4FMTfDiF6s-OIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=KohFQSMcaiS2QNUyYz07:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170178
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

On 6/16/2026 11:42 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 6/15/2026 5:35 PM, Philippe Mathieu-Daudé wrote:
>>> On 15/6/26 22:17, Pierrick Bouvier wrote:
>>>> We add a new script: scripts/check-maintainers-file.py, that will run at
>>>> configuration time (and not at build time), to not hurt build time.
>>>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>>>
>>>> We can expect things to be mostly in sync since adding or removing a
>>>> source or test file will trigger a configure step.
>>>
>>> You mention adding/removing but this script only checks for removals,
>>> no additions; did I miss something?
>>>
>> The initial scope was only to check the MAINTAINERS file itself is
>> correct. But while we're at it, we could extend the script to check that
>> all files in the tree belong to at least one maintainer entry. This
>> could have the benefit to force coverage for all new files. First we can
>> try to see what is not covered at the moment.
>>
>> What do you think Markus?
> 
> I periodically post a report on MAINTAINERS coverage.  The most recent
> one is for v10.2.0-rc4:
> 
>     Subject: Report on MAINTAINERS coverage
>     To: qemu-devel@nongnu.org
>     Date: Thu, 18 Dec 2025 13:45:24 +0100
>     Message-ID: <87h5toc61n.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/87h5toc61n.fsf@pond.sub.org/
>

Thanks, I didn't know you were publishing those!

> We had more than a thousand files not covered then.  Getting to 100%
> coverage would take a big push, and require help from many people.
> 
> Even with imperfect coverage, we could still require coverage for all
> new files.  I'm not sure this is practical without at least some
> targeted MAINTAINERS improvements.  Test-drive with a month or three
> worth of existing commits to see how bad it would have been, to give us
> an idea on how bad it would be?  Or just take the plunge, and revert if
> it turns out to be bad?
> 
> This series tries to solve a smaller problem.  Even if we decide we want
> the bigger problem solved, getting the smaller problem solved sooner is
> probably better than getting it solved together with the bigger one
> later.
> 

Right, definitely let's focus on what we have here already.

