Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80EBC44520
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 02:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm0Wq-0001k7-Mp; Mon, 20 Jul 2026 22:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wm0Wp-0001jj-31
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 22:48:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wm0Wm-00078N-Uj
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 22:48:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KND11u4022384
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 02:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OZeBZUwXzR5+7WZ+n2zbHpJ92dW7xZA7NFSGTVSKMbg=; b=E018oHv4DasAEWbw
 wKqehulQ6QyzFXvh3EvqhSIKfcdqaDYcuemCSi8OUnKnDLLbCbDE9WHkAat7XMfk
 Jt1NVh7HG3J+cwcqhDgQUYL9qhdbDxK4u2CMTgmsGhHFeLmb4vAaIupaIPIVz+Ew
 ACJU6yV31rIQvpRWWIwbk0bkkK0LUdHu6EyPkYKyGBsXL6wQgdXCn/zuWlCy9qaS
 oZae2YcsJJ8BeMXOjJDLqlR+Kz8K23IC4ycz7kQPi08yDxWOYMPIXxUgAPeIF3OE
 zRbsBMwnekAMnBtHzro2vz+slqqz5TmWRBYx+5KottmcPrV86z83GNusaZcesWG9
 /838zA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhk2fbffm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 02:48:14 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so2928955a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784602093; x=1785206893; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OZeBZUwXzR5+7WZ+n2zbHpJ92dW7xZA7NFSGTVSKMbg=;
 b=TxbbxC++19vrgiuadUPcnRNMtTDQsD/o+b20bHSH4Kx/G87oiXrrwz1Et25F62llz2
 HHOKDhKxRvZtbHzQ1/ad6eStZjfprmKPveaycH/I/DXfCNB0QyFcPSx/jcNG3fnNLIm4
 HDt0UgISmhFxZNqYSps0C4C5Dm9sDcBomYb2g6OPRn0pNiWf+JKzib3R8MielwiZmW5K
 mTHd+STED0YQxoHS77OJ1ksb78UIoWYZ1vEOBaX7whkabfVCCLmidZ0ds0MWkl4o6+Yk
 Ypyg46MndKO44unpUyrcyZ0Pv0hQx0bewFmOnVPXVYebmniwK8OAF8m+9SfmBq8Hma8g
 phLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784602093; x=1785206893;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OZeBZUwXzR5+7WZ+n2zbHpJ92dW7xZA7NFSGTVSKMbg=;
 b=hIT2omF4grOBnxQTL+l7ALLyk++Q3PL2NVNQsgWPWwp0Wkx8EAw3Ixn6pPGkiyjbnS
 ZBnmZDSf0bvSZLYaaii1g8UBEE5CcgNzrtUkvnaObS9VpLVbETUZNW8LeSUNSDObT6kh
 LwHb3GbIiZmYwNnQqTnwMGKML/Yo8Ba0Fzx3SiOIBbYY8GlLCcnHv1Af8Q/ecdsr7k28
 ZVJExEpafHFDiPD9dfsbCwZpX6s5MLFn7Q7HcnT28fyB5guw07XPGr64a0nHjsQbpGDn
 K+6Rvjey7Oj4P6sHNeZNk+J9rUi4MFgSY6e5TCrUYYGC84YtR3oKsYSX6/sr8Wt3mmbP
 LBjw==
X-Gm-Message-State: AOJu0YwzHnMJdw6Mgxs37Cz6R4ycAbOvxKxcf3OQxVbYBIDAMFn7MdQK
 uv4umJPj6CQK8eQcg0SGMJYktMCIA7BJ6wSUIa9L3Y2mBrgXj98X6grG/xckZjQ+hVA0dGN5BcT
 R/XVorx12Mx2LL44K9uZ2YCMSBsckFTdzE1zjs6mE9T/XbU/fKlgB6B9DNA==
X-Gm-Gg: AfdE7cmwwSm1wiedb05LXEuI/48RDTZnUbFddTx5bhfPUXXVucK+Mk8d9/+WFC8iLZx
 rG/2zWHu7A8fhbSyGxxUYX1jxo73LGJMFe2kWIbNAUe6ROVU214QYIGWC44PID1MRwKlPyHZxJz
 Rg03qFw7ok8waDSgdhFsWudGSYpjDWPG3LXlT8UQ+srciyJo4BAsushrlrds++eT5wO0ilMDHy4
 7StZd2Ta4tRiiohLiY4wXTzmTCeukveNJb7AG3CG8ApuCVZbiV8t47XPlJ1RR0qcn3fHL1CdJt8
 4DAz6uUF4sCmFSI/x9cUdGrlepwGcV1d680aZLJ7ngYkA+yZ6+oZynAIiwWcWC9WDmgeeY0rEfB
 5huK6/p4l/6j7ZxeW0j1bAZOFDrn8gv7eyrEnjBuV+PcTzmTO5AuJYwWJi9FEUy4rfrn0
X-Received: by 2002:a05:6a20:7493:b0:3c0:9c19:65b1 with SMTP id
 adf61e73a8af0-3c3ada6141emr19416076637.73.1784602093438; 
 Mon, 20 Jul 2026 19:48:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:7493:b0:3c0:9c19:65b1 with SMTP id
 adf61e73a8af0-3c3ada6141emr19416055637.73.1784602093015; 
 Mon, 20 Jul 2026 19:48:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20cfe3sm44156291eec.30.2026.07.20.19.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 19:48:11 -0700 (PDT)
Message-ID: <089649f0-b677-4c1a-a42b-eb9853f4fc7a@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 19:48:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] build: fix sparc64 host
To: Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
 <20260720171031.259f590e@shazbot.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260720171031.259f590e@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: J7IUECk1WLcB6lH4YnKASHd3jTyYfs5Z
X-Authority-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=6a5eddee cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=9qUTvQc-AAAA:8 a=EUspDBNiAAAA:8 a=FXnhwHm46DDoLNdrRRAA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDAyNCBTYWx0ZWRfX+TfGRkS2Nroz
 qAMC3vP9be4x7g6nhg81XflUtxiHo45QcCEjW3y386Vw9GcMzC16A+BZEHgYTmoaGbfJ3Wy7XYU
 EeDcEplXKESZcj4yyH04X5lGqRLLtSg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDAyNCBTYWx0ZWRfX+okjn6ryHovQ
 y1sRTRieumBUscW4VL5MJpbU+9gOq2LVmlBUba7WEcixPPzFpu1PN6AvVHzyxT1hbfsOki0gA1t
 ecLmhfclg1JBGep2pePWPkssn53iGnbQzVSt3Xq39tDbtKfzltK0q7doiGxd6CTo0FwZ9qH+k+l
 v2JAjuiIQJE9poHt58JeHH5udRzlULXzvMpkagKu1E5vIwmPh8VZ71xwQ/G1lTZCtWD4DWamiE8
 imdaccqvsQd5jmz/nBVIVpbumNRww/YmzmPKgp8awLCkdNLMMQiNb1Ah0rqaH57Vp8N53/qBTTB
 UzgVe6osM/ozdBV7A+MaD8D5VScitsRDWzqzvhhTAEO+RqFEfamb8ztXkDhqV92DavMnv45pA+V
 mABGKlqxxB4bHB7cKLFACZ+lvZH5m3wobmrVj+wNYOSbLrJDMkgmHwp0Qv0ZxGTJFK6RDryqBQT
 BnbdWcW4bPkKCFF5I1g==
X-Proofpoint-GUID: J7IUECk1WLcB6lH4YnKASHd3jTyYfs5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210024
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/20/2026 4:10 PM, Alex Williamson wrote:
> On Mon, 20 Jul 2026 22:17:13 +0000
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> 
>> It was reported that build on sparc64 host is currently broken, due to inclusion
>> of asm/kvm.h, which is not present on this platform:
>> https://lore.kernel.org/qemu-devel/c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru/
> 
> Isn't is sufficient just to remove the stale <linux/kvm.h> include?
> 
> I don't know of a case that fails, platforms that support vfio might
> actually be a sub-set of those that support KVM, but being dependent on
> a KVM supported host has no technical basis.  KVM and VFIO are
> independent features where neither should have a hard dependency on the
> other.  Thanks,
>

It's related to a recent change that was made to get rid of CONFIG_KVM
in the file to deduplicate hw/vfio/listener.c between targets. So it's
now unconditionally included, thus the regression.

Limit inclusion from the build system is the right way to deal with
this, thus CONFIG_VFIO, thus why we need to do something to control
through Kconfig.

> Alex
> 
>> Problem is that we assumed in Kconfig that VFIO is available for all linux
>> hosts, which is wrong. It is limited to linux hosts having kvm support.
>> Since we already have a meson.build section identifying those hosts, just define
>> a new CONFIG_KVM_HOST in host configuration.
>>
>> Pierrick Bouvier (2):
>>   meson.build: define CONFIG_KVM_HOST
>>   hw/vfio: restrict to kvm hosts
>>
>>  Kconfig.host    | 3 +++
>>  hw/vfio/Kconfig | 8 ++++----
>>  meson.build     | 4 ++++
>>  3 files changed, 11 insertions(+), 4 deletions(-)
>>
> 


