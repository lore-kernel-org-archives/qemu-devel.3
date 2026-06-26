Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7943DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6E2-0003f1-2k; Fri, 26 Jun 2026 09:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wd6Cx-0003Hf-JG
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:03:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wd6Cu-0002VH-La
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:02:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QAcshf1069928
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 13:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 62QqorZf9k5bB1/qGoYocrY+3B4FU/2oGXwz4JUfF14=; b=j6yD4rqcc1qKxS/F
 t2bXxzY/PSWaJ14S3RBt75Gkp8iDLVEM1SdaBi9L+kycZF71HRBnE/xSjmwrb5Qk
 xVFCbf/lkbRUOlN/BJuuzTkU3vgQfJMvcZhTXoiP1A4rfKnM4QJuxtnqApmifDkd
 Tg5XTPeBS7/t1hsChJoxanrocx3pdcbOgkLdoJimnJJkmmFIjBxMTDuUan+uXQL1
 plNDe4zayzgh+UjmEGJbCE17kSiBMHg5aJ8eMBeFGtZy5muYXMaA6PTdOnwUnZ1f
 L9PLcuPwJaDfKoTAhYyMlDljNkZ6JMvOyCUhCIVoxSsROBvKN2/zN2jC47hwyo3X
 lgHtjQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fctafq0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 13:02:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so1176301a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782478971; x=1783083771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=62QqorZf9k5bB1/qGoYocrY+3B4FU/2oGXwz4JUfF14=;
 b=gfrUk2+eaB82tAyhNn8x9qm/naVV5bcgtFXlUPJT766Rmq5hOo+mBMe3tkFrgIpw86
 zUmWQmu4nXvP+1sM4oqWpo65zligOMYfJaIZYV2ujFxYtF28rchbbDvn5m+D0WU2Xsx2
 ZJGJFB9XhC/4EYWDszUWox9D/EB29wKlgZ704o8PYd1VNebYvhibFDVtV1OJ0SkMtVg5
 6ngbuHklALdrh+fDknjbi8XWaOMSmlBwua+vTpVtcEL+oLvR0L9Ao2NRvvU1yjdVoSJy
 MSLJHEVOvkYOytVzXh96kQdGH/Hsi+tK06UTOQMyqnLYj9tIEiYzWBWYEmq52HFJGZ7C
 afSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478971; x=1783083771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=62QqorZf9k5bB1/qGoYocrY+3B4FU/2oGXwz4JUfF14=;
 b=h+/ScTiXOOSi8x4pDJ3S9M7UHfkaKc7kjJUtPrhdshU4Kb3D1CYoBF08KQzx1L2yJk
 /Tm/Mx/bMRdKgCdUVICiqPQXJVEwVK/WKscvYMDQIid7DINX3Vk1kvOxLI2d7ap8UZzn
 UkXKQ9D+mOD7rTI7d08NGkoS2OzMqjlgs7o6LFOpQaVO0c7852jq1nmz6WLXya8OegpQ
 Vy7eke3QhR/f6k1YaQy3+31RbMmKNE0cJ2rE6DCA0kaOYdvU0+bgenvsuIjNHCkSGfw5
 EltRZE47yYt+REDi5IpD0YsbOaVdEOZGSQk1Z5g1xl6Oh1oPGUsuLCXr/LH0zzoMSFdp
 iRxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dEfiyIpKQV9PtMPSh8T0OdcVlAANLX3gP5pGeYacjXNpuoE8jnvNMDjSMAL+gwCwNDc0Yuj0ea1DH@nongnu.org
X-Gm-Message-State: AOJu0Yxvi+Fsc8aq9JltTY8E+ZofzF9temxW9dQoaF3zKqBtRC5y8FJ0
 W7Nn/c2LzmPF/8lKJhmMYPIq+eeCXETO7XjPLRzXPWdKH7/2Ej4LwcgOlBib8ajGrgXCbyRn5ZB
 9aMaZqlPCxEuFS5PJP+OQ7WZs/u/HLrFkPA/8CFS71qHq8VcxDKAQL/tndg==
X-Gm-Gg: AfdE7cmbN7O6ILK2LuOOpsQ0qT8Ztt1DvK3qBAsBc2xF6+oAsqFqbZkQJUbPOMDOgbm
 DXY+r+MMIQjziawCZ0iGEv/HA4IDa0N6ZSyFosTIXkeqgnZHBPHROGsD5WWihkHZVcYNr2NILIG
 hNJZsrArkvLhPshYC/P9wH41Bpn693bpuU/206ZHHgmCATefWHyzq+YMaxG6UCGk/tRXi7SXLd+
 Gaan+YmHg6uFY5lGuh7Ys/gEauBANCOMLxBMB3KaaIUqXniywUB3Vm4cnsKKv+bkB4902FeEnyL
 hCLwQnP3rJCBmVBhm/9xj7KK6CiblSMlPFT+SnyQT2AKKpY90+A9Q75n0JWL5pr+5p/kF0PjRX1
 B/PzeqdI24XJ507yX3TeZ+UFIGcZ0hbKrcIBKrbwRBGn6BWDGR84zuIjE5/PLHw==
X-Received: by 2002:a05:6a21:3d87:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3bf5b7b0530mr1809764637.0.1782478970542; 
 Fri, 26 Jun 2026 06:02:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:3d87:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3bf5b7b0530mr1809346637.0.1782478965822; 
 Fri, 26 Jun 2026 06:02:45 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269009163sm86111485e9.11.2026.06.26.06.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 06:02:44 -0700 (PDT)
Message-ID: <ae7712ad-450a-43d5-982b-07e26bf675c5@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 15:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] json-streamer: reuse parser
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20260626101727.1727389-1-pbonzini@redhat.com>
 <20260626101727.1727389-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260626101727.1727389-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IWE4lSwZOXj4-rFNr1yJBEhJmFE04lA6
X-Proofpoint-ORIG-GUID: IWE4lSwZOXj4-rFNr1yJBEhJmFE04lA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEwNiBTYWx0ZWRfXw9fPAOxvMVoD
 CN9FHRM5gk+343TxpMkAO3z5q2rM3K72/sgBWld0JKli/aWzT12P0uHQV/UUz3IHGQ0KwnvTYCg
 EaNNzLDXbXU1qJ26gBhCgEUI2AOYFsJvXekzyqFHkQUHeozAXw0MfkFIJl/XSvZH2E0dytLLaGA
 PU9/5IEfR2C8wohcsnaJF4Nn8Dj+iyw17r6nFDDdyNJnRMgbCU2CPYsa6bJb/zAISguFNSO9uPE
 YFMRgogmkerIFrsUHS2+ptXkCCSwvh201NIhpSYLhkglyda/Y7hnaz6UnfDjsNWPz/5vW9MHRY3
 OYSFC301PKheLqPSfTr5/CsSGA9SAQHiAx7Gj+7fp398/R6/lgos80RFTshbezmi91o3RwXeM26
 Cnw95LsvVk/l0eMyxDw3MydKCdmoaM451XZyZ/8aFgg5BH5x6F1DVoBujRhsl8odQbFVbgSivKc
 9Dd+PtorkATj6Cph9kA==
X-Authority-Analysis: v=2.4 cv=FPkrAeos c=1 sm=1 tr=0 ts=6a3e787c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEwNiBTYWx0ZWRfX9txw795dc933
 cE32dqwI8R+WaMsiRr93KKq40Mee3nncJQtoNNTc5gq4lydFO6ZqScFrYZauku/6GTt4P5G8SMO
 LGE3j/EwJpY8uIeq2hBUJmC1ugtjfs4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260106
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

On 26/6/26 12:17, Paolo Bonzini wrote:
> The push parser can be reset, so reuse it when the json-streamer
> detects a completed toplevel object.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qobject/json-parser.h |  2 +-
>   qobject/json-streamer.c       | 11 ++++-------
>   2 files changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

