Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA5DC4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljFB-0005Wv-Vn; Mon, 20 Jul 2026 04:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljEn-0005Vo-Nt
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:20:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljEl-0001EV-NB
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:20:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K76fj91713125
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JkE94juDKULxzHC4mMoxnbUMRIAbq3MMJu2tAqr63fI=; b=Sw+qWPNtqa3gM0nZ
 68/ZfysIDBuWwsGGyisG/QmGmKroDgKAnB57xIL45QkOw0v9H5Lv2PH7Jy8YSzF3
 bY9zBWmvG3shPcCI0O/FAXICdOfwoi5/THfs39U9ae3Cex0K0gLz7MGQQerbjTN4
 UD6ac9QazPoT8gAUtef2f5hUDGkroSqHz8f21zB9CfLZ4/uob8gadSvKrfDqlkGH
 QMWXeaCeFJKbrA+SPnCjzqyx41bzlytVrpQoyPN5DrhP4ZYiM4cqf7WDXGt1BixO
 m9sSiJ5afiQ7WXqeJeKIchLb1z4b2pXfOkyaiaTh35tptugioQXmbGD1phf10m7e
 YN6Unw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0c08w1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:20:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92da6f3cc81so1358178285a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784535629; x=1785140429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JkE94juDKULxzHC4mMoxnbUMRIAbq3MMJu2tAqr63fI=;
 b=MrFkYnlFOwoGAylPl2D95Atdm+TqG0aYDnoc6v+THsX251ZRK2/1FwKovtuh+dK7vb
 TOXVutfJHkUGi8XUcgMc59srQRm1VEMDGoIqFnqtSHxNEeYLL7yCqIFWlmALkf3jr74m
 6jzqULTBxLqCAItHooaJOoYt3dg+OGt9lfdUVnbBbTC0xH2vH5dKLbOCz4vOBCAw1DGA
 0EOxXm1TEQs6d5cXtkgxa9fZPiGR7yj8tCfd8fqfTZK5K9swD+H27C8PKiPaL9uvUnXb
 kBfISb51IXl964UOIxOKQlKdPTTnGWCLZSDlENlBB8zB5hX5O9RrDGprpqNe9R6t57os
 BcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535629; x=1785140429;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JkE94juDKULxzHC4mMoxnbUMRIAbq3MMJu2tAqr63fI=;
 b=T9dp3zUcdl7Pgdz+NIKNOzZ4d4bMkHz8JH4+xLIh3Bvc25ccaES41Dvhae7ekXH6yd
 EgzsXcNGrZqrMOGyFyclu6IP237SM8bAV32EqTxIKd5dIz+zm0xNa342xNhgeRJlLMno
 PuUvmjHgGMFj2UIxjFPLk85vt2D84DPaLHsBN2TcKVlTd09Egu8QTIesVISNVmhkNZ5H
 YIw0WOuRRm9zLFItj64E0mDz3aR8xnQlfFMZo3vrTbSjPblbkrsR/6kv4DSmsebbhkz5
 dIFpKn919AYHlz9IjBeekf3O4+d1h9rJUNaJCQgB4F13l94quli7Y0zPpN2exL/ZTSGU
 Bd2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTAXiFzTIcaGLyQGvL6S7AYI4H8yc9PgXRZHxvoX0mpYRTruPFCAGwsEgxcXV19PpLMz6Bu0fQec95@nongnu.org
X-Gm-Message-State: AOJu0YwtoxzzzcPQs6zdMsH8lKwOV/o8Y9572AFp/Plw+xpGhLFQTNmW
 y6JXMsYFJZs3JUuCm/hNnqdXX24AogOSAhLhfTd2k0957KihtC0oFnIHBCQxKyG84j7qGOBkFfr
 JnDLQra2WRH703OwtL+1dvMmZyIu6sXhoJgg2BEqTUXHoXZnvyeRqMyPBmQ==
X-Gm-Gg: AfdE7cmC0w24SUULvDbjj5SshdLjQfZtgpNJYCsYVnF7hBO8+BjwnvjE/dsEDjK4XHF
 /apYxWU855Sqb/GGhkNgN8EYO+oUfrV5qlXHD+imYzxd/2yZYRq57q64i12DC8GP+UTH4V7kQfV
 v9YMYu6iMGlytVOAO7HsFX6FAqg4NsWlV2e29vO29qpVim+wFax8KcihXuxF/xIUCAth5nSqOMc
 uM4I8CYQF+TzTFER/L7S0af02CKwlUErN/9eO45PT15BxvxeRDKAJ9KbxWyVUHxF3Id6paIRzqa
 qGWE4zWGjsBpNG4eFWcSskPE3B+YrW3G23qC4W5Irs60tvar9OjqmVgol8qzZtfuH4RXBgZiHgo
 QdQZ6PJffMIEf/Z9cY11Sor0va2QSEqZHPoLfNwVB4ztvZzTaRG0=
X-Received: by 2002:ac8:594a:0:b0:51c:7b12:5ff7 with SMTP id
 d75a77b69052e-5213d7abfb3mr123937811cf.83.1784535628510; 
 Mon, 20 Jul 2026 01:20:28 -0700 (PDT)
X-Received: by 2002:ac8:594a:0:b0:51c:7b12:5ff7 with SMTP id
 d75a77b69052e-5213d7abfb3mr123937611cf.83.1784535627890; 
 Mon, 20 Jul 2026 01:20:27 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edcf8dsm30458976f8f.27.2026.07.20.01.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:20:26 -0700 (PDT)
Message-ID: <4359cab9-fdb4-4bd2-ad35-dc0724b12a62@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 001/134] qom: Introduce object_new_child()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-2-graf@amazon.com>
 <12d544b3-5c68-488a-91e5-ac64d1a27338@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <12d544b3-5c68-488a-91e5-ac64d1a27338@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HeYkiCE8 c=1 sm=1 tr=0 ts=6a5dda4d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=ZiMIAIO6AAAA:8 a=20KFwNOVAAAA:8 a=vggBfdFIAAAA:8
 a=KKAkSRfTAAAA:8 a=MR4dTCdTAYsfVAQqf0QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=KohFQSMcaiS2QNUyYz07:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sfx-k5lG_hxUdF37Oaf2fY8cSO9bls3W
X-Proofpoint-ORIG-GUID: sfx-k5lG_hxUdF37Oaf2fY8cSO9bls3W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfXyoopuCvNxHYJ
 Lntd/3kmU6mh8eLKlgilaA/3mzpUE57RUS/iYe4pP0sHJNZ02McQOUUthXxBIfHAjeLxXVgcRwk
 CZke7h5XUIL7itDOHbtnW4JsN8wyTo0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfX49lpVYZ2bn7n
 w41LGdFA6r2ZruL4k3glKX7PgxieOKZKsQLv4Tu2RF4e7SVPbJmfHXUBzFHc2MUjF+5jFaq4BKx
 6X+uwHiN43r7BTPP+CgFADbju4CuiE+eyMPrIrRMqZhy/eMJTypkCbhw7wToPrlazCFEs+msj9T
 WM+qMWk5fZZL9hzbZx3n+bIZtw5xH7ug8tJTWFjw/n5mSblDOHGly+hVTOaxzn1RCARQYwTywdg
 XhTfQRbtnyFX4WYIm9Fb/UtXAVbdEBq0J0x/zdjz8HZaLGNwA87vSH1MBts77iPM5EuAn9P4/+4
 C7qDeGRJh62qV00DHKEtYOhhhKpUHOlUYJE5UZT24rTUiS7SsDFp8HCE/SUuiBlbQAnlW/TgEIy
 FDFW37908C36R6EsE3xaPPNPlt47+7CLQaApn1sayGK1BVWvSMT5Duj8z7OWaKscCVY0sRohX+u
 dtj2vqMv9nYa23k32mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200091
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 13/7/26 18:49, Richard Henderson wrote:
> On 7/11/26 15:34, Alexander Graf wrote:
>> We already have two ways of creating a QOM object with a parent set
>> from birth: object_initialize_child() for objects embedded in the
>> parent struct, and object_new_with_props() for heap-allocated objects
>> that also want a list of string properties applied.  What we do not
>> have is the plain heap-allocated dual of object_initialize_child():
>> create the object, add it as a child<> of a given parent under a given
>> name, and hand the reference to the parent.
>>
>> Board and composite-device code that heap-allocates children today
>> therefore either open-codes object_new()+object_property_add_child()
>> +object_unref(), or skips the parenting step entirely and lets
>> device_set_realized() dump the object into /machine/unattached.
>>
>> Add object_new_child(parent, id, typename) as that missing primitive.
>> The reference created by object_new() is transferred to the parent's
>> child<> property, so on return the sole reference is held by @parent
>> and the caller does not need to unref.  Later patches build the qdev
>> and per-bus creation helpers on top of this.
>>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
>> Assisted-by: Kiro
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> ---
>>   include/qom/object.h | 25 +++++++++++++++++++++++++
>>   qom/object.c         | 13 +++++++++++++
>>   2 files changed, 38 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +Object *object_new_child(Object *parent, const char *id,
>> +                          const char *typename)
>> +{
>> +    Object *obj;
>> +
>> +    g_assert(parent);
>> +    g_assert(id);
> 
> Of course, typename can't be null either.
> 
> But it reminds me that gcc and llvm have attributes nonnull and 
> returns_nonnull; we should be using those, both for their Werror and 
> documentation values.

'nonnull' attribute is not useful at runtime, and the odd of writing
code with NULL argument are low.

'returns_nonnull' is a hint to optimizers and don't help protecting
us from bad code / pattern.

OTOH the one I find useful is 'warn_unused'.

