Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0FDFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDQo-0001ZK-IO; Wed, 29 Apr 2026 18:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDQm-0001Z5-I3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:30:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDQk-0007L8-VT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:30:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbYsd256087
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N/kx/Gdm8IcJd0SnOHtYBcEUO7HdyZYG1HF/YypyybY=; b=e3v4O9GuF7uGXQ7h
 yCK6Vw5z5F09xBOnUo9sQOxUeR9+DKPvCZxQe6QAtCNi3jJxlzTkJ3rbAYH9Vz27
 iIFae+JKMDSuF3tzcHnK5C/7WcwJlTjSFBkKCCtTWi32EiqXPqyU1nap0P/45kGn
 YTJE2OQu5LGGdQnG40aN5K16/Cy4lWPsjN4ezpcl6qROX97HKRN5vf3CvDlnDshj
 xOAT5AV5vMw5gLyXtQGaTCklu0cpJ/woztsaghj17RfzGHaFIYpT7KviU6wDUlDp
 7N9Z0s9TUXqT8LDgeJtPTFvdecGhL8+6rx+5WXPeacubamWTZidKQ80is8fpXWb/
 rFb5ZA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dun71hbe8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:30:53 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c21dbc9c1so754128c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777501852; x=1778106652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N/kx/Gdm8IcJd0SnOHtYBcEUO7HdyZYG1HF/YypyybY=;
 b=hxB/hnlQc3ywD8Ut6/yhMcAVwqDZUWNp2eU/em85+Zsmdy2UaltMONLqe+ZX7SqWEO
 i5k9viHzYCzJkM9zYep0aiAk5jggSBDk13B1uTijFuZ6SKh0/0YaLWwHXC27NAkPV+Rd
 k+TB1vvtfU/qnHzhSosywg0QrsI7sC4S59w3hWHFeZhZxn1xoiQe/YGIJFJhGWbZ4Jfq
 aTmZLbdYdUPoPOgBGtXoEvrqDiL2gywn9yKPXYq/LiH+DfqSYpAd5WqNWkUwjdGCyGce
 C+rzyUjYrbd/6oEluucwxFnzkzkhjJAx3VhQ9RIR09ByuDnxCFWSa6Zq54Oqw0/8dwKr
 EuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501852; x=1778106652;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N/kx/Gdm8IcJd0SnOHtYBcEUO7HdyZYG1HF/YypyybY=;
 b=AbgJGQ9qjpeV42tz3XwH0iKHs8LNBtyb3wWEf0Fn1S2sAkUYYKWwH3bLbfIdgbddT+
 Ky+YyvFtWPk5dtUCOSCyQghT2tY4Xdy/kf2gOep2pbBsalPQrZfDuxWhEO5Y2ScbAb6f
 MiPa+z7Lp5D85sd/Pb0HKyehgQN6yGP6La09qka5HvGMhkfeJipvKx0Hn2kzMm0oZdJp
 KovLivA4VWO4sTywWmuh0Gzv3jZ7GBn1ApHSBIgjHxJYSpZG/Xer+Y/Q8aWT4t3AqQso
 MXXfYYg1jasksb+ulKVkCdXbm2dBv0d/Z3WZ2URR60aAY9oRDB1hkUZnp4AqYyaYdBKL
 IghA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lV/RWchuPzgPQ/owYWPqkcnJbFNsE2dLzdXyQWGp/Dgd+RCuXMb9dUYkiLc387LGB1Fsd7Y4roxFm@nongnu.org
X-Gm-Message-State: AOJu0YxaAE8cdSviysfXKugNn/rx6M7YepVXXe37E28IL2+SBBFqUxv6
 WukGEWrlzf+M+6quHYKz9V4aW/tnKfC7d8r2Zyr9tRr6kMxT3NsiOHD058q/xd04V3esUyWaGpb
 tIK2QsvrwFtjZ7VX+hGEgBUvPdAZAWDFn3lJuOOGteBUuDWOozSodw6ZCgA==
X-Gm-Gg: AeBDietNpmsj96Q6dEGjFNw8lU0OcJZNPM5FrxKhZieuOhWUsHYTk9NKXUlaKQVbucB
 tIK+3YfGp8YrrVvfpj+kY7tdF2KejAhwNrGCsFhPR4Kmk3rC6egwqYE7HwJUbO2GJGm74goa0sG
 D/jQT74hRh6qkkuJju+oEiHrkApRBePBzIeE5W6OSfc9HwDTK/P27A1z1lQGKT7gswxUC2tS2av
 WRsSuL+zwcnYzGBHAXxlY/eou761O8F/0yjJRuQClaX8q+dDuuikUOcHGgafDTLvEbTOeOR5dHV
 C9f5O55VJS+DGuy4vlZGINcaVkHcQjQ0f0utFdvg7uTdDltA6CK+5k4MdjGkDky/UIQr6CgaV5p
 BXcvg7PCQJiBtXtS4kXEnJFsHzQXFHMvs+dZBC4SWbQrNyPtpcu+HgEHbwTYJmgR/OsYTHq8dXT
 1+Y65RXyWsg3n/XkywzNdUcgsx
X-Received: by 2002:a05:7300:fd03:b0:2da:7e33:9261 with SMTP id
 5a478bee46e88-2ed3dea8e6bmr107682eec.27.1777501852489; 
 Wed, 29 Apr 2026 15:30:52 -0700 (PDT)
X-Received: by 2002:a05:7300:fd03:b0:2da:7e33:9261 with SMTP id
 5a478bee46e88-2ed3dea8e6bmr107674eec.27.1777501852036; 
 Wed, 29 Apr 2026 15:30:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c070beesm4214173eec.14.2026.04.29.15.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:30:51 -0700 (PDT)
Message-ID: <d9b5006f-8e50-49d2-9afd-fa47f2773eaf@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:30:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] bsd-user: Add syscall header generator for FreeBSD
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
 <20260429-syscall-nr-v2-1-67a8d09dc13e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-syscall-nr-v2-1-67a8d09dc13e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rP-IryZoF-IX8tcc0HgGo6fnJpAj75SU
X-Proofpoint-ORIG-GUID: rP-IryZoF-IX8tcc0HgGo6fnJpAj75SU
X-Authority-Analysis: v=2.4 cv=TvHWQjXh c=1 sm=1 tr=0 ts=69f2869d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=6mbVqX4RBJJKe1JIGN8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIyNiBTYWx0ZWRfX9bpZpzLzXcRV
 7Z8C1QpB+pz+b37ohwWZ2+OAc+3a/CsbugtilGQAY4JaYIusaWbS5hJMOmEXW0z8xII+tKf6Fb7
 ZFnnP2m8LjtykeR7lyITKARBEjlhyiyvTpJG+IB7vo5yrKP6Ox85G1SOPAotkqCDcESPkZuKKDZ
 GeQsrCF1TIDtfyVx/Q6WO7nDf3a7/l0J/yGE2Q+0k0BTjDuMc6Rz5BLYl13TWmzhOT7vwHm0bh+
 XcmeVpfaNkr3MaVZxddDbJqSZrhx6zc4Oqs90FT+XLEbbuSxrfbxK946DGp5hNqkVhHL8nczINh
 DzxG0gH9eU10RAb2rAmmUb6jFFUVvErQSgq/oEP6n26w5LE4y1t3+fNbmx5HRboB8fk0izwEkPR
 HeTmVuCKsvyZxjd6+XTlxe5lYpbHpEIb5tJiEeluuccAQRpcCKYvKV0vyWiIRnGWaPbtrLECCLh
 QbfQ1dI5VP6JD78K1nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290226
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

On 4/29/2026 7:38 AM, Warner Losh wrote:
> Generate the syscall numbers from the installed header that has them.
> Ideally, we'd use FreeBSD's lua infra for this, but that requires that
> we have those files installed, and they aren't quite the same across
> supported versions yet, so use this simple, but effective hack. Add to
> meson build, but unused.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/meson.build           | 11 ++++++++++-
>  bsd-user/freebsd/scripts/syscallhdr.sh |  9 +++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

