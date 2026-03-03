Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FB3EB3649
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEhO-0005z6-7D; Mon, 02 Mar 2026 20:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxEhL-0005yi-TB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:37:19 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxEhK-0002e9-6O
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:37:19 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62317n8x3741797
 for <qemu-devel@nongnu.org>; Tue, 3 Mar 2026 01:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c9D7E3y17En/cMlTX+1iByWTtTNgukjCkOsjOOAFmYY=; b=UsWMtcNohPAYeoAv
 yJLZRhzjcCty2T2KyUuafmO82NhAOM1p81qPYomMUUDk2CqYld/OSzEUvFEn4ATA
 g7Ngi30RURaRHaeo4cnQPxNZyu9COz+C+UdcGvcfPJRvrjl3tJdcvCG0q16i7P0o
 XlgiTgkCFAS+SzMhReNKloRSwEz6HtWtJ3tNT64PlJNWVMBqbsgK7/IkXqc75Ery
 2wAi5KDyv00iWV/cxwfoqTjvhR7G3mYm4QpgCQd4gZfLDx3f79Xs4P6X9cc00p/X
 ILGs5J7R9ICPgq+i7geT0f7JoOwmliiHv0H3Y9KJHVDCpakBRVKp21wpLzx3LmPz
 Df8rOQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7trk1qc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:37:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be21f89332so299975eec.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772501835; x=1773106635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c9D7E3y17En/cMlTX+1iByWTtTNgukjCkOsjOOAFmYY=;
 b=Sd798ZLYuSAKnpa2dbJ44BNpZAYRL9KSRXoL4UAj4tjkb5eX6ATDq5SUl5JM3Ec5ke
 LBIN5Gkrl+F6GwTjqrFQjBuKHMwmpXMcr4N9HF7H7QyfK37x4GFmdPVSO38LHufOmCKp
 K/3TIH7ltyNOkhcM65G5aYS3SBGJXza+5uInk202hfdSPvyD3Rf2cLMn+2h/+XGG6+Fb
 xq3wTv4XF+KC4txnRM3KoNF3hldnlVDB2L3Vcirv73sqi7Mbh4c7gYOgOpQ1ey1RIujL
 9EL+0j6ZJuxcJEvGXehwxPXbW+JCYOOb6tZNLGnyfKxYi6wrc5yRAJIUq2TClXTF1+sY
 BRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772501835; x=1773106635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c9D7E3y17En/cMlTX+1iByWTtTNgukjCkOsjOOAFmYY=;
 b=s0XcnpfXoj4zzP8iyNNyZuEPZSAEdRGvgVx7weiOi0Wa8BNigDWVlORq5ipEunznUh
 OlZ3S2X6XF3daN5LmAl6yJAG7C8Og5hv/u9G2Lut3xIe5jDvN2AkoyO3JI9lafLJUiyA
 BSSAF53BIrV/Y4zI7VgW9gqoGsa+JKqayCdYq5f5+QVMTIY8NrReXuO2g6xAujo75lEP
 vJfM9fHgyrTUaBJ4Hv7YCsqR4ZW6VbObU5jgSx1MH6FdUH2e5ulGL1CZcrS5tCfQjqU7
 nT2oMn1qFPOcFZfuZViBN5zg9ugypQVEgSokk21y9kXmf1EsJI3NtEsNJ+t5NTQqHym7
 bI4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzqRSAbTDaM96B7YFDx0wDAWfg1gpO7Mjq1KTvcLR/MC1rp5kXFpZQpEeg0JwrM6z2lFRyTQE4fjqQ@nongnu.org
X-Gm-Message-State: AOJu0YwRyZvqgz/ZAjoOW6FXuPCbTJExuoywDpjlDNC2XYmFjJ1iWa/U
 Yj5HDYKmWG3W9yOX2arl2BrQ0cv8RYZAFn8Sq3wnN/RE1IBHEld5I2NY1FS+WwvNhf9PQvfe27C
 kFr5qowymQe1OcUKPCldfGfnH+l1gx/GP12cMm9zUUzRjVPXD/Nky8s2hRw==
X-Gm-Gg: ATEYQzyEJO3A2GvkxUtFZmUOCyGrx6xD4Sz7muHiZpVPhKJ3XqG+GZFvNlVCNouV048
 sQeEYlgqHaiwU5V0NFVYWWCqKUuz7NHxoafCYWcMInLvJ4Mdl62+bkYWBRUiCgSwZaOcOCPtWZX
 47D5WDG9SbHjEFIqY5iws2eKJZHMf2jEypUmw3scfK9UwmJ3OagLp0u2zftIdiYOq0M1k98pC2b
 Qfd6UkGPtOvTKETH+rsMOkPWHO0/deJHY9+LAiPi0omHdwQYXpGFxQbGHayhb85A6FkDNJPlxJf
 rw3B4v2vZMsiTTEC63FXOlBttITHdp9REk92fCdxxHDyUUY3fKfyy3qob43V2uQ+woGrDmvEz4c
 FungTViCJ6XXf73++fniV259wZInDmwkOJFjhWPqstpL1FR3Y299l7kdh41BgkcPi/CmAvnTO39
 FA
X-Received: by 2002:a05:7300:cb11:b0:2be:1f58:3297 with SMTP id
 5a478bee46e88-2be1f584194mr678195eec.30.1772501835335; 
 Mon, 02 Mar 2026 17:37:15 -0800 (PST)
X-Received: by 2002:a05:7300:cb11:b0:2be:1f58:3297 with SMTP id
 5a478bee46e88-2be1f584194mr678187eec.30.1772501834712; 
 Mon, 02 Mar 2026 17:37:14 -0800 (PST)
Received: from [10.110.0.81] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be0dcfbf08sm4767991eec.31.2026.03.02.17.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 17:37:14 -0800 (PST)
Message-ID: <9e00103b-af71-42d9-bc2b-30df6ccfe7cf@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 17:37:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/i3c/mock-i3c-target: Set num_sent in TX
 callback to fix trace reporting
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@kaod.org" <clg@kaod.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>
References: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
 <20260303013322.1297499-3-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260303013322.1297499-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDAwNSBTYWx0ZWRfX8nYM+eSiiWCD
 9f+i7di9IklB2P7Gg9TpcBbD1yV7+QdVwGroniBK24i14StkS9W42bswXHD7gKnYdoJQ5xUg1zH
 FGUsFa7LBu8VIhWe7gaGhvqKTfTkv9olO+1scQwtto/+3Nn6tMxmJasYoCU33SWYVO4N0NOrsOf
 V9aULT2ovw9MBHyF+miv0YncMhCa6WZBhv6CXDvyTQxG/CKCFvC8pPhxzds7/rNX7J1qhX7mmjn
 O3aM0HpRS7p5WoI9xlXvcGQ0rTob0dOY13oAT3LNGoiLQnHQALHNrWO4flcJ11XJS53NxZMjFXd
 Fd9ZwCzBxIKnigND6hUoS5F937kwTW0WjAfh2GmtMJpVz9qVJve5C+pR9dXFegH+CS7MzSy5+TM
 La7QYA6baY1oEjKlTGKqdB6z/5VW+cyExX0GfAEnePzxe0E0gt/JTSJR11s7tLeZzCOVAWvYQis
 CPcwFxcMj6LW6ivGQbw==
X-Authority-Analysis: v=2.4 cv=TNhIilla c=1 sm=1 tr=0 ts=69a63b4c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=eFj69PhkKSCQKAAO8LQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: urmW_qwm6rdyCyz7i2dICpRTmf3DJS1k
X-Proofpoint-GUID: urmW_qwm6rdyCyz7i2dICpRTmf3DJS1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030005
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/2/2026 5:33 PM, Jamin Lin wrote:
> mock_i3c_target_tx() did not update *num_sent before returning.
> 
> Although some callers may not directly use this value, i3c_send()
> passes num_sent to trace_i3c_send(). If the target TX callback does
> not initialize *num_sent, the trace output may report an incorrect
> or uninitialized value, leading to confusing debugging information.
> 
> For example, the following trace was observed:
> 
>   mock_i3c_target_tx I3C mock target write 0x12
>   i3c_send I3C send 0/1 bytes, ack=1    (expected 1/1 bytes)
> 
> This happens because *num_sent was never set by the TX callback.
> 
> Fix this by setting *num_sent in all return paths,
> including the IBI magic handling case, to accurately reflect
> the number of bytes consumed.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/i3c/mock-i3c-target.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c
> index 875cd7c7d0..b99709a08b 100644
> --- a/hw/i3c/mock-i3c-target.c
> +++ b/hw/i3c/mock-i3c-target.c
> @@ -70,6 +70,7 @@ static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
>  
>      if (s->cfg.ibi_magic && num_to_send == 1 && s->cfg.ibi_magic == *data) {
>          mock_i3c_target_ibi_timer_start(s);
> +        *num_sent = 1;
>          return 0;
>      }
>  
> @@ -86,6 +87,7 @@ static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
>          s->buf[s->p_buf] = data[i];
>          s->p_buf++;
>      }
> +    *num_sent = to_write;
>      return ret;
>  }
>  

Looks good to me, Thanks for the quick re-spin

Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>


Thanks
Jithu

