Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAD606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b9T/fjcG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GcQa7Atc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4HW-0004Sc-OM; Mon, 16 Nov 2026 16:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4HM-0004S7-TJ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:30:21 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4HG-0002k9-IT
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:30:18 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfmpF4147196
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N1gR2j0CC3hLaLKKgu9MBMaWYnyHtZn45Zgwf195I80=; b=b9T/fjcGA8CVIfbF
 8xOXP0Hhovu8HaqjNQqzYlbK9fQhmccraIdi4+ls6BBwUoAg5w//XdqULU6cBTst
 tWukSFetBRGKbeOcoLHejU3siBOa4LY5NNQP4Fl+8hhyYEWRXW/NAQPfLrXHBVFT
 0BLQhwdQDRCutxoxSPZW/q1RNYBP51REH+h099oOzfD42fOTasyyx6KxTVyMwiCj
 UIs72zT+lyOl5uCXS7eRVmNov7B63qtOAvayY+EbPgcUQUl2Ot2jCgvr4dsmBNhh
 7e7wSeF8rxeCoKSAVZI2wQjF5rtWVUUgQOk5LbJ158EbMbcuhXFwlBynONwE4vm7
 A/y1Cw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f825kd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:30:11 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-37628596fc9so10409321eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864610; x=1795469410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N1gR2j0CC3hLaLKKgu9MBMaWYnyHtZn45Zgwf195I80=;
 b=GcQa7AtclEiORv8RKiYzNlUxhMcFqVzHpENl7Hh4Y7FFWgsFFr2nKB0j52FTJ/k+jr
 BgketJyrhmcwG3THtMuqeoYwXA1PdL9og3tj+hW9owKvoH8Pfe8YiG1boY4jRTcWuIPh
 s6A0oEc6guInQn6uCwRJSjqpkxB9ajkE9tIs00jFrNMm63+FnVFwHhNBSlvfOvIqmtN8
 /uT6LMqWxki/SbL390xGlhkW3aBl3ZB7OJd+Xy5P6I/2110aQxaFwqpkcB8h1t5LhMCy
 KHWvvKwFfHjcPF8kjwxWX9q/8VRK+9f91MxcCtrRvKElPaqnHjx7IVvctuZI7ta9faFs
 pUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864610; x=1795469410;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N1gR2j0CC3hLaLKKgu9MBMaWYnyHtZn45Zgwf195I80=;
 b=vFcg4xNsAvHu6n8h/ZzayYuI7trY1f2WU97DoeHzg0svjlQBfBB8KLvpA3cCcByq/z
 2pBsGZ05syi0JnrWBC7LBC6pGYAQxKlP/FAuU3D12klocKuGBEhKPN6wcn0M9+3umPvl
 EDKLv0zH1FDW2UT9aecn1nm+cKIUcFHzA90qfnxGlcnYbVQQNeOuqu+ulnrd3qOV6++H
 nqxh3sVGtO3K+lbZpwsIag8Vqj2dMC8ZCgqgPYS7f8F0jV0XZ67rzn8CfHJiCRd3jas9
 JqFSptaVFPtRCp9YlWhmWa0AOxmWFumhxbrU8DcY5khwEB2Cj8lkzxY3QcJo3LggxKG8
 GDBQ==
X-Gm-Message-State: APuU4Z8/6C/J8qWy25G1qlTUA6+o5DeeTb11XStGdqtv6AEaZrSXn15h
 nZRNn/LBIfT8iENMvf1zRpcOwkpwHgHPRBcCWKnDzQ+rLFMFFJuRkKGKTdiHG8ASy6WGluvsPFV
 hBqcwLTQK3822/NDtgJKcnMA1pBN7VekbgxFBL/fTOqZmkeKcoAarHVfm5A==
X-Gm-Gg: AZFdTZcJd8+4X9K8AjANmVUXB+EQEA00ipj689okW9aDO2BlTTRUKPy0UkZ0n+mJDEm
 wbjWKOdrKPKtdI+0NHizQ+ElLDWpPsQcxXxlnSNm8ZpHqe8L/JZramUM3vi6rnUmaW45KdkAZ6f
 f44VLBDazttkyhNwDt5R+10bIMtyNwwhstRECClXydpV+PiGt8DiTa6QcHPmt3CXhpDi0Rbegab
 VAlxmSDhMIGDIfgZrGyrUvuJ1YZ/rf5PcC4pDdJeh5FSkIzF2gSz+X+fq3kotoBu4pLRMFA3aBC
 HIQ3zJlK3WGT5Xj4vsCGAqbqV58NKHYsXqgo3u4kKnSdZXa8CNV3Bk2cA6pQlq8jSBCJwFQ6Dyo
 RyAxpYwpdJ7OEJVrK0RXkZ922DvJ9XPIUzyVWrpAsUab1vHh8KOhauChkMtbN4DVQ3D1Ic6UgKl
 6W+EnfEAYg8OF0wNKiDBKMshYJRUUQTYw5gv/Bkfu32g8=
X-Received: by 2002:a05:7300:3b04:b0:369:fb01:2eb7 with SMTP id
 5a478bee46e88-37965daabf3mr17003035eec.13.1794864609983; 
 Mon, 16 Nov 2026 13:30:09 -0800 (PST)
X-Received: by 2002:a05:7300:3b04:b0:369:fb01:2eb7 with SMTP id
 5a478bee46e88-37965daabf3mr17002979eec.13.1794864609264; 
 Mon, 16 Nov 2026 13:30:09 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm36422399eec.16.2026.11.16.13.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:30:08 -0800 (PST)
Message-ID: <a4d1c0e7-3d5e-4a04-8675-a2bfe9371fe7@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:30:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/48] qapi: report target compatibility for machine types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-36-berrange@redhat.com> <87fqx5xj3d.fsf@pond.sub.org>
 <avbaFmxkAKN1tWp4@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <avbaFmxkAKN1tWp4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX37nF2F6jOUjj
 nJ1V2XaAOE3Qmq+d4BOn3Wi+lzxCkpl3agM4nKbd7T4RoSjOkmnWEMQqL2p2IZ8vEIvIOznBQio
 m+Gc4VXHdZnKpvpWrHg+i9iIeZvUZA4ItID1Ixyw5ihyvPiON3QCfnJzuu8/3tmZG53+QhCfeDL
 AlZxpUnADR9nYq5amkbbcHHLRBGYntnhC5Mf3aA9K8hwyAjXOzbsS6Lt9i0Z7EH29qNB3e8xroh
 DfJbupl22JXLoaMNhMS48IR9vxteWmPRdiFM61rX610nsB2J8uvxgm7Xm1McH/RYziXbOmnsC4Y
 SRTSxTLyzjr4BKbitv/jPDHfdYXFSpK07VUrg12KuNc5IlCnzJpymzxNFCqb7hRk+ZRTj/MK67H
 JIkPJm6YvP9pHSPjl2iAm/UPqX0rIMV4ezNicbLpYJ+N4/QXUvC9YE4q7mVQ+df0sMCEVQFuGdF
 B/hx9HUBdZe1itNaikg==
X-Proofpoint-GUID: tPoYKyHR8dr0jenHcZwrY5RYMESf4Zwz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX2eA9aN30pppu
 RUtDs3HNUxiZZQFdmwPL90qFfQXsJ1mGtw2ZoLzE5DKAJ7CcWWnLuokXF3FW8HLreIxKHbrc+Lm
 Cl5DfQxzes9+Yqfcct/3s9Y9KC/4l3g=
X-Proofpoint-ORIG-GUID: tPoYKyHR8dr0jenHcZwrY5RYMESf4Zwz
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb75e3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=-zMwbsk-t2_QhS6-I_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160085
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/2026 1:36 AM, Daniel P. Berrangé wrote:
> On Fri, Nov 13, 2026 at 08:53:58AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> Add a 'targets' field to MachineInfo which is populated with
>>> the list of targets a machine is declard to be compatible
>>> with.
>>>
>>> To avoid reporting redundant information for the traditional
>>> per-target emulator binaries, this new field is only emitted
>>> if no target is currently selected, or the 'all-targets'
>>> flag is explicitly set.
>>
>> How much redundant data does this save in practice?
>>
>> Is saving it worth the additional interface complexity?
> 
> All the arm machine types will report
> 
>   targets: [ "arm", "aarch64"]
> 
> except for a handful which will be
> 
>   targets: [ "aarch64"]
> 
> In a multi-target binary (ie what we intend to ship in
> future, along side current binaries), it makes sense
> that we report this, but in a single target binary
> (ie what we ship today), it feels somewhat odd to me
> to be reporting
> 
>   targets: [ "arm", "aarch64"]
> 
> in the qemu-system-arm binary, given it can't support
> aarch64.
> 
> So I wanted to hide the 'targets' output when a specific
> target is selected.
> 
> Functionally there is no problem with reporting this
> unconditionally in all scenarios. It just felt odd,
> which admittedly is a weak reason for a technical
> choice.
>

I don't feel it's really odd. You could consider it's odd to report
different things when talking about same machine across multiple targets.

It seems most of our effort on QAPI side has been to remove any target
specific and expose all details all the time. If we follow this logic,
it should be perfectly fine to return [ "arm", "aarch64"], even if "arm"
target is not present in binary.

Also, it creates a distinct behaviour between qemu-system-X and
qemu-system, which is not necessarily a desirable thing.

>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>
> 
> With regards,
> Daniel

Regards,
Pierrick

