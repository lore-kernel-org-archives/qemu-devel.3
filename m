Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eSpPdQGw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hdYLdDCJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLy9A-0006ph-SK; Wed, 28 Oct 2026 03:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLy99-0006pG-3V
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:32:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLy96-0002qZ-KC
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:32:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S6A2dj325654
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D169SGkr4EUaLmZTcQaPJKdTsXaSiwbI1jDoJgRtcxI=; b=eSpPdQGwEcVgp+lS
 yhsjOg4J3nJuDlbJXG+V6N6kupXWZ2ssZcVvovo9iYuZL0MJGjynPT51ZQj6vc2a
 sf3MuettJ89WK4r+yFOHMCu2eQEp6kHMJAIittiL8fL8nAl5Y2auP4AkhdYdxv/m
 Ip9eDqAKPM+wr0ZKFB62Yki/BHZgPf3TxiPXCfhARMiquGiXvyGmILIzQjm4DhvG
 vSgJhreJ3Vp2EjV2zK7kg3R99GlriN0xx1c2rwcCxrF+EgdpnkWUXACmJv7k/yGU
 ta8vWfaK+YcojmufhI6zjHOG5dadPyRttoE9taRBAo3ut2qOpjPpJJejgb47QNZj
 K5URpg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhw88xn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:32:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c70349f65so16336596d6.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793172743; x=1793777543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D169SGkr4EUaLmZTcQaPJKdTsXaSiwbI1jDoJgRtcxI=;
 b=hdYLdDCJY+N0VJgb0ZZ5chlhJ7kiV2P0RPPDdim+OXjhFoydjEOp1gO6PvdIKsqoFG
 YKHm8pr+Qgx4hY9vlnXN0Ucz1nLx3aQnjOizJsELpAgqa4YyCsaKO+fTGi30yzWrVObr
 XWvtDu4xgynVGe3IxY5rwhf83exi8UO4DOVa8nQuKMUgGk4AMOJh8qknXiNeIv3ygIVQ
 6d2eacnBGY6+FnCV8QgREPxq9MQv6K0oA2blS7tfO4tcTemwVnO2gbQHWLsEhviAH5gS
 S96q6o8OleXxh5524dhhmpg/bFSBOcpN/EfwzNj89n9C7kT4fiQYwvlAlqd+3L6nPsVh
 oyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793172743; x=1793777543;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D169SGkr4EUaLmZTcQaPJKdTsXaSiwbI1jDoJgRtcxI=;
 b=1EOTYj/37tI+jLoaKW7JryCUuEap6l9zL6rOR2oSJm2w1ljW2/lYRU50/e0+FtLROg
 DEVbelnXrIe45jRWh4QtCwfaCZ1jasq9BCoUaP3QXWUEN5usHiZ80csPqUxc2n8XA/al
 pfxPEFTVThjxUalDDbOxvq5N5NZM96ZeEx5DhHQH5bcpA7AFlLAoGCzFKrmOzTrc02S1
 XFDR67xA4oddPqt1kpVWQ5c9bl091rNQbh6ZTiGfkZtp1+OvV6eB2BKCbNiV4d6l6syc
 AkplfLVcS6p6jqagiiBOQeHxk87c/JH4Y+cx3tzAOg1gxhG1GqkP8fM/TyYXCB5J10ZL
 6Mww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaBIFV293o32DCaKO8nQHz2hMGWdDV8ya6jspa2SgboX4OrYsMCoK4yfR8ITXQZ9iuemVT4n2KU1fd@nongnu.org
X-Gm-Message-State: AFq9FYIEpSLWiEDooXo9lYe+YIAgN1Gtc+LaFK6csj85UP/QNNFAUs6Z
 wPlHT1NYa895op1qlGmLXTqWUIqNklvAFhWIRY8zHSoyA+Fj2gxJmpIt3UY6goG0Gwecuo+zz2k
 83HMSlWY5OJLqOFMajC2dfYPg/Z+9W1fsF+L4y5W3LqFOh/GYkf1KjlNoeg==
X-Gm-Gg: AYBFou3Gf/LZNgByAYbKGC6TF8pYgLA6DyPqnDaXf6/JXw7bCG8138gdPO4O5tnH7YP
 8FZvbXfCIQ5Wv4nklp/mHDUAr48OpdPhkkFX+3kbpX5uJX/ClQYcn8ae5p2Aeh+Vo99Evldkx4H
 118ujnUNW1nY0ypLs3OFk8EIdrq2baxSfTfZE52xpOHkc/ll+Wu8vUZJOrkF37Rbq2fv8bHsdKu
 +jcW8ckIEtrFC463K4yAyyCtHUH1noIyZFg7vcdYVUu2kmxsTZF+wsbUN+XxlqiWmb/mgIIgH6F
 rbj1pmUPAoWS42GF9iDEDspsCy9fm1i6z/LUd5cpRgsQvaVhFB2wJZaiDM9aDxULSBccf4z5VtS
 8R4/pg4RXEMCMXaK7Yt9tepxEp0/AYcaGG9nAyYs09Rn9/gLm3OQmBezxMdnM3fHLqmB8s8/fFd
 nowIco8Aq8i1E4efUkTMPfDnE=
X-Received: by 2002:a05:620a:444a:b0:93f:2bc8:283d with SMTP id
 af79cd13be357-94408cc0fdfmr191809785a.47.1793172743083; 
 Wed, 28 Oct 2026 00:32:23 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:93f:2bc8:283d with SMTP id
 af79cd13be357-94408cc0fdfmr191807385a.47.1793172742552; 
 Wed, 28 Oct 2026 00:32:22 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a9792269b2sm27150675e9.13.2026.10.28.00.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 00:32:21 -0700 (PDT)
Message-ID: <e84af371-8fce-466c-9df6-c74863c127a4@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 08:32:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 51/59] system: Remove deprecated 'debug-threads' option for
 -name
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
 <20261027192341.9197-52-philmd@oss.qualcomm.com>
 <0dab848f-426e-49af-a28e-8165591b9d03@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
In-Reply-To: <0dab848f-426e-49af-a28e-8165591b9d03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GedYwl-7_f3CbmcyBWf6156w38rwX4xy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyOSBTYWx0ZWRfX+w3Wg4hPBR//
 7KhV3ecqLYggXaiR8NTKbLb4PE27vBjNzLc6zj0GvbEyZ4s4Jue3JgAgmPAZBPe/coW2pFW2qEQ
 rfupFY5iZ8rJBzMYxTMM632YK123Wek=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae1a508 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=3WJfbomfAAAA:8
 a=NmSMnd42iJdNESe6x_QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-ORIG-GUID: GedYwl-7_f3CbmcyBWf6156w38rwX4xy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyOSBTYWx0ZWRfXynpuOq1ghCUq
 78TNd5gXz79zWlAsrs1zCqHEvuz5YNq5yXxgkOxUVTp3+uJJ79taGk85KtTKN2PKA7qMZxwWKQC
 fPhkddNeCXIQmkg6K5/+lBgwRFSZWf4kT4nkGew7k6EhQDjCHuAdKpcQVYuwKEBrL5Ehhm9yHca
 ubhZuGpcCor0mR/QB2JorIqUVQHMHRNnhF1bTVjWEfLnln9F2eOuHdwR45Xpj07pofaZ2J+3VxZ
 mmbggMITJKvtbaSVL29P+bmbeltWul9WGOZj7oGWMGpynmGDoRAbTDY1ol18rpKPyN8/XsuLk4i
 h8bM0I3jTP3T67Ml5pfZS7rEb9PjWvG89qLO8NjBsv0kUR0c1cknNojgpewmqemsLRoCKQpaLM1
 epMfuFAm0A7vEmtw2Qr7LVf86/VH40df6Nt9jGZUH6YdBBKZIHOzrqX8qCxZ/jS3BFOOFNE+J2w
 S1P6K3aTostelHfrhcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(Cc'ing migration compat and libvirt teams)

On 28/10/26 02:01, Richard Henderson wrote:
> On 10/27/26 14:23, Philippe Mathieu-Daudé wrote:
>> 'debug-threads' option for -name was deprecated in v11.0
>> (commit 1b65aeed2a0 "system: unconditionally enable thread
>> naming") thus can now be removed.
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
>> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
>> Reviewed-by: Ján Tomko<jtomko@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert<dave@treblig.org>
>> Message-Id:<20261018232917.7716-1-philmd@oss.qualcomm.com>
>> ---
>>   docs/about/deprecated.rst             |  7 -------
>>   docs/about/removed-features.rst       |  9 +++++++--
>>   system/vl.c                           | 11 -----------
>>   tests/qtest/migration/framework.c     |  4 ++--
>>   tests/qtest/migration/precopy-tests.c |  2 +-
>>   qemu-options.hx                       |  7 +++----
>>   6 files changed, 13 insertions(+), 27 deletions(-)
> 
> You need to remove this from the testsuite as well:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/17523155796#L58

Hmm I was surprised because the pipeline in my fork passed, but then
looking clearer this job is marked as "allow_failure: true" for me,
why is it blocking on the mainstream repo?

Back to the test, this is the migration-compat-x86_64 job running
previous release binary vs latest one, so I'd think this is the
expected behavior, v11.0 and v11.1 have that deprecated option, and
we can not test vs v11.2 which removed it.

If we want to change that workflow, then when deprecating on v11.0
we also need to remove the tests coverage, so when we remove the
feature at $deprecation_release+2 the migration-compat test does not
break. Here the question is, do we want to keep testing deprecated
features? Maybe yes in the case of unmaintained area when the
deprecation process triggers new maintainers stepping in and the
deprecation to be cancelled.

We could also mark the feature removed but keep it ignored and
undocumented until the next release but we'll likely forget and
miss that in workflow so I don't recommend that way.

Maybe there are another ways to resolve that but I'm not seeing
them. Ideas?

