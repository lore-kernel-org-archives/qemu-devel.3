Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88A606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T0D6VFEK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WAIU5aJ1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJNym-000650-HL; Wed, 21 Oct 2026 00:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNyU-00063k-Hh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 00:30:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNyS-0001uD-G4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 00:30:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L4Fwvu3685471
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VQ5m/iC3WaF+XCXRAIfeZ9rJXrMgyEK7/Vwnaw4sMH4=; b=T0D6VFEKVLZeI4uF
 GvBVuH+FYfAPKo2mOkj++F4IEDF/rCMPR5gHUjNYZAXihVNTwARsSCaO4jusnDK+
 uzISRbA7SvwFHNARc074MAbF0EIq/iMyALaq+B49c3BEhynRvwHhc8nimSB8TcM8
 eyw6mA+4zrZpkZ5aqJgmDSd4QLUhfirwF2Ehqy9sg9nlGo62a9P8fY2vNMmT+7GX
 4aU8qgSPZxEweMTKlUTiXNeJk+Gf5SPlbbzk1oayAqqRK+Bd8jg8aLFGhFh34gQg
 5r2EKR4B4WCurNQK5qGRVVrDw3yDuZ07NfazqnBUZlWW27jt/pG/6OwouznhILL3
 EgYQjw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r12q7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:30:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844e383so55209085a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 21:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792557046; x=1793161846; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VQ5m/iC3WaF+XCXRAIfeZ9rJXrMgyEK7/Vwnaw4sMH4=;
 b=WAIU5aJ1AWFzNqOAwhz6RcRhHpCEvGvcgVcR+jh+VKYEP/5c+PDGxcY7ggiK9TTrOU
 v86vu3KO4Xd6h0EHkeFChXfPXtTHJ6nu1ziRvt5twOOcI/P3fjmMkP+OXquQmJ6SubPt
 MqlvlMtjqktza99XjCMN4W0aVeGDjM4t6ObBfGfnjfTcZRKjA64u77booUoNGleemhsu
 1HJbhEdH5FN2wl+5sFaM6JUM1kwdf/5EWytS0Z1vZdZQa9F9Dli/amHOm0ORO2hCWVLr
 wSqoBeckz0XmhrGPScMRQSHce+pKTqY7BP3oU9S5SOnkN3IgeWh7vupLveq/odNrNSZo
 OiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792557046; x=1793161846;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VQ5m/iC3WaF+XCXRAIfeZ9rJXrMgyEK7/Vwnaw4sMH4=;
 b=SkZ6+S6PjT1pEkOJattchU/BcLr18eT+v2hsnehuZxbSDUy1RwAnykoHkNRpRVR6Kg
 Gj8v8hE9jPISO2nzrOv9vXYgkFyC/1Fuj3H6g9jO+L2Fhxwv1g75jE8V546L6XkZ7QCG
 E4L7S8zxfqnmV+vRurEOjwBt+9ilrZj69VzxvMuour5fAle2FZlWPJkWMj0yyf5oOVlF
 LU6wer9UyatERzfVTjdab8i3fp88P/mX4RYXENOD8Wsh4vbu5IO64hqv8alIDTJDamYS
 jJtMDh+8tHkzWVBYgw7SfspFuX9vejVm/o37uueiWezYf9wAzHZgjbezD03qe+C9PEUQ
 AKmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw49XfURPN4vUeUqZtWKVDylw4c2lYYV7LlV1tA9K/cE9P7zdMOn+oxNj961SyrXJKzo7OCwAW3vMbf@nongnu.org
X-Gm-Message-State: AFq9FYLIRhhVQNrqWo1QGIMUk9XydE7Q+ogb4IkHX84XpGpzvmQbwJNU
 KsXG2BfbQSmDFJF0c6FK7zIYpjwIT+UXSGTZr0ht6xS1IDyElELRtdczjdkyHi6b5652SWdWiA4
 igBYfYIeJwLqoTZS6pbDqKGJifqwCFn5a8uJ6K+qaa7ai2a1h9lr85sW46Q==
X-Gm-Gg: AYBFou1a/CKh9Xw9tTvekgCgsnTvaFiYv7AAbQ86SMEvQT60+RGJ4MsNLWGqZkUOsYX
 tUvm8M7mTN92t7uoAMyYEGSIcn5d8Ma2xP7hZO/GcB5DR9wpQq7UP9gpCZElj/BE6q2uDGln1R3
 iU3EYyZZXSku4vk6VaoGeSgqsJm0rR3GA+PPiRjkEtSvncaBpA3ifmRkjX3RZGeF3u1l2aMbTTm
 ErdTG3SuIUeTq9lfueov1vJhAz2NP5C5N6kC7D6buPrpa11vXm6P4f7Uh5B5PR3zZlrPHzIL6Ur
 pjzkzyuImVqmGdoct37dvocDuhKbsXdQSKM8ARyW3Bix6UNFnca3O+75lGBaQ/701WUw85sspUA
 ifgRtaYKLjcv7566iRA6bg/HXySSpFOIGDQ==
X-Received: by 2002:a05:620a:470d:b0:93f:216f:f404 with SMTP id
 af79cd13be357-93f57f1d752mr241750685a.40.1792557046360; 
 Tue, 20 Oct 2026 21:30:46 -0700 (PDT)
X-Received: by 2002:a05:620a:470d:b0:93f:216f:f404 with SMTP id
 af79cd13be357-93f57f1d752mr241747285a.40.1792557045885; 
 Tue, 20 Oct 2026 21:30:45 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e258424bcsm2717464f8f.55.2026.10.20.21.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 21:30:45 -0700 (PDT)
Message-ID: <b622b220-b7d8-483a-9c7c-06cf7da22997@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 06:30:43 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/sparc: Add the SHA instructions
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-7-stian@itx.no>
 <dcdb1452-5196-4edf-aaee-cb032f581526@oss.qualcomm.com>
In-Reply-To: <dcdb1452-5196-4edf-aaee-cb032f581526@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad83ff7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=EfpQIFrvkjdB9kFoBmkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ZCIgos2p7kKq9d9AXgHEOLIRroQa32DG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfX2zq53PuyiU97
 iGNNtDk1VXa6/fnYV3bBzid5JpHs1tUyVtejnS4J9E5DUQPlyOrYSd03QmnO+ZvDgAaKQ1VLbpc
 dZcMm2PVylixoD52p4CSXNIzC4ZUF+vMhZ8tazUkm60xJoG0JP4bg2FFeQsd71F1mefAJaw+gdy
 yEhh7Gu3hkoVm5BQReBWmDUAUSSbm2OhLPIblEfwaL/V5QYBnETf1C7nlM6jT+eIIY2lKEa60jd
 NFyqViCNMB7e1I9G0SLlqGFBwUjRpqdRCAmSAcgCyiJYyA1xXGU/xhMM+lB+oc9bQ+QOv2hPfvG
 ANJ6wnoqdy8k/oQwVsPHXAkYrbLG6iwWIIFvpNobDKb0j2fcpl7zmksZ+6xwVeVGp6MvCEGoKEw
 YKI6VStKVLqnrVL6PRznnSeU3yJDqjbuo2wyp7PxbXKEeM3sCfCOhRYsXrQDn8uAFQzI0HCjNZn
 SowwBZaDDHA0a8UrEDA==
X-Proofpoint-GUID: ZCIgos2p7kKq9d9AXgHEOLIRroQa32DG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfX9uv4ddRvBWvz
 vGFwoTQb3Qu3x71aAJeJiL8oiLida2/f6cKq0sWS4vZ+//UdsvXLgCJyqT3Ev1LiMYLqJ3qhifp
 HFLC0b5/4OZsLhRdgXf0MFhrBSTD9QI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210017
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/26 21:54, Philippe Mathieu-DaudÃ© wrote:
> Hi,
> 
> On 20/10/26 16:55, Stian Halseth wrote:
>> Implement the SHA1, SHA256 and SHA512 instructions according
>> to OSA (Oracle SPARC Architecture) 2011 section 7.115,
>> using the algorithms defined in FIPS 180-4.
>>
>> Read and update the fixed floating-point registers and mark the
>> lower FPR bank dirty. Share the SHA-2 Boolean functions between
>> the SHA256 and SHA512 helpers.
>>
>> Gated behind the crypto CPU feature and disabled for sparc32.
>>
>> Signed-off-by: Stian Halseth <stian@itx.no>
>> ---
>>   target/sparc/crypto_helper.c | 272 +++++++++++++++++++++++++++++++++++
>>   target/sparc/helper.h        |   3 +
>>   target/sparc/insns.decode    |   4 +
>>   target/sparc/translate.c     |  18 +++
>>   4 files changed, 297 insertions(+)


>> diff --git a/target/sparc/helper.h b/target/sparc/helper.h
>> index 1320f5ebba..4be84622c8 100644
>> --- a/target/sparc/helper.h
>> +++ b/target/sparc/helper.h
>> @@ -134,6 +134,9 @@ DEF_HELPER_FLAGS_2(aes_kexpand0, 
>> TCG_CALL_NO_RWG_SE, i64, i64, i64)
>>   DEF_HELPER_FLAGS_3(aes_kexpand1, TCG_CALL_NO_RWG_SE, i64, i64, i64, 
>> i32)
>>   DEF_HELPER_FLAGS_2(aes_kexpand2, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>>   DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>> +DEF_HELPER_FLAGS_1(sha1, TCG_CALL_NO_RWG, void, env)
>> +DEF_HELPER_FLAGS_1(sha256, TCG_CALL_NO_RWG, void, env)
>> +DEF_HELPER_FLAGS_1(sha512, TCG_CALL_NO_RWG, void, env)
> 
> Hmm you set TCG_CALL_NO_RWG but the helper do read env->fpr[].
> While benign in practice because fpr[] aren't tracked as global
> TCG regs, the correct declaration is using no flag at all:
> 
> DEF_HELPER_1(sha1, void, env)
> DEF_HELPER_1(sha256, void, env)
> DEF_HELPER_1(sha512, void, env)

I apologize I was wrong, your patch is correct: fpr[] is not
a TCG global. I'm having some confusion with TCG_CALL_NO_RWG.

> Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


