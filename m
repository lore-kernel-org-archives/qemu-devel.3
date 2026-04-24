Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFC0FED3FB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMFG-0007jF-Fg; Fri, 24 Apr 2026 15:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMFA-0007iu-Nz
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:31:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMF8-00036o-St
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:31:16 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OGubbm1243990
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mv3b9whj527j6h+2v84xQHbClKzxvp525xnM4gJz3TQ=; b=Q02s1Wp8T1EsibP3
 J4EYNzH+5s5K2OI1kS/ezdMxKqzxyJw0pHK7CPq43v4/sIDsrUxoOfDZPChsneRX
 mqESr0yWHCcLfWrccyVy2cBRSFD2RbNi6wTIqogxExMToNf5hLEpi86/omwlf6jX
 AYG3tm4uTDIo/el5jW7USiefgrPYEtItcDB0tQkqS4iL2PiB2oUwSSQmcZEQWwui
 K/8dafWk3ZzHQdt1kUlyMgCmMF63YSPzmQFgkUH5XZnulPwl6S7JW4I+ySfWAuOm
 60NmhfZIom9u3aPoWiPYDkPkloKhJ3ARlMTk8bkbGeTzJ6/vB+WxaerfF6+pHtJ4
 h9rPKw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr48n2yaj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:31:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c16233ee11so11394482eec.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777059071; x=1777663871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mv3b9whj527j6h+2v84xQHbClKzxvp525xnM4gJz3TQ=;
 b=fQWy1Onit5EwlRUnaOcv17UvQfUXr5OPML/BylA8JODNFgJSWBvms6E+e8Tb0zVTjt
 nnB+CdPAeZErSkVUnQyWxZZDl3dLO4ePEHwzvHSKLehg4otDS2L5FdwmPSZVTHshONRk
 1cf4FJp4b/5OohBQc3yCZHxjhw4Gb+PPtMHsn6LFK/oZgfh70W62aIf6U/YvqVkMHl6O
 w0NkeqJ5DCj1Lo7D9vvWshb/cWnswxqJFBo2Jb2eaJvNFh7L/4NwkrCy7GWxsmcRe3Fk
 zyZwgs12sXSOegKARfZtkCfGCzYVpfSvv0hFigUtEG0n50hX6SAZSUCH9eti0dJk4/Rl
 OUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777059071; x=1777663871;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mv3b9whj527j6h+2v84xQHbClKzxvp525xnM4gJz3TQ=;
 b=KpxEwT5buWmcqXAdHbLdaKYzU03ADsdpcI9DPthl9qQP81RduZQb/Dhb+tNnRWYuAh
 FbUjkAN4hBBk6fBiMOJKMMxwvwOhk0D+jAEJuTTpw56BfiCYh9ISAvyLR4DfwbOBXRwT
 +vL3ckBiJaNoVrlKJhjKzajia4DN1L/VIXmDuKYBHmqgyTgVFQlY8nj+/oKmMxaJT6NU
 mlQ+HXKm5lBehX3hcFf2Fmuo0A2NThhECTgfJ6ifYi7qg7IjNoVbD82l8qUZLEAOrGxv
 PhC6Esque5bs7hxqP+4b4EfbT25yzxVbmOcX57wX24gEs039+uKwZleQUptUKkPf7v27
 hZMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TUJCyyB830nNoT4lRe4CEqiU4W7DNdHh2nsQiYp27yhGVvIK5ZMAfAR6nz9kkvfqbrb5/ZNXHQnCY@nongnu.org
X-Gm-Message-State: AOJu0YyhchNfEnId8rsac2PdG+q5ugiCCvlIrl1pq70mY/tz5yWYdc3V
 vqQzNEzS7k27JV0jir2MX/CbuVXmI0dMBpEqTYMT7oBdkC65Pp3EhJ3WIIlEVdSWN7sK6yJUjuS
 a3iMqMu+9k4S7dIPYJrZsrsxj9noNWdR98Cl+D8+jcWoiJxVUzHzNIXPm3g==
X-Gm-Gg: AeBDiet5zAFnJqAtc52D6Y5S48LgjAhtuXp7CMFw98t3IcspKHGggcCy1yBUD2FyAak
 7GE5YXwQRJThZt7SMW+EvK+JMVtf9B98FzMvlZhU5onwAqc+lHNEuw7YF00fIis+rX+36NBDl5Z
 zaL8ejWTJmBHsbGNBpYd53tig2TOwCnOs/2uzmPf4gq92curfirRWiECBf8lBAQK8vsPIMoyPLr
 9cdhmwzpuINLJzyR9lESFyAYhtYk6ctw+bEbzcdqF/MSnRAYEKzhvtSLcJvR4WxYPYDJqzkm2s5
 0VtfylT0WWnSpMHj5hK7b8GKIiDvJgTNTmRX7VShcyWY3o7NNaZXd/d9vEC7UyqFyNoDagY/51b
 xsbHRAcOHVuPJI/qdFAGQs/xLl6gTXogzUU4YRiAIaSU5Q7WVNPAPU6BoX4YlkH8+IYicHWotM4
 YkT/p9fMAv5s70xFx87Njfv2zm
X-Received: by 2002:a05:693c:2c84:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-2e47873bd2cmr19464402eec.17.1777059071434; 
 Fri, 24 Apr 2026 12:31:11 -0700 (PDT)
X-Received: by 2002:a05:693c:2c84:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-2e47873bd2cmr19464336eec.17.1777059070710; 
 Fri, 24 Apr 2026 12:31:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d2cff04sm32403973eec.23.2026.04.24.12.31.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 12:31:10 -0700 (PDT)
Message-ID: <e341ea82-5389-4e13-9fb5-a00c3383da85@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 12:31:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call 28/4/2026 agenda items?
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
References: <874il05rwo.fsf@draig.linaro.org>
 <ce906d97-7022-4671-8590-2f8f58b098bf@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ce906d97-7022-4671-8590-2f8f58b098bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Mx-e9GZtKy3PIp-avaGA4yycNJ547vT4
X-Authority-Analysis: v=2.4 cv=VOjtWdPX c=1 sm=1 tr=0 ts=69ebc500 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=nXA5WNwiAAAA:8 a=AIFZ9CWN9rhRYy_1z0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=fGr-7aqQv4RST94IA8XU:22
X-Proofpoint-ORIG-GUID: Mx-e9GZtKy3PIp-avaGA4yycNJ547vT4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4NyBTYWx0ZWRfX22g8xApczMdt
 Mjoee1Q3WAswrMU9Ac2EF8jnvt91q/o6bb2HRHkdeCOtpV8JjpVzhf9zefaNsBrfdWoKAUHAV9Z
 MBPXPdaLPtrRzUibexgyB1Ze3NfddiPJG+9wqEq7ONh/hjucug+qsuv4Hsi2N04UiXxt7WdBckh
 KIYXbODjNbVwkfEvyLKJ91xkvTTQBNHUsBrKDY0xz6sN9FVkBND38f+0+br2/RlPpHa4SL+DjDz
 vPmNAd/iL1qD/ZG2tp2wXn0Ne8VYbK/Q89fqrhNuBs1QrtgMasBcKwFWAump7nLKn2+AWc4IcD2
 csC7U9mpwzzakzHRbmv4kRd63NaksLpHkFQqHqELYwYLMnPKvyG+Uyl8aPUDM4idAqrKX9Wxd7u
 CQ9QfRY48wNW9HuAKGVKc+fyb+fOIybfsoMysVb4x7j7fr7TouRX1XhODVF5hXPtnP9/cPFsvMb
 W4b7jMNDZnjCCBhW+WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240187
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

On 4/24/2026 8:40 AM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 24/4/26 16:55, Alex Bennée wrote:
> 
>> The KVM/QEMU community call is at:
>>
>> https://meet.jit.si/kvmcallmeeting
>> @
>> 28/04/2026 14:00 UTC
>>
>> Are there any agenda items for the sync-up?
> 
> I'd like to have a discussion with Stefan and Pierrick about the
> possible improvements that can be done on our CI system, and
> review our git-forge use in general.
>

That's a nice topic I would be happy to talk about with all of you.

> Pierrick: Stefan is available this Tuesday, are you?
>

It would be 6am on my side, which is too early sorry.

However, I would be very happy to talk about it in private with Stefan 
and you, and other people interested in this specific topic.

I just feel it will be a conversation that may derail very easily with 
many people participating, and it would be better to restrict it to 
people very enthusiastic about it first.

Once we have a concrete plan, we can share it more widely and deal with 
critics and see what can really be done.

> Regards,
> 
> Phil.
> 

Regards,
Pierrick

