Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9712C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6a14-0006Fw-GL; Tue, 15 Sep 2026 16:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6a0s-0006FX-9i
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:44:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6a0q-0007Z1-MN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:44:22 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FItf363928401
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kD/QY42LNHCWBp+cJCavDOpF9JO/fIgPXg3CWYb0cQ8=; b=VrJhcDmds33mZfEw
 JigUyfzTuwxwiibyJfwlJUETVSEjE0/t9acfqJez+uc9lCNSpxUY5mtmjZoN4wn8
 Bg9JoJ67yKkvNhtgkqj4/0j07jrthMUHPCAaGjuG+yUgUbgvb89G6S7sUsf/MI6J
 gy3mJ5aw/vI91+1fbhyGcgN+sT2zACqbzIJ2jM6J/7szLi3BFUWI4o5pltwAVczw
 7jBCh92+MfKgLw0bW4SuoZqoHNdBAZR1YSgRhzh6CfgCH9uFsuQuVuajn0P/VIP+
 xDMJ/nxvBtzbrjohFTi4sHhPMzTiR4AOSMblPnOO5OZTQemwj9yQxUOqyFAeOxlm
 wtA74A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqagegu13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:44:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39e18af9f48so567076a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789505058; x=1790109858; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kD/QY42LNHCWBp+cJCavDOpF9JO/fIgPXg3CWYb0cQ8=;
 b=IZpowLvvkyTEge1ed5BLsAiCDgtuJ60PcW94F87M/QG+CEE0sIzNhmgPZdBUfIP97M
 HlOcBj87cGOAKhqjxsYTxdj6VM56gEQ1ARXU16LNzABU/59ajoUeGFalLSMoDquc8J7Z
 48mBiqEOXjz2F7ufLQSZ9KZFl+NtN66rcchfmcRq+1LZwmCWMGWPlvIdLIySys1Z1UGr
 SYzotAtTvHRpdo5Z3MyNZr34JmkVFv3aI9GEIlvZdyVj+B3U0xQshTqSHGsmErnMhFDo
 svZUEA3zLiPWOX9zo+aqpipVyqPLk33kckbumwWGG+UVqtx/MMmNikW0yqTSZ9WQKJXU
 +UVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789505058; x=1790109858;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kD/QY42LNHCWBp+cJCavDOpF9JO/fIgPXg3CWYb0cQ8=;
 b=Qf79qixvnmo4VjKW1gBn0nMlRxqGN7ToMlNLWmKJq8nHFkU9W/f0Oo0ix6w0AljA8U
 /BE9QAFTPjwhLFpJ0MjiCDZCChM7mqk4Z+r8ScBGQeHziPH52JDgZQ9yv6FDFXJ8U+cF
 CrZmwz4p60PIl5VJ82/iycyeWtOffl2BCztIkNtLcMCK/GUazNGbRAA8FcK6QFR+s7Ab
 5752cURuKjnSzdf2DaczL42Y7JMSXMz2GP6vQdwGZyhQEv7uTOtFTl5kCIOvv0QyQJf0
 aaa0i/cjG5htLmC13gt8VVC77A2rmcAyP5lPDOTtu3BkPNohOJ9tkXpSefOIIPW56LZS
 f2uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ8iPdqa2vNfvVGiy2Rp3JsEFx/efP0qPNtcMB86UxD2US8j3t0c77DX3z2HepgkBUlybv2w6sGsQI@nongnu.org
X-Gm-Message-State: AFuF++mPFtV58lRScoZDEJxaV50KU+LPS/Qd6wDVdlUq09z3G40AA8q6
 VZbTK2feLhZrFjUf11OoF596YTjJKvOSTigK/VPwyCxrH/Q2H1toaTC4pknmGqdjPBBo6ianoP1
 iCCisNhAIi2jWyn2tMd2WuGcRhDbeQ6FGwbFA5JPPatEGyw/ecab8JQWiZg==
X-Gm-Gg: AYBFou1t5HTyOBA6V0/2iURuCKyjuwsPC0ieiFEt/mKrpYUtEkyjwCaj/tHz7WTd80D
 rsjZ3OuxUS8bDpIsbwS4xmz/51aY8c1DHyBybGlS/lm3vUfe9/FDHgxX0YHntfJLZgm5Lm9NGFr
 Xyd3pUmWxPChcwicTWhU9ydQqDmLvVNWEG5Ev83nZpGJ6wcBF+dF9knSmgBTva+uC5nWjZ/wCyO
 amKzG5bDt20sxzBXpLzyFYsujiIiWRqXFZkgLxjg3PLGrCOHJqviGndTsWyZi/FBlKfBx3jJEMh
 beXs5tcOwl7t6aXswCl0164hknyYkKus0Ul1VQyEH+ULWD3R3XccJPxUJJB01UBaurH+4G8Io9I
 87pOaME7wTmVoU1G2IlCcOS0atbBG75sOiB/IZ+81xw8ztFpxvt4a/GadHO5zagmC0rht
X-Received: by 2002:a17:90b:2f08:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39dfdfd409amr5506349a91.5.1789505058279; 
 Tue, 15 Sep 2026 13:44:18 -0700 (PDT)
X-Received: by 2002:a17:90b:2f08:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39dfdfd409amr5506317a91.5.1789505057776; 
 Tue, 15 Sep 2026 13:44:17 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395cfb0d0sm1090713c88.4.2026.09.15.13.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 13:44:17 -0700 (PDT)
Message-ID: <6716ca13-1667-4e99-b7d4-e4e0b587c963@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 13:44:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/tcg/s390x: Provide the libc bits needed by the
 system tests
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260915110959.492195-1-iii@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260915110959.492195-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMwMyBTYWx0ZWRfX3H/WWzsHvG9n
 3FsmCeaUycoWhdmeUGOzB6lpqcHVhjIHy0jLeU6AbBATTAkktgtIgC6PWGDrlw8Qc6UdZuuIBJP
 ucrpXbLf/Ig/GsBH5eL9tx8fh9w3BEk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMwMyBTYWx0ZWRfX3MEMRVydfbf8
 UBCUZBUXRtlPxwhiOLA2KkcljmxvSpMoKmL47EP7ajDfQv1FaH+JfRmjZAzISCS16RpVp2rn7cJ
 beOuPDW5CLZkkWL2mBkm6HBTcUdrwcQ5v8Ur40wRTFA5oEdEFUGbKkd+kYscc+Q6WLjYLHXGaor
 2NHLkhnQm7nz0wDkV57ilkNi4gQgUAemE/h5yY0aUFfUSmglxl651+bZ0gFoT1dBmW4g77PVLp+
 s7TAw/9qKcr2bce3EHGM8xzfdVcJwa4cbNJah9g4mHxA9mVWxezF7PDZT+OPHtvMRlhIWDTDQFj
 36SFb23GT1AyFL189BD52xMJFunf152cOK36EsZTjimIG48Z2Oey/BIbZ7PHA4OAImirt1AMmjR
 SfuhN/xNxwCfZa7S751OQC+G6mPVkvO4RdBAePBUxCLC2w1NdGFveU+K30NhzSe9PMLhqqwv97Y
 ANUXSMxxXPUc6599E2g==
X-Proofpoint-GUID: XNtp1sd2wETSWE0H4NhaXPPnkHhZzeTc
X-Proofpoint-ORIG-GUID: XNtp1sd2wETSWE0H4NhaXPPnkHhZzeTc
X-Authority-Analysis: v=2.4 cv=PcZqFShd c=1 sm=1 tr=0 ts=6aa9ae23 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=GaQpPoNlAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bJ2kKOJRcc9SvmRcoysA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=xF5q_uoM5gZT5J3czcBi:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150303
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

On 9/15/2026 4:09 AM, Ilya Leoshkevich wrote:
> The meson conversion dropped the SLOF libc include path that commit
> 3fa010d5317 ("tests/tcg/s390x: Use the SLOF libc headers for the
> multiarch tests") had added, breaking the build on systems without a
> cross-libc, such as Fedora.
> 
> Rather than reintroducing a dependency on the SLOF submodule, which no
> other tcg test has, declare the three functions that the reused pc-bios
> code actually needs: memcpy(), memset(), and printf().
> 
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Closes: https://patchew.org/QEMU/20260910100120.2076092-1-berrange@redhat.com/
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Fixes: cd81cf86834 ("tests/tcg/s390x: system tests")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1: https://lore.kernel.org/qemu-devel/20260914235113.272992-1-iii@linux.ibm.com/
> v1 -> v2: Drop the SLOF dependency (Pierrick)
> 
>  tests/tcg/s390x/libc/stdio.h       | 11 +++++++++++
>  tests/tcg/s390x/libc/string.h      | 12 ++++++++++++
>  tests/tcg/s390x/system/meson.build |  2 ++
>  3 files changed, 25 insertions(+)
>  create mode 100644 tests/tcg/s390x/libc/stdio.h
>  create mode 100644 tests/tcg/s390x/libc/string.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

