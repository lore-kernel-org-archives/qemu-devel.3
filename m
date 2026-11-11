Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C4606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WO3q46VK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VYdmljoI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRD5Z-0006FB-EH; Wed, 11 Nov 2026 13:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xRD5W-0006Ew-4C
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 13:30:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xRD5R-0007cU-JR
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 13:30:23 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtDQ23680371
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 18:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XJlDESLhPUCB6Z8IBdR/v2VDwZ/nlOhmlHTw6yYbKEU=; b=WO3q46VKZ4fZyXoY
 skIxqiZOXX1a2MyeoB4txLUfg2zTx6KsCEdb49WivR7jqP7lczjC/QQv81XDOJrn
 IU/+DGXCzm4vDejmN3ipv/mj2GXoRnXxgXorVw5bfUEAIWkT+haAfSYWf/5NGdW/
 2p1oqYrTR7hUGDN6THfh241e45QZKyZ6voVhuTIiL9MipvrO2weWDSbPNHOsKZb8
 U1oojfN9n0SKhGqc2cJZ6NyIfnh+FVBmJ2L9sKL/l0k0J/FlP7cuI2ySXijbROJB
 VusIvuJely+v42mInlL0DRBkg0xiqi3x77Y3R+ivQavPw2jwXjnq+ACg6R6UKxP2
 QB64Pw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt151577-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 18:30:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-375bac6bd21so74053eec.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794421816; x=1795026616; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XJlDESLhPUCB6Z8IBdR/v2VDwZ/nlOhmlHTw6yYbKEU=;
 b=VYdmljoIW8MZgeX4Qh0bmMZs+wqLv3pVEiBuEZnUMTy1uTfP/nGTUPP5cMg/uPS8n/
 RxNsiAVOCE/oYKgT5JzfKzQID93w85f8HTMDwuGsg/v1VvdzFwuw/2bsGLdsSAjzd0jG
 DZuSHtnrcUXDN2J+Q74wOz0wI36F1sUPw/TNSUHkQhsWKdBCQSxsO1ZfStrNaXNLFwkI
 kcO1bWtN6YQr2TeiTFreaNDZZnquuzZdRlMHZC4Lzg3NrWTD2Kr+pJ/kiwk5dOxN9uIY
 mUkWhjf2VT27NbLLc/A9tHDmlWMlKeZrNOC79pJEimhC7nt6qm0szfDNFXlX+EbfORrI
 vTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794421816; x=1795026616;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XJlDESLhPUCB6Z8IBdR/v2VDwZ/nlOhmlHTw6yYbKEU=;
 b=uuCIThKLrD+23EeeT8x4NDfT5AnIxTCcq2I9G/KWduMRT1TNxzqbE72SQdmmlOFObf
 cFtZzKsL9p/ar63HqFMbgHmV58MHKi9IQrQ8jhGEhbuQvB2egrib0M6VXzE+y9V0/Lsv
 BswP7MfUKcIsqhmh0GuHELtIal5+d7SGF/UBRUGQliKcxXnlfo2yagfNI8p6MBXxHqvm
 9rxD7FNQ5qkrcXk8ddDW7jbHCXZPOElWMCuJXTClSoArHuXKpbc9lq02wG/0uadGH6el
 6wR/o0JrG7tkOMTAgpAPTg9lZIqCuLAQ+lkErkVgfO8i8O+U7ACyOmNJAQ3FpNJSf4+w
 2aTA==
X-Forwarded-Encrypted: i=1;
 AL+hErFCv+Ff3Fjs9Dmh5zB3SDdrqfZZlgWdre6mVkpKlzUFV8hqSnnzj9SNbQ0NcLjKWNTFNJyGrsCRzdxN@nongnu.org
X-Gm-Message-State: APuU4Z9zzOD/Da/A3YSh2H8TMKx9D95Fo4hpmnTe3+FKHA6IzT6ikNLv
 5SNFUHgSR673R3weAMRFIazbi4K0hM24DT1in49J2l81jwB9qkWjwI8dMski3vICdpRLxfKyiuF
 Y+8zu2XFDlwlo6B3ICRP8V30h+g1Yaucp8qZFMeXoP1GH7/CsVG70EeqmLw==
X-Gm-Gg: AYBFou2P/QHz9/ruxYYcad5Vwd4Szx93bRk3008qxX3B/lSj/J1fKY+4VrbRlUWWx3Y
 T1hthtGVPdx+sxwiw/zlLInJ7zQ3TzrESF5cBOqgby9WUhxsiwqm9B6Shsu7bJT6JZjYx23jWL/
 TC50sSRs64sUaAkt0GOn/OaYrX10GKXw7NrvGNvZ6aEMXCe7Q2G+px7gPIhsgPQ8tkIW92h96vj
 Eu/XGPCnmpifxP0Fa09J2VRsJlVsjkSjoWOLz0GcCINGKS+hZRGbnhM1kRksCxq7oN+n/VbJSd/
 9/EcBsoKWeochls+mabgAfM8mmzm2QLKt3AbTjjWa82Ic3QLylFUfi44Dvu7GBToTTvdOeLNV7H
 EpwVm9kfolN6K6JAxu8ocXPNccu80P+zSDwnoMBXxmIFYlUn0hxz8wgqDGJnLBXAgHsEQ4OwLgz
 SaoM67qskmlTcBNLsCrOULqere9qcaI6KNUJ5b7oihuZo=
X-Received: by 2002:a05:693c:83db:10b0:36a:2f6c:490e with SMTP id
 5a478bee46e88-377e093d52dmr198207eec.6.1794421816073; 
 Wed, 11 Nov 2026 10:30:16 -0800 (PST)
X-Received: by 2002:a05:693c:83db:10b0:36a:2f6c:490e with SMTP id
 5a478bee46e88-377e093d52dmr198175eec.6.1794421815105; 
 Wed, 11 Nov 2026 10:30:15 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3766146551asm10063915eec.1.2026.11.11.10.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 10:30:14 -0800 (PST)
Message-ID: <03fccdcd-6711-4074-8d4a-a8b682388c9e@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 10:30:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] roms: add H2 firmware support
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Brian Cain
 <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261024180657.2036255-1-brian.cain@oss.qualcomm.com>
 <20261024180657.2036255-2-brian.cain@oss.qualcomm.com>
 <4e004471-b8e2-498f-8c8b-19f0983f7082@tls.msk.ru>
 <f03c7a6d-57f3-4b9a-8376-54b4c8d6582b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f03c7a6d-57f3-4b9a-8376-54b4c8d6582b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MyBTYWx0ZWRfXzP0/nGpNAf9h
 dQFGfaGVRQOf4uoYfFOgyY4Mt0IC5t6MFUtt/L15N3JmrbjkRNXSAwwklJKGXGUI9ffLLcGnCkr
 wjGSIkWLU0Pgd0nSLKzXgUpkx0nuxkI=
X-Authority-Analysis: v=2.4 cv=Yrya1IYX c=1 sm=1 tr=0 ts=6af4b439 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=TlB6LTUgs_LyMxKOGI8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: L0JTwga8VU8x6wxUo8WFkVbaGqz_VygM
X-Proofpoint-ORIG-GUID: L0JTwga8VU8x6wxUo8WFkVbaGqz_VygM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MyBTYWx0ZWRfX93Wm15yCjhGt
 w5ATR35alK4YGy/Quuw/y0ws2RvrmFvgmobjugOoJRYFwwk4kIvlQv9Zc/N8QXzmMCOzGI3Cvxd
 V1rB8mLdkHYx/hQNIzeXvwQjhMtqJeWxkH9Ffy9paeZTaMZKq9prWSEhX8EfaGXeG9c/EjrMsny
 AaS9egyU1T7XdPwyWqCx6q9BBGVK3bN9U64+T3aRqijPXQTMbbpCHhnHWA7bYyk7LgFG5+rLB6t
 OdoFSQIECB++LciDJ4/CceJoqmMcZi2WuMGBQ6N61g+oqswqifGvJlQri5YGDCmVDCR7ohs3jw3
 5xYpC8QcE9v0fayNR4dqHhPbwG5kyE24vZWOWnkQ55KPLAgMZhi7/+/qXKGBmJnG8bbKo5ZHrFf
 rm3erfJ2eTew2/ejP+ZH5CYL0lfc1dk0mz6goK906tKeFTkItJAjs5TPl6awXjjiUK62X2ZXFUv
 nJQazuzLgbAk8pIyi+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110073
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 10:23 AM, Pierrick Bouvier wrote:
> On 11/11/2026 12:09 AM, Michael Tokarev wrote:
>> On 10/24/26 21:06, Brian Cain wrote:
>>
>>> --- a/roms/Makefile
>>> +++ b/roms/Makefile
>>
>>> +# Needs Hexagon SDK on PATH.
>>> +hexagon_h2_build := hexagon-firmware-build
>>> +hexagon_h2_src := $(CURDIR)/hexagon-hypervisor
>>> +hexagon_h2_out = $(CURDIR)/$(hexagon_h2_build)
>>> +hexagon_h2_booters := hexagon-booter-qcs6490-cdsp \
>>> +    hexagon-booter-sm8975-nsp hexagon-booter-sa8775p-cdsp \
>>> +    hexagon-booter-sc8480xp-nsp0 hexagon-booter-sa8797p-nsp0
>>> +hexagon_h2_loadlinux := hexagon-loadlinux-qcs6490-cdsp \
>>> +    hexagon-loadlinux-sm8975-nsp hexagon-loadlinux-sa8775p-cdsp \
>>> +    hexagon-loadlinux-sc8480xp-nsp0 hexagon-loadlinux-sa8797p-nsp0
>>> +hexagon_h2_common_flags = USE_PKW=0 TARGET=opt NULL_ANGEL_TRAP=1 \
>>> +    HMX_HLX_SUPPORT=1 \
>>> +    H2K_LOAD_ADDR=0x9b800000 H2K_GUEST_START=0xa2000000 \
>>> +    H2K_GIT_COMMIT=0x$(shell git -C hexagon-hypervisor rev-parse --
>>> short=8 HEAD) \
>>> +    H2K_GIT_COMMIT_LONG=0x$(shell git -C hexagon-hypervisor rev-parse
>>> HEAD) \
>>> +    JFLAG=-j$(shell nproc)
>>
>> Can we get rid of the git thing here please?
>>
>> When a user downloads tarball from qemu download area and extracts it,
>> there's no git repository in there.  So the above `git rev-parse` fails.
>>
>> I dunno if there should be official releases for the hexagon firmware or
>> we can create a file with some version string inside the subdir and use it
>> if exists (as we've done previously for some other roms, for exactly the
>> same reason).  But the current version is not good :)
>>
>> (Testing 11.2.0-rc0 as a tarball, and noticed this immediately ;)
>>
>> Thanks,
>>
>> /mjt
> 
> Hi Michael,
> 
> What is the use case to build from roms if you don't have access to git
> submodules to get sources for the projects? Any other rom build will
> fail, simply because submodules are not present.
> 
> The difference in error message is subtly different (rev-parse failed vs
> 'no makefile found in subdir X'), but the result is the same: you can't
> build any rom that requires submodules.
> 
> If we want something that works with a tarball, Makefile should do
> explicit git clone per project and not rely on submodules.
>

Oops, my bad. I missed the fact that we embed rom sources directly in
our tarball, which I was not aware of. In this case, we indeed need to
specify what is the commit built directly (with a check to make sure it
stays updated if submodule is present and git rev-parse succeeds).

> Regards,
> Pierrick


