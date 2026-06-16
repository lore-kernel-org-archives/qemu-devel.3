Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252BCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZHvA-00075L-B5; Mon, 15 Jun 2026 20:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHv8-000757-Vk
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:44:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHv6-0007Ta-L9
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:44:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0OK1T2093948
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i2H71KIlSzvcTueBQJz2VeyMwuJYq5Vd0u8V8qGVmDU=; b=OQNIBa8eX3Tck9z8
 M2tgppBUvs0Td1H8NLQZMpDNr1YTcGo8qhzZQ197QMV4ogK7DZ8+GpnpCKJ1IkB/
 hC6YozurGfzLq4RFH5PxCkLQlnzb7nSVPovyYLeYlx342wEPBGW51bT/dX3IGWWy
 vt6GdXiCehiykWXp3My4zuRBCYAVb7rQ5f2QV6jK4NGJfh6LWbvFg0okaaBOnZD7
 z/jzxHAX+AjnuiNUT7onTSYED+/fbWV/9zl7Em9NYShDQII6uAlyhXsRaQlzsdGG
 mFgLldMqULu/MmC+GoPknOEeJ7OxQs9J7HK0sQo83Y0zJDb2im+NZVIdwg/+rA8t
 g9tYLQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter23wcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:44:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157d38ab37so400002385a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781570686; x=1782175486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i2H71KIlSzvcTueBQJz2VeyMwuJYq5Vd0u8V8qGVmDU=;
 b=KRZC9q6ciKOUYMtpXXZJ6l0ghDJyyalVPOxLAyaoDgb3r6aiiOK0vcfoYfM54+LyNj
 QJYmS7F3M0GiveK/qtF3tvi07SmKSjco+FvTNXnQHeyYnPNcdhbXUdjxs3Ig2u6Oa4Aq
 dka4Ryd6QrefKLFryvMX5Q9RYVB2rS/xIvhH0mhP1dZGlHs6OqVvAPXcDC2/6J10zQD+
 quzdOqfriQKcw3JtQx6JUeY8RjPZ3+8/15b0iPYB5K056crc6+tWd7wP1nZ1yMnJ71kf
 +2fwUt2bHacKC2A7chEzwYTj2k5VMMQWQj4va/VOd+sSTi0ZYrUaEtNGzNOsthv0pyvB
 FbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781570686; x=1782175486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i2H71KIlSzvcTueBQJz2VeyMwuJYq5Vd0u8V8qGVmDU=;
 b=ZyWsh4uWYUnPEPoug1icjh//oH3zopblVcRqJrhaXpI2bObuDBfTfRTl8wnh8md2Gp
 /5bEX//wXeDr9jOZLL++3UDvFTOX4/D52PJ0erJyK7sXj8U8kr0Kz8tvZ7PJ55eL5iTX
 HWsSShfx9G6fflwSuRJ1cdjgfHdgCMOjkJdeNtkWskDTpk1MUdneoS1u3X+e+9r06Cww
 NVBMfASwwIjk9c4Q7dmHRMgsTNYseClFkPOrHpKDFQaBWQA6R7F7zv4loqJebkZkyNEN
 3JwpmaKRKiDVLE62dlFQlhKE3CxNXejtf7ZR5HAjW5h4OfaVSOFryXcWgpV5uExsOiv0
 Gjrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LvPTGgEUhefQp8KXjJogYdQRGDsOnC/Fv0jRREvQOSxaX8pfI4fk4PL7+zjhMiRkK6/0TS9LAGS81@nongnu.org
X-Gm-Message-State: AOJu0Yw8S5FIxnC200EKtag2NnQkrueoD4D361VF1hFIE4tZ8bzvBCq0
 pq8GgTtrXwkTlyAmxg3EnBCor9xIECZLo0SrnjS/bz5fV79pm2Q9Vg5mJrJNevshQxj6YXAKHGT
 XL7hBQhrzsssDgwQQLpKY0fbicaypteHCELI5gmEDApFHG4aG6BkNhwrfew==
X-Gm-Gg: Acq92OFiAoXpVCvXCNNz9znuAHskvHoEZc7InuPLjxTuK0fhZLAvIlqHc3nGE0iHeb+
 jI8wol9qksc5hIpXkHqCjB0NDD5LVEzqFCNZCTeNL4WniDxM+A2nERVR2NX+4hIwmRVxp7R6p+L
 Op+Xv1+iKtGtJhOzIRUIfxbCLjQ4V7iNQZdlOqFFLp+0m4BmSPMqNvXklLZJ1dAodjQNrRCrCwi
 l7PLp4v5EggGXb3wUozatamLWHYsLCrnVlIY7M/BLnOVzS1vxRb22ApQSlelIeKnR2S+J+GYWIQ
 X+D+u0p+IimBdNPMs3cGhbsWzOV0U4rEpznd4uCG4+cCBjZnjmhVUE3aczo6nISjc7E5ySzwSkk
 kIFe9J9m2WsTT+/6nD51lJK6u53zMZdNon6yOeAhxOAeT9vH0L3k3hFMjETR1UBIV58KIWePE
X-Received: by 2002:a05:620a:1a28:b0:8ef:ca26:dcf8 with SMTP id
 af79cd13be357-91c422e18abmr258305185a.0.1781570686568; 
 Mon, 15 Jun 2026 17:44:46 -0700 (PDT)
X-Received: by 2002:a05:620a:1a28:b0:8ef:ca26:dcf8 with SMTP id
 af79cd13be357-91c422e18abmr258302485a.0.1781570686044; 
 Mon, 15 Jun 2026 17:44:46 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a8ebe3sm9303895e9.11.2026.06.15.17.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 17:44:45 -0700 (PDT)
Message-ID: <c445bbc8-5576-4118-a613-195788f966ff@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 02:44:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] igb: Refactor TX path to return processed byte
 count
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
 <20260615-igb-trl-v4-4-cf5739bf529f@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615-igb-trl-v4-4-cf5739bf529f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNCBTYWx0ZWRfXzLdGG+KkZO7N
 dmyxP2Cv/IjZFiL5+VtpiOQcfC6JFY47wn9ygwoKP7h1g0BnOyeeN/gGA3+I9MjD1K92j82NRJK
 F8dIXMqHh7NEYIKsn9a4pR0k8RGHgFs=
X-Proofpoint-GUID: RZ7XyJgUSHaNP7uAvXvjhBbeHq7Xf7Wn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNCBTYWx0ZWRfXxwO6KAD0hDty
 PF6YPUFp2Nq3QYKYD9g0Pj42b6Ki83BZSBwzostAkcZgizh5Eud05ExJhd2zWB7q87J0ROP66fC
 ALiiVdbmFVPOjfEeoo9ANqAJbLJwP3Wy4kRl4u280BEncHGUKrtIqrA5rLn6Lq/cwx0jEwBBTEm
 4MPkjBmpYPgjrpwh4xbGqB7ZXS9A9I3q8aaQjKPO4jvRwjmlSs+C8W04ThHqXUkcDC2mfN4qOdr
 rLiGpRIqFgl69lh5ROGx9SjRFPahTsind+vzGfO/ceoZpLJMvyV9GWlRXH1oDiqR22UGDp6rHUO
 wRvlaJc/QHrsQztYIHGlfbeCdtnx+CIORPrYssMJXY13u6N7Y92ouuT4RJwnTs1TM3vMV07HDb9
 t0xTyzDxJa3QqqJmZbJlGDJ+KlaGtNKRHaT23vV9uxXsEIEHOnteHg0uPTKyXaXD0YmfQlh86Zx
 fvWbscK5ZOSQOgvOlKw==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a309c7f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=3jr_9Eaof67Eon-Z6BgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: RZ7XyJgUSHaNP7uAvXvjhBbeHq7Xf7Wn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160004
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

On 16/6/26 00:18, Josh Hilke wrote:
> Modify igb_process_tx_desc to return the total size of the transmitted
> packet (in bytes) when processing the End of Packet (EOP) descriptor,
> and 0 otherwise. This allows the transmission loop to track how many
> bytes are being sent for rate-limiting calculations.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

