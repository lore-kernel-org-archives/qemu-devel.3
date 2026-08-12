Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000E9C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBRG-0002Bv-KW; Wed, 12 Aug 2026 12:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBQK-0001EE-VD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:03:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBQI-0000Yg-U7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:03:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbqxV3949947
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 16:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KOIjRm2+MezYLNeLFZNHl/NjIOfh3JNANFLKbOf+3O0=; b=lJhnVXjWt2WKJuEZ
 aq80fEBPO9dLBFMJSuFgOyi9lT8nKUQaMmSOwO8het/VjiqWB89Uh0YO03Uo8YY8
 8sOuAAu6Rwg24D0pzFehU3UKjOI9OL2T3FIatU4gcmEaHVjRW4gqRRL8anNj98o5
 d5r6KL2xrQW3/Ko+njinYZmhu9PGeG8z8r26LxSIxdFu2SuPmHRuyfYHkr3xhzKA
 YiU7GUe1p1cqHf89epkqI9uNs5W4GDlRDq2dtF26vADfnfuyYBss8NI0Z2NT5Uam
 L63HKZVqqQHqcyFJ+BrNUkOrzYfPSVtkZDwWK8NUzSfiS6Y0XobjbaP//1wDxfiI
 Xak6sQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2tw4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 16:03:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfa55c9430so13710555ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786550598; x=1787155398; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KOIjRm2+MezYLNeLFZNHl/NjIOfh3JNANFLKbOf+3O0=;
 b=kumVi+MDhiVtFQssRd0rGBZAmjESBBTbLa5uHOvt0gm7k95htFdqQraqq2UhGegYTx
 0pLkxTe0/bGCwOMOn2wtlQ+Fk/zvOAC8fQDtI1lan7gZdR/0Hj0czZ7Jr9ckT9aDsK0o
 Ww64e1HKfXgPgp83NGKxmzrOCBNhaojGOxW6gRA+vniAeL7xlx7RICLZa/z8mfopdrMj
 3+Ai2BiXV1mBLeLd81+4s2ez9lwe6snrWiudFOq92G/h84t+X2PHxkp8AZbxmQWDk+Tg
 An61yWss/dGrfEVitUUWjkMqWFiXVIHS6PBwklc+LU+1XYc1PLAPqWixz9yqoeSKS+LJ
 cN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550598; x=1787155398;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KOIjRm2+MezYLNeLFZNHl/NjIOfh3JNANFLKbOf+3O0=;
 b=dSv0tFVWUcgSfKqRnyXY2brBcxZ2oNGoMRBYS3a79/N9syFkJyO5lrI1oVIEqU2AKO
 lRjpsjo06IHfyGXzUn7Tph28k7UAWmfWbSzeSAgFwNHQadnZtuEIYwCJz4iwDaDzYaU4
 x8ku9qbzK3tuQ20/SDhKR+BhTg5iPh6N1wmIkbD40RnFvQCGMszqLCl4Xn72uHmgRLCB
 7/gWckdSiARSV9Efeyjr+Ui3ZCwh3K+1oVT4X7e25MXniwmhK+v6nav/PAylWCH9lVTq
 I7wueBhXgkn/lJqzJDwuPz13pEIP394kqjNhChOtHRDCc7CsYnED5WanqxZcgP6djW20
 wiew==
X-Gm-Message-State: AOJu0YzoO3swt7UJEPe8OzE3X5k8Vit1PZAHxVxRR7Y94d2yajwfRitZ
 +vETsSJLZkv7C7xkjrV8LSNZlzjGmVV6tFPud21cIpgQnDtQuTUIeWyv/xcdhAhlkmq6zm2YhGW
 A1ctRiYWb2aT+MdikvCBo2WA+9zttgSd4QkHZGamsaX7VOouQTWYCGaQ7CA==
X-Gm-Gg: AR+sD11jQHpiXKzHYW7vPlOlY3DU8C3nq3Xb9Lkuig3vfWvdzjXvAAQZ7nMeWJc4Qjq
 S6mot70grEyF/NSi3sQivk9OznCQUuUFYebsUTmZa6ww9zHehJ6MN5J9o20CF0S9pebnxRRlDE1
 fq1yrTXucJfkYegW71SuC+SJUe65PqX9ivYVgfEwRd/f06/C6kJsgUF86spHNUpyocKCdFCQPHX
 ihbQ/p9MWYGCbo/GaqT0K2J+2YYwrz9weWtskyeoInBqMvPdfPhGIy8wvl338Ek9cq/u4h8IysM
 2kv14+TEvlQWOa0NCJnBmzbiLAqq0t2MaIA6dhh6/eENV2oocXTTXKNZSg2TfYmXaNhdHTtE8wI
 ugHkcld/RhGCRoY7hZV3uZKNSTdmV1Uxx1Hoqdr3n5gil87BgBUWANh8yaaVzEmTFsc0a
X-Received: by 2002:a17:90b:2e52:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-39301490a7dmr7405346a91.12.1786550598198; 
 Wed, 12 Aug 2026 09:03:18 -0700 (PDT)
X-Received: by 2002:a17:90b:2e52:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-39301490a7dmr7404850a91.12.1786550595872; 
 Wed, 12 Aug 2026 09:03:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f935f5ecsm3954863a91.5.2026.08.12.09.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 09:03:15 -0700 (PDT)
Message-ID: <2e675bbc-1163-4a8b-88c4-0e2875164965@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 09:03:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 097/103] tests/tcg: remove remaining Makefiles
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-98-pierrick.bouvier@oss.qualcomm.com>
 <87ecg3za53.fsf@draig.linaro.org>
 <9a1d9f99-ef41-451b-a8fb-fd1fae500e22@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9a1d9f99-ef41-451b-a8fb-fd1fae500e22@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c9947 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=jvCby04J0YQehbGwutcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: pAc8yEQ-kfKj10FukIND3tj7wkq9GUZN
X-Proofpoint-GUID: pAc8yEQ-kfKj10FukIND3tj7wkq9GUZN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfX3LOQxbgQ2UWr
 VtB0Eg6rK1wws6vkWCs3Z7/+2c87OxN76gYpTszhHbAyU4/mEY1iJSgMbwh88QSYCpo/gNHiQqT
 +3Fj/1+zkWpAy/o9DiU7h6fY7N0SY8Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfXyD3JqnM0pn57
 egO2jl8h6rG/1oaiE+ffH3NjNg2U9440TLzj/dOMHzariEQm6jM1B7pzU1q+XpIcHoQ81VsN+12
 8VLRdOGSIsSEp5f9gu+nNcdgGntywMHKvL8VdoDjxpY+yedbYf2yNtttrQvzdpHJGA8x8whFfyr
 Sl2y77fs7gCyyZ/x/t2dsXLZJhGp43DBac2/8M/gTGls4HiB3TVNSYrha1kNz4DevfDuZCt4LE7
 iqY8Bk+qvSXzDBf0vh13BC8LOnPo0dk+ar868aC3jsqTu+P+nHk8gntX+WJUGTprzjHfDuVWFbP
 V/re3p4DdmVJ6TT2d2WJnXcYORAAdvkPB/Xu7tU5/B470TXmA2ZpBIKLKS7KH8LeMAxvXdLtPRq
 S0M2hdqbJTdvbs6r7XbAcMp1VG+lJy4045bTDTrcbJyJ3FT8TUF2Sc+S0fLSdmbxe/5UxR+x3lZ
 BFaXF71UT8VKzXN+IlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120130
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/12/2026 8:57 AM, Pierrick Bouvier wrote:
> On 8/12/2026 7:27 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> tests/tcg/mips/user/ has extra tests that are not currently run at the
>>> moment. Keep their Makefiles until they are implemented.
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> <snip>
>>> -else
>>> -# For system targets we include a different Makefile fragment as the
>>> -# build options for bare programs are usually pretty different. They
>>> -# are expected to provide their own build recipes.
>>> -EXTRA_CFLAGS += -ffreestanding -fno-stack-protector
>>> -
>>
>> Ahh here is where -ffreestanding came in. We should also check why
>> -fno-stack-protector was added.
>>
>

https://gitlab.com/qemu-project/qemu/-/commit/580731dcc87eb27a2b0dc20ec331f1ce51864c97

It seems like a specific setup on a specific machine will have specific
requirements. Not sure it should become the norm, but if you prefer, I
can just replicate the existing flags, and we can call it a day.

Let me know what you'd prefer.
 Regards,
Pierrick

