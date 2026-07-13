Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EDDC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjL0R-0002P6-E4; Mon, 13 Jul 2026 14:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL0F-0002OC-6O
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:03:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL0A-00068c-Vj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:03:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8lVx1908363
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cEuhgnV7xYD81IYPAYx/edZ0pk9O8g1yBlSzlqCgr/Y=; b=Mddjsk5lHYpPEvVG
 tJiP3kXNUBc4XLSjyvGxfIOjRglzZFPjUZfmufwW3YIpLT3/lSQy3w/gHCiVMYZY
 qQck+5srfe4frrJi/eKyl0AH20KPyxd8WERp+Ehq3nIy5RTTKzLZZtKicjYZAF35
 ywJTNHhVf6854nH/IOnuTVVoQgQnFRZNxP69gFN3F3BBXW9+aLlN4upURmt8YNCb
 V2Tp/Btux88pYS08PyNNqf52c+0zvhVnAaxBECL9WVTtn9y5rJ5eJe6STmCQhTQr
 mLRFnNi1FGKXdOVjX2LQOn+l3a/LQRVRRfTk4trKZE9sWGzpeEUHun3mx+1E/8a/
 7Q4O3g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda22da-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:03:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-380b630c505so4179243a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783965807; x=1784570607; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cEuhgnV7xYD81IYPAYx/edZ0pk9O8g1yBlSzlqCgr/Y=;
 b=T37XWqHjQujYaxBfIFb54FRn/PRoGjFuXbYMbkGireurj8XjHVE28I0TiIa9bs1hfK
 Mrwc0rDZqhmjJltS8LUcLx60RSaMCnU7c6Zc/99CZq/qRqmbOdPX5LSI0YairGd5K0d7
 CsXWNWblyCR1MAkcxajboYF06r53k4krmmhCxnErAxOHAe6CAt0dALzYsWLsvjDjClQu
 8byjfRyggj3sDFovRVgOLIegZt7Myp1b44LipEWFieC5ApyF77E6aqb2EWqWab8+T8GH
 qfmii6SvmmzRsnrm/twzPZMW9SpBZxt71c7RakwyBLE8iX9EnRRTIHP3QRxUcTnDGlNg
 PbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783965807; x=1784570607;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cEuhgnV7xYD81IYPAYx/edZ0pk9O8g1yBlSzlqCgr/Y=;
 b=DFCkIgSKAX4x/Kuml0YoyCuTNla/TBhsVlm1hNbNbJG+yiNhq0HS28wTQxHUneqISX
 MKDKXyZjDpSkuHSLTy7P6uWLWJpzdonJjcuo0cMO0ZQ95HHkpMd4t4ZPTZ2oxPez/Fks
 baF7QJcAAE/dM1yE9q5Svex3P6KHn5/mUbJyuaad5P1bqs6RL94DaM0fIazqUBd5H/+w
 v9+cPc9Ca1qIsv96jrjn0C7dZGysM5YISM7zZ56dAVeiVZFGdk0HQn0Oq3s4vVTmuJ5N
 Oj1DtwUgEhTlS0iWNHqdBPjw38c0/E4kwnymainX6yyLgG+tz7ffi1K31Q/0MF5xRyTj
 VmXg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ros0GFM8Ln57xA6ee8N20IX4CWzTqrZ3rw0FfuY4Gs1XrgdIk1+ev+EOm0SALUJokcISTN5jx9y+o9g@nongnu.org
X-Gm-Message-State: AOJu0YxT9zhUhm2zFc0k1/KQN0HcQjkBUS3i4Xpr6vOrjC6AjeLaNN0S
 2eq4mwmp9QUaZiOPo3Q5Lnvwzkq4rszIhucp6j/bwN+CpezzGEI/6z0xHDZGz9t7Pv+njbSJkxU
 enBkWYzJdMNpZ2TfmZJHZer995t+ScSGaGtS+q7rmfjffXSrQT0MuUcm05w==
X-Gm-Gg: AfdE7ckzzXUZ81F30cQAlpgBi2mT5jz2YVbkpGbP1JxSNkS44nLguhsqcNif0Yq+4+2
 eeFvkHmj2pqkkpCdhirShZm2+qodaxnOmUiwh6bo4Pw8S9gB4lX+YPLo+Fjrj6DfwqAKq9CHnzk
 CayozhYRZbKOi6aOSzVhIn+vPB6YPfGj/YVrYJS+krm2vxm2tYZH1xbfPZ5gMu8RbhofqTcVj1z
 d9FedcVHFb9MPEEIIcg/eElDgJRjRnbQI6VF4fRD36lD1Ajy1GOoDKiycLX8vm3Y8Gw/IBdLUW3
 p1+zUdvpzck3ct4pD2U0ebkTOy6oT0Up98wvCS4KVWWxQb4HLL50rURB1lqs1BIGbCIKWXncpj4
 K2HJu6KhWocir05DF6Cj0XRrj9+lzULnCJ+doMBy0CN9G5ru0r34yxB8zTXyY6BsklQPGCZuNpM
 TG6/Y=
X-Received: by 2002:a17:90b:5103:b0:368:9da3:c496 with SMTP id
 98e67ed59e1d1-38dc774d032mr10126443a91.24.1783965806669; 
 Mon, 13 Jul 2026 11:03:26 -0700 (PDT)
X-Received: by 2002:a17:90b:5103:b0:368:9da3:c496 with SMTP id
 98e67ed59e1d1-38dc774d032mr10126391a91.24.1783965805885; 
 Mon, 13 Jul 2026 11:03:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4b97661sm40081151eec.7.2026.07.13.11.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 11:03:25 -0700 (PDT)
Message-ID: <9b8f79c7-1f30-4036-ba05-22d390a22410@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 11:03:23 -0700
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
 <8c2aa5fe-026e-45c2-a908-5f6c245b2993@oss.qualcomm.com>
 <2c57e188-b9f5-45b9-90b3-81a3d128254a@sjtu.edu.cn>
 <69924eee-ba12-4a3e-baff-8ecb86d1ce77@oss.qualcomm.com>
 <37b40d64-aaa7-4358-ad5d-70c15dc05cba@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <37b40d64-aaa7-4358-ad5d-70c15dc05cba@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfX3/8B3A13ES+u
 FaUMISvz9nL1fpnt0o6CL7+ZAwt6gv4GO9Yz5xPSuHdXW1y5YYR6BGt0++uvjgIPd8VUct/U2uz
 pdv/+LLoclM+A8+h3pipIxW5Jap2Jw0=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a55286f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=DeBbWu-sujYPe9ffx0AA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: lNPfsrTKo96vOApkDdB_0yV_bmWuk3-3
X-Proofpoint-ORIG-GUID: lNPfsrTKo96vOApkDdB_0yV_bmWuk3-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfX5kbxPtQefiFX
 FtK1lhxxIakikWw3iCdIIgwWJt5ZOoos8ZoLlLTf2jGIxXE9RuU8H/nVMwEXr2KQ83Pp9C+Wt+F
 6vAzF/rsK2gJromar3DZKIvbfPiOtYlz8pHBSF8czMa2HU+Zel48D1YqTzEcVDHk23Erfyc+CUf
 tyJb7BBO2JRh6syot94Hvlhi6onEVLR1TDjWY7iQA/f29q9WRbiMGXnzHkP0WmMPvdz1voJ9Rhi
 ao6YbuovDAndoSrCuAfc0rpmqBxKwO68AxxquaMf+IbVJV7uExkvDsserP8h1/vMFNa4ilvp1Nd
 rkdZ7i82iWy1rtk2xwgi1XgOc//OA3iBoc8Oi36dxHWUcbqTADcpfk6+mAsempat1vWyCqOiv6A
 U639j5dZm8JUF7fHELEwPvxZ0ZkB33QMwh50Ua5lG9BmTYQAiy5pGFfA+EwxsLLgSej7210T6a9
 hV9e4aC2pH6VAg9Bsjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130187
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

On 7/13/2026 10:56 AM, Ziyang Zhang wrote:
> On Mon, 13 Jul 2026 10:53:56 -0700, Pierrick Bouvier wrote:
>> On 7/13/2026 9:34 AM, Ziyang Zhang wrote:
>>> On Mon, 13 Jul 2026 08:31:18 -0700, Pierrick Bouvier wrote:
>>>> The problem is that if that the guest program, or the host library
>>>> (host
>>>> libhello) may depend on libstdc++. If they do and if they depend on a
>>>> (newer) symbol not present in lorelei libstdc++, we break ABI. Same
>>>> goes
>>>> for libgcc.
>>>>
>>>> By not doing this, you'll be forced to provide a lorelei devkit
>>>> everytime a new libstdc++ is published, or a distribution updates its
>>>> gcc.
>>>>
>>>> The only solution is to embed libstd++ and libgcc statically, or
>>>> rely on
>>>> host libraries. If you choose the second option, you know have the
>>>> opposite problem. So I think the only way to solve it is really static
>>>> linking, even if it will slightly increase binaries size.
>>>>
>>>
>>> The devkit already ships libstdc++ and libgcc anyway: its own clang/
>>> LoreTLC link them dynamically, and we bundle them so the toolchain even
>>> starts. So bundling libstdc++ for the thunk flow adds no new dependency,
>>> it just reuses one the devkit must carry. Static-linking the thunks
>>> wouldn't make the devkit any smaller or more self-contained either,
>>> since clang still needs the dynamic libstdc++; we'd only be adding
>>> static copies on top of it.
>>>
>>
>> There is a difference between the toolchain dependencies, and thunks
>> dependency. For the first one, it's perfectly find to provide libstdc++,
>> for the second, it can create conflicts at runtime that may be very hard
>> to diagnose and solve.
>>
>>> On the ABI risk itself: libstdc++ keeps a backward-compatible ABI, and
>>> the copy we bundle is recent, so a thunked host library only breaks if
>>> it was built against a strictly newer libstdc++ and references a new
>>> symbol. Even then it needs no new devkit, because the resolution order
>>> is the integrator's to choose. On a host newer than our bundle, putting
>>> the system libstdc++ ahead of the devkit's on LD_LIBRARY_PATH lets the
>>> host library bind the newest one, while clang and the Lorelei runtime
>>> keep working against it by backward compatibility. So a gcc update on
>>> the host doesn't force us to reship.
>>>
>>
>> Sure can choose indeed. However, he has to find where such libraries are
>> located on his system, and prepend that to LD_LIBRARY_PATH. Not the most
>> user-friendly thing to guess and debug IMHO.
>>
>>> There's also an active reason not to static-link. Both the Lorelei
>>> runtime and the generated thunk libraries depend on libstdc++. If we
>>> statically link libstdc++ into a thunk while the host library it
>>> dispatches to links the system libstdc++ dynamically, the process ends
>>> up with two libstdc++ copies on the host side, right across the boundary
>>> where C++ objects and exceptions pass between the thunk and the real
>>> library. That can break:
>>>
>>> - Exceptions: one thrown in the host library may not be caught in the
>>> thunk. The two copies have different std::type_info for the same type,
>>> so the match fails and it hits std::terminate.
>>> - dynamic_cast / typeid across the boundary: they assume a single
>>> type_info per type, so they can start returning null or misidentifying
>>> types.
>>> - Duplicated global state: two sets of the iostream objects, the locale/
>>> facets, and the exception emergency buffer.
>>>
>>
>> That's a good point, but does lorelei even provide a solution for that?
>> I guess that exception raised from an host library and sent back to
>> guest binary with target specific types will not result in what is
>> expected at the moment.
>>
>>> Based on the above reasons, I prefer to do that than statically link and
>>> grow the big artifact. Does that hold for you?
>>>
>>
>> Ok.
>>
>>> Thanks,
>>> Ziyang Zhang
>>>
>>
>> Regards,
>> Pierrick
> 
> 
> Wait a second. I missed something.
> 
> Sorry, last time I answered without actually checking the libstdc++
> situation on the four distros. You were right to push on it, so I looked
> properly.
> 
> You were right that the x86_64 sysroot is the crux: libc6-amd64-cross
> gives /usr/x86_64-linux-gnu/ a libc but no libstdc++, so the guest side
> has no system libstdc++ to fall back on. That's the side we should keep
> providing ourselves, and the devkit already ships the x86_64 libstdc++
> next to the guest runtime for exactly that. It's only a default, though:
> if a guest executable needs a newer libstdc++, the user can put a newer
> x86_64 libstdc++.so ahead of ours on the guest LD_LIBRARY_PATH (the -E
> one) and it takes precedence, while our runtime keeps working against it
> by backward compatibility. So we are not locking anyone to our version.
> 
> The host side is different, there libstdc++ is reliably present. I
> checked each distro's stock minimal base image, with nothing installed
> on top:
> 
> Debian 12: libstdc++6 12.2.0-14+deb12u1
> Ubuntu 24.04: libstdc++6 14.2.0-4ubuntu2~24.04.1
> Fedora 40: libstdc++-14.2.1-3.fc40
> Arch (2024-08 snapshot): libstdc++.so.6 from gcc-libs 14.2.1
> It ships out of the box on all four, and the C compiler pulls it in on
> Debian, Ubuntu and Arch.
> 
> So the split I'd propose: provide libstdc++ only on the guest side (the
> x86_64 sysroot has none), and on the host side rely on the system's, so
> the host thunk and the real host library both bind the host's own
> libstdc++ rather than a copy we ship. That directly addresses the ABI
> point you raised: nothing we ship shadows the host's libstdc++, so a
> thunk never forces an older libstdc++ onto a host library built against
> a newer one.
> 
> Does that split sound right to you?
> 

That's a reasonable default, and Lorelei can be updated for this without
having to update anything on QEMU side (or its documentation).

If I had to choose, I would still do static linking for guest and host
thunks, because I don't think we can handle exceptions correctly anyway.
But the most important is that current example already works out of the
box, which makes this series ready for upstream.

Regards,
Pierrick

