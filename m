Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D139BC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVHs-0004Et-RN; Wed, 08 Jul 2026 12:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVHq-0004Ee-Sk
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:38:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVHp-000206-0j
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:38:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLUBK3208941
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l1/uXx0T4flk4wzpAu18REESCW0cbfe8F2JHFwXwlj4=; b=IspNAIO+zVJKnShQ
 W32iYdxz+WQM7EJ1IF44Rk250/BwaQ6E8kqZYm0cQ1kUO78kixj9eWNYhzeKBNNl
 Q+/V0FWeF8kRjB9+Dlqnn5TOAEhC/AG83x2T316RG0On/4fZ3uXUF11j2YK5v1Hm
 xoUAYuyrNkMZA09zUiOIiS7l0szDjhvgrgIToYtIrGavTtrlp9mnxEwSnjx5Afup
 kTq3tUJn9VH5c4oDDCDCPihGu8OeA9Ac65QK9wQ6xQD2Y81yCd6fAsEtVDmuHxqC
 Y0VY9au4xcu94UMk5pUpH68tXHrRMbmt7Ph9PPIOUiQ3bjBYgy1b4/ij1wIegmU9
 pq2KpA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9gqwanfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:38:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9fe2607511so1244624a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783528690; x=1784133490; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1/uXx0T4flk4wzpAu18REESCW0cbfe8F2JHFwXwlj4=;
 b=CUdBFV9ZjmKREghMZopO2gviN7pQLDIJ+gUZwOhvliPoglANjLLjOrSH5/QPaWMfIG
 EoyoYX1ELzxfEQU9n4ZzGb3N0NSaDeW15MpDwkybvwDp5dJtwuQ4yXGLRsKnKSaKN9hz
 NUbNMBVxvhS+7zlgcGRqkBH2noZF8ys2veXGC7+1zD5rwgaqmSmaIHN1lAPE+yYySWd7
 qhqxag951yFKo3RTWw2I6fbv6e/l+MLCZdW+O/9tQMlLp8q1fEKnbL9whiVTwx8pVL2l
 bm11JL5PQjN8k/Wp8uq0sYO4S7oMuZ5bUeRiuXE5WgrwScjoKLQ87GnEep3LBfKkKwpu
 Td6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783528690; x=1784133490;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1/uXx0T4flk4wzpAu18REESCW0cbfe8F2JHFwXwlj4=;
 b=gmWNJLeTBXB1tldaXkvpHWY20hIvFKShaSE8Str328WUSrot/1B39pDIqA0YEHHdcQ
 onRW0CE3rA3WSnCB/G3QpZsBdPlOo7J1+pBYvTj00m6qVj2DJnCNdMFwU7NVgI61XCZy
 9clQ2SaHa7Z9cdV8Pjak1bbSCUZ79VD0v5pDNeA5trPRg8Thl6gNlMPhC+4d+0+WuUR0
 ZEALyhD0OulX5/I0mxBM1l9+Tk8CpJCq2pU2X15X1rz+DxcUWZIbW05HZc9yYwYZpq26
 aebSyXWqR9BLQGdhevuCm180xV8E7lEuOz9CH+DRFh3WQUjW3STBe22SrPYfp4X4LIfS
 SX3A==
X-Gm-Message-State: AOJu0YzSs7QB3YC33sv7xEPdjQKL0gmNaZjZUGa77MeyUevqdHfWKmE6
 0ziNsMVrXKydQ5+0iEP43CEBbDA539V3Tk8jtW0wvTpmkOJP92H1t+QT/NqBOwc2X/w98hAEMde
 HC2w8Zfnb77metzPn/e0h7jo9VON6ENXqLY2cuTSY1N8qkj3FPRVGGSgYdFOjXitOrg==
X-Gm-Gg: AfdE7clm2O54BZYJ+bLjfs/350pLv0Nz102b6EqXTl+wViW4rG4fxcKjo23v802bl74
 RHJNpw8rGpegHxtLtPhnQvP5y0RjInz/rsD7MfJoHWFXe7rjVRZQk0bphADcQpVjuqtNZYo6E5X
 EKuolLMvl8VNRguGtuS9uW7uQCMDv9jQdcU0n9xVYOGl7zoL9qyQpyNDExgcU+5Tm98piTyyU5C
 QDmCI1kVi02uuIISl+K6hZNda+rtN+i3qa1XsWxluZuzhXW9RIB9+PvopobQw5/abjeZzLFcYif
 EYlBOkWGc4P1OempArJ+53IJ+KMwWgONP1zEPHJvIabQNF75PnH2Db+AMwbjXcwGY9ePr2H4fxr
 ZG08g7YQOhK+O/VyS60YgFIe7EmAR32mJHklQxQc0U0Pq5qnozDHuvuej/n03x8MYVRXr/aorZu
 tfzqo=
X-Received: by 2002:a05:6a21:7d01:b0:3bf:e449:3316 with SMTP id
 adf61e73a8af0-3c0bc8c37bdmr3817065637.14.1783528690329; 
 Wed, 08 Jul 2026 09:38:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d01:b0:3bf:e449:3316 with SMTP id
 adf61e73a8af0-3c0bc8c37bdmr3817015637.14.1783528689792; 
 Wed, 08 Jul 2026 09:38:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6594f6a9sm22751085c88.5.2026.07.08.09.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 09:38:09 -0700 (PDT)
Message-ID: <8e4fff2c-c9e6-4a1c-a555-4e8fe3c84fc5@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 09:38:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/docker/dockerfiles/ubuntu2404.docker: add
 missing apt update
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, mjt@tls.msk.ru
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE2MyBTYWx0ZWRfX6cRZiDG06vs7
 6YaBycm2QhbmKoPalK0L9TN4yJIZzBEJyI8jpDpYmBCha8xsds09O8Ag/ASQ1UUSc4DbZT68Yqi
 6ldN3W/2RI1w49fLcGopdeN4pHDv5znRpRwYs82nMqohiq9lxXAwIcJRAIruBE5m39X0zXjdmJG
 18KSvwobVTSWR/iVhTtuLyW9ltjuhrzKOO7v8e59Y2ttccp27O/5QRslW5knRBcz3n36+oEAhPS
 fAOvy5qphMStVcTiolVDLLRSVsjULyeUS0MDAqenZnKNswLuQxkOPwq3Kx4/LnrOFkHtJ67Pv/o
 GeH86bAXZHQ/ObxEzOXmTD/t3AjGuisBB07uUVJa/jcydok9C62KxcvU/YsG1xhhIByct22DpPC
 HEGy85o7LmeIKdyeoZ7AfGK4t/Hq9fP0W4jk04qzRZgXBdSt+ZiNOpiIfFuA3nwpeia/sCQ95IN
 0EJcZCFWlHsn0ZQT6+Q==
X-Proofpoint-GUID: qDqVf6rjwwFyZUBjrydhRuRLGtdWfSGT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE2MyBTYWx0ZWRfX0UamlTOiVptW
 L9pjz37jwt170Oy8+UShyAbFVsh7SrSWmaspmFIDsf3cmrb6+f9HEv43Ofp7r5gi1zqqkp40I4+
 OucZ2c4gPP24VTy63OV792s5P6EMfXA=
X-Proofpoint-ORIG-GUID: qDqVf6rjwwFyZUBjrydhRuRLGtdWfSGT
X-Authority-Analysis: v=2.4 cv=Wf88rUhX c=1 sm=1 tr=0 ts=6a4e7cf3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=n6MYwUk4AAAA:8 a=EUspDBNiAAAA:8 a=7v0Q7q_gVrHnMD0pE0sA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080163
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

On 7/7/2026 2:46 PM, Pierrick Bouvier wrote:
> RUN statements should always use apt update && apt install together:
> https://docs.docker.com/build/building/best-practices/#apt-get
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/ubuntu2404.docker | 3 ++-
>  tests/lcitool/refresh                      | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
> index 26bc2dd94f4..27992e34fd9 100644
> --- a/tests/docker/dockerfiles/ubuntu2404.docker
> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
> @@ -160,7 +160,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
>  ENV RUSTDOC=/usr/bin/rustdoc-1.83
>  ENV CARGO_HOME=/usr/local/cargo
>  ENV PATH=$CARGO_HOME/bin:$PATH
> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +RUN apt update && \
> +  DEBIAN_FRONTEND=noninteractive eatmydata \
>    apt install -y --no-install-recommends cargo
>  RUN cargo install --locked bindgen-cli
>  # As a final step configure the user (if env is defined)
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 1fdd37440c9..bbbc6d3c46a 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -157,7 +157,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
>  ENV RUSTDOC=/usr/bin/rustdoc-1.83
>  ENV CARGO_HOME=/usr/local/cargo
>  ENV PATH=$CARGO_HOME/bin:$PATH
> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +RUN apt update && \
> +  DEBIAN_FRONTEND=noninteractive eatmydata \
>    apt install -y --no-install-recommends cargo
>  RUN cargo install --locked bindgen-cli
>  """

Adding missing reviewed-by to be able to send a PR for this.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

