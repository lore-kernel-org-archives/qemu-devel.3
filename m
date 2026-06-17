Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69FECD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvOE-0001gy-Mq; Wed, 17 Jun 2026 14:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZvOC-0001gk-Ph
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:53:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZvOA-0008LM-Oi
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:53:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHdE4Z2895757
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 18:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W67qwx31U7nlTDryYWeQEWy1gT6HVjlNT1qVpG3WyDQ=; b=Bnohi4fTfFbgjAQ3
 jLFMiWCxA0huoXDaZM8Ptv/BCfrV5vO8EDgKrpt4vgVjfIW1WHQgVtpNI4mQclLm
 xQWn0DL3sJQH76rLyHRNoiJmhCCanrz4o7GlDiJzOn+ONkY/ESkQMcNLTrE8gURw
 ogOj8HMm76HXKvX3KuQVCpnsyeKEBcHsrnwEzz5Emxw0UrTti2keKOf7N6Jhydp/
 WcnCf68D5DQvnVqgdwJdfdQQcXLYI1tgDy8rOhD8ryD7SQFdKiWmVGwLQPBKC3Ev
 rly9GiCTO02jZnqEhAgobyOHOuqNxd3biuKVhOWOK0PM0zk+J2onG6ehCgzoO196
 n8PR8Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer4xss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 18:53:23 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso544297c88.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781722403; x=1782327203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W67qwx31U7nlTDryYWeQEWy1gT6HVjlNT1qVpG3WyDQ=;
 b=O9yCxYbFWnLmxNiBj5177ibadXu42oGuzqY4rD6kbYP0JMOQbwmOTDExA/eOFtJiHw
 SJV4HniJ4PQVSH8TU3IvV5UJI3/NXQsYDHGc5WYMCsldOMJrdhX4BlZ/TSZMHtU6xosg
 up++AhNAv01TAJ0KE5HYEpdV0IzhwcI+43h1SP4PF1oku4P+ZdUXe5eOPO/GHTwu8nO5
 mT2zOM9iXyWSQcSMlF1yf5B2P9puo0ukSS+0elue7d43AecFQcHt8mE//7zgWC4bmVAJ
 VyMzjNexJukKCBA+rNnOwW95PhKm14jXrkC+0FTacmG6WkfklYzwgeuJAELnJRFlY7qB
 wJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781722403; x=1782327203;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W67qwx31U7nlTDryYWeQEWy1gT6HVjlNT1qVpG3WyDQ=;
 b=mtNe2RUpNaWemwVukdv8kKXOPBGklNCPMxltSj23EauDzr9drLRMILvDQBIIJsjk5c
 i2qhQJ8LTUzJUfUxCfJEkoXs1//9v5gAyRj465g7TJU2rC+DOR0tOKnWOHr8vLGwTDGg
 1evl9P96StyAIRLF4CiV9xzFO6UmZncppI3ykNFRNbvxli1e+hLefYbzH6dLY8j5Otbr
 YOoW7wtWpRG/ePfwWpaMzxJWuabI+xgsKOlEx8Jyd53Q6Y/AlmrF0ld5B09GNcjDHHrf
 KamzMhboJyh0vdxsolURMa140y1mEDYXsHLuvlzXTAt9JFtSlAYf/gNRhqvfF8hHFcxN
 tYXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tM7GmGbOFjvD3JBYbmMWClEOAPpue0BVTEuXcZ2ZAYcLVNSEfYuxsVHw4DTDdspCIaOQaeLmL8KwM@nongnu.org
X-Gm-Message-State: AOJu0Yz0e9J9jviF9D8O0HJCAyffPWLOnltZYbeuVpTizhFuw/6TpX0J
 nx+TysqEjfG2r0MNvUs+zxIiLgca+GzMIQ7vIVvmo1vwzy08yI9/PgzHiLgWi6ZptddfbfFw6WQ
 8WUYpDEY4Dxz/1q/t+LvgjrphePef/gLDOA6SASR3ieVJzSD4X2o1Ld3T+g==
X-Gm-Gg: Acq92OG97hGFfs5V1SevBRS8pmv3QtsWGnVsNZzfuT9q3xYDVA+ElxDFuUNOAiQx+WW
 HFiL4dm2Fnr2nl3mnkEtXCXBCQCHXKrbK1DyW4cIwxKRPrFY5CcTzXq/iQgjNsZdNSnExwim0Zy
 ffNSNiATK2L/xI46xOVTDATKD8vMK8lneQcGX6HjvCPaxfe94wt6eVjTHui81Jz6BR3fS5J+xr7
 MDxvL1oI6LP/gJXA/NeTLS32/CGR+lBNy3fY8mG8sxQNBt9maJJLtVze4j1W1JON+Naf2eHXkKu
 ggvyTTPR5A86BQ5E7KEv+th0wW4cNbUsLbl1wos7YeBrwfuTacju3lMlVoeK+pDx/XOJIloTZLb
 Lhf6vXF7oGAcIzrK6hH6rTcdznCCsprdqItvJiAofB/3g04ltxArJqzYhhZ+loXNawjayk2N2fC
 lQnwA=
X-Received: by 2002:a05:7022:baa:b0:12d:b993:c68f with SMTP id
 a92af1059eb24-1398f66afdbmr2007679c88.4.1781722402923; 
 Wed, 17 Jun 2026 11:53:22 -0700 (PDT)
X-Received: by 2002:a05:7022:baa:b0:12d:b993:c68f with SMTP id
 a92af1059eb24-1398f66afdbmr2007652c88.4.1781722402325; 
 Wed, 17 Jun 2026 11:53:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b9815a6sm17583374c88.15.2026.06.17.11.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 11:53:21 -0700 (PDT)
Message-ID: <1867d155-d43a-44dd-9ce3-b7c2a0626f00@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 11:53:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
 <ajEA4CybcZHwYEEF@redhat.com>
 <CAFEAcA_r2+S+iy4nu4Kv9Gjwsu_izq5iHUYs6vycq=dX-+Cpsw@mail.gmail.com>
 <72a4533f-067a-4539-99a5-ebbc34224167@oss.qualcomm.com>
 <87mrwtpu3v.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87mrwtpu3v.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WVM3noueImU6KCT9ugbWQ0A3bo4gMtpy
X-Authority-Analysis: v=2.4 cv=Mr1iLWae c=1 sm=1 tr=0 ts=6a32ed23 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=_tpOQYEyFRvxsKipNSAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: WVM3noueImU6KCT9ugbWQ0A3bo4gMtpy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4MiBTYWx0ZWRfX/tEx2MNM0hX5
 SJ5qKyRZdedspQYb2jwdRiifvsM3FBSt6czKvNKdYkZ0Zg/S8hGw8Jwtp7y2L1DREAYJOwDv0Hw
 n3ZNiyfAbqH0UQFSHTbsD5oQhQJphjQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4MiBTYWx0ZWRfX3FoVQBs+vm76
 EPx22wJCcYBI9b3nJH0cz2Wvsev9/eTNYJVxT39NyzDhRKuQCLay+pRr1BFCzHDIPy0GA4AXwBx
 QcGOrWEBQy7gt1HtRW6eisJbJIV5P6xzIsL6OKRcoWePgjGoyBOJ8IoIbHissLFPh3pwrXE3aRl
 d2Kwhwn0l56hIoClaqGDqGinJoMoq4fxmgcjlsDqA+EAPSF44DEXhcl9ztSd2B8Kmf4myz1aq25
 nHs7oqtUMoUpF2/gm+trwl+QW3jXWr2n1beBvqTVYZyhxJBkxnyH8HbVqLD2Ehkwo7vU4i+KnVe
 jb6nvlr77kcsonzDmO8unsG2Pi4ZZwIJdqEj0YR4M3KvdOhaj8PsPuT1meoEJtyCuONMCOH7o1S
 kv+NOOvnBXz7Hz68Do8W1Or+nXk/a7NVWRPrWuQGKfT+TgNTPz0XjzOGD5THGTpZoHJolYJNoR5
 GxZ68QT8srfdygrFjKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170182
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

On 6/16/2026 11:19 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 6/16/2026 1:30 AM, Peter Maydell wrote:
>>> On Tue, 16 Jun 2026 at 08:54, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> On Mon, Jun 15, 2026 at 01:17:23PM -0700, Pierrick Bouvier wrote:
>>>>> We add a new script: scripts/check-maintainers-file.py, that will run at
>>>>> configuration time (and not at build time), to not hurt build time.
>>>>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>>>>
>>>>> We can expect things to be mostly in sync since adding or removing a
>>>>> source or test file will trigger a configure step.
>>>>> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
>>>>> build things from scratch and always run the configure step.
>>>>>
>>>>> With this, it should be impossible by design to have an upstream
>>>>> MAINTAINERS file with non existing file entries.
>>>>
>>>> Accuracy of the MAINTAINERS file is an upstream-only concern, but
>>>> IIUC, this check is going to apply universally to every build of
>>>> QEMU which is undesirable. It is irrelevant to end users and not
>>>> appropriate to check in downsteam vendors forks.
>>>>
>>
>> I accept the argument about downstream forks even though they are free
>> to remove the check since they are... forks.
>> However, it's relevant to users I think. It's very easy to move a file,
>> and forget to update associated MAINTAINERS entry, and the sooner we
>> catch that, the better. Similar, when a new file is added and not
>> covered by an entry in MAINTAINERS, it's very easy to miss that.
>>
>>>> In a "normal" modern project this kind of check would be done in
>>>> a CI job on the merge request, since that's the only place it is
>>>> relevant. In our case, the nearest fit is the checkpatch.pl file.
>>
>> It depends how fast you want to catch the problem.
>> Adding yet another round trip latency to a project that already has a
>> multi day latency for upstream is not a good thing IMHO.
> 
> Yes, and ...
> 
>> Also, it brings yet another burden on top maintainers that will have to
>> deal with this new failure, fix it themselves, or recreate their staging
>> set for the next batch and wait for yet another day. More time spent,
>> more noise, more iteration, just for a missing line update in
>> MAINTAINERS file.
> 
> ... yes.
> 
> We might have conditioned ourselves to consider such loops normal.
> They're not.
>

You're the first person I read here saying it's not normal, that's
refreshing to see some lucidity instead of "It has always been like
that/I have my own tempo, suck it up".

>> All that is nonexistent if no one can build it if it's incorrect. That's
>> why we use -Werror by default for instance. And if someone sends a patch
>> breaking this, you can be sure they didn't even try to build their own
>> code/doc/test.
> 
> I don't want make to fail during development just because I haven't
> updated MAINTAINERS, yet.  It's a distraction that could snap me out of
> the flow.  I'm developing with -Werror disabled for the same reason.
> 
> I do want make to fail before I send patches.  I do another compile with
> -Werror enabled then, but that's just my personal workflow.
> 
> Solutions I like well enough:
> 
> * Make it a compile-time warning that obeys --enable-werror.  Could well
>   be more trouble than it's worth.
> 
> * Make it fail "make check".
>

This assumes everyone always use make check.

Spoiler: a lot of people, including myself and experimented
contributors, sometimes forget it. To be honest, I never run any
test/check on my own machine, and just let GitHub do it for me,
relentlessly and consistently.

If we take a step back and consider the recent series to fix
MAINTAINERS. It was like 40 patches?

I don't know which period of time it covered since last time MAINTAINERS
file has been consistent (if it has been one day). But let's say a year
at least. So, it means that maybe 3 times in your personal life, when
you'll move or remove a file, your flow will be interrupted, and you'll
be given a chance to fix things directly instead of hours later. It's
very different from -Werror that may hit you more frequently. I'm sure
you get more door bells/phone calls interrupting you than this error :).

We can't do anything really consistent out of breaking the build, or
break the CI. And break the CI adds latency by design.
Git pre-commit hooks are a good way to deal with that (with formatting
also), but we can't enforce any of that unfortunately.

If we choose the CI way, truth is that top maintainers will pay for the
cost. I'm not one of them, so can't speak for them, but I feel like
solving a problem by narrowing the existing bottleneck is not a good idea.

> Dislike:
> 
> * Make it a checkpatch.pl error.  Stays out of my hair during
>   development, but then I have to remember to actually run
>   checkpatch.pl, or risk having CI bouncing things back to me, wasting
>   everybody's time.  Meh
> 
> * Make it fail CI in some other way.  Worse, because now I have to
>   remember running checkpatch.pl *and* that other way.
> 
> * Make it fail "make".  Stay out of my hair!
> 
>> Does that open your view on this approach?
>>
>>>
>>> You could put it in "make check", or (if you want to avoid the
>>> downstream-forks issue) in some sub-bit of "make check"
>>> that we don't check by default but do check in one of our CI jobs.
>>>
>>
>> If argument above is still rejected, we can just add a CI job (calling
>> script directly). I'm not sure any kind of integration is needed. Also,
>> not sure where to fit that in any existing test suite to be honest.
>>
>>> checkpatch isn't a great place for checks that you want to
>>> stay consistent on because so much of its output is "this
>>> is wrong/merely something to check, ignore".
>>>
>>
>> I agree, checkpatch is not useful to enforce things. It would be
>> different if it was strictly enforced in CI, but that's not the case,
>> and won't be given the false positives it brings.
> 
> CI should only reject things that are actually wrong, or at least
> undesirable.
> 
> checkpatch.pl warns when you add, move, or delete files without updating
> MAINTAINERS.  It's only a warning, because MAINTAINERS may in fact not
> need an update.  Not good enough for CI rejects.
> 
> The purpose of warnings is to help maintainers and developers find
> *potential* issues.
> 
>>
>>> -- PMM
>>
>> Thanks for both of you for the feedback,
>> Pierrick
> 


