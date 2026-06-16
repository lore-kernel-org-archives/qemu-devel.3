Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF25CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXgN-00087L-Bs; Tue, 16 Jun 2026 13:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZXgM-000876-8m
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:34:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZXgK-0005JQ-Kj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:34:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH9NMA4167356
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mLn3gOPpemEBgSA7imu3GQIlvmWjENae98hVPlTWxk4=; b=TeZMxQsj4Rsjhijd
 ApiB4puZFAE7xqEH0PS97M8Om3npFM3dlHFdyi/gYjcnLgppUNHl3OZItUfTeSCf
 6AG2Fn4wnGNlP03ic8m0hZ4oKq3L4pK1/loXIgLcpM2aa9ts0K9PdPa0xKE69oYY
 FcSfNPkodazhhVgYM2dHgu5ukrAu+26ACoj5mLg7OnA9T55uhWVYXREzYYcoFNs2
 Z12PL9qVXXIXMB0gasPiEr0rfTrhwJwI0Rgciw1xCYTfQWOxhXBUbPiLnFe/e912
 V/x/Gfkz++sf1J5AJehYfU65vRCyrVXmN8h+KPmY8GHJod6GGffbh+LGidxgCRGP
 cCRWRA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ystrn7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:34:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bc7296c59so376046eec.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781631272; x=1782236072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mLn3gOPpemEBgSA7imu3GQIlvmWjENae98hVPlTWxk4=;
 b=H5btaR4Qb1mCBLbufe+3xtW8OsT6yX5dISVxIv54k9ZC06RMMYeZagWTqk0PFQFaRl
 js/bTSEad9MkO7ziNLBlUEy7+nAmUn5j6uMGS8+OTBodC23vOby1LjewdoGnFh1ghWhw
 6FQucnGwmYrOL8PjiUUulT3VgRx/yv4UGiaAgrzXj1dWTObC3otxj1nZ/0fnHAIy0mzr
 k1ASKyhkKsKnIDBT2kH8LSHazl0033kNExfQR42r6X6euNIlHaKPUEPab7Te0YTwRRIs
 wOteszwP0EbkMH9dc4+WagRrVOcVHhlj9RWJ7sefxUTqXqxKVjvcbeAYVUpfZ0HDY1j+
 Bv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781631272; x=1782236072;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mLn3gOPpemEBgSA7imu3GQIlvmWjENae98hVPlTWxk4=;
 b=RQsurgbkpvcCktD1J2//vvzVu3PtkorJpfAe5AJCbRI4KFkwEZYokvKFSQbP9XV1Ax
 IB4SV6QuZU986pWHANT/NoG5OpXOuK2Hxrrjws+cnYFF7XjD/yEhnarU9XkzLX+OHd3T
 Qj5zsgq0rwF8FjRCGReEpHhDJggAelkQjA3I0CEyZwK+b4ygh8Mt2ix4sP1AkZb6QP8l
 v4Jz1CiBOpn13ibAjj3XmDI+oSR+dYhmFMt4y2puYy146d3oDFntg0ilY9+LbbEt0UTr
 nkMKH0SNGiMttY6wx23GYOAXOBqveY4K4R9E883EPd73i/o8cimAf7VA8jLpy8cGrGFK
 aPog==
X-Gm-Message-State: AOJu0YzgcVn4ksiW0iTF/jRq41uH+dRm5aJ0+dY0DJdx5daKeXjAgstw
 2m+UCVZ6v0C6b0uT1dWDlK7vmaGhzkUvc3AOAh5nBccRjTtVKPDG/8S10xuYE3KLiPt+RTjRAs6
 jQ1AyanuxVxoOjhhYpSyG8/h7EL5rLPr+UXzQXdQtF1wGd9wT36U6SzBHduUZQcTI4fy7
X-Gm-Gg: Acq92OFjJyPPGn32t8VVKRxS87yGlwrpICLSCb7z7kKrsnTRwckAeIC9khu4pIbtmoy
 VK6MzBl2O91//lf1R1tyPCAewt0Ea7dC0cnm3Na1nZD3rwBy1KKIEQysZeInVVZWydRS0NkuSAc
 IfqiqKe485AEv1QyvGX/IMAZdi7b0Ko8QbrilZ8S5Sna6K1caOCzLzUtPLj4qnMXjeo+4++5t+3
 ssGJkZyJHK4V8biu46/b16yk2JX5dE4z6rRJIcczX9LOBvMIaviJ3iyj3ZfPosQ4zfwCBpMwbRe
 zac3gDQmVS3In7zCDkodJxzMYoxD+UFnsL6TaLH0Heod6CVAVM9AsSw0mof5ggLHhwTbFOWnx7R
 ap8F7RJgUVwJP1lMnuvn5ub/+ummTVa/zcDiUw0DJgsCcEFmi6U9Y5vOBChIQ48ApQpIMv0+Sd7
 CsPCtP92vubpCBKA==
X-Received: by 2002:a05:7301:10c2:b0:2be:7fc2:fc38 with SMTP id
 5a478bee46e88-30bc990ef57mr213772eec.5.1781631272213; 
 Tue, 16 Jun 2026 10:34:32 -0700 (PDT)
X-Received: by 2002:a05:7301:10c2:b0:2be:7fc2:fc38 with SMTP id
 5a478bee46e88-30bc990ef57mr213750eec.5.1781631271679; 
 Tue, 16 Jun 2026 10:34:31 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm21351310eec.8.2026.06.16.10.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:34:31 -0700 (PDT)
Message-ID: <2c5de0a2-4f78-4b4e-8faf-864e20900b35@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 10:34:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] tests: update ubuntu2204 to ubuntu2404
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
References: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6xgyFTr6gKAGdWIEkTVc6pvtWADfPDYy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4MCBTYWx0ZWRfX9b176aR9zok7
 a8LifkN7Z7uIY/A/AKO4mSS7z/3Q7DhGtQ+yWJG30iAmpysiSFO4A9HMZmOPRpu5kKD6OE7Cw59
 1xdHOPs6kilKO3ClEgjnH6wn/hYThpo=
X-Proofpoint-ORIG-GUID: 6xgyFTr6gKAGdWIEkTVc6pvtWADfPDYy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4MCBTYWx0ZWRfXw5dpmUwW7Bu0
 Lzkuan+5FV2nok/JD+//gwRiSxRxpY7QZaR1JxanKWC5jap4VvD8I9s4CHjhBLq7Rv91IKsy5pS
 ftEsTwqSU56mvNy+4nsd6BmppB2KC6l3NggqXRigVfuEzKMoW7RWwqx9c1S2PoQw+/HMIxjadVH
 Htkhgai73EdsDaOKSxGLb7dNJ/JSTEglFJB2I3rdByzNoVwYe752KQkcBkyUaSL6kJiSoK9EbK/
 VPFdEaCodKHWF2hWpAxnXj7cD89QutLvUgVsxpaoR0OFKOfNWBfekQPSEgpBwn/EesMbyJL03Rh
 oGGKnN7zhnQ+iegEdKjcb9H/7OQps24CoNw7W+kV231V/WdOTwDi1/tfcGx9wLFq+jck+XPkjAx
 28ktrGHQ1oSyzMePP8LteLTBU7wq0Hq4h27nqMjI9oubz2XFyoAW2ahEDN0oVEhq1Kic+vxMqQ0
 7nz5Gktnll1OmWntHcg==
X-Authority-Analysis: v=2.4 cv=JJcLdcKb c=1 sm=1 tr=0 ts=6a318929 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=mkg-ff_Mvfj7XMvBLCUA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160180
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

On 6/10/2026 12:22 PM, Pierrick Bouvier wrote:
> Ubuntu 26.04 LTS is now available since April 2026.
> If I followed correctly, we support latest two LTS releases, so we should be
> able to update. If not, feel free to correct me :).
> 
> v2
> --
> 
> - edit warning fix patch to explain in description why it's a false positive.
> - edit doc patch to mention all host images s
> 
> Pierrick Bouvier (5):
>   net/af-xdp.c: maybe-uninitialized warning with gcov build on
>     ubuntu2404
>   tests: add ubuntu 2404
>   docs: update mention to ubuntu2204
>   ci: update to ubuntu2404
>   tests: remove ubuntu2204 container
> 
>  .gitlab-ci.d/buildtest.yml                       | 16 ++++++++--------
>  .gitlab-ci.d/containers.yml                      |  6 +++---
>  docs/devel/testing/main.rst                      |  4 ++--
>  net/af-xdp.c                                     |  2 +-
>  .../{ubuntu2204.docker => ubuntu2404.docker}     | 12 ++++++++----
>  tests/lcitool/refresh                            |  8 +++-----
>  6 files changed, 25 insertions(+), 23 deletions(-)
>  rename tests/docker/dockerfiles/{ubuntu2204.docker => ubuntu2404.docker} (95%)
> 

This was merged into master (608ad9307d5b4797d2254ee3a4bad2bc8c8bcbae).

Regards,
Pierrick

