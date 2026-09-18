Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B22C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 03:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7PFI-0007zt-C5; Thu, 17 Sep 2026 23:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x7PFG-0007zF-SL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 23:26:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x7PFF-0006ld-CR
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 23:26:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2UW5S262836
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NJLPYacTxXFB17HuXQnVy4Hrs2GiTJh7L+fMJxukKJg=; b=XzZ05LfUgtEGmila
 Hp023JF/qhkVq3MT5kF5wjfFyYjXRtCsh0/WV4tO1Ner2ddRQlEXmbANX9OpJdOc
 ab5VocN/E4OC3+iQMT4QpN2h7UnaCNjMBq1DFA2VQLAwwI7Ef06ftrLeLWK5qqhB
 9GAPXF4nvZuPfTLbbhiiVX9G2733aoDP+HTPCFUYA/oR2+y4v6qHSVvoaP2EXKLt
 ui4Iq+yA7PTbtTtnsEz12qLOxwskEPwPN5GQEA/5DVDJlAMp6qAsGJ3ghje25Krf
 kVsxjHMUVXxG8bpoapGxT/S9Vf1MT7LiiENgkJKeXsuZkOZmGdLd1Omq23F6Wo6g
 LmdDaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrg41433-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:26:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5329e965ba3so3349671cf.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 20:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789701988; x=1790306788; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NJLPYacTxXFB17HuXQnVy4Hrs2GiTJh7L+fMJxukKJg=;
 b=Y8uk88Zvqm1jo8VxrX6sfMw/omwciED34yhkO/69dUJBw8BTU2svxdccdmlHVrrwdc
 6m+jju9Vi8zPzgMcyPU0eK9uh1RHR9uGfjDGfOQNk6utOReVsR+C5TYih1+K67FR0R+s
 p296mB/3BbJ6DQdWFnu5A47K5ABMmWWP7ek0JSZEr4nX2J+BhQjPKzGB1+0S+ImGHnot
 r6a0ewtERCZz4Om+mmG6Ya3FZ0DElD6Z99CjYkTCL3qLsAElXo7Go1NSawsRkYkl+WDH
 h4oO4ZQBAVdhwnNJ/fSnfmBstkoaD5cM2zzB2J+tZ37kn5w/tt42k2DFib2EzHSt51RT
 zmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701988; x=1790306788;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NJLPYacTxXFB17HuXQnVy4Hrs2GiTJh7L+fMJxukKJg=;
 b=XSGu1SiF4L5ddM3BmfIV3kmHUxF1CTla9ldqx+6QhxHJuiloQ1+IM1AWjbYn2Og4AR
 K9FWI3uf5bTqymxh0wvtFwzF9LflkE95ubyKlx33XzmvCSGQ7kEV5Dm9kNcEuJq87tkn
 sNMx8/q1GGvsvg585IKP1CRsibd6y6os51x6ha/jFMViZ6eafd/RXiBJoV4ZV1ivOi4a
 03B3Lf+BYFbfj0JbY1cF2crJs2H365hM9r0BDMxR+9sMNz42CwlthfCx7jgHquZm6N+K
 SaEIqwe4/t/V1IGk5G4kNuESlxoNR3wll1R676aPsOlsMEgwSdPKTw02CVf7v0fSY3ro
 Zv6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwx09XJPW4aa6+RwGLj1mOfnqxjkmf/3KO21quNc/9KQyqAwB5C5yS+Dr+V0mbP5Dc48n6klDV5mQSC@nongnu.org
X-Gm-Message-State: AFuF++k95RxAOKJIUR7g6LzyyiRvINnXSjZHzss8SGTOuyk8z1aznWRa
 274mirAfseB4JcgQVOxZM2v/mzfqenHN5jt2IrG/EQRp7QvVMl0+GLuigMPA5Nehn/kqgVwCS4e
 IqzMT8cHRNnZ19qi9YZsmyeRJkESxudCHhC3jdHOLJbg8vmxvj6aKffjDgQ==
X-Gm-Gg: AYBFou3p/5G+fDMOhWNn1CN80OqJb3DI+6vsJApzfgbWtlF3nHzcQx7aESuqtgf5Qtn
 effEykB8EFORgN4zQzr22XAQjqQYlBP8ngd6OLMEyvGJ6uFkDxrk3cVfQyac/4fsm0FetCCMULo
 MTusZZ6zccJny8U7zj7UuUBAbmiukJNq85EYNsJPCKshEhpRj14MxRqn9VVuA/08XsRf7VWKH3D
 zynPhHGHPYJhBupkTGYhQaH1DNILDa4SVFtEnMeocuTrzkEA1zojESghZkkZyEJX1DU734RtInx
 RXU+4Cawz1GK8q7aes8/QvRaaFntVKwYG4wik4qzoZt8pCLNc/4Md9cCHuOKMzViQXJvMAR1JZ+
 Orvkx3nnRt4wqFCbMV1o9Pyg/UkOkbTpls/Qn3wtS8udz2Bo42uA3LgxzZzDU7hIYcXO7KRCeOy
 w2QLM=
X-Received: by 2002:a05:620a:4809:b0:93b:d7c0:461c with SMTP id
 af79cd13be357-93bdca91c94mr156050785a.87.1789701988319; 
 Thu, 17 Sep 2026 20:26:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4809:b0:93b:d7c0:461c with SMTP id
 af79cd13be357-93bdca91c94mr156047685a.87.1789701987908; 
 Thu, 17 Sep 2026 20:26:27 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93be0e90276sm31322585a.21.2026.09.17.20.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:26:27 -0700 (PDT)
Message-ID: <8c35fd98-e9cb-46bc-a014-bdef47c0e524@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 22:26:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] hw/hexagon/virt: use unique QOM name
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <17746591750@163.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260918000640.1001-1-luoyonggang@gmail.com>
 <20260918000640.1001-6-luoyonggang@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260918000640.1001-6-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: R_U9uHxzRuNZQnGlsAcUFx-VaiNInbor
X-Authority-Analysis: v=2.4 cv=ZO9CCn7b c=1 sm=1 tr=0 ts=6aacaf65 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ne3SjsFjHeSDkW3U5kIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: R_U9uHxzRuNZQnGlsAcUFx-VaiNInbor
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA0MiBTYWx0ZWRfX2eONu4ys5B01
 aaTMLpZ0GFPGdPJ8Fzjt4GkG1W/RROOVt6PeiegYkdfoSY8M+oibuJc7m1OQ/RwWgM3ufvaQyYI
 2ZN+AAphiECzaF0BeciR9gtrb/j/D1InoouLerxjWzD1ZVLrPK4D8dvayYEv3eEUuXvH9QVew9S
 hu9TgqFvDhWvkJJ6eaVh6tXxE6bAVvjVrx54qVqf/P7CQxC/EWIA16oG3k5ttkyHQ8HxAFpE1PW
 nolTjBhT/f4ch2FML7Js/YraftMDHglD4O8prml8vqTzu/QKrDLi48XyEWUuXAHoTdW/+xWS1j+
 v52eb1CLOhTxeXB+ILc2Acmc8IJe1DCqwhxWbDTBmKjSGxha0/TEegOK50fdPI1e6PD3WCCRDOv
 y8sXAaL7NrvnT5qYhB8hIfFlEYwHxJh5a+9/DoHY7uZRJ7129728fO4UMvyATRsuHkQthvaW8KC
 sYkVUDt+s6VHUMTlGLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA0MiBTYWx0ZWRfX/dNO8PJw86nv
 /T7TDXRtxbbzEX0l0D2aXAAj0NXbStYQ3UraMtI8vCT6R2NGzVhu+X7RlubgG//bZ6mMhHnDC1y
 47CPhp1EMC9W/jD23u6dDnUcnXWLZlc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/17/2026 7:06 PM, Yonggang Luo wrote:
> Set TYPE_HEXAGON_VIRT_MACHINE to MACHINE_TYPE_NAME("hexagon-virt") so
> Hexagon virt no longer collides with other virt-machine types in one
> process. Keep the -M / help / migration name as virt via
> machine_class_set_name().
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   hw/hexagon/virt.c         | 1 +
>   include/hw/hexagon/virt.h | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> index 64d8366d27d..04591066bef 100644
> --- a/hw/hexagon/virt.c
> +++ b/hw/hexagon/virt.c
> @@ -359,6 +359,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>       MachineClass *mc = MACHINE_CLASS(oc);
>   
>       mc->desc = "Hexagon Virtual Machine";
> +    machine_class_set_name(mc, "virt");
>       mc->init = virt_init;
>       mc->default_cpu_type = HEXAGON_CPU_TYPE_NAME("v68");
>       mc->default_ram_size = 4 * GiB;
> diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
> index 4ca2f1ef859..523c4858036 100644
> --- a/include/hw/hexagon/virt.h
> +++ b/include/hw/hexagon/virt.h
> @@ -26,7 +26,7 @@ struct HexagonVirtMachineState {
>   
>   void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
>   
> -#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
> +#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("hexagon-virt")
>   OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE)
>   
>   #endif /* HW_HEXAGONVIRT_H */

