Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCDDCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHt6-0000s4-QV; Mon, 12 Oct 2026 11:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGHsp-0000jn-G8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:24:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGHsn-0001Fu-It
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:24:11 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC08Nx1686255
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 15:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 avhuJwfJZkq5ZDM6XyuP9+mxbFtn/0gqePxEjPC8c6k=; b=O2f/KgFU6hf+G62a
 Fr8F94HuTWqld0FSEqw4BQIzG+pjSNN7VOZHeU4xEQYIi3GGZ85ckQxqND5yFuZz
 NwibqNGZ9s0Ln3itx2LBj3/z0LzQXABLSPavV7S4bkt0WBn2n0lyjicbo1FkDAue
 BLN+37fJw2EzfFIl71d+6oL94FsaceoATF+DGh561JWYLcm0pCm2ZTCF298W2Q+M
 bwP4spzMU9XLcthdJlnUeok0J49DsTIZvVK+F7f2ruqWfUAWyqjA4Ns6yablSyjS
 CXOS8Nt4E9MyEuywUERLJCHRV1XXAWuQKddc9/HrKD5tojbeWY1ykX5i72wxT/K5
 6zCDEg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wbc1fb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 15:24:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5337f26ee19so61334891cf.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791818647; x=1792423447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=avhuJwfJZkq5ZDM6XyuP9+mxbFtn/0gqePxEjPC8c6k=;
 b=aMI6O951Xy/eiCZSIFZWH778ujF3/x0gy7T+r+9KoGfdRMK6Xuu8jXQG7kiac9oZ9v
 Oo21BmMx70eLal0SFuc80AL5uEdohDBimanWNc1uDeNPTfFmYGb7BNcJCu6tIL8XeJnt
 h6K7m+p/PuASGrKRdgkcSkyq6QZKUN7MgJJb7GhOgffGvOgR1CBT1h9XfrLG3tH5Bnx9
 wy2UPGYGAIOVWLcl+NhWqIhbbtXs9lJ+xUc8UvGqPU4IYlxn7hRk5v4IHSCMT9eZH4Cv
 B8MI+6xzhY+FIkWBFE+/nrRTV1SpQ40NoyjhlsdtLDLChC4vYPxgtld8zQbgrU7KmwdK
 ynNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818647; x=1792423447;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=avhuJwfJZkq5ZDM6XyuP9+mxbFtn/0gqePxEjPC8c6k=;
 b=COcJjebg1u93RQRMyxL89zUmnQGBYfcSInyEMXbBE/+2Q/qom6M5L5Ao3Wzc8TkI7s
 IOiqf0R7dxseEaJokkADy2GUWcxHrfE2Q5O/fpOri7c12wYR7lZ0MhVLrgjVTm2XpslJ
 pKdTKkyKy7vLoiOIxJTwtH3gmcm4lptXAKNOAfDaG3X+KlLaJE7I9Y2DJNPN30nvoxIR
 gI0sS3HsVRogB4MU0Yc2BwigHdn6EbhfRk7XaeRcjMFVLD3o7iRuhznu5yqmU08CtDWp
 NcryLUj1ob3xFSyp0PaEYxGrad0UbuWQTnhl9dKNRZxp8sUftnneXHcd0z1QVhlSEgmH
 k+2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+qAxYmQ0abl4mljI46xVLsc8Bzr6mN1j9/+Ol6mJxwOtsKJdJurSe3/x/K5BZXPNFrFJfQ6qgbki0@nongnu.org
X-Gm-Message-State: AFq9FYLscoBogyWT5xVApEzfup6eOlO58GjlEH8KbPnPGFuoFc6HK5wj
 /0T6HrZ4QTff4xU50hqRimNXLWFcuDT1hkezYW4rOOtPH0q87OKipncun/dmJ8R9YrENrSikIjt
 e5vjHUGOXHh5I4FJawaQGLfcxTcTR1gn1I/Ke5mC9IyOXKoxA8foh71wcmQ==
X-Gm-Gg: AYBFou3eAJF8dy0UVcXuci5CbSYNyXC6wlY52/k0rmGcXsfiLpxSu9AkTi+4bCsBW02
 maK7LHCaV1AAxGMq9Q5iTF4jM6QA4aRtkKnBzgMXqcUpTrll6jiQUtA8Yh3ThmwgL7wkkrzknPZ
 2nk1aKe9YI16uvc7fh3JEkd6+X7LUYVJjvIt1N2TsK6khhLTQKVcSqnQRiQ8Gk2SeSw+eDlRjbD
 nf5lS+3w9AYqYYErseJq++MxOccd4/6aMD0YpZ3O0DBBDgwbrMhL72aFIbfTe/KtQ9qtP5E41Nr
 dxCA7TEb7HzKBFrAKoS40bwORG6E1I+IZE/ZcHWwT4lqnarZL/pixJpJuFPQ+th3F64rtvImCho
 nYvBkbM4taEdCSznO1qgLDxJyBWGjj1qsk36nA8X4w0iozKp7rW667tg1qK1rraHF
X-Received: by 2002:ac8:5a92:0:b0:533:340e:7483 with SMTP id
 d75a77b69052e-5359f488e55mr175018441cf.5.1791818646796; 
 Mon, 12 Oct 2026 08:24:06 -0700 (PDT)
X-Received: by 2002:ac8:5a92:0:b0:533:340e:7483 with SMTP id
 d75a77b69052e-5359f488e55mr175017911cf.5.1791818646307; 
 Mon, 12 Oct 2026 08:24:06 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b76eea2sm81168561cf.18.2026.10.12.08.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 08:24:05 -0700 (PDT)
Message-ID: <c96995ab-d5e5-4e25-9ac5-26f518aac7f5@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 10:24:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] meson.build: add hexagon-softmmu to multi-target
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-12-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-12-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfXyKYRj8Gp170l
 0hwvtBp1NHQBeaoH9J76fVGAuOeE/K7FHVrQc0McFca0Vnf/UQ1H5GDo/aWxwify8fNl4vmuRoi
 9v36Pc4r2FKwd3rbwK8Vlsj4CSAdYQA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfXwJqoSbK+GRgZ
 3P6X6+IN2Njqwh6BIjRbTQFsmwZWjoBOypoV87VDe7Wx22Xa1nw/YEUbhArWof/8v2bS1EHulNx
 fUz4i+swAKvV0H0wOnAxetgTaA4DadAN453yJcXVAe1CGm2rBhR3iHS087s4UTDtfbYVsNz/es7
 N4tDEXQmwAjdB9hM9a58BVtYx12iHjk45T7Htub0eUZ2NhxKRU6Ao/8mmTg2uHoDu1zvJWsyx3z
 UuVKpfhM6kFZ4Pmdx9RHiic9QrV6Fb3i0dZMWXkYbUEpENdju38s8egvi0gvs3l/HvQRoE8ZNXG
 HK+d/0lOw4ggodvH+jEoz9GZcinpmxg8o+yDINAehC8FMBEE3QpZ/9/++j1woHn0pLfb2fAC9CP
 MqWJgRFpPKS4z6JROA3Tvw8ksQSTjpRDoONFwR6Xb2oqMvJHuedNruQE+zFH0xwvhgag+uTlzum
 xt2tTdbEmE8JV75vmuw==
X-Authority-Analysis: v=2.4 cv=C4p8WgP+ c=1 sm=1 tr=0 ts=6accfb97 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TdCweVQKI3rwcFZ9k6gA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: wgIx6bFX74T5dtVs6nsn5tPU5yLXhFYZ
X-Proofpoint-GUID: wgIx6bFX74T5dtVs6nsn5tPU5yLXhFYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120061
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 10/9/2026 5:52 PM, Pierrick Bouvier wrote:
> Now that semihosting is solved, hexagon can join the list of target
> compatible with others.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   meson.build | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/meson.build b/meson.build
> index 48da6cf3e6b..367f3b296c3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4273,6 +4273,7 @@ multi_target_supported_targets = [
>     'alpha-softmmu',
>     'arm-softmmu',
>     'avr-softmmu',
> +  'hexagon-softmmu',
>     'hppa-softmmu',
>     'm68k-softmmu',
>     'microblaze-softmmu',

