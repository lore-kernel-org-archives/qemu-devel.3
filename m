Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89444CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY2Jm-0006uk-UY; Fri, 12 Jun 2026 09:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wY2Jm-0006ub-8W
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 09:53:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wY2Jk-0002eH-P7
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 09:53:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CCinco3747638
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 13:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GUJirjl2yOuqerpocLDFPhTSBc9PfeNhyb5jWRHalv4=; b=FLHgDTcpt2TthnL2
 emeB9tkPhqYDjVnpLoCAewlnGUHvhg5rHgDTlQG/CV3zrNbI8ucmPw7/X/NjQWvk
 rHsQ3nYKhC99twMLALdxCuTI8O6MBpGQCioik9YlAmhXCmPUCR0rwQ7aHO1tD6hb
 gxOEfqqlzwvOmsuI/WSbGnrGc7LGUMw5zXl/j5pEJcD9ikevcEU3DqoO5P9oMLD2
 pefuRGOInO6tQrmXmKzLOD1VzvZ5AIBXA2bNlqAiXq4bRlVt9ApTFR0dwLPxbU8m
 RzntX8556NNuGO413MEQn6dnHYpdeAiccwIHFamtdtPXjj+JkxrtPM1BvDkWzZuF
 DV4IuA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76ej291-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 13:53:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157c8eb597so153880285a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781272381; x=1781877181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GUJirjl2yOuqerpocLDFPhTSBc9PfeNhyb5jWRHalv4=;
 b=ASoUbA0BcKbeigjUsraONXBbANgiHT7GbbM0T2/rIviZ0dHpeHkF1SaI8tiSAd5M3R
 iaMDHAA4fRD90HvBWtPWJezo0fRtY3OJOWgQROGYAqi2fM8k9KEwT/Ob+MkTz7cJdKHU
 sY6oUEv6u930JEzbXKTQ/tWml4pdhdTG3xtJ2YLnzmEIEf2p+jMNtF7IHD96vFmYvg2s
 +WLMASbE7GD3qHl814enbJN0nbIxQN2BUoDbjz9poI3HC8WrKtbnzq7niQxijIfS8JDl
 O9x+7pD4HysT2Z5ZIcNaEgK2b6WvkXJUWYg2sT2KDE2C7uc7k91lc88EeVflSFw0tIin
 kFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781272381; x=1781877181;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUJirjl2yOuqerpocLDFPhTSBc9PfeNhyb5jWRHalv4=;
 b=GR6A8bibCyuBOefpJ4nHWTM1Smq+PZOGUxN/P8VGf1DwQIIvpryZPP1lDS51ZN66dL
 kevl2MpTBL2fAWLTywCJqbonZ5Ro6RJlmcDq934hRT45DU/nM0ysjZO4ZUk3Ht+I1xk1
 28+cugTTNYTXr5uI4k6ugy5izjZf0px1wrm/kJfTVPOdA7RtAXzl4cq6WBFoW5qHOi4A
 x17RyPaeLEbhIztaq8bxPauSWumOBKHcZ4jnOndzwwtz5f2WjvqE/T2yg+7jTosZ2YCf
 n7zBYoK5w80whpXS+stDzpzcryyfFUaS6ugzOTs4uOrepQZLg6L+YPztByt5IWNo1Mqt
 Wxzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bHbBTmiVZj272g2Xr9kuhxPPMnPYjSqH27umV4Wj9K6uL6QmAtYHr1QVMDn9tg3fR8SPwKHixp72J@nongnu.org
X-Gm-Message-State: AOJu0YxVIm92Z39Z82W1+FE2IbPW7/zUb07sPWd9dBRQEc3kdT4tyf7o
 zeO8wOuVRwBttf0pb023kG5PtV8/tjRoUutyNXHUK49sWK6pKd6e6lhcemeyfOf2dbTK4gAitwp
 jGKLL2oxCq/784IB3pqu7Iu82gK65FUH/7EUBdC0+2KAtgJnu6EL5ihVXhg==
X-Gm-Gg: Acq92OFG3SrTgOO3uByexeYrhObaPO4bKX8ZlMow2whtvrjndqbwkjVczdKcporbUrN
 dLncBIRXZjEaYXazyuZ9Noc56j29Rxf9NtY8LYSd50ZS+jl0DR2vfoNaVnI/gjRwkndziaOea4v
 ZkF9/rHgFbwl3iBndnFXK02FGJfEMi9Dd8Dp0CA42KflYLY8zgdyqIZKBF+GRuFZL1Idblw7p6D
 +80cRE8EwkivxH3w5QNHSx6qe6LkXrtdyJQ8O4lSxIl9X74VeaWh5ZXgh4p3EeeJE1ZGhnG6hmi
 A4sK6ddFcKonF83EKN5yQe7Wg7JcPJWDZn6+kODDDB7PJdc7eV5Vipz4n6gI1+vV2JThxBFKWKc
 jp9Y6tIgKdx89BHHz6sJG/jeYohsPVcr/JFprHVFSBFKbSPSGVBxHjbCZLFgrXGmKmeT4gqyz
X-Received: by 2002:a05:620a:4515:b0:915:a811:1707 with SMTP id
 af79cd13be357-9161bac4a5cmr404931285a.5.1781272381552; 
 Fri, 12 Jun 2026 06:53:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:915:a811:1707 with SMTP id
 af79cd13be357-9161bac4a5cmr404924685a.5.1781272381098; 
 Fri, 12 Jun 2026 06:53:01 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm6259245f8f.8.2026.06.12.06.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 06:52:59 -0700 (PDT)
Message-ID: <3e68d61a-6ced-49b0-a122-a184ab83c6df@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ppc/pnv: Remove Power8E and Power8NVL spapr cores
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-4-adityag@linux.ibm.com>
 <2610e4bd-7ddc-4880-808d-3f55bb166938@oss.qualcomm.com>
 <e87e7d6f-2ee2-423e-9111-19b7f14f376e@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e87e7d6f-2ee2-423e-9111-19b7f14f376e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2c0f3e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VnNF1IyMAAAA:8 a=dC97xGjGZpUxjfkWrzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: KtWkKsY7CGgxWxAjcAGyjtZSNq2hI34s
X-Proofpoint-GUID: KtWkKsY7CGgxWxAjcAGyjtZSNq2hI34s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX+JJr3Zw0qyDQ
 zbXAjaifTiLJ1tV5izg9LP7HIZuBDQzIf1jG6bENU/5M592n/YUpoLBT4vH/T0lWrPwjerviNnR
 4wLNDhkPn07ogn7P/xESMLgKPLD9FtU1YPPEv2pUQlCh5ymMAFiyjyu23FdWOaAtSL1CRsdi70w
 90lIXp9cu34ADWiqOSoXslFr+fhkxeVkSTDN3u6jGMQXfK7XjvbgHUvTNkji1EAMsmjUp2qhV5y
 KNeArKizKXvmAH/FVE7DmHZSeAMFOrh82nMS2xMbhBwdNUXsfOTiXuYlRXjBC78+QChO1/6GA54
 UzdBWQkv2dD4RKNmgEb2mZnYhH5B4EQ3HSqBzExpcrWPa7TmK7ynjh5530c5onfWzRURkK/Wd8l
 zaoceH/mUMLbeS/Xk39CGa63lJ1LsMEn/dknC9ZVmJDAxMaNTjj0Wzj7pu1ElGFDUNczvZwf8ec
 Tm1caZxL6jk2Beh1KMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX+YbGpNNLjTcr
 YvktBKBsmpn+5DAxfUDDDJd0DeNMOs/gTTQB+edr21rlPbXiNf5k4fwTtDH+6wmXm+MSh69IBq7
 aY4Duq9WG2AyZPD7ihVf9h8ZVBKLNmo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120127
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On 12/6/26 08:36, Aditya Gupta wrote:
> On 11/06/26 12:12, Philippe Mathieu-Daudé wrote:
> 
>> On 10/6/26 11:07, Aditya Gupta wrote:
>>> Power8E and Power8NVL were deprecated since QEMU 10.1, with
>>> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
>>>
>>> Remove the corresponding 8E and 8NVL CPU cores from spapr/pseries
>>>
>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>> ---
>>>   docs/system/ppc/pseries.rst | 2 +-
>>>   hw/ppc/spapr_cpu_core.c     | 2 --
>>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> Squash with following?
>>
> Sure, you mean squash into patch #4, the target/ppc change ?

Yes.

> Thanks for reviewing !

;)

