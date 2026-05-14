Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3F7CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZoq-000679-0W; Thu, 14 May 2026 13:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZoo-00066v-Vf
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:25:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZom-0006j2-Sx
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:25:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeQ7T3951578
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fTLfILI4cFAFTB2fFdLIYUrxYuZRtDMd9bRF4gYUjEk=; b=eZ4/QOGDu1BhieQ7
 3/O5XoEETx+FeUHUSPQy6+ZNM+f+WpO8iSQpmAVli2RnDQix87KSZjLHzW0sdhei
 bqzRdI2Y+ymHhAnZ8+OmqGP/MR+ARDDz6GGqvHGB8kJ21CQKWlghfo4iuu0vMw+q
 SQrlQuY0hVBBuxZRB65nixfW70uOPcN1Cd8aNDhBpjDbVexlZw+YZb7D57sPW/kZ
 pJskvuDeJf74f8eeQVLX7NptgBiuCofcn8s0H7i3dOuApSAwNS5bnrDVavixub3X
 z67uNzuNOOA0G5XdPKZ7bR+uEDTZOEjtZ0BWqixow5xLvT5WFpAPKggmr7vQZLqt
 3btOLQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57kstpqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:25:51 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13367aca29aso3349683c88.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778779550; x=1779384350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fTLfILI4cFAFTB2fFdLIYUrxYuZRtDMd9bRF4gYUjEk=;
 b=Ls8VBdhwyzbY+N/oRT0fmFmwCOG56Qm9Lzpr/Z0hmb/8Bb/4SDICAiwZhEJHvA9JzH
 UDnkNvz82ZG0TJITbQnlnkVgMrUGle/Dm7jdH7EdPV0n9S82V/Bt2/0d1+nqyEBW7Gow
 YHo9ZGbwQiX5A162qf2jI7+X1bb29UqtZh4bLraC8uYWvj49Xk/p9pR9E5qrIPrjScae
 SDS4dClm2w2LtQkn7FOYmACP713Z8KxuCAOr+JH9JuqxnAJL3RaS47mCB9jCCf3M2Mei
 Irrqe797Sy8TZrsn2JWAB+4+6IY1erLVwhqtXD/RjDYJYLrLRAkpGjjyhsmXGmDiP3dR
 vVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779550; x=1779384350;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fTLfILI4cFAFTB2fFdLIYUrxYuZRtDMd9bRF4gYUjEk=;
 b=l4L8YSCGGWZwWaWiGIRtojbvyFXxpqXmtZ8LGrERqIafz8AmsFZS7iW+/8YgOkyDXU
 BGWwLoEJo00QVlvCdSDa/8QopWczH+wEisyYdLsQnLFm4cK5OGgJYnqMCQv0Cl/bnSOm
 Twu1GhV6YJwvfssec5Utld2/A0ljMCYorGHCkLIZKYY53yLkWTDBkkqc1uYrek0oTIfU
 jvPPyoL3+sBhqqZiA1wY6ue0YjDdXp2dTyJG9BNDRDyiLTovHyBOyQoEmJyAkoFRXFTz
 yoW0PGpSUCdHHof4ok5OM7Pi+gC3Li0vsZdt3FFRG1cB7jld96s800nS+DKW7+Wj6tBN
 oZhw==
X-Gm-Message-State: AOJu0Yy2kRPXokT1BacJt2BjJk8fuWxPykVYTGdIHSREzrafmWt7VdHx
 /mWSI56RTAnslAV4PqT0WmuKL6xLfKI225nM54cim5WcRwrG3cdZmRPTqipZi7O2AO+iXH4fY8e
 G4oxI9svFoWSQOII1z4eTncJ0bhJe7hWpHn91f5F60Ci/b/Mxv14lzKq560FMqoYfrNAq
X-Gm-Gg: Acq92OE4fDsFcT/EO+dm/dNilhZGMc2nsimTH+Q5/RPw/GPizivgHCIluu3xAOnfT1I
 HF46AYyO2k4h4DfGEVGafn+7errKcK0fbau8kbOySU0qUrSliTpXvayZguGrdS0VROo2ONxKCK2
 FqWelnapHiRwx5fivVDvNZiYB2qfIqCe7bH8ayamlf4dg2YustOJ87QBN+O23dY0oL1GIZY6Ygu
 VoPjHvUpAZgw/mlMek1uRvSpYFPWBkuQKGkmeitJnq9z/bFsB3uKfdOtztWYhdMjxFbcwM5VNPm
 Lafe7xlsupzBVrqnz42pQOuJnBJMlTfzR/zRJxeXzAI8Qqe742Ny984Ts58qrpOvLikCp2+KVWe
 7mp+GZIage1aRcTJjINTd2T5zHooOrtsFw4VXB7mjfGTx8RAuQtWSlRjtkSG6hsq1fMPCrHKnWF
 +PIt5tnr/JYcIUwA==
X-Received: by 2002:a05:7022:41a6:b0:12c:6da8:856d with SMTP id
 a92af1059eb24-1350473aa68mr14139c88.26.1778779550437; 
 Thu, 14 May 2026 10:25:50 -0700 (PDT)
X-Received: by 2002:a05:7022:41a6:b0:12c:6da8:856d with SMTP id
 a92af1059eb24-1350473aa68mr14117c88.26.1778779549970; 
 Thu, 14 May 2026 10:25:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbed531esm5427037c88.8.2026.05.14.10.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 10:25:49 -0700 (PDT)
Message-ID: <dabb0b39-c143-405a-82e9-fce6674c35f2@oss.qualcomm.com>
Date: Thu, 14 May 2026 10:25:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] single-binary: deduplicate target_info()
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: I6A8P35MEcNlbF0wvNvTPelkjkmsChRY
X-Authority-Analysis: v=2.4 cv=KZbidwYD c=1 sm=1 tr=0 ts=6a06059f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uBdxnfw8I0pi9JzHwZEA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NSBTYWx0ZWRfX4zIXdbnoeUrN
 Kqog0YlJtZ53dXuJtrm2aWlWmBRknrSyPqnAPS98kqPW7g1JXQiOiAJsrBYAiEST3M2JrK1r5GF
 OuAPvB9gxloPmPhiDp73P5ot+9sUFFX/NXb/pG6S/yK04LifsXAcm0GQpBf0pnJz14oKQn0c70/
 5H8yVmOjrDr0Jcik6ofGoKIeERUH/ftxyS+F/66Z+Nfwv6C1KI4Y9/0mneqHXTpT+m+V5n9S+Ro
 V9jecKIsZLgTCjmCa/ohLOV0Orie9b0hxcykAsZntL1XtGX+aCtK8c56zHQaf+jgjxVRokjYAoi
 A/Axy/NntL89q1tIBSySBC0ziXLjBce1I4VJO8ztdonRxnNIhztB9zjghBaozX0tGvy6UtoBBo9
 Ss3mgbWpJxl0n+sq7MB4Z+FiNG0VOGSCj2iyFyGwwA+0ZhlEROLEzAfreac740X0GkFaUNYFAq6
 X/kbvQqX4nxjvzAcnXw==
X-Proofpoint-ORIG-GUID: I6A8P35MEcNlbF0wvNvTPelkjkmsChRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140175
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

On 5/12/2026 8:02 AM, Pierrick Bouvier wrote:
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
> v6
> --
> 
> - Simplify QOM types as suggested by Richard
> - Use class_base_init + class_data mechanic to initialize target-info pointer
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
> Pierrick Bouvier (5):
>   qom/object: register OBJECT and INTERFACE QOM types before main
>   qom/object: initialize type_table in static ctor with fundamental QOM
>     types
>   target-info: introduce TargetInfo in QOM
>   target-info-qom: detect target from QOM
>   target-info: replace target_info() in system-mode
> 
>  configs/targets/aarch64-softmmu.c |  6 ++--
>  configs/targets/arm-softmmu.c     |  6 ++--
>  include/qemu/module.h             |  1 +
>  include/qemu/target-info-init.h   | 53 +++++++++++++++++++++++++++++++
>  include/qemu/target-info-qom.h    | 30 +++++++++++++++++
>  qom/object.c                      | 22 ++++---------
>  system/vl.c                       |  4 +++
>  target-info-qom.c                 | 45 ++++++++++++++++++++++++++
>  target-info-stub.c                |  6 ++--
>  9 files changed, 145 insertions(+), 28 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>  create mode 100644 include/qemu/target-info-qom.h
> 

v7 sent, fixing issue with oss-fuzz:
https://lore.kernel.org/qemu-devel/20260514172303.1484273-2-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

