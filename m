Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A681606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YKk1PQ3C;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hDnTYTkG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMb3-0002p4-OC; Tue, 17 Nov 2026 12:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTMb2-0002kJ-93
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:03:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTMb0-0006dl-IR
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:03:51 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR4xH3503943
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 17:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N+SKk/vTcwt1mYSJmINxufjG6fkbw3YmMpfUcELjmeo=; b=YKk1PQ3CEh8Gp+AW
 HPs/WusqglsWupEFUawHlOQgUKafteLwy6mC41wD3LoDTGw0Nn4A5asmrZn4NS/k
 IAajTeQNbbL3njptBrcHwVKid7TesspfGUDhdpor0oLm/5xAngWEWThRG9yMWf9M
 vpJ1GqIL4oNU96HMy36HG3KrDAXeMmiISBheK6OSInhgaMwgpHohvUJZHQJU99a8
 m91UNEsCHuesCcqRdvUCJy0PNhn7qgVEH6dThFU24oXVp7EdE2clUZ5zmMkmOAUh
 oXQUpLh9L24c9Sk9Ai0aR4Zx9oMixBeFwJZbCY6Ay4EWZZHACzP0TIXGgETPsSev
 pzINQA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv11rag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 17:03:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so100898eec.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794935028; x=1795539828; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N+SKk/vTcwt1mYSJmINxufjG6fkbw3YmMpfUcELjmeo=;
 b=hDnTYTkGE5JWlV2a4uG8voxIgDrDOSJw5IH+jo8xLVDzIviyAzhTlw/44vuO0OBTb2
 S8Du58wLw/q/SiqHD6cZ/bxF7tTzXceWpXJuy+ELiu9BUI20xg9xpu8qkJQXV4GMoVl8
 2XGbr23nWtM1lRiCwOPZq9AVHQrzWafMSia0aG3FR2YChzWhIiL2CxxCvuutJPBgcyyo
 VXApcYZrJd5Q2mzUmBev4IuyUIACoX+PiOBtNzsFXSuPOrxeIo/VyC4ijXAAcSaiUDZO
 d2KzsyKpBr9XofhFJiyQlNjwrIRpWuy3MpN1HQz9UHzMbUIn1sPkC1N+AMzo9VT1gDKs
 pZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794935028; x=1795539828;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N+SKk/vTcwt1mYSJmINxufjG6fkbw3YmMpfUcELjmeo=;
 b=zZTs12zuSM2mUbYb6ejzoWI+7pIqMb0i0JL+aDjqfHI+SR+zQMeWGOuv2u9QZxT+NY
 F6WFadrb9OvHljXPBUPYKaHkYhpSqg3QIBzSIGVqM0Zj7xrQ5S34dE8NN28v5ojYlH03
 XJWOwBbtDBEJnzpyCbiQZ2zwAdH0NbZUioT6Xcar8pITQCMuAdXqpXIt3iExoYMVHSkx
 csoPtexE2A44hVl/c7jaEyXXV5Z7QUk115hVTOOZ+mSFzsQ/eIArjxxaLm+5p24ObJpT
 BNqAFY+7xymOynnAPAbCP+LL61jdFu1RL8ZzrstJP87BOFYxe5jqR9yRzK+u3elM+0VC
 jrKQ==
X-Gm-Message-State: APuU4Z9pW2E4sx3030hLDSRtZ6J+Kt6edMxU+k6zr2sYbYviZ+jqB9IG
 jDGdG0O+I0nPeJuwxICzA+cMfzbuJfHBeeJ2C1xWvTNzrJrhTpIreEEVEiz9YaydXFgzIXpXgm3
 jrQYiO+0yM9SYlGhMP4qxMP/OdtjRSyPLssl9netlGQh3eVKJ4NVfuwOlV/3DnsknLw==
X-Gm-Gg: AZFdTZeE71cXlVUdHBRqMKCQBYbfdkJseh0PZv1kWD9P2/aBb8SzBgxT/fzW6Dwgmjf
 N8kBuDKOX/XTU0ImAiZv/ClxNDDVW8xiSTDb/s8X/30fB6Q1iHzBf/BHmoCe9c1scOlc/lfkcvj
 MvvxDXtpkNky/qS0OdRk6eQo+9qg3dry4LFoUsYOyZnid+MhAzu97zrfZ/OWYQcF48UTPApERsX
 evS6W4Y5WHgIBTnzxCZpLj9si5Ck1pIhs0QMj4ip77SyejcDQruIVIzBAWB5QxTNUzPDDKrHU8h
 Cy0s1VFnI39xpJiFEoqwxdOM8IkJzTMf2Hb9CNAlFHP6JKsNKHSQZril/7SVTIyBTMEtJs3G0Kv
 zvCeX1W0LDXvbQwSNU8b5XOpRF82ngcRFURWlu8CZ7mz+XQxM1bxcFvFerrRO12lG346k5CvrKf
 DCXLK94X1pu64w/Jdvp2nDSkXWjPkeOkPJ0TeLADsL1QY=
X-Received: by 2002:a05:693c:415c:10b0:36a:1008:5815 with SMTP id
 5a478bee46e88-3827dd05a3emr80811eec.5.1794935027545; 
 Tue, 17 Nov 2026 09:03:47 -0800 (PST)
X-Received: by 2002:a05:693c:415c:10b0:36a:1008:5815 with SMTP id
 5a478bee46e88-3827dd05a3emr80784eec.5.1794935026903; 
 Tue, 17 Nov 2026 09:03:46 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad134sm57790643eec.27.2026.11.17.09.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 09:03:46 -0800 (PST)
Message-ID: <855f671a-befd-439d-909a-b65d1ed6f286@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 09:03:44 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/docker/dockerfiles/release: use full registry
 name for image
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, pick Peter Xu <peterx@redhat.com0>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261117170244.3180399-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117170244.3180399-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EWYPhLJJrI91OJnklyXJNEmgv9tQ4_An
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NyBTYWx0ZWRfXyOqZnOVxuqoF
 J4KJGo4xVSTE+CNuynWAe1+Lf2cyZzjNbLYi1FEFHYHlVyKgCmFTgaciZF/g9+62ZYPKhV2BsjW
 Xyr/MPv5efxoJpNAu0Uo1k5MuSxeLq8=
X-Proofpoint-ORIG-GUID: EWYPhLJJrI91OJnklyXJNEmgv9tQ4_An
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afc88f4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=6G8LcwpkvcHK_XEa6m4A:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NyBTYWx0ZWRfXxyZUVJOdRC3T
 Kq/xJjrMsfRHXLx82u6UMqI3fp9YKvwPlP/kBQH0QXXqWChVScNzGVBj71WkDgd6kzvZBv3Wwjd
 D8/OnlZBBnnpxm/Fe2lEHt5yiu2ik6aAi9MoE2zl6ZxLWTDhJirUmuP3yB5pJPEAMHa78bhILAv
 C+ziq9IoMxPqP1R1qao2tEDkcqItOJ3XBoKkDU0NEOP7x9CuttBrzNbrtAeZzVSj1NBDs06IsRc
 XgG/L8kjA4M4ONWisIginmc33RIt2f40hNxBooAUF9kkKv4I0jd9r0Aj5LWeq09RP16eIbd2N7m
 nu/T8cCp3YWw/9ZWCIHXSubiy/cdyaL7eHnSRPizTP62izAQtfW3lqplawY8bLA12A/vEGnkzrK
 xd2b2V/qMPw7g0FPsJSgjftSdonuQIq7GCkJynfTCTSqmZUa/0cs45VkpZc7JcB3/xX3pmqQrjr
 v7MQ+lM8k5kZRyIdWqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170067
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

On 11/17/2026 9:02 AM, Pierrick Bouvier wrote:
> By default, podman does not have docker.io preconfigured as default
> registry, so building fails.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/release.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
> index ca6babde01e..23cd64a9829 100644
> --- a/tests/docker/dockerfiles/release.docker
> +++ b/tests/docker/dockerfiles/release.docker
> @@ -1,6 +1,6 @@
>  ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
>  
> -FROM ubuntu:$UBUNTU_VERSION AS build
> +FROM docker.io/library/ubuntu:$UBUNTU_VERSION AS build
>  
>  # add deb-src for apt build-dep
>  RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true

v2
--

- use  docker.io/library/ubuntu instead of docker.io/ubuntu, to match
our ubuntu2404 image.

