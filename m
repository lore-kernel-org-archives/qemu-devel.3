Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161EECA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJVn-0001i9-DG; Thu, 01 Oct 2026 12:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJVl-0001h6-Qh
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:19:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJVi-0000GS-Mp
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:19:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsdVT3987052
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 16:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uf29OAn3095XuCxtD+sZ+R4luFGbzSMILf7008Rxfzc=; b=BEBgymih0ylvDrGN
 A//vvDRMMV0AXntP2i3gCZ5OBZZuXIBJZAN9NmDCyj+mLNUXoQjF1kj0i1nIuXA9
 lkcHW3AxTYjs+GT3k0EWyEmR/O1+u4JMGlKI18rIeswXuH6T5nLE0VNt11jtW70d
 hPWjmt65Zq7CUGm7gfNkbumLd+QhnclwvjED7fVRsQ4BFqYMgOESoBai0B9vTYia
 lKy31OY8v/3IOhd5SRqjrP5massKU5bS8ggFINm4GZHXeHlZAV5weG0BWEsyz+Ln
 90SlAp0Wh7yJzeNEQ8CLGnbPx+LMFYVBVBBI6LUI7Bn0l5rzMZyBG/IBalPBcg7X
 EfsQmQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1hvkjq0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:19:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4988171eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790871592; x=1791476392; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uf29OAn3095XuCxtD+sZ+R4luFGbzSMILf7008Rxfzc=;
 b=QEJkFnl4pS0+xqQ+BKDzhi3+iW4mgBOI/I7ZT+Ii6Ed46czOOPDSQkfGejaeBn1rP7
 nxa8CCGS9dIb+/8EdQIo1w2iXqnscxowYljNSPRUi+8zfTd3eQG4jDrsjqrJb1ejlmMB
 Usc3ZwcRhPCRDoFMPqWf+wdoaBsaPpQUqFFhCpn2/nDwEAlcEWO4Udbsab7kOSyxyk14
 kLpZo3zbmTdLYWjJIKD0L75zFnH9eNIomt9fyDdxyzR2vss72ApYUqSin8MqcsRaGk3Y
 RDBqRy9qpmMsan6FhI0We6ZNvFGFPdtHOfb4EdBtBn2arfuXPJfSx4KN6gnEGZ5sgpl4
 ZxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790871592; x=1791476392;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uf29OAn3095XuCxtD+sZ+R4luFGbzSMILf7008Rxfzc=;
 b=vQ52GMFc/5UKNPZpQjgG6sN9tzhlkKd4ypqG7w2ArGb/vYtTmDn0L05dem6GOi1NwE
 lmW/b60X0laEqB89WR9JUucifFy+HQQG3dr6MwwuOT/6vVhvjRqTQs0x6bQ4rZ3c7nBd
 yqtjoOoCOBnXx8nzHi9/5UZ7UjkFtPXFo3S2fJRsrMFzaQtZ9ZH74lWBjzVRH7Xx5FRO
 PWfISqlgWhJ/YtSQD+6xyoduAQGsMA2pKTFavaS+oF5x/rQzQegFFhuXmzU2CH4gZLpF
 hVD5jnwku3fp27bpYeKd7PWoNTxGT5dtUUpSHSVhtpa9xeTiWsk5me2BA8WPSAUDz+N4
 Sy8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBytU1ZgT8dnn/7/eyBnQN52G3H+ozqpDocyrUWUh0mTQwLPVV31MIkOD1IkssXxCqyMZ2CbHrrDJ78V@nongnu.org
X-Gm-Message-State: AFuF++lX/1pOKYwpDVl8Afgv87WW78aAgCQJb2gEyrLV9VK8E0XYcxDl
 arfqXE9TqzBJfm2kiHZvsemrbxKlmYxXn6CzztNR8gMivTS64JkGuLcpDLkK3rUtb1OcD5qW2hE
 RqB0/U/dLFhKoXSZc6+CCXaofcy4D9e0GPT+fEVmOtK0KDU0bAYnLFRQtLw==
X-Gm-Gg: AYBFou03oH7Go7y71cIysk579Ygy88j3R73sWzvQMG6QPJGEGdWlaefKWan1chsuFQ5
 w6pYtVVdtnRBO1X1rfyY7qYw9dqdtNhzvqD0kKEoLBkalQFEjzk2GLQZvg83DNue/D4ylgGdt1y
 5lMnFus56Kvg2jjcCbnp/x97HDCGNPIcS9VptS2+9JIHHddRmxXYNqe6np3bT+dPyl+JjGmtmYV
 rxZ7HAzXN4dPFkWNS2PheHmN0aBZTn8SR7ITnEtaNfghknfJvqyxOylHo+pfDIL1JDLpnMGyydF
 /KgpLdo+x5Zcz/bweGPo5OW9kUBK2/8JjUawGeE1PoRoMXTEGrTtIH8NeCej5Gp7n56Y2fsjXjt
 a5L+Bk3HVy9XGcTK3uzsnARblq7SgSrotYgGEamT55II7d9yy3lgbp1KIGkrqXzFH9X4hcg==
X-Received: by 2002:a05:701b:240b:b0:14d:4313:1873 with SMTP id
 a92af1059eb24-14d43131a75mr4694115c88.27.1790871591984; 
 Thu, 01 Oct 2026 09:19:51 -0700 (PDT)
X-Received: by 2002:a05:701b:240b:b0:14d:4313:1873 with SMTP id
 a92af1059eb24-14d43131a75mr4694052c88.27.1790871591203; 
 Thu, 01 Oct 2026 09:19:51 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f274650a1sm374189c88.11.2026.10.01.09.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 09:19:50 -0700 (PDT)
Message-ID: <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 09:19:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: luoyonggang@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
 <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
 <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
 <74853ef8-7315-466a-99ac-41c8182f9b13@oss.qualcomm.com>
 <ar4TQtKqfXX5Ul9O@redhat.com>
 <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
 <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
 <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NSBTYWx0ZWRfXwxVMLqm7mNTz
 Q1d30yWfpfPlJaPu0qEWM9AQ2PYcDpoqLxVmqCXucvBl7hYuMZbCLez+UrenjgLeh7+2ULH0qzS
 Hk/fHrHB2fQOuIyWoEnhGxHtx2YNI6o=
X-Proofpoint-ORIG-GUID: _FxDaxEMPL8cPi9hh95Mv1ax3To11KHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NSBTYWx0ZWRfX1YPdo1z8r6qx
 KbikP/TaDqphzc0jfPRo6W5ExWITw6sQKufV+Mb//29ke40ZWjz/WzXo8IBFtLTomWLnqWhHnXe
 GSsfa/ZUT6liEwhUDt20mRCRkiLOI4j/qVLGWFcO63E63oj/RBdjBdpPTp1Md4zUSO2YTU5Riu5
 GRFF7SpwahnhIUiAZjuB8hA/bBHK6sh+Tctl8qLmIBykuDCSSZ2V+ScQhusycQyPvj1FeY7OJTS
 b53IOnNOM7PdO4+b3Ke2jnShZSGtX0MG/Yb9d83AZ35e7NwdzJeV6fTIp1a5zJ9MqJegN7gqL3C
 BXpT+CkYxDFZWW7zDjZ07gfesT64Vj9zLe3/8ORIYlcrTtD0StMMOb/vlTTycENfvoh9rGeJcQm
 B6xiRGFjGQwWoCSZln4D4+cVl/VWneFGv36ivimTAWRTiwuvmYIk/hPpQ5JhvBU3lrTyTWw5Kuy
 WjRIlcBHHfVs60Dbsgw==
X-Authority-Analysis: v=2.4 cv=IY8Symqa c=1 sm=1 tr=0 ts=6abe8828 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=pGLkceISAAAA:8 a=tBj55iEU8tPC2elFMXEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: _FxDaxEMPL8cPi9hh95Mv1ax3To11KHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010065
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

On 10/1/2026 9:14 AM, Yonggang Luo wrote:
> On Thu, Oct 1, 2026 at 4:44 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 1/10/26 10:13, Yonggang Luo wrote:
>>> On Thu, Oct 1, 2026 at 4:01 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> On Wed, Sep 30, 2026 at 09:23:50PM -0700, Pierrick Bouvier wrote:
>>>>> On 9/30/26 6:55 PM, Yonggang Luo wrote:
>>>>>> On Thu, Oct 1, 2026 at 2:19 AM Pierrick Bouvier
>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>> On 9/26/26 1:15 AM, Yonggang Luo wrote:
>>>>>>>> - Add machine_class_set_name() so boards can keep a stable -M name
>>>>>>>>      when the QOM type is uniquified. machine_class_base_init still
>>>>>>>>      defaults the name to the QOM type without -machine.
>>>>>>>> - Document that MachineClass::name is the -M name, not the QOM type.
>>>>>>>> - Sort -M help by MachineClass::name so order matches the printed names
>>>>>>>>      when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
>>>>>>>>
>>>>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>>> ---
>>>>>>>>     hw/core/machine.c        |  6 ++++++
>>>>>>>>     include/hw/core/boards.h | 12 +++++++++++-
>>>>>>>>     system/vl.c              |  8 +++-----
>>>>>>>>     3 files changed, 20 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> First, I'm not opposed to this series, and if anyone wants to pull this,
>>>>>>> I'm ok with that decision. It's just unclear for me what will be
>>>>>>> direction after this step.
>>>>>>>
>>>>>>> If I understand correctly, the goal here is to allow to register
>>>>>>> multiple "virt" machines, while still having distinct QOM types behind
>>>>>>> the hood, which does no affect behavior of current binaries who have
>>>>>>> only a single "virt" type at most.
>>>>>>>
>>>>>>> That said, if we project in the future where we have a binary with
>>>>>>> multiple of those "virt" machines, how will the current series help? The
>>>>>>> situation we'll have is distinct QOM types, that all answer to the name
>>>>>>> "virt", so we have no way to select them individually.
>>>>>>>
>>>>>>> Slightly worse, find_machine() will just pick the first machine name
>>>>>>> virt, which is a non-deterministic order at the moment.
>>>>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_type=heads#L846
>>>>>>
>>>>>> That will handle it properly. For single-target binary qemu-system-$arch.exe,
>>>>>> this won't be an issue, as there is no conflict as they won't be compiled in.
>>>>>> For multi-target binary qemu-system.exe, we will choose the target through
>>>>>> -M $arch:$machine, and when no $arch is specified, the default to arch
>>>>>> to be "none",
>>>>>> so still won't be non-deterministic.
>>>>>>
>>>>>
>>>>>> "when no $arch is specified, the default to arch to be "none",so still >
>>>>> won't be non-deterministic.
>>>>>
>>>>> That's my point, the current abstraction will create something ambiguous by
>>>>> design. When people will specify -M virt, without $arch:, a random machine
>>>>> will be selected. At least, maybe this series should ensure there is only
>>>>> one virt alias, or make it forbidden and uses unambiguous names only.
>>>>
>>>> Yes, if there are multiple choices, we should not pick an arbitrary one
>>>> non-deterministically, we must require the user to narrow the choice
>>>> explicitly in some manner.
>>>>
>>>>> "$arch:" is just a workaround to not add -target option, except that it
>>>>> comes with additional problems, creating inconsistent command lines.
>>>>> I already expressed my skepticism about the "machine prefix" based approach,
>>>>> being more in favor to strongly filter types per target with an unambiguous
>>>>> -target option. I'll accept the community's choice on this, but just wanted
>>>>> to see this explained before someone hits the pull button on this series, so
>>>>> they know what will come down the road.
>>>>
>>>> Historically, QEMU do alot of things like this where we invented magic
>>>> syntax that needed custom parsing of the command line. Over time we
>>>> came to the conclusion this ad-hoc parsing was a bad idea, and we
>>>> should always explicitly model things, even if it is more verbose.
>>>>
>>>> Thus I would not want to see "$target:$machine" as something that is
>>>> parsed into two pieces.
>>>>
>>>> IOW, "aarch64-virt" would be OK as a unique name which treated as an
>>>> opaque string, but "aarch64:virt" as something split into "aarch64"
>>>> (target) and "virt" (machine) would be a bad idea.
>>>>
>>>> An acceptable way of modelling the latter would be to use
>>>>
>>>>    '-machine name=virt,target=aarch64'
>>
>> Why mix target information parsing at machine level when the
>> machine already know it is target specific? People wanting to
>> use the ARM virt machine don't want to know (and don't care)
>> about the M68k virt machine.
>>
>>>
>>>>
>>>> or
>>>>
>>>>    -machine virt -target aarch64
>>>
>>>
>>> That's made me confused, as different people propose different ways to
>>> handle it.
>>> Can we just choose one first?
>>> '-machine name=virt,target=aarch64' is introducing new options, so is
>>> '-machine virt -target aarch64'
>>> I can not argue which is better, my suggestion may land one first. Both
>>> "-machine virt -target aarch64" and "-machine $arch:$name" I have
>>> already implemented. And currently I chose
>>> "-machine $arch:$name" according to
>>> https://patchwork.ozlabs.org/project/qemu-devel/cover/20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com/#3749257
>>
>> You still did not explained what you are trying to achieve
>> with all your contributions, so my view is surely biased by
>> what we envisioned 3 years ago when we started to pave our
>> way for heterogenous emulation.
>>
>> My options so far for a single binary:
>>
>> - infer from argv[]
> This can be easy to implement and can be defer till the qemu-system-$arch
> is symbolic link to qemu-system.
> 
>> - enforce with CLI -target
> 
> I want to post my personal options, I'll prefer the -target options as
> it's far easier to implement than "-machine $arch:$machine".
> -machine $arch:$machine is very complicated to implement correct.
> 
>> - not expose any machine
> 
> I think not exposing any machine in the command line is a good option,
> as it's easier to
> implement and clean for the user. But I think this series is still needed.
> As we want the means to inspect all machines and devices for all
> targets(that need all of them
> to be registered into the QOM type hash table).
>

It's not strictly needed to expose all types. -target can be parsed
first, and influence what is visible from help (including -M help) also.

Also, if we go down the -target option, we should decide if we expose
all types or not, which means if we implement filtering or not. If we
expose all the types, I'm not sure what -target is supposed to choose.

Daniel, what do you think about this one?

>>
> 
>> Phil.
> 
> 
> 


