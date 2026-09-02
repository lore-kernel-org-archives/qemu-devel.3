Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD250C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nJb-0000Tf-Ci; Wed, 02 Sep 2026 11:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nJV-0000TP-Kc
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:55:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nJT-0007L0-WA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:55:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FZUai2067485
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ouoCji+867Lg6bLLtScj9Jf+voyEcpR7SvoYQeMo4zY=; b=oTgxpOlapyPeg3OU
 Tg/BhooC5h7tYiD4qZAiCloNMIsE2+dm53jCzdveYJTlfeU+5Uw39DwfGnTYFRDK
 eYX5xNybjQwN8bD9sMJcUNb8zC6e83/WQtZvpN0aKW/3UliWgIfqBrZY3dZyb62D
 u5cIdejcYq7kNZHsDdA+BJG+HiMrXvncVl7/m+s2dndmj9/DRqJaugNnz6UdMuph
 t0IA5Fr2acilq54jHUjNMCn/acyhZCG1pu0lT4Cka2DYPC9Q4jv4j6hvDABodStj
 tRIlzbnAt65uDwtOgZyhfG8j1T3/cJZ4UD11CqPxkdWl5CuZ/Nlz8+RWg97enYhr
 m1UqgQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv892uv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:55:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e62e3459fso234797885a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788364546; x=1788969346; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ouoCji+867Lg6bLLtScj9Jf+voyEcpR7SvoYQeMo4zY=;
 b=PCH/CAwLUY/xkKaGCx8IYqvsrVsRcCunID0uxyl19eGCmKpw5PpSBmGYKAwGdQfiBD
 9nTRDEuxhPq5TM+2+57VtJQtQqb8myX21tAYnCAf164WyWDAD7Jq4Hbhp5dL5TEGdyVj
 4mJtX3zjYX3+kJWuSr3EylyfAYQ+V8D31D9W5Mk42tAQN013EtV16zTBsAlnW1YAMUZR
 nQWDnNF3oh4vQaHaVMIsPZr31ogj+u4Lzi6DWIKIEgOG2X5jYIVyKKMwy1fhluW9c4AN
 Kb8g9SOW6CIr5VIj+zAfWASJVu2lbLWQTPaOtLhn5gGPPuZWvPVvVB7Vhu/f+Cqg28jT
 qQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364546; x=1788969346;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ouoCji+867Lg6bLLtScj9Jf+voyEcpR7SvoYQeMo4zY=;
 b=V7poz7ZSk2Kl9bo6ou1cbtUn8M38fmb1bOKWVeFu2JXG1nXR34mZw9snRd8kOgPnKD
 C+5gIaa7f/ozucM6051lZaJjo5G4kbQeIPv0eOGk/GcIiX4vIifHXnzqVU7WHxxcvRxu
 6FEjcuUg00lPqm3hHSrULZrlZWvIpDWg2XWx3Sql0C0fRdj4B/BWYKoWqMsYaeXGfSuH
 RMBMIXpkSuO6zWGuD9E/zSKPiangrQtzEU9HtVzlj1xSFDZoMjYz7ufG3MqGGvHINY6Q
 bs6+6lfVFyRTnIJc1wdaZUNuaTnzntNmcqAmXwhzZZlieOyU/FyyrG673eqkS97y4jY/
 Ppgw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rog+Ik4cuQ6yY0wo1Hbbyd0YBVAtBi3H1RqHoIpGpPGWvaifUPLCH0GfooWBavWSRkt/Qr5ivjO5whI@nongnu.org
X-Gm-Message-State: AFuF++lkIW8USLb5AHo/R/NOGvicC5s+FdUCgullYbMXL2OeGX9MD3gO
 6aGC5yPeOxNaynlpMHJu0gFP4PxxVirOpVvm9Y/rvxG/R/Qy5GiYGaUZkmGpT2uXkWY7BJxj0XM
 huIG4ko/DaxFKv/mZ182dfG2cG34lr5G/NUxIgaz7AADU4Ghk0p4DOc7eEQ==
X-Gm-Gg: AR+sD11LMMtskrsN5JkZuBhUn8m0Z10ZKnZtCVrR2F10q7uS8bvtHAnqzpBkY+enrt6
 lfjJ8Hwyhb5Z2yHqrDMnNOrc3wwWpzUSoicnTh5BeTA9A1mQGT/eWdBSol2ulxUHv3rYRvzz/ZE
 QhBCN42ZACXVtLqD1XvLxAnxmZ0DOW0NGzNuyKtzpIwo7ezJZ/HPo3GLhHHp3qXTzR6DxQr8pNb
 PSA6DwaKp/S1epTyMhgcXR11q1DBw0kG7oe3sYqBQ0PnsnnBHOBTOqVZirWxD0lrQYbAGbgf+fi
 4W7qyqMkwSPTc1WoJrVc0ldF285EsZLuMFlEeGTjbr63nV3AzB9jMpwIFyq4129dq3uR6bv/4PR
 TK+dV1ZqpCRZSMcQUVXbWAacwOt64I0n3+A==
X-Received: by 2002:a05:620a:224:b0:939:6dea:374b with SMTP id
 af79cd13be357-9396dea3871mr22026185a.47.1788364545739; 
 Wed, 02 Sep 2026 08:55:45 -0700 (PDT)
X-Received: by 2002:a05:620a:224:b0:939:6dea:374b with SMTP id
 af79cd13be357-9396dea3871mr22020985a.47.1788364545200; 
 Wed, 02 Sep 2026 08:55:45 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5e6115sm1092845e9.14.2026.09.02.08.55.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 08:55:44 -0700 (PDT)
Message-ID: <12afcfc8-e2ca-4d1d-89c0-54f8252abcc2@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 17:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] configs/targets: remove target info definitions
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-6-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UPzg-Jz7DWycPwaf91NVCWMTOUIf__an
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a984702 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=TXqgn4ZCpqUpD0GZQoMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MCBTYWx0ZWRfX5U0n2QacPysE
 2bWVIq+4/cgfCiNZ4pITsk5dncMxeCN2Dkq929pfnlmoQMX57Q0s4QebWSoOA302WBM/wYIPI7l
 8KibTOWJz6jMPTOKaJQuun0r/hDha9DP6CYkLJqGUvW7Yo87wuBjdnCkjd/znmkigfjrJAtEJ9d
 6wprADEaBGbjLlxBzRugZsMk2hRWjzVxaW/pvSe99WJXCWYkhwio2ATqASXJApLkGyLc2RhZ0xa
 gXM1ri6HfKrRfLNjraWIN2Yx6PwJmwdTqINVyPPlnyoP3sGjDUrT4WTNgyamnm79O8buQAEMl4q
 z9cu1kCLCDLn5Y1aLdkoUSM25DBmMjQ6YmODC4WUJnvnGGrgh8UP05+KM8CMpXooQ0+JJD1GtgJ
 wrKVG/vj04q+MtVBzgrodbcCPHuFeX67PhBOqizKGaM4cJWV04J53UVS4gPEFViBc6nZ25C+y8k
 rLzMgb194Aui/ze3wMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MCBTYWx0ZWRfX8FRuDvCGDJmO
 KYcJpxozk6CnHQs/Zu7kA4T8hLiSEik1xNCN+s0D2J+2OR33v9ipeVVIFB0CULwmrlJaKh8eeeB
 11RvuTEzhopisKxXPc5OkTwhPZCq0bc=
X-Proofpoint-ORIG-GUID: UPzg-Jz7DWycPwaf91NVCWMTOUIf__an
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020140
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> Now that we remove machine_typename, we don't need to keep duplicated
> file per target anymore. So we can just rely on target-info-stub.c.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   configs/targets/aarch64-softmmu.c | 26 --------------------------
>   configs/targets/arm-softmmu.c     | 26 --------------------------
>   configs/targets/meson.build       |  6 ------
>   configs/targets/riscv32-softmmu.c | 25 -------------------------
>   configs/targets/riscv64-softmmu.c | 25 -------------------------
>   meson.build                       |  7 +------
>   6 files changed, 1 insertion(+), 114 deletions(-)
>   delete mode 100644 configs/targets/aarch64-softmmu.c
>   delete mode 100644 configs/targets/arm-softmmu.c
>   delete mode 100644 configs/targets/meson.build
>   delete mode 100644 configs/targets/riscv32-softmmu.c
>   delete mode 100644 configs/targets/riscv64-softmmu.c

We also need to update MAINTAINERS. Anyway I rather keep that for
now (including the following patch). I'am squashing removal of
"*machines-qom.h" include lines where appropriate.

