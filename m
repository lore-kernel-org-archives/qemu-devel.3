Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05225CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGera-0007rW-3u; Tue, 13 Oct 2026 11:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGerY-0007qP-QV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:56:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGerS-00074H-LX
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:56:23 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3SXK442744
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XyL2PQFHmx4gMd4uvfpGwFjs1cdH+Q5Ev43sOlCPO4Q=; b=ixtpuVzg8eCWPhxa
 kyppMxRGGC6s71jy3aEQD1KkCtYO0X/uHmx6tsQ19nU5E5AMDkCnSDPxPCxnLwMd
 8/p3ffbZre0L+zKnSefBki9bhSr0MXWVDtEPjsnhJ5/3IvrtHM3cuXOaC2kesiNA
 Oil3pM6nszjQ8cUPOCFl1/mgglyEluj2gJU7IUwm7fECXneR4WkFEl5AxJlUEc/B
 Orb/UvFaqsyvwkYGkRrYYyymHjr6xfA5cGiMZhS9sGPNjabtGhSQWV2lpijdBV0C
 ehY26E32MTB/FrS7xEBqey6jukWKP218QXgQBNFOmpeurK2F6O4Ge0Ok1rIXYqa7
 ppHJNg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71gtcs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:56:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so27549795ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791906975; x=1792511775; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XyL2PQFHmx4gMd4uvfpGwFjs1cdH+Q5Ev43sOlCPO4Q=;
 b=YSDNfM5IwqHU6iG3W6jxucXGyfPcP+arDDqPY8djYfosKe3Rxb3riuwVVz7xafnVm4
 ir8y9dQsl53S5R+H2+iCgKzdGU5fjkLeldCR9+YmQtROO9jFVITDvdLbXRovB1GT7s1z
 kfncQnN/1rJ/foUAYeyNfJsCtAx8tO1xzzj1j34mmCSNdkHji8ncygxLF+t2+miTsfXU
 9OXvp15fE+7ovFGjACqFprIKvBOBd+n4ZrupWpQ6lB9rEVUjs0kRbjzvPrdbFQuOMHQ5
 okOga3l81CeQbL9ny2yDE2TJGH74TT6p20Bno3S93ZKXvHBbw5/np2LTFn4BRkVf0bmB
 Iz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906975; x=1792511775;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XyL2PQFHmx4gMd4uvfpGwFjs1cdH+Q5Ev43sOlCPO4Q=;
 b=VDTD5YT5E0auGXk5+29sTXAr44A981dyNtWiThVI31JJJ8d7B5cJePdZOKHTHGQkjV
 1D0rgAcYh78a4wnemESPgADAqa0axnXD1TiCSqVmsKWdEBmlKRjc0dR4HJUS/OpILXW3
 I4jgJGiwc3EaThKu4ehimrYzMQuBebLEsT0lEsp5NeL15edpuu3tSkwJv6V+JaFZPUwy
 FdwynULsfi4/dlhOSH2u/EvoxJoNEvbditPYvYNsgwCUQ4lSwF6pmwIRiiHkKhJMW9YZ
 1miKOvsklpf4VfcDJv4DVLMB4dcp1bOphTlN1ezi0F8LtAEsJQvEPvOlUU2/RSMTJaky
 0Gqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBN+kpgljgYCvYL8ld7NmQuuhu9tfIFy5r2pp3wKjSAiYRI7T4OMqxyBAvu3SvOOEy61h777vGwVvN@nongnu.org
X-Gm-Message-State: AFq9FYJelGqzVhFZh9zIq/7pgLOJWWrsjnYUAIIrDqfYZ9SvYm3azZ1c
 BATPnJvfSIEKkpvhcgMEd4HVSUdo6yHzY4g61owUH0oqCAA2wUGY9BChwtmOWh/+YPnDdkg7wFB
 VIirFJlkqRm8UXgy4i0T4HJ1YN4azMYkjUyka8CGbRkphAgwC61PdRfwjtg==
X-Gm-Gg: AYBFou2g+IAqGKMH4CW3DKpQRr0xvC6E1oukEYTpq6FCc86+oY0gXiTUTHYDznzK79y
 QVq7yU8JZ9G7dmEJDtrvDVc/+nNB+/Wu4UVL+f6JRsK5HKFuL0w0goBDwxg8IT9nSh6Y9k16Uea
 L7vlNJAqmyiJedFpBbnzni+qDTW740g9f/csS+QPiio7Y+8fgkrsSAKY0Gk5PygIwKuCwg1x5Z/
 xTsHQI3AlmtnYNifGzCvjW7mecoJllXsxICFm1AdCLzRA/ALxoLpPOrTv4o354MgrV4n/oV09pY
 MlV59m9B/Ca4QFiX0536nZrk4YKl8m4wweJGj0+GcOEm0TygZCwul5yJPfOLFXWWKKuDsEJLyuC
 Wq6MDo3vaLjjXFf37QLV/DthxiO+zyvG1CdVNpolCZCO2WMBxB5tTvW6MRxYlnITABczwgg==
X-Received: by 2002:a17:902:dac9:b0:2e3:1d30:8658 with SMTP id
 d9443c01a7336-2e842836264mr111904555ad.10.1791906974660; 
 Tue, 13 Oct 2026 08:56:14 -0700 (PDT)
X-Received: by 2002:a17:902:dac9:b0:2e3:1d30:8658 with SMTP id
 d9443c01a7336-2e842836264mr111904185ad.10.1791906973960; 
 Tue, 13 Oct 2026 08:56:13 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422c99b6sm58637515ad.65.2026.10.13.08.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 08:56:13 -0700 (PDT)
Message-ID: <60494b19-420f-4d0f-966c-b70c4c51104b@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 08:56:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
 <asdlbOZBSYIaCMIh@redhat.com>
 <CAE2XoE91XxoJRFpQ_1jhmX6LdxMyN16CF7RXxM62C5Ctkc1tig@mail.gmail.com>
 <42fd67c0-c20d-4bc4-bede-79073e4be4a1@oss.qualcomm.com>
 <CAE2XoE-gN5-vmE8r00Ds_Z=E1WePSFi_MJXjmy9ZuXEU_=o31g@mail.gmail.com>
 <3034c146-0697-4db7-acd4-8076b317a09e@oss.qualcomm.com>
 <CAE2XoE-gCTrpEeCROz9JMpPnTQXQ+AnBTR4RwdQhYizkExjK9w@mail.gmail.com>
 <8cb24445-b659-4bd4-9497-888ce152e82d@oss.qualcomm.com>
 <1a477877-516a-41b8-8548-598bfad74f25@oss.qualcomm.com>
 <CAE2XoE_MotPuxBBkLFWmcDf6ACva2r7y-7sRbQ3DNNwZvXcJFQ@mail.gmail.com>
 <ae0dcb2d-1488-4cea-8bc0-2a0cb2cd74be@oss.qualcomm.com>
 <CAE2XoE9B8RXg6=6kofVA=d6C5OBXT9GZ2cPceWUUDa4m9=_fRg@mail.gmail.com>
 <bfa70b6e-fc66-4607-bd45-b55ae2951d57@oss.qualcomm.com>
 <CAE2XoE-9w1-3-kFvWXdZZz=sc-Eor3goUr09vANbaqyNrtJGdg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-9w1-3-kFvWXdZZz=sc-Eor3goUr09vANbaqyNrtJGdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6ace54a0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=SBenxNRcLLTFxgQK21wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: j6iU0l7iSYCrJty7bo6Df15aNkG3rCJ1
X-Proofpoint-ORIG-GUID: j6iU0l7iSYCrJty7bo6Df15aNkG3rCJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfX1gszMldQNnhp
 8BhGifhPKwZW7Mzt11CMhf27I8cJkEJRM+dtlPxryA87qvrtmFe0B7lwKhDUcl/dYdSyatk7wbS
 q28Hgu1FH8yOPHjPqIh23wxtEY6T2fXj+EGzcF9Twc3QZnorC0G7eGcKbOh5ssAEiFrofv0Ahtl
 LUMw61wrObkBT15HpvExr7EzGCTE8wWeDROYcr2LiyhhNNDb7JNC2XWDbkl2xbYTJGCO+BZ8M7j
 Ktj10ql0dL0a5tq1sESaRO+5frMbum8/AuoXTTSS+RhAkH7+LEfF+d87gDxZyqEIliwksC5dsfc
 kX+9bXSTsM1RSlCeCJ31+U68KVqXZMTKuu5fNfGT2M0ETEKnzXZA8KYR7NDCgEwJ+5uD0qKUKmv
 XkLhwgv1lB5ojkO89de/pO5yQ3WvLPPx4FHC9WxMRlqkokzwU7mdRcXDBcoMcBlfUeMQCfI+7V4
 i9/CEKqu83QQRSkIorQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfX/+1rTtlz8efa
 nLMejh7R1TFyXAt+j9JsxobiQNhvAln0MZo9nIIX7PLpMq20tQSOZSXnL0gES9w84dFzd+BJNRg
 EXKRaLFN9drFtnHLds58shmilFCz/sU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130063
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

On 10/12/2026 9:03 PM, Yonggang Luo wrote:
> On Tue, Oct 13, 2026 at 11:53 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/12/26 7:43 PM, Yonggang Luo wrote:
>>> On Tue, Oct 13, 2026 at 9:26 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/11/26 9:26 PM, Yonggang Luo wrote:
>>>>> On Mon, Oct 12, 2026 at 10:25 AM Pierrick Bouvier
>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> On 10/11/26 7:13 PM, Pierrick Bouvier wrote:
>>>>>>> On 10/11/26 1:22 PM, Yonggang Luo wrote:
>>>>>>>> On Fri, Oct 9, 2026 at 2:34 AM Pierrick Bouvier
>>>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>>>
>>>>>>>>> On 10/8/2026 10:13 AM, Yonggang Luo wrote:
>>>>>>>>>> On Fri, Oct 9, 2026 at 12:06 AM Pierrick Bouvier
>>>>>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
>>>>>>>>>>>> On Thu, Oct 8, 2026 at 5:42 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
>>>>>>>>>>>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
>>>>>>>>>>>>>>> This allows a combined binary to register machine types from all its targets.
>>>>>>>>>>>>>>> Consequently, QMP `query-machines` can return machine entries from every
>>>>>>>>>>>>>>> target, even when `none` is selected. For example, a client can query the
>>>>>>>>>>>>>>> combined machine list with:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> ```json
>>>>>>>>>>>>>>> { "execute": "query-machines" }
>>>>>>>>>>>>>>> ```
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The returned list includes the registered machine classes from all linked
>>>>>>>>>>>>>>> targets. This is separate from selecting a machine: with `-target none`,
>>>>>>>>>>>>>>> `-M virt` reports the targets that provide `virt` instead of choosing one
>>>>>>>>>>>>>>> arbitrarily:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> ```text
>>>>>>>>>>>>>>> qemu-system -target none -M virt
>>>>>>>>>>>>>>> unsupported machine type: "virt" for target "none"
>>>>>>>>>>>>>>> Available for targets:
>>>>>>>>>>>>>>>       aarch64
>>>>>>>>>>>>>>>       arm
>>>>>>>>>>>>>>> ```
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>     From the long conversation on a previous thread, I thought we reached
>>>>>>>>>>>>>> the conclusion that if we didn't expose any ambiguous name, then -target
>>>>>>>>>>>>>> option is unnecessary, or maybe I got lost on track of this thread.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'm not sure which semantic we want to have with -target none. If there
>>>>>>>>>>>>>> is no ambiguous name registered, we just don't need it at all. It's a
>>>>>>>>>>>>>> win-win IMHO.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes, if we expose unique names for every machine, then -target is then
>>>>>>>>>>>>> redundant.
>>>>>>>>>>>>
>>>>>>>>>>>> so how to diff riscv32-virt and risv64-virt? oh so for this machine we
>>>>>>>>>>>> needs two name?
>>>>>>>>>>>> "virt" needs register twice for it? or register only a single time,
>>>>>>>>>>>> but we prefix the target_name()
>>>>>>>>>>>> automatically? for example machine::name === "virt", but we can use
>>>>>>>>>>>> "riscv32-virt" "risv64-virt" to reach it?
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Yes, ideally we should have different variant of virt for 32/64 bit.
>>>>>>>>>>> Same goes for cpu max types.
>>>>>>>>>>>
>>>>>>>>>>> QOM type is always registered unambiguously ("$arch-virt"). Then, for
>>>>>>>>>>> the "alias" name, which is virt, in case multiple matches are found,
>>>>>>>>>>> command line can return an error with list of unambiguous names to call it.
>>>>>>>>>>>
>>>>>>>>>>> $ qemu-system -M virt
>>>>>>>>>>> Multiple virt machines are available. Please choose one of them:
>>>>>>>>>>> - aarch64-virt
>>>>>>>>>>> - riscv64-virt
>>>>>>>>>>>
>>>>>>>>>>> There is no "parsing" of the argument, it's just the real QOM type. Then
>>>>>>>>>>> we can find which target it implements from mc->targets.
>>>>>>>>>>> And then, we can automatically choose which cpus should be available
>>>>>>>>>>> based on that, thanks to cpu->targets.
>>>>>>>>>>>
>>>>>>>>>>> For existing binaries, nothing change.
>>>>>>>>>>
>>>>>>>>>> Good, I think we found a clean way now, is_available should be
>>>>>>>>>> removed, and TypeInfo::targets and TypeImpl::targets should be added.
>>>>>>>>>
>>>>>>>>> It goes into MachineClass only for now.
>>>>>>>>>
>>>>>>>>>> I think
>>>>>>>>>> for "virt" we can add a shared hw/machine-virt.c instead, and forwarding to
>>>>>>>>>> the $arch specific virt. so that we only have a single "virt" registered.
>>>>>>>>>> And it's
>>>>>>>>>> targets is
>>>>>>>>>> QEMU_ARCH_I386 |
>>>>>>>>>> QEMU_ARCH_ARM |
>>>>>>>>>> QEMU_ARCH_RISCV |
>>>>>>>>>> QEMU_ARCH_LOONGARCH |
>>>>>>>>>> QEMU_ARCH_M68K |
>>>>>>>>>> QEMU_ARCH_OR1K |
>>>>>>>>>> QEMU_ARCH_XTENSA |
>>>>>>>>>> QEMU_ARCH_HEXAGON
>>>>>>>>>>
>>>>>>>>>> So that we won't have a list of conflict QOM names for "virt" machines.
>>>>>>>>>> As now we indeed have only a single "virt" machine that redirects to
>>>>>>>>>> different targets.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The idea looks appealing, but I don't think it solves the problem to
>>>>>>>>> have multiple virt variants available at the same time.
>>>>>>>>>
>>>>>>>>> The "alias" idea you introduced before is good, we just need to add a
>>>>>>>>> check if an alias is really unique, else return an error, as explained
>>>>>>>>> previously.
>>>>>>>>>
>>>>>>>>> If "-M aarch64-virt" works for both the new and existing binary, and -M
>>>>>>>>> virt only for existing binaries (and ambiguous for new one), I think
>>>>>>>>> that's a safe approach.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> For other types also conflict can be handled in the same way, such as
>>>>>>>>>> "-cpu host" "-cpu max"
>>>>>>>>>> maybe others, but I think they all have the same way to deal with.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> That's why  TypeInfo::targets and TypeImpl::targets better than sole
>>>>>>>>>> Machine::targets
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> One step at a time.
>>>>>>>>> Let's keep focused on declaring targets for a single machine first.
>>>>>>>>> Then we can iterate to solve the "virt" problem.
>>>>>>>>> Then convert all the existing machines and add a check in machine-target.c
>>>>>>>>> Then, and only then, we can see what happens with cpus.
>>>>>>>>
>>>>>>>> I tried this idea, but I faced a fatal error, because the
>>>>>>>> target_info() is not available until
>>>>>>>> the machine selected(the target arch will be select just along with
>>>>>>>> the machine selected), so basically
>>>>>>>> all calls to target_info() would raise an error(null pointer), how to
>>>>>>>> deal with it?
>>>>>>>>
>>>>>>>
>>>>>>> I see. Indeed, since we can't set a target before registering all types,
>>>>>>> it implies that all the types class_init can't use target_* functions.
>>>>>>>
>>>>>>>
>>>>>>> - register_accel_target_type
>>>>>>> - cpu_max_v8_register_type
>>>>>>>
>>>>>>
>>>>>> Sorry, mail sent to early.
>>>>>>
>>>>>> For the is_available callback usage, it should be easy to do the switch,
>>>>>> since it's basically the same information that what we are trying to do
>>>>>> - we can leave them for now.
>>>>>>
>>>>>> Some types (like accel and max mentioned above), explicitly change their
>>>>>> definition depending on the target. It's a behavior we can't rely on
>>>>>> anymore, and it means we need proper distinct types instead of a single
>>>>>> one with dynamic definition driven by target-info.
>>>>>>
>>>>>> I think that's the preliminary work needed, before being able to go
>>>>>> further: convert all existing usage in class_init with distinct types +
>>>>>> is_available, and then we can do the switch from is_available to the new
>>>>>> .targets approach.
>>>>>
>>>>> Hi Pierrick,
>>>>> I have already tried that introducing new QOM names just to make class_init
>>>>>    target-independent is too broad(means all usage of it should be handled)
>>>>> and could complicate compatibility(changed too much code).
>>>>> Can we avoid new names by some new means(ideas welcome)?
>>>>>
>>>>
>>>> As a first step, I don't think we need new names, is_available can be
>>>> used to selectively register one definition or another and avoid any
>>>> clash. What is missing at the moment though, is that some types (like
>>>> cpu max above) change their definition based on target definition.
>>>
>>>
>>>>
>>>> So for cpu max, we would have two distinct types, both named max, but
>>>> one with is_available(target_arm), and other one with
>>>> is_available(target_aarch64), so they are never registered at the same time.
>>>
>>>>
>>>> Same for virt machines. It's already what we have, duplication is
>>>> handled at the moment with distinct is_available callbacks.
>>>>
>>>> Then, see below.
>>>>
>>>>>
>>>>>>
>>>>>> It's probably worth having the conversion in its own series (only
>>>>>> cleanup usage of target_* in class_init), before trying to get rid of
>>>>>> is_available.
>>>>>
>>>>>>
>>>>>> For the implementation, you can use the multi-targets.c binary test to
>>>>>> drive the change. Remove the module init for target info (leaving no
>>>>>> target set), and add a hacky patch to skip call to is_available (and
>>>>>> return true instead) and allow double definition (which will rely on
>>>>>> is_available). Then, fix all the segfault. Once it compiles and runs,
>>>>>> only double definition will be left, which can be handled by inserting
>>>>>> the right is_available callbacks. Then in a subsequent series, the
>>>>>> switch to .targets can be made.
>>>>>
>>>>>
>>>>> Still have no clean clue about how to remove is_available , as we have many
>>>>> "virt" machines. Do you means all "virt" machines with "virt-machine" QOM names
>>>>> are inserted to the table? How to get it working because the "key" is string.
>>>>>
>>>>
>>>> Once we have type definition which only depends on is_available, we can
>>>> convert this to .targets, which would contain the same information.
>>>> For the rest, I have some ideas, but I would like first we do the first
>>>> part (convert to is_available), which is already a huge work in itself,
>>>> and a series of its own.
>>>
>>> Indeed I am confused .targets only exists on Machine, how is it
>>> related to -cpu host -cpu max?
>>>
>>
>> We can introduce cpu.targets after machine.targets.
>> First step is just to get something that works with is_available and
>> does not require any target info to be set.
> 
> Feels weird, what's wrong with this method:
>  target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
> index 65f851f2006..d7323ab431c 100644
> --- a/target/arm/tcg/cpu-max-v8.c
> +++ b/target/arm/tcg/cpu-max-v8.c
> @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
>  #endif
>  }
> 
> +static void max_v8_tcg_initfn(Object *obj)
> +{
> +    if (target_aarch64()) {
> +        aarch64_max_v8_tcg_initfn(obj);
> +    } else {
> +        aarch32_max_v8_tcg_initfn(obj);
> +    }
> +}
> +
>  static void cpu_max_v8_register_type(void)
>  {
> -    static const ARMCPUInfo max_v8[2] = {
> -        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
> -        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
> +    static const ARMCPUInfo max_v8 = {
> +        .name = "max-v8",
> +        .initfn = max_v8_tcg_initfn,
>      };
> -    arm_cpu_register(&max_v8[target_aarch64()]);
> +    arm_cpu_register(&max_v8);
>  }
>  type_init(cpu_max_v8_register_type)
>

In this case, It seems simpler to me to register two max types, with
different is_available. Arm maintainers might have a different opinion,
so I encourage you to post this as a separate series with them in cc.

It's also the last inline patch I'll answer to (next ones will be
silently ignored).

> 
>>
>>>
>>> I already have a working copy that does not depend on target_info()
>>> and selects target_info() when the machine
>>> is selected, no QOM name introduced. only for machines, we will have
>>> $target_name-$machine_name as a name for selecting
>>> the exact machine.
>>>
>>> The cpu max cpu host is dealt by moving the choose code out of
>>> class_init, into object_init. I really did not get your idea by use
>>> is_avaiable. because when I try to get all QOMs to be registered. then
>>> I won't call is_available at all.
>>
>> As a first step, we rely on is_available, to work on distinguishing
>> proper types per target and break the dependency of multiple class_init
>> to target_info. Then, we can replace is_available with .targets.
>>
>>> because "is_available" depends on target_info(),(we won't have
>>> target_info() till the machine is selected).
>>>
>>
>> We can imagine registering types in different buckets per target, which
>> would allow for duplication.
> 
> 
> So your idea is multiple hash-tables for QOM types? key is the target_arch?
>

I don't want to dig more into this now, a lot of preliminary work has
been discussed already, let's focus on that.

Regards,
Pierrick

