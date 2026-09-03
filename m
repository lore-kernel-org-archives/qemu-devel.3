Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380C6C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AD5-0003Qs-8C; Thu, 03 Sep 2026 12:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2AD2-0003QX-GH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:22:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2AD0-000605-7q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:22:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3WQK1430705
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 16:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nsuCDlvjXox/Yb8yG9oUPUhuFAx9jF89pz7sLfgXnhE=; b=YohLl+M6BbK6J1dv
 UbZqTLF7zTcVtCV4BauQBZH95+ymyvfKDrwPE9szkh5/tpb3+x0MGmu4aN8hb0cI
 1+EInupLxIaL7bGylP3vn74cZStQ9gZ1wUmrSmy+Z1RtpOQiZRs9vOAufQ8wYjVn
 95lWx0svtcwLcuVVNfiL7fWT889EvYyn9fQsyJnt8OL+ExheuIXWIOY1SpC5FcaT
 5ZeQuf7WovE1NU9Wk5AEyH2PF/iyja9TObx0bDfb3Uu6scy/lMv6FdycWtVdUbZu
 uuzuhCxjjRZDyhmwHLkCzy00IlH1C0HYFG5MNVgWVyKsq36a0a86i6rDNhszsb7D
 1InayA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4jv6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:22:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-396b9ef3070so403974a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788452555; x=1789057355; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nsuCDlvjXox/Yb8yG9oUPUhuFAx9jF89pz7sLfgXnhE=;
 b=K2N+6yM5AHOSkpIJfEJ2RBZ13F4gy86Ad/JgcBgy0YZfu4IJKrFjtJkBKDhpKPLVEP
 csHgq+x0qcTjBmfyPybRIGFLuX096w7p+HQWJYsvBU+3zcVjhDaiNaCrMG/wdqtxeHb/
 mIH2rdmZc1DgQId1SNTci5mnFxRp5DUBZW0f/4tRZ1C0fOa5/Yxz6z/bPbFb756H20PH
 XmHkkE7+xQIEuslMnCZH/D/+BUwMyPjfxx54yr20akpalD63A01PGZqSy2L05Kh2wDGV
 QeIJV7S958vVBAuVLC3VLrko2KFKxisl8sXa6nRdkmg67GJbIwhjDyBSC0wRBNGFac3F
 l87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788452555; x=1789057355;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nsuCDlvjXox/Yb8yG9oUPUhuFAx9jF89pz7sLfgXnhE=;
 b=cR4l1Fac3BJGFE0cBG5Ma4wRs/vaiJM3IzR7I1d1dX5F9qlislEcNn09tHFqPlMuBE
 baIlzvH4CsHhcUfEpOTotazBCJZnw4CFxM6PdS7nZJeZA6Am9yIk2TIumlnrdpiWoVMW
 599Uwv+gQyEGMwan79f6UKorX17Yo5XNRCZ7MDTUddiYLVEycb8Aid0T2Pp7C3RkQLhA
 YWBBNjB3NrHtvp8EHDehdR9AgGeB526PcTbpKHs/VuC8wd8FdpGiHBbZJf6azYjsat8g
 x/NigvKOPVyqBEg7BLE2Ce3uhVh8SPVLOVXsHZ6dVSPGBijHNA5NZV4I2qUJjOiyKowW
 n6MA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx67bMgigL0KUl2fble5EFpxSg8Jw13gx0HZWQaDeAOI/S1HukeGPPOFplislts9iUTkRNX7t4FzzGC@nongnu.org
X-Gm-Message-State: AFuF++mhL6q8C3gvSNfoYbUz5BUWvPZJAtA8m4q9Vqpp33SI+nmkB+sQ
 ljVqA3UOZK1dSjNAwx8Lo385gCD4H4JF6ISGLNGaMreY1wuIZgidHZ69VzDauOpuPgDFuuyMD52
 3e5awdEzmkQDOIWJoxQ8wB7SEx9JiaKmDkrGSzvMI2GL1wxTMNjz4mze3GA==
X-Gm-Gg: AYBFou0lojlRZMAJe8sX2VQ3ljvzH2t1dkgs9y8A2WsGElFvRfoV2irFZjoAvz7kcdP
 e8Mi2KadkAkNyybLY3q/NlR22ZXZv8cd2/3h72YIOufD7poYupb21QE5xUc+FhwD6rQpjKDFU9X
 M+mJemuNOv80YXxFlSrcxbu6orxlgVVSK99/CJx43ZOWntySkliYsacDX8EhzatYKsFic6muPms
 IZ64vtSc6ZR38WgNQ5FY0rwVNWY5bRs+Yh8JygubDS9xCCGCend7Nxmg8HjtGKkKty/6XjZfkZG
 BEVBlxlUPbDKHiZN7lXSu5cBEIl7mpN4Qnsyazc8EM5rH7gDizjSYpKiqTBzS/D6RN/lqKf6kk0
 nDBuZl9bCKigk4xShPBLsG2gJcVOTB6XP4jE3ZUIlwozZgL5Z4hOxz8X9HdjXPVQzYyRM
X-Received: by 2002:a17:90b:4407:b0:398:9bd4:d13 with SMTP id
 98e67ed59e1d1-39aee219427mr19650532a91.18.1788452554827; 
 Thu, 03 Sep 2026 09:22:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4407:b0:398:9bd4:d13 with SMTP id
 98e67ed59e1d1-39aee219427mr19650446a91.18.1788452554268; 
 Thu, 03 Sep 2026 09:22:34 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa31b24sm59704eec.13.2026.09.03.09.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 09:22:33 -0700 (PDT)
Message-ID: <a5097863-f3ab-4ee9-b6fd-250058e6377f@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 09:22:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Bump min compiler versions again
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260903103548.2142568-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903103548.2142568-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a999ecb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7tLszpB8rurWp6AI2CkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: M63rUxcdHat9HF7OOwssfpzvrlQU2lUG
X-Proofpoint-ORIG-GUID: M63rUxcdHat9HF7OOwssfpzvrlQU2lUG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0MiBTYWx0ZWRfXzCbegOzMYroi
 9sl8+DYcpDCsgjQi9H+wTWkMlaVaFugC/QYVSHo3V/C/hTQO38YqWhIX4/UZiGa7gIVD4j8g0Wu
 rxOMHM3I3P9ykewLQR3J8Po2yFfgLXA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0MiBTYWx0ZWRfXyBytIokgOw/z
 272RpZO9O5LdgxG4s4Kd+Z2ORqfX1mXAWH/3dNavCE1ZRgG+ezTZyhT16ZVObZQSesgx3PDPa08
 1ABb73Efk83KhSDvEiO4Wbv1fr6mRFhaWsa7LEV4SFyDN/HH0depD7YaoeQs3oEKXNBVQdON1sc
 eZ9SdZGk/rm1eQV9//gmX32HfpbQUvRfEQDp6/NuzMilIKQ68/mOWgMgQKgNOfEzfBq9BEprcId
 NOW24i7yUzMQ88RBgW9Svm+KcjjxyhLxlO7GNnnUvIQpWM8CNkU849sm/fVl4YSuY+UsOiL+8/4
 TSHIozPsOmh033n7hbtdMsqdPgI+stLcWfvs61AkC8jqVrsXv2JU6i3AsaHT2BC8i7UcYN6dd7a
 OjYs+jIrwEh+CQZ8BGnzYFbleCa7TuWWeCw4ZebYLwg1RiVwTk40XleVScaQsdOEXZvxVREd9aB
 yP+l+i7PViMocabFArg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030142
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

On 9/3/2026 3:35 AM, Daniel P. Berrangé wrote:
> With the security policy we want to rely on usage of
> the -ftrivial-auto-var-init=zero flag to declare
> bugs "not a CVE" if they rely on uninitialized stack
> variables.
> 
> This arg is only supported by  CLang 17 or GCC 12 though,
> both of which are beyond our current min versions.
> 
> This series bumps CLang to enable this, but we can't
> bump GCC far enough due to the NetBSD constraint due to
> its system GCC being 10.x. They do have newer GCC in the
> pkg-src as non-default add-ons but we mostly stick with
> default system versions.
> 
> We could bump to 12.x and force NetBSD users into use of
> the non-default versions, but the last patch took the view
> that we can just warn that use of old GCC versions takes
> you outside the security policy.  If people prefer the
> former though, I can respin.
> 
> Also historically the macOS XCode versions reported by
> clang did not appear to align with upstream CLang versions
> so we checked versions separately for macOS.
> 
> With this set of patches we happen to end up on 17.0 for
> both upstream CLang and macOS Clang, and this makes me
> wonder if we can rely on aligned versions going forward ?
> 
> Latest XCode 26.6 apparently reports clang 21.0.0 which
> appears to be a match for a modern llvm release.
> 
> I'm no macOS expert though so looking for feedback from
> people with more direct knowledge.
> 
> Daniel P. Berrangé (4):
>   meson: simplify clang version checks
>   meson: bump min XCode CLang to 17.0
>   meson: bump min upstream CLang to 17.0
>   meson: warn on GCC < 12.0 due to lack of -ftrivial-auto-var-init=zero
> 
>  meson.build | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 

For the series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

