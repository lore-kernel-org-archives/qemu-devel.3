Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDD8C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4p2w-0004p9-Hl; Thu, 10 Sep 2026 20:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4maO-0004XI-1J
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 17:45:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4maM-0007wQ-1W
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 17:45:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ALTTV52995842
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 21:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qnask+VF0BNKn823HDX1GHCs1wlxhSX0R8TyhgoBlo4=; b=bTP1smm7W9tM7e8i
 hFmlcQCGJlBfQv+gH6Ej5CHcKxRLXYXsksu77Rnao2B2vocXDSxLoU/I2S7nMhnV
 tUdB76D4dimkLKRiTnUKo2qyRmk/cGfoRL1ZmY/eaotCos05jWySSfgMez3qg/30
 PSPWq0TSvOHxvCNXgzf5j/B5hwLn/4lBIpWfOVgL+sUJq3Z06Amv/lup+zn4+viS
 QdLV3AgsIjVJau/jUeDYPyKn/1xZTrtkclgrekaP0c2FsWZTM43l+e8rOemJUA0a
 ByNK0YSkZaiAyVc4rqXIma5mY6lnNsN2HekcB/yDvNLtD2vf1vI2DvbIGdlkj2xx
 F38flw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkxd8supu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 21:45:28 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b28d9206f8so203423b6e.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 14:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789076728; cv=none;
 d=google.com; s=arc-20260327;
 b=CmLbmANrK9boNhPDhQLw4Uj2gbivcCvTyJsRgM1iSAQEb8kWB4m6e+CtT5IC//yAnq
 CRFaBhpSM2+5mUWg5YIvNEvudZdmFDynZ4BSOpL2MqARLIo6e8i+8HdwWrMqlSyRMdCf
 XY00ix+xlDunN/lmIPk7kVFYvs73ORYC2WI8BOsHzSj2xn2GlBqao1JtACfPYchUv8+g
 oNT+UOL5HeWltOwuRpIUctD9W2kX0tg2vw2KemK/4G8gn/78EYXKDTj5qgwhMoKhfKBW
 CviAOkyIX0ma744SWOdba2fxr2LOwjxnHUvuD6oLFZYj6IeOznU1EtEhox4iVjzzsWqb
 XIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qnask+VF0BNKn823HDX1GHCs1wlxhSX0R8TyhgoBlo4=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=Kg8oRGmx7ZiBy/BDjAle/VKSQ9nTZJBVpnByQNelGrMN/9WPg5UzLBG5NlPui7Gx5P
 tyg5fmI+h3KXHFMb4ILFvbANfNoJ2k8FspjuVZVk5Jm7zwENvWEwLqABpQ3gdEhaaUj9
 TALdgr9vBpEHjen041PvX4c/JYnWJOlZwWwkkRjgfMYKlgxNgaOBAXghSuvUL+gSYH8a
 DmeaYIdKOt2D9nAlX7KJrhdd7c4XughXjWWOIk5LNXshGg5nJu/2dZSwU17fL4eSwKa6
 0ydQVxFkegEoOCy+FUEkedTzHr2nJyxFR3fNNZma7PPTemHc1UXwCDgjkZttJlPjpFTx
 vmsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789076728; x=1789681528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qnask+VF0BNKn823HDX1GHCs1wlxhSX0R8TyhgoBlo4=;
 b=WYSXzNt8DqZwSnC9DtrVcnvwLa1XC78i2j9vkwj1MDC24WMIvV+uBlwsgpOSStw9Tm
 MpQXaFNibVp8n79WpINIBrebZlBEh0NKG+GIO7ecSEm+k4j7PSjRmC9R33Vn0wYEQTR9
 Wx66JT4qoQ6xtGxsI4NaviISU5ONCKIXemfB4D8fqLggKjsDeogaekT8JabCpPWdvo62
 JxnfnQRg6hu0XDOtI3lv6nQTiaffr53V/uAzx/rhP3CbF2jXxBR+PeKaxPRdb1+j/JOY
 td5uISY5XHndtvyzW0SCrvzYAuJe/6qjDFbMsIN7PnqR42ZviwgmRhbeDIc+TtTVNFVg
 aAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789076728; x=1789681528;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qnask+VF0BNKn823HDX1GHCs1wlxhSX0R8TyhgoBlo4=;
 b=mUudE0Uz1Ay0KHbLzF+1XvPydtgEr5bxvFEh78KTQRKm9AbHSTGPhaZMwljtxQy8zA
 FGj8hTkB15X1sP32TMvuV02mS5U3mbDFnMVorYiSBj1JlxCUlXfqwtkP6U8hQpz46q8X
 5QfYGB/FDJHNwjVGotPNwklYIJNcqGsbRwRjR8DizLDDy1C4N7OknwOR1vZ8T0FTCe5k
 Hs+KH+h/Ul7pbhqm2LZffyaxsKjWJUwBuHFP4QHXUWM8ZVYWp+RKyZYdI6icsSWWp/z8
 lY6caakDQqj3lu5RtwrteHzh2BprAs8uJoZl8ZnAZ4m38dmN0sCHeOY5OLH40OFDYRsf
 9BTQ==
X-Gm-Message-State: AFuF++no7EHTvnh6NL/SlNIKIdF/3O9ve+q4jUtHNLYpc5EtZLjCrO2p
 VBlTKGe0abwGu3Ibx4Ps9vWzI+HSf4OmpazpCwyJTDo7a5pJ1rk+AYElsI8vnVN/Mme7np7j7X9
 qhEEdaZmcBKVukWcSK2g3QHsIIirhAm9ZlssNP+HQbOUulOr2tzq9sZIFgdfPd2AjU6Gabgyit7
 Xz/fhKUptGhdgQ8DDdf+GNIke3S72LDVIo
X-Gm-Gg: AYBFou3yfjefpJ2qHjW7qUPZnpurkZexzc5IoQYtDM3p8+DvFf9mkW+d/UXAlcwcFZ5
 MAzIBvDkHOesFKh9RJSvJYnTL/WoxamOlxXyIfgkrzV2f6EEspc9XNi7PFuzZSCKnzHErE+cTpX
 gZZokiexUzkrbsebVOmxkyJeq8ZEYdCmBfCPOcT87pfTVQdAW/LRs2UIoUGHjt+yTX3T+T2i2Im
 g14o4IEqTFpP2Rxlw==
X-Received: by 2002:a05:6820:4dcc:b0:6b7:8396:f3e0 with SMTP id
 006d021491bc7-6c0bd87b7ddmr585210eaf.66.1789076727993; 
 Thu, 10 Sep 2026 14:45:27 -0700 (PDT)
X-Received: by 2002:a05:6820:4dcc:b0:6b7:8396:f3e0 with SMTP id
 006d021491bc7-6c0bd87b7ddmr585188eaf.66.1789076727454; Thu, 10 Sep 2026
 14:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-5-brian.cain@oss.qualcomm.com>
 <CAJ+KCYPB8-coR8irYHZ3f9HqzH1EYyG_8ASSperhPkkj-g9zAQ@mail.gmail.com>
 <cfb663ec-1a7b-47db-9c95-069e724b3476@oss.qualcomm.com>
In-Reply-To: <cfb663ec-1a7b-47db-9c95-069e724b3476@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 16:45:16 -0500
X-Gm-Features: AcwNN1W7kzYWiZjnzJ8hdQBIPTWDsBqASrIq-DY05BuzYQhOKLF1kjWNnZSJc1w
Message-ID: <CAJ+KCYNnBLzXEOn+_NJBaQ+ujG-xN98TMLKM60RkgAyhxdkAyA@mail.gmail.com>
Subject: Re: [PATCH 4/9] target/hexagon: raise an exception for HVX with
 SSR:XE clear
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 5ZQzQoYUhipoiSTmwUDiBtTkV4gsgq9m
X-Proofpoint-GUID: 5ZQzQoYUhipoiSTmwUDiBtTkV4gsgq9m
X-Authority-Analysis: v=2.4 cv=PchqFShd c=1 sm=1 tr=0 ts=6aa324f8 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=5Jhoi1_dSe9dIxniScsA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI3MCBTYWx0ZWRfX+uUixpjek3wf
 uDLm3Z8eTv1tgaP1FtV/6K80EUP0PwaRb6qAIzWufYf8HSp4NfZbTaFhWA3uTHQ5Jn2sj6XMFW5
 wk180DFQFVqvfo3647sjEf29EgSvN2WNvc3QpEesKTONTQyEpskdJataEotQXCSMRUbn7Vb3sOa
 +MosvtjER1vT0brTqs06RL8DpFNGoeOtdbdUgrnshXSTjTfJU6feD/MWZh3SFL+tdCgN8IwgwZh
 6fjv0PkSwhkxe+Kyxkm9Gd4XpWoxZZamrJSBKy6/aCcRwV5hfpK7XgCsvREtiBeX1CZPrIngIDs
 vE6aPINHePLk6TF1Cab3ulG37AMoQJphaNQqyMXyRwV6OvulC5n4KsrlgzGBkncBJqKmVfdV7uJ
 AfjUNEfp41+dobNoISgWbOYn99m4RzjZgAqN20ieKstvElZfp7B4VF3zwtk06tJTqrNZQIhml3Q
 Ln+pk7cq+cZG4b0nETA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI3MCBTYWx0ZWRfX757WpqwaLGQF
 l+VtRQSfK0SPd2Ukc69X1KvYBxHsb8PVesBvGSlzQ3e5lXUI5fpsjjoq0hlmk6KzctR1Z7OHWOk
 BV9R9VY3YSxtqpaHNZpSmlHk0HWIH5I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100270
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Thu, Sep 10, 2026 at 10:32=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> SSR:XE gates access to the HVX coprocessor: executing an HVX instruction
> while it is clear must raise a precise exception with cause 0x16,
> NO_COPROC_ENABLE.
>
> Carry SSR:XE in a TB flag and emit the exception for the
> first HVX packet of a TB when the coprocessor is disabled.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h       |  1 +
>  target/hexagon/translate.h |  2 ++
>  target/hexagon/cpu.c       |  2 ++
>  target/hexagon/translate.c | 11 +++++++++++
>  4 files changed, 16 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

