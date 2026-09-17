Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B36C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Fml-0005gz-AI; Thu, 17 Sep 2026 13:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7FmY-0005Uu-Dk
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:20:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7FmV-00058v-IN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:20:22 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH5QrY1600908
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kD9XzJCs5eIQe2HUAqyjtGJkP14KbvsYJpSIvMT7saQ=; b=NcGd0M3zop1sLhIb
 b3yCF+8ssqztHfFNw0d+/VOrfcji8IM/hI8FHkGGgz/YNvc5BGegPt/Gi/Vj0qmZ
 5AUeOX0+zC/vIpcVe1zKW1d+wLfs8hFA1kxJgUeV22YyLSBYal1/yU/EwwzNHmd8
 t2aC9EPsvNCRKun/BdWE3mqZmuYjno0057ic/eUu+ExgAgQWSiGasbb7Ny+7kuIL
 n7dF7KHnD9NIWQ39+IOje16mZUWEZMbk5Q12ACTbvBodjUvJcf1yn+HW1V/HS1ES
 ymaBpc8AnD7iipoKaguPgnVHdjlxxIDDV/Y50hFj77C3enAiSjRqfB76YZW159OO
 5Vxqrg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw3eqm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:20:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso1524501a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789665616; x=1790270416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kD9XzJCs5eIQe2HUAqyjtGJkP14KbvsYJpSIvMT7saQ=;
 b=b4VgnNb9oKm2YGku1FltW1XAtp5I6rOAJ+j4wecTJEjvh+ELaBOHJ+4GZ2ucMXA6+G
 q9m5zyZzCPxk0oy6nK1T+koPZZE2/r63pHMJnwBMobMdPAgXmS1h16cHnrhSA/+e1my9
 YjUEaFQvloueAkg2RmTcAFRHref8ERUMP8EgY6UPoWMiR1qm2rDq3W7i3/6CkSZPAnTK
 Kn2dhCzWGEej92mK8dfC3cOkxVyqlD/8teRBQAQS7QJWXVco/sY1vLnRP3V0KVUpCh9a
 haOuaKhn0tJ8UgbYNzeQ8fJHqgt512L1kz6+8Y3YXGDdFlLVhtUUiLYdwN9AoP1Tq4xO
 SmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665616; x=1790270416;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kD9XzJCs5eIQe2HUAqyjtGJkP14KbvsYJpSIvMT7saQ=;
 b=cC6QqrNUUPYlr/7kHTeJf4qYceI5KxjMf8z7jIWd6s6hjOGdrTyG8ntUilrXB3fIg9
 0dahBdAUujrUl7upBCrdSjWDIbK55VxJi0u0E8YnO4J8H7g2BzwlTtkKOxggFuLubak2
 ET11Fwimwr3PgWWzgkxXkwfPgNXyYOAtJYWnIZT05Y/enUwLSYQjKcGJcHiQk12XaLVW
 QAQNz9TQR5ALnVmjaWyUvBo/Q6ovL22x+2s8tS0BsmQz3gP0fE9rQYFXuv7TTpor758J
 aO8a3bNQWVzRyIES5/rQnjKJFkTqOSVfh9CQ/Lb7AL/wTpCidXFODBbYUarBso/fn8Hg
 rHKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8Dh6QTDDMXf/UbH376H4VgeefgblZd8TkBYdTPGu1njeuXj6awRqj9hQD/jFgtQmHxDHCaUB3JTqJ@nongnu.org
X-Gm-Message-State: AFuF++n/KCY5u/gnZpED889snyt8wxhWxMu29cIyOC3jTFAG+6x5Ox2e
 DdBkmm4fCiK81FT9uU6gNLhK6C1vhKThGaHpvYovujfAit0cq7dB92eXS5UTMKG0b02SR+ULZQI
 2Ttd9rAkvrRLCEEd1stqcud7iSdvN4NU/QaBgLA0Md7F9tCe7FjZJMZGZaw==
X-Gm-Gg: AYBFou1G1zBp6zLv5CjT7xOCrSR+dHX1d/tYzh2ad2OgxXkMN9tlMHP7bkbXYGGBkQc
 CGtCQDklPFmTCqte/yV+TPknD09hc1oLub9aSlLRnAGs2jRe5DQMxc0q15WokwlivUhupBU3JPB
 ED8fNAWKxAJzphPXzBNynukZczbHxIDiCMx5YQw5jSFU69zODm/S33WRVpGblA3Uwckfdnhg1vb
 ojj5p/KhrgY6fq2md2SYDFOg7APKBak9QFRT2PAYnWs0meRdrF35aaeO2MPozAYT2XTqZaUgVeY
 RRNPCTSMAXuaWVYNxdowJYSUOAPxkx3qiivtVI152E0jj/j1NekCFX9aAkwPt6kbwdgfq3p41W0
 x2S1VqHSFRw9KwAJYftguRQ0mKhQ8ThON3s5+gw4Wyla2HFutkFbnENOoCeC/tLtY2JlQ
X-Received: by 2002:a05:6a21:7107:b0:3d3:adad:f177 with SMTP id
 adf61e73a8af0-3dd5f7a8a9fmr18361685637.25.1789665615986; 
 Thu, 17 Sep 2026 10:20:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:7107:b0:3d3:adad:f177 with SMTP id
 adf61e73a8af0-3dd5f7a8a9fmr18361601637.25.1789665615401; 
 Thu, 17 Sep 2026 10:20:15 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5e40494sm16705707eec.15.2026.09.17.10.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 10:20:14 -0700 (PDT)
Message-ID: <c0c5cf55-b4ff-495b-babd-3a75fd991127@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:20:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/17] testing: various docker clean-ups post meson tcg
 conversion (pre-PR)
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FHwbIIZplmV06gxgtyRTDZPA1DF4Gh47
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0NyBTYWx0ZWRfX+1OCBJAAz7V/
 Vxif/Tb9XBNligkvMBKMowShHpTk1+zHIzzMP66rm4/ofLRn9AQ7p5Dhx6590sMiloXaMfIIrJ2
 lBbJuZaXdgoLNAAHTiTWb0z53TTqLBDDqM5vzu9VC3TUIincCOlZQpStPiqTQKJJPV6+eeVL9Ek
 Pl+vqnlNAkuhyNtBMb+5gxpIlAg4XUII3ET+/dh5z4BEoHNYp6QsJTb8XB3eP5JPZAc/l14+YrM
 h4478znHmVV1JBYt+uxPmREEMbx8+djPh4ciXJtxwARShe9zgrLmXVBBULaJmVvsbsmXJlHYzUf
 X59bJMHhuAWn1bkY1Bf9WMU4KhIGJBe9V+mCNcusXrHO4/DP8yPEC+8X58G66+tR0A3Jswl2nlE
 6XwBPCAbh4CAHs9YphbLVKw7pzjvuOfXM9lCdK9Ot19SS/e+ZEsjf7b2JeT72e/WNXC/JuCNGvr
 /EczU/R1RutrFJ48n+A==
X-Proofpoint-GUID: FHwbIIZplmV06gxgtyRTDZPA1DF4Gh47
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0NyBTYWx0ZWRfX5eM9S3R87Q7I
 qewH7eEx35+o9jt2dCj1d8JHRnJYBBZs5oCbvZvNISnHM0UlBfi7p52dg8p9HJ9vyJuH/BFDYNt
 BE/o4kidYSgLE78sKGEQSPrYSSoVjq0=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aac2150 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=aiox24Fdyf-heaFxs2oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170247
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

On 9/17/2026 9:55 AM, Alex Bennée wrote:
> This cleans up a few bits and pieces although doesn't totally solve
> the issue of an apparent stall while meson builds the docker image.
> However with these changes there should be no difference between the
> meson build and the equivalent "make docker-image-foo" invocation.
> 
> We also finally get rid of the ill-advised magic caching support in
> docker.py.
> 
> v5
>  - fixup a bunch of rebase damage
>  - swap out my ccache fix for Anders
>  - rename revert to "configure: ensure it also honours container configuration"
>  - use Pierricks solution for avoid too many SKIPs while validating config
>

It seems that this version removes patch:
Revert "tests/tcg/meson.build: implement ./configure -cross-cc-* options"

That's fine and correct, but we're missing two things:
- cross-cc-cflags and prefix should be passed to config.mak also
(similar to the merge for container options). Not strictly needed as I'm
not sure anyone needs this "extra" flexibility for roms/vdso, but needed
if we want to make sure we don't break anything for anyone.
- scripts/meson_buildoptions.sh update that was missing originally for
those meson options.

For the rest, it looks good and ready!

Regards,
Pierrick

