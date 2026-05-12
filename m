Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71139CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMoeY-0001fF-VK; Tue, 12 May 2026 11:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMoeM-0001c9-0T
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:04:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMoeF-0001Mo-GQ
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:03:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CAkYav739985
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nYDuUxVH5umMtA6iwV2rCvRfWJ5tM26wtB37NySaA4I=; b=E/XBApvu4F2G/K9E
 SCuaG9M3kCrdmJfivxqptYKY6pc4Cj3c2GQddXUrVIpF4ZSJPe73vJoWsS1yTfa9
 gZl7pnijvZ23nR+/FL6i7cxHU0fIhLxBIf6X+gPtV4hKEC99yYnFTgRF1eaNTpeB
 tLkDMlnnGw7vSbfi/bHnpXBhJkO6sMdVrmDD4b8+bU4Kg1O7xOETAwKLZx6OOD95
 1RhwqxnF3iFy6vObMNJyFd+kcJJR23FAM55YFKfju5Ebl3EJijyuzgdG1C8jk8ot
 xFh6sQt9l54EgdfQJVN4PRro+tEqHzcVMP1RpdmSAocKpCeien1iy/Gb/9AvvSho
 bDD2hg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhs366-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:03:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so6752810eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778598227; x=1779203027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nYDuUxVH5umMtA6iwV2rCvRfWJ5tM26wtB37NySaA4I=;
 b=jm0lYXWBU7CdUIzwnyWr8HbcuFOVPXsJyJW4/kS3HV1nJzTlPb6lubFQ9YX5BeM3Bz
 sR1CBls3mwRnUcG9mzJ6dpDp2HrQ/zGQtt2EhMY1XvGMpHTB6dVPqHN98MAoRzQx9/Pc
 iUuw1st5LmbMLqh9ZH6Ez7epSUOcjJXKT5O2mEB8khpyqevixYqtNSSOeJrLUAcKMwX4
 QXn4wHjpnt5x116gLpXmfSgpgGu6G9639c6KMCWtQhbXenfkJqa91IVa0mADFAAeYPto
 XWX5wnDDnuPYj726mQvsaiY6bdHMZ2r2z2Hc08BKaILVFDJXWokk1vA+q5guSkbxFDtB
 NsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598227; x=1779203027;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYDuUxVH5umMtA6iwV2rCvRfWJ5tM26wtB37NySaA4I=;
 b=FT4iDNuvvrRBdVhxbhraKem0sBdds4hX3cg9Rms/b3elQVu++W7HpTkq0YchOtS1Du
 1XhOJN4b8SCls/e1aA4bs0rw38NrsH2eaWMhCVmcaigNYtrHotTfGm+KU4feTdH3syhv
 X/dLO2t8JK0SdZ3mBOi61h1c8tv1ex+qcCEdubkhOGfODFUzMoJbIwieNJCPmvjimjcO
 MrCHIIR9oFnOY4RZh+ZkJAUHWAzxEXxzHOFxzIBE1cLVA+W26kv2ahWSOwnApHlwhr4S
 XvibVwoP0CiwD+ZBjflKE2aPD7Tq3MXp+O3Z9uYhbw/6ynFJyqrg9i3L05Z4WB8+V0vo
 U+nw==
X-Gm-Message-State: AOJu0Yxqb3P+HBNVgmgkUrzOc/XilQ/5AzERGUj4e7xUmx58fLDizLTg
 IZEsRaq+YJv+C6Bguy7oUt7gcKqu9MPsNP9nRwoMqa2TolMeyz1w2+y35maWKV1IcCJqBdM0oPw
 z2mdk7CqPcOn8Zgn54v2e8GtoKfV0TyaBzgi0M5ja747UJvNtdYhjs9YdhNGDcziuoy/K
X-Gm-Gg: Acq92OG+1mWFUSVoiLOkRsQHM59saHN8DIM0xE4b3U4qYQdfn6awk5KiJ6I/hyeXF3R
 p36pybYYwoYHvSuQSJxjS1hD+EITHMPyKPxA8Pbeh3xvYFzfWhtVaPGukCooKKaISkwHoYmNj7w
 MY0vTlyXXVxCBnDnAWVIiZQ9RYzQ2EVWR0aWyFCr5HXycsx8XWFP6qdzCyEuUdJbfjLLmg21Cw7
 rsA6BoqhjWG6qZ+YlOc/2Am0RFhgxHPxJNJL2Lc5/8oULXdiERce+fVdPPnzggRqlQ/BPj1E1Ky
 DaOIY6ByxTEAZRBKP9FZ1cIuDF8eYdaD4udaYdDcumlOyqsZDGYZzBXPJ/BgXBeYyvgjfRoIQZ9
 t3U1kGgbvDmSn2C0AQdr7qbBEX4x8pCqdl41v4qPrvW2mKyh9HhX7ZGhj1rUylY5qMu3V03yHMa
 WE9MlqF/JpMslD1w==
X-Received: by 2002:a05:7300:214f:b0:2ea:cd38:f921 with SMTP id
 5a478bee46e88-2ffd7ce16bdmr1875205eec.26.1778598226495; 
 Tue, 12 May 2026 08:03:46 -0700 (PDT)
X-Received: by 2002:a05:7300:214f:b0:2ea:cd38:f921 with SMTP id
 5a478bee46e88-2ffd7ce16bdmr1874898eec.26.1778598223865; 
 Tue, 12 May 2026 08:03:43 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88885b87dsm21924833eec.21.2026.05.12.08.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:03:43 -0700 (PDT)
Message-ID: <e6470779-9f98-4a3f-a837-c04036701675@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:03:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] single-binary: deduplicate target_info()
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1NyBTYWx0ZWRfX22FOVeBBtKfV
 qWZhgvx6bEp2vRy+dH6KvQEJ8Y4qon1edkPMxIE75GG61hG7bsnibycPrvtahd8KUlN9cakkK5F
 wKEbJR6g4htlBdmVbohl/SNvbM9bSUOgOVWva+ggJV2Zr1mBZ2VOhl3VcMwQBtTVK5pX7zC6GGc
 FqnSroWhzdJdtlM5QxjMWwaJNx35N+wtL7jkcGRll0YteAfb2L5hD8+2SOEjHVw4II1ltZ9pR0b
 dva7tNj4GSTevCwM7jZbDmjvYmOtV1lUfmOxdAt2nrs01ODHjvN2Ng5PJni4XCJQ2imw94CCzUi
 4pmIbz1KhlAKtHSGJe2I5ZgB5CBzLwF284J5LSoliITGv6+sSlhCSCOMhQMy2x0+xjCTOky1ZAC
 ZdrJeIJOOQXxxux0f5feuNNWnCVqCia9Hf6ypOc1IPZcWgJe/S9UEM9BDV2DLnQWuLQYYz9MKkV
 sQsqGnYXYH77OMP4oeA==
X-Proofpoint-GUID: w1WHRswp1VABTs7zqzf6W5667EHHmuRf
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a034154 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uBdxnfw8I0pi9JzHwZEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: w1WHRswp1VABTs7zqzf6W5667EHHmuRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120157
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

On 5/8/2026 5:54 PM, Pierrick Bouvier wrote:
> We are getting close to be able to link several targets in a single QEMU system
> binary, and the last obstacle on the road is to embed several TargetInfo in the
> same binary. The end result of this series is to have a single definition for
> target_info symbol.
> 
> This series adds TargetInfo types in QOM, and retrieve them dynamically(). At
> the moment, we don't deal yet with multiple TargetInfo selection, but install
> all that is needed to be able to do it easily.
> 
> Because TargetInfo data is set through class_init, it creates an issue at
> startup, where we may try to instantiate additional (unrelated) types just to
> retrieve the list of "target-info-X" types. Those other types class_init may be
> using target information, to add target specific properties for instance.
> This issue has been fixed by adding a new object_class_get_list_by_name_prefix
> that does not force instantiation of all QOM types, but only those matching a
> specific pattern. This way, we first initialize and retrieve target-info types
> before others.
> 
> An alternative would be to leave all this out of QOM, and use startup
> initializer to add them in a single list. However, because all the single-binary
> work has been using QOM where possible, it would be really sad to not use it for
> this final step. Comments are welcome!
> 
> Finally, sticking to our promise not create a special "single-binary
> configuration", the goal is to use the *exact* same codepath for normal binaries
> also. It means that even for existing system binaries, the goal will be to use
> QOM to retrieve current target, even if there is only one.
> 
> v5
> --
> 
> - Fix header guard name for target-info-init.h
>   (TARGET_INFO_INIT_H -> QEMU_TARGET_INFO_INIT_H)
> - add a new patch to initialize type_table with TYPE_OBJECT and TYPE_INTERFACE,
>   as suggested by Richard
> - use a single class_init for all target-info-* classes.
> 
> v4
> --
> 
> - Revert to v2 MODULE_INIT_TARGET_INFO as Daniel didn't comment on issues about
>   about MODULE_INIT_QOM_EARLY.
> 
> v3
> --
> 
> - fix rebase mistake for one header guard
> - remove MODULE_INIT_TARGET_INFO and introduce MODULE_INIT_QOM_EARLY, as
>   requested by Daniel
> 
> v2
> --
> 
> - fix header guards
> - introduce new module init step (MODULE_INIT_TARGET_INFO)
> - as a consequence of item above, we need to register TYPE_OBJECT before startup
> - fix xtensa core type registration using type_init instead of static ctor
> 
> Pierrick Bouvier (6):
>   qom/object: register OBJECT and INTERFACE QOM types before main
>   qom/object: initialize type_table in static ctor with fundamental QOM
>     types
>   target-info: extract target_info() definition in target-info-init.h
>   target-info-qom: detect target from QOM
>   target-info: replace target_info() in system-mode
>   target-info-qom: use a single class_init for target-info-* classes
> 
>  configs/targets/aarch64-softmmu.c |  6 +--
>  configs/targets/arm-softmmu.c     |  6 +--
>  include/qemu/module.h             |  1 +
>  include/qemu/target-info-init.h   | 63 +++++++++++++++++++++++++++++++
>  include/qemu/target-info-qom.h    | 31 +++++++++++++++
>  qom/object.c                      | 22 +++--------
>  system/vl.c                       |  4 ++
>  target-info-qom.c                 | 41 ++++++++++++++++++++
>  target-info-stub.c                |  6 +--
>  9 files changed, 152 insertions(+), 28 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>  create mode 100644 include/qemu/target-info-qom.h
> 

v6 sent:
https://lore.kernel.org/qemu-devel/20260512150208.1167711-6-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

