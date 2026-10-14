Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA4ACC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 00:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnJn-0000Lm-AR; Tue, 13 Oct 2026 20:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnJl-0000LW-PM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:58:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnJj-0004p4-0W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:58:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHkjc23000921
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GzVMQX8I7fYqz5U89JrjfjCa7QJ3gl6JLPhXZAe2T9s=; b=ppX01kHZHfjKk5ru
 xJacXZTk7rhs9ZsCwyjhqHKKYraMQDPGrywNJ5be9HiUWPRdUbj5EJnYuEA4+lg6
 2cV3NhRO94pRTmxQRlQrO6llwWIjP2F0LHMzbCTm7QetphaOhFk8iInRRAbH6INY
 Pp0nNB8XuHPfmPzgFd3BE/0X7/+eVZbBQxwdO50InS7eUgqpyYFxHsuvHigZ128J
 2lGqxFvd57BGWsxXezb72Yr5A7LjnsH42offvCJOzSSJOBdkPY2GmlMolq1LcZg3
 Hf/O9t8o5Z0P+0mRxVCHXINp1O/LjaSpNQhqKLdaQKsKQ1f0gFsAjcYsjdNAde5f
 b6esWQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbesg1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:58:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso6912460eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 17:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791939480; x=1792544280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GzVMQX8I7fYqz5U89JrjfjCa7QJ3gl6JLPhXZAe2T9s=;
 b=UaSbtGjv/rwHCAPR+0V9eKl0a33dWCJFxKkoPVh2lH6WNaK6FRqRUesoC8fzja9PdB
 O9o5jZN1RnWJ1pqBW0bGK3CENfoXc5dnLgNhFmpmq+J5JJl7S9nHQB/HBbjWTYPgtLPG
 R9n7/mXMneLEpyLh2aiqWbBtY/FwVenAgya2WiLl2U7runDyBZgiZjClGq1Mvmupth8X
 jZyYORe5jL0na3s5YbsEItXlOBNl5Mlgr6+6IRnZVDQAoIwsH4HcjIGaICsv1MOfjTuY
 1AhnBrPHJ0ZOTHUeDxw+g0pe2kEHiHfplz1bLHsGbFxVKtb/QBTsVhw18E1+HEL0HHx0
 vVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791939480; x=1792544280;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GzVMQX8I7fYqz5U89JrjfjCa7QJ3gl6JLPhXZAe2T9s=;
 b=pcgPHs7TfRDPBHhLPndjqBSGYcKuMkUsYE2Sv2cSe6V7evpusGG1bvaidphkRsUfHS
 UpgXqHEFvySPWWLjLEUY69mHSLeSGampRtYISuu4ZDrE3FOqxtpIf6q8RBP1T0D+DU+K
 f/eZmegwHPi+A0kQuIDvsWX3O4/2LWXcXi7reeYMMZ5l5opgY0pNQJOGF7rEkB+iZbeI
 1M9bIVp0Gtbe+TiiLmZiTP89q9yAB+KL9EFDup7fyLXrWRYVDexo+Z88PPa2sU3AKgwv
 SMHtBSehYapXY+6HT4CJiELi3OshdDZhn0Cy4egueYCQg2jZNlNzH4Lp3X71mDgr4er0
 3Pog==
X-Gm-Message-State: AFq9FYLHeSm4KcRW5tu1g/nXifFbECBtluqQIy0AWiRRubSphD/nONaT
 bubfdcIzABp7gaTkj9TzpvSzFuq+l0MnNewanR6X4th++DJ6Y3EpDvdjy2derd2nBfX49/Sr6S8
 DCT0kjXyW2eKzdEuL8nnwEqG1yTIkBd41PuR/ePD5JbKjws4hMs/biBsnrPnLxONszQ==
X-Gm-Gg: AYBFou16wCuECDUXtn88jVeUothIN3/UBEgJdBu4XwqLEYO6ivWQhJCNb8fVV8kKkg8
 sTGMMK8Vzmjz43gUYhl+HcNC5NOHuL9UKEaeRezUPFKryr1FH5tvPehM43r+AiNjT32Pz0HnJso
 okKlawQCUIc7OWSVPuBKkcz2k+8+hfr7MnIxvcg48aLEAphYmeHalNvVTGUNrsU+tZp2QNmzXGN
 BPjZ8Dd+3or0qXdL2sNWG5okl/QASGYJtu1hOUTGhv1TStYsXYaCNBVqxNJe9WQqtcLQtI6cpg/
 yBgP7ZcmUpkSE7kj4P7wBREF6i/YEHYOscm7T+UyfBAehP9jHvdN2Db2CZ08/JLImZvtn0vJWO1
 ZOOLCPL4P8OwwwRii1n3vvs/mQvXCQYGobp3MNQGlYfbLDNgiC9L21LKjGvsCI0PQdZDdjQ==
X-Received: by 2002:a05:7300:e5c4:b0:353:5d9a:9971 with SMTP id
 5a478bee46e88-3537e088be4mr19767010eec.18.1791939480328; 
 Tue, 13 Oct 2026 17:58:00 -0700 (PDT)
X-Received: by 2002:a05:7300:e5c4:b0:353:5d9a:9971 with SMTP id
 5a478bee46e88-3537e088be4mr19766975eec.18.1791939479615; 
 Tue, 13 Oct 2026 17:57:59 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm52433423eec.17.2026.10.13.17.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 17:57:58 -0700 (PDT)
Message-ID: <8719df60-a192-48a1-90de-e0b43e37680d@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 17:57:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] releases: build and run any QEMU release easily!
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peterx@redhat.com, mjt@tls.msk.ru
References: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S5LQRUPt62x9y5ZVPY4YV2gss4AgiBMC
X-Proofpoint-GUID: S5LQRUPt62x9y5ZVPY4YV2gss4AgiBMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfX6hvNNLgEhTiq
 u9/wuzkP0LxOqqJbJx9mR8pdoCF5IMafxxffLC9miYXtzS9NWh+hQaOIxgJgzncljhotB1E129N
 091Z1VTzNckGi3PiaThr2zWN2OFvqu8+rXfy+nB0TEsmtSp8nTlz6fbFlLjVLUH6G6qbpr/ulV8
 0PXReqiPobp0G7/GWA2J6mNB0dPLMJSxL0HbCGa4GlXRHYUYh/n+A91h1uVG2CO8Gg+HFRpgsyW
 0j6sxvIHUG1FrXQF9hvbVmjMU8TUlw52/P8dXhqHgEcJOoJkOncoSREKZLQ3hkxf5CbSqPGJqOz
 thUxHyqxQ71/oVdQ4C3OD367WTJagWEvyQs/oJuGc3VWGH6KpK7lAr3b15Omh08nXQ8yy5BC1em
 1MJX4AVF4SPCqVlZQUxQqYnIttVJQIlt19c6e3gTEzyUynnxMGL+bXrB8ELV1FySRl2iCRYI+Um
 KsgnFVqSrlEWj2tb2Yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfX5Hs0m4Ajb3lQ
 q2YtaC/HmTm/TnVjaicexcswLToy3WXP/dvh0AhJdEivG8e404q75iqoEdSVvUcaexyw9khuPPx
 EadX3gjB08arwJKtVDJ3TYyS502xGpU=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6aced399 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HcjIUGKs2DahF9jiNQQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140003
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

On 10/11/2026 9:27 AM, Pierrick Bouvier wrote:
> This series was inspired by a recent post from Fabiano to provide container
> images for migration tests:
> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
> 
> The idea to be able to build and run any QEMU (past) release with containers was
> in my mind for some time, so I gave it a shot. Finally, it was easier than
> expected to obtain a single dockerfile (with a few hacks) that works over all
> our releases.
> 
> The oldest functional distro we can find nowadays is ubuntu 14.04. Because of
> this, the oldest QEMU release we can build is v1.6.1. Previous ones require an
> environment we can't get easily today.
> 
> Images have the absolute minimal content possible. It's only qemu binaries,
> artifacts (roms, keymap, ...), and libraries. There is no shell or any other
> tool included. As a result, images have a size from 240MB (v1.6.1) to ~1GB
> (v11.0.0).
> 
> This series adds 3 pieces:
> - a unique dockerfile to build any QEMU release. User has to provide an explicit
>   Ubuntu version when building a given QEMU version.
> - A script build_release_container.sh which automatically detects which ubuntu
>   version a given release should be buildable on (based on date). It works
>   great, and the heuristic works for all our versions.
> - a script generate_release_links.sh which creates wrapper scripts automatically
>   using prebuilt images (hosted on my dockerhub).
> 
> TLDR:
> $ ./scripts/build_release_container.sh v1.6.1
> $ podman run -it --rm qemu/v1.6.1 qemu-system-arm --version
> 
> $ ./script/generate_release_links.sh qemu-time-machine
> $ ./qemu-time-machine/v1.6.1/qemu-system-arm --version
> QEMU emulator version 1.6.1, Copyright (c) 2003-2008 Fabrice Bellard
> $ ./qemu-time-machine/v11.0.0/qemu-system-arm --version
> QEMU emulator version 11.0.0 (v11.0.0)
> Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers
> 
> v2
> --
> 
> - fix generate_release_links.sh: was missing userns option for podman
> - dockerfile: cleanup "|| true" and replaced with proper ifs
>
sent v3, adding support for ubuntu 12.04, and thus lowering older
revision until v0.12.0:
https://lore.kernel.org/qemu-devel/20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

