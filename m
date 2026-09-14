Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC25CC88E67
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5z9m-0007JQ-P9; Mon, 14 Sep 2026 01:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z95-00070d-4v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:22:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z92-00016o-99
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:22:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E2eL1s151569
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1KcY80vIH3+qRva290soJZ9fVzqxRjAbZLponmCsgJ8=; b=MvmYMe7qBAirMLq4
 HXpHiRtQz19nTO2gYlT+d+q5kx4/eJ9SSx3jEAblvQnRBLX6Mgqxh3xrgo/h5eY8
 PqbrmfjVFGpfTcse5WaEePM2xdQr8BNWd+hzcn/OCnXfmIB1vRwMq/BZe1fl9w/f
 7eJOTsgLeRkatCOLlpPfIDlKSUh6kpWfkVxr2LL6e/suM3HsLweo4SjiHft3z82o
 6jXiTSE4O+/qU/TdL+/HUCQKl9cSao+lQVXrwmq/PNZZgjLslMeKSUYPGxTdG7hW
 WRLiLaZpbNkfypzX3XSMjvjlGBTziW/9loyL1fPtRPKtkrLMntMErqknEoujntw6
 5uzplA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k08yhm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:22:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so33315815ad.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789363337; x=1789968137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1KcY80vIH3+qRva290soJZ9fVzqxRjAbZLponmCsgJ8=;
 b=U5gVLchPWRjxu0XOMeh6v1JhhjEonfcOyPo1JtY47aN0SrTUJOYKt/z4188fXS2d3A
 kYiLp2w+KnBFyp7Tk1qLD7cdVhvlTM4GZhMGKwOgJL1w37ovlKhJm8udUVGbOI5quB/0
 KaWavc/gNgj6iU1t7E/08DK+fKD1sHNM2bBpmary5i6i4WR3GNcoiqrx24STV2Pw+Wgb
 pynXa2xp9OU6ZbKpDdOB3n8KVUb43Dg7u5Awf96DOkcDscE6kzGRqXWrVEvhjsXeVNZZ
 bEbjuEzAvmV9F3psveCrBLJSE1ZWXCLk6+pfcdOhuwjNvWwgm63qujoJD8HrPNyuC9o9
 ItIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789363337; x=1789968137;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1KcY80vIH3+qRva290soJZ9fVzqxRjAbZLponmCsgJ8=;
 b=HsJl4ru/1T96PGG1utrxK7q3IAfNGISkRMWzpGMDPK79C9ThjZZ2TGgiHAFq9fO7qr
 e7kMzBfWBopVIa9Y4cJjVziRQtyZR6FicfQWOhMr13wi4BwPWZtCg3NhiZZI1DulQJGg
 Gm8qHkX6Ovw9s5RfDL18EA3UTJHJcrXHSw4tDCYbhn+tP4c7V6ErGUtv4EY7dA51V6Vx
 Iu4EdyGnI8Ns0i5oRAx3r8op7wiPBT9O43j03Z0QfsJww8aFvYRYsxK28lWPle7Vz1Ic
 yc0lflXqJJf7IuMrKN46T7134vh9ue+oflbNIvJv/9N/BuInz2CWW21lpCLyBlOY1iyv
 EarQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByi8Xb5mONInF6lAqMIoEx/ms7CCTO8jjUx+AHo1BvRA9Eso4s+qLMP0arbIF8khtYsp0LI+HtIFTFx@nongnu.org
X-Gm-Message-State: AFuF++kaRugvfv9GmCE4zTweO5v372yaGWwmSjlCN+ShS8Y5hAO6i7Vi
 DDdefG34qw1HRPswCT10HiEy7l1/QIkRgZgklt9BuUTBQd56zux5g8qnkDjmVGqg0p6JaQigtqm
 hy7eyPEfC9NUlk+m8uphKOwzRYSQgSUR+OZNlOHVTJEGWe/dyOoRezS/wWQ==
X-Gm-Gg: AYBFou2Ep46PYGMPn6D7wInNwL9jZmd+s6vp0B0upqgc0otrmztYCzNlkZoJneXYvZZ
 ArYS9DZ16O/r5za0GVevX/eY5WBL0P9141tuZMp5UrguVcHU9AjaxMS8ZRaVkuikvBn++3Q76+k
 pNSZt3rzjJwZtRQphxhGaqYiOYE2Koe3pz84epjyLZoggvi8KLcZ4NntWlSFMYPvw5OVkKwje/i
 99iL6m7QPph33Ou2q8On06rq9tHysUt4EqfiolzLml17kuMOMxzKXyNIJ7Gog0iu55I99nw0DA7
 t0o7wRjCyA+eAZcA7hUbe86sWjwaINxxPNqwnlabn3Rym9v6QwzC5+xAGfiA39LyKShM5q2uiab
 yf92OO27caujr5i6nDfb3iFy9HvVskobd/FPvgo9J7vzZgXawan41Qng=
X-Received: by 2002:a17:902:fc44:b0:2da:e67a:87d4 with SMTP id
 d9443c01a7336-2dd6c75e064mr24498665ad.19.1789363337007; 
 Sun, 13 Sep 2026 22:22:17 -0700 (PDT)
X-Received: by 2002:a17:902:fc44:b0:2da:e67a:87d4 with SMTP id
 d9443c01a7336-2dd6c75e064mr24497915ad.19.1789363336566; 
 Sun, 13 Sep 2026 22:22:16 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cff297esm41631815ad.73.2026.09.13.22.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:22:16 -0700 (PDT)
Message-ID: <150e7e19-d8b5-4034-afd8-08f50168808e@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 22:22:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] tests/docker: strip remaining caching logic from
 docker.py
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
 <20260910181504.1010916-8-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260910181504.1010916-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA3MyBTYWx0ZWRfX5URY/XKQHoza
 F3PK05ztJvlwF/W6Ej02bTXJc6eHfJ04MixpC+4Y2fWJMwPjF/XkvpEuo6DDtRhuz7pZsqu9z8k
 mAjwFY5dHMR9OPeVx6dphqfVw7GxRh4=
X-Proofpoint-GUID: _-o4fRoexMMN1mfrieaS9W4QpVXr2bCM
X-Proofpoint-ORIG-GUID: _-o4fRoexMMN1mfrieaS9W4QpVXr2bCM
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa78489 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bzVQIcQu6vZenJM0qbsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA3MyBTYWx0ZWRfX2mYZuuvPOTuX
 vi30xDhwBnDJKN6ABfWVIfZWp4ukiwrLT9UFPz3GVPPUg0C98i+rw/qQ728fpOgX9jJvW9X2YU/
 82auMP/B6hR2cRUrpjGm65vsEBDi0HdPiqd/xARGeEdpuPnJk2CQJbIMcIGTrK0Vk+zI15xcvbO
 aAPQfjPjXWasim2+lSao7VRLCKjeFQoLKntiUtxiLCNTNGk5m0CpdsTLJ7pjXkKVZaxmsTHvjSe
 MQkF0PMuCeWDOOooZcIDPzoXshwcUydKBrt83CVDCfNZk82sx5E+dssW2LHk1V0gz+inYik+S97
 OYYwIVSc1jmLhUHWW28i6bAbUecmD8hjUXJBgaPwwLXr0Ym7IzNjfZGMdo/fZNB/M5w3bhGboT3
 FvH14TGnWHrZkxAwjIUA1bBExkS1RK5paUFXnP+arohcqK/UzaeQuKu6YsYwGT394NIX1Bn9uD1
 fgFzU+QoT8ekNBywK6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/10/26 11:15 AM, Alex Bennée wrote:
> The caching logic was a remnant of an older time when we had multiple
> shared layers building that went into the final image. It was arguable
> that it worked back then but it is definitely not needed now so into
> the bin it goes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/docker.py | 148 ++++++++++++++---------------------------
>   1 file changed, 49 insertions(+), 99 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

