Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E450606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QIe7umly;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HIGBjvFX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJE66-00052j-2I; Tue, 20 Oct 2026 13:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJE64-00052Y-Ed
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:58:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJE62-00043N-L8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:57:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGu3LA1925923
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IglO5Ppq2wr7wP7A9vDhEK/a+eUHtRNlerCAi0o6QXk=; b=QIe7umlyy4iN2g7p
 PZbWRbwd4+brWUTGQcejC8Urps9okMFIrd4ZTTv5Kj+7Vn9gq8gsILn+15Beom6Y
 P1RC62k1wSF+/8YnpT6Sefb9yiW2Vl4jTjoCtbWoS3pjQ9lYS6tYtSQj3ew7ICyI
 UH58KdWjyQzQgKRbb+XDTwJIIk4EHok2FOCHZMoYpJgGSVYfdkHseRafzOeLJNAy
 hgbX+6yt6lvSrH7qLlbtlB1yQZEgtEmgRGHuAR5iJbdjp3JMrqA6XO7wBe+1L4lV
 jItyetCF1UzmtDgE8eSlgqsLB74u96KxsJUBCKfONP24MtZ6g/7eeFtUAdWS8yUf
 nNSdCw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qbt3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:57:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ae8e7e546so743567685a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792519076; x=1793123876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IglO5Ppq2wr7wP7A9vDhEK/a+eUHtRNlerCAi0o6QXk=;
 b=HIGBjvFXh94Y7VFdctfw87XE4xJJCj5+kn9w8CEaMgVz6EFE4hg/niNA5MRHcVjCY9
 BZIAuybGXIcjnxzRRFQJPw/avChlvtzijVDQo3GDxb94nfv+5+KaPGn8YyIjokOECcM8
 E++p44vqeUm1Cg3lheciQ6MmRJ175WKCv5F0pIz6imv7u+9015RU8GcNyIolHTL+gl6A
 gKi0FOqHioErDv4J8PB3E4SU3oba0RDCKmsfEccl/muJzu/Rx4p23UfbO+R5OOY/0FF+
 goWYDPVN3BFgk/XzLjIW/wJKsBJ5B9hLg8rnWEHWcnbF0bqHaVHc+GweKpcVjelzJ4Gy
 xCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519076; x=1793123876;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IglO5Ppq2wr7wP7A9vDhEK/a+eUHtRNlerCAi0o6QXk=;
 b=2R9xgeoX8LamOpCQEvPbd58802uyZ/h5B15I8121K8o0tGd5Uex2h8hZUTx8l4kcuG
 XoU/AaF6vR0WpeKV2Gw3YCMAmbJ6CXLhs60jt2UzzTyiM9uBA3apL862AqjBEQqiMZD1
 9e4wCh8EcRQ+DxTGqS4bpR3YdBuccGZnHzWa7HqZLfY+yuGnUHueA/7/dbOliBXxPu10
 yo9iZpijELPe3yPCEPdl7gMDMYh4YW5PYlehyTUXISyoZ9IsZIArYUcwJmnKwkEeKSJq
 tqeGAsyse4eF8okKtRYMx1iEFupCVhzrPMoxaCjeWbq+kav9AG7lEzpIRqrUjX6lm1Ys
 scfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/amg+W+gEcTFqeqK4q+ZOAUXQgeb5BverfozaoSaXv7xw2kwj75tiwVXnoP8Sx117NqSB3zPOxkuO@nongnu.org
X-Gm-Message-State: AFq9FYJanro1/FWLsMaRqzp+FEfJ1kYwBs5dScRb986lODUU14RuMwb9
 O/NMOyhWIuplIrVZRIDK3vL9iufoEkaO2w9aD4TudDrGR1MmGVdpomKeFms1ptL1iKp+R5s4ijL
 wfOViwpsJ4pbHD7QJCxewWlSglpScqzask3ARVMhlKqGB0jjJhBVRssDFvHCK9Izo2hun
X-Gm-Gg: AYBFou3U0NTJQfG6GUr/050ECGj6LUKT5fSrYZuey8DmEfNh8pPpvywwAcpI9XPCg0N
 EUtg6Oq1/53VMHTdtXXhAI4OubarhA1NiW6SGEwODOUIEsESP2wd3N/4liPj2+TDDFOKdHVjDdt
 76TQhnMnkQZEwWpQRnGiDNA10OafWx+YyX6BSbMGpiYt38famHUF/XaKgNVkZ7Ho2F8sPkLdtZH
 PNF6vJq/tXb1doIsgRpVPiE2Ovf4A5b00mits4DrioNmGw98wHwb06a4O7bXapVtDWlzaVHL1VV
 bCCoQZAFmjc7Qud4N2JlVVV8szaBWVHUJOYfq+YngXnc41/ANxfL9OxzxU4Q+3K2Vb5zwZGUAU5
 Pf5d/cj/9aD1A+KK37lA=
X-Received: by 2002:a05:620a:284e:b0:93e:c12c:9dcc with SMTP id
 af79cd13be357-93f29dd9a8fmr1917202785a.76.1792519076513; 
 Tue, 20 Oct 2026 10:57:56 -0700 (PDT)
X-Received: by 2002:a05:620a:284e:b0:93e:c12c:9dcc with SMTP id
 af79cd13be357-93f29dd9a8fmr1917198585a.76.1792519076087; 
 Tue, 20 Oct 2026 10:57:56 -0700 (PDT)
Received: from [192.168.69.210] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d82dfd5sm7214562f8f.47.2026.10.20.10.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 10:57:55 -0700 (PDT)
Message-ID: <9562f040-9305-4041-96e5-fb89c0bd72dd@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 19:57:51 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/avr: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020122752.3651914-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GFyozpiqdxqT5JJoy-zENvE53aZxCwco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3MSBTYWx0ZWRfX9ZJXRW7fMOho
 B2h9+wmCcCx8IRCfdBq1I10FauDubC8LpF6q5i3I06PfUsOSpYC29bLcFHCvkG3kuDfYd1pJH7Y
 xP0UNj8h5/a86B8cQk8s9gPq6+LsrKh0yfw49VNNPtRS2iNPiMC5bb4JO4bXLtO/E6YAfAr5idw
 uBqlgkkfPPKfG3lAKfPz+TOOYIjgdlDCmJhc5dBFR2x80T7mdvYsRiPHFzu7XEFA+QpuhB71ckl
 gX3EMh4a1XOUuw6Sj2v5DiTfWxNznQ3gy0VphcAA5z1fC46mk292ihX+rzaFzBXE6SqmFmJF/tn
 UvJIzysYuGyQQYVw5EjUmNkcfm5+kVBqS9qhmFjXhRX2ryQ0FTyIPa7I/XXtEmkh3LArdOxuQWD
 4u7Mf3ggDqLWNrl7DM0SRaurThg0wyXcVsS1AQpu+WYBj0nP8QS0KwDsbAuVN1aPsyGfB+jk+Ea
 CE0xXVT4mKXtGSB+GVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3MSBTYWx0ZWRfX41tj+fA9//3E
 +xiYv6xpbPe11RrtmEJ3ArH4jgOrAZy/YdXOxwfa0KojVzgFmRK2dU8VZx5ZVUtwswuVhIZitrg
 MCWLl7yAF7+WKdD/8xNnksuDRxc+lVs=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad7aba5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2kYTDro-z8tN1mFBP-0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GFyozpiqdxqT5JJoy-zENvE53aZxCwco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200071
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

On 20/10/26 14:27, Peter Maydell wrote:
> Convert avr to providing the translate_for_debug method rather than
> the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/avr/cpu.h    |  3 ++-
>   target/avr/cpu.c    |  2 +-
>   target/avr/helper.c | 11 +++++++++--
>   3 files changed, 12 insertions(+), 4 deletions(-)

No MMU,

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

