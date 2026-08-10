Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1694CC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtG3C-0000RT-Oz; Sun, 09 Aug 2026 22:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG39-0000Qn-0H
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:47:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG37-0003wH-LN
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:47:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L6jCR4105757
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PdTrDhI+JXsXTE7X8TWgsDuxJb3Y6yJEI77/zJX9Cx4=; b=Hl+6+HgYHB04Z3DP
 JhTjKXxEAA4kPafAM9D3g5Yr4Eetl1E+xTke4shwCWs+e4BAlXPSsKbTFJTWuOS7
 t76fMuMwEhcQHb192odFQMt2p70ilBIz93CWKYgP39yxaM9tlwC67ebv0DqKHvnP
 NgRzhvvQZiPvT4H9dGUN28Tbpdp4C+2QJtYmHkKB7WQOTUXHNyHIapjmQzl5eD6S
 u8aJVbMGsFzrxhbNHRV+yGKVE7c526XasJAz+HxEhN2oNeTxF4MG4/OgLFXN8crL
 7IyNJ+oy2BgiTUmGXMLc1REketJb822szbfRhTtaVXpBLDMSodkB1/IsbLECdm9/
 afImQw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7c670-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:47:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so26923301cf.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786330056; x=1786934856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PdTrDhI+JXsXTE7X8TWgsDuxJb3Y6yJEI77/zJX9Cx4=;
 b=C9BMS7k6dS/8CfFEhFeTkQKpVVf92KbLyjiU8h5n3p4qZA/ATCszY+kKMajs5mUySp
 98lNnrttPXq5OJYXXNQD+lggYtwc/tEVIi3gJzlRqAi2+8M/zZGGmjSz7+//faC6o6VH
 6HDclPMNu+j91RFK/nJX0QGq0O19ncHENgx7F+OqKo40RHFKK2fUCLGxUm31UHABlKKh
 V03x+Ukh+WiVeTCJGlZbZd33v8eFB284aEkNE5TkVSQBorPrhGKVNLrJly01UC5ltCJY
 gQ4kRxOfZjlagcA/TAIbkGNgu+HYv1ZfayH1ncft8PC265B3x7wTvOXCS1IA128OIiQQ
 8Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330056; x=1786934856;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PdTrDhI+JXsXTE7X8TWgsDuxJb3Y6yJEI77/zJX9Cx4=;
 b=h/c7dzFNG3O20H10aiHQlm2kPunsKP0s1kdQUD3xx8/nQy3nJxYnfYMGH/gvsqyFsm
 yKcFDZhFqyN/KTRqShGIfLnP1JzG9kQ33u9nJcFqd654ga506yFG0zADxHcxDN4e9Atq
 SQnfZQXhnNDRu5JTIVgVe9/wrSnxABrkhZ3j4nzRkz84NbagwfF3CmIm+4iULjvbfSEb
 fvg1Iq66Qu27leAH70akbneaqSLXUg+E0qMhk5FEfpokvrVOMYdUvrPmM0xW7APAKj1d
 rVUE2/OlfoZmef6C+OeHh1eqGGLCUsfZr+hFc/pyZKb+78r3eYtaXCO19jg4CMy8/aUP
 cYZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXslvHx9DFZ943RcWpCzykC5HBPujYM/m+wfbi2AMHMIhoeBFkIS++o72xTsqGnUCOdHXzHMV6cF+X@nongnu.org
X-Gm-Message-State: AOJu0YwjXp/ovcjfkEmItrdp0DL/anmxMiX6IZyl7O369vkOATnw9TRP
 KzDg7bjPQ00wsPtgnb9HThSy3P+MgPG3ptmBMiQG4oiAetBg5osG5mVN63x+r15iZpWUeg0rteA
 dmNaQ/iDmJw7du5mcx/H3I2Yk1VcBCghaPEf0swVOJFclJVEQiPGibzAdeg==
X-Gm-Gg: AR+sD12PoBhZMlsoglQaHIdiic79NFLHq76lWE8ytUgZcbEysZ20LT1MtnJ+PFFI5h+
 dhGDhs7tRDoruMSrbOqmisVVa6w20Desx9MhVZbpoKy2aLmSwaJQDaYYeO4xPNSgOpTUG9J4txq
 txHn9Qq8/a6BnrfGpaQEQkk21kooqXL0v7OCkWcuULXjxiB6ebrNQOGQPVzXGXTzUmXoh+p4evD
 lV/WjLibpG/L2APTL+q5CDXdgXGsegbSgPAc3nRoUiEMnc67K3qSNsQGus2ByddcVISCizgGu/4
 DrUuxSeyAuTCIDCSgBj4v4EsAwCNJbrzX3cy4/f7FYuJfGKHrXekTWa61T7Aj7spamViKuFEsqQ
 saZuNhlJRVwgT2nMwbkWlbZnSM2aDeFreArQ=
X-Received: by 2002:a05:622a:c05:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-52d0b21b462mr303350131cf.34.1786330055683; 
 Sun, 09 Aug 2026 19:47:35 -0700 (PDT)
X-Received: by 2002:a05:622a:c05:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-52d0b21b462mr303349871cf.34.1786330055312; 
 Sun, 09 Aug 2026 19:47:35 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002206effsm27099898f8f.32.2026.08.09.19.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:47:34 -0700 (PDT)
Message-ID: <66b51f04-4072-4661-bd2a-f2b80e4f5b95@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/riscv: Enable disassembly via capstone
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809013343.664966-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMiBTYWx0ZWRfX+fgJa1AZFk/H
 IJm58TKsFxiY/QoPrFV7a9/EPC3ulKBUwfWBUzSe+ratesTYgY90JCz0KfYp7SpbUoBdesg8HWk
 3UChjkJC70BIP0I8E5vI09//d6vYOuo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMiBTYWx0ZWRfX5NJGHLAkO0id
 0qVVGhRCAhHSz8xpzyVw8dBaeYEH1I1djmW0BzHCh0GnaEHNXTHn4UnaVzG9RVq/dTPjKZxQxkU
 0dGwD7aNuSlqcf0wEyhQahAnRP8+yB0tmEAR3oRneBEkM3FQwTIDrvWoimtkgWN1BChbH5kWt+c
 om5CZAr3ukfTzT3GIaD2yKcPVVA1obmGiR7f+rtZhriZMsEZdXmYdD1/53dSKza8PNhCE9m3U6U
 d0Wfy58cjY3GUDa0CpuraAXLML4zTfTwHfjGGPDo24ClbwzaDvUN+Cy5Xf0eGrK3ywlPmDWoJvL
 ssqS4h4PPtHvahiMuqlbjS0gakY9a75+VIAFwPmBaU/jR2VSOXkibKm+o9eXVOSfQ3xyciPTUKY
 +UPkcPdWgGEKkbpZg/2dgxZGi6TDldtIB3CHkpbH4brRHravFVHrMX9DmI8TSj+VzEinv/c0ivf
 e1LftP/EBGlln3KmiKQ==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a793bc8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: k1Dfe75-u3p6lrygQeI36rkGN1RjO63P
X-Proofpoint-GUID: k1Dfe75-u3p6lrygQeI36rkGN1RjO63P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100022
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

On 9/8/26 03:33, Richard Henderson wrote:
> In capstone v5, riscv support is spare, but v6 is pretty good.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/capstone.h | 34 +++++++++++++++++
>   disas/capstone.c         | 19 ++++++++++
>   target/riscv/cpu.c       | 81 +++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 133 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

