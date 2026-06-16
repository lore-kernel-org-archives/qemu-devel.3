Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C324FCD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZHaX-0003G5-12; Mon, 15 Jun 2026 20:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHaW-0003Fk-3D
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:23:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHaU-0003GE-NE
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:23:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ17P21454047
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tO0j1msQwpegRTHV7kln8V7yK0ciSqx47q823HbeFS8=; b=Q10LhRpDynHA+R/Q
 usjWVnhXKpMdtFFARLsznjoop0ePsN3my2rioo4/PN2eN81PUVtfpV6R1hhtx/Hh
 YXWMyL1AL4sprtXgZMyU/cvos1Yohhy9+39UFk/wowt9TnZGxCki/Y1N3QmoZoP0
 cgjqj/XkWlvrB3TNRErU4ibgzWlcEySly2J5bOTjJ3oIdz2fK3kd136M2DOyywPJ
 J4k3FmEEyw7eCVFRug2etvWNppQsX6gXbxzh74zljYC3a5JyBssyLL6GP0fZhFMz
 x9N904J35Y2lXSE5yoGrX+WQWLlWq2DD6gPWRpAfmuWE04mWu5weiw1FdxJRpOD7
 x0OlqQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2cc9rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:23:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91931144870so442423785a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781569408; x=1782174208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tO0j1msQwpegRTHV7kln8V7yK0ciSqx47q823HbeFS8=;
 b=T4i96ddd23QJdGzEcD2t//ppSV6yul6SYsUlvagAosvjRfSiK91GLlXpge3CQg9xV0
 ZMrCTQXZcgE2QHugxi3/1huvop9bDj2mUEo43w57luXVQ+b8g8yhlEWg5n3COdiKfJFf
 QEJuO8C6ws27oJakNSetdoCmY/wAYWSiSD19FS0y+DIhd67q39g6ILzYUoxZoReJndO5
 80a2NYIu/gtt5Mk03DAZaRvYqSfu0Gq9wF/sYHpmlM+IWxKCqgp8tlU0yN3qSbizHLQm
 CeEOouhiLjYilIeekPmVy35Zc91/B1dXlWH6AERG3D0ep51bJkxwnkt/W8bymPCoU4AY
 /roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781569408; x=1782174208;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tO0j1msQwpegRTHV7kln8V7yK0ciSqx47q823HbeFS8=;
 b=Fq/JR42BFGSOHiMTi+weewFywriyrpzZamnnBk8+1oQxY5ecq9sJzMbL5gQ+a2NDae
 RjwmoOJotR+6HznahzBcYuYYM3i4PQPxTUEQR1XJPl/Nf/yzc48f0tt59uyCU4kt2z8Z
 FIDRKsC8PxrOa+eEgLVsWM7nUh58mEgBJq2cHle6nY2m4opJYqF8loLZVlIqAwxo0N6s
 ehxz8q9Tk0JFN7DMeODSs7oOjudv6Ya3TrdrutZxvK4Z9W/7uqFfpquznEBkSm95TPYT
 DtqdgM8furIVmiSnaOP/5ljvJ7BmqJJbsKTeI3LI15Q9ci9fSP+uYcgdHnmoEh/caZG9
 cZWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ883lo6qQ78dZB6O8mH8eAgAzBRAqeMPdwCImdmklliyy3q29AcrulZvKIf2IYxaHa69gPu8FxnePSN@nongnu.org
X-Gm-Message-State: AOJu0Yx77OUEmxdvk7wbZcDhnoqdPyhgCgX54aDAqYcd9oIooUZ/isdL
 gTXLYPIUxMHawbZ5xCdNlTmIiD0ly8JAN5DWB4dVboFyFm3NP+PDXjZvBxq9ohq6YP+cFgnN33z
 XVNx/WLhjrUY2fHyD36snNQvNlxJZ30nuU05TyNVEiN84q5i4k574mU9VlQ==
X-Gm-Gg: Acq92OFT5awnUm9Jb/YCtlB0VNFuzxmtL47LxcMRBsntHZ7aSGCWkG30J+TbO6Gp/2a
 Jze3sGXw/SjbzK471Lvn8D9VYvt0EEsYcqCOB5uAZ5FmXtJvBl3SkYRLs9mMksNTXceOMM9bVSS
 7MC+fafX//cOXVesqgot4Lguzshidp4t+Auym7GfLkE4+GCdclKHIvWrPFYOwGhPr9OS2Z4OFn1
 AOubC/gblI3cL5byA4TT9qjbsmakeqGxsk5k9tQ3/W0CEXhV9EoQjywNBCeQOiXXdPixjwVekKM
 l5h+n07E5nixjUD/C62a2uG4++Tr/AOCjQOjj7+6Cclw13OosYGqVepkUssI1UFjXaLt+65z/+3
 4TkTbiLwyZoqSWnZPcihBKMjdDmQqd4hHxsJnkTBXjYogav54k+smD9SdVbo5F6VqORMSFibZ
X-Received: by 2002:a05:620a:448c:b0:915:e670:4021 with SMTP id
 af79cd13be357-9161bd3cb48mr2525041985a.45.1781569408493; 
 Mon, 15 Jun 2026 17:23:28 -0700 (PDT)
X-Received: by 2002:a05:620a:448c:b0:915:e670:4021 with SMTP id
 af79cd13be357-9161bd3cb48mr2525038885a.45.1781569408116; 
 Mon, 15 Jun 2026 17:23:28 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b39e9sm237806425e9.0.2026.06.15.17.23.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 17:23:26 -0700 (PDT)
Message-ID: <5ad9da6c-4484-4f04-bb8f-332a15fb9413@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 02:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/26] plugins: use consistent parameter documentation
 for userdata
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615193526.2883349-24-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615193526.2883349-24-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX47swMKKRsFZ4
 2rBx1oWUmUNPi5jDMVzqH9Wm2K/edr/mVVytQl0haSKG1D186kNyxG/kPGwgL2vtq/fcSNnXIOB
 KfiqqDUyGeyko7mmC1ILd8M6ahWkVYXn4Amw3pzF6nc0nfUwYz6MLSTTSN+kWc3YV0vv23HqaNw
 uwQuJDtQ4InLn9BV3OFUmsER1QIB2vQs9xUpNMsH7pkAS2LnkBiF73hYoM7WRtSVFaeNOwtRRzm
 9/fu2UZD6gic3RWS7ixaRUwZiFS2qLxy5oUdYoVceW5l9uocG9+HQohBB7p+OS7XRHMmEG6inRT
 tR+ED//mLp7yropabxM43PHL/ilMtt395SG6eLZAr1c20/Gr6keFj07jNoc8wyO0ctdoWLJEEe7
 HDcEZdg5pTO3noas1A0mwWFNW7HMptKPBqlMpYRwZ24c2y8Luz0sy4kUx2mqcphI0LxDB2PdajK
 z5TgvEU+LufAx06703Q==
X-Proofpoint-ORIG-GUID: rdI1ixR8nR4gmH4Cl3QQ9JA-bxBAlpWz
X-Proofpoint-GUID: rdI1ixR8nR4gmH4Cl3QQ9JA-bxBAlpWz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX17pnHn2JniJH
 9VjqYnf3qmSKUesjEf8Ao+J5i7NtAtFabadVkA2JBBbooRdf7rdgXFKwrOWbkKRNxuABKlmMxa5
 UTlTb6eHPWvNToywU2XVqxfkadYNBZ4=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a309781 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160001
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

On 15/6/26 21:35, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/plugins/qemu-plugin.h | 36 +++++++++++++++++------------------
>   1 file changed, 17 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

