Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B70CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 00:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGmnh-0002oY-3U; Tue, 13 Oct 2026 20:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGmnf-0002oL-Q2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:24:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGmnd-0001TF-Tl
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:24:55 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DLRMeg1404185
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8ow74i5IRw4nhKaKsQHlzeA9pPYU5QVMgsgeaZlzaRQ=; b=TDRAyqFE/nT+MbVb
 3R6wkDYVTrKunW8LmsHWkiO1Q9bXqQSzBG4WBeh3nSgaGfzCxcBkZuwFz7OLf5d0
 onTRyqZ+0eaor0ryfnqj14FqtatRGwfl5KBtkJYW2MvxJeCeH9HRW7i+Kn7KutH5
 pOtlfVQ0hcbB9WrBSojVNVj4J4UjzKF4Q3bHJq7UrWGUrnEkRky2ae+Z4C5jqlXY
 UPbHe6A6RNpvtR39p7YVAChokq+VdUBI/bqhgqbWrxIH11aUzSucey3GOK3gnhqj
 GFZIs5Etb/Poiqy78knhIwanZTB9Y2lmsiJdR5J8SIc2/zdXWYypfrK5ROvTQcI3
 on4rqg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9psk27rr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:24:51 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-8233f34d21eso3287430a34.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791937491; x=1792542291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ow74i5IRw4nhKaKsQHlzeA9pPYU5QVMgsgeaZlzaRQ=;
 b=RTvjO3As6UVMoVWP4+Y3pVntc5CgEo/RbQrMVTVmT7oFjiqXOk9nC+UOIvbTL74ROM
 3Py9SXXQpIw8IIdkhHET2I8AL1u0xfGnFH/+FX4R4tWpJ++7mhFhBZmtrs9S8N0aFaGW
 gKF3y2PNHa2GWpbj7StlXAi1hWdGBdGmN088vLW+v1B8cTKO/Lv04nuRYLZMKpqgXqh1
 5Xv3yfPdKBGjS3VuCPf+v540XshqmfHqLgx9W2VuArbL1oBjwH/mACWSPAiSn9ggWI7B
 CGHwvOUsSHNhgfXTrGZ3MQtSrf29v6Gbn70KlxLWNTVC+eP7hMyolIIHg667MVEzivC5
 u+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791937491; x=1792542291;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ow74i5IRw4nhKaKsQHlzeA9pPYU5QVMgsgeaZlzaRQ=;
 b=dZTa2sXgZ9i8ByBfbAmhCpiZQvLGN2g7jAsv8dWfCCaVJbrQA1HJznYN0ABc+PHqZj
 Hj/0wOySFma6radBiHLxGjOiJhR13oBxBvP6L+CW0x4Bdf/p0pIKU135Ap/u4FrSSiCn
 jKe4HtTAjzxWL6+DsQd2fRWoJSvm/vw0dZCK8/fGj7vKUDerWc07Ymhg2Jg/6aLqDItG
 pNnP3FrVdIUNbkYEYGJtj7TsZSR8cYJL2fm55HD3S5wPIRBwKLsGHvFr7/CuXXuwvkk1
 3IanXEQ0TU+i/OELPHxm39QvcFHBN2xkztfG2IXkJ0nqS/kv2+T1V21lpHQ5rPWYjLlD
 DAOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlxq9fqUlho3CKq3WHsW2AVO+6ZipxxrF1ttZlAqhs1+JDII2S9enAQvDNAQaJhcwClykBPi2syLPs@nongnu.org
X-Gm-Message-State: AFq9FYJjrtzapCBcEqmA40/JfALX2bZS+VSlQ8ziC2c9ubo66OPsPGd4
 51HrYj02L71aWKYpHFU7Mnx9f73btvPafPLrKy0bCaMsZVOG+GhXXxT+9owGkcc59Yoa02Dl1oJ
 FcbG+GbjvEUf27UoPsWBFT28ZMS8cqa4FpSiQZHI+pnGv5yLVzJ7p6gGCepR/y78hwQ==
X-Gm-Gg: AYBFou2kBStdKQz6sWur47FSZwvoLh3ALmK62vKUATWm3j3lzX3DVChOg4vH/rzIc5p
 jqvx8lYEIhHi7WHbO3VJz05Jtk0LZFa88bLnsUENCrCziVe3JFIdZutA6p8QmrTeMm+TIWL/8tT
 fFT8otW+sGIyRllmrCGnEBvJp4gxrnBgwyvU5h3IefuqaJseQ8h9PqxU1Bm0Vu7CiifR/HrH03o
 UEPZbeIon/QKVggrTweRqgUcqkw/3Isc4LfTKdXL7NYlhHf6ROGVZB7xd3He6G8AXuYbjnaM8UF
 0L+tEVaJbuIedOCyw8l91lwvcaqUUrdMLhP6+V5OIqyntD+5GvN+YAk3fRns1uq8oNlqWOheRMP
 zr7l/7wX6LH4FzKffldzl0feBVwdvYKp9tsfHjVbs1Eu0hHspQAiX9sBxTKJyLvlRcA==
X-Received: by 2002:a05:6830:67c9:b0:81c:ebf4:9ff8 with SMTP id
 46e09a7af769-830997cb00dmr13122978a34.30.1791937490931; 
 Tue, 13 Oct 2026 17:24:50 -0700 (PDT)
X-Received: by 2002:a05:6830:67c9:b0:81c:ebf4:9ff8 with SMTP id
 46e09a7af769-830997cb00dmr13122900a34.30.1791937488843; 
 Tue, 13 Oct 2026 17:24:48 -0700 (PDT)
Received: from ?IPV6:2600:100c:b088:78be:8d58:2241:3c5e:b479?
 ([2600:100c:b088:78be:8d58:2241:3c5e:b479])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-835c9da2b31sm8946769a34.5.2026.10.13.17.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 17:24:45 -0700 (PDT)
Message-ID: <c4909309-faaf-4b22-8554-92f8757d132c@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 19:24:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tests/functional/hexagon: add MiniVM, lock tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-7-brian.cain@oss.qualcomm.com>
 <c788ccde-7e96-48f1-8bd8-74e773db5e85@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <c788ccde-7e96-48f1-8bd8-74e773db5e85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uZ77yHwyaa2aAZbuo2ChwjYztgsRTKYE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwMSBTYWx0ZWRfX//8pmWYPcg9+
 1nGrpWhojtw5W3WRSjVV24450PJq23ocxAfSEM1Ut7zIadfFbpAltDTG4GrVJc3ewlgoI8V3Bdw
 /jOKACF7UaIYIY8n2kf+o9wujrMMst4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwMSBTYWx0ZWRfXxClda7aVwQr2
 I45cAozqlgN9T2DMqwv82T6eu/HQ1rG0/UN+NR4+jcWi+T1alUuvHtHxqLtnIi4eK33l2gphIzT
 PiAUR1TQQyWHhsabE8yDbruH8/Oc20rtdg2OHgbcfZniXRfVWLhZyfALPlV/WXY6qujYic2u3fS
 PLIum+5g0zJ4TjA44I2shPkVAykG65BnjKvNq6ZrtaPQPK4Vt6P5EsWOqOrY5uCSE1rYoikAf4b
 xMRruZSUSl62L4QABHwdTE8Lldc8Y3VzZTHlLuafXUc6CsLPrUPo8/tuwCIxREJA+TSAwkMe8LW
 ub6h1dSD3KPLhMpdoYgRZ439VQ1KOuPUGxks4/sMMU5ROu2UVNtUpkUXnfb71Q3iU91Q3EotylG
 MEeCeVmebxA20QMXNbLF5gMkfqc0KDbCo+CSYFmgtN5BkOdqtJ3y3J65IDBfJdXxjx02M+z9TUC
 widm6EgcjlKiZQGmHFw==
X-Authority-Analysis: v=2.4 cv=cbJHPXDM c=1 sm=1 tr=0 ts=6acecbd3 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=qC_FGOx9AAAA:8
 a=EUspDBNiAAAA:8 a=fS-9sY5N3xxQDiTvAUkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-GUID: uZ77yHwyaa2aAZbuo2ChwjYztgsRTKYE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140001
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 10/13/2026 4:55 PM, Pierrick Bouvier wrote:
> On 10/9/2026 12:25 PM, Brian Cain wrote:
>> Add the lock_verify test case to verify the k0/tlblock behavior, add the
>> minivm tests to cover start() and more.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/functional/hexagon/meson.build      |  1 +
>>   tests/functional/hexagon/test_minivm.py   | 43 +++++++++++++++++++++++
>>   tests/functional/hexagon/test_systests.py |  3 ++
>>   3 files changed, 47 insertions(+)
>>   create mode 100755 tests/functional/hexagon/test_minivm.py
>>
>> diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
>> index 44053e64676..e182bc98a06 100644
>> --- a/tests/functional/hexagon/meson.build
>> +++ b/tests/functional/hexagon/meson.build
>> @@ -3,6 +3,7 @@
>>   tests_hexagon_system_thorough = [
>>     'arch_tests',
>>     'systests',
>> +  'minivm',
>>   ]
>>   
>>   test_hexagon_timeouts = {
>> diff --git a/tests/functional/hexagon/test_minivm.py b/tests/functional/hexagon/test_minivm.py
>> new file mode 100755
>> index 00000000000..a70edbcc987
>> --- /dev/null
>> +++ b/tests/functional/hexagon/test_minivm.py
>> @@ -0,0 +1,43 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import QemuSystemTest, Asset, skipBigDataTest
>> +
>> +class MiniVMTest(QemuSystemTest):
>> +    '''
>> +    minivm is a Hexagon hypervisor that implements the Hexagon VM
>> +    specification.  These test cases boot minivm and then load test cases
>> +    to the address specified by MiniVMTest.GUEST_ENTRY and
>> +    execute a minvm-guest program to exercise minivm virtualization
>> +    features.
>> +    '''
>> +    timeout = 180
>> +    GUEST_ENTRY = 0xc0000000
>> +    REPO = 'https://artifacts.codelinaro.org/artifactory'
>> +    ASSET_TARBALL = \
>> +        Asset(f'{REPO}/codelinaro-toolchain-for-hexagon/'
>> +               '19.1.5/hexagon_minivm_2024_Dec_15.tar.gz',
>> +        'd7920b5ff14bed5a10b23ada7d4eb927ede08635281f25067e0d5711feee2c2a')
>> +
>> +    @skipBigDataTest()
>> +    def test_minivm(self):
>> +        self.set_machine('sim')
>> +        self.archive_extract(self.ASSET_TARBALL)
>> +        rootfs_path = self.scratch_file('hexagon-unknown-linux-musl-rootfs')
>> +        kernel_path = f'{rootfs_path}/boot/minivm'
>> +
>> +        for test_case in ('test_mmu', 'test_interrupts', 'test_processors'):
>> +            with self.subTest(test_case=test_case):
>> +                vm = self.get_vm(name=test_case)
>> +                vm.add_args('-kernel', kernel_path, '-device',
>> +                            f'loader,addr={hex(self.GUEST_ENTRY)},'
>> +                            f'file={rootfs_path}/boot/{test_case}')
>> +                vm.launch()
>> +                vm.wait()
>> +                self.assertEqual(vm.exitcode(), 0)
>> +
> In case we decide to extend that with many other sub testcases, it could
> be useful to define real sub tests. Just a suggestion though, it's not
> necessary for the only 3 tests we have at the moment.

OBTW confession time - the subTest() was merely hackery because the 
tarball includes a large-ish filesystem.  It was a sparse file before 
archive+compression but effectively now it's dense.  I just did this to 
avoid the time spent extracting for each test.  The extraction time 
dominates the test duration.

So maybe there's a better approach to consider w/o subTest()?

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>
> Regards,
> Pierrick

