Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE42CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWd4z-0007mY-TX; Mon, 08 Jun 2026 12:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWd4y-0007lo-6w
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:44:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWd4w-0004Bf-L4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:43:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658FFoqN3934854
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 16:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iP9LH8QQlSpBRaXty6QclGgN9Ld40vbVmjmuZmedtag=; b=aue1nCaSck7oSECY
 IrJlG5mwJj1PnFz48Y+8uRgtAgdEspnSb7Mz4KiKLFyz0tMqwTLtuVMbq7Rc1ygo
 vNUHIJeoHugvsxItl9lLiWkdxVM8ZgFIAYbioHFKY/HjdbP+c0V4Da5rrsOONBhE
 5gey22yD7IZU+RvfU+SKe6u45wjgridWqRLG9S2ooCKn4UBiNvDgg/Jb6E2SCDTH
 1R8v4WNvZyLcDdBfTns52B8C0K0k7u79tRNTFQ+4+e13D5Fq8VVI9F1vNLxqtqja
 2NOqjO2703mndayPzKuVqGDXSLZidW3FZWBjb7Sx7uxOpJIRoI6NFQJ2MIHJ43jz
 6s7dsg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rs7ej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 16:43:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ed777a96so2882825eec.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780937034; x=1781541834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iP9LH8QQlSpBRaXty6QclGgN9Ld40vbVmjmuZmedtag=;
 b=Otkhl8lJR8znnncVu+/4UbhzjEg5WYsCTHph2kvGcxg4Qx/8Ak0TzE4yKonVtMAqjA
 xlV66DlB/dUOYGF1qFD4AE72tciUDC6tniseOT818+I3zWcYexfBpIBrKKdmWDB6FP7+
 7B2qIZavc4zUkXaoszQmWs1pY5R3j7Wcgf/wGJype89P+/Vezf4ctg0jo+ZEPArq/wI2
 j1OsCX07yeybL9hZ1bJsC7IHAfdMUA22MkY9BKUxW1Kq8cEXxrM4XiYKnz4nEKflrDby
 tPdM4+GsSL0ZMzAat7/dqw9TswTnW1fbnkBcP0V7Hsr+TsOC6wOC2re5AI+uYjEu9yvd
 wQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780937034; x=1781541834;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iP9LH8QQlSpBRaXty6QclGgN9Ld40vbVmjmuZmedtag=;
 b=XKADrot0AHMwHbnBj4SxF6gB+w2ElQQvJN5k+4tHdWj5QCdjoOCm2YQyandLjbt03s
 LSjxVlSeRGtT+N2kZFr+LV9yWUMDGleD3KoIf9IpASYUAxiXhkoN6xm/Ci/zjYLXt5yA
 +JKJ+4fMcUIeuKLozyD5yLb4/AUJr+86aPkETG7oXGgGRpiJg/M/1j0DnsCANPkd1aHc
 jIkb5Qpd0CCalesE6si/2m/l8VAZAX3mbSGDcteaUveIhzv4SDJii5CQp47oB4C4KPUJ
 Qd9DzH3ZVZ6DA2EJH52PhcfmcBU3ZoaLXX76TikkyJDyEH5F1bu9G0+VbL+Foy8mKGN5
 Q/zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/s7x/7tsp2yxWsXzwRX5I921ZR4Qo1yZvYItPR4pkCBrtFKKnALWg1MIO0DnFJtZ+LqqWn7vOUZomC@nongnu.org
X-Gm-Message-State: AOJu0YxmhF+7GO4NXUconhufvOMmdJ1A0nOyT7rBl2vtFQ+oDMFlbGZx
 hMEP9F9CN+aU6X5YlHLUMxnDcYsGpfLY9qCPxsvSINQsjEyYoQ9ZBHjJxXNneNpcDKZRivTdiEH
 uLqCN4Stvh0QjVHbEq5eu83brQD3BSIOXiHLnmwJ/EG67SnlS3i0BkpyCLg==
X-Gm-Gg: Acq92OHu++q3roEXgHF+RvDq4bQrTPScfs4fq3vvyYNayL4tkfdQeDL597xXe/rpXPb
 qDhgqlXNK/b29Rgi3iOOOLemcJOU/VXhTBt0K2H0jEDlUJ5jFusYFglJX0yZ8sFToxpFDXn8IJQ
 +pK7Uf1WuxKFYcCrKOw9pL0FyZfyjrshRiocsndcrVgycbw4dQFo95RFtiBiFwhFjuo9FL2z+Il
 71VXJiO1CrX8DrRup6Jvni4QIYJpX+AI1c4SYW0M7+ScejyCmRV+m6tGbFXMqxTZ0gX0L5Y2H/n
 MB4DA38QQi9kNH+Zi2vvuZSyGsVF5EsAW6HrSEUh4myLX8lceL8oK3nBBR/i+x0YB9hSv+RUT9e
 UFV8VHRtmuK70l4mkzgceWM0EpI0aeTfKaaTFWfvNOnRUgLpN4pogsYPodFEKgHZpUMH/k0E1u/
 Gs3uR+GtDjlE/rjQCCzJ5lFoTb
X-Received: by 2002:a05:7301:db08:b0:2d2:d5a3:e97c with SMTP id
 5a478bee46e88-3077ffb5107mr4322380eec.12.1780937034141; 
 Mon, 08 Jun 2026 09:43:54 -0700 (PDT)
X-Received: by 2002:a05:7301:db08:b0:2d2:d5a3:e97c with SMTP id
 5a478bee46e88-3077ffb5107mr4322354eec.12.1780937033570; 
 Mon, 08 Jun 2026 09:43:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df77a0asm18795872eec.27.2026.06.08.09.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 09:43:53 -0700 (PDT)
Message-ID: <87a61b17-7200-47cc-bdb5-e8763c6c010a@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 09:43:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: strip macOS "-unsigned" suffix from binary name
To: Peter Maydell <peter.maydell@linaro.org>, Emmanuel Blot <eblot@meta.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260608-testing-macos-v1-1-42774498936f@meta.com>
 <CAFEAcA-aNmOmjhbVypCLpDVowTeSK-28aaY5X0jqRe32qmkqUQ@mail.gmail.com>
 <aibhMPHu6nbBT3Yi@redhat.com>
 <CAFEAcA98r4DxQbB+yiWKqnTGSzps+GGQ3gxFPLogBGTXY77jXQ@mail.gmail.com>
 <CAMdbysh2-mjxmWZcfDw53UbJd0keBtTgO_gnGc6pPMzv3GOPDw@mail.gmail.com>
 <CAFEAcA_WtRMz93Y7CrGW0PDTzoA+jXtY-4e0AgYXemCe4GG6RQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA_WtRMz93Y7CrGW0PDTzoA+jXtY-4e0AgYXemCe4GG6RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3eOscfr_hguBMjBFzEwJCFiPvL7sRIF9
X-Proofpoint-ORIG-GUID: 3eOscfr_hguBMjBFzEwJCFiPvL7sRIF9
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26f14b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VabnemYjAAAA:8 a=90BsCYJaAqXSNwoB5XAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MCBTYWx0ZWRfX1qnUmYqaYjfo
 8S9VhyVWJi9Ip+FDMEtn6lRUXQ7+XiW0f/ccqm0Du1B6Uu9uhv9Whhvi3hn8Veilr9ySBr9fR0f
 UrJbBQX75N5FwTcUaIZQ3WqMh5GgVm4ceEXzkE0z5qQkLBa2p2JMzAig1jc+pnieSQ7tpUADtQe
 Lva0RGENd7rqKcnOmGfJqETitOotkIJLv1V33RJTvMa70Ml1F0cEZOGvsYKRoPC6QxRs4FnOdQ/
 nkfOwLKJeU4rt9icb/yrOnN6wNVKUAF5hwJILP5pvHN5YzaE5oUeO1729nJgpu6U3xg+XVWFAYe
 2NFcSQzhOdJ0FeHjHATE6oCIENqX2poocLv3YKkPKSZrIg4+EfvWq6XMW+K+heOrydxIvYO3elP
 6NB+K9hiOht7KKMcgKsLI4oBM8wzAi0EpMCNyvRNba56Q6lYxvQvQlYHhC2ZOl6VyoNW4JLCTWH
 h1biqCX4i/vAUgZr9OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080160
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

On 6/8/2026 9:08 AM, Peter Maydell wrote:
> On Mon, 8 Jun 2026 at 16:57, Emmanuel Blot <eblot@meta.com> wrote:
>>
>> Ok thanks, got it.
>>
>> I need to use `ninja -C build qemy-system-arm` to generate the signed
>> binary, because the default target only generates the `-unsigned`
>> version (I guess this is the linker's default output, macOS requires
>> an extra signing step).
>> The signed version is defined as an on-demand command which is not
>> part of the default build (`all`).
> 
> Right, this is the bug that needs fixing. The default target should
> build the signed binary.
> 
> -- PMM
> 

For information, I recently offered to Alex to do a rewrite of tcg
makefiles in meson natively. It's not the first time, and certainly not
the last time, that we waste hours/days debugging dependencies there,
this has to stop.

After this weekend, I am close from a proof of concept covering aarch64
and multiarch tests. It fixes any issue we had with dependencies, among
other improvements.

So hopefully the fix for that will be to wait for the meson version. If
anyone wants to spend cycle and fix existing Makefiles, feel free to do
it also, but they will be gone at some point.

Regards,
Pierrick

