Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266DB606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mt83klwf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ww3jjE8T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3RP-0002uw-28; Mon, 16 Nov 2026 15:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3R9-0002g0-Ks
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:36:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3R0-0003fD-Pu
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:36:21 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfE09611760
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /Zv/ONqWY3dXq7rqnI2964WmUUW1lsjXpkqDZlyOtmg=; b=mt83klwfrB43hdaG
 2zQqTXLSfrTK4/j2j53wquad7pA6UCKB1PBC3Di3taqKKFZnE7VImVYrOrI8kjee
 xC8+Pbfr186G/xNT9vnkt7rXveW/9r1Y/sADAIrjrC1C5QB/NeMWbpCzkqL3qUKp
 GDmwJ1+RikWHebpIfPOGbE8/EXXLYC47O1QQnKsIDXvu/SuBFV6VhdMP0elzQSwT
 sE4Se08bjHzbEpk7mGGVi3tqfqQsyUqu58ZCiKhLleK04PW6WmJHOmHkk3JqRzCh
 gdnEZd+UUsR40dL9hAMdOeE4gq97EC76CEYnxTJAGe/GLUMonSCyABAYb/ntuUIJ
 OvmmXg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6gjkj0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:36:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-37628596fc9so10301467eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794861372; x=1795466172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Zv/ONqWY3dXq7rqnI2964WmUUW1lsjXpkqDZlyOtmg=;
 b=Ww3jjE8T7COPFwYbZlJfnWFW2ySCsQ5vF4dWpNIWm5Xd2bhbBoFFuNb7NmsQWlic2B
 E0qtKeRMfN0y9vP0f9fkztLqB2S6LGYlgPHQcK+mPupwTPbKFOSzCLg2VGwPBj8i1NIP
 R9TqPoipffu8IbWjFdlzY4sQ74aK6GiPPshkIcil+Lzoa2TGIpTpmninm5Lt0/GwM4xt
 yLymlyrTqCS3S3LAeOBjfsayt3/Pw7mlJ6RD32NscQDJDgzni0xnpJeRrmG/LJ3LyZuH
 Ubyfe6jYw9lQKg6IeWBQ3dBCILaTw32TwAroMrv8gnxZNhFo9BaXoaDEMwR3CVjUrEDO
 PP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861372; x=1795466172;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Zv/ONqWY3dXq7rqnI2964WmUUW1lsjXpkqDZlyOtmg=;
 b=c6LxEjzi+y9FOr5fuAwLakfyOtZ3oO0n6OjYN7i1hFnOAQDuzEAvfo/UUorC8mJNIX
 nb4bFz9wOykYqVrd+YkGd5LL0gUxhleI21AaEW07ByzsUF6tENgLH8Yu5xPqXDeF18C6
 4x7h6Wc6ZLTdB1zGmYBGGQAzKBpjiIT+cOVQPwuTwp80Lr0X4lIjNKkOUtH97llHDJGI
 DYDcdHi+p18GosZpw5zV7JciTBVrYNUstqSykLJ48P+qwrGWNDOQzDMNUWA+fEcoa0rX
 q5NZr+xvJy6DxIwWzkQx2O/Malmf9Fck4OvmcckmpD2bqnT/y5cya94m2xR4gD2hX0Ex
 mu/A==
X-Forwarded-Encrypted: i=1;
 AL+hErH0/F17xTTujkBd3NLif/hgh+yBOKeOoynFwdqiPsBs99mJIo6/C2BCvBIgYYbABgYUYyytjT2PAFP6@nongnu.org
X-Gm-Message-State: APuU4Z+8JMjzv+PaoU0gJgFD0cgXj1mKemRp/qcXf0PSYQUlBkWLh3pQ
 /MZp/lLyswRspEPhl86Cpy+J33Jlbk4+2vVBU4xptFky2FBHukmKsFEsYSl8rxysJORteZRL/dx
 KhSd0h0Sc/aLRqysykzXsqYiO+Bsbk3uTnf3+27oH/bbzHOqQqylHZtaxqQ==
X-Gm-Gg: AZFdTZcz/9y0v4Nmrsi0el/KdK6k1Y7kehbt7fPvbQlGO6iEFUyaIHb4wz73ARDNtJx
 1l8uzNrU9GFABbFGyojFlm93sTfHU403CFmAl038+37WAGkOH61rEb53coJAXdDX4AFUyeKqEoY
 a5W5MRVR4sY3cewDtDlNmtuWcHieFt7+uevBwJb/MqzjN74OocHPuG0wHCVkXqTLw8RuK41mS1S
 Bu56EyP6aLD6ITBFvQl52FJUgMKoJPdjM/D7zCtkVNx3NwPL4LHzjjPVPQh+oYFIQ9nS15TVHB3
 lNyb1voHidxYQKBlaajqHMcziv1KhtFODfF8I1FFUD+khGGe3Uus5BobY1ukCuLnuyJ7HKrYqVu
 6S7qfcLFW/PK6gQ+uGtm6cpDdyGrb58uDBhovEUivmaT2ENiLWUN9MDtXbro1td3QtkTWnP1V8g
 mFUMqwOYYDKAly8V2SRysXJT3BAFz3CAVgAdUnPRF1Ifk=
X-Received: by 2002:a05:7300:e78c:b0:381:7ee:d351 with SMTP id
 5a478bee46e88-38107eed442mr671306eec.15.1794861371888; 
 Mon, 16 Nov 2026 12:36:11 -0800 (PST)
X-Received: by 2002:a05:7300:e78c:b0:381:7ee:d351 with SMTP id
 5a478bee46e88-38107eed442mr671281eec.15.1794861371321; 
 Mon, 16 Nov 2026 12:36:11 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378d7e5sm36734071eec.3.2026.11.16.12.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:36:10 -0800 (PST)
Message-ID: <dc04b027-07a4-4c5c-b7d8-c04e9d910fce@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:36:09 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/48] qom: define a TargetSpecific interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-4-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX1MIonWglj5Mj
 OlRwbKhUXGIkEDpbcpUhU4FdZQRp5BSuMJrZWCvwdtcSDNk1NDzQzLfCQJsjbb7L4spmG9jaiGF
 47VAdg42qySANxcrG+OYJePn46NehwcSTjLi2G/er64BQD+v/3P18Liv+IDA6BcZ2At6onoF8MX
 5rQqdCwDZLJgArs+IDm3gkbam30VhhS4Nbo5cQujjx6jlZv1WzCizK/4Yd28i/BRUZ2aUW3fTQS
 2jNEfIzgjryIRtkXd/vFX3VTkQBI7zzBtewlv+aWQokgKMiQZzxL7g/VT8iWTo0C6Sr4bzUOj5M
 HGSaOtDxbhlpoXKicRMVbCShfdWutLCbJmzflN7qqtY6dkf544njV5BoCNGikUdiowtcJEwmVrP
 zmDrmXsYGT1eoL05UJd75Ro32d1w46aFG70fyO/+KU8eNrXhF3TIgyAWzWj3C9KmrJ0J4rseBv6
 CpHAeV5ogwFwiBubswg==
X-Proofpoint-GUID: LarM6Pc89fIeYHZvghnstIqeEQNBc78K
X-Proofpoint-ORIG-GUID: LarM6Pc89fIeYHZvghnstIqeEQNBc78K
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afb693c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=9ZsfFCW2S5gBXKDDKjIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfXwJAk/KuFVy55
 IeSTsqo/KmCD5LP+/cn21Hw6UZ/Q5TRrFLDoxLymzGsusyWFpnDF0foTfA9E+02BebCN25zlO9k
 60maWMtmSCZoO6hxHl/FiYowzdWUvB0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160082
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> This can be used to declare a type as being target specific.
> 
> Implementing the interface just records the target metadata,
> applying the enforcement requires the object creation path to
> call 'target_specific_class_check()' to validate the system
> state.
> 
> This approach is intended to allow classes to be unconditionally
> registered, which allows introspection at any time. The target
> specific enforcement is applied at runtime in the object
> creation codepaths that need to apply restrictions. This implies
> that QOM class names must be globally unique across all targets
> known to QEMU.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

...

> +/**
> + * TargetSpecificClass:
> + * @parent_class: the base class
> + *
> + * Interface for classes that want to declare they have target
> + * specific restrictions. This is intended to allow classes to
> + * be registered and introspected unconditionally, while
> + * preventing creation of instances unless a compatible target
> + * is selected.
> + */
> +struct TargetSpecificClass {
> +    InterfaceClass parent_class;
> +
> +    /*
> +     * Leave as 0 to indicate no target specific creation restrictions,
> +     * or set to a bitmask of QEMU_ARCH_nnn constants to limit what
> +     * targets it can be created under.
> +     */
> +    int targets;

Should be uint64_t, as it was recently increased in
include/qemu/base-arch-defs.h. We don't yet have any value hitting the
upper 32 bits, but we should be consistent.

...

Regards,
Pierrick

