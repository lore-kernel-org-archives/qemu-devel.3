Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8285C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp7uL-0007xl-1l; Wed, 29 Jul 2026 13:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wp7uI-0007xP-D2
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:17:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wp7uG-0002Lr-3t
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:17:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TG4wqw2545838
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 17:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wGYMIrko+ednYwDm2MPOCaj+M7wkN3azRWAHFMua4yo=; b=Ua1k0QyPJRZNm9Qe
 Xlr+H2/kkN+UkhE+DTgb9anNCGi9lbjszTH1qOqZHNVde7yrsoO0xNVbqB6HGhxp
 vfN2/aoz4eGNoxJP3HspmcPfbnoc4Z3IvLagyXx+mNSY5Ka1Gtp5SxglDP/87sBD
 osLqNUP+wzVDERok6M0B6BkR5je0Ate9sPdA9IHt++chkMgKmxfv9lBq5ekRmcv2
 WvNaJ4qu+DW+0SqZ2FHTz1GlClL4MBXh1fkVsBKN+VIqLkaICrM0SebPvSN3ae3b
 aw5BYJOXwKpcZlL2buPyeaLoAgxCvLkI78SFOthduE0BVkgj6O6yiT37/KMjuEgw
 9VurDg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqmqsrd82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 17:17:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso1473869a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785345441; x=1785950241; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wGYMIrko+ednYwDm2MPOCaj+M7wkN3azRWAHFMua4yo=;
 b=UhKb57DWwmzYdymmvLVN5k4nOQ9RpMeo/P8+lmxFYYY61eMVAHV0Zl6OfFlABo4u0h
 mlthijPpm+a4IyFTQeVRqQ9E7aKDBD3AmaZdkMdVzjc5EpY66Ovvqjl7S/OrkBn10WbP
 mmdbgm9ql2pHxCgK27twIRTUYYa7r20G4X1g2dRsKGgCBHECZyL8/ZljkdGsLLRlI8Y0
 mRO9uZBNol0zUPLQhrPTO6jqPBrP+02na3RgoWlipEEkuBadMhynqnNOpd2QYPyS6U/B
 xOugir2D/SUmC5rRKvCpyaWZtiEsr+O89SCJwaKAEeEoNnuC9f4afdL/G2UU5q0aHnD5
 P2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785345441; x=1785950241;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wGYMIrko+ednYwDm2MPOCaj+M7wkN3azRWAHFMua4yo=;
 b=F3AUXHp7TyxPUhVqQQHg2pebaIMdg77yUqB7Iot8EwMsinweDmTP/yfiSqu/4cqEFO
 P6TqWz0tkCawNCmbCTdA5DpnFVpPijFHtOBqBZqesg6FRIsU6e7Ux4Vx74L9rL3g8LPY
 zdHedm81Lr+7cOY4m2Lchqt39m5i1Cv+9TOYgYUkpelgSW4bRot7VlMMZCjdWDu89rde
 OVv3tJKDYe1GIspf6rnqJfQY+MZxGVWxbUqfyXUQHfvsIe/TECDQ4XKCv4cIAatoJ4x3
 VazhDjiQ2q/TJ/A5CVsauWUV6PIlpfqxVuWBtfp7kQ0G0y2wpcCwb1nTrOZXKUqYWlmd
 crTg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4cvKo+P/fSwzOFG208C5rLQ/GvDl0WHT0MTMNu77rES2YjV7nR5kvPmMwB+tep2UOlaui89gFKAzk@nongnu.org
X-Gm-Message-State: AOJu0Yyu7d3UK04pR2mV+nTqDc3ZPtYpCGeJ8NA7nxYB/X1T6PilnElq
 ZF8fegGk4OzdeQ2CiECIB6i0XcAz7ar7MyFqFgI7rnKGiVushPntxPTwQSlJjfyRuA61cVu2Uqo
 GSC1Agr2U4MM8pfUHBjRcGWOrXA6U5OP4RBkSjbDUX+jkeyqHEvYwrB8eCw==
X-Gm-Gg: AR+sD10QnrXyLP9xyieqH6hkiJntVxn6BgKbDdXhcAwctGL+mL4cNeM8fa/2JX8lJKv
 GKPMjIMV2whytW+45tPfd6Ouau6SsJ5eYAz0Z5dSr0kRpwQum1oZrZeKQ0ZnAlWHE1yBaXbTrUz
 Hh4pQXy45QVlxRpfqY9sNl7DgPGvVyLNBew7ChNnaAqWlPIY0YSkboVM2bG6bLdaDxRtr/rSdSw
 l1HCeXeMu8fUVtnAqC5XDcpJGTImP9or8ufRKBPRdIqAYPhmspWjarwHKrOnIIHZzQl4XSWepLn
 EZngOGYXv0EPo7PQMR3I2e0BmkgzcTM54cr/dPjoOVFHVn5B+QmVQs1C7im6FmRE1UjOCaxqQN3
 hw4hDpbDzD/Pj8oc+kLibQ82F1vfzoN8fjPVODk8a5f1lN/HUANPG35sVijkiffQlsnL5
X-Received: by 2002:a17:90b:1e48:b0:38e:7069:7125 with SMTP id
 98e67ed59e1d1-38f6a4ebf18mr7105575a91.42.1785345441088; 
 Wed, 29 Jul 2026 10:17:21 -0700 (PDT)
X-Received: by 2002:a17:90b:1e48:b0:38e:7069:7125 with SMTP id
 98e67ed59e1d1-38f6a4ebf18mr7105552a91.42.1785345440623; 
 Wed, 29 Jul 2026 10:17:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b88e12sm11794105eec.11.2026.07.29.10.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 10:17:19 -0700 (PDT)
Message-ID: <b6f87681-83c2-49e2-b814-4c94d0c3cfb3@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 10:17:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 000/103] tests/tcg: run tests with meson
To: Aniket Sahu <asahu1x@linux.ibm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <79992c9a-1267-4512-aca2-7187e0925789@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <79992c9a-1267-4512-aca2-7187e0925789@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzNCBTYWx0ZWRfX6+/c3/7BLlGr
 6t5ItvL8qyx3jntZIuOeKzrwMviyOTOdj0W4+R5rBcv2eDT39+pJkkHXvajQaTK9I9IUzXrtJwK
 N9JpijzqUU9Y4G8d3kUIjbVgoIlvmmg=
X-Authority-Analysis: v=2.4 cv=HdAkiCE8 c=1 sm=1 tr=0 ts=6a6a35a2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=d_YGY-zz4ozj_5gnMjMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: cSbm_5EwjSnQN--9WD6k56FihvYVZqHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzNCBTYWx0ZWRfX6JKH+S4eWdx1
 FsbqTFnyi/0hD8Fef8mJdl3Ye3IvJ4Od04+xHMejMwr9RjHIRBy+/nmpgNb0QJHRZMRjAV/xlXI
 hibD6DzutsOrXj/uWZwT+ogahWdQ77zIejdWVDro/bRsqV0f1JjixRf1EYW1yv+eD5lWTL1bRdq
 gb+j79UwMpmJtf75OxIPfx8SDe4Wqm0vrFZP98G2QbwaafN3cvDtCwqRCibZiBJ8/TnRIyiXdw0
 IX1FJYPnGOeV21wCn1IGJ+hm0pPKRzYQTXfB+nw21+mned5WrkVN1ebDWFPymU9usGFtqxLeK21
 UNfkRv79k+ZEh3FfGsbe9aSIqq7XC+DvQu2+4UEfE3SuZtO+yc+ILnORWYB/hsWFViK3t7jH2GB
 UdP/Fug8/4PIGqcc2Oxw3vAnYjrbrrGzFZBMGaQVW6FXYRxVm+QsNZvKCtorrrDj1wU0AXnUg8V
 FcvBnioNGcvUa49BNdA==
X-Proofpoint-GUID: cSbm_5EwjSnQN--9WD6k56FihvYVZqHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290134
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

On 7/29/2026 4:24 AM, Aniket Sahu wrote:
> On Mon, 28 Jul 2026, Pierrick Bouvier wrote:
>> [PATCH v6 000/103] tests/tcg: run tests with meson
> 
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>

Thanks for giving a try Aniket.

> Platform details:
>   Host arch:       ppc64le
>   OS:              Ubuntu 26.04
>   Kernel:          7.0.0-28-generic
>   GCC:             15.2.0 (Ubuntu 15.2.0-16ubuntu1)
>   meson:           1.10.1
>   ninja:           1.13.2
> 
> Commands used to build and run the tests:
> $ mkdir build && cd build
> $ ../configure
> $ make -j$(nproc)
> $ make check-tcg
> 
> Command output: The test report is very large, so I'm only adding the
> final report here
> 
> ...
> 1476/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_sext    
>                     SKIP             0.00s   exit status 77
> 1477/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_shift  
>                        SKIP        0.00s   exit status 77
> 1478/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_sr      
>                 SKIP             0.00s   exit status 77
> 1479/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_timer  
>                        SKIP        0.00s   exit status 77
> 1480/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_windowed
>                         SKIP          0.00s   exit status 77
> 
> Summary of Failures:
> 
>  117/1480 tcg+tcg-aarch64-linux-user - qemu:aarch64-linux-user-gcsss    
>         FAIL             0.11s   killed by signal 6 SIGABRT
> 
> Ok:                228
> Fail:              1
> Skipped:           1251
>

Skipped are because cross compilers are not installed, and our cross
containers only support x64 and aarch64 for some.

> Full log written to /home/stuff/code/qemu/build/meson-logs/testlog.txt
> 
> 
> 
> Failure noted:
> 
> - aarch64-linux-user/gcsss: SIGABRT on ppc64le host. Confirmed
>   pre-existing on origin/master, not introduced by this series.
>   Filed an issue for the same: https://gitlab.com/qemu-project/qemu/-/
> work_items/4106

Thanks for checking it was existing before.
Unfortunately I don't have access to a powerpc64 host, but maybe someone
among arm maintainers has.

Regards,
Pierrick

