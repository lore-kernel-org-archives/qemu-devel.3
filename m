Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC24C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 04:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkExe-0004F7-4p; Mon, 17 Feb 2025 23:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tkExb-0004Eh-TM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 23:11:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tkExZ-0000Yu-MB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 23:11:51 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HN07kW010792
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 04:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ikduOGpOeCmI1zux03c36uBR1RBYDj9h7AjLaseARfI=; b=CL+udxRriCfVfm7S
 A3vxXtp1nUUaXh8mD+dlxITgfAta+Z6WJ0Ra6/ZzZdFnfU4rgoJmHj1SCttGe4G2
 mQwTtVRaLrJZ4TifovjGPNxuD/3tSQfGqYKzE5DMuSzLynT0WKTKFNnSVIa9AmZk
 x97xMtJzrKdpkUhYC6ScMGh836XfQ8uCR2AnY/QD1o9tK9EmXicK3dNbzfc8rgab
 lMb+orqgfkJ1r3k5A0n7ZIHi126ZtRyAgPinM6uGlQDSfUBhYz6Khxr1U/7icric
 q9nKSi7eUSmzEk9iyCKMiUFCn8uqH2jAnjW5jTAIlUXzPVssQEsiCgT51oUXu20P
 9FDHnA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7suj6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 04:11:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e637c24051so84812076d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 20:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739851904; x=1740456704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ikduOGpOeCmI1zux03c36uBR1RBYDj9h7AjLaseARfI=;
 b=Kbhu7KnM7E2ln8FsV3NZm3jQkjMVYMz96tlLDT0BUy6g6Y1mfjnxHBWyQbHyiFUIgQ
 bTKIrAkSEmMZ+1p+2a2H8WhpLV9AUQV0cdGKoTn/pTOzMBIljDO/PwR51m9TVN/lQn9c
 +gXAf+S+NuJNdj1IHdSLR+w258W3C28qW5LmL3Tnw/qp4BvqO5BkghO2ESIIUN7AE/qF
 dgl5gbPb7GYCLtcPfvDWdv4MR9PPR9d18e3DwwdLCF/PqCMh7eTAWmRZp007V69fcyW2
 ULQPbgPX1extOvNcHiLEJvYSVV8ujThcP+LXlFrYl9CTjuyFxlI8ki3TLVJW/nvMylA5
 /ISw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTuqJNUe5EiGS7c70EDf0crXwZw1qLVSoCF0CpMY5RmJ7QXaYWPzFaBFcobQMRep/nWP64dsbimstn@nongnu.org
X-Gm-Message-State: AOJu0YxvzZe2LdtOWL9RragM8rwkRJ0hlvbvTscjkhr6SMu5bFs6+TCj
 hgh33Sv4irubd8UsF0/FLYRSwBXQzcgEtJKHNqPqpMVKtcekr9hH3kJKaBgZL11VPxzuodUm1sV
 eP3/Y/etBLGjvnIghTVYtwzd8ge9sjfrZowW13aC1QIRBTu501NUn5g==
X-Gm-Gg: ASbGncuX+zumyJD7SbBoecjjlTzL2i7POW0pQLsD3QP8KLxM8/iLWOMbDkAblK2KCvA
 gxoN3dpQJ7jA2cjTuYu8NvvF+vOvS+/6liJF83Vzc56nNjPfhBZv0BAJ6EeK5/leOhOe3pp6Xec
 n7CNnVqg1Uv4quqKt7VllRiLvPkpK18hF0mPY+9gdxzDR3kv5692Q0YVEd/l1aw6i+oHANq26c3
 plRpCOwR8QwZ6JNiy/APlccjknQqaKsY+CK3iNYpyeKidhlPUGn6RA0iPtAl16hBBcezVd6bTTF
 OebU4MUQAglQa9Fkl+UqIsQ19i0OBDWmOk/dqw4tknjB6LvI+C4yAeYhQ+3aKe23fowcAnWRG8c
 rxm79xQ==
X-Received: by 2002:a05:6214:519d:b0:6e6:61a5:aa54 with SMTP id
 6a1803df08f44-6e66cd1f3dcmr120449346d6.44.1739851902278; 
 Mon, 17 Feb 2025 20:11:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLWzL45dpBocUE1mEcw03R+xTzGw6ip4UhW5u7dwqtHKvnrhKtHzo/cjQ7uiCALHemPcUheg==
X-Received: by 2002:a05:6214:519d:b0:6e6:61a5:aa54 with SMTP id
 6a1803df08f44-6e66cd1f3dcmr120449116d6.44.1739851901834; 
 Mon, 17 Feb 2025 20:11:41 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65d7793f5sm59556576d6.5.2025.02.17.20.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 20:11:41 -0800 (PST)
Message-ID: <4e788add-ee40-4d98-b065-6745e6e2fce5@oss.qualcomm.com>
Date: Mon, 17 Feb 2025 22:11:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
To: Stefan Weil <stefan.weil@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <b3ef0b9f-df09-4444-b0aa-3b2a36f7cd3a@weilnetz.de>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <b3ef0b9f-df09-4444-b0aa-3b2a36f7cd3a@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DzbwHfQqVwL0A5bAWyOZ6vu7akDkvHYD
X-Proofpoint-ORIG-GUID: DzbwHfQqVwL0A5bAWyOZ6vu7akDkvHYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_01,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 1/11/2025 4:08 PM, Stefan Weil via wrote:
> Am 10.01.25 um 21:33 schrieb Pierrick Bouvier:
>> For now, it was only possible to build plugins using GCC on Windows. 
>> However,
>> windows-aarch64 only supports Clang.
>> This biggest roadblock was to get rid of gcc_struct attribute, which 
>> is not
>> supported by Clang. After investigation, we proved it was safe to 
>> drop it.
>>
>> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and 
>> aarch64
>> hosts.
>>
>> v1 contained warning fixes and various bits that have been upstreamed 
>> already.
>> The only bits left in this series are the gcc_struct removal, and 
>> fixing the
>> plugins build with clang.
>>
>> This series is for 10.0, as we decided to not include the gcc_struct 
>> removal is
>> 9.2 release.
>>
>> All patches are now reviewed, so this series can be pulled. I'll 
>> report that to
>> MSYS2 too, so we can enable clang environments for QEMU.
>>
>> v1: 
>> https://patchew.org/QEMU/20241031040426.772604-1-pierrick.bouvier@linaro.org/
>>
>> v2:
>> - drop attribute gcc_struct instead of using -mno-ms-bitfields option
>> - add a section about bitfields in documentation
>>
>> v3:
>> - explain why gcc_struct attribute matters in packed structs in 
>> commit message
>> - reword the bitfields documentation with suggestions given
>>
>> v4:
>> - edit for bitfields doc requested by Philippe
>>
>> Pierrick Bouvier (3):
>>    win32: remove usage of attribute gcc_struct
>>    docs/devel/style: add a section about bitfield, and disallow them for
>>      packed structures
>>    plugins: enable linking with clang/lld
>>
>>   docs/devel/style.rst                      | 20 +++++++++++++++++++
>>   meson.build                               |  6 +++---
>>   include/qemu/compiler.h                   |  7 +------
>>   scripts/cocci-macro-file.h                |  6 +-----
>>   subprojects/libvhost-user/libvhost-user.h |  6 +-----
>>   contrib/plugins/meson.build               |  2 +-
>>   plugins/meson.build                       | 24 +++++++++++++++++++----
>>   tests/tcg/plugins/meson.build             |  3 +--
>>   8 files changed, 48 insertions(+), 26 deletions(-)
>
> This nice series allows building QEMU for Windows with the LLVM cross 
> compiler on my ARM64 machine, so you can add

Is this toolchain available publicly or did you build it yourself?  It 
would be handy if there were a linux x86_64 hosted cross-toolchain that 
can target Windows-aarch64.  Or linux aarch64 hosted would be pretty 
good, too.

Is there an MSYS2 or other distributor that provides windows-aarch64 
builds of the glib and other library dependencies?

>
> Tested-by: Stefan Weil <sw@weilnetz.de>
>
> I only needed a trivial additional fix in scripts/nsis.py for `make 
> installer` because the usual GNU objdump and the LLVM objdump (or the 
> cross x86_64-w64-mingw32-objdump in my test) produce slightly 
> different output (indentation with \t, indentation with four spaces). 
> I'll prepare a patch which eliminates the need for objdump, so no 
> intermediate fix is needed for this.
>
> Stefan W.
>

