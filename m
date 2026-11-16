Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA91606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T+zjTZ71;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IOhFa258
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT46A-0003Id-KS; Mon, 16 Nov 2026 16:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT463-0003Bu-0q
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:18:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT460-0001OO-VN
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:18:38 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfTfn912874
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ok8sZcB54V2dpqL7twpQAKZ8IKlJb5cGAD03zqGobv4=; b=T+zjTZ71Ao835+V8
 L3fMcPeWnQojwbZbsp1VrTZCHElwErnlnI1kMs766SgKrINaprQymc3K8OGNoQYF
 Jb/5Kh4Kgf4UOWY3//5mXugV4jckPi7OOvwOwFsp3ICAjzHJKKtMiQz+489akzl6
 D1vwGTzxo5G5V7W/09LmsLDU8eEaakGQ1fw/VQXm/UcreTaQ5M3dhNmIVLv1rY2p
 iBIt0qCElKrfCDaUZHNjo4VD5WeRsi9pseJ/xBvZv0WQ/JcN3VkTpsinb0Pv9c0A
 RFgocLt4MISWYnRFnFjSA1J4whuee/70D/pjqUY+/pyv9cOc8xAPzPqCws1fbc12
 8I4DxQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y1s6j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:18:35 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d32175c486so517408137.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863914; x=1795468714; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ok8sZcB54V2dpqL7twpQAKZ8IKlJb5cGAD03zqGobv4=;
 b=IOhFa258Y5f5JdPIj5QBKWt3QpKNw3ZviAJ3Zknm85STHy1pG2vT/uq9p/XcS3JMTL
 oAk9Y2MfgugIjkDEtEqsKP9WVfh5bJ94ZgvEL0F9lnHZYf4bmyVSKlNGEptNOczbCYqs
 E4syxYrnI+XGY9TZdAtIzQLWqQIv6aagmATbjXLuwjQ6acWxLlnvkbS+NR3zGr86mwc+
 0UNDSF6dsLW+m7oVPIkbBXN0vzcOZnOf2suUJ5EUTikHjJvYX6YzywlDZerpEgqBNxb0
 1paCGIuVTHpB5znPZgW4lPGFqLN/OJpSc3uGgNZb6G0Bo+mWb4EuhyjNMwCy5jQbHD83
 7V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863914; x=1795468714;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ok8sZcB54V2dpqL7twpQAKZ8IKlJb5cGAD03zqGobv4=;
 b=IIu0kyQFQEE3lqKWVHy6Wdm3ntgiAK8EBZhDH4wbVHDCimcA7FGxM4kU/6EcTW1slS
 JK5CQxQYayZQH/kpN7foecugDBQYMvbUTM4mtinhqp7PrkzkMyTXPWAY5KLS8+RXSSAM
 fe+m0oclKf3Pz+bNgPBbpe4/5Vn153wQI4euNuPk539ELYnBKqW7Lvecp6h/WnnAjQLy
 bG/AnSB5YejXpVyZ4q0+I3BBlHKLk/qBL5sqTZo2uqSQxcX8n/0m7Ek4TtCoRqjI1L44
 gyDAHQG0Fhkx7dOfk9l0hOdbouwiyQa4WYD1teUWVfT5A0z7ssAnMsyGi3l9ufrUKPho
 I/XA==
X-Gm-Message-State: APuU4Z9kiXk03STA1ZHCy/YVzfmCNR8lmYGfZcqtyYfERseRNyfUVdGw
 Lhc/xVMGeTj25vkRHB9+0RyxhS8NrSgHWFCEJ+rnv/b2pJBc5jugJlRmN9bHgzonqil2CzFzn+1
 j6Opjk3a3j2Bj14Re4YmP7QM6ChxnIKU7/BwJK0TRgebZIZR50VVPdwqyRg==
X-Gm-Gg: AYBFou0ZGQDycY01Nu50joHyJG2EoGa/0jz2WZj7g/i6om9PhGYI3mlCt0gt5N38JO+
 2+syl02kTyvzca6Yq8tdps5t/xe6+Snk8rWWBorPOBPuRaH+veYrhDYDDOkyRoBJhPkp9eXa3yS
 rjXq7Mc3qftufKLbfZQCnZCs34Y4UbsoFlShCCxb2sbd4TusDH2xM8ya29DkadL67FWx9eNNi/Z
 jLgmcawNhp6D+UFXJprZPnxsDvGbRvUOkkgqBwZPUeuT2T6Jwfba5bQDqWSiPDCD0wv3mfo7Str
 bvHihWJ1aKN329gtjGiRFZ+Qm55sEO5nLPfIWLfOUl/VJ2MRlchEAU4nnkpd5cGZZkAJOS18Auq
 TMrHTSOF1062+MMjG8AZMuAFGueME/LqWGwuvMHe2hJtKwC09V566YDFGwwoGGquJec7bHrAFIK
 QHrZp+kGw=
X-Received: by 2002:a05:6102:a4b:b0:7cc:1192:563c with SMTP id
 ada2fe7eead31-7d64d770298mr3151472137.25.1794863913972; 
 Mon, 16 Nov 2026 13:18:33 -0800 (PST)
X-Received: by 2002:a05:6102:a4b:b0:7cc:1192:563c with SMTP id
 ada2fe7eead31-7d64d770298mr3151460137.25.1794863913420; 
 Mon, 16 Nov 2026 13:18:33 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78430918sm13301425e9.13.2026.11.16.13.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:18:32 -0800 (PST)
Message-ID: <6a2d6288-51ca-493d-a805-b0c95cd73dae@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 22:18:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/26] hw/char: mark common serial / console devices as
 secure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-20-berrange@redhat.com>
 <1725710c-a202-406e-9eb6-d8a42a62d86a@oss.qualcomm.com>
 <avtGD4N677h5o85q@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <avtGD4N677h5o85q@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qYNTevhfMROj-yKTCizQGmmoeng6RYHS
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afb732b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=a_i3EzfmGNxZrRuUMfIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: qYNTevhfMROj-yKTCizQGmmoeng6RYHS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX1Tal5YZj1eOI
 co48Sf+4T7gCaqtGmI9tVvcNT7GbFUZT3xWWv2O44mC+YuQJljEX9gcdEAlUCjTTfb4ULJTa0o1
 M8h5cN/1Dj25FaD2NayRwx3zJDJ5Uls=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX9C7P1DMCifey
 5tozO8VqyGxt19q34L9D4S1tSpeGtQycqAq3kHj3IXdhfJ+1GvSyFrK7vTQIVZ1EgJdCVyDUU1k
 VjNC37k6YyoFJHT9ZZEGE0VRL+QLUiiEuVyc9Y5MdSSKgmqXj+7esuhxdQ51CR+ixsEfdUCcutx
 i6CG6C7tVcmx6nbcfMYcsdM5xDy59WD1IpRQ3QLqPw0DEyO/Sw+IOAEsu6t2u6rrmqCax/68GTU
 dQ2z4ugCt4IDrzRcu4D8bZ2DVV2q0v3sQ0dyaJqgw86zU/6wqsrPdDTCVvNmZmByHsvgM/qCRhS
 D41H5BXMVHLyll8oTvIQzRNZQSbUl3L9EKbJDXTrr30h9NC1Qx6yiCOnq0E0QdZ7x/RyY+/zXdu
 3SkqSXlNp9CLUpzVnD/KGuicbSK2sZjVgM2HAECnlnXDdLB6Vov9ExEFxXLvYlP78NiFgtNxZaY
 HSHxICitIieL1bXkXEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 16/11/26 19:06, Daniel P. BerrangÃ© wrote:
> On Mon, Nov 16, 2026 at 02:36:39PM +0100, Philippe Mathieu-Daudé wrote:
>> On 13/11/26 19:42, Daniel P. BerrangÃ© wrote:
>>> These are needed as a baseline feature for many virtualization use
>>> cases on x86, PPC64 and s390x.
>>>
>>> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Acked-by: Cornelia Huck <cohuck@redhat.com> #sclpconsole(-lm)
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    hw/char/debugcon.c       | 1 +
>>>    hw/char/sclpconsole-lm.c | 1 +
>>>    hw/char/sclpconsole.c    | 1 +
>>>    hw/char/serial-isa.c     | 1 +
>>>    hw/char/serial-pci.c     | 1 +
>>>    hw/char/serial.c         | 1 +
>>>    hw/char/spapr_vty.c      | 1 +
>>>    7 files changed, 7 insertions(+)
>>>
>>> diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
>>> index a1b370b90be..f38ce7b765e 100644
>>> --- a/hw/char/debugcon.c
>>> +++ b/hw/char/debugcon.c
>>> @@ -134,6 +134,7 @@ static const TypeInfo debugcon_isa_info = {
>>>        .parent        = TYPE_ISA_DEVICE,
>>>        .instance_size = sizeof(ISADebugconState),
>>>        .class_init    = debugcon_isa_class_initfn,
>>> +    .secure        = true,
>>>    };
>>
>> What is the rationale for using the debug console in virtualization?
> 
> SeaBIOS/EFI are in the virtualization use and the debugcon is how
> you get logs out of them to figure out what's gone wrong when they
> break. IMHO that makes it worthwhile to include, and as a device,
> it is simple enough that it isn't likely to give us a security
> burden.

OK, fine then, thanks.


