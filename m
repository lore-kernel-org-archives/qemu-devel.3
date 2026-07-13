Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193BBC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjId4-0007zb-IA; Mon, 13 Jul 2026 11:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjIcx-0007z1-SN
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:31:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjIcv-0000uv-TE
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:31:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8OSu1922780
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3tLJGRZsSAvvMY3iZT3gAKpSGZl3mez9mx4po6zbD+Q=; b=MaK6jJ7Yb2M1NXSm
 Eyj8cDUioQ54hnTE0h/SnwqYa9lp/fqx6rvLf+nakYsdTd1x2PZ1ESG3zF/Ud2ip
 XwMlhdWmczLreXf2BjG95wt4+TJZKS2QAy1FxWX26AWswkDY3cJoDDN0pBa/0F47
 qWw4X/uiGfZbcsm9V5o1jQON+ii1G7vDrxzlON7pMrE2lBDVx8XBd1tsSfIV+dpd
 hj8axMur5iCUIsm8Z4ynDx5oDyD9zXHdVjNXpvRBmdL6Ak5qCrJTU1LUMkEAlFnP
 98k7R1egOX4Xl79m+lxPQ7Gpx6iTCf0ArNnbFN1qfh26msrJt+kQaDZwAn4HcnnF
 QTohdQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubssxsg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:31:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cec4226c70so23378285ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783956681; x=1784561481; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3tLJGRZsSAvvMY3iZT3gAKpSGZl3mez9mx4po6zbD+Q=;
 b=HRs4+8TIXmmke7kUzeXnXmM2K44xeiTowYfRH7+aZNxYSR0RNHjnCeoqnbDkqu6omL
 OSoLeBiHirML2C/+Y8HoB12IdgTH81DPVMgBXkReZ3rKu284NnUkkU2jeFZAvGjLHabX
 UOtVkJULB5xmEI94BIYPuKANXuJ70VrqeF4OIXf5ZrPfzpYAXxDFz2DbqrtvUmcZFGL6
 +Q9YqNi1Ca5d9wVF/C5G7X3wLJiu7IcdLya94+Ol+8SM/NL624nOVH+7Yj6SO5D443M9
 yF8PEBOP87e2chzcaE2EYqA/XVdy2IPsbec+DWA0YJretF8IyY/3GZWy91RhiUShHvgi
 X6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956681; x=1784561481;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3tLJGRZsSAvvMY3iZT3gAKpSGZl3mez9mx4po6zbD+Q=;
 b=NT71DB6Fmuaul0NqLC3uypRyeSBOaf0EdzlvibUyf+348kka4S0Hl6rgXuSvLj1rdy
 GDyU+w8A+1NIgvmV1DWfbWUsy1y7WeJ1u+jXQoCnjFnabsYtMNZmbcKPNiA/oWOLsVg0
 hm4q8E/o94cVW7vPIX6xxcvtkCzo4s1NxGhxx0v/1eSJkzM1QGUCp8s9rEV4oujprDBo
 eq3sV6rj1xCfMmy9x8yVxJjHUomBtmaBh/G4lf8gBvHdqILzw/zxxZJaRjzMA9RjIvmw
 N44VzosdibbC+34E0kY66LFsr/6z0ZKFyjHGOPnzeyVimrK0nUoo/RD99JzaBedPQqYD
 8eVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWs1ZavGFHx48++fZ0kcFsS5BSgMpjdpMW+2fq+8Ys1IOC9sOE6EEVzDQanXyRwzax6KR9wdPucaV1@nongnu.org
X-Gm-Message-State: AOJu0Ywp0X3dIPljC/kNChKKYoOLS2sYOhABPtrtn0kNLrVksmWBGoJv
 X+A5ssgoDY3xJh/g+YvSO6F1PGiuTwJYtFKPSTsyDOb37dNhgFOCjqzdERtNqevOgzGpDXmWgmI
 9nJSiXt798DJs0uz62oCvaZ1lEB0DFOzNAwQpIs+OyJRloHlNTUZD5RZ8LA==
X-Gm-Gg: AfdE7cmg1lPuTjSiMvDlAg3q+tzudF7FOeSZXdqrupwbOEbSe/nFVzYok2D3sgaXJcj
 gsKN1DWAkoHupVM6889792cxO4OFe7SeyJprEN8kIPgJnTSoAL2ZM/ZldswWnN8SaXcIxEmE5BL
 yzZmNekLRoQWYNCanbN7762HzVCMeT8Hwg5HJnkM31GnSeSdWMxYOTluLoa3Fqdbi/Wc51KjfXp
 kLZPvCgW+3qdUtLPlMn0lzZk0uHu7gkhOGDMVoJCZjHTaFBy17phrQHAsAWykIDFZxsWkMe3c4u
 BIVInaEfC3dpbT9TFtLSXT+dlNzf/BR0Tf7Gq5nRAjco6BM6c9Wiwm+UcF2/3UcoVNXrxjtNl8y
 MCcspM//bDzEp0pNRooXk6UmYtb0hhaBcu1RfNXM5iv7GYBHexBDkCvKzg157BqPi4xyXRVExCH
 /v+/E=
X-Received: by 2002:a17:90b:35c6:b0:38e:408:9d7d with SMTP id
 98e67ed59e1d1-38e0408d43emr2828145a91.36.1783956681372; 
 Mon, 13 Jul 2026 08:31:21 -0700 (PDT)
X-Received: by 2002:a17:90b:35c6:b0:38e:408:9d7d with SMTP id
 98e67ed59e1d1-38e0408d43emr2828094a91.36.1783956680711; 
 Mon, 13 Jul 2026 08:31:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm80954332eec.14.2026.07.13.08.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 08:31:20 -0700 (PDT)
Message-ID: <8c2aa5fe-026e-45c2-a908-5f6c245b2993@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 08:31:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260710212601.583352-1-functioner@sjtu.edu.cn>
 <20260710212601.583352-3-functioner@sjtu.edu.cn>
 <990f11f5-c8fd-4cf6-b186-180e24452ff3@oss.qualcomm.com>
 <5a303ce5-cb6f-43b9-857f-39cffc8c7d67@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5a303ce5-cb6f-43b9-857f-39cffc8c7d67@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a5504ca cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=xNf9USuDAAAA:8 a=QATuLo-ivlSwMO_N86AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Mn-9X3LpSS83DMxU2Pp7whQWryztvIwY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2MSBTYWx0ZWRfX8WkdLRQdXwm8
 MnGHgAQqStbEPRMtf5MPSV+fTJ/efzQ2n1k+eEoahtBNfiSEKqP5b6bvG+8EkkDCRw3nHIRHuIp
 gcFxeAdg4lSv0Q/hG/nDFfA0KEMxSG0=
X-Proofpoint-GUID: Mn-9X3LpSS83DMxU2Pp7whQWryztvIwY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2MSBTYWx0ZWRfX5mY1dHmVZWTV
 efMYoZ2E/U84hVTM/1lZzCnIjF2W7qyDO8DDubac1v76PLBg+N+/N3TMFEpJTdeYIz6QhWaJV4U
 Vt924M0SkfznwP6YPreYO7P/cWyht4m7gr1RvEXeqWZMO5h1fHbo5J7Z4gQvSbkgDo5rluWbYM9
 P35nL08Mi+D/aGWuYYSmLNlWFzCx6oRJoF2hMOwQfLnoXBg3rBb/LQ9Neq4YjcX1CGZ7q6SAN1E
 bzP/GQRLcvEJ4JZ2CEUp2xJQKxVYxT0aHrK4D8zfKRgW7hk4IN+sO6M5Oto7bdONWczzLIIVIGt
 6xz2B49gritW8/yle6suMNOmEV9GBVnlplGFlZzqQrmrkiksbskQYF73kVRqLh/zVX2fjVOt5Gb
 LwdmBBjpoXTtgoTkp2tivqUiRkUXRSOUuDNXPKSZwNoQPvE2J1KQeORlY8pQNDpC6sPaOJe8lkE
 lVkLwyITXAyLYKB0+aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130161
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

On 7/10/2026 10:05 PM, Ziyang Zhang wrote:
> Hi,
> 
> On Fri, 10 Jul 2026 15:57:52 -0700, Pierrick Bouvier wrote:
>> Great work, the workflow is now ready!
>>
>> A few small issues are left with lib dependencies.
>>
>> libstdc++
>> ---------
>>
>> LD_LIBRARY_PATH=$DEVKIT/lib:build/host \
>> ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libdlcall.so \
>> -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64 \
>> -L /usr/x86_64-linux-gnu/ \
>> build/guest/main
>> build/guest/main: error while loading shared libraries: libstdc++.so.6:
>> cannot open shared object file: No such file or directory
>>
>> Indeed, libstc++ is not available in machine's x86_64 sysroot by
>> default. It works with -L $DEVKIT/x86_64/sysroot but as mentioned
>> previously, we don't want to use another sysroot than the one that user
>> has, since it can contain extra libraries we are not aware about (or
>> Lorelei one can bring extra dependencies that we don't want).
>>
>> So the last thing needed is to link statically libstdc++ for guest thunk
>> and host thunk. In addition, you can do it for lorelei .so (I mean .so
>> included in devkit), so thunking is fully self contained and does not
>> require extra dependencies from the system where it runs.
>> Same for libgcc.
>> Link parameters you need are -static-libstdc++ -static-libgcc.
>> Once added, all thunks and lorelei devkit should be portable between
>> different machines 👍.
>>
>> The only base dependency we can assume will be present is libc (which
>> also includes libm.so).
>> We could argue if c++ should be considered as a base dependency also.
>> For debian (+ubuntu), fedora and archlinux, it's not.
>> See what is included in debian libc package. For instance, in our case:
>> https://packages.debian.org/trixie/all/libc6-amd64-cross/filelist
>>
>> doc
>> ---
>>
>> While at it, please add -L /usr/x86_64-linux-gnu/ to command line so it
>> matches the default people will use.
>>
>> rpath
>> -----
>>
>> It seems that .so in thunks have rpath set to $ORIGIN:$ORIGIN/../../lib,
>> which should not be needed. LD_LIBRARY_PATH will specify where to find
>> the correct libraries, please remove it.
>>
>> You can use this command to double check this:
>> readelf -d thunks/libhello_HTL.so thunks/x86_64/libhello.so
>> No RUNPATH should be present.
>>
>> thunks/libhello_HTL.so has an explicit dependency to
>> build/host/libhello.so. It should not include build/host and just link
>> to libhello.so. Remove rpath also.
>>
>> thunks/x86_64/libhello.so, remove rpath.
>>
>> To clarify, lorelei-devkit-*/*/lib/* can use rpath since devkit itself
>> is self contained. Thunks can not.
>>
>> -----
>>
>> Once solved, we'll have a clean and minimal workflow, which ensure
>> thunks do not require any extra dependency.
>>
>> With this, any user will be able to grab a lorelei devkit + a thunk
>> tarball and use it as a drag and drop replacement for their system
>> libraries, as long as it matches their version of course.
>>
>> Keep up the good work!
>> Pierrick
> 
> Thanks for the careful review.
> 
> On libstdcxx / libgcc: rather than static-linking them into every thunk,
> I'd
> prefer to bundle the shared libraries in the devkit and let the thunks link
> against them dynamically. The reasoning:
> 
> The devkit already has to carry libstdcxx for LoreTLC itself, which is a
> large
> C++ program. Shipping it once as a shared library and having the guest and
> host thunks link that same copy avoids baking a static libstdc++ into every
> thunk, and keeps LoreTLC and the thunks on one runtime.
> 
> The portability you're after is preserved. libstdc++.so.6 and libgcc_s.so.1
> sit beside the lorelei runtimes (the devkit's host lib/ and guest
> x86_64/lib/),
> so they are found on the same LD_LIBRARY_PATH the run already sets. A clean
> Fedora or Arch container with only libc installed runs a devkit + thunk
> pack
> directly, nothing else needed. The one base dependency we assume is still
> libc. The devkit brings its own libstdcxx and libgcc.
> 
> So static vs dynamic doesn't change what the user must have installed. I
> went
> with dynamic because it's the smaller and simpler of the two here.
>

The problem is that if that the guest program, or the host library (host
libhello) may depend on libstdc++. If they do and if they depend on a
(newer) symbol not present in lorelei libstdc++, we break ABI. Same goes
for libgcc.

By not doing this, you'll be forced to provide a lorelei devkit
everytime a new libstdc++ is published, or a distribution updates its gcc.

The only solution is to embed libstd++ and libgcc statically, or rely on
host libraries. If you choose the second option, you know have the
opposite problem. So I think the only way to solve it is really static
linking, even if it will slightly increase binaries size.

> For the rest: I'll drop the RPATH from the thunk libraries, make the host
> thunk record its real library's SONAME (libfoo.so) instead of the build
> path,
> and add -L /usr/x86_64-linux-gnu/ to the documented command.
> 

Regards,
Pierrick

