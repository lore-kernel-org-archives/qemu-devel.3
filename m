Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D1FC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6AIi-0008PI-QN; Mon, 14 Sep 2026 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6AIg-0008Of-BC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:17:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6AIe-0002u3-HA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:17:02 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED11qf1028976
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 emJbJ5ijuzSQDilDhNi+QoCApC6uMZ50+0kTdRfJPo8=; b=nBLF6i7pjeI/Jw2f
 bmNNA0qiz0/aqM6/kIZ82buDUCkRa9XqO5UN1dXaGVE2AZ5bLQgDc+gklwxGzLW6
 N93sfPkeMZ0Q9uCd+euITa5EoCCeKmysTdhXSSmf/DG5noNjNbcjkoTgWnpLFPTT
 V6M9gl2HiBT03vhDZTXoUfwj/3+VPCLUyEFguyzO+MjlpWSr+q70guUK987UQWuE
 wqTPmJtuDqzI4d0GeP/RASWq7Bhkb6f/5dqwTpGzcoc/g/zo2B26+267GbK7CtPN
 TOHcaZKJ1bp8gZHQEEmWm19NEaF+W8MfgL0fz4unWgBhSvfla3df3IZVHRFTP8D+
 ytOTgA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5t6xp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:16:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d6f80c76e6so64611685ad.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789406217; x=1790011017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=emJbJ5ijuzSQDilDhNi+QoCApC6uMZ50+0kTdRfJPo8=;
 b=RXNw9Do/d3qemSIu0bhsnYwWVPGBrCQQuyuuNzA6KP3hYGwkISUgqZvMziL+O8LMp9
 2FMXxo8HH+VyVNGjUw54NrJZ9SqQ0cU+QOLw31lU0lBJ8x35EBaJGSqkcg/HlnyyHnOW
 FOK+H9UFVE4EsBhowDsqnxjWnJ22SR9CiWGySYJ1lUUtnoV8hseVbSG5c0XgRwopcOKc
 Tvh83H/D1DclkHJiggHJbo0L4MMiVkN+Fgt6jnYdlzN/spW6LlmzfgTPcdR+aoELrwlN
 y9JcMSBsS+7fH2MHlnkJJhtZK255oHBB2BfwWUgi/ysEf/7E/twoAi8C1asy13qoMrti
 10Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789406217; x=1790011017;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=emJbJ5ijuzSQDilDhNi+QoCApC6uMZ50+0kTdRfJPo8=;
 b=W81/WflhNG0ttyBkUkoKkW5V9cuR6jEjHF9Pa0ndlWj5+wvwHuoOmFpjaBLr4hjCgM
 TRNEWCxwdb6ztcxZNf4uAzRfEjE+lURXMe/QR34xyqBhzujeP4YK0dJgB7gPBftRm7Gc
 SKhbBI+9O/mr3itIkoOahKCFLz+5VP6eXBJcYjzsrdGTbFxv7JRcCSKHgscQ6HTptfXB
 +kjXIamtmuRJ7LqhrfQ50k0yzML77uv6fITKWer8bXiM4oosRwvzvmbh/lYU3tQ8Z98I
 hubEfLNDGBL7rY1+hbY5vIl1nwxzK9/inBYirGJUt+ucvaSRDdGyTWdQEGn5OxiK30qR
 Hxgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxekzN4rAZJXrXeLEsaI7JVp1EE0UXIeAxaU5X+V2V0CX9bRdQ01ZThOKhV9/DUJCi+O6e09Q61TId9@nongnu.org
X-Gm-Message-State: AFuF++ltkNkOzbZOz5eBKi9he3rn2lyCDVu+2nAkvfJD50yrK9NEhrgN
 c8pnzCQcci82jzlJTt7i5tP8qOF65ko8pQCaPQQu9dRhzJf7gfOmsSfjg0wz4NmU7f34U+HFKKO
 fjUNeCVU8hVgw6pLx2PYAMsICvgoDKXgGrlq1klQSibbzXd3DNXIcQs/Bgw==
X-Gm-Gg: AYBFou0c674U7p7ciZ7cBUIG1+99UeE6aGAmF4Szbcj7HnOfLDCRjSubWBEj4uNTO29
 sz7eOB7DbUrVh6peKqg1oAtpaCrADn9SB6wDIA2RY/sf95cXda/KI6BplmnAI2u2PDGdHTep7pU
 198I/6M9af6Zx9OYnt3/249FJUIm3Ky+1wi+G4oKAsWUgi8XB/VSriPcUr69Cslv5fWqsNcNepz
 s6pbopyS8qkrCJ4aaaKqD5xhLT8JRcz0L6Bs/5O1H8aI9EoRSDTDHp2phbCyH8grkBZLybS/jy0
 ew56C+2tWwd5xWwzgNpDvR4WglXvL9yMpAmaLvABjaGMZmZ5/94Rn1wWDRsZZYm5bJH5kVZKprH
 IPqJp5b8+VvV2/QXMBFwbQZl3vx6fdp7saQrIVPPYm5G+7+jA6FTMqFd7Cb7HSVH29KBf
X-Received: by 2002:a17:90b:1c0a:b0:39d:f5b6:ca47 with SMTP id
 98e67ed59e1d1-39df5b6e80fmr4442789a91.12.1789406217414; 
 Mon, 14 Sep 2026 10:16:57 -0700 (PDT)
X-Received: by 2002:a17:90b:1c0a:b0:39d:f5b6:ca47 with SMTP id
 98e67ed59e1d1-39df5b6e80fmr4442734a91.12.1789406216936; 
 Mon, 14 Sep 2026 10:16:56 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b348cbsm26711903c88.3.2026.09.14.10.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 10:16:56 -0700 (PDT)
Message-ID: <ccd9e4ad-2469-46f7-b60e-01c21fa99953@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:16:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0NSBTYWx0ZWRfX/lfyxXqXVD7U
 mhOtKms3ygrr4PfoGYMUQvYynEiw5NiInS8A5fE5r0+a/dtNqIiKfZYEvwEXcqg90yfRqOAejiN
 7blRq11AUyaOmHr4riiq2rn1JZjo6dI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0NSBTYWx0ZWRfX3uFzlaFfM7oN
 bKE+szwV0GE/z8+rK04g26/dPfmWnGeD8Prglsx7EWq9r2EoKydvIJcAspsbFf+W15uvBGPCeJc
 Qt3s3UM7DDqddJbnCLcjDqvIdSJHJZ78nK1XXok9KhvgzFauqKw6lUz4Ns5LyR/I6Ni9ESoVb+S
 wDcvP7hgpJ4TEo9CuxQcO9FkivOUret8yySP6WD4cCK/37pBOMKZflI0c84849tzu8nXeO0H0U4
 r94YEWMqsfv8zrI+07tvZfOfzP4/lU/EUla7Mumdo3unZcoCBhWqjTYzibOOsQQTfxXZluwPKPT
 Em764RVCsZCELNJpFC3RXUa8dBhHgMzLFC0XNtbWakCm+865vdVQ3s6SBptr/zPqwETbEjmoLa/
 ls2gjp9NMbQcLNGSqL+3JbH2yRyhtp2O5sMI474QgiE/FHuvS9r5J+y4oAJ+cLdCk1udWftael/
 NxDIEqjHHyqJQFDU2ZA==
X-Proofpoint-GUID: jUDVLu_QJ_ONF4UWcWMelM_nycem3Cw5
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa82c0a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=5E76znJ5OGKFSMxzBB4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: jUDVLu_QJ_ONF4UWcWMelM_nycem3Cw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140245
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

On 9/14/2026 9:57 AM, Paolo Bonzini wrote:
> On Mon, Sep 14, 2026 at 6:13 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> There might be some confusion with what the series introduced. To make
>> it clear, it does not touch, nor use tests/docker/Makefile.include.
>>
>> Each tests/tcg/arch declares which container it depends on, and we have
>> tests/tcg/meson.build that automatically builds it if needed for tests.
>> Reverting that will not be very easy to be honest, as it's a core part
>> of the new logic.
> 
> If it is core, why is it patches 102...105?
>

The container build logic is introduced in patch 28.
Then, in review, it was asked to honor existing configure options, thus
they were added on top. Same for cross cflags. (patches 100-101).

>>  > IMHO it would be nice to replace tests/docker/Makefile.include with
>>> a meson.build too. Yes, that would make it rely on a configured
>>> build tree, but IMHO that's an acceptable tradeoff to get more
>>> stuff into meson natively.
>>
>> That's easy, and would allow us to get rid of
>> tests/docker/Makefile.include completely, by adding matching targets
>> make container-image-debian-*. Also, we can have a top target
>> 'container-images'. With this, people can build them with ninja or make.
>>
>> As Daniel mentioned, the trade off is to run configure first, and I feel
>> it's quite acceptable. What do you think Paolo?
> 
> The problem is that right now firmware builds are broken, because all
> the supporting code in configure was removed. I'll review anything
> that fixes it, even moving firmware builds to meson custom_targets
> even though it seems quite intrusive.
>

roms/Makefile find cross compilers by itself without relying on
config-host.mak.
If my analysis is correct, the only components that need to be fixed
are: pc-bios/vof, pc-bios/s390x, and pc-bios/optionrom.

If it works for you, I can replicate roms/Makefile logic for cross
compilers directly for those components, which would remove the need to
reintroduce anything on configure side.

By the way, why do those pc-bios components have not been added to roms
like the rest?

> Paolo
> 

Regards,
Pierrick

