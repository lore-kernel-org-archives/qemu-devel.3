Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE99CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGjri-0007nz-S6; Tue, 13 Oct 2026 17:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGjrh-0007nf-IC
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:16:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGjrf-0001oH-KS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:16:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHNLPj2332976
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3SX67Zcp+lSzSIiZwkh92ubZw0TmTBoJ3RJIwg+NSUY=; b=UioxSNjEsrOGj+lF
 smYdw2c/huY59DztNPwrMwvs1fIqVpm+toMxy0ji/vXdhK+lIQttxDrS+xm7Vq7k
 TUSprDNKPL67gsFfDUL4umTeFY6Nl7JI9cC+dWSSovkQMtJyYs0EmSmW5VShTnD9
 EZDmD4CFgy6zSTSys8ar3LUlumPquQ+wlOIMDI7oo38nu/46qiallqGr5pd4ZSeX
 s0qMlOevuK2xBrH1ONYC9c2rmKhaTBX35ezMAZJ0wgTv0pC7gCOawSZe1QWwDZvQ
 eczgmHhr5CtUVpAEug7zvRKP/zWnlHj38jJxfSgx49PM/2uRFX1cIg7KUrghgYTC
 TpwzYw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s0hgycg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:16:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd0cf3b1c70so300557a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791926209; x=1792531009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SX67Zcp+lSzSIiZwkh92ubZw0TmTBoJ3RJIwg+NSUY=;
 b=I7YV5Q6WZEEKCP2clXGR4zZxnJfig6cc7RXAaab6yBkQXJthYnVPhGlr/mHNYTK7Pd
 JNZHhy6PHAiHQgwlCc2ycy0CY65iSH9synW72QCBtADW9iJ4oYUTl1olBLvyekvMKr6O
 SWsWA2ZMF1kq+0xQLkDARkMK5T4ZSNJjoFDvfYx/9P14qejdV93Ihy7hLkEsoeNuUhXL
 5oyHX1Fjc/V+ANx0WwGqn4RqbdnMEe2zuC6uyZDzjcuC0kuDBOoeAUgtyvUIdZsBPs/W
 dS6QH+46BAxD6ZqhLRSyG9xMDYRTxaNgxCgU92Iu3PTzuZG+fv0ddnJU5eUu0N+Eiaxe
 AY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791926209; x=1792531009;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SX67Zcp+lSzSIiZwkh92ubZw0TmTBoJ3RJIwg+NSUY=;
 b=IlWq+XwreQIcTHD3W6sABo3BnqLLhfVdmHGsiITyqKdZXyqyA6ZKspsjf6W+6jePN+
 e4XRkf9U1jbdQSqOfhJ+Y8WqsshmtnJGxB3w0FCM/hwmyBYNoZas7pGoZmcpxP3oO/kO
 EJ9GG4jLj2puQlBxeS2zWTG6g30l7gI2Xz8W9GOehLcaj54Q7EPtB11PqwfEdBzAhy/r
 Ta+Rn0sCGHkfz44lvLq+6vzNQUP595/BicgNFkGi8IBUmEDK9rV0Q01v8hTFQdNRYxRA
 4YsTq9/NHu04cDvJVONLNMOU6ij9JnB/9z9MIZxcaqPz7RAEqJQz8KVHklc6TUz+yXnj
 z3JA==
X-Gm-Message-State: AFq9FYL5qAAn64TyS7kbkzJk3dNbRL3ifcFrW/W8W2Fcz0h5LflLO3B5
 jFEJ24BMN2frH59iOMPYtCMk3YR9Zk9K6sUaMaHlIq+Ry2hjaK7w+Ha46ygiQJbNThdRy4TtKyd
 oC7omn3r3dOgBRzbwpoVkX7HoUI+GA358YlvFUYrTPBkZVt4simvH+pn7yA==
X-Gm-Gg: AYBFou1Vz7qFTzMA0jqG5ARG9WzZRbiJ/VauR/ZDIGa8VQJZTT4w36e5lMc/KP1s/iP
 W9rrYfmNgbFIhEbRIYN7YqkByJjaFZb1PAgUQz8tuWeMRM4r8lDUA9qb+OY2jVGW+Vt+h+8IkFw
 GA+DtPxW2iMam1nDYCCD/eIqK0V9gH1Aa4VXwqjdMCLylZAmnn9Var7WkLASTi0WgBLheper/ZX
 gbVwkEt0mKS5/aLw1HOzLDrmCs+z2Za9a2IRzs2wUwyZzF4veoBWC3rB1jLv8HqmVxVT7elg/0o
 YymZAiyVSst1BqgZXC4K8BI3lKQu1TMsk4A9SzW4EAqo99jWPBqr5hw4RRy2xlrz8AYkMGTz1F3
 Wiy42ac/Pwv6FBSem/IiQfn2rWQ77AKsrw6F40H5Pzm4ylPagqLAV/gZh
X-Received: by 2002:a17:90b:2b50:b0:3a8:609c:7a6 with SMTP id
 98e67ed59e1d1-3ab3a8e9100mr10921093a91.44.1791926208821; 
 Tue, 13 Oct 2026 14:16:48 -0700 (PDT)
X-Received: by 2002:a17:90b:2b50:b0:3a8:609c:7a6 with SMTP id
 98e67ed59e1d1-3ab3a8e9100mr10921078a91.44.1791926208232; 
 Tue, 13 Oct 2026 14:16:48 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac604b2f7csm1145224a91.10.2026.10.13.14.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 14:16:47 -0700 (PDT)
Message-ID: <217d7743-f441-444c-9ea3-7de07bdd3b21@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:16:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] releases: build and run any QEMU release easily!
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, mjt@tls.msk.ru
References: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
 <as6d-7bwBOyz88hq@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <as6d-7bwBOyz88hq@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GL+dgeNK c=1 sm=1 tr=0 ts=6ace9fc1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xCEogyAeZDdTSCQxLzoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: FKn7qf_TUaEf5F8bImqaDPOCRcqpcTFe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NCBTYWx0ZWRfX5YZPc3QZOF+a
 XgpjbbmufmC+OQf4H+9yuMykgYw0uLm7GxrD1iPc7eeT1pyxR7A3pErAN1LUIWEIUM82Jl831cI
 g+MBM2YTwxmGt4nibDzcb2pQlwbABik=
X-Proofpoint-GUID: FKn7qf_TUaEf5F8bImqaDPOCRcqpcTFe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NCBTYWx0ZWRfX1OXKZy57HR0+
 kMg3uifoWBww3C5g42GNcBKGhQl3PdwFxQCmLwNNTmzf86rQuzSx91CXWScV47BfJeQO6FtwuUE
 DEjKubfjC7d74J3JIkD77RxMRboQc5x9b4D6LS8XsAber15httNSdiC2a/IUK7hstFm6QCSPF7u
 sL2KZ5Ld8BH3WgQXgc4r6kbEV3bMJ9TNDkhEpzSir2xypAtL4FgMdRTS9TnKCuWeWnfs/GO6DsK
 /oqU9ZG8BhZRG93rI0h9V5NBQOfKLq7H90MMMgAnC5QNkn1okTkuiAZUx8NwDhjECkXI3HFPerm
 kvP7Y1uQ/hmL6CqkSsis21DJpdUwc3hQxsAgOeXa7XydcMhuLvSiW5W00aEmboQpYXXXa4TALns
 WMM/t4Bt+ad1DYZVeWXeUkfTvs/LFY9c9FPBNO0E2X9gXSdCykNykTk583c+bKoL1Y+9dRon5l5
 75zHZddqeBTiafyjJiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130084
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

On 10/13/26 2:09 PM, Peter Xu wrote:
> On Sun, Oct 11, 2026 at 04:27:34PM +0000, Pierrick Bouvier wrote:
>> This series was inspired by a recent post from Fabiano to provide container
>> images for migration tests:
>> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
>>
>> The idea to be able to build and run any QEMU (past) release with containers was
>> in my mind for some time, so I gave it a shot. Finally, it was easier than
>> expected to obtain a single dockerfile (with a few hacks) that works over all
>> our releases.
>>
>> The oldest functional distro we can find nowadays is ubuntu 14.04. Because of
>> this, the oldest QEMU release we can build is v1.6.1. Previous ones require an
>> environment we can't get easily today.
>>
>> Images have the absolute minimal content possible. It's only qemu binaries,
>> artifacts (roms, keymap, ...), and libraries. There is no shell or any other
>> tool included. As a result, images have a size from 240MB (v1.6.1) to ~1GB
>> (v11.0.0).
>>
>> This series adds 3 pieces:
>> - a unique dockerfile to build any QEMU release. User has to provide an explicit
>>    Ubuntu version when building a given QEMU version.
>> - A script build_release_container.sh which automatically detects which ubuntu
>>    version a given release should be buildable on (based on date). It works
>>    great, and the heuristic works for all our versions.
>> - a script generate_release_links.sh which creates wrapper scripts automatically
>>    using prebuilt images (hosted on my dockerhub).
>>
>> TLDR:
>> $ ./scripts/build_release_container.sh v1.6.1
>> $ podman run -it --rm qemu/v1.6.1 qemu-system-arm --version
>>
>> $ ./script/generate_release_links.sh qemu-time-machine
>> $ ./qemu-time-machine/v1.6.1/qemu-system-arm --version
>> QEMU emulator version 1.6.1, Copyright (c) 2003-2008 Fabrice Bellard
>> $ ./qemu-time-machine/v11.0.0/qemu-system-arm --version
>> QEMU emulator version 11.0.0 (v11.0.0)
>> Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers
> 
> This looks pretty useful and also generic, thanks for working on it.
> 

Is there something specific you would need for migration purpose that is 
not covered yet?

If we go in this direction, and decide to host official images 
somewhere, we could even add the wrappers by default for all builds, so 
everyone could have ./build/releases/vX.Y/qemu-* scripts generated by 
default when typing make or ninja.

Regards,
Pierrick

