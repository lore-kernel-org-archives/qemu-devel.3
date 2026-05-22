Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552F9CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 17:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQU3O-0005v1-CG; Fri, 22 May 2026 13:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU3L-0005tY-Ar
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:52:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU3I-0001Jt-JL
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:52:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHgIY13602336
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bvzjqd/tBZR5BEb6eCZ+vtt+IYFTKabiCLcyJUBzguY=; b=bMZnSaQavz26bocZ
 JRzUtf6Ov9KHzwJEVPvtdKzxMjFvq958uz2xZkGKk/agzjzCDj5ay7voyxd6auoW
 GLaOkYAKS8kv3fnITu+nX/k75XeHJ2utefliiu2BFKpFXJ76kOkwlywe3So9rWMW
 mE1k5qxDpCjZEtnWHVysZRsN0WjQ7zrurOGJDWs6B/a3h8wr4w7diyrPq5BpZAbe
 sOH77ZUKGSkfV7Qzp0lIJY0A9kVZ8EqVm7PJQoFAVTU1YZ6FdITrId0cHUpEz6ar
 rpGSaiUNz50o3klfejd30aeYq3XZZvYDW0KSX6HSBXgQPjYJU2hXecWC8oK15L6N
 Rq2pTg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaury01m8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:52:51 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13537722193so7767768c88.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779472371; x=1780077171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bvzjqd/tBZR5BEb6eCZ+vtt+IYFTKabiCLcyJUBzguY=;
 b=TA5b60J49V/PexSxqo4k2BPIRPoY8pgSkP6xiGSH5PVMuoRimBwKxJXFxnsWC+Z6RU
 ivboM79mod3tWbaG4x4kXPrQU/yE0jzpMzn4ocsSwZI3uPhBEiMVyRo8EKDnzfhGy1Ef
 xIw4f4/4xEK4/mBXer1nPqI5LRebnerCUc3rcfzWZTNNDVgX4BVSMk51Lr1n4XikDhvd
 ntvCz9PaZgWBmRu5H+/y490h+7WojtxVWdebu6Cr50F9Lj+rpcWSTyHDuIFjiFKnujaE
 +ZqE+KHm9XqtmTUmFzh9fgt172C9szvcXHU5HUcaNe2eA1g46Zp1EBb/cy24Oz1CPCqb
 UATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779472371; x=1780077171;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bvzjqd/tBZR5BEb6eCZ+vtt+IYFTKabiCLcyJUBzguY=;
 b=VgT6jWiKLPw8Wo/SAfAug8GPoNei1wXQWgMDkDMg74Re9XSYjae4FigkaU80xlSN2s
 ZI14RKQUc9+0kV/pbj+fONmqtZY8kcNjDYTJRdIMQKwz+ECeQuuTDWFCJu6cj/3K82LI
 vs7yhPAOn0HrOP4Lq9slJzeN3fPfzrcESRQrkk9Jm49fBIMIcFo8sTvTBmAMhuAeXQU1
 SZbMRKnUbfUtUkm8TdQnOQr0hoTrHZCUiSTsjRiN7gQOxTwuIPJGEVICP8iHvC7mp9Ud
 l69A4Oy65DjM2J6vnRIJJWB4T3Q8yd/VVae/k0Gj/RbBLudiNLgRyJkgyX6JSHZgyuDi
 DX/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+buLZRnX1UG37vDWd1J34ShjRUMrbyHWx+EJysmRGRAy9KxQcHT+HBdsGH2irxNBVU0uijyE1rPl1Q@nongnu.org
X-Gm-Message-State: AOJu0Yy9SQYB/8TlVwNtj+DL7LbhYWus2efUQLYdk+aHdwT8nR0hdW0K
 UxR8WsOukwymq0vZIFhBEEQXk1iAzNCs1BE1Wh57bHvIMfHCub01onLNL04hXOFwt9IJPYOj7Gs
 zTq00ZWWZ1xrZ16JGDYoaQUpyc7kjvVL22P6c3w6qjvXdzqig86Jz8sv4CQ==
X-Gm-Gg: Acq92OHx3OhRUUJXL/a4SP68BOphtmx3AmZQqpdP9Ib4YznvbhzrGzrp2blFHxG+zP9
 EBdcu0vqeEe+qxLoorFoXjnBua+lLB9mAxuAGgU00dId6f9ZiWWccdcb41qxVzaFK0imY2BIKIr
 3S//rVIagpdV+026+IpY8Xa3GPQCAC7abdaY/YefnR7qERCTxFggOpvPTZl7lXRpSM5nhop1pje
 xRRdUNtFg+z0dLzARA9jXsz/+ptNhMRLDnOtWD9F0FReI/zl0rl/9cakRI56CeAe1xJLHcWo3Y3
 nxsBSavsRKi0Xw/YUHL0/NkfPhMsD8b5Z/mBR4bYshKU6zZlK8+LpgNSdQ0Zlxo8QRvXfM7SZoh
 kSHQ3FVJ5LKCQmTVdrvXa0dKBKHMJvQhTHKqPIj29LyVIVlYuMebaid3viezJQCBGPKd80STiaf
 ByIr5gEMetCZXZD/JTxAh0TuAV
X-Received: by 2002:a05:701b:4189:20b0:136:777a:1df2 with SMTP id
 a92af1059eb24-136777a1f92mr816205c88.11.1779472370682; 
 Fri, 22 May 2026 10:52:50 -0700 (PDT)
X-Received: by 2002:a05:701b:4189:20b0:136:777a:1df2 with SMTP id
 a92af1059eb24-136777a1f92mr816195c88.11.1779472370159; 
 Fri, 22 May 2026 10:52:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e672asm1766652c88.3.2026.05.22.10.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 10:52:49 -0700 (PDT)
Message-ID: <549a4e6c-b3fb-451e-98c0-db6478811389@oss.qualcomm.com>
Date: Fri, 22 May 2026 10:52:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] gitlab: add MacOS 26 job on gitlab runner
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-8-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521131739.540157-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3OCBTYWx0ZWRfX36Ny5Yeu1stV
 kMJyDaJTVs9ip7GKvu6LKlv+rM/mfLdSVO9IOhufIEixm75ija7h44R3H62elUn3YTbXkbDbw2Y
 1RLSBV871Gizi5QxEjEShSVYOmqvrGOO32TsxaBVzHBBGaeuyUCoSMLp9qwcIWssaedZgXmvkqW
 tPWnSCP/q0Uq/hvR8DDL1fUvGajW7zD0o5qlOCNvXb9m/fj251aJmWgZn5JqwFOt2yMZhn/kRtg
 qWhNJhgpCrOWBeSeu6QNBMLRf0L5nv9DKfdrNds0bC5NYEncujiCV9tXCb4WP8nWaIY5/lhJ/3u
 +h/axvWcWscV/egZMNprrbftug9+WmTOy0iGOSaF7/AeRs/AVT8T/qgr+JXDtHffb7U63362xqs
 Pf/rgRMBN36iatJK/+IEStrz+59OPk3AH5OOTKLXzEfbtVHKB4TePzgdwrB4rsncDTUJpId7DiU
 Opc742ho/CGnhfUagSw==
X-Proofpoint-ORIG-GUID: dZERb8QBdrO7watnUc8NT49RD1DKFiJW
X-Authority-Analysis: v=2.4 cv=d8fFDxjE c=1 sm=1 tr=0 ts=6a1097f3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=t4vobd5irhleK6ilZBoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dZERb8QBdrO7watnUc8NT49RD1DKFiJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220178
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/21/2026 6:17 AM, Alex Bennée wrote:
> gitlab supports 3 MacOS images with 15 and 26 being the current
> supported ones. To get ahead of the curve lets enable 26 as well.
> 
> It re-uses the same brew list but also attempts to work around python
> configure failure by setting DYLD_LIBRARY_PATH:
> /opt/homebrew/opt/expat/lib/
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> 
> v2
>   - call runners directly, seems to be working now
>   - drop debug lines
> ---
>  .gitlab-ci.d/macos.yml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

