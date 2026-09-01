Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F5C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1T8I-0004Lm-7E; Tue, 01 Sep 2026 14:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1T8F-0004LS-Nw
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:22:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1T8D-00020z-TB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:22:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgJmV199891
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 18:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WxGcqlMRe1h8rufChKdnipJn+gFcVL7ZCJnaWhoft5s=; b=b069A89dTyXBAgtp
 7cyUZasxsK2O3U89aETJWB3NedWSFla6/m7zG0V25y33PUFKFVfaQ6UdwbpKxOcT
 hETb+KwxFNfZKPLcWV4fU1YlqzyIT/qiA9QwmcKgBSgsjcKlqHo0GlegWNyc2SFA
 oV7jz5/jswvtKtruWmNy0kIg963GY4reAs2LrTL60JTm1yU98WnTvPYd1kCx5G+e
 HEQE0gAuWUEk3ulSYjnTGpQaN+Yv+4pYIQqk1kORyh6ulTIBaf0RxZAGhTD7bIoY
 GdAgRyHUkDizsTHzDR8jOyZpTxgCnsaFQZ+igdpcLRkMc4Wihy6ZOE2o126cd3j6
 KqNTOA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdsnu3cw4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 18:22:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf1c86963bso13788385ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788286965; x=1788891765; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WxGcqlMRe1h8rufChKdnipJn+gFcVL7ZCJnaWhoft5s=;
 b=kEVJwTdYdEL53EFfWOKGpunGuO72ptuc4Fi3/VsJg1t0sc8Chk7PYs1o96Ak/VlZ9H
 Evt0tpokP/fAd8iZK5X+F4DyIHUcEpBZC0sIbQ2ruAQBuEk934txx6yRXpeHLwfoko6u
 f/Z349NCmifyNwWBxRyiFKGK7pMKDVlRO2Bh4LB2ev2xa3nwOiYZVgLde9/5HBQ2hzrw
 uuXU2QBSZdHVPJScIbZMZ9yiDN0eaQsRJ2zsqQdMIu1Xnf1qEiPurx1+viQHjL0nQicN
 xbhR4+AIQVdjfcUW0y/avRJ2RwPwSNv7IUj8ZNXvmt04DRpljwrbq2ALr4WiXoEnZBCN
 256w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788286965; x=1788891765;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WxGcqlMRe1h8rufChKdnipJn+gFcVL7ZCJnaWhoft5s=;
 b=B98G9665cEyRaZmr7bmB4AgdcTVvBpSxX8l+SbTYqhj0q7GdQ6BGXvpmwlrCl60hHO
 DnUtbtrVty5t9DR0zViVSW1V426I2Gzk+IB/HMr3o3lZ9VT/0/izrAOo7i6eC64+VefB
 /2IsdScpcqW1oedr30hSI8QYllveTsE61UWv9Vfm31GBKzBX3MTT9sS4hGOt7tYDrSfq
 5uVpFcjZ7RfTcgH3WHU7JzqrcHunyi3Mx42rM0kP5gOIsf/V2ADgFfzRMKPbLu1NZjrr
 n92lOo95sNup/IWodDTrPK3kiJ9V4vNFsve7c97PK+ZEWW306zqOLDiGjOxC31RK5Ugz
 BXIg==
X-Gm-Message-State: AFuF++lm45429cFkyNMVn3sfRrswlvUkBh4hD7lu43iXuCT25GI90dVC
 9HVdCImJHBgym/o9RF9Beyb+vUTO8QFK5Wf0406T1gkGbwFus3yOgVCJ0BzGB0R63LnajyM1B22
 t1D/eDDEmMFyjW8kW3Y00EgR+R5SXkszcaNJXePcSf/kQRIp74WGs4KSn8g==
X-Gm-Gg: AYBFou2tRLRa4IZ2z+fAvutd3c2OWzi6RkKeWLvGIQxLu9UsnaUyVos3uF38vadLm3/
 OPEdwoAZ2h2MsAa1oyw/YT0EvynbzLQpwTlhPnNueiWMo4xR37Cy3CRxCBRmqs25EyGeSCKj4by
 oPzeV1OwCgumluEpo3ZrroD6FYB2Ctqofinwx5Ur5fc/OFrtkTWkrL0CsRUOJMg98GzF7dtV8fF
 /opWEwx9xxdCygF1WgvMkC7ZnYCmJ3keG/qHFRlpkftdUU/DbLP90m6uX6vqrMdd/azmxDCNjkn
 8egpTmpz9smhbNeJUrQTt0R83+nVdZaQLyRlMjYHMzRnGo7qyW9VTjRpGJZ1r1PKG3awYvVTgbR
 h5hfKEGuhmVYLcXQiee7bZ6IDiW1mX/R0BaYGJEBhlGBA7bQ3IhrFJ+hnJHIpC3UwHyFU
X-Received: by 2002:a17:903:228c:b0:2d8:d4d2:d13a with SMTP id
 d9443c01a7336-2d95296ea94mr71613285ad.22.1788286964819; 
 Tue, 01 Sep 2026 11:22:44 -0700 (PDT)
X-Received: by 2002:a17:903:228c:b0:2d8:d4d2:d13a with SMTP id
 d9443c01a7336-2d95296ea94mr71612725ad.22.1788286964359; 
 Tue, 01 Sep 2026 11:22:44 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f077fad2dsm27105eec.0.2026.09.01.11.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 11:22:43 -0700 (PDT)
Message-ID: <c3a1b237-36bc-4150-8aab-21aeebf22273@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 11:22:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 000/105] tests/tcg: run tests with meson - last chance
 to review
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <878q5lugc5.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <878q5lugc5.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE2MiBTYWx0ZWRfX2BQsae58OMw6
 K+UQr8q9w7HpnS/EhT53A4MJXxarpSYik2w7BCkcsovzYiM6OEfT/1BHXX6YWXqWXbmyHov3t1q
 8wiW9OCbPGQpJzo/zv7aXtAcB1OBtCWyKoZdjXIGIMIYbFhp2svCr4k4/sIvBj643x/yKhAfO8X
 Tim4seHAkf+St7/zu4BSlzjDmIBY6wgc3t1W9y16M9+vLauit9CMr4tIGdgdVpoLXwbwMxnWQBm
 250QINwf11lFDN8v2i1MiIJEwLn2B8Z5Wtn/8hniv5O0b7Yc2Z3a6cC3FSy0EhRWm2RZlJLUA2t
 gemU+D/zyGgOY79FjAK4pOMgnNbIsQtky2F4QHufS6XgxXTHdSNEdcLmtlT/f8kmkMad3zw+J68
 b+Y7ykjKEu/8O6DUMErl1VGzaa4zfvym6bA8p/PbmONw5imfe4A5KBubH+lrRB+qghuaQ8U9cR8
 ZXYIVbIlGu3kUNV5wAg==
X-Authority-Analysis: v=2.4 cv=L6ItheT8 c=1 sm=1 tr=0 ts=6a9717f5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=HwHlEJMHbfk88DceLFMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE2MiBTYWx0ZWRfX6u18T8NMLBXa
 Dzj9OUx6jwcTrkJAm6XFKTM8ptTr1TVa/W3t+eXqVCHTXHL3XPo6wqByi9L1cJ3tuIRDAz05QC8
 5B3l16XKLRAEdnyII99vMzF9N/hjZeU=
X-Proofpoint-ORIG-GUID: yErZsfV5BdczyLp5XG4S0CtS4PCe4wF3
X-Proofpoint-GUID: yErZsfV5BdczyLp5XG4S0CtS4PCe4wF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010162
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

On 9/1/2026 8:44 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> This series replaces TCG tests makefiles with meson, with the
>> goal of having something more readable and maintainable in the long term.
>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
>> them with meson directly.
>>
>> It covers all existing tests for all architectures, including
>> user/system/multiarch-user/multiarch-system. It implements all requirements
>> listed on original thread [1].
>>
>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>
> <snip>
> 
> I think this series is ready to merge so consider this a final chance to
> review any architecture related bits. I shall generate the PR on Friday.
>

Glad to hear, thanks Alex.

Just be aware it does not apply at the moment (since yesterday), because
of armv7 flag added to tcg/arm/Makefile.softmmu-target. You just need to
apply it an anterior commit, and do a git rm to go past the conflict. I
don't think it's worth respining just for it.

I'll be off next week FYI, so won't be able to help if anything else is
blocking.

Regards,
Pierrick

