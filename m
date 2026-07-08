Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5FBC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whbEZ-0000os-Rt; Wed, 08 Jul 2026 18:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whbEY-0000o7-4b
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:59:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whbEW-000173-KC
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:59:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668KtMAd3946548
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 22:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ZHvPci+W5HxwrZGd5ljKFEhtiBL3xhWgwc/GNe40tI=; b=NNdoDRP446TjBMPD
 5nPA247bTHe9h2yX14pyMacsQlbWVnRNA2qc0aigO5oavXq2ITjYhmISkAuStqgH
 ZdcaGECd2zZPfWpyGsBdMlAfsGRXrJLAQ8+hZ8DhX0bKRLHdBM8AGuoPMl+vC20R
 OEJauzeXxLvbNNkiVZD1SwkLXuYI++LlKwyRxDWLExV6GwhW+6BNq+MDdgb4TTln
 0wFvHKiwpgFm1K3fLYMNSc6npTbxUVft/XrsgMWXyh3fJqurYI5vLuYft/D04/jB
 MU0dVGjZIfspPfOnh/qKvkrEKi+a6LtYrf1caTcIJiZl4Wi+qRlGDUGtXKs68uz9
 yGQLPA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqs9dbt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:59:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d137a68so26995911cf.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783551550; x=1784156350; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9ZHvPci+W5HxwrZGd5ljKFEhtiBL3xhWgwc/GNe40tI=;
 b=JiKPCsynbPZqduaC+mWuTsIVU7sLj3W0DFx88qMDqmCURii8TKsI1OYNJoxyc0Y42T
 8/phqwLpS/TeBbtmJvSlExfMxFTLnUYkaywfDJk+sQOuMJKOrpra/HhpmXCAZqA4D1JK
 wa819+ueCDbLSMCbVe/hfZE+uKvKRm/pX1/GNFBC8ZZfYkEXOl8JPn4CTQvvsLTF7TYY
 aLgJ1xN7ubUg47dLkQ/58fvAXptTY/xEHJG5GMejzzGbS7K4kw0jOg3V+2FJ82qw3Cce
 /5u9qZJ+Eq0QABcl3v3Ms/fBzh5BWlf3Gr70IohUd7yxZz3W2z4bFxTK8Edj7tDp3yTm
 jnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783551550; x=1784156350;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ZHvPci+W5HxwrZGd5ljKFEhtiBL3xhWgwc/GNe40tI=;
 b=IfQ2h1e9H9sgOrS9N49oF6B+sfEe8U7AL4LnsmtD0aVI41w030SDFSwBOnzNPUKLDr
 KQeTgckYUjy3Mb8SqqMNJJTcRaiNZVTTtizbauamnEzsxBfusgmChWwfGADUsmkLlIII
 fZzKkaCuiCf7GcY7rhYXEHOzjOFiO/cZRxK5iu9lwZ6fxy3ZvVYPF5XwV3YXMXvabeK2
 PH99LssEQiJIYe9Lk4D8DlRu+b+2FMPyccFH8PpzRHoxiFV5H4aS4ZY3yvNUWHUXOcQO
 aLUBvphGlqertsh+zZQqQNiMTB2XHBPFq23qEumeZIHsU7k1JFFfjB7DZ9gkQ5sMPDjP
 g5Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkT0nYRwElIUXHpi7mnFpUHt+bUjOVX+K4lDK9+sP6VA15i1aj6ReQ4EnG6pqbKw8bFZ83611dMc4I@nongnu.org
X-Gm-Message-State: AOJu0YwUy+vdPiuJg2Kh9bceASJxipSuHRoUdenMwe7yovMCODr3lfsH
 jWActfCIU7hFfWV1ztpgScKfdL9EH9/QUvXXeA/j+9vPvbusQkUC1BZgy8/qvxlnxGvRRlTi5lo
 yIWz6REVrUYdortnJybnsWvdZGTK16W02KbMkKPc8aRw4VCGA4R/6cDjdtg==
X-Gm-Gg: AfdE7cmDlfqs3Pv40PFmRgMSHEUgYXNqmGc2QBYMogVo1t/ksMyjUXAxRt5J8z2LIhz
 9Y7SZwM/fPPWOwe0U/KPINFBw1QWlYZpZtaGtS161zyWe6ZUJdTExLrSemPgRsSCrzvKU5GhkkC
 RBuvNQEnt5T2CKJZEAq5tk2TI6K5sJBScRgmFdWcPhHUeHGtMjaehZuXMVQZgnQebNGfwHQAP7m
 8hLgIFfKsRd2t9F3HnA2FkDDo0i5EDO1AA6KO78I01d3PNqTyogrH+niezlfBG1IbH+POwOAXcG
 BxhfIYJo9CBmAZazoWHL5On256530PZcMDQuXfFwljoyUlU3MVoodJYtNijrZEaXs7FTfEyffso
 UVGfJUxcQpJ19arBfPh/wgnNCSsmgRPkGaFAQBA69egROerryPLw2i/HDyxn5aw==
X-Received: by 2002:a05:622a:38d:b0:51a:8c9a:8fb2 with SMTP id
 d75a77b69052e-51c8b4c751amr48472691cf.67.1783551550411; 
 Wed, 08 Jul 2026 15:59:10 -0700 (PDT)
X-Received: by 2002:a05:622a:38d:b0:51a:8c9a:8fb2 with SMTP id
 d75a77b69052e-51c8b4c751amr48472451cf.67.1783551549825; 
 Wed, 08 Jul 2026 15:59:09 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d7a375sm8443335a12.15.2026.07.08.15.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 15:59:08 -0700 (PDT)
Message-ID: <3d2d869c-d1a0-40d1-83c2-755c080bd17d@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 00:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap support
 for AST2700
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfX3rTxu3+/sNPt
 leR7Sd31CAcMTib3myMXGE/kCM1ONPWULqyo/7gvinTE+htxrkwSQPNWTS5YuJ/m7OEe2Kk+J4I
 wfwqnQLlZ9TGl+TERgPRDtbucaNng9A=
X-Proofpoint-GUID: 62jxDTLQZ_2hp6scbLDwURuvqfLA-R_b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfX3EOw+ejSdeyA
 Hz8LVG36auB+OMC/C52AQc9T60YJd6sIdCohHhAPAO/8EfhuA2Zo2ipurD4F1O3xYRld+dsXYOu
 79FDpCdykVAfnzxl0zUfrV5oB56uPNXPUsxFoJ+XuPxkekXHthGRb79/9gxmRxZCpgVKKbZMltT
 qse6eVv6z8RKGTfuL3Pcd79hGC4fSro0FGeLf/vlNuykjox10oJOxLkPrtdLVfnYlVa3xUg7oEK
 7wXCb19EVei4xwoqNyWFw84ZL+f74vHo1pffjRBbRzlRcGa+o+v4C7VjZL0QrgAMifIJ1ZmRoeN
 PGcSRibp1zr4ocC5iugqMrrki3tiUaBMJaS0ObhTAOoraIHu5H6otOJoaPVxuC4Jp941TC6bu6Q
 IEnMgukzscKfq5sopyB/bnxAyf4ocVlwv8qKShXsU8iMfURYVGQD0n6tbeqN8Uke87CLeHo7rIl
 RcGH0jFydvqxLF7KnQQ==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4ed63f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=E3A8Cuo5wui9a3iAGOgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 62jxDTLQZ_2hp6scbLDwURuvqfLA-R_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080226
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

On 8/7/26 11:20, Jamin Lin wrote:
> This series improves AST2700 platform support by aligning SSP/TSP
> power and reset behavior with hardware, and enabling DRAM remapping
> required for proper firmware boot flow.


> Jamin Lin (10):
>    hw/arm/ast27x0: Start SSP in powered-off state to match hardware
>      behavior
>    hw/arm/ast27x0: Start TSP in powered-off state to match hardware
>      behavior
>    hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
>    hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
>    hw/misc/aspeed_scu: Implement SSP reset and power-on control via SCU
>      registers
>    hw/misc/aspeed_scu: Implement TSP reset and power-on control via SCU
>      registers
>    hw/misc/aspeed_scu: Add SCU support for SSP SDRAM remap
>    hw/misc/aspeed_scu: Add SCU support for TSP SDRAM remap
>    tests/functional/aarch64/test_aspeed_ast2700fc: Boot SSP/TSP via PSP
>      and load binaries from DRAM
>    docs: Add support vbootrom and update Manual boot for ast2700fc

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

2 notes:

1/ I3C errors in dmesg:

[    8.151230]  14c20000.i3c0: MIPI I3C HCI v0.0 r00
[    8.151498]  14c20000.i3c0: unsupported HCI version
[    8.151761] mipi-i3c-hci 14c20000.i3c0: probe with driver 
mipi-i3c-hci failed with error -93
[    8.152250]  14c21000.i3c1: MIPI I3C HCI v0.0 r00
[    8.152518]  14c21000.i3c1: unsupported HCI version
[    8.152779] mipi-i3c-hci 14c21000.i3c1: probe with driver 
mipi-i3c-hci failed with error -93
[    8.153322]  14c22000.i3c2: MIPI I3C HCI v0.0 r00
[    8.153588]  14c22000.i3c2: unsupported HCI version
[    8.153853] mipi-i3c-hci 14c22000.i3c2: probe with driver 
mipi-i3c-hci failed with error -93
...

2/ shutdown not working

[  246.405297] systemd-shutdown[1]: Entering exitrd...
shutdown: poweroff --timeout=90000000us --log-level info 
--log-target=kmsg --log-color --exit-code=0
/shutdown: line 97: poweroff: not found
Execute poweroff -f if all unmounted ok, or exec /init
shutdown-sh#


