Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64804C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7JWB-0006Mc-Vr; Thu, 17 Sep 2026 17:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7JWA-0006MI-T1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:19:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7JW9-0003zV-E2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:19:42 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLGEeF3431986
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 41CBtQm8RyISMbf2T/VaepmCCF8nUxKNUD3OgsCTH4Q=; b=YAu/d6I1oj9O6JZu
 EYQeqZU+Nwn+iT9S2E/vswBtSuut9h2Uf6oZ3zrqKIHXlDueuh0G55Cl4fllDj/3
 8LB3zFFvxDTja5iehZF3d+7mZHpDSpN6utLyHHuX9VKx6Oqaby7v7gUJIvE+KLNo
 7nipT7xs4Jgqkx9oscqcgW6GjpM/fW+kWyWZe7ceEruQZfoB4kLAFMuGYHSrgNYZ
 ei91dXcj2fh1CiU4xnFnSqjOTQNh3y+7jrr4CCPbvvQoELuAMypLj5slRcrK8WAO
 OUFnTmV88FExLD95QNYqWOTGqBTG/OTcuBIUt1lhEAByNAw7ckCrK++n/FdTZRwL
 kmQ59Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grhs6hxfp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:19:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1bbd7d6e6so1196929a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789679977; x=1790284777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=41CBtQm8RyISMbf2T/VaepmCCF8nUxKNUD3OgsCTH4Q=;
 b=WO42t64B7WtTW/U5j/UTnxeOiFMp92RxsMejxqwLWXQzbcteHjpAHuzypgwnymBaKp
 2lDZUZBip480NYpoF8PhS8PJVPkp62WRDHoMfvfx5k9Plabgt3MP9NHNxJiKPwKkLr08
 9LE6kf3116ARBsEur5ROxaCGbXzA9fjaT8VXekm4eeJiHFK1KjCrEHujTVlPYNYW+FiA
 lYIKPLSH9X1wL04AAY+Cy20VZIsMegl2lOBT+oG93IwROe3rua3ugiVXOIE14aDBzPjJ
 HNGUn41xPipa48E/ZAl3uEuHbR0/K5IY3izauD7cG8OYIvQfMBCacTw3wp8TsZMut5NT
 lSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789679977; x=1790284777;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=41CBtQm8RyISMbf2T/VaepmCCF8nUxKNUD3OgsCTH4Q=;
 b=tLofkvloFhNN1yJGTRuZqDTDgZgqNuD/YXe1GkOT+OzG6Eg7yvqwTD0cdjzUYun5Dm
 RwyPwyPMAwFwbb9C2SJyLvpnOWRCLVThlvVKj3+Zwq5LnbZ4qGVp9vLP2iZCwiAnczlD
 rA+UkRlBP2hLrraQpYVeX+d9A8ikOYvkSuj5SW1jmZA3D4Vba3SSEBfO9SCD4BWTHPG2
 tV6MWi4TlzRLRKYRkhn8pBvTTHpFGrKztjYpF7jkajtnnC5w0f8fKzk+q13ZTuzgTqc9
 43cYwFim6GxjZ8wr1vMsitNWAoGZ77XcLGKiNOk1/7Nd5Md6KYjvZdZMMxd0w1Y5lbEr
 SmDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx734soOHIwg4mXJ1lJI79s2g0E1uhLKeYCFalTSVFWfBaDA52ykJIr5VxULj7Qxq1rz8iKyxsLytda@nongnu.org
X-Gm-Message-State: AFuF++mE8hOF+4Td4LzLhxKszJML9DLmGEOVd/dCIr83T9Nwi/iM5V4G
 +Rwl6jAfar/rtLoA4JhnOHZlkJ2oKxh3MEAS/3j9p2Q0wdyb5fyc3zahbVnzA5ZXFxOf0rqMh+L
 0Q8GKGOPHVqIfQ7mqNWAJDeIdkaYlW0roZ0N1aaST5MK78f1x9pG5Cmi+Hw==
X-Gm-Gg: AYBFou1rg7I1PRO6PSJlaKSL0hZmtBu78+GSHTkdFIuHbOM//6468q5ZCFe7PfUP73o
 o8jsH7yFO7CyfPqd9laGUshHeOznB+Dh7/mLY0+8SBMGD+uvJkp2+dqsMnatlUggu8QxJkzNAW9
 ZVUSOOrxd8lhyD4Y6Rgqx7Jf9JU7PzdwWJRGk2m6CFqdrF0E1qBaGVIW7U9KDdHuonn3UwsJk3v
 GoKmJKSdf3TXLrUAiODDr/3u8p+TN50NLOWIO/HjCuzWa5ari1MkBtsPLigKxo9urh3GWy2nmin
 +FSyI7biPH8fI5+ixWy50vASyKNN864L0Fi8ighCRQJR05UeMRECfpZcNGKM2QljiecWqcCtEmJ
 0alDc49ZB2t5C78lsEJ1Wh0khtiLu916AxvJUpYmg1Mb/aeeOwMORhPgDtxoNXkQJMIIq
X-Received: by 2002:a17:902:d4cb:b0:2d8:d4ce:9f37 with SMTP id
 d9443c01a7336-2ddb1b99598mr8417435ad.21.1789679977342; 
 Thu, 17 Sep 2026 14:19:37 -0700 (PDT)
X-Received: by 2002:a17:902:d4cb:b0:2d8:d4ce:9f37 with SMTP id
 d9443c01a7336-2ddb1b99598mr8417155ad.21.1789679976899; 
 Thu, 17 Sep 2026 14:19:36 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ac47cfsm16221795eec.17.2026.09.17.14.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 14:19:35 -0700 (PDT)
Message-ID: <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 14:19:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Matthew Rosato
 <mjrosato@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Kyle Evans <kevans@freebsd.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260917165602.3405537-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMwNSBTYWx0ZWRfX9ApOg9Lg905Z
 3wIKIetg3g9p/mLxfxetEVV+mwA2Yu1EatQbzpxTIIctgW+LqpSmiWqpaaWYeorRNa+7NhOK/W2
 cqrD+Ty4lXEWklT5gZwZ9xkPdDpTv1FMIh6QaVVpFzDN9rTZDE4PkwWxgf9bsmYDpEYwr76jcbW
 7wJhMlQIx9IhLXdjQ40SYQHuCTx/dEp+OLhrUNXr7+DGVYDl1KUadpi+XPzas5Fk9FvZi8YzxKd
 DksmEfzwhuybYwOU0KEPZrH8j8KX77Doz/t9RsaAK5TT0taBzTnJmwIG5HDj4TAXoDuzuGtt+5J
 qTHv+1pSeSidGFrsuMp/2qgLrDwj0dfh/B5zAGMyEQtpbj7n69PNYfev3Se09Xlfelob0lBi059
 CXkP/5U4WVxKXzKSbjtvEdGCOXyrzdgjnttBYqXgryToyHBJjrpd3tTW1XOkiQoBxfqPc6GbMKB
 75uhXz2L06U9VunEsTw==
X-Proofpoint-GUID: jPq3_RjgZz34KtsnntspObCxCl3bzRhq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMwNSBTYWx0ZWRfX6SoVsQ5I+qbH
 YVITDz2508ug/xcY9vfniPJnjl+nsIN47bqlj/uQ99OXpUvLN8TSyf4n2JWW7z/RrWeoxYZlDwP
 4T5dWnzc6EwYmG5ehXyxQCEWa0gcVWA=
X-Proofpoint-ORIG-GUID: jPq3_RjgZz34KtsnntspObCxCl3bzRhq
X-Authority-Analysis: v=2.4 cv=cvwOAF4i c=1 sm=1 tr=0 ts=6aac596a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=uYbDg6Ze2NDCcb9HcAEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170305
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

On 9/17/2026 9:55 AM, Alex Bennée wrote:
> The caching logic was a remnant of an older time when we had multiple
> shared layers building that went into the final image. It was arguable
> that it worked back then but it is definitely not needed now so into
> the bin it goes.
> 
> Tested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py | 148 ++++++++++++++---------------------------
>  1 file changed, 49 insertions(+), 99 deletions(-)
>

After testing this series, it's not a good idea to include this patch.

It forces a systematic rebuild, even when image is already. This has
three consequences:
- verbosity: we see build log systematically
- slower: running a noop rebuild takes time
- network dependency: docker.py --registry triggers a pull, which fails
if there is no network. It breaks offline make check.
Also, it slows down things too.

So, let's drop this patch and keep the caching mechanism for now, it's
still useful/needed.

Regards,
Pierrick

