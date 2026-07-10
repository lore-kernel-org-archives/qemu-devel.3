Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8736CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBUf-0005F7-Jn; Fri, 10 Jul 2026 09:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiBUe-0005Ez-Eh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:42:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiBUa-0007TQ-V2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:42:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AD6YmH871644
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nYOBHy+hXnz2zuGmAy6xy+rqO0/eZcu/WA1biZ/JNiA=; b=dFyFRV05PWdXAtP9
 O3gB+2nUyYSRDn6djuW6rLEuOwx6wxBYnF5ay/367XyySVsF3peCRvCtMgVeDdLJ
 9bntnZPXB14Ny9Sl4aVPlAfvUizmAxdwYm489/LdpMmvWfjgkjIolVqwlTPGUACG
 wUjhTxt/Eu3eYFSex4SxLiUVJmTknZMh8jI0Ae5dJAwIWOV5XFPuMsl/0exIgp0g
 +lN2ppWZxIVxy9CqTxloady/dmQrcjt01bIuCrrdsNGoHww4lLStnE9Q0qaZFUPs
 pwzcRPa6wFAaWBqq2oLeyjVKTqfWdvVhvvOHuk34jpF48JfJHQiWiIlIohFbZS55
 4PSpAw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faxyg8nnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:42:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d137a68so20980101cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783690931; x=1784295731; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nYOBHy+hXnz2zuGmAy6xy+rqO0/eZcu/WA1biZ/JNiA=;
 b=Zu3VLuyoHMrgIKpUlsrBn+YWACGApOK/MW6UKVjG8tBGRt+Wd01GD64+yaIXmozR5y
 HI9itbYdDHETYVSB7fvVmR2/dk5+V2SMmjE9AvljyDGOZ03dZp058BWyAHHnYBBY++m6
 HSOwUG/rXdw3HGuk5zz8iDbmcUTp2Z6745QDFqyUqMb+Q3nj24TdaraspqbxlN5eKaQ+
 0YCHSGCwkCCk40trC6XJ7Oj7Rjaw4KA4kYblLz/jI9sJIW4VaqRYpc12ds/NPphY39tl
 kYV+NjOXAkC6XSn+bY3xhiGsQTgCGsDTTpkdycCdbB77j4S1Pwk6NEXCDLjrCSeKLkdb
 4Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690931; x=1784295731;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nYOBHy+hXnz2zuGmAy6xy+rqO0/eZcu/WA1biZ/JNiA=;
 b=LqxPOJ47rlMDgGc52XLMK7vP1+HkfJZDgmX5Xr9nqfnwxfYNh2Bb177mqkg5QBfYPy
 f5m3K5WytiF5Xq1d5dnD/tgXJfx/ET9wcgIEi8XZYxw61igQLyfOPfxamtujIam1iZvn
 t61rnh/To5Kqo/st1tBz4iGPpHYy5tWYdwvD0ZOiWfbX/sD7C5bO9OzpJL+3AGRbq5a/
 I6PAyo4uvyfVlTDorRxpplqialJmcc5H24ltqWpalhki5UE861R43jZ/wxqOxWbrMzAp
 LRMYYxyswX3iGiUfytvDmHtFrijIfmWRC9WjWjm0Z0++IaNgv2qdzVTXdIXginlhYY+1
 585Q==
X-Gm-Message-State: AOJu0YzGYjCqGG6jxLRPLI/jGGiDpI0BmRGKJcZNrwdu5akHmH6a+CPh
 ids7Sp/k9eZ7vyTVJ9kUWDn9dTMyHeZve+PqRcNqTCt+V83LQXSR/KaKbOKrFwgUNalwuzUhgYw
 2zrNQ7GbNHdVt9iefTPzQXBeOeTzUoQdzOlQ73LGL/pCBGpEJu80cVMLsf/CD4jvZSg==
X-Gm-Gg: AfdE7clp9F+nzrC81ONOn2f5Oy453Pj9IHSoyk3JFcY3nZqx/iQzGnMVJlCVEEQaUji
 6tt0qITMX9PW/cuvbFQPftjE7dCKz5GqbVBndbOdtzUCB+nzpT+1P6zMasM41Nu2jVeYyANFYEn
 FPm6hEs9snjLZXeqfXHQzjjj8BzLe71oMJrJoeNeXVVA8hHL7uwVV/5xqCX5EjdZDOsEhQxGfYz
 PEOUIPwy7uDk9tXvcj7zX8hpsCNTDthgkJ2RdEfkhhAKzAs4jAGRadZIV8mYsk3QW5FoEFNpTfU
 dNVio3VN+2FaupzdD17cGToV7JIDtfstp07dAkYs1PARfrwfvchhreBahavobj2R7qLVQkVbh37
 Ev1CB3Q3aTzl2MYAahqurL05teFn3UVhl028fUDsRF88vCO9zuxjgs/wHSMVoEw==
X-Received: by 2002:ac8:5fcd:0:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-51c8b3a051fmr119454531cf.5.1783690930853; 
 Fri, 10 Jul 2026 06:42:10 -0700 (PDT)
X-Received: by 2002:ac8:5fcd:0:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-51c8b3a051fmr119454361cf.5.1783690930499; 
 Fri, 10 Jul 2026 06:42:10 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4f09f89sm61750055e9.10.2026.07.10.06.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 06:42:09 -0700 (PDT)
Message-ID: <f76c3796-faea-4396-a2b6-cff322738a2d@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:42:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: fix querying available machines
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 th.huth+qemu@posteo.eu
Cc: qemu-devel@nongnu.org, berrange@redhat.com, philmd@mailo.com,
 ganeshredcobra@gmail.com
References: <20260710090317.498350-1-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710090317.498350-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RxfG8G4-oRTPvKTc_xtcirmS70mx3EUc
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a50f6b3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=6R7veym_AAAA:8 a=EUspDBNiAAAA:8 a=K1ir9hTErLnS5tp-OiMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNSBTYWx0ZWRfX8Rmhvy030bU/
 qMeZccislRZFg0QkFjCI1eoETvoa/9mKoMs2qDenN771+gm0zEog+l2WL2Bm3GR0EOYR3WtidWB
 wcMCbtw9BmLn1O0RX6OD+vZzztCubFE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNSBTYWx0ZWRfXzC3eH0wOH96s
 vZiQ/SUoUtqQG/cIAhyqnSSBaBJJ/sCfPU+Ygdnx7S6JxVR2QeUq3Hp+1BcSIfXwChgiklA9CIK
 XlHzDNh1StJCAYqP0fyJhXt76AElhpN9ENivjXJEA7aeM32wA/vLZQL6+OAbSnlAqMJH4qp/IvS
 2Z6czCYglQaDLd2X0ZEPJZDWE4T1Tog/26KYtWbQAS2R0pghnvXI16bsaM3LRvEn0jr72TnC0Fk
 o8jefwgYGMaZNc3lNR3YVOnnYcR/CQSVNVBvx0l+3O8/gfOZsSgOpFdBGVY0xLPzXup9UWwKAEF
 JvkuyY0isa1OnwzsGXi3hcYDcPHm6MscLzSvXttTlzlB7saQq9DIKiAPbKTpY7ZiNLyHtUc2tjb
 kRK//1kzvV2lIVti7j06YLsfV6sOLXtiuQ5lbZLUVrbzVJ8DTUoKoT8qrUOJ5IUijt6jl3IdqVb
 XR1lTY94XdT/IiZqqSw==
X-Proofpoint-GUID: RxfG8G4-oRTPvKTc_xtcirmS70mx3EUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100135
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

On 10/7/26 11:03, Vladimir Sementsov-Ogievskiy wrote:
> Aliases are not handled, and that's why tests used them
> are skipped, like this:
> 
>      PYTHONPATH=python:tests/functional \
>      QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 \
>      MESON_BUILD_ROOT=$PWD/build \
>      ./build/pyvenv/bin/python3 tests/functional/x86_64/test_hotplug_blk.py
> 
> TAP version 13
> ok 1 test_hotplug_blk.HotPlugBlk.test # SKIP no support for machine q35
> 1..1
> 
> Fixes: 0e7aa78b0bee50 ("tests/functional: use QMP to query available machines")
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/functional/qemu_test/testcase.py | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

