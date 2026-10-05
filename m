Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23248CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlJ5-0005k9-Vn; Mon, 05 Oct 2026 12:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDlIj-0005gb-7N
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:12:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDlIh-00079l-Nd
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:12:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP0j72178390
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 16:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RKGcoadoarpXLzN4TqHa+mk6vZ64t8gbm2aENzgC+dA=; b=PIDGMj3sSacDJWlz
 3yox4voTpFVaOCPSL7Qd4lPex+j45/vNA9x3EMoaXorS+xkUF4kSg1OdfL1QnfMk
 SQ563iPmW4l0LSbKGaqztFHmkcjLUyfmgUdWD5Vr4KJXAr/3H3Rq24lRTtqsZa5Z
 l69dBbwBXe2iojz/aTnrDKOzXVUED5SrGBtpdFIHchH3hUcEzt2m2Cn+unf9bmiy
 ovitu0rJV7f1D2Im7TLtUz2Dhk4hyjmpinVv433b3kgpL4TSIbrfaRVu40Dy0rOq
 CQ3Y7koerwkjTNimMppzZgdvsZvyRdFDagDmXsm8k6J1Zj+OKrSN6qjpsvY4BG5G
 ofkxVA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cj60rss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 16:12:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34ef0362d95so3711769eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791216746; x=1791821546; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RKGcoadoarpXLzN4TqHa+mk6vZ64t8gbm2aENzgC+dA=;
 b=dRJlKxYvBXmYYqpKKU08UDSTy4be8wbAecnNNknT03lVQZENYq38JEjtwCUw7YfRFq
 sHxM08fu2lAbmUWhNfPForAc2la/wEGyChkMZL39hJNnlaCh4MIRoMgnlnhcsAl44JRK
 CTYHRadAF7ZieN86t9qC4ftEnzNIZXbhCycIoTwu+v/4hWUZAEn6T+FRy0TpOcAkDOVM
 RPdi3hs63rZwUih1nmPd/aPBFz2LV3DyXJLIwxql52WmpOJCozSf1x6qqODNy4x9KiE7
 FbWrJKKSiRX515e0sb7SmaWAutBNhM9+jtn1UW8/QMLS64Ty8UH7j1sho/uGOsero8Hw
 KYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791216746; x=1791821546;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RKGcoadoarpXLzN4TqHa+mk6vZ64t8gbm2aENzgC+dA=;
 b=QrkZonVujKlXiwsr1Ufv9mvFAMUMvTfY7scl1ql4swAoENiHBFNNEM4KuhtHJBtU84
 +/qxzptKRJEju/RFHAENwzA/qkttNWCUlac0ommKk05nYGFrnh62AqYWImqKymW4Ck3w
 NGH/AUeFtUrsSKXEnV8v901rW6CL9bRPxA4iM5ZqRFfRKZ39p2OjjsiDsvNKcjzbH/tX
 vN/BIi+BCuFEN7Rn9abG8iEJFUuLN0MZVOnKioCNhtEsyHZ1lUgzR/q8rdF88UGKv7Y4
 Cwum1+aZETRIWvbS66Tbr5QyAZDrx1Fw/fCY4NBjR8hPm4Fj3ELZdopbe5ztpTRjR4Vs
 kTXQ==
X-Gm-Message-State: AFuF++lzb9Dba6XJmA1q/1ut3JLknr/7iyzw1czNxBhJJuxoTzXmH8cL
 ttVKuM2aUyCDNQ0S0knsM3vtEdfBNu6D3ZSsQqs0NmpgAXyI1D5zzDt9Si97ZdFCZ+OqmxArWr+
 Y7YTDKMmEZOQpRbeneMDtBzAfreEm696QWWOI4rMEW7HFNGYVnRkiwYpzpQ==
X-Gm-Gg: AYBFou2RyvlomWMWtLq3+hIb4swB+ECuAKpDwbdrhxTh5g1sNRcJzjTffctcIZmzsCc
 i/T4ZC9SXTgih7YZy23LorazHgrP8fMVMlT99M514eGwEhOp94iuAPQU4YwK/kn+grFV/Dy2fws
 YdNIqe5c3NeQqmoaFped9LijNd1Mqiw67+npSKbJV4E+Yc6SQYpSQq3RqlXrpjKu9I4xS+QgqST
 fALSmK1oieC222OlP9RBnYoA4+/qOrEfnph1aILv2XN3rkt4BzqJsM2VpxAsoKMIbJFGLw7Az5p
 b9hX+yzniWwlS5bvl0X5Brk5GeIpEnzZkk4XldGY6qbK6riU20qYz4Y/Igr4cv/PHN24pRcz9lm
 lN8UZBliPYrmEHXw3zwOuV0bi5Clu2vXyhedFoE2B7VNYwFUcofMt5J/hleHN8MLrPR5WUQ==
X-Received: by 2002:a05:701b:2406:b0:143:46a6:b01f with SMTP id
 a92af1059eb24-151c36c4ddfmr11189780c88.31.1791216745337; 
 Mon, 05 Oct 2026 09:12:25 -0700 (PDT)
X-Received: by 2002:a05:701b:2406:b0:143:46a6:b01f with SMTP id
 a92af1059eb24-151c36c4ddfmr11189745c88.31.1791216744625; 
 Mon, 05 Oct 2026 09:12:24 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fc87346bsm47723042c88.8.2026.10.05.09.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 09:12:23 -0700 (PDT)
Message-ID: <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 09:12:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MyBTYWx0ZWRfX4YLw8w5YapK/
 ff2yDKL5f59ncU5LgNeKRA+aIj3fuGzHsXRr7Pngszma6nzLE3zIgzTjReCSSL40HkoUzNApfhF
 lLajSybU3TpbfBj+DEtKW0dYthPkEcBqfnFuP4garnSJ4ZMsMcw/GgJutz5juMy+hz+NTraj8OU
 y967HtGUJ2H3itFs1Nuj6vxtGY0uKWBxys6+r0cr5/f9nbigVvrb6s6kkXoN8VXPLeUdjqEGAOh
 IpZtmRNZC9OO3NbzCy1dFWhSbIZnupijWVS7OZFcERCGT8oKl+KqqJcR7CWQoZ1yEV8aClVOWFi
 QI194Hyhk6ac2YpzVfM8RouPFIk0dAexWvlbCOQUDPC1R5wohMAqR2WY1n4W1rXYDIGRxaT6Rsb
 4do4sZTT2jB1Loz2uveB+1WCm1wD7WTXn0QL62ATHmLlBwXHiZsctLALtf4AQmHVyP+0/+8RLNk
 kIOr/hCMxhwYDqfaCCA==
X-Proofpoint-GUID: C4-lB5QIyQQ29vvZRkGkb4a-ylGr-fi0
X-Proofpoint-ORIG-GUID: C4-lB5QIyQQ29vvZRkGkb4a-ylGr-fi0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MyBTYWx0ZWRfX2+wmh9+yKFoA
 0S/VPQOHNLPidMMdDJQHwIcFuYtyO2j6TGUw1lxs8HEPHZIOhqYj7a9fDamJY+RtjxpjDxywvAY
 Yzg5wT+oRFlNjwRz1PZKyqZQK8m9fzY=
X-Authority-Analysis: v=2.4 cv=bpTZl0ai c=1 sm=1 tr=0 ts=6ac3cc6a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=gtcreJhlBZZCXNracTAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050063
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

On 10/5/2026 9:10 AM, Yonggang Luo wrote:
> On Tue, Oct 6, 2026 at 12:03 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/4/2026 12:29 AM, Yonggang Luo wrote:
>>> `TARGET_ARCH` identifies a base architecture, not necessarily the full
>>> system-emulation target. For example, `mipsel-softmmu` uses `TARGET_ARCH=mips`,
>>> which caused `query-target` to report `mips` instead of `mipsel`.
>>>
>>> Generate `TARGET_SYS_EMU` separately. Softmmu builds use the full target name,
>>> as `SysEmuTarget` enumerates system targets. User-mode builds use
>>> `TARGET_ARCH`: user target names such as `aarch64_be` and `mipsn32el` do not
>>> have corresponding `SysEmuTarget` values. This means `mipsel-linux-user` now
>>> reports the base architecture `mips` rather than `mipsel`; its executable name
>>> remains unchanged. Initialize `TargetInfo.target_arch` from this token and add
>>> a qtest to check the `query-target` result against the target name of the
>>> running QEMU binary.
>>>
>>> Yonggang Luo (4):
>>>   Revert "target-info: Statically initialize target_arch"
>>>   Revert "meson: Add TARGET_ARCH to config_target_data"
>>>   tests/qtest: check query-target architecture
>>>   target-info: preserve full softmmu target identity
>>>
>>>  meson.build            | 11 +++++++++--
>>>  target-info-stub.c     |  2 +-
>>>  tests/qtest/qmp-test.c | 13 +++++++++++++
>>>  3 files changed, 23 insertions(+), 3 deletions(-)
>>>
>>
>> Why should we do this for user binaries? Current work around
>> single-binary only concerns system binaries, where all targets are
>> correctly covered by what exists.
> 
> From my personal point of view, keeping target_arch as
> SYS_EMU_TARGET__MAX for user binaries
> is a better option. I am doing this is for replica of commit
>

Ok, but I'm not sure it answers the why.
Could you explain the benefits?

> "target-info: Statically initialize target_arch"
> 
>>
>> Regards,
>> Pierrick
> 
> 
> 


