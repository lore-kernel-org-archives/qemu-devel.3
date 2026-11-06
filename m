Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA1606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Eo3KF+el;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AKfubkHu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNVS-00081Q-KK; Fri, 06 Nov 2026 12:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNVQ-000813-BW
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:13:36 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNVO-0002dc-8I
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:13:36 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6F0Kx53927577
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 17:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o4uCPdTsjfNFr2CgrnePKOX49zplFp40/6+78EdzjZI=; b=Eo3KF+elj/m3viNX
 1KTBd1BBMLND5YKj1STPiFMcxSdflGA9t751edB3RbfqROHqyqiCK2wwYwtNXmn4
 Gd8Dqyu9tGSaK0PKn10VOk2/wEeaGVKxNb1z5yhuYqcQsQ5gkUiwisTyBROvjXeI
 spwha/+N8s6ZX0zIXqr9H/6hM5jpEZYRYeICwQu8phu9CAdajwglt6FjaB3skKok
 1wNf+Ew25LO8dk4jbfNsllTob+Y29Q2Sj7rKLRQeE55rdhn23fN+bvbYDvLwkrRc
 dhyxzP6yxpwi2897KH+DlUhMQmXMGrdx0PPgXwE3LFhRl19C/CT7vyB5mbX8Zdnh
 B5zTgA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa3ty3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:13:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1569751eec.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793985202; x=1794590002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o4uCPdTsjfNFr2CgrnePKOX49zplFp40/6+78EdzjZI=;
 b=AKfubkHu3g4CD6VKCYFX39ed4dWR5Eb+Cfm4sTuWy+xMlOpF8DfsVcGb03g/d1srWN
 ILOiVnGGAh0WlJAwCY/uoXewjtrAQQiJtuhv6jdMofzUxov0/o5H4zSaR8e95C/hJ0At
 y+q+AFYjw+jMkEk4ij3FOB7xUAcZhwI5GOe2dRm/EuZ6TV6c0zYZZCCbLkjRODVVWUNB
 vl7idRgtiZXWhg/0leqKvK/SMJTsG1E+5eFeEBDVyrmI/+weszj0NPtFbpoyqZ3nhxLt
 9cPs9HiX2cBbvF5whDTz3U+JhL2rQZk4OcLvp0f1uF9GV8plbbESD5PLO0vUzAMgyXL9
 e70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793985202; x=1794590002;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o4uCPdTsjfNFr2CgrnePKOX49zplFp40/6+78EdzjZI=;
 b=Or2x5fru9+gfWiq1Rm+cMkfqb+p1VG/8ssFMB5uahC/2Jg2E8pkxPWc1RGZxLV+n1p
 WuP3zfjOu55+jur52jaMjfrxB/niK057vA7DH7jRmkmlB2xOD5fwxhF3IoeNggg4K9tp
 AqsEAMzu8osdp1tpnJBOwcWpOd7ac+jljoAOXB/8H3mrDL09MPR+X9Mdl796owHguSWL
 x2wM2LHDJrNQApEgdHenDvn9c5vn0JE89BpJ1FzDgKyczFz9Jq1JOc+SXS2BNXJJGoer
 rEY2qk59LCJzJveQF1Zm7Qohr95bq4q0cKd1rRdCv29RGsfZOxxWv5B41pA5AOyay+LD
 EPZQ==
X-Gm-Message-State: APuU4Z+M5nGprG1KabMCo6mPodjl9JOywKI0zSCp45SIdpM/6ySPnR3n
 P+h6dPc/a6Ayp7yBUdXWmzPJ7cm7wk2HkETT/AgpvzGAuwmteOymNzMVOhx5kq/fr4JOni2GxVX
 DG2Jgk86ZMx3cT1hgtsSCK/MgVBeSyMKMwCY5g7CWW+OSbrGhxefCKidp9g==
X-Gm-Gg: AYBFou3myz3Td1l73JrEOBGkw3Qg/HH+tuPt8aSm3oPwtZkVXEoCwRf/zg1fBrGa9kx
 xX8OA1YsNlzmORSIPkjKvdqYl1iKwCGtJwc+8tqc9FXBFX7R3zEcA4Z3wDiVQ7b3UilRZLt8oM4
 XIEnY1GFHLCT+kf1jJvZ1dLhifRVckccEm75wtsxigDHOxl1KcHNGbgGEJs8becygA4xwf50wib
 dR9u5oo79R7fQx3surjbU0l6D6M2zlHkBij0mJfYgEDlpULEngR+e4PtwJ70C+3YFiayqwBSNdD
 XvIX+FJg7LfMdVCDXcYuG5tElv3P/b4+PYSWf93Hll9jdDR0ONd0lUlMnKi9ftKeK+ikT2VgR3q
 6oeArTgUBrmiaqa/P6SA5DE7kBB91DK0A7+P/PaBCzuHynHp4Kd2IkS95zPfa6PLDcrVF7D5url
 33rxOl/I2tk0Ctoa6ydQvuAQlZbqlb7qJMko+s4LKaPw==
X-Received: by 2002:a05:7300:6006:b0:36d:f004:ae6e with SMTP id
 5a478bee46e88-36f76b15b33mr4470983eec.34.1793985201984; 
 Fri, 06 Nov 2026 09:13:21 -0800 (PST)
X-Received: by 2002:a05:7300:6006:b0:36d:f004:ae6e with SMTP id
 5a478bee46e88-36f76b15b33mr4470946eec.34.1793985201288; 
 Fri, 06 Nov 2026 09:13:21 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8e3a47esm10321768eec.6.2026.11.06.09.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 09:13:20 -0800 (PST)
Message-ID: <db4879c7-e5ef-48ea-98ae-44f14a5e840e@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:13:18 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw: support machine filtering without is_available
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261105102432.1131493-1-berrange@redhat.com>
 <e0afc971-a070-4853-b690-b6c523c5b65a@oss.qualcomm.com>
 <au3zw-IBajJYhiWN@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <au3zw-IBajJYhiWN@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BKsx5Ve0qPGXnhIeW-VGqBa3ySnggQm6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX9TlZOLn+q8FY
 htFKL43K02/ghmU/SzoUKk8XC/op4fwSyFlf0UEBr4QcvngQhzGSD20xo6FqkGhOkKX0dt4iWVu
 DSKNNl9rKqRvQgrXrBydgh81cW5aQjSSCBXXzqNA8UrKWccQjDLQykmc3k8sSna125KmHk+2yKE
 9Aawk2mErFb37+6LqisYc74TGiDLjg2jP+RXq7qDA6hIS4t4zs0lEebH9+rsuItbvHVmP4MPdfR
 RdYRV+xGlBsav+TYOzbpSaLnB4kC3bgfAP5xd/HZl00aZ+TR6wRttnmbM2Mxlh2UOeAMT3vKviB
 1eBThXzLTQAEYKe8Ewf0w6dWbGfiwCcO3ZKGmlc7fPqqZHz6htA30on5wdvmCzJGaf0FmVj91sD
 jF86vfrH7L02pU+YAV0y1pCJoSdwF+WtL8PfIt+hvo2AdtJO3LrKim4pyYhiy8tea6sc6BoCfg8
 WaXkrwAXxzdOgokAk5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX2I68HLzXPbBC
 8ztPXo/hnrJvXMA6Os6bMd/Nh5seYVDI7bj7/CIqFjFC41rt5vuhsW3Q/wXo1qCaxN11/fTy2re
 RrZxLBeYNJjKUSuLbm1+GYqMm61FRsA=
X-Proofpoint-ORIG-GUID: BKsx5Ve0qPGXnhIeW-VGqBa3ySnggQm6
X-Authority-Analysis: v=2.4 cv=CaKdd7rl c=1 sm=1 tr=0 ts=6aee0ab8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=5ODKxfEBBgD_3g-98KwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 7:35 AM, Daniel P. Berrangé wrote:
>>
>> Thanks for posting the series.
>>
>> Would that be possible to complete it so that beyond compilation, test
>> ./build/tests/unit/test-multi-target passes also? At the moment it fails
>> with duplicated types being registered.
> 
> Oh I see, it didn't failure because I only enabled
> the two arm/aarch64 targets, once i add in more
> targets we get a clash on the virt-machine class.
> 
> FYI, it also fails without my patch series present
> in some scenarios:
> 
> # child process (/multi-targets/qom-types-are-unique/aarch64 [1950288]) stderr: "Registering `vm-launch-update' which already exists\n"
> **
> ERROR:../tests/unit/test-multi-target.c:41:test_qom_types_are_unique: child process (/multi-targets/qom-types-are-unique/aarch64 [1950288]) failed unexpectedly
> not ok /multi-targets/qom-types-are-unique/aarch64 - ERROR:../tests/unit/test-multi-target.c:41:test_qom_types_are_unique: child process (/multi-targets/qom-types-are-unique/aarch64 [1950288]) failed unexpectedly
> Bail out!
> Aborted                    (core dumped) tests/unit/test-multi-target
> 
> This is caused by presence of 'igvm-devel' at build time on
> one of my machines (Fedora), which enables this device type,
> if you have both arm and aarch64 targets enabled.
> 
> We need to add igvm to our Fedora dockerfile to catch this
> in CI.
> 
> Moving it from specific_ss to system_ss make the test pass,
> but I'm unclear if it is sufficient to rely on lack of
> compiler and test complaints ? Or it needs manual code
> inspection to make sure the device is safe in this
> scenario ?
>

We are guaranteed a "common" file works because config poisoning ensures
the whole compilation unit, including headers, does not use any target
specific code (#ifdef).

So if it compiles, it's a safe change.

>> That's why this is_available was introduced in the first place. It was
>> just a way to move forward and provide the multi-target test to prevent
>> regression while work on single-binary is continued by Yonggang.
> 
> Right, so with my series, we would first need the class
> renames to fix the multi-target test.
>

Correct. That's why is_available was used to do selective registration
for virt and max cpu, because I don't see how a rename can work without
breaking existing binaries.

Introducing .targets does not solve the problem by itself, since name
conflict is still there. That's why I suggested to use buckets per
target, which is what Yonggang implemented.

I have no strong attachment to any approach and would be happy to follow
any end-to-end solution you recommend. I'll let you lead on this.

> I should have labelled this posting "POC" as it was not
> tested thoroughly.
>

No worries, it would have been caught in CI anyway, so we are safe here.

> With regards,
> Daniel

Regards,
Pierrick

