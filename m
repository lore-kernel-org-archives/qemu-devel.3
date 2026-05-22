Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95149CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 17:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQU38-0005eY-Am; Fri, 22 May 2026 13:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU34-0005cv-Ta
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:52:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU32-0000n3-Tb
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:52:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGu3Js3947445
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qP3cPfK7GG4wPljJehkbiTGwbPVPrrwt9kMc2W+LucE=; b=UFjLHiNaz0Fucy2Y
 g8FsxBT+H/Rw8YAADN9+sZ0LqT8/kfQT4pUk5nYRbfMbhK86HYdSzo/m5plMGoV/
 lpNVFx80UKNshUmt2YPt7a62oZ4QCc4mQItD/ZoMrnrUChk1pWXEfYy+wwkxsBDM
 rKnKIbz72Br5iHBGK3TplXYd3R8gVnTc0KX9YPoCIMYZqZ7WATWBVpL4AhZRQuI5
 MRRRM9F6Q+dPAaBFjwOpohxeH+uTgpBASthm2h9JCvu3uyL97mujxy3UIc5xi0jB
 R+BjMHSx72rFyY7hJg3Avy1AK4j6uRzWy6gCCgk/o/9TpdN6AZqUAaGYvcOts7MC
 /FxwdQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean2nhukm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:52:35 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13537722193so7766808c88.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779472355; x=1780077155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qP3cPfK7GG4wPljJehkbiTGwbPVPrrwt9kMc2W+LucE=;
 b=elXsYd93vEl/aYbYqrqITBwU8N30u2nLpkUHRBWvDDTal/J22wP6Ak4gH9wSTfCXIq
 TPRwG6RLl35crJ6Qv5AA5UqrMKfvDru7H7W7FU6jN1bDpWpy54l42JwHaRYLPPC+4Jw4
 9cPPLkReCgpU4ScMoGdI+e/Ic6RuveG/3bDGXObhg7NZy1JzjEiQ+WxB5TD2aM1Zl0Zq
 jgyD4yFXpyWLpOxWfk9QBQFqmoTsJnicyEjE598X5v/vFMMnm5WqsXv4tzmQo8WIEOdP
 uBcn4BFtc/ED322HKAe9g1aXH6+20w/c02BUE0SO/X2oVP26BMUCFm9E6Z/7vbGkLdej
 5dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779472355; x=1780077155;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qP3cPfK7GG4wPljJehkbiTGwbPVPrrwt9kMc2W+LucE=;
 b=A+uC84XReT0lfxda65j+V4UqzTIOyhTdUzxecGkxl1ksf9pI8ogwxiZTAzu+IijqXG
 kmMf9Z4bUOiV+e6hDrMAxkU2cPI1nUWjGUmraVr/zqsRgnTkzw2culTU8wlj+H3CDLTP
 EtujYsbQGd9xfdYffxZJiLQUoZyhlEXAU5MZJCQeluEqbZ/IMTcTYCxpBppGgBk7ItpR
 Z7Udude54JTg1KiBsDjmbII3IXwjM8mgiLc9ugmIBzWZ/zcu8wPKFUdKwhQJNk2vGYys
 C8clSHK7HzoPmcgDjZlZGNVOHMAOhjjmZ0O7A+UVTwl4UGBF+6NOz0bzVDzRykVEVgPB
 twqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QDf189mT3STElpesRFzZE6Ug0JVzlAyNF0wQwRdvHaI3yk+tD1uBiVCeibgX5cDCMDsi/bK8JYKB1@nongnu.org
X-Gm-Message-State: AOJu0Yx1jpB/8z0CUHp5Yk5Ev/Pq3JeCgrULFuPqBVJAjDWKO5jTE1x5
 fvNDe+HAqwCnDvEYZccfXBj0ZWfu1c8P6+ExHzzrCcNhvpUOuAMi7zGzhFRntGrOoZ5A/K1MV+k
 lFWD7F2X3aStw53DH6KXS9F/T/D8yyw/EjnB+w/hOYj7obpYgYeO4NnJw5g==
X-Gm-Gg: Acq92OGXCSx5d+ETtpXWs0Wciq5zHsBDrggMSZkzTlxwfRQvr17eFq30UxrmjQKC+bp
 7Yh+L74nbtMPuW6BV2S/frNhIgzpD3Kje2yuzCjBnTLvW/M1B2H+Nxn2MuiH3enL90iPzsqoXCK
 NF633okeIumbwVuA1PIMnbT8P7uKEFZreKbZor1+ZuliCP8IlsWfBB5tnINZCAkbvgACdYq8mnt
 06VlTzF6ZAvqwTqWk1eOlLaMFgDGmS07pTtP7u/JUBGYM5lIzHUiI93PyJ5zWJzbZsrU52jpIYO
 vkkIQGqrJr82anWTiYKdYv8bjNZq4Dh8fgHvELmLwQIJGvP+TGgOYb9hqWc5H/qwDZyZ8O8wbto
 F6BRKe/sIeb+z6Rn77SDlcHyPSzp/eTNS4LIw/lWsrizvnehM/yqi4XWAJar4LnCEYL/X47Py4g
 B2ddC5sQpNH/Gz3Q==
X-Received: by 2002:a05:7022:985:b0:12d:cbce:5fb7 with SMTP id
 a92af1059eb24-1365f8117c4mr1730764c88.6.1779472354572; 
 Fri, 22 May 2026 10:52:34 -0700 (PDT)
X-Received: by 2002:a05:7022:985:b0:12d:cbce:5fb7 with SMTP id
 a92af1059eb24-1365f8117c4mr1730754c88.6.1779472354009; 
 Fri, 22 May 2026 10:52:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366aa9a8b2sm1729341c88.12.2026.05.22.10.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 10:52:33 -0700 (PDT)
Message-ID: <c5ee7422-0f55-49d8-9ceb-10f70246e92c@oss.qualcomm.com>
Date: Fri, 22 May 2026 10:52:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] gitlab: add initial MacOS 15 on gitlab runner
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-7-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521131739.540157-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XvDK/1F9 c=1 sm=1 tr=0 ts=6a1097e3 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kGB7cVtOLoMqFlL1_a0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mgKgHrmINZepUarHjFMAXD807D_Ezj5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3OCBTYWx0ZWRfX0kr/aXp/lgAY
 /6GZKhMxaA3lx+uwlCPpOdc7VnRMRLkDUIDZtl5lpXl9ZYnVkqwpVFH6uz1G3AYqffqhFvdOwxT
 WCHh9bjsDnz2BGvUrhhFGodmcEhC8JEfQHLAPnzdKTRiWMy7zydf6mxXqDr2TmleZ+glnVJy6RN
 33r4IuyIXxTgd0abUe70pLzNbIw+RqLZUADfQ38/x9Vxbsp5Zj8CFoE+rssfJFTZX99S2kq3/aX
 smyDB6VoQqwAzbEWLYaIDw7teX1GilMiITFqOW3V4zZ9z7cKRYdOr5rHPIUpkkPEx412z3HmOo+
 6NH5GO18aRzQQTpXvg9+jg1qdSZVRXquhchTcwQif0bt2ZQQzYqZ2wSB995ptwq86pT+DFMjsMe
 rJbK4aSrc0jShyqvvxBIpUa5yo+rUvbz47AS3q8A9T06wQDt+JrGt7MpLMiIEBqWYM0pUKN7XxC
 62VlDXeP4Ypins/Z4WQ==
X-Proofpoint-ORIG-GUID: mgKgHrmINZepUarHjFMAXD807D_Ezj5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220178
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

On 5/21/2026 6:17 AM, Alex Bennée wrote:
> The gitlab runners are currently in beta but available to projects on
> the Premium and Ultimate plans (which QEMU is via the Open Source
> program).
> 
> We install some compilers via brew so we can run some of the check-tcg
> softmmu test cases.
> 
> We disable rust as the version is too old.
> 
> We disable plugins because we haven't taught the test harness about
> .dynlib vs .so yet.
> 
> There is a discrepancy between the vars and version of MacOS because
> lcitool needs teaching about other versions (although I don't think it
> matters as brew is shared across versions).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - call tcg run directly to work around makefile issues
>   - drop debug lines
> ---
>  tests/lcitool/refresh         | 11 ++++++++
>  .gitlab-ci.d/macos-14.vars    | 16 ++++++++++++
>  .gitlab-ci.d/macos.yml        | 47 +++++++++++++++++++++++++++++++++++
>  .gitlab-ci.d/qemu-project.yml |  1 +
>  4 files changed, 75 insertions(+)
>  create mode 100644 .gitlab-ci.d/macos-14.vars
>  create mode 100644 .gitlab-ci.d/macos.yml
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

