Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57B606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gJGj1l8k;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kO3QKzyV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3lq-0004IT-Ru; Mon, 16 Nov 2026 15:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3lm-0004I0-Uz
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:57:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3ll-0008Si-Ia
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:57:42 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfN323248812
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TPfzgzv3gPVO5yZAz8YWFIBT5BT2k2lVQWMR5TPzQJ8=; b=gJGj1l8kVoHVjW0W
 fdcgRBirr7qlWgM+dpL1GqK3dUOSYjrv7ukRtE8FewU3Dyj6QNMdk/SMR/NA1E46
 L84Oz1nFsHsjagjZqqNRlgRYhU4QLsT0QS57rDkWfsQVj60Q2nL/1U5xQYMPyQtI
 uI3bPffPYg2g4ycmgVYRQV/uQncKOAr1uuADV0INUQFq8JzE5UVDlBh8WlnJeatj
 kljLKNR1h+2iAAXrLHLwd2XJhnlhpi/b5Hsv4En4BsrbMYXl5E13AQA7qfCrrmSZ
 ulm4ETDs+xdHOeMLxko3mwyMarhBIcvKiF3Zzsndx4YO9xBk/Za7dJv/6rBjUbuJ
 XpT/Vg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfjadf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:57:39 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b3b45597c7so2416960c88.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794862659; x=1795467459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TPfzgzv3gPVO5yZAz8YWFIBT5BT2k2lVQWMR5TPzQJ8=;
 b=kO3QKzyVOdqpV59ftg+Mm9sWoax6AL/wS565Kqcw/goBbFXDhJLI5FgJLw8RUG5HNz
 8+RId4KPwRzi8/pRueR3CDsRfkYA2/OZMu9EObnWzGs5IwbBfURkYksiZIHs8joSJxcV
 +P1EdZ96H4Q63UZsWWQyaaxV/BxnEpyAVa6Zxw+18eqMzHmkTcKPuwfrB9HZp657vPVd
 XD6OHBpQAUBSl9sjoquqaWWyFtxUBcRtjOmCdZCbJ6xyjW3RjvWpwm9v/VsPpY2Gg6rv
 6H0csCdfy+CBhW/CZR1lKCkJOjkgUHiRb1DXVH5VF4Hdkz/jJF3vMMn+1K+ILnE3XHtn
 xLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862659; x=1795467459;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TPfzgzv3gPVO5yZAz8YWFIBT5BT2k2lVQWMR5TPzQJ8=;
 b=EYH/hpZIEj4zCZuWXFkmk1GJ1UQIL9vY+DzlmvT0tJARfnlqGpFAgapyrOzTP0yM3W
 Y7zOpnNqcm7a1c2Zb4bOLU3WUkW2Q2XtCXzvr9ClCMbtOJoIRfd92szI+cmaMXldbQwf
 DliwlmwnoYQToxRc3GxAynkEG2ZMYsKZIQAX04dJYupS7cuAFwnC8ByYyEiLKcB7sBD5
 PCM7Yx4QhiYc2WE3BD//aiI/uFWtsUX+sM5WIr3A61g7vNlNUukFKi5Q7rVRTWebyD9s
 nEP/tk5EcbUfCz/WpzejteJftwIyH6zEiqrwySbK8xUBWjVwTc3GevAj3qA2kfQ3kCCc
 XkpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGkh143MeP2PCqINUyFsWhnbAl3fBABVlRe3z/wvSHvNaiZ7LEv1EQYCXJXtP4OpozWGWwqsLV3/dO/@nongnu.org
X-Gm-Message-State: APuU4Z/vu6iFyVhePSwqkpS2CV4BRpDp3NsjIb/O8UPAI6OTwEZafdde
 U8XAjiMvzZOLHwQxdHxpoRla8gOXf7qdRNxVwwuQ2PGAwLj06D64Vz0M+m8DdXmbzfRmhgL2LjY
 D5QwE1nfhPUcKiPmaZ9r0imSRhQL0Jv0EyrPXl5F7vtePJglVdshUx5ctgg==
X-Gm-Gg: AYBFou3KUG/XSXlUoLcthyp+2DjhIkFzYbn8Cbgz25y8JJXNSrDmSlshZOz7w8xn1Fv
 4M9wq5qgne9uKVteSqEbZrCSJh8FLXKcu2Yl0VNi6XdxYXjf+hciG49uxp21pW6Ai+lCp6M1ujN
 R/ZxLRi+fQH+77HzMSfixNKyiZHhFqnuIZduSw8gWiq7oj1JUug89nTad8Wmzsj0ojfKOU6H5kv
 qKU0hF3RkoQQFpuspoR3+k5T0wzqOcHBxAdjxzKLl0ERnY5Jy9XmoNqFmO1XQt+4Ez+B2SGYp21
 GdZ8Rebb1MO4GFc5Hlttd7YXrCriitExc8m46BKVs0d+RQe3hR1/OTOlW4P9WFVqr0YR7mPE9sG
 /68bW+qaQEPDQKxar7AuHajq/Ik6mloJH8x2YidmYxdzARUOvpdROoqEWQAgATCQNoOQQ0fQNG1
 K0eEmpLiUN1ApHQfB+ou7piT4x5paRsyCDhDDjN0EI0NY=
X-Received: by 2002:a05:701b:4194:20b0:1b3:aee5:20c5 with SMTP id
 a92af1059eb24-1b5030fbe7emr12691754c88.22.1794862658925; 
 Mon, 16 Nov 2026 12:57:38 -0800 (PST)
X-Received: by 2002:a05:701b:4194:20b0:1b3:aee5:20c5 with SMTP id
 a92af1059eb24-1b5030fbe7emr12691736c88.22.1794862658420; 
 Mon, 16 Nov 2026 12:57:38 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50309b27dsm34006404c88.2.2026.11.16.12.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:57:37 -0800 (PST)
Message-ID: <2bc0b65e-5a8d-4bd2-b3ec-86913459ffdc@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:57:36 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/48] system: resolve multiple aliases when creating
 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-11-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb6e43 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=OlgZcnecIKIgW91Bf6YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MyBTYWx0ZWRfX44+HVuFLEw4h
 9E3HiVKibxa46zOSUIKBY3nlMDycSR04myhcNTnBsaQlnEx21w/K6KhekGfs085t8dOrXSImxOd
 x5Ir8izrC0WgdEPmwgPXCm1UazB9OBs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MyBTYWx0ZWRfX8eQK8L8X6uVk
 Q1lHFD97Q8DTMVNpl3CHk80mHSlytpb0qWkOm/jcWh2G4WyZtC2S0XlaH6nD/pAwPB+2H9Y6zyf
 QY2bNWGvOVITHgJFukUfYaqFExHXp+OfAr/Hxyjiv2wwDDGqanSqnkik1tdKKiXY+URRZfD6YR+
 Os+aHvP2DDwu2xjHB7fQACI0LzltyuZEiS8rrLA9n7MudrejUrkRH0f+CBWUDx43XtYgmCcP99A
 Vdma4TVyHSreBH1MxC2v/9mkUSKBnFMh/+zFrcpeqgnIG1QwkM1WFuW+pwi5YBNyYVnbZtgnrh4
 VOX/romDBBkr5/HV1pAdO/rQ0F/jbr/Mi9AeT7gBgVu/hhaFqZQcTIJvTW5fA2m7Lvd1Llm17GX
 AwEl6e02MTwP2sZleRa97jmOn/Mj45SqFs/bUireLciT7KRL7O/UZpDqAPcsgB3KNYZctBg8CgO
 0T46YnA3W1Va77agD1g==
X-Proofpoint-ORIG-GUID: m8rkBb7MaMwYAvG6_skqz7qL3WdjBV3x
X-Proofpoint-GUID: m8rkBb7MaMwYAvG6_skqz7qL3WdjBV3x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160083
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> Use aliased_class_resolve() to lookup a machine class when
> no primary QOM type or MachineClass alias matches.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/vl.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

