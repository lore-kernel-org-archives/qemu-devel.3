Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF203606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VWwUmoYk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eepzn4JN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHDN-0006F9-Ae; Fri, 23 Oct 2026 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKHDK-0006Ee-V4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:29:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKHDI-0005IO-SQ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:29:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE69pu2999825
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 opBUtjH+FbGG6WsqEfKArzcwdpIiUZfwSPoVpDfLgEM=; b=VWwUmoYk5FNzd4S5
 p7q46PMLcpvE5SgSbYU5lXtrXrDxUXkBF3s3MitJbBVmsNDHHQXmDGezFiKSRvow
 pJ+F8b6xu7q8iXa9Pb120RZV+bNNvOI0f30elBQc07tBo2/NTnLp4bCVb9vcphRf
 mzNBkwtcKdA46Q28LTDwDb0QxY7acjCyM7CEL8MznVrLqxGUN2dDYgF9baBApjEi
 J1B5a8B/3x1mhx/kw0vIJkqnsC5piR1ziQxRsBc2AUk7p5eaoTx7GEcyQDnC3B+J
 in2UnKFqlerHCb3NsIw3r2n5JUSgUmK1PuUMHXW6DQx0B6UhZ2oO9JV7ZCPumLJ6
 2uK5VQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0psv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:29:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c01778cefso22801586d6.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769386; x=1793374186; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=opBUtjH+FbGG6WsqEfKArzcwdpIiUZfwSPoVpDfLgEM=;
 b=eepzn4JNFlaHI1dSPqDAsv/mOe4rcwGuSKabWOtID80g/VbgZ79oh5tQrhal98Fvgl
 gkIzgVUNdSZlpGA9sOKryUCQAg1yiH3bZ73d27qI7tnoW59lCGmWsly53hT6namf9TUK
 yZ9oi65Db7A2qW5OmdhoNWCYC1bE/r90CIV11BSJ/KpnAE2xBWnxXDIGZJx/DJtTZs95
 1GVDs1EFQRXIw5kiEchOZQAR4zMuWmmGAZi7LpREcKRdhNnSRU76qDnDe287Ca1zQZSA
 YbmXB5izvZA+0M6j7qCMcUH9Sl6jNabHoYRNvZ+xCUPPWdEHpW4n8cmw248FuN5TEvr8
 rHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769386; x=1793374186;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=opBUtjH+FbGG6WsqEfKArzcwdpIiUZfwSPoVpDfLgEM=;
 b=LAph2qtyY4fzDvU0sL5EYO+JaR/0h2K78zYlZE4qfuRnds0PmPgj/dEFlvkTX1caVS
 apxWDiZgZAyWrF+OWzqI6BJmRVcdHFo/gF/ZugOYn8TbWEqkD4P0syUpgaXD8yihW203
 rqW/+tCsex/te3jqS8e2xl37sXuP9it7XggHk4CoBbuNgmJLjAy3s9zbDm4BSoGHIdYQ
 NDngzmhtccxOqzcHxdDzQy89Kw3gpirP54r8rHZ959QSHtWdy7kerOZO3/ZUp+48UtTT
 lyRw1YGAG5rqjO+vnD1O4U1+/MyHgv4w65S9IgxLMIYa8NbpqqqbN08xWagJsRDrIkUi
 o5vQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkDdUXlK3jq8w8O3w86OUHt29ZgPippUpYXcnsiTyw1vtY4ofbE+Xzvi6ATZ9dwIV2I5tvjikym9iy@nongnu.org
X-Gm-Message-State: AFq9FYJwIJsp/1FmKV/vQYEH3KQ0HNS0jfdjp5SvzUYoanmkWIZxkeMT
 NiXT/52tlxAOu2uV0Jzm6go5vUZUrpfaP3LCUltxjSRP5Alz/AKTf3MVfzMPgx/m2cjubHCm3dS
 h4Var0kq/rYBAspxQZUhNtvdq+JIVu0l4OQo+twh27DldLZ71ImubdsS5Tw==
X-Gm-Gg: AYBFou1+/RH/G1QNNhKIw1SLdAl5AJu/wW+vWg5sWS94ZMPdF1FVs+r5r1BBbCAwyRy
 ysFSfRzC06QOZD4+1xh4DFMFoIVurEluwo5m4YwBi1JQbZwKJ0hV1k5ry/mW5cUNJYPvW04Cdta
 Z09FhvI3/+BTf9R0zIyz+jQMLCMz0poboX2Bt0ZncWtlU0j+E36Ud0Rpv2uCLoZ4iuDquRUVuMT
 XKqnkaMiS+OSW2AHAytZf8rPSEpcwSnYrQozeT3yeFMGR6yrE8B1qVi5YTVwRCl5cC21BvJBEH4
 S0yjZDhDA/LeM11Fg/Qn2cOkGRrDeMKQHH7mCvjuzDODhRH6VpjmIp3g12E7G54+RjrBSNgYvcL
 8hyNb4FEx5Qm/e0JEs5Jm20i/dL6Lu65FfIHxUpdq6mJW9f0rrzjH2GSqCWy+EnR2
X-Received: by 2002:a05:6214:b6a:b0:91c:20ef:2020 with SMTP id
 6a1803df08f44-91c3a63b1aamr37670436d6.6.1792769385486; 
 Fri, 23 Oct 2026 08:29:45 -0700 (PDT)
X-Received: by 2002:a05:6214:b6a:b0:91c:20ef:2020 with SMTP id
 6a1803df08f44-91c3a63b1aamr37669956d6.6.1792769384913; 
 Fri, 23 Oct 2026 08:29:44 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c45228b5fsm4159176d6.20.2026.10.23.08.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 08:29:44 -0700 (PDT)
Message-ID: <fcf9f090-ce8a-4710-981b-366799bf9159@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:29:42 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new roms/ content for hexagon: h2
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Brian Cain <bcain@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "deller@gmx.de" <deller@gmx.de>, "thuth@redhat.com" <thuth@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
References: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
 <CAJSP0QX+aJJKes6zbxKZ0+NEhYydXhK61+cva26jTFw3dLRZMA@mail.gmail.com>
 <ba6246ab-38ad-4d32-be51-51c1c99d2569@oss.qualcomm.com>
 <CAJSP0QV9rQSmcb-K609iSje4VHgs_NK88YXKv5-LtaLGOh-nZQ@mail.gmail.com>
 <CAEqNhNZqEFz9oh2jY7EDx_ZWBgzTVstQjtZL4O3xSbK7LRwBZg@mail.gmail.com>
 <CAJSP0QWuBjxE1g7a7xbERBRcOdbwKUjOvPxDuyBg9heXVtzS=A@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJSP0QWuBjxE1g7a7xbERBRcOdbwKUjOvPxDuyBg9heXVtzS=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX3NnTrfL/n6Rk
 U4gk54w7pOyDguYicrplOiPM/Ax4DspVdeINexLScAM/t2aqDYEqLEHhvyhiF1oKrvdKJrSHrkg
 gowsG05d+tXsykjikO0pAkNjF+JU4iOLjCbFz1UIYhQYRvBapjGBXHpkdVCt1pic3RyhA5Iy/ZI
 lrpGCZh7lYVqef6u49ZOOFdAh7X5AR/re/P2X+7uwr1EaH7J2fmtlaeYSGvarwWg6ZOR4EOTl3m
 nDXWn5UWfrxqljK6V1kduvyFb1pkwpoUByst1v3m4wQ3hjQE+jWtpOJP4D7UKf9lY4FG7kP4SC/
 wVkk0KUUS6YkJ3G/f36iwFLUH+E4mCxVj4t1jt3Pp6iZChcF5iN+IxZaPj6SdSeqrRpeojCM3nS
 VK9Yppx8FaUGmJ/Y2KQBsOWhP9RVoV+B3aLqe5w9HPbAXPLxGIfurNeXl2fqtDgcBqxcSOv85Qp
 bGIEH6RkXYkXSujMs3w==
X-Proofpoint-GUID: PKP9K-epSmb7_I55KxvTUVC4SRFExmYS
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb7d6a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=QDtakQoWLUx7RWLp-yYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PKP9K-epSmb7_I55KxvTUVC4SRFExmYS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXz1Lq5PKl82Kc
 Z1f4ZQ26HQy8md9fphXJbVlxlgG414bqNWQLoDpt+Tg0t/q/7fL1G3i/WvQXYQ5l1Ch0KAg7/Ay
 bqm//k7BFrIbHgc1GmNmpm9i2CcJPrE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230060
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 7/10/2026 12:42 AM, Stefan Hajnoczi wrote:
> On Thu, Jul 9, 2026 at 6:31 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> On Thu, Jul 9, 2026 at 2:51 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>> On Wed, Jul 1, 2026 at 10:21 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>>>> On 6/30/2026 11:01 AM, Stefan Hajnoczi wrote:
>>>>> On Sun, Jun 28, 2026 at 9:46 PM Brian Cain <bcain@quicinc.com> wrote:
>>>>>> I'm working on upstreaming support for hexagon system emulation and it'd be useful to add the h2 vmm to QEMU's roms/ in order to simplify booting OSs like Linux.
>>>>>>
>>>>>> To that end, I think the initial step in the process is to mirror the repo in the qemu-project?  https://github.com/qualcomm/hexagon-hypervisor/ is where the code is hosted now.  And once that is done I suppose I would add QEMU patches to add the build process and build output into roms/.  Can one of you do that mirror step or suggest how I can do it?
>>>>> Hi Brian,
>>>>> I have created a mirror of the stable branch here:
>>>>> https://gitlab.com/qemu-project/hexagon-hypervisor
>>>>>
>>>>> Please take a look and let me know if you need any changes.
>>>>
>>>> Excellent, thanks!
>>>>
>>>>
>>>> I have a feeling that the 'stable' branch of this repo was a 'good
>>>> intention' that does not have a process by which it gets updated.  I've
>>>> asked the maintainers if they plan to keep this branch active or prune
>>>> it.  And I'll ask if they can generate a tag/release that we could use
>>>> as a basis.
>>> Hi Brian,
>>> Would you like me to change the mirroring configuration to follow
>>> "master" instead of "stable"?
>> Yes, please do.
> Done.

Thank you - I've (finally) followed up.  Apologies, not sure if anyone 
else would be a good reviewer in addition to Pierrick. I've been lazily 
relying on the magic of "git publish" to pull in the relevant 
maintainers.  I'm adding a link to the thread here in case others want 
to review.


https://lore.kernel.org/qemu-devel/20261023152117.3668641-1-brian.cain@oss.qualcomm.com/


> Stefan

