Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7356C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WOx-0000SV-AQ; Tue, 15 Sep 2026 12:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6WOt-0000Rj-Gt
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:52:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6WOp-0008Nz-Ev
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:52:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAgIN3959297
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S28lbtSQOd7UDT8FLhBrYzxU9iWlgIUc1BuYA+bHXsg=; b=huN6Xjfrv36G/Z3i
 fBH1VqjtNZqV1IguevVY5KkMtG/z7GgjFelzZ6a1RXcm7oio0KDX8nfYQBr3Ced0
 UVVS5iPIdgcea1re4oMMcqSe5eI9UEf0IulcxRsd8PBG2BNXNDmozSMyqYGkxKTe
 Pe935welrAK+n5d+O7eTCED4Y0DZHEUQs/VTuRNEep0r4mlwEHyZ4l6EeNT+vJD6
 6qLN3CHyDb+fP24NFu5loPx0+jssy4rqBj9Olk82mVFhm7kqBCD98w+pMpPwrIzi
 IBoAWYQ1ROcReDSdd45bLdAH3OO+6KCw3d36nRzciQ9DoFzmzXNHIwoluvu/U8Wv
 SnO/2g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2j5yh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:52:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8710450f731so1147729b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789491169; x=1790095969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S28lbtSQOd7UDT8FLhBrYzxU9iWlgIUc1BuYA+bHXsg=;
 b=KH4nSoTVnPHWcjLfKADEpwLpjMar2wmqChK4yWbXJSDF0AA0+IGCKWi2tVZ+FNpAj2
 yfszqnOy8Mp9SBm9MOVdWnIXYsU2+apihvtmlAgY3WnEmd4dfwdFiPdtQYbUrZ3ivZJp
 e0v6Nt8EGrmM/t3DSasTaY4aLhUe3Om94nN29eHf063ncjvilfFXPWvsZWSMnL6xkOEL
 Shs2xlyllwPfobV3UEwmF7V86xTesl7zz7btPFj/QeXhv/HWec4QCGjMgilOPwZm0A/g
 dx4auWSO2dRgenMEBnpDzKqZw8wRIXfp4zPHXGjdDUb73SehqHtRpvaS0TTPW6HrpxTv
 w/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491169; x=1790095969;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S28lbtSQOd7UDT8FLhBrYzxU9iWlgIUc1BuYA+bHXsg=;
 b=FpXW1fnV5EkPErXZ5RHI76voxV6nNHpzzSZw1LtPgkDlkQfDUcRZumKB84cXlb7n+a
 cviSbWSAefrKJl3D9zy9X+WBM3qeNTkwW5qGLX7JH9kPQEbz2lliOWp3X6GVmsuR2tdG
 jotH2CBPS+FXalD1pFzbbJgYWj/xxvuCjKG7iIvyiLm/wh2a7gLJEqD3FRraVBUj0HZ4
 +Tc4AKQX9Ewt3Yot3qta/GaOERV1Ogk1yuWKEFVKv6BpCxuVepUJ8dw6C/SHeDAnbevU
 wbep4hQVE59/uH/Ih/8YG2z5XY5rr1/xrQm3EuIQ/nSGJ+NsDtZOe46AGGPhNtmYFhIX
 7mnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz82Bo3YlyAffVlcEORKr9MGd0+NoGgaprfYVmnLrTV+R/RFFeeIvz4fQelK00KXKQ7ZR0p7aHSVNMD@nongnu.org
X-Gm-Message-State: AFuF++n2j5DK0ZxH2Af0sQLhmnNATR/qrC28RiSFTaDRKB7UlYZdoleV
 qzFtqYFDGFSwcOTWwZljpWx6OInJYin6OXE2Y+xRz4jjHkO1p2LVMO1/CEt9WskCWQTUMjbekyn
 tMEzyfiqILnyCvE8lQI8lvEB/2eH2Ohng8NBXKO806uDB/Z+cK8o3AbqWvQ==
X-Gm-Gg: AYBFou3XmZeFZP9Q4kwBSazd3BaARqFmBMOJoR79yDXAGBsjIMc9bLzAof8M+IN4I8E
 fMqbrvkJ7M17R3WVJ1Nf9GobSZGdDE6n0QrXokVeMxGCnJOXZehPSyilh7zurInzW7NsCxGECH4
 kOSsDZcjU5UDfNztDu9iPe0OkQoGsvUQjzew6x098w7RD5A8lvBCb65q4bCCy3LBB1ZoxOEBtAo
 uw46obtrJspl0q8aWj7hGLKLNJRpVgfcFMtgKW9AJbAAcHKqc4h+peeIYlO/HJjfXzk/kohVPNu
 8rDq64cBUHxSErW8YJQSkMBlXxJgTT/x6BsrZ9xKhsEGjsICCkjUSpRJ+i/C4YztE8FV0bbL8Cn
 newUnMBXBifJ6QhwgBjCeot7OZk/UItsg7m0xsZLkPAZiDh5DKoiU26hJXxUNXEPZGNHX
X-Received: by 2002:a05:6a21:3a41:b0:3cc:45cc:c401 with SMTP id
 adf61e73a8af0-3dd5282268cmr4669769637.13.1789491168723; 
 Tue, 15 Sep 2026 09:52:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a41:b0:3cc:45cc:c401 with SMTP id
 adf61e73a8af0-3dd5282268cmr4669670637.13.1789491168027; 
 Tue, 15 Sep 2026 09:52:48 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm451842eec.14.2026.09.15.09.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 09:52:47 -0700 (PDT)
Message-ID: <b0649064-303b-468d-82f6-55242416816c@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 09:52:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] tests/tcg/hexagon: add HVX vwhist tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
 <20260915163047.4180600-11-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260915163047.4180600-11-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Iq7dGV7E12lxhjl976CMwrv4b7lwSmRs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0NSBTYWx0ZWRfXzUAagED96vUr
 jscLRdvFb9DK5O7WM7HMaozwHnXO+blBGW63acVdypVISypAqjykbnVk43CysKuFr8JVn7RS5zH
 0Lwe/c5+QW/+XLEIkZukrE1fX6eaPj4y9z1a+J0r9n1fv7i0rlMiV5NSeTaGMenqTVlkrqk5FjW
 /4OYw5UCRr+DLepUbCtaHaolMyiMqVK8b/BFT5Svk6YTA97BBKyhh6lYnl54AiCm6xNEHIzTmM/
 1vlK4S8WKM/xXpJV4usIdc1zTs3/c9GY7SW03LKAvvI/tCqbhIBzXbdB4MVL9DPoU3qZrt96GQc
 ftjlAK7mF1i59xmzdG68+jZ27bKubrTYk5MiCQ+TfGucg4enT6UcjAxmyqXNPeydDTHYcmIQMVw
 xqWHVpq0Gr6QXiD31zDpNdqEOPRYQMiexCXTQ2BxTKqUM+OSUOSghRgW+62rAWqgKrXKe8jjtGB
 TFNcZwzbV6V+UTeej1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0NSBTYWx0ZWRfX10iX0u/fV11u
 Dpzh2jnLdQ1pmGV3CVGaD4cQ9uUh7+hJMzderhUH461a1/6ZkmSAnPcihKCl0A56k2VQTqvOSAF
 +BB/kc60DoQ7scRe/9J6sT7DoK4jcfI=
X-Proofpoint-GUID: Iq7dGV7E12lxhjl976CMwrv4b7lwSmRs
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa977e1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pABdWDBWeka73zIzwdwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150245
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

On 9/15/2026 9:30 AM, Brian Cain wrote:
> Test all eight vwhist instruction variants and the four Q-masked forms.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hex_test.h    |  10 +
>  tests/tcg/hexagon/test_vwhist.c | 345 ++++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build   |   1 +
>  3 files changed, 356 insertions(+)
>  create mode 100644 tests/tcg/hexagon/test_vwhist.c
All good for me.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Thanks,
Pierrick

