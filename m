Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AA7C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluBa-0007VX-PV; Mon, 20 Jul 2026 16:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluB3-0007LU-95
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:01:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluB0-0004xE-JI
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:01:24 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTZCS3622214
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OcWBraa83/TEpyZHTrraLdKwU9TkVft2O4J3UAFI0Eo=; b=NqBlLm7umo8vGDZs
 ILEklys3S6et13rKTd2ZXgKkA7YEr260oIrsx9QzpQ9c69VTdcgEx1zFdJATkOAL
 OGza64ePBj+J7kSVk6k6vkXgRQOQeHvyPn61xZfd65EzERkP8zBcM2gF2sWfjDNq
 Q55oZidvw8m6lsytN44I3zQT00c5405b1RkPO77mlxBq+VbOQsQ4d4nSdHrEIPQe
 DT4HMTXNIkY+q8Ra4fPKybRDy3Xn4yT760NPU99RPFfZiyWOsnlF7+YJQp5Z2qxR
 HdZAA78qqdryA5Kq5uUb6K2r4vJ4WOopgGyi++kO3BYoZvnFLLn13Y4GwPHDnk9K
 wzyhFA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxk5rv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:01:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e7131849bso1736315a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784577680; x=1785182480; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OcWBraa83/TEpyZHTrraLdKwU9TkVft2O4J3UAFI0Eo=;
 b=gXSG8r974rSN3q/chCbVCdj1Z2uMAiBUcIbkcGJFeSHJ5V+kI1Ja01S6RNIH+/A52w
 kLQANRM/tBUO9qbr8auwwBC3FXGJ5B0xqQ79r64kMCnXCi+YXyInzV1/6AUImmnuShHl
 w63l7+Tz0xnQQHJcofL4kPFUlwpUI3L+fV+DFkt6i8LLjtlfaxJOabGBR397SDl3ZfdV
 xpkvUuvZ2kK18a3JVvAeh2I/GEwUkiPnc4bxmjUEUS7i0SAQyGlAFdIfDG4dIIXAgPOK
 TapP/1KucNPAcbeAHFN//QdQ6KnhEnw3wzknYo7vJvLrxq63yNnRn2jJUEVkrvueutV2
 w38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784577680; x=1785182480;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OcWBraa83/TEpyZHTrraLdKwU9TkVft2O4J3UAFI0Eo=;
 b=lvPF+fv819e/k3lYXBsOa4ymVhwzfj1cwGEquUjYvtYCcA617w+ddRaKKavlxqxS/C
 OyiTCGN5u6PlMNyShsKplgRcdxd/QKk448Z7NmUjNSXMBKvra1rjuZdfB1J44ceMpqHH
 3Wy8j1/oEw7A/+1pQlBKaC2EXJ7OXPEeJgUVF+o3/5hebr/OgyaCBTdJO9ZYqWCATzT3
 SZTgO3gSOOQeCExkINr7+ql3xzg2aldwLUUN/su2Anj7Km5H83TqdoV7x2hdGl0HEn1Y
 BkMyAX4P76Sd6DuJMSWYIy39dROOCPiFM2duFLtGmVnhYnw4ChmB9CXrRDnl3jxbkWPd
 mTVw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqu6rsr+2HpVKKBo6kADivCS4UC//UA0jbrs9uXH7b10Q4uz+nsqW2oTEO/w4+ihc3+3aJLGLsMUEKd@nongnu.org
X-Gm-Message-State: AOJu0Ywe7OzmPN8NJJO4koW1zQNvJcXwOX4kRFanZ7uoeZb1do/HVvAT
 lV0i3QuhDzdd6CNGGy2kwxJr4tIFTMKUXgkWHRQXJ7qvIpjXJOviIV38Lwx6RXt1CjedkOJ6x5P
 KE0lwFV3SW3ArJlkB/rw+DWY41KHnsfdLtIs5P5+CXo6jb1M3OwSU5Z273g==
X-Gm-Gg: AR+sD12FW6KEyIGAbBal5FsrA+Gu+NNNeWybR+IcP0B+3wSC6U3SmSjVoNBGMRyaslf
 g1Y4GvaTIN15DmobT/kavha6cPAbMo/IW5m7sOFZ1PO9xmZLHiy9qbtoU14Bv2yMvM3CYi757jH
 3nPrGnkhOWZCSCAZdYx9x8g5146lEo2fRiQ+yQ8+l82sHQlq5OHoOhX1tEEtuD9rCntywuEbuIg
 DxyrnPmIKGxizaUROnbWr4lLu5OB8i5Sq5sMGfGzzOFEgUx0fna7TcM61057o7MzD/ZMUZqcH4b
 IN4btjgy9nKfFT44lMwk93SDUhHJ7S1kyc81NdE2CZiwnVN7Sa9fbQH8k1azJfefFBzOu/3rae5
 PL9uKMyCpfQBCro9w8LcGPUKaiGw/Vajn/Jf5SBqjXyBUQa7OYRf1VqrMIcrBGVkyyen7
X-Received: by 2002:a17:90b:5251:b0:38e:76f8:fcbf with SMTP id
 98e67ed59e1d1-38e76f91ca1mr6548557a91.31.1784577679610; 
 Mon, 20 Jul 2026 13:01:19 -0700 (PDT)
X-Received: by 2002:a17:90b:5251:b0:38e:76f8:fcbf with SMTP id
 98e67ed59e1d1-38e76f91ca1mr6548529a91.31.1784577679158; 
 Mon, 20 Jul 2026 13:01:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29c2c93sm36124681c88.3.2026.07.20.13.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:01:18 -0700 (PDT)
Message-ID: <e91b671f-006d-4354-b9c1-563209a87530@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 13:01:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] docs/about/emulation: sharpen the dlcall boundary and
 its guest requirements
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
 <20260719074730.1520517-4-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260719074730.1520517-4-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5e7e90 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=7-mR_K-J60hpG5QstZcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfX+2hM3N9WA0Ii
 PflZtl8bnCXBG6nTwbXKunDDVV/GO4RQCjkvTjmF0vrjxBjlRDv75RxvmucGPu8LFXwEDZMZ6dX
 NwYaLVjWMaGf500AptQuravjmbUesbc=
X-Proofpoint-GUID: phOHc0LBvaktkuAno1ss1gn3sKbWN05w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfXwSxRdDiR7lTi
 KZa6OeI4aLh4cj8TEMJ1WpFqOHIqxaTUCwk7eM43nExAqj5r40O8kwztUKdcKuYFIlpIxR2jzBs
 lqJ2sy8TgVA8CufyKpXHdMtwoBAvQlpFrf4wTg27tvV/kCuYFR6K6c5/oBakk2vvxjYS7Ho1r6J
 w3e/A+0043Zld41gg0yC8ERZTPMwopRI4RoPdcCUwg+bK6r69Qmsi6EbD6FwVjoD1arrjgsOqR2
 PzlAIEfIZF6SatW8uiHkhpT01MTYLlIkandp7Eik0SZnjBAMgEXCldrCePT8+maCGAiRtAeaIP2
 LMYsr2MozxfD35FK3OlWg21pinh2DlTPanCIYUsRjk4SOmnt0JGtFIXme9LHBK799K4/mVk/4ec
 omEaspo51C/3toi6Q5FxIlKAnJdwlBos63CIgWiFpT5OOI+0qnHjB4XtKBRsjYWkvyxkh7HOPE9
 UlJnvYve1y9lJ3O3zzA==
X-Proofpoint-ORIG-GUID: phOHc0LBvaktkuAno1ss1gn3sKbWN05w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200219
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

On 7/19/2026 12:47 AM, Ziyang Zhang wrote:
> Record the same data model requirement as the plugin: guest_base == 0 is
> necessary but not sufficient.
> 
> Describe the magic syscall number the way the plugin now does. It has to be a
> number the guest ABI does not use and does not reject before the plugin sees
> it, rather than merely a high one, so show syscall_num= being used as well.
> 
> A library is not turned into thunks, it is left alone and the thunks are
> produced for it, so say that instead. Argument marshalling, callbacks and
> variadic functions are also what the plugin does not do, and listing them in
> its description blurs the boundary it draws. Move them to Lorelei, where they
> are pointed at as a reference.
> 
> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  docs/about/emulation.rst | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

