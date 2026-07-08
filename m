Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08176C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUs1-0007bx-98; Wed, 08 Jul 2026 12:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whUrn-0007Zj-3Q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:11:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whUrg-0004QZ-AO
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:11:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C3Ec62751436
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8+7oy5XvMxGGcBJTz9zw6CXYHe+C7AC9iXVcuc7gfBI=; b=RiaSutxVqX9S8O/g
 TszGkNYvc6a2gglD0udwDllSE66GLCvxY+fZRaSGXvMjUxc/tcS43Rb0JyG5gxPz
 GIp9QITzUcx7zY/aHUEue6th9kyhlMtgAttoEh8H6h5y58DS/tDLs01NQbybNuFV
 vTgK0SGKNpLm4qofGnryM55BJj2TOVUGA3pWidX4o/fJ82Qkr5vWui3g25hOn+a+
 rUpNu4fxYZwVsvW6z1CS8Wl1sRBUa0uwCAN4asDvbYU2bR69mTZ08JwGUBTypkL2
 23MRYWm58jwV/BobiPbGTEdXFm558tVGP05pQvaYw1idOTI/ICOEuhhYxvrU4Sju
 DJlPxg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hjpfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:11:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-384048e7e14so1272664a91.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783527069; x=1784131869; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8+7oy5XvMxGGcBJTz9zw6CXYHe+C7AC9iXVcuc7gfBI=;
 b=PzjqIBPr/DxdkTPH5GToq+7Rctl8qcqoV8KQjwDa4EU4O7+ggBe4uGZSz9Z7i7EeBV
 EWoZO2vNeMNY6ZeUmgqmGckttk88EBeUhDF8hnoqdr/F04hzIoxdhq5Oa49dX393OAbJ
 kQZvIvN0udbHVxQAtywxgrcNvgyhJi2gxDIqSKZvGjTf5TrSDasdxi6C9fS+zjoVcP3O
 gF5BvO+pa64xJe5pj2Nvh0rri+jhJGbAjyKnNCf4mmrDvI2Zf5CS4F0961TZ7nTmZqMC
 BV6y4DewU31fAiejcCnMBteoT47R+7OLPX/zDHIkPRLG4MnrO3tHM0b8Ceh82xkk+Tsi
 3Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527069; x=1784131869;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8+7oy5XvMxGGcBJTz9zw6CXYHe+C7AC9iXVcuc7gfBI=;
 b=Eu+pCst8dmp/qxNZvwd4Ogn79pj9Zc2zSKfQ7rqW/oR+k0wv0fs3PvH8rve/uYrHYr
 cW2kqeceyTXcRuEK107Z5uX4KHVUikBnCdWbUw+AbzQ/L3dvQHPucLf8tZuXreiQ07k+
 H0+XCpDa+YHzm3IKQCydAKNQm5R1DfyB5ukUfNGMXxdWVU2Q+WOQh1DapjQcn4x3tE67
 C1+ebFdlhmXN538AXQLWuZbFfD/6SguRj+f4z6lQX6VEJ5ePSX8ApHE0N9BFidr7VJPD
 nZU9H2qIHTwkzlvRvcV47H111ac8b+P3LSWCMYV8bZibLficHDZqGw4uDcJJeK2VFbJg
 /W7A==
X-Gm-Message-State: AOJu0Yzg1m+pQ70n+ZZFhT4cJlcpph9hDgtrqC1IprA0efLD0vwDZu1B
 2ccCeR8Dlu48g370DcXsPz7NDBZOOV55lKZ43cyrbRUY7/lnPPv9v2/sYpidWXxEQrLz4dsHe+a
 0yJK/jT78pIiVZy2w3HrcmGh7gVoff7TtJwgzxY6heECzrpwWNiC/XO7y/w==
X-Gm-Gg: AfdE7ckiQ6dvuLyb/V5PSlgfyZO/fiy0d+nooRACcixCeCxzeHvaJuRRNEQqrc1qSkR
 BNR9aGdYIS8EhjHQRx2fVS78E7NyU0LfhlkqToMU8/F11Ae/VD9y8d0y3WQ7CvLNqZLj3IwRgZd
 DwccY5CUJ1lE2Gug04vTYlE/qZ5xuAtc/1q1FwPDkFI+XLf5kigZit4ws3O//6KkUgGvm5OEhYO
 HyQK92mhh3lAbTKHMBORve7OcBx+CQdrRi9PiBnm98xymRwkbSuiFA2d/yYg26drPiN1oReLqU8
 vQB/0Ewpo5S5qjwKy7E81zd0jFpxGYwl3gcaEDfoVAHKdKxrwEgRQLBeJPbKFjhZAFoJOrWt/zi
 Upb8O99kJchBOOwpaIZUhcnY+HNe+5bZ1dLIZq828VPauagsY7sUpgo+oH02X1scNE7TpizM9eP
 2Z2Po=
X-Received: by 2002:a17:90b:39cd:b0:37e:2005:6509 with SMTP id
 98e67ed59e1d1-3893fe5b9dbmr3628769a91.3.1783527068530; 
 Wed, 08 Jul 2026 09:11:08 -0700 (PDT)
X-Received: by 2002:a17:90b:39cd:b0:37e:2005:6509 with SMTP id
 98e67ed59e1d1-3893fe5b9dbmr3628717a91.3.1783527067940; 
 Wed, 08 Jul 2026 09:11:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a5b26csm21247572eec.15.2026.07.08.09.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 09:11:07 -0700 (PDT)
Message-ID: <de1a5a28-7469-4331-9e47-e43f03f0980d@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 09:11:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/docker/dockerfiles/ubuntu2404.docker: add
 missing apt update
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 richard.henderson@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
 <ak4H9Tn-t5rRH3oJ@redhat.com>
 <24403961-c7e6-4ab9-9d1e-719caa2f959b@tls.msk.ru>
 <03e7ce1f-f25c-4e83-be4b-042b1100c104@oss.qualcomm.com>
 <7a0e3797-1716-4d4c-89ed-9ae1ee3140b4@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7a0e3797-1716-4d4c-89ed-9ae1ee3140b4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1OCBTYWx0ZWRfX0NRX6fpUVSVg
 XAvxlKblv2LUCwu2clTbAb0piXeyLbC6jgFsGuDyvD0BNU6ojdosnyGyF3+39TbAOnOoLHY4ay2
 nlEeMh7mQ4EoogeXL7rgxcCJISzq64+ftdz/16cqrEasGe1afZIR/jvkW6XidMACHY5+ZdXUfdE
 VI5HsH2SdlWEyp2gXBGJzG/cYejas96S8k+8iajh2cfpeZ98qCC1Mtky77QQSh7Gh9kaqVaeh28
 TgMfmVPrtpEuLfsv2HxZMhcD9eaDdJmtv5oQw3BNJjyBTSRTvkND+a4QeIxDZ/kMZmozhMSwCsb
 /unT6xB1BF2mpopzcTRFF2RF4dJj19fKvc+wQcaZn3ulJ16QL/STTNnGPgOqPDg940X0V8pyIC9
 xzPPPJGn3bODaFb9zzANSBi6buoDNITxENzvqEa4uXccqx9as/ltTlJaa8ciu9DOjfxgoG3V/rG
 jJ7BrGivtLeIQZtSIoQ==
X-Proofpoint-GUID: z7M-mIh4l9786vLBXqSlgdNvXcE8Zjj5
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e769d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=n6MYwUk4AAAA:8 a=uPZiAMpXAAAA:8 a=R2two0n6AAAA:8 a=FrIm8lUnDmQE-uxnit0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1OCBTYWx0ZWRfX3z0rSkR3U+cT
 qHIaNBw/OqlzrRDzfD54XXDAD9AYQp3yigSQi8sT8w9XTwG1LjBhqZZ4akcEUaix9twIAtpbdfV
 xqUr7wlZS+xMU9NP46R/2h1ygMCpNVw=
X-Proofpoint-ORIG-GUID: z7M-mIh4l9786vLBXqSlgdNvXcE8Zjj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080158
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

On 7/8/2026 7:54 AM, Michael Tokarev wrote:
> On 08.07.2026 17:28, Philippe Mathieu-Daudé wrote:
>> On 8/7/26 11:27, Michael Tokarev wrote:
> 
>>> No, running it again should not be needed.  Unless we change
>>> /etc/apt/sources.list.
>>
>> The problem we want to address is wrt remote content going out of
>> sync; we need to run 'apt update' previous to any 'apt' call which
>> use the remote.
> 
> It's definitely not required to be this way.  Running `apt update' once,
> when creating containers, is enough.  Any subsequent apt install &Co
> will be run "soon enough" to avoid worrying about cache going out of
> sync.  Even if meanwhile a new version of some package has been uploaded,
> old version is available for some time (usually at least a day).
> 
> So no, running `apt update' before every `apt install' and similar
> is not necessary.
> 
> And sure, you can do it - it's just some wasted time.
>

Sorry but that's an incorrect view of how docker layer is working.
There is no guarantee of how "soon enough" a previous RUN statement will
be ran, before a next one. As long as command line associated to RUN is
not modified, or that base image is not pulled again, all previous RUN
statements are cached by default.

That's why Richard observed that his container was broken for weeks, and
it could have been broken until the end of times.

The recommendation given to him was to make a build without cache, which
is not the right way to fix it.
If you want a good analogy, let's imagine you have a build system with a
missing dependency: you can either fix it, or suggest to run "clean" and
start over. The latter was suggested.

In the case of apt install, concerned package might not be available
anymore between previous and current RUN statement. That's why you need
apt update with every apt install.

Those links, including official docker documentation, explain the same:
- https://docs.docker.com/build/building/best-practices/#apt-get
-
https://stackoverflow.com/questions/34248439/in-docker-why-is-it-recommended-to-run-apt-get-update-in-the-dockerfile
-
https://medium.com/@janscheffler/lessons-learned-apt-install-in-docker-images-bfad0e026f6d

Another common example is a previous RUN statement that downloads
something from a (now) broken link. New builds will fail, while cached
one will work. That's why building containers from scratch daily CI is a
good practice. It's similar to what we observe with QEMU functional
tests assets that are cached in our CI, but are missing regularly, until
someone unfortunate discovers that.

Running apt upgrade/dist-upgrade manually is not recommended, and the
best way to have updated containers (especially for production purpose)
is to rebuild them from scratch.

> Thanks,
> 
> /mjt

Regards,
Pierrick

