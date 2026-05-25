Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4AECD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 17:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRYxE-0007zc-8q; Mon, 25 May 2026 13:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRYx4-0007yi-7n
 for qemu-devel@nongnu.org; Mon, 25 May 2026 13:18:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRYx1-0007pI-Og
 for qemu-devel@nongnu.org; Mon, 25 May 2026 13:18:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PEBdxs3658095
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 17:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GFZSyZxfUBqDXS7KjAVmYSod
 f5PDS7OpqHUyiLyWsNw=; b=T3mhYbm6n9kqQObxHElHh0Zlb0ce3OXHQZAJGhYW
 EamzMN1mGssJgoMv4UJJyYXutsOJicNmV1JIdUS720fV9yk7opt16Xh6vuwb+8kA
 sHgnMHeQ0Y82Rfmcf6hkma74EFTK/PnuiCEHh3Yu8n9zToE4roYQ2xa2zy1q4wdP
 gpc74ZJ8k+IjxdirMivzYhN+/W5wiFOEryd90GYC7mTcimVCIlAlt+DHbZip4IvO
 eDjZrexJ5Au8qHN6MmyCHkpuGfQzwfqmzNDijWZX4jaEeDsiDZWFQGuVzSUh7QsH
 xZA9BuN3zgKoPspKgH3y2FaCYmxyETrYJH7LyHYpaTVt7Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqyn8j5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 17:18:49 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13537722193so1737953c88.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779729529; x=1780334329; darn=nongnu.org;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFZSyZxfUBqDXS7KjAVmYSodf5PDS7OpqHUyiLyWsNw=;
 b=Sr4XztVs1gc4JtGdgbrYqJ7aByxMVG4UbxJzUnt8QzDh0N30jVdWM6WTQrOqG5Jz0a
 9GoHky+GVdNGFZsPJfxScwy+c3n1Eo06occZ4irUVBN689qwykyueyZlI2XaYan23/Ns
 5NmdK1isMVCwMd/VJ9q9sZHCaelpWi1hjaJMAIQElfHw/ulO820++X/JsavB+cDVuf3q
 K+RCOr8sapkLiIFc5TCSRlw5HMWtLHB3cA67zZFMcXKDQzDmuljS+1hqT/AUfiu++IXK
 paGRlCPvqSTwP1VU/SmMlj2C07KqIFqxCf0tvuXr/tcgkiBjMpyhYIga2Zf5kdKnaewV
 gi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779729529; x=1780334329;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GFZSyZxfUBqDXS7KjAVmYSodf5PDS7OpqHUyiLyWsNw=;
 b=N8kmL6+14L9GK7ekhdZOqtlHpZwe1TWpxCmJhQ1fby2gRwT3OaqFz5qNx0qdYm5lpr
 D4GJdkm2Lr65x7rtsPb6WQY2nN9HkFD59JrMK2pWUnb+HyKIlw2ryo1bUNScIDZEwAx1
 qB1y7vakFWNkUohLl00Lbjq+CIaIbdOpawv/TgfurIqrqngdbJ3eCe2cvA6fDQQtTzxl
 yQYGdS1VTihvxvrvaO8qQ4gKCYvqAicARjw1/s77KLBKgYkLGikihFYhjPw7jNBw/BzB
 /7MJbR7rUtNl5vym9Y0e4pBG34SJI5vecNhqrncuoV0omztex9tu0k2L787n2cPd9qjU
 V8SA==
X-Gm-Message-State: AOJu0Yyu72eY/Vonoq5uSOVGf1Thp0tLAb1y7vgVSJmWlZ0sg9Ht2GLa
 efa06xgT5F6v7538HXpltoZPKjWRa5C7IhpigoaGa9pM+RdpLTrsYnfF0bsxC3Iv5P3mAQIiWa6
 xwf4bV3brBxNj+D72Od0QdPH06t4EfBaN7RNIrJoCOYNLWeI409vEAiX5kA==
X-Gm-Gg: Acq92OHL83EaI3d88h6yjoO/hhcmMqe2ojfstzo78LTxzoff7uRxQ6vor5IAeE3mHLN
 HIR7XlxZW17K3cR9eVoMR2HsqNHQ8p1yXUf0BzlzvBYPXcP+pn9bFFSyG65TeMDUHKCfV/PAcIA
 Azu0BOZtTdetM/jH8/pQi1JIAYTRqEvOS5c3FOnF8xFRsQ5FvY2hcIbHBaCA12NZD6o2UUiCvaU
 gIkHoA6pLWpjZTv+yMcjh+cHv3dcDkwtEEew9jhob5GLUZ1960iViK17y01qpuAJM+yiGR36GFz
 +43fv7nMyIPmSc6/XEDWxfb9lPh0zd3audfbun3hy2SguhEuyEPT5nseDms+ZLDNSnYSyCBvt/B
 pt5X9KioiNNpeslvoi8VigD8MGtCZvGRPmelMGbfuWZHxcCdqmkUY6jJpX6MPYE8MrQzzspyTW0
 4hj5agGbCbQ7GHQw==
X-Received: by 2002:a05:7022:2381:b0:136:a5df:dcb9 with SMTP id
 a92af1059eb24-136a5dfddfamr2859682c88.10.1779729528790; 
 Mon, 25 May 2026 10:18:48 -0700 (PDT)
X-Received: by 2002:a05:7022:2381:b0:136:a5df:dcb9 with SMTP id
 a92af1059eb24-136a5dfddfamr2859662c88.10.1779729528134; 
 Mon, 25 May 2026 10:18:48 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a40305csm5991699c88.7.2026.05.25.10.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 10:18:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------40CsafmXQVnozvoL3aCd0RDG"
Message-ID: <0f73d717-1621-4c3f-9c5e-9bfdfaffb0b8@oss.qualcomm.com>
Date: Mon, 25 May 2026 10:18:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency to
 run-tcg-tests-% rules
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
 <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
 <87cxymec7b.fsf@draig.linaro.org>
 <5bd51a1a-4079-4073-bbd8-f0206a1ad458@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5bd51a1a-4079-4073-bbd8-f0206a1ad458@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Wpwb99fv c=1 sm=1 tr=0 ts=6a14847a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=3Kua0wUZ5nQODclCGu0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=wHKK0QyR7lOD0vgqDtsA:9 a=B2y7HmGcmWMA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: TsV28BCf96Ml_aJLsoIDz9KAls22oZgs
X-Proofpoint-ORIG-GUID: TsV28BCf96Ml_aJLsoIDz9KAls22oZgs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE3NCBTYWx0ZWRfX6K3O77fxcZy2
 dHs0dwZciYa5bOmQMpEmuuWwlp19DYs6r4+V7y05lOZiTUe8QjAizInYtPLZkX6uipbH9j/jdKl
 9PBOyFqVwYhCJia44BrTgdK7z1F/2CXwg9Iu5xvDQOwl/pLohl3CKOfWXy7TkRsVCUSgXCJWTDR
 3waFsJfyD1EqqWIS9eEiEeEN8hBKJtcg3m5ryVW8kQN7i7RlJDDjnTMiWvLuJfpCVPooG7g+DZg
 mVvLuJIsK9wLRU+7OiS3RUW53gt1hz+B0sg4QiFvbu4zXcx4boqa41oqDB1M+2CLX2OzBn1gmOr
 TumGionCHlyPy4PRGNpUTDNjIDsj9YE8Y6r8oOWf39JcVbj3I/CGxIutVMBynvVaiifgbK0oab6
 9RlDyIZc/onPbXh1HxtzwZJq3OnG5/m1weC6u1XP7PUUzEKRubtdCL6oGwPNTrDxYKI9bd3vdux
 JgQVDzvHsiiW/5+ff0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250174
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

This is a multi-part message in MIME format.
--------------40CsafmXQVnozvoL3aCd0RDG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/25/2026 8:46 AM, Pierrick Bouvier wrote:
> On 5/23/2026 1:56 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> On 5/22/2026 12:02 PM, Alex Bennée wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> On 5/21/2026 6:17 AM, Alex Bennée wrote:
>>>>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>>>>> ensure they get built. This is especially important for MacOS which
>>>>>> otherwise only builds the unsigned binaries on a normal "make all"
>>>>>> run.
>>>>>>
>>>>>
>>>>> I'm not sure to see why it matters. tcg-tests don't make use of hvf, so
>>>>> unsigned binaries are plenty for it.
>>>>>
>>>>> Which other binary is this building that is not built by default?
>>>>>
>>>>> In general, if something is not included in "all" target, let's make
>>>>> sure it's included there (meson.build?) instead of adding a workaround
>>>>> here. Not only tests benefit this, but anyone doing a build on a
>>>>> platform that might have optional binaries not built by default.
>>>>
>>>> If you have a suggestion on how to make that work I'm all ears.
>>>>
>>>
>>> I would be happy to help, but I don't understand what the goal is. I
>>> have three questions that should help to provide a suggestion.
>>>
>>> Which exact test command do you run?
>>
>> make check-tcg
>>
>>>
>>> ```
>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>> ensure they get built.
>>> ```
>>> Aren't they built by all?
>>
>> Apparently not.
>>
>>> It seems to be a dependency, at least for check-tcg:
>>> .ninja-goals.check-tcg = all test-plugins
>>>
>>> ```
>>> This is especially important for MacOS which otherwise only builds the
>>> unsigned binaries on a normal "make all" run.
>>> ```
>>> Why do you need signed binaries for testing on MacOS (hvf?)?
>>
>> In a previous iteration I made configure spit out the unsigned binaries
>> to config-target.mak but the request was to fix the dependencies
>> instead.
>>
>> It all works on Linux so I'm not sure why MacOS is being so weird
>> because the meson emulators target mechanism should be the same.
>>
> 
> Just tried now, and it does not work on Linux neither (make check-tcg
> does not build any target beyond tests). Maybe you forgot to clean your
> folder?
>

The root issue is that tests/Makefile.include is included *after*
evaluation of ninja-targets in main Makefile. Thus,
.ninja-goals.check-tcg is ignored.

The fix is to move ninja-targets evaluation to the end of main Makefile,
which introduce the expected dependency for check-tcg to "all
test-plugins" targets.

You can replace current patch with the one attached to this email.

Regards,
Pierrick
--------------40CsafmXQVnozvoL3aCd0RDG
Content-Type: text/plain; charset=UTF-8;
 name="0001-Makefile-move-ninja-targets-evaluation-to-end-of-fil.patch"
Content-Disposition: attachment;
 filename*0="0001-Makefile-move-ninja-targets-evaluation-to-end-of-fil.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmZmM0MThmMWFkZTQyN2UzYWI0NjQ4ZDk3YWYzNzg4OGY0MjRiYWE3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+CkRhdGU6IE1vbiwgMjUgTWF5IDIwMjYgMTA6MDk6NTYg
LTA3MDAKU3ViamVjdDogW1BBVENIXSBNYWtlZmlsZTogbW92ZSBuaW5qYS10YXJnZXRzIGV2
YWx1YXRpb24gdG8gZW5kIG9mIGZpbGUKCkFsZXggZm91bmQgdGhhdCBtYWtlIGNoZWNrLXRj
ZyB3YXMgbm90IGNvcnJlY3RseSBidWlsZGluZyBxZW11IGJpbmFyaWVzLgpUaGUgcHJvYmxl
bSB3YXMgdGhhdCAuL3Rlc3RzL01ha2VmaWxlLmluY2x1ZGUgaXMgaW5jbHVkZWQgKmFmdGVy
KgpldmFsdWF0aW5nIG5pbmphLXRhcmdldHMuIFRodXMsIC5uaW5qYS1nb2Fscy5jaGVjay10
Y2cgd2FzIGlnbm9yZWQuCgpUbyBmaXggdGhpcyBhbmQgYXZvaWQgbWlzdGFrZXMgaW4gdGhl
IGZ1dHVyZSwganVzdCBtb3ZlIHRoZQpuaW5qYS10YXJnZXRzIGV2YWx1YXRpb24gYXQgZW5k
IG9mIG1haW4gTWFrZWZpbGUuCgpTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogTWFrZWZpbGUgfCA4OCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggNTQ1NDdhMzdiMWEuLjVl
MDBiYzA5MGZjIDEwMDY0NAotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtMTM1
LDQ5ICsxMzUsNiBAQCAkKFNSQ19QQVRIKS9zY3JpcHRzL21lc29uLWJ1aWxkb3B0aW9ucy5z
aDogJChTUkNfUEFUSCkvbWVzb25fb3B0aW9ucy50eHQgJChTUkNfUAogCSAgc2NyaXB0cy9t
ZXNvbi1idWlsZG9wdGlvbnMucHkgPiAkQC50bXAgJiYgbXYgJEAudG1wICRACiBlbmRpZgog
Ci0jIDQuIFJ1bGVzIHRvIGJyaWRnZSB0byBvdGhlciBtYWtlZmlsZXMKLQotaWZuZXEgKCQo
TklOSkEpLCkKLSMgRmlsdGVyIG91dCBsb25nIG9wdGlvbnMgdG8gYXZvaWQgZmxhZ3MgbGlr
ZSAtLW5vLXByaW50LWRpcmVjdG9yeSB3aGljaAotIyBtYXkgcmVzdWx0IGluIGZhbHNlIHBv
c2l0aXZlIG1hdGNoIGZvciBNQUtFLm4KLU1BS0UubiA9ICQoZmluZHN0cmluZyBuLCQoZmly
c3R3b3JkICQoZmlsdGVyLW91dCAtLSUsJChNQUtFRkxBR1MpKSkpCi1NQUtFLmsgPSAkKGZp
bmRzdHJpbmcgaywkKGZpcnN0d29yZCAkKGZpbHRlci1vdXQgLS0lLCQoTUFLRUZMQUdTKSkp
KQotTUFLRS5xID0gJChmaW5kc3RyaW5nIHEsJChmaXJzdHdvcmQgJChmaWx0ZXItb3V0IC0t
JSwkKE1BS0VGTEFHUykpKSkKLU1BS0UubnEgPSAkKGlmICQod29yZCAyLCAkKE1BS0Uubikg
JChNQUtFLnEpKSxucSkKLU5JTkpBRkxBR1MgPSBcCi0gICAgICAgICQoaWYgJFYsLXYpIFwK
LSAgICAgICAgJChpZiAkKE1BS0UubiksIC1uKSBcCi0gICAgICAgICQoaWYgJChNQUtFLmsp
LCAtazApIFwKLSAgICAgICAgJChmaWx0ZXItb3V0IC1qLCBcCi0gICAgICAgICAgJChvciAk
KGZpbHRlciAtbCUgLWolLCAkKE1BS0VGTEFHUykpLCBcCi0gICAgICAgICAgICAgICAkKGlm
ICQoZmlsdGVyIC0tam9ic2VydmVyLWF1dGg9JSwgJChNQUtFRkxBR1MpKSwsIC1qMSkpKSBc
Ci0gICAgICAgIC1kIGtlZXBkZXBmaWxlCi1uaW5qYS1jbWQtZ29hbHMgKz0gJChvciAkKE1B
S0VDTURHT0FMUyksIGFsbCkKLW5pbmphLWNtZC1nb2FscyArPSAkKGZvcmVhY2ggZywgJChN
QUtFQ01ER09BTFMpLCAkKC5uaW5qYS1nb2Fscy4kZykpCi0KLW1ha2VmaWxlLXRhcmdldHMg
Oj0gYnVpbGQubmluamEgY3RhZ3MgVEFHUyBjc2NvcGUgZGlzdCBjbGVhbgotIyAibmluamEg
LXQgdGFyZ2V0cyIgYWxzbyBsaXN0cyBhbGwgcHJlcmVxdWlzaXRlcy4gIElmIGJ1aWxkIHN5
c3RlbQotIyBmaWxlcyBhcmUgbWFya2VkIGFzIFBIT05ZLCBob3dldmVyLCBNYWtlIHdpbGwg
YWx3YXlzIHRyeSB0byBleGVjdXRlCi0jICJuaW5qYSBidWlsZC5uaW5qYSIuCi1uaW5qYS10
YXJnZXRzIDo9ICQoZmlsdGVyLW91dCAkKGJ1aWxkLWZpbGVzKSAkKG1ha2VmaWxlLXRhcmdl
dHMpLCAkKG5pbmphLXRhcmdldHMpKQotLlBIT05ZOiAkKG5pbmphLXRhcmdldHMpIHJ1bi1u
aW5qYQotJChuaW5qYS10YXJnZXRzKTogcnVuLW5pbmphCi0KLSMgVXNlICJ8IGNhdCIgdG8g
Z2l2ZSBOaW5qYSBhIG1vcmUgIm1ha2UteSIgb3V0cHV0LiAgVXNlICIrIiB0byBieXBhc3Mg
dGhlCi0jIC0tb3V0cHV0LXN5bmMgbGluZS4KLXJ1bi1uaW5qYTogY29uZmlnLWhvc3QubWFr
Ci1pZm5lcSAoJChmaWx0ZXIgJChuaW5qYS10YXJnZXRzKSwgJChuaW5qYS1jbWQtZ29hbHMp
KSwpCi0JKyQoaWYgJChNQUtFLm5xKSxAOiwkKHF1aWV0LUApJChOSU5KQSkgJChOSU5KQUZM
QUdTKSBcCi0JICAgJChzb3J0ICQoZmlsdGVyICQobmluamEtdGFyZ2V0cyksICQobmluamEt
Y21kLWdvYWxzKSkpIHwgY2F0KQotZW5kaWYKLWVuZGlmCi0KLWVsc2UgIyBjb25maWctaG9z
dC5tYWsgZG9lcyBub3QgZXhpc3QKLWlmbmVxICgkKGZpbHRlci1vdXQgJChVTkNIRUNLRURf
R09BTFMpLCQoTUFLRUNNREdPQUxTKSksJChpZiAkKE1BS0VDTURHT0FMUyksLGZhaWwpKQot
JChlcnJvciBQbGVhc2UgY2FsbCBjb25maWd1cmUgYmVmb3JlIHJ1bm5pbmcgbWFrZSkKLWVu
ZGlmCi1lbmRpZiAjIGNvbmZpZy1ob3N0Lm1hayBkb2VzIG5vdCBleGlzdAotCiBTVUJESVJf
TUFLRUZMQUdTPSQoaWYgJChWKSwsLS1uby1wcmludC1kaXJlY3RvcnkgLS1xdWlldCkKIAog
aW5jbHVkZSAkKFNSQ19QQVRIKS90ZXN0cy9NYWtlZmlsZS5pbmNsdWRlCkBAIC0zMzcsMyAr
Mjk0LDQ4IEBAIGVuZGlmCiAKIHByaW50LSU6CiAJQGVjaG8gJyQqPSQoJCopJworCisjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjCisKKyMgNC4gUnVsZXMgdG8gYnJpZGdlIHRvIG90aGVyIG1ha2VmaWxl
cworCitpZm5lcSAoJChOSU5KQSksKQorIyBGaWx0ZXIgb3V0IGxvbmcgb3B0aW9ucyB0byBh
dm9pZCBmbGFncyBsaWtlIC0tbm8tcHJpbnQtZGlyZWN0b3J5IHdoaWNoCisjIG1heSByZXN1
bHQgaW4gZmFsc2UgcG9zaXRpdmUgbWF0Y2ggZm9yIE1BS0UubgorTUFLRS5uID0gJChmaW5k
c3RyaW5nIG4sJChmaXJzdHdvcmQgJChmaWx0ZXItb3V0IC0tJSwkKE1BS0VGTEFHUykpKSkK
K01BS0UuayA9ICQoZmluZHN0cmluZyBrLCQoZmlyc3R3b3JkICQoZmlsdGVyLW91dCAtLSUs
JChNQUtFRkxBR1MpKSkpCitNQUtFLnEgPSAkKGZpbmRzdHJpbmcgcSwkKGZpcnN0d29yZCAk
KGZpbHRlci1vdXQgLS0lLCQoTUFLRUZMQUdTKSkpKQorTUFLRS5ucSA9ICQoaWYgJCh3b3Jk
IDIsICQoTUFLRS5uKSAkKE1BS0UucSkpLG5xKQorTklOSkFGTEFHUyA9IFwKKyAgICAgICAg
JChpZiAkViwtdikgXAorICAgICAgICAkKGlmICQoTUFLRS5uKSwgLW4pIFwKKyAgICAgICAg
JChpZiAkKE1BS0UuayksIC1rMCkgXAorICAgICAgICAkKGZpbHRlci1vdXQgLWosIFwKKyAg
ICAgICAgICAkKG9yICQoZmlsdGVyIC1sJSAtaiUsICQoTUFLRUZMQUdTKSksIFwKKyAgICAg
ICAgICAgICAgICQoaWYgJChmaWx0ZXIgLS1qb2JzZXJ2ZXItYXV0aD0lLCAkKE1BS0VGTEFH
UykpLCwgLWoxKSkpIFwKKyAgICAgICAgLWQga2VlcGRlcGZpbGUKK25pbmphLWNtZC1nb2Fs
cyArPSAkKG9yICQoTUFLRUNNREdPQUxTKSwgYWxsKQorbmluamEtY21kLWdvYWxzICs9ICQo
Zm9yZWFjaCBnLCAkKE1BS0VDTURHT0FMUyksICQoLm5pbmphLWdvYWxzLiRnKSkKKworbWFr
ZWZpbGUtdGFyZ2V0cyA6PSBidWlsZC5uaW5qYSBjdGFncyBUQUdTIGNzY29wZSBkaXN0IGNs
ZWFuCisjICJuaW5qYSAtdCB0YXJnZXRzIiBhbHNvIGxpc3RzIGFsbCBwcmVyZXF1aXNpdGVz
LiAgSWYgYnVpbGQgc3lzdGVtCisjIGZpbGVzIGFyZSBtYXJrZWQgYXMgUEhPTlksIGhvd2V2
ZXIsIE1ha2Ugd2lsbCBhbHdheXMgdHJ5IHRvIGV4ZWN1dGUKKyMgIm5pbmphIGJ1aWxkLm5p
bmphIi4KK25pbmphLXRhcmdldHMgOj0gJChmaWx0ZXItb3V0ICQoYnVpbGQtZmlsZXMpICQo
bWFrZWZpbGUtdGFyZ2V0cyksICQobmluamEtdGFyZ2V0cykpCisuUEhPTlk6ICQobmluamEt
dGFyZ2V0cykgcnVuLW5pbmphCiskKG5pbmphLXRhcmdldHMpOiBydW4tbmluamEKKworIyBV
c2UgInwgY2F0IiB0byBnaXZlIE5pbmphIGEgbW9yZSAibWFrZS15IiBvdXRwdXQuICBVc2Ug
IisiIHRvIGJ5cGFzcyB0aGUKKyMgLS1vdXRwdXQtc3luYyBsaW5lLgorcnVuLW5pbmphOiBj
b25maWctaG9zdC5tYWsKK2lmbmVxICgkKGZpbHRlciAkKG5pbmphLXRhcmdldHMpLCAkKG5p
bmphLWNtZC1nb2FscykpLCkKKwkrJChpZiAkKE1BS0UubnEpLEA6LCQocXVpZXQtQCkkKE5J
TkpBKSAkKE5JTkpBRkxBR1MpIFwKKwkgICAkKHNvcnQgJChmaWx0ZXIgJChuaW5qYS10YXJn
ZXRzKSwgJChuaW5qYS1jbWQtZ29hbHMpKSkgfCBjYXQpCitlbmRpZgorZW5kaWYKKworZWxz
ZSAjIGNvbmZpZy1ob3N0Lm1hayBkb2VzIG5vdCBleGlzdAoraWZuZXEgKCQoZmlsdGVyLW91
dCAkKFVOQ0hFQ0tFRF9HT0FMUyksJChNQUtFQ01ER09BTFMpKSwkKGlmICQoTUFLRUNNREdP
QUxTKSwsZmFpbCkpCiskKGVycm9yIFBsZWFzZSBjYWxsIGNvbmZpZ3VyZSBiZWZvcmUgcnVu
bmluZyBtYWtlKQorZW5kaWYKK2VuZGlmICMgY29uZmlnLWhvc3QubWFrIGRvZXMgbm90IGV4
aXN0Ci0tIAoyLjQzLjAKCg==

--------------40CsafmXQVnozvoL3aCd0RDG--

