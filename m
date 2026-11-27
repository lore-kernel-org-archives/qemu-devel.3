Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004DA606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YURC4ulu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X7KD+8uo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1be-00065J-RV; Fri, 27 Nov 2026 14:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX1ba-000644-PR
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 14:27:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX1bZ-0003nZ-4m
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 14:27:34 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJRNUi2668952
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 19:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5yv/zmPSzvp5qNBuMWJFyrqOrr3UwvYV1XtcWC/HL6k=; b=YURC4uluWZFFG2gc
 CjcjBIPiP/bpaxojtJUqZWMX7mdLdE9T0f3u3lGd7GuUhgANizJnB9jJJ1ydmTTR
 xeR8zroqmKVjdAF8CLtBRTJ37875olAfx+0j4YgQv41tztzQajV8bSPu1P0urbRl
 ROqdkEtOEKiutQSF3pHNgKJMYKTX2i5duWLgh3V835bhUcjYLTzgR9MQfqntaUIj
 cz8Uy/5klxQC8lcenUWT27GL5Q7BAK4Pru24pmj60ACJkdlFcUnc908PGPYkrAYg
 4MchWSCQ+LfWratYOm1syxqwYJfWK2dIcCHKKJ9WddtL/MkrbPEAvc4UKybQd/eF
 BJqP3g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1jg01d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 19:27:31 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso5160177c88.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 11:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795807650; x=1796412450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5yv/zmPSzvp5qNBuMWJFyrqOrr3UwvYV1XtcWC/HL6k=;
 b=X7KD+8uoow+JxQ9q3kJI9vtBT7CJGLEzzI6qsozUdaPyJQQoUoBtqHG+6+r+dFeat/
 OOLKVoSZNwtk/4wpiWei3SddYVkZ9PXHYamXwHBdOeolLOT41iL2uKtYIRscmWXDc3CZ
 5Jkxf7VRB7tho1xnVcUCJxSPgLqZj5nGHh2xKJNaBQGGX1m2v4JEiGIrWLr5JxU3Ni0E
 RDMVajdJdBXfGqvvhyErl5zodPiDqzaf7PrYn7DiAkqRt9h2smKjLTx3KC6Deti0HheA
 EOz09jMRC5Vgs+85tCkfcJI3xIMJEZubx9cF2xFvzbSvVtFfARKi2DDUmqLkTUs1Otnd
 a/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795807650; x=1796412450;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5yv/zmPSzvp5qNBuMWJFyrqOrr3UwvYV1XtcWC/HL6k=;
 b=qzUba9IBiOzhJjx7VgXNnoeRozF+f0oMO6FHCU1OC1UTQKjr217bbcxGJuSddDdnmf
 LZP5PkQyBrOjPpIIcxq4Vv0FWQPtZRdnwlLcOHQRrYLEqW/R53B/otOLPwkZDJNhzeaC
 FZbidwBX35fouwKSqynTAutXa5UzYdA+fm9rEolJgx8Vgd54310lD9xPOlgB3YX6OBvy
 nwDnhXd6QXNEQtsl0NSVg7IGdqhkzoQ2ubijTsKM6CoxwAppA6ttaNgjRuTz0nsw+IR6
 bRGzb+gpttadMB1BHxSq5IvRZmCzTyE8r/+K8g3Kf8M2QfCwWP6j8bF/fIRx4HtfVNui
 Ii/A==
X-Forwarded-Encrypted: i=1;
 AL+hErFcsPK0hJz11Y59DYzUQOOd3GLKfW/coQgCyAd4ACRovW1Oh1zvD9UwlVI/R+4HWLmDY2bS3ZTQ7y03@nongnu.org
X-Gm-Message-State: APuU4Z96Q4fjViIQhSIpqPPIPVeIYOraYVVytY7LrSXxavrDvGAV5CDC
 Y2Qjt6iFAhhi8yH45N3CoPxNmSXHthIYpD4Bfl7MryjfQ4Pizw1BbUok5J0h3WZcrkP1Z/9WQI0
 RvFi0uemfoHeCCV28FfnTN2hO4hmsj1vsnIufEZd+tTk3qqI2hSUTA27SXg==
X-Gm-Gg: AZFdTZef3PHlovOB3hjbYLgTlbfcTDmNCyuIOJvV9avsUOdYA53joO8Q6OKa7xWiNs+
 Sb7JcVx8/Soln7/1H/DGm7TBC029BLRf5lGLJhUgu4hZeAj9FmSluUPLKiMw2khkCvTRRl9Qfti
 asroQ1DncbDircOWfEkpXCXCagmwKQhJEH7Gga45tkCWVrO11gxa5zq7N2gXq1W4NkDMFxpnaQE
 ykRzUpGNdO03+fnJfYcNmdLEoaaXFDoJiVxgQr12NY3NznTQe2sPeGAor3hevV5neJwaESodvp2
 gfPNVcAK0HrLVAJeatVcH4ajuQL+8djruegLRrDHYIAx8/uK1VnQE7LDvUt/+MSX6tIhyjs1Qbv
 nGg9WuczwrQTFawkXzeFvwPh0eP9+t7RbKIVwTBjNRtvBRhZIvDjYAS5L9faXMBUqQtCna2EM+0
 U7FGQO+NnmJxMmhiRlRcxFRIhjWpudCM4p7PAzQHrRkw/0PlNAXQGL
X-Received: by 2002:a05:701b:4555:20b0:1a2:2da2:b278 with SMTP id
 a92af1059eb24-1b556894b6emr27457295c88.14.1795807650155; 
 Fri, 27 Nov 2026 11:27:30 -0800 (PST)
X-Received: by 2002:a05:701b:4555:20b0:1a2:2da2:b278 with SMTP id
 a92af1059eb24-1b556894b6emr27457269c88.14.1795807649638; 
 Fri, 27 Nov 2026 11:27:29 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5569bffd2sm55023067c88.0.2026.11.27.11.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 11:27:28 -0800 (PST)
Message-ID: <79e927bb-dc28-497c-892f-6916e6a832ed@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 13:27:28 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 0/5] dump, hexagon: add support for cores
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
 <899a468e-5fd7-4a99-91b9-309f83ec1d4c@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <899a468e-5fd7-4a99-91b9-309f83ec1d4c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3NyBTYWx0ZWRfXw1pcE1ZFekxC
 g1WStyJiG8+3+govoft4Xeppvy98YdwtS0AfjD+yJKwo/zYenObn4NyiwoC9nvrPst1m/tRYGE+
 kDJQfag8Wvl0DN/z5niDEAVELpi/WGToSJd3qVEb2f3G6RnMA9GRqwS+Ml/FlxNvGN4OygWHvFR
 RCpUzUrwF1Emcnowx+jA2xLxlPXzgbn041SHNeYfIkZKHVRT/zmQqKrJRuWSiXdWk1MxuSLLlXv
 FxPt3ELzn85DLJi4kYM3aqeFhEV1jQJsIkZEMuXHLymiL6tSS9muIQpG3gaC0CY/sEUqutpWf8c
 nUywHRV7XVPzNzPZyRPacp2sXELJ7DeIz8mckEEkTVwZE1zjTridMbrfYH1RIsghGzMntxTkoHG
 vAZXBVK8blGJWF1eWV7dqtPVeUBbsMjZDuysIUL9hrNcaEeU/+3A2B6l28wXAqkmBP+MvGjPys+
 xt5KssTkNIVLYDaCBiQ==
X-Proofpoint-ORIG-GUID: drUBTcbUXwGgjx5EHZUVD2nXAMsoD4JR
X-Authority-Analysis: v=2.4 cv=QpzLTlyd c=1 sm=1 tr=0 ts=6b09d9a3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=u-f05wyYrlj_e_UGnmwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: drUBTcbUXwGgjx5EHZUVD2nXAMsoD4JR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3NyBTYWx0ZWRfX95h1hRTJ5IoU
 K/LAfN+ol18yRiEiZQ7Iyc/+l57c6zrL2GFw0GHzcOjz61VsdHc+TZM0G+phXDd8qW2qEw4xC5P
 ZShFxHn9c2ft3bPrut4dUmt/X2CRQOo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/27/2026 11:36 AM, Pierrick Bouvier wrote:
> On 11/25/2026 11:48 AM, Brian Cain wrote:
>> A bugfix and implementation of core dumps for hexagon linux-user and sysemu.
>>
>> "fix e_ehsize in ELF core headers" seemed like it might not be appropriate
>> for -stable, so I've not specifically added it as a Cc/Fixes.  Could it
>> cause some incompatibility?  Seems safer to just land it for future releases.
>>
> Was it tested with lldb, or something else?

I tested this series with lldb and "hexagon-lldb" from the Hexagon SDK.  
The community lldb fails w/"Unsupported OS" but hexagon-lldb is able to 
handle these cores.


>
>> Brian Cain (5):
>>    dump: fix e_ehsize in ELF core headers
>>    dump: let targets set e_flags in the ELF core header
>>    linux-user: let targets add notes to core dumps
>>    target/hexagon: support ELF core dumps
>>    target/hexagon: dump vector and sys regs in cores
>>
>>   include/hw/hexagon/hexagon_tlb.h |  10 ++
>>   include/system/dump-arch.h       |   1 +
>>   linux-user/hexagon/target_elf.h  |   8 +
>>   linux-user/loader.h              |   9 ++
>>   target/hexagon/core-dump.h       |  89 +++++++++++
>>   target/hexagon/cpu.h             |   2 +-
>>   target/hexagon/internal.h        |   8 +
>>   dump/dump.c                      |   6 +-
>>   hw/hexagon/hexagon_tlb.c         |  17 +++
>>   linux-user/elfload.c             |  14 ++
>>   linux-user/hexagon/elfload.c     |  14 ++
>>   target/hexagon/arch_dump.c       | 129 ++++++++++++++++
>>   target/hexagon/core_notes.c      | 245 +++++++++++++++++++++++++++++++
>>   target/hexagon/cpu.c             |  17 ++-
>>   target/hexagon/meson.build       |   2 +
>>   15 files changed, 566 insertions(+), 5 deletions(-)
>>   create mode 100644 target/hexagon/core-dump.h
>>   create mode 100644 target/hexagon/arch_dump.c
>>   create mode 100644 target/hexagon/core_notes.c
>>

