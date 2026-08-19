Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBEEC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wweNx-0003h8-Ee; Wed, 19 Aug 2026 07:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wweNw-0003gs-BV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:23:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wweNu-00050B-OV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:23:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JA8Ape3984399
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hiG5pSOqwGpKMGcLMG5A9H1hdTZB6As9VUuEvUEVxQo=; b=jrcHorRqX4LiLVP8
 g7T+AYt0pScWHMkTZipkXlV14xTQhpqLv166c15xfjDEnFaQs1oFYGebu0V6EQwY
 xk3sk0I96aotK/OT+qgJzfeiqADNBPoFXCztozPLSOUf5KN8I1Ot2VkGiyQXNwLP
 aiqScJ8WVsQaLR6Oy114aggBLL3gVuA9IJcEmv16duSvSgFWlAKszCEVYB38+F15
 TLUxZkPeCwuc/35M2LP1+tGhx9ANj0eSzIdqlGgpNqK9gn1YWtGSzdQUodMtzycR
 VfWcD+hK4mZuYP0ZLyQKU3EEmV3jkKXDXFG3Y3Z7agnE1Ge8ghwy5bQp9GG9nB88
 9G5Jmg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfjk0uu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:23:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e62e3459fso102643185a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787138584; x=1787743384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hiG5pSOqwGpKMGcLMG5A9H1hdTZB6As9VUuEvUEVxQo=;
 b=G2InUBjLbwUnDYVbkRg7VBXiU60HplLXyeR1vbZKAB4qd+v9dLHVll/LmrQyTn1mnj
 kVIWE6Q2JeG4xl10c99funEHNDIFvRVz+KyrgUJfX1Gzg8kxtHJEBOIOThi2kQG+Be1k
 VOQ57+2JpEgTtLtFfbUgG2av6kD/IbHMnaBaSRPZD+X5ET2qf5txzITRuqnfqdtR/AUs
 iXO0AIcZmqyvsA9Dnyd7hRiiXdDB4U1m93cRSR1eb0Xx7buR75QydTT0yZy2GIjyiExb
 Ijt2LY/SNUSKFuXsyJ/NIyYp7d6YkVswVOndhznGSlLRrkHUJZGWtXmYSCOGPOciBbOe
 1fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787138584; x=1787743384;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hiG5pSOqwGpKMGcLMG5A9H1hdTZB6As9VUuEvUEVxQo=;
 b=irbI3ATu5voh38K5O+klvp+vT1Ii649iVbUkynESVLIroJ1hjzjieqAW4hxoiXsOi1
 nSwtpf8pw9QZGsT9rGGGLUPjNONDIlasIieGPMn24sjaHJNA43QIi1om20wqsRKsl67q
 wyc0mQ0ctZ5tHV0r19SINvxrRzmAsMH+r8zF77lknPtU6JRrLH1aQNemHXy/3sDPdxwu
 nnBQyUFvBMRmX8a5XNYnhqmw1g/QYNlRN8uZj7r5z/qvd4XLUKh/QKT2UiwFknsmQ//0
 fd1hHA+ayRI4DuJNsS0H3dynwTHmVsehxsH/rIvq54qYY5jJUaqYXSY9g91Z495Jm7UF
 CANg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJu1SiLbCwQP4J9mv941XyNlUvuzlQnow3Ff6plr6mss/F98pdmIgM8e7ABu8hx6DmbXREAZQudIZi@nongnu.org
X-Gm-Message-State: AOJu0YzpgBCVwkjR2pDNMUJd00MxGwCHmPbAaHYS25Os3cSmMkL+Av0k
 8sMLqeqVLjAL1MQwJz4TVy1Ey6BTXJfBtBiowh+BgIxDhxx8uSJ79im1yHJ1uigMtYx9DCUJUxl
 XiVlRDksgKpPwI+unUepny+nFz+wcZFA4EkxkGnMEPeYzWqPAe6Tx0CeRUw==
X-Gm-Gg: AR+sD136/0MCAJbFDPVSerb0j+8iYYxIIVRAqgeqVD7MGcia8ny54jw0staRyLz/q5n
 JaWjU3J36+nQQLoWnJiLcBA4tG2SBaLe20IcR8Dj1H1dk0dTMGoEgUDytu0FAGj2o0cxrv4xxJl
 jofqWTrxl7SKVJ/6a0RiA6o/2dkJBx8Fi1VgrlaC4BSoIUblz9zGqViiPoNI5hwJGM/EcVYUMur
 m0cv7I/nwsidQdCQO/z9yp9btSHWT0/26hj9MZFrKj5QeWPku7joi+IjP26/sdnu9l1q0Ts9uBR
 ApUslKALZFoGfVnVaWhvnGY9DPxfLxjWR+6LoW5ohgfUs86CKRkqybVtJSIGy4Ez2hxDXqPYFHL
 AjU2uKEGyStiL3Lzhr3mab09X3WxKYqnxhRI=
X-Received: by 2002:a05:620a:4143:b0:936:e723:27a8 with SMTP id
 af79cd13be357-9371e2d3809mr310438485a.23.1787138583727; 
 Wed, 19 Aug 2026 04:23:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4143:b0:936:e723:27a8 with SMTP id
 af79cd13be357-9371e2d3809mr310433885a.23.1787138583297; 
 Wed, 19 Aug 2026 04:23:03 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14415ecsm4994832f8f.7.2026.08.19.04.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 04:23:02 -0700 (PDT)
Message-ID: <5e603ff8-b885-4f86-922d-6e2ee93fdef2@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 13:23:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 000/104] tests/tcg: run tests with meson
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4OCBTYWx0ZWRfX1h3z3zkD61eY
 48fPYCutKRBDTd6Rc8sEEwgHrrZLBONtXcqglN9PZCeSkKvR0D7/N99FWnD4Jq4ntzBFpoYl7oV
 d2Oi1dz3e8cCONIxbdLkdw8oD0rOqWWRBxI7d/UAVfAB3AW4MSE6GNTc5riyfuvzIIf2esNiov5
 m869RuoxbKpCfItB+ulvjwlelWpHDM3sTTE988iGzpQxpE25HUpBP8dXUhvB0bk4uzNPaSy5/oe
 4MWa3pXbGQetPwuCvjWU1SQsNpSX0HDwTGtqBOkCMxt+uhj6ZzQxiNReTw3rcGrKvZEiYTpwA70
 E4o/vesHZr2rR2l45gjxEZWeEktmhleyny4R2UOutj2BgUDaz8WAnzq6xYJ4fi/hEGh9Z287uQy
 Oo33fUli2dkryg4KY63nFNGV4rpIp8pQHDvfeB+mpZ7q1REB6aLpYmYbqWFeQZypOhRsUzRmLpD
 8f6yzInxUeyTGws5DEA==
X-Proofpoint-GUID: upWypi1Mp62SHAk88ZKMNkui7XZbv0dq
X-Proofpoint-ORIG-GUID: upWypi1Mp62SHAk88ZKMNkui7XZbv0dq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4OCBTYWx0ZWRfX2OzZ2DKLFjKT
 eMIH007KZtg2dm46GxUL/H6s4XrG+sJJ9zVlsMgWZcLp5xSfFVGVSBQenCkNTaNqwKRAIq+0Nkk
 riHNuLeDMzYr5mXYdqUTep+OCKk2Luc=
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a859218 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=rP-5iQ1yHDb8f-SXJOgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 18/8/26 21:21, Pierrick Bouvier wrote:
> This series replaces TCG tests makefiles with meson, with the
> goal of having something more readable and maintainable in the long term.
> Also it closes the gap that tcg tests had with the rest of tests, by integrating


>   configure                                     | 530 +---------
>   docs/devel/build-system.rst                   |   4 +-
>   docs/devel/testing/main.rst                   |  35 +-
>   meson.build                                   |  21 +-
>   meson_options.txt                             |  95 +-
>   plugins/api.c                                 |   2 +
>   pythondeps.toml                               |   2 +-
...>   tests/tcg/Makefile.target                     | 281 -----
>   tests/tcg/test_cc.c                           |   9 +
>   159 files changed, 30852 insertions(+), 3924 deletions(-)
This is a massive rewrite of TCG test harness. Markus noted on current
/master there are no maintainer:

$ ./scripts/get_maintainer.pl -f tests/tcg/
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> 
(commit_signer:62/99=63%, gitlab:@pierrick.bouvier)
Richard Henderson <richard.henderson@linaro.org> 
(commit_signer:34/99=34%, gitlab:@rth7680)

Still before this rewrite you are the first one listed.
Just saying, you are a good candidate ;)

