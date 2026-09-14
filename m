Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FC9C88E67
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5z8c-0006qz-Jv; Mon, 14 Sep 2026 01:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z8a-0006pr-Dn
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:21:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z8Y-0000vw-P4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:21:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E2eO342742815
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +KiUk0BsDUijxIsBMhNetXzo/kPDi1AenBAtUcgB4ic=; b=ClhWRsA3U4VQqr5v
 2jS+g54+7XSqh1sSHKZ4IZlYQ5LYhVJ3JyhaNNN3x+e+DEISQbl1BgyzV3q5JC0h
 Iyn1kkIQCrR/WuPmm/OzItmt1KpZVUbIzQnobm6z8d2+8auGLYtZDBBU8I4+vGba
 YgXZ9J1g/Hqbz0KH3T/+zJG9FhBfizA6XOZ+1HEa3aO9Qvg4aYKezEGjG+alsDNq
 nHLJwDKvNyE+Nw5U9ODdmma906mP8MUyfRD7cu3x1QNd+/3bZ48FsEIagN9RBq3a
 alVPgQcA9n/IL1UKn1Djl35tcO7YYZ50BPhiKqNsKxhr6SB1d8HDf5M9qvSQM0s4
 /ZCFGg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gn018n09y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:21:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso3556504a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789363309; x=1789968109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+KiUk0BsDUijxIsBMhNetXzo/kPDi1AenBAtUcgB4ic=;
 b=dn3dJWawj+JU45cBdTmHvuYQZRgAikLuUKPfPt3e99Gqg8CD5Iry5rNoV7vunHmWUW
 G9gVWE6zhC7W4ILvPciShcueMunTHn8+WyckqCo1R1mwGUZc1vHY5PjT3dHMwUWGaxzJ
 V064XbVMo0fF2QdU8TKslehBwTsfgH1n2B2cUNLIq5NrOFdu5fB7Jbr2lYFgeNvCaZTL
 nH0kdcbOGA6nIOCqVP1ZaXjtW+WH5OwAO5zkKRJs3iIcf9vnt7YYRiKPZVFwPwSwK7rj
 pPPJxxh7hQ3mdx6yrno3aBXf+DcE/eoOFo8EGBWwaTosIfl4h1w2SwxoZdmsLOHSRv5B
 ofYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789363309; x=1789968109;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+KiUk0BsDUijxIsBMhNetXzo/kPDi1AenBAtUcgB4ic=;
 b=W7UTuoFIPD3JMp+7Cnu/xuJNICha6YDyanJo/oWsNiLm9vojEUXVcxLqUdIOcrprCj
 xkf7KbU7uEHgPQ4AuHwtl06CQfenu2/PD6Dt5YnkgjbuOQdlT0Xjn9R6wJgBAw/INRgL
 CxAA0K2qKBAYFwfLkLJyaCA8P8p0pdoLhr/C9+8P58Bywb+rsolLrLl0vvAy2tYhSOn4
 DoVARuB/lzaQwMcyctRgaBEWvczpixdMFiee22DTR0MxcxdfYTfCTF0h3AEJg8nJ+QFf
 kqNj+7BTKdLH8LgfAB8jXYB7P/ZLX14TUWvHW12j6FUcpQJ5jK9eMdyY48TziGEiGn5m
 vCYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQuMnBnvXYZ5092KX2SR0Y9STmHdwA5495+qDAwt6XA3Iycwkq4lekeKP79PthjACdyZmvM7mgqkop@nongnu.org
X-Gm-Message-State: AFuF++nFXmUVUkDBtxDdrxb55J8fFy7kgTBzPcGzXqPZmvz8cU0iqxIN
 0R1NmQ1Zytn03pZyXGPJmMF33psRgcehBrstm7YynO2qmL9uFnlwkvqoruMfFZ1xo/qwPNNbm1q
 jJ+kmVc24+inNjfMyB+IKefZ+nFOP30aPIH0c07EEri+DsVR5KRQ6wq1igw==
X-Gm-Gg: AYBFou0EwZQxJEXBU5Btxof8bj7pk5bAnQA2CiexCXK+D/mU6MCRhouVOSjmz7z4eJq
 1lWULaDW6W0vIVkih4BXam/vNxUQis7LnV/Baq3kiHr8HgjrIImXZMrgYlYOE/hLPhC1NePVF6R
 AFnRNdhYscHlNPwkZdOUa+JEkbsgx9VFQdY5TWV9WI26SOEy5In/7fRQdL9ZtqVHThe86pAZXjw
 gYVkNGmcxjlqXlS3+X4Wr8h2OMuDuuu8syKkp9xDJfPcwmQrhWZIHnWgapjMxU35LEG/LGwNl85
 qnp+UJ4L0U7xMhl8UMI8joECMsJUB78VxV5XRPfFiTZHPsJ35QVNWPVcfp/ANY4DZUH0njp9snU
 fRDEvvkTxnZTNHHyC+y7apn6KKCzV6AwosripIvYJ/+4QWeSbzDLS+rg=
X-Received: by 2002:a17:90b:3ecd:b0:39d:ba21:fd90 with SMTP id
 98e67ed59e1d1-39dec04f01emr2031248a91.16.1789363308666; 
 Sun, 13 Sep 2026 22:21:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3ecd:b0:39d:ba21:fd90 with SMTP id
 98e67ed59e1d1-39dec04f01emr2031196a91.16.1789363308226; 
 Sun, 13 Sep 2026 22:21:48 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d9afb1900sm5458621a91.0.2026.09.13.22.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:21:47 -0700 (PDT)
Message-ID: <16aef246-b1b6-402b-b0ea-1f75541aedcb@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 22:21:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] tests/docker: remove used _read_qemu_dockerfile
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-7-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260910181504.1010916-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c4g+0h9l c=1 sm=1 tr=0 ts=6aa7846d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3VFnEwZfmNiA6ypndboA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA3MyBTYWx0ZWRfXwhZHHMbxDsUs
 GnkGWPFwsX6OuOW2jWefYxIQdbyqcPNYOqw7paqZHKyoDMO55kv8LbRAW5DBQs76CT1KfB99yIV
 SjusWmGCYd2zD8IZhKsA65I2etNn4Yw=
X-Proofpoint-GUID: fTi171KhiKhI7g2U-61yAlKn3Ahhdg-E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA3MyBTYWx0ZWRfX9I86vkh6YaXp
 2iTTH+2xI+WNv0SPS6wF8uPr3qbA+hLsGP68PSHMBOaFYNz6vWqPOWgJMUvE8Y+AoauBUtXRlkD
 A4ZT/AyWU2oapj2CB4ZpdOUI7bl5XmW3zpidwJqDE33DyOC4Q9e2fAwM4TvU8Y0+l0OadaOM84L
 dUU341siN+QQLEwEuOa4GVRvJ/p9xS6NNkmTz3vq9vOUUbu14jlvoEgM5DILaRIQr84qoFeg6bR
 9M4r3XtB3JB4DG4wfIL9NeVv5mdtGrYfjbiQngsk8EOuqdIQF/Sw0BpgLxrapLB/6OIuXO393U7
 ndGir4dXHGHF1+sfE4sn6ervE4+2FipVeMNcR68NEYjcn57GPNLwILu+IOaSkLS0v0RMmQzDsKs
 YyIcBHEuzo9SxV6j7NQ4lLE0VJ0q7AKDJ37qOvGDXKkHulL92295VD6oAAC8tvfU15eS9J/mmZm
 gRVdWa+wjsvahAexjIg==
X-Proofpoint-ORIG-GUID: fTi171KhiKhI7g2U-61yAlKn3Ahhdg-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140073
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

On 9/10/26 11:15 AM, Alex Bennée wrote:
> This is no longer needed since the functionality using it was removed.
> 
> Fixes: 07056db1b50 (tests/docker: remove FROM qemu/ support from docker.py)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/docker.py | 10 ----------
>   1 file changed, 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

