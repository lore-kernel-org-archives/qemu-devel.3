Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D239C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDfo-0000LU-0S; Tue, 21 Jul 2026 12:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmDfn-0000LL-1C
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:50:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmDfk-0004mn-TV
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:50:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDfr142962587
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 16:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6cgY8+qmduX8S4nVs5DaH1cWkBp94hjmX499ARdyxNg=; b=Ry3zhXRgUtwqjmnp
 uwmyqIKEElML6Y21idvi6Lqrs9sC01DHC5JYd8OYeD+KMxDWBgBsX3DOqFXE1Bzm
 z7/+cKEq40bMHwA+nbxDqUJMo953SKl+iIYgdxGcJXnV7825Ht+mjhs0cB+0ebSw
 fsg3l4njoWn4E2t506fI3Ook6K9pi/mBWypwbiPY0zRhZQQHkop86fnEBascpG0f
 sJ20Z+kSk+6lk9fWzxbJXhAMCxX8DxhAI5ydkVEFKqKzf8NR29aJrH38kyE2+7mp
 umAl1DxfMSNSxVzpESOs7ustRondfycj/penqQ1VIhmW/kmsjEiSuAxnHjByLrSa
 qN6ItA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6nssyvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 16:50:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccd1958e8fso114468995ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784652621; x=1785257421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6cgY8+qmduX8S4nVs5DaH1cWkBp94hjmX499ARdyxNg=;
 b=KgV6vhud/o0Le5vYUsbFYt781UK0UfMCxGFPdOWFR2YqjaK5+PujVbk+XVHvCxWDoF
 qYiFHs1jVJlMnH+khmEPWaltw51WjC1/hphT2XjzlBc+fb94w89mfoBJ/dOtOHAlz3vi
 ssjbwiFLmIVD7lKGtfgvCCs617J18pnsYhoirdA5Rwkmoa6bno+/7np6TJ/4K9q4Uuic
 /WbMK5uhR446HcTDTcz+dCGA8sSFmVoykd9wnVjiLHBK1ZSWC+Q2Lfnlf1cQs4MeXBDN
 wwBWieY+VxylWV7AQ1okfhcmwwfQLuEIUB5AJCJTP4EDHdqY7D3Ew3vf3kEEs4lYwJPV
 XCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784652621; x=1785257421;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6cgY8+qmduX8S4nVs5DaH1cWkBp94hjmX499ARdyxNg=;
 b=PAHNTBaWkMzid0mjTfIbNG9/zy2CQkSBCXB8xgYfinhwa5a+7vUeqFfvH6x7dz460N
 aU50ZX6OnSYZ4oSbPM9lyhwdBoLw+RfoANtModgi7TwNgqGAPr5/RJbpE3r7q6BaJYiW
 RoCLowu9fjlcMTiPwPh7QynRbIf+9ThVFPtZhl/ofJg9alaRNuD1dd7SnQxiR16xL3VX
 fQx55PMrJbhj031PTuBi15AH2b6/wlNRBjmXrFwX2NL5MNrU0omIQhk6ybRu79VnOTf9
 bnzuGsN3fKSYBoD+lnVTW6GBwnP9pHlW36OVfk8SrLrQp2vMEdd7HMd/8dSX+C0r5g+I
 MMBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFVPAtcpvxTAEv2revYCElfhfjepgbRaheRYlbjP6oP+7kCU2E/8SJX00RXXl7GAUktK9c9+7KueGU@nongnu.org
X-Gm-Message-State: AOJu0YwVONMWQhDixauMx6vYcTuMVaj88mvbBsfWHc3B7/lLRtaggm5U
 zcYLTe5W4QjROZVjLH5Tg3CJa45wk4rwLVhfwtbn1KScuhD2v2ZD2LajBiwy1b+4kRuEyCqwzLo
 rvrQthvq1XCoF0KPTFbj5BZwnOXD+0sh4aGUoFIUsTTr9EJszCiPp1+3zoQ==
X-Gm-Gg: AR+sD10IQOrVIRJ451CuEENj726Jkh42wdjMYZI32Olgqly1v74JPuqf9jN/SyRT4B/
 ZH5CbCvGCPbtcv28CGEtgmKFK4r5bE57CRx/3PA0IsdLrZadFQeQOo3+PN8GXtZ44dkPb3kJOFM
 sj0S++88+ss1yKiIsPQyZ8hBHyUS9dIVxmddUK/cx9nyhFASZyeBz9rV2Pw2Pdy/wKXZv0pCcDG
 ASnIGKqzCCnViuZmi26tj5fTruuLF9UG+7TOEb4nXSKf67ZjqAX2qZAItd3juv+KPXdSKHjU05N
 EQ82pI07DJyPnLpecgrPkQQY2nyC9mWddbFyckkL6uQik/DJl3FZGSuTSDeowmXof6Q201gq09H
 wZ8FCBX8cA+hj/FGLP1SlHwNq3G89npwe2B81/Mf/8xVXSxBC8qaZcn+GVueuemywjVE/
X-Received: by 2002:a17:903:2383:b0:2c9:97a7:f544 with SMTP id
 d9443c01a7336-2cf34a18cefmr208361545ad.42.1784652620598; 
 Tue, 21 Jul 2026 09:50:20 -0700 (PDT)
X-Received: by 2002:a17:903:2383:b0:2c9:97a7:f544 with SMTP id
 d9443c01a7336-2cf34a18cefmr208361175ad.42.1784652619974; 
 Tue, 21 Jul 2026 09:50:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6162csm649975eec.7.2026.07.21.09.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 09:50:18 -0700 (PDT)
Message-ID: <1114d029-f7f3-44d4-b19f-f919b1d0e00b@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 09:50:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] dlcall: correct the syscall number claim and the
 guest requirements
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ihedXwhtJD84UHXH7bru9qLMFdlKJePd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE3NyBTYWx0ZWRfXyEJD1qPuyiz9
 PcnNko7R8WA//WVJ3fC3NHMhWFaWgHQ3YwMVp9B0JLbqrvb4zQYSv9c44m8kHt4Lu2P7vLUjDU/
 7OFKaZCTEbF2voP+wN+tXuiGL6k4YNM=
X-Authority-Analysis: v=2.4 cv=ZJjnX37b c=1 sm=1 tr=0 ts=6a5fa34d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=uUglX_S_jsOhXFroYCcA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: ihedXwhtJD84UHXH7bru9qLMFdlKJePd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE3NyBTYWx0ZWRfX2LsnclSZququ
 LgXMUmU2AZ03Ysom9ppHyB3DGrEE20oANRdYUiYnHGnJ1787X9YJSq1RleHloeY024tYpeUBP53
 5SQ8GwqJoWlTyTPF/5wuYKXNA3wrISc+NXXWox9OQNd94/5vxS8VCpVTqyZL11CJaMigws07euS
 99M21SrmMLA/t1R4tEWWLNh6LzaYTKwJTQnhlx0FLgGo1aHw4ZlEyNxcRl573tXbU7VRyp93ld4
 KcPbv5a7TzjHJQK0y6ml4nkT/zvGdiVhRzbkXdK8vwhtUblLdzCqdyC4DtgR0NVtHHp2pl4txBC
 cTA+Ogpq6bghCEjTS8rMUJmsVc24BBIB2lmBO8g3USeo/tnRqDEu8SbBy1YC/nYy2+f5AFGFh1R
 khK0ZIErpihMeRTRyd5jCeHRFFw3sQc+2bQCJAl95av8fGBLkAXZK2uA+qMML8ss1hYoBtDtE2Y
 di0ADu1F7tJvzifha7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210177
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

On 7/19/2026 12:47 AM, Ziyang Zhang wrote:
> Hi,
> 
> Three small follow-ups to the dlcall plugin merged for 11.1. There is no
> functional change: all of them are comment and documentation fixes.
> 
> The first one matters most. The plugin picks 4096 as its magic syscall number,
> and the comment justified that by saying every Linux ABI keeps its syscall
> numbers well below it. That is not true for MIPS O32, which bases its numbering
> at 4000, so 4000 + 96 is a real getpriority. Loading the plugin on such a guest
> would let the filter consume a legitimate getpriority() and read its arguments
> as a dlcall request, where the first one selects an operation and the second is
> taken as a string pointer.
> 
> Raising the number does not rescue that case, which is the part I had wrong at
> first. O32 answers numbers its table does not define with ENOSYS in cpu_loop(),
> before do_syscall() and therefore before the filter, so on O32 there is no
> number that is both free and reachable. Its N32 and N64 ABIs base at 6000 and
> 5000 and have no such gate, so they are unaffected.
> 
> I checked this under qemu-mips rather than only reading cpu_loop(), using a
> plugin that logs what its syscall filter receives. A plain getpriority() from
> the guest arrives at the filter as num=4096 a1=0, which is what dlcall would
> read as an operation ID with a NULL key, while syscall(8192, ...) returns
> ENOSYS and never reaches the filter at all.
> 
> There is an upper bound elsewhere too. arm32 answers anything past ARM_NR_BASE
> (0xf0000) with ENOSYS or SIGILL before do_syscall(), as the comment in
> tests/tcg/multiarch/test-plugin-syscall-filter.c already notes, so a large
> number is not a safe default either. 4096 sits below that and above the
> ordinary syscall numbers, which is why it works on the targets people use this
> with.
> 
> That test carried the same wrong reason, so the second patch corrects it. It
> picked 4096 believing no ISA uses the number, when what actually keeps it safe
> is that the filter matches on the first argument as well: a real syscall
> carrying this number falls through untouched. tests/tcg/plugins/setpc.c matches
> on the number alone, which works for the single test program it is loaded with,
> but the collision applies there too, so neither test shows that 4096 is free.
> 
> I have deliberately not changed the default, nor restricted which guests may
> load the plugin. The number is already configurable with syscall_num=N, and
> dlcall is generic infrastructure rather than something tied to one userspace
> project, so it should not decide which guest architectures people may
> experiment with. What was wrong here was the reasoning in the comments, so they
> now describe what a target actually does with the number.
> 
> The last patch extends the guest_base == 0 warning, since the guest must match
> the host's pointer width and endianness as well, and tidies two things in the
> prose: a library is not turned into thunks but has thunks produced for it, and
> argument marshalling, callbacks and variadic functions belong with Lorelei
> rather than in the plugin's description, since they are precisely what it does
> not do.
> 
> Also in the first patch, two out pointers were dereferenced without the assert
> the others carry.
> 
> Thanks,
> Ziyang Zhang
> 
> Ziyang Zhang (3):
>   contrib/plugins/dlcall: correct the syscall number claim, note the
>     data model
>   tests/tcg: correct why the magic syscall number is safe here
>   docs/about/emulation: sharpen the dlcall boundary and its guest
>     requirements
> 
>  contrib/plugins/dlcall.c                      | 32 +++++++++++++------
>  docs/about/emulation.rst                      | 31 ++++++++++++------
>  .../multiarch/test-plugin-syscall-filter.c    |  9 ++++--
>  3 files changed, 50 insertions(+), 22 deletions(-)
> 

This was merged into master (83e8f88135cba892934b1d4d04f4c063e213700a).
Thank you for your contribution!

Regards,
Pierrick

