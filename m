Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9479606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ifuqui2S;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZttnACsg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURZC-0000NR-TA; Fri, 20 Nov 2026 11:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xURZ4-0000Ji-C5
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:34:18 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xURZ2-0008Mv-4x
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:34:18 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfOGV304307
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 16:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KQ3zYJTleLktf5GQeOFYy9oaFuYDZ7W2KjBJNGiG96Q=; b=Ifuqui2SqZbLHh60
 JhFBTdZ+BrzsofMhOxKwXCtt5bKc+L9efKhHRPAXMh+O+ZecMPMCqUzUhKGfD/kB
 ptyuxN1DjZQA5hxOSo1Oz1Onnu7uB45HOanyU4LouL22/6jihYfa+49F2BIcpojS
 rHMMUnIkezspKug4BjqtB0IYH8ZPqrUlqeYXGosd15aIfeGC4v0nBeC7gCGSY3kI
 LX+84EC/jqqCSs7wzte1cy71AX5TSpUvlCnGFyD8jKLjM9VeJCg20UJOdq7j7c+L
 emwoNuNgT+GUundrExgsYZfcJh9pQrbJFY10NcwcyacMfO5YpYS6LWoP+0n6Ba9j
 dzAr6Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu82df2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 16:34:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f20addba1so198387985a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795192453; x=1795797253; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KQ3zYJTleLktf5GQeOFYy9oaFuYDZ7W2KjBJNGiG96Q=;
 b=ZttnACsgSp6atuL56UwJKm+ftKCWtzHucuFn/ITcWUF765wFzZ6kPSU4WjhnzpPmNh
 fR6sjBhRL46OOa1gESGC1sTv1WW/B1kD8KdpevPCmzNbrIA7fYbpeE5BoenGNJ5rKvaY
 y6PT34kos7064zmmjBYefHjo2V4OIQ8OP7TgHH9VQo0UZ7+4wNuKDN2weTPNbTqS7O7H
 NnqlnqhfmdcVAo9pnJAv/WZy50fY+IhRVkWj1vD/ZDa0LKAIVKE9pOvcqNGX+FnRo1nP
 xFteRLIdm3uoKfXaU9jklFWeUsKSnuxJMTPopOTKWIj0rODU/RX1UlZbuOyjcLE07hOj
 5GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795192453; x=1795797253;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KQ3zYJTleLktf5GQeOFYy9oaFuYDZ7W2KjBJNGiG96Q=;
 b=nO/KiD20YrT9TogNUP67bvkXC45Q44DxKW6MWg//64pIOqPiUSrjXkFzGB3F5tFV2f
 rvBFZ5Zf9tZdoE5do/P/6dQgInt+QUJ/i/8jyjHIKa+gtL8WsBwHyG/otK4WAa+Iv5wg
 T58lauBrXxLS8JaVhIHm5SsqH5CzLjUT8nKzwnIRyxlgqnYhXmaakkNSmaBa6LAEfmwX
 ZrjrA2/RLElk2GyShiWcvjn00rIXQijhS5nby1zaUUZtZ9hBAANR4D/XGOMjvOdq+aqk
 xfMJM82eyQhzyRkUWtt5oSYvSfWun4MrZiddsVz58jlY/nZbVsi5CzlFeRy6Sb9aMC5M
 k9dg==
X-Forwarded-Encrypted: i=1;
 AL+hErHXlRZd0esqlN4gkBMJzw1EAB9SVtQ3vVERnaeynudm/bJwxZkFIwBfnlE1uBFRvXchHBvN6tYsXFJI@nongnu.org
X-Gm-Message-State: APuU4Z/VHBGjeOZGXt0KhN+f+IDuRHdGKRPXpZn3xkGvn6u+w147swXS
 tEJo4OwoJE6i+7a9Xp7RcCk09oobeQDeDNNJH5ITIfhfGQODbw8nQbOQa4Yo1BvLPOCXIlerNOC
 YFkXx4sn4qqAZqPRKM/hMAsJ+j1uBhWbIwjZh4aJvD6P76u/1Hbv+0Lq3BQ==
X-Gm-Gg: AYBFou0pRgMDO+pEMiZLe0YfVvtbIN75pGjc3+7Xyr2eWrmr9EEPMW2TgzRCn2AA7wy
 ML5xeGmiW9RFc30GDlpdanZBHXYPxIv7n0hcS4DbbuisfLGrDw1u2KXtTqjVUK0XhMWguSQmFSX
 nwZuffeVd8ibFN4nmNTy3MkrohllxYk90/pkIaDRhQ6EEwUbavwgYdeve7UUD8RwbUPDDw+0USh
 kOemUz/5U3oK9o659C/KYckq1DXSUR39ofd0MP7Sv2nqrW9ghbnVtRlV4+dyuGcPbECsiF9Cyqf
 ghTaVVl39p7SqgnE6Xi494taST+X4rvk08MbpXc2hm6ELjDn6EfA9lq/CldpAGrNbVgXo1B6glw
 GG/wkbSSa79dxsVh5i5RSO/R5uWjEU1BO+SR2tKgKXur2U4WPJtcatJ6xIX3prSaoQtQE
X-Received: by 2002:a05:620a:3188:b0:949:7572:e76f with SMTP id
 af79cd13be357-949ba9bb204mr594986085a.46.1795192452704; 
 Fri, 20 Nov 2026 08:34:12 -0800 (PST)
X-Received: by 2002:a05:620a:3188:b0:949:7572:e76f with SMTP id
 af79cd13be357-949ba9bb204mr594977985a.46.1795192452125; 
 Fri, 20 Nov 2026 08:34:12 -0800 (PST)
Received: from [192.168.0.4] ([79.127.134.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm149621145e9.14.2026.11.20.08.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 08:34:11 -0800 (PST)
Message-ID: <71fa0d0f-6b0e-49eb-8044-9c4eb30b9f38@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 17:34:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] nc53c710 rewrite
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Keith Monahan <keith@techtravels.org>
References: <20261119233235.32808-1-deller@kernel.org>
 <37f422f9-bb94-4eae-826c-56fed883812c@oss.qualcomm.com>
 <062a8d3b-44a0-4938-8fcb-9f755d92c21a@gmx.de>
 <b9ee3eb0-9a65-42c1-bf6f-078b0f34a5d1@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b9ee3eb0-9a65-42c1-bf6f-078b0f34a5d1@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2NSBTYWx0ZWRfXwjK13SQmNeFB
 ciA7CT6OB0fF4A+c9EbboIQCtHie4TJHYmqLCaV5SnMPDKaw7kgzSd6o9SPcE5xPt9gR2YhfnSi
 BkQNWIn37W98FpmsiqwUJGEMqC74ZY/ARj69z0Vj170uMz0AyWM10R8LRTL4Z8hqT/xP03NJ4f3
 M6CHm7NMYzGnLOXSS5cndmANhYGl2Mvner04o7KiuFkoVtwcyANOrSbiM4FcgleVy3K3M93twjR
 2n99+dS1a2lFUr78BWLgB/wvUWBxEHV+eKEN515At3tAjVv+0SyO2hSz3sGPJ1/mQTtjygl8n+h
 UlwijzfCRFnpH3Oj36drJr7nF6HGnqKzKjUuImaShR7QLT2vHqNwM5jDat4B2DRelah/QWgnfuF
 phEfYyRhoy/GnLPN5MCR1r7KK/jKaGuzBVs7oSXZZaHirgdcwjGfBcCD9kCek3D9pa58VdfkzR6
 btqgHr/PlER80kfOBLA==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b007685 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=dMDxPF1GtEdq01UuaR/ERg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=RzGX5YNrWM4I1bShSZQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 8FuCnYXznBLqaCBL3mn2tt2AdAh7h_h_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2NSBTYWx0ZWRfX5YFdo5W8wnm1
 /7rDdzu03/E6KsCJDadiiLIZDt8JNmKXxfpMhCGCEb27Nzn3FxDkIgE84W/NAT8xVH2iQrFb2gd
 KRr0izMltSKy+2/g9y+sISYXxuw6/50=
X-Proofpoint-GUID: 8FuCnYXznBLqaCBL3mn2tt2AdAh7h_h_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200065
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-20 10:59, Mark Cave-Ayland wrote:
> On 20/11/2026 08:25, Helge Deller wrote:
> 
>> On 11/20/26 00:39, Philippe Mathieu-Daudé wrote:
>>> On 20/11/26 00:32, Helge Deller wrote:
>>>> From: Helge Deller <deller@gmx.de>
>>>>
>>>> This is the third attempt to replace the existing 53c710 driver by
>>>> a new driver based on the code of the lsi53c895a.c.
>>>> Patch #1 is not meant to be reviewed, as it basically just replaces
>>>> the existing driver by a new one.
>>>
>>> "Please do not review, simply accept".
>>
>> Well, I agree, it sounds quite rude, which was not my intention.
>> I basically wanted to say that it's a hard lift-and-shift patch which
>> makes no real sense to try to review, as it is huge and replaces
>> most of the code.
>>>   hw/scsi/ncr53c710.c   | 3042 +++++++++++++++++------------------------
>>>
>>>> Please review.
>>>
>>> .
>>>
>>>> It would be great if this series can be included for qemu v11.2, as 
>>>> the current
>>>> driver does not work stable for any guest OS.
>>>
>>>   11 files changed, 1426 insertions(+), 2215 deletions(-)
>>>
>>> IIUC even v11.1 driver "does not work stable for any guest OS", right?
>>
>> Yes.
>>
>> Helge
> 
> As I mentioned in some of the earlier reviews, I have a lot of sympathy 
> for the submitter here based upon my experience of doing the large 
> rework of the ESP SCSI driver a while back. In particular when working 
> on QEMU as a hobby, it can take much longer to find the time to complete 
> any changes requested during upstream review.
> 
> My take on this is that we want to encourage more people to contribute 
> to QEMU and unless you happen to be an LSI SCSI expert it's almost 
> impossible to review a large rework like this - and this shouldn't be a 
> barrier for contribution. It's clear from Keith and Helge's comments 
> that this series solves real problems that users are currently 
> experiencing with QEMU's HPPA emulation so I think we should aim for a 
> more pragmatic approach:
> 
> - Aim for a basic code review based upon our existing coding standards 
> to check that the device implements a reasonable object model
> 
> - Ask for proof that testing the supported guest OSs (Linux, HP-UX and 
> NetBSD) doesn't trigger a sanitizer abort when built using '--cc=clang' 
> '--cxx=clang++' '--enable-ubsan' '--enable-asan'
> 
> - Mark the device as not being included in the QEMU security boundary
> 
> - Update Kconfig so that the NCR710 device is only built when the HPPA 
> target is selected
> 
> If these criteria are met, and given it only affects the HPPA target, 
> then is there any reason why this series shouldn't be merged?
Sorry if I missed your comment on an earlier series, I was not Cc'ed and
try to not read all qemu-devel@ :)

I understand the hobbyist PoV and respect it, but that would settle a
precedent which I'd rather discuss with other maintainers or during
a community call.

I'll try to split this series using a LLM, since this appears to be
an acceptable use.

