Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13141CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 04:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEJUH-0005Pz-7Q; Wed, 07 Oct 2026 00:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEG3H-0008T6-Sk
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:03:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEG32-0001sV-1j
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:02:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966eDq52834136
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 09:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9Qzr4xM8E/Ol0WnTSww3Y31WWioP3XMsHKf6j+JTpC4=; b=ohPAKj1bPFn6akLO
 zlhLv+OxDhirruBHwtGLD+khWbUPyrmUAI8E2K1gbG7brvm3KXlbGID1sgBRD1YW
 zI+yVSh8hsN2y9FfXePIS0QbABqQXh3/I8nmVaXriDBQ49Y/sEBFhNuVvg2DrHFp
 900dLoT1JbV8K6W+sIRAE7Vw566Ox9BMq4uBMR9hjq9fUUbZFJHG+u4+89hRDBzQ
 ZqYsgeII488z88UpBtC1/KzDo1F3aDo4ew5K7SpWQJyQs4Rf8NqlW5zYrUWiLGgl
 cwK8f1TH+EGP0fNALPL0C3ddI4BBDq+jdwDgRsOhgUXN4dwAsaDTQgByAE/fO1LJ
 gXsXBw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4dncktxe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:25:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ca9b53afaso691456485a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791278730; x=1791883530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Qzr4xM8E/Ol0WnTSww3Y31WWioP3XMsHKf6j+JTpC4=;
 b=T+KSUmc+edvE0DlLD5yiRtTDBQ0+n53SdURoDGHq4t5tdjEn/bAwJeUbdmF0WdelUJ
 MlFSMCo/NDVKbwQldHawI33Hf0kBqli7B3yfYbBVl93RtnHyBnFDoC5Jy4TGDNSA8nHU
 n8nSyxWXZgyGmw6Sqsvjj41vWz9BS9/oZXqh5UQob+LUmz1SqTlLo37UkunwRcqahBwf
 lcbDHNxfSBFy6QAWvN/AGnxs6SLeUBK3CKpzXXyrXC1bbHQgOmH2fY8lvpQWeBPNu3p5
 pUKsH21ld2nXFCud+9HsngQKSQbKlxWSP2BjHoEmHxrSHywj/gLLmNB8z33OkzCafiEU
 WcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791278730; x=1791883530;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Qzr4xM8E/Ol0WnTSww3Y31WWioP3XMsHKf6j+JTpC4=;
 b=DGALJsNe7LgpmfmcSrfKsmZxkY++baLh04JS66YL7gDkF7L8J2v/KS1FUUuot38mHP
 KGM4iNs+79JccRWY/7ibqvtVnXAQMZ+DyQaSZwi8N7IE4orSP6xM5cOH9y/xA5foiLTP
 80Hdd6AOxvuSs8Vxl7JoNZuOvMrHuq3iMPsVo2TzoZzVlH5HMF+wGMcFcM+HfDKub8fr
 5EFowBhgm3xLYX7W2LW3wkjVtJcb3WgisSa/m3lH9YdpkqD6Udwz/z1Iq/CoUsWAyTkU
 +laBD8DmGPFWgZ/UxfYxfniIAiZEYX2ICd4mLYB6WJ2/kcjZLTKLT7F7XKnPNBWeKJYo
 qaeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEpgim70V1nL0GRIZ4A+WSCsIq+qZMG9WGsAP2YMN2js1kGy+xqDGV4rQ3B6/x0KSxb8xQuPRUcEsg@nongnu.org
X-Gm-Message-State: AFuF++mzNSM8iqKCmpZY1W27enXI7p/dns622cUVAT1da6Rp54SyJfLq
 RFNzRYD6hPnAYy1xDxF33xls22tcc2Y5/WuU1TCxNsDdhK0RdedaGg06mYc7r1evUM0HthWkVFV
 /21w3SV+ng2Ek9/O2eeIdqErB36pfNBAiDO1GDyuC4NHuYYpkSQkL35ObLA==
X-Gm-Gg: AYBFou0hmYgnxnxUZTvemzb55UkBwjjgf+0JtxqnXZZVEkNPh6R1Ga7g1/9tOE6Q8zS
 W0RkAMKQCnTDqKlXuzPsygSIO3Am9FQtK8R30dTaU+NA2/d0g6GuSKHMwJHk1UBP0qKJqjKA7M8
 zKpTQSDTMXf9S3JkJ0comB4EqeXKqvhJie8kQ4+wXfV9lxGIgYnfzu6d2rxXj5WTDYo3sMd/+p/
 E3CYG1h1ayd9/cgnUAovV4cQwDglw3PW4zgiDq7bnkaq5hFHP+I/IGhssWXRegYXq06Oc6T00N5
 7NJMktyNWBO6ylenuDXuTM5zKFEu0RE2UYNLFQ9pPnW7Iya4fg7nnAwbVKW+ClGkixDwFKppLYT
 1ZczyA7GYH3TUp8W8oJ954yzKJLSG8GGuNA==
X-Received: by 2002:a05:620a:2a08:b0:93c:6092:ac66 with SMTP id
 af79cd13be357-93e8f351d75mr132878285a.24.1791278730301; 
 Tue, 06 Oct 2026 02:25:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2a08:b0:93c:6092:ac66 with SMTP id
 af79cd13be357-93e8f351d75mr132874885a.24.1791278729864; 
 Tue, 06 Oct 2026 02:25:29 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a166bfaf73sm216094065e9.4.2026.10.06.02.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 02:25:29 -0700 (PDT)
Message-ID: <d62debe0-bc73-47be-8b0e-f7f3496b4f0e@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 11:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/31] hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of
 RAM by default
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-11-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006083445.30362-11-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX8OXjImM2Zzp9
 AXWY1fIj9L8/ebf8qKKIyjJt25igz/SP+3JXkbeABFuB02Y4PX9iPJxlhbUDqFmoixvBI9KD1Jy
 r+WKaO5klRmuqzgm/y0TNc0GIXUtHjc=
X-Authority-Analysis: v=2.4 cv=Vdxir1p9 c=1 sm=1 tr=0 ts=6ac4be8b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: YtD58TLM9FkIHa6SJ2pw3nOtJcJYLIba
X-Proofpoint-ORIG-GUID: YtD58TLM9FkIHa6SJ2pw3nOtJcJYLIba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfXx9vo5KaAei8U
 uB9NTdB+5EQmazoFbn9QzTd0TaweuceRy5Lp9DA+hEpPQ7sI6opqKmlA+//P9Zz0ysQa8zCmraZ
 3KDF53X98p2deOXNorSLVAY1yLm/LVPdRB1GGDKtqm7tJGMrlrUDbrEDydIHd+sd3EV8Nza+stH
 bzNgK77j+YeG/3+GUvsniLcqkSE1ff7JAF62F/5rZNnIf0wgZTCepbny9fuzLY9TKno6sUpMtkJ
 SCd6bocGnr+P/v7/3HQBtpYE/h9y89x41AhE/n8bIOanGqurYeKo0jbPhjYadAe2scT+UBEDoQx
 6kMCdflWuJZDsPXCDQavrKIpKM5/uN/SHvHY49QWmTifiFr+unCUBBIni1exAvQR1MyxWR3VLri
 8hQCBaflKZFvOu45k7DmvO0vxP9+pqXty419153X+cN6pPLFyFGfqwLylF79tdphj6Hx45hYpGP
 PUWxFgGxlHcPze4HnLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060037
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/10/26 10:34, Bernhard Beschow wrote:
> Having two CPUs and 1 GiB of RAM matches real hardware. Fix the machine
> defaults to make its use more ergonomic and less error-prone.
> 
> To reproduce the old default behavior for e.g. migration purposes,
> `-smp 1 -m 128M` needs to be passed on the command line.
> 
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/mcimx7d-sabre.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

