Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE3606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QyrDzsoQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlE91NmQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJYja-0001MO-EJ; Wed, 21 Oct 2026 12:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJYjW-0001Le-3u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:00:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJYjT-0002uG-J2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:00:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFUAXD1481680
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3sLN+VtTp1GT8KmOAKZ03sJNJNMbdc2oxGQOgY6Wvh8=; b=QyrDzsoQEriiqCmP
 aDq+BxvCGhjqx7PWoGj+up5DqMjCFJ2TCWGhLDaHan+drQQgLCmmy4ipwTeU40QO
 3U1wKtKFCYvghVtPH3aM+cFUaN9g5AUOrLiNPWA6QhACstZRvXtCBsTXQnUv8o6d
 tGCkzopjj/jeqHYUVS01Ros9Ic3oOYMNs4p5JWpwn2DqxsucI5tSlUYIbJ/kfJgr
 gB4QzGFHoNAwnTOLA2Wt5NrVBoYJyRPgHFteEruWy2SQDw9g35PgShrMfHzcnKQi
 A4fihztwi2aC3pVNGewxEF/uGlGeTtTsz4evneUxbD/2XB3f4M5Nr7oRuVIDmff+
 UwrY4g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs0423s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:00:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so3205614eec.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598399; x=1793203199; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3sLN+VtTp1GT8KmOAKZ03sJNJNMbdc2oxGQOgY6Wvh8=;
 b=jlE91NmQCWoJtndNiCoWtoUZv1KQKA8a44kjOnSnXLSpbjjIVTpCAcOyzE1q+lfZm5
 hX2p22nq+QBourSe/2AtJ75bzRevqdJCtgqml2HKR9WHK+Jmhtryc4PR8ZX8upxWme7q
 a5scjMsEoDTeH/Rd8fG5xrnuRwmagm++Cb/paqaDG9LfAEVMV3TkK1Xeeox8Znp0X5Zc
 mzr7bTerM7o6XKQLMi7EfNIs2NKPb0pcU0sle5LPuqPv6mfke1S1bXsE5+5ljvBzPX0m
 ht+PlQnpv0zeq8Dt1OfsL/3lnvcOTY3ZhaK4/427tH5Oa6lg9yX5Pmvdes6HjANmDVwV
 /3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598399; x=1793203199;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3sLN+VtTp1GT8KmOAKZ03sJNJNMbdc2oxGQOgY6Wvh8=;
 b=mVJozM+zgbQIgZ+yLluZno1SmRP2NEThCgiV3vYLlr1CkJM6RVLxMdeot3U8CjFFL0
 cRkXfN1ULCY0uzo9jaahXjOLSaVnoQaVWu/NpuLKsBhyos0LLEx7NhJSfRF+1SJgieQM
 YDI+7Uny9AdSmI/cvbHcPO4zwTMoQbJ0n5xYnDfsXwb3e6NsIEtun4nILZW6HB4YjehD
 XRxnr/VBU9Vc0nmFbVi5ncx2rX0UVLBahHRZGbr4RLZma0eB0CofK6TD64R4J7/Cn85S
 32GphGo95yRnTGRL5DJ/ROCrou2yjmsyri1HGLD8oTYDmW//cbNtcsYDUIux8nBmDy83
 kyeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUEuNOCbv6sNijXPmcLVfuyxpeHkUT7mOggirjrctf7hyP4UsgR3BCNG1SV1pVgdDtWmKIj3hJbml1@nongnu.org
X-Gm-Message-State: AFq9FYKNGa3p0X8ahNHGTPuLot5/VHKvxekxy0Mq1Nsg8n4zrRkhu1BM
 qiE6zHusgUbsxh7yfGMNF6nb0BY96Sh4VfwBHiHV7G+Sr2hcxHGtudSsBCpM5eGRBGC7csNKoll
 lqtqugb/jIPRwQre0TDyAuD6DTMTIgOa1pUWFIQJM209UDn7BZoWyEj7+Dg==
X-Gm-Gg: AYBFou3b/EPtxIVAw0cnkJerlK+na1/dpceQJyjPOCNqAz68h5A23+S/1PxOPzOj6N+
 LWJtnxeEk7bbNA8pz69GSsUV8O1tkZ4+bZUJaCDgfiWQhalJzDUbqr5UzN8IHhYm67WKuSrwoBg
 oAAcbO+Ngtx4Ekr8LfFLMoafIRulkbm1AvDmxeAFCtP8RaNhdM6nPIDGDFbKxyeOOZIptNCrfL5
 6/kUXf5nGaqrGWCA2cM7iUfeP3oEib3J+nq6PBsWscbwPFgho7416KgBunA1FDTXjsljzvWvo6W
 uFLlC1dE4MqQGs+dPE7Yi+UiqBFiT6HOpElHssWQKNL6lXwSXkW5nlRZ3BIeJ9SxPKm+eiHBKUN
 VIP2RVi1+jFxijPXOH0uRFnV4l5/WX1vXGxMiPI4Dih56zZtOMnej4adfay7uhaqRlq++xw==
X-Received: by 2002:a05:693c:60cf:b0:353:8205:8558 with SMTP id
 5a478bee46e88-3674b82ad86mr4645769eec.5.1792598399088; 
 Wed, 21 Oct 2026 08:59:59 -0700 (PDT)
X-Received: by 2002:a05:693c:60cf:b0:353:8205:8558 with SMTP id
 5a478bee46e88-3674b82ad86mr4645721eec.5.1792598398275; 
 Wed, 21 Oct 2026 08:59:58 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cca3d8sm8346775eec.14.2026.10.21.08.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 08:59:57 -0700 (PDT)
Message-ID: <834c24b4-7e0f-4664-9242-5033afeeb48f@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 08:59:55 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: add automatic retry
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
 <ceab474d-ea17-41f8-817c-86f90c0feef0@oss.qualcomm.com>
 <CAFEAcA8-evgTa4GgvHV7HjUAeqnee1CN3onAK-EBH42saRqNag@mail.gmail.com>
 <87fqxz1fv7.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87fqxz1fv7.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad8e181 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kFd27rduAZo37rJrp94A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfXy/ApfIrSPM1+
 zqP8N5o8ZxcbkVQqSRBs0te4DexVMZMB7Vhfi9usNPDFUB3oVKte5gFT90eCQa7EJSDUF5V/6Kg
 cUdErYPJoxvBliR2xir9orFbxS26iazx3j9jZyIqyCGrhbXGfBlCKRVtInhPc7MfI7cFGgt6U+E
 dI/vhdHK/kKYtTNSigg8bH3Pa2ya+MdZLkm9qsFne9nINzVoucaUV/YP2UxO5Uo0qzRF/BD4q+2
 6XJpGS3Iwf7VvdmbJf/+4xSvSWL18Xsgjj/wKQDxIaZccAs6g2dusyekJ6eZicr76VO55fK0bWu
 lT7gcY2DSoXAOpbgM5TQq1JeWSKGaa0ENafMyLORKi01aG0xvvujHDGb4kQJUKWkSu+IrkBEpQO
 EjnRFSUuuTPfIO0CzW+QQZel6jPzXa7pui3Tp76ZTQHLaasl6bqZo+Znz6rF3Uh8g+UY6HYQpaZ
 h2vR3/XFUEJHbgMXb+w==
X-Proofpoint-ORIG-GUID: eYfP8LgLa9QL88l36m3Ae__5-EyZ0hUa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX2UXZVtb1yfxW
 Dl/gFwppnU1lACoVZTXvU2AX/myjoVeF6UPr01cEt4Fwzg9yTRfnYuKZMDHWa41SE33Rm2y2gmv
 QoAJWLb+WknwsG+A4vgMhWHlPGUIQfg=
X-Proofpoint-GUID: eYfP8LgLa9QL88l36m3Ae__5-EyZ0hUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210063
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/2026 3:56 AM, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Wed, 21 Oct 2026 at 03:41, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>>>
>>>
>>> On 10/20/2026 6:16 PM, Pierrick Bouvier wrote:
>>>> When merging PR on the project, it's possible to observe failures on CI
>>>> that can be related to sporadic test failures or infrastructure issues
>>>> (pod eviction with Kubernetes). As a result, it adds latency on the
>>>> process and workload for our top maintainers.
>>>>
>>>> This patch sets an automatic retry (supported by gitlab out of the box),
>>>> so failing jobs are automatically retriggered.
>>>>
>>>> It's important to note that in case there is a real test or build
>>>> failure, concerned jobs will run a second time, and fail again. That
>>>> said, it happens seldomly since sub maintainers are supposed to test for
>>>> this before sending it. Also, the retry is limited to the job that
>>>> failed, so it should be cheap in terms of CI minutes.
>>>
>>> Will this effectively mask those flaky failures so that no one hears
>>> about them?  Is there a way to find out about them with something like a
>>> weekly/monthly digest of failures?
>>
>> Broadly speaking, it's already the case that flaky failures are masked.
>> Random infra-type failures / random timeouts /etc are common enough
>> that when I'm doing a merge CI run I will just hit the retry button
>> without much deep investigation.
>>
>> In an ideal world we'd pull down the gitlab job history and look
>> through it for cases of "job X failed running against commit hash Y,
>> but we also saw job X succeed on commit hash Y" (i.e. the retry
>> worked second time) and then check the failure logs for what
>> kinds of things are intermittent like that. But that requires
>> somebody to put in the work to do that analysis. Gitlab's own
>> CI job history web UI is very bad and doesn't let you do even
>> basic things like "show me just the history for job X".
> 
> The gitlab-failure-analysis script was an attempt to start doing this,
> so the last 10 failing staging pipelines where:
> 
>   $ ./scripts/ci/gitlab-failure-analysis --count 10
>   failed pipeline 2949515618, total jobs 120, skipped 5, failed 8,  45059 tests, 1112 skipped tests, 8 failed tests
>     Failed job 17194356901, block: [luks], https://gitlab.com/qemu-project/qemu/-/jobs/17194356901
>     Failed job 17192659533, block: [vmdk], https://gitlab.com/qemu-project/qemu/-/jobs/17192659533
>     Failed job 17192659440, block: [vhdx], https://gitlab.com/qemu-project/qemu/-/jobs/17192659440
>     Failed job 17192659398, block: [vdi], https://gitlab.com/qemu-project/qemu/-/jobs/17192659398
>     Failed job 17192659309, block: [qed], https://gitlab.com/qemu-project/qemu/-/jobs/17192659309
>     Failed job 17192659287, block: [qcow2], https://gitlab.com/qemu-project/qemu/-/jobs/17192659287
>     Failed job 17192659245, block: [parallels], https://gitlab.com/qemu-project/qemu/-/jobs/17192659245
>     Failed job 17192659237, block: [nbd], https://gitlab.com/qemu-project/qemu/-/jobs/17192659237
>     Failed test qemu.block-nbd-optional+block-thorough - qemu:io-nbd-nbd-stale-connection, block: [nbd], 1 raw nbd-stale-connection
>     Failed test qemu.block-parallels-optional+block-thorough - qemu:io-parallels-nbd-stale-connection, block: [parallels], 1 parallels nbd-stale-connection
>     Failed test qemu.block-qcow2-optional+block-slow - qemu:io-qcow2-nbd-stale-connection, block: [qcow2], 1 qcow2 nbd-stale-connection
>     Failed test qemu.block-qed-optional+block-thorough - qemu:io-qed-nbd-stale-connection, block: [qed], 1 qed nbd-stale-connection
>     Failed test qemu.block-vdi-optional+block-thorough - qemu:io-vdi-nbd-stale-connection, block: [vdi], 1 vdi nbd-stale-connection
>     Failed test qemu.block-vhdx-optional+block-thorough - qemu:io-vhdx-nbd-stale-connection, block: [vhdx], 1 vhdx nbd-stale-connection
>     Failed test qemu.block-vmdk-optional+block-thorough - qemu:io-vmdk-nbd-stale-connection, block: [vmdk], 1 vmdk nbd-stale-connection
>     Failed test qemu.block-luks-optional+block-thorough - qemu:io-luks-nbd-stale-connection, block: [luks], 1 luks nbd-stale-connection
>   failed pipeline 2945631627, total jobs 120, skipped 5, failed 13,  0 tests, 0 skipped tests, 0 failed tests
>     Failed job 17162982778, check-python-minreqs, https://gitlab.com/qemu-project/qemu/-/jobs/17162982778
>     Failed job 17162982652, block: [vpc], https://gitlab.com/qemu-project/qemu/-/jobs/17162982652
>     Failed job 17162982622, block: [vmdk], https://gitlab.com/qemu-project/qemu/-/jobs/17162982622
>     Failed job 17162982605, block: [vhdx], https://gitlab.com/qemu-project/qemu/-/jobs/17162982605
>     Failed job 17162982484, block: [vdi], https://gitlab.com/qemu-project/qemu/-/jobs/17162982484
>     Failed job 17162982417, block: [raw], https://gitlab.com/qemu-project/qemu/-/jobs/17162982417
>     Failed job 17162982413, block: [qed], https://gitlab.com/qemu-project/qemu/-/jobs/17162982413
>     Failed job 17162982411, block: [qcow2], https://gitlab.com/qemu-project/qemu/-/jobs/17162982411
>     Failed job 17162982380, block: [parallels], https://gitlab.com/qemu-project/qemu/-/jobs/17162982380
>     Failed job 17162982361, block: [nbd], https://gitlab.com/qemu-project/qemu/-/jobs/17162982361
>     Failed job 17162982339, block: [luks], https://gitlab.com/qemu-project/qemu/-/jobs/17162982339
>     Failed job 17162261239, check-cfi-x86_64, https://gitlab.com/qemu-project/qemu/-/jobs/17162261239
>     Failed job 17162261192, ubuntu-24.04-s390x-all-system, https://gitlab.com/qemu-project/qemu/-/jobs/17162261192
>   failed pipeline 2929887766, total jobs 120, skipped 7, failed 18,  0 tests, 0 skipped tests, 0 failed tests
>     Failed job 17055360127, check-python-minreqs, https://gitlab.com/qemu-project/qemu/-/jobs/17055360127
>     Failed job 17055360119, functional-system-opensuse, https://gitlab.com/qemu-project/qemu/-/jobs/17055360119
>     Failed job 17055360117, functional-system-centos, https://gitlab.com/qemu-project/qemu/-/jobs/17055360117
>     Failed job 17055360116, check-system-centos, https://gitlab.com/qemu-project/qemu/-/jobs/17055360116
>     Failed job 17055360113, block: [vpc], https://gitlab.com/qemu-project/qemu/-/jobs/17055360113
>     Failed job 17055360112, block: [vmdk], https://gitlab.com/qemu-project/qemu/-/jobs/17055360112
>     Failed job 17055360111, block: [vhdx], https://gitlab.com/qemu-project/qemu/-/jobs/17055360111
>     Failed job 17055360110, block: [vdi], https://gitlab.com/qemu-project/qemu/-/jobs/17055360110
>     Failed job 17055360109, block: [raw], https://gitlab.com/qemu-project/qemu/-/jobs/17055360109
>     Failed job 17055360108, block: [qed], https://gitlab.com/qemu-project/qemu/-/jobs/17055360108
>     Failed job 17055360107, block: [qcow2], https://gitlab.com/qemu-project/qemu/-/jobs/17055360107
>     Failed job 17055360106, block: [parallels], https://gitlab.com/qemu-project/qemu/-/jobs/17055360106
>     Failed job 17055360105, block: [nbd], https://gitlab.com/qemu-project/qemu/-/jobs/17055360105
>     Failed job 17055360104, block: [luks], https://gitlab.com/qemu-project/qemu/-/jobs/17055360104
>     Failed job 17055360078, ubuntu-24.04-s390x-all-system, https://gitlab.com/qemu-project/qemu/-/jobs/17055360078
>     Failed job 17055360066, tsan-build, https://gitlab.com/qemu-project/qemu/-/jobs/17055360066
>     Failed job 17055360065, build-cfi-x86_64, https://gitlab.com/qemu-project/qemu/-/jobs/17055360065
>     Failed job 17055360061, clang-system, https://gitlab.com/qemu-project/qemu/-/jobs/17055360061
>   failed pipeline 2908947622, total jobs 119, skipped 5, failed 5,  0 tests, 0 skipped tests, 0 failed tests
>     Failed job 16911683051, functional-system-debian, https://gitlab.com/qemu-project/qemu/-/jobs/16911683051
>     Failed job 16911681150, functional-cfi-x86_64, https://gitlab.com/qemu-project/qemu/-/jobs/16911681150
>     Failed job 16911679766, functional-system-opensuse, https://gitlab.com/qemu-project/qemu/-/jobs/16911679766
>     Failed job 16911678710, functional-system-centos, https://gitlab.com/qemu-project/qemu/-/jobs/16911678710
>     Failed job 16911433872, ubuntu-24.04-s390x-all-system, https://gitlab.com/qemu-project/qemu/-/jobs/16911433872
>   failed pipeline 2906503036, total jobs 119, skipped 5, failed 4,  0 tests, 0 skipped tests, 0 failed tests
>     Failed job 16896095104, functional-system-centos, https://gitlab.com/qemu-project/qemu/-/jobs/16896095104
>     Failed job 16896090260, functional-system-opensuse, https://gitlab.com/qemu-project/qemu/-/jobs/16896090260
>     Failed job 16896083592, functional-cfi-x86_64, https://gitlab.com/qemu-project/qemu/-/jobs/16896083592
>     Failed job 16895432496, functional-system-debian, https://gitlab.com/qemu-project/qemu/-/jobs/16895432496
>   failed pipeline 2876539219, total jobs 119, skipped 5, failed 6,  0 tests, 0 skipped tests, 0 failed tests
>     Failed job 16692899473, functional-system-fedora, https://gitlab.com/qemu-project/qemu/-/jobs/16692899473
>     Failed job 16692899464, aarch64-macos-26-build, https://gitlab.com/qemu-project/qemu/-/jobs/16692899464
>     Failed job 16692899463, aarch64-macos-15-build, https://gitlab.com/qemu-project/qemu/-/jobs/16692899463
>     Failed job 16692899432, clang-system, https://gitlab.com/qemu-project/qemu/-/jobs/16692899432
>     Failed job 16692899429, build-some-softmmu, https://gitlab.com/qemu-project/qemu/-/jobs/16692899429
>     Failed job 16692899413, cross-win64-system, https://gitlab.com/qemu-project/qemu/-/jobs/16692899413
>   failed pipeline 2840522620, total jobs 119, skipped 5, failed 7,  0 tests, 0 skipped tests, 0 failed tests
>     Failed job 16454091776, functional-system-opensuse, https://gitlab.com/qemu-project/qemu/-/jobs/16454091776
>     Failed job 16454091774, functional-cfi-x86_64, https://gitlab.com/qemu-project/qemu/-/jobs/16454091774
>     Failed job 16454091761, check-cfi-x86_64, https://gitlab.com/qemu-project/qemu/-/jobs/16454091761
>     Failed job 16454091760, check-system-opensuse, https://gitlab.com/qemu-project/qemu/-/jobs/16454091760
>     Failed job 16454091758, functional-system-centos, https://gitlab.com/qemu-project/qemu/-/jobs/16454091758
>     Failed job 16454091740, check-system-centos, https://gitlab.com/qemu-project/qemu/-/jobs/16454091740
>     Failed job 16454091730, ubuntu-24.04-s390x-all-system, https://gitlab.com/qemu-project/qemu/-/jobs/16454091730
>   failed pipeline 2839257817, total jobs 119, skipped 5, failed 2,  0 tests, 0 skipped tests, 0 failed tests
>     Failed job 16436167533, ubuntu-24.04-s390x-all-system, https://gitlab.com/qemu-project/qemu/-/jobs/16436167533
>     Failed job 16436167532, ubuntu-24.04-s390x-all-linux, https://gitlab.com/qemu-project/qemu/-/jobs/16436167532
>   failed pipeline 2830538304, total jobs 119, skipped 5, failed 3,  0 tests, 0 skipped tests, 0 failed tests
>     Failed job 16377263801, check-rust-tools-nightly, https://gitlab.com/qemu-project/qemu/-/jobs/16377263801
>     Failed job 16377263686, ubuntu-24.04-s390x-all-system, https://gitlab.com/qemu-project/qemu/-/jobs/16377263686
>     Failed job 16377263684, ubuntu-24.04-s390x-all-linux, https://gitlab.com/qemu-project/qemu/-/jobs/16377263684
>   failed pipeline 2820341086, total jobs 119, skipped 5, failed 2,  0 tests, 0 skipped tests, 0 failed tests
>     Failed job 16307778927, check-rust-tools-nightly, https://gitlab.com/qemu-project/qemu/-/jobs/16307778927
>     Failed job 16307778897, functional-system-debian, https://gitlab.com/qemu-project/qemu/-/jobs/16307778897
> 
> It has rudimentary access to the tests but I think the deep dive would
> require better retention of the job artefacts. The second pipeline in
> the above list lists the "job artefacts" as removed 3hrs ago which is I
> guess why we don't get the test breakdown for the earlier jobs.
> 
> Anyway perhaps we can expand this to be more useful?
>

I guess take the latest 1000 runs, report failing jobs, see if there is
a pattern. Then for each run of job failing, see if they have a pattern
inside also.

Running CI on GitHub side, I found there are some recurrent flaky (that
I simply deactivated for now) but some real sporadic that are rarely
triggered. Since adding an automatic retry on individual tests, it's
almost green 100% of the time, which convinced me to propose this here.

>>
>> thanks
>> -- PMM
> 


