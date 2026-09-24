Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7911DC98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 04:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9bPS-0000b3-0Y; Thu, 24 Sep 2026 00:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bPQ-0000aN-PX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 00:50:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9bPP-0007bt-1i
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 00:50:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O36f30953477
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XH1MckLYOHcs6kD8Zp13IzPpP+1VjEah9U1ju9Ea1os=; b=dKCfXoMURU0wh9B5
 TEy1F1cA+Px2JPFVvhUEszwuLBGq+8lq3vhE6j5Eia19YnyNs6Lq3fNXl76xeBxk
 0EURBuvyEPybn47wXya0WgjCfgyRkidCwu0q8r7arPkTundfdQtPdBIMlHnUJ64I
 toAnlhhuh+h4KK/1g8j+xZvo+CIwKH6+wiR9V0wCWZHcBtBcKfzZTDrGZtGLdt+u
 nFiV8l8qnLImh2JUXXWKau0IGV0jNKRu9A46tbRtjSCkg1hg4Vpl0gSrvaR7oHmo
 lQk3gq19miQmirFHHgPd5N/wKBmWif93p+d2fDdJ0bfcGudJps6gkpCcUpGlXEIW
 6JLHAA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb2nbh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:50:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa34873bso284873385a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 21:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790225409; x=1790830209; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XH1MckLYOHcs6kD8Zp13IzPpP+1VjEah9U1ju9Ea1os=;
 b=J14PbGQaL/mRYZdinUiDrwNcD8DJfYhnAEg5Chz5hUX9yt5fEpguUwKCa/4Yfr959B
 APU1yi4rMRFh0pPZhelviAwDibNOZGBaRGzDhqapKtfVG9QxEZreNpQHMMkB1cb+9BZf
 s9ab+cGHkj3NHXHfnQNktg019bZ7+iIHMHU/SwT7IgTJiubcbUVGjXVtbHyaMAd9hPzT
 USPRFoHpJYlir+9BvonZmO7gTmE0w9KqON4Q5jD0C8xuIMYSRHLcS0X0lB9tHkJDmkrb
 QO7Zo8y2O5uqkyFz+N8FbPPExXB9P5z49Mz1ubasF8uThG4X3SLXEs0LgQqlu/vsCNqd
 obNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790225409; x=1790830209;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XH1MckLYOHcs6kD8Zp13IzPpP+1VjEah9U1ju9Ea1os=;
 b=u1srohBmE4S/9vddJqrX81h8jtb+8xfT+JxFByUaos/MNR5tUBPXksjErJMq/JBj74
 2BQW4l6FsE2KLNI4xGF4Wn8WrnZX81o7KTW8O5ls+KG92Cx8SLQboTpAtdMKXubYLP+K
 TTjL+zTE7oKNewWSwp7Wv9S3553jlpb3VO7TlkHmvLeTPUmgSOn28vGw1J0tL18tBX37
 Zc3UBUZkgeZX9lvLUwDkPiSNOlKMALMWTp+iOuNBcaDZV3mcGYYHGRJr/lz7v3JP74bs
 5kT/7An7uXoY7IdRM99btzwKhS5Wut+vw+buCOVecMnjYTrqBirEToIGllKR+GtTnA44
 I3JA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWXVC5fjD1aygmiQiM5MqjMA7D8y+M8B2Cz7I+5aIYq4EUPPRjLlOGdDbb8C/2fM93wmPCEzusliG+@nongnu.org
X-Gm-Message-State: AFuF++n46018Wl+lKdwhsGT96kgNcenD8574VW7LrHT41JAGktIl0Y7C
 fV4K62L8ApRxlmklbzsA/mXJif/PpDxhHJQgba9flx/chAuBWQjmgbtlSuD6VuaTM3oYzVbfpC3
 DM+9j6JYCDtoMzISLDzUFAQJQAA1KyAqWOFQ8vMXVCtsqDDQPA4s36IQvDQ==
X-Gm-Gg: AYBFou2DKVm9vib1RPcu/xOGQFdgMpI8UXXh25P66ClIWaV/bePDbS8nGrJ+ACrmD77
 4fH/7ZtwuvWm4rNQtjFw1rgHmQKLbhxKhtLBdVy5w4qzOAJazsYDEHyt+IpuAsyBJwPzAXTXrKY
 Qn53Mln04IZ9rTBRlN3FqtXNtz68ncLmqqAVYiS3TPwXhxGjA9ruudSUFrK3QgHX5NZJo7F1sIL
 w1KESNPOeCOBdLhM03HzVkCD4AcJYGZ50yRfIaaNpa1TdGnBt8Z9e2bT8gsUqYrY8T1DiQ3vs2k
 MSHtl81BV7R/j7m0TpGAcCJ3rAaR1slb8CxdnAU+vaMRzbyX6OEHV3o5cn/rpNkIPaPFKdIBE6f
 fTO6NfUvyUy/k9zPz4WeqvGBTUhdeQidm4A==
X-Received: by 2002:a05:620a:4084:b0:93b:d7a2:83c6 with SMTP id
 af79cd13be357-93c363fd8e6mr123039685a.53.1790225408556; 
 Wed, 23 Sep 2026 21:50:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4084:b0:93b:d7a2:83c6 with SMTP id
 af79cd13be357-93c363fd8e6mr123037185a.53.1790225408060; 
 Wed, 23 Sep 2026 21:50:08 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5dff204sm58241895e9.14.2026.09.23.21.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 21:50:07 -0700 (PDT)
Message-ID: <1363e225-e3a4-4ee3-bffd-6f46265d75d2@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 06:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/19] hw/net/bcm2838_genet: fix TX ring activation
 check
Content-Language: en-US
To: Marcelo Manzo <marcelomanzo@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
 <20260811143557.7862-18-marcelomanzo@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811143557.7862-18-marcelomanzo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8cBC1keyTdjyiSfezchQ8Tqkr0zUIjAJ
X-Proofpoint-ORIG-GUID: 8cBC1keyTdjyiSfezchQ8Tqkr0zUIjAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMSBTYWx0ZWRfX1EMh/cmbyRzX
 VSfBqg1CS/J7mftCcsX6jqs46RvvNHzlbhHaSwLPeXi5yUvfejbzvMxwMHbpo2DC1hOmNl4690c
 9dQjLS69TKggaqwYoUefy24B3wIqg9xSnwc+R1861BJ9r5rAlou4rXDeRy2XsAlxtZs5XsZpTlt
 pttI0BqossCuYtWcb1I03TqmPdndnn6fQoT60LV+E94YCQVo0h2vdYjD8mYjyX+/nRlgGAzfk3V
 scYBjCwqC+oqfols73NhnPSIleiDop/5n+LaR5ALMc04NqTF/Tw/AdmdwM3QiYIkjskNn3Shexj
 DY5Mhyop1dCHC/7cb0wljBpY74Tpi3htFa6skDheLfRHUVReqKaALrYYjzwEG7pZgzDUFtUdzlf
 LknxdUpr+qLwdt3c6yXlhRwYe+wT7tc7hak4B/RUofgFS8wH3qr9GiyhrWjl624fitEx2qZM7fe
 DoyC0pDEISy5vVEQ1/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMSBTYWx0ZWRfXyOz/nLOgRitN
 VfC2GNhXSl6aIhgDvgoUhe+o/qusygqew4v7jGbk94KjsFYYiHFmC4Nzo8Ifqyeix8kqIJQR8ku
 q8cSZ60PKvuh+WZNd81gsJlgdU6Gevo=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab4ac01 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=iquIOom5MBXtIeGK7K4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240021
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

On 11/8/26 16:35, Marcelo Manzo wrote:
> bcm2838_genet_tdma_ring_active() extracted the per-ring enable bit
> from ring_cfg_reg using the GENET_DMA_CTRL register's EN field
> definition (1 bit wide, at bit 0) instead of GENET_DMA_RING_CFG's
> own EN field (17 bits wide, one bit per ring). Since a 1-bit
> extraction at bit 0 only ever reflects ring 0's enable bit, every
> other ring (1-15, and the default ring 16) was silently treated as
> inactive regardless of whether the driver had actually enabled it.
> TX traffic hashed onto those queues was dropped with no error,
> eventually tripping the guest's qdisc watchdog ("NETDEV WATCHDOG:
> transmit queue N timed out") and causing intermittent DHCP failure /
> link-local address fallback.
> 
> bcm2838_genet_rdma_ring_active(), the RX equivalent, already used
> the correct field, confirming this was a copy-paste error isolated
> to the TX path.
> 
> Confirmed fixed across repeated boots: real DHCP lease every time,
> 0% ping loss, no more checksum or watchdog messages in dmesg.
> 
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>   hw/net/bcm2838_genet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

