Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC541C88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5zWe-0006Bt-De; Mon, 14 Sep 2026 01:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5zWc-0006B5-GE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:46:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5zWZ-0005Zz-Gu
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:46:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5j4La063677
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ebZvzrhxaanANfMnPQ23Jxu2u39GOVLE4PtWVWJnn2M=; b=PvvyhfPQgJePUGCz
 UawVPLV8v4o8oKPS1ymz82IANulvWmMZTJLcVNttD7NoGaLo8/QHDr9+HxTS5/Jp
 DPT3FWlTW6klD6YBXpbeC5faM3Upp7Ianjk/LFYWOcH0lpMFxj1yxQ9CmA0ZRzys
 SBlFcLkBnOU05fy0ESy/iR34r1JaLVwGvbfkzsvk3d9l8WhmoWmQtbCQj/O6LpRI
 hdq9D4nnMtKj9tHn1QWWp4k2WI3RW4Q167EQzecqXJBEZev62bD3vQTsubDhjuBX
 dyWHd6dujacqmkCCbBcrgFVf/p57VaOp7OJyCayzlHNEz7lHnrNufHElheKoygYI
 WeFFfQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dn8x7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:46:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso4250699a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789364797; x=1789969597; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ebZvzrhxaanANfMnPQ23Jxu2u39GOVLE4PtWVWJnn2M=;
 b=hwQwV25RjUJsNs288oiRUy+WEbkhW0pi54CRRk/jeG0KXA2/hV5zBAV9IEPNpkeMbs
 XrQV+kIFxQTqDWk+x++RSrcY5ekjkOjz3Ryk/tyVGKGnFxnWaHBH79R6YlKV4R9f1Teu
 oyKB2Vu7F6uc0sNBLvvSlsKKo2owXdBhLdK+NYkQcHdoQKuZVoy9otHRr47K9WeBn6kW
 JOeCtwpHFOgIehZ/b9Hg6+GO1P5sfbpvtRMW7MFiIg4TQzm75yOkhLqR+6iK6Uj7c2q4
 Ak5yj8LAGoJb/1eLJEnJM8bDCUkyhntQFcp8jz+r+YoM1vZ1HczXi71k+dcDdHQLzk1j
 14sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364797; x=1789969597;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ebZvzrhxaanANfMnPQ23Jxu2u39GOVLE4PtWVWJnn2M=;
 b=RActE3TX1/r6KHtHXuXnPN/CDULepvnZWsiw9keJbLekXDHiWVabcAUd2XtnmbpUPF
 AuTEU+Un5tcr9Pn8yde5LbnhwbCS4oDVhoOBVqsX7Wz64pkUJYrBc4d2aTl6b/9caTY5
 XfVai7AXhyHHH9LUl7v6g3f+lgEut65dOVLKSj4cBHTteAcKB/Nsljw0cbvjToiuol5h
 2g5o4yzyDkxAF4KWPvHR+xLo7vB0tWPjAxKMTxrXN8aZxeGvcETTKCXx/tWE+6Be1DYE
 4ygVlrZtcLIVLI92XwC469ZitsFS+0fzC11dHxiT2Y6eZAMBGU9lQ0lDcdRQVDESgwfL
 HBMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxm2Ebfr6cB6p71DwskmQ2uUbT8lXDplihQ/8tWvATmhclT3ymQreu33tPmzsJkQR/vQBhq+XySxVcF@nongnu.org
X-Gm-Message-State: AFuF++lWW/6V/SQZVm9wdq6o3IkzfFDx/Pnl9N7FT5mlF2YGtfY/JxMJ
 iVgufK6DkFpDZ6h5i4OMBXJ+bKHPDloUaRhhc5LLOUxNIJvKbqcnUKMJtERreozuPDkz7vKunD9
 obSjbRpMga6a8AKo0e3KfzvpALftYWeuiJM/v3uLK1htn07KVq2uzeFOz7g==
X-Gm-Gg: AYBFou2JX+B2jhiJY2kWvmqajv/ZuHUzBSMUY8HDXolYdq8y80MYUWAh1mJjflteUzo
 mb2ctbRkM4WmhPO5vnd4OuKaX/l7QA3UhsEmMoGVkmpccMYKP0GcMhOkwvH9umMWNe+C6aUpVNh
 seVtC3HOuNRZDhIPupZt4VYwZ/sZurBvF6jwyYLMjPFMYhaP5etrBZDXDpbP4YGMPEJuN83U/rC
 QztfVO0yQ2sDeXESxTzERM71HFmDHfXxw9Sp09KujfHmhEObLG1B3bTwvz9+05yPxrFYBU9rFBo
 yZs12VM0gIaXEdEPD/0oo6Gn02ByC16o6WpsI1XLljsqYMBM0EYnXJYsfEb0SXliS6an/taQQJR
 mK3TzC52x2kRaKpZoFvYOIgrTo4ws6Mu7fuDFGEtDz91jL4vPejV7rK0=
X-Received: by 2002:a17:90a:e7c2:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-39dec497e11mr1196545a91.10.1789364796671; 
 Sun, 13 Sep 2026 22:46:36 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c2:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-39dec497e11mr1196485a91.10.1789364796152; 
 Sun, 13 Sep 2026 22:46:36 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d99531b21sm18611728a91.13.2026.09.13.22.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:46:35 -0700 (PDT)
Message-ID: <514486c3-7e28-44ff-9080-88d30c388175@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 22:46:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <b2b1d77e-c3e3-4aad-87d2-f5d4834abd1a@oss.qualcomm.com>
 <apAG8JQTnQxRkfip@redhat.com>
 <9e36f8a0-5363-4ce2-accf-62ccf3602344@oss.qualcomm.com>
 <CABgObfYw8U6q1xdUXcP5XBNTpB-n9MR=DkzFXpb6nkn7g00etQ@mail.gmail.com>
 <997fad72-3d6f-4ec6-9017-290959d9848f@oss.qualcomm.com>
 <b426be77-d233-4f45-9c14-889e95141b6d@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <b426be77-d233-4f45-9c14-889e95141b6d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA3OSBTYWx0ZWRfXyTTMfNWGiUl7
 XA5PCzFKB3pUdJijd/Ry13dnoMUdZ1Xfp+w8nQ/fe8AsM2/CkKAJCfdJK+NRFr4h2FuKKSFqmSn
 huSpQSYFil48L03lxyzuSjI5fjx78qqGyqz7hB1SA24QtUHafLFJAgDyYnbnz0Kk5j2wQwxclch
 fSuqnh/pqh1kqqpmZtVaJTYy3vW+RqjfXip5XcIY6wNk415psgBKpA7W+jwAu028IwOoSRG258O
 8eYolzeylVMhLsDLrXp/OAifDZus6PgTgnthqIf+UsPX95RO0ruT1RU++YR4YQiZk+eNnE/zVzf
 XHmXHYHt2W87MyAJARIJA42NmJBK14o4FNTTTTfbmnnLMh0N1Xxr1KOBPT1UOLccBw1alu1JZnI
 sLhHH++vcauYdbiSddl3GW7qlhu9GlTsGPc9MNLqSwV1Op7bdK7PhJR8iFWe7C6w3OmCONJd6JP
 S6vBqis0yrrb0pwsEhA==
X-Proofpoint-ORIG-GUID: I3aqSzqMIWFOP_Fn4_iwiB5jKRP5Xg49
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA3OSBTYWx0ZWRfX+y9IBaM+p30H
 tR78fXx7oW/f8UAOj4yzB+Ko524j0LzN/RDYt1CzVy8/F5Jc/aLC4SE8bBcKPS8Zof9/PXhxdH8
 D1qriK4K8uU/4kwMmNBRPH88Us+vM9I=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa78a3d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=9QkMTC1sBftomiCVg_4A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: I3aqSzqMIWFOP_Fn4_iwiB5jKRP5Xg49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140079
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

On 9/4/26 5:47 AM, Paolo Bonzini wrote:
> On 8/27/26 21:58, Pierrick Bouvier wrote:
>> On 8/27/2026 10:48 AM, Paolo Bonzini wrote:
>>> Whoa whoa.
>>>
>>
>> I apologize to Daniel, and other people on this thread for resorting to
>> sarcasm in this situation, and personally mention Daniel in my answer.
>>
>> It stems from the fact that it's not the first time Daniel come on a
>> thread to push a view (that might be wrong) and don't listen to other's
>> people opinion, or leave the conversation when he has no more arguments
>> or discover he's wrong. I'm not the first one to discover this, and it's
>> a topic that came from multiple people I met. I invite anyone to tell me
>> publicly it's in my head, and that it is wrong.
> 
> Please stop.  Just stop.  "It came from multiple people" never ends well.
> 
> I have my own disagreements with Daniel, which is no surprise since I've
> known him at work for over 15 years.  In fact, we probably had a couple
> just this week, though that's fortunately above average.  We have
> different personalities, we come from different cultural backgrounds.
> We are still able to respect each other and I seek his opinion even if
> (or sometimes because) I know it'll be different and make things harder
> for me. :)
> 
>>> Sometimes people don't reply not because they disagree, but because
>>> they trust the people involved to resolve the problem.
>>
>> We presented a plan a year ago, for which multiple people have been
>> supportive in general. Now we are close to having a single binary
>> upstream, we have Daniel coming last minute and asking to solve issues
>> we are not at yet. I feel it's not helping us, and simply blocking work.
>>
>> Daniel's main concern (correct me if I'm wrong), is that we might
>> introduce regressions by introducing a -target option, and filtering on
>> QOM types.
> 
> I'll briefly touch the technical part.  As it was explained, the problem
> is really just in the use of symlinks for aarch64 and riscv64 binaries.
> 
> All that Daniel is *asking for* is to split the experimental part from
> the existing one.  Did he go on a tangent on what else he'd like from
> the experimental part?  Yes, but that's simply a justification for why
> it's better to keep it split.
> 
>> I have no problem with anyone deciding to refactor the QEMU command
>> line, but it's a different problem from what we are doing now.
>> We just want to provide a first version upstream mixing at least two
>> base architectures, and providing exact same behavior than existing
>> binaries.
> 
> Yes, and that's fine.
> 
>>> Let me remind you of the discussion we had about -fms-bitfields and
>>> how it was resolved amicably and profitably.
>>
>> I really appreciated this exchange with you. Even if I was a newcomer,
>> you explained where you disagreed, but accepted a different answer. Then
>> we iterated to prove that existing struct layout were not impacted, and
>> we both observed it was safe to remove this option. I felt like we both
>> worked toward a goal, and not that you pushed your personal vision
>> without any technical basis.
> 
> I have a different memory.  While I am also satisfied with the outcome,
> I remember that it was hard to explain why you couldn't just drop
> -fms-bitfields, and what analysis was required before you did that.  And
> the outcome was positive mostly (or only) because *I* did the analysis
> that was necessary to ensure there would be no regressions with *your*
> proposed patch.
> 
> What Daniel is asking is even less - he's only asking to *remove* the
> bits that symlink qemu-system-arm and qemu-system-riscv64 into
> qemu-system.  (Perhaps you could do that with a configure option
> instead, btw, that's also a possibility and would make CI integration
> easier).
>>> This project was extremely complex and some disagreements are normal,
>>> but overall I would say it has received support from the community for
>>> years. It is close to the finish line, let's not forget all the
>>> collaboration so far.
>>
>> At this point, I don't see the finish line coming anytime soon.
>> We are stuck in a situation where we now might have to design a whole
>> new command line from scratch, for a reason I ignore.
> 
> This is simply not true. The important part: "We don't have to do all
> that straightaway. If we declare qemu-system 'experimental' initially we
> can iterate on that intentionally breaking compat in releases, without
> any impact on qemu-system-$TARGET".
> 
> Experimental doesn't mean unusable.
>> - let's go with original plan, and just introduce -target option and
>> call it a day for now. CLI refactoring can be initiated in parallel.
> 
> That's exactly what Daniel suggested.  In fact the same is true for more
> things than just the command line:
> 
> - filtering can be applied (if needed at all) to qemu-system *after* the
> binary is available in qemu.git, exactly because qemu-system is
> experimental;
> 
> - if we decide later that -target is not always needed, that would also
> be doable after the merge.
> 
> I hope this helps not so much solving the technical disagreement, but
> clarifying that yes, sometimes you've got to "agree to disagree", but
> personal attacks of any intensity are not "agreeing to disagree".
>

Thanks for the answer Paolo, I took note of all the points you mentioned.

Regarding the future direction, I would be happy to see an 
"experimental" binary, without any symlink set for now. Beyond filtering 
we can implement or not, my understanding was that people involved were 
not in favor to see -target option.

A solution we could have is indeed to expose all machines/cpus/devices 
(knowing it will very quickly create more problems with QOM types having 
duplicated names - riscv64 vs aarch64), and let user pick any 
combination. However, we still need a -target option to set the correct 
TargetInfo internally, independently of all the rest.

I'll let someone else do a proposal on the topic as I spent a lot of 
energy on this with a specific direction (option + filtering) without 
reaching consensus, and I'll be happy to follow any direction that will 
be accepted by the community.

> Paolo
> 

Thanks,
Pierrick

