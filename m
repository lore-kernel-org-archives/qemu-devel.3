Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A54CD4F35
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 11:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMlEu-0004dR-4t; Tue, 12 May 2026 07:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMlEp-0004d0-A9
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:25:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMlEn-00014S-JU
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:25:23 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CB2LSO3444808
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fvbi8X6+0OwenSSMBG29ao9m0wsC3ZJshZ4NBRWbhUM=; b=LwbrR6gDnxCHV7tB
 0A1uzwaYcbe/V0t19rHtyHWvGE7YhGoALbp7ryQg+4rHbgsZIEIXKCZX5fSLHpJN
 Fs31rhFPGUpQXDmFXvmPUHbF+gPfoeBaVa/28QII7Cy7T/Ng5aFGYCmBzBHS0AqD
 FC6PmoyxE9oKGp4/MWG8ggSFNcGqws+c9m2VMjvSzlkkDPXjo9Q8qELomj6CSy/0
 1a00NLxgaeDXC/P/4Dz98gi7JmVKZP4a1kjKJ9q2TWJymdQhYIPS3Q15UE9Y+XnP
 7fleMVJAJrrXdas5SyQopwrA2qK/kNhQ9Bj0m2ZxBv/0zVjUg1TN4/d1iLBU8zD0
 3HlOkQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0jy88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:25:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8ece46c4ba9so968769585a.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778585119; x=1779189919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fvbi8X6+0OwenSSMBG29ao9m0wsC3ZJshZ4NBRWbhUM=;
 b=OKOk3fr5RsH3uOn1g2kqK55npLBYjL3NPUsvbvOGCer+FCqUhz4HZF+FJ2JhBuAA25
 I09BSlvNTOKxm+rwNj8jHEsqSEp3pVId1m+yC8LZL4amNtEIc/mLu96u/KDExIp9fpzb
 wtbw/xgeTA84Bm1iUZayZ+jJFsROxwn6sgxpxmBtQwmlwhluGSFl2fRI1YDrH6kpa8MM
 uvh8ZPzXtN2G7JkMYfprPq5YZpbtjrW/QFTrVgqAwNkcrbRSZbX6qCOhBJZGodh5P48R
 kyH+PQG85lLsX0ll1wqe/U1y9fzapoOu4VgE+5r2Ql+igHQe+QxqzNx/00ERqJr/yqkd
 Pezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778585119; x=1779189919;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fvbi8X6+0OwenSSMBG29ao9m0wsC3ZJshZ4NBRWbhUM=;
 b=nb2Mqg8l6ipC2wvqgqe6MjVwkj8LRld4I5FYeb+9l8+68gcuYjMzuLKTAFxu9rV1jZ
 BqpowBZfuTBk0Yt/lssGtF04ssV3lZUI5oyYAo0mm4Z/x7v7hd1w52ayav+kEnbO4O0o
 sOXC/zLwFTDvntWh8yNfqEwyuKYh7KqqhxPJOlnj0eQQ7sBPu+qwikha5sL5shKOuDuz
 7+B5RjgDJiNqRsFxrth+orJusDML30vN6xLl2xKFsI6fLKvXv9o4iFMzNsYeCmrftqDP
 0/oM4eIkqpkbe9y2M3cKOoI09TiyggnQo/B3ZpUJHy6JKLhiiXLfKnpnpeT1/bH0r4PF
 EWLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HVDx0xJvOPmfbVwdWjY0uyU5VUlxUx6FaVOe80Pu9+XJj1hpK7LhruYlWlIIFFEpvFyLS4Bk/kNrv@nongnu.org
X-Gm-Message-State: AOJu0Yw9dFkLiS+QJq0N9GU5Gt1pPFGnQ6HMFImcstvdTJGxzXP188XQ
 zlD0uBTCBI0ljjN87zYFyKD7ksZr2NwpnzyCOBraoJtCM0wmTVNV/TQnM8eFMQB+z+JNT0nPGER
 ZOSB+sgsDRsNWxjASrjwQG1Q47bNBZ3kiLD6VCJqxLEsvl/lYl8Oi8mFE1w==
X-Gm-Gg: Acq92OHHPZJnsBNRvUOYa1vqoZqIRGEeAWOYgvFUJRi5Gsgdvo74g23lqNcP3xzV7lN
 mXQ+XVB/xitjJ4NKbjtYcfUI2iNw8dxMCv/jcRpPFMeZdKsy67iTOyan5RxwvwjZgRvMOF3neNy
 3kbSBHTYe9onOjLsOeijgsrOsTHxYrh11db2thfKSkDnJBhIzahvqUCfY8smtASSuI1WkGNvIw2
 ZOPEmqOQVaZmAcNynEX4Sn10rJfWsSJmf43bjMA10ErxPXkdH+faAB38paSk0Tp91MX022BlMGF
 HrWjJXOWPylN0n3IjjrE590MCGwky0cX93pVcjDaoUsf46ROSrQeTYcg+EQg/0Un6z7QwofyS2W
 EGUNFK73ZTDWg5UPUoucSzktZkYU144VGJPtpo7tyXIE5wz0b5XUJoAC7KhY=
X-Received: by 2002:a05:620a:4806:b0:8f2:4470:4796 with SMTP id
 af79cd13be357-9090e6e24c6mr2043706385a.20.1778585118857; 
 Tue, 12 May 2026 04:25:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4806:b0:8f2:4470:4796 with SMTP id
 af79cd13be357-9090e6e24c6mr2043702485a.20.1778585118399; 
 Tue, 12 May 2026 04:25:18 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b986c371sm1305736685a.2.2026.05.12.04.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 04:25:17 -0700 (PDT)
Message-ID: <88318c83-e8be-4b0e-8499-039203d1bf79@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:25:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv/kvm: Add BFloat16 extensions support
To: Zongmin Zhou <min_halo@163.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Zongmin Zhou <zhouzongmin@kylinos.cn>
References: <cover.1778551633.git.zhouzongmin@kylinos.cn>
 <3930b7f89638ce3a89a2fc13051571fa860bed6f.1778551633.git.zhouzongmin@kylinos.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3930b7f89638ce3a89a2fc13051571fa860bed6f.1778551633.git.zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a030e1f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=cgWPXpg_ERXXHHlUJLUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: MR-g1e4bVe8lWBC3dW1UvRDm2ozQ93bg
X-Proofpoint-ORIG-GUID: MR-g1e4bVe8lWBC3dW1UvRDm2ozQ93bg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDExNyBTYWx0ZWRfX0DOQX/7HFUbW
 S6t8wZrTBeo8m24HO0tfEbyvcUFblxY2INqF8mlf//6Ojvugx61wp91h2ShZhG1h9c7ZEMXVW3s
 bAdnbqHQ4UYdLYnQN5BPscMkDO4uKL5jD3kce88Pbuvyvw49jfwWgE9/9y9VdY357Zfm36EY2Li
 X49IB5pbQtrIapEJySaVmouBRHYjoFXHJzYmhd38JLi0/0T/O12tpT4R5YlamfuQWDAnlYmiyRa
 nBqojwVozdSmpqdGIalGxl159WTfwkjxCEi0o2VbHzesJlqzQFKurK0JDI1zv2qWpFwZGgRRXBw
 R62FbcRuhymLOpMaG7p+SuQna5EAWB333DWbq1jZ70dZ+vszLEkFamnxVa8BNNTF/2JPXo6tk9k
 6SO9urnOdgi3IBnMnHhrBC4ZP0Zv1wfbgDFP4128g5i0AdK0/m/NP4kcJEQHFsOYz6RrFQqbMse
 TuIImr/gplUZtt13GxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120117
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 5/11/2026 11:25 PM, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> Expose the BFloat16 extensions (Zfbfmin, Zvfbfmin, Zvfbfwma) to KVM guests
> when available in hardware.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/kvm/kvm-cpu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index a46737f934..d732f5614a 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -309,6 +309,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
>       KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
>       KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
>       KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
> +    KVM_EXT_CFG("zfbfmin", ext_zfbfmin, KVM_RISCV_ISA_EXT_ZFBFMIN),
>       KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
>       KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
>       KVM_EXT_CFG("zba", ext_zba, KVM_RISCV_ISA_EXT_ZBA),
> @@ -334,6 +335,8 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
>       KVM_EXT_CFG("zvbc", ext_zvbc, KVM_RISCV_ISA_EXT_ZVBC),
>       KVM_EXT_CFG("zvfh", ext_zvfh, KVM_RISCV_ISA_EXT_ZVFH),
>       KVM_EXT_CFG("zvfhmin", ext_zvfhmin, KVM_RISCV_ISA_EXT_ZVFHMIN),
> +    KVM_EXT_CFG("zvfbfmin", ext_zvfbfmin, KVM_RISCV_ISA_EXT_ZVFBFMIN),
> +    KVM_EXT_CFG("zvfbfwma", ext_zvfbfwma, KVM_RISCV_ISA_EXT_ZVFBFWMA),
>       KVM_EXT_CFG("zvkb", ext_zvkb, KVM_RISCV_ISA_EXT_ZVKB),
>       KVM_EXT_CFG("zvkg", ext_zvkg, KVM_RISCV_ISA_EXT_ZVKG),
>       KVM_EXT_CFG("zvkned", ext_zvkned, KVM_RISCV_ISA_EXT_ZVKNED),


