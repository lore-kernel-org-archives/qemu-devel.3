Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB84FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDr3-0007Ax-Sm; Wed, 29 Apr 2026 18:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDr1-0007An-Uj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:58:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDr0-0007Z0-13
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:58:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TMF9Om3884903
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aARovWH86GSkpUcuF+YvzZeFkn2zSetLrAx4yFnQxxM=; b=I7M32HuV3XTMPgne
 wuH92b11KYIYQgCm8n0BsMR7Z2KqeH07ChfGqfCX7Uob8IyGJICKJZdgLvELEW+7
 G6FYYtwoMcgDHkiyWD4nqWpOAOeQ0F+TtK9uSx7DFHihpkVUUxVr5ZYE7qoDm+Lh
 sxq8PEPrb8hQHk1fAPPmragLTfOUOADr7uC7C3boCPDRX4dHCG2ynWVY6zpevJ/o
 98cMagqb7pPG2RCeYh1d7BTgctD7DjpygmBhgtqhhtV8/B7nMOozob7GVSWjJtIj
 Jexioi5joHnaFM14pTxivYw4SnWKtdaY2L33ALTvs4G6JMeV2mmsP2LmrZjnDi0t
 D47PvQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dutmag347-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:57:59 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c8de02a4dso1497515c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503478; x=1778108278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aARovWH86GSkpUcuF+YvzZeFkn2zSetLrAx4yFnQxxM=;
 b=T4lXrTKVWSWb0gaRtC8dNmuXDATJf2wpKpruj3uifV4g18Pe9qPWYqP4YJX3y+pL3M
 x+EO4gyIS0QzeorEmJxqQ5g10I090inC+M8anFPFbwuvDQORLJqGVLffqmlvQawAGzuf
 tbgawAq6O/MPD8fiB5NC3yUMUW+NJvL+Dn4QLncxCB7lKR7HhukCYNt6hUoHIlUlkGSv
 lY4bMhE47a80+oyvlgyIlLm0WcO7F8SDgZpi/IzTFik623ZWsexcPoOqF/nyFt2nxlX1
 RE0zaLjD6yuirw1JUMxszlDvPWMsxPinMZ03sZhd1Weh03YLJlzahCC9MIP1fkBEYW26
 F/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503478; x=1778108278;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aARovWH86GSkpUcuF+YvzZeFkn2zSetLrAx4yFnQxxM=;
 b=Wov62Qoqm6Zt+FzQoVMqrXCI3rSaEkaOs4tJ6tRmTlDOynOWUDAJwja6ZqrMGDB9+F
 ONs9FYWw1brlN9YnEd6xetRXca4bwcsdrR0M2a3ZwbFHoRDy5xuSa1Sxi2QjWpUnT9rp
 djN3bSne5b6dTQ1gpTqcQy9kOZibfNHdD1nI5w2ZslFWlu/LjSOFiDT33BHfrhcNSvil
 eCajXd6O1UEGIVaQ5XIA+COsrXwM+0YnWzuxgtKwdtCjLFuJhL20N54DNQ+22CZGgyyY
 +K8AOnVr6E99pu9wpzwzvx6pA3GICOtsDceI0/jujsQdP3fgRl9Np1tg492VoCtZql8e
 tpAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lg4MVAVfYrVq4F5Pyhb0jo4hNvkmMP7dVsk81HFEAkyvw90vBGA8ifnNztWT9n+wsieqJXAVt0tSM@nongnu.org
X-Gm-Message-State: AOJu0YyJ34FrjF0/XpHbMI8Dzle5XHfmqm/Z92f+FSGxYlgbf6Kj9C2b
 Q5MRpPuCOiD2irIJ08aH5HdHzFBajtoEdI1lT3nP44pTJAOqidLfLQ2SDQeGXDhFbHuDMCl9OD4
 FgwrjCx+n4cTCM4mP0rG90VQpKGi50C8eDCNQDiX/EzZM8Xy5xNQAWxJ+bg==
X-Gm-Gg: AeBDiev0fZ9Ck/Ze/tg7WL8uSqWCvq3f2EK3JZOSwAX7ONxKySCMs+TiPn49ZQrQ3V1
 3VvZWFbyytaFA+uqX1eZ0j+dbPtfodwEcT6FVylUnImWcIyzyS0UMCrhkYiBEyD7DnM0KLD/yNP
 I2a3gVn0WSocQQqiPph2iAHYTfQ5MA7gkTO+MRJp65Hro9M8rYlmLstzEZvq3vEAcGfbKCXbFAx
 2EaolDY6xOVy8OXgNfShZd3P8hs6YLkLlU0vz8BYejNL0khkMBtT+qPe0YFy3kigEsMzbfPCNYh
 e1zN51OraDpLasLjKAzkGuQSy9/p9f4N29tURLXC6DXyOWFaYwl5Ufi+dlUg12ND9E23/c7HeH1
 9sotAf/4nkoPr8WbHmDW5i/L3POBY167ipMRSAlcIE7WzjUMEzxqY/fHRqKO8BzJ3f9loCmo1JT
 P3T1dj2Uug+/55MCxJhbvpsXyH
X-Received: by 2002:a05:7022:f8f:b0:12d:de3e:cc03 with SMTP id
 a92af1059eb24-12dead2ee02mr204187c88.42.1777503477797; 
 Wed, 29 Apr 2026 15:57:57 -0700 (PDT)
X-Received: by 2002:a05:7022:f8f:b0:12d:de3e:cc03 with SMTP id
 a92af1059eb24-12dead2ee02mr204172c88.42.1777503477247; 
 Wed, 29 Apr 2026 15:57:57 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de321f1cesm6183056c88.8.2026.04.29.15.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:57:56 -0700 (PDT)
Message-ID: <7c91f7f7-b728-455b-be4a-e0b4154efecf@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:57:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] bsd-user: upstream ioctl
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>, Alexander Kabaev <kan@FreeBSD.org>,
 Sean Bruno <sbruno@FreeBSD.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <31f894ed-4acf-4d0b-9335-c94d67dc53bd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <31f894ed-4acf-4d0b-9335-c94d67dc53bd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bqe3yhZuwW4btegFDVW-bAX7iODi4gv9
X-Proofpoint-GUID: bqe3yhZuwW4btegFDVW-bAX7iODi4gv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfXxPMLIVAahUPX
 om2UHbyGX+EchSjB7PKmpaUjFo3sB33EGAv6rou7XNCIa/xxZ46I0hRGlSw4JXS3Y5XfRzHO6ZJ
 RnWmhwkXXQ5xINxFGKkoeEDhHwozhc9nyDPC0cXB7DwkE8xJh2oSUn6B+MrbMkC680SfKyAWtcP
 wCS5zzbpvkfoAUW6V/Re9C0auoj0F8h1cY18VDHDfQtXB0+Tg3K5ic/c6sAGmCx1eLRAE1NuUlk
 waboRJ5zKT39GckN/0qvnJBNDNIWHjb70wiIKrOADdZ+3gIhFaSKFedjb5P+/FC+SxV2oE9/SNm
 tjvUhbVEKEbMBpB0kCWvq7HILz+0NiOQvWh1/EScwIpZU+qqJ8gebBglZVRa33I5rQC6VgbdClK
 i1tWtElBz6jYYmoU3lA/Gh9Mu5uWfS0h25rVgjva4lxGv61fPeryTBYAIbwZN0L3WzWg8Gm9COs
 WAmf3YGi6oC6IAqgYoA==
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69f28cf7 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=7Qk2ozbKAAAA:8 a=NEAV23lmAAAA:8 a=hfwOJu26wxn4Ku-7IDIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290231
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

On 4/29/2026 3:52 PM, Pierrick Bouvier wrote:
> On 4/29/2026 7:45 AM, Warner Losh wrote:
>> Again with the help of claude, harvest the ioctl changes from
>> bsd-user blitz branch. These are a bit messy, since ioctls tend
>> to be a bit messy. Ideally, all this would be generated, but
>> that code isn't ready yet, so we go with what we have.
>>
>> Please note: All style complaints are false positives. The > 80
>> character ones are fine: these files are semi-generated from upstream
>> and fixing them makes syncing harder. Harder syncing in code that's
>> basically boilerplate is worse than lines that are too long for
>> definitions people are never going to read.
>>
>> The two errors:
>> ● b64902a56387: bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
>>   ● checkpatch.pl: 197: ERROR: Macros with complex values should be enclosed in parenthesis
>>   ● checkpatch.pl: 198: ERROR: Macros with complex values should be enclosed in parenthesis
>> are impossible to fix: they are what they need to be for the macro
>> tricks that are being used. One cannot add parenthesis and have correct
>> code.
>>
>> This is largerly unchanged from v1, which didn't get any reviews.
>>
>> Signed-off-by: Warner Losh <imp@bsdimp.com>
>> ---
>> Changes in v2:
>> - rebase forward, minor tweaks for blitz branch evolution
>> - Link to v1: https://lore.kernel.org/qemu-devel/20260412-ioctl-v1-0-1d998a460560@bsdimp.com
>>
>> ---
>> Stacey D. Son (10):
>>       bsd-user: Add FreeBSD tty ioctl definitions
>>       bsd-user: Add FreeBSD file I/O ioctl definitions
>>       bsd-user: Add FreeBSD socket ioctl definitions
>>       bsd-user: Add FreeBSD cryptodev ioctl definitions
>>       bsd-user: Add FreeBSD disk ioctl definitions
>>       bsd-user: Add FreeBSD IPv6 ioctl definitions
>>       bsd-user: Add FreeBSD ioctl type definitions
>>       bsd-user: Add FreeBSD ioctl command table
>>       bsd-user: Add bsd-ioctl.h header
>>       bsd-user: Add target_sockaddr and safe_ioctl to syscall_defs.h
>>
>> Warner Losh (7):
>>       bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
>>       bsd-user: Add log_unsupported_ioctl function
>>       bsd-user: Add do_ioctl_unsupported function
>>       bsd-user: Add target_to_host_sockaddr_in6 function
>>       bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
>>       bsd-user: Add do_bsd_ioctl main function
>>       bsd-user: Add init_bsd_ioctl function
>>
>>  bsd-user/bsd-ioctl.c                  | 438 ++++++++++++++++++++++++++++++++++
>>  bsd-user/bsd-ioctl.h                  |  14 ++
>>  bsd-user/freebsd/os-ioctl-cmds.h      | 151 ++++++++++++
>>  bsd-user/freebsd/os-ioctl-cryptodev.h |  74 ++++++
>>  bsd-user/freebsd/os-ioctl-disk.h      |  41 ++++
>>  bsd-user/freebsd/os-ioctl-filio.h     |  34 +++
>>  bsd-user/freebsd/os-ioctl-in6_var.h   | 217 +++++++++++++++++
>>  bsd-user/freebsd/os-ioctl-sockio.h    | 240 +++++++++++++++++++
>>  bsd-user/freebsd/os-ioctl-ttycom.h    | 237 ++++++++++++++++++
>>  bsd-user/freebsd/os-ioctl-types.h     | 104 ++++++++
>>  bsd-user/syscall_defs.h               |  10 +
>>  11 files changed, 1560 insertions(+)
>> ---
>> base-commit: becd22fdc2a071783d9e04421526633772b3b98c
>> change-id: 20260411-ioctl-68c80a77ad32
>> prerequisite-change-id: 20260312-share-thunk-ab1585477999:v2
>> prerequisite-patch-id: a048e442d9dda7ee4ed1070ef5eb524e078b9a3b
>>
>> Best regards,
> 
> Hi Warner,
> 
> a few checkpatch warnings:
> https://github.com/p-b-o/qemu-ci/actions/runs/25116258138/job/73604077805
> 
> Regards,
> Pierrick

First commit seems to not belong to this series, but taken from
prerequisite-change-id. I didn't know b4 shazam would be follow, but
that's great and much more convenient than the custom Based-on tag QEMU
devs are used to.

