Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAD0CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwlt-0005qI-4p; Tue, 23 Jun 2026 04:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwlq-0005pd-Ed
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:46:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwlo-000670-Lb
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:46:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6ck8E3564056
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e0ZwpbBZi9SMFTLfIQisx3Uop807q88DhfjWJMo6/Og=; b=GRlx3vmPe8u7AWnc
 dhmgwkgSeKQRnsCHrKNe+y5AD89DknjU0Io3jtkVfndPRX+8I/vmDXW3imOJ1sIc
 nMOBwga3YHs1KzqvIKZb0NCiumPAf9f+wDzqu8IOSYIpZfYOmKkrv+lK6k2XSNYb
 jqdaa8qhB/K3eqV3NVoT8uEwxPXZJHTVVKp8vYJxlrROPg459AJoWMxt9tvF8Ipo
 5qXpxACQt9N0OIh8xYDBxwHxMId1z31MPrRdA1RFqUHG9Jv+faVkk3f5Vx8J+uFh
 pmLth98Ch2pvfLM6+XzUZ4lBWKDKnN6lBi80Hk9ItdFSF5/zCIB+X3ffwSzvkrAn
 uOR7MQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n43tqh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:46:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-921634eebdbso716654785a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782204370; x=1782809170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e0ZwpbBZi9SMFTLfIQisx3Uop807q88DhfjWJMo6/Og=;
 b=gT5W/aNoJafKepWKxl9NCbV7T2VJ84aAhn8m0qUswYzLjVP/6HqFMdrXRrXf6NEJJ6
 xRJx9x+09SmnfxcefnptxU3QFChHSEU+fYIObbxW1Zpj4ZO8VyvqTGUgglY1fwtHd05e
 FECCTsSzYxG31mXq3qCwvNT4fo1GmJh8mqTz0YeC/ZdGoAbx5oHWYzDnACC9gz6jKiJt
 JUnCPnWZIFVhkjXFT2hP9KlYKBnbwW0KRKUOd7Td+9HfrVbhL2SXZsydyQKfGYIxMGJ/
 V8XRBfUdbJHsv8+vU6k34iobEmx3Sze9dpNdwhqW2b7CaVMVKYF542LWzdg316N5rFOB
 z4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204370; x=1782809170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e0ZwpbBZi9SMFTLfIQisx3Uop807q88DhfjWJMo6/Og=;
 b=LG8AuyG1XDVituYW2PFNrGtr9Fz+iS7UxUSNi0W4fXxIHf0EmP3n1UeWtQhEyn1492
 Kr3IFef7JixHfsaNQv8uOIEwbu3WQO+zvwb3OG/i1n4X3C80ggu1O1qhrePkfrB50mye
 V9yXtyyhqBQEjAWo9Y/1UxO+4CpaIRCAQPXvUfDJKOFEVpeWN7rXrViOrnWTW/FHubc5
 cSvPxGD0X5g2XkQclEmMPrD29to67pFl8ekYiHMf608Vc5lqoUEvFYMFer3eVtdyZnDU
 xxQd/TKTY1uwEWZZlFw8hy4Kyqcn6pthLlDkyp1MupJgWCdiKLo0UiilGsNdiHaOjqPC
 BWIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9V4nQMouQeAtcc56JT/zl60cxLqYWAAZqt0mNK5rduPCyWj5lmQARB+9r5BqdChiXHSX57va7HhnJ2@nongnu.org
X-Gm-Message-State: AOJu0YxF1SaScfJ+6/cN5RhAXzJAZIReMviQiFZK4S/4GfubfdnltX4F
 2+hJdnYMieKY/H1E73UFdTTw5BujASy6mBiW2+i5BHjDp0wXnETkm+7aIKqeIetl1mdk87UnESR
 34ozzpGO+mceF/4lYEoQ3B87eK94xx6k3e4oIAEnJMki8h4esj7sf/pUijQ==
X-Gm-Gg: AfdE7clHjNI/ChMfITturuqmmo58CCjR6dJzH4xbtg67r20s3pLc2I6w78QvyGVK6+N
 O/UUmTyt58SQ+VodB4N79ydurNSXcVeFlJirQCbwPmiJ7/dzONh2nVO8NrPg0F36qveJBD3Y8RZ
 dvFNeOdyQKI3nV1hQqI4vEVLv7at7XBhbU+ve9iYb3BPs4ucJdiDpg0R+GdGKB4NlUw8GyQ0uLc
 LYOSBi23iGKOGVI1XUusAyEIafim78tcYMDNU05fuLd+EP3qWmqjNSMjbNi8S7wS1VpPBYf2Pv8
 sefol3bs3ci7NJMquf2BJm6vl8SoeseXhWf049jzlzodSDTpF9LsqjUg7c0J3HUqlfjC/4oaNaK
 0dvyc5RreT3kRNPZoqaFBLLjAtgOG3HVNBAcYktRx7TUGPHjze34C0rvwc3nWdQ==
X-Received: by 2002:a05:620a:2b9b:b0:915:a217:a96a with SMTP id
 af79cd13be357-921d3da92eamr2455883285a.53.1782204370093; 
 Tue, 23 Jun 2026 01:46:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2b9b:b0:915:a217:a96a with SMTP id
 af79cd13be357-921d3da92eamr2455879485a.53.1782204369585; 
 Tue, 23 Jun 2026 01:46:09 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c5e998decsm473182666b.22.2026.06.23.01.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:46:08 -0700 (PDT)
Message-ID: <274d0c00-749c-48be-be65-86bda3fcad54@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] igb: Implement Transmit Rate Limiting (TRL)
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
 <033dc4c3-6398-49c0-aaec-487927cd549c@oss.qualcomm.com>
 <CAAdrzjvZvikgz-pC0W+n5W-DFn73pqoToqv32A25or77YzCi5A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAAdrzjvZvikgz-pC0W+n5W-DFn73pqoToqv32A25or77YzCi5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfX0XO/Y4Oj4RhF
 XFhr1upID1u/sRPzy18A2ERucMPk3yWHDVfNxGm2xpHf8PGqJz9pjf54cb11hz0DuN/J51iESGp
 nSwc+8jV+rSuqCqEnVearcEYnsdlVbo=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a3a47d2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=ID6ng7r3AAAA:8 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8
 a=z72Nt26p6EMQDsdTYkUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-ORIG-GUID: G6KIvEXZgOZG4CL3Imfl-1A0QbD5hQbu
X-Proofpoint-GUID: G6KIvEXZgOZG4CL3Imfl-1A0QbD5hQbu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfX2k1tWICBNbOa
 dW6QyAoVkT1r8XNrJ5fMXzOxdnKnZP/Z8kvO/rzuYg8he8fhQ52kvs4fAkxF1dvbcjlG1YRagMp
 2pIZCFuVw/gdAg0q2133otIA3KAlusu0/nWSwNRT4ZIwMyZJ8+lTUOVSZUS3rURLjDhThDXnMpS
 Wsacnla2K+mfvccA6aFq4RxbQbrvEiwROrL86YSvCNHuFt7c19qnnEq76/0fuTV8hpRaPEOC3TU
 lCLyTyshFFHI/beHMAF+DqxSi+rk/4652Y509a5gJL9uMow8ICmoImjTU44rFiiJB1bE/x5pM8s
 52Kt6lpnWN76oKJYhZR+be78u3QH3VEg7SNVq3CyqByegFpEv9+pVScCCZX+pMirA7XJhWD8YO+
 2YLHvt28cdduaiYIo+BX8JPYb3qN2Zs+Yo68kEt2hIkRYpBIFOLu2z1/2UAMsj/XTVO4O4Hjia9
 Qsn/KPctbxa+8/pNYlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 23/6/26 00:09, Josh Hilke wrote:
> No need to review again unless you want to. The updates in v7 are just
> responses to Akihiko's comments on v6. The changes are pretty minor at
> this point.

OK, then for "pretty minor changes" please carry the reviewer tags from
previous series, that save us time, otherwise we have to review again.

See 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review:

   When reviewing a large series, a reviewer can reply to some of the
   patches with a Reviewed-by tag, stating that they are happy with that
   patch in isolation (sometimes conditional on minor cleanup, like
   fixing whitespace, that doesn’t affect code content). You should then
   update those commit messages by hand to include the Reviewed-by tag,
   so that in the next revision, reviewers can spot which patches were
   already clean from the previous round. Conversely, if you
   significantly modify a patch that was previously reviewed, remove the
   reviewed-by tag out of the commit message, as well as listing the
   changes from the previous version, to make it easier to focus a
   reviewer’s attention to your changes.

> 
> On Mon, Jun 22, 2026 at 4:50 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Hi Josh,
>>
>> On 22/6/26 21:05, Josh Hilke wrote:
>>> This is v7 of a patch series implementing the Transmit Rate Limiter (TRL) feature for
>>> the Intel 82576 (igb) network device emulation in QEMU.
>>>
>>> v6: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg04562.html
>>>
>>> Changelog:
>>>
>>> v7:
>>>     - Inline igb_trl_disable() since it's only needed in one location,
>>>       igb_core_set_link_status().
>>>     - Fix indentation in QTest.
>>>     - Don't set PCI_MSIX_ENTRY_CTRL_MASKBIT when clearing pending
>>>       interrupts in Qtest.
>>>     - Fold calculations igb_trl_calculate_delay() to simplify logic.
>>
>> I already reviewed some of these in your v4, should I review
>> the patches again?
>>
>>>
>>> Signed-off-by: Josh Hilke <jrhilke@google.com>
>>> ---
>>> Josh Hilke (7):
>>>         igb: Define TRL registers and core state
>>>         igb: Add VMState support for TRL state
>>>         igb: Implement TRL register write and configuration
>>>         igb: Refactor TX path to return processed byte count
>>>         igb: Implement TRL throttling and timer resumption
>>>         igb: Add QTest for Transmit Rate Limiter register multiplexing
>>>         igb: Add QTest for Transmit Rate Limiter traffic throttling
>>>
>>>    hw/net/igb.c           |  43 +++++++++++
>>>    hw/net/igb_common.h    |   1 +
>>>    hw/net/igb_core.c      | 142 ++++++++++++++++++++++++++++++++--
>>>    hw/net/igb_core.h      |  12 +++
>>>    hw/net/igb_regs.h      |   5 ++
>>>    tests/qtest/igb-test.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>    6 files changed, 404 insertions(+), 5 deletions(-)
>>> ---
>>> base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
>>> change-id: 20260608-igb-trl-19be198da6f2
>>>
>>> Best regards,
>>


