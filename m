Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10423CD37AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 00:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLW0L-00038W-TX; Fri, 08 May 2026 20:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLW0J-00038E-Bt
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:57:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLW0H-00069f-DT
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:57:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648GTf8G145193
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 00:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 htcmKaI17OSjSN2NJ9Vg11AUTBJHptKtDxJu0pGzdow=; b=PnQmC1g7dA8Sa0MQ
 lSQHCQ9U1V5o4X332YUCWAvRUF5bBWax3a+wEbMVU7WmdfO4EiPdOciO8jCij/Lk
 8ZdkxSne+zLIx42evJopuo+j4q7vfqNV64ko9NnOXiUZsRzbBcfwTeNTD5MLPObO
 1BVU7rSvXUg/eua3vUsEYL0lH2QRda9eMUU5q7YVXqF8Us+EXQ4cvIaTsSkCDUpf
 8OOXsCj+C7ePR/f9kJOGXyGW10X5XZDSKHFt4iqGpBmBa+Dt+ldihbLjDlGmrL6L
 k5ZF9Wo/a0x6Ll82CxhDnAaFhx5itjfsxhoN0Szy2TSxquclMhDMe/BADRghkQrU
 vX9weA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1kdc1c53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 00:57:11 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b81ff82e3cso2009053eec.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778288231; x=1778893031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=htcmKaI17OSjSN2NJ9Vg11AUTBJHptKtDxJu0pGzdow=;
 b=Su2+aHEqd57ALWnopJjwC0/VR3pjLETlEqblL/F7zbGzrp9fFic0i32ZUQf0flUqhq
 9kcPORtDex3TmAaDKi30rYFZhvxUoGcEHk8nfQ09dWhazRr0Uzi/ckI59BPkLCYtXQkl
 QULzPqBB82UfzKPn8fO88+T40cRC+UIuJNinZOcNORiCTVSMItf/rrIeJb6nMzGa3tdY
 y/mxxnxpwuabWZ5aswSRsNHyg4L4CBdE51l+pfVRqJdb1H5teqXcSf1WFYXEqWAoWEnk
 vX0NL3RZwA4kijU5n0z3SzYufOxp0r3S/bBk9LkwTyaQk0d9AmhrGqPEkpxinO9CPJih
 Oc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778288231; x=1778893031;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=htcmKaI17OSjSN2NJ9Vg11AUTBJHptKtDxJu0pGzdow=;
 b=WyL5EzyhHL0Om0BRv4n1zeh4sFxWQMNiwx6kxztk+KvarUlejEmKr9nx0q0qBMYqoR
 W76C3039s4kv1jwrCVzsf0H5I07P3BzzVbd4C07OgoozwpuIrOLG5nISxvUq0GKjl++U
 IgY8Lt3GNDTeI350PsSSSZMdwndvgaAYVDNEYPB8emVmKRxtrB8aTy3ExxnsNEoyiFA1
 7k81UreHWQBV17o0CEIDS/fWtQRZLO+M6gM2ZZo6NfasO0F+RFQNyA4qibgjD94wNOik
 WEyLynQDkP1BekauOMq/itXCnlM1I1kln/jOiqnlFN/kaIQB0M/Hez30F/lEcrOR35ev
 ZvPw==
X-Gm-Message-State: AOJu0YyRDwHugO1pcKd9qb3EvMyekmCVphU5ziI96O+91yXcd2FzrW+0
 i11XElu/e094h/2O2xo2RSfsxIQLj12qcQubNg7FEkmEbj5wTkvKWmsOIvX/8BXxwDJojHpZXBW
 WgrRzLEXwmRmOcZjIWOkZiCoyp73L7wuByW+0nJVzwpslanbJjMV8HSRBWEv5rUDJNm6d
X-Gm-Gg: AeBDiesEyn1PjZH6kdclJLnJjqf8Hocf6fzs4fEep27qVWz9YNvVwoZIBPuURh14DUA
 d7LIgCKsGZl3aqu/bMSTsdxvxivfLQ8wDrsUWeCelsXwyXNWkVz/sRREiTYpVTTLXjvDrbcmQcP
 QE89cMCiWrbFZWoOIsMoCnMzqFCIH/7EtcMTmE+/+KpCch1QXOO2+s+KnUAuUqHO+ZLBsV9BIdR
 psQgLZWtwD5iJpaEmHn4G80gX5rinWJHnAryQj+Av6CYdKkBDANhYYu/oEJiZNv1aIE1VyrQaOu
 VMMBaC2mRDr8cvuyEGO2h6YcYRolgi5mfGorX5CpOvK4RJ257b/yo6gOAEJsWcHSKN/jGNiWRbX
 J+sgTizVnl9mfdNFC0CnPQTtHdd28Zo6b/r16qAEam8KNtzlkPKND3ZnOrkpxbLb0HBTEHc+ndO
 SwcuaxXt0wNgHYXA==
X-Received: by 2002:a05:7022:e0e:b0:12d:ea50:31ad with SMTP id
 a92af1059eb24-1323aa56f32mr4384844c88.5.1778288230787; 
 Fri, 08 May 2026 17:57:10 -0700 (PDT)
X-Received: by 2002:a05:7022:e0e:b0:12d:ea50:31ad with SMTP id
 a92af1059eb24-1323aa56f32mr4384822c88.5.1778288230273; 
 Fri, 08 May 2026 17:57:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327875a269sm4628394c88.13.2026.05.08.17.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 17:57:09 -0700 (PDT)
Message-ID: <15dd2d50-50bd-4d0b-b402-888de685843f@oss.qualcomm.com>
Date: Fri, 8 May 2026 17:57:08 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwNyBTYWx0ZWRfX52mIYytvCug8
 TZgOVC2jqLBfoCxvfjYp9pUPS9dfAzmk5/j+jFtKzn/uW5kIKbfbv8p957vwyka7vBazo6Z4Nty
 GfJXIqRboMQNR2eyqTUfTvKPmp3wUfBlrKUGP9o/ZR0sua/S9IVp7qoRbcbzmCaRe+SrkGK58A8
 9UaovZKcc3OiZxD2/YhrOEdLneX5XqgA1l2qPK0ic2Mi69P/XaslNxReXIHGB7E2X87ZXdhlR27
 i0fvlG1bIfdP20F7TIMvYgLZaQHXk7ZQ4welYfqRCjQ4U/gWdv4shFZsdCTv4BO2hIemd/94wMR
 FKy+u1JQOWi21N/jWDLQrtu2O8AuhiEGO+kiQcbZYiLSg3p4aF2YKFstYR/D7ZOq8n+fMVz8JK1
 lUfdGIo6TcPhBZYnB2G+g0MxIfi8mkPuJHjThk8xd5DwKLK2Y9pCms3V1TSluKtW4yPdOnGq1Cw
 bbLf6vaEs6DndyUfqWw==
X-Authority-Analysis: v=2.4 cv=RZOgzVtv c=1 sm=1 tr=0 ts=69fe8667 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uBdxnfw8I0pi9JzHwZEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: H43fVXiVKwb_u1uqvEUYbnSQYaWRUXUK
X-Proofpoint-ORIG-GUID: H43fVXiVKwb_u1uqvEUYbnSQYaWRUXUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090007
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

sent v5:
https://lore.kernel.org/qemu-devel/20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

