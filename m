Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67359C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCA6-0007PZ-9m; Tue, 07 Jul 2026 16:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whCA4-0007PO-0F
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:12:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whCA2-00064N-DR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:12:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5MFM341632
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 20:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /q5w3m9Un9rKCETBOXhMDul9e9psvn4Vrpktu8gsOaw=; b=IGamNVQqcraqWuet
 e5F90fF/Jr6ymn4pCVhjMFCDgqLFr9lsAGigmadzXnAx2RLE/m7NyOf+LkaMJ2ve
 uLbwpTPZsU50nwPiE0sfqVftvLquoZ+TcgT2BiWSBWjFB0+Zmhdd18q60crU0J1H
 BaL2056rnkNj2mWJSeye1m16hE3zx81n1hvGYy/ZInuOfZ7xV8yRW8oKKhcoLl33
 CN92Kky8VPql8ossmbUZgHcQpHo/1bld7aedSNkoXOm8rWEnA1/zRisbRavVnAYt
 TsN2H+6YJ/8bJpzPVBPLLw2D2uFCsRVAdR6ujgFjshNDnIa9r+4JyLBCruYmmGi4
 RUFgYg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2ub9rk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 20:12:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso13491921cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783455172; x=1784059972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/q5w3m9Un9rKCETBOXhMDul9e9psvn4Vrpktu8gsOaw=;
 b=AwxIHZrjXKrADBqQAkEA7PMkhtAoFPr4aIMJpbNRByL2THrMeME7GXOWxlR/ZoRzu+
 kwSGTvz7QePieXbY3KEejYMsYrNsr48lwG5XmTgoXohdV0eMF0LlxGiHLD8l1FzaUss/
 7qya59wlWPMepq2Gjy8j2y8bM/7bXRvQ/WqdXVGYhUrtruqzijdFAgxEwDJemOG1GQJC
 tXX/SDd/bUf00UhCx6jjZfRxxJd2VkuFTr+uBF0Sas0qME2z9FzHzTmKg76KTl/BEgQs
 TSihVC2iLv4Jt3FjgZb+/uYRBgsAzZT6n/FFieJHrL2AKF8NDxZqqCl37bCrW5kSGrqh
 upPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783455172; x=1784059972;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/q5w3m9Un9rKCETBOXhMDul9e9psvn4Vrpktu8gsOaw=;
 b=f1IXlIdpOXYy7O4gKXzWrUD8WWorw+8wA4O7IuV+HVzoluVycJU2MrQeDYpVGwlDDr
 G3Gl0oIOxsBE+EL2wCXyIVr6uYRyGudiVtokIzUie/1nyBUYnMCWi+9cqDrunZZXfJ1m
 6JGz9LcYQSqV2Jlpf2qiWnMolcUVJHZT1gYu7p6AGkWrS9bDhxrMr7sspzKMcZqj57tN
 Ep+Bjs1FwGruWDq29UJ7UMI24+CC71TzSpfGuxOAIQV9N990Xiwxijea3mmsmHJ29o+l
 0tNy/JOJa86Cfp+cYg+u7L/52w7KU9dQuoQY694E4JfROsXYqfyUZvze+4pNXUi1O08V
 KzVg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqozxt4nItK3MJq+l4D1lqfJIUg22HknsQWBVp9lcgJhnuwYwsTd3Y+63f6NkqHTtTLH+WvbV8C36gm@nongnu.org
X-Gm-Message-State: AOJu0YyxIyO60i4izPChc9Cy8j5xLJh5/tj+u7Cu+Q7tCbuoCiortetX
 7m8B6WBkXTmoxOzmh05xXKBMZDoRm/EGyX//cSVz56wQvyy+S3ZshE5ZO0pp7zlGX5PpEX3weZs
 LOgHlvQ5bx7GJuo25biLPr4xoahzw5wRV5CaPRII1Bv0Ytky5jxnq1rv3kckPMD0+cA==
X-Gm-Gg: AfdE7ckWJ42YAQbsXzjD3b5Z98Oj3oKOye+6C8wrL/Wk8Wl1ihbT1Wx9QUe+9BwTw09
 G6iNY3QFLoSxpyhr89VYL7V8vg6EAqHib6b/iVjWedmIpoIE0rbfAYrXkvSJg+DnIn6CdkPTZMF
 UWsiKiAA9cL83qdTWEeefoe7r6JtW8q0ru+vp90DNxMKrYaiN7aK7SNrsJxdNj4etqFtmsbes0L
 XYj0g0irXdqcaXAhN+fX9RLNBjUFtZCFuhpPvPK8L5h/5P8l8nXatbOiK6su5iwH1u1O1ii+luL
 dQoDDtf9PFMTHq0RTAQzsU29aCHD99iVXEU6CofJ3X4V+1+596JZMgoxhOxniqkylvFHwXvW1YK
 oJ17ws2QNeC0RftQlK5+T2UJmg+prYp3CT+vrX0RVU6FRqPe1VSc4otZLYRH9ng==
X-Received: by 2002:ac8:598e:0:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-51c7a7516ffmr43586271cf.19.1783455171918; 
 Tue, 07 Jul 2026 13:12:51 -0700 (PDT)
X-Received: by 2002:ac8:598e:0:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-51c7a7516ffmr43586081cf.19.1783455171502; 
 Tue, 07 Jul 2026 13:12:51 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm36769999f8f.15.2026.07.07.13.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 13:12:50 -0700 (PDT)
Message-ID: <1ecb1dd7-5d47-4304-a0f0-bfec305fb859@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 22:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] target/tricore: MPU, peripherals, tc39x SoC
Content-Language: en-US
To: Parthiban <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 christoph.seitz@infineon.com, David Brenken <david.brenken@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
 <9f3952f1-1794-414d-bf7b-db7a5094ed22@linumiz.com>
 <cfdde0d6-77fa-4216-92ac-bdf9b9b26087@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <cfdde0d6-77fa-4216-92ac-bdf9b9b26087@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE5NyBTYWx0ZWRfX7g6/XJA9PPdl
 qSncyyaHHruECllOeQLxqpyfI370FgELSzshy6yCYFo6c+XmUNsCEDmsQUcIdM/cccQ+rRRlGB9
 o4H/gKWb5fc3GgsAsJVcPlteSPGjRhU=
X-Proofpoint-GUID: -nLYkqlrHIUJDBDot_QQBynCrpyMOWRG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE5NyBTYWx0ZWRfX1++xIc4E7rG/
 1v9f2NaJtAREz8YmGfFAgbaFxfLNfq4REkzbWDbggPlAtFh098meC1BbgTOuZAd2gQs8d6bSL34
 9ohm6wwBT5u1+fIP9rvl+MGSqYpWIiBJZQHPc+fVOKvSygbIfWezXmqDnBUiATLvQV8uHFLe3r0
 s1cgOfvdhgOuGRXbZ6TwHWEc9jlEDe86Xkg48jAJdvkg5lbAyBAbOapnj2ZTYNrXd/l5c9icWlB
 8+E66tZc807gY3j3zKa+Qm5wu/lTbqcE7xOj6cSpQMtfoOgIhKLVVBe6ZTIWLXYZZvZcFJk3Psn
 6IMA3x80Ad82eXBAotMxzu9xR7i4CBqfvtMBgFSbUQ0Au2L6LIKF7IQfsgTnTDh6EMN/OsJmsdO
 pHuBNSFnBfl+xoySwE13adMZvsl5itizWeF8wdHHNGYqXupyNmLaLJSVthKdrCWlk3OhM2A5JR7
 yupGeikV+ciTqXsEQ7Q==
X-Proofpoint-ORIG-GUID: -nLYkqlrHIUJDBDot_QQBynCrpyMOWRG
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d5dc4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=vU9dKmh3AAAA:8 a=bkFhEHBFzupQzs3BJtIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070197
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

Hi Parthiban,

On 7/7/26 20:16, Parthiban wrote:
> On 6/15/26 3:13 PM, Parthiban wrote:
>> On 5/31/26 11:30 AM, Parthiban Nallathambi wrote:
>>> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
>>> ---
>>> Parthiban Nallathambi (10):
>>>        target/tricore: replace legacy DPM/CPM CSFRs with CPXE/DPRE/DPWE
>>>        target/tricore: implement memory protection in get_physical_address
>>>        target/tricore: add tc39x CPU model
>>>        hw/intc: add TriCore interrupt router
>>>        hw/char: add TriCore ASCLIN UART controller
>>>        hw/timer: add TriCore System Timer Module (STM)
>>>        hw/tricore: add System Control Unit (SCU) device
>>>        hw/tricore: wire peripherals into tc27x SoC
>>>        MAINTAINERS: take over TriCore and add peripheral file paths
>>>        hw/tricore: add tc39xb SoC and KIT_AURIX_TC397_TRB machine
>>
>> Good evening, Ping for review. I know TriCore lags active maintainers.
>> Looking forward to know how to handle it. I have few follow-up patch series
>> which handles additional models and also newer cores.
> 
> Ping and looking forward for initial reviews for TriCore.

I have this series tagged for review, but I couldn't dedicate enough
time / focus / energy to start reviewing it... :S Unfortunately it
missed the next release, but it will likely be in the following one!

Regards,

Phil.


