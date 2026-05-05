Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45C7CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKObz-00014h-2N; Tue, 05 May 2026 18:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKObu-000144-Ps
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:51:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKObr-0007Nw-Az
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:51:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645H0KgH3740708
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 22:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gM31MTfUTrHtRP1fOR3g1odQBMJ7iuBeqqDdFZ/WSQA=; b=WgLVuC0grSnafrQ8
 V6Hu2VUYd+bbffBdmqEsu3OYr/VQvrR09l1vDCzdh28koKpN0B8znQObUKqfqSUm
 6fnvhSx2md1jgueXZJjrm9X2D6zzUXTdTtHDXZM79ZwHCzG3TQLRNMYg46S3YFL7
 xrEYPXGsVjn82ro9rzN86tkpxG+eiyZZ2pru1hFI7eCWVkAR1pO7FDZLyxvdU/Of
 h71xdRp8Fz/mMIgj5+goHVKi0nff3CHtPy6ZCgaAVP7UeON7Gg+W7Jz9il1MQSfJ
 iymT3s4asc/kTf+KwEBvFdadLvv4EEfsRcYpg/VzfoIfoYP6o4JYz040TypMxikx
 tFOOOA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyefqawfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:51:22 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1309f4ee9a3so2233213c88.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778021481; x=1778626281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gM31MTfUTrHtRP1fOR3g1odQBMJ7iuBeqqDdFZ/WSQA=;
 b=j0xjZpO/O3PoiLMVFcFIHhppYKR4GXpd9TNBDnW9Cz503DfyLvo/BvWwveeRioWbew
 05J7NAYxnyAyKOLFxB5WQ0zPIrM11ToRIsuYSFCtGaq55UA2KCTW+A+THNrZ7ajvpKel
 8AO8C4wzxNM1MiC2oHS9QRS1Hb1OS9RN+np7iW+6cH/ybQn77Vv22JR1+bwTesXvpQ6w
 HCulBGxPtMwsO4t6Gg+dEJFbkC14PmUBAfyQ3aSYYC3V1CcuyTXcX00+egeI7w7y+HhH
 qO7cmpCripEdDgPrE5oo+BT0k9yADE6j8FNw4lm+EQtJnAOPm1B2d5XXmrk/i2KKXPJ5
 xVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021481; x=1778626281;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gM31MTfUTrHtRP1fOR3g1odQBMJ7iuBeqqDdFZ/WSQA=;
 b=pqLuXnExKn6rW0LBVZP9YMIsbBNkkQW7sIahYqM2niWqO2r5UpSTaK54K7qCToyg4R
 XOXnvOgtYPGpyegDLynkacZghlGdMuy55lzhdRuyxl9HlZGFpoGJGS7kTi5i2JCJ5Nj2
 iHrDJLbknBPNPWHfHFMi+1iOxMZgOGbwd+57BrlAzpYyAA+cW2wjLZPy1mWrKB4CFrQd
 uBieclIHNW2VuGY7dTH/BhqUVnKnDDFIq396xBjLUBkKhBbCisaOBIkxVOhvfWPwJ9it
 GkX228xdUwrDYyzB9xPw1KO2Qw8AkZVLIfECGS+TuR/nMZxHdribKHznVYswsCM/jMJa
 OwGg==
X-Gm-Message-State: AOJu0YysFT6OJb/yDcYeiawBYRoKrXdTkYfaF7RKvKudrYYQrSVHgF9H
 37rZZKJMOshzTwJmLw7PBZbL438Z3To4uBd4DOpFj38y4Ucx7L9WQYMeDIbavy+eIkCxzVkSfwy
 i4W9bSx92nkBx8v6Qqunk6K+nytWb4I3J+OKQ20qX/i0+kuIvLMiWJzfXxKOiY9IQ7H3P
X-Gm-Gg: AeBDiev4+TFfmzSpeW/Ty7K4VLgQ2ez4yIbN0hymAjhHhOATyYsUfBYGdrB0ev8SCeE
 26N5AwZzfiyg8P7jp9QPCFbvor3TOgiWJchYA1GMoSTPhQgJvO+ak6wsOAue5xgggqfLZYPsELD
 YfxxJ6zv2h97IioX60CWDDKq/eU+/JxUrH8V6LVJJDh/3uUbJRozZfEoXZca1epLlVXF6ifvnSh
 i3BkJ2a78nfEXi4QU8IsOikZkQ0/ApDLSNobERimtT8O1OJUSnlGU9ORL0gEFwx7C1vbMf0sTC/
 VVN0cOCZ0E4nocv6cy9c7N7BgmFE7F+ieBy+Msje1zbgFRE/Vf86xBKlNfq5msVlqre6Gct4bOg
 S+q83h2djCqQ73MJnCTeJtoCNCabKPwldzfLMYUc4ji4xHzLd5tEDad/8qZUcJPo/WS+5Zh4Pka
 RlLzbh1dg72hISwplHOEA2cKTK
X-Received: by 2002:a05:7022:ef0a:b0:130:7246:10aa with SMTP id
 a92af1059eb24-131851d3eb2mr672506c88.12.1778021480560; 
 Tue, 05 May 2026 15:51:20 -0700 (PDT)
X-Received: by 2002:a05:7022:ef0a:b0:130:7246:10aa with SMTP id
 a92af1059eb24-131851d3eb2mr672480c88.12.1778021479988; 
 Tue, 05 May 2026 15:51:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-131f9686bd0sm883856c88.4.2026.05.05.15.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 15:51:19 -0700 (PDT)
Message-ID: <cb7ef2de-54b4-4931-b83c-39781ccb63d3@oss.qualcomm.com>
Date: Tue, 5 May 2026 15:51:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] single-binary: deduplicate target_info()
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMyBTYWx0ZWRfX27uYeYroEF4T
 IkeFeZ5asvSVbZMoTgjspEKAG9qx5JptHkfcH4lShAfsxCKX/YjVJJxv8O1jUs6x87zwNPHo6iM
 5znuqWzGehId9mQjdcVHxg74APUOG3snWw1Yl1mahvuU6JwgUkAGdMP9xvJhoeVKUb4A5Q95ZCU
 Owk+q9oVwfTB6iPmqvcHANwildFOvlghe4hb9O5Sgpc8O867MLtw2B84hh4JtxNyOqa1DFYEPEz
 wE19bi2DIqlv36HVRqzReqbiMeMqdjeWOhxyu0j3rnjmn3tiTCNKen+CUn/UShezfynugZdf9uv
 9wXCGRWXBd7zvXnoGL5SjGuoPvfc7gHKRJWEmIBgLNHqqjwjHiTevW/YMiFW0CoYStbBzq7uZyu
 X405clzqfpnbbi98m9mHhbY9sCOQzHayEloiMoiHf0siz5SR/E+9jKoQ/IfgXNtF09XDiOc2vBu
 GX8lZ24CPik4kzkqZgQ==
X-Proofpoint-ORIG-GUID: MV-JgC61_kwScGBUBXjjKMRcKsHo8C_B
X-Proofpoint-GUID: MV-JgC61_kwScGBUBXjjKMRcKsHo8C_B
X-Authority-Analysis: v=2.4 cv=edoNubEH c=1 sm=1 tr=0 ts=69fa746a cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=uBdxnfw8I0pi9JzHwZEA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050223
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

On 5/5/2026 3:48 PM, Pierrick Bouvier wrote:
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
>   target/xtensa/core: register types using type_init
>   qom/object: register OBJECT and INTERFACE QOM types before main
>   target-info: extract target_info() definition in target-info-init.h
>   target-info: introduce TargetInfo in QOM
>   target-info-qom: detect target from QOM
>   target-info: replace target_info() in system-mode
> 
>  configs/targets/aarch64-softmmu.c |  6 +--
>  configs/targets/arm-softmmu.c     |  6 +--
>  include/qemu/module.h             |  1 +
>  include/qemu/target-info-init.h   | 73 +++++++++++++++++++++++++++++++
>  include/qemu/target-info-qom.h    | 30 +++++++++++++
>  qom/object.c                      |  4 +-
>  system/vl.c                       |  4 ++
>  target-info-qom.c                 | 35 +++++++++++++++
>  target-info-stub.c                |  6 +--
>  target/xtensa/overlay_tool.h      |  5 ++-
>  10 files changed, 153 insertions(+), 17 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>  create mode 100644 include/qemu/target-info-qom.h
> 

Patches 2 and 4 still need review.

Regards,
Pierrick

