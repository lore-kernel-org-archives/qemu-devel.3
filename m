Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAAEC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TAr-0005Dp-4f; Tue, 01 Sep 2026 14:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1TAp-0005DR-Q6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:25:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1TAn-0002kN-Vb
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:25:31 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681I2lGP3531028
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 18:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QPYaCre0o8Gg6C0cB4MIfcyfO7m6cEz4b19e8r9VvyU=; b=jW5QnHaA4HH3a2E8
 gUSJ+2pISUkdteKjIWzf5B7quwlOsrerqUIsU8B3o5QjgIcZ8zWGSZJgdS6eAyuu
 RS2n5L23P0h+abEVGdR00GMMjaNYxQeJVK5jSgNXjPEbLG5Ql7F43HdLSZRzvZME
 ZIYJEIJ1U3tAJU/rv/Mw/W8uM6R9jnhLcKa7mN2p5E6TjORT7DRIfYxTx40kaRDL
 uHdqK2NVP4Ag2QXeM5ZeALSkPe13APEvISSkl3NPxrnmzYsI7WKtT4Bf4EG/KIAj
 yXxIyea1PAn/Wn01XZJ+Ix/KIbweeZr3DjhcnfFVgzTTjEA3IIt9rUnLj0KbyxZc
 ExUCww==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge3n0r3f6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 18:25:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso154303a91.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788287127; x=1788891927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QPYaCre0o8Gg6C0cB4MIfcyfO7m6cEz4b19e8r9VvyU=;
 b=JQsG9k3kXk7sA9dr3TPoW60jfGi3gx0Ffht3gHUKyZfLA/klMnaIO50ud3vawVKeK0
 RkrgkIJJ+wxHj7YCaybDXeSfs9M+9OkWVdIJ3/LLgTWubL/N2XeMXwaYNfhEzUTiNepS
 jNzMpj+vSCJ/Wla+K65Jy6bnxIl5P7+xY3NBt2MMZcBVcQD3JMwcMb3uOqP5y2/7fAq5
 S8os36OFSujrEtsMQsO6qh4sEwUl+fZb/+K5BGqDbTrqsrh8L2aB9lD6CK9dKBDKpmwH
 5JzCxKPJA048lNJKrxQAyJMwEEcAtolNsLAp7tmlNP7kQjMLOKzO9q6CpICI8OgKncRu
 8Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788287127; x=1788891927;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QPYaCre0o8Gg6C0cB4MIfcyfO7m6cEz4b19e8r9VvyU=;
 b=isFT17iuf+KDpH06q88lOsuoe9c32CAb4o1I6cmz+K52oEkOdAmY544jGLBQ/TUo0X
 m9GkVbtocSxBZtDRijnUS3ParUGqtEN0nKCgevAXYCLNJ6G3tIUpqXB//rAfwW4eg6i2
 YCkgxLcJXFtEyrk55UVLmpph9udhxLnrVrr01K5XbFAsr3NcTHt+r7o/r5B7C6Q8k0CW
 f1ZhZq28+ZosChBP4QE7Ox8PiFPCL24lrhHJEeaQf2GoWddWPKBQckRY9eR3XOAXXV7E
 picrtfP4BK96qAXKCAsASS53h980BFzB/wZdjrSXULBzlcvxV6cjUZfkSCHrWvB6xgW2
 ChTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzv9cOF+Bs0VWyy/5qajbskvyiIwGWUtlConBXRVi9mzRUYVaABC2FNqRGYrhLlwy3MwXHtLJWFUVQ1@nongnu.org
X-Gm-Message-State: AFuF++myC5Z4/2fZjUVbf8Lcj8eJiZIsjLjNHpqF1JaTwA3Cq/4XV05f
 o+4/6A/g8rl0LccMhXklsDc82O/MFn+PmMKkDp5C7ElgjKp+zV2GBrn3DXfyH9IrxsvS65H9A+0
 +LCRbcg+hZiRx5xVx44i22W1kgdLt3aVE92SFmSS1CKRZ1SCiqQDXh5Rc0g==
X-Gm-Gg: AYBFou3sMMzjgGL0x6IPUcdBQkHWGZFhOvBp25jQ9t8H4wR9ll8Okh7l/+QkUmSJp0f
 vchCZ9hnmqiYSnlzkhOv7ZsdPwsnLu9v7ZmLV4akELsasEgAv+/X7ISYOK+v1as+y65XpWPM4tC
 nYDZXz8UbLDwhf6VYyaaTm+axPobL6tIe4hYFwbYSH4RIJ6HTZhAYOiAs8VJc58hEoSfTYgucfT
 8mcW32SoE9f+VRDbR7V5I0weCky5vKqeqkyFAE+V6Z2Tk+tpPiQJqQWr814+vckkLr4IafPtM1f
 hMOwhoPPlQdyjxIuS9zU/NN0wnI5eC1/aLv4gE/yMSgu7OBKqVQbuwXo29jq/ecvhdknqnwgKWR
 xxe0ClW9kkgUyGcLuqGhUjTZlnRrgtF1fl5ogP8w3ZMb+HxkhP5+YPQyXepjGR6QfsAfd
X-Received: by 2002:a17:90b:2fcc:b0:398:9be9:ab8f with SMTP id
 98e67ed59e1d1-3989be9aca2mr43920393a91.20.1788287127257; 
 Tue, 01 Sep 2026 11:25:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2fcc:b0:398:9be9:ab8f with SMTP id
 98e67ed59e1d1-3989be9aca2mr43920306a91.20.1788287126717; 
 Tue, 01 Sep 2026 11:25:26 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-328713b944bsm42158032eec.27.2026.09.01.11.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 11:25:26 -0700 (PDT)
Message-ID: <d88d03c1-2df7-4de5-81dc-f55bdd1b2fa4@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 11:25:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] target/hexagon: guard writes to unimplemented
 guest registers
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
 <20260901173353.200474-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260901173353.200474-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE2MiBTYWx0ZWRfX2etHGSrfuOM8
 g0uiS3RWLtPFxqxHZDfQ6Mk3H0WEtrDffp77sIgso29sr79LqKS1K05lWXS72TWfQYE5tv536qI
 jLn6fh+4KA1LfW45S/ENtNMe/aSRbuvp3610lF/DQ31lCMaAEoDQfG5VMC2PIFOIlL0YYkJk0uR
 J64nbcuDVsnmol0P6Kdq565yMls99mxVtm6hPVXwLKfaWgBjfIJkBX7z26biYd14BcZ4eOCVnlw
 TNp5k48GS1PnpmcMwmqXNQGvrTl7FC6i9Tqvz4p1Wc06jzKfcQx4H2cgTGkyDGVz+k+yUyKl9P/
 XSzjsWQb8VRt/LSEcNw+vh88Mi0jlWt2hesflRJMeulCPXSVcKcH5oT5AhUkvoJ7uS09p11X9xg
 9M8KVNBkpsLY3ituFwzY209GOiL3lxwKgw3sR3+Hke7VqanxbDMgLzzBuodrYGlcDt5KKg4KV+U
 1HvBqhgY/2L98QMweIQ==
X-Proofpoint-GUID: J2RFmDAuRNt1drgcLgddvCTonb6ZfX6m
X-Proofpoint-ORIG-GUID: J2RFmDAuRNt1drgcLgddvCTonb6ZfX6m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE2MiBTYWx0ZWRfX2isRlkueHiy3
 Lfkgou5ZbNRcnBoF3V61quA41SOzeHT7gUB1XZobq/bL9C12cs+iKq8Qi54zRZ5ZO6Vw/BQhTvf
 CYJCFzAPHziaVHU8XUASWN7N6gVOrXw=
X-Authority-Analysis: v=2.4 cv=R9oz39RX c=1 sm=1 tr=0 ts=6a971898 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=EN0u9-qThA6bqHlYfB0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010162
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

On 9/1/2026 10:33 AM, Brian Cain wrote:
> Guest register G4 and above have PMU-ish features that are yet
> to be implemented.  We'll skip these when we encounter this code
> rather than fault on an assertion.
> 
> Note that the generated call to greg_writable() has the side-effect
> of doing a LOG_UNIMP for these register accesses.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h   |  4 +++-
>  target/hexagon/hex_common.py | 18 +++++++++++++++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

