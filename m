Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317AFC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 05:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm2rA-000093-Eb; Tue, 21 Jul 2026 01:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wm2r5-00008V-AR
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 01:17:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wm2qy-0001R7-3Y
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 01:17:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KNCS5d045372
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 05:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pwy0I2HcgeXqVaG6BPQGV/xnhnZyItDOcXQ/p/yY0/g=; b=HPum/lUoJVhh1Ssn
 MG0rf9Eftiqns18mKHQVr1FW1/TGHnQ+tyvjDqoy5Nyqrplhfpp3pNZ65bnJnHFv
 36zet8n6PFJezWJmSL4ihKVK8PRzLzFNkwx1gixV7E3psXQtxC3VFkRNVDfZwMm8
 fToxgskxGKOVRbtC97ODCzpt9iEZq7aHiF/Q5YtAwZSt2DarPQlY6M9/3pMw4HWT
 ecxaNrOs3oD0m1bhgnqoKopKc78wInLsET79SHg10VV7wrfXi9G2kkphUh940QLt
 k+UFT4ucKgAj5KNP2DHwt/L9Qbc6QpplcIPxwvcQXHCVnF1L4EH1a0cF8preKA/F
 iK70hQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5tden-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 05:17:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso4047250a91.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784611032; x=1785215832; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pwy0I2HcgeXqVaG6BPQGV/xnhnZyItDOcXQ/p/yY0/g=;
 b=kXlCkIoFlW0CDdbdd7MRB7voMAPml/kRmvlPk4kJfSsEv9EBdnC6MQ5FsJBrz2OW+T
 dX7EFfovglCQA+p9D+peRLldWrB/wr4fTFG/TzWFMHzeKZWsm5Ej9mUI+LEFDucC5CjS
 hAJywbF6Rka9xZ3BUP9uhiVfmiu+agcoWPMplKyJFLfuqtSt55BWnaUigcKho+E+8o7A
 xtV7lV8qzijbthTFYUcojBioHZDXzXpZHydQ77gCNeWELsli/NNCuuZSASqPRbVe6ALL
 0LgoeDIgM/LxPw/W3EE8ZMKUvct5y0Q0wrfNiHSNj+PchsND2PVjcTky2QM6jGdpU7dw
 qWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784611032; x=1785215832;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pwy0I2HcgeXqVaG6BPQGV/xnhnZyItDOcXQ/p/yY0/g=;
 b=lbRihD6gmUgck1MJD0ziCKSxLHQ7CHAzDtk+o501fn9LTL3nb39H0RweI2339/hrc8
 H22M3Gbm7v3q2CvXwx/U387Nyof5n+bjfZc5lvWWGs4X/Eb3kHspzaizpgHaWZYX274R
 y8q7NMAVc0g7zeF4bgYpa2oMLjzmBFIp3526GTkD5tfIIUJ9V6DL2fwY+m0tTTmCfeTu
 0UUGBIF4Y0EENPtr4XU2pvdAkfN1LOPbslpTTj7Xdo22pIkl0bVS+1SBxDuKXnaG/28c
 Dn6mivZtzGVULOsIg5HDGYDa0bGfqRFvZSR1VeyHkbaNqBkhQvlhY1KQfcBLtctP6YMw
 yZrw==
X-Gm-Message-State: AOJu0YzeoBBlKedM5du2Q4GCbmKCjONh7QR2e6UuAXtX26fWu8ZEr9Wi
 ufLEFGzTyNOQo4JHx+ttc1clxNe96EoA80i+44nwbpGWXRCPRbDEMltT/x/BTY6H8ZmNpOoMx9x
 nBN9+5xkLdrid89qfBhoUq9xzR/GjHVwIYzhisRp+T/Wl03ywLszzPr6lTQ==
X-Gm-Gg: AR+sD10sqvgXpDoIc52ZwKr4O7MB3XDfbxAwmNjNC4sKMO/foDfmnMQrBfeisB0+GJJ
 HmZ+ppOCRpMBQjdfpUmYxS5fTJBxV0bNioxWozfEKuJedZQJpmUSSA4sojtYVcG23DynCie/oCJ
 YAJJbZ/FVapFyUaFL0Hcd6LAP1c5uWCJIroSk0vD92P0CPKQt2+IT1J9hwu25hQGN1wiRsJCKzW
 Q8Ww5ZOoOOBUiTzKingqu6DlIm+YJBbgXbh+tk2ybe5Ez/QXlppFTzz2TWEdBA2KbmLI5QEsw84
 XS0KBTjbbdKFRMZwaXWGXrs9g3qC9ibKS3i5nvbFWKaFphpjB4cSHIcL3Fb8VOEkI6vbHJexBjm
 XjorUYjll9By1eh7IUDEoIWaLScqCDpscNrknoznlahoxybo2yE05yLdSVa8DCSpX+RRu
X-Received: by 2002:a17:90b:1e44:b0:38e:584f:2515 with SMTP id
 98e67ed59e1d1-38e584f25c6mr9731401a91.37.1784611032395; 
 Mon, 20 Jul 2026 22:17:12 -0700 (PDT)
X-Received: by 2002:a17:90b:1e44:b0:38e:584f:2515 with SMTP id
 98e67ed59e1d1-38e584f25c6mr9731388a91.37.1784611031933; 
 Mon, 20 Jul 2026 22:17:11 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d0784011esm2764154c88.2.2026.07.20.22.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 22:17:11 -0700 (PDT)
Message-ID: <a0d5c160-fc29-4c5c-b82c-d79151022e5d@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 22:17:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] build: fix sparc64 host
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
 <20260720171031.259f590e@shazbot.org>
 <089649f0-b677-4c1a-a42b-eb9853f4fc7a@oss.qualcomm.com>
 <a2273203-403c-4da1-b3dd-0933dd70faf0@app.fastmail.com>
 <de6169d2-15ac-4f46-a249-ddb753946be5@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <de6169d2-15ac-4f46-a249-ddb753946be5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA1MiBTYWx0ZWRfXxXWLAKIHeFlJ
 uc1IVCFdZVPDTOUCiK0eIL9bofklAR6h5ogygqdQgYra+rjQGSFTW0vc+h2W4jkwnPpiI69VIVF
 IPVW8HsiRRug5V9DpDXn0AqgKsv7kixfaRqDXIOvnUFtaH0KYAQBaRPnzVT4tXaQazmmzJ9fQQl
 gElD1pg55hJl5C1VBe5tJd6hlGTxWIp+petan3h0iW6eA5+F2ausA0nVUZQopy925EGqbUXlXey
 5R0IwBuQpObI6DPr6RQyFRR5g8XECJcBGJRJnqCnvI5ajowHWeumPu4S23oT9EiiBU+jo7rA7gW
 zWX8z6djsA+8X7UnqTgwHZSr9/E4584+5sfSlnhvBR2F0ipPRg3Jzm76nhXmEoyMxj0tCnXllg9
 DOPTHfw/R+a0kwvxYXbSZlEz0GZHiIQyvMPwVKVgJOlE2nvrJ22E46euKIxEP1h9v4WI9Xngu0s
 aY3DlW71Y9M5nAjoigg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA1MiBTYWx0ZWRfX0jG/rmvuqFFZ
 QrldtlM4jlAadgj0U74c+luBc9JhRcGJnvwaeuJHBPY2aQb1L58B9TK3ykW+Z3l4mB7JEl+Brhv
 LA77ZmcJOO47GPoXcYyID0yf9u5phCo=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5f00d9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9qUTvQc-AAAA:8 a=F09qlkv3ylOdv3rp5iQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-GUID: YmwPnwp12-9luoVU52qop_IlPeiBpFLi
X-Proofpoint-ORIG-GUID: YmwPnwp12-9luoVU52qop_IlPeiBpFLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210052
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

On 7/20/2026 10:14 PM, Cédric Le Goater wrote:
> On 7/21/26 05:33, Alex Williamson wrote:
>> On Mon, Jul 20, 2026, at 8:48 PM, Pierrick Bouvier wrote:
>>> On 7/20/2026 4:10 PM, Alex Williamson wrote:
>>>> On Mon, 20 Jul 2026 22:17:13 +0000
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>>> It was reported that build on sparc64 host is currently broken, due
>>>>> to inclusion
>>>>> of asm/kvm.h, which is not present on this platform:
>>>>> https://lore.kernel.org/qemu-devel/c3a7cd83-7666-40c5-9baa-
>>>>> ebe64edacab6@tls.msk.ru/
>>>>
>>>> Isn't is sufficient just to remove the stale <linux/kvm.h> include?
>>>>
>>>> I don't know of a case that fails, platforms that support vfio might
>>>> actually be a sub-set of those that support KVM, but being dependent on
>>>> a KVM supported host has no technical basis.  KVM and VFIO are
>>>> independent features where neither should have a hard dependency on the
>>>> other.  Thanks,
>>>>
>>>
>>> It's related to a recent change that was made to get rid of CONFIG_KVM
>>> in the file to deduplicate hw/vfio/listener.c between targets. So it's
>>> now unconditionally included, thus the regression.
>>
>> I understand.  I'm suggesting the fix is simply:
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index c19600e980a8..008f488a3e7d 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -20,7 +20,6 @@
>>     #include "qemu/osdep.h"
>>   #include <sys/ioctl.h>
>> -#include <linux/kvm.h>
>>   #include <linux/vfio.h>
>>     #include "exec/target_page.h"
>>
>> This builds in both a native amd64 environment and a cross-compiled
>> sparc64 environment.
>

Thanks, I'm ok with this.
Do you have instructions (or better, a Dockerfile) for the cross compile
sparc64 environment you use?
It's the only host we don't have cross compilation environment at the
moment.

> This leaves linux/kvm.h included only in the following VFIO files:
> 
>   hw/vfio/kvm-spapr.c
>   hw/vfio/kvm-helpers.c
> 
> Looks clean to me.
> 
> Thanks,
> 
> C.
> 


