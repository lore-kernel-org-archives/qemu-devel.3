Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977A9FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIIcP-0003JP-9F; Thu, 30 Apr 2026 00:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIcN-0003JC-Rl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:03:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIcI-0005ur-Vs
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:03:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TNuHTm3636528
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 04:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 02zXLgHv6S47QgegaL3qWD5CJ8gCYsNwboun3TzOzkA=; b=hkML2FNUhlAxmKtP
 Al6J8mtz+1jCV/aZuH9jm/hBrcipJy7P1s7CRtjaL3MS+AlhOudClsmGVg7lM6O0
 YotncUy0H4GfieHYSrfitNXt3Hmh8Cw4HRPXqmucb0cdt5swclkIU3IXGKf9zDgJ
 mRwVnuV2vadFegY37edPdHq5KtVGDpW2vZLe0XRclSsQwyWExb2pHpoZ14asGrkG
 gLqaCbsgEaJaeuDtf+m1bgwTX1rTUKx/GxVIf99zM72FbCw5FJjd3NRNINhrChTB
 dkd0oFMYaFuRBYeBALLMmompD+GDrIFQ7D+VIxnPTl9p92CaUhdDY6tMNsBOlKeM
 thu4jw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q0pv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 04:00:13 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c8de02a4dso2356771c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521612; x=1778126412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=02zXLgHv6S47QgegaL3qWD5CJ8gCYsNwboun3TzOzkA=;
 b=Mh2KpkzAvsEX4l0jTgkTEl+syTnVCLF5QVgeuMvLE6Xq67WJrbFCPIl8b3Wf5mvrvP
 G1FASI6ur/cemlfx7KyBWtxtbuNnKMkBqeq5nTuQqdTvZ3L1OxA4XWDiygwXgEUuQAcG
 9XWm9cN7g4LOEfBu5GqzFH++BiGvyHF9T6KZLnKq6Lf/UbL+XAI2Zl5U8AK78c7VqNso
 d17Z0AJI52Y7fgkokRyOz/p3GBy9+T79nSJnHrAEazRegxGn7ltM6njpbTFZ1k5Irzo4
 WcKdW6p2MkMBbTdiJzCV6Vzv2rlvG+UK4Jns3fy5AbHCFURwyZ78Z7Kmri1deafs5UsO
 x5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521612; x=1778126412;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=02zXLgHv6S47QgegaL3qWD5CJ8gCYsNwboun3TzOzkA=;
 b=RFP0hCE/j1coVqbJGzzh05mvI70m0UKZ5WM+guF2ehwlm//bGWMleUeihKvAtPDu+n
 ggnMpLWMUUs8BryVTcHTjAaK+RuFJktlXv/7rwaOzLppsNrzCabH4iT+aYtog/BXICBA
 i9wdIYtJUMCky0d+COWl8qaYX7LJhQg8w5Krlqvso9hLX7buGrSlxNs7LGXtv1r5OJ3F
 N3Lwe/Z8nBWyv6RuHe+liEQYVlEVHyhnVvx0YVnZ17X/Ribq46KeGtJZkGySAc9D1xwO
 1DClmmNVm0JIk8NYD5AMMbKSe5T5f95GHuL2SNBYHGlYpS9IBHtF0pMKEoJmUVVqBvsx
 JFTA==
X-Gm-Message-State: AOJu0YxPpYZbH35mBHJXwyPdmh0GWQuV9XoeTM3krwQCZerLdVSep/dz
 Vieq75UoBn6kz2uYdnb8F61MQsybNXlzvj6yYudc+NkBvLBhQ097CAbGOG+a9lBDTKyvYXr4bJ+
 Bqj7vgbovCMfwwWLVinFzopYMwvSNxiiP9gmBiw8NTzs4rQRkBXvcyKqhDwtLISh9Q09M
X-Gm-Gg: AeBDietzu0ac1F70clyGaDMEH6ZvKbef5EgW5vspPHFNol+6wo7JE/7NaA2GMACUnuG
 NK2oVyuc8pxu9SLwdnC+ziX4hTSwyxzV6SaSPIQeuWKvXUZpaBfp5w5EZMBeQFnCldVpMxh5LRy
 yP0XL3E699ptuLzKFRBV0eK2UGZ3wZ3KxM70i3kNibanee5HWlUXJaYgZw5wt8i8C1u3S4Uult7
 fHPLYeP9s10BXTbCXGbONvnM53og45J2wn2EftHDCSiFQxm20St2YzpqtdUWs/TFNT572fGFk2j
 p/PAmoTiAThcooREQbMnXRUgeBwIInCMPlrb3WfiryEY/FHlrrTSH3W0HD/KCWBTfjhK5pKSDIa
 ep1UVW8nrd+FhtUI6ZQnA1oW0eNxouWpDLmkjDYZt3MGq8+LmqTH7gtPnQfbrRRGfdPvh2ELQhI
 YUrGwC2l7x4GrFLOoNQMh9KEda
X-Received: by 2002:a05:7022:2510:b0:11b:f056:a19b with SMTP id
 a92af1059eb24-12deac72761mr713604c88.18.1777521612244; 
 Wed, 29 Apr 2026 21:00:12 -0700 (PDT)
X-Received: by 2002:a05:7022:2510:b0:11b:f056:a19b with SMTP id
 a92af1059eb24-12deac72761mr713579c88.18.1777521611611; 
 Wed, 29 Apr 2026 21:00:11 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm4941134eec.24.2026.04.29.21.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:00:11 -0700 (PDT)
Message-ID: <fe238e88-c6cc-4339-85c2-5ffb05af939f@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 21:00:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] single-binary: deduplicate target_info()
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: osZYtBaveVBKC8QDgB5C0iEn62Wlnp7I
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f2d3cd cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Y2j3AdOTtJS36E6jY_8A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfX5AR98ftslCX5
 /jl0qx6rnVojuvifc99qUENSnQOB+WDfajCeccZO5kBeIvc1Nvnw3KyIsiKoLF3XDBfe04gz593
 /ub67lDJzPAZxga0a+ZmcTEk9dyIv7R1HfcQ3FHVdV1Kq18kgkc8VMflAhtj9PqcRbQTmr8Cmb9
 qUPhsNkZvUBn6TQTukzAJTe6YtALjWdzRbRGfWKmOY2fo/lDm/jq67Qi2c5gSG63qg2y7bwOr9m
 MZEZ/ZycCVkQ+8I6pmXvs6X3fhbbhmeeMdYRsOK8VyhNUM7PDM+zEmkKvn7l35iWhwGy1IMonUu
 ChuKZcVWG6J0Heivfo7bXqQRzPikiyULdRtOJJEJgtgBzNIykAOKPvNzLMWckKv65jkMzlgeKfw
 ZJ5U7HcNvtUWmGn+zht1xL7yLbfWYnuYpq4f7Pfz/oVFTGABoWIIf2Bm2wWoYqimwRFjzV/i5vK
 9UnLB9iPJ/2wS2nmedw==
X-Proofpoint-ORIG-GUID: osZYtBaveVBKC8QDgB5C0iEn62Wlnp7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300036
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

On 4/28/2026 4:45 PM, Pierrick Bouvier wrote:
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
> Pierrick Bouvier (6):
>   target-info: extract target_info() definition in target-info-init.h
>   target-info: introduce TargetInfo in QOM
>   system/vl: initialize QOM first
>   qom/object: add object_class_get_list_by_name_prefix
>   target-info-qom: detect target from QOM
>   target-info: replace target_info() in system-mode
> 
>  configs/targets/aarch64-softmmu.c |  6 +--
>  configs/targets/arm-softmmu.c     |  6 +--
>  include/qemu/target-info-init.h   | 63 +++++++++++++++++++++++++++++++
>  include/qemu/target-info-qom.h    | 25 ++++++++++++
>  include/qom/object.h              | 13 +++++++
>  qom/object.c                      | 40 ++++++++++++++++++++
>  system/runstate.c                 |  1 -
>  system/vl.c                       |  5 +++
>  target-info-qom.c                 | 32 ++++++++++++++++
>  target-info-stub.c                |  6 +--
>  10 files changed, 184 insertions(+), 13 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>  create mode 100644 include/qemu/target-info-qom.h
> 

Sent v2:
20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com

Regards,
Pierrick

