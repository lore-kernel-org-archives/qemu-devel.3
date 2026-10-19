Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC88C606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K7UPEjuo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CzJMm/w2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvta-0008Em-3y; Mon, 19 Oct 2026 18:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvtX-0008EZ-Sb
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:31:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvtV-0003Kp-DS
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:31:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZQRE792179
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /gZWa4lM3XuNKi3ktTo6zzU7iPdEB8ySX1gXKFoHvXU=; b=K7UPEjuoougyH94L
 lkY27N9MbS1ErPaufDH5ymAnkzCDk7YxZLa0r8Cr1AVu0KQjiX1RHieQ5CE86AOs
 d97EZKVestJVKdAxkLXpc7aABwB+oRsdkPQHH6Gji1ZkcDbKce/YhdvU1wvguw6/
 IvvIAfvgru/tCqKaleGqcMifFtlk51nYVhSSfGm+SzOyutMkO3fz14gBdwNxb5I+
 +WbZo8ndXNrlVOKGujEuWqDTON5BWo3g+AqIVcLP55Gpw74UzoHkb6XzsqJLuftW
 vUlO6hZRMXQXSreViAGK26298Yfl46/UuYWS//awhjjiWzok8QPR7fu0ihPIspmo
 mOEhWQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3fbh6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:31:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91becce058aso53745096d6.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449106; x=1793053906; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/gZWa4lM3XuNKi3ktTo6zzU7iPdEB8ySX1gXKFoHvXU=;
 b=CzJMm/w2FqMlvHN3av5t7kLi0pbr2SuWOoSayfiYi35lz6wmqJEh1T9ND0GFbgplB3
 Yc8qJLzM3Z2YkkTVqNX6cAeGgUZg2TqJT5mVZemLdI3Nz/PW8NpWG8xspyIlwh3JODNK
 i+TC8M7UAVTYzJd390ZpE0k0fAfwLsO+bUVYM2KYjrc9ukc/nkYe9JeqSCHrF5EQON7U
 5uphwri5pl8w2int8qVbnSea5P3taHIiGTyR6i5+kiWDBM51ox8P0U7kUD4OEItQrj5O
 Fn4xbvXqEJT8fa5qQitnfF1NiKAcNu1gNFIOWhDexv3UD/wrqh76Ka/h3c+C9vbwldjG
 uUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449106; x=1793053906;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/gZWa4lM3XuNKi3ktTo6zzU7iPdEB8ySX1gXKFoHvXU=;
 b=z1HpqPAED0vaRFP3eoIBfiCnVA8ZsIX9CtK4eaG685JTHeOpShjwgEX6k0oeTHPaDs
 83CLkk3z7b+z4pUARCc1Uq5Lnh33e9f8FiD01YyGNLBJrDZbecH7ImwjxCI53GmpHRHs
 BjFR3rWWE87hQlw14fKe0Kddm0Q2AfQRy4dv5VKSA/jKqvi6x/CSY9OkRuYmNT/qPUqV
 +svOFH+4R1ZGidhM0HfuRihDInz/yWJ6flaUKZtSOV2kpiNQzLyWs3ln4vfAqKCAnoen
 TiRJZJL+sVeuGcBaOIaZrKtcIQ6HX9XJfQXlAee+Bp3HPYwnfpX7pRQBoM+bP1M2QkK8
 2vfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBySNIrwuUu8vfDnWRRm5fYca2BvEKuLQG6c4R5FeqiOxJlm3gmskXjg+oyTIB52Y5rpYwyEY6TQFmeb@nongnu.org
X-Gm-Message-State: AFq9FYJqyk9XEGkkyV+5cPioxjhDoU5tD8QRMhcpNFThf0xCOq7HdCAM
 o7SDvyKre+hJK4NgSKiVSWyXpLRWybLJPnhXLJE8cHR5VMa+JvvP/iijRbip8MK7bAYenB2aKov
 dTVKIaMVoaiDWTEkglt5wNf98VVpF5YRxVbJrx7RZCF0rS8VAUYmGdxVm8w==
X-Gm-Gg: AYBFou1+GfRZaVvcwC5r5APJtwbk0i+8lIOQWG3h6ihJe7/PGuN9B1I7rfaxZohKLW/
 FL+5XtVe5uQQdEpoWBLi61bGW+BoxdYA/Y8nOkBFEhkFix/FUt8pVfWkYtzNHzHT8yt9f7y5sYh
 QAICiNxbLw9vod9vKKmvQ6G03zKbLFYOV/nlcMmhnv54JPC8SdwppboHOElciSf6u9RJZeEsoKV
 zCCoxOfEbhT7rB9eTRUBs22hJfmLn2pmUvy8d29KWZHXaBgx5CyBwdbfnzANf0oeUEEygN2Ltld
 bhkmB3AmrlnjUudjw7T2N955g7I//6q4KUaGHf+wK15mNxdDO3eEzTlcYnBwgvQzHVlLrJ604pv
 s63KeVCxPxrzlianLADhujUPSx2ESuFYt0KLC81oKPW95kfx4oig8cicsSqYwChHsFxGVh8pNt3
 HICXY=
X-Received: by 2002:a05:620a:6492:b0:93f:3829:848a with SMTP id
 af79cd13be357-93f382986damr927141485a.40.1792449105928; 
 Mon, 19 Oct 2026 15:31:45 -0700 (PDT)
X-Received: by 2002:a05:620a:6492:b0:93f:3829:848a with SMTP id
 af79cd13be357-93f382986damr927138185a.40.1792449105319; 
 Mon, 19 Oct 2026 15:31:45 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c0405ec3fsm8268496d6.7.2026.10.19.15.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:31:44 -0700 (PDT)
Message-ID: <94d323e4-dbb5-46af-b73e-6323d8c6405a@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:31:43 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: assert qfloat shift
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20261019153558.2422277-1-brian.cain@oss.qualcomm.com>
 <20261019153558.2422277-2-brian.cain@oss.qualcomm.com>
 <667ed637-cb4e-46b4-878d-5a1571542750@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <667ed637-cb4e-46b4-878d-5a1571542750@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yFHAYW8sskZZB2E6ECAmiNmfTldilVuX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX3HxASlik0DSP
 QHo7RUFSXZ++/zIXyoLsGzoMkOFA+AZ+Uq0MXzeYTaWELCPjDx8w2tdKaf9c3SHbm2bNBn9OGIl
 WfYQN0xU2RzTgxTkPlBJ8I08FNxkzSeYXcK2Czo8o3t8KakDALcXVJqUvknGEyRWGKC9wz2ngzs
 IT2ca9TgK1D++agbcNxj2mXcny9YBo1z66NFrIoVdgHRbAcSx/vS6RT+iwLFvO3zopVpWs4Jhfg
 wxD5wvp3aER4L6t5MfVu56FpenhqCVhwP2BNfMN7pA8kfuGOZiRLrd5vRqE2xyrjIoilI7PAnjO
 ij9qgUEqUNBhrmqt8o9DYQ3vAQDVBaQYyTJVeO6VZZ3aaXNf9yvSyyk4ZQ1EERqJm63I7Kdbw5G
 wsYhPmwm/7gHZkCs449k8lTdzhev0HJx0j9B1ZZNlxqRWLz3Z95IZjBebA14CbhuFwsshAHtccY
 Mc688a+gdy8ysdZVxvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfXwM3xmQ27ZINP
 3RAqGNy8vjNhp/42Hd6pAkPsgho6n6YogEl+OE/W5Y43siQ4P8GPqqSDcdzVr+2OOFz6ytb2gfm
 /celCx1qIyP449pgHa0QErOECv4UfDw=
X-Proofpoint-GUID: yFHAYW8sskZZB2E6ECAmiNmfTldilVuX
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad69a53 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rrOLSYwCUoWMPKGF2ZAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 10/19/2026 4:34 PM, Pierrick Bouvier wrote:
> On 10/19/2026 8:35 AM, Brian Cain wrote:
>> The midpoint rounding thresholds shift by "shift - 3", which Coverity flagged
>> as potential undefined behavior.
>>
>> The legacy add and multiply paths select exp such that the normalized result
>> is at most one bit above it. With the largest legacy fraction width of 23 bits,
>> shift is at least 41.  We can safely assert this here.
>>
> I'm not sure how to interpret this part. If the absolute minimum of
> shift it 41, then assert could be >= 41 directly?

Yeah: I was focused more on the coverity finding than applying the right 
fix.  I'll change it to 41.


>
>> Link: https://lore.kernel.org/qemu-devel/CAFEAcA_WJ-PYCfiiu44uTQiDoc58_9Ky3uEd-9g14nPgDPT__g@mail.gmail.com/
>> Fixes: 2633da1e127f ("target/hexagon: add the QFloat logic")
>> Resolves: Coverity CID 1688240
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/mmvec/hvx_qfloat.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/hexagon/mmvec/hvx_qfloat.c b/target/hexagon/mmvec/hvx_qfloat.c
>> index 41cc827aa87..afbcb114ca0 100644
>> --- a/target/hexagon/mmvec/hvx_qfloat.c
>> +++ b/target/hexagon/mmvec/hvx_qfloat.c
>> @@ -721,6 +721,11 @@ static int64_t legacy_round_n(FloatParts64 parts, int exp, int frac, int adj,
>>       }
>>   
>>       if (midpoint) {
>> +        /*
>> +         * The legacy add/multiply result is at most one bit above exp,
>> +         * making shift at least 41.
>> +         */
>> +        g_assert(shift >= 3);
>>           threshold = UINT64_C(3) << (shift - 3);
>>           if (low <= threshold) {
>>               return base + 1;

