Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F99C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtSeV-0002Sw-92; Mon, 10 Aug 2026 12:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtSeR-0002SN-5P
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:14:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtSeP-0003AR-Ay
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:14:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGEFkh1391595
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 16:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g9Mj599jjx1YWKaY/HSbQZqoS7h8RktdVnD8WhKR12k=; b=YzZAUpnGt5EHfzCd
 FkN34tG14BmHeEErxoU6+OUcvH94474xc6UwBKCNFlzii0OB8Jt68gMZfOCEZijj
 fieOswDwmrIsbWanEwwakjeLE75/9IUMXD8kcpTxICn66YeROAsBBlOOqkSw6VeF
 bcemX96yqPyYq9tAd8DJL26XzPVe4V7G4b3dgYGBMJhXxn9YR+BPinr1f7BZkMUc
 SSD5scrN/nTUSXBLBSE+Upo7OXm0aa9f3YYorlYjivnr7fOjKL8X5rxKXu0u+XlX
 GKMrJIDM/w+AR9xreZY96KpJGW97fsMV1YFMJ6bRCZRloEKYxTvWKiLTFSXSEdOA
 2ZC0dw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v92e8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 16:14:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb4bd11ddf8so2586382a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786378494; x=1786983294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g9Mj599jjx1YWKaY/HSbQZqoS7h8RktdVnD8WhKR12k=;
 b=U0KQWHMVIpTxkOYfUxGubDBY829Nd0A4rIonMxcUq3/Ek+31CzuzHg+D2hsp/+4GQ0
 d8EoTxethWe270kpCnDe3CGw4TAdfnI02LOZx5cISLhnlqFFb5HCW+pev7VBAjZOk3Da
 Kwat0a8WHV4mwMqGoMHQ1Xp1SaHoMHbvLirCG+tLat7UOvNVBvDPvvGP2ThuEtc4vX7F
 ZaJIlkGZbm+cq/ODgM1HCGWPJ/dFRwcR5PewUrc89dHWGr10iEFQEGKbHqb5MWkU1TMX
 5wXYIjuGVeYOAIUmRbzKqOePzfQsBHOgZLDms9S9QK33xYgblJddFXZWYMEEi3E2kLP9
 MAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786378494; x=1786983294;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g9Mj599jjx1YWKaY/HSbQZqoS7h8RktdVnD8WhKR12k=;
 b=X8kWdlBZZlWwOGkZxacmv/8lwXYEMq5lTa9fi7Fufpkj1Oi88nora4CN9xlByUeMXV
 bSZvq0bE2v3N1uRwpaycm0Q5+YXUhHCkmpjbbQ72ynwxu2wbtUfA7MJuevH1DprEeVuJ
 hONceZ6yt8dHvropAUZNBh2W3ScygbnFFl2u/9gs372s1Mg/CYbSCI9MFUxFHqQcwLrN
 bx9YnkmL+t2jGRL6CiGoLCPYIugbTjhK4J4uLUGqwPJh7povNkOGbXvwRj6Xe1vy99Ni
 KlKJfLcSrBT0/pCwX8sa4LCDGyFKQf1DMrOgUZuNTaw2+EkaNYUkrQyn29SjBHo4VQ+4
 kTEw==
X-Gm-Message-State: AOJu0Yx9asf4L7hr2m7RdP8HCpmBj/IabjMQEO3ofznsYZpvVT9XXLBi
 sZ7PJi4vwX6H5mQJKl2i090B5vK6zY6oSdV0giHxALA0q/caVZGH9zgDlbalgD/R/VMqtR/pXA6
 j+w2Sbb+nuaFfb5AUaOef5rvI+SX3blIADkDhylkWQQsv5sembLCPMH7rDQ==
X-Gm-Gg: AR+sD11qYBLlkJvUHGz4lzxeISjhotandCz0yh7CGqbxc7z99aaY5dbPnMMgvsyg44j
 TGsuwR2+iI7Y9aeDWD9M6zORsiLEnjtD+dyob8z+pxAC0qIT9DiF61lGfh3FUW45XZUwF35mnx6
 yyxkbsd3rRLF2L9oH38sJaz6W4esh4PbKQMov2gqknpNp6C/6nifmZjSYxheDSVOjL1m4fFggLe
 fe7aXsTOj1BCMFoyiOsHkWrz/SnCzpWZUoWLh6Q6579CUdMDkZSOucJDKzEIK51ApW7bav/lKsP
 M7P8vdl+0D3iHt8+erG/XFFnJ69delwmRy1RQ6chKkQEdv7jsH4VqnmvUu3IeVK3LdHa9rrsctO
 Ai/+BLmfWEINHk79vN5qcyXatyEGOgpfzT7tVJZthhEPWc85iXS4cV+shKRBIl1fW7PGK
X-Received: by 2002:a05:6a20:72a2:b0:3b4:605c:2163 with SMTP id
 adf61e73a8af0-3cbce6cad62mr23294745637.4.1786378493877; 
 Mon, 10 Aug 2026 09:14:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a2:b0:3b4:605c:2163 with SMTP id
 adf61e73a8af0-3cbce6cad62mr23294664637.4.1786378493282; 
 Mon, 10 Aug 2026 09:14:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm35750644c88.13.2026.08.10.09.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 09:14:51 -0700 (PDT)
Message-ID: <070898c1-3ba5-4e7f-afa6-0ba2099badfd@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 09:14:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <CAFEAcA_h7t7hF=i0xSh1DLq9Dmy-VL+fBa09R5RS6BOTFXLj=g@mail.gmail.com>
 <e4f25ac5-2817-456e-9ea7-f03ff8f625f3@oss.qualcomm.com>
 <CAFEAcA85VMpWbi1y_P7ScSLBRar4AnjVAzi1KLyk8GKH0jNUYQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA85VMpWbi1y_P7ScSLBRar4AnjVAzi1KLyk8GKH0jNUYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzOSBTYWx0ZWRfX59rz8fFI9Jrc
 ZVcrMKJqmNM5vi6uSRpl/uBTVPgJxePDj2IgP+QtKLTlKBpvvmofe4v+bebyQ/SKQHcMMpCobWi
 fhTKojGJYFMfXDWD2GUARuDhrGNlklI=
X-Proofpoint-ORIG-GUID: hSCA3I2Qw78OYjKdznzsIrhbK0bSY5Dg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzOSBTYWx0ZWRfX3VxYFEnp22yO
 e3lVS3nb5RrzM/2GrS0ccf+UHpV4MpeCD1w1IH2/jmHwpOzUy6z33InGyZHqEmUjus15aA4lCHp
 peYv55wKzZgvZPgn7+8Py2d4xwr7Hhsj0FOqqIknBtvCT7/8/ysy0Rysfq0Bn5WB10H0ATXFLTm
 5AdSTEbl8OEkILbvEJHQzRi8oSIgvsaQFiy1G+7inmP711L+6uoxuxXVNJ05zH7uxenz3Sf3P3d
 pYoCY9zD1lpDb7BqAWtK8nxiDbnUy16jqTCxaPMzWE7n44GV/1klwin/KANjOXxgRi00d4RQl7d
 f5EKuQwGe4FKq6iIJJM0EXU3VA9axdPnwKIGOpIDhAWy0cvqIkAnnKccVmbSUnnB96ajuFM8rgT
 9ujtprKhC7r5uUuNhr6Nih0Sq1n0pjEuZ/LofNhIWLyjkUfI7FCbRYXtq8uM3Grp2skbrMa0xtV
 aLsc+SIQ5WTCFG+rIrg==
X-Authority-Analysis: v=2.4 cv=T5m8ifKQ c=1 sm=1 tr=0 ts=6a79f8fe cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kwPjPhiR0R5Vz32UExAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: hSCA3I2Qw78OYjKdznzsIrhbK0bSY5Dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100139
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

On 8/10/2026 9:00 AM, Peter Maydell wrote:
> On Mon, 10 Aug 2026 at 16:55, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 8/10/2026 8:46 AM, Peter Maydell wrote:
>>> On Fri, 24 Jul 2026 at 01:09, Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> Now that we can link a single-binary with at least two targets (arm, aarch64),
>>>> we want to make sure that we expose the same set of machines (later devices and
>>>> cpus) than target binaries. For that, we implemented a static filtering based on
>>>> target interfaces that each machine will implement to declare which targets have
>>>> this machine.
>>>>
>>>> However, we discovered that this static filtering is not enough. Indeed, some
>>>> machines and devices do not depend only on target, and their presence can depend
>>>> on Kconfig or host/target combination. Thus, our static approach can't work, and
>>>> we need something more flexible.
>>>
>>> Do you have some specific examples of where the static filtering isn't
>>> sufficient? I can certainly believe that we have some at the moment,
>>> but I'm curious about how much of that is "just by accident because
>>> ifdefs were the easy thing to do" versus when the filtering makes
>>> sense for avoiding showing the user things that won't work.
> 
>> As you can see in the series, machines nitro and x-remote are concerned
>> (they depend on host/guest combination - summarized by a target config
>> entry). There are additional devices I found also (igpd bus, plus nitro
>> devices), but I wanted to validate approach on machines first.
>> I didn't observe any cpu (yet) that needs this extra flexibility.
>> This is only for arm/aarch64 combination, I expect we'll have other
>> cases as we add new archs in single-binary.
>>
>> Also, there is a benefit to register *all* types and filter them
>> afterward: we can identify conflicting QOM types with any combination,
>> and not only depending on which targets gets enabled.
>> Finally, this approach is much less verbose than adding an if (cond) {}
>> on every type_register_static location.
>>
>> Do you have an alternative suggestion that would retain all those
>> benefits, but would be better in your option?
> 
> No, I'm not particularly strongly opinionated about the approach,
> I was just trying to understand the background motivation for it.
>

It would be more easy if we could expose the patches we have to enable
the single-binary itself, so people can test and see what is the value
of current series. However, given reception of such patches in the past,
we decided to present them as the last piece of puzzle, and not before.

So we're trying to make sure that existing targets (arm, aarch64) have
the exact same set of devices/machines/cpu, before adding the machinery
to build and run the single-binary.

> thanks
> -- PMM


