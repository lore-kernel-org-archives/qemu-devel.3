Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FA1C55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX74-0006Xj-09; Sun, 02 Aug 2026 10:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX71-0006XF-H3
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:24:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX70-0007O4-3w
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:24:23 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6VRq2009660
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 foj/7HUB86GbO3zNQIdsT/8B70YKda3puVp2yQxR794=; b=e6S/7OJ/5gmpL7hE
 WFPR0AIv7E/gYQ/IW1tOoLpCDGaorSxC3e9TjPpNRDxOve/PY3HaHn+QoIP4rxXI
 ed19xYq9Ml6/TfCelqHKkhyN7kv6V1qqZhSGTZiMxPwCcquXK4H0NlGqh9NIMR7l
 klHylVlYd63DY8IgzbjsgGGZ4TV5+a8CFl/fyB2RXbTfSiiLrodZrkYM8RI1Zfkv
 5uUOGnrAfSMWta9jQXNFQc/UCJ4QTiyCdsf+L1wQIZynDNZsn1NiAkOA+h7rmwBK
 1DiAN7LtXFIHIbaUi6xww7H0l4qRYVb0Asir16uWaXhq6k/KxIQ/MYdN8m4Smm05
 /MCWGA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8qpty2g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:24:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5283df62d68so23916971cf.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680659; x=1786285459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=foj/7HUB86GbO3zNQIdsT/8B70YKda3puVp2yQxR794=;
 b=DXdx5sZAqz76g4Fv3IqX0UQWgkEnI3A1CbabRu73grZtG2LzFwsVWcY3CZiHruBAzL
 XADh04ARkZX0Vpa/yWCTudL6OmpC+hOsdAunj3SGO0yJ2PLKcTdGbCJKjWLneY8u7BOh
 wJKwtjhEZCstIIZhezNQ8PKvDzi3dTcdJL4KCzLStK9NJYvBEKz1RhZHNldFmB6J+SoF
 AYma38wxPogdjPNwgFbVqNo0dh3qqWSoa2ThE3kHUDeS29+K/6iebVp7cmqPTnSGHQQO
 7fQEtwQI1ut78qH5Gtk6R0oFqgE/dof9UF+/fG2Xtb77yId7BSBOzBjBTOPmZSv2Lbql
 wdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680659; x=1786285459;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=foj/7HUB86GbO3zNQIdsT/8B70YKda3puVp2yQxR794=;
 b=R3cssMrqhIAU6W7MC+4bJ4qLR5QAH+UA1OqinTM8Rp/eR7/5WN8LDFCzgoFLezMr2A
 N24NtXkO4YljUexAXgZ0c7BfmbIAJxVpbg9X5/OiTGeiypBDc1O8RNouNpGy7wsM4G1N
 FmixfGVW3KcWVLITTshrL5Ej8J5LK19JeWQwOC/xWlQZ4o5mS79XxEYI5ej0XZs7DRer
 73IBYzjKNnE1EB8BrgbNYOhFCEZkoRmlG4fAQ1mt6VWDdsG905Qvot0UOt/jzB1H3zME
 coT9Yq11dB/4l9sKC4R2GSWpcc07GbdCuUubioAhFFoaZcsdPkvwK+t400XfEZeBdRWF
 bZeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcoNEeELt6l0XulXeuCVSBeLUR/sm2LZkNJxT0AOWUZa/fPGLWd+46uDF+ULJmhB0Tg5fkcRR3dF2f@nongnu.org
X-Gm-Message-State: AOJu0Yz+WnClO2rk8m2ERhFHU8bpo8t1JSRt7zIjcu19dF0Kn0N9ATtz
 zk/URK4Tfz4yPszuRQbizFOqlkkVyuN0sXjgrDpTzzlFpkIxPv+yCcxNocm+oO9hvNFmH8OQVma
 qfscO9Hfad0gHEAqfQkaL9HiP9GM/rmUOarwzQFEPtcCNLnVVkxVONK1V3A==
X-Gm-Gg: AR+sD10+KIb2NjGq+Hsvm1zxBqx/JAqzkeK7/iSvNM2HbWOwRw4XZDPdeXQwEfMc/+E
 Putw7zuUAo37go2vShylL7Bn+K6G/a9DOdvMsjA6oivc+wFsE0s1x5pBMVJRJ01GtPowoewipJg
 2sh2tUP7VIEpCdBg6zBHeFRokpvJViXdrmx5MkefAUE6Wm8fWsK4RC3kKOY/DeWsNuaKwriecYz
 lfFR35C9WEky3ZZaOzJieq1C3f40Q+1n9/m2XtySViFguuP/6lQUUft08SPX+laDHa4Fi9EKzWx
 DCIUia3zu0t4jv5iQnWWupUSJbRdlj6rF9Dx0D7gVo7RdN2eWD9aA4RvSL2bPKsB5W+O5nW0aFl
 a+YydOfh8RTh9QGMO0NPBmnJD7JUrw70UJj/3OzYsnEG8q/IYqbA=
X-Received: by 2002:a05:622a:c07:b0:51c:17cd:1fd4 with SMTP id
 d75a77b69052e-52b56845401mr144592631cf.41.1785680659094; 
 Sun, 02 Aug 2026 07:24:19 -0700 (PDT)
X-Received: by 2002:a05:622a:c07:b0:51c:17cd:1fd4 with SMTP id
 d75a77b69052e-52b56845401mr144592161cf.41.1785680658689; 
 Sun, 02 Aug 2026 07:24:18 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d17f2sm27825355f8f.2.2026.08.02.07.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:24:18 -0700 (PDT)
Message-ID: <fd0895ce-8474-4e9e-8a71-268069b7b993@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/arm: Rename isar_feature_aa64_idst
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260724031123.76597-1-richard.henderson@linaro.org>
 <20260724031123.76597-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724031123.76597-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyOCBTYWx0ZWRfX9/HjkzJOwGXf
 geYMVyUY5pkNv/P1oxhNHOrugKSlcTBT/sju8p4fc0u3mejS+9+cHvmNAQWK4yMEsDXIore4p9o
 hZIWecvpcfghs5BYttTmHW4gdM+C4qkcmES5drtEg+7PL3tk7Cds+G9DWSxtMvWdMoNfhViUVki
 ceYGtkzjnJRqv6/yEYzescLnz2rnNvufUH5ePGLr148ZwWNWg4I+XVeFd/Z0Omo0vC66BWebYBY
 jwA8ZJfetZI+IsoX+aVTud5KuYlW+RmGYjM5FlaWvNJm5JfnVRquUWkE7KfwrhYSZD+WE8WMGdB
 slLfK8q9XbOhXkEoomFCvfiNotjr66hVtiTfRXmnWQsZwP8cVPFWC40weytZ9bXxuCYF/V5fa00
 LTky634h150qcXOUR73kdmZa0kqr2BvOvwCw8bN7ms3x80ZS6v20mI3vIfzexpY/3M3hCE3DR5/
 BjiSifkXwubw8tVY0Gw==
X-Proofpoint-GUID: D6IoAm89Y7YOTih0BMPPgfLequ6acui3
X-Authority-Analysis: v=2.4 cv=MpViLWae c=1 sm=1 tr=0 ts=6a6f5314 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: D6IoAm89Y7YOTih0BMPPgfLequ6acui3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyOCBTYWx0ZWRfX9RTymOUBAK2A
 dISCo9CBu8JwvFfHuBLA5aO6skRase063dSOPp5/wmvlPR+fTPARfJ2wsocTTD/klgu74W0zs/B
 3rWkvCdKFLUbS1j4k0UfRXo3QauAR2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020128
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

On 24/7/26 05:11, Richard Henderson wrote:
> Rename from isar_feature_aa64_ids to match the feature name: FEAT_IDST.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-features.h      | 2 +-
>   target/arm/tcg/op_helper.c     | 2 +-
>   target/arm/tcg/translate-a64.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

