Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343D0CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkj0-0000B1-MB; Wed, 20 May 2026 13:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPkiy-000092-Ue
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:28:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPkix-00053Q-4F
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:28:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6dNp119200
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 17:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D13+H1Mp8EzFCXQrk+X7Aj1vLCKqh4Kh6v6xM18ydlw=; b=CUve9bU6ZOMbRGei
 vn8H3XsyTzqG/w9dx+/awQQp6uTkGx88vJmuz7BQFTGSBkDe3l5mbTOe3uyZorJ9
 6w8OZUxHJbgKeLcCzt9IAiU5O+uYnnunGf/9pRwW6rdSwA1baon5ph+sVCyMVn5P
 9vGzdlMVimk4ClDlxXpwKd0ZoAEdBUarKPt1kBLpKF6Clw17TU2OGFiC+oBIJ9W/
 RHIwly/DbNzP0OPo7j434SQPKiQTRBFRVG2f1FeWSgheU/GEO2tyDU9qSAC+pGI3
 8TZ23JBWk4SWFwR7ICIz80OKm0Q0pQRajbA5NpTwX/fBqsN7DcYfSiMnVta32rth
 n4AXgw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee890en-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 17:28:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso6315793eec.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779298128; x=1779902928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D13+H1Mp8EzFCXQrk+X7Aj1vLCKqh4Kh6v6xM18ydlw=;
 b=U5QwxnyQ29v5RRL68/jzU1e8RS5iOuVNWRcFEIvKXedvkgGIyVzIEnVNDEfoM41i9M
 TosgFebKWR7Ua2fJ/1h/fcw9Na4yvkZ2U73A4fXv/5Csg8fAZBq/QystKFg7DSYUZTgy
 /AD/4UxlpziQnRBJHT6w2aMMWRU0VpivOhdbJAD+8+VzlaYRUOIC6nt6U/b5Ozaq1q9z
 eABZXtNS0QVO8LgztxubemroeKxdQ4OoJPjQIgGr78raLbonTtqSX4h/6r9BFaCJ2DLE
 OVO+8FB9xawtK7rlvpfQK3daBroN7cLuqP/p1eWfMwtoYLENRxhrN6ApgLIHPkT/lofI
 gyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298128; x=1779902928;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D13+H1Mp8EzFCXQrk+X7Aj1vLCKqh4Kh6v6xM18ydlw=;
 b=h216kkc+42glmOY65lC1LspZtjdwEABbKgsxcFT0TQNoIXLFJ57jPVQwrcd2oHFcdu
 RmKawy8Clo76OwFqtyw2flqgVshCG+XZWOuj0FmZGK1pffgyDO5jiVnNa5tmYElokbsC
 UINza7kVOaxJ2rRV01ZatlQq4ZxXqtVZX3r6ogC3x+ayYCMmgNVFBdlHR8dY9RIE/k10
 RyYel23ChO8wjZd0utWgaBmNsmnGUpzU23OzVXX/bpe63I3oqRgkM8m+Oj6IOKhF+fTl
 zOjUhEjZkHWnoEMQDgQmwiHLz9MiUw6fQCOf6ay6M4TV3cHmoTMMIL3MMttUw9Lyt6Uk
 /1WQ==
X-Gm-Message-State: AOJu0YwpOKczzrzyKxdtaXKegDHnnbB5aMIub2n0ec9bAYmV4YhDOJeP
 6YaeLi6Bsgu956Wb1TGKfRiOglc9jMme5OM9hcJcGKLsI00uaz06VH6WKS9OWKNMIxf/+Y91Bkf
 iSjM3NFvMCU27VWDrNguoLfaybYTNlkrZc2NommzEqNcj08IqXL0khn0OzA==
X-Gm-Gg: Acq92OFD5FXm8OQBs3k6+FT4uNkamfPid7DbEnFayvsqe3MbqvQQ8CU6X+mJUtCnqBk
 vUlXWT2AjGr06vn3ocxv+wJ/LHcS49R9G9VCIKYcTurpmWKRdo3nyb2sB8RA2ArRhqtXU0bS1d+
 S/Y9Lf3rXndyVg7f1hB2YCK8k1nlArUfH2fOyFNSctCBcVaceFtVGKiKuIqUyTiUOZZK+hLkCQW
 i3EyEDS/Lwd2C4bVF1Ad42LG/bjy4a9xDT2jUTFoaSAgJoSLu7CxfLUSvFmaU7r3hzzR++xug0b
 clrR/k2RoN4NYbuCJvW2TKzr3QunQn3EPWcadq3DvR96A1ERG9PG4DzRiC6vBUvRqEcDLe0FeYW
 eIw2NjmmK7cyBecrnlYtrygkNTLzGDYtJu4w506dfgyKNuulBHqACkYAWXKNQjpoSAQ==
X-Received: by 2002:a05:7300:818b:b0:2be:7885:31df with SMTP id
 5a478bee46e88-30398618b3fmr12871926eec.17.1779298128449; 
 Wed, 20 May 2026 10:28:48 -0700 (PDT)
X-Received: by 2002:a05:7300:818b:b0:2be:7885:31df with SMTP id
 5a478bee46e88-30398618b3fmr12871911eec.17.1779298127898; 
 Wed, 20 May 2026 10:28:47 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6adsm21929484eec.15.2026.05.20.10.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:28:47 -0700 (PDT)
Message-ID: <114b06cc-c6a0-4d09-89ae-f23b45965f19@oss.qualcomm.com>
Date: Wed, 20 May 2026 12:28:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260520123947.12711-1-philmd@linaro.org>
 <87fr3ms0oi.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87fr3ms0oi.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: D8OD8Ebauqj323b_fcr76RTwkwhL28LU
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0def51 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=I7ceL_pRgTA7RbhvOF0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3MCBTYWx0ZWRfX+b8CHK6afpHg
 ZZpJkonn8WIsHTjTZ28JkirQp5p4ZbGBq2hsnDgAM9RnPfls/8/IeBOjw2OfhzAYuZyEjXR5ku3
 zadZBqX6xwUzU0xX2WGszdm/ic8ubqLfEYibS9RhCLvgdJmt2k6Vf2iRR5iKlOUQ1uELyo5LAW1
 C1upsdVAf9Wlprz2KaW6pjPHALhjdIjlC10gx1mVjmP00eDvHfG3hv8Y3z4F6ETbqVhUQLNNhnk
 eCvAnZ02eXAWxsh+jtIYLtns4b8DBQsN7NjkK1TOv+KPRr7BHXd1irrADuO6MepU4g24lTOoNhF
 wU/ScduXKQj9OqefH/qJePs8Z7ZdmSA3b7/UJUxbyIq6n0n+vcTybChn7SbaVemvqYNx84s1a94
 2rgcVT3kIzDMQm8D+qXEelRsxXYPA6uwr+B6PsLNqs5aiXoHKMBe3xt0U3cdiXzAWjS800Y+KPb
 YUMlj57GAEowGozV+vA==
X-Proofpoint-GUID: D8OD8Ebauqj323b_fcr76RTwkwhL28LU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200170
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

On 5/20/2026 7:52 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reorganise")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b75f3222f2f..2a4d124fb3c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -256,7 +256,7 @@ X: target/hexagon/gen_idef_parser_funcs.py
>>  F: linux-user/hexagon/
>>  F: tests/tcg/hexagon/
>>  F: disas/hexagon.c
>> -F: configs/targets/hexagon-linux-user/default.mak
>> +F: configs/targets/hexagon-linux-user.mak
>>  F: docker/dockerfiles/debian-hexagon-cross.docker
> 
> This one's wrong, too.
> 
> I have an unsent patch fixing both.  In fact, I have an unsent series
> fixing *all* F: patterns that don't resolve to any file.
>

I planned to take a look at this, and would be happy to review yours.
Any chance you have a script that we could integrate directly into our
meson.build? (I feel it's better than checkpatch, since checkpatch is
not blocking anything CI wise).

This way, any time a project is configured (not built, configured), it
would trigger a check. Since every file removal/adding implies a
meson.build modification, it should keep the MAINTAINERS file consistent
by design.

>>  F: gdbstub/gdb-xml/hexagon*.xml
>>  T: git https://github.com/quic/qemu.git hex-next
> 


