Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23494C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA7fn-0001rt-2G; Fri, 25 Sep 2026 11:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xA7fk-0001rA-BC
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:17:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xA7fh-0002Np-D4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:17:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDT2Pn3628345
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XFKJ/2TrMmtj8j1SLXFpIjBKDvN6+bPnfoVVnrVYt8g=; b=FhqgBdSbeAXQlxi1
 4EFnH2osfnM7cBM/5oTw7UDffrnID+DkdTC35uVS2kQlZssAY5pUnrY8vTpzUqWq
 fW8g8K5yfKAxtFKswF99B/YlViAkdgskEEOBkRqcZ5qo17Jix/ziMXuWQGMLJ241
 RzLBXdB1Zdt64MrJNcKw38v/ZUylQeJh0fkXAwiFKRXmd02iCSfoh6OzcNPE/8HY
 GbRynZ7T01D1IaX8smxq+wz76D9V03a9X+jnjXmNr8D3Vl1/cadJ6c8kA96S3Xep
 q/qtpjTCgTP2EPhF0IgBYDVV4of23mBz20ghjYbjVK3hKQnjHkZslD4w1OGAwwJF
 Xjyg6Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq39x8p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:17:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2df9a4c95fcso4421315ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790349426; x=1790954226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XFKJ/2TrMmtj8j1SLXFpIjBKDvN6+bPnfoVVnrVYt8g=;
 b=TUgCMF8hCmONOOkKKgGAVrOPVq1RNQiWiYzaMZbCM0rPmfCfh491Gcp/romsaQBGZw
 PQ3tW8Nz35dNw3/eB+61Pf1vtp6oNr5te5+Nu3mZaQ3LjiDEd08GJXp4fIIEt9leUJW+
 QPEQWzdtdjh5MKxZOG3enmWhKILA5VEhQoMtU83ehK83wsOoaiDBd9eIs6XZWPHdMVCe
 I+QWTfbyIc4NROTMas/LWzdCTZPpZyAnPAArEWy6xc1zVQlItspS6avK7EhbeMpnEKZu
 zbaRUH8vHf8zD6qD8bqLYVrA2ayrDzUBRcnM1kzm857LWkU4icclVP3r5IvNyCshDVYT
 6X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790349426; x=1790954226;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XFKJ/2TrMmtj8j1SLXFpIjBKDvN6+bPnfoVVnrVYt8g=;
 b=LWNBFOx508w0rxLs2MHs0UeevZPKQQA0DSHIetwQbwWxziyy7+9nwDUFc39baPDvFa
 qxXUQ/8ijEU7IQsN9Op81XBvY16vQnPqhCcpt9tiwv71vTPf/squrif/WCGTkHoc+ODb
 B0SPIzapsg6R1RAwjehjpB9gJSalIwAT9510M2IEqERYZmQySYo3ydE15RClFKGUFqdr
 K4eHhg17AIBOBozvG3BAXtMlxykQgxIO/Yp5T8OGAt5WoGJqVnd85J7PT3XkWQNfg7Zv
 u5EWes6VjxHrUrUWP0nKWEoKZViSb/is4Jx/0avd4k6LoH2KCdqcvmpHwEP8HQthJwUJ
 Mnlg==
X-Gm-Message-State: AFuF++kgOlEUtPhio9ruKKKFDVnHIqGHIOQ5xBOznmf3/NSluOQ0/Raq
 9RUv48P4EpTecnf2fIaoiTHT811kEZDvsoK1gbbJvvW7tTfMfyC7T5eEMI08JEbQfIp5KdRPkO0
 eRQowIbJge+mbmplJGlCCkuCEp9B9NSfrycKLrcK8Spdo7x1O7XedQirNjw==
X-Gm-Gg: AYBFou1/5yPXLz53MsNzel/++6EcWLyrDc31v71FH0V6iR+M43KSGBb8Tw5wqII+CgG
 z4KUU7jv3BJT0PdT2qlWZhTS3QC/uVMv8rNQFQxOQuVgpUmbqv77LpOD2bgwylwIkOGdEyPvfYF
 jYYo3GZCnfD0SRGI4jf/95qi2MaKFsoGKhZpBvuZKoeI4dQ1lRFlU2GTcW20U6/lwKvDJaPfTKV
 8Q8DyNlVY9tAayX/GrCzPwAz9atUitdApuMhZTdqN+SzTqsHDGiYHCELUFyMzolVqu571actYN0
 TAItAQP4UOuSFgnPZFVxN958uwFImozuzSLiWQjSfIgaGGjkf5Wk4TJoNjsUnJayaxFBsuls4G9
 7k7GQp0uaZ8tsHx0geO3d9frjPjcv62HWZiYzBtGCJbpM4BT/GVhJk0UqQDxg4F+iCXE=
X-Received: by 2002:a17:902:f541:b0:2dd:c053:d741 with SMTP id
 d9443c01a7336-2df7dc3829dmr47175295ad.40.1790349425875; 
 Fri, 25 Sep 2026 08:17:05 -0700 (PDT)
X-Received: by 2002:a17:902:f541:b0:2dd:c053:d741 with SMTP id
 d9443c01a7336-2df7dc3829dmr47175025ad.40.1790349425314; 
 Fri, 25 Sep 2026 08:17:05 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df9142a2f9sm13042975ad.48.2026.09.25.08.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 08:17:04 -0700 (PDT)
Message-ID: <b1e1ffe5-a7ce-44be-96ed-b425c15cb10c@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 08:17:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/tcg/meson.build: introduce cc_alt (alternative
 cross compiler)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260924213942.26491-3-pierrick.bouvier@oss.qualcomm.com>
 <arZBMfW-1WcpjNZs@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arZBMfW-1WcpjNZs@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXxHxRCAvgmDr5
 HfEcIO+hSjC0xWgHhbxKEXnxXnPVq934dJ3DnTj/i9UGV2qbGp5YtDg0XxuTj4CW8dlnS3btGzV
 3aT/+EtjsXElOFhsEgUyyluAgES9eqI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXwXHNLubCOFwv
 Dfitp5l3KB5vd2YYcplkMZXxWaL66oJ/5h852s6rRGJ+5J6Thrt3nSEpR3kIBJ2Fp8Okz9TwROE
 Tfty05lyT+uT7IRcs4MdUjmtStf+XESXgph2R8/Adpb17AoCkFD1tgvP3xv9Nq2ZdgvZJPdjz8d
 Oad+dFnHbdHhCRgVQ1HuG3Mkw4QC83qQjolxfzqd31XqHhL0xVGhBzhWIjPzZRPRjGthaTGiHZl
 EEYqbVHSJx3nF/v7Hrp7ypeJ397BAe/YRdC6BuMXDeoe/Ke9zf1QX7hjY2ccVSszCjVy1Qgk9cg
 9JEP7NbQnDboR5XO3lSGqmrP6J9TEanLC53gUSIRbeUktgj+ME/VE7oZbOdwZUR5wnJ39oeYp98
 jekWXArAa6Fbd+0kDo9yaqruYZFErPUHdo1Z1lLA8Jk8aLXCcFVCQ2kpLxRJpUpTjagNhnMdeNq
 5+yn3gaGND3VRT9o1CA==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab69073 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=jMxiaY3KWykQ_qJIs7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: knyDXHCeXz6ojHxf-BMT2QLiItA0y-sH
X-Proofpoint-ORIG-GUID: knyDXHCeXz6ojHxf-BMT2QLiItA0y-sH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250060
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

On 9/25/2026 2:38 AM, Daniel P. Berrangé wrote:
> On Thu, Sep 24, 2026 at 09:39:40PM +0000, Pierrick Bouvier wrote:
>> This allows each target to provide an additional list of cross
>> compilers to check. With this, we can detect default cc for common
>> setups (debian/fedora/macos) without user having to provide a
>> --cross-cc-* option.
>>
>> In addition, it allows us to pick up host compilers for various hosts.
>> (debian and archlinux have $arch-linux-gnu-gcc installed
>> with gcc package by default, but not fedora).
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/tcg/meson.build | 46 +++++++++++++++++++++++++------------------
>>  1 file changed, 27 insertions(+), 19 deletions(-)
>>
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 0006d192cab..59ab73e1d10 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -21,6 +21,7 @@ tcg_tests = {}
>>  # {
>>  #   'name_of_target': {
>>  #     'cc': 'cross_compiler',
>> +#     'cc_alt': ['list of alternative cross compilers', ...]
>>  #     'cc_dockerfile': 'name_of_dockerfile',
>>  #     'cc_feat_cflags': {
>>  #       'name': ['feature cflags'],
>> @@ -210,7 +211,7 @@ foreach target, plan: tcg_tests
>>  
>>    # return a clear error if user misspell a target entry
>>    foreach key, _ : plan
>> -    allowed = ['cc', 'cc_dockerfile', 'cc_feat_cflags',
>> +    allowed = ['cc', 'cc_alt', 'cc_dockerfile', 'cc_feat_cflags',
>>                 'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
>>      if key not in allowed
>>        error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
>> @@ -218,15 +219,18 @@ foreach target, plan: tcg_tests
>>      endif
>>    endforeach
>>  
>> -  cc = find_program(plan['cc'], required : false)
>> +  cc_list = [plan['cc']]
>> +  if 'cc_alt' in plan
>> +    cc_list += plan['cc_alt']
>> +  endif
> 
> If you're combining these into a list anyway, why not just
> have 'cc' be a list of CC names to begin with and not bother
> with a separate 'cc_alt' field ?
> 

It's just a semantic choice, since cc has to be provided in docker
container, while cc_alt do not. I can add a comment if it makes sense
for you with this explanation.

> With regards,
> Daniel


