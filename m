Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B02DCA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 18:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFcGN-0006dd-BJ; Sat, 10 Oct 2026 14:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFcGL-0006cz-3w
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 14:57:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFcGI-0008Az-83
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 14:57:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AIfxsV510997
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 18:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Om86OsmSOnxQ3rMISMcSDlcgHcGTvInzJrDV5Hxbr74=; b=I3HBZeHEGU3ieiUT
 110+b/t70gFnuhdX1x1t+xPRfvftN7TyY7Xvwl18mhRN0XDdDQCte3WvaWReWxJi
 O2CqFNnINjPprFP6+AKLWpQgppWC6u5pfqRj235K7HvioYE9uPwGyxJkCi4zQ75E
 e/3IUq3sb4eb49U2eNZ6wkGPRv6Zqk7Bd1zuxDsH673+ffk2dYjq8yoNOqpnJ9SB
 1WCO+ZsnivsknLCJjEk7leZrwNIpGaEysGh2G5uTChbWmiOF1Ukvvh5ex3CwIIfB
 xxgUWmaIq0AT+Zux14dVzAzlJMn0J5wYNeXe62M116AcgMNwe5f5FsSDIh3ZhRcn
 Y7J3bg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9sf6n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 18:57:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a7d2f25f65so2005202a91.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791658654; x=1792263454; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Om86OsmSOnxQ3rMISMcSDlcgHcGTvInzJrDV5Hxbr74=;
 b=JKvZOJNh2JwPdKND4cqCrgQv1XoJ1Y35YIbBjgDE+rqA6gbjDzKtXIyX+Nv7UihL8Z
 Kyp2qZTqoU8waoc6ZhE0ifhOaa8CG1jNFcaabQU9Kuugh88gJV5iVupplsgLsP2c7bBL
 TCECX8/p9X+5gIP1TWdtT9RJAL3rWZrZROA6xYzrKf9M89BlwtZycGIo9fmmpxC2wzFC
 12/wxk4W/8szWfNQGbWx/rkQcQELqf2Ma6q7cyLtUe2cgPOQ3k9Yv8MI2gs8xPaNJenA
 72M/vdqhfRbIX1n53zFmSafpeHz95367Y8E+QKVwaZ4/AC76q0Kqx86Zai5sIuea5L/D
 iUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791658654; x=1792263454;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Om86OsmSOnxQ3rMISMcSDlcgHcGTvInzJrDV5Hxbr74=;
 b=XSeASTnbJVW7ssQQFkeYSpez+2JN2+CfvA5VXj6HKMXNwtu5xwuYXjKcQC0vhmnXOA
 oPNjbXdzJlniV22JUPqjg4bzX7rGU1fjswvsMI/2YK7CS28w47uiQGpH+PeaxDD0gbbl
 Td+B4mPCCfqqiUBBYFKwBQyIsf3NiQjeCVU7/0xXxyfNwTjvpxT5oA/e582BBKw8RkO6
 urdpm+FpN5QzfFKnKyOTZeIr5EhBwQBgZNBu2iFbYjC2P4R9HCfyfG6YXoshbsuvIoAA
 E8xq3xPBXNrBH/uTRqSe/E7aO9VX9S83Z+nVqUYQktFer/9Rh5BaR0fzYZLtYu3hQIZH
 hm4g==
X-Gm-Message-State: AFq9FYLzEoT729mgzeuy7GLuVnD356Sxy0RyFB/zQYvEYMjic2sVvyII
 v/CRaok1brCFW3W/AI0NQVQETSjYiksq9K1542g6YsANkN6VKoiDvu1j6EGxQgnrueLdADhPrxd
 AhQ+8O/Lo/4TkCkG3El6qrczVuxB3aIgHBZq/PltjSo7nN50P9tlWec+VhA==
X-Gm-Gg: AYBFou0qgSAudiaWBb24HbQZAUZdsP8UlrL+jrm5vwA3iPO5VRJyTv4YFvhu/Fis/HW
 u3eHuwXPkt2JRo5W4Etar+QQpiy0vL8O92+btklRq4oH1oVijz7Kqluq9Kt8N11JlpXbhtdz/ku
 4rvYzN4D7m9aCeqU200avgOicI4xKrgdIunUO7aZWaNSSRI29gSF3P2eoQOYxo9x9d+xPa90UuG
 oRgFE+nNqtk9cWISrJtiM3uHXVSqyvVQLUeWysHvQQWRe+ORwRpqaTY02v2c4qexm4TAZLvJkVQ
 35F1RliyIiM82TdWDIuM2S6mnT0j7udq6KREE0JnjFgQMTlWsH2oOkP2FnjqIHTAotU4wfHE4at
 +o60je0vjUqoIlD9cWh4VTQKQIUN2dmQG6jh48wuvEff9qBB48Jw8zDSN
X-Received: by 2002:a17:90b:1dd1:b0:3a0:c85a:ee12 with SMTP id
 98e67ed59e1d1-3ab3aceba09mr3335436a91.41.1791658654409; 
 Sat, 10 Oct 2026 11:57:34 -0700 (PDT)
X-Received: by 2002:a17:90b:1dd1:b0:3a0:c85a:ee12 with SMTP id
 98e67ed59e1d1-3ab3aceba09mr3335416a91.41.1791658653829; 
 Sat, 10 Oct 2026 11:57:33 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371e2833sm9390660a91.17.2026.10.10.11.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 11:57:32 -0700 (PDT)
Message-ID: <79329529-5971-46b1-a8e0-1a6d86f10237@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 11:57:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] tcg: namespace target helper symbols for combined
 builds
To: luoyonggang@gmail.com, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Song Gao <17746591750@163.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260930073935.712-1-luoyonggang@gmail.com>
 <20260930073935.712-5-luoyonggang@gmail.com>
 <374ba010-b530-4310-b20f-65ada56cda6b@oss.qualcomm.com>
 <f8ea6e43-2e6e-48b7-a61c-d9ec2200872c@linaro.org>
 <CAE2XoE97kuRkF4i2+t=tH0d0dXWjCaNmUjUaVZDPekWimSN3gw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE97kuRkF4i2+t=tH0d0dXWjCaNmUjUaVZDPekWimSN3gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6aca8a9f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=daik7hMXr06KtmuEIbsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Jhu82W8QXfHB1dCFSXQYtKCftDzib8ut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA3NSBTYWx0ZWRfX5x054RjyA9Q6
 Pe404xRuHhNxz0rV0tf4QoNzw08EavlXUytfChRIGz1vkDQ09jbQA0llGCPGXuPE9db1exoGDYy
 ZqFBE6kkS8HdpwWuw+55rXPWS/ZdQF1fbtKIwNg6u4WODFSTB6CMKY6o+r5gQk3ynCE4BqDo0be
 IK0aLZcP9lb42MhqlbiBrtdUBudOvuRKTn8MRpFLVYsS4NBpH2IIo/Dwf5H1Fex7TxGwNjkpUpF
 FYAzu/9JU/sR6zdJxa3KZJvYTKndi6gEHIfCQ4sRd92cXlEhsURg7xAwTL7ReV5sjKmHLGTfCHO
 aeF8VnhyrivCdfDyAfCpn5r6nqyJozYAyCZFlnxcIXjthc5SdprXnqAvQCTm6wfJKol1vG1c8S1
 pKTpufU6PHfRpRVwWWNH7oKJEMZE0pydP1hk2+vYAsCVbhEm6k/FGZSqufAS4Gd8JYdLQjK3SyN
 SOrZp0agFolhXstFOKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA3NSBTYWx0ZWRfX2qWyjHFJnwyB
 IbTaIwyRTKHSwqe00zcDMsmsoGphvHJGztbCGoydmMBhCil6tIExxvmc1n3vo9pSCHca8BLfqL8
 7ZeZ2dzRNcwRJW45+wZ5eRnhlkAbIUk=
X-Proofpoint-ORIG-GUID: Jhu82W8QXfHB1dCFSXQYtKCftDzib8ut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/10/26 1:53 AM, Yonggang Luo wrote:
> On Sat, Oct 10, 2026 at 3:45 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 10/1/26 18:51, Pierrick Bouvier wrote:
>>> On 9/30/2026 12:39 AM, Yonggang Luo wrote:
>>>> Use target-specific assembler names and helper metadata for TCG helpers
>>>> when multiple targets share a binary. The generated prototype maps the
>>>> generic C helper name to a target-specific linker symbol, for example:
>>>>
>>>>       helper_raise_exception
>>>>           __asm__("helper_i386_raise_exception")
>>>>
>>>> This lets target helper definitions keep generic C names while avoiding
>>>> linker symbol collisions between targets.
>>>>
>>> Hi Richard, do you have an opinion on this patch?
>>>
>>> We are trying to see if we do renaming per helper, or if we introduce a
>>> "generic" way to deal with it. I don't have a strong opinion, renaming
>>> things or adding more macros and build system soup are both ok on my
>>> side, so direction would depend on your culinary taste.
>> I think the general direction is good.  Perhaps the specifics need
>> adjustment.  In particular, using __asm__ to rename symbols is suspect
>> and likely non-portable to non-ELF hosts like Darwin and Windows.
> 
> I have already tested on windows, only not sure about Darwin, let's me
> create a test on Darwin,
> because I do not have a CI for Darwin to test it.
>

You can take a look at (see README):
https://github.com/p-b-o/qemu-ci#qemu-ci

It will automatically add a full GitHub CI on top of your repo, 
including bsd, macos, windows, linux, so it makes easy to ensure things 
compile correctly on all platforms.

>>
>>
>> r~
> 
> 
> 


