Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F2606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RN2vkv8w;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SkLuMLZE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI2k-0005pd-JC; Fri, 23 Oct 2026 12:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKI2P-0005cB-8B
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKI2N-00037A-0N
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6A7i3019170
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MJvgy5yd6ENulL2kEQpUKDXI68s6+l+K7NwnDnookA4=; b=RN2vkv8wtRECq609
 3JdhsAh+ERb1EZ/GSRsaydZDnIjLDF/gZo4o7sqGWk97Vaq55TW3cWkWlo0/Q5LN
 dt6fbXgu4m7QMeOgLNHO4UHlpqvjdZwTxwJsla8IybP+HKMYkRM8coYhz3MEqeSr
 ntQ712rSRT41D8YpP5REMXXgbq+QJRgPxgqWHRmxew11IytUMK7Asf4J+RZnMrxI
 zZ/0OUpFn81CRd00hLvU4Pib+KazXeZaHzNBDcYO/KUZp2JbH+szbGBwLMkJz/kb
 h6HgYO0zyvDoKMjkEhIToqOwUmYuyfnGQeBkJ+BAKytWH1ZG6fOL3jbupjj56/xy
 gbC5gA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykbyb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so3358018eec.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772551; x=1793377351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MJvgy5yd6ENulL2kEQpUKDXI68s6+l+K7NwnDnookA4=;
 b=SkLuMLZEwfXM3dYERla1Q5ig5uSMJrYQcpinw0jANQPOzE/afIcQu72Do4/fo/FvIu
 nDHD0f1Kjlv0iziuAQDFthaY5EqPP0/Km1KzD2BXIeydNJ3My0efvd/OO9zuwP5k+S9Y
 4D3Xu+y/Rj7ErAJtgrA95jDrrRDwasaBvl7DX84xQAQx76gWgZUA1+aWGKojIn4P2cW4
 ZTiOZvnjhixz0IIDORNyJNpHjQGsOsxvbMdEOgyOjVg56rUvOhpdk7pNwAlDHOIDCcbN
 /BG08nfXWzdr9CE+RuR3YRAVmsNeaODMceKvWZOCogNVS81u3z5d3lb8dX5hOPdCkxXA
 dmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772551; x=1793377351;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MJvgy5yd6ENulL2kEQpUKDXI68s6+l+K7NwnDnookA4=;
 b=MmM4xzylGAOIQ/FJEOBtPXh1YsWqfLeQ6FVZIt7UDI3rvWUeGxhvZKtpH4f3MC4nJT
 NnvkcA0INN0FBwLmyV8RRgYoG1KSQVg7jk3eind/UN5dJiysj5Wr/zgJEKhXrat8azm5
 55Fw1PiQsTrqIXrEFqgERkf4mXZt33Psw/ATcR7D8SGijeHPRIjI69de0O2HuCPPT9h6
 XcZgOJgg/U43DA1QLV++RWZ9AojyUS22KPTYFUL5/2maXXLbgvxKXObnKWMZkAP9/4Zu
 mLasreIwl9YmQ0NJY7c21Fy5KxPw+B7tonl58m5AEsEdx+0Xnjgrn+Ou4IMnJqfjAB40
 qYew==
X-Forwarded-Encrypted: i=1;
 AKwUvByAZTi+fvj5fzUitSf+gAOk+A2h9dOZSLNoU7MjbqVCcKhds8AN+LXeiCg9CSqxSnF48UVmR9Xypbo5@nongnu.org
X-Gm-Message-State: AFq9FYLGPMDVkGjHY+sbafA6bUP+Vp8MNIi/KTIgBk6i5tlhZOba/LOV
 xYhe3YdP1YGvsT59IfUoamZ8peKxcPQOg/OCtdE0Pr7fP0tBsAONDawUxTWhKprhdk7J5EoPzPO
 2OZSSI23d/pxDF3UBQ2Sh2exWHa70zwbTsv8RZGaPUvsXrmZuMctZ+bXSCQ==
X-Gm-Gg: AYBFou3VgSBwjM813V5EG4dpxsJgiKRtUjFjPVsylhZTLxX1kvP9qErttis+kQL5ILS
 H3U7FO7IAl3A6i+hhJsF5jo2aQVahM+G9Dg9FwdxncC7khrokmL3YI1VMubfQT2t20/woeDaUIs
 W66te1UxwzXBnEnBq63S5f8YEs1W0ErTb3QABsVyqfXELLdg0O31XMF0lhU/Fhu4qMrPMevBUyG
 hDN9FJVmJP8dz9jtWTHNlVQkP6puKSHzYPd/X73s/Vk2mmmuqgrMzoKQDnhpu81FW0fyPcXRvzo
 kdFEM4DSF8sH72fLSwVN/RWxEVHcMqYqKHkg4c65D0w9WkXO5fBdFNaj3nk+xeSy/PZ0wI895VB
 lWIVjEwPEp3k/4TwXOmaiZ3WNI0Am1iOmrfvwKtqyDxYT2Jj7A8uicVepVR/rBxufpq3V1Q==
X-Received: by 2002:a05:7301:488e:b0:369:b75e:d24e with SMTP id
 5a478bee46e88-369d90c806dmr3669530eec.5.1792772551100; 
 Fri, 23 Oct 2026 09:22:31 -0700 (PDT)
X-Received: by 2002:a05:7301:488e:b0:369:b75e:d24e with SMTP id
 5a478bee46e88-369d90c806dmr3669494eec.5.1792772550482; 
 Fri, 23 Oct 2026 09:22:30 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e6c7de15sm726874eec.3.2026.10.23.09.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 09:22:30 -0700 (PDT)
Message-ID: <1e0403dd-2ed8-4a0e-bff8-74726d2e8e2b@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 09:22:28 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new roms/ content for hexagon: h2
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: Brian Cain <bcain@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "deller@gmx.de" <deller@gmx.de>, "thuth@redhat.com" <thuth@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
 <CAJSP0QX+aJJKes6zbxKZ0+NEhYydXhK61+cva26jTFw3dLRZMA@mail.gmail.com>
 <ba6246ab-38ad-4d32-be51-51c1c99d2569@oss.qualcomm.com>
 <CAJSP0QV9rQSmcb-K609iSje4VHgs_NK88YXKv5-LtaLGOh-nZQ@mail.gmail.com>
 <CAEqNhNZqEFz9oh2jY7EDx_ZWBgzTVstQjtZL4O3xSbK7LRwBZg@mail.gmail.com>
 <CAJSP0QWuBjxE1g7a7xbERBRcOdbwKUjOvPxDuyBg9heXVtzS=A@mail.gmail.com>
 <fcf9f090-ce8a-4710-981b-366799bf9159@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fcf9f090-ce8a-4710-981b-366799bf9159@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX4UMS4908A0/P
 6Edk0DMYmGz+Ak8EEhwjjxY9QP92CC7ajLLeLRXTFOlBrRuZ4niHRkBD44deVERaDjgEySu7csJ
 kDHMtI6M0DAELCTwTblmn3lcx1QxayRx6KRWwYzssTFbx/XN2v1BDKiMP7YucrjE2p4hzYgcwXw
 J3iwtzGoSPEScy0wUqcnb9Eg5LfZAdVu6AHv6G4KaaJsWtKLJE1T0q+nLyCpxOjEKa2vH3/MyHy
 XHxM+EyT/AVXhbCHkgXMiRccRNxr6mr8ouDIsOn5BIeGljZYbwipXNq5EEqCu9aRbzGcv0oIMAp
 6bdIUUtyAUrVuIVCygLT9DYJUwpRiUuLCHF6fxfIaHLLX0ekn8HB3PHu58W425NQ4yWiRYuS8kE
 ARiBPYZqvOaWyLBRFnTk8UZa2REKdYCzRcznzEYM0jOSFj49C7WtnQ0aqsKGOnN2hywN+iMbUyi
 ZrzFh7DzWmvYPq4zO2g==
X-Proofpoint-ORIG-GUID: IxEA5G_eO7bG9Pm7tKcat6ZMKQQFrpO6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX+567EQPkIdky
 DhuT5PSgu7l/QVnOqwvTnOkRWCqWKiLytiuRxtLmRqrhV+N17Clk37aLcnKVGFKGThrai+vYnxJ
 tQKmQ9AsjqsefYnSuCpSgqWRrCJix/Q=
X-Proofpoint-GUID: IxEA5G_eO7bG9Pm7tKcat6ZMKQQFrpO6
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb89c8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=XlX4fRG5bbw2bmG0eXkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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

On 10/23/2026 8:29 AM, Brian Cain wrote:
> 
> On 7/10/2026 12:42 AM, Stefan Hajnoczi wrote:
>> On Thu, Jul 9, 2026 at 6:31 PM Brian Cain
>> <brian.cain@oss.qualcomm.com> wrote:
>>> On Thu, Jul 9, 2026 at 2:51 AM Stefan Hajnoczi <stefanha@gmail.com>
>>> wrote:
>>>> On Wed, Jul 1, 2026 at 10:21 PM Brian Cain
>>>> <brian.cain@oss.qualcomm.com> wrote:
>>>>> On 6/30/2026 11:01 AM, Stefan Hajnoczi wrote:
>>>>>> On Sun, Jun 28, 2026 at 9:46 PM Brian Cain <bcain@quicinc.com> wrote:
>>>>>>> I'm working on upstreaming support for hexagon system emulation
>>>>>>> and it'd be useful to add the h2 vmm to QEMU's roms/ in order to
>>>>>>> simplify booting OSs like Linux.
>>>>>>>
>>>>>>> To that end, I think the initial step in the process is to mirror
>>>>>>> the repo in the qemu-project?  https://github.com/qualcomm/
>>>>>>> hexagon-hypervisor/ is where the code is hosted now.  And once
>>>>>>> that is done I suppose I would add QEMU patches to add the build
>>>>>>> process and build output into roms/.  Can one of you do that
>>>>>>> mirror step or suggest how I can do it?
>>>>>> Hi Brian,
>>>>>> I have created a mirror of the stable branch here:
>>>>>> https://gitlab.com/qemu-project/hexagon-hypervisor
>>>>>>
>>>>>> Please take a look and let me know if you need any changes.
>>>>>
>>>>> Excellent, thanks!
>>>>>
>>>>>
>>>>> I have a feeling that the 'stable' branch of this repo was a 'good
>>>>> intention' that does not have a process by which it gets updated. 
>>>>> I've
>>>>> asked the maintainers if they plan to keep this branch active or prune
>>>>> it.  And I'll ask if they can generate a tag/release that we could use
>>>>> as a basis.
>>>> Hi Brian,
>>>> Would you like me to change the mirroring configuration to follow
>>>> "master" instead of "stable"?
>>> Yes, please do.
>> Done.
> 
> Thank you - I've (finally) followed up.  Apologies, not sure if anyone
> else would be a good reviewer in addition to Pierrick. I've been lazily
> relying on the magic of "git publish" to pull in the relevant
> maintainers.  I'm adding a link to the thread here in case others want
> to review.
>

I'll take a look, and would be happy if the more experimented
maintainers here could take a look also, as I have no experience with
upstreaming roms on the project.

Especially around the layout (should all files be prefixed or in a
subfolder), and the license added. I'm fine with how it is now, but
people having dealt with that in the past might have a different opinion.

> 
> https://lore.kernel.org/qemu-devel/20261023152117.3668641-1-
> brian.cain@oss.qualcomm.com/
> 

Regards,
Pierrick

