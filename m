Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97A6CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 15:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPiR5-0000S1-Qd; Wed, 20 May 2026 11:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPiR4-0000RG-12
 for qemu-devel@nongnu.org; Wed, 20 May 2026 11:02:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPiR1-0002XW-Ak
 for qemu-devel@nongnu.org; Wed, 20 May 2026 11:02:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuSHN3680286
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 15:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OBpzLV9dsAKuB4xzwFmRuE5A4+aMfwZoKPDMqVrLaqw=; b=BQig6QlqVHCB7oH6
 juMAUmjxQZNkGJitFsKlG88GNaZCqXVwF8bsYh8HC9yOLKAl6g85V0UaQmDBU1hx
 x+EDbhFCq7Q0cZlVghFRrd/kQHlAWwf3aX7Trs9DB3RvWYhCoB9u/xgUOWcK9Uv+
 1P2Y9t8YfWxGXZ4pqXjrHP4ASGCGqfBiD3OqoHbGPKdsNHVUY4xVWwmCbLZw4LIB
 NmaT/1kgaiWKhHyyX4F23S1H3sswkWeJ0+HkoPHaV1ckmF1TN7wzNO6sYFx9jezh
 qPxUtsg4xzp8YnyWzPjVH10iEi0NU4zLMO4vE/bMOj7Hc2zQBw/LeFiez9fRjeRz
 0oS4iA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j09db-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 15:02:07 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1329791f18fso8446225c88.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779289327; x=1779894127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OBpzLV9dsAKuB4xzwFmRuE5A4+aMfwZoKPDMqVrLaqw=;
 b=hj18t1RAgpM0hVMJvQfaod83ms2k/po04p/tIVuYLltFOu+WR3pGEVgjzGMmnJWU57
 A2rs4cj1bNJpxmHCrt/uduVWA5YdxCbIySLtzQz2bIwFbKz55f7RI3wvYpx4jSgeJH0Q
 L411nbTAGDvj3bk4fwzoAooTu/Iu4UNgKvLlX0+xvjEz7yVj+aYiTLcwvGU589+D9xbV
 upeUYScp8FOzmFZCefcAM7gIOiNkWelUH0SNiSXhq+88x8gbjRS10blrAyigjhG2gNNa
 TfGfAbfMpRjCaGI5L/LYqDJuRN/ax4CnfCUaa1RldJ3BBVQhLzZ3pCqaNfODuYkGq/b2
 051g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779289327; x=1779894127;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OBpzLV9dsAKuB4xzwFmRuE5A4+aMfwZoKPDMqVrLaqw=;
 b=WvvkdIsR4yP5k4OxTN8Hsr1kA9covsBjKkXdgTsQvEnx+1RihQ5Mb0fbDZFb1X0FAh
 wTZObBNqStoqhSaN/UuJXwwAcWqLHCf49L0Tw0mrTnzEbVAtXVwMVJEMaWo6gq20IRlW
 QC12uQ3rCqz9sJlv9kAUrSiTfPctho4HsQQlC3MUMXXC4APEO4P+41X0/oQ1JSGp+6Vb
 aWwJmD+qPS82FKIcF5DwbR+KRFQ5XBUwl0W9qpjDxixnJuguplumUttiMs0avTXPDmVY
 cguK0cFIjsciRVgPeN+p0f2lTNkKucBaoMX2KKo6uXFhybgnvSUbI8SnoO9+BNRp4GJ9
 sgbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MU2vVaoKwMkTpDVUnpuL4p63MAcA0CechyzQBzRNwGkbTITzg/a7kh/tJVfUEsm5g/mwtWVQ+xIgM@nongnu.org
X-Gm-Message-State: AOJu0YwZbb8ObZ/rAkgG5UKrg2pQ9JdEnX7ovxEdMsRWMY8586Fo1ljY
 16Ka6zeFnufeBroYgdVCEMtvRgLsY2s+wRykUPzibX5JzecQNEvQAXV+G9X/eFtVyjoIyUItgEt
 yjtyA/eoIs3kQ8xNxY8i37qvEXko3Z1POdro5jP1addMiw9cx3/K2FXZ7mg==
X-Gm-Gg: Acq92OHB+y1RBQbMKklp0D6GSuNRpKr7gLM6iU2S7RXaF8CfM39JUkKk95wN9sWOSfU
 Q4pmIm9zrFd3b1VX7KNDY7+wO2rPyn48vPzuhtohQBt9SB2XeAX/PXdFblJMb8Y7Z66cuPc4tBJ
 EdPgt00aHmUrf9PAKMeMNbV/iPGbOFrrA2mLyeRB8q1urwV3jqVZWEaID94lxoJ0crefKUWkpVU
 /mlteD/9TtIsssR+DiQF/s4I0krVMXb3Pkp1XBOJuilv7cV38C5tq9ia6XcOJ/Jl2HRKk6SrI0r
 y0njnN2XugCw1C8TQIn/85eVegjNXtKEQ1tEEXj5G9i4ZkxkE/ke7GrdUy2+0ivBUlZOm1t/Zjy
 1BwPk81Bz6QNHkRpLh944VCzFDYk+bcTTXT/P5X+sSOztxyfHQiyATa+KzfBinPKwWw==
X-Received: by 2002:a05:7022:1e12:b0:12d:de3f:f3e7 with SMTP id
 a92af1059eb24-13504a4a0b8mr9696058c88.39.1779289291116; 
 Wed, 20 May 2026 08:01:31 -0700 (PDT)
X-Received: by 2002:a05:7022:1e12:b0:12d:de3f:f3e7 with SMTP id
 a92af1059eb24-13504a4a0b8mr9694308c88.39.1779289277308; 
 Wed, 20 May 2026 08:01:17 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-135e5c0a918sm4345662c88.14.2026.05.20.08.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 08:01:16 -0700 (PDT)
Message-ID: <c9cd8228-0a18-49f7-b403-445affeaf972@oss.qualcomm.com>
Date: Wed, 20 May 2026 10:01:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: GitLab issues for security disclosures
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <agxzKzzDOJm1EU_v@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agxzKzzDOJm1EU_v@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dccef cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=D19gQVrFAAAA:8 a=NEAV23lmAAAA:8 a=1zXRcMG9_WFFh9bre0AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-GUID: dm7b0U5nPu2_vwXz6nHgbTIoNMzd5gSj
X-Proofpoint-ORIG-GUID: dm7b0U5nPu2_vwXz6nHgbTIoNMzd5gSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NiBTYWx0ZWRfX3U0MP7t8BJmL
 r1/i+JYcjZDSK7unhssuHzfzIvnaefYvEBR4jsBLa+pINP0uHPiiK2ecZVOZBAZmg/09cXMR9xu
 GCwbOBiY2WV9Wrdbk2vOifKrge43hm3r1KCPcOA3AYEI589Zl4mq99u1VcWltkzmxvvLzKLsL2P
 6H6k890JuL0/q8QwuNNQxK3T2vyFG+kuQuwRlmGsHx6rNU2TuUnLoeTK6Lmh8zWThUq0ph7f6c+
 0Gt5+tQG+NOkok3Z6784xGBtnTkDEwUQcYBgtmgXJsGqNLi1xRz4Bwte5AIa7jqVENnUbICFPoc
 y9AHD8S0zWkY6uR4krj2gkcKoTSv/cO4WKEMIZkskYJbkpYGwOrW74ZO80b/eQrkB8EqAvK5MA0
 TD1UBhPF0BwD9eIavTyR38iM3m0m7B+eoH/z9o2MZNIiIxLZPLmKz/lcx7A0CmRu6svZGdoMXCM
 HuMM4QU1YWbZ0Bwwjag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200146
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

Hi Daniel,

On 5/19/2026 9:26 AM, Daniel P. Berrangé wrote:
> The qemu-security mailing list was created several years back now and
> traditionally saw 1-2 disclosures a month at worst. This was manageable.
> 
> Since approx March 1st, the new normal is to see as many as 20 disclosures
> in one single day, more than 200 in total now. This is unsustainable.
> I was thinking we needed more people on qemu-security to triage, but IMHO
> this won't really fix the problem.
>

Considering the increase in number of issues, would that be possible to
make stricter rules about what is expected?

For instance, asking for a working exploit and optionally a VM image +
instructions to reproduce it. I am not expert on the topic, but what I
see is that if we have this, all duplicates would be eliminated at once.

This would force security researchers to spend time (and tokens) on
providing a concrete test and environment to reproduce, which really
helps with fixing and testing. Else, simply ignore and close those issues.

> This needs an issue tracker to cope with & email is not an issue tracker.
> We faked an issue tracker with a shared spreadsheet to prevent us drowning
> these past few months, but this is still not sustainable & probably won't
> ever be.
>

Overall, you're right.
However, changing the tool won't solve the number of issues sent, and
for that, something additional is needed.

I wonder also what is the percentage of duplicates there is from what
you observed in the last 2 months. Any rough idea of the number?

> The traditional POV was that security disclosures must be dealt with on
> a strict "need to know" basis until there was a concious decision to make
> them public. Typically that happened when a patch was published by the
> maintainer on qemu-devel. Rarely have we applied an embargo period after
> a maintainer had a patch ready to post, as most bugs were not severe
> enough. Also in typical usage Libvirt has SELinux/AppArmour to mitigate
> impact of a guest ecsape into QEMU.
> 
> QEMU is not alone in this chaos, to quote Linus
> 
>    https://lkml.org/lkml/2026/5/17/896
> 
> [quote]
>   the continued flood of AI reports has basically made the security list
>   almost entirely unmanageable, with enormous duplication due to
>   different people finding the same things with the same tools. People
>   spend all their time just forwarding things to the right people or
>   saying "that was already fixed a week/month ago" and pointing to the
>   public discussion.
> [/quote]
> 
> They have explicitly changed their policy for disclosure now:
> 
>   https://github.com/torvalds/linux/commit/a03ef333fbd6cd861c8457c3d055ee3643a9baad
> 
> [quote]
>   If you resorted to AI assistance to identify a bug, you must treat
>   it as public. While you may have valid reasons to believe it is not,
>   the security team's experience shows that bugs discovered this way
>   systematically surface simultaneously across multiple researchers,
>   often on the same day
> [/quote]
> 
> IME for qemu-security we've definitely seen the same bugs reported by
> different people, within days of each other, a couple of times even
> the same day. Dupes are not the majority  - QEMU has so much low
> hanging fruit - but they're a sizeable chunk.
> 
> 
> Because we don't have a good automated way to publish disclosures
> from qemu-security, we don't provide contributors any way to check
> for duplicates before submission. The burden of checking for dupes
> thus falls on the qemu-security triage people, or the maintainers
> we forward issues to.
> 
> For disclosures in the non-virtualization use case, we ask the
> reporter to file a gitlab issue or send a patch. They almost never
> do this. We're lucky to have any reply to emails at all.
> 
> 
> IMHO we need to move to an issue tracker. GitLab was originally
> discounted in favour of qemu-security list since "Confidential"
> issues cannot have visibility managed in a fine grained way.
> They are visible to everyone with "Reporter" role or higher,
> which is 70+ people for QEMU.
> 
> If we accept the kernel's view that AI discovered issues should be
> considered public immediately because of the high chance of parallel
> "discovery", then GitLab's limitations don't seem to bad.
> 
> It is also of note that we've had some people ignoring qemu-security
> policy and directly filing public gitlab issues for stuff discovered
> via AI/LLM agents already. Those are not getting attention for CVE
> assignment, should it be needed which and can't be cross-referenced
> by general maintaniers to stuff we have received via qemu-security.
> 
> We have some options IMHO
> 
>  1. Move all security disclosure to GitLab confidential issues
>     no disclosures via email
> 
>  2. Move AI/fuzzer assisted disclosures to GitLab confidential
>     issues, keep human discovered issues on qemu-security list
> 
>  3. Move AI/fuzzer assisted disclosures to GitLab public
>     issues, keep human discovered issues on qemu-security list
> 
> In all three cases, if a GitLab issue is determined to be security
> relevant, any maintainer could send a request to qemu-security list
> to get Red Hat product security to allocate a CVE.
> 
> Out of those I'd probably lean towards (2) which is slightly
> more restrictive than the kernel new policy but not by much.
> 
> Some key benefits of using GitLab for security disclosures
> 
>  * We can trivially make disclosures public if we classify them
>    as a non-virtualization use case, or when the fix is ready.
> 
>  * We can formally track the lifecycle of disclosures through to
>    the final fix, for both virtualization & non-virtualization
>    use cases. The only difference will be that the former can
>    request a CVE assignment
> 
>  * We can do reports/queries of outstanding issues
>  
>  * We can more easily use automation to process issues
> 
>  * Maintainers can see bugs without waiting for someone to triage
>    and forward it on their way.
> 
>  * The small number of security bug triage people are no a bottle
>    neck anymore
> 
> Some downsides/implications
> 
>  * Every disclosure in a confidential issue will be visible to every
>    maintainer who has joined the qemu-project repo on GitLab. IOW
>    that is treating every maintainer as equally trusted.
> 
>    We do have qemu-security though we could be mailed if someone
>    considered their disclosure to be severely impactful but the triage
>    team can't make that decision.
> 
>  * We must NOT grant membership to qemu-project at a Reporter level
>    for anyone whom is not an active maintainer. They must be limited
>    to the "Guest" role at most.
> 
>  * No one is formally responsible for GitLab issue triage. We have
>    had Thomas do it in the past periodically with script assistance.
>    We have Alex doing some of it now with bot assistance. The danger
>    is security disclosures get ignored as "somebody else's problem"
>    no one has accountability.
> 
> With regards,
> Daniel

Regards,
Pierrick

