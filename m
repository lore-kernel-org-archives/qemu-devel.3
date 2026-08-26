Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F79FC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIka-0000je-1Y; Wed, 26 Aug 2026 14:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzIkX-0000iJ-PJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:53:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzIkT-0004ne-Fq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:53:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGuoKu1310594
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q+GuKNhmSV5MwT9xgzo64fFKH6ElJEq/Qt5ZuoMbN38=; b=OCL2F8NDN2Ng3hbc
 CBFVJ6bGdb3mnx16Gpot+D9Ll6izeHMBMHvhz+LjHqisqb3MfPv6L/NUc3e8yCH6
 1DbSZLHHbL8LxSNS+p4nHFV1+RaMJfEAriNS8A6sszWCFCMzcYm4Wd2oi30BFUSK
 62zNzzeOzFOVCZ91lNOASzaBcS453IAl6HIGyyfYcsEYA41HXXdfKxG8q1fcYFLG
 Rexb+SnjAyJnmwQQHKLt3/sjFE4g+roM36/RkB74b92yvZZuU1PQ/pt9vU7wfxgy
 Dk0MuGZd/HEq25xX2NRz1w9xEbE5uRA7MgrVPWOXHMJ3xHLMaf/jxgDWazEknLpl
 HvPoTw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03a9j1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:53:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso144873a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787770399; x=1788375199; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q+GuKNhmSV5MwT9xgzo64fFKH6ElJEq/Qt5ZuoMbN38=;
 b=KpQYhXqRuffWKUWRh1EE7DpQ7sNESLgQD2z3nVTlxMZigRE58bEub+K6sJONyMgd5w
 FLDo2w+P6/xmZ0wtMr5zYTptn/DPl3LykQ/rj5y9WJ+PZ3JwnHFP9E/KL7djyO5kx5tG
 3QKS6HhBbowtqY1LbEGXqhRipukXWRsr3n0/+1shE6agiSqnxYjs/x12A7Yb9NnPLWZ1
 yTPW45vr1YPR3MStdks8XNBWp4IumEjlJZ14mONn29WDueB4yQpJkxQn2i1zdwoPyYnQ
 2Sov9xnyAws4mUAF0YrkOIX1uOh+7IglKS9qeIcAOZAhnVWcQxDeJVsKiTk73Z6wmBhp
 JLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787770399; x=1788375199;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q+GuKNhmSV5MwT9xgzo64fFKH6ElJEq/Qt5ZuoMbN38=;
 b=eSgPVhRXGo6MSCelZUpbGu10UOqBHRA6e/tqnaC66vfOR1up3sThKv5GyhKsVjzQlg
 0GOWP9k1agi1053j3YKCMixF+N9MmpehQZZJ69WWkMYn1WxK0MpuP+7WmXRFbclrJpyF
 y+eU0TKgHA13odM5zAADHgUWgnHuYkK9pbSaJgstD0fbH5yiLAnzAfhXIt4w35eLYWyT
 HycR5MLTBM0sZF4SV5G91jwwg2RAF4MSs8rNAGC3l2Kmpuu1b8NIm5tXa0gA8jzlSnFC
 wY+kgsdKKiHM/0+8M6eFPgCIpsqPCX/yWJultVdXxlifMoLGkC03ws3vZjGxf+6xh/6+
 fu3A==
X-Gm-Message-State: AFuF++kbdvUKzVLwD8ZOsum/UPsSFSCDt5XifG6ZU5wcmV3XnY/i8ED0
 UTnELLZ9JMUev7xVe7ktgLOSs3FpboFekNgSXxBi1OcFLc0hcLspk4MflcN3V2HHt9Qk+evVTIt
 AfQ797h3er0G5NkLsSFlIE8MQsPXf6AwQ9ggPEVCZurRKOAh8Rhnf8D9Itg==
X-Gm-Gg: AR+sD12zwr8Vy7SG06Bn7RVpRILsvcNDuGLu5doO6UzGEDfzhGf/hEeO71G0tGrvM5m
 6R85+w6bTqp4AiNuVVu/zTPKzTdovTKW0QEVGUX4RxuELX7o/6HYNoe0SxFoniwrk6eHqof6Tl4
 IyeX9ljxSckKxMQ7EgHRgcOxrm3fNUqKzystjyoz9jRoLBU8b0LkBiQIfhMoP18Z2ibwAXi4lIB
 X/eyMN8EdEDxU/ijzNeoPwuOJ/OWyrOAV48DjjT82kpZAvAXQkFOhljcPl2WKUi423OFqv0tj+G
 mUjSYDIjgVXY4oJXpN0Zlnu5gaEeTbUWIs77fmgHc8tS6oClRTdRtr90os87naH1UDhRpbIuF2U
 s7sKz73F6/VxuT2kpROiURCNfrzErDh+GOjaAO/JV1FDBPWfKAejTBNRqVZSAdjAxKxy+
X-Received: by 2002:a17:90a:e7cb:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-3969bb7ae09mr1106208a91.5.1787770398819; 
 Wed, 26 Aug 2026 11:53:18 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cb:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-3969bb7ae09mr1106165a91.5.1787770398278; 
 Wed, 26 Aug 2026 11:53:18 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d8d208csm10526105eec.23.2026.08.26.11.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 11:53:17 -0700 (PDT)
Message-ID: <6c38922a-c733-4444-89ba-cfaf9397a1ea@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 11:53:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>,
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
 Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <b2b1d77e-c3e3-4aad-87d2-f5d4834abd1a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b2b1d77e-c3e3-4aad-87d2-f5d4834abd1a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CqN5_JM_syV0rdKKIjPNikJAaQEriF7y
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8f361f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=vnREMb7VAAAA:8 a=_OsohoArVhiiuAOQVD4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: CqN5_JM_syV0rdKKIjPNikJAaQEriF7y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1OCBTYWx0ZWRfX4yQuUMrhJUHG
 IZf3LKKS9ezpPTbLg7QNcnZUNQPVph3uJFEseG/Ls/+v0qL291V2+Ow6czcdQmLbEYVa4khMD6C
 t+/1nF8MDNnYEzeviP1hEmVbuJg10/vfCJO+s4mvHaMKi6nGXVAC/PA/X0wOqqf18T+5BKEF60J
 dRqgw35drmd+TVDXFvvzTe9gcMXZZdA8Jiba08z6g7RlVoGPbgHEjSlVJt3zK+LromjvXVhmfHY
 Rkyc9o7ckOIQ+6lMX7boUbLYYQcyVSfu9FIVfiwbRIyeHqGKwQXibYwsaTlpGf1k7Pttk5tHl/t
 UeJdzDDOHd1KF8wNa3YfCccqd+MXWeL6LHgszUmfIYOy3W26W3aV58kDcgS2aa6s0x46QWcE4bk
 ktoDlHpT8EHI/p650Jpz5lYgxdmNyud4WgsukGgJInsjdMk4iVqVZrE7V4o4XrEX1Nc/KrnAIzC
 I0bkX2hRscjW7TX+sow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1OCBTYWx0ZWRfX5g/s5Nyc/wVl
 qxEu/aJcR/joYQUjtYpPmXK0LJQETgDNRf/yttS5sDLrVuslbOB5Vgd88LJvT85EylCcbMOfg+D
 Z+VmbMGCXc3k1q1AORiztL+MURcrLoA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260158
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

On 8/26/2026 11:35 AM, Pierrick Bouvier wrote:
> On 8/26/2026 5:32 AM, Daniel P. Berrangé wrote:
>> On Sun, Aug 23, 2026 at 11:07:18PM +0800, Yonggang Luo wrote:
>>
>> snip,
>>
>> ..to comment just on the end result for now..
>>
>>> The last patch builds qemu-system (and qemu-systemw on Windows) from
>>> aarch64 common/system objects plus RISC-V arch objects, and installs
>>> qemu-system-{arm,aarch64,riscv32,riscv64} as symlinks so argv[0] still
>>> selects TargetInfo.
>>>
>>> Examples:
>>>
>>>   qemu-system -target aarch64 -M virt ...
>>>   qemu-system-riscv64 -M virt ...
>>>
>>> A basename that matches no registered token falls through to the unique
>>> default. A combined binary with no suffix requires -target when more
>>> than one default TargetInfo is registered.
>>
>> In testing and comparing  the new qemu-system-riscv64 symlink
>> to qemu-system vs the current standalone qemu-system-riscv64
>> binary there are some significant user visible changes.
>>
>> The simplest is 'qom-list-types' went from reporting approx
>> 770 classes, to reporting approx 1530 classes. IOW, the
>> qemu-system-riscv64 binary is now reporting supporting for
>> all the classes that were unique to arm.
>>
>> The '-device help' output similarly shows a great many more
>> devices
>>
>> TL;DR introspecting qemu-system-riscv64 is no longer accurate
>> wrt riscv64 capabilities. 
>>
>> This is not suprising, since we register all TypeInfo meaning
>> we get all QOM classes present. Some of Pierricks patches try
>> to filter places which iterate over classes, but this does not
>> have full coverage.
>>
> 
> I would add that if you would focus on reviewing and helping for this
> filter problem instead of reinventing the wheel for command line, it
> would be solved by now.
> 
>>
>> I think this is probably also what leads to the increased RAM
>> usage in qemu-system-riscv64. Starting
>>
>>   qemu-system-riscv64 -nodefaults -display none -M none
>>
>> shows an increase in RAM usage from  17.3 to 20.7 MB which
>> is about 15% increase. NB this is dirty, private RAM per
>> process. The shared RAM pages also increase but that's not
>> a concern since they're common to all QEMU processes.
>>
>> qemu-system-aarch64 shows a much smaller RAM increase, since
>> it only grew from 1430 classes to 1530 classes.
>>
>> We have many more target though, so if we assume the end
>> point where every single target is unified, the the union
>> of all classes for all targets comes to approx 3600.
>>
>> My guesstimate is that would mean a memory increase for
>> qemu-system-riscv64 from 17.3 to 39.9 MB, which is a
>> 72% increase.
>>
>> In absolute terms this is still modest, but for deployments
>> with large VM counts  and small RAM sizes, that gets to be
>> significant.
>>
> 
> How surprising (:eye-roll:) it is that adding more code and more classes
> would result in a higher memory usage, or bigger binary size for
> qemu-system.
> 
> More seriously. If someone is concerned about it, the simple solution is
> to restrict list of targets and/or Kconfig to include less.
> 
>>
>> None of this means single binary is a bad idea.
>>
>>
>> My main takeaway is that we're creating uneccessary work
>> for ourselves by trying to make 'qemu-sytem' identical
>> in behaviour to qemu-system-$TARGET.
>>
>> The complex filtering patches / QOM interfaces that I
>> found uncomfortable in Pierrick's base series are largely
>> around the filtering needed to simulate qemu-system-$TARGET,
>> and they're still incomplete. I don't have high confidence
>> in our ability to avoid regressions if we go route this
>> route.
>>
>>
>> IMHO we should make a clean break with the past. Leave
>> the existing qemu-system-$TARGET binaries being built
>> from the same pieces they are today, such that there
>> is better confidence that we are not making behavioural
>> changes to them.
>>
> 
> Funny enough, it reminded me word for word of a blog post from a
> Microsoft employee where he explained that powershell existed only
> because young developers were scared to modify original cmd shell.
> 
> Regression issues are solved with testing and good design, not by
> inventing new things.
> 
>>
>> qemu-system should be built alongside qemu-system-$TARGET
>> and offer new semantics where it is documented as exposing
>> everything from all targets whenever introspected and does
>> not apply target type or target Kconfig filtering to inputs/
>> outputs. 
>>
>> We still get the benefit of only building most  .o files
>> once, so keeping qemu-system-$TARGET is only a small
>> overhead in the final step of linking everything together.
>>
>>
>> qemu-system will still have the increased memory overhead
>> but that's fine as qemu-system-$TARGET will be unaffected.
>> We can tackle the memory overhead of qemu-system at our
>> leisure through use of loadable modules, and thus not have
>> that as a task to think about today.
>>
>>
>> With the clean break with the past, we also have the
>> ability to tackle various long standing design mistakes
>> present in qemu-system-$TARGET instead of carrying them
>> over into the new binary.
>>
>> Specifically
>>
>>  * -nodefaults should become the default
>>  
>>  * All CLI args should be processed in order from
>>    the command line, so we eliminate the nonsense
>>    where we process some -object, then -chardev,
>>    then more -object through hand crafted deps
>>
>>  * No default machine type
>>
>>  * Drop all legacy syntax so we only have a single
>>    QAPI based way of configuring.
>>    eg drop -hda, -hdb, -cdrom, -drive, etc
>>       only keeping -blockdev
>>    eg drop -mon, -monitor, -qmp, etc only
>>       keeping -object
>>
>> We don't have to do all that straightaway. If we declare
>> qemu-system "experimental" initially we can iterate on
>> that intentionally breaking compat in releases, without
>> any impact on qemu-system-$TARGET.
>>
>> Avoiding the back compat task will give us more flexibility
>> with the follow on work when people come to create new
>> machine types with heterogenous CPU targets.
>>
> 
> Seems like the Genius.Artist. in the bottle just need to escape, and you
> can send us a nice series doing all this. Meanwhile, I'll try to find a
> carpet, a monkey, a princess and a suit to be the next Aladdin.
>

I was wondering why my brain connected with this, but watching "A whole
new world" video clip and lyrics made it obvious.
https://www.youtube.com/watch?v=EXTLJmYsaUQ&list=RDEXTLJmYsaUQ&start_radio=1

Now, we definitely need an AI generated version for heterogeneous
emulation :)

>>
>> With regards,
>> Daniel
> 
> Regards,
> Pierrick


