Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C85CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPiS-0001XB-6h; Thu, 15 Oct 2026 13:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPiN-0001Wd-Sj
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:58:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPiH-0000AX-3v
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:58:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFXLQn3510589
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 flE7R1DQqwINz3XxEZoJTh65wklMU+8w+rSqs1H+usU=; b=NXaM/KH1vfXWXB/k
 By7VH5B8YRBZEy24YIdt6uZKV/RkiqR2UPdxqCgjcuT8hHaB6lObxyRy4pGeWyf1
 TO/XBDx1ET+yGHOGv1WmU8O62wABIOleZU51VoOyKpOQr0sbXtlnbUR3k6gNZwv5
 SgfE/i6PjuxRog3PUBehJd1yZwSKMx3/MPlHNd1+tEuhxbnu6FmpY2sEj9Kgy5YN
 naRjcUJBoOe9jPfByhM0dnhDVOjg24GW6kxyGWxXeZHitKzaPBtEAXFceyDbqt75
 DrT2YX537j9ryLFELJjETgR3utc/2kbcDu0eAfF8w62MMeUBzpDZTz6RXxXiLRNr
 2oyo5Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdsbbyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:57:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so7116790eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792087073; x=1792691873; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=flE7R1DQqwINz3XxEZoJTh65wklMU+8w+rSqs1H+usU=;
 b=OGgeA3EkUOw7j6RR6IEkhCY87xyUdSomUEJtRBjE2wZjs/X5/iNbNkxnPze6wcYe2Y
 CyB1Cx6RcKTWphafJ5h9PESPAJ0P6+++SiM3CEUNSB2iwpf5h2QRJcEZ1k/tMMIYiGjZ
 P75+6YyfBc7LCUKWeb0aQTu2JAMwBBn/VTjHAoM+ATyIoF5eStIqb/FHsLSxf6zWHPuS
 SOPjAmQKbwqsUWNYmGCQXaEWPuPOZ2a8x8IG4l6cq5Dack31YITA1eU7nzqXFzGSqHHb
 6lgDnnYAhOhfzqCQcK5rG2uqFz8nP8mTzBvamARlcOeiISYly4f7129QJ3AXvMwFImtf
 bSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087073; x=1792691873;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=flE7R1DQqwINz3XxEZoJTh65wklMU+8w+rSqs1H+usU=;
 b=yKYH2bP5fR46Hg5uxL1TFTcE9qjSIXe66quVYak9bzXpZXOfdLEDbggYDm1qBZyPDx
 W+itt8sBMvUyIxSn9TZog5dg+sBLmPXas2IxfG9+SCsY71w1F5rapy63efGRNWtmxSpK
 QuBFyLMp6QrY1P3i0RUC3iUf6ZhjcwN3svG+4Cx4WzHcquFSGTW7EVAlMI4Xh1tH5hsv
 LZ3QPlZjQ8ynA4aY9cCYSxvVt87oTfATXEawG3gw8AEvrrerlb3HGzI+LLAb5bjfdaZZ
 YGP53+g5SqgsVNlFeFukgcskQUarFNgV5iwGTyt8oRZUipH6EbWwolEBl3OC7bkmuKtV
 9oPw==
X-Gm-Message-State: AFq9FYKQvqMKtq2ucT0gt/Ax332hmFHzC+WFZUtvN3UmbtKnMvArIiAP
 DqQtREBxUn21+ELAizI96aWHX6b+fXn49e5UsVwAJc23dpbI5e5clqh2TsLzsD9OC2q1IAI50SO
 3oEGdkJYIFLdRs5iuSqepKXu1xtITgg/ShKlIGhHxTj0BiEkD0nZKap1Elg==
X-Gm-Gg: AYBFou3/hJJK9ZYS4tNy/heQe8VnNEjqwVRuBachX9VDBKNAZJiTYGa2Mw2YMBOv0jR
 zAasIImQQLnvpPlkDOscXNLZVyBGQmlbNa1h5nvt7/bmFOw8olu8roh7ylaWXvWJxMj4fgKpwIb
 1lEFEdjNE5rj7QV/ruGsZgi8UW74Dca0mLNLzZSIS+vOUiIFh8aGYF68mMBIPXmxi2rTkf0fv9Y
 fdyvf82dUQ6I23OJCVXRIBb2S19DB9FG/G5Ww84txi/UgJruNHW9UFH2jnN69ke+5gnwmZ2L+9y
 OTk1wfPElmF/Unkp8qIY9CcjFkUfApaSZTb6yXGE72G+lbbXFyi8M+kVMR5xPF4l1qu/tEoxUXT
 O/1wwE/rggRYBFKwD8bV/d6UVOgrpptn9oIcUNC5jlm/4sDgnqh1An2dhfedhGeI3+mOCew==
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id
 5a478bee46e88-3537e0788bemr36557306eec.14.1792087072788; 
 Thu, 15 Oct 2026 10:57:52 -0700 (PDT)
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id
 5a478bee46e88-3537e0788bemr36557209eec.14.1792087071744; 
 Thu, 15 Oct 2026 10:57:51 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3605778c624sm476021eec.15.2026.10.15.10.57.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:57:51 -0700 (PDT)
Message-ID: <e9807140-5a65-413e-be58-c3e268125431@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 10:57:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions
 duplication
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
 <87bj8vbj3u.fsf@pond.sub.org> <atCHfQ0g-FGMjlBN@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <atCHfQ0g-FGMjlBN@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R9IIWbHdCfZ-gZzu0AtRsyaPTeoM8jPw
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad11421 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=femL1ASruX3xrRhflhoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MSBTYWx0ZWRfXxxITH/d84RZ7
 ME04ZP/5lO59QbE3iUvxpOo3zUj9yg8qFwqc2/7CL9AfM2rv4iy5Fz8twuulMgJvLzAvye9vKGr
 KVtUQ9wn4iHSteKYop/B2wHADgAcZYh/9w8YaIxNB0VFe3XbFKSJFCsBbcNO6o19Y8DezYedwCE
 ohzSOAboW8Yc3L0I9GWZzFAOFporFM1TJX4zKlLQovEjw6J9MhDJgFSKUSzG6ZEBDbm41qFiZfu
 dhdk5wsLefuj9RkC0ZqZkvWyYtdQzWEMZp7evs2dzC6eAddfBcD7fm+2Q9r4BC7hwcd0YqVFDAH
 bmlk72C4c2rhhIJzITRgOe6IW+7fPHSivMoTNAYsZDkU0NtOvCMRpJNgMecErkC2W11VZlZwqxH
 0rj4paE0JLcVGsInGRytMmiSHnodu9ThqeZtk2neSIea1oG51dE3wieaA59Uop1s/vDweFsWzOn
 BVYWcALVMDI4BjXO+Cg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MSBTYWx0ZWRfXz+nChESY5rVm
 ZzlZOoRxtf32JYrqxv1oFvDJs0Zz6fR9sGocSOzaGEtZkV+nIpoJlwGAOIDgjOPAUBHK6ehKe/K
 EuP3w/HFdMsugHlqASoUl6NnDxl8yzs=
X-Proofpoint-GUID: R9IIWbHdCfZ-gZzu0AtRsyaPTeoM8jPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150071
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

On 10/15/2026 12:57 AM, Daniel P. Berrangé wrote:
> On Thu, Oct 15, 2026 at 07:58:29AM +0200, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> This series allows to link multiple targets that define
>>> qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
>>> target-specific ones and a single dispatcher. We didn't use yet the dispatcher
>>> pattern, and it's the first situation where it appears to be a good fit.
>>>
>>> A possible alternative would be to introduce this callback directly at
>>> target-info level, which I think is a less desirable solution, since it would
>>> ties this API to monitor.
>>
>> I'm curious... why would such a tie be undesirable?
> 
> I don't think target-info should be involved at all, it is a problem
> to solve in the CPU type system. The CPU definitions are introspecting
> sub-classes of TYPE_CPU.
> 
> IMHO the right way to solve this is for CPUClass to gain a callback for
> introspection, and for each target to provide an impl of that callback.
> 
> There should only be a single qmp_query_cpu_definitions method that
> introspects all registered TYPE_CPU subclasses. That way in a
> multi-target binary, the introspection will return info for all
> CPUs for all compiled in targets.
>

I was wondering if what we would like to expose is all targets, or only
the ones that have a cpu active.

> That would need refactoring of the current qmp_query_cpu_definitions
> methods which is a bigger job. This series as is, is a reasonable
> small initial stepping stone to make it possible to link the binaries,
> before a later followup patch to do the full refactoring to get the
> desirable API semantics.
>

That was the goal 👍.

> With regards,
> Daniel

Regards,
Pierrick

