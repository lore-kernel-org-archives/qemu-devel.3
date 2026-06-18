Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08198CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waDjH-0003gN-2j; Thu, 18 Jun 2026 10:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waDjF-0003gA-4K
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:28:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waDjD-0001eH-28
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:28:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IDrWeS1453194
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 14:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zQcnlhbDq9tZVQ73cNXxU8SQDl298JmUw05dazHh/R4=; b=EL1YIP7mUGuJCedw
 2XLiREayTiPgHXZcfim8aM5rRQWaGN+XWCEemb1x46esg0ESqZEq6CKp406qC/Kv
 fmwew190b+cbwJykSOdfgmQmLr97lFvwH/12um6D9ltpGvJsOfZyiWYJu7FIohgC
 4JEOlcivdzDkNyTB9IDVtxppVBhp6V/6h79MZzjVgAese3gry5vSf9sr3YDZTmsQ
 f4aKSZNAc+8WYyM+GQ1AuDC7d76UDFybwCiND355gFcQqF3/d24ASBqKvud3DPHD
 bs4bCIQ7vTYff0Xl6inVARuZQQWEBafG1vnZt6oKa72uBcV1MauGnpTfYThlNOaG
 cKZ9HQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2ccw3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 14:28:20 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-72655a207b2so521184137.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781792899; x=1782397699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zQcnlhbDq9tZVQ73cNXxU8SQDl298JmUw05dazHh/R4=;
 b=gxkHURzPcvDHBCftzOL7VPRmhIzgtItp5aPwvpSOU/2is7D4s7m+zBCrXg5+MLilBR
 XgbpMj00Je+yVAnX1DyTnS49lXr5Pik2UpBbo3Z3f+xixbQO9q52eGulDtnaNXPqAlFn
 Hb+cnpLvtVSZJQNq4mM11D9ip7u8gR/C9+GzItGoIA72twY1vQxHoCiSXUcekouMSEKV
 zVpeUXuWHWU1ZcBn44qcT9MURpknXAxuSbJfA/1I32mgPknJDSuuCoGhf5TRKwEj1Elr
 hEvGOyCP3Ah/DoOVmtc0Pw+Qf6jjn6LLXQKuMtf3Xa/wu667LthhAwqsgucW9KWK1ShP
 ORTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781792899; x=1782397699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zQcnlhbDq9tZVQ73cNXxU8SQDl298JmUw05dazHh/R4=;
 b=sLSh53wvkgYcVyiLJCgP9fUkBtHqT3i2qu7uUNuVMs3EKkx0XCpzfbJjGOgzVT9rzV
 nUKeHituJauV34qqmkeqiCji1P42Z1Q3BJ6tonAj5lUFWOqmEQ4hlRn0XKMEF4161e2l
 bP/wpn7D2RI+A3/7LrwI2ak20kRphPoe/Da0mJjQQabHi1kBIIzZVC+jUXCttkbOenf2
 wA5hrd6+Z9elIKvMHpJHY02MaIAli0sCAlT+bVBOOwzsGws6wwkx+K8SJjpqbM4lLYkW
 Z7UYKb1PRbu7txOS9Sob/+fbW9+WqJwYhO0clUzVFPvy6Xoylr0FW9i1ArE+ehf2h9aA
 dyLg==
X-Gm-Message-State: AOJu0YwwhYHvquBQDaylibVX6F+dMokf2K5iNIcWAdFJc0WWNZq8gVSi
 3RMzWkeY4YxSLghooYNuuB3aul+7xUk105qzPQ6mm+u7ZFIHsX0S6H8P3tjR+PjoSxweD37MJbi
 DH4o6Hvvtr4JRSl0DpRdcYDP0WHl7yDPi2cRjDtu9WxPa++YG7uxiz1BUNg==
X-Gm-Gg: AfdE7ckIrGktkwo+2BW2oWGKx4WjQuE0gIpnkBlJweVPj9xc2KEnP7ijrDZ1CPXLFkE
 1aZSAT1spInL0NPGNHWRuP0OgzO+6tK1B2TJmfEZCxnVQkqyM4hvqBUG73SsFzlxgCZt33Ukp5Q
 9xzM3pw6A67Aw5xh4g/dMXbxndjisMBsYlMUe9M137MEaiY+bDWS1hvWPgUnOGjWisG8nYseX7q
 fuqRmVsPOYok6HHQC+mB+HnjMd0+b2wSLt6pdaD9vRag7gEXQQukneWbJ71+sUNp8l14ES0xn5W
 RKrcaKj2rrPc/C8qWoQRKiYUqBM/uduVEG1dkL4cnlWVt/zLXKOjWdb7dg939LtfWx+vgFLCwUX
 nrdlLFU6XTs89qS0poooGozR5bGTaTghuegYrQ+5Wk2uJAdlud2f7TtV2j8er4w==
X-Received: by 2002:a05:6102:c86:b0:634:5339:33bf with SMTP id
 ada2fe7eead31-727c643f5fcmr2690300137.18.1781792899358; 
 Thu, 18 Jun 2026 07:28:19 -0700 (PDT)
X-Received: by 2002:a05:6102:c86:b0:634:5339:33bf with SMTP id
 ada2fe7eead31-727c643f5fcmr2690262137.18.1781792898778; 
 Thu, 18 Jun 2026 07:28:18 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa890d8sm263152215e9.10.2026.06.18.07.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 07:28:17 -0700 (PDT)
Message-ID: <a6b6b7d8-beeb-4d62-b274-c2d196a7ae19@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <4420c1d2-0a4f-4a99-814e-f7b27a38b03c@oss.qualcomm.com>
 <ajP-y4C93kc_jcae@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <ajP-y4C93kc_jcae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzNCBTYWx0ZWRfX7umZPLGtz/ae
 SZR8ALzTJ5PsTIGmtfq9fK8YFpS1IKFTk70hdCkM06T8sqgfREZIyOEZBIW6NWM/JctEjhmM6Nu
 muI3lO1BDpRfRgFaI9B6l4hltakkP0PYB465mfIpukjMK0MEyHdNYSwaq5UfWWfVeLnBzCntSiv
 gSEfdB0uvVi3OhR1myXSVtdYEZ92ip6JN5aj4Vu1bodM8pIDjQB9s3s9GtBuwmlHUKy+ukyTzk6
 p9tCwsLLBB/ZwYu+lta5X7xFKDJBp/CNyWAlZVmzzdtOTFVoMtyHUyGMQF08TZtPE0ingjf7VJy
 OaWoaW4RAD/bjhQ3zMh+EpZz/JWyGbwawolaXwLnrE/qhWL6JJoc458xPmeY37Tvf637d9nQv2h
 1eTDS8qGZb7Qw3wAPXFx3DyYJoP70wy432Cd6+XxzV0tOCbTbGjbYZi00rDef5RmMI/xXr9lOXH
 Qb0csQ9xVoWvhCWNhKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzNCBTYWx0ZWRfXxr/yXJNEO9QD
 q4QqwQyzSOmo3pGWh617xt1tsVRVFXsvOEDERXNh6ryFh2iOoct26aA42iDQELsQMX/q3BOreng
 oiKAVBdiwTSrr/qMgsrhMHUIlBd0Myo=
X-Proofpoint-GUID: d_GJz1kgiKFW9KKqQwHmS0Wt3eCKdo1o
X-Proofpoint-ORIG-GUID: d_GJz1kgiKFW9KKqQwHmS0Wt3eCKdo1o
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a340084 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=ID6ng7r3AAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=uBfNojPgi_GBrEQPJqUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180134
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 18/6/26 16:20, Daniel P. BerrangÃ© wrote:
> On Thu, Jun 18, 2026 at 04:07:44PM +0200, Philippe Mathieu-Daudé wrote:
>> On 18/6/26 15:20, Daniel P. BerrangÃ© wrote:
>>> It is no longer viable to handle the incredible volumes of
>>> AI assisted security disclosures via email, nor are extended
>>> embargos practical or useful.
>>>
>>> Remove all information about the current security process and
>>> instruct reporters to use 'confidential' issues. In contrast
>>> to the old highly restrictive "need to know" approach, the
>>> new approach makes all security issues visible to all QEMU
>>> maintainers immediately.
>>>
>>> The focus is on making issues public as soon as possible with
>>> a viable patch. Co-ordinated disclosure will no longer be
>>> attempted and nor will requests to embargoes be accepted.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    contribute/report-a-bug.md     |   9 +-
>>>    contribute/security-process.md | 309 +++++++++++++++------------------
>>>    2 files changed, 148 insertions(+), 170 deletions(-)
>>
>>
>>> +**The QEMU project no longer accepts security issue disclosures via email.**
>>> +
>>> +New disclosures must follow the [report a bug](report-a-bug.html)
>>> +process to file a GitLab issue (work item) for each potential issue,
>>> +***marking it as "*confidential*" prior to submission.***
>>> +
>>> +Some important notes when disclosing potential security issues:
>>> +
>>> +* The QEMU project cannot provide an SLA for response to security
>>> +  disclosures, or any bug reports in general. Issues will be
>>> +  responded to at the discretion of maintainers, subject to their
>>> +  available time.
>>> +
>>> +* Attachments added to GitLab *confidential* issues are not themselves
>>> +  confidential. If someone knows the randomly generated URL for the
>>> +  attachment, they can view the content. Thus be careful where attachment
>>> +  URLs are shared, while the issue remains confidential.
>>> +
>>> +* All disclosures will eventually be made public. Thus the content
>>> +  or attachments for any issue must not contain data that the reporter
>>> +  considers to be sensitive / private.
>>> +
>>> +* Not all areas of QEMU are considered to provide a security
>>> +  boundary. Consult the [security guide](https://www.qemu.org/docs/master/system/security.html)
>>> +  for details on how QEMU classifies features.
>>> +
>>> +* If an issue affects a feature within the QEMU security boundary,
>>> +  but the reporter is unsure of the security implications, err on
>>> +  the side of caution and mark it as "*confidential*" initially.
>>> +
>>> +* All important information must be disclosed in the issue description,
>>> +  minimizing use of attachments to what is strictly needed. There is
>>> +  a strong preference for individual files to be attached directly.
>>> +  Avoid the use of archives (zip, tar, 7z, etc) to bundle files where
>>> +  practical.
>>
>> Except this bullet point, everything LGTM. Here I'd enforce reporters to
>> attach a reproducer (in command line form, with image attached, pointing
>> to requiered public images to trigger the issue).
> 
> FWIW, I don't think we're going to have a significant problem of
> insufficient info with current disclosure practices.
> 
> We've not required this historically but none the less most of the AI
> assisted disclosures have contained more than enough information to
> easily reproduce the issues. Either clearly describing the steps in
> the issue description, or shell/python scripts or qtests to exercise
> it.
> 
> Out of ~300 disclosures this year, only a couple have needed a disk
> image to demonstrate and those were stll trivial.
> 
> Also note that elsewhere in the file I also explicitly note that
> the reporter must personally acknowledge that they reproduced the
> problem, so they should be validating the instructions the AI
> spat out.

OK.

> 
>> If not provided, personally as a maintainer I'd like -- or let scripts --
>> the ability to discard the *confidential* tag to issue with no
>> reproducer attached, as I don't want to waste time guessing / poking
>> around, possibly realizing the issue is not reachable.
> 
> I very much doubt this is going to be a significant problem for any
> confidential issues we get.
> 
> The doc is biased towards prompt disclosure though, with the maintainer
> having the discretion to decide when to do that now.  Even if it is a
> valid security issue a maintainer can decide it should be made public
> without waiting for a patch if low severity.

Fine then, thanks.

> 
> We don't want issues to remain confidential for more than $SMALL number
> of days.
> 
> 
>> Otherwise,
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> With regards,
> Daniel


