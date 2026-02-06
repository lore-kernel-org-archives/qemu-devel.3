Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AB2EE6B6A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 23:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUsj-0003aA-TU; Fri, 06 Feb 2026 18:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voUsg-0003YA-Tj
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 18:04:55 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voUqL-0005s8-KR
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 18:02:43 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 616F0W9I2482148
 for <qemu-devel@nongnu.org>; Fri, 6 Feb 2026 22:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YAvJcMHQ2L+DNxAiPmVIVkLiuPxQmNdS8apde3ewrS8=; b=ZJUmIrl8FQ0aAmmw
 DZPBwAtVzOnqQf5IzLKRtBzXITJm8OUc8geZjrteLIHLhOGW5PO3l9OJE1YASXQs
 TEa1PbZ/FeF8W9s9aaxxLLE4W7wJ+M04uzNsE3vivy86ltiTahhrGOHrpImPEML9
 6Z8d/ES+/UgxsmDhpy6xnG37ChO0J+olZZf0X5cC3xxaPOyPaIZoV8HbfmhR8rML
 ExwUGK6w9mBQUqPEz+ozMva0YMm5zsX0VXW+mOC5t3omlfrQJhYhZmCFbqP9+8o/
 zGH18mbNZSHX6koKTXG50zu+1QAevp+Y+yLeQZhZq8tyH0A1WPrP3U+UIeZknnpk
 QW9C8Q==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c172rhp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 22:58:06 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-794ef1c2509so78821377b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:58:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770418685; cv=none;
 d=google.com; s=arc-20240605;
 b=L++RDTWIGw/A9K/kzVuFafpkpSeBnBcHryBkzYa37ea3evQ7rRSjbzAtZlfgRL707L
 +Vgh7mtz4eMjkHDRBOq/ozqlKY4u5KZ6Jsvack1XCloIboTINjGCvyNc0wMepNBILr9P
 akPMcINoOhvGNbWvVR29OK3HRGGtI+Bq/aRORCrdp02Kpdozx5nqfjw1biXC/lrfv3DV
 xiYlB3jIn0l9Bsj7OW6E1kz9z9ChL0xe+8Tb8eJ1M4xDYp5OQgFN6sky3GS2DAUMfiZr
 gPPZR8X3QTqMfmn/kKsjFDNKo8ZBQ+psvzkPHy/tZEh8c4yzSfb4gTXJ7w+AwHu+eQf8
 7oGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YAvJcMHQ2L+DNxAiPmVIVkLiuPxQmNdS8apde3ewrS8=;
 fh=wMuXnNq2CHhBbNv/cYYL4ILyVbHZTs2JpBmT1BtvJ58=;
 b=IdwPsIF8FI41Dp3VhAu2icpee/ozVnwXvqckOhbCuAJdmxMASSsVCKU94P4v8rpVJO
 ktYHDZ6ma+amj4OXJuxyCiVLL1CVkbeh+UIOJq5TKKE/DckVsWKuJR+bbgEMHl+OjFed
 ZbgEcdVFJyn8EfToAaSKWoJ00QbeuhQPa6GtonZVzcAjIgYqTjxGusegi1LdDxTO+CxF
 hnqU8AuiTyItZ8eaQXpiFBRjHlzT184hNMw+I5e6d03gXhtIxAmgMd3i1hWtg8DHvb+Z
 9kcajsKsLEyGhkDQ11Zb0NypuV3ymug05iDoj3M0OBpiDVRDMN/bPdZKASg+zFOoACz4
 FQZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770418685; x=1771023485; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAvJcMHQ2L+DNxAiPmVIVkLiuPxQmNdS8apde3ewrS8=;
 b=e9k/oyAz2hYA6D6wn0uy9Fb24tfn/2t1y86JtafmQSQbhPxZrkBURq90MXKNfzgf4K
 S8WjV7Qe4X61pwd3NGEr7y4pLWr/Gw0EZ7hVb5J9UWVRSUrj4hBNG7CIjSDMQd/LmQhe
 KRBvFoXYlUDk115cj9ROQPZ7YAHT2MjypfZifXqR9oARgi4X+047q+bPDOh7PqD4jr58
 eTXtjDBENJPZ76FEbuWWGIed3hXwiPzxqFyYaYQYeb9w5J/k6CHE6gtDEVskG+pboaj+
 cK3eCyqVJ2nQgfEL3KKSIADVQ9IzfDHClHigh9/yAJhAIqbCoWvCdSg2YPNnGWESGavv
 TXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770418685; x=1771023485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YAvJcMHQ2L+DNxAiPmVIVkLiuPxQmNdS8apde3ewrS8=;
 b=SvPkMXBvD8f4++wRZCYMhFSpAKmRwptn7ZLWarC9T0QehBBAf03V65WUGzmYg4kdvR
 q2YOeq/TD9Pc9fIX8GoxWl0gxkZWxydZlW/nWgv1p8L7/vyYSkp7/5VDFsG2XEFmJHdr
 2ms9X8vx/p6K/eGUvXsAm6dXpaFx+oz0co3wWDC+CGOsVTYJA03YX8DXOZdVi9+FLJWG
 /vlGm1NdNorex81o2R5yByKg3/UlOEaALso8EuqVG0LxyYg6xyi2nfJfA1TJsdhjF4hr
 I1rwW8y4jT0GmqV6YtQKOQjcp1Ka5rJOP6E7JC0tnAyrY95aUciyezsfJThFZtOkE1Xc
 I38Q==
X-Gm-Message-State: AOJu0YyaERn1VZjZy5mFWTXDY/jiQZscMzR7TcfvgHyyQIEkZyPcn/dG
 mNZAiQBAfsUnvJ0f7IZWEEA63h+a2+3Sorbb8IOYU9Cn7N5GCTMI43bS7ck6IwZCnL58jpD3AUh
 +F9DmFxh/uQRkCwC5hifXZKBKrio5ZxKyPFVBG8sOS4LOz3Q9xFEZIJCpLjrb3DQbAEkuAMbdDD
 x+temuxGhTdk+/z6UnXO7Q+NNPKdDtc1qO
X-Gm-Gg: AZuq6aJ0ixU04/hKaZyVxolHMedMefnF7R+uHGg/1hpElufOf9BK0FM1nLzz8lMOERZ
 lmKj+R9lirsrlfkWDyM31moe0CKLS/57W23eRiy7ew2ycmxmX6frLBt1ZLQyQdW39IhuFnrdnvo
 +rJ4U7sn0zCQvz3iu1zO1b08+yuU4ZT4FrU6bMmF5NWF8q6DJuiX+J5liDjW9MLMy7lJY=
X-Received: by 2002:a05:690e:14c4:b0:649:e9f1:bb9d with SMTP id
 956f58d0204a3-649e9f1bcccmr5927318d50.36.1770418685152; 
 Fri, 06 Feb 2026 14:58:05 -0800 (PST)
X-Received: by 2002:a05:690e:14c4:b0:649:e9f1:bb9d with SMTP id
 956f58d0204a3-649e9f1bcccmr5927313d50.36.1770418684663; Fri, 06 Feb 2026
 14:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
 <ce628255-5c7f-4a06-bc2a-b358aaa4ffc6@linaro.org>
In-Reply-To: <ce628255-5c7f-4a06-bc2a-b358aaa4ffc6@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 6 Feb 2026 16:57:48 -0600
X-Gm-Features: AZwV_QjsjqgKp85wmvcXDAP7W6cpS93w_AOM3HepLy49tsXoDvizkwap6tvWvkQ
Message-ID: <CAEqNhNacL9shLbCamou3G5nUNRsWZLqrf1TXVHHagKzZDKgWqQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Handle some invalid encodings
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com, alex@alexrp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: sDRT0NLdy7mKGkQz_dFLNnF6OL8g_Buc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE3MCBTYWx0ZWRfX733sCAmiD54U
 vXRzMl5XaMq1mE+31Vvyy2Zimkf69szpcdM9AISlTB70ZiIMY2mEROVAPJQENZ4ObjgA5vlT8CP
 hDr7BY52+LfVp2rzTspqsj47thktBsmJh76QEK1ixtq7uCBg/n4TbG7fzlZ+H6ikCi//H+TQKwi
 3n+a2GWIwnaCI9enN72h8ycNOt0fFbhLwdZY/W4zzKX+rF5bDtnRaiEIGzKloR1Sim/3nPqCAXA
 oAfF/97hLdGZi3ww7ZDxAC1bADasFsmq22fNNjWIP1Gy2crLoMf+ctb146xSr1KZcYR0BNKI+Y7
 8sPZ4ayEITFb6LL9BUvtHRPcHvFFQ5nCNSbE5pQSBZ7oKFWFRoUnbHGjrxOpgF5HjtdKWH/9BiF
 LSiVzXwZEwFltd1tRUTHzjD6Hq3mccTcYKBfw3lMg6mZYXuP8T+zWyueDQhgZzacyWXPYw3fS0Z
 einUhMtVtYC/AUnP+6g==
X-Proofpoint-ORIG-GUID: sDRT0NLdy7mKGkQz_dFLNnF6OL8g_Buc
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=698671fe cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8 a=95S5wn_Vhp-iR_8qngEA:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060170
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Feb 6, 2026 at 4:50=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 2/6/26 10:38 AM, Brian Cain wrote:
> > Fix the issues reported by Alex R=C3=B8nne Petersen causing zig test su=
ite
> > failures.  The 0x0 case is a conflicting "multiple register write" - th=
e
> > handler here will cover duplexes but not the more general case of multi=
ple
> > register writes.  I'll include that in a subsequent patchset.
> >
> > Brian Cain (3):
> >    target/hexagon: Fix invalid duplex decoding
> >    target/hexagon: Reject duplex encodings with duplicate dest register=
s
> >    target/hexagon: Return decode failure for invalid non-duplex encodin=
gs
> >
> >   linux-user/hexagon/cpu_loop.c        |  4 ++++
> >   target/hexagon/decode.c              | 28 +++++++++++++++++++++++++--=
-
> >   target/hexagon/translate.c           | 18 ++++++++++++++++--
> >   tests/tcg/hexagon/invalid-duplex.c   | 28 +++++++++++++++++++++++++++=
+
> >   tests/tcg/hexagon/invalid-dups.c     | 23 +++++++++++++++++++++++
> >   tests/tcg/hexagon/invalid-encoding.c | 20 ++++++++++++++++++++
> >   tests/tcg/hexagon/Makefile.target    | 23 ++++++++++++++++++++++-
> >   7 files changed, 138 insertions(+), 6 deletions(-)
> >   create mode 100644 tests/tcg/hexagon/invalid-duplex.c
> >   create mode 100644 tests/tcg/hexagon/invalid-dups.c
> >   create mode 100644 tests/tcg/hexagon/invalid-encoding.c
> >
>
> Sounds good.
>
> I have one suggestion to improve it. For tests, it would be nice to
> catch SIGILL, so test returns 0 if it worked as expected, or exit with 1
> if SIGILL was not sent. It's just a suggestion though :)

Tsk - good call.  And that way I could combine the test cases.  I like
it, will do.

> Regards,
> Pierrick

