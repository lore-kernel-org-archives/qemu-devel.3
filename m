Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DCCCC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGlLk-00058C-9G; Tue, 13 Oct 2026 18:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGlLh-00056P-Bi
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:51:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGlLf-0001hC-Jc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:51:57 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DK3NMa1460089
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BlJjZcymRbvQ1DDiiXnGMoy3NZmeypUYhTBXRYe8y84=; b=AlkOpPoeIXwv56MU
 m8R1r26w4nYmvOlzKid8oFOiidfjLCeoSeAfx3EpcnKSYIsNv3/uSpqhwtfhZlWz
 ftr32Ad7EjkeqnD81OeJdvs2ZItiWqBaQ5pmQi4+ibBW4UEAzb4CPe3Akdyp094M
 y8R9cA/VsLpmjEAEo1kwMB0GOzmTAQtea9FnCJR88obctYAUTq2uY+VxfEdlE06H
 9MOFYJ5KvHMMagVW1dz5UuoB6yrJjXWJ/2UCuSUjXbtj5ziG+jNYbc2135/8jtIz
 +NCU6cPJ2TGKCgYjTSvm4XP4z6igpS+wdpCE+Wu99Sbr96mPYLA34i3jEAdPlj53
 hNy1Sw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjudwa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:51:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso7860605eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791931913; x=1792536713; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BlJjZcymRbvQ1DDiiXnGMoy3NZmeypUYhTBXRYe8y84=;
 b=MCuWwGAx1o4H+uWas44saqaKzMXu9aqp0lGWaOkMlLTPotbtfOVNFID5kGuvPrkJcF
 BxNtDe56PkgNY0X6FmTtOcCx5STvEUHFtyeoAGjYXWJBU//f4H1EymYN+Onikvy8Im6E
 zqtkz42zswZv+CJ18hbSM0D+SwhQha/3jBM6s5K0QKAIpwJ3vjYu2WGfhWORmd6a4PqX
 H1SxoH/e621VZdqn8LkJ1EEV/S2v1zMd/c90jxDYQouSbdp4dfanw2+2z7aKjfsKQNMG
 7sQmbaTg3FWTsw9FC5xp0Kdt2r6cTpQHAHsnNe2yGwcXPHJZ1VIjtAEEodIfInfXZfOK
 Y5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791931913; x=1792536713;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BlJjZcymRbvQ1DDiiXnGMoy3NZmeypUYhTBXRYe8y84=;
 b=xq8NFr7hMgSmFD4CjhEg9ggzNlR9VSlJLL4y6L2BFAz5bQBUtpX6u4JeesxqZ1R6vf
 aM+zcFeDyyx3JzOSyC/V6ArnDeeJDyG8BBwlj7z2Yh91V98jc7aBmpScZrYHsg5nZ6Uh
 o3vyDD8+3Ssj9UwtV+bunT5S+jt9jBlHUU33RmCSbY6WcAAHI1aBE73hNtLy4JLsERg5
 VOBF/4rKmKWK0k2AiMC4NeDyVmfu6jqZsXK16ryQvROe6VI1Nw1v3TxkIUn43BoEn0MQ
 blKt2LWd3jUfzYS4Xpr/i03CqOOhSWj98VsWw8jRldq34B/SOk7TJqX6mSZaDA25ck+M
 D0Vg==
X-Gm-Message-State: AFq9FYIFNvuViiMoX02YzpJiuWYnjQPLAM6BZ1716e6G4k0sBUSGiGAn
 Kg4mDIrGg8wRwClfMtQWiU+00YohQKqcmLcEyDIf+dbBKGagR/qMDJXD712EyyxyRXQ2mS2RNJY
 9WFUEW1vBrAGd9cnrgnScOP0XpDjGS7Ax1VJgD41v8KgNzOFRefpH+HEIfg==
X-Gm-Gg: AYBFou1DZBgQna6ZbpXCAokwFt0jFm8L2bNM3E0iSY+k9S0qiakquQ1Z302LfMSzg1f
 8YZ+A+AcaNVPMqrg6SMCtcpZfqithNAsRTiAeJUS4PEg5+scCjfeWsGLu78cQfntDaJTez7Cq08
 mXecdm/mfNydJUFH2VLVQCXOR7AsWrHbFpX58lwfxxTDXQCWtrD3PkPORLsp8wzWCxgA6dcntoi
 gka2INmkU4zGmT5VGpQ5lttLdwO4LCzfaqn3xq2gjnZ+BhwviiMXLUbuX38eOy/xrlcf1wQsETF
 e9L6MTvRI5QHLIcHscSndLmP5/2m3uXNgePWu2Fv9NIHpnv9jhsNH9Qy8s8RVkmiMr7uiCirr6s
 ZWEeRvkDBmYDtyURrpEiz3iK5W7J9NKdyUiqWhrZO3pm56zdrYWLp6Ck0zLOuN0RNAEygGQ==
X-Received: by 2002:a05:701b:21db:b0:149:ef22:2fa2 with SMTP id
 a92af1059eb24-16a5dcf5a62mr19391895c88.8.1791931912440; 
 Tue, 13 Oct 2026 15:51:52 -0700 (PDT)
X-Received: by 2002:a05:701b:21db:b0:149:ef22:2fa2 with SMTP id
 a92af1059eb24-16a5dcf5a62mr19391868c88.8.1791931911671; 
 Tue, 13 Oct 2026 15:51:51 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm44671070c88.0.2026.10.13.15.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 15:51:50 -0700 (PDT)
Message-ID: <d8bc6206-6b35-4c02-850f-ed11195670c5@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:51:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] container images for migration-test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mjt@tls.msk.ru
References: <8733vbtmge.fsf@suse.de> <asyX0JccFfG0ZMDp@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <asyX0JccFfG0ZMDp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA5MSBTYWx0ZWRfXyJgIOMiajV4K
 LUvoYQukPW16lEIG/5EkhFESqoeyHXXkc/OP3yKJpWnLE9uT+0lpEWzC4vKTwubKxuMI+ussAbH
 oj51szamGUZAmQ2Jjgv8wZArr8RxIFY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA5MSBTYWx0ZWRfX4ZbQj8/ZDskG
 99w8zHtx6/ToxMcpetLQrBN1SqQen2GE70c00QWyo45co8/TeP3AHgXpZJxa+cLQH6jMtOh2Ul8
 nYbKoZ2v/JxeEYIw5bLj4yxoLaioytGNHYvBApld2dd3ZCucHWv22cu3HUaJ8gANkIOMVAYRNz/
 EmINW5W9+dekHaqktQ0J7vP26w4ISMLP51LZiJILOVf0wKFKG+YsFFoNGyDyqr9NNA9AG9siiUp
 JkGcKESQMoQovsWwLuFzKrj1/mAT/Fyd5E/ZWZLn927HigbceOU9RU+puJ/loaEQoZ+6pzptXNv
 TE+pBS1fMpUQkHOyHwfAb/TGf3qdd4n/FT/wY64QuUQ3Mt2JThOtln6OYcaNbyABTayNBxk4Cin
 gLRbeCO7svbxS+CL10HPuzFOB0ndVHhE9yFCn4b57fbu3thzxAIJJDkx3ISUn1ijJRGXGzw8XTN
 nImbLphKuQq87qBfTtg==
X-Proofpoint-ORIG-GUID: nX9eu8kWOl9EzIFzcSY4nAjvwk__oT1n
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6aceb609 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=fxJcL_dCAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ayiGaCuBvgnxp1wScT4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: nX9eu8kWOl9EzIFzcSY4nAjvwk__oT1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130091
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

On 10/12/2026 1:18 AM, Daniel P. Berrangé wrote:
> On Mon, Sep 14, 2026 at 08:58:09PM -0300, Fabiano Rosas wrote:
>> Hi, I just wanted to share and ask for feedback on some container images
>> I've been building as part of my testing of migration pull-requests.
>>
>> From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
>> following:
>>
>> $ docker images
>> qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
>> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
>> qemu:11.0.0                                   018a3f0f4dcc          2GB
> 
> snip
> 
>> 2) Neither the QEMU build nor the distro repos are reliable enough to
>> allow me to just "go back in time" and rebuild at any moment, I need to
>> keep the artifacts cached to avoid rebuilding. Otherwise it comes time
>> to send a PR and I discover that some python piece has changed or the
>> distro messed up the older repository.
> 
> Yes, in general building old QEMU on new distros periodically
> hits trouble.  If building old QEMU, better reliability is
> achieved by using a distro release that was from the same
> timeframe as QEMU.  Is using containers targetting such old
> distro versions not an option ? The tests/docker/dockerfiles
> from the old QEMU branch ought to work ?
>

Using containers image we had in tree would be nice, assuming they still
work today and don't reference any url that disappeared. I see that, for
ubuntu for instance, we targeted some mid-LTS releases (like 19.04), so
apt urls should be changed to https://old-releases.ubuntu.com/. It's
quite hard to achieve true portability in dockerfiles over time.

As an alternative, this is an example of a single dockerfile that can
build all our releases from 1.6.1 -> latest, using only LTS versions
from 14.04 to 26.04:
https://lore.kernel.org/qemu-devel/20261011162737.3024-2-pierrick.bouvier@oss.qualcomm.com/

> Our stable release branches have the same needs, and their
> CI is using the container images from the old branches.
> 
> How far back in time do you need/want to go for migration
> testing ?  Is it sufficient to merely target versions for
> which mjt is still doing active maint work, so we can
> expect the containers to still work.
> 
> With regards,
> Daniel

Regards,
Pierrick

