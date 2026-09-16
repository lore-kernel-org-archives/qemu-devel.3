Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16AAC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sqC-00083q-8V; Wed, 16 Sep 2026 12:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sq9-00081L-Oo
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:50:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sq7-0001UU-LH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:50:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeEca3107061
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /wJW7Lu2In1QCLq6HZ7y/m5iNKUD6ioqcnGTSR5EqIA=; b=kgr3JZigDyZGf8jk
 Ody7g7EKQbOjW+lKn8EGG0DqQ2peMIak0EQ5u1qoH9WxY8cvtgeuJYTVGsvxvSzs
 H1khNMRMerI9VWeVWXD6zOowXqjHHdPFgTrhk0MaBC9lGBI5Sfrpkt5FJ7Rr4NgE
 eaND1Btt6lIuoyQrDsTNGMhJ8IsMgbgI5gw7Z+2OIlMFpYQs4xyNnm8CToh2K5cE
 TYf8icnM/DoCNOWKswC5T7dpJrG0DEwVhln/8bxbDOABp8RDfCllvKD+6KOxkLBs
 eUXptZ3HCqblqX7cjk1AifWaRvPAF+VErDsjbcjg2I/swTTiF2ubwa0qwy1CLyPo
 RovY0w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquw2s0d8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:50:30 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39b6416441eso11134632a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789577429; x=1790182229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/wJW7Lu2In1QCLq6HZ7y/m5iNKUD6ioqcnGTSR5EqIA=;
 b=Dtk3ZK5Rkx6UEEWZQ0w8CcnSv8xP6LGAMXw5XEOFt88E32FkqUwZWyasOlEL2MZfh0
 NlLfr9caQZso2+nxHbBi7KyDstDKRaSY/6QZkOgDciuls4sx2D0rS1MiQjEzHaYWMBx4
 OvF8AnjVvJ5Gl378uGDDeGmHZb2x7+6LOOZKKPeQcgpnIyCcvtWLShjMZhX6SHjboKO+
 kJSZSxhmcKh+25WijKCPHxvMPoiM7vVsXMp6AciNsloxrfXrqjzuibXx2Fr56PmxuRRK
 1o2a7mQ2RRrM29YT9GF4rAreyWUscAjAPxQ0d4km9UiVJGtPIcWfL5PDreglpyJrDRir
 QL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789577429; x=1790182229;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/wJW7Lu2In1QCLq6HZ7y/m5iNKUD6ioqcnGTSR5EqIA=;
 b=VmoMA/9mGh1ItnLWZMHaIjW41UQvqGL0Vw15yxvczajZf6lVAv35W4IPjC6R3V1HtK
 PAEpPJTYoxV3OgZ41ZPDCh0q9xXKu7qZtsivkTTWHkdg0EOwXhhhKeZmzE7GdZf94iiC
 A00g7OdN9lKF2sP+YudwjtF9tAB4425xMKeXiPhkHh5umPjKoMam+O9/Hf6HStFv0iLe
 SQkU5sSc2XVOATRFnkDmxTnfium/WDIdqA21sgwNZqoeq2LN8XLfOGy3j1dXuMinIcGy
 idhqh/s2KmuES6FhpVxkBFZUujc55d2tMwRsGuTiKdJKVaj10I2um27IC3r81G21l4jd
 fafA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNPaPbO+ZZlr3I27Fyc2sPhq0BpgMDzqLi4ETpQgdA2tFmuo4HpRjZZS0YqfmtXy0KuiiQyzdS9TSq@nongnu.org
X-Gm-Message-State: AFuF++k9GWNxcvi2lRXvmfGoebObhiSaOfDh3v0lCFOMgySw62rLWsJo
 Skt2NHVHBV7LdVuOOaGxRuPotlzTCyh1pbLWTOSnKuHfJDjBYuFF5nHotUIzWVkHgpyaLNfldEN
 X0ftJ1zmUpSxSf8sHDQNF1bZDvTjKr5OucctecFZvssFP5LMKMNJ3mcQ9qA==
X-Gm-Gg: AYBFou21SzTrJ5VCS7MicALXnj014Zatu94QTZdE0DzWMo7bfMifp+IlBQVgKojuK97
 UTgD3moqBNRAU/NImJPCe64OlpfxdhQdlTWlYuRyIZhg91tZzxPNrukiVgRHZvNChGd4pCzfgqx
 U2O8Kc5otVULvO9OXvJXrz7takfAnH0vYrhKiBsjviW7M2MTOKwprcQww+7Sw1rlzWKBJJsJmb7
 OqWmy9Aewlhl1ZfW4ykGOMeOkXCyCm1trNwjlWdhovWYBwi5SJrLxWOHl1aHahIDIYqa71pql1J
 FBdc8bXv2U/X+bbAZ3S3S7OP8tcD1/LK0MoSOAfUq8TXlRimveCK3AB3SCk+GkfHFMo/XnveB7i
 fAcQY3hltciye/GBQ0GHoJyWFbBsuGTmbdMCW+yqJp/Mq97LW4HnJy2YYch8M0T5+Ry7G
X-Received: by 2002:a17:90b:1b08:b0:39d:ee20:1e3b with SMTP id
 98e67ed59e1d1-39e1e4cf1cbmr7400994a91.23.1789577429203; 
 Wed, 16 Sep 2026 09:50:29 -0700 (PDT)
X-Received: by 2002:a17:90b:1b08:b0:39d:ee20:1e3b with SMTP id
 98e67ed59e1d1-39e1e4cf1cbmr7400917a91.23.1789577428700; 
 Wed, 16 Sep 2026 09:50:28 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b030aesm8922499eec.26.2026.09.16.09.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 09:50:26 -0700 (PDT)
Message-ID: <53d81a0e-f0d4-419c-b9ce-8832bfefe0a1@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 09:50:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] configure: re-purpose the tcg test compiler
 configs for vdso building
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-6-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916153013.2134555-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzMCBTYWx0ZWRfX9Fzo/sT3RWJ1
 ln9yP/hLG9SYbwnDOQtCCc/p58krwZYMB/mHErPiNEmX2JEKfopsut3tzNJMsaxJGofMl82BrI5
 HT4BSNTBr7AuT99ZRkqde0FgJoDZIOo=
X-Proofpoint-GUID: G6gu4odehDiLg5JdUDc_wx1gT79uV5jT
X-Authority-Analysis: v=2.4 cv=N4m8hG9B c=1 sm=1 tr=0 ts=6aaac8d6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0Dqc5Zc_Qx-x__DvnkYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: G6gu4odehDiLg5JdUDc_wx1gT79uV5jT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzMCBTYWx0ZWRfX+m8Y1mTPwKyi
 DlaYyRChw1cK4iQLnTpVQ59M0Y54BP2St6KFmcp4Zv2X4W2Tk4PzJHcnyHmNVkWpqdOdBAiOKD5
 wwi5HaJzn089K0HLYiDYVyjJzihS2HuFbz/0VzjUkm/T53KKsfd01iFcHzotoBWt95sPAlew+dx
 FKZpUdKAAq8ZPEb86qkdwyefk48N4igkrBFDO27PEP8522QwOVFSLh0eYMHEtiedhrSqq9F6XYf
 KMunHQ4llz6Na/Fc2TdYd1CZn5SEXR1QF3HRpUtyJxu8GtguGPLetG2pOYU1qrhtQY0AD5tH62f
 klGHiY1Rhze44d1vg+qdPKq+lITFhVOc3XbpTtmTDIBrbbjY1LEeK/1H+7ROZ2eYFiz9Ir1EV1h
 nRbr4ZbBwwNQiqHIQiQAVnag9/TeQRc9B7EHO+v4HpOErVeD+wONzJE0a5vh+Rv5gpTc9vH4rQQ
 E12wakDKOfA3E26GNug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160230
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

On 9/16/2026 8:29 AM, Alex Bennée wrote:
> All the tcg tests are in meson now so there is no reason to put the
> config-target.mak files in those directories. We also don't need the
> GDB feature tests or to emit prerequsistes.
> 
> The vdso re-build blob does use the compiler definitions though so
> we can emit the details for that and tweak the vdso makefiles to point
> at the right place. Note some of the vdso makefiles build both 32 and
> 64 bit versions from the same compiler.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure                            | 69 +++++++++++-----------------
>  linux-user/aarch64/Makefile.vdso     |  2 +-
>  linux-user/arm/Makefile.vdso         |  2 +-
>  linux-user/hppa/Makefile.vdso        |  2 +-
>  linux-user/i386/Makefile.vdso        |  2 +-
>  linux-user/loongarch64/Makefile.vdso |  2 +-
>  linux-user/ppc/Makefile.vdso         |  2 +-
>  linux-user/riscv/Makefile.vdso       |  2 +-
>  linux-user/s390x/Makefile.vdso       |  2 +-
>  linux-user/sh4/Makefile.vdso         |  2 +-
>  linux-user/x86_64/Makefile.vdso      |  2 +-
>  11 files changed, 36 insertions(+), 53 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

