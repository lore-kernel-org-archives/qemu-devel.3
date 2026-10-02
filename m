Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2808CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChDR-0001ZX-2x; Fri, 02 Oct 2026 13:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xChDO-0001Z8-KM
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:38:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xChDM-0005qm-SL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:38:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692H65Hw1481356
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 17:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mTAkuP9aGjrsrpXf8bcP29dY361PC6yD8LN1ZJmWCqo=; b=Y0D76kOpp8Ew6rf8
 zxeql27KgPeD++PPJuCKYtR6mRCVeyRFOhJFLIhMSlwcjrix4VMiXbY+nVkiugKv
 paglIfx5i3v8urZ5JYEDfMpEudWkJe6C7r9LJBcReqD39xDsdM9EXVyzN2EGmHAu
 JK+nTLnlUIoPtBAYxWuwNw7+MctEVneQf5uS7m8ObgeS+qO9H4KhzZuW6v7CZadM
 Cv+L0qCHBo4ZFBENalJv/rZjQfbioyCY1wV0UJQnp9jDKhnnvqW9C7QW9TjxWOdc
 VzXr242NMn1zf+LtwbPdgIlSwflEYyYME0NXb5TUAWOWnjV/yMzKUoyUmLbzxcJ0
 phpZ3A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3d8ntm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 17:38:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e46c120dfso63883285a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790962709; x=1791567509; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mTAkuP9aGjrsrpXf8bcP29dY361PC6yD8LN1ZJmWCqo=;
 b=UmE46ZSkqyn2h6f6VEwuX3Yh6a+ZWVtoL+S5GktI1YfCTO9sb14k+IvaYGT1EVMGsx
 ruYd6WDeDlyCZR3gIMxR/cDHqhD22h+Is9UYOLam5dZ0MHa1h33HVI7mTNdpTMQ7LJ8V
 f8+PaJ8hSKlrZd4A5weWSSiWqFMO7uksZ49ict3iKUeuDjluxsuETFBcFROmsBB7FfAP
 8oAOrdrMOJky9U3XS0Abr+Wdr7RRBvcluZBywFCxDTYpmEaQKoTiHZVRvkdF2dZ2gi5v
 h/Q1F6WvKFKK7psKYGq0gBxR0zAGv5IcvMRtaj8GblnNkc8nAQqE+JAR3bCqrmIgFfmF
 YJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790962709; x=1791567509;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mTAkuP9aGjrsrpXf8bcP29dY361PC6yD8LN1ZJmWCqo=;
 b=SD1UJtjBeN1LccbqJnRuNrzhlnbYVX/y8Aricap4jbxCNsuIEWkBpcMmugOdYj0CEe
 2SxWPOV5SA3KCi8jrihC/YrLZCoNjDeIYuphSylW9uCzUfobQeDruCl5RERClLzTzhX9
 +13BoLCgx6Q7KW2LhOpYOvARZDQ1z2W1cxzyoLOt5PH27Blatym09u8fEdD6pKWO+lEw
 IEhTJvGg5ZARiyZcT2m0ats+/tPPkvLDhQDNlg5hyr002EdutjkrzNdpZNlzuTxFM9Vt
 gpOxPuKYUDaiACS2w+he8q3buqmMKK+pghrHYpX5DTnCoqonuCDRjSmnaD1Iv/NROflH
 Ndmw==
X-Gm-Message-State: AFuF++k19uXY6FEFNB621gtKTCJkjXfN6MyvpNiX0ikth6rSEF7O3WnN
 bg8EIFlDeQf/8YWJJCWDaXbVHf8edBeJBLMyw/421brpsFvlkS3oHs72eVjWpf00fTkDN0OgoPv
 ocnmPe3WEyaW4x4B+RLMYCLY+iFBHviMBjkMGJ3/er3jnQFAw6PQpO2qRNQ==
X-Gm-Gg: AYBFou3uK+cdqGJqNHkwgASqJN/ybQZPvUOtbbceF3XAO/m9VCFIYjUu5/eo5O1g9+U
 Wh0Iywg6dGS1kJ2uWjQI3o0GpX3IyamE8MCgcABzDdmxuZ+5f6q0/NP8Gr7XFiOnAxeE7WY2Pg1
 9etxqoQ6Ntxv0eCdmmbG9SUtv7rxZ5zbFP903lCMeZ/69IbPUPjygxKLPo5qhZJPFeir/RLd8Jy
 EZzaHqZaszLR2eUJYiJBVmoPAvkffIy1v81D/iPVBaVLPlu5yhVZ/5zO3H6H4pvT95WkiO4NqVW
 X59g1Ar3Ux1GtAJWZjbfu5BRbH3hRtkKEbpvQtvwRqNtZbNVWjiauzKC8/eEwsJRxChwmyRFEy2
 Y/OT8jWBezXPRSPbHIXJbBIoT6pLQjkwCj/nNVXdiFAqfymupS+aXJGRjAf/UC9IF
X-Received: by 2002:a05:620a:28cf:b0:93c:83ab:c882 with SMTP id
 af79cd13be357-93e5105b050mr8340285a.37.1790962709004; 
 Fri, 02 Oct 2026 10:38:29 -0700 (PDT)
X-Received: by 2002:a05:620a:28cf:b0:93c:83ab:c882 with SMTP id
 af79cd13be357-93e5105b050mr8334285a.37.1790962708460; 
 Fri, 02 Oct 2026 10:38:28 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e4ce407b0sm114605966b.39.2026.10.02.10.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 10:38:27 -0700 (PDT)
Message-ID: <6249db1b-50ba-4676-8c32-04c24577e950@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 12:38:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Hexagon: ll/sc fixes, emit TCG barriers, TLB locks
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
 <CAJ+KCYPoCyR+2k=oN6Dh0-Kyi4sJD3SAghm7bzvitJAFk1gtmA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYPoCyR+2k=oN6Dh0-Kyi4sJD3SAghm7bzvitJAFk1gtmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: auC3ugAISa4Xg6lNgqEaHOwXeg3W45-o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX3hQOrJRyX2C+
 RPi75UmF1GT1YDj72/3fKhb3AWf4eX4eR5/Nl5BlGfhGcksc5awqmpgHpL6dWHRuccXlCg6xOoi
 B6Y6ZEfiINk4QvyDLqgpq0J+5L4oZA0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX5XgJ79XiTaU9
 AXEIdgZXk1iK8ikYqBfkapsZYi/uQfYXSX6Z0pR3Tbd4mx01Hm30dyqK+sENfvc+WH/jaAlllMl
 JyZp+9wF0Ib1yvv8gN6bvH39DnDuXpZ1vnDcROy0sWt5XshukQEJ/XHftRoUpeIq704CUAOIMNN
 s0OszT/RFPXGpaV9i1U4aj93HgSjS4Q3gn/OgKp30kZgOIodRsPddQ/VPNqB6p0cNAt/kQaQSLB
 hUsiK8VA88B+DsZbEpamUM48klFxVNIs/kGcV7UO/oIy60pK6D+9QNd+MLFqDUTpJ9Y/26vPeze
 lBsqQYdh83ZCK2r/XzCHizYiFDVsVJcmORoFiX3BSI3QtEbprPo4q5TkV3KiCIh1eqvLEi2HTx6
 tPnxp0iAnE4HWsbqEFl9TQRypkGJvKoV6SPpkCiQfqLTfZ8nfSxo38FHK9bxOdIEgcjnA111xC/
 FzpxoOGEwnEYjPkn9+g==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6abfec16 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=buF5m6E0Ba73rGJ1eEIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: auC3ugAISa4Xg6lNgqEaHOwXeg3W45-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020070
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


On 10/2/2026 12:29 PM, Marco Liebel wrote:
> On Sat, Sep 26, 2026 at 9:43 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> While preparing to enable MTTCG, audits and testing revealed gaps and
>> bugs in our implementation.
>>
> Which tests revealed those gaps/bugs?

Mostly the qemu-hexagon-testing test cases but also h2.  This commit 
series is necessary-but-not-sufficient to pass those, so we'll enable 
them after we enable some other features too.


> Commits LGTM

Can you add an official R-b that will get picked up by tools like b4?  
Just on the cover letter is fine, if it applies to all of the patches in 
the series.


