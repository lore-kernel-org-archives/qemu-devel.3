Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821EFCD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDnc-0001Ii-G5; Wed, 13 May 2026 13:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDnX-0001E7-Dq
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:55:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDnV-0004DL-Mt
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:55:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DHe7Ih1393359
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hlLAWbMsHFCMLqdUBgD+biykeaRCnj2CF6m3YTdEWGQ=; b=RnLEh4SrvfR4xJof
 Tt11JIWWWsJ1TIR8aDhnX+6KOHQzAkvetK+OhCMy09rDQsc9eJStVc3v68rChVnV
 /MSBTFWN1YPH2j6HAoAmOBnLihBEyb8Sd/Y/CuUCSvRT35AQqaTotmY8qqofTJ7q
 pxTaudoFfx3FT1y3NIt5i8vxzu2bL0hK2HTwVX2sd+AS3jR8XQHLs8/QRDqaYWIh
 VDgL0fcibVdI2CfLJy93n2JNdAECM/gqtIXUsttftomnpTB+qqm+mqzkl1WkZvJK
 yVj2eJMACWKASbJGeABWx5xbHbVHAy3rdzlUIvq2442/k09wVBhCnmr46N7Sogf8
 Y0H45w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k262y09-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:55:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2eebb099efbso35493eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778694903; x=1779299703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hlLAWbMsHFCMLqdUBgD+biykeaRCnj2CF6m3YTdEWGQ=;
 b=jwVr9YM9NDP0W5tLcCCM6m8JYe39o9bk/jgogCYYZ5NiwqOSUvTJI9qtyCW6jYj+8B
 1uHQaH9koz4nWArbcQrJs+wzR52EF2ew1BMVnCU5JeGQImHP23mwP4SHOlDC2aUd6ZxN
 +kHmWGok+qr12RN2N3CUT11TpZCnGK8hHbKMn5Zs/VdXr3Jg5E9C/CNIzJ/itPP3h5fp
 3hSaaUclUHcjeMti8uSRQqYIyf1W/3atlbJj1tHe/o1g6Rm2LfOgxiIAL6FiP2w846/1
 fpl5xauk0w0ikhgDLOTiZa/LW+iCDD56apGCJrPWmKNtg9grK6wmHxbzdqcxFxWE2+4v
 /oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694903; x=1779299703;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hlLAWbMsHFCMLqdUBgD+biykeaRCnj2CF6m3YTdEWGQ=;
 b=dCK0evtSt9Eh0+oZTdHsg+n6zgMfnx0Fed2zxPzKwM95a2RPL6Wxpj2a0gWfUxCLCP
 KBZYFSEPbE7BRd1bofNkgncdYxtTB/JoNsaGr3xouDIrmT1o1hRlVuptDD2c8vrrOCEt
 Y/HepaPi/fW4eFEGo9GViIVvnLTa1WQlH/9oM8gb10bKqQyjsOPB9zqO3RE3Di6MsEF2
 +HA83qCDFIVLve4rhFJNnJXnUi/38hLWDxem2qqEAjr0AXtZvpvX94Mw+8OD6zW6QfVR
 vJH07N+WYjtEzCecmpNZR6LiGpeVVlOSMVYpBtebm9p/udLJm8pdXTE00pHH16n6xX7V
 blHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tGPVfQ6BnLcz1amp5nNhixss/1OMe/koBhE0FAUIVWVjA1+bDTs9ODAKJYuzrsUOalTV4WmdJ8mNB@nongnu.org
X-Gm-Message-State: AOJu0YwZsKDeMKYeNDE03kD8f83PARsc1QGczhvnHkyF+JL3H45pOgWd
 cShYkXcjgnFn68D8owPgz6iWfbP66I3ThkXQaN2hRmU1nmjkbSl8BybmZO4/GAYk1Xtzg15Ncma
 7oJl1kYB0vJOTD9RFxXXP3K1XUH0+GTUcRO50ZMFqPyqxbP6J6/lTRvBRHQ==
X-Gm-Gg: Acq92OG6jHNp6JSUQHrePpUodF2QPf5NhUWBI2L/yyyMsZqZ4DZ1lqFAsgT+CW9VehR
 3qmrDFGPmF2De7875VXwmFsc2IfINbkBM+1xzHIJNGtYaEWI0r8l2im3OJRMCvi8Fmqk/pXhuF5
 DDVSYyhcgAZ15nt3ocKuJVLRIjfv5fIXrd9zw2mYCnrDwg3dJNXFZiltiClPGn1yAKsB4QxRtkC
 WhuWjpBwZI+ofaaO1RDlsbq7u+erAGeJ/jEcvca3xuW7RXgJsVz+tYflko+BdIhvo/nGzpdjnFz
 qtCocrHJZGSAGQ0CM5Bv3pQ7cJhIG4Wb2NdUSYRLxHZt9Ej0913MwOULjTQ702deJJJ0AqUW2Zc
 BuI12Blkl4lZ3+qPYF+h8A3z82Sr01dpNdY6gMJ6RvF0BlTcTv+7BEUuqqpTeQSXmP1iCgbKshd
 Dq62uhU50P0iLK0A==
X-Received: by 2002:a05:7301:2907:b0:2dd:c066:bf7 with SMTP id
 5a478bee46e88-30153fc345dmr2422828eec.11.1778694902690; 
 Wed, 13 May 2026 10:55:02 -0700 (PDT)
X-Received: by 2002:a05:7301:2907:b0:2dd:c066:bf7 with SMTP id
 5a478bee46e88-30153fc345dmr2422789eec.11.1778694902135; 
 Wed, 13 May 2026 10:55:02 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8893441absm31127435eec.31.2026.05.13.10.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 10:55:01 -0700 (PDT)
Message-ID: <939fec00-2307-4b63-97f7-1c392b7ee068@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:55:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Fix formatting of `Error **`
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260513-error-v1-1-49fa04bc5c22@9elements.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260513-error-v1-1-49fa04bc5c22@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a04baf7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=PzGKxP3WAAAA:8 a=EUspDBNiAAAA:8 a=J7s-eodBJmQGiyBaidAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfXxl8vei49AtxK
 7kHyccjCWhKc4vcEP9ttG6RQjA5vyq6MKAa1rIppfZ3r8X99H8qZ9AUA457FRW9iCCNtKQN/66p
 LT3al2mt1fxP52/zDVgKDqP5/dyuf3E9CQyTYy5KIKwT9DruTvQ9G0phUU9USO7AzTMhRqHhfp5
 ffbzPjylz6H2sFeyRAFE1U1oX9+1E38kkfwfg4DKB+H/P48PUPl/5cf0USQT1K/fmNNd/dhRm2M
 SCBynt6TzvePDUABf7FsVTAt9mj5iUJEEMUpr21awJgXqf+wvtjDckibIcRldn48jwklfuGvm71
 ky5LhpiGAn9OWhCJj68iWbhxtr7Qg/eXuEommhMx0W1/CmGxV6n2Y9DUXLSixMln/KATNsn4rNI
 rS1HKg7HekUsSjjBKz5Cp5LB0CCdiK3X4O/mUqlhsrnR+MpJxM4M5gZlyWng0MXJgrd2KOjiGPw
 8dYH4iYUQLJZMmSORcA==
X-Proofpoint-ORIG-GUID: 5XrjMFaFShEdFNoquiQrvVHivbgiqsph
X-Proofpoint-GUID: 5XrjMFaFShEdFNoquiQrvVHivbgiqsph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130179
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

Hi J.

On 5/13/2026 8:06 AM, J. Neuschäfer wrote:
> Since the ReST conversion, Error ** is expressed as Error ``*````*``, which is
> rendered in HTML as Error *````*. Fix it so the HTML output resembles the
> intended C syntax.
> 
> Fixes: 336a7451e8 ("docs: convert README, CODING_STYLE and HACKING to RST syntax")
> Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
> ---
>  docs/devel/style.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 12e509d10de0b8c044c8429aaaee8855bde1deb5..b8edcf9316f059fe15415543098118b28fcaf99c 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -784,10 +784,10 @@ error, non-negative / -errno, non-null / null, or Error objects.
>  Example: when a function returns a non-null pointer on success, and it
>  can fail only in one way (as far as the caller is concerned), returning
>  null on failure is just fine, and certainly simpler and a lot easier on
> -the eyes than propagating an Error object through an Error ``*````*`` parameter.
> +the eyes than propagating an Error object through an ``Error **`` parameter.
>  
>  Example: when a function's callers need to report details on failure
> -only the function really knows, use Error ``*````*``, and set suitable errors.
> +only the function really knows, use ``Error **``, and set suitable errors.
>  
>  Do not report an error to the user when you're also returning an error
>  for somebody else to handle.  Leave the reporting to the place that
> 
> ---
> base-commit: 45cad8beca3ad75ebe63a36fdc60c98395fd2df1
> change-id: 20260513-error-674f87f0d381
> 
> Best regards,

thanks for the fix, I'll pull this directly.

Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

