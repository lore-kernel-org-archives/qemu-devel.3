Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB96C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x13Vv-0007LQ-VF; Mon, 31 Aug 2026 11:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x13Vu-0007LH-4j
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 11:01:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x13Vs-0007cu-D9
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 11:01:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VETQ1b3296597
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 15:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LZgDrl+788Db8abTtDLcsdIScUHTLzAuwTcRGTc6+z4=; b=bQRQEEoCt+tC9DDY
 iSSFJgbiNQ4+5pfgtnI46QwoIGXWXbtcnVg8e8n0hdfY1o0jzO2yQmmy3q4X9ON2
 3UlI2kyeH22kJtHak+ZyHUeZnGL2sE0apIJUXVNEwqDlh3Ah80Kl0QQoKOw81FjQ
 Ik9RTSApjdT9hy+qz5NLpYxpEeIFCsJl034lf/wt1nuYq1QkZk+lRRohKPSUyB1y
 1uYxxU7E9rJiEUToXl2zeUcVzBQvjOI9G66ZZ+pZ0SSODgKLFda63ZSTF1q2Y34y
 0VJ8orthBD8ViJbOFYm/g1LGpx5tXixLBI4WIgOTXaH0LwFYG30JoHz0VfP4ql/D
 Q394Vw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6ayhjbd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 15:01:29 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97bf8f3a38bso135657241.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788188489; x=1788793289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LZgDrl+788Db8abTtDLcsdIScUHTLzAuwTcRGTc6+z4=;
 b=VSbmsm6h4A70NO8KymkaANZa2+hNVyXpzDA1aoYqopdYW7vcawWp37q1UcgZrtNtuv
 CjzBS5/OT9iQuOx1WdGja2fPxiqg8Ts7o7WGkRrmS9KiFXBnch38hjVD4wdw+84PVd9C
 ZiRQ+NC1lGuSTlWZu0e0Nd94ok+8Nj8MqRvt62u8OI+CL4hqM7ZCOZ50eQvVfo+jOzTO
 Cj8VES4/iEro73fBRTQZAlBgW2hIMLpj68a2AP/GcpgldM9+q8RDjfAFOd0qE2GoJHQN
 O8Vc5E3iyZZbBGR0GYKKWFghQL3FOzVwFUMeR117CT+r9PkmsqzGa3ylGgTiG/v954vX
 lSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788188489; x=1788793289;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LZgDrl+788Db8abTtDLcsdIScUHTLzAuwTcRGTc6+z4=;
 b=frCiucCUKCOtaTdn+hh5jWvTSbQAPStnNa8rSK5bPJXxVfUqZYwY/nIDCvlMksy4YV
 Ap7iEcMgzHGcoair39r8yifQInGc4SxIGHOvuHMbUY4tBw4JYdHcKRAS476UHlu3ciKQ
 1uIpikYYcPcI44PTVpr9RBtvmzqPkyyrqTgDuoCtqX+f+waPmHc28KjloOX3Rm/UokOF
 7ZQzetCbc+58L3QWmran0dLvmLA6zoluU65uwXp4RmvEvd6W7/SISb8mmC44HmNY56aU
 Mmjml7Z1MgSsMgxq0NUwXjc8IHJuSU2jIwqoTKR4UPbqHMOyZGdV0XNY2tEsVGsymFbz
 ZxLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPCswr9yeif4tzEK1b1azXp8wkx9e6FDI6NPY0JmXCqodbqxy2C/RlzFNN0LnK65v17tgYZYclrlg4@nongnu.org
X-Gm-Message-State: AFuF++mFxK6SZsFeC4/8MPtTzpQ+fSFxk1aasDHBh0EGRsQdneiG4/Mr
 91LiofGrJRMOLzi6FYZvZpV3OLqvA7lxvsNNkISusMVYtgJec2xEee8qrvX7RNCSjA7Jh3SpJHA
 VUpz/xlL6aCR/l3qYErewIeMhMutMhaiS7MFTokVN/TG1ujdiH871XkpXIA==
X-Gm-Gg: AR+sD11rNUjvgC/35ec6LrkEpKDoJCU9Mg5AK8+utz8OD6FWf83Cu7uiVljGB69FGMH
 1156dvPZIsarPBhmw8vLjrg9WnUpoTVCDil7/W5VCNLnp0S4O4qp3bF1/cyCBYEz+K06pfJc9Na
 RL7+P0v+iyYCEKOEypL9zgtDK+IuEKdysMjL8PjQTrJ9p2lA2PcqHRrDO4oImrFgnnz9FE+ylwk
 ogaORj2Cshfn5AG4z9AymMR9y8zb6TUDgKqaXTRUM4VGdi/pAUgReN2cfLQVc9RPh5Jai4Uz0Pg
 Hd3wRkKkEcB8gpT5RDZGcsqH3NJyRS5dCa9GZ4O6vpS4nP49f2raIOhn/ZEz8DgTDIoGbAuwJCz
 E9CFaCllXzyNp/NcCCkD+3TFAt3rZ2JHO3A==
X-Received: by 2002:a05:6102:41a8:b0:785:c643:a415 with SMTP id
 ada2fe7eead31-789fc3b4a39mr481764137.12.1788188488886; 
 Mon, 31 Aug 2026 08:01:28 -0700 (PDT)
X-Received: by 2002:a05:6102:41a8:b0:785:c643:a415 with SMTP id
 ada2fe7eead31-789fc3b4a39mr481645137.12.1788188487001; 
 Mon, 31 Aug 2026 08:01:27 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm24140418f8f.25.2026.08.31.08.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 08:01:26 -0700 (PDT)
Message-ID: <1bfabaf0-b320-448c-abea-dc7d3778a5e1@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 17:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/47] target-info: add target_microblaze
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-42-pierrick.bouvier@oss.qualcomm.com>
 <044509bf-1976-4319-954b-438307e91a8a@oss.qualcomm.com>
In-Reply-To: <044509bf-1976-4319-954b-438307e91a8a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX1SnMvBpPZszn
 seIPjhwvsiRMIpo96ud+go0XVGWx9/vzqSkbPUDFI7uK1giaDA5hsLF7eeEa2mSySp0aoaywdEZ
 0n34aMhJGCGK7GziYy2bOgY0ivOr6hA=
X-Proofpoint-GUID: Y6fLBvr1xJBsYjSz9BzGRtLLmkZSdbYM
X-Authority-Analysis: v=2.4 cv=CYE4Irrl c=1 sm=1 tr=0 ts=6a959749 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tktyLbxy17x8PF_CT5wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: Y6fLBvr1xJBsYjSz9BzGRtLLmkZSdbYM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX7B/wPdLdExnq
 T3TlnQ/oDd4JKY6joIbAAxt1jClYvy/QmrYIpd8w5bJ1tqG59UYGoYDO/S3XGPnJmrS3nTravI0
 mnUTlc7z/Tu7WeXYiExG5DneBaUTJES1rmbyfJNWzRnt718Nhfbt0GgeITFUaqT6ldlsmePs6ZJ
 y8dKehrd+FQHL82wToGoTmDB/G2eL9Ct5tuw0Ub9Cd8gXtBUSp/a06Ars17FTu17kIFbcHM6fR/
 5hYNIdztaMlm+GECEkem16iTQgfxnlqQ/Spi8/tPR24tQlk0z6nn3ESNiwoegMqicoi5XjMHhhq
 CU6gH1CGRifjV+BLbxluPvghgNSPOMOnoGqrUgbBDAhKoBXHixmNim6XL/sY296VFrSkYQ26ApO
 XGswEyAf4BNCQ4W/X5+yPD8RhRJW/Gy3tB0667sruui8Bot+c+L4DWHiW4uBQ550LRttCJO9bnW
 +R5U/rBAPTOz8TaIjOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130
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

On 31/8/26 09:16, Philippe Mathieu-DaudÃ© wrote:
> On 29/8/26 00:58, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info.h | 7 +++++++
>>   target-info.c              | 6 ++++++
>>   2 files changed, 13 insertions(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

