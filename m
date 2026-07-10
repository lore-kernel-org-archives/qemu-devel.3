Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0939C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4Ba-0003gJ-37; Fri, 10 Jul 2026 01:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4BX-0003g6-S1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:54:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4BV-0002Kl-Li
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:54:03 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3pleO3856872
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /PmDdElUMf30bcCcQKtDlLJlL+mM6U6nxBGdyVwgCXI=; b=ev1if8I5WEWZ/PrG
 XI440J3yFhPEK8zSDEDUQx9rBWZRiQCpspJuCVQmdBWirNfQDfeu7qVLpYhxxkJo
 RNuoayRNi6k7N2phvLnCteQE8rspEsQiErUcJnZSVsSPXxtyMpH7M24G0TBR+kIt
 kQMYa4sDKtGrY32uCMouOpd2SZbe67Wl6lyBJBA0MMzF6im98E1MkLoXfXLPt26A
 4mBH3hRyiK7Cw/H6ammzkl3Za2/eOB1LV31an5blVHg0Dafx4gEK1/73UJ9Sw88n
 Te4S+bW1fHby+bg4j/Indlfz1JJY42KBWjitgs0C37MFQUcWTIO6Y3DJhXhL+5I1
 zM0vig==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0dmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:53:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381250979d5so770377a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783662819; x=1784267619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/PmDdElUMf30bcCcQKtDlLJlL+mM6U6nxBGdyVwgCXI=;
 b=kEpp9ZGpuYnlw/GYO3lXKVoX1LVNR34LfZl/I38DerdOs0+LyWxh6vw9C1c/GqjHIL
 kA54RFywI1A3q6TsD3a1au/Cjwnr1+tYX4TABvTxloECYolGv+rLniK2/ZiLiytpZlIB
 hw3q3Iy2HK8lbCVLOJ/BGxYjNfpJJFmIN0M0Gq4WzM7eGQbkfk16rNyFPErnYsK3D8mi
 ahl9NUnzURAR3kOzyLD1dL2EUbZi/IOivEqx+bZ6W/3WERO/VlhXlSIWxoAU6xE78qzv
 sBUCd6F8MSI9HHfuxs43wpHydWNVqhj46IoOG3n+gLoLkm7iTg48k4KltAh4pzr3yi0X
 Jrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662819; x=1784267619;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/PmDdElUMf30bcCcQKtDlLJlL+mM6U6nxBGdyVwgCXI=;
 b=nCL3KT221Qg7I+rFYIb0r4T3ZXOAUfNy2KOxWNyu7KWpErliJHGOnh9VTPFQMxIiGE
 6YZ7RSYfxrK/6M35MQi+3uOePRrVpjIJGCzZt8IgTLlM/UrTqiyxcO49Sa4PPm2i3pr5
 aWHe0k2AyeznhwF6Rq5ldFcWG29c9x/wuNriNzfYQ9ovvpIbLF4CQsu98rsmaKDejft3
 6Z5SMVFO+GLhbozLK7Wx6Zul1gYN1Cwrq5Tnl+C4NtlLMMaMBZADDtwumVPwON9XHb26
 Jt8KrQEd5GElYQCBkaSH1LLAYQYxUN1aeWgwEuvNGiz5WYwr5JZNhKBz9lR13xvWSd1O
 OtEQ==
X-Gm-Message-State: AOJu0Ywns8MrKKie3o8nhkrIRjM5A+Nty38udGj9MuzKZq9BoVR6OakE
 +tb7XPt4W5iO9mQH/8xdnSOMdo1lVlhAyqCc2VAiLaggB52Ehmlt79CPUYebteMtO0rYzNDKfU6
 TAzJSnlKebFxYjbwwBso/snfUqss5yP2lEPt0/mSok6cCcCCrJnhOtq2S0A==
X-Gm-Gg: AfdE7cmITG1gfvTsRT9lSL8DqxFl+8MmZ4uDSCsVm3Ny85s3ZbdpvxqHzX7YA4lwPK0
 L8aW+mZpsHMgwNDN9fTMVQsErLl48kfJ25+emKsG9MhjWNLvtyLs8cJyB5VaUMaJGnJJxJmir9x
 QdqPla110L6XqNEP84pu9T7uEtYsZXo7c8e8VMBOeORxbRqfLqK4saLiuFktop+KH1s1E8kr7Cu
 o7LMUq7ZsMa3yCrKGAwDezcbQT4SJu2BaoX7JuRmSsr2wMKHHD/5fM88KdgPGyPIT2ZomuyRUFL
 F1j0c2Ysbugw6gej05S3m0sgfOONoGkzg39/EjaNnbEDeAKCV484HgurFO5oqN2qyAr81zQF2U6
 GrkRJ/9oIk5GgmEH8xuD49321p5mxn9tt2jOxVhLfhElrZiTCLOmR11Jg62sKf8/UG+nY2KAoU8
 BNIGk=
X-Received: by 2002:a17:90b:1dc2:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-389418d96c1mr10252390a91.20.1783662819212; 
 Thu, 09 Jul 2026 22:53:39 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc2:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-389418d96c1mr10252357a91.20.1783662818694; 
 Thu, 09 Jul 2026 22:53:38 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accae5sm58315720eec.29.2026.07.09.22.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 22:53:38 -0700 (PDT)
Message-ID: <50afc3a4-a254-49d6-93d2-42f3c37064da@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 22:53:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
 <CAMo8BfJg09ca6Kxw0WLLj0SQLBcOCwYmSN=e3u063oY-fgrdfw@mail.gmail.com>
 <99d7064e-50f3-4947-884a-6f6c14f2cee2@oss.qualcomm.com>
 <84fddbf3-e523-4a23-b95e-cc6102e459c3@oss.qualcomm.com>
 <CAMo8BfKGqu=GbDhp525Oqt4VVCC7cPSYZ5obsUuuFQYKvreeKQ@mail.gmail.com>
 <422b0dd7-b3a2-45fc-a76f-43c18f95c426@oss.qualcomm.com>
 <968352f9-089f-4409-800a-3efef59d114d@oss.qualcomm.com>
 <CAMo8BfLPahC0T-8U=y=Jacx5zNvO=4jFXiCFfWvYUKtyNVk=Qg@mail.gmail.com>
 <3f2dd388-ea87-462a-9438-10ddef3f1c82@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3f2dd388-ea87-462a-9438-10ddef3f1c82@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfX/0t1Uql2OOr1
 d7ZBkLBQ3Tq4BgtlAxDFHVeTIgtxFKbxOKYRUSZwDGIL9Z6bpv+P9ZtyoXHTXZ4Dajs6Dvn4BEe
 Ua80detr0XfJ1BNGDfP38Y0rD0CQCsI=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a5088e4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=V9bkZ-3obDFA_QSSM14A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: mEqvmwDFVoHTCvi-jqGl22uUGyyJLY25
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfXySmInQaPtEkc
 zC8p5nhcPq7/owDuOliA47W7lF4KW0qx/40t8xtqqeErxnu2Hg0PkyEggRFr8tdO4TMilaFWUGu
 X+Y0IBMg0ThRFW7FvS4sH7xlO9DVdf5AzM1upJxrBAdyOiL+K+alWRt1jUiTHfBSE4EHBCPrcrI
 uWmu0kvvvdb77v6faLSgNtxIW8KYT11kYc5W3sQ8e7YWLPtVQICmRF8+PdjHRBVbjVvA8X9nEC0
 rc3oxk9vgV2DaLfBnYUjhF52B4RVnN5hO+pF3ZneNgqO/V3FquwMUtSJSVq+jZ1LNzKZnt/Auiv
 LU/aR1RIvmKFjAs+NGJse0Zj6kBtBu+QOVr4ch9+qMXQ4bYO5S87Cxi9PGBEunreeBtx9hxc0BN
 xLgNi2U0qn+S0PQowS2gGGnsbCAo0+C91Z/0Ns4MnR9LcZPFVU1L/c7CTAZsCNmPiGC2jIrbRRn
 50PYCPhuedWA1qTJPew==
X-Proofpoint-GUID: mEqvmwDFVoHTCvi-jqGl22uUGyyJLY25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100054
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

On 7/9/2026 12:03 PM, Pierrick Bouvier wrote:
> On 7/9/2026 11:42 AM, Max Filippov wrote:
>> On Thu, Jul 9, 2026 at 8:24 AM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>> If you have a chance to take a look, I observed that test_timer.S is
>>> flaky on xtensaeb with kc705_be. It fails with a probably of 25% on my
>>> machine.
>>
>> This is a rather well-known issue that for a core with .clock_freq_khz
>> that is not
>> exactly matching the icount argument used to run the timer test it
>> will sometimes
>> fail. The easiest way to fix it is probably changing the default core
>> clock frequency.
>> The more useful way to fix it would be to make the core clock of the
>> `sim` machine
>> adjustable and set it to the value that matches the icount.
>>
> 
> Could you share the magic command arguments that achieve this?
> I can edit test qemu args to match this.
>

Using -icount 8 (instead of 6) solves the flakiness.
Also, icount is not needed for all other tests, so I restricted it to
test_timer only.

Regards,
Pierrick


