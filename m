Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131EFC44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfIR-0001fm-TD; Tue, 14 Jul 2026 11:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjfIM-0001bP-N7
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:43:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjfIJ-0008N2-9A
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:43:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcjDL824481
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Eoq+/7h2b0kre4ErgL+wFaNhe4oD1SxD77IDQB+BI5k=; b=PKM9X5Xri5+tAVBc
 O2lZ8vESuUdVH3R1p8XpVsstXngZmx9fUWPpRGAUqAtgB0976ieethGEzaBs0CaC
 ahv+KTzuDuX8ZxXpgBosUSJSth/5k1UEkP18ATC4iyywBzeStRH2ie3idKLPquR/
 C5YjRgC6i4GM3xXqiG1odldsvbKt7i45/W3ZT0sZ17xgRstzo0yXhEN4tZigU3Zb
 96BIl1GchuCwYlhYHzCvfLkCgG0N2spRl8lX2bjUeVXh71B1KHGJb9kBaKRXI/66
 VAiT2TjUz0joxQOpIbd1M9KlEe121CyFWsGwsvwSM8IDcNBpQDnSaT/LWCxn8iOI
 lUPtVg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr4b2wt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:43:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso6573096a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784043816; x=1784648616; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Eoq+/7h2b0kre4ErgL+wFaNhe4oD1SxD77IDQB+BI5k=;
 b=Rjn7SMqNbHyR4BLUibOLpHn3Aid5YzLZexc7YeA5OAeJYU15p4QV/ddGyD117+gDmA
 ttFjaRmI8mrvNCxdXLDUUuhyie1wOtug6UYEDBIbpLlfAwNGNzL6Dr/+U+RXCOCrIm5J
 3PviePacbcPe5p9BX9A7esfbCKDlY6jhsX+YpBPyp0rofMr87jZbC0LsfmkY8Tf6TKOb
 p1SqooGhKwQMPT8s2R4yaVJGG/JMeMoINLo3c6gpL87UhHt3irANueky8r7MBAZsy0QH
 eJi9M5i4XROHM0tEnY6O4dITQMWyMQV5QVrhKM6fxVICv5XaQattG2LV2SsCsdeVnvcz
 HkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784043816; x=1784648616;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eoq+/7h2b0kre4ErgL+wFaNhe4oD1SxD77IDQB+BI5k=;
 b=GfRijR2X1g2Qnsih6P6x/jy8Bp7Ao4mDKBZfj7UtS6li7EFwhXkPWSmefc3KBmVPD7
 Rc9QutSvAzKO2yP6Xbs9H7Zar8QetQqBCaOEq4JbKrsySX7vImsqFeSZN3qjM7s0RhhW
 XpjpLArdSut8dEJ7nb3Td5sLA0BBjL/Q/Ge/aDmE8FSbuxPHFWZkbDwMNcTwZb4BnSIj
 /yS0pqLHFCdyOdTqZMxpLBe+JSdEQklGy5C6J0o2qWCUqs1d/Yrk8T6kesshYYHCwPe7
 oCDOLQaCAyf2gihqByBZ6hWdNWT/pUIb71iwjoW//CkRgunMfqklyE1uPtsZoVIr2RF8
 yDyg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1Q+1u2XhBhmj/iM0N+pThlddN7xE2jRp2jNt/sALgzklrq9jizkSSzSzOGtI8Omq8w/64Yim6w6vB@nongnu.org
X-Gm-Message-State: AOJu0YyYcdN3IHG0UR2v8Q2foANXPUSIAI3gJs7NBJZEYLou4EXtbDt5
 H8d1aX3KbzqcrmfQIJiASeS6YdrkrOqb2XN3roNXj6M8Ga7E+gj+phNQognQk493OG19y52oLY8
 HmJohUfDQ//h6E2F/+UireQZLk/2uG30k6uGYRvNas7IzvDqEPl36u5s3MQ==
X-Gm-Gg: AfdE7cnBjiT/rtdEqn8j5KoLFGIciobGmZfc5CoC4890HNzPhaE9TxHUj618RliM1jQ
 uBLN+v33ezdtHT28ehTmrRMrLisvw1/z3j+vaF83f2nOrXjtgbjxHSG6ILe/T5p/PXh7vyeq4Gq
 9NXn0OZe8SvC8sNFxJx/btPmeWekT3M7M4Tn0e3903UbC2IHG9FDPHDbAYyaaS/eEnb0NY7wboF
 rUWrwTfEbW6attH3B8z2tM9ypf/diCijHTt8Xsi1yVVRyMHPDmcfl1NczXYUKu+H18kS1Pi0/Mg
 ZGOwEM9lqSX/1hUqRH1RJtA798tS46ISg4FNzOuoNmWECukF19w19Rh1lD5oWeuNY/nUZXtqvhF
 TF5E7W6xgus0LsiPOJS8Xez/CKzxW1H3zqpXoGcMDBK/ykOy86i0uCK60wimtb2g69mQCk2yG2p
 P8rwY=
X-Received: by 2002:a05:6a21:7e82:b0:3c3:373f:e82b with SMTP id
 adf61e73a8af0-3c3373febd1mr7015158637.19.1784043815811; 
 Tue, 14 Jul 2026 08:43:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:7e82:b0:3c3:373f:e82b with SMTP id
 adf61e73a8af0-3c3373febd1mr7015121637.19.1784043815354; 
 Tue, 14 Jul 2026 08:43:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b8fc7c088sm31065756c88.2.2026.07.14.08.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 08:43:34 -0700 (PDT)
Message-ID: <24690de5-8178-41bf-94f6-cd383f599b2a@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 08:43:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 82/98] tests/tcg/s390x: user tests
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-83-pierrick.bouvier@oss.qualcomm.com>
 <584dbebe-6105-45a6-ae4d-d0fb4fc6eaaf@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <584dbebe-6105-45a6-ae4d-d0fb4fc6eaaf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fbaLbTo0ShFIRBgNDk6LNir3wLITjNFb
X-Proofpoint-ORIG-GUID: fbaLbTo0ShFIRBgNDk6LNir3wLITjNFb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2MyBTYWx0ZWRfXx1RWlu4rLBro
 kW29UaWUV05R8DrfRX40DgUmvM2te/jfXh0gGroTUYqnsxmeUyANybBeeZoRUsvWDczBQHLB7VL
 ntJavoYibZcgRnqImSMJZNCzb5OjKGyUfwZjmKYW+fxDiJ06LfE2oBm9Uiyp0mwTB7qYzBJwSqI
 gXUHw5djzGS4p1Ju7VxD6EZjNC6+kdH28v8hCW9AS35tF7n3p7bLrkaSmKlkGiJDjS7l3wIFiYq
 icH7eIZOgA/ueyvlltLmvSuE/jdEuCqYwQ6RAAVC0Ddy6FffJCb7dnEuMOOhxF0UgPOyezA0WN/
 OA5DvMjJ/LxsUf8QbMxba4gjctoDrTcQEd56pQ3y+zoEUE3iKiNdcKKFrxDqG41o9pSQ2WpEWJ/
 ynYUn8NQuZADC/fiF2VhdJdH3iJC3Pt90xSQ3uBx3TojiNNfUI9LCPnVUiKZKQlKz6rg6N2hpPo
 eqekJT7DP3/TbA/fXvA==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a565929 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=yLZYCrRHGCbx25FZ9MgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2MyBTYWx0ZWRfX3Z86AOPW3rmi
 RAZG/GI/dnkA/+LkhDafYS9GlrZ2j9OURroyb0AV7ao/Bw7i6Ba9WofKwhaBzmqeGDyLtmvKQvw
 MVmVrjJ2nvIhP51yLmBQZpES89oLtEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140163
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

On 7/14/2026 1:54 AM, Ilya Leoshkevich wrote:
> 
> 
> On 7/10/26 23:43, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   tests/tcg/meson.build           |   1 +
>>   tests/tcg/s390x/Makefile.target | 127 -----------------------------
>>   tests/tcg/s390x/meson.build     | 138 ++++++++++++++++++++++++++++++++
>>   3 files changed, 139 insertions(+), 127 deletions(-)
>>   delete mode 100644 tests/tcg/s390x/Makefile.target
>>   create mode 100644 tests/tcg/s390x/meson.build
> 
> In general the s390x tests work now, however, I get:
> 
> 155/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-fma
>                                         SKIP             0.09s   exit
> status 77
> 156/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vfminmax
>                                         SKIP             0.07s   exit
> status 77
> 157/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vs
>                                         SKIP             0.06s   exit
> status 77
> 158/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vcvt
>                                         SKIP             0.06s   exit
> status 77
> 159/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vlstr
>                                         SKIP             0.05s   exit
> status 77
> 160/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vstrs
>                                         SKIP             0.04s   exit
> status 77
> 
> with the series. Without the series these tests do run:
> 
>   TEST    fma on s390x
>   TEST    vfminmax on s390x
>   TEST    vxeh2_vcvt on s390x
>   TEST    vxeh2_vlstr on s390x
>   TEST    vxeh2_vstrs on s390x
>   TEST    vxeh2_vs on s390x
> 

Can you please run one of the test in verbose?
It will print the reason why it was skipped.
$ ./build/pyvenv/bin/meson test -C build \
s390x-linux-user-vxeh2_vcvt --verbose

I guess the cross compiler is not detected, and we need to find why.
With following questions, we should know what's missing.

- Do you have s390x-linux-gnu-gcc installed?

- Does this command work?
$ s390x-linux-gnu-gcc -static -o /dev/null tests/tcg/test_cc.c

- Do you have podman or docker installed?

- What is the output of this command?
$ ./tests/docker/docker.py probe

Regards,
Pierrick

