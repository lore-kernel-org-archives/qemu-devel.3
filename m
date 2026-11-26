Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4F606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P5Pffu5u;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EkhzEmu3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWirZ-0007n5-2q; Thu, 26 Nov 2026 18:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWirV-0007m4-KO
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:26:45 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWirQ-0002FH-3U
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:26:44 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwAPC781882
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XRXYRRCqMdaJaqcEqo3g2mU/t6yHIVGrW0dxlCVs9jE=; b=P5Pffu5um1w0OlQM
 N5ErctICfa168LyuLTh7S24uO+2pV8AVZ37mWrEk2mwNRJypMBh8B/8qr5VwSjsc
 Rp8B9RjgcajjHE3bHIxPwg0g8n7/4AM0mt4ScpB39Li3xB/GsOcWGo3jUe6LTXtL
 4Ymup7vPTJdhNlVaRzyy44IB24SoyEivVg4SEDQVGhMnHhxbcw9YqngeAClnh7Wb
 zrosARMaDlJtUJ0daDi4yj7eNhexrG1VPcQDA17Cj/FobvmZDVYGn2ZXELz4HIjX
 dGv3p42DslRWo5cE83d3RYLqbJ/Fkh4XR8xQQlW/+3Bbld2X5hCQYuyt0uSxDRbZ
 91IVbg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6hm82knd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:26:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-375bac6bd21so7411863eec.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795735590; x=1796340390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XRXYRRCqMdaJaqcEqo3g2mU/t6yHIVGrW0dxlCVs9jE=;
 b=EkhzEmu3TkvqmKk9iRtBg402g2RcnYl+ulPmIc+uqVZDC3gr/XSEJ6P7hoXHapFpNM
 TMDWwiak4ZPt63fb1NCWN0A5xj/mf0GCChfaGmHxoFjl3MMf1JN47voboLFZB7Hb6NNN
 DFLJTMrgXr/Q3QA8jjWDiUYnp3DrvAKTaPQunCGygspFQCCOiERAF9PjLlwhUAESh0Wo
 O5MY/9MoDmZ1jJKfbJe6n6c8h4mBF/PWllJWMzsiLwwWvOpQacuuRa7Cj/CYH4u013k/
 thbwkiEu2qjB+MV5rV8MkfusqdAxZZWC2rVAuTV9+VH/oVJnUc0IjPFUssSSY5yePgth
 oJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735590; x=1796340390;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XRXYRRCqMdaJaqcEqo3g2mU/t6yHIVGrW0dxlCVs9jE=;
 b=bkw66j7nlaDiysmIgO0OZLKuRHSyVRi9+mk40NR57s2nBhkOa5LwfM2faxbnfbFkgU
 ymXI7Pvc7q5YEy83eAq/yTgL6jzd/CwfH9bacXuXxDP/Zj3gikdTCdrWx4+HY1IcIQtx
 iM9WnuEgEkNfC6psP9ruJON2HCgpy/FVzrH8S8EwbHKkzILuICvaQCpu5fAY0QZWzULF
 1O098VgV5kmUydnFIMDvHOqe+KZHxESDHd0UjBNTfDnb/R9cvjhKE5Mhh2OVCJ670y94
 NPaKMtw9eJtt0iE9qlE2y948GIzs/YuCeQRHvm8jmofMidtnbjMK7Bi2Ek3bRTd6zWSc
 W6QA==
X-Forwarded-Encrypted: i=1;
 AL+hErGnD+dYYZIuMkt5iIjVKrnqEJShRcgi4QWWMYDifv0w3FXvNZx+tDIIgbDWsrA6pnZG/OhnQsBnNYTT@nongnu.org
X-Gm-Message-State: APuU4Z91ATAbE9cNnRoEJeN1qgcwXVAFwoa2sF6Uiy54P97/TtdxaNlV
 beIDFzcWvA/WBnR6DMVeRDb07X4k1tApv5CKGODmnf64T2r1DcfcRtCcV/hyQNE/Qxo4umGyJkZ
 CG9vjOJeanAMLvz8mw/Oj0vlrzp8mOwfMBUNlCCyD/nkTrgg1QH2CBY6mZQ==
X-Gm-Gg: AZFdTZdXjhfxPJEZn6o+Qu8NmgTCurr9Ut4XLwzUOdbr0Wvv+rAnfxBNSYF6vZF4tv4
 skqCDzMFGYledg6Ih+0CUtYH2DuINKLrErAhgMfIc14/pY+Grcp2os0BawBvkj0idgVtYiqEHC9
 4LaJxQgwH7HIs2d3C5aUlaiqwVDBcsE/3L3zN+pGtOiyE1+40Um/P5sfWHM+gZsKVMgyzJiE7yQ
 jMb3U2+c3LtWD6wLEAJ9zRwc/hjGpA+8YVPEl8+GUZenSc9O4Mx3gf8OZzhTvYjB1ddQR2Vu8Yt
 S0jX5dkRvxd6Xq7k1I2GX35QV2ny8wzp+3eYrCs8VuCz1oOWyIbPmt8JjK0jZYUWNcrlUKx9IZ+
 wQcDeNWWWwSizyXF8MTVfndPZI+2jM+0dSD/PLiq7HDlpQbWCb9eoXF2oJiq+XCr0mjMqG6Vd8/
 lbkfTwsvKoE/0Mg1qgsDkMaOReF1sHb2RHne+B3922qLY=
X-Received: by 2002:a05:693c:6395:20b0:375:6fed:8e71 with SMTP id
 5a478bee46e88-384b3986edamr23208460eec.7.1795735589558; 
 Thu, 26 Nov 2026 15:26:29 -0800 (PST)
X-Received: by 2002:a05:693c:6395:20b0:375:6fed:8e71 with SMTP id
 5a478bee46e88-384b3986edamr23208440eec.7.1795735589027; 
 Thu, 26 Nov 2026 15:26:29 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386b1965c02sm33756662eec.27.2026.11.26.15.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 15:26:28 -0800 (PST)
Message-ID: <ee8de7d1-ed91-4e70-bac3-860c78bf5f3e@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:26:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Split ARM_CP_IO as ARM_CP_IO_ENDTB +
 ARM_CP_IO_BQL
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20261126223959.62899-1-philmd@oss.qualcomm.com>
 <20261126223959.62899-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261126223959.62899-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ACr4zEWzb_7ZYXnGH-6Dqm_1454WllN8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MiBTYWx0ZWRfX0Oq9ejj3eFj1
 gJymnE7+WnLq5Cu5rgsLUANlyW/B1cnZDRgaHYoh+18FxwJVUDPoiCpzge6QUwlHBw1Reb0/ziU
 KJLnTXNaAmP1AnA2LorfB8NjPeSoOmw=
X-Proofpoint-GUID: ACr4zEWzb_7ZYXnGH-6Dqm_1454WllN8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MiBTYWx0ZWRfXw/uemJ6+cf17
 eUy8u0cuYQtjSwD7oe1bKF5kmC53OYOw06IgE+3wtqCqYXOcsJUn+QFlGf5sDA0zoS6IaLCczho
 WYlQFnWNjYUA/VMXL9gX3KMVT3E2KvWF+FmN2V9RpgRwbZHvwa9cyCe7t9n7JBfVXa9CNOqFbY/
 s0mwWsGDpmWcWzZ3vfdWQgjl0z8+HBxyqvKC6HZ0wU4GwlLtU9nqrz9pnpRYJFx223okT9RCPrP
 5WpEwcvuXbdSegnJY5ZGHpJFops/bP5bWnoPYugu3CsiXcaxV4dmyM5HhoxcB+i5XcuC93vqvnJ
 ThqzARlUWlvoIMxgxQ2rYeHnDtAaxew5s+s0GY0BKgYc3PD640fkUzKdd65iQAwCVrs9g5NHKGv
 0wurXq3Ngm5AQzsj+/7bxcbi4ycPFIjHxXqtgu0NKiT86qVRv96y6/nxfq4uODoET58c0J/9Zdx
 VKNz4UGkjsqsCOiNv0w==
X-Authority-Analysis: v=2.4 cv=O/usLx9W c=1 sm=1 tr=0 ts=6b08c026 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=haWXIRxN-KZGYTMq2MYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260092
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

On 11/26/2026 2:39 PM, Philippe Mathieu-Daudé wrote:
> ARM_CP_IO both ends the TB at translation and takes the BQL
> around the read/write hooks. Split it into two flags so a
> register can end the TB without taking the BQL. ARM_CP_IO is
> now their union, so existing users are unchanged. Update
> multi-thread-tcg.rst document. No functional change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  docs/devel/multi-thread-tcg.rst |  8 +++++---
>  target/arm/cpregs.h             | 11 ++++++++++-
>  target/arm/helper.c             |  4 ++--
>  target/arm/tcg/op_helper.c      |  8 ++++----
>  target/arm/tcg/translate-a64.c  |  2 +-
>  target/arm/tcg/translate.c      |  2 +-
>  6 files changed, 23 insertions(+), 12 deletions(-)
> 

After our conversation, looks good to split both cases.

If I'm correct, we probably want to make sure there are no write
function on those registers, no?

It seems that all registers in next patch have only read access.

For the naming and bikeshedding, I would favor to keep IO (as the
default BQL version), and introduce CP_IO_NO_BQL (or CP_IO_BQL_FREE).
The ENDTB thing does not really makes clear it's supposed to be
thread_safe, out of its documentation.

Regards,
Pierrick

