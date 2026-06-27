Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4078EC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 07:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdN1n-0007HN-Le; Sat, 27 Jun 2026 03:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdN1m-0007H5-2P
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 03:00:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdN1j-0001iO-Fd
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 03:00:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65R3jYac014263
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 07:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GVjJ1XY4gBvRjyjVIi8ix3Jte5BtLtfLPVpB9OgNuP8=; b=Rc7MCtv/O5tuxVmx
 8MdpCMhkXYHO6aceB46eyF856AOZvZOmqbdfh7pzKhgjnjn6ISAiCYtlOdxLRckd
 +yOh/+SlpwSnroe7qy99JCqT5aOcoscTgstMoLqQq98+4RFa4vISOalQTHxWE+mM
 Krzm3bBO4Bxkw7WiAifpD5IaQDkAkH9iYRT1s6lsuU7LddeMx9If5OcMAEOM49OG
 H8gXGrC9xChNC/eBGCLvPl0Rsfzdr+i04dt8mSH/Gx6F8khChx/memJ9Kah5L2dk
 RRw6ClkUG5sauNrHq3WxIgxutiqvBupEhkMG701gvlQABA1hQekfKqR5fLhGZ02x
 Fxx/Fg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6ga48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 07:00:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bccca5620so2411616eec.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 00:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782543628; x=1783148428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GVjJ1XY4gBvRjyjVIi8ix3Jte5BtLtfLPVpB9OgNuP8=;
 b=YIdpIjx8W7/uos/Q5QTkQYwXyBJIvAA8RJfXXfs+yTsiGu3JPJW7HI82xTKFcC9Jc/
 +8EqpCCss6adxpkAroDEfqt+vhhciZB3npN4jygqqY6gCIWOcaX7LiiBUUv0mNNYDpzJ
 xYzDpwJfeZntSJ46qjA2gJXifXaAkesRHrn/3coxNu87cuNDx9nfsRcE1SagfAgteenK
 i3+lvd47uXicj8NyzZpbtRZ9kU6u/o1M7GYdy19R+pO1Xc3iOlb8604UQHmerldp++2J
 5s5CCwP/dEvaNafONxcQeT9C69bT+XT09+vBy5PW4wQ9EWBu06MEJ6upGUdI5pVlGaQB
 Pp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782543628; x=1783148428;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GVjJ1XY4gBvRjyjVIi8ix3Jte5BtLtfLPVpB9OgNuP8=;
 b=llUhdsuMZIZliY2tW9fKyiDCEnCqbElvf6DJmCidrYOhvW1IFUNQ4b78JYg3VYVUqK
 lVd9Vly9zygV+bKNlBBbEkpZqDB8HEFGR2lUbG/b2SVMmd6WlcwxhBwW/9n95MZZBokk
 H8FVaQj1XQ1/Z2HvcRsQP4FI0LLwmOtRWRuYKWpnzY+GPsYcQV6/8AWlP5DIiDGMjmEH
 YOf6oXLxkOiZ86Ogo9DbA9T10zwW1zscSi1iTU1F1TCjAyjPN64bidSWanbT5vV8syXU
 Zloc5ekLiTjK+rs5S4K+4sCoPfaO1KbVoo4W7lX/tpQha70fNtbHRN1mHRg9OA1Aae2i
 iTqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCeqeSoJ6S+AJh5gzOEPi6eN1FFQe5BYkplYZg/zoJf3RZq1Ciy3UrrMxZNrCazr3aH3OWaoa+nscl@nongnu.org
X-Gm-Message-State: AOJu0YziI/5HZeeeiz2U9VvVW9EHG9+2hWvFZWvllKelXDDhOnYz82Pi
 Yp7Fbbj4RR19DCoEjdlN5uWy8eXZDbFSmfB7NF4kdIoTD2OhbGESD6FtP3bY2Srx9FDTLjsadkB
 S/OY1+0vaJkiWbysxUDdlQxEQFEX+ZqgWGsVGuuLsnRm7jIDTY/1ijM9Nrg==
X-Gm-Gg: AfdE7cnXGjQ9gLpeLQ7AszmkDcTUa0ZDVZa0c3NFgnUZlhH9VgI8jQvpTi9fD6Mf2Sw
 AoK5hqs+pM1ZJjR+EXRWYFi25f2LtP59xHdLjSzgjolQMKxAA1jtPvzpsjnydoi4UO0y+jnl+DM
 Zc5ZY5pGX/b8+e1r06NwLGdsNR8BTjQr1gzWCgcxp8QB62FRakLd0IN/WeAr/nQJmKcuy7+7vkP
 FEhhb978R81jerPefEMq8KdWwd4D3HnNsVkNn24BV742O921EIE16hXdWHUZhaB0ZWmipIA6MOh
 wBvg0O3QT5aP3VPT4O2HF5SI8PmIOwTDEYkVwqegEV6RNY7+E89jL5Ls8BMshG2jkJpbZrwU5BM
 mvib566T8TYytFsR7KGM9MhO65CqxqPXJ7wtfHXQCnqLaTld1O0Oubd9vQoK8Pt1UVXtV+puf3n
 Gjvu0=
X-Received: by 2002:a05:7301:4e8a:b0:30b:d865:4bd6 with SMTP id
 5a478bee46e88-30c84eba981mr9387525eec.22.1782543627742; 
 Sat, 27 Jun 2026 00:00:27 -0700 (PDT)
X-Received: by 2002:a05:7301:4e8a:b0:30b:d865:4bd6 with SMTP id
 5a478bee46e88-30c84eba981mr9387478eec.22.1782543627127; 
 Sat, 27 Jun 2026 00:00:27 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ca5f14f8asm10546063eec.6.2026.06.27.00.00.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jun 2026 00:00:26 -0700 (PDT)
Message-ID: <b10ed0d4-7a8b-4bf7-97b0-e4e973d392d1@oss.qualcomm.com>
Date: Sat, 27 Jun 2026 00:00:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Konstantin Ryabitsev <mricon@kernel.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
 <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
 <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
 <9d2737e3-34f0-4f68-813b-37059615bced@oss.qualcomm.com>
 <CAFEAcA8660BZOmX_KXeF7JJaJwgKO3zSRDEmJURg27FK=tqbZg@mail.gmail.com>
 <df4a5857-ec4f-4d4f-bc08-1a9c5caae100@oss.qualcomm.com>
 <0f2205d0-06b5-40ad-9952-e18a6a951078@oss.qualcomm.com>
 <fe77f7a1-1a31-457c-9dec-e1b49cd35371@oss.qualcomm.com>
 <d83a2e21-403f-4146-b129-4d9ee264282a@oss.qualcomm.com>
 <20260626-mustard-beluga-of-perspective-8dbebe@lemur>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626-mustard-beluga-of-perspective-8dbebe@lemur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6EWxoBPWXjYFBHK8BFO73mjQaAZOL-c2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDA1OCBTYWx0ZWRfXxw5qzoSVFA75
 N+9nEwPFkHKssAHljot4bvWqiaznrhU/V6J0QVHH1A74YTkeJN+8UCnhPFVxoZR8LWv8zMpAlZK
 CTA9OtRHhUMU61CBozD1c/778ysNU5Q=
X-Proofpoint-GUID: 6EWxoBPWXjYFBHK8BFO73mjQaAZOL-c2
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a3f750c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=oNgn5WDEn9JSsLHWEUcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDA1OCBTYWx0ZWRfX+CRWvUMWFT+B
 nYwvNxctXLdJm6gMuVoMp9U/V7zvPK1AsBsmM/P7BRdEGRJLlxfGkX86YOXvscJjHY7ZBpIYbTC
 j5CEvJQu6J10MvaxkDRip3Qa1dwPPL/mVjDfZKcPrImXtJcbQPuFLVLE75qyXw55s0Lt4M40uTM
 1Fe4mjOk2CpBQodCSb/0nMmpr0rPQQSoL3/+yZRU5aRRYtzOAnrh27lq1nPsmTvxko8LVardqBB
 ncVxf1UEGwE3CFtePplwkVJCYKMSUe+vLCwhdQwiewFRG6bsInz5irwcQcZxspX8iXputbkU6Z2
 opNFITu7+B5x3XXmDeDupprq5E//OplXBRJTOwghvGgp/90RkK9A+n5nGGeyAQ6hOPt/GVDEQVl
 1XFdpA6EK5UORzP/h9GWDLeUoEYwAKPKwY3399KjKBv7BTQBzQjjyxqPQcQC6PvkFM2936Ftn9E
 R+yacQZV46ZouIUjC9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/26/2026 8:31 PM, Konstantin Ryabitsev wrote:
> On Tue, Jun 23, 2026 at 12:16:56PM -0700, Pierrick Bouvier wrote:
>> Based-on: is a QEMU specific tag, that is only understood by patchew,
>> and no other tool to my knowledge.
>> b4 has base_commit, which allows to give a specific base, but not a
>> specific repository. I'm not aware of any b4 tag that allows to mention
>> a base series. It makes sense, series are not branches, and stacking
>> them comes with a lot of problems.
>>
>> So it seems like email workflow is quite limited in this regard, and the
>> only way to deal with it properly is to wait for base patches to be
>> merged, or include them in the series.
> 
> You *can* specify dependencies with a b4-managed branch, via --edit-deps.
> However, both the contributor and the maintainer have to use b4 to retrieve
> and apply patches for it to really work.
> 
> If the maintainer retrieves the series using "b4 shazam <msgid>" then, if the
> series specifies prerequisites, they will all be retrieved and applied.
> 
> See https://b4.docs.kernel.org/en/latest/contributor/prep.html#working-with-series-dependencies
> 
> It remains marked as "experimental" simply because not enough people use it
> and therefore there are still many corner-case bugs that exist and just
> haven't been properly discovered.
>

Maybe I missed something in the documentation (feel free to correct me),
but as mentioned above, it seems like b4 only has base-commit (+
change-id, message-id, patch-id). In the current discussion, the need
would be to specify a base commit/branch + a base repository, similar to
information included in a pull request, thus why I said it's limited. I
didn't see how to cover that with b4 or any other tool and email
workflow, and maybe it's not even a good idea to be honest.

> HTH!
> 
> -K

Thanks,
Pierrick

