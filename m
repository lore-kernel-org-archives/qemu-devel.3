Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFD8C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1cR-0006HB-Vc; Tue, 07 Jul 2026 04:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1cQ-0006H1-Um
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:57:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1cP-0000O6-9v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:57:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678Djgb3050550
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 08:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nhBVdAn+jjEJpl9GGvSGXmJwci2BkcnJyb15MNbbGuU=; b=HPxXkU3dvM9i0GrF
 YS8DpRFF87mzi5puTRT6EIwnU2YCcjL/IoIWVnFyH/SQAW3owwmKthnHjZXRbOZu
 rS1EHi9So4OT4gmK639r0ly1MUHNhQJh+a62Gxp3WFIHJJNFx9K3VeCmWv5+Al9x
 2n0vLQBgWQUHeZ+eB2P3D69mRLbv+f384tcGoPdTg0gxHGTrqQf7r/o5rgVm6Fw8
 zJ0LVqlzc1XPMXaoZqO6zjXD0AL/h3mjX0HZTTaerxyY5fGghn3abejTUeBNtVtp
 Rn3KqUVYlepUAy6sUlKpVzQjgIi3zPMv0Y+ie2u1Rz0sQQxPV23SDAvqEWx0Uq/0
 33nFiA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u8bkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:57:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8fc6b670b4bso15189606d6.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783414647; x=1784019447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nhBVdAn+jjEJpl9GGvSGXmJwci2BkcnJyb15MNbbGuU=;
 b=ajLEcdYKKoFZOulVjEcgE+YEZbQ3HgevBQGE7ug9z5alPweO+9ryMtCmhpCjwhHTh1
 ow5Hqjplb1qvmoY+BoiRooLP0dGRSjOg5VyzvJpYg5mFYN2iKkhRT3q7wExsjzR7FJlj
 wIAPol4ayQ69i1fc6Yl4/uLsicRvT50tVyQ5kNjpePpA3vYntxMiUyPekRHfHW38sD4C
 FwHOaJF1713o2jtMrD6uNRh45Im9ykVyf79HrTHaqSvZXPGCk3TJ0BQHPJatNjFkTMG2
 wC6ReU5nvQDynFMi420xSv87CNvamdcs4hwty9FTGG/8i7F2XdfUNZd6ntmeqMly6yhD
 ySRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783414647; x=1784019447;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nhBVdAn+jjEJpl9GGvSGXmJwci2BkcnJyb15MNbbGuU=;
 b=L+GJ8mLF+VcLbrs89r0KzQT0wodtFUSZbKb+i47yv3eNgk+E1v/WzfNkKboZxY2SrW
 civ2S0iK68hKJXeXSXq+cn6/MaVb4ajYCwfQwHi88oj7j4lY0xIdjsKMAJ/bSocKO+6S
 O1178aYn2WtgooOKzhLyn4OcrvY4wG8wBCwQiRlWkb9t1odbjLJBjr63JD/ctLLCZ889
 T988AI8qyRMoBKEHLOIet+aAQTl8Nq48IGyVCP8ZKQEB0mYxbhc3DrksH1/yhJNuJZUr
 EB7tBE6Z+s111uEZbqXOMYF9vwhvXcfntc7o3A6FyyYoh745EMr1TIwT3bquIxFEaB9c
 IbhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXxB8BPUhhLgk1vkbKLP4FYb0Z7SjOKCi7xiLfvuvZVLCKW4oj27Ch7zmHz0PD/DAdWgI9CEZz+Lif@nongnu.org
X-Gm-Message-State: AOJu0YyWEHHqG6dn8b9TC+4m2VboAMB6Am4IZ9m1O/Kk9XNmOi0MYHkJ
 QwtORwa6vGI/pR11gPTFsLT2zEACJHT+NbKaa/3JsV7A39td+hQLoeH5sjEX1OMU91LYRrMwHXn
 CTx83Xbtnq4s9ZQ0wK1fAtaj9zLDtAufGWOz8fV2YJZqU/iQDTkSP5tlgAw==
X-Gm-Gg: AfdE7cmF8P7oWIVulBjpR/jnF2+574Q/kSOF+91XtjG/w6TA2IYVD1Cekwc0Qa5r6ri
 w52x9PTwAdClbJfIvp6uo0AkxhnXccVM02/XLFA4tiLQoI0rPb4n9u2eYc8c0SvX9/mUYRhqqVD
 9/1cUeLDBx6329Guis/0DhkcovXI5TOPJMKHXSH+Q03DB2kU3RIXWtr2RlGw1skApnkdthOyh6o
 P++MYKo6ewPRWFO0d83NhKCinkHFU1Wfgm2zgnZq00EXLagZ8nQ0484x+LI5QaQL77ClB3U6nO3
 iX4GzVnpE8Ucs+OB07QOa1SMGCmV2FOzPilZrvY009tn+69N4O4PhCauTYxKgTKUNHshNeEUehP
 ygUjANASiubtcZYe+OAH+Un0RRsdZjqU3475icdB4NXE/Jm3pkX8PIXLeQUvTYA==
X-Received: by 2002:ac8:7dd2:0:b0:50b:4491:a2cf with SMTP id
 d75a77b69052e-51c747bc7admr46102411cf.27.1783414646676; 
 Tue, 07 Jul 2026 01:57:26 -0700 (PDT)
X-Received: by 2002:ac8:7dd2:0:b0:50b:4491:a2cf with SMTP id
 d75a77b69052e-51c747bc7admr46102261cf.27.1783414646250; 
 Tue, 07 Jul 2026 01:57:26 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19ce4ad4sm5314074a12.12.2026.07.07.01.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 01:57:25 -0700 (PDT)
Message-ID: <2d2e2609-ff6d-448d-9a78-9e9b6b9a9ec2@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options: Enable the -enable-kvm option for loongarch
Content-Language: en-US
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260705-add-loong64-kvm-v1-1-aa8b85ecfa32@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260705-add-loong64-kvm-v1-1-aa8b85ecfa32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NSBTYWx0ZWRfX+OZL6dz+znry
 agjDoCw7Ub4MMFJOzyig46mCPdAkTiZEGZkTf4V097u005LlDL1AZq4srZWD/lhp2CiRx2X8/ow
 eYr+DDRCgzR7Ist6pGGlfsLG4NMlQxw=
X-Proofpoint-GUID: h0peetrjKtvrINpM--YUoaF0CwWPg0-0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NSBTYWx0ZWRfX52HARE88ZKon
 8aAP11o4qNZxDdb/1So14gP2WIXgF9j6QvYOm1XX55/jVrmONvy1bD9x2HyWhAbdUWfKqpZPWGM
 N3sKLngu3+EOGjHDpk1y9pLY+VxTAPdR/txunN3p8dvYAFKwpPbJj1mdBx0vlhOxplz+LFidARf
 hFN62NQ135Ad8VEboI3jhrdsj8xTWauueTVu+pQsIhRqiFjeYm7DPhR5PdEmyQLixQw2M4HmKW9
 2aEShHs0iWRJVXmYE1DMIkPPq2+NYJFIXQdLd8mmc8nX0HFwAmFUSz4a33xaXELK/QxfwGSBSyN
 kapK0yrF47dP46WCIkp358Fc1q8jB52clRGRW1JgyqZRYvJuZ9gSbpkjLbw7P3b+pOIDY3L67TG
 GVKg0CIbRJZduBRLD0pJRXPR37eaYV2K63mr7UeNxOTXZCVrNB7BQ4ziwpinvj+fKnYlFlmF06D
 i3xZaAKhgZhObL1AFPA==
X-Proofpoint-ORIG-GUID: h0peetrjKtvrINpM--YUoaF0CwWPg0-0
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4cbf77 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=NTFCwsDEUaYd9owm7-gA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070085
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

Hi,

On 4/7/26 21:50, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>   qemu-options.hx | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e44b47de68137120da9979fb081d0c108f13179c..c7dbbd01e73367380fcf653fa8d0d18795dde9a7 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5164,7 +5164,7 @@ ERST
>   DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
>       "-enable-kvm     enable KVM full virtualization support\n",
>       QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_MIPS | QEMU_ARCH_PPC |
> -    QEMU_ARCH_RISCV | QEMU_ARCH_S390X)
> +    QEMU_ARCH_RISCV | QEMU_ARCH_S390X | QEMU_ARCH_LOONGARCH)
>   SRST
>   ``-enable-kvm``
>       Enable KVM full virtualization support. This option is only

Isn't the legacy option for "-accel kvm"? (Apparently since commit
303d4e865b7 which is from September 2010). Maybe we should get rid
of the '-enable-kvm' use in examples / scripts...

