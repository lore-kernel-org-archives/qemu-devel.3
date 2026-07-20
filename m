Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC09C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlsBA-0008O7-0a; Mon, 20 Jul 2026 13:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlsB7-0008Lb-OP
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:53:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlsB5-00047U-E4
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:53:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6d9I2785428
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 neQlMTOuqe5LOulugL6m6hFV9C4VExHW20DPGd/1Lvs=; b=JpwFW40nTMacLwly
 lqYLY6p2FAKT3GPuP/Dcwnj8SMfr6pnJ3CakAPdsbVC8guG/hMq0ZQ9KB1GVJM6d
 qCdgkBobn+BIk+coSznap/be4OV7iaNr32LzGXje+tcvc5o2Pf2ljsoV8TnmJtLJ
 gvJZ5unBsLzwmKk4lDkaf9k8pHmx63PUbp4AXtKyc1d2Lkc+t3iDMf55GRsv26u4
 j0PDbKXletiH0XXlpy7YhFpcQcWd3LIFYHERHnGS6PE4m0Gza0Xm1ZnAp40tgW2m
 LW5Jq7SQ9nV2joF5NdN8F0rZVHi6KSwgZVtAEAkc4R5cI268sSJBO/onlEKowvuQ
 dR76wg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs52b7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:53:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so2824895a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569996; x=1785174796; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=neQlMTOuqe5LOulugL6m6hFV9C4VExHW20DPGd/1Lvs=;
 b=MG+qLa8UK8rEcZGPGtbbcQUsKMXjOUKFKicIOWYW2KLSUxcCXiu9mbNBtqwvhGnK22
 M/JQxl+/rozEQF9IkPP3hFKf1Koaz3sT3Av+tq1rni1ksV2s0j9OAA3075J+0fNi7Lj3
 m9YScTaxtohecDN4wSOOivEJLmPifYKzmFc4kZazGBaJ8AgC6ji0XNpdtnFoGfRB55z8
 /5WEE33NLSA8kfa2wmfR4E2/JqhW+Ttu+eH/Ua0D98uj/rKYyDfaaOEDV/zDNjKAxQAG
 AtmSrQm5tdlZsFQHBpWYwi5MMgdNPsAb9MhXBCnmVZZ6zacNiQFGLevfcCl18TWvL7qo
 7V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569996; x=1785174796;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=neQlMTOuqe5LOulugL6m6hFV9C4VExHW20DPGd/1Lvs=;
 b=Gq6Pz+6e+BxnHDafy88tAc2lXI1tZp/DibXcjZTf9EzkyzzCpzcl1TodDTnhJ7di/q
 UNOUwp4GeX4xwCMPckLzlYBbnTH2fhC9X2xcNyfeWgL/s93xvIoVD99qcbV+704sEd86
 FCroDqa9J3ti7meMGD+pAhjAXnjVOrSux6bvgU8jTqPVhR+nFe7IDwWQM10q96L45Hsv
 SoMH3AhQJrm45VHbaq6gKISyA/vKVcwQQ6MQDAK1BTY8HNCTKkwZCLs5+rHgqVRUJXLz
 cYs9XinA4WT2yUIxyBFIHK3E7nrYKW65nopVPwhlY5QEo4h0bGxeGoM+k/PWW1um4GIu
 +xmQ==
X-Gm-Message-State: AOJu0YyhnL2FH/psr2H25HvsoGVvqeqKhZEDOrCnmZMG2J72LGDj2eN3
 mLVgiCRHmGXfIucDKyzqlXGw99nxZZt4HhwK0EPvyf08IUpkSyDreL+pqlPCawXMYSuUZ0TREYe
 ZgBzPdbf9JqW6Suf0NxqGTZLQHJQgK7meiKf+JUWkxf5hEup+Zy6RxRkLxQ==
X-Gm-Gg: AfdE7clDheASqFoq7hVmaQ+F4bo6UJSK1NIV4SU5OYuqGE4hSzC8WXhrHTJOMj1LBcw
 cb9YhJyg1cNhihf832JxkdX3B6jtkkGUmdwnvqBgzAm8gU+/Qgbp4dsJisEc+VkQwHYPVHwytUa
 UbXDuLxRXEZqYDDfTVbYVqo0Wc4h6qCEWhFTmYIsvy13j8cufEKkyHGQ+Pyp2t9PuvkMj/Pyl07
 e5hvBXa/5/orIXFQdYnud6Bak9OnMJ6zKEFESmGNl9Q0tLxA1fTuYFubRxKT04SoiUKNPvxVx51
 4DUt7KgArvZEw+cKju7jYZUbh4nmxkCW9sYJR2JjDbH2ONHrNnMbsKfLCI/okCHAXps3IxCri8j
 Dan/zJJdaG8VVytGlEWJnz6de9iRy9jvTGlB8i3nl6jyVISU5TZmE2FKLbTMormfFgBmZ
X-Received: by 2002:a05:6a21:6e97:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3c38d90d352mr20971821637.13.1784569995618; 
 Mon, 20 Jul 2026 10:53:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e97:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3c38d90d352mr20971795637.13.1784569995139; 
 Mon, 20 Jul 2026 10:53:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm40405978eec.25.2026.07.20.10.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 10:53:14 -0700 (PDT)
Message-ID: <0ed09a8f-2de8-4910-b853-cd717dbf3317@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:53:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
 <87wlupst0e.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87wlupst0e.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5NSBTYWx0ZWRfX2qdNcqAL8JoI
 NspdXK3NH1m91kxFLu84DPyJ+qnNscanBsP1viCwXXvbI5sdEo0N+ftdaVprmIwqvmVUI1o5XbM
 fGYHSR7xROZPHHXnKvNrX2N/eFgEWdU=
X-Proofpoint-GUID: GXgngAkiKQGaYAm0lf56mOoP9_gMikzp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5NSBTYWx0ZWRfX+Xsjgz5+dprE
 +zckEMmA78VFsg9erHKBJy/zOE1rxACIApxppYUoEBk57mRzOoTHkN5a0ij4spyU/LVlgsutAJs
 BVDCyhut7PHRhWC/L/Lt2yDCuAhfahFu6Yq/IpLVuacoPrngCBcyJxA76UQjydo35X3Mm/dot4O
 UR4cXRa5MBJ8+4rPaACdqRgFoF+P0QnykmycxHzaW66qk/DwpzwRUP4wl/9WcpX2XK0rtNSg/WU
 ZGNW0Bw1mjj50fOujGjE0RcfD9ar2GoWQxmBXtzXtpCOnFM7HHEka93bHAZMA3P6JKvtKJpm3qw
 NQxncW8B58Aih1BlHM7HfbIj6OzAG85qgdpBR/vXatOobNd6nKgaYTM2RZExw1jaGYU/50RUGEe
 IjKRkNU/8nKZld9pruC8dIjS2hH2cHuRudZh8mAm8M1t14Jf8DMCJI3/g/yeIwHWnZ9X+fGkWMv
 29WNzlsnjUbxUhlh8pQ==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5e608c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RU4ZrdubBn92dM0SyloA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: GXgngAkiKQGaYAm0lf56mOoP9_gMikzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200195
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

On 7/20/2026 6:14 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Those options were useful a few years ago, before containers were
>> available as an alternative for missing cross compilers. Simplify the
>> workflow by removing those options and maintaining only the container
>> based approach.
>

I was expecting some discussion around this patch, and to start it when
the comment comes. Question is "Should we provide this feature or not?".
I totally agree with you that we need to support other configurations we
have in our CI, like MacOS and compilers from homebrew.

However, instead of implementing this by keeping --cross-* options, I
would be more keen to turn 'cc' into a list, instead of fixed choice.

For instance, instead of:
# tests/tcg/aarch64/meson.build
  tcg_tests += {
    'aarch64-linux-user': {
      'cc': 'aarch64-linux-gnu-gcc',
    ...

We could have:
  tcg_tests += {
    'aarch64-linux-user': {
      'cc': ['aarch64-linux-gnu-gcc', 'some_other_variant-gcc'],
    ...

I think it's a saner choice, because one problem with --cross-* is that
it allows people and maintainers to have their "own" setup, that are not
documented anywhere. By forcing compilers to be added to dockerfiles and
paths to be explicit in arch files, we make sure the same CI is
reproducible for everyone.

A good example of that is xtensaeb, which was not in docker container
file because it could be set with cross-cc-xtensaeb.

> I'm confused here - I thought we wanted to keep local cross compilers
> and provide containers as the fallback. Otherwise it will be very
> difficult to test against newer compilers without having to rebuild the
> containers.
>

That's exactly the point. By making it hard, you force by design things
to be reproductible by anyone and documented. In this case, by forcing
the people who wants a newer compiler to provide a dockerfile patch for it.

Another example is the aarch64 test with have require a bleeding gcc-16.
It's not even installable via debian repositories at the moment, it
means the test is just always skipped in CI. So basically, it's not
testing anything out of the original developer's machine who has the
"right" setup. In this case, the right fix is not rely on latest gcc,
but add manual the needed opcode so it works on any version (see patch
included in current series).

For those reasons, I'm really much more in favor to provide a default
that works out of the box, instead of "it works on my machine with a
custom configure option".

What do you think?

> Currently the MacOS build relies on local compilers built via brew.
>

Let me know which compiler is used on MacOS for cross compiling every
arch, and I can add those to next version, so it can work out of the box.

Regards,
Pierrick

