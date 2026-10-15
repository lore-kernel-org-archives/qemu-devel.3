Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E9CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPVM-00072W-My; Thu, 15 Oct 2026 13:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPVL-000723-FK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:44:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPVJ-0007L5-Px
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:44:35 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFE3lw2678387
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6Q8Qr/lfjrYiNo9/X1UXJgtRJTid9RHJFQATXmTFZE=; b=WQ2haSsPhy6Es+rJ
 YxdioBqqiUbOKLQHFvoI3fJZK9kN/0ZHfPZFGeqXKlty6Dqdjc+jTsKdec4XNwTv
 XB2IECUAoi/n5lKTbHuL0AauRQTuayRyzEc7L0B8iEtK6RfLiPuKhBLBZmOPyswF
 BCQ19BoYRi73Cc+jgCVLNNXYvioMOGqfVZzAX2mB1jfiqWgrG1tsv5AuxW74Oi6W
 yRMHy+FhWYN8lUjdYmqjjxKXTXBS6tGjMeFU9bpe8CJ13R74VdLdZUOMGlrFs/Jl
 bxHa/jOn81009bobZfSbdYqI+InuIwWC1++Vsq2GL52r4XO6gEW99lG2sJN5hmms
 Hmfwvg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19t8mbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:44:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e46b4b700so307507685a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792086272; x=1792691072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A6Q8Qr/lfjrYiNo9/X1UXJgtRJTid9RHJFQATXmTFZE=;
 b=MBYur6mMzD+twnJ4TK17QrP148wE9vDJwkUiym7uSoxS3KuqAQdOXm6lbRkNNJrzCr
 cSH3Lg+ZxnM8QQZyisRdraEziT17ENTYTQyY3z2Y3w9A6T3k+4lvgVDo93HGor9LAcvE
 5wyQK4B9Il+2eMGSAvYAAbLMWeI4k8XNOQHMGWcGlt3J89m/2jrGligk4cZ1w5no72yB
 dc8iNoqgb5lE4072PuSoY7S1iuBHtr4XcAwCo/aryBQHRcjY9d+exJVZINw0D44HRvBV
 iJzV+JOj4egvVCLkDSwbXXYBcjb/f+fgK6n1+eEsyTsTtwri7nI/GaNk/jpYDzV+lcf+
 ysow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792086272; x=1792691072;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A6Q8Qr/lfjrYiNo9/X1UXJgtRJTid9RHJFQATXmTFZE=;
 b=elarUNgFRZYMktHM9TcTozW9OndIf4+56Z8bHGeXmqd8UsgAB0A2eTgSW2S5duGi8l
 R6Z3ATV6sehlw3Ndngo6y56AsmquFa78tABmZ6QNj/e0/7nE+kJkCqZsKTvHugztujyi
 xIKaGPjb0FkDb2x7MGYOqSfh8pomwM9AHNLax4TptrHIK2Cehga4jUIo9Aczyu7LAsbd
 tfJsCWQpXBRjJmudLGWJTuvl+Fna6zqpFs4bpxqSMpjDgbzNX9ae/2UAWXM2D55k4Kw3
 6gJNrmXTbqAhE7Ukk8+D1qaHc+q6JOErxVoTJVEnTJDzjez1aY7gU2wLuCUNfcAOYVwZ
 6RiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtbDKeKuHRjdK08nSojq5PqxxZGFaXwMmpgsVVYYOcsVlax9TnT/+3fpuJ5NWhpOrpuQWBqAilN9RC@nongnu.org
X-Gm-Message-State: AFq9FYJtZlHIF0BkBgqgKndaOKl+z+TOPagBl0TsMVdYZsyFyzjd7+BN
 B2Y937I9/P3UbHSbmj/xjnxPt/J71y6IXfj6FsnqpbubB8a8bRiQz/i3qSYC6XTZxYF4i1Q3RfT
 CSinfSKUxIN/hNeu36ioSh6CAvAQr9es04j2xsK2koleQYXh17dV7/WdxA/uQDmxFsg2f
X-Gm-Gg: AYBFou1W4GnOIBb9QOEzVSQuQboxHl4S3lrHgJ9UV0ZaYNL0gVNPDMktygp6q2UkMRn
 SUsL86LOM2B4oSwsUUxJ5UWnPf/faaftCso7lt6uebA+vp9T44PaAgjzIjjEq6PHnYHMoba00Y2
 /1kk4OLEpzyNmXzVWk+Dk64Y1ftD6q5HrLH+FbmWqNE6KR80uZ04gdT16AsBfX6Ab+/gXCaRhDr
 hGe19zxngR1WR7RRZuFF8Q6gAPqvbbrvgl2WdRc5bM/JH2FtcIF5qTkGz6A754O+JOQFJeYQ7lF
 LTGmnPMW2U3qIxoWehM6BtKjc3ExYBnK35Y7CyH0uLvEzDoihBhTFCn5qxGLQ4uZOEegvWVzBqo
 u/kHTzaqVM//b/M3c7Z6KH4NDouJUCOkTgg==
X-Received: by 2002:a05:620a:2248:20b0:93e:c12c:9b77 with SMTP id
 af79cd13be357-93ec12c9f5fmr2235067285a.82.1792086271579; 
 Thu, 15 Oct 2026 10:44:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2248:20b0:93e:c12c:9b77 with SMTP id
 af79cd13be357-93ec12c9f5fmr2235064585a.82.1792086271130; 
 Thu, 15 Oct 2026 10:44:31 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5ac1093sm5109280f8f.44.2026.10.15.10.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:44:30 -0700 (PDT)
Message-ID: <39c7300d-4cda-4fae-a2c5-c80a774e6f27@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 19:44:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] target/hexagon: declare semihosting ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-9-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014210526.104215-9-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: G4vdBIMPh-smr6VI3v0rMZxkenywtXjs
X-Proofpoint-ORIG-GUID: G4vdBIMPh-smr6VI3v0rMZxkenywtXjs
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad11100 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=X6Q8Br3edyyEBAiNBCQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX2vP6FdFx7XWj
 5u5KMruxB2d/2kiXF72wcBxVVr4B8Zw5Q3yZdtnreJNiORtmrXsHEtJYijf7q26KVifS9vuwUyX
 W4mCzhsHSje26v7FvGprWOfCOBhfbiUqns7635vPHAAW0CLlOncmjaAt/leGE3f6Z06LnhuPOsh
 Yss3kTTuRINUco19vdXhiM4A3frGjFQm8Zx/rDko/I0DywjDPLA0cgBrcYp/WIa2wE2r3Vz7Gj2
 4yBgbxRGJE6o6ciZz2+yU+0TAjcT9YG8AFkjLYU68y5NbYifQ+QbxW9x1VxBIrkzGdXfxlmTlrO
 Dy9I2hUJ0gQ8dWDsc0U0TUGgxdyx3E8b8QjmXjRe7nwNYZ2HAF190lbrSYyhV2tGik7Q4G/Rexf
 loQo8SHB/5JLIaRWhbXYemAO7RQ4kNMLBFixPzHLTosn11D4K1zzHrnC64yXYXbyHqaxQG5e1HD
 apVuiUPtQ+nv6DIrzrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX1pZPQTOeUZcd
 DLF7HKuNsYesmhWxFOowiS6xI9YgvAQbzDmz/rU/tXw4ZvtuQ9ajEE3kwDB6YbRndmusmW7D9A3
 lgnSt9ROR7cDUJQOsQVHC5ZsjBbCYMk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150070
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

On 14/10/26 23:05, Pierrick Bouvier wrote:
> For now, we keep the global common_* symbols defined.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/hexagon/common-semi-target.c | 65 ++++++++++++++++++++++++-----
>   target/hexagon/cpu.c                |  2 +
>   target/hexagon/internal.h           |  2 +
>   3 files changed, 59 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

