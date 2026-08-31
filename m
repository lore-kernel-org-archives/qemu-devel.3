Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1945C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vCo-0004fr-LD; Mon, 31 Aug 2026 02:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vCm-0004fb-Un
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:09:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vCl-0005lV-GN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:09:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52VRR2423203
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VJ290nMnUV7cLYIx8Rizl4LCOGGz6eeneu79Q2tfPPk=; b=WRawIh+yE5snzG5n
 t0SZ4kumHxgEG5Kr4VQI2uiIz+cYwFJM6QnSuuVPtb0Ww9VrtCVrGpdQblAo0L8R
 llPYfueJP8gS5wprIEWckkfdUuULRw3IdzAIUG6pVerKADp1uHaYRff0uSi3Fb8a
 EvTxjR7l9SjG5OApsJE0s4z2zNCGM1oSws6NLZUg5WXX8kIRPzaY7y6ok+VXcEJH
 4+piNifud7Ph78FtqGiCvCxK7tInfkHPe2f5tHPhEPuqoAon3JBYPaDrM2eBybSj
 C/hwY2nyQBd9I62b9XFy74DFdqqCkVwVl7DqWq6EVZQQa0e5Z8FQCfTGpi5oxiPE
 7KZfsQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2cu8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:09:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939062ecda9so370926785a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788156553; x=1788761353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VJ290nMnUV7cLYIx8Rizl4LCOGGz6eeneu79Q2tfPPk=;
 b=h4wMnR4i0AoFgq++azKgghCeFpp4n4R1aPWKkI8f4PLfqlV5kSF1Us57/UUQ+x29nC
 XJzsUeXktVbqGIem7/k0dMZapZl4WofVoSw90sQw4j2zdyB9XkFobv6wtNf2Qi3u30Xc
 53SuhAtJdVs7VaERZT+uGSf7M8zy82DRbi9iVxcD6JhZN8TpeH+EtxEEelDpasbZhdFS
 s2iIZSlSVhs6OvGVpaTssElWFGzXELX5QOUJotjsK7e59ffWJ1BA/R0c94j+Ve2MSeL+
 BUVztNN3kmyCiM1vU5UuS+qfdIdxtpK4jobb8/mLuu1BFXrxkrfYMnc8wCk9Y/NqX5wE
 60XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788156553; x=1788761353;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VJ290nMnUV7cLYIx8Rizl4LCOGGz6eeneu79Q2tfPPk=;
 b=IpmocidLQTurLRDuWpznR0a0bH+EUmOmjjJtRi6LAPkLDMte48bxj7+yTPkqqB7h9U
 MHvA/1KVYTeOp7qNIWQQsIgaS4SU4yVmbaRkTG9HO8GBFQvEXvb8/Ha/zbIjiAGpV1lY
 6dh92Ti5FG09KSksuXp36QKkVI9mtAz7diCnL4Kq2qqVcreUMzH3SRWCfGbFXeuQFTPB
 qpxCd9jaf9YZeR1xCAYtIOoYSwIg/knlnuvbQea7dFrg+A9iJUVbE9ebGZQBBWYC9TDJ
 jYEXn+0pqMIIjQE0TEK/nHDgb6HSPYsh8gmOcIv7Wa895GtOktwirv2ccbboSXnNe8eA
 QZwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ0VeXPvSGVQQmkRsur80M/H/9zUYL1p3nw7sGBiGm6erMI7Y5md7qrnUVngcu7Wo/jWNdHWptfjDp@nongnu.org
X-Gm-Message-State: AFuF++kZ8baXzECFzgS4uS/fJFs0pUnV1l7EFpnbA6nISHKs8f8HwfEm
 gxrWFkqnyRMlUMEAxWbt8Q9Q/AKlcTzn04hmbKUpAegaBAKdyZMR8yzqSq5p6WFZVmH0iHBF61r
 bOPMbugtyShsFQMPYti8S/rg2BuzTMymscI7kioL0I6VBxyScpkJjiNDcPg==
X-Gm-Gg: AR+sD11ucfC9VlkX3HZB3u+ttch7KhLZqejO2EL6bcaqBSYE/Zuj+OL2HOT59hyQvPm
 oHbgLY6qscyfJwcG6XG+pwuO1VjFOmOrSK3LF9GW4SMekugYKVXQSZdthQ0mRrUsu2af/nt+Mgy
 Jtx5YMmZHD0LMQPPxlrXYjdldf2P+VBD0gRobag62FdIQr0u9Eh8B6yIDIDgvnNzRyEUywantMU
 +eGAraUK3EAFDwDb2Mvbmy731m0WGfVlzDlcs1sKQtzO7AV8IruFDUgSN7VK6r2EhyxqKUS/myu
 8JQWbKXMZ7S2uSh466r/sWopYOou5sdtmaXCO7T3eMFWY+mlkixSXmySoTkLAqpQrlrrKhb2BJQ
 VqF5mXOgff2EiSNEpujSns6PoQ6nnFS29Eg==
X-Received: by 2002:a05:620a:27d5:b0:936:af9f:4c30 with SMTP id
 af79cd13be357-93942b2383cmr77448985a.25.1788156553315; 
 Sun, 30 Aug 2026 23:09:13 -0700 (PDT)
X-Received: by 2002:a05:620a:27d5:b0:936:af9f:4c30 with SMTP id
 af79cd13be357-93942b2383cmr77444485a.25.1788156552699; 
 Sun, 30 Aug 2026 23:09:12 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9617179asm119466845e9.2.2026.08.30.23.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:09:12 -0700 (PDT)
Message-ID: <2bc1d662-6f30-4bf3-a81f-01222863ea60@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] target/loongarch: Use tcg_gen_lea_tl for ALSL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828224451.1564072-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a951a8a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: FAwINMrIbxI09xovTfw_kdOn2QtDqqRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfXw0j5F8L4gO9z
 SvYmeW8Wx0Lxihy17Ohrx/garYlkGx/sVyMPWgurGGGdNKufsuNh0w/0ogYEy5fDZ+OJnGXVYYR
 fn7LJhL2AMsWNzWCE8NNxLuOVZ7wOR1eBkc8UOuXEzknVprSiOel4WcsH2Ut5HsKZWW4ZfBY5wm
 5NtX2jOwg/i+2EQCDVerg3JgPawM2uogVOE97zsp1MAhXGjRexelZH0tYW4MMh3nqD6Glm87Frb
 IvOo+gbS39mtNwHy24P11gPvKABSu02ngPwKY9HH3PjjB+Bd9gWaIU19fb6BpJpUO5B/jhGY+p5
 THL+PxYPWONggzvyPM/H0vPBaqikAyKT/X4lTVtYPUqArmhqZ3Fr3RHEPgs53qLhNuaLcP0Vde5
 YW03ugMPDKdExGuCBoiT6vS6CzoC0SZRVPRslfQq1aJAiQI+LdHgEWQUTzFZPqR3uXHCQbFDVLd
 xuehMspvoI18w42GsMw==
X-Proofpoint-ORIG-GUID: FAwINMrIbxI09xovTfw_kdOn2QtDqqRK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfX3EvKD5+4EPME
 KtRt7pfzX1hRIgC/D33Le7rUXn9fxJXiZ0nUe3WVuapW7DVzxX/DU9irz010yNJMZ7heJ52s9QN
 2xqDiI/JMvOLCf2pFMfGX5+q7PjLDhA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310051
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

On 29/8/26 00:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/tcg/insn_trans/trans_arith.c.inc | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

