Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D04C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 04:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkx2K-0003fY-89; Sat, 18 Jul 2026 00:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkx2I-0003fI-LC
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 00:52:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkx2H-0000hr-6M
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 00:52:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66I4NC8s3891576
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 04:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z+zOoEvEiF9WudrD0BwBrgA0gcrVtJ2X7XshIAskqOU=; b=fcbUoP3x6hOYKmB3
 cmSjyGQ8+23HsBIdy58E280xrqvVjpOkx6IXXrAUxeEQiLDvFDkWzhT+4mpQj7b0
 RhNXoMErXZF0T2tVUClpUugXVm58I1xv64Tbk4l+AUQZln0RI0HhGRY/Fgrg4Izg
 5OO9cVj4WUDFPnJBXCC/BaczqiDK/G2+SEEMu7OkF97KkHIK63R6O27QRKIyy+uA
 f0TLLbLN1hDLSE1JtHQXiY7oPSk3NL6iVR3j6i6R8EFdj9iVOj5MXs/MTMS/qEA0
 FF0cyOsQeJpXiKogtezKs4Y7/UsJJpMd3kBdOlg/PX8f41TL6ePEa2sQwbTvF6mt
 jRw7hw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc01fg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 04:52:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c890bac374eso19729510a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784350342; x=1784955142; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z+zOoEvEiF9WudrD0BwBrgA0gcrVtJ2X7XshIAskqOU=;
 b=FZ0o0tx82tFnP6FjZvLgueLwbTYrCGZrWtIrPmJVXyaTbEHx55/QS6E+uu413E7O5P
 ukGjjLTkl69uthh7m2ELe2my24gtCA+v+0yIPAnrlGJort0cPPJpuCDtMYGj3TJB0eYp
 EoP/sUlJMUtokSKXhf4Bbk8ysfjxnhoe8YFGeZST5cNedxL+B6jgpkGn37jQt/7NXSP5
 4fm/NTUp3lQ3VMsVl2OkLytc87X5AlsAj6fs/34P8c2C5uaQ8fwlXKWAVJlw5jHAhbVO
 1qX8K//jUV4WU/MeykaoHtrHBPvE4xFm+/DTFlGfN/MEo9oRTnJZfRm4zrKq2rBFz7Rf
 rd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784350342; x=1784955142;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z+zOoEvEiF9WudrD0BwBrgA0gcrVtJ2X7XshIAskqOU=;
 b=i4wqTR9w0b8skcIp1dviI0e/HAMxcTdBKhnUp0Iv1RvoSb+W/NbMfnDhHjDYqBnnIy
 gc5qNFxZSZAYF1Ayphxxai1XCsk+2czDItmHSYhbyCA9AYKt44+hbnt0/hF01/nM9HVE
 M1TTyfC+VowZKRJjbjIjMqodxOuOUlBggq5/6lWhFc2trQsXaD0BOZ9VBvP926Lp4cfh
 e4yygzwX3U/hSn3Cg5EhVQ50x5UBWZfsQWJLtLbtpYlMn5geiOBDJvRRSaUWp6UsxOvf
 ypQrsq5XXpdMi52eleHKd5qUsncQB/Roc0V86vfFzVjDmnWV8Kmrow0GrpL00mmdR9fA
 Rd/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqayMDzGrF05YaC8GPdIaY0HTK3nmMfFlZO+FMSz1CakqUWsRhRQuKeS/T8Z+uF7UAoP5FFue4ug7bF@nongnu.org
X-Gm-Message-State: AOJu0Yy03MvSo0kT8ESYdmqP3/+x21jzDMuA4Wi9pgowgX7pQ3IqhI/K
 Eb8zJ/LIrARJ2WTUwZKA53QOGRQ+rApNqkpmzXkbwEK9xCRB08IuKzI8Oje8SwJDDJ6Ah9HnhTY
 67PlCo5lQNbRSwDGj4VnBtbRp7He/ia9T0BdJH3AkcfzHdJy9E8LMRSTjaA==
X-Gm-Gg: AfdE7cn76YmLeAN0O3DjlMQAMo7ltSCxjgRf9ca17x0PrLNipeTH9Lm4+H0aZWRDyow
 jKngYigESF8bElTbwbNF6QMKDFMPrC2QqqSRIhgMHdPFk4iU3l27wqt7kdzojT3uE3ngKkuoWon
 Cub+7RBSdcEtMoUu0UX7mli0TXy+62FbA/rNENLVSHsT07Wbtb9mU2DFPMZmvvRdWqsaDUef89I
 /NuUYLtaIcIvNo62SQTbflowe8KKxQ5pJFlapW4LkWGDd4EoBTyIwHZGLJK+mos00G5i1zTR39d
 RXuZo+1fMZTa+nHhnyz1oBmDITql+LdS/tk8X5wGSWK8D+WlJYlpYwmjL6Smpca9JwEppRerf8s
 Odvj86QQR26Wq7vghfHd0XAp5w2DezIrI6JGi/PB+naJkzzqI7QwC5OAHvXMfhfDcUHHz
X-Received: by 2002:a05:6a21:1506:b0:3c1:c6e:9360 with SMTP id
 adf61e73a8af0-3c3ad844369mr6126181637.32.1784350341909; 
 Fri, 17 Jul 2026 21:52:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:1506:b0:3c1:c6e:9360 with SMTP id
 adf61e73a8af0-3c3ad844369mr6126150637.32.1784350341421; 
 Fri, 17 Jul 2026 21:52:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fe4677sm11266202eec.11.2026.07.17.21.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 21:52:20 -0700 (PDT)
Message-ID: <73d87f66-6907-4e02-8026-b89c49912aeb@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 21:52:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
To: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
 <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
 <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
 <d3f85639-e6a4-4917-8300-d48a7852662f@oss.qualcomm.com>
 <5dc9f2fc-3bd6-4df3-8496-44e6037b51ad@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5dc9f2fc-3bd6-4df3-8496-44e6037b51ad@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDA0NiBTYWx0ZWRfXwqgfQ1+KzkyA
 NxwZ5TfdGq/rvhoEF+9S0rqgxu2tQewee87FeVatVJszlxQ6fIPpI/ZvSU1qgzO+r4GEjZOlULT
 tzWsSsSulo2aSS1EAt7spkO1vUQYVfk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDA0NiBTYWx0ZWRfXyWQvrFMqZQcU
 UIo9CT58jfQ3rCxdr9k0jTA/RMxCHXpREnXNsHRFOYOGi9k0Wv4GSZWl2JgRcNEz7JwH3QpEJRG
 e0QPNDaFia7raXFl4Kns0yB1JfNTYAR4W5j7fsa6vTCLitzVz2tLfqIwSVkmK3qQ1mHPXgjkT/x
 HPd5v6JgFE35fQw6p5IFGcDsvj0g4M683fk16UqXs4gLQ7AP6cA9vRhLcaZ2T65mpHzfiUEPymG
 29S1lwG5RNpFSMXfZvoIF/nK8tnAwlzncO2Bxsu6RghPWPAKMZq0kjtmAfutMjfcejD/0hQ4BM4
 lAOMcWqAQaQvhvq8rRxyHLiW7zFzGHyNm/MJmgaWvuaBaXaUXuOWmbilx0m9N7u1vQPL00qkIMf
 sfISYe12icTiN9WyOQR/KnMmU1y7VgLyT3vx2Af03ZgV9Vf9qG6F3aHGzg1qbDcDf4uIuywonYX
 WbnTDw/NS2OCggNxk7w==
X-Proofpoint-ORIG-GUID: yv4iwy-RkJBAmzV99uWF4D9nu1Zyk6CW
X-Proofpoint-GUID: yv4iwy-RkJBAmzV99uWF4D9nu1Zyk6CW
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5b0686 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=pWJUZo6IXamL42iKUEkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180046
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/17/2026 9:14 PM, Michael Tokarev wrote:
> On 7/17/26 22:40, Pierrick Bouvier wrote:
> 
>> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/vfio/Kconfig?
>> ref_type=heads#L5
>>
>> ```
>> config VFIO
>>      bool
>>      depends on LINUX
>> ```
>>
>> Incorrect, and it should exclude Linux hosts not supporting VFIO.
>> At least sparc64 to fix the current issue.
> 
> Shouldn't there be "depends on LINUX & KVM" ?  At least, this
> way we can do --disable-kvm and it will work.
>

I think it's a safe choice, but not sure if we are supposed to be able
to use the exotic combination of vfio with tcg also. Maybe it doesn't
make any sense technically though, I don't know the arcane of vfio.

@Cédric, Any idea of which matrix of host/target is supposed to be
supported?

> Is sparc64 the only architecture where kvm is not available?
> Somehow I doubt it's the case.  Yet, on other architectures
> without kvm, the thing builds.
> 
> To me, this smells like a bug in debian, - missing asm/kvm.h
> include in linux-headers - so that some headers are missing
> while some others are present.  Or a bug in kernel itself, with
> sparc port lagging in this area so that even dummy asm/kvm.h is
> not provided.
>

In upstream kernel, that's the list of architectures providing this:
./arch/arm64/include/uapi/asm/kvm.h
./arch/loongarch/include/uapi/asm/kvm.h
./arch/mips/include/uapi/asm/kvm.h
./arch/powerpc/include/uapi/asm/kvm.h
./arch/riscv/include/uapi/asm/kvm.h
./arch/s390/include/uapi/asm/kvm.h
./arch/x86/include/uapi/asm/kvm.h

It seems like there is no concept of "asm/kvm.h" stub in the kernel.
Which seems reasonable considering they have Kconfig for this.

> Thanks,
> 
> /mjt

Regards,
Pierrick

