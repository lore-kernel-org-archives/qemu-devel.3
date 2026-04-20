Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39DBF5A8A3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 17:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEsPL-0002p9-S9; Mon, 20 Apr 2026 13:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEsPG-0002p0-TC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:27:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEsPF-0002zt-8S
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:27:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KGjZoK2980973
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 17:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lx1lADZNXwEIXK2UAxMev0zG0DR2VIDxTkEbtTUoyh0=; b=bWBIDb3Q0Sn3DC9q
 Vg/fQUgETT2ZytUZJcuB/Bb5wgo0nP4DFa/PcW7BaOR4puDpS+rfoROn+a8aET1R
 G1LzhtCuGidyrTJ2W8UbsHPqLlswB8He8AVo2Nc7KyDBoyEfTVZNBVbZIAkAu2Lz
 ufEoBFwnfwNQ9igp9tKxKOsZ2e8gy93JsxrCGB6vSP7LwjvTfzVUDR1OqSfgDxml
 gN2ZMCN9glmFf538V6bI+7c8r3MtOmBekPHPHrzkqb7OWx4Vjw0Ny5rWkj/5Dsxu
 ixaF+5Sat6OeChAiwKthGL8X0sMfE9mqfyt5aauNyLiDp5OlJFAk6WkdqY5RUbFf
 W7SS6g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnj2psmnp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 17:27:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2da19227bc1so6347493eec.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776706050; x=1777310850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lx1lADZNXwEIXK2UAxMev0zG0DR2VIDxTkEbtTUoyh0=;
 b=XbjCJkTsRgJjG1OJzcH2XsYpr0Tva9IBPXa413qRkLHrCL6yRgvero7AWoycf8VL+8
 LUUEE+hzlrGAgmL8Z8E1Y0zD87q8p9YG2jeUIWC/jj44sfpIE7lCd5qWSUQB4NE1hb2c
 Ug37OHq8k2W6inYSCcvyoQLeidxhduhFgod2wQun71JZeKpohr6edNTImaUR9vZg9DgT
 FFdG0nQTy9lM6RN7zt56jAZGGRDdthH8HVpsw93N6UMMTeqNq7sHZs36weh+m6NJ7tDE
 djQp9MtrisXUC+2Gw54ql8KMTeWtLqaVn8oPl/cV9iBK5cJL0Oe+nsvQTxnd0GljefMJ
 dZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776706050; x=1777310850;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lx1lADZNXwEIXK2UAxMev0zG0DR2VIDxTkEbtTUoyh0=;
 b=gzdFHChGDJytH8WdZy5USmdIFANc4FlHVeEqM8suYZbw6tcoRSTrZm2SOLWgE/Q0bC
 LJ4mXRaXdvr9I3UlnGAbxad3Z626F99GrWqppmMx9fDnf2y4Pnv7od3auu89iOgomB3c
 Lky+WQzemBYgio+1SJm3oJpLVzyiWOkegmQ0VNqxOi4/gm+ubtJKNQeMbn5MHDSYfJdm
 FBsOU7QvwQ+6raBrWGt9jN3LLlXW6YKQJs5rA3d+TnmbV0IPkwP5Ic1ms8hihbdbYXLK
 6kfbBdruga43sXvGnLpjWPm0pA6vg3sOuNBfkpOU7WCmHSaB7Vky2g4qdjHmYcaapzKj
 sxOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KP5QlvoHYxN8yF5AXHb83OQRHNd3yA61Kt7t4ZD0ptg/kKB7WP7sJLZx8ITBeiqm/HDzqE2XSs3Ff@nongnu.org
X-Gm-Message-State: AOJu0YzuyiGq0mg7fPB7/ZEGzsau2c8qlWl9A4NETvFvcPyXQaZ6yG/q
 7/G8Pp3ir/33RfsZFQPilver8tehZaZMZIGsKOZ78BHA5hCDoE/k0PGh/rHSRyVtqYHc+9XGnRW
 SEOmnlFVP+mIwVCmdvHmxho4f30ztUTtzK+c8S1aBjO9Dp4xmOJSqECJj9A==
X-Gm-Gg: AeBDiesmFeN7Z9GWQe9khi2GkRRzFAOhnkip0K9VxL9ZSaluCIU+fyZaEYyEGIkZrf/
 4rWPtQ7BOaq6szShBWeHcbk+BhNTk9rNrPVwo3v1WeX8b+idjVJz/NXwaPrajkt6fAHnhJlsPeR
 UZsjso8l5zveCeCQzUfwY1O/ypqR/PgI9cN8+O41N9On2CBBUO1Mwr/p6mbHl+1vZ0aJfV7Ixzd
 94L0g7YmgzeX006SKFVth/++aoxNJd3sNfmgZ3vVz/bs9B1PUUkEX8buCO7eHHqJmt8LYZB2fZo
 cnyciRss6LC80OQYo+Xd3YtiuuavorbikZK9nVbJb9LikFqTcNpMf6PzjfS8genTI7O7CeQd7VA
 5j7q3Fje2ilbjdpih9V+W3J84UWKhJQ0wFgnpQa0ExnK2n4tdKEtvy44BXGeVQt2BIC/SXbzxeB
 6Gd0QNg0eGGuLtqKeSxhuT5eFS
X-Received: by 2002:a05:693c:2b04:b0:2e1:f72:3f2a with SMTP id
 5a478bee46e88-2e4647d03admr7474267eec.4.1776706050106; 
 Mon, 20 Apr 2026 10:27:30 -0700 (PDT)
X-Received: by 2002:a05:693c:2b04:b0:2e1:f72:3f2a with SMTP id
 5a478bee46e88-2e4647d03admr7474230eec.4.1776706049580; 
 Mon, 20 Apr 2026 10:27:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53dcb487bsm15531177eec.31.2026.04.20.10.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 10:27:29 -0700 (PDT)
Message-ID: <5b1c0f7d-0152-4d22-a0f1-112c5feefccb@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 10:27:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] hw/hexagon: Add globalreg model
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260416210305.2255579-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Hp0fisSbSbsXZEFhBEEvwXCmGgqUECFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE2OSBTYWx0ZWRfXzWuiKxRBMKyv
 Uk6ODNSR39X7zkWt+H/wpZaXnRHAT0B5igMZkXBnjPL4Uu6Xgxq57SzqQJiFRQiY9ToKSa+Zho7
 mPGMfGzJCdfRehszhzK6UnJsfQz/wUs/0v5YwkYoRtMWj288QKED/2WGJ0pGWVW25IA6c5DDW2l
 H1T/49P4P0JifWiuzEE/GkYIdu7jmZt9yDmEoSwmllyBryrSGAZRLi87unhE4ymcKBr5FK3yU+D
 ICZ3b6lNPqHSePqzXEEfxC4SA+gSWnuvv12BfLIoHyGfCdWXPtEt2LIxRFtTNxejOlpgc8xL/8+
 vUXMsxLAZucQ5KjaxuYWoOnjtzK4ewIw5dBUIOpJD/gJhW8iuzB6pWgrvaCEMKmo2jB29lMbscZ
 nxJewT2CrYuMJo3HhAWM/gxIL32yc66Zry/lhzrinU3Ta3qu7PnJQN1H2zFEp4ccjzT15Bn8/uO
 tA4aw9UX2ruuvXJp/pw==
X-Authority-Analysis: v=2.4 cv=XMoAjwhE c=1 sm=1 tr=0 ts=69e66202 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KZe48YFUlJDY7fMftiQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Hp0fisSbSbsXZEFhBEEvwXCmGgqUECFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200169
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/16/2026 2:02 PM, Brian Cain wrote:
> Some of the system registers are shared among all threads
> in the core.  This object contains the representation and
> interface to the system registers.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Sid Manning <sid.manning@oss.qualcomm.com>
> ---

> +void hexagon_globalreg_reset(HexagonGlobalRegState *s)
> +{
> +    do_hexagon_globalreg_reset(s);
> +}
> +

Where is this function is supposed to be used?
Seems like only reset_hold mechanism is used.

Regards,
Pierrick

