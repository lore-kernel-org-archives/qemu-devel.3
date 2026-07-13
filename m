Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CDCC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 17:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjKr3-0007Iw-N3; Mon, 13 Jul 2026 13:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjKr0-0007Io-DD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:54:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjKqx-0004f4-Al
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:54:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF85bY1701330
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 17:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CS6FEFXx1rvIdSLicJDciYbvQCGW9gD85N5LeMBi0E0=; b=ik/ocJrjM+UL5c+D
 R7wQYY1ziNXEbLBGQDbfUm6t+4kewBNN22dFQwu9Xx81E0fwFConvZ4Doe9T9k9M
 Q9jExpbtD8f5zqMAuktFlBzewjydYvFH7ZXglI34Q4EFn6dCwJF9EFY83BUv137x
 C6B8okWytmqn8iPrE3hX9WPUZ1OZa1lw+e7JZpBmAOam9Q1m4KM5yztfYYsTom4P
 UD9G33adJQtggMy0IeuXChoizfjIs3RswbQmvRRdkz946yRgOy2wpD0myl4nyTgE
 4Y7+cUbNTOkRxRQlKNuI7FatMxzCyvp4ycLWpRQxzyUW9C/4ervpUJDda/R5oyWh
 kL3SUw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3hyrd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 17:53:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85798977dcso2259794a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783965239; x=1784570039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CS6FEFXx1rvIdSLicJDciYbvQCGW9gD85N5LeMBi0E0=;
 b=EwF/zD5HLn8AMxo7s/F0AMYKoJ0VeOJbVYsHCCxuz0//O1zcO0DFUFC4O1JsP/SjAO
 gOjYB7VmCGboTcg6Y3aioWhJl4rP7E9OoBxLIusrzNqtJZhcDbRqzpyJ7Har/ctPkpea
 ADJiNZH0Hq68122Gy9RHfComquWQBVOqBlNSLkj2AW52RFXZqKSeWbHC04jHrEeVWrpO
 ukIzCpanLpOzoiPLQckS9z0dqdMbRtJiMV9TXv0ODpXR9+51Nkd5wbZLQNK6Jq3q0ruP
 CQIWoGXw5vgMZGi2PMebUpe6OC4ZjrmEodcrdtO7qQ6iaTAaTUTAdEaxWuFCsZq2JHvl
 b0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783965239; x=1784570039;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CS6FEFXx1rvIdSLicJDciYbvQCGW9gD85N5LeMBi0E0=;
 b=Ndkj/ZtikG+HOvkxFsS6a6bznpyPn4/Yn0aXr0hks3fwiCzf3bfzNWbYHNAAmarPSa
 r920NpRevwTwSIGrpp1g6O0gZ0I/zjmS7YVnyAsebhtFzEmo1PbXzRudiVPk4KPJwJBb
 /wssPBffoZiAGNgjCQ1pzx88G97qJnqnIECl8u+HNNafKyi0oEJUZvCKx3z+g8bGn46S
 OWItQ+WB3Ih7TmV+N5yd5izJI//ec6STVnkOPC7RRnKAkybowiPdywkTG4VBthPnA0pG
 0fkuaWQmfdxwzRrsByGCK9UViDD7Rvmc8RJnets6mUzJ2+p3EO9UPRpWboMrgRwqjcVO
 735Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrnvmw9wjmv+oarTlO75uPAfRgAqQU6AsVYA24nSntTRZOmNuQ70s/kDy0PapGfVfENmR2LqV8AymTs@nongnu.org
X-Gm-Message-State: AOJu0YzyKXYzS0LvcyOVDPIdhUBo64JTPxd/K9pNQdENPC3rXm5J93D4
 Js/nY2i6mHcCfqAAONb3AVZ8VMFrP+M76ZOlfcNCALMIY46To4IcDKP7SCGM9XgFa/ihwSsA0q4
 wLv7O31WhZJikqFRF8JlfqqdWE847OQps4KJbm7xI5fOR26a+u+BUYp+Zkg==
X-Gm-Gg: AfdE7clDM91Vlco+5K1L1S0gkDQn9Weubtm9G+Csl3A3HvqJKvgGrnwr6479pqHaROW
 CmF/5fKkWfgYFJ7fNeqbYdXoIBA0Qo90yr1aFELJHuAwlJoORuibBPYs1GjaaFhELPnGSyCg2EU
 atn1BCQPC55rsdbrSSC0U37a/07tqt/TtxliqMllnYxngGituwVD32qUUoCGaSP4joGPe/rDEaa
 Ej+KBAERsIYoS+Lt5gACw/tVWIFQldkOipDbACRaXADEF0yY2oK1DbCc1NkRWaoXegpcKjWKDJY
 1iG+inZmRRFe+4KOBPNmveyT4TTRA1kS+1yVJy21u9bEqYbC3jKLJMi51XWixSErU9txwDpjMdI
 NQLZSb3l49kwuqLlTI13tHELChLCBVQBVpTT4McepA5Q+mQnzsYFAENZCADTbZoixE4Z7m4mhRj
 zelRY=
X-Received: by 2002:a05:6a21:7a43:b0:3c0:9c19:65b4 with SMTP id
 adf61e73a8af0-3c110a7b347mr11045893637.76.1783965239082; 
 Mon, 13 Jul 2026 10:53:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a43:b0:3c0:9c19:65b4 with SMTP id
 adf61e73a8af0-3c110a7b347mr11045864637.76.1783965238592; 
 Mon, 13 Jul 2026 10:53:58 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm123735548c88.14.2026.07.13.10.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 10:53:58 -0700 (PDT)
Message-ID: <69924eee-ba12-4a3e-baff-8ecb86d1ce77@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:53:56 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2c57e188-b9f5-45b9-90b3-81a3d128254a@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Bh8z7mvWSIjRazWLpf2WyP_y1JCgj9sg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NiBTYWx0ZWRfX2V0XrRV32kH5
 UWQZdboOuRl++sj+fqhtJG3HN3SIB1KbnZVjE3Kt2oaxo4/BAio0UX2AEJV7FkIwazPCsuVj6u9
 rpdHu6Fm8YnwLZfleZ+ArSWUGvYOEo0=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a552637 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=xwSr5YbGb3vt4MF34V0A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NiBTYWx0ZWRfX5qMuX/7xiX33
 JgIp3GqEXOy2ZIf2xnPhbscgTIB4SjZd+YAgIKBX0ciIXjlCUZAxMrIQsptKzn3suxr7OAlaYbF
 ituZ/zZ62/6tluQy7nkvNOnQwP8Kp8aSyQqbTWZyavBdRtK+LgokKeXriHAxzp9Q5EknIsD3JBO
 6dr++TUS9E0WCFbjvnWBBOt/jY+qcntfT3XsUYxqnfqHbVm3ovRiP0Ug9SZL26/C3K2pnWG6EjC
 oXYHs73EFyQJMy3rfdDN8rRk/pC4gwVCeGfkLJpMrhoEhuqhidNQws10Q35KT5aA/ro+boMk5Bp
 wf/HOrvIz2BzabDiBtD1cyF7TPSQaZ5eTci5WyKarUV1mUNj5yN6Dm2E/x0hoUcYgZuP2c/xzAy
 ySOpwutfWviSleT7hTh8bymwiVyNLSYYfn1QpyjMACnzfg2whwlW5V50ZonThbvHnu4biyEoUht
 ui3txUPGQLvabjjH+sQ==
X-Proofpoint-GUID: Bh8z7mvWSIjRazWLpf2WyP_y1JCgj9sg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130186
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

On 7/13/2026 9:34 AM, Ziyang Zhang wrote:
> On Mon, 13 Jul 2026 08:31:18 -0700, Pierrick Bouvier wrote:
>> The problem is that if that the guest program, or the host library (host
>> libhello) may depend on libstdc++. If they do and if they depend on a
>> (newer) symbol not present in lorelei libstdc++, we break ABI. Same goes
>> for libgcc.
>>
>> By not doing this, you'll be forced to provide a lorelei devkit
>> everytime a new libstdc++ is published, or a distribution updates its
>> gcc.
>>
>> The only solution is to embed libstd++ and libgcc statically, or rely on
>> host libraries. If you choose the second option, you know have the
>> opposite problem. So I think the only way to solve it is really static
>> linking, even if it will slightly increase binaries size.
>>
> 
> The devkit already ships libstdc++ and libgcc anyway: its own clang/
> LoreTLC link them dynamically, and we bundle them so the toolchain even
> starts. So bundling libstdc++ for the thunk flow adds no new dependency,
> it just reuses one the devkit must carry. Static-linking the thunks
> wouldn't make the devkit any smaller or more self-contained either,
> since clang still needs the dynamic libstdc++; we'd only be adding
> static copies on top of it.
>

There is a difference between the toolchain dependencies, and thunks
dependency. For the first one, it's perfectly find to provide libstdc++,
for the second, it can create conflicts at runtime that may be very hard
to diagnose and solve.

> On the ABI risk itself: libstdc++ keeps a backward-compatible ABI, and
> the copy we bundle is recent, so a thunked host library only breaks if
> it was built against a strictly newer libstdc++ and references a new
> symbol. Even then it needs no new devkit, because the resolution order
> is the integrator's to choose. On a host newer than our bundle, putting
> the system libstdc++ ahead of the devkit's on LD_LIBRARY_PATH lets the
> host library bind the newest one, while clang and the Lorelei runtime
> keep working against it by backward compatibility. So a gcc update on
> the host doesn't force us to reship.
>

Sure can choose indeed. However, he has to find where such libraries are
located on his system, and prepend that to LD_LIBRARY_PATH. Not the most
user-friendly thing to guess and debug IMHO.

> There's also an active reason not to static-link. Both the Lorelei
> runtime and the generated thunk libraries depend on libstdc++. If we
> statically link libstdc++ into a thunk while the host library it
> dispatches to links the system libstdc++ dynamically, the process ends
> up with two libstdc++ copies on the host side, right across the boundary
> where C++ objects and exceptions pass between the thunk and the real
> library. That can break:
> 
> - Exceptions: one thrown in the host library may not be caught in the
> thunk. The two copies have different std::type_info for the same type,
> so the match fails and it hits std::terminate.
> - dynamic_cast / typeid across the boundary: they assume a single
> type_info per type, so they can start returning null or misidentifying
> types.
> - Duplicated global state: two sets of the iostream objects, the locale/
> facets, and the exception emergency buffer.
>

That's a good point, but does lorelei even provide a solution for that?
I guess that exception raised from an host library and sent back to
guest binary with target specific types will not result in what is
expected at the moment.

> Based on the above reasons, I prefer to do that than statically link and
> grow the big artifact. Does that hold for you?
>

Ok.

> Thanks,
> Ziyang Zhang
> 

Regards,
Pierrick

