Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034FEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wge8S-0002u1-GO; Mon, 06 Jul 2026 03:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wge8M-0002sE-AH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:52:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wge8K-0006bS-JQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:52:54 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641Stl3593989
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 07:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fQH9C5SmNW4nJAX78bgKZGgdZNAi1Ei3RYTb8qMJuog=; b=KLTnZwh9G6WshgWP
 YEP1w+wwJErQjEXRetviHET7Wqi7NM6pvXesHBIPuY6TEUiEEhQVU6a6IwTtn38i
 4AwIZWgj3ZNOEYjyuclpKuytjs55QZdWtLuzD2rwu+re7ewBirl0IVcizP7zp7Fo
 SDzij5yHAM1m+mYAbhNhpD4jjVuazboZx8fDnQ1m7Gl+xRx+ipNFPSeM6stp5WCe
 ieA9wuh6nMFI7sVPE/UxSdn0O3/XG4Vu3AnJP62qqQLrtb6s6Bgiygj1QAJ+Guep
 c1PAK0gT99kE42qkMBWztn52Rg3jhv8XVLaZARZFyinf1/Tka5sctgyqspy3Lj03
 Cj8xFQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgwf1a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:52:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e538afe65so257657585a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783324370; x=1783929170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fQH9C5SmNW4nJAX78bgKZGgdZNAi1Ei3RYTb8qMJuog=;
 b=Amqc15/bYaVdKopcB7YJtrgK20rDOoznXX+8HjF8sDblj6DKBuXZhMX+r/5oG2tfdH
 Xz2VTk8GyMFufLEfEPEbStolU+I1Z0Loy+TCLNFlTkvNufRhU5u6q5Zmk66jh88HJ/JX
 GVyop/N0hALGI8Jjzhg6+7cVD2Z6vSRemzBZLCAhq/4X4AfD+w/5QmfDVmyS6nCZdaP3
 JhOgYYArLaVBzfjKbdLrxOZVnwLjjuIlJ/vPkzi1Wy5qjZL+AVJA2VYjKjvPh9UOoEBH
 DJPX2ctdYxytfZ0jpHKYZUUnaQwqZDjxy3qaTSrYaGyBi0QH9kv8KsMB59LDcuIcfy8u
 471w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783324370; x=1783929170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQH9C5SmNW4nJAX78bgKZGgdZNAi1Ei3RYTb8qMJuog=;
 b=OOyiwkoBZvffc28IorJBLI2BuRT6oiW1drgHyRe8i2g3jqqdKYAL6Q8a0ZHofP7brH
 R2aYVDXWhPNphdmK/3PzruLPNbNkMPFXKgHiu/r+aHVCksoC0EnSkudXfb/zwcZiVNcX
 8tsI5OS9i274bKVqOOWATrPTqjZs0D2cWLDkeBghFiWiLaOIs8DCnCGuX1iGb0805Sc8
 pA+DmGXVucEgQOGj+urvhgcI5cJeN6AAktGq/OcfcQYuWML5cO/5ZaOCaNfX6TplMPx+
 MZ66NVZmNp/OGCEuAblalVAW9I+xThfzaIBjPjq3meAAYUexcFSy+9fP9L9iIfoQkXHV
 ueWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxtwsUtndvqitSGk0OdkAMEBKG0ygi+pf1tt205LoEoCqDu+Mw7aD1dKLGhosDTR52IpF9kYY469qm@nongnu.org
X-Gm-Message-State: AOJu0Yyfo63cISoyC5Qm3mMc14eYFCb0JQrxEe1hMbhFtdb/BxBJpUup
 nqNZxX1ZT4rPUNryaJDn5WS4AFHW3fnnj9hvFnjN6Y4xpwEq6XdvKRkkk2c2CgnCKPCQzhFq8uo
 3brTVtd8z1kH4AfbrnMMnCepkZMdJ2+iH9Bf+Dwclm1Qakq4XE2Lj3j8oCQ==
X-Gm-Gg: AfdE7cnvsRo/4+AuJe2vmW7KXgaIcQqeyj74BzmV8J5eIbVs6ujkcJ8rmKUprsFESVe
 ToR7rNVus0tRU78I284fqta58lBYy/YdigMKizsrcxliRHxMqTz97Ft0JBlcsFW8KdaszVUDAYg
 csgoxZON9dDrHpON5PU1j+HgHvTK8M4EWCZ4aPQmqDxKH7qpD6bavpaiD2DOh42c2dz5ynJWQEQ
 +/BHfxyGf0q5P/7wNJowogs2xvZzc/5Rlq4yh4dCTtCxtC8NtFSWmAI4l/BJ4zeJgL2LeaIqc7U
 oOHlzl4pFzx3K2tSyLYcN5W4NXa5X/hJ/MEYUkPsCvffoD7MKJpvdUCSzr3gInO04C+jFTjPDSc
 fh4r3lSluNTvps96zx2r0TsxUKiO4cIxa0quxlmozjxaV0kbYJxIwEvOF2AXW2Q==
X-Received: by 2002:a05:620a:170d:b0:914:7e9a:2716 with SMTP id
 af79cd13be357-92e9a4a39damr1386788785a.38.1783324369999; 
 Mon, 06 Jul 2026 00:52:49 -0700 (PDT)
X-Received: by 2002:a05:620a:170d:b0:914:7e9a:2716 with SMTP id
 af79cd13be357-92e9a4a39damr1386786685a.38.1783324369492; 
 Mon, 06 Jul 2026 00:52:49 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cf68f5sm3595327a12.13.2026.07.06.00.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 00:52:48 -0700 (PDT)
Message-ID: <f59d4a97-4b8b-4128-ba81-b5c7a7f46549@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] hw/block: m25p80: Fix dummy byte handling for
 Macronix flash
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz
 <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20260630135729.466264-1-bin.meng@processmission.com>
 <20260630135729.466264-4-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630135729.466264-4-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4b5ed3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=qudNOe3MAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=5xjKf8XXW5LcFHKYHnAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=icPJRyImjHd6_pBPa6HO:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: 7hzMAB53cJiYVkpOKgSuZNmdCsUs6rjr
X-Proofpoint-GUID: 7hzMAB53cJiYVkpOKgSuZNmdCsUs6rjr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3OCBTYWx0ZWRfX7LuGuneXN4w/
 PaOTSuFcZN7qcvMOgnGjmLJgwJrZQmL08pKtUUxjxnEzBQQZH91R/EqKzS8aNgMw7EBtF9Hgk55
 zWP4mTp3OUcilnO/CYhRWDAgi8Bd/Vk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3OCBTYWx0ZWRfX3Tn70qc7TeQA
 6KutSjDDHuINNjazRXLvF1bgVAOZGG6DZ7d+Uq6XD1TvektogGuAHfmWvPqLXoZdeIMbqHV36q/
 bQv8EODqQmx5yRu0ITN985Qe2dmn5AZwkb+vBOPWReEWBEnOERz0gQPrxebTA6JkXYmbESi2oP1
 6Kh44EFCz0kTckuO5svA/D829GAcpKDLw6zkhvMuNIb5e6Bs3WaCUCkwpBsp+gjR3p+6Wf7up1D
 tDW2aFCMcaxYBI1vVK5AECxqBe0dff/Xj5lQ8HtAtw/9Xs0fDpKZD1BpN9Rzx8sIGoxr/u2AYwl
 CT2a0BZMwBJSODcr5ZyzfVN6CfXncTdIBQxs44qD33fa6xDvfojiIlhQ5I3a3272Jj9ZBtIbR0T
 Te3sSCDe785RuyeNxOEyd2YyDJiBhwZDIIKIdhnQoc6z77uD4W2LwoXbnkLGk5xi4coxooesRIy
 ZTDrK1DohlYovaO3lpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/6/26 15:57, Bin Meng wrote:
> Macronix flashes expose DC[1:0] bits in the volatile configuration
> register [1]. These bits select the number of dummy clock cycles
> used by the fast-read command families.
> 
> Convert the Macronix dummy-cycle settings through per-command-family
> tables and round up the non-byte-aligned cases that the byte-oriented
> SSI model cannot represent exactly.
> 
> [1] https://www.macronix.com/Lists/Datasheet/Attachments/8657/MX66L51235F,%203V,%20512Mb,%20v1.1.pdf
> 
> Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/block/m25p80.c | 66 +++++++++++++++++++++++++++--------------------
>   1 file changed, 38 insertions(+), 28 deletions(-)


> +static uint8_t macronix_extract_cfg_num_dummies(Flash *s, uint8_t bus_width)
> +{
> +    static const uint8_t dummy_cycles_fast[4] = { 8, 6, 8, 10 };
> +    static const uint8_t dummy_cycles_dio[4] = { 4, 6, 8, 10 };
> +    static const uint8_t dummy_cycles_qio[4] = { 6, 4, 8, 10 };
> +    const uint8_t *dummy_cycles = dummy_cycles_fast;
> +    uint8_t num_dummies;
> +
> +    assert(get_man(s) == MAN_MACRONIX);
> +
> +    switch (s->cmd_in_progress) {
> +    case DIOR:
> +    case DIOR4:
> +        dummy_cycles = dummy_cycles_dio;
> +        break;
> +    case QIOR:
> +    case QIOR4:
> +        dummy_cycles = dummy_cycles_qio;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    num_dummies = dummy_cycles[extract32(s->volatile_cfg, 6, 2)];
> +    num_dummies *= bus_width;
> +
> +    if (num_dummies % 8) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "M25P80: the number of dummy bits is not multiple of 8");
> +        num_dummies = ROUND_UP(num_dummies, 8);

This is a programming error, I'd rather abort here and not
let the guest continue.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    }
> +
> +    return num_dummies / 8;
> +}


