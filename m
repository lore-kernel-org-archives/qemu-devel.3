Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEEACA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCaYM-0000cl-1v; Fri, 02 Oct 2026 06:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCaYI-0000cO-3l
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:31:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCaYF-0004lp-W9
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:31:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6929nm2L558019
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 10:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sHLJ+fmCh2DFHdbGxS4WwWNa/1Q9CcDIgvkeHb4bHPY=; b=gpaLOFjuu3sBhWLZ
 A66jHELife/uFv8oRn+N3XGO8ksrMNuwDub/3cIHyKNDDhbKmuK1KD5WA4eFPi9s
 t64v7+o+c0CEUi3Ce0tCIbiTuqYShElBgXIU3f705GriAxtnhEJ/RughtNrrpRtB
 G/phpg853SnyErHpvdEG/Suy67VZXRJklD79rrUxEMCO8c4IY4i6syZtUlbnQFDY
 X/xyEx+2JKSyOJvjYj3PFo9M6VCciJSmRh09tpU6fmwsWArl8wq/nCyihvHnJ8NZ
 KzvQ44JLgKe9D1qCmhBWUh4HvJFgNcCehNC/oS/EGriKIyuJqX7N00POVt4zOyrR
 +5oQyw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1tbgbkt5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:31:37 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bfee69e500so1382715137.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790937096; x=1791541896; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sHLJ+fmCh2DFHdbGxS4WwWNa/1Q9CcDIgvkeHb4bHPY=;
 b=I5FAkmEagEytsP4oaxAG6df9j2VxGmdHZBF6MwI/XdJ6ruwdDUC3QLyeqQpV2qP25q
 DLKQD79JEnZVZAPfqInuEBfnxwi24hBoE2KBD1qmzn1S/xbDrnrlv60jlFYxOrpYWFBm
 to8GIml5TUdmEQttTb6TPA+/vZfDafWp4KyP8NHtndxZ5kIBL/jopnlmtKBMC7woUqro
 MTuz4ggUnAZUel2p5JyfNJvbzzEnNoZuymdzmkQmtcZlBzn7bYDvZ1Eh1pbBg/RVVNYd
 qLYuRVCNCO9WI/FKa3w619k0+XSVO3CzOZIwEcnefGZjvU4eYezHG1Oa74pLVsvNTgyo
 M+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790937096; x=1791541896;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sHLJ+fmCh2DFHdbGxS4WwWNa/1Q9CcDIgvkeHb4bHPY=;
 b=J648mBwP7ZNculnsbeGGWv8aB+vvRlrzqbqfM3xe8WLSYP3OhLW0kmRx20Uj//Uf3j
 JDKWsXI2nAfpBUfztT7ZbZxQK0qVnDvPFtRqhsVYQ3WKBLPzpnP6uZhcKf4Rsb6VdeHC
 84oUmvTQVpTfhSI2alV2eG44qe5ET9NqJtB2oAQendr+rTjf9LzYYB1C52pegJVlukn7
 205RxLCIeY0E/reNnJkChLb2+iB1CVWSgw96mAHgjSR8sZTspuGnsxIK1lZ7eTfJvFR3
 lzLeYH1kAsleYyGkg+DTFAjRcWXqZJ2AYUwzKDHtovnStHsq7GdY0v8rzZiiQrVlJaO8
 Qz5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGkr6aM4+7KbYo/YQe5KOrjpstv8R0+voQP74QGvNcrO9THLmHYksE+iuiQ+AIuhuEbtgkWYm2XOjq@nongnu.org
X-Gm-Message-State: AFq9FYIKM6kSQyHmt5BG98E8WINDY813rXL9hV5aMbuMJvWweTBfYih6
 Fu3yFwuWkcdnygaVGO3fL0OzAV4zCjwFz17YX9b5bvXR9C2amCsMsB5TMsD6UJTgSwh6Wwj0Scr
 /UpCW0pEqRTXjQWmuhGTjIJwkyUSjNug8hS5s4mdxucDptZN+mCgO06JNbA==
X-Gm-Gg: AYBFou1FKbi6KeFW6vpFoBfFOsLoappXld4Iz0yculEAhF2sobXfj35Eonoqlfhzri+
 L2MNxpeml4NdkmtwS/TQLDoysMY3st8NLhvXUV9uw9/cl4u0HAPyH7oJPPMyGwoz5nYJ4l5wXdI
 CBz8Kop1KVBVZ3L+IM0nQQf+yYLgdzgSVurHzfF1ix3yZP0pYlhW93zfR/Dv7Pt/cXO16Af+rub
 vsEce7p9zxBu0XaZ+3HL4i1cMUwIBcT4bYJGI3TtLkcqAO/yVMJMluxGY7UcoGf57sUDx/ludFh
 Hq9yxDRc3GVuFAVstVgsNV3+9wxNRMS6GhLlSlQ9hqhRrfQcgoJSno6yUZEjOxPS4CVg47JrmTZ
 Lb69rwwfx1/8oNzuufTe+jg==
X-Received: by 2002:a05:6102:5111:b0:7a0:eb10:79b5 with SMTP id
 ada2fe7eead31-7c0f487cc53mr664551137.10.1790937095985; 
 Fri, 02 Oct 2026 03:31:35 -0700 (PDT)
X-Received: by 2002:a05:6102:5111:b0:7a0:eb10:79b5 with SMTP id
 ada2fe7eead31-7c0f487cc53mr664545137.10.1790937095424; 
 Fri, 02 Oct 2026 03:31:35 -0700 (PDT)
Received: from [10.111.137.66] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280c6597sm73235655e9.9.2026.10.02.03.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 03:31:34 -0700 (PDT)
Message-ID: <b9019487-979f-4b37-9c30-3fc43c308d06@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 12:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fail iso packets sent to non-iso
 endpoints and vice-versa
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20261001194756.3003085-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001194756.3003085-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MSBTYWx0ZWRfX1MvJAfTi1xLc
 o2oJS49YZ4AQrJlQMFNdARPXi3WZRAfFRSOGEqeVa+wWh/ZnCyTivhHN80Gvq9hKm21IzvzNBOw
 UZCW0fWiNn8OOmvwQvXQtmihL+6q2z4=
X-Authority-Analysis: v=2.4 cv=QY7zLcbv c=1 sm=1 tr=0 ts=6abf8809 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=mVuZ1GJhL4F-jNGdb7sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MSBTYWx0ZWRfX/0LCjIhL9OnL
 +74wUHkb9ycYgyuRpixnWxsJcHjcs3t3jPPpuxoYsxB1kcKLbZ0z4LWjb9/dZsa58FOCnA2bg20
 b6ApzUTbT64oFgXp4XxhkyU/vjleNa3YeQi+TwXLN8/g0a/+X3spIWEm5KLjaKycaoC3+ijvORL
 3wACmkK+NP0RpUA5f/Q1mUW90uj2FHaSENXcpXrJP/Px9qe3evgO+CbPEMWhXp/fsCvEVMuKB2a
 EW7CDYvXW8z1FuwFVkreOtrTMwxxcFtkSuGMStmKDEpCagPirT2cPJ5q2yQiELZxDEH3ZI86a/f
 +GlvMieutoTJiYlKVIgVzR5fqlyLVxmBsnewDucBS1AbSinjLqNay7uvfpr77iyF4euT9rF2E6g
 6Mu+oKjUe40SyafZ3ZbNKwNeK/znG9dbQ/n43xq1AT6puBpJKMUM7F6JmhVn2Hjvd6EQuqPShA6
 lfhD8B9ssFRCjEvyoVA==
X-Proofpoint-ORIG-GUID: dD4JWtMdwZWEpCcuJgPZ9rw60N613knc
X-Proofpoint-GUID: dD4JWtMdwZWEpCcuJgPZ9rw60N613knc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020041
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 2026-10-01 21:47, Peter Maydell wrote:
> The OHCI USB controller requires software to set up an Endpoint
> Descriptor data structure.  This specifies (among other things) both
> an EndpointNumber telling the controller which USB endpoint to talk
> to, and a Format (F) bit which is 1 for Isochronous transfers and 0
> for General transfers.
> 
> The specification requires that software matches the F bit with the
> endpoint it's setting up the descriptor for, so that Control, Bulk
> and Interrupt endpoints use F=0, and Isochronous endpoints use F=1.
> It doesn't require the controller to check whether software gets this
> right.
> 
> The spec isn't totally clear about what happens if software creates
> an ED with a mismatch, but I believe that the controller just trusts
> the F bit, and tries to talk to the endpoint with the wrong sequence
> of USB tokens (notably, isochronous transactions have no handshaking
> and the others do). This probably results in the transfer failing.
> 
> In hcd-ehci.c we check for the "iso transfer to non-iso endpoint" and
> make it fail, but we don't do this in hcd-ohci.c.  The result is that
> a guest that deliberately sets up this situation can cause us to hit
> the assertion added in commit 7b1eba96aeca, where the endpoint is not
> isochronous and returns USB_RET_ASYNC to an iso TD handling function
> that isn't prepared to deal with that.
> 
> Add checks for both "iso transfer to non-iso endpoint" and "non-iso
> transfer to iso endpoint" and make those TDs fail rather than blindly
> sending them to the endpoint.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3729
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The diff looks a little complex because of the re-indenting;
> looking at an "ignore whitespace changes" diff might be clearer
> 
> Only testing here has been running the repro in the bug tracker
> plus "make check-functional", which probably doesn't exercise
> USB very much.
> 
> ---
>   hw/usb/hcd-ohci.c   | 61 +++++++++++++++++++++++++++------------------
>   hw/usb/trace-events |  2 ++
>   2 files changed, 39 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

These functions are huge...

Side note, I don't get why we copy packet data *then* return
error if device not found (trace_usb_ohci_td_dev_error), this
is sub-optimal.

