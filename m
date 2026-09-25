Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F10DC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA7jU-0003FL-7U; Fri, 25 Sep 2026 11:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xA7jH-0003Dj-UK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:20:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xA7jF-00034P-A3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:20:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PD2v381056570
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5V+k/jYlEdzqb3o4pwQwCP0m4iAUdFh6kq1QgJtN0ow=; b=o9gzmmNgEAENJFv5
 v5FcWlwbGuSzwEioQzZK/I8gvGl7DEhz+OmUUZd6LAD5xjEinDnYVT0KLsoPt/Pd
 vg2ulfPHxCfmxkBBvUmYcOrRGJ4GbWFy8gEDd8HMbRyR+tbWsTwnqi7nAc/hq2Oi
 DjM67MmL2Yb/SQNsXNViFWNuNEdiZL98qaqDNPb8dVkdXn8QZ2fFE/WJCYSuxb9Q
 7crWr+AnvH4/hBwFxR80ip4kEQm08GYOc+iZ7eRIvQbfGofx83lIxFHxICx+FOOF
 TIevMYmRXkluEi5FmUZ2+/qFRYTmWCzzdgXdYk4xVv5HW1iewsrqNebrWWmF6obH
 VEkDyw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7b0xb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:20:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2df5a65671eso11306475ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790349646; x=1790954446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5V+k/jYlEdzqb3o4pwQwCP0m4iAUdFh6kq1QgJtN0ow=;
 b=HO/X5HgF4pmXYiknjAmmvjuTsNiXQu7e3rRHx+QQEQg86t0c8RwDr4HLkm4SHfpeT9
 iUS9gXbTyjj9wgE8guweMX8NQcmZIOb0xrY/QMotz97sAL9W8b23SxzvPYvUkLH/WfBy
 6s8f0sHKhTcpBp4DYkPFnOTcVCIzmUMuKRxRlQcpcDuRt5egqIolmn4RW/xKvp3kY0PO
 4WzMK7ExSK4wBS6PaOfXaj6t6vPo80b+/Ty0WPLVBf1B4rH+JeOZbqR7hr2JaeoQIk5U
 Js02f/kocgWBSXzy16NCWw16MVvlVD7NEuDEjpXlCVf2G/MizB6+Xgl4bvvvyTfDeScW
 YrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790349646; x=1790954446;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5V+k/jYlEdzqb3o4pwQwCP0m4iAUdFh6kq1QgJtN0ow=;
 b=hl82B/0XI86xuHWYQqf9ddmDbClS2ettiP3yPfVJ3cwUuOC0UWdKTImhVkGrZYskdm
 AHwYix0IfSIoGh4KXzJFuyjuDW971Y+FBc4+MOH3nHLg0m78Nte8ZJpjzs8/DiP7leo0
 rtVJTFp5bzf/LfTnD5V8OPT8IebibKKelecjWDAQ0KQQMlNAVwzD526jOwwku0f4WjsF
 6doLbwU5SrzfgfMy4YKuOpsieIf0S1CfkFa523FsC5iRp17hFN0NUkw7ggLB6yS9v2na
 BeK7AGO8I3u/K5BzQ7IsQidR0xR3PwnWU7k3ICrQ8NnEbg+vrpF9mL/n2hq0vLAGcBeZ
 yR7w==
X-Gm-Message-State: AFuF++luQCTNnG6uTAfQhEKlw3k8LWGtmq9Ee+EpT9Va4uJ/X/VcjStd
 FvKr2J1OMfZC/lO3clp9yJc7ICvleGrMriT7VyRXz021es1YRm1itmRaKRwXmWJU/Ti5QvtGxqs
 PhVCr7TDkvZSZiZZisQWirtCRD/cBx9VS/YxXmzBT5Xgfso2KHtNSY3pUSQ==
X-Gm-Gg: AYBFou2SihdPpNY1FKakuWlotcWriRWW/OkupcwQjH78CHvkwn6jwpLZ8xN8Uig+9Ul
 apewxLE6MC/Ccx6ntQUCia4H6ZvQ9mW7Ov6+KmiwsYEDQtrzNJibOXpHQ5XzC6vGGeCgMFbkRrA
 4dBon8THnYtfe4uc6rFcMhy325c08fu72ZS/DABGejfDL2d9ZI8gLfzNOv/V/3hKnlx9GCTqat8
 kAlWcbcRX+qoNwwIcWbmxlDd9/JEHkqR7OD0w7PLbU8wK/jemYUpo9Fli8mOeBckZIqqgvLHFQI
 fKBSDyMnG/1h+5sDiqNNh8hB7AEl9+fuAWRilLZlB9sDZ6c9zsz72DfuYtp7cMHtA5JRvpFVVoD
 bVjMEPhYgEzl+gYgmv3QaLD0OAh1njpjYGXG1V5eHRecT7uUOJw/VNdNXoH2STIT/Zy0=
X-Received: by 2002:a17:903:3b83:b0:2da:fa62:4aee with SMTP id
 d9443c01a7336-2df7dfc39f8mr34834725ad.1.1790349645439; 
 Fri, 25 Sep 2026 08:20:45 -0700 (PDT)
X-Received: by 2002:a17:903:3b83:b0:2da:fa62:4aee with SMTP id
 d9443c01a7336-2df7dfc39f8mr34834595ad.1.1790349644990; 
 Fri, 25 Sep 2026 08:20:44 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df91461177sm12575535ad.74.2026.09.25.08.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 08:20:44 -0700 (PDT)
Message-ID: <fa2f6396-c658-4ca9-a985-04d9f2cffda2@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 08:20:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/tcg: add alternative cross-compilers for fedora
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260924213942.26491-4-pierrick.bouvier@oss.qualcomm.com>
 <arZBqmDtOX8YoJaA@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arZBqmDtOX8YoJaA@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: k1FLUMQp70m63VvejgcmBSkISQfhsFK_
X-Proofpoint-ORIG-GUID: k1FLUMQp70m63VvejgcmBSkISQfhsFK_
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab6914e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=vTr9H3xdAAAA:8 a=DXCZQ6ynHBf9aCTSatAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MSBTYWx0ZWRfXzWWgn6+qt4Lb
 Eimjb0XNYT683z43vs0Ff35U0dcZ/VQRvbOyyVYQj3+IrCFQwyboPZoMFMz6gjVNK8WYtESXPQ+
 kn69T6+QgjysqWyiaoyk5BmT1pfWibNfU3LzFMPx2LCqLWEVuoI3QHPHhLExbzHkPPu75UWcwHN
 IF0m2U9sKPYt6Nwh0kUTq6ryNpygY207d8/DpTRvypfT2TZ+DdlWc5ftf1qV6nzR25OvwUZhXf5
 1+w4AG2i0k1F/u8qQoxvcJjYpb+blcsOOvBc9fWccdDY/lU7GrYwfEmB21FJOEXj7mXHrcbGxtT
 7CIqBkJYEj1fwZawhRE1sJNK1dcYbdsRn7KOcZ/YrsPDDE1FQzBuc+bqs0zcJm9mZM9h4G6Oj3w
 JhZOpAGn9LvPfRx9YSLipd4WMBYoWHcBGHLexx2URjA1+XeynssO7dSQqzLbFMpRzFHKhs4EaRa
 IZGDILqogzbjSYOC9lQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MSBTYWx0ZWRfX9LBUGuL+ps5K
 FKR3Z/WPzBBcwLiWNm8LoqNWG7PQmfTYjUIUFKbmTQh8tNwf5p+7bVCcJDt3kZbHIstHAMpp68N
 nAWI6bL7oTg+I7vOuVlPJGceMtCVg0Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250061
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

On 9/25/2026 2:40 AM, Daniel P. Berrangé wrote:
> On Thu, Sep 24, 2026 at 09:39:41PM +0000, Pierrick Bouvier wrote:
>> This allows to pick host compiler automatically on fedora, as those
>> binaries are installed with 'gcc' package.
>>
>> This covers all host arch supported to this day:
>> https://fedoraproject.org/wiki/Architectures
>> - x86_64
>> - aarch64
>> - ppc64le
>> - riscv64
>> - s390x
>> Note: QEMU and Fedora don't support 32-bit hosts anymore.
> 
> Regardless of what installation arches Fedora targets, it
> ships cross compilers for pretty much everything. In F44
> I see the following GCC available:
> 
> gcc-aarch64-linux-gnu.x86_64         16.2.1-1.fc44 updates
> gcc-alpha-linux-gnu.x86_64           16.2.1-1.fc44 updates
> gcc-arc-linux-gnu.x86_64             16.2.1-1.fc44 updates
> gcc-arm-linux-gnu.x86_64             16.2.1-1.fc44 updates
> gcc-avr32-linux-gnu.x86_64           16.2.1-1.fc44 updates
> gcc-bfin-linux-gnu.x86_64            16.2.1-1.fc44 updates
> gcc-c6x-linux-gnu.x86_64             16.2.1-1.fc44 updates
> gcc-frv-linux-gnu.x86_64             16.2.1-1.fc44 updates
> gcc-h8300-linux-gnu.x86_64           16.2.1-1.fc44 updates
> gcc-hppa-linux-gnu.x86_64            16.2.1-1.fc44 updates
> gcc-hppa64-linux-gnu.x86_64          16.2.1-1.fc44 updates
> gcc-ia64-linux-gnu.x86_64            16.2.1-1.fc44 updates
> gcc-loongarch64-linux-gnu.x86_64     16.2.1-1.fc44 updates
> gcc-m68k-linux-gnu.x86_64            16.2.1-1.fc44 updates
> gcc-microblaze-linux-gnu.x86_64      16.2.1-1.fc44 updates
> gcc-mips64-linux-gnu.x86_64          16.2.1-1.fc44 updates
> gcc-mn10300-linux-gnu.x86_64         16.2.1-1.fc44 updates
> gcc-openrisc-linux-gnu.x86_64        16.2.1-1.fc44 updates
> gcc-powerpc64-linux-gnu.x86_64       16.2.1-1.fc44 updates
> gcc-powerpc64le-linux-gnu.x86_64     16.2.1-1.fc44 updates
> gcc-ppc64-linux-gnu.x86_64           16.2.1-1.fc44 updates
> gcc-ppc64le-linux-gnu.x86_64         16.2.1-1.fc44 updates
> gcc-riscv32-linux-gnu.x86_64         16.2.1-1.fc44 updates
> gcc-riscv64-linux-gnu.x86_64         16.2.1-1.fc44 updates
> gcc-s390x-linux-gnu.x86_64           16.2.1-1.fc44 updates
> gcc-sparc64-linux-gnu.x86_64         16.2.1-1.fc44 updates
> gcc-x86_64-linux-gnu.x86_64          16.2.1-1.fc44 updates
> gcc-xtensa-linux-gnu.x86_64          16.2.1-1.fc44 updates
> 
>

We want to detect host compiler here (redhat-* variants), as mentioned
in commit description. It addresses original request from Paolo. Cross
compilers above are already detected with current cc field.

> 
> With regards,
> Daniel


