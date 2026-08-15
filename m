Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB858C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvEp9-0004il-IJ; Sat, 15 Aug 2026 09:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEp6-0004iE-47
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:53:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEp4-0002aS-C2
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:53:19 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDMLwD4012961
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2QVIRMmy6CwNjWFI8w4TaBxFhy+gC22lWK+qfX3lm84=; b=bIMiGvozReWfRNFq
 uChwj2wozeU5DMnQHusId0X2qHQ6FtcA2S21wm1WDQ8ZrCW2YoOzTVhyWltG3OQi
 DGy6Px21Sa0C1tpbf+Kgf2tI+8wdshEn1oc/NLhcHPguLHoCHrqNfpwVUr3wOI/c
 aVgjjh+hp/lM7zWD/WziDmoIgj2RyrSd7WbzwzRCeaGasODOWu9krbtvK3gOvSw3
 5CBhh9HYjWYwqXup2PnAcCpq878RIBr699gJSpYHsz0Ku0aHlnXASPuy9rOItn3W
 r15akix/H6wpt+cfE7V1qBukBpGvhevD0G8H3S1viD4NtmX9DdVP2823BN4YkR++
 4CHCCA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9ggycy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:53:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936d067836eso196909985a.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786801995; x=1787406795; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2QVIRMmy6CwNjWFI8w4TaBxFhy+gC22lWK+qfX3lm84=;
 b=Uy051mr3lQ6OeFWQSn2ksRHWyUNwDduuddvWMPvjSd4wI4gqpoZYya9ZLFZ6DPtgWY
 Q+zHc7v/Ozu65/PCumfSl87W0OhdPGNJLezGgrBxXuQdru4mczW7TPS6Nq1za6pyi8OV
 l3FGMVsDxivHPAEVv7kH867wVO5xRk/IybMr4rpfxvMaSBKagXYXDTs5abBWT9X22VJS
 uoV/Im6FZ9eVx3R8YZ6h25+A50/H7Cv57X0ebajL7vjW4Mv6sjR+aodmCNSabxhmqlXx
 oBd/qhS1iNSFzoR5vMPK3pzA9VKYZ6D0AdpBGC21sM6BtezY6C0sdgO5DThmK20rz083
 /zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786801995; x=1787406795;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2QVIRMmy6CwNjWFI8w4TaBxFhy+gC22lWK+qfX3lm84=;
 b=AXmnTGeH9LaxxdScYu2Syow5h0ChatkyXOZr9rLBdcxLQzgPA9M+T0Gye9QkbqD+EO
 JyxoGVE5ejh8Qxo6AJCBV0XWONdT6+/jh0g/2XYqT37ia192U4/tDXR8VdFJJinpXgIM
 xsgp2Kt3aPmQrJTqOUqKmbvfVkQybQOJeRBJQpUs1QXj5SJfClEJe1wVFePP9st2QZF0
 63HaEBJXsTI8uOK/3z0VW3+gVk0BtT+4NaR7r6vradoEB5YgO6+70dUaukI/ogIwLkM3
 NM1wBiNI5luTxku2+xY3TTJOhqa6rH8563NjcFEkH4Jxv3gwn5EIx7UFghd64OnEKWBx
 UXAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+4OA7ZfymsK1G7gDS90Ek2PGWGBzl7AITaikONa8ZPB0GlUDJHXnHrGj1yFvNof/mVcf42uCT2vkM@nongnu.org
X-Gm-Message-State: AOJu0YyF/DZPKPNkZ/esJkqOGurnyIxS0ud/ADdgdLbogfl0vSMlA5EZ
 A5s9wgU2kSd17NLn+JdmjpLno56DK1/wQW0WUfuH+ppPguqogPpi0RwQrcnS2Ky+QbXizyyZqrg
 zUDdg2rC/fLDSFzEEWKx0yzPNjMNcS+R/JZAbMjAQ0Joi58CpD/Vu2w2qOg==
X-Gm-Gg: AR+sD120xDyCXqtzS8MGufSEADx5BGlodvoBI/0uFTC+2a79wmChIT18kAM9GEhh72h
 edraqK73yj3pRZbMp3pgdO4y1reATnAlk9eblaVNTPi7KomSRd2KJdEB9jVuVMGjRYYjrqQXlgX
 ckld5D2htEZq1cC+CLdXtj8r2640D6UrjQQklahTc39XJsSsNayeh1N9N9J7e/UrdERygQ03yf0
 iZ9IgwzYwQLGJ0hoXHeBii7MDfvwpDLq95WkcferwoOXjZqNl7IG5tYXOg+FwwyYU3N4jHO3PkF
 koIElavXRsQlWl6LwJG7HDpTX5qy1rWfykGgfLLeb1u0IwXctVwRsGx033MYwgf/7NpmSnvQs95
 kbymYzdMPTS8m0t9io86vULxzOPy5iF9aHhc=
X-Received: by 2002:a05:620a:3d01:b0:915:a111:86ae with SMTP id
 af79cd13be357-936d238c318mr914137485a.35.1786801995570; 
 Sat, 15 Aug 2026 06:53:15 -0700 (PDT)
X-Received: by 2002:a05:620a:3d01:b0:915:a111:86ae with SMTP id
 af79cd13be357-936d238c318mr914135185a.35.1786801995124; 
 Sat, 15 Aug 2026 06:53:15 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899b5f86sm115714325e9.5.2026.08.15.06.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:53:14 -0700 (PDT)
Message-ID: <fa0c9b5c-81c5-4289-92b4-2d77329cbde4@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 15:53:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc: xen: reinstate the "xenfv" machine alias
Content-Language: en-US
To: Dario Faggioli <dfaggioli@suse.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org, 
 anthony@xenproject.org, paul@xen.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260730162238.3308286-1-dfaggioli@suse.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260730162238.3308286-1-dfaggioli@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8DxbUUw3Me0k4nc1OjUiGdaxHNNXK3nr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfX8TbCHvIFPM45
 H/+6XIhVqcSdy5gaqNysN6eW8fjY3DjcO2EJxn60S+/HKQm68jHMzRCXS+7JQouucvIzZLjROfr
 5fb8YjLu3nWrpClPAczw8tWQ3QjCzRE=
X-Proofpoint-GUID: 8DxbUUw3Me0k4nc1OjUiGdaxHNNXK3nr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfX/t+rY/ywUZwQ
 hTlceH312ML9RIfH86bDsFs5Ue03Pv9vDFrfFcfpsF29kjJ1Zhj9+uHOkMwAQ2CyR20e51bFTde
 XNePLbTH/YyxzsHXxhcjR6srHSOq6eR7hSZ8/p3j4hjYWQD/jFcUMkh04VeYJ9uY2gH2vhTDSr8
 Z93QyNPcCjG5DeknJy7W+k5L98817PPFAADiGIozijovymOxLVMyb0IEK1tUha2/IQHVyhfdwf0
 Ckd7p+8a7IRHS4sTUpStaVNLOoM2grW/fbwmf2Q9LGd50IaHConW3Y6qELVlbSAvbHSu2eSlQ2s
 /o7sAV2kMotSLWkowE1YMXNW1otyk9CIaVW276eYGH2Q0W4FNkXyaoEgG3ufI6gXQMRI1a7wgIY
 zk+d0tkxZ0jRstQzVnTwtAfZmj+PA5NnBkRzv7KasRowgjXgEMBmGfvq0k365M9dd7xsI2Xd7dy
 66n+XXIizVi8+Y4QltQ==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a806f4c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=iox4zFpeAAAA:8 a=EUspDBNiAAAA:8 a=KGrwjuuvIC_z2q61s9oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150100
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

On 30/7/26 18:22, Dario Faggioli wrote:
> Commit 7d2778dea32a4924a469f1cc5767042c8f5b4eea ("hw/i386/pc:
> Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines") removed
> the Xen machine type that was providing the "xenfv" alias. As a
> consequence, since the tools are apparently relying on such alias,
> we're getting this, as soon as one tries to start a Xen (HVM) VM:
> 
>    qemu-system-i386: unsupported machine type: "xenfv"
>    Use -machine help to list supported machines
> 
> Reinstate the alias and let it point to the only Xen machine we
> still have.
> 
> Fixes: 7d2778dea3 hw/i386/pc: Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines
> Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
> ---
>   hw/i386/pc_piix.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 82457bdb16..0a911ce59e 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -658,6 +658,7 @@ static void xenfv_machine_4_2_options(MachineClass *m)
>   {
>       pc_i440fx_machine_4_2_options(m);
>       m->desc = "Xen Fully-virtualized PC";
> +    m->alias = "xenfv";
>       m->max_cpus = HVM_MAX_VCPUS;
>       m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
>   }

Oops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Queued adding the @stable tag for backport.

