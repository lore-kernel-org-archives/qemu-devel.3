Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F110CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsHX-0008Vo-Ib; Wed, 17 Jun 2026 11:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZsHV-0008UY-OF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:34:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZsHK-0007RN-Ki
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:34:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFOejf2638867
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X4L7RJpXFn2WXJGXM8VxPzJUgx+32htZycnzR5dWu7A=; b=KVMl9pIeCiUEi+Ht
 yp15nWY0973bnxJrFuQTy3hXYy2NumM/tcZOTQX2UWz0O5biM97w6AfGGdGybgM9
 gdUk9GayKZGRtShX2HAKi9cgJVtAZXZt85cxqWe54c88mO9JMnAySYJlIsLI7aWp
 BEw1Y5DSsTlhADxx2nYcGYFrzBhQIxR49RO0WrJ3GrGRd/uNM0VB6viI3Z8bGbsN
 1MFLjMGzFradnDkHmUrG2hJ2m4tG/m6tAu2eDbmDJsFCu365F+qcYaxXWvtAnuHx
 fmNeeDjE6gj7Jc/KOyafO5eLVWfvboCXPSSGorP/SuE3AvtEPixOY78ljUUlMFtM
 gnXd0g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueet3v34-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:34:07 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-966d40aca0eso1437462241.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781710446; x=1782315246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X4L7RJpXFn2WXJGXM8VxPzJUgx+32htZycnzR5dWu7A=;
 b=Z6w93KvhpY21uXQSvcceslNzpp8hfUxxE68VoyGVHL1Hcklt6uYJ9w65ESH8cCFFQZ
 L+dX41N9JSFAgK15VrqNQKmCg5A3B1Q4Vlwd+lvfWPQVYXAlVX6SfObvaN1/YaF9MPpq
 5ivkuSTU8EIL9UZvx0bJXFgsOqUfwTTi5quaElofF2ggmzGZKPMpa5fxpUFMnC9Dd+92
 Rn9y+K3XcbWx+n6G8XyZuOKNXQOcg78fs/jYilT5CiDgh51hOQH3XyI0ZC0i4/3eRTSk
 Xo5F1sOQdH6l29K0vRSAMxAO0RvHb77sGX20yi51vFYyW5tKd9+KKDMYmBHyZaCv5/Q9
 fiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781710446; x=1782315246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X4L7RJpXFn2WXJGXM8VxPzJUgx+32htZycnzR5dWu7A=;
 b=kS5nFGhtlAvHI1iHz1qsaYzkLtLO6yIpyDsQkVIQzGKW/fuvoE4HUYNgw4IP0eI1Tp
 0VMuSyqfowAQtZbWDhZ+dxhrEIK936oZ+cmZ3OxtaB67iMtY+6OqsioFsCK9XR434yJO
 QZkG8BJ9FP19Hbm5j0+cFHLjiArbgoIVSQptxlqmQnEYEjX3ubiX3q3biyWstF10vmnI
 cB4SCPvDCR6RVQp0aLXUlOS/vpTHUJ2FBevMnX/AFBkG9gzrm965XfDj/GCIbn+nid6A
 Rz8YewCY5wktg/acCJBe1Bl3RgRYAlhDORpdm959at098REg3fdqgtICIxCde0UwoOys
 6omw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/icLiv4SM2VWV4cLoppkQhKPYH2v97X7cX/trIiic5UemT1ZdMKksaZ1aLdXxNAHbRH9GJrbNnQixj@nongnu.org
X-Gm-Message-State: AOJu0YzM7f1CxMxG/Sy0vyMo1j16RJVVKpDyU4PwkyK1//PU2AvZ5Oep
 sImr00uk1l+hFshJMoF5qk2yZUgW3+4wvkOEsBMfCm0VDYPTE20Dro7gbvLqtfEpuYkanwg5gwU
 QSXl22uyAa8SvjOoMZfhcNLLqt7cUvHbmXq5MCyD+pdIerBuBMMey1A6EpQ==
X-Gm-Gg: AfdE7cl9j35pCZoZYd76fksLqgEsRDA77J/6GrEskwYQs755PB4ObK+XQ6xN3WnGoUJ
 HCbv3EOQ2+vNpjdxgFGLUdE/X1yolRzhImHXb1enu14awnxq4cgKP8gC84IowKzLtw5gvf39Bug
 nHUo1qHGMwhlx1Idgikc3TPp89aUt21nGgTEVQWjCKJiHKpu/I/ItYc7uJqFWcXFrKTSK/kcOcU
 Tj6UWbggo2QtbSkSdKjqeKi8oq86H+Z0q2bGcto/s3gO724RZgYnPRjBY1pOvEO1DmKSaV6fEsP
 09CRbe2ckK6HJWgmmlDehU1IfJzvS5F6MAH2OGzL+3EUN+XzkHsnXPkLXvCHALG3QHRgMh8dOQt
 tVstIs25obiThhr4Kjb8lPrsolK2V+6LbsZnHJb1/XShUC3XUsF8FP7OZQkOBfA==
X-Received: by 2002:a05:6102:8394:10b0:726:cd42:d039 with SMTP id
 ada2fe7eead31-726cd42ecdbmr949290137.24.1781710446422; 
 Wed, 17 Jun 2026 08:34:06 -0700 (PDT)
X-Received: by 2002:a05:6102:8394:10b0:726:cd42:d039 with SMTP id
 ada2fe7eead31-726cd42ecdbmr949262137.24.1781710446061; 
 Wed, 17 Jun 2026 08:34:06 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm57494304f8f.11.2026.06.17.08.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 08:34:05 -0700 (PDT)
Message-ID: <1ed6596c-0e54-4296-a294-ce44e1008341@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 17:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] accel/tcg: Have cpu_loop_exit_requested() take
 const cpu and un-inline
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-9-philmd@oss.qualcomm.com>
 <8633117c-e2e7-4e68-8684-6b7bb6b6fc20@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <8633117c-e2e7-4e68-8684-6b7bb6b6fc20@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TTjXUrZezyPKhHNydXO3v11_LBlpBnds
X-Authority-Analysis: v=2.4 cv=JufBas4C c=1 sm=1 tr=0 ts=6a32be6f cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=5NyoWofplgpWzV8F83sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: TTjXUrZezyPKhHNydXO3v11_LBlpBnds
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE0OSBTYWx0ZWRfXxiGrkJdacDG4
 wRf+IzbiRdyauGcmw66yy5ur0SsgDx+qnmUjoK+xIO15PQ8vzMHBD8eI5HDIotAAnJFepPKQGHg
 djSHrMqU3THqG6JLJIAv/H3pVzLbgr7dQCJvI1KeINdNlr2IX0lNBg00a/ByZlTwdGpYtTOvy4G
 qGu6SdorfP5CGtcojjFc1mFiEvW2Qj9O6EoAf6tQP5mJWu9IV8SKkMkaK2s308DQDblNopHq/OU
 ri5+2/tDmEgxRQZol0Cy6BfR2YlX4niqwoSARLulEirqCUJvTqZ7ECFd556dy3t0I3KzFp1FLmu
 oqqr73o0bC4XJpn2UihBfzIXlYWXsNW8BGW1DVkGZ8t4UxYbjJp6tOL203rWGui4cyTuqhYnal3
 zo1ntmCg8XHHrlmdgxWsUV6Zz0bCywz6oOHARw6ictirXoRRtfW3zSr8sFqWz8fL+Ypkx8Mg5e8
 41kCeK+pc5jh4nHn0dA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE0OSBTYWx0ZWRfX3n9bd+YGBnEb
 Isl2j1uZ3A8Lfr/Oa2oHfhkCHDQgQUyTP/H4nc2dc4/nZAniiDwkGYak18jEcRI/Xqbr6bpeM77
 szGicYI9FpafLC2rqSvfp9/BsBSQ/8s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170149
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 17/6/26 16:44, Richard Henderson wrote:
> On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
>> Of the 5 calls in our codebase, 4 are unlikely(), so not worth
>> inlining in header. Since the CPUState is simply read-only
>> accessed, make the argument const.
> 
> Unlikely to trigger, but still called within inner loops.
> Please keep this inline.

Why not inline all of them then? What is so special about
this particular one?

