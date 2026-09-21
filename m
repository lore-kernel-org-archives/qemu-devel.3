Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF75C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eMI-0007VJ-SB; Mon, 21 Sep 2026 09:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eMB-0007Up-6z
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:46:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eM8-00047k-2p
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:46:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAeAen837792
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DOctR8bQ0dvpJy1dFyYDmPtWPKBSC6hbXQMzKh+dYxg=; b=d/Uq2P7EwJQGl3vB
 87OERGTOHF0fYw9hcrjr8vCnvfCMwVB19ZmTr9R0JQt+wm66P/VoVozheBdeCsnQ
 My88Cv8fk1HwhbsvSjPhGHaKHNfyLdm3F+1hNmdckr1Fd0KKXCr+t7Aa8s91785e
 YYnGXbfmUtjr6ZG8gm5EtbrfRXZxLqzjsUjXk4+LV38lNFPJwBXlsfUKRaiO6Zjb
 5jEqxBTJsXO0GHHYFyXhSVwcVVrxtiM4Evbzk6ZwUJ7SfUFxwJBAUQcHGMBQ0DBZ
 G5iNuTFJzNXbl8E2SlcwRBbm79Gm0Onlis92tndlOSjRnfEmNcqlf1nedk95B/RM
 Y556gw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5j3x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:46:50 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-78f4d6af128so919281137.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789998410; x=1790603210; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DOctR8bQ0dvpJy1dFyYDmPtWPKBSC6hbXQMzKh+dYxg=;
 b=NmlWy+l2H58VzaWxP3L8nQLc9SJ5W6oPpYFKGcvv8iB2DYxgm0WrCPhaYNf8ho4Tn+
 W8cR25CnJkzlbwmziKl7P8yKOrtxyFiMOBvhmUHzfZtUuBB6L4L5lLFbN8HnKE9HP5nI
 0uK8FjzVJfeyPsAzAjH0t9PKERUjXX/ouW7Z2ONJIXiKWCvvsWYc/O3IrLJbQSbFhGIT
 d/4yWb0JqkZ/nM5Qjugt+0d84zWB8J6kzFx8J12xtL4N4iSOBiKxra0VQ0XO3Bq5Wydd
 259coFf4iiVFIs8EREyiL7T79OSIlx+kv6LrCCRUr4FxK05z9xLI98F46oaW4eKwhPbZ
 sO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789998410; x=1790603210;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DOctR8bQ0dvpJy1dFyYDmPtWPKBSC6hbXQMzKh+dYxg=;
 b=mrslPPOsST2d0MHiOU9FeypFCrzc7BEHr7aIc8Ai1sLKJGkwsl7j9YJI5h4rRzS8vY
 TZrKzUgzfzBFVCcwVDCxj7ScsXduuNcoyxMhLb5lei/lySv1Hf7WKMzBIjeh/V6t8wjn
 BK+mrWSJjWPoUtSWxD1maTCVpVFriS5vaz0yfZuJK7u4dTC9Ejzhv9pMSKS6fsR+2cSJ
 32twhEM0swL2CB3v822+xNQOSpxGcQW6DA1zh2pUJxac2TDqT/0F9zBJGODVAgaQ13O9
 /qfbyjO6ZB6CnXLuphYbNpt76FUnhT32lNG4svO0ha+QBZ07Lv0o9AYKDO6nEqrwxRy2
 zfrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpa6TROih3kkex5Y0Luf3y7An4SK/kj93vs26l+6iT+qRwJ+3+hrs+Cs2itTJUItMQHDcsUEJn+Hrv@nongnu.org
X-Gm-Message-State: AFuF++nWzWhfIbt2VyGdZU08xd9Jf5UIK9zBjfq3l+ZmUXPGnIlq3Ev+
 h2fNCij4xn8O0ci+JiBOorCouZwVDZ8JKvlTQZ4/CK0vK13ZCCXK2SoqUiqZ5c/3y7BIlzGmMMp
 HKQD68P23BXT7ZxlpJ3Gt8xHSFcQ1U7HxAW+/rFUdJU2fPVDuN6B7t8rIog==
X-Gm-Gg: AYBFou3Hv7lWFU/H9dOFE16C7G8zxy0MlaYYAfcw6MbwGYKwPeKT5p+2rorxdVM2cFo
 kgM0Bggj4fpUelLkK5vRhXSkDjAvbV0tmRXnnj0aQTDWECBejDu/xLnPPUimeoXIgWsDu/zDqD8
 ta43zGBVax9Wytjb880WBgvP+xjNakVjv0T2X9RoxT2nn83mZegB7KISwB5+Wl8i8K8GwnTcDIC
 dlo+7tkG6KP/66lKK6qpNeVYvebtG9HaK9JgOxa6QAuPIPA/AiFD/y1Tp57V+axQkEWS+VYnxMp
 sk7y0/JLmDnr/mCdP8iAtbQkR5RwkKjeZg/4tYxpzxbho1rc4dGDrqh3BcuU2+rAaVXqQsnfmdX
 /vAIODNhY3IL8EuRxFe6b
X-Received: by 2002:a05:6102:5124:b0:7a7:19aa:f0d3 with SMTP id
 ada2fe7eead31-7a719aaf734mr2221124137.32.1789998409931; 
 Mon, 21 Sep 2026 06:46:49 -0700 (PDT)
X-Received: by 2002:a05:6102:5124:b0:7a7:19aa:f0d3 with SMTP id
 ada2fe7eead31-7a719aaf734mr2221070137.32.1789998409498; 
 Mon, 21 Sep 2026 06:46:49 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd115dcbsm228167975e9.15.2026.09.21.06.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 06:46:48 -0700 (PDT)
Message-ID: <d26280c2-c4f6-41fa-9b30-e4f41e9830bd@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] target/riscv: Move target_long.h inclusion away
 from cpu.h
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-6-f98c5a244636@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918-hw-riscv-cpu-int-v5-6-f98c5a244636@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab1354a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: q3najc7hl55rdyJJjvqfV9kezlrXTlLU
X-Proofpoint-ORIG-GUID: q3najc7hl55rdyJJjvqfV9kezlrXTlLU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwMCBTYWx0ZWRfXzMQYMd6t2/r/
 tGOhTrECUMcTJGvzt5zjG08ApNcrYTU6qi/hsMkLTxewlCSvkEFZUsQh+frUqEojTYWpiTCxgZm
 1vg2s6l6m7fm+NmbQkKh7UDDLpj5FKI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwMCBTYWx0ZWRfX6gBpDE1vu8Wh
 wc8fFfZcefjK0yZxY0KHX+nQH++zT4AVTPuisEpg0WzAdVG9lFI8FKnWiyAEdzWDFiD60Cl4Idw
 DcrN17p3UX6TU+vM9vHnCfivhlEXatMvVok9ScNT1SZQQ0SelAUKGUjs0FGuCVzH2lIGXU5/QOC
 cOlODse7wV+cHpRi0kLznitx4no+v0Ft8qRZcaxzobqu38IVVlrXrQ6ToeBMIR07ZUSdK46hDHo
 fTFXR5hHLYlVrpZqehJcHHmJia8AzUgz3/BTRgsSuvFVwakwhRweNIJDliMeYHgKDMzSK96YR+O
 k7LDkxj3ByBb1EFPS/DQwH4Tz7SVc90GUfE4eK2cKvSEM3AQIHF7jN1vroI1hdCW8kMKBL6WxoN
 JNSAra31A9cd/7Wu6l33yUCmqGeCaAah/8ENdlgBKK1CaWIOTR7t7iEuZosj55q1D3cMfO38fpS
 hBpDCdQpZe2YnZMRlag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2026-09-18 0:05, Anton Johansson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h         | 1 -
>   target/riscv/internals.h   | 1 +
>   target/riscv/tcg/pmu.h     | 1 +
>   target/riscv/kvm/kvm-cpu.c | 1 +
>   4 files changed, 3 insertions(+), 1 deletion(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

