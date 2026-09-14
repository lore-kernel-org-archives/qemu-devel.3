Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A78DC88E67
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5ynk-0002gm-0G; Mon, 14 Sep 2026 01:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5ync-0002bU-5B
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:00:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5yna-000666-Af
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:00:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E2emlK3865188
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /1xkf9rckSVfbn8++et+p8jM8FdvKQN0Wm+wwjvVb0o=; b=YeQJDiHt0Nq0Xsnb
 RhpHg5l64rX3SP4NNl0QdczqHnCZGY+haelr/eUKEBeYYKF0JAFTrwi8Dco80Npw
 GPldTCr5J6rmnULKDojJvoVvHZBbcngseIcACzh5g4z4gf7KmLT8YkHor7BkWB+N
 Zlmf/ul93FmMrWbDg8yPAP+lu6Q6QWgPLPFAApFj9uFs9PgKF2qfzt0FwioSVTYI
 L8mcTnHhs5jxCLaiTBpXtXsZvu3WYeqIVY6hiIXgszzy8dJMxVVGXTFjdjPYcp4K
 ewbj2d9BbrUWzUrqKa2vfHWIMEgPWKP4yBTJrCiGyRGG7mFB08TJpkvAJNXsy6fv
 vIhNNA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dn4cx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:00:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso53643485ad.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789362005; x=1789966805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/1xkf9rckSVfbn8++et+p8jM8FdvKQN0Wm+wwjvVb0o=;
 b=C7IZbASg339MJEXI6L7FfM4q60oWfU30OuP9zbkXtFcUUxsIQP+Vwm5Gm3Q49ksTww
 0ijpKaGDAfDoUGptKhf9zIQAkAx3ednW3SZTYUAPFZd/QfeCljufkkmxSKBN6ssjrLO6
 UFuX6Jt8NZTGJUXQIiJ4fwm4DybMPsBuGkNPhPbdsk4dIub3BBU/qdbdSW6DLBTRTrmL
 M6WLpRkLrdVUEedPWjA05mRP4Mf/tEkg9GPANJ7JNafNGmSsYVSux+7pKYPJgIeCnhoe
 rj5L3xewtO0Du54jryt8YaZ4gJ2X6THA7YRwl65k7K4qasxchlmU6e/MkiDwK3f8+osg
 EzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789362005; x=1789966805;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/1xkf9rckSVfbn8++et+p8jM8FdvKQN0Wm+wwjvVb0o=;
 b=rmzXwyOx3E4m7yHwx++MNIZkFF3zLB6Xp0+vhGCC7iN+1qK4ScveFIDIMCPsoCPCqk
 fc/2qr7Y/NrcDkvUNzhFGfzMcmVYhYmp22qkcEjWpPAOTailKHtBXGQv98Hh9tKHjfr9
 lzwa3TVv6YqfjlK07bkoabE1eygaZNFYltYHV9bIdyGDm2jlz6S86+rRMAp8NBQ3dLMH
 iOVGHAckcvuqeuvVO1kY/2fu3xIgxvHf30bc7JL1rK77qw2zr85yMmpfFFtwV6Qt0aOJ
 I2u5yVFdSdGcZ/yh19Dbu5tIezGixU2UXQuXO4A8qPpNlv4oPsh+qqYaADAzxKjhT5iY
 ujHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmwo/P2mWWtEUdTPo1aveF9s41QnWzVPn5GvopUy3CJjDE+j+SW7+hDAHhKTFYdnsR+sUpknyjdvh4@nongnu.org
X-Gm-Message-State: AFuF++mRu9CXmWXIoJMkhdz2TWOTAojubbP2m6UO4POrsRWmoeByxnPK
 epPCYXGs1oScBqykD5GJ4yDRjCj4nQI8HIe1V855hVnnNbgsKr2LJlygB/edzmd5/avp+6ClFQq
 9x0LB1G2YpJguPtn50bKUXx/qkwbuo2ykiJaiMAfnallSgJl+np7dXeg+SQ==
X-Gm-Gg: AYBFou0hFTvXDbqxysA9V0d0yNbyEHWrJ2mZcPuNfFewtzV5KP+QiaFnOoFQ45S87bV
 tQYUN8PRVrhRJWyax2Y94v+MUX6qEX5p8acuvl6p8q2UzHpa7oWXEFiHLuoG7BrbRdzaxDWFNKR
 xfmRa9wQXgD3BFrih2EiHZdB7zI3noYbTSm8MUAgiJG8ALh1SokoYf3zTQtneSyK/H21O/oUCJQ
 /8Ko/ih9JNfkZJLsbnqMXJkH1q6bhrvmcPrQ1wD7jerFgVIgnyNa1OSbx+nI2Re2HIaC33ViMig
 aPpLa1nuLtmfcZqCt1K/pqyCvcfF90FXdlMGk9nm/lk2rbBSoYxErhoouoz8BiJwyYmmeHwBrH4
 L/ovmepHco9E4H6zwgdpWTzOQBa7BI6FTcO5mAb1l7pt3kkapzqDgq+U=
X-Received: by 2002:a17:903:3d0f:b0:2db:39da:90f2 with SMTP id
 d9443c01a7336-2dd6c5d60fbmr22963835ad.8.1789362004740; 
 Sun, 13 Sep 2026 22:00:04 -0700 (PDT)
X-Received: by 2002:a17:903:3d0f:b0:2db:39da:90f2 with SMTP id
 d9443c01a7336-2dd6c5d60fbmr22962755ad.8.1789362004240; 
 Sun, 13 Sep 2026 22:00:04 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfc4403sm41787015ad.52.2026.09.13.22.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:00:03 -0700 (PDT)
Message-ID: <d925904e-6a15-4c58-8fd0-e54d5724c364@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 22:00:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] scripts/meson-buildoptions.sh: update missing options
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260910181504.1010916-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA2OCBTYWx0ZWRfXw91ANWlPNEGz
 85yRcNsrkfNFZu0GuOrfseson90Fi5EuleeMOIt4OTJMuFmBZ3uHM8iHo6kSww6V1mGpV5U5Zua
 42sRYSYTSVJdfGA5ZJkc7PAkHhUnU+GszWsF0T6dEmqesoi6u/+FdXq0r3hfArnClNtc84s0UVC
 zXWV97vDNVZcBW20ohm9VVwsR+XJl3tNRuTERKtLW0NO7+/Tk/Vu0fu7g1gPQmUxAChxvTrsv8z
 Z5DDh0K3qWrWW21jw2NbOXGpwqv/vl6VQO8iKceQe46D7F4VE9wDgaSFgEgOLk2gDJtRp6sWEv8
 inFDbBL06d9tjd5fZDnY67HaIRoLj3VxkFuWhyEzKQlh3OhfVbat2blQUh53mRjAdCiNs/CR1ZK
 mfdK/XD9BvRhGe3ntzMRz4R2GeizGORBx6sMxUxAd4kPwYQkmkgj1riI8VGnhNx9FxhUgbGOKCd
 6UfagVXik9dKGVBgX5Q==
X-Proofpoint-ORIG-GUID: A22N-Xm1YhLcIiZ6_sWijJadV-A41Cdy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA2OCBTYWx0ZWRfX/UWy3leKTl4F
 D/5VF55Fy5BPgZW5x0kCNNV4HH1LywQQIXieNIzDkAjj01QPYB3ZDe0ijQ1ifZkevhty64OWb/I
 IAhZENAg3864KJSYPEtpcQe4AA7nSpw=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa77f55 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yqi13mcQqCKfvUqUR4sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: A22N-Xm1YhLcIiZ6_sWijJadV-A41Cdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/10/26 11:14 AM, Alex Bennée wrote:
> This should have been updated when the meson check-tcg changes where
> made. Include it now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   scripts/meson-buildoptions.sh | 142 ++++++++++++++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Thanks for this fix.
I can confirm I didn't see this needed to be updated, simply because I 
only ran make check-tcg (which didn't retrigger it), and use ninja/meson 
test for everything else.

Maybe the best place to generate this file would be from meson itself, 
as a custom_target run by default.

What do concerned folks think?

Regards,
Pierrick

