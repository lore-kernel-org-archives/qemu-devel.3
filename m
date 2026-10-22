Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE2606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pGJzJLmk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VxmStv9q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJwdF-0005LP-R8; Thu, 22 Oct 2026 13:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJwdE-0005L7-8w
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:31:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJwdC-0002oW-LH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:31:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MH5sqv249768
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IPjPRVi6uv5llxHmcNo25dLcgwjk/qWiWmCXzRps4r8=; b=pGJzJLmkKhRnmSFT
 Xy19KKaekESENCLiuQ6/b+BEAFxdiGQc12LsUdwt7vqiOUQYOIcx6fci1lq+PFm+
 aU/TkRmyPigLfboMaMzCpi72T9CChEjBkNyuTGuph08ACBBe09xNhZsxIUFZ8V3J
 BMqdxk5rrNwE5u+R4vPw+gQFmHcVngmhcCYJv4y8WR1ZadUJd7jPSiQQKiz2haEA
 7zT9JLmD2/YhYsWjtSw4gme7EbvPJyrzJ84WIR6uH1zSJ9S5tKXDG8zeMfhjmymk
 W1XLYK1TTLxxk+R9/imzB6FeRialx6OgaU7LOAXAAjkdJqj9Ql5sP6Vt+Vpa5YUZ
 OBK47g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw09xd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:31:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3692c5b061bso119171eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792690265; x=1793295065; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IPjPRVi6uv5llxHmcNo25dLcgwjk/qWiWmCXzRps4r8=;
 b=VxmStv9qvsmdwb6zidIhPMJtQ5zr+sxjdulMMlJVffZAd9mhd3Gi/IyTwawxfTJfUB
 zDtsSlItBV+bLdgWjZoO7fdjaSVDAnSdQmTio5ttaf+WStZehbTsNFByuCER/zbvwP59
 Gk8BdeToZGGXfWyq03EoJgeRGmXBmBkcyvvtv1HAt3q6YBZe+ebmagGqjn5CSpiTsKVR
 SVjnckX8Ns0nYmQP+luIVtT6XG5janx+f61a7K1rBQP7RCprEnTSGMp9dD+jSBBgapGM
 lgCm1ediakMwk7o0lRsToKd2pi7eVuqanHinfKNmRLy3Mcv41uBNDkUV928CWRxX6oIw
 whkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792690265; x=1793295065;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IPjPRVi6uv5llxHmcNo25dLcgwjk/qWiWmCXzRps4r8=;
 b=PomcsVxH0cW4HjjiWsRACiEZUo4H5y0GzLZYQKyo0ENEkwoS0EzeJB/r4lcNxTjRlr
 cwNeWmbgO3vXbT3O8iry7mK2eOICnxhB3KpWG7aHIK5C5eHoVtVbtS68Bm/jVHAFhA3v
 rjKvAVymIVywB1ALznE0Q+UsZCl+BYutd3iplAIzkvb0KtFp1Zi1VF5gF6xxt5hy9eWc
 VQGXEBbLdIX0VbKDGN0b2i2vkR13Q6AZb/t4Nk6m+IB5kR+POpnmiiw4/kc3Qe6HRmgC
 BEltwa/03oVi38HEOMvTadFGaiKoJTgxPZxuZH2b0wjtN4zG7PpshYA5Y74pQEkFk1IU
 ehag==
X-Forwarded-Encrypted: i=1;
 AKwUvByRb3NeFiFzYSKdT32bst8wy3NxJPfwTtKzxrfir3Pl+AY6gD3svGOrjhe9rH9qj7MTm7iKjqKYzp4G@nongnu.org
X-Gm-Message-State: AFq9FYIITJeAmHFDhUqkd1A+bTEfkRZYv8qkqePL/+HpohxLMYEnkthh
 MX4k/JRwUdLYy0NVw2ZEsYbi5FOr7xiVbDla6R+iuhqeUCLdZHitH8rtHMf+b3ihX90QlvwER6e
 KsFrh5aUQP0ZzLioKazGA63KYiyZec6ScyYKFuQs3Ayf/9xvKZpgCAREz5w==
X-Gm-Gg: AYBFou3VUvyTVlvjDqpt6Fh546GHE20fs42McOGFtN/asvXo6aSCUqKhviHaBmMWKSG
 rz53RbrzdzWbLJ/Bp6uDX+jYyitzQWVgLf7+Mt9nFu6mmBfICYKtXLlPhFF66PUin7bhQwTY6Yr
 WSouovaSgIj/nX6/hdtdsZwlKQqQjmNjSLgjFP6OhjMteOqWpUN4zUkZ2FOLohzXPYnYrPkLpoz
 MPur5TOHuiEPKsRW806iahO7uz/FuBdSfyPNzoBY4q30uTjxvOaQPJ3uCnzIChWZ7csPe8dJsGK
 NH6+pZXs9fxUXJZOhlDy5GxiYTf/iRc7PzVpCCjhd9/xL7SzCBjV30+59ucG58LpeOhJ3TQH5zg
 8Yr2HoenL5QD4/EPzdw/7RUAe+h/GXVj0b0n1+q/IPzECtGcbt8QhKlchz5g/G6KXpQA7xw==
X-Received: by 2002:a05:7300:106:b0:365:f73b:510b with SMTP id
 5a478bee46e88-3674e450faemr8136689eec.13.1792690264773; 
 Thu, 22 Oct 2026 10:31:04 -0700 (PDT)
X-Received: by 2002:a05:7300:106:b0:365:f73b:510b with SMTP id
 5a478bee46e88-3674e450faemr8136652eec.13.1792690264148; 
 Thu, 22 Oct 2026 10:31:04 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367412b24e3sm16020494eec.19.2026.10.22.10.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 10:31:03 -0700 (PDT)
Message-ID: <869bb694-51ed-43c5-a061-575b9ba91ac1@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 10:31:02 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] ci 20261021
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20261021181932.9555-1-pierrick.bouvier@oss.qualcomm.com>
 <9d5de336-72b8-43d0-8d6b-0d38118099d9@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9d5de336-72b8-43d0-8d6b-0d38118099d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Uhd3uvEEcjowlPj8YDpsasWe4KREl1xa
X-Proofpoint-ORIG-GUID: Uhd3uvEEcjowlPj8YDpsasWe4KREl1xa
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada4859 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SfMdbctfOV5dhtSqw9IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2OSBTYWx0ZWRfX/yLGczdzTMNT
 Mi1WovGXmdkOt/8mWbnMa8w+YqPmK7pyDdfQiR+D2Yusj8/vH1e/o5Pts/SHOtsIPsk2MjKN2Jn
 PrS6i2/ysCazMwGt/WQBEEfvEo6c4mc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2OSBTYWx0ZWRfX3XcuuL2krR89
 fcxQ04b0N/Z0MJ8iMEI2Jy3IdpFKLyuJS4xC5rh9if52a1rSWsip64zp3FqbHxswKOJths5dz9M
 zdmLeI4rr+RXLfnbxwZWOrbKUk+OfUStLYkmUqP78lCnVL1LFDsaCjyuRHHI0GF8lS7CbICA4/B
 2UBTYhsU4pu74K6wku6528xwcHPm7xq11AZJK8kOeUeZmJ8WUxiCkXQ+oLeXmFzh/JpnjsIO+rz
 KOmRl73Dc6QmeZtAd9FF67YpanRC1Rkaj/K1YnnluweBfRzsGlFY6OazdbYAYOStQE+TXadLJSb
 H0FaAXse1Uq5i6nltObJLqTZhVD2iTJ4Fpa1OsN0qtPZPSxv4bq8u+TEfk7sUdD53kcYXNiwZK4
 qUvHtPkpLHpp+9w32ZuEiYREk8m6W6Pr2eyls8rfRTFR9toMsoq4BZMqH/c7gXOKBRD74MV812Q
 d0zwSKIusSNjGX/o8SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220069
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 12:33 AM, Richard Henderson wrote:
> On 10/21/26 20:19, Pierrick Bouvier wrote:
>> The following changes since commit
>> 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:
>>
>>    Merge tag 'pull-9p-20261019' of https://github.com/cschoenebeck/
>> qemu into staging (2026-10-20 07:04:06 +0200)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/ci_gitlab-20261021
>>
>> for you to fetch changes up to 3a6d37c9883d21529a01e3615960696f91499153:
>>
>>    ci: add automatic retry (2026-10-21 18:18:33 +0000)
>>
>> ----------------------------------------------------------------
>> Changes:
>> - [PATCH] ci: add automatic retry (Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com>)
>>    Link: https://lore.kernel.org/qemu-devel/20261020231602.24344-1-
>> pierrick.bouvier@oss.qualcomm.com
>>
>> ----------------------------------------------------------------
>> Pierrick Bouvier (1):
>>        ci: add automatic retry
>>
>>   .gitlab-ci.d/base.yml | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Applied, thanks.
> 
> FWIW, the first pipeline containing this was entirely green without
> intervention, which otherwise has not happened this month.  I don't know
> how (or if it's possible) to see which jobs may have been retried.
>

That's encouraging.
Yes, you can see it from list of "Related jobs" on a pipeline (right of
the screen, scroll down).

For instance, on this recent pipeline:
https://gitlab.com/qemu-project/qemu/-/jobs/17378918262
We can see that build-user failed the first time.

Probably it's possible to extract this data using GitLab API is we want
to build long term statistics.

Regards,
Pierrick

