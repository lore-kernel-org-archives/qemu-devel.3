Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6E1C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1R2-0007cS-ID; Wed, 01 Jul 2026 16:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wf1Qw-0007c5-NW
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 16:21:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wf1Qu-0003M9-Vk
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 16:21:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661Gmj4r1590015
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 20:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5wmlurrdykMTTLEIwFUHCN0Kmd3yPS5/zJEe3OJGT8U=; b=PK4bpu61UKPKa3hF
 hJoEXzwd1BOMMIyKBIARPpFN02XDfuEolPKVDB2fGRZooA2J9z4f5tu86WgFmisH
 iGIGNOnlZ1wOPxE3oRB3z/fzSDwTDJNeUkf665DWuEYff1SyXpP3IT+DFj13DNyA
 s3g2/+gVNrsJUA8ijta40dfcni5MkgaRLNuIB/3Tjfdz63dJxyYcOujeIm8r/nIK
 db7mJfyaJgKimR6rPi1moMEunt5JfH/x6VCGuKsjoAZ854HazigPKGt9ougGB2/6
 N16pMGY308X6tORDPvDT+a7V3oh3mdyLPDrOpz+rn3G1XpCjTYExsmphuWL4vdSr
 JMVGnA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q09pmc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 20:21:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f0867a75ecso23158266d6.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782937276; x=1783542076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5wmlurrdykMTTLEIwFUHCN0Kmd3yPS5/zJEe3OJGT8U=;
 b=XQZ7s9vuYLS/2Vsfll8lWCpM+loEmf8yEXuV1gCRnGBBrgI2fDQlwkTSqfZycGAgqO
 /0jndFj7/vVQqmpnzAbsB6AFxZMvZ8wmFh1U/f3CHJfYcjcQBoSSyPi8bGF2Cx8+F1C8
 awCYYCTklTA66R3yr+3vQDI+I4eNyz9tFcTqh9462LYZzz080bm7CRcaiuf0a9Y7/l6H
 PwOT3n9M/fwJUJQKJ0qLB7OcFL2lN/Ue4kUxbcUPRwdEX3xz7/62kfOVUFZhIopI1sgw
 RZBZcYshQRWTv7oD7RlN6eTXPmNhlXJxcuCYVepGToQm7LsMxI1ToEoUbqWIqgEnKazr
 4nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782937276; x=1783542076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5wmlurrdykMTTLEIwFUHCN0Kmd3yPS5/zJEe3OJGT8U=;
 b=s6N/buRqsL19WLinZR9Fpa66ixO8YguJ5IqR03eRBUkTq4KugXZTRKQxMpfFdUlE5j
 FuzeCCWbYHkjoXfTrsr26vyZqULyUAhiXkX8MW9NO2X/BzK5SDPVYu6qekk4PI8QfxrS
 +DCTm6H4GiydhrLgs1z9LaWIf1Id6UVI8dxav7LceTPwkKBrOLaEgGOwL1o3SqE+bORo
 xO3JzKvtCcI5wNvS+1mpv6d1XFFfz34VgYX93g/DN5hmOhqRyQStAP7S5vDBqHbshCC9
 shqLw4zxgCiLTfXNJvom7T/IfPXMTXysyNL59ElzOMYI44mmzANBwRTL3zi6JWXGTWhk
 AhDA==
X-Gm-Message-State: AOJu0YwHLk0fiZKJiKitTclg2pj/puXgl0f3KZj/VzvT3jfAfJf9c92y
 EuO5IvohsLSN66mkr8H8MtzaC4LopDA3NiL28PYg3T+ktVQh0XyvE6iAU6R2wU+CytMc9iTfOtg
 xXo/bDASoUN+VsSj4FWxT51VVNyifrxi5D4U6oBMf19NYFQM5/y6LkytyMw==
X-Gm-Gg: AfdE7clx8eLpmzc9WheVRo9TiO8GfesDnvgkkxOWWvttERpAEswav6NoVuS1xOiz7es
 hCfPznNXhXe/8rrp7HSXTb32TqF0ShsKZ1+UEpH1XKw+jYCwOTXaOPf9XNDhXfC14bxZEa0e2jV
 FqX2vwvWYrs7KUFKfpisna4hamPX/UvuGagzFoTsZ4sWTDVCOsCHz2bkTXz4G/GGkY0/LbNMpQp
 eZAXvd4STqvNUcQzTH9UIWwaMwG1O1wnsi0aDSLGoKhWB4qsl6WH55QqM/zLJidASuJpYsK/k4p
 HaTVW/HysNh395QpTsu9OG9PJA6/J6iNvXzzirzfXZH0+/sW5quq40KG86ZnNg4xyFUGFLe0n/S
 zqGZNJCngcROYtouuCNaNFibimI5ZUb3niR8Zt2hV+rZpwMonSw7E/WfD8gA1MCpbIvzALqYqJb
 o=
X-Received: by 2002:ad4:424e:0:b0:8e9:f5de:d62e with SMTP id
 6a1803df08f44-8f3c95d47cdmr31299096d6.47.1782937276252; 
 Wed, 01 Jul 2026 13:21:16 -0700 (PDT)
X-Received: by 2002:ad4:424e:0:b0:8e9:f5de:d62e with SMTP id
 6a1803df08f44-8f3c95d47cdmr31298336d6.47.1782937274924; 
 Wed, 01 Jul 2026 13:21:14 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4724bad04sm7738516d6.44.2026.07.01.13.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 13:21:14 -0700 (PDT)
Message-ID: <ba6246ab-38ad-4d32-be51-51c1c99d2569@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 15:21:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new roms/ content for hexagon: h2
To: Stefan Hajnoczi <stefanha@gmail.com>, Brian Cain <bcain@quicinc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "deller@gmx.de" <deller@gmx.de>, "thuth@redhat.com" <thuth@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
References: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
 <CAJSP0QX+aJJKes6zbxKZ0+NEhYydXhK61+cva26jTFw3dLRZMA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJSP0QX+aJJKes6zbxKZ0+NEhYydXhK61+cva26jTFw3dLRZMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a4576bd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=COk6AnOGAAAA:8 a=sV-nAV3Y9LPqhRapAsYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XSNWG-qJl9dEEHFel0qp_OPIbuw2-nDM
X-Proofpoint-GUID: XSNWG-qJl9dEEHFel0qp_OPIbuw2-nDM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIxNyBTYWx0ZWRfX2VoPu6zmZwMV
 +FKHv9MxBgZO0fQIabCcBsVW09tlxUgYVvHgQJI5yO1llidNzUppgJ3D4aWNriDZCH+ZIvVYfoU
 F43bSO2RQv0z0IVE5A5e6kaZO+Emck0mMud7sfWa03zbq5BogGjMPhyCgC7nJFliv9DnYZWOitJ
 kda9LslIjJzEhFLN8GkI0otlq0YdvqkW3IcLxSecUugOSQc3EVoIkw1MEl5ztDapQRLSghER5o9
 2k7ExdpfIg4iArJIJYwV1u4JkEA/HIkTnl5AaENfksSOv2o3+xTGPXOVtVzY5bEUiha/ay4ySnS
 gwtzy8ydUVDzRRVD4ZouBGCUgIGR2tpUCkhZwctZht1rAikNz1Io/3gxXqBYOErt7CMvFhRucYM
 SVHqFs4wkvuz8PIkvnjJI40ymhYO84tTiRQMVgJcKUlb1h5pX6W3qQu46ZtWxvc4TkSi1hbNfkK
 mZ/bQFNcBk4iBOtqrMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIxNyBTYWx0ZWRfX0G3eiFU+IMBX
 r/q7MSmYzq9otdUazIlBqDySFzUuBUhLJVs8FWQfbK4imoaV5S4IKMlu95rHSjEXeME/kI1L+oV
 jQL7BPsSOCG6NDpKSZjVSwGKiEUNkRY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010217
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 6/30/2026 11:01 AM, Stefan Hajnoczi wrote:
> On Sun, Jun 28, 2026 at 9:46 PM Brian Cain <bcain@quicinc.com> wrote:
>> I'm working on upstreaming support for hexagon system emulation and it'd be useful to add the h2 vmm to QEMU's roms/ in order to simplify booting OSs like Linux.
>>
>> To that end, I think the initial step in the process is to mirror the repo in the qemu-project?  https://github.com/qualcomm/hexagon-hypervisor/ is where the code is hosted now.  And once that is done I suppose I would add QEMU patches to add the build process and build output into roms/.  Can one of you do that mirror step or suggest how I can do it?
> Hi Brian,
> I have created a mirror of the stable branch here:
> https://gitlab.com/qemu-project/hexagon-hypervisor
>
> Please take a look and let me know if you need any changes.


Excellent, thanks!


I have a feeling that the 'stable' branch of this repo was a 'good 
intention' that does not have a process by which it gets updated.  I've 
asked the maintainers if they plan to keep this branch active or prune 
it.  And I'll ask if they can generate a tag/release that we could use 
as a basis.


What's the process by which we update our fork?  It has an automated 
mirror process driven by gitlab?  What if we need changes that 
can't/won't be upstreamed - can we make those locally?  I don't yet have 
any plans to make local changes, just want to understand how the process 
works.


>
> Thanks,
> Stefan
>

