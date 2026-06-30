Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD58C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZMB-0006kC-W4; Tue, 30 Jun 2026 10:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weZMA-0006k3-F9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:22:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weZM8-0006TR-J4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:22:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEDD2H2213505
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 14:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r82B7kdGtgmJkzg9AZKk8BwpTG49cZuth6pj0JTPkUU=; b=mQvEvB5j8eX5Xjx6
 1AzLcblacBxlvCs0F6Ku5TtuURdc6/jbyrzK6R6KR57SJGxJ+Ycl0swPmPpYS4RC
 NH99exv61zxvqJbLLThBs07Bx4JMGZfDjPG09TN8Hnkp5Q9tgZWSkRKLBUDqau9/
 rxEuw03ZFWFvBrzGQAK337iogv3x1ZBzjaGWtCou2KUHyGEoUXDA9OAjNHOJNrvd
 e2lMOdYB8l2VNH4jJCKdGZcOt9QpiEhUotIlGcvfwBP1nQsOTx1oACY9WV+hXVvO
 X3UxqeTTEpzMlup12KfjQ5GYqohP4pswvQl/EacUvXs+wnHfh1jbBLZFwZPwDDu6
 PsBVJw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fjp08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 14:22:30 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-737f663b020so1546408137.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782829349; x=1783434149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r82B7kdGtgmJkzg9AZKk8BwpTG49cZuth6pj0JTPkUU=;
 b=MFplY2FA7neUzzFm87Kl2iau6pSj8SxkXtngEGZBeEtO3kmUEW4whahkM9bguJrHEm
 xgWp85OemHJMnZpuViGpm/1V2bEZNN7NEr1lO8yzC1yz0BaEtPiSBPEeMzTjH1pg2AXp
 2XBf7Btga/haHH/ur5mMldK09E9QhlMXfBZxBVQgYjIoAJArv2os4GkK3kDgNCoyY1ci
 r21G/fN/h/5yCPUdBVnP9I46Of/w81tE3r0SckE7dZlgYVV3nyusHa+A41hEYKREhsSi
 E/9bx6pw3qUTcqnGtV3tWF6XnZkiOiBc0kKqobdjpbYFPIivAeiZvNfDyxhLt+4EvcVH
 STdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782829349; x=1783434149;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r82B7kdGtgmJkzg9AZKk8BwpTG49cZuth6pj0JTPkUU=;
 b=sDjndF5ZKoHkE8z+RF2vB3Qq/mRA1FpcSTMxKodmulYoTHEd5XEmJfTA/HBQ/Oxi6F
 e8BblGMci7wxOWGjgoZieT+irMvNebsBsbI+6PgrUK4wyJmlfUktsawea8AGJ7H4MSqv
 zKHzwWnYi9vxttYec8mBUhYjUONnuAQO/gQKWu9Zr92TjODetKuiLi+7PGEDi+HZkcmu
 l/rycFzCM0nSaHcWAvypolzVn1I1WyqAxdWHljTf1VOZ3x/ItuyZHp+Ev4afOq47I7fO
 NXBhR2+C4rx72LDTL8djl2aDh1EXWyDHDUaah0XROhD2suM5AbzCKv+lai2mlB3RqkY6
 wIYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsHAYxwvkroROBcnogySSwS4dw8iU8mVi0cSAuiiNsbx6SMzP0AkO5o1FmfBXUbLHbj6Vj/K9Pvk6i@nongnu.org
X-Gm-Message-State: AOJu0Ywx48BPQq4dEV9fpVoBOjLvm4HQPERZYOrHLqDjJHuQBXA/096a
 wHzdDqyT9uL1lrfg77oK0Ue1iw/2NdqqAYIbFQ3CfyVFQsBDqCXRdTH49yc1/UE3CWB6mJZw1op
 +rHii78+ssA3yihzjelyCR35A0hQCtHweQUnYwy7FxT5V8BpuPQeVhi6YpL2WYvaVRA==
X-Gm-Gg: AfdE7clzDgZN1Gq6AoIB2TxwAn4fWl7kfARmLJQgQncgFg2Rr8EKloTFni7Z4mlz6Qg
 kTD24wBJzHn5e7gfXKz7MRvHe5BNoKAKLfUK5UEnhxPR9LNL2N+LCfnT6TvT/t6gIrJaFG/NgvJ
 pvfgm7GW+TvEoQFqH9OETD3UpmoGAEi2fABo7u0YJbyADECJsyKQKwG+oms4K6N6YUWmDKf4Wla
 C/t4dCmU7qAG4Fw2fqFMkxs+alYKES+iKVX6Rraobaw6+gOpa8advoL5vTUsSCn4GH8e+qn5zmw
 N0korzMnqIkEei66wNiS4vAEVyoPwOXsX37UL7Ik0M/s35pDBBj6mTdXkNM99rlsTM8566j1sm/
 61LyF1nyML6FXLaSkoGD0nZvEOSf5jOZ3dGjoJJiuaoORew881hUXoaHpbsIwSQ==
X-Received: by 2002:a05:6102:8022:b0:738:be73:55e9 with SMTP id
 ada2fe7eead31-73cb894e386mr312970137.12.1782829349258; 
 Tue, 30 Jun 2026 07:22:29 -0700 (PDT)
X-Received: by 2002:a05:6102:8022:b0:738:be73:55e9 with SMTP id
 ada2fe7eead31-73cb894e386mr312960137.12.1782829348834; 
 Tue, 30 Jun 2026 07:22:28 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47560effc81sm8305952f8f.0.2026.06.30.07.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 07:22:27 -0700 (PDT)
Message-ID: <9b5b0e92-4d07-422d-b8d9-247781afd0a8@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 16:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/mptsas: Reset doorbell state on reset
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20260629185035.2138238-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629185035.2138238-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfXzBEqBYqdXv+6
 +F+3TiJul085IhrFcRVJlSmBYUNKOLxFmGWm7LQUf0l0RIAcR+EQMXFJ0PS3hU4W4L+0E5+JGUR
 lly4/jFSJ7ThzapmJuibrFKFeLyoSHyKC6rqmrlLV7GpR0gXv4BmGRC/OXslOOgevybNyFObQDp
 a8WEXvP6rkdUhAGOuf/Pm0KM7m0OHKkKwAfRmXH4OEWJMcKH4bONtddD0yn5x9Xso3H2/HN0ohy
 5onw757TfXO6kLGVgmIRg9PubQdO/JLNCmtCHvz/A18Aozwqcd53lKSEn68YLJV6ZaWfyaE/Syp
 1+nBtGnGzkub3ruUE7ljaLnVPIeleDCsN4gMe4OBKNA/n02ZnLBydo6Ndb9EWaJh+KQG5C+c03S
 yQd3vpYyarZAtxC1XciULwIT1JfEBSHKcuSv9zJvaurnQgDE5j25eSEIlajoeEmbQMKaTLe2BQE
 ZMFlNkNewlAzKUuIiBg==
X-Proofpoint-ORIG-GUID: rExsaElpe4rht3cQevdhAfklRkSzyVrN
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a43d126 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=BxYp5kjD7oKxsPU3rKwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: rExsaElpe4rht3cQevdhAfklRkSzyVrN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfX16nGBqVeRVM1
 WFbewCqNapBKRQaTBhMV2a/QxKD67Ud4QPnfTJxewGi0JMOCkiM4DwHEzqqisQp6F7tTmE8xxM4
 ZoYAAvct8K4b81LCg3pdtoW2ZlblOq0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300133
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

On 29/6/26 20:50, Peter Maydell wrote:
> Currently the mptsas reset function clears intr_status, but it
> doesn't reset the doorbell state machine.  This means that the state
> machine and the interrupt state get out of sync, and the guest can
> trigger an assertion failure in mptsas_doorbell_read() where
> s->doorbell_state is still DOORBELL_READ but s->intr_status does not
> have MPI_HIS_DOORBELL_INTERRUPT set.
> 
> Fix this by having reset also reset the doorbell state.  Strictly
> speaking we don't need to also clear doorbell_reply_idx and
> doorbell_reply_size, because those are only read when in
> DOORBELL_READ state, and the code always sets them up before
> transitioning into that state.  But it's less confusing to clear them
> out on reset.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/304
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Disclaimer: this fixes the fuzzer repro case, and I have
> run "make check" and "make check-functional", but I'm pretty
> sure neither of those actually exercises the mptsas device...
> ---
>   hw/scsi/mptsas.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

