Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968D606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BCGO7rWT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EZjDPTuB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Zm-0007gv-QX; Mon, 16 Nov 2026 16:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Zl-0007gc-NY
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:49:21 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Zk-0003NQ-36
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:49:21 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfGij2134908
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FDjVpa5xcsWzMH+MR1DBtWtujqYLYfCVyGCtexevmG4=; b=BCGO7rWTbLx/xLpt
 OXjMJraFavGz/n9y8uLGiqgvU0tODNfdqX4qFiwzeJh9po5wOknVb7PpRxn3zvKM
 deoWfgbyXB8T6+m9AJXTdC6GfYDEgT4tb+PcbWKeNzKSHCyq81HO5H1/GLmKMW0q
 Sa3EHJ+Q1Ibb5x18rMWgJ2KPOi+A5PmFgP23xVepR85ziufkElOqCd46dLnum17Z
 wJqVwqppY80EqNbFsM7HRAus6viL/823660Z3/PjDI6NfIYIlf2DbMrfPw4B0ZYJ
 nIITMqK0+bsK+K7vz7usHw8kNYf9aUcH/l/aNUGTOxefVGEM/itheT8Hj6FXDKyf
 hw9wLQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0003jn8j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:49:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3724667bc16so188018eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865758; x=1795470558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FDjVpa5xcsWzMH+MR1DBtWtujqYLYfCVyGCtexevmG4=;
 b=EZjDPTuBopssubAZ4PoKNWjBJVzb7fiWjRn/Ya6sm1KR1AlVi/z3H57PX3qXxpxAXE
 oFBu04jIC+WrakTJWwgMKIrBcfxCvxzXKH1+NfSW3NoS4Pue139yU+QK0oy/yzWLvTG+
 LLKIa3mcz8J6B7ICGPVPTApE6ozMTGEsE/BDpzLNKK8udZsFpDUrsrDRt/g+8ByFruQ9
 xaJUC3VWzKRUKxKKpU7WBsF2LKphEOvZlYQbhFhFR2ha4ODBUv3gw9yOQ3D+6UGkThV6
 cpZCCKdMLUkJV6/L1NSrAuA6fmQp1FROB7W0feMukKI2xzplQ2qdyRfZ9OWwWYiFDGm9
 mIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865758; x=1795470558;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FDjVpa5xcsWzMH+MR1DBtWtujqYLYfCVyGCtexevmG4=;
 b=FmkZaeJltl+Zx9erxYAH4gzIM0fIMQcmqKXr3/8fF2UFsc48BEcaK9dx9Rk/gKES3x
 mLd4gYQE8mXGoQlhd6p/9QtFCKIgR7f5nA3SEnyb35cA69RN36MqU6dnSMtB3Jb6lV4Z
 NcjM0DsF2kME6o9z+qKgbJ6/3yb0TRplkiGJebIE3x+39szjHJgFCo+Axi3X7PSfl4XF
 6Bfr5qQrMQgriwPK7h3vECTdyM6/BWl2HHoR/ThvGvh+PCTlAqfFEtKSX869P2suXMbU
 b+UctVkX7qe1Jx4bANUJFeq5veRvKBkB/D6PV/nOK3wiwvbMATBNVcJNh8+wF/3LCyWE
 lnqw==
X-Gm-Message-State: APuU4Z+FZqBxt0FfZZCErj4nRkbfFB9ScfbsO+/zvSpqXaJTaKSFsfAE
 d+Eaxkwd+ykqGlFEIw84wriG9kspCywDZLtYx9E25oOSrIo6HmWxj9YcyYQYYLSNjBwtto+6bCA
 g+bkrUpmkdRipkU9dC5a7tfUN5nqJeKTzl7nSXFAMzwPJ3/CvYB9iC0VEfQ==
X-Gm-Gg: AZFdTZcYwWTYqJoEswHZf9s+9sBDCAMgOmn6ASiY0CBK+R/8RYCijU5tKLyLPXomxlD
 5yqRPRW9Whd/c3oiDxbA0FCB4T/ttUcyh7zieMn5CDf0eZoLWTX7ny6lHry9CPRytPA+UGuwxYo
 O3eYrP4yRz8OJiYXQmtchFcTdTZ9KKocYRYgjPrGS9VSB3Fgw+r9z7syN8KClF4OFCaewzv6jxS
 VKKoaNobIo5Uiwm0aaVPY0zOD/FHYlxohlatD5efnlOLuKqV4OLX0XugKJTpKkptdaZVzlZGTBc
 Gu9PH+tsU4JngPbvbjHEuy8J8Rz8/O43GYVI0SXxuS06rRUsYmBmVioxz2//xwD17qTHolp2oYD
 PflCoLG0BGa8Enr4YDf8IZ1RFVsITTQnXtH6Yg/PddBp3Ba+B8qDwQzeyJmAKfYMPtjzxIe16ee
 U4HVl6s9xmTJLBWaEIAZz2KuKJP+WNefRU8I8UTbDPNkA=
X-Received: by 2002:a05:7301:e21:b0:36a:2473:9b2f with SMTP id
 5a478bee46e88-3810fa07a9amr886869eec.23.1794865757464; 
 Mon, 16 Nov 2026 13:49:17 -0800 (PST)
X-Received: by 2002:a05:7301:e21:b0:36a:2473:9b2f with SMTP id
 5a478bee46e88-3810fa07a9amr886837eec.23.1794865756664; 
 Mon, 16 Nov 2026 13:49:16 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955e0d966sm37826779eec.15.2026.11.16.13.49.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:49:16 -0800 (PST)
Message-ID: <4abc5ab0-1d3b-48fc-b128-cd64a4b4c2ad@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:49:14 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/48] hw: tweak approach to setting alias in machine
 macros
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-6-berrange@redhat.com>
 <ca8a6fcb-0b5e-4745-b5c2-99fb6770a62a@oss.qualcomm.com>
 <avt3ctAhBPoLXj13@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <avt3ctAhBPoLXj13@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CNr5ZF_yfduc-PSzVpSP748Kbk2OYI7N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX/BPgQotwZgYU
 DGaG7+h1GsODqoS0t0x8l0R44xs7civA8fHtzbbdvBhEqBGdQ4MOEdeE/ePq7WW8FJn3zfcxvsQ
 B8iKOmZTLcTSWuGVjyyeP4ur5yIc1Xc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfXyh+dWcZe9oXC
 jw/mFwx8/VICZ5tUF0ZMmn8p3gaRJzC0xlDj4YLYxmSAaHk8HsoS7APtXG6/C+t/CMNyJKtUU8l
 JqfiUmpG9+IzzgCGqFxBVNNBI/aTMdMNjDa+1Fzd+m2GCb6GFg0bk4pDkzCf1Zrxsdhd1cwd1KZ
 iCPSdYxXufPH3xPM/1csKkuTtR3iVFn8r95HECaLMrdFI+Hy0yLidfCM1BaDapOY90oQVxQefTv
 A8UAVWwT9K3IcYtM7F7U+EW2N7CKoauuzDhMJZbqtOZsHXu51RM4O7WVV33YyVRE95g/DQiYv7J
 6VXOAuA/sY8Qwi1FsPJdxFVQQHmTmNdilIgC/9iMzRngaeYlib0paNnq1mIXlLeGOZhxfXGUZTU
 eYy1yXVJWfsDnFRNQHyvqBy/edhDG91leKpo56nTfU8wiv+9NZ2HmaT187nPfYs4SAHbW7NeU2t
 zBfLQ6CssVkiyjbq65A==
X-Authority-Analysis: v=2.4 cv=Z4N5j3RA c=1 sm=1 tr=0 ts=6afb7a5e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=aOr3f1Vml4cNLhS51mAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: CNr5ZF_yfduc-PSzVpSP748Kbk2OYI7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160086
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

On 11/16/2026 1:36 PM, Daniel P. Berrangé wrote:
> On Mon, Nov 16, 2026 at 12:46:39PM -0800, Pierrick Bouvier wrote:
>> On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
>>> Currently the pattern for DEFINE_MACHINE macros is to
>>> pass a boolean "latest" flag as a macro parameter, which
>>> is then used in a test. For example
>>>
>>>         ...
>>>         if (latest) {
>>>             mc->alias = "s390-ccw-virtio";
>>>             mc->is_default = true;
>>>         }
>>>
>>> On the surface this looks fine, but this is actually taking a
>>> build time static characteristic of the machine type and turning
>>> it into a runtime tunable that only ever has a single code path.
>>> ie the macro code expands to:
>>>
>>>         if (true) {
>>>             mc->alias = "s390-ccw-virtio";
>>>             mc->is_default = true;
>>>         }
>>>
>>> or
>>>
>>>         if (false) {
>>>             mc->alias = "s390-ccw-virtio";
>>>             mc->is_default = true;
>>>         }
>>>
>>> The compiler should optimize out the condition, but we can do
>>> do this explicitly by passing the desired extra initializers
>>> to the macro directly.
>>>
>>
>> Has it been measured? It looks like a very premature optimization to
>> remove one if that is absolutely not on any hot path.
> 
> To be clear, this is not a performance impact. At this point
> in the series, it is just a bit of "ugliness" when looking
> at the code emitted from the macro.
>

I see. My tolerance seems to be lower and my eyes were already hurt when
seeing those functions instead of proper functions with a struct
parameter :).

> A few patches further along, however, we need to be able to
> set a list of aliases that varies per machine. At that point
> we can't be just passing a bool value in, we need to pass a
> block of code in.
> 
> So this commit is mostly about preparing for that latter
> change, the "optimization" mentioned is just incidental.
>

Ok, let's move forward.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


>>
>>> This makes the macro definition a bit more verbose, but it will
>>> facilitate forthcoming changes that require more complex
>>> initialization to be added to the class initializer methods.
>>>
>>
>> As mentioned on another thread, the DEFINE_* macros seems to create more
>> problems than they solve, and we would gain clarity by simply accepting
>> the extra lines of boilerplate.
>>
>> We could have exception of course (especially for machines defined in a
>> single file), but for global macros available in multiple files, our
>> life would be much more easier without all this.
>>
>> Just my 2 cents.
>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Regards,
>> Pierrick
>>
> 
> With regards,
> Daniel


