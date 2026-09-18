Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FCDC982DF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7eAq-000719-FK; Fri, 18 Sep 2026 15:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eAn-00070m-DL
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:23:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eAl-0005TW-Mb
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:23:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGoIl71347736
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /IhO/JSdfSIeMIBxZjFk+tOUxK8mOr7/CSa66XEMNQ4=; b=L6GK9A5LRYYO1j+R
 /vjfnofO9uAHbE0SyRcrhkN9+ZlV6H/O1Mx5v6kRIYWFDxyr0kdxNGvCMEPPJj19
 sJRRd7LGLQecPkKxEcoRvn36mJ9/YqHjoVmng7xl4I3NsMo9e8hvhoC5GjRcn8aA
 A12YU3T18M1AJANSE9SV7p+moMQ0Fium7cOJAPN4wVDXxLrv51GBqQHAr7vj6x52
 od7bmfm5Z8Cm6UGtOY9SXvyHfVGdsr6Tez6ukZqcTwD5pDtDbK0Wm/RvUNEsFAMh
 t42wwO4usDKi/A1oEuYOEkxV5/FADVUVtjVWzng2x0DAtEs+ZUms80b78GnMSqzj
 eKacag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs72u19qe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:22:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so24013175ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789759376; x=1790364176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/IhO/JSdfSIeMIBxZjFk+tOUxK8mOr7/CSa66XEMNQ4=;
 b=hpA5B1Oa76qHYFUG6La3pkIToLVDWlFI62YMdSC9x2Q9p4e7E3fqG4KdSeLK49+G9d
 JT6veaSgn+Gqc9AuNZE9pgOF8/bS51yYtp1LutcnDzvMWXHDparnKEWQzU8XKmerpuEK
 yi0fuAZZSIkju0vslqa1jgewfh1JgJ+TweEqwi7pK/N62kisIjCaHMzZBP3O9ersUwDO
 LqsNa+MzA9o7q2G6AE3PlN9gusSA6si4mvzXVXZ9xAAzSlTtuol79Ml4/dXOP+/fa3R7
 S8pDfZSRK/lcvFTUGBXL3COVxxqA+0BjcZXwsCzPtAtvsskRLalj4NdvCo5SGhFrVrgB
 Wngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789759376; x=1790364176;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/IhO/JSdfSIeMIBxZjFk+tOUxK8mOr7/CSa66XEMNQ4=;
 b=EhNqFNQ021GNtq0nXC90/VPIMMyJOALgqHBTPs5KO3jcylpbOUJ00g9pos+/EeT5lA
 Z0YA9OtN/QEw3F0U78NzHIIknmrGPYrROk1anvQx24fTrvPzePlFzM78poQKttsckZzZ
 NqxO0DQbCnsjhPzVo5rkJ3KZAu9KFNgttrq0x1x3hJPDXifq5y0F8VS0UlUp0ALy2h/Q
 VIZBeeLSygjsARGjGwaAcyCOHkqHMwr5F/3SqzDHNwQfx/VKZWuyWFUQWxpbdXQZFnwD
 h4lXR8Uofin/ad9LnVxcIet2M4+iUuL3ZIZZV5rCgCiXp/kbHfVlKem+HmQFP4y+GnDH
 ggRg==
X-Gm-Message-State: AFuF++lVScNT5aMvypd5KQPguE7aozZyBNUqH6xZWwnXkcG8LCKtt6FG
 qAMV1wY2ihXGaz5JtvyykOQ9J2gVxME0yIRhHQZnDQHoYdDAH2HEYi8hMeFOJwXzpnvtr0Kn0to
 CZInQ9iFT7dTfzWQZixdbHv8OPaO985VVpo0FyGiy9iDK47R87vtbF0yy8A==
X-Gm-Gg: AYBFou2Xjq/2YYyU+Kvcw40JHueTJ4njvZUQn14Q6cIJJufdIoLn1tIJdIJnycUlVRN
 RK+K+4dwlH5Ny8o4WfTYagNsiNMVUf9YyMr+JEDcKo+nbMksiHVn5V0IYtEPMeUDlk1ojNQ/e4l
 DFeOnG/9dp6WT77iOW+MrwzjHLJli/At4++SjXBm7CzMVngD6piFOJus3EvD+GQM89cAqjmXs6J
 KEfYiNGvXQpS8pQLcgBCWcMaPTlgmBwk+2tGftfz0Bt3Im6x0UebK477YDM/iKH2PscHwH+lwkH
 0AfgBO5jWfMLkNvPSYudO5pQ0/tHEfkBR3f2IntEz3QUJssr3RrQYJV+9u2u0d7v+coH3qeQZwS
 GNKRJLJdCPXeU7usQR2ihEMR2GTLf07mh5mU0RAULnAIEtc9ullULfgcz6fy271JEvvNX
X-Received: by 2002:a17:903:1a4e:b0:2d8:d4d2:d13a with SMTP id
 d9443c01a7336-2dd9ca3f373mr101707525ad.22.1789759376185; 
 Fri, 18 Sep 2026 12:22:56 -0700 (PDT)
X-Received: by 2002:a17:903:1a4e:b0:2d8:d4d2:d13a with SMTP id
 d9443c01a7336-2dd9ca3f373mr101707285ad.22.1789759375656; 
 Fri, 18 Sep 2026 12:22:55 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c32da4960sm861234eec.0.2026.09.18.12.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 12:22:54 -0700 (PDT)
Message-ID: <8c2c4869-d31a-4551-bcea-49f4f45a8fe0@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 12:22:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
 <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
 <87a4pf6moc.fsf@draig.linaro.org>
 <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com>
 <87y0cy6ace.fsf@draig.linaro.org>
 <7393baca-7746-4211-94cd-e0400cb864b2@oss.qualcomm.com>
 <5bc81802-f243-4faf-822a-04adb5717563@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5bc81802-f243-4faf-822a-04adb5717563@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X_52QaDxLATvR6FF-qAMzMGdi2WK2itt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI3OCBTYWx0ZWRfX6Wj4DBxMMvfc
 +uceIE/tdxmMIlpwbgq9O8yeyr+nmmqhwQJS9wWepEp+KSBtP1B4xpD5SXwIGQtZZUsJlAhrnyI
 latnVNVxfxIux2RnhosxdxFBm3uzFnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI3OCBTYWx0ZWRfX0h3nHCXms5DF
 oyxqPJWVdKeV2+Irg6W/XatsIorjsC1lThB/qgx5QvZlSFNt7CKfTcPZe4H7g9mxwMJyUp1ztfW
 LeW+nRyHJrQPo+sc+FiNcSKc1NBBl0sXmupinzCgHGGb+iTjgvet4rK+IfKBhyzSl540Wx2B2dj
 NcPLy0eJnx1K0VPhA4r/A0QxhRiLrVK3ovullaHh2rukqPb8BrNlGr0C6w5mgFSMG4Mcvhn83cO
 ovQMwVOznq/LbLxcetSnYXYSI5MEbIqFuu9q3RJ/69EnHGK9DG4bzsa+ya5FK1Jf2NC0dVtFtYU
 5BbXsnvzN8oVLD/tcjC8A2D9xsF+8d8BijNTYKNe3j7CBAu4G1JgABog1OfpJNE9CAW2GDGe/cn
 eRiNrXpl3zfvOSA3y/eTczm3ltyx7b6xBKSItlilhlT0WDXL3g0mS8jk8hA5pKLPW69pSJswT0T
 YMST3nLXnG230u5Rarw==
X-Proofpoint-GUID: X_52QaDxLATvR6FF-qAMzMGdi2WK2itt
X-Authority-Analysis: v=2.4 cv=DO8acCNb c=1 sm=1 tr=0 ts=6aad8f90 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=WIetgykv9vw4gKVDwtwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180278
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/18/2026 10:58 AM, Richard Henderson wrote:
> On 9/18/26 07:07, Pierrick Bouvier wrote:
>>    # finally create a top level target to rebuild all tests
>>    alias_target('tcg-tests', exe_targets)
> 
> FWIW, that used to be called build-tcg.
>

Would you prefer to change name to that?

I don't mind personally, and if some people were used to it, it makes
sense to provide the same.

> 
> r~


