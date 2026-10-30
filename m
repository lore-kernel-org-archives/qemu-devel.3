Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD60606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JqZVkDPs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DKBjnCPK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMs84-0006tM-Hf; Fri, 30 Oct 2026 15:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMs82-0006t3-Bb
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:19:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMs80-0006ZE-Pd
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:19:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIjHun3060085
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 19:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0wN7OY/ThL8mGWX5zn6gWw2QIL+WYfx8SiyPtBdw4yQ=; b=JqZVkDPs0gwkym8/
 9J8Ob25y1WE293Vn/t7N5eLdJxJ/0WasZyszxY2kmSrtS8e/wN/Zgoyygszl4ZwP
 aTTLD147qP4hRkbpzZ6AacCBDC32pNUc6weqr3hVuCBY9O3GUulw9URh82zRn7la
 AqcbmJa5LvkdyqNNLnGTPLdTNvopJGfqDCyHoy8gvkY47cAGwKmkD4hNAYxI/qKj
 XxpAsol+7GoUyHgVuQHCuQ1+bdQ2XmKPKos/sS3tYxrCRKUrM0D4IT2gnSMj+6hm
 H97lUvx8hMb8JZvh5BB+8F9L94D8DyQF/Jiv57U8ge+hd/9qlIyRIolRANYTz1N/
 boiCxA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0sxg3dn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 19:19:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c3c370b17so1770512eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793387940; x=1793992740; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0wN7OY/ThL8mGWX5zn6gWw2QIL+WYfx8SiyPtBdw4yQ=;
 b=DKBjnCPK58DJDrCGub6ExkZWghZZGd4G1ZW3LjkdpnVYfJb1c2c1mc/g4QWSnncmY2
 uPnAVEyrHyjt7dbVR9lEW34s/Qd2HQkiwoSIoDscgSY2fI18LMXmchqx7YFLTY/KBpX6
 tYiqrelyYqgTjjLjSAwPzDkMQu6mNRSWPgrZDTJJeZ8dPEoEReYAP6326rr4S5sSQ+9D
 5687oDX3MQ1uTubP4nqwQTFn5G0yxbO8sgWky5K4CY6Dg7pYi/Oh4HAOUNetgghuKOyA
 7FoHFZRc79T6ZwxWdGxEnhnvd2FRQJrBvbeLzAZ2mZr9u7IXDbXfy3MzItBZzu7RX00Z
 P2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793387940; x=1793992740;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0wN7OY/ThL8mGWX5zn6gWw2QIL+WYfx8SiyPtBdw4yQ=;
 b=jFioUqtk5FibS7jWryTsDj7ZwGrukePPh2TuAeG2LKax+fCsdL7QUGI/+WOE1W5unl
 atweOujeCTvoJUdsov1lYUjVD/GEfgegmM47ss4ZiNRW0pXHB6upzfiNtPqmvAY27xPp
 wU8sIE/86KsYRTif9Q9t0xqYTr/Uusc9VyREwORomJve8drugvdaOZcIhU2PbMrZlyBe
 nSMAWSHVrjekUCcHUdcH9XNrsVSganbDyQplMS1VgbQdBODzZPtJWQNMSojTc7dS3Czx
 26h/cez5buKz1GeEoSa5/h0XFW5Z5DliEulwwt9YKKO6HypMdcchi0Cwia78iRvsKLU0
 QhIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlsuzyQEj7n5p4n8xpICdFG07gmkBVaQ/mF8EsFiCNbcX8VOyDwODmoDBBJ29XYRMAGVJd11+EdqpT@nongnu.org
X-Gm-Message-State: AFq9FYLSrKhzPTlULy+WmXtg65NPt7K5yrqj2gmsl36kPTTGzJpQMrO3
 xBZfJ/UvcQDDjmsj4he6SfIMMA6JAHBLWJkra3L5rp2wVOnIyXX9nmbk99EjIm20rR4LljF9+Gk
 kZVO/dCWYzWkNmIr3Keg0iCz8z8IAF4OR8go9+KprEOYjlAg94VBfEBofHA==
X-Gm-Gg: AYBFou3GIzLpRDlFCDKfAIcfYULa4jjiQuH4TVUxB2HaxiV3ygCk7o9y1juKFzePsFN
 tz6KjNlnNFJRmh5kT7o/KABtmwoY8YC9sZxWDW/K5CddHrzaE/z3Z3OMC6WYv7Zr2DonN6QADlJ
 AaDDiHn6pujqSJ4JS4L3/LQ5b/H9xs8HqUOB8C50x1g0ONIJX6Ca6a8YnVsbciog0upcQ9FRdQa
 iza1Qpgr2b3hsJcPfT5MNGj3HTrCsT5VGDcrRvvNNSh7eHwaFdJny6vt0pL3+tJEGwWeAmxndXs
 aGqNbFJs+kvcq7leuHfJkmjbYBsC6ximCOjSP9Rh++A/EkSXSPzZ697iBSZiGxU85l6dPLfgsaI
 xTQ0sR7+EQvax81PDM/nu9BzDfl2tpguApEipsj9SOZ9oYWg0eVR6jWsjolUbKMFagktuTGt07h
 /9KOBLLLExarYM0pD8a53QuL7Od/DXTSdjRj0iotfOlzE=
X-Received: by 2002:a05:7300:5988:b0:369:ef92:bd7b with SMTP id
 5a478bee46e88-36a42426236mr4539098eec.41.1793387940389; 
 Fri, 30 Oct 2026 12:19:00 -0700 (PDT)
X-Received: by 2002:a05:7300:5988:b0:369:ef92:bd7b with SMTP id
 5a478bee46e88-36a42426236mr4539075eec.41.1793387939820; 
 Fri, 30 Oct 2026 12:18:59 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a6eabbsm10037062eec.24.2026.10.30.12.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 12:18:59 -0700 (PDT)
Message-ID: <8c57a107-c87a-480e-b946-1fb02a500a52@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:18:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] tests/docker: Add the mips32r6el toolchain on
 Debian cross container
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno
 <aurelien@aurel32.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
 <20261030182546.2508-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030182546.2508-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3NiBTYWx0ZWRfX8zURZFQI9Vvc
 cxh8QhwZ8O2B9RGF62BTbOBdWU2M1h0Ss/l3O+ww5kjpNQZdemx7yxVI9TmmIcbF2v4EOZnBxoz
 OOql6wl/vkfXnA8T+nbygfjQVPJoQvzWwKoVtSWx8IPv+3wqpO3IEzr3AzR48ToGgMTi2ywfSDX
 CgSA3yzop2yX15bAVPFWLZ8AVJjBr6qxb7Zd9s4TSKpIwhQKAO7DvhKNfu9enBXcgNBv7ZiJgsu
 fYf3tbvnjqMdG5nYwanPnQPzQZfkR79nVLPRcpoAWe62j7DF3vMwlLVWK3mhRLW67I8CK6hLz7V
 udxtXpZNqJiDVmNAguCobKFqkjl73JgvBD3QzPXDdDxxmaIlDTfgN2a9B5x/s8rMrlF/cgOlNo4
 SH+mhiatQwBnBNb9V4XrgdkrByntRDSkCpSTIkgymzXaZ621oMyk0CInKRYp4wCNWMz9GgJZL7s
 mHT82kptI53Err52QbA==
X-Proofpoint-ORIG-GUID: vol6ZDP1UiyfMHSOalKMozEiQkPPfMGU
X-Proofpoint-GUID: vol6ZDP1UiyfMHSOalKMozEiQkPPfMGU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3NiBTYWx0ZWRfX4XCMvOsGQohA
 NItFbTSIWIU0EIR2/Rp+0ny7fk8oKpb80f8e0RdAZXzRBQtO7CtxOSBpeR13J/Pv0E7RVSUuSif
 Bc/MQiWuEFcvWAdBA4/PtNMqFiSMmWM=
X-Authority-Analysis: v=2.4 cv=ap0nmiZV c=1 sm=1 tr=0 ts=6ae4eda5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=v0-6_hPEN2iNG6QYXMkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300076
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

On 10/30/2026 10:25 AM, Philippe Mathieu-Daudé wrote:
> Use mipsisa32r6el-linux-gnu-gcc for the little-endian MIPS32R6
> tests and install its compiler, binutils and libc development
> packages in the shared Debian cross image.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/debian-all-test-cross.docker | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
> index eefc03c49a4f..4bbed2cdf08c 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -89,6 +89,9 @@ RUN apt update && \
>    libc6-dev-mips64el-cross \
>    gcc-mipsel-linux-gnu \
>    libc6-dev-mipsel-cross \
> +  gcc-mipsisa32r6el-linux-gnu \
> +  binutils-mipsisa32r6el-linux-gnu \

Any reason you need binutils?
Seems like it's not required for other mips variant.

> +  libc6-dev-mipsr6el-cross \
>    gcc-mipsisa64r6-linux-gnuabi64 \
>    libc6-dev-mips64r6-cross \
>    gcc-mipsisa64r6el-linux-gnuabi64 \


