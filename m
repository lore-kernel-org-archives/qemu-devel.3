Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A3B606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fnDsPZug;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KSr4/w3q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4XY-00070a-UT; Mon, 16 Nov 2026 16:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4XV-00070F-Uc
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:47:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4XT-0007b8-SG
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:47:01 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfGMO2247130
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BigtqOR5ETLEK28dZDC75UrvRgbYHBZy9rpqOnjOZsQ=; b=fnDsPZugOxMtpCJM
 pzj/Ufj1sYT+y0XuPeHYDIiknI33fANYGszbPKAEc5WWfnpX+pXW3Igd0LVM5+i9
 FqiSnut0Ds6dNgCOBAeKJq6Z+98OKcI3fqsC9UiPZT7/v0/O4S954LBNMALmhu1o
 DNtri3MwRLDUtT7FQ7rI0SbtE2c8l2eQ8jZTu6CbdrTfFAZBSv3MZiVz4b7TbCqm
 yGqlfZRbjN1tbduN+gO6wruLPa/a0zs7SsUOuIv+z1in1esnoKVgJ4OQISB3eHlS
 /9fIVyv41tf/lqGoIQLFTecXUBTD1DKkLBfBQNKSzGpS5KuIj2nN5b6apR5IL4p/
 Xo9wtg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqyaqjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:46:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-37549877380so5272591eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865617; x=1795470417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BigtqOR5ETLEK28dZDC75UrvRgbYHBZy9rpqOnjOZsQ=;
 b=KSr4/w3q6P0VcO0my2TfVbxeLVjocNaiyExx3v/3+1GC17JjIZ69hE7yc74plqqfvB
 HcNLSiyf8Pdk02d3uk0/dpXfk58SgzzlE1jFphoFJXAj7cP4RZjcYIwGDfTdp5L/CfoL
 w/fXPBXUVArj1bPwtAYpVERsh2XgLvoBWQmT/5+yDQnQo37jkT5AdIxT9k2BH5y7d3A2
 s9oEsbURHksGy1nkRuQbgKo84NhDlRSFQhPoFE1mKlK0cUmjl4gOVKYonxRsLwLSeOeq
 ot9GyLrer631M18UuPhFvt87Udsh/TjeymdkEKU2RIX8Fq5yXBZkBnBL3bboGFVfLLRd
 NyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865617; x=1795470417;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BigtqOR5ETLEK28dZDC75UrvRgbYHBZy9rpqOnjOZsQ=;
 b=rxTSt+T/lH5Mn6sW0Qjff0Qs0FjF+/53lZ0rlPGbwrLylXeQkKWZwSZirA8bC9A04B
 uyv26rEmm0qEXoGZImtZaHMzYwWYGzkd/JCvkFQ3Sq79biIurv6Ts2ZgqUlrs5XmXB62
 IerpRsfMzMHx7QSNJlthIahXfOrzzhdV+hrOcBMCPExRl0qPJcqYj+/03+SnGKIFGxBW
 ihTgowa6PDCsOWIh54M+KPgkBj7RUcFbeE0pQwTDVdHJ0dHVwQpp4FdsQQ2b7dnz9VuQ
 xC9Bf8e+Dj3EP4EpL7ZkO5xh+vlAw8ymBWvBXvm+TNsnLf3ClsT2q9pLKEC36ilvm5hX
 GvaA==
X-Gm-Message-State: APuU4Z9vUdg2I6J1N9R4+dBXS+hNVIDiC8JzpcODLTI1D3567NR6hZNi
 etNaZzb5YZBsjlbl7SX75CR7u8nHByr8P5ofewg2WhayrYsPl4GUg1jirxj0LOPU/10TrLFgyGl
 Hceox3AhLb6ZREdtH6W9eaHp/ogbngU8TqSj8iyVltU4f3Ltc5vtSndWRWQ==
X-Gm-Gg: AZFdTZcFjx87RrDLkGZRbxf2uGxDHo7BlDcVQCA47Rk9eTkHVECLT5Ih5bXn7vdUpsy
 /CnKKwaEJ0rlGyAUrlYPNz0H8G/W0X0DvNx+IslRPC58huwksGCEMD1I3V7EWD1/D+38cAIWwh5
 KZY/M/bjXUCy2LOqRC3iMd+4Jef8AA7OYcS03DbuzkkMxDNMrgZGOLz0dVBDBk6sXW69Vms+VCP
 HHHQ/MFhkg6I7z3tdPk7XtlGoM7YXUg19lTyuXbdJQm6l2cRLvZhxYLbYSnNLVkUssUMScvuykf
 OsgQKOKII1ZO1jERHxtCxOuToV4yA7oAnIl2ScZrRXzZ22BM6OsBiyx5SxzGteF3qdfOoOWfr4J
 1uc+Ve1EKEABQKtSNtVVvB4lNaISXibNbB0vxLjV+tj9MAgybVYKAd8wog0nh3Dc9C0v3kUmtLJ
 iit/BJtPlGuyli/jGcCTOM5/JGU1TE0cHAcJuY4yIZZl8=
X-Received: by 2002:a05:7301:4d07:b0:375:87f5:ccee with SMTP id
 5a478bee46e88-379684b56e7mr12649913eec.29.1794865616875; 
 Mon, 16 Nov 2026 13:46:56 -0800 (PST)
X-Received: by 2002:a05:7301:4d07:b0:375:87f5:ccee with SMTP id
 5a478bee46e88-379684b56e7mr12649882eec.29.1794865616111; 
 Mon, 16 Nov 2026 13:46:56 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955a1c5c2sm37611081eec.14.2026.11.16.13.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:46:55 -0800 (PST)
Message-ID: <67b3aa1d-af5b-49eb-b3bd-23b98b449ad6@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:46:54 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/48] hw: resolve QOM type conflicts in multi-target
 builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Markus Armbruster <armbru@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <CAE2XoE8OvtmLOx9LqmL=aOu2ptu0UpFGYwOdU5YHQ3N=9e1rpg@mail.gmail.com>
 <avcAa4U_QIu5NVQu@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <avcAa4U_QIu5NVQu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX5rnXyoI9mBYT
 nrC+ne5FID047INTWWEQTzFprIVPeCcmDhdCA4pqzaFMrVLlH5RtXXmFTEawXd1SHvHS6ys8cCr
 8fNi2X/SUFNuwtW7zDrrh+n58k0hNZ8=
X-Proofpoint-GUID: RINePvaMI5462qEKLWNR2eqp81e2swPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX8h+22fsMvuJk
 yIyKiQjvHxzVGx4Lcxuu2gYWPrubdzOEDyOu5bLXlBG3TGW/cDe8sbAaX7GNlKf4RZWT3SXyxOF
 YDCV9WI2QjwiwHaGouWYf0Ow5MPfk6Mo84KYKvBW/w63Q7L5pH8rOl6QPEEvWL5GTU31zuEr1vl
 7lsO2ovgiv1CgsqP9O0Mzx3kG+3F6rq1O8i759SPm3wma3/JJxgUWsHIsc9ds+wL5czHKxPa00p
 U1k6On7SM4r5ZEexjccVp8Byq3WeNEg9a+Vvh+jf4dfO/shh6UgcS+X+HcFdj+asf4UKv/vrmFw
 HHv+Ua5D2tnZ+mXNMkIJ6FPWPqCO0iauAelHuIKHEmAH5RmlfkUP4DA4xEZ/oyPq2yG3GDidJFz
 o9+jfKFyNKDQ/zRhTHvXaaLXLh5aKuwfo3DDnCrXAipQemcA/qbJoDHZsmdlF+V00iDhl8LT4g/
 0bw0XaYwtgG3AZBMhjg==
X-Proofpoint-ORIG-GUID: RINePvaMI5462qEKLWNR2eqp81e2swPn
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afb79d2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=cMSORcGohnQfWt5fTEIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160086
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/2026 4:19 AM, Daniel P. Berrangé wrote:
> On Thu, Nov 12, 2026 at 11:08:02PM +0800, Yonggang Luo wrote:
>> On Thu, Nov 12, 2026 at 9:31 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>
>>> When building a multi-target binary, QOM types from multiple targets
>>> will be linked together. QOM types are required to have unique names
>>> when registered, so linking multiple targets in turn requires QOM type
>>> names to be unique across the QEMU codebase.
>>>
>>> Global QOM type name uniqueness is a desirable property for QEMU
>>> regardless of multi-target work, so that QEMU presents a non-ambiguous
>>> object model to applications regardless of context.
>>>
>>> In a multi-target binary, it is desirable to applications are able to
>>> introspect all types linked into QEMU, when launching with '-machine
>>> none'. Dynamic filtering of registered classes at runtime, to resolving
>>> QOM naming conflicts is undesirable, as it requires introspection
>>> to be repeated for each available target in order to discover the full
>>> set of available types in a binary.
>>>
>>> Introspection is a fairly heavy weight process due to QEMU's vast size,
>>> so enabling introspection to be done once only for all targets will be a
>>> very significant benefit for management applications with a multi-target
>>> binary.
>>>
>>> The glaring problem is that our historical design has led to multiple
>>> targets all providing a 'virt' machine type, which leads to multiple QOM
>>> types call 'virt-machine' which are all different.
>>>
>>> Having a common short name "virt" is a useful characteristic for users,
>>> but this does not imply we need to use that as the basis for primary QOM
>>> typename. It is sufficient to have an alias called 'virt'.
>>>
>>> In terms of implementation there are two core pieces
>>>
>>>  * An 'Aliased' interface which can be implemented by QOM types which
>>>    want to support type aliases.
>>>
>>>  * A 'TargetSpecific' interface which can be implemented by QOM types
>>>    which want to declare  they can only be used with a subset of targets.
>>>
>>> With those foundational pieces
>>>
>>>  * Machine implements Aliased and TargetSpecific
>>>
>>>  * query-machines reports multiple aliases and declared supported
>>>    targets per machine for introspection
>>>
>>>  * All the 'virt' machines are renamed to $target-virt, and aliases
>>>    added for the shorter 'virt' names to retain compatibility and
>>>    convenience when a target is selected
>>>
>>>  * All the machines which have 'is_available' set now report their
>>>    targets via the TargetSpecific  interface
>>>
>>>  * Creating machines validates declared targets from TargetSpecific
>>>
>>> An apparent design mistake in TYPE_ACCEL_CPU is resolved which allows
>>
>> Target independent TYPE_ACCEL_CPU  is my first choice, if the QOM name is
>> do not have to be kept, I think this is better.
>>
>>> removal of the is_available hooks from target specific CPU impls, which
>>> were working around the bug.
>>>
>>> The original proposed patches to unconditionally register some object
>>> properties is pulled in.
>>>
>>> Overall this brings us closer to having a single unified object model
>>> across all targets, without having to make runtime variations of what
>>> is exposed/reported by a given QOM class name.
>>
>>
>> Thanks, overall looks good to me.
>>
>> hw/microblaze: defer PetaLogix endianness default until init:
>> https://lore.kernel.org/qemu-devel/20261105194958.1117-5-luoyonggang@gmail.com/
>>
>> is also for avoid target_info in class_init
> 
> I added a R-B to that.
> 
>> The last gap is how to handling cpu class name conflict
>> target/arm: register separate max-v8 CPU types for arm and aarch64:
>> https://lore.kernel.org/qemu-devel/20261031164009.2048-7-luoyonggang@gmail.com/
> 
> I had a look at your earlier proposal here:
> 
>   https://lore.kernel.org/qemu-devel/20261013195606.152-1-luoyonggang@gmail.com/
> 
> and to me that looks like it should do what we need.
> 
>  * In existing qemu-system-arm and qemu-system-aarch64 it will
>    "just work"
> 
>  * In qemu-system-aarch64, users can still opt-in to 32-bit
>    mode only by using "-cpu max-v8:aarch64=off"
> 
> So based on Peter's comment it does not look like we need to
> have the ability to register two distnict "max-v8" CPU classes,
> a single class can do the right thing at runtime in its
> instance constructor.
> 
> I see Pierrick commented that it would not work in multi-target:
> 
>   https://lore.kernel.org/qemu-devel/f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com/
> 
> I'm not understanding why that is ? The choice of 32-bit vs 64-bit
> is made at Object initialization time, so if the
> 
>      if (target_aarch64()) {
>         ...
> 
> condition is not sufficient, it seems like we could add more logic
> to that condition easily and to make it do the right thing at runtime.
>

I suspect we'll have more issues with those kind of if in instance_init
instead of class_init, but I don't have any concrete counter-example for
now, so let's move with that.

> With regards,
> Daniel

Regards,
Pierrick

