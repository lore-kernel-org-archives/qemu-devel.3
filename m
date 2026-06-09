Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF63CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWy97-00042W-Fh; Tue, 09 Jun 2026 11:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWy95-00042C-9p
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:13:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWy93-000417-Fe
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:13:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClZdZ2706239
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 15:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MHxXcpIrFuX3nUyCybBJcqQMX57QwRBjToHAnaRLuy4=; b=ERwU1BO9K6JHEFS2
 m7MdBrHmDa5nJHQWr1USXUV1XaiV7lZSV8a/bdB7oH0qHLJrewMx40s1YSgQYYvm
 +lL53eSGzWO9v2yCbsb2j4SF79nBqefXuv2ek9m0zCH8zAWTM1nJkHrYcZt4RRoE
 KV4psJZfizvLn1kE0GkJluiYaAsVD8SHLNiousR3scJ4NfH6yb6XgLYM6nUcLAjb
 Vokhb9P63qA5JJONRvqcc9CdAjjWtyGp8oBdtTBJyoTCArI0RmRql53nVtqay9TG
 e3BBsTN6FTt0hc79PvuvK4n4IQ740gaDEePUkSihBLNcYeUQbg7DFkE7EI8ZJmpi
 g7vjjg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt1w8k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:13:35 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-440fd88f521so6986630fac.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781018015; x=1781622815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MHxXcpIrFuX3nUyCybBJcqQMX57QwRBjToHAnaRLuy4=;
 b=N4zRg67S/6zcCfhPewzySFsc2OSFj2GALLSB8DaeMrL+rXWpSHgkV2R8Q5q9//k7NA
 VnhqaAd6711uFLYBoACVZeU3QJPUPfGzguVSmaym/7aFvPEQuwszqt1cRvOOi2M4xD/l
 hp1sLYmCIh+Fjr4hny4zJRSuSvSzQ0/+0CW5K/WAm3+iXU3WCdRUaofDIfTBI1cQn7D9
 9NIaVyaYkS6MOtq27QVe816no3wr/7YgvfaFaDDXC1B6MO5FK7d6RbN9wwwYulZj4zpi
 cDWNYMHkhDSArwtFK9N2tiAxEDVZfwpUeigdelV0HiQe4ZcCH79vfJPt0Y1tNt02mwX7
 bHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781018015; x=1781622815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHxXcpIrFuX3nUyCybBJcqQMX57QwRBjToHAnaRLuy4=;
 b=XInFh7C2whJnTs3DF3tJKQRz82aKiM7q/N41FmYtXXp0UMhyW2MZBXAxQhq+4XuERm
 Pfzee+VWM93DFOh6Br7yI6Mc9/2UKGeY0nJr70W95iv3tLzF+X7Ef6usThKxZ7WZRhrh
 xryl3wqGTLm5nzwIKX6T4AiXFgs8lfaCShj87kBqmQj3BKVZ1HF3fVFAsIAO8Zf5B4pO
 Izo1ifFXoPLJ4ECik7AMj/vWXy8eQw56Msn4ltcaGulDqYLTpDSX8FjxMPrqoqkPnP0n
 nQFv+VGMvoqu6ybs7wIKJP6WR6D4kXkMWeyPs5H7dQ5pzrQKb/0dl3zq3xHEoPibFUsi
 2AIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cMzvqVg6Vie+yMRqObGwIJ43f6QAGymvPGzUH7bm6+XPhM6OOD5C/WpI7cTpOb/VzZASUeE7ZVf8O@nongnu.org
X-Gm-Message-State: AOJu0Yzipqw7vzmS86P3G+QrvTXiJZWswRP0aD1ihEjYSs9qAmyXNVuB
 za/8U7g8NnEG+R5APy/gsWWj+q9nJtEiq8G8PEJEBMDYK9PwkHS2DjNuWv6hN1+s0JNLaOgVoBj
 vJu0hyQGdEED3mjxEIJmsCG44aMz9Cp1AkWrP7FgZCDA00/AoDr2Ev1n0FQ==
X-Gm-Gg: Acq92OEuopHSzJrvLeWx2hFpaqahFxytpjdC4m7YmFyWrg8I0/lsNCDFlhdJ6H1qo4j
 7bYRcpBDdjQiESPATgNzP/H399zeh/+NtrgQHJj+mkL9uKhVA0z1Aj0q5dK3TU6LOxlA47iWCvK
 3z4AuGhJSo5o0vjVujEOButHMIG+5XJuvkCE0SFl3yRKA+23a1J5+cNs32R5WmiOte3JWEN4dbU
 hL39AsRDnadzrmW9r4qzNBTz2mQUZOLa+2xks5rqkKF67ayRGAgVxxbVoh8ohWy5Lk8+KCsYkam
 otztQYhJpy5rpMoxqrMn/+KjpFMSxX4N0CrXNdCDTS2RkykO25Mc9exWVBUTsbntfjpDuaXO1sA
 7PzD9VsJol+S8n4OZ5HGIrACDBY0MB5rUyisiHZNz091NSSLcjmtScP79lnEXZsb/Q2c=
X-Received: by 2002:a05:6820:200f:b0:69e:3a55:a62a with SMTP id
 006d021491bc7-69e68b480fbmr12580207eaf.13.1781018014672; 
 Tue, 09 Jun 2026 08:13:34 -0700 (PDT)
X-Received: by 2002:a05:6820:200f:b0:69e:3a55:a62a with SMTP id
 006d021491bc7-69e68b480fbmr12580185eaf.13.1781018014302; 
 Tue, 09 Jun 2026 08:13:34 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055307aacsm1065251066b.47.2026.06.09.08.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 08:13:33 -0700 (PDT)
Message-ID: <49529ff5-e173-4df3-88e0-b07567ec238b@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 17:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] ui/hmp: move index_from_key() where it is used
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
 <20260609-ui-input-v1-2-42615deb818e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609-ui-input-v1-2-42615deb818e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZIcobDoHcubumLNoicLgut46rS-crXPF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NSBTYWx0ZWRfX5CRWV6lInSJX
 NWpxuXby6JGhetXoRCmzFXYcUPHRYI8wYsiDJgk2z2eyin+xcNYfH/YFmStu6/TgpF8mh0I7rjZ
 +29ME6tFZaODaPVv/eIJ8TUzYuHbNPQrYIEGkooHwSKavCR/PNSMXUS9E10ggg2JhIK9FLiNDcn
 oams4SoIjRkfvbBlbIu1tTp255KAI46EoBzzRZAaU/9L+L6Cxk56IoplkLECmXZ+CpMlaCN58RX
 kvkPpNcj8wpnVrhRHPMVZlCg/L4QXkAHq2n31YjbdF1STc23W5I1gHO7GFgG0QqAirsQbgUw58Z
 GPpdZYqDg/Y378iBzeK13d7qpGEpwyTq4oBR4/7zVWPNBe8dqhK0DVBTbQlQb9k8NyzdsmJraXd
 AkcdP4TDQ1poKFpCJcfAWTcFv/mUJ2yXpUeh+VDV2in7xsR209tQBniG5LWmMKVfdy01OVupO4F
 T91PCYbxXlFYih+DscA==
X-Proofpoint-GUID: ZIcobDoHcubumLNoicLgut46rS-crXPF
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a282d9f cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090145
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

On 9/6/26 16:34, Marc-AndrÃ© Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h |  3 ---
>   ui/input-legacy.c    | 15 ---------------
>   ui/ui-hmp-cmds.c     | 15 +++++++++++++++
>   3 files changed, 15 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

