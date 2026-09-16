Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BF4C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sbo-0003cO-UC; Wed, 16 Sep 2026 12:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sbn-0003bx-4A
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:35:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sbl-00078u-OS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:35:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG5LjJ3597322
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vKE6r3whpvejVv7J1iK6GK5LuX8liJAEidYhPAzBXC4=; b=QMVeOh5tL1Dc6R6j
 PycRX5cJGTudOzOvHkCaWaDt0MH0rU6FZQ6o5gBY4jKmA6BsyVoFr1tjJEgJ0Ys/
 opaTa4gcPhsznMp8Gx+uWhnmOmpf6Se3rUZAv55l6iVdGBqohnS6YmV8lcU8xbmX
 mvNmMjX+Vaa80KWG2CnQHzdDAUBGoESB/Y+IZKsfrV4xkSDW3ErDMM5HTHF2d/OC
 Y0ixvAz2CbsHhAB9z5AaJ0cdcQO0sNJNhdR62AyzKzYDMboXa6VVgcfJUsgck7ej
 dpioVjANElUTo1OrPeUEvXrODjni3nw2XSBy++UbmaKhom/g7sshgRUYm/ND81XK
 OhO3pQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxay863w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:35:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39deb05ef51so5001243a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789576539; x=1790181339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vKE6r3whpvejVv7J1iK6GK5LuX8liJAEidYhPAzBXC4=;
 b=DtcS1j8ZM4yOtYV7QuyWj+AZuWntKYodZprfwKKNhCUXzSNr6NEA1j3FK37SMv1lV5
 mmn+Yevf/SeiTar0z4PE2I/q+uy6ujpvSq0rMso6fFpTPcqN1WKaxDE7KAibGrxlQNPa
 5Y0RmuFSet70Qft/1pN+h8HcqYtNe8mkGEdfPm/QazAdKAiyou/Hcj1Hl1YgTc0zOGrW
 urqesTCpp9HWHylXtCSYJGgiY+gNuFfMwgYwUmvVOJI6fSueSdZZwM15zRUS9gqX96vO
 a1GRs3l+mM469XLHekOhwCCSmpP4dNWkzzGlKxF0gWOIdYiXJVLOhp85Kc0ovyRLu0oy
 ltXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576539; x=1790181339;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vKE6r3whpvejVv7J1iK6GK5LuX8liJAEidYhPAzBXC4=;
 b=oWGWnYEEV/SF6ffFsG2YAG2uLSyXSEp0t3rEzA9I8jgCyHA6bjyQpYL+4rkuxaPLTw
 JCNq2lKLEl0XlsBMS/1tmYxqfW2ZdFgcEksaJ2D1JHi7tgImlMjAq6vYutaUSL0qCddh
 dvyGbEbf+Gaug6fjrshHCZcG05AZMX9g7kK7wlRikRbHMvTSoQQ7bIhrIRywb8VxEKG7
 uZy64UtXrBqtQY2eOCysnLHlLpfjVVabH+zyTyhJymso4WAeftM5GOG9kaN3zyFgPwsz
 Mxmy3gVOCPN0E1lH2Y5XHz3N+9ygvAZmJyYeX5toACnoGTxBc58XFSwkAFBQA52EX1F3
 9WrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIw4ggVD6cDylrF72MTi6+XeAPa1qCSpflu52/s8SkgIi+iKkbDD5tBBO70Fa6UiuAOPXDsMJegMxX@nongnu.org
X-Gm-Message-State: AFuF++mVe3Qn5W/O7CLPDhXjB6AWQi5ImskrRHYVVes+7SSIdtArtnj8
 u/CXXcLFRy2lM88qTlXIUUvhyDxX4E5Pu02/vO6mbA/YlWIUzSSjhOxfBB68FcZTuipO9m64wqz
 2gjJ008Ap5kj3NrGxPdM313FgHpRugFOeVOp4n2cbfvCIYu2jb0WJpbYs2Q==
X-Gm-Gg: AYBFou2aD/uqtpuiw3FX4E3vPqzVgJHiTvTaY0jglGdmXF5TNztQBhrNj6wSu0Ng+n3
 TePngk+QSAyKkbdQ+zbieBm7nlWaI5RAS9jU4ZqSvDsbh9iRYWrOBYE9a81SZZLLU61usoxZcGI
 TbC4f3IU5UUNwucAgRWQi1KPElOWm+RxOfS18CN7gTX0+4gr7V4aV5PSP/8R2DuMKicc7e+z7ck
 1BxFKqtEcLzoZX2UGAv/SzYagn0FHVWy3W1ScR3se4QBfziuMF4bdijt7u9xzlZbtsm4XT068dw
 CbRfLpqeh79wNWpnELzwLZ2WfS1bkedqHRKEYtXNGaXzWaXHSvQYISulflqAHoL2ECygcXwSIVY
 l/b7TSN598yVtwGcZGCOE2IxKfZJSN/lFLXhD3lt6Cc5FPIN/LPjwzvOE5kU3yAQ/NiKo
X-Received: by 2002:a17:90a:e18f:b0:39e:1315:a952 with SMTP id
 98e67ed59e1d1-39e1e4deb71mr9277430a91.18.1789576536075; 
 Wed, 16 Sep 2026 09:35:36 -0700 (PDT)
X-Received: by 2002:a17:90a:e18f:b0:39e:1315:a952 with SMTP id
 98e67ed59e1d1-39e1e4deb71mr9277276a91.18.1789576535550; 
 Wed, 16 Sep 2026 09:35:35 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a0c5sm9123329eec.7.2026.09.16.09.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 09:35:34 -0700 (PDT)
Message-ID: <382bb2d4-f773-479f-98d8-c0073c594881@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 09:35:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] tests/tcg: use --add-current-user when building
 containers
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
 <20260916153013.2134555-9-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916153013.2134555-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyNiBTYWx0ZWRfX42xV4F0mbOeW
 eJB12R0OxhFbxvu1JhDsViV1qc19oXgv6b/5MSthV/9Z820ell21O8+2ks00d3nnr7AdJc499g7
 uPXWPXiinZrwXaWtweBUSw93lM/pIV2rgYp9VM74mqadZYnt2BYCUqsDtgrBu67tG72i9bkBkNR
 vxIChxJUEQVhQc7SXssnHkLzBYiC3cvJTDhcpOIUe32dCWSFvEGFpcl2Gp6Yz7Rsh+B4RsRGkjc
 uJsEDZXsu6+zxn/J2fmnigWerilm2bIx5+E9iAKqgN1HER9s9bFCXRFPsmMYlnKRjnPGNFrOXyM
 tUCAeD4SHH/16fZda0Ts+2WC2VV+fNBws3nuKMvnnRIyn1uqDM65+3OsqQFMCiI2LI+OS+WHo1v
 b+pTY7VVAzpk3SA7Yw1qoHXNM8lX+invfr44W4qX0thtoppVB072Pk9YbKi3WyDdYkmb/b/4yr6
 MoJdVsSrvJLiZfpe2vQ==
X-Proofpoint-GUID: GTSNMo1Dse_UUvv4UOunL0vwlP_MFGHE
X-Authority-Analysis: v=2.4 cv=EoJHPicA c=1 sm=1 tr=0 ts=6aaac55c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pdCF86s5bGdHQuHMJA4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GTSNMo1Dse_UUvv4UOunL0vwlP_MFGHE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIyNiBTYWx0ZWRfX+f3AUygvVMzv
 Fw8TpoYlbVdN3dXZeruTBaQlqNK/Y1ybjt+zmtlnFAYgtxSNxBtI4vFR9msfZ/laCCXefkjt1H1
 A8i1sEedddeXTFbC8MBissc4S0dHQB4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160226
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

On 9/16/2026 8:30 AM, Alex Bennée wrote:
> As the meson tcg build routes the container builds through docker.py
> we can also clean up its hack which involved appending a RUN line to
> the dockerfile. All the dockerfiles that care will work with the
> --build-arg.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py | 13 ++++++-------
>  tests/tcg/meson.build  |  3 ++-
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

