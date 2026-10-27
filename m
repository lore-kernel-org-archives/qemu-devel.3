Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085A606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nyPhHnp5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TXnfS6RD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLknU-0001ij-Jw; Tue, 27 Oct 2026 13:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLknS-0001ia-4I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:17:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLknQ-0006DJ-26
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:17:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RH039e3309917
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 17:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pzF9dnw0w4Qi3MgCIieMv8FrRUrKeSRhi0J2wl7xDvQ=; b=nyPhHnp5l143S2/+
 jNCETD3H4aEk6/5wRNKydaopzhI3OGWGxQhTWpT02kvwPSai7vkJ5V5pxTROq11c
 +bvGrk/gj50zoN+sIrNUZ5BMLVxHNSxdqZURxUbNBrkRVIGpfR24Z51AXM0DhPQ1
 lH3AScfBWunCNGqpQNX+ao3+ofQ0d6i62Jr8zMw0QRm+/65IudJv86prv7iSwT9L
 LbxotvKnUnIjm61kBNz1VmevCi+YZUgGK4ALY5LcpfSgM1Dfl1W47iZsxD1YAebq
 24RbkR3xIT/0e9cIGtIo+7/sDYV8S76RbdTrA0Y8zzbLethC2k27fwR+N7n/dcJ1
 yxRbpA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtbj69-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 17:17:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7c0f07b4e81so4761137.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793121428; x=1793726228; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pzF9dnw0w4Qi3MgCIieMv8FrRUrKeSRhi0J2wl7xDvQ=;
 b=TXnfS6RDZwIQSWv3/Dz+a/J+QPA9Gy8J0k+MkN2fKmWnSwFA4bng/ibbxE/6LKowr3
 8pglMrfDIIeJmmamYlS0ASKSyyH6ty8VG03oAHTWX7V/tKe7kJnCGTW54WCZC1TwwXgb
 8IVswJ1Tjkl+lWXLqOIimQIB4PjtdXPd8Up4UnGwF6DKamr1BxIjt6m2a2hydDEfuQmx
 1RU+kwydJ+wyuE+SuazUP9hjOBEwTL3cGG1u17MJvIdFnNsPDzHIshT/W4UQ4yHYrOJt
 aGxzp6PH8XJYauEQVzr1PYDm+tRsWbKU6xAg2OCo+uYNzMP0cn+O9bMOeSCaPK79aoFn
 F43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793121428; x=1793726228;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pzF9dnw0w4Qi3MgCIieMv8FrRUrKeSRhi0J2wl7xDvQ=;
 b=WSYPm64tGayvYdtiTMHhy/iDwL90RSEuDuZ+B4ter69A86pmh1dJQg0XEwWB1EFy1J
 5skHJU49cstvunqFZyUSK+JSGLyyBhm23hkkISSYFVG6ykOMM9v2SSZcXZqrU+KoRVD+
 wK10LUOmTinI0U+8TBLI9Ky/LqZXaukXTKX+pAexHtPnyIPwDwKLifQ/hG1bMfch7Y9k
 I8PmbCMlxYIMxEqL7D9k+xCBk1YNna3hJV3sPExeALEb8drvvtWMf6hG9TN84S4nrsDw
 EcjyRNgIKp9R2fKkraeyJ42m7x0FbQM3LwXmEMkLcBjtS/Bq3XuxoYAqVOWCTD4O2FVR
 q2Bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLYTwxj/A56U9FnZDOu5ftlflORjFkRiW2u8EgKUXIWW9/fnmY/ZzEehumP960HvrLeVodfdqhD+Mx@nongnu.org
X-Gm-Message-State: AFq9FYLD4CaCuoY/WaXy77z0AHnTk6iM0Zx9cN3NB/BcoOXAzHM+JAOF
 9UmLukMRdwTISzzF6sEk094AHVahXRY+uz6eH5S+LxUC9mokF6qBGe4uTyNRhS/eo9SZbM7HT1n
 og0B8lzDfGWs0/qDRfNEr5Xi0BtPfIRCBz4qze0Yhn58x8uEFNNVzGOb1Zg==
X-Gm-Gg: AYBFou1WcmOPr2UZkkS1hB4Sf/uQAxOImlVqow4ZGYQAXMfafEZFlkp0qN3o4F1HdYF
 EU2826YtdeIn1DBfYogIcSP82RpoJMfMWdib14PegS5rcVjXtYiV8rOoDQzdgrJ1gciwrAQ0PhA
 dDfaMWHcZrOJ2rJVHg7eyIeUOCXgAf1uyNwn6U8H70DoF3PkDXVYq6QaAWdJi6y0OLD71RLKTlc
 5wBoOcRs214OrO/MHt1Ve0LgZOTDjyr1IPNLj6oKCtxdTxzrl/8tHmWGP29cdHxFxM1eQxVvI4r
 HZ9UXFNSbw8eo9a2ZWoo+H6UfUpmgeqXkEoQqyt1de9lbEiU3/5IgrCVzKmx6yxqIcTGJrkzAuO
 CUyCX0aSzzUI0WYwqQQQ=
X-Received: by 2002:a05:6102:441a:b0:79c:99ea:2c9a with SMTP id
 ada2fe7eead31-7ce5ccde202mr3601079137.11.1793121428274; 
 Tue, 27 Oct 2026 10:17:08 -0700 (PDT)
X-Received: by 2002:a05:6102:441a:b0:79c:99ea:2c9a with SMTP id
 ada2fe7eead31-7ce5ccde202mr3601004137.11.1793121427550; 
 Tue, 27 Oct 2026 10:17:07 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92eb9ab6asm3119255e9.0.2026.10.27.10.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 10:17:06 -0700 (PDT)
Message-ID: <e341734d-a96a-40a4-a54c-c0539c27c4e6@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 18:17:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with PyPI when working offline
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
References: <6e28a268-6ec0-4f83-8d31-76c48634c2b0@linaro.org>
 <9cf3e30b-b2fe-4507-ac57-b437dca14721@redhat.com>
 <eeac5fd9-e03e-43e6-b53b-d0bb2d9e375f@oss.qualcomm.com>
 <CAFn=p-ZkTd5iv9UZCondYbBe6Y3Gudcv8oE-95Ttnh2O8dujEQ@mail.gmail.com>
 <419c14e6-cf06-4502-bad8-903d6896d4f6@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <419c14e6-cf06-4502-bad8-903d6896d4f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX/ZOQF4k1QxQt
 Sg9DlFYnFnqI9Y8Fp8L+GZMOABjXucz+r0u3LXqd079bcgR7bRonwSFE38C9kcEJ4uvpLO/A6ui
 fMv8sbUVwxEXbtTLoySGqn7j1Mc6oCI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX12WX1olLqcD/
 TG5iw2Zh3W2U+qD0MWdIJ4m1txDogil9lGAZLdsGyAQl3qMtuK2ETQV9Jl0dcHJ8VbEJ/Gsa2s5
 0mJBL44By6IJ01goXz72vPlbaDvV/4EiOqMOFN/QqL5wZy0gcipeTwfD63LjrmyNsXM3UyZakYC
 AYZKTbYAK4COtfzyQ5qL5YrkXa71xooHVPSblTK3TSNGKI5E1umEQOS/FO2Kp61y2ABRJRQu4z9
 O5IRbu8pUHej74gFO5yWrCKIwPqswO+8ydUbhUjMA1iDbGM+/fnAwTZB0u/92X6QWx4kHgOjIrm
 lD1iB1ODRMvksiWLJ1TaDWVBhtiJc++gsO8yjL3Fn5lQA5tZenCRpJZcyW4PDhPkXFznXffH8gN
 GvxTpHTvCTNqUniELAZq16s7HeOeoemyoXswKML5nhe3cOjp0sM8sBoUx6K37mw1zKW+fkPC9jY
 rqwkCT+W0ynx2LcipIw==
X-Proofpoint-ORIG-GUID: 993T_L-g_hWkujViKvhvuwJJrgvXB15e
X-Proofpoint-GUID: 993T_L-g_hWkujViKvhvuwJJrgvXB15e
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0dc95 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=iDw3GeftGWU4ZHOe0o4/TA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CckQENj0AAAA:8 a=IXRbXKkiDPkPv5A30C4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-23 14:55, Philippe Mathieu-DaudÃ© wrote:
> On 2026-07-29 18:01, John Snow wrote:
>> On Wed, Jul 29, 2026 at 9:30 AM Philippe Mathieu-Daudé
>> <philmd@oss.qualcomm.com> wrote:
>>>
>>> Hi Paolo,
>>>
>>> On 13/5/26 15:36, Paolo Bonzini wrote:
>>>> On 5/13/26 15:04, Philippe Mathieu-Daudé wrote:
>>>>> Hi,
>>>>>
>>>>> This is the second time I'm working offline and do a simple
>>>>> rebase, which triggers a re-configure, and then I'm stuck because
>>>>> PyPI tries to access the Internet and do not allow me to neither
>>>>> build nor test:
>>>>
>>>> Does it work if you configure with --disable-download?
>>>
>>> I got this issue again today:
>>>
>>> $ ../configure --disable-docs --enable-plugins
>>> --target-list=aarch64-softmmu --enable-tcg --enable-kvm
>>> python determined to be '/usr/bin/python3'
>>> python version: Python 3.14.4
>>> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
>>> mkvenv: checking for meson>=1.5.0
>>> mkvenv: checking for pycotap>=1.1.0
>>> mkvenv: installing meson==1.11.1, pycotap==1.3.1
>>> mkvenv: checking for qemu.qmp>=0.0.5
>>> mkvenv: checking for setuptools>=44.1.1
>>> mkvenv: checking for wheel>=0.34.2
>>> mkvenv: checking for pip>=20.3.4
>>> mkvenv: installing qemu.qmp==0.0.6
>>> WARNING: Retrying (Retry(total=4, connect=None, read=None,
>>> redirect=None, status=None)) after connection broken by
>>> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read
>>> timed out. (read timeout=15)")': /simple/qemu-qmp/
>>> WARNING: Retrying (Retry(total=3, connect=None, read=None,
>>> redirect=None, status=None)) after connection broken by
>>> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read
>>> timed out. (read timeout=15)")': /simple/qemu-qmp/
>>> WARNING: Retrying (Retry(total=2, connect=None, read=None,
>>> redirect=None, status=None)) after connection broken by
>>> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read
>>> timed out. (read timeout=15)")': /simple/qemu-qmp/
>>>
>>> Indeed using --disable-download fixed it.
> As of today's b6c4b7e86dec:
> 
> $ ../configure
> python determined to be '/usr/bin/python3'
> python version: Python 3.14.4
> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> mkvenv: checking for meson>=1.6.0
> mkvenv: checking for pycotap>=1.1.0
> mkvenv: installing meson==1.12.0, pycotap==1.3.1
> mkvenv: checking for qemu.qmp>=0.0.5
> mkvenv: checking for setuptools>=63.1.0
> mkvenv: checking for wheel>=0.41.2
> mkvenv: checking for pip>=23.2.1
> mkvenv: installing qemu.qmp==0.0.6
> WARNING: Retrying (Retry(total=4, connect=None, read=None, 
> redirect=None, status=None)) after connection broken by 
> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
> timed out. (read timeout=15)")': /simple/qemu-qmp/
> WARNING: Retrying (Retry(total=3, connect=None, read=None, 
> redirect=None, status=None)) after connection broken by 
> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
> timed out. (read timeout=15)")': /simple/qemu-qmp/
> WARNING: Retrying (Retry(total=2, connect=None, read=None, 
> redirect=None, status=None)) after connection broken by 
> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
> timed out. (read timeout=15)")': /simple/qemu-qmp/
> WARNING: Retrying (Retry(total=1, connect=None, read=None, 
> redirect=None, status=None)) after connection broken by 
> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
> timed out. (read timeout=15)")': /simple/qemu-qmp/
> ^CERROR: Operation cancelled by user

This happens when I rebase on mainstream 'master'; something
triggers a refresh while likely not necessary.

Obviously this is in an offline environment so not easy to debug there.

> 
> $ ../configure --disable-download
> 
> ERROR: missing subprojects
> 
> --disable-download specified but subprojects were not
> checked out.  Please invoke "meson subprojects download"
> before configuring QEMU, or remove --disable-download
> from the command line.
> 
> $ pyvenv/bin/meson subprojects down
> load
> ERROR: Directory . does not seem to be a Meson source directory.
> 
> $


