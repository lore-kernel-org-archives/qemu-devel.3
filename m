Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA1606D813
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F0/Zwb1M;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QsJF8FxR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOCwW-00028o-UO; Tue, 03 Nov 2026 06:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCwV-000275-Rd
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:44:43 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCwU-0007yp-86
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:44:43 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3ABYIw2002763
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 11:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yf5eZ/RWWCS7C6KKz+3lLZnvJElJVariyFpxgmpUdmc=; b=F0/Zwb1MQbnFG4e5
 ERyL4/smLvMSE1ixciX8bvTwxyAz2AISnwWxcNVVLpZdfhP5Qcr/5xKN8JlE7PBf
 C1Wm0zvQoA47toksx3WKQxMw0eJ0hVeHOfE/IE8JaUmgyF6z0km2sbJiL8hAi0jo
 l9rRVsP4YTs8hVl9FkO7vRDrQ2+dE7hwi6UEGhy2K9exB3+vZd9IrN9x01bEKpEI
 d2+pSGM9FhR30Thmj0kuNCeRKdX5sY4MHdi+mKgdI2hj41eHX6eljAh8KcOVqEJU
 xz3aZkvAd8hUeRR9ZvRZS/lvFJuZtiSnSw8vUqZKMdvZZUUksn+tgzu/TlhTNEEZ
 llybdQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq7ycstn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 11:44:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2c0e6653so699104585a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793706280; x=1794311080; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yf5eZ/RWWCS7C6KKz+3lLZnvJElJVariyFpxgmpUdmc=;
 b=QsJF8FxRkRGDYy2pMN57rDUhDPrkK+NBVguyVb6N76xXTwnl9JWc3nOjaItfWNqWNY
 Fp/srDHQQTDGXZ39gz2vaX4HoimHbyc2GN9B2OEQZ9dH3CiPxYlX8J8i0d5+LGNxDFR8
 76U5H+tXGlJz99xmIrLAk9JoQqFXFuPfdxxSEhIBUEz8exaypYLChtT2XtPUl0GjKgrt
 0Q2XWObm966B/rLJMvW+gjIqahlQ9OTFlRDK1dG551ZSWhOazfRV9r7sd0EPBCm6tI5/
 wmy3Z94Hyjwgu/1bm5QU7LFJkje8ScvI7j20Dqhb76yxZ7fmpgCw270GaaKye1yC5j9U
 caRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706280; x=1794311080;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yf5eZ/RWWCS7C6KKz+3lLZnvJElJVariyFpxgmpUdmc=;
 b=UKfR1mBny3Z32foRRRiV6zXjLDaLFZkzD8ICJmi3qPEO/CbAgOb8DnDIDUWtTfSf/k
 hm/0KztPCEr9/nVeXG7PO/RbNlNxgkrbI4+8oQJ9IVDWyTon2wc1dS0EJZkATmVTEvOP
 zs8JVTLPZFi98JKUIfcC62Z1oU6A9VratuRaPLleypKmOu7x5hZhQeu3oL6c8aOGYUvF
 erSUXCqWY4/BVwArPQzkmmrCld4osp+AxOHB1LOJmHCAsosPrK91yocnQV+7QoCAtIoM
 oNZHCoYPKlSAqVm5HktPZfFUR5Gu1CHRvDOSfKuMavQpvrHJykyFjFiu7xJmob6PJq7A
 VAqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxr4T+ckec41jGuVhoNX/Xq5h3Y1TcdVjCCAz3RwPYnCTZwvcHb0+aRIXZBu/IkIPvPN3YsFD5jwXlA@nongnu.org
X-Gm-Message-State: APuU4Z/KLjuuZs9ORMYZrfOOZMirzCK80BvenVrWbKo6eyAfH+1THXRq
 HUFxzl9ijkF90VTaMpOiJYXvatVNl7RlgunH+1+IiZ0+vFg4ii5z3jPZQeS8413vOyNdjn+vTEJ
 9/llpF8f3sWR52eF/WyaCqTe2KR+wtd5R8zGXWcaJe+siYApgnAYgQLrlR4w67APvdA==
X-Gm-Gg: AYBFou3pIYnKiaIVbTMp1lCZuUNLrzlbF/risUIa5RBWwol87yL8kqMkb1z4NGWxLhz
 /hWySXAFMvLyn+ESIJ/iKABo2CbyCF1HagPngiWJ0PmK72sDU+k0yG1Oe7Ww/PfZ1ASS31JZpa6
 ioQTBmQLHopITmlfDqKtUsnQRiXvogMvIyI2swYLDQbMqzDUM5rH0gSlwSWPysk/Pf4yMW2CX08
 2S+G44JvO6nYtr1q1xZIG8d0NRJ9vdQzitfmSEjdWVQYhPol01lddZxGEQvC7im+Tpk1Uo5F/Ts
 VSKIQvw/hkyyuTegZBp6M++nzGHbI8YrBTMR/1QZDy62USkHto5bHBVQsyErAAj19Gem+fEEPVW
 UIC/keNOVCIIzpUhTi+fQuE28WMJ2tpeAo6+ZcbGbeDveGu9YhwBbW9VmasNUA+jq/lTC5G0mYc
 FGCWsdjg==
X-Received: by 2002:a05:620a:440b:b0:93e:c12c:f142 with SMTP id
 af79cd13be357-94421807ad9mr2142107785a.76.1793706279758; 
 Tue, 03 Nov 2026 03:44:39 -0800 (PST)
X-Received: by 2002:a05:620a:440b:b0:93e:c12c:f142 with SMTP id
 af79cd13be357-94421807ad9mr2142104085a.76.1793706279187; 
 Tue, 03 Nov 2026 03:44:39 -0800 (PST)
Received: from [192.168.15.12] ([187.56.223.122])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425852274sm1067113885a.19.2026.11.03.03.44.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:44:38 -0800 (PST)
Message-ID: <717db136-e5ca-4185-873c-82ca6c343115@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 08:44:32 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/riscv: Select SSI for IBEX
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-6-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261101031547.125591-6-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V7foQuni c=1 sm=1 tr=0 ts=6ae9c928 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=bus90iwuyia7r0C3gDGjVg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=uaJWICHtPDjwm8IFUgYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: wtzsPLSmTEEAFSdLBIEc-Mu6k0cG6kWG
X-Proofpoint-GUID: wtzsPLSmTEEAFSdLBIEc-Mu6k0cG6kWG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX/CpfdpDFdwDB
 HKPzAHM9EZFx4NWXlkrSOx9pl55h1s6buXF4qS5LoaiogcFajSxV9UpCINVQkA2GCTX6hblEi5F
 BTW9nav75wnBhxTj78EneltVTEses8XDWlxeSS/1IHOdZIh+vI8PRfV7i8dKylJOEeaIVovo/ts
 2xt5vGmmlNPGqyZuMTPh0FRGfaR4BKwYOjK9FbKB1OkHNgY8z7cmqzSPXYboEaZq1XmSyC2wXQP
 Tx75kXOMRnuCKOXKe5y0+CvMA+3mrtk10gvQCPg4vLwIjbog15xWnNOdN+b+gGKBUiqzPa/smLw
 jK4VeGJtFKnnosnOS609Lwhe91l3J2vsZucyEv3rYka0rw5TiD21w81ueI5X7uGnLLaZqG1Bgkq
 7W5PHo65r+qU75sh4bCDP3vzj6sBWkf0OJVL/dRIzyCHfBhptcgJnkTRg1MB4/sKYhDTQzjBTHq
 6IxtV1JTNqMfqFOa19A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX0peBXGvQkw2Z
 +S6re6DNtOCRyB9UNHWhyZtat+uS8QI+zYObIh6lQSeXAj52iqvk3uZ+PG1gz62tQB4w2fdRDFj
 VyN8qAIE9+d6w+ZpGOLkSFRWYCOC+PY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030046
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/1/2026 12:15 AM, Tan Chi wrote:
> The Ibex SPI host controller uses the SSI bus infrastructure,
> but CONFIG_IBEX does not select CONFIG_SSI.
> 
> This causes undefined references to SSI functions, including
> ssi_transfer(), when building a minimal RV32 OpenTitan target
> without default devices.
> 
> Select SSI from IBEX to ensure that the required bus
> implementation is built.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 27f03b687c..d99fee0fd7 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -6,6 +6,7 @@ config RISCV_NUMA
>   
>   config IBEX
>       bool
> +    select SSI
>   
>   config RISCV_DEVICE_COMMON
>       bool


