Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C8DC5DF6D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoIh-0005s9-Sd; Sun, 16 Aug 2026 23:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoIf-0005rl-V0
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:46:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoIZ-00079z-Ut
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:46:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCZ8I4126845
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zec+HCFN4cwVJz6Jp4rkSBf0gIdg5n98DKOZJa8K4AA=; b=CnrMJwmnS155+Kb8
 AxIb1W5H3avT5kMG2LeTA2b0aEqFSwP0Nu87sIuYZTIjujS2BVnma1LParYxomFP
 dbjk0i34UudL1f0PyAf+W4ZX0NOf+oMBJKIgVeZe2VneQWRGQ4ewCgQKT+9Rt+7F
 0O4UwRzUL2YSMc8BBx/ABBy0tZgIONZEAwwVIFxtVb7TcCsrH/Xynbnr2FKru48l
 JAiWHmKqSkVgs+05D+TLRBoU4GZFyxHPuuz0elORjNe7EDPgiCe65iWjPDERKYUo
 EzAx9cis9lr17deqAKhe9MGsc/0b+pCyCgzVPmyeJMs0Znsrw6m0tzzlIFYD07wc
 csyw0g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g322qapx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:46:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93494cce712so329739585a.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 20:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786938363; x=1787543163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zec+HCFN4cwVJz6Jp4rkSBf0gIdg5n98DKOZJa8K4AA=;
 b=YJPkF3MtJZkTEu4+RPGdenZDCC9/NtRYli+WPNfxTuh8R5nb4AzOioDIsnA3t+YjQB
 L5ipY6DALU57NlVEBA1oS5LoqFoKmXTgl8QQZA1RwH1wTair36PYzmxFvSkk8L6Z65hd
 AHoZY55fajwg+sveCwOCaLD4DXmhRBxIpgLaAsWRVRBkM/hQnuIJ9x1EBpmuqUT2ZtL5
 HiYN5O/56m/WCb0fN0D8VOTmWGO2nocql4NhT4vtyKqREDw4aT4upoFKp5Arw48yCPzc
 OZ5em9e+gBWyZzbzSCdPNxAP6dSoNVX0ZoQnkS9bhxIe4KhOqj4jqZItCm2jAIYlLKB6
 m07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786938363; x=1787543163;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zec+HCFN4cwVJz6Jp4rkSBf0gIdg5n98DKOZJa8K4AA=;
 b=LLRPW+gGNgOb1ORp6HuWwPlipcPb1ze2oS4tB+8HgOW5I6mn1j28u/74OwUVc5bcIO
 C9P2krc4R406EByOKqz/3TcmTZijMFz0tlxPnqzHtMipA5PAqI3AlkpyYt2Fk4vDcITh
 CxKRDI6RsKrm/665ucqNTtU8LldJjKO2XuNYmWLKN+N/+qYgaKJlMyniyJuv3FRQ+iMV
 mjMHKA9+cBA6cODTiuxHl5oSSSXboIw+edR3gByjnMptt2wu/xtH9SUFdywMkglPK/9r
 JCDn8ayg/P+x+EBV4unFEA1SHldy+YrlaQQ64bzIVsYfADhYcJ9ZfQzLB258WQR4XGIq
 7akA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoI+yOshBE4Q67q1VL0wg1QQdBwaMyCD8OV6RUZVlGAmrndYW9e+/bAsr6TBUnQSHHG8oXZO83Nbh8Y@nongnu.org
X-Gm-Message-State: AOJu0YxK/cE93CCQv477qyWH58Rxodsgz4qcTxmFBRd/IrHredSPQODH
 YUqyeqXTObBFFzxFyRtHALhf+tsWPR600QZYE7xJ4TpQI3NuTejALzvXbpI6fgDHgttFndcwcFQ
 R3d8u2V23MkLm1abF4AaaRMgze17JKKreL5vpBI1asiJqg7QHzmV5ncOq/A==
X-Gm-Gg: AR+sD13WraW68rNk60J3+bhiptecjP8bkSb1cv2Ec7VZ0DoVKVp9am0NWzXRDeR96Y2
 1zRbjATnTLbr6AZwDbBur2b1C29LdN70wywx3/iII+YfckuRDH/wxK0/bEJxlfkczBbC3wJODnY
 VexNPot02BVxlr34oqdTcuIg/mV2O7RL1nFTnexTZXkXpaKjU20EX2fIqYV6/eYjUttxf0JeeAd
 fpi7NwahG3tJvPoFHSsTd+H3u/chz+6NZHISzRMkoM5xy8Raq/xuWb5B2Ompty66IToZfe2wi3T
 pDIvtzSQ8OkU3lybgMa+Wr1Sqcn8N58IzrPt3jJT9jBpGhPpcHP1Raxea7giNuEYZpGRHPNssRQ
 qWM13q7w4ncMCiSjv8W5x38DnORtyl34Cjcs=
X-Received: by 2002:a05:620a:9359:b0:92e:54b3:3f86 with SMTP id
 af79cd13be357-936d23632a1mr2012454585a.29.1786938363597; 
 Sun, 16 Aug 2026 20:46:03 -0700 (PDT)
X-Received: by 2002:a05:620a:9359:b0:92e:54b3:3f86 with SMTP id
 af79cd13be357-936d23632a1mr2012451585a.29.1786938363204; 
 Sun, 16 Aug 2026 20:46:03 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998ca63e5csm91839725e9.2.2026.08.16.20.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 20:46:02 -0700 (PDT)
Message-ID: <6a5792fb-ee94-4aa2-afc3-44e69a58d86e@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 05:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 44/49] hexagon: condition HMP-specific code
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-44-e53fc35bc550@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260816-qemu-no-hmp-v3-44-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfX6K8qR6Tor8wB
 3DKjsNtSjoJODfTbcmTMaf6UdfBhaMBPMyg4amp+blwPoHghV9/tePmAz2WD8TUBz0XRESbJrgN
 B4yEBt5qW63wAW03hST+Cf1lNiAOpTM=
X-Proofpoint-GUID: gwOsQf0rQ2N0ksFqV2BObi1Xhr9d5LUB
X-Authority-Analysis: v=2.4 cv=C5PZDwP+ c=1 sm=1 tr=0 ts=6a8283fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfXxStJTur42MFP
 /pZSS7B16jctTViMln88JailAObRUhZ+TSDhLY/YU95kmSEtYGz5SJ0XzeN0LaUbZYlFEzQiBWJ
 JuvJYZDPZz9KJA6p0htQJOD4agtQ0C+C2UDe+w/e+NeP1C56+ETk6Gur8vHY1j3nnfylCGtH/yb
 qQA0J1EAUWVoSMA/WJ+VYv4tus5kQXVBKvYYEj3zx0/iTtatXYMBtdY4LLXvNgAtAgm7gVBUZju
 KgLp0RMc3997oi7AmoZfZoRJNK9PwdnBVPHoxtzX7ReKLKR/pxNLRBciVGQnfb2u0bTj9fImNwZ
 LDxmhZE6bxdCrY94nwveDVFvYYjOkyiKch6oZju//AaiyQCn+y0L/fCY4zVTTLxh7edvkvAVuYP
 ZQuKHWgGCZSQ4F/XdBAKq340SBB3lE+cGTBXXTbGkTwIdyAWJFXvUif9foMTrIYhZUcD/Cn/ODe
 P8iE6E2NivdrQ4QL4Sw==
X-Proofpoint-ORIG-GUID: gwOsQf0rQ2N0ksFqV2BObi1Xhr9d5LUB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170026
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

On 16/8/26 21:13, Marc-AndrÃ© Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/hexagon/hexagon_tlb.c | 42 ++++++++++++++++++++++--------------------
>   target/hexagon/hex_mmu.c |  2 ++
>   2 files changed, 24 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

