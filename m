Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C73C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ9R-00010n-Eh; Fri, 10 Jul 2026 17:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ9Q-0000vD-Jg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:52:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ9N-0006HZ-OX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:52:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3GYO1841662
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zX/ccb5htWrlRrb+eLS7rdEZ4xEiJqyH++YKHuqmqJU=; b=hFiXrz3bcAGvnQEO
 vioOWSDebk3pbYmN6tjEOy+T469L8735ei1NG5V6BhCJvh/FucLKEexwf3yGeo2Y
 BZI35FqgHRlDxOMmF1X1hBRk0NGHqBqE1zpVttJsvpbelTbyLu7Lii9FMAQr+6CM
 UJ8I2Q6t+1APr0I8k40CMyhKYHiuabNhBuPovslHYFocQuUWalpU99sJrR2AsbGn
 zTzHTbhwSJ1L7bbEivbhTpC5WvG7r7+OxnVbKS9qCenomSwG0k9GeP1PeKwk3M5F
 gp09o7LqRiBoIqeGs7H/AcsReGbmD2gaUJJbN1qt9jkXCDhUcqG7SXJW3h0r9WAe
 PJHuXA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xn13pp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:52:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1852a86fso15213051cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720367; x=1784325167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zX/ccb5htWrlRrb+eLS7rdEZ4xEiJqyH++YKHuqmqJU=;
 b=G4pDspgIUi7f5XYLYO9cUfGyVhXeMrGsZnt2s3fub+aggu9Egi2HQ/XqhyHWTqmE0+
 uvEOGgSr4iaXT3hIrDsHIuW69Y6PuyrP/CnllBJi7h+BJNsCooUp3W+LBTF4epKtM5Vh
 lyx+s0wcrz6kCO5Cdr13uXdL+r0k6e4RjEfTeuZKVEFm/dap9x2Kd/v9WXUbzxufWHHc
 VkZ19ModLV/o/WYUxYsY/4mroQ/ViBp0pJXZaq8rfxv1rslWsu3b9+7n/jt8ZNMwHcLa
 qj3VFPftHB7u4qSODWhradKNAwmnp+Zab4Onv7inPcfo/B94ZgfAoy3GG60UdeuUFKCP
 vxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720367; x=1784325167;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zX/ccb5htWrlRrb+eLS7rdEZ4xEiJqyH++YKHuqmqJU=;
 b=PUPFzM9PmuzvXI7lGscAJEV2YNSCY3zL1EQJ7WB+NWxm900t+S+eK9pZ+1NjlCRH4x
 TkafNmnmQ5ObVcCENFJ0ILqpnkXaE65kHQ5++TdFDKzhM5v1hyFJKRFLN2T0pzI+Txj+
 VRHXSYzJ9tee2UcA5RIfRh/Rt+3DpGike9VBW8MnCbReiPmW26iSO3gZgLQM8Jkav8uy
 aTatpOGrUsch6nM33dVpRl2ePGYTYCc103GNtaAC1DuMut1v5RsA68OyOcvYZroq/nvf
 VPxjWwogXA83U5+UFESfaxVm5Na1n9vi4kuTC5ypE4dpAZpwIP/qlxvmehz7zSlr4vAb
 MH9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqut3GgX2xLBaLo5NHLenACcIpEBf6s4cM2dlIYPND5iH/edKaqbr8Ucsndr8RiRTGzQICIZslunx67@nongnu.org
X-Gm-Message-State: AOJu0YyufYjvvadXQBAA3ZmfS0I+OUF4eH7GGnU8kWbmGD3dfon4UL6Q
 4yl6NbzDVSba9kMkJcsEi1sDoD4bOB4OB8sSWqqcT92hZfu9L46EgddDWkl1INpBLz35dhTAwkt
 UkDZy5GBCAHG0Y0lo7StK2SBk7D/QdFPI8kkPlaffB4FHaEMuqnjhH9Qomw==
X-Gm-Gg: AfdE7cl3nuYtQpY2YEZ9MAQsNmZYeAQgno/Zo4A11F4RHho1MkM/3JdmNWwJKVr4xx6
 uUY0ahDxwAfJsLowWozI8uDCts3z00GKKtSmGWZNj108JPR8KxGQFXbf1y+IHd/9260fY7w0Nzb
 l87eT+g5nBOHxzCv78ximrorKDH0FDZZvG7bqMOS46StODDOcUSqaFvLBAJciRSjDBVw9eUorEp
 AYbDMHknlBIdYn33BQ0bDujuQzODOPN/jk4VGg9ncy4s44atkVGgx4iWkd7eeeM2G4qOk1OS9yr
 ohdlvljuGWp3aHxU96dR0XZsd6tEj6Ovcd1jH15mGybuq11DpCBh3L4eP5Bgt6nSMQloMdPCK9V
 obUaIcRgU7KOkN/o33c8zExMdLU/SoIzCnuI2c40ksrdBttreOpTa+xEfhonZrg==
X-Received: by 2002:ac8:7f8c:0:b0:51c:135a:5b49 with SMTP id
 d75a77b69052e-51cbf0468ccmr8560541cf.4.1783720367258; 
 Fri, 10 Jul 2026 14:52:47 -0700 (PDT)
X-Received: by 2002:ac8:7f8c:0:b0:51c:135a:5b49 with SMTP id
 d75a77b69052e-51cbf0468ccmr8560311cf.4.1783720366798; 
 Fri, 10 Jul 2026 14:52:46 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ccaf1sm293795655e9.2.2026.07.10.14.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:52:45 -0700 (PDT)
Message-ID: <29a22377-5e83-41eb-a327-97c4c84002b9@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/51] gdbstub: Report actual watchpoint trigger address
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JJYLdcKb c=1 sm=1 tr=0 ts=6a5169b0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ge5hdUQLQkj_eIuYbJEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7KTDyLOWo6h5B2HPP7nbLbvU2FFoH87N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX77OAszlZqY1m
 HGDtmdyXVvi1CAkRr6tba0HBMoKiHI7aOYWgDLpH2y+w8V1+dNNjvDF+8xyaxze0lEectt/o9TU
 0hyiL7M+32bsO+hjcHrp3iCiTL4wtxU=
X-Proofpoint-GUID: 7KTDyLOWo6h5B2HPP7nbLbvU2FFoH87N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXytDIaU9IXYJ5
 EDS2qXG/MhV4hDJ36sHvD2KD1iFF2IMxp674ydl8wROARFdGp18yPKBUMWUYNqe6h/SzG01UqJJ
 DA2gnX7lYDc+EC556WMDZ7P2ForxzTZbY1yHabIbog3bNkKfHfqA4mBoXSOSqwN0H7FGghjeniI
 zaVvmKHd2b/17gdDVv1rwM4veixyyOs9e7IVv4VL9L7Nqga8Hv/KUlc9KVwIvygRd1ZBNAE02Y7
 NUuG7MU6CtCORVFZVchthSDycRSkF7PW+9lJf08P+FMs7KCmj9RulrVzlcKGF2AbCN7dnEkuXPP
 Wf6T7yi1QwzbCREp4l4qF+Ieq7M/dAOqC9P7im0jxjLGrCPn3A+32wF9sioZnxDTYyHn3Vuw5Dn
 Lb9DDo4AIyWlgJ1dA72K0xm2xr1NOe4LuVRxcR4LIqQYCNXrk4yunQr7yiIayCYLwLM92NrHAws
 4mT1MfuVhIF0pb+xCBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> While gdb doesn't care either way, it seems more correct to
> report the address of the watchpoint hit, rather than the
> beginning of the watchpoint region.
> 
> Adjust all virtualization hosts which construct a dummy
> CPUWatchpoint structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   gdbstub/system.c       | 4 ++--
>   target/arm/hvf/hvf.c   | 1 +
>   target/arm/kvm.c       | 1 +
>   target/i386/kvm/kvm.c  | 4 ++--
>   target/ppc/kvm.c       | 4 ++--
>   target/s390x/kvm/kvm.c | 2 +-
>   6 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

