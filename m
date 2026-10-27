Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF3606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jd8kw3LM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=grDj7HMe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLqaO-00041o-9t; Tue, 27 Oct 2026 19:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLqaM-00041f-QD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 19:28:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLqaH-0008L1-82
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 19:28:06 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RKtr3w2792850
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KxxE0zm06CnDhvgjOHLdESYoNK38/E7AKQ/KATMyO6k=; b=Jd8kw3LM73rZYBBp
 EosZ/kNQE5oBUoCFFtnzut8lbFegm3dOqCKiUfp1GsnSHOBI8Q/pIeO+9S1gSmr4
 K12BgblKpDLa0GaSQlxV5+joICxgc4DQZA6161CyooWpF3Rzh3euDVsW0ppiSf6G
 OVRVNp2e+/R06+NeR4kVYNN6R4spvOwZmFcyiEtMAaCKwTemN04gv70ZCEeA9kw0
 4s6y4TehP0Ofgyzf+JhUM49sA3cIqHJ9swcVmoVli8D+F32rra3Y73gKtSvJw2aa
 JGv/BHz3dDOCsv5Dn6pCRihyQ/yH+XX0ZLvgNSRVUHkG/tfUe4dHMORbfa6pn7Iu
 i1zzaQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g1jur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:27:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso633856eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 16:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793143677; x=1793748477; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KxxE0zm06CnDhvgjOHLdESYoNK38/E7AKQ/KATMyO6k=;
 b=grDj7HMeRVDRqulIugGMVMmNxMj9dhI0WccpPOltZDPavBlt9t3JAqcXcVFlTQxeSr
 DfOOyWqU0PU2yFfXUIgWU7GsHikNAuQMeHJN/3SRgbNDPKj5hgyxSvNzgeUQTtUJaehF
 GkSNlkKU3LHG431Nk5+EQTRHjbd6PzaQnVccul4Tlli+jALPIHL8qUOsc5YzeW0CGnE5
 oB9/SfnOYpmdh3eMcg2T29EQ9az/jBEpq2TbUjyVVjDthDXa0QYJlwhsady3HGB+SaO8
 2HXWFS2KJcqblhxcNgYiaAJHRomBT6AvPEdIEPZ6CrsXJ6SY+0QwQht1Yg3M1gH3HO+r
 T88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793143677; x=1793748477;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KxxE0zm06CnDhvgjOHLdESYoNK38/E7AKQ/KATMyO6k=;
 b=zD5Squ9gEWc6rEGddJoJd71T2EBOdyq50qzgdxJMuJEKy7hqGuWfPIXYp9M3At7Y7r
 EEuFyejItRCwbDcMbubyNZyQFyfZ89S/kVKpodDyYXgVUd8v1Yf7hr5FHpV9iiDnLRAZ
 axUp4pYgO4BcYYrk6FfUSl/2nSDiS15p6TbAst9sRwdke2zC+0ey4VHMwG5tzczl/2Fx
 N2dK6U64eJ5iYWW7x95Och5kfslqJYrvn7Ee2x1u0wW8Lp7v7XtpXbPPav1+DkNWdKzy
 3vsl72bZ3kavpCR1ffGD0fkTFw+MtLTI1LyNB4+U2GzKjnDnoxdpDr4V5n5Orhvp1ZIo
 io7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRfrNU36uPT7NgNzg6JWWIwQmt2CxhVcyIRoCb6qcEsYwN7l/y+en4Jz1OdYfeYnVf2VYZdKrUEzoq@nongnu.org
X-Gm-Message-State: AFq9FYJ1MOh/Nu6bFe1B415I/TwUVvD0Bhvv3ZBfwJlIbntfXtLTf/qb
 YpAr5+U+vQGI9QO3+1wOCSdOykxWkQZGye0Z6+fDia7lYD8rSxABhfCMKI2XeKQb/GX78hctRJ/
 fxqsq8bymUqTYZu+62mmoCZ9+emitWc9hyAaFMRGdo5P7nr4JGoinIYCL2Q==
X-Gm-Gg: AYBFou1LS1EngNxdWXJ+h+SrSV5GZrG1Te0LlOumUxjPKj7UXPmyjlHWfIbgCokfKxS
 hVbHzzko5gBKTTNO8x6diivl6VWUiF45YRdbVIFZN3eGko2zh7smgDhvBoBNANSqYklJAOnEB1O
 /i33ogkAXky/AgQs953s68icQ/Mk1Rk007F9uXaKx71hQP7OhdctKEcogMHnBEYWCihBxWM210n
 E5zMqkCvm1I8WUwbfk/w38Vts9rgnybwVt4whCKV4i5U5FozxGdFwXe6nPLSWbYIi29fRxZGwMT
 pnqqpAJZfC3JhN0joCENX5fLnO0wo/48FamuLN58n997RbWZ5U0Z0ZN6xu5uHAPB7FJx5HHv07Z
 pPLQR8h/JQEN5q+OmFkW/K7eowvQojUyRSTGUkZDThSjQTUMOpX50dejviBcj15g/ojhT9w==
X-Received: by 2002:a05:693c:8951:20b0:35f:5591:e40c with SMTP id
 5a478bee46e88-36a201770eemr1202650eec.22.1793143677112; 
 Tue, 27 Oct 2026 16:27:57 -0700 (PDT)
X-Received: by 2002:a05:693c:8951:20b0:35f:5591:e40c with SMTP id
 5a478bee46e88-36a201770eemr1202625eec.22.1793143676505; 
 Tue, 27 Oct 2026 16:27:56 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23908449sm86490eec.11.2026.10.27.16.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 16:27:55 -0700 (PDT)
Message-ID: <62cf8efc-da0c-4118-96b0-c3eb772e32ac@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 15:27:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] releases: build and run any QEMU release easily!
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 mjt@tls.msk.ru, peterx@redhat.com
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
 <87h5icl9dw.fsf@suse.de>
 <c4b4213c-6013-4a96-aa13-509778bbb6eb@oss.qualcomm.com>
 <87zew0jud9.fsf@suse.de>
 <786c36d6-d321-46f0-9e66-eb5847baabe9@oss.qualcomm.com>
 <87fqxrjgul.fsf@suse.de>
 <2b635b7d-05b8-4ac2-a275-ef132a2bef27@oss.qualcomm.com>
 <87cxsukb3w.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87cxsukb3w.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5NCBTYWx0ZWRfX0ZAkc3o+CpH+
 0ICawrgygad/GJOz6itmKyckxcJduR6vl3YQOCRZpldmcAImot0sboFmQmbUbI25d+sUDfMhSrp
 zgnJ2EsHp1N9XEEsGbhiW8qWuwplvyA8on/KCJTZkVFV199uCELMNmOibyzWKCHum4E/czU4GHz
 SF4lU0wkrPaVwvm+D8MxnMQxwCfcyn7G5CFRD8+i1Uy9E2EwZSgf3/eKX4c+Tn1KLc5UjdUnOnj
 m1EZ/GbbyBXBF4Tnnj6TEeaoxZ1UndzQW7UcwYFLGdypQ3OGtDSgYgwdLazaABccXFxJ3N9cz5b
 A5QiUhmfIeyOpxj/Zx2YG/LoUHjhHVLI6TQAXxAUVOcfHZeWQtUgBhBkmEuaixPZHRzRwAfrbjZ
 MYUdGcN0T2UiISP4OMC8Er/AnujXeKVrehDPD1p+bmaIIZtQxgUO7esiSq1+oZzQ1xGqYUT9bdd
 YL862of+/yJGCtP6uWw==
X-Proofpoint-GUID: dvfgzQzwwpbASLKEXm8sML2bPNQ-MIZ4
X-Proofpoint-ORIG-GUID: dvfgzQzwwpbASLKEXm8sML2bPNQ-MIZ4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA5NCBTYWx0ZWRfX+CvuNfJZIXF4
 N8VgdpId367o/TaO7xrkll2l8nLfBuR5gljfNJXgmyulkMsA/SpRb5LQjp8lv6+MvLzmSoe7dF/
 HnpeyjPovf7qC9Wfj6yTDkYedpGEJQs=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae1337d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Uo0tMxZHxKPaqfDo40sA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/2026 2:54 PM, Fabiano Rosas wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 10/27/2026 7:36 AM, Fabiano Rosas wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 10/26/2026 8:32 AM, Fabiano Rosas wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>>>>> On 10/23/2026 8:33 AM, Fabiano Rosas wrote:
>>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>>
>>>>>>>> This series was inspired by a recent post from Fabiano to provide container
>>>>>>>> images for migration tests:
>>>>>>>> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
>>>>>>>>
>>>>>>>> The idea to be able to build and run any QEMU (past) release with containers was
>>>>>>>> in my mind for some time, so I gave it a shot. Finally, it was easier than
>>>>>>>> expected to obtain a single dockerfile (with a few hacks) that works over all
>>>>>>>> our releases.
>>>>>>>>
>>>>>>>
>>>>>>> Good stuff, thanks for this work. I'm just not sure how much of it fits
>>>>>>> upstream in the current shape, let's discuss...
>>>>>>>
>>>>>>> You say this was in your mind for a while, could you elaborate a bit on
>>>>>>> how you think this could benefit the project?
>>>>>>>
>>>>>>
>>>>>> First usage that comes to my mind is that it would greatly help for
>>>>>> migration, allowing automatic testing in CI, by just downloading any
>>>>>> previous QEMU, dump a machine, and restore it on current version.
>>>>>
>>>>> Don't we also build QEMU several times over in CI? Maybe I'm wrong, but
>>>>> it might allow us to decouple a few tests from the build steps.
>>>>>
>>>>
>>>> This is for current version, not past ones. I'm not sure it's worth
>>>> adding an identical build for past versions on every pipeline.
>>>>
>>>
>>> I thought we re-built current qemu a few times, no? We have containers
>>> for various distros and then make; make check inside of them. The
>>> question was whether a step 0 to build the binary container for this
>>> release would allow some builds to be skipped.
>>>
>>
>> I see. To some extent, yes. However, if you take a look more closely,
>> you'll notice most of the builds differ by:
>> - set of targets built
>> - configure options
>> - distro target
>>
>> While we could maybe optimize some parts, that still requires duplication.
>>
>>>>>> We could do it for last 10 releases to ensure migration from packaged
>>>>>> versions in all supported distros (red hat, alpine, ubuntu, ...) work
>>>>>> as expected.
>>>>>>
>>>>>
>>>>> It's a nice idea but potentially a costly one. I don't think there is a
>>>>> guarantee that the downstream package is migration-compatible with the
>>>>> upstream package.
>>>>>
>>>>
>>>> What would be costly? It seems it would just be a download + savevm
>>>> through monitor, and a loadvm from current version tested.
>>>>
>>>
>>> Setting it up would be simple. Working with it, not so much. It's a test
>>> that once it fails, then it becomes a tedious job of figuring out
>>> whether the issue is a failure on our side or if it's merely an
>>> incompatibility between upstream vs. downstream. The packaged QEMU can
>>> have all sorts of tweaks, extra patches, fewer patches, different code
>>> entirely, different machine type ABI, etc (their own QMP commands
>>> even). The distro can guarantee it all works inside their environment.
>>>
>>> When a problem happens on the intersection between the two binaries, if
>>> it's on our side, we'd need to determine whether to fix it or tell the
>>> distro "don't do that". If it's on their side then we open a bug report
>>> and hope that this is even a priority for them.
>>>
>>> So overall I'm in favor, but I don't expect it to be game changing.
>>>
>>
>> Do we have a concrete example in recent migration history of distro
>> doing a custom downstream patch that broke migration?
>>
> 
> No because no one tries to migrate from the distro packaged QEMU to the
> upstream QEMU (i.e. apt install qemu vs. git clone qemu).
> 
> The downstream package contains whatever upstream version the downstream
> maintainer wanted to include (e.g. a stable branch) with their own
> customizations added on top. These are experienced people that make
> sensible choices, so things are not wild, but there's still a solid
> layer of separation.
> 
> The (mostly enterprise) distros will also potentially have more than one
> stream, e.g. qemu-11.0.0 and qemu-11.0.0-A, where this "A" is something
> that fits their own policies (e.g. a version that only receives updates
> for CVE fixes; or a version with backports that only ships as part of a
> particular product).
> 
> The downstream companies might also have their own special sauce to deal
> with migration. Red Hat for instance defines machine types that don't
> even exist upstream.
> 
> The general point here is that it's already a lot of work for the
> downstream, it might not be a good use of the community time to have us
> also taking a look at all those details. And of course in some cases
> there's a conflict of interest.
>

Right, I see your point. We indeed can't do this job for the distros.

>> This would be series author's job/time, not maintainer's.
>>
> 
> It should be, yes. More complex problems or ones that for some reason
> weren't detected right away will still take other people's time.
> 
>> Also, I think it's precisely why it's interesting to investigate those.
>> What is the point to maintain any kind of compatibility, if it's not for
>> our main users?
>> Preserving compatibility for versions built manually from source is a
>> niche use case.
>>
> 
> You're thinking in the correct direction, however migration specifically
> is very dependent on hardware, both emulated and real. The right people
> to test compatibility between distro version X vs. distro version X+1 is
> the downstream QA team. Companies have access to hardware that closely
> matches their customers', usually outside of the range of what the
> community can get their hands on.
> 
> We could maybe attempt a joint effort where upstream provides the CI and
> tests while the downstreams add their own hardware and test jobs. Take
> git HEAD, package it into a .rpm/.deb, etc and run tests on it.
> 
> Note that there's:
> 
> A) the migration/ subsystem, which performs the migration and provides
> the APIs and core code.
> 
>   This is where we test features and compatibility mechanisms.
>   I.e. qtest/migration-test, the migration-compat job in CI and what I
>   test in every PR.  This is well covered. We don't add new features or
>   major fixes without tests.
> 
> B) the vmstate code for a device, IOW, the thing being migrated.
> 
>   This is where compatibility issues are more likely to occur (think
>   developer adds new emulation feature and forgets to update vmstate
>   code).
> 
>   There are some tests for this under qemu-iotests, there's static
>   checking using -dump-vmstate, some parts in functional tests, some in
>   qtests/qom-test.
> 
>   This is pooly covered for a bunch of reasons:
> 
>   One needs to think carefully about the device, craft tests that
>   include it, configure it and do something that is prone to be affected
>   by migration. Some bugs will only trigger at the OS layer, so guest
>   kernel and drivers come into play.
> 
>   There's a spec for the hardware, there's no spec for what happens when
>   the device state and OS magically change because it's actually QEMU
>   running v8.2.0 and migration took 1s more to converge than usual. So
>   writing the device and tests for it tends to be quicker than writing a
>   good migration test; most people don't bother.
> 
>   We also like to keep backwards migration compatibility because distros
>   usually provide that. It's a completely different test and sometimes
>   hard to justify when the device writer doesn't particularly care about
>   the cloud computing scenarios where migration is used.
>

Thanks for the insight, I understand better why migration is poorly
covered in our test suite.

Regards,
Pierrick

