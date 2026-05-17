Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE0CCD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 16:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOeh7-0006Wx-OX; Sun, 17 May 2026 12:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wOegt-0006VK-T7
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:50:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wOegr-0006Ni-LJ
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:50:11 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64H4UNaJ784662
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 16:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QmcOr7paIhCa+bdjzm4h2PYCu2WBaDaw6pHmPl8rXJw=; b=pfpGZjB4xSNZfYoV
 wgfV+0lxdPWh+XfaGPA/WXQrTKSHzwwm2NCrzniq47qH8JmqalFNzMS2QJr/SwL+
 kzd/15LRFDocQBxBFr5HsAacV4mcb/NAhz8pxEAwwUZ8AeJpYaw3+oJCnD2AyN3+
 oJRS3RLEXy3hn4fgHRpCrSz2QewZny8irXsuOfP8+cTYHI55nel1CtvYbZkfUaB6
 pqXlj1r4ZAtMK3kJhdCTF/lC+O/SyMIxJ8JiAH0y2SRloJVX4oKDEwQ7MDW+XPu1
 uWP0ectMXqaIp6lgogXBsy85mtgh/EX9YtxIqqstmAnxR8H0vzfYMl6uuM/+XrcV
 CTRB5Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hbcb5j9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 16:50:06 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13312be8a31so5324778c88.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779036606; x=1779641406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QmcOr7paIhCa+bdjzm4h2PYCu2WBaDaw6pHmPl8rXJw=;
 b=OpgaJmbwk4BoCbWFew9XOCVLYpHmmeDcj6b6XWZqE62rA6aZRFmQbTqJ14AzpGclZO
 uA+ge7OYrJac5Hw5N7x1/nMxJe2OJJGEsJqEKRi1bC1z/F4mnim8M76yjVRn0YclwbjX
 8Jo4Kzwyuo1FdSu60005HT2xKKQvn0M+kUbT4/iHMcNYk1PkzfSTo49kWWRnuoxKXSAs
 URo/y0i2UetHVaZu/E9Kto9evoFK7mWacH8KcSC5G584VSNsAkEld+yqJW2kcrm58p+T
 UGId5XY48rBTdNznRT3Prb32jFkOUUmby7Gn4nhAFgiJsXGzXyTNbCWeosJzrFNPC+LA
 +q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779036606; x=1779641406;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QmcOr7paIhCa+bdjzm4h2PYCu2WBaDaw6pHmPl8rXJw=;
 b=MWV6ILWY8+KoN6h92MRKiGx60RRu6meD6+fdzj5881eyqymYmX2sjkar1gBRCT+65e
 m5D5t0JOp34S81xuEV2sHXOYcZzfZWaWiKt1h1UBCyJGRvZUgXO4DX/q8YN0J9xtEm/w
 WpFCLScv2bwRJFBmmXdPpyczJNGmsBmbeVU856RGI7/qB84o7x2H6GlXnOSGaXB55cKB
 ntTvR/8C0KXGkEQt8Z2G5KEc1f6gORfez2KiQ503cPG4CBOFM2a+E4+/Lc3Rl59wkHOv
 58+bX7E0TT+J9LDo+mv40wdV2rE2PMzejEoHT5P4t81W/ByLwxELkSAJhYYoj9FCWron
 Fv3Q==
X-Gm-Message-State: AOJu0YzGRaoL2Vru6xJsw9qe10NCFb/DW8oOP/xjDjsWj3PlKF9EI1ZT
 FY3I8mK2WJoTsXa76kiuR7/v/SoFANOO/RgM3HuQ+aYd1HZ1z9riqiy1k+AWmgWASZ5qkviS15N
 2XzvKjPCHeLwVglBL5QaK5EmYbwpEDcFPIgZ3+YNtP6f8QSqb+Wu/Z71uj2XNuPC9pprh
X-Gm-Gg: Acq92OHX4ctislOpIdj2V+g17KnqdjIizweRtnZ3O+2QpPm5pMOpr3NYIcRW2DznJnD
 yTqgYyZVRusMrbYM1WPbN+odVczx3C19q10yxaSp33yPtjCvefKet/+kfvvjzkYqJ9UCGGDjyna
 d1wlZhiF/SR3zxrQkqpVV2oW5LfJOhY3WGSprwEFZzPA7yiKwS0O8lzH/CoBnMt09GsFoSGdeZB
 8z7baRzDBEQabzTgsRovWmBIVj+zy3a8e5dF6dnMu1WEJMlbrv8biHCrVGZhsncn9x3S3cyRhsR
 oOWsJzra1tjUe7QvuIVVFKqjZz6EHJWI1EDQmrStn+VREtmTdmgiHCuwqyzKgrVLyAGdtSPkVBL
 TDL/GkmyNOtc3ZJYgmhnuf0k9LBn9eHOBOEe/JQsjUKpGZEnUHbylFaCyHXEzF0TF8fGymczoCh
 IJLlA4TjhR
X-Received: by 2002:a05:7022:7a1:b0:130:aa42:16c7 with SMTP id
 a92af1059eb24-135058326d5mr5433473c88.42.1779036605897; 
 Sun, 17 May 2026 09:50:05 -0700 (PDT)
X-Received: by 2002:a05:7022:7a1:b0:130:aa42:16c7 with SMTP id
 a92af1059eb24-135058326d5mr5433459c88.42.1779036605343; 
 Sun, 17 May 2026 09:50:05 -0700 (PDT)
Received: from [10.110.17.140] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ef5sm16965588c88.2.2026.05.17.09.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 09:50:04 -0700 (PDT)
Message-ID: <d11c5d12-6639-45cb-bd4c-3a93454f9f44@oss.qualcomm.com>
Date: Sun, 17 May 2026 09:50:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] single-binary: deduplicate target_info()
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>
References: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cuSrVV4i c=1 sm=1 tr=0 ts=6a09f1be cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=uBdxnfw8I0pi9JzHwZEA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE4MSBTYWx0ZWRfXzRUcoSsMlgvO
 hz7Q9XDFtEPlwrqIt0hEA0tUfKAC1C3kRc6qb6GnS8cBwEuRYrKQ/E5YbL4y4Fn8YWo4WnS6+H4
 y5VJQR/JEnwmhqHj3+byR/cApJXNRiSM9flp4iqLMH09JRVTYni1OqltE50IQ2NUQXaqRM438aG
 cOcBtggKdMT1AqzsQtC91JjyELXS1kFq3uBbcXfOyhoMl87Fa+KdadQIPGH6jHbqlI4LXJubznH
 qLGolDy50P7Y7wmqHdfg3hcoHoJmy6211enx0rdvQN8JtVhv1VNGp+TTGAa1dJreBSxX0+nOSPc
 ccCE0Bw3KytctfX0IfBxEkuZZXlWk/fJxvZnntrDTAEPXqAWk6dtyan1ycG8dLNvttAnYjhLDIO
 wxgPS01B0GnyURrsh4f49RSsORPWU1Fdi1LA3ay96mRTrmJ/fDvxX4y6qKx9zkpIxK4+ani0XHK
 8ILcF8PaU/BkW1YpBuw==
X-Proofpoint-GUID: mbVLpD6qu61eWueqeUd2YYSSPXDba6iQ
X-Proofpoint-ORIG-GUID: mbVLpD6qu61eWueqeUd2YYSSPXDba6iQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170181
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

On 5/14/2026 10:22 AM, Pierrick Bouvier wrote:
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
> v7
> --
> 
> - Init target info in oss-fuzz main. Fixes job build-oss-fuzz.
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
>  tests/qtest/fuzz/fuzz.c           |  3 ++
>  10 files changed, 148 insertions(+), 28 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>  create mode 100644 include/qemu/target-info-qom.h
> 

This was merged into master (66f0b110b6654d876cfe18ad735902622003eb5e).

Regards,
Pierrick

