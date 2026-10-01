Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B9CA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCK05-00017X-HM; Thu, 01 Oct 2026 12:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCK03-000173-Vy
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:51:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCK01-0003cJ-9K
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:51:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsR652267821
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 16:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1EC1Zmm9ffg5+j3mLvgjjCqQBv9SUjaEWLtb4hTneL8=; b=mj6/1HHlzzR1Bd3x
 lf6T5Nr0ZL/V56pK4C3H8oHPVz9EUDLl+WT6fpe5ioLFiZlGwCKHNLJKlpgwNkb3
 GibrIOMpu5EreBoLiv7ejQmx1q33Vl+cXedXYs8toxYqivxz/gFEHg5+uI+NDirW
 TOFlZPoGS70J08R8UHkWn+eA30igGxo1KFpaPQsFiM3MjzTS3jPzv57FHGUdvte4
 8HDs6/uagPUZ0rsUKsVLGYVkuckZapFvRKMgMrx0alq9CVEG9N6XJuJSU527LhPa
 67+veKxAB/yQGzw7/HtFyzk6mb1Gg9AQPNrQ8be8gGdMbcZVL411IW1Hc58FPhnm
 cAHt0Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1rvq8un6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:51:11 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14383177746so15579801c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790873470; x=1791478270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1EC1Zmm9ffg5+j3mLvgjjCqQBv9SUjaEWLtb4hTneL8=;
 b=cMxShBAW+Wzy0j6NV8YJUc6VEmZfqiQHwSzco2kHPtibEpfGkL3l5coEiwU6E6PRId
 zGRTDK2VZHq1A3weft2RA7dIQ69l07a3e1AjOzyUVEftEna93oUrE22Bx0YgNHH3Yu7l
 1UMr+dW0EulunC+IF9UEFbq6A7UzSYtsTPYFEZk3U64ahWuBIDhLHzfMY7ZqhqAs1j+5
 lOGUj7xAOSgeZEc9xkchFGvs8IsfSTIzYH6yRtxpVmGL6Yd26dIgOpEJ5T+54WpCHsvp
 GpqCU2aibaixC5Th6drItU3Byk6NaG3zUpiGH7/xGs0oJEGkh3xsrPwFRYfD2KqDFStV
 aMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790873470; x=1791478270;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1EC1Zmm9ffg5+j3mLvgjjCqQBv9SUjaEWLtb4hTneL8=;
 b=Ym4Ku4qK8xjckRIHc7U89jDwaHeXmOuiXacVJT13lMQkQQG+j9CrxRqpK8wbGcTSfu
 vn99L1GaP1AtFXExg8+vhfy+bLD327c3hvA1jAcuKbrZ52KD8htte8u4AOV61RRq5ALT
 8X/GII0uymZxL5/PM5t7Vsdy5mRuHMvrHovqp4EKXs36uy1IhZcpScXQrpYV/FaRunTD
 CsYwoSF9Clev/C8yRPLdPTr+oB0beOmkYT7GUcNfPs13HfCfrEopPlr5kk9ifwhJfIL2
 nS/qofHHi9ybahPm/6FPhzhu+tHWtb4mdnaKtPhBNjsTe339Hn4BecADd4AmdbVkzqJQ
 pg9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbRCsbHCG8u1Wq0T6JkscsfXPwZ3AzPeBSp8g73FNAedDLPfQm5jbqJ+sy4uI1zGhmHYA/4yZQZ1VM@nongnu.org
X-Gm-Message-State: AFuF++lJGHk1WEZh8pp+K0uNRX/338x7OJ072+ziFLEfFAuf7hw/cuaD
 3360YRdyyztja/PAwmCsmyFeb8Rn6dP0LAJIh6geAXAw0AitjbcUIBCCyXoR7Piqpzk2IZ8qhS9
 bjGGi0QNySGGP+icJsa2BjXXJyuK58GaSdHBZE+96knHnJjwN61Q+kd9PTQ==
X-Gm-Gg: AYBFou0ICB5zKpy9Ds2eoFWsFqJIR7KHxPx0+QS0gXgbBZz1ajBdVuZIoUrKmudvO/H
 aYIt0OSZ78jQoQtEmLNN9GD5j/wpHNalrffoTCL+OmHyTx3Mi04NAQBwJjZQvjmXP0p6dPupTCI
 7rvJ58jUhzzKEjUNEJ2ImUG9ALMrna0FPGvqeJbZcWjL/097phds+QdcYEeg9hGo8MgKhQJ8YtA
 Hl9APtEyyBEpAV2w4IQ5Rwkym0jCfHN509jsptzWlmPFFhTk87Ci73MvjUDxssAHMMQBSpfnI+7
 GxjZcVMdKoGlshRBv6ybfWhNCtcPFW/b0UnSGZc4F7IvfqjOdpu4+h/065tssszmnHEiv8IFzaG
 IaoLz2EHlkMpbQf3Mr3wbnjb9Nhi6kxJR2i947B4aWvBSlFPR8tWHczmg5DaDVMt1b8K4Og==
X-Received: by 2002:a05:701b:2712:b0:13e:5a50:1e17 with SMTP id
 a92af1059eb24-14d31a7d13bmr6469370c88.3.1790873470290; 
 Thu, 01 Oct 2026 09:51:10 -0700 (PDT)
X-Received: by 2002:a05:701b:2712:b0:13e:5a50:1e17 with SMTP id
 a92af1059eb24-14d31a7d13bmr6469309c88.3.1790873469323; 
 Thu, 01 Oct 2026 09:51:09 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f26bb14cbsm432639c88.7.2026.10.01.09.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 09:51:08 -0700 (PDT)
Message-ID: <374ba010-b530-4310-b20f-65ada56cda6b@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 09:51:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] tcg: namespace target helper symbols for combined
 builds
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260930073935.712-1-luoyonggang@gmail.com>
 <20260930073935.712-5-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930073935.712-5-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NyBTYWx0ZWRfXyTkKRVvCE2za
 qWU8JPzoVxr30N10S1pGJWx7yFq0USEeAOhjXD02Q3NmKHLLtH4+dXHHBhZfq7qKD+t+bRPtPiu
 uWTL7c9XG+GNKTMeGNzqPoIsiMvStqBtaBDUnecNOOyBM5uZImSLoiIUjDjALux2ewl7gX8tSJo
 rAIYAYidM0tLBRXN7YOez61HfKIXSG4PZUXqHkeMjYYgN3EWgN9Ih10/xoi9VFzpNJUBZqnnHV8
 lUz+HwiCYCq4MzYOea0+Tx3UZxv3LOqoQLpD+nV/bmZxV71lBKKpzkiQJqQKUh1zt8fpLU1DvOE
 6VIdV7DMceWj03t7vCsY1skvoG8JwmrdaVXNzPtSaOj7r6Mg4DNoverGK+mN6DzO9WxIFXHzhMW
 VzknjOJynhi/T8P4TjaaUOS/7ocBFWYv7/JWxSgJEe/Jx9/Cn8CUgwLnF76z2QF13wTr8YjSXqh
 V02+p7KYvIjzM6/l+cQ==
X-Authority-Analysis: v=2.4 cv=JIauIMKb c=1 sm=1 tr=0 ts=6abe8f7f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=ZidyKko-PBEqLHQ7VRUA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: cAGpxKQmQ9wyTdWfzOqng-hx44GecTSz
X-Proofpoint-ORIG-GUID: cAGpxKQmQ9wyTdWfzOqng-hx44GecTSz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NyBTYWx0ZWRfX82pJrBQbBiae
 0TIeLw9PWgpmBi3IDvbIH910yjTwp5X/3ThuYV8VaLa+GihePoiykF7IsxqgY4Toi8bVDBrWt9S
 HwlVYLPBM8letYnihQD9EBoF31Jn28E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010067
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

On 9/30/2026 12:39 AM, Yonggang Luo wrote:
> Use target-specific assembler names and helper metadata for TCG helpers
> when multiple targets share a binary. The generated prototype maps the
> generic C helper name to a target-specific linker symbol, for example:
> 
>     helper_raise_exception
>         __asm__("helper_i386_raise_exception")
> 
> This lets target helper definitions keep generic C names while avoiding
> linker symbol collisions between targets.
>
Hi Richard, do you have an opinion on this patch?

We are trying to see if we do renaming per helper, or if we introduce a
"generic" way to deal with it. I don't have a strong opinion, renaming
things or adding more macros and build system soup are both ok on my
side, so direction would depend on your culinary taste.

Regards,
Pierrick

