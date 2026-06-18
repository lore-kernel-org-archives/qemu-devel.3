Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D9BCD98F0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waMEv-0005lu-7y; Thu, 18 Jun 2026 19:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMEs-0005ll-IY
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:33:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMEr-0004WL-29
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:33:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ILsI243060238
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9cfFdYROfSOZUWgkKFQCFcneJqG4ler9yQrwyiDyuHg=; b=D6pNsjclpK8PkVEp
 RZ1QnQL3VvE8lZjhE2bo5YNI8tNHem7S+enYnEo2w3kJG3yYcrCEB4M1sD9Bxgfy
 0URvXSosjOBQEXuLjvn2Q0Hs9adLgO97yI0N3u7k/xMKaHr9YmoyRKA4x1xamkDt
 NLYIFPiarJs9NOs5Ms0wr0IyWkK4YjOeRNJVxxQI+JHcfMx1AssmXHZJWLjh5t/A
 nIaEBOoXtdyveH8Rkw9KThVFMLkmCUcmGb1Ua93Njd5BMZmRrQpADJYo5gU9kpAm
 u3RWhDUMX53RH2XKmqpt/zwqJzEOZ/LgO2nFwZasEti7KgaiUFWJpECSBFK6SpFH
 uriYyA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmtj9gx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:33:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so2929137eec.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781825613; x=1782430413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9cfFdYROfSOZUWgkKFQCFcneJqG4ler9yQrwyiDyuHg=;
 b=UyfdxKNs+4TK4Ms9WXLB6SZsQNKis8YHddpZbLmmZbFpKPW+joxU+CiMkIx5HBZ7Eo
 Ao+iyGPZ9gAqLZpRpXJUA46H/DNHp2blYWs1BoyqACcyydSb8M9rmO+wVz9nGJ+PeTGt
 2jDsPdcmqsUdNgOtRUDiSKOJ1uauSkZhWzvZRoiLgtURwFi/bRJR0Li77wmIe/uWVx2T
 yyKm73rU17Hn3zWFyw/gpwOGg9tdVSUU0TJ+tCVCqUAJcgvRdsGnZdTNj8skgVymCeQG
 oTpZQVW5nQaN2wFNluWn+Lv2ylN2sRH2qGur+rP6wtIcpPaH0EPnaJ1p2YCQGE/FcwaR
 DZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781825613; x=1782430413;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9cfFdYROfSOZUWgkKFQCFcneJqG4ler9yQrwyiDyuHg=;
 b=oKOqF/jDAgMrn6uGWegSrHoRHbfqoUEuTp63sQcrftDsdYEKFm4lEqmsyNv2Ue9Uqc
 utPB58wrsuVGrdmcQRDYaMPHQdH3JAGTGyv4k8P+7OGwnok9h9rDoFH29lf/vzbecPYs
 slfJvpe9qIndeQQK43FDeH9z2XvdDTdBLMQF3ko7ANO1aCoRbhuQjoND+VVlqd27qw6J
 5wX4dZUd9GU+pmgTxnQzDpKB18Rt2vtFoslUIlufD9fZIsK9lZFm4SaMQvmexS5g8k27
 fOwspfxE8i30n66KWNGgXt1HUPDdHQxK0X03h9bPtQq0CsXPD2NaPXZFS1y4QzUClVux
 A3dQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lr8Y3YRG5HQrTv1MDCfqYbJfpWcEnZFI372Yks5o13+yFJVF3BbIPpgyLMenjwLVHW0co6Wawpduo@nongnu.org
X-Gm-Message-State: AOJu0YwuK3yWYMgPSsXPynAj73UFLaoifl54TryVN7AbCHAo9tQNTUZs
 Oi2fPRixOXRKodU91aSg/KXUlOTW+Mg6eBUxFE1SAS64IxHIeLEQCVTdnzjdoECziTisHMMxBlY
 FQve7Ww+6XeFifjKHPvde0mnmosnloGTLX61S0opblFjOeJ2FTF+nym96EA==
X-Gm-Gg: AfdE7ckeGbEoQ0LLFU0oX+3C6YNxqNW5q9joNtjPqajl4TvOQf2dt5f1+UWsHGSinAn
 w/FCW954KcBwvqFlvf4jCNco82j3B0tc8wXZqJ6q7Y1FRYE/a9ZFyHyXNFsfH6CoOoLOXEGj2Kl
 I3H5gL0k7P9ydz/dRZxHqppX2e0CwH/RNTjit7nu0Ma+DkH4BPadGaRySTknk7Xi+QJHOJZRpmF
 YUVLMTIL0glwsKkqmoRLwviPAIwOgh30OqUmYepjRfgO7b9AUaZGcdMQzyG5go8n1ckoNvkgUu4
 frlzdmLCdnwqyji8QG1NpZh/APCJY7iwezdmKIURcgTShZaw2MyN5Zaip4MH+6EAVmOe+iywTxH
 HcCdpkN7QJpN3y9qZVfTrBdF0O5HTzTAZOOJ/4sP2zpkegus93sWSJZr6UDmTfCdFOn8T+5Rh0c
 1MvoE=
X-Received: by 2002:a05:7022:f68e:b0:139:8172:8371 with SMTP id
 a92af1059eb24-139a4eadd4amr84065c88.14.1781825612962; 
 Thu, 18 Jun 2026 16:33:32 -0700 (PDT)
X-Received: by 2002:a05:7022:f68e:b0:139:8172:8371 with SMTP id
 a92af1059eb24-139a4eadd4amr84042c88.14.1781825612479; 
 Thu, 18 Jun 2026 16:33:32 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139a364a83csm381965c88.11.2026.06.18.16.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 16:33:31 -0700 (PDT)
Message-ID: <cb5c388b-fbf7-409d-b1bd-bbf0033426c6@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:33:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] plugins: use int64_t for the syscall filter return
 value
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260618082426.790315-1-functioner@sjtu.edu.cn>
 <20260618082426.790315-2-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260618082426.790315-2-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIxNSBTYWx0ZWRfXwkiMENKKefIW
 kPZFfd7Hi5uM4rfu27b1+/yq5sFHHqEasSEtEFsBEULqXnvDGRysXzDJ/mnwfDrpMA0xUTarHL1
 ioJCrXYoFV2OUe9rfeXWL5macIQTyi8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIxNSBTYWx0ZWRfXzgnIpHBP50DZ
 WItdALiiqUpi58IqP5ue9Pae9Y0XnSfTGC4pulEmJHGuTU7NW3nksqNfYSVIobCW+dDEd9sT/GO
 wxZHHE2Zgnsu/EJ4h7MjfjkTAFaRlddxKBeDw9ybYzuXZ8DEVkNXxp5V5CpYlupBOd3BJuL535s
 FaOi+iVn14clnROtkOZZCtakxHw8jtRe/CW1EX1ZdIkFWgTScRGmoUKmgIcKqijyqBtztQy+lFb
 yTPKWG2g28bM+qYWY8sCcdFvoIsB8ZG6YU8gTSHZkobbzxZ6/dpkgMCkM8/zGb44V1657nMS6KE
 /wmuJWzFU+twj7aWlgIHHgyi7DYV5rCauP2bGL3rl9rIe7dxCO1KM4ikfVF4Gc1lDDRAZ/aO044
 pLQWFSF3bB44uOmrkeVB0/HDszN+WzuoT8TyeDglKJDT6YXGaAFFCfPTsekzGgd0gDmt+ZQwKTe
 wEs9X1SG7kuelhj+FBw==
X-Proofpoint-GUID: 7XHcj-TcnajN28I9E5HyIF38hC7zBtjp
X-Proofpoint-ORIG-GUID: 7XHcj-TcnajN28I9E5HyIF38hC7zBtjp
X-Authority-Analysis: v=2.4 cv=OM8XGyaB c=1 sm=1 tr=0 ts=6a34804d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Vf1TyO4ObYaWejyBN_0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180215
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/18/2026 1:24 AM, Ziyang Zhang wrote:
> The syscall return value passed back through the syscall filter
> callback is semantically signed: negative values encode errno codes.
> Declaring the sysret pointer as uint64_t * is therefore misleading and
> forces callers to launder the value through an unsigned temporary.
> 
> Change the sysret pointer to int64_t * across the public plugin API
> typedef (qemu_plugin_vcpu_syscall_filter_cb_t), the internal
> qemu_plugin_vcpu_syscall_filter() prototypes and stub, its
> implementation in plugins/core.c, the linux-user caller, and the
> in-tree example plugins.
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
> v2: rebased onto current master. The syscall callbacks now take a
>     userdata argument, so the filter signatures were adjusted to keep
>     that while changing only the sysret type. No functional change.
> ---
>  include/plugins/qemu-plugin.h | 2 +-
>  include/qemu/plugin.h         | 4 ++--
>  linux-user/syscall.c          | 2 +-
>  plugins/core.c                | 2 +-
>  tests/tcg/plugins/setpc.c     | 2 +-
>  tests/tcg/plugins/syscall.c   | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

