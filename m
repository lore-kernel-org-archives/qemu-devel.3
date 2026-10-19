Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CA606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eREfo3kr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cw12v8tk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIu1n-0001Xf-VP; Mon, 19 Oct 2026 16:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIu1m-0001XX-KY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:32:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIu1k-0001Sm-EM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:32:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJsbK3474929
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 20:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8kjV6oEbyxu3B31BgYVNy6XSMMklbjL7HJiwBwDRecw=; b=eREfo3krQpITdQ0w
 ho9v1S3W6z17FLDV+y8K8Nk+UBbHJIVYO9c5EoH5AafUi8ppOJ0wDFhuA2vPJSlf
 tLg68Ea+noKYzh1VcKDr/m43H+O2EXQHfAwOq7ckWBV2LKNi/IkjllB9VOm214g0
 UQpjzq4U4ObhKbSw6GAi4Qqit8CUChhRl+2TBuACbxKyMoVjDoQ+4KwI3d/qNK1T
 ClX5uuhtfGGc4l+vk8q3+F3AXdXYedG7Z4vj8Y8tqBzYil88NHGfPTs5rWeDwL3G
 RqFtwDAG1nPPkZYX9ptrES4TThWVG83yce0RmwNDbz64H8IkDmyiu1S1fI5a59VV
 KhNhEQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdqtf8n03-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 20:32:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5212836eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792441930; x=1793046730; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8kjV6oEbyxu3B31BgYVNy6XSMMklbjL7HJiwBwDRecw=;
 b=Cw12v8tkUQF8Cjb8kE1WT3ppJNTB9gLnBUDAgAyIOsasrBItwteF2Fng1vN4iUk8kI
 +gx+MMnSXDHLvklZbNd0bIB3LKP/VdqfY+4M/p9KEEEL9ZjMrk6fwtBFI3142xe3a89c
 nLKjYrW1Ec1lWYveajR4tlR6YGxMZHN2reMWfX62hmSLQO6NJWECpRqyJNjGTuYhsF4P
 qArrp4OKu5XQMcYj7RqCwiy4codb5Td3GfPvIKQjBuP/LP2Ma6in+n9icrfZLZDb4MhD
 Rti2fbuf6CO1jXLb9gQ25S8q3BCp1htOlEWZSl+pQV9EKifkHqy94I+lljT+8RHBZBGX
 Hb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441930; x=1793046730;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8kjV6oEbyxu3B31BgYVNy6XSMMklbjL7HJiwBwDRecw=;
 b=AsC2ohGooFoHqR6qul3NzI+t/cNhwXG7Upu8TtyWLL7OuAORbSquFmzo1Ur6KdAI91
 XNgCvCRSUGyMGw+IPaDa/AcciKym7LndpNnt2O41+BT68j5d3S7zjcmqOJlEDren7hJy
 FsskfCiiS3+OwORKWSAe3lOnYbTzuYxkaSGZtv9D4F/R45Xmxq2sJVMZrBrp0c9LyMZi
 5+Zt9PuuCHzoqeLQooFZAkplN//R9+Oqo9yVqxxobgkA1W0h2TUu/XUT9KdvJJ0ZCmQG
 sdUso5PrZy4tuOyvLtutDPVRKt9/XlNkZMhMfZqgZGa5jmkSLG8Hv8jFo6HLCeVzFSEN
 8SEA==
X-Gm-Message-State: AFq9FYKgHxzJBEUQWanR/OCfzQCpDGT7zWsN21f7p1Pf+6yKb+yKG/tG
 zq6Y1u1Reu6JRjQMBK2zy9C4z6Cy1/nY5jcrA4C4khBUxuuYGXmbcAyjznorXhapyacHEg8Uq50
 /bjO+zY8Kd9u175brh4H9ENaKSsxphcmX8V6+bar0sc+jKwJBVFmzySOSiA==
X-Gm-Gg: AYBFou2WV7kqp1aQ02pR2aazx1q6BIOH83ajItpyWqTkwg2POU9ukve72ZKzpB2WgAW
 TQUhtXNBzyXoEoS6OhRV8Y5LSZh0nkHuYOii2gOij+iTvac0Ekxg/s12edwXjyzTwiuJwWSY2JI
 5UhvsaFBRwu690nRwyeDwThCSRQ+nMAoqT5AcevWHJ25EcQBPP+62HFCfm1ox6tVv6RoUrhdQZE
 7XJNdzkgYHzeGcJoIV44LhuK3UY7v+ydWMk+eI+UF/IK3uarsd303NbZG+FrcbFVnuJogqst2BJ
 uMZspPXZ0ZpbtIcTS07gyFi782NAmFvomLFp2jl79V2FgyJ6guHcSGv44lzud49R04sRMLcgDJI
 Q5RqpCNsa9fyQx7icq35KA/v2GroxcHptD+nq0FEn1t6JfXGstfVape2eUSPZhSXpJObFvw==
X-Received: by 2002:a05:693c:821c:b0:35f:5591:e40c with SMTP id
 5a478bee46e88-361a195ad4cmr11786456eec.22.1792441929621; 
 Mon, 19 Oct 2026 13:32:09 -0700 (PDT)
X-Received: by 2002:a05:693c:821c:b0:35f:5591:e40c with SMTP id
 5a478bee46e88-361a195ad4cmr11786400eec.22.1792441928792; 
 Mon, 19 Oct 2026 13:32:08 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082b8573dsm34521495eec.25.2026.10.19.13.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 13:32:08 -0700 (PDT)
Message-ID: <82425214-d5df-49d5-aee0-ff0f9fe7ef45@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:32:06 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/tcg/ppc64: Run float_conv* against power8
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019185600.2031729-1-farman@linux.ibm.com>
 <20261019185600.2031729-3-farman@linux.ibm.com>
 <cee46a83-aec3-4725-acaf-e52d16e327a5@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cee46a83-aec3-4725-acaf-e52d16e327a5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SpEFe/O0 c=1 sm=1 tr=0 ts=6ad67e4a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=4PYtp0kt8oKGRJpOdj4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4MSBTYWx0ZWRfX2H5R9qHsiH4S
 8KT1nCAt1PrkiQQ/8szi52bSfDE3taZfAakWKTfbVSfl1lbaENbOmDV+YeeQ/TyyyzNvn7luCty
 V3zMI7BtIJC3F0tnLjfYIzlfIrKSlTSU9JUKKiWg/ZBgCinNda7uYUFreQBvDsYzEb/E6IdMkNK
 V8dfyg84BD5FR3R/q/f13zctJ3gWeWj4iuFkk1zlqYlxXok0xHCFpjdfrJ/bpaSN5h6g7pePMwV
 E/HSQi3VvNTVRh0Q/Xz7HaUPV1+mwYmd2Rr+ZCt7YNIdYFfIPpHpRGQdOlb2npyS0TOoi1cN/QZ
 bA0vKop0n3n2RopTyMKrq8/iMvG2A5FdUD86ce7DnKZm0VWR7G+eJNtf0QE6PgdFkV7KO/q+1bf
 Xh5IVbBxKQm5+gnglN5DXkSXQX5C0y/8a4xN1jdCk4V1zUt+kXD/NdKZCpssA40JeDt2V6pwFCO
 LUWL+H5Q+Sk2Kn2rqzg==
X-Proofpoint-GUID: lyBtQTpVqZet-JhWUwLKerwFp7h65zef
X-Proofpoint-ORIG-GUID: lyBtQTpVqZet-JhWUwLKerwFp7h65zef
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4MSBTYWx0ZWRfX6zC5Xoh5sdvH
 WVSi6p5KYq/kesSV6/E4C078Uve2sQxWRgbvBShemHW08lhHdjY5by2j7M1Y6dF6ru+0rUAcvC0
 drSw6qAzACAuhmDKzoJh22wPH6n246U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190081
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 1:29 PM, Pierrick Bouvier wrote:
> On 10/19/2026 11:56 AM, Eric Farman wrote:
>> There is an oddity that turns up with the float_convd and float_convs
>> tests, when running from different toolchains. As one example, the
>> expectation at the start of tests/tcg/ppc64/float_conv*.ref is:
>>
>>   ### Rounding to nearest
>>   from double: f64(nan:0x007ff4000000000000)
>>     to single: f32(nan:0x7fe00000) (INVALID)
>>      to int32: -2147483648 (INVALID)
>>      to int64: -9223372036854775808 (INVALID)
>>     to uint32: 0 (INVALID)
>>     to uint64: -9223372036854775808 (INVALID)
>>
>> But, other hosts offer a different response, e.g., this debian guest
>> on my laptop:
>>
>>   ### Rounding to nearest
>>   from double: f64(nan:0x007ff4000000000000)
>>     to single: f32(nan:0x7fe00000) (INVALID)
>>      to int32: -2147483648 (INVALID)
>>      to int64: -9223372036854775808 (INVALID)
>>     to uint32: 0 (INVALID)
>>     to uint64: 0 (INVALID)
>>
>> The explanation seems to be a behavior change when compiling to different
>> versions of power hardware. When building the arguments from the multiarch
>> directory, let's ensure these float tests offer a deterministic response
>> to these NaN tests by explicitly binding them to a CPU architecture.
>>
>> Chose power8 for no real reason. This behavior change appears between
>> power6 and power7, but other tests that rely on a specific architecture
>> today pick either power8 or power10.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>  tests/tcg/ppc64/float_convd.ref | 144 ++++++++++++++++----------------
>>  tests/tcg/ppc64/float_convs.ref |  80 +++++++++---------
>>  tests/tcg/ppc64/meson.build     |   6 ++
>>  3 files changed, 118 insertions(+), 112 deletions(-)
>>
> 
> Thanks for the update Eric,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> I'll let you pull this as part of ppc64 subsystem.

Checking MAINTAINERS, I noticed you are working more on s390x side, and
not ppc (I've been misled by @ibm.com). If I can help by pulling the
series as part of tcg tests, let me know, and I'll send it on Thursday.

Regards,
Pierrick

