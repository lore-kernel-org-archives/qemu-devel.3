Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D81BC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9qWb-0002Ib-Ur; Thu, 24 Sep 2026 16:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9qWZ-0002Ft-7Z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:58:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9qWW-0005t3-P9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:58:34 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdipx2996402
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 20:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j3XYzw3tCYghNRi9XHu5Lm3JdqFR7uQL5iiWwC9CYXY=; b=X+PPaP9dAGh2QWBV
 96g1M/S5V7mOmijGHBZR2nejYamRY7fh7F06/VDwgBQotAwmb4cPDWjn+nZOKtdv
 EynWuJvvH8c7ZWLaHJEOobxf9YU6P3ZrYIbecxKTJGtWtzHvr56QeNLsByBwEgKq
 AfIpy5aGIP7Po9y5qPP6yOugTrxcVQ2JkEUzGprHu++zXAvBY99xs+PZ83SLrryi
 kL4YocahoB2yMPbqFgXbMqebs1T9vbG3q5zHnr406xsX4qpltt0+JQ+WKbJ8e9sf
 be9/uFktEIKgxCxg7T7noNS76Q+yDrdcH2aWhHsuym0nFC8JBZnf1cbCb0QOKfbX
 NFVhdg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw465214q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 20:58:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so185816a91.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790283507; x=1790888307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j3XYzw3tCYghNRi9XHu5Lm3JdqFR7uQL5iiWwC9CYXY=;
 b=PVRTKgYNqq8bbEn16hbiHwUZfAoMAUTIzmquh96oaGTaYLlMmsyr/jKbCB3RoX+/px
 osqtsMaQyeFu4XzCyN7dbbMXz5EBbrEROrK1uLxKDaf7sH5PvLv51rRQsN9m2bdeQADb
 EbDwqsraWGdC1g3pnCZRfaDcDYcl+p/JwmAwR79WZKheWRmDxuZxBl2AgMrYn2Xyk2fx
 i44eyddnWWkCA0YSz3skh7OS4Ggb8WZHL+NGt0jK2ftuCIZCdQC8G0cb+jAa++r6ybGd
 GPv3975wZKNlRYE9m7WCBQf/OqeINH95xwJh00qoDxJ6ID22/FN0knEy1rB510ui5whz
 NJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790283507; x=1790888307;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j3XYzw3tCYghNRi9XHu5Lm3JdqFR7uQL5iiWwC9CYXY=;
 b=Bw8kKJNK/OYQeogBhCCVw9Gwt3T5DbeOUbUdaPrxdOb0JwFK+0X6jUSlM8s85otqFO
 muPxt7AGXplvrce/EsJe0T7YaKd8c3bRBWgkgh6r1MRdWlN9hP7eQEf3h/4bZByZc/h2
 oLphuBBF40YnhObRieUH61uakuwYtCz5rnnDnNhCTBX+ZzOSsHDQHgnMMRHfOOjRbuR7
 DeF6OCeWB+U0tU31b6F5hOiWC+dm4A6fah/rIt9wvuxzHqRypM8MiHpn0m5mEzHvZvob
 22KTkDS+XCa20EYs4eYAPXtFpjRmUKyVdl4icUz+rwtpswnGfJIknD1kpyziSLQt1xcN
 sDzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4jexjb4+JkIYg6iVoNIX21nbUS6bczDVWKa4OrBUYgWDQf7/ncuSy21YvGVc8zmv5PQnY//HPUXAA@nongnu.org
X-Gm-Message-State: AFuF++l32PGfVJaf49IlDtuIV4W62GtEewbckElqnBXK+TGYOoFOn1qQ
 srgViEfDitI+GBAaRJHwA0UeLnydsgjksnt7HbvuY7FBi61BSh90fK8it+LkfKPYAIPNKSwhV0F
 Svv3un65VIRcacFqAnV7iUFutK0oJIcxeVJ+Yj7Ndquj4rO0hB8oYmA3jZQ==
X-Gm-Gg: AYBFou2AWvkeyZlm1A9u52jwo7ptCWENhQ0+wAG9KILTiGgIUzLWPQOF08PAnbBZ7FM
 sDcqtPV7eY4zhJPzWZtCV1X4yrdbeqbEb6uSKco4wDXLseaPtR83QWIyfcZdQVnc0k8QNOxRuWN
 qkZNmc0gbkf5LeKeiNTYcqaYLHW0ezfk9SRk0KwKZmHO26tN/ZxZW3liC7TIUhUEvMJdTLa/Mlf
 NYYfhwQj1zga0IC8snUkMEdh63dGwUvX4YCiIIr0lf8yIk4bIb2EH4yFHByDLhhkH4IwayNwG3A
 FkcptfTKDZULUZksYRR/WPHomW3E+Y1GmAFPT3QVlZ0qeQyJ0SDCy955ZOC3Qh3hY5sLPHpErD5
 GigF8xAIIK0cgivafdxhZ8Apuy4rwESkNJ9J0kKct87gcX2xHHTr5/gKxKEQNOBUXQ4g=
X-Received: by 2002:a17:90b:2e50:b0:39e:6a81:5a97 with SMTP id
 98e67ed59e1d1-3a098e3e987mr3316041a91.43.1790283506722; 
 Thu, 24 Sep 2026 13:58:26 -0700 (PDT)
X-Received: by 2002:a17:90b:2e50:b0:39e:6a81:5a97 with SMTP id
 98e67ed59e1d1-3a098e3e987mr3316025a91.43.1790283506259; 
 Thu, 24 Sep 2026 13:58:26 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0974ec5c4sm6415506a91.5.2026.09.24.13.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 13:58:25 -0700 (PDT)
Message-ID: <8c6a20b8-8e61-4a89-8d80-61931de94708@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 13:58:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/meson.build: compile test with
 -fno-stack-protector by default
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260924202012.2465-1-pierrick.bouvier@oss.qualcomm.com>
 <018A9A4D-629A-4849-8654-F23944AE6E4E@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <018A9A4D-629A-4849-8654-F23944AE6E4E@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab58ef3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=WMzZgty7qj21bDrsTmcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 7_loO8kp-g_QR2_xHAlv8Uh1gMCC7nG5
X-Proofpoint-GUID: 7_loO8kp-g_QR2_xHAlv8Uh1gMCC7nG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NSBTYWx0ZWRfX8IZF8WXiogml
 hoZA4AcwicectdSnxb4DLEQAjApvW1xFz7+K72KX1odMCdJoQmOkvtq7EveuTAaJtl6YCv//CY7
 Vfm5fr9w357N/9zLWjTyw14GIBLeQVCL1gciWpbBxCc606AgQJBMTdxfRbd8fwuk1XJdtbpSjvM
 lX9PeZuzEshHnpwZOYuTVtt9gDcmlG9JS2KGsz8mZavM7l/XXv0+sQeN4VtSHnor6By4gU11WJR
 zuo0mT8McTluDcb32kaFv/hzxvABS026GQyHtz6rLI4lBNqtTx4i0A5mcpCTBhzGzQsP09JJKBK
 1UI4RhLQBBh4fyjdQHTPeFhHoVSxX9OlTqMMmVMuxlN1Pv1thBF7G22i0+oE+6V4UKdN75u/jPv
 ZLRIQx8YjFXQzz5CBRXB/HZiSXXSCW9n5h8i3My1YV9/7469wl6KqreLTIDcpvv+3CXIyMNu8uH
 8rDA8q1zg6/GMqalioQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NSBTYWx0ZWRfXwESSypfOpzMp
 Mg1dnvad2a93uVEoBifRx+9N328ngqzNqQPiFcBVlopWXRy9imGtKkZU+Wq+t1ds/W1bwUIstUN
 EoGMqgkvtdYB/1YFZDLNifwt5WEZJws=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240085
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

On 9/24/2026 1:43 PM, Bernhard Beschow wrote:
> 
> 
> Am 24. September 2026 20:20:12 UTC schrieb Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>:
>> Some compilers enable stack protection by default (for instance, on
>> archlinux). This produce a compilation error on some of our tests:
>>
>> /usr/sbin/x86_64-linux-gnu-gcc tests/tcg/multiarch/system/interrupt.c -o tests/tcg/x86_64-softmmu-interrupt.test -static -MMD -MF tests/tcg/x86_64-softmmu-interrupt.d -Wall -Werror -O0 -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I tests/tcg/x86_64/system/../../minilib tests/tcg/x86_64/system/../../minilib/printf.c ../tests/tcg/x86_64/system/boot.S -Wl,-T ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64 -Wl,--no-warn-rwx-segments -Wl,--build-id=none -lgcc
>> /usr/bin/ld: /tmp/ccs11W6S.o: in function `print_num':
>> tests/tcg/x86_64/system/../../minilib/printf.c:45:(.text+0xec): undefined reference to `__stack_chk_fail'
>> /usr/bin/ld: /tmp/ccs11W6S.o: in function `ml_printf':
>> tests/tcg/x86_64/system/../../minilib/printf.c:136:(.text+0x549): undefined reference to `__stack_chk_fail'
>> collect2: error: ld returned 1 exit status
>>
>> This flag has been previously added, but was removed when moving tcg
>> tests to meson, with the goal to identify which systems require it.
>> https://gitlab.com/qemu-project/qemu/-/commit/580731dcc87eb27a2b0dc20ec331f1ce51864c97
>> One of these system is archlinux.
>>
>> Thus, disable stack protection by default. It has no impact on tests
>> results.
> 
> Thanks for providing the working patch so blazingly fast!
> 
> Tested-by: Bernhard Beschow <shentey@gmail.com>
>

I'll pull it tomorrow with other series on tcg-tests 👍

>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>> tests/tcg/meson.build | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 75f0a52fd22..35b3dff4ef2 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -426,6 +426,12 @@ foreach target, plan: tcg_tests
>>                                       '-MMD', '-MF', '@DEPFILE@',
>>                                       '-Wall', '-Werror',
>>                                       '-O0', '-g', '-fno-strict-aliasing',
>> +                                      # Some host compilers (like archlinux)
>> +                                      # have stack protection enabled by default.
>> +                                      # This results in a linking error for some
>> +                                      # of our tests due to missing symbol
>> +                                      # __stack_chk_fail. Thus, disable it.
>> +                                      '-fno-stack-protector',
>>                                       cflags],
>>                             depfile: exe_name + '.d',
>>                             output: exe_name + '.test',


