Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44ACCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkYG-0003P8-Tk; Mon, 05 Oct 2026 11:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDkY9-0003OY-Bk
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:24:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDkY7-0000W8-AO
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:24:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EPwCQ762336
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 15:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qzGr48K7MjfnZAzro8Ym+//QfGh+33gwHmclTctQEn4=; b=fxURN6hCPVloXdFS
 9qFWwR/UlHg2B72HbEUoRDxCGkk7VolAidZ9Pz3xIZUb3DO3vFupAINgCN5H1bB3
 hMbTqyklcmZgE+6IQysELxREwEw4hdl/VRZXjZs3MUzMyVMZzhOm9Ez9O7kf+u3/
 kLN9YHRWahu5EFN8PsvVVJQ9COT8t0SEQ+qgn8tZ2OCQhBL5GNPBAqFkPpFwxIfH
 Z3O/XPHbsep5B/IQvHRuQ/rdv1GXyA+hlqh1Fhcvc7eu95ZI4ilrwiuDK9SWaW49
 Uq34WlLDfBuq/AB8cPxynywtSnVN6c6YZYTbYKrhm3Bogp6Ui11SNWWv6jhGgF3G
 YVtKVQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4dncg8ga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 15:24:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so4450684eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791213856; x=1791818656; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qzGr48K7MjfnZAzro8Ym+//QfGh+33gwHmclTctQEn4=;
 b=C7Lmp89yj7WHbSP2uyEResR8fv2LjKm5wiWnEg85TXMTmvaemTOd3iYYTY2xOyo0jk
 3VtGdMMGb/YMQpM8zYMyyUIxM6o0b8LHMORAhJ/kJ7jUuoIpaEbmZjG9Dfe+mBpeazc+
 HKP2Ul8yUgzsfS3TcNJn2KSq4IkEbSNYz7woePY3hYahrzjgXxIxQTgX+ojBbwfbIPOg
 jzKdQXihTsIQNXcgUjU+TDoI92T85AQzAjy/lv/hAHcu4FYCaT1c4shZ6786Ht2rN/lK
 JoMNQuJEGPMKgQDdEEAz1Eg8wAmcuXjg+o6Y9XpQyhj23p2MjUp1hhibnBv4CgXc84cX
 XvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213856; x=1791818656;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qzGr48K7MjfnZAzro8Ym+//QfGh+33gwHmclTctQEn4=;
 b=L/KkXZ7GHKZyIe2QmFm3MtyJhqJz2W6oPT2UmXm35ws5yUbRjG9VJEb3Y4WNioslL5
 tc8RfG6NAeJzkDWEn2yGFQFjJ+QNzP3yFH1OXFpjoKHMobtZIaccWcHvrC9f5Ah/sHfN
 ci766sMf396ou0h7x/tjK9JsrcZi9ROV3Bbhx13qmYmQh8GO7sRiCIX9wejM6A3xZl2O
 2CSBNx2/iljphbpmTyhr289PGINywmiI5/XqUU0vPYe347yb1KL5MHUiQCNEiAmJ6zKO
 I4WZbtChoFQYJBwps1EVU4Xf2hkCBvkxCWc1qYh1+1v5y4+uPavQmZuj9hjaFF74o96Y
 3AKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR+7fzbV+QCg4pM8ubNo+qFACW3vJE8whUCDp9phqC1CTO842h5mS5dnvZ4byDiDysTWo+KcgOkFLB@nongnu.org
X-Gm-Message-State: AFuF++lkUlkZ/Z7eCANrbX9QEvqb5k/PSRv/QrNPVqm3ozlahRqWs68m
 qBFC17QNaDT2Mc2PnkUpBTNeAvpJJ4cmPIUa9qPqZxwqg3593w8XkW7OiDumh3copHVEMpq2tGM
 GHZNEsBJBHGFjTWKYPI64dDcs/reZ+afwzzg9/E1qmVyIyhvHgsDHoabbKQ==
X-Gm-Gg: AYBFou2C3YG3O7zH+sn9nDJO/2BAj9QQ7GtcBQgzwkfLF5D5c8MbrV2JYl0AhjLhNNt
 1peVNJYsJiRUc5VOQa37jHDMiV15ScF5UEbrcFuaM+26e9zT5Fm778Nwdptr4RbXnL+oKgNQFfb
 vCj0yfHcdE4gSw5YR6Y/GtxlpIEmmDMT/h9/br66reusmcm5rI2QGGRxpi7OTxtGHJc+6v+N6zi
 7ADoD9AY7Ciy85uAj4J1CouDbRZZoR5mcZJilaDkfRgbC0Eu4tdrxUspm2ddGpf1jvJFdIze5iB
 XEkEyhLAC/m7tVWp5uGJ9V2RqV9gTIGHobisKKgdhKiv2Sg0pyV1I8UfIav1yNeZjudKzIW3arE
 avAt19XYEdjV+9lwkVsLxoaqPDC4/fpANCgFeGpanZFx7gCSDVoF/EEfxpsCXdtVLbxouxg==
X-Received: by 2002:a05:701b:428a:20b0:14a:d8fe:33a4 with SMTP id
 a92af1059eb24-14f5c5e7cb6mr13517043c88.38.1791213856125; 
 Mon, 05 Oct 2026 08:24:16 -0700 (PDT)
X-Received: by 2002:a05:701b:428a:20b0:14a:d8fe:33a4 with SMTP id
 a92af1059eb24-14f5c5e7cb6mr13516759c88.38.1791213850521; 
 Mon, 05 Oct 2026 08:24:10 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fcec9a95sm24795087c88.15.2026.10.05.08.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:24:09 -0700 (PDT)
Message-ID: <f125ccc3-fc5a-44ce-b32d-a6dfa3f04506@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 08:24:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/i386: Build test-i386-opt-shr
To: Dominic P <gcc@gcc.dp11.uk>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, qemu-arm@nongnu.org
References: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
 <20260930185124.3036980-4-gcc@gcc.dp11.uk>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930185124.3036980-4-gcc@gcc.dp11.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX4Y0wRW+YIaWc
 wL4YR5npStrrYIY5qZOG94mpy+Z9YSX62vSsHmqxB+502WnESNWcv9055OKIM2768g3tUryzlZo
 QTgtKNG6obu+3T1DmK20vlsdva+1GKk=
X-Authority-Analysis: v=2.4 cv=Vdxir1p9 c=1 sm=1 tr=0 ts=6ac3c121 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=CP7RdrZA_qBg88vvjUMA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Wr1cSa8zKikHQcNFq_H4g0JqqMSZxHbV
X-Proofpoint-ORIG-GUID: Wr1cSa8zKikHQcNFq_H4g0JqqMSZxHbV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX2Gxhp++SH7CS
 aT2SbOCvy/tqz7ir7Psckwck53qlgsUZWJ2PxcAOxNXM1Ed2MQMu0WTdUxh6ome+qYiAnWWCZA/
 Fb3KaWlPdWgJEE4T0GlHdGh/uKTGCLLUwC0F7EDrRSxS5Gatun3K8hMbxrMS+SLVbu6ytQgfF88
 SSYW6OXsdIezivowunLubqY1I/kwkjTLQ+SNTAN1aCrfUI1mCzESN8Fa47mNKWU4DlyqfoKl0eX
 6CrwPl+wnNBFNtFAniU4OBzVIu1E5hf9ILKUwhI30xoEcpD5Amh1z3Xkg5Q81nHorBPp/QzowKl
 IjlRnux1ktLyw+lf3aMlZn2WpMUs3NsCC+3FR/zLAfCT00xzoB2bwzGLVxPk0/1HH6xCe/OTsl5
 l4Uj8mabfcM5BWD7baNjIMUwHSwrECjKjkx7obU3R7wmOeqrr6P+urOBC7yLxeic9Vr6kFSFjm5
 h+xO1naTde1o9znPpBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050060
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/30/2026 11:51 AM, Dominic P wrote:
> The old Makefile.target built every tests/tcg/i386/*.c.  The meson
> conversion lists the tests explicitly and missed test-i386-opt-shr.c,
> which 5fe51606146 had added in the meantime, so it is no longer built.
> 
> Fixes: b4e3e90d61 ("tests/tcg/i386: user tests")
> Assisted-by: Claude Opus 5 (Anthropic)
> Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
> ---
>  tests/tcg/i386/meson.build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
> index 4152371a3f..26bd85c05e 100644
> --- a/tests/tcg/i386/meson.build
> +++ b/tests/tcg/i386/meson.build
> @@ -28,6 +28,7 @@ tests += {
>    'test-i386-fxtract.c': {},
>    'test-i386-fyl2x.c': {},
>    'test-i386-fyl2xp1.c': {},
> +  'test-i386-opt-shr.c': {},
>    'test-i386-opt-rol.c': {},
>    'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
>    'test-i386-pseudo-denormal.c': {},

This specific patch was merged into master
(2a0ac9c8ac2d303ca515dc819043409aef18cab5).
Thank you for your contribution!

Regards,
Pierrick

